Return-Path: <linux-fsdevel+bounces-55763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74416B0E6ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749107B0370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE8528B4EC;
	Tue, 22 Jul 2025 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3oBXBwjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895A2877E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225659; cv=none; b=hnZvkbKWV8qzIUCVHgc2Fl12nHiC69qZjKX/UO79RI7m3cT7dkqMHikGcKWnEskKHMWtrbWlzNkIplshT8TgSCO2fQ3eTiZoqd/gKyfG4kIWIG67wdkD4mPXG8lpPSlEDgjtaT02PIL1JIori1dOVGybox2m25qrIFssEtVumvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225659; c=relaxed/simple;
	bh=i9Topy5p8+oRB1ybTn3eGTjAdmW4So/zy81PHcCSQws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cZKJ/do9MSAm8FAIOAXrTNyta3bAko38UXW0/59gHyu83Xu2blmr9Gj3nVL9ZDdiqu6F8qXE5lt6GpIcrFF36rj3RFqEitEtevY9637mg55Tx42gpW0RQVURzI+OID9IC8Iww5U61faFRsJLEbAzQh3t5HvBcmBIDaHkxjvtzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3oBXBwjH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311d670ad35so5610469a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753225656; x=1753830456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+m6qI30JHvrm3ONaGCpQMi0L8lxI7PYDb1Mu/Pb3F4=;
        b=3oBXBwjHNB/20r0hYHUo9vZehvohDETqWCUjsCDEyL+kRBgH4IOWq6ZyqqnhLOvxXE
         Ol9d1WAShIZs29mgPsEl2AANInab5X7lTu38QVCnI+8gAdxo4BtQ/mbDzmJUL3PmlYzM
         3tY29xS1MbB928GRSQSaDAABmfc7vxaAik5oQbM5dsiNMQx6tUZoSlJCusNNJzrsBpKR
         HiQFpV4DuZastDN6Fqywl1v5FIiC6zu2vbea3np75HcthenrRXt04v1+wDeFE6puqlXY
         S4lxz9g/X7uGpGABuuT003TMROQDqgCPxScrE+Q9JJBiFkWkUa4n4aboTYaNVQqSyNf3
         I3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753225656; x=1753830456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+m6qI30JHvrm3ONaGCpQMi0L8lxI7PYDb1Mu/Pb3F4=;
        b=HPCBNFagqwwe0hrAIHDreQoskE+Nyu3L5VEIwYd7iWdWl98jrg7Rm9QjZRuCKltVMy
         HZznsN//SbcMw8QUQH+2ATQuZBVt5IUy4RljW4kk49A3ZG3M5lhRtgkruwatd+4ld3HP
         pXE6T47/NC+3jNbajJ2ZGLE4jtZ7axFI97QJ4JNwBtx0Dy4ph2xQRortaRVLFpoXO2tE
         VaV3VMOi4xWtHO8iuo9v5iYNc8WSS8SmmY6Aabmf8iaSdDObIRUOsX3LuC/VRyCvT3AV
         6dfZjyrANxlZkTY7TJZrqOBVihnsIk6KU+t6HXm7Bjd8lcDdPA9sZdZu848h3l+oSK5Y
         nKXw==
X-Forwarded-Encrypted: i=1; AJvYcCWOB74r5i03pAtIomoKG06HdQ3w6lBAQY/stLTQOnyrBA9zVRcPLJtN+SPYHJ6+sUkpJFnotJNbSnXm3Rro@vger.kernel.org
X-Gm-Message-State: AOJu0YxCecjjVMBigOS90sKO6hTAGEeXs4JbCTay6h7vKlVeqEJfbF/H
	H06lRFvA+/FxlkdL/8+VNXBKA+Qt4eOr2C9sYrlecWNLnOvttxbZ5V/Sft4sf/fMS/0IC6T8Id0
	ZfeOGOw==
X-Google-Smtp-Source: AGHT+IFOb8KYXXobVAAvvjW+Fe1YbH8mwfp6V2E801ROWDybd0+20juthdBHS5x4qZEtLjQQN6CpBVqzr4M=
X-Received: from pjuj4.prod.google.com ([2002:a17:90a:d004:b0:313:242b:1773])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5647:b0:311:fc8b:31b5
 with SMTP id 98e67ed59e1d1-31e507abbc6mr1697551a91.14.1753225656408; Tue, 22
 Jul 2025 16:07:36 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:07:34 -0700
In-Reply-To: <80a047e2-e0fb-40cd-bb88-cce05ca017ac@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250713174339.13981-2-shivankg@amd.com> <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
 <aH-j8bOXMfOKdpHp@google.com> <80a047e2-e0fb-40cd-bb88-cce05ca017ac@redhat.com>
Message-ID: <aIAZtgtdy5Fw1OOi@google.com>
Subject: Re: [PATCH V9 0/7] Add NUMA mempolicy support for KVM guest-memfd
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivank Garg <shivankg@amd.com>, vbabka@suse.cz, willy@infradead.org, 
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

On Tue, Jul 22, 2025, David Hildenbrand wrote:
> On 22.07.25 16:45, Sean Christopherson wrote:
> > On Tue, Jul 22, 2025, David Hildenbrand wrote:
> > > Just to clarify: this is based on Fuad's stage 1 and should probably still be
> > > tagged "RFC" until stage-1 is finally upstream.
> > > 
> > > (I was hoping stage-1 would go upstream in 6.17, but I am not sure yet if that is
> > > still feasible looking at the never-ending review)
> > 
> > 6.17 is very doable.
> 
> I like your optimism :)

I'm not optimistic, just incompetent.  I forgot what kernel we're on.  **6.18**
is very doable, 6.17 not so much.

