Return-Path: <linux-fsdevel+bounces-65123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D69BFCC12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB3F1A610DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAFE34DB5D;
	Wed, 22 Oct 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p96rpe+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF17C34D912;
	Wed, 22 Oct 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145329; cv=none; b=MMh7i4bhoFeoag8e5uw7XsEcxJvW75LJnFoFDVXND0U7nvGm9fVEvi0LKJ+8W1xbtjAd58HNZQJyDiS8EcIE48TmIhctLG0wtXmR3LBDs/ctOy9I/YqnmlD0FtofqJDkKjpP3VCvGpfuktkIGaAbwzbQ+9uRLhxh3BkZVea3PUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145329; c=relaxed/simple;
	bh=uD1lXLa3iERtWTFaqK+n+ldKKKAPBgWiZ0PUi7o41Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsMhgnQSOrYAAsnXtVmj/zFEW5ClIB54EHEG+fH0g/wI7EOduaSGVbt9q+s1xVfNTdHv8av1SFgU7Q3dnWKthUfNjQXqd+7pHya9PR4VXBkbF0OBKnz1LTHCVahrT9HLRjdM8i3MPCV/tiqj0wTQcuO8khHSe9MnQBEz/2Pi7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p96rpe+8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M6xCmW014219;
	Wed, 22 Oct 2025 15:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xvzr1Y8dpMAUvoEFP57Gz835wHqBYz
	e10hbyZJeYU3g=; b=p96rpe+8jnIvJcnNRSXnoAPg+2bPFvo3QYoRkE9XzhXOuf
	zPU2HkzEcM1nDb3BKO3LYcNgZpWcrbVplnyT48p0FCkoweL8zrwPAlHB5CYbQm+x
	HNS/LhTF//xKum9vf1Ddjh6D2+WHxMY+liq50P7+j32lWdYGNBWfdW5SHxC5hDcB
	V8raLaY6GqWjC1UlIT8pdrRl3Z7fXa59vsnZeU3JQhoMYwSqKerwp8gyyf2ztLq6
	StSUFLh4QdrGLaMAOjU/zguLq9XCZ7NAvPi5iMUMgpC5sYJB2DoYjpjZhl++qSpB
	owKG4AFDsdS58ufnQkUH4OnqUUKl5DwfXesfF92g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vuxtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:00:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MEpIdh002378;
	Wed, 22 Oct 2025 15:00:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vuxta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:00:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MES37T032103;
	Wed, 22 Oct 2025 15:00:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n0wah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 15:00:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MF0JRG61211024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 15:00:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33AEA2004B;
	Wed, 22 Oct 2025 15:00:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B81C2004D;
	Wed, 22 Oct 2025 15:00:18 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Oct 2025 15:00:18 +0000 (GMT)
Date: Wed, 22 Oct 2025 17:00:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        David Laight <david.laight.linux@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [patch V4 06/12] s390/uaccess: Use unsafe wrappers for ASM GOTO
Message-ID: <20251022150016.37430Aa6-hca@linux.ibm.com>
References: <20251022102427.400699796@linutronix.de>
 <20251022103112.232389777@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022103112.232389777@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8rtbyt9zSskKlv_nEpWKeIuOG0eXKSER
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7mGSdj579bLq
 8bxKzWQ1s8+btHn0jwgAP2J3vX/A4EDg/HYeBH4RsyA5X+zGAdGIwFDsszFuA+Rn1v01A0G6Yjs
 vO6A8wck2DPsUU69VTxABi+r3WoXEdameL5QVo/RksBPiR+jb6D+2UrRoVIg2Iq/O6AsFY3wYT5
 PNCbILR1buB2fxPv51m4yPgFagoOjPret48aJLEeRSls7plxINKeU5yrx6Yk/cvBYbkFpLuEv+2
 cC6SaFGy3Zn+mHF6qUaOg4lQzCotveGK2C59n1pbfL63Z+o6dqfDill8gmsksaHpgwTwW2wrpK9
 bs5ltJsCCgMlLBlcLq8bAga6P/bzqpPOPPxNDA9reMNdOvsKvMKrYr3xNsBpe4DhuMlrzQLF2L1
 QwLoubNXcqjQwkWg6G6TPxJxCDvB2g==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f8f189 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=l-w2ndfUCpChbJJzmvYA:9 a=CjuIK1q_8ugA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: uK_G6Z0fHMdC8Ou7HEH28NKPmNT2Wfej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Wed, Oct 22, 2025 at 02:49:09PM +0200, Thomas Gleixner wrote:
> ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:
> 
> bool foo(u32 __user *p, u32 val)
> {
> 	scoped_guard(pagefault)
> 		unsafe_put_user(val, p, efault);
> 	return true;
> efault:
> 	return false;
> }
> 
> It ends up leaking the pagefault disable counter in the fault path. clang
> at least fails the build.
> 
> S390 is not affected for unsafe_*_user() as it uses it's own local label
> already, but __get/put_kernel_nofault() lack that.
> 
> Rename them to arch_*_kernel_nofault() which makes the generic uaccess
> header wrap it with a local label that makes both compilers emit correct
> code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/include/asm/uaccess.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

