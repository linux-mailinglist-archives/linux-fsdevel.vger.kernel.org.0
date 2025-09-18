Return-Path: <linux-fsdevel+bounces-62070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFFB83388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 08:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB27617F967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 06:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7462DF124;
	Thu, 18 Sep 2025 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caNOf/8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CE2BEFE4
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178424; cv=none; b=FNVa++kpCNZXMc9LKBiKhHJhCUKMctYaNpC1L3ohbNIM1DQ5bGN/HJ5GTpeAKYpFLaxFsF5fmSDj3xdJ+Xkg4YylkjP6747JkwULysBn2mLvVJaqgUZSzVlhO9lSUsSOiLofdnwmB2EGyDeEARbajQH7BW7UowI4yN4iJN+D/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178424; c=relaxed/simple;
	bh=D2tnMC/HBE68esSjs5GaQ2p4LH2Hgz5G8pAkimgNE84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=crZHdr9LWMzyOQmw0Rlfzx86pDb/8RwXB74eph2aNoXqblrCHWJEgPrGxxFdIjIFtPIlvHyNHmZSniSr7u+2gys1THnqqTef8Fy72OT+QIsBk5u0mqPhtWVa2S4gzFiyyt0BWG1Q7vRAavxRpnRpjQwaQJ0Vr/Ym9ET/jVULdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caNOf/8b; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2665e11e120so7285885ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 23:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758178423; x=1758783223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdY8CdA7D7v7QlqIXdHWhklcBLDBGklkP9F/ba8VEO0=;
        b=caNOf/8b48DxO/KqrqevaCee6mjBDFns47DuHJyN8FGo1seRsHuT+EAzls3ObpSEW1
         OnNvaS7JxBPSIYSoUUd69gqjrrYxhhFtap+BZRJq4Y4UDk/o8yGru9CDRQDQzYw6ykXb
         0JDsIz/zy5ON5XyCOcw1YxO5agigrZ8TG+2WgmoTd63OfvEcRnPKYWLeUQGaXNiK+dNn
         Wuvlznw6r7U9/hFfJ4RUsREPjPDuRfMlS15pO+GdOvwl3tLHdPRdOqVmlmP2P+UPYdY1
         NDhRvNFIZtEObbScuDyscHE32WeaOdZRNYwD30KmY+i2GylczUb+UT+kj+BodNNCS1pQ
         c4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178423; x=1758783223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdY8CdA7D7v7QlqIXdHWhklcBLDBGklkP9F/ba8VEO0=;
        b=DJCCY92b1xg2p863HEm0CNXw+cy98P9M9ist0zYhBmNMCXXQi9HjnRhamblx0vOrsF
         PWsPaljKqw/1DoZDkUAVuhsHxpph/q4OVo2nzGucbd2vgZSkI/IOH2F3vgNryzxFiVbb
         n7h5ZNM+hj2OhgFCSCoZN5e8SS/BLKVdVWrxyeHg4Wpri3SkJWVQYbpFNy3eByZTcxTD
         LtYehmtjGb+2WOjG4eFSYjxSPtJcT5HZnS7owlfoNjYnpvjSA2/cNkxpnZc+B6YaPuVN
         7K6yGnRx0IVnRIAUo86quaw2ovh8EnBARC7LjUlLp0R1Xovsfi7M1FWmfATsErIl2QX9
         /WYw==
X-Forwarded-Encrypted: i=1; AJvYcCUfjvSfB7vNHAra7vK5E6d08etzcv3jnXTIG9VCIq7qLebqNXgeshX+R7Cr7zKPq+Blqg5l59LE+MjF7wWU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2stHwI3up6gqcKE8VcRgfmBvcPuWjjgmP1u2OFwbjN6lYoI1P
	yg76PNm2JpHDJr5uAKInU+jN4jUswGUmBYnpVyJpubvkL7Bl7O2v1tBBm8eQQP2AMKlukWXslwQ
	RcyGxSBCuoUyALiA6InjOH7kXRw==
X-Google-Smtp-Source: AGHT+IH4/xFas5qH9WkGtquuXdWcMilu78LEjzqF2BsDWfyKCYslt2SGwsXQ1h75MU0H2eQyEYDJZApNSPXmxa7tZQ==
X-Received: from pjff12.prod.google.com ([2002:a17:90b:562c:b0:32e:ddac:6ea5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef0f:b0:24c:965a:f97e with SMTP id d9443c01a7336-26811ba541dmr70869245ad.2.1758178422688;
 Wed, 17 Sep 2025 23:53:42 -0700 (PDT)
Date: Thu, 18 Sep 2025 06:53:41 +0000
In-Reply-To: <20250916222801.dlew6mq7kog2q5ni@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <2ae41e0d80339da2b57011622ac2288fed65cd01.1747264138.git.ackerleytng@google.com>
 <20250916222801.dlew6mq7kog2q5ni@amd.com>
Message-ID: <diqzh5x0p7yi.fsf@google.com>
Subject: Re: [RFC PATCH v2 35/51] mm: guestmem_hugetlb: Add support for
 splitting and merging pages
From: Ackerley Tng <ackerleytng@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, 
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

> On Wed, May 14, 2025 at 04:42:14PM -0700, Ackerley Tng wrote:
>> 
>> [...snip...]
>> 
>
> Hi Ackerley,
>
> We've been doing some testing with this series on top of David's
> guestmemfd-preview branch with some SNP enablement[1][2] to exercise
> this code along with the NUMA support from Shivank (BTW, I know you
> have v3 in the works so let me know if we can help with testing that
> as well).
>

Thank you for offering! I'm quite backed up now with some internal
work. Will definitely appreciate all the help I can get once I manage to
push out an RFCv3!

> One issue we hit is if you do a split->merge sequence the unstash of the
> private data will result in folio_test_hugetlb_vmemmap_optimized() reporting
> true even though the hugetlb_vmemmap_optimize_folio() call hasn't been
> performed yet, and when that does get called it will be skipped, so some HVO
> optimization can be lost in this way.
>
> More troublesome however is if you later split the folio again,
> hugetlb_vmemmap_restore_folio() may cause a BUG_ON() since the flags are in a
> state that's not consistent with the state of the folio/vmemmap.
>
> The following patch seems to resolve the issue but I'm not sure what the
> best approach would be:
>
>   https://github.com/AMDESE/linux/commit/b1f25956f18d32730b8d4ded6d77e980091eb4d3
>

I saw your reply on the other thread. Thanks for informing me :)

> Thanks,
>
> Mike
>
> [1] https://github.com/AMDESE/linux/commits/snp-hugetlb-v2-wip0/
> [2] https://github.com/AMDESE/qemu/tree/snp-hugetlb-dev-wip0

