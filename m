Return-Path: <linux-fsdevel+bounces-46348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BECA87C7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174623B180A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051C26A1CA;
	Mon, 14 Apr 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKTDHglf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC41269836;
	Mon, 14 Apr 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624443; cv=none; b=SAOqVRGv3KWdj+3iyCsXp2glesX4Cyb/SLbFOM0He1tGhQ/uFnBJjo+igzLOyt+NfQv8CeM63jhTsuLth1YCgJiemVagtqJKV9d6RRKsi/JGvvdxFd30syScfCd3q+QfeOCuOGVJKZ4HP4ByFEYuYBgpTUKVvKlFln1oRCfiJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624443; c=relaxed/simple;
	bh=Yx0s+29+fWiKG5e4fyOCBvG2yH0V+I1OL3c1XfGljr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9lyL7SdTaVgTfscAeFsip7YcbTyCHwt8FG3SvQN+6oupWFTTCdqpLqlq6723mhtU8dPWWI+6PtUH3XtIW/8Uz6yLdEB7rmkKOKQpGXgdGi6NJMXaH/Iow73YsyRWT+dJg0rjPhT+TcvSVXBjeoOWSWpRapg72UNum9St8INVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKTDHglf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638DAC4CEE2;
	Mon, 14 Apr 2025 09:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744624442;
	bh=Yx0s+29+fWiKG5e4fyOCBvG2yH0V+I1OL3c1XfGljr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RKTDHglfBRaRk7Z1UhTKUaSYsds+HamSNpTvpeIkZ6BQEo2Xbk5B94ov3jXtVtGBK
	 umErYL1uABCcLXxmZXcw0TcnpYgP5ikIp81TucCnstpanuO906Sw1RY5OoJNmBe4GR
	 bD2I9WFBHU3V6oWwZfo8O9l61BjFiLewP1J9vHdLbTAMCUIO+VRl25gJHRHpkq1XSg
	 kLBVYOUPvWcIyPSv0QOBa7SsWYEfiAIC4L4yW+UYKuuw7oUwrNz/anCALT4tnwIAQL
	 ccnA6WFuQsiVDAfqcDVxLCLgIQ99XwNuWbYnsDFGzMBlE3grqUl4hSYiPTI6JeX8DJ
	 ptzCXHBQTddDA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Apr 2025 11:53:37 +0200
Subject: [PATCH 2/3] coredump: fix error handling for replace_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-work-coredump-v1-2-6caebc807ff4@kernel.org>
References: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
In-Reply-To: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Yx0s+29+fWiKG5e4fyOCBvG2yH0V+I1OL3c1XfGljr8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/uW08eVr2OrPvHOuu/y7Y92Nf7u/HQXrMbN1yNiHan
 OXTNfUvdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEVY3hN9vU3r+h9bts9rPb
 y/G1rS06ssw/6oOWgVne3sadrUIKpxgZtj4IivTP4zs1mSmo5MZxhfNd4X9KchL+ba0L4ZOvlP/
 HBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The replace_fd() helper returns the file descriptor number on success
and a negative error code on failure. The current error handling in
umh_pipe_setup() only works because the file descriptor that is replaced
is zero but that's pretty volatile. Explicitly check for a negative
error code.

Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index c33c177a701b..2ed5e6956a09 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -507,7 +507,9 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct file *files[2];
 	struct coredump_params *cp = (struct coredump_params *)info->data;
-	int err = create_pipe_files(files, 0);
+	int err;
+
+	err = create_pipe_files(files, 0);
 	if (err)
 		return err;
 
@@ -515,6 +517,9 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 
 	err = replace_fd(0, files[0], 0);
 	fput(files[0]);
+	if (err < 0)
+		return err;
+
 	/* and disallow core files too */
 	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
 

-- 
2.47.2


