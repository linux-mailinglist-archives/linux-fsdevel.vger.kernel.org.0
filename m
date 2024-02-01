Return-Path: <linux-fsdevel+bounces-9913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F21845EAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34F028A149
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B0463CA5;
	Thu,  1 Feb 2024 17:38:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2051984035;
	Thu,  1 Feb 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809095; cv=none; b=g4drrgKqdnKjPRy7dpXwPCz2MU05Q0sST+4QzQwm+SYIZ5ilnkzYJbuZaaTJ7wodPaM3dIeUvdcVwdtLCq0+avpf6aQ7J3tWQ6eYYbkdEw0w6EK4rcN6N9MAPJAIAipSS+QiH8Ex79VZ3rEQNjW4DPQySetCvbaYv1LuWT6ptq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809095; c=relaxed/simple;
	bh=jhs6/w/DeOvJUV7Jwr+kDKKldZRIn41+ZSTQPxuy7jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UriR61GQtfeMQsFi/bOhOO50Uu8TUPYiPxd9V/xOqflRYOyFHnNe/0kpcbqO4HIQzgvvIPvlBPIii979wLNJnkCOVwUCeL02WWUMkP4Ed+04kDMkfFaaMHnV40cUdAIn4XF2Zzjk4JDbQUmdzsQ/9cFwu5WibV25Yw9Venmpm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01D83DA7;
	Thu,  1 Feb 2024 09:38:55 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C163F738;
	Thu,  1 Feb 2024 09:38:07 -0800 (PST)
Date: Thu, 1 Feb 2024 17:38:04 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, vincenzo.frascino@arm.com, david@redhat.com,
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 30/35] arm64: mte: ptrace: Handle pages with
 missing tag storage
Message-ID: <ZbvW_HlrSMOpETlF@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-31-alexandru.elisei@arm.com>
 <30278898-c4b2-4dd6-ba68-a19575f81a65@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30278898-c4b2-4dd6-ba68-a19575f81a65@arm.com>

Hi,

On Thu, Feb 01, 2024 at 02:51:39PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > A page can end up mapped in a MTE enabled VMA without the corresponding tag
> > storage block reserved. Tag accesses made by ptrace in this case can lead
> > to the wrong tags being read or memory corruption for the process that is
> > using the tag storage memory as data.
> > 
> > Reserve tag storage by treating ptrace accesses like a fault.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> > 
> > Changes since rfc v2:
> > 
> > * New patch, issue reported by Peter Collingbourne.
> > 
> >  arch/arm64/kernel/mte.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index faf09da3400a..b1fa02dad4fd 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -412,10 +412,13 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> >  	while (len) {
> >  		struct vm_area_struct *vma;
> >  		unsigned long tags, offset;
> > +		unsigned int fault_flags;
> > +		struct page *page;
> > +		vm_fault_t ret;
> >  		void *maddr;
> > -		struct page *page = get_user_page_vma_remote(mm, addr,
> > -							     gup_flags, &vma);
> >  
> > +get_page:
> > +		page = get_user_page_vma_remote(mm, addr, gup_flags, &vma);
> 
> But if there is valid page returned here in the first GUP attempt, will there
> still be a subsequent handle_mm_fault() on the same vma and addr ?

Only if it's missing tag storage. If it's missing tag storage, the page has
been mapped as arch_fault_on_access_pte(), and
handle_mm_fault()->..->arch_handle_folio_fault_on_access() will either
reserve tag storage, or migrate it.

> 
> >  		if (IS_ERR(page)) {
> >  			err = PTR_ERR(page);
> >  			break;
> > @@ -433,6 +436,25 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> >  			put_page(page);
> >  			break;
> >  		}
> > +
> > +		if (tag_storage_enabled() && !page_tag_storage_reserved(page)) {
> 
> Should not '!page' be checked here as well ?

I was under the impression that get_user_page_vma_remote() returns an error
pointer if gup couldn't pin the page.

Thanks,
Alex

> 
> > +			fault_flags = FAULT_FLAG_DEFAULT | \
> > +				      FAULT_FLAG_USER | \
> > +				      FAULT_FLAG_REMOTE | \
> > +				      FAULT_FLAG_ALLOW_RETRY | \
> > +				      FAULT_FLAG_RETRY_NOWAIT;
> > +			if (write)
> > +				fault_flags |= FAULT_FLAG_WRITE;
> > +
> > +			put_page(page);
> > +			ret = handle_mm_fault(vma, addr, fault_flags, NULL);
> > +			if (ret & VM_FAULT_ERROR) {
> > +				err = -EFAULT;
> > +				break;
> > +			}
> > +			goto get_page;
> > +		}
> > +
> >  		WARN_ON_ONCE(!page_mte_tagged(page));
> >  
> >  		/* limit access to the end of the page */

