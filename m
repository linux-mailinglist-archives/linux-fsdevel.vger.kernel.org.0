Return-Path: <linux-fsdevel+bounces-1219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D67D7ADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 04:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9AC1B212D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 02:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB948F5C;
	Thu, 26 Oct 2023 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LujEJlb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92B2F44
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 02:24:19 +0000 (UTC)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1BD6D8;
	Wed, 25 Oct 2023 19:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=q1Nvz
	lz4m5YlXKgzOVfLPIxG3pjGCPz8pjWhlQCBR3s=; b=LujEJlb3QzRohqXLqpoTC
	akb+/G41SkLeuP2rMsamojGbRXUInr/Gwn3HpzqRsHB8hkhegxn+cR734zsvUsBp
	JxzsNwmWyDOQd5AHdifxSOvj+jRc23yr6RWF2eFfW5UTusgjWiVRf50mnZaXlg0Q
	XuwlOWQStG2rroXNT3JsSs=
Received: from localhost.localdomain (unknown [106.13.245.201])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wCHLyrAzTll_Vn5BQ--.55683S2;
	Thu, 26 Oct 2023 10:24:01 +0800 (CST)
From: gaoyusong <a869920004@163.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND] fs: Fix typo in access_override_creds()
Date: Thu, 26 Oct 2023 02:23:59 +0000
Message-Id: <20231026022359.258507-1-a869920004@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHLyrAzTll_Vn5BQ--.55683S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy7GFW3Kr43Zr43Zr4kCrg_yoWxCwc_Cw
	4Iyr48Grs8tryIywn8WanYyF1Sg34FyF1rG34xJry3KryfZ3ZxuryDKrn7JrWUWr47K3s8
	Xrn8ZFWDZF4I9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnTlk3UUUUU==
X-Originating-IP: [106.13.245.201]
X-CM-SenderInfo: zdywmmasqqiki6rwjhhfrp/xtbB0wcV6VXl10aJVAABsV

Fix typo in access_override_creds(), modify non-RCY to non-RCU.

Signed-off-by: gaoyusong <a869920004@163.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 98f6601fbac6..72eb20a8256a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -442,7 +442,7 @@ static const struct cred *access_override_creds(void)
 	 * 'get_current_cred()' function), that will clear the
 	 * non_rcu field, because now that other user may be
 	 * expecting RCU freeing. But normal thread-synchronous
-	 * cred accesses will keep things non-RCY.
+	 * cred accesses will keep things non-RCU.
 	 */
 	override_cred->non_rcu = 1;
 
-- 
2.34.1


