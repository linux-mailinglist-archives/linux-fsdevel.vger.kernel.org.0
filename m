Return-Path: <linux-fsdevel+bounces-69960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29CC8CCC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192433B1F02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 04:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B342D8DB8;
	Thu, 27 Nov 2025 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maG/SUC3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5229B799
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764217351; cv=none; b=WrZ/p8BDVR8pxNvVKTOuj9OxKGFbOJWVFHGYRFXNlwq9o8BOKSnGbvU6rAZ8Vdax4UzyZ0YdfhZbQp6EYF0sDyyZvNJevpqFWcLmPuaafGvTinUacrRVwGzKBrEN2rxmUF0jkP2SsFzQJv7gS7dHAmMslvgTFqUSII1U4vH0oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764217351; c=relaxed/simple;
	bh=2mT8NkA8n4pI7iGhBuPOIC9L/ZbQrFHsOpjeHsUJ+lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7tU7tOAz3X9WYuf5qWLckqSdyQl2tXJkY07Ddj1bsYjqp+McARvwreomHIrh892RzFjy0yD8e8OOSfYPO4UFWr2OIX0mplIMnhOvz46C1279G0S7Zg2970BRR+IzwWWKy+ZpQfKANaSquz5FKFcw7cFzuI7bq3OTrnD7JNVj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maG/SUC3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b22624bcdaso51142885a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 20:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764217349; x=1764822149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBY2hGlp5xDNa7Ek85Hj92aNDRHVnR99QGNyQtFdIz8=;
        b=maG/SUC3rwijxOP4dhtgqIP/986auH09v/q3a5WlrWZalaszqlzOwgcTsORilpmzVs
         YZLjfMwt8PFV25oHG4lEFKpu2W5aIecDStgF4k/tSuQIebkaGaCMNWDFhATvvUxhGNWn
         XWv+0vfNZW4Y57MGEv/d27cnP+EThjK+6qcmJT2AHx+k2Yh3b7p5k/SbX5i3XDB7UmF5
         g1YLRauSIXd6yodcZJs59+jNJYt6aFbIPxA8HRKms+f3hOaA062MoasKGUd2yQuBPEo9
         MCZcRElDilMCifRB7jYSnY8Tr2MtOcP1Cm3GdK+4ZWRtKDybbQXJxXZAuABzLErAPG1z
         KrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764217349; x=1764822149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBY2hGlp5xDNa7Ek85Hj92aNDRHVnR99QGNyQtFdIz8=;
        b=B4U1jpyYuaguQewpSer+h0/ElxcwAIdzPgCCDjEFy7+lBtacpH847boyrKZF/ez/RE
         vNfFWpuowC/u7XonH9NEIw3zEvyKnkoAXRVUHZ8g+r58dqjq3KtCFhHJf5Z23kKSozoi
         n/7l5dDU+cJtCJSRsUkU8DYcikR4dO4fx5Dl2DMgRchIwE7LQ1oxB6rQc/l68i3tSyCJ
         TdMGhrl0wdCsp7+DHaR6wShLI+XotY5tRpcRaAGAFJQPlBCp0E1Sw9yAJRardgl6JKev
         MevzVAjQ0cVzZLmFSBHNV8ZUHwE+NNN9aECa0GjhVKDCZbnkduBGfk7rh6sWR+3RLEsn
         SXXw==
X-Forwarded-Encrypted: i=1; AJvYcCVwqkQLBI8yL8lInvjlv1Pl67yF/u2276y0rQist+XmuD+WWHB/7kwgkfvK7WYM6c6FPXc0fgtKF7vs0+sL@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjDzS2b7hdKioUjksjrL4BasgpgC/NrmRmyLT3eYvTXQzQdKV
	OY715GVlIU4x9ZeKIKMrxMfQPu/EJOyerr0MVqI86WrYiZOtu4Tkx8FS4p/PdrwqVXYEX+mbfak
	bIynTuhvxLf2Ajvb/I/X1T01GuonQJ2k=
X-Gm-Gg: ASbGncu+BpKD2pg0hMT8++uFiWBRRdcDfOrnPrRKqrO5Tg+Pj8Hme0ooTK4UliM6gaJ
	RNntsdkTaquLPTIrRxaaMmDhkwJf0QI3hV9J+gJCtgq3j+D+COORVwiFRnFKcM0ldAqO1GMo1r/
	Kp6heZnDx2FYnany7fMP2wlJtRfT2MpVxGG58mxPBrd3kx5aGZG4qo76AhRbULlNMUnOH7nLVQt
	8+l/aUIRx2KfPkNpjJaOtFwA9ENmvk8vCSLCT7FszPCVOzHdLx/BgOHmHeD18GW9HPnspLPgmrA
	mceS
X-Google-Smtp-Source: AGHT+IF/2OHEG3LUgPMXOJw4DDaFf/N1kDbkxj4PlQ+jOCs1AfpUOxHzVBEY8oHxETzeiPPKmtGSMi/k9qIz1abldeY=
X-Received: by 2002:a05:620a:44d4:b0:8b2:f9ac:a893 with SMTP id
 af79cd13be357-8b33d49a4c6mr3106281485a.66.1764217348492; Wed, 26 Nov 2025
 20:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127011438.6918-1-21cnbao@gmail.com> <aSfO7fA-04SBtTug@casper.infradead.org>
In-Reply-To: <aSfO7fA-04SBtTug@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 27 Nov 2025 12:22:16 +0800
X-Gm-Features: AWmQ_bnJyCR-GwS1_fTaB2mJ8nbB2MiVvoC0dBi_6l0nwDIR-Nl2i2LJsMX4LWo
Message-ID: <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Pedro Falcato <pfalcato@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Oven Liyang <liyangouwen1@oppo.com>, Mark Rutland <mark.rutland@arm.com>, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	=?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@arm.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Wentao Guan <guanwentao@uniontech.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Nam Cao <namcao@linutronix.de>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 12:09=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Nov 27, 2025 at 09:14:36AM +0800, Barry Song wrote:
> > There is no need to always fall back to mmap_lock if the per-VMA
> > lock was released only to wait for pagecache or swapcache to
> > become ready.
>
> Something I've been wondering about is removing all the "drop the MM
> locks while we wait for I/O" gunk.  It's a nice amount of code removed:

I think the point is that page fault handlers should avoid holding the VMA
lock or mmap_lock for too long while waiting for I/O. Otherwise, those
writers and readers will be stuck for a while.

>
>  include/linux/pagemap.h |  8 +---
>  mm/filemap.c            | 98 ++++++++++++-------------------------------=
------
>  mm/internal.h           | 21 -----------
>  mm/memory.c             | 13 +------
>  mm/shmem.c              |  6 ---
>  5 files changed, 27 insertions(+), 119 deletions(-)
>
> and I'm not sure we still need to do it with per-VMA locks.  What I
> have here doesn't boot and I ran out of time to debug it.

I agree there=E2=80=99s room for improvement, but merely removing the "drop=
 the MM
locks while waiting for I/O" code is unlikely to improve performance.

For example, we could change the flow to:
1. Release the VMA lock or mmap_lock
2. Lock the folio
3. Re-acquire the VMA lock or mmap_lock
4. Re-check whether we can still map the PTE
5. Map the PTE

Currently, the flow is always:

1. Release the VMA lock or mmap_lock
2. Lock the folio
3. Unlock the folio
4. Re-enter the page fault handling from the beginning

The change would be much more complex, so I=E2=80=99d prefer to land the cu=
rrent
patchset first. At least this way, we avoid falling back to mmap_lock and
causing contention or priority inversion, with minimal changes.

Thanks
Barry

