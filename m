Return-Path: <linux-fsdevel+bounces-57262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF0B200C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD421892A7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8992D9EF9;
	Mon, 11 Aug 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjrx988p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OCJVa6Gj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897651EE019;
	Mon, 11 Aug 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898609; cv=none; b=fkenH2As0hSJ2f3EwAIhXUqBluQPQDCCVTafX5B4NG4IwkIPXLuDrrOERH4OEj5zDSvHMPhx9RrHTtry+bXIaTmK/PeI+wjk/zPdlRkcFfDZkEozm4edgUC9vA7ccyCDSdiJtUfjw9XzMygS25GGLQiKtdJxuALonHRlcaS9k8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898609; c=relaxed/simple;
	bh=kE11z5r1ndYK8PrNv2TZNcy9WFFJTs7MUXKy+LrT1VM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=M2KHdr147rus3uI0kNu3Dpw1JkXT8QFkoxe25cDNm2HzQIwr1fzti/LQYY/P544DLVbterh+228lL7DXveXwOo0Ci2IJfFUukBuFERl9TDEKSGzNd3ESjMzAwssY4Q+WcZbr6HEWUppTb6wapPykQYOFJIzKbM5wLkM0S9Qq+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjrx988p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OCJVa6Gj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754898605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a3YgmVdpOVi+2VbNpwvqRfjXywH6CwTQ7bZnwNobs6g=;
	b=bjrx988pHbdnv/C2pmUagoE4o8yddHkjQ4ZPH9GexSVDcdq9dD+VF19e7cku9xUiy6PLlU
	o46Y5Llf0YePB/xJA5QkadUsh/UGgnaCzdeO3J2RjtMEu6hyk2R9TAkdjC2jJQhY0YMRZo
	QP7jxcEtAm3WlIGgy/5D2MVy7QVc7cZ1j6GWnZV00gk/oikmonCKyXzB531SMQSTsYo8qE
	L7DZpWDzjSaX5taSA1nTYn5S4ps54PJDxKjM/8Nzb244N7MgL/M4uEPulQixRs0N7gCAPw
	+ao/lhXearoBSD9YbBYEIT3LbRhqOuQLq4QwOKznv8BlXBvTyMxFjL9aZ2QJLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754898605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a3YgmVdpOVi+2VbNpwvqRfjXywH6CwTQ7bZnwNobs6g=;
	b=OCJVa6GjV8MHXwmsT9F7SkpzV63W1rGmBMe0CLgBlJjG9W7CEiptZIuQPYOeWoZx80UNhN
	vuFLx12QyUb7peAw==
To: Christian Brauner <brauner@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Lennart Poettering <lennart@poettering.net>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/coredump: Remove the read() that fails the test
Date: Mon, 11 Aug 2025 09:49:57 +0200
Message-Id: <20250811074957.4079616-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Resolve a conflict between
  commit 6a68d28066b6 ("selftests/coredump: Fix "socket_detect_userspace_cl=
ient" test failure")
and
  commit 994dc26302ed ("selftests/coredump: fix build")

The first commit adds a read() to wait for write() from another thread to
finish. But the second commit removes the write().

Now that the two commits are in the same tree, the read() now gets EOF and
the test fails.

Remove this read() so that the test passes.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/testing/selftests/coredump/stackdump_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/test=
ing/selftests/coredump/stackdump_test.c
index 5a5a7a5f7e1d..a4ac80bb1003 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -446,9 +446,6 @@ TEST_F(coredump, socket_detect_userspace_client)
 		if (info.coredump_mask & PIDFD_COREDUMPED)
 			goto out;
=20
-		if (read(fd_coredump, &c, 1) < 1)
-			goto out;
-
 		exit_code =3D EXIT_SUCCESS;
 out:
 		if (fd_peer_pidfd >=3D 0)
--=20
2.39.5


