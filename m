Return-Path: <linux-fsdevel+bounces-64813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A859FBF4C53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A356518C54FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1320226D4EF;
	Tue, 21 Oct 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iram.es header.i=@iram.es header.b="YpYVuGBx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-006a4e02.pphosted.com (mx07-006a4e02.pphosted.com [143.55.146.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB942224245;
	Tue, 21 Oct 2025 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.55.146.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029728; cv=none; b=LoaORVwXEiIWmDRcwdCLQvBTfkV5M5Z9g24NmgjPEK2Zty+gjH8uhpDDwxDdmJu30rsB02cLwuqV9Yv8wyf8zNSTRQJIB3WlIJKLHpJB8DxrZDEJVIKulnL1Dl8rTGh0M84VLTQhEI2WajVPra76MvzrB2rYRrhmDvpgb5EmcZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029728; c=relaxed/simple;
	bh=HMGdk3I075bK5E/gp9SATIQq1qBXSq91Oir+DGivIiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4fJ1vz/dMDfZ6fSERaYY86VUJyd1zbs/JlufaBjMqwZtOCBcMuvtWZXNH/wU8npIikjJYARc+G0CaXmV8B4BtBYYWPV0+SpcepLT4PU/9Tosrw2JyTPv4fTAJAcr7PVwylij9e1uUFKDwQT7wKou/qhGJCkHtTv96Olwi13Jkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iram.es; spf=pass smtp.mailfrom=iram.es; dkim=pass (2048-bit key) header.d=iram.es header.i=@iram.es header.b=YpYVuGBx; arc=none smtp.client-ip=143.55.146.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iram.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iram.es
Received: from pps.filterd (m0316690.ppops.net [127.0.0.1])
	by mx07-006a4e02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L63AQs1248592;
	Tue, 21 Oct 2025 08:34:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iram.es; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=dkim3; bh=F164kmUr5EMZ6e+BTntGiD39zV8R
	xXZwoRaGnCHEUKE=; b=YpYVuGBxuCwNJOQ3pBoy4A9ND5k7mRQOc+KGKrd42ih8
	OAXsKtgh51RKxIBPRqYFZZhxoqsJDsHSjdT+uBjxoUEETInGL/mkVbpDNQSh0jTi
	AINogUjyNJYUKHNOvirHoJmCRTw0E0AGyG1mEh2hfTH9ypTfEajsFBmTzWEW6AcI
	3cDOIJXKeNn4+YDr1ZUiqzADvthene2bFu72cXBErZFkYhcAwTd24ZD9nwGwRTu/
	6/0YkK7nru8rVpz30c/b25h17gRRIVulAV1foZlV1gIXNsVELI9YAVooBm+XaTJL
	kaMRQ+ZSe2o1We13qnamNjH/qaU+Hcfl/guzkqy5Wg==
Received: from mta-out02.sim.rediris.es (mta-out02.sim.rediris.es [130.206.24.44])
	by mx07-006a4e02.pphosted.com (PPS) with ESMTPS id 49wrkpfknq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:34:47 +0200 (MEST)
Received: from mta-out02.sim.rediris.es (localhost.localdomain [127.0.0.1])
	by mta-out02.sim.rediris.es (Postfix) with ESMTPS id 15B3914009E;
	Tue, 21 Oct 2025 08:34:47 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mta-out02.sim.rediris.es (Postfix) with ESMTP id DF9E7140FAD;
	Tue, 21 Oct 2025 08:34:46 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 mta-out02.sim.rediris.es
Received: from mta-out02.sim.rediris.es ([127.0.0.1])
 by localhost (mta-out02.sim.rediris.es [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 9cGW7RgyfRah; Tue, 21 Oct 2025 08:34:46 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy01.sim.rediris.es [130.206.24.69])
	by mta-out02.sim.rediris.es (Postfix) with ESMTPA id 2DFB114009E;
	Tue, 21 Oct 2025 08:34:45 +0200 (CEST)
Date: Tue, 21 Oct 2025 08:34:43 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 10/10] powerpc/uaccess: Implement masked user access
Message-ID: <aPcpg0lQUk0IhHvL@lt-gp.iram.es>
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
 <179dbcda9eb3bdc5d314c949047db6ef8fd8a2ee.1760529207.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179dbcda9eb3bdc5d314c949047db6ef8fd8a2ee.1760529207.git.christophe.leroy@csgroup.eu>
X-Authority-Analysis: v=2.4 cv=QvxTHFyd c=1 sm=1 tr=0 ts=68f72988 cx=c_pps
 a=N+btqqeLiyZkBSWNmht35Q==:117 a=N+btqqeLiyZkBSWNmht35Q==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pbnP-CYKNpT2arfVchsA:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: fPY5OWlvYhbiva90HCVVCXenrvtnOCXX
X-Proofpoint-GUID: fPY5OWlvYhbiva90HCVVCXenrvtnOCXX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA1MCBTYWx0ZWRfX2lPxlPelhpYO
 fKzNMXsOb4ELb/Gi1Q5qBO8bWlp8UOoMX00pFGk6ILvZghWaahLfwNY1BC8iutNisGPxbYKcfK5
 4MhDp3/ncePuRlR/rquIly1v6w2VvpjCqmMBBRwbC86Ke4g/JPasy6W84eYdQkoWsP1JdD0GNE4
 4w8bDukcBTT9KRN2Hwq+ouDLYqLo+b4eLMTzAvpwKaoTlBLi8+9N4ZR0+oAC0aiImf/KfuErwi2
 llnHe09xbNiWeHl8ok/ZcciYVmj2p82Vu/bg1rMmjKvAs9nmCQ94pQWKiv/nqhnpm5gTjuu9ch9
 08WPk+WA9Fx7B6JEMFzL2tsZJrphM8OT8ykb1U3ruJrsbXfnXvrJZqyBKRtX/wBu7SkUYv7uUd1
 T8qu9FfLEfoIX5vM8kLOIPLSRBhb7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=salida_notspam policy=salida score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510210050


Hi Christophe,

On Fri, Oct 17, 2025 at 12:21:06PM +0200, Christophe Leroy wrote:
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
> below, with a gap in-between. It leads to a 3 instructions sequence:
> 
>   20:	7c 69 fe 76 	sradi   r9,r3,63
>   24:	7c 69 48 78 	andc    r9,r3,r9
>   28:	79 23 00 4c 	rldimi  r3,r9,0,1
> 

Actually there is an even simpler (more obvious) sequence:

sradi r9,r3,63
srdi r9,r9,1  
andc r3,r3,r9

(the second instruction could also be clrldi r9,r9,1)

which translates back to C as:

[snipped]
> +static inline void __user *mask_user_address_simple(const void __user *ptr)
> +{
> +	unsigned long addr = (unsigned long)ptr;
> +	unsigned long sh = BITS_PER_LONG - 1;
> +	unsigned long mask = (unsigned long)((long)addr >> sh);
> +
> +	addr = ((addr & ~mask) & ((1UL << sh) - 1)) | ((mask & 1UL) << sh);
> +
> +	return (void __user *)addr;
> +}
> +

either (srdi):
	unsigned long mask = ((unsigned long)((long)addr >> sh)) >> 1;
or (clrldi):
	unsigned long mask = (unsigned long)(((long)addr >> sh) & LONG_MAX);

followed by:
	return (void __user *)(addr & ~ mask);

the result is the same but I find it easier to read, and it may be
easier for the compiler than to recognize an rl?imi insruction.

Cheers,
Gabriel

 


