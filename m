Return-Path: <linux-fsdevel+bounces-69951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B30C8C83C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85FD34E609E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A764E2C033C;
	Thu, 27 Nov 2025 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtXWOBz5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4421E86E
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206110; cv=none; b=hXDFP7swZqh3E5ht5wJhrUUa6vNgJLi7ONM2dfoGrAo7GI3qZ8pSWbL62RYMxa9RP5pg8HgGjqWl7pbbTEKCJSD4FzaQVHFxWe9/vvU/z5mCXr5RK7SRn1avbPBtLe6nrww+bNsyiJbiY9P6Z6Ovnlm9WJrxznDmglhENYd0I00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206110; c=relaxed/simple;
	bh=jbv/5yqfSa0KJ/IeA29hXhIEAtQ59RgN8Zbg7ZWt3Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FvtvvnNi5rg7OD6gkAN6CnjdPe7vjkKv+BJdY4YTCwlgO8TT7URyGgf2WMpJLpEivRfQlX6UZZzAIZOp7FU3lLwrtGt55dVtpTkAdXlhnXKd70N0/qLSdZzb6yDa1iYcAuRQzonPujI+Le3fm/hac4pnWgVrUqxOv26iH+p8B+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtXWOBz5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso242793b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 17:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764206106; x=1764810906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YN0BTLFbTgqhPvFlS+d/VYwmsgL4p5TAnUdzEI0ntIc=;
        b=VtXWOBz5kvhlT+HHpT42BUwUQ5eVLkegSXUfr6Q0m7BVHOLfcSyR8EWL7GHT4H9F4W
         kxtLyRtcwtI6RABWmXedgM+SBB8mH9Jo5bC71KczP7sGnDMqRRDtH2SrpQBpT7M8UswM
         6/ZADe6us54p9OcxEjskT0c1+hztXlYM9h3gAYooUTVwCUo+xgJF27cS9V3kRbO9dnYS
         FngzepAHNjrKMcGH2/1ITVHRSg6q1X1sGDfX3L8M4LcULRknxhgbfM6ciCGMkqkC2ySs
         VNNnVkQA/sv3Zc9Sd7DmAXC/3ObsZqOgT1EInbxI0B+ew+ZXKp5+lcZxxYqipJj+li6V
         QhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206106; x=1764810906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN0BTLFbTgqhPvFlS+d/VYwmsgL4p5TAnUdzEI0ntIc=;
        b=bw8dtpiO3rTuG3995udHT0Kt60OzkljujJOrDtxvoz1sWP9nMcc3vSK5oNjrNal6HY
         QJMvJMKA//J54ctkerRGSAO3mdM5/48oNVpPj8s0tkFoZUmwHH1y56GSZr04zZhku+83
         is3ysKp3YhRyXNAQJhnKdIBI2IArhag6u2Fl7GKtj6aMoBlYfO7Ja9yDlxViGBIBclFO
         TuxaoTh29wbI6NeqssgYxbeLrkKEdz3wD3LOFEz2XrNAS+pICPrILnVYzmXGm45wE2ya
         HfBsfY67yDQf/l8yWOeNTdUsw1QVPQWOdLK3I8zQBIQkl066ZMP86hJR40ROcd7b9A1O
         ebRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN+4sQXhfZkCMee0OXtqX0yCqO/Ff19wNw12L5HKDwsYH9NHpjcMDQKIP7UpIlFiszoPlmcKUxwDHX8iKu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22hcF6U1a547y2XEkdsbR1zFYZMaIAERnat9M7202PVyEM24Q
	GS5ls9zlHOR4eFVkps4tGeNgdI3Nxhye1+dUHvZnVkx5JIJD3G7oANV6
X-Gm-Gg: ASbGnctvK9eYNHFnCwhO2IcR31BWtGGlLsEyKZUEUfz7RJLixLkFlzCLB07JIGhdrb8
	AsRYHojyheXd/CXfUlcNrrp4khbNbaXzdbjMzHCJiLPzj6QRbyRM48I5abNNjhe+ocpuF+b0H25
	T9Q0ONw8llmaiDSSP9UZw++vU416f0cRYZACYfQmN8Nb+nb5BYI/G0/Jjn0HC8jALSdJZBRtU0O
	30kGXFHVKGwtzz+KNdP9m3vqHCCPjmkU39GNrDXmaRh05Yg8z0m0in3eACy6gAlbrZRKz7r00Ck
	QR9vC8XPYyRMDCw8ucrzaOLIDDFUf36FiXgcnV2SEm5UmEbUwzzeOzPFCCkS0BrXYnV3Y1jm0tC
	r3IIlgaREIalFxRxa/qTcTylIsrJZq+5JXA2Tw6X6WFSlzaSQqNflXPKSUE9OO/dnzn7e+WArC/
	1S6pIWr7IWKzbGfRVOBBGaVskP
X-Google-Smtp-Source: AGHT+IFOjeQ0nHa/gitKNf1wf8IwI8ZEjtO1qVKyyQQ31rBE2Lfq+ONwSrRkJugnArpqn7KBTPKjcA==
X-Received: by 2002:a05:6a00:114f:b0:7a4:f552:b524 with SMTP id d2e1a72fcca58-7ca8b2b16e0mr9121834b3a.28.1764206105589;
        Wed, 26 Nov 2025 17:15:05 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c414c226f9sm22447356b3a.53.2025.11.26.17.14.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Nov 2025 17:15:04 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Barry Song <v-songbaohua@oppo.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Oven Liyang <liyangouwen1@oppo.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Nam Cao <namcao@linutronix.de>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying page faults after I/O
Date: Thu, 27 Nov 2025 09:14:36 +0800
Message-Id: <20251127011438.6918-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Oven observed most mmap_lock contention and priority inversion
come from page fault retries after waiting for I/O completion.
Oven subsequently raised the following idea:

There is no need to always fall back to mmap_lock if the per-VMA
lock was released only to wait for pagecache or swapcache to
become ready.

In this case, the retry path can continue using the per-VMA lock.
This is a big win: it greatly reduces mmap_lock acquisitions.

Oven Liyang (1):
  mm/filemap: Retry fault by VMA lock if the lock was released for I/O

Barry Song (1):
  mm/swapin: Retry swapin by VMA lock if the lock was released for I/O

 arch/arm/mm/fault.c       |  5 +++++
 arch/arm64/mm/fault.c     |  5 +++++
 arch/loongarch/mm/fault.c |  4 ++++
 arch/powerpc/mm/fault.c   |  5 ++++-
 arch/riscv/mm/fault.c     |  4 ++++
 arch/s390/mm/fault.c      |  4 ++++
 arch/x86/mm/fault.c       |  4 ++++
 include/linux/mm_types.h  |  9 +++++----
 mm/filemap.c              |  5 ++++-
 mm/memory.c               | 10 ++++++++--
 10 files changed, 47 insertions(+), 8 deletions(-)

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Oven Liyang <liyangouwen1@oppo.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kristina Martšenko <kristina.martsenko@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Wentao Guan <guanwentao@uniontech.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org

-- 
2.39.3 (Apple Git-146)


