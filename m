Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1713903E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 12:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAMLja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 06:39:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:42248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgAMLja (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:39:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 804C5ABB1;
        Mon, 13 Jan 2020 11:39:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 158C21E0D0E; Mon, 13 Jan 2020 12:39:28 +0100 (CET)
Date:   Mon, 13 Jan 2020 12:39:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] udf: Fix meaning of ENTITYID_FLAGS_* macros to be really
 bitwise-or flags
Message-ID: <20200113113928.GB23642@quack2.suse.cz>
References: <20200112221353.29711-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200112221353.29711-1-pali.rohar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 12-01-20 23:13:53, Pali Rohár wrote:
> Currently ENTITYID_FLAGS_* macros definitions are written as hex numbers
> but their meaning is not bitwise-or flags. But rather bit position. This is
> unusual and could be misleading. So change meaning of ENTITYID_FLAGS_*
> macros definitions to be really bitwise-or flags.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>

Thanks. I agree. I've added this patch to my tree.

								Honza

> ---
>  fs/udf/ecma_167.h | 4 ++--
>  fs/udf/super.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index f9ee412fe..3fd85464a 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -95,8 +95,8 @@ struct regid {
>  } __packed;
>  
>  /* Flags (ECMA 167r3 1/7.4.1) */
> -#define ENTITYID_FLAGS_DIRTY		0x00
> -#define ENTITYID_FLAGS_PROTECTED	0x01
> +#define ENTITYID_FLAGS_DIRTY		0x01
> +#define ENTITYID_FLAGS_PROTECTED	0x02
>  
>  /* Volume Structure Descriptor (ECMA 167r3 2/9.1) */
>  #define VSD_STD_ID_LEN			5
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 0dad63f88..7e6ec9fa0 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -773,7 +773,7 @@ static int udf_verify_domain_identifier(struct super_block *sb,
>  		udf_warn(sb, "Not OSTA UDF compliant %s descriptor.\n", dname);
>  		goto force_ro;
>  	}
> -	if (ident->flags & (1 << ENTITYID_FLAGS_DIRTY)) {
> +	if (ident->flags & ENTITYID_FLAGS_DIRTY) {
>  		udf_warn(sb, "Possibly not OSTA UDF compliant %s descriptor.\n",
>  			 dname);
>  		goto force_ro;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
