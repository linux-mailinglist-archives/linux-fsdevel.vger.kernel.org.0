Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359403BB56D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 05:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhGEDUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 23:20:20 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21559 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhGEDUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:20:07 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210705031729epoutp03d8e599261dcddad2ef370fdac0c878a1~OxsGD0Dw43232632326epoutp038
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jul 2021 03:17:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210705031729epoutp03d8e599261dcddad2ef370fdac0c878a1~OxsGD0Dw43232632326epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625455050;
        bh=Qix9xX6ewQgl83Lzo7sFZn3/i5jDl0ssf/yNcBj1sXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q59oTKQkB8UBy9VnSor4Ap+xCFLMOvIE8mMOp4NKDk1tzrpcKhBpDSbbu5HJueLVS
         Ulklb+wp6W0R0GfloUeXPZFosM/6P2Zzm6+7y5nrbriUZMLljh5nhlmKsTaWs2f6QP
         WA1z6aAoiKknuHCm9aSlPF1IBCRoJnMwmaUbZLfM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210705031729epcas1p15385d0805cdcfb213b679f66ec411214~OxsFP-tEi2110321103epcas1p1X;
        Mon,  5 Jul 2021 03:17:29 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GJ9pw0sXlz4x9Q0; Mon,  5 Jul
        2021 03:17:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.4E.10119.7C972E06; Mon,  5 Jul 2021 12:17:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210705031727epcas1p104689b6fb5f53812333fc4048b57bb55~OxsDkvrF71197211972epcas1p1q;
        Mon,  5 Jul 2021 03:17:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705031727epsmtrp2dba6455fc1c0044563fa7b1403091699~OxsDj0BGv1726817268epsmtrp28;
        Mon,  5 Jul 2021 03:17:27 +0000 (GMT)
X-AuditID: b6c32a38-965ff70000002787-fc-60e279c7aef1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.EC.08289.7C972E06; Mon,  5 Jul 2021 12:17:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210705031726epsmtip2655a7f3c68bf0eccc09d56a7ce63bf53~OxsDMRY7Q2507925079epsmtip2t;
        Mon,  5 Jul 2021 03:17:26 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        willy@infradead.org, hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v5 05/13] ksmbd: add rdma transport layer
Date:   Mon,  5 Jul 2021 12:07:21 +0900
Message-Id: <20210705030729.10292-6-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705030729.10292-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzOubfcFrOyK6A7q5tjdxoGS2lLeRw2cE4Nuz4WcY9kMXFwpTe0
        s6+0xYGaAFvEWaGUmtCpFI1MNyAGBh0DKptQZ+0cUZ4BNlEGDJQVBULkYXEtxWz/fef3+77v
        9zjn8PDQVkLAU6gNrE7NKCliDafRGSUWunL/yhD/WJGACjy3OMg16eWigqk30OSylYNumS9i
        qKrmVwz13XvERRPPWnC08OwJQFdb3RzU3VJOoHlrHio2zQSh4z3RyPHDRQL9M+Ek0GDpeQLd
        9rqC0NJ8ObE1jPbapnH6XH4nh24+e5dLN3wfTTsuzGK0YyCfoI83ebn09NgghzbZqwFtrxzG
        6Fp7L4eerd9I1496sDT+fmWynGVkrC6CVWdqZAp1Vgq1+6P07enxCWKJUJKEEqkINaNiU6gd
        e9KEqQqlb0wq4jCjzPaF0hi9nhJtSdZpsg1shFyjN6RQrFam1ErE2hg9o9Jnq7NiMjWqtyVi
        cWy8j5mhlJ+v6APaulE853T5N3g++MWIG0EwD5Jx8NHsE8yPQ8kmAK1tnxvBGh+eAdAy3MkN
        HGYBrHbXBT1XDNfeAYFEC4Bjo048IPdJFqy5RsDjEeRb8Kl9nT8cTh6A/U2TuJ+Pk+dwONhs
        XzEKI5NgW9sg14855GbYWFkG/JhPJsPxQg83UOw1WFN3bcU/mEyBrcbeIL8RJPt50PKVmQiQ
        dsDKU3+uzhMGH7rsq2IBnJ1qXeV8AW+6F7EAPgbrKn7m+huFpBQWTRj8ECejYG2LKMB4HTYv
        2VbawckQODVXFBRg8+HXhaEBymZo6nKuGm6AxhOPV4vS8Ip9AAusxwxgp8MCzGDj2f8qXACg
        GqxntXpVFquXaOP+f2P1YOUdR6MmYPM8jmkHGA+0A8jDqXD+JxVDGaF8GZN7hNVp0nXZSlbf
        DuJ9uyvFBesyNb6PoDakS+JjpVIpiktITIiXUi/xm4n2jFAyizGwh1hWy+qe6zBesCAfs01f
        X942k2LOeSFZclmYPXFftVWUVt5TV0RODA388em31rULjRsOxpqWYP7JDkfhfUWeRWdJ3XKP
        SjhjOfq+bJto59OOmzWvnOm+filxZG+Z68rYu/veY36SRPHvuj47tnf6t2bB+uXLnAclcx1x
        xak5N05HvpxTsng43N77Zm6ZtNGGD4WIbshNUQWygyEvnvKKuhdluoe790RqkqL74FDVO79f
        zVjbdbJo087x+d6kS0BjPzRyILIHfSz8UrGcGvxBsXu8qmGsOKt0/3cjuJDYBbhFf+/z9hw1
        GeauHUm83Z/nfpXtkgTXK7aXhjSFONsKakDDlPZBiefDOyfyhgTtDoqjlzOSaFynZ/4FR/C1
        jVAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvO7xykcJBpPes1s0vj3NYnH89V8g
        652yxet/01ksTk9YxGSxcvVRJotr94EqXvzfxWzx8/93Ros9e0+yWFzeNYfN4sf0eovevk+s
        Fq1XtCx2b1zEZvHmxWE2i1sT57NZnP97nNXi9485bA7CHn/nfmT2mN1wkcVj56y77B6bV2h5
        7F7wmclj980GNo/WHX/ZPT4+vcXi0bdlFaPHlsUPmTzWb7nK4vF5k5zHpidvmQJ4o7hsUlJz
        MstSi/TtErgy5s+7xliw4QlzxeQ5M5gbGPd3MXcxcnJICJhIPFx/gbGLkYtDSGAHo8T1o5Oh
        EtISx06cAbI5gGxhicOHiyFqPjBKzLw4HSzOJqAt8WeLKEi5iEC8xM2G2ywgNcwC65kl3kz9
        xQKSEBawlDh48BY7iM0ioCqxbfE0RhCbV8BG4nnbW3aIXfISqzccANvLKWArsbfrKiuILQRU
        0/3zB+sERr4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCI0dLawfjnlUf9A4x
        MnEwHmKU4GBWEuENnXcvQYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWp
        RTBZJg5OqQYmp81hXXoTDeOMVn/Va9FWs+xYIXTA2art9dnE1cuyPS99ariqUbWFmfPY0z/l
        bto6xxd4XdTv0fz7qW5KuUTWPYvOQ1tlynfsn9rNNCFBVbJJanLHcm9jt9tz44x/RXPsn7zo
        1srr+28UcrGKbHvG9yeC3er64wplbW235RGCfeW7+b/VuLNkbDU6fVvsZfrxLMn0qseyDyIv
        3/60xfpJ5Wa2edeXvg/K3/d90/Ggnyst9xcIf9VdY//k8Srb8s67dzdK/Q92OxVn+YE/2EHp
        s4rziy09j972bV9waFKHa5HOyWrGF5WbLIN2TkthrLzNVn7u51XPyHy3E9f05I1qpqT+VGqu
        EngVzrafT+ahEktxRqKhFnNRcSIAb4HIPgsDAAA=
X-CMS-MailID: 20210705031727epcas1p104689b6fb5f53812333fc4048b57bb55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705031727epcas1p104689b6fb5f53812333fc4048b57bb55
References: <20210705030729.10292-1-namjae.jeon@samsung.com>
        <CGME20210705031727epcas1p104689b6fb5f53812333fc4048b57bb55@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds rdma transport layer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 2045 +++++++++++++++++++++++++++++++++++++
 fs/ksmbd/transport_rdma.h |   61 ++
 2 files changed, 2106 insertions(+)
 create mode 100644 fs/ksmbd/transport_rdma.c
 create mode 100644 fs/ksmbd/transport_rdma.h

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
new file mode 100644
index 000000000000..171fb3dd018a
--- /dev/null
+++ b/fs/ksmbd/transport_rdma.c
@@ -0,0 +1,2045 @@
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
+static inline int get_buf_page_count(void *buf, int size)
+{
+	return DIV_ROUND_UP((uintptr_t)buf + size, PAGE_SIZE) -
+		(uintptr_t)buf / PAGE_SIZE;
+}
+
+static void smb_direct_destroy_pools(struct smb_direct_transport *transport);
+static void smb_direct_post_recv_credits(struct work_struct *work);
+static int smb_direct_post_send_data(struct smb_direct_transport *t,
+				     struct smb_direct_send_ctx *send_ctx,
+				     struct kvec *iov, int niov,
+				     int remaining_data_length);
+
+static inline struct smb_direct_transport *
+smb_trans_direct_transfort(struct ksmbd_transport *t)
+{
+	return container_of(t, struct smb_direct_transport, transport);
+}
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
+			pr_err("Recv error. status='%s (%d)' opcode=%d\n",
+			       ib_wc_status_msg(wc->status), wc->status,
+			       wc->opcode);
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
+		pr_err("Can't post recv: %d\n", ret);
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
+	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
+
+again:
+	if (st->status != SMB_DIRECT_CS_CONNECTED) {
+		pr_err("disconnected\n");
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
+				pr_err("Can't post recv: %d\n", ret);
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
+		pr_err("Send error. status='%s (%d)', opcode=%d\n",
+		       ib_wc_status_msg(wc->status), wc->status,
+		       wc->opcode);
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
+		pr_err("failed to post send: %d\n", ret);
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
+	if (nentries < get_buf_page_count(buf, size))
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
+			pr_err("failed to map buffer\n");
+			ret = -ENOMEM;
+			goto err;
+		} else if (sg_cnt + msg->num_sge > SMB_DIRECT_MAX_SEND_SGES - 1) {
+			pr_err("buffer not fitted into sges\n");
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
+	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
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
+		pr_err("read/write error. opcode = %d, status = %s(%d)\n",
+		       wc->opcode, ib_wc_status_msg(wc->status), wc->status);
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
+				     get_buf_page_count(buf, buf_len),
+				     msg->sg_list, SG_CHUNK_SIZE);
+	if (ret) {
+		atomic_inc(&t->rw_avail_ops);
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	ret = get_sg_list(buf, buf_len, msg->sgt.sgl, msg->sgt.orig_nents);
+	if (ret <= 0) {
+		pr_err("failed to get pages\n");
+		goto err;
+	}
+
+	ret = rdma_rw_ctx_init(&msg->rw_ctx, t->qp, t->qp->port,
+			       msg->sg_list, get_buf_page_count(buf, buf_len),
+			       0, remote_offset, remote_key,
+			       is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	if (ret < 0) {
+		pr_err("failed to init rdma_rw_ctx: %d\n", ret);
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
+		pr_err("failed to post send wr: %d\n", ret);
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
+	return smb_direct_rdma_xmit(smb_trans_direct_transfort(t), buf, buflen,
+				    remote_key, remote_offset,
+				    remote_len, false);
+}
+
+static int smb_direct_rdma_read(struct ksmbd_transport *t, void *buf,
+				unsigned int buflen, u32 remote_key,
+				u64 remote_offset, u32 remote_len)
+{
+	return smb_direct_rdma_xmit(smb_trans_direct_transfort(t), buf, buflen,
+				    remote_key, remote_offset,
+				    remote_len, true);
+}
+
+static void smb_direct_disconnect(struct ksmbd_transport *t)
+{
+	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
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
+		pr_err("Unexpected RDMA CM event. cm_id=%p, event=%s (%d)\n",
+		       cm_id, rdma_event_msg(event->event),
+		       event->event);
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
+		pr_err("error at rdma_accept: %d\n", ret);
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
+		pr_err("Can't post recv: %d\n", ret);
+		goto out;
+	}
+
+	t->negotiation_requested = false;
+	ret = smb_direct_accept_client(t);
+	if (ret) {
+		pr_err("Can't accept client\n");
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
+		pr_err("max_send_size %d is too large\n", t->max_send_size);
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
+		pr_err("consider lowering send_credit_target = %d, or max_outstanding_rw_ops = %d\n",
+		       smb_direct_send_credit_target,
+		       smb_direct_max_outstanding_rw_ops);
+		pr_err("Possible CQE overrun, device reporting max_cqe %d max_qp_wr %d\n",
+		       device->attrs.max_cqe, device->attrs.max_qp_wr);
+		return -EINVAL;
+	}
+
+	if (smb_direct_receive_credit_max > device->attrs.max_cqe ||
+	    smb_direct_receive_credit_max > device->attrs.max_qp_wr) {
+		pr_err("consider lowering receive_credit_max = %d\n",
+		       smb_direct_receive_credit_max);
+		pr_err("Possible CQE overrun, device reporting max_cpe %d max_qp_wr %d\n",
+		       device->attrs.max_cqe, device->attrs.max_qp_wr);
+		return -EINVAL;
+	}
+
+	if (device->attrs.max_send_sge < SMB_DIRECT_MAX_SEND_SGES) {
+		pr_err("warning: device max_send_sge = %d too small\n",
+		       device->attrs.max_send_sge);
+		return -EINVAL;
+	}
+	if (device->attrs.max_recv_sge < SMB_DIRECT_MAX_RECV_SGES) {
+		pr_err("warning: device max_recv_sge = %d too small\n",
+		       device->attrs.max_recv_sge);
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
+		pr_err("Can't create RDMA PD\n");
+		ret = PTR_ERR(t->pd);
+		t->pd = NULL;
+		return ret;
+	}
+
+	t->send_cq = ib_alloc_cq(t->cm_id->device, t,
+				 t->send_credit_target, 0, IB_POLL_WORKQUEUE);
+	if (IS_ERR(t->send_cq)) {
+		pr_err("Can't create RDMA send CQ\n");
+		ret = PTR_ERR(t->send_cq);
+		t->send_cq = NULL;
+		goto err;
+	}
+
+	t->recv_cq = ib_alloc_cq(t->cm_id->device, t,
+				 cap->max_send_wr + cap->max_rdma_ctxs,
+				 0, IB_POLL_WORKQUEUE);
+	if (IS_ERR(t->recv_cq)) {
+		pr_err("Can't create RDMA recv CQ\n");
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
+		pr_err("Can't create RDMA QP: %d\n", ret);
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
+	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
+	int ret;
+	struct ib_qp_cap qp_cap;
+
+	ret = smb_direct_init_params(st, &qp_cap);
+	if (ret) {
+		pr_err("Can't configure RDMA parameters\n");
+		return ret;
+	}
+
+	ret = smb_direct_create_pools(st);
+	if (ret) {
+		pr_err("Can't init RDMA pool: %d\n", ret);
+		return ret;
+	}
+
+	ret = smb_direct_create_qpair(st, &qp_cap);
+	if (ret) {
+		pr_err("Can't accept RDMA client: %d\n", ret);
+		return ret;
+	}
+
+	ret = smb_direct_negotiate(st);
+	if (ret) {
+		pr_err("Can't negotiate: %d\n", ret);
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
+		pr_err("Can't start thread\n");
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
+			pr_err("Can't create transport: %d\n", ret);
+			return ret;
+		}
+
+		ksmbd_debug(RDMA, "Received connection request. cm_id=%p\n",
+			    cm_id);
+		break;
+	}
+	default:
+		pr_err("Unexpected listen event. cm_id=%p, event=%s (%d)\n",
+		       cm_id, rdma_event_msg(event->event), event->event);
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
+		pr_err("Can't create cm id: %ld\n", PTR_ERR(cm_id));
+		return PTR_ERR(cm_id);
+	}
+
+	ret = rdma_bind_addr(cm_id, (struct sockaddr *)&sin);
+	if (ret) {
+		pr_err("Can't bind: %d\n", ret);
+		goto err;
+	}
+
+	smb_direct_listener.cm_id = cm_id;
+
+	ret = rdma_listen(cm_id, 10);
+	if (ret) {
+		pr_err("Can't listen: %d\n", ret);
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
+		pr_err("Can't listen: %d\n", ret);
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
diff --git a/fs/ksmbd/transport_rdma.h b/fs/ksmbd/transport_rdma.h
new file mode 100644
index 000000000000..da60fcec3ede
--- /dev/null
+++ b/fs/ksmbd/transport_rdma.h
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
-- 
2.17.1

