Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB65828D162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgJMPkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 11:40:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgJMPkq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:40:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B717B2E6;
        Tue, 13 Oct 2020 15:40:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BCDEBDA7C3; Tue, 13 Oct 2020 17:39:17 +0200 (CEST)
Date:   Tue, 13 Oct 2020 17:39:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v8 07/41] btrfs: disallow NODATACOW in ZONED mode
Message-ID: <20201013153917.GC6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <c5f6be584aea6de94506d91093be11c6c22e6088.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f6be584aea6de94506d91093be11c6c22e6088.1601574234.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:36:14AM +0900, Naohiro Aota wrote:
> NODATACOW implies overwriting the file data on a device, which is
> impossible in sequential required zones. Disable NODATACOW globally with
> mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/ioctl.c | 3 +++
>  fs/btrfs/zoned.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index ab408a23ba32..5d592da4e2ff 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -91,6 +91,9 @@ struct btrfs_ioctl_send_args_32 {
>  static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
>  		unsigned int flags)
>  {
> +	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), ZONED))
> +		flags &= ~FS_NOCOW_FL;
> +

This can't be inside the function, the 'type' here is for inode that
does not know anything about zoned mode. The right place is after
check_fsflags in btrfs_ioctl_setflags in a helper like:

	ret = check_fsflags_compatible(fs_info, flags));
	if (ret)
		goto out_unlock;

and check_fsflags_compatible checks for zoned mode and NOCOW and returns
-EPERM, not silently unmasking it.

>  	if (S_ISDIR(inode->i_mode))
>  		return flags;
>  	else if (S_ISREG(inode->i_mode))
