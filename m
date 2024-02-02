Return-Path: <linux-fsdevel+bounces-10104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B7847B37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544A61C21907
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A21332B8;
	Fri,  2 Feb 2024 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="stqve+V0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589D12F395;
	Fri,  2 Feb 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907635; cv=none; b=odYB93mgAIBFydgpYPIO1P0krWxK6REUtrtkdejav/k9frVV4RGe/ehpGLpiTolLpqc+0PkYlkAGhXv1O57D9lJDFOR2BIm/ny1i1W+dVFBQi60u48HBO3Ziz0OD+U19YSeduI3Tll8wqShNrxviFBcDp4Z7LfATaqeLt5Sak18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907635; c=relaxed/simple;
	bh=3qwtk0TzM3yqkpdWTkMn8G1D7Yvm6JJDP82nQNcfpzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYkwSXhFTeuoTqETJ2Q/N5WsqmwW3eMpdjUgpUy3G1YuVsj73YYcR7E4svhKsxpeoqrOeCHwXtDw2GX/26dS8r4lYY1jrniQakiQzLCkBhxpJFvK19fPyg4QWqckB2ipDYZaqxWx3Ok2fVqZ5S15K3GZFj/Q2FpaJZe6u6j6ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=stqve+V0; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706907631;
	bh=3qwtk0TzM3yqkpdWTkMn8G1D7Yvm6JJDP82nQNcfpzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stqve+V0iP+i7A8cWyEdeR/J0+TFtioEAeqXubDQfNrggDawyuTqMyi7DlnWDbJPW
	 iDOy+p1MQzxotedzOUguk4h94qZrEA0AN7mjmuzZ7X9J6dE3YIgS9yNly8YeiJOzGM
	 aE02qMnnDQ2TWTEIqq0WhcRJylZzNF3EBqhM9xwgiCTZuXtmJxPxi/59mJrN+FJJS9
	 iMUPk/3CUQifwg8kFZnYAe8PayUfUzpS9yBrCAjw9+zgkOAWJzl1Hsfmh4xylcg2sf
	 DyIb2UVO9CL+zPup7gMxuA3MqBvmsHTIUEuxKr01Euu+/TTDdIo2T9pudSkFGCgQor
	 3SRQF2RTqGK/Q==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRSpk6BX1zXBy;
	Fri,  2 Feb 2024 16:00:30 -0500 (EST)
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
Subject: [RFC PATCH v4 10/12] dm: Cleanup alloc_dax() error handling
Date: Fri,  2 Feb 2024 16:00:17 -0500
Message-Id: <20240202210019.88022-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
References: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
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


