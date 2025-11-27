Return-Path: <linux-fsdevel+bounces-70007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4FC8E122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B334E4E5DAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1932C93C;
	Thu, 27 Nov 2025 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3uTzexq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB032BF25
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243565; cv=none; b=EDy+h0rPFl163DerN/TrB53LNmtXTzEKmZELIKoTo+Egm6c3b7voyHjBSA5voeoEIrW+HcEWLF2ldkhFgWqyJUXTwZsgT0ofTEnD+0ncLPINHzlkjc6hQmDtIx+szxck9/Yq6kHS6KCl7zFeWC2pDU0FYrZ0A4qCgvPzZ0AoYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243565; c=relaxed/simple;
	bh=VmYFJVGbSNiRXH1yQ3UAeHylPpQU5o+0M5eUQPT/G+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/RhjsaL96XdhHCfQvdtn0XqVz4V4zjCW65/s6iaNT1U0RYdB9//eK+5T0xkJiBCGFHPGXwz4Oi0DIKH+16xOKpK0kTBqVfDdI3Sur5GPnvTkvG6FiaToHHNwK5SE8yxoTfBcyAlOVz3inpLMRsGyVGvRL8n9H60fJSlbTsLKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3uTzexq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2da83f721so83981285a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 03:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764243562; x=1764848362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTgQXrnGbp8yRV1ffH5aOGb73MnxpAvx9lMPfkiZ/pE=;
        b=O3uTzexqsI0MjNTP1s7+4J7RRJWLCE/mWBMPtLG9utwDkbNFO+iB44IT8durRdFmHG
         lSOCiAM8ChzskDJfeR9s6GA76rYhsOqD2wjEDguoHiJNfXtcrG8v6h8mKSCDuvCgSPIN
         L5Gyp1VsSVIzFsn6wHDPt0jgdcyT4RBU5grXy6Obud3X1dLuXbr/ex0ZKtDs5fITL3z0
         yeW5KVKVwr3FIs96cXG9Sc/rWQHISeXjAfGW7S+8AFQfjcBg+VIcAwFXOayI7EwmiC2y
         YQms1qFwMwBpah0rcaMSzN2n8XioDN51rIDgDE/55gRNnGk7FqAp5pIGWGYtUbzIKVel
         1f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764243562; x=1764848362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTgQXrnGbp8yRV1ffH5aOGb73MnxpAvx9lMPfkiZ/pE=;
        b=PnGMFjidUgvfTb34w3PFqz/s0yTYVCYC7B6OCEC5rfAJUG6RAWjgTQOrw+s/5w0YHM
         Zge5mePlnjEl/1AR/2tR5ybAzqZEDgQI0nAZDtYe/0fCj9b0vr5wkrThHF64noYbWam4
         09YqRLEF/xEtKeuFiA69Xb7WCmw4Yi3xWuZ8UxeZXYg+192s/leCqJZ/VeaLyPngOSz4
         XAQrYKIIhzlUlEhz9LoKGinfpV1VspYPS6aQjnr1UqtM3qd9T+EJy1oWFQK0gi70Zehi
         6bW0rhLbZVqv9o9wm54c1NbQROSNbuMIE9eDi5DHhcIDC6ZEty8uavrs3qHdjNZHZDdl
         kF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmh7PQtXGBwc3gJDZB/CfZQfrYBfYWF7tVbITZLM4aq0iIz2lAJ7QBR7zXEKKCp9JwC/yeqUfsL5AGMhDN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XiwZQxkibPzKirUvT2eA9upmuZphHZDrXj4vMJAwlFff4hUN
	3BIj4/jj0PRP+yS9T0RYD1wk22oJ+4seOCKruRFbQSVdu1W3SeELjJOzKzAc8UbbHv9I/aH5uc3
	lnEPqTBsVHniXSPlsfsfHeWiOe5WWzOg=
X-Gm-Gg: ASbGnctGPD+SBjrIf8lA7ynD/zW2npQdR5y2Jeeab+7/dRL8uyCSSux2OQqNr/tZJ4N
	/178MXbAtDAJyun2HwFYnwUXyRKsvhIT/fkYxfk+XLnXqrT00GVRdJWf6nm3RjWrxeuvcEBozeg
	/SMF6Gyq8TR0kWjdja2npC52W027stwSbqJYR3QnIT9VuBdYkzVyAuegDIzHOGGCoceHWPuf9u6
	80YxXMHi92ZN488ga0VjVqrqtj8fCh7/as1OaDjvVW0OhlXMq5posDmzMpwVnQcz7kb+Q==
X-Google-Smtp-Source: AGHT+IF8AX3QuwU8PWoyMHubrE0YEf7OwwbSbZImelOgI0KoQ85t34HoENkNaCeescbBRgk60ctOqyrcZAkFR1pI8MI=
X-Received: by 2002:a05:620a:4094:b0:8b2:3484:8e22 with SMTP id
 af79cd13be357-8b32a8d7accmr3051143885a.0.1764243562227; Thu, 27 Nov 2025
 03:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127011438.6918-1-21cnbao@gmail.com> <20251127011438.6918-2-21cnbao@gmail.com>
 <5by7tko4v3kqvvpu4fdsgpw42yl5ed5qisbaz3la4an52hq4j2@v75fagey6gva>
In-Reply-To: <5by7tko4v3kqvvpu4fdsgpw42yl5ed5qisbaz3la4an52hq4j2@v75fagey6gva>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 27 Nov 2025 19:39:11 +0800
X-Gm-Features: AWmQ_bmMHpk-p6E2I_jCY1Xqg4XmWm0x9ikXHEjIDdMSrcjAo4PIsH4k_44adgY
Message-ID: <CAGsJ_4xQKARuEuhrVuV+WmBC7+NCNd==Zi9nGmze5mfSjF1kdw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mm/filemap: Retry fault by VMA lock if the lock
 was released for I/O
To: Pedro Falcato <pfalcato@suse.de>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	Oven Liyang <liyangouwen1@oppo.com>, Russell King <linux@armlinux.org.uk>, 
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
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Rutland <mark.rutland@arm.com>, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Robin Murphy <robin.murphy@arm.com>, 
	=?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@arm.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Wentao Guan <guanwentao@uniontech.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Nam Cao <namcao@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:52=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Thu, Nov 27, 2025 at 09:14:37AM +0800, Barry Song wrote:
> > From: Oven Liyang <liyangouwen1@oppo.com>
> >
> > If the current page fault is using the per-VMA lock, and we only releas=
ed
> > the lock to wait for I/O completion (e.g., using folio_lock()), then wh=
en
> > the fault is retried after the I/O completes, it should still qualify f=
or
> > the per-VMA-lock path.
> >
> <snip>
> > Signed-off-by: Oven Liyang <liyangouwen1@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  arch/arm/mm/fault.c       | 5 +++++
> >  arch/arm64/mm/fault.c     | 5 +++++
> >  arch/loongarch/mm/fault.c | 4 ++++
> >  arch/powerpc/mm/fault.c   | 5 ++++-
> >  arch/riscv/mm/fault.c     | 4 ++++
> >  arch/s390/mm/fault.c      | 4 ++++
> >  arch/x86/mm/fault.c       | 4 ++++
>
> If only we could unify all these paths :(

Right, it=E2=80=99s a pain, but we do have bots for that?
And it=E2=80=99s basically just copy-and-paste across different architectur=
es.

>
> >  include/linux/mm_types.h  | 9 +++++----
> >  mm/filemap.c              | 5 ++++-
> >  9 files changed, 39 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index b71625378ce3..12b2d65ef1b9 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1670,10 +1670,11 @@ enum vm_fault_reason {
> >       VM_FAULT_NOPAGE         =3D (__force vm_fault_t)0x000100,
> >       VM_FAULT_LOCKED         =3D (__force vm_fault_t)0x000200,
> >       VM_FAULT_RETRY          =3D (__force vm_fault_t)0x000400,
> > -     VM_FAULT_FALLBACK       =3D (__force vm_fault_t)0x000800,
> > -     VM_FAULT_DONE_COW       =3D (__force vm_fault_t)0x001000,
> > -     VM_FAULT_NEEDDSYNC      =3D (__force vm_fault_t)0x002000,
> > -     VM_FAULT_COMPLETED      =3D (__force vm_fault_t)0x004000,
> > +     VM_FAULT_RETRY_VMA      =3D (__force vm_fault_t)0x000800,
>
> So, what I am wondering here is why we need one more fault flag versus
> just blindly doing this on a plain-old RETRY. Is there any particular
> reason why? I can't think of one.

Because in some cases we retry simply due to needing to take mmap_lock.
For example:

/**
 * __vmf_anon_prepare - Prepare to handle an anonymous fault.
 * @vmf: The vm_fault descriptor passed from the fault handler.
 *
 * When preparing to insert an anonymous page into a VMA from a
 * fault handler, call this function rather than anon_vma_prepare().
 * If this vma does not already have an associated anon_vma and we are
 * only protected by the per-VMA lock, the caller must retry with the
 * mmap_lock held.  __anon_vma_prepare() will look at adjacent VMAs to
 * determine if this VMA can share its anon_vma, and that's not safe to
 * do with only the per-VMA lock held for this VMA.
 *
 * Return: 0 if fault handling can proceed.  Any other value should be
 * returned to the caller.
 */
vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
{
...
}

Thus, we have to check each branch one by one, but I/O wait is the most
frequent path, so we handle it first.

>
> I would also like to see performance numbers.

Yes. From what I understand, this patchset should improve performance in a
fairly straightforward way.
But yes, I can certainly include some data in v2.

>
> The rest of the patch looks OK to me.

Thanks
Barry

