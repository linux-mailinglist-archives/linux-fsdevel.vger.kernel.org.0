Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACD28024B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfHBVjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 17:39:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39529 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726052AbfHBVjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:39:55 -0400
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x72LdipO023483
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Aug 2019 17:39:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 33EB64202F5; Fri,  2 Aug 2019 17:39:44 -0400 (EDT)
Date:   Fri, 2 Aug 2019 17:39:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
Message-ID: <20190802213944.GE4308@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia>
 <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
 <20190801224344.GC17372@mit.edu>
 <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
 <20190802154341.GB4308@mit.edu>
 <CAK8P3a1Z+nuvBA92K2ORpdjQ+i7KrjOXCFud7fFg4n73Fqx_8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Z+nuvBA92K2ORpdjQ+i7KrjOXCFud7fFg4n73Fqx_8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:00:52PM +0200, Arnd Bergmann wrote:
> 
> I must have misunderstood what the field says. I expected that
> with s_min_extra_isize set beyond the nanosecond fields, there
> would be a guarantee that all inodes have at least as many
> extra bytes already allocated. What circumstances would lead to
> an i_extra_isize smaller than s_min_extra_isize?

When allocating new inodes, i_extra_isize is set to
s_want_extra_isize.  When modifying existing inodes, if i_extra_isize
is less than s_min_extra_isize, then we will attempt to move out
extended attribute(s) to the external xattr block.  So the
s_min_extra_isize field is not a guarantee, but rather an aspirationa
goal.  The idea is that at some point when we want to enable a new
feature, which needs more extra inode space, we can adjust
s_min_extra_size and s_want_extra_size, and the file system will
migrate things to meet these constraints.

The plan was to teach e2fsck how to fix all of the inodes to meet theh
s_min_extra_size value, but that never got implemented, and we even
then, e2fsck would have to deal with the case where tit couldn't move
the extended attribute(s) in the inode out, because there was no place
to put them.

In practice, this hasn't been that much of a limitation because we
haven't been adding that many extra inode fields.  Keep in mind that
Red Hat for example, has explicitly said they will *never* support
adding new features to an existing file system.  Their only supported
method is back up the file system, reformat it with the new file
system features, and then restore the file system.

Of course, if the backup/restore includes backing up the extended
attributes, and then restoring them, the xattr restore could fail,
unless the user also increased the inode size (e.g., from 256 bytes to
512 bytes).

Getting this right in the general case is *hard*.  Fortunately, the
corner cases really don't happen that often in practice, at least not
for pure Linux workloads.  Windows which can have arbitrarily large
security id's and ACL's might make this harder, of course --- although
ext4's EA in inode feature would make this better, modulo needing to
write more complex file system code to handle moving xattrs around.

Since the extended timestamps were one of the first extra inode fields
to be added, I strongly suggest that we not try to borrow trouble.
Solving the general case problem is *hard*.

					- Ted
