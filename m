Return-Path: <linux-fsdevel+bounces-63844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16918BCF5FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 15:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD733B3DD5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4B27BF6C;
	Sat, 11 Oct 2025 13:50:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m17211.xmail.ntesmail.com (mail-m17211.xmail.ntesmail.com [45.195.17.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA40238159;
	Sat, 11 Oct 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760190613; cv=none; b=Q7Dep7jjlYIQxesjJdTxqbqEx2iuFxAlcIrZDqA04kARHcwF7ssyP/oaJ+KMZVvSPNZEMwV/JQrmJhPON58hfJRz8d0r6d4Ct7jk5FCu2soctPas1cwsN85Pez8D9W1jTG/vwVvsx3i3P6Rrxf2aFiFsGZE4XrhaQBONME+HxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760190613; c=relaxed/simple;
	bh=r+xq8gR6zIKZl5tezizIpc/zT6w4z2hz/wYYb4a3nbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f1ADmb3RmeJasb7945GJ8hVVTjCVV7SJdYpdIBTV55cTFkkY3i5eZmtKdOgnhrot6lxJfj+7JrDEI2EBM3dPVRQZSKpqohSsLVuw/YN0FV13LxyW7+k0zvlmHHKgWetYDSnkoDO4AniAnqE2niwQN8lsIvGlAFNW6YuPORsb89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 115ff4355;
	Sat, 11 Oct 2025 17:14:02 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fs: Fix uninitialized 'offp' in statmount_string()
Date: Sat, 11 Oct 2025 17:13:53 +0800
Message-Id: <20251011091353.353898-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99d28c6deb0229kunmfef54592ec018
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSENOVkIYSkIeQ0hJSB1PQ1YVFAkWGhdVGRETFh
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
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
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


