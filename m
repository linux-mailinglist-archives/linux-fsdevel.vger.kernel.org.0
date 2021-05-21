Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3AA38BF89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 08:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhEUGi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 02:38:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:54215 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhEUGhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 02:37:46 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210521063559epoutp01c3f07f8072b1bdcf6a77b48b21b0e7f8~BAXjrp4qY2334323343epoutp01q
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 06:35:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210521063559epoutp01c3f07f8072b1bdcf6a77b48b21b0e7f8~BAXjrp4qY2334323343epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621578959;
        bh=edRXD7RvN7pJ1mb2tJozuVYj1RmTxWSVbMoTfFi8Rwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAk0oQY4xfFOEUQadFBtrFNmwlGgTxwrHsGzO6T8g3lHdIVLamyEzUSYlY/BAtbjJ
         c+j2l0W1Otktj2vkP1Q21yuzK13QR/DAQseZftTyPRc/1MZ6mxUZ01cqCGXzdIvqQt
         0LI3DGQlIuNt3cK6mGW7BSc2D6v+9slV9pRAfhjk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210521063559epcas1p1702c6c989c3b8357b80129a3ee2e6ea1~BAXjLntdL2289222892epcas1p1v;
        Fri, 21 May 2021 06:35:59 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FmcLk1Sw5z4x9QQ; Fri, 21 May
        2021 06:35:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.EE.09701.EC457A06; Fri, 21 May 2021 15:35:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210521063557epcas1p20d8b4fc461f05c1a9c638605e85adbd8~BAXh1BUSy0404004040epcas1p2q;
        Fri, 21 May 2021 06:35:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210521063557epsmtrp25e86458f4e81a8ac6e1a8cad857f4454~BAXhz2t6x1342813428epsmtrp2i;
        Fri, 21 May 2021 06:35:57 +0000 (GMT)
X-AuditID: b6c32a36-c0126a80000025e5-ac-60a754ceb2e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.4E.08163.DC457A06; Fri, 21 May 2021 15:35:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210521063557epsmtip142464284dddea1bd2850ec9dc70826ac~BAXhetukQ1555115551epsmtip1r;
        Fri, 21 May 2021 06:35:57 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        willy@infradead.org, Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v3 07/10] cifsd: add oplock/lease cache mechanism
Date:   Fri, 21 May 2021 15:26:34 +0900
Message-Id: <20210521062637.31347-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521062637.31347-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmru65kOUJBrtesFs0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InKsclITUxJ
        LVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBelFJoSwxpxQoFJBY
        XKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCTcevqe5aC
        3xOZK/5Ov8HewPj2JFMXIweHhICJxK3bEl2MXBxCAjsYJa6v/cUM4XxilLjd8B7I4QRyPjNK
        nO1SAbFBGmYvPcwCUbSLUaLh6AaEjp3/ZzKCjGUT0Jb4s0UUpEFEIFbixo7XYDXMAruYJc4u
        esEIkhAWcJToa7jABmKzCKhKzJ7UBNbLK2AjsahHEWKZvMTqDQfAjuAUsJV4+n0BK0T8BofE
        ibnRELaLxIyHu1ggbGGJV8e3sEPYUhKf3+1lg7DLJU6c/MUEYddIbJi3jx3ie2OJnhclICaz
        gKbE+l36EBWKEjt/zwU7klmAT+Ld1x5WiGpeiY42IYgSVYm+S4ehBkpLdLV/gFrqIfH12T9o
        6ExglLg7/TT7BEa5WQgbFjAyrmIUSy0ozk1PLTYsMEKOr02M4BSsZbaDcdLbD3qHGJk4GA8x
        SnAwK4nwcjsuTxDiTUmsrEotyo8vKs1JLT7EaAoMuYnMUqLJ+cAskFcSb2hqZGxsbGFiZm5m
        aqwkzpvuXJ0gJJCeWJKanZpakFoE08fEwSnVwCR9h/8L15ezr/i+ZHf1XHI6xRPx2/Z0UHj7
        nOq52w65BLyOtZmv8/lk477WsPh3L5aX797fpy3E6D1vf11gS7TFpvC1D499PLNw1hKvgqQj
        8fUXg2M/+T76NqGYg8Hyr7bau269Rre0RJ6DTR+OKSyf+nL6tNKl7OHnbp9yUeorit6ts+/q
        9zVTGGxCW863dfw913Ps+6eDNypnt4t2RC1Zy2VgsOB2zzxG3cfLvI7EMNxUzWqsWHp6T4HW
        r6N7rM8eE2rmqPhW4P/77I3cAqMc/pkb/k7aaHBg9df/V69d2P9q8d9OfV8VCct8xo4CdpGv
        i9orRV7+44pXzb659NyU5zIqbRU7edl4t6icWrRQiaU4I9FQi7moOBEAFHM7hkoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnO7ZkOUJBj8vK1k0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InisklJzcks
        Sy3St0vgyrh19T1Lwe+JzBV/p99gb2B8e5Kpi5GTQ0LARGL20sMsXYxcHEICOxgl9l2YzgKR
        kJY4duIMcxcjB5AtLHH4cDFIWEjgA6PEy3k2IGE2AW2JP1tEQcIiAvESNxtug41hFjjDLNHQ
        sgdsjLCAo0RfwwU2EJtFQFVi9qQmRpBeXgEbiUU9ihCb5CVWbzjADGJzCthKPP2+gBVilY1E
        z82V7BMY+RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOFi2tHYx7Vn3QO8TI
        xMF4iFGCg1lJhJfbcXmCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KL
        YLJMHJxSDUy2++t0VKLEInXlTxmxt/McT7oRn/njZjUTl+G3FQekZgYcZ5N/PInB8mbKu7dW
        a8R+uEQfiz8qeP7gRp9Q07T1S6p/ayy8qrBRf4NT0rsrj7wcq/e82bpA9RCzrvTTY3qscY/f
        77qQ+er209/JBjzZ/Vds5vRt/np6dssfzeaHZz+HadUqX3Ao2f6yu7X94fFXPUcmOu8VmGj7
        r+NJwbJw/z/lkbypR/dOyty95Jt3+qJf7M4OU8QLk3sfC0f7P53SHmJ9bPe1dy8Ycww6zB+J
        HZyn7CQs8iUz7eEyDY25EZHJ3rYRnFcnns+esDHYarP0zS1NDFunXfLezL1pRalg6sfJrBOm
        9/zM1C1PdXuqxFKckWioxVxUnAgA6qHFigUDAAA=
X-CMS-MailID: 20210521063557epcas1p20d8b4fc461f05c1a9c638605e85adbd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210521063557epcas1p20d8b4fc461f05c1a9c638605e85adbd8
References: <20210521062637.31347-1-namjae.jeon@samsung.com>
        <CGME20210521063557epcas1p20d8b4fc461f05c1a9c638605e85adbd8@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds oplock and lease cache mechanism.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifsd/oplock.c | 1667 +++++++++++++++++++++++++++++++++++++++++++++
 fs/cifsd/oplock.h |  133 ++++
 2 files changed, 1800 insertions(+)
 create mode 100644 fs/cifsd/oplock.c
 create mode 100644 fs/cifsd/oplock.h

diff --git a/fs/cifsd/oplock.c b/fs/cifsd/oplock.c
new file mode 100644
index 000000000000..e77f1385a8c1
--- /dev/null
+++ b/fs/cifsd/oplock.c
@@ -0,0 +1,1667 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/moduleparam.h>
+
+#include "glob.h"
+#include "oplock.h"
+
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "buffer_pool.h"
+#include "connection.h"
+#include "mgmt/user_session.h"
+#include "mgmt/share_config.h"
+#include "mgmt/tree_connect.h"
+
+static LIST_HEAD(lease_table_list);
+static DEFINE_RWLOCK(lease_list_lock);
+
+/**
+ * alloc_opinfo() - allocate a new opinfo object for oplock info
+ * @work:	smb work
+ * @id:		fid of open file
+ * @Tid:	tree id of connection
+ *
+ * Return:      allocated opinfo object on success, otherwise NULL
+ */
+static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
+		u64 id, __u16 Tid)
+{
+	struct ksmbd_session *sess = work->sess;
+	struct oplock_info *opinfo;
+
+	opinfo = kzalloc(sizeof(struct oplock_info), GFP_KERNEL);
+	if (!opinfo)
+		return NULL;
+
+	opinfo->sess = sess;
+	opinfo->conn = sess->conn;
+	opinfo->level = OPLOCK_NONE;
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	opinfo->pending_break = 0;
+	opinfo->fid = id;
+	opinfo->Tid = Tid;
+	INIT_LIST_HEAD(&opinfo->op_entry);
+	INIT_LIST_HEAD(&opinfo->interim_list);
+	init_waitqueue_head(&opinfo->oplock_q);
+	init_waitqueue_head(&opinfo->oplock_brk);
+	atomic_set(&opinfo->refcount, 1);
+	atomic_set(&opinfo->breaking_cnt, 0);
+
+	return opinfo;
+}
+
+static void lease_add_list(struct oplock_info *opinfo)
+{
+	struct lease_table *lb = opinfo->o_lease->l_lb;
+
+	spin_lock(&lb->lb_lock);
+	list_add_rcu(&opinfo->lease_entry, &lb->lease_list);
+	spin_unlock(&lb->lb_lock);
+}
+
+static void lease_del_list(struct oplock_info *opinfo)
+{
+	struct lease_table *lb = opinfo->o_lease->l_lb;
+
+	if (!lb)
+		return;
+
+	spin_lock(&lb->lb_lock);
+	if (list_empty(&opinfo->lease_entry)) {
+		spin_unlock(&lb->lb_lock);
+		return;
+	}
+
+	list_del_init(&opinfo->lease_entry);
+	opinfo->o_lease->l_lb = NULL;
+	spin_unlock(&lb->lb_lock);
+}
+
+static void lb_add(struct lease_table *lb)
+{
+	write_lock(&lease_list_lock);
+	list_add(&lb->l_entry, &lease_table_list);
+	write_unlock(&lease_list_lock);
+}
+
+static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
+{
+	struct lease *lease;
+
+	lease = kmalloc(sizeof(struct lease), GFP_KERNEL);
+	if (!lease)
+		return -ENOMEM;
+
+	memcpy(lease->lease_key, lctx->lease_key, SMB2_LEASE_KEY_SIZE);
+	lease->state = lctx->req_state;
+	lease->new_state = 0;
+	lease->flags = lctx->flags;
+	lease->duration = lctx->duration;
+	INIT_LIST_HEAD(&opinfo->lease_entry);
+	opinfo->o_lease = lease;
+
+	return 0;
+}
+
+static void free_lease(struct oplock_info *opinfo)
+{
+	struct lease *lease;
+
+	lease = opinfo->o_lease;
+	kfree(lease);
+}
+
+static void free_opinfo(struct oplock_info *opinfo)
+{
+	if (opinfo->is_lease)
+		free_lease(opinfo);
+	kfree(opinfo);
+}
+
+static inline void opinfo_free_rcu(struct rcu_head *rcu_head)
+{
+	struct oplock_info *opinfo;
+
+	opinfo = container_of(rcu_head, struct oplock_info, rcu_head);
+	free_opinfo(opinfo);
+}
+
+struct oplock_info *opinfo_get(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo;
+
+	rcu_read_lock();
+	opinfo = rcu_dereference(fp->f_opinfo);
+	if (opinfo && !atomic_inc_not_zero(&opinfo->refcount))
+		opinfo = NULL;
+	rcu_read_unlock();
+
+	return opinfo;
+}
+
+static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
+{
+	struct oplock_info *opinfo;
+
+	if (list_empty(&ci->m_op_list))
+		return NULL;
+
+	rcu_read_lock();
+	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
+		op_entry);
+	if (opinfo && !atomic_inc_not_zero(&opinfo->refcount))
+		opinfo = NULL;
+	rcu_read_unlock();
+
+	return opinfo;
+}
+
+void opinfo_put(struct oplock_info *opinfo)
+{
+	if (!atomic_dec_and_test(&opinfo->refcount))
+		return;
+
+	call_rcu(&opinfo->rcu_head, opinfo_free_rcu);
+}
+
+static void opinfo_add(struct oplock_info *opinfo)
+{
+	struct ksmbd_inode *ci = opinfo->o_fp->f_ci;
+
+	write_lock(&ci->m_lock);
+	list_add_rcu(&opinfo->op_entry, &ci->m_op_list);
+	write_unlock(&ci->m_lock);
+}
+
+static void opinfo_del(struct oplock_info *opinfo)
+{
+	struct ksmbd_inode *ci = opinfo->o_fp->f_ci;
+
+	if (opinfo->is_lease) {
+		write_lock(&lease_list_lock);
+		lease_del_list(opinfo);
+		write_unlock(&lease_list_lock);
+	}
+	write_lock(&ci->m_lock);
+	list_del_rcu(&opinfo->op_entry);
+	write_unlock(&ci->m_lock);
+}
+
+static unsigned long opinfo_count(struct ksmbd_file *fp)
+{
+	if (ksmbd_stream_fd(fp))
+		return atomic_read(&fp->f_ci->sop_count);
+	else
+		return atomic_read(&fp->f_ci->op_count);
+}
+
+static void opinfo_count_inc(struct ksmbd_file *fp)
+{
+	if (ksmbd_stream_fd(fp))
+		return atomic_inc(&fp->f_ci->sop_count);
+	else
+		return atomic_inc(&fp->f_ci->op_count);
+}
+
+static void opinfo_count_dec(struct ksmbd_file *fp)
+{
+	if (ksmbd_stream_fd(fp))
+		return atomic_dec(&fp->f_ci->sop_count);
+	else
+		return atomic_dec(&fp->f_ci->op_count);
+}
+
+/**
+ * opinfo_write_to_read() - convert a write oplock to read oplock
+ * @opinfo:		current oplock info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int opinfo_write_to_read(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (!(opinfo->level == SMB2_OPLOCK_LEVEL_BATCH ||
+	      opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE)) {
+		ksmbd_err("bad oplock(0x%x)\n", opinfo->level);
+		if (opinfo->is_lease)
+			ksmbd_err("lease state(0x%x)\n", lease->state);
+		return -EINVAL;
+	}
+	opinfo->level = SMB2_OPLOCK_LEVEL_II;
+
+	if (opinfo->is_lease)
+		lease->state = lease->new_state;
+	return 0;
+}
+
+/**
+ * opinfo_read_handle_to_read() - convert a read/handle oplock to read oplock
+ * @opinfo:		current oplock info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int opinfo_read_handle_to_read(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	lease->state = lease->new_state;
+	opinfo->level = SMB2_OPLOCK_LEVEL_II;
+	return 0;
+}
+
+/**
+ * opinfo_write_to_none() - convert a write oplock to none
+ * @opinfo:	current oplock info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int opinfo_write_to_none(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (!(opinfo->level == SMB2_OPLOCK_LEVEL_BATCH ||
+	      opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE)) {
+		ksmbd_err("bad oplock(0x%x)\n", opinfo->level);
+		if (opinfo->is_lease)
+			ksmbd_err("lease state(0x%x)\n",
+					lease->state);
+		return -EINVAL;
+	}
+	opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+	if (opinfo->is_lease)
+		lease->state = lease->new_state;
+	return 0;
+}
+
+/**
+ * opinfo_read_to_none() - convert a write read to none
+ * @opinfo:	current oplock info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int opinfo_read_to_none(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (opinfo->level != SMB2_OPLOCK_LEVEL_II) {
+		ksmbd_err("bad oplock(0x%x)\n", opinfo->level);
+		if (opinfo->is_lease)
+			ksmbd_err("lease state(0x%x)\n", lease->state);
+		return -EINVAL;
+	}
+	opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+	if (opinfo->is_lease)
+		lease->state = lease->new_state;
+	return 0;
+}
+
+/**
+ * lease_read_to_write() - upgrade lease state from read to write
+ * @opinfo:	current lease info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int lease_read_to_write(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (!(lease->state & SMB2_LEASE_READ_CACHING_LE)) {
+		ksmbd_debug(OPLOCK, "bad lease state(0x%x)\n",
+				lease->state);
+		return -EINVAL;
+	}
+
+	lease->new_state = SMB2_LEASE_NONE_LE;
+	lease->state |= SMB2_LEASE_WRITE_CACHING_LE;
+	if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+		opinfo->level = SMB2_OPLOCK_LEVEL_BATCH;
+	else
+		opinfo->level = SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+	return 0;
+}
+
+/**
+ * lease_none_upgrade() - upgrade lease state from none
+ * @opinfo:	current lease info
+ * @new_state:	new lease state
+ *
+ * Return:	0 on success, otherwise -EINVAL
+ */
+static int lease_none_upgrade(struct oplock_info *opinfo, __le32 new_state)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (!(lease->state == SMB2_LEASE_NONE_LE)) {
+		ksmbd_debug(OPLOCK, "bad lease state(0x%x)\n",
+				lease->state);
+		return -EINVAL;
+	}
+
+	lease->new_state = SMB2_LEASE_NONE_LE;
+	lease->state = new_state;
+	if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+		if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+			opinfo->level = SMB2_OPLOCK_LEVEL_BATCH;
+		else
+			opinfo->level = SMB2_OPLOCK_LEVEL_II;
+	else if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+		opinfo->level = SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+	else if (lease->state & SMB2_LEASE_READ_CACHING_LE)
+		opinfo->level = SMB2_OPLOCK_LEVEL_II;
+
+	return 0;
+}
+
+/**
+ * close_id_del_oplock() - release oplock object at file close time
+ * @fp:		ksmbd file pointer
+ */
+void close_id_del_oplock(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo;
+
+	if (S_ISDIR(file_inode(fp->filp)->i_mode))
+		return;
+
+	opinfo = opinfo_get(fp);
+	if (!opinfo)
+		return;
+
+	opinfo_del(opinfo);
+
+	rcu_assign_pointer(fp->f_opinfo, NULL);
+	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
+		opinfo->op_state = OPLOCK_CLOSING;
+		wake_up_interruptible_all(&opinfo->oplock_q);
+		if (opinfo->is_lease) {
+			atomic_set(&opinfo->breaking_cnt, 0);
+			wake_up_interruptible_all(&opinfo->oplock_brk);
+		}
+	}
+
+	opinfo_count_dec(fp);
+	atomic_dec(&opinfo->refcount);
+	opinfo_put(opinfo);
+}
+
+/**
+ * grant_write_oplock() - grant exclusive/batch oplock or write lease
+ * @opinfo_new:	new oplock info object
+ * @req_oplock: request oplock
+ * @lctx:	lease context information
+ *
+ * Return:      0
+ */
+static void grant_write_oplock(struct oplock_info *opinfo_new, int req_oplock,
+		struct lease_ctx_info *lctx)
+{
+	struct lease *lease = opinfo_new->o_lease;
+
+	if (req_oplock == SMB2_OPLOCK_LEVEL_BATCH)
+		opinfo_new->level = SMB2_OPLOCK_LEVEL_BATCH;
+	else
+		opinfo_new->level = SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+
+	if (lctx) {
+		lease->state = lctx->req_state;
+		memcpy(lease->lease_key, lctx->lease_key,
+				SMB2_LEASE_KEY_SIZE);
+	}
+}
+
+/**
+ * grant_read_oplock() - grant level2 oplock or read lease
+ * @opinfo_new:	new oplock info object
+ * @lctx:	lease context information
+ *
+ * Return:      0
+ */
+static void grant_read_oplock(struct oplock_info *opinfo_new,
+		struct lease_ctx_info *lctx)
+{
+	struct lease *lease = opinfo_new->o_lease;
+
+	opinfo_new->level = SMB2_OPLOCK_LEVEL_II;
+
+	if (lctx) {
+		lease->state = SMB2_LEASE_READ_CACHING_LE;
+		if (lctx->req_state & SMB2_LEASE_HANDLE_CACHING_LE)
+			lease->state |= SMB2_LEASE_HANDLE_CACHING_LE;
+		memcpy(lease->lease_key, lctx->lease_key,
+				SMB2_LEASE_KEY_SIZE);
+	}
+}
+
+/**
+ * grant_none_oplock() - grant none oplock or none lease
+ * @opinfo_new:	new oplock info object
+ * @lctx:	lease context information
+ *
+ * Return:      0
+ */
+static void grant_none_oplock(struct oplock_info *opinfo_new,
+		struct lease_ctx_info *lctx)
+{
+	struct lease *lease = opinfo_new->o_lease;
+
+	opinfo_new->level = SMB2_OPLOCK_LEVEL_NONE;
+
+	if (lctx) {
+		lease->state = 0;
+		memcpy(lease->lease_key, lctx->lease_key,
+			SMB2_LEASE_KEY_SIZE);
+	}
+}
+
+static inline int compare_guid_key(struct oplock_info *opinfo,
+		const char *guid1, const char *key1)
+{
+	const char *guid2, *key2;
+
+	guid2 = opinfo->conn->ClientGUID;
+	key2 = opinfo->o_lease->lease_key;
+	if (!memcmp(guid1, guid2, SMB2_CLIENT_GUID_SIZE) &&
+	    !memcmp(key1, key2, SMB2_LEASE_KEY_SIZE))
+		return 1;
+
+	return 0;
+}
+
+/**
+ * same_client_has_lease() - check whether current lease request is
+ *		from lease owner of file
+ * @ci:		master file pointer
+ * @client_guid:	Client GUID
+ * @lctx:		lease context information
+ *
+ * Return:      oplock(lease) object on success, otherwise NULL
+ */
+static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
+		char *client_guid, struct lease_ctx_info *lctx)
+{
+	int ret;
+	struct lease *lease;
+	struct oplock_info *opinfo;
+	struct oplock_info *m_opinfo = NULL;
+
+	if (!lctx)
+		return NULL;
+
+	/*
+	 * Compare lease key and client_guid to know request from same owner
+	 * of same client
+	 */
+	read_lock(&ci->m_lock);
+	list_for_each_entry(opinfo, &ci->m_op_list, op_entry) {
+		if (!opinfo->is_lease)
+			continue;
+		read_unlock(&ci->m_lock);
+		lease = opinfo->o_lease;
+
+		ret = compare_guid_key(opinfo, client_guid, lctx->lease_key);
+		if (ret) {
+			m_opinfo = opinfo;
+			/* skip upgrading lease about breaking lease */
+			if (atomic_read(&opinfo->breaking_cnt)) {
+				read_lock(&ci->m_lock);
+				continue;
+			}
+
+			/* upgrading lease */
+			if ((atomic_read(&ci->op_count) +
+			     atomic_read(&ci->sop_count)) == 1) {
+				if (lease->state ==
+					(lctx->req_state & lease->state)) {
+					lease->state |= lctx->req_state;
+					if (lctx->req_state &
+						SMB2_LEASE_WRITE_CACHING_LE)
+						lease_read_to_write(opinfo);
+				}
+			} else if ((atomic_read(&ci->op_count) +
+				    atomic_read(&ci->sop_count)) > 1) {
+				if (lctx->req_state ==
+					(SMB2_LEASE_READ_CACHING_LE |
+					 SMB2_LEASE_HANDLE_CACHING_LE))
+					lease->state = lctx->req_state;
+			}
+
+			if (lctx->req_state && lease->state ==
+					SMB2_LEASE_NONE_LE)
+				lease_none_upgrade(opinfo, lctx->req_state);
+		}
+		read_lock(&ci->m_lock);
+	}
+	read_unlock(&ci->m_lock);
+
+	return m_opinfo;
+}
+
+static void wait_for_break_ack(struct oplock_info *opinfo)
+{
+	int rc = 0;
+
+	rc = wait_event_interruptible_timeout(opinfo->oplock_q,
+		opinfo->op_state == OPLOCK_STATE_NONE ||
+		opinfo->op_state == OPLOCK_CLOSING,
+		OPLOCK_WAIT_TIME);
+
+	/* is this a timeout ? */
+	if (!rc) {
+		if (opinfo->is_lease)
+			opinfo->o_lease->state = SMB2_LEASE_NONE_LE;
+		opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+		opinfo->op_state = OPLOCK_STATE_NONE;
+	}
+}
+
+static void wake_up_oplock_break(struct oplock_info *opinfo)
+{
+	clear_bit_unlock(0, &opinfo->pending_break);
+	/* memory barrier is needed for wake_up_bit() */
+	smp_mb__after_atomic();
+	wake_up_bit(&opinfo->pending_break, 0);
+}
+
+static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
+{
+	while (test_and_set_bit(0, &opinfo->pending_break)) {
+		wait_on_bit(&opinfo->pending_break, 0, TASK_UNINTERRUPTIBLE);
+
+		/* Not immediately break to none. */
+		opinfo->open_trunc = 0;
+
+		if (opinfo->op_state == OPLOCK_CLOSING)
+			return -ENOENT;
+		else if (!opinfo->is_lease && opinfo->level <= req_op_level)
+			return 1;
+	}
+
+	if (!opinfo->is_lease && opinfo->level <= req_op_level) {
+		wake_up_oplock_break(opinfo);
+		return 1;
+	}
+	return 0;
+}
+
+static inline int allocate_oplock_break_buf(struct ksmbd_work *work)
+{
+	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, GFP_KERNEL);
+	if (!work->response_buf)
+		return -ENOMEM;
+	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
+	return 0;
+}
+
+/**
+ * __smb2_oplock_break_noti() - send smb2 oplock break cmd from conn
+ * to client
+ * @wk:     smb work object
+ *
+ * There are two ways this function can be called. 1- while file open we break
+ * from exclusive/batch lock to levelII oplock and 2- while file write/truncate
+ * we break from levelII oplock no oplock.
+ * work->request_buf contains oplock_info.
+ */
+static void __smb2_oplock_break_noti(struct work_struct *wk)
+{
+	struct smb2_oplock_break *rsp = NULL;
+	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
+	struct ksmbd_conn *conn = work->conn;
+	struct oplock_break_info *br_info = work->request_buf;
+	struct smb2_hdr *rsp_hdr;
+	struct ksmbd_file *fp;
+
+	fp = ksmbd_lookup_durable_fd(br_info->fid);
+	if (!fp) {
+		atomic_dec(&conn->r_count);
+		ksmbd_free_work_struct(work);
+		return;
+	}
+
+	if (allocate_oplock_break_buf(work)) {
+		ksmbd_err("smb2_allocate_rsp_buf failed! ");
+		atomic_dec(&conn->r_count);
+		ksmbd_fd_put(work, fp);
+		ksmbd_free_work_struct(work);
+		return;
+	}
+
+	rsp_hdr = work->response_buf;
+	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
+	rsp_hdr->smb2_buf_length = cpu_to_be32(HEADER_SIZE_NO_BUF_LEN(conn));
+	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->CreditRequest = cpu_to_le16(0);
+	rsp_hdr->Command = SMB2_OPLOCK_BREAK;
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = cpu_to_le64(-1);
+	rsp_hdr->Id.SyncId.ProcessId = 0;
+	rsp_hdr->Id.SyncId.TreeId = 0;
+	rsp_hdr->SessionId = 0;
+	memset(rsp_hdr->Signature, 0, 16);
+
+	rsp = work->response_buf;
+
+	rsp->StructureSize = cpu_to_le16(24);
+	if (!br_info->open_trunc &&
+	    (br_info->level == SMB2_OPLOCK_LEVEL_BATCH ||
+	     br_info->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))
+		rsp->OplockLevel = SMB2_OPLOCK_LEVEL_II;
+	else
+		rsp->OplockLevel = SMB2_OPLOCK_LEVEL_NONE;
+	rsp->Reserved = 0;
+	rsp->Reserved2 = 0;
+	rsp->PersistentFid = cpu_to_le64(fp->persistent_id);
+	rsp->VolatileFid = cpu_to_le64(fp->volatile_id);
+
+	inc_rfc1001_len(rsp, 24);
+
+	ksmbd_debug(OPLOCK,
+		"sending oplock break v_id %llu p_id = %llu lock level = %d\n",
+		rsp->VolatileFid, rsp->PersistentFid, rsp->OplockLevel);
+
+	ksmbd_fd_put(work, fp);
+	ksmbd_conn_write(work);
+	ksmbd_free_work_struct(work);
+	atomic_dec(&conn->r_count);
+}
+
+/**
+ * smb2_oplock_break_noti() - send smb2 exclusive/batch to level2 oplock
+ *		break command from server to client
+ * @opinfo:		oplock info object
+ *
+ * Return:      0 on success, otherwise error
+ */
+static int smb2_oplock_break_noti(struct oplock_info *opinfo)
+{
+	struct ksmbd_conn *conn = opinfo->conn;
+	struct oplock_break_info *br_info;
+	int ret = 0;
+	struct ksmbd_work *work = ksmbd_alloc_work_struct();
+
+	if (!work)
+		return -ENOMEM;
+
+	br_info = kmalloc(sizeof(struct oplock_break_info), GFP_KERNEL);
+	if (!br_info) {
+		ksmbd_free_work_struct(work);
+		return -ENOMEM;
+	}
+
+	br_info->level = opinfo->level;
+	br_info->fid = opinfo->fid;
+	br_info->open_trunc = opinfo->open_trunc;
+
+	work->request_buf = (char *)br_info;
+	work->conn = conn;
+	work->sess = opinfo->sess;
+
+	atomic_inc(&conn->r_count);
+	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
+		INIT_WORK(&work->work, __smb2_oplock_break_noti);
+		ksmbd_queue_work(work);
+
+		wait_for_break_ack(opinfo);
+	} else {
+		__smb2_oplock_break_noti(&work->work);
+		if (opinfo->level == SMB2_OPLOCK_LEVEL_II)
+			opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+	}
+	return ret;
+}
+
+/**
+ * __smb2_lease_break_noti() - send lease break command from server
+ * to client
+ * @wk:     smb work object
+ */
+static void __smb2_lease_break_noti(struct work_struct *wk)
+{
+	struct smb2_lease_break *rsp = NULL;
+	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
+	struct lease_break_info *br_info = work->request_buf;
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *rsp_hdr;
+
+	if (allocate_oplock_break_buf(work)) {
+		ksmbd_debug(OPLOCK, "smb2_allocate_rsp_buf failed! ");
+		ksmbd_free_work_struct(work);
+		atomic_dec(&conn->r_count);
+		return;
+	}
+
+	rsp_hdr = work->response_buf;
+	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
+	rsp_hdr->smb2_buf_length = cpu_to_be32(HEADER_SIZE_NO_BUF_LEN(conn));
+	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->CreditRequest = cpu_to_le16(0);
+	rsp_hdr->Command = SMB2_OPLOCK_BREAK;
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = cpu_to_le64(-1);
+	rsp_hdr->Id.SyncId.ProcessId = 0;
+	rsp_hdr->Id.SyncId.TreeId = 0;
+	rsp_hdr->SessionId = 0;
+	memset(rsp_hdr->Signature, 0, 16);
+
+	rsp = work->response_buf;
+	rsp->StructureSize = cpu_to_le16(44);
+	rsp->Reserved = 0;
+	rsp->Flags = 0;
+
+	if (br_info->curr_state & (SMB2_LEASE_WRITE_CACHING_LE |
+			SMB2_LEASE_HANDLE_CACHING_LE))
+		rsp->Flags = SMB2_NOTIFY_BREAK_LEASE_FLAG_ACK_REQUIRED;
+
+	memcpy(rsp->LeaseKey, br_info->lease_key, SMB2_LEASE_KEY_SIZE);
+	rsp->CurrentLeaseState = br_info->curr_state;
+	rsp->NewLeaseState = br_info->new_state;
+	rsp->BreakReason = 0;
+	rsp->AccessMaskHint = 0;
+	rsp->ShareMaskHint = 0;
+
+	inc_rfc1001_len(rsp, 44);
+
+	ksmbd_conn_write(work);
+	ksmbd_free_work_struct(work);
+	atomic_dec(&conn->r_count);
+}
+
+/**
+ * smb2_lease_break_noti() - break lease when a new client request
+ *			write lease
+ * @opinfo:		conains lease state information
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int smb2_lease_break_noti(struct oplock_info *opinfo)
+{
+	struct ksmbd_conn *conn = opinfo->conn;
+	struct list_head *tmp, *t;
+	struct ksmbd_work *work;
+	struct lease_break_info *br_info;
+	struct lease *lease = opinfo->o_lease;
+
+	work = ksmbd_alloc_work_struct();
+	if (!work)
+		return -ENOMEM;
+
+	br_info = kmalloc(sizeof(struct lease_break_info), GFP_KERNEL);
+	if (!br_info) {
+		ksmbd_free_work_struct(work);
+		return -ENOMEM;
+	}
+
+	br_info->curr_state = lease->state;
+	br_info->new_state = lease->new_state;
+	memcpy(br_info->lease_key, lease->lease_key, SMB2_LEASE_KEY_SIZE);
+
+	work->request_buf = (char *)br_info;
+	work->conn = conn;
+	work->sess = opinfo->sess;
+
+	atomic_inc(&conn->r_count);
+	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
+		list_for_each_safe(tmp, t, &opinfo->interim_list) {
+			struct ksmbd_work *in_work;
+
+			in_work = list_entry(tmp, struct ksmbd_work,
+				interim_entry);
+			setup_async_work(in_work, NULL, NULL);
+			smb2_send_interim_resp(in_work, STATUS_PENDING);
+			list_del(&in_work->interim_entry);
+		}
+		INIT_WORK(&work->work, __smb2_lease_break_noti);
+		ksmbd_queue_work(work);
+		wait_for_break_ack(opinfo);
+	} else {
+		__smb2_lease_break_noti(&work->work);
+		if (opinfo->o_lease->new_state == SMB2_LEASE_NONE_LE) {
+			opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+			opinfo->o_lease->state = SMB2_LEASE_NONE_LE;
+		}
+	}
+	return 0;
+}
+
+static void wait_lease_breaking(struct oplock_info *opinfo)
+{
+	if (!opinfo->is_lease)
+		return;
+
+	wake_up_interruptible_all(&opinfo->oplock_brk);
+	if (atomic_read(&opinfo->breaking_cnt)) {
+		int ret = 0;
+
+		ret = wait_event_interruptible_timeout(opinfo->oplock_brk,
+			atomic_read(&opinfo->breaking_cnt) == 0, HZ);
+		if (!ret)
+			atomic_set(&opinfo->breaking_cnt, 0);
+	}
+}
+
+static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
+{
+	int err = 0;
+
+	/* Need to break exclusive/batch oplock, write lease or overwrite_if */
+	ksmbd_debug(OPLOCK,
+		"request to send oplock(level : 0x%x) break notification\n",
+		brk_opinfo->level);
+
+	if (brk_opinfo->is_lease) {
+		struct lease *lease = brk_opinfo->o_lease;
+
+		atomic_inc(&brk_opinfo->breaking_cnt);
+
+		err = oplock_break_pending(brk_opinfo, req_op_level);
+		if (err)
+			return err < 0 ? err : 0;
+
+		if (brk_opinfo->open_trunc) {
+			/*
+			 * Create overwrite break trigger the lease break to
+			 * none.
+			 */
+			lease->new_state = SMB2_LEASE_NONE_LE;
+		} else {
+			if (lease->state & SMB2_LEASE_WRITE_CACHING_LE) {
+				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+					lease->new_state =
+						SMB2_LEASE_READ_CACHING_LE |
+						SMB2_LEASE_HANDLE_CACHING_LE;
+				else
+					lease->new_state =
+						SMB2_LEASE_READ_CACHING_LE;
+			} else {
+				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+					lease->new_state =
+						SMB2_LEASE_READ_CACHING_LE;
+				else
+					lease->new_state = SMB2_LEASE_NONE_LE;
+			}
+		}
+
+		if (lease->state & (SMB2_LEASE_WRITE_CACHING_LE |
+				SMB2_LEASE_HANDLE_CACHING_LE))
+			brk_opinfo->op_state = OPLOCK_ACK_WAIT;
+		else
+			atomic_dec(&brk_opinfo->breaking_cnt);
+	} else {
+		err = oplock_break_pending(brk_opinfo, req_op_level);
+		if (err)
+			return err < 0 ? err : 0;
+
+		if (brk_opinfo->level == SMB2_OPLOCK_LEVEL_BATCH ||
+		    brk_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE)
+			brk_opinfo->op_state = OPLOCK_ACK_WAIT;
+	}
+
+	if (brk_opinfo->is_lease)
+		err = smb2_lease_break_noti(brk_opinfo);
+	else
+		err = smb2_oplock_break_noti(brk_opinfo);
+
+	ksmbd_debug(OPLOCK, "oplock granted = %d\n", brk_opinfo->level);
+	if (brk_opinfo->op_state == OPLOCK_CLOSING)
+		err = -ENOENT;
+	wake_up_oplock_break(brk_opinfo);
+
+	wait_lease_breaking(brk_opinfo);
+
+	return err;
+}
+
+void destroy_lease_table(struct ksmbd_conn *conn)
+{
+	struct lease_table *lb, *lbtmp;
+	struct oplock_info *opinfo;
+
+	write_lock(&lease_list_lock);
+	if (list_empty(&lease_table_list)) {
+		write_unlock(&lease_list_lock);
+		return;
+	}
+
+	list_for_each_entry_safe(lb, lbtmp, &lease_table_list, l_entry) {
+		if (conn && memcmp(lb->client_guid, conn->ClientGUID,
+				   SMB2_CLIENT_GUID_SIZE))
+			continue;
+again:
+		rcu_read_lock();
+		list_for_each_entry_rcu(opinfo, &lb->lease_list,
+				lease_entry) {
+			rcu_read_unlock();
+			lease_del_list(opinfo);
+			goto again;
+		}
+		rcu_read_unlock();
+		list_del(&lb->l_entry);
+		kfree(lb);
+	}
+	write_unlock(&lease_list_lock);
+}
+
+int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
+		struct lease_ctx_info *lctx)
+{
+	struct oplock_info *opinfo;
+	int err = 0;
+	struct lease_table *lb;
+
+	if (!lctx)
+		return err;
+
+	read_lock(&lease_list_lock);
+	if (list_empty(&lease_table_list)) {
+		read_unlock(&lease_list_lock);
+		return 0;
+	}
+
+	list_for_each_entry(lb, &lease_table_list, l_entry) {
+		if (!memcmp(lb->client_guid, sess->conn->ClientGUID,
+			    SMB2_CLIENT_GUID_SIZE))
+			goto found;
+	}
+	read_unlock(&lease_list_lock);
+
+	return 0;
+
+found:
+	rcu_read_lock();
+	list_for_each_entry_rcu(opinfo, &lb->lease_list,
+			lease_entry) {
+		if (!atomic_inc_not_zero(&opinfo->refcount))
+			continue;
+		rcu_read_unlock();
+		if (opinfo->o_fp->f_ci == ci)
+			goto op_next;
+		err = compare_guid_key(opinfo,
+				sess->conn->ClientGUID,
+				lctx->lease_key);
+		if (err) {
+			err = -EINVAL;
+			ksmbd_debug(OPLOCK,
+				"found same lease key is already used in other files\n");
+			opinfo_put(opinfo);
+			goto out;
+		}
+op_next:
+		opinfo_put(opinfo);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+out:
+	read_unlock(&lease_list_lock);
+	return err;
+}
+
+static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
+{
+	struct lease *lease1 = op1->o_lease;
+	struct lease *lease2 = op2->o_lease;
+
+	op2->level = op1->level;
+	lease2->state = lease1->state;
+	memcpy(lease2->lease_key, lease1->lease_key,
+		SMB2_LEASE_KEY_SIZE);
+	lease2->duration = lease1->duration;
+	lease2->flags = lease1->flags;
+}
+
+static int add_lease_global_list(struct oplock_info *opinfo)
+{
+	struct lease_table *lb;
+
+	read_lock(&lease_list_lock);
+	list_for_each_entry(lb, &lease_table_list, l_entry) {
+		if (!memcmp(lb->client_guid, opinfo->conn->ClientGUID,
+			    SMB2_CLIENT_GUID_SIZE)) {
+			opinfo->o_lease->l_lb = lb;
+			lease_add_list(opinfo);
+			read_unlock(&lease_list_lock);
+			return 0;
+		}
+	}
+	read_unlock(&lease_list_lock);
+
+	lb = kmalloc(sizeof(struct lease_table), GFP_KERNEL);
+	if (!lb)
+		return -ENOMEM;
+
+	memcpy(lb->client_guid, opinfo->conn->ClientGUID,
+			SMB2_CLIENT_GUID_SIZE);
+	INIT_LIST_HEAD(&lb->lease_list);
+	spin_lock_init(&lb->lb_lock);
+	opinfo->o_lease->l_lb = lb;
+	lease_add_list(opinfo);
+	lb_add(lb);
+	return 0;
+}
+
+static void set_oplock_level(struct oplock_info *opinfo, int level,
+		struct lease_ctx_info *lctx)
+{
+	switch (level) {
+	case SMB2_OPLOCK_LEVEL_BATCH:
+	case SMB2_OPLOCK_LEVEL_EXCLUSIVE:
+		grant_write_oplock(opinfo, level, lctx);
+		break;
+	case SMB2_OPLOCK_LEVEL_II:
+		grant_read_oplock(opinfo, lctx);
+		break;
+	default:
+		grant_none_oplock(opinfo, lctx);
+		break;
+	}
+}
+
+/**
+ * smb_grant_oplock() - handle oplock/lease request on file open
+ * @work:		smb work
+ * @req_op_level:	oplock level
+ * @pid:		id of open file
+ * @fp:			ksmbd file pointer
+ * @tid:		Tree id of connection
+ * @lctx:		lease context information on file open
+ * @share_ret:		share mode
+ *
+ * Return:      0 on success, otherwise error
+ */
+int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
+		struct ksmbd_file *fp, __u16 tid, struct lease_ctx_info *lctx,
+		int share_ret)
+{
+	struct ksmbd_session *sess = work->sess;
+	int err = 0;
+	struct oplock_info *opinfo = NULL, *prev_opinfo = NULL;
+	struct ksmbd_inode *ci = fp->f_ci;
+	bool prev_op_has_lease;
+	__le32 prev_op_state = 0;
+
+	/* not support directory lease */
+	if (S_ISDIR(file_inode(fp->filp)->i_mode)) {
+		if (lctx)
+			lctx->dlease = 1;
+		return 0;
+	}
+
+	opinfo = alloc_opinfo(work, pid, tid);
+	if (!opinfo)
+		return -ENOMEM;
+
+	if (lctx) {
+		err = alloc_lease(opinfo, lctx);
+		if (err)
+			goto err_out;
+		opinfo->is_lease = 1;
+	}
+
+	/* ci does not have any oplock */
+	if (!opinfo_count(fp))
+		goto set_lev;
+
+	/* grant none-oplock if second open is trunc */
+	if (ATTR_FP(fp)) {
+		req_op_level = SMB2_OPLOCK_LEVEL_NONE;
+		goto set_lev;
+	}
+
+	if (lctx) {
+		struct oplock_info *m_opinfo;
+
+		/* is lease already granted ? */
+		m_opinfo = same_client_has_lease(ci, sess->conn->ClientGUID,
+			lctx);
+		if (m_opinfo) {
+			copy_lease(m_opinfo, opinfo);
+			if (atomic_read(&m_opinfo->breaking_cnt))
+				opinfo->o_lease->flags =
+					SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE;
+			goto out;
+		}
+	}
+	prev_opinfo = opinfo_get_list(ci);
+	if (!prev_opinfo ||
+	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx))
+		goto set_lev;
+	prev_op_has_lease = prev_opinfo->is_lease;
+	if (prev_op_has_lease)
+		prev_op_state = prev_opinfo->o_lease->state;
+
+	if (share_ret < 0 &&
+	    prev_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
+		err = share_ret;
+		opinfo_put(prev_opinfo);
+		goto err_out;
+	}
+
+	if (prev_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
+	    prev_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
+		opinfo_put(prev_opinfo);
+		goto op_break_not_needed;
+	}
+
+	list_add(&work->interim_entry, &prev_opinfo->interim_list);
+	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II);
+	opinfo_put(prev_opinfo);
+	if (err == -ENOENT)
+		goto set_lev;
+	/* Check all oplock was freed by close */
+	else if (err < 0)
+		goto err_out;
+
+op_break_not_needed:
+	if (share_ret < 0) {
+		err = share_ret;
+		goto err_out;
+	}
+
+	if (req_op_level != SMB2_OPLOCK_LEVEL_NONE)
+		req_op_level = SMB2_OPLOCK_LEVEL_II;
+
+	/* grant fixed oplock on stacked locking between lease and oplock */
+	if (prev_op_has_lease && !lctx)
+		if (prev_op_state & SMB2_LEASE_HANDLE_CACHING_LE)
+			req_op_level = SMB2_OPLOCK_LEVEL_NONE;
+
+	if (!prev_op_has_lease && lctx) {
+		req_op_level = SMB2_OPLOCK_LEVEL_II;
+		lctx->req_state = SMB2_LEASE_READ_CACHING_LE;
+	}
+
+set_lev:
+	set_oplock_level(opinfo, req_op_level, lctx);
+
+out:
+	rcu_assign_pointer(fp->f_opinfo, opinfo);
+	opinfo->o_fp = fp;
+
+	opinfo_count_inc(fp);
+	opinfo_add(opinfo);
+	if (opinfo->is_lease) {
+		err = add_lease_global_list(opinfo);
+		if (err)
+			goto err_out;
+	}
+
+	return 0;
+err_out:
+	free_opinfo(opinfo);
+	return err;
+}
+
+/**
+ * smb_break_all_write_oplock() - break batch/exclusive oplock to level2
+ * @work:	smb work
+ * @fp:		ksmbd file pointer
+ * @is_trunc:	truncate on open
+ */
+static void smb_break_all_write_oplock(struct ksmbd_work *work,
+		struct ksmbd_file *fp, int is_trunc)
+{
+	struct oplock_info *brk_opinfo;
+
+	brk_opinfo = opinfo_get_list(fp->f_ci);
+	if (!brk_opinfo)
+		return;
+	if (brk_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
+	    brk_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
+		opinfo_put(brk_opinfo);
+		return;
+	}
+
+	brk_opinfo->open_trunc = is_trunc;
+	list_add(&work->interim_entry, &brk_opinfo->interim_list);
+	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II);
+	opinfo_put(brk_opinfo);
+}
+
+/**
+ * smb_break_all_levII_oplock() - send level2 oplock or read lease break command
+ *	from server to client
+ * @work:	smb work
+ * @fp:		ksmbd file pointer
+ * @is_trunc:	truncate on open
+ */
+void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
+		int is_trunc)
+{
+	struct oplock_info *op, *brk_op;
+	struct ksmbd_inode *ci;
+	struct ksmbd_conn *conn = work->sess->conn;
+
+	if (!test_share_config_flag(work->tcon->share_conf,
+				    KSMBD_SHARE_FLAG_OPLOCKS))
+		return;
+
+	ci = fp->f_ci;
+	op = opinfo_get(fp);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
+		if (!atomic_inc_not_zero(&brk_op->refcount))
+			continue;
+		rcu_read_unlock();
+		if (brk_op->is_lease && (brk_op->o_lease->state &
+		    (~(SMB2_LEASE_READ_CACHING_LE |
+				SMB2_LEASE_HANDLE_CACHING_LE)))) {
+			ksmbd_debug(OPLOCK, "unexpected lease state(0x%x)\n",
+					brk_op->o_lease->state);
+			goto next;
+		} else if (brk_op->level !=
+				SMB2_OPLOCK_LEVEL_II) {
+			ksmbd_debug(OPLOCK, "unexpected oplock(0x%x)\n",
+					brk_op->level);
+			goto next;
+		}
+
+		/* Skip oplock being break to none */
+		if (brk_op->is_lease && (brk_op->o_lease->new_state ==
+				SMB2_LEASE_NONE_LE) &&
+		    atomic_read(&brk_op->breaking_cnt))
+			goto next;
+
+		if (op && op->is_lease && brk_op->is_lease &&
+		    !memcmp(conn->ClientGUID, brk_op->conn->ClientGUID,
+			    SMB2_CLIENT_GUID_SIZE) &&
+		    !memcmp(op->o_lease->lease_key, brk_op->o_lease->lease_key,
+			    SMB2_LEASE_KEY_SIZE))
+			goto next;
+		brk_op->open_trunc = is_trunc;
+		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE);
+next:
+		opinfo_put(brk_op);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+	if (op)
+		opinfo_put(op);
+}
+
+/**
+ * smb_break_all_oplock() - break both batch/exclusive and level2 oplock
+ * @work:	smb work
+ * @fp:		ksmbd file pointer
+ */
+void smb_break_all_oplock(struct ksmbd_work *work, struct ksmbd_file *fp)
+{
+	if (!test_share_config_flag(work->tcon->share_conf,
+				    KSMBD_SHARE_FLAG_OPLOCKS))
+		return;
+
+	smb_break_all_write_oplock(work, fp, 1);
+	smb_break_all_levII_oplock(work, fp, 1);
+}
+
+/**
+ * smb2_map_lease_to_oplock() - map lease state to corresponding oplock type
+ * @lease_state:     lease type
+ *
+ * Return:      0 if no mapping, otherwise corresponding oplock type
+ */
+__u8 smb2_map_lease_to_oplock(__le32 lease_state)
+{
+	if (lease_state == (SMB2_LEASE_HANDLE_CACHING_LE |
+			    SMB2_LEASE_READ_CACHING_LE |
+			    SMB2_LEASE_WRITE_CACHING_LE)) {
+		return SMB2_OPLOCK_LEVEL_BATCH;
+	} else if (lease_state != SMB2_LEASE_WRITE_CACHING_LE &&
+		 lease_state & SMB2_LEASE_WRITE_CACHING_LE) {
+		if (!(lease_state & SMB2_LEASE_HANDLE_CACHING_LE))
+			return SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+	} else if (lease_state & SMB2_LEASE_READ_CACHING_LE) {
+		return SMB2_OPLOCK_LEVEL_II;
+	}
+	return 0;
+}
+
+/**
+ * create_lease_buf() - create lease context for open cmd response
+ * @rbuf:	buffer to create lease context response
+ * @lease:	buffer to stored parsed lease state information
+ */
+void create_lease_buf(u8 *rbuf, struct lease *lease)
+{
+	struct create_lease *buf = (struct create_lease *)rbuf;
+	char *LeaseKey = (char *)&lease->lease_key;
+
+	memset(buf, 0, sizeof(struct create_lease));
+	buf->lcontext.LeaseKeyLow = *((__le64 *)LeaseKey);
+	buf->lcontext.LeaseKeyHigh = *((__le64 *)(LeaseKey + 8));
+	buf->lcontext.LeaseFlags = lease->flags;
+	buf->lcontext.LeaseState = lease->state;
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+					(struct create_lease, lcontext));
+	buf->ccontext.DataLength = cpu_to_le32(sizeof(struct lease_context));
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+				(struct create_lease, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	buf->Name[0] = 'R';
+	buf->Name[1] = 'q';
+	buf->Name[2] = 'L';
+	buf->Name[3] = 's';
+}
+
+/**
+ * parse_lease_state() - parse lease context containted in file open request
+ * @open_req:	buffer containing smb2 file open(create) request
+ *
+ * Return:  oplock state, -ENOENT if create lease context not found
+ */
+struct lease_ctx_info *parse_lease_state(void *open_req)
+{
+	char *data_offset;
+	struct create_context *cc;
+	unsigned int next = 0;
+	char *name;
+	bool found = false;
+	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
+	struct lease_ctx_info *lreq = kzalloc(sizeof(struct lease_ctx_info),
+		GFP_KERNEL);
+	if (!lreq)
+		return NULL;
+
+	data_offset = (char *)req + 4 + le32_to_cpu(req->CreateContextsOffset);
+	cc = (struct create_context *)data_offset;
+	do {
+		cc = (struct create_context *)((char *)cc + next);
+		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
+		if (le16_to_cpu(cc->NameLength) != 4 ||
+		    strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
+			next = le32_to_cpu(cc->Next);
+			continue;
+		}
+		found = true;
+		break;
+	} while (next != 0);
+
+	if (found) {
+		struct create_lease *lc = (struct create_lease *)cc;
+		*((__le64 *)lreq->lease_key) = lc->lcontext.LeaseKeyLow;
+		*((__le64 *)(lreq->lease_key + 8)) = lc->lcontext.LeaseKeyHigh;
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		return lreq;
+	}
+
+	kfree(lreq);
+	return NULL;
+}
+
+/**
+ * smb2_find_context_vals() - find a particular context info in open request
+ * @open_req:	buffer containing smb2 file open(create) request
+ * @tag:	context name to search for
+ *
+ * Return:      pointer to requested context, NULL if @str context not found
+ */
+struct create_context *smb2_find_context_vals(void *open_req, const char *tag)
+{
+	char *data_offset;
+	struct create_context *cc;
+	unsigned int next = 0;
+	char *name;
+	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
+
+	data_offset = (char *)req + 4 + le32_to_cpu(req->CreateContextsOffset);
+	cc = (struct create_context *)data_offset;
+	do {
+		int val;
+
+		cc = (struct create_context *)((char *)cc + next);
+		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
+		val = le16_to_cpu(cc->NameLength);
+		if (val < 4)
+			return ERR_PTR(-EINVAL);
+
+		if (memcmp(name, tag, val) == 0)
+			return cc;
+		next = le32_to_cpu(cc->Next);
+	} while (next != 0);
+
+	return ERR_PTR(-ENOENT);
+}
+
+/**
+ * create_durable_rsp_buf() - create durable handle context
+ * @cc:	buffer to create durable context response
+ */
+void create_durable_rsp_buf(char *cc)
+{
+	struct create_durable_rsp *buf;
+
+	buf = (struct create_durable_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_durable_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_durable_rsp, Data));
+	buf->ccontext.DataLength = cpu_to_le32(8);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_durable_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	/* SMB2_CREATE_DURABLE_HANDLE_RESPONSE is "DHnQ" */
+	buf->Name[0] = 'D';
+	buf->Name[1] = 'H';
+	buf->Name[2] = 'n';
+	buf->Name[3] = 'Q';
+}
+
+/**
+ * create_durable_v2_rsp_buf() - create durable handle v2 context
+ * @cc:	buffer to create durable context response
+ * @fp: ksmbd file pointer
+ */
+void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp)
+{
+	struct create_durable_v2_rsp *buf;
+
+	buf = (struct create_durable_v2_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_durable_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_durable_rsp, Data));
+	buf->ccontext.DataLength = cpu_to_le32(8);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_durable_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	/* SMB2_CREATE_DURABLE_HANDLE_RESPONSE_V2 is "DH2Q" */
+	buf->Name[0] = 'D';
+	buf->Name[1] = 'H';
+	buf->Name[2] = '2';
+	buf->Name[3] = 'Q';
+
+	buf->Timeout = cpu_to_le32(fp->durable_timeout);
+}
+
+/**
+ * create_mxac_rsp_buf() - create query maximal access context
+ * @cc:			buffer to create maximal access context response
+ * @maximal_access:	maximal access
+ */
+void create_mxac_rsp_buf(char *cc, int maximal_access)
+{
+	struct create_mxac_rsp *buf;
+
+	buf = (struct create_mxac_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_mxac_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_mxac_rsp, QueryStatus));
+	buf->ccontext.DataLength = cpu_to_le32(8);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_mxac_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	/* SMB2_CREATE_QUERY_MAXIMAL_ACCESS_RESPONSE is "MxAc" */
+	buf->Name[0] = 'M';
+	buf->Name[1] = 'x';
+	buf->Name[2] = 'A';
+	buf->Name[3] = 'c';
+
+	buf->QueryStatus = STATUS_SUCCESS;
+	buf->MaximalAccess = cpu_to_le32(maximal_access);
+}
+
+void create_disk_id_rsp_buf(char *cc, __u64 file_id, __u64 vol_id)
+{
+	struct create_disk_id_rsp *buf;
+
+	buf = (struct create_disk_id_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_disk_id_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_disk_id_rsp, DiskFileId));
+	buf->ccontext.DataLength = cpu_to_le32(32);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_mxac_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	/* SMB2_CREATE_QUERY_ON_DISK_ID_RESPONSE is "QFid" */
+	buf->Name[0] = 'Q';
+	buf->Name[1] = 'F';
+	buf->Name[2] = 'i';
+	buf->Name[3] = 'd';
+
+	buf->DiskFileId = cpu_to_le64(file_id);
+	buf->VolumeId = cpu_to_le64(vol_id);
+}
+
+/**
+ * create_posix_rsp_buf() - create posix extension context
+ * @cc:	buffer to create posix on posix response
+ * @fp: ksmbd file pointer
+ */
+void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp)
+{
+	struct create_posix_rsp *buf;
+	struct inode *inode = FP_INODE(fp);
+
+	buf = (struct create_posix_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_posix_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_posix_rsp, nlink));
+	buf->ccontext.DataLength = cpu_to_le32(52);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_posix_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
+	/* SMB2_CREATE_TAG_POSIX is "0x93AD25509CB411E7B42383DE968BCD7C" */
+	buf->Name[0] = 0x93;
+	buf->Name[1] = 0xAD;
+	buf->Name[2] = 0x25;
+	buf->Name[3] = 0x50;
+	buf->Name[4] = 0x9C;
+	buf->Name[5] = 0xB4;
+	buf->Name[6] = 0x11;
+	buf->Name[7] = 0xE7;
+	buf->Name[8] = 0xB4;
+	buf->Name[9] = 0x23;
+	buf->Name[10] = 0x83;
+	buf->Name[11] = 0xDE;
+	buf->Name[12] = 0x96;
+	buf->Name[13] = 0x8B;
+	buf->Name[14] = 0xCD;
+	buf->Name[15] = 0x7C;
+
+	buf->nlink = cpu_to_le32(inode->i_nlink);
+	buf->reparse_tag = cpu_to_le32(fp->volatile_id);
+	buf->mode = cpu_to_le32(inode->i_mode);
+	id_to_sid(from_kuid(&init_user_ns, inode->i_uid),
+		SIDNFS_USER, (struct smb_sid *)&buf->SidBuffer[0]);
+	id_to_sid(from_kgid(&init_user_ns, inode->i_gid),
+		SIDNFS_GROUP, (struct smb_sid *)&buf->SidBuffer[20]);
+}
+
+/*
+ * Find lease object(opinfo) for given lease key/fid from lease
+ * break/file close path.
+ */
+/**
+ * lookup_lease_in_table() - find a matching lease info object
+ * @conn:	connection instance
+ * @lease_key:	lease key to be searched for
+ *
+ * Return:      opinfo if found matching opinfo, otherwise NULL
+ */
+struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
+		char *lease_key)
+{
+	struct oplock_info *opinfo = NULL, *ret_op = NULL;
+	struct lease_table *lt;
+	int ret;
+
+	read_lock(&lease_list_lock);
+	list_for_each_entry(lt, &lease_table_list, l_entry) {
+		if (!memcmp(lt->client_guid, conn->ClientGUID,
+			    SMB2_CLIENT_GUID_SIZE))
+			goto found;
+	}
+
+	read_unlock(&lease_list_lock);
+	return NULL;
+
+found:
+	rcu_read_lock();
+	list_for_each_entry_rcu(opinfo, &lt->lease_list, lease_entry) {
+		if (!atomic_inc_not_zero(&opinfo->refcount))
+			continue;
+		rcu_read_unlock();
+		if (!opinfo->op_state || opinfo->op_state == OPLOCK_CLOSING)
+			goto op_next;
+		if (!(opinfo->o_lease->state &
+		      (SMB2_LEASE_HANDLE_CACHING_LE |
+		       SMB2_LEASE_WRITE_CACHING_LE)))
+			goto op_next;
+		ret = compare_guid_key(opinfo, conn->ClientGUID,
+			lease_key);
+		if (ret) {
+			ksmbd_debug(OPLOCK, "found opinfo\n");
+			ret_op = opinfo;
+			goto out;
+		}
+op_next:
+		opinfo_put(opinfo);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+out:
+	read_unlock(&lease_list_lock);
+	return ret_op;
+}
+
+int smb2_check_durable_oplock(struct ksmbd_file *fp,
+		struct lease_ctx_info *lctx, char *name)
+{
+	struct oplock_info *opinfo = opinfo_get(fp);
+	int ret = 0;
+
+	if (opinfo && opinfo->is_lease) {
+		if (!lctx) {
+			ksmbd_err("open does not include lease\n");
+			ret = -EBADF;
+			goto out;
+		}
+		if (memcmp(opinfo->o_lease->lease_key, lctx->lease_key,
+			   SMB2_LEASE_KEY_SIZE)) {
+			ksmbd_err("invalid lease key\n");
+			ret = -EBADF;
+			goto out;
+		}
+		if (name && strcmp(fp->filename, name)) {
+			ksmbd_err("invalid name reconnect %s\n", name);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+out:
+	if (opinfo)
+		opinfo_put(opinfo);
+	return ret;
+}
diff --git a/fs/cifsd/oplock.h b/fs/cifsd/oplock.h
new file mode 100644
index 000000000000..f8b4b486eb93
--- /dev/null
+++ b/fs/cifsd/oplock.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_OPLOCK_H
+#define __KSMBD_OPLOCK_H
+
+#include "smb_common.h"
+
+#define OPLOCK_WAIT_TIME	(35 * HZ)
+
+/* SMB Oplock levels */
+#define OPLOCK_NONE      0
+#define OPLOCK_EXCLUSIVE 1
+#define OPLOCK_BATCH     2
+#define OPLOCK_READ      3  /* level 2 oplock */
+
+/* SMB2 Oplock levels */
+#define SMB2_OPLOCK_LEVEL_NONE          0x00
+#define SMB2_OPLOCK_LEVEL_II            0x01
+#define SMB2_OPLOCK_LEVEL_EXCLUSIVE     0x08
+#define SMB2_OPLOCK_LEVEL_BATCH         0x09
+#define SMB2_OPLOCK_LEVEL_LEASE         0xFF
+
+/* Oplock states */
+#define OPLOCK_STATE_NONE	0x00
+#define OPLOCK_ACK_WAIT		0x01
+#define OPLOCK_CLOSING		0x02
+
+#define OPLOCK_WRITE_TO_READ		0x01
+#define OPLOCK_READ_HANDLE_TO_READ	0x02
+#define OPLOCK_WRITE_TO_NONE		0x04
+#define OPLOCK_READ_TO_NONE		0x08
+
+#define SMB2_LEASE_KEY_SIZE		16
+
+struct lease_ctx_info {
+	__u8	lease_key[SMB2_LEASE_KEY_SIZE];
+	__le32	req_state;
+	__le32	flags;
+	__le64	duration;
+	int dlease;
+};
+
+struct lease_table {
+	char			client_guid[SMB2_CLIENT_GUID_SIZE];
+	struct list_head	lease_list;
+	struct list_head	l_entry;
+	spinlock_t		lb_lock;
+};
+
+struct lease {
+	__u8			lease_key[SMB2_LEASE_KEY_SIZE];
+	__le32			state;
+	__le32			new_state;
+	__le32			flags;
+	__le64			duration;
+	struct lease_table	*l_lb;
+};
+
+struct oplock_info {
+	struct ksmbd_conn	*conn;
+	struct ksmbd_session	*sess;
+	struct ksmbd_work	*work;
+	struct ksmbd_file	*o_fp;
+	int                     level;
+	int                     op_state;
+	unsigned long		pending_break;
+	u64			fid;
+	atomic_t		breaking_cnt;
+	atomic_t		refcount;
+	__u16                   Tid;
+	bool			is_lease;
+	bool			open_trunc;	/* truncate on open */
+	struct lease		*o_lease;
+	struct list_head        interim_list;
+	struct list_head        op_entry;
+	struct list_head        lease_entry;
+	wait_queue_head_t oplock_q; /* Other server threads */
+	wait_queue_head_t oplock_brk; /* oplock breaking wait */
+	struct rcu_head		rcu_head;
+};
+
+struct lease_break_info {
+	__le32			curr_state;
+	__le32			new_state;
+	char			lease_key[SMB2_LEASE_KEY_SIZE];
+};
+
+struct oplock_break_info {
+	int level;
+	int open_trunc;
+	int fid;
+};
+
+int smb_grant_oplock(struct ksmbd_work *work, int req_op_level,
+		u64 pid, struct ksmbd_file *fp, __u16 tid,
+		struct lease_ctx_info *lctx, int share_ret);
+void smb_break_all_levII_oplock(struct ksmbd_work *work,
+		struct ksmbd_file *fp, int is_trunc);
+
+int opinfo_write_to_read(struct oplock_info *opinfo);
+int opinfo_read_handle_to_read(struct oplock_info *opinfo);
+int opinfo_write_to_none(struct oplock_info *opinfo);
+int opinfo_read_to_none(struct oplock_info *opinfo);
+void close_id_del_oplock(struct ksmbd_file *fp);
+void smb_break_all_oplock(struct ksmbd_work *work, struct ksmbd_file *fp);
+struct oplock_info *opinfo_get(struct ksmbd_file *fp);
+void opinfo_put(struct oplock_info *opinfo);
+
+/* Lease related functions */
+void create_lease_buf(u8 *rbuf, struct lease *lease);
+struct lease_ctx_info *parse_lease_state(void *open_req);
+__u8 smb2_map_lease_to_oplock(__le32 lease_state);
+int lease_read_to_write(struct oplock_info *opinfo);
+
+/* Durable related functions */
+void create_durable_rsp_buf(char *cc);
+void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp);
+void create_mxac_rsp_buf(char *cc, int maximal_access);
+void create_disk_id_rsp_buf(char *cc, __u64 file_id, __u64 vol_id);
+void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp);
+struct create_context *smb2_find_context_vals(void *open_req, const char *str);
+struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
+		char *lease_key);
+int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
+		struct lease_ctx_info *lctx);
+void destroy_lease_table(struct ksmbd_conn *conn);
+int smb2_check_durable_oplock(struct ksmbd_file *fp,
+		struct lease_ctx_info *lctx, char *name);
+#endif /* __KSMBD_OPLOCK_H */
-- 
2.17.1

