Return-Path: <linux-fsdevel+bounces-7853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F4582BACC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 06:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895391C24956
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 05:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699FA5B5CB;
	Fri, 12 Jan 2024 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdDTjYFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2995B5C0;
	Fri, 12 Jan 2024 05:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7cc92a83200so1438876241.3;
        Thu, 11 Jan 2024 21:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705037034; x=1705641834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jbg7j/o7TigrpbP9pCRChKmkHgg8XMfVY3M+Leeyjw=;
        b=cdDTjYFxFWNz7U2j47iGzhZfs6JzVF8Ddlt9Jt5OKuY+u6TOPc97DcigpDBZ87sNo0
         hpzN9qdOsIp6WgU4Zm9cBw8p4ubO5Jw2+1/egKk/b8mP4UuFKPkGvEVMzbomsw004yBN
         yBjaCcegYdd+3n2J06qd7rSraouQ8sHvFxxu92rxdGrsaiwYtiNXTJfaLebuZTL+g8ad
         12VhVJUgnPFAYeygWwZ0FW5/F6AH8nASb/j4qhsoxsoihjsheMuyesyqMlcgRuw77Kor
         tYUnAy0CXX4ELwBl7A1lzzlcURBr3qaKC8fbdQEEcAsTe7tBNQ/tICviXO+cf67ySRmM
         WmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705037034; x=1705641834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jbg7j/o7TigrpbP9pCRChKmkHgg8XMfVY3M+Leeyjw=;
        b=vrmaRK/hXEC/TC/rlK7MAr88LPWxWQwRgLNs8hwcdk2Cdz6+67b/X7DLaFRTcMMjl4
         a9izRLGkHu6XSe74u4qcAZ+vnJ3E5nbp7X1fAKMt8x1HcNKwXTXoVM/0cmHV1eY81RdK
         FftFHmUjhG5BByCjDQj5BfH5ZOJ1TrfeABPgY0tH0LNpGWX4qnrpTBftVJsnKTEsHSm6
         cMIaz3ObZbAFOZ8CRobNnH8+tv+Y6fCAEPBuw0F/j+K6wJ9nfmYLi3t9wwExK/qn/oC3
         PuUSej2ccVVaAQRnLC1FkqJoFuUJ/mfGCbokqPZ0wLzSVD/Gd+b8mUGOjwHijflBDsj4
         pK2g==
X-Gm-Message-State: AOJu0Ywx1xOJqTMUaEBtICfXJpssi0BdyM4JNJ0fJhfPDBp/5uBNvTcr
	bketpldX/g1zv7Wj+146GqUqbMcPyrDGmE+uYRI=
X-Google-Smtp-Source: AGHT+IGL5NibdB+VgWzXbVkI///6TjrjTVlE73BwT0RwBfRQYn6OOfT/CsGMEtgMADyRNcqDE8crQpKiCNt+P65LdmM=
X-Received: by 2002:a05:6102:4193:b0:468:151c:b018 with SMTP id
 cd19-20020a056102419300b00468151cb018mr472286vsb.14.1705037033413; Thu, 11
 Jan 2024 21:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111154106.3692206-1-ryan.roberts@arm.com>
In-Reply-To: <20240111154106.3692206-1-ryan.roberts@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Jan 2024 18:23:42 +1300
Message-ID: <CAGsJ_4wJogNK1Gi5aZNsz7KS4wDDLoXZpLcyOeEAqHft-eo9QA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm/filemap: Allow arch to request folio size for
 exec memory
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 4:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Change the readahead config so that if it is being requested for an
> executable mapping, do a synchronous read of an arch-specified size in a
> naturally aligned manner.
>
> On arm64 if memory is physically contiguous and naturally aligned to the
> "contpte" size, we can use contpte mappings, which improves utilization
> of the TLB. When paired with the "multi-size THP" changes, this works
> well to reduce dTLB pressure. However iTLB pressure is still high due to
> executable mappings having a low liklihood of being in the required
> folio size and mapping alignment, even when the filesystem supports
> readahead into large folios (e.g. XFS).
>
> The reason for the low liklihood is that the current readahead algorithm
> starts with an order-2 folio and increases the folio order by 2 every
> time the readahead mark is hit. But most executable memory is faulted in
> fairly randomly and so the readahead mark is rarely hit and most
> executable folios remain order-2. This is observed impirically and
> confirmed from discussion with a gnu linker expert; in general, the
> linker does nothing to group temporally accessed text together
> spacially. Additionally, with the current read-around approach there are
> no alignment guarrantees between the file and folio. This is
> insufficient for arm64's contpte mapping requirement (order-4 for 4K
> base pages).
>
> So it seems reasonable to special-case the read(ahead) logic for
> executable mappings. The trade-off is performance improvement (due to
> more efficient storage of the translations in iTLB) vs potential read
> amplification (due to reading too much data around the fault which won't
> be used), and the latter is independent of base page size. I've chosen
> 64K folio size for arm64 which benefits both the 4K and 16K base page
> size configs and shouldn't lead to any further read-amplification since
> the old read-around path was (usually) reading blocks of 128K (with the
> last 32K being async).
>
> Performance Benchmarking
> ------------------------
>
> The below shows kernel compilation and speedometer javascript benchmarks
> on Ampere Altra arm64 system. (The contpte patch series is applied in
> the baseline).
>
> First, confirmation that this patch causes more memory to be contained
> in 64K folios (this is for all file-backed memory so includes
> non-executable too):
>
> | File-backed folios      |   Speedometer   |  Kernel Compile |
> | by size as percentage   |-----------------|-----------------|
> | of all mapped file mem  | before |  after | before |  after |
> |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=
=3D|=3D=3D=3D=3D=3D=3D=3D=3D|
> |file-thp-aligned-16kB    |    45% |     9% |    46% |     7% |
> |file-thp-aligned-32kB    |     2% |     0% |     3% |     1% |
> |file-thp-aligned-64kB    |     3% |    63% |     5% |    80% |
> |file-thp-aligned-128kB   |    11% |    11% |     0% |     0% |
> |file-thp-unaligned-16kB  |     1% |     0% |     3% |     1% |
> |file-thp-unaligned-128kB |     1% |     0% |     0% |     0% |
> |file-thp-partial         |     0% |     0% |     0% |     0% |
> |-------------------------|--------|--------|--------|--------|
> |file-cont-aligned-64kB   |    16% |    75% |     5% |    80% |
>
> The above shows that for both use cases, the amount of file memory
> backed by 16K folios reduces and the amount backed by 64K folios
> increases significantly. And the amount of memory that is contpte-mapped
> significantly increases (last line).
>
> And this is reflected in performance improvement:
>
> Kernel Compilation (smaller is faster):
> | kernel   |   real-time |   kern-time |   user-time |   peak memory |
> |----------|-------------|-------------|-------------|---------------|
> | before   |        0.0% |        0.0% |        0.0% |          0.0% |
> | after    |       -1.6% |       -2.1% |       -1.7% |          0.0% |
>
> Speedometer (bigger is faster):
> | kernel   |   runs_per_min |   peak memory |
> |----------|----------------|---------------|
> | before   |           0.0% |          0.0% |
> | after    |           1.3% |          1.0% |
>
> Both benchmarks show a ~1.5% improvement once the patch is applied.

Hi Ryan,
you had the data regarding exec-cont-pte in cont-pte series[1], which has
already shown 1-2% improvement.

Kernel Compilation with -j8 (negative is faster):

| kernel                    | real-time | kern-time | user-time |
|---------------------------|-----------|-----------|-----------|
| baseline                  |      0.0% |      0.0% |      0.0% |
| mTHP                      |     -4.6% |    -38.0% |     -0.4% |
| mTHP + contpte            |     -5.4% |    -37.7% |     -1.3% |
| mTHP + contpte + exefolio |     -7.4% |    -39.5% |     -3.5% |

Kernel Compilation with -j80 (negative is faster):

| kernel                    | real-time | kern-time | user-time |
|---------------------------|-----------|-----------|-----------|
| baseline                  |      0.0% |      0.0% |      0.0% |
| mTHP                      |     -4.9% |    -36.1% |     -0.2% |
| mTHP + contpte            |     -5.8% |    -36.0% |     -1.2% |
| mTHP + contpte + exefolio |     -6.8% |    -37.0% |     -3.1% |

Speedometer (positive is faster):

| kernel                    | runs_per_min |
|:--------------------------|--------------|
| baseline                  |         0.0% |
| mTHP                      |         1.5% |
| mTHP + contpte            |         3.7% |
| mTHP + contpte + exefolio |         4.9% |


Is this 1.5% you are saying now an extra improvement after you have
mTHP + contpte + exefolio in [1]?

[1] https://lore.kernel.org/linux-mm/20231218105100.172635-1-ryan.roberts@a=
rm.com/

>
> Alternatives
> ------------
>
> I considered (and rejected for now - but I anticipate this patch will
> stimulate discussion around what the best approach is) alternative
> approaches:
>
>   - Expose a global user-controlled knob to set the preferred folio
>     size; this would move policy to user space and allow (e.g.) setting
>     it to PMD-size for even better iTLB utilizaiton. But this would add
>     ABI, and I prefer to start with the simplest approach first. It also
>     has the downside that a change wouldn't apply to memory already in
>     the page cache that is in active use (e.g. libc) so we don't get the
>     same level of utilization as for something that is fixed from boot.
>
>   - Add a per-vma attribute to allow user space to specify preferred
>     folio size for memory faulted from the range. (we've talked about
>     such a control in the context of mTHP). The dynamic loader would
>     then be responsible for adding the annotations. Again this feels
>     like something that could be added later if value was demonstrated.
>
>   - Enhance MADV_COLLAPSE to collapse to THP sizes less than PMD-size.
>     This would still require dynamic linker involvement, but would
>     additionally neccessitate a copy and all memory in the range would
>     be synchronously faulted in, adding to application load time. It
>     would work for filesystems that don't support large folios though.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> Hi all,
>
> I originally concocted something similar to this, with Matthew's help, as=
 a
> quick proof of concept hack. Since then I've tried a few different approa=
ches
> but always came back to this as the simplest solution. I expect this will=
 raise
> a few eyebrows but given it is providing a real performance win, I hope w=
e can
> converge to something that can be upstreamed.
>
> This depends on my contpte series to actually set the contiguous bit in t=
he page
> table.
>
> Thanks,
> Ryan
>
>
>  arch/arm64/include/asm/pgtable.h | 12 ++++++++++++
>  include/linux/pgtable.h          | 12 ++++++++++++
>  mm/filemap.c                     | 19 +++++++++++++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index f5bf059291c3..8f8f3f7eb8d8 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1143,6 +1143,18 @@ static inline void update_mmu_cache_range(struct v=
m_fault *vmf,
>   */
>  #define arch_wants_old_prefaulted_pte  cpu_has_hw_af
>
> +/*
> + * Request exec memory is read into pagecache in at least 64K folios. Th=
e
> + * trade-off here is performance improvement due to storing translations=
 more
> + * effciently in the iTLB vs the potential for read amplification due to=
 reading
> + * data from disk that won't be used. The latter is independent of base =
page
> + * size, so we set a page-size independent block size of 64K. This size =
can be
> + * contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB en=
try),
> + * and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base page=
s are in
> + * use.
> + */
> +#define arch_wants_exec_folio_order(void) ilog2(SZ_64K >> PAGE_SHIFT)
> +
>  static inline bool pud_sect_supported(void)
>  {
>         return PAGE_SIZE =3D=3D SZ_4K;
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 170925379534..57090616d09c 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -428,6 +428,18 @@ static inline bool arch_has_hw_pte_young(void)
>  }
>  #endif
>
> +#ifndef arch_wants_exec_folio_order
> +/*
> + * Returns preferred minimum folio order for executable file-backed memo=
ry. Must
> + * be in range [0, PMD_ORDER]. Negative value implies that the HW has no
> + * preference and mm will not special-case executable memory in the page=
cache.
> + */
> +static inline int arch_wants_exec_folio_order(void)
> +{
> +       return -1;
> +}
> +#endif
> +
>  #ifndef arch_check_zapped_pte
>  static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
>                                          pte_t pte)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 67ba56ecdd32..80a76d755534 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3115,6 +3115,25 @@ static struct file *do_sync_mmap_readahead(struct =
vm_fault *vmf)
>         }
>  #endif
>
> +       /*
> +        * Allow arch to request a preferred minimum folio order for exec=
utable
> +        * memory. This can often be beneficial to performance if (e.g.) =
arm64
> +        * can contpte-map the folio. Executable memory rarely benefits f=
rom
> +        * read-ahead anyway, due to its random access nature.
> +        */
> +       if (vm_flags & VM_EXEC) {
> +               int order =3D arch_wants_exec_folio_order();
> +
> +               if (order >=3D 0) {
> +                       fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
> +                       ra->size =3D 1UL << order;
> +                       ra->async_size =3D 0;
> +                       ractl._index &=3D ~((unsigned long)ra->size - 1);
> +                       page_cache_ra_order(&ractl, ra, order);
> +                       return fpin;
> +               }
> +       }
> +
>         /* If we don't want any read-ahead, don't bother */
>         if (vm_flags & VM_RAND_READ)
>                 return fpin;
> --
> 2.25.1
>

Thanks
barry

