Return-Path: <linux-fsdevel+bounces-64299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A47BE0608
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6558244F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9337530FF04;
	Wed, 15 Oct 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvURDB2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F7D30F940
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556316; cv=none; b=M2It05W/YEavzytsv/Bw0PyKhuUQA8XYaoBUoJW1ZxQ5+/YmuvQWYQXJM0efS7Y6V6NOb6TOzRr5E4epphjjKVdpYgVsmeMUgtxs5egQEF3v00OC41PP3nfiBFh+MTrQiUZNwxfR1ychqGPPtb9oF8XT4TnmPNuMrafqOauMgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556316; c=relaxed/simple;
	bh=1C7R0OlcDfzCrDNlHP23bsVD6WxFN5roYyk953BnBNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GalvdCw/uTmqgdwh5IDawnpORBTPr6JMaPNJXVBMWa0tGuto2TlnX3g6mBu2j7GfUZBRrZ9RiZAcGL5+UEhfEkrTBDGSSJ+2zsVL9TNEcTwqL7bWoqk1w/3Ps9pdgdcESHZ+a9JgvaLkNzraO/x+tUIuqY0CSkRc9zn2omjT0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvURDB2b; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78f30dac856so100730576d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556313; x=1761161113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZKdkbczThzjFB/XasmnId0cLwQ4C+67cjGeOTOncUU=;
        b=LvURDB2bWmzmqc3ssvxSZ5e41cSaG+FYiEbdcfC9cY184Iz7xDLZ2mw3gltSKQZ6lt
         Gb8i4g746WVUeM/u5dyezFGSPw1rFoXL14Q5oDlX7uU6fkq1637nSqsSYL6PhKV+4Fb5
         C7jZ2hBCCUC7DqzxJL+TtR7wO0b4MS0C3O8r8NW1qVBPjaP8aePXqbEXCaW75xJ8XJRY
         4+Yk/GVU24t25jo3GQ3Im4KSPqtg+3pHWmCjVvktEnpWEuHY+NT3WiXN9H+vAukTqkTw
         EhC1pibdM7mdZGBixA6HOy4B3TKHjcSOBgPSHuHjwhoOEeXIVeB9f+BQ5AP5SBAWmR64
         vIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556313; x=1761161113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZKdkbczThzjFB/XasmnId0cLwQ4C+67cjGeOTOncUU=;
        b=lsV/PZXqNjpoa0couurPV+kCT2TNcjieFm0Vh7vsg2EGyIsH0yUsPU8MZhtcydNnpU
         X6RdrBRQYpKj28cSqaceHGLkyGXFYoe1E8AtXSMJxtoUgA9w40UIP71WCD38/s7s6MuT
         0pvkGeU0MpBnxxj8X78JIh8I3V0NKRYq1fMLfJKcC3Nkrhgc7n4rhaMp1YHnzCPjYVoT
         dUzePQWGC27HKYP3M792pxzpUVgn5Bl1avV7tdZUgISOzKcdnjUVmlVFuFMRQS/sMxDM
         hqdTpp6MqdJxHCNERXSjN6bji3c/Uzo1Wb5nBHLmOp/h34tip0vfC/LU++ujsIzkNqGe
         Xb4g==
X-Forwarded-Encrypted: i=1; AJvYcCWsa+chS4B9nV2ycFEETdoUrso10ZBrj6TIi7DuRZG3bxfbD1D2hsq+4WiRE0DBagw+ZF9JNy/AHwpI/HHu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xwHzbkox/Cf9lrxZL5DalHOuHojFI5L33T4a+OOFlQLQ43IG
	mBsjofSo6lKNyHWM2u+6rFAIyEiOw4+lWTwDYWgOJHwpIgH4E172mbHL
X-Gm-Gg: ASbGnctJ3/7Sc+nCr6vrwjdaDD16Dizn/fOyh+S+zliNkTpNrP7e7Sfbw7lxgihHhuv
	+qlpCSLyM+Ac/abSpKoz1C3E7tZ7VMEEvj6o8wrf6wKH20V/hC4dIYypPhnn6Q23m2dWuhR1Et8
	pwedU+6DXdbTeylMJRs0T61HtTshbXx2GZu9rh5l3S54tTvlViSvD4XiGPLgBHGRDR5Uen70F2T
	vyJrcF2D/6zkTgJOe/rlOXhXWSwm92Xq+jU8iAOhPVOx1SXpyEu7u2d1Tohv/nXkr9qZFoadajK
	0E6uht/OB8MSI6Zp24me3noQndAObFqv7RpsdSz2BbcppE86RmjWncOhhusBjEB15kG8ZLniv17
	7MTP75fMo0d5bTdB47FlbvJCW/+t0FoMW+iKhqrhCU+DCGxG8X9+HnsaQx8xZTrrmchVAUH/ntd
	8g6LF0hLbLpKR6IFDqKX9ib3QQaN6wdov/pWko6uVHYXkbma6L3KcF36cxJM4aofyRBMcqaSOCl
	TEi0FRASgjvmFpqV6DAkDWCQ7WDKxNzP8HX53T/eGpaRUBmpc2naYOt3N6WJ8A=
X-Google-Smtp-Source: AGHT+IG7liVg/dFGAXjOyaKmVuQjChyGkmShQ9JV9oLbo6kDusjiP3kvxzCrSASqCG/bT3aBHrC7KQ==
X-Received: by 2002:a05:6214:da5:b0:81c:b934:a01 with SMTP id 6a1803df08f44-87b2efb9b5fmr472291556d6.31.1760556312957;
        Wed, 15 Oct 2025 12:25:12 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:12 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:36 -0400
Subject: [PATCH v17 06/11] rust: alloc: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1945;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=1C7R0OlcDfzCrDNlHP23bsVD6WxFN5roYyk953BnBNs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDAN3p325daLL4ZjhjcTgzqClyBuzpHB1y4m1///5j/K+30qaqRH3Sgm2aqLHXCgT2ZR6uF5mJU
 hkiaomJhEowg=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit 9def0d0a2a1c ("rust: alloc: add
Vec::push_within_capacity").

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
2.51.0


