Return-Path: <linux-fsdevel+bounces-39082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACF6A0C080
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D14C1887814
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5F2236F1;
	Mon, 13 Jan 2025 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVTMp4yi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66519223338;
	Mon, 13 Jan 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793388; cv=none; b=dNUEC6cH/TwS6UOIQ7EeH+vCw8JT+/9QSp9GFI+YqDy3kfKQXWKMedk7xOlJ23OvBzyHOPBoFZECfYr1sG/XiqAztVcXKkNOp5zuf6fliQYpLrQMtHfGc0Us8HCvOwcKnobYG7Ydzb4guVIs3lDBR1/fi4u4Vjuve6etEs+utYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793388; c=relaxed/simple;
	bh=+3sJGrPKNUeuUfG3jjtrnsRB725PrrORkWg60agP5L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJ9RPNlo2w67Rcl3NGTiOIm+whjOfDd02wA1xsaxzne+0NQLq9VCWSryrMZiz2EgvK9CX8KZ/CbOWnJ+2EW0YAlOLk5K+Ah7MtvPkPG0Ilk9tk7UV1hMcoMLWvHWVLtay7Noe41sCG+Omxguy87QEf3wJXtNvc8h0BHbZasXGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVTMp4yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7984BC4CEE5;
	Mon, 13 Jan 2025 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793388;
	bh=+3sJGrPKNUeuUfG3jjtrnsRB725PrrORkWg60agP5L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVTMp4yiVU7QpdEfdMN0LWpCx9lsTLBaJPpY6iAy32Ji9s910MmJeaJmentolku3x
	 Rsj0Bs/PLZJKWNLMRherDE+6hAyPABRyCdQVKx0s/gyTgSya4T/WEXVuPSXo0gbRW2
	 8C2wqNua6Em6k49dVq42xPEx777sgmcn9cPRFJ+n9yLLBWoGEYw5jcNlDUQXnl77GF
	 S1lURDRiZVYjLjNk+MmDPUBKmHCsENnYA2moPydfTprfltRuOJ55A3YmuB3RyXjQXy
	 o70BjmDTFqkvZLLDgOeMlwvXLn00sipr5rT359exGFBW3ZgaD7ZGWfz/1nphG23+Qb
	 0hZyOuf3dGEhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Kunbo <zhangkunbo@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/5] fs: fix missing declaration of init_files
Date: Mon, 13 Jan 2025 13:36:17 -0500
Message-Id: <20250113183619.1784510-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183619.1784510-1-sashal@kernel.org>
References: <20250113183619.1784510-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index 40a7fc127f37..975b1227a2f6 100644
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


