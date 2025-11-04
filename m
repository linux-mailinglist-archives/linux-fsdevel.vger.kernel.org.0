Return-Path: <linux-fsdevel+bounces-66962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D906C31D90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08CEC4EC976
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8EF260583;
	Tue,  4 Nov 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="komXz4R+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937D2566D3
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270172; cv=none; b=msSUyoaSpW0w/BIK86zgyI7wYxE45G5lc4IPAi8aIsKSqsR3SLEuzmB6k3RdoXy/tI5lVMvYZJ4DZVKBPnSJe5g9EqkHLqB+seZ40YnAnuSXj/7swN0l5FwjAsB2f7Wc708cuRKz+UuU6tqBQCNrAs3eUxQJ0WgYNlfLXoKdvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270172; c=relaxed/simple;
	bh=8GNMbexAGe1nKqMzzLVClEkNd7j6DVDRkgcdOMp8ajQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqo3CllkY/b9Q8yWn1hIGrvfd8by2SAxn5EdMUNIqlOmjlhdd7vFefHVW8Ls32abXPZvroQw8ZFQvyvPjza4XX93r05s/4mBMJQRd8qbjFKWgn8cp50qhqmTfhM0vEgwHgWAvVAkawe1HExtdl8Hyg/lBJxpCEyBTpo/xbV29S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=komXz4R+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2959197b68eso195975ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762270170; x=1762874970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GNMbexAGe1nKqMzzLVClEkNd7j6DVDRkgcdOMp8ajQ=;
        b=komXz4R+41dzT/XSiGVn89xk28v1lVjn5ZUX4+R3Vry1fRFm0on3hzx47TViArkgsV
         64igP4q74IHlHGz/e6WNOhIzO4NoXFVpzWZY5PT6xsU5aMt5urG5Tmgum3HpayNNAR7W
         qMgE5xpOgsKWwcZiD/HiON3MyShaU7sEGd9iKE/mhwXRZZth+xK/SZMi8eNiy6M2u/JN
         mu5mOt3DcNFAVsM5g7HUMIvWJa2e7uJ6jJGTK7/tdfqn1iuKZ03YmvQ6604ISnoZsI6F
         EwQrKMGUNWm7ChO2CPB+o/p4InWbwf4bs/Ew38x9e09dHaSp+1R2iw0gthCKjcs7qe3Y
         ZcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762270170; x=1762874970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GNMbexAGe1nKqMzzLVClEkNd7j6DVDRkgcdOMp8ajQ=;
        b=aYmfxY/uy0RSZeKVMQzPlp0AV0RlDRHC5kdw/NZ0lIGC7EsLPFgH8ix73NLsSw6UK9
         235MSTuLvtC8tP63onfd4gV7iEpQEjRe1FsDEQwl5IXRg3/Q5rFBohgTcTCAC6nao79D
         0LvDpkUX4MQJxVOf2faM2ZNZVadnBml8hK4gkGpQU1x8rGaPjn0vdXsDw91yIgSsj2pF
         T729NlHWLGxx+m4GeNjM2UvB22Ro7OgYOi8MsgtreoHHpsh68oRazzBC+SQilMZuSbCe
         7iwYwAKjY9s4PUrR6SSk0ZEhvh3edS+bcBTB6acUpCy4zce8SPzntlS/cw26E0+jR7bD
         0t5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZkLWDnVXvc3M7mAJFP3u5j/N/f4sNE6nFcU5+iUoLBGDuFHPlxOWko1envvgG/huf+6wUnHx3CKDBHvW+@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOxcZpJQKi8Yz1Hy/vxMWGBsLpfa3tspGmfX+kAjmpLGJ+2vg
	fSCZYZh9CVU84DuxfDi9infeZOO7ukal6yOXbsBVZ/x3z5rtuTnMWzOsELXiwFsKwc666F6nD3O
	ZEnq5I2M0HU8uWsNGx7rAyeUsr9KND6lVxH6KCtEW
X-Gm-Gg: ASbGncuTrVNnSsnp9hMXwXSrPDR/7/uR06DS4xcuIbPLmEP+r+TpljRUuyP2OftXD86
	TdmLgRWUW5LkOlrgkEn37no7c6Gebe+kpWw3xA9a+DGKWzi7ESUMrSrG7Dis68vCct7uB0lWxWa
	po2UkSquECCUvRAxGCbrjSS68yaNQya30uZ7aJRD+2/FtJVMSsrA7quJjkh4ihDrgihEbLLvmwP
	NomM6+MxPxyUMcrAbdcVVNRrrPwS91l4J8UMJ/1sPJnrHuOLkZ5T1t9y82g5xpawRlXaIrH4lp8
	hyY82ZUiYFyrtCpjcg==
X-Google-Smtp-Source: AGHT+IH4UAJnle8ScuJWqynVoBOWdaJhxSn6rAs6bqvidoqyAcb3/mjW+zeWXvxPSrbgnMnIJK48J8HHgBswCtIjjHM=
X-Received: by 2002:a17:902:c412:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-295fd276d54mr4970305ad.2.1762270169379; Tue, 04 Nov 2025
 07:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <5a4dfc265a46959953e6c24730d22584972b1179.1760731772.git.ackerleytng@google.com>
 <aQnGJ5agTohMijj8@yzhao56-desk.sh.intel.com>
In-Reply-To: <aQnGJ5agTohMijj8@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 4 Nov 2025 07:29:14 -0800
X-Gm-Features: AWmQ_bl_ayCFfhnMsugNyyrAbP6HSGsNUxGOugUtPG7U3zm3zMrinB0nHoIiMMY
Message-ID: <CAGtprH9cajbGWrU9PAZWNKMeKJ9DyhoV=nEYk_DnYnR8Fyapww@mail.gmail.com>
Subject: Re: [RFC PATCH v1 11/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maobibo@loongson.cn, 
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org, 
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, 
	qperret@google.com, richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org, 
	steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, wyihan@google.com, xiaoyao.li@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:27=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:
>
> On Fri, Oct 17, 2025 at 01:11:52PM -0700, Ackerley Tng wrote:
> > For shared to private conversions, if refcounts on any of the folios
> > within the range are elevated, fail the conversion with -EAGAIN.
> >
> > At the point of shared to private conversion, all folios in range are
> > also unmapped. The filemap_invalidate_lock() is held, so no faulting
> > can occur. Hence, from that point on, only transient refcounts can be
> > taken on the folios associated with that guest_memfd.
> >
> > Hence, it is safe to do the conversion from shared to private.
> >
> > After conversion is complete, refcounts may become elevated, but that
> > is fine since users of transient refcounts don't actually access
> > memory.
> >
> > For private to shared conversions, there are no refcount checks. any
> > transient refcounts are expected to drop their refcounts soon. The
> > conversion process will spin waiting for these transient refcounts to
> > go away.
> Where's the code to spin?

When dealing with 4k pages, I think we don't need to spin waiting for
transient refcounts to drop, that logic will be needed when dealing
with huge folios in order to restructure them while handling
conversion. So the specific part can be safely dropped from the commit
message.

