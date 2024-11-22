Return-Path: <linux-fsdevel+bounces-35549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6999D5B22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 09:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD25B224F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2635718B462;
	Fri, 22 Nov 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O3CLSVmz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B65165EE6;
	Fri, 22 Nov 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264831; cv=none; b=Hz1h1u66XIj83BCj6egET272XKzcnCS32ban1QKrzt6MLoNu9DpjdOHsIFsXLcLAF0O2DHxkYAN58IKf21toOjZmdjfat3Q7UvyCDWWoXDVOSnWFsDe9JJXLYvRbOIQA2hLwpUMWySfzuOvsZLXawHVrzSRhh3po18IMWQH/OlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264831; c=relaxed/simple;
	bh=NuIAn4WN9tuE3Z3+e4/LD9vBt0vhTMGMlYSG0sjGT6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lovGkoGvILFUNpANtoUQwnhK0g51xkiD6Rnb0oaNcLNan8lQ8zqFuuP9j5Tzff5uAa7ihcEq63eFVVCpgPS9B9BGmPGr1WCMLfce6I5f8YLVPJZAJSYzdyps7KZQQm15Qgx19g0yIfAb1Vi2yxCwF5nZT2d3OtwnQP3el2rZI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O3CLSVmz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1qP5U006973;
	Fri, 22 Nov 2024 08:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SaePHCRKhD41eZpCkKUbZZLRBivcQk
	LiOz/uWyQXTGQ=; b=O3CLSVmz1Ekch1T9i3lpmR0eDkHoWv+tTb1tMfy7NjXRyR
	FfqkcPPpOkGMpQ18kbWSPv6dB6pLIcV3Y1g+anyUeJeUYz2whK0fys6KDtX+QjU3
	D6EvY2ROoNGgm8Hqfnfns2dDdeCybcbvpA0GG+zXRX5ZDKp+OeViftnWOR0L7B3G
	9lIpSKuh7SZvP0ZKLCy1IL5zNIwXhicnAoQUTpOSxRJLgc+Wmd04yJh/jRy7HEDp
	w7yj9bZDwG+PI1xdcIdNNSZCL0CMGvXy+9sbuB8B5V/5X21pqyFuPoDFq9EaMbqf
	880br+vhgRZAtbMoLP0eTU17xSscBm/Zt1a6tjJw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu26pde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:40:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM3Cocp025906;
	Fri, 22 Nov 2024 08:40:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1jff4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:40:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AM8eNo512321172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 08:40:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E22DC2004E;
	Fri, 22 Nov 2024 08:40:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36AC120043;
	Fri, 22 Nov 2024 08:40:23 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.16.13])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 22 Nov 2024 08:40:23 +0000 (GMT)
Date: Fri, 22 Nov 2024 09:40:17 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/kcore.c: Clear ret value in read_kcore_iter
 after successful iov_iter_zero
Message-ID: <Z0BDcVpUjtbWmYTv@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241121231118.3212000-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121231118.3212000-1-jolsa@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pMlr2yiv_z5t_79X43YJrR_QMOwYgNvr
X-Proofpoint-ORIG-GUID: pMlr2yiv_z5t_79X43YJrR_QMOwYgNvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=778 adultscore=0 mlxscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220070

On Fri, Nov 22, 2024 at 12:11:18AM +0100, Jiri Olsa wrote:
> If iov_iter_zero succeeds after failed copy_from_kernel_nofault,
> we need to reset the ret value to zero otherwise it will be returned
> as final return value of read_kcore_iter.
> 
> This fixes objdump -d dump over /proc/kcore for me.
> 
> Cc: stable@vger.kernel.org
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Fixes: 3d5854d75e31 ("fs/proc/kcore.c: allow translation of physical memory addresses")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  fs/proc/kcore.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 51446c59388f..c82c408e573e 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -600,6 +600,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  					ret = -EFAULT;
>  					goto out;
>  				}
> +				ret = 0;
>  			/*
>  			 * We know the bounce buffer is safe to copy from, so
>  			 * use _copy_to_iter() directly.

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thank you, Jiri!

