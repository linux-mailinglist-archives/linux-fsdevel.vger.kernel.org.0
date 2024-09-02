Return-Path: <linux-fsdevel+bounces-28204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6A968007
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F93B228A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF00185B6F;
	Mon,  2 Sep 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Hy2StFKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82216149E03;
	Mon,  2 Sep 2024 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260856; cv=none; b=e/qH7KrLaLIezwxx6ULsF95TYvf53UltAcL+4V5ZrR1lvp5z1svw8Bc6XgyDvjgFt+3G50ZAQVTDw8N54orucIoJ22+QdwmU1BGLyWFBRJnpt41RA6TRpKP8pBdmVX8xVSd+uJLyFmmLfwkHObJyz3xDb+oRbJ7PRgncXjo+97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260856; c=relaxed/simple;
	bh=c4dE2X3D8jNW7VIHknDX4GKLOebCJIX98K1SweWgq9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdjkqVyORhfmDhC8y7QShOSkR+L/Sf1bL7FTDEXH7lKXg5lE3tKPMQgdvhtx+E5P6BSdOttIFN9CgrsfBy8bBzB7WnSOECaoL1nPmktCVGH6ZRUYMoz21RH2LAHmmvghy+Q++rCeBmwywwiblx7W7nzbx8WUK9Lrjgu4pHVzXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Hy2StFKc; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wy0F94X8Lz9scM;
	Mon,  2 Sep 2024 09:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725260845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeczAUMJPFpgcChSC2NOpYh4duarO6U/B6665/OuVEY=;
	b=Hy2StFKc/4fKf2gCKEaSL7UxDpWJxwxLk2pIp3OJ2n0a8eq6IW3vyQEhkRp9UJOLiTiunW
	YVTgg2HXuIfJngk+nyBMbisgCqKp0kocbdERctb3CL37YgSXM/OKuHCK11SCUJi+Rm+DHr
	d/RS7NpLLmiXwVHtJr1MG9rUNGeOyL4iPgnzY+CHiPuHVq8ooP/7CH8HAR9k3bDkr4U+R+
	MJuJVkrkZ0uI4B5q/enV9pEvNdplFH8PT1Tox0tMbtr48T4Ewf1d5fyeUq0xy+talR9bzS
	oiAEfpPnttmh/2ruGnsLF7CYK1q1QPyMWhX5xUUMPN3y3Qg7LIXZKDqCID++eA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 02 Sep 2024 17:06:25 +1000
Subject: [PATCH RFC 3/8] openat2: explicitly return -E2BIG for (usize >
 PAGE_SIZE)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-extensible-structs-check_fields-v1-3-545e93ede2f2@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
In-Reply-To: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=c4dE2X3D8jNW7VIHknDX4GKLOebCJIX98K1SweWgq9g=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaRdTWGRbE3TnMVyMdt3/7qP1bN/2Gyw2jHlR07LlQNPj
 xpsTOPk6yhlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATmS3OyHBd5dLj/ifJLEc2
 z/o4p+HyZJ/uo1XTcvh+nt7n8dBBxFmU4b/b7UkqGo/ddocHbXU6cMVNSOsM471neR8eL2uIuvH
 zuRQXAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

While we do currently return -EFAULT in this case, it seems prudent to
follow the behaviour of other syscalls like clone3. It seems quite
unlikely that anyone depends on this error code being EFAULT, but we can
always revert this if it turns out to be an issue.

Cc: <stable@vger.kernel.org> # v5.6+
Fixes: fddb5d430ad9 ("open: introduce openat2(2) syscall")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/open.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..30bfcddd505d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1458,6 +1458,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
 
 	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
 		return -EINVAL;
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
 
 	err = copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
 	if (err)

-- 
2.46.0


