Return-Path: <linux-fsdevel+bounces-78175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJoYB6vmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D051E17FE80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E46C3100F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5037FF52;
	Mon, 23 Feb 2026 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLs4G3rf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBBE1E9906;
	Mon, 23 Feb 2026 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890125; cv=none; b=KAQb5LjNsN9xbYPAZIkeAATeEmZEWeM1pxxpudhmnGekkuTRcsVqY/rvEqwhKU4I9fR1A0PlgedR33fUXziho7H1K7qiGBuQgPFIy2uq1XPXYY5QrIte3fOEpK2h2p0PFfWTUQq0qd8y7Hn/kgD49Gw7LJeBBHg54B4XxhA1lAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890125; c=relaxed/simple;
	bh=RYOl1+wgoYJgNIX0o1KLAzZJP4lWK7bra6v1hXvke6c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkyDxvDYXgp5Xa6TWPvLAfEGpusQi5skImdhihWbjkyTuiKdyitVMX0Q73FpFKRQzDHMeQIPZUXGgHk981l/WzCD9xu1AvHYFp0sM7K/zyFHTBIHWRBGfSUb7QK3ta6u/YHpND7zYJdClae1V31ApBP3FtJxgdrvhezBcV4fqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLs4G3rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FA7C116C6;
	Mon, 23 Feb 2026 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890124;
	bh=RYOl1+wgoYJgNIX0o1KLAzZJP4lWK7bra6v1hXvke6c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WLs4G3rfIL8c7TfxojW9gwdRQ1EMHOPsCcMfylCImWto3Vf+/qPy6OEvueFuLel1y
	 XfVAbdCv7j2zNZQDi6bwz/ysTrlwN1l0RcmJTDjbiIXmX+EwtE8YiRTiyow06Bunsp
	 OXCuUTMHEF8zNZymn+lUfG50BtAaguW4ksy/RsUb3hA4JlBOcb53ABxp/snagaHgqq
	 nMsMKcsIb5uipWfx3s6mIUsTpSxFwFAv+WJrlxzneH10dvwJ5k1mfRRehEu+4CLN5X
	 cp4Xhv0an7BQghrdG37jTkgBSVbBnXSYwJVkXAd3m5+I0GNBSfUBP5b4oTaL6Y3txj
	 N4YzfG90yH5EQ==
Date: Mon, 23 Feb 2026 15:42:03 -0800
Subject: [PATCH 03/10] fuse2fs: let the kernel tell us about acl/mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745234.3944028.6720977370701087020.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
References: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78175-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: D051E17FE80
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

When the kernel is running in iomap mode, it will also manage all the
ACL updates and the resulting file mode changes for us.  Disable the
manual implementation of it in fuse2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    4 ++--
 misc/fuse2fs.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index b7ee336b5e4546..2cbbd1ed19a00c 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2505,7 +2505,7 @@ static int fuse4fs_propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl || S_ISDIR(mode))
+	if (!ff->acl || S_ISDIR(mode) || fuse4fs_iomap_enabled(ff))
 		return 0;
 
 	ret = fuse4fs_getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -3931,7 +3931,7 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!fuse4fs_is_superuser(ff, ctxt)) {
+	if (!fuse4fs_iomap_enabled(ff) && !fuse4fs_is_superuser(ff, ctxt)) {
 		ret = fuse4fs_in_file_group(ff, req, inode);
 		if (ret < 0)
 			return ret;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 473a9124016712..503d3c1cba5fd4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2307,7 +2307,7 @@ static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl || S_ISDIR(mode))
+	if (!ff->acl || S_ISDIR(mode) || fuse2fs_iomap_enabled(ff))
 		return 0;
 
 	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -3636,7 +3636,7 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!is_superuser(ff, ctxt)) {
+	if (!fuse2fs_iomap_enabled(ff) && !is_superuser(ff, ctxt)) {
 		ret = in_file_group(ctxt, &inode);
 		if (ret < 0)
 			goto out;


