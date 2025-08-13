Return-Path: <linux-fsdevel+bounces-57769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BEFB24F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919C99A1545
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677C30AADE;
	Wed, 13 Aug 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY2FxXPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986F309DD8;
	Wed, 13 Aug 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100814; cv=none; b=OwdZjYpklaEzkpfKbTu7wqU/+xlS0ImFnZZzfBgLsvRAAMdjX3d77sBLceNaJP04cwd8XOY1HnogG5GiAFjA2z5cbCHjDS9fGc6x84Wj5BxFKvRRNEO+SrPJtOXkS7tOesHcXmcOBMB1AoSJ7J0I2/niDcZAP1pG7rsez5aGl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100814; c=relaxed/simple;
	bh=bPLaN+gqrTPMFDwtsZirXHerPZbjjybhbgw7exIeXKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+mBptM/h1b0CzLptJ8Af6f4FNEgtFVqrojWuCjqenJx7nwdDoxKmbaVbHZSHTglYq2q40hHwDVuC0QBfvfijA3MZ1BlCqpzDbgoTVwKRuodRXtd1QcALiZI3i5AUrdWVkiGyXh7BOr68giw+czCgOLG/JrgAEudxokPjYsO+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY2FxXPl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109c6532fso219921cf.3;
        Wed, 13 Aug 2025 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100812; x=1755705612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIkNXnCZ3MkK2KcZGD39lF3QssIupNbx0seswPTYcjs=;
        b=dY2FxXPl/fVBjtlpsaHax7vmhfgiZpqvwGdNWZMePanC2DjJnZzD7nmPB/ntNXQ4s4
         DlvCGDjywoaazl+d1KFoBz/rNs+97giIOEFTHn0LZxbtLgsGUwYSemeqLGxwyJTAWEIl
         CV9g4xENh3kWY9hpFrph/DKAKMhh+X9qvS5jDQH5mteRn1cE7v5tAJm6n8tmcDwAXQt2
         f1vKk1xOxXF0boKEpPzOrtKBFKbYeO3oIwfPT/Ad0c7CC1mCkNlHwR2EC3IXJjviHmfB
         WCnAVTrNgXH4DvuPKqx7WffBw5lgZDj3mhN5kaqPousRyK2cuYFEvaR07ll9NnT9tnDH
         ISwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100812; x=1755705612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIkNXnCZ3MkK2KcZGD39lF3QssIupNbx0seswPTYcjs=;
        b=Jkx+SJyeDMVJVZFXaj18jx+5nfPbWt0qB7OOFfQNuuHmJ+FQiQ3MoyhyxOrPJ2Xygm
         tssOn+qYQOH4S5/N6IPtfWgcLU3fcUvn7U37hDV1J6I2m6PCF9+Zx+kNd6aMnlUmY9NO
         JSdsgYUQWJy9cqb5jy4V9Sh6g7WweJPlyUhmhZDvnJMPz0U00/Rj0UcyTtry7977vle+
         S92QwznSRVlXqcW4fGibuZELJElPVkUCH+vmtV5N6DZ6LtRmWWyT/wK5HzypdGEEr1xo
         6fvaTlspGRrgffdi52WlYf6n003Q4uuAakL06PWRnUPfJPzjFBJcux3WISvhXyBNTE/u
         TYdg==
X-Forwarded-Encrypted: i=1; AJvYcCUC1xn1ELPuLjm0GtmevayGIfind3GFNh1eAS2SEL3rvoW9kuW5vk2R4Y38OCRk7f+ZUSx09qK1@vger.kernel.org, AJvYcCUWE+vwuvzZZTPUdo0dNsjBzKpV5MNdqU8kkjiZ+ZMLnRpUxsopMOCQjToMhob/8cQZ2P5/x5yRj1bLzh1yMg==@vger.kernel.org, AJvYcCVDcBVF5lbVFQxISSXg8OcqNrtWSR8fq1c8lxENHaUAN1xWuO651Z2zLJ0V/Rxn9XsmV1fftYBxpOd+EEjj@vger.kernel.org, AJvYcCVlQAyiR7J7rTwMdRKTScRDgK7+p6MeYAWzJjohQbSKzFIfAmF7Y7Tf+v0GCev6hH5oo0i0eTjebKu+@vger.kernel.org, AJvYcCVmYsJXfJVogzn2JUERWITIbeoURdq6YSUdAWiyXHNiBDWet1IdJKtcNB//wPpbCCrpIW5xCS/54569lg==@vger.kernel.org, AJvYcCW9oWH5G/IsCkfXez1CfMrcVVRIdv80iJ/r9rHDrk0PsFSWCLrzXCWpBW67CloervVfFl+HV1JM1rPlGpXgNRg=@vger.kernel.org, AJvYcCWTItwvsu4B1kMyYqBj4sbh5kkjx5r1JYzbm9GtTqeoXxuf1h6gWInj8BLFsjUufADLvITDPMlDHAllKc6S2Gd2@vger.kernel.org, AJvYcCXkhkg8p/w9AEhU/igMgejnDXAiVnVwdFM/fY6iaGn06Wd5+rBvvf+NVYxKT/JE9uTlffVHM4sc0t2r@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHFHDZGbIztckMaXpBU+O3osKfN6S1zHtVtfKMfKqRwlqrSkS
	Q8XuR35rqgKFMTrTyMDPg6rXTqlSIh2JLO3EM2v0i+xwLku7MTGz436O
X-Gm-Gg: ASbGnctFhfAEIQIbLdKHiEZdklGj5RbPnWg73i8ge7vwiLj0AJ3GirhwHoCcYtl2ODg
	DF8i53EDbNYKNhcI7t0JwVKESObhpWX47cdwtZ3dmiAAbMSF18S0TBtxodwY/bK4XuJx8Afoq8D
	3xYDZRJnBH1etBaFOYhtGclkzS9LNN3E6/a2DCQN2fqDwTywz4DIDcv2W52Ss0pWlurExXggoye
	X8H5nh50ug2ZxboqoPvN2JssCJYHvYSSaQu0O/XabzGHhBpAe8t83/T34LdMaC9dfH/nWhxBdd7
	1+zlBdONy3QW9UnSiHjdLmD5nV6OUDqQ+DgOqICBSWyOEFfn1aIST3CqyS04AGj9Uxe/e8VPQCb
	bfrkKzWZS6sJ7loIapIaG0L5WyJBjLwEO6tUqacgfpqIo+PK4bM7lCdu59uuhKUIhVaGJm7+U08
	ASMRznZHZkel+Fs9ZykA16kjCVEmUheVd3yk8kocE=
X-Google-Smtp-Source: AGHT+IGB9luC8u+YHIYmHP0t2yteUQeoqnZL6RrlgDzQaKsQEO65H9dR+1IZpvQ5QqTEsI36AknLxw==
X-Received: by 2002:a05:622a:120f:b0:4ab:66d1:dcdd with SMTP id d75a77b69052e-4b0fc81b73emr47127731cf.39.1755100811571;
        Wed, 13 Aug 2025 09:00:11 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:00:10 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:25 -0400
Subject: [PATCH v2 15/19] rust: seq_file: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-cstrings-v2-15-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=1328;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=bPLaN+gqrTPMFDwtsZirXHerPZbjjybhbgw7exIeXKw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGCU707SG1NbzTSxJCLbczm9uIyWPFy4Tb7N0AGhHUZZY73xh+gbylKW2yVpu6ZFFDVhAcw2yEz
 pJfQCnF7rkQo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/seq_file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 855e533813a6..518265558d66 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
             );
         }

-- 
2.50.1


