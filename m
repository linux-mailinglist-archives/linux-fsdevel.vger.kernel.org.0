Return-Path: <linux-fsdevel+bounces-60750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A58B51340
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 11:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BD93BEDE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2303148AB;
	Wed, 10 Sep 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jN5MqZxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FA25FA0F;
	Wed, 10 Sep 2025 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497976; cv=none; b=ksdFGbc4JvELJyGlu+tC4YhhKUXe4rEparVWZQC4dw4xk0Jm2Lohff8dIkTmDQlxgDGp6qy/EuQf4yh+4IDSazKTiQbkOmTs0DfORG3zM3CP8PmDCq1o3/ZNNofZJh+8Gjk7dYTma5KW/Xh16JfRWuo8jtXG/jH3fF9Qx1/vPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497976; c=relaxed/simple;
	bh=xDOQ3tKoBu/sOOZhtBH6Ba+B8q0xe1ULISL6Nmm+Zng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHF+nxGIHNZcHKb6lGQcVeC0AguPKbpfDoi5eJ3tcD/9XmrprzcPGG4+Hz98YPYI8Q18ZXP1vxXPA/1gQ7H8QDlLrVfo2GHiK2pHlPswzoUo3MSgPs62qzE8Gjw1jVkIlt7fN7y45hGWsIztgCr3s46H/Pvh7dUNxdzlKQ+4zw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jN5MqZxb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A5QUs6026934;
	Wed, 10 Sep 2025 09:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZRs0Fj2qKmba2qHVh+jE/iOhDv6xRT
	1zMWYuNLPCwWA=; b=jN5MqZxbKiuhjaMpH7p8CsLplmX5OHdSQzNnjZjLodJdsU
	Ro+h8J7PSYWO3jw7ZZcqM/pItbRpkzvdO0u5SS2qbeLnHi8L9Hk9j1ABvvMc7iV8
	w/WvZFZyDA255TmgwlVXcQ9XN4evfsF69Hv/jWP8R7OlCuL65y4Kc/pL9lcSIHAX
	+5oredvfa6IV6/Dx8fX1usBaKLtn7j/u+T50UhSweQeT2QgMGfn9FMsUu7+MbMBJ
	6QC/75axPsQ41AeI8n7GejE9KVoT6ZJnnKmIpyYY8f86fmU8Shyctml3zJRlTWp0
	3QkJqTwR1PwUWYHLGJNR6nSg/ajmDiGXeusXPaqg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmww903-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 09:52:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A6OrxF010613;
	Wed, 10 Sep 2025 09:52:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smyrh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 09:52:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58A9qd3t57082290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 09:52:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5951F2004B;
	Wed, 10 Sep 2025 09:52:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31D9F20043;
	Wed, 10 Sep 2025 09:52:39 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Sep 2025 09:52:39 +0000 (GMT)
Date: Wed, 10 Sep 2025 11:52:37 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: Fix unused variable warning in rd_load_image()
 on s390
Message-ID: <20250910095237.9573B41-hca@linux.ibm.com>
References: <20250908121303.180886-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908121303.180886-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hiqv4XYERw89owVYJ6wjlAIsrRF7pICX
X-Proofpoint-ORIG-GUID: Hiqv4XYERw89owVYJ6wjlAIsrRF7pICX
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c14a6a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=PkAY6qTL1cK_7XifSX8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX5WLtJubH4tUx
 ejMTW6sUHUNToKQGvvMwY6VDjbmnjY3esOFu6pIAtTNOX9d1CmYI9g8jE6D8AXmocHpWcK3JtF+
 Lig1PemT+4Y+BDzgN3tswljf/HvLLMWqnYoM9LrTgjRRtrMrJE1mjip8KGspxn5Vc7yBgvuJpJX
 ySXjEMHXwLkKx2Ow5bheH34Mxsyf31D+wm7kSKjzKKWhmvVFnu6sxTXYhp0EbS55y+fuiAZGZvc
 SKldRGDrhh9+ogu+u3kDyv+C8gGuzwP16bJIdbwU9S3BB/7upf/xAZ/eOtR8F5lV4IBvvDnhI/y
 CrQ8WelSShRkW9CCqaaoEDbAbQoG8tTEQIKbiye7Atn9c1f272aC7D+4x+qlIv91DKQDbVcn//y
 siN7OeuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Mon, Sep 08, 2025 at 02:13:04PM +0200, Thorsten Blum wrote:
> The local variable 'rotate' is not used on s390, and building the kernel
> with W=1 generates the following warning:
> 
> init/do_mounts_rd.c:192:17: warning: variable 'rotate' set but not used [-Wunused-but-set-variable]
>   192 |         unsigned short rotate = 0;
>       |                        ^
> 1 warning generated.
> 
> Fix this by declaring and using 'rotate' only when CONFIG_S390 is not
> defined.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  init/do_mounts_rd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index ac021ae6e6fa..cbc4c496cb5f 100644
> --- a/init/do_mounts_rd.c
> +++ b/init/do_mounts_rd.c
> @@ -189,9 +189,9 @@ int __init rd_load_image(char *from)
>  	unsigned long rd_blocks, devblocks;
>  	int nblocks, i;
>  	char *buf = NULL;
> -	unsigned short rotate = 0;
>  	decompress_fn decompressor = NULL;
>  #if !defined(CONFIG_S390)
> +	unsigned short rotate = 0;
>  	char rotator[4] = { '|' , '/' , '-' , '\\' };
>  #endif
>  
> @@ -249,7 +249,9 @@ int __init rd_load_image(char *from)
>  	for (i = 0; i < nblocks; i++) {
>  		if (i && (i % devblocks == 0)) {
>  			pr_cont("done disk #1.\n");
> +#if !defined(CONFIG_S390)
>  			rotate = 0;
> +#endif

Instead of adding even more ifdefs, wouldn't it make more sense to get
rid of them and leave it up to the compiler to optimize unused stuff
away? Something like this instead:

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..0cc9caf2411d 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -191,9 +191,7 @@ int __init rd_load_image(char *from)
 	char *buf = NULL;
 	unsigned short rotate = 0;
 	decompress_fn decompressor = NULL;
-#if !defined(CONFIG_S390)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
-#endif
 
 	out_file = filp_open("/dev/ram", O_RDWR, 0);
 	if (IS_ERR(out_file))
@@ -255,12 +253,11 @@ int __init rd_load_image(char *from)
 		}
 		kernel_read(in_file, buf, BLOCK_SIZE, &in_pos);
 		kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
-#if !defined(CONFIG_S390)
 		if (!(i % 16)) {
-			pr_cont("%c\b", rotator[rotate & 0x3]);
+			if (!IS_ENABLED(CONFIG_S390))
+				pr_cont("%c\b", rotator[rotate & 0x3]);
 			rotate++;
 		}
-#endif
 	}
 	pr_cont("done.\n");
 

