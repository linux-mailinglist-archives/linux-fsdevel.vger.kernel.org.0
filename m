Return-Path: <linux-fsdevel+bounces-57747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E2B24E2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6A9B620E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEB2D7396;
	Wed, 13 Aug 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHFZStIw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B22882D7;
	Wed, 13 Aug 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099920; cv=none; b=q5oEtFIe8+MmPSfMz+bM9d11vsEq/lypY+3YHgXaNyG+CgWHKpSfpUnTcmIRICjv+cnGFs1GP6f4Xxc3FsN6VdojxJZFkSj/KMlB7yWowVsMVBIVEBBKArDKbl4nTcIblSz9TXUOKkORbfKJLruj53vfINPpMYSUFLb0npN99CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099920; c=relaxed/simple;
	bh=LjcCbHMUoV3TltewN0HsJRdLdRD1ekMI3/F3iYl7gdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bahdf4pSukb7vPp1oSORaRpa4cI2FUMWuw6DeT0wJN9NmFYIqRWCekxnanJj8Emb7LS3/JaYrDr0YZK39EcMG5DfZJfL2HnSaowWgGKVwXXDB/AnNsuTq2HcnAOVvWAFZmB9Y934xsI5I1S3dsvM9VBdPS3knsi675rR/9N0Bfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHFZStIw; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70a88db0416so812186d6.0;
        Wed, 13 Aug 2025 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099916; x=1755704716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjwWWlaiSxuBLrutmj24/qoTYXM0TidVt0sz9ukj7i4=;
        b=VHFZStIwJ4OZMmgAfTzH0Her9ZCFg0PztOm+vxDk2MM11DHkrmfb28Ia/xCuUbXXJJ
         mKnf2ZYGD0FYj8z4btZK7tSnFiOxDIWQLzm+uZklqi5F7pl3SYSG5t3wgvMwkTB4b7FN
         SvrJ5RuSsB6HGJ22E6ZMohEmyOPeSUkoqi79LEEA6zmKeo5dm7epA3QakZSRGtXSS9q6
         eIKRrXfQX0oghJ2ZdSLnOGObBhvO8zRUZJP5uV7jAtqP9PqVlgdlJtfjBwKdJmik0nWD
         F55TySfIIRo5+hTU02FIN77k3jnHvBjXUwWBBbbR7Bid5Xv5EgDP5QDfb9gzg/AZnubu
         zJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099916; x=1755704716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjwWWlaiSxuBLrutmj24/qoTYXM0TidVt0sz9ukj7i4=;
        b=TJU5Z1TnGOQz/OAeLaOp3+WrTWxu/BD8j9esiHMOVe1ST9PpzdIqt8GFCSAY3PhuoV
         urIUceaSGt/riWam4zJJYEQbgMgtN+vh+n2jXBNIcT43gFLwvEN9udufkZm3s91jVVhy
         jHQx79811wHA0N+JpIhw+VsUwGM6vL23huElwwHNvHOpgtak9PcytK7gTXIUgKkh0HvG
         rWI+UNJ1/Q74/4b15g6QF284EUUO1pqewub+1gsY3Se0wqjXx3S5KCV5ViNvftQMZ43z
         sVBX6m9HqTaNam98wrMY+ahQdv4YNVNOfckt2dEohQkvVH2ql1a3U2nQ+NBRfTNWiZi4
         /tCg==
X-Forwarded-Encrypted: i=1; AJvYcCUWJtR8TR5XwmZjaffBCFI8FO7+wAq+fPvjataovrla3x1CxZDB1YKYfPk3iKwRetQ5A+5LdMIBc01FIyMD@vger.kernel.org, AJvYcCW72D+PqlSigIttMaBH13gFXTCS+WLDy8tAI/NXOJWy6PQ21I/wnxztc/MWvv1mW1f/IRrfdTn8yGZFFMPN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vW+M+suMFUBP970oxU/kyF+/VOAmuMet2oOCc5f02l3WUMWe
	kczeOadqLe4aDt/pVYZHl5ZOYjcUKfiUhtnoeYL5PwpIv4eYDQjxhELw
X-Gm-Gg: ASbGncsXOt/K9SE0nWiUO3C0yoYhINWM9XWtBt4VIkAcrg8q4Wuo0f6+UAHuU1x3+N5
	tH2EvGGrlhsDkNa9Dn8sVdAxac+umr5w9jq74tLtGbORoZkQEp6NXKCeFA2wQpnC9iQCuibh8VC
	QexbN9bfV2lnyapQLjqTAvv3AQGdXV74JiWARlV5Ro005h3/YofLmF15KFsEm9cwuGxWjLT9BO9
	ToMGxt0IasNj5OtjIAzdgPhfz2ecAP21kd1CVuXr61SUiFngDPHatUNDhGFeWdWfNbYN6UPit91
	unfQo5sZrEz7B3pxvw0ITHhH3U7bEPGV3aakbhP7tdYTrhYcWB7HdZ0yCTtVZYEl8T7VHNtkxWY
	5WhMdo767aliGmTmnjA62tvu1ZbJP9sjsQs8MAZWb4zr5zVurIM5iDZxcDVVwMtqOJBhciaDs0m
	2m4LSGQV/rXDmciNl1CZBNkoaRh4eFkPpZQw==
X-Google-Smtp-Source: AGHT+IFo4WArkDrsCUK9t4B6jzw/aFmRiBWP2yrzAvS/zR6ACJmHYfP/VTbhopmm+LesuhQ0Tnd1Gg==
X-Received: by 2002:a05:6214:c62:b0:707:5d90:5e92 with SMTP id 6a1803df08f44-709e8969c59mr52606936d6.23.1755099915764;
        Wed, 13 Aug 2025 08:45:15 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca3621asm194127396d6.33.2025.08.13.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:45:15 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:45:06 -0400
Subject: [PATCH v15 2/4] samples: rust: platform: remove trailing commas
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-cstr-core-v15-2-c732d9223f4e@gmail.com>
References: <20250813-cstr-core-v15-0-c732d9223f4e@gmail.com>
In-Reply-To: <20250813-cstr-core-v15-0-c732d9223f4e@gmail.com>
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
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099909; l=1557;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=LjcCbHMUoV3TltewN0HsJRdLdRD1ekMI3/F3iYl7gdo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO8mU4ZtUTy2WAWiBRXSVqeaRSmzF3VR/fQVAMv11BPx81UtsH2jPBVrPoOeIFZIGeK9uRKIC2T
 lF7fw1KgGMA0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for the next commit in which we introduce a custom
formatting macro; that macro doesn't handle these spurious commas, so
just remove them.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 69ed55b7b0fa..ad08df0d73f0 100644
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
2.50.1


