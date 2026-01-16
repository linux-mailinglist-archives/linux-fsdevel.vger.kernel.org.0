Return-Path: <linux-fsdevel+bounces-74171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE4D33456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07C0A30326EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9061633A9F1;
	Fri, 16 Jan 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbO//O9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B133A704
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578067; cv=none; b=VUBgMvvK73NXuVS9G3U/I8ICbO7I8BV/JOY5iq1zk6w5mdU+nU860VlU1sPiYUSmQIBFz8oBeQ5lKkI7SB96C7Pci9NadrKpQGiI2jaTxTUJEtPVTpp3tA4qUy46xPhweIQUnPNfzlYQWYwyDy5jyqPKPDdJjzPn7XfZKf1UrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578067; c=relaxed/simple;
	bh=cbz4P0q8LjyF0OVI7OVejj9Lnkf5fBOIA9+hzT8ibrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOptkY95HB5pqA/PLdM/mcnBdWqvvzMWandUDlEJPvhZo2N7XANEMksWB3mhfwU8ffAfCRncizDO6VnV28DN6M4cn7XInzmLG1bvA5s2B8hdGRyB+m5NjFGGplZ+sSc1sdGcAwOal47okiybr/v4icfvfxDZNILLyftGbxteocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbO//O9G; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a090819ed1so14812355ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768578064; x=1769182864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbz4P0q8LjyF0OVI7OVejj9Lnkf5fBOIA9+hzT8ibrU=;
        b=dbO//O9G332HhBxJtKD2JQbZXK+wnfpwC3CQvQdXruUpCU57QkYhLoE6roepa/T/BJ
         b2U9QTNYTDXYM1jnVjamlkZ11yafdYxSc2lqrCLiLTrAID0EED8UiSLuWClSP7SdGAhL
         VEg/nR0AyoIciYoDj2SfSQ8VAysUDxh8K5rd3qfFEU5qyHg+kM6mSVcrggtSnqoscvNn
         M26BO8fQuN3lafBfW2vvav43Wy8ZKkD0gXxAKpHKHJ/NXK83VgQPP+x1zgHCVHRYpfFI
         RgoPXlK6/kyxRKGDnYFNAbZC3z+Se0A6SUSvIYINsdjJ0rsO4EQXgvwcwTQm1E6IPVg/
         m8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578064; x=1769182864;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cbz4P0q8LjyF0OVI7OVejj9Lnkf5fBOIA9+hzT8ibrU=;
        b=ab5Sfn1pEqm14g0iQTBHS1hp5v1VC+B8LWAdcIwrN3M2KWC/qa4zCO+6OTv+rpT21+
         lXqL8PCWME0LzEM1fqF5K2YJ+FBSOxSAmNjv1etEBnXWiGZf5hh0Rf5TDsuo9nuazPSS
         aEOp/TvBssZXYNuTmJJSdXi5afF1tU1CXHeEEWQCHpwsSTodGvslPIa8ff297iVbLYXf
         Y3ZaaPz17MqC0spS7AqI1H5hTUhhzk7xfUG8QQ8+7/EUB3QU/mfenBwdTw76e/uykrib
         sCniv1zRSzZDV5Tg2k/2TgjCzXfKG7gp9V4QvMXHqRlemMHxhXf7b/VdpP4qjMTFkDAs
         A5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWPhvt9x6964JeaLS+XL/BFGtSTCqhiuCLyBkLVLFYxgiwRCYa0LMMrsYHkyAfzhR2yFwPzMHRLm1sOuv19@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWIccMKnyQXYZyxhiX0homEnHz2NKo+VpNQXaMRiwHj+lYsML
	uvQU1BHiW1s99uFScya0GD2GYgeOVnfr5EWtWpa++4tuEtSEMWlGF92uAOmhCP0RlX7mGbwapac
	LICOwjQ==
X-Received: from plss10.prod.google.com ([2002:a17:902:c64a:b0:29f:68b:3550])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf07:b0:2a2:bff6:42ef
 with SMTP id d9443c01a7336-2a7174fa860mr37848805ad.7.1768578064299; Fri, 16
 Jan 2026 07:41:04 -0800 (PST)
Date: Fri, 16 Jan 2026 07:41:02 -0800
In-Reply-To: <4781ba9c5d16394cdd785d008cf2a2d81c5cda35.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
 <208b151b-f458-4327-94bc-eb3f32d20a68@amazon.com> <4781ba9c5d16394cdd785d008cf2a2d81c5cda35.camel@intel.com>
Message-ID: <aWpcDrGVLrZOqdcg@google.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kalyazin@amazon.com" <kalyazin@amazon.com>, "kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "david@kernel.org" <david@kernel.org>, 
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "jgross@suse.com" <jgross@suse.com>, 
	"surenb@google.com" <surenb@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org" <maz@kernel.org>, 
	"peterx@redhat.com" <peterx@redhat.com>, "ast@kernel.org" <ast@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, "pjw@kernel.org" <pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>, 
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"jmattson@google.com" <jmattson@google.com>, "luto@kernel.org" <luto@kernel.org>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "haoluo@google.com" <haoluo@google.com>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"hpa@zytor.com" <hpa@zytor.com>, "song@kernel.org" <song@kernel.org>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"peterz@infradead.org" <peterz@infradead.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jthoughton@google.com" <jthoughton@google.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"prsampat@amd.com" <prsampat@amd.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "joey.gouly@arm.com" <joey.gouly@arm.com>, 
	"derekmn@amazon.com" <derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "jannh@google.com" <jannh@google.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org" <kas@kernel.org>, 
	"will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026, Rick P Edgecombe wrote:
> On Fri, 2026-01-16 at 15:02 +0000, Nikita Kalyazin wrote:
> > > TDX does some clearing at the direct map mapping for pages that
> > > comes from gmem, using a special instruction. It also does some
> > > clflushing at the direct map address for these pages. So I think we
> > > need to make sure TDs don't pull from gmem fds with this flag.
> >=20
> > Would you be able to give a pointer on how we can do that?=C2=A0 I'm no=
t
> > very familiar with the TDX code.
>=20
> Uhh, that is a good question. Let me think.

Pass @kvm to kvm_arch_gmem_supports_no_direct_map() and then return %false =
if
it's a TDX VM.

