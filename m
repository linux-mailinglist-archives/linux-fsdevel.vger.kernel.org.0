Return-Path: <linux-fsdevel+bounces-77223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3KPGBhjckGm7dQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:33:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9512D13D205
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 704203013025
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A7299948;
	Sat, 14 Feb 2026 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEN2nk+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F29475;
	Sat, 14 Feb 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771101204; cv=none; b=dmS11IsZAY8+QFEhFvIhKUIoi9GCx5pAVih91vm+jusK9ce56ZgTIkvB9Aa380wAEUz9n5uUsiP8ucQdIrJjaB6XL/L2a98moJAMV+ohpocBc4KPK3g7fkXIP1ECT8Q3FdpsmbZdEAvkUUP0Rtml24wMOtz+b1SWcIIawsWKxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771101204; c=relaxed/simple;
	bh=kRPpSvRaO+9nsvBsobRozgVCjKXJBokYXSaSEJg70SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzAzp0o4JTaZc0tBSZi5pXyS/sfHK8bAVomf11NbaIi75d7Pw40P0l691JtRTnKO4lf7VF3D5KoZfCGv6nCRvdQEKe1lIjL/cJaLegKDMf7/7VVrPGDPlZV0SotG9amkvYVVmrjcVXlzrYGEm8wod3YTKQw46amZVZ3Htqzg62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEN2nk+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE1CC16AAE;
	Sat, 14 Feb 2026 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771101203;
	bh=kRPpSvRaO+9nsvBsobRozgVCjKXJBokYXSaSEJg70SQ=;
	h=From:To:Cc:Subject:Date:From;
	b=tEN2nk+/b059Wf20VW+ot/GZyrA1zVrUfxsKIeaIa/mgAmY9dCWzquGtg2Ksepxi8
	 JyDn+eJs5eZnKtG6E+68xiSpSPeCzZzard5d/g33/IpwvJc6+tEidPaaKTIUYwXGx9
	 0UgXNK0/wyPIlraEAoUcTSUAVm2fZI7UPRWSi1WOfBlqHtK8E/JopXavJoOQ4enOiA
	 QUn4GFoFf4GtttaVJIEQ2I39V+q5gkMAZTTmTOVeGoxQC/VEou1/9fqA8cPd73jUxz
	 htk51nB7rCU6ly1XLBPi29x11IQAm7UhYDZul70SDrsIcv2z1OQr1vLWY48qAIWiPu
	 fvmXGT0Oxat5Q==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/2] fsverity: remove fsverity_verify_page()
Date: Sat, 14 Feb 2026 12:33:09 -0800
Message-ID: <20260214203311.9759-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77223-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9512D13D205
X-Rspamd-Action: no action

This series removes the non-large-folio-aware function
fsverity_verify_page(), which is no longer needed.

Eric Biggers (2):
  f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
  fsverity: remove fsverity_verify_page()

 fs/f2fs/compress.c       | 3 ++-
 fs/verity/verify.c       | 4 ++--
 include/linux/fsverity.h | 6 ------
 3 files changed, 4 insertions(+), 9 deletions(-)


base-commit: 3e48a11675c50698374d4ac596fb506736eb1c53
-- 
2.53.0


