Return-Path: <linux-fsdevel+bounces-57745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A1B24E66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756699A49DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D3287517;
	Wed, 13 Aug 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX/6PhTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906C24468D;
	Wed, 13 Aug 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099915; cv=none; b=kGwwojf5G9tVoh+ZnYhStaIOiZ9EOn0p007B+quWs9IiJMUQrIvOWd0Hqgi0OeQsuQq8ERuCjxKc72frhAaARpGUdKp27KTtmhArw3GOZxbfrOmfB6U+0OljK6D5x+NeMBZ426Q+SDl/bz39HVA/HKET9KryUuxEy7Lnl3b3VmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099915; c=relaxed/simple;
	bh=stzNSR7YVVO4mhJL85aVSZ9OiFGzP4bNmlXxQrGpD1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LOj6qR+KL6ROnJFMjRog+Av1Yw9NeP2/YUubVRTBrXhQClPNQ7VaDeIyQUAsl0lYn48gp6LZIv1COh/jTwRB14rtz0lTeBgZ/rMUKE/Wmvbh0rbC9RzyZt3V4RimtAoUNUkg0bnvLU28CZLOzGHVzYR8PTXYwjDSmPbLzGp8mOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX/6PhTR; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70a9f6542f7so341486d6.3;
        Wed, 13 Aug 2025 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099912; x=1755704712; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8va3jts9g6WRN4RL4mjY7ZuhFWahTXZ2Z84JGnvkdyg=;
        b=lX/6PhTRLe1HClcZRppnkfEDFRFQlE4MppCFEmr+hvTt93U8Ap4wF0mztPPkA37jGk
         w/CoZ1+KtJHv5GfT7PcxOPbxI192o3109ucZctUK1lXF60IkxCqR05Y5mdTycCIg0h9e
         A19AHAFs6unQ3T0nAq8xqCxFKaAkjmXzyzk/jW+lErZS04z9xDoSxVTSCd0tq5J8qNP3
         vhzgusFauXAzLNEeDU/Wm6q2H0t5OFDbIL0ZucJQmNa6vSmbw1eklXMcjN/f93024ae6
         NplDGzZUIfBLrC/nmB23LtXQFdCp8vcErKBMIQ0VOAa2m3Yk/FjAinKJ+XYkgnrqHeVn
         zgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099912; x=1755704712;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8va3jts9g6WRN4RL4mjY7ZuhFWahTXZ2Z84JGnvkdyg=;
        b=SU1o9TdGz0RhirSP5Tuz5LSWegmuXiqSPpMWuKsFXI2Q4W46gJUdOt//Z1bc8V3vG8
         3tO7n6B9y6Bx/TD3z3ZZxvKqKjawGIYA2LTR8Ua4R+WfNbNmWchxneQUyHVnwysDWt+J
         e3U8yRmsenz+qbe8l5seir7eRxTffOpGj8RbVefBWyfDO7DoYZ6HUtecR5QslEIM5Avj
         5a5nNOlbjw6nRuSpwdPHEjJbfyrjci3PpYWtbQ1NLcJsKqWHUDYxswf8mhf662/0lH4y
         Vy5hTeKdmNDBvquptj++qxjE1Kf09VjywYHC41aM39jehMeeCwUldzRliYHh7oahnQmZ
         SV4g==
X-Forwarded-Encrypted: i=1; AJvYcCVnAp6lR9O9IzhSeADepiNw78wE7FNxqoTzQwCICm9F+ekfHwKmeahhaCMbgQbOxaWRCyZnV8v44AmsC8SC@vger.kernel.org, AJvYcCW5nkdppXrIg7bB2U+U58BJS0+UJBaQ0RIKGvYTSxaaATTS1gwrIx7z66AoJSl8ruhFzyFfamQ7RJu3sww5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh99sJ9WwGqGQIKEVQpn1xUKij+HnJ4PQV2zQ7m1DMWzxPAUAj
	NTTz/+I5PwN+QB12hoGOfv3J/GauXxAgWLbkxZMgnrfrpK17f7bBOHmV
X-Gm-Gg: ASbGncuWIwSK7djVEec5FTRJN6Sp3MW+xqCb1CEMhZtie+53Li8VVk3ArEfWLM/AI55
	OPW1/va0VmKlCK6znKED4sYgO3Y1GRwG9q2Vy/amzGuUXdyOPvey6l/pwypPdq9k+2NYDdLO/II
	xD5rdgoozt7tQtniHNm4EMtxtFNVx+Q5UgszSURd/nmzBj6MtxTXSKfxegLiIOWsVQeR/iSpLNT
	w6bgWPFtsJ3Oz+1NtiW6/Mz/7ZszDzCeyq9wlNOBeukgBSTEpNqDfMm2ofKteF4KujIXVOt5M7x
	Blg0V8O90eh9IJ7wJ/rZaCWFT4GWbBpsuTFhVNyXYPZfFSp1idonrEVZnDKbyYLn3mTpVic5Xhu
	sUNAIyWWPsVFAIfe2uKCS70N2lrRR1ldnD3u/oxhp8kNJArD7G13rX+REWqidpyk3T8TjrN8yKH
	x/Z5rFyQ4XmpwFIjrrV6hapMuzvyVSP+TsZBmLusmZjcTw
X-Google-Smtp-Source: AGHT+IEw7GoCagC81P6CCxrhzikSDCAhCvx4D5275LDY8M+H1gVXmbg6eNOKubdSNSaVoML7/rQwgg==
X-Received: by 2002:a05:6214:20c3:b0:709:b6bc:f6f4 with SMTP id 6a1803df08f44-709e89579a2mr47020186d6.32.1755099911489;
        Wed, 13 Aug 2025 08:45:11 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca3621asm194127396d6.33.2025.08.13.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:45:10 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v15 0/4] rust: replace kernel::str::CStr w/ core::ffi::CStr
Date: Wed, 13 Aug 2025 11:45:04 -0400
Message-Id: <20250813-cstr-core-v15-0-c732d9223f4e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGznGgC/5WSy07kMBBFf6WV9RhV+e1e8R+IhVMu0xGTDjghG
 oT493GCmE66NQuWtnOujyv3oxm5dDw2x8NHU3juxm441wWaX4eGTvH8xKJLdaORIA1IQEHjVAQ
 NhUXSbWhtQAmUm/r9S+Hc/VnDHh7rOpehF9OpcPxO0OAxoFHW2DvpPTghxRzTUIZ5fH6/fynDN
 Jz72P2+o6FfIk/dOA3lfdWb7RL8LSI3IrMVILy2gZJNMuR0//QvZBGZ3X9JV8kU0dcjCVr5a9J
 vSbUlfSWpVVladt56e02GC6nQbclQSYPJEhkps5XXJMIFNVJvUYTKWo0yBp1CcuaGxQ2rYMfiY
 pwCAbXUBri9V15Yi2HHymXCQIFcq00AuGHVhXW7ltSjyta/4pLiNrh4MynUGxb3znpxjo6Bopf
 kd86fX50r/PpWezt9Fa9p48iV7vtuOh58NpEVJLvMSitmhuQAvEox68Q+M5pkvFm61vM4xrXvx
 8Pq4qv5qrEK5Xge3iaBYl7eY7Qh1C1pnfPG6acxEQ1TBBPI4O5pn38BDTJLFJoDAAA=
X-Change-ID: 20250201-cstr-core-d4b9b69120cf
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
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099909; l=8791;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=stzNSR7YVVO4mhJL85aVSZ9OiFGzP4bNmlXxQrGpD1w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD7flcTHe7UNsJBM8aVqwkgEC54LB+YN5qPzZfyDhONFxgt0HDbUnZIdp6D8ttu/Ik71EC53EPO
 tW/t9LnFC6QQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
have omitted Co-authored tags, as the end result is quite different.

This series is intended to be taken through rust-next. The final patch
in the series requires some other subsystems' `Acked-by`s:
- rust/kernel/device.rs: driver-core. Already acked by gregkh.
- rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
- rust/kernel/seq_file.rs: vfs, I think? missing MAINTAINERS entry.
  Christian Brauner <brauner@kernel.org>, perhaps?
- rust/kernel/sync/*: no clear owner, probably doesn't need any.

This series depends on steps 2a[1] and 2b[2] which both depend on step
1[3].

Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
Link: https://lore.kernel.org/all/20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com/ [1]
Link: https://lore.kernel.org/all/20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com/ [2]
Link: https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com/ [3]
Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v15:
- Seal `CStrExt`. (Benno Lossin)
- Add patch to remove trailing commas from
  samples/rust/rust_driver_platform.rs.
- Link to v14: https://lore.kernel.org/r/20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com

Changes in v14:
- Break the change into multiple series.
- Move `CStr` reexport to `kernel::ffi`. (Alice Ryhl)
- `pub use core::fmt::{....}` in `kernel/fmt.rs`. (Benno Lossin)
- Avoid unnecessary binding to `first_lit` in `fmt!`. (Benno Lossin)
- Add comment to `identifier`-extracting loop. (Benno Lossin)
- Change `quote_spanned!` formatting. (Benno Lossin)
- Link to v13: https://lore.kernel.org/r/20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com

Changes in v13:
- Rebase on v6.16-rc4.
- Link to v12: https://lore.kernel.org/r/20250619-cstr-core-v12-0-80c9c7b45900@gmail.com

Changes in v12:
- Introduce `kernel::fmt::Display` to allow implementations on foreign
  types.
- Tidy up doc comment on `str_to_cstr`. (Alice Ryhl).
- Link to v11: https://lore.kernel.org/r/20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com

Changes in v11:
- Use `quote_spanned!` to avoid `use<'a, T>` and generally reduce manual
  token construction.
- Add a commit to simplify `quote_spanned!`.
- Drop first commit in favor of
  https://lore.kernel.org/rust-for-linux/20240906164448.2268368-1-paddymills@proton.me/.
  (Miguel Ojeda)
- Correctly handle expressions such as `pr_info!("{a}", a = a = a)`.
  (Benno Lossin)
- Avoid dealing with `}}` escapes, which is not needed. (Benno Lossin)
- Revert some unnecessary changes. (Benno Lossin)
- Rename `c_str_avoid_literals!` to `str_to_cstr!`. (Benno Lossin &
  Alice Ryhl).
- Link to v10: https://lore.kernel.org/r/20250524-cstr-core-v10-0-6412a94d9d75@gmail.com

Changes in v10:
- Rebase on cbeaa41dfe26b72639141e87183cb23e00d4b0dd.
- Implement Alice's suggestion to use a proc macro to work around orphan
  rules otherwise preventing `core::ffi::CStr` to be directly printed
  with `{}`.
- Link to v9: https://lore.kernel.org/r/20250317-cstr-core-v9-0-51d6cc522f62@gmail.com

Changes in v9:
- Rebase on rust-next.
- Restore `impl Display for BStr` which exists upstream[1].
- Link: https://doc.rust-lang.org/nightly/std/bstr/struct.ByteStr.html#impl-Display-for-ByteStr [1]
- Link to v8: https://lore.kernel.org/r/20250203-cstr-core-v8-0-cb3f26e78686@gmail.com

Changes in v8:
- Move `{from,as}_char_ptr` back to `CStrExt`. This reduces the diff
  some.
- Restore `from_bytes_with_nul_unchecked_mut`, `to_cstring`.
- Link to v7: https://lore.kernel.org/r/20250202-cstr-core-v7-0-da1802520438@gmail.com

Changes in v7:
- Rebased on mainline.
- Restore functionality added in commit a321f3ad0a5d ("rust: str: add
  {make,to}_{upper,lower}case() to CString").
- Used `diff.algorithm patience` to improve diff readability.
- Link to v6: https://lore.kernel.org/r/20250202-cstr-core-v6-0-8469cd6d29fd@gmail.com

Changes in v6:
- Split the work into several commits for ease of review.
- Restore `{from,as}_char_ptr` to allow building on ARM (see commit
  message).
- Add `CStrExt` to `kernel::prelude`. (Alice Ryhl)
- Remove `CStrExt::from_bytes_with_nul_unchecked_mut` and restore
  `DerefMut for CString`. (Alice Ryhl)
- Rename and hide `kernel::c_str!` to encourage use of C-String
  literals.
- Drop implementation and invocation changes in kunit.rs. (Trevor Gross)
- Drop docs on `Display` impl. (Trevor Gross)
- Rewrite docs in the style of the standard library.
- Restore the `test_cstr_debug` unit tests to demonstrate that the
  implementation has changed.

Changes in v5:
- Keep the `test_cstr_display*` unit tests.

Changes in v4:
- Provide the `CStrExt` trait with `display()` method, which returns a
   `CStrDisplay` wrapper with `Display` implementation. This addresses
   the lack of `Display` implementation for `core::ffi::CStr`.
- Provide `from_bytes_with_nul_unchecked_mut()` method in `CStrExt`,
   which might be useful and is going to prevent manual, unsafe casts.
- Fix a typo (s/preffered/prefered/).

Changes in v3:
- Fix the commit message.
- Remove redundant braces in `use`, when only one item is imported.

Changes in v2:
- Do not remove `c_str` macro. While it's preferred to use C-string
   literals, there are two cases where `c_str` is helpful:
   - When working with macros, which already return a Rust string literal
     (e.g. `stringify!`).
   - When building macros, where we want to take a Rust string literal as an
     argument (for caller's convenience), but still use it as a C-string
     internally.
- Use Rust literals as arguments in macros (`new_mutex`, `new_condvar`,
   `new_mutex`). Use the `c_str` macro to convert these literals to C-string
   literals.
- Use `c_str` in kunit.rs for converting the output of `stringify!` to a
   `CStr`.
- Remove `DerefMut` implementation for `CString`.

---
Tamir Duberstein (4):
      rust: macros: reduce collections in `quote!` macro
      samples: rust: platform: remove trailing commas
      rust: support formatting of foreign types
      rust: replace `CStr` with `core::ffi::CStr`

 rust/ffi.rs                          |   2 +
 rust/kernel/device.rs                |   1 +
 rust/kernel/error.rs                 |   2 +
 rust/kernel/firmware.rs              |   9 +-
 rust/kernel/fmt.rs                   |  87 +++++++-
 rust/kernel/prelude.rs               |   7 +-
 rust/kernel/seq_file.rs              |   2 +-
 rust/kernel/str.rs                   | 395 ++++++++---------------------------
 rust/kernel/sync/condvar.rs          |   2 +-
 rust/kernel/sync/lock.rs             |   2 +-
 rust/kernel/sync/lock/global.rs      |   2 +-
 rust/macros/fmt.rs                   |  94 +++++++++
 rust/macros/lib.rs                   |  19 ++
 rust/macros/quote.rs                 | 111 +++++-----
 samples/rust/rust_driver_platform.rs |   4 +-
 15 files changed, 367 insertions(+), 372 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250201-cstr-core-d4b9b69120cf
prerequisite-message-id: 20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com
prerequisite-patch-id: 0ccc3545ff9bf22a67b79a944705cef2fb9c2bbf
prerequisite-patch-id: b1866166714606d5c11a4d7506abe4c2f86dac8d
prerequisite-patch-id: b575ae9ef33020b691c8c5a17bd1985676519e14
prerequisite-patch-id: 8fee5e2daf0749362331dad4fc63d907a01b14e9
prerequisite-patch-id: 366ef1f93fb40b1d039768f2041ff79995e7e228
prerequisite-patch-id: 1d350291f9292f910081856d8f7d5e4d9545cfd1
prerequisite-patch-id: 9a6a60bd2b209126de64c16a77a3a1d229dd898c
prerequisite-patch-id: 08ae5855768ec3b4c68272b86d2a0e0667c9aa47
prerequisite-patch-id: 801be981c2346617fa9412498930b68dc784693b
prerequisite-patch-id: f0dbf0a55a27fe8e199e242d1f79ea800d1ddb66
prerequisite-patch-id: c0b4abb4d44f7e63d002d0bfe5239296930c183e
prerequisite-message-id: 20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com
prerequisite-patch-id: 6711f2a2f25c12784057aa725a9482feef6bb6f0
prerequisite-patch-id: 3b5144133c0e239e0a258c9aa4da0df2dd464e66
prerequisite-patch-id: 589a352ba7f7c9aefefd84dfd3b6b20e290b0d14
prerequisite-patch-id: 2a4b0b9170e25637b9eba0e516863bdcdb4149a8
prerequisite-patch-id: 3d89601bba1fb01d190b0ba415b28ad9cbf1e209
prerequisite-patch-id: 10923aebf24011b727f60496c0f9e0ad57e0a967
prerequisite-patch-id: 9a7e8ba460358985147efd347658be31fbc78ba2
prerequisite-patch-id: f79b8755f3d75effc581d09eafe5725043516aad
prerequisite-patch-id: d598958c2d64dcb56a5cd64b088594be51b1d752

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


