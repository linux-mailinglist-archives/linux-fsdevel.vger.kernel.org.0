Return-Path: <linux-fsdevel+bounces-76604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJLAH+schmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:55:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83864100999
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAC973016B1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A45C36166D;
	Fri,  6 Feb 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epP4pnGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723735DCF2;
	Fri,  6 Feb 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396693; cv=none; b=VRPjMxIqw+FnVsF2+LnSquMaTWk5o8JF8ICx1XJEEke2A/lyLvcpj9v8C/Gpt9579fFAr+ZfI/eXv4vrYBQQmRqGNfatTt7rFR5zEGPQasbvJLBFCK/Om64BW9g+EDDlIMeqZLtJu0KHPoceopLfld3PGi7vOMnZ8VA8LKYJcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396693; c=relaxed/simple;
	bh=rtx6MQuKGsMkGa6pdQwtTVbbhFMtalHH9NJdtqEgurs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEqbh+MlaZ8P2geVikw5s0CWcfjBCCRjNrNiSUfQbGNOoXF15Wcc1NT/DD99QwldzksgyioFL/HP9CYEC2QKyUkVMn8peQTvSWOVGbhddtkmzhnI4/fFrOIYkAoGZRDRc7CkSrDb0PAneI2zpxbvRH1uAwv1RAL/YT0eE/2nefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epP4pnGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4677C116C6;
	Fri,  6 Feb 2026 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396693;
	bh=rtx6MQuKGsMkGa6pdQwtTVbbhFMtalHH9NJdtqEgurs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epP4pnGdXTvZSAfKjvHAp03uSE12pJMmauV2e6HD5BHWUfMMncPqIVib3Fwvm4wvb
	 eeEt6uDnu1HA6WL5G9VrX/WLoqhnJ3YXjHr2WFTDO64GbN3lYLZkCl23U35AST5Y9J
	 evqBpWZ+MCkETEVz1tbBAt5umfasIMCKkeL2VbFiRxEbqeT0LjS2/qDBWZZ2d6gV3k
	 3hEnApAYJPp+vnU+dadrog+AI3fhOce+icLFgvn8C5IcwBK1S1NRG8kWIr7QQeY+n9
	 4lNEHUmh7x06QPqBiRzmiVgg4kSa2w2xPD86KHY73oAvTF4TKrqrJtw15WQI5NBhEZ
	 xDNoVRF9hCBqA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 06/12 for v7.0] vfs btrfs
Date: Fri,  6 Feb 2026 17:50:02 +0100
Message-ID: <20260206-vfs-btrfs-v70-7e05d1142772@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; i=brauner@kernel.org; h=from:subject:message-id; bh=rtx6MQuKGsMkGa6pdQwtTVbbhFMtalHH9NJdtqEgurs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se/cEPUtM/zMGRn+K4zxV23mmwnefdzf1+u0a8Zx4 ftfX29Z11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARaT1Ghv3MKtaB1uleBz72 GumeMp2XlL3uXI/N9YU3LM++U1t+wIKR4eet7fvVLv/UfJYf+VlwyZyc5R1tqqYvp/x7FGv/Is4 1iQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76604-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83864100999
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains some changes for btrfs that are taken to the vfs tree to
stop duplicating VFS code for subvolume/snapshot dentry

  Btrfs has carried private copies of the VFS may_delete() and
  may_create() functions in fs/btrfs/ioctl.c for permission checks
  during subvolume creation and snapshot destruction. These copies have
  drifted out of sync with the VFS originals — btrfs_may_delete() is
  missing the uid/gid validity check and btrfs_may_create() is missing
  the audit_inode_child() call.

  Export the VFS functions as may_create_dentry() and
  may_delete_dentry() and switch btrfs to use them, removing ~70 lines
  of duplicated code.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.btrfs

for you to fetch changes up to f97f020075e83d05695d3f86469d50e21eccffab:

  Merge patch series "btrfs: stop duplicating VFS code for subvolume/snapshot dentry" (2026-01-14 17:17:53 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.btrfs

Please consider pulling these changes from the signed vfs-7.0-rc1.btrfs tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "btrfs: stop duplicating VFS code for subvolume/snapshot dentry"

Filipe Manana (4):
      fs: export may_delete() as may_delete_dentry()
      fs: export may_create() as may_create_dentry()
      btrfs: use may_delete_dentry() in btrfs_ioctl_snap_destroy()
      btrfs: use may_create_dentry() in btrfs_mksubvol()

 fs/btrfs/ioctl.c   | 73 ++----------------------------------------------------
 fs/namei.c         | 36 ++++++++++++++-------------
 include/linux/fs.h |  5 ++++
 3 files changed, 26 insertions(+), 88 deletions(-)

