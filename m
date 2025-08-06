Return-Path: <linux-fsdevel+bounces-56820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3AB1C04B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C45C18A229F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F6218ABD;
	Wed,  6 Aug 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="d6nyFjaN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6078206F23;
	Wed,  6 Aug 2025 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460456; cv=none; b=enlnE6572VGgoP26qDdnn9MM48dbxKnnvTsthHlOjxPlWuafbPlJ8293KHiPe62qRH/CDKghN1ZKpiOVv24eisKH4YbB8KJQZcWYcAR4NpSAxfKsnT7kcSVmqSN/qMuSosjnFLYzgdreHr0DdwsWiM4LSgh86+xrHIZDdtVcU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460456; c=relaxed/simple;
	bh=Ye39SgM+Etl8XRmkHnnUx23tWQlJ53yx1MHZm4Nu7EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4MwbGZ1GggTo0BYD+Wj2qDj7OU1s018fDXJe167cXWqziW9pdlrdEsMUCGoK8WxG2pqJv6PAjioRMrLKELQ4AlljlKttdtvCtEBAdCE993pf8F5SnfKD4jiQ9a4yRazsxyYOgVDCggHX8Vn3EsBmVYLnreZ4gLgEE5ctVezgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=d6nyFjaN; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bxfvw6fHPz9tLZ;
	Wed,  6 Aug 2025 08:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754460445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvjO1yXplYoS1k6lhx55wXs3NDrmm2HWfvZNqZWFq4s=;
	b=d6nyFjaNUaChikrH0suD1BoCbuUJMFnx+GFSOkZsOjxZKvHX8j0IvtXg8KbpKn5Qk1AYfQ
	LV97FsBEOhSjJrFCPB7NGoBhyME6wS6GVYXwlOwzPClPa8n7owq/eC6rkGmSPsNrXrlZ/B
	noBvX7L7GbdxO5A/Priyb2mWuZ8gNii6AyGKEG5CHmJ5obR3m33N7VTVPZcYPbrt4SMvRx
	kRvqB7lgDZTHrLZ7VBbtC5ePF3Jg+3999P4BRR5EcTXr9mtQxWpymgevAzRhb+DVexIXlp
	Mqzv9wIeatYWOcdaKE0uhgyHPml8tmTcjtKFOiCIHzuqTpjWGRBCfomBwCvn5w==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 06 Aug 2025 16:07:06 +1000
Subject: [PATCH v2 2/2] vfs: output mount_too_revealing() errors to
 fscontext
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-errorfc-mount-too-revealing-v2-2-534b9b4d45bb@cyphar.com>
References: <20250806-errorfc-mount-too-revealing-v2-0-534b9b4d45bb@cyphar.com>
In-Reply-To: <20250806-errorfc-mount-too-revealing-v2-0-534b9b4d45bb@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Ye39SgM+Etl8XRmkHnnUx23tWQlJ53yx1MHZm4Nu7EE=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRM+shvsOc0v/rih8LTqlIP9V9Xt/ntUFQw44n2kZWHm
 janqb/N7ChlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQAT+aXI8D/D+eTJf52CyvOc
 11y/f1bNqcSDg+WYZZ3EgoAIpg1v0h0Z/vv4J8+ddHLaP4767nu5tX+SJpzRcFJz5//TXWguVyH
 ZwAIA
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
 fs/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 55f28cebbe7d..1e1c2c257e2e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3820,8 +3820,10 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	int error;
 
 	error = security_sb_kern_mount(sb);
-	if (!error && mount_too_revealing(sb, &mnt_flags))
+	if (!error && mount_too_revealing(sb, &mnt_flags)) {
+		errorfcp(fc, "VFS", "Mount too revealing");
 		error = -EPERM;
+	}
 
 	if (unlikely(error)) {
 		fc_drop_locked(fc);
@@ -4547,7 +4549,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 
 	ret = -EPERM;
 	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
-		pr_warn("VFS: Mount too revealing\n");
+		errorfcp(fc, "VFS", "Mount too revealing");
 		goto err_unlock;
 	}
 

-- 
2.50.1


