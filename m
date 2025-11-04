Return-Path: <linux-fsdevel+bounces-66885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E1C2F813
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 07:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA9D421181
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B02EAD0D;
	Tue,  4 Nov 2025 06:50:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698852DEA93;
	Tue,  4 Nov 2025 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239027; cv=none; b=gt+TTOYM7fQTdusqtsHumORxLYyDyvMJUQZ8I2s9ovULuA6HKZaYD30MftLNDtAR4C8qkmJu/IFZNyqTiKty3Qc64GsXKpKRgXgh3xVV/rlDlcLouNwVJPpUBV3rZ6DOaqxxdtayxloKaJaRlMOY0FRyz0j1x5dMgNOM5C78VEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239027; c=relaxed/simple;
	bh=FYQEunThMRncXDgZkVdnaOtP94z9pOVDBNVLUqLncPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttjSVyHDFB4g+ShkBpbxYMPqrap+20w2wUVKyWqe+06WE4r7VloQ1w2IQEBc8fQCgFLuhLxcm5Uh575XVsjfCWKjo6LzrjDNS/tcOhb/4Th4G34YBWbMDGGIK9KBIY/imaoqgNkrTr4KyDmBGctbgrDClhq5yKUDocz99exfkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d0zGM0Zbtz9sSh;
	Tue,  4 Nov 2025 07:35:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I4w3aEv5EITr; Tue,  4 Nov 2025 07:35:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d0zGL6PZFz9sSg;
	Tue,  4 Nov 2025 07:35:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C4D928B76C;
	Tue,  4 Nov 2025 07:35:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id fs4pJqTtKSTf; Tue,  4 Nov 2025 07:35:06 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C60B08B763;
	Tue,  4 Nov 2025 07:35:04 +0100 (CET)
Message-ID: <e0795f90-1030-4954-aefc-be137e9db49e@csgroup.eu>
Date: Tue, 4 Nov 2025 07:35:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 00/12] uaccess: Provide and use scopes for user access
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251027083700.573016505@linutronix.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251027083700.573016505@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/10/2025 à 09:43, Thomas Gleixner a écrit :
> This is a follow up on the V4 feedback:
> 
>     https://lore.kernel.org/20251022102427.400699796@linutronix.de
> 
> Changes vs. V4:
> 
>    - Rename get/put_user_masked() to get/put_user_inline()
> 
>    - Remove the futex helpers. Keep the inline get/put for now as it needs
>      more testing whether they are really valuable.
> 
>    - Picked up tags
> 
> The series is based on v6.18-rc1 and also available from git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git uaccess/scoped
> 

move_addr_to_user() in net/socket.c and put_cmsg() in net/core/scm.c 
should be converted as well

Christophe

> Thanks,
> 
> 	tglx
> ---
> Thomas Gleixner (12):
>        ARM: uaccess: Implement missing __get_user_asm_dword()
>        uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
>        x86/uaccess: Use unsafe wrappers for ASM GOTO
>        powerpc/uaccess: Use unsafe wrappers for ASM GOTO
>        riscv/uaccess: Use unsafe wrappers for ASM GOTO
>        s390/uaccess: Use unsafe wrappers for ASM GOTO
>        uaccess: Provide scoped user access regions
>        uaccess: Provide put/get_user_inline()
>        coccinelle: misc: Add scoped_masked_$MODE_access() checker script
>        futex: Convert to get/put_user_inline()
>        x86/futex: Convert to scoped user access
>        select: Convert to scoped user access
> 
>   arch/arm/include/asm/uaccess.h               |   26 ++
>   arch/powerpc/include/asm/uaccess.h           |    8
>   arch/riscv/include/asm/uaccess.h             |    8
>   arch/s390/include/asm/uaccess.h              |    4
>   arch/x86/include/asm/futex.h                 |   75 ++----
>   arch/x86/include/asm/uaccess.h               |   12 -
>   fs/select.c                                  |   12 -
>   include/linux/uaccess.h                      |  314 ++++++++++++++++++++++++++-
>   kernel/futex/core.c                          |    4
>   kernel/futex/futex.h                         |   58 ----
>   scripts/coccinelle/misc/scoped_uaccess.cocci |  108 +++++++++
>   11 files changed, 501 insertions(+), 128 deletions(-)
> 


