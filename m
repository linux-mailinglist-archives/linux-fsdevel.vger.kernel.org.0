Return-Path: <linux-fsdevel+bounces-78092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFFHE7/gnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:20:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A770017F2E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 118EC3053BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2E37F747;
	Mon, 23 Feb 2026 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJRO6Mg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921037F734;
	Mon, 23 Feb 2026 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888825; cv=none; b=EyNXivYZ++DBqf4Sbug8/bUn/zmf9k0HH/UchNyGlqB8IhO9i6ZtXfS60rzrKcScOXYmNkA7m/4emT7DFj0gVvsX92ChU4HATQpPP6p2oeKUXUQwUikH4sJE8mCpKRWq4vF4SnTShAKvaSk82Iqvr/T8A/g/A9VK4G3LIU2a2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888825; c=relaxed/simple;
	bh=NC/nqTvdnRRjeCVAlkOR2MeyNtZR1hNBPt6JMbayXiQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmbDp68Cjqod+xOZZdIhiC965EJSltbEq9yTkrjlsEO1/l4kg0l0gDKoCo7Dj8FuMuAoRLSKpUstJV4WngQqejKHyJ7/OZmeyds1iWVb3+NXk2c/+mxBBdAkpExAPcjKdUJZayX2UMI+PeItvPNlsfTfi3kELOjjbuS9yGn4/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJRO6Mg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558C9C116C6;
	Mon, 23 Feb 2026 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888825;
	bh=NC/nqTvdnRRjeCVAlkOR2MeyNtZR1hNBPt6JMbayXiQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JJRO6Mg9KlKh3nOG0TWPKpbrqUXeJ9tuhPcofny9c2d0Z9aK2VksoQVnLgCMv0G+H
	 mOd4BEuUZXBIN3tFaZ8pKW6N64GhzAt/32Wz3w3J5P3CvCAE3Fu9qc7tyXk4mmEaQc
	 4rweP+MBLwoypf/gWavBSiEkYWPipjRuDKyOo4+R5tb6nsnwAYAA67iOnWNeNwXkN8
	 hvaydQAetvnLqc9W/p+3zQZYWD66bY9xg5x9jRMNOMAmPesxxyr+zkFzg47biPFeoU
	 QAc/oLln2DfGueVQZQ97I8VV/+Os7UxQnWrQ1ynUIIREkWyMK18no1FhFDOjp4ADvV
	 /yeLjYuSeKHgQ==
Date: Mon, 23 Feb 2026 15:20:24 -0800
Subject: [PATCH 9/9] fuse: always cache ACLs when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735717.3937167.14356284450149267658.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
References: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78092-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A770017F2E8
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Keep ACLs cached in memory when we're using iomap, so that we don't have
to make a round trip to the fuse server.  This might want to become a
FUSE_ATTR_ flag.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c     |   12 +++++++++---
 fs/fuse/dir.c     |   11 ++++++++---
 fs/fuse/readdir.c |    5 ++++-
 3 files changed, 21 insertions(+), 7 deletions(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index b1e6520ae237cc..146d80552072bd 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -211,10 +211,16 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (fc->posix_acl) {
 		/*
 		 * Fuse daemons without FUSE_POSIX_ACL never cached POSIX ACLs
-		 * and didn't invalidate attributes. Retain that behavior.
+		 * and didn't invalidate attributes. Retain that behavior
+		 * except for iomap, where we assume that only the source of
+		 * ACL changes is userspace.
 		 */
-		forget_all_cached_acls(inode);
-		fuse_invalidate_attr(inode);
+		if (!ret && is_iomap) {
+			set_cached_acl(inode, type, acl);
+		} else {
+			forget_all_cached_acls(inode);
+			fuse_invalidate_attr(inode);
+		}
 	}
 
 	return ret;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4729137fddab30..7be5185d9506d9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -448,7 +448,8 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
 			goto invalid;
 
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &outarg.attr, NULL,
 				       ATTR_TIMEOUT(&outarg),
 				       attr_version);
@@ -1663,7 +1664,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 		sync = time_before64(fi->i_time, get_jiffies_64());
 
 	if (sync) {
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
@@ -1847,6 +1849,9 @@ static int fuse_access(struct inode *inode, int mask)
 
 static int fuse_perm_getattr(struct inode *inode, int mask)
 {
+	if (fuse_inode_has_iomap(inode))
+		return 0;
+
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
@@ -2530,7 +2535,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 		 * If filesystem supports acls it may have updated acl xattrs in
 		 * the filesystem, so forget cached acls for the inode.
 		 */
-		if (fc->posix_acl)
+		if (fc->posix_acl && !is_iomap)
 			forget_all_cached_acls(inode);
 
 		/* Directory mode changed, may need to revalidate access */
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 45dd932eb03a5e..7ecc55049eefc6 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -8,6 +8,8 @@
 
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
+
 #include <linux/iversion.h>
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
@@ -224,7 +226,8 @@ static int fuse_direntplus_link(struct file *file,
 		fi->nlookup++;
 		spin_unlock(&fi->lock);
 
-		forget_all_cached_acls(inode);
+		if (!fuse_inode_has_iomap(inode))
+			forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &o->attr, NULL,
 				       ATTR_TIMEOUT(o),
 				       attr_version);


