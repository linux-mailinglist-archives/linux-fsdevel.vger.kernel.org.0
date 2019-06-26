Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209C056125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 06:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfFZEMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 00:12:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44482 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfFZEMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:12:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfzHR-0000Pn-Ag; Wed, 26 Jun 2019 04:11:33 +0000
Date:   Wed, 26 Jun 2019 05:11:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        shaggy@kernel.org, ard.biesheuvel@linaro.org, josef@toxicpanda.com,
        hch@infradead.org, clm@fb.com, adilger.kernel@dilger.ca,
        jk@ozlabs.org, jack@suse.com, dsterba@suse.com, jaegeuk@kernel.org,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] vfs: create a generic checking function for
 FS_IOC_FSSETXATTR
Message-ID: <20190626041133.GB32272@ZenIV.linux.org.uk>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia>
 <156151633829.2283456.834142172527987802.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156151633829.2283456.834142172527987802.stgit@magnolia>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:32:18PM -0700, Darrick J. Wong wrote:
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -373,10 +373,9 @@ static int check_xflags(unsigned int flags)
>  static int btrfs_ioctl_fsgetxattr(struct file *file, void __user *arg)
>  {
>  	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
> -	struct fsxattr fa;
> -
> -	memset(&fa, 0, sizeof(fa));
> -	fa.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags);
> +	struct fsxattr fa = {
> +		.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags),
> +	};

Umm...  Sure, there's no padding, but still - you are going to copy that thing
to userland...  How about

static inline void simple_fill_fsxattr(struct fsxattr *fa, unsigned xflags)
{
	memset(fa, 0, sizeof(*fa));
	fa->fsx_xflags = xflags;
}

and let the compiler optimize the crap out?
