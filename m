Return-Path: <linux-fsdevel+bounces-22783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D491C1DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E621C2221A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD451C2320;
	Fri, 28 Jun 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuGeR8kB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A511C007E
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586669; cv=none; b=Wjde70yK5KO5pF6DMRQh0zpd2xvVVGEi84LjTEBexmEcVb13bo+/8oGxJX30gO2brV85FP+wdO8f0xNc/IOApkbNi7NAQB7muK+FIQCnM44KLC+J5wN1xx8L25LEVOdLV8T0fBqrK1hyeMkzHExagctBxbtaTdZ+kVKV0GcJ3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586669; c=relaxed/simple;
	bh=M3YIVmz5boCkvi0mnE4L1CziPuvjOFE5n9nrA82sjnw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iktZZ0/M17zhO/CAmH7tqCjQD0qasAFhJc6zRtWWFh8ZikskzX5U4WAZsh9ytkqd7KrMHhuDPwzbuzr0Otgx/0oRmg7aHHnfWIayNhH/9zsdqtNQ8rlBBlnuP0tQFebriKOzFjrYsLLgTYZ1QNPJhFsMw29PKfsc0kAnxgiUbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vuGeR8kB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-643acc141cbso7646657b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586666; x=1720191466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NA8HRtt4OeyTIYVrVVw99oYidbVN1cJjouXWxEI7IuA=;
        b=vuGeR8kBEYJjlLob1BajpQUo+rAAHA9NFcCQ2CXn+aDRRDeISc2w4lY73gxRe2bXLe
         QzEy49/TQ0kXgzWRhYAHPNnsvwP0J93XstSBZhcCZ4HnKGEqHoDqIE4CRBJPmpO2GHrf
         dpNWNDbArDJIuz3tTJsFawleuPjEMb/NPq3M+7pdk8SfSKtWVxYFdqIp2D3xFSs2LCE8
         cWzxJGGTdfr9RNRiuce5E9ghO8wvOfcD0vKcbNSA3MuZP3POEWaD9DlFCBd6Gt5V0k2H
         FIJMJCTiaSfKCmmg+KXYcyWyaDgev0qjpLKgtSoAceY2ZNr1tZKtU0O3o8k5hWl0UuGt
         /t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586666; x=1720191466;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NA8HRtt4OeyTIYVrVVw99oYidbVN1cJjouXWxEI7IuA=;
        b=gpI1kXVp+kIhHko+XtYHkqPa95n86xw6dI5/obnVg+/+vrFpBZrOfAlEshgq58Xn7Q
         0dfznV+A7/iVjZ8nZmYso6rFmFIZFdXBlV2IR8j0mbMV64hjLZ1dz4I34DznbKE27Heb
         Xe5slPH1IF5ygzW0NTnRK8w990okIRLAMJ54SshlCPC/82/ZByLlsAgBzQTW8/yfwiTj
         lWzd3OwcaTgzVjA36LwAmp2qUCAUqnoqqS1Zl66rPxAcC096OdY3MmCQljXgahMkSTCv
         JrAttCeRvKkpNxR/rRdfeKmKvoZi53/cyHkPaZfCBtq4/JPuTq/xWyhF1BKZDPHm9KQh
         0sLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj01089KtocQyvRyLuXjERxsuppVuh5bwjc8shmVFBbivlx5Rc8rhnbBKaee9a0hRNEmLp+V9hJw9yLWkQTz+XGEgjVGa4VzF+RqZvMA==
X-Gm-Message-State: AOJu0YyyJVF3geE2W8NApL8h/kqhbtgYcUT+tSH7PW94lFLCAEhEeFql
	vvVSh0uMRNH+avztwjjzYnqgbateD/AI5A5VjfuP96QKHSdV5DcJtssuz+7c1QCKabL/u1Vdhit
	esiCe/1FWP9M5rw==
X-Google-Smtp-Source: AGHT+IE+eDmpLmhKs501YYhrpAk6zg+yW4a6qnT/SvB2OB1cKFo2A6iIj7oJWlC5W10VD6MHC8kEGeWBSLCfFvQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:f12:b0:e03:5e58:489b with SMTP
 id 3f1490d57ef6-e035e585039mr10750276.3.1719586666015; Fri, 28 Jun 2024
 07:57:46 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:13 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEnPfmYC/2XQTWrDMBAF4KsErauiGf1OV71H6EKWJUfgRsUuJ
 iX47pUDwRHeCJ7ge8zMnc1xynFmH6c7m+KS51yuNdi3EwsXfx0iz33NDAVKAJTcjzlEnvIYuUb
 dkYvOW1Ssgp8ppnx7lJ2/ar7k+bdMf4/uBbbfZw291izABU8OfIouWDTwOZQyjPE9lG+29Sy4W
 xSmsVitTwZsED31pA5WPq0SAK6xsloypDqTSDsRDlbttj6NVdvMgQIKJ4yR3cHqV9vuq7eZpXX OWCcF6oM1u9VgG2uq7erdfeoDdWQbu67rPyzbBv3RAQAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5663; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=M3YIVmz5boCkvi0mnE4L1CziPuvjOFE5n9nrA82sjnw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9RxbKPPfzciPL6lpJcTc5NeEvkMayauk+9U
 jwlGw5zYyKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PUQAKCRAEWL7uWMY5
 RnNND/46YpaiCkKy5HD29LASC74h6d55rWtDSiLCMcXo0fX2xZd/D4ivN/E6elk7JGOAMjjx3F4
 2HLLeGAVwiET4UyYaKJz9pHHBpoli5lVjCNoz0THr199QV7Ue5AVPPxo5SeyH6ICGKHuLVGMgWp
 TsoPMtNLvkPCXF25VYs5TZ8QR+UC4ztHAMU10IUm4oYmYyxhMcHRicFMO87rwyqTFM0jNMUnoC6
 LmwkYyHMk0GQdgETumIOiCk1KV4eMDbxaRSTp4WipJxzWxnLmpVcfi5CIc20YK0lfNs9EV6kvhn
 8pmpy+mRf89w6jZneQNAQRCZ1MLpxjc6WHBGeCJT93rVvqs0KLniN2jroPzWudOZONpR0wMpeJS
 w7yqjkIBpB/lBGUDO1E6rOiwiNT4Maf8o419xn3cis6UcEgEFg6DzmuNFzklzXM+dktEE4JGC82
 TXBSsghD3HVUTmv+taSHsvUnSpn6k+elntzLgFfZzmFCP/xjJmxpL0GJCqhrgyxBy4oKO11v/Ba
 CX580/7Zmb+e3jwe+NoP6ZbagEDJ5DGlzpzDgGGT5ydcMnYQ3C+b3Ju9hxocJYSGfllkn9Jh3Yt
 WHLliehyLwojSTwTx4+Ytv0Qb3rYWChIAoK7cveItNYShF/DN6iBfOKSDwmG36d+7TyVjYBqyuJ r+jOWevz77R690g==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Subject: [PATCH v7 0/8] File abstractions needed by Rust Binder
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
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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
 rust/kernel/cred.rs             |  83 ++++++++
 rust/kernel/file.rs             | 459 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  72 +++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  13 +-
 rust/kernel/sync/poll.rs        | 119 +++++++++++
 rust/kernel/task.rs             |  91 +++++++-
 rust/kernel/types.rs            |  26 +++
 12 files changed, 954 insertions(+), 12 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20231123-alice-file-525b98e8a724

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


