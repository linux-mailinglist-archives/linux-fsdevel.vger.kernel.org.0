Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566ED15B0CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 20:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgBLTQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 14:16:36 -0500
Received: from albireo.enyo.de ([37.24.231.21]:37258 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgBLTQg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:16:36 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1j1xUs-0004mc-FF; Wed, 12 Feb 2020 19:16:30 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1j1xTY-0004zd-0I; Wed, 12 Feb 2020 20:15:08 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rich Felker <dalias@libc.org>
Subject: Re: XFS reports lchmod failure, but changes file system contents
References: <874kvwowke.fsf@mid.deneb.enyo.de>
        <20200212161604.GP6870@magnolia>
        <20200212181128.GA31394@infradead.org>
        <20200212183718.GQ6870@magnolia>
Date:   Wed, 12 Feb 2020 20:15:08 +0100
In-Reply-To: <20200212183718.GQ6870@magnolia> (Darrick J. Wong's message of
        "Wed, 12 Feb 2020 10:37:18 -0800")
Message-ID: <87d0ajmxc3.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Darrick J. Wong:

> On Wed, Feb 12, 2020 at 10:11:28AM -0800, Christoph Hellwig wrote:
>> On Wed, Feb 12, 2020 at 08:16:04AM -0800, Darrick J. Wong wrote:
>> > xfs_setattr_nonsize calls posix_acl_chmod which returns EOPNOTSUPP
>> > because the xfs symlink inode_operations do not include a ->set_acl
>> > pointer.
>> > 
>> > I /think/ that posix_acl_chmod code exists to enforce that the file mode
>> > reflects any acl that might be set on the inode, but in this case the
>> > inode is a symbolic link.
>> > 
>> > I don't remember off the top of my head if ACLs are supposed to apply to
>> > symlinks, but what do you think about adding get_acl/set_acl pointers to
>> > xfs_symlink_inode_operations and xfs_inline_symlink_inode_operations ?
>> 
>> Symlinks don't have permissions or ACLs, so adding them makes no
>> sense.
>
> Ahh, I thought so!
>
>> xfs doesn't seem all that different from the other file systems,
>> so I suspect you'll also see it with other on-disk file systems.
>
> Yeah, I noticed that btrfs seems to exhibit the same behavior.
>
> I also noticed that ext4 actually /does/ implement [gs]et_acl for
> symlinks.

Rich Felker noticed this, which may be related:

| Further, I've found some inconsistent behavior with ext4: chmod on the
| magic symlink fails with EOPNOTSUPP as in Florian's test, but fchmod
| on the O_PATH fd succeeds and changes the symlink mode. This is with
| 5.4. Cany anyone else confirm this? Is it a problem?

It looks broken to me because fchmod (as an inode-changing operation)
is not supposed to work on O_PATH descriptors.
