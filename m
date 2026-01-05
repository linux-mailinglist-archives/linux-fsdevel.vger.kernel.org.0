Return-Path: <linux-fsdevel+bounces-72388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F76CCF3963
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 13:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2A033002B84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D1332EB9;
	Mon,  5 Jan 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsCGNIp1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0632C923
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616963; cv=none; b=FK80Q8C1Bg1XosC1WhWoX8u2gq/2Md7nQ9n+ysDv4yf5Zq6d2iaEU5Bim9o7qCplYztjrlTVxbFf3Tmq8OEI//hlPWa0hq5+XfZi+RhIxRpeayyM/q32s2dUBVaMKQ+dmX/+/SlQHPpz5feq48wWW0unGsqZKjEo4dPEq/36LVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616963; c=relaxed/simple;
	bh=kMOE8SG+apSYdkSF9wxqn459O1XV4mgd4R9CI30yqRE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FfRuPk8CttGTIfYkTeoJP3uxXEKyWy+RggXWRb/qaAUd56XCC7homI6k61MkbY2394rByqceoW1pJuX3XQdaHDtPG7mt0riAYBaCPFYVC2ZO9MrKJAUZBFPIv0hzr8NOGOie0XJvbNeyfE2nlgUk36tU7VZyXmRKvHu0/L06RGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsCGNIp1; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b73586b1195so40179366b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767616959; x=1768221759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=suTH4y/aK07UioTUbupgL2cgp19BWpg3A0c3oYdgR0I=;
        b=YsCGNIp18JiGPOzkn/DPqh3z2eIbkvQNR5id0hInLs9r4OT02HbOpXEnRMQN9GNph7
         sNtBrV0a1xzlfML3GhTwslx/r9T+QVOIOcd0gZpfVoVUrD4+Eu3Nf6lBxL45vz9jJrp8
         4XubaQW22q/62ZXfYZPDmGok+6228nh4BGDPaTP1bW2iOLUnJsvQRrXhuru43enR+bIb
         R7ytnolmQtzV6DKNzvAsDPwtk8yR6ZxPb8DovB8DmE05T+k7WcdWWLjiL7lveNuDYsOf
         0uAbaR6Rn8J8ZlqDVl4t7mqxTnscmGqYHPCpZEUUYsZvQpGNhO2whJYj1Zus4BDHRwuz
         u+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616959; x=1768221759;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=suTH4y/aK07UioTUbupgL2cgp19BWpg3A0c3oYdgR0I=;
        b=aqln7uX7CCj5rCcLZvrtl+1k3Q9lDxzkhAYQVqf0BOWjhFrAb5heMh7Qfbg9GLob22
         z1hPhCBpTy0RrdGX/IhQRcfu3EwDfq4tiXPXTCIOb01N4STvKG2Jpm8+S/aSAkWJitTo
         ayqP9kChYZDhDVZ+KrTc5CBnoZwYs+JCujgV+thyqPf28K9UDYLmDGaKjhUzSQ1q1l5p
         Ox0DdRO7ftIJtVq/jjezj+JkO8BbaeRs9E5jP1KSccaO46vtf3Sv2boDDRihimLzOdgR
         /C/Q4tqi7LgZCtRKGDTMkjRHmlKBQtVNs+NhM/jHwdPDTQaZCP3avUYS+vxxANde+RO2
         tvVw==
X-Forwarded-Encrypted: i=1; AJvYcCXaXpFLI0kH0fqos9LlZctx/KEA4Z76as1eGTFqv4+waOpMqfjlaZn4XzwSRIdSZEva5bFg3AfT8fJL2tKb@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmAl24frYrBDoH3b73ZzUH9QNox/FZlCOD9OX2wy1kJLAENV4
	Qx1P3n58J4Ohsw7mXhnHPFQoSYHoXoRUn5XVGYmBou2j5d2lT8qOnRyKxZj/Nz+4LGuIzKf8H/p
	bQiurS1UVi3A/4OtTRg==
X-Google-Smtp-Source: AGHT+IGf1O7IHkQTlTr95Pslbnl5wrFL8+HDWkBjzBEOHejeoVvO3AomqVuVaw8gUaSkcMI/MyfZHpwyBJwWEqs=
X-Received: from ejcul5.prod.google.com ([2002:a17:907:ca85:b0:b73:3b0d:754d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:318c:b0:b80:402e:6e77 with SMTP id a640c23a62f3a-b80402e6f1fmr3924567866b.54.1767616958861;
 Mon, 05 Jan 2026 04:42:38 -0800 (PST)
Date: Mon, 05 Jan 2026 12:42:13 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKWxW2kC/32NTQrCMBCFr1Jm7UgmoUZceQ/pok2nSaAmJalBK
 b27sQdw8+B7vJ8NMifPGW7NBomLzz6GCvLUgHF9sIx+rAxSyJaq4MiTD4zplVd0PC+ccNJDq+h
 KSggNtbikmnkfo4+usvN5jelzfBT6uX/nCqHAXjIpMxjS/eVuY7Qzn018Qrfv+xf9TXaXtQAAA A==
X-Change-Id: 20251202-define-rust-helper-f7b531813007
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5550; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=kMOE8SG+apSYdkSF9wxqn459O1XV4mgd4R9CI30yqRE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW7G2KP3s3XkvuUe28vfCsN8trnhXVpe23MOsp
 r09yEuuWCGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVuxtgAKCRAEWL7uWMY5
 RvWlEAClQm3dLefLdyw558cl7DXXFM/HG6E0PYtjbQN8CJN5Z73NMsBCPkh4yi3buGxEDSwuLgK
 knLtqhBaD1uekLELc+gYUWfr87wmwKWNdTFPwiPPorV51hNabNaXw8G7fOYYMdF+oxPpF/1MkqL
 +h2mkAAuC4NIQrJ858OmgnAGAMmLTFdB1n+a62gCy4lbEQ+P19PHaV421HMwhz7HZ2zymicnR/I
 YQegrNv3LY5G3K38u1cG0t0TmheZacr6GTA969Qw4qbJHpcuwYXq7kxEqXbgX6m59pwD3Wjjpry
 hw/QZRKqddie8OdfN4X9hVSaRnZ2YTxS914ZbYHeNxK2aAKzT3hK7KA+iR9yICYNMqRl6tfchAn
 dbu/pDyjlflom6arj6cS+By423tUdk5jbgU5+GtHRr6jE58lI65j3HOKfdWNAGC68BugTffPYy4
 ZB6WJ7vIOjICkbpwY3OY8xNiKhiA8NRRgNDmBCtMrU4q1Z02hhm639rqkLt4Ls9fGBvO9/g97YD
 6dOKVGW4yqgDQhLSoUQhSGPZSRLMfaz9tqZ4lsyNhCq0/edLIJfsQhCRB3ZHADjjhOMMHK/lpdZ
 w1UiXgV48Dh91eOwO4H2r6iHlqp4Eydgtc/WDsVIaegqEKCM57R/ttatf0zojd8qfWcDHJyPgdD qkahi/Z6S+Gc45Q==
X-Mailer: b4 0.14.2
Message-ID: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
Subject: [PATCH v2 00/27] Allow inlining C helpers into Rust when using LTO
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Peter Zijlstra <peterz@infradead.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pwm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mitchell Levy <levymitchell0@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This patch series adds __rust_helper to every single rust helper. The
patches do not depend on each other, so maintainers please go ahead and
pick up any patches relevant to your subsystem! Or provide your Acked-by
so that Miguel can pick them up.

These changes were generated by adding __rust_helper and running
ClangFormat. Unrelated formatting changes were removed manually.

Why is __rust_helper needed?
============================

Currently, C helpers cannot be inlined into Rust even when using LTO
because LLVM detects slightly different options on the codegen units.

* LLVM doesn't want to inline functions compiled with
  `-fno-delete-null-pointer-checks` with code compiled without. The C
  CGUs all have this enabled and Rust CGUs don't. Inlining is okay since
  this is one of the hardening features that does not change the ABI,
  and we shouldn't have null pointer dereferences in these helpers.

* LLVM doesn't want to inline functions with different list of builtins. C
  side has `-fno-builtin-wcslen`; `wcslen` is not a Rust builtin, so
  they should be compatible, but LLVM does not perform inlining due to
  attributes mismatch.

* clang and Rust doesn't have the exact target string. Clang generates
  `+cmov,+cx8,+fxsr` but Rust doesn't enable them (in fact, Rust will
  complain if `-Ctarget-feature=+cmov,+cx8,+fxsr` is used). x86-64
  always enable these features, so they are in fact the same target
  string, but LLVM doesn't understand this and so inlining is inhibited.
  This can be bypassed with `--ignore-tti-inline-compatible`, but this
  is a hidden option.

(This analysis was written by Gary Guo.)

How is this fixed?
==================

To fix this we need to add __always_inline to all helpers when compiling
with LTO. However, it should not be added when running bindgen as
bindgen will ignore functions marked inline. To achieve this, we are
using a #define called __rust_helper that is defined differently
depending on whether bindgen is running or not.

Note that __rust_helper is currently always #defined to nothing.
Changing it to __always_inline will happen separately in another patch
series.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Pick up Reviewed-by: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
- Update formatting in mm and slab patches.
- Add new helpers in files uaccess, pwm, and time.
- Drop any patches that have been merged.
- Link to v1: https://lore.kernel.org/r/20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com

---
Alice Ryhl (27):
      rust: barrier: add __rust_helper to helpers
      rust: blk: add __rust_helper to helpers
      rust: bug: add __rust_helper to helpers
      rust: clk: add __rust_helper to helpers
      rust: completion: add __rust_helper to helpers
      rust: cpu: add __rust_helper to helpers
      rust: cred: add __rust_helper to helpers
      rust: err: add __rust_helper to helpers
      rust: jump_label: add __rust_helper to helpers
      rust: maple_tree: add __rust_helper to helpers
      rust: mm: add __rust_helper to helpers
      rust: of: add __rust_helper to helpers
      rust: processor: add __rust_helper to helpers
      rust: pwm: add __rust_helper to helpers
      rust: rbtree: add __rust_helper to helpers
      rust: rcu: add __rust_helper to helpers
      rust: refcount: add __rust_helper to helpers
      rust: security: add __rust_helper to helpers
      rust: slab: add __rust_helper to helpers
      rust: sync: add __rust_helper to helpers
      rust: task: add __rust_helper to helpers
      rust: time: add __rust_helper to helpers
      rust: uaccess: add __rust_helper to helpers
      rust: usb: add __rust_helper to helpers
      rust: wait: add __rust_helper to helpers
      rust: workqueue: add __rust_helper to helpers
      rust: xarray: add __rust_helper to helpers

 rust/helpers/barrier.c    |  6 +++---
 rust/helpers/blk.c        |  4 ++--
 rust/helpers/bug.c        |  4 ++--
 rust/helpers/build_bug.c  |  2 +-
 rust/helpers/clk.c        | 24 +++++++++++++-----------
 rust/helpers/completion.c |  2 +-
 rust/helpers/cpu.c        |  2 +-
 rust/helpers/cred.c       |  4 ++--
 rust/helpers/err.c        |  6 +++---
 rust/helpers/jump_label.c |  2 +-
 rust/helpers/maple_tree.c |  3 ++-
 rust/helpers/mm.c         | 20 ++++++++++----------
 rust/helpers/mutex.c      | 13 +++++++------
 rust/helpers/of.c         |  2 +-
 rust/helpers/page.c       |  9 +++++----
 rust/helpers/processor.c  |  2 +-
 rust/helpers/pwm.c        |  6 +++---
 rust/helpers/rbtree.c     |  9 +++++----
 rust/helpers/rcu.c        |  4 ++--
 rust/helpers/refcount.c   | 10 +++++-----
 rust/helpers/security.c   | 26 +++++++++++++++-----------
 rust/helpers/signal.c     |  2 +-
 rust/helpers/slab.c       |  4 ++--
 rust/helpers/spinlock.c   | 13 +++++++------
 rust/helpers/sync.c       |  4 ++--
 rust/helpers/task.c       | 24 ++++++++++++------------
 rust/helpers/time.c       | 14 +++++++-------
 rust/helpers/uaccess.c    | 10 ++++++----
 rust/helpers/usb.c        |  3 ++-
 rust/helpers/vmalloc.c    |  2 +-
 rust/helpers/wait.c       |  2 +-
 rust/helpers/workqueue.c  |  8 +++++---
 rust/helpers/xarray.c     | 10 +++++-----
 33 files changed, 136 insertions(+), 120 deletions(-)
---
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20251202-define-rust-helper-f7b531813007

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


