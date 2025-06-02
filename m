Return-Path: <linux-fsdevel+bounces-50381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67CFACBB67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 21:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F26C18932C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39137223DFA;
	Mon,  2 Jun 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dboiU4Qd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F618154BF0
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748891890; cv=none; b=WsdJRYOvi4u2eX31SmVnfteDEgjtJm6q10duufBsWR3ZiBGHQtW2hZ+ETcAJTk4YX8FMh3C2+c0ExTD9Hu1ph2NfQ8zhHrgAaR7JXucQN2b97zkHPcCCsmv8f4GX1UQlX2OA//CZi9M5o3DCB7r4fX2Rcd4o+Y3OIrRbCCF/hmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748891890; c=relaxed/simple;
	bh=12/Gd93aaTA83c1HNtC1zFmn672vDmey9gAStWrKOoY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FRdl3tBre5UqsjvgwgL9v50m9SWBYGOpz8kne2L9XPSZiJ9vS71AUzYW/ZcrOniwsPP4ncr6e3DN4toNHKKjar1Y8fMolmM8JYxdm2mMokA4Ziwk1ykvm+5M+AWUPwlPpXTn5c7peGAaywLuRiJ1ZoQYELFZ036LxFDVsKoPfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dboiU4Qd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso2976717a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748891887; x=1749496687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJKFQqx9UM1AGUF2AcszFEpAtqC30YGJfsyhTo68y9A=;
        b=dboiU4QdT7Zfzlh8PXvH7/LOFhtHaGgj59D1tUUd5UyTZwJVPxp3d47REtNal67oAB
         weAk6XYREaAr7ecGKSy+rU/zAdQj2m9Z673GABEtcGYS+ROw1CRkoiE0b6FTkSybY+cL
         qiLU3rg7cXQU9UoG5zic2QuZulY+xYUEuUcGLeLK5RDc6vLatodNX0uYvadmumFVp0cM
         VIjmY6HpcvkFooFQ/Pzx683IAS/XqRIRQfk0PeqqjlTKFqpjIGwX1IrZxqxfrRCcQ8SQ
         lHCf2mTfTElyh9cWXoGI6dz+t8zSCKLsIqd3X6FShIJig2YB/5f8HxkW5oj3bdk1XXBi
         HZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748891887; x=1749496687;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJKFQqx9UM1AGUF2AcszFEpAtqC30YGJfsyhTo68y9A=;
        b=Jg4NvkK7EKiD8mzfDlXoYab3rTbzsDFAG3eTRTmvRprpcJTIMTi3Z251+usDnBFHHo
         TgcWJaNTdSkQvfP4i9G1J26Hnn8/sivnyXNSQZQeLpQTkBLzMj1Nku/2vKY556XZYL7C
         cm2NuWflmm/mjrZyNHpgyR2CL+gyuuZmMnFka37XKBFnFCpnKKqj6oayKPECTDjRMYqK
         aG6MDuCNUL7H4FfJWbR46jIj6P5kM5KuTa9h0zvy7Y2fERT72ipn9zePLYbeRGuZ4dKH
         EeLLRLD1hfzrRqnC/D8kI+EOdHlqKKwam4Qsip4KMOtdiv0CMVUFNYWDbI26/909nHII
         tt+w==
X-Forwarded-Encrypted: i=1; AJvYcCUGQFGxd5Zyj3Mh1NafvkDDbF1+if/4T6ESSMVkbBtQrsPr8qIb3bfa+oYJSkXqQoABj5g0JrvdtuiwIBEz@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5g1VPlWOlcUqXZUGVrw/LQObDYeIw7pN/xrWCLl9nzyrxsta
	HFv5QeOmQKOJ2YF+j56sY3Xqy5+QTAM0/gI5N+55YOdVyVnhQCc3ukQl2wvFBIGpOXs/liI4yfp
	9JKWXwsfXiwJDCTarKL0jI1vK/Q==
X-Google-Smtp-Source: AGHT+IGq+MKdUzduCIrTwDf5QIgX09YLMJA7ZELTYRvBBkbWv4Z283ky9bfc20mR5vbgJYZFPZLaDF55ZVFFrEdiWw==
X-Received: from pgbfe22.prod.google.com ([2002:a05:6a02:2896:b0:b2e:c47e:345a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7484:b0:218:5954:1293 with SMTP id adf61e73a8af0-21ad97f95b5mr27557841637.34.1748891887220;
 Mon, 02 Jun 2025 12:18:07 -0700 (PDT)
Date: Mon,  2 Jun 2025 12:17:53 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <cover.1748890962.git.ackerleytng@google.com>
Subject: [PATCH 0/2] Use guest mem inodes instead of anonymous inodes
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
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
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi,

This small patch series makes guest_memfd use guest mem inodes instead
of anonymous inodes and also includes some refactoring to expose a new
function that allocates an inode and runs security checks.

This patch series will serve as a common base for some in-flight series:

* Add NUMA mempolicy support for KVM guest-memfd [1]
* New KVM ioctl to link a gmem inode to a new gmem file [2]
* Restricted mapping of guest_memfd at the host and arm64 support [3]
  aka shared/private conversion support for guest_memfd

[1] https://lore.kernel.org/all/20250408112402.181574-1-shivankg@amd.com/
[2] https://lore.kernel.org/lkml/cover.1747368092.git.afranji@google.com/
[3] https://lore.kernel.org/all/20250328153133.3504118-1-tabba@google.com/

Ackerley Tng (2):
  fs: Provide function that allocates a secure anonymous inode
  KVM: guest_memfd: Use guest mem inodes instead of anonymous inodes

 fs/anon_inodes.c           |  22 ++++--
 include/linux/fs.h         |   1 +
 include/uapi/linux/magic.h |   1 +
 mm/secretmem.c             |   9 +--
 virt/kvm/guest_memfd.c     | 134 +++++++++++++++++++++++++++++++------
 virt/kvm/kvm_main.c        |   7 +-
 virt/kvm/kvm_mm.h          |   9 ++-
 7 files changed, 143 insertions(+), 40 deletions(-)


base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
--
2.49.0.1204.g71687c7c1d-goog

