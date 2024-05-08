Return-Path: <linux-fsdevel+bounces-19052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A668BFA31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDD41F2323C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00118120A;
	Wed,  8 May 2024 10:03:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF37E112;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162583; cv=none; b=piBPXgSHtEjyhJvUogaIomr16okazvH8pUeBn0OiAdXG4UsGHPMJ8InArKE/7MUM/pvGj4WyaOA6d2PQl8Y1X7dr+r8Yz6mPlqa2u+Ir9NmAtQy4Z3lFa6+gV6Oxwdnv6Z2yuH1IiYLts+yZVKX9q2jOclGSMY2DfDG7c9w9BdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162583; c=relaxed/simple;
	bh=ZLEyWKfOkPzCqlC7ygciF1YyeE2AYJ+O8XuwZUZ166Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jqnorG5oFJkvai4l7DUKGB92hAnYhDty5RHXA2jBVw8t75280aR4u2Tw+Na9jlehlyGNdLoul9pT9U1+fW1rKv7j2s2UpYzhy2EUvezvLMNLaaxvCJMN0U0tWCuzCnqZqZuAa037dXm1XDErsgBJjOeuPkXPNq6lOUsrvGhxTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-b5-663b4a39aaa4
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v14 10/28] dept: Record the latest one out of consecutive waits of the same class
Date: Wed,  8 May 2024 18:47:07 +0900
Message-Id: <20240508094726.35754-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2Sf0iTeRzH+36f7/PD5eJhLXzS6LpRCUn2y+pz1kVwdPdQCEV/BN1ZjXxs
	q/mDbWoWxcppZi0sUC+VUqu11LtsWqipLMOlSbpypJZZSZxnbQp6Gy2lbjPqnw8vPp/35/XX
	m6MUd+lITptqlPSpap2KkRGZN7xyZfz2TcmrbwwSuHh+Nfj+yydQfruWAdffNQhqG05hGOv4
	Dfr9HgTTT3opKClyIah8+4qCBucwglbbaQb63s0Dt2+Cga6icwzkXLvNwNMPMxiGii9hqLEn
	QHdhFQZHYJRAyRgDZSU5ODj+xRCwVrNgNS2DEVspCzNv10DX8HMaWl/EwOUrQwy0tHYRcDaO
	YOhrLmdguPYLDd3OTgKuixYa/hqvYuCD30qB1TfBwjNHBYY6c1CUN/WZhkcWB4a863cwuAfv
	I2jLf4PBXvucgYc+D4Z6exEFn252IBi54GUh93yAhbJTFxCcyy0mYB5aD9Mfy5mtP4kPPROU
	aK7PElv9FUR8XCWITaWvWNHc9oIVK+wZYr1thXitZQyLlZM+WrRXn2VE++QlVizwurE43tPD
	ip1/ThPxnbsE74zcK9ucJOm0mZJ+1ZYDMk3h+16UPjb36JOmcWJCj8IKUBgn8HHCg+oR8p1v
	DaAQM3y0MDAQoEKs5JcI9ZZ/6BBTvEcmXO/5NcTzebXQ3OifzRN+mXCz7SMOsZzfIJS/L6O/
	On8Qauocs56w4H5wdHw2r+DXC/dzStkCJAtmvnBCv7kTfX1YKDywDZBCJK9Ac6qRQpuamaLW
	6uJiNdmp2qOxB9NS7ChYJuuJmd8b0aRrdzviOaQKlzsi4pMVtDrTkJ3SjgSOUinlHWc2Jivk
	SersY5I+bb8+QycZ2lEUR1QR8rX+rCQFf0htlI5IUrqk/3bFXFikCSUl5o0uNen2CbYE90vl
	YWUP1/f66tozUcZ1WJm2eM/xaKfXMOmy/BEzFb7A8zRjW8uJe1JT7C8B1a4dVfDj3cF5cYs0
	8RnKwMK6GNJLpxQ3rNrU7E3I6ks7mTlFtm1pT8+9UxnuzO8/2705IpD4syXQEWVSaJxFc+uM
	xiUbl59UEYNGvWYFpTeo/weHkxoESAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0zMcRzHfb+/f3fH8dtp/NSIG2MitRUfiuGBflj+PMDmiX7jl26uw11/
	ZFi5K0m1zpyjQsqu1FHuPEi5pFacJlFLWjXyt1zXhuuPy58u8+Sz197v916PPhJCYab8JSpN
	gqjVCGolLSNlOyL0K9dui4gNcRlWgDE7BDw/MkkorLTS0Ha3AoH1fhqGgaYoeD3iQuB9/oIA
	s6kNwc13vQTcb+5D4Cg7S0P7h5nQ4RmmwWm6QIO+pJKGl18nMPRcvoihwhYNLXnFGOrHP5Ng
	HqChwKzHk+cLhnFLOQOW1CXQX5bPwMS7UHD2dVLQeM1JgaM7CK5e76HhocNJQnN1P4b2mkIa
	+qx/KGhpfkpCmzGHgjvuYhq+jlgIsHiGGXhVX4ShyjBpy/j+m4InOfUYMm7dw9DxphZBXeZb
	DDZrJw2NHhcGu81EwM/SJgT9uUMMpGePM1CQlovgQvplEgw94eAdK6Q3ruMbXcMEb7An846R
	IpJ/VszxD/J7Gd5Q183wRbZE3l62nC95OID5m988FG8rP0/ztm8XGT5rqAPz7tZWhn96xUvy
	HzrMeFfAflnkIVGtShK1qzbEyOLyBl+gYwPTTzx/4CZT0RNpFpJKODaMe3y7C/mYZpdyXV3j
	hI/92IWcPecT5WOCdcm4W61bfDybFbia6pGpPcku4UrrxrCP5exqrnCwgPrnDOQqquqnPNLJ
	/M1n99RewYZztfp8Jg/JitC0cuSn0iTFCyp1eLDuSFyKRnUi+ODReBuafBfL6QljNfrRHtWA
	WAlSzpC30RGxCkpI0qXENyBOQij95E3n1sQq5IeElJOi9ugBbaJa1DWgAAmpnCvftk+MUbCH
	hQTxiCgeE7X/WyyR+qeiTOFMSfCfOKMqa8XonI+nvldR/frF1cmmqMzrbxfE722JDvKwlfcc
	ge+HNq1d3x5ZWaP+ZXyU4K3NXe8ecuYELly2fdaVyLAM+aWQRaR72SxNZ9jMeZf25Fk97jMh
	nTV9MVdDpW7T5tGtVfO9ErPn+LOdMbuz/e2lFr/B0AAvdyNISerihNDlhFYn/AXpFhxPKgMA
	AA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The current code records all the waits for later use to track relation
between waits and events in each context. However, since the same class
is handled the same way, it'd be okay to record only one on behalf of
the others if they all have the same class.

Even though it's the ideal to search the whole history buffer for that,
since it'd cost too high, alternatively, let's keep the latest one at
least when the same class'ed waits consecutively appear.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 8ca46ad98e10..2c0f30646652 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1497,9 +1497,28 @@ static struct dept_wait_hist *new_hist(void)
 	return wh;
 }
 
+static struct dept_wait_hist *last_hist(void)
+{
+	int pos_n = hist_pos_next();
+	struct dept_wait_hist *wh_n = hist(pos_n);
+
+	/*
+	 * This is the first try.
+	 */
+	if (!pos_n && !wh_n->wait)
+		return NULL;
+
+	return hist(pos_n + DEPT_MAX_WAIT_HIST - 1);
+}
+
 static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
 {
-	struct dept_wait_hist *wh = new_hist();
+	struct dept_wait_hist *wh;
+
+	wh = last_hist();
+
+	if (!wh || wh->wait->class != w->class || wh->ctxt_id != ctxt_id)
+		wh = new_hist();
 
 	if (likely(wh->wait))
 		put_wait(wh->wait);
-- 
2.17.1


