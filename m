Return-Path: <linux-fsdevel+bounces-13719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAC8731EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF78C1C21CD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513925F49A;
	Wed,  6 Mar 2024 08:55:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D2564A;
	Wed,  6 Mar 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715350; cv=none; b=i6y3JaaGQ8WxvFwt2OYO9jTamFemfUj24HAgnbywjCBgAvt6OPcIos8YxAhVWcX0zrq+7oSrRjje71zd5UzCn/4SYg0Jvnf6LZZAnPXYckD9RTPVG5a/rikwj+e9gKXIBLemq/y1dYZBwBvTFFqyyYzGqNEgJNAvW1fMaMENeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715350; c=relaxed/simple;
	bh=rOOuSh+1eZIFPiRqy8Z4jjiN4PmFYfqaD61RmkKO4sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OmGHGC5JyNIGuIxyXMT2ELhvy/CsB4eM+Nfrr3K3im95TpuDznGHMzMP15sxNCF7SrJldJYwZK52eGn7+sp3apuiosru35yTa5pz/HkU17oH5OP9g7AULj+A6li/YKB4mbMDDMzr0w5XLN+rx4yYE/dTIojaDM+oAUhr5IM3yns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-8a-65e82f7feb03
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
Subject: [PATCH v13 22/27] dept: Record the latest one out of consecutive waits of the same class
Date: Wed,  6 Mar 2024 17:55:08 +0900
Message-Id: <20240306085513.41482-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSaUxTaRSG/b67tlpzp0PiFU00dUskoEyEnIlL0Bj9TNwSxj+aqDdwR8oU
	NK2iqAQUUERB0UBRcGSzNsC4tDIwDji1bMUFGSWKBogQFCotKNrOFIjaavxz8uQ973l+HZ5S
	W5lgXpu4X9YnSjoNq6SV7mmloalLhuSlPW/mQd6ZpeD5mEVD8Y1qFjquVyGovn0Mg7N5PTz3
	uhBMPHpMgTG/A0FpXw8Ft1t6ETSYj7PwdGA6dHpGWWjLP81CevkNFv4dnsTQXXAeQ5VlEzw4
	V4bB5hukwehkociYjv1jCIPPVMmBKW0B9JsvcTDZFw5tvc8YaHgZAhd/72ahvqGNhpa6fgxP
	7xSz0Fv9mYEHLQ4aOvJyGPhjpIyFYa+JApNnlIMnthIMNzP8ohMfPjHQmmPDcKLiFobOF38j
	uJv1CoOl+hkLjR4XBqsln4Lxa80I+nPdHGSe8XFQdCwXwenMAhoyuiNg4v9iNupn0ugapUiG
	9SBp8JbQ5H6ZSP661MORjLsvOVJiOUCs5sWkvN6JSemYhyGWylMssYyd50i2uxOTkfZ2jjgK
	J2gy0GnEW4O3K1fEyjptkqxfsmq3Mu5xzQdmn3Pqodz+AZSGWhXZSMGLwjLxlb2c+s6Nta+5
	ALPCIrGry/c1DxLmitacN0yAKcGlFCva12Ujnv9RkES3d34AaWGBWPt+TaChEiLFwquF3Dfj
	HLHqpu2rReHPz46cZQOsFiLER+mlflb6O5958cX1JvztYKZ4z9xFn0OqEjSlEqm1iUkJkla3
	LCwuOVF7KCxmb4IF+V/JlDK5ow6NdUTbkcAjzTRVlGJQVjNSkiE5wY5EntIEqY6OD8hqVayU
	fFjW792lP6CTDXY0i6c1M1Q/eQ/GqoU90n75N1neJ+u/bzGvCE5D5ui89453yyPjY/45/Eum
	fWX9tcjNs1fvCabeeULX7Lgc3lzQ9MORq6eGyrIGK2pD+tZxRVLtmKU5h9nZchTZ3Lf+nOXb
	snH3f16H4Z7DScA1ak2Nj7njStHtCqmIOp56Misl6f6vw89rtkXrV8YXXnh7ZZG89kqE8cm4
	6+HrhU0b2jW0IU4KX0zpDdIXRHFUWkYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/7lqvDkjwkUYy0MCqFjJduRFT+CQr7UFIfylMecuSltjIX
	XaytME1N8ZaaeJlLdGZNu6uYo5VFZil2m5ZjlSMvpW61tIsr+vLy43kefp9ejlTm0XM4dcJh
	SZMgxqkYOSXfukq/5NSyASm0/74fZF8IBfd4KgUl9WYGOq/WIjA3nibA9SACXnoGEUw8fUZC
	QV4ngvL+XhIabX0ImqvPMNDlnAHd7hEG2vPSGdBX1jPw/PMkAfb8HAJqLVvgycUKAlq9nygo
	cDFQXKAnps4AAV5TDQumlCBwVBexMNkfBu19PTRYL7fT0PxmMVwqtTPQ1NxOge22g4CuuyUM
	9Jl/0/DE9oiCzuwMGuqGKxj47DGRYHKPsPCitYyAa4Yp27mxXzQ8zGgl4JzxOgHdr+8haEl9
	T4DF3MOA1T1IQIMlj4QfVx4gcGQOsXD2gpeF4tOZCNLP5lNgsIfDxPcSZt1KbB0cIbGh4Shu
	9pRR+HGFgO8U9bLY0PKGxWWWI7ihOgRXNrkIXD7qprGl5jyDLaM5LE4b6ibwcEcHix8VTlDY
	2V1ARAbukq+OkeLUSZJm2dpoeeyzG2P0Qdf05EyHE6Wgh7I0JOMEfrlgvfWB9THDLxRevfKS
	Pvbn5wsNGR9pH5P8oFwwdmxKQxw3ixeFIc8CH1J8kHDr63rfQsGvEAqrCtl/xnlC7bXWvxbZ
	VJ41nMX4WMmHC0/15cxFJC9D02qQvzohKV5Ux4Uv1R6I1SWok5fuS4y3oKlnMZ2YzL6Nxrsi
	2hDPIZWfYp3sk6SkxSStLr4NCRyp8lcc/+GUlIoYUXdM0iTu0RyJk7RtKJCjVAGKzVFStJLf
	Lx6WDkjSQUnzvyU42ZwUFDpsOmnrP/FuZUvptun6HmHvjp6Za7zW/AD5uCXg5KINxvVVWeK3
	XkXupaiwnwO7364w1xW9Tr5cj0McpPGQxz5tH2XfODt100CJ/9xvvcGRjvlIt7P6uGZPYC7X
	kp1eZUyZ1Wj4Ul4Z4Ay0BY/eXBKxOCPGPOZqKhV3Jm6/qXuporSxYlgIqdGKfwD78fKUKAMA
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
index 1b8fa9f69d73..5c996f11abd5 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1521,9 +1521,28 @@ static struct dept_wait_hist *new_hist(void)
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


