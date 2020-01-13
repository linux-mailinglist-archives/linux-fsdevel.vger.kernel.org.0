Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8008139041
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 12:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgAMLkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 06:40:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:42826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgAMLko (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1EDC7AD55;
        Mon, 13 Jan 2020 11:40:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BCDDD1E0D0E; Mon, 13 Jan 2020 12:40:42 +0100 (CET)
Date:   Mon, 13 Jan 2020 12:40:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] udf: Disallow R/W mode for disk with Metadata partition
Message-ID: <20200113114042.GC23642@quack2.suse.cz>
References: <20200112144959.28104-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200112144959.28104-1-pali.rohar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 12-01-20 15:49:59, Pali Rohár wrote:
> Currently we do not support writing to UDF disks with Metadata partition.
> There is already check that disks with declared minimal write revision to
> UDF 2.50 or higher are mounted only in R/O mode but this does not cover
> situation when minimal write revision is set incorrectly (e.g. to 2.01).
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>

Yeah, right. Better be cautious. I've added the patch to my tree.

								Honza

> ---
>  fs/udf/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 8c28e93e9..3b7073c2f 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1063,7 +1063,8 @@ static int check_partition_desc(struct super_block *sb,
>  		goto force_ro;
>  
>  	if (map->s_partition_type == UDF_VIRTUAL_MAP15 ||
> -	    map->s_partition_type == UDF_VIRTUAL_MAP20)
> +	    map->s_partition_type == UDF_VIRTUAL_MAP20 ||
> +	    map->s_partition_type == UDF_METADATA_MAP25)
>  		goto force_ro;
>  
>  	return 0;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
