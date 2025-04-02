Return-Path: <linux-fsdevel+bounces-45487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CD5A786E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 05:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D8918928C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 03:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244723024D;
	Wed,  2 Apr 2025 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="E/Z9ZCoh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C930226CF0;
	Wed,  2 Apr 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743565560; cv=none; b=WvJJIDi4V+1W3EHWtB89u+3Kd8BE4AcGcQdIAKE8mCevMBxSkOHaQvaOUFio+Wz1T2zAZ9mGLZ8eh0TIwL0i5qOLyVRGHfRHeCTmvHk/OtEi/ZR6bo3kHtuyU9qA7n9rOoPqSgwc4K4E9QtidqJZyrMcKpRyXcs4ZOUE4ReVGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743565560; c=relaxed/simple;
	bh=eLJXIpnlB/DF+APEOR2BWEebuVobdEbVvoO7SlYo430=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9HdWGPU4XeVVsZYH8rpp/+Oka5k+jH4co/EB0fkrL01GdnYmUlcNUzypZieMGwkWEw+Bgk0xuqkS4MZ8FYT2w6kY2m+zFLX0Ut+WQH6wB7A0KQoi9Ykkbma7ShdoMCF1YMpSXmI2viqHCZuJk6UO7r8xZUkoayCRcyK59rPWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=E/Z9ZCoh; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=dZO8Z
	XE0GcyFn5LuP2awAU+8F/Vo4jGABZ91w6miiDU=; b=E/Z9ZCohgcxGEiIJgtOST
	th4p+UlP9e/31+6xpY19FhL6oqTszophTJ8Oxr/aD4tjMLkSx3LJfFstVAs3RKPh
	1YXwEh1r7X3Nqp804edqpLozuvDvwjmg66kiiR9IC0N1gQaQieXHTfxn8b9Iad1P
	RcpCcIM8gITP7NEPonxdEQ=
Received: from hexiaole-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC332_bsuxnDx5HAg--.44432S2;
	Wed, 02 Apr 2025 11:45:32 +0800 (CST)
From: Xiaole He <hexiaole1994@126.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiaole He <hexiaole1994@126.com>
Subject: [PATCH v1] fs/super.c: Add NULL check for type in iterate_supers_type
Date: Wed,  2 Apr 2025 11:45:29 +0800
Message-ID: <20250402034529.12642-1-hexiaole1994@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC332_bsuxnDx5HAg--.44432S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1rWFyfKFWDtrWUZw43KFg_yoWDKFX_Zr
	1xZFZ3Gw47AF1rtF45CFWxJrZxKwnavr1fWr4avFZrCr98JF4DJrykur98Z3yfCFnYqF9r
	Grn2gF4fKF4xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNF4iUUUUUU==
X-CM-SenderInfo: 5kh0xt5rohimizu6ij2wof0z/1tbikAgjBmfsrBCylgAAsu

The first several lines of iterate_supers_type are below:

1 void iterate_supers_type(struct file_system_type *type,
2 	void (*f)(struct super_block *, void *), void *arg)
3 {
4 	struct super_block *sb, *p = NULL;
5
6 	spin_lock(&sb_lock);
7 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
8 	...
9 }

The iterate_super_type is a exported symbol, and if iterate_supers_type
is called with type of NULL, then there will be a NULL pointer
dereference of argument type in line 7.

This patch fix above problem by adding NULL pointer check for argument
type.

Signed-off-by: Xiaole He <hexiaole1994@126.com>
---
 fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 5a7db4a556e3..105a275b8360 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -959,6 +959,8 @@ void iterate_supers_type(struct file_system_type *type,
 {
 	struct super_block *sb, *p = NULL;
 
+	if (unlikely(ZERO_OR_NULL_PTR(type)))
+		return;
 	spin_lock(&sb_lock);
 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
 		bool locked;
-- 
2.43.0


