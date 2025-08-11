Return-Path: <linux-fsdevel+bounces-57259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E814DB20079
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0666916B55C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5E2DA760;
	Mon, 11 Aug 2025 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJDS7pZ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3B18CC13;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897957; cv=none; b=oOfAGTurCypt6p9u86CBeAW4dtM198OoddkwvIasoSkB6wzL3E8q2Ez4F81GVRu6ZXbaDd4TIYBNfqpPwer3USoMNOR5pjTTVX2vNgNlvzKwaPaz1mP55sxqZpPeMit+ubvsAoWkweGpWRdc1b08TDDCYt76nQ2v5KFvDr6MglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897957; c=relaxed/simple;
	bh=mK6CJP6wXPdl6rvaIqsW3gkQFt5wVL75TLgzg9n7BVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K64yoBcPHZLsnHUHc0/GVWUopPPaPnc4S4ten6f+MVS9qNoNoN03HLGJfVsbW8/yvsQe+6AMXYKbsKHBdpVQxIDgEGMj5z1sknUBINv9Ted+nlkuctRrx4CyEE/ZzRpp0vJyX0pvsrd6/s+K03NC6fsakJ17UKcAseW8wcm7Ewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJDS7pZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F196C4CEF6;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754897957;
	bh=mK6CJP6wXPdl6rvaIqsW3gkQFt5wVL75TLgzg9n7BVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FJDS7pZ3Dd5o9CzfSfgqeMXjCSuQ2XZOV7FZZkXXawW8tlZBAIUjcavmwXs0RHRkK
	 Vp0NSL/rL/iaHiQnGJKdu6YEHnB+IzCrThYQO1JLpxyicFbieoTb8Sl/l0q5BegKtP
	 9kk/XIAO/GAgrOlxC9H+DcWUts5jRddWkGMa9W1LjDMXppv9z0qeTPAgvM8tZYDFPC
	 hQrDrYr1Y10xwkliknEo1OA3PYDzpwHfkmVlBosRhnKSCWVlYwfqyusnyqXZ/EyOfg
	 YkLGurowGAejqtM53pom18mgBp5lfNsmN/GpT/yFqwT8a1s4erDqa0+WyZ22iPuK2m
	 kg4ZfOQPzElQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE2C87FD2;
	Mon, 11 Aug 2025 07:39:17 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Mon, 11 Aug 2025 16:39:05 +0900
Subject: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
References: <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
In-Reply-To: <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>, 
 Christian Theune <ct@flyingcircus.io>, Arnout Engelen <arnout@bzzt.net>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2365;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=hZDuTLSkBIrbNvtG2nBE30QLrkf6x/91sVi7wfIoY/8=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBomZ4jPlqojv6vaPt93ZlypZLQsy3yk2wT3tyj6
 icWFXgHg5yJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaJmeIwAKCRCrTpvsapjm
 cPRkD/99SV5Af6iDJv4P7JOhmn3VChlwphgIm3/B/MNnzBf1jXsBZaCdyxliuJ0wzqyv5XM1hOR
 Bx0XvLSU8abfTNwB6m92a/wDMVm/VJzJe4LJ7XeRA9fZacSaBjs5xo9481418Y56j9ARNerELQA
 KMy8ktpDAoCcbw/a0PitGs+4lULLGNd4pXEj+iJ6TTndo/CFsza73PKqjCC7XCgD6KQZX+O80Vc
 3Y7Fq8YbToVUbq18aS+AvNyRbvS72bg4VlPodHSMxPGl/POs/vFPMobKnz3iDu9A0bkUuXDq58E
 QHFDNlnqrm8yOnXyD0rfsq1mvqpGIN2bY4NHqeBT1x9DNDQ6KDWwukj1AHdwJM13nxAgXgTR8gP
 SAjIDJ0pJEz7PFfmVvMWX8Hdg9DGuPNqDcuujs8hnKraPkBqv4UJe3d4I8+IE5qqnhKhIDrUTBs
 t/3zyXGLFdfrhpam3zxuxA5LdrX4HDF/sDiZ5PHb7fDHBlszz5oHW/5QAWzvEqymp6tgPowx0FV
 4jCRRMpNB11If1y9KJM1QyD9g6dcYgi0EZ5GOOGR/vealtNi1U5iENhsBvXNu+fVcOC6YAKtUhU
 9m0fuUJF7//Vdia6rl0SiLs4Cxtlaw2EhKJL49XOqpwro6uGWUfxDDlMnR713LMOxihT1MVFPXS
 SpzJgfLbIpBRWhw==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

It's apparently possible to get an iov forwarded all the way up to the
end of the current page we're looking at, e.g.

(gdb) p *iter
$24 = {iter_type = 4 '\004', nofault = false, data_source = false, iov_offset = 4096, {__ubuf_iovec = {
      iov_base = 0xffff88800f5bc000, iov_len = 655}, {{__iov = 0xffff88800f5bc000, kvec = 0xffff88800f5bc000,
        bvec = 0xffff88800f5bc000, folioq = 0xffff88800f5bc000, xarray = 0xffff88800f5bc000,
        ubuf = 0xffff88800f5bc000}, count = 655}}, {nr_segs = 2, folioq_slot = 2 '\002', xarray_start = 2}}

Where iov_offset is 4k with 4k-sized folios

This should have been because we're only in the 2nd slot and there's
another one after this, but iterate_folioq should not try to map a
folio that skips the whole size, and more importantly part here does
not end up zero (because 'PAGE_SIZE - skip % PAGE_SIZE' ends up
PAGE_SIZE and not zero..), so skip forward to the "advance to next
folio" code.

Reported-by: Maximilian Bosch <maximilian@mbosch.me>
Reported-by: Ryan Lahfa <ryan@lahfa.xyz>
Reported-by: Christian Theune <ct@flyingcircus.io>
Reported-by: Arnout Engelen <arnout@bzzt.net>
Link: https://lkml.kernel.org/r/D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me/
Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 include/linux/iov_iter.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index c4aa58032faf874ee5b29bd37f9e23c479741bef..7988a0fc94ad0525b475196035dc5d754fd3d117 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -168,6 +168,8 @@ size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2
 			break;
 
 		fsize = folioq_folio_size(folioq, slot);
+		if (skip >= fsize)
+			goto next;
 		base = kmap_local_folio(folio, skip);
 		part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
 		remain = step(base, progress, part, priv, priv2);
@@ -177,6 +179,7 @@ size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2
 		progress += consumed;
 		skip += consumed;
 		if (skip >= fsize) {
+next:
 			skip = 0;
 			slot++;
 			if (slot == folioq_nr_slots(folioq) && folioq->next) {

-- 
2.50.1



