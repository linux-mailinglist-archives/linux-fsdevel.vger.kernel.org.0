Return-Path: <linux-fsdevel+bounces-58986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA0B33B17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DA820434B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9624C2C3257;
	Mon, 25 Aug 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iram.es header.i=@iram.es header.b="n15LO+qs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-006a4e02.pphosted.com (mx07-006a4e02.pphosted.com [143.55.146.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61B2BDC25;
	Mon, 25 Aug 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.55.146.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114059; cv=none; b=jdAg6SOsZrEc7RWkr1TRiv0sk0Mm39DF0njkgFUDdY3L3W7HBvn4ls/hQQSWkHsMTiwQuM0YKp/ktPwgrbXlggUxAAlQh/xXq8XdGm5uqJd+kyF9xr6RBiikG4w1gsMKX+DyW+8ju/3LDncCOnxOdiAErRzkRKNTrd7/UmPqgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114059; c=relaxed/simple;
	bh=od0Cl7EQYnvwX+EQ1mk1FhFEsgSnIhapkhd3PkN1zYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mezuf8XjTtCMI2RdQay5+WCb3ZcWyr04bT2Yi4KGOaZK9jt7vt6oqNHaFpV7aAl2DIQjdTipwh/GDHn31oUU5QeX0f077pQzL/27mygArfyScQ+gEqWMmavnZohltJcsxIspiOegBEJgLf3xOvCtG4WMQ/q3hvUSAD1YQa86FSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iram.es; spf=pass smtp.mailfrom=iram.es; dkim=pass (2048-bit key) header.d=iram.es header.i=@iram.es header.b=n15LO+qs; arc=none smtp.client-ip=143.55.146.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iram.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iram.es
Received: from pps.filterd (m0316690.ppops.net [127.0.0.1])
	by mx07-006a4e02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P6PQ5K015116;
	Mon, 25 Aug 2025 11:04:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iram.es; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=dkim3; bh=rzEViH2qeblykcKgZ/ETV2fumwaV
	6V/zw4MF9XRlfeU=; b=n15LO+qsawzZh20Qn/20l1l3bhwYF9/v8hNwrHTt2L8t
	YHSDQEyu9J6ONEXYGoxQfYm3Ggf16oO3UwGJAZEK51gLu9abRXIVlP9ie9/udLL7
	Vlfhay/EhcMLO6GbTgoclzxF1qcLRBrkE3EihGPSdKezANy9+D2Cdx/5OLrK3z3P
	7r76IEpXgztUNYUxrEhMw0UXauFqIUi8+ZA2utAQrS4aaSkVhRNynL1fUj9Pj26W
	RYNLdEnGH2aGyRoVuxeiBaWTR4RYBRNkE7xsbyR/wTTSjB3BnhkWS55NR/lFzIsN
	npKqwMjN09rJPyjCS98FknJTNCPu5rvyr8UEZrzx2Q==
Received: from mta-out02.sim.rediris.es (mta-out02.sim.rediris.es [130.206.24.44])
	by mx07-006a4e02.pphosted.com (PPS) with ESMTPS id 48qq0ka2r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 11:04:54 +0200 (MEST)
Received: from mta-out02.sim.rediris.es (localhost.localdomain [127.0.0.1])
	by mta-out02.sim.rediris.es (Postfix) with ESMTPS id 0EE4014009B;
	Mon, 25 Aug 2025 11:04:53 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mta-out02.sim.rediris.es (Postfix) with ESMTP id DD484140F82;
	Mon, 25 Aug 2025 11:04:52 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 mta-out02.sim.rediris.es
Received: from mta-out02.sim.rediris.es ([127.0.0.1])
 by localhost (mta-out02.sim.rediris.es [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 6dKRDSvFm0JS; Mon, 25 Aug 2025 11:04:52 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy01.sim.rediris.es [130.206.24.69])
	by mta-out02.sim.rediris.es (Postfix) with ESMTPA id 5905014009B;
	Mon, 25 Aug 2025 11:04:51 +0200 (CEST)
Date: Mon, 25 Aug 2025 11:04:50 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <david.laight.linux@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 10/10] powerpc/uaccess: Implement masked user access
Message-ID: <aKwnMo7UllLZkOcK@lt-gp.iram.es>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
 <647f1b1db985aec8ec1163bf97688563ae6f9609.1755854833.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647f1b1db985aec8ec1163bf97688563ae6f9609.1755854833.git.christophe.leroy@csgroup.eu>
X-Proofpoint-GUID: mUolfay-w1WXToAdGEjUbL3FPWWo1ug9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDIzMiBTYWx0ZWRfX8G3CF8JrmY3U
 BGgHltBwz3ExKiF7DjIdHKqJVml6dwPnDSIeKEc3k+1nbVINQyRJb932oCgW0jxo7xUZuvURGrb
 0lybQtEVPgVxAbInIze5gfIj2JwT3kZnBngcdOQ1rNrpkmK6XO+qOvi/3NYDqqlaI7ClQamdSoH
 vwbsnvjm2+kk4adUbYXXsz1ZxzAyoPEue6z9kJn/NUNd9sTJZPnYn6++gtQEWTZHxIgI1Mezejn
 IX5Dw/Tgz3Ak0bsTmPj43e2B8M+5UfPLHEl4VUTBjV1p6IqneumXH1JSTpP1qECQ20vWmgERkrt
 8sybnJI0U6q1FctZz3KfFVtLiKnzgBH2N40FoGH06e4A3x8tQFeAwpXa6Brm/2LjZCyy8v8dW0A
 gnkNeD2S
X-Proofpoint-ORIG-GUID: mUolfay-w1WXToAdGEjUbL3FPWWo1ug9
X-Authority-Analysis: v=2.4 cv=fJQ53Yae c=1 sm=1 tr=0 ts=68ac2736 cx=c_pps
 a=N+btqqeLiyZkBSWNmht35Q==:117 a=N+btqqeLiyZkBSWNmht35Q==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=XLq9KcJuiYQVQIFsEiUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=salida_notspam policy=salida score=0
 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230232


Hi Christophe,

On Fri, Aug 22, 2025 at 11:58:06AM +0200, Christophe Leroy wrote:
> Masked user access avoids the address/size verification by access_ok().
> Allthough its main purpose is to skip the speculation in the
> verification of user address and size hence avoid the need of spec
> mitigation, it also has the advantage of reducing the amount of
> instructions required so it even benefits to platforms that don't
> need speculation mitigation, especially when the size of the copy is
> not know at build time.
> 
> So implement masked user access on powerpc. The only requirement is
> to have memory gap that faults between the top user space and the
> real start of kernel area.
> 
> On 64 bits platforms the address space is divided that way:
> 
> 	0xffffffffffffffff	+------------------+
> 				|                  |
> 				|   kernel space   |
>  		 		|                  |
> 	0xc000000000000000	+------------------+  <== PAGE_OFFSET
> 				|//////////////////|
> 				|//////////////////|
> 	0x8000000000000000	|//////////////////|
> 				|//////////////////|
> 				|//////////////////|
> 	0x0010000000000000	+------------------+  <== TASK_SIZE_MAX
> 				|                  |
> 				|    user space    |
> 				|                  |
> 	0x0000000000000000	+------------------+
> 
> Kernel is always above 0x8000000000000000 and user always
> below, with a gap in-between. It leads to a 4 instructions sequence:
> 
>   80:	7c 69 1b 78 	mr      r9,r3
>   84:	7c 63 fe 76 	sradi   r3,r3,63
>   88:	7d 29 18 78 	andc    r9,r9,r3
>   8c:	79 23 00 4c 	rldimi  r3,r9,0,1
> 
> This sequence leaves r3 unmodified when it is below 0x8000000000000000
> and clamps it to 0x8000000000000000 if it is above.
> 

This comment looks wrong: the second instruction converts r3 to a
replicated sign bit of the address ((addr>0)?0:-1) if treating the
address as signed. After that the code only modifies the MSB of r3. So I
don't see how r3 could be unchanged from the original value...

OTOH, I believe the following 3 instructions sequence would work,
input address (a) in r3, scratch value (tmp) in r9, both intptr_t:

	sradi r9,r3,63	; tmp = (a >= 0) ? 0L : -1L;
	andc r3,r3,r9   ; a = a & ~tmp; (equivalently a = (a >= 0) ? a : 0)
	rldimi r3,r9,0,1 ; copy MSB of tmp to MSB of a 

But maybe I goofed...

Gabriel

 
 


