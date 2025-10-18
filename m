Return-Path: <linux-fsdevel+bounces-64576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45BBED6A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17563623EC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F092DA753;
	Sat, 18 Oct 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeZ6X/mJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22D2C2369
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809556; cv=none; b=AgfZoxKJfO57rtAc2g3E0leHIcwTiOBcqJiTH6XZjPkyk2X3SF3tdYslSOfd6yjmSxTXC5lnS0Bxw5tk44k0ZqX09r38No/HI8znrHy6M+0pUO0b1ZkdPHFuia0H8kGlYNs7DiuKX6cX5T/DiJ2N4Lpur4DcHOhdPLaIH/eeTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809556; c=relaxed/simple;
	bh=VZx3xyzuE8sdJWwvMWeYLSbsWBC7U7VUNVHO5x1zs/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bdsq6Jwcspcs8IJnhMLd1JVEAhiO8JjtYs77WiIbb0fctaQCSv2K6Z+3ZsWboooLzJi5+0V9McIT1489y5KqToVcj2B9lgvqjjE2+GsKe5dWfT4Gkm1JlTFF9MUQOqorpyEm3K+3uaYzTW6Ef6suSXz6TzeHlF4Sy0OiKiXYtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeZ6X/mJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87c148fb575so47696156d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809554; x=1761414354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhXSu5jvbOALYGh18N5SGleu51uu827FBi1PfdDv9uw=;
        b=GeZ6X/mJehcWrd39xdzJeNrugqhrW86xBE6m9Gnnoo8AwrhTOqCAgRRxXnGFcBQvsy
         Vuoo/+N9soBxaGwkn66RHjU416fUW87AdC9y65QmClk05JIgIQp+Oghr4QMKJ+l0QFuU
         adhgZ+H5Sga2pn1w4fnCYCEk1MIgqrf72tX/RcdrkBNpFWu6Fr2TtZwrJS/iT+fyGLcb
         W2XXKLExkQO83tvm+HbwGx77I6VVV/Kf9EjR9LNPpbXPllNqlorYOjn1JeINMs/amSmg
         GDis8T63646/1uSIs62wNYP/RB3/7eK0ov3ZUB24rSH465rIAPgsZ44tW0ZX+REPFoYN
         TDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809554; x=1761414354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhXSu5jvbOALYGh18N5SGleu51uu827FBi1PfdDv9uw=;
        b=Zb04ZYVani8QtXGS1NTUECdVlkmtnJOn6O3CVuzAT+1cF0YM7qXtqD0zSRv31Ita4C
         CPHRgvoBbhdoZVz0KFDQYDGtD2vSgB4+4QdSDXVI4ZKn6sKTSE5P+vI1oBmWBwA0Ai1Q
         5jac0Q68nHxbll7BDy87R8yzHKP+c4OZvU3Bv43lVMLcp62HjfnqnoldbaVyEvMpWKny
         9HN2BkJRNwP5TZdK5lQHW+u0Q9Rz8QpzXmt8uG0TSrs5mkrI/y7SO3kisi960i8vp+2I
         Xzd3HPbQh17rf5ciSqkMdicAdgo3IykrEjPEMhR8w05nSw9PqBBNmbkJjlI2ukh5bxp6
         XaNg==
X-Forwarded-Encrypted: i=1; AJvYcCURUNHL9rLFNLagPllo9Mrm4wdbjdp2soxfpjF13J1nU3m9yqtI+VBHcI6rUfX5x/O/wEr7+oaTuqTGAz7H@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCORXCOfYcJIeyFUfs0IyjxY5bsl01euNsx4QYNQdaiEUKtmV
	vwiDhtrDi7b9+pVJjl+PAeIRDFakktiFu7wQ6RvGwjtlMSp/4c8pPeaH
X-Gm-Gg: ASbGncuhs3cIR+HYWGcA0VNEfSYwvG3kvWB+DrG0nYIizLplCV+2xt+3zNX3exR4DO3
	ahh7oIQh0mq0ro/yEVDETdSrm6V8SiES23iiOwqzSnkcYE/y4tQDcdyH8hwJBfEKD7rtGaiT+9Q
	Gcx23CeY1MTcxuZLX6arqPIbxlCIaf6siNg/W+X2jhj1MbC8Ve2Mf5i/2uc/+Yy8ggslNXioqLv
	qSdemIQV7rClkbeESTI+VjYA/ejR+sGT3b25xc/2usNgB5355Qp4G8ZO4LQ7dQcBiCr/FQHYQyL
	XS9XkJvOu3PhYlV+drEsIcVh7nkeoqUFOtIJowK7kHCtyNmggTCtXfGG0nz3osYZdvueIcNm12B
	4pvqWdePmwTotuR/5lJ8DFk0vHn/jGWwd4bmgMTrB8GbR5EYRh2grKo4XlP06unIifepioF6oCD
	+ZDgV9QOuCD+WkwQIxSw1Q3wixsORkUYGgv0Q236Xd5eEEeLtr/EJyes+yD8aH1CGY8McQePF0X
	IzwTkrQ/Nbqxs8uQ/9Lnj3xs8sQjvCBz+nJHnS9p8ibERohEg8+
X-Google-Smtp-Source: AGHT+IHwmbCilEbE3X/epDbrG5LC82vpTK8X6AnN2QSsDBY9zv0L0DqM69lN1FMFmljkUNXxkq4AOQ==
X-Received: by 2002:ac8:7dd4:0:b0:4e8:96ab:da8b with SMTP id d75a77b69052e-4e89d283014mr129620021cf.23.1760809553435;
        Sat, 18 Oct 2025 10:45:53 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:52 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:17 -0400
Subject: [PATCH v18 06/16] rust: alloc: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-6-ef3d02760804@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=2039;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=VZx3xyzuE8sdJWwvMWeYLSbsWBC7U7VUNVHO5x1zs/Y=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPuKAuVf9GfET2NKL0q4bp4Tc3Ay6O1rJo/qozL6xioRoXG7kz7tkE7k1hDE/ytV5U50M81wQNc
 BkpwRYc3KSAs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit 9def0d0a2a1c ("rust: alloc: add
Vec::push_within_capacity").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec/errors.rs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index 21a920a4b09b..e7de5049ee47 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -2,14 +2,14 @@
 
 //! Errors for the [`Vec`] type.
 
-use kernel::fmt::{self, Debug, Formatter};
+use kernel::fmt;
 use kernel::prelude::*;
 
 /// Error type for [`Vec::push_within_capacity`].
 pub struct PushError<T>(pub T);
 
-impl<T> Debug for PushError<T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl<T> fmt::Debug for PushError<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "Not enough capacity")
     }
 }
@@ -25,8 +25,8 @@ fn from(_: PushError<T>) -> Error {
 /// Error type for [`Vec::remove`].
 pub struct RemoveError;
 
-impl Debug for RemoveError {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl fmt::Debug for RemoveError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "Index out of bounds")
     }
 }
@@ -45,8 +45,8 @@ pub enum InsertError<T> {
     OutOfCapacity(T),
 }
 
-impl<T> Debug for InsertError<T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl<T> fmt::Debug for InsertError<T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self {
             InsertError::IndexOutOfBounds(_) => write!(f, "Index out of bounds"),
             InsertError::OutOfCapacity(_) => write!(f, "Not enough capacity"),

-- 
2.51.1


