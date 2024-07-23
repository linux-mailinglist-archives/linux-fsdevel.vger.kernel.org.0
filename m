Return-Path: <linux-fsdevel+bounces-24153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D293A75F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 20:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A12846EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 18:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4749913DDD8;
	Tue, 23 Jul 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="opUwadBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BA2E83F;
	Tue, 23 Jul 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760327; cv=none; b=tzMNKOX+cz9TTlqo6Amd6UDKCyXJMGkXZ95gR4tgJREkL5MMGywPtonsf2fsTpotT15/WZB4VSCob9eeHrKzMNv0eVJEEnaSA0+qVUcc5amaROP44rKbgDgPLlUqwn7YNXrdqyZ7V+QygW4eF13pDfzjn84l9hlYEtWZvsEK7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760327; c=relaxed/simple;
	bh=UrxWRPlMqpoWKZ2bExnCYyL4Z0PybRF7zzgPePLINCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=scpWfT9XD1DqOniWyBAB+lYqDohmU+ynSr8Lq92WIJvYD0ktSHP+awaBbpAhqaePHT5l6haQzIJ3WTGi6BgweCAXMp43iHDLOV2q2kL9y89LtqSZ0xRusn6X+r8dWTcgJ2zrgrGPfYjsXOSKKIgudkv4J1lFD4bM0eVzH8CBT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=opUwadBX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NAUdeW019032;
	Tue, 23 Jul 2024 18:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gCCB1G6hlRvOVWfsLO+bg+iIDXZd0MGxhchi6Ypv1wY=; b=opUwadBXeU5mB+H3
	LReIUOQtAog8dM2aE3Kviqtgh4NsLUcgPDH7HYG8ACYH8BGL/+5H940r7dgu2Ksr
	yAnrVC5Ue9wTaWVVyelIWIyBegfl9KAVq/hoOBw+XoIxzxU0v7rtI6V2pY4TlSBG
	bPcr3H8/ok8GtRlcOt/CAM6XjdlcXWdpxqn76Gcd0cXNqGD3Od8cVhDUk759EQuM
	k1SzBA/DZr/YAUNrC2wazbA4DO6z6cXwYtEzbAfIOroKL35y+YoWiqVNOhO/cNWC
	mwzemEtNlR1dtwaVWHts3Hlm8yu3G3PR8nbVre3CuqikYYBh3N8zlRIm3+dnACXz
	2p668g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g60jyr3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:45:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIjMOM012077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:45:22 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:45:22 -0700
Message-ID: <d9e59c2d-bd31-4536-9a7b-64b2c071f50d@quicinc.com>
Date: Tue, 23 Jul 2024 11:45:22 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] unicode: add MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240524-md-unicode-v1-1-e2727ce8574d@quicinc.com>
 <87y17vng34.fsf@mailhost.krisman.be> <87v823npvl.fsf@mailhost.krisman.be>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87v823npvl.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zz9er9Q2DBXDwk5k9hdK20aM6trT2ry8
X-Proofpoint-GUID: zz9er9Q2DBXDwk5k9hdK20aM6trT2ry8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230130

On 6/20/2024 4:41 PM, Gabriel Krisman Bertazi wrote:
> 
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>
>>> Currently 'make W=1' reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8data.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8-selftest.o
>>>
>>> Add a MODULE_DESCRIPTION() to utf8-selftest.c and utf8data.c_shipped,
>>> and update mkutf8data.c to add a MODULE_DESCRIPTION() to any future
>>> generated utf8data file.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> ---
>>> Note that I verified that REGENERATE_UTF8DATA creates a file with
>>> the correct MODULE_DESCRIPTION(), but that file has significantly
>>> different contents than utf8data.c_shipped using the current:
>>> https://www.unicode.org/Public/UNIDATA/UCD.zip
>>
>> Thanks for reporting this.  I'll investigate and definitely regenerate
>> the file.
> 
> Now that I investigated it, I realized there is perhaps a
> misunderstanding and not an issue. I just tried regenerating utf8data.c
> and the file is byte-per-byte equal utf8data_shipped.c, so all is
> good.
> 
> Considering the link you posted, I suspect you used the latest
> unicode version and not version 12.1, which we support.  So there is no
> surprise the files won't match.
> 
>> The patch is good, I'll apply it to the unicode code tree
>> following the fix to the above issue.
> 
> Applied!
> 
> ty,
> 

Hi,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff

