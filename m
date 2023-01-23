Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C126783DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjAWSAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjAWSAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:00:05 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469044BD
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 10:00:04 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 5F7EA5616BE1; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 08/20] mm: split off pages_volatile function
Date:   Mon, 23 Jan 2023 09:37:36 -0800
Message-Id: <20230123173748.1734238-9-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,SUSPICIOUS_RECIPS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This splits off the pages_volatile function. The next patch will use
this function.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 88a969849955..19f434f97dc1 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3182,8 +3182,7 @@ static ssize_t pages_unshared_show(struct kobject *=
kobj,
 }
 KSM_ATTR_RO(pages_unshared);
=20
-static ssize_t pages_volatile_show(struct kobject *kobj,
-				   struct kobj_attribute *attr, char *buf)
+static long pages_volatile(void)
 {
 	long ksm_pages_volatile;
=20
@@ -3195,7 +3194,14 @@ static ssize_t pages_volatile_show(struct kobject =
*kobj,
 	 */
 	if (ksm_pages_volatile < 0)
 		ksm_pages_volatile =3D 0;
-	return sysfs_emit(buf, "%ld\n", ksm_pages_volatile);
+
+	return ksm_pages_volatile;
+}
+
+static ssize_t pages_volatile_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", pages_volatile());
 }
 KSM_ATTR_RO(pages_volatile);
=20
--=20
2.30.2

