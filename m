Return-Path: <linux-fsdevel+bounces-25109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD894931F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E237E1C21C3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F31BE23E;
	Tue,  6 Aug 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjsuwahO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F518D659;
	Tue,  6 Aug 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954740; cv=none; b=sniDSDLkYMf5oFDdnmSAz+gHZT2u4ND4EZUlLv+UEb9fRJhHJVzzMHrvckOnqa472PFD43t4/wvXXeHgwegDUU0dNj7HtkntNLbvC6+DFlo3Q8L5QXRJ7h60FSA+KXGkbYaRpfQPyz1Fie2yG6zU1zSDPE+fiAFWaTpsyH2gS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954740; c=relaxed/simple;
	bh=691QilyEvzlg/2Bt54Q3j8m95vwztLrqKuCrAM5y/Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P0Vd4wqjNlEjOvhKbwl7s2LhIbZm4kIqPn5yVmXOWNVOSnn89119kN2NaHdSr4dKpCKm3+u1VTmJssbVK8TShJS8Xz0uS+Yjj+5VfXBJniGEUDDo1ZJi6ACJl8Gbl7fHLZJ0k7Y2SmiTXXqiiOePpPDAqtjP9ZNxfL3FjOUaUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjsuwahO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1095C32786;
	Tue,  6 Aug 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722954739;
	bh=691QilyEvzlg/2Bt54Q3j8m95vwztLrqKuCrAM5y/Dw=;
	h=From:Date:Subject:To:Cc:From;
	b=UjsuwahOj+Jt7EWqhiFcM1kX04RiH7FOmxi8A36JnsLoNHiKiQPbRiRq4fm1mwCZQ
	 5V6ol5zZgLnftev2CGHOFJyT4JMqpCONaxxMZBMcVuqjOQKgthf3aCrmAH3B0MNB6I
	 +bCB2ku07L56R5xjy9+jYuu6Nu2ZAYP7QRstFPY8HdGDZCH2U0Xst1iajW0VEKQoCE
	 FfpVLJg8Ys0QCY+z6jAOgxMyQuf24GivI06fUSzvaMsyqz1v4UmxYSSeDWelGifF9v
	 Js08u1vMiOpSY4g1V8JL1JIquX6TosWVcLC+X+QhNFFde5PyOXAKy6tSNj2jUSo9b3
	 pEBNuwWPkff9A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Aug 2024 10:32:17 -0400
Subject: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-openfast-v2-1-42da45981811@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPAzsmYC/0XMQQ7CIBCF4as0sxYDQ9OqK+9huhjp0BINNNAQT
 cPdxbpw+b+8fBskjo4TXJoNImeXXPA18NCAmclPLNxYG1BiK3vUIizsLaVVkGnP1N87Ghmh3pf
 I1r126jbUnl1aQ3zvclbf9YecJP6RrIQUpIy1SFrLTl8fHD0/jyFOMJRSPv3g3cihAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5709; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=691QilyEvzlg/2Bt54Q3j8m95vwztLrqKuCrAM5y/Dw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmsjPyr6qXd81k0Il4k3F/nEVaNrCMBJs90Adem
 X5fXKKOpzCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZrIz8gAKCRAADmhBGVaC
 FdJwD/9ZtRjBDilpM06eP2KszTn2z+boLaqZ7wSU9gdR0diSG7KHs/aBEkgfcj+l5n2HWSIe2YT
 56dpcSurrgVqkGI9x+xOI2V8StdWXjKr9eMbYeo3cwFOfyIm8v8aD8xcBdWVMGWdQNTrcJg5Fh7
 CFAn6it42nKwcD6YCvG6lpU+LuqaUdlPe/dHJN0KEsWr//l/MEeUV6gD1UhdKRdmJifZ1ZBA26M
 4sMhbOtNCk3mtN0IJrIgYz/C/9ZOgB3Fj61sUbbR/xSJvMOns8Ag3yzrbKF6OM775ahokxfElNa
 QWUurkw4tnWa6QaGSPPrroo7sjvh1x0ny3waqKODN7XtJa1hckVTnRwY0Bjq+yLiWMVCRu66TSf
 C4yP5Kq7jUV9MjrorNGN2NAb/NWK7WbqKJW1qA/NRlu7RawGpf8WNNqEOtgjVI+xxBoyufmYMYX
 jKnPVVbxoMQMmsiFFzIUTq2ItA8wTw/C9S/AajaItN74fsWmYVB7azfS13Yq7UyqwQgi/V9+bPu
 SW/YJ7kPxcJMuBbbMPKW3K+edmdOhwLHQwgPV6lLgqiHFMc22JBttVgwBJIJ+2NaEs2TdXgenXf
 9n3By0pz4shRSZN8qrxJ77nSCcr9wQPw9GO44sEoDuObb1hYBkuA0r3V9YWObHr9XClZJqX9BF+
 XIJ5b01NUr2tolw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Today, when opening a file we'll typically do a fast lookup, but if
O_CREAT is set, the kernel always takes the exclusive inode lock. I
assume this was done with the expectation that O_CREAT means that we
always expect to do the create, but that's often not the case. Many
programs set O_CREAT even in scenarios where the file already exists.

This patch rearranges the pathwalk-for-open code to also attempt a
fast_lookup in certain O_CREAT cases. If a positive dentry is found, the
inode_lock can be avoided altogether, and if auditing isn't enabled, it
can stay in rcuwalk mode for the last step_into.

One notable exception that is hopefully temporary: if we're doing an
rcuwalk and auditing is enabled, skip the lookup_fast. Legitimizing the
dentry in that case is more expensive than taking the i_rwsem for now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Here's a revised patch that does a fast_lookup in the O_CREAT codepath
too. The main difference here is that if a positive dentry is found and
audit_dummy_context is true, then we keep the walk lazy for the last
component, which avoids having to take any locks on the parent (just
like with non-O_CREAT opens).

The testcase below runs in about 18s on v6.10 (on an 80 CPU machine).
With this patch, it runs in about 1s:

 #define _GNU_SOURCE 1
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <sys/wait.h>

 #define PROCS           70
 #define LOOPS           500000

static int openloop(int tnum)
{
	char *file;
	int i, ret;

       	ret = asprintf(&file, "./testfile%d", tnum);
	if (ret < 0) {
		printf("asprintf failed for proc %d", tnum);
		return 1;
	}

	for (i = 0; i < LOOPS; ++i) {
		int fd = open(file, O_RDWR|O_CREAT, 0644);

		if (fd < 0) {
			perror("open");
			return 1;
		}
		close(fd);
	}
	unlink(file);
	free(file);
	return 0;
}

int main(int argc, char **argv) {
	pid_t kids[PROCS];
	int i, ret = 0;

	for (i = 0; i < PROCS; ++i) {
		kids[i] = fork();
		if (kids[i] > 0)
			return openloop(i);
		if (kids[i] < 0)
			perror("fork");
	}

	for (i = 0; i < PROCS; ++i) {
		int ret2;

		if (kids[i] > 0) {
			wait(&ret2);
			if (ret2 != 0)
				ret = ret2;
		}
	}
	return ret;
}
---
Changes in v2:
- drop the lockref patch since Mateusz is working on a better approach
- add trailing_slashes helper function
- add a lookup_fast_for_open helper function
- make lookup_fast_for_open skip the lookup if auditing is enabled
- if we find a positive dentry and auditing is disabled, don't unlazy
- Link to v1: https://lore.kernel.org/r/20240802-openfast-v1-0-a1cff2a33063@kernel.org
---
 fs/namei.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1e05a0f3f04d..2d716fb114c9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3518,6 +3518,47 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	return ERR_PTR(error);
 }
 
+static inline bool trailing_slashes(struct nameidata *nd)
+{
+	return (bool)nd->last.name[nd->last.len];
+}
+
+static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
+{
+	struct dentry *dentry;
+
+	if (open_flag & O_CREAT) {
+		/* Don't bother on an O_EXCL create */
+		if (open_flag & O_EXCL)
+			return NULL;
+
+		/*
+		 * FIXME: If auditing is enabled, then we'll have to unlazy to
+		 * use the dentry. For now, don't do this, since it shifts
+		 * contention from parent's i_rwsem to its d_lockref spinlock.
+		 * Reconsider this once dentry refcounting handles heavy
+		 * contention better.
+		 */
+		if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
+			return NULL;
+	}
+
+	if (trailing_slashes(nd))
+		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
+
+	dentry = lookup_fast(nd);
+
+	if (open_flag & O_CREAT) {
+		/* Discard negative dentries. Need inode_lock to do the create */
+		if (dentry && !dentry->d_inode) {
+			if (!(nd->flags & LOOKUP_RCU))
+				dput(dentry);
+			dentry = NULL;
+		}
+	}
+	return dentry;
+}
+
 static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
@@ -3535,28 +3576,31 @@ static const char *open_last_lookups(struct nameidata *nd,
 		return handle_dots(nd, nd->last_type);
 	}
 
+	/* We _can_ be in RCU mode here */
+	dentry = lookup_fast_for_open(nd, open_flag);
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
 	if (!(open_flag & O_CREAT)) {
-		if (nd->last.name[nd->last.len])
-			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
-		/* we _can_ be in RCU mode here */
-		dentry = lookup_fast(nd);
-		if (IS_ERR(dentry))
-			return ERR_CAST(dentry);
 		if (likely(dentry))
 			goto finish_lookup;
 
 		if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
 			return ERR_PTR(-ECHILD);
 	} else {
-		/* create side of things */
 		if (nd->flags & LOOKUP_RCU) {
+			/* can stay in rcuwalk if not auditing */
+			if (dentry && audit_dummy_context())
+				goto check_slashes;
 			if (!try_to_unlazy(nd))
 				return ERR_PTR(-ECHILD);
 		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
-		/* trailing slashes? */
-		if (unlikely(nd->last.name[nd->last.len]))
+check_slashes:
+		if (trailing_slashes(nd))
 			return ERR_PTR(-EISDIR);
+		if (dentry)
+			goto finish_lookup;
 	}
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {

---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240723-openfast-ac49a7b6ade2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


