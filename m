Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC06783FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjAWSD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjAWSDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:03:22 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5E27D4A
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 10:03:19 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 636A05616BE3; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 09/20] mm: expose general_profit metric
Date:   Mon, 23 Jan 2023 09:37:37 -0800
Message-Id: <20230123173748.1734238-10-shr@devkernel.io>
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

The documentation mentions a general profit metric, however this metric
is not calculated. In addition the formula depends on the size of
internal structures, which makes it more difficult for an administrator
to make the calculation. Adding the metric for a better user experience.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 19f434f97dc1..d29454a802a0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3205,6 +3205,21 @@ static ssize_t pages_volatile_show(struct kobject =
*kobj,
 }
 KSM_ATTR_RO(pages_volatile);
=20
+static ssize_t general_profit_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	long general_profit;
+	long all_rmap_items;
+
+	all_rmap_items =3D ksm_max_page_sharing + ksm_pages_shared +
+				ksm_pages_unshared + pages_volatile();
+	general_profit =3D ksm_pages_sharing * PAGE_SIZE -
+				all_rmap_items * sizeof(struct ksm_rmap_item);
+
+	return sysfs_emit(buf, "%ld\n", general_profit);
+}
+KSM_ATTR_RO(general_profit);
+
 static ssize_t stable_node_dups_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -3269,6 +3284,7 @@ static struct attribute *ksm_attrs[] =3D {
 	&stable_node_dups_attr.attr,
 	&stable_node_chains_prune_millisecs_attr.attr,
 	&use_zero_pages_attr.attr,
+	&general_profit_attr.attr,
 	NULL,
 };
=20
--=20
2.30.2

