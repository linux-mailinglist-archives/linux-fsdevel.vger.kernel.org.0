Return-Path: <linux-fsdevel+bounces-50062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC75AC7D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD5A16B3F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE92918DA;
	Thu, 29 May 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CEYFtCRm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BA62918D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518457; cv=none; b=uDRK/fzreSiRPZT4JnoXAUKqheQ2wMA/rZtGpitWa65+SZamE8wJXJpPTbnPfZ/hWvRXiHSV3biMGReZlQt8L7ffLudy97hTvUBskVOer3r4oTLVVjF4aYc9ztFdp7t6X3XYwsNyiFy/K50fAoL5SmGLg4mmZ99puMuDXseQ1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518457; c=relaxed/simple;
	bh=irxrtV/yKjRKlPlTMXRPvB9A/FA9Cryd9Ii1gmgTGZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=IL3d3k6YbEbNodnluleQGUW2RV6uruVpmRFeVbNaE5izUWIfonkESGmI3NLEQLe80ci1HWMjcbTITY2LIj6PNnbvNXGUogTioYBV2GqRKSW/6BwUaWVG7QLU4jpXFCVvc+bbhXmoMk91DP6W0MrUazFqRW737mmH6jFkMmiyO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CEYFtCRm; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250529113413epoutp011df8449c48eb4671058d0576afe682fc~D-ET0H9Pg2482824828epoutp01X
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250529113413epoutp011df8449c48eb4671058d0576afe682fc~D-ET0H9Pg2482824828epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518453;
	bh=J0bOkMsxx+My3P3fA0s0LpJACRCKsJ2melVHzlSN380=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEYFtCRmoON3oqtAmtTl89xrnD9rjjbk4fAzQYVJoQTs/U6and5rG63wZlY5YUcho
	 yL1Jh8YvOR/yPzxKsQ5HGjkzdjTq95KjH2SnbuadHPPxo/FZtFnzoaHrx9/GTqR94q
	 5qB51aXv4b13IUDct4L5NjkfggYZjwe4m3dZLXU4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250529113412epcas5p11973dd81c97a15f05e9778c52c0c7e24~D-ETHsjcv0283302833epcas5p1r;
	Thu, 29 May 2025 11:34:12 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.179]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b7PQq3CRXz2SSKX; Thu, 29 May
	2025 11:34:11 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250529113302epcas5p3bdae265288af32172fb7380a727383eb~D-DRa_6-80440004400epcas5p3l;
	Thu, 29 May 2025 11:33:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529113302epsmtrp2d54317629504c1808562ac7d68203cf8~D-DRZcoft3187631876epsmtrp2F;
	Thu, 29 May 2025 11:33:02 +0000 (GMT)
X-AuditID: b6c32a52-41dfa70000004c16-4b-683845ed4ad1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.92.19478.DE548386; Thu, 29 May 2025 20:33:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113258epsmtip2aafd700ab400e6f72cbda5b4e089c4e5~D-DNkrXA42194921949epsmtip25;
	Thu, 29 May 2025 11:32:57 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH 11/13] gfs2: add support in gfs2 to handle multiple
 writeback contexts
Date: Thu, 29 May 2025 16:45:02 +0530
Message-Id: <20250529111504.89912-12-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjHfc85PedQqR5rlddLZKk2cQ2gBCFvvMAWs3lC/DCJojEaqXKk
	SFtrK4jGC4I4bTZlIkIvam3kWqAbIsLOplhAQQQphMQmw4kpohBRi4iKhVFwid9++d+eLw+N
	i/uIhXSy5iCn0yhUUlJI1DRIg0OHfkDKlYZWDNVU8hSyOMpJ1FFpByi7boJAmTk+HNl7zpNo
	sMELUGteG4aqO2PQ664aDNnd5QBV33sCUJdnFuLzxwXIXV+HoVJ7E4bM+VkY8jhMOLr5bkSA
	Om0b0F9/txDoSfmEAHXUtwrQ45w+gJ7zf+BouPAUhe4+OEMh7+XJkUe++wI09sFCfreEfWCD
	bJ2ph2JvlMjZrrZUtqrsLMlWeS9QbHPBGMG+uGEELG8dxljenUGy7a509vXtbpI9V10G2Dzz
	CfahtZFiSy65sJ/E24VrEzlVchqnWxGdIFQOnD5Nan+fmV6cc53KAHcDDICmIbMKDpbiBiCk
	xcwtAJ/+00QZQMCkvhjyPXWCaZ4LS8f7qenQWwB9lb2Yv0wyofBD5ha/LmHcOGxvezhVwJlx
	APmBED/PZeKhsdCL+ZlgZLC/0Yn7WcREw3+tV74cCIbGztGpwwGTuu36CPCzmFkHC90VxHR+
	Dmwxeojp/WCYddOM5wDG9JVl+sqyAqwMzOO0enWSeo82PEyvUOtTNUlhe/arq8DUJ8jjakGR
	wxfmBBgNnADSuFQiyoyJUopFiYrDRzjd/l26VBWnd4JFNCENEi1VnU0UM0mKg1wKx2k53f8u
	RgcszMBArNvxMSIbi1jTEX5Sc8AuPT57V9b6qMgfecS7lgV/WqKK6zPez42VmmTDZrusoKQx
	ZfHqtKqS+ttBO4/Bb0cKjl6TO+Il1O6inubUdb0zNlrmC/ClmmHLe11Y/ordotwY3aHfwmsj
	94ZGJPvine2bfo5S9i8IrC4e+jOwJc7bIJ4Zos09H2jIMw8130qM/cb3edC1lTLFeBKosbaE
	bVvT8G2vuhvB8n1vgsyS9M5nlmjb+EZJ5EC2ZvT7T+5YReaE0Nzw2Zqy+ZfR9erypl5xyIFi
	d3LXHZk8QXtuzEPYUJHrzFXry9rcnb+a87qDLIeeb7koe1Ozo2LgpKtC1Ssl9EpFuBzX6RX/
	AbKoNU94AwAA
X-CMS-MailID: 20250529113302epcas5p3bdae265288af32172fb7380a727383eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113302epcas5p3bdae265288af32172fb7380a727383eb
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113302epcas5p3bdae265288af32172fb7380a727383eb@epcas5p3.samsung.com>

Add support to handle multiple writeback contexts and check for
dirty_exceeded across all the writeback contexts

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/gfs2/super.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index dfc83bd3def3..d4fdab4a4201 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -450,6 +450,7 @@ static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct address_space *metamapping = gfs2_glock2aspace(ip->i_gl);
 	struct backing_dev_info *bdi = inode_to_bdi(metamapping->host);
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 	int ret = 0;
 	bool flush_all = (wbc->sync_mode == WB_SYNC_ALL || gfs2_is_jdata(ip));
 
@@ -457,10 +458,12 @@ static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
 		gfs2_log_flush(GFS2_SB(inode), ip->i_gl,
 			       GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_WRITE_INODE);
-	if (bdi->wb_ctx_arr[0]->wb.dirty_exceeded)
-		gfs2_ail1_flush(sdp, wbc);
-	else
-		filemap_fdatawrite(metamapping);
+
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx)
+		if (bdi_wb_ctx->wb.dirty_exceeded)
+			gfs2_ail1_flush(sdp, wbc);
+		else
+			filemap_fdatawrite(metamapping);
 	if (flush_all)
 		ret = filemap_fdatawait(metamapping);
 	if (ret)
-- 
2.25.1


