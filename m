Return-Path: <linux-fsdevel+bounces-10818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1984E866
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1091D2949A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA873F9CA;
	Thu,  8 Feb 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TAhR2aeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829625634;
	Thu,  8 Feb 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418178; cv=none; b=Ek5xibD5ebuoaITrFAhKuU1azeoOi5TEcx6IlytFjXMbgofs5IkklisuPA6UJR25utJ2LFHKM539yvKZrrgELWQ1OAd6mhWyb+1n7NXZqhJeLLQyOkMvt6ALCn80Po4W/aEe8cuDqmFi/xvO0etuEYA6L/4mgjMjraC391mdoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418178; c=relaxed/simple;
	bh=3qwtk0TzM3yqkpdWTkMn8G1D7Yvm6JJDP82nQNcfpzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdHb3WzvT7aVq+5nmlb7miLkhblJvZib0QY1ssaDyvLWy7WeQD+RvH1oaVR1hONV57+QXNP3P0+6S9vRcg4f6J7+Rrzc4geuprWleqWo27mmw9s0IpP2sg85QI0jM+LIN6F6Bpd8roO2j7jhHTwXMWZTvzaKm8CUvRYkC6/skT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TAhR2aeh; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707418167;
	bh=3qwtk0TzM3yqkpdWTkMn8G1D7Yvm6JJDP82nQNcfpzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAhR2aehSVIy+7kxOHR6NVnmGYlp9kd5ycnTSBAI6hceetyhQOWUUfcm/nFiep+a1
	 kEkco0j8ZB4aI7AGUsK7I6wOE9xdzR/fBQB/pGe+tbFE1K6mzmAeXB5d7S7zA0bRWj
	 ip3Ju2dZR0HVfK7H2Y2FckrBH/MiPVeZX1zh4NiDcc1BLONE3/lFUOu67rYwA1XBw6
	 zqyIy2GXXYMOivh7iSp4mwMGUu1002g4dcG4icNksUO16LHayffi2x7O5HtglehPmp
	 B5lutv1FF5uLG4qLTgKWQTdXfMpywAxesrzwZXGsCyTz/972b+6tAcEMA0N6RREPQK
	 fjRsnlrFyE3ww==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TW5ck5SmGzY2M;
	Thu,  8 Feb 2024 13:49:26 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 10/12] dm: Cleanup alloc_dax() error handling
Date: Thu,  8 Feb 2024 13:49:11 -0500
Message-Id: <20240208184913.484340-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that alloc_dax() returns ERR_PTR(-EOPNOTSUPP) rather than NULL,
the callers do not have to handle NULL return values anymore.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: dm-devel@lists.linux.dev
Cc: nvdimm@lists.linux.dev
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2fc22cae9089..acdc00bc05be 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2124,8 +2124,8 @@ static struct mapped_device *alloc_dev(int minor)
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 
 	dax_dev = alloc_dax(md, &dm_dax_ops);
-	if (IS_ERR_OR_NULL(dax_dev)) {
-		if (IS_ERR(dax_dev) && PTR_ERR(dax_dev) != -EOPNOTSUPP)
+	if (IS_ERR(dax_dev)) {
+		if (PTR_ERR(dax_dev) != -EOPNOTSUPP)
 			goto bad;
 	} else {
 		set_dax_nocache(dax_dev);
-- 
2.39.2


