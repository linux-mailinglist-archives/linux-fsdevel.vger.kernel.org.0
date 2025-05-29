Return-Path: <linux-fsdevel+bounces-50056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39FAC7D30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8973B4B27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482928ECD9;
	Thu, 29 May 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vETbCvxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BC28EA63
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518442; cv=none; b=MCgWtLogbQv/+EeGu1+zz+PKdsUyNxU4B2IZ9Opa2e7vGv7qiRLqLkm2viKhrdX+qkoC7Dpp1lFWypN5wJ2O8UIwwU6fuCjewu5m/VYTkCMEroWI8NNIjifK3RW5sXIKv/+3WpvCv1z8HxCruUnAldGf/UIzbHm+k3I6af3f7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518442; c=relaxed/simple;
	bh=OsW59tgZtg7NrMG5nvh2yWw0ClX2A4W4yG4NH7GNF/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sRwFWwEEuREa7Q4365OXRCbAPk5egEyTjIh9by+qmgD5etLXH7fmF6gpoU4Wk9vy7Xthu80YSW08WWS7fQD4EXnVpNRHua0rwPQnaUnaaMYBS+ugTcHH2vjN8QqW69D7kPdaQ8Bam9ZS/jVB4w7jaXbIpv5g2J2PrLaKauJEHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vETbCvxL; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250529113358epoutp03a147f50acc04e2749c2b704fd598e2cf~D-EF7aw3H1014110141epoutp03J
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250529113358epoutp03a147f50acc04e2749c2b704fd598e2cf~D-EF7aw3H1014110141epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518438;
	bh=YVQc/WM+0VBSsD0jrWzuyT5Fy00MAzbyaleiZXGhJOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vETbCvxLbscdz42m0xibxK80NvlHSGYC9nSQpC8t2DbiwrsklMr/U4RQh8cRySx4I
	 hc/zf7grx5CMxs7zvflWN5KJ77KxVVzZ8Wr9su3Fu6Ui/w1Yiq8xiPp+75XxG+mHD8
	 5WrBYDM+zcb2e6Mk5brslJAVtmDfqDmZhH4R2g0A=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250529113357epcas5p18de4e7caba809b6bb3565d3e9d982b40~D-EEvRK7r0737107371epcas5p18;
	Thu, 29 May 2025 11:33:57 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.175]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b7PQW2YF3z6B9m4; Thu, 29 May
	2025 11:33:55 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113236epcas5p2049b6cc3be27d8727ac1f15697987ff5~D-C5wJXZx2930829308epcas5p21;
	Thu, 29 May 2025 11:32:36 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529113236epsmtrp240a2f4a07bb2f63134e2af6d9c4e69f3~D-C5vFydm3187631876epsmtrp2R;
	Thu, 29 May 2025 11:32:36 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-ed-683845d494c2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.82.19478.4D548386; Thu, 29 May 2025 20:32:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113232epsmtip2bd1005fd88dc0a37d763985b112d9710~D-C15pB1S2452324523epsmtip2I;
	Thu, 29 May 2025 11:32:32 +0000 (GMT)
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
Subject: [PATCH 05/13] writeback: modify bdi_writeback search logic to
 search across all wb ctxs
Date: Thu, 29 May 2025 16:44:56 +0530
Message-Id: <20250529111504.89912-6-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjHfc+9JHXHKuEVFllqFEVl6tS8QQf6geyd0WTzLkbhhJ5xK0h6
	wCvjrsGaDJwBpFhBpAZaFMUKkooiijegatmCdSnaSPFGUqHivBUmdCZ+++X5/Z9/ng8PRypc
	VCCXmJoualIFtZLxo5quK4MX/BWFEhZ2XJuNms5aWHS8oZ5B98+aADrQMkahvGIviUyOIga9
	uj4MUGdJN4HMtkjk7mkikMleD5D5Zh9APf2TkaVslEb2thYC1Zk6CFRRlk+g/gYdiS6+GaGR
	rfondLn1DoX66sdodL+tk0YPi10ADVjOk8hjKGDRtbuFLBrWfy65571Fo4/vjjMrZ+C71RC3
	6BwsvlAbinu6M3Cj8RCDG4f/ZPHtYx8p/PxCOcCWKg+BLfYcBlsf7MHuK38z+A+zEeCSimzc
	VXWDxbWlD4hfFNF+K1SiOnGXqPk+ItYvoVAXnWaW7ekb7GRzQC+rBTIO8ktg82AbrQV+nIJv
	BtBd1AV84ltocbTQPp4K60afsb7QEIBvnI8ZLeA4hl8A3+VtHJ9P4+0ktHZ3TSyQ/CiAlpfz
	x3kqHws/PdGS40zxs6D+qJ4YZzn/I6zUmf+/IhiW2/6dYBkfAatrRiaOUHzOGOxnKF9+CrxT
	3k/5+oNh/sUKshjwuq+U7itVBQgj8BfTpJT4lLi0RWGSkCJlpMaHxe1MaQQTnxC67hI43eAN
	awcEB9oB5EjlNHle5LIEhVwl7N0nanbGaDLUotQOgjhKGSCfqT6kUvDxQrqYLIppouaLJThZ
	YA4xw78g4/Yzqb1jbVbSuZc/qPYfdZgoJSypzLI/9Qz22obWR1dkl4ItVY5VTkIVO5wUvrVu
	zilN8pxfLW/LfiN6ucUGoTfTJSz/3bb5iKE18F6rZ5NUO7Qy6qr1xIfw9EfyknNRs/H0rMzF
	+tX/FC43hhSZch7VvD+wC5EDn8JGrqgDd3w4rI2JOji2zenKfvE+yOmc0pWbuTtfT++o+UbW
	Mzd81en5nu+OHT6JXud6Hy6ZvmZw5DJVmlj+uOAEt9nluHlrqXHZvJOTcnm6OcRbqbFmXpIm
	abevKXgbdGbhNnfyBgcc8I+88bN1f4A6ZHJcRIDbkBRzJNK7z50fscFbKCgpKUFYFEpqJOE/
	V5BOyngDAAA=
X-CMS-MailID: 20250529113236epcas5p2049b6cc3be27d8727ac1f15697987ff5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113236epcas5p2049b6cc3be27d8727ac1f15697987ff5
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113236epcas5p2049b6cc3be27d8727ac1f15697987ff5@epcas5p2.samsung.com>

Since we have multiple cgwb per bdi, embedded in writeback_ctx now, we
iterate over all of them to find the associated writeback.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fs-writeback.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 9529e16c9b66..72b73c3353fe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1091,6 +1091,7 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	struct backing_dev_info *bdi;
 	struct cgroup_subsys_state *memcg_css;
 	struct bdi_writeback *wb;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 	struct wb_writeback_work *work;
 	unsigned long dirty;
 	int ret;
@@ -1114,7 +1115,11 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	 * And find the associated wb.  If the wb isn't there already
 	 * there's nothing to flush, don't create one.
 	 */
-	wb = wb_get_lookup(bdi->wb_ctx_arr[0], memcg_css);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
+		if (wb)
+			break;
+	}
 	if (!wb) {
 		ret = -ENOENT;
 		goto out_css_put;
-- 
2.25.1


