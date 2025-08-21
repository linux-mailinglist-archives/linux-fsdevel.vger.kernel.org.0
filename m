Return-Path: <linux-fsdevel+bounces-58606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4007B2F732
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B4AA2265D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F302DE202;
	Thu, 21 Aug 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhIYVoU5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A62DBF69
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777055; cv=none; b=bUK1lAlg0zufEX4bpF2208JzroSOUCVXBuz7wTfOo4PIuJRvXMT9qtwGVzZ5L0INdYi2w0zeW4LOime1gN8s4uvfvpWYR+Zh4oaCjAa3knCMrbxsZiR/tr1pcae46/pg9jVdkGbwb9XR76gXDSEi1AlYrakKLbzEENjaUYz0jHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777055; c=relaxed/simple;
	bh=2tWzELTCpgrNQh2ndBHtYYugFGD9DKwxtmap0Funj9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l39BeShH7wS1zXyf8lDtX8I3OwdewX/ZLBY59ct1xsGTS9EBOWDSXALXwZDd3YxfT8kEX/vUxiWXaUjBl58Xd0ERBQcoJvp0UKcDy9TOnOZe7mBVtS0F4r3cXoyv1MCOLVoJJjsvl6FPwmMUgHPgNi0z9f6rIZR1Wtu7fA2Vxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhIYVoU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54435C4CEEB;
	Thu, 21 Aug 2025 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755777055;
	bh=2tWzELTCpgrNQh2ndBHtYYugFGD9DKwxtmap0Funj9o=;
	h=From:To:Cc:Subject:Date:From;
	b=lhIYVoU5UGBDtVtWZm0u82OZIl+XEI2fmx3p6irU9Igo/dzb/h/54D9y64sQyqW84
	 +WcEf3oXdm9IscbQZAPn0Em8Ir/lxkhZak52m+cokyLwOPTZ1EaMCvnegcyfmvPqK+
	 DyaiOKkg/aA33qXGgHhWMn//B8zItNlHw4en5tfPwwGm8YwhAGMcCVokXpMf6NYu6R
	 VWA0vK5+0GrML/VUFzJid0M4dA4UulnczI17Evegwg8Hz7oyNFOMZuzcKrbwwtksPy
	 BiPCZjQ30ffVC88XBY3AedHx0NLT/wTYsbZD8ci5fPc+YZhQdr62mnrw0GZIntiv2n
	 iTPgNHjcLYAXA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Brad Spengler <brad.spengler@opensrcsec.com>
Subject: [PATCH] coredump: don't pointlessly check and spew warnings
Date: Thu, 21 Aug 2025 13:50:47 +0200
Message-ID: <20250821-moosbedeckt-denunziant-7908663f3563@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=brauner@kernel.org; h=from:subject:message-id; bh=2tWzELTCpgrNQh2ndBHtYYugFGD9DKwxtmap0Funj9o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQs55CUU9v98cH8Sz2V+rtymBMOrA0+YH7YjvVUR/jlp jvPc/ntOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaipcfIsD78VeFzH9GWlTnT 9H1uX7gUtuR1lszy1vxvGxer/1zu+J+RobOYgeXKkcr7vMt2rV6XtyP0mcZmBrkDCbMF/j30+vH LkxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

When a write happens it doesn't make sense to check perform checks on
the input. Skip them.

Whether a fixes tag is licensed is a bit of a gray area here but I'll
add one for the socket validation part I added recently.

Fixes: 16195d2c7dd2 ("coredump: validate socket name as it is written")
Reported-by: Brad Spengler <brad.spengler@opensrcsec.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 4 ++++
 fs/exec.c     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5dce257c67fc..60bc9685e149 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1466,11 +1466,15 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 	ssize_t retval;
 	char old_core_pattern[CORENAME_MAX_SIZE];
 
+	if (write)
+		return proc_dostring(table, write, buffer, lenp, ppos);
+
 	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
 
 	error = proc_dostring(table, write, buffer, lenp, ppos);
 	if (error)
 		return error;
+
 	if (!check_coredump_socket()) {
 		strscpy(core_pattern, old_core_pattern, retval + 1);
 		return -EINVAL;
diff --git a/fs/exec.c b/fs/exec.c
index 2a1e5e4042a1..e861a4b7ffda 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2048,7 +2048,7 @@ static int proc_dointvec_minmax_coredump(const struct ctl_table *table, int writ
 {
 	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
-	if (!error)
+	if (!error && !write)
 		validate_coredump_safety();
 	return error;
 }
-- 
2.47.2


