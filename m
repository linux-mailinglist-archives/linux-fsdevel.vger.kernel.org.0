Return-Path: <linux-fsdevel+bounces-78483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN1jOXRNoGnvhwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:41:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5951A6CB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 402F5316BE7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A354392C28;
	Thu, 26 Feb 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eYza4UBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12A3859F7;
	Thu, 26 Feb 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112891; cv=none; b=skVDrXx6Y0iMZBVBv6ejH1A9yzPihAtYmYlRHaaax0KH4PmrBnMoyJLtUmql5nwpI8N76l1waFTPnVqdm6WBV1+ze/IiAPENgfemm6gMbmPOapBoMR71zbRirmSeH/awrwO3+SWs4BdKoPRnqVDf4CG/aUM8acqRcMH4YKE93hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112891; c=relaxed/simple;
	bh=TlUQXYrnjSoaCbkHb1MVILPUcB5rWl72ygSzJU59jJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm6vlegyvBYhlU01H1YDjy++5HxtR97sVPWW42V7OFNmyvxb4wR9KgVSn927D9LRTSLuT9jO6z//3Sqp8GDvNhR5DWs3y2J7/KnMkq76IGrKDcdNf01cQXZ0PLTWIBqH7JcE4J4xlEfzVsXqN0EHKkXNFHIVxNP6F9MEsPUWCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eYza4UBR; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772112730;
	bh=wIAqc9ZjSWfa/F2Z89KnaSRh5o6S817igYSMsy6Yias=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eYza4UBRaVzP6QafQtmzd4Ou8+Lvsp3TceeLtja//jGOmPtr2TbDk12RlNj6uYKXK
	 acYeGLzYP0/9JVI4+NKtjYCGDnJ1Dg2ae6EFP84Zb53++PBIJDHYna7fZ5tr0UIdEa
	 PHDowcjlvycd1G4QE2Zb/ekQTJusC40IRXaWjiN4=
X-QQ-mid: zesmtpip4t1772112714t22e84ed1
X-QQ-Originating-IP: y4BUbQojiwAYU3AEeB9zl5yJkZDVNE3EZ4cRoAVfcKs=
Received: from uos-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Feb 2026 21:31:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1048834162358125244
EX-QQ-RecipientCnt: 6
From: Morduan Zang <zhangdandan@uniontech.com>
To: bfoster@redhat.com
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	Morduan Zang <zhangdandan@uniontech.com>
Subject: [PATCH] mm: fix pagecache_isize_extended() early-return bypass for large folio mappings
Date: Thu, 26 Feb 2026 21:31:49 +0800
Message-ID: <3F3A46783F8E9D52+20260226133149.79586-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20240919160741.208162-3-bfoster@redhat.com>
References: <20240919160741.208162-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ODcDgdcDagQKK73kbnoKVnPAelgFd7Q6Mg6OyC7hgcKFpHFWBkzjjlmp
	g5Rq9T2TLhJC0skg/q0ul79P4ZzcquUzKn/uvFOZY11/U23Buz22qL+kBfJbNX/ll4YLmj0
	2zB4sAyugLaRRWWp4axXbr3I8NiqTWgTLX0nlkO7mZ4yivC45MMnCC+fFt9PaV0pW9gMlnz
	9uUS4prTcLH/EsvYUYJQ3uFTRJ3iSsHlY93b9mUXLgytGgbQMVksS7uuzYvwT7kn0XcRrpU
	yy/CWG609P3JZgd4z0cFs0e4jTTKePY9/Da0zpxUTOwOsYFSBodddq0D6JB1svxvcB2Rpm3
	uQdC2+RMqJKRY82HkXvPkaKPma8s5EqANcIUDMTBc0pT6Mtmu5YthikZOEQie0u0x49mWrW
	Tr+iv44nsnV2DqbEn9HCFvK4TrGH+VJb+rndyDgn/vZwJRxGuRsyEiN4FVgjOVX63GYLQ2p
	klBBDahAm0C00dBanm5HLp/DGP+XodoBy5PzQgLE4gAaZRMFaLwu0evWbND/gsQRbz4LzAw
	cWAmKcum8VbFW/mLo+XTAA4KE4GD02ufecukPzyzDdbwjP1WznIkOniXHsKrCFwa/AHxL4j
	CcCIxZ1bldViPLk223Zcpc/RxUR5GQOCgxWQ2xFw8lpKfnE1YfCHgXmWvsnyGSG1wHmPrWU
	l0iO83vJskwMJr5yD92dIu2TlEHl5/iVlyGyRGTRvX7AK5vrxY8NOYCDX0r9dcYQo14DC2Z
	gsoLWMslbMvwGFs3+KHAuQrsqq+kNAJ+3cXtvHS+vQdQOS4MJRC9htVepg/v1pkJjqiGJtT
	LXVhdLOsaAACn44UZHu7/fQNhS0EOYoX7PCI4dYFOoj4hu5MdkFo4YKxCyk13EnU5fvG4vK
	eGwMoq8p6DdOVH4pqdp0fx8LdfvuWMbSsUrgghp8WjmQ3sr9kPnPhdaIT4IgDqZP445jrGS
	C7oxVE8g3bNNaZTRyD34GCCgxfl0C2+bJeSaHJ8K67KdT/VmE2LbANPh7WOgnq3mEiWLIQ8
	rCIzBYnQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78483-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim,uniontech.com:email]
X-Rspamd-Queue-Id: EA5951A6CB1
X-Rspamd-Action: no action

pagecache_isize_extended() has two early-return guards that were designed
for the traditional sub-page block-size case:

  Guard 1:  if (from >= to || bsize >= PAGE_SIZE)
                return;

  Guard 2:  rounded_from = round_up(from, bsize);
            if (to <= rounded_from || !(rounded_from & (PAGE_SIZE - 1)))
                return;

Guard 1 was originally "bsize == PAGE_SIZE" and was widened to
"bsize >= PAGE_SIZE" by commit 2ebe90dab980 ("mm: convert
pagecache_isize_extended to use a folio").  The rationale is correct
for the traditional buffer_head path: when the block size equals the page
size, every folio covers exactly one block, so writeback's EOF handling
(e.g. iomap_writepage_handle_eof()) zeros the post-EOF tail of the folio
before writing it out, and no action is needed here.

Guard 2 covers the case where @from rounded up to the next block boundary
is already PAGE_SIZE-aligned, meaning no hole block straddles a page
boundary.

Both guards are correct for the traditional case.  However, commit
52aecaee1c26 ("mm: zero range of eof folio exposed by inode size extension")
added post-EOF zeroing inside pagecache_isize_extended() to
handle dirty folios that will not go through writeback before the new
i_size becomes visible.  That zeroing code is placed after both guards,
so it is unreachable whenever either guard fires.

The same stale-data window is also covered by xfstests generic/363
which uses fsx with "-e 1" (EOF pollution mode) and exercises a broad
range of size-changing operations.

Fixes: 52aecaee1c26 ("mm: zero range of eof folio exposed by inode size extension")
Fixes: 2ebe90dab980 ("mm: convert pagecache_isize_extended to use a folio")
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
---
 mm/truncate.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 12467c1bd711..d3e473a206b3 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -847,13 +847,32 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
 
 	WARN_ON(to > inode->i_size);
 
-	if (from >= to || bsize >= PAGE_SIZE)
+	if (from >= to)
 		return;
+
+	/*
+	 * For filesystems with bsize >= PAGE_SIZE, the traditional buffer_head
+	 * path handles post-EOF zeroing correctly at writeback time. However,
+	 * with large folios enabled, a single folio can span multiple PAGE_SIZE
+	 * blocks, so mmap writes beyond EOF within the same folio are not zeroed
+	 * at writeback time before i_size is extended. We must handle this here.
+	 */
+	if (bsize >= PAGE_SIZE) {
+		/*
+		 * Only needed if the mapping supports large folios, since otherwise
+		 * each folio is exactly one page and writeback handles EOF zeroing.
+		 */
+		if (!mapping_large_folio_support(inode->i_mapping))
+			return;
+		goto find_folio;
+	}
+
 	/* Page straddling @from will not have any hole block created? */
 	rounded_from = round_up(from, bsize);
 	if (to <= rounded_from || !(rounded_from & (PAGE_SIZE - 1)))
 		return;
 
+find_folio:
 	folio = filemap_lock_folio(inode->i_mapping, from / PAGE_SIZE);
 	/* Folio not cached? Nothing to do */
 	if (IS_ERR(folio))
-- 
2.50.1


