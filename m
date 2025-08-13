Return-Path: <linux-fsdevel+bounces-57765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA084B24F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990301C23792
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D02FF16E;
	Wed, 13 Aug 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPblPfNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481D2D1F61;
	Wed, 13 Aug 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100799; cv=none; b=Gny71X2mpbMAuEMkJhcU5kg3EhW4bzXnWs8FCYGIre1cNNOUcWI/RtBWuD9Kin+ALouETzoLs4IdlPdJIItgsnSV96qhlrqsNvwphaXaFC3AxHPllrm9ULMQV00Q/rlWcs4iNUmj+08d3jLiz6tGMFfvtbzaJJ8KEmL2MYSnFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100799; c=relaxed/simple;
	bh=aFmL2NR8fBnSS0Eo3JlIIR2kUEbvCMcpyoIscPmgPvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lz+ku/eZq2Ku2saTPHRM8oC8rHsW4k1aO9HnFTIXDS/66t2cwPzGH53z4+SH0C/+IQi3vgwZZuS7ulv75b72bvzneYa0Ts8bZiuTPCqbrk19vroKWQ8Oa5lAktrft4HNozvNVMEUIP2m2oJ6miuO85ncFyMqkqFYm0l1hBYMmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPblPfNo; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109add472so359971cf.1;
        Wed, 13 Aug 2025 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100795; x=1755705595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4l8i2sEeNyD3uPILdjK+jaPwYgeKMm+ZntjpvS529I=;
        b=DPblPfNoV9HQUdY+g5poFtGVu5+oTsREahlkQ70i/c6cM9xja8VypObLIknuPGsKHp
         5axji6PG6AjfLRLPbDx9DGRCqphppi6sK1EhDDdCpaES6OKibcbb7tEjqEBJ1ge9X8zh
         5qvJ8ySb4MUWqUFqR+IYFtF5ZaYGOdmXK/kKKMNQ+qJifHnaXY/P/vNBQ+/Kywq5AkbF
         VPldbkpyVpHx/ib2F3hqi3ewHRbU9kwDAwl7UF29GqoH+6aMauXZnJXyIMfGXY0amvrb
         wjsTY9tRJpU14VUPAcrzjfmDF/6Xqe4QCjU2SETHRLXdapNC2gexllIn1Y0tn6aunDxH
         N2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100795; x=1755705595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4l8i2sEeNyD3uPILdjK+jaPwYgeKMm+ZntjpvS529I=;
        b=W/cslwVNTY3o+iyneSw/6jN+l0KAAXJ4mdTMiY9s5JrWJJ8zoDbr5W739kMbjHYhTk
         WhPIZxYh8t1+2FK7C4HUQqjzPdcC0lwVamCHWU8EDN3o8pa8tPz5XKrWjW3vU9QzjOC2
         amdlynvnh0D64xT44562k6JcUBmH6A5s+fQB0uefVNvNQVWPwHErkfw+omRV0O2dtx+R
         IgCaNgz4YBglMV5R1bbAUmjzKn0TOdovSiaTLGnEE6Lkj4v7h/+YDXhbpprRQ782v/wt
         NE4uaPalp3pE1T9RsgbN93uuc4K99eeFK7jpXrPs0Nysp8OrIS5rgvpRNkvzgXHj0TXl
         NX8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9CX5snygSPzPwleFQWBKThyqWh8Idw//p4aTGjEQ5zDYWOqcr+N9FGaehUhAH/wKmkhWQ/ZEqAmD1+5DNQAjP@vger.kernel.org, AJvYcCUqAdF0Zqd8NHA1C1r0dV8IEx+zAir7Kek2Oh94x7SsaoGavUs9INFrEgRTFTXz19CA6u5UM0ew7yTSk+m5Sg==@vger.kernel.org, AJvYcCUxX7jcoXcFhsK+/8C9/FdRx2KR3uBTaTuA3WYp4JwiJfCh+kroiOtGLe1dxmWbbnjQjjRa+G1slTcz@vger.kernel.org, AJvYcCV6J1GCtnzH0c5figlf6To+K2Ksam90uBjz5EpOWX9zRv5RbRv0O8i6kgv33+oPffzm/eeds2pi@vger.kernel.org, AJvYcCVe0fqSDVeLdX/wdepI+A1ZG50ZwciVlDok0nm8OdV40DvZguKuJXpji+I9+aSqtiFOVr+P/qIt+biBNAs+5Uw=@vger.kernel.org, AJvYcCX152GsgZ2smEDGRL11vfEyKUKuqMsg97zAaxOIfQtZd4Ll1lHq8yxjRETPLFGww75Qi+IhRoRh8o4HhA2S@vger.kernel.org, AJvYcCXTDP58PbK7ba2nBYu3rDc+q4s3Z2g7fFEDh0fTYKqWM7GwlS7+4XiUEvx/LwBZGQM/nujIU+kHTInx@vger.kernel.org, AJvYcCXv8fYO1UdPENNbjhCPADNCtOxFSpokj0LXbhra9OrJU8heWNGiPK6MCnJtdQENbP/n/CMagcul1W/6dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyENzgtzZfJhN1EIr6yqxD4tangBsMHbKPVRpcAgTucDjPMHE/A
	WydBAZZ0NEf8NixHROWo5T1W8lI7kfgkRhooUhdSw07fW2/iJ4ptnTuV
X-Gm-Gg: ASbGnct/0gzPHdP91b2gQ7hJ7p7+MFnlAwroQzkJjgcdm1Zt5E2dUj1PB/QSL6TiqbC
	FghsOMXQcxIQ5W/xWbMqlHiLcNmGhBMLLC7eht+KlqJtDcp0+/JK2nRomKX35++I+7zvzTCSbHT
	F71ToS0IZiTo3FMlN9/nQi6pRfYtQq7jYCe0YNRnhKMpay5E0tt67AmArSGMJdSPUZ4+bSXpq95
	FJm/qSDNqDpP5VwLbcWBh4gwob1IBcR8LdHfqcBnGaMMldfkwJDc9C+ursuv4gv5MY5jNJRVBby
	GmblGv/voYBE6dew7uRpaqSh4iQc4qyhxC/68wT0Hx3J+sl3ShoZNzSCbLXtnlqKW1OxDXLbRTm
	oItRt6rA/glEyRoYtrs2wCJFrShQcTiTHc3XE56TXpEG1c/zBQuGKAr8ok81rXoYIe07mXXLA0L
	ywxOAI+q7XwYBzp4bUl29s3WgXV6jmW7QevXdsJrs=
X-Google-Smtp-Source: AGHT+IE9yYjN8Lj7sjrBb5G5y7e+9Lkv3po6+5dMllJMdJnuYbEDB7N8jixA+pC4n6efn+2e5Jn5CQ==
X-Received: by 2002:a05:622a:5986:b0:4b0:89c2:68fe with SMTP id d75a77b69052e-4b0fc8b7decmr54119151cf.52.1755100794976;
        Wed, 13 Aug 2025 08:59:54 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm124482211cf.53.2025.08.13.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:54 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:59:20 -0400
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
Message-Id: <20250813-core-cstr-cstrings-v2-10-00be80fc541b@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755100760; l=1049;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=aFmL2NR8fBnSS0Eo3JlIIR2kUEbvCMcpyoIscPmgPvI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIIKVbMeN5Cnbru1lYfayjvN18lKhXLa6k9p0y4VX9OuLzFcCKlTUNU/VwLz/Ibsog4LzZdADpB
 02WR8TJkCYgI=
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
2.50.1


