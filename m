Return-Path: <linux-fsdevel+bounces-76607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zq3XOq4chmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99E10094A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E74AD3019595
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BF23B5314;
	Fri,  6 Feb 2026 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8AxzhBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B73AA197;
	Fri,  6 Feb 2026 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396698; cv=none; b=rIDcVwent52A/koLDEZOYVV5YeoaxB4xkkJDXaAq0AM6+DzG7/kvzxT50SMHyvYNxNDIq7YwcaCRXIC2TfAdoaHI2W2JQCpaCO9cl2Jp9KzA8uM5zZTJYVKk5nflhEy7FS6p50g/plVzGuKPCAPMwvgnSxTYRwgzJ2tCVSwnWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396698; c=relaxed/simple;
	bh=GuMmtVB1YWYBA0yB69k38sQLGwquxaqwXfAjnEB1NUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPSsrqa0Rfa+vkgfiSKSATcRtPvc+nqz0wF+/ZT1GvWdCNp3HOOi7B06IqXH8oBbPLmkndQRwcIVuCcsGED65klLG7SPOcwCpLXSyUhTujrc7iWYR0OOHwcF/VzVUKvf669blHCZWgCB6NRcS/q648Acye/buy/2eE6u5nb9cfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8AxzhBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB8AC116C6;
	Fri,  6 Feb 2026 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396697;
	bh=GuMmtVB1YWYBA0yB69k38sQLGwquxaqwXfAjnEB1NUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8AxzhByRzDBc437/jzlS1l5iaa4O8NbZp2CNfS+JPGiEM89rBvsqyotfG2RECadk
	 W4JqSFAOEbGgDhsM5PupSbtkBgPFTRpCQSyAcmMcCpqq6rZtdoAaEbt0nZQ6eQcUPf
	 mDakmE8Yvc2EC1bO7UGLIJPGF8FQf8FA+Gz5w25OrX3WXPBITxHVRiNyaTpVxkM1FC
	 nk+TGBhrNS3QNmcxyzvFc9gDlyzityggmu5+Q5F5bXs6kXk49UCRW8TMGypcIuAfYI
	 8QFiT+pY2CTWYhX/1VbCiUvgExsZbaNR5z/IDmkEDHxJjZzx+rv+fmeGc0u1GsVk/r
	 54Sg3VPSacW5w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 09/12 for v7.0] vfs atomic_open
Date: Fri,  6 Feb 2026 17:50:05 +0100
Message-ID: <20260206-vfs-atomic_open-v70-7297c622297a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=brauner@kernel.org; h=from:subject:message-id; bh=GuMmtVB1YWYBA0yB69k38sQLGwquxaqwXfAjnEB1NUM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se+yM1Odbdu5dW/Mkd9LQz0u3pd92NSTfDlZ+EKHC VOhTPSWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsqmf4yfhu44EJHIaqfNN2 t7pNUSgSMOvwa5ds1Z+06PbN/1XrpjH8Uy24rWFQsDLwxaP/wgl+l7vlryR7HNWMtVmeJc96NaS dGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76607-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF99E10094A
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

Allow knfsd to use atomic_open():

  While knfsd offers combined exclusive create and open results to
  clients, on some filesystems those results are not atomic. The
  separate vfs_create() + vfs_open() sequence in dentry_create() can
  produce races and unexpected errors. For example, open O_CREAT with
  mode 0 will succeed in creating the file but return -EACCES from
  vfs_open(). Additionally, network filesystems benefit from reducing
  remote round-trip operations by using a single atomic_open() call.

  Teach dentry_create() -- whose sole caller is knfsd -- to use
  atomic_open() for filesystems that support it.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.atomic_open

for you to fetch changes up to 6ea258d1f6895c61af212473b51477d39b8c99d2:

  fs/namei: fix kernel-doc markup for dentry_create (2026-01-20 14:54:01 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.atomic_open

Please consider pulling these changes from the signed vfs-7.0-rc1.atomic_open tag.

Thanks!
Christian

----------------------------------------------------------------
Benjamin Coddington (3):
      VFS: move dentry_create() from fs/open.c to fs/namei.c
      VFS: Prepare atomic_open() for dentry_create()
      VFS/knfsd: Teach dentry_create() to use atomic_open()

Christian Brauner (1):
      Merge patch series "Allow knfsd to use atomic_open()"

Jay Winston (1):
      fs/namei: fix kernel-doc markup for dentry_create

 fs/namei.c         | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfs4proc.c | 11 ++++++--
 fs/open.c          | 39 --------------------------
 include/linux/fs.h |  2 +-
 4 files changed, 82 insertions(+), 50 deletions(-)

