Return-Path: <linux-fsdevel+bounces-36270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0BF9E0875
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 17:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A956316B991
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504412FF70;
	Mon,  2 Dec 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="epBVXn7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0977DA7F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154997; cv=none; b=Tsf5cHYY5iEDysheT9gtCynm7aHFgLI8irr6WSIy3Auw/PxT5XGwRGrwfnnnwCWFxF6tn27yntuibsp0sBZ8RZrJtrAeknnKGR9igfhG7cWGG1JUfym0Pgla2bz7Xc7XMGc0i4cKNtOti9rkVMIV3USZs1H5jibUo03buBCgpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154997; c=relaxed/simple;
	bh=9+EwqRBQ9XDIdCVnOglNOdcxkC2/IPTM6/OlzECA3uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ilNG0lOgVd0DqsxlOr7UmWN0qz58txZSeLirk/c/JK9mq9iAb7qqLFhbNFiwj0btVRi7a2oPgSmiHhf1ixjbXgcx4VdDKy4yw6gyD7Uy5/kfZbMAOykAbYql5RkmLiFcJhDghi4NHKb2ONeOruTIW9By4mbhzrCbxefMcicscB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=epBVXn7/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28oj7t010215;
	Mon, 2 Dec 2024 15:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4KX6/MWUVKSnemowOD8s5zQJLgs/M/OAtcQuDIuKaI0=; b=epBVXn7/KuI9LGvg
	TlY6FNZVox3ap3kg3bD5YXGge0tyspb06cVgMUBvrSlvCAWh1Aa6xIh3QdhCAhYO
	qHFm9nU80eyy5btOTGKGUeuZIkPRYn2nsT/jO47jlGeEtIehsWNo1f7qaSXx1cdd
	4Nuaf/+D2jtvR9PtMR+/mZ77/SlPPjvORtSEOVUhgiCzdikqu3Tyu0DnGMUQLxvW
	8KTkAXz8NiBpB22+ksH+HT3X4te6L+cBPLJvC7wSI1R6rOEf1gCFaPLpLcr4MRgT
	+Hkbp+m5gbFAuuIF4I3ph4/pUiN7HnapXl2YRhPqz9u65nTIcvJGbULGOXRWktHP
	eDbzYQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437t1gdbsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 15:56:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B2FuPij019234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Dec 2024 15:56:25 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 2 Dec 2024
 07:56:25 -0800
Message-ID: <3b8e8227-82d3-41c9-89d3-e70de1afa43e@quicinc.com>
Date: Mon, 2 Dec 2024 07:56:24 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] Add base implementation of an MFS
To: Bijan Tabatabai <bijan311@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <btabatabai@wisc.edu>
CC: <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <mingo@redhat.com>
References: <20241122203830.2381905-1-btabatabai@wisc.edu>
 <20241122203830.2381905-5-btabatabai@wisc.edu>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241122203830.2381905-5-btabatabai@wisc.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N_2rXqtcJ5ENEIEtl5tkPwT6AGsvBhpZ
X-Proofpoint-ORIG-GUID: N_2rXqtcJ5ENEIEtl5tkPwT6AGsvBhpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020137

On 11/22/24 12:38, Bijan Tabatabai wrote:
> Mount by running
> sudo mount -t BasicMFS BasicMFS -o numpages=<pages> <mntdir>
> 
> Where <pages> is the max number of 4KB pages it can use, and <mntdir> is
> the directory to mount the filesystem to.
> 
> This patch is meant to serve as a reference for the reviewers and is not
> intended to be upstreamed.
> 
> Signed-off-by: Bijan Tabatabai <btabatabai@wisc.edu>
...
> +static int __init init_basicmfs(void)
> +{
> +	printk(KERN_INFO "Starting BasicMFS");
> +	register_filesystem(&basicmfs_fs_type);
> +
> +	return 0;
> +}
> +module_init(init_basicmfs);
> +
> +static void cleanup_basicmfs(void)
> +{
> +	printk(KERN_INFO "Removing BasicMFS");
> +	unregister_filesystem(&basicmfs_fs_type);
> +}
> +module_exit(cleanup_basicmfs);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Bijan Tabatabai");

Based on the other feedback it looks like this won't be accepted, but
for completeness I have a specific commit check which flagged this patch.

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
(if any) are left, so please don't introduce a new one :)

Please add the missing MODULE_DESCRIPTION()

/jeff

