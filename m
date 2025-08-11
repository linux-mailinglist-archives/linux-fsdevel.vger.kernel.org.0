Return-Path: <linux-fsdevel+bounces-57363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E2B20C22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943882A248A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344B62D3230;
	Mon, 11 Aug 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIbEH2Ox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC1253B42
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922859; cv=none; b=P56tq/9QpfBx32EXxS7mi9eVjdiE+6iOSjlvh9OEuxjRxycgU+E1jHtvflk4vOpdCBlKrDrmmm2UP0xeIMV5xKkZ35P5cscHN2KXRixGfDwa4VZF7ui5fqdyDIuth0Tewn2LM4y2dzt9zw/WAPL702VewJUzcRwNTpPiKPAtoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922859; c=relaxed/simple;
	bh=bruREYZz13FVqwhmiTuhvJnq89yjM0qtV4JcUUKirMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sein010qUkWIseH07DSux8K58OKMqu/4VqGqj1yPo2VY1dt5IiCWTIxsNLlr8oCZYjfpGWF88cCEvHXli6f38PKPSuLUQQCTo0L9F5U15ZF9aN15vrdwRsFtW9GlOE51GRuq0OfCnIIAhVLgEV7n0nzafM1G3amp3/3xZD8Y+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIbEH2Ox; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b46e380a400so1521289a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754922857; x=1755527657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3QC/DofyyJ1kIbquP7TygGRJBogDIdpEUbLnTdcdHg=;
        b=DIbEH2OxjBvZkBS8teorCGp39U2CsmDZuMeaPxaLBtckmwePYI1C99M65EyxVI7trh
         HMj94pK8tSAk3aLUDeLtAL6D0cSxG/BAIn/jY23E+Z+FueDmK4DbobALuGZ7GOUSpFAV
         pFuN9hANNqRVIBG3ZvvVCSw2QTKDTvKP8zGpnXzSyTfcMqchaQovLADWbt6PftZYq+8u
         MDnxb7e9+ghOdjDXxhD0wKp0209GGbj42znut7BAb3XeN1mYs9dLBE8YTT0TeccuZFNV
         78Z3olcG5TguJmbCuK46mBMg9bII8+GyNCNGPCcxWsmK1r2rbJoaYCZLg7gIdLsEdA9X
         HxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922857; x=1755527657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3QC/DofyyJ1kIbquP7TygGRJBogDIdpEUbLnTdcdHg=;
        b=sXRJWrIT8WKFRKWaAUXpzFjeVOkua/AvWm9jOvjyBCaQ5wRd++TlX/7Os6RATrgSN0
         fsBOXfrQK+xdGcCqau8tyNdt+bBsPUl+uco9O3/PBrfwXe2WcNQHnlsZTDX2cXnYCKwC
         8Bt8T/gmmMIrZxVzUbdxVfux0ZjR0AARp3oSla9Mg1HMo4psu9vtuAPlIYM90p9c9ZWI
         NJXxNyFZXxDhNnGZW8onGIvJCwU3khb0bGXam8PfhboDGSCOBYDIf8kLQ4ZzTU4GjaSz
         G5fo6cqlIRbMRHDqPbeEqbl1/4qJlc1szuX/BMJlZK7kiH0yAbSP08oVqQfua1A4jHoW
         yDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfQG/2z/SGem9HNH/854e5ANCr13n2/5ro9RJOunUxxTWG83FPU/RMvlcR0hjHbdeHO+Hica0t16VafKTh@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQxFAF9u3/CDkk3amdfh/j0CPJwnbqno2uz/b4DA2kYplMs7N
	hZ8A72d1lyOY+hZvO3CLCm/eadbkw70MNYVIYk6U0xtUeMGAkdhdZfv+0xGrY5XQiUrJasCO9Fc
	jdV+9rQ==
X-Google-Smtp-Source: AGHT+IHDzFt+0zXjA0CUz3si8YkwDTRVPFUsiiRh4VZN4Dkprgq2wlq3CPL9ofZgO6/62HnwUQZt6ujhFVk=
X-Received: from pgos21.prod.google.com ([2002:a63:af55:0:b0:b31:d198:ffb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8b:b0:240:6dc:9164
 with SMTP id adf61e73a8af0-2405502ffeamr23223057637.15.1754922855887; Mon, 11
 Aug 2025 07:34:15 -0700 (PDT)
Date: Mon, 11 Aug 2025 07:34:14 -0700
In-Reply-To: <20250811090605.16057-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811090605.16057-2-shivankg@amd.com>
Message-ID: <aJn_ZvD2AfZBX4Ox@google.com>
Subject: Re: [PATCH RFC V10 0/7] Add NUMA mempolicy support for KVM guest-memfd
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: david@redhat.com, vbabka@suse.cz, willy@infradead.org, 
	akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Shivank Garg wrote:
> This series introduces NUMA-aware memory placement support for KVM guests
> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> that enabled host-mapping for guest_memfd memory [1].

Is this still actually an RFC?  If so, why?  If not, drop tag on the next version
(if one is needed/sent).

