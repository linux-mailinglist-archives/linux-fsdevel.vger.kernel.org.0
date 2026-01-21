Return-Path: <linux-fsdevel+bounces-74904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFt6CgZAcWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:07:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB695DCCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FC705AB5D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21E3D1CBC;
	Wed, 21 Jan 2026 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYjnOuaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F83B8BA8;
	Wed, 21 Jan 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024327; cv=none; b=aQDK+vIdLvQmZcUR3xZpRWmVkbZgUZpU4pFsJBv5KZ+pPmiwO7tO2qcpiV1ElBMsl7mWQeMghrxVgs+xqc2lN8wtDfwRKos6fyWn3NsIn1ozZtdJ9viiVI8XWtfgnQspeXtPBv5vmmvmdXSFTC/kzyhyi+9E8EFmVUxZ0rFk+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024327; c=relaxed/simple;
	bh=eK3BKdrbu4QPB0dIjt6L9ewZ4mh8vJZaorm+w1qrPX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyFqmI/FjAplXuSmcpI9fcDAmAypiYtVfCJEblhXipZ/gu7JmYQTNvq90/WzSYnpS+Ce7Hn7T2VJ8SmMR953QXTnSkAIwsSG2e/TSg9zzDvzfkia8Bq7NmtRRSLGMLqfa3Fz8HemphSYgdwz5cC36lJxbf0WRyWqBGsTLqGT3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYjnOuaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9921C4CEF1;
	Wed, 21 Jan 2026 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769024326;
	bh=eK3BKdrbu4QPB0dIjt6L9ewZ4mh8vJZaorm+w1qrPX8=;
	h=From:To:Cc:Subject:Date:From;
	b=iYjnOuaHnCmjDuVgPo8pZUCkDj6E5TBI6uzztTn6EukrTgTwj1Sf3FRl6i87/NaGn
	 sTJf0taOhaTCqkegIpBI6ONmUPOgPjXgjQTWLe20BxMWDLQUnr82TnCt02J69pL1UG
	 mPyhe1E5kZ20mSBNBG9sC6U0Wtt5BdsW3fi7IwNHkACmfxYryHXhkdkyVUEW7Ufaoc
	 EEvUP/e/ohiDwq4xohAg3Xcr4L5IAPjj2zPqqfKx+UG8sNJyrnGebcY5rxPteTGdKl
	 4z1FsQFJ93I3WMs2+p2pQajj5t/WhGfoE6nulwqepeVR2CHZ75kFQSwoLVMJprSETb
	 6TBT4e8FuZJFw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] fs: reset read-only fsflags together with xflags
Date: Wed, 21 Jan 2026 20:36:43 +0100
Message-ID: <20260121193645.3611716-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74904-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BBB695DCCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While setting file attributes, the read-only flags are reset
for ->xflags, but not for ->flags if flag is shared between both. This
is fine for now as all read-only xflags don't overlap with flags.
However, for any read-only shared flag this will create inconsistency
between xflags and flags. The non-shared flag will be reset in
vfs_fileattr_set() to the current value, but shared one is past further
to ->fileattr_set.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---

The shared read-only flag is going to be added for fsverity. The one for ->flags
already exists.

[1]: https://lore.kernel.org/linux-xfs/20260119165644.2945008-2-aalbersh@kernel.org/

---
 fs/file_attr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..bed5442fa6fa 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -142,8 +142,7 @@ static int file_attr_to_fileattr(const struct file_attr *fattr,
 	if (fattr->fa_xflags & ~mask)
 		return -EINVAL;
 
-	fileattr_fill_xflags(fa, fattr->fa_xflags);
-	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
+	fileattr_fill_xflags(fa, fattr->fa_xflags & ~FS_XFLAG_RDONLY_MASK);
 	fa->fsx_extsize = fattr->fa_extsize;
 	fa->fsx_projid = fattr->fa_projid;
 	fa->fsx_cowextsize = fattr->fa_cowextsize;
@@ -163,8 +162,7 @@ static int copy_fsxattr_from_user(struct file_kattr *fa,
 	if (xfa.fsx_xflags & ~mask)
 		return -EOPNOTSUPP;
 
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
-	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
+	fileattr_fill_xflags(fa, xfa.fsx_xflags & ~FS_XFLAG_RDONLY_MASK);
 	fa->fsx_extsize = xfa.fsx_extsize;
 	fa->fsx_nextents = xfa.fsx_nextents;
 	fa->fsx_projid = xfa.fsx_projid;
-- 
2.52.0


