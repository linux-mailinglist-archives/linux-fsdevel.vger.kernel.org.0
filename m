Return-Path: <linux-fsdevel+bounces-39074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A0A0C02D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09A716022C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C681FBCB8;
	Mon, 13 Jan 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn3qRRYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC01FBC9E;
	Mon, 13 Jan 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793321; cv=none; b=Zi7QICkcOc71geZaDWsMwoQ+ryjI/nahtFHDEn20uWkVVizMkU29irNRjdQcSzDeWmD6zJs3uGb8Vqdy43vvS9fQzxYZmDMxSWgRoXcFA58IvU7B6HJF/DZTX0RIsHYByOQXyuU2x33IE7fjMksrGVSIXOUaRkx3c5snCSflQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793321; c=relaxed/simple;
	bh=cuucFRvoqGQgOniGasI8uJeUnXS0e8oosv6J65UrUJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLNB5W12v4jS9F4o4FoWDJ4MJrMpxl9JneAiY+he8r4OUiTjs1magWmuzDbdy8fv1sps8SfH2zuTFGGVL6cryXIRrrWTbZSOi+yB7KUU4z6kylFC2M0kpNtbdRMrsmdH/o4d98YwukEF2mGkkZjmHt6UiUJwWuogLPzsNOCIGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn3qRRYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADBDC4CEE3;
	Mon, 13 Jan 2025 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793321;
	bh=cuucFRvoqGQgOniGasI8uJeUnXS0e8oosv6J65UrUJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tn3qRRYS3ZAqcwAbzSkJtHc2ajl16i4mPDMSJe92lH1srwyC9+NvSgv9yENcAo++r
	 1+5HjN9xd1Q6mF6Ng6F1+cjIQ+KIsHrF0/FBJDrp99uDioqQcReb5tSIqMCBQnc39s
	 tU7XHX5f1TA+1p0xi4cfkG/mIy1Luvce15/HC6RbSUOCG6sUQAZ3WEisBUxaN3zpfW
	 Lxgl6gI+evX8U97M4njYLyXXxVaJCWDHvmT3XzFAN+yPEXxcflajzjflaOKb7Q0zZY
	 /Bs7vZLDB68lfBWauyt35njpnsR9tM1xEDs4z9HBtxamPkDvJtZbTuAw+IZY34ttvA
	 SxNWSPm0w8RbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Kunbo <zhangkunbo@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/10] fs: fix missing declaration of init_files
Date: Mon, 13 Jan 2025 13:35:04 -0500
Message-Id: <20250113183511.1783990-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183511.1783990-1-sashal@kernel.org>
References: <20250113183511.1783990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.71
Content-Transfer-Encoding: 8bit

From: Zhang Kunbo <zhangkunbo@huawei.com>

[ Upstream commit 2b2fc0be98a828cf33a88a28e9745e8599fb05cf ]

fs/file.c should include include/linux/init_task.h  for
 declaration of init_files. This fixes the sparse warning:

fs/file.c:501:21: warning: symbol 'init_files' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
Link: https://lore.kernel.org/r/20241217071836.2634868-1-zhangkunbo@huawei.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index bd817e31d798..a178efc8cf4b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/close_range.h>
 #include <net/sock.h>
+#include <linux/init_task.h>
 
 #include "internal.h"
 
-- 
2.39.5


