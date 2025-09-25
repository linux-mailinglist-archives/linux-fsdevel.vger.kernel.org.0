Return-Path: <linux-fsdevel+bounces-62734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E5BB9FA05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38763B58BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0BD276057;
	Thu, 25 Sep 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gk3EeibO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E5272E4E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807711; cv=none; b=YtaLGhRJZIKJtiXoxOevwLKETV4lcB0CqpDpCjKeJcrTAh0XfxY/WtT3hgBrxTGJMrT4SVXceP8f8wOTqtZVJYSXnwMzgkuiedQJ9Mu4zFHNXfhwC4oLIqlLUS2VrHjfOtJjodtL61HL1JHUbONYsojo77zEASNAAnTjK7nTYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807711; c=relaxed/simple;
	bh=AY4CdJYGfM13VOROhcQg+Kh48EgBR5zHwAOZ2HsNQ/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=THYx/5zDb+OmO+1OqerqYxpSxV35k8nsGxzZncpnq+T1q/N8khQMZV7UgUyEAcb01KYx0gV94ORyf3XuZT8fZIQmCKsKvdCL6p5E/4TgTLu9y9jmu87AlgiqYjz41CIkXU5L154IpUX9gjEO9cfkQ8m1cqHCv2CczbUc3AN1IE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gk3EeibO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso950626a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758807710; x=1759412510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dU4j5xINCBqy1Rj7i7G1Vfx3gRcoZTHMrIeb9JUSMNk=;
        b=Gk3EeibO1ZMcFGAcEWPL5hFYtzingz6gXXVe/ASHILBBp8JIkEIsVYwd1ZaF9MvWfj
         N4gYNQXa/1zVXGox0ZoGigvTO8b4AbkAjAtyoJuWvjvBeCOu09EyecPoNYG7uwsomFaJ
         LLEqJBGoM6XzQOnYxn51VkO2k5kYRXiwuWpY2PBEqflI25GKMN+VodBGlZwmHtl1IGDI
         w3C2T9OdU/mUgoR6xBhp10hzxlGCo6OElsXX3YEFfZtJoXN5xi9jUK9okgImyP4nP0bG
         Rr2qUKGQnXlqelhxSVQAoVTKvRmMNgEQzM6LpEFtfu2McjZ6TgHrAqCQMS4Kd7mB2BGs
         XoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807710; x=1759412510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU4j5xINCBqy1Rj7i7G1Vfx3gRcoZTHMrIeb9JUSMNk=;
        b=PDTRksn2IQrJgXWAbJpiCnIa9C0EptdcloAb0wZxxh181GOw4Fjnhur2GbrbID3ECU
         UQi0pU/s01eoNi8NveZ6VZ8p0ODw9DCtrpvzUj/7sbIKZsTborY3PbirC//XgNcJ+zOJ
         PEqEXmC5+hFCLCWRtUsLwQE9AqBg1iTjAE7WRmiVAzkRLNL/ZRkbjf8kNTOm4ZY1Bv3z
         OSmdMFqblT73ObZ9aorIb+pTsEgDxI3eGXKmmy+XYVmpqGv49m6b6AXLUkrhAIZ42eY1
         4y0cmuEWbRW5kC/yDQ0em3Eh839xzFrjWeHv4h9e4fgrR46VUs4OkmMPQ4fZ03UU2MqJ
         ehTw==
X-Forwarded-Encrypted: i=1; AJvYcCVFlSlZbccJZJ/1DoLDZYOTZ+DoRfXjlXzJqHPbhU1sUrxTjy5XZBGzqmfLFxsHQV8xuqXGpqMUpHLMyYf/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+aQgbF4QeSj/CJDdDXTRSntZeMvJsL+ynBuq0Znh+A1RZd64N
	UTnM4spVEWkj6m/NdhSWG6/DtuUSNO40ZV67M8GdsluZ1ViYNDr+wF25njRalY8dcpow3vsK37J
	zAiaL1w==
X-Google-Smtp-Source: AGHT+IGEjcBsUTlo4/vVd9aOmfS85HeXK7VXkMsc2AM9X82gWAt19f8n9mk94PI8ByiZcVy2ayMJHM96hBY=
X-Received: from pjbjx4.prod.google.com ([2002:a17:90b:46c4:b0:330:88c4:627])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4a:b0:334:e020:2f16
 with SMTP id 98e67ed59e1d1-334e0202f83mr1618309a91.11.1758807709301; Thu, 25
 Sep 2025 06:41:49 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:41:42 -0700
In-Reply-To: <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-7-shivankg@amd.com>
 <diqztt1sbd2v.fsf@google.com> <aNSt9QT8dmpDK1eE@google.com>
 <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com> <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
Message-ID: <aNVFrZDAkHmgNNci@google.com>
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>, willy@infradead.org, 
	akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org, 
	vbabka@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, chao.gao@intel.com, 
	bharata@amd.com, nikunj@amd.com, michael.day@amd.com, shdhiman@amd.com, 
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, 
	peterx@redhat.com, jack@suse.cz, hch@infradead.org, cgzones@googlemail.com, 
	ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com, 
	dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com, 
	jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 25, 2025, David Hildenbrand wrote:
> On 25.09.25 13:44, Garg, Shivank wrote:
> > On 9/25/2025 8:20 AM, Sean Christopherson wrote:
> > I did functional testing and it works fine.
> 
> I can queue this instead. I guess I can reuse the patch description and add
> Sean as author + add his SOB (if he agrees).

Eh, Ackerley and Fuad did all the work.  If I had provided feedback earlier,
this would have been handled in a new version.  If they are ok with the changes,
I would prefer they remain co-authors.

Regarding timing, how much do people care about getting this into 6.18 in
particular?  AFAICT, this hasn't gotten any coverage in -next, which makes me a
little nervous.

