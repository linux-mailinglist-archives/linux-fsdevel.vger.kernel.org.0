Return-Path: <linux-fsdevel+bounces-22042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20275911705
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 01:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C079E1F23470
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3214EC6B;
	Thu, 20 Jun 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ovVCw6wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB55820E;
	Thu, 20 Jun 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927307; cv=none; b=gcmwVxLQNXZYNBROFLq3TciQlEjHtdgOKXQYKAzyP+kIdER358sSipbzv95t5H5rJkCBtxEuZKdlXKQS7Yi01XZDELglyVZYfu73PwO6iBrAEy03yLusoPIp8NLBp/puJlqWHjLLDdqHl2yAgvxl3r17a0KWl1PdSQt5wODCwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927307; c=relaxed/simple;
	bh=K9A4waJ6QXZxdccuDR+Mur9FbJzzjKX3VejoGo5Y2J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kS8CDgAL3aA2eZt0ExsMsrrCTatRpE5JkbcwMw0veivMdDUpFfCbvFfEK1NFhqD4ZbfQgg/ckKBE0uyYE4hHFmR38v6h2LOfqSkOfevob8SYE4W302YzRrjm+uFmvScLL5qtDJxNTsRn4xSnruowuAsHf+xLJmqBCWQpbfP5E5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ovVCw6wk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHAooY012954;
	Thu, 20 Jun 2024 23:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	44pzIQEQy0lJSh3B76Z91ATHmOFB+uMzHLgQXY1EFFA=; b=ovVCw6wkIhoh2sXG
	oXbVr1+/5b7Qpg8JQw+wCnm6UetNjN7BdeSHOzllO2Dk3ZDQkScF3tLmi+4YxAqQ
	b2Am58PZ/NxhJtjEp183MDssxyDpz06QTMO4f0OBsewzPVLc1tgGF0i1Ja3FqLG8
	BiZoQpbC/7+YvXMsWaVD4Zx/RZXnypAuFGIqUZrfeyHwxpTiSof1bgdhPeC+Ff63
	iP4u9OzCczlla3lo1UcnA0s+IX4qZggYL7xbpTdJt5md5DRnIgkJaeqchtgV0Mex
	vs0VanMsTiLBXUI2RdpT8FzlDeCxK/hxDcmMyf89V4rAHBb58DY8jREvct5r52Jx
	HHhVKQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrkkgxt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 23:48:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KNmLim011487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 23:48:21 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 16:48:21 -0700
Message-ID: <a42047c6-067a-455d-b32a-a715ef41b004@quicinc.com>
Date: Thu, 20 Jun 2024 16:48:20 -0700
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
X-Proofpoint-GUID: BfDDNSqnyV6uS9fuYgvV_YwkYsYZ7uUH
X-Proofpoint-ORIG-GUID: BfDDNSqnyV6uS9fuYgvV_YwkYsYZ7uUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxlogscore=852
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200174

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
yes, I was using current data.
thanks for taking the patch -- two more files to color green in my spreadsheet :)

