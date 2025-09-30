Return-Path: <linux-fsdevel+bounces-63114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D31BACA15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 13:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5CC3A8E9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673C2253EA;
	Tue, 30 Sep 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eblLuuX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6111E1A05
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230284; cv=none; b=HBcqci0TyNX29ARsXMF/tiW4e74Wd7Rd0LPbvJvn5sPac2eoLO2mxbY32RWIDDPdAzM/Atk94YMOIIG05aSukkvR9igbF+aiFTXmbk6Y6lBggk/MiM84jAlVYE5UAIHXB6B5vSeKeErTjdBUKcY2V8LAFp/H/EGro69Os/fGX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230284; c=relaxed/simple;
	bh=rd6r3YZ5CreoOIGPhlv7qZcTbTgQxOS1EYltrH+4Vok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2XlYWppcZlDBqkFOE12QM7f/WLo7kgwBtphqu5F6wJR31ecvTpHZ1LdEaLy9srCbt1k0BY7SOEeC/gySa14E1qQpMTuwc522bRH6wKYPUiuhpuS3ReptVhKHuA1mGx17UesjtRyXDQ3GJdIM/EuOV0Sxkm1jTqlvVWkBlgnu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eblLuuX/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e0798so72126885ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759230283; x=1759835083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPM9cQm+a2uPRDlRKN6oUV7loYn+iemaYSScmwnHm2U=;
        b=eblLuuX/GahellGoPu7RbL4xOj4Uu2XBrdbde/Bv6Qy3uCBKLJSGEoK98khvYNYsGo
         eBdKMeDYb4TS8t9f+DgJLeUxAY8S0AZzU/98t47TvKEpXCf2lPBDXFk/lZoxNmfjUvii
         PqQd3A0MSHrLe0ZZYBHJVctYTsyVySHoK6VpacoKX4EXRBadWo09ljKBL7jQzsB0eqmH
         eFvAn+qPOm957mOKG/6lhhmBouJwXK2sHyQzoPhC3uKsKzucsUKqHgT46WNBPHkn8eV4
         eEo+nRS90RHqATqmK+30qB9BH2vAo7vHjWdRC/8Z9+iEz6a93fsXprTlghS3O8F0IMol
         XS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230283; x=1759835083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPM9cQm+a2uPRDlRKN6oUV7loYn+iemaYSScmwnHm2U=;
        b=PPJ/9W74FB4jo0QsBYr4/MuhxoCWM9lxyhhlGxm0RnWRRFaNn/zMoJkZNrhs/v1JWg
         /4P5hZVHiVF+ZRL8SbxVR1j8liYcd4zt3Kz4UNvBYBR4TIsNE6OjxiUS/+lmxIQuoVs3
         fjnhmvQoTjehsPVp7JKG5AIabN8IYsbcHmv6BNqq1zfI0k0ZuYaouiuS1/yFlINyYMDY
         rtnbjuAKNlBG93UOblIuemcAKEgHsFiNYMiinVsIZaWnHOHqap9wAB34h54e2xV9dEjn
         yKMRK7nP7+GZswdt1afDqCCtUmgiw1xXy93F1oDEJVXOC2UB3VTZ+E8kBcu3s41ewdv4
         GROA==
X-Forwarded-Encrypted: i=1; AJvYcCU4PwUqIz1hgCnoALZmHjrkf27j3+F+gpZZYrk20TSVXBAtV/OHhLIlOu7b5dAAj6XvHeNyedkcJw9bxaj0@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMRGqgGzU9QvF6bxBWjEP6C/2jmSsBzb1Kd0fRG5uNe9oKJys
	00XEFtunwwXrUw88kCTOCSOst5s6eK+nOEsLG4KGfTc7P5bbON0B/4zd
X-Gm-Gg: ASbGncu1buDeoMn2U9TrAZj0el615b49oUVIJBGVkoKZSLKLBHK56zEfk8f7f9EbmS6
	kXx3Mj1vSkMdpAdKcqFc4zhAN+bq/V+V68bIsV14ZRXR8P5bvvm3dil50fQMSzY2jiURYZ5JAwd
	hWUow2+0fDx0JSFoyu1KruWzJVd+5ptN5CtzydlXRcp+rB3dJqLP856Ejrl1I1BkF2uqNREWMl9
	9xHoXUtEfHxfLhsNxWHD1mjwactxGmeXhcJp1Ngyg9+/ZwZ1gMR9bFH5Kt1dJnboG2FaO7SZ7Fu
	xPLhxULUnSzE2uShR1Rzbq6EGumKHbV4XSXqKnkgrkT7/QkNY9UP2yRnGekC7pqMWqePcwcBHAD
	8ZfiqEOGGqqwaRVAtnWR4bdfmXd99uMA0IvBrzcUUbNFP+cbXQ0YrHrHILt7Wcg==
X-Google-Smtp-Source: AGHT+IHzSgoeQhshCVoioYm/kSlIiIPlDW7b2JR6FtckzXalSYNpdGWehRFnw4TklcYXNFKx4nNzww==
X-Received: by 2002:a17:903:2348:b0:275:3ff9:ab88 with SMTP id d9443c01a7336-27ed4a4e174mr220944555ad.49.1759230282147;
        Tue, 30 Sep 2025 04:04:42 -0700 (PDT)
Received: from LAPTOP-1SG6V2T1 ([45.14.71.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66fb07dsm155372575ad.36.2025.09.30.04.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 04:04:41 -0700 (PDT)
From: Tong Li <djfkvcing117@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tong Li <djfkvcing117@gmail.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2] rust: file: add intra-doc link for 'EBADF'
Date: Tue, 30 Sep 2025 19:02:58 +0800
Message-ID: <20250930110258.23827-1-djfkvcing117@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CANiq72n+tBB=NasbJr95YJ=HPgSc35uwKALRyHDOyh4nG6xUOA@mail.gmail.com>
References: <CANiq72n+tBB=NasbJr95YJ=HPgSc35uwKALRyHDOyh4nG6xUOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `BadFdError` doc comment mentions the `EBADF` constant but does
not currently provide a navigation target for readers of the
generated docs. Turning the references into intra-doc links matches
the rest of the module and makes the documentation easier to
explore.

Suggested-by: Onur Özkan <work@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1186
Signed-off-by: Tong Li <djfkvcing117@gmail.com>
---
 rust/kernel/fs/file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 67a3654f0fd3..f3153f4c8560 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -448,9 +448,9 @@ fn drop(&mut self) {
     }
 }
 
-/// Represents the `EBADF` error code.
+/// Represents the [`EBADF`] error code.
 ///
-/// Used for methods that can only fail with `EBADF`.
+/// Used for methods that can only fail with [`EBADF`].
 #[derive(Copy, Clone, Eq, PartialEq)]
 pub struct BadFdError;
 
-- 
2.51.0


