Return-Path: <linux-fsdevel+bounces-77282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNswCpodk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:37:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A15D143E44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5EC0300462F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B046310779;
	Mon, 16 Feb 2026 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKZnc2bF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E431064B;
	Mon, 16 Feb 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248764; cv=none; b=L7txvH5DpR6H39b2tZ9cw83xBCFyKVtEGBX4zbvcf3rNgfya0g2KNKAuI7MdJpUQlqNzfQgdlMW1FLP9JXqf8gOmhEDF6e+y4nDyTgMX2iII7ESmIGHJDgBoftHsrvCjssbtAAH8Ke4J9dXPEqCY3bLbovuha8/RDrNwVUuIshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248764; c=relaxed/simple;
	bh=96SxHSPi59GBrRPEDM8gKWYEJ+q1qKqGM49g4nTkdB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvAI1ij/hWSp41rt+NHzXhmgnIkMkglMjUGtotEkQOj9Xwr/bUBeSW6q7MeV98UIWztN04IT3jBzsuu1LEG4O+w3+jAy2XDNmJcDlU346Wle+WWJd+OJ8xlLfd7CgDXJqUGJjfjeLeQWht7wSCZMecDiUAr/Y5MoWGjvxZeJKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKZnc2bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFF5C116C6;
	Mon, 16 Feb 2026 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248764;
	bh=96SxHSPi59GBrRPEDM8gKWYEJ+q1qKqGM49g4nTkdB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IKZnc2bFfW0W82B1axiPsfeG/OH6odSnFk6t29PyOLxGZNrqeUK0mUj25LUOU7Ziv
	 A3zbGKEOFHiWHaPfAokCeFQZSRrILdRzwlTIqUvTzIT66H6l0g8ywsCy9KPcUuLHFz
	 jipGl3KpcuDtIWn1Pys7kE7xAoeXNKM95L3+1Qzt21agvqjmsgRFT9JK1az3ssdTT7
	 nDH5BQpoWz2BrV2zXLAJiN4JvemlPD3Vk+7+LOFvQEaHzXbWekHzZxk7D8a22pJwu+
	 Y83CBOWXA3QPiDwb9CBWSo2vt7UnEwVQja7kxsYT4mgSUwDYRi2WCVXoEHON8i6Ofr
	 QY6gb/Tbu+rEA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:32:03 +0100
Subject: [PATCH 07/14] xattr: add xattr_permission_error()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-7-c2efa4f74cb7@kernel.org>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
In-Reply-To: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=brauner@kernel.org;
 h=from:subject:message-id; bh=96SxHSPi59GBrRPEDM8gKWYEJ+q1qKqGM49g4nTkdB4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlolTurXu/ddPcs+fdk/9U6Am8MhlAv83LwnD0mgpY
 42qf+tdO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby35+RYZHzvxMMF7deDl7+
 Luzuz1ger61N6y/bPDx6d2PX1idffi9l+Gd9eG9O78xDSiUs5hGruR/YiesulhGeujJ/7rPiMA6
 u+fwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77282-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A15D143E44
X-Rspamd-Action: no action

Stop repeating the ?: in multiple places and use a simple helper for
this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xattr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 64803097e1dc..c4db8663c32e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -106,6 +106,13 @@ int may_write_xattr(struct mnt_idmap *idmap, struct inode *inode)
 	return 0;
 }
 
+static inline int xattr_permission_error(int mask)
+{
+	if (mask & MAY_WRITE)
+		return -EPERM;
+	return -ENODATA;
+}
+
 /*
  * Check permissions for extended attribute access.  This is a bit complicated
  * because different namespaces have very different rules.
@@ -135,7 +142,7 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
 	 */
 	if (!strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN)) {
 		if (!capable(CAP_SYS_ADMIN))
-			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
+			return xattr_permission_error(mask);
 		return 0;
 	}
 
@@ -146,7 +153,7 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
 	 */
 	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
 		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
-			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
+			return xattr_permission_error(mask);
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
 		    (mask & MAY_WRITE) &&
 		    !inode_owner_or_capable(idmap, inode))

-- 
2.47.3


