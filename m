Return-Path: <linux-fsdevel+bounces-42385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA0A415AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 07:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D96B188B25E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C291FFC63;
	Mon, 24 Feb 2025 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DCUxkcYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166615886C;
	Mon, 24 Feb 2025 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379710; cv=none; b=EMA1GAlTCZuZyO15xUbCs4OdWXRN1LgtqkgYCHhgUpUnujE6i2+JfXAzNtiwJxUghJTpAr2ss7j3sxpyUGELtGfZ18AbCxQ8KdeIEh3zHSLJMk0EGmglXwjgxyZQ8B5/iVUXSoZK/uWeLF3d9RLGRkzkS82kibzDZdwZy2YD0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379710; c=relaxed/simple;
	bh=9KZgxs+1o6vKrEnPwrYoJj3riTTKoKtEdF5UGkLRMHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU99IDutF1tK2lKIIXbVrlO4pwXll6MKzHDKXsY9N4eqYqErt+uhI8pKcBl/U4cof0IUUdiGoWsKMR203JE0JMdTx/i6+EIAcjnPlSkabTvVPyRE2NO2p7MYABxfN7QeqkpfZ/gS3iC+bIJ6seqnB6A/HsTjURsdN48HIfM0PqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DCUxkcYe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2D9A2020204;
	Mon, 24 Feb 2025 06:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/s+Bcdw5RZudblgGKPzY06GE+qI04O
	/42P1AlZVTUgg=; b=DCUxkcYeLRl84AxXG7hnIHwhdwshoo+4RuZ6G/d5iLWern
	YQKqeMWVD2msNpiKHtTffnyucLzNcCk9h1qnyNp+BQH537tFBfy9mm6BOQ6kChDF
	Tt6NiqHQ95eRbESUTqVEwHyJ2T4eYnDmyDf59CBwrCKTMyD84Hzg+omFfReiDEMz
	L4i2mXz5Az5rA1N+p9qFS75msC7uTCZdQkGBjWFwrwf7P2E3iTJyOJilgT+GvZX/
	eGPVlBxkQ4ouXT3+NEJjIYlwiWHpFH90bRdpLMK24+Q4kTulpQKuA5hgv9KniS2N
	vqzNbzOrcYH72vAWvcbs50we3ODP0Jqw6PRjQnsg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450cta1ec4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 06:48:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2X9dv012465;
	Mon, 24 Feb 2025 06:48:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwse2j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 06:48:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51O6mDNw11010484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 06:48:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F34B2004B;
	Mon, 24 Feb 2025 06:48:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7179320043;
	Mon, 24 Feb 2025 06:48:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Feb 2025 06:48:11 +0000 (GMT)
Date: Mon, 24 Feb 2025 12:18:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: linux-ext4@vger.kernel.org, jack@suse.com, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangerkun@huawei.com
Subject: Re: [PATCH] ext4: Modify the comment about mb_optimize_scan
Message-ID: <Z7wWKFrYfdJwX2JA@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250224012005.689549-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224012005.689549-1-wozizhi@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mk52NVO6j5ghDtBd05GOgoSNkD65teSr
X-Proofpoint-ORIG-GUID: mk52NVO6j5ghDtBd05GOgoSNkD65teSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=729
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240042

On Mon, Feb 24, 2025 at 09:20:05AM +0800, Zizhi Wo wrote:
> Commit 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning") introduces
> the sysfs control interface "mb_max_linear_groups" to address the problem
> that rotational devices performance degrades when the "mb_optimize_scan"
> feature is enabled, which may result in distant block group allocation.
> 
> However, the name of the interface was incorrect in the comment to the
> ext4/mballoc.c file, and this patch fixes it, without further changes.

Looks good Zizhi, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

IIRC the documentation above mballoc is a bit outdated and it might
be a good idea to see if we can make more improvements there. Maybe
something worth exploring

Regards,
ojaswin
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  fs/ext4/mballoc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b25a27c86696..68b54afc78c7 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -187,7 +187,7 @@
>   * /sys/fs/ext4/<partition>/mb_min_to_scan
>   * /sys/fs/ext4/<partition>/mb_max_to_scan
>   * /sys/fs/ext4/<partition>/mb_order2_req
> - * /sys/fs/ext4/<partition>/mb_linear_limit
> + * /sys/fs/ext4/<partition>/mb_max_linear_groups
>   *
>   * The regular allocator uses buddy scan only if the request len is power of
>   * 2 blocks and the order of allocation is >= sbi->s_mb_order2_reqs. The
> @@ -209,7 +209,7 @@
>   * get traversed linearly. That may result in subsequent allocations being not
>   * close to each other. And so, the underlying device may get filled up in a
>   * non-linear fashion. While that may not matter on non-rotational devices, for
> - * rotational devices that may result in higher seek times. "mb_linear_limit"
> + * rotational devices that may result in higher seek times. "mb_max_linear_groups"
>   * tells mballoc how many groups mballoc should search linearly before
>   * performing consulting above data structures for more efficient lookups. For
>   * non rotational devices, this value defaults to 0 and for rotational devices
> -- 
> 2.39.2
> 

