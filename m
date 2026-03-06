Return-Path: <linux-fsdevel+bounces-79633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKIVCmsBq2msZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:31:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E162224EE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4306D309A3EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB1136A023;
	Fri,  6 Mar 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR9/o42X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9B407566
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814523; cv=none; b=md89esFfExl7aP30pb/yurbj5nce2cvUbOcrEwSBqo0fT++mH+lO1Tr3EUYDnly6UXxSk9isufKWxMWd5hsq0DcctOpBV0MYT9K2GcP7IZZcNj1XGAOb9x2ota2RAI9EqQ9UHJr8LYmrMOzfIfXRdh85mSYxiurzqhVcJ6jbW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814523; c=relaxed/simple;
	bh=PzWWv0VsnAPgrex3gIvNGOtw6lTUsQZtwiNiTpnaF6w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=BKkdCzyighIYSR9Lhw7gEwtvQcsGOhqqyr+c0Z/CYbKigPE13eZw/fkYhBAnlcssw2FXTKxazifjl6AcLhnwfQeSeT7U29bd7fXGIkdWdsulWA/TivjG5xV7YtQNMMi7NwOTodQkIQp2daa3kl342IkyT0GwUOX999ROLuiMP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR9/o42X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAC9C4CEF7;
	Fri,  6 Mar 2026 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772814522;
	bh=PzWWv0VsnAPgrex3gIvNGOtw6lTUsQZtwiNiTpnaF6w=;
	h=From:Subject:Date:To:From;
	b=tR9/o42X8fTQaQuSP4C4CslDTSDzjm6azJ1HtjV7iXn2MH1TSsF4CoMBHtCeIVKkU
	 DLZSiCh2SHtmJCnEFigWJSV1z/Pd6XCjniU0dC0Q775iHmQb97lgLPnG2bXQR70atE
	 HQ1XFCRbzinghLieC02eSzgO1pk6jLfuXOyj303ehihKRBEQbD/Wjj+TZmbB81xWwh
	 xvXTrFIZ0FnQTOj29xPQlOxSQNZgEEt+FMNKmPh7RHqxDu7rDnqVfK1il2zx7ZvpBE
	 5e/W3qAF5aRzcVU+dN+oeY7or0R8aCISgZrIfZTNrnoXt8tcAlquCV+nUrwxvmp3zP
	 RaszmBBrmJTWA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] namespace: allow creating empty mount namespaces
Date: Fri, 06 Mar 2026 17:28:36 +0100
Message-Id: <20260306-work-empty-mntns-consolidated-v1-0-6eb30529bbb0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALQAq2kC/yXMSw7CIBSF4a0YxmKA8tKtGAdwuVrUQgP4StO92
 +rwPzn5JlKxRKzksJlIwWesMacl+HZDoHfpgjSGpYlgQrOOafrK5UZxGNuHDqmlSiGnmu8xuIa
 BMmOlFKD2UgayGGPBc3z//OPp3/XhrwhtRdeHdxWpLy5Bv06Dqw3LDjgzxiowaIN3PnDgtmPcc
 ei0UFJ6ZawWVpB5/gLzzvKywwAAAA==
X-Change-ID: 20260306-work-empty-mntns-consolidated-078442c5944d
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-e55a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PzWWv0VsnAPgrex3gIvNGOtw6lTUsQZtwiNiTpnaF6w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuZthxcb2fevTZI1WRX8Ntm7UcdI/brYrVZNFuKfx7o
 sOqL0qqo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL1Txn+e6e5pa4pipkRXF56
 58xN/lO/j578cZKz/wnz0Uf2mpsf9DEyPE6606q9lvXj6hczCzx61vsHXA2NuPZd/m/Pnxb7+lm
 nOQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 9E162224EE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79633-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently, creating a new mount namespace always copies the entire mount
tree from the caller's namespace.  For containers and sandboxes that
intend to build their mount table from scratch this is wasteful: they
inherit a potentially large mount tree only to immediately tear it down.

This series adds support for creating a mount namespace that contains
only a clone of the root mount, with none of the child mounts.  Two new
flags are introduced:

- CLONE_EMPTY_MNTNS (0x400000000) for clone3(), using the 64-bit flag
  space.
- UNSHARE_EMPTY_MNTNS (0x00100000) for unshare(), reusing the
  CLONE_PARENT_SETTID bit which has no meaning for unshare.

Both flags imply CLONE_NEWNS.  The resulting namespace contains a single
nullfs root mount with an immutable empty directory.  The intended
workflow is to then mount a real filesystem (e.g., tmpfs) over the root
and build the mount table from there.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      namespace: allow creating empty mount namespaces
      selftests/filesystems: add tests for empty mount namespaces
      selftests/filesystems: add clone3 tests for empty mount namespaces

 fs/namespace.c                                     |  85 +-
 include/uapi/linux/sched.h                         |   7 +
 kernel/fork.c                                      |  17 +-
 kernel/nsproxy.c                                   |  21 +-
 .../selftests/filesystems/empty_mntns/.gitignore   |   4 +
 .../selftests/filesystems/empty_mntns/Makefile     |  12 +
 .../empty_mntns/clone3_empty_mntns_test.c          | 938 +++++++++++++++++++++
 .../filesystems/empty_mntns/empty_mntns.h          |  50 ++
 .../filesystems/empty_mntns/empty_mntns_test.c     | 725 ++++++++++++++++
 .../empty_mntns/overmount_chroot_test.c            | 225 +++++
 tools/testing/selftests/filesystems/utils.c        |   4 +-
 tools/testing/selftests/filesystems/utils.h        |   2 +
 12 files changed, 2052 insertions(+), 38 deletions(-)
---
base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
change-id: 20260306-work-empty-mntns-consolidated-078442c5944d


