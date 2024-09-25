Return-Path: <linux-fsdevel+bounces-30054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD429856E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 12:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7035D1F20F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E8015DBAB;
	Wed, 25 Sep 2024 10:05:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3614AD19;
	Wed, 25 Sep 2024 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258738; cv=none; b=GV+wh+lXihvi/Qi+kR/xd0v/Jkf3IMMXddkBsJGci5n+uecigo29P1hGEO+b/TkNZgAqNyeMMWQ7IIECv2+rASpgyorZNxVv4QaleQUcYUUH0yf5wf30GE9AtfZ8qbfbpmAO1YX+RUz/eYFuCD8pedqPPEZQh6RE3lcOA9bshCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258738; c=relaxed/simple;
	bh=qGQI1uV9gNC0+wFAUvqgZd/1D5PbfUTEFlfPnBq4z74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3CqNewdwzYmZOrjtjj0eMBG/5PwdrY1ehWrMcLkM3YEhl7VDkIjspmNbyNjSSbuyvDk2Vda22Gfj6siCZUu6Kbpdkyx/EB9t1IphrEiRJPWijw6n51uTj4LXpm1EbUD+d9Oga4nfCtVFWq/Dk5TdDvJn1Dsb+fZrvg65+KyOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XDC664Lgnz9sSK;
	Wed, 25 Sep 2024 12:05:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdRuDw19ZA5l; Wed, 25 Sep 2024 12:05:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XDC663XQwz9sRr;
	Wed, 25 Sep 2024 12:05:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 66F1B8B76E;
	Wed, 25 Sep 2024 12:05:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id PJHxtpbIOOEt; Wed, 25 Sep 2024 12:05:34 +0200 (CEST)
Received: from [192.168.232.90] (PO27091.IDSI0.si.c-s.fr [192.168.232.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CBE218B763;
	Wed, 25 Sep 2024 12:05:33 +0200 (CEST)
Message-ID: <f40ea8bf-0862-41a7-af19-70bfbd838568@csgroup.eu>
Date: Wed, 25 Sep 2024 12:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] mm: Use pxdp_get() for accessing page table
 entries
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240917073117.1531207-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/09/2024 à 09:31, Anshuman Khandual a écrit :
> This series converts all generic page table entries direct derefences via
> pxdp_get() based helpers extending the changes brought in via the commit
> c33c794828f2 ("mm: ptep_get() conversion"). First it does some platform
> specific changes for m68k and x86 architecture.
> 
> This series has been build tested on multiple architecture such as x86,
> arm64, powerpc, powerpc64le, riscv, and m68k etc.

Seems like this series imply sub-optimal code with unnecessary reads.

Lets take a simple exemple : function mm_find_pmd() in mm/rmap.c

On a PPC32 platform (2 level pagetables):

Before the patch:

00001b54 <mm_find_pmd>:
     1b54:	80 63 00 18 	lwz     r3,24(r3)
     1b58:	54 84 65 3a 	rlwinm  r4,r4,12,20,29
     1b5c:	7c 63 22 14 	add     r3,r3,r4
     1b60:	4e 80 00 20 	blr

Here, the function reads mm->pgd, then calculates and returns a pointer 
to the PMD entry corresponding to the address.

After the patch:

00001b54 <mm_find_pmd>:
     1b54:	81 23 00 18 	lwz     r9,24(r3)
     1b58:	54 84 65 3a 	rlwinm  r4,r4,12,20,29
     1b5c:	7d 49 20 2e 	lwzx    r10,r9,r4	<= useless read
     1b60:	7c 69 22 14 	add     r3,r9,r4
     1b64:	7d 49 20 2e 	lwzx    r10,r9,r4	<= useless read
     1b68:	7d 29 20 2e 	lwzx    r9,r9,r4	<= useless read
     1b6c:	4e 80 00 20 	blr

Here, the function also reads mm->pgd and still calculates and returns a 
pointer to the PMD entry corresponding to the address. But in addition 
to that it reads three times that entry while doing nothing at all with 
the value read.

On PPC32, PMD/PUD/P4D are single entry tables folded into the 
corresponding PGD entry, it is therefore pointless to read the 
intermediate entries.

Christophe

