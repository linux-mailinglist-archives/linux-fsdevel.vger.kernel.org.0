Return-Path: <linux-fsdevel+bounces-13803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B1873F50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C712287476
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37414DFC3;
	Wed,  6 Mar 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEYq0sVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFC14CAC7
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749540; cv=none; b=mGhw3labMWBTh8XateT5B3VA4/bz+8R29TAGzgp+D79Kj6lFuVwkB35xrXakCGD1XpEOEDPa472/I3tTOYjqzTcz82FQ1wa3XViR8tWRKoQqwiTRfzOaWCtd8XttwzL5vum+C+bIXqhNCL47QKgaKUUhh6kWWZHM6etYGY/PG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749540; c=relaxed/simple;
	bh=NrtbL/EY4V8lv5W/NYv3/0shGeJ2rjAV+ZTsI9ELgcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XhKvtqaRjlFZVp3IU0KGiJkZ9TDGaR5RRtPtEgB04l/K4Yio+dE3SvIkiXhdC8odVHYEVZ6dR1VYbAz53VGdceaLxMTOkGg6naH+hyJ8JduICOi+khW4S2I1hIHz7741+uGftcr0oGARVxzv7nePOmKWnZiEY7+Ph+7I2O3rR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEYq0sVx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso10844789276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749537; x=1710354337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6AcyGgSKYmz5a5MAIaPTUUBsabHZwFmfRjLl2PG8hA=;
        b=bEYq0sVxHrMuTds06WHbN7Ei0K64EGQ9+W4kMa+0VtpmMjOtDB9a3LqV25pMa2LY4W
         se0Solh0/mr4sF+09LmbHO1jLF6CwgtNWTKU9Gb2H/IfwY7pZZm0VjJvw+V5EIq4D2BL
         AqZbCKVforZjCKxwUh8n5A0PCKOisG8lWpGfhIqml6j9VnKrHSVBGIikyCDU5jIqEVSi
         AlAHJ7GZXIAJmdnE6Tp4HzTBayaiVSnfoWMUMqdsa+a8g9nm+ANYZpOWNTashKR8fH+1
         un0/FKZCi2HhxUX192UvYNVxAuYEnINLoxTuckoPcAkqfncgH1YGnzQInGjyNtj2t2CD
         qpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749537; x=1710354337;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K6AcyGgSKYmz5a5MAIaPTUUBsabHZwFmfRjLl2PG8hA=;
        b=HtH8MofRrmH29j/By+vQjVhn0IUA2kZMjYhIpD3dOG87x2vrSqNZDg/3Qd0s0v+z0o
         TtXC0iRuvNpC47RVAcw9cYFYBL1kZ3jP4o0PWYjXm9k+gGF/7+suoZSLDL0L7YCuPk7G
         MR++6buskoIBOK3d/xbVAj21S7rv/QMpmdE+F04qvXDkBlkyUsPd/DP24ddM4og+eHny
         0zjzpHEm5+mpKrpN85lnndiWQ0//8yU8rXQPtUnts2GoY9F7fViV8+Kk9MkwSIfo/M3Z
         62AveUwCF+2Vea1C7ZsqntwOfnOwh/tWxGoDFvEo9p7mzcfSVOyRElM9CXVoWGLcJPGd
         xCfw==
X-Forwarded-Encrypted: i=1; AJvYcCWk4e2x9c9Bfg/CqUR0N3v9eh8vc7gXxGVmaO8Va+Y5Hdk+M6ZcSmOEMBwBcqCUujLTe5hGf2xX6kYgJHkF/W2Tless2RFGVwV73PW/SQ==
X-Gm-Message-State: AOJu0Yz6h+1W82bMFjluE5gupYeu6lT+c+Zs9EiwPH6KCIDM4VpMP7Mz
	b6QyD2/IF8nxB2qd8i28WcWCNKupx+gp6FDgYhGjjV6jr3IPL8FD8+2zLLY62z2DZBFNIZ+JJtF
	dIA==
X-Google-Smtp-Source: AGHT+IHr70OmG1R1IO1Fluk0v1eGaHNwt9Z96sNJit+XMVYfO4W641pUVkuKWr/RRoRl/U2gSXjA5z2Bwhw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:18d3:b0:dc7:865b:22c6 with SMTP id
 ck19-20020a05690218d300b00dc7865b22c6mr633022ybb.8.1709749536658; Wed, 06 Mar
 2024 10:25:36 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:22 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-25-surenb@google.com>
Subject: [PATCH v5 24/37] rust: Add a rust helper for krealloc()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Kent Overstreet <kent.overstreet@linux.dev>

Memory allocation profiling is turning krealloc() into a nontrivial
macro - so for now, we need a helper for it.

Until we have proper support on the rust side for memory allocation
profiling this does mean that all Rust allocations will be accounted to
the helper.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..ad62eaf604b3 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -157,6 +158,13 @@ void rust_helper_init_work_with_key(struct work_struct=
 *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
=20
+void * __must_check rust_helper_krealloc(const void *objp, size_t new_size=
,
+					 gfp_t flags) __realloc_size(2)
+{
+	return krealloc(objp, new_size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_krealloc);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indi=
ces.
--=20
2.44.0.278.ge034bb2e1d-goog


