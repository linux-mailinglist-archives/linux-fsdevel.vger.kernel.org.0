Return-Path: <linux-fsdevel+bounces-51476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CFAD71E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33402176904
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442862586C8;
	Thu, 12 Jun 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuWGbaBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440225B2F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734761; cv=none; b=DRiVDFeIvUEFBL1wiziSO9cxESPocnHH1nEEuqHDTdZ4jTN4Eax3/PZ/EmGGww5217ukDzEc+kMUrQEIvROTcxb0+hRgiGx9bSetItkk+ZabOSU9FIot06a6CR/IRV38BHtCQBdTTq7+gYnijfEyeBjBSwn6esL/AJKbxW6hD4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734761; c=relaxed/simple;
	bh=dfxsKTMoClrDCdsbKeQNA+LpoyAQKzKn/YqtSN1shjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmoUtXw8NZUn5BCpQr6w5/uQIwm2ukODitpU3HNrwH3P9VjNxkLsMUanhZo0apRscAbpe6BMQgPJnY+RCFaLShR4D0B7FryU3virympJ3/bojsdKYD+7Kd8LcEUTB5BspxDyIaiqkfBECvgxtzvUK+6GLahadRAWI50bjx/lyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuWGbaBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AD4C4CEEA;
	Thu, 12 Jun 2025 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734761;
	bh=dfxsKTMoClrDCdsbKeQNA+LpoyAQKzKn/YqtSN1shjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PuWGbaBiXjYieKfFsHNLTMcn2504V2i8qkgA3R8+UcWolc8D/2Kj+kTxzRmFF+qJh
	 HSJ2YBmwcH36gmpGkcrEF+czaG4AZu/1d3ciXQSeVbqWCIfIip65GWm267Zhc7ZSK8
	 sCxx1RZZ/v0op0dGAbeyv8e269sU3q7Z2rvcnjJeXznfg33UNwm3hqRVoW/aBkJz2B
	 NeGNZGF5Pnd3RPZlcsdxj90Jv2lNzK0Y1sDleA1HJE+5EmKm+k5XmWFwiPZOlHbk9R
	 vs8pElNjrPSiG4bvKqMOOdKHHwRj8F73tSotTIaU2oMcOktpXRHnBelTExlbNyMrAn
	 vUne7qt6ztKgw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:29 +0200
Subject: [PATCH 15/24] coredump: use a single helper for the socket
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-15-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dfxsKTMoClrDCdsbKeQNA+LpoyAQKzKn/YqtSN1shjw=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGhK1UegZ+Gqj5bS3A2Q3/9DDeRIzZFiqPL3PClmN10dzfrp2
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmhK1UcACgkQkcYbwGV43KLB5AD9E+pd
 86okEC2VuEoGjG7aMFEBt0xnDutwAWHhE75jF70BAOAgBYvEjgQdOryovGlQkd20i3laoiTuucv
 dr0EUqTgE
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't split it into multiple functions. Just use a single one like we do
for coredump_file() and coredump_pipe() now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index cddc1f7bfcab..521c6c4ded9d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -855,17 +855,18 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 	cn->mask = ack.mask;
 	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 }
-#else
-static bool coredump_sock_connect(struct core_name *cn,
-				  struct coredump_params *cprm)
+
+static bool coredump_socket(struct core_name *cn, struct coredump_params *cprm)
 {
-	coredump_report_failure("Core dump socket support %s disabled", cn->corename);
-	return false;
+	if (!coredump_sock_connect(cn, cprm))
+		return false;
+
+	return coredump_sock_request(cn, cprm);
 }
-static bool coredump_sock_request(struct core_name *cn,
-				  struct coredump_params *cprm) { return false; }
+#else
 static inline void coredump_sock_wait(struct file *file) { }
 static inline void coredump_sock_shutdown(struct file *file) { }
+static inline bool coredump_socket(struct core_name *cn, struct coredump_params *cprm) { return false; }
 #endif
 
 /* cprm->mm_flags contains a stable snapshot of dumpability flags. */
@@ -1104,10 +1105,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	case COREDUMP_SOCK_REQ:
 		fallthrough;
 	case COREDUMP_SOCK:
-		if (!coredump_sock_connect(&cn, &cprm))
-			goto close_fail;
-
-		if (!coredump_sock_request(&cn, &cprm))
+		if (!coredump_socket(&cn, &cprm))
 			goto close_fail;
 		break;
 	default:

-- 
2.47.2


