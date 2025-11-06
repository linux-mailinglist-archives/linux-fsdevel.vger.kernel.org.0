Return-Path: <linux-fsdevel+bounces-67376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC001C3D5BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 21:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA31D3A2923
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 20:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F99F2FD7CF;
	Thu,  6 Nov 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WyIIT4b8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772162FD68D;
	Thu,  6 Nov 2025 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460991; cv=none; b=ixUK3ZhkhG2P23I79kryx2imjVgk0F2QiZHsFUU6nt8k3iO0n7uebN8X6rARxDJn9UV3F3cvP20acBc21OVWF71ZlsQMgJboF99F90Fw/BXlIuoi4WUouneesixYoPhwjvAjiPRdcH3S5qaDfoHplkpokt3J3ky/wSnfFykvjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460991; c=relaxed/simple;
	bh=bbFUgFowN93OjJkpn+NxU2qlNKD2R+NiclY+wSoH+6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZK7+ETtMOtXFHvQRBF9pATVFFAGovscpLkEMvCnf9gYQ2vybOZeFk+H2k0dBM+y+wdsUILVoDlu74oOfpyoxh5ENnhyRK0ZnbB6605I/yE344znK4OgUW7waUWSUJ8rOHlXrxDQO1ay82Z598QoArZO8owZP/GVRPyg2nZWM6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WyIIT4b8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JQqNoNDV8HuO1pMnk/LZMyOeELzn0dq9sQSxUhLjMBo=; b=WyIIT4b8ABHZb5z8YXK4u/rh8H
	RkfHwD1iSESoKdnf6MtWbbQVRSrPn+3ncX15bulflP0HtxOBwqUpS2UzftwIr/9PSKvfwftCJYjEQ
	bK5p85vnPKL+L4KkEKzDiFLWVCp+weBQ8+4pgd8rcJXS+lBFBQqSwSOx+Op0kKTzvbvLBeanN59qg
	0wvA9leQp/JXdHb0z9i0rFQOVFX4sr7rsugUD6aFJOoFOLOAKFQV0GuK9MpUkGOcl0zm4SofnG1X6
	/+r8tpdh8SAEolXXUg1vzTcnJGMn46GtRIa/neBPKmzpE1ChvQtn6hPsWMUyhW2RTULMKN/qP846F
	Q26Pidgw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH6c5-00000009pyn-3g0B;
	Thu, 06 Nov 2025 20:29:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] gfs2: Use bio_add_folio_nofail()
Date: Thu,  6 Nov 2025 20:29:42 +0000
Message-ID: <20251106202944.2344526-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the label says, we've just allocated a new BIO so we know
we can add this folio to it.  We now have bio_add_folio_nofail()
for this purpose.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c4..233b3aa8edca 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -562,8 +562,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 			bio = gfs2_log_alloc_bio(sdp, dblock, gfs2_end_log_read);
 			bio->bi_opf = REQ_OP_READ;
 add_block_to_new_bio:
-			if (!bio_add_folio(bio, folio, bsize, off))
-				BUG();
+			bio_add_folio_nofail(bio, folio, bsize, off);
 block_added:
 			off += bsize;
 			if (off == folio_size(folio))
-- 
2.47.2


