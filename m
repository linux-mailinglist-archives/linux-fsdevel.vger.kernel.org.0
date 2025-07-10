Return-Path: <linux-fsdevel+bounces-54537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D381B008D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF36D3AE901
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638F274B54;
	Thu, 10 Jul 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jkoHW/o8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E32248B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165248; cv=none; b=HvYiJysOpL6aqZ+CIoKRA8PNGA7Ii+Pv5gQUCmDfXR6Pr+I11LLvuk0kL6RnaFBq0+5XnX66uxy+F2R8lLR/08cbyXt6x9G6mfVDm1Bq3nM05/sMmnM6gu/FAKe9CqQf7o4zC1kF2aEZtCjHk0J1Iqmkb9E84iRb7Pfh47NJOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165248; c=relaxed/simple;
	bh=Iyx/rY3um5foq2UdmVnt2T9K+tytX3EZTYmOTemq+Co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCC6+Wp4GuDbg+BcWqGuIF9GBlCJMy0iwVLCpq0UR+QMerWgUOqJvc8rVZh7c8jqNNM7mL+iQ2+Jkd6PdOwppuN9sQgUdSWjiKMDWUKb5npplf6Lq9+Zv/7uyG7pMdNVgNhmVGdXCB6c1p4vIgMCYYtP0au99s7CsVkQ8zq2vWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jkoHW/o8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AGBTTh013811
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 09:34:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fLWc5sDtQr4fdfwzMmBd3PXfsLS6ZqtHFE2nBMh8Eps=; b=jkoHW/o89ZSs
	89YmkOk9lB+lhSHW7AZakM9CldA4TZu9TYL9U9zo7c8pFL2HWCsS8hjkL1KT5ivN
	4CbCM24lr58n+hDuKAwgZSqsyrWJb3sapqu5Huf6YOCAnXmr03gsaGMeenX82xwi
	gRIfM4LWOmosh+ElKzqI9lAJ8hLRxdk3xFKofdpSWz/hN//DckvDlS9Tm0swVfEQ
	vOoTW6rZjONYfVibKNITvCEV97ag+Zl1vmJmcjvSzMJG0qEeXBtZNwMYMoXq8ugY
	UFIRoPsvhz+BsdJlG+FPjClmtlZKrnJULHrQDuI6gpmZL0692us7Wa/M7Kw/VQ7H
	xxYRrgzh1g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47t81cuqmb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 09:34:06 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 10 Jul 2025 16:34:04 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id CD93931F1B857; Thu, 10 Jul 2025 09:33:57 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@fb.com>, <ibrahimjirdeh@meta.com>, <jack@suse.cz>,
        <josef@toxicpanda.com>, <lesha@meta.com>,
        <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: [PATCH 3/3] [PATCH v2 3/3] fanotify: introduce event response identifier
Date: Thu, 10 Jul 2025 09:33:31 -0700
Message-ID: <20250710163331.3888821-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxiSqm5Uso_J1+4efAgefdUJDhwGQOt8WDd8NFkB6Y1RcQ@mail.gmail.com>
References: <CAOQ4uxiSqm5Uso_J1+4efAgefdUJDhwGQOt8WDd8NFkB6Y1RcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0MSBTYWx0ZWRfXxCSjTjVW+bIH 69cXvKdjmI0vBcDzw5guFKjQ4ymHg1kuXei54RE2mie9COcr9AQCoC/315Ht/FIKdrBmgcYbwq6 3PiuWVsl2qbLeFstSP7xw1U3edo2L8gmsvTDrG7CFOMLqJGp/w+U4k3G7+AqubV6rt/J2hov0l6
 qlE2X+bFHlgGq4J75XilrZTm5LoS4llGur3MifFpl4qATdjvpulj1Ce6V8veE+5CZlqMzoNOoWp t2GubqUkBC9mLdg+3dBKN2mAxuMiFR90vifwrlPGy48+gK6g7YsUCs+tRS0TKiEcvMJFaRtydKU Nn5Nc2TDUCT8aLzydArDlqhWDbzpKcwEr0D0WUGw2XkWj3+MmzOG4QblFHec7hiGMqQDUIWSYyj
 jEuzfE1fD3GhRXvNfcKGBJ5QcEXVqwqwiJ0N93EHaXbQwsMGEH+k8qRPTEUTNKOzNb3Fz3m3
X-Authority-Analysis: v=2.4 cv=ecA9f6EH c=1 sm=1 tr=0 ts=686feb7e cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=tm-JOOCgNrQRJpHM-h4A:9
X-Proofpoint-GUID: 5cK84QwILqSQkYW3_v1jkrklYplnZ0Zc
X-Proofpoint-ORIG-GUID: 5cK84QwILqSQkYW3_v1jkrklYplnZ0Zc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01

On 7/10/25, 1:45 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73i=
l@gmail.com>> wrote:
> > IMO, this is shorter and nicer after assigning fd =3D -ret; above:
> >
> >        if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR |
> >
> > FAN_REPORT_RESPONSE_ID))
> >                metadata.fd =3D fd;
> >        else
> >                metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
> >
>
> And above this code is also a good place to place the build assertion:
>
> BUILD_BUG_ON(sizeof(metadata.id) !=3D sizeof(metadata.fd));
> BUILD_BUG_ON(offsetof(struct fanotity_event_metadata, id) !=3D offsetof=
(struct
> fanotity_event_metadata, fd));
>
> Which provides the justification to use the union fields interchangeabl=
y
> in this simplified code.
>
> Thanks,
> Amir.

I will simplify the code to use union fields interchangeably + add the
suggested build assertions and resubmit these soon. It gives a chance
to fix the various formatting issues :)

