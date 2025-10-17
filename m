Return-Path: <linux-fsdevel+bounces-64544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27CBEB9A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E01189C018
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854234DB6D;
	Fri, 17 Oct 2025 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EL8IzmC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5D338598
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732011; cv=none; b=gdiemn3eDrydOc5xqOmc3hadpuD9e9x49mbnphEPKBa/3/AFYyPOXygGt8+QDJhii5ks9XZ0P/gXf88ymZXNA0i9FRuidqhwyJa1se5JZYaNBzGxHZCkmR0FQIU2KhZt0A1Yh8+ZUkdSAaXCIT7Cw95aCTWEw6/1e8KUbT02PZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732011; c=relaxed/simple;
	bh=30zQD4pjDiSn/+U/aldACY0mrFS2JuKzSnFZG7FjNQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MK79rt/0ceEwF0UmZRTKjj0F4MubVggCA4rtQPFpfoB6R53CYjqKn0r2bCxK8z+6w49XcIKObaNSViBIHmvOFjUp/sxCuJaiO0M0bJfvw1NioiMU5BMKC7CDCkOdnk6C836fDq+GZ7tTPITGiikgBfMyeaayWj1yJd3mD2CizSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EL8IzmC5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b646768eso2680364a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732002; x=1761336802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mpVwCYbwMET7AecOcE2QimVcHIz1TOOFcfyLkjDeGo=;
        b=EL8IzmC5z4DTQUYvZCy3jKls8uL6JbJj8vXJCerWWlefkvzKo3EiyPvHEWDXtbvLeL
         ps9wFnbKHg7T67l5dHLlFW+c96db/77a4px1hqLuvOTAGCLCMF8wgXXDGuJchJenCGh+
         eoFgD/SbJ1HhQmEd0UNEeikNEsdmbbyf0KPuzEI2sY5TVYzGE/K1BvRBFrpKSEgBoYZj
         F2hWTGsF78bsFJKdW1WMwg10IwDuK4PBZUoDI3LE3f/njKyvBqMo1C++ioBKM4yvlVhp
         miBHevQlyRYoSLjSp9HMrP6kEZ6gNAzVvLtaUY+3Lvq4AkQHA78RNk/jkDyzgVPcdz8X
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732002; x=1761336802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mpVwCYbwMET7AecOcE2QimVcHIz1TOOFcfyLkjDeGo=;
        b=KNqfNPTNkUKMPqMUIDUCEEEnUDtMUTdkEVzWdyg7DbFjGw3vKfqyCPud0JWxMVQU/U
         OzDv0lxsz6HxpHtjb5o4L0sBrchLlxqQv+Har75ln7GuRucmYdGTmSFxQimBsQHbxzxv
         zo71865rVJRL7RqMXFH0bLKX5v9WvZBnCUbnqSu/vnpN8ThtIrQyqn6BS8PrAdvt406K
         m58b8YoxoSvqVbYT1EW6c97ggeueDr3Y/H/CJfJBSjVngC5BZ8nAYflTRUASENvdhy4r
         PzGjkS6gdMpZJ5Bvg4zAe1yqqirOJYCIEsgbCAUVF1WHAcqaKAwEre5yGxl/16f6WSnn
         XjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCgKks8cdocF1dcaPQyxBr447+YfQGWYXt4U6i2X9NvA61HYhahBh1RBNDZ5kjTBVrcabeIXj4SRaCswtQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7g23EdmVajc5STKDbRkXXO3m1/m49w7gpVIl8fJYVLkvObsb
	VN7b5h7ysqdxcxBy+au6fhE5iNDQcfuTpUOlFD0in/h8kVwpKgLMome6P29EIhhxdv387O52uVi
	fxCz41YIt4zFwcI1zpm1fqT+Duw==
X-Google-Smtp-Source: AGHT+IHcO4NwxOJfZLNEBbx6WNz/S52BTLMchZETWWpFSftU3iw+fmFyD6t6Of9AgSIAzGHhdhWoKd+61TBtvxNmOQ==
X-Received: from pjbfs17.prod.google.com ([2002:a17:90a:f291:b0:32e:bcc3:ea8e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d87:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33bcf853679mr6444234a91.6.1760732001959;
 Fri, 17 Oct 2025 13:13:21 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:13 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <a3126618d7cb353faad7b231e70c2b732498f449.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 32/37] KVM: selftests: Check fd/flags provided to
 mmap() when setting up memslot
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

Check that a valid fd provided to mmap() must be accompanied by MAP_SHARED.

With an invalid fd (usually used for anonymous mappings), there are no
constraints on mmap() flags.

Add this check to make sure that when a guest_memfd is used as region->fd,
the flag provided to mmap() will include MAP_SHARED.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rephrase assertion message.]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index cb73566fdf153..8603bd5c705ed 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1057,6 +1057,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 
+	TEST_ASSERT(region->fd == -1 || backing_src_is_shared(src_type),
+		    "A valid fd provided to mmap() must be accompanied by MAP_SHARED.");
+
 	mmap_offset = flags & KVM_MEM_GUEST_MEMFD ? gmem_offset : 0;
 	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
 					vm_mem_backing_src_alias(src_type)->flag,
-- 
2.51.0.858.gf9c4a03a3a-goog


