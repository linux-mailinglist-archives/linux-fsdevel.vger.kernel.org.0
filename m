Return-Path: <linux-fsdevel+bounces-66714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C5CC2A7A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A083A7973
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 07:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF282D249A;
	Mon,  3 Nov 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyuFXS/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401F2D1907;
	Mon,  3 Nov 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156643; cv=none; b=EF6QRezUPv4F58o2MmNVgGoVZI2R3qeuoni3vwsC7jJna2vEY2dkFw8Q6iXqK9sSZKMuwxV/IAHCiNCMSJscGp+h3JnmE42jKL3MBf58QDzoWneyN31z+V9XdFVS2OVabg4OHMcQd1bB5WZ+Ysg+eVwzb320vLfZK6tt+OB1+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156643; c=relaxed/simple;
	bh=HSj/Z5n0gDZ4meqwx9ffw43W8XomEOuc7B2mT893bzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N3M+ucM8M+7Ghcbz26qodnLJtUpcMl+eSg4WI2iWqmH4yKzGdg82SsxvJwrLUrzQczXL4+VEwiTTpfpwK2niD3tzYwUHQw6289ITNh2EyJp4wuOGgeIYCsT1MFRDiVG/OHAVu/8C0kIv9gW4s9NQMtGCgcY4YlHZzli/QASK16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyuFXS/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78AEC4CEE7;
	Mon,  3 Nov 2025 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762156642;
	bh=HSj/Z5n0gDZ4meqwx9ffw43W8XomEOuc7B2mT893bzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EyuFXS/5i8cjPsKl1fmDKJwxtvpzPfkDrVD/7Dw9cVg4MIRSZ9pwX9Mwp3TkQNtyw
	 zoeqzLLyxPRNqLWKH6FXNg+6ZNo7vj4V4K1a2Q2k642McCDmgxisCjpK6A9S/QL1M+
	 JohKsDSLySE14H0H5z5GG8d356N9+qgQ55m+uwsMsRoTogFqUE9iZVhmwTsjaJxJ0D
	 rf7CiQwNGNOSkhhNm3a8Kegsyv/wACFQk0qTNci2kW/sBtJn3XjoC3JgBMB4DLxEd1
	 BxbJrOVgc9EcBq/f6dV64raqbuuFvwCKqXqgbvNuoO3N0Gl4d4KOsuqDiCv8HqbTcE
	 IGGXAlmxritEQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "Roy, Patrick" <roypat@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"song@kernel.org" <song@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>, "Kalyazin,
	Nikita" <kalyazin@amazon.co.uk>, "Thomson,
	Jack" <jackabt@amazon.co.uk>,
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
	"tabba@google.com" <tabba@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>
Subject: Re: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from
 direct map
In-Reply-To: <20250924152214.7292-2-roypat@amazon.co.uk>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-2-roypat@amazon.co.uk>
Date: Mon, 03 Nov 2025 13:27:04 +0530
Message-ID: <yq5ajz07czvz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Roy, Patrick" <roypat@amazon.co.uk> writes:

....

> +static int kvm_gmem_folio_zap_direct_map(struct folio *folio)
> +{
> +	if (kvm_gmem_folio_no_direct_map(folio))
> +		return 0;
> +
> +	int r =3D set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_p=
ages(folio),
> +					 false);
> +
> +	if (!r) {
> +		unsigned long addr =3D (unsigned long) folio_address(folio);
> +		folio->private =3D (void *) ((u64) folio->private & KVM_GMEM_FOLIO_NO_=
DIRECT_MAP);
> +		flush_tlb_kernel_range(addr, addr + folio_size(folio));
> +	}
> +
> +	return r;
> +}

These 'noflush' functions are actually doing flush_tlb_kernel

[-]  =E2=88=98 flush_tlb_kernel_range
 |-[-]  =E2=86=90 __change_memory_common
 |  `-[-]  =E2=86=90 set_memory_valid
 |     `-   =E2=86=90 set_direct_map_valid_noflush

-aneesh

