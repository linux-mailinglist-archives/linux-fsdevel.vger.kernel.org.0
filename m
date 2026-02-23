Return-Path: <linux-fsdevel+bounces-78091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A8kGprhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:24:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838617F4A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A223B31AD818
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555637E307;
	Mon, 23 Feb 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQBcKXXM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184D2222A9;
	Mon, 23 Feb 2026 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888810; cv=none; b=kajseukZI+wzdot0h03qngm2+ZUBkak2Yfslvc7m+T1BDomzPaoCb/so7rFa66HERJDRSKFbWve8NHSpOFexb/ImPVJQfHi228m2lzfLPPGIQsiOuhayr+YjXaABiVwMABHLgH9lNPYFunKlIYeRRGzkrbDGlTiiLcHe9XoJfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888810; c=relaxed/simple;
	bh=9c8XCNZX4cSu7JZockjUMs7M5UlV6MBJF6bxBnICsEU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPbr03UqYsPs3hyAEtvFEInAdceKYBXINLXv5wOgDsi78iDDbUJHSMYGio9DNAu15NYSjn9TU31WhU7Gq3OEyqfqJsuMNIkd3e6o5FiPkUFTjL/hd9Rrj1JUw909hAvIxnmOBInYCrbmmL7sZIGodIJUMf1gjSjPb/Cws//Nipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQBcKXXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04F0C116C6;
	Mon, 23 Feb 2026 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888809;
	bh=9c8XCNZX4cSu7JZockjUMs7M5UlV6MBJF6bxBnICsEU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=vQBcKXXMszKHQmTYxunCP+8kqDelwg2SuE1wiJUz8QM1yE34z/aOpwcAZ6eC/TNDO
	 r3+blbqeaT7FbuAGTIq5n4lVfDm+KBYxNlJiESLAin7Kk7rfZOOGmSfUEheSNRrVnP
	 hZRukY3mK7kkjBDtHTo5OIs1jJhsinjzbv3K0ElCdJJoC4e4la5WzvfyDJMqHOTqLY
	 R85ETCvmvckJSBhA8jc+GvDMePfnTFk3xf9etQjRsIUsS2X9Eb41itV8tdAfqydAke
	 cywC0doBdvnNNaRaZOU9hPyEPwD8eyZeA6cY0/5wY2HhnWlwOASryRyYm7uO3TS74o
	 xVYfomsx805Pw==
Date: Mon, 23 Feb 2026 15:20:09 -0800
Subject: [PATCH 8/9] fuse: update ctime when updating acls on an iomap inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735696.3937167.941616712898855309.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78091-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0838617F4A3
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the fuse kernel driver is in charge of updating file
attributes, so we need to update ctime after an ACL change.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 483ddf195d40a6..b1e6520ae237cc 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -7,6 +7,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
@@ -112,6 +113,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
 	umode_t mode = inode->i_mode;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -179,10 +181,24 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			ret = 0;
 	}
 
-	/* If we scheduled a mode update above, push that to userspace now. */
 	if (!ret) {
 		struct iattr attr = { };
 
+		/*
+		 * When we're running in iomap mode, we need to update mode and
+		 * ctime ourselves instead of letting the fuse server figure
+		 * that out.
+		 */
+		if (is_iomap) {
+			attr.ia_valid |= ATTR_CTIME;
+			inode_set_ctime_current(inode);
+			attr.ia_ctime = inode_get_ctime(inode);
+		}
+
+		/*
+		 * If we scheduled a mode update above, push that to userspace
+		 * now.
+		 */
 		if (mode != inode->i_mode) {
 			attr.ia_valid |= ATTR_MODE;
 			attr.ia_mode = mode;


