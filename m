Return-Path: <linux-fsdevel+bounces-64525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95613BEB84B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4225818866D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098833FE2C;
	Fri, 17 Oct 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GPCu6NB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3610033DECB
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731975; cv=none; b=ga8O37WGP1ZeGmuE6kIKAIqx7mzoCJb2B6IacCVT21qlUVPfmj6TgukNJT3aSdqJdOaFid9Ow4CH74BfCKx+lobZTv9OlYd//agxnWUf2POY7aiDcypqSJv5tn26pAPYDkh8Sd9ndHsg9KTFrtypIEF6LU1UqBxBk83hgf0sF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731975; c=relaxed/simple;
	bh=5sPCbmVaZjwOnK8esh5b6y2EMzjDjIkrPLz3+NCgVqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0H5dlHQ5GZ8RVWKVsr4bAxhcWfZs66xSQDNZgnpKshAu3W9CikxODvqsKecVuPafms3U4/NjpuEo1I/vmiFniGetdADRsO/ZNaVymsACUNnzRYbhIeYZM9V73i26Ax370wWP3PWplvR0NViuotBTtuh2WaXWRPggzDiS4Mgjqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GPCu6NB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so1882279a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731969; x=1761336769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KR72vgpCvELPyR/ICJ3IjpNbxUCWAnmK6eB3NpuYbR4=;
        b=2GPCu6NBEQ55fkAt62GWgZJGk65LERr9vIAnjHp/c3Z8GfUJGHtq0HPcHoH8N0y1o/
         nwQgm8NIDrox+5S8SdA46S7Lxqcao+Ahby6IPylziz6YP/ek2uywwB/ekjMKBhn/nSB0
         d7LagSCiX2+mGIihCUzlfZggCfiKjxcGAJ5Wl9lZXH+msnTYEdmNZSKZ76q+X2Np2Y1P
         AXRGOQ1nlvjNvTa09XdWT2YdYMZX3ftUApXUCVgd+6oD0Lqx0Yi6573wGNIkG7c2b7Wf
         2M5UzNj73z/5djAQQWSyGsoOblkvVU6ND7tMS2vfWCUwUjf3XNyHEeI/dghRLs2A4BS1
         8TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731969; x=1761336769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR72vgpCvELPyR/ICJ3IjpNbxUCWAnmK6eB3NpuYbR4=;
        b=SmyN2eR5srWCaIfs56J9pf0vVZ11UqK9K/f3KgYZs5OJaoeqTUy8qec9h0L4xpMG1h
         gLPDcAX97tseBeAxKD7HScCbsjB1FEK9R0Bb2IhhjKh+bqpqBYj5UzIydqtmWYC6YymP
         y0LPKsK9Ejtc+cNTNeXNo1L7sGV0W/r74vneiOz8V2dxJmSGrPGvVLkHHwOL19sYl18U
         DURER2aSgbtbaxBJiQq32GKk/IBHefSIl8XNGYHieDwwg7SbpkO4mhjBcKhgGKxvxdfp
         cDj+q0b6YcLSuvRUzi8Ew7pM6lsOx361BBBew3pv8VZuJdIn1m6cJBOjBUaugRy/iyi+
         uZQA==
X-Forwarded-Encrypted: i=1; AJvYcCWPIvsh5+e+87NImeee0I23UmuXiQIOkQeKgWRYWWttTxf7bexIJxTZUHhM8BdFY8JHhPOC9guWuP+W7YIr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QV/0FJZ50PwrKvtQKiQ2purSNnvXA43nXKQMHvH82PDG/MeV
	+HdagQRCIGOg2NpCBW2LXxc8Li0EwkKJ/QftdaN4lTI5cgXPzpfWf9E8Th6JEUHUZuI1zkXolIx
	CvZDfiRDQY5v7pydRGN9URhTstw==
X-Google-Smtp-Source: AGHT+IGTLI28yZrk0rADnL8AJRnYpgX7fVX5tQYbza0e4ND5OU4Hj5SMJ3v64nlbDhoh1Pqxs5RCZmim7dvJP9f9Zg==
X-Received: from pjbdy13.prod.google.com ([2002:a17:90b:6cd:b0:33b:ce80:9efc])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e46:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-33bcf953e72mr6347941a91.9.1760731968802;
 Fri, 17 Oct 2025 13:12:48 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:53 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <36defde6a09d2a7b4ff5507b752546a906b262f9.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 12/37] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Bury KVM_VM_MEMORY_ATTRIBUTES in x86 to discourage other architectures
from adding support for per-VM memory attributes, because tracking private
vs. shared memory on a per-VM basis is now deprecated in favor of tracking
on a per-guest_memfd basis, and no other memory attributes are on the
horizon.

This will also allow modifying KVM_VM_MEMORY_ATTRIBUTES to be
user-selectable (in x86) without creating weirdness in KVM's Kconfigs.
Now that guest_memfd support memory attributes, it's entirely possible to
run x86 CoCo VMs without support for KVM_VM_MEMORY_ATTRIBUTES.

Leave the code itself in common KVM so that it's trivial to undo this
change if new per-VM attributes do come along.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 4 ++++
 virt/kvm/Kconfig     | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index acb03b45ba050..49c7709e3d895 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -80,6 +80,10 @@ config KVM_WERROR
 
 	  If in doubt, say "N".
 
+config KVM_VM_MEMORY_ATTRIBUTES
+	select KVM_MEMORY_ATTRIBUTES
+	bool
+
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index b3473aec4d24d..72b19813e5412 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -112,10 +112,6 @@ config KVM_MEMORY_ATTRIBUTES
        depends on KVM_GENERIC_MMU_NOTIFIER
        bool
 
-config KVM_VM_MEMORY_ATTRIBUTES
-       select KVM_MEMORY_ATTRIBUTES
-       bool
-
 config KVM_GUEST_MEMFD
        select KVM_MEMORY_ATTRIBUTES
        select XARRAY_MULTI
-- 
2.51.0.858.gf9c4a03a3a-goog


