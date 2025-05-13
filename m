Return-Path: <linux-fsdevel+bounces-48849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4455AB51AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225FA7B8DC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40EB2690F0;
	Tue, 13 May 2025 10:07:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E59025228E;
	Tue, 13 May 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130878; cv=none; b=tyOYIt5NFtMzLbwwCWH1jlkqv+vwOXuhwv130gxzPz5Ofa0Yhz1EZIkPjJM2TrG+lDm1BMiIazl656N9m6a5iF4BsF3UDVou+WZDqzkYEyiTdS4APBXY+ukbCoDMYEZ+b/rDPynHW4I87uBHtUjkqbon8K+nHpoGUmu1RKQ/9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130878; c=relaxed/simple;
	bh=Tt5fY0uAKrgzU+Mw+IpqvXF4Smt9wx8k6PcTCp/EFPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jKcP6wVIRY1eMOG/PKALfDjN0jPrwZJazc6X2iU98HlkIa+uhmtSk/Y8w3LNN3/Xx/2sg3IcwoDEPotuVyyj1+FWt8pEZt6LC7oTuHl6Lr5rFWSRm1+reGHK1ci1YB/0QO79dVtT0iGO27RRiSK5C24P5vwq/t6OlvJTLyvnAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-7d-682319ef0224
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
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v15 12/43] dept: record the latest one out of consecutive waits of the same class
Date: Tue, 13 May 2025 19:06:59 +0900
Message-Id: <20250513100730.12664-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG/b/3VmvedERfwIxZQ4wsOCtizvCSxX3Yf94TEzMhuHXjdW0G
	BYuAmJCAAoNyGbIAys2CriAt0hWWoROHRYuMDEFKRYcobBoJlyaFVlGYthK/nPzynOc8z5fD
	kXI7HcRptCdEnVYVr2CklHR6RV24K3CdelP+7CrwzOVRUN1iZqD/igmBuS2LgInbX8B97xSC
	13/fJaGirB9B3dgjEtrsowg6Gk8zMPjfSnB4XAz0lBUwcOZiCwMDkwsEjJSXEmCy7oPHxmcU
	9JbUE1AxwUBVxRnCN54TMG9sYsGYGQrjjZUsLIwpoWfUSUPHw4/hfO0IA9c7eiiwt48TMHit
	moFR8xsaeu13KPAWB0P/2SIammfqGZj0Gkkwelws3Os0EGA3rAJLti8wd/Z/GrqLOgnIvfQr
	AY4HfyC4kfeEAKvZyUCXZ4qAVmsZCa8abiMYL55mIadwnoWqrGIEBTnlFGSPRMLrl77mmjkl
	ZF2wUNC86ESf7cDmWjPCXVMuEme3puFXniEGd3gNFP6rXsBXKx+xOPvGQxYbrCm4tTEMX7w+
	QeA6t4fG1qZ8BlvdpSzWTzsIPNPXxx5cEy3dHifGa1JF3Sc7v5GqHS0vqKSny08aSg10Jrol
	0SMJJ/BbhK7CXlaPuHfc5Irxywy/Xhgenif9HMB/JLQWPaP1SMqRvHO5cL/mAfL7P+BVwmR5
	gt9D8aFC6dlO1s8yfqsw731CLsWHCCZL5zuW+PTFhj7Kz3I+UigxmCh/psBXSISSXyzM0kGg
	cLNxmCpBMgNa1oTkGm1qgkoTv2WjOl2rObnxu8QEK/J9lzFjIaYdufsP2RDPIcUK2Z2JtWo5
	rUpNTk+wIYEjFQGyrN99kixOlX5K1CV+rUuJF5NtKJijFKtlm71pcXL+e9UJ8QdRTBJ177cE
	JwnKRFzwalssjtj2U9Wu8L603Nh/a2sy8ocirT2zx5ybo45c/q078elYQ8g1xzm9Z++6w5Vh
	OfuVtkD38bWCfmGg200OxFTu0XS9nEkp/HP77ox/juY2B0XcNR346tPFxGPfbogWf771uUW7
	Lapg64fBX1aPJT1ec2Su7SqvbJOdz/8xPK8gQkElq1XKMFKXrHoLkMqe5lkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ/fXY5HGg+t4Sy2rJKpfbZ+zH89szEzZssfeqaHu1WHO1KN
	KZUfUauo0A9XcdrdqdxFibN0ipiTStEqFTWtH2d0j37izuafz157f97vz/ufD4N7VZFrGZX6
	pKhRC/EKSkbIdoelB0yt2ajcWjESDs7pSwSU1JgoaK82IjDVpWEw1hIFPdIEgvm373AoKmhH
	UD7Uj0Nd6wACa9V5Cjq/LoMup4OCtoIrFKRX1lDwfnwBg77CfAyM5l3wWT9KwJvcCgyKxigo
	LkrHXOMbBrN6Aw36VD8YrrpFw8JQMLQNdJNgK20jwdq7BW6W9VHw1NpGQGvDMAadjSUUDJj+
	kPCm9RUBUo4PtOdlk3B/qoKCcUmPg97poKGjSYdBq24V1Ga4rl74+ZuEl9lNGFy48wCDrk9P
	EDy7NIiB2dRNgc05gYHFXIDD3L0WBMM5kzRkXp2loTgtB8GVzEICMvpCYH7G1Vw6HQxpt2sJ
	uL/YjXZE8qYyE+JtEw6cz7Cc5uecHyjeKukI/nUFxz++1U/zGc96aV5nPsVbqvz5yqdjGF/+
	w0nyZsNlijf/yKf5rMkujJ+y2+k9vtGy8FgxXpUoaoIiY2TKrppfxPERzyRdvo5MRS88shDD
	cOx2zuA4mIU8GIrdzH38OIu72Ztdz1myR8ksJGNwttuT6yn9hNz+lazAjRcmuD0E68fl5zXR
	bpazodysNPgvy7HrOGNt0z/2cOmL9+yEm73YEC5XZyRykUyHlhiQt0qdmCCo4kMCtXHKZLUq
	KfDwsQQzcv2P/uxCXgOa7oxqRiyDFEvlr8Y2KL1IIVGbnNCMOAZXeMvT6l2SPFZIThE1xw5p
	TsWL2mbkwxCK1fKdB8QYL/aocFKME8Xjoub/FmM81qYiQ4qU97qeupbZ7BMQfuSxtOLMw/69
	P4uNOfqgM8v7cYctImizkSDv+l6XXm6I3rutJ/NLh7Av4ITd8J69GLNPG2Zv2LG43DfsyZBn
	UuPz6pLJ9MCoVXEfyizPt288MRKxOtSYYpuZk4YGz+0vuFFvNfSov2/q2PJoYKGypbyvt2aJ
	gtAqhWB/XKMV/gL5TXZiOwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The current code records all the waits for later use to track relation
between waits and events within each context.  However, since the same
class is handled the same way, it'd be okay to record only one on behalf
of the others if they all have the same class.

Even though it's the ideal to search the whole history buffer for that,
since it'd cost too high, alternatively, let's keep the latest one when
the same class'ed waits consecutively appear.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index fc1d9e8b28f9..211bafffc980 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1485,9 +1485,28 @@ static struct dept_wait_hist *new_hist(void)
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


