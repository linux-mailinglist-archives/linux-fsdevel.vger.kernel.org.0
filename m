Return-Path: <linux-fsdevel+bounces-68178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C0C55E64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 07:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A7C3BA94B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 06:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9A1316901;
	Thu, 13 Nov 2025 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K7kVmzXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EDA23EA8B;
	Thu, 13 Nov 2025 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014313; cv=none; b=O0CGwSU4TjUrOT1ZFrTnAZTRPgCJ3CvSBoILcW3C1H38JJjYSocLVMDcJByXD+8bv9uMQKHl6ss9LFEk+odPTsJ4MhxD/omsh0ZEir1mDiqHt4mcnqLeXUCrPOGwwrPfOvEH0b8eSP0MBwCcH+kdPpowtQn16SVdlI7+z7x09ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014313; c=relaxed/simple;
	bh=iCQS1gx6YMd7NWCCEwr+9lUwMRBm3bMMcxD1i35iNg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=panSPqyWwKlENZ7IxOo5IGjBiTujYLeMBep9rZy0l88EyPU/u3TmW6ajMT1rV9lRKEEh75nqWC4v70udU35HJ5nj8SgFisvWpGm1WS9WBjsGst7XHQjwlW5gnaCsXEr37DH5fJ+oRildjOCbLhGI5R/xwL+jum7qIBkOF0uJMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K7kVmzXE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACKBMBa022431;
	Thu, 13 Nov 2025 06:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JtOZ/d
	mz0spKmG8aZ1fFNGvOFsdNe4+rQ+N7TaW64ic=; b=K7kVmzXENpTAOs4cB0Vzsx
	vBmpdwyQ0sUXQVr2hcK6ZoHkD+LF8u/gNiy6olIJiQk+7PeUr79CVw5gEOosSOYe
	2CwaB7UkyRh/OelagtduAcZP/EGaaKcXbgQdYyR2ClWB6qkHXVNa2dp1JltAE/06
	OwcxGuhWLR55TWYQ/3d6mMD2oL7bTFuM0k4hRJBtwGZi47I+u3pys0yXcV8KPETf
	3W/p96A0Rb5bnQgqZ1iEA+COf0UQYATEQK4WxpVjarJ/OiSm0Rwyqz56A/w++lta
	76k4e1mQypJJ5E3KVnGCFixiy1BghrCddjT/Vx/hlRzxp+r5JIKt5avhhLzOQTjg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk3sge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 06:10:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AD6As3p011705;
	Thu, 13 Nov 2025 06:10:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk3sg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 06:10:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD4JFte014759;
	Thu, 13 Nov 2025 06:10:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpkc92f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 06:10:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD6Aqu030671376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 06:10:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B544058057;
	Thu, 13 Nov 2025 06:10:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 843E058058;
	Thu, 13 Nov 2025 06:10:44 +0000 (GMT)
Received: from [9.98.111.108] (unknown [9.98.111.108])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 06:10:44 +0000 (GMT)
Message-ID: <9f4e874a-89d0-4915-ac53-cf5449d9762b@linux.ibm.com>
Date: Thu, 13 Nov 2025 11:40:42 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] powerpc: Implement masked user access
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet
 <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <cover.1762427933.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HVKkNxiAx95Rq8CP36ofSk3CJYBVK6my
X-Proofpoint-ORIG-GUID: dgdJ4fXrU_mvZFiHm7cFP_2C6pdTVRM3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX4lpCBSV1cTL/
 gwJxVyQE+tTTZzL6R0egp/xZXaGMZN1L8r0JkR2Wgnb5rfUq7dRQ/b/2QTHBLQevRndGhpydvkx
 txg70WPnH6kM2X+k/cGoW4kJMDJCJ6hQtZwvBPeMT7mj+8W5aR9knFnspqiPadwYcl2e9cGmJ7L
 420jr32HT5TA+24dIv7sdQ/oLO5xT9Lg/i8hDsjaxCQiuBLPboKDiURJwCS8f8qHl/ibHzxEgb9
 VTJVk9U3grbyyAfjjR6eQFV9kElUu+RZSI2CGCtyuusBqu8y9yLOFOG2kt94xFKhyuzJekCbrEB
 /F65PGEQJIIZHOblh2TwAdSPRmMIS+aolp5MtsT9Vh/F3DLLlGiMLgSzsUROZ4nfpsWlRB+XPFt
 kG7crPwyUV2U5VxLNkthMWVojLZSfg==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=6915766e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=paD_15X78B_6zWkLfEcA:9 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099



On 11/6/25 5:01 PM, Christophe Leroy wrote:
> This is a rebase on top of commit 6ec821f050e2 (tag: core-scoped-uaccess)
> from tip tree.
> 
> Thomas, Peter, could you please take non-powerpc patches (1, 2, 3)
> in tip tree for v6.19, then Maddy will take powerpc patches (4-10)
> into powerpc-next for v6.20.

Thomas/Peter,

If you can please take non-powerpc patches in this series
in v6.19, I will park the rest of the series (4-10)
to the v6.20 merge.

Maddy

> 
> Masked user access avoids the address/size verification by access_ok().
> Allthough its main purpose is to skip the speculation in the
> verification of user address and size hence avoid the need of spec
> mitigation, it also has the advantage to reduce the amount of
> instructions needed so it also benefits to platforms that don't
> need speculation mitigation, especially when the size of the copy is
> not know at build time.
> 
> Patches 1,2,4 are cleaning up some redundant barrier_nospec()
> introduced by commit 74e19ef0ff80 ("uaccess: Add speculation barrier
> to copy_from_user()"). To do that, a speculation barrier is added to
> copy_from_user_iter() so that the barrier in powerpc raw_copy_from_user()
> which is redundant with the one in copy_from_user() can be removed. To
> avoid impacting x86, copy_from_user_iter() is first converted to using
> masked user access.
> 
> Patch 3 replaces wrong calls to masked_user_access_begin() with calls
> to masked_user_read_access_begin() and masked_user_write_access_begin()
> to match with user_read_access_end() and user_write_access_end().
> 
> Patches 5,6,7 are cleaning up powerpc uaccess functions.
> 
> Patches 8 and 9 prepare powerpc/32 for the necessary gap at the top
> of userspace.
> 
> Last patch implements masked user access.
> 
> Changes in v4:
> - Rebased on top of commit 6ec821f050e2 (tag: core-scoped-uaccess) from tip tree
> - Patch 3: Simplified as masked_user_read_access_begin() and masked_user_write_access_begin() are already there.
> - Patch 10: Simplified mask_user_address_simple() as suggested by Gabriel.
> 
> Changes in v3:
> - Rebased on top of v6.18-rc1
> - Patch 3: Impact on recently modified net/core/scm.c
> - Patch 10: Rewrite mask_user_address_simple() for a smaller result on powerpc64, suggested by Gabriel
> 
> Changes in v2:
> - Converted copy_from_user_iter() to using masked user access.
> - Cleaned up powerpc uaccess function to minimise code duplication
> when adding masked user access
> - Automated TASK_SIZE calculation to minimise use of BUILD_BUG_ON()
> - Tried to make some commit messages more clean based on feedback from
> version 1 of the series.
> 
> Christophe Leroy (10):
>   iter: Avoid barrier_nospec() in copy_from_user_iter()
>   uaccess: Add speculation barrier to copy_from_user_iter()
>   uaccess: Use masked_user_{read/write}_access_begin when required
>   powerpc/uaccess: Move barrier_nospec() out of
>     allow_read_{from/write}_user()
>   powerpc/uaccess: Remove unused size and from parameters from
>     allow_access_user()
>   powerpc/uaccess: Remove
>     {allow/prevent}_{read/write/read_write}_{from/to/}_user()
>   powerpc/uaccess: Refactor user_{read/write/}_access_begin()
>   powerpc/32s: Fix segments setup when TASK_SIZE is not a multiple of
>     256M
>   powerpc/32: Automatically adapt TASK_SIZE based on constraints
>   powerpc/uaccess: Implement masked user access
> 
>  arch/powerpc/Kconfig                          |   3 +-
>  arch/powerpc/include/asm/barrier.h            |   2 +-
>  arch/powerpc/include/asm/book3s/32/kup.h      |   3 +-
>  arch/powerpc/include/asm/book3s/32/mmu-hash.h |   5 +-
>  arch/powerpc/include/asm/book3s/32/pgtable.h  |   4 -
>  arch/powerpc/include/asm/book3s/64/kup.h      |   6 +-
>  arch/powerpc/include/asm/kup.h                |  52 +------
>  arch/powerpc/include/asm/nohash/32/kup-8xx.h  |   3 +-
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |   4 -
>  arch/powerpc/include/asm/nohash/kup-booke.h   |   3 +-
>  arch/powerpc/include/asm/task_size_32.h       |  28 +++-
>  arch/powerpc/include/asm/uaccess.h            | 132 +++++++++++++-----
>  arch/powerpc/kernel/asm-offsets.c             |   2 +-
>  arch/powerpc/kernel/head_book3s_32.S          |   6 +-
>  arch/powerpc/mm/book3s32/mmu.c                |   4 +-
>  arch/powerpc/mm/mem.c                         |   2 -
>  arch/powerpc/mm/nohash/8xx.c                  |   2 -
>  arch/powerpc/mm/ptdump/segment_regs.c         |   2 +-
>  lib/iov_iter.c                                |  22 ++-
>  lib/strncpy_from_user.c                       |   2 +-
>  lib/strnlen_user.c                            |   2 +-
>  net/core/scm.c                                |   2 +-
>  22 files changed, 161 insertions(+), 130 deletions(-)
> 


