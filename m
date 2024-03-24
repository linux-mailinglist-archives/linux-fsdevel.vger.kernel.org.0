Return-Path: <linux-fsdevel+bounces-15172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D233887C3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 11:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D27281CCF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2701758D;
	Sun, 24 Mar 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5Soixto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA933F9;
	Sun, 24 Mar 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711276251; cv=none; b=R6MmdfUDNrBfliJdkk9vlL3aPDAqAcZhfvZeTniBwpU/A44xb7zkqbbRwa+cPJXiCtyi5i+EVBTpblpxIqsawMIvjsaoPLWLvUcOwy1OVAbFe2ne0tk+DPsA3EkP+lrLOqCy8fugRUTIJt1FBqDnIwLiJuIG6Kgcz7yOzDRKdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711276251; c=relaxed/simple;
	bh=i/KBVM/hVsILZHtcXZzSHp2NdrbsYCYNR/zIoJ3kBaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5BX+OK5GYKXy7ovRB6b9+08fhf3vdPOsbz8VIhlWMLNuvleO3w5/lt/FqHyBqJegcl1xe6pGui21KSdPjT3YVMSj0Ia/Hz5SJCg64I4s/JbWX56+et7/dV6/bBKYYJAbNIBa1vlUUIgHyvO0lI0rmY+QKaRwAkHHsjNfcUeebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5Soixto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211E3C433F1;
	Sun, 24 Mar 2024 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711276251;
	bh=i/KBVM/hVsILZHtcXZzSHp2NdrbsYCYNR/zIoJ3kBaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5SoixtoQOXDGlmn7h4qZyREMJ6mWoeIaoniDbaB8DYpPY4lP+Fk8FhR3xwxK1gz9
	 AM/JCXIvzOlhNa5wokIeF6+ZUWRYzPOvRYLye6bcgeNex82WYQCdM0mkSvmmmulpeV
	 THXt3BFrRP2WCMTz0ZPuCrEKPSW6KRibMppHqcY663WUZURlspcm5IiTZESzoAvUKw
	 VEMbUJukG4OZ5KnKIb4aQGbCwqGbOFfKBCaRQMeft13CXgUXLJHLDOWtKxvA52sQmr
	 OinKzNAeqGJ5VJwisWLebE4hjcZGDXK+8ygilZGv3N0ihFBq0TVZCouP+4OQOn1IfL
	 nOFBi5g8gWsKA==
Date: Sun, 24 Mar 2024 12:29:39 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, xingwei lee <xrivendell7@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	samsun1006219@gmail.com, syzkaller-bugs@googlegroups.com,
	linux-mm <linux-mm@kvack.org>
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
Message-ID: <ZgAAk4roqPaJ6gWF@kernel.org>
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
 <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com>
 <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
 <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com>
 <CAJfpegub5Ny9kyX+dDbRwx7kd6ZdxtOeQ9RTK8n=LGGSzA9iOQ@mail.gmail.com>
 <463612f2-5590-4fb3-8273-0d64c3fd3684@redhat.com>
 <a6632384-c186-4640-8b48-f40d6c4f7d1d@redhat.com>
 <dd3e28b3-647c-4657-9c3f-9778bb046799@redhat.com>
 <b40eb0b7-7362-4d19-95b3-e06435e6e09c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40eb0b7-7362-4d19-95b3-e06435e6e09c@redhat.com>

On Fri, Mar 22, 2024 at 10:56:08PM +0100, David Hildenbrand wrote:
> On 22.03.24 22:37, David Hildenbrand wrote:
> > On 22.03.24 22:33, David Hildenbrand wrote:
> > > On 22.03.24 22:18, David Hildenbrand wrote:
> > > > On 22.03.24 22:13, Miklos Szeredi wrote:
> > > > > On Fri, 22 Mar 2024 at 22:08, David Hildenbrand <david@redhat.com> wrote:
> > > > > > 
> > > > > > On 22.03.24 20:46, Miklos Szeredi wrote:
> > > > > > > On Fri, 22 Mar 2024 at 16:41, David Hildenbrand <david@redhat.com> wrote:
> > > > > > > 
> > > > > > > > But at least the vmsplice() just seems to work. Which is weird, because
> > > > > > > > GUP-fast should not apply (page not faulted in?)
> > > > > > > 
> > > > > > > But it is faulted in, and that indeed seems to be the root cause.
> > > > > > 
> > > > > > secretmem mmap() won't populate the page tables. So it's not faulted in yet.
> > > > > > 
> > > > > > When we GUP via vmsplice, GUP-fast should not find it in the page tables
> > > > > > and fallback to slow GUP.
> > > > > > 
> > > > > > There, we seem to pass check_vma_flags(), trigger faultin_page() to
> > > > > > fault it in, and then find it via follow_page_mask().
> > > > > > 
> > > > > > ... and I wonder how we manage to skip check_vma_flags(), or otherwise
> > > > > > managed to GUP it.
> > > > > > 
> > > > > > vmsplice() should, in theory, never succeed here.
> > > > > > 
> > > > > > Weird :/
> > > > > > 
> > > > > > > Improved repro:
> > > > > > > 
> > > > > > > #define _GNU_SOURCE
> > > > > > > 
> > > > > > > #include <fcntl.h>
> > > > > > > #include <unistd.h>
> > > > > > > #include <stdio.h>
> > > > > > > #include <errno.h>
> > > > > > > #include <sys/mman.h>
> > > > > > > #include <sys/syscall.h>
> > > > > > > 
> > > > > > > int main(void)
> > > > > > > {
> > > > > > >              int fd1, fd2;
> > > > > > >              int pip[2];
> > > > > > >              struct iovec iov;
> > > > > > >              char *addr;
> > > > > > >              int ret;
> > > > > > > 
> > > > > > >              fd1 = syscall(__NR_memfd_secret, 0);
> > > > > > >              addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
> > > > > > >              ftruncate(fd1, 7);
> > > > > > >              addr[0] = 1; /* fault in page */
> > > > > 
> > > > > Here the page is faulted in and GUP-fast will find it.  It's not in
> > > > > the kernel page table, but it is in the user page table, which is what
> > > > > matter for GUP.
> > > > 
> > > > Trust me, I know the GUP code very well :P
> > > > 
> > > > gup_pte_range -- GUP fast -- contains:
> > > > 
> > > > if (unlikely(folio_is_secretmem(folio))) {
> > > > 	gup_put_folio(folio, 1, flags);
> > > > 	goto pte_unmap;
> > > > }
> > > > 
> > > > So we "should" be rejecting any secretmem folios and fallback to GUP slow.
> > > > 
> > > > 
> > > > ... we don't check the same in gup_huge_pmd(), but we shouldn't ever see
> > > > THP in secretmem code.
> > > > 
> > > 
> > > Ehm:
> > > 
> > > [   29.441405] Secretmem fault: PFN: 1096177
> > > [   29.442092] GUP-fast: PFN: 1096177
> > > 
> > > 
> > > ... is folio_is_secretmem() broken?
> > > 
> > > ... is it something "obvious" like:
> > > 
> > > diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> > > index 35f3a4a8ceb1e..6996f1f53f147 100644
> > > --- a/include/linux/secretmem.h
> > > +++ b/include/linux/secretmem.h
> > > @@ -16,7 +16,7 @@ static inline bool folio_is_secretmem(struct folio *folio)
> > >             * We know that secretmem pages are not compound and LRU so we can
> > >             * save a couple of cycles here.
> > >             */
> > > -       if (folio_test_large(folio) || !folio_test_lru(folio))
> > > +       if (folio_test_large(folio) || folio_test_lru(folio))
> > >                    return false;
> > >            mapping = (struct address_space *)
> > 
> > ... yes, that does the trick!
> > 
> 
> Proper patch (I might send out again on Monday "officially"). There are
> other improvements we want to do to folio_is_secretmem() in the light of
> folio_fast_pin_allowed(), that I wanted to do a while ago. I might send
> a patch for that as well now that I'm at it.
 
The most robust but a bit slower solution is to make folio_is_secretmem()
call folio_mapping() rather than open code the check.

What improvements did you have in mind?
 
> From 85558a46d9f249f26bd77dd3b18d14f248464845 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Fri, 22 Mar 2024 22:45:36 +0100
> Subject: [PATCH] mm/secretmem: fix GUP-fast succeeding on secretmem folios
> 
> folio_is_secretmem() states that secretmem folios cannot be LRU folios:
> so we may only exit early if we find an LRU folio. Yet, we exit early if
> we find a folio that is not a secretmem folio.
>
> Consequently, folio_is_secretmem() fails to detect secretmem folios and,
> therefore, we can succeed in grabbing a secretmem folio during GUP-fast,
> crashing the kernel when we later try reading/writing to the folio, because
> the folio has been unmapped from the directmap.
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/secretmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index 35f3a4a8ceb1..6996f1f53f14 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -16,7 +16,7 @@ static inline bool folio_is_secretmem(struct folio *folio)
>  	 * We know that secretmem pages are not compound and LRU so we can
>  	 * save a couple of cycles here.
>  	 */
> -	if (folio_test_large(folio) || !folio_test_lru(folio))
> +	if (folio_test_large(folio) || folio_test_lru(folio))
>  		return false;
>  	mapping = (struct address_space *)
> -- 
> 2.43.2
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

