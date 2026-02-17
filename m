Return-Path: <linux-fsdevel+bounces-77458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULcBFRD4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7F151D49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C2D305D4A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7E29D297;
	Tue, 17 Feb 2026 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4uNB8HD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADE221FCF;
	Tue, 17 Feb 2026 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370478; cv=none; b=NcVLe12dnzLVsMvkALaRjELql8H+664mOYHavdw66ZKAKc3TzhTPHmUNjHcdaIifjMWCrHbrZAhznDL/gv93UF7jTls4ylp5XGyX2jhcDZ3PKpC3iLo56F/kKXzHhLi7BP6g0LyaVMNwARHMtGEmarkod7vvRuGfOlg8LFtFn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370478; c=relaxed/simple;
	bh=HKFsPv9qtOLRNegtadxq2+cVh83+lhDv8nfJxFBBclY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djkdYB6OgY8rsgY35D2AwBWIos3J3Xd8z5Pur5YvHOYntrJgpY+ZIQ/sOKWND6SFQANpSKb+JzhnIxgNntvUqjsBPHLRyvyDPLDu9cxJTrP9h0pzBzUcHUE7HN6ezcVcV6zZ7cGJ2+xzwvljLm0RCEfr4ETx46VP/Q8MGK8K3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4uNB8HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E61C4CEF7;
	Tue, 17 Feb 2026 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370478;
	bh=HKFsPv9qtOLRNegtadxq2+cVh83+lhDv8nfJxFBBclY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4uNB8HD6ZPeBG4RIv8NyyFOivpedID2zgMBbxBoLNER9n8w59T6P4Y15JwbCKMvg
	 35ISRz+YombxOSIvyk+IBsmY1M/fEb6F9/OqvLDzHVcmFtnuUBXg7UlAW2S9+/rROb
	 rZs/kYtf6gEBUZWsW0yA4TbSn/rmxBTOdxkun4R9l5GIOtta1rzDvxv26zLTnGptbv
	 wTBWEcovva70wvj6me9wjdyDdCuDwTHchE4Sd1y/uLS7VVaQbEvMnUhtaf7c0J/64i
	 iSoo4UXov1EVJ/3UNH1Ip7yXKdlAmZtjpdzDxwe70d6sLRmkwOGJWIUNPLLABAP+/d
	 IsT6JGzL/UKIg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 21/35] xfs: disable preallocations for fsverity Merkle tree writes
Date: Wed, 18 Feb 2026 00:19:21 +0100
Message-ID: <20260217231937.1183679-22-aalbersh@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77458-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06E7F151D49
X-Rspamd-Action: no action

While writing Merkle tree, file is read-only and there's no further
writes except Merkle tree building. The file will be truncated
beforehand to remove any preallocated extents in futher patches.

The Merkle tree is the only data XFS will write. We don't want XFS to
truncate any post EOF extests due to existing preallocated extents.
Therefore, we also need to disable preallocations while writing merkle
tree.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_iomap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index b5d70bcb63b9..52c41ef36d6d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1941,7 +1941,9 @@ xfs_buffered_write_iomap_begin(
 		 * Determine the initial size of the preallocation.
 		 * We clean up any extra preallocation when the file is closed.
 		 */
-		if (xfs_has_allocsize(mp))
+		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+			prealloc_blocks = 0;
+		else if (xfs_has_allocsize(mp))
 			prealloc_blocks = mp->m_allocsize_blocks;
 		else if (allocfork == XFS_DATA_FORK)
 			prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
-- 
2.51.2


