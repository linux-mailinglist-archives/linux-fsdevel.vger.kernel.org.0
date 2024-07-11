Return-Path: <linux-fsdevel+bounces-23588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4115092EDE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 19:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AA51C216C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4916DC0D;
	Thu, 11 Jul 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aIPJ9u0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D415ECCA;
	Thu, 11 Jul 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719324; cv=none; b=XwVIBtYQvdQ4Ss76+WvZu1j0LS+UZrm56XxMUaBz9Hpx3b9lAdde9Bjfc+3o0t1cJvIXZKijUCHQpdWdSHBtEoHKXwpU57OZBnJ4uTS1Em2dZj08SowFLsbcaUoz4aF2rA7yEoWdqdR/j+8gvTb7CNugvaHSr6l80EdaN083Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719324; c=relaxed/simple;
	bh=Yq5IPf1HRPSyNRcPOhcfpmbjqBQXjhii33FKiak2WP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nsj1By/WVpNtXvRK7wxyf2NOsJNGkAe8j2Ngrj3Qtxo6N1fGs7/rnmlfUcsk6OfWX1wKIOhn+4vWdzxaIyKn8FS5e0EvLCr7AX44BKxfOLvLlfQFCPmVjmWteSDnaO6FyWpZ25GdlWqjgfLz1M+oqM+OHYFo8R2FH1hpnpY/X2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aIPJ9u0h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BD2LO7007421;
	Thu, 11 Jul 2024 17:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qNPf0d2xbAM8URqvKSWu8WshjIdAJFLq2jdFkPgYo2k=; b=aIPJ9u0hBoZUGZ+C
	VjBCfdT242yhcU/dTCGwU7+4+BnGthPusUwd4F3vFc5uIx7iCl9jRy2LWoROt4hE
	+Wc1xz4FfRurvOUa8D2mVAhz+koE+cY3BVP0twdzj9erzfokvRQhZY4BPb8f/oMT
	yzIDrnkyoA213a+7LQDmL+/jVRQXv6zqfkal8vNyTwTvFcSvzCf84bzb7YgNXB3e
	esz+2F1bsaUBE1YSh+rXZAZm2OrkDVcSCtDG84yHaQRJaITJzDhhnIgTGZJL42Dx
	Jk25llWRhsO4WiH0M5Su2wnn345sC0uiyr9Lmct7x4pepz9ksQGSO8/rZYIWU2K2
	BMQQoA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4091jdqcvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 17:35:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BHZGAt031757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 17:35:16 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 10:35:15 -0700
Message-ID: <f623ca12-6911-48d0-8706-483f38a99b13@quicinc.com>
Date: Thu, 11 Jul 2024 10:35:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/adfs: add MODULE_DESCRIPTION
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Jan Kara <jack@suse.cz>
References: <20240523-md-adfs-v1-1-364268e38370@quicinc.com>
 <20240524-zumal-butterbrot-015b2a21efd5@brauner>
 <20240527164022.GE2118490@ZenIV>
 <20240528-gehemmt-umziehen-510568bb05ac@brauner>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240528-gehemmt-umziehen-510568bb05ac@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B8dvNRnMd4KtbiTIJfnGVLX6N3pIlPeZ
X-Proofpoint-ORIG-GUID: B8dvNRnMd4KtbiTIJfnGVLX6N3pIlPeZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=846
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407110122

On 5/28/24 03:00, Christian Brauner wrote:
> On Mon, May 27, 2024 at 05:40:22PM +0100, Al Viro wrote:
>> On Fri, May 24, 2024 at 03:13:04PM +0200, Christian Brauner wrote:
>>> On Thu, 23 May 2024 06:58:01 -0700, Jeff Johnson wrote:
>>>> Fix the 'make W=1' issue:
>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/adfs/adfs.o
>>>>
>>>>
>>>
>>> Sure, why not.
>>
>> Might make sense to move those into a separate branch, IMO (and feel
>> free to slap ACKed-by: Al Viro <viro@zeniv.linux.org.uk> on those -
>> AFAICS all of them look reasonable).
> 
> Thanks! Added Acks to all of them and about to push it to
> #vfs.module.description.

Following up since I don't see this in linux-next and hope to have all 
of these warnings fixed tree-wide in 6.11.

/jeff

