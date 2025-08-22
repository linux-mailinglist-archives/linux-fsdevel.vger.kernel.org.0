Return-Path: <linux-fsdevel+bounces-58746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0EB31203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F1F56805D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAFE2EC55A;
	Fri, 22 Aug 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCVMJT3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A18287276
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852171; cv=none; b=nokWEi5D088+i38lLby5GHz6DVRa4bvxbpiHtYZ0c63kGWdtehi2Ck+OiEqks16f0Ke5uzXrVDKKGQ1vIu7t56HbAXk7F3F7ORU5uxM/i3hiULtPRmPSIexcTGRUOYfHoX1dRiI9g/HPytYXpVlGSpQSg2H5NKiWxk4B3cp+VqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852171; c=relaxed/simple;
	bh=P8lEjSUsH8QKYWIsvl6nW02/qSfsT+NKwD9w8/tPzfc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q14VFH/+QgmtpPpQ9X3GGRkBhA3LTw7tp/MNnYEYcuJlmNkfvQBYnip9G09oyRBaWmpbRVJiv0OIzIidr2cqETryvVurKyfbhb4b9KYtba5g6cgG/tLAvO8v8250vHx90SJqku/O3cxo8CpvqY1Q6Au8ss8yAgzzK4qvpucXdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCVMJT3N; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b9e4146902so774206f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755852167; x=1756456967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X6mLoGvz5QfzWBhRmSqYhb91n+mvi4YwgTmTcFMvHXo=;
        b=dCVMJT3N1dNqUQaqAyaAh4cc10TzFeTZk/e2PFJ8UPmuA/AqFZL2AXFGAy/JnY+gJM
         n91Pfy+jiNxuK5z/mW/CGym5In0+85MzgnWOAIkHx+FPh1LF41QCjiUa4P6LNpIOdcY8
         4l7zX/l4y+vr6Gvya2IFKqrT2G6cvlxydzdPAAhT6hu3CZD29+SRR0SYNqRToP/tk/q4
         eD5hO7vdlGbJCbPbysI5aT0WYR9vWhMfZYXdZmHwbD8bo44OkLUVvCXe0tK9a+PDm/MD
         DKz6HupM0y39fSYWm1q1RuI6rldE1KIpKgEXewhzuUf/qC2a9VsLmpqv6rx2afjZSMeh
         T18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852167; x=1756456967;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6mLoGvz5QfzWBhRmSqYhb91n+mvi4YwgTmTcFMvHXo=;
        b=Q8ZQvXczMggwL0nTueRpqm8mrrur38+M8An5gG06CNY3KQAgz+vWteZXAIxfjme1JU
         RwTlmZpH/kO/Ah+lBM2ehzvTD8XxwzGsMNntORJoCWwj1La1ctLAvusy4TYRht//hEhJ
         HmRXdiHLf7yhu2SqopW+f3mJI8FKJF4w37xyZdvR5x1PRfoWMzsQx3Nn5bsfMMCwvWJb
         0AHca7SW7NpBfTtZ0N1o20lXO50V/g7DT6GPZ4AxH1rdpNXh2/PPd/m9Bne2TmnwmnRr
         AyZLOkUHSk1eGBvFfvbOINYBE4IAYKgyeH6O6+LZmTIrTxlq4PjKc2W8W8Br3SjBtzUV
         zq1g==
X-Forwarded-Encrypted: i=1; AJvYcCXNakClTP05sF9GDl+RShMB36LVkTs2nRN8c9uLpW6ODcGeIx4TN4cTcN2oR+2PO3d9Tjhri7WWv4kkEkbP@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0SsqSTjxo3pGODqSlEACIyOLdK4aGZOfSOHE545LrfQHKjWu
	jU4vYTh0T5NyAr8xAUBoW3qWWmVNMK6gutlJUmt0ggDcvrKZC027D4kT8yST7/lSNXDoIAoH5W4
	fV+PKsmACvY+HXthDqQ==
X-Google-Smtp-Source: AGHT+IG2MVK6IFNgGPhqjx6K1gtb1tj5Bpp0bHY0Ebu75ec1bz0Rc5e1CB45/ZkAluF7rZv7IAdkUdDkmwWQE34=
X-Received: from wrml11.prod.google.com ([2002:adf:e58b:0:b0:3c0:65f3:525e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2085:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3c5dcdfb740mr1300665f8f.52.1755852167021;
 Fri, 22 Aug 2025 01:42:47 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:42:31 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHctqGgC/23QwW4CIRAG4FfZcC6GGdhd8NT3MD0gDitJFQsra
 WN89456cBt7/GG+//BfRKWSqIp1dxGFWqopHzn0b50Ie3+cSKYdZ4EKe6UBZMpNppmKDM4aT16
 NO7CCz0+FYvq+V20+OO9TnXP5uTc3uL3+U9JAKhmH4EAb8hbN+5Tz9EmrkA/i1tLwKUdlFhJZ0
 uC8HwNEo+hF6oVEXEjNUlMMLmBA6/SLNE9pQS+kYRlMBKdxq3qKf+T1MUKhrzPPOD+WEFtfSfL /Ic3rrg0rGGUJwNfXXy8y1aR8AQAA
X-Change-Id: 20250311-iov-iter-c984aea07d18
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2737; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=P8lEjSUsH8QKYWIsvl6nW02/qSfsT+NKwD9w8/tPzfc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqC2APu5gKuYwVpcN5S1631tfhGnyMdQYL4EK7
 xhxysljiFWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKgtgAAKCRAEWL7uWMY5
 RrhPD/40MWfQD+mmamwG+cKjMvljxMtFQzgUnhAT1LDJT0RD8Ng7Dy1vn+Gtujze1VH3njVLN2g
 J0cZ0KHXixSW7xf/cpu/U6ddL6nXzJCu3NjsecXCel2qd2lulzOTIPcPnGSyWyvcaUYG7dkLfve
 hbVzPJvV6vWLWGdRKYV1rySJJoz9UUZOw1EhE/EVuzSTmsWECyBsF+e2mk7c+8Y5+F246sPwUJk
 OaGDRZPaSx+BBJLVJbZsmyJmxJU9oFCdUONEMGNLBsfmfao4g1ECk4MP5KJt9Qmd47Q+aDLb+aF
 pfCw0MH/xYSo5UQ7CYQvUD4XMqrmxSDAuZJXiGftHwMWBHQ+9uTh/yks5gBqcudqAa3F9DwEL7g
 F6QJpAfwQlXBtO5qLxZwxD0t14nW44Iuv3jQjuxFniPPXMCFKEanvZuX0OPVRzTQrOC1XDY3hIh
 B7FBsrlo7bZ26j78xQ+iZT0Z9IJRMdU2Y4zOb/Z4uU0CJsydT0WLJST3dVcU8moOFSboLBrg5gz
 7msbUU7uDt+heMHtFcBEp58HgzMTiW4YydCsM4YGutt5qqu/AJhulnjFpf6NSSJuhYfW5rlYgza
 PrRm5cSb4lBC5dJ9iCBrwpk7rQJhO37HMtgwYA60v8rQ89gEmXal+WDGJk/IZYoXlqCpjNiN/Ne UkIFukF15Sihsow==
X-Mailer: b4 0.14.2
Message-ID: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
Subject: [PATCH v5 0/5] Rust support for `struct iov_iter`
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

This series adds support for the `struct iov_iter` type. This type
represents an IO buffer for reading or writing, and can be configured
for either direction of communication.

In Rust, we define separate types for reading and writing. This will
ensure that you cannot mix them up and e.g. call copy_from_iter in a
read_iter syscall.

To use the new abstractions, miscdevices are given new methods read_iter
and write_iter that can be used to implement the read/write syscalls on
a miscdevice. The miscdevice sample is updated to provide read/write
operations.

Intended for Greg's miscdevice tree.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v5:
- Reword "struct invariants" to "type invariants"
- Reword inc_len safety comment.
- Split Kiocb into separate patch.
- Link to v4: https://lore.kernel.org/r/20250813-iov-iter-v4-0-c4f1932b05ef@google.com

Changes in v4:
- Rebase on v6.17-rc1. No longer any dependencies.
- Adjust wording of `revert` safety comment.
- Adjust "deinitialize" wording to "write uninitialized".
- Adjust several comments' wording in `rust/kernel/fs/kiocb.rs`.
- Link to v3: https://lore.kernel.org/r/20250722-iov-iter-v3-0-3efc9c2c2893@google.com

Changes in v3:
- Rebase on rust-next.
- Use ptr::from_mut to silence warning.
- Move Kiocb to rust::fs.
- Rename Kiocb::device() to Kiocb::file() as it's no longer miscdevice
  specific.
- Significant rewording of docs and safety comments, especially patch 1
  and 2.
- Link to v2: https://lore.kernel.org/r/20250704-iov-iter-v2-0-e69aa7c1f40e@google.com

Changes in v2:
- Remove Send/Sync/Copy impls.
- Reword docs significantly.
- Rename Kiocb::private_data() to Kiocb::device().
- Rebase on v6.16-rc2.
- Link to v1: https://lore.kernel.org/r/20250311-iov-iter-v1-0-f6c9134ea824@google.com

---
Alice Ryhl (4):
      rust: iov: add iov_iter abstractions for ITER_SOURCE
      rust: iov: add iov_iter abstractions for ITER_DEST
      rust: fs: add Kiocb struct
      rust: miscdevice: Provide additional abstractions for iov_iter and kiocb structures

Lee Jones (1):
      samples: rust_misc_device: Expand the sample to support read()ing from userspace

 rust/kernel/fs.rs                |   3 +
 rust/kernel/fs/kiocb.rs          |  68 +++++++++
 rust/kernel/iov.rs               | 314 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/miscdevice.rs        |  63 +++++++-
 samples/rust/rust_misc_device.rs |  36 ++++-
 6 files changed, 482 insertions(+), 3 deletions(-)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250311-iov-iter-c984aea07d18

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


