Return-Path: <linux-fsdevel+bounces-24225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8878493BD00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 09:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385EF283308
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 07:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210D16F8E8;
	Thu, 25 Jul 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IMp2mdPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092204428;
	Thu, 25 Jul 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892102; cv=none; b=mLIWuDsRs4IHZaOA2bXvS94AfQsJ1502G8MZnU4ceNdt2tFtqpijC8hA8WkgF8mQpOvwlnom93RcWZt6ujMRmps+lkot8K7UNbjNL9G2xitwNx0KbubBHZ1PHR96CL1JMMh4kMHLUnRoLhOgRlwYt3vL8N9uO7jnK4Ry4o9/cDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892102; c=relaxed/simple;
	bh=ydbfuohjatUcdiCDESO0TMpmlY+ErfumtWftHn6xhc8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ik4LCSlTMrbmpykAY4mzWbQ4Lea5u8/h2j7bWVM9hql7MkfmF2CaQgxgkQYrncBcZtVa2EgHBdSRTbhunZfkTwiz4Y+epVsafwzU126vdn4Z088r5I69JWbPmaqHx67jOxJXtnjITIzpD3T4wj2xJn/LFJKkV9zb9wp4BVuXeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IMp2mdPr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OJlCC5007911;
	Thu, 25 Jul 2024 07:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ig7qJ9Vxpn3l4dcvLm0+s7oO6xAzUdgvzcwziFSjE6M=; b=IMp2mdPrVEuEhnJ3
	7VlREr044iOOChgwcf6s/n9GsciRvpy/pavDwnwy4gnAw8y09Tu4Vf4VMHbXun39
	jNkKU7unhH1g1eX8bzrn2EUFqjNaxdbhRRpf3GH97HYUNgKxo6RkTMV41YqdiY7k
	zmdd2Yl66ZnAGmfiTLNe6HO6Ataewt+RQ1nBQ7nD7wLyUIGcTnKjtpXixbegm5Ju
	kYOIK8AI8BytSzUUNoH5S2M/nfjMD2+1cM//qpEuxP3mT42tY0QaVgl5qGvtqhaR
	4a+ublY6hODYQmrAFbmoeR50QA9JH+VNKmvWUtUQ33EVWeQHKHyR4VhBoebrE8CY
	ZPAWQQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jh473x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 07:21:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46P7LbND025094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 07:21:37 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 00:21:37 -0700
Received: from nalasex01b.na.qualcomm.com ([fe80::f0fe:41be:6309:e65b]) by
 nalasex01b.na.qualcomm.com ([fe80::f0fe:41be:6309:e65b%12]) with mapi id
 15.02.1544.009; Thu, 25 Jul 2024 00:21:37 -0700
From: "Yuvaraj Ranganathan (QUIC)" <quic_yrangana@quicinc.com>
To: Theodore Ts'o <tytso@mit.edu>,
        "linux-fscrypt@vger.kernel.org"
	<linux-fscrypt@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Software encryption at fscrypt causing the filesystem access
 unresponsive
Thread-Topic: Software encryption at fscrypt causing the filesystem access
 unresponsive
Thread-Index: Adrd1KUCQ0a7ysxrSBSnpsfNUNxokAAEOaUAAB9SRWA=
Date: Thu, 25 Jul 2024 07:21:36 +0000
Message-ID: <08079d01e25748108aedb95a3c30e5e7@quicinc.com>
References: <PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com>
 <20240724162132.GB131596@mit.edu>
In-Reply-To: <20240724162132.GB131596@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bOWsMKe9dU10-9fOwDgQYEc4txTg_vWD
X-Proofpoint-GUID: bOWsMKe9dU10-9fOwDgQYEc4txTg_vWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_07,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250046

Hello Ted,

I don't see fast_commit feature is enabled for this filesystem.

Here are the filesystem features enabled for that disk partition,

Filesystem features:=20
has_journal ext_attr resize_inode dir_index stable_inodes filetype needs_re=
covery extent 64bit flex_bg encrypt sparse_super large_file huge_file dir_n=
link extra_isize metadata_csum

Thanks,
Yuvaraj.

-----Original Message-----
From: Theodore Ts'o <tytso@mit.edu>=20
Sent: Wednesday, July 24, 2024 9:52 PM
To: Yuvaraj Ranganathan <yrangana@qti.qualcomm.com>
Cc: linux-fscrypt@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-ker=
nel@vger.kernel.org
Subject: Re: Software encryption at fscrypt causing the filesystem access u=
nresponsive

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Wed, Jul 24, 2024 at 02:21:26PM +0000, Yuvaraj Ranganathan wrote:
> Hello developers,
>
> We are trying to validate a Software file based encryption with=20
> standard key by disabling Inline encryption and we are observing the=20
> adb session is hung.  We are not able to access the same filesystem at=20
> that moment.

The stack trace seems to indicate that the fast_commit feature is enabled. =
 That's a relatively new feature; can you replicate the hang without fast_c=
ommit being enabled?

                                                - Ted

