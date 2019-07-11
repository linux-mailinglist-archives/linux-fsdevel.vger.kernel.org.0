Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0666865A2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfGKPMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 11:12:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728691AbfGKPMm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:12:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B00F1AD36;
        Thu, 11 Jul 2019 15:12:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 560501E43CB; Thu, 11 Jul 2019 17:04:36 +0200 (CEST)
Date:   Thu, 11 Jul 2019 17:04:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     " Steven J. Magnani " <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] udf: support 2048-byte spacing of VRS descriptors
 on 4K media
Message-ID: <20190711150436.GA2449@quack2.suse.cz>
References: <20190711133852.16887-1-steve@digidescorp.com>
 <20190711133852.16887-2-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711133852.16887-2-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-07-19 08:38:52,  Steven J. Magnani  wrote:
> Some UDF creators (specifically Microsoft, but perhaps others) mishandle
> the ECMA-167 corner case that requires descriptors within a Volume
> Recognition Sequence to be placed at 4096-byte intervals on media where
> the block size is 4K. Instead, the descriptors are placed at the 2048-
> byte interval mandated for media with smaller blocks. This nonconformity
> currently prevents Linux from recognizing the filesystem as UDF.
> 
> Modify the driver to tolerate a misformatted VRS on 4K media.
> 
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

Thanks for the patches! I've added them to my tree and somewhat simplified
the logic since we don't really care about nsr 2 vs 3 or whether we
actually saw BEA or not. Everything seems to work fine for me but I'd
appreciate if you could doublecheck - the result is pushed out to

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next

Thanks!

								Honza
> 
> --- a/fs/udf/super.c	2019-07-10 20:55:33.334359446 -0500
> +++ b/fs/udf/super.c	2019-07-10 21:20:58.138382326 -0500
> @@ -741,6 +741,7 @@ static int udf_check_vsd(struct super_bl
>  	int sectorsize;
>  	struct buffer_head *bh = NULL;
>  	int nsr = 0;
> +	int quirk_nsr = 0;
>  	struct udf_sb_info *sbi;
>  
>  	sbi = UDF_SB(sb);
> @@ -780,11 +781,27 @@ static int udf_check_vsd(struct super_bl
>  		if (vsd_id > nsr)
>  			nsr = vsd_id;
>  
> +		/* Special handling for improperly formatted VRS (e.g., Win10)
> +		 * where components are separated by 2048 bytes
> +		 * even though sectors are 4K
> +		 */
> +		if ((sb->s_blocksize == 4096) && (quirk_nsr < 2)) {
> +			vsd_id = identify_vsd(vsd + 1);
> +			if ((nsr == 1) || (quirk_nsr == 1)) {
> +				/* BEA01 has been seen, allow quirk NSR */
> +				if (vsd_id > quirk_nsr)
> +					quirk_nsr = vsd_id;
> +			} else if (vsd_id > 3)
> +				quirk_nsr = vsd_id;  /* 0 -> 255 */
> +		}
> +
>  		brelse(bh);
>  	}
>  
>  	if ((nsr >= 2) && (nsr <= 3))
>  		return nsr;
> +	else if ((quirk_nsr >= 2) && (quirk_nsr <= 3))
> +		return quirk_nsr;
>  	else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) ==
>  			VSD_FIRST_SECTOR_OFFSET)
>  		return -1;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
