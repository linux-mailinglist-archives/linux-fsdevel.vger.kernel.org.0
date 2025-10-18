Return-Path: <linux-fsdevel+bounces-64571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB189BED627
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEE1400607
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41721265CDD;
	Sat, 18 Oct 2025 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q27Nv88l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B925DB1D
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809538; cv=none; b=tQdBosj+HKY6TBUnCIr9ybP3/rkI2TtohKBzelW2Z9cE2HN3nE8t+AALsMWBuChFWvhFfdN/jqDPvKVs5Pw5jTSFVD8nDU6aLzw9OTwm/X0bRiQ/kkL13fJK7YapWNJB3zbtHEOI9ujHNi+YZDh7NfobGQHnJHkyGSZLqNin3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809538; c=relaxed/simple;
	bh=5IzviSKzcg5QXxBA9uZe2s664KTsV8Tne2rtRwo/bww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3+nQ9GNww008qgT1nF1AxU9KlWIl40aIwccvee3kQVmt4QtGwMzWsZ2pyI2qdOawlHjq9mUlJ6svF1sBNeShrhmxRy1uLKCflmksUAer5PpyRGy5okOgO8aVcW8/JMFdFwqc+5BzKBarPDUnqOgLeyez7CDKaefBeJp7AP69c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q27Nv88l; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88e4704a626so450603085a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809536; x=1761414336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmofoJkHkMxsaLhdlprPrmfRRb4k8Y1fAGmfllLm4kw=;
        b=Q27Nv88lwG8WtOScTJF+LqJvOyeRmP4ZDqM5t9H1xBqWmyaNT4kgG010V7qDD0BJe+
         lE7JSXpZCE68Lg5S+jYdIOOHuGUA9ed/NgdLWQ/K5T02Cy6CBqVKyR63a9E8+meG4g45
         POXmwzvXEoppx/+rp62KceldkqkrRkdGlCiEltex5huljAkLFiHsJw4zBpdUV1Yievo9
         iEJFa6qTyfMlFkerGMUrn3eKhBLdJnB5WbBM7Z39jMVfYrjSAARmFbiuZUpBc62pDorR
         NU3VlntTD64673vpMRmsCnyoDtl6i1xhqAJqCuk7RDNnnYwHRSiPLVpneL5MnAgadS5q
         8qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809536; x=1761414336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmofoJkHkMxsaLhdlprPrmfRRb4k8Y1fAGmfllLm4kw=;
        b=wJeg+bMR8P2pgaPglYBt522SoWM/e10BEzZd0QDH1ykVdNw0lOtseFHw2ENUaPjM7U
         ZewQ5XXVB/EXaf8u9J2ykHi3O66MQMvMUptzqm9p7UAfiFTrL5dKqjToSKJi0uBkIimE
         JMYIgdoMDsbtXE/mp9KmwPR8EMjNRsV6t5aArd6pq9pQ6dfAVDkVy33YAUBuy+8pKgLK
         hC1rSVVKU5oTIDP2AJFXLHZJs215bn9HZlZDIjSQOZ10NK9GAXgCGgTBhE4NKUg6if+f
         SCu7QhIduMdtJes6vtj/5eCfBc97TnCT/LdOixoZM/8fmIlgEKMyEeCf0cKfPEqQfFbm
         0q9A==
X-Forwarded-Encrypted: i=1; AJvYcCW4gs1CR3Ule0X9kJ9HPnxMQvIM/E9ST0FUZcuBlAkVFAKlv5oLqMJ+UwmzH55wsULJCS/INugxGkcAEdft@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuv5uPls/hM5xjBxWms+mD6el1EljCEI/oNbGc+aL9McpDOSO1
	kMMxx/SxwfTV0Gwt3hnuw71sE9+18u6R/P6CIwqNJq8VQ4aCRVA0xitf
X-Gm-Gg: ASbGncvSrxuEMXHCqezF6CAb9SD3pQyKYz7+oLkQSidxA/FX/4gO1OyLOB6cBCxA3te
	Qxt9TalP6zVMGGnhVca4/dNUowfPdeVXFZfi8L5RjdxBfZirUyH75qrERseSxhC43OegOxgM5XH
	CBpK+QGlWRNPQ7M3xMiNSS737e0m9/AK4FXVFH2f7dJQB5VfebmNxlVgzBAB1bGbtmTBwAE8zx4
	Gh1DCvi67aEJzwoaSnybnukxfBq65lWoNgVX7GFdO0iO2wjsqkgZkOhMd1FpQYZM/cU5ie2dTKF
	juZUEjKni2y0z16ydij2NDyf/uJiCnR71wvK7ECid+RGYZZH9hkBv4Z4WQs+nJl2qVGs/u6v1cA
	KxcTXQocywFvnjg9amyTGxFKXBXQCVG4fw4b+FGzb8RoOGBibWc2GGPf1AIdzZKb6dwwHhZaV3M
	zsXJ+qQojTGbl2o+ttVRgzUdSvvbRgE4crOYbbMQ/lHcBvBci+SNkECi08poVG2/7oljgi/Fk4g
	C3JxgSBnpgdqslUQ98wWAYd7D8Y1ajS6FPLcVjUr1FXtra7ayAU
X-Google-Smtp-Source: AGHT+IHGPyNylAC+NcjKR3LVCwruQ+XagK91t9ZK/AgOi9yexcJC3Bdqjt9T2UkkZHJl14b1ky8RWg==
X-Received: by 2002:a05:622a:10:b0:4e8:a664:2cfa with SMTP id d75a77b69052e-4e8a66467efmr59406621cf.34.1760809535454;
        Sat, 18 Oct 2025 10:45:35 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:34 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:12 -0400
Subject: [PATCH v18 01/16] samples: rust: platform: remove trailing commas
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-1-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809526; l=1642;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=5IzviSKzcg5QXxBA9uZe2s664KTsV8Tne2rtRwo/bww=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDwRhntvVCGUiRlEkiv1zZeGhdA6rD6SNhGZH3QI1C43PlBagNvzfDvivxfFTU380ObMT25PMu4
 pe9SrdQ8j/g4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for a later commit in which we introduce a custom
formatting macro; that macro doesn't handle trailing commas so just
remove them.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 6473baf4f120..8a82e251820f 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -146,7 +146,7 @@ fn properties_parse(dev: &device::Device) -> Result {
 
         let name = c_str!("test,u32-optional-prop");
         let prop = fwnode.property_read::<u32>(name).or(0x12);
-        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n",);
+        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n");
 
         // A missing required property will print an error. Discard the error to
         // prevent properties_parse from failing in that case.
@@ -161,7 +161,7 @@ fn properties_parse(dev: &device::Device) -> Result {
         let prop: [i16; 4] = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
         let len = fwnode.property_count_elem::<u16>(name)?;
-        dev_info!(dev, "'{name}' length is {len}\n",);
+        dev_info!(dev, "'{name}' length is {len}\n");
 
         let name = c_str!("test,i16-array");
         let prop: KVec<i16> = fwnode.property_read_array_vec(name, 4)?.required_by(dev)?;

-- 
2.51.1


