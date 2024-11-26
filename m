Return-Path: <linux-fsdevel+bounces-35922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8D9D9AD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70730161EA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C41DA61D;
	Tue, 26 Nov 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOKjw2+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4A1DA60D
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636495; cv=none; b=sGnBPlRxcgYidWV0Ridz3zzLuV/sD20M5dJIQP0BAb+rz3piPSKuo6IIPdscb9iog5BQkToHIbXeHVmd8eHobuUM5tWCEWgd4ETxxNHDxQoVijYZvk0r6XnrRMNF+BBX/HVp6Ff51TynJnrqrhFgYbE4gu2y1SrTuQXsS2bLp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636495; c=relaxed/simple;
	bh=LzHZSIB3uuUqqSEGYbIshH/HG/EMysiZv3qwp3h8skw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+dVpFSyj7rRTSfbNvJDt7mHZu8gbj7q0Cetc+eqJlR/f8QE6HA73Kr1sZjaaWLC8z/V5/aaCsON2c3PnX6S7gBC5vl/zG9RaSfaNvlOQj/FdeQc6EPKOAK3auiobr0zmKR0mixn/Vgmv+LK8k12P+qY3mMcBuLycjlAdW83bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOKjw2+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436F8C4CECF;
	Tue, 26 Nov 2024 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732636495;
	bh=LzHZSIB3uuUqqSEGYbIshH/HG/EMysiZv3qwp3h8skw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOKjw2+FzS1xUbmtZewdYyxDYIfYCcte0hAkepPYuNfbsifvo+xMGVOkNw7OhlSQ9
	 OJYlnQN3efHG+cxx1dSKQYCKF6kjnNGnR537DsU3brjQo+rJYRAjHQLSdAcUnAOzGS
	 bnkOLvMiElXJSCCz26M2/WPO25rUPQgH/ZJkUvb97X2pKwG/IdIfcnIYdmfFZiPoR4
	 b9dLVWzC8LUIkMRsQrBOEsBw4MO1u7TQQ/AEOL8M8GVoxPKQYM+tLCM1/WvHxEQMIH
	 ZW85T3EPgmXUfDGOkoa8P7VGRY9J2eqiHsFTKcAhFs4jnu8rgzFmu2l4C/r6GmRQ4a
	 SBBYdKTfKqUKQ==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2 2/5] libfs: Check dentry before locking in simple_offset_empty()
Date: Tue, 26 Nov 2024 10:54:41 -0500
Message-ID: <20241126155444.2556-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126155444.2556-1-cel@kernel.org>
References: <20241126155444.2556-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Defensive change: Don't try to lock a dentry unless it is positive.
Trying to lock a negative entry will generate a refcount underflow.

The underflow has been seen only while testing.

Fixes: ecba88a3b32d ("libfs: Add simple_offset_empty()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index bf67954b525b..c88ed15437c7 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -347,13 +347,14 @@ int simple_offset_empty(struct dentry *dentry)
 	index = DIR_OFFSET_MIN;
 	octx = inode->i_op->get_offset_ctx(inode);
 	mt_for_each(&octx->mt, child, index, LONG_MAX) {
-		spin_lock(&child->d_lock);
 		if (simple_positive(child)) {
+			spin_lock(&child->d_lock);
+			if (simple_positive(child))
+				ret = 0;
 			spin_unlock(&child->d_lock);
-			ret = 0;
-			break;
+			if (!ret)
+				break;
 		}
-		spin_unlock(&child->d_lock);
 	}
 
 	return ret;
-- 
2.47.0


