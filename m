Return-Path: <linux-fsdevel+bounces-8249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCB2831B7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D172A1C22B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E31E884;
	Thu, 18 Jan 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZ6nQwB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1A1DDD4
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588616; cv=none; b=ZOmPsj/fpsuaiCroxBFT7WHDwuC1PD1EqrXrugH/kFmMWJm3WB314mS3QQzChuPRHoxsknD4s6iV9VsS1nAJFPeWy8+jo1NGLkyjMmE66RSaZzHLqxe/9hH9wvAXzoF9KVzSL4UD8KgoQCieb0rIG/bS0pBar/1lD9KAJCshpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588616; c=relaxed/simple;
	bh=jhNAUl+zNRT0DrGGSk/2IHTE6BjJ/ijabDZTUKUpX+o=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Developer-Key:X-Developer-Signature:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type; b=MZDWBIffqfnsssnwqXSXFkx4fyGkqwLdmiTKyL7CXxHI8bw/7J9DM8gSSDDIT3yBAeRsHIu9akp6X3J8JgpwQRds4AQYcMu6hV9L6JYzV/UXp+64yf+5hcrtUZXa5VIMf9ZxQdYiS1DfW9OaKhuIzRwFZ5u9YnobPZw7UhX4vjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZ6nQwB3; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-50e75f8d722so387469e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 06:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705588612; x=1706193412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0v0DKUVm/o60VD+s4pHxHrhv8BixZc6h40304F/G0T0=;
        b=vZ6nQwB3rF9RTmCwwzjKD2KEIdqtgr0KLnHrSxJL2zk8sXvhd6qYWtegXpkjj8qdIC
         pHFpRjwyld5aCBq6ajCNCzkBzZDod4NBaLqv9sGvrgzTrKNn77BYjmlU14htf0ERuvDq
         BFINVc5iNyeiN830lIZWYJ/WsPWjWrGR28WKNK/LnpWpcpFffwtm2dsbUsFX37snAQkF
         kdiyAuRTyT93bY598ii8s04i1xC+rB08NpHkUs8kiuTL6kinup0jxt6voRzw2buFadDf
         vnPfzU0vVsfv9T4BASs68dWq4i9A7220APwzAD6p4UNU2Zk0EdAqZvbEeLxh1ymlXehn
         3zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588612; x=1706193412;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0v0DKUVm/o60VD+s4pHxHrhv8BixZc6h40304F/G0T0=;
        b=F0w5YKcRTNfa3miLUeOpgQRYdQpkUftlgVv1cRz5Kik/TwavyrqCaGt4LF5Bbe6Dd9
         4XxxzJBxuMSHBHz7vKThSiIAK7EE0Evi9cYa7R93il2BZMW1ZiIN/PD8xZBN7qP/VU/M
         4dup/F+hT/fc7fMVDj6wBBIoVfT7ITTlCefE0mbtXEyvsmEcV/c4C2r//OKikCld+s1R
         k+z8urBjK9WSwNtBO60pDOJtMJlTMBHK33nfaWdNQrYmm12S678Qke1ZFqvzfeQcEo6F
         FDqvM3m2e0IqtCX143+x9ejbsLr0vNfpBtvyqvDXulH49AQDCMXE0c9BAEgm2/uVk0Zx
         oqug==
X-Gm-Message-State: AOJu0YxPV6gLsW6I0Wc1QuEGGNzpJ7yeLEI3Gy9gQdR90zPk7TL82dYC
	bv94Wjtiu7haIhQYHahmzF6xa6N79VmOvTQPAlnB2wHRSnlia/vkLTzt8JyOG05jBISqRcUBjud
	4n+FXy7tenossdw==
X-Google-Smtp-Source: AGHT+IH++RrT7XJnlPbyNQDU0b3yDi12ZhV2bf8Jr+2xWg4gaqXlF8npqL0MspBZqGkPjDN99AkA5+X00UUBHLY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:34c1:b0:50e:b2ba:147 with SMTP
 id w1-20020a05651234c100b0050eb2ba0147mr6622lfr.2.1705588612573; Thu, 18 Jan
 2024 06:36:52 -0800 (PST)
Date: Thu, 18 Jan 2024 14:36:41 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4635; i=aliceryhl@google.com;
 h=from:subject; bh=jhNAUl+zNRT0DrGGSk/2IHTE6BjJ/ijabDZTUKUpX+o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlqTHLOLO4pSaf2+zw3LdhQoTIc4w+uP2NKl9Y9
 /cn6Z7VrtmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZakxywAKCRAEWL7uWMY5
 Rk99D/0TYZ05gVZnIv1O/8NQ7Qj2KOYRm7SGdDQU0riJGIupvyVGm85cuWSZ+eFKcM2VZQIbXqQ
 AKCyaWC79/EkRmp0tOTOA8dWiYyfYcAsdUCaEDMuPeGV72JyAeYpHSYHdOSgBOqf2EMr4dPBTA8
 lK7aYxg/qAUulf8m8m4uEHjVy0qSglOrzsshCv7uM6U0F3RjjdjcsQh2YnvBEXHV4gBT15TmLP4
 EY9QNde/ga8sOa7g4jIRvKg9TbpuImJQbL781fMYeXpfziHfGQqUoWX2N9PYym8i2i4raxaHaRO
 CeItS4DcdWjdqqgHAxRI2LA97Aou6+QeD7irIJmsm1E9LClzp0XaUGNlJ2QRFYIndXRzq5gNQC6
 szUZZcnDUdFW8JTMDTgNXnpNR6H+xL4rtW6aLwO530sIYCeSKpa1SgnqLwbo8Dhpmz52O9/IIuf
 J9BIO3+QS6OQAoMc/wm1F8rnH8Y3EFaAp0RNVEtET3HldJjSC5WH+fw7vP/E7YMPddtpa/lQXRI
 x2J4ruw9QgvhMQvEZ9ui2v9J+hQHIbVjuWoWb103Ga0kRT2g3oVkYcIFVA63Q0+Rjm6Bp60Nr37
 hXK6bG4BCWgN01WrjKI6GvH/32QP+6h+2SlX/3YzYu/4pe3tjebyngBh9tP9hTVwCNGrExsbf3M DOXWb0TOVvL4wXA==
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
Subject: [PATCH v3 0/9] File abstractions needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

This patchset contains the file abstractions needed by the Rust
implementation of the Binder driver.

Please see the Rust Binder RFC for usage examples:
https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/

Users of "rust: file: add Rust abstraction for `struct file`":
        [PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
        [PATCH RFC 03/20] rust_binder: add threading support

Users of "rust: cred: add Rust abstraction for `struct cred`":
        [PATCH RFC 05/20] rust_binder: add nodes and context managers
        [PATCH RFC 06/20] rust_binder: add oneway transactions
        [PATCH RFC 11/20] rust_binder: send nodes in transaction
        [PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support

Users of "rust: security: add abstraction for secctx":
        [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: types: add `NotThreadSafe`":
        [PATCH 5/9] rust: file: add `FileDescriptorReservation`

Users of "rust: file: add `FileDescriptorReservation`":
        [PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
        [PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support

Users of "rust: task: add `Task::current_raw`":
        [PATCH 7/9] rust: file: add `Kuid` wrapper
        [PATCH 8/9] rust: file: add `DeferredFdCloser`

Users of "rust: file: add `Kuid` wrapper":
        [PATCH RFC 05/20] rust_binder: add nodes and context managers
        [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: file: add `DeferredFdCloser`":
        [PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support

Users of "rust: file: add abstraction for `poll_table`":
        [PATCH RFC 07/20] rust_binder: add epoll support

This patchset has some uses of read_volatile in place of READ_ONCE.
Please see the following rfc for context on this:
https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- Completely rewrite comments about refcounting in the first patch.
  - And add a note to the documentation in fs/file.c.
- Discuss speculation gadgets in commit message for the Kuid wrapper.
- Introduce NotThreadSafe and Task::current_raw patches and use them in
  later patches.
- Improve safety comments in DeferredFdCloser.
- Some other minor changes.
- Link to v2: https://lore.kernel.org/r/20231206-alice-file-v2-0-af617c0d9d94@google.com

Changes in v2:
- Update various docs and safety comments.
- Rename method names to match the C name.
- Use ordinary read instead of READ_ONCE in File::cred.
- Changed null check in secctx.
- Add type alias for PhantomData in FileDescriptorReservation.
- Use Kuid::from_raw in Kuid::current_euid.
- Make DeferredFdCloser fallible if it is unable to schedule a task
  work. And also schedule the task work *before* closing the file.
- Moved PollCondVar to rust/kernel/sync.
- Updated PollCondVar to use wake_up_pollfree.
- Link to v1: https://lore.kernel.org/all/20231129-alice-file-v1-0-f81afe8c7261@google.com/

Link to RFC:
https://lore.kernel.org/all/20230720152820.3566078-1-aliceryhl@google.com/

---
Alice Ryhl (6):
  rust: security: add abstraction for secctx
  rust: types: add `NotThreadSafe`
  rust: task: add `Task::current_raw`
  rust: file: add `Kuid` wrapper
  rust: file: add `DeferredFdCloser`
  rust: file: add abstraction for `poll_table`

Wedson Almeida Filho (3):
  rust: file: add Rust abstraction for `struct file`
  rust: cred: add Rust abstraction for `struct cred`
  rust: file: add `FileDescriptorReservation`

 fs/file.c                       |   7 +
 rust/bindings/bindings_helper.h |   8 +
 rust/helpers.c                  |  94 ++++++
 rust/kernel/cred.rs             |  74 +++++
 rust/kernel/file.rs             | 512 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  71 +++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  15 +-
 rust/kernel/sync/poll.rs        | 113 +++++++
 rust/kernel/task.rs             | 112 ++++++-
 rust/kernel/types.rs            |  17 ++
 12 files changed, 1015 insertions(+), 12 deletions(-)
 create mode 100644 rust/kernel/cred.rs
 create mode 100644 rust/kernel/file.rs
 create mode 100644 rust/kernel/security.rs
 create mode 100644 rust/kernel/sync/poll.rs
---
base-commit: 711cbfc717650532624ca9f56fbaf191bed56e67
change-id: 20231123-alice-file-525b98e8a724

Best regards,
--
Alice Ryhl <aliceryhl@google.com>

