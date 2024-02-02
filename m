Return-Path: <linux-fsdevel+bounces-9986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E67846E62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F9F1C26F92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C3C13D509;
	Fri,  2 Feb 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4SvTzjPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5313BEB5
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871350; cv=none; b=h6XMErUdwvLikPwiW27KkGFOQYNiBpnP1RIbTL6Bj3u6gy84PgeFYSiq14apW8FwdcVun3qUdTjmN4qvRusZ2yPKPJqip1dKHs0UV+NiSmFwcSCizlhT/OwH4mvmxSEJ5ncUbJmaRiOi9ptIk+TnntkWr2abDvbMX0lIJcb0M98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871350; c=relaxed/simple;
	bh=mGdvPWrbrx4U8RhRaK04UOHddGQFO92nBOYIqfwKAKs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nr+qSuBwScfnm4XkUnbpi6OWyy/wabzCy0eg7bIOXYZIYABgOjOjarBALv+gn1EDA8ozC7yvR35BhXEWJT2jKIwwpFP8+/kLm012SxwAJMf6sVPIzQ+499xJh3n/Mv5//ZyOGqoqbi3xsXv9s7CZwIthyHbIAmw4Az36DOovp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4SvTzjPO; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-51126da2a28so1659522e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871346; x=1707476146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t1SYVq7IWrVJrOWe+eZ7mALVplGmC5gzqBZJtitkX2o=;
        b=4SvTzjPOjDDGfytsfa573Xx9cwxtFjxUPiBqoIOMNBglS9ZCncd9GhKzQa4VdpbFX+
         /XBze1+N+PESq3NzdgEDNtImJvmqLPxC+csVbz+r9NMzyinhJThLhW1MiuQLEQlyAmF3
         q0AJ5HOgGM8ZuO+unDcvSv393cCySsbj+EugqqvDnFde0bxhCZL3eq6806qmt2UGI1ug
         EchYz7TPgDghgq5B47hjsDxUiGUAbH9WDdMiBMVl9twXjiBYh3rJfKRnK/P++g5WOg/L
         zykTYnKLQ6l0t6+CbLEoUL6xcIhMTCu9197swrj95K8s2L6ZTUdvVRcN1lH57/Cf3kSt
         cImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871346; x=1707476146;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1SYVq7IWrVJrOWe+eZ7mALVplGmC5gzqBZJtitkX2o=;
        b=DiUWXH0GkwUYO9Qf+k9aU4Z+7eUMmH1VcyWtWvlZEAdgoLbu8LUGA3uJTZctojRfGw
         VTzKsjAqIpkAnCph2BX+XV8w69tgcSO4PvtyKzzQlfmyAIgRqX3BiK9L5uCywB+jRa90
         PRVoXn9oRJqODE2ZiLIOh/Eyi4zHTTCIoTwJ3DF8RSxA8aQBiKGD8cHFfitjDB6cg0yZ
         J8ReecUGDEMuvJZwZBTIdW7P8LnEFzkhVxcWBij4CVkKGTA/RVp82dsIIOxoTKLMugZ7
         En0uR0J+AHYwAIwKdS0UJ/6WTrlumC50BnMK8/U/3nDkFVnZjBgeTPiY3A+4jZW8LNPz
         vb6g==
X-Gm-Message-State: AOJu0Yxp9tDWGE1oTMMwVSnYmmSvVgAXU0P607ZaPNt3VYTuC7BVlAwP
	AXcOr+Y9OrAKwZYQT84PN0bW+9GFtcmF1l7YVjU5Hl5tMsz9/Nn3fwoq1KMcKBH88VvwscMKAia
	oFyPYkZY3zIooOg==
X-Google-Smtp-Source: AGHT+IGGObZWHfU6Slkxo1CoTAdGz+pUJ80DT96dUA/lIpV6yFSwgu8y5rONUnCiVdtJ64Ykr8tAblHpZyNAvQE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3904:b0:511:2c22:91d4 with SMTP
 id a4-20020a056512390400b005112c2291d4mr5781lfu.3.1706871346299; Fri, 02 Feb
 2024 02:55:46 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:34 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5345; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=mGdvPWrbrx4U8RhRaK04UOHddGQFO92nBOYIqfwKAKs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjE6pCs+rI00fx1280XNJDyXvExjIQNzU+nr
 4V0h3LOxsaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIxAAKCRAEWL7uWMY5
 Rv3FD/9TOTqjOveDki2tSpD80/JyKVOjmRv1jn9DDlUbxoGmotj+mKova98vX82ceo5Y5Cq9ccl
 QC8FYuSQRinH3IndTurAWmKwbvzGcFUXUXOJeL2H9+4kfKua4aB84OEbWuZIaAWYms7tSS3IFlg
 yL6Q1rDzIjxnhSAtbgLR+tRp+1kBt9j6+oqD4Vrd44iMUOiiGe8StLOVH6+07pk0W2CVHmd2Gig
 pUWDSrKRI8Q3ix1BdtJ8iv4/GNdaT9EEwQni9GNQGuoV/bxp0WDZ3keBeHVYVaoxhFh+UpTRnFY
 TXhq6sLHQLtxzprIU8HziNPOwZaZZwMAHJbMboxr/yDBY0RsW8yc0qW4Vn5dlJPo3CAZnF4kqPy
 jYQXA58Of3ZgfHKa3fH9SgrZ/RaQiH9AR9z3+xFsqZtKjfOTrdzJwqndoJf19SZBKaak13oXQoB
 zs2AwoRa/0pS/6taFC9RWys9PC9+K0hgi7Y1PK6TGgUIiKkdJvFxpBUt5tjnfkSIBfWgvL+0vND
 /gi2c0xpclugDJf81un4VHb3x6T5MTTzLKChyCXAqPXkmod8aXNyfvxhFwrrOUt180qmmCxoNNW
 2ROBqYZHrCMGU9OCoRPwWwbTCblkNmnkJ6wS4rkUgGaIfTKvDJ9zviTKBcDpIiJsDO6h1kR0SUh t0SwRm/tA3zcUmw==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Subject: [PATCH v4 0/9] File abstractions needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patchset contains the file abstractions needed by the Rust
implementation of the Binder driver.

Please see the Rust Binder RFC for usage examples:
https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/

Users of "rust: types: add `NotThreadSafe`":
        [PATCH 5/9] rust: file: add `FileDescriptorReservation`

Users of "rust: task: add `Task::current_raw`":
        [PATCH 7/9] rust: file: add `Kuid` wrapper
        [PATCH 8/9] rust: file: add `DeferredFdCloser`

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

Users of "rust: file: add `FileDescriptorReservation`":
        [PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
        [PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support

Users of "rust: file: add `Kuid` wrapper":
        [PATCH RFC 05/20] rust_binder: add nodes and context managers
        [PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: file: add `DeferredFdCloser`":
        [PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support

Users of "rust: file: add abstraction for `poll_table`":
        [PATCH RFC 07/20] rust_binder: add epoll support

This patchset is based on rust-next, which means that it doesn't compile
without the following patch, which has not yet made it further upstream
than rust-next.
https://lore.kernel.org/all/20240105012930.1426214-1-charmitro@posteo.net/

This patchset has some uses of read_volatile in place of READ_ONCE.
Please see the following rfc for context on this:
https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Moved the two really simple patches to the beginning of the patchset.
- Update Send safety comments.
- Use srctree relative links.
- Mention that `Credential::euid` is immutable.
- Update some safety comments to mention the invariant on Self.
- Use new name for close_fd_get_file.
- Move safety comments on DeferredFdCloser around and be more explicit
  about how many refcounts we own.
- Reword safety comments related to _qproc.
- Add Reviewed-by where appropriate.
- Link to v3: https://lore.kernel.org/r/20240118-alice-file-v3-0-9694b6f9580c@google.com

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
      rust: types: add `NotThreadSafe`
      rust: task: add `Task::current_raw`
      rust: security: add abstraction for secctx
      rust: file: add `Kuid` wrapper
      rust: file: add `DeferredFdCloser`
      rust: file: add abstraction for `poll_table`

Wedson Almeida Filho (3):
      rust: file: add Rust abstraction for `struct file`
      rust: cred: add Rust abstraction for `struct cred`
      rust: file: add `FileDescriptorReservation`

 fs/file.c                       |   7 +
 rust/bindings/bindings_helper.h |   8 +
 rust/helpers.c                  |  94 ++++++++
 rust/kernel/cred.rs             |  81 +++++++
 rust/kernel/file.rs             | 514 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  72 ++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  15 +-
 rust/kernel/sync/poll.rs        | 117 +++++++++
 rust/kernel/task.rs             | 108 ++++++++-
 rust/kernel/types.rs            |  17 ++
 12 files changed, 1025 insertions(+), 12 deletions(-)
---
base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
change-id: 20231123-alice-file-525b98e8a724

Best regards,
--
Alice Ryhl <aliceryhl@google.com>

