Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F60FD20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfD3Pp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfD3Pp0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47528AD94;
        Tue, 30 Apr 2019 15:45:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CC4DDA88B; Tue, 30 Apr 2019 17:46:25 +0200 (CEST)
Date:   Tue, 30 Apr 2019 17:46:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 0/8] vfs: make immutable files actually immutable
Message-ID: <20190430154622.GA20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
References: <155552786671.20411.6442426840435740050.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155552786671.20411.6442426840435740050.stgit@magnolia>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:04:26PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> The chattr(1) manpage has this to say about the immutable bit that
> system administrators can set on files:
> 
> "A file with the 'i' attribute cannot be modified: it cannot be deleted
> or renamed, no link can be created to this file, most of the file's
> metadata can not be modified, and the file can not be opened in write
> mode."
> 
> Given the clause about how the file 'cannot be modified', it is
> surprising that programs holding writable file descriptors can continue
> to write to and truncate files after the immutable flag has been set,
> but they cannot call other things such as utimes, fallocate, unlink,
> link, setxattr, or reflink.
> 
> Since the immutable flag is only settable by administrators, resolve
> this inconsistent behavior in favor of the documented behavior -- once
> the flag is set, the file cannot be modified, period.

The manual page leaves the case undefined, though the word 'modified'
can be interpreted in the same sense as 'mtime' ie. modifying the file
data. The enumerated file operations that don't work on an immutable
file suggest that it's more like the 'ctime',  ie. (state) changes are
forbidden.

Tthe patchset makes some sense, but it changes the semantics a bit. From
'not changed but still modified' to 'neither changed nor modified'. It
starts to sound like a word game, but I think both are often used
interchangeably in the language. See the changelog of 1/8 where you used
them in the other meaning regarding ctime and mtime.

I personally doubt there's a real use of the undefined case, though
something artificial like 'a process opens a fd, sets up file in a very
specific way, sets immutable and hands the fd to an unprivileged
process' can be made up. The overhead of the new checks seems to be
small so performance is not the concern here.

Overall, I don't see a strong reason for either semantics. As long as
it's documented possibly with some of the corner cases described in more
detail, fine.
