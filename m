Return-Path: <linux-fsdevel+bounces-55841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F9B0F5C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF5564DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25062F5479;
	Wed, 23 Jul 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="IHZNcmFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA62EE288
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282019; cv=none; b=ESg5NrL7+MR9YXRQFS/dgrXBOr66zMXnmE4HvUclQ5MuZbXho6K8v4/Xb3I1hFjDWyiJfM4oS4YgV+ou6SlQUgGevVtB9xZhElI0afEt90MMtML7HR8XEAt9W+LeWzIVdeFAJ+UeSeXbWQJmAI0thlGce52Yt7o1+OUxufp80U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282019; c=relaxed/simple;
	bh=f+GDZMWDZJ+VR9AGii24ODCbYkbiXkpxGsAaLIJVFdg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzj5r9yVEEkm0dev/qx+ucgHuBcEiab9/6v8dcT13EXtHo0pTEaCpoFMy67PHZXLwwkcyHhHu16AwO++Zu0K50T4f+GxnP7k+bp8o8le/Dg2jgaB7AQRRkxwUX9lOvSAkloG/Do9X7s+J76VWr2KuaRNrjPzMEWuZDT4V613uy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=IHZNcmFa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7183dae670dso62710487b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282016; x=1753886816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inB1PU3JWa0vbtTol7UPnIAGavYFixpKMP3Mnwcd84A=;
        b=IHZNcmFatXGtvf/rYbXauEIWrfIzb1QEczTtP46KsO1VxWQL2GSvPvqA7welG7yDMy
         kPny59P7Fb9o1mxJIh/8DwUndsozrNI2GQkaqD89nndQo05Y5Ll2w0HY4bpBpYswlm68
         HSrSc42XyqKGkMyCFWx10JADe3vN+d1ukSd7awPUFWYFJTQfhRaa0UDKPxl4WQZXntfQ
         FJdLcFy9dDthXh02+pKLHtY84O32mR+m3z9G7ldDcGFnUbqghx6LzcCy3E1i3QtrqGpF
         OycRt3LzEW/o0+10B6FyrtbH6/VE3j4AoC25P0IQVyc9z8WgShZhbY/H4FxwZ0OITJEb
         Mq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282016; x=1753886816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inB1PU3JWa0vbtTol7UPnIAGavYFixpKMP3Mnwcd84A=;
        b=L/PNAOiv+Ua+uU5AbRUzlgubSA5Gb58QUa4EYL8edabxfHbVhk1El9ZWLUffTuFHGE
         fhLF493xFMhAmD7BANqTE6Ij7AbOwv6zv7K3v9MozMN2XzqujdncNokivBGSSpYjHiJ3
         ZmPBjGOOymqJguO1Z1Jnpmreevfp6GcVZ6isrCgwNc+N3HDQx2f/pLy5M+OmPCNXBCYg
         tiBJ9H1+WXcW3cgiSGav4lu/Xk0S1iO5d+z/42DJ5V0kBTFtuw9xl+/YXW7O1e9HqLB+
         mgVCd5f7IvS5GnFWPGy+YUNCKtVbqAycWsh3QTV7qqcsHPFQtGbepi9Q1k9uXDg0svak
         qFng==
X-Forwarded-Encrypted: i=1; AJvYcCVELQD6Z0/vVgWiB/QEcDf3XPwJVN3/U8m3JFlWnuy4yqgkKuGvdEwEmvvyG8kHacfzNlhdhCJutaqAZsuf@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzTmy30tZpdddgCsNKV016EIDaD6X79umUbqPoKWIGSrUB19I
	Asq/2yozIo4bAD3tUhxkXUnU7Egx3ctLZd2IHO21SZ2DLgfhOadyaWsO1i/NOldmseQ=
X-Gm-Gg: ASbGnctlkViIzGNgQ5fzUcpucITS5KA3v+w3D9hBh38cz8iJR6sRqRfKCANr4gd0use
	AWgMuXaR/G7CazhVLrOSNfHvpaBKdRw/e3AlHt5PXRVeY5PLHSCqNii/vy/LOyJ4LFdlnDwCM0y
	mcckZ2BanoS5adIcpghs4a8sAlRi7vBf9kgWDxbf+6AgmDg4GlqTRfBVS1vhV0xJLwzG3bkJ2U1
	/UA/OHPGWKkoiq4+kNMHVjrmpn0MSqCYb7144LZws00Mjl1ZTezYPFHaS2TAwtTJoquGvdurRSd
	t12SW8dSzEHl8LkJchTwtigB5vKIjU+26u66O4RWt2FKuH60JXffJCyaCkjR4ruzwb1EhBDp7pm
	zRdOKsH1T1MRJ15yK/g4pNucu0ex8UV49X6bJ/HPoe+d3OxBSLzQRU2aBKWV8PD4UZaK0XMZGLN
	coJCOb5shwCdU44Q==
X-Google-Smtp-Source: AGHT+IHbn/J5Pj5jthdHC0UvAscyWuGSIeItHc3xuSaAqAb6w+jHqSJyHG/OBKZLtTuVuVxeIgZROw==
X-Received: by 2002:a05:690c:3693:b0:70d:f3f9:1898 with SMTP id 00721157ae682-719b4258e07mr46642237b3.35.1753282016453;
        Wed, 23 Jul 2025 07:46:56 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:46:55 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 01/32] kho: init new_physxa->phys_bits to fix lockdep
Date: Wed, 23 Jul 2025 14:46:14 +0000
Message-ID: <20250723144649.1696299-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep shows the following warning:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.

[<ffffffff810133a6>] dump_stack_lvl+0x66/0xa0
[<ffffffff8136012c>] assign_lock_key+0x10c/0x120
[<ffffffff81358bb4>] register_lock_class+0xf4/0x2f0
[<ffffffff813597ff>] __lock_acquire+0x7f/0x2c40
[<ffffffff81360cb0>] ? __pfx_hlock_conflict+0x10/0x10
[<ffffffff811707be>] ? native_flush_tlb_global+0x8e/0xa0
[<ffffffff8117096e>] ? __flush_tlb_all+0x4e/0xa0
[<ffffffff81172fc2>] ? __kernel_map_pages+0x112/0x140
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff81359556>] lock_acquire+0xe6/0x280
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff8100b9e0>] _raw_spin_lock+0x30/0x40
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff813ec327>] xa_load_or_alloc+0x67/0xe0
[<ffffffff813eb4c0>] kho_preserve_folio+0x90/0x100
[<ffffffff813ebb7f>] __kho_finalize+0xcf/0x400
[<ffffffff813ebef4>] kho_finalize+0x34/0x70

This is becase xa has its own lock, that is not initialized in
xa_load_or_alloc.

Modifiy __kho_preserve_order(), to properly call
xa_init(&new_physxa->phys_bits);

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 5a21dbe17950..1ff6b242f98c 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 				unsigned int order)
 {
 	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa;
+	struct kho_mem_phys *physxa, *new_physxa;
 	const unsigned long pfn_high = pfn >> order;
 
 	might_sleep();
 
-	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
-	if (IS_ERR(physxa))
-		return PTR_ERR(physxa);
+	physxa = xa_load(&track->orders, order);
+	if (!physxa) {
+		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
+		if (!new_physxa)
+			return -ENOMEM;
+
+		xa_init(&new_physxa->phys_bits);
+		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
+				    GFP_KERNEL);
+		if (xa_is_err(physxa)) {
+			int err_ret = xa_err(physxa);
+
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+
+			return err_ret;
+		}
+		if (physxa) {
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+		} else {
+			physxa = new_physxa;
+		}
+	}
 
 	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
 				sizeof(*bits));
-- 
2.50.0.727.gbf7dc18ff4-goog


