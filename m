Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA55A3CAFD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 02:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhGPAGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 20:06:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11421 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhGPAGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:06:54 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210716000357epoutp0270ea10c2353a90f99ff38d09d559e8c3~SHJP2fcGJ1074510745epoutp020
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 00:03:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210716000357epoutp0270ea10c2353a90f99ff38d09d559e8c3~SHJP2fcGJ1074510745epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626393837;
        bh=YFLSrUXx6/13cRr5mZe3XXsWwcu7cmjgDv+ySjZOHYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L28VQHRmLpPcsoO8TjBBkBPVdnd0ncs8SqLVg0/23F5w8OqoVXwTV3aMamaZod64o
         ebTEHIopJegI3k3nLAI7yK+nZorc/Q4JfUPoizaRBWdNp81phfjAKv4ntED2LgUJU7
         cnnnnnbwp0h2a1NJv/9SL+bheAGD+PmLTmXWq61U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210716000353epcas1p1c4095b2fc9782121daabbfc0d4e19037~SHJMudNzZ0646506465epcas1p1d;
        Fri, 16 Jul 2021 00:03:53 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GQs0S5nwsz4x9Q4; Fri, 16 Jul
        2021 00:03:52 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.0E.13454.8ECC0F06; Fri, 16 Jul 2021 09:03:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210716000349epcas1p1062a5e54cb3adda3c3ca23b933acffee~SHJIf1BxJ1420814208epcas1p1G;
        Fri, 16 Jul 2021 00:03:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210716000349epsmtrp202c09f12f6416c0827e4bed5ed4b9ec1~SHJIevq_g1353413534epsmtrp2n;
        Fri, 16 Jul 2021 00:03:49 +0000 (GMT)
X-AuditID: b6c32a39-185ff7000002348e-c8-60f0cce8be6b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.8E.08289.5ECC0F06; Fri, 16 Jul 2021 09:03:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210716000349epsmtip2310e355effe4d4fbbd73292cd8dde63e~SHJINjype1664016640epsmtip2R;
        Fri, 16 Jul 2021 00:03:49 +0000 (GMT)
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
Subject: [PATCH v6 03/13] ksmbd: add tcp transport layer
Date:   Fri, 16 Jul 2021 08:53:46 +0900
Message-Id: <20210715235356.3191-4-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715235356.3191-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxbVRT3vte+lrnqW4Ht2iWDPTInHdCW0nJRWDTi9oxO2QbRmCzlhb4U
        tn7ZFgRGYjGZjGby4UxwyDdxzo7pRhsGxS5L2cRO5gQ3BjicOhc6kO8McAyxpUX975xzfx/n
        nHv4uNBJiPh5egtr0jNaitjA6eiJlcT7+maypV/d3ol6J1Z4qHQqBk38XcNB31e1YOjLs1cx
        NHh3mod8qy4c/bW6CNA3bi8H/eSqI9BSzfvoo4o5Ljp2U4y6L7QQ6E9fD4FGqhsJdGOll4uW
        l+qIF4X0Sv0sTn9m7efQXbWjPNpxRkx3N81jdPewlaCPda7w6Nn7Ixy6wmkHtLP1N4yeb99G
        t/8xiWVsfEebmssyatYUzepzDOo8vSaNeu2g6mWVQimVxctSUDIVrWd0bBqV/npG/J48rX84
        KrqA0eb7SxmM2UxJdqeaDPkWNjrXYLakUaxRrTXKpMYEM6Mz5+s1CTkG3fMyqTRR4Udma3MX
        P20BxukyrNA19wXXCn6+BWwgjA/JJGh1N3BsYANfSHYC6Dk3jgeTOQCX79h4wWQeQMfJR7x1
        Sn1VfwjlAtA+u0r8S5mtuOYX5vMJchd87IwMECLIQ3Coc2KNgJM2HN6/24cFHsJJBPuvfYAH
        8BxyBywdjAqUBeQL8NSqkwiaRcGz5y/jgTiMTIX3vAsgoAPJPj68eHJ9iHS44B4PEcLheK8z
        1KkIzk+5Q/X34HfeR1gwLoHnGy7xAr6QlMMTPksgxMlY+LVLEkRsh13L9WvqOPkUnHp4ghtE
        C+DxD4VByA5YMdATEtwKbWUzIVMa/vBrKRbcSCWAXeN1vCqwrfY/hyYA7GAzazTrNKxZZlT8
        /8vawdr5ilM6Qc3kTIIHYHzgAZCPUxGCzxMns4UCNVNUzJoMKlO+ljV7gMK/umpcFJlj8N+/
        3qKSKRLlcjlKUiYrFXJqi6CL8GQLSQ1jYY+wrJE1rfMwfpjIim22Fgkv875dOB5XoMW6BZ6y
        q8qKB0O7i680cG8lL0mymsN3WtMLUpjDquZGYXHH9J5DWe/CgzFjo75fFpNiNo1FOmbPJO6/
        OZrhVb95YCv3SdJwPW6XvXxpWvpM9Wn5S5nDWXubk7od9OFGXe1eVjQ1esTzYxYvcQDbpLxd
        IxCfEpQs0MrFto2VGR7D0ajlx4UXZU2Soaai59xu5fBpLeuIGyE7WgdUT8ztXzh3ry9Tpind
        4sppiiho++RBQtaFfWoHSr4jLBSUDzSXvDXmzS/fF9V//eGiZyr2RiZ14I2jV55tWfpYLKkE
        7kuD9t/pp+0iHfCFg1dsrdSrura3t1Mccy4jE+MmM/MPlr+nGkcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO7TMx8SDLbO4bM4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFFcNimpOZllqUX6dglc
        Gd9nLGIseN/OVLHr03LWBsbbVxm7GDk5JARMJOZOuMjcxcjFISSwg1Hi5c0eqIS0xLETZ4AS
        HEC2sMThw8UQNR8YJXau+gcWZxPQlvizRRSkXEQgXuJmw20WkBpmgTnMEjs3HgGbIyxgIXHx
        VBNYPYuAqkTjNXmQMK+AtcTM/1vYIFbJS6zecIAZxOYUsJF4fPIbWKsQUM36NRtYJjDyLWBk
        WMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwjWlo7GPes+qB3iJGJg/EQowQHs5II
        71KjtwlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1ME2J
        tUrYpyNRVDjvxOmNd5qibE6u/md0N+o1/6Ym99urO6wdc35eeTTf0/lzwssJ/+ZwP0/gKO5b
        rdo5M6pnX/qRjtMZ5qtenN+wrjRGRfM2bxAn69+CRQ2b972Zlhpp/zr3+h0764rLS7pMsreI
        OHz5+uBIksmsspbXfQ8553yyna927X5P1wdOn4WTlVrMXiUcbN9S26Nq67eFcc3ELbJ/GI02
        M3k9+mPWUa1xX4P5WEPxpUu+zEeO9HcXHomeuq9mygxx7jd7nPLED2z5tu+C2JHkDzlnZk8Q
        qL82w7akdp3bXa+ir/0z63w2h3/aPu0He+3e9OUzzDZkPK22uhWoNCvnglL/UybHeZ0MJS5K
        LMUZiYZazEXFiQCpyCloAAMAAA==
X-CMS-MailID: 20210716000349epcas1p1062a5e54cb3adda3c3ca23b933acffee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210716000349epcas1p1062a5e54cb3adda3c3ca23b933acffee
References: <20210715235356.3191-1-namjae.jeon@samsung.com>
        <CGME20210716000349epcas1p1062a5e54cb3adda3c3ca23b933acffee@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds tcp transport layer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c    | 413 ++++++++++++++++++++++++++
 fs/ksmbd/connection.h    | 211 +++++++++++++
 fs/ksmbd/transport_tcp.c | 619 +++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/transport_tcp.h |  13 +
 4 files changed, 1256 insertions(+)
 create mode 100644 fs/ksmbd/connection.c
 create mode 100644 fs/ksmbd/connection.h
 create mode 100644 fs/ksmbd/transport_tcp.c
 create mode 100644 fs/ksmbd/transport_tcp.h

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
new file mode 100644
index 000000000000..d7ee0bfb5838
--- /dev/null
+++ b/fs/ksmbd/connection.c
@@ -0,0 +1,413 @@
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
+LIST_HEAD(conn_list);
+DEFINE_RWLOCK(conn_list_lock);
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
+	spin_lock_init(&conn->llist_lock);
+	INIT_LIST_HEAD(&conn->lock_list);
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
+	if (!work->multiRsp)
+		atomic_dec(&conn->req_running);
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
+		pr_err("NULL response header\n");
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
+		pr_err("Failed to send message: %d\n", sent);
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
+	 * is bigger than deadtime user configured and opening file count is
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
+			pr_err("sock_read failed: %d\n", size);
+			break;
+		}
+
+		if (size != pdu_size) {
+			pr_err("PDU error. Read: %d, Expected: %d\n",
+			       size, pdu_size);
+			continue;
+		}
+
+		if (!default_conn_ops.process_fn) {
+			pr_err("No connection request callback\n");
+			break;
+		}
+
+		if (default_conn_ops.process_fn(conn)) {
+			pr_err("Cannot handle request\n");
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
+		pr_err("Failed to init RDMA subsystem: %d\n", ret);
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
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
new file mode 100644
index 000000000000..487c2024b0d5
--- /dev/null
+++ b/fs/ksmbd/connection.h
@@ -0,0 +1,211 @@
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
+	spinlock_t			llist_lock;
+	struct list_head		lock_list;
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
+	bool				binding;
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
+extern struct list_head conn_list;
+extern rwlock_t conn_list_lock;
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
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
new file mode 100644
index 000000000000..56ec11ff5a9f
--- /dev/null
+++ b/fs/ksmbd/transport_tcp.c
@@ -0,0 +1,619 @@
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
+		pr_err("client ip resolution failed\n");
+		rc = -EINVAL;
+		goto out_error;
+	}
+
+	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
+					      KSMBD_TRANS(t)->conn,
+					      "ksmbd:%u",
+					      ksmbd_tcp_get_port(csin));
+	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
+		pr_err("cannot start conn thread\n");
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
+		pr_err("Failed to shutdown socket: %d\n", ret);
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
+		pr_err("Can't create socket for ipv6, try ipv4: %d\n", ret);
+		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,
+				  &ksmbd_socket);
+		if (ret) {
+			pr_err("Can't create socket for ipv4: %d\n", ret);
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
+		pr_err("Failed to set SO_BINDTODEVICE: %d\n", ret);
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
+		pr_err("Failed to bind socket: %d\n", ret);
+		goto out_error;
+	}
+
+	ksmbd_socket->sk->sk_rcvtimeo = KSMBD_TCP_RECV_TIMEOUT;
+	ksmbd_socket->sk->sk_sndtimeo = KSMBD_TCP_SEND_TIMEOUT;
+
+	ret = kernel_listen(ksmbd_socket, KSMBD_SOCKET_BACKLOG);
+	if (ret) {
+		pr_err("Port listen() error: %d\n", ret);
+		goto out_error;
+	}
+
+	iface->ksmbd_socket = ksmbd_socket;
+	ret = ksmbd_tcp_run_kthread(iface);
+	if (ret) {
+		pr_err("Can't start ksmbd main kthread: %d\n", ret);
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
+		pr_err("failed to stop forker thread\n");
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
diff --git a/fs/ksmbd/transport_tcp.h b/fs/ksmbd/transport_tcp.h
new file mode 100644
index 000000000000..e338bebe322f
--- /dev/null
+++ b/fs/ksmbd/transport_tcp.h
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

