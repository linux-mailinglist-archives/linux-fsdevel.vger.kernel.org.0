Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7B114397
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 16:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfLEPbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 10:31:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:47264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfLEPbu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:31:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04F89AFAE;
        Thu,  5 Dec 2019 15:31:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F9B6DA733; Thu,  5 Dec 2019 16:31:42 +0100 (CET)
Date:   Thu, 5 Dec 2019 16:31:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 06/28] btrfs: disallow NODATACOW in HMZONED mode
Message-ID: <20191205153142.GU2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-7-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204081735.852438-7-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:17:13PM +0900, Naohiro Aota wrote:
> NODATACOW implies overwriting the file data on a device, which is
> impossible in sequential required zones. Disable NODATACOW globally with
> mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/hmzoned.c | 6 ++++++
>  fs/btrfs/ioctl.c   | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
> index 1c015ed050fc..e890d2ab8cd9 100644
> --- a/fs/btrfs/hmzoned.c
> +++ b/fs/btrfs/hmzoned.c
> @@ -269,5 +269,11 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
>  		return -EINVAL;
>  	}
>  
> +	if (btrfs_test_opt(info, NODATACOW)) {
> +		btrfs_err(info,
> +		  "cannot enable nodatacow with HMZONED mode");
> +		return -EINVAL;

That's maybe -EOPNOTSUPP, the error message explains what's wrong and we
can leave EINVAL for the really invalid arguments. I'll need to look if
this is consistent with the rest of error code returned from mount
though.
