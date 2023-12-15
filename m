Return-Path: <linux-fsdevel+bounces-6167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C459A81418E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 06:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DBD1C22465
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 05:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65B79DB;
	Fri, 15 Dec 2023 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="osIOs18x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C470DDA8;
	Fri, 15 Dec 2023 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF3tA23030077;
	Fri, 15 Dec 2023 05:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WwhbnCJ/fvj1pBHTsPcikQpwh3p9fizJJVTCR0bzuCo=; b=os
	IOs18xp/yBTZqmdQzVbjlJTRbFjICiHbu9cijQ0MNmMnxMm0nE88Ap3eyc222Y/B
	n1RFlSredGasfpyvHZiA5cRJrQ41j1cGUYTf8N7AcnSFBJZQd5BYVrWmmUZXJpHo
	OvDCjCWCFF8tqtKb2JdefmfpHEDY4cAtDfrVThmNNPiQHm7pmF6JOaRxOY/Znppe
	k0yxmOzsADwRB54Nu0VD6lnhZydUlgecvtpb4H6UAruSxXTxfNGwYGi4rueVo0KE
	Rm6kQqu550Rl2EJZLDN51Kgbuc5GSEgZFEtGs13R0Bay3rmqbxh/0Vhpk8d2dLte
	xADAHzfUcPaEoElYgAuQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp0pb79r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:52:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF5qOFd024341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:52:24 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 21:52:16 -0800
Message-ID: <75de85ae-ebcb-4f86-8cbf-749708cb3668@quicinc.com>
Date: Fri, 15 Dec 2023 13:52:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox
	<willy@infradead.org>
CC: <kernel@quicinc.com>, <quic_pkondeti@quicinc.com>, <keescook@chromium.or>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <oleg@redhat.com>,
        <dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9L7uaS1JyabO0j9O4o1SCZxK4G0IVJ0o
X-Proofpoint-GUID: 9L7uaS1JyabO0j9O4o1SCZxK4G0IVJ0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=543 mlxscore=0 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150034



On 12/14/2023 2:27 AM, Eric W. Biederman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> On Wed, Dec 13, 2023 at 06:17:45PM +0800, Maria Yu wrote:
>>> +static inline void write_lock_tasklist_lock(void)
>>> +{
>>> +	while (1) {
>>> +		local_irq_disable();
>>> +		if (write_trylock(&tasklist_lock))
>>> +			break;
>>> +		local_irq_enable();
>>> +		cpu_relax();
>>
>> This is a bad implementation though.  You don't set the _QW_WAITING flag
Any better ideas and suggestions are welcomed. :)
>> so readers don't know that there's a pending writer.  Also, I've see >> cpu_relax() pessimise CPU behaviour; putting it into a low-power mode
>> that takes a while to wake up from.
>>
>> I think the right way to fix this is to pass a boolean flag to
>> queued_write_lock_slowpath() to let it know whether it can re-enable
>> interrupts while checking whether _QW_WAITING is set.
> 
> Yes.  It seems to make sense to distinguish between write_lock_irq and
> write_lock_irqsave and fix this for all of write_lock_irq.
> 
Let me think about this.
It seems a possible because there is a special behavior from reader side 
when in interrupt it will directly get the lock regardless of the 
pending writer.

> Either that or someone can put in the work to start making the
> tasklist_lock go away.
> 
> Eric
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

