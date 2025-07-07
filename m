Return-Path: <linux-fsdevel+bounces-54197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C958AFBE96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6821B16CCE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DC289379;
	Mon,  7 Jul 2025 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBKybkcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E92433AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751930717; cv=none; b=CzOw1ACb77f0wQR7g3bEGmxxxAccyS4i2PScX8ZZreNzZv/glJ96jnPMTP6b+KwGjt1q/prB2Boh9XqDViZLLpeW5rRpHK/zFGejvm+to7ZrTk+GZ23cYJm9kkXFPjz2lRgKD5IFafpJ/nH4yH7ManaztjMhTokh4pAboLE7WUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751930717; c=relaxed/simple;
	bh=JHbksS7Ik6LaoWpSJU26eNZHwnoWAXLMnPu9PY2UpqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LsZpTcWod3HTxJOy6yg06qOgxaLq8BGRt7sZYe6u5tHgAnbRRSc3C16T6I9OvFl7PM0xoxvj5NY2MoO3YZrBQrAFn1sX2ge6l1X0Vjdf5b7he7kpar463dF3BKHFSM3uSPtCHbp1AyCyIb3zc4cDBvcFegaKNbMW/uHbIEhRVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBKybkcB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31215090074so5978468a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751930716; x=1752535516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHbksS7Ik6LaoWpSJU26eNZHwnoWAXLMnPu9PY2UpqE=;
        b=hBKybkcB3e5Dt9TDYEYCScfGA6befovCy1IXOtsYuFtk4kqSyhdThoQM1eaDZs6Npc
         hzFkjzoXBSZ+hv6Vly9GVeAiMpdSt7qnxiiapTBqD5GOE6hraA5+JfqndWL9P1eOO05a
         ZAGbBlERJDeYA09NI/Mee514Pufi8wJ/LOUwc49eCD2QIbirV8sLbvsj3b0i/kwh+Vna
         KqTGp6ItLIyR51mEpsZjrpxiUTCMHZfklFd3LZHy6AfM7u1ZYF2a70Lw5TfyH7S9FHAY
         q0tEix/1rSp5ZDBJBa8NYhThcKdYkj/sIw++MF/MaZIPkWoCLSeSZP3V91nwMfYi/iYx
         nxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751930716; x=1752535516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHbksS7Ik6LaoWpSJU26eNZHwnoWAXLMnPu9PY2UpqE=;
        b=ReUurIw68iysnmTiKsz4WYbiOewH0ki6vUzm+KdYdidDdB5T+t6I6BaGyT2nZ6qeF7
         Q+y4ttq+xZQ20QZdJ55NTy4bfiZdJo0MzC9hbAcfHPDv0h/oOheCbDr8d9BbjylpMohh
         376n1miPjk6LcL7/ivRS1yrtsvSWPBvktIPNcXoahG/c4D8Ym+L75m2uIyqLXXyuBvIO
         BlNSygLdcyfSjOew+kbB3sxem/6BI7PaBgit/Vtp9AYEi1C5xFBdDwdxQIOQO3PenI2M
         KIQHtNneZpf1vI+Uw9M47bgVGEy9gPSTAWMzTDk4q1yS9XX0GG3UUN85bmpfI6toYT4p
         g5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVTl2czQ2EYKXrs60th5qlpUeYFq2ztbyCC2TREyBgjc4w02riIDXUgGMgjO4ouRta2AY+wcdNl4719LYUY@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJB4Xo1UJoYQ/YvOZV3B0D8/DViGsm9rKt4N8CGmvlfJR3y8d
	gD3gniaP2OQyslGyXgR03/8QfKuSovRSqs3rN4kVggZfgSel61czonhZfJfJwxV2oQcQ1pumuMi
	U015/Xw==
X-Google-Smtp-Source: AGHT+IHec07vkrbcNzUBZe/F6EmhpBPtyl7Ef0BOzGMA51wQ8QB8Pn/cPlRz3g6O/7DZmfJqJVUpfLdRuGc=
X-Received: from pjbqx14.prod.google.com ([2002:a17:90b:3e4e:b0:312:e914:4548])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37c8:b0:311:ab20:159d
 with SMTP id 98e67ed59e1d1-31aadd9ce5bmr19229725a91.19.1751930715704; Mon, 07
 Jul 2025 16:25:15 -0700 (PDT)
Date: Mon, 7 Jul 2025 16:25:14 -0700
In-Reply-To: <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com> <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
 <aGIBGR8tLNYtbeWC@yzhao56-desk.sh.intel.com> <CAGtprH-83EOz8rrUjE+O8m7nUDjt=THyXx=kfft1xQry65mtQg@mail.gmail.com>
 <aGNw4ZJwlClvqezR@yzhao56-desk.sh.intel.com> <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
Message-ID: <aGxXWvZCfhNaWISY@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 01, 2025, Vishal Annapurve wrote:
> I would be curious to understand if we need zeroing on conversion for
> Confidential VMs. If not, then the simple rule of zeroing on
> allocation only will work for all usecases.

Unless I'm misunderstanding what your asking, pKVM very specific does NOT want
zeroing on conversion, because one of its use cases is in-place conversion, e.g.
to fill a shared buffer and then convert it to private so that the buffer can be
processed in the TEE.

Some architectures, e.g. SNP and TDX, may effectively require zeroing on conversion,
but that's essentially a property of the architecture, i.e. an arch/vendor specific
detail.

