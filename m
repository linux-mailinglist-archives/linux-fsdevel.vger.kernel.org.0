Return-Path: <linux-fsdevel+bounces-64001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06355BD57FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC80403453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15932FB637;
	Mon, 13 Oct 2025 17:25:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m81193.netease.com (mail-m81193.netease.com [47.88.81.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9729A322;
	Mon, 13 Oct 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.88.81.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376304; cv=none; b=nQqqpLM6vt5H3JRgTUITXXV9c6idBI8L5NUIGL86XRNtWMTduOkAbQMhPGGlbbCYUhuVviyr9JiwKhxxmQ62os5OOJ1J+0WzseZYEE8gcbEzG70issWNJ+l0li4Q5qpJ3OSN/xVmgvRMfWBVQtFscfk598O6KKFr/msS+Ewlz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376304; c=relaxed/simple;
	bh=gtbS0FKSa1Grv/vNh0H5O9ORgDt9oo1tUzC8KeQiMNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4WZnus9HKVqOmCR/RSfo61hRjUjmhHZzbaW3j1PqKz9nTPiAfkFVF6UBExgxmaNwfr5uU3RqvWjsKSQWO0HBNEYB9L7BExScWlmjVOtdklvsiqM9+F3Cy7z1n68wu5XeIfPk5O43uC7oPTe+2iB/svuN4J1kJOPVEcd1P5aQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=47.88.81.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11768a2a8;
	Mon, 13 Oct 2025 19:42:00 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] fs: Fix uninitialized 'offp' in statmount_string()
Date: Mon, 13 Oct 2025 19:41:51 +0800
Message-Id: <20251013114151.664341-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251011091353.353898-1-zhen.ni@easystack.cn>
References: <20251011091353.353898-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99dd609cca0229kunmc18ee22b2d2b5d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEwaVk0dH0wYQkIfTx9MTVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

In statmount_string(), most flags assign an output offset pointer (offp)
which is later updated with the string offset. However, the
STATMOUNT_MNT_UIDMAP and STATMOUNT_MNT_GIDMAP cases directly set the
struct fields instead of using offp. This leaves offp uninitialized,
leading to a possible uninitialized dereference when *offp is updated.

Fix it by assigning offp for UIDMAP and GIDMAP as well, keeping the code
path consistent.

Fixes: 37c4a9590e1e ("statmount: allow to retrieve idmappings")
Fixes: e52e97f09fb6 ("statmount: let unset strings be empty")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Reviewed-by: Jan Kara <jack@suse.cz>
---
Changes in v2:
- Add Fixes: e52e97f09fb6 ("statmount: let unset strings be empty")
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..5b5ab2ae238b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5454,11 +5454,11 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		ret = statmount_sb_source(s, seq);
 		break;
 	case STATMOUNT_MNT_UIDMAP:
-		sm->mnt_uidmap = start;
+		offp = &sm->mnt_uidmap;
 		ret = statmount_mnt_uidmap(s, seq);
 		break;
 	case STATMOUNT_MNT_GIDMAP:
-		sm->mnt_gidmap = start;
+		offp = &sm->mnt_gidmap;
 		ret = statmount_mnt_gidmap(s, seq);
 		break;
 	default:
-- 
2.20.1


