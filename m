Return-Path: <linux-fsdevel+bounces-9673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565D844418
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107A528FE94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF09812C531;
	Wed, 31 Jan 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EB06hVwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340912BE84;
	Wed, 31 Jan 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718352; cv=none; b=cN37HzENRRdJ4aDAZc9VYVuyY22dQfTtayKZovoM+oRula9L9pNTRim+ZJUHLgHvcB4hUuUmv5s3FYma57KAjCeTwKxQTBJclAmuvdn4aJMJX84T44/e3+TATN2Pz94xqTndkIzX1a6DdeJns2b8rvUSZdEXXKwuUm4L9cSjCcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718352; c=relaxed/simple;
	bh=CfmY1KnEab9DsMrJbyvT5LgUiqxfD1jYSIdakS3IZw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbKcMQBSUrsR8rpHTTORn6IWF6PB+hFsj18Hgec8Gwumki0WjPbtREbt+BNoLCBnNQ42Fi3S6txHfuA9DXLWc4NH0Zjefg5moHlfkaAsqf4fNx9T33MXUYCLnDvCmFKbeu1X2x23U3ToE6Uz1PCCQznathcid6Ppi9FPvlMH0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EB06hVwq; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706718348;
	bh=CfmY1KnEab9DsMrJbyvT5LgUiqxfD1jYSIdakS3IZw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EB06hVwqH30Biu+iJCPUcv/terkIISNlE4G2KLYR9OPO6YHERtB+CQuC+sUJ11GiS
	 qanrhIUz9PaLQE+1Sfk0euf5aZEOnEh0ZmU+8GuZPFIs/dUfEpFpY4aR3hMNoQ0M4K
	 YjYn8N+vE1erhhgi+WRevsbvvXyXBUbecJrhzvF+suEsrIh0Is3m8q7H9EX/5wMjZ9
	 p0E0sTMQLq4kN8hV//trJ3mjwoImjOLdvL5YGOOOSyKl//9q9lix/RG3EaWChntvIr
	 cfkBAkZwRIFFgomMisFAqXV18H2U/8TgTzIZaM6+spiKRIWy+N1609kejZ5IMCInoX
	 m8KJF4ssXA/MQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQ6ph0mWTzVnx;
	Wed, 31 Jan 2024 11:25:48 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 1/4] dm: Treat alloc_dax failure as non-fatal
Date: Wed, 31 Jan 2024 11:25:30 -0500
Message-Id: <20240131162533.247710-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for checking whether the architecture has data cache
aliasing within alloc_dax(), modify the error handling of dm alloc_dev()
to treat alloc_dax() failure as non-fatal.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 drivers/md/dm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 23c32cd1f1d8..f90743a94da9 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2126,12 +2126,12 @@ static struct mapped_device *alloc_dev(int minor)
 		md->dax_dev = alloc_dax(md, &dm_dax_ops);
 		if (IS_ERR(md->dax_dev)) {
 			md->dax_dev = NULL;
-			goto bad;
+		} else {
+			set_dax_nocache(md->dax_dev);
+			set_dax_nomc(md->dax_dev);
+			if (dax_add_host(md->dax_dev, md->disk))
+				goto bad;
 		}
-		set_dax_nocache(md->dax_dev);
-		set_dax_nomc(md->dax_dev);
-		if (dax_add_host(md->dax_dev, md->disk))
-			goto bad;
 	}
 
 	format_dev_t(md->name, MKDEV(_major, minor));
-- 
2.39.2


