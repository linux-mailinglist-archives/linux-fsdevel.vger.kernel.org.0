Return-Path: <linux-fsdevel+bounces-77229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJl4GtrmkGnudgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 22:19:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0A713D46F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC6CA30221CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2325F994;
	Sat, 14 Feb 2026 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1TAy0Nq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260515687D;
	Sat, 14 Feb 2026 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771103956; cv=none; b=Aw/kTzrqMg9BWK07WMoHS3d1C+dHRfRvtbSZhtcYOJm1q+nTrWHwAkN6yExJ3TdCu2LIbVefXY9EgjPyFCSDTqoWzsTsl9bPOIVexucfsDaLYj4IBdkob9BNB8PBHH93xrfp8kTUpWJUF6xcgrgwFH6b6M9hgAFu0MQuly7jlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771103956; c=relaxed/simple;
	bh=M6VL2Ez0tT1CpEX0FgdzeilPEVi5VNIinD4KFHFmOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tvaw0152uxE6K05/eF+dUc3Ed1VuPSoH7IIws0pqOHjPObEOqz3VPWZBfBPjixaIN/r+fDFwQphg9DjzjTA4K534A1U4bi0nnu+UH7til/MNZAVFJJHLkCrw4cty/xCC+7ca9nCFhM1UupsykFEmUbL5m488NQakNjFfHQHt52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1TAy0Nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A6BC16AAE;
	Sat, 14 Feb 2026 21:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771103956;
	bh=M6VL2Ez0tT1CpEX0FgdzeilPEVi5VNIinD4KFHFmOnE=;
	h=From:To:Cc:Subject:Date:From;
	b=u1TAy0NqarrB76rRo4+F6siHdo2KE5BMGtDlvxRS1X9qcRzXmPZg/OXL3OXVGV+JB
	 RbnsEHZ9ZMPULmS8glhcvIx+CnhFT5xfm5mX1BCjH0j3DA33xjoWTrM395GfLEpHsu
	 DgMZ+6HqmpjdWP2LoM5DEGkvQbZCtdBsROTU6TZQQHj2FtqyPf6ZCbtF3xac3e1dvN
	 Ykha2yOAuSrJhsahlm1Cw5iNWF364t54Sgp3uFMVSPeRQ5x5jIdVgMGXXDnqj4tMoR
	 bdX+qz4bWRZvjNaPGB/8pbgEC9pyZ9ut5GQIMnsIsDa1dk2naoLExJpaQVq+ibk/j9
	 9iL9JsLDJHMPw==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/2] fsverity: remove fsverity_verify_page()
Date: Sat, 14 Feb 2026 13:18:28 -0800
Message-ID: <20260214211830.15437-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77229-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB0A713D46F
X-Rspamd-Action: no action

This series removes the non-large-folio-aware function
fsverity_verify_page(), which is no longer needed.

Changed in v2:
    - Made one specific part of f2fs_verify_cluster() large-folio-aware.

Eric Biggers (2):
  f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
  fsverity: remove fsverity_verify_page()

 fs/f2fs/compress.c       | 6 +++++-
 fs/verity/verify.c       | 4 ++--
 include/linux/fsverity.h | 6 ------
 3 files changed, 7 insertions(+), 9 deletions(-)


base-commit: 3e48a11675c50698374d4ac596fb506736eb1c53
-- 
2.53.0


