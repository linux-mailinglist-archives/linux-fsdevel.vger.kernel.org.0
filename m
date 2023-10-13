Return-Path: <linux-fsdevel+bounces-257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034847C86BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A215E282D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0415E95;
	Fri, 13 Oct 2023 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE814AA8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 13:24:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD4C0
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 06:24:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qrI9p-0007uc-Gy; Fri, 13 Oct 2023 15:24:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qrI9o-001PIy-Sy; Fri, 13 Oct 2023 15:24:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qrI9o-00FbR4-Jo; Fri, 13 Oct 2023 15:24:48 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] chardev: Simplify usage of try_module_get()
Date: Fri, 13 Oct 2023 15:24:42 +0200
Message-ID: <20231013132441.1406200-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=646; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=R9INCCnZHjDrqqT6TUHXdcgerU7KHEBfB0eb0qLpMwU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKUUZclcGYEOhLRMtHbtGLteZrJdk79WIndBVW ZHk7KpETEOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSlFGQAKCRCPgPtYfRL+ ToB+B/wP4oSHAFvIVb5PJ9gFF7cj/S30/uwt3xz6VjtRFviDcIOyZ2viIbZz8WlLzKwSVm8ZzaR nZxcP/xhs/VxvyiGK/ZWv1XNJhpSQ9FVXnNu7/0mHcKek50ZRB/sE1vJEnpWiEgcGA/5yDTgva0 3bG1VO3JdvkL/dlVsqTs5pP7cWgDz5abxbvg8+nqNA351/AIWZLxlKcgyPpdedZfRmATRzxprz+ vZqkqehUVNAbuT/sU0jZ+XwichJrgNUyOxeMBPr+aBuAUcE99YGqE/tfhxzD+6e58yqicUTq8Yo VhYTs8KTAUvzGG+0ajZvdq1C/Q63ecJP9sPchf1TRCzR/xyX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

try_module_get(NULL) is true, so there is no need to check owner being
NULL.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 fs/char_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 950b6919fb87..6ba032442b39 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -350,7 +350,7 @@ static struct kobject *cdev_get(struct cdev *p)
 	struct module *owner = p->owner;
 	struct kobject *kobj;
 
-	if (owner && !try_module_get(owner))
+	if (!try_module_get(owner))
 		return NULL;
 	kobj = kobject_get_unless_zero(&p->kobj);
 	if (!kobj)
-- 
2.42.0


