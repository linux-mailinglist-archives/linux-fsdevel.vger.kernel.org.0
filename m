Return-Path: <linux-fsdevel+bounces-17540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF378AF63C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 20:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC81F25D7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3643513E40C;
	Tue, 23 Apr 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m4+wTHPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3613DDAA;
	Tue, 23 Apr 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895519; cv=none; b=k9hHlDtIfA1pvZdvpJDDXL+TytanJi9urW9ZuMfIAodATxVOnrX0BRMobxTTUVcszabUwECATBQnsnxqiEaW5OZp9evfpk6posUzYvzNksTLiF7ka3V/mqp2C/eU2Zf1kUsEURJQ5ZDmshSdY5o4HRnZOMPmvdGjaNMBoyu8f/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895519; c=relaxed/simple;
	bh=y5o+F+N3d05eaqrBJZon2XutCdWweRRZ+a6QTCcj2FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brypSovexUPc6WBqnBGeaAdFh8zy64Qxg4PXuMAgwvlY9DKO3z1vIh1I7qXO2cW/X8YTWapshvq7cEymMNEbE6+88lUi4pi/zicJuXURn5tHt6PUDWoSO2/r1YIpVoaHiTgct1ZOH/hq5Lvum+//hpqs+9rCl2JO/1WJ8ftyP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m4+wTHPB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GImDTwHR7dxIEVcWRknSk262EH01U7E8MroXbU85sZU=; b=m4+wTHPBl7ke3GLR8Q2b1LHcAX
	JVT7yZ1fWERESM53VFS7Y09mCvRfxhECgGDOhMXy0F9AN7DlmZxr4B4fJBp+5rSMtpnylKk6BbvvH
	sSeESgQtqFvtlxvaZcuIwiEA3bf56LUGnuxpRlF3f4SovqpomZI9qLcbhmLQBS8Me8YJgBFFXP0nH
	Kfjwc7uH4DCOv5rQ/cVe5sgIJ7si8n9VBj6UzIOlYz7mQX9HJ3wreugOvBnlKjDQ4j15P7d9ZMVcf
	QjnPJ6jVmMWZkwTh1yF695V5XfejVFnbeztFMkFoKYp4yP0hWoADmjnlUjLBqcHn2hhMKhfl0d+VY
	RZYQtzlA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzKW5-000000014oa-2H9e;
	Tue, 23 Apr 2024 18:05:17 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	Liam.Howlett@oracle.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	david@fromorbit.com,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 1/2] tools: fix userspace compilation with new test_xarray changes
Date: Tue, 23 Apr 2024 11:05:15 -0700
Message-ID: <20240423180517.256812-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423180517.256812-1-mcgrof@kernel.org>
References: <20240423180517.256812-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Liam reported that compiling the test_xarray on userspace was broken.
I was not even aware that was possible but you can via and you can
run these tests in userspace with:

make -C tools/testing/radix-tree
./tools/testing/radix-tree/xarray

Add the two helpers we need to fix compilation. We don't need a
userspace schedule() so just make it do nothing.

Reported-by: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/radix-tree/linux/kernel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
index c5c9d05f29da..c0a2bb785b92 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -18,6 +18,8 @@
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
+#define schedule()
+#define PAGE_SHIFT	12
 
 #define __acquires(x)
 #define __releases(x)
-- 
2.43.0


