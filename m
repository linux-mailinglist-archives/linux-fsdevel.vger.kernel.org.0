Return-Path: <linux-fsdevel+bounces-15897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E033A8958C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 17:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D75F1C20E4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13B137762;
	Tue,  2 Apr 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SgZfM4j8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF2134738;
	Tue,  2 Apr 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072939; cv=none; b=lJi2ZDmq/pRqxG2c9BuA/f6/LqCbORLBrFlMwlbo+FqN48aPGvuJBhYyDnbwaUD6ZUOXZOwHAAsGvbksgfCWMMKPxWoWY9UvsgoaBwrdFyv1kVNWsYiUascJy7STyqye/N/b4pwdfFbcNsMCftFVDIckUegorhEnY//T9uQQSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072939; c=relaxed/simple;
	bh=3qqbmy6OIcOoO07cO28FmCqjE206p+74Pkl9CCe0L8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oV4IU3JuFep57iarqKkG/0LMVg5Z4NHwg0aAgAPQjNNCFy155TUp/qXCf9tJyRCuhrVLZmtxBGaqxgRPmF5a3FqxH7CItwvBVkJdBHYRLAGksm19mopxTr1ofbLgsCkv/5OJF4FTAOeTdKaO0SUnDDcPcTgR8zXk3qWBsbLPhjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SgZfM4j8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712072935;
	bh=3qqbmy6OIcOoO07cO28FmCqjE206p+74Pkl9CCe0L8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgZfM4j8m0wWn0DNkDq46LDfpOBCGT3bILSbqHsGSkUxpPo4b81IwwPrajdoCRvtX
	 I9p71M+M9+37cLUTdwD9efeNnm8NGbKKT5AELMTUDi+9Js+xv+kx/NzGqOxwd7Ary/
	 zG2nBh7kWJFz5w1UaHVgfrRvJ1LcMygbfanLp168vvYaX6KcLSAjeM9+xOXkdp3+KC
	 Mh0eMbgI92pS+V8giRfPK3NFpk2zOtnmQHmurb5O5fIFnUeX59s+UaTUpOtsnLHDU5
	 gDahwNPmpCA0ASioL89EdUSTwGD5AVZwXkuaE/YTKkvWtgBr24Jjk1Gjp0soSK0qtV
	 LFrDgky450Pxw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BA3A037820F5;
	Tue,  2 Apr 2024 15:48:54 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v15 6/9] ext4: Log error when lookup of encoded dentry fails
Date: Tue,  2 Apr 2024 18:48:39 +0300
Message-Id: <20240402154842.508032-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402154842.508032-1-eugen.hristev@collabora.com>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2d0ee232fbe7..3268cf45d9db 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+					"Directory contains filename that is invalid UTF-8");
 			return false;
 		}
 		return ret;
-- 
2.34.1


