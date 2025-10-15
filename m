Return-Path: <linux-fsdevel+bounces-64296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B2EBE05D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 487F6358014
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74F630EF89;
	Wed, 15 Oct 2025 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQvM5R3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888F30E0D9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556310; cv=none; b=cyR0z+vC0lneT07u162H8K52QBWePxP80Oi84J0JQeRjpNx0HRglB7BL9OKRopvZI0iRNjPYx4Vns2JBoP8pxw+EwmRO06tzM94OPf+9AY7/PdsS887xnuESzLdsuDrCP8E6eAlswrL2NzcdKBalKv0msSYxTEx/+5lGgfcM9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556310; c=relaxed/simple;
	bh=Qn1W1cp+yTwc3WIdXx1edrK3W/vliJQWYr2kDZAgGBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QS/voY23h3Vv7TmEnzQ7GTodhj6XtA5BbtgmzYvRlNMCRtMdiDtxJ28wb8egfPoH7HP5xmI3YXxOyH63Cq/18XAaIZ2NhVOgdh2hv29W79h96McFOq33qH2fcawyA6PtIEoa84GmayL3dNZlwyUg+AHBQDWs+cMTSTpNMKPTna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQvM5R3/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7946137e7a2so104885496d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556307; x=1761161107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z0UoCENjvPOzaJ7c22Y9TSWGsGdKl3uaGJR5NzjspE=;
        b=dQvM5R3/bTVeAHIbUhXqCyhCYZcU2V479ToP4Mb6X3gow/0QaV5XGpAwgYWc0SY7u1
         IYhjuFgyGlvae9b4GXv8CiXg0suQgSx2kZebwo4xpH0erARZy2n59Wi6ymlCm0tDOy0E
         FHEYKI5uQbt9WDEsqLKjaH9dH6vGzbHaATSNsXUCkzUfUplquBZNekAEM88lEJontwlH
         iVTxhLG9ogDBPN6jQO3d2fmWzzOC/86D53uLmLHMtC8imgpScq62ximwgdmzobps7DHN
         8Ol9VPg7wWJjldHLmBJmMT/P+OQRBuvNKCpye01ADsqKD0g1HV7dzO4zOyTIDpZJjOup
         Gy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556307; x=1761161107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/z0UoCENjvPOzaJ7c22Y9TSWGsGdKl3uaGJR5NzjspE=;
        b=f+XsrRR7vLi1xtUXQuhnpl740QG8KRZLvxMmgze9P+jXB6pYBU53wROetew3YWTN+Q
         xN1iQBYK3HsU7P/tderv69sXkuCK0eDR3VWM05zcZD1u5GhL3qhyabnFYB4XL/2xNIue
         HHBC0dBinLmx3sEgoHn00q8Y+vtLXSJmh/lCnBpycKll9s1Ykiorzib4wu6SABNo2/wQ
         epSTobvEL1Rpqu/uA3bhhUK6KH2xRRmEJIdleCZlZ80j4bzdBTcZe4OrHueLTHXty6WI
         fpS1OGUczL6GLncG8V7cXF6mDhSBjmjvphGQtpiNT9L4vCvXHMYJFtrin05a4PL9Y9p9
         dvog==
X-Forwarded-Encrypted: i=1; AJvYcCUuW6pqV3CIc07GQrmz/eS6gOIPBwHqto3Mi+SqypGMi/1gU3a20LMZNKynV5qSVvhQTmybOcGdKX4tUJNG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EKL4DP4GDUSNTGP2ymw1INP+fzI5H0zgVzU82kcJS96NQndd
	MY35OcVF/UMhAG9yg3AKXpe81MmmmsjiBFd9NJojTuLveQXcOemMIaEz
X-Gm-Gg: ASbGncvVsUhtaipXMh6QpU5qeyP2okRfnuc1mcnuxHqZL/T4zR0UMYfqhCzj44j0jjM
	px7X9rhyEanvp8pt6Dd2hTdlYhiNOVQ12zdgdVIozg4Td+6yJqQ+f/RrvOXJ97pixfGJOkiqG6t
	u17ooixf2S+MD7XZJU5VZVyrEMe4duLgmeslgUmkkVu4t0E4Jg9KHy+UaYmOPDB6kD4/3e1zUJK
	7GobyN/p3wqQTTHNQIjGO+uyVy1SAGM012bRD98pa2g+q9N28Uy4J0PgFvE+96d/PMHq6yv2pDm
	h7tOqdIGG0POchWj3oBBJGtfmJUgqAqNNCvUgnmseo739mc2fxi4fkNB0oyez5m7/9D9hWp8AES
	cmUwzg8sACUu6q9C8L5ify50inRKJCvT2zayQNU91MREDBTYchNQizhkv7Hp7Ra8TPK6SNTReys
	fAkiNjx43QFfQhhPxziKfpczMIR6zkW3remzhMiwi+qaR4ubcvsX3RpaH1XitLz+BWZla2iaEMg
	Fl1TU453CenvFW/e/y9aEdxtyMJmZVZ6aiMl2fTabc+hS8TZDEtEbg6oxUnzn3sQG12uihIvg==
X-Google-Smtp-Source: AGHT+IG2tULJ6h6PVvWUIOB2ZFPRQKa/V9qgfB8TRjULEb+0DCRZ6eO1hx3aZgOim3FIHrolDm9d/Q==
X-Received: by 2002:a05:6214:27e9:b0:803:3b8e:e9a5 with SMTP id 6a1803df08f44-87b2efc2c78mr410404166d6.36.1760556305773;
        Wed, 15 Oct 2025 12:25:05 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:33 -0400
Subject: [PATCH v17 03/11] rust_binder: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-3-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1147;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Qn1W1cp+yTwc3WIdXx1edrK3W/vliJQWYr2kDZAgGBI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPq4IgijUUTbPqcb/sFKSMvqN+uNEx3DeWVE1av3DAj4osSldGBCYfq78JujAqGy30VkSuPwWuG
 OpXoXaJlyWQ8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/error.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 9921827267d0..b24497cfa292 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -2,6 +2,7 @@
 
 // Copyright (C) 2025 Google LLC.
 
+use kernel::fmt;
 use kernel::prelude::*;
 
 use crate::defs::*;
@@ -76,8 +77,8 @@ fn from(_: kernel::alloc::AllocError) -> Self {
     }
 }
 
-impl core::fmt::Debug for BinderError {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Debug for BinderError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.reply {
             BR_FAILED_REPLY => match self.source.as_ref() {
                 Some(source) => f

-- 
2.51.0


