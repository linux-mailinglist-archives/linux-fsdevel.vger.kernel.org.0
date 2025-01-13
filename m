Return-Path: <linux-fsdevel+bounces-39080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA970A0C06F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F0B1633A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1566214225;
	Mon, 13 Jan 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvVTyx6D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7C2135D6;
	Mon, 13 Jan 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793372; cv=none; b=E0wRJXmWsrksDBGpZq3ESO1YEulc5BuLIpd5S2Z4etIEf4oWOaQrPeytCf3C5GbVr3PQ5biuYIwhxVfaC2zE8BspVuCTSPPuKJpgTtWpVHP1tpPQJNb95IrRk02QXHZHn75otvmWaqDR5dH3Q4h9GXIoAKZPXJz2+nc6E3X+lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793372; c=relaxed/simple;
	bh=w9oEjYQV3UBE2a7bIDVTK9ZmqzyCwxuyANfOJlAqfbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdX2xECn8y9QWYgJO2GYw7prQdzSoZamb3hUe0x6iygYa6VzjDbKRkxCXOBy2xRpIx87QUkgGpgg0p6Ulpue2JmUFAUzyrgUkYqoMc9ntwGNITYyzUYjC87rnZHuyTA+6bQ2bvKSKMBL+WeaQDUOf5VjMkXzleaTzBhDqJM/Mgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvVTyx6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106B9C4CEE3;
	Mon, 13 Jan 2025 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793371;
	bh=w9oEjYQV3UBE2a7bIDVTK9ZmqzyCwxuyANfOJlAqfbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvVTyx6D9fZVVMdV7UPODtqRGMd09eo085VD216REx2omsvcFUAXN5+3Y0XP5X7rl
	 0QAFwMr0szomAS9I5HuQZy3VVFjAFHRa0oa9SO8PF1nKC1LvjwM2D2nAqHaMt08+nN
	 xu4J8CoB5E07gX6fduTUUNrSDyYKOBa6wrKySbiKKAiV/3DxF/voaOAvY8qKRWCXUi
	 kaJKAdfNQJV7Ya8QoVx/KW+yDtxOpU0WFBNgxVoO5yAF28r/Q8cIIbJxeKSt+14d23
	 TMCCQuhmj9LKL+tWnqlsHNRApuFNdUDKswZuXPiN7hTt1pM0eQ2IxNTVMpCvKMhNTW
	 IzAWyrR20r72Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Kunbo <zhangkunbo@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/6] fs: fix missing declaration of init_files
Date: Mon, 13 Jan 2025 13:35:57 -0500
Message-Id: <20250113183601.1784402-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183601.1784402-1-sashal@kernel.org>
References: <20250113183601.1784402-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.176
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
index b4194ee5c4d4..386968003030 100644
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


