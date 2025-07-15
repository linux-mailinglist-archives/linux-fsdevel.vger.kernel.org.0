Return-Path: <linux-fsdevel+bounces-54922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD5B053BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 09:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BB84A45D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834D273D88;
	Tue, 15 Jul 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDQG1zWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF726FDA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565907; cv=none; b=gsWXoZvOSUhOzrT6nztC7nWAMHB5jZiItCDhlJag1uMV42/ibsajrRnddYzsL2etKY5RgmDh6oIOj4hZ6iIV4iwhfr+fVUtF0JokRT29fslcaQ+4ftysV56VJ5sWH5cIDKuQjjGvmiThR2vTsrw51ZU74bBYHdE8a5XMdPhCu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565907; c=relaxed/simple;
	bh=5R5dZnbiyygZdlZtK7nNk0eY27z3EajEBJy5SPvfPCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qaOfbwKDcomgCHubwux872+eSbh+Fou/1kM59fORY9eCtSM2r0N7uuXxVY/anpQoDfVtn0c/yvG0KyiXqkwUZoHWGcgFfl2BEWrgTyaxWl170ripZZCYTl11kbVFsvMms9erzikSaADxx2FcQU56432oUD+LWfTPd2Qe839YQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDQG1zWM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-453817323afso32150125e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752565904; x=1753170704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NS9O2ujWL6LsDQQoap8xTVW/1qCTR4S7H1M7ty6BGnE=;
        b=UDQG1zWMkrXKL6sgMqq3YR/eIz6WPTlow6b4hyYPahzXaOB1qwMCwO1pfgssMh0c8A
         Q+1F52vBePz5yTCV3QlKJ97GWDLDnTQHjYKzCc0PgvCfG+c7C/ShnI16KkE5RidRwxrw
         YUnaZOoiY0/uBf4hghBSXHwHf/KSIkSCOE5zP28GQryoMsHZm1pcEEtmg8AA1747mQQd
         b/G+Mx0VJwM3LGV4Iiz6jzCX9Pe1pBLAqRS1hEijKzix9yBX9WSmbvz25nL8mhOXRgxv
         4blpcMH4HS11+mdHf+nhIX3v4PBzyANcHAPIi+9DIguOdpLZRYHBEwY4hSVMz9RmvGYt
         9iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752565904; x=1753170704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS9O2ujWL6LsDQQoap8xTVW/1qCTR4S7H1M7ty6BGnE=;
        b=dnPPM8EMujUcuE7/lNoejVItK1LwkdRkuAWlj/ThLB/cZPTe0ET9eLM3wnpBGcTS8f
         OBxao33GzcLlC3lWw2nAE6w0t7sGmmaPOvk1GTqWtRuGfz6Olho/iP1czUe7sWWjd6C7
         Xuru1ubSj7nTaL9u/V1hSJWktAvE0FxpcEffLz4xnTyTJzBeiqriD3At9E2mWborjtRx
         5snth28aB8+Bqdr3nM8lbIUUZlDHgsrH1aFpMLkC4bJOtWiyGH6yBil1hXEM5q11iCK8
         UKgj60vzSutXIfMgZYfsn0UpXWHaCFU7Eeq2cgaNIDAQnUXRvE/at9pDV0VHugDyisQ5
         ipIg==
X-Forwarded-Encrypted: i=1; AJvYcCUOP9cfhCWO2SQ+L0oNclpAojZGcQD4Pgunl6pO7YOU5+3g3rDsc7Q3rP19MkV2fDW1Q8tc0B1eZnzBgkDV@vger.kernel.org
X-Gm-Message-State: AOJu0YyafAaI/FEJtyY5909PY7NuchW2vCIfoihNS3FdH05p1oSNl1M8
	Zw5tz/WajvHAbxfOFHAQOjjJpsZF4xwX3sY7GVO1x1AI6hocyWd9FrzL7DN0ECAZKOagXXoSDEQ
	Lm+z6bZigC0wCV2+GFg==
X-Google-Smtp-Source: AGHT+IHo8SnWntfu2R42F6ufX2/J1nwq5gsZlwYTZG9xHFsa46eGg3Q6cheAw7jV7hH6yBZ51dQ1IlJEMs13sSo=
X-Received: from wmth21.prod.google.com ([2002:a05:600c:8b75:b0:455:76a8:b3a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b25:b0:456:18cf:66b5 with SMTP id 5b1f17b1804b1-45618cf6c49mr59096405e9.22.1752565904488;
 Tue, 15 Jul 2025 00:51:44 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:51:40 +0000
In-Reply-To: <CAH5fLgh=kGj2shvChkPD4LHyHrmJ7ZCeWVpM-ZE3dG5NRMLWXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAH5fLgh=kGj2shvChkPD4LHyHrmJ7ZCeWVpM-ZE3dG5NRMLWXA@mail.gmail.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=aliceryhl@google.com;
 h=from:subject; bh=5R5dZnbiyygZdlZtK7nNk0eY27z3EajEBJy5SPvfPCk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBodgglRMZ5OWcL8gY6qg+0UHkzCyoOQUs6U7R4j
 fRuONq3tm2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHYIJQAKCRAEWL7uWMY5
 RppTD/0YAVKJ3KoY8JTW/pD7ajYZdrPoNyFfdO1zodYb1zB4hDtbhn5Js3qQxnK1N8BEHA0zZIj
 pYekEAmeNNl4Snzl1lMbcP2PC3uZcS/6hFvndiPyXDrR57b9AvptAmYaHXF/BAQiPo8Ix483UzW
 cpdB/6zuY3++Tpxj74kQL8FT1LBRGKCg3aoCSOqruUgrPIbH4AWzYAQn7+l1tQUnNnPS5if+1rO
 3DLDJnUtHBZ2Sc4pwfYWg9M4GbdMivekW0f0aR31ExnH0DQAO2gYAGxZNoz//jUL7fSCH+dbC5u
 Oajzxse7F0TAL9gR5P35Y6MudxWkqUwHElemAT5X0VFlI0TJTQ6q7QUSn264ZYKbjzJZe2b2H1a
 9TYbFKHqrp2zdlgzpp+59D4N8zoUN7NII1v2EEqMVUCM7E6ir157vBQFosbbXfCAZayJcERfyGC
 sx7UbRbUK8oBrnlwdjG8Kn5XhJCRL0LQVxUOso6+0ieqOjVGSKDJxOs8q/MGHyJk3KZaUqt+vfe
 O3UsHKrs7GsxaVllX/nsrLBCoAa9AQkAI4AYTSBD1RkYpZd/lcAWAj8uWyYYdHL3Z8RwFEo4xfR
 oF58hV3rjMvJxjRYalcX8364rxQ6nEo3p2JrOJiXSkkZhHzZCo5P3nXCuUDF6Dxavze/wBq253I 9JcxoDfNWEhgkmQ==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715075140.3174832-1-aliceryhl@google.com>
Subject: [PATCH v2] vfs: add Rust files to MAINTAINERS
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
Christian, please use this version if you agree that `struct poll_table`
also goes under this entry.

 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3f7fbd0d67a..3833ac2b58d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9234,15 +9234,19 @@ FILESYSTEMS (VFS and infrastructure)
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
+F:	rust/kernel/sync/poll.rs
 F:	Documentation/driver-api/early-userspace/buffer-format.rst
 F:	init/do_mounts*
 F:	init/*initramfs*
-- 
2.50.0.727.gbf7dc18ff4-goog


