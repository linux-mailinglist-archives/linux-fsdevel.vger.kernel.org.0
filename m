Return-Path: <linux-fsdevel+bounces-62751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA023B9FC3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4996256236D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6198285060;
	Thu, 25 Sep 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcYXPhQt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752272D191C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808520; cv=none; b=tf0m24XR00y7Qev4DSbJcE7D4xpZRSz0BDfeY0FkxzY7DSAihnUIvgxMIvQ2EozOhTXFBUgVPg3d1pfw1LC3T2c64mHPu1JX1R10Qyrf1TJnQABga0YigGujJF3epxE93yOsReA05NcD+WWYy/FHFzb7wiNFYafH1JsT1nShVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808520; c=relaxed/simple;
	bh=zng85sA8+SsVec6zNo4TiEoP/H6f+tIcV689AAppDzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtYIref3aZUPJQK74Yhi9G6RAGouzzrl/GEbf8HQprztWoZTxjP8oH9qCqH14DNXuM20wjDKQ1+jz3Spd2rffew4geGTXhre5HweSVPGjeCQVnbTAcDAqmuzJZdtwEbDrrtNXDubH6kp372r9qIIqNJvduzFFqAIZQVgUORtU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcYXPhQt; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7946137e7a2so8794266d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808517; x=1759413317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYha/ksIy3nvgxYlzdJIQEddJjIGfcGOB5STOc36XYg=;
        b=EcYXPhQtkXXRN7OTov2ez9YRzmFF4pdKpT+1C30EZOesc7+986YR52Y2wti6MkR3c7
         E8wqFyf8rFflFZMsomMVUqAqz1qa0lDKweu8x2Hwoi6G/KLwNmWUHtKHWknP0LAKERIB
         qMqkB3kyT1A+QER7Kwr+6/CqyEx6z9jkqLgfoFYHFadzVK7y7OSjSIg98jsY8qrT0iKu
         Jq8vHlWdf7tS/YJ8nkzFo6oKXWOe71Th1wxLuNx9NUXVG9DVNzfkDe4ESx9qcFPB97zB
         lGGXENCy1LWY6NV0oA4kkcAspPFsx5oGFhffY8U2rg5Sdkp6fhIg7Es67gPHi0HRhYVb
         TcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808517; x=1759413317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYha/ksIy3nvgxYlzdJIQEddJjIGfcGOB5STOc36XYg=;
        b=shY/2Q/5o1bF67O6J9sYFc3uO5xzxi9ENxY4YNNE0QakoK3Dno8rhw+ODJiuOAaTE8
         GjidqqLFQ/JvGGIKCYWyJfl1LdFDqcZwjdPoXzWmpbPKBya2NmMepA3PRbVUPHPYPaTG
         MDN56xNS7NW/ylbb15kRPtptmFdBS82VYKNB3I1Hyqh3f8/prQVwbRQ19mnzEFLm0qFJ
         x+WTt8PxKM8IMX1XsKU5T/yrS8Oa1RUNRQ4uXQRAgT1yLzbZ5I+jbC3DScgVStrDWICJ
         I4GxB+cEpHYzQdQXPTudNo4hPDQUTGwrTfaLM6hYBskflLNxniI4w1UtCWe3frNLWY6s
         vRbg==
X-Forwarded-Encrypted: i=1; AJvYcCVhoGwu4nEhrm6Gcgsa8KagXNlkhqNK4UGWJ4BDx90TVLtSFplk5zuY2L6FeZxwIK9I+8RcTQcOxzxk8v2d@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+ax0b7fpN9yOh+H0tBdxlmUSVhAyv9yCMM25cwGf4no7y9oW
	Fg/r1pQFiWqXKrSnvzoE0QCa2TUNu11GxK+xNwytZJdSnsAeqjGsuka/
X-Gm-Gg: ASbGncuHmmbrQm7DBPS/NPm2i16TaD2DwCyzhHjfUmRO7LbrAQYh8SyqKqdDEdhQVFQ
	jrPBeTD+VG4Ee72AlOtkV6usARlKUOXbJMQ4XzUUizeIgB50DAn/pFpi1mazUq9IcMf/HlLi9Z2
	U8oVCvY2NxPJZoWV+OCphV33j6XXUDhMUFrJp3FcgR9KIOaGU6pcfTP5F40B5Mr8QGI41r4jIXU
	fsImCp2YNiUo9FwhTiaZRCLdaOOyNCJ3X4vH7chqSbC+n4URYbUjdsrEXM78qBKRUi/etdD1FGH
	3qkYsnpXti/ia9uzfiuX1arKCqlqf9LzY8PAPjGP94v5On5L0TwHBc4DkRwvTVpExUB/rIPj7sn
	4zW8R0kLFVEVzxpa7lDmNRQr8jAl3zWb9iZDUOcHpUvqXIee1mczdmn6PmDogfuVpnTqvqjqA+R
	TYEEKGtm7VVO4l7tobZis2Q+vWhWM3h7+3Gyvubp6+zM3dgefVDOBk7Od1tj660la+JkY4
X-Google-Smtp-Source: AGHT+IEZqYEZb8mISdLJuHBwRf4k0Tn3piTiphxdju20VgZskXS1fQZSSYTbb7BgZgibnFeCDmQS/g==
X-Received: by 2002:a05:6214:27cd:b0:78a:e10c:1f6a with SMTP id 6a1803df08f44-7fc2864221fmr42029446d6.1.1758808516914;
        Thu, 25 Sep 2025 06:55:16 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:58 -0400
Subject: [PATCH v2 10/19] rust: macros: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-10-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=1049;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=zng85sA8+SsVec6zNo4TiEoP/H6f+tIcV689AAppDzE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIVNC06tKtgyxIKxAK3EObC8MiCaZE3yn180AX/LsynQ5F4vys0WrFsiwfjmzPM+0UA7iPHoZU6
 G25wrGtAh8gk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/macros/module.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 5ee54a00c0b6..8cef6cc958b5 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -228,7 +228,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             type LocalModule = {type_};
 
             impl ::kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static ::kernel::str::CStr = ::kernel::c_str!(\"{name}\");
+                const NAME: &'static ::kernel::str::CStr = c\"{name}\";
             }}
 
             // Double nested modules, since then nobody can access the public items inside.

-- 
2.51.0


