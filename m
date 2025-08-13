Return-Path: <linux-fsdevel+bounces-57740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF3B24DE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3EA3A9753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB127AC41;
	Wed, 13 Aug 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg7SU6t/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3178284B5B;
	Wed, 13 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099606; cv=none; b=druwsg3WrZ6zDBNQTsVcxwBebJmcN+LC13xWrdnB/aW78JvQzgShdW+E3JQUjGjQnmqKn3+qdXP+g3dD14HwJiPNJMm9PbBW1tBcQnfBMZL9wanZgfio9BHe91Z09I/nvYgUvreKMMFQ2HROTo8w8DSv1BmcTjtv9VTsQe325qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099606; c=relaxed/simple;
	bh=RP9BgmTgGLsZJlnOuBKxXo7vRURZVQnq5fRAl43lnxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ikl98TG42cCNX4u9uFScmeWuZrcyplKX+M9FvcCcU7iDvVVZTK7CJSqGmgyRFvtd6hCU6XC7z5K0cOrccjY/5Bm7Gs63BOBTvqMgoDePAQq+5x+ulT9iW1VJyuRpReGhTTVBx4Rrf62zQAWHMD/s72ryOywRB+EqFkGJ4T6LFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg7SU6t/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e86faa158fso2366385a.1;
        Wed, 13 Aug 2025 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099604; x=1755704404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qpsl+4vBrJRbJlqVCZp4ufITcVO/mct/gLsPqZyfMc=;
        b=jg7SU6t/q4khit85L6POZZrVL7pq2KYEjhC6K1k99xqAlKwpY3KNaTd5e8dJpyxY3Y
         jSoWsgRppxxW98SNQ2hsp1sGobDYylv1lxhFZSWX/mqsFl1ZO/NFwfdkZbV50OQ2fL6J
         hIQG5j0+MrqR5p7KN4hkSEQ4Gm0vbwGj4yYJIdQsEoXan0IfLvUUNAD5aELok69szmn/
         qjmfRZiRKmi88oUiMcAHfkcSChWlT0ox+EWtnKM6o/KffSVjCE+8KKf8MVJ+LQiK0hs5
         nAjQwueeCyL0g4AWrKQSiznfLRde95uzxOrtQd7fyzVSQxsPoEoDx1XCgIsD9vmIKxZ9
         8ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099604; x=1755704404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qpsl+4vBrJRbJlqVCZp4ufITcVO/mct/gLsPqZyfMc=;
        b=vU3i04oF1e9yTjy69f+spa0IRcBu9FcIFd0Q8lzErjXbKK1a+sBA9VHNWbuGNGdodL
         7TG7Kpj1e8SA0ikfmXNV/59VlQdDRQ/9DJIUwBm0cmLHjbYkp4UyYImeyP9x08uGDF5k
         u+ZPeTuPDzjccv20H9A2SBLAgIoovOZqK6UK6d4wI+9sqfCyB39hc0T0q3kQQpPaMIOe
         Nz6/XXThJYYp4WVMHvs87hEi2X22b2jK6jaUyT0T959Tx+/F5tzIogIL8nKr9NUnba4y
         Jig3xDaHy5YJN/mixnLPtSTpouDG/13XoikzQmK4Skk+Dkium7RKZy1RpZwVBRKs9nM+
         iScg==
X-Forwarded-Encrypted: i=1; AJvYcCUHB3pcmQZpKqnIwAL0P1/C+aQwh6rpT3aljqzASL3oDzBBCI9V91unk3qZlnTO4BVk4vmNIQTo6mS5dA==@vger.kernel.org, AJvYcCUl0HkLyhHQhLG1bgw6nt67ir6WJs/NhVySuGgCgScC2kPNj/BWwEwYdn/iGxDDuA5DsbbMiyKS5iZj0dZ6NvoH@vger.kernel.org, AJvYcCVaq1flXGukef0LuPmFYP+MmQ4Dgsyu9K3sszZ9WNzKp9IFI73hJBoSOyk3k4PnogdD5ZS1mEjPDYHE9j4C@vger.kernel.org, AJvYcCWLd1dfjMj/Wy/DCipx4wO5PxCUvq06amP9zfaxbvzF2icSTz7QYLjgnyhswbwI5jgko43hgmZftcW7Y6TEVg==@vger.kernel.org, AJvYcCWsTv6Y4Gar+iH24mun/7hrifpFJ7SYYVlgECuBAjxVT8IKtTlP4TC2f4CiLhsl/+vie3wgg6QmNmALc7MSGKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmAEkYz5vkVkmoq96BSCY23VxsPgAZ6dPvY377ffPsNiR0eIwa
	eUlioc6zbSPbvTMy5AViNo7bPlr/yrVumL2XUKFChiUYgLNJvlVR6YRt
X-Gm-Gg: ASbGncsGIEwWGxr1OH2l1YFUjnuFYT4oCyH/nX2uJBzQyeuZqwAlgkQkNvMHIIS/O9/
	qQUmGh4dEkvrJKe+ghNfz01xrGSZ4C8p3FCXkLONN+hABgoqggQt1M5PQhuEO4xE9hCpN7004RH
	QhIURDOQJNkuNHEi493r7h3H8xzfFMP/wjkdMknZiI4DNvlto3Z3ACZxT1dhmG1KSdcyTHhSugU
	LWS3Te/EzYyzwT35sqK7dvCVHtseC/FdwCBc8I0zenZOz1s5IUfcNzYr24rxzq1y5b4IErw6Z2h
	Zj/2vANOZTBYj8BVJCqnFcSa4yVpvRhritBFqHA7TX5m083hEI3RQm3vwE+aB+b8T31ktN35rMI
	SBi65Psg5YoX9i5JouzcIqWneE6pqWRRUH4xyDfAI5Gnf/79CLtjD8TiwgYI0XZ/Tp9dNrY6bTm
	gQ6/sK3wfv3yND+s9Ds7JvUrsA+0S93LRSlg==
X-Google-Smtp-Source: AGHT+IEuXl9nU8BxNMaZcf00fEBMhN8CPnsH2MX5pRIR595Bg9FirSB63Hs35j+kk9MEGbhoVixU0w==
X-Received: by 2002:a05:620a:450c:b0:7e6:92a4:3f03 with SMTP id af79cd13be357-7e86fc24707mr5121985a.8.1755099603612;
        Wed, 13 Aug 2025 08:40:03 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:40:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:50 -0400
Subject: [PATCH v3 5/9] rust: file: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-5-a15eca059c51@gmail.com>
References: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099590; l=1134;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=RP9BgmTgGLsZJlnOuBKxXo7vRURZVQnq5fRAl43lnxk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKl+lYEvf8gi26tp1qsgbmNj69ikU6KcIBZ+ES5GC7bQ34Bf2HyuMiq2uxB6M1hJNeJt7F1p9V5
 +oP2Eqk03xw8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/fs/file.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 35fd5db35c46..67a3654f0fd3 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -11,6 +11,7 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
+    fmt,
     types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::ptr;
@@ -460,8 +461,8 @@ fn from(_: BadFdError) -> Error {
     }
 }
 
-impl core::fmt::Debug for BadFdError {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Debug for BadFdError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         f.pad("EBADF")
     }
 }

-- 
2.50.1


