Return-Path: <linux-fsdevel+bounces-70049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 417A1C8F81F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B605A349BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E532D46B2;
	Thu, 27 Nov 2025 16:26:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF312C3253
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260799; cv=none; b=knPkUKb+HPLEFuTR6ObfBfDWLR8C0v/1UAmKUphQ9MoOsh7anr1wQG3QugkafKRF7qzdBWgTFWHZHIzilzFGmbIhts0TTnGyu1nUc2P7+nM6vnkvyHI6y2c7IALin5tqd1SqLKimo9SF0q4wSR4yqT0LDvqcaQPMbxBLuSTbB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260799; c=relaxed/simple;
	bh=pzeqql03IOqRYw2QFnOlDD1jswAd6lKoIUORmNt774Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf77agEikrDC4bK9OSgOuAO5ongZ9eGEOoLpX4NkQJpqqRPFTKG696j7ezW+rv64VknfbB6guJyb6yKuTYaqklgNVCNjv5hlAW6hEO0qXIY97HvA+/LteGgf6LfRbZp8OxPNRWf8jmL62Bvtu3yLoiSNMyyLODNQksiGSr4JHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBC9E2124F;
	Thu, 27 Nov 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DDE43EA63;
	Thu, 27 Nov 2025 16:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pdD/A7h7KGnRfwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 27 Nov 2025 16:26:32 +0000
Date: Thu, 27 Nov 2025 16:26:30 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	Oven Liyang <liyangouwen1@oppo.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Wentao Guan <guanwentao@uniontech.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Nam Cao <namcao@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [RFC PATCH 1/2] mm/filemap: Retry fault by VMA lock if the lock
 was released for I/O
Message-ID: <kzwpwntmta4bpt27stif2hs5cwlu54kayfi34o562jpr2mjbew@h3ddkbxibxhf>
References: <20251127011438.6918-1-21cnbao@gmail.com>
 <20251127011438.6918-2-21cnbao@gmail.com>
 <5by7tko4v3kqvvpu4fdsgpw42yl5ed5qisbaz3la4an52hq4j2@v75fagey6gva>
 <CAGsJ_4xQKARuEuhrVuV+WmBC7+NCNd==Zi9nGmze5mfSjF1kdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xQKARuEuhrVuV+WmBC7+NCNd==Zi9nGmze5mfSjF1kdw@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DBC9E2124F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Thu, Nov 27, 2025 at 07:39:11PM +0800, Barry Song wrote:
> On Thu, Nov 27, 2025 at 6:52 PM Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > On Thu, Nov 27, 2025 at 09:14:37AM +0800, Barry Song wrote:
> > > From: Oven Liyang <liyangouwen1@oppo.com>
> > >
> > > If the current page fault is using the per-VMA lock, and we only released
> > > the lock to wait for I/O completion (e.g., using folio_lock()), then when
> > > the fault is retried after the I/O completes, it should still qualify for
> > > the per-VMA-lock path.
> > >
> > <snip>
> > > Signed-off-by: Oven Liyang <liyangouwen1@oppo.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  arch/arm/mm/fault.c       | 5 +++++
> > >  arch/arm64/mm/fault.c     | 5 +++++
> > >  arch/loongarch/mm/fault.c | 4 ++++
> > >  arch/powerpc/mm/fault.c   | 5 ++++-
> > >  arch/riscv/mm/fault.c     | 4 ++++
> > >  arch/s390/mm/fault.c      | 4 ++++
> > >  arch/x86/mm/fault.c       | 4 ++++
> >
> > If only we could unify all these paths :(
> 
> Right, it’s a pain, but we do have bots for that?
> And it’s basically just copy-and-paste across different architectures.
> 
> >
> > >  include/linux/mm_types.h  | 9 +++++----
> > >  mm/filemap.c              | 5 ++++-
> > >  9 files changed, 39 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index b71625378ce3..12b2d65ef1b9 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -1670,10 +1670,11 @@ enum vm_fault_reason {
> > >       VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
> > >       VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
> > >       VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
> > > -     VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
> > > -     VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
> > > -     VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
> > > -     VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
> > > +     VM_FAULT_RETRY_VMA      = (__force vm_fault_t)0x000800,
> >
> > So, what I am wondering here is why we need one more fault flag versus
> > just blindly doing this on a plain-old RETRY. Is there any particular
> > reason why? I can't think of one.
> 
> Because in some cases we retry simply due to needing to take mmap_lock.
> For example:
> 
> /**
>  * __vmf_anon_prepare - Prepare to handle an anonymous fault.
>  * @vmf: The vm_fault descriptor passed from the fault handler.
>  *
>  * When preparing to insert an anonymous page into a VMA from a
>  * fault handler, call this function rather than anon_vma_prepare().
>  * If this vma does not already have an associated anon_vma and we are
>  * only protected by the per-VMA lock, the caller must retry with the
>  * mmap_lock held.  __anon_vma_prepare() will look at adjacent VMAs to
>  * determine if this VMA can share its anon_vma, and that's not safe to
>  * do with only the per-VMA lock held for this VMA.
>  *
>  * Return: 0 if fault handling can proceed.  Any other value should be
>  * returned to the caller.
>  */
> vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
> {
> ...
> }
> 
> Thus, we have to check each branch one by one, but I/O wait is the most
> frequent path, so we handle it first.
>

Hmm, right, good point. I think this is the safest option then.

FWIW:
Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

