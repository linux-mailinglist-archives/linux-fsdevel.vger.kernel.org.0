Return-Path: <linux-fsdevel+bounces-54836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98419B03EF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDB01898533
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 12:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42422472AB;
	Mon, 14 Jul 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOYnfRSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7227735
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497217; cv=none; b=pw0C9hQsIojD9+SFH1mvzyI1ZcJs2VTmFHMjdgJCZ8wsAQhNTN9Bz+Cv1aMFj/CCbcFYlRRRDjbZu/x2mqohckYEM7PJBWK6TrczwlUd9uIS0eH8azsxZ377CU41Fi7YQPhmXZzL3/Cwg0fENLI9oJf4LQmrIYk9f8X5Vko/QvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497217; c=relaxed/simple;
	bh=NwaR9/Je7AdkfWw/1b2DE6uNLUshXOFDwHugnY+q+RQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TCj6ddwT88nReh227lKufjbwydV4a/lHiJ+0D9+5I/YtVNmqDFod247megjMlNtNz5RX+Uu+z4u+z3ijlyfkxU+OhxoB0GnV2UiWUWQCS9uFVd2ATj/Cng+CZ1hertVTnqa/PNe2XOFbJQe9JFnbUUxs9MaZATJasas3K5dCJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOYnfRSt; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so2516915f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752497214; x=1753102014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ccg/VW3jk6vHTqe8idOqc1Z4CEUc8mxrSFOjqsDu7cI=;
        b=MOYnfRStU3Web5Ac2YvwK02vL2tkFYUmdqRhc5L2OBErHi4lCYKgVS7pyF5WgbnPas
         GP4JV1J1yQ0MVw2sPnHVJNsr8pd263wgYKAmNxKnYFjfo0aXxrYW7wt2vOFIBXffyJvH
         jd4b0e3kqK0R2CXMPKFzLTRrI8oWvNGGwOXi2C7TWS4vGsHU+wfjOSAeuNUy/Yhwgckk
         pkQGoysdmnFyhswWtv24QGmRauCJu0l2AJ/fofaweRoRQAHzrgu+qismfAhJip5CBRuS
         7zBM8NvBOlj+C4JCPNK+kG7d6bAgTImJMAAz/+Po4QJma8gC6KATVn15XvxLyphlSa44
         yPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752497214; x=1753102014;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccg/VW3jk6vHTqe8idOqc1Z4CEUc8mxrSFOjqsDu7cI=;
        b=Q2x0kJ/rRQ2hLLhuxadkKefw60q2lucQbyNXv44fcza3j9HTSmslLhlO23CuZPNTaM
         hxvWS2/u9AEDUTrAooh7GNK2wzsFXCSDOne4yxDFrG9jKo4x76B9DDrjSh+pqkVXoMc0
         LbPJDK8iMxHD2PAVwyQZf5FmIJ48CilWf1azfJAf6R5akBfl9bTC7bwZjLP+qace9aJS
         VrYpf1MVn8vHCrWcxgDyh6LaSSvknGsxsX8nj7flMFP8MnAC6eMOD6iREO+hf544K1RS
         ccqtf8w7Q9UPy+kVlYFmy5HHFDczodkIWXhn3aY+9rR/u5DaioUr25B2ArCMzvCUeftC
         IPpg==
X-Forwarded-Encrypted: i=1; AJvYcCWiEtalnukPqraks2V1IVhQw30hxcCOc6/lTDc9w0iDXkZ3aoPRBznTUxTDv8pDLahSQCVGxsiEEHHXa3zn@vger.kernel.org
X-Gm-Message-State: AOJu0YzHveN5Eii4cUc5VWvr5QlmWS2OWlzHHtoq3nv5WQptUHqK5plK
	KJlRv31TGb0JZprMZsGpCxr155hWjEVtZQ4LGzK/+sx7WvVUZfJBBmoFpQSvTBVRqUt+BpPS9RO
	oghbaZ/YpkHufIiO0Lg==
X-Google-Smtp-Source: AGHT+IEpsrPLmARnWG0wtS9HbqgJ/QuMlwRCzIc+Pa2sIBjddgiU/CUibBgEAh8mKJeMd3XXQbDdyEVvZ7B5DMs=
X-Received: from wmbes26.prod.google.com ([2002:a05:600c:811a:b0:456:217f:2625])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2dc3:b0:3a4:f6ed:767a with SMTP id ffacd0b85a97d-3b5f18d989fmr11340308f8f.38.1752497214090;
 Mon, 14 Jul 2025 05:46:54 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:46:36 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=aliceryhl@google.com;
 h=from:subject; bh=NwaR9/Je7AdkfWw/1b2DE6uNLUshXOFDwHugnY+q+RQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBodPrFMtDYlaKtIAaCblIupqTBYvaLYd97VcZJ6
 79BZGvcyA6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHT6xQAKCRAEWL7uWMY5
 RnfRD/4uT8Etu9wSyoy0yGLIXdzEUPphX1k2F5TDm3V0WmSBVEE97bKYg1pdD/ZnSn+kFFmfz8w
 3OidOftxqy12+pgS7M7m9ikQkjLaGvKVY/sAecJc5CBN+j9eyRy4y0O0XMZZirhPqMyDVc4m+fr
 Tul3c9KCkL0g9Mc6MQfdYeLxJdMGwpuCwpq+/2Rk8DXZIU18nbG0k8QTogOxCfWfOM7srhlTG0O
 9B+WFJMqIkZAgxiYeA3/25yeYHvkb+Hof50r1PyJne3B6/kA6ciTtJVHiMCkxlkUoYOYHbGhyL5
 8IuAoHTxVTW+FcipkSJVJLQfyKd0A9xtouhZZETF/+7UYqlU1G6j5CSDLUEE0dOkQJS4//Vj0uk
 D9/iZhYkMqvqD1jIVi8UOoj+O1J+hz69xAQkf0h/weqc1de7RK039xDFXuxa3AMYlBLvNrc9J1E
 W9jZUUu/uC1k0EHXqQZyAICQY5OV713s1ZSVC7m6YEGXr3aIUai8XKiyJTbVB8jhDY9SwJEoPL9
 8SADujmmA01K+YjSxonhNt4xU+ovAxZB8DwL5qtPoieZQmrVCQixnHE4fDqtZ+YT6lzncPlddhm
 elPNvlOWQKTHFvopT8R7W7nU5tDNcvInC3d8be07oAam4chEL1dRY8PFxMPQqS0LEmv7a6PPn8j eMNj3BoHFI02o3A==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714124637.1905722-1-aliceryhl@google.com>
Subject: [PATCH 1/2] vfs: add Rust files to MAINTAINERS
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

These files are maintained by the VFS subsystem, thus add them to the
relevant MAINTAINERS entry to ensure that the maintainers are ccd on
relevant changes.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3f7fbd0d67a..0f4e99716183 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9234,15 +9234,18 @@ FILESYSTEMS (VFS and infrastructure)
 FILESYSTEMS (VFS and infrastructure)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
 M:	Christian Brauner <brauner@kernel.org>
 R:	Jan Kara <jack@suse.cz>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
 F:	fs/*
 F:	include/linux/fs.h
 F:	include/linux/fs_types.h
 F:	include/uapi/linux/fs.h
 F:	include/uapi/linux/openat2.h
+F:	rust/kernel/fs.rs
+F:	rust/kernel/fs/
+F:	rust/kernel/seq_file.rs
 F:	Documentation/driver-api/early-userspace/buffer-format.rst
 F:	init/do_mounts*
 F:	init/*initramfs*
-- 
2.50.0.727.gbf7dc18ff4-goog


