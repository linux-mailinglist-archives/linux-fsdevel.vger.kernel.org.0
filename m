Return-Path: <linux-fsdevel+bounces-77449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOsMBlP4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD0151DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DF53076B4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C972F39A3;
	Tue, 17 Feb 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoCA8E6V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9433E2C1593;
	Tue, 17 Feb 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370459; cv=none; b=TvV92UeYyQn8ZvqeHx0BEwQWviHVp4D/iJA+cGog6LXcmVbN7vFp492bdqjUESXOidmUCS03r83DSxMMe/1F4jOFEDvRtHt55tfxJ5aj0GaG8YBcGnec/uAHN93f6HT+5LYwx/5DutenwpWQwGW8witx4BTS62wuPxFH+20qN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370459; c=relaxed/simple;
	bh=7Sal3g8mhk2sBxwKdGGQV/nUpdQCnPiDPd8UZ8TXBQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crPc/i7GholXYnGyLKWrfQqSIjYey4RCFbySj4+6KUlZ8K70s1zMIizQlEGxrdXhKe1MVWmZIJIntghzV6S8OC6mzCYvTmV1ehshXHKpAGk8dHCUzaYO17m+schWODDeILi/CGBWaUulmTgUkJwT7afoPEvQc9BczNqQregRepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoCA8E6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768E8C19421;
	Tue, 17 Feb 2026 23:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370459;
	bh=7Sal3g8mhk2sBxwKdGGQV/nUpdQCnPiDPd8UZ8TXBQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JoCA8E6VYd32Gywrag9qTVix26KS/Sscni399QCg8MpK5zAduq6jsa3c8u6AZSVE6
	 /XDfqL3EqLjePqr+rHCtjxL8sYvulJZMW2J/FGD2Kxk2EWbiR5m8CvkY9j9M2473gL
	 2xi4BwEgYooCDXpBWq9PSE5GE1n4yk1R77sSJLDaQehqs09QaLC3iRGdhZN/4hO8mX
	 5p9/9jqW9tSNpJ+BKIwZQAyz5N+b/bN7BhwerfJWb/aaokPJDfd0qswCcQyadbgjGc
	 tAqwDwcB22gCY0i7T5tDzLZkiwLdOK+FsaBEuj+FsdwmQLD0icEMXSP2G4TCD9lD9m
	 dD3TXai6Ica1A==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 12/35] iomap: let fsverity verify holes
Date: Wed, 18 Feb 2026 00:19:12 +0100
Message-ID: <20260217231937.1183679-13-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260217231937.1183679-1-aalbersh@kernel.org>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-77449-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78FD0151DEE
X-Rspamd-Action: no action

fsverity needs to verify consistency of the files against the root hash,
the holes are also hashed in the tree.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6ebf68fdc386..9468c5d60b23 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -553,6 +553,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		if (iomap_block_needs_zeroing(iter, pos) &&
 		    !(iomap->flags & IOMAP_F_FSVERITY)) {
 			folio_zero_range(folio, poff, plen);
+			if (fsverity_active(iter->inode) &&
+			    !fsverity_verify_blocks(ctx->vi, folio, plen, poff))
+				return -EIO;
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
 			/*
-- 
2.51.2


