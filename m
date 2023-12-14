Return-Path: <linux-fsdevel+bounces-6031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1169812455
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 02:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5161C214F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 01:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE581E;
	Thu, 14 Dec 2023 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSq1uGLr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB9642;
	Thu, 14 Dec 2023 01:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6B2C433C8;
	Thu, 14 Dec 2023 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702516284;
	bh=XwoFjsJDwQ9a2+DWM4rjeegVkzh/lxFGbWD3rYfyGcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSq1uGLrFIRUTnVT3AS20PIwVXDWLgO8ozWsfsDZWaPJjk8n3u8l/eWwAv50O0EMd
	 u8lxxL9Y4sSkGifdgqH3/YI4+EmFlAIdAVSI/mgcQl9karZZTwtudxVBlp5VpjaMxu
	 SjagbjSDOcAhlUiBn/nkeM13SGJb/wwTwxfblLge9zGFRonPJ2SBordG8cRqdYFNpI
	 3vAf2yXumJqwsUhu2Qb2L2P3bTvd2tZKU5prXoqDMiIFx8b91cZLKRNAPDnqn2anJK
	 4lsRsLROKyVu60uG6cdSuihgOfEcCuT+ZirEHhGzdijeXu7TpvPoxov1wnMfqIDbmI
	 CMP4+mM/C2Qxg==
Date: Wed, 13 Dec 2023 17:11:21 -0800
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
	anuj1072538@gmail.com, gost.dev@samsung.com, mcgrof@kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v18 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <ZXpWOaxCRoF7dFis@kbusch-mbp>
References: <20231206100253.13100-1-joshi.k@samsung.com>
 <CGME20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7@epcas5p2.samsung.com>
 <20231206100253.13100-3-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206100253.13100-3-joshi.k@samsung.com>

On Wed, Dec 06, 2023 at 03:32:34PM +0530, Kanchan Joshi wrote:
>  static inline bool bio_has_data(struct bio *bio)
>  {
> -	if (bio &&
> -	    bio->bi_iter.bi_size &&
> -	    bio_op(bio) != REQ_OP_DISCARD &&
> -	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
> +	if (bio && (bio_op(bio) == REQ_OP_READ || bio_op(bio) == REQ_OP_WRITE))
>  		return true;

There are other ops besides READ and WRITE that have data, but this is
might be fine by the fact that other ops with data currently don't call
this function.

> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 7c2316c91cbd..bd821eaa7a02 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -393,6 +393,10 @@ enum req_op {
>  	/* reset all the zone present on the device */
>  	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
>  
> +	/* copy offload dst and src operation */
> +	REQ_OP_COPY_SRC		= (__force blk_opf_t)19,

Should this be an even numbered OP? The odd ones are for data
WRITEs.

> +	REQ_OP_COPY_DST		= (__force blk_opf_t)21,

