Return-Path: <linux-fsdevel+bounces-33806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F59BF23A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9FB1F21DB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437E2010F0;
	Wed,  6 Nov 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GgS+pgHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9112EAE0
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908288; cv=none; b=FhpySvLJcEESOjestyrOPjweRm4prrRp6/ESq36c/Rycs6tP4yVa6wG4aRP1qgGHY+oTCZMlE8/i6SJgyw+RbHSTaYNTU2eQ5R8mRxGgt1qbKZkCmDXYrHW7IdHcWf4qqaId6SZE8gISm4e/Mc8Tx4Iire0DhpHjAzJ4QQdiR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908288; c=relaxed/simple;
	bh=JXV3op0nI1/pZ4kkCasLJPsZUNzb/hoUEaZf3MN8BDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rzSRjm+0unFXuSM9sMpPTqBohaA5uL14FaOZl6PsA+8DeXBjtozI5xQuYzXOkRSmNJ2kCetzEYcE2FQr2OOrNsVlH3x9/uR+cFp+iSplFleo7TRFKsOgFzH8vNg2J1sKjNGTMoLznr5zlzXPMv6DX+sZSU4Vc/1oEGjNt+2Lwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GgS+pgHN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68DSuw004700;
	Wed, 6 Nov 2024 15:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WAZTOzuds0AAxrmF8OogqaBcqNvElJTDiS9Z2JBHLG8=; b=GgS+pgHN+0JRXRHI
	CnNfOVclmPANKeFfmfRTKxy8KU62dq504BxqUGdYOTIVV9lSOKSAybMViFpBQNBJ
	lNCoVAF2N7BMWgDbiEjIZa+UQy2wQTTLgbpjCbNYFFBjryXlkF9qh0hC+qZVj+cf
	Um4bIlOabkysrj2nh5QgWdD7u5ArB8aQuvUUE6Z6NjKCer2+LrJXzLZCUY2kRFTO
	0B64FrMqqfdY5/Ly9Dtb63ysvilOkaWY0Jgcby+LQux+5BS5JD4VWx5vPmjxGEd+
	C1CG7WBDCbcg4NQZAc7tp0KYZ2RzI5C1CXMHUkGfEVCK+SudcskCRI1tpgZivcRY
	HzAfgg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx4m2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 15:51:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6Fp8IP012831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 15:51:08 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 07:51:08 -0800
Message-ID: <9dc5e012-724c-4bec-a702-aa1194b99311@quicinc.com>
Date: Wed, 6 Nov 2024 07:51:08 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] initramfs_test: kunit tests for initramfs
 unpacking
To: David Disseldorp <ddiss@suse.de>, <linux-fsdevel@vger.kernel.org>
CC: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
References: <20241104141750.16119-1-ddiss@suse.de>
 <20241104141750.16119-3-ddiss@suse.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241104141750.16119-3-ddiss@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r9f1TgfhH_hE9lmofB5BZw2WcSAccsGt
X-Proofpoint-ORIG-GUID: r9f1TgfhH_hE9lmofB5BZw2WcSAccsGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=849
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060124

On 11/4/24 06:14, David Disseldorp wrote:
> Provide some basic initramfs unpack sanity tests covering:
> - simple file / dir extraction
> - filename field overrun, as reported and fixed separately via
>   https://lore.kernel.org/r/20241030035509.20194-2-ddiss@suse.de
> - "070702" cpio data checksums
> - hardlinks
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---

...

> +kunit_test_init_section_suites(&initramfs_test_suite);
> +
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
(if any) are left, so please don't introduce a new one :)

Please add the missing MODULE_DESCRIPTION()


