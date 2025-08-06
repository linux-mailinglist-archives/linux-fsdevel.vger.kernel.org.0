Return-Path: <linux-fsdevel+bounces-56807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EEEB1BFA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AD66231F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 04:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCCC1E5B72;
	Wed,  6 Aug 2025 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="raC8khgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E652BA3F;
	Wed,  6 Aug 2025 04:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455734; cv=none; b=BypJWEURrgm/6RpiuZo3fOhNIijIaGj+IS15veVxBa0SPymUnKGB0PV79/XrQBgepKkWBBJiMEc9KcWfQrkzj1jP3zk+fjledlu6msFDT92f6v7U2Xgqb4gy7no417nCDflQo3Ku1mHL8trBWCgNZ7q/H2HwFumUyLQ99t+QOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455734; c=relaxed/simple;
	bh=stOywZDoIU0FaZ/HagCupK5dlv3tKXwhDvsLXMZLl1c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nj/Jg7l04Q42v/V6931/HiBTlniOyJXkNnSUVsoOPP5zwXvvxnIul3/rT0hJgLM6c6uAfLdisXMGLvicZqAcOufnW5s5BkoXsHvPxvxEJBoaSUxXZZjGLtMgX+zwWf6qEP8d99F5/FHvCKvkxJNJf9u/QbZAAh8j5CyvSW9MwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=raC8khgk; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxd9D39Bcz9tF7;
	Wed,  6 Aug 2025 06:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754455728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4gNXonq3IuDgcBCcXQEGzxyOr4rIqlPjiQqPdv91WTg=;
	b=raC8khgkTlQHbhuinFmhZbVfXQmzKX/L5T97sCacsTBlROFGPHUN+fxL2SN7ldUb6PAhPs
	9/iz+Dy1XZnyVThraRcj0s6WhKXzIOdlsqtHYBDLCwyt1OP01h+Hhwx7JcxJ0kxGkUMtg6
	fttknt5nzw1tcqKlAjrvOR0YGGkDwqhxFnBpLbhgIu/iHk/RCB6ADqoXqI/cr3Tq2A34Uc
	oNyyDyL7pYvLovJeKYLJuIAwUQrCVWh0rK5FSEe+/h0oJ8X6uQURpiTP5gVVhhX5hjP/kN
	4aARdnt7IhHGIwecvXKKYzIwadkbZco4yMiFwjiN0Q+SyjW6zMaG7FhbkobhXw==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 0/2] vfs: output mount_too_revealing() errors to fscontext
Date: Wed, 06 Aug 2025 14:48:28 +1000
Message-Id: <20250806-errorfc-mount-too-revealing-v1-0-536540f51560@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJzekmgC/x3MwQqDMAyA4VeRnA1kQu3cq4iHTlMXmI2kKgPx3
 S07fof/PyGzCWd4VScYH5JFU8GjrmD8hDQzylQMDTWOnuSQzdTiiIvuacNNFUvG4StpRjd1sfX
 0Dt4TlMNqHOX3v/fDdd2VGirWbQAAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=stOywZDoIU0FaZ/HagCupK5dlv3tKXwhDvsLXMZLl1c=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMurdyy8RI7hCz8r2etke0MqIVCn6KRPmLTj+X6bXvl
 rR6wJQZHaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiGlqMDM9yXv+9MdV046Eo
 Vg/NXt2T4vzFPyfm16g+PWOwWNlVJ5nhf8oswVNtHCv+RNyR1fp6dsK2N+57/b9GPVzZfNLv2YX
 rUiwA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

It makes little sense for fsmount() to output the warning message when
mount_too_revealing() is violated to kmsg. Instead, the warning should
be output (with a "VFS" prefix) to the fscontext log. In addition,
include the same log message for mount_too_revealing() when doing a
regular mount for consistency.

With the newest fsopen()-based mount(8) from util-linux, the error
messages now look like

  # mount -t proc proc /tmp
  mount: /tmp: fsmount() failed: VFS: Mount too revealing.
	 dmesg(1) may have more information after failed mount system call.

which could finally result in mount_too_revealing() errors being easier
for users to detect and understand.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Aleksa Sarai (2):
      fscontext: add custom-prefix log helpers
      vfs: output mount_too_revealing() errors to fscontext

 fs/namespace.c             |  6 ++++--
 include/linux/fs_context.h | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)
---
base-commit: 66639db858112bf6b0f76677f7517643d586e575
change-id: 20250805-errorfc-mount-too-revealing-5d9f670ba770

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


