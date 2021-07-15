Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC03CAFDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 02:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhGPAG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 20:06:57 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11495 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhGPAG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:06:56 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210716000400epoutp02167889801ca4847791b074c544c0aeaa~SHJTFo54n1041010410epoutp02K
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 00:04:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210716000400epoutp02167889801ca4847791b074c544c0aeaa~SHJTFo54n1041010410epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626393840;
        bh=6Q4Ud/3F/MesmVJod6G0opsjuKtapJCh+Qv6QAuW26o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktDoGPD14h7mXdpEuQ65nurPERxp0abaOazZJk4PsP7mWac/4x3pmWhfw3esVgOzD
         OZeYYZTtQ6pmNEBhx67mRuNl4FKrnKw85subEE/NxXA5iRnooOW2OGoYddjJ7gKrHw
         ixkD1sJlzKzRjRKtP+sfXEPY6VCZ+XfjxFClrLzI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210716000357epcas1p226e3683d7400e410ef6e8a352723ac71~SHJP4nLPs0230402304epcas1p2d;
        Fri, 16 Jul 2021 00:03:57 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GQs0W2X7Wz4x9Pp; Fri, 16 Jul
        2021 00:03:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.C9.09952.BECC0F06; Fri, 16 Jul 2021 09:03:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210716000351epcas1p38834ce6505074c56308a6d71e762e09f~SHJKhZn9e1447614476epcas1p3P;
        Fri, 16 Jul 2021 00:03:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210716000351epsmtrp2183ac6b7c38b4abb8abe217956efc616~SHJKgekWg1353413534epsmtrp2p;
        Fri, 16 Jul 2021 00:03:51 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-74-60f0cceb018d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.8E.08289.7ECC0F06; Fri, 16 Jul 2021 09:03:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210716000351epsmtip27b19a2807bf1b505d6a18d8564e1db86~SHJKQw7BP1664016640epsmtip2S;
        Fri, 16 Jul 2021 00:03:51 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, willy@infradead.org,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v6 06/13] ksmbd: add a utility code that tracks (and caches)
 sessions data
Date:   Fri, 16 Jul 2021 08:53:49 +0900
Message-Id: <20210715235356.3191-7-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715235356.3191-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmvu7rMx8SDF5u47c4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFE5NhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAzykplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3IyPi1YzFzQ+4+x4vix
        6ewNjHMvMXYxcnJICJhI3H+5jrWLkYtDSGAHo8SrE3sYIZxPjBL/3v9ig3A+M0q82NHBBtMy
        6fIHqMQuRolPL76xwrXM3befpYuRg4NNQFvizxZRkAYRgViJGzteM4PUMAt0MUs8vX+GCSQh
        LBAj8bT9A5jNIqAqsfHRC7CjeAWsJa6+vcYEsU1eYvWGA8wgNqeAjcTjk9/A7pMQuMIhsefl
        V6gvXCTuz57GCmELS7w6voUdwpaS+PxuL9TZ5RInTv6CGlojsWHePnaQQyUEjCV6XpSAmMwC
        mhLrd+lDVChK7Pw9F2w6swCfxLuvPawQ1bwSHW1CECWqEn2XDkMNlJboav8ANdBDYv5KdUiI
        9DNKXN0+hXkCo9wshAULGBlXMYqlFhTnpqcWGxYYIkfZJkZw8tUy3cE48e0HvUOMTByMhxgl
        OJiVRHiXGr1NEOJNSaysSi3Kjy8qzUktPsRoCgy6icxSosn5wPSfVxJvaGpkbGxsYWJmbmZq
        rCTOu5PtUIKQQHpiSWp2ampBahFMHxMHp1QD065bFsyH7MLkI2+s/XB2yZR7s1WUDgld8daU
        e8CRb9lj4LXP485SDfssvoMcVv9v7Dpa8Y61YaGvePCf6pPGgedmvjf9y3RT2Nd8Tt8DvcUq
        x9LZHk9Y/l4+fz3jzmf7lk2OdXSb0qdzR85XzKemTVWQw/drwPfsI8unzLpQkeKw8+v/5PjS
        SbKfqjy489QCir2Dm798NtERFEr/1MAkMpNXb95pD1NP766jXUcT4xuyvblcPuw9uCTnifyB
        5SK6S+3TO827JmusKmmxsPb76Ks0s5MzwL6h6xzjXsUgsc9yjfrMZ3fuK8+48rCgptA6Vsr5
        V5GVwAZxo7/fFQKORLHmTlHxMvnTf6zV+IESS3FGoqEWc1FxIgD73iWJRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO7zMx8SDG7/lrQ4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFFcNimpOZllqUX6dglc
        GZ8WLGYu6P3HWHH82HT2Bsa5lxi7GDk5JARMJCZd/sDWxcjFISSwg1Hi854TLBAJaYljJ84w
        dzFyANnCEocPF4OEhQQ+MEp8fc0HEmYT0Jb4s0UUJCwiEC9xs+E2C8gYZoE5zBI7Nx4Bmy8s
        ECXx/+RLJhCbRUBVYuOjF2BxXgFriatvrzFBrJKXWL3hADOIzSlgI/H45DdGiF3WEuvXbGCZ
        wMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcIxoae1g3LPqg94hRiYOxkOM
        EhzMSiK8S43eJgjxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TB
        KdXAZFkwRc07WMelNn85203FfTeFlkxI4fjy4IJR9b5tP5PvnnKafEjvf/X3f0bLalbe5ItX
        915RvS/dv/PenRK9H9faL6R82j9xhpLXqS+/r8W/99q80PniyiOy4U7x74VP58ucf1mRPFk5
        5/yCqzW7F/hwbf3lsl1LZqdi9pbV195s2f38aQWrhFF32oWUB4aPO+qkg7fsM5+86lJuWfWn
        o5InFy4+u+wuh77lmninteWicidmHNnwV3nir0+7OLVW531St5lqavvRew1309GPiziDDre6
        hZos6lg3r/nO9J5oh865mW3/3PdXWq74vPzI01Uaz31Xv2MLWDrjV7dI/+ZVuacuLK2r3d0U
        +YjX4YCpEktxRqKhFnNRcSIAEsFDoAADAAA=
X-CMS-MailID: 20210716000351epcas1p38834ce6505074c56308a6d71e762e09f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210716000351epcas1p38834ce6505074c56308a6d71e762e09f
References: <20210715235356.3191-1-namjae.jeon@samsung.com>
        <CGME20210716000351epcas1p38834ce6505074c56308a6d71e762e09f@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The management code caches share configs, user configs, and all other info
needed by active SMB sessions. It also handles user-space IPC upcalls
to obtain corresponding smb.conf and user database entries.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/ksmbd_ida.c    |  46 +++++
 fs/ksmbd/mgmt/ksmbd_ida.h    |  34 ++++
 fs/ksmbd/mgmt/share_config.c | 238 ++++++++++++++++++++++
 fs/ksmbd/mgmt/share_config.h |  81 ++++++++
 fs/ksmbd/mgmt/tree_connect.c | 121 ++++++++++++
 fs/ksmbd/mgmt/tree_connect.h |  56 ++++++
 fs/ksmbd/mgmt/user_config.c  |  69 +++++++
 fs/ksmbd/mgmt/user_config.h  |  66 +++++++
 fs/ksmbd/mgmt/user_session.c | 369 +++++++++++++++++++++++++++++++++++
 fs/ksmbd/mgmt/user_session.h | 106 ++++++++++
 10 files changed, 1186 insertions(+)
 create mode 100644 fs/ksmbd/mgmt/ksmbd_ida.c
 create mode 100644 fs/ksmbd/mgmt/ksmbd_ida.h
 create mode 100644 fs/ksmbd/mgmt/share_config.c
 create mode 100644 fs/ksmbd/mgmt/share_config.h
 create mode 100644 fs/ksmbd/mgmt/tree_connect.c
 create mode 100644 fs/ksmbd/mgmt/tree_connect.h
 create mode 100644 fs/ksmbd/mgmt/user_config.c
 create mode 100644 fs/ksmbd/mgmt/user_config.h
 create mode 100644 fs/ksmbd/mgmt/user_session.c
 create mode 100644 fs/ksmbd/mgmt/user_session.h

diff --git a/fs/ksmbd/mgmt/ksmbd_ida.c b/fs/ksmbd/mgmt/ksmbd_ida.c
new file mode 100644
index 000000000000..54194d959a5e
--- /dev/null
+++ b/fs/ksmbd/mgmt/ksmbd_ida.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include "ksmbd_ida.h"
+
+static inline int __acquire_id(struct ida *ida, int from, int to)
+{
+	return ida_simple_get(ida, from, to, GFP_KERNEL);
+}
+
+int ksmbd_acquire_smb2_tid(struct ida *ida)
+{
+	int id;
+
+	id = __acquire_id(ida, 1, 0xFFFFFFFF);
+
+	return id;
+}
+
+int ksmbd_acquire_smb2_uid(struct ida *ida)
+{
+	int id;
+
+	id = __acquire_id(ida, 1, 0);
+	if (id == 0xFFFE)
+		id = __acquire_id(ida, 1, 0);
+
+	return id;
+}
+
+int ksmbd_acquire_async_msg_id(struct ida *ida)
+{
+	return __acquire_id(ida, 1, 0);
+}
+
+int ksmbd_acquire_id(struct ida *ida)
+{
+	return __acquire_id(ida, 0, 0);
+}
+
+void ksmbd_release_id(struct ida *ida, int id)
+{
+	ida_simple_remove(ida, id);
+}
diff --git a/fs/ksmbd/mgmt/ksmbd_ida.h b/fs/ksmbd/mgmt/ksmbd_ida.h
new file mode 100644
index 000000000000..2bc07b16cfde
--- /dev/null
+++ b/fs/ksmbd/mgmt/ksmbd_ida.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_IDA_MANAGEMENT_H__
+#define __KSMBD_IDA_MANAGEMENT_H__
+
+#include <linux/slab.h>
+#include <linux/idr.h>
+
+/*
+ * 2.2.1.6.7 TID Generation
+ *    The value 0xFFFF MUST NOT be used as a valid TID. All other
+ *    possible values for TID, including zero (0x0000), are valid.
+ *    The value 0xFFFF is used to specify all TIDs or no TID,
+ *    depending upon the context in which it is used.
+ */
+int ksmbd_acquire_smb2_tid(struct ida *ida);
+
+/*
+ * 2.2.1.6.8 UID Generation
+ *    The value 0xFFFE was declared reserved in the LAN Manager 1.0
+ *    documentation, so a value of 0xFFFE SHOULD NOT be used as a
+ *    valid UID.<21> All other possible values for a UID, excluding
+ *    zero (0x0000), are valid.
+ */
+int ksmbd_acquire_smb2_uid(struct ida *ida);
+int ksmbd_acquire_async_msg_id(struct ida *ida);
+
+int ksmbd_acquire_id(struct ida *ida);
+
+void ksmbd_release_id(struct ida *ida, int id);
+#endif /* __KSMBD_IDA_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
new file mode 100644
index 000000000000..cb72d30f5b71
--- /dev/null
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/jhash.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/parser.h>
+#include <linux/namei.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+#include "share_config.h"
+#include "user_config.h"
+#include "user_session.h"
+#include "../transport_ipc.h"
+
+#define SHARE_HASH_BITS		3
+static DEFINE_HASHTABLE(shares_table, SHARE_HASH_BITS);
+static DECLARE_RWSEM(shares_table_lock);
+
+struct ksmbd_veto_pattern {
+	char			*pattern;
+	struct list_head	list;
+};
+
+static unsigned int share_name_hash(char *name)
+{
+	return jhash(name, strlen(name), 0);
+}
+
+static void kill_share(struct ksmbd_share_config *share)
+{
+	while (!list_empty(&share->veto_list)) {
+		struct ksmbd_veto_pattern *p;
+
+		p = list_entry(share->veto_list.next,
+			       struct ksmbd_veto_pattern,
+			       list);
+		list_del(&p->list);
+		kfree(p->pattern);
+		kfree(p);
+	}
+
+	if (share->path)
+		path_put(&share->vfs_path);
+	kfree(share->name);
+	kfree(share->path);
+	kfree(share);
+}
+
+void __ksmbd_share_config_put(struct ksmbd_share_config *share)
+{
+	down_write(&shares_table_lock);
+	hash_del(&share->hlist);
+	up_write(&shares_table_lock);
+
+	kill_share(share);
+}
+
+static struct ksmbd_share_config *
+__get_share_config(struct ksmbd_share_config *share)
+{
+	if (!atomic_inc_not_zero(&share->refcount))
+		return NULL;
+	return share;
+}
+
+static struct ksmbd_share_config *__share_lookup(char *name)
+{
+	struct ksmbd_share_config *share;
+	unsigned int key = share_name_hash(name);
+
+	hash_for_each_possible(shares_table, share, hlist, key) {
+		if (!strcmp(name, share->name))
+			return share;
+	}
+	return NULL;
+}
+
+static int parse_veto_list(struct ksmbd_share_config *share,
+			   char *veto_list,
+			   int veto_list_sz)
+{
+	int sz = 0;
+
+	if (!veto_list_sz)
+		return 0;
+
+	while (veto_list_sz > 0) {
+		struct ksmbd_veto_pattern *p;
+
+		sz = strlen(veto_list);
+		if (!sz)
+			break;
+
+		p = kzalloc(sizeof(struct ksmbd_veto_pattern), GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+
+		p->pattern = kstrdup(veto_list, GFP_KERNEL);
+		if (!p->pattern) {
+			kfree(p);
+			return -ENOMEM;
+		}
+
+		list_add(&p->list, &share->veto_list);
+
+		veto_list += sz + 1;
+		veto_list_sz -= (sz + 1);
+	}
+
+	return 0;
+}
+
+static struct ksmbd_share_config *share_config_request(char *name)
+{
+	struct ksmbd_share_config_response *resp;
+	struct ksmbd_share_config *share = NULL;
+	struct ksmbd_share_config *lookup;
+	int ret;
+
+	resp = ksmbd_ipc_share_config_request(name);
+	if (!resp)
+		return NULL;
+
+	if (resp->flags == KSMBD_SHARE_FLAG_INVALID)
+		goto out;
+
+	share = kzalloc(sizeof(struct ksmbd_share_config), GFP_KERNEL);
+	if (!share)
+		goto out;
+
+	share->flags = resp->flags;
+	atomic_set(&share->refcount, 1);
+	INIT_LIST_HEAD(&share->veto_list);
+	share->name = kstrdup(name, GFP_KERNEL);
+
+	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
+		share->path = kstrdup(ksmbd_share_config_path(resp),
+				      GFP_KERNEL);
+		if (share->path)
+			share->path_sz = strlen(share->path);
+		share->create_mask = resp->create_mask;
+		share->directory_mask = resp->directory_mask;
+		share->force_create_mode = resp->force_create_mode;
+		share->force_directory_mode = resp->force_directory_mode;
+		share->force_uid = resp->force_uid;
+		share->force_gid = resp->force_gid;
+		ret = parse_veto_list(share,
+				      KSMBD_SHARE_CONFIG_VETO_LIST(resp),
+				      resp->veto_list_sz);
+		if (!ret && share->path) {
+			ret = kern_path(share->path, 0, &share->vfs_path);
+			if (ret) {
+				ksmbd_debug(SMB, "failed to access '%s'\n",
+					    share->path);
+				/* Avoid put_path() */
+				kfree(share->path);
+				share->path = NULL;
+			}
+		}
+		if (ret || !share->name) {
+			kill_share(share);
+			share = NULL;
+			goto out;
+		}
+	}
+
+	down_write(&shares_table_lock);
+	lookup = __share_lookup(name);
+	if (lookup)
+		lookup = __get_share_config(lookup);
+	if (!lookup) {
+		hash_add(shares_table, &share->hlist, share_name_hash(name));
+	} else {
+		kill_share(share);
+		share = lookup;
+	}
+	up_write(&shares_table_lock);
+
+out:
+	kvfree(resp);
+	return share;
+}
+
+static void strtolower(char *share_name)
+{
+	while (*share_name) {
+		*share_name = tolower(*share_name);
+		share_name++;
+	}
+}
+
+struct ksmbd_share_config *ksmbd_share_config_get(char *name)
+{
+	struct ksmbd_share_config *share;
+
+	strtolower(name);
+
+	down_read(&shares_table_lock);
+	share = __share_lookup(name);
+	if (share)
+		share = __get_share_config(share);
+	up_read(&shares_table_lock);
+
+	if (share)
+		return share;
+	return share_config_request(name);
+}
+
+bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
+			       const char *filename)
+{
+	struct ksmbd_veto_pattern *p;
+
+	list_for_each_entry(p, &share->veto_list, list) {
+		if (match_wildcard(p->pattern, filename))
+			return true;
+	}
+	return false;
+}
+
+void ksmbd_share_configs_cleanup(void)
+{
+	struct ksmbd_share_config *share;
+	struct hlist_node *tmp;
+	int i;
+
+	down_write(&shares_table_lock);
+	hash_for_each_safe(shares_table, i, tmp, share, hlist) {
+		hash_del(&share->hlist);
+		kill_share(share);
+	}
+	up_write(&shares_table_lock);
+}
diff --git a/fs/ksmbd/mgmt/share_config.h b/fs/ksmbd/mgmt/share_config.h
new file mode 100644
index 000000000000..953befc94e84
--- /dev/null
+++ b/fs/ksmbd/mgmt/share_config.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __SHARE_CONFIG_MANAGEMENT_H__
+#define __SHARE_CONFIG_MANAGEMENT_H__
+
+#include <linux/workqueue.h>
+#include <linux/hashtable.h>
+#include <linux/path.h>
+
+struct ksmbd_share_config {
+	char			*name;
+	char			*path;
+
+	unsigned int		path_sz;
+	unsigned int		flags;
+	struct list_head	veto_list;
+
+	struct path		vfs_path;
+
+	atomic_t		refcount;
+	struct hlist_node	hlist;
+	unsigned short		create_mask;
+	unsigned short		directory_mask;
+	unsigned short		force_create_mode;
+	unsigned short		force_directory_mode;
+	unsigned short		force_uid;
+	unsigned short		force_gid;
+};
+
+#define KSMBD_SHARE_INVALID_UID	((__u16)-1)
+#define KSMBD_SHARE_INVALID_GID	((__u16)-1)
+
+static inline int share_config_create_mode(struct ksmbd_share_config *share,
+					   umode_t posix_mode)
+{
+	if (!share->force_create_mode) {
+		if (!posix_mode)
+			return share->create_mask;
+		else
+			return posix_mode & share->create_mask;
+	}
+	return share->force_create_mode & share->create_mask;
+}
+
+static inline int share_config_directory_mode(struct ksmbd_share_config *share,
+					      umode_t posix_mode)
+{
+	if (!share->force_directory_mode) {
+		if (!posix_mode)
+			return share->directory_mask;
+		else
+			return posix_mode & share->directory_mask;
+	}
+
+	return share->force_directory_mode & share->directory_mask;
+}
+
+static inline int test_share_config_flag(struct ksmbd_share_config *share,
+					 int flag)
+{
+	return share->flags & flag;
+}
+
+void __ksmbd_share_config_put(struct ksmbd_share_config *share);
+
+static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
+{
+	if (!atomic_dec_and_test(&share->refcount))
+		return;
+	__ksmbd_share_config_put(share);
+}
+
+struct ksmbd_share_config *ksmbd_share_config_get(char *name);
+bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
+			       const char *filename);
+void ksmbd_share_configs_cleanup(void);
+
+#endif /* __SHARE_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
new file mode 100644
index 000000000000..0d28e723a28c
--- /dev/null
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+
+#include "../transport_ipc.h"
+#include "../connection.h"
+
+#include "tree_connect.h"
+#include "user_config.h"
+#include "share_config.h"
+#include "user_session.h"
+
+struct ksmbd_tree_conn_status
+ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name)
+{
+	struct ksmbd_tree_conn_status status = {-EINVAL, NULL};
+	struct ksmbd_tree_connect_response *resp = NULL;
+	struct ksmbd_share_config *sc;
+	struct ksmbd_tree_connect *tree_conn = NULL;
+	struct sockaddr *peer_addr;
+	int ret;
+
+	sc = ksmbd_share_config_get(share_name);
+	if (!sc)
+		return status;
+
+	tree_conn = kzalloc(sizeof(struct ksmbd_tree_connect), GFP_KERNEL);
+	if (!tree_conn) {
+		status.ret = -ENOMEM;
+		goto out_error;
+	}
+
+	tree_conn->id = ksmbd_acquire_tree_conn_id(sess);
+	if (tree_conn->id < 0) {
+		status.ret = -EINVAL;
+		goto out_error;
+	}
+
+	peer_addr = KSMBD_TCP_PEER_SOCKADDR(sess->conn);
+	resp = ksmbd_ipc_tree_connect_request(sess,
+					      sc,
+					      tree_conn,
+					      peer_addr);
+	if (!resp) {
+		status.ret = -EINVAL;
+		goto out_error;
+	}
+
+	status.ret = resp->status;
+	if (status.ret != KSMBD_TREE_CONN_STATUS_OK)
+		goto out_error;
+
+	tree_conn->flags = resp->connection_flags;
+	tree_conn->user = sess->user;
+	tree_conn->share_conf = sc;
+	status.tree_conn = tree_conn;
+
+	ret = xa_err(xa_store(&sess->tree_conns, tree_conn->id, tree_conn,
+			      GFP_KERNEL));
+	if (ret) {
+		status.ret = -ENOMEM;
+		goto out_error;
+	}
+	kvfree(resp);
+	return status;
+
+out_error:
+	if (tree_conn)
+		ksmbd_release_tree_conn_id(sess, tree_conn->id);
+	ksmbd_share_config_put(sc);
+	kfree(tree_conn);
+	kvfree(resp);
+	return status;
+}
+
+int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
+			       struct ksmbd_tree_connect *tree_conn)
+{
+	int ret;
+
+	ret = ksmbd_ipc_tree_disconnect_request(sess->id, tree_conn->id);
+	ksmbd_release_tree_conn_id(sess, tree_conn->id);
+	xa_erase(&sess->tree_conns, tree_conn->id);
+	ksmbd_share_config_put(tree_conn->share_conf);
+	kfree(tree_conn);
+	return ret;
+}
+
+struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
+						  unsigned int id)
+{
+	return xa_load(&sess->tree_conns, id);
+}
+
+struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
+						 unsigned int id)
+{
+	struct ksmbd_tree_connect *tc;
+
+	tc = ksmbd_tree_conn_lookup(sess, id);
+	if (tc)
+		return tc->share_conf;
+	return NULL;
+}
+
+int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
+{
+	int ret = 0;
+	struct ksmbd_tree_connect *tc;
+	unsigned long id;
+
+	xa_for_each(&sess->tree_conns, id, tc)
+		ret |= ksmbd_tree_conn_disconnect(sess, tc);
+	xa_destroy(&sess->tree_conns);
+	return ret;
+}
diff --git a/fs/ksmbd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
new file mode 100644
index 000000000000..18e2a996e0aa
--- /dev/null
+++ b/fs/ksmbd/mgmt/tree_connect.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __TREE_CONNECT_MANAGEMENT_H__
+#define __TREE_CONNECT_MANAGEMENT_H__
+
+#include <linux/hashtable.h>
+
+#include "../ksmbd_netlink.h"
+
+struct ksmbd_share_config;
+struct ksmbd_user;
+
+struct ksmbd_tree_connect {
+	int				id;
+
+	unsigned int			flags;
+	struct ksmbd_share_config	*share_conf;
+	struct ksmbd_user		*user;
+
+	struct list_head		list;
+
+	int				maximal_access;
+	bool				posix_extensions;
+};
+
+struct ksmbd_tree_conn_status {
+	unsigned int			ret;
+	struct ksmbd_tree_connect	*tree_conn;
+};
+
+static inline int test_tree_conn_flag(struct ksmbd_tree_connect *tree_conn,
+				      int flag)
+{
+	return tree_conn->flags & flag;
+}
+
+struct ksmbd_session;
+
+struct ksmbd_tree_conn_status
+ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name);
+
+int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
+			       struct ksmbd_tree_connect *tree_conn);
+
+struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
+						  unsigned int id);
+
+struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
+						 unsigned int id);
+
+int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess);
+
+#endif /* __TREE_CONNECT_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/user_config.c b/fs/ksmbd/mgmt/user_config.c
new file mode 100644
index 000000000000..d21629ae5c89
--- /dev/null
+++ b/fs/ksmbd/mgmt/user_config.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include "user_config.h"
+#include "../transport_ipc.h"
+
+struct ksmbd_user *ksmbd_login_user(const char *account)
+{
+	struct ksmbd_login_response *resp;
+	struct ksmbd_user *user = NULL;
+
+	resp = ksmbd_ipc_login_request(account);
+	if (!resp)
+		return NULL;
+
+	if (!(resp->status & KSMBD_USER_FLAG_OK))
+		goto out;
+
+	user = ksmbd_alloc_user(resp);
+out:
+	kvfree(resp);
+	return user;
+}
+
+struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp)
+{
+	struct ksmbd_user *user = NULL;
+
+	user = kmalloc(sizeof(struct ksmbd_user), GFP_KERNEL);
+	if (!user)
+		return NULL;
+
+	user->name = kstrdup(resp->account, GFP_KERNEL);
+	user->flags = resp->status;
+	user->gid = resp->gid;
+	user->uid = resp->uid;
+	user->passkey_sz = resp->hash_sz;
+	user->passkey = kmalloc(resp->hash_sz, GFP_KERNEL);
+	if (user->passkey)
+		memcpy(user->passkey, resp->hash, resp->hash_sz);
+
+	if (!user->name || !user->passkey) {
+		kfree(user->name);
+		kfree(user->passkey);
+		kfree(user);
+		user = NULL;
+	}
+	return user;
+}
+
+void ksmbd_free_user(struct ksmbd_user *user)
+{
+	ksmbd_ipc_logout_request(user->name);
+	kfree(user->name);
+	kfree(user->passkey);
+	kfree(user);
+}
+
+int ksmbd_anonymous_user(struct ksmbd_user *user)
+{
+	if (user->name[0] == '\0')
+		return 1;
+	return 0;
+}
diff --git a/fs/ksmbd/mgmt/user_config.h b/fs/ksmbd/mgmt/user_config.h
new file mode 100644
index 000000000000..b2bb074a0150
--- /dev/null
+++ b/fs/ksmbd/mgmt/user_config.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __USER_CONFIG_MANAGEMENT_H__
+#define __USER_CONFIG_MANAGEMENT_H__
+
+#include "../glob.h"
+
+struct ksmbd_user {
+	unsigned short		flags;
+
+	unsigned int		uid;
+	unsigned int		gid;
+
+	char			*name;
+
+	size_t			passkey_sz;
+	char			*passkey;
+};
+
+static inline bool user_guest(struct ksmbd_user *user)
+{
+	return user->flags & KSMBD_USER_FLAG_GUEST_ACCOUNT;
+}
+
+static inline void set_user_flag(struct ksmbd_user *user, int flag)
+{
+	user->flags |= flag;
+}
+
+static inline int test_user_flag(struct ksmbd_user *user, int flag)
+{
+	return user->flags & flag;
+}
+
+static inline void set_user_guest(struct ksmbd_user *user)
+{
+}
+
+static inline char *user_passkey(struct ksmbd_user *user)
+{
+	return user->passkey;
+}
+
+static inline char *user_name(struct ksmbd_user *user)
+{
+	return user->name;
+}
+
+static inline unsigned int user_uid(struct ksmbd_user *user)
+{
+	return user->uid;
+}
+
+static inline unsigned int user_gid(struct ksmbd_user *user)
+{
+	return user->gid;
+}
+
+struct ksmbd_user *ksmbd_login_user(const char *account);
+struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp);
+void ksmbd_free_user(struct ksmbd_user *user);
+int ksmbd_anonymous_user(struct ksmbd_user *user);
+#endif /* __USER_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
new file mode 100644
index 000000000000..8d8ffd8c6f19
--- /dev/null
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/xarray.h>
+
+#include "ksmbd_ida.h"
+#include "user_session.h"
+#include "user_config.h"
+#include "tree_connect.h"
+#include "../transport_ipc.h"
+#include "../connection.h"
+#include "../vfs_cache.h"
+
+static DEFINE_IDA(session_ida);
+
+#define SESSION_HASH_BITS		3
+static DEFINE_HASHTABLE(sessions_table, SESSION_HASH_BITS);
+static DECLARE_RWSEM(sessions_table_lock);
+
+struct ksmbd_session_rpc {
+	int			id;
+	unsigned int		method;
+	struct list_head	list;
+};
+
+static void free_channel_list(struct ksmbd_session *sess)
+{
+	struct channel *chann, *tmp;
+
+	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
+				 chann_list) {
+		list_del(&chann->chann_list);
+		kfree(chann);
+	}
+}
+
+static void __session_rpc_close(struct ksmbd_session *sess,
+				struct ksmbd_session_rpc *entry)
+{
+	struct ksmbd_rpc_command *resp;
+
+	resp = ksmbd_rpc_close(sess, entry->id);
+	if (!resp)
+		pr_err("Unable to close RPC pipe %d\n", entry->id);
+
+	kvfree(resp);
+	ksmbd_rpc_id_free(entry->id);
+	kfree(entry);
+}
+
+static void ksmbd_session_rpc_clear_list(struct ksmbd_session *sess)
+{
+	struct ksmbd_session_rpc *entry;
+
+	while (!list_empty(&sess->rpc_handle_list)) {
+		entry = list_entry(sess->rpc_handle_list.next,
+				   struct ksmbd_session_rpc,
+				   list);
+
+		list_del(&entry->list);
+		__session_rpc_close(sess, entry);
+	}
+}
+
+static int __rpc_method(char *rpc_name)
+{
+	if (!strcmp(rpc_name, "\\srvsvc") || !strcmp(rpc_name, "srvsvc"))
+		return KSMBD_RPC_SRVSVC_METHOD_INVOKE;
+
+	if (!strcmp(rpc_name, "\\wkssvc") || !strcmp(rpc_name, "wkssvc"))
+		return KSMBD_RPC_WKSSVC_METHOD_INVOKE;
+
+	if (!strcmp(rpc_name, "LANMAN") || !strcmp(rpc_name, "lanman"))
+		return KSMBD_RPC_RAP_METHOD;
+
+	if (!strcmp(rpc_name, "\\samr") || !strcmp(rpc_name, "samr"))
+		return KSMBD_RPC_SAMR_METHOD_INVOKE;
+
+	if (!strcmp(rpc_name, "\\lsarpc") || !strcmp(rpc_name, "lsarpc"))
+		return KSMBD_RPC_LSARPC_METHOD_INVOKE;
+
+	pr_err("Unsupported RPC: %s\n", rpc_name);
+	return 0;
+}
+
+int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
+{
+	struct ksmbd_session_rpc *entry;
+	struct ksmbd_rpc_command *resp;
+	int method;
+
+	method = __rpc_method(rpc_name);
+	if (!method)
+		return -EINVAL;
+
+	entry = kzalloc(sizeof(struct ksmbd_session_rpc), GFP_KERNEL);
+	if (!entry)
+		return -EINVAL;
+
+	list_add(&entry->list, &sess->rpc_handle_list);
+	entry->method = method;
+	entry->id = ksmbd_ipc_id_alloc();
+	if (entry->id < 0)
+		goto error;
+
+	resp = ksmbd_rpc_open(sess, entry->id);
+	if (!resp)
+		goto error;
+
+	kvfree(resp);
+	return entry->id;
+error:
+	list_del(&entry->list);
+	kfree(entry);
+	return -EINVAL;
+}
+
+void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
+{
+	struct ksmbd_session_rpc *entry;
+
+	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
+		if (entry->id == id) {
+			list_del(&entry->list);
+			__session_rpc_close(sess, entry);
+			break;
+		}
+	}
+}
+
+int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
+{
+	struct ksmbd_session_rpc *entry;
+
+	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
+		if (entry->id == id)
+			return entry->method;
+	}
+	return 0;
+}
+
+void ksmbd_session_destroy(struct ksmbd_session *sess)
+{
+	if (!sess)
+		return;
+
+	if (!atomic_dec_and_test(&sess->refcnt))
+		return;
+
+	list_del(&sess->sessions_entry);
+
+	down_write(&sessions_table_lock);
+	hash_del(&sess->hlist);
+	up_write(&sessions_table_lock);
+
+	if (sess->user)
+		ksmbd_free_user(sess->user);
+
+	ksmbd_tree_conn_session_logoff(sess);
+	ksmbd_destroy_file_table(&sess->file_table);
+	ksmbd_session_rpc_clear_list(sess);
+	free_channel_list(sess);
+	kfree(sess->Preauth_HashValue);
+	ksmbd_release_id(&session_ida, sess->id);
+	kfree(sess);
+}
+
+static struct ksmbd_session *__session_lookup(unsigned long long id)
+{
+	struct ksmbd_session *sess;
+
+	hash_for_each_possible(sessions_table, sess, hlist, id) {
+		if (id == sess->id)
+			return sess;
+	}
+	return NULL;
+}
+
+void ksmbd_session_register(struct ksmbd_conn *conn,
+			    struct ksmbd_session *sess)
+{
+	sess->conn = conn;
+	list_add(&sess->sessions_entry, &conn->sessions);
+}
+
+void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
+{
+	struct ksmbd_session *sess;
+
+	while (!list_empty(&conn->sessions)) {
+		sess = list_entry(conn->sessions.next,
+				  struct ksmbd_session,
+				  sessions_entry);
+
+		ksmbd_session_destroy(sess);
+	}
+}
+
+static bool ksmbd_session_id_match(struct ksmbd_session *sess,
+				   unsigned long long id)
+{
+	return sess->id == id;
+}
+
+struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
+					   unsigned long long id)
+{
+	struct ksmbd_session *sess = NULL;
+
+	list_for_each_entry(sess, &conn->sessions, sessions_entry) {
+		if (ksmbd_session_id_match(sess, id))
+			return sess;
+	}
+	return NULL;
+}
+
+int get_session(struct ksmbd_session *sess)
+{
+	return atomic_inc_not_zero(&sess->refcnt);
+}
+
+void put_session(struct ksmbd_session *sess)
+{
+	if (atomic_dec_and_test(&sess->refcnt))
+		pr_err("get/%s seems to be mismatched.", __func__);
+}
+
+struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
+{
+	struct ksmbd_session *sess;
+
+	down_read(&sessions_table_lock);
+	sess = __session_lookup(id);
+	if (sess) {
+		if (!get_session(sess))
+			sess = NULL;
+	}
+	up_read(&sessions_table_lock);
+
+	return sess;
+}
+
+struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
+					       unsigned long long id)
+{
+	struct ksmbd_session *sess;
+
+	sess = ksmbd_session_lookup(conn, id);
+	if (!sess && conn->binding)
+		sess = ksmbd_session_lookup_slowpath(id);
+	return sess;
+}
+
+struct preauth_session *ksmbd_preauth_session_alloc(struct ksmbd_conn *conn,
+						    u64 sess_id)
+{
+	struct preauth_session *sess;
+
+	sess = kmalloc(sizeof(struct preauth_session), GFP_KERNEL);
+	if (!sess)
+		return NULL;
+
+	sess->id = sess_id;
+	memcpy(sess->Preauth_HashValue, conn->preauth_info->Preauth_HashValue,
+	       PREAUTH_HASHVALUE_SIZE);
+	list_add(&sess->preauth_entry, &conn->preauth_sess_table);
+
+	return sess;
+}
+
+static bool ksmbd_preauth_session_id_match(struct preauth_session *sess,
+					   unsigned long long id)
+{
+	return sess->id == id;
+}
+
+struct preauth_session *ksmbd_preauth_session_lookup(struct ksmbd_conn *conn,
+						     unsigned long long id)
+{
+	struct preauth_session *sess = NULL;
+
+	list_for_each_entry(sess, &conn->preauth_sess_table, preauth_entry) {
+		if (ksmbd_preauth_session_id_match(sess, id))
+			return sess;
+	}
+	return NULL;
+}
+
+static int __init_smb2_session(struct ksmbd_session *sess)
+{
+	int id = ksmbd_acquire_smb2_uid(&session_ida);
+
+	if (id < 0)
+		return -EINVAL;
+	sess->id = id;
+	return 0;
+}
+
+static struct ksmbd_session *__session_create(int protocol)
+{
+	struct ksmbd_session *sess;
+	int ret;
+
+	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
+	if (!sess)
+		return NULL;
+
+	if (ksmbd_init_file_table(&sess->file_table))
+		goto error;
+
+	set_session_flag(sess, protocol);
+	INIT_LIST_HEAD(&sess->sessions_entry);
+	xa_init(&sess->tree_conns);
+	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
+	INIT_LIST_HEAD(&sess->rpc_handle_list);
+	sess->sequence_number = 1;
+	atomic_set(&sess->refcnt, 1);
+
+	switch (protocol) {
+	case CIFDS_SESSION_FLAG_SMB2:
+		ret = __init_smb2_session(sess);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		goto error;
+
+	ida_init(&sess->tree_conn_ida);
+
+	if (protocol == CIFDS_SESSION_FLAG_SMB2) {
+		down_write(&sessions_table_lock);
+		hash_add(sessions_table, &sess->hlist, sess->id);
+		up_write(&sessions_table_lock);
+	}
+	return sess;
+
+error:
+	ksmbd_session_destroy(sess);
+	return NULL;
+}
+
+struct ksmbd_session *ksmbd_smb2_session_create(void)
+{
+	return __session_create(CIFDS_SESSION_FLAG_SMB2);
+}
+
+int ksmbd_acquire_tree_conn_id(struct ksmbd_session *sess)
+{
+	int id = -EINVAL;
+
+	if (test_session_flag(sess, CIFDS_SESSION_FLAG_SMB2))
+		id = ksmbd_acquire_smb2_tid(&sess->tree_conn_ida);
+
+	return id;
+}
+
+void ksmbd_release_tree_conn_id(struct ksmbd_session *sess, int id)
+{
+	if (id >= 0)
+		ksmbd_release_id(&sess->tree_conn_ida, id);
+}
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
new file mode 100644
index 000000000000..82289c3cbd2b
--- /dev/null
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __USER_SESSION_MANAGEMENT_H__
+#define __USER_SESSION_MANAGEMENT_H__
+
+#include <linux/hashtable.h>
+#include <linux/xarray.h>
+
+#include "../smb_common.h"
+#include "../ntlmssp.h"
+
+#define CIFDS_SESSION_FLAG_SMB2		BIT(1)
+
+#define PREAUTH_HASHVALUE_SIZE		64
+
+struct ksmbd_file_table;
+
+struct channel {
+	__u8			smb3signingkey[SMB3_SIGN_KEY_SIZE];
+	struct ksmbd_conn	*conn;
+	struct list_head	chann_list;
+};
+
+struct preauth_session {
+	__u8			Preauth_HashValue[PREAUTH_HASHVALUE_SIZE];
+	u64			id;
+	struct list_head	preauth_entry;
+};
+
+struct ksmbd_session {
+	u64				id;
+
+	struct ksmbd_user		*user;
+	struct ksmbd_conn		*conn;
+	unsigned int			sequence_number;
+	unsigned int			flags;
+
+	bool				sign;
+	bool				enc;
+	bool				is_anonymous;
+
+	int				state;
+	__u8				*Preauth_HashValue;
+
+	struct ntlmssp_auth		ntlmssp;
+	char				sess_key[CIFS_KEY_SIZE];
+
+	struct hlist_node		hlist;
+	struct list_head		ksmbd_chann_list;
+	struct xarray			tree_conns;
+	struct ida			tree_conn_ida;
+	struct list_head		rpc_handle_list;
+
+	__u8				smb3encryptionkey[SMB3_ENC_DEC_KEY_SIZE];
+	__u8				smb3decryptionkey[SMB3_ENC_DEC_KEY_SIZE];
+	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
+
+	struct list_head		sessions_entry;
+	struct ksmbd_file_table		file_table;
+	atomic_t			refcnt;
+};
+
+static inline int test_session_flag(struct ksmbd_session *sess, int bit)
+{
+	return sess->flags & bit;
+}
+
+static inline void set_session_flag(struct ksmbd_session *sess, int bit)
+{
+	sess->flags |= bit;
+}
+
+static inline void clear_session_flag(struct ksmbd_session *sess, int bit)
+{
+	sess->flags &= ~bit;
+}
+
+struct ksmbd_session *ksmbd_smb2_session_create(void);
+
+void ksmbd_session_destroy(struct ksmbd_session *sess);
+
+struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id);
+struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
+					   unsigned long long id);
+void ksmbd_session_register(struct ksmbd_conn *conn,
+			    struct ksmbd_session *sess);
+void ksmbd_sessions_deregister(struct ksmbd_conn *conn);
+struct ksmbd_session *ksmbd_session_lookup_all(struct ksmbd_conn *conn,
+					       unsigned long long id);
+struct preauth_session *ksmbd_preauth_session_alloc(struct ksmbd_conn *conn,
+						    u64 sess_id);
+struct preauth_session *ksmbd_preauth_session_lookup(struct ksmbd_conn *conn,
+						     unsigned long long id);
+
+int ksmbd_acquire_tree_conn_id(struct ksmbd_session *sess);
+void ksmbd_release_tree_conn_id(struct ksmbd_session *sess, int id);
+
+int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name);
+void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id);
+int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id);
+int get_session(struct ksmbd_session *sess);
+void put_session(struct ksmbd_session *sess);
+#endif /* __USER_SESSION_MANAGEMENT_H__ */
-- 
2.17.1

