Return-Path: <linux-fsdevel+bounces-5091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A13807FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 05:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C671C208BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E010A19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TdCzpH5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B0E9
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 19:13:06 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231207031304epoutp0207e8f7fcdc6c5f3fd00848c51977b41b~ebh35HOMo0527505275epoutp02T
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 03:13:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231207031304epoutp0207e8f7fcdc6c5f3fd00848c51977b41b~ebh35HOMo0527505275epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701918784;
	bh=kEnJSqJnGAr311BHfpczIC7RMy9eT9iDiK7Djt9W5z4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=TdCzpH5zy9Pkw7SwnNiYsMTAUzxOo1ciT4cfDqWMJBqIJf0SImWSrlWMLEsB8XdY1
	 9oldjTfnV2FRzGx1VJwL3hdVOvyQXEHczrdNHJjoxY0oPyWbMXOaJcR2AoKmL43Zng
	 bJD1b/R8k/NQnrvp75KZcRV5pjjZLTPXS3Z9+baI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20231207031303epcas1p3ea37ec57ce7cda8c932e418868cafc6b~ebh3fgQhG0873408734epcas1p3Y;
	Thu,  7 Dec 2023 03:13:03 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp3.localdomain
	(Postfix) with ESMTP id 4SlzqM59b4z4x9Pw; Thu,  7 Dec 2023 03:13:03 +0000
	(GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231207024038epcas1p295aeb7ba0b55f1aa981c93f3c8baf1bc~ebFjebP9I1050310503epcas1p2U;
	Thu,  7 Dec 2023 02:40:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231207024038epsmtrp1cf5a57e43b93f2a85b6eaa18e315b57c~ebFjdkZ5p1825718257epsmtrp1F;
	Thu,  7 Dec 2023 02:40:38 +0000 (GMT)
X-AuditID: b6c32a29-1fffd70000002233-52-657130a553fd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	66.88.08755.5A031756; Thu,  7 Dec 2023 11:40:38 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231207024037epsmtip23ad31677e61c79e2ec5724b1d944db75~ebFjSpnxR3077430774epsmtip2a;
	Thu,  7 Dec 2023 02:40:37 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'John Sanpe'" <sanpeqf@gmail.com>, <linkinjeon@kernel.org>,
	<willy@infradead.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>, <cpgs@samsung.com>
In-Reply-To: <20231205155837.1675052-1-sanpeqf@gmail.com>
Subject: RE: [PATCH v3] exfat/balloc: using hweight instead of internal
 logic
Date: Thu, 7 Dec 2023 11:40:37 +0900
Message-ID: <1461149300.81701918783708.JavaMail.epsvc@epcpadp4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHq4eTUneZyFxWc8t1Fi11O3NHACwHutvBVsGwzFbA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXneZQWGqweH9TBatR/YxWrw8pGkx
	cdpSZos9e0+yWBxpX8Ju8fHBbkaL3z/msDmwe+ycdZfdY/MKLY9NqzrZPPq2rGL0aJ+wk9nj
	8ya5ALYoLpuU1JzMstQifbsEroz3Z++wFdxSqJjWv5StgfGARBcjJ4eEgInEid072UFsIYHd
	jBLH28q7GDmA4lISB/dpQpjCEocPF3cxcgFVPGeUmPN9BjNIOZuArsSTGz/BbBGBKIltR/rZ
	QGxmgWyJF19/skM0dDFKbFlzECzBKWApsWjdeVaQocICvhK3joeChFkEVCRmHvnJCBLmBSpZ
	vdgcJMwrIChxcuYTFpAws4CeRNtGRojp8hLb385hhjheQWL3p6OsEBdYSbxsPMkKUSMiMbuz
	jXkCo/AsJJNmIUyahWTSLCQdCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeS
	luYOxu2rPugdYmTiYDzEKMHBrCTCm3M+P1WINyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQh
	gfTEktTs1NSC1CKYLBMHp1QDk7Xqu+9Jyuo+Bq9i7906su5wlu+vzaeX25jn6fr31mz+IyVk
	vMHPp7bD7PH3eKV6Wb7saj+TLLV5VtIn7A2fhTxoPLZk2WS1OW5lS9YnaL21vmW2dGruxICD
	tnFfPqpKF33i0//K9IijtPx50eHAl5Y+18ueLUvc8sBgW139Xxbb1+achxfcCbx2qKoy1JRd
	xKO+zr+lrMZY5PLG1FcNKc/31S6feem8B2MII5u3l45kufnCRzeKDXdP7NFMYmh8elXr2vlQ
	Y695m2bG/9c+E7tYZ73zJeZpf+195V6aayxSnmu3/8mkpyFuF44k/WxQiQ9MtvpxaNWdc59S
	JuUc3Nt68GhRBe/x4K4Oxq5VSizFGYmGWsxFxYkAzIY1TRMDAAA=
X-CMS-MailID: 20231207024038epcas1p295aeb7ba0b55f1aa981c93f3c8baf1bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20231205160306epcas1p35c3e3fc9ef2c8651eac58a8d6c194880
References: <CGME20231205160306epcas1p35c3e3fc9ef2c8651eac58a8d6c194880@epcas1p3.samsung.com>
	<20231205155837.1675052-1-sanpeqf@gmail.com>

> Replace the internal table lookup algorithm with the hweight
> library, which has instruction set acceleration capabilities.
> 
> Use it to increase the length of a single calculation of
> the exfat_find_free_bitmap function to the long type.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>

Thanks for your patch.
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/balloc.c | 48 +++++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
> index e918decb3735..69804a1b92d0 100644
> --- a/fs/exfat/balloc.c
> +++ b/fs/exfat/balloc.c
> @@ -5,11 +5,22 @@
> 
>  #include <linux/blkdev.h>
>  #include <linux/slab.h>
> +#include <linux/bitmap.h>
>  #include <linux/buffer_head.h>
> 
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> 
> +#if BITS_PER_LONG == 32
> +# define __le_long __le32
> +# define lel_to_cpu(A) le32_to_cpu(A)
> +#elif BITS_PER_LONG == 64
> +# define __le_long __le64
> +# define lel_to_cpu(A) le64_to_cpu(A)
> +#else
> +# error "BITS_PER_LONG not 32 or 64"
> +#endif
> +
>  static const unsigned char free_bit[] = {
>  	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*  0 ~
> 19*/
>  	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3,/* 20 ~
> 39*/
> @@ -26,22 +37,6 @@ static const unsigned char free_bit[] = {
>  	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0                /*240 ~
> 254*/
>  };
> 
> -static const unsigned char used_bit[] = {
> -	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3,/*  0 ~
> 19*/
> -	2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4,/* 20 ~
> 39*/
> -	2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5,/* 40 ~
> 59*/
> -	4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,/* 60 ~
> 79*/
> -	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4,/* 80 ~
> 99*/
> -	3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6,/*100 ~
> 119*/
> -	4, 5, 5, 6, 5, 6, 6, 7, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4,/*120 ~
> 139*/
> -	3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,/*140 ~
> 159*/
> -	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5,/*160 ~
> 179*/
> -	4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 2, 3, 3, 4, 3, 4, 4, 5,/*180 ~
> 199*/
> -	3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6,/*200 ~
> 219*/
> -	5, 6, 6, 7, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,/*220 ~
> 239*/
> -	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8             /*240 ~
> 255*/
> -};
> -
>  /*
>   *  Allocation Bitmap Management Functions
>   */
> @@ -244,25 +239,24 @@ int exfat_count_used_clusters(struct super_block
*sb,
> unsigned int *ret_count)
>  	unsigned int count = 0;
>  	unsigned int i, map_i = 0, map_b = 0;
>  	unsigned int total_clus = EXFAT_DATA_CLUSTER_COUNT(sbi);
> -	unsigned int last_mask = total_clus & BITS_PER_BYTE_MASK;
> -	unsigned char clu_bits;
> -	const unsigned char last_bit_mask[] = {0, 0b00000001, 0b00000011,
> -		0b00000111, 0b00001111, 0b00011111, 0b00111111, 0b01111111};
> +	unsigned int last_mask = total_clus & (BITS_PER_LONG - 1);
> +	unsigned long *bitmap, clu_bits;
> 
>  	total_clus &= ~last_mask;
> -	for (i = 0; i < total_clus; i += BITS_PER_BYTE) {
> -		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
> -		count += used_bit[clu_bits];
> -		if (++map_b >= (unsigned int)sb->s_blocksize) {
> +	for (i = 0; i < total_clus; i += BITS_PER_LONG) {
> +		bitmap = (void *)(sbi->vol_amap[map_i]->b_data + map_b);
> +		count += hweight_long(*bitmap);
> +		map_b += sizeof(long);
> +		if (map_b >= (unsigned int)sb->s_blocksize) {
>  			map_i++;
>  			map_b = 0;
>  		}
>  	}
> 
>  	if (last_mask) {
> -		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
> -		clu_bits &= last_bit_mask[last_mask];
> -		count += used_bit[clu_bits];
> +		bitmap = (void *)(sbi->vol_amap[map_i]->b_data + map_b);
> +		clu_bits = lel_to_cpu(*(__le_long *)bitmap);
> +		count += hweight_long(clu_bits &
> BITMAP_LAST_WORD_MASK(last_mask));
>  	}
> 
>  	*ret_count = count;
> --
> 2.43.0




