Return-Path: <linux-fsdevel+bounces-61005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD19B543BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 09:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D0F1C868C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1D2C08B6;
	Fri, 12 Sep 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="flO1iKZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831982BE62D;
	Fri, 12 Sep 2025 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661737; cv=none; b=KyLAZqv7/iLCB5X7lcPFDzyXtHQ4zhlNDHdO4JAWG/9jPPllWSBuB8+bFYtT9Yfl7EMSccPAKzs0AdpQYNkRRe6UZO7eaUIo4x9DnJJjxJ8np0eF2lLovGroA+J7T7WN9346EtwTssCCQDAnWrNJ7+NixhUv3yEZmTIT0bUhby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661737; c=relaxed/simple;
	bh=7N8j92UF1rmeEeMIiK9A/lZjg3S0qoHyuNm6kSJjeD4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZoHC3JpdbxIP8NKm49QlFA+fb2pVBo3weCsCznAK/FReBb6MLctLcGEuRu2a8HB5qhcjqmb0cEVyXdgZ94NlWpcxWpZ3+OnL/nlzudYoZEOf7F/WKTWy1jR3ArBZdIdYrKYHYHcwHI+4B6WCC3OCrhPbNUae/8zc/dFrY9w4HOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=flO1iKZ1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BMBPqt026821;
	Fri, 12 Sep 2025 07:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7N8j92
	UF1rmeEeMIiK9A/lZjg3S0qoHyuNm6kSJjeD4=; b=flO1iKZ1NObM3bAjoluDKi
	r840Bk0ASzcAGEyhoQiQHLlJ7Ft+jP6aEFN8ygl67RTR6/t2+z387deHtexSTIrG
	y/Hhzc6YRvWV395ksfKkcaue2N2tqw/m8G33vI2vKFdOTG2Q8n8Ts3+jFvtaPLK0
	brrwPNPabfFAiEN7n7t8Aa0ViG0NCK52r39Jt+ucrv4R2JiD5fJu5cjB6CiM/fqE
	ziaMFpl4lzQ7RVu23tMxb3BiK1XRsEUDZJ1JPDA280yeISqu/aA5E9MyOi4Y2c8Z
	IoNQNxGtkf1aK83jjVqQtucDtTaov3f1ihN780KJ6T6RLh8hxxmecr3G146BylAQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct8pm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:22:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C5BHBf011457;
	Fri, 12 Sep 2025 07:22:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9ut181-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 07:22:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C7M2cM29754062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 07:22:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC9435805D;
	Fri, 12 Sep 2025 07:22:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EA2A58059;
	Fri, 12 Sep 2025 07:21:58 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.244.60])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Sep 2025 07:21:58 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [linux-next20250911]Kernel OOPs while running generic/256 on Pmem
 device
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <aMPIwdleUCUMFPh2@infradead.org>
Date: Fri, 12 Sep 2025 12:51:44 +0530
Cc: linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com,
        ojaswin@linux.ibm.com, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm@vger.kernel.org, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <96AA28C4-24DD-4638-B944-CC2E2E7FC4C0@linux.ibm.com>
References: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com>
 <aMPIwdleUCUMFPh2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX694bk+5dV0QP
 vwkrmWpJdqg0KMSFaHJMTLh0yb6j5fa0y1iPDNVi4pdil47n+vvxxr4pLL3ub/OdAaQj1q8Esnz
 vPvFbCZk0F35dt0vp/JvFz8GNb4vgPCQUrc2FIDO/3nd8dFS6bm4+qJeyNWVze+9W+lO8DKaGw5
 jyfUiC+o6z7bke/wjJyQZSLiXz9DnmO9SHDxKCLNc/Il7HOwAzIL36Lr5h+uGafQsLsS5AHXftK
 wD2K8JqZWwHbs1esDqsRI5/KdAkXg00ohc2JCYIudWZM2fBctB78NvGFPtbRADdyfcXRxahP8Wu
 9fCoJg8hQnfCpGtfJqsLYVHeT9UKw9sxKwDYdCa8oaSxRruSx1Gf/aovLAUBWLK8b4B7vN/ddgr
 hzJNLVW7
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c3ca1c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=wOK_BrywWAtTNq7yZiUA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 62UQL51jW9jaTqixgBdQ7gy0k8zYkkMo
X-Proofpoint-ORIG-GUID: 62UQL51jW9jaTqixgBdQ7gy0k8zYkkMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010



> On 12 Sep 2025, at 12:46=E2=80=AFPM, Christoph Hellwig =
<hch@infradead.org> wrote:
>=20
> On Fri, Sep 12, 2025 at 10:51:18AM +0530, Venkat Rao Bagalkote wrote:
>> Greetings!!!
>>=20
>>=20
>> IBM CI has reported a kernel crash, while running generic/256 test =
case on
>> pmem device from xfstests suite on linux-next20250911 kernel.
>=20
> Given that this in memcg code you probably want to send this to =
linux-mm
> and the cgroups list.

Thanks for advice.

Adding mm and croups mailing list.

Regards,
Venkat.




