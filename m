Return-Path: <linux-fsdevel+bounces-70475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F348CC9CC99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 20:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DDF3A2014
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92D2E1722;
	Tue,  2 Dec 2025 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kip3Lc9z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463B2DEA94
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704274; cv=none; b=Zr/w8VoHWAG+2tRvV3v1CZoRkdSSLEwAg50dg0lXOBnVdiFJbUWTixSs9+9yioQRlRjzfnJWAMRGyuUDOwzYhoiz07J7/+U2t4LEylXqCs7sruGE4yo2eA1XiENyL+6DU11/Yyl5HKbi3DqyA8PSoG1eU/rBHQ5IiSQgDVbl6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704274; c=relaxed/simple;
	bh=W8ZblEwgjuL8jZJ36a/bhPpyurnqnpzkgPSqnenEdCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A5Dd319igyu/ZozrCdN8jPLriCoYOxDk/1wuTL2VICfNlC/uZaFInWG3DQ8kRPktZOyjM56/n2OSSeYwz7OYzJavRK9VXIf/zRiEx6Nf91kQOrPajLfhkNeI+4ympv0hJUGXiu80q73ZSLKYa+q+Lcg9qotkV8CncMzP72ss+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kip3Lc9z; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42e2e448d01so1972694f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 11:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704269; x=1765309069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zhJ/66bq3Dhg0Aw+wAsmTfNgUiWxLNmyfbE+xmpzX9c=;
        b=kip3Lc9zeKn8FFLlcaLuTFCWl9jrb34d6WKCg5JjmA0h723skcbKHQg7jkZ5BvxMPk
         eAnzgDz6VzBUQpP7AiwHo0AxoJ1OrhaEDQbGZimYGWXRn0iFUOQVQtLCHV/KNfmcEWW/
         SfhWDoN8raJAy4VlVWYQ7ThW3/CF36+yY5aoZoYfubUHdrdSDlFoE7AobKrJg81uuH1W
         GZbiktG0oOguoOj8ocECp5unUNyMaGNIRe/0OMH3FFCCWFXNq9uiPlBPpU3tyx0kaJpj
         aflM5LXo8+OCIeJSStj4CBmCRU6SlhtMB4Owdj0apaUU781s8fIMTFAKLDg71IeXjr67
         wweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704269; x=1765309069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhJ/66bq3Dhg0Aw+wAsmTfNgUiWxLNmyfbE+xmpzX9c=;
        b=YBdAdvEO1VNKGDqg8i2R+AxAG20MsCDr2F4frRw27yiXITlb+uxbMVq8Stk0CqME18
         iuA313ELbRogvzSzvG0UOj+6vQ3+pt+GSQGBOnD+cpVEbWJCqndg8tp5Q/Np9Jb+uD/K
         In00sTEaRycZ5zt+L783xXIYDwIXlGpT6Aj3jDfp6YWmw3sHdXYsOGLWP7au2Fyudu66
         1wOnbUVpgCDLEWmooEPO+4nfBrPQ3kjaBYDkBiPrB0hQpP6gZ13PEfPwS5iZKjRYCfd7
         7sWPeJdAusSMuDP9Ab/XTTX+UZ9N8iRQeMS6qq05j0yaNaj3qIlBqobMg/edGWM4afpd
         H5cA==
X-Forwarded-Encrypted: i=1; AJvYcCUbp9X2AmY2e/ecbPkqR7ge3A5OVcFcviDZBu2xRIDWY3572bSOIUl1QlQA+hrSw3NJwatsa0iGee7ZL7k4@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4u/0y/p59iszX693KT0+n6vNZhh/QVhDm9+muzVRaxQon7gy
	NrMJ76+6IHxPDEbcqgtRzLTYHzgxB7oX3IIZXhmWbr3Sj5LCzSoWKRLupBCBk979Ee4HNixuwUT
	zXUSQeUFf5VFz6MGxow==
X-Google-Smtp-Source: AGHT+IHLoORxJFIMnvNaTR7esNyOMYjh5IgIdqpmM1jiNlaGB5DkF31Koo1mWN1Y6iCnVsE9Qgyw7dzDpU2Msvk=
X-Received: from wruh15.prod.google.com ([2002:a5d:688f:0:b0:42b:3951:1b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:288b:b0:425:73c9:7159 with SMTP id ffacd0b85a97d-42e0f344080mr31795438f8f.33.1764704268795;
 Tue, 02 Dec 2025 11:37:48 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:24 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPU/L2kC/x2MSwqAMAwFryJZG2iVUvEq4sJPagNSJVURxLsb3
 AwMzHsPZBKmDG3xgNDFmbekYssCpjikhZBndahM5awCZwqcCOXMB0ZadxIMfnS1bWxtjAcd7qL N/Z92/ft+At1vUmQAAAA=
X-Change-Id: 20251202-define-rust-helper-f7b531813007
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7075; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=W8ZblEwgjuL8jZJ36a/bhPpyurnqnpzkgPSqnenEdCA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AAbiS38ffQuRjq4nMNsCbAsC2Z0/xEFskYI
 a7cs/y+HK6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9AAAAKCRAEWL7uWMY5
 RljtD/0fz1OjaXVHkkiWZGm1MTTTeoRD7MZeZtSJpWwEp10zfQcriF9Tz7TiY8DRVjupa7ieL6W
 K+QIimSfxkf0pF+U85RZt8x5R0zrrPA7a0r4Czw2u898rjuZSvXB9rsMsd8s49K2iNGlMl8no4n
 8dLlxYWEysWLhXoCLey0TdCeJgWmZWEtLRFaN6a3PtKGsKPj5IDQPwWCgiJcyBf9skYFC8xnLoN
 myrtxskJJ3xSky7n1TIOas7ooGu8EP6L1qP0CCGnHx3PR9GtRbSahp4lABH8jI74mWyxI75KaqA
 e9yf1n+e6sDD4Miar5xu7Waav7mh4Wlvpm+FSeBd0t7yox6QRDaIfb300TNnYzo1UMbkA4TsjSu
 jitafYyHMfHqSaZ8Hw25YynM0XiSR4dLFJXhzu6X6CIEFlbZbNx++pCQngoNk0Iidbvfmj1MwRy
 JBZM2bXi/bb6e6iBnyXdGbM+VMwGo9ik6yIiLbuEi0MdhQ1SQbz9kEaJXP2rfRSiJxCIobwXnwA
 zcbWzlULfAo1IcQ75R/0IuuuYUNlgfzaNl2x/c5ODo5ZVsxdgIMF9rF1905CYwuTY0YH222qCZ0
 fao/NDvnvYrOIhSBHgNknvBcn+HM6CoE2Hycm48/DGMTeSqNxcbw9tlPWj5SJ+DhS/1mHLW0MMy +rvrgaUoICXqdBg==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Subject: [PATCH 00/46] Allow inlining C helpers into Rust when using LTO
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Carlos Llamas <cmllamas@google.com>, 
	Yury Norov <yury.norov@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-block@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Lyude Paul <lyude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
	Remo Senekowitsch <remo@buenzli.dev>, "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>, Gary Guo <gary@garyguo.net>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mitchell Levy <levymitchell0@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>
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
Alice Ryhl (46):
      rust: auxiliary: add __rust_helper to helpers
      rust: barrier: add __rust_helper to helpers
      rust: binder: add __rust_helper to helpers
      rust: bitmap: add __rust_helper to helpers
      rust: bitops: add __rust_helper to helpers
      rust: blk: add __rust_helper to helpers
      rust: bug: add __rust_helper to helpers
      rust: clk: add __rust_helper to helpers
      rust: completion: add __rust_helper to helpers
      rust: cpu: add __rust_helper to helpers
      rust: cpufreq: add __rust_helper to helpers
      rust: cpumask: add __rust_helper to helpers
      rust: cred: add __rust_helper to helpers
      rust: device: add __rust_helper to helpers
      rust: dma: add __rust_helper to helpers
      rust: drm: add __rust_helper to helpers
      rust: err: add __rust_helper to helpers
      rust: fs: add __rust_helper to helpers
      rust: io: add __rust_helper to helpers
      rust: irq: add __rust_helper to helpers
      rust: jump_label: add __rust_helper to helpers
      rust: kunit: add __rust_helper to helpers
      rust: maple_tree: add __rust_helper to helpers
      rust: mm: add __rust_helper to helpers
      rust: of: add __rust_helper to helpers
      rust: pci: add __rust_helper to helpers
      rust: pid_namespace: add __rust_helper to helpers
      rust: platform: add __rust_helper to helpers
      rust: poll: add __rust_helper to helpers
      rust: processor: add __rust_helper to helpers
      rust: property: add __rust_helper to helpers
      rust: rbtree: add __rust_helper to helpers
      rust: rcu: add __rust_helper to helpers
      rust: refcount: add __rust_helper to helpers
      rust: regulator: add __rust_helper to helpers
      rust: scatterlist: add __rust_helper to helpers
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

 rust/helpers/auxiliary.c     |  6 +++--
 rust/helpers/barrier.c       |  6 ++---
 rust/helpers/binder.c        | 13 ++++-----
 rust/helpers/bitmap.c        |  6 +++--
 rust/helpers/bitops.c        | 11 +++++---
 rust/helpers/blk.c           |  4 +--
 rust/helpers/bug.c           |  4 +--
 rust/helpers/build_bug.c     |  2 +-
 rust/helpers/clk.c           | 24 +++++++++--------
 rust/helpers/completion.c    |  2 +-
 rust/helpers/cpu.c           |  2 +-
 rust/helpers/cpufreq.c       |  3 ++-
 rust/helpers/cpumask.c       | 32 +++++++++++++---------
 rust/helpers/cred.c          |  4 +--
 rust/helpers/device.c        | 16 +++++------
 rust/helpers/dma.c           | 15 ++++++-----
 rust/helpers/drm.c           |  7 ++---
 rust/helpers/err.c           |  6 ++---
 rust/helpers/fs.c            |  2 +-
 rust/helpers/io.c            | 64 +++++++++++++++++++++++---------------------
 rust/helpers/irq.c           |  6 +++--
 rust/helpers/jump_label.c    |  2 +-
 rust/helpers/kunit.c         |  2 +-
 rust/helpers/maple_tree.c    |  3 ++-
 rust/helpers/mm.c            | 20 +++++++-------
 rust/helpers/mutex.c         | 13 ++++-----
 rust/helpers/of.c            |  2 +-
 rust/helpers/page.c          |  9 ++++---
 rust/helpers/pci.c           | 13 +++++----
 rust/helpers/pid_namespace.c |  8 +++---
 rust/helpers/platform.c      |  2 +-
 rust/helpers/poll.c          |  5 ++--
 rust/helpers/processor.c     |  2 +-
 rust/helpers/property.c      |  2 +-
 rust/helpers/rbtree.c        |  5 ++--
 rust/helpers/rcu.c           |  4 +--
 rust/helpers/refcount.c      | 10 +++----
 rust/helpers/regulator.c     | 24 ++++++++++-------
 rust/helpers/scatterlist.c   | 12 +++++----
 rust/helpers/security.c      | 26 ++++++++++--------
 rust/helpers/signal.c        |  2 +-
 rust/helpers/slab.c          | 14 +++++-----
 rust/helpers/spinlock.c      | 13 ++++-----
 rust/helpers/sync.c          |  4 +--
 rust/helpers/task.c          | 24 ++++++++---------
 rust/helpers/time.c          | 12 ++++-----
 rust/helpers/uaccess.c       |  8 +++---
 rust/helpers/usb.c           |  3 ++-
 rust/helpers/vmalloc.c       |  7 ++---
 rust/helpers/wait.c          |  2 +-
 rust/helpers/workqueue.c     |  8 +++---
 rust/helpers/xarray.c        | 10 +++----
 52 files changed, 280 insertions(+), 226 deletions(-)
---
base-commit: 54e3eae855629702c566bd2e130d9f40e7f35bde
change-id: 20251202-define-rust-helper-f7b531813007

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


