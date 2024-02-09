Return-Path: <linux-fsdevel+bounces-10921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2383084F46C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6A31F2339D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9802DF7D;
	Fri,  9 Feb 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfjXB9Nw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773992C1B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477532; cv=none; b=RSYMckf3Q2Yh6N+e/XbrNCxN/FZloLsbPrO1WnLk8StIRr2MDCSEm1fLZ1O9375FfG2tgDCxv3UOJJB059V3BqCO+E871tNC4uxjrIXcDEpEACZ5Zl7m9r6hKfVrNnOSfaFgQVmqUP0q8att+59HTyF/2VDxXp3SzDaLlHtUl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477532; c=relaxed/simple;
	bh=Gpy7ziB0JDQ1OJWFxJmiq8bG2HMIwkNv0HIf1uBOKHg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VtG1PPGRn1JgnL64NoCz4CfHTeCLl/1afgBI4BNBd2wFL6qQ+fza/uPPvxLt6pwTbn/uqT2MolWyvW2ULFoJipNDaS16xas0Aakvrv1TUUXLntjdfzz7cm7B+fXCpJLvhhQpqFw5isSP/ZZOBZ1xHAcsaEj+Tu9M9RAmSG1lDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfjXB9Nw; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-5116e3cce79so768000e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477528; x=1708082328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SHWFr0o7nVaJfX6SDsUG6CZHBy53eoMvg9Pc8jxLeGw=;
        b=bfjXB9NwbIf+8KV0FPMgtRSW8AIGRs++jGiv1gRGjIykgUlnLhXk7uP7pXz3ph0X2c
         SHdg+KXu1Jkrq0g7bF43LmjLI4CLeUlf7xX9amNFpxgAt2DlFXY9iCT3ATXpJm/be158
         jEpaFfCxzLH1bYPDcPtwyBBD/s/L0rhuasgEoohfHIOBm1KEUVF+OH+qZSRRBohgfqpS
         IybIYP4z5c3jg7G6y3Gho9Z98GLYeexo6nVudXBjAA+p8aBKfgfoCQDPkmdPTmHGLoFQ
         pOezRwfrylptagnOW6MAFICGmBubPvvn+9qRpCWQhr852Lzf+5lkSRF16vd5tdyAEbar
         iHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477528; x=1708082328;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHWFr0o7nVaJfX6SDsUG6CZHBy53eoMvg9Pc8jxLeGw=;
        b=WpZd/5G4JCQBrZdO9Tr1Oi2ORzng9m6lBflMz8Wz/fJVFBK0+jqR6/vBgX8rAnAInF
         fNY1WFvS4mkZ8oZCw2fyBTGsEarUYIf/8W+T922tTUq0ywVMqkh/uk5If4yld7q0Tv33
         QXUT36VQ7cyADTrHRAkkZgt53E2YbQg9FZJ5T/O9j3UdXqqbbjPR+XWjHC3jAVEcx3z3
         xg8Xo5GZPVJe/mReRlSZQ82wnVP7ByFuHo8sA1Z8HHcttm1+vgAPp3lgwsgBfoBRlt9T
         /khpTCWM0jSkC0tiq9FUsSNHHcn1h8ELNMG3X6eeHwltB3cZwL5jvmgpUZnPhh6uGgRe
         UzZA==
X-Forwarded-Encrypted: i=1; AJvYcCW0kVm5znKIBUUlMhM6j8gUcVSmsfRHMXqyLrcga2u3gHw5jSNSZErW596uR7putdpLLkuWCs9BzPYzIRXP+jv8tyws23Aaip1Pva8Nrw==
X-Gm-Message-State: AOJu0Yx7fbUnO1fERp22BnshQ2j9aCpPNeKdyzkOPEZh41m/ZTyouhGm
	wbLkNJkF0zdVsXEFki/gBjLdE91bsWVByURJFZ59SHMGxnu6bL6JQajEduUpeoR0vTQbWtGkyCa
	U0+gDXIA19O/XXg==
X-Google-Smtp-Source: AGHT+IFOsK4WWUyfr4sQfwmC5PcxbB0lo89QwRCCNg20BNjM8Xnn16lkNmrgmYEpF+qvM5aDH38zikK9Ki2bqh8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:208d:b0:511:51ec:90ea with SMTP
 id t13-20020a056512208d00b0051151ec90eamr1016lfr.1.1707477528191; Fri, 09 Feb
 2024 03:18:48 -0800 (PST)
Date: Fri, 09 Feb 2024 11:18:13 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPUJxmUC/2XO0QrCIBTG8VcJrzM8R+e0q94junDuuISVscUox
 t49F8QauxG+A78/jqynLlLPjruRdTTEPqZ7HsV+x/zV3Rvisc6boUAJgJK7NnriIbbECywqa8i
 4EhXL4NFRiK9v7HzJ+xr7Z+re3/YA8/WXsf+ZAbjgwYALZHyJGk5NSk1LB59ubO4MuFgUemUxW
 xc0lF7UtrZqY+XPKgFgVlZma7VVlQ62MMJvrFpsflZWzX/21qMwQmtZrew0TR85x0YrWQEAAA= =
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5469; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Gpy7ziB0JDQ1OJWFxJmiq8bG2HMIwkNv0HIf1uBOKHg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxgoAJlBOkBuZqb7aqud7lwYRLxizcQYR49fn4
 8a7uC7m5RmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcYKAAAKCRAEWL7uWMY5
 RpQVD/9Y7HeTuylq2VajFWEMWp1pZMeNy7tMqRxFhBi/ItZP9SNWSvEBxyHomM5yLvEmsYK4IkJ
 SAmasr2xDfFZGcdmcFJkCQlmZahHJaMThaZz9bMIMeGW6aU0jZkp/uudjVTpfBPqrgkSJhwURpa
 wEyt69dAfaNOSzf9mF8X8CXIKXa4uUYmNYj9a542ycsDiCfLQ6ik01BDCUVpXZo07aoorkXo415
 UVpBecMm3kkO/XsrELGqmzPFu9vV7C7hGklX07TorX/jBME0XduUP9LKPa1En4GXbw1HPWQEtF9
 y2Ly1qhbioxn6yVMnn93bitPWEFmRP6uwCuVLvVdYVfQFypMUqmqgDVVB65CfC3916cJkwl00i6
 53YcPwAwJk1yd/N8f+e4+6+uHdyyESsY2eNyuQk38Q+p6dESoVi6PrZD3m5mPH0n4Mu0YTRDMtt
 Avge4XVeZRlEpVL9e7zRPAOrBVBFaHY75+1HcEUV/Ch6V5Kd5aR1FT7Ej5MJwJIWF8tKBkVNRpF
 snDecJpH2egt9GjGYkcOelQmNwHZ36c887a6MkGFkZmnw/IbhNZMUnFKS3qP+inMvViZe0FNQZp
 LiJgoH9kp/WHqUrWJhzM1HNEYfc4GRc3JW5XMuO+nYjk/WmnJp28pyd3yATJi61z+mXV3nS2GoJ uXQR/XuMlEkmxSQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240209-alice-file-v5-0-a37886783025@google.com>
Subject: [PATCH v5 0/9] File abstractions needed by Rust Binder
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
 rust/kernel/cred.rs             |  83 +++++++
 rust/kernel/file.rs             | 519 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  72 ++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  14 +-
 rust/kernel/sync/poll.rs        | 117 +++++++++
 rust/kernel/task.rs             | 105 +++++++-
 rust/kernel/types.rs            |  18 ++
 12 files changed, 1029 insertions(+), 12 deletions(-)
---
base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
change-id: 20231123-alice-file-525b98e8a724

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


