Return-Path: <linux-fsdevel+bounces-77440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ26OOr3lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFE3151CA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CF313047BF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE822D781E;
	Tue, 17 Feb 2026 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/0OGFTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199B254841;
	Tue, 17 Feb 2026 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370440; cv=none; b=FJ2GkydNFfhUkzIeNQJNc0He/304GoMOtJTk2jhD9bV6QbgJtBpPHEXIbj+o9orlj6T91W1kbiZSrvuyvZ3GjpyEXKR/9GzviTDMMCgbvDzwiEywtbnFjgq/EdFhvxg1myDGX/RIiWqViPBvqfqZyEliwGOiETTbVEYV+GsL5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370440; c=relaxed/simple;
	bh=OPNq6NDl/+c2IRnQWtgkPsQdDU8h+PpEsmXTNTpwnxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5iHIDwyn9WJVcdgXV5lcMdRU7D+VJas9xFrGN7qU1xk4wDTzBPYzFcDX5LZ1ECeK806mFlcwCO4Ch8Y2rf7ZfH061H6P4Jc9QbhMqraJM0r8J19S1jXHwFL6IzzrfqMWg5vfAre2KkTBuzsX4MCXhAZAn0V2l7ndN0YtgRoMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/0OGFTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C16BC4CEF7;
	Tue, 17 Feb 2026 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370440;
	bh=OPNq6NDl/+c2IRnQWtgkPsQdDU8h+PpEsmXTNTpwnxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/0OGFTz3bwV1TIQKKgA2NrZTOdYbYPS0JnEplYZbYKOPVEuyTT094+NgKk5JEFES
	 l5v0M/4NJlnCdPOuRFtm0qbUdFauCDMeA4S9xXRX/Bta03H5bcvF9YzynB2H/tPpM0
	 HoEKxWBr58xZdsONmYl+5QljQMFFUEd2C13nYvg0j8wDzhys+Tv54Sh49ZpR4RjNpe
	 kqODWHaz7TkiSX7mbjR4BIlIXRlGBxdgxXbO+NBiQTp+CE+/RfJbRIiQL4vorPkQmu
	 XsPYzxssOIQqIl4Et77wmUAG/i7lOnjmBVzZC4WrWwIpaHSBVA3cH3388QVtkkVYuu
	 orOS63kst6i5Q==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 03/35] fsverity: add consolidated pagecache offset for metadata
Date: Wed, 18 Feb 2026 00:19:03 +0100
Message-ID: <20260217231937.1183679-4-aalbersh@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77440-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AFE3151CA5
X-Rspamd-Action: no action

Filesystems implementing fsverity store fsverity metadata on similar
offsets in pagecache. Prepare fsverity for consolidating this offset to
the first folio after EOF folio. The max folio size is used to guarantee
that mapped file will not expose fsverity metadata to userspace.

So far, only XFS uses this in futher patches.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/pagecache.c    | 6 ++++++
 include/linux/fsverity.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index 1819314ecaa3..73f03b48d42d 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -56,3 +56,9 @@ void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
 		folio_put(folio);
 }
 EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);
+
+loff_t fsverity_metadata_offset(const struct inode *inode)
+{
+	return roundup(i_size_read(inode), mapping_max_folio_size_supported());
+}
+EXPORT_SYMBOL_GPL(fsverity_metadata_offset);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 16740a331020..278c6340849f 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -214,6 +214,7 @@ bool fsverity_verify_blocks(struct fsverity_info *vi, struct folio *folio,
 			    size_t len, size_t offset);
 void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
+loff_t fsverity_metadata_offset(const struct inode *inode);
 
 #else /* !CONFIG_FS_VERITY */
 
@@ -295,6 +296,12 @@ static inline int fsverity_ensure_verity_info(struct inode *inode)
 	return -EOPNOTSUPP;
 }
 
+static inline loff_t fsverity_metadata_offset(const struct inode *inode)
+{
+	WARN_ON_ONCE(1);
+	return ULLONG_MAX;
+}
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct fsverity_info *vi,
-- 
2.51.2


