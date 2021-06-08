Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C539EB72
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 03:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhFHBdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 21:33:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36260 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231342AbhFHBdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:33:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1581U63V029840
        for <linux-fsdevel@vger.kernel.org>; Mon, 7 Jun 2021 18:31:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5HrHHih5juBqYKEEslPOvXicus6WWgPH+iRjEl6TblE=;
 b=amxgprEku9rCQRvdWBmXu/0dZv4ziiDbMNJ1H+AzjZDyEK4MCtAofsB8BWqiwnlGlCV9
 o+B9DsMRcSyLKfce86LYlR5S/ijO3IKbacOzZzKQS6pN5fgSUruVQ1CbruTOxl2VYpSn
 iwWuHMNyDlaII8Zrs4IKhdjvpmJnmWPwVlk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 391m0t40uf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jun 2021 18:31:44 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 18:31:41 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 9090781D6D45; Mon,  7 Jun 2021 18:31:29 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v8 2/8] writeback, cgroup: add smp_mb() to cgroup_writeback_umount()
Date:   Mon, 7 Jun 2021 18:31:17 -0700
Message-ID: <20210608013123.1088882-3-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608013123.1088882-1-guro@fb.com>
References: <20210608013123.1088882-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: guvaMkzVlK3ZHHKBK2uFXZ2o64XJeNDP
X-Proofpoint-ORIG-GUID: guvaMkzVlK3ZHHKBK2uFXZ2o64XJeNDP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A full memory barrier is required between clearing SB_ACTIVE flag
in generic_shutdown_super() and checking isw_nr_in_flight in
cgroup_writeback_umount(), otherwise a new switch operation might
be scheduled after atomic_read(&isw_nr_in_flight) returned 0.
This would result in a non-flushed isw_wq, and a potential crash.

The problem hasn't yet been seen in the real life and was discovered
by Jan Kara by looking into the code.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index bd99890599e0..3564efcc4b78 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1000,6 +1000,12 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_i=
d, unsigned long nr,
  */
 void cgroup_writeback_umount(void)
 {
+	/*
+	 * SB_ACTIVE should be reliably cleared before checking
+	 * isw_nr_in_flight, see generic_shutdown_super().
+	 */
+	smp_mb();
+
 	if (atomic_read(&isw_nr_in_flight)) {
 		/*
 		 * Use rcu_barrier() to wait for all pending callbacks to
--=20
2.31.1

