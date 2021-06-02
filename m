Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE97397FCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 05:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhFBEAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 00:00:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27068 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFBEAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:00:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210602035819epoutp03a10546f666e0a41d63cc2327d29832c4~Ep9UO1jSW1180111801epoutp03a
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 03:58:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210602035819epoutp03a10546f666e0a41d63cc2327d29832c4~Ep9UO1jSW1180111801epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622606299;
        bh=OsHjH6TM8CM6bRRT0oXcFH9f0MudZ4/u/qKRTogBUVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdFlipyGvAWHWsLZF1YTEr3yEDemGI1VUEZRqzMqIe8s1twUvmWmrWP4qgOaQPDIq
         xKYQ/6peZlDD8SrTLhEH0AwQQ6byyES2Q4wa/swFX5KbL8E3701+mDVa5FHm3TYSNB
         pQczJRe0rlm5hiiWzscWbrohvJXuAAo6E7gon+qE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210602035818epcas1p3185edd69fd3e188d6ae94a33e7008010~Ep9TYHGS11758617586epcas1p3N;
        Wed,  2 Jun 2021 03:58:18 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FvwHF10Ngz4x9Pp; Wed,  2 Jun
        2021 03:58:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.28.09578.8D107B06; Wed,  2 Jun 2021 12:58:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210602035816epcas1p240598e76247034278ad45dc0827b2be7~Ep9RntVlR3069330693epcas1p2d;
        Wed,  2 Jun 2021 03:58:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210602035816epsmtrp17335f72d15c8b8781b611244ac39805c~Ep9RmYZ8g1621416214epsmtrp1O;
        Wed,  2 Jun 2021 03:58:16 +0000 (GMT)
X-AuditID: b6c32a35-fb9ff7000000256a-1e-60b701d82a16
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.25.08637.8D107B06; Wed,  2 Jun 2021 12:58:16 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210602035815epsmtip29e8cf5cf1e5dc80911cc95631fc34386~Ep9RE51e00074900749epsmtip2N;
        Wed,  2 Jun 2021 03:58:15 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, stfrench@microsoft.com, willy@infradead.org,
        aurelien.aptel@gmail.com, linux-cifsd-devel@lists.sourceforge.net,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, hch@lst.de, dan.carpenter@oracle.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v4 03/10] cifsd: add trasport layers
Date:   Wed,  2 Jun 2021 12:48:40 +0900
Message-Id: <20210602034847.5371-4-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602034847.5371-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmru4Nxu0JBv++Wlo0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InKsclITUxJ
        LVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBelFJoSwxpxQoFJBY
        XKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCTMefFd9aC
        dfM4Ky5fPcLcwLjwJHsXIyeHhICJxO/Wj0A2F4eQwA5GiUvrJ7NBOJ8YJV7fuscI4XxjlFj7
        5QBQhgOsZenEZJBuIYG9jBInJ5hB2EANPdOkQUrYBLQl/mwRBQmLCMRK3NjxmhlkDLPALmaJ
        rfc3sYEkhIHG/Ly+jwnEZhFQlfh/8h8ziM0rYC2xfO8MqOvkJVZvOAAW5xSwkVh9bQrYcRIC
        Vzgkbs57wAhR5CLRdXQlE4QtLPHq+BaoZimJl/1tUHa5xImTv6BqaiQ2zNvHDvGLsUTPixIQ
        k1lAU2L9Ln2ICkWJnb/ngk1nFuCTePe1hxWimleio00IokRVou/SYaiB0hJd7R+gFnlIbDt0
        ARpq/YwS5/+sYZ3AKDcLYcMCRsZVjGKpBcW56anFhgWGyBG2iRGchLVMdzBOfPtB7xAjEwfj
        IUYJDmYlEV73vK0JQrwpiZVVqUX58UWlOanFhxhNgWE3kVlKNDkfmAfySuINTY2MjY0tTMzM
        zUyNlcR5052rE4QE0hNLUrNTUwtSi2D6mDg4pRqYbmn+mc9zYPYNKacrey133Itdt/DPz0On
        zPUa7FP3xy+snOPC/vaEjO//lGRzu9V/u21vXbntvonT9scRg5ziVhX98gkPJ7p53277M/fi
        Zn0WhkzrvbG9UUfEzoSICTxaeeaj4rXXqWfntZcWyO9YL7OK32VTvMzrfcIha45/TlC7dOKE
        2IFJcfmLom9e7/ul+PXkfF6GHxPifEUvpj1aH/ni9RRPli7GLVv5t2vP1Nq06v7hZMezXgqs
        Gf5xZtl+1y/Nnrv57K+fMatWzBS5v2WC9ZnVeubse5atTvrT3pb52c7vpOLLk8vPOHjp8HX9
        nfdaNjta7PWmF/NztSKS/SPOCTtzP2rzlA0ojZvzr0eJpTgj0VCLuag4EQB0fg66SwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO4Nxu0JBk/n8lo0vj3NYnH89V92
        i9f/prNYnJ6wiMli5eqjTBbX7r9nt3jxfxezxc//3xkt9uw9yWJxedccNosf0+stevs+sVq0
        XtGy2L1xEZvF2s+P2S3evDjMZnFr4nw2i/N/j7Na/P4xh81B2GN2w0UWj52z7rJ7bF6h5bF7
        wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK4InisklJzcks
        Sy3St0vgypjz4jtrwbp5nBWXrx5hbmBceJK9i5GDQ0LARGLpxOQuRk4OIYHdjBLNPVwgtoSA
        tMSxE2eYIUqEJQ4fLu5i5AIq+cAocevqF7A4m4C2xJ8toiDlIgLxEjcbbrOA1DALnGGWePrk
        KjtIQhho/M/r+5hAbBYBVYn/J/8xg9i8AtYSy/fOYIfYJS+xesMBsDingI3E6mtT2CDusZZY
        On8f+wRGvgWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKjRUtzB+P2VR/0DjEy
        cTAeYpTgYFYS4XXP25ogxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQi
        mCwTB6dUA1Pv++tOmT/uJjpuTWjqD30aIz5Tse5T0gTTTp0HzGemtvR05M8su6iQ8ef9Cq3c
        lb724np9uiI8h0RjrsyaEFFYdX5b58WyxsUmi7fs7A9iTF1z7FxiJsceqe8n96a/WPNrk4m2
        Qutj1zk3NoksV0wsNl//JfDqldCJTcePcHRWukz7eKohQk06ROGS0aYb1z6musZ5la1YwnJs
        675z7DKpHHxrJho23GNlfx6sndBhfKEqM2G7k5exTGrMmYu5c5qUzu65VrTTfpufq33wvNo+
        W4EwRbOm4otR5U1ewotKnedcvmu9fUVQYoFoYEaztb6PIf9Sn1eBTRV+MWunnZz8NP7GnZja
        rol506OllViKMxINtZiLihMBSVKE3QUDAAA=
X-CMS-MailID: 20210602035816epcas1p240598e76247034278ad45dc0827b2be7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602035816epcas1p240598e76247034278ad45dc0827b2be7
References: <20210602034847.5371-1-namjae.jeon@samsung.com>
        <CGME20210602035816epcas1p240598e76247034278ad45dc0827b2be7@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds transport layers(tcp, rdma, ipc).

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifsd/connection.c        |  411 +++++++
 fs/cifsd/connection.h        |  204 ++++
 fs/cifsd/mgmt/ksmbd_ida.c    |   46 +
 fs/cifsd/mgmt/ksmbd_ida.h    |   34 +
 fs/cifsd/mgmt/share_config.c |  239 ++++
 fs/cifsd/mgmt/share_config.h |   81 ++
 fs/cifsd/mgmt/tree_connect.c |  122 ++
 fs/cifsd/mgmt/tree_connect.h |   56 +
 fs/cifsd/mgmt/user_config.c  |   70 ++
 fs/cifsd/mgmt/user_config.h  |   66 ++
 fs/cifsd/mgmt/user_session.c |  328 ++++++
 fs/cifsd/mgmt/user_session.h |  101 ++
 fs/cifsd/transport_ipc.c     |  880 +++++++++++++++
 fs/cifsd/transport_ipc.h     |   47 +
 fs/cifsd/transport_rdma.c    | 2040 ++++++++++++++++++++++++++++++++++
 fs/cifsd/transport_rdma.h    |   61 +
 fs/cifsd/transport_tcp.c     |  620 +++++++++++
 fs/cifsd/transport_tcp.h     |   13 +
 18 files changed, 5419 insertions(+)
 create mode 100644 fs/cifsd/connection.c
 create mode 100644 fs/cifsd/connection.h
 create mode 100644 fs/cifsd/mgmt/ksmbd_ida.c
 create mode 100644 fs/cifsd/mgmt/ksmbd_ida.h
 create mode 100644 fs/cifsd/mgmt/share_config.c
 create mode 100644 fs/cifsd/mgmt/share_config.h
 create mode 100644 fs/cifsd/mgmt/tree_connect.c
 create mode 100644 fs/cifsd/mgmt/tree_connect.h
 create mode 100644 fs/cifsd/mgmt/user_config.c
 create mode 100644 fs/cifsd/mgmt/user_config.h
 create mode 100644 fs/cifsd/mgmt/user_session.c
 create mode 100644 fs/cifsd/mgmt/user_session.h
 create mode 100644 fs/cifsd/transport_ipc.c
 create mode 100644 fs/cifsd/transport_ipc.h
 create mode 100644 fs/cifsd/transport_rdma.c
 create mode 100644 fs/cifsd/transport_rdma.h
 create mode 100644 fs/cifsd/transport_tcp.c
 create mode 100644 fs/cifsd/transport_tcp.h

diff --git a/fs/cifsd/connection.c b/fs/cifsd/connection.c
new file mode 100644
index 000000000000..06c42309be72
--- /dev/null
+++ b/fs/cifsd/connection.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <namjae.jeon@protocolfreedom.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/mutex.h>
+#include <linux/freezer.h>
+#include <linux/module.h>
+
+#include "server.h"
+#include "buffer_pool.h"
+#include "smb_common.h"
+#include "mgmt/ksmbd_ida.h"
+#include "connection.h"
+#include "transport_tcp.h"
+#include "transport_rdma.h"
+
+static DEFINE_MUTEX(init_lock);
+
+static struct ksmbd_conn_ops default_conn_ops;
+
+static LIST_HEAD(conn_list);
+static DEFINE_RWLOCK(conn_list_lock);
+
+/**
+ * ksmbd_conn_free() - free resources of the connection instance
+ *
+ * @conn:	connection instance to be cleand up
+ *
+ * During the thread termination, the corresponding conn instance
+ * resources(sock/memory) are released and finally the conn object is freed.
+ */
+void ksmbd_conn_free(struct ksmbd_conn *conn)
+{
+	write_lock(&conn_list_lock);
+	list_del(&conn->conns_list);
+	write_unlock(&conn_list_lock);
+
+	kvfree(conn->request_buf);
+	kfree(conn->preauth_info);
+	kfree(conn);
+}
+
+/**
+ * ksmbd_conn_alloc() - initialize a new connection instance
+ *
+ * Return:	ksmbd_conn struct on success, otherwise NULL
+ */
+struct ksmbd_conn *ksmbd_conn_alloc(void)
+{
+	struct ksmbd_conn *conn;
+
+	conn = kzalloc(sizeof(struct ksmbd_conn), GFP_KERNEL);
+	if (!conn)
+		return NULL;
+
+	conn->need_neg = true;
+	conn->status = KSMBD_SESS_NEW;
+	conn->local_nls = load_nls("utf8");
+	if (!conn->local_nls)
+		conn->local_nls = load_nls_default();
+	atomic_set(&conn->req_running, 0);
+	atomic_set(&conn->r_count, 0);
+	init_waitqueue_head(&conn->req_running_q);
+	INIT_LIST_HEAD(&conn->conns_list);
+	INIT_LIST_HEAD(&conn->sessions);
+	INIT_LIST_HEAD(&conn->requests);
+	INIT_LIST_HEAD(&conn->async_requests);
+	spin_lock_init(&conn->request_lock);
+	spin_lock_init(&conn->credits_lock);
+	ida_init(&conn->async_ida);
+
+	write_lock(&conn_list_lock);
+	list_add(&conn->conns_list, &conn_list);
+	write_unlock(&conn_list_lock);
+	return conn;
+}
+
+bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
+{
+	struct ksmbd_conn *t;
+	bool ret = false;
+
+	read_lock(&conn_list_lock);
+	list_for_each_entry(t, &conn_list, conns_list) {
+		if (memcmp(t->ClientGUID, c->ClientGUID, SMB2_CLIENT_GUID_SIZE))
+			continue;
+
+		ret = true;
+		break;
+	}
+	read_unlock(&conn_list_lock);
+	return ret;
+}
+
+void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct list_head *requests_queue = NULL;
+
+	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
+		requests_queue = &conn->requests;
+		work->syncronous = true;
+	}
+
+	if (requests_queue) {
+		atomic_inc(&conn->req_running);
+		spin_lock(&conn->request_lock);
+		list_add_tail(&work->request_entry, requests_queue);
+		spin_unlock(&conn->request_lock);
+	}
+}
+
+int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	int ret = 1;
+
+	if (list_empty(&work->request_entry) &&
+	    list_empty(&work->async_request_entry))
+		return 0;
+
+	atomic_dec(&conn->req_running);
+	spin_lock(&conn->request_lock);
+	if (!work->multiRsp) {
+		list_del_init(&work->request_entry);
+		if (work->syncronous == false)
+			list_del_init(&work->async_request_entry);
+		ret = 0;
+	}
+	spin_unlock(&conn->request_lock);
+
+	wake_up_all(&conn->req_running_q);
+	return ret;
+}
+
+static void ksmbd_conn_lock(struct ksmbd_conn *conn)
+{
+	mutex_lock(&conn->srv_mutex);
+}
+
+static void ksmbd_conn_unlock(struct ksmbd_conn *conn)
+{
+	mutex_unlock(&conn->srv_mutex);
+}
+
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
+{
+	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
+}
+
+int ksmbd_conn_write(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb_hdr *rsp_hdr = work->response_buf;
+	size_t len = 0;
+	int sent;
+	struct kvec iov[3];
+	int iov_idx = 0;
+
+	ksmbd_conn_try_dequeue_request(work);
+	if (!rsp_hdr) {
+		ksmbd_err("NULL response header\n");
+		return -EINVAL;
+	}
+
+	if (work->tr_buf) {
+		iov[iov_idx] = (struct kvec) { work->tr_buf,
+				sizeof(struct smb2_transform_hdr) };
+		len += iov[iov_idx++].iov_len;
+	}
+
+	if (work->aux_payload_sz) {
+		iov[iov_idx] = (struct kvec) { rsp_hdr, work->resp_hdr_sz };
+		len += iov[iov_idx++].iov_len;
+		iov[iov_idx] = (struct kvec) { work->aux_payload_buf, work->aux_payload_sz };
+		len += iov[iov_idx++].iov_len;
+	} else {
+		if (work->tr_buf)
+			iov[iov_idx].iov_len = work->resp_hdr_sz;
+		else
+			iov[iov_idx].iov_len = get_rfc1002_len(rsp_hdr) + 4;
+		iov[iov_idx].iov_base = rsp_hdr;
+		len += iov[iov_idx++].iov_len;
+	}
+
+	ksmbd_conn_lock(conn);
+	sent = conn->transport->ops->writev(conn->transport, &iov[0],
+					iov_idx, len,
+					work->need_invalidate_rkey,
+					work->remote_key);
+	ksmbd_conn_unlock(conn);
+
+	if (sent < 0) {
+		ksmbd_err("Failed to send message: %d\n", sent);
+		return sent;
+	}
+
+	return 0;
+}
+
+int ksmbd_conn_rdma_read(struct ksmbd_conn *conn, void *buf,
+			 unsigned int buflen, u32 remote_key, u64 remote_offset,
+			 u32 remote_len)
+{
+	int ret = -EINVAL;
+
+	if (conn->transport->ops->rdma_read)
+		ret = conn->transport->ops->rdma_read(conn->transport,
+						      buf, buflen,
+						      remote_key, remote_offset,
+						      remote_len);
+	return ret;
+}
+
+int ksmbd_conn_rdma_write(struct ksmbd_conn *conn, void *buf,
+			  unsigned int buflen, u32 remote_key,
+			  u64 remote_offset, u32 remote_len)
+{
+	int ret = -EINVAL;
+
+	if (conn->transport->ops->rdma_write)
+		ret = conn->transport->ops->rdma_write(conn->transport,
+						       buf, buflen,
+						       remote_key, remote_offset,
+						       remote_len);
+	return ret;
+}
+
+bool ksmbd_conn_alive(struct ksmbd_conn *conn)
+{
+	if (!ksmbd_server_running())
+		return false;
+
+	if (conn->status == KSMBD_SESS_EXITING)
+		return false;
+
+	if (kthread_should_stop())
+		return false;
+
+	if (atomic_read(&conn->stats.open_files_count) > 0)
+		return true;
+
+	/*
+	 * Stop current session if the time that get last request from client
+	 * is bigger than deadtime user configured and openning file count is
+	 * zero.
+	 */
+	if (server_conf.deadtime > 0 &&
+	    time_after(jiffies, conn->last_active + server_conf.deadtime)) {
+		ksmbd_debug(CONN, "No response from client in %lu minutes\n",
+			    server_conf.deadtime / SMB_ECHO_INTERVAL);
+		return false;
+	}
+	return true;
+}
+
+/**
+ * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
+ * @p:		connection instance
+ *
+ * One thread each per connection
+ *
+ * Return:	0 on success
+ */
+int ksmbd_conn_handler_loop(void *p)
+{
+	struct ksmbd_conn *conn = (struct ksmbd_conn *)p;
+	struct ksmbd_transport *t = conn->transport;
+	unsigned int pdu_size;
+	char hdr_buf[4] = {0,};
+	int size;
+
+	mutex_init(&conn->srv_mutex);
+	__module_get(THIS_MODULE);
+
+	if (t->ops->prepare && t->ops->prepare(t))
+		goto out;
+
+	conn->last_active = jiffies;
+	while (ksmbd_conn_alive(conn)) {
+		if (try_to_freeze())
+			continue;
+
+		kvfree(conn->request_buf);
+		conn->request_buf = NULL;
+
+		size = t->ops->read(t, hdr_buf, sizeof(hdr_buf));
+		if (size != sizeof(hdr_buf))
+			break;
+
+		pdu_size = get_rfc1002_len(hdr_buf);
+		ksmbd_debug(CONN, "RFC1002 header %u bytes\n", pdu_size);
+
+		/* make sure we have enough to get to SMB header end */
+		if (!ksmbd_pdu_size_has_room(pdu_size)) {
+			ksmbd_debug(CONN, "SMB request too short (%u bytes)\n",
+				    pdu_size);
+			continue;
+		}
+
+		/* 4 for rfc1002 length field */
+		size = pdu_size + 4;
+		conn->request_buf = kvmalloc(size, GFP_KERNEL);
+		if (!conn->request_buf)
+			continue;
+
+		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
+		if (!ksmbd_smb_request(conn))
+			break;
+
+		/*
+		 * We already read 4 bytes to find out PDU size, now
+		 * read in PDU
+		 */
+		size = t->ops->read(t, conn->request_buf + 4, pdu_size);
+		if (size < 0) {
+			ksmbd_err("sock_read failed: %d\n", size);
+			break;
+		}
+
+		if (size != pdu_size) {
+			ksmbd_err("PDU error. Read: %d, Expected: %d\n",
+				  size,
+				  pdu_size);
+			continue;
+		}
+
+		if (!default_conn_ops.process_fn) {
+			ksmbd_err("No connection request callback\n");
+			break;
+		}
+
+		if (default_conn_ops.process_fn(conn)) {
+			ksmbd_err("Cannot handle request\n");
+			break;
+		}
+	}
+
+out:
+	/* Wait till all reference dropped to the Server object*/
+	while (atomic_read(&conn->r_count) > 0)
+		schedule_timeout(HZ);
+
+	unload_nls(conn->local_nls);
+	if (default_conn_ops.terminate_fn)
+		default_conn_ops.terminate_fn(conn);
+	t->ops->disconnect(t);
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops)
+{
+	default_conn_ops.process_fn = ops->process_fn;
+	default_conn_ops.terminate_fn = ops->terminate_fn;
+}
+
+int ksmbd_conn_transport_init(void)
+{
+	int ret;
+
+	mutex_lock(&init_lock);
+	ret = ksmbd_tcp_init();
+	if (ret) {
+		pr_err("Failed to init TCP subsystem: %d\n", ret);
+		goto out;
+	}
+
+	ret = ksmbd_rdma_init();
+	if (ret) {
+		pr_err("Failed to init KSMBD subsystem: %d\n", ret);
+		goto out;
+	}
+out:
+	mutex_unlock(&init_lock);
+	return ret;
+}
+
+static void stop_sessions(void)
+{
+	struct ksmbd_conn *conn;
+
+again:
+	read_lock(&conn_list_lock);
+	list_for_each_entry(conn, &conn_list, conns_list) {
+		struct task_struct *task;
+
+		task = conn->transport->handler;
+		if (task)
+			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
+				    task->comm, task_pid_nr(task));
+		conn->status = KSMBD_SESS_EXITING;
+	}
+	read_unlock(&conn_list_lock);
+
+	if (!list_empty(&conn_list)) {
+		schedule_timeout_interruptible(HZ / 10); /* 100ms */
+		goto again;
+	}
+}
+
+void ksmbd_conn_transport_destroy(void)
+{
+	mutex_lock(&init_lock);
+	ksmbd_tcp_destroy();
+	ksmbd_rdma_destroy();
+	stop_sessions();
+	mutex_unlock(&init_lock);
+}
diff --git a/fs/cifsd/connection.h b/fs/cifsd/connection.h
new file mode 100644
index 000000000000..1658442b27b0
--- /dev/null
+++ b/fs/cifsd/connection.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_CONNECTION_H__
+#define __KSMBD_CONNECTION_H__
+
+#include <linux/list.h>
+#include <linux/ip.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <net/inet_connection_sock.h>
+#include <net/request_sock.h>
+#include <linux/kthread.h>
+#include <linux/nls.h>
+
+#include "smb_common.h"
+#include "ksmbd_work.h"
+
+#define KSMBD_SOCKET_BACKLOG		16
+
+/*
+ * WARNING
+ *
+ * This is nothing but a HACK. Session status should move to channel
+ * or to session. As of now we have 1 tcp_conn : 1 ksmbd_session, but
+ * we need to change it to 1 tcp_conn : N ksmbd_sessions.
+ */
+enum {
+	KSMBD_SESS_NEW = 0,
+	KSMBD_SESS_GOOD,
+	KSMBD_SESS_EXITING,
+	KSMBD_SESS_NEED_RECONNECT,
+	KSMBD_SESS_NEED_NEGOTIATE
+};
+
+struct ksmbd_stats {
+	atomic_t			open_files_count;
+	atomic64_t			request_served;
+};
+
+struct ksmbd_transport;
+
+struct ksmbd_conn {
+	struct smb_version_values	*vals;
+	struct smb_version_ops		*ops;
+	struct smb_version_cmds		*cmds;
+	unsigned int			max_cmds;
+	struct mutex			srv_mutex;
+	int				status;
+	unsigned int			cli_cap;
+	char				*request_buf;
+	struct ksmbd_transport		*transport;
+	struct nls_table		*local_nls;
+	struct list_head		conns_list;
+	/* smb session 1 per user */
+	struct list_head		sessions;
+	unsigned long			last_active;
+	/* How many request are running currently */
+	atomic_t			req_running;
+	/* References which are made for this Server object*/
+	atomic_t			r_count;
+	unsigned short			total_credits;
+	unsigned short			max_credits;
+	spinlock_t			credits_lock;
+	wait_queue_head_t		req_running_q;
+	/* Lock to protect requests list*/
+	spinlock_t			request_lock;
+	struct list_head		requests;
+	struct list_head		async_requests;
+	int				connection_type;
+	struct ksmbd_stats		stats;
+	char				ClientGUID[SMB2_CLIENT_GUID_SIZE];
+	union {
+		/* pending trans request table */
+		struct trans_state	*recent_trans;
+		/* Used by ntlmssp */
+		char			*ntlmssp_cryptkey;
+	};
+
+	struct preauth_integrity_info	*preauth_info;
+
+	bool				need_neg;
+	unsigned int			auth_mechs;
+	unsigned int			preferred_auth_mech;
+	bool				sign;
+	bool				use_spnego:1;
+	__u16				cli_sec_mode;
+	__u16				srv_sec_mode;
+	/* dialect index that server chose */
+	__u16				dialect;
+
+	char				*mechToken;
+
+	struct ksmbd_conn_ops	*conn_ops;
+
+	/* Preauth Session Table */
+	struct list_head		preauth_sess_table;
+
+	struct sockaddr_storage		peer_addr;
+
+	/* Identifier for async message */
+	struct ida			async_ida;
+
+	__le16				cipher_type;
+	__le16				compress_algorithm;
+	bool				posix_ext_supported;
+};
+
+struct ksmbd_conn_ops {
+	int	(*process_fn)(struct ksmbd_conn *conn);
+	int	(*terminate_fn)(struct ksmbd_conn *conn);
+};
+
+struct ksmbd_transport_ops {
+	int (*prepare)(struct ksmbd_transport *t);
+	void (*disconnect)(struct ksmbd_transport *t);
+	int (*read)(struct ksmbd_transport *t, char *buf, unsigned int size);
+	int (*writev)(struct ksmbd_transport *t, struct kvec *iovs, int niov,
+		      int size, bool need_invalidate_rkey,
+		      unsigned int remote_key);
+	int (*rdma_read)(struct ksmbd_transport *t, void *buf, unsigned int len,
+			 u32 remote_key, u64 remote_offset, u32 remote_len);
+	int (*rdma_write)(struct ksmbd_transport *t, void *buf,
+			  unsigned int len, u32 remote_key, u64 remote_offset,
+			  u32 remote_len);
+};
+
+struct ksmbd_transport {
+	struct ksmbd_conn		*conn;
+	struct ksmbd_transport_ops	*ops;
+	struct task_struct		*handler;
+};
+
+#define KSMBD_TCP_RECV_TIMEOUT	(7 * HZ)
+#define KSMBD_TCP_SEND_TIMEOUT	(5 * HZ)
+#define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
+
+bool ksmbd_conn_alive(struct ksmbd_conn *conn);
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
+struct ksmbd_conn *ksmbd_conn_alloc(void);
+void ksmbd_conn_free(struct ksmbd_conn *conn);
+bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
+int ksmbd_conn_write(struct ksmbd_work *work);
+int ksmbd_conn_rdma_read(struct ksmbd_conn *conn, void *buf,
+			 unsigned int buflen, u32 remote_key, u64 remote_offset,
+			 u32 remote_len);
+int ksmbd_conn_rdma_write(struct ksmbd_conn *conn, void *buf,
+			  unsigned int buflen, u32 remote_key, u64 remote_offset,
+			  u32 remote_len);
+void ksmbd_conn_enqueue_request(struct ksmbd_work *work);
+int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work);
+void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops);
+int ksmbd_conn_handler_loop(void *p);
+int ksmbd_conn_transport_init(void);
+void ksmbd_conn_transport_destroy(void);
+
+/*
+ * WARNING
+ *
+ * This is a hack. We will move status to a proper place once we land
+ * a multi-sessions support.
+ */
+static inline bool ksmbd_conn_good(struct ksmbd_work *work)
+{
+	return work->conn->status == KSMBD_SESS_GOOD;
+}
+
+static inline bool ksmbd_conn_need_negotiate(struct ksmbd_work *work)
+{
+	return work->conn->status == KSMBD_SESS_NEED_NEGOTIATE;
+}
+
+static inline bool ksmbd_conn_need_reconnect(struct ksmbd_work *work)
+{
+	return work->conn->status == KSMBD_SESS_NEED_RECONNECT;
+}
+
+static inline bool ksmbd_conn_exiting(struct ksmbd_work *work)
+{
+	return work->conn->status == KSMBD_SESS_EXITING;
+}
+
+static inline void ksmbd_conn_set_good(struct ksmbd_work *work)
+{
+	work->conn->status = KSMBD_SESS_GOOD;
+}
+
+static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_work *work)
+{
+	work->conn->status = KSMBD_SESS_NEED_NEGOTIATE;
+}
+
+static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_work *work)
+{
+	work->conn->status = KSMBD_SESS_NEED_RECONNECT;
+}
+
+static inline void ksmbd_conn_set_exiting(struct ksmbd_work *work)
+{
+	work->conn->status = KSMBD_SESS_EXITING;
+}
+#endif /* __CONNECTION_H__ */
diff --git a/fs/cifsd/mgmt/ksmbd_ida.c b/fs/cifsd/mgmt/ksmbd_ida.c
new file mode 100644
index 000000000000..54194d959a5e
--- /dev/null
+++ b/fs/cifsd/mgmt/ksmbd_ida.c
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
diff --git a/fs/cifsd/mgmt/ksmbd_ida.h b/fs/cifsd/mgmt/ksmbd_ida.h
new file mode 100644
index 000000000000..2bc07b16cfde
--- /dev/null
+++ b/fs/cifsd/mgmt/ksmbd_ida.h
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
diff --git a/fs/cifsd/mgmt/share_config.c b/fs/cifsd/mgmt/share_config.c
new file mode 100644
index 000000000000..bcc4ae4381b9
--- /dev/null
+++ b/fs/cifsd/mgmt/share_config.c
@@ -0,0 +1,239 @@
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
+#include "../buffer_pool.h"
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
+		share->path = kstrdup(KSMBD_SHARE_CONFIG_PATH(resp),
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
diff --git a/fs/cifsd/mgmt/share_config.h b/fs/cifsd/mgmt/share_config.h
new file mode 100644
index 000000000000..953befc94e84
--- /dev/null
+++ b/fs/cifsd/mgmt/share_config.h
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
diff --git a/fs/cifsd/mgmt/tree_connect.c b/fs/cifsd/mgmt/tree_connect.c
new file mode 100644
index 000000000000..029a9e81e844
--- /dev/null
+++ b/fs/cifsd/mgmt/tree_connect.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+
+#include "../buffer_pool.h"
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
diff --git a/fs/cifsd/mgmt/tree_connect.h b/fs/cifsd/mgmt/tree_connect.h
new file mode 100644
index 000000000000..4e40ec3f4774
--- /dev/null
+++ b/fs/cifsd/mgmt/tree_connect.h
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
+#include "../ksmbd_server.h"
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
diff --git a/fs/cifsd/mgmt/user_config.c b/fs/cifsd/mgmt/user_config.c
new file mode 100644
index 000000000000..7f898c5bda25
--- /dev/null
+++ b/fs/cifsd/mgmt/user_config.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include "user_config.h"
+#include "../buffer_pool.h"
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
diff --git a/fs/cifsd/mgmt/user_config.h b/fs/cifsd/mgmt/user_config.h
new file mode 100644
index 000000000000..b2bb074a0150
--- /dev/null
+++ b/fs/cifsd/mgmt/user_config.h
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
diff --git a/fs/cifsd/mgmt/user_session.c b/fs/cifsd/mgmt/user_session.c
new file mode 100644
index 000000000000..739588a6c96a
--- /dev/null
+++ b/fs/cifsd/mgmt/user_session.c
@@ -0,0 +1,328 @@
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
+#include "../buffer_pool.h"
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
+	struct channel *chann;
+	struct list_head *tmp, *t;
+
+	list_for_each_safe(tmp, t, &sess->ksmbd_chann_list) {
+		chann = list_entry(tmp, struct channel, chann_list);
+		if (chann) {
+			list_del(&chann->chann_list);
+			kfree(chann);
+		}
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
+	ksmbd_err("Unsupported RPC: %s\n", rpc_name);
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
+	if (IS_SMB2(sess->conn)) {
+		down_write(&sessions_table_lock);
+		hash_del(&sess->hlist);
+		up_write(&sessions_table_lock);
+	}
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
+bool ksmbd_session_id_match(struct ksmbd_session *sess, unsigned long long id)
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
+		ksmbd_err("get/%s seems to be mismatched.", __func__);
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
diff --git a/fs/cifsd/mgmt/user_session.h b/fs/cifsd/mgmt/user_session.h
new file mode 100644
index 000000000000..761bf4776cf1
--- /dev/null
+++ b/fs/cifsd/mgmt/user_session.h
@@ -0,0 +1,101 @@
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
+	u64			sess_id;
+	struct list_head	list_entry;
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
+bool ksmbd_session_id_match(struct ksmbd_session *sess, unsigned long long id);
+struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id);
+struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
+					   unsigned long long id);
+void ksmbd_session_register(struct ksmbd_conn *conn,
+			    struct ksmbd_session *sess);
+void ksmbd_sessions_deregister(struct ksmbd_conn *conn);
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
diff --git a/fs/cifsd/transport_ipc.c b/fs/cifsd/transport_ipc.c
new file mode 100644
index 000000000000..b09df832431f
--- /dev/null
+++ b/fs/cifsd/transport_ipc.c
@@ -0,0 +1,880 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/jhash.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/hashtable.h>
+#include <net/net_namespace.h>
+#include <net/genetlink.h>
+#include <linux/socket.h>
+#include <linux/workqueue.h>
+
+#include "vfs_cache.h"
+#include "transport_ipc.h"
+#include "buffer_pool.h"
+#include "server.h"
+#include "smb_common.h"
+
+#include "mgmt/user_config.h"
+#include "mgmt/share_config.h"
+#include "mgmt/user_session.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/ksmbd_ida.h"
+#include "connection.h"
+#include "transport_tcp.h"
+
+#define IPC_WAIT_TIMEOUT	(2 * HZ)
+
+#define IPC_MSG_HASH_BITS	3
+static DEFINE_HASHTABLE(ipc_msg_table, IPC_MSG_HASH_BITS);
+static DECLARE_RWSEM(ipc_msg_table_lock);
+static DEFINE_MUTEX(startup_lock);
+
+static DEFINE_IDA(ipc_ida);
+
+static unsigned int ksmbd_tools_pid;
+
+#define KSMBD_IPC_MSG_HANDLE(m)	(*(unsigned int *)m)
+
+static bool ksmbd_ipc_validate_version(struct genl_info *m)
+{
+	if (m->genlhdr->version != KSMBD_GENL_VERSION) {
+		ksmbd_err("%s. ksmbd: %d, kernel module: %d. %s.\n",
+			  "Daemon and kernel module version mismatch",
+			  m->genlhdr->version,
+			  KSMBD_GENL_VERSION,
+			  "User-space ksmbd should terminate");
+		return false;
+	}
+	return true;
+}
+
+struct ksmbd_ipc_msg {
+	unsigned int		type;
+	unsigned int		sz;
+	unsigned char		____payload[0];
+};
+
+#define KSMBD_IPC_MSG_PAYLOAD(m)					\
+	((void *)(((struct ksmbd_ipc_msg *)(m))->____payload))
+
+struct ipc_msg_table_entry {
+	unsigned int		handle;
+	unsigned int		type;
+	wait_queue_head_t	wait;
+	struct hlist_node	ipc_table_hlist;
+
+	void			*response;
+};
+
+static struct delayed_work ipc_timer_work;
+
+static int handle_startup_event(struct sk_buff *skb, struct genl_info *info);
+static int handle_unsupported_event(struct sk_buff *skb, struct genl_info *info);
+static int handle_generic_event(struct sk_buff *skb, struct genl_info *info);
+static int ksmbd_ipc_heartbeat_request(void);
+
+static const struct nla_policy ksmbd_nl_policy[KSMBD_EVENT_MAX] = {
+	[KSMBD_EVENT_UNSPEC] = {
+		.len = 0,
+	},
+	[KSMBD_EVENT_HEARTBEAT_REQUEST] = {
+		.len = sizeof(struct ksmbd_heartbeat),
+	},
+	[KSMBD_EVENT_STARTING_UP] = {
+		.len = sizeof(struct ksmbd_startup_request),
+	},
+	[KSMBD_EVENT_SHUTTING_DOWN] = {
+		.len = sizeof(struct ksmbd_shutdown_request),
+	},
+	[KSMBD_EVENT_LOGIN_REQUEST] = {
+		.len = sizeof(struct ksmbd_login_request),
+	},
+	[KSMBD_EVENT_LOGIN_RESPONSE] = {
+		.len = sizeof(struct ksmbd_login_response),
+	},
+	[KSMBD_EVENT_SHARE_CONFIG_REQUEST] = {
+		.len = sizeof(struct ksmbd_share_config_request),
+	},
+	[KSMBD_EVENT_SHARE_CONFIG_RESPONSE] = {
+		.len = sizeof(struct ksmbd_share_config_response),
+	},
+	[KSMBD_EVENT_TREE_CONNECT_REQUEST] = {
+		.len = sizeof(struct ksmbd_tree_connect_request),
+	},
+	[KSMBD_EVENT_TREE_CONNECT_RESPONSE] = {
+		.len = sizeof(struct ksmbd_tree_connect_response),
+	},
+	[KSMBD_EVENT_TREE_DISCONNECT_REQUEST] = {
+		.len = sizeof(struct ksmbd_tree_disconnect_request),
+	},
+	[KSMBD_EVENT_LOGOUT_REQUEST] = {
+		.len = sizeof(struct ksmbd_logout_request),
+	},
+	[KSMBD_EVENT_RPC_REQUEST] = {
+	},
+	[KSMBD_EVENT_RPC_RESPONSE] = {
+	},
+	[KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST] = {
+	},
+	[KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE] = {
+	},
+};
+
+static struct genl_ops ksmbd_genl_ops[] = {
+	{
+		.cmd	= KSMBD_EVENT_UNSPEC,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_HEARTBEAT_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_STARTING_UP,
+		.doit	= handle_startup_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SHUTTING_DOWN,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_LOGIN_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_LOGIN_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SHARE_CONFIG_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SHARE_CONFIG_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_TREE_CONNECT_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_TREE_CONNECT_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_TREE_DISCONNECT_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_LOGOUT_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_RPC_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_RPC_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
+		.doit	= handle_unsupported_event,
+	},
+	{
+		.cmd	= KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE,
+		.doit	= handle_generic_event,
+	},
+};
+
+static struct genl_family ksmbd_genl_family = {
+	.name		= KSMBD_GENL_NAME,
+	.version	= KSMBD_GENL_VERSION,
+	.hdrsize	= 0,
+	.maxattr	= KSMBD_EVENT_MAX,
+	.netnsok	= true,
+	.module		= THIS_MODULE,
+	.ops		= ksmbd_genl_ops,
+	.n_ops		= ARRAY_SIZE(ksmbd_genl_ops),
+};
+
+static void ksmbd_nl_init_fixup(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ksmbd_genl_ops); i++)
+		ksmbd_genl_ops[i].validate = GENL_DONT_VALIDATE_STRICT |
+						GENL_DONT_VALIDATE_DUMP;
+
+	ksmbd_genl_family.policy = ksmbd_nl_policy;
+}
+
+static int rpc_context_flags(struct ksmbd_session *sess)
+{
+	if (user_guest(sess->user))
+		return KSMBD_RPC_RESTRICTED_CONTEXT;
+	return 0;
+}
+
+static void ipc_update_last_active(void)
+{
+	if (server_conf.ipc_timeout)
+		server_conf.ipc_last_active = jiffies;
+}
+
+static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
+{
+	struct ksmbd_ipc_msg *msg;
+	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
+
+	msg = kvmalloc(msg_sz, GFP_KERNEL | __GFP_ZERO);
+	if (msg)
+		msg->sz = sz;
+	return msg;
+}
+
+static void ipc_msg_free(struct ksmbd_ipc_msg *msg)
+{
+	kvfree(msg);
+}
+
+static void ipc_msg_handle_free(int handle)
+{
+	if (handle >= 0)
+		ksmbd_release_id(&ipc_ida, handle);
+}
+
+static int handle_response(int type, void *payload, size_t sz)
+{
+	int handle = KSMBD_IPC_MSG_HANDLE(payload);
+	struct ipc_msg_table_entry *entry;
+	int ret = 0;
+
+	ipc_update_last_active();
+	down_read(&ipc_msg_table_lock);
+	hash_for_each_possible(ipc_msg_table, entry, ipc_table_hlist, handle) {
+		if (handle != entry->handle)
+			continue;
+
+		entry->response = NULL;
+		/*
+		 * Response message type value should be equal to
+		 * request message type + 1.
+		 */
+		if (entry->type + 1 != type) {
+			ksmbd_err("Waiting for IPC type %d, got %d. Ignore.\n",
+				  entry->type + 1, type);
+		}
+
+		entry->response = kvmalloc(sz, GFP_KERNEL | __GFP_ZERO);
+		if (!entry->response) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		memcpy(entry->response, payload, sz);
+		wake_up_interruptible(&entry->wait);
+		ret = 0;
+		break;
+	}
+	up_read(&ipc_msg_table_lock);
+
+	return ret;
+}
+
+static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
+{
+	int ret;
+
+	ksmbd_set_fd_limit(req->file_max);
+	server_conf.flags = req->flags;
+	server_conf.signing = req->signing;
+	server_conf.tcp_port = req->tcp_port;
+	server_conf.ipc_timeout = req->ipc_timeout * HZ;
+	server_conf.deadtime = req->deadtime * SMB_ECHO_INTERVAL;
+	server_conf.share_fake_fscaps = req->share_fake_fscaps;
+	ksmbd_init_domain(req->sub_auth);
+
+	if (req->smb2_max_read)
+		init_smb2_max_read_size(req->smb2_max_read);
+	if (req->smb2_max_write)
+		init_smb2_max_write_size(req->smb2_max_write);
+	if (req->smb2_max_trans)
+		init_smb2_max_trans_size(req->smb2_max_trans);
+
+	ret = ksmbd_set_netbios_name(req->netbios_name);
+	ret |= ksmbd_set_server_string(req->server_string);
+	ret |= ksmbd_set_work_group(req->work_group);
+	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
+					req->ifc_list_sz);
+	if (ret) {
+		ksmbd_err("Server configuration error: %s %s %s\n",
+			  req->netbios_name, req->server_string,
+			  req->work_group);
+		return ret;
+	}
+
+	if (req->min_prot[0]) {
+		ret = ksmbd_lookup_protocol_idx(req->min_prot);
+		if (ret >= 0)
+			server_conf.min_protocol = ret;
+	}
+	if (req->max_prot[0]) {
+		ret = ksmbd_lookup_protocol_idx(req->max_prot);
+		if (ret >= 0)
+			server_conf.max_protocol = ret;
+	}
+
+	if (server_conf.ipc_timeout)
+		schedule_delayed_work(&ipc_timer_work, server_conf.ipc_timeout);
+	return 0;
+}
+
+static int handle_startup_event(struct sk_buff *skb, struct genl_info *info)
+{
+	int ret = 0;
+
+#ifdef CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+#endif
+
+	if (!ksmbd_ipc_validate_version(info))
+		return -EINVAL;
+
+	if (!info->attrs[KSMBD_EVENT_STARTING_UP])
+		return -EINVAL;
+
+	mutex_lock(&startup_lock);
+	if (!ksmbd_server_configurable()) {
+		mutex_unlock(&startup_lock);
+		ksmbd_err("Server reset is in progress, can't start daemon\n");
+		return -EINVAL;
+	}
+
+	if (ksmbd_tools_pid) {
+		if (ksmbd_ipc_heartbeat_request() == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ksmbd_err("Reconnect to a new user space daemon\n");
+	} else {
+		struct ksmbd_startup_request *req;
+
+		req = nla_data(info->attrs[info->genlhdr->cmd]);
+		ret = ipc_server_config_on_startup(req);
+		if (ret)
+			goto out;
+		server_queue_ctrl_init_work();
+	}
+
+	ksmbd_tools_pid = info->snd_portid;
+	ipc_update_last_active();
+
+out:
+	mutex_unlock(&startup_lock);
+	return ret;
+}
+
+static int handle_unsupported_event(struct sk_buff *skb, struct genl_info *info)
+{
+	ksmbd_err("Unknown IPC event: %d, ignore.\n", info->genlhdr->cmd);
+	return -EINVAL;
+}
+
+static int handle_generic_event(struct sk_buff *skb, struct genl_info *info)
+{
+	void *payload;
+	int sz;
+	int type = info->genlhdr->cmd;
+
+#ifdef CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+#endif
+
+	if (type >= KSMBD_EVENT_MAX) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (!ksmbd_ipc_validate_version(info))
+		return -EINVAL;
+
+	if (!info->attrs[type])
+		return -EINVAL;
+
+	payload = nla_data(info->attrs[info->genlhdr->cmd]);
+	sz = nla_len(info->attrs[info->genlhdr->cmd]);
+	return handle_response(type, payload, sz);
+}
+
+static int ipc_msg_send(struct ksmbd_ipc_msg *msg)
+{
+	struct genlmsghdr *nlh;
+	struct sk_buff *skb;
+	int ret = -EINVAL;
+
+	if (!ksmbd_tools_pid)
+		return ret;
+
+	skb = genlmsg_new(msg->sz, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	nlh = genlmsg_put(skb, 0, 0, &ksmbd_genl_family, 0, msg->type);
+	if (!nlh)
+		goto out;
+
+	ret = nla_put(skb, msg->type, msg->sz, KSMBD_IPC_MSG_PAYLOAD(msg));
+	if (ret) {
+		genlmsg_cancel(skb, nlh);
+		goto out;
+	}
+
+	genlmsg_end(skb, nlh);
+	ret = genlmsg_unicast(&init_net, skb, ksmbd_tools_pid);
+	if (!ret)
+		ipc_update_last_active();
+	return ret;
+
+out:
+	nlmsg_free(skb);
+	return ret;
+}
+
+static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle)
+{
+	struct ipc_msg_table_entry entry;
+	int ret;
+
+	if ((int)handle < 0)
+		return NULL;
+
+	entry.type = msg->type;
+	entry.response = NULL;
+	init_waitqueue_head(&entry.wait);
+
+	down_write(&ipc_msg_table_lock);
+	entry.handle = handle;
+	hash_add(ipc_msg_table, &entry.ipc_table_hlist, entry.handle);
+	up_write(&ipc_msg_table_lock);
+
+	ret = ipc_msg_send(msg);
+	if (ret)
+		goto out;
+
+	ret = wait_event_interruptible_timeout(entry.wait,
+					       entry.response != NULL,
+					       IPC_WAIT_TIMEOUT);
+out:
+	down_write(&ipc_msg_table_lock);
+	hash_del(&entry.ipc_table_hlist);
+	up_write(&ipc_msg_table_lock);
+	return entry.response;
+}
+
+static int ksmbd_ipc_heartbeat_request(void)
+{
+	struct ksmbd_ipc_msg *msg;
+	int ret;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_heartbeat));
+	if (!msg)
+		return -EINVAL;
+
+	msg->type = KSMBD_EVENT_HEARTBEAT_REQUEST;
+	ret = ipc_msg_send(msg);
+	ipc_msg_free(msg);
+	return ret;
+}
+
+struct ksmbd_login_response *ksmbd_ipc_login_request(const char *account)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_login_request *req;
+	struct ksmbd_login_response *resp;
+
+	if (strlen(account) >= KSMBD_REQ_MAX_ACCOUNT_NAME_SZ)
+		return NULL;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_login_request));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_LOGIN_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = ksmbd_acquire_id(&ipc_ida);
+	strscpy(req->account, account, KSMBD_REQ_MAX_ACCOUNT_NAME_SZ);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_spnego_authen_response *
+ksmbd_ipc_spnego_authen_request(const char *spnego_blob, int blob_len)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_spnego_authen_request *req;
+	struct ksmbd_spnego_authen_response *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_spnego_authen_request) +
+			blob_len + 1);
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = ksmbd_acquire_id(&ipc_ida);
+	req->spnego_blob_len = blob_len;
+	memcpy(req->spnego_blob, spnego_blob, blob_len);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_tree_connect_response *
+ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
+			       struct ksmbd_share_config *share,
+			       struct ksmbd_tree_connect *tree_conn,
+			       struct sockaddr *peer_addr)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_tree_connect_request *req;
+	struct ksmbd_tree_connect_response *resp;
+
+	if (strlen(user_name(sess->user)) >= KSMBD_REQ_MAX_ACCOUNT_NAME_SZ)
+		return NULL;
+
+	if (strlen(share->name) >= KSMBD_REQ_MAX_SHARE_NAME)
+		return NULL;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_tree_connect_request));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_TREE_CONNECT_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+
+	req->handle = ksmbd_acquire_id(&ipc_ida);
+	req->account_flags = sess->user->flags;
+	req->session_id = sess->id;
+	req->connect_id = tree_conn->id;
+	strscpy(req->account, user_name(sess->user), KSMBD_REQ_MAX_ACCOUNT_NAME_SZ);
+	strscpy(req->share, share->name, KSMBD_REQ_MAX_SHARE_NAME);
+	snprintf(req->peer_addr, sizeof(req->peer_addr), "%pIS", peer_addr);
+
+	if (peer_addr->sa_family == AF_INET6)
+		req->flags |= KSMBD_TREE_CONN_FLAG_REQUEST_IPV6;
+	if (test_session_flag(sess, CIFDS_SESSION_FLAG_SMB2))
+		req->flags |= KSMBD_TREE_CONN_FLAG_REQUEST_SMB2;
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+int ksmbd_ipc_tree_disconnect_request(unsigned long long session_id,
+				      unsigned long long connect_id)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_tree_disconnect_request *req;
+	int ret;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_tree_disconnect_request));
+	if (!msg)
+		return -ENOMEM;
+
+	msg->type = KSMBD_EVENT_TREE_DISCONNECT_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->session_id = session_id;
+	req->connect_id = connect_id;
+
+	ret = ipc_msg_send(msg);
+	ipc_msg_free(msg);
+	return ret;
+}
+
+int ksmbd_ipc_logout_request(const char *account)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_logout_request *req;
+	int ret;
+
+	if (strlen(account) >= KSMBD_REQ_MAX_ACCOUNT_NAME_SZ)
+		return -EINVAL;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_logout_request));
+	if (!msg)
+		return -ENOMEM;
+
+	msg->type = KSMBD_EVENT_LOGOUT_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	strscpy(req->account, account, KSMBD_REQ_MAX_ACCOUNT_NAME_SZ);
+
+	ret = ipc_msg_send(msg);
+	ipc_msg_free(msg);
+	return ret;
+}
+
+struct ksmbd_share_config_response *
+ksmbd_ipc_share_config_request(const char *name)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_share_config_request *req;
+	struct ksmbd_share_config_response *resp;
+
+	if (strlen(name) >= KSMBD_REQ_MAX_SHARE_NAME)
+		return NULL;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_share_config_request));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_SHARE_CONFIG_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = ksmbd_acquire_id(&ipc_ida);
+	strscpy(req->share_name, name, KSMBD_REQ_MAX_SHARE_NAME);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_open(struct ksmbd_session *sess, int handle)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= KSMBD_RPC_OPEN_METHOD;
+	req->payload_sz = 0;
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_close(struct ksmbd_session *sess, int handle)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= KSMBD_RPC_CLOSE_METHOD;
+	req->payload_sz = 0;
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle,
+					  void *payload, size_t payload_sz)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= rpc_context_flags(sess);
+	req->flags |= KSMBD_RPC_WRITE_METHOD;
+	req->payload_sz = payload_sz;
+	memcpy(req->payload, payload, payload_sz);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess, int handle)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command));
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= rpc_context_flags(sess);
+	req->flags |= KSMBD_RPC_READ_METHOD;
+	req->payload_sz = 0;
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle,
+					  void *payload, size_t payload_sz)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = handle;
+	req->flags = ksmbd_session_rpc_method(sess, handle);
+	req->flags |= rpc_context_flags(sess);
+	req->flags |= KSMBD_RPC_IOCTL_METHOD;
+	req->payload_sz = payload_sz;
+	memcpy(req->payload, payload, payload_sz);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+struct ksmbd_rpc_command *ksmbd_rpc_rap(struct ksmbd_session *sess, void *payload,
+					size_t payload_sz)
+{
+	struct ksmbd_ipc_msg *msg;
+	struct ksmbd_rpc_command *req;
+	struct ksmbd_rpc_command *resp;
+
+	msg = ipc_msg_alloc(sizeof(struct ksmbd_rpc_command) + payload_sz + 1);
+	if (!msg)
+		return NULL;
+
+	msg->type = KSMBD_EVENT_RPC_REQUEST;
+	req = KSMBD_IPC_MSG_PAYLOAD(msg);
+	req->handle = ksmbd_acquire_id(&ipc_ida);
+	req->flags = rpc_context_flags(sess);
+	req->flags |= KSMBD_RPC_RAP_METHOD;
+	req->payload_sz = payload_sz;
+	memcpy(req->payload, payload, payload_sz);
+
+	resp = ipc_msg_send_request(msg, req->handle);
+	ipc_msg_handle_free(req->handle);
+	ipc_msg_free(msg);
+	return resp;
+}
+
+static int __ipc_heartbeat(void)
+{
+	unsigned long delta;
+
+	if (!ksmbd_server_running())
+		return 0;
+
+	if (time_after(jiffies, server_conf.ipc_last_active)) {
+		delta = (jiffies - server_conf.ipc_last_active);
+	} else {
+		ipc_update_last_active();
+		schedule_delayed_work(&ipc_timer_work,
+				      server_conf.ipc_timeout);
+		return 0;
+	}
+
+	if (delta < server_conf.ipc_timeout) {
+		schedule_delayed_work(&ipc_timer_work,
+				      server_conf.ipc_timeout - delta);
+		return 0;
+	}
+
+	if (ksmbd_ipc_heartbeat_request() == 0) {
+		schedule_delayed_work(&ipc_timer_work,
+				      server_conf.ipc_timeout);
+		return 0;
+	}
+
+	mutex_lock(&startup_lock);
+	WRITE_ONCE(server_conf.state, SERVER_STATE_RESETTING);
+	server_conf.ipc_last_active = 0;
+	ksmbd_tools_pid = 0;
+	ksmbd_err("No IPC daemon response for %lus\n", delta / HZ);
+	mutex_unlock(&startup_lock);
+	return -EINVAL;
+}
+
+static void ipc_timer_heartbeat(struct work_struct *w)
+{
+	if (__ipc_heartbeat())
+		server_queue_ctrl_reset_work();
+}
+
+int ksmbd_ipc_id_alloc(void)
+{
+	return ksmbd_acquire_id(&ipc_ida);
+}
+
+void ksmbd_rpc_id_free(int handle)
+{
+	ksmbd_release_id(&ipc_ida, handle);
+}
+
+void ksmbd_ipc_release(void)
+{
+	cancel_delayed_work_sync(&ipc_timer_work);
+	genl_unregister_family(&ksmbd_genl_family);
+}
+
+void ksmbd_ipc_soft_reset(void)
+{
+	mutex_lock(&startup_lock);
+	ksmbd_tools_pid = 0;
+	cancel_delayed_work_sync(&ipc_timer_work);
+	mutex_unlock(&startup_lock);
+}
+
+int ksmbd_ipc_init(void)
+{
+	int ret = 0;
+
+	ksmbd_nl_init_fixup();
+	INIT_DELAYED_WORK(&ipc_timer_work, ipc_timer_heartbeat);
+
+	ret = genl_register_family(&ksmbd_genl_family);
+	if (ret) {
+		ksmbd_err("Failed to register KSMBD netlink interface %d\n", ret);
+		cancel_delayed_work_sync(&ipc_timer_work);
+	}
+
+	return ret;
+}
diff --git a/fs/cifsd/transport_ipc.h b/fs/cifsd/transport_ipc.h
new file mode 100644
index 000000000000..9eacc895ffdb
--- /dev/null
+++ b/fs/cifsd/transport_ipc.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_TRANSPORT_IPC_H__
+#define __KSMBD_TRANSPORT_IPC_H__
+
+#include <linux/wait.h>
+
+#define KSMBD_IPC_MAX_PAYLOAD	4096
+
+struct ksmbd_login_response *
+ksmbd_ipc_login_request(const char *account);
+
+struct ksmbd_session;
+struct ksmbd_share_config;
+struct ksmbd_tree_connect;
+struct sockaddr;
+
+struct ksmbd_tree_connect_response *
+ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
+			       struct ksmbd_share_config *share,
+			       struct ksmbd_tree_connect *tree_conn,
+			       struct sockaddr *peer_addr);
+int ksmbd_ipc_tree_disconnect_request(unsigned long long session_id,
+				      unsigned long long connect_id);
+int ksmbd_ipc_logout_request(const char *account);
+struct ksmbd_share_config_response *
+ksmbd_ipc_share_config_request(const char *name);
+struct ksmbd_spnego_authen_response *
+ksmbd_ipc_spnego_authen_request(const char *spnego_blob, int blob_len);
+int ksmbd_ipc_id_alloc(void);
+void ksmbd_rpc_id_free(int handle);
+struct ksmbd_rpc_command *ksmbd_rpc_open(struct ksmbd_session *sess, int handle);
+struct ksmbd_rpc_command *ksmbd_rpc_close(struct ksmbd_session *sess, int handle);
+struct ksmbd_rpc_command *ksmbd_rpc_write(struct ksmbd_session *sess, int handle,
+					  void *payload, size_t payload_sz);
+struct ksmbd_rpc_command *ksmbd_rpc_read(struct ksmbd_session *sess, int handle);
+struct ksmbd_rpc_command *ksmbd_rpc_ioctl(struct ksmbd_session *sess, int handle,
+					  void *payload, size_t payload_sz);
+struct ksmbd_rpc_command *ksmbd_rpc_rap(struct ksmbd_session *sess, void *payload,
+					size_t payload_sz);
+void ksmbd_ipc_release(void);
+void ksmbd_ipc_soft_reset(void);
+int ksmbd_ipc_init(void);
+#endif /* __KSMBD_TRANSPORT_IPC_H__ */
diff --git a/fs/cifsd/transport_rdma.c b/fs/cifsd/transport_rdma.c
new file mode 100644
index 000000000000..efaa9776841f
--- /dev/null
+++ b/fs/cifsd/transport_rdma.c
@@ -0,0 +1,2040 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2017, Microsoft Corporation.
+ *   Copyright (C) 2018, LG Electronics.
+ *
+ *   Author(s): Long Li <longli@microsoft.com>,
+ *		Hyunchul Lee <hyc.lee@gmail.com>
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ */
+
+#define SUBMOD_NAME	"smb_direct"
+
+#include <linux/kthread.h>
+#include <linux/rwlock.h>
+#include <linux/list.h>
+#include <linux/mempool.h>
+#include <linux/highmem.h>
+#include <linux/scatterlist.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/rdma_cm.h>
+#include <rdma/rw.h>
+
+#include "glob.h"
+#include "connection.h"
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "buffer_pool.h"
+#include "transport_rdma.h"
+
+#define SMB_DIRECT_PORT	5445
+
+#define SMB_DIRECT_VERSION_LE		cpu_to_le16(0x0100)
+
+/* SMB_DIRECT negotiation timeout in seconds */
+#define SMB_DIRECT_NEGOTIATE_TIMEOUT		120
+
+#define SMB_DIRECT_MAX_SEND_SGES		8
+#define SMB_DIRECT_MAX_RECV_SGES		1
+
+/*
+ * Default maximum number of RDMA read/write outstanding on this connection
+ * This value is possibly decreased during QP creation on hardware limit
+ */
+#define SMB_DIRECT_CM_INITIATOR_DEPTH		8
+
+/* Maximum number of retries on data transfer operations */
+#define SMB_DIRECT_CM_RETRY			6
+/* No need to retry on Receiver Not Ready since SMB_DIRECT manages credits */
+#define SMB_DIRECT_CM_RNR_RETRY		0
+
+/*
+ * User configurable initial values per SMB_DIRECT transport connection
+ * as defined in [MS-KSMBD] 3.1.1.1
+ * Those may change after a SMB_DIRECT negotiation
+ */
+/* The local peer's maximum number of credits to grant to the peer */
+static int smb_direct_receive_credit_max = 255;
+
+/* The remote peer's credit request of local peer */
+static int smb_direct_send_credit_target = 255;
+
+/* The maximum single message size can be sent to remote peer */
+static int smb_direct_max_send_size = 8192;
+
+/*  The maximum fragmented upper-layer payload receive size supported */
+static int smb_direct_max_fragmented_recv_size = 1024 * 1024;
+
+/*  The maximum single-message size which can be received */
+static int smb_direct_max_receive_size = 8192;
+
+static int smb_direct_max_read_write_size = 1024 * 1024;
+
+static int smb_direct_max_outstanding_rw_ops = 8;
+
+static struct smb_direct_listener {
+	struct rdma_cm_id	*cm_id;
+} smb_direct_listener;
+
+static struct workqueue_struct *smb_direct_wq;
+
+enum smb_direct_status {
+	SMB_DIRECT_CS_NEW = 0,
+	SMB_DIRECT_CS_CONNECTED,
+	SMB_DIRECT_CS_DISCONNECTING,
+	SMB_DIRECT_CS_DISCONNECTED,
+};
+
+struct smb_direct_transport {
+	struct ksmbd_transport	transport;
+
+	enum smb_direct_status	status;
+	bool			full_packet_received;
+	wait_queue_head_t	wait_status;
+
+	struct rdma_cm_id	*cm_id;
+	struct ib_cq		*send_cq;
+	struct ib_cq		*recv_cq;
+	struct ib_pd		*pd;
+	struct ib_qp		*qp;
+
+	int			max_send_size;
+	int			max_recv_size;
+	int			max_fragmented_send_size;
+	int			max_fragmented_recv_size;
+	int			max_rdma_rw_size;
+
+	spinlock_t		reassembly_queue_lock;
+	struct list_head	reassembly_queue;
+	int			reassembly_data_length;
+	int			reassembly_queue_length;
+	int			first_entry_offset;
+	wait_queue_head_t	wait_reassembly_queue;
+
+	spinlock_t		receive_credit_lock;
+	int			recv_credits;
+	int			count_avail_recvmsg;
+	int			recv_credit_max;
+	int			recv_credit_target;
+
+	spinlock_t		recvmsg_queue_lock;
+	struct list_head	recvmsg_queue;
+
+	spinlock_t		empty_recvmsg_queue_lock;
+	struct list_head	empty_recvmsg_queue;
+
+	int			send_credit_target;
+	atomic_t		send_credits;
+	spinlock_t		lock_new_recv_credits;
+	int			new_recv_credits;
+	atomic_t		rw_avail_ops;
+
+	wait_queue_head_t	wait_send_credits;
+	wait_queue_head_t	wait_rw_avail_ops;
+
+	mempool_t		*sendmsg_mempool;
+	struct kmem_cache	*sendmsg_cache;
+	mempool_t		*recvmsg_mempool;
+	struct kmem_cache	*recvmsg_cache;
+
+	wait_queue_head_t	wait_send_payload_pending;
+	atomic_t		send_payload_pending;
+	wait_queue_head_t	wait_send_pending;
+	atomic_t		send_pending;
+
+	struct delayed_work	post_recv_credits_work;
+	struct work_struct	send_immediate_work;
+	struct work_struct	disconnect_work;
+
+	bool			negotiation_requested;
+};
+
+#define KSMBD_TRANS(t) ((struct ksmbd_transport *)&((t)->transport))
+#define SMB_DIRECT_TRANS(t) ((struct smb_direct_transport *)container_of(t, \
+				struct smb_direct_transport, transport))
+
+enum {
+	SMB_DIRECT_MSG_NEGOTIATE_REQ = 0,
+	SMB_DIRECT_MSG_DATA_TRANSFER
+};
+
+static struct ksmbd_transport_ops ksmbd_smb_direct_transport_ops;
+
+struct smb_direct_send_ctx {
+	struct list_head	msg_list;
+	int			wr_cnt;
+	bool			need_invalidate_rkey;
+	unsigned int		remote_key;
+};
+
+struct smb_direct_sendmsg {
+	struct smb_direct_transport	*transport;
+	struct ib_send_wr	wr;
+	struct list_head	list;
+	int			num_sge;
+	struct ib_sge		sge[SMB_DIRECT_MAX_SEND_SGES];
+	struct ib_cqe		cqe;
+	u8			packet[];
+};
+
+struct smb_direct_recvmsg {
+	struct smb_direct_transport	*transport;
+	struct list_head	list;
+	int			type;
+	struct ib_sge		sge;
+	struct ib_cqe		cqe;
+	bool			first_segment;
+	u8			packet[];
+};
+
+struct smb_direct_rdma_rw_msg {
+	struct smb_direct_transport	*t;
+	struct ib_cqe		cqe;
+	struct completion	*completion;
+	struct rdma_rw_ctx	rw_ctx;
+	struct sg_table		sgt;
+	struct scatterlist	sg_list[0];
+};
+
+#define BUFFER_NR_PAGES(buf, len)					\
+		(DIV_ROUND_UP((unsigned long)(buf) + (len), PAGE_SIZE)	\
+			- (unsigned long)(buf) / PAGE_SIZE)
+
+static void smb_direct_destroy_pools(struct smb_direct_transport *transport);
+static void smb_direct_post_recv_credits(struct work_struct *work);
+static int smb_direct_post_send_data(struct smb_direct_transport *t,
+				     struct smb_direct_send_ctx *send_ctx,
+				     struct kvec *iov, int niov,
+				     int remaining_data_length);
+
+static inline void
+*smb_direct_recvmsg_payload(struct smb_direct_recvmsg *recvmsg)
+{
+	return (void *)recvmsg->packet;
+}
+
+static inline bool is_receive_credit_post_required(int receive_credits,
+						   int avail_recvmsg_count)
+{
+	return receive_credits <= (smb_direct_receive_credit_max >> 3) &&
+		avail_recvmsg_count >= (receive_credits >> 2);
+}
+
+static struct
+smb_direct_recvmsg *get_free_recvmsg(struct smb_direct_transport *t)
+{
+	struct smb_direct_recvmsg *recvmsg = NULL;
+
+	spin_lock(&t->recvmsg_queue_lock);
+	if (!list_empty(&t->recvmsg_queue)) {
+		recvmsg = list_first_entry(&t->recvmsg_queue,
+					   struct smb_direct_recvmsg,
+					   list);
+		list_del(&recvmsg->list);
+	}
+	spin_unlock(&t->recvmsg_queue_lock);
+	return recvmsg;
+}
+
+static void put_recvmsg(struct smb_direct_transport *t,
+			struct smb_direct_recvmsg *recvmsg)
+{
+	ib_dma_unmap_single(t->cm_id->device, recvmsg->sge.addr,
+			    recvmsg->sge.length, DMA_FROM_DEVICE);
+
+	spin_lock(&t->recvmsg_queue_lock);
+	list_add(&recvmsg->list, &t->recvmsg_queue);
+	spin_unlock(&t->recvmsg_queue_lock);
+}
+
+static struct
+smb_direct_recvmsg *get_empty_recvmsg(struct smb_direct_transport *t)
+{
+	struct smb_direct_recvmsg *recvmsg = NULL;
+
+	spin_lock(&t->empty_recvmsg_queue_lock);
+	if (!list_empty(&t->empty_recvmsg_queue)) {
+		recvmsg = list_first_entry(&t->empty_recvmsg_queue,
+					   struct smb_direct_recvmsg, list);
+		list_del(&recvmsg->list);
+	}
+	spin_unlock(&t->empty_recvmsg_queue_lock);
+	return recvmsg;
+}
+
+static void put_empty_recvmsg(struct smb_direct_transport *t,
+			      struct smb_direct_recvmsg *recvmsg)
+{
+	ib_dma_unmap_single(t->cm_id->device, recvmsg->sge.addr,
+			    recvmsg->sge.length, DMA_FROM_DEVICE);
+
+	spin_lock(&t->empty_recvmsg_queue_lock);
+	list_add_tail(&recvmsg->list, &t->empty_recvmsg_queue);
+	spin_unlock(&t->empty_recvmsg_queue_lock);
+}
+
+static void enqueue_reassembly(struct smb_direct_transport *t,
+			       struct smb_direct_recvmsg *recvmsg,
+			       int data_length)
+{
+	spin_lock(&t->reassembly_queue_lock);
+	list_add_tail(&recvmsg->list, &t->reassembly_queue);
+	t->reassembly_queue_length++;
+	/*
+	 * Make sure reassembly_data_length is updated after list and
+	 * reassembly_queue_length are updated. On the dequeue side
+	 * reassembly_data_length is checked without a lock to determine
+	 * if reassembly_queue_length and list is up to date
+	 */
+	virt_wmb();
+	t->reassembly_data_length += data_length;
+	spin_unlock(&t->reassembly_queue_lock);
+}
+
+static struct smb_direct_recvmsg *get_first_reassembly(struct smb_direct_transport *t)
+{
+	if (!list_empty(&t->reassembly_queue))
+		return list_first_entry(&t->reassembly_queue,
+				struct smb_direct_recvmsg, list);
+	else
+		return NULL;
+}
+
+static void smb_direct_disconnect_rdma_work(struct work_struct *work)
+{
+	struct smb_direct_transport *t =
+		container_of(work, struct smb_direct_transport,
+			     disconnect_work);
+
+	if (t->status == SMB_DIRECT_CS_CONNECTED) {
+		t->status = SMB_DIRECT_CS_DISCONNECTING;
+		rdma_disconnect(t->cm_id);
+	}
+}
+
+static void
+smb_direct_disconnect_rdma_connection(struct smb_direct_transport *t)
+{
+	queue_work(smb_direct_wq, &t->disconnect_work);
+}
+
+static void smb_direct_send_immediate_work(struct work_struct *work)
+{
+	struct smb_direct_transport *t = container_of(work,
+			struct smb_direct_transport, send_immediate_work);
+
+	if (t->status != SMB_DIRECT_CS_CONNECTED)
+		return;
+
+	smb_direct_post_send_data(t, NULL, NULL, 0, 0);
+}
+
+static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
+{
+	struct smb_direct_transport *t;
+	struct ksmbd_conn *conn;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+
+	t->cm_id = cm_id;
+	cm_id->context = t;
+
+	t->status = SMB_DIRECT_CS_NEW;
+	init_waitqueue_head(&t->wait_status);
+
+	spin_lock_init(&t->reassembly_queue_lock);
+	INIT_LIST_HEAD(&t->reassembly_queue);
+	t->reassembly_data_length = 0;
+	t->reassembly_queue_length = 0;
+	init_waitqueue_head(&t->wait_reassembly_queue);
+	init_waitqueue_head(&t->wait_send_credits);
+	init_waitqueue_head(&t->wait_rw_avail_ops);
+
+	spin_lock_init(&t->receive_credit_lock);
+	spin_lock_init(&t->recvmsg_queue_lock);
+	INIT_LIST_HEAD(&t->recvmsg_queue);
+
+	spin_lock_init(&t->empty_recvmsg_queue_lock);
+	INIT_LIST_HEAD(&t->empty_recvmsg_queue);
+
+	init_waitqueue_head(&t->wait_send_payload_pending);
+	atomic_set(&t->send_payload_pending, 0);
+	init_waitqueue_head(&t->wait_send_pending);
+	atomic_set(&t->send_pending, 0);
+
+	spin_lock_init(&t->lock_new_recv_credits);
+
+	INIT_DELAYED_WORK(&t->post_recv_credits_work,
+			  smb_direct_post_recv_credits);
+	INIT_WORK(&t->send_immediate_work, smb_direct_send_immediate_work);
+	INIT_WORK(&t->disconnect_work, smb_direct_disconnect_rdma_work);
+
+	conn = ksmbd_conn_alloc();
+	if (!conn)
+		goto err;
+	conn->transport = KSMBD_TRANS(t);
+	KSMBD_TRANS(t)->conn = conn;
+	KSMBD_TRANS(t)->ops = &ksmbd_smb_direct_transport_ops;
+	return t;
+err:
+	kfree(t);
+	return NULL;
+}
+
+static void free_transport(struct smb_direct_transport *t)
+{
+	struct smb_direct_recvmsg *recvmsg;
+
+	wake_up_interruptible(&t->wait_send_credits);
+
+	ksmbd_debug(RDMA, "wait for all send posted to IB to finish\n");
+	wait_event(t->wait_send_payload_pending,
+		   atomic_read(&t->send_payload_pending) == 0);
+	wait_event(t->wait_send_pending,
+		   atomic_read(&t->send_pending) == 0);
+
+	cancel_work_sync(&t->disconnect_work);
+	cancel_delayed_work_sync(&t->post_recv_credits_work);
+	cancel_work_sync(&t->send_immediate_work);
+
+	if (t->qp) {
+		ib_drain_qp(t->qp);
+		ib_destroy_qp(t->qp);
+	}
+
+	ksmbd_debug(RDMA, "drain the reassembly queue\n");
+	do {
+		spin_lock(&t->reassembly_queue_lock);
+		recvmsg = get_first_reassembly(t);
+		if (recvmsg) {
+			list_del(&recvmsg->list);
+			spin_unlock(&t->reassembly_queue_lock);
+			put_recvmsg(t, recvmsg);
+		} else {
+			spin_unlock(&t->reassembly_queue_lock);
+		}
+	} while (recvmsg);
+	t->reassembly_data_length = 0;
+
+	if (t->send_cq)
+		ib_free_cq(t->send_cq);
+	if (t->recv_cq)
+		ib_free_cq(t->recv_cq);
+	if (t->pd)
+		ib_dealloc_pd(t->pd);
+	if (t->cm_id)
+		rdma_destroy_id(t->cm_id);
+
+	smb_direct_destroy_pools(t);
+	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
+	kfree(t);
+}
+
+static struct smb_direct_sendmsg
+*smb_direct_alloc_sendmsg(struct smb_direct_transport *t)
+{
+	struct smb_direct_sendmsg *msg;
+
+	msg = mempool_alloc(t->sendmsg_mempool, GFP_KERNEL);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+	msg->transport = t;
+	INIT_LIST_HEAD(&msg->list);
+	msg->num_sge = 0;
+	return msg;
+}
+
+static void smb_direct_free_sendmsg(struct smb_direct_transport *t,
+				    struct smb_direct_sendmsg *msg)
+{
+	int i;
+
+	if (msg->num_sge > 0) {
+		ib_dma_unmap_single(t->cm_id->device,
+				    msg->sge[0].addr, msg->sge[0].length,
+				    DMA_TO_DEVICE);
+		for (i = 1; i < msg->num_sge; i++)
+			ib_dma_unmap_page(t->cm_id->device,
+					  msg->sge[i].addr, msg->sge[i].length,
+					  DMA_TO_DEVICE);
+	}
+	mempool_free(msg, t->sendmsg_mempool);
+}
+
+static int smb_direct_check_recvmsg(struct smb_direct_recvmsg *recvmsg)
+{
+	switch (recvmsg->type) {
+	case SMB_DIRECT_MSG_DATA_TRANSFER: {
+		struct smb_direct_data_transfer *req =
+			(struct smb_direct_data_transfer *)recvmsg->packet;
+		struct smb2_hdr *hdr = (struct smb2_hdr *)(recvmsg->packet
+				+ le32_to_cpu(req->data_offset) - 4);
+		ksmbd_debug(RDMA,
+			    "CreditGranted: %u, CreditRequested: %u, DataLength: %u, RemainingDataLength: %u, SMB: %x, Command: %u\n",
+			    le16_to_cpu(req->credits_granted),
+			    le16_to_cpu(req->credits_requested),
+			    req->data_length, req->remaining_data_length,
+			    hdr->ProtocolId, hdr->Command);
+		break;
+	}
+	case SMB_DIRECT_MSG_NEGOTIATE_REQ: {
+		struct smb_direct_negotiate_req *req =
+			(struct smb_direct_negotiate_req *)recvmsg->packet;
+		ksmbd_debug(RDMA,
+			    "MinVersion: %u, MaxVersion: %u, CreditRequested: %u, MaxSendSize: %u, MaxRecvSize: %u, MaxFragmentedSize: %u\n",
+			    le16_to_cpu(req->min_version),
+			    le16_to_cpu(req->max_version),
+			    le16_to_cpu(req->credits_requested),
+			    le32_to_cpu(req->preferred_send_size),
+			    le32_to_cpu(req->max_receive_size),
+			    le32_to_cpu(req->max_fragmented_size));
+		if (le16_to_cpu(req->min_version) > 0x0100 ||
+		    le16_to_cpu(req->max_version) < 0x0100)
+			return -EOPNOTSUPP;
+		if (le16_to_cpu(req->credits_requested) <= 0 ||
+		    le32_to_cpu(req->max_receive_size) <= 128 ||
+		    le32_to_cpu(req->max_fragmented_size) <=
+					128 * 1024)
+			return -ECONNABORTED;
+
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_transport *t;
+
+	recvmsg = container_of(wc->wr_cqe, struct smb_direct_recvmsg, cqe);
+	t = recvmsg->transport;
+
+	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
+		if (wc->status != IB_WC_WR_FLUSH_ERR) {
+			ksmbd_err("Recv error. status='%s (%d)' opcode=%d\n",
+				  ib_wc_status_msg(wc->status), wc->status,
+				  wc->opcode);
+			smb_direct_disconnect_rdma_connection(t);
+		}
+		put_empty_recvmsg(t, recvmsg);
+		return;
+	}
+
+	ksmbd_debug(RDMA, "Recv completed. status='%s (%d)', opcode=%d\n",
+		    ib_wc_status_msg(wc->status), wc->status,
+		    wc->opcode);
+
+	ib_dma_sync_single_for_cpu(wc->qp->device, recvmsg->sge.addr,
+				   recvmsg->sge.length, DMA_FROM_DEVICE);
+
+	switch (recvmsg->type) {
+	case SMB_DIRECT_MSG_NEGOTIATE_REQ:
+		t->negotiation_requested = true;
+		t->full_packet_received = true;
+		wake_up_interruptible(&t->wait_status);
+		break;
+	case SMB_DIRECT_MSG_DATA_TRANSFER: {
+		struct smb_direct_data_transfer *data_transfer =
+			(struct smb_direct_data_transfer *)recvmsg->packet;
+		int data_length = le32_to_cpu(data_transfer->data_length);
+		int avail_recvmsg_count, receive_credits;
+
+		if (data_length) {
+			if (t->full_packet_received)
+				recvmsg->first_segment = true;
+
+			if (le32_to_cpu(data_transfer->remaining_data_length))
+				t->full_packet_received = false;
+			else
+				t->full_packet_received = true;
+
+			enqueue_reassembly(t, recvmsg, data_length);
+			wake_up_interruptible(&t->wait_reassembly_queue);
+
+			spin_lock(&t->receive_credit_lock);
+			receive_credits = --(t->recv_credits);
+			avail_recvmsg_count = t->count_avail_recvmsg;
+			spin_unlock(&t->receive_credit_lock);
+		} else {
+			put_empty_recvmsg(t, recvmsg);
+
+			spin_lock(&t->receive_credit_lock);
+			receive_credits = --(t->recv_credits);
+			avail_recvmsg_count = ++(t->count_avail_recvmsg);
+			spin_unlock(&t->receive_credit_lock);
+		}
+
+		t->recv_credit_target =
+				le16_to_cpu(data_transfer->credits_requested);
+		atomic_add(le16_to_cpu(data_transfer->credits_granted),
+			   &t->send_credits);
+
+		if (le16_to_cpu(data_transfer->flags) &
+		    SMB_DIRECT_RESPONSE_REQUESTED)
+			queue_work(smb_direct_wq, &t->send_immediate_work);
+
+		if (atomic_read(&t->send_credits) > 0)
+			wake_up_interruptible(&t->wait_send_credits);
+
+		if (is_receive_credit_post_required(receive_credits, avail_recvmsg_count))
+			mod_delayed_work(smb_direct_wq,
+					 &t->post_recv_credits_work, 0);
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static int smb_direct_post_recv(struct smb_direct_transport *t,
+				struct smb_direct_recvmsg *recvmsg)
+{
+	struct ib_recv_wr wr;
+	int ret;
+
+	recvmsg->sge.addr = ib_dma_map_single(t->cm_id->device,
+					      recvmsg->packet, t->max_recv_size,
+					      DMA_FROM_DEVICE);
+	ret = ib_dma_mapping_error(t->cm_id->device, recvmsg->sge.addr);
+	if (ret)
+		return ret;
+	recvmsg->sge.length = t->max_recv_size;
+	recvmsg->sge.lkey = t->pd->local_dma_lkey;
+	recvmsg->cqe.done = recv_done;
+
+	wr.wr_cqe = &recvmsg->cqe;
+	wr.next = NULL;
+	wr.sg_list = &recvmsg->sge;
+	wr.num_sge = 1;
+
+	ret = ib_post_recv(t->qp, &wr, NULL);
+	if (ret) {
+		ksmbd_err("Can't post recv: %d\n", ret);
+		ib_dma_unmap_single(t->cm_id->device,
+				    recvmsg->sge.addr, recvmsg->sge.length,
+				    DMA_FROM_DEVICE);
+		smb_direct_disconnect_rdma_connection(t);
+		return ret;
+	}
+	return ret;
+}
+
+static int smb_direct_read(struct ksmbd_transport *t, char *buf,
+			   unsigned int size)
+{
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_data_transfer *data_transfer;
+	int to_copy, to_read, data_read, offset;
+	u32 data_length, remaining_data_length, data_offset;
+	int rc;
+	struct smb_direct_transport *st = SMB_DIRECT_TRANS(t);
+
+again:
+	if (st->status != SMB_DIRECT_CS_CONNECTED) {
+		ksmbd_err("disconnected\n");
+		return -ENOTCONN;
+	}
+
+	/*
+	 * No need to hold the reassembly queue lock all the time as we are
+	 * the only one reading from the front of the queue. The transport
+	 * may add more entries to the back of the queue at the same time
+	 */
+	if (st->reassembly_data_length >= size) {
+		int queue_length;
+		int queue_removed = 0;
+
+		/*
+		 * Need to make sure reassembly_data_length is read before
+		 * reading reassembly_queue_length and calling
+		 * get_first_reassembly. This call is lock free
+		 * as we never read at the end of the queue which are being
+		 * updated in SOFTIRQ as more data is received
+		 */
+		virt_rmb();
+		queue_length = st->reassembly_queue_length;
+		data_read = 0;
+		to_read = size;
+		offset = st->first_entry_offset;
+		while (data_read < size) {
+			recvmsg = get_first_reassembly(st);
+			data_transfer = smb_direct_recvmsg_payload(recvmsg);
+			data_length = le32_to_cpu(data_transfer->data_length);
+			remaining_data_length =
+				le32_to_cpu(data_transfer->remaining_data_length);
+			data_offset = le32_to_cpu(data_transfer->data_offset);
+
+			/*
+			 * The upper layer expects RFC1002 length at the
+			 * beginning of the payload. Return it to indicate
+			 * the total length of the packet. This minimize the
+			 * change to upper layer packet processing logic. This
+			 * will be eventually remove when an intermediate
+			 * transport layer is added
+			 */
+			if (recvmsg->first_segment && size == 4) {
+				unsigned int rfc1002_len =
+					data_length + remaining_data_length;
+				*((__be32 *)buf) = cpu_to_be32(rfc1002_len);
+				data_read = 4;
+				recvmsg->first_segment = false;
+				ksmbd_debug(RDMA,
+					    "returning rfc1002 length %d\n",
+					    rfc1002_len);
+				goto read_rfc1002_done;
+			}
+
+			to_copy = min_t(int, data_length - offset, to_read);
+			memcpy(buf + data_read, (char *)data_transfer + data_offset + offset,
+			       to_copy);
+
+			/* move on to the next buffer? */
+			if (to_copy == data_length - offset) {
+				queue_length--;
+				/*
+				 * No need to lock if we are not at the
+				 * end of the queue
+				 */
+				if (queue_length) {
+					list_del(&recvmsg->list);
+				} else {
+					spin_lock_irq(&st->reassembly_queue_lock);
+					list_del(&recvmsg->list);
+					spin_unlock_irq(&st->reassembly_queue_lock);
+				}
+				queue_removed++;
+				put_recvmsg(st, recvmsg);
+				offset = 0;
+			} else {
+				offset += to_copy;
+			}
+
+			to_read -= to_copy;
+			data_read += to_copy;
+		}
+
+		spin_lock_irq(&st->reassembly_queue_lock);
+		st->reassembly_data_length -= data_read;
+		st->reassembly_queue_length -= queue_removed;
+		spin_unlock_irq(&st->reassembly_queue_lock);
+
+		spin_lock(&st->receive_credit_lock);
+		st->count_avail_recvmsg += queue_removed;
+		if (is_receive_credit_post_required(st->recv_credits, st->count_avail_recvmsg)) {
+			spin_unlock(&st->receive_credit_lock);
+			mod_delayed_work(smb_direct_wq,
+					 &st->post_recv_credits_work, 0);
+		} else {
+			spin_unlock(&st->receive_credit_lock);
+		}
+
+		st->first_entry_offset = offset;
+		ksmbd_debug(RDMA,
+			    "returning to thread data_read=%d reassembly_data_length=%d first_entry_offset=%d\n",
+			    data_read, st->reassembly_data_length,
+			    st->first_entry_offset);
+read_rfc1002_done:
+		return data_read;
+	}
+
+	ksmbd_debug(RDMA, "wait_event on more data\n");
+	rc = wait_event_interruptible(st->wait_reassembly_queue,
+				      st->reassembly_data_length >= size ||
+				       st->status != SMB_DIRECT_CS_CONNECTED);
+	if (rc)
+		return -EINTR;
+
+	goto again;
+}
+
+static void smb_direct_post_recv_credits(struct work_struct *work)
+{
+	struct smb_direct_transport *t = container_of(work,
+		struct smb_direct_transport, post_recv_credits_work.work);
+	struct smb_direct_recvmsg *recvmsg;
+	int receive_credits, credits = 0;
+	int ret;
+	int use_free = 1;
+
+	spin_lock(&t->receive_credit_lock);
+	receive_credits = t->recv_credits;
+	spin_unlock(&t->receive_credit_lock);
+
+	if (receive_credits < t->recv_credit_target) {
+		while (true) {
+			if (use_free)
+				recvmsg = get_free_recvmsg(t);
+			else
+				recvmsg = get_empty_recvmsg(t);
+			if (!recvmsg) {
+				if (use_free) {
+					use_free = 0;
+					continue;
+				} else {
+					break;
+				}
+			}
+
+			recvmsg->type = SMB_DIRECT_MSG_DATA_TRANSFER;
+			recvmsg->first_segment = false;
+
+			ret = smb_direct_post_recv(t, recvmsg);
+			if (ret) {
+				ksmbd_err("Can't post recv: %d\n", ret);
+				put_recvmsg(t, recvmsg);
+				break;
+			}
+			credits++;
+		}
+	}
+
+	spin_lock(&t->receive_credit_lock);
+	t->recv_credits += credits;
+	t->count_avail_recvmsg -= credits;
+	spin_unlock(&t->receive_credit_lock);
+
+	spin_lock(&t->lock_new_recv_credits);
+	t->new_recv_credits += credits;
+	spin_unlock(&t->lock_new_recv_credits);
+
+	if (credits)
+		queue_work(smb_direct_wq, &t->send_immediate_work);
+}
+
+static void send_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct smb_direct_sendmsg *sendmsg, *sibling;
+	struct smb_direct_transport *t;
+	struct list_head *pos, *prev, *end;
+
+	sendmsg = container_of(wc->wr_cqe, struct smb_direct_sendmsg, cqe);
+	t = sendmsg->transport;
+
+	ksmbd_debug(RDMA, "Send completed. status='%s (%d)', opcode=%d\n",
+		    ib_wc_status_msg(wc->status), wc->status,
+		    wc->opcode);
+
+	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
+		ksmbd_err("Send error. status='%s (%d)', opcode=%d\n",
+			  ib_wc_status_msg(wc->status), wc->status,
+			  wc->opcode);
+		smb_direct_disconnect_rdma_connection(t);
+	}
+
+	if (sendmsg->num_sge > 1) {
+		if (atomic_dec_and_test(&t->send_payload_pending))
+			wake_up(&t->wait_send_payload_pending);
+	} else {
+		if (atomic_dec_and_test(&t->send_pending))
+			wake_up(&t->wait_send_pending);
+	}
+
+	/* iterate and free the list of messages in reverse. the list's head
+	 * is invalid.
+	 */
+	for (pos = &sendmsg->list, prev = pos->prev, end = sendmsg->list.next;
+	     prev != end; pos = prev, prev = prev->prev) {
+		sibling = container_of(pos, struct smb_direct_sendmsg, list);
+		smb_direct_free_sendmsg(t, sibling);
+	}
+
+	sibling = container_of(pos, struct smb_direct_sendmsg, list);
+	smb_direct_free_sendmsg(t, sibling);
+}
+
+static int manage_credits_prior_sending(struct smb_direct_transport *t)
+{
+	int new_credits;
+
+	spin_lock(&t->lock_new_recv_credits);
+	new_credits = t->new_recv_credits;
+	t->new_recv_credits = 0;
+	spin_unlock(&t->lock_new_recv_credits);
+
+	return new_credits;
+}
+
+static int smb_direct_post_send(struct smb_direct_transport *t,
+				struct ib_send_wr *wr)
+{
+	int ret;
+
+	if (wr->num_sge > 1)
+		atomic_inc(&t->send_payload_pending);
+	else
+		atomic_inc(&t->send_pending);
+
+	ret = ib_post_send(t->qp, wr, NULL);
+	if (ret) {
+		ksmbd_err("failed to post send: %d\n", ret);
+		if (wr->num_sge > 1) {
+			if (atomic_dec_and_test(&t->send_payload_pending))
+				wake_up(&t->wait_send_payload_pending);
+		} else {
+			if (atomic_dec_and_test(&t->send_pending))
+				wake_up(&t->wait_send_pending);
+		}
+		smb_direct_disconnect_rdma_connection(t);
+	}
+	return ret;
+}
+
+static void smb_direct_send_ctx_init(struct smb_direct_transport *t,
+				     struct smb_direct_send_ctx *send_ctx,
+				     bool need_invalidate_rkey,
+				     unsigned int remote_key)
+{
+	INIT_LIST_HEAD(&send_ctx->msg_list);
+	send_ctx->wr_cnt = 0;
+	send_ctx->need_invalidate_rkey = need_invalidate_rkey;
+	send_ctx->remote_key = remote_key;
+}
+
+static int smb_direct_flush_send_list(struct smb_direct_transport *t,
+				      struct smb_direct_send_ctx *send_ctx,
+				      bool is_last)
+{
+	struct smb_direct_sendmsg *first, *last;
+	int ret;
+
+	if (list_empty(&send_ctx->msg_list))
+		return 0;
+
+	first = list_first_entry(&send_ctx->msg_list,
+				 struct smb_direct_sendmsg,
+				 list);
+	last = list_last_entry(&send_ctx->msg_list,
+			       struct smb_direct_sendmsg,
+			       list);
+
+	last->wr.send_flags = IB_SEND_SIGNALED;
+	last->wr.wr_cqe = &last->cqe;
+	if (is_last && send_ctx->need_invalidate_rkey) {
+		last->wr.opcode = IB_WR_SEND_WITH_INV;
+		last->wr.ex.invalidate_rkey = send_ctx->remote_key;
+	}
+
+	ret = smb_direct_post_send(t, &first->wr);
+	if (!ret) {
+		smb_direct_send_ctx_init(t, send_ctx,
+					 send_ctx->need_invalidate_rkey,
+					 send_ctx->remote_key);
+	} else {
+		atomic_add(send_ctx->wr_cnt, &t->send_credits);
+		wake_up(&t->wait_send_credits);
+		list_for_each_entry_safe(first, last, &send_ctx->msg_list,
+					 list) {
+			smb_direct_free_sendmsg(t, first);
+		}
+	}
+	return ret;
+}
+
+static int wait_for_credits(struct smb_direct_transport *t,
+			    wait_queue_head_t *waitq, atomic_t *credits)
+{
+	int ret;
+
+	do {
+		if (atomic_dec_return(credits) >= 0)
+			return 0;
+
+		atomic_inc(credits);
+		ret = wait_event_interruptible(*waitq,
+					       atomic_read(credits) > 0 ||
+						t->status != SMB_DIRECT_CS_CONNECTED);
+
+		if (t->status != SMB_DIRECT_CS_CONNECTED)
+			return -ENOTCONN;
+		else if (ret < 0)
+			return ret;
+	} while (true);
+}
+
+static int wait_for_send_credits(struct smb_direct_transport *t,
+				 struct smb_direct_send_ctx *send_ctx)
+{
+	int ret;
+
+	if (send_ctx &&
+	    (send_ctx->wr_cnt >= 16 || atomic_read(&t->send_credits) <= 1)) {
+		ret = smb_direct_flush_send_list(t, send_ctx, false);
+		if (ret)
+			return ret;
+	}
+
+	return wait_for_credits(t, &t->wait_send_credits, &t->send_credits);
+}
+
+static int smb_direct_create_header(struct smb_direct_transport *t,
+				    int size, int remaining_data_length,
+				    struct smb_direct_sendmsg **sendmsg_out)
+{
+	struct smb_direct_sendmsg *sendmsg;
+	struct smb_direct_data_transfer *packet;
+	int header_length;
+	int ret;
+
+	sendmsg = smb_direct_alloc_sendmsg(t);
+	if (IS_ERR(sendmsg))
+		return PTR_ERR(sendmsg);
+
+	/* Fill in the packet header */
+	packet = (struct smb_direct_data_transfer *)sendmsg->packet;
+	packet->credits_requested = cpu_to_le16(t->send_credit_target);
+	packet->credits_granted = cpu_to_le16(manage_credits_prior_sending(t));
+
+	packet->flags = 0;
+	packet->reserved = 0;
+	if (!size)
+		packet->data_offset = 0;
+	else
+		packet->data_offset = cpu_to_le32(24);
+	packet->data_length = cpu_to_le32(size);
+	packet->remaining_data_length = cpu_to_le32(remaining_data_length);
+	packet->padding = 0;
+
+	ksmbd_debug(RDMA,
+		    "credits_requested=%d credits_granted=%d data_offset=%d data_length=%d remaining_data_length=%d\n",
+		    le16_to_cpu(packet->credits_requested),
+		    le16_to_cpu(packet->credits_granted),
+		    le32_to_cpu(packet->data_offset),
+		    le32_to_cpu(packet->data_length),
+		    le32_to_cpu(packet->remaining_data_length));
+
+	/* Map the packet to DMA */
+	header_length = sizeof(struct smb_direct_data_transfer);
+	/* If this is a packet without payload, don't send padding */
+	if (!size)
+		header_length =
+			offsetof(struct smb_direct_data_transfer, padding);
+
+	sendmsg->sge[0].addr = ib_dma_map_single(t->cm_id->device,
+						 (void *)packet,
+						 header_length,
+						 DMA_TO_DEVICE);
+	ret = ib_dma_mapping_error(t->cm_id->device, sendmsg->sge[0].addr);
+	if (ret) {
+		smb_direct_free_sendmsg(t, sendmsg);
+		return ret;
+	}
+
+	sendmsg->num_sge = 1;
+	sendmsg->sge[0].length = header_length;
+	sendmsg->sge[0].lkey = t->pd->local_dma_lkey;
+
+	*sendmsg_out = sendmsg;
+	return 0;
+}
+
+static int get_sg_list(void *buf, int size, struct scatterlist *sg_list, int nentries)
+{
+	bool high = is_vmalloc_addr(buf);
+	struct page *page;
+	int offset, len;
+	int i = 0;
+
+	if (nentries < BUFFER_NR_PAGES(buf, size))
+		return -EINVAL;
+
+	offset = offset_in_page(buf);
+	buf -= offset;
+	while (size > 0) {
+		len = min_t(int, PAGE_SIZE - offset, size);
+		if (high)
+			page = vmalloc_to_page(buf);
+		else
+			page = kmap_to_page(buf);
+
+		if (!sg_list)
+			return -EINVAL;
+		sg_set_page(sg_list, page, len, offset);
+		sg_list = sg_next(sg_list);
+
+		buf += PAGE_SIZE;
+		size -= len;
+		offset = 0;
+		i++;
+	}
+	return i;
+}
+
+static int get_mapped_sg_list(struct ib_device *device, void *buf, int size,
+			      struct scatterlist *sg_list, int nentries,
+			      enum dma_data_direction dir)
+{
+	int npages;
+
+	npages = get_sg_list(buf, size, sg_list, nentries);
+	if (npages <= 0)
+		return -EINVAL;
+	return ib_dma_map_sg(device, sg_list, npages, dir);
+}
+
+static int post_sendmsg(struct smb_direct_transport *t,
+			struct smb_direct_send_ctx *send_ctx,
+			struct smb_direct_sendmsg *msg)
+{
+	int i;
+
+	for (i = 0; i < msg->num_sge; i++)
+		ib_dma_sync_single_for_device(t->cm_id->device,
+					      msg->sge[i].addr, msg->sge[i].length,
+					      DMA_TO_DEVICE);
+
+	msg->cqe.done = send_done;
+	msg->wr.opcode = IB_WR_SEND;
+	msg->wr.sg_list = &msg->sge[0];
+	msg->wr.num_sge = msg->num_sge;
+	msg->wr.next = NULL;
+
+	if (send_ctx) {
+		msg->wr.wr_cqe = NULL;
+		msg->wr.send_flags = 0;
+		if (!list_empty(&send_ctx->msg_list)) {
+			struct smb_direct_sendmsg *last;
+
+			last = list_last_entry(&send_ctx->msg_list,
+					       struct smb_direct_sendmsg,
+					       list);
+			last->wr.next = &msg->wr;
+		}
+		list_add_tail(&msg->list, &send_ctx->msg_list);
+		send_ctx->wr_cnt++;
+		return 0;
+	}
+
+	msg->wr.wr_cqe = &msg->cqe;
+	msg->wr.send_flags = IB_SEND_SIGNALED;
+	return smb_direct_post_send(t, &msg->wr);
+}
+
+static int smb_direct_post_send_data(struct smb_direct_transport *t,
+				     struct smb_direct_send_ctx *send_ctx,
+				     struct kvec *iov, int niov,
+				     int remaining_data_length)
+{
+	int i, j, ret;
+	struct smb_direct_sendmsg *msg;
+	int data_length;
+	struct scatterlist sg[SMB_DIRECT_MAX_SEND_SGES - 1];
+
+	ret = wait_for_send_credits(t, send_ctx);
+	if (ret)
+		return ret;
+
+	data_length = 0;
+	for (i = 0; i < niov; i++)
+		data_length += iov[i].iov_len;
+
+	ret = smb_direct_create_header(t, data_length, remaining_data_length,
+				       &msg);
+	if (ret) {
+		atomic_inc(&t->send_credits);
+		return ret;
+	}
+
+	for (i = 0; i < niov; i++) {
+		struct ib_sge *sge;
+		int sg_cnt;
+
+		sg_init_table(sg, SMB_DIRECT_MAX_SEND_SGES - 1);
+		sg_cnt = get_mapped_sg_list(t->cm_id->device,
+					    iov[i].iov_base, iov[i].iov_len,
+					    sg, SMB_DIRECT_MAX_SEND_SGES - 1,
+					    DMA_TO_DEVICE);
+		if (sg_cnt <= 0) {
+			ksmbd_err("failed to map buffer\n");
+			ret = -ENOMEM;
+			goto err;
+		} else if (sg_cnt + msg->num_sge > SMB_DIRECT_MAX_SEND_SGES - 1) {
+			ksmbd_err("buffer not fitted into sges\n");
+			ret = -E2BIG;
+			ib_dma_unmap_sg(t->cm_id->device, sg, sg_cnt,
+					DMA_TO_DEVICE);
+			goto err;
+		}
+
+		for (j = 0; j < sg_cnt; j++) {
+			sge = &msg->sge[msg->num_sge];
+			sge->addr = sg_dma_address(&sg[j]);
+			sge->length = sg_dma_len(&sg[j]);
+			sge->lkey  = t->pd->local_dma_lkey;
+			msg->num_sge++;
+		}
+	}
+
+	ret = post_sendmsg(t, send_ctx, msg);
+	if (ret)
+		goto err;
+	return 0;
+err:
+	smb_direct_free_sendmsg(t, msg);
+	atomic_inc(&t->send_credits);
+	return ret;
+}
+
+static int smb_direct_writev(struct ksmbd_transport *t,
+			     struct kvec *iov, int niovs, int buflen,
+			     bool need_invalidate, unsigned int remote_key)
+{
+	struct smb_direct_transport *st = SMB_DIRECT_TRANS(t);
+	int remaining_data_length;
+	int start, i, j;
+	int max_iov_size = st->max_send_size -
+			sizeof(struct smb_direct_data_transfer);
+	int ret;
+	struct kvec vec;
+	struct smb_direct_send_ctx send_ctx;
+
+	if (st->status != SMB_DIRECT_CS_CONNECTED) {
+		ret = -ENOTCONN;
+		goto done;
+	}
+
+	//FIXME: skip RFC1002 header..
+	buflen -= 4;
+	iov[0].iov_base += 4;
+	iov[0].iov_len -= 4;
+
+	remaining_data_length = buflen;
+	ksmbd_debug(RDMA, "Sending smb (RDMA): smb_len=%u\n", buflen);
+
+	smb_direct_send_ctx_init(st, &send_ctx, need_invalidate, remote_key);
+	start = i = 0;
+	buflen = 0;
+	while (true) {
+		buflen += iov[i].iov_len;
+		if (buflen > max_iov_size) {
+			if (i > start) {
+				remaining_data_length -=
+					(buflen - iov[i].iov_len);
+				ret = smb_direct_post_send_data(st, &send_ctx,
+								&iov[start], i - start,
+								remaining_data_length);
+				if (ret)
+					goto done;
+			} else {
+				/* iov[start] is too big, break it */
+				int nvec  = (buflen + max_iov_size - 1) /
+						max_iov_size;
+
+				for (j = 0; j < nvec; j++) {
+					vec.iov_base =
+						(char *)iov[start].iov_base +
+						j * max_iov_size;
+					vec.iov_len =
+						min_t(int, max_iov_size,
+						      buflen - max_iov_size * j);
+					remaining_data_length -= vec.iov_len;
+					ret = smb_direct_post_send_data(st, &send_ctx, &vec, 1,
+									remaining_data_length);
+					if (ret)
+						goto done;
+				}
+				i++;
+				if (i == niovs)
+					break;
+			}
+			start = i;
+			buflen = 0;
+		} else {
+			i++;
+			if (i == niovs) {
+				/* send out all remaining vecs */
+				remaining_data_length -= buflen;
+				ret = smb_direct_post_send_data(st, &send_ctx,
+								&iov[start], i - start,
+								remaining_data_length);
+				if (ret)
+					goto done;
+				break;
+			}
+		}
+	}
+
+done:
+	ret = smb_direct_flush_send_list(st, &send_ctx, true);
+
+	/*
+	 * As an optimization, we don't wait for individual I/O to finish
+	 * before sending the next one.
+	 * Send them all and wait for pending send count to get to 0
+	 * that means all the I/Os have been out and we are good to return
+	 */
+
+	wait_event(st->wait_send_payload_pending,
+		   atomic_read(&st->send_payload_pending) == 0);
+	return ret;
+}
+
+static void read_write_done(struct ib_cq *cq, struct ib_wc *wc,
+			    enum dma_data_direction dir)
+{
+	struct smb_direct_rdma_rw_msg *msg = container_of(wc->wr_cqe,
+							  struct smb_direct_rdma_rw_msg, cqe);
+	struct smb_direct_transport *t = msg->t;
+
+	if (wc->status != IB_WC_SUCCESS) {
+		ksmbd_err("read/write error. opcode = %d, status = %s(%d)\n",
+			  wc->opcode, ib_wc_status_msg(wc->status), wc->status);
+		smb_direct_disconnect_rdma_connection(t);
+	}
+
+	if (atomic_inc_return(&t->rw_avail_ops) > 0)
+		wake_up(&t->wait_rw_avail_ops);
+
+	rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
+			    msg->sg_list, msg->sgt.nents, dir);
+	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+	complete(msg->completion);
+	kfree(msg);
+}
+
+static void read_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	read_write_done(cq, wc, DMA_FROM_DEVICE);
+}
+
+static void write_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	read_write_done(cq, wc, DMA_TO_DEVICE);
+}
+
+static int smb_direct_rdma_xmit(struct smb_direct_transport *t, void *buf,
+				int buf_len, u32 remote_key, u64 remote_offset,
+				u32 remote_len, bool is_read)
+{
+	struct smb_direct_rdma_rw_msg *msg;
+	int ret;
+	DECLARE_COMPLETION_ONSTACK(completion);
+	struct ib_send_wr *first_wr = NULL;
+
+	ret = wait_for_credits(t, &t->wait_rw_avail_ops, &t->rw_avail_ops);
+	if (ret < 0)
+		return ret;
+
+	/* TODO: mempool */
+	msg = kmalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
+		      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
+	if (!msg) {
+		atomic_inc(&t->rw_avail_ops);
+		return -ENOMEM;
+	}
+
+	msg->sgt.sgl = &msg->sg_list[0];
+	ret = sg_alloc_table_chained(&msg->sgt,
+				     BUFFER_NR_PAGES(buf, buf_len),
+				     msg->sg_list, SG_CHUNK_SIZE);
+	if (ret) {
+		atomic_inc(&t->rw_avail_ops);
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	ret = get_sg_list(buf, buf_len, msg->sgt.sgl, msg->sgt.orig_nents);
+	if (ret <= 0) {
+		ksmbd_err("failed to get pages\n");
+		goto err;
+	}
+
+	ret = rdma_rw_ctx_init(&msg->rw_ctx, t->qp, t->qp->port,
+			       msg->sg_list, BUFFER_NR_PAGES(buf, buf_len),
+			       0, remote_offset, remote_key,
+			       is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	if (ret < 0) {
+		ksmbd_err("failed to init rdma_rw_ctx: %d\n", ret);
+		goto err;
+	}
+
+	msg->t = t;
+	msg->cqe.done = is_read ? read_done : write_done;
+	msg->completion = &completion;
+	first_wr = rdma_rw_ctx_wrs(&msg->rw_ctx, t->qp, t->qp->port,
+				   &msg->cqe, NULL);
+
+	ret = ib_post_send(t->qp, first_wr, NULL);
+	if (ret) {
+		ksmbd_err("failed to post send wr: %d\n", ret);
+		goto err;
+	}
+
+	wait_for_completion(&completion);
+	return 0;
+
+err:
+	atomic_inc(&t->rw_avail_ops);
+	if (first_wr)
+		rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
+				    msg->sg_list, msg->sgt.nents,
+				    is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+	kfree(msg);
+	return ret;
+}
+
+static int smb_direct_rdma_write(struct ksmbd_transport *t, void *buf,
+				 unsigned int buflen, u32 remote_key,
+				 u64 remote_offset, u32 remote_len)
+{
+	return smb_direct_rdma_xmit(SMB_DIRECT_TRANS(t), buf, buflen,
+				    remote_key, remote_offset,
+				    remote_len, false);
+}
+
+static int smb_direct_rdma_read(struct ksmbd_transport *t, void *buf,
+				unsigned int buflen, u32 remote_key,
+				u64 remote_offset, u32 remote_len)
+{
+	return smb_direct_rdma_xmit(SMB_DIRECT_TRANS(t), buf, buflen,
+				    remote_key, remote_offset,
+				    remote_len, true);
+}
+
+static void smb_direct_disconnect(struct ksmbd_transport *t)
+{
+	struct smb_direct_transport *st = SMB_DIRECT_TRANS(t);
+
+	ksmbd_debug(RDMA, "Disconnecting cm_id=%p\n", st->cm_id);
+
+	smb_direct_disconnect_rdma_connection(st);
+	wait_event_interruptible(st->wait_status,
+				 st->status == SMB_DIRECT_CS_DISCONNECTED);
+	free_transport(st);
+}
+
+static int smb_direct_cm_handler(struct rdma_cm_id *cm_id,
+				 struct rdma_cm_event *event)
+{
+	struct smb_direct_transport *t = cm_id->context;
+
+	ksmbd_debug(RDMA, "RDMA CM event. cm_id=%p event=%s (%d)\n",
+		    cm_id, rdma_event_msg(event->event), event->event);
+
+	switch (event->event) {
+	case RDMA_CM_EVENT_ESTABLISHED: {
+		t->status = SMB_DIRECT_CS_CONNECTED;
+		wake_up_interruptible(&t->wait_status);
+		break;
+	}
+	case RDMA_CM_EVENT_DEVICE_REMOVAL:
+	case RDMA_CM_EVENT_DISCONNECTED: {
+		t->status = SMB_DIRECT_CS_DISCONNECTED;
+		wake_up_interruptible(&t->wait_status);
+		wake_up_interruptible(&t->wait_reassembly_queue);
+		wake_up(&t->wait_send_credits);
+		break;
+	}
+	case RDMA_CM_EVENT_CONNECT_ERROR: {
+		t->status = SMB_DIRECT_CS_DISCONNECTED;
+		wake_up_interruptible(&t->wait_status);
+		break;
+	}
+	default:
+		ksmbd_err("Unexpected RDMA CM event. cm_id=%p, event=%s (%d)\n",
+			  cm_id, rdma_event_msg(event->event),
+			  event->event);
+		break;
+	}
+	return 0;
+}
+
+static void smb_direct_qpair_handler(struct ib_event *event, void *context)
+{
+	struct smb_direct_transport *t = context;
+
+	ksmbd_debug(RDMA, "Received QP event. cm_id=%p, event=%s (%d)\n",
+		    t->cm_id, ib_event_msg(event->event), event->event);
+
+	switch (event->event) {
+	case IB_EVENT_CQ_ERR:
+	case IB_EVENT_QP_FATAL:
+		smb_direct_disconnect_rdma_connection(t);
+		break;
+	default:
+		break;
+	}
+}
+
+static int smb_direct_send_negotiate_response(struct smb_direct_transport *t,
+					      int failed)
+{
+	struct smb_direct_sendmsg *sendmsg;
+	struct smb_direct_negotiate_resp *resp;
+	int ret;
+
+	sendmsg = smb_direct_alloc_sendmsg(t);
+	if (IS_ERR(sendmsg))
+		return -ENOMEM;
+
+	resp = (struct smb_direct_negotiate_resp *)sendmsg->packet;
+	if (failed) {
+		memset(resp, 0, sizeof(*resp));
+		resp->min_version = cpu_to_le16(0x0100);
+		resp->max_version = cpu_to_le16(0x0100);
+		resp->status = STATUS_NOT_SUPPORTED;
+	} else {
+		resp->status = STATUS_SUCCESS;
+		resp->min_version = SMB_DIRECT_VERSION_LE;
+		resp->max_version = SMB_DIRECT_VERSION_LE;
+		resp->negotiated_version = SMB_DIRECT_VERSION_LE;
+		resp->reserved = 0;
+		resp->credits_requested =
+				cpu_to_le16(t->send_credit_target);
+		resp->credits_granted = cpu_to_le16(manage_credits_prior_sending(t));
+		resp->max_readwrite_size = cpu_to_le32(t->max_rdma_rw_size);
+		resp->preferred_send_size = cpu_to_le32(t->max_send_size);
+		resp->max_receive_size = cpu_to_le32(t->max_recv_size);
+		resp->max_fragmented_size =
+				cpu_to_le32(t->max_fragmented_recv_size);
+	}
+
+	sendmsg->sge[0].addr = ib_dma_map_single(t->cm_id->device,
+						 (void *)resp, sizeof(*resp),
+						 DMA_TO_DEVICE);
+	ret = ib_dma_mapping_error(t->cm_id->device, sendmsg->sge[0].addr);
+	if (ret) {
+		smb_direct_free_sendmsg(t, sendmsg);
+		return ret;
+	}
+
+	sendmsg->num_sge = 1;
+	sendmsg->sge[0].length = sizeof(*resp);
+	sendmsg->sge[0].lkey = t->pd->local_dma_lkey;
+
+	ret = post_sendmsg(t, NULL, sendmsg);
+	if (ret) {
+		smb_direct_free_sendmsg(t, sendmsg);
+		return ret;
+	}
+
+	wait_event(t->wait_send_pending,
+		   atomic_read(&t->send_pending) == 0);
+	return 0;
+}
+
+static int smb_direct_accept_client(struct smb_direct_transport *t)
+{
+	struct rdma_conn_param conn_param;
+	struct ib_port_immutable port_immutable;
+	u32 ird_ord_hdr[2];
+	int ret;
+
+	memset(&conn_param, 0, sizeof(conn_param));
+	conn_param.initiator_depth = min_t(u8, t->cm_id->device->attrs.max_qp_rd_atom,
+					   SMB_DIRECT_CM_INITIATOR_DEPTH);
+	conn_param.responder_resources = 0;
+
+	t->cm_id->device->ops.get_port_immutable(t->cm_id->device,
+						 t->cm_id->port_num,
+						 &port_immutable);
+	if (port_immutable.core_cap_flags & RDMA_CORE_PORT_IWARP) {
+		ird_ord_hdr[0] = conn_param.responder_resources;
+		ird_ord_hdr[1] = 1;
+		conn_param.private_data = ird_ord_hdr;
+		conn_param.private_data_len = sizeof(ird_ord_hdr);
+	} else {
+		conn_param.private_data = NULL;
+		conn_param.private_data_len = 0;
+	}
+	conn_param.retry_count = SMB_DIRECT_CM_RETRY;
+	conn_param.rnr_retry_count = SMB_DIRECT_CM_RNR_RETRY;
+	conn_param.flow_control = 0;
+
+	ret = rdma_accept(t->cm_id, &conn_param);
+	if (ret) {
+		ksmbd_err("error at rdma_accept: %d\n", ret);
+		return ret;
+	}
+
+	wait_event_interruptible(t->wait_status,
+				 t->status != SMB_DIRECT_CS_NEW);
+	if (t->status != SMB_DIRECT_CS_CONNECTED)
+		return -ENOTCONN;
+	return 0;
+}
+
+static int smb_direct_negotiate(struct smb_direct_transport *t)
+{
+	int ret;
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_negotiate_req *req;
+
+	recvmsg = get_free_recvmsg(t);
+	if (!recvmsg)
+		return -ENOMEM;
+	recvmsg->type = SMB_DIRECT_MSG_NEGOTIATE_REQ;
+
+	ret = smb_direct_post_recv(t, recvmsg);
+	if (ret) {
+		ksmbd_err("Can't post recv: %d\n", ret);
+		goto out;
+	}
+
+	t->negotiation_requested = false;
+	ret = smb_direct_accept_client(t);
+	if (ret) {
+		ksmbd_err("Can't accept client\n");
+		goto out;
+	}
+
+	smb_direct_post_recv_credits(&t->post_recv_credits_work.work);
+
+	ksmbd_debug(RDMA, "Waiting for SMB_DIRECT negotiate request\n");
+	ret = wait_event_interruptible_timeout(t->wait_status,
+					       t->negotiation_requested ||
+						t->status == SMB_DIRECT_CS_DISCONNECTED,
+					       SMB_DIRECT_NEGOTIATE_TIMEOUT * HZ);
+	if (ret <= 0 || t->status == SMB_DIRECT_CS_DISCONNECTED) {
+		ret = ret < 0 ? ret : -ETIMEDOUT;
+		goto out;
+	}
+
+	ret = smb_direct_check_recvmsg(recvmsg);
+	if (ret == -ECONNABORTED)
+		goto out;
+
+	req = (struct smb_direct_negotiate_req *)recvmsg->packet;
+	t->max_recv_size = min_t(int, t->max_recv_size,
+				 le32_to_cpu(req->preferred_send_size));
+	t->max_send_size = min_t(int, t->max_send_size,
+				 le32_to_cpu(req->max_receive_size));
+	t->max_fragmented_send_size =
+			le32_to_cpu(req->max_fragmented_size);
+
+	ret = smb_direct_send_negotiate_response(t, ret);
+out:
+	if (recvmsg)
+		put_recvmsg(t, recvmsg);
+	return ret;
+}
+
+static int smb_direct_init_params(struct smb_direct_transport *t,
+				  struct ib_qp_cap *cap)
+{
+	struct ib_device *device = t->cm_id->device;
+	int max_send_sges, max_pages, max_rw_wrs, max_send_wrs;
+
+	/* need 2 more sge. because a SMB_DIRECT header will be mapped,
+	 * and maybe a send buffer could be not page aligned.
+	 */
+	t->max_send_size = smb_direct_max_send_size;
+	max_send_sges = DIV_ROUND_UP(t->max_send_size, PAGE_SIZE) + 2;
+	if (max_send_sges > SMB_DIRECT_MAX_SEND_SGES) {
+		ksmbd_err("max_send_size %d is too large\n", t->max_send_size);
+		return -EINVAL;
+	}
+
+	/*
+	 * allow smb_direct_max_outstanding_rw_ops of in-flight RDMA
+	 * read/writes. HCA guarantees at least max_send_sge of sges for
+	 * a RDMA read/write work request, and if memory registration is used,
+	 * we need reg_mr, local_inv wrs for each read/write.
+	 */
+	t->max_rdma_rw_size = smb_direct_max_read_write_size;
+	max_pages = DIV_ROUND_UP(t->max_rdma_rw_size, PAGE_SIZE) + 1;
+	max_rw_wrs = DIV_ROUND_UP(max_pages, SMB_DIRECT_MAX_SEND_SGES);
+	max_rw_wrs += rdma_rw_mr_factor(device, t->cm_id->port_num,
+			max_pages) * 2;
+	max_rw_wrs *= smb_direct_max_outstanding_rw_ops;
+
+	max_send_wrs = smb_direct_send_credit_target + max_rw_wrs;
+	if (max_send_wrs > device->attrs.max_cqe ||
+	    max_send_wrs > device->attrs.max_qp_wr) {
+		ksmbd_err("consider lowering send_credit_target = %d, or max_outstanding_rw_ops = %d\n",
+			  smb_direct_send_credit_target,
+			  smb_direct_max_outstanding_rw_ops);
+		ksmbd_err("Possible CQE overrun, device reporting max_cqe %d max_qp_wr %d\n",
+			  device->attrs.max_cqe, device->attrs.max_qp_wr);
+		return -EINVAL;
+	}
+
+	if (smb_direct_receive_credit_max > device->attrs.max_cqe ||
+	    smb_direct_receive_credit_max > device->attrs.max_qp_wr) {
+		ksmbd_err("consider lowering receive_credit_max = %d\n",
+			  smb_direct_receive_credit_max);
+		ksmbd_err("Possible CQE overrun, device reporting max_cpe %d max_qp_wr %d\n",
+			  device->attrs.max_cqe, device->attrs.max_qp_wr);
+		return -EINVAL;
+	}
+
+	if (device->attrs.max_send_sge < SMB_DIRECT_MAX_SEND_SGES) {
+		ksmbd_err("warning: device max_send_sge = %d too small\n",
+			  device->attrs.max_send_sge);
+		return -EINVAL;
+	}
+	if (device->attrs.max_recv_sge < SMB_DIRECT_MAX_RECV_SGES) {
+		ksmbd_err("warning: device max_recv_sge = %d too small\n",
+			  device->attrs.max_recv_sge);
+		return -EINVAL;
+	}
+
+	t->recv_credits = 0;
+	t->count_avail_recvmsg = 0;
+
+	t->recv_credit_max = smb_direct_receive_credit_max;
+	t->recv_credit_target = 10;
+	t->new_recv_credits = 0;
+
+	t->send_credit_target = smb_direct_send_credit_target;
+	atomic_set(&t->send_credits, 0);
+	atomic_set(&t->rw_avail_ops, smb_direct_max_outstanding_rw_ops);
+
+	t->max_send_size = smb_direct_max_send_size;
+	t->max_recv_size = smb_direct_max_receive_size;
+	t->max_fragmented_recv_size = smb_direct_max_fragmented_recv_size;
+
+	cap->max_send_wr = max_send_wrs;
+	cap->max_recv_wr = t->recv_credit_max;
+	cap->max_send_sge = SMB_DIRECT_MAX_SEND_SGES;
+	cap->max_recv_sge = SMB_DIRECT_MAX_RECV_SGES;
+	cap->max_inline_data = 0;
+	cap->max_rdma_ctxs = 0;
+	return 0;
+}
+
+static void smb_direct_destroy_pools(struct smb_direct_transport *t)
+{
+	struct smb_direct_recvmsg *recvmsg;
+
+	while ((recvmsg = get_free_recvmsg(t)))
+		mempool_free(recvmsg, t->recvmsg_mempool);
+	while ((recvmsg = get_empty_recvmsg(t)))
+		mempool_free(recvmsg, t->recvmsg_mempool);
+
+	mempool_destroy(t->recvmsg_mempool);
+	t->recvmsg_mempool = NULL;
+
+	kmem_cache_destroy(t->recvmsg_cache);
+	t->recvmsg_cache = NULL;
+
+	mempool_destroy(t->sendmsg_mempool);
+	t->sendmsg_mempool = NULL;
+
+	kmem_cache_destroy(t->sendmsg_cache);
+	t->sendmsg_cache = NULL;
+}
+
+static int smb_direct_create_pools(struct smb_direct_transport *t)
+{
+	char name[80];
+	int i;
+	struct smb_direct_recvmsg *recvmsg;
+
+	snprintf(name, sizeof(name), "smb_direct_rqst_pool_%p", t);
+	t->sendmsg_cache = kmem_cache_create(name,
+					     sizeof(struct smb_direct_sendmsg) +
+					      sizeof(struct smb_direct_negotiate_resp),
+					     0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!t->sendmsg_cache)
+		return -ENOMEM;
+
+	t->sendmsg_mempool = mempool_create(t->send_credit_target,
+					    mempool_alloc_slab, mempool_free_slab,
+					    t->sendmsg_cache);
+	if (!t->sendmsg_mempool)
+		goto err;
+
+	snprintf(name, sizeof(name), "smb_direct_resp_%p", t);
+	t->recvmsg_cache = kmem_cache_create(name,
+					     sizeof(struct smb_direct_recvmsg) +
+					      t->max_recv_size,
+					     0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!t->recvmsg_cache)
+		goto err;
+
+	t->recvmsg_mempool =
+		mempool_create(t->recv_credit_max, mempool_alloc_slab,
+			       mempool_free_slab, t->recvmsg_cache);
+	if (!t->recvmsg_mempool)
+		goto err;
+
+	INIT_LIST_HEAD(&t->recvmsg_queue);
+
+	for (i = 0; i < t->recv_credit_max; i++) {
+		recvmsg = mempool_alloc(t->recvmsg_mempool, GFP_KERNEL);
+		if (!recvmsg)
+			goto err;
+		recvmsg->transport = t;
+		list_add(&recvmsg->list, &t->recvmsg_queue);
+	}
+	t->count_avail_recvmsg = t->recv_credit_max;
+
+	return 0;
+err:
+	smb_direct_destroy_pools(t);
+	return -ENOMEM;
+}
+
+static int smb_direct_create_qpair(struct smb_direct_transport *t,
+				   struct ib_qp_cap *cap)
+{
+	int ret;
+	struct ib_qp_init_attr qp_attr;
+
+	t->pd = ib_alloc_pd(t->cm_id->device, 0);
+	if (IS_ERR(t->pd)) {
+		ksmbd_err("Can't create RDMA PD\n");
+		ret = PTR_ERR(t->pd);
+		t->pd = NULL;
+		return ret;
+	}
+
+	t->send_cq = ib_alloc_cq(t->cm_id->device, t,
+				 t->send_credit_target, 0, IB_POLL_WORKQUEUE);
+	if (IS_ERR(t->send_cq)) {
+		ksmbd_err("Can't create RDMA send CQ\n");
+		ret = PTR_ERR(t->send_cq);
+		t->send_cq = NULL;
+		goto err;
+	}
+
+	t->recv_cq = ib_alloc_cq(t->cm_id->device, t,
+				 cap->max_send_wr + cap->max_rdma_ctxs,
+				 0, IB_POLL_WORKQUEUE);
+	if (IS_ERR(t->recv_cq)) {
+		ksmbd_err("Can't create RDMA recv CQ\n");
+		ret = PTR_ERR(t->recv_cq);
+		t->recv_cq = NULL;
+		goto err;
+	}
+
+	memset(&qp_attr, 0, sizeof(qp_attr));
+	qp_attr.event_handler = smb_direct_qpair_handler;
+	qp_attr.qp_context = t;
+	qp_attr.cap = *cap;
+	qp_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
+	qp_attr.qp_type = IB_QPT_RC;
+	qp_attr.send_cq = t->send_cq;
+	qp_attr.recv_cq = t->recv_cq;
+	qp_attr.port_num = ~0;
+
+	ret = rdma_create_qp(t->cm_id, t->pd, &qp_attr);
+	if (ret) {
+		ksmbd_err("Can't create RDMA QP: %d\n", ret);
+		goto err;
+	}
+
+	t->qp = t->cm_id->qp;
+	t->cm_id->event_handler = smb_direct_cm_handler;
+
+	return 0;
+err:
+	if (t->qp) {
+		ib_destroy_qp(t->qp);
+		t->qp = NULL;
+	}
+	if (t->recv_cq) {
+		ib_destroy_cq(t->recv_cq);
+		t->recv_cq = NULL;
+	}
+	if (t->send_cq) {
+		ib_destroy_cq(t->send_cq);
+		t->send_cq = NULL;
+	}
+	if (t->pd) {
+		ib_dealloc_pd(t->pd);
+		t->pd = NULL;
+	}
+	return ret;
+}
+
+static int smb_direct_prepare(struct ksmbd_transport *t)
+{
+	struct smb_direct_transport *st = SMB_DIRECT_TRANS(t);
+	int ret;
+	struct ib_qp_cap qp_cap;
+
+	ret = smb_direct_init_params(st, &qp_cap);
+	if (ret) {
+		ksmbd_err("Can't configure RDMA parameters\n");
+		return ret;
+	}
+
+	ret = smb_direct_create_pools(st);
+	if (ret) {
+		ksmbd_err("Can't init RDMA pool: %d\n", ret);
+		return ret;
+	}
+
+	ret = smb_direct_create_qpair(st, &qp_cap);
+	if (ret) {
+		ksmbd_err("Can't accept RDMA client: %d\n", ret);
+		return ret;
+	}
+
+	ret = smb_direct_negotiate(st);
+	if (ret) {
+		ksmbd_err("Can't negotiate: %d\n", ret);
+		return ret;
+	}
+
+	st->status = SMB_DIRECT_CS_CONNECTED;
+	return 0;
+}
+
+static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
+{
+	if (!(attrs->device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS))
+		return false;
+	if (attrs->max_fast_reg_page_list_len == 0)
+		return false;
+	return true;
+}
+
+static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
+{
+	struct smb_direct_transport *t;
+
+	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
+		ksmbd_debug(RDMA,
+			    "Fast Registration Work Requests is not supported. device capabilities=%llx\n",
+			    new_cm_id->device->attrs.device_cap_flags);
+		return -EPROTONOSUPPORT;
+	}
+
+	t = alloc_transport(new_cm_id);
+	if (!t)
+		return -ENOMEM;
+
+	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
+					      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
+					      SMB_DIRECT_PORT);
+	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
+		int ret = PTR_ERR(KSMBD_TRANS(t)->handler);
+
+		ksmbd_err("Can't start thread\n");
+		free_transport(t);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int smb_direct_listen_handler(struct rdma_cm_id *cm_id,
+				     struct rdma_cm_event *event)
+{
+	switch (event->event) {
+	case RDMA_CM_EVENT_CONNECT_REQUEST: {
+		int ret = smb_direct_handle_connect_request(cm_id);
+
+		if (ret) {
+			ksmbd_err("Can't create transport: %d\n", ret);
+			return ret;
+		}
+
+		ksmbd_debug(RDMA, "Received connection request. cm_id=%p\n",
+			    cm_id);
+		break;
+	}
+	default:
+		ksmbd_err("Unexpected listen event. cm_id=%p, event=%s (%d)\n",
+			  cm_id, rdma_event_msg(event->event), event->event);
+		break;
+	}
+	return 0;
+}
+
+static int smb_direct_listen(int port)
+{
+	int ret;
+	struct rdma_cm_id *cm_id;
+	struct sockaddr_in sin = {
+		.sin_family		= AF_INET,
+		.sin_addr.s_addr	= htonl(INADDR_ANY),
+		.sin_port		= htons(port),
+	};
+
+	cm_id = rdma_create_id(&init_net, smb_direct_listen_handler,
+			       &smb_direct_listener, RDMA_PS_TCP, IB_QPT_RC);
+	if (IS_ERR(cm_id)) {
+		ksmbd_err("Can't create cm id: %ld\n", PTR_ERR(cm_id));
+		return PTR_ERR(cm_id);
+	}
+
+	ret = rdma_bind_addr(cm_id, (struct sockaddr *)&sin);
+	if (ret) {
+		ksmbd_err("Can't bind: %d\n", ret);
+		goto err;
+	}
+
+	smb_direct_listener.cm_id = cm_id;
+
+	ret = rdma_listen(cm_id, 10);
+	if (ret) {
+		ksmbd_err("Can't listen: %d\n", ret);
+		goto err;
+	}
+	return 0;
+err:
+	smb_direct_listener.cm_id = NULL;
+	rdma_destroy_id(cm_id);
+	return ret;
+}
+
+int ksmbd_rdma_init(void)
+{
+	int ret;
+
+	smb_direct_listener.cm_id = NULL;
+
+	/* When a client is running out of send credits, the credits are
+	 * granted by the server's sending a packet using this queue.
+	 * This avoids the situation that a clients cannot send packets
+	 * for lack of credits
+	 */
+	smb_direct_wq = alloc_workqueue("ksmbd-smb_direct-wq",
+					WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!smb_direct_wq)
+		return -ENOMEM;
+
+	ret = smb_direct_listen(SMB_DIRECT_PORT);
+	if (ret) {
+		destroy_workqueue(smb_direct_wq);
+		smb_direct_wq = NULL;
+		ksmbd_err("Can't listen: %d\n", ret);
+		return ret;
+	}
+
+	ksmbd_debug(RDMA, "init RDMA listener. cm_id=%p\n",
+		    smb_direct_listener.cm_id);
+	return 0;
+}
+
+int ksmbd_rdma_destroy(void)
+{
+	if (smb_direct_listener.cm_id)
+		rdma_destroy_id(smb_direct_listener.cm_id);
+	smb_direct_listener.cm_id = NULL;
+
+	if (smb_direct_wq) {
+		flush_workqueue(smb_direct_wq);
+		destroy_workqueue(smb_direct_wq);
+		smb_direct_wq = NULL;
+	}
+	return 0;
+}
+
+static struct ksmbd_transport_ops ksmbd_smb_direct_transport_ops = {
+	.prepare	= smb_direct_prepare,
+	.disconnect	= smb_direct_disconnect,
+	.writev		= smb_direct_writev,
+	.read		= smb_direct_read,
+	.rdma_read	= smb_direct_rdma_read,
+	.rdma_write	= smb_direct_rdma_write,
+};
diff --git a/fs/cifsd/transport_rdma.h b/fs/cifsd/transport_rdma.h
new file mode 100644
index 000000000000..da60fcec3ede
--- /dev/null
+++ b/fs/cifsd/transport_rdma.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2017, Microsoft Corporation.
+ *   Copyright (C) 2018, LG Electronics.
+ */
+
+#ifndef __KSMBD_TRANSPORT_RDMA_H__
+#define __KSMBD_TRANSPORT_RDMA_H__
+
+#define SMB_DIRECT_PORT	5445
+
+/* SMB DIRECT negotiation request packet [MS-KSMBD] 2.2.1 */
+struct smb_direct_negotiate_req {
+	__le16 min_version;
+	__le16 max_version;
+	__le16 reserved;
+	__le16 credits_requested;
+	__le32 preferred_send_size;
+	__le32 max_receive_size;
+	__le32 max_fragmented_size;
+} __packed;
+
+/* SMB DIRECT negotiation response packet [MS-KSMBD] 2.2.2 */
+struct smb_direct_negotiate_resp {
+	__le16 min_version;
+	__le16 max_version;
+	__le16 negotiated_version;
+	__le16 reserved;
+	__le16 credits_requested;
+	__le16 credits_granted;
+	__le32 status;
+	__le32 max_readwrite_size;
+	__le32 preferred_send_size;
+	__le32 max_receive_size;
+	__le32 max_fragmented_size;
+} __packed;
+
+#define SMB_DIRECT_RESPONSE_REQUESTED 0x0001
+
+/* SMB DIRECT data transfer packet with payload [MS-KSMBD] 2.2.3 */
+struct smb_direct_data_transfer {
+	__le16 credits_requested;
+	__le16 credits_granted;
+	__le16 flags;
+	__le16 reserved;
+	__le32 remaining_data_length;
+	__le32 data_offset;
+	__le32 data_length;
+	__le32 padding;
+	__u8 buffer[];
+} __packed;
+
+#ifdef CONFIG_SMB_SERVER_SMBDIRECT
+int ksmbd_rdma_init(void);
+int ksmbd_rdma_destroy(void);
+#else
+static inline int ksmbd_rdma_init(void) { return 0; }
+static inline int ksmbd_rdma_destroy(void) { return 0; }
+#endif
+
+#endif /* __KSMBD_TRANSPORT_RDMA_H__ */
diff --git a/fs/cifsd/transport_tcp.c b/fs/cifsd/transport_tcp.c
new file mode 100644
index 000000000000..d6d5c0038dea
--- /dev/null
+++ b/fs/cifsd/transport_tcp.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/freezer.h>
+
+#include "smb_common.h"
+#include "server.h"
+#include "auth.h"
+#include "buffer_pool.h"
+#include "connection.h"
+#include "transport_tcp.h"
+
+#define IFACE_STATE_DOWN		BIT(0)
+#define IFACE_STATE_CONFIGURED		BIT(1)
+
+struct interface {
+	struct task_struct	*ksmbd_kthread;
+	struct socket		*ksmbd_socket;
+	struct list_head	entry;
+	char			*name;
+	struct mutex		sock_release_lock;
+	int			state;
+};
+
+static LIST_HEAD(iface_list);
+
+static int bind_additional_ifaces;
+
+struct tcp_transport {
+	struct ksmbd_transport		transport;
+	struct socket			*sock;
+	struct kvec			*iov;
+	unsigned int			nr_iov;
+};
+
+static struct ksmbd_transport_ops ksmbd_tcp_transport_ops;
+
+static void tcp_stop_kthread(struct task_struct *kthread);
+static struct interface *alloc_iface(char *ifname);
+
+#define KSMBD_TRANS(t)	(&(t)->transport)
+#define TCP_TRANS(t)	((struct tcp_transport *)container_of(t, \
+				struct tcp_transport, transport))
+
+static inline void ksmbd_tcp_nodelay(struct socket *sock)
+{
+	tcp_sock_set_nodelay(sock->sk);
+}
+
+static inline void ksmbd_tcp_reuseaddr(struct socket *sock)
+{
+	sock_set_reuseaddr(sock->sk);
+}
+
+static inline void ksmbd_tcp_rcv_timeout(struct socket *sock, s64 secs)
+{
+	lock_sock(sock->sk);
+	if (secs && secs < MAX_SCHEDULE_TIMEOUT / HZ - 1)
+		sock->sk->sk_rcvtimeo = secs * HZ;
+	else
+		sock->sk->sk_rcvtimeo = MAX_SCHEDULE_TIMEOUT;
+	release_sock(sock->sk);
+}
+
+static inline void ksmbd_tcp_snd_timeout(struct socket *sock, s64 secs)
+{
+	sock_set_sndtimeo(sock->sk, secs);
+}
+
+static struct tcp_transport *alloc_transport(struct socket *client_sk)
+{
+	struct tcp_transport *t;
+	struct ksmbd_conn *conn;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+	t->sock = client_sk;
+
+	conn = ksmbd_conn_alloc();
+	if (!conn) {
+		kfree(t);
+		return NULL;
+	}
+
+	conn->transport = KSMBD_TRANS(t);
+	KSMBD_TRANS(t)->conn = conn;
+	KSMBD_TRANS(t)->ops = &ksmbd_tcp_transport_ops;
+	return t;
+}
+
+static void free_transport(struct tcp_transport *t)
+{
+	kernel_sock_shutdown(t->sock, SHUT_RDWR);
+	sock_release(t->sock);
+	t->sock = NULL;
+
+	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
+	kfree(t->iov);
+	kfree(t);
+}
+
+/**
+ * kvec_array_init() - initialize a IO vector segment
+ * @new:	IO vector to be initialized
+ * @iov:	base IO vector
+ * @nr_segs:	number of segments in base iov
+ * @bytes:	total iovec length so far for read
+ *
+ * Return:	Number of IO segments
+ */
+static unsigned int kvec_array_init(struct kvec *new, struct kvec *iov,
+				    unsigned int nr_segs, size_t bytes)
+{
+	size_t base = 0;
+
+	while (bytes || !iov->iov_len) {
+		int copy = min(bytes, iov->iov_len);
+
+		bytes -= copy;
+		base += copy;
+		if (iov->iov_len == base) {
+			iov++;
+			nr_segs--;
+			base = 0;
+		}
+	}
+
+	memcpy(new, iov, sizeof(*iov) * nr_segs);
+	new->iov_base += base;
+	new->iov_len -= base;
+	return nr_segs;
+}
+
+/**
+ * get_conn_iovec() - get connection iovec for reading from socket
+ * @t:		TCP transport instance
+ * @nr_segs:	number of segments in iov
+ *
+ * Return:	return existing or newly allocate iovec
+ */
+static struct kvec *get_conn_iovec(struct tcp_transport *t, unsigned int nr_segs)
+{
+	struct kvec *new_iov;
+
+	if (t->iov && nr_segs <= t->nr_iov)
+		return t->iov;
+
+	/* not big enough -- allocate a new one and release the old */
+	new_iov = kmalloc_array(nr_segs, sizeof(*new_iov), GFP_KERNEL);
+	if (new_iov) {
+		kfree(t->iov);
+		t->iov = new_iov;
+		t->nr_iov = nr_segs;
+	}
+	return new_iov;
+}
+
+static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
+{
+	switch (sa->sa_family) {
+	case AF_INET:
+		return ntohs(((struct sockaddr_in *)sa)->sin_port);
+	case AF_INET6:
+		return ntohs(((struct sockaddr_in6 *)sa)->sin6_port);
+	}
+	return 0;
+}
+
+/**
+ * ksmbd_tcp_new_connection() - create a new tcp session on mount
+ * @client_sk:	socket associated with new connection
+ *
+ * whenever a new connection is requested, create a conn thread
+ * (session thread) to handle new incoming smb requests from the connection
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int ksmbd_tcp_new_connection(struct socket *client_sk)
+{
+	struct sockaddr *csin;
+	int rc = 0;
+	struct tcp_transport *t;
+
+	t = alloc_transport(client_sk);
+	if (!t)
+		return -ENOMEM;
+
+	csin = KSMBD_TCP_PEER_SOCKADDR(KSMBD_TRANS(t)->conn);
+	if (kernel_getpeername(client_sk, csin) < 0) {
+		ksmbd_err("client ip resolution failed\n");
+		rc = -EINVAL;
+		goto out_error;
+	}
+
+	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
+					      KSMBD_TRANS(t)->conn,
+					      "ksmbd:%u",
+					      ksmbd_tcp_get_port(csin));
+	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
+		ksmbd_err("cannot start conn thread\n");
+		rc = PTR_ERR(KSMBD_TRANS(t)->handler);
+		free_transport(t);
+	}
+	return rc;
+
+out_error:
+	free_transport(t);
+	return rc;
+}
+
+/**
+ * ksmbd_kthread_fn() - listen to new SMB connections and callback server
+ * @p:		arguments to forker thread
+ *
+ * Return:	Returns a task_struct or ERR_PTR
+ */
+static int ksmbd_kthread_fn(void *p)
+{
+	struct socket *client_sk = NULL;
+	struct interface *iface = (struct interface *)p;
+	int ret;
+
+	while (!kthread_should_stop()) {
+		mutex_lock(&iface->sock_release_lock);
+		if (!iface->ksmbd_socket) {
+			mutex_unlock(&iface->sock_release_lock);
+			break;
+		}
+		ret = kernel_accept(iface->ksmbd_socket, &client_sk,
+				    O_NONBLOCK);
+		mutex_unlock(&iface->sock_release_lock);
+		if (ret) {
+			if (ret == -EAGAIN)
+				/* check for new connections every 100 msecs */
+				schedule_timeout_interruptible(HZ / 10);
+			continue;
+		}
+
+		ksmbd_debug(CONN, "connect success: accepted new connection\n");
+		client_sk->sk->sk_rcvtimeo = KSMBD_TCP_RECV_TIMEOUT;
+		client_sk->sk->sk_sndtimeo = KSMBD_TCP_SEND_TIMEOUT;
+
+		ksmbd_tcp_new_connection(client_sk);
+	}
+
+	ksmbd_debug(CONN, "releasing socket\n");
+	return 0;
+}
+
+/**
+ * ksmbd_tcp_run_kthread() - start forker thread
+ * @iface: pointer to struct interface
+ *
+ * start forker thread(ksmbd/0) at module init time to listen
+ * on port 445 for new SMB connection requests. It creates per connection
+ * server threads(ksmbd/x)
+ *
+ * Return:	0 on success or error number
+ */
+static int ksmbd_tcp_run_kthread(struct interface *iface)
+{
+	int rc;
+	struct task_struct *kthread;
+
+	kthread = kthread_run(ksmbd_kthread_fn, (void *)iface, "ksmbd-%s",
+			      iface->name);
+	if (IS_ERR(kthread)) {
+		rc = PTR_ERR(kthread);
+		return rc;
+	}
+	iface->ksmbd_kthread = kthread;
+
+	return 0;
+}
+
+/**
+ * ksmbd_tcp_readv() - read data from socket in given iovec
+ * @t:		TCP transport instance
+ * @iov_orig:	base IO vector
+ * @nr_segs:	number of segments in base iov
+ * @to_read:	number of bytes to read from socket
+ *
+ * Return:	on success return number of bytes read from socket,
+ *		otherwise return error number
+ */
+static int ksmbd_tcp_readv(struct tcp_transport *t, struct kvec *iov_orig,
+			   unsigned int nr_segs, unsigned int to_read)
+{
+	int length = 0;
+	int total_read;
+	unsigned int segs;
+	struct msghdr ksmbd_msg;
+	struct kvec *iov;
+	struct ksmbd_conn *conn = KSMBD_TRANS(t)->conn;
+
+	iov = get_conn_iovec(t, nr_segs);
+	if (!iov)
+		return -ENOMEM;
+
+	ksmbd_msg.msg_control = NULL;
+	ksmbd_msg.msg_controllen = 0;
+
+	for (total_read = 0; to_read; total_read += length, to_read -= length) {
+		try_to_freeze();
+
+		if (!ksmbd_conn_alive(conn)) {
+			total_read = -ESHUTDOWN;
+			break;
+		}
+		segs = kvec_array_init(iov, iov_orig, nr_segs, total_read);
+
+		length = kernel_recvmsg(t->sock, &ksmbd_msg,
+					iov, segs, to_read, 0);
+
+		if (length == -EINTR) {
+			total_read = -ESHUTDOWN;
+			break;
+		} else if (conn->status == KSMBD_SESS_NEED_RECONNECT) {
+			total_read = -EAGAIN;
+			break;
+		} else if (length == -ERESTARTSYS || length == -EAGAIN) {
+			usleep_range(1000, 2000);
+			length = 0;
+			continue;
+		} else if (length <= 0) {
+			total_read = -EAGAIN;
+			break;
+		}
+	}
+	return total_read;
+}
+
+/**
+ * ksmbd_tcp_read() - read data from socket in given buffer
+ * @t:		TCP transport instance
+ * @buf:	buffer to store read data from socket
+ * @to_read:	number of bytes to read from socket
+ *
+ * Return:	on success return number of bytes read from socket,
+ *		otherwise return error number
+ */
+static int ksmbd_tcp_read(struct ksmbd_transport *t, char *buf, unsigned int to_read)
+{
+	struct kvec iov;
+
+	iov.iov_base = buf;
+	iov.iov_len = to_read;
+
+	return ksmbd_tcp_readv(TCP_TRANS(t), &iov, 1, to_read);
+}
+
+static int ksmbd_tcp_writev(struct ksmbd_transport *t, struct kvec *iov,
+			    int nvecs, int size, bool need_invalidate,
+			    unsigned int remote_key)
+
+{
+	struct msghdr smb_msg = {.msg_flags = MSG_NOSIGNAL};
+
+	return kernel_sendmsg(TCP_TRANS(t)->sock, &smb_msg, iov, nvecs, size);
+}
+
+static void ksmbd_tcp_disconnect(struct ksmbd_transport *t)
+{
+	free_transport(TCP_TRANS(t));
+}
+
+static void tcp_destroy_socket(struct socket *ksmbd_socket)
+{
+	int ret;
+
+	if (!ksmbd_socket)
+		return;
+
+	/* set zero to timeout */
+	ksmbd_tcp_rcv_timeout(ksmbd_socket, 0);
+	ksmbd_tcp_snd_timeout(ksmbd_socket, 0);
+
+	ret = kernel_sock_shutdown(ksmbd_socket, SHUT_RDWR);
+	if (ret)
+		ksmbd_err("Failed to shutdown socket: %d\n", ret);
+	else
+		sock_release(ksmbd_socket);
+}
+
+/**
+ * create_socket - create socket for ksmbd/0
+ *
+ * Return:	Returns a task_struct or ERR_PTR
+ */
+static int create_socket(struct interface *iface)
+{
+	int ret;
+	struct sockaddr_in6 sin6;
+	struct sockaddr_in sin;
+	struct socket *ksmbd_socket;
+	bool ipv4 = false;
+
+	ret = sock_create(PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
+	if (ret) {
+		ksmbd_err("Can't create socket for ipv6, try ipv4: %d\n", ret);
+		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,
+				  &ksmbd_socket);
+		if (ret) {
+			ksmbd_err("Can't create socket for ipv4: %d\n", ret);
+			goto out_error;
+		}
+
+		sin.sin_family = PF_INET;
+		sin.sin_addr.s_addr = htonl(INADDR_ANY);
+		sin.sin_port = htons(server_conf.tcp_port);
+		ipv4 = true;
+	} else {
+		sin6.sin6_family = PF_INET6;
+		sin6.sin6_addr = in6addr_any;
+		sin6.sin6_port = htons(server_conf.tcp_port);
+	}
+
+	ksmbd_tcp_nodelay(ksmbd_socket);
+	ksmbd_tcp_reuseaddr(ksmbd_socket);
+
+	ret = sock_setsockopt(ksmbd_socket,
+			      SOL_SOCKET,
+			      SO_BINDTODEVICE,
+			      KERNEL_SOCKPTR(iface->name),
+			      strlen(iface->name));
+	if (ret != -ENODEV && ret < 0) {
+		ksmbd_err("Failed to set SO_BINDTODEVICE: %d\n", ret);
+		goto out_error;
+	}
+
+	if (ipv4)
+		ret = kernel_bind(ksmbd_socket, (struct sockaddr *)&sin,
+				  sizeof(sin));
+	else
+		ret = kernel_bind(ksmbd_socket, (struct sockaddr *)&sin6,
+				  sizeof(sin6));
+	if (ret) {
+		ksmbd_err("Failed to bind socket: %d\n", ret);
+		goto out_error;
+	}
+
+	ksmbd_socket->sk->sk_rcvtimeo = KSMBD_TCP_RECV_TIMEOUT;
+	ksmbd_socket->sk->sk_sndtimeo = KSMBD_TCP_SEND_TIMEOUT;
+
+	ret = kernel_listen(ksmbd_socket, KSMBD_SOCKET_BACKLOG);
+	if (ret) {
+		ksmbd_err("Port listen() error: %d\n", ret);
+		goto out_error;
+	}
+
+	iface->ksmbd_socket = ksmbd_socket;
+	ret = ksmbd_tcp_run_kthread(iface);
+	if (ret) {
+		ksmbd_err("Can't start ksmbd main kthread: %d\n", ret);
+		goto out_error;
+	}
+	iface->state = IFACE_STATE_CONFIGURED;
+
+	return 0;
+
+out_error:
+	tcp_destroy_socket(ksmbd_socket);
+	iface->ksmbd_socket = NULL;
+	return ret;
+}
+
+static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
+			      void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct interface *iface;
+	int ret, found = 0;
+
+	switch (event) {
+	case NETDEV_UP:
+		if (netdev->priv_flags & IFF_BRIDGE_PORT)
+			return NOTIFY_OK;
+
+		list_for_each_entry(iface, &iface_list, entry) {
+			if (!strcmp(iface->name, netdev->name)) {
+				found = 1;
+				if (iface->state != IFACE_STATE_DOWN)
+					break;
+				ret = create_socket(iface);
+				if (ret)
+					return NOTIFY_OK;
+				break;
+			}
+		}
+		if (!found && bind_additional_ifaces) {
+			iface = alloc_iface(kstrdup(netdev->name, GFP_KERNEL));
+			if (!iface)
+				return NOTIFY_OK;
+			ret = create_socket(iface);
+			if (ret)
+				break;
+		}
+		break;
+	case NETDEV_DOWN:
+		list_for_each_entry(iface, &iface_list, entry) {
+			if (!strcmp(iface->name, netdev->name) &&
+			    iface->state == IFACE_STATE_CONFIGURED) {
+				tcp_stop_kthread(iface->ksmbd_kthread);
+				iface->ksmbd_kthread = NULL;
+				mutex_lock(&iface->sock_release_lock);
+				tcp_destroy_socket(iface->ksmbd_socket);
+				iface->ksmbd_socket = NULL;
+				mutex_unlock(&iface->sock_release_lock);
+
+				iface->state = IFACE_STATE_DOWN;
+				break;
+			}
+		}
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ksmbd_netdev_notifier = {
+	.notifier_call = ksmbd_netdev_event,
+};
+
+int ksmbd_tcp_init(void)
+{
+	register_netdevice_notifier(&ksmbd_netdev_notifier);
+
+	return 0;
+}
+
+static void tcp_stop_kthread(struct task_struct *kthread)
+{
+	int ret;
+
+	if (!kthread)
+		return;
+
+	ret = kthread_stop(kthread);
+	if (ret)
+		ksmbd_err("failed to stop forker thread\n");
+}
+
+void ksmbd_tcp_destroy(void)
+{
+	struct interface *iface, *tmp;
+
+	unregister_netdevice_notifier(&ksmbd_netdev_notifier);
+
+	list_for_each_entry_safe(iface, tmp, &iface_list, entry) {
+		list_del(&iface->entry);
+		kfree(iface->name);
+		kfree(iface);
+	}
+}
+
+static struct interface *alloc_iface(char *ifname)
+{
+	struct interface *iface;
+
+	if (!ifname)
+		return NULL;
+
+	iface = kzalloc(sizeof(struct interface), GFP_KERNEL);
+	if (!iface) {
+		kfree(ifname);
+		return NULL;
+	}
+
+	iface->name = ifname;
+	iface->state = IFACE_STATE_DOWN;
+	list_add(&iface->entry, &iface_list);
+	mutex_init(&iface->sock_release_lock);
+	return iface;
+}
+
+int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
+{
+	int sz = 0;
+
+	if (!ifc_list_sz) {
+		struct net_device *netdev;
+
+		rtnl_lock();
+		for_each_netdev(&init_net, netdev) {
+			if (netdev->priv_flags & IFF_BRIDGE_PORT)
+				continue;
+			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
+				return -ENOMEM;
+		}
+		rtnl_unlock();
+		bind_additional_ifaces = 1;
+		return 0;
+	}
+
+	while (ifc_list_sz > 0) {
+		if (!alloc_iface(kstrdup(ifc_list, GFP_KERNEL)))
+			return -ENOMEM;
+
+		sz = strlen(ifc_list);
+		if (!sz)
+			break;
+
+		ifc_list += sz + 1;
+		ifc_list_sz -= (sz + 1);
+	}
+
+	bind_additional_ifaces = 0;
+
+	return 0;
+}
+
+static struct ksmbd_transport_ops ksmbd_tcp_transport_ops = {
+	.read		= ksmbd_tcp_read,
+	.writev		= ksmbd_tcp_writev,
+	.disconnect	= ksmbd_tcp_disconnect,
+};
diff --git a/fs/cifsd/transport_tcp.h b/fs/cifsd/transport_tcp.h
new file mode 100644
index 000000000000..e338bebe322f
--- /dev/null
+++ b/fs/cifsd/transport_tcp.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_TRANSPORT_TCP_H__
+#define __KSMBD_TRANSPORT_TCP_H__
+
+int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
+int ksmbd_tcp_init(void);
+void ksmbd_tcp_destroy(void);
+
+#endif /* __KSMBD_TRANSPORT_TCP_H__ */
-- 
2.17.1

