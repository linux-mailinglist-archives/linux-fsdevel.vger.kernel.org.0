Return-Path: <linux-fsdevel+bounces-10221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03458848DA7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 13:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B50F281E16
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727C224DE;
	Sun,  4 Feb 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI9dNCw6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7B224CB;
	Sun,  4 Feb 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707049999; cv=none; b=qXmOXN5DcuXbmPYDK7GAE6ydfXHEBAXctQmu1EXF+YzBq3OXZzXulBtNFp2tdRqWjZ2WLjtSwtT2kmTYTVzkxn1AiRqHZpQ89ZALTDRgOAmhlZE83Yuc0NOZx9Hxtnpyaf07HRd4N+RNB8NhbHvTuOIWiEjvt6glxjsZvhs0b5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707049999; c=relaxed/simple;
	bh=tUb84TlzXHt1IU/2JXj468FUS1oRysS/ztfYJPoYHp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fDyj0RSFSg48SCOM0cHIFEud+y+mLdHgyx+DQ3CLijHCJHFEYZW/IJKYKB2g/yU9FUau8CtC9AKhLZwsQMhF7A3v8GFoh2H0eav2GabEeRJf902SieukWC5L54kBM9xZKkMgu69Lyi4CgbyzSaUoHXsE7dPGHFQsQ9cQDhUF2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI9dNCw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A13CC433F1;
	Sun,  4 Feb 2024 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707049999;
	bh=tUb84TlzXHt1IU/2JXj468FUS1oRysS/ztfYJPoYHp4=;
	h=From:Date:Subject:To:Cc:From;
	b=BI9dNCw6srBdVv2d6s4fdVRyF6Q5nj8TgLOoHUgs6OiICA9dexhGykAxw5imT3QLU
	 clUOjqspg17cwmhJuGP/8b3FNtkEfEuEM4bK7qM7pV76bSeQMvnO6jnpip3fq7MHvf
	 BAR7VgFZ/RyYx5TELqFfR0wRPa2ST3/Pcc/AA0VP6m9zw+9DvuKVvQRpqYnrUrSjvI
	 r1o8lTUe9/zE2oBqNYyIuvBHKTXr2yJMpadoM34IuWlGJf4Ud925WQ9qnT47BZs3cH
	 D3rkZhda+B9QDT0RaJBz8bpmlWdcgByOhttIv18/ObDpTiB0kQdJ2HEZcwTksjVKFN
	 u7Lkx1NrIVS5w==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 04 Feb 2024 07:32:55 -0500
Subject: [PATCH] filelock: add stubs for new functions when
 CONFIG_FILE_LOCKING=n
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-flsplit3-v1-1-9820c7d9ce16@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPaDv2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3bSc4oKczBJj3ZREMzOzFAujJPMkEyWg8oKi1LTMCrBR0bG1tQA
 3JXiZWgAAAA==
To: Christian Brauner <brauner@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tUb84TlzXHt1IU/2JXj468FUS1oRysS/ztfYJPoYHp4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlv4QHX6KksZ4zQY7QHs4PamLpO9ItNSIcm/Xlu
 JYUjeZHVIGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZb+EBwAKCRAADmhBGVaC
 FQ8FD/4mvgATOGCSC4QBT43oj6d4HGsFeiX7kppaIBfKAaXZS6BAxwH0/glK7jGhFLuKwnI0vHi
 2TZoCdGeaLY5KUjhMTUzpg8zrzYRTFZBQvBbFRFvarLTEdXkqjrMFuSdw8KIqONnWIm2xkIOlgO
 8Usr7m+Sozb211U7aASJpnsD0Elu2IQvlNf4O8NsaemBPtzAf0YtqFKNcXa4F/ZhFNIc3ETKl7J
 9Jr5sFgwifCdCbpUF6rECc//W4bpPd3EJBSiI/+25mtR7bYWo2l9pKAnacftcxpydTFl6ligUDv
 U7LfXnYX5anjso0vor6moqyxJ8oVQxQIaLmV/2RQovX5ZThw7PwkI5TP2ncpkS8ixb5ZsD+Kh6C
 UJPjh/HqWhmMI608RFSPelhFBZrdSZbRLu2xL89xWRuZU9BxR0hNtjuapTmOP6IIngTl1mnaWtO
 Ws+gAlYzd/DDXsbXisl5PjbUIYymzvVMiyysULzkD35mMu3v4mMPNfpRl527l/uswPWcqzGr1gx
 sEfFKOp46g/b6Q808YIhr/5YFPe4wmjjjqIZ4clujx2yck8tb/SkwCbRkaz7rBczWEQgkr+n9eE
 q7ApE3Q1LP8NloMM9rZ9sz3+aOtU6Epb8bnOgJT9Fsjz1wymtXlRUtm+QjsrqDzii20Jrit2t8r
 k8eR1ThyZrTdowg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We recently added several functions to the file locking API. Add stubs
for those functions for when CONFIG_FILE_LOCKING is set to n.

Fixes: 403594111407 ("filelock: add some new helper functions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402041412.6YvtlflL-lkp@intel.com/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Just a small follow-on fix for CONFIG_FILE_LOCKING=n builds for the
file_lease split. Christian, it might be best to squash this into
the patch it Fixes.

That said, I'm starting to wonder if we ought to just hardcode
CONFIG_FILE_LOCKING to y. Does anyone ship kernels with it disabled? I
guess maybe people with stripped-down embedded builds might?

Another thought too: "locks_" as a prefix is awfully generic. Might it be
better to rename these new functions with a "filelock_" prefix instead?
That would better distinguish to the casual reader that this is dealing
with a file_lock object. I'm happy to respin the set if that's the
consensus.
---
 include/linux/filelock.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 4a5ad26962c1..553d65a88048 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -263,6 +263,27 @@ static inline int fcntl_getlease(struct file *filp)
 	return F_UNLCK;
 }
 
+static inline bool lock_is_unlock(struct file_lock *fl)
+{
+	return false;
+}
+
+static inline bool lock_is_read(struct file_lock *fl)
+{
+	return false;
+}
+
+static inline bool lock_is_write(struct file_lock *fl)
+{
+	return false;
+}
+
+static inline void locks_wake_up(struct file_lock *fl)
+{
+}
+
+#define for_each_file_lock(_fl, _head)	while(false)
+
 static inline void
 locks_free_lock_context(struct inode *inode)
 {

---
base-commit: 1499e59af376949b062cdc039257f811f6c1697f
change-id: 20240204-flsplit3-da666d82b7b4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


