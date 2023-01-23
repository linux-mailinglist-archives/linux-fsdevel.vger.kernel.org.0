Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1363267841D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjAWSGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjAWSGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:06:25 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286B030B3A
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 10:06:10 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 76E965616BED; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 14/20] mm: expose ksm merge type in ksm_stat
Date:   Mon, 23 Jan 2023 09:37:42 -0800
Message-Id: <20230123173748.1734238-15-shr@devkernel.io>
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

This exposes the ksm process type in /proc/<pid>/ksm_stat. The name of
the value is ksm_merge_type.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 fs/proc/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index a2b7779f76f6..2b63a70fb7a6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3200,6 +3200,7 @@ static int proc_pid_ksm_merging_pages(struct seq_fi=
le *m, struct pid_namespace *
=20
 	return 0;
 }
+
 static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *n=
s,
 				struct pid *pid, struct task_struct *task)
 {
@@ -3209,6 +3210,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, st=
ruct pid_namespace *ns,
 	if (mm) {
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
+		seq_printf(m, "ksm_merge_type %s\n", ksm_merge_type(mm));
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
 		mmput(mm);
 	}
--=20
2.30.2

