Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4CB3F43A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 05:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhHWDJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 23:09:39 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:35000 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhHWDJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:09:30 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210823030847epoutp04f7ba5c1372d757a1ec4a880d29df5c70~d0LedPXOV0681106811epoutp04M
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 03:08:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210823030847epoutp04f7ba5c1372d757a1ec4a880d29df5c70~d0LedPXOV0681106811epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629688127;
        bh=t02meZS9/Pt4URHcUtPH7M0SPZTbzuWLY7/dF8Sfda4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bR0KioSJ2Tv6eHYCasUIaTeeuzHRyddh1/QzN/DJ6CjouW59+pwKFmNRPowDn5KVh
         9pSZX2+Bly/mo7CRGUWAH7OXecrFupciktuLdLGMDXWR5tsxz/9A1rGFO/fBzPgAwg
         v4G9BruedL+F73wStCNNohXNuYfSRQdJVvqKinEY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210823030846epcas1p41f62646d61d9ef9042ac92e9fa10e867~d0Ld2VPq_3021430214epcas1p4x;
        Mon, 23 Aug 2021 03:08:46 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.249]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GtHJD5mybz4x9QB; Mon, 23 Aug
        2021 03:08:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.AF.09910.C3113216; Mon, 23 Aug 2021 12:08:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210823030844epcas1p2a9dc2c02d32df86e9eb3c2af975c7d81~d0Lbr9lSH1985819858epcas1p2Y;
        Mon, 23 Aug 2021 03:08:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210823030844epsmtrp2dc636425ade8ab12dca1302c36ef5b58~d0LbqybsX0379803798epsmtrp2K;
        Mon, 23 Aug 2021 03:08:44 +0000 (GMT)
X-AuditID: b6c32a35-c45ff700000026b6-c2-6123113cacd3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.25.09091.B3113216; Mon, 23 Aug 2021 12:08:44 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210823030843epsmtip223dfb6b43d32d6000662bff41c85e415~d0LbUtKcT0638306383epsmtip2q;
        Mon, 23 Aug 2021 03:08:43 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, willy@infradead.org, hch@infradead.org,
        senozhatsky@chromium.org, christian@brauner.io,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com, hch@lst.de,
        dan.carpenter@oracle.com, metze@samba.org, smfrench@gmail.com,
        hyc.lee@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v8 04/13] ksmbd: add ipc transport layer
Date:   Mon, 23 Aug 2021 11:58:07 +0900
Message-Id: <20210823025816.7496-5-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823025816.7496-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmrq6NoHKiwbWTahbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBGZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwK9ArTswtLs1L18tLLbEyNDAwMgUqTMjO6Jj5
        hbFgzinGivfd8g2MLSsZuxg5OSQETCSam0+ydzFycQgJ7GCUWPK3hQkkISTwCch5nwKR+MYo
        saBrGTNMx813MxghEnsZJT5PPAzlAHVsv9oD1M7BwSagLfFniyhIg4hArMSNHa+ZQWqYBWYz
        Szzfe4oFJCEsYCExeecaMJtFQFXi9v99YDfxClhLbL7zlwlim7zE6g0HwDZzCthIfJz0CmyZ
        hMANDokfb/qhnnCR6J9ziA3CFpZ4dXwLO4QtJfH53V6oeLnEiZO/oIbWSGyYt48d5FAJAWOJ
        nhclICazgKbE+l36EBWKEjt/zwWbzizAJ/Huaw8rRDWvREebEESJqkTfpcNQA6Uluto/QC31
        kGje+xUaJP2MEivO/2KZwCg3C2HDAkbGVYxiqQXFuempxYYFhvAYS87P3cQITsZapjsYJ779
        oHeIkYmD8RCjBAezkgjvXyblRCHelMTKqtSi/Pii0pzU4kOMpsCwm8gsJZqcD8wHeSXxhiaW
        BiZmRiYWxpbGZkrivIyvZBKFBNITS1KzU1MLUotg+pg4OKUamA5PUHRoO6Ue/lhzyi12x+M8
        XY84TD54ues65n3NefPpoYTxvuw9EcJLJr++LCHZ9CFxu+nkpT9KtJmXlFtXX5q09KmIfUfN
        Z4GFTxWPzNi08fKG70/+uDzSf/eVQV98plnriem/VLvF31x652zNF/Dt4FKNiz+t9rh4SUur
        Re9QOVfK9Uz1wfdZise0jrLUbnDm1onzD8lTqlc8ueeQhbzd6ZrEdtPkpwKTpj/RWHiqYa2B
        ON/+i5JrX/5a/dCe41OfveIai4k1q2vNZlS/c52+s8k0ekZ31tK7b/sfMr2eJrCwIZTnQtnS
        qzqPtT6siJYpiJvlnGYg6v99uqrpvH1XhOckCJhMrJijskRwToESS3FGoqEWc1FxIgD3t7OD
        TwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvK6NoHKiwYf7jBbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBGcdmk
        pOZklqUW6dslcGV0zPzCWDDnFGPF+275BsaWlYxdjJwcEgImEjffzQCyuTiEBHYzSrTMOsMC
        kZCWOHbiDHMXIweQLSxx+HAxSFhI4AOjRGdHCEiYTUBb4s8WUZCwiEC8xM2G2ywgY5gF1jNL
        nH3dBDZGWMBCYvLONWA2i4CqxO3/+8D28gpYS2y+85cJYpW8xOoNB5hBbE4BG4mPk14xQuyy
        lvizZy3TBEa+BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNGS3MH4/ZVH/QO
        MTJxMB5ilOBgVhLh/cuknCjEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC
        1CKYLBMHp1QDU+Xt8EWONjdfH9ar2egsvKa77knq/Ul7n9cn3wz2iXnf4jgtw2DXwXW/C/e/
        kFltr5DW9PSg70T79aobuu8xfS9l+fI+cI/IpfNeq/bLFDw1lchbGMrvuUT/AZOxyM28KbOX
        LXFf+jpWTDbgjJr/rMK8x6dnvXL+mrPjYeQ8+RqFtezM927d156wO9PcW/qs1jNdzqbjQUf+
        b+K5veI+/60dJkacTfr7UnacD1VcdbiEMVjZb4mEc8ziCJ3UCpbAacJagn7LSuxu2C3ulztz
        +dWWs7zbDj/prz3t/CExJGNGwcT+Xib+S1rfZ6mHbxWY5nA3VFSl71XW17nBa3QnsMhtO951
        MoRJe2Z2EatqrxJLcUaioRZzUXEiAHHJlboJAwAA
X-CMS-MailID: 20210823030844epcas1p2a9dc2c02d32df86e9eb3c2af975c7d81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210823030844epcas1p2a9dc2c02d32df86e9eb3c2af975c7d81
References: <20210823025816.7496-1-namjae.jeon@samsung.com>
        <CGME20210823030844epcas1p2a9dc2c02d32df86e9eb3c2af975c7d81@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds ipc transport layer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_ipc.c | 874 +++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/transport_ipc.h |  47 +++
 2 files changed, 921 insertions(+)
 create mode 100644 fs/ksmbd/transport_ipc.c
 create mode 100644 fs/ksmbd/transport_ipc.h

diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
new file mode 100644
index 000000000000..44aea33a67fa
--- /dev/null
+++ b/fs/ksmbd/transport_ipc.c
@@ -0,0 +1,874 @@
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
+static bool ksmbd_ipc_validate_version(struct genl_info *m)
+{
+	if (m->genlhdr->version != KSMBD_GENL_VERSION) {
+		pr_err("%s. ksmbd: %d, kernel module: %d. %s.\n",
+		       "Daemon and kernel module version mismatch",
+		       m->genlhdr->version,
+		       KSMBD_GENL_VERSION,
+		       "User-space ksmbd should terminate");
+		return false;
+	}
+	return true;
+}
+
+struct ksmbd_ipc_msg {
+	unsigned int		type;
+	unsigned int		sz;
+	unsigned char		payload[];
+};
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
+	unsigned int handle = *(unsigned int *)payload;
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
+			pr_err("Waiting for IPC type %d, got %d. Ignore.\n",
+			       entry->type + 1, type);
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
+		pr_err("Server configuration error: %s %s %s\n",
+		       req->netbios_name, req->server_string,
+		       req->work_group);
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
+		pr_err("Server reset is in progress, can't start daemon\n");
+		return -EINVAL;
+	}
+
+	if (ksmbd_tools_pid) {
+		if (ksmbd_ipc_heartbeat_request() == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		pr_err("Reconnect to a new user space daemon\n");
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
+	pr_err("Unknown IPC event: %d, ignore.\n", info->genlhdr->cmd);
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
+	ret = nla_put(skb, msg->type, msg->sz, msg->payload);
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
+	req = (struct ksmbd_login_request *)msg->payload;
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
+	req = (struct ksmbd_spnego_authen_request *)msg->payload;
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
+	req = (struct ksmbd_tree_connect_request *)msg->payload;
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
+	req = (struct ksmbd_tree_disconnect_request *)msg->payload;
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
+	req = (struct ksmbd_logout_request *)msg->payload;
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
+	req = (struct ksmbd_share_config_request *)msg->payload;
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
+	req = (struct ksmbd_rpc_command *)msg->payload;
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
+	req = (struct ksmbd_rpc_command *)msg->payload;
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
+	req = (struct ksmbd_rpc_command *)msg->payload;
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
+	req = (struct ksmbd_rpc_command *)msg->payload;
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
+	req = (struct ksmbd_rpc_command *)msg->payload;
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
+	req = (struct ksmbd_rpc_command *)msg->payload;
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
+	pr_err("No IPC daemon response for %lus\n", delta / HZ);
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
+		pr_err("Failed to register KSMBD netlink interface %d\n", ret);
+		cancel_delayed_work_sync(&ipc_timer_work);
+	}
+
+	return ret;
+}
diff --git a/fs/ksmbd/transport_ipc.h b/fs/ksmbd/transport_ipc.h
new file mode 100644
index 000000000000..9eacc895ffdb
--- /dev/null
+++ b/fs/ksmbd/transport_ipc.h
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
-- 
2.17.1

