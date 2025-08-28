Return-Path: <linux-fsdevel+bounces-59576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A3B3AE30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FE11C2261C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39982FC89A;
	Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gDZh+OT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB92F0C46
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422498; cv=none; b=mSXpuuvmXM0fCQrpP6OXXERR0kIE70KlEdaTDkfJW42H/9/zKlhqaMChNVcJiCrhVLOJaeEdzAm8zqWIzZaNhv/7Ks0o5Aw9/AYNgraGOkJYT5CbC8xz9CMw4hmItUHENGSnZ2odbegml5EH4V3AWC84haa7NELCUUcz41B/0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422498; c=relaxed/simple;
	bh=fr+X1ObJCQpRCjz+ZSezFRp+eZb8shNwPNL0PXDUt9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjRRuMBzFnIl7Ddx37yXTj9KUYVPxtTNeEfQud+6o7TvFl57Vz7HPR8g1HgM+RJJhLJdFZLzIgxZozrdvvd2GU7FhmaZP2gslj736S+G7ZA7J1JUlYT7CVcmtPX9qXeRNG09GsNLkwPHcgFHVMDGdDi2iqgi45ricJnvM+AsQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gDZh+OT6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=41GW52dSi2ARz43rVuABrOvtT3w5JtgtRhEQ8pbYKQs=; b=gDZh+OT67fBChMZHaWp9BQjkU2
	dYvr4URXgDisKFqwi71fXrTPiVljoaoKZuJFiHpbpnrG8RWgITCgwlNqiWttVyQbeMXqO2dyACgmL
	PczF0WZv8tiSayyD0Rdo6OR3/0NrGJ9WpgjTF9DYq+kl6LiD49pf14B5AuVRFvl1DmScVSb7l6ClZ
	M5SWbNm3bcVPNlaeKjHJYAOpQY/r36OT1xc88aGX19zw7IAER9awXmLuqWjYe3q41s2/D97ZSo6F8
	iclhFOUBQs9Ny+ZgpqS42de8Jj87J+7rTBWfB/9TWR8slz5pN+HJoLxmHDG4QRP9wFRgaSrl6sCwu
	C10Y6dBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj2-0000000F27u-42HR;
	Thu, 28 Aug 2025 23:08:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 42/63] mnt_warn_timestamp_expiry(): constify struct path argument
Date: Fri, 29 Aug 2025 00:07:45 +0100
Message-ID: <20250828230806.3582485-42-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 70ae769ecf11..a7c840371a7f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3230,7 +3230,8 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	touch_mnt_namespace(mnt->mnt_ns);
 }
 
-static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
+static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
+				      struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
 
-- 
2.47.2


