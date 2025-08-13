Return-Path: <linux-fsdevel+bounces-57763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E19B24ED2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4247BF483
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340429B795;
	Wed, 13 Aug 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfQsaL67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BE294A17;
	Wed, 13 Aug 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100792; cv=none; b=MXjDJx9f3KcXExNoqU4N+y6unclBu8aDGuRUCgpZRABAwE5XfRqPUb2erJO+2ueBHdNESYCDk8mridRd76BVftk7WtqbSJZLMuRvlAt7NUbtphxq0pQhi8WuTvM6r6A0Z9PZrYAwX9P0t84J5atXQjH5+tFzpQJTT/lXmcFcM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100792; c=relaxed/simple;
	bh=UGSTQZC9H1LDaPmLjFq4B1ddEUZz53neJbsEkAPyHbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VwJxMinDXZOKo9CxZ5GSVSsTSwJ+UmJOaifACjampM+JT7LyUKHZCWiN9vJUDYcvcl6Qig5RzPrlf8fbpGP2xpHPzD8VieFGVM7KehsvyufgqEWuRqEfVAuRvo8ssA76OvCDcDxdf8Mbf0wGHmlFYwyupNxeSxdWnY7Z0JPUrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfQsaL67; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b1099126afso545941cf.0;
        Wed, 13 Aug 2025 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100789; x=1755705589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZjL8BuYiXMAJDEbNeQ1u7fLpcTiw+Jir0VMSqwREoA=;
        b=lfQsaL67xCK7BAUMeftvCxg/lA6buBtuyXIggIvGzAaFjQOzuyJMEU3Ba4FrasAxqx
         SMT6zQDee6Z2SCrj0EVweS4OJS9qEaKmo7xJ/amQN7drbPHEZvlmqO5iKn+Xp6SWQadW
         Wsu0bu9bZVjRz8emYrt0DmEs+rVWQMiI/CpAp5jlkpVkDcB01BhoTy7kwiaqQE7WBllN
         pi/SZub2EoCPJFlYbsQyw5u/XUeQHSBbiicKEqbRTFk3z20Dtj9WZ/hDgEEr+vgYstF3
         RUDASncaHmI5zjMeR35V62+OmpUYRt9RuCsqr/sS9FsZI/++8ChZe8mtdnvMjyYwoikO
         d+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100789; x=1755705589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZjL8BuYiXMAJDEbNeQ1u7fLpcTiw+Jir0VMSqwREoA=;
        b=KyOX86EZKp6QLe1+qFJT7+u76uS9vzgwOJHoXapqxKRxJflD4hZga7QplYBkCSOmuk
         ZZcLaDiojC/vhC+U6Q1jN32VDRD6merYMFDOD/rgX4ZCkoS9Zyh/YsorxaeUDptqfwGn
         5pE0irWZvz59VxQkrJgUbksmCMQMDFddYj/7kRf2rS4zndVeQ7TWa5+FRr2Su5WYHXTM
         qiaAXF4KvVSKQtS8hkqFgh4CHtqW5aMXSkVXM1ydGFcw9BZVUrcMQA8NWxS8gWku9Y8G
         hsWwAizN9W4CysI+rPG/6c7Ps7lIve7QEyD4q4KiyxwPOCwLvBiSIAIvuMwVffSPyN+V
         b+dw==
X-Forwarded-Encrypted: i=1; AJvYcCU7beikBFmUrBj8Y7K4znfYnPa/h6lHZsyGQZtqeOeihzCjwUP55wHr4UVJ79jDkHB330Hpm46Fcpkx@vger.kernel.org, AJvYcCUZInhtsiAYVHNWsNS0+m7VC88TgIY3fFcMmFoRXlNVz49y1TMLc0QnX2DG93RjOwNEEVQyxnsuV86BYw==@vger.kernel.org, AJvYcCUeBzm4bbZHL8r7PYRjwHtABLb163n5NMrDnyB+S/2su3hmBQHNlxYS49ajy7KSBxHN9ibmvGeh7I8k/lLGlw==@vger.kernel.org, AJvYcCUv+ixoyfGodZfKbN5N3CtS4pNQIkAn6KZUVu3hh0xHPCOnLUEalafGUXWKMTEgeuAW9RpkI45PuEiwdiZdC0CC@vger.kernel.org, AJvYcCV5gQkbuIKwsRTIdxF0rHzRdNkn0ny0xvwZ+EvRjCsfiTjtvcHKD7AVAPHq92j9z4pIWCv6jn5G9PmF@vger.kernel.org, AJvYcCVNBKGl6IiBvb2QdshyBkNvijLM8ef4OZ+zBhT/FPu1bQCLS/IJjPfOBdJbS+Kgb2AWfRHZpQXt@vger.kernel.org, AJvYcCVWOkWML1VpOTux+q2X4cFhn9dfQhi1szBpgfkoERc0Q9dbSlkFE/gCnmkZbLDCHDVMKxhT8RUzorUoVluNNDs=@vger.kernel.org, AJvYcCXi1sa+n/gxkDiq7LzWSYaniCaeOt6o3H3WIC2/kyKurMiXsJXj57z2d28qf6jO3TdpVbIEet2PgdnUMmYW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LR+tKKXQ9ENpxpFMIdB295f2oQmd3WvxygSphXU8nRTzUNiK
	0KHQldtQLJw2Ij4pPlu+ZHXEQmfSVt7TtovAgehYGJnRSQ28Di9lgNFq
X-Gm-Gg: ASbGncuXNxahBZDcj1mJrAce+x2gv6CL8ebZ2e5yg3MTKtfM374TpXBAwiAo9EUlqyF
	AAgyyaQZYPnoEw4cWVlmziMxMGOS5pUrpSk0bgoLc3Osi92G3kjYejZs+t3sC3y1pS5RIjP4gYI
	WvJcCtjJ1+OMHInw2MESNTnP6iN12wWuDloKJa1Vtvt+vf5B0+uEAuBfCcB8r2KSb/tpg1V+gp3
	/Er63cHqBLs7v+e9qc2iKGa3EG1rD73KwlU/xuGzx3UAdoZXZvlHH4NRJPjRLSzQk5xM7qPwixN
	4UH8q3Q0ejOPB+fKxmFWAPabLaNq6nl45TF5H9EjvzfAfl+tyePA5WXkeswqw91Ew3PE2UyFDyI
	ryf5wSb3hg/rMXfJT1l1jeupUm992idR4p1HTORTqao4qr1EWbmYLZjhXGqAOTVa3tKtVv4MTSa
	TSNet5c8RDHZl50R6oOuTcUmSCLNK3
X-Google-Smtp-Source: AGHT+IFFp6aIDI6QZQPb+JyapqaAj5uYDYsz9npJMS7fiT1IGSQMfKW1auc5xK12YIuMevr8ggZZCw==
X-Received: by 2002:a05:622a:4d0a:b0:4b0:8f6e:d70f with SMTP id d75a77b69052e-4b0fc8208cemr46654731cf.43.1755100788813;
        Wed, 13 Aug 2025 08:59:48 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:48 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:18 -0400
Subject: [PATCH v2 08/19] rust: firmware: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-8-00be80fc541b@gmail.com>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
In-Reply-To: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=1629;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=UGSTQZC9H1LDaPmLjFq4B1ddEUZz53neJbsEkAPyHbw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG+vCCP6hDccm3sUoowPnpwpgqqFe3IfCMbA99v8SH1XNqg9hEr3E2kDwI1zkxYST/aT1F37NuR
 CZw/X51tLPQo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/firmware.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 376e7e77453f..71168d8004e2 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -51,13 +51,13 @@ fn request_nowarn() -> Self {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{c_str, device::Device, firmware::Firmware};
+/// # use kernel::{device::Device, firmware::Firmware};
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
 /// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
-/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
+/// let fw = Firmware::request(c"path/to/firmware.bin", &dev)?;
 /// let blob = fw.data();
 ///
 /// # Ok(())
@@ -204,7 +204,7 @@ macro_rules! module_firmware {
     ($($builder:tt)*) => {
         const _: () = {
             const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
-                $crate::c_str!("")
+                c""
             } else {
                 <LocalModule as $crate::ModuleMetadata>::NAME
             };

-- 
2.50.1


