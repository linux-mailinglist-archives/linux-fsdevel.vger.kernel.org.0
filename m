Return-Path: <linux-fsdevel+bounces-44010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE05A60B90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 09:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48ADF19C2D05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0A1A5BBF;
	Fri, 14 Mar 2025 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kBpm+0Qw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2E1A23B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940995; cv=none; b=kwLMtIN1eFX7BOrfAia21Hv7u+qrsqA5mY7eLk1F8vUDCLXVi8b2DzzaMMezshnRbk3s8w5h+jkvUphTA0hoI3vC/6mrLvx6bwca1qpMQ5u1wEk3cS+Ntlx2NC2krKI22Xr9NWo/+KmPnPWnZKPEcM8gkml6IbusKSnbiGElWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940995; c=relaxed/simple;
	bh=+VOeEyaaz4ETl+dZkiEVp7F2yseM43nsL5eCpvrqo2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awnZ3darCrcSl5bBBWaSkjmmJ2+zOLngegSdFNQjfPU5M4BzctZQkQSp04k8rOkCjASMfUAzW0FkIZi6Jc/DshMRzhgMYWiRBM4CrcAbkucji/Lcz+wgwtDz8a9SwXMbBF7ZnACTujF7iiB2T1Oj88jTiEXkjpC/JYiAZtM/XZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kBpm+0Qw; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85d9a87660fso152876239f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741940992; x=1742545792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG/NhetTUX73vAvkNoljifPvpPm7zk3dE/2sfnfhqPg=;
        b=kBpm+0QwTCd69Wj62PiurQ2Yy6o0svNz8PKoaAeyk2k1w0rvS9Tfg30CwdMu/HakHS
         iVMjx0mZEefGz7SyTwCghJFZ5bN7fGRKNjCDvKObR5HfUUCo86JVxW7un3MmfNAtLwut
         wnBC8h6VWP/pglAbWTaxYBOF2+zpHq7SAJ2GkvoIGoUYLR9mmF0U5XhJFBvGmUZeNDHL
         ulBNBq4jPuAeobA5nyPVaZwePeWdirNebt7qc7bXYwfPcYc5LSvy7zLoNFGGieUMgh3P
         eS/nep4o1EchXEUGb6DGVBQ/7Uun/DnrxGO6qn30vxSTTjeKYJ3/HzkYpGCErebJliO2
         DZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940992; x=1742545792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG/NhetTUX73vAvkNoljifPvpPm7zk3dE/2sfnfhqPg=;
        b=dSQVmglejrE4V3JR1CyKi0+DgzN8k0tI4ggtusZkzmpne1j25zIQ+Ay6RllmKgm42W
         VVu9+f76pra/A0x/obHXuwsGDJF+BLNk/3+9CJV8nF/G5pn73e5+ojeea/Sdsou4Ujwa
         irK82VyF6lRU9gmQuPaiCjx5yKL/wQGn15S2cIP4pQc9O978kxk6P+KBSWDKiaDqGj1A
         o32qhO7uztgFO9lqNMmhPVa+R31+rLVjH7Vy7OjgCRirrMNBKQdWQXIwtjXiuCLFkBuj
         +rGEEOo92TElaY/tnTlBIoPHStL+d1SsEbUHRSWqKtxvjV5JuPqVKYesIgczUZ9o1xZs
         9E3g==
X-Forwarded-Encrypted: i=1; AJvYcCVYrinzYHqcs0zsC+LT2y8MjIXrXJRhPduhnuEVN9DBRdNCXUgao+cqPpUOLmMiGVtS5L2x98zu6Pz9vlES@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1ptbrSuqTO1W/ddXVAMKSZJOH4ktmu5LUXjxAnyGwQBg0+9J
	7Ps+6VLB2wtg+rXQcpcAZdnLv+4gw/FDnv/EfDwxBXgQIR1WhMWc4s5KIMpMdaWYOJeiWnPXuND
	pfeimiZijeXnG+P00EcFDaKpAQ0HeYDrMQyHDdQ==
X-Gm-Gg: ASbGncuYgY1Owc0JY6OfhJ+BN8ofDWXm5O+kkBQ/yOXlw4jW793W0GTOcFt0r70MO3Q
	ehgc175AEBjnTrV+Ft8OGGdBf7dWdOzttg+t1cPhH1N3woEICJDWuQpx6KmCQdwFZPdqrSbnbWV
	3BeH0vZLA5XRdqPu1zTOQGy1+F1Ig=
X-Google-Smtp-Source: AGHT+IGRGLu273ia/uJ1kVEfWXIabWgbH3cTFkXdos2+rXsX2htUfTI0qOd7W1pVul4CWeCQ4K4xAqme80WLVyOqC1E=
X-Received: by 2002:a05:6602:3809:b0:85b:3c49:8825 with SMTP id
 ca18e2360f4ac-85dc47a4b7emr202235439f.4.1741940992038; Fri, 14 Mar 2025
 01:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-9-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-9-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:29:41 +0800
X-Gm-Features: AQ5f1JqloEVd2PMJQWiW4SYNMnwxagAj6nW3aH_4ypy943_pLM-QCjhzDDCcitw
Message-ID: <CANXhq0rKE-PFP=OnD4o3+fDxgmzLxuz3LDyGmvBqnTgVO8oCsw@mail.gmail.com>
Subject: Re: [PATCH v11 09/27] riscv mmu: write protect and shadow stack
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> `fork` implements copy on write (COW) by making pages readonly in child
> and parent both.
>
> ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
> Assumption is that page is readable and on fault copy on write happens.
>
> To implement COW on shadow stack pages, clearing up W bit makes them XWR =
=3D
> 000. This will result in wrong PTE setting which says no perms but V=3D1 =
and
> PFN field pointing to final page. Instead desired behavior is to turn it
> into a readable page, take an access (load/store) fault on sspush/sspop
> (shadow stack) and then perform COW on such pages. This way regular reads
> would still be allowed and not lead to COW maintaining current behavior
> of COW on non-shadow stack but writeable memory.
>
> On the other hand it doesn't interfere with existing COW for read-write
> memory. Assumption is always that _PAGE_READ must have been set and thus
> setting _PAGE_READ is harmless.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index ccd2fa34afb8..54707686f042 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -411,7 +411,7 @@ static inline int pte_devmap(pte_t pte)
>
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> -       return __pte(pte_val(pte) & ~(_PAGE_WRITE));
> +       return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
>  }
>
>  /* static inline pte_t pte_mkread(pte_t pte) */
> @@ -612,7 +612,15 @@ static inline pte_t ptep_get_and_clear(struct mm_str=
uct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long address, pte_t *ptep)
>  {
> -       atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)pte=
p);
> +       pte_t read_pte =3D READ_ONCE(*ptep);
> +       /*
> +        * ptep_set_wrprotect can be called for shadow stack ranges too.
> +        * shadow stack memory is XWR =3D 010 and thus clearing _PAGE_WRI=
TE will lead to
> +        * encoding 000b which is wrong encoding with V =3D 1. This shoul=
d lead to page fault
> +        * but we dont want this wrong configuration to be set in page ta=
bles.
> +        */
> +       atomic_long_set((atomic_long_t *)ptep,
> +                       ((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE=
) | _PAGE_READ));
>  }
>
>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
>

LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

