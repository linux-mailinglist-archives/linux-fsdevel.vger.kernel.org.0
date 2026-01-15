Return-Path: <linux-fsdevel+bounces-73910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7653D24069
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 11:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9523025A55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F18936E476;
	Thu, 15 Jan 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKNzmbfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07152362130
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474479; cv=none; b=hWidq5WiHKY2oEzBMo+WLxcTmPHI+5+QzhsMkR9m/fNEzBixEkAejuLMWrxiDRz4wq6zBinCYnjr6FBgX7iQ+FKt8hIJek+jC4fBH9Uxe6DqafWCpo/3z/O/2Mp+jkQu0XHzX5AZuXzDqGLUGwvFLCZlfucSXru8l2f4TqEo/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474479; c=relaxed/simple;
	bh=/1KAtvLvvLMpDi9CfvfFJ6x5SY4Jp+t4QyV0IUSlh0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbaM27BsE/1tml8MkGCo3Fb98+uKAG7R/GTW7Q1dTv9rofTrTVPudqGVELy5LjAI4kEGkJ321h16KAAeclQuf53FzREYLc40edRogXTuQgNKAowLMU9oKTN13En8HdaULGNSBUdSP+EBBbGwpNbxZCij0j1NepQ6eoGngvnZAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKNzmbfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823B3C19422
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768474478;
	bh=/1KAtvLvvLMpDi9CfvfFJ6x5SY4Jp+t4QyV0IUSlh0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QKNzmbfk137GH9cQf861KFuI/s73C1BD2S3Hmbu7L4olXN8PPEoplOGPC3Dn+Fghq
	 d7NNig4oWCpOSIeBtNStaJwz3bg7aVQZat7qFuMIPU0kjjV1Zxa7gbFsWnix0oDnv7
	 ZRKHmxfl/AQ8POyX8V98RhNoPE/yFC0oqIg1E0MtXDoMOAKelQtsVvb3FGZixoZivK
	 Rp7oq4fmbL4nC88WdaO1cINXanI8SNdp86XjdW3uyKEa9nEnZpVBxgV/GT7DBxWNJz
	 MGAMiMltUcK9PHqa/Jgmr9mFgqF0Q1rQRYaIL9ClhIG7TJqwK/Gl5opvhFbV6wah/U
	 wsGtLw2eFS8rQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b872b588774so115461766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 02:54:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYPIPQbyIAJio4lQTzo0cUetV9NM/D5MDoLJJJfg7kRRyTaCxBIWsBiAUShkteR62xGfKCp91DLdwaeWtR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vBd2x0cHyT5hCXYW7g7vC53dye8JxlJUwUkzM7NIXR7a8uTd
	ama4W7OZT2gPbj2wylThyLvvEE487P/fF8pqai8XU6qmOS48CHzUDCNHvflV+UCe0RLVkfHzHIy
	Sg6LWwS+99xrO+S25aS6/ueM4zzh59YQ=
X-Received: by 2002:a17:907:742:b0:b80:4103:537e with SMTP id
 a640c23a62f3a-b87614066e3mr530726366b.53.1768474476869; Thu, 15 Jan 2026
 02:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-2-kalyazin@amazon.com>
In-Reply-To: <20260114134510.1835-2-kalyazin@amazon.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 15 Jan 2026 18:54:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6S4bVdpwbER84-iwSE+bQrFu_gF=Ww-bCFxThJ7WiUwQ@mail.gmail.com>
X-Gm-Features: AZwV_QhNEeWPSp4pau3pJiv_muGT_zHnXI7A5fP4Fz_wHAvUMBfJQxrRqBdZrqI
Message-ID: <CAAhV-H6S4bVdpwbER84-iwSE+bQrFu_gF=Ww-bCFxThJ7WiUwQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] set_memory: add folio_{zap,restore}_direct_map helpers
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"prsampat@amd.com" <prsampat@amd.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, 
	"jmattson@google.com" <jmattson@google.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Nikita,

On Wed, Jan 14, 2026 at 9:45=E2=80=AFPM Kalyazin, Nikita <kalyazin@amazon.c=
o.uk> wrote:
>
> From: Nikita Kalyazin <kalyazin@amazon.com>
>
> These allow guest_memfd to remove its memory from the direct map.
> Only implement them for architectures that have direct map.
> In folio_zap_direct_map(), flush TLB on architectures where
> set_direct_map_valid_noflush() does not flush it internally.
>
> The new helpers need to be accessible to KVM on architectures that
> support guest_memfd (x86 and arm64).  Since arm64 does not support
> building KVM as a module, only export them on x86.
>
> Direct map removal gives guest_memfd the same protection that
> memfd_secret does, such as hardening against Spectre-like attacks
> through in-kernel gadgets.
>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  arch/arm64/include/asm/set_memory.h     |  2 ++
>  arch/arm64/mm/pageattr.c                | 12 ++++++++++++
>  arch/loongarch/include/asm/set_memory.h |  2 ++
>  arch/loongarch/mm/pageattr.c            | 16 ++++++++++++++++
>  arch/riscv/include/asm/set_memory.h     |  2 ++
>  arch/riscv/mm/pageattr.c                | 16 ++++++++++++++++
>  arch/s390/include/asm/set_memory.h      |  2 ++
>  arch/s390/mm/pageattr.c                 | 18 ++++++++++++++++++
>  arch/x86/include/asm/set_memory.h       |  2 ++
>  arch/x86/mm/pat/set_memory.c            | 20 ++++++++++++++++++++
>  include/linux/set_memory.h              | 10 ++++++++++
>  11 files changed, 102 insertions(+)
>
> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm=
/set_memory.h
> index 90f61b17275e..d949f1deb701 100644
> --- a/arch/arm64/include/asm/set_memory.h
> +++ b/arch/arm64/include/asm/set_memory.h
> @@ -14,6 +14,8 @@ int set_memory_valid(unsigned long addr, int numpages, =
int enable);
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
> +int folio_zap_direct_map(struct folio *folio);
> +int folio_restore_direct_map(struct folio *folio);
>  bool kernel_page_present(struct page *page);
>
>  int set_memory_encrypted(unsigned long addr, int numpages);
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index f0e784b963e6..a94eff324dda 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -357,6 +357,18 @@ int set_direct_map_valid_noflush(struct page *page, =
unsigned nr, bool valid)
>         return set_memory_valid(addr, nr, valid);
>  }
>
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                           folio_nr_pages(folio), false)=
;
> +}
> +
> +int folio_restore_direct_map(struct folio *folio)
> +{
> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                           folio_nr_pages(folio), true);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  /*
>   * This is - apart from the return value - doing the same
> diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/inc=
lude/asm/set_memory.h
> index 55dfaefd02c8..9bc80ac420a9 100644
> --- a/arch/loongarch/include/asm/set_memory.h
> +++ b/arch/loongarch/include/asm/set_memory.h
> @@ -18,5 +18,7 @@ bool kernel_page_present(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
> +int folio_zap_direct_map(struct folio *folio);
> +int folio_restore_direct_map(struct folio *folio);
>
>  #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> index f5e910b68229..14bd322dd112 100644
> --- a/arch/loongarch/mm/pageattr.c
> +++ b/arch/loongarch/mm/pageattr.c
> @@ -236,3 +236,19 @@ int set_direct_map_valid_noflush(struct page *page, =
unsigned nr, bool valid)
>
>         return __set_memory(addr, 1, set, clear);
>  }
> +
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +       int ret;
> +
> +       ret =3D set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                          folio_nr_pages(folio), false);
> +
> +       return ret;
Why not use a single statement which is the same as the ARM64 version?
The RISCV version has the same problem.

Huacai

> +}
> +
> +int folio_restore_direct_map(struct folio *folio)
> +{
> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                           folio_nr_pages(folio), true);
> +}
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm=
/set_memory.h
> index 87389e93325a..16557b70c830 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -43,6 +43,8 @@ static inline int set_kernel_memory(char *startp, char =
*endp,
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
> +int folio_zap_direct_map(struct folio *folio);
> +int folio_restore_direct_map(struct folio *folio);
>  bool kernel_page_present(struct page *page);
>
>  #endif /* __ASSEMBLER__ */
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 3f76db3d2769..2c218868114b 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -401,6 +401,22 @@ int set_direct_map_valid_noflush(struct page *page, =
unsigned nr, bool valid)
>         return __set_memory((unsigned long)page_address(page), nr, set, c=
lear);
>  }
>
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +       int ret;
> +
> +       ret =3D set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                          folio_nr_pages(folio), false);
> +
> +       return ret;
> +}
> +
> +int folio_restore_direct_map(struct folio *folio)
> +{
> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                           folio_nr_pages(folio), true);
> +}
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void=
 *data)
>  {
> diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/s=
et_memory.h
> index 94092f4ae764..fc73652e5715 100644
> --- a/arch/s390/include/asm/set_memory.h
> +++ b/arch/s390/include/asm/set_memory.h
> @@ -63,6 +63,8 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
> +int folio_zap_direct_map(struct folio *folio);
> +int folio_restore_direct_map(struct folio *folio);
>  bool kernel_page_present(struct page *page);
>
>  #endif
> diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
> index d3ce04a4b248..df4a487b484d 100644
> --- a/arch/s390/mm/pageattr.c
> +++ b/arch/s390/mm/pageattr.c
> @@ -412,6 +412,24 @@ int set_direct_map_valid_noflush(struct page *page, =
unsigned nr, bool valid)
>         return __set_memory((unsigned long)page_to_virt(page), nr, flags)=
;
>  }
>
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +       unsigned long addr =3D (unsigned long)folio_address(folio);
> +       int ret;
> +
> +       ret =3D set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                          folio_nr_pages(folio), false);
> +       flush_tlb_kernel_range(addr, addr + folio_size(folio));
> +
> +       return ret;
> +}
> +
> +int folio_restore_direct_map(struct folio *folio)
> +{
> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                           folio_nr_pages(folio), true);
> +}
> +
>  bool kernel_page_present(struct page *page)
>  {
>         unsigned long addr;
> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set=
_memory.h
> index 61f56cdaccb5..7208af609121 100644
> --- a/arch/x86/include/asm/set_memory.h
> +++ b/arch/x86/include/asm/set_memory.h
> @@ -90,6 +90,8 @@ int set_pages_rw(struct page *page, int numpages);
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
> +int folio_zap_direct_map(struct folio *folio);
> +int folio_restore_direct_map(struct folio *folio);
>  bool kernel_page_present(struct page *page);
>
>  extern int kernel_set_to_readonly;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 6c6eb486f7a6..3f0fc30eb320 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2656,6 +2656,26 @@ int set_direct_map_valid_noflush(struct page *page=
, unsigned nr, bool valid)
>         return __set_pages_np(page, nr);
>  }
>
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +       unsigned long addr =3D (unsigned long)folio_address(folio);
> +       int ret;
> +
> +       ret =3D set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                          folio_nr_pages(folio), false);
> +       flush_tlb_kernel_range(addr, addr + folio_size(folio));
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(folio_zap_direct_map, "kvm");
> +
> +int folio_restore_direct_map(struct folio *folio)
> +{
> +       return set_direct_map_valid_noflush(folio_page(folio, 0),
> +                                           folio_nr_pages(folio), true);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(folio_restore_direct_map, "kvm");
> +
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  void __kernel_map_pages(struct page *page, int numpages, int enable)
>  {
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index 3030d9245f5a..8d1c8a7f7d79 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -40,6 +40,16 @@ static inline int set_direct_map_valid_noflush(struct =
page *page,
>         return 0;
>  }
>
> +static inline int folio_zap_direct_map(struct folio *folio)
> +{
> +       return 0;
> +}
> +
> +static inline int folio_restore_direct_map(struct folio *folio)
> +{
> +       return 0;
> +}
> +
>  static inline bool kernel_page_present(struct page *page)
>  {
>         return true;
> --
> 2.50.1
>
>

