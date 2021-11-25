Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7115F45D223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 01:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbhKYAiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 19:38:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40506 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346686AbhKYAgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 19:36:00 -0500
Received: from callcc.thunk.org ([64.129.1.15])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AP0WWkq015823
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 19:32:34 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4C07E4200F8; Wed, 24 Nov 2021 19:32:31 -0500 (EST)
Date:   Wed, 24 Nov 2021 19:32:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ7Zn8pEp9D/oqS1@mit.edu>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <163772381628.1891.9102201563412921921@noble.neil.brown.name>
 <20211123194833.4711add38351d561f8a1ae3e@linux-foundation.org>
 <163773141164.1891.1440920123016055540@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163773141164.1891.1440920123016055540@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:23:31PM +1100, NeilBrown wrote:
> 
> It would get particularly painful if some system call started returned
> -ENOMEM, which had never returned that before.  I note that ext4 uses
> __GFP_NOFAIL when handling truncate.  I don't think user-space would be
> happy with ENOMEM from truncate (or fallocate(PUNHC_HOLE)), though a
> recent commit which adds it focuses more on wanting to avoid the need
> for fsck.

If the inode is in use (via an open file descriptor) when it is
unlocked, we can't actually do the truncate until the inode is
evicted, and at that point, there is no user space to return to.  For
that reason, the evict_inode() method is not *allowed* to fail.  So
this is why we need to use GFP_NOFAIL or an open-coded retry loop.
The alternative would be to mark the file system corrupt, and then
either remount the file system, panic the system and reboot, or leave
the file system corrupted ("don't worry, be happy").  I considered
GFP_NOFAIL to be the lesser of the evils.  :-)

If the VFS allowed evict_inode() to fail, all it could do is to put
the inode back on the list of inodes to be later evicted --- which is
to say, we would have to add a lot of complexity to effectively add a
gigantic retry loop.  

Granted, we wouldn't need to be holding any locks in between retries,
so perhaps it'a better than adding a retry loop deep in the guts of
the ext4 truncate codepath.  But then we would need to worry about
userspace getting ENOMEM for system calls which historically, users
have traditionally never failing.  I suppose we could also solve this
problem by adding retry logic in the top-level VFS truncate codepath,
so instead of returning ENOMEM, we just retry the truncate(2) system
call and hope that we have enough memory to succeed this time.

After all, can the userspace do if truncate() fails with ENOMEM?  It
can fail the userspace program, which in the case of a long-running
daemon such as mysqld, is basically the userspace equivalent of "panic
and reboot", or it can retry truncate(2) syste call at the userspace
level.

Are we detecting a pattern here?  There will always be cases where the
choice is "panic" or "retry".

							- Ted
