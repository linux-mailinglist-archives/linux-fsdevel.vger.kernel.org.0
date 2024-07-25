Return-Path: <linux-fsdevel+bounces-24241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F593C418
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F57B21B20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1A19D07C;
	Thu, 25 Jul 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVFNNCjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156119B3C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917667; cv=none; b=njK04D8AQh4nP2NCazWcvNbCpb+LbgWQ0+0VOwdtiHirLRmgtYNkakHXELG25NVyHtyVxcx/BXSoHvjHj9Kx0be/RPOGnRn8E1pdV6OCBmpw4JLa8nVCp5yaJAqCsmG/g7wHcozovW2iIfwHTiL/pB0C/AjYr/Fppbaj14zIZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917667; c=relaxed/simple;
	bh=7Ty2jd7XS19f8jweVbNXl/I8ZxDPi9ZE32hd5VUkXV0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rlb9KnjmsD+KG/izff/DLeDeY9lAujUjL0YA3JJz0NbUA/Kl3nPcxw89RI0YMe14VXezO2rIWxupzYiVq+OAM8oKFdGtDjy4rOYSUd3mxOd5+L93dHG7k70IcGLpPW4io7JpHnZDfo8u75jNMV+yl8KP/Fh3534VBUHgCPpDsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVFNNCjt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso1843543276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917663; x=1722522463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FmMvEDTUM7SJGjPHPt8xAPFAtJI/4JVS81vyFcmWnms=;
        b=QVFNNCjtzgzxqAmdpGXDziQM8DcvP73OulELfwK75xTUsb3kbxABB9+a49/thP2yhO
         aSHMkI/cEW1ZmxbUkma03YrXJm04DdiqcharclU4J9hLzTncAa3Lf5wiQKYlw6CeBJKH
         JlrDD0sSMVST09q4n5aOKP+Da2LxNTx9E3I467TiSsI5ELImUpfuJkLW85sb/k2u9WuG
         BJGHsWDdW1+mBHcSg2kbt1LfEw+OCDfXZIuIccOezk2KGgmasmh5+pzieU0c3TyiZFGt
         ySednpT1XHQDn1TWUgvYL5a854NwRmvkgJawjjQT0OghzrZW2Twm8kjZHN1y311qbOhG
         i2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917663; x=1722522463;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmMvEDTUM7SJGjPHPt8xAPFAtJI/4JVS81vyFcmWnms=;
        b=tFt4jK6Hvo5i5FvF9fKgXHyLhLVcTui/ruhWA5KFIV00hINNTH/UIcepwDm7YXiOaL
         F0jTo3ETlzaqa5sUbUfFzyzTt/Y4XL710UWm+wt3bBoOig1aqSBdEnfJN+4C9tyB00tP
         bTKVgszq/duOJrQJdKvodsLPVXHhES2ZWUhRnFnUARtjkL+XeFf2ZHeMWTClGdEgzFlq
         Yu1qbxf4GuG1iQupGoU9oUAmV3MpjHnk5cZUlXoYmupHL37HF6xFOOyX5qMphSm+ps5x
         zUh64hvcoUoqxblzGlHMErJyop9B9QVIoSuxrUbdzrSCYsykN9E4vd8JizC1D9SZ8Y0w
         41/w==
X-Forwarded-Encrypted: i=1; AJvYcCWiVHTVZwyZf4OAY/oX6L4Sf4rYeYIaj6FKIS6hgLjr2E+TAF5VzR333djwxWwTZ6KbhnImlSSbCHt3/BRBEl7dTzP3dOL8w7LWOKbAPQ==
X-Gm-Message-State: AOJu0YwtcVM48NnxRkxPwOtSOs5MRsgCQGJuYvikVxZo/3lg6x+seqRq
	fo0EfB8bLY8JA1RRS+AjaWy2syBBT420Iw2Gl0lmywxHy2wIhQfYwR2zAmwV/TwZ50HG+gsx3EE
	xvni/H54i2IC8gg==
X-Google-Smtp-Source: AGHT+IHIyIby8/kbfXWmuAvlBrV0aU944PjZD5psJRwSOEPT31ufxVnHeTHQaIv5R/bBugq+xOrQHsRPjUPFZTw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1542:b0:e08:5554:b2be with SMTP
 id 3f1490d57ef6-e0b246d7917mr4492276.9.1721917662576; Thu, 25 Jul 2024
 07:27:42 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:33 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANVgomYC/2XQwWrEIBAG4FdZPNfijDqOPfU9Sg/GaFbYbkpSQ
 suSd69ZWLKSi/AL38/M3MScppJm8Xa6iSktZS7jtQZ+OYl4DtchydLXLFChBkAtw6XEJHO5JGn
 Rdp4TB4dGVPA9pVx+72UfnzWfy/wzTn/37gW230eNf65ZQCqZGUJOHB0SvA/jOFzSaxy/xNaz4
 G5RUWOx2pAJXFS97705WP2wRgFwY3W1nrzpKHvLKh6s2W19Gmu2maOPqFgR6e5g7bNt97XbzNo xk2Ot0B4s7daCayxV29W7h9xH33l3sG63hO2+rlrTOwWZtLZZN3Zd138xO/BRDQIAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6039; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7Ty2jd7XS19f8jweVbNXl/I8ZxDPi9ZE32hd5VUkXV0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDWNt7ibPDJ1eL1PPHozS6mf+hTCblcGVjCN
 MQ+GzuFmBOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg1gAKCRAEWL7uWMY5
 RtHfD/9VMrneoaL4q+y0LfbWz4/+qwBauIBE2Txq7IhR1unzqyiAyozxTbKgthIEoLOvrcILz7E
 NBizvZVMi+ROmGe+V5xn946G54EKFXTxP82npQBQ6G879LmQpGgAzgKvLfHcOqHf0u8XKAgeS9v
 V3WOoDpvgEIygZtydbMDVb/pYvJUgkwdyA/IpnEKyWFf766HPuqibQso49iAvUrgoZJhjOfr2SE
 0VlvG4M8HYmWsQUvM/48YXKvh6cgAynt1apQ5D2RtqEuYNJ+sr6o4ULmDcKCWdj2i5fL/NToLiZ
 LTpnCJ31N9LNeBzBUibG78XK/6YuXhEbSzAZvLlGVf6orof+xdJcYGbjqGxqry8laOy56ZdH4kr
 /eIsRKBbLfr9d0VvGV4MAs5u9WQ7NlDqtX3ZPpB7xAPcUrutWjNvP9eIKOEYxnbJG+FyaAVOwAH
 0DcYSEeECgI+HHiicPwh6DUtRPb1Jn+dHFpTZRNresQ24Q18IvxPUfiINJTStGjjU63O6zPRKJh
 W7hXQiPgSLxUGSYW7LvnNjzhk6qE7Aez+OLPrGjGt8f61Gc09C7SZF+RrkQCma6Y7VkZYYei+/e
 gsStscz1LmBk3dEygUTMtsyrhaNrszG4D7OqncyFJtSjXqBhvF3fkE0Ehxpb+wcshFmVdM7K1Au hBRqOCp60xtcjrQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Subject: [PATCH v8 0/8] File abstractions needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

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

Users of "rust: file: add abstraction for `poll_table`":
	[PATCH RFC 07/20] rust_binder: add epoll support

This patchset has some uses of read_volatile in place of READ_ONCE.
Please see the following rfc for context on this:
https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v8:
- Rename File::from_ptr to File::from_raw_file.
- Mention that NotThreadSafe also affects Sync.
- Fix copyright lines.
- Move rust/kernel/file.rs to rust/kernel/fs/file.rs to reduce conflicts
  with Wedson's vfs patches.
- Link to v7: https://lore.kernel.org/r/20240628-alice-file-v7-0-4d701f6335f3@google.com

Changes in v7:
- Replace file sharing modes with File / LocalFile.
- Link to v6: https://lore.kernel.org/r/20240517-alice-file-v6-0-b25bafdc9b97@google.com

Changes in v6:
- Introduce file sharing modes.
- Rewrite most documentation for `struct file` wrapper.
- Drop `DeferredFdCloser`. It will be sent later when it can be placed
  somewhere where only Rust Binder can use it.
- Rebase on top of rust-next: 97ab3e8eec0c ("rust: alloc: fix dangling pointer in VecExt<T>::reserve()")
- Link to v5: https://lore.kernel.org/r/20240209-alice-file-v5-0-a37886783025@google.com

Changes in v5:
- Pass a null pointer to task_tgid_nr_ns.
- Fix some typos and other formatting issues.
- Add Reviewed-by where appropriate.
- Link to v4: https://lore.kernel.org/r/20240202-alice-file-v4-0-fc9c2080663b@google.com

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
Alice Ryhl (5):
      rust: types: add `NotThreadSafe`
      rust: task: add `Task::current_raw`
      rust: security: add abstraction for secctx
      rust: file: add `Kuid` wrapper
      rust: file: add abstraction for `poll_table`

Wedson Almeida Filho (3):
      rust: file: add Rust abstraction for `struct file`
      rust: cred: add Rust abstraction for `struct cred`
      rust: file: add `FileDescriptorReservation`

 fs/file.c                       |   7 +
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers.c                  |  86 ++++++++
 rust/kernel/cred.rs             |  85 ++++++++
 rust/kernel/fs.rs               |   8 +
 rust/kernel/fs/file.rs          | 461 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  74 +++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  13 +-
 rust/kernel/sync/poll.rs        | 121 +++++++++++
 rust/kernel/task.rs             |  91 +++++++-
 rust/kernel/types.rs            |  29 +++
 13 files changed, 973 insertions(+), 12 deletions(-)
---
base-commit: b1263411112305acf2af728728591465becb45b0
change-id: 20231123-alice-file-525b98e8a724

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


