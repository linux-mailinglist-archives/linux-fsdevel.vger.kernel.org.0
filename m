Return-Path: <linux-fsdevel+bounces-25293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6191494A789
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2583B2806F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A501E4F04;
	Wed,  7 Aug 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaKz64aR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60631E4EF5;
	Wed,  7 Aug 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032636; cv=none; b=ZWnzvjsROEnkeXZKAs5vRny1xnGNJD119ZwAEm/lUIsvzIEzk9hRLCwiJcOFpUEeM+wdRivKdSO2r+ZFJi/CwssBSxX4iLBjKWG9fqk6AvwPi+D2y11OCLv7QCW+gmDzTh/PqZbXTjTEE8j2uzGfLYWr41KdCPyBnUREQ9fnm58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032636; c=relaxed/simple;
	bh=HVHUAGja3w2utW1M1fyR+1PFIvvi4lENnqjmqyZSopw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Oe/6HW7Ql8YxBNPnmy4AORtl/7sGSbUVMr1VjrqiN7dd1wnnqLdu93vkl4CGptHb3TpogMganEePQgEzorsxJs4s3UQ5tNo54URiwziF1St0WIdmstrzkY7VJGNhT3Uk0w9dZ3Q/mRiVZSMpBRucO9dBoisDP5aQCEsxL001bY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaKz64aR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A681BC32782;
	Wed,  7 Aug 2024 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723032636;
	bh=HVHUAGja3w2utW1M1fyR+1PFIvvi4lENnqjmqyZSopw=;
	h=From:Date:Subject:To:Cc:From;
	b=QaKz64aRt/r7YRP6nJh5iEPB5smum166MVOfVJol1zi2kyjPI+oWgk2/v0mDeAHMm
	 Nxe93Y53wzaa+Fy2j/YYtSZF6XU7DbDEAb0ah4ezTUMt07Lb1mhm+YI9d0WNVdOZeV
	 yjKeeOsFqP5xLTgOC432Vbh/2hRtqIC/NwDfEJIaT/YPFIpllcDI6n5cMJ7DQGcvbd
	 Zc3yp+l6LELFLRsCrUtaX+yQy/aVuY0Vz/T61BHU02CePFmKX9guDvGmxJRnXddsgH
	 22TIS+qczjpbwsSBf307ZLaktIuxfp+569tmDmBk5QQZ4ZKhWKqRQPnibh22qC654e
	 JEUc7WNVFymzQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 Aug 2024 08:10:27 -0400
Subject: [PATCH v3] fs: try an opportunistic lookup for O_CREAT opens too
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-openfast-v3-1-040d132d2559@kernel.org>
X-B4-Tracking: v=1; b=H4sIADJks2YC/1WMyw7CIBBFf6VhLQYG7MOV/2FcjO3QEg000BBN0
 3+X1oV1eW7uOTOLFCxFdi5mFijZaL3LoA4Fawd0PXHbZWYgQIsKFPcjOYNx4tjqBqt7iR0By/c
 xkLGvLXW9ZR5snHx4b+Uk1/UbqQX8IklywVG2xgAqJUp1eVBw9Dz60LO1kmBvljsTuOQaOtSnp
 pa1lH/msiwf5h4hH9sAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5802; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HVHUAGja3w2utW1M1fyR+1PFIvvi4lENnqjmqyZSopw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBms2Q7vLZqYSnXHfaj1gl/n7HaX8hFXugqqCdjo
 kf7GsF7zF6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZrNkOwAKCRAADmhBGVaC
 FWTyEADMEmqEAeMOiQQ8+bKxSLw4Kb/iY4AZXLmkddc13ycgpJvjnfSvRRU5HJVYHqcU8RVjvhl
 fz3LUWKGlzLpk3xcnr1Uy/4CpIzr7nqiNUOFHSSE5zBGsZ9gSdMvcHIcdRvMGBgOc8Vnfz+mkNw
 RaXwxDq2eXvVmXHZHyv2xTiqC7tiASlsjrdWYKFEDMTsCH9FDFS/7hB8hHU3Qyr/Bhz3ecHPVRC
 muarTNYdkVRJW6JESARmijzzfbgAjUsb5dYj3rKF2Obaoq6Va4DbOK5NGYLyY8P0fv8vEkFhfEK
 Xa+WEQsoTYh6Z49aU/3jMxRcSODRsAyYjyKbL39r2pwVKWa4dUXoE5vmFDtybnabvBoZTudtnQI
 GkJqLibvQUayAumgUHxzlAFfYFTElOOyLWY8nVU9JTM90LEK6+VBbaPbcHH/SmkxBSrygCpEDCC
 gTBzNDYN+6Rf2zFWCjdmKlDfBVRjsmNNCBQOV8jwZbA/G8O+502IzTqHGnrcVqETSU7eufs9Q3L
 UZyNQVPJ6nP+fre5KnO9htX3AweSzITeZIN4azCRcA25rcehKqQ7TBmSCn6wnABtI1MlUkbW8Qy
 6+M7GN29+954AkMXVyqXqHJtzwJTWbltGKLoT0aMw4Rzkbx9aJYEmccaVl6RxDswJW1hfq51MrN
 FEMEBg31iOqupOg==
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

Mateusz wrote a will-it-scale test that does an O_CREAT open and close in
the same directory repeatedly. Running that in 70 different processes:

    v6.10:		  754565
    v6.10+patch:	25747851

...which is roughly a 34x speedup. I also ran the unlink1 test in single
process mode to try and gauge how bad the performance impact would be in
the case where we always have to search, not find anything and do the
create:

    v6.10:		200106
    v6.10+patch:	199188

~0.4% performance hit in that test. I'm not sure that's statistically
significant, but we should keep an eye out for slowdowns in these sorts
of workloads if we decide to take this.
---
Changes in v3:
- Check for IS_ERR in lookup_fast result
- Future-proof open_last_lookups to handle case where lookup_fast_for_open
  returns a positive dentry while auditing is enabled
- Link to v2: https://lore.kernel.org/r/20240806-openfast-v2-1-42da45981811@kernel.org

Changes in v2:
- drop the lockref patch since Mateusz is working on a better approach
- add trailing_slashes helper function
- add a lookup_fast_for_open helper function
- make lookup_fast_for_open skip the lookup if auditing is enabled
- if we find a positive dentry and auditing is disabled, don't unlazy
- Link to v1: https://lore.kernel.org/r/20240802-openfast-v1-0-a1cff2a33063@kernel.org
---
 fs/namei.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1e05a0f3f04d..7894fafa8e71 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3518,6 +3518,49 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
+	if (IS_ERR_OR_NULL(dentry))
+		return dentry;
+
+	if (open_flag & O_CREAT) {
+		/* Discard negative dentries. Need inode_lock to do the create */
+		if (!dentry->d_inode) {
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
@@ -3535,28 +3578,39 @@ static const char *open_last_lookups(struct nameidata *nd,
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
-			if (!try_to_unlazy(nd))
+			bool unlazied;
+
+			/* can stay in rcuwalk if not auditing */
+			if (dentry && audit_dummy_context()) {
+				if (trailing_slashes(nd))
+					return ERR_PTR(-EISDIR);
+				goto finish_lookup;
+			}
+			unlazied = dentry ? try_to_unlazy_next(nd, dentry) :
+					    try_to_unlazy(nd);
+			if (!unlazied)
 				return ERR_PTR(-ECHILD);
 		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
-		/* trailing slashes? */
-		if (unlikely(nd->last.name[nd->last.len]))
+		if (trailing_slashes(nd)) {
+			dput(dentry);
 			return ERR_PTR(-EISDIR);
+		}
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


