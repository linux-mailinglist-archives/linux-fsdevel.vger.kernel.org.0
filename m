Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E649A3CAFE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 02:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhGPAHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 20:07:05 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52313 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbhGPAG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:06:59 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210716000403epoutp0169c624228b74b1c421e14e8fb93025ed~SHJWDt70q1920419204epoutp01g
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 00:04:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210716000403epoutp0169c624228b74b1c421e14e8fb93025ed~SHJWDt70q1920419204epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626393843;
        bh=95igpM+asSgOWcVnYP7dDvYTCpekOP+M9vSFWmT/+RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcGVv/emvZFTgouEvOZOKSvDW+rKehYO7YODaFHf7MlCN5idfJyae2jyhBiCn2vKx
         uw+8nH3R2RJVQBkGrCvNcJ6+TYLnYjlAkd7dxC/T1AE6RamWHcimf/kNxcbGDG/AZI
         EzVIp8u9clSsmh2T4vhlFh1nV2A8zz7ECtgn59qY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210716000358epcas1p2aea6017c0a5c863ed91eb07fef83f448~SHJRcPFyg0789907899epcas1p2O;
        Fri, 16 Jul 2021 00:03:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GQs0Y21yNz4x9Q8; Fri, 16 Jul
        2021 00:03:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.9E.10119.DECC0F06; Fri, 16 Jul 2021 09:03:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210716000353epcas1p408f03e0e1a6621e778dc3f9407fc56e9~SHJMMJ2FD0592905929epcas1p4-;
        Fri, 16 Jul 2021 00:03:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210716000353epsmtrp209e5d8833f28045d2fd5db901ee2b5e9~SHJMK6fKh1353413534epsmtrp2r;
        Fri, 16 Jul 2021 00:03:53 +0000 (GMT)
X-AuditID: b6c32a38-97bff70000002787-9c-60f0ccedc847
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.FA.08394.9ECC0F06; Fri, 16 Jul 2021 09:03:53 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210716000352epsmtip211c48dcddc99bb021097c0b2fb85fb7b~SHJLlGc6f1664616646epsmtip2E;
        Fri, 16 Jul 2021 00:03:52 +0000 (GMT)
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
Subject: [PATCH v6 08/13] ksmbd: add smb3 engine part 1
Date:   Fri, 16 Jul 2021 08:53:51 +0900
Message-Id: <20210715235356.3191-9-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715235356.3191-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmnu7bMx8SDN79ZrM4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFE5NhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAzykplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3IyVvW/Yyw48Vio4sKr
        o0wNjG+X83cxcnJICJhIrNjQydjFyMUhJLCDUeLevpnsEM4nRolHk74yQzjfGCVOb1vJDtOy
        +tI2qMReRolJf5rZ4Fp+vpzO2sXIwcEmoC3xZ4soSIOIQKzEjR2vwRqYBbqYJZ7eP8MEkhAW
        MJeY2tTIAmKzCKhKzDx4G8zmFbCWuHjtPhvENnmJ1RsOMIPYnAI2Eo9PfgM7VkLgDIfEuX93
        GEGWSQi4SLQ9EYWoF5Z4dXwL1KVSEp/f7YWaUy5x4uQvJgi7RmLDvH3sEK3GEj0vSkBMZgFN
        ifW79CEqFCV2/p7LCGIzC/BJvPvawwpRzSvR0SYEUaIq0XfpMNRAaYmu9g9QSz0k7nafZIWE
        SD+jxIbTc1gmMMrNQtiwgJFxFaNYakFxbnpqsWGBCXKUbWIEJ18tix2Mc99+0DvEyMTBeIhR
        goNZSYR3qdHbBCHelMTKqtSi/Pii0pzU4kOMpsCgm8gsJZqcD0z/eSXxhqZGxsbGFiZm5mam
        xkrivDvZDiUICaQnlqRmp6YWpBbB9DFxcEo1MLXbursWN9XY8DR/ZHmx49jf80v0xHSCzyy4
        yvdLJ5H5z1nbOQdnzmNWVXjcbv8h8Grm6isNj9KeH9dcarGF6x+H0o1Ao+hd4TKvnn2s/Mv4
        3Xxm111Fjj1+5/LL71zdccbDu91499X2wFhfte77d7fdSLrlLj1RXPBvbaefmPWU/zJalROj
        /dXf5ajxVvXdmWzxqnPqi3gmrf8Tpss9nJEuVqiWGHdpnXTxdzsT8QO3Hr7r3P9uxzF+8zCF
        Hat75q25vObD3hixLy5XTKz7s4tMAmpqgvoqTwtdTnaYmX7uq8Cyad1eCsc6o6x2rnaZIs8k
        rZxd6f4xZY5359cvhYt7n2xPa+mQZurZrKtwVImlOCPRUIu5qDgRAJpgXJxHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO7LMx8SDL5t5LA4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFFcNimpOZllqUX6dglc
        Gav63zEWnHgsVHHh1VGmBsa3y/m7GDk5JARMJFZf2sbcxcjFISSwm1Hi59dDbBAJaYljJ84A
        JTiAbGGJw4eLIWo+MErsu3ONESTOJqAt8WeLKEi5iEC8xM2G2ywgNcwCc5gldm48wgiSEBYw
        l5ja1MgCYrMIqErMPHgbzOYVsJa4eO0+1C55idUbDjCD2JwCNhKPT34D6xUCqlm/ZgPLBEa+
        BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNES3MH4/ZVH/QOMTJxMB5ilOBg
        VhLhXWr0NkGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkG
        ppyohrdLqxwKb++S9orT9fqzeXH06lXrRNia214x2Ev4mr7XtuZZbCK669HWmkX5jpvz/uxO
        vJt5sYOj4Ljs/6mWXatUPdkt9qyRL1wZlDDF71DKfZ4ZzycUWNt433+i1BxVzrSQb8oNwx0z
        8449Tyv7UXjmf59BUdhm7XldizNqTSf4qOX/8U2Nf9ikeu32xtjtXeoiOem9JkUFXGu5rNpy
        ig9r3VApz+rff1fMxejM8q6mn8z3FL+uzJrzakXNMaYGdpbQTSneqw64x4o11a/lDv1n6pCb
        lj313EIZpZ+//1/6ZcqZs1txFvORSEPmwDf6h5/k2b7udxPd2zBpdghHQq6DgNWEMyIzAj4p
        sRRnJBpqMRcVJwIAc2gweQEDAAA=
X-CMS-MailID: 20210716000353epcas1p408f03e0e1a6621e778dc3f9407fc56e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210716000353epcas1p408f03e0e1a6621e778dc3f9407fc56e9
References: <20210715235356.3191-1-namjae.jeon@samsung.com>
        <CGME20210716000353epcas1p408f03e0e1a6621e778dc3f9407fc56e9@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds server-side procedures for SMB3.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2ops.c |  308 ++
 fs/ksmbd/smb2pdu.c | 8299 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/smb2pdu.h | 1684 +++++++++
 3 files changed, 10291 insertions(+)
 create mode 100644 fs/ksmbd/smb2ops.c
 create mode 100644 fs/ksmbd/smb2pdu.c
 create mode 100644 fs/ksmbd/smb2pdu.h

diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
new file mode 100644
index 000000000000..8262908e467c
--- /dev/null
+++ b/fs/ksmbd/smb2ops.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include "glob.h"
+#include "smb2pdu.h"
+
+#include "auth.h"
+#include "connection.h"
+#include "smb_common.h"
+#include "server.h"
+
+static struct smb_version_values smb21_server_values = {
+	.version_string = SMB21_VERSION_STRING,
+	.protocol_id = SMB21_PROT_ID,
+	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.max_read_size = SMB21_DEFAULT_IOSIZE,
+	.max_write_size = SMB21_DEFAULT_IOSIZE,
+	.max_trans_size = SMB21_DEFAULT_IOSIZE,
+	.large_lock_type = 0,
+	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE,
+	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
+	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
+	.header_size = sizeof(struct smb2_hdr),
+	.max_header_size = MAX_SMB2_HDR_SIZE,
+	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.lock_cmd = SMB2_LOCK,
+	.cap_unix = 0,
+	.cap_nt_find = SMB2_NT_FIND,
+	.cap_large_files = SMB2_LARGE_FILES,
+	.create_lease_size = sizeof(struct create_lease),
+	.create_durable_size = sizeof(struct create_durable_rsp),
+	.create_mxac_size = sizeof(struct create_mxac_rsp),
+	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
+	.create_posix_size = sizeof(struct create_posix_rsp),
+};
+
+static struct smb_version_values smb30_server_values = {
+	.version_string = SMB30_VERSION_STRING,
+	.protocol_id = SMB30_PROT_ID,
+	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.max_read_size = SMB3_DEFAULT_IOSIZE,
+	.max_write_size = SMB3_DEFAULT_IOSIZE,
+	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
+	.large_lock_type = 0,
+	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE,
+	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
+	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
+	.header_size = sizeof(struct smb2_hdr),
+	.max_header_size = MAX_SMB2_HDR_SIZE,
+	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.lock_cmd = SMB2_LOCK,
+	.cap_unix = 0,
+	.cap_nt_find = SMB2_NT_FIND,
+	.cap_large_files = SMB2_LARGE_FILES,
+	.create_lease_size = sizeof(struct create_lease_v2),
+	.create_durable_size = sizeof(struct create_durable_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_mxac_size = sizeof(struct create_mxac_rsp),
+	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
+	.create_posix_size = sizeof(struct create_posix_rsp),
+};
+
+static struct smb_version_values smb302_server_values = {
+	.version_string = SMB302_VERSION_STRING,
+	.protocol_id = SMB302_PROT_ID,
+	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.max_read_size = SMB3_DEFAULT_IOSIZE,
+	.max_write_size = SMB3_DEFAULT_IOSIZE,
+	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
+	.large_lock_type = 0,
+	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE,
+	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
+	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
+	.header_size = sizeof(struct smb2_hdr),
+	.max_header_size = MAX_SMB2_HDR_SIZE,
+	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.lock_cmd = SMB2_LOCK,
+	.cap_unix = 0,
+	.cap_nt_find = SMB2_NT_FIND,
+	.cap_large_files = SMB2_LARGE_FILES,
+	.create_lease_size = sizeof(struct create_lease_v2),
+	.create_durable_size = sizeof(struct create_durable_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_mxac_size = sizeof(struct create_mxac_rsp),
+	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
+	.create_posix_size = sizeof(struct create_posix_rsp),
+};
+
+static struct smb_version_values smb311_server_values = {
+	.version_string = SMB311_VERSION_STRING,
+	.protocol_id = SMB311_PROT_ID,
+	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.max_read_size = SMB3_DEFAULT_IOSIZE,
+	.max_write_size = SMB3_DEFAULT_IOSIZE,
+	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
+	.large_lock_type = 0,
+	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE,
+	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
+	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
+	.header_size = sizeof(struct smb2_hdr),
+	.max_header_size = MAX_SMB2_HDR_SIZE,
+	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.lock_cmd = SMB2_LOCK,
+	.cap_unix = 0,
+	.cap_nt_find = SMB2_NT_FIND,
+	.cap_large_files = SMB2_LARGE_FILES,
+	.create_lease_size = sizeof(struct create_lease_v2),
+	.create_durable_size = sizeof(struct create_durable_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_mxac_size = sizeof(struct create_mxac_rsp),
+	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
+	.create_posix_size = sizeof(struct create_posix_rsp),
+};
+
+static struct smb_version_ops smb2_0_server_ops = {
+	.get_cmd_val		=	get_smb2_cmd_val,
+	.init_rsp_hdr		=	init_smb2_rsp_hdr,
+	.set_rsp_status		=	set_smb2_rsp_status,
+	.allocate_rsp_buf       =       smb2_allocate_rsp_buf,
+	.set_rsp_credits	=	smb2_set_rsp_credits,
+	.check_user_session	=	smb2_check_user_session,
+	.get_ksmbd_tcon		=	smb2_get_ksmbd_tcon,
+	.is_sign_req		=	smb2_is_sign_req,
+	.check_sign_req		=	smb2_check_sign_req,
+	.set_sign_rsp		=	smb2_set_sign_rsp
+};
+
+static struct smb_version_ops smb3_0_server_ops = {
+	.get_cmd_val		=	get_smb2_cmd_val,
+	.init_rsp_hdr		=	init_smb2_rsp_hdr,
+	.set_rsp_status		=	set_smb2_rsp_status,
+	.allocate_rsp_buf       =       smb2_allocate_rsp_buf,
+	.set_rsp_credits	=	smb2_set_rsp_credits,
+	.check_user_session	=	smb2_check_user_session,
+	.get_ksmbd_tcon		=	smb2_get_ksmbd_tcon,
+	.is_sign_req		=	smb2_is_sign_req,
+	.check_sign_req		=	smb3_check_sign_req,
+	.set_sign_rsp		=	smb3_set_sign_rsp,
+	.generate_signingkey	=	ksmbd_gen_smb30_signingkey,
+	.generate_encryptionkey	=	ksmbd_gen_smb30_encryptionkey,
+	.is_transform_hdr	=	smb3_is_transform_hdr,
+	.decrypt_req		=	smb3_decrypt_req,
+	.encrypt_resp		=	smb3_encrypt_resp
+};
+
+static struct smb_version_ops smb3_11_server_ops = {
+	.get_cmd_val		=	get_smb2_cmd_val,
+	.init_rsp_hdr		=	init_smb2_rsp_hdr,
+	.set_rsp_status		=	set_smb2_rsp_status,
+	.allocate_rsp_buf       =       smb2_allocate_rsp_buf,
+	.set_rsp_credits	=	smb2_set_rsp_credits,
+	.check_user_session	=	smb2_check_user_session,
+	.get_ksmbd_tcon		=	smb2_get_ksmbd_tcon,
+	.is_sign_req		=	smb2_is_sign_req,
+	.check_sign_req		=	smb3_check_sign_req,
+	.set_sign_rsp		=	smb3_set_sign_rsp,
+	.generate_signingkey	=	ksmbd_gen_smb311_signingkey,
+	.generate_encryptionkey	=	ksmbd_gen_smb311_encryptionkey,
+	.is_transform_hdr	=	smb3_is_transform_hdr,
+	.decrypt_req		=	smb3_decrypt_req,
+	.encrypt_resp		=	smb3_encrypt_resp
+};
+
+static struct smb_version_cmds smb2_0_server_cmds[NUMBER_OF_SMB2_COMMANDS] = {
+	[SMB2_NEGOTIATE_HE]	=	{ .proc = smb2_negotiate_request, },
+	[SMB2_SESSION_SETUP_HE] =	{ .proc = smb2_sess_setup, },
+	[SMB2_TREE_CONNECT_HE]  =	{ .proc = smb2_tree_connect,},
+	[SMB2_TREE_DISCONNECT_HE]  =	{ .proc = smb2_tree_disconnect,},
+	[SMB2_LOGOFF_HE]	=	{ .proc = smb2_session_logoff,},
+	[SMB2_CREATE_HE]	=	{ .proc = smb2_open},
+	[SMB2_QUERY_INFO_HE]	=	{ .proc = smb2_query_info},
+	[SMB2_QUERY_DIRECTORY_HE] =	{ .proc = smb2_query_dir},
+	[SMB2_CLOSE_HE]		=	{ .proc = smb2_close},
+	[SMB2_ECHO_HE]		=	{ .proc = smb2_echo},
+	[SMB2_SET_INFO_HE]      =       { .proc = smb2_set_info},
+	[SMB2_READ_HE]		=	{ .proc = smb2_read},
+	[SMB2_WRITE_HE]		=	{ .proc = smb2_write},
+	[SMB2_FLUSH_HE]		=	{ .proc = smb2_flush},
+	[SMB2_CANCEL_HE]	=	{ .proc = smb2_cancel},
+	[SMB2_LOCK_HE]		=	{ .proc = smb2_lock},
+	[SMB2_IOCTL_HE]		=	{ .proc = smb2_ioctl},
+	[SMB2_OPLOCK_BREAK_HE]	=	{ .proc = smb2_oplock_break},
+	[SMB2_CHANGE_NOTIFY_HE]	=	{ .proc = smb2_notify},
+};
+
+int init_smb2_0_server(struct ksmbd_conn *conn)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * init_smb2_1_server() - initialize a smb server connection with smb2.1
+ *			command dispatcher
+ * @conn:	connection instance
+ */
+void init_smb2_1_server(struct ksmbd_conn *conn)
+{
+	conn->vals = &smb21_server_values;
+	conn->ops = &smb2_0_server_ops;
+	conn->cmds = smb2_0_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
+	conn->max_credits = SMB2_MAX_CREDITS;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+}
+
+/**
+ * init_smb3_0_server() - initialize a smb server connection with smb3.0
+ *			command dispatcher
+ * @conn:	connection instance
+ */
+void init_smb3_0_server(struct ksmbd_conn *conn)
+{
+	conn->vals = &smb30_server_values;
+	conn->ops = &smb3_0_server_ops;
+	conn->cmds = smb2_0_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
+	conn->max_credits = SMB2_MAX_CREDITS;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
+	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
+}
+
+/**
+ * init_smb3_02_server() - initialize a smb server connection with smb3.02
+ *			command dispatcher
+ * @conn:	connection instance
+ */
+void init_smb3_02_server(struct ksmbd_conn *conn)
+{
+	conn->vals = &smb302_server_values;
+	conn->ops = &smb3_0_server_ops;
+	conn->cmds = smb2_0_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
+	conn->max_credits = SMB2_MAX_CREDITS;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
+	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
+}
+
+/**
+ * init_smb3_11_server() - initialize a smb server connection with smb3.11
+ *			command dispatcher
+ * @conn:	connection instance
+ */
+int init_smb3_11_server(struct ksmbd_conn *conn)
+{
+	conn->vals = &smb311_server_values;
+	conn->ops = &smb3_11_server_ops;
+	conn->cmds = smb2_0_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
+	conn->max_credits = SMB2_MAX_CREDITS;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+
+	if (conn->cipher_type)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
+
+	INIT_LIST_HEAD(&conn->preauth_sess_table);
+	return 0;
+}
+
+void init_smb2_max_read_size(unsigned int sz)
+{
+	smb21_server_values.max_read_size = sz;
+	smb30_server_values.max_read_size = sz;
+	smb302_server_values.max_read_size = sz;
+	smb311_server_values.max_read_size = sz;
+}
+
+void init_smb2_max_write_size(unsigned int sz)
+{
+	smb21_server_values.max_write_size = sz;
+	smb30_server_values.max_write_size = sz;
+	smb302_server_values.max_write_size = sz;
+	smb311_server_values.max_write_size = sz;
+}
+
+void init_smb2_max_trans_size(unsigned int sz)
+{
+	smb21_server_values.max_trans_size = sz;
+	smb30_server_values.max_trans_size = sz;
+	smb302_server_values.max_trans_size = sz;
+	smb311_server_values.max_trans_size = sz;
+}
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
new file mode 100644
index 000000000000..c1a594599431
--- /dev/null
+++ b/fs/ksmbd/smb2pdu.c
@@ -0,0 +1,8299 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <linux/syscalls.h>
+#include <linux/namei.h>
+#include <linux/statfs.h>
+#include <linux/ethtool.h>
+#include <linux/falloc.h>
+
+#include "glob.h"
+#include "smb2pdu.h"
+#include "smbfsctl.h"
+#include "oplock.h"
+#include "smbacl.h"
+
+#include "auth.h"
+#include "asn1.h"
+#include "connection.h"
+#include "transport_ipc.h"
+#include "transport_rdma.h"
+#include "vfs.h"
+#include "vfs_cache.h"
+#include "misc.h"
+
+#include "server.h"
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "ksmbd_work.h"
+#include "mgmt/user_config.h"
+#include "mgmt/share_config.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/user_session.h"
+#include "mgmt/ksmbd_ida.h"
+#include "ndr.h"
+
+static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
+{
+	if (work->next_smb2_rcv_hdr_off) {
+		*req = ksmbd_req_buf_next(work);
+		*rsp = ksmbd_resp_buf_next(work);
+	} else {
+		*req = work->request_buf;
+		*rsp = work->response_buf;
+	}
+}
+
+#define WORK_BUFFERS(w, rq, rs)	__wbuf((w), (void **)&(rq), (void **)&(rs))
+
+/**
+ * check_session_id() - check for valid session id in smb header
+ * @conn:	connection instance
+ * @id:		session id from smb header
+ *
+ * Return:      1 if valid session id, otherwise 0
+ */
+static inline int check_session_id(struct ksmbd_conn *conn, u64 id)
+{
+	struct ksmbd_session *sess;
+
+	if (id == 0 || id == -1)
+		return 0;
+
+	sess = ksmbd_session_lookup_all(conn, id);
+	if (sess)
+		return 1;
+	pr_err("Invalid user session id: %llu\n", id);
+	return 0;
+}
+
+struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
+{
+	struct channel *chann;
+
+	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
+		if (chann->conn == conn)
+			return chann;
+	}
+
+	return NULL;
+}
+
+/**
+ * smb2_get_ksmbd_tcon() - get tree connection information for a tree id
+ * @work:	smb work
+ *
+ * Return:      matching tree connection on success, otherwise error
+ */
+int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
+{
+	struct smb2_hdr *req_hdr = work->request_buf;
+	int tree_id;
+
+	work->tcon = NULL;
+	if (work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE ||
+	    work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE ||
+	    work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE) {
+		ksmbd_debug(SMB, "skip to check tree connect request\n");
+		return 0;
+	}
+
+	if (xa_empty(&work->sess->tree_conns)) {
+		ksmbd_debug(SMB, "NO tree connected\n");
+		return -1;
+	}
+
+	tree_id = le32_to_cpu(req_hdr->Id.SyncId.TreeId);
+	work->tcon = ksmbd_tree_conn_lookup(work->sess, tree_id);
+	if (!work->tcon) {
+		pr_err("Invalid tid %d\n", tree_id);
+		return -1;
+	}
+
+	return 1;
+}
+
+/**
+ * smb2_set_err_rsp() - set error response code on smb response
+ * @work:	smb work containing response buffer
+ */
+void smb2_set_err_rsp(struct ksmbd_work *work)
+{
+	struct smb2_err_rsp *err_rsp;
+
+	if (work->next_smb2_rcv_hdr_off)
+		err_rsp = ksmbd_resp_buf_next(work);
+	else
+		err_rsp = work->response_buf;
+
+	if (err_rsp->hdr.Status != STATUS_STOPPED_ON_SYMLINK) {
+		err_rsp->StructureSize = SMB2_ERROR_STRUCTURE_SIZE2_LE;
+		err_rsp->ErrorContextCount = 0;
+		err_rsp->Reserved = 0;
+		err_rsp->ByteCount = 0;
+		err_rsp->ErrorData[0] = 0;
+		inc_rfc1001_len(work->response_buf, SMB2_ERROR_STRUCTURE_SIZE2);
+	}
+}
+
+/**
+ * is_smb2_neg_cmd() - is it smb2 negotiation command
+ * @work:	smb work containing smb header
+ *
+ * Return:      1 if smb2 negotiation command, otherwise 0
+ */
+int is_smb2_neg_cmd(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr = work->request_buf;
+
+	/* is it SMB2 header ? */
+	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
+		return 0;
+
+	/* make sure it is request not response message */
+	if (hdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR)
+		return 0;
+
+	if (hdr->Command != SMB2_NEGOTIATE)
+		return 0;
+
+	return 1;
+}
+
+/**
+ * is_smb2_rsp() - is it smb2 response
+ * @work:	smb work containing smb response buffer
+ *
+ * Return:      1 if smb2 response, otherwise 0
+ */
+int is_smb2_rsp(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr = work->response_buf;
+
+	/* is it SMB2 header ? */
+	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
+		return 0;
+
+	/* make sure it is response not request message */
+	if (!(hdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR))
+		return 0;
+
+	return 1;
+}
+
+/**
+ * get_smb2_cmd_val() - get smb command code from smb header
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      smb2 request command value
+ */
+u16 get_smb2_cmd_val(struct ksmbd_work *work)
+{
+	struct smb2_hdr *rcv_hdr;
+
+	if (work->next_smb2_rcv_hdr_off)
+		rcv_hdr = ksmbd_req_buf_next(work);
+	else
+		rcv_hdr = work->request_buf;
+	return le16_to_cpu(rcv_hdr->Command);
+}
+
+/**
+ * set_smb2_rsp_status() - set error response code on smb2 header
+ * @work:	smb work containing response buffer
+ * @err:	error response code
+ */
+void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
+{
+	struct smb2_hdr *rsp_hdr;
+
+	if (work->next_smb2_rcv_hdr_off)
+		rsp_hdr = ksmbd_resp_buf_next(work);
+	else
+		rsp_hdr = work->response_buf;
+	rsp_hdr->Status = err;
+	smb2_set_err_rsp(work);
+}
+
+/**
+ * init_smb2_neg_rsp() - initialize smb2 response for negotiate command
+ * @work:	smb work containing smb request buffer
+ *
+ * smb2 negotiate response is sent in reply of smb1 negotiate command for
+ * dialect auto-negotiation.
+ */
+int init_smb2_neg_rsp(struct ksmbd_work *work)
+{
+	struct smb2_hdr *rsp_hdr;
+	struct smb2_negotiate_rsp *rsp;
+	struct ksmbd_conn *conn = work->conn;
+
+	if (conn->need_neg == false)
+		return -EINVAL;
+	if (!(conn->dialect >= SMB20_PROT_ID &&
+	      conn->dialect <= SMB311_PROT_ID))
+		return -EINVAL;
+
+	rsp_hdr = work->response_buf;
+
+	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
+
+	rsp_hdr->smb2_buf_length =
+		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
+
+	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->CreditRequest = cpu_to_le16(2);
+	rsp_hdr->Command = SMB2_NEGOTIATE;
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = 0;
+	rsp_hdr->Id.SyncId.ProcessId = 0;
+	rsp_hdr->Id.SyncId.TreeId = 0;
+	rsp_hdr->SessionId = 0;
+	memset(rsp_hdr->Signature, 0, 16);
+
+	rsp = work->response_buf;
+
+	WARN_ON(ksmbd_conn_good(work));
+
+	rsp->StructureSize = cpu_to_le16(65);
+	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
+	rsp->DialectRevision = cpu_to_le16(conn->dialect);
+	/* Not setting conn guid rsp->ServerGUID, as it
+	 * not used by client for identifying connection
+	 */
+	rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+	/* Default Max Message Size till SMB2.0, 64K*/
+	rsp->MaxTransactSize = cpu_to_le32(conn->vals->max_trans_size);
+	rsp->MaxReadSize = cpu_to_le32(conn->vals->max_read_size);
+	rsp->MaxWriteSize = cpu_to_le32(conn->vals->max_write_size);
+
+	rsp->SystemTime = cpu_to_le64(ksmbd_systime());
+	rsp->ServerStartTime = 0;
+
+	rsp->SecurityBufferOffset = cpu_to_le16(128);
+	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
+	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
+		sizeof(rsp->hdr.smb2_buf_length)) +
+		le16_to_cpu(rsp->SecurityBufferOffset));
+	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
+		sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
+		AUTH_GSS_LENGTH);
+	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
+	if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY)
+		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
+	conn->use_spnego = true;
+
+	ksmbd_conn_set_need_negotiate(work);
+	return 0;
+}
+
+static int smb2_consume_credit_charge(struct ksmbd_work *work,
+				      unsigned short credit_charge)
+{
+	struct ksmbd_conn *conn = work->conn;
+	unsigned int rsp_credits = 1;
+
+	if (!conn->total_credits)
+		return 0;
+
+	if (credit_charge > 0)
+		rsp_credits = credit_charge;
+
+	conn->total_credits -= rsp_credits;
+	return rsp_credits;
+}
+
+/**
+ * smb2_set_rsp_credits() - set number of credits in response buffer
+ * @work:	smb work containing smb response buffer
+ */
+int smb2_set_rsp_credits(struct ksmbd_work *work)
+{
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
+	struct smb2_hdr *hdr = ksmbd_resp_buf_next(work);
+	struct ksmbd_conn *conn = work->conn;
+	unsigned short credits_requested = le16_to_cpu(req_hdr->CreditRequest);
+	unsigned short credit_charge = 1, credits_granted = 0;
+	unsigned short aux_max, aux_credits, min_credits;
+	int rsp_credit_charge;
+
+	if (hdr->Command == SMB2_CANCEL)
+		goto out;
+
+	/* get default minimum credits by shifting maximum credits by 4 */
+	min_credits = conn->max_credits >> 4;
+
+	if (conn->total_credits >= conn->max_credits) {
+		pr_err("Total credits overflow: %d\n", conn->total_credits);
+		conn->total_credits = min_credits;
+	}
+
+	rsp_credit_charge =
+		smb2_consume_credit_charge(work, le16_to_cpu(req_hdr->CreditCharge));
+	if (rsp_credit_charge < 0)
+		return -EINVAL;
+
+	hdr->CreditCharge = cpu_to_le16(rsp_credit_charge);
+
+	if (credits_requested > 0) {
+		aux_credits = credits_requested - 1;
+		aux_max = 32;
+		if (hdr->Command == SMB2_NEGOTIATE)
+			aux_max = 0;
+		aux_credits = (aux_credits < aux_max) ? aux_credits : aux_max;
+		credits_granted = aux_credits + credit_charge;
+
+		/* if credits granted per client is getting bigger than default
+		 * minimum credits then we should wrap it up within the limits.
+		 */
+		if ((conn->total_credits + credits_granted) > min_credits)
+			credits_granted = min_credits -	conn->total_credits;
+		/*
+		 * TODO: Need to adjuct CreditRequest value according to
+		 * current cpu load
+		 */
+	} else if (conn->total_credits == 0) {
+		credits_granted = 1;
+	}
+
+	conn->total_credits += credits_granted;
+	work->credits_granted += credits_granted;
+
+	if (!req_hdr->NextCommand) {
+		/* Update CreditRequest in last request */
+		hdr->CreditRequest = cpu_to_le16(work->credits_granted);
+	}
+out:
+	ksmbd_debug(SMB,
+		    "credits: requested[%d] granted[%d] total_granted[%d]\n",
+		    credits_requested, credits_granted,
+		    conn->total_credits);
+	return 0;
+}
+
+/**
+ * init_chained_smb2_rsp() - initialize smb2 chained response
+ * @work:	smb work containing smb response buffer
+ */
+static void init_chained_smb2_rsp(struct ksmbd_work *work)
+{
+	struct smb2_hdr *req = ksmbd_req_buf_next(work);
+	struct smb2_hdr *rsp = ksmbd_resp_buf_next(work);
+	struct smb2_hdr *rsp_hdr;
+	struct smb2_hdr *rcv_hdr;
+	int next_hdr_offset = 0;
+	int len, new_len;
+
+	/* Len of this response = updated RFC len - offset of previous cmd
+	 * in the compound rsp
+	 */
+
+	/* Storing the current local FID which may be needed by subsequent
+	 * command in the compound request
+	 */
+	if (req->Command == SMB2_CREATE && rsp->Status == STATUS_SUCCESS) {
+		work->compound_fid =
+			le64_to_cpu(((struct smb2_create_rsp *)rsp)->
+				VolatileFileId);
+		work->compound_pfid =
+			le64_to_cpu(((struct smb2_create_rsp *)rsp)->
+				PersistentFileId);
+		work->compound_sid = le64_to_cpu(rsp->SessionId);
+	}
+
+	len = get_rfc1002_len(work->response_buf) - work->next_smb2_rsp_hdr_off;
+	next_hdr_offset = le32_to_cpu(req->NextCommand);
+
+	new_len = ALIGN(len, 8);
+	inc_rfc1001_len(work->response_buf, ((sizeof(struct smb2_hdr) - 4)
+			+ new_len - len));
+	rsp->NextCommand = cpu_to_le32(new_len);
+
+	work->next_smb2_rcv_hdr_off += next_hdr_offset;
+	work->next_smb2_rsp_hdr_off += new_len;
+	ksmbd_debug(SMB,
+		    "Compound req new_len = %d rcv off = %d rsp off = %d\n",
+		    new_len, work->next_smb2_rcv_hdr_off,
+		    work->next_smb2_rsp_hdr_off);
+
+	rsp_hdr = ksmbd_resp_buf_next(work);
+	rcv_hdr = ksmbd_req_buf_next(work);
+
+	if (!(rcv_hdr->Flags & SMB2_FLAGS_RELATED_OPERATIONS)) {
+		ksmbd_debug(SMB, "related flag should be set\n");
+		work->compound_fid = KSMBD_NO_FID;
+		work->compound_pfid = KSMBD_NO_FID;
+	}
+	memset((char *)rsp_hdr + 4, 0, sizeof(struct smb2_hdr) + 2);
+	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->Command = rcv_hdr->Command;
+
+	/*
+	 * Message is response. We don't grant oplock yet.
+	 */
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR |
+				SMB2_FLAGS_RELATED_OPERATIONS);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = rcv_hdr->MessageId;
+	rsp_hdr->Id.SyncId.ProcessId = rcv_hdr->Id.SyncId.ProcessId;
+	rsp_hdr->Id.SyncId.TreeId = rcv_hdr->Id.SyncId.TreeId;
+	rsp_hdr->SessionId = rcv_hdr->SessionId;
+	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
+}
+
+/**
+ * is_chained_smb2_message() - check for chained command
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      true if chained request, otherwise false
+ */
+bool is_chained_smb2_message(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr = work->request_buf;
+	unsigned int len;
+
+	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
+		return false;
+
+	hdr = ksmbd_req_buf_next(work);
+	if (le32_to_cpu(hdr->NextCommand) > 0) {
+		ksmbd_debug(SMB, "got SMB2 chained command\n");
+		init_chained_smb2_rsp(work);
+		return true;
+	} else if (work->next_smb2_rcv_hdr_off) {
+		/*
+		 * This is last request in chained command,
+		 * align response to 8 byte
+		 */
+		len = ALIGN(get_rfc1002_len(work->response_buf), 8);
+		len = len - get_rfc1002_len(work->response_buf);
+		if (len) {
+			ksmbd_debug(SMB, "padding len %u\n", len);
+			inc_rfc1001_len(work->response_buf, len);
+			if (work->aux_payload_sz)
+				work->aux_payload_sz += len;
+		}
+	}
+	return false;
+}
+
+/**
+ * init_smb2_rsp_hdr() - initialize smb2 response
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0
+ */
+int init_smb2_rsp_hdr(struct ksmbd_work *work)
+{
+	struct smb2_hdr *rsp_hdr = work->response_buf;
+	struct smb2_hdr *rcv_hdr = work->request_buf;
+	struct ksmbd_conn *conn = work->conn;
+
+	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
+	rsp_hdr->smb2_buf_length =
+		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
+	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->Command = rcv_hdr->Command;
+
+	/*
+	 * Message is response. We don't grant oplock yet.
+	 */
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = rcv_hdr->MessageId;
+	rsp_hdr->Id.SyncId.ProcessId = rcv_hdr->Id.SyncId.ProcessId;
+	rsp_hdr->Id.SyncId.TreeId = rcv_hdr->Id.SyncId.TreeId;
+	rsp_hdr->SessionId = rcv_hdr->SessionId;
+	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
+
+	work->syncronous = true;
+	if (work->async_id) {
+		ksmbd_release_id(&conn->async_ida, work->async_id);
+		work->async_id = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * smb2_allocate_rsp_buf() - allocate smb2 response buffer
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0 on success, otherwise -ENOMEM
+ */
+int smb2_allocate_rsp_buf(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr = work->request_buf;
+	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
+	size_t large_sz = work->conn->vals->max_trans_size + MAX_SMB2_HDR_SIZE;
+	size_t sz = small_sz;
+	int cmd = le16_to_cpu(hdr->Command);
+
+	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE)
+		sz = large_sz;
+
+	if (cmd == SMB2_QUERY_INFO_HE) {
+		struct smb2_query_info_req *req;
+
+		req = work->request_buf;
+		if (req->InfoType == SMB2_O_INFO_FILE &&
+		    (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
+		     req->FileInfoClass == FILE_ALL_INFORMATION))
+			sz = large_sz;
+	}
+
+	/* allocate large response buf for chained commands */
+	if (le32_to_cpu(hdr->NextCommand) > 0)
+		sz = large_sz;
+
+	work->response_buf = kvmalloc(sz, GFP_KERNEL | __GFP_ZERO);
+	if (!work->response_buf)
+		return -ENOMEM;
+
+	work->response_sz = sz;
+	return 0;
+}
+
+/**
+ * smb2_check_user_session() - check for valid session for a user
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+int smb2_check_user_session(struct ksmbd_work *work)
+{
+	struct smb2_hdr *req_hdr = work->request_buf;
+	struct ksmbd_conn *conn = work->conn;
+	unsigned int cmd = conn->ops->get_cmd_val(work);
+	unsigned long long sess_id;
+
+	work->sess = NULL;
+	/*
+	 * SMB2_ECHO, SMB2_NEGOTIATE, SMB2_SESSION_SETUP command do not
+	 * require a session id, so no need to validate user session's for
+	 * these commands.
+	 */
+	if (cmd == SMB2_ECHO_HE || cmd == SMB2_NEGOTIATE_HE ||
+	    cmd == SMB2_SESSION_SETUP_HE)
+		return 0;
+
+	if (!ksmbd_conn_good(work))
+		return -EINVAL;
+
+	sess_id = le64_to_cpu(req_hdr->SessionId);
+	/* Check for validity of user session */
+	work->sess = ksmbd_session_lookup_all(conn, sess_id);
+	if (work->sess)
+		return 1;
+	ksmbd_debug(SMB, "Invalid user session, Uid %llu\n", sess_id);
+	return -EINVAL;
+}
+
+static void destroy_previous_session(struct ksmbd_user *user, u64 id)
+{
+	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
+	struct ksmbd_user *prev_user;
+
+	if (!prev_sess)
+		return;
+
+	prev_user = prev_sess->user;
+
+	if (!prev_user ||
+	    strcmp(user->name, prev_user->name) ||
+	    user->passkey_sz != prev_user->passkey_sz ||
+	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz)) {
+		put_session(prev_sess);
+		return;
+	}
+
+	put_session(prev_sess);
+	ksmbd_session_destroy(prev_sess);
+}
+
+/**
+ * smb2_get_name() - get filename string from on the wire smb format
+ * @share:	ksmbd_share_config pointer
+ * @src:	source buffer
+ * @maxlen:	maxlen of source string
+ * @nls_table:	nls_table pointer
+ *
+ * Return:      matching converted filename on success, otherwise error ptr
+ */
+static char *
+smb2_get_name(struct ksmbd_share_config *share, const char *src,
+	      const int maxlen, struct nls_table *local_nls)
+{
+	char *name, *unixname;
+
+	name = smb_strndup_from_utf16(src, maxlen, 1, local_nls);
+	if (IS_ERR(name)) {
+		pr_err("failed to get name %ld\n", PTR_ERR(name));
+		return name;
+	}
+
+	/* change it to absolute unix name */
+	ksmbd_conv_path_to_unix(name);
+	ksmbd_strip_last_slash(name);
+
+	unixname = convert_to_unix_name(share, name);
+	kfree(name);
+	if (!unixname) {
+		pr_err("can not convert absolute name\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ksmbd_debug(SMB, "absolute name = %s\n", unixname);
+	return unixname;
+}
+
+int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
+{
+	struct smb2_hdr *rsp_hdr;
+	struct ksmbd_conn *conn = work->conn;
+	int id;
+
+	rsp_hdr = work->response_buf;
+	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
+
+	id = ksmbd_acquire_async_msg_id(&conn->async_ida);
+	if (id < 0) {
+		pr_err("Failed to alloc async message id\n");
+		return id;
+	}
+	work->syncronous = false;
+	work->async_id = id;
+	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
+
+	ksmbd_debug(SMB,
+		    "Send interim Response to inform async request id : %d\n",
+		    work->async_id);
+
+	work->cancel_fn = fn;
+	work->cancel_argv = arg;
+
+	if (list_empty(&work->async_request_entry)) {
+		spin_lock(&conn->request_lock);
+		list_add_tail(&work->async_request_entry, &conn->async_requests);
+		spin_unlock(&conn->request_lock);
+	}
+
+	return 0;
+}
+
+void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
+{
+	struct smb2_hdr *rsp_hdr;
+
+	rsp_hdr = work->response_buf;
+	smb2_set_err_rsp(work);
+	rsp_hdr->Status = status;
+
+	work->multiRsp = 1;
+	ksmbd_conn_write(work);
+	rsp_hdr->Status = 0;
+	work->multiRsp = 0;
+}
+
+static __le32 smb2_get_reparse_tag_special_file(umode_t mode)
+{
+	if (S_ISDIR(mode) || S_ISREG(mode))
+		return 0;
+
+	if (S_ISLNK(mode))
+		return IO_REPARSE_TAG_LX_SYMLINK_LE;
+	else if (S_ISFIFO(mode))
+		return IO_REPARSE_TAG_LX_FIFO_LE;
+	else if (S_ISSOCK(mode))
+		return IO_REPARSE_TAG_AF_UNIX_LE;
+	else if (S_ISCHR(mode))
+		return IO_REPARSE_TAG_LX_CHR_LE;
+	else if (S_ISBLK(mode))
+		return IO_REPARSE_TAG_LX_BLK_LE;
+
+	return 0;
+}
+
+/**
+ * smb2_get_dos_mode() - get file mode in dos format from unix mode
+ * @stat:	kstat containing file mode
+ * @attribute:	attribute flags
+ *
+ * Return:      converted dos mode
+ */
+static int smb2_get_dos_mode(struct kstat *stat, int attribute)
+{
+	int attr = 0;
+
+	if (S_ISDIR(stat->mode)) {
+		attr = ATTR_DIRECTORY |
+			(attribute & (ATTR_HIDDEN | ATTR_SYSTEM));
+	} else {
+		attr = (attribute & 0x00005137) | ATTR_ARCHIVE;
+		attr &= ~(ATTR_DIRECTORY);
+		if (S_ISREG(stat->mode) && (server_conf.share_fake_fscaps &
+				FILE_SUPPORTS_SPARSE_FILES))
+			attr |= ATTR_SPARSE;
+
+		if (smb2_get_reparse_tag_special_file(stat->mode))
+			attr |= ATTR_REPARSE;
+	}
+
+	return attr;
+}
+
+static void build_preauth_ctxt(struct smb2_preauth_neg_context *pneg_ctxt,
+			       __le16 hash_id)
+{
+	pneg_ctxt->ContextType = SMB2_PREAUTH_INTEGRITY_CAPABILITIES;
+	pneg_ctxt->DataLength = cpu_to_le16(38);
+	pneg_ctxt->HashAlgorithmCount = cpu_to_le16(1);
+	pneg_ctxt->Reserved = cpu_to_le32(0);
+	pneg_ctxt->SaltLength = cpu_to_le16(SMB311_SALT_SIZE);
+	get_random_bytes(pneg_ctxt->Salt, SMB311_SALT_SIZE);
+	pneg_ctxt->HashAlgorithms = hash_id;
+}
+
+static void build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt,
+			       __le16 cipher_type)
+{
+	pneg_ctxt->ContextType = SMB2_ENCRYPTION_CAPABILITIES;
+	pneg_ctxt->DataLength = cpu_to_le16(4);
+	pneg_ctxt->Reserved = cpu_to_le32(0);
+	pneg_ctxt->CipherCount = cpu_to_le16(1);
+	pneg_ctxt->Ciphers[0] = cipher_type;
+}
+
+static void build_compression_ctxt(struct smb2_compression_ctx *pneg_ctxt,
+				   __le16 comp_algo)
+{
+	pneg_ctxt->ContextType = SMB2_COMPRESSION_CAPABILITIES;
+	pneg_ctxt->DataLength =
+		cpu_to_le16(sizeof(struct smb2_compression_ctx)
+			- sizeof(struct smb2_neg_context));
+	pneg_ctxt->Reserved = cpu_to_le32(0);
+	pneg_ctxt->CompressionAlgorithmCount = cpu_to_le16(1);
+	pneg_ctxt->Reserved1 = cpu_to_le32(0);
+	pneg_ctxt->CompressionAlgorithms[0] = comp_algo;
+}
+
+static void build_posix_ctxt(struct smb2_posix_neg_context *pneg_ctxt)
+{
+	pneg_ctxt->ContextType = SMB2_POSIX_EXTENSIONS_AVAILABLE;
+	pneg_ctxt->DataLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
+	/* SMB2_CREATE_TAG_POSIX is "0x93AD25509CB411E7B42383DE968BCD7C" */
+	pneg_ctxt->Name[0] = 0x93;
+	pneg_ctxt->Name[1] = 0xAD;
+	pneg_ctxt->Name[2] = 0x25;
+	pneg_ctxt->Name[3] = 0x50;
+	pneg_ctxt->Name[4] = 0x9C;
+	pneg_ctxt->Name[5] = 0xB4;
+	pneg_ctxt->Name[6] = 0x11;
+	pneg_ctxt->Name[7] = 0xE7;
+	pneg_ctxt->Name[8] = 0xB4;
+	pneg_ctxt->Name[9] = 0x23;
+	pneg_ctxt->Name[10] = 0x83;
+	pneg_ctxt->Name[11] = 0xDE;
+	pneg_ctxt->Name[12] = 0x96;
+	pneg_ctxt->Name[13] = 0x8B;
+	pneg_ctxt->Name[14] = 0xCD;
+	pneg_ctxt->Name[15] = 0x7C;
+}
+
+static void assemble_neg_contexts(struct ksmbd_conn *conn,
+				  struct smb2_negotiate_rsp *rsp)
+{
+	/* +4 is to account for the RFC1001 len field */
+	char *pneg_ctxt = (char *)rsp +
+			le32_to_cpu(rsp->NegotiateContextOffset) + 4;
+	int neg_ctxt_cnt = 1;
+	int ctxt_size;
+
+	ksmbd_debug(SMB,
+		    "assemble SMB2_PREAUTH_INTEGRITY_CAPABILITIES context\n");
+	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt,
+			   conn->preauth_info->Preauth_HashId);
+	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
+	inc_rfc1001_len(rsp, AUTH_GSS_PADDING);
+	ctxt_size = sizeof(struct smb2_preauth_neg_context);
+	/* Round to 8 byte boundary */
+	pneg_ctxt += round_up(sizeof(struct smb2_preauth_neg_context), 8);
+
+	if (conn->cipher_type) {
+		ctxt_size = round_up(ctxt_size, 8);
+		ksmbd_debug(SMB,
+			    "assemble SMB2_ENCRYPTION_CAPABILITIES context\n");
+		build_encrypt_ctxt((struct smb2_encryption_neg_context *)pneg_ctxt,
+				   conn->cipher_type);
+		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		ctxt_size += sizeof(struct smb2_encryption_neg_context);
+		/* Round to 8 byte boundary */
+		pneg_ctxt +=
+			round_up(sizeof(struct smb2_encryption_neg_context),
+				 8);
+	}
+
+	if (conn->compress_algorithm) {
+		ctxt_size = round_up(ctxt_size, 8);
+		ksmbd_debug(SMB,
+			    "assemble SMB2_COMPRESSION_CAPABILITIES context\n");
+		/* Temporarily set to SMB3_COMPRESS_NONE */
+		build_compression_ctxt((struct smb2_compression_ctx *)pneg_ctxt,
+				       conn->compress_algorithm);
+		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		ctxt_size += sizeof(struct smb2_compression_ctx);
+		/* Round to 8 byte boundary */
+		pneg_ctxt += round_up(sizeof(struct smb2_compression_ctx), 8);
+	}
+
+	if (conn->posix_ext_supported) {
+		ctxt_size = round_up(ctxt_size, 8);
+		ksmbd_debug(SMB,
+			    "assemble SMB2_POSIX_EXTENSIONS_AVAILABLE context\n");
+		build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ctxt);
+		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		ctxt_size += sizeof(struct smb2_posix_neg_context);
+	}
+
+	inc_rfc1001_len(rsp, ctxt_size);
+}
+
+static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
+				  struct smb2_preauth_neg_context *pneg_ctxt)
+{
+	__le32 err = STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP;
+
+	if (pneg_ctxt->HashAlgorithms == SMB2_PREAUTH_INTEGRITY_SHA512) {
+		conn->preauth_info->Preauth_HashId =
+			SMB2_PREAUTH_INTEGRITY_SHA512;
+		err = STATUS_SUCCESS;
+	}
+
+	return err;
+}
+
+static int decode_encrypt_ctxt(struct ksmbd_conn *conn,
+			       struct smb2_encryption_neg_context *pneg_ctxt)
+{
+	int i;
+	int cph_cnt = le16_to_cpu(pneg_ctxt->CipherCount);
+
+	conn->cipher_type = 0;
+
+	if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION))
+		goto out;
+
+	for (i = 0; i < cph_cnt; i++) {
+		if (pneg_ctxt->Ciphers[i] == SMB2_ENCRYPTION_AES128_GCM ||
+		    pneg_ctxt->Ciphers[i] == SMB2_ENCRYPTION_AES128_CCM ||
+		    pneg_ctxt->Ciphers[i] == SMB2_ENCRYPTION_AES256_CCM ||
+		    pneg_ctxt->Ciphers[i] == SMB2_ENCRYPTION_AES256_GCM) {
+			ksmbd_debug(SMB, "Cipher ID = 0x%x\n",
+				    pneg_ctxt->Ciphers[i]);
+			conn->cipher_type = pneg_ctxt->Ciphers[i];
+			break;
+		}
+	}
+
+out:
+	/*
+	 * Return encrypt context size in request.
+	 * So need to plus extra number of ciphers size.
+	 */
+	return sizeof(struct smb2_encryption_neg_context) +
+		((cph_cnt - 1) * 2);
+}
+
+static int decode_compress_ctxt(struct ksmbd_conn *conn,
+				struct smb2_compression_ctx *pneg_ctxt)
+{
+	int algo_cnt = le16_to_cpu(pneg_ctxt->CompressionAlgorithmCount);
+
+	conn->compress_algorithm = SMB3_COMPRESS_NONE;
+
+	/*
+	 * Return compression context size in request.
+	 * So need to plus extra number of CompressionAlgorithms size.
+	 */
+	return sizeof(struct smb2_encryption_neg_context) +
+		((algo_cnt - 1) * 2);
+}
+
+static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
+				      struct smb2_negotiate_req *req)
+{
+	int i = 0;
+	__le32 status = 0;
+	/* +4 is to account for the RFC1001 len field */
+	char *pneg_ctxt = (char *)req +
+			le32_to_cpu(req->NegotiateContextOffset) + 4;
+	__le16 *ContextType = (__le16 *)pneg_ctxt;
+	int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
+	int ctxt_size;
+
+	ksmbd_debug(SMB, "negotiate context count = %d\n", neg_ctxt_cnt);
+	status = STATUS_INVALID_PARAMETER;
+	while (i++ < neg_ctxt_cnt) {
+		if (*ContextType == SMB2_PREAUTH_INTEGRITY_CAPABILITIES) {
+			ksmbd_debug(SMB,
+				    "deassemble SMB2_PREAUTH_INTEGRITY_CAPABILITIES context\n");
+			if (conn->preauth_info->Preauth_HashId)
+				break;
+
+			status = decode_preauth_ctxt(conn,
+						     (struct smb2_preauth_neg_context *)pneg_ctxt);
+			pneg_ctxt += DIV_ROUND_UP(sizeof(struct smb2_preauth_neg_context), 8) * 8;
+		} else if (*ContextType == SMB2_ENCRYPTION_CAPABILITIES) {
+			ksmbd_debug(SMB,
+				    "deassemble SMB2_ENCRYPTION_CAPABILITIES context\n");
+			if (conn->cipher_type)
+				break;
+
+			ctxt_size = decode_encrypt_ctxt(conn,
+				(struct smb2_encryption_neg_context *)pneg_ctxt);
+			pneg_ctxt += DIV_ROUND_UP(ctxt_size, 8) * 8;
+		} else if (*ContextType == SMB2_COMPRESSION_CAPABILITIES) {
+			ksmbd_debug(SMB,
+				    "deassemble SMB2_COMPRESSION_CAPABILITIES context\n");
+			if (conn->compress_algorithm)
+				break;
+
+			ctxt_size = decode_compress_ctxt(conn,
+				(struct smb2_compression_ctx *)pneg_ctxt);
+			pneg_ctxt += DIV_ROUND_UP(ctxt_size, 8) * 8;
+		} else if (*ContextType == SMB2_NETNAME_NEGOTIATE_CONTEXT_ID) {
+			ksmbd_debug(SMB,
+				    "deassemble SMB2_NETNAME_NEGOTIATE_CONTEXT_ID context\n");
+			ctxt_size = sizeof(struct smb2_netname_neg_context);
+			ctxt_size += DIV_ROUND_UP(le16_to_cpu(((struct smb2_netname_neg_context *)
+							       pneg_ctxt)->DataLength), 8) * 8;
+			pneg_ctxt += ctxt_size;
+		} else if (*ContextType == SMB2_POSIX_EXTENSIONS_AVAILABLE) {
+			ksmbd_debug(SMB,
+				    "deassemble SMB2_POSIX_EXTENSIONS_AVAILABLE context\n");
+			conn->posix_ext_supported = true;
+			pneg_ctxt += DIV_ROUND_UP(sizeof(struct smb2_posix_neg_context), 8) * 8;
+		}
+		ContextType = (__le16 *)pneg_ctxt;
+
+		if (status != STATUS_SUCCESS)
+			break;
+	}
+	return status;
+}
+
+/**
+ * smb2_handle_negotiate() - handler for smb2 negotiate command
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0
+ */
+int smb2_handle_negotiate(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_negotiate_req *req = work->request_buf;
+	struct smb2_negotiate_rsp *rsp = work->response_buf;
+	int rc = 0;
+	__le32 status;
+
+	ksmbd_debug(SMB, "Received negotiate request\n");
+	conn->need_neg = false;
+	if (ksmbd_conn_good(work)) {
+		pr_err("conn->tcp_status is already in CifsGood State\n");
+		work->send_no_response = 1;
+		return rc;
+	}
+
+	if (req->DialectCount == 0) {
+		pr_err("malformed packet\n");
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		rc = -EINVAL;
+		goto err_out;
+	}
+
+	conn->cli_cap = le32_to_cpu(req->Capabilities);
+	switch (conn->dialect) {
+	case SMB311_PROT_ID:
+		conn->preauth_info =
+			kzalloc(sizeof(struct preauth_integrity_info),
+				GFP_KERNEL);
+		if (!conn->preauth_info) {
+			rc = -ENOMEM;
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto err_out;
+		}
+
+		status = deassemble_neg_contexts(conn, req);
+		if (status != STATUS_SUCCESS) {
+			pr_err("deassemble_neg_contexts error(0x%x)\n",
+			       status);
+			rsp->hdr.Status = status;
+			rc = -EINVAL;
+			goto err_out;
+		}
+
+		rc = init_smb3_11_server(conn);
+		if (rc < 0) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto err_out;
+		}
+
+		ksmbd_gen_preauth_integrity_hash(conn,
+						 work->request_buf,
+						 conn->preauth_info->Preauth_HashValue);
+		rsp->NegotiateContextOffset =
+				cpu_to_le32(OFFSET_OF_NEG_CONTEXT);
+		assemble_neg_contexts(conn, rsp);
+		break;
+	case SMB302_PROT_ID:
+		init_smb3_02_server(conn);
+		break;
+	case SMB30_PROT_ID:
+		init_smb3_0_server(conn);
+		break;
+	case SMB21_PROT_ID:
+		init_smb2_1_server(conn);
+		break;
+	case SMB20_PROT_ID:
+		rc = init_smb2_0_server(conn);
+		if (rc) {
+			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+			goto err_out;
+		}
+		break;
+	case SMB2X_PROT_ID:
+	case BAD_PROT_ID:
+	default:
+		ksmbd_debug(SMB, "Server dialect :0x%x not supported\n",
+			    conn->dialect);
+		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+		rc = -EINVAL;
+		goto err_out;
+	}
+	rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+
+	/* For stats */
+	conn->connection_type = conn->dialect;
+
+	rsp->MaxTransactSize = cpu_to_le32(conn->vals->max_trans_size);
+	rsp->MaxReadSize = cpu_to_le32(conn->vals->max_read_size);
+	rsp->MaxWriteSize = cpu_to_le32(conn->vals->max_write_size);
+
+	if (conn->dialect > SMB20_PROT_ID) {
+		memcpy(conn->ClientGUID, req->ClientGUID,
+		       SMB2_CLIENT_GUID_SIZE);
+		conn->cli_sec_mode = le16_to_cpu(req->SecurityMode);
+	}
+
+	rsp->StructureSize = cpu_to_le16(65);
+	rsp->DialectRevision = cpu_to_le16(conn->dialect);
+	/* Not setting conn guid rsp->ServerGUID, as it
+	 * not used by client for identifying server
+	 */
+	memset(rsp->ServerGUID, 0, SMB2_CLIENT_GUID_SIZE);
+
+	rsp->SystemTime = cpu_to_le64(ksmbd_systime());
+	rsp->ServerStartTime = 0;
+	ksmbd_debug(SMB, "negotiate context offset %d, count %d\n",
+		    le32_to_cpu(rsp->NegotiateContextOffset),
+		    le16_to_cpu(rsp->NegotiateContextCount));
+
+	rsp->SecurityBufferOffset = cpu_to_le16(128);
+	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
+	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
+				  sizeof(rsp->hdr.smb2_buf_length)) +
+				   le16_to_cpu(rsp->SecurityBufferOffset));
+	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
+			sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
+			 AUTH_GSS_LENGTH);
+	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
+	conn->use_spnego = true;
+
+	if ((server_conf.signing == KSMBD_CONFIG_OPT_AUTO ||
+	     server_conf.signing == KSMBD_CONFIG_OPT_DISABLED) &&
+	    req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED_LE)
+		conn->sign = true;
+	else if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY) {
+		server_conf.enforced_signing = true;
+		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
+		conn->sign = true;
+	}
+
+	conn->srv_sec_mode = le16_to_cpu(rsp->SecurityMode);
+	ksmbd_conn_set_need_negotiate(work);
+
+err_out:
+	if (rc < 0)
+		smb2_set_err_rsp(work);
+
+	return rc;
+}
+
+static int alloc_preauth_hash(struct ksmbd_session *sess,
+			      struct ksmbd_conn *conn)
+{
+	if (sess->Preauth_HashValue)
+		return 0;
+
+	sess->Preauth_HashValue = kmemdup(conn->preauth_info->Preauth_HashValue,
+					  PREAUTH_HASHVALUE_SIZE, GFP_KERNEL);
+	if (!sess->Preauth_HashValue)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int generate_preauth_hash(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	u8 *preauth_hash;
+
+	if (conn->dialect != SMB311_PROT_ID)
+		return 0;
+
+	if (conn->binding) {
+		struct preauth_session *preauth_sess;
+
+		preauth_sess = ksmbd_preauth_session_lookup(conn, sess->id);
+		if (!preauth_sess) {
+			preauth_sess = ksmbd_preauth_session_alloc(conn, sess->id);
+			if (!preauth_sess)
+				return -ENOMEM;
+		}
+
+		preauth_hash = preauth_sess->Preauth_HashValue;
+	} else {
+		if (!sess->Preauth_HashValue)
+			if (alloc_preauth_hash(sess, conn))
+				return -ENOMEM;
+		preauth_hash = sess->Preauth_HashValue;
+	}
+
+	ksmbd_gen_preauth_integrity_hash(conn, work->request_buf, preauth_hash);
+	return 0;
+}
+
+static int decode_negotiation_token(struct ksmbd_work *work,
+				    struct negotiate_message *negblob)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_sess_setup_req *req;
+	int sz;
+
+	if (!conn->use_spnego)
+		return -EINVAL;
+
+	req = work->request_buf;
+	sz = le16_to_cpu(req->SecurityBufferLength);
+
+	if (ksmbd_decode_negTokenInit((char *)negblob, sz, conn)) {
+		if (ksmbd_decode_negTokenTarg((char *)negblob, sz, conn)) {
+			conn->auth_mechs |= KSMBD_AUTH_NTLMSSP;
+			conn->preferred_auth_mech = KSMBD_AUTH_NTLMSSP;
+			conn->use_spnego = false;
+		}
+	}
+	return 0;
+}
+
+static int ntlm_negotiate(struct ksmbd_work *work,
+			  struct negotiate_message *negblob)
+{
+	struct smb2_sess_setup_req *req = work->request_buf;
+	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct challenge_message *chgblob;
+	unsigned char *spnego_blob = NULL;
+	u16 spnego_blob_len;
+	char *neg_blob;
+	int sz, rc;
+
+	ksmbd_debug(SMB, "negotiate phase\n");
+	sz = le16_to_cpu(req->SecurityBufferLength);
+	rc = ksmbd_decode_ntlmssp_neg_blob(negblob, sz, work->sess);
+	if (rc)
+		return rc;
+
+	sz = le16_to_cpu(rsp->SecurityBufferOffset);
+	chgblob =
+		(struct challenge_message *)((char *)&rsp->hdr.ProtocolId + sz);
+	memset(chgblob, 0, sizeof(struct challenge_message));
+
+	if (!work->conn->use_spnego) {
+		sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->sess);
+		if (sz < 0)
+			return -ENOMEM;
+
+		rsp->SecurityBufferLength = cpu_to_le16(sz);
+		return 0;
+	}
+
+	sz = sizeof(struct challenge_message);
+	sz += (strlen(ksmbd_netbios_name()) * 2 + 1 + 4) * 6;
+
+	neg_blob = kzalloc(sz, GFP_KERNEL);
+	if (!neg_blob)
+		return -ENOMEM;
+
+	chgblob = (struct challenge_message *)neg_blob;
+	sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->sess);
+	if (sz < 0) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = build_spnego_ntlmssp_neg_blob(&spnego_blob, &spnego_blob_len,
+					   neg_blob, sz);
+	if (rc) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	sz = le16_to_cpu(rsp->SecurityBufferOffset);
+	memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
+	rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
+
+out:
+	kfree(spnego_blob);
+	kfree(neg_blob);
+	return rc;
+}
+
+static struct authenticate_message *user_authblob(struct ksmbd_conn *conn,
+						  struct smb2_sess_setup_req *req)
+{
+	int sz;
+
+	if (conn->use_spnego && conn->mechToken)
+		return (struct authenticate_message *)conn->mechToken;
+
+	sz = le16_to_cpu(req->SecurityBufferOffset);
+	return (struct authenticate_message *)((char *)&req->hdr.ProtocolId
+					       + sz);
+}
+
+static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
+				       struct smb2_sess_setup_req *req)
+{
+	struct authenticate_message *authblob;
+	struct ksmbd_user *user;
+	char *name;
+	int sz;
+
+	authblob = user_authblob(conn, req);
+	sz = le32_to_cpu(authblob->UserName.BufferOffset);
+	name = smb_strndup_from_utf16((const char *)authblob + sz,
+				      le16_to_cpu(authblob->UserName.Length),
+				      true,
+				      conn->local_nls);
+	if (IS_ERR(name)) {
+		pr_err("cannot allocate memory\n");
+		return NULL;
+	}
+
+	ksmbd_debug(SMB, "session setup request for user %s\n", name);
+	user = ksmbd_login_user(name);
+	kfree(name);
+	return user;
+}
+
+static int ntlm_authenticate(struct ksmbd_work *work)
+{
+	struct smb2_sess_setup_req *req = work->request_buf;
+	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	struct channel *chann = NULL;
+	struct ksmbd_user *user;
+	u64 prev_id;
+	int sz, rc;
+
+	ksmbd_debug(SMB, "authenticate phase\n");
+	if (conn->use_spnego) {
+		unsigned char *spnego_blob;
+		u16 spnego_blob_len;
+
+		rc = build_spnego_ntlmssp_auth_blob(&spnego_blob,
+						    &spnego_blob_len,
+						    0);
+		if (rc)
+			return -ENOMEM;
+
+		sz = le16_to_cpu(rsp->SecurityBufferOffset);
+		memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
+		rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
+		kfree(spnego_blob);
+		inc_rfc1001_len(rsp, spnego_blob_len - 1);
+	}
+
+	user = session_user(conn, req);
+	if (!user) {
+		ksmbd_debug(SMB, "Unknown user name or an error\n");
+		rsp->hdr.Status = STATUS_LOGON_FAILURE;
+		return -EINVAL;
+	}
+
+	/* Check for previous session */
+	prev_id = le64_to_cpu(req->PreviousSessionId);
+	if (prev_id && prev_id != sess->id)
+		destroy_previous_session(user, prev_id);
+
+	if (sess->state == SMB2_SESSION_VALID) {
+		/*
+		 * Reuse session if anonymous try to connect
+		 * on reauthetication.
+		 */
+		if (ksmbd_anonymous_user(user)) {
+			ksmbd_free_user(user);
+			return 0;
+		}
+		ksmbd_free_user(sess->user);
+	}
+
+	sess->user = user;
+	if (user_guest(sess->user)) {
+		if (conn->sign) {
+			ksmbd_debug(SMB, "Guest login not allowed when signing enabled\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return -EACCES;
+		}
+
+		rsp->SessionFlags = SMB2_SESSION_FLAG_IS_GUEST_LE;
+	} else {
+		struct authenticate_message *authblob;
+
+		authblob = user_authblob(conn, req);
+		sz = le16_to_cpu(req->SecurityBufferLength);
+		rc = ksmbd_decode_ntlmssp_auth_blob(authblob, sz, sess);
+		if (rc) {
+			set_user_flag(sess->user, KSMBD_USER_FLAG_BAD_PASSWORD);
+			ksmbd_debug(SMB, "authentication failed\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return -EINVAL;
+		}
+
+		/*
+		 * If session state is SMB2_SESSION_VALID, We can assume
+		 * that it is reauthentication. And the user/password
+		 * has been verified, so return it here.
+		 */
+		if (sess->state == SMB2_SESSION_VALID) {
+			if (conn->binding)
+				goto binding_session;
+			return 0;
+		}
+
+		if ((conn->sign || server_conf.enforced_signing) ||
+		    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
+			sess->sign = true;
+
+		if (conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION &&
+		    conn->ops->generate_encryptionkey &&
+		    !(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
+			rc = conn->ops->generate_encryptionkey(sess);
+			if (rc) {
+				ksmbd_debug(SMB,
+					    "SMB3 encryption key generation failed\n");
+				rsp->hdr.Status = STATUS_LOGON_FAILURE;
+				return rc;
+			}
+			sess->enc = true;
+			rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+			/*
+			 * signing is disable if encryption is enable
+			 * on this session
+			 */
+			sess->sign = false;
+		}
+	}
+
+binding_session:
+	if (conn->dialect >= SMB30_PROT_ID) {
+		chann = lookup_chann_list(sess, conn);
+		if (!chann) {
+			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
+			if (!chann)
+				return -ENOMEM;
+
+			chann->conn = conn;
+			INIT_LIST_HEAD(&chann->chann_list);
+			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
+		}
+	}
+
+	if (conn->ops->generate_signingkey) {
+		rc = conn->ops->generate_signingkey(sess, conn);
+		if (rc) {
+			ksmbd_debug(SMB, "SMB3 signing key generation failed\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return rc;
+		}
+	}
+
+	if (conn->dialect > SMB20_PROT_ID) {
+		if (!ksmbd_conn_lookup_dialect(conn)) {
+			pr_err("fail to verify the dialect\n");
+			rsp->hdr.Status = STATUS_USER_SESSION_DELETED;
+			return -EPERM;
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+static int krb5_authenticate(struct ksmbd_work *work)
+{
+	struct smb2_sess_setup_req *req = work->request_buf;
+	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	char *in_blob, *out_blob;
+	struct channel *chann = NULL;
+	u64 prev_sess_id;
+	int in_len, out_len;
+	int retval;
+
+	in_blob = (char *)&req->hdr.ProtocolId +
+		le16_to_cpu(req->SecurityBufferOffset);
+	in_len = le16_to_cpu(req->SecurityBufferLength);
+	out_blob = (char *)&rsp->hdr.ProtocolId +
+		le16_to_cpu(rsp->SecurityBufferOffset);
+	out_len = work->response_sz -
+		offsetof(struct smb2_hdr, smb2_buf_length) -
+		le16_to_cpu(rsp->SecurityBufferOffset);
+
+	/* Check previous session */
+	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
+	if (prev_sess_id && prev_sess_id != sess->id)
+		destroy_previous_session(sess->user, prev_sess_id);
+
+	if (sess->state == SMB2_SESSION_VALID)
+		ksmbd_free_user(sess->user);
+
+	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
+					 out_blob, &out_len);
+	if (retval) {
+		ksmbd_debug(SMB, "krb5 authentication failed\n");
+		rsp->hdr.Status = STATUS_LOGON_FAILURE;
+		return retval;
+	}
+	rsp->SecurityBufferLength = cpu_to_le16(out_len);
+	inc_rfc1001_len(rsp, out_len - 1);
+
+	if ((conn->sign || server_conf.enforced_signing) ||
+	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
+		sess->sign = true;
+
+	if ((conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) &&
+	    conn->ops->generate_encryptionkey) {
+		retval = conn->ops->generate_encryptionkey(sess);
+		if (retval) {
+			ksmbd_debug(SMB,
+				    "SMB3 encryption key generation failed\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return retval;
+		}
+		sess->enc = true;
+		rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+		sess->sign = false;
+	}
+
+	if (conn->dialect >= SMB30_PROT_ID) {
+		chann = lookup_chann_list(sess, conn);
+		if (!chann) {
+			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
+			if (!chann)
+				return -ENOMEM;
+
+			chann->conn = conn;
+			INIT_LIST_HEAD(&chann->chann_list);
+			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
+		}
+	}
+
+	if (conn->ops->generate_signingkey) {
+		retval = conn->ops->generate_signingkey(sess, conn);
+		if (retval) {
+			ksmbd_debug(SMB, "SMB3 signing key generation failed\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return retval;
+		}
+	}
+
+	if (conn->dialect > SMB20_PROT_ID) {
+		if (!ksmbd_conn_lookup_dialect(conn)) {
+			pr_err("fail to verify the dialect\n");
+			rsp->hdr.Status = STATUS_USER_SESSION_DELETED;
+			return -EPERM;
+		}
+	}
+	return 0;
+}
+#else
+static int krb5_authenticate(struct ksmbd_work *work)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+int smb2_sess_setup(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_sess_setup_req *req = work->request_buf;
+	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct ksmbd_session *sess;
+	struct negotiate_message *negblob;
+	int rc = 0;
+
+	ksmbd_debug(SMB, "Received request for session setup\n");
+
+	rsp->StructureSize = cpu_to_le16(9);
+	rsp->SessionFlags = 0;
+	rsp->SecurityBufferOffset = cpu_to_le16(72);
+	rsp->SecurityBufferLength = 0;
+	inc_rfc1001_len(rsp, 9);
+
+	if (!req->hdr.SessionId) {
+		sess = ksmbd_smb2_session_create();
+		if (!sess) {
+			rc = -ENOMEM;
+			goto out_err;
+		}
+		rsp->hdr.SessionId = cpu_to_le64(sess->id);
+		ksmbd_session_register(conn, sess);
+	} else if (conn->dialect >= SMB30_PROT_ID &&
+		   (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
+		   req->Flags & SMB2_SESSION_REQ_FLAG_BINDING) {
+		u64 sess_id = le64_to_cpu(req->hdr.SessionId);
+
+		sess = ksmbd_session_lookup_slowpath(sess_id);
+		if (!sess) {
+			rc = -ENOENT;
+			goto out_err;
+		}
+
+		if (conn->dialect != sess->conn->dialect) {
+			rc = -EINVAL;
+			goto out_err;
+		}
+
+		if (!(req->hdr.Flags & SMB2_FLAGS_SIGNED)) {
+			rc = -EINVAL;
+			goto out_err;
+		}
+
+		if (strncmp(conn->ClientGUID, sess->conn->ClientGUID,
+			    SMB2_CLIENT_GUID_SIZE)) {
+			rc = -ENOENT;
+			goto out_err;
+		}
+
+		if (sess->state == SMB2_SESSION_IN_PROGRESS) {
+			rc = -EACCES;
+			goto out_err;
+		}
+
+		if (sess->state == SMB2_SESSION_EXPIRED) {
+			rc = -EFAULT;
+			goto out_err;
+		}
+
+		if (ksmbd_session_lookup(conn, sess_id)) {
+			rc = -EACCES;
+			goto out_err;
+		}
+
+		conn->binding = true;
+	} else if ((conn->dialect < SMB30_PROT_ID ||
+		    server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
+		   (req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
+		sess = NULL;
+		rc = -EACCES;
+		goto out_err;
+	} else {
+		sess = ksmbd_session_lookup(conn,
+					    le64_to_cpu(req->hdr.SessionId));
+		if (!sess) {
+			rc = -ENOENT;
+			goto out_err;
+		}
+	}
+	work->sess = sess;
+
+	if (sess->state == SMB2_SESSION_EXPIRED)
+		sess->state = SMB2_SESSION_IN_PROGRESS;
+
+	negblob = (struct negotiate_message *)((char *)&req->hdr.ProtocolId +
+			le16_to_cpu(req->SecurityBufferOffset));
+
+	if (decode_negotiation_token(work, negblob) == 0) {
+		if (conn->mechToken)
+			negblob = (struct negotiate_message *)conn->mechToken;
+	}
+
+	if (server_conf.auth_mechs & conn->auth_mechs) {
+		rc = generate_preauth_hash(work);
+		if (rc)
+			goto out_err;
+
+		if (conn->preferred_auth_mech &
+				(KSMBD_AUTH_KRB5 | KSMBD_AUTH_MSKRB5)) {
+			rc = krb5_authenticate(work);
+			if (rc) {
+				rc = -EINVAL;
+				goto out_err;
+			}
+
+			ksmbd_conn_set_good(work);
+			sess->state = SMB2_SESSION_VALID;
+			kfree(sess->Preauth_HashValue);
+			sess->Preauth_HashValue = NULL;
+		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
+			if (negblob->MessageType == NtLmNegotiate) {
+				rc = ntlm_negotiate(work, negblob);
+				if (rc)
+					goto out_err;
+				rsp->hdr.Status =
+					STATUS_MORE_PROCESSING_REQUIRED;
+				/*
+				 * Note: here total size -1 is done as an
+				 * adjustment for 0 size blob
+				 */
+				inc_rfc1001_len(rsp, le16_to_cpu(rsp->SecurityBufferLength) - 1);
+
+			} else if (negblob->MessageType == NtLmAuthenticate) {
+				rc = ntlm_authenticate(work);
+				if (rc)
+					goto out_err;
+
+				ksmbd_conn_set_good(work);
+				sess->state = SMB2_SESSION_VALID;
+				if (conn->binding) {
+					struct preauth_session *preauth_sess;
+
+					preauth_sess =
+						ksmbd_preauth_session_lookup(conn, sess->id);
+					if (preauth_sess) {
+						list_del(&preauth_sess->preauth_entry);
+						kfree(preauth_sess);
+					}
+				}
+				kfree(sess->Preauth_HashValue);
+				sess->Preauth_HashValue = NULL;
+			}
+		} else {
+			/* TODO: need one more negotiation */
+			pr_err("Not support the preferred authentication\n");
+			rc = -EINVAL;
+		}
+	} else {
+		pr_err("Not support authentication\n");
+		rc = -EINVAL;
+	}
+
+out_err:
+	if (rc == -EINVAL)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	else if (rc == -ENOENT)
+		rsp->hdr.Status = STATUS_USER_SESSION_DELETED;
+	else if (rc == -EACCES)
+		rsp->hdr.Status = STATUS_REQUEST_NOT_ACCEPTED;
+	else if (rc == -EFAULT)
+		rsp->hdr.Status = STATUS_NETWORK_SESSION_EXPIRED;
+	else if (rc)
+		rsp->hdr.Status = STATUS_LOGON_FAILURE;
+
+	if (conn->use_spnego && conn->mechToken) {
+		kfree(conn->mechToken);
+		conn->mechToken = NULL;
+	}
+
+	if (rc < 0 && sess) {
+		ksmbd_session_destroy(sess);
+		work->sess = NULL;
+	}
+
+	return rc;
+}
+
+/**
+ * smb2_tree_connect() - handler for smb2 tree connect command
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+int smb2_tree_connect(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_tree_connect_req *req = work->request_buf;
+	struct smb2_tree_connect_rsp *rsp = work->response_buf;
+	struct ksmbd_session *sess = work->sess;
+	char *treename = NULL, *name = NULL;
+	struct ksmbd_tree_conn_status status;
+	struct ksmbd_share_config *share;
+	int rc = -EINVAL;
+
+	treename = smb_strndup_from_utf16(req->Buffer,
+					  le16_to_cpu(req->PathLength), true,
+					  conn->local_nls);
+	if (IS_ERR(treename)) {
+		pr_err("treename is NULL\n");
+		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
+		goto out_err1;
+	}
+
+	name = ksmbd_extract_sharename(treename);
+	if (IS_ERR(name)) {
+		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
+		goto out_err1;
+	}
+
+	ksmbd_debug(SMB, "tree connect request for tree %s treename %s\n",
+		    name, treename);
+
+	status = ksmbd_tree_conn_connect(sess, name);
+	if (status.ret == KSMBD_TREE_CONN_STATUS_OK)
+		rsp->hdr.Id.SyncId.TreeId = cpu_to_le32(status.tree_conn->id);
+	else
+		goto out_err1;
+
+	share = status.tree_conn->share_conf;
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC share path request\n");
+		rsp->ShareType = SMB2_SHARE_TYPE_PIPE;
+		rsp->MaximalAccess = FILE_READ_DATA_LE | FILE_READ_EA_LE |
+			FILE_EXECUTE_LE | FILE_READ_ATTRIBUTES_LE |
+			FILE_DELETE_LE | FILE_READ_CONTROL_LE |
+			FILE_WRITE_DAC_LE | FILE_WRITE_OWNER_LE |
+			FILE_SYNCHRONIZE_LE;
+	} else {
+		rsp->ShareType = SMB2_SHARE_TYPE_DISK;
+		rsp->MaximalAccess = FILE_READ_DATA_LE | FILE_READ_EA_LE |
+			FILE_EXECUTE_LE | FILE_READ_ATTRIBUTES_LE;
+		if (test_tree_conn_flag(status.tree_conn,
+					KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			rsp->MaximalAccess |= FILE_WRITE_DATA_LE |
+				FILE_APPEND_DATA_LE | FILE_WRITE_EA_LE |
+				FILE_DELETE_LE | FILE_WRITE_ATTRIBUTES_LE |
+				FILE_DELETE_CHILD_LE | FILE_READ_CONTROL_LE |
+				FILE_WRITE_DAC_LE | FILE_WRITE_OWNER_LE |
+				FILE_SYNCHRONIZE_LE;
+		}
+	}
+
+	status.tree_conn->maximal_access = le32_to_cpu(rsp->MaximalAccess);
+	if (conn->posix_ext_supported)
+		status.tree_conn->posix_extensions = true;
+
+out_err1:
+	rsp->StructureSize = cpu_to_le16(16);
+	rsp->Capabilities = 0;
+	rsp->Reserved = 0;
+	/* default manual caching */
+	rsp->ShareFlags = SMB2_SHAREFLAG_MANUAL_CACHING;
+	inc_rfc1001_len(rsp, 16);
+
+	if (!IS_ERR(treename))
+		kfree(treename);
+	if (!IS_ERR(name))
+		kfree(name);
+
+	switch (status.ret) {
+	case KSMBD_TREE_CONN_STATUS_OK:
+		rsp->hdr.Status = STATUS_SUCCESS;
+		rc = 0;
+		break;
+	case KSMBD_TREE_CONN_STATUS_NO_SHARE:
+		rsp->hdr.Status = STATUS_BAD_NETWORK_PATH;
+		break;
+	case -ENOMEM:
+	case KSMBD_TREE_CONN_STATUS_NOMEM:
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+		break;
+	case KSMBD_TREE_CONN_STATUS_ERROR:
+	case KSMBD_TREE_CONN_STATUS_TOO_MANY_CONNS:
+	case KSMBD_TREE_CONN_STATUS_TOO_MANY_SESSIONS:
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		break;
+	case -EINVAL:
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		break;
+	default:
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	}
+
+	return rc;
+}
+
+/**
+ * smb2_create_open_flags() - convert smb open flags to unix open flags
+ * @file_present:	is file already present
+ * @access:		file access flags
+ * @disposition:	file disposition flags
+ * @may_flags:		set with MAY_ flags
+ *
+ * Return:      file open flags
+ */
+static int smb2_create_open_flags(bool file_present, __le32 access,
+				  __le32 disposition,
+				  int *may_flags)
+{
+	int oflags = O_NONBLOCK | O_LARGEFILE;
+
+	if (access & FILE_READ_DESIRED_ACCESS_LE &&
+	    access & FILE_WRITE_DESIRE_ACCESS_LE) {
+		oflags |= O_RDWR;
+		*may_flags = MAY_OPEN | MAY_READ | MAY_WRITE;
+	} else if (access & FILE_WRITE_DESIRE_ACCESS_LE) {
+		oflags |= O_WRONLY;
+		*may_flags = MAY_OPEN | MAY_WRITE;
+	} else {
+		oflags |= O_RDONLY;
+		*may_flags = MAY_OPEN | MAY_READ;
+	}
+
+	if (access == FILE_READ_ATTRIBUTES_LE)
+		oflags |= O_PATH;
+
+	if (file_present) {
+		switch (disposition & FILE_CREATE_MASK_LE) {
+		case FILE_OPEN_LE:
+		case FILE_CREATE_LE:
+			break;
+		case FILE_SUPERSEDE_LE:
+		case FILE_OVERWRITE_LE:
+		case FILE_OVERWRITE_IF_LE:
+			oflags |= O_TRUNC;
+			break;
+		default:
+			break;
+		}
+	} else {
+		switch (disposition & FILE_CREATE_MASK_LE) {
+		case FILE_SUPERSEDE_LE:
+		case FILE_CREATE_LE:
+		case FILE_OPEN_IF_LE:
+		case FILE_OVERWRITE_IF_LE:
+			oflags |= O_CREAT;
+			break;
+		case FILE_OPEN_LE:
+		case FILE_OVERWRITE_LE:
+			oflags &= ~O_CREAT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return oflags;
+}
+
+/**
+ * smb2_tree_disconnect() - handler for smb tree connect request
+ * @work:	smb work containing request buffer
+ *
+ * Return:      0
+ */
+int smb2_tree_disconnect(struct ksmbd_work *work)
+{
+	struct smb2_tree_disconnect_rsp *rsp = work->response_buf;
+	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_tree_connect *tcon = work->tcon;
+
+	rsp->StructureSize = cpu_to_le16(4);
+	inc_rfc1001_len(rsp, 4);
+
+	ksmbd_debug(SMB, "request\n");
+
+	if (!tcon) {
+		struct smb2_tree_disconnect_req *req = work->request_buf;
+
+		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		smb2_set_err_rsp(work);
+		return 0;
+	}
+
+	ksmbd_close_tree_conn_fds(work);
+	ksmbd_tree_conn_disconnect(sess, tcon);
+	return 0;
+}
+
+/**
+ * smb2_session_logoff() - handler for session log off request
+ * @work:	smb work containing request buffer
+ *
+ * Return:      0
+ */
+int smb2_session_logoff(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_logoff_rsp *rsp = work->response_buf;
+	struct ksmbd_session *sess = work->sess;
+
+	rsp->StructureSize = cpu_to_le16(4);
+	inc_rfc1001_len(rsp, 4);
+
+	ksmbd_debug(SMB, "request\n");
+
+	/* Got a valid session, set connection state */
+	WARN_ON(sess->conn != conn);
+
+	/* setting CifsExiting here may race with start_tcp_sess */
+	ksmbd_conn_set_need_reconnect(work);
+	ksmbd_close_session_fds(work);
+	ksmbd_conn_wait_idle(conn);
+
+	if (ksmbd_tree_conn_session_logoff(sess)) {
+		struct smb2_logoff_req *req = work->request_buf;
+
+		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		smb2_set_err_rsp(work);
+		return 0;
+	}
+
+	ksmbd_destroy_file_table(&sess->file_table);
+	sess->state = SMB2_SESSION_EXPIRED;
+
+	ksmbd_free_user(sess->user);
+	sess->user = NULL;
+
+	/* let start_tcp_sess free connection info now */
+	ksmbd_conn_set_need_negotiate(work);
+	return 0;
+}
+
+/**
+ * create_smb2_pipe() - create IPC pipe
+ * @work:	smb work containing request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+static noinline int create_smb2_pipe(struct ksmbd_work *work)
+{
+	struct smb2_create_rsp *rsp = work->response_buf;
+	struct smb2_create_req *req = work->request_buf;
+	int id;
+	int err;
+	char *name;
+
+	name = smb_strndup_from_utf16(req->Buffer, le16_to_cpu(req->NameLength),
+				      1, work->conn->local_nls);
+	if (IS_ERR(name)) {
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+		err = PTR_ERR(name);
+		goto out;
+	}
+
+	id = ksmbd_session_rpc_open(work->sess, name);
+	if (id < 0) {
+		pr_err("Unable to open RPC pipe: %d\n", id);
+		err = id;
+		goto out;
+	}
+
+	rsp->hdr.Status = STATUS_SUCCESS;
+	rsp->StructureSize = cpu_to_le16(89);
+	rsp->OplockLevel = SMB2_OPLOCK_LEVEL_NONE;
+	rsp->Reserved = 0;
+	rsp->CreateAction = cpu_to_le32(FILE_OPENED);
+
+	rsp->CreationTime = cpu_to_le64(0);
+	rsp->LastAccessTime = cpu_to_le64(0);
+	rsp->ChangeTime = cpu_to_le64(0);
+	rsp->AllocationSize = cpu_to_le64(0);
+	rsp->EndofFile = cpu_to_le64(0);
+	rsp->FileAttributes = ATTR_NORMAL_LE;
+	rsp->Reserved2 = 0;
+	rsp->VolatileFileId = cpu_to_le64(id);
+	rsp->PersistentFileId = 0;
+	rsp->CreateContextsOffset = 0;
+	rsp->CreateContextsLength = 0;
+
+	inc_rfc1001_len(rsp, 88); /* StructureSize - 1*/
+	kfree(name);
+	return 0;
+
+out:
+	switch (err) {
+	case -EINVAL:
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		break;
+	case -ENOSPC:
+	case -ENOMEM:
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+		break;
+	}
+
+	if (!IS_ERR(name))
+		kfree(name);
+
+	smb2_set_err_rsp(work);
+	return err;
+}
+
+/**
+ * smb2_set_ea() - handler for setting extended attributes using set
+ *		info command
+ * @eabuf:	set info command buffer
+ * @path:	dentry path for get ea
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int smb2_set_ea(struct smb2_ea_info *eabuf, struct path *path)
+{
+	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	char *attr_name = NULL, *value;
+	int rc = 0;
+	int next = 0;
+
+	attr_name = kmalloc(XATTR_NAME_MAX + 1, GFP_KERNEL);
+	if (!attr_name)
+		return -ENOMEM;
+
+	do {
+		if (!eabuf->EaNameLength)
+			goto next;
+
+		ksmbd_debug(SMB,
+			    "name : <%s>, name_len : %u, value_len : %u, next : %u\n",
+			    eabuf->name, eabuf->EaNameLength,
+			    le16_to_cpu(eabuf->EaValueLength),
+			    le32_to_cpu(eabuf->NextEntryOffset));
+
+		if (eabuf->EaNameLength >
+		    (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN)) {
+			rc = -EINVAL;
+			break;
+		}
+
+		memcpy(attr_name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
+		memcpy(&attr_name[XATTR_USER_PREFIX_LEN], eabuf->name,
+		       eabuf->EaNameLength);
+		attr_name[XATTR_USER_PREFIX_LEN + eabuf->EaNameLength] = '\0';
+		value = (char *)&eabuf->name + eabuf->EaNameLength + 1;
+
+		if (!eabuf->EaValueLength) {
+			rc = ksmbd_vfs_casexattr_len(user_ns,
+						     path->dentry,
+						     attr_name,
+						     XATTR_USER_PREFIX_LEN +
+						     eabuf->EaNameLength);
+
+			/* delete the EA only when it exits */
+			if (rc > 0) {
+				rc = ksmbd_vfs_remove_xattr(user_ns,
+							    path->dentry,
+							    attr_name);
+
+				if (rc < 0) {
+					ksmbd_debug(SMB,
+						    "remove xattr failed(%d)\n",
+						    rc);
+					break;
+				}
+			}
+
+			/* if the EA doesn't exist, just do nothing. */
+			rc = 0;
+		} else {
+			rc = ksmbd_vfs_setxattr(user_ns,
+						path->dentry, attr_name, value,
+						le16_to_cpu(eabuf->EaValueLength), 0);
+			if (rc < 0) {
+				ksmbd_debug(SMB,
+					    "ksmbd_vfs_setxattr is failed(%d)\n",
+					    rc);
+				break;
+			}
+		}
+
+next:
+		next = le32_to_cpu(eabuf->NextEntryOffset);
+		eabuf = (struct smb2_ea_info *)((char *)eabuf + next);
+	} while (next != 0);
+
+	kfree(attr_name);
+	return rc;
+}
+
+static noinline int smb2_set_stream_name_xattr(struct path *path,
+					       struct ksmbd_file *fp,
+					       char *stream_name, int s_type)
+{
+	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	size_t xattr_stream_size;
+	char *xattr_stream_name;
+	int rc;
+
+	rc = ksmbd_vfs_xattr_stream_name(stream_name,
+					 &xattr_stream_name,
+					 &xattr_stream_size,
+					 s_type);
+	if (rc)
+		return rc;
+
+	fp->stream.name = xattr_stream_name;
+	fp->stream.size = xattr_stream_size;
+
+	/* Check if there is stream prefix in xattr space */
+	rc = ksmbd_vfs_casexattr_len(user_ns,
+				     path->dentry,
+				     xattr_stream_name,
+				     xattr_stream_size);
+	if (rc >= 0)
+		return 0;
+
+	if (fp->cdoption == FILE_OPEN_LE) {
+		ksmbd_debug(SMB, "XATTR stream name lookup failed: %d\n", rc);
+		return -EBADF;
+	}
+
+	rc = ksmbd_vfs_setxattr(user_ns, path->dentry,
+				xattr_stream_name, NULL, 0, 0);
+	if (rc < 0)
+		pr_err("Failed to store XATTR stream name :%d\n", rc);
+	return 0;
+}
+
+static int smb2_remove_smb_xattrs(struct path *path)
+{
+	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	char *name, *xattr_list = NULL;
+	ssize_t xattr_list_len;
+	int err = 0;
+
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_debug(SMB, "empty xattr in the file\n");
+		goto out;
+	}
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
+
+		if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
+		    strncmp(&name[XATTR_USER_PREFIX_LEN], DOS_ATTRIBUTE_PREFIX,
+			    DOS_ATTRIBUTE_PREFIX_LEN) &&
+		    strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX, STREAM_PREFIX_LEN))
+			continue;
+
+		err = ksmbd_vfs_remove_xattr(user_ns, path->dentry, name);
+		if (err)
+			ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
+	}
+out:
+	kvfree(xattr_list);
+	return err;
+}
+
+static int smb2_create_truncate(struct path *path)
+{
+	int rc = vfs_truncate(path, 0);
+
+	if (rc) {
+		pr_err("vfs_truncate failed, rc %d\n", rc);
+		return rc;
+	}
+
+	rc = smb2_remove_smb_xattrs(path);
+	if (rc == -EOPNOTSUPP)
+		rc = 0;
+	if (rc)
+		ksmbd_debug(SMB,
+			    "ksmbd_truncate_stream_name_xattr failed, rc %d\n",
+			    rc);
+	return rc;
+}
+
+static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
+			    struct ksmbd_file *fp)
+{
+	struct xattr_dos_attrib da = {0};
+	int rc;
+
+	if (!test_share_config_flag(tcon->share_conf,
+				    KSMBD_SHARE_FLAG_STORE_DOS_ATTRS))
+		return;
+
+	da.version = 4;
+	da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+	da.itime = da.create_time = fp->create_time;
+	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
+		XATTR_DOSINFO_ITIME;
+
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt),
+					    path->dentry, &da);
+	if (rc)
+		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
+}
+
+static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
+			       struct path *path, struct ksmbd_file *fp)
+{
+	struct xattr_dos_attrib da;
+	int rc;
+
+	fp->f_ci->m_fattr &= ~(ATTR_HIDDEN_LE | ATTR_SYSTEM_LE);
+
+	/* get FileAttributes from XATTR_NAME_DOS_ATTRIBUTE */
+	if (!test_share_config_flag(tcon->share_conf,
+				    KSMBD_SHARE_FLAG_STORE_DOS_ATTRS))
+		return;
+
+	rc = ksmbd_vfs_get_dos_attrib_xattr(mnt_user_ns(path->mnt),
+					    path->dentry, &da);
+	if (rc > 0) {
+		fp->f_ci->m_fattr = cpu_to_le32(da.attr);
+		fp->create_time = da.create_time;
+		fp->itime = da.itime;
+	}
+}
+
+static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
+		      int open_flags, umode_t posix_mode, bool is_dir)
+{
+	struct ksmbd_tree_connect *tcon = work->tcon;
+	struct ksmbd_share_config *share = tcon->share_conf;
+	umode_t mode;
+	int rc;
+
+	if (!(open_flags & O_CREAT))
+		return -EBADF;
+
+	ksmbd_debug(SMB, "file does not exist, so creating\n");
+	if (is_dir == true) {
+		ksmbd_debug(SMB, "creating directory\n");
+
+		mode = share_config_directory_mode(share, posix_mode);
+		rc = ksmbd_vfs_mkdir(work, name, mode);
+		if (rc)
+			return rc;
+	} else {
+		ksmbd_debug(SMB, "creating regular file\n");
+
+		mode = share_config_create_mode(share, posix_mode);
+		rc = ksmbd_vfs_create(work, name, mode);
+		if (rc)
+			return rc;
+	}
+
+	rc = ksmbd_vfs_kern_path(name, 0, path, 0);
+	if (rc) {
+		pr_err("cannot get linux path (%s), err = %d\n",
+		       name, rc);
+		return rc;
+	}
+	return 0;
+}
+
+static int smb2_create_sd_buffer(struct ksmbd_work *work,
+				 struct smb2_create_req *req,
+				 struct path *path)
+{
+	struct create_context *context;
+	struct create_sd_buf_req *sd_buf;
+
+	if (!req->CreateContextsOffset)
+		return -ENOENT;
+
+	/* Parse SD BUFFER create contexts */
+	context = smb2_find_context_vals(req, SMB2_CREATE_SD_BUFFER);
+	if (!context)
+		return -ENOENT;
+	else if (IS_ERR(context))
+		return PTR_ERR(context);
+
+	ksmbd_debug(SMB,
+		    "Set ACLs using SMB2_CREATE_SD_BUFFER context\n");
+	sd_buf = (struct create_sd_buf_req *)context;
+	return set_info_sec(work->conn, work->tcon, path, &sd_buf->ntsd,
+			    le32_to_cpu(sd_buf->ccontext.DataLength), true);
+}
+
+static void ksmbd_acls_fattr(struct smb_fattr *fattr, struct inode *inode)
+{
+	fattr->cf_uid = inode->i_uid;
+	fattr->cf_gid = inode->i_gid;
+	fattr->cf_mode = inode->i_mode;
+	fattr->cf_dacls = NULL;
+
+	fattr->cf_acls = get_acl(inode, ACL_TYPE_ACCESS);
+	if (S_ISDIR(inode->i_mode))
+		fattr->cf_dacls = get_acl(inode, ACL_TYPE_DEFAULT);
+}
+
+/**
+ * smb2_open() - handler for smb file open request
+ * @work:	smb work containing request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+int smb2_open(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_tree_connect *tcon = work->tcon;
+	struct smb2_create_req *req;
+	struct smb2_create_rsp *rsp, *rsp_org;
+	struct path path;
+	struct ksmbd_share_config *share = tcon->share_conf;
+	struct ksmbd_file *fp = NULL;
+	struct file *filp = NULL;
+	struct user_namespace *user_ns = NULL;
+	struct kstat stat;
+	struct create_context *context;
+	struct lease_ctx_info *lc = NULL;
+	struct create_ea_buf_req *ea_buf = NULL;
+	struct oplock_info *opinfo;
+	__le32 *next_ptr = NULL;
+	int req_op_level = 0, open_flags = 0, may_flags = 0, file_info = 0;
+	int rc = 0, len = 0;
+	int contxt_cnt = 0, query_disk_id = 0;
+	int maximal_access_ctxt = 0, posix_ctxt = 0;
+	int s_type = 0;
+	int next_off = 0;
+	char *name = NULL;
+	char *stream_name = NULL;
+	bool file_present = false, created = false, already_permitted = false;
+	int share_ret, need_truncate = 0;
+	u64 time;
+	umode_t posix_mode = 0;
+	__le32 daccess, maximal_access = 0;
+
+	rsp_org = work->response_buf;
+	WORK_BUFFERS(work, req, rsp);
+
+	if (req->hdr.NextCommand && !work->next_smb2_rcv_hdr_off &&
+	    (req->hdr.Flags & SMB2_FLAGS_RELATED_OPERATIONS)) {
+		ksmbd_debug(SMB, "invalid flag in chained command\n");
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		smb2_set_err_rsp(work);
+		return -EINVAL;
+	}
+
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC pipe create request\n");
+		return create_smb2_pipe(work);
+	}
+
+	if (req->NameLength) {
+		if ((req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
+		    *(char *)req->Buffer == '\\') {
+			pr_err("not allow directory name included leading slash\n");
+			rc = -EINVAL;
+			goto err_out1;
+		}
+
+		name = smb2_get_name(share,
+				     req->Buffer,
+				     le16_to_cpu(req->NameLength),
+				     work->conn->local_nls);
+		if (IS_ERR(name)) {
+			rc = PTR_ERR(name);
+			if (rc != -ENOMEM)
+				rc = -ENOENT;
+			goto err_out1;
+		}
+
+		ksmbd_debug(SMB, "converted name = %s\n", name);
+		if (strchr(name, ':')) {
+			if (!test_share_config_flag(work->tcon->share_conf,
+						    KSMBD_SHARE_FLAG_STREAMS)) {
+				rc = -EBADF;
+				goto err_out1;
+			}
+			rc = parse_stream_name(name, &stream_name, &s_type);
+			if (rc < 0)
+				goto err_out1;
+		}
+
+		rc = ksmbd_validate_filename(name);
+		if (rc < 0)
+			goto err_out1;
+
+		if (ksmbd_share_veto_filename(share, name)) {
+			rc = -ENOENT;
+			ksmbd_debug(SMB, "Reject open(), vetoed file: %s\n",
+				    name);
+			goto err_out1;
+		}
+	} else {
+		len = strlen(share->path);
+		ksmbd_debug(SMB, "share path len %d\n", len);
+		name = kmalloc(len + 1, GFP_KERNEL);
+		if (!name) {
+			rsp->hdr.Status = STATUS_NO_MEMORY;
+			rc = -ENOMEM;
+			goto err_out1;
+		}
+
+		memcpy(name, share->path, len);
+		*(name + len) = '\0';
+	}
+
+	req_op_level = req->RequestedOplockLevel;
+	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
+		lc = parse_lease_state(req);
+
+	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE_LE)) {
+		pr_err("Invalid impersonationlevel : 0x%x\n",
+		       le32_to_cpu(req->ImpersonationLevel));
+		rc = -EIO;
+		rsp->hdr.Status = STATUS_BAD_IMPERSONATION_LEVEL;
+		goto err_out1;
+	}
+
+	if (req->CreateOptions && !(req->CreateOptions & CREATE_OPTIONS_MASK)) {
+		pr_err("Invalid create options : 0x%x\n",
+		       le32_to_cpu(req->CreateOptions));
+		rc = -EINVAL;
+		goto err_out1;
+	} else {
+		if (req->CreateOptions & FILE_SEQUENTIAL_ONLY_LE &&
+		    req->CreateOptions & FILE_RANDOM_ACCESS_LE)
+			req->CreateOptions = ~(FILE_SEQUENTIAL_ONLY_LE);
+
+		if (req->CreateOptions &
+		    (FILE_OPEN_BY_FILE_ID_LE | CREATE_TREE_CONNECTION |
+		     FILE_RESERVE_OPFILTER_LE)) {
+			rc = -EOPNOTSUPP;
+			goto err_out1;
+		}
+
+		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
+			if (req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE) {
+				rc = -EINVAL;
+				goto err_out1;
+			} else if (req->CreateOptions & FILE_NO_COMPRESSION_LE) {
+				req->CreateOptions = ~(FILE_NO_COMPRESSION_LE);
+			}
+		}
+	}
+
+	if (le32_to_cpu(req->CreateDisposition) >
+	    le32_to_cpu(FILE_OVERWRITE_IF_LE)) {
+		pr_err("Invalid create disposition : 0x%x\n",
+		       le32_to_cpu(req->CreateDisposition));
+		rc = -EINVAL;
+		goto err_out1;
+	}
+
+	if (!(req->DesiredAccess & DESIRED_ACCESS_MASK)) {
+		pr_err("Invalid desired access : 0x%x\n",
+		       le32_to_cpu(req->DesiredAccess));
+		rc = -EACCES;
+		goto err_out1;
+	}
+
+	if (req->FileAttributes && !(req->FileAttributes & ATTR_MASK_LE)) {
+		pr_err("Invalid file attribute : 0x%x\n",
+		       le32_to_cpu(req->FileAttributes));
+		rc = -EINVAL;
+		goto err_out1;
+	}
+
+	if (req->CreateContextsOffset) {
+		/* Parse non-durable handle create contexts */
+		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER);
+		if (IS_ERR(context)) {
+			rc = PTR_ERR(context);
+			goto err_out1;
+		} else if (context) {
+			ea_buf = (struct create_ea_buf_req *)context;
+			if (req->CreateOptions & FILE_NO_EA_KNOWLEDGE_LE) {
+				rsp->hdr.Status = STATUS_ACCESS_DENIED;
+				rc = -EACCES;
+				goto err_out1;
+			}
+		}
+
+		context = smb2_find_context_vals(req,
+						 SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST);
+		if (IS_ERR(context)) {
+			rc = PTR_ERR(context);
+			goto err_out1;
+		} else if (context) {
+			ksmbd_debug(SMB,
+				    "get query maximal access context\n");
+			maximal_access_ctxt = 1;
+		}
+
+		context = smb2_find_context_vals(req,
+						 SMB2_CREATE_TIMEWARP_REQUEST);
+		if (IS_ERR(context)) {
+			rc = PTR_ERR(context);
+			goto err_out1;
+		} else if (context) {
+			ksmbd_debug(SMB, "get timewarp context\n");
+			rc = -EBADF;
+			goto err_out1;
+		}
+
+		if (tcon->posix_extensions) {
+			context = smb2_find_context_vals(req,
+							 SMB2_CREATE_TAG_POSIX);
+			if (IS_ERR(context)) {
+				rc = PTR_ERR(context);
+				goto err_out1;
+			} else if (context) {
+				struct create_posix *posix =
+					(struct create_posix *)context;
+				ksmbd_debug(SMB, "get posix context\n");
+
+				posix_mode = le32_to_cpu(posix->Mode);
+				posix_ctxt = 1;
+			}
+		}
+	}
+
+	if (ksmbd_override_fsids(work)) {
+		rc = -ENOMEM;
+		goto err_out1;
+	}
+
+	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE) {
+		/*
+		 * On delete request, instead of following up, need to
+		 * look the current entity
+		 */
+		rc = ksmbd_vfs_kern_path(name, 0, &path, 1);
+		if (!rc) {
+			/*
+			 * If file exists with under flags, return access
+			 * denied error.
+			 */
+			if (req->CreateDisposition == FILE_OVERWRITE_IF_LE ||
+			    req->CreateDisposition == FILE_OPEN_IF_LE) {
+				rc = -EACCES;
+				path_put(&path);
+				goto err_out;
+			}
+
+			if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+				ksmbd_debug(SMB,
+					    "User does not have write permission\n");
+				rc = -EACCES;
+				path_put(&path);
+				goto err_out;
+			}
+		}
+	} else {
+		if (test_share_config_flag(work->tcon->share_conf,
+					   KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS)) {
+			/*
+			 * Use LOOKUP_FOLLOW to follow the path of
+			 * symlink in path buildup
+			 */
+			rc = ksmbd_vfs_kern_path(name, LOOKUP_FOLLOW, &path, 1);
+			if (rc) { /* Case for broken link ?*/
+				rc = ksmbd_vfs_kern_path(name, 0, &path, 1);
+			}
+		} else {
+			rc = ksmbd_vfs_kern_path(name, 0, &path, 1);
+			if (!rc && d_is_symlink(path.dentry)) {
+				rc = -EACCES;
+				path_put(&path);
+				goto err_out;
+			}
+		}
+	}
+
+	if (rc) {
+		if (rc == -EACCES) {
+			ksmbd_debug(SMB,
+				    "User does not have right permission\n");
+			goto err_out;
+		}
+		ksmbd_debug(SMB, "can not get linux path for %s, rc = %d\n",
+			    name, rc);
+		rc = 0;
+	} else {
+		file_present = true;
+		user_ns = mnt_user_ns(path.mnt);
+		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
+	}
+	if (stream_name) {
+		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
+			if (s_type == DATA_STREAM) {
+				rc = -EIO;
+				rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
+			}
+		} else {
+			if (S_ISDIR(stat.mode) && s_type == DATA_STREAM) {
+				rc = -EIO;
+				rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
+			}
+		}
+
+		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE &&
+		    req->FileAttributes & ATTR_NORMAL_LE) {
+			rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
+			rc = -EIO;
+		}
+
+		if (rc < 0)
+			goto err_out;
+	}
+
+	if (file_present && req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE &&
+	    S_ISDIR(stat.mode) && !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
+		ksmbd_debug(SMB, "open() argument is a directory: %s, %x\n",
+			    name, req->CreateOptions);
+		rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
+		rc = -EIO;
+		goto err_out;
+	}
+
+	if (file_present && (req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
+	    !(req->CreateDisposition == FILE_CREATE_LE) &&
+	    !S_ISDIR(stat.mode)) {
+		rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
+		rc = -EIO;
+		goto err_out;
+	}
+
+	if (!stream_name && file_present &&
+	    req->CreateDisposition == FILE_CREATE_LE) {
+		rc = -EEXIST;
+		goto err_out;
+	}
+
+	daccess = smb_map_generic_desired_access(req->DesiredAccess);
+
+	if (file_present && !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
+		rc = smb_check_perm_dacl(conn, &path, &daccess,
+					 sess->user->uid);
+		if (rc)
+			goto err_out;
+	}
+
+	if (daccess & FILE_MAXIMAL_ACCESS_LE) {
+		if (!file_present) {
+			daccess = cpu_to_le32(GENERIC_ALL_FLAGS);
+		} else {
+			rc = ksmbd_vfs_query_maximal_access(user_ns,
+							    path.dentry,
+							    &daccess);
+			if (rc)
+				goto err_out;
+			already_permitted = true;
+		}
+		maximal_access = daccess;
+	}
+
+	open_flags = smb2_create_open_flags(file_present, daccess,
+					    req->CreateDisposition,
+					    &may_flags);
+
+	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		if (open_flags & O_CREAT) {
+			ksmbd_debug(SMB,
+				    "User does not have write permission\n");
+			rc = -EACCES;
+			goto err_out;
+		}
+	}
+
+	/*create file if not present */
+	if (!file_present) {
+		rc = smb2_creat(work, &path, name, open_flags, posix_mode,
+				req->CreateOptions & FILE_DIRECTORY_FILE_LE);
+		if (rc)
+			goto err_out;
+
+		created = true;
+		user_ns = mnt_user_ns(path.mnt);
+		if (ea_buf) {
+			rc = smb2_set_ea(&ea_buf->ea, &path);
+			if (rc == -EOPNOTSUPP)
+				rc = 0;
+			else if (rc)
+				goto err_out;
+		}
+	} else if (!already_permitted) {
+		/* FILE_READ_ATTRIBUTE is allowed without inode_permission,
+		 * because execute(search) permission on a parent directory,
+		 * is already granted.
+		 */
+		if (daccess & ~(FILE_READ_ATTRIBUTES_LE | FILE_READ_CONTROL_LE)) {
+			rc = inode_permission(user_ns,
+					      d_inode(path.dentry),
+					      may_flags);
+			if (rc)
+				goto err_out;
+
+			if ((daccess & FILE_DELETE_LE) ||
+			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
+				rc = ksmbd_vfs_may_delete(user_ns,
+							  path.dentry);
+				if (rc)
+					goto err_out;
+			}
+		}
+	}
+
+	rc = ksmbd_query_inode_status(d_inode(path.dentry->d_parent));
+	if (rc == KSMBD_INODE_STATUS_PENDING_DELETE) {
+		rc = -EBUSY;
+		goto err_out;
+	}
+
+	rc = 0;
+	filp = dentry_open(&path, open_flags, current_cred());
+	if (IS_ERR(filp)) {
+		rc = PTR_ERR(filp);
+		pr_err("dentry open for dir failed, rc %d\n", rc);
+		goto err_out;
+	}
+
+	if (file_present) {
+		if (!(open_flags & O_TRUNC))
+			file_info = FILE_OPENED;
+		else
+			file_info = FILE_OVERWRITTEN;
+
+		if ((req->CreateDisposition & FILE_CREATE_MASK_LE) ==
+		    FILE_SUPERSEDE_LE)
+			file_info = FILE_SUPERSEDED;
+	} else if (open_flags & O_CREAT) {
+		file_info = FILE_CREATED;
+	}
+
+	ksmbd_vfs_set_fadvise(filp, req->CreateOptions);
+
+	/* Obtain Volatile-ID */
+	fp = ksmbd_open_fd(work, filp);
+	if (IS_ERR(fp)) {
+		fput(filp);
+		rc = PTR_ERR(fp);
+		fp = NULL;
+		goto err_out;
+	}
+
+	/* Get Persistent-ID */
+	ksmbd_open_durable_fd(fp);
+	if (!has_file_id(fp->persistent_id)) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	fp->filename = name;
+	fp->cdoption = req->CreateDisposition;
+	fp->daccess = daccess;
+	fp->saccess = req->ShareAccess;
+	fp->coption = req->CreateOptions;
+
+	/* Set default windows and posix acls if creating new file */
+	if (created) {
+		int posix_acl_rc;
+		struct inode *inode = d_inode(path.dentry);
+
+		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(user_ns,
+							   inode,
+							   d_inode(path.dentry->d_parent));
+		if (posix_acl_rc)
+			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
+
+		if (test_share_config_flag(work->tcon->share_conf,
+					   KSMBD_SHARE_FLAG_ACL_XATTR)) {
+			rc = smb_inherit_dacl(conn, &path, sess->user->uid,
+					      sess->user->gid);
+		}
+
+		if (rc) {
+			rc = smb2_create_sd_buffer(work, req, &path);
+			if (rc) {
+				if (posix_acl_rc)
+					ksmbd_vfs_set_init_posix_acl(user_ns,
+								     inode);
+
+				if (test_share_config_flag(work->tcon->share_conf,
+							   KSMBD_SHARE_FLAG_ACL_XATTR)) {
+					struct smb_fattr fattr;
+					struct smb_ntsd *pntsd;
+					int pntsd_size, ace_num = 0;
+
+					ksmbd_acls_fattr(&fattr, inode);
+					if (fattr.cf_acls)
+						ace_num = fattr.cf_acls->a_count;
+					if (fattr.cf_dacls)
+						ace_num += fattr.cf_dacls->a_count;
+
+					pntsd = kmalloc(sizeof(struct smb_ntsd) +
+							sizeof(struct smb_sid) * 3 +
+							sizeof(struct smb_acl) +
+							sizeof(struct smb_ace) * ace_num * 2,
+							GFP_KERNEL);
+					if (!pntsd)
+						goto err_out;
+
+					rc = build_sec_desc(user_ns,
+							    pntsd, NULL,
+							    OWNER_SECINFO |
+							    GROUP_SECINFO |
+							    DACL_SECINFO,
+							    &pntsd_size, &fattr);
+					posix_acl_release(fattr.cf_acls);
+					posix_acl_release(fattr.cf_dacls);
+
+					rc = ksmbd_vfs_set_sd_xattr(conn,
+								    user_ns,
+								    path.dentry,
+								    pntsd,
+								    pntsd_size);
+					kfree(pntsd);
+					if (rc)
+						pr_err("failed to store ntacl in xattr : %d\n",
+						       rc);
+				}
+			}
+		}
+		rc = 0;
+	}
+
+	if (stream_name) {
+		rc = smb2_set_stream_name_xattr(&path,
+						fp,
+						stream_name,
+						s_type);
+		if (rc)
+			goto err_out;
+		file_info = FILE_CREATED;
+	}
+
+	fp->attrib_only = !(req->DesiredAccess & ~(FILE_READ_ATTRIBUTES_LE |
+			FILE_WRITE_ATTRIBUTES_LE | FILE_SYNCHRONIZE_LE));
+	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
+	    !fp->attrib_only && !stream_name) {
+		smb_break_all_oplock(work, fp);
+		need_truncate = 1;
+	}
+
+	/* fp should be searchable through ksmbd_inode.m_fp_list
+	 * after daccess, saccess, attrib_only, and stream are
+	 * initialized.
+	 */
+	write_lock(&fp->f_ci->m_lock);
+	list_add(&fp->node, &fp->f_ci->m_fp_list);
+	write_unlock(&fp->f_ci->m_lock);
+
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc) {
+		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
+		rc = 0;
+	}
+
+	/* Check delete pending among previous fp before oplock break */
+	if (ksmbd_inode_pending_delete(fp)) {
+		rc = -EBUSY;
+		goto err_out;
+	}
+
+	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
+	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
+	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
+	     !(conn->vals->capabilities & SMB2_GLOBAL_CAP_LEASING))) {
+		if (share_ret < 0 && !S_ISDIR(file_inode(fp->filp)->i_mode)) {
+			rc = share_ret;
+			goto err_out;
+		}
+	} else {
+		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+			req_op_level = smb2_map_lease_to_oplock(lc->req_state);
+			ksmbd_debug(SMB,
+				    "lease req for(%s) req oplock state 0x%x, lease state 0x%x\n",
+				    name, req_op_level, lc->req_state);
+			rc = find_same_lease_key(sess, fp->f_ci, lc);
+			if (rc)
+				goto err_out;
+		} else if (open_flags == O_RDONLY &&
+			   (req_op_level == SMB2_OPLOCK_LEVEL_BATCH ||
+			    req_op_level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))
+			req_op_level = SMB2_OPLOCK_LEVEL_II;
+
+		rc = smb_grant_oplock(work, req_op_level,
+				      fp->persistent_id, fp,
+				      le32_to_cpu(req->hdr.Id.SyncId.TreeId),
+				      lc, share_ret);
+		if (rc < 0)
+			goto err_out;
+	}
+
+	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)
+		ksmbd_fd_set_delete_on_close(fp, file_info);
+
+	if (need_truncate) {
+		rc = smb2_create_truncate(&path);
+		if (rc)
+			goto err_out;
+	}
+
+	if (req->CreateContextsOffset) {
+		struct create_alloc_size_req *az_req;
+
+		az_req = (struct create_alloc_size_req *)smb2_find_context_vals(req,
+					SMB2_CREATE_ALLOCATION_SIZE);
+		if (IS_ERR(az_req)) {
+			rc = PTR_ERR(az_req);
+			goto err_out;
+		} else if (az_req) {
+			loff_t alloc_size = le64_to_cpu(az_req->AllocationSize);
+			int err;
+
+			ksmbd_debug(SMB,
+				    "request smb2 create allocate size : %llu\n",
+				    alloc_size);
+			smb_break_all_levII_oplock(work, fp, 1);
+			err = vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0,
+					    alloc_size);
+			if (err < 0)
+				ksmbd_debug(SMB,
+					    "vfs_fallocate is failed : %d\n",
+					    err);
+		}
+
+		context = smb2_find_context_vals(req, SMB2_CREATE_QUERY_ON_DISK_ID);
+		if (IS_ERR(context)) {
+			rc = PTR_ERR(context);
+			goto err_out;
+		} else if (context) {
+			ksmbd_debug(SMB, "get query on disk id context\n");
+			query_disk_id = 1;
+		}
+	}
+
+	if (stat.result_mask & STATX_BTIME)
+		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
+	else
+		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
+	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
+		fp->f_ci->m_fattr =
+			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
+
+	if (!created)
+		smb2_update_xattrs(tcon, &path, fp);
+	else
+		smb2_new_xattrs(tcon, &path, fp);
+
+	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
+
+	generic_fillattr(user_ns, file_inode(fp->filp),
+			 &stat);
+
+	rsp->StructureSize = cpu_to_le16(89);
+	rcu_read_lock();
+	opinfo = rcu_dereference(fp->f_opinfo);
+	rsp->OplockLevel = opinfo != NULL ? opinfo->level : 0;
+	rcu_read_unlock();
+	rsp->Reserved = 0;
+	rsp->CreateAction = cpu_to_le32(file_info);
+	rsp->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(stat.atime);
+	rsp->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.mtime);
+	rsp->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.ctime);
+	rsp->ChangeTime = cpu_to_le64(time);
+	rsp->AllocationSize = S_ISDIR(stat.mode) ? 0 :
+		cpu_to_le64(stat.blocks << 9);
+	rsp->EndofFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
+	rsp->FileAttributes = fp->f_ci->m_fattr;
+
+	rsp->Reserved2 = 0;
+
+	rsp->PersistentFileId = cpu_to_le64(fp->persistent_id);
+	rsp->VolatileFileId = cpu_to_le64(fp->volatile_id);
+
+	rsp->CreateContextsOffset = 0;
+	rsp->CreateContextsLength = 0;
+	inc_rfc1001_len(rsp_org, 88); /* StructureSize - 1*/
+
+	/* If lease is request send lease context response */
+	if (opinfo && opinfo->is_lease) {
+		struct create_context *lease_ccontext;
+
+		ksmbd_debug(SMB, "lease granted on(%s) lease state 0x%x\n",
+			    name, opinfo->o_lease->state);
+		rsp->OplockLevel = SMB2_OPLOCK_LEVEL_LEASE;
+
+		lease_ccontext = (struct create_context *)rsp->Buffer;
+		contxt_cnt++;
+		create_lease_buf(rsp->Buffer, opinfo->o_lease);
+		le32_add_cpu(&rsp->CreateContextsLength,
+			     conn->vals->create_lease_size);
+		inc_rfc1001_len(rsp_org, conn->vals->create_lease_size);
+		next_ptr = &lease_ccontext->Next;
+		next_off = conn->vals->create_lease_size;
+	}
+
+	if (maximal_access_ctxt) {
+		struct create_context *mxac_ccontext;
+
+		if (maximal_access == 0)
+			ksmbd_vfs_query_maximal_access(user_ns,
+						       path.dentry,
+						       &maximal_access);
+		mxac_ccontext = (struct create_context *)(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength));
+		contxt_cnt++;
+		create_mxac_rsp_buf(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength),
+				le32_to_cpu(maximal_access));
+		le32_add_cpu(&rsp->CreateContextsLength,
+			     conn->vals->create_mxac_size);
+		inc_rfc1001_len(rsp_org, conn->vals->create_mxac_size);
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+		next_ptr = &mxac_ccontext->Next;
+		next_off = conn->vals->create_mxac_size;
+	}
+
+	if (query_disk_id) {
+		struct create_context *disk_id_ccontext;
+
+		disk_id_ccontext = (struct create_context *)(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength));
+		contxt_cnt++;
+		create_disk_id_rsp_buf(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength),
+				stat.ino, tcon->id);
+		le32_add_cpu(&rsp->CreateContextsLength,
+			     conn->vals->create_disk_id_size);
+		inc_rfc1001_len(rsp_org, conn->vals->create_disk_id_size);
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+		next_ptr = &disk_id_ccontext->Next;
+		next_off = conn->vals->create_disk_id_size;
+	}
+
+	if (posix_ctxt) {
+		contxt_cnt++;
+		create_posix_rsp_buf(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength),
+				fp);
+		le32_add_cpu(&rsp->CreateContextsLength,
+			     conn->vals->create_posix_size);
+		inc_rfc1001_len(rsp_org, conn->vals->create_posix_size);
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+	}
+
+	if (contxt_cnt > 0) {
+		rsp->CreateContextsOffset =
+			cpu_to_le32(offsetof(struct smb2_create_rsp, Buffer)
+			- 4);
+	}
+
+err_out:
+	if (file_present || created)
+		path_put(&path);
+	ksmbd_revert_fsids(work);
+err_out1:
+	if (rc) {
+		if (rc == -EINVAL)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		else if (rc == -EOPNOTSUPP)
+			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+		else if (rc == -EACCES || rc == -ESTALE)
+			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		else if (rc == -ENOENT)
+			rsp->hdr.Status = STATUS_OBJECT_NAME_INVALID;
+		else if (rc == -EPERM)
+			rsp->hdr.Status = STATUS_SHARING_VIOLATION;
+		else if (rc == -EBUSY)
+			rsp->hdr.Status = STATUS_DELETE_PENDING;
+		else if (rc == -EBADF)
+			rsp->hdr.Status = STATUS_OBJECT_NAME_NOT_FOUND;
+		else if (rc == -ENOEXEC)
+			rsp->hdr.Status = STATUS_DUPLICATE_OBJECTID;
+		else if (rc == -ENXIO)
+			rsp->hdr.Status = STATUS_NO_SUCH_DEVICE;
+		else if (rc == -EEXIST)
+			rsp->hdr.Status = STATUS_OBJECT_NAME_COLLISION;
+		else if (rc == -EMFILE)
+			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		if (!rsp->hdr.Status)
+			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+
+		if (!fp || !fp->filename)
+			kfree(name);
+		if (fp)
+			ksmbd_fd_put(work, fp);
+		smb2_set_err_rsp(work);
+		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
+	}
+
+	kfree(lc);
+
+	return 0;
+}
+
+static int readdir_info_level_struct_sz(int info_level)
+{
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+		return sizeof(struct file_full_directory_info);
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+		return sizeof(struct file_both_directory_info);
+	case FILE_DIRECTORY_INFORMATION:
+		return sizeof(struct file_directory_info);
+	case FILE_NAMES_INFORMATION:
+		return sizeof(struct file_names_info);
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+		return sizeof(struct file_id_full_dir_info);
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+		return sizeof(struct file_id_both_directory_info);
+	case SMB_FIND_FILE_POSIX_INFO:
+		return sizeof(struct smb2_posix_info);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int dentry_name(struct ksmbd_dir_info *d_info, int info_level)
+{
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_full_directory_info *ffdinfo;
+
+		ffdinfo = (struct file_full_directory_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(ffdinfo->NextEntryOffset);
+		d_info->name = ffdinfo->FileName;
+		d_info->name_len = le32_to_cpu(ffdinfo->FileNameLength);
+		return 0;
+	}
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_both_directory_info *fbdinfo;
+
+		fbdinfo = (struct file_both_directory_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(fbdinfo->NextEntryOffset);
+		d_info->name = fbdinfo->FileName;
+		d_info->name_len = le32_to_cpu(fbdinfo->FileNameLength);
+		return 0;
+	}
+	case FILE_DIRECTORY_INFORMATION:
+	{
+		struct file_directory_info *fdinfo;
+
+		fdinfo = (struct file_directory_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(fdinfo->NextEntryOffset);
+		d_info->name = fdinfo->FileName;
+		d_info->name_len = le32_to_cpu(fdinfo->FileNameLength);
+		return 0;
+	}
+	case FILE_NAMES_INFORMATION:
+	{
+		struct file_names_info *fninfo;
+
+		fninfo = (struct file_names_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(fninfo->NextEntryOffset);
+		d_info->name = fninfo->FileName;
+		d_info->name_len = le32_to_cpu(fninfo->FileNameLength);
+		return 0;
+	}
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_id_full_dir_info *dinfo;
+
+		dinfo = (struct file_id_full_dir_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(dinfo->NextEntryOffset);
+		d_info->name = dinfo->FileName;
+		d_info->name_len = le32_to_cpu(dinfo->FileNameLength);
+		return 0;
+	}
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_id_both_directory_info *fibdinfo;
+
+		fibdinfo = (struct file_id_both_directory_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(fibdinfo->NextEntryOffset);
+		d_info->name = fibdinfo->FileName;
+		d_info->name_len = le32_to_cpu(fibdinfo->FileNameLength);
+		return 0;
+	}
+	case SMB_FIND_FILE_POSIX_INFO:
+	{
+		struct smb2_posix_info *posix_info;
+
+		posix_info = (struct smb2_posix_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(posix_info->NextEntryOffset);
+		d_info->name = posix_info->name;
+		d_info->name_len = le32_to_cpu(posix_info->name_len);
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * smb2_populate_readdir_entry() - encode directory entry in smb2 response
+ * buffer
+ * @conn:	connection instance
+ * @info_level:	smb information level
+ * @d_info:	structure included variables for query dir
+ * @user_ns:	user namespace
+ * @ksmbd_kstat:	ksmbd wrapper of dirent stat information
+ *
+ * if directory has many entries, find first can't read it fully.
+ * find next might be called multiple times to read remaining dir entries
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
+				       struct ksmbd_dir_info *d_info,
+				       struct user_namespace *user_ns,
+				       struct ksmbd_kstat *ksmbd_kstat)
+{
+	int next_entry_offset = 0;
+	char *conv_name;
+	int conv_len;
+	void *kstat;
+	int struct_sz, rc = 0;
+
+	conv_name = ksmbd_convert_dir_info_name(d_info,
+						conn->local_nls,
+						&conv_len);
+	if (!conv_name)
+		return -ENOMEM;
+
+	/* Somehow the name has only terminating NULL bytes */
+	if (conv_len < 0) {
+		rc = -EINVAL;
+		goto free_conv_name;
+	}
+
+	struct_sz = readdir_info_level_struct_sz(info_level);
+	next_entry_offset = ALIGN(struct_sz - 1 + conv_len,
+				  KSMBD_DIR_INFO_ALIGNMENT);
+
+	if (next_entry_offset > d_info->out_buf_len) {
+		d_info->out_buf_len = 0;
+		rc = -ENOSPC;
+		goto free_conv_name;
+	}
+
+	kstat = d_info->wptr;
+	if (info_level != FILE_NAMES_INFORMATION)
+		kstat = ksmbd_vfs_init_kstat(&d_info->wptr, ksmbd_kstat);
+
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_full_directory_info *ffdinfo;
+
+		ffdinfo = (struct file_full_directory_info *)kstat;
+		ffdinfo->FileNameLength = cpu_to_le32(conv_len);
+		ffdinfo->EaSize =
+			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
+		if (ffdinfo->EaSize)
+			ffdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			ffdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(ffdinfo->FileName, conv_name, conv_len);
+		ffdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_both_directory_info *fbdinfo;
+
+		fbdinfo = (struct file_both_directory_info *)kstat;
+		fbdinfo->FileNameLength = cpu_to_le32(conv_len);
+		fbdinfo->EaSize =
+			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
+		if (fbdinfo->EaSize)
+			fbdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+		fbdinfo->ShortNameLength = 0;
+		fbdinfo->Reserved = 0;
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			fbdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(fbdinfo->FileName, conv_name, conv_len);
+		fbdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_DIRECTORY_INFORMATION:
+	{
+		struct file_directory_info *fdinfo;
+
+		fdinfo = (struct file_directory_info *)kstat;
+		fdinfo->FileNameLength = cpu_to_le32(conv_len);
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			fdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(fdinfo->FileName, conv_name, conv_len);
+		fdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_NAMES_INFORMATION:
+	{
+		struct file_names_info *fninfo;
+
+		fninfo = (struct file_names_info *)kstat;
+		fninfo->FileNameLength = cpu_to_le32(conv_len);
+		memcpy(fninfo->FileName, conv_name, conv_len);
+		fninfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_id_full_dir_info *dinfo;
+
+		dinfo = (struct file_id_full_dir_info *)kstat;
+		dinfo->FileNameLength = cpu_to_le32(conv_len);
+		dinfo->EaSize =
+			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
+		if (dinfo->EaSize)
+			dinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+		dinfo->Reserved = 0;
+		dinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			dinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(dinfo->FileName, conv_name, conv_len);
+		dinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_id_both_directory_info *fibdinfo;
+
+		fibdinfo = (struct file_id_both_directory_info *)kstat;
+		fibdinfo->FileNameLength = cpu_to_le32(conv_len);
+		fibdinfo->EaSize =
+			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
+		if (fibdinfo->EaSize)
+			fibdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+		fibdinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		fibdinfo->ShortNameLength = 0;
+		fibdinfo->Reserved = 0;
+		fibdinfo->Reserved2 = cpu_to_le16(0);
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			fibdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(fibdinfo->FileName, conv_name, conv_len);
+		fibdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case SMB_FIND_FILE_POSIX_INFO:
+	{
+		struct smb2_posix_info *posix_info;
+		u64 time;
+
+		posix_info = (struct smb2_posix_info *)kstat;
+		posix_info->Ignored = 0;
+		posix_info->CreationTime = cpu_to_le64(ksmbd_kstat->create_time);
+		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
+		posix_info->ChangeTime = cpu_to_le64(time);
+		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->atime);
+		posix_info->LastAccessTime = cpu_to_le64(time);
+		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->mtime);
+		posix_info->LastWriteTime = cpu_to_le64(time);
+		posix_info->EndOfFile = cpu_to_le64(ksmbd_kstat->kstat->size);
+		posix_info->AllocationSize = cpu_to_le64(ksmbd_kstat->kstat->blocks << 9);
+		posix_info->DeviceId = cpu_to_le32(ksmbd_kstat->kstat->rdev);
+		posix_info->HardLinks = cpu_to_le32(ksmbd_kstat->kstat->nlink);
+		posix_info->Mode = cpu_to_le32(ksmbd_kstat->kstat->mode);
+		posix_info->Inode = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		posix_info->DosAttributes =
+			S_ISDIR(ksmbd_kstat->kstat->mode) ? ATTR_DIRECTORY_LE : ATTR_ARCHIVE_LE;
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			posix_info->DosAttributes |= ATTR_HIDDEN_LE;
+		id_to_sid(from_kuid(user_ns, ksmbd_kstat->kstat->uid),
+			  SIDNFS_USER, (struct smb_sid *)&posix_info->SidBuffer[0]);
+		id_to_sid(from_kgid(user_ns, ksmbd_kstat->kstat->gid),
+			  SIDNFS_GROUP, (struct smb_sid *)&posix_info->SidBuffer[20]);
+		memcpy(posix_info->name, conv_name, conv_len);
+		posix_info->name_len = cpu_to_le32(conv_len);
+		posix_info->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+
+	} /* switch (info_level) */
+
+	d_info->last_entry_offset = d_info->data_count;
+	d_info->data_count += next_entry_offset;
+	d_info->out_buf_len -= next_entry_offset;
+	d_info->wptr += next_entry_offset;
+
+	ksmbd_debug(SMB,
+		    "info_level : %d, buf_len :%d, next_offset : %d, data_count : %d\n",
+		    info_level, d_info->out_buf_len,
+		    next_entry_offset, d_info->data_count);
+
+free_conv_name:
+	kfree(conv_name);
+	return rc;
+}
+
+struct smb2_query_dir_private {
+	struct ksmbd_work	*work;
+	char			*search_pattern;
+	struct ksmbd_file	*dir_fp;
+
+	struct ksmbd_dir_info	*d_info;
+	int			info_level;
+};
+
+static void lock_dir(struct ksmbd_file *dir_fp)
+{
+	struct dentry *dir = dir_fp->filp->f_path.dentry;
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+}
+
+static void unlock_dir(struct ksmbd_file *dir_fp)
+{
+	struct dentry *dir = dir_fp->filp->f_path.dentry;
+
+	inode_unlock(d_inode(dir));
+}
+
+static int process_query_dir_entries(struct smb2_query_dir_private *priv)
+{
+	struct user_namespace	*user_ns = file_mnt_user_ns(priv->dir_fp->filp);
+	struct kstat		kstat;
+	struct ksmbd_kstat	ksmbd_kstat;
+	int			rc;
+	int			i;
+
+	for (i = 0; i < priv->d_info->num_entry; i++) {
+		struct dentry *dent;
+
+		if (dentry_name(priv->d_info, priv->info_level))
+			return -EINVAL;
+
+		lock_dir(priv->dir_fp);
+		dent = lookup_one_len(priv->d_info->name,
+				      priv->dir_fp->filp->f_path.dentry,
+				      priv->d_info->name_len);
+		unlock_dir(priv->dir_fp);
+
+		if (IS_ERR(dent)) {
+			ksmbd_debug(SMB, "Cannot lookup `%s' [%ld]\n",
+				    priv->d_info->name,
+				    PTR_ERR(dent));
+			continue;
+		}
+		if (unlikely(d_is_negative(dent))) {
+			dput(dent);
+			ksmbd_debug(SMB, "Negative dentry `%s'\n",
+				    priv->d_info->name);
+			continue;
+		}
+
+		ksmbd_kstat.kstat = &kstat;
+		if (priv->info_level != FILE_NAMES_INFORMATION)
+			ksmbd_vfs_fill_dentry_attrs(priv->work,
+						    user_ns,
+						    dent,
+						    &ksmbd_kstat);
+
+		rc = smb2_populate_readdir_entry(priv->work->conn,
+						 priv->info_level,
+						 priv->d_info,
+						 user_ns,
+						 &ksmbd_kstat);
+		dput(dent);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+static int reserve_populate_dentry(struct ksmbd_dir_info *d_info,
+				   int info_level)
+{
+	int struct_sz;
+	int conv_len;
+	int next_entry_offset;
+
+	struct_sz = readdir_info_level_struct_sz(info_level);
+	if (struct_sz == -EOPNOTSUPP)
+		return -EOPNOTSUPP;
+
+	conv_len = (d_info->name_len + 1) * 2;
+	next_entry_offset = ALIGN(struct_sz - 1 + conv_len,
+				  KSMBD_DIR_INFO_ALIGNMENT);
+
+	if (next_entry_offset > d_info->out_buf_len) {
+		d_info->out_buf_len = 0;
+		return -ENOSPC;
+	}
+
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_full_directory_info *ffdinfo;
+
+		ffdinfo = (struct file_full_directory_info *)d_info->wptr;
+		memcpy(ffdinfo->FileName, d_info->name, d_info->name_len);
+		ffdinfo->FileName[d_info->name_len] = 0x00;
+		ffdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		ffdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_both_directory_info *fbdinfo;
+
+		fbdinfo = (struct file_both_directory_info *)d_info->wptr;
+		memcpy(fbdinfo->FileName, d_info->name, d_info->name_len);
+		fbdinfo->FileName[d_info->name_len] = 0x00;
+		fbdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		fbdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_DIRECTORY_INFORMATION:
+	{
+		struct file_directory_info *fdinfo;
+
+		fdinfo = (struct file_directory_info *)d_info->wptr;
+		memcpy(fdinfo->FileName, d_info->name, d_info->name_len);
+		fdinfo->FileName[d_info->name_len] = 0x00;
+		fdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		fdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_NAMES_INFORMATION:
+	{
+		struct file_names_info *fninfo;
+
+		fninfo = (struct file_names_info *)d_info->wptr;
+		memcpy(fninfo->FileName, d_info->name, d_info->name_len);
+		fninfo->FileName[d_info->name_len] = 0x00;
+		fninfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		fninfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_id_full_dir_info *dinfo;
+
+		dinfo = (struct file_id_full_dir_info *)d_info->wptr;
+		memcpy(dinfo->FileName, d_info->name, d_info->name_len);
+		dinfo->FileName[d_info->name_len] = 0x00;
+		dinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		dinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_id_both_directory_info *fibdinfo;
+
+		fibdinfo = (struct file_id_both_directory_info *)d_info->wptr;
+		memcpy(fibdinfo->FileName, d_info->name, d_info->name_len);
+		fibdinfo->FileName[d_info->name_len] = 0x00;
+		fibdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		fibdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case SMB_FIND_FILE_POSIX_INFO:
+	{
+		struct smb2_posix_info *posix_info;
+
+		posix_info = (struct smb2_posix_info *)d_info->wptr;
+		memcpy(posix_info->name, d_info->name, d_info->name_len);
+		posix_info->name[d_info->name_len] = 0x00;
+		posix_info->name_len = cpu_to_le32(d_info->name_len);
+		posix_info->NextEntryOffset =
+			cpu_to_le32(next_entry_offset);
+		break;
+	}
+	} /* switch (info_level) */
+
+	d_info->num_entry++;
+	d_info->out_buf_len -= next_entry_offset;
+	d_info->wptr += next_entry_offset;
+	return 0;
+}
+
+static int __query_dir(struct dir_context *ctx, const char *name, int namlen,
+		       loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct ksmbd_readdir_data	*buf;
+	struct smb2_query_dir_private	*priv;
+	struct ksmbd_dir_info		*d_info;
+	int				rc;
+
+	buf	= container_of(ctx, struct ksmbd_readdir_data, ctx);
+	priv	= buf->private;
+	d_info	= priv->d_info;
+
+	/* dot and dotdot entries are already reserved */
+	if (!strcmp(".", name) || !strcmp("..", name))
+		return 0;
+	if (ksmbd_share_veto_filename(priv->work->tcon->share_conf, name))
+		return 0;
+	if (!match_pattern(name, namlen, priv->search_pattern))
+		return 0;
+
+	d_info->name		= name;
+	d_info->name_len	= namlen;
+	rc = reserve_populate_dentry(d_info, priv->info_level);
+	if (rc)
+		return rc;
+	if (d_info->flags & SMB2_RETURN_SINGLE_ENTRY) {
+		d_info->out_buf_len = 0;
+		return 0;
+	}
+	return 0;
+}
+
+static void restart_ctx(struct dir_context *ctx)
+{
+	ctx->pos = 0;
+}
+
+static int verify_info_level(int info_level)
+{
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+	case FILE_DIRECTORY_INFORMATION:
+	case FILE_NAMES_INFORMATION:
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+	case SMB_FIND_FILE_POSIX_INFO:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int smb2_query_dir(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_query_directory_req *req;
+	struct smb2_query_directory_rsp *rsp, *rsp_org;
+	struct ksmbd_share_config *share = work->tcon->share_conf;
+	struct ksmbd_file *dir_fp = NULL;
+	struct ksmbd_dir_info d_info;
+	int rc = 0;
+	char *srch_ptr = NULL;
+	unsigned char srch_flag;
+	int buffer_sz;
+	struct smb2_query_dir_private query_dir_private = {NULL, };
+
+	rsp_org = work->response_buf;
+	WORK_BUFFERS(work, req, rsp);
+
+	if (ksmbd_override_fsids(work)) {
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+		smb2_set_err_rsp(work);
+		return -ENOMEM;
+	}
+
+	rc = verify_info_level(req->FileInformationClass);
+	if (rc) {
+		rc = -EFAULT;
+		goto err_out2;
+	}
+
+	dir_fp = ksmbd_lookup_fd_slow(work,
+				      le64_to_cpu(req->VolatileFileId),
+				      le64_to_cpu(req->PersistentFileId));
+	if (!dir_fp) {
+		rc = -EBADF;
+		goto err_out2;
+	}
+
+	if (!(dir_fp->daccess & FILE_LIST_DIRECTORY_LE) ||
+	    inode_permission(file_mnt_user_ns(dir_fp->filp),
+			     file_inode(dir_fp->filp),
+			     MAY_READ | MAY_EXEC)) {
+		pr_err("no right to enumerate directory (%pd)\n",
+		       dir_fp->filp->f_path.dentry);
+		rc = -EACCES;
+		goto err_out2;
+	}
+
+	if (!S_ISDIR(file_inode(dir_fp->filp)->i_mode)) {
+		pr_err("can't do query dir for a file\n");
+		rc = -EINVAL;
+		goto err_out2;
+	}
+
+	srch_flag = req->Flags;
+	srch_ptr = smb_strndup_from_utf16(req->Buffer,
+					  le16_to_cpu(req->FileNameLength), 1,
+					  conn->local_nls);
+	if (IS_ERR(srch_ptr)) {
+		ksmbd_debug(SMB, "Search Pattern not found\n");
+		rc = -EINVAL;
+		goto err_out2;
+	} else {
+		ksmbd_debug(SMB, "Search pattern is %s\n", srch_ptr);
+	}
+
+	ksmbd_debug(SMB, "Directory name is %s\n", dir_fp->filename);
+
+	if (srch_flag & SMB2_REOPEN || srch_flag & SMB2_RESTART_SCANS) {
+		ksmbd_debug(SMB, "Restart directory scan\n");
+		generic_file_llseek(dir_fp->filp, 0, SEEK_SET);
+		restart_ctx(&dir_fp->readdir_data.ctx);
+	}
+
+	memset(&d_info, 0, sizeof(struct ksmbd_dir_info));
+	d_info.wptr = (char *)rsp->Buffer;
+	d_info.rptr = (char *)rsp->Buffer;
+	d_info.out_buf_len = (work->response_sz - (get_rfc1002_len(rsp_org) + 4));
+	d_info.out_buf_len = min_t(int, d_info.out_buf_len, le32_to_cpu(req->OutputBufferLength)) -
+		sizeof(struct smb2_query_directory_rsp);
+	d_info.flags = srch_flag;
+
+	/*
+	 * reserve dot and dotdot entries in head of buffer
+	 * in first response
+	 */
+	rc = ksmbd_populate_dot_dotdot_entries(work, req->FileInformationClass,
+					       dir_fp, &d_info, srch_ptr,
+					       smb2_populate_readdir_entry);
+	if (rc == -ENOSPC)
+		rc = 0;
+	else if (rc)
+		goto err_out;
+
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_HIDE_DOT_FILES))
+		d_info.hide_dot_file = true;
+
+	buffer_sz				= d_info.out_buf_len;
+	d_info.rptr				= d_info.wptr;
+	query_dir_private.work			= work;
+	query_dir_private.search_pattern	= srch_ptr;
+	query_dir_private.dir_fp		= dir_fp;
+	query_dir_private.d_info		= &d_info;
+	query_dir_private.info_level		= req->FileInformationClass;
+	dir_fp->readdir_data.private		= &query_dir_private;
+	set_ctx_actor(&dir_fp->readdir_data.ctx, __query_dir);
+
+	rc = iterate_dir(dir_fp->filp, &dir_fp->readdir_data.ctx);
+	if (rc == 0)
+		restart_ctx(&dir_fp->readdir_data.ctx);
+	if (rc == -ENOSPC)
+		rc = 0;
+	if (rc)
+		goto err_out;
+
+	d_info.wptr = d_info.rptr;
+	d_info.out_buf_len = buffer_sz;
+	rc = process_query_dir_entries(&query_dir_private);
+	if (rc)
+		goto err_out;
+
+	if (!d_info.data_count && d_info.out_buf_len >= 0) {
+		if (srch_flag & SMB2_RETURN_SINGLE_ENTRY && !is_asterisk(srch_ptr)) {
+			rsp->hdr.Status = STATUS_NO_SUCH_FILE;
+		} else {
+			dir_fp->dot_dotdot[0] = dir_fp->dot_dotdot[1] = 0;
+			rsp->hdr.Status = STATUS_NO_MORE_FILES;
+		}
+		rsp->StructureSize = cpu_to_le16(9);
+		rsp->OutputBufferOffset = cpu_to_le16(0);
+		rsp->OutputBufferLength = cpu_to_le32(0);
+		rsp->Buffer[0] = 0;
+		inc_rfc1001_len(rsp_org, 9);
+	} else {
+		((struct file_directory_info *)
+		((char *)rsp->Buffer + d_info.last_entry_offset))
+		->NextEntryOffset = 0;
+
+		rsp->StructureSize = cpu_to_le16(9);
+		rsp->OutputBufferOffset = cpu_to_le16(72);
+		rsp->OutputBufferLength = cpu_to_le32(d_info.data_count);
+		inc_rfc1001_len(rsp_org, 8 + d_info.data_count);
+	}
+
+	kfree(srch_ptr);
+	ksmbd_fd_put(work, dir_fp);
+	ksmbd_revert_fsids(work);
+	return 0;
+
+err_out:
+	pr_err("error while processing smb2 query dir rc = %d\n", rc);
+	kfree(srch_ptr);
+
+err_out2:
+	if (rc == -EINVAL)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	else if (rc == -EACCES)
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	else if (rc == -ENOENT)
+		rsp->hdr.Status = STATUS_NO_SUCH_FILE;
+	else if (rc == -EBADF)
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+	else if (rc == -ENOMEM)
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+	else if (rc == -EFAULT)
+		rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
+	if (!rsp->hdr.Status)
+		rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+
+	smb2_set_err_rsp(work);
+	ksmbd_fd_put(work, dir_fp);
+	ksmbd_revert_fsids(work);
+	return 0;
+}
+
+/**
+ * buffer_check_err() - helper function to check buffer errors
+ * @reqOutputBufferLength:	max buffer length expected in command response
+ * @rsp:		query info response buffer contains output buffer length
+ * @infoclass_size:	query info class response buffer size
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int buffer_check_err(int reqOutputBufferLength,
+			    struct smb2_query_info_rsp *rsp, int infoclass_size)
+{
+	if (reqOutputBufferLength < le32_to_cpu(rsp->OutputBufferLength)) {
+		if (reqOutputBufferLength < infoclass_size) {
+			pr_err("Invalid Buffer Size Requested\n");
+			rsp->hdr.Status = STATUS_INFO_LENGTH_MISMATCH;
+			rsp->hdr.smb2_buf_length = cpu_to_be32(sizeof(struct smb2_hdr) - 4);
+			return -EINVAL;
+		}
+
+		ksmbd_debug(SMB, "Buffer Overflow\n");
+		rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
+		rsp->hdr.smb2_buf_length = cpu_to_be32(sizeof(struct smb2_hdr) - 4 +
+				reqOutputBufferLength);
+		rsp->OutputBufferLength = cpu_to_le32(reqOutputBufferLength);
+	}
+	return 0;
+}
+
+static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp)
+{
+	struct smb2_file_standard_info *sinfo;
+
+	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
+
+	sinfo->AllocationSize = cpu_to_le64(4096);
+	sinfo->EndOfFile = cpu_to_le64(0);
+	sinfo->NumberOfLinks = cpu_to_le32(1);
+	sinfo->DeletePending = 1;
+	sinfo->Directory = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_standard_info));
+	inc_rfc1001_len(rsp, sizeof(struct smb2_file_standard_info));
+}
+
+static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num)
+{
+	struct smb2_file_internal_info *file_info;
+
+	file_info = (struct smb2_file_internal_info *)rsp->Buffer;
+
+	/* any unique number */
+	file_info->IndexNumber = cpu_to_le64(num | (1ULL << 63));
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_internal_info));
+	inc_rfc1001_len(rsp, sizeof(struct smb2_file_internal_info));
+}
+
+static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
+				   struct smb2_query_info_req *req,
+				   struct smb2_query_info_rsp *rsp)
+{
+	u64 id;
+	int rc;
+
+	/*
+	 * Windows can sometime send query file info request on
+	 * pipe without opening it, checking error condition here
+	 */
+	id = le64_to_cpu(req->VolatileFileId);
+	if (!ksmbd_session_rpc_method(sess, id))
+		return -ENOENT;
+
+	ksmbd_debug(SMB, "FileInfoClass %u, FileId 0x%llx\n",
+		    req->FileInfoClass, le64_to_cpu(req->VolatileFileId));
+
+	switch (req->FileInfoClass) {
+	case FILE_STANDARD_INFORMATION:
+		get_standard_info_pipe(rsp);
+		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+				      rsp, FILE_STANDARD_INFORMATION_SIZE);
+		break;
+	case FILE_INTERNAL_INFORMATION:
+		get_internal_info_pipe(rsp, id);
+		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+				      rsp, FILE_INTERNAL_INFORMATION_SIZE);
+		break;
+	default:
+		ksmbd_debug(SMB, "smb2_info_file_pipe for %u not supported\n",
+			    req->FileInfoClass);
+		rc = -EOPNOTSUPP;
+	}
+	return rc;
+}
+
+/**
+ * smb2_get_ea() - handler for smb2 get extended attribute command
+ * @work:	smb work containing query info command buffer
+ * @fp:		ksmbd_file pointer
+ * @req:	get extended attribute request
+ * @rsp:	response buffer pointer
+ * @rsp_org:	base response buffer pointer in case of chained response
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
+		       struct smb2_query_info_req *req,
+		       struct smb2_query_info_rsp *rsp, void *rsp_org)
+{
+	struct smb2_ea_info *eainfo, *prev_eainfo;
+	char *name, *ptr, *xattr_list = NULL, *buf;
+	int rc, name_len, value_len, xattr_list_len, idx;
+	ssize_t buf_free_len, alignment_bytes, next_offset, rsp_data_cnt = 0;
+	struct smb2_ea_info_req *ea_req = NULL;
+	struct path *path;
+	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
+
+	if (!(fp->daccess & FILE_READ_EA_LE)) {
+		pr_err("Not permitted to read ext attr : 0x%x\n",
+		       fp->daccess);
+		return -EACCES;
+	}
+
+	path = &fp->filp->f_path;
+	/* single EA entry is requested with given user.* name */
+	if (req->InputBufferLength) {
+		ea_req = (struct smb2_ea_info_req *)req->Buffer;
+	} else {
+		/* need to send all EAs, if no specific EA is requested*/
+		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
+			ksmbd_debug(SMB,
+				    "All EAs are requested but need to send single EA entry in rsp flags 0x%x\n",
+				    le32_to_cpu(req->Flags));
+	}
+
+	buf_free_len = work->response_sz -
+			(get_rfc1002_len(rsp_org) + 4) -
+			sizeof(struct smb2_query_info_rsp);
+
+	if (le32_to_cpu(req->OutputBufferLength) < buf_free_len)
+		buf_free_len = le32_to_cpu(req->OutputBufferLength);
+
+	rc = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
+	if (rc < 0) {
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+		goto out;
+	} else if (!rc) { /* there is no EA in the file */
+		ksmbd_debug(SMB, "no ea data in the file\n");
+		goto done;
+	}
+	xattr_list_len = rc;
+
+	ptr = (char *)rsp->Buffer;
+	eainfo = (struct smb2_ea_info *)ptr;
+	prev_eainfo = eainfo;
+	idx = 0;
+
+	while (idx < xattr_list_len) {
+		name = xattr_list + idx;
+		name_len = strlen(name);
+
+		ksmbd_debug(SMB, "%s, len %d\n", name, name_len);
+		idx += name_len + 1;
+
+		/*
+		 * CIFS does not support EA other than user.* namespace,
+		 * still keep the framework generic, to list other attrs
+		 * in future.
+		 */
+		if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+			continue;
+
+		if (!strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX,
+			     STREAM_PREFIX_LEN))
+			continue;
+
+		if (req->InputBufferLength &&
+		    strncmp(&name[XATTR_USER_PREFIX_LEN], ea_req->name,
+			    ea_req->EaNameLength))
+			continue;
+
+		if (!strncmp(&name[XATTR_USER_PREFIX_LEN],
+			     DOS_ATTRIBUTE_PREFIX, DOS_ATTRIBUTE_PREFIX_LEN))
+			continue;
+
+		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+			name_len -= XATTR_USER_PREFIX_LEN;
+
+		ptr = (char *)(&eainfo->name + name_len + 1);
+		buf_free_len -= (offsetof(struct smb2_ea_info, name) +
+				name_len + 1);
+		/* bailout if xattr can't fit in buf_free_len */
+		value_len = ksmbd_vfs_getxattr(user_ns, path->dentry,
+					       name, &buf);
+		if (value_len <= 0) {
+			rc = -ENOENT;
+			rsp->hdr.Status = STATUS_INVALID_HANDLE;
+			goto out;
+		}
+
+		buf_free_len -= value_len;
+		if (buf_free_len < 0) {
+			kfree(buf);
+			break;
+		}
+
+		memcpy(ptr, buf, value_len);
+		kfree(buf);
+
+		ptr += value_len;
+		eainfo->Flags = 0;
+		eainfo->EaNameLength = name_len;
+
+		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+			memcpy(eainfo->name, &name[XATTR_USER_PREFIX_LEN],
+			       name_len);
+		else
+			memcpy(eainfo->name, name, name_len);
+
+		eainfo->name[name_len] = '\0';
+		eainfo->EaValueLength = cpu_to_le16(value_len);
+		next_offset = offsetof(struct smb2_ea_info, name) +
+			name_len + 1 + value_len;
+
+		/* align next xattr entry at 4 byte bundary */
+		alignment_bytes = ((next_offset + 3) & ~3) - next_offset;
+		if (alignment_bytes) {
+			memset(ptr, '\0', alignment_bytes);
+			ptr += alignment_bytes;
+			next_offset += alignment_bytes;
+			buf_free_len -= alignment_bytes;
+		}
+		eainfo->NextEntryOffset = cpu_to_le32(next_offset);
+		prev_eainfo = eainfo;
+		eainfo = (struct smb2_ea_info *)ptr;
+		rsp_data_cnt += next_offset;
+
+		if (req->InputBufferLength) {
+			ksmbd_debug(SMB, "single entry requested\n");
+			break;
+		}
+	}
+
+	/* no more ea entries */
+	prev_eainfo->NextEntryOffset = 0;
+done:
+	rc = 0;
+	if (rsp_data_cnt == 0)
+		rsp->hdr.Status = STATUS_NO_EAS_ON_FILE;
+	rsp->OutputBufferLength = cpu_to_le32(rsp_data_cnt);
+	inc_rfc1001_len(rsp_org, rsp_data_cnt);
+out:
+	kvfree(xattr_list);
+	return rc;
+}
+
+static void get_file_access_info(struct smb2_query_info_rsp *rsp,
+				 struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_access_info *file_info;
+
+	file_info = (struct smb2_file_access_info *)rsp->Buffer;
+	file_info->AccessFlags = fp->daccess;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_access_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_access_info));
+}
+
+static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
+			       struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_all_info *basic_info;
+	struct kstat stat;
+	u64 time;
+
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		pr_err("no right to read the attributes : 0x%x\n",
+		       fp->daccess);
+		return -EACCES;
+	}
+
+	basic_info = (struct smb2_file_all_info *)rsp->Buffer;
+	generic_fillattr(file_mnt_user_ns(fp->filp), file_inode(fp->filp),
+			 &stat);
+	basic_info->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(stat.atime);
+	basic_info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.mtime);
+	basic_info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.ctime);
+	basic_info->ChangeTime = cpu_to_le64(time);
+	basic_info->Attributes = fp->f_ci->m_fattr;
+	basic_info->Pad1 = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(offsetof(struct smb2_file_all_info, AllocationSize));
+	inc_rfc1001_len(rsp_org, offsetof(struct smb2_file_all_info,
+					  AllocationSize));
+	return 0;
+}
+
+static unsigned long long get_allocation_size(struct inode *inode,
+					      struct kstat *stat)
+{
+	unsigned long long alloc_size = 0;
+
+	if (!S_ISDIR(stat->mode)) {
+		if ((inode->i_blocks << 9) <= stat->size)
+			alloc_size = stat->size;
+		else
+			alloc_size = inode->i_blocks << 9;
+	}
+
+	return alloc_size;
+}
+
+static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
+				   struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_standard_info *sinfo;
+	unsigned int delete_pending;
+	struct inode *inode;
+	struct kstat stat;
+
+	inode = file_inode(fp->filp);
+	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
+
+	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
+	delete_pending = ksmbd_inode_pending_delete(fp);
+
+	sinfo->AllocationSize = cpu_to_le64(get_allocation_size(inode, &stat));
+	sinfo->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
+	sinfo->NumberOfLinks = cpu_to_le32(get_nlink(&stat) - delete_pending);
+	sinfo->DeletePending = delete_pending;
+	sinfo->Directory = S_ISDIR(stat.mode) ? 1 : 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_standard_info));
+	inc_rfc1001_len(rsp_org,
+			sizeof(struct smb2_file_standard_info));
+}
+
+static void get_file_alignment_info(struct smb2_query_info_rsp *rsp,
+				    void *rsp_org)
+{
+	struct smb2_file_alignment_info *file_info;
+
+	file_info = (struct smb2_file_alignment_info *)rsp->Buffer;
+	file_info->AlignmentRequirement = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_alignment_info));
+	inc_rfc1001_len(rsp_org,
+			sizeof(struct smb2_file_alignment_info));
+}
+
+static int get_file_all_info(struct ksmbd_work *work,
+			     struct smb2_query_info_rsp *rsp,
+			     struct ksmbd_file *fp,
+			     void *rsp_org)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_file_all_info *file_info;
+	unsigned int delete_pending;
+	struct inode *inode;
+	struct kstat stat;
+	int conv_len;
+	char *filename;
+	u64 time;
+
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		ksmbd_debug(SMB, "no right to read the attributes : 0x%x\n",
+			    fp->daccess);
+		return -EACCES;
+	}
+
+	filename = convert_to_nt_pathname(fp->filename,
+					  work->tcon->share_conf->path);
+	if (!filename)
+		return -ENOMEM;
+
+	inode = file_inode(fp->filp);
+	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
+
+	ksmbd_debug(SMB, "filename = %s\n", filename);
+	delete_pending = ksmbd_inode_pending_delete(fp);
+	file_info = (struct smb2_file_all_info *)rsp->Buffer;
+
+	file_info->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(stat.atime);
+	file_info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.mtime);
+	file_info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.ctime);
+	file_info->ChangeTime = cpu_to_le64(time);
+	file_info->Attributes = fp->f_ci->m_fattr;
+	file_info->Pad1 = 0;
+	file_info->AllocationSize =
+		cpu_to_le64(get_allocation_size(inode, &stat));
+	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
+	file_info->NumberOfLinks =
+			cpu_to_le32(get_nlink(&stat) - delete_pending);
+	file_info->DeletePending = delete_pending;
+	file_info->Directory = S_ISDIR(stat.mode) ? 1 : 0;
+	file_info->Pad2 = 0;
+	file_info->IndexNumber = cpu_to_le64(stat.ino);
+	file_info->EASize = 0;
+	file_info->AccessFlags = fp->daccess;
+	file_info->CurrentByteOffset = cpu_to_le64(fp->filp->f_pos);
+	file_info->Mode = fp->coption;
+	file_info->AlignmentRequirement = 0;
+	conv_len = smbConvertToUTF16((__le16 *)file_info->FileName, filename,
+				     PATH_MAX, conn->local_nls, 0);
+	conv_len *= 2;
+	file_info->FileNameLength = cpu_to_le32(conv_len);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_all_info) + conv_len - 1);
+	kfree(filename);
+	inc_rfc1001_len(rsp_org, le32_to_cpu(rsp->OutputBufferLength));
+	return 0;
+}
+
+static void get_file_alternate_info(struct ksmbd_work *work,
+				    struct smb2_query_info_rsp *rsp,
+				    struct ksmbd_file *fp,
+				    void *rsp_org)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_file_alt_name_info *file_info;
+	struct dentry *dentry = fp->filp->f_path.dentry;
+	int conv_len;
+
+	spin_lock(&dentry->d_lock);
+	file_info = (struct smb2_file_alt_name_info *)rsp->Buffer;
+	conv_len = ksmbd_extract_shortname(conn,
+					   dentry->d_name.name,
+					   file_info->FileName);
+	spin_unlock(&dentry->d_lock);
+	file_info->FileNameLength = cpu_to_le32(conv_len);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_alt_name_info) + conv_len);
+	inc_rfc1001_len(rsp_org, le32_to_cpu(rsp->OutputBufferLength));
+}
+
+static void get_file_stream_info(struct ksmbd_work *work,
+				 struct smb2_query_info_rsp *rsp,
+				 struct ksmbd_file *fp,
+				 void *rsp_org)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_file_stream_info *file_info;
+	char *stream_name, *xattr_list = NULL, *stream_buf;
+	struct kstat stat;
+	struct path *path = &fp->filp->f_path;
+	ssize_t xattr_list_len;
+	int nbytes = 0, streamlen, stream_name_len, next, idx = 0;
+
+	generic_fillattr(file_mnt_user_ns(fp->filp), file_inode(fp->filp),
+			 &stat);
+	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
+
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_debug(SMB, "empty xattr in the file\n");
+		goto out;
+	}
+
+	while (idx < xattr_list_len) {
+		stream_name = xattr_list + idx;
+		streamlen = strlen(stream_name);
+		idx += streamlen + 1;
+
+		ksmbd_debug(SMB, "%s, len %d\n", stream_name, streamlen);
+
+		if (strncmp(&stream_name[XATTR_USER_PREFIX_LEN],
+			    STREAM_PREFIX, STREAM_PREFIX_LEN))
+			continue;
+
+		stream_name_len = streamlen - (XATTR_USER_PREFIX_LEN +
+				STREAM_PREFIX_LEN);
+		streamlen = stream_name_len;
+
+		/* plus : size */
+		streamlen += 1;
+		stream_buf = kmalloc(streamlen + 1, GFP_KERNEL);
+		if (!stream_buf)
+			break;
+
+		streamlen = snprintf(stream_buf, streamlen + 1,
+				     ":%s", &stream_name[XATTR_NAME_STREAM_LEN]);
+
+		file_info = (struct smb2_file_stream_info *)&rsp->Buffer[nbytes];
+		streamlen  = smbConvertToUTF16((__le16 *)file_info->StreamName,
+					       stream_buf, streamlen,
+					       conn->local_nls, 0);
+		streamlen *= 2;
+		kfree(stream_buf);
+		file_info->StreamNameLength = cpu_to_le32(streamlen);
+		file_info->StreamSize = cpu_to_le64(stream_name_len);
+		file_info->StreamAllocationSize = cpu_to_le64(stream_name_len);
+
+		next = sizeof(struct smb2_file_stream_info) + streamlen;
+		nbytes += next;
+		file_info->NextEntryOffset = cpu_to_le32(next);
+	}
+
+	if (nbytes) {
+		file_info = (struct smb2_file_stream_info *)
+			&rsp->Buffer[nbytes];
+		streamlen = smbConvertToUTF16((__le16 *)file_info->StreamName,
+					      "::$DATA", 7, conn->local_nls, 0);
+		streamlen *= 2;
+		file_info->StreamNameLength = cpu_to_le32(streamlen);
+		file_info->StreamSize = S_ISDIR(stat.mode) ? 0 :
+			cpu_to_le64(stat.size);
+		file_info->StreamAllocationSize = S_ISDIR(stat.mode) ? 0 :
+			cpu_to_le64(stat.size);
+		nbytes += sizeof(struct smb2_file_stream_info) + streamlen;
+	}
+
+	/* last entry offset should be 0 */
+	file_info->NextEntryOffset = 0;
+out:
+	kvfree(xattr_list);
+
+	rsp->OutputBufferLength = cpu_to_le32(nbytes);
+	inc_rfc1001_len(rsp_org, nbytes);
+}
+
+static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
+				   struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_internal_info *file_info;
+	struct kstat stat;
+
+	generic_fillattr(file_mnt_user_ns(fp->filp), file_inode(fp->filp),
+			 &stat);
+	file_info = (struct smb2_file_internal_info *)rsp->Buffer;
+	file_info->IndexNumber = cpu_to_le64(stat.ino);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_internal_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_internal_info));
+}
+
+static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
+				      struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_ntwrk_info *file_info;
+	struct inode *inode;
+	struct kstat stat;
+	u64 time;
+
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		pr_err("no right to read the attributes : 0x%x\n",
+		       fp->daccess);
+		return -EACCES;
+	}
+
+	file_info = (struct smb2_file_ntwrk_info *)rsp->Buffer;
+
+	inode = file_inode(fp->filp);
+	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
+
+	file_info->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(stat.atime);
+	file_info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.mtime);
+	file_info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.ctime);
+	file_info->ChangeTime = cpu_to_le64(time);
+	file_info->Attributes = fp->f_ci->m_fattr;
+	file_info->AllocationSize =
+		cpu_to_le64(get_allocation_size(inode, &stat));
+	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
+	file_info->Reserved = cpu_to_le32(0);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_ntwrk_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_ntwrk_info));
+	return 0;
+}
+
+static void get_file_ea_info(struct smb2_query_info_rsp *rsp, void *rsp_org)
+{
+	struct smb2_file_ea_info *file_info;
+
+	file_info = (struct smb2_file_ea_info *)rsp->Buffer;
+	file_info->EASize = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_ea_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_ea_info));
+}
+
+static void get_file_position_info(struct smb2_query_info_rsp *rsp,
+				   struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_pos_info *file_info;
+
+	file_info = (struct smb2_file_pos_info *)rsp->Buffer;
+	file_info->CurrentByteOffset = cpu_to_le64(fp->filp->f_pos);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_pos_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_pos_info));
+}
+
+static void get_file_mode_info(struct smb2_query_info_rsp *rsp,
+			       struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_mode_info *file_info;
+
+	file_info = (struct smb2_file_mode_info *)rsp->Buffer;
+	file_info->Mode = fp->coption & FILE_MODE_INFO_MASK;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_mode_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_mode_info));
+}
+
+static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
+				      struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_comp_info *file_info;
+	struct kstat stat;
+
+	generic_fillattr(file_mnt_user_ns(fp->filp), file_inode(fp->filp),
+			 &stat);
+
+	file_info = (struct smb2_file_comp_info *)rsp->Buffer;
+	file_info->CompressedFileSize = cpu_to_le64(stat.blocks << 9);
+	file_info->CompressionFormat = COMPRESSION_FORMAT_NONE;
+	file_info->CompressionUnitShift = 0;
+	file_info->ChunkShift = 0;
+	file_info->ClusterShift = 0;
+	memset(&file_info->Reserved[0], 0, 3);
+
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_comp_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_comp_info));
+}
+
+static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
+				       struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb2_file_attr_tag_info *file_info;
+
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		pr_err("no right to read the attributes : 0x%x\n",
+		       fp->daccess);
+		return -EACCES;
+	}
+
+	file_info = (struct smb2_file_attr_tag_info *)rsp->Buffer;
+	file_info->FileAttributes = fp->f_ci->m_fattr;
+	file_info->ReparseTag = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_attr_tag_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_attr_tag_info));
+	return 0;
+}
+
+static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
+				struct ksmbd_file *fp, void *rsp_org)
+{
+	struct smb311_posix_qinfo *file_info;
+	struct inode *inode = file_inode(fp->filp);
+	u64 time;
+
+	file_info = (struct smb311_posix_qinfo *)rsp->Buffer;
+	file_info->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(inode->i_atime);
+	file_info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(inode->i_mtime);
+	file_info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(inode->i_ctime);
+	file_info->ChangeTime = cpu_to_le64(time);
+	file_info->DosAttributes = fp->f_ci->m_fattr;
+	file_info->Inode = cpu_to_le64(inode->i_ino);
+	file_info->EndOfFile = cpu_to_le64(inode->i_size);
+	file_info->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
+	file_info->HardLinks = cpu_to_le32(inode->i_nlink);
+	file_info->Mode = cpu_to_le32(inode->i_mode);
+	file_info->DeviceId = cpu_to_le32(inode->i_rdev);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb311_posix_qinfo));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb311_posix_qinfo));
+	return 0;
+}
+
+static int smb2_get_info_file(struct ksmbd_work *work,
+			      struct smb2_query_info_req *req,
+			      struct smb2_query_info_rsp *rsp, void *rsp_org)
+{
+	struct ksmbd_file *fp;
+	int fileinfoclass = 0;
+	int rc = 0;
+	int file_infoclass_size;
+	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_PIPE)) {
+		/* smb2 info file called for pipe */
+		return smb2_get_info_file_pipe(work->sess, req, rsp);
+	}
+
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
+				    work->compound_fid);
+			id = work->compound_fid;
+			pid = work->compound_pfid;
+		}
+	}
+
+	if (!has_file_id(id)) {
+		id = le64_to_cpu(req->VolatileFileId);
+		pid = le64_to_cpu(req->PersistentFileId);
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, id, pid);
+	if (!fp)
+		return -ENOENT;
+
+	fileinfoclass = req->FileInfoClass;
+
+	switch (fileinfoclass) {
+	case FILE_ACCESS_INFORMATION:
+		get_file_access_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_ACCESS_INFORMATION_SIZE;
+		break;
+
+	case FILE_BASIC_INFORMATION:
+		rc = get_file_basic_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_BASIC_INFORMATION_SIZE;
+		break;
+
+	case FILE_STANDARD_INFORMATION:
+		get_file_standard_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_STANDARD_INFORMATION_SIZE;
+		break;
+
+	case FILE_ALIGNMENT_INFORMATION:
+		get_file_alignment_info(rsp, rsp_org);
+		file_infoclass_size = FILE_ALIGNMENT_INFORMATION_SIZE;
+		break;
+
+	case FILE_ALL_INFORMATION:
+		rc = get_file_all_info(work, rsp, fp, rsp_org);
+		file_infoclass_size = FILE_ALL_INFORMATION_SIZE;
+		break;
+
+	case FILE_ALTERNATE_NAME_INFORMATION:
+		get_file_alternate_info(work, rsp, fp, rsp_org);
+		file_infoclass_size = FILE_ALTERNATE_NAME_INFORMATION_SIZE;
+		break;
+
+	case FILE_STREAM_INFORMATION:
+		get_file_stream_info(work, rsp, fp, rsp_org);
+		file_infoclass_size = FILE_STREAM_INFORMATION_SIZE;
+		break;
+
+	case FILE_INTERNAL_INFORMATION:
+		get_file_internal_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_INTERNAL_INFORMATION_SIZE;
+		break;
+
+	case FILE_NETWORK_OPEN_INFORMATION:
+		rc = get_file_network_open_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_NETWORK_OPEN_INFORMATION_SIZE;
+		break;
+
+	case FILE_EA_INFORMATION:
+		get_file_ea_info(rsp, rsp_org);
+		file_infoclass_size = FILE_EA_INFORMATION_SIZE;
+		break;
+
+	case FILE_FULL_EA_INFORMATION:
+		rc = smb2_get_ea(work, fp, req, rsp, rsp_org);
+		file_infoclass_size = FILE_FULL_EA_INFORMATION_SIZE;
+		break;
+
+	case FILE_POSITION_INFORMATION:
+		get_file_position_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_POSITION_INFORMATION_SIZE;
+		break;
+
+	case FILE_MODE_INFORMATION:
+		get_file_mode_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_MODE_INFORMATION_SIZE;
+		break;
+
+	case FILE_COMPRESSION_INFORMATION:
+		get_file_compression_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_COMPRESSION_INFORMATION_SIZE;
+		break;
+
+	case FILE_ATTRIBUTE_TAG_INFORMATION:
+		rc = get_file_attribute_tag_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_ATTRIBUTE_TAG_INFORMATION_SIZE;
+		break;
+	case SMB_FIND_FILE_POSIX_INFO:
+		if (!work->tcon->posix_extensions) {
+			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
+			rc = -EOPNOTSUPP;
+		} else {
+			rc = find_file_posix_info(rsp, fp, rsp_org);
+			file_infoclass_size = sizeof(struct smb311_posix_qinfo);
+		}
+		break;
+	default:
+		ksmbd_debug(SMB, "fileinfoclass %d not supported yet\n",
+			    fileinfoclass);
+		rc = -EOPNOTSUPP;
+	}
+	if (!rc)
+		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+				      rsp,
+				      file_infoclass_size);
+	ksmbd_fd_put(work, fp);
+	return rc;
+}
+
+static int smb2_get_info_filesystem(struct ksmbd_work *work,
+				    struct smb2_query_info_req *req,
+				    struct smb2_query_info_rsp *rsp, void *rsp_org)
+{
+	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_conn *conn = sess->conn;
+	struct ksmbd_share_config *share = work->tcon->share_conf;
+	int fsinfoclass = 0;
+	struct kstatfs stfs;
+	struct path path;
+	int rc = 0, len;
+	int fs_infoclass_size = 0;
+	int lookup_flags = 0;
+
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS))
+		lookup_flags = LOOKUP_FOLLOW;
+
+	rc = ksmbd_vfs_kern_path(share->path, lookup_flags, &path, 0);
+	if (rc) {
+		pr_err("cannot create vfs path\n");
+		return -EIO;
+	}
+
+	rc = vfs_statfs(&path, &stfs);
+	if (rc) {
+		pr_err("cannot do stat of path %s\n", share->path);
+		path_put(&path);
+		return -EIO;
+	}
+
+	fsinfoclass = req->FileInfoClass;
+
+	switch (fsinfoclass) {
+	case FS_DEVICE_INFORMATION:
+	{
+		struct filesystem_device_info *info;
+
+		info = (struct filesystem_device_info *)rsp->Buffer;
+
+		info->DeviceType = cpu_to_le32(stfs.f_type);
+		info->DeviceCharacteristics = cpu_to_le32(0x00000020);
+		rsp->OutputBufferLength = cpu_to_le32(8);
+		inc_rfc1001_len(rsp_org, 8);
+		fs_infoclass_size = FS_DEVICE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_ATTRIBUTE_INFORMATION:
+	{
+		struct filesystem_attribute_info *info;
+		size_t sz;
+
+		info = (struct filesystem_attribute_info *)rsp->Buffer;
+		info->Attributes = cpu_to_le32(FILE_SUPPORTS_OBJECT_IDS |
+					       FILE_PERSISTENT_ACLS |
+					       FILE_UNICODE_ON_DISK |
+					       FILE_CASE_PRESERVED_NAMES |
+					       FILE_CASE_SENSITIVE_SEARCH |
+					       FILE_SUPPORTS_BLOCK_REFCOUNTING);
+
+		info->Attributes |= cpu_to_le32(server_conf.share_fake_fscaps);
+
+		info->MaxPathNameComponentLength = cpu_to_le32(stfs.f_namelen);
+		len = smbConvertToUTF16((__le16 *)info->FileSystemName,
+					"NTFS", PATH_MAX, conn->local_nls, 0);
+		len = len * 2;
+		info->FileSystemNameLen = cpu_to_le32(len);
+		sz = sizeof(struct filesystem_attribute_info) - 2 + len;
+		rsp->OutputBufferLength = cpu_to_le32(sz);
+		inc_rfc1001_len(rsp_org, sz);
+		fs_infoclass_size = FS_ATTRIBUTE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_VOLUME_INFORMATION:
+	{
+		struct filesystem_vol_info *info;
+		size_t sz;
+
+		info = (struct filesystem_vol_info *)(rsp->Buffer);
+		info->VolumeCreationTime = 0;
+		/* Taking dummy value of serial number*/
+		info->SerialNumber = cpu_to_le32(0xbc3ac512);
+		len = smbConvertToUTF16((__le16 *)info->VolumeLabel,
+					share->name, PATH_MAX,
+					conn->local_nls, 0);
+		len = len * 2;
+		info->VolumeLabelSize = cpu_to_le32(len);
+		info->Reserved = 0;
+		sz = sizeof(struct filesystem_vol_info) - 2 + len;
+		rsp->OutputBufferLength = cpu_to_le32(sz);
+		inc_rfc1001_len(rsp_org, sz);
+		fs_infoclass_size = FS_VOLUME_INFORMATION_SIZE;
+		break;
+	}
+	case FS_SIZE_INFORMATION:
+	{
+		struct filesystem_info *info;
+
+		info = (struct filesystem_info *)(rsp->Buffer);
+		info->TotalAllocationUnits = cpu_to_le64(stfs.f_blocks);
+		info->FreeAllocationUnits = cpu_to_le64(stfs.f_bfree);
+		info->SectorsPerAllocationUnit = cpu_to_le32(1);
+		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
+		rsp->OutputBufferLength = cpu_to_le32(24);
+		inc_rfc1001_len(rsp_org, 24);
+		fs_infoclass_size = FS_SIZE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_FULL_SIZE_INFORMATION:
+	{
+		struct smb2_fs_full_size_info *info;
+
+		info = (struct smb2_fs_full_size_info *)(rsp->Buffer);
+		info->TotalAllocationUnits = cpu_to_le64(stfs.f_blocks);
+		info->CallerAvailableAllocationUnits =
+					cpu_to_le64(stfs.f_bavail);
+		info->ActualAvailableAllocationUnits =
+					cpu_to_le64(stfs.f_bfree);
+		info->SectorsPerAllocationUnit = cpu_to_le32(1);
+		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
+		rsp->OutputBufferLength = cpu_to_le32(32);
+		inc_rfc1001_len(rsp_org, 32);
+		fs_infoclass_size = FS_FULL_SIZE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_OBJECT_ID_INFORMATION:
+	{
+		struct object_id_info *info;
+
+		info = (struct object_id_info *)(rsp->Buffer);
+
+		if (!user_guest(sess->user))
+			memcpy(info->objid, user_passkey(sess->user), 16);
+		else
+			memset(info->objid, 0, 16);
+
+		info->extended_info.magic = cpu_to_le32(EXTENDED_INFO_MAGIC);
+		info->extended_info.version = cpu_to_le32(1);
+		info->extended_info.release = cpu_to_le32(1);
+		info->extended_info.rel_date = 0;
+		memcpy(info->extended_info.version_string, "1.1.0", strlen("1.1.0"));
+		rsp->OutputBufferLength = cpu_to_le32(64);
+		inc_rfc1001_len(rsp_org, 64);
+		fs_infoclass_size = FS_OBJECT_ID_INFORMATION_SIZE;
+		break;
+	}
+	case FS_SECTOR_SIZE_INFORMATION:
+	{
+		struct smb3_fs_ss_info *info;
+
+		info = (struct smb3_fs_ss_info *)(rsp->Buffer);
+
+		info->LogicalBytesPerSector = cpu_to_le32(stfs.f_bsize);
+		info->PhysicalBytesPerSectorForAtomicity =
+				cpu_to_le32(stfs.f_bsize);
+		info->PhysicalBytesPerSectorForPerf = cpu_to_le32(stfs.f_bsize);
+		info->FSEffPhysicalBytesPerSectorForAtomicity =
+				cpu_to_le32(stfs.f_bsize);
+		info->Flags = cpu_to_le32(SSINFO_FLAGS_ALIGNED_DEVICE |
+				    SSINFO_FLAGS_PARTITION_ALIGNED_ON_DEVICE);
+		info->ByteOffsetForSectorAlignment = 0;
+		info->ByteOffsetForPartitionAlignment = 0;
+		rsp->OutputBufferLength = cpu_to_le32(28);
+		inc_rfc1001_len(rsp_org, 28);
+		fs_infoclass_size = FS_SECTOR_SIZE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_CONTROL_INFORMATION:
+	{
+		/*
+		 * TODO : The current implementation is based on
+		 * test result with win7(NTFS) server. It's need to
+		 * modify this to get valid Quota values
+		 * from Linux kernel
+		 */
+		struct smb2_fs_control_info *info;
+
+		info = (struct smb2_fs_control_info *)(rsp->Buffer);
+		info->FreeSpaceStartFiltering = 0;
+		info->FreeSpaceThreshold = 0;
+		info->FreeSpaceStopFiltering = 0;
+		info->DefaultQuotaThreshold = cpu_to_le64(SMB2_NO_FID);
+		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
+		info->Padding = 0;
+		rsp->OutputBufferLength = cpu_to_le32(48);
+		inc_rfc1001_len(rsp_org, 48);
+		fs_infoclass_size = FS_CONTROL_INFORMATION_SIZE;
+		break;
+	}
+	case FS_POSIX_INFORMATION:
+	{
+		struct filesystem_posix_info *info;
+
+		if (!work->tcon->posix_extensions) {
+			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
+			rc = -EOPNOTSUPP;
+		} else {
+			info = (struct filesystem_posix_info *)(rsp->Buffer);
+			info->OptimalTransferSize = cpu_to_le32(stfs.f_bsize);
+			info->BlockSize = cpu_to_le32(stfs.f_bsize);
+			info->TotalBlocks = cpu_to_le64(stfs.f_blocks);
+			info->BlocksAvail = cpu_to_le64(stfs.f_bfree);
+			info->UserBlocksAvail = cpu_to_le64(stfs.f_bavail);
+			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
+			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
+			rsp->OutputBufferLength = cpu_to_le32(56);
+			inc_rfc1001_len(rsp_org, 56);
+			fs_infoclass_size = FS_POSIX_INFORMATION_SIZE;
+		}
+		break;
+	}
+	default:
+		path_put(&path);
+		return -EOPNOTSUPP;
+	}
+	rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+			      rsp,
+			      fs_infoclass_size);
+	path_put(&path);
+	return rc;
+}
+
+static int smb2_get_info_sec(struct ksmbd_work *work,
+			     struct smb2_query_info_req *req,
+			     struct smb2_query_info_rsp *rsp, void *rsp_org)
+{
+	struct ksmbd_file *fp;
+	struct user_namespace *user_ns;
+	struct smb_ntsd *pntsd = (struct smb_ntsd *)rsp->Buffer, *ppntsd = NULL;
+	struct smb_fattr fattr = {{0}};
+	struct inode *inode;
+	__u32 secdesclen;
+	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
+	int addition_info = le32_to_cpu(req->AdditionalInformation);
+	int rc;
+
+	if (addition_info & ~(OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO |
+			      PROTECTED_DACL_SECINFO |
+			      UNPROTECTED_DACL_SECINFO)) {
+		pr_err("Unsupported addition info: 0x%x)\n",
+		       addition_info);
+
+		pntsd->revision = cpu_to_le16(1);
+		pntsd->type = cpu_to_le16(SELF_RELATIVE | DACL_PROTECTED);
+		pntsd->osidoffset = 0;
+		pntsd->gsidoffset = 0;
+		pntsd->sacloffset = 0;
+		pntsd->dacloffset = 0;
+
+		secdesclen = sizeof(struct smb_ntsd);
+		rsp->OutputBufferLength = cpu_to_le32(secdesclen);
+		inc_rfc1001_len(rsp_org, secdesclen);
+
+		return 0;
+	}
+
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
+				    work->compound_fid);
+			id = work->compound_fid;
+			pid = work->compound_pfid;
+		}
+	}
+
+	if (!has_file_id(id)) {
+		id = le64_to_cpu(req->VolatileFileId);
+		pid = le64_to_cpu(req->PersistentFileId);
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, id, pid);
+	if (!fp)
+		return -ENOENT;
+
+	user_ns = file_mnt_user_ns(fp->filp);
+	inode = file_inode(fp->filp);
+	ksmbd_acls_fattr(&fattr, inode);
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_ACL_XATTR))
+		ksmbd_vfs_get_sd_xattr(work->conn, user_ns,
+				       fp->filp->f_path.dentry, &ppntsd);
+
+	rc = build_sec_desc(user_ns, pntsd, ppntsd, addition_info,
+			    &secdesclen, &fattr);
+	posix_acl_release(fattr.cf_acls);
+	posix_acl_release(fattr.cf_dacls);
+	kfree(ppntsd);
+	ksmbd_fd_put(work, fp);
+	if (rc)
+		return rc;
+
+	rsp->OutputBufferLength = cpu_to_le32(secdesclen);
+	inc_rfc1001_len(rsp_org, secdesclen);
+	return 0;
+}
+
+/**
+ * smb2_query_info() - handler for smb2 query info command
+ * @work:	smb work containing query info request buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_query_info(struct ksmbd_work *work)
+{
+	struct smb2_query_info_req *req;
+	struct smb2_query_info_rsp *rsp, *rsp_org;
+	int rc = 0;
+
+	rsp_org = work->response_buf;
+	WORK_BUFFERS(work, req, rsp);
+
+	ksmbd_debug(SMB, "GOT query info request\n");
+
+	switch (req->InfoType) {
+	case SMB2_O_INFO_FILE:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
+		rc = smb2_get_info_file(work, req, rsp, (void *)rsp_org);
+		break;
+	case SMB2_O_INFO_FILESYSTEM:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILESYSTEM\n");
+		rc = smb2_get_info_filesystem(work, req, rsp, (void *)rsp_org);
+		break;
+	case SMB2_O_INFO_SECURITY:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
+		rc = smb2_get_info_sec(work, req, rsp, (void *)rsp_org);
+		break;
+	default:
+		ksmbd_debug(SMB, "InfoType %d not supported yet\n",
+			    req->InfoType);
+		rc = -EOPNOTSUPP;
+	}
+
+	if (rc < 0) {
+		if (rc == -EACCES)
+			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		else if (rc == -ENOENT)
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+		else if (rc == -EIO)
+			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+		else if (rc == -EOPNOTSUPP || rsp->hdr.Status == 0)
+			rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
+		smb2_set_err_rsp(work);
+
+		ksmbd_debug(SMB, "error while processing smb2 query rc = %d\n",
+			    rc);
+		return rc;
+	}
+	rsp->StructureSize = cpu_to_le16(9);
+	rsp->OutputBufferOffset = cpu_to_le16(72);
+	inc_rfc1001_len(rsp_org, 8);
+	return 0;
+}
+
+/**
+ * smb2_close_pipe() - handler for closing IPC pipe
+ * @work:	smb work containing close request buffer
+ *
+ * Return:	0
+ */
+static noinline int smb2_close_pipe(struct ksmbd_work *work)
+{
+	u64 id;
+	struct smb2_close_req *req = work->request_buf;
+	struct smb2_close_rsp *rsp = work->response_buf;
+
+	id = le64_to_cpu(req->VolatileFileId);
+	ksmbd_session_rpc_close(work->sess, id);
+
+	rsp->StructureSize = cpu_to_le16(60);
+	rsp->Flags = 0;
+	rsp->Reserved = 0;
+	rsp->CreationTime = 0;
+	rsp->LastAccessTime = 0;
+	rsp->LastWriteTime = 0;
+	rsp->ChangeTime = 0;
+	rsp->AllocationSize = 0;
+	rsp->EndOfFile = 0;
+	rsp->Attributes = 0;
+	inc_rfc1001_len(rsp, 60);
+	return 0;
+}
+
+/**
+ * smb2_close() - handler for smb2 close file command
+ * @work:	smb work containing close request buffer
+ *
+ * Return:	0
+ */
+int smb2_close(struct ksmbd_work *work)
+{
+	u64 volatile_id = KSMBD_NO_FID;
+	u64 sess_id;
+	struct smb2_close_req *req;
+	struct smb2_close_rsp *rsp;
+	struct smb2_close_rsp *rsp_org;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_file *fp;
+	struct inode *inode;
+	u64 time;
+	int err = 0;
+
+	rsp_org = work->response_buf;
+	WORK_BUFFERS(work, req, rsp);
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC pipe close request\n");
+		return smb2_close_pipe(work);
+	}
+
+	sess_id = le64_to_cpu(req->hdr.SessionId);
+	if (req->hdr.Flags & SMB2_FLAGS_RELATED_OPERATIONS)
+		sess_id = work->compound_sid;
+
+	work->compound_sid = 0;
+	if (check_session_id(conn, sess_id)) {
+		work->compound_sid = sess_id;
+	} else {
+		rsp->hdr.Status = STATUS_USER_SESSION_DELETED;
+		if (req->hdr.Flags & SMB2_FLAGS_RELATED_OPERATIONS)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		err = -EBADF;
+		goto out;
+	}
+
+	if (work->next_smb2_rcv_hdr_off &&
+	    !has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(work->compound_fid)) {
+			/* file already closed, return FILE_CLOSED */
+			ksmbd_debug(SMB, "file already closed\n");
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+			err = -EBADF;
+			goto out;
+		} else {
+			ksmbd_debug(SMB,
+				    "Compound request set FID = %llu:%llu\n",
+				    work->compound_fid,
+				    work->compound_pfid);
+			volatile_id = work->compound_fid;
+
+			/* file closed, stored id is not valid anymore */
+			work->compound_fid = KSMBD_NO_FID;
+			work->compound_pfid = KSMBD_NO_FID;
+		}
+	} else {
+		volatile_id = le64_to_cpu(req->VolatileFileId);
+	}
+	ksmbd_debug(SMB, "volatile_id = %llu\n", volatile_id);
+
+	rsp->StructureSize = cpu_to_le16(60);
+	rsp->Reserved = 0;
+
+	if (req->Flags == SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB) {
+		fp = ksmbd_lookup_fd_fast(work, volatile_id);
+		if (!fp) {
+			err = -ENOENT;
+			goto out;
+		}
+
+		inode = file_inode(fp->filp);
+		rsp->Flags = SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB;
+		rsp->AllocationSize = S_ISDIR(inode->i_mode) ? 0 :
+			cpu_to_le64(inode->i_blocks << 9);
+		rsp->EndOfFile = cpu_to_le64(inode->i_size);
+		rsp->Attributes = fp->f_ci->m_fattr;
+		rsp->CreationTime = cpu_to_le64(fp->create_time);
+		time = ksmbd_UnixTimeToNT(inode->i_atime);
+		rsp->LastAccessTime = cpu_to_le64(time);
+		time = ksmbd_UnixTimeToNT(inode->i_mtime);
+		rsp->LastWriteTime = cpu_to_le64(time);
+		time = ksmbd_UnixTimeToNT(inode->i_ctime);
+		rsp->ChangeTime = cpu_to_le64(time);
+		ksmbd_fd_put(work, fp);
+	} else {
+		rsp->Flags = 0;
+		rsp->AllocationSize = 0;
+		rsp->EndOfFile = 0;
+		rsp->Attributes = 0;
+		rsp->CreationTime = 0;
+		rsp->LastAccessTime = 0;
+		rsp->LastWriteTime = 0;
+		rsp->ChangeTime = 0;
+	}
+
+	err = ksmbd_close_fd(work, volatile_id);
+out:
+	if (err) {
+		if (rsp->hdr.Status == 0)
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+		smb2_set_err_rsp(work);
+	} else {
+		inc_rfc1001_len(rsp_org, 60);
+	}
+
+	return 0;
+}
+
+/**
+ * smb2_echo() - handler for smb2 echo(ping) command
+ * @work:	smb work containing echo request buffer
+ *
+ * Return:	0
+ */
+int smb2_echo(struct ksmbd_work *work)
+{
+	struct smb2_echo_rsp *rsp = work->response_buf;
+
+	rsp->StructureSize = cpu_to_le16(4);
+	rsp->Reserved = 0;
+	inc_rfc1001_len(rsp, 4);
+	return 0;
+}
+
+static int smb2_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
+		       struct smb2_file_rename_info *file_info,
+		       struct nls_table *local_nls)
+{
+	struct ksmbd_share_config *share = fp->tcon->share_conf;
+	char *new_name = NULL, *abs_oldname = NULL, *old_name = NULL;
+	char *pathname = NULL;
+	struct path path;
+	bool file_present = true;
+	int rc;
+
+	ksmbd_debug(SMB, "setting FILE_RENAME_INFO\n");
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return -ENOMEM;
+
+	abs_oldname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
+	if (IS_ERR(abs_oldname)) {
+		rc = -EINVAL;
+		goto out;
+	}
+	old_name = strrchr(abs_oldname, '/');
+	if (old_name && old_name[1] != '\0') {
+		old_name++;
+	} else {
+		ksmbd_debug(SMB, "can't get last component in path %s\n",
+			    abs_oldname);
+		rc = -ENOENT;
+		goto out;
+	}
+
+	new_name = smb2_get_name(share,
+				 file_info->FileName,
+				 le32_to_cpu(file_info->FileNameLength),
+				 local_nls);
+	if (IS_ERR(new_name)) {
+		rc = PTR_ERR(new_name);
+		goto out;
+	}
+
+	if (strchr(new_name, ':')) {
+		int s_type;
+		char *xattr_stream_name, *stream_name = NULL;
+		size_t xattr_stream_size;
+		int len;
+
+		rc = parse_stream_name(new_name, &stream_name, &s_type);
+		if (rc < 0)
+			goto out;
+
+		len = strlen(new_name);
+		if (new_name[len - 1] != '/') {
+			pr_err("not allow base filename in rename\n");
+			rc = -ESHARE;
+			goto out;
+		}
+
+		rc = ksmbd_vfs_xattr_stream_name(stream_name,
+						 &xattr_stream_name,
+						 &xattr_stream_size,
+						 s_type);
+		if (rc)
+			goto out;
+
+		rc = ksmbd_vfs_setxattr(file_mnt_user_ns(fp->filp),
+					fp->filp->f_path.dentry,
+					xattr_stream_name,
+					NULL, 0, 0);
+		if (rc < 0) {
+			pr_err("failed to store stream name in xattr: %d\n",
+			       rc);
+			rc = -EINVAL;
+			goto out;
+		}
+
+		goto out;
+	}
+
+	ksmbd_debug(SMB, "new name %s\n", new_name);
+	rc = ksmbd_vfs_kern_path(new_name, 0, &path, 1);
+	if (rc)
+		file_present = false;
+	else
+		path_put(&path);
+
+	if (ksmbd_share_veto_filename(share, new_name)) {
+		rc = -ENOENT;
+		ksmbd_debug(SMB, "Can't rename vetoed file: %s\n", new_name);
+		goto out;
+	}
+
+	if (file_info->ReplaceIfExists) {
+		if (file_present) {
+			rc = ksmbd_vfs_remove_file(work, new_name);
+			if (rc) {
+				if (rc != -ENOTEMPTY)
+					rc = -EINVAL;
+				ksmbd_debug(SMB, "cannot delete %s, rc %d\n",
+					    new_name, rc);
+				goto out;
+			}
+		}
+	} else {
+		if (file_present &&
+		    strncmp(old_name, path.dentry->d_name.name, strlen(old_name))) {
+			rc = -EEXIST;
+			ksmbd_debug(SMB,
+				    "cannot rename already existing file\n");
+			goto out;
+		}
+	}
+
+	rc = ksmbd_vfs_fp_rename(work, fp, new_name);
+out:
+	kfree(pathname);
+	if (!IS_ERR(new_name))
+		kfree(new_name);
+	return rc;
+}
+
+static int smb2_create_link(struct ksmbd_work *work,
+			    struct ksmbd_share_config *share,
+			    struct smb2_file_link_info *file_info,
+			    struct file *filp,
+			    struct nls_table *local_nls)
+{
+	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
+	struct path path;
+	bool file_present = true;
+	int rc;
+
+	ksmbd_debug(SMB, "setting FILE_LINK_INFORMATION\n");
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return -ENOMEM;
+
+	link_name = smb2_get_name(share,
+				  file_info->FileName,
+				  le32_to_cpu(file_info->FileNameLength),
+				  local_nls);
+	if (IS_ERR(link_name) || S_ISDIR(file_inode(filp)->i_mode)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	ksmbd_debug(SMB, "link name is %s\n", link_name);
+	target_name = d_path(&filp->f_path, pathname, PATH_MAX);
+	if (IS_ERR(target_name)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	ksmbd_debug(SMB, "target name is %s\n", target_name);
+	rc = ksmbd_vfs_kern_path(link_name, 0, &path, 0);
+	if (rc)
+		file_present = false;
+	else
+		path_put(&path);
+
+	if (file_info->ReplaceIfExists) {
+		if (file_present) {
+			rc = ksmbd_vfs_remove_file(work, link_name);
+			if (rc) {
+				rc = -EINVAL;
+				ksmbd_debug(SMB, "cannot delete %s\n",
+					    link_name);
+				goto out;
+			}
+		}
+	} else {
+		if (file_present) {
+			rc = -EEXIST;
+			ksmbd_debug(SMB, "link already exists\n");
+			goto out;
+		}
+	}
+
+	rc = ksmbd_vfs_link(work, target_name, link_name);
+	if (rc)
+		rc = -EINVAL;
+out:
+	if (!IS_ERR(link_name))
+		kfree(link_name);
+	kfree(pathname);
+	return rc;
+}
+
+static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
+			       struct ksmbd_share_config *share)
+{
+	struct smb2_file_all_info *file_info;
+	struct iattr attrs;
+	struct iattr temp_attrs;
+	struct file *filp;
+	struct inode *inode;
+	struct user_namespace *user_ns;
+	int rc;
+
+	if (!(fp->daccess & FILE_WRITE_ATTRIBUTES_LE))
+		return -EACCES;
+
+	file_info = (struct smb2_file_all_info *)buf;
+	attrs.ia_valid = 0;
+	filp = fp->filp;
+	inode = file_inode(filp);
+	user_ns = file_mnt_user_ns(filp);
+
+	if (file_info->CreationTime)
+		fp->create_time = le64_to_cpu(file_info->CreationTime);
+
+	if (file_info->LastAccessTime) {
+		attrs.ia_atime = ksmbd_NTtimeToUnix(file_info->LastAccessTime);
+		attrs.ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
+	}
+
+	if (file_info->ChangeTime) {
+		temp_attrs.ia_ctime = ksmbd_NTtimeToUnix(file_info->ChangeTime);
+		attrs.ia_ctime = temp_attrs.ia_ctime;
+		attrs.ia_valid |= ATTR_CTIME;
+	} else {
+		temp_attrs.ia_ctime = inode->i_ctime;
+	}
+
+	if (file_info->LastWriteTime) {
+		attrs.ia_mtime = ksmbd_NTtimeToUnix(file_info->LastWriteTime);
+		attrs.ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
+	}
+
+	if (file_info->Attributes) {
+		if (!S_ISDIR(inode->i_mode) &&
+		    file_info->Attributes & ATTR_DIRECTORY_LE) {
+			pr_err("can't change a file to a directory\n");
+			return -EINVAL;
+		}
+
+		if (!(S_ISDIR(inode->i_mode) && file_info->Attributes == ATTR_NORMAL_LE))
+			fp->f_ci->m_fattr = file_info->Attributes |
+				(fp->f_ci->m_fattr & ATTR_DIRECTORY_LE);
+	}
+
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_STORE_DOS_ATTRS) &&
+	    (file_info->CreationTime || file_info->Attributes)) {
+		struct xattr_dos_attrib da = {0};
+
+		da.version = 4;
+		da.itime = fp->itime;
+		da.create_time = fp->create_time;
+		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
+			XATTR_DOSINFO_ITIME;
+
+		rc = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
+						    filp->f_path.dentry, &da);
+		if (rc)
+			ksmbd_debug(SMB,
+				    "failed to restore file attribute in EA\n");
+		rc = 0;
+	}
+
+	/*
+	 * HACK : set ctime here to avoid ctime changed
+	 * when file_info->ChangeTime is zero.
+	 */
+	attrs.ia_ctime = temp_attrs.ia_ctime;
+	attrs.ia_valid |= ATTR_CTIME;
+
+	if (attrs.ia_valid) {
+		struct dentry *dentry = filp->f_path.dentry;
+		struct inode *inode = d_inode(dentry);
+
+		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+			return -EACCES;
+
+		rc = setattr_prepare(user_ns, dentry, &attrs);
+		if (rc)
+			return -EINVAL;
+
+		inode_lock(inode);
+		setattr_copy(user_ns, inode, &attrs);
+		attrs.ia_valid &= ~ATTR_CTIME;
+		rc = notify_change(user_ns, dentry, &attrs, NULL);
+		inode_unlock(inode);
+	}
+	return 0;
+}
+
+static int set_file_allocation_info(struct ksmbd_work *work,
+				    struct ksmbd_file *fp, char *buf)
+{
+	/*
+	 * TODO : It's working fine only when store dos attributes
+	 * is not yes. need to implement a logic which works
+	 * properly with any smb.conf option
+	 */
+
+	struct smb2_file_alloc_info *file_alloc_info;
+	loff_t alloc_blks;
+	struct inode *inode;
+	int rc;
+
+	if (!(fp->daccess & FILE_WRITE_DATA_LE))
+		return -EACCES;
+
+	file_alloc_info = (struct smb2_file_alloc_info *)buf;
+	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
+	inode = file_inode(fp->filp);
+
+	if (alloc_blks > inode->i_blocks) {
+		smb_break_all_levII_oplock(work, fp, 1);
+		rc = vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0,
+				   alloc_blks * 512);
+		if (rc && rc != -EOPNOTSUPP) {
+			pr_err("vfs_fallocate is failed : %d\n", rc);
+			return rc;
+		}
+	} else if (alloc_blks < inode->i_blocks) {
+		loff_t size;
+
+		/*
+		 * Allocation size could be smaller than original one
+		 * which means allocated blocks in file should be
+		 * deallocated. use truncate to cut out it, but inode
+		 * size is also updated with truncate offset.
+		 * inode size is retained by backup inode size.
+		 */
+		size = i_size_read(inode);
+		rc = ksmbd_vfs_truncate(work, NULL, fp, alloc_blks * 512);
+		if (rc) {
+			pr_err("truncate failed! filename : %s, err %d\n",
+			       fp->filename, rc);
+			return rc;
+		}
+		if (size < alloc_blks * 512)
+			i_size_write(inode, size);
+	}
+	return 0;
+}
+
+static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
+				char *buf)
+{
+	struct smb2_file_eof_info *file_eof_info;
+	loff_t newsize;
+	struct inode *inode;
+	int rc;
+
+	if (!(fp->daccess & FILE_WRITE_DATA_LE))
+		return -EACCES;
+
+	file_eof_info = (struct smb2_file_eof_info *)buf;
+	newsize = le64_to_cpu(file_eof_info->EndOfFile);
+	inode = file_inode(fp->filp);
+
+	/*
+	 * If FILE_END_OF_FILE_INFORMATION of set_info_file is called
+	 * on FAT32 shared device, truncate execution time is too long
+	 * and network error could cause from windows client. because
+	 * truncate of some filesystem like FAT32 fill zero data in
+	 * truncated range.
+	 */
+	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
+		ksmbd_debug(SMB, "filename : %s truncated to newsize %lld\n",
+			    fp->filename, newsize);
+		rc = ksmbd_vfs_truncate(work, NULL, fp, newsize);
+		if (rc) {
+			ksmbd_debug(SMB, "truncate failed! filename : %s err %d\n",
+				    fp->filename, rc);
+			if (rc != -EAGAIN)
+				rc = -EBADF;
+			return rc;
+		}
+	}
+	return 0;
+}
+
+static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
+			   char *buf)
+{
+	struct ksmbd_file *parent_fp;
+	struct dentry *parent;
+	struct dentry *dentry = fp->filp->f_path.dentry;
+	int ret;
+
+	if (!(fp->daccess & FILE_DELETE_LE)) {
+		pr_err("no right to delete : 0x%x\n", fp->daccess);
+		return -EACCES;
+	}
+
+	if (ksmbd_stream_fd(fp))
+		goto next;
+
+	parent = dget_parent(dentry);
+	ret = ksmbd_vfs_lock_parent(parent, dentry);
+	if (ret) {
+		dput(parent);
+		return ret;
+	}
+
+	parent_fp = ksmbd_lookup_fd_inode(d_inode(parent));
+	inode_unlock(d_inode(parent));
+	dput(parent);
+
+	if (parent_fp) {
+		if (parent_fp->daccess & FILE_DELETE_LE) {
+			pr_err("parent dir is opened with delete access\n");
+			return -ESHARE;
+		}
+	}
+next:
+	return smb2_rename(work, fp,
+			   (struct smb2_file_rename_info *)buf,
+			   work->sess->conn->local_nls);
+}
+
+static int set_file_disposition_info(struct ksmbd_file *fp, char *buf)
+{
+	struct smb2_file_disposition_info *file_info;
+	struct inode *inode;
+
+	if (!(fp->daccess & FILE_DELETE_LE)) {
+		pr_err("no right to delete : 0x%x\n", fp->daccess);
+		return -EACCES;
+	}
+
+	inode = file_inode(fp->filp);
+	file_info = (struct smb2_file_disposition_info *)buf;
+	if (file_info->DeletePending) {
+		if (S_ISDIR(inode->i_mode) &&
+		    ksmbd_vfs_empty_dir(fp) == -ENOTEMPTY)
+			return -EBUSY;
+		ksmbd_set_inode_pending_delete(fp);
+	} else {
+		ksmbd_clear_inode_pending_delete(fp);
+	}
+	return 0;
+}
+
+static int set_file_position_info(struct ksmbd_file *fp, char *buf)
+{
+	struct smb2_file_pos_info *file_info;
+	loff_t current_byte_offset;
+	unsigned long sector_size;
+	struct inode *inode;
+
+	inode = file_inode(fp->filp);
+	file_info = (struct smb2_file_pos_info *)buf;
+	current_byte_offset = le64_to_cpu(file_info->CurrentByteOffset);
+	sector_size = inode->i_sb->s_blocksize;
+
+	if (current_byte_offset < 0 ||
+	    (fp->coption == FILE_NO_INTERMEDIATE_BUFFERING_LE &&
+	     current_byte_offset & (sector_size - 1))) {
+		pr_err("CurrentByteOffset is not valid : %llu\n",
+		       current_byte_offset);
+		return -EINVAL;
+	}
+
+	fp->filp->f_pos = current_byte_offset;
+	return 0;
+}
+
+static int set_file_mode_info(struct ksmbd_file *fp, char *buf)
+{
+	struct smb2_file_mode_info *file_info;
+	__le32 mode;
+
+	file_info = (struct smb2_file_mode_info *)buf;
+	mode = file_info->Mode;
+
+	if ((mode & ~FILE_MODE_INFO_MASK) ||
+	    (mode & FILE_SYNCHRONOUS_IO_ALERT_LE &&
+	     mode & FILE_SYNCHRONOUS_IO_NONALERT_LE)) {
+		pr_err("Mode is not valid : 0x%x\n", le32_to_cpu(mode));
+		return -EINVAL;
+	}
+
+	/*
+	 * TODO : need to implement consideration for
+	 * FILE_SYNCHRONOUS_IO_ALERT and FILE_SYNCHRONOUS_IO_NONALERT
+	 */
+	ksmbd_vfs_set_fadvise(fp->filp, mode);
+	fp->coption = mode;
+	return 0;
+}
+
+/**
+ * smb2_set_info_file() - handler for smb2 set info command
+ * @work:	smb work containing set info command buffer
+ * @fp:		ksmbd_file pointer
+ * @info_class:	smb2 set info class
+ * @share:	ksmbd_share_config pointer
+ *
+ * Return:	0 on success, otherwise error
+ * TODO: need to implement an error handling for STATUS_INFO_LENGTH_MISMATCH
+ */
+static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
+			      int info_class, char *buf,
+			      struct ksmbd_share_config *share)
+{
+	switch (info_class) {
+	case FILE_BASIC_INFORMATION:
+		return set_file_basic_info(fp, buf, share);
+
+	case FILE_ALLOCATION_INFORMATION:
+		return set_file_allocation_info(work, fp, buf);
+
+	case FILE_END_OF_FILE_INFORMATION:
+		return set_end_of_file_info(work, fp, buf);
+
+	case FILE_RENAME_INFORMATION:
+		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ksmbd_debug(SMB,
+				    "User does not have write permission\n");
+			return -EACCES;
+		}
+		return set_rename_info(work, fp, buf);
+
+	case FILE_LINK_INFORMATION:
+		return smb2_create_link(work, work->tcon->share_conf,
+					(struct smb2_file_link_info *)buf, fp->filp,
+					work->sess->conn->local_nls);
+
+	case FILE_DISPOSITION_INFORMATION:
+		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ksmbd_debug(SMB,
+				    "User does not have write permission\n");
+			return -EACCES;
+		}
+		return set_file_disposition_info(fp, buf);
+
+	case FILE_FULL_EA_INFORMATION:
+	{
+		if (!(fp->daccess & FILE_WRITE_EA_LE)) {
+			pr_err("Not permitted to write ext  attr: 0x%x\n",
+			       fp->daccess);
+			return -EACCES;
+		}
+
+		return smb2_set_ea((struct smb2_ea_info *)buf,
+				   &fp->filp->f_path);
+	}
+
+	case FILE_POSITION_INFORMATION:
+		return set_file_position_info(fp, buf);
+
+	case FILE_MODE_INFORMATION:
+		return set_file_mode_info(fp, buf);
+	}
+
+	pr_err("Unimplemented Fileinfoclass :%d\n", info_class);
+	return -EOPNOTSUPP;
+}
+
+static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
+			     char *buffer, int buf_len)
+{
+	struct smb_ntsd *pntsd = (struct smb_ntsd *)buffer;
+
+	fp->saccess |= FILE_SHARE_DELETE_LE;
+
+	return set_info_sec(fp->conn, fp->tcon, &fp->filp->f_path, pntsd,
+			buf_len, false);
+}
+
+/**
+ * smb2_set_info() - handler for smb2 set info command handler
+ * @work:	smb work containing set info request buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_set_info(struct ksmbd_work *work)
+{
+	struct smb2_set_info_req *req;
+	struct smb2_set_info_rsp *rsp, *rsp_org;
+	struct ksmbd_file *fp;
+	int rc = 0;
+	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
+
+	ksmbd_debug(SMB, "Received set info request\n");
+
+	rsp_org = work->response_buf;
+	if (work->next_smb2_rcv_hdr_off) {
+		req = ksmbd_req_buf_next(work);
+		rsp = ksmbd_resp_buf_next(work);
+		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
+				    work->compound_fid);
+			id = work->compound_fid;
+			pid = work->compound_pfid;
+		}
+	} else {
+		req = work->request_buf;
+		rsp = work->response_buf;
+	}
+
+	if (!has_file_id(id)) {
+		id = le64_to_cpu(req->VolatileFileId);
+		pid = le64_to_cpu(req->PersistentFileId);
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, id, pid);
+	if (!fp) {
+		ksmbd_debug(SMB, "Invalid id for close: %u\n", id);
+		rc = -ENOENT;
+		goto err_out;
+	}
+
+	switch (req->InfoType) {
+	case SMB2_O_INFO_FILE:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
+		rc = smb2_set_info_file(work, fp, req->FileInfoClass,
+					req->Buffer, work->tcon->share_conf);
+		break;
+	case SMB2_O_INFO_SECURITY:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
+		rc = smb2_set_info_sec(fp,
+				       le32_to_cpu(req->AdditionalInformation),
+				       req->Buffer,
+				       le32_to_cpu(req->BufferLength));
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	if (rc < 0)
+		goto err_out;
+
+	rsp->StructureSize = cpu_to_le16(2);
+	inc_rfc1001_len(rsp_org, 2);
+	ksmbd_fd_put(work, fp);
+	return 0;
+
+err_out:
+	if (rc == -EACCES || rc == -EPERM)
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	else if (rc == -EINVAL)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	else if (rc == -ESHARE)
+		rsp->hdr.Status = STATUS_SHARING_VIOLATION;
+	else if (rc == -ENOENT)
+		rsp->hdr.Status = STATUS_OBJECT_NAME_INVALID;
+	else if (rc == -EBUSY || rc == -ENOTEMPTY)
+		rsp->hdr.Status = STATUS_DIRECTORY_NOT_EMPTY;
+	else if (rc == -EAGAIN)
+		rsp->hdr.Status = STATUS_FILE_LOCK_CONFLICT;
+	else if (rc == -EBADF || rc == -ESTALE)
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+	else if (rc == -EEXIST)
+		rsp->hdr.Status = STATUS_OBJECT_NAME_COLLISION;
+	else if (rsp->hdr.Status == 0 || rc == -EOPNOTSUPP)
+		rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
+	smb2_set_err_rsp(work);
+	ksmbd_fd_put(work, fp);
+	ksmbd_debug(SMB, "error while processing smb2 query rc = %d\n", rc);
+	return rc;
+}
+
+/**
+ * smb2_read_pipe() - handler for smb2 read from IPC pipe
+ * @work:	smb work containing read IPC pipe command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+static noinline int smb2_read_pipe(struct ksmbd_work *work)
+{
+	int nbytes = 0, err;
+	u64 id;
+	struct ksmbd_rpc_command *rpc_resp;
+	struct smb2_read_req *req = work->request_buf;
+	struct smb2_read_rsp *rsp = work->response_buf;
+
+	id = le64_to_cpu(req->VolatileFileId);
+
+	inc_rfc1001_len(rsp, 16);
+	rpc_resp = ksmbd_rpc_read(work->sess, id);
+	if (rpc_resp) {
+		if (rpc_resp->flags != KSMBD_RPC_OK) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		work->aux_payload_buf =
+			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL | __GFP_ZERO);
+		if (!work->aux_payload_buf) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(work->aux_payload_buf, rpc_resp->payload,
+		       rpc_resp->payload_sz);
+
+		nbytes = rpc_resp->payload_sz;
+		work->resp_hdr_sz = get_rfc1002_len(rsp) + 4;
+		work->aux_payload_sz = nbytes;
+		kvfree(rpc_resp);
+	}
+
+	rsp->StructureSize = cpu_to_le16(17);
+	rsp->DataOffset = 80;
+	rsp->Reserved = 0;
+	rsp->DataLength = cpu_to_le32(nbytes);
+	rsp->DataRemaining = 0;
+	rsp->Reserved2 = 0;
+	inc_rfc1001_len(rsp, nbytes);
+	return 0;
+
+out:
+	rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+	smb2_set_err_rsp(work);
+	kvfree(rpc_resp);
+	return err;
+}
+
+static ssize_t smb2_read_rdma_channel(struct ksmbd_work *work,
+				      struct smb2_read_req *req, void *data_buf,
+				      size_t length)
+{
+	struct smb2_buffer_desc_v1 *desc =
+		(struct smb2_buffer_desc_v1 *)&req->Buffer[0];
+	int err;
+
+	if (work->conn->dialect == SMB30_PROT_ID &&
+	    req->Channel != SMB2_CHANNEL_RDMA_V1)
+		return -EINVAL;
+
+	if (req->ReadChannelInfoOffset == 0 ||
+	    le16_to_cpu(req->ReadChannelInfoLength) < sizeof(*desc))
+		return -EINVAL;
+
+	work->need_invalidate_rkey =
+		(req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
+	work->remote_key = le32_to_cpu(desc->token);
+
+	err = ksmbd_conn_rdma_write(work->conn, data_buf, length,
+				    le32_to_cpu(desc->token),
+				    le64_to_cpu(desc->offset),
+				    le32_to_cpu(desc->length));
+	if (err)
+		return err;
+
+	return length;
+}
+
+/**
+ * smb2_read() - handler for smb2 read from file
+ * @work:	smb work containing read command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_read(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_read_req *req;
+	struct smb2_read_rsp *rsp, *rsp_org;
+	struct ksmbd_file *fp;
+	loff_t offset;
+	size_t length, mincount;
+	ssize_t nbytes = 0, remain_bytes = 0;
+	int err = 0;
+
+	rsp_org = work->response_buf;
+	WORK_BUFFERS(work, req, rsp);
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC pipe read request\n");
+		return smb2_read_pipe(work);
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, le64_to_cpu(req->VolatileFileId),
+				  le64_to_cpu(req->PersistentFileId));
+	if (!fp) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!(fp->daccess & (FILE_READ_DATA_LE | FILE_READ_ATTRIBUTES_LE))) {
+		pr_err("Not permitted to read : 0x%x\n", fp->daccess);
+		err = -EACCES;
+		goto out;
+	}
+
+	offset = le64_to_cpu(req->Offset);
+	length = le32_to_cpu(req->Length);
+	mincount = le32_to_cpu(req->MinimumCount);
+
+	if (length > conn->vals->max_read_size) {
+		ksmbd_debug(SMB, "limiting read size to max size(%u)\n",
+			    conn->vals->max_read_size);
+		err = -EINVAL;
+		goto out;
+	}
+
+	ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
+		    fp->filp->f_path.dentry, offset, length);
+
+	work->aux_payload_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
+	if (!work->aux_payload_buf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	nbytes = ksmbd_vfs_read(work, fp, length, &offset);
+	if (nbytes < 0) {
+		err = nbytes;
+		goto out;
+	}
+
+	if ((nbytes == 0 && length != 0) || nbytes < mincount) {
+		kvfree(work->aux_payload_buf);
+		work->aux_payload_buf = NULL;
+		rsp->hdr.Status = STATUS_END_OF_FILE;
+		smb2_set_err_rsp(work);
+		ksmbd_fd_put(work, fp);
+		return 0;
+	}
+
+	ksmbd_debug(SMB, "nbytes %zu, offset %lld mincount %zu\n",
+		    nbytes, offset, mincount);
+
+	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
+	    req->Channel == SMB2_CHANNEL_RDMA_V1) {
+		/* write data to the client using rdma channel */
+		remain_bytes = smb2_read_rdma_channel(work, req,
+						      work->aux_payload_buf,
+						      nbytes);
+		kvfree(work->aux_payload_buf);
+		work->aux_payload_buf = NULL;
+
+		nbytes = 0;
+		if (remain_bytes < 0) {
+			err = (int)remain_bytes;
+			goto out;
+		}
+	}
+
+	rsp->StructureSize = cpu_to_le16(17);
+	rsp->DataOffset = 80;
+	rsp->Reserved = 0;
+	rsp->DataLength = cpu_to_le32(nbytes);
+	rsp->DataRemaining = cpu_to_le32(remain_bytes);
+	rsp->Reserved2 = 0;
+	inc_rfc1001_len(rsp_org, 16);
+	work->resp_hdr_sz = get_rfc1002_len(rsp_org) + 4;
+	work->aux_payload_sz = nbytes;
+	inc_rfc1001_len(rsp_org, nbytes);
+	ksmbd_fd_put(work, fp);
+	return 0;
+
+out:
+	if (err) {
+		if (err == -EISDIR)
+			rsp->hdr.Status = STATUS_INVALID_DEVICE_REQUEST;
+		else if (err == -EAGAIN)
+			rsp->hdr.Status = STATUS_FILE_LOCK_CONFLICT;
+		else if (err == -ENOENT)
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+		else if (err == -EACCES)
+			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		else if (err == -ESHARE)
+			rsp->hdr.Status = STATUS_SHARING_VIOLATION;
+		else if (err == -EINVAL)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		else
+			rsp->hdr.Status = STATUS_INVALID_HANDLE;
+
+		smb2_set_err_rsp(work);
+	}
+	ksmbd_fd_put(work, fp);
+	return err;
+}
+
+/**
+ * smb2_write_pipe() - handler for smb2 write on IPC pipe
+ * @work:	smb work containing write IPC pipe command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+static noinline int smb2_write_pipe(struct ksmbd_work *work)
+{
+	struct smb2_write_req *req = work->request_buf;
+	struct smb2_write_rsp *rsp = work->response_buf;
+	struct ksmbd_rpc_command *rpc_resp;
+	u64 id = 0;
+	int err = 0, ret = 0;
+	char *data_buf;
+	size_t length;
+
+	length = le32_to_cpu(req->Length);
+	id = le64_to_cpu(req->VolatileFileId);
+
+	if (le16_to_cpu(req->DataOffset) ==
+	    (offsetof(struct smb2_write_req, Buffer) - 4)) {
+		data_buf = (char *)&req->Buffer[0];
+	} else {
+		if ((le16_to_cpu(req->DataOffset) > get_rfc1002_len(req)) ||
+		    (le16_to_cpu(req->DataOffset) + length > get_rfc1002_len(req))) {
+			pr_err("invalid write data offset %u, smb_len %u\n",
+			       le16_to_cpu(req->DataOffset),
+			       get_rfc1002_len(req));
+			err = -EINVAL;
+			goto out;
+		}
+
+		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
+				le16_to_cpu(req->DataOffset));
+	}
+
+	rpc_resp = ksmbd_rpc_write(work->sess, id, data_buf, length);
+	if (rpc_resp) {
+		if (rpc_resp->flags == KSMBD_RPC_ENOTIMPLEMENTED) {
+			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+			kvfree(rpc_resp);
+			smb2_set_err_rsp(work);
+			return -EOPNOTSUPP;
+		}
+		if (rpc_resp->flags != KSMBD_RPC_OK) {
+			rsp->hdr.Status = STATUS_INVALID_HANDLE;
+			smb2_set_err_rsp(work);
+			kvfree(rpc_resp);
+			return ret;
+		}
+		kvfree(rpc_resp);
+	}
+
+	rsp->StructureSize = cpu_to_le16(17);
+	rsp->DataOffset = 0;
+	rsp->Reserved = 0;
+	rsp->DataLength = cpu_to_le32(length);
+	rsp->DataRemaining = 0;
+	rsp->Reserved2 = 0;
+	inc_rfc1001_len(rsp, 16);
+	return 0;
+out:
+	if (err) {
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+		smb2_set_err_rsp(work);
+	}
+
+	return err;
+}
+
+static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
+				       struct smb2_write_req *req,
+				       struct ksmbd_file *fp,
+				       loff_t offset, size_t length, bool sync)
+{
+	struct smb2_buffer_desc_v1 *desc;
+	char *data_buf;
+	int ret;
+	ssize_t nbytes;
+
+	desc = (struct smb2_buffer_desc_v1 *)&req->Buffer[0];
+
+	if (work->conn->dialect == SMB30_PROT_ID &&
+	    req->Channel != SMB2_CHANNEL_RDMA_V1)
+		return -EINVAL;
+
+	if (req->Length != 0 || req->DataOffset != 0)
+		return -EINVAL;
+
+	if (req->WriteChannelInfoOffset == 0 ||
+	    le16_to_cpu(req->WriteChannelInfoLength) < sizeof(*desc))
+		return -EINVAL;
+
+	work->need_invalidate_rkey =
+		(req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
+	work->remote_key = le32_to_cpu(desc->token);
+
+	data_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
+	if (!data_buf)
+		return -ENOMEM;
+
+	ret = ksmbd_conn_rdma_read(work->conn, data_buf, length,
+				   le32_to_cpu(desc->token),
+				   le64_to_cpu(desc->offset),
+				   le32_to_cpu(desc->length));
+	if (ret < 0) {
+		kvfree(data_buf);
+		return ret;
+	}
+
+	ret = ksmbd_vfs_write(work, fp, data_buf, length, &offset, sync, &nbytes);
+	kvfree(data_buf);
+	if (ret < 0)
+		return ret;
+
+	return nbytes;
+}
+
+/**
+ * smb2_write() - handler for smb2 write from file
+ * @work:	smb work containing write command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_write(struct ksmbd_work *work)
+{
+	struct smb2_write_req *req;
+	struct smb2_write_rsp *rsp, *rsp_org;
+	struct ksmbd_file *fp = NULL;
+	loff_t offset;
+	size_t length;
+	ssize_t nbytes;
+	char *data_buf;
+	bool writethrough = false;
+	int err = 0;
+
+	rsp_org = work->response_buf;
+	WORK_BUFFERS(work, req, rsp);
+
+	if (test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC pipe write request\n");
+		return smb2_write_pipe(work);
+	}
+
+	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		ksmbd_debug(SMB, "User does not have write permission\n");
+		err = -EACCES;
+		goto out;
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, le64_to_cpu(req->VolatileFileId),
+				  le64_to_cpu(req->PersistentFileId));
+	if (!fp) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!(fp->daccess & (FILE_WRITE_DATA_LE | FILE_READ_ATTRIBUTES_LE))) {
+		pr_err("Not permitted to write : 0x%x\n", fp->daccess);
+		err = -EACCES;
+		goto out;
+	}
+
+	offset = le64_to_cpu(req->Offset);
+	length = le32_to_cpu(req->Length);
+
+	if (length > work->conn->vals->max_write_size) {
+		ksmbd_debug(SMB, "limiting write size to max size(%u)\n",
+			    work->conn->vals->max_write_size);
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
+		writethrough = true;
+
+	if (req->Channel != SMB2_CHANNEL_RDMA_V1 &&
+	    req->Channel != SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
+		if (le16_to_cpu(req->DataOffset) ==
+		    (offsetof(struct smb2_write_req, Buffer) - 4)) {
+			data_buf = (char *)&req->Buffer[0];
+		} else {
+			if ((le16_to_cpu(req->DataOffset) > get_rfc1002_len(req)) ||
+			    (le16_to_cpu(req->DataOffset) + length > get_rfc1002_len(req))) {
+				pr_err("invalid write data offset %u, smb_len %u\n",
+				       le16_to_cpu(req->DataOffset),
+				       get_rfc1002_len(req));
+				err = -EINVAL;
+				goto out;
+			}
+
+			data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
+					le16_to_cpu(req->DataOffset));
+		}
+
+		ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
+		if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
+			writethrough = true;
+
+		ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
+			    fp->filp->f_path.dentry, offset, length);
+		err = ksmbd_vfs_write(work, fp, data_buf, length, &offset,
+				      writethrough, &nbytes);
+		if (err < 0)
+			goto out;
+	} else {
+		/* read data from the client using rdma channel, and
+		 * write the data.
+		 */
+		nbytes = smb2_write_rdma_channel(work, req, fp, offset,
+						 le32_to_cpu(req->RemainingBytes),
+						 writethrough);
+		if (nbytes < 0) {
+			err = (int)nbytes;
+			goto out;
+		}
+	}
+
+	rsp->StructureSize = cpu_to_le16(17);
+	rsp->DataOffset = 0;
+	rsp->Reserved = 0;
+	rsp->DataLength = cpu_to_le32(nbytes);
+	rsp->DataRemaining = 0;
+	rsp->Reserved2 = 0;
+	inc_rfc1001_len(rsp_org, 16);
+	ksmbd_fd_put(work, fp);
+	return 0;
+
+out:
+	if (err == -EAGAIN)
+		rsp->hdr.Status = STATUS_FILE_LOCK_CONFLICT;
+	else if (err == -ENOSPC || err == -EFBIG)
+		rsp->hdr.Status = STATUS_DISK_FULL;
+	else if (err == -ENOENT)
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+	else if (err == -EACCES)
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	else if (err == -ESHARE)
+		rsp->hdr.Status = STATUS_SHARING_VIOLATION;
+	else if (err == -EINVAL)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	else
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+
+	smb2_set_err_rsp(work);
+	ksmbd_fd_put(work, fp);
+	return err;
+}
+
+/**
+ * smb2_flush() - handler for smb2 flush file - fsync
+ * @work:	smb work containing flush command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_flush(struct ksmbd_work *work)
+{
+	struct smb2_flush_req *req;
+	struct smb2_flush_rsp *rsp, *rsp_org;
+	int err;
+
+	rsp_org = work->response_buf;
+	WORK_BUFFERS(work, req, rsp);
+
+	ksmbd_debug(SMB, "SMB2_FLUSH called for fid %llu\n",
+		    le64_to_cpu(req->VolatileFileId));
+
+	err = ksmbd_vfs_fsync(work,
+			      le64_to_cpu(req->VolatileFileId),
+			      le64_to_cpu(req->PersistentFileId));
+	if (err)
+		goto out;
+
+	rsp->StructureSize = cpu_to_le16(4);
+	rsp->Reserved = 0;
+	inc_rfc1001_len(rsp_org, 4);
+	return 0;
+
+out:
+	if (err) {
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+		smb2_set_err_rsp(work);
+	}
+
+	return err;
+}
+
+/**
+ * smb2_cancel() - handler for smb2 cancel command
+ * @work:	smb work containing cancel command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_cancel(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *chdr;
+	struct ksmbd_work *cancel_work = NULL;
+	int canceled = 0;
+	struct list_head *command_list;
+
+	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
+		    hdr->MessageId, hdr->Flags);
+
+	if (hdr->Flags & SMB2_FLAGS_ASYNC_COMMAND) {
+		command_list = &conn->async_requests;
+
+		spin_lock(&conn->request_lock);
+		list_for_each_entry(cancel_work, command_list,
+				    async_request_entry) {
+			chdr = cancel_work->request_buf;
+
+			if (cancel_work->async_id !=
+			    le64_to_cpu(hdr->Id.AsyncId))
+				continue;
+
+			ksmbd_debug(SMB,
+				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
+				    le64_to_cpu(hdr->Id.AsyncId),
+				    le16_to_cpu(chdr->Command));
+			canceled = 1;
+			break;
+		}
+		spin_unlock(&conn->request_lock);
+	} else {
+		command_list = &conn->requests;
+
+		spin_lock(&conn->request_lock);
+		list_for_each_entry(cancel_work, command_list, request_entry) {
+			chdr = cancel_work->request_buf;
+
+			if (chdr->MessageId != hdr->MessageId ||
+			    cancel_work == work)
+				continue;
+
+			ksmbd_debug(SMB,
+				    "smb2 with mid %llu cancelled command = 0x%x\n",
+				    le64_to_cpu(hdr->MessageId),
+				    le16_to_cpu(chdr->Command));
+			canceled = 1;
+			break;
+		}
+		spin_unlock(&conn->request_lock);
+	}
+
+	if (canceled) {
+		cancel_work->state = KSMBD_WORK_CANCELLED;
+		if (cancel_work->cancel_fn)
+			cancel_work->cancel_fn(cancel_work->cancel_argv);
+	}
+
+	/* For SMB2_CANCEL command itself send no response*/
+	work->send_no_response = 1;
+	return 0;
+}
+
+struct file_lock *smb_flock_init(struct file *f)
+{
+	struct file_lock *fl;
+
+	fl = locks_alloc_lock();
+	if (!fl)
+		goto out;
+
+	locks_init_lock(fl);
+
+	fl->fl_owner = f;
+	fl->fl_pid = current->tgid;
+	fl->fl_file = f;
+	fl->fl_flags = FL_POSIX;
+	fl->fl_ops = NULL;
+	fl->fl_lmops = NULL;
+
+out:
+	return fl;
+}
+
+static int smb2_set_flock_flags(struct file_lock *flock, int flags)
+{
+	int cmd = -EINVAL;
+
+	/* Checking for wrong flag combination during lock request*/
+	switch (flags) {
+	case SMB2_LOCKFLAG_SHARED:
+		ksmbd_debug(SMB, "received shared request\n");
+		cmd = F_SETLKW;
+		flock->fl_type = F_RDLCK;
+		flock->fl_flags |= FL_SLEEP;
+		break;
+	case SMB2_LOCKFLAG_EXCLUSIVE:
+		ksmbd_debug(SMB, "received exclusive request\n");
+		cmd = F_SETLKW;
+		flock->fl_type = F_WRLCK;
+		flock->fl_flags |= FL_SLEEP;
+		break;
+	case SMB2_LOCKFLAG_SHARED | SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
+		ksmbd_debug(SMB,
+			    "received shared & fail immediately request\n");
+		cmd = F_SETLK;
+		flock->fl_type = F_RDLCK;
+		break;
+	case SMB2_LOCKFLAG_EXCLUSIVE | SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
+		ksmbd_debug(SMB,
+			    "received exclusive & fail immediately request\n");
+		cmd = F_SETLK;
+		flock->fl_type = F_WRLCK;
+		break;
+	case SMB2_LOCKFLAG_UNLOCK:
+		ksmbd_debug(SMB, "received unlock request\n");
+		flock->fl_type = F_UNLCK;
+		cmd = 0;
+		break;
+	}
+
+	return cmd;
+}
+
+static struct ksmbd_lock *smb2_lock_init(struct file_lock *flock,
+					 unsigned int cmd, int flags,
+					 struct list_head *lock_list)
+{
+	struct ksmbd_lock *lock;
+
+	lock = kzalloc(sizeof(struct ksmbd_lock), GFP_KERNEL);
+	if (!lock)
+		return NULL;
+
+	lock->cmd = cmd;
+	lock->fl = flock;
+	lock->start = flock->fl_start;
+	lock->end = flock->fl_end;
+	lock->flags = flags;
+	if (lock->start == lock->end)
+		lock->zero_len = 1;
+	INIT_LIST_HEAD(&lock->clist);
+	INIT_LIST_HEAD(&lock->flist);
+	INIT_LIST_HEAD(&lock->llist);
+	list_add_tail(&lock->llist, lock_list);
+
+	return lock;
+}
+
+static void smb2_remove_blocked_lock(void **argv)
+{
+	struct file_lock *flock = (struct file_lock *)argv[0];
+
+	ksmbd_vfs_posix_lock_unblock(flock);
+	wake_up(&flock->fl_wait);
+}
+
+static inline bool lock_defer_pending(struct file_lock *fl)
+{
+	/* check pending lock waiters */
+	return waitqueue_active(&fl->fl_wait);
+}
+
+/**
+ * smb2_lock() - handler for smb2 file lock command
+ * @work:	smb work containing lock command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_lock(struct ksmbd_work *work)
+{
+	struct smb2_lock_req *req = work->request_buf;
+	struct smb2_lock_rsp *rsp = work->response_buf;
+	struct smb2_lock_element *lock_ele;
+	struct ksmbd_file *fp = NULL;
+	struct file_lock *flock = NULL;
+	struct file *filp = NULL;
+	int lock_count;
+	int flags = 0;
+	int cmd = 0;
+	int err = 0, i;
+	u64 lock_start, lock_length;
+	struct ksmbd_lock *smb_lock = NULL, *cmp_lock, *tmp, *tmp2;
+	struct ksmbd_conn *conn;
+	int nolock = 0;
+	LIST_HEAD(lock_list);
+	LIST_HEAD(rollback_list);
+	int prior_lock = 0;
+
+	ksmbd_debug(SMB, "Received lock request\n");
+	fp = ksmbd_lookup_fd_slow(work,
+				  le64_to_cpu(req->VolatileFileId),
+				  le64_to_cpu(req->PersistentFileId));
+	if (!fp) {
+		ksmbd_debug(SMB, "Invalid file id for lock : %llu\n",
+			    le64_to_cpu(req->VolatileFileId));
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+		goto out2;
+	}
+
+	filp = fp->filp;
+	lock_count = le16_to_cpu(req->LockCount);
+	lock_ele = req->locks;
+
+	ksmbd_debug(SMB, "lock count is %d\n", lock_count);
+	if (!lock_count) {
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		goto out2;
+	}
+
+	for (i = 0; i < lock_count; i++) {
+		flags = le32_to_cpu(lock_ele[i].Flags);
+
+		flock = smb_flock_init(filp);
+		if (!flock) {
+			rsp->hdr.Status = STATUS_LOCK_NOT_GRANTED;
+			goto out;
+		}
+
+		cmd = smb2_set_flock_flags(flock, flags);
+
+		lock_start = le64_to_cpu(lock_ele[i].Offset);
+		lock_length = le64_to_cpu(lock_ele[i].Length);
+		if (lock_start > U64_MAX - lock_length) {
+			pr_err("Invalid lock range requested\n");
+			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			goto out;
+		}
+
+		if (lock_start > OFFSET_MAX)
+			flock->fl_start = OFFSET_MAX;
+		else
+			flock->fl_start = lock_start;
+
+		lock_length = le64_to_cpu(lock_ele[i].Length);
+		if (lock_length > OFFSET_MAX - flock->fl_start)
+			lock_length = OFFSET_MAX - flock->fl_start;
+
+		flock->fl_end = flock->fl_start + lock_length;
+
+		if (flock->fl_end < flock->fl_start) {
+			ksmbd_debug(SMB,
+				    "the end offset(%llx) is smaller than the start offset(%llx)\n",
+				    flock->fl_end, flock->fl_start);
+			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			goto out;
+		}
+
+		/* Check conflict locks in one request */
+		list_for_each_entry(cmp_lock, &lock_list, llist) {
+			if (cmp_lock->fl->fl_start <= flock->fl_start &&
+			    cmp_lock->fl->fl_end >= flock->fl_end) {
+				if (cmp_lock->fl->fl_type != F_UNLCK &&
+				    flock->fl_type != F_UNLCK) {
+					pr_err("conflict two locks in one request\n");
+					rsp->hdr.Status =
+						STATUS_INVALID_PARAMETER;
+					goto out;
+				}
+			}
+		}
+
+		smb_lock = smb2_lock_init(flock, cmd, flags, &lock_list);
+		if (!smb_lock) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+	}
+
+	list_for_each_entry_safe(smb_lock, tmp, &lock_list, llist) {
+		if (smb_lock->cmd < 0) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+
+		if (!(smb_lock->flags & SMB2_LOCKFLAG_MASK)) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+
+		if ((prior_lock & (SMB2_LOCKFLAG_EXCLUSIVE | SMB2_LOCKFLAG_SHARED) &&
+		     smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) ||
+		    (prior_lock == SMB2_LOCKFLAG_UNLOCK &&
+		     !(smb_lock->flags & SMB2_LOCKFLAG_UNLOCK))) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+
+		prior_lock = smb_lock->flags;
+
+		if (!(smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) &&
+		    !(smb_lock->flags & SMB2_LOCKFLAG_FAIL_IMMEDIATELY))
+			goto no_check_cl;
+
+		nolock = 1;
+		/* check locks in connection list */
+		read_lock(&conn_list_lock);
+		list_for_each_entry(conn, &conn_list, conns_list) {
+			spin_lock(&conn->llist_lock);
+			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
+				if (file_inode(cmp_lock->fl->fl_file) !=
+				    file_inode(smb_lock->fl->fl_file))
+					continue;
+
+				if (smb_lock->fl->fl_type == F_UNLCK) {
+					if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file &&
+					    cmp_lock->start == smb_lock->start &&
+					    cmp_lock->end == smb_lock->end &&
+					    !lock_defer_pending(cmp_lock->fl)) {
+						nolock = 0;
+						list_del(&cmp_lock->flist);
+						list_del(&cmp_lock->clist);
+						spin_unlock(&conn->llist_lock);
+						read_unlock(&conn_list_lock);
+
+						locks_free_lock(cmp_lock->fl);
+						kfree(cmp_lock);
+						goto out_check_cl;
+					}
+					continue;
+				}
+
+				if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file) {
+					if (smb_lock->flags & SMB2_LOCKFLAG_SHARED)
+						continue;
+				} else {
+					if (cmp_lock->flags & SMB2_LOCKFLAG_SHARED)
+						continue;
+				}
+
+				/* check zero byte lock range */
+				if (cmp_lock->zero_len && !smb_lock->zero_len &&
+				    cmp_lock->start > smb_lock->start &&
+				    cmp_lock->start < smb_lock->end) {
+					spin_unlock(&conn->llist_lock);
+					read_unlock(&conn_list_lock);
+					pr_err("previous lock conflict with zero byte lock range\n");
+					rsp->hdr.Status = STATUS_LOCK_NOT_GRANTED;
+						goto out;
+				}
+
+				if (smb_lock->zero_len && !cmp_lock->zero_len &&
+				    smb_lock->start > cmp_lock->start &&
+				    smb_lock->start < cmp_lock->end) {
+					spin_unlock(&conn->llist_lock);
+					read_unlock(&conn_list_lock);
+					pr_err("current lock conflict with zero byte lock range\n");
+					rsp->hdr.Status = STATUS_LOCK_NOT_GRANTED;
+						goto out;
+				}
+
+				if (((cmp_lock->start <= smb_lock->start &&
+				      cmp_lock->end > smb_lock->start) ||
+				     (cmp_lock->start < smb_lock->end &&
+				      cmp_lock->end >= smb_lock->end)) &&
+				    !cmp_lock->zero_len && !smb_lock->zero_len) {
+					spin_unlock(&conn->llist_lock);
+					read_unlock(&conn_list_lock);
+					pr_err("Not allow lock operation on exclusive lock range\n");
+					rsp->hdr.Status =
+						STATUS_LOCK_NOT_GRANTED;
+					goto out;
+				}
+			}
+			spin_unlock(&conn->llist_lock);
+		}
+		read_unlock(&conn_list_lock);
+out_check_cl:
+		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
+			pr_err("Try to unlock nolocked range\n");
+			rsp->hdr.Status = STATUS_RANGE_NOT_LOCKED;
+			goto out;
+		}
+
+no_check_cl:
+		if (smb_lock->zero_len) {
+			err = 0;
+			goto skip;
+		}
+
+		flock = smb_lock->fl;
+		list_del(&smb_lock->llist);
+retry:
+		err = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
+skip:
+		if (flags & SMB2_LOCKFLAG_UNLOCK) {
+			if (!err) {
+				ksmbd_debug(SMB, "File unlocked\n");
+			} else if (err == -ENOENT) {
+				rsp->hdr.Status = STATUS_NOT_LOCKED;
+				goto out;
+			}
+			locks_free_lock(flock);
+			kfree(smb_lock);
+		} else {
+			if (err == FILE_LOCK_DEFERRED) {
+				void **argv;
+
+				ksmbd_debug(SMB,
+					    "would have to wait for getting lock\n");
+				spin_lock(&work->conn->llist_lock);
+				list_add_tail(&smb_lock->clist,
+					      &work->conn->lock_list);
+				spin_unlock(&work->conn->llist_lock);
+				list_add(&smb_lock->llist, &rollback_list);
+
+				argv = kmalloc(sizeof(void *), GFP_KERNEL);
+				if (!argv) {
+					err = -ENOMEM;
+					goto out;
+				}
+				argv[0] = flock;
+
+				err = setup_async_work(work,
+						       smb2_remove_blocked_lock,
+						       argv);
+				if (err) {
+					rsp->hdr.Status =
+					   STATUS_INSUFFICIENT_RESOURCES;
+					goto out;
+				}
+				spin_lock(&fp->f_lock);
+				list_add(&work->fp_entry, &fp->blocked_works);
+				spin_unlock(&fp->f_lock);
+
+				smb2_send_interim_resp(work, STATUS_PENDING);
+
+				ksmbd_vfs_posix_lock_wait(flock);
+
+				if (work->state != KSMBD_WORK_ACTIVE) {
+					list_del(&smb_lock->llist);
+					spin_lock(&work->conn->llist_lock);
+					list_del(&smb_lock->clist);
+					spin_unlock(&work->conn->llist_lock);
+					locks_free_lock(flock);
+
+					if (work->state == KSMBD_WORK_CANCELLED) {
+						spin_lock(&fp->f_lock);
+						list_del(&work->fp_entry);
+						spin_unlock(&fp->f_lock);
+						rsp->hdr.Status =
+							STATUS_CANCELLED;
+						kfree(smb_lock);
+						smb2_send_interim_resp(work,
+								       STATUS_CANCELLED);
+						work->send_no_response = 1;
+						goto out;
+					}
+					init_smb2_rsp_hdr(work);
+					smb2_set_err_rsp(work);
+					rsp->hdr.Status =
+						STATUS_RANGE_NOT_LOCKED;
+					kfree(smb_lock);
+					goto out2;
+				}
+
+				list_del(&smb_lock->llist);
+				spin_lock(&work->conn->llist_lock);
+				list_del(&smb_lock->clist);
+				spin_unlock(&work->conn->llist_lock);
+
+				spin_lock(&fp->f_lock);
+				list_del(&work->fp_entry);
+				spin_unlock(&fp->f_lock);
+				goto retry;
+			} else if (!err) {
+				spin_lock(&work->conn->llist_lock);
+				list_add_tail(&smb_lock->clist,
+					      &work->conn->lock_list);
+				list_add_tail(&smb_lock->flist,
+					      &fp->lock_list);
+				spin_unlock(&work->conn->llist_lock);
+				list_add(&smb_lock->llist, &rollback_list);
+				ksmbd_debug(SMB, "successful in taking lock\n");
+			} else {
+				rsp->hdr.Status = STATUS_LOCK_NOT_GRANTED;
+				goto out;
+			}
+		}
+	}
+
+	if (atomic_read(&fp->f_ci->op_count) > 1)
+		smb_break_all_oplock(work, fp);
+
+	rsp->StructureSize = cpu_to_le16(4);
+	ksmbd_debug(SMB, "successful in taking lock\n");
+	rsp->hdr.Status = STATUS_SUCCESS;
+	rsp->Reserved = 0;
+	inc_rfc1001_len(rsp, 4);
+	ksmbd_fd_put(work, fp);
+	return 0;
+
+out:
+	list_for_each_entry_safe(smb_lock, tmp, &lock_list, llist) {
+		locks_free_lock(smb_lock->fl);
+		list_del(&smb_lock->llist);
+		kfree(smb_lock);
+	}
+
+	list_for_each_entry_safe(smb_lock, tmp, &rollback_list, llist) {
+		struct file_lock *rlock = NULL;
+		int rc;
+
+		rlock = smb_flock_init(filp);
+		rlock->fl_type = F_UNLCK;
+		rlock->fl_start = smb_lock->start;
+		rlock->fl_end = smb_lock->end;
+
+		rc = vfs_lock_file(filp, 0, rlock, NULL);
+		if (rc)
+			pr_err("rollback unlock fail : %d\n", rc);
+
+		list_del(&smb_lock->llist);
+		spin_lock(&work->conn->llist_lock);
+		if (!list_empty(&smb_lock->flist))
+			list_del(&smb_lock->flist);
+		list_del(&smb_lock->clist);
+		spin_unlock(&work->conn->llist_lock);
+
+		locks_free_lock(smb_lock->fl);
+		locks_free_lock(rlock);
+		kfree(smb_lock);
+	}
+out2:
+	ksmbd_debug(SMB, "failed in taking lock(flags : %x)\n", flags);
+	smb2_set_err_rsp(work);
+	ksmbd_fd_put(work, fp);
+	return err;
+}
+
+static int fsctl_copychunk(struct ksmbd_work *work, struct smb2_ioctl_req *req,
+			   struct smb2_ioctl_rsp *rsp)
+{
+	struct copychunk_ioctl_req *ci_req;
+	struct copychunk_ioctl_rsp *ci_rsp;
+	struct ksmbd_file *src_fp = NULL, *dst_fp = NULL;
+	struct srv_copychunk *chunks;
+	unsigned int i, chunk_count, chunk_count_written = 0;
+	unsigned int chunk_size_written = 0;
+	loff_t total_size_written = 0;
+	int ret, cnt_code;
+
+	cnt_code = le32_to_cpu(req->CntCode);
+	ci_req = (struct copychunk_ioctl_req *)&req->Buffer[0];
+	ci_rsp = (struct copychunk_ioctl_rsp *)&rsp->Buffer[0];
+
+	rsp->VolatileFileId = req->VolatileFileId;
+	rsp->PersistentFileId = req->PersistentFileId;
+	ci_rsp->ChunksWritten =
+		cpu_to_le32(ksmbd_server_side_copy_max_chunk_count());
+	ci_rsp->ChunkBytesWritten =
+		cpu_to_le32(ksmbd_server_side_copy_max_chunk_size());
+	ci_rsp->TotalBytesWritten =
+		cpu_to_le32(ksmbd_server_side_copy_max_total_size());
+
+	chunks = (struct srv_copychunk *)&ci_req->Chunks[0];
+	chunk_count = le32_to_cpu(ci_req->ChunkCount);
+	total_size_written = 0;
+
+	/* verify the SRV_COPYCHUNK_COPY packet */
+	if (chunk_count > ksmbd_server_side_copy_max_chunk_count() ||
+	    le32_to_cpu(req->InputCount) <
+	     offsetof(struct copychunk_ioctl_req, Chunks) +
+	     chunk_count * sizeof(struct srv_copychunk)) {
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		return -EINVAL;
+	}
+
+	for (i = 0; i < chunk_count; i++) {
+		if (le32_to_cpu(chunks[i].Length) == 0 ||
+		    le32_to_cpu(chunks[i].Length) > ksmbd_server_side_copy_max_chunk_size())
+			break;
+		total_size_written += le32_to_cpu(chunks[i].Length);
+	}
+
+	if (i < chunk_count ||
+	    total_size_written > ksmbd_server_side_copy_max_total_size()) {
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		return -EINVAL;
+	}
+
+	src_fp = ksmbd_lookup_foreign_fd(work,
+					 le64_to_cpu(ci_req->ResumeKey[0]));
+	dst_fp = ksmbd_lookup_fd_slow(work,
+				      le64_to_cpu(req->VolatileFileId),
+				      le64_to_cpu(req->PersistentFileId));
+	ret = -EINVAL;
+	if (!src_fp ||
+	    src_fp->persistent_id != le64_to_cpu(ci_req->ResumeKey[1])) {
+		rsp->hdr.Status = STATUS_OBJECT_NAME_NOT_FOUND;
+		goto out;
+	}
+
+	if (!dst_fp) {
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+		goto out;
+	}
+
+	/*
+	 * FILE_READ_DATA should only be included in
+	 * the FSCTL_COPYCHUNK case
+	 */
+	if (cnt_code == FSCTL_COPYCHUNK &&
+	    !(dst_fp->daccess & (FILE_READ_DATA_LE | FILE_GENERIC_READ_LE))) {
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		goto out;
+	}
+
+	ret = ksmbd_vfs_copy_file_ranges(work, src_fp, dst_fp,
+					 chunks, chunk_count,
+					 &chunk_count_written,
+					 &chunk_size_written,
+					 &total_size_written);
+	if (ret < 0) {
+		if (ret == -EACCES)
+			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		if (ret == -EAGAIN)
+			rsp->hdr.Status = STATUS_FILE_LOCK_CONFLICT;
+		else if (ret == -EBADF)
+			rsp->hdr.Status = STATUS_INVALID_HANDLE;
+		else if (ret == -EFBIG || ret == -ENOSPC)
+			rsp->hdr.Status = STATUS_DISK_FULL;
+		else if (ret == -EINVAL)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		else if (ret == -EISDIR)
+			rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
+		else if (ret == -E2BIG)
+			rsp->hdr.Status = STATUS_INVALID_VIEW_SIZE;
+		else
+			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+	}
+
+	ci_rsp->ChunksWritten = cpu_to_le32(chunk_count_written);
+	ci_rsp->ChunkBytesWritten = cpu_to_le32(chunk_size_written);
+	ci_rsp->TotalBytesWritten = cpu_to_le32(total_size_written);
+out:
+	ksmbd_fd_put(work, src_fp);
+	ksmbd_fd_put(work, dst_fp);
+	return ret;
+}
+
+static __be32 idev_ipv4_address(struct in_device *idev)
+{
+	__be32 addr = 0;
+
+	struct in_ifaddr *ifa;
+
+	rcu_read_lock();
+	in_dev_for_each_ifa_rcu(ifa, idev) {
+		if (ifa->ifa_flags & IFA_F_SECONDARY)
+			continue;
+
+		addr = ifa->ifa_address;
+		break;
+	}
+	rcu_read_unlock();
+	return addr;
+}
+
+static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
+					struct smb2_ioctl_req *req,
+					struct smb2_ioctl_rsp *rsp)
+{
+	struct network_interface_info_ioctl_rsp *nii_rsp = NULL;
+	int nbytes = 0;
+	struct net_device *netdev;
+	struct sockaddr_storage_rsp *sockaddr_storage;
+	unsigned int flags;
+	unsigned long long speed;
+
+	rtnl_lock();
+	for_each_netdev(&init_net, netdev) {
+		if (netdev->type == ARPHRD_LOOPBACK)
+			continue;
+
+		flags = dev_get_flags(netdev);
+		if (!(flags & IFF_RUNNING))
+			continue;
+
+		nii_rsp = (struct network_interface_info_ioctl_rsp *)
+				&rsp->Buffer[nbytes];
+		nii_rsp->IfIndex = cpu_to_le32(netdev->ifindex);
+
+		nii_rsp->Capability = 0;
+		if (netdev->num_tx_queues > 1)
+			nii_rsp->Capability |= cpu_to_le32(RSS_CAPABLE);
+		if (ksmbd_rdma_capable_netdev(netdev))
+			nii_rsp->Capability |= cpu_to_le32(RDMA_CAPABLE);
+
+		nii_rsp->Next = cpu_to_le32(152);
+		nii_rsp->Reserved = 0;
+
+		if (netdev->ethtool_ops->get_link_ksettings) {
+			struct ethtool_link_ksettings cmd;
+
+			netdev->ethtool_ops->get_link_ksettings(netdev, &cmd);
+			speed = cmd.base.speed;
+		} else {
+			pr_err("%s %s\n", netdev->name,
+			       "speed is unknown, defaulting to 1Gb/sec");
+			speed = SPEED_1000;
+		}
+
+		speed *= 1000000;
+		nii_rsp->LinkSpeed = cpu_to_le64(speed);
+
+		sockaddr_storage = (struct sockaddr_storage_rsp *)
+					nii_rsp->SockAddr_Storage;
+		memset(sockaddr_storage, 0, 128);
+
+		if (conn->peer_addr.ss_family == PF_INET) {
+			struct in_device *idev;
+
+			sockaddr_storage->Family = cpu_to_le16(INTERNETWORK);
+			sockaddr_storage->addr4.Port = 0;
+
+			idev = __in_dev_get_rtnl(netdev);
+			if (!idev)
+				continue;
+			sockaddr_storage->addr4.IPv4address =
+						idev_ipv4_address(idev);
+		} else {
+			struct inet6_dev *idev6;
+			struct inet6_ifaddr *ifa;
+			__u8 *ipv6_addr = sockaddr_storage->addr6.IPv6address;
+
+			sockaddr_storage->Family = cpu_to_le16(INTERNETWORKV6);
+			sockaddr_storage->addr6.Port = 0;
+			sockaddr_storage->addr6.FlowInfo = 0;
+
+			idev6 = __in6_dev_get(netdev);
+			if (!idev6)
+				continue;
+
+			list_for_each_entry(ifa, &idev6->addr_list, if_list) {
+				if (ifa->flags & (IFA_F_TENTATIVE |
+							IFA_F_DEPRECATED))
+					continue;
+				memcpy(ipv6_addr, ifa->addr.s6_addr, 16);
+				break;
+			}
+			sockaddr_storage->addr6.ScopeId = 0;
+		}
+
+		nbytes += sizeof(struct network_interface_info_ioctl_rsp);
+	}
+	rtnl_unlock();
+
+	/* zero if this is last one */
+	if (nii_rsp)
+		nii_rsp->Next = 0;
+
+	if (!nbytes) {
+		rsp->hdr.Status = STATUS_BUFFER_TOO_SMALL;
+		return -EINVAL;
+	}
+
+	rsp->PersistentFileId = cpu_to_le64(SMB2_NO_FID);
+	rsp->VolatileFileId = cpu_to_le64(SMB2_NO_FID);
+	return nbytes;
+}
+
+static int fsctl_validate_negotiate_info(struct ksmbd_conn *conn,
+					 struct validate_negotiate_info_req *neg_req,
+					 struct validate_negotiate_info_rsp *neg_rsp)
+{
+	int ret = 0;
+	int dialect;
+
+	dialect = ksmbd_lookup_dialect_by_id(neg_req->Dialects,
+					     neg_req->DialectCount);
+	if (dialect == BAD_PROT_ID || dialect != conn->dialect) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (strncmp(neg_req->Guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (le16_to_cpu(neg_req->SecurityMode) != conn->cli_sec_mode) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (le32_to_cpu(neg_req->Capabilities) != conn->cli_cap) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	neg_rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+	memset(neg_rsp->Guid, 0, SMB2_CLIENT_GUID_SIZE);
+	neg_rsp->SecurityMode = cpu_to_le16(conn->srv_sec_mode);
+	neg_rsp->Dialect = cpu_to_le16(conn->dialect);
+err_out:
+	return ret;
+}
+
+static int fsctl_query_allocated_ranges(struct ksmbd_work *work, u64 id,
+					struct file_allocated_range_buffer *qar_req,
+					struct file_allocated_range_buffer *qar_rsp,
+					int in_count, int *out_count)
+{
+	struct ksmbd_file *fp;
+	loff_t start, length;
+	int ret = 0;
+
+	*out_count = 0;
+	if (in_count == 0)
+		return -EINVAL;
+
+	fp = ksmbd_lookup_fd_fast(work, id);
+	if (!fp)
+		return -ENOENT;
+
+	start = le64_to_cpu(qar_req->file_offset);
+	length = le64_to_cpu(qar_req->length);
+
+	ret = ksmbd_vfs_fqar_lseek(fp, start, length,
+				   qar_rsp, in_count, out_count);
+	if (ret && ret != -E2BIG)
+		*out_count = 0;
+
+	ksmbd_fd_put(work, fp);
+	return ret;
+}
+
+static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
+				 int out_buf_len, struct smb2_ioctl_req *req,
+				 struct smb2_ioctl_rsp *rsp)
+{
+	struct ksmbd_rpc_command *rpc_resp;
+	char *data_buf = (char *)&req->Buffer[0];
+	int nbytes = 0;
+
+	rpc_resp = ksmbd_rpc_ioctl(work->sess, id, data_buf,
+				   le32_to_cpu(req->InputCount));
+	if (rpc_resp) {
+		if (rpc_resp->flags == KSMBD_RPC_SOME_NOT_MAPPED) {
+			/*
+			 * set STATUS_SOME_NOT_MAPPED response
+			 * for unknown domain sid.
+			 */
+			rsp->hdr.Status = STATUS_SOME_NOT_MAPPED;
+		} else if (rpc_resp->flags == KSMBD_RPC_ENOTIMPLEMENTED) {
+			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+			goto out;
+		} else if (rpc_resp->flags != KSMBD_RPC_OK) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+
+		nbytes = rpc_resp->payload_sz;
+		if (rpc_resp->payload_sz > out_buf_len) {
+			rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
+			nbytes = out_buf_len;
+		}
+
+		if (!rpc_resp->payload_sz) {
+			rsp->hdr.Status =
+				STATUS_UNEXPECTED_IO_ERROR;
+			goto out;
+		}
+
+		memcpy((char *)rsp->Buffer, rpc_resp->payload, nbytes);
+	}
+out:
+	kvfree(rpc_resp);
+	return nbytes;
+}
+
+static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
+				   struct file_sparse *sparse)
+{
+	struct ksmbd_file *fp;
+	struct user_namespace *user_ns;
+	int ret = 0;
+	__le32 old_fattr;
+
+	fp = ksmbd_lookup_fd_fast(work, id);
+	if (!fp)
+		return -ENOENT;
+	user_ns = file_mnt_user_ns(fp->filp);
+
+	old_fattr = fp->f_ci->m_fattr;
+	if (sparse->SetSparse)
+		fp->f_ci->m_fattr |= ATTR_SPARSE_FILE_LE;
+	else
+		fp->f_ci->m_fattr &= ~ATTR_SPARSE_FILE_LE;
+
+	if (fp->f_ci->m_fattr != old_fattr &&
+	    test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		struct xattr_dos_attrib da;
+
+		ret = ksmbd_vfs_get_dos_attrib_xattr(user_ns,
+						     fp->filp->f_path.dentry, &da);
+		if (ret <= 0)
+			goto out;
+
+		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+		ret = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
+						     fp->filp->f_path.dentry, &da);
+		if (ret)
+			fp->f_ci->m_fattr = old_fattr;
+	}
+
+out:
+	ksmbd_fd_put(work, fp);
+	return ret;
+}
+
+static int fsctl_request_resume_key(struct ksmbd_work *work,
+				    struct smb2_ioctl_req *req,
+				    struct resume_key_ioctl_rsp *key_rsp)
+{
+	struct ksmbd_file *fp;
+
+	fp = ksmbd_lookup_fd_slow(work,
+				  le64_to_cpu(req->VolatileFileId),
+				  le64_to_cpu(req->PersistentFileId));
+	if (!fp)
+		return -ENOENT;
+
+	memset(key_rsp, 0, sizeof(*key_rsp));
+	key_rsp->ResumeKey[0] = req->VolatileFileId;
+	key_rsp->ResumeKey[1] = req->PersistentFileId;
+	ksmbd_fd_put(work, fp);
+
+	return 0;
+}
+
+/**
+ * smb2_ioctl() - handler for smb2 ioctl command
+ * @work:	smb work containing ioctl command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_ioctl(struct ksmbd_work *work)
+{
+	struct smb2_ioctl_req *req;
+	struct smb2_ioctl_rsp *rsp, *rsp_org;
+	int cnt_code, nbytes = 0;
+	int out_buf_len;
+	u64 id = KSMBD_NO_FID;
+	struct ksmbd_conn *conn = work->conn;
+	int ret = 0;
+
+	rsp_org = work->response_buf;
+	if (work->next_smb2_rcv_hdr_off) {
+		req = ksmbd_req_buf_next(work);
+		rsp = ksmbd_resp_buf_next(work);
+		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
+				    work->compound_fid);
+			id = work->compound_fid;
+		}
+	} else {
+		req = work->request_buf;
+		rsp = work->response_buf;
+	}
+
+	if (!has_file_id(id))
+		id = le64_to_cpu(req->VolatileFileId);
+
+	if (req->Flags != cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL)) {
+		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+		goto out;
+	}
+
+	cnt_code = le32_to_cpu(req->CntCode);
+	out_buf_len = le32_to_cpu(req->MaxOutputResponse);
+	out_buf_len = min(KSMBD_IPC_MAX_PAYLOAD, out_buf_len);
+
+	switch (cnt_code) {
+	case FSCTL_DFS_GET_REFERRALS:
+	case FSCTL_DFS_GET_REFERRALS_EX:
+		/* Not support DFS yet */
+		rsp->hdr.Status = STATUS_FS_DRIVER_REQUIRED;
+		goto out;
+	case FSCTL_CREATE_OR_GET_OBJECT_ID:
+	{
+		struct file_object_buf_type1_ioctl_rsp *obj_buf;
+
+		nbytes = sizeof(struct file_object_buf_type1_ioctl_rsp);
+		obj_buf = (struct file_object_buf_type1_ioctl_rsp *)
+			&rsp->Buffer[0];
+
+		/*
+		 * TODO: This is dummy implementation to pass smbtorture
+		 * Need to check correct response later
+		 */
+		memset(obj_buf->ObjectId, 0x0, 16);
+		memset(obj_buf->BirthVolumeId, 0x0, 16);
+		memset(obj_buf->BirthObjectId, 0x0, 16);
+		memset(obj_buf->DomainId, 0x0, 16);
+
+		break;
+	}
+	case FSCTL_PIPE_TRANSCEIVE:
+		nbytes = fsctl_pipe_transceive(work, id, out_buf_len, req, rsp);
+		break;
+	case FSCTL_VALIDATE_NEGOTIATE_INFO:
+		if (conn->dialect < SMB30_PROT_ID) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		ret = fsctl_validate_negotiate_info(conn,
+			(struct validate_negotiate_info_req *)&req->Buffer[0],
+			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0]);
+		if (ret < 0)
+			goto out;
+
+		nbytes = sizeof(struct validate_negotiate_info_rsp);
+		rsp->PersistentFileId = cpu_to_le64(SMB2_NO_FID);
+		rsp->VolatileFileId = cpu_to_le64(SMB2_NO_FID);
+		break;
+	case FSCTL_QUERY_NETWORK_INTERFACE_INFO:
+		nbytes = fsctl_query_iface_info_ioctl(conn, req, rsp);
+		if (nbytes < 0)
+			goto out;
+		break;
+	case FSCTL_REQUEST_RESUME_KEY:
+		if (out_buf_len < sizeof(struct resume_key_ioctl_rsp)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = fsctl_request_resume_key(work, req,
+					       (struct resume_key_ioctl_rsp *)&rsp->Buffer[0]);
+		if (ret < 0)
+			goto out;
+		rsp->PersistentFileId = req->PersistentFileId;
+		rsp->VolatileFileId = req->VolatileFileId;
+		nbytes = sizeof(struct resume_key_ioctl_rsp);
+		break;
+	case FSCTL_COPYCHUNK:
+	case FSCTL_COPYCHUNK_WRITE:
+		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ksmbd_debug(SMB,
+				    "User does not have write permission\n");
+			ret = -EACCES;
+			goto out;
+		}
+
+		if (out_buf_len < sizeof(struct copychunk_ioctl_rsp)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		nbytes = sizeof(struct copychunk_ioctl_rsp);
+		fsctl_copychunk(work, req, rsp);
+		break;
+	case FSCTL_SET_SPARSE:
+		ret = fsctl_set_sparse(work, id,
+				       (struct file_sparse *)&req->Buffer[0]);
+		if (ret < 0)
+			goto out;
+		break;
+	case FSCTL_SET_ZERO_DATA:
+	{
+		struct file_zero_data_information *zero_data;
+		struct ksmbd_file *fp;
+		loff_t off, len;
+
+		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ksmbd_debug(SMB,
+				    "User does not have write permission\n");
+			ret = -EACCES;
+			goto out;
+		}
+
+		zero_data =
+			(struct file_zero_data_information *)&req->Buffer[0];
+
+		fp = ksmbd_lookup_fd_fast(work, id);
+		if (!fp) {
+			ret = -ENOENT;
+			goto out;
+		}
+
+		off = le64_to_cpu(zero_data->FileOffset);
+		len = le64_to_cpu(zero_data->BeyondFinalZero) - off;
+
+		ret = ksmbd_vfs_zero_data(work, fp, off, len);
+		ksmbd_fd_put(work, fp);
+		if (ret < 0)
+			goto out;
+		break;
+	}
+	case FSCTL_QUERY_ALLOCATED_RANGES:
+		ret = fsctl_query_allocated_ranges(work, id,
+			(struct file_allocated_range_buffer *)&req->Buffer[0],
+			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
+			out_buf_len /
+			sizeof(struct file_allocated_range_buffer), &nbytes);
+		if (ret == -E2BIG) {
+			rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
+		} else if (ret < 0) {
+			nbytes = 0;
+			goto out;
+		}
+
+		nbytes *= sizeof(struct file_allocated_range_buffer);
+		break;
+	case FSCTL_GET_REPARSE_POINT:
+	{
+		struct reparse_data_buffer *reparse_ptr;
+		struct ksmbd_file *fp;
+
+		reparse_ptr = (struct reparse_data_buffer *)&rsp->Buffer[0];
+		fp = ksmbd_lookup_fd_fast(work, id);
+		if (!fp) {
+			pr_err("not found fp!!\n");
+			ret = -ENOENT;
+			goto out;
+		}
+
+		reparse_ptr->ReparseTag =
+			smb2_get_reparse_tag_special_file(file_inode(fp->filp)->i_mode);
+		reparse_ptr->ReparseDataLength = 0;
+		ksmbd_fd_put(work, fp);
+		nbytes = sizeof(struct reparse_data_buffer);
+		break;
+	}
+	case FSCTL_DUPLICATE_EXTENTS_TO_FILE:
+	{
+		struct ksmbd_file *fp_in, *fp_out = NULL;
+		struct duplicate_extents_to_file *dup_ext;
+		loff_t src_off, dst_off, length, cloned;
+
+		dup_ext = (struct duplicate_extents_to_file *)&req->Buffer[0];
+
+		fp_in = ksmbd_lookup_fd_slow(work, dup_ext->VolatileFileHandle,
+					     dup_ext->PersistentFileHandle);
+		if (!fp_in) {
+			pr_err("not found file handle in duplicate extent to file\n");
+			ret = -ENOENT;
+			goto out;
+		}
+
+		fp_out = ksmbd_lookup_fd_fast(work, id);
+		if (!fp_out) {
+			pr_err("not found fp\n");
+			ret = -ENOENT;
+			goto dup_ext_out;
+		}
+
+		src_off = le64_to_cpu(dup_ext->SourceFileOffset);
+		dst_off = le64_to_cpu(dup_ext->TargetFileOffset);
+		length = le64_to_cpu(dup_ext->ByteCount);
+		cloned = vfs_clone_file_range(fp_in->filp, src_off, fp_out->filp,
+					      dst_off, length, 0);
+		if (cloned == -EXDEV || cloned == -EOPNOTSUPP) {
+			ret = -EOPNOTSUPP;
+			goto dup_ext_out;
+		} else if (cloned != length) {
+			cloned = vfs_copy_file_range(fp_in->filp, src_off,
+						     fp_out->filp, dst_off, length, 0);
+			if (cloned != length) {
+				if (cloned < 0)
+					ret = cloned;
+				else
+					ret = -EINVAL;
+			}
+		}
+
+dup_ext_out:
+		ksmbd_fd_put(work, fp_in);
+		ksmbd_fd_put(work, fp_out);
+		if (ret < 0)
+			goto out;
+		break;
+	}
+	default:
+		ksmbd_debug(SMB, "not implemented yet ioctl command 0x%x\n",
+			    cnt_code);
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	rsp->CntCode = cpu_to_le32(cnt_code);
+	rsp->InputCount = cpu_to_le32(0);
+	rsp->InputOffset = cpu_to_le32(112);
+	rsp->OutputOffset = cpu_to_le32(112);
+	rsp->OutputCount = cpu_to_le32(nbytes);
+	rsp->StructureSize = cpu_to_le16(49);
+	rsp->Reserved = cpu_to_le16(0);
+	rsp->Flags = cpu_to_le32(0);
+	rsp->Reserved2 = cpu_to_le32(0);
+	inc_rfc1001_len(rsp_org, 48 + nbytes);
+
+	return 0;
+
+out:
+	if (ret == -EACCES)
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	else if (ret == -ENOENT)
+		rsp->hdr.Status = STATUS_OBJECT_NAME_NOT_FOUND;
+	else if (ret == -EOPNOTSUPP)
+		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+	else if (ret < 0 || rsp->hdr.Status == 0)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	smb2_set_err_rsp(work);
+	return 0;
+}
+
+/**
+ * smb20_oplock_break_ack() - handler for smb2.0 oplock break command
+ * @work:	smb work containing oplock break command buffer
+ *
+ * Return:	0
+ */
+static void smb20_oplock_break_ack(struct ksmbd_work *work)
+{
+	struct smb2_oplock_break *req = work->request_buf;
+	struct smb2_oplock_break *rsp = work->response_buf;
+	struct ksmbd_file *fp;
+	struct oplock_info *opinfo = NULL;
+	__le32 err = 0;
+	int ret = 0;
+	u64 volatile_id, persistent_id;
+	char req_oplevel = 0, rsp_oplevel = 0;
+	unsigned int oplock_change_type;
+
+	volatile_id = le64_to_cpu(req->VolatileFid);
+	persistent_id = le64_to_cpu(req->PersistentFid);
+	req_oplevel = req->OplockLevel;
+	ksmbd_debug(OPLOCK, "v_id %llu, p_id %llu request oplock level %d\n",
+		    volatile_id, persistent_id, req_oplevel);
+
+	fp = ksmbd_lookup_fd_slow(work, volatile_id, persistent_id);
+	if (!fp) {
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+		smb2_set_err_rsp(work);
+		return;
+	}
+
+	opinfo = opinfo_get(fp);
+	if (!opinfo) {
+		pr_err("unexpected null oplock_info\n");
+		rsp->hdr.Status = STATUS_INVALID_OPLOCK_PROTOCOL;
+		smb2_set_err_rsp(work);
+		ksmbd_fd_put(work, fp);
+		return;
+	}
+
+	if (opinfo->level == SMB2_OPLOCK_LEVEL_NONE) {
+		rsp->hdr.Status = STATUS_INVALID_OPLOCK_PROTOCOL;
+		goto err_out;
+	}
+
+	if (opinfo->op_state == OPLOCK_STATE_NONE) {
+		ksmbd_debug(SMB, "unexpected oplock state 0x%x\n", opinfo->op_state);
+		rsp->hdr.Status = STATUS_UNSUCCESSFUL;
+		goto err_out;
+	}
+
+	if ((opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE ||
+	     opinfo->level == SMB2_OPLOCK_LEVEL_BATCH) &&
+	    (req_oplevel != SMB2_OPLOCK_LEVEL_II &&
+	     req_oplevel != SMB2_OPLOCK_LEVEL_NONE)) {
+		err = STATUS_INVALID_OPLOCK_PROTOCOL;
+		oplock_change_type = OPLOCK_WRITE_TO_NONE;
+	} else if (opinfo->level == SMB2_OPLOCK_LEVEL_II &&
+		   req_oplevel != SMB2_OPLOCK_LEVEL_NONE) {
+		err = STATUS_INVALID_OPLOCK_PROTOCOL;
+		oplock_change_type = OPLOCK_READ_TO_NONE;
+	} else if (req_oplevel == SMB2_OPLOCK_LEVEL_II ||
+		   req_oplevel == SMB2_OPLOCK_LEVEL_NONE) {
+		err = STATUS_INVALID_DEVICE_STATE;
+		if ((opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE ||
+		     opinfo->level == SMB2_OPLOCK_LEVEL_BATCH) &&
+		    req_oplevel == SMB2_OPLOCK_LEVEL_II) {
+			oplock_change_type = OPLOCK_WRITE_TO_READ;
+		} else if ((opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE ||
+			    opinfo->level == SMB2_OPLOCK_LEVEL_BATCH) &&
+			   req_oplevel == SMB2_OPLOCK_LEVEL_NONE) {
+			oplock_change_type = OPLOCK_WRITE_TO_NONE;
+		} else if (opinfo->level == SMB2_OPLOCK_LEVEL_II &&
+			   req_oplevel == SMB2_OPLOCK_LEVEL_NONE) {
+			oplock_change_type = OPLOCK_READ_TO_NONE;
+		} else {
+			oplock_change_type = 0;
+		}
+	} else {
+		oplock_change_type = 0;
+	}
+
+	switch (oplock_change_type) {
+	case OPLOCK_WRITE_TO_READ:
+		ret = opinfo_write_to_read(opinfo);
+		rsp_oplevel = SMB2_OPLOCK_LEVEL_II;
+		break;
+	case OPLOCK_WRITE_TO_NONE:
+		ret = opinfo_write_to_none(opinfo);
+		rsp_oplevel = SMB2_OPLOCK_LEVEL_NONE;
+		break;
+	case OPLOCK_READ_TO_NONE:
+		ret = opinfo_read_to_none(opinfo);
+		rsp_oplevel = SMB2_OPLOCK_LEVEL_NONE;
+		break;
+	default:
+		pr_err("unknown oplock change 0x%x -> 0x%x\n",
+		       opinfo->level, rsp_oplevel);
+	}
+
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
+	opinfo_put(opinfo);
+	ksmbd_fd_put(work, fp);
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	wake_up_interruptible_all(&opinfo->oplock_q);
+
+	rsp->StructureSize = cpu_to_le16(24);
+	rsp->OplockLevel = rsp_oplevel;
+	rsp->Reserved = 0;
+	rsp->Reserved2 = 0;
+	rsp->VolatileFid = cpu_to_le64(volatile_id);
+	rsp->PersistentFid = cpu_to_le64(persistent_id);
+	inc_rfc1001_len(rsp, 24);
+	return;
+
+err_out:
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	wake_up_interruptible_all(&opinfo->oplock_q);
+
+	opinfo_put(opinfo);
+	ksmbd_fd_put(work, fp);
+	smb2_set_err_rsp(work);
+}
+
+static int check_lease_state(struct lease *lease, __le32 req_state)
+{
+	if ((lease->new_state ==
+	     (SMB2_LEASE_READ_CACHING_LE | SMB2_LEASE_HANDLE_CACHING_LE)) &&
+	    !(req_state & SMB2_LEASE_WRITE_CACHING_LE)) {
+		lease->new_state = req_state;
+		return 0;
+	}
+
+	if (lease->new_state == req_state)
+		return 0;
+
+	return 1;
+}
+
+/**
+ * smb21_lease_break_ack() - handler for smb2.1 lease break command
+ * @work:	smb work containing lease break command buffer
+ *
+ * Return:	0
+ */
+static void smb21_lease_break_ack(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_lease_ack *req = work->request_buf;
+	struct smb2_lease_ack *rsp = work->response_buf;
+	struct oplock_info *opinfo;
+	__le32 err = 0;
+	int ret = 0;
+	unsigned int lease_change_type;
+	__le32 lease_state;
+	struct lease *lease;
+
+	ksmbd_debug(OPLOCK, "smb21 lease break, lease state(0x%x)\n",
+		    le32_to_cpu(req->LeaseState));
+	opinfo = lookup_lease_in_table(conn, req->LeaseKey);
+	if (!opinfo) {
+		ksmbd_debug(OPLOCK, "file not opened\n");
+		smb2_set_err_rsp(work);
+		rsp->hdr.Status = STATUS_UNSUCCESSFUL;
+		return;
+	}
+	lease = opinfo->o_lease;
+
+	if (opinfo->op_state == OPLOCK_STATE_NONE) {
+		pr_err("unexpected lease break state 0x%x\n",
+		       opinfo->op_state);
+		rsp->hdr.Status = STATUS_UNSUCCESSFUL;
+		goto err_out;
+	}
+
+	if (check_lease_state(lease, req->LeaseState)) {
+		rsp->hdr.Status = STATUS_REQUEST_NOT_ACCEPTED;
+		ksmbd_debug(OPLOCK,
+			    "req lease state: 0x%x, expected state: 0x%x\n",
+			    req->LeaseState, lease->new_state);
+		goto err_out;
+	}
+
+	if (!atomic_read(&opinfo->breaking_cnt)) {
+		rsp->hdr.Status = STATUS_UNSUCCESSFUL;
+		goto err_out;
+	}
+
+	/* check for bad lease state */
+	if (req->LeaseState &
+	    (~(SMB2_LEASE_READ_CACHING_LE | SMB2_LEASE_HANDLE_CACHING_LE))) {
+		err = STATUS_INVALID_OPLOCK_PROTOCOL;
+		if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+			lease_change_type = OPLOCK_WRITE_TO_NONE;
+		else
+			lease_change_type = OPLOCK_READ_TO_NONE;
+		ksmbd_debug(OPLOCK, "handle bad lease state 0x%x -> 0x%x\n",
+			    le32_to_cpu(lease->state),
+			    le32_to_cpu(req->LeaseState));
+	} else if (lease->state == SMB2_LEASE_READ_CACHING_LE &&
+		   req->LeaseState != SMB2_LEASE_NONE_LE) {
+		err = STATUS_INVALID_OPLOCK_PROTOCOL;
+		lease_change_type = OPLOCK_READ_TO_NONE;
+		ksmbd_debug(OPLOCK, "handle bad lease state 0x%x -> 0x%x\n",
+			    le32_to_cpu(lease->state),
+			    le32_to_cpu(req->LeaseState));
+	} else {
+		/* valid lease state changes */
+		err = STATUS_INVALID_DEVICE_STATE;
+		if (req->LeaseState == SMB2_LEASE_NONE_LE) {
+			if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+				lease_change_type = OPLOCK_WRITE_TO_NONE;
+			else
+				lease_change_type = OPLOCK_READ_TO_NONE;
+		} else if (req->LeaseState & SMB2_LEASE_READ_CACHING_LE) {
+			if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+				lease_change_type = OPLOCK_WRITE_TO_READ;
+			else
+				lease_change_type = OPLOCK_READ_HANDLE_TO_READ;
+		} else {
+			lease_change_type = 0;
+		}
+	}
+
+	switch (lease_change_type) {
+	case OPLOCK_WRITE_TO_READ:
+		ret = opinfo_write_to_read(opinfo);
+		break;
+	case OPLOCK_READ_HANDLE_TO_READ:
+		ret = opinfo_read_handle_to_read(opinfo);
+		break;
+	case OPLOCK_WRITE_TO_NONE:
+		ret = opinfo_write_to_none(opinfo);
+		break;
+	case OPLOCK_READ_TO_NONE:
+		ret = opinfo_read_to_none(opinfo);
+		break;
+	default:
+		ksmbd_debug(OPLOCK, "unknown lease change 0x%x -> 0x%x\n",
+			    le32_to_cpu(lease->state),
+			    le32_to_cpu(req->LeaseState));
+	}
+
+	lease_state = lease->state;
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	wake_up_interruptible_all(&opinfo->oplock_q);
+	atomic_dec(&opinfo->breaking_cnt);
+	wake_up_interruptible_all(&opinfo->oplock_brk);
+	opinfo_put(opinfo);
+
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
+	rsp->StructureSize = cpu_to_le16(36);
+	rsp->Reserved = 0;
+	rsp->Flags = 0;
+	memcpy(rsp->LeaseKey, req->LeaseKey, 16);
+	rsp->LeaseState = lease_state;
+	rsp->LeaseDuration = 0;
+	inc_rfc1001_len(rsp, 36);
+	return;
+
+err_out:
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	wake_up_interruptible_all(&opinfo->oplock_q);
+	atomic_dec(&opinfo->breaking_cnt);
+	wake_up_interruptible_all(&opinfo->oplock_brk);
+
+	opinfo_put(opinfo);
+	smb2_set_err_rsp(work);
+}
+
+/**
+ * smb2_oplock_break() - dispatcher for smb2.0 and 2.1 oplock/lease break
+ * @work:	smb work containing oplock/lease break command buffer
+ *
+ * Return:	0
+ */
+int smb2_oplock_break(struct ksmbd_work *work)
+{
+	struct smb2_oplock_break *req = work->request_buf;
+	struct smb2_oplock_break *rsp = work->response_buf;
+
+	switch (le16_to_cpu(req->StructureSize)) {
+	case OP_BREAK_STRUCT_SIZE_20:
+		smb20_oplock_break_ack(work);
+		break;
+	case OP_BREAK_STRUCT_SIZE_21:
+		smb21_lease_break_ack(work);
+		break;
+	default:
+		ksmbd_debug(OPLOCK, "invalid break cmd %d\n",
+			    le16_to_cpu(req->StructureSize));
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		smb2_set_err_rsp(work);
+	}
+
+	return 0;
+}
+
+/**
+ * smb2_notify() - handler for smb2 notify request
+ * @work:   smb work containing notify command buffer
+ *
+ * Return:      0
+ */
+int smb2_notify(struct ksmbd_work *work)
+{
+	struct smb2_notify_req *req;
+	struct smb2_notify_rsp *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
+
+	if (work->next_smb2_rcv_hdr_off && req->hdr.NextCommand) {
+		rsp->hdr.Status = STATUS_INTERNAL_ERROR;
+		smb2_set_err_rsp(work);
+		return 0;
+	}
+
+	smb2_set_err_rsp(work);
+	rsp->hdr.Status = STATUS_NOT_IMPLEMENTED;
+	return 0;
+}
+
+/**
+ * smb2_is_sign_req() - handler for checking packet signing status
+ * @work:	smb work containing notify command buffer
+ * @command:	SMB2 command id
+ *
+ * Return:	true if packed is signed, false otherwise
+ */
+bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
+{
+	struct smb2_hdr *rcv_hdr2 = work->request_buf;
+
+	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
+	    command != SMB2_NEGOTIATE_HE &&
+	    command != SMB2_SESSION_SETUP_HE &&
+	    command != SMB2_OPLOCK_BREAK_HE)
+		return true;
+
+	return false;
+}
+
+/**
+ * smb2_check_sign_req() - handler for req packet sign processing
+ * @work:   smb work containing notify command buffer
+ *
+ * Return:	1 on success, 0 otherwise
+ */
+int smb2_check_sign_req(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr, *hdr_org;
+	char signature_req[SMB2_SIGNATURE_SIZE];
+	char signature[SMB2_HMACSHA256_SIZE];
+	struct kvec iov[1];
+	size_t len;
+
+	hdr_org = hdr = work->request_buf;
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = ksmbd_req_buf_next(work);
+
+	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
+		len = be32_to_cpu(hdr_org->smb2_buf_length);
+	else if (hdr->NextCommand)
+		len = le32_to_cpu(hdr->NextCommand);
+	else
+		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+			work->next_smb2_rcv_hdr_off;
+
+	memcpy(signature_req, hdr->Signature, SMB2_SIGNATURE_SIZE);
+	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
+
+	iov[0].iov_base = (char *)&hdr->ProtocolId;
+	iov[0].iov_len = len;
+
+	if (ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, 1,
+				signature))
+		return 0;
+
+	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+		pr_err("bad smb2 signature\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ * smb2_set_sign_rsp() - handler for rsp packet sign processing
+ * @work:   smb work containing notify command buffer
+ *
+ */
+void smb2_set_sign_rsp(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *req_hdr;
+	char signature[SMB2_HMACSHA256_SIZE];
+	struct kvec iov[2];
+	size_t len;
+	int n_vec = 1;
+
+	hdr_org = hdr = work->response_buf;
+	if (work->next_smb2_rsp_hdr_off)
+		hdr = ksmbd_resp_buf_next(work);
+
+	req_hdr = ksmbd_req_buf_next(work);
+
+	if (!work->next_smb2_rsp_hdr_off) {
+		len = get_rfc1002_len(hdr_org);
+		if (req_hdr->NextCommand)
+			len = ALIGN(len, 8);
+	} else {
+		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
+		len = ALIGN(len, 8);
+	}
+
+	if (req_hdr->NextCommand)
+		hdr->NextCommand = cpu_to_le32(len);
+
+	hdr->Flags |= SMB2_FLAGS_SIGNED;
+	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
+
+	iov[0].iov_base = (char *)&hdr->ProtocolId;
+	iov[0].iov_len = len;
+
+	if (work->aux_payload_sz) {
+		iov[0].iov_len -= work->aux_payload_sz;
+
+		iov[1].iov_base = work->aux_payload_buf;
+		iov[1].iov_len = work->aux_payload_sz;
+		n_vec++;
+	}
+
+	if (!ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, n_vec,
+				 signature))
+		memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
+}
+
+/**
+ * smb3_check_sign_req() - handler for req packet sign processing
+ * @work:   smb work containing notify command buffer
+ *
+ * Return:	1 on success, 0 otherwise
+ */
+int smb3_check_sign_req(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	char *signing_key;
+	struct smb2_hdr *hdr, *hdr_org;
+	struct channel *chann;
+	char signature_req[SMB2_SIGNATURE_SIZE];
+	char signature[SMB2_CMACAES_SIZE];
+	struct kvec iov[1];
+	size_t len;
+
+	hdr_org = hdr = work->request_buf;
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = ksmbd_req_buf_next(work);
+
+	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
+		len = be32_to_cpu(hdr_org->smb2_buf_length);
+	else if (hdr->NextCommand)
+		len = le32_to_cpu(hdr->NextCommand);
+	else
+		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+			work->next_smb2_rcv_hdr_off;
+
+	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
+		signing_key = work->sess->smb3signingkey;
+	} else {
+		chann = lookup_chann_list(work->sess, conn);
+		if (!chann)
+			return 0;
+		signing_key = chann->smb3signingkey;
+	}
+
+	if (!signing_key) {
+		pr_err("SMB3 signing key is not generated\n");
+		return 0;
+	}
+
+	memcpy(signature_req, hdr->Signature, SMB2_SIGNATURE_SIZE);
+	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
+	iov[0].iov_base = (char *)&hdr->ProtocolId;
+	iov[0].iov_len = len;
+
+	if (ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature))
+		return 0;
+
+	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+		pr_err("bad smb2 signature\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ * smb3_set_sign_rsp() - handler for rsp packet sign processing
+ * @work:   smb work containing notify command buffer
+ *
+ */
+void smb3_set_sign_rsp(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *req_hdr;
+	struct smb2_hdr *hdr, *hdr_org;
+	struct channel *chann;
+	char signature[SMB2_CMACAES_SIZE];
+	struct kvec iov[2];
+	int n_vec = 1;
+	size_t len;
+	char *signing_key;
+
+	hdr_org = hdr = work->response_buf;
+	if (work->next_smb2_rsp_hdr_off)
+		hdr = ksmbd_resp_buf_next(work);
+
+	req_hdr = ksmbd_req_buf_next(work);
+
+	if (!work->next_smb2_rsp_hdr_off) {
+		len = get_rfc1002_len(hdr_org);
+		if (req_hdr->NextCommand)
+			len = ALIGN(len, 8);
+	} else {
+		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
+		len = ALIGN(len, 8);
+	}
+
+	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
+		signing_key = work->sess->smb3signingkey;
+	} else {
+		chann = lookup_chann_list(work->sess, work->conn);
+		if (!chann)
+			return;
+		signing_key = chann->smb3signingkey;
+	}
+
+	if (!signing_key)
+		return;
+
+	if (req_hdr->NextCommand)
+		hdr->NextCommand = cpu_to_le32(len);
+
+	hdr->Flags |= SMB2_FLAGS_SIGNED;
+	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
+	iov[0].iov_base = (char *)&hdr->ProtocolId;
+	iov[0].iov_len = len;
+	if (work->aux_payload_sz) {
+		iov[0].iov_len -= work->aux_payload_sz;
+		iov[1].iov_base = work->aux_payload_buf;
+		iov[1].iov_len = work->aux_payload_sz;
+		n_vec++;
+	}
+
+	if (!ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec, signature))
+		memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
+}
+
+/**
+ * smb3_preauth_hash_rsp() - handler for computing preauth hash on response
+ * @work:   smb work containing response buffer
+ *
+ */
+void smb3_preauth_hash_rsp(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	struct smb2_hdr *req, *rsp;
+
+	if (conn->dialect != SMB311_PROT_ID)
+		return;
+
+	WORK_BUFFERS(work, req, rsp);
+
+	if (le16_to_cpu(req->Command) == SMB2_NEGOTIATE_HE)
+		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+						 conn->preauth_info->Preauth_HashValue);
+
+	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE && sess) {
+		__u8 *hash_value;
+
+		if (conn->binding) {
+			struct preauth_session *preauth_sess;
+
+			preauth_sess = ksmbd_preauth_session_lookup(conn, sess->id);
+			if (!preauth_sess)
+				return;
+			hash_value = preauth_sess->Preauth_HashValue;
+		} else {
+			hash_value = sess->Preauth_HashValue;
+			if (!hash_value)
+				return;
+		}
+		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+						 hash_value);
+	}
+}
+
+static void fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, char *old_buf,
+			       __le16 cipher_type)
+{
+	struct smb2_hdr *hdr = (struct smb2_hdr *)old_buf;
+	unsigned int orig_len = get_rfc1002_len(old_buf);
+
+	memset(tr_hdr, 0, sizeof(struct smb2_transform_hdr));
+	tr_hdr->ProtocolId = SMB2_TRANSFORM_PROTO_NUM;
+	tr_hdr->OriginalMessageSize = cpu_to_le32(orig_len);
+	tr_hdr->Flags = cpu_to_le16(0x01);
+	if (cipher_type == SMB2_ENCRYPTION_AES128_GCM ||
+	    cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+		get_random_bytes(&tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
+	else
+		get_random_bytes(&tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
+	memcpy(&tr_hdr->SessionId, &hdr->SessionId, 8);
+	inc_rfc1001_len(tr_hdr, sizeof(struct smb2_transform_hdr) - 4);
+	inc_rfc1001_len(tr_hdr, orig_len);
+}
+
+int smb3_encrypt_resp(struct ksmbd_work *work)
+{
+	char *buf = work->response_buf;
+	struct smb2_transform_hdr *tr_hdr;
+	struct kvec iov[3];
+	int rc = -ENOMEM;
+	int buf_size = 0, rq_nvec = 2 + (work->aux_payload_sz ? 1 : 0);
+
+	if (ARRAY_SIZE(iov) < rq_nvec)
+		return -ENOMEM;
+
+	tr_hdr = kzalloc(sizeof(struct smb2_transform_hdr), GFP_KERNEL);
+	if (!tr_hdr)
+		return rc;
+
+	/* fill transform header */
+	fill_transform_hdr(tr_hdr, buf, work->conn->cipher_type);
+
+	iov[0].iov_base = tr_hdr;
+	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
+	buf_size += iov[0].iov_len - 4;
+
+	iov[1].iov_base = buf + 4;
+	iov[1].iov_len = get_rfc1002_len(buf);
+	if (work->aux_payload_sz) {
+		iov[1].iov_len = work->resp_hdr_sz - 4;
+
+		iov[2].iov_base = work->aux_payload_buf;
+		iov[2].iov_len = work->aux_payload_sz;
+		buf_size += iov[2].iov_len;
+	}
+	buf_size += iov[1].iov_len;
+	work->resp_hdr_sz = iov[1].iov_len;
+
+	rc = ksmbd_crypt_message(work->conn, iov, rq_nvec, 1);
+	if (rc)
+		return rc;
+
+	memmove(buf, iov[1].iov_base, iov[1].iov_len);
+	tr_hdr->smb2_buf_length = cpu_to_be32(buf_size);
+	work->tr_buf = tr_hdr;
+
+	return rc;
+}
+
+int smb3_is_transform_hdr(void *buf)
+{
+	struct smb2_transform_hdr *trhdr = buf;
+
+	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
+}
+
+int smb3_decrypt_req(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess;
+	char *buf = work->request_buf;
+	struct smb2_hdr *hdr;
+	unsigned int pdu_length = get_rfc1002_len(buf);
+	struct kvec iov[2];
+	unsigned int buf_data_size = pdu_length + 4 -
+		sizeof(struct smb2_transform_hdr);
+	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
+	unsigned int orig_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
+	int rc = 0;
+
+	sess = ksmbd_session_lookup_all(conn, le64_to_cpu(tr_hdr->SessionId));
+	if (!sess) {
+		pr_err("invalid session id(%llx) in transform header\n",
+		       le64_to_cpu(tr_hdr->SessionId));
+		return -ECONNABORTED;
+	}
+
+	if (pdu_length + 4 <
+	    sizeof(struct smb2_transform_hdr) + sizeof(struct smb2_hdr)) {
+		pr_err("Transform message is too small (%u)\n",
+		       pdu_length);
+		return -ECONNABORTED;
+	}
+
+	if (pdu_length + 4 < orig_len + sizeof(struct smb2_transform_hdr)) {
+		pr_err("Transform message is broken\n");
+		return -ECONNABORTED;
+	}
+
+	iov[0].iov_base = buf;
+	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
+	iov[1].iov_base = buf + sizeof(struct smb2_transform_hdr);
+	iov[1].iov_len = buf_data_size;
+	rc = ksmbd_crypt_message(conn, iov, 2, 0);
+	if (rc)
+		return rc;
+
+	memmove(buf + 4, iov[1].iov_base, buf_data_size);
+	hdr = (struct smb2_hdr *)buf;
+	hdr->smb2_buf_length = cpu_to_be32(buf_data_size);
+
+	return rc;
+}
+
+bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *rsp = work->response_buf;
+
+	if (conn->dialect < SMB30_PROT_ID)
+		return false;
+
+	if (work->next_smb2_rcv_hdr_off)
+		rsp = ksmbd_resp_buf_next(work);
+
+	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE &&
+	    rsp->Status == STATUS_SUCCESS)
+		return true;
+	return false;
+}
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
new file mode 100644
index 000000000000..0eac40e1ba65
--- /dev/null
+++ b/fs/ksmbd/smb2pdu.h
@@ -0,0 +1,1684 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef _SMB2PDU_H
+#define _SMB2PDU_H
+
+#include "ntlmssp.h"
+#include "smbacl.h"
+
+/*
+ * Note that, due to trying to use names similar to the protocol specifications,
+ * there are many mixed case field names in the structures below.  Although
+ * this does not match typical Linux kernel style, it is necessary to be
+ * able to match against the protocol specfication.
+ *
+ * SMB2 commands
+ * Some commands have minimal (wct=0,bcc=0), or uninteresting, responses
+ * (ie no useful data other than the SMB error code itself) and are marked such.
+ * Knowing this helps avoid response buffer allocations and copy in some cases.
+ */
+
+/* List of commands in host endian */
+#define SMB2_NEGOTIATE_HE	0x0000
+#define SMB2_SESSION_SETUP_HE	0x0001
+#define SMB2_LOGOFF_HE		0x0002 /* trivial request/resp */
+#define SMB2_TREE_CONNECT_HE	0x0003
+#define SMB2_TREE_DISCONNECT_HE	0x0004 /* trivial req/resp */
+#define SMB2_CREATE_HE		0x0005
+#define SMB2_CLOSE_HE		0x0006
+#define SMB2_FLUSH_HE		0x0007 /* trivial resp */
+#define SMB2_READ_HE		0x0008
+#define SMB2_WRITE_HE		0x0009
+#define SMB2_LOCK_HE		0x000A
+#define SMB2_IOCTL_HE		0x000B
+#define SMB2_CANCEL_HE		0x000C
+#define SMB2_ECHO_HE		0x000D
+#define SMB2_QUERY_DIRECTORY_HE	0x000E
+#define SMB2_CHANGE_NOTIFY_HE	0x000F
+#define SMB2_QUERY_INFO_HE	0x0010
+#define SMB2_SET_INFO_HE	0x0011
+#define SMB2_OPLOCK_BREAK_HE	0x0012
+
+/* The same list in little endian */
+#define SMB2_NEGOTIATE		cpu_to_le16(SMB2_NEGOTIATE_HE)
+#define SMB2_SESSION_SETUP	cpu_to_le16(SMB2_SESSION_SETUP_HE)
+#define SMB2_LOGOFF		cpu_to_le16(SMB2_LOGOFF_HE)
+#define SMB2_TREE_CONNECT	cpu_to_le16(SMB2_TREE_CONNECT_HE)
+#define SMB2_TREE_DISCONNECT	cpu_to_le16(SMB2_TREE_DISCONNECT_HE)
+#define SMB2_CREATE		cpu_to_le16(SMB2_CREATE_HE)
+#define SMB2_CLOSE		cpu_to_le16(SMB2_CLOSE_HE)
+#define SMB2_FLUSH		cpu_to_le16(SMB2_FLUSH_HE)
+#define SMB2_READ		cpu_to_le16(SMB2_READ_HE)
+#define SMB2_WRITE		cpu_to_le16(SMB2_WRITE_HE)
+#define SMB2_LOCK		cpu_to_le16(SMB2_LOCK_HE)
+#define SMB2_IOCTL		cpu_to_le16(SMB2_IOCTL_HE)
+#define SMB2_CANCEL		cpu_to_le16(SMB2_CANCEL_HE)
+#define SMB2_ECHO		cpu_to_le16(SMB2_ECHO_HE)
+#define SMB2_QUERY_DIRECTORY	cpu_to_le16(SMB2_QUERY_DIRECTORY_HE)
+#define SMB2_CHANGE_NOTIFY	cpu_to_le16(SMB2_CHANGE_NOTIFY_HE)
+#define SMB2_QUERY_INFO		cpu_to_le16(SMB2_QUERY_INFO_HE)
+#define SMB2_SET_INFO		cpu_to_le16(SMB2_SET_INFO_HE)
+#define SMB2_OPLOCK_BREAK	cpu_to_le16(SMB2_OPLOCK_BREAK_HE)
+
+/*Create Action Flags*/
+#define FILE_SUPERSEDED                0x00000000
+#define FILE_OPENED            0x00000001
+#define FILE_CREATED           0x00000002
+#define FILE_OVERWRITTEN       0x00000003
+
+/*
+ * Size of the session key (crypto key encrypted with the password
+ */
+#define SMB2_NTLMV2_SESSKEY_SIZE	16
+#define SMB2_SIGNATURE_SIZE		16
+#define SMB2_HMACSHA256_SIZE		32
+#define SMB2_CMACAES_SIZE		16
+#define SMB3_GCM128_CRYPTKEY_SIZE	16
+#define SMB3_GCM256_CRYPTKEY_SIZE	32
+
+/*
+ * Size of the smb3 encryption/decryption keys
+ */
+#define SMB3_ENC_DEC_KEY_SIZE		32
+
+/*
+ * Size of the smb3 signing key
+ */
+#define SMB3_SIGN_KEY_SIZE		16
+
+#define CIFS_CLIENT_CHALLENGE_SIZE	8
+#define SMB_SERVER_CHALLENGE_SIZE	8
+
+/* SMB2 Max Credits */
+#define SMB2_MAX_CREDITS		8192
+
+#define SMB2_CLIENT_GUID_SIZE		16
+#define SMB2_CREATE_GUID_SIZE		16
+
+/* Maximum buffer size value we can send with 1 credit */
+#define SMB2_MAX_BUFFER_SIZE 65536
+
+#define NUMBER_OF_SMB2_COMMANDS	0x0013
+
+/* BB FIXME - analyze following length BB */
+#define MAX_SMB2_HDR_SIZE 0x78 /* 4 len + 64 hdr + (2*24 wct) + 2 bct + 2 pad */
+
+#define SMB2_PROTO_NUMBER cpu_to_le32(0x424d53fe) /* 'B''M''S' */
+#define SMB2_TRANSFORM_PROTO_NUM cpu_to_le32(0x424d53fd)
+
+#define SMB21_DEFAULT_IOSIZE	(1024 * 1024)
+#define SMB3_DEFAULT_IOSIZE	(4 * 1024 * 1024)
+#define SMB3_DEFAULT_TRANS_SIZE	(1024 * 1024)
+
+/*
+ * SMB2 Header Definition
+ *
+ * "MBZ" :  Must be Zero
+ * "BB"  :  BugBug, Something to check/review/analyze later
+ * "PDU" :  "Protocol Data Unit" (ie a network "frame")
+ *
+ */
+
+#define __SMB2_HEADER_STRUCTURE_SIZE	64
+#define SMB2_HEADER_STRUCTURE_SIZE				\
+	cpu_to_le16(__SMB2_HEADER_STRUCTURE_SIZE)
+
+struct smb2_hdr {
+	__be32 smb2_buf_length;	/* big endian on wire */
+				/*
+				 * length is only two or three bytes - with
+				 * one or two byte type preceding it that MBZ
+				 */
+	__le32 ProtocolId;	/* 0xFE 'S' 'M' 'B' */
+	__le16 StructureSize;	/* 64 */
+	__le16 CreditCharge;	/* MBZ */
+	__le32 Status;		/* Error from server */
+	__le16 Command;
+	__le16 CreditRequest;	/* CreditResponse */
+	__le32 Flags;
+	__le32 NextCommand;
+	__le64 MessageId;
+	union {
+		struct {
+			__le32 ProcessId;
+			__le32  TreeId;
+		} __packed SyncId;
+		__le64  AsyncId;
+	} __packed Id;
+	__le64  SessionId;
+	__u8   Signature[16];
+} __packed;
+
+struct smb2_pdu {
+	struct smb2_hdr hdr;
+	__le16 StructureSize2; /* size of wct area (varies, request specific) */
+} __packed;
+
+#define SMB3_AES_CCM_NONCE 11
+#define SMB3_AES_GCM_NONCE 12
+
+struct smb2_transform_hdr {
+	__be32 smb2_buf_length; /* big endian on wire */
+	/*
+	 * length is only two or three bytes - with
+	 * one or two byte type preceding it that MBZ
+	 */
+	__le32 ProtocolId;      /* 0xFD 'S' 'M' 'B' */
+	__u8   Signature[16];
+	__u8   Nonce[16];
+	__le32 OriginalMessageSize;
+	__u16  Reserved1;
+	__le16 Flags; /* EncryptionAlgorithm */
+	__le64  SessionId;
+} __packed;
+
+/*
+ *	SMB2 flag definitions
+ */
+#define SMB2_FLAGS_SERVER_TO_REDIR	cpu_to_le32(0x00000001)
+#define SMB2_FLAGS_ASYNC_COMMAND	cpu_to_le32(0x00000002)
+#define SMB2_FLAGS_RELATED_OPERATIONS	cpu_to_le32(0x00000004)
+#define SMB2_FLAGS_SIGNED		cpu_to_le32(0x00000008)
+#define SMB2_FLAGS_DFS_OPERATIONS	cpu_to_le32(0x10000000)
+#define SMB2_FLAGS_REPLAY_OPERATIONS	cpu_to_le32(0x20000000)
+
+/*
+ *	Definitions for SMB2 Protocol Data Units (network frames)
+ *
+ *  See MS-SMB2.PDF specification for protocol details.
+ *  The Naming convention is the lower case version of the SMB2
+ *  command code name for the struct. Note that structures must be packed.
+ *
+ */
+
+#define SMB2_ERROR_STRUCTURE_SIZE2	9
+#define SMB2_ERROR_STRUCTURE_SIZE2_LE	cpu_to_le16(SMB2_ERROR_STRUCTURE_SIZE2)
+
+struct smb2_err_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;
+	__u8   ErrorContextCount;
+	__u8   Reserved;
+	__le32 ByteCount;  /* even if zero, at least one byte follows */
+	__u8   ErrorData[1];  /* variable length */
+} __packed;
+
+struct smb2_negotiate_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 36 */
+	__le16 DialectCount;
+	__le16 SecurityMode;
+	__le16 Reserved;	/* MBZ */
+	__le32 Capabilities;
+	__u8   ClientGUID[SMB2_CLIENT_GUID_SIZE];
+	/* In SMB3.02 and earlier next three were MBZ le64 ClientStartTime */
+	__le32 NegotiateContextOffset; /* SMB3.1.1 only. MBZ earlier */
+	__le16 NegotiateContextCount;  /* SMB3.1.1 only. MBZ earlier */
+	__le16 Reserved2;
+	__le16 Dialects[1]; /* One dialect (vers=) at a time for now */
+} __packed;
+
+/* SecurityMode flags */
+#define SMB2_NEGOTIATE_SIGNING_ENABLED_LE	cpu_to_le16(0x0001)
+#define SMB2_NEGOTIATE_SIGNING_REQUIRED		0x0002
+#define SMB2_NEGOTIATE_SIGNING_REQUIRED_LE	cpu_to_le16(0x0002)
+/* Capabilities flags */
+#define SMB2_GLOBAL_CAP_DFS		0x00000001
+#define SMB2_GLOBAL_CAP_LEASING		0x00000002 /* Resp only New to SMB2.1 */
+#define SMB2_GLOBAL_CAP_LARGE_MTU	0X00000004 /* Resp only New to SMB2.1 */
+#define SMB2_GLOBAL_CAP_MULTI_CHANNEL	0x00000008 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_PERSISTENT_HANDLES 0x00000010 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_DIRECTORY_LEASING  0x00000020 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_ENCRYPTION	0x00000040 /* New to SMB3 */
+/* Internal types */
+#define SMB2_NT_FIND			0x00100000
+#define SMB2_LARGE_FILES		0x00200000
+
+#define SMB311_SALT_SIZE			32
+/* Hash Algorithm Types */
+#define SMB2_PREAUTH_INTEGRITY_SHA512	cpu_to_le16(0x0001)
+
+#define PREAUTH_HASHVALUE_SIZE		64
+
+struct preauth_integrity_info {
+	/* PreAuth integrity Hash ID */
+	__le16			Preauth_HashId;
+	/* PreAuth integrity Hash Value */
+	__u8			Preauth_HashValue[PREAUTH_HASHVALUE_SIZE];
+};
+
+/* offset is sizeof smb2_negotiate_rsp - 4 but rounded up to 8 bytes. */
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+/* sizeof(struct smb2_negotiate_rsp) - 4 =
+ * header(64) + response(64) + GSS_LENGTH(96) + GSS_PADDING(0)
+ */
+#define OFFSET_OF_NEG_CONTEXT	0xe0
+#else
+/* sizeof(struct smb2_negotiate_rsp) - 4 =
+ * header(64) + response(64) + GSS_LENGTH(74) + GSS_PADDING(6)
+ */
+#define OFFSET_OF_NEG_CONTEXT	0xd0
+#endif
+
+#define SMB2_PREAUTH_INTEGRITY_CAPABILITIES	cpu_to_le16(1)
+#define SMB2_ENCRYPTION_CAPABILITIES		cpu_to_le16(2)
+#define SMB2_COMPRESSION_CAPABILITIES		cpu_to_le16(3)
+#define SMB2_NETNAME_NEGOTIATE_CONTEXT_ID	cpu_to_le16(5)
+#define SMB2_POSIX_EXTENSIONS_AVAILABLE		cpu_to_le16(0x100)
+
+struct smb2_neg_context {
+	__le16  ContextType;
+	__le16  DataLength;
+	__le32  Reserved;
+	/* Followed by array of data */
+} __packed;
+
+struct smb2_preauth_neg_context {
+	__le16	ContextType; /* 1 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__le16	HashAlgorithmCount; /* 1 */
+	__le16	SaltLength;
+	__le16	HashAlgorithms; /* HashAlgorithms[0] since only one defined */
+	__u8	Salt[SMB311_SALT_SIZE];
+} __packed;
+
+/* Encryption Algorithms Ciphers */
+#define SMB2_ENCRYPTION_AES128_CCM	cpu_to_le16(0x0001)
+#define SMB2_ENCRYPTION_AES128_GCM	cpu_to_le16(0x0002)
+#define SMB2_ENCRYPTION_AES256_CCM	cpu_to_le16(0x0003)
+#define SMB2_ENCRYPTION_AES256_GCM	cpu_to_le16(0x0004)
+
+struct smb2_encryption_neg_context {
+	__le16	ContextType; /* 2 */
+	__le16	DataLength;
+	__le32	Reserved;
+	/* CipherCount usally 2, but can be 3 when AES256-GCM enabled */
+	__le16	CipherCount; /* AES-128-GCM and AES-128-CCM by default */
+	__le16	Ciphers[1];
+} __packed;
+
+#define SMB3_COMPRESS_NONE	cpu_to_le16(0x0000)
+#define SMB3_COMPRESS_LZNT1	cpu_to_le16(0x0001)
+#define SMB3_COMPRESS_LZ77	cpu_to_le16(0x0002)
+#define SMB3_COMPRESS_LZ77_HUFF	cpu_to_le16(0x0003)
+
+struct smb2_compression_ctx {
+	__le16	ContextType; /* 3 */
+	__le16  DataLength;
+	__le32	Reserved;
+	__le16	CompressionAlgorithmCount;
+	__u16	Padding;
+	__le32	Reserved1;
+	__le16	CompressionAlgorithms[1];
+} __packed;
+
+#define POSIX_CTXT_DATA_LEN     16
+struct smb2_posix_neg_context {
+	__le16	ContextType; /* 0x100 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__u8	Name[16]; /* POSIX ctxt GUID 93AD25509CB411E7B42383DE968BCD7C */
+} __packed;
+
+struct smb2_netname_neg_context {
+	__le16	ContextType; /* 0x100 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__le16	NetName[0]; /* hostname of target converted to UCS-2 */
+} __packed;
+
+struct smb2_negotiate_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 65 */
+	__le16 SecurityMode;
+	__le16 DialectRevision;
+	__le16 NegotiateContextCount; /* Prior to SMB3.1.1 was Reserved & MBZ */
+	__u8   ServerGUID[16];
+	__le32 Capabilities;
+	__le32 MaxTransactSize;
+	__le32 MaxReadSize;
+	__le32 MaxWriteSize;
+	__le64 SystemTime;	/* MBZ */
+	__le64 ServerStartTime;
+	__le16 SecurityBufferOffset;
+	__le16 SecurityBufferLength;
+	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
+	__u8   Buffer[1];	/* variable length GSS security buffer */
+} __packed;
+
+/* Flags */
+#define SMB2_SESSION_REQ_FLAG_BINDING		0x01
+#define SMB2_SESSION_REQ_FLAG_ENCRYPT_DATA	0x04
+
+#define SMB2_SESSION_EXPIRED		(0)
+#define SMB2_SESSION_IN_PROGRESS	BIT(0)
+#define SMB2_SESSION_VALID		BIT(1)
+
+/* Flags */
+#define SMB2_SESSION_REQ_FLAG_BINDING		0x01
+#define SMB2_SESSION_REQ_FLAG_ENCRYPT_DATA	0x04
+
+struct smb2_sess_setup_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 25 */
+	__u8   Flags;
+	__u8   SecurityMode;
+	__le32 Capabilities;
+	__le32 Channel;
+	__le16 SecurityBufferOffset;
+	__le16 SecurityBufferLength;
+	__le64 PreviousSessionId;
+	__u8   Buffer[1];	/* variable length GSS security buffer */
+} __packed;
+
+/* Flags/Reserved for SMB3.1.1 */
+#define SMB2_SHAREFLAG_CLUSTER_RECONNECT	0x0001
+
+/* Currently defined SessionFlags */
+#define SMB2_SESSION_FLAG_IS_GUEST_LE		cpu_to_le16(0x0001)
+#define SMB2_SESSION_FLAG_IS_NULL_LE		cpu_to_le16(0x0002)
+#define SMB2_SESSION_FLAG_ENCRYPT_DATA_LE	cpu_to_le16(0x0004)
+struct smb2_sess_setup_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 9 */
+	__le16 SessionFlags;
+	__le16 SecurityBufferOffset;
+	__le16 SecurityBufferLength;
+	__u8   Buffer[1];	/* variable length GSS security buffer */
+} __packed;
+
+struct smb2_logoff_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+struct smb2_logoff_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+struct smb2_tree_connect_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 9 */
+	__le16 Reserved;	/* Flags in SMB3.1.1 */
+	__le16 PathOffset;
+	__le16 PathLength;
+	__u8   Buffer[1];	/* variable length */
+} __packed;
+
+struct smb2_tree_connect_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 16 */
+	__u8   ShareType;  /* see below */
+	__u8   Reserved;
+	__le32 ShareFlags; /* see below */
+	__le32 Capabilities; /* see below */
+	__le32 MaximalAccess;
+} __packed;
+
+/* Possible ShareType values */
+#define SMB2_SHARE_TYPE_DISK	0x01
+#define SMB2_SHARE_TYPE_PIPE	0x02
+#define	SMB2_SHARE_TYPE_PRINT	0x03
+
+/*
+ * Possible ShareFlags - exactly one and only one of the first 4 caching flags
+ * must be set (any of the remaining, SHI1005, flags may be set individually
+ * or in combination.
+ */
+#define SMB2_SHAREFLAG_MANUAL_CACHING			0x00000000
+#define SMB2_SHAREFLAG_AUTO_CACHING			0x00000010
+#define SMB2_SHAREFLAG_VDO_CACHING			0x00000020
+#define SMB2_SHAREFLAG_NO_CACHING			0x00000030
+#define SHI1005_FLAGS_DFS				0x00000001
+#define SHI1005_FLAGS_DFS_ROOT				0x00000002
+#define SHI1005_FLAGS_RESTRICT_EXCLUSIVE_OPENS		0x00000100
+#define SHI1005_FLAGS_FORCE_SHARED_DELETE		0x00000200
+#define SHI1005_FLAGS_ALLOW_NAMESPACE_CACHING		0x00000400
+#define SHI1005_FLAGS_ACCESS_BASED_DIRECTORY_ENUM	0x00000800
+#define SHI1005_FLAGS_FORCE_LEVELII_OPLOCK		0x00001000
+#define SHI1005_FLAGS_ENABLE_HASH			0x00002000
+
+/* Possible share capabilities */
+#define SMB2_SHARE_CAP_DFS	cpu_to_le32(0x00000008)
+
+struct smb2_tree_disconnect_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+struct smb2_tree_disconnect_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+#define ATTR_READONLY_LE	cpu_to_le32(ATTR_READONLY)
+#define ATTR_HIDDEN_LE		cpu_to_le32(ATTR_HIDDEN)
+#define ATTR_SYSTEM_LE		cpu_to_le32(ATTR_SYSTEM)
+#define ATTR_DIRECTORY_LE	cpu_to_le32(ATTR_DIRECTORY)
+#define ATTR_ARCHIVE_LE		cpu_to_le32(ATTR_ARCHIVE)
+#define ATTR_NORMAL_LE		cpu_to_le32(ATTR_NORMAL)
+#define ATTR_TEMPORARY_LE	cpu_to_le32(ATTR_TEMPORARY)
+#define ATTR_SPARSE_FILE_LE	cpu_to_le32(ATTR_SPARSE)
+#define ATTR_REPARSE_POINT_LE	cpu_to_le32(ATTR_REPARSE)
+#define ATTR_COMPRESSED_LE	cpu_to_le32(ATTR_COMPRESSED)
+#define ATTR_OFFLINE_LE		cpu_to_le32(ATTR_OFFLINE)
+#define ATTR_NOT_CONTENT_INDEXED_LE	cpu_to_le32(ATTR_NOT_CONTENT_INDEXED)
+#define ATTR_ENCRYPTED_LE	cpu_to_le32(ATTR_ENCRYPTED)
+#define ATTR_INTEGRITY_STREAML_LE	cpu_to_le32(0x00008000)
+#define ATTR_NO_SCRUB_DATA_LE	cpu_to_le32(0x00020000)
+#define ATTR_MASK_LE		cpu_to_le32(0x00007FB7)
+
+/* Oplock levels */
+#define SMB2_OPLOCK_LEVEL_NONE		0x00
+#define SMB2_OPLOCK_LEVEL_II		0x01
+#define SMB2_OPLOCK_LEVEL_EXCLUSIVE	0x08
+#define SMB2_OPLOCK_LEVEL_BATCH		0x09
+#define SMB2_OPLOCK_LEVEL_LEASE		0xFF
+/* Non-spec internal type */
+#define SMB2_OPLOCK_LEVEL_NOCHANGE	0x99
+
+/* Desired Access Flags */
+#define FILE_READ_DATA_LE		cpu_to_le32(0x00000001)
+#define FILE_LIST_DIRECTORY_LE		cpu_to_le32(0x00000001)
+#define FILE_WRITE_DATA_LE		cpu_to_le32(0x00000002)
+#define FILE_ADD_FILE_LE		cpu_to_le32(0x00000002)
+#define FILE_APPEND_DATA_LE		cpu_to_le32(0x00000004)
+#define FILE_ADD_SUBDIRECTORY_LE	cpu_to_le32(0x00000004)
+#define FILE_READ_EA_LE			cpu_to_le32(0x00000008)
+#define FILE_WRITE_EA_LE		cpu_to_le32(0x00000010)
+#define FILE_EXECUTE_LE			cpu_to_le32(0x00000020)
+#define FILE_TRAVERSE_LE		cpu_to_le32(0x00000020)
+#define FILE_DELETE_CHILD_LE		cpu_to_le32(0x00000040)
+#define FILE_READ_ATTRIBUTES_LE		cpu_to_le32(0x00000080)
+#define FILE_WRITE_ATTRIBUTES_LE	cpu_to_le32(0x00000100)
+#define FILE_DELETE_LE			cpu_to_le32(0x00010000)
+#define FILE_READ_CONTROL_LE		cpu_to_le32(0x00020000)
+#define FILE_WRITE_DAC_LE		cpu_to_le32(0x00040000)
+#define FILE_WRITE_OWNER_LE		cpu_to_le32(0x00080000)
+#define FILE_SYNCHRONIZE_LE		cpu_to_le32(0x00100000)
+#define FILE_ACCESS_SYSTEM_SECURITY_LE	cpu_to_le32(0x01000000)
+#define FILE_MAXIMAL_ACCESS_LE		cpu_to_le32(0x02000000)
+#define FILE_GENERIC_ALL_LE		cpu_to_le32(0x10000000)
+#define FILE_GENERIC_EXECUTE_LE		cpu_to_le32(0x20000000)
+#define FILE_GENERIC_WRITE_LE		cpu_to_le32(0x40000000)
+#define FILE_GENERIC_READ_LE		cpu_to_le32(0x80000000)
+#define DESIRED_ACCESS_MASK		cpu_to_le32(0xF21F01FF)
+
+/* ShareAccess Flags */
+#define FILE_SHARE_READ_LE		cpu_to_le32(0x00000001)
+#define FILE_SHARE_WRITE_LE		cpu_to_le32(0x00000002)
+#define FILE_SHARE_DELETE_LE		cpu_to_le32(0x00000004)
+#define FILE_SHARE_ALL_LE		cpu_to_le32(0x00000007)
+
+/* CreateDisposition Flags */
+#define FILE_SUPERSEDE_LE		cpu_to_le32(0x00000000)
+#define FILE_OPEN_LE			cpu_to_le32(0x00000001)
+#define FILE_CREATE_LE			cpu_to_le32(0x00000002)
+#define	FILE_OPEN_IF_LE			cpu_to_le32(0x00000003)
+#define FILE_OVERWRITE_LE		cpu_to_le32(0x00000004)
+#define FILE_OVERWRITE_IF_LE		cpu_to_le32(0x00000005)
+#define FILE_CREATE_MASK_LE		cpu_to_le32(0x00000007)
+
+#define FILE_READ_DESIRED_ACCESS_LE	(FILE_READ_DATA_LE |		\
+					FILE_READ_EA_LE |		\
+					FILE_GENERIC_READ_LE)
+#define FILE_WRITE_DESIRE_ACCESS_LE	(FILE_WRITE_DATA_LE |		\
+					FILE_APPEND_DATA_LE |		\
+					FILE_WRITE_EA_LE |		\
+					FILE_WRITE_ATTRIBUTES_LE |	\
+					FILE_GENERIC_WRITE_LE)
+
+/* Impersonation Levels */
+#define IL_ANONYMOUS_LE		cpu_to_le32(0x00000000)
+#define IL_IDENTIFICATION_LE	cpu_to_le32(0x00000001)
+#define IL_IMPERSONATION_LE	cpu_to_le32(0x00000002)
+#define IL_DELEGATE_LE		cpu_to_le32(0x00000003)
+
+/* Create Context Values */
+#define SMB2_CREATE_EA_BUFFER			"ExtA" /* extended attributes */
+#define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
+#define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
+#define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
+#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
+#define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
+#define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
+#define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"
+#define SMB2_CREATE_REQUEST_LEASE		"RqLs"
+#define SMB2_CREATE_DURABLE_HANDLE_REQUEST_V2   "DH2Q"
+#define SMB2_CREATE_DURABLE_HANDLE_RECONNECT_V2 "DH2C"
+#define SMB2_CREATE_APP_INSTANCE_ID     "\x45\xBC\xA6\x6A\xEF\xA7\xF7\x4A\x90\x08\xFA\x46\x2E\x14\x4D\x74"
+ #define SMB2_CREATE_APP_INSTANCE_VERSION	"\xB9\x82\xD0\xB7\x3B\x56\x07\x4F\xA0\x7B\x52\x4A\x81\x16\xA0\x10"
+#define SVHDX_OPEN_DEVICE_CONTEXT       0x83CE6F1AD851E0986E34401CC9BCFCE9
+#define SMB2_CREATE_TAG_POSIX		"\x93\xAD\x25\x50\x9C\xB4\x11\xE7\xB4\x23\x83\xDE\x96\x8B\xCD\x7C"
+
+struct smb2_create_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 57 */
+	__u8   SecurityFlags;
+	__u8   RequestedOplockLevel;
+	__le32 ImpersonationLevel;
+	__le64 SmbCreateFlags;
+	__le64 Reserved;
+	__le32 DesiredAccess;
+	__le32 FileAttributes;
+	__le32 ShareAccess;
+	__le32 CreateDisposition;
+	__le32 CreateOptions;
+	__le16 NameOffset;
+	__le16 NameLength;
+	__le32 CreateContextsOffset;
+	__le32 CreateContextsLength;
+	__u8   Buffer[0];
+} __packed;
+
+struct smb2_create_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 89 */
+	__u8   OplockLevel;
+	__u8   Reserved;
+	__le32 CreateAction;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 AllocationSize;
+	__le64 EndofFile;
+	__le32 FileAttributes;
+	__le32 Reserved2;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 CreateContextsOffset;
+	__le32 CreateContextsLength;
+	__u8   Buffer[1];
+} __packed;
+
+struct create_context {
+	__le32 Next;
+	__le16 NameOffset;
+	__le16 NameLength;
+	__le16 Reserved;
+	__le16 DataOffset;
+	__le32 DataLength;
+	__u8 Buffer[0];
+} __packed;
+
+struct create_durable_req_v2 {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le32 Timeout;
+	__le32 Flags;
+	__u8 Reserved[8];
+	__u8 CreateGuid[16];
+} __packed;
+
+struct create_durable_reconn_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	union {
+		__u8  Reserved[16];
+		struct {
+			__le64 PersistentFileId;
+			__le64 VolatileFileId;
+		} Fid;
+	} Data;
+} __packed;
+
+struct create_durable_reconn_v2_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct {
+		__le64 PersistentFileId;
+		__le64 VolatileFileId;
+	} Fid;
+	__u8 CreateGuid[16];
+	__le32 Flags;
+} __packed;
+
+struct create_app_inst_id {
+	struct create_context ccontext;
+	__u8 Name[8];
+	__u8 Reserved[8];
+	__u8 AppInstanceId[16];
+} __packed;
+
+struct create_app_inst_id_vers {
+	struct create_context ccontext;
+	__u8 Name[8];
+	__u8 Reserved[2];
+	__u8 Padding[4];
+	__le64 AppInstanceVersionHigh;
+	__le64 AppInstanceVersionLow;
+} __packed;
+
+struct create_mxac_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le64 Timestamp;
+} __packed;
+
+struct create_alloc_size_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le64 AllocationSize;
+} __packed;
+
+struct create_posix {
+	struct create_context ccontext;
+	__u8    Name[16];
+	__le32  Mode;
+	__u32   Reserved;
+} __packed;
+
+struct create_durable_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	union {
+		__u8  Reserved[8];
+		__u64 data;
+	} Data;
+} __packed;
+
+struct create_durable_v2_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le32 Timeout;
+	__le32 Flags;
+} __packed;
+
+struct create_mxac_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le32 QueryStatus;
+	__le32 MaximalAccess;
+} __packed;
+
+struct create_disk_id_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le64 DiskFileId;
+	__le64 VolumeId;
+	__u8  Reserved[16];
+} __packed;
+
+/* equivalent of the contents of SMB3.1.1 POSIX open context response */
+struct create_posix_rsp {
+	struct create_context ccontext;
+	__u8    Name[16];
+	__le32 nlink;
+	__le32 reparse_tag;
+	__le32 mode;
+	u8 SidBuffer[40];
+} __packed;
+
+#define SMB2_LEASE_NONE_LE			cpu_to_le32(0x00)
+#define SMB2_LEASE_READ_CACHING_LE		cpu_to_le32(0x01)
+#define SMB2_LEASE_HANDLE_CACHING_LE		cpu_to_le32(0x02)
+#define SMB2_LEASE_WRITE_CACHING_LE		cpu_to_le32(0x04)
+
+#define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE	cpu_to_le32(0x02)
+
+struct lease_context {
+	__le64 LeaseKeyLow;
+	__le64 LeaseKeyHigh;
+	__le32 LeaseState;
+	__le32 LeaseFlags;
+	__le64 LeaseDuration;
+} __packed;
+
+struct lease_context_v2 {
+	__le64 LeaseKeyLow;
+	__le64 LeaseKeyHigh;
+	__le32 LeaseState;
+	__le32 LeaseFlags;
+	__le64 LeaseDuration;
+	__le64 ParentLeaseKeyLow;
+	__le64 ParentLeaseKeyHigh;
+	__le16 Epoch;
+	__le16 Reserved;
+} __packed;
+
+struct create_lease {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct lease_context lcontext;
+} __packed;
+
+struct create_lease_v2 {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct lease_context_v2 lcontext;
+	__u8   Pad[4];
+} __packed;
+
+/* Currently defined values for close flags */
+#define SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB	cpu_to_le16(0x0001)
+struct smb2_close_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 24 */
+	__le16 Flags;
+	__le32 Reserved;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+} __packed;
+
+struct smb2_close_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* 60 */
+	__le16 Flags;
+	__le32 Reserved;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 AllocationSize;	/* Beginning of FILE_STANDARD_INFO equivalent */
+	__le64 EndOfFile;
+	__le32 Attributes;
+} __packed;
+
+struct smb2_flush_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 24 */
+	__le16 Reserved1;
+	__le32 Reserved2;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+} __packed;
+
+struct smb2_flush_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;
+	__le16 Reserved;
+} __packed;
+
+struct smb2_buffer_desc_v1 {
+	__le64 offset;
+	__le32 token;
+	__le32 length;
+} __packed;
+
+#define SMB2_CHANNEL_NONE		cpu_to_le32(0x00000000)
+#define SMB2_CHANNEL_RDMA_V1		cpu_to_le32(0x00000001)
+#define SMB2_CHANNEL_RDMA_V1_INVALIDATE cpu_to_le32(0x00000002)
+
+struct smb2_read_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 49 */
+	__u8   Padding; /* offset from start of SMB2 header to place read */
+	__u8   Reserved;
+	__le32 Length;
+	__le64 Offset;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 MinimumCount;
+	__le32 Channel; /* Reserved MBZ */
+	__le32 RemainingBytes;
+	__le16 ReadChannelInfoOffset; /* Reserved MBZ */
+	__le16 ReadChannelInfoLength; /* Reserved MBZ */
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_read_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 17 */
+	__u8   DataOffset;
+	__u8   Reserved;
+	__le32 DataLength;
+	__le32 DataRemaining;
+	__u32  Reserved2;
+	__u8   Buffer[1];
+} __packed;
+
+/* For write request Flags field below the following flag is defined: */
+#define SMB2_WRITEFLAG_WRITE_THROUGH 0x00000001
+
+struct smb2_write_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 49 */
+	__le16 DataOffset; /* offset from start of SMB2 header to write data */
+	__le32 Length;
+	__le64 Offset;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 Channel; /* Reserved MBZ */
+	__le32 RemainingBytes;
+	__le16 WriteChannelInfoOffset; /* Reserved MBZ */
+	__le16 WriteChannelInfoLength; /* Reserved MBZ */
+	__le32 Flags;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_write_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 17 */
+	__u8   DataOffset;
+	__u8   Reserved;
+	__le32 DataLength;
+	__le32 DataRemaining;
+	__u32  Reserved2;
+	__u8   Buffer[1];
+} __packed;
+
+#define SMB2_0_IOCTL_IS_FSCTL 0x00000001
+
+struct duplicate_extents_to_file {
+	__u64 PersistentFileHandle; /* source file handle, opaque endianness */
+	__u64 VolatileFileHandle;
+	__le64 SourceFileOffset;
+	__le64 TargetFileOffset;
+	__le64 ByteCount;  /* Bytes to be copied */
+} __packed;
+
+struct smb2_ioctl_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 57 */
+	__le16 Reserved; /* offset from start of SMB2 header to write data */
+	__le32 CntCode;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 InputOffset; /* Reserved MBZ */
+	__le32 InputCount;
+	__le32 MaxInputResponse;
+	__le32 OutputOffset;
+	__le32 OutputCount;
+	__le32 MaxOutputResponse;
+	__le32 Flags;
+	__le32 Reserved2;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_ioctl_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 49 */
+	__le16 Reserved; /* offset from start of SMB2 header to write data */
+	__le32 CntCode;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 InputOffset; /* Reserved MBZ */
+	__le32 InputCount;
+	__le32 OutputOffset;
+	__le32 OutputCount;
+	__le32 Flags;
+	__le32 Reserved2;
+	__u8   Buffer[1];
+} __packed;
+
+struct validate_negotiate_info_req {
+	__le32 Capabilities;
+	__u8   Guid[SMB2_CLIENT_GUID_SIZE];
+	__le16 SecurityMode;
+	__le16 DialectCount;
+	__le16 Dialects[1]; /* dialect (someday maybe list) client asked for */
+} __packed;
+
+struct validate_negotiate_info_rsp {
+	__le32 Capabilities;
+	__u8   Guid[SMB2_CLIENT_GUID_SIZE];
+	__le16 SecurityMode;
+	__le16 Dialect; /* Dialect in use for the connection */
+} __packed;
+
+struct smb_sockaddr_in {
+	__be16 Port;
+	__be32 IPv4address;
+	__u8 Reserved[8];
+} __packed;
+
+struct smb_sockaddr_in6 {
+	__be16 Port;
+	__be32 FlowInfo;
+	__u8 IPv6address[16];
+	__be32 ScopeId;
+} __packed;
+
+#define INTERNETWORK	0x0002
+#define INTERNETWORKV6	0x0017
+
+struct sockaddr_storage_rsp {
+	__le16 Family;
+	union {
+		struct smb_sockaddr_in addr4;
+		struct smb_sockaddr_in6 addr6;
+	};
+} __packed;
+
+#define RSS_CAPABLE	0x00000001
+#define RDMA_CAPABLE	0x00000002
+
+struct network_interface_info_ioctl_rsp {
+	__le32 Next; /* next interface. zero if this is last one */
+	__le32 IfIndex;
+	__le32 Capability; /* RSS or RDMA Capable */
+	__le32 Reserved;
+	__le64 LinkSpeed;
+	char	SockAddr_Storage[128];
+} __packed;
+
+struct file_object_buf_type1_ioctl_rsp {
+	__u8 ObjectId[16];
+	__u8 BirthVolumeId[16];
+	__u8 BirthObjectId[16];
+	__u8 DomainId[16];
+} __packed;
+
+struct resume_key_ioctl_rsp {
+	__le64 ResumeKey[3];
+	__le32 ContextLength;
+	__u8 Context[4]; /* ignored, Windows sets to 4 bytes of zero */
+} __packed;
+
+struct copychunk_ioctl_req {
+	__le64 ResumeKey[3];
+	__le32 ChunkCount;
+	__le32 Reserved;
+	__u8 Chunks[1]; /* array of srv_copychunk */
+} __packed;
+
+struct srv_copychunk {
+	__le64 SourceOffset;
+	__le64 TargetOffset;
+	__le32 Length;
+	__le32 Reserved;
+} __packed;
+
+struct copychunk_ioctl_rsp {
+	__le32 ChunksWritten;
+	__le32 ChunkBytesWritten;
+	__le32 TotalBytesWritten;
+} __packed;
+
+struct file_sparse {
+	__u8	SetSparse;
+} __packed;
+
+struct file_zero_data_information {
+	__le64	FileOffset;
+	__le64	BeyondFinalZero;
+} __packed;
+
+struct file_allocated_range_buffer {
+	__le64	file_offset;
+	__le64	length;
+} __packed;
+
+struct reparse_data_buffer {
+	__le32	ReparseTag;
+	__le16	ReparseDataLength;
+	__u16	Reserved;
+	__u8	DataBuffer[]; /* Variable Length */
+} __packed;
+
+/* Completion Filter flags for Notify */
+#define FILE_NOTIFY_CHANGE_FILE_NAME	0x00000001
+#define FILE_NOTIFY_CHANGE_DIR_NAME	0x00000002
+#define FILE_NOTIFY_CHANGE_NAME		0x00000003
+#define FILE_NOTIFY_CHANGE_ATTRIBUTES	0x00000004
+#define FILE_NOTIFY_CHANGE_SIZE		0x00000008
+#define FILE_NOTIFY_CHANGE_LAST_WRITE	0x00000010
+#define FILE_NOTIFY_CHANGE_LAST_ACCESS	0x00000020
+#define FILE_NOTIFY_CHANGE_CREATION	0x00000040
+#define FILE_NOTIFY_CHANGE_EA		0x00000080
+#define FILE_NOTIFY_CHANGE_SECURITY	0x00000100
+#define FILE_NOTIFY_CHANGE_STREAM_NAME	0x00000200
+#define FILE_NOTIFY_CHANGE_STREAM_SIZE	0x00000400
+#define FILE_NOTIFY_CHANGE_STREAM_WRITE	0x00000800
+
+/* Flags */
+#define SMB2_WATCH_TREE	0x0001
+
+struct smb2_notify_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 32 */
+	__le16 Flags;
+	__le32 OutputBufferLength;
+	__le64 PersistentFileId;
+	__le64 VolatileFileId;
+	__u32 CompletionFileter;
+	__u32 Reserved;
+} __packed;
+
+struct smb2_notify_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 9 */
+	__le16 OutputBufferOffset;
+	__le32 OutputBufferLength;
+	__u8 Buffer[1];
+} __packed;
+
+/* SMB2 Notify Action Flags */
+#define FILE_ACTION_ADDED		0x00000001
+#define FILE_ACTION_REMOVED		0x00000002
+#define FILE_ACTION_MODIFIED		0x00000003
+#define FILE_ACTION_RENAMED_OLD_NAME	0x00000004
+#define FILE_ACTION_RENAMED_NEW_NAME	0x00000005
+#define FILE_ACTION_ADDED_STREAM	0x00000006
+#define FILE_ACTION_REMOVED_STREAM	0x00000007
+#define FILE_ACTION_MODIFIED_STREAM	0x00000008
+#define FILE_ACTION_REMOVED_BY_DELETE	0x00000009
+
+#define SMB2_LOCKFLAG_SHARED		0x0001
+#define SMB2_LOCKFLAG_EXCLUSIVE		0x0002
+#define SMB2_LOCKFLAG_UNLOCK		0x0004
+#define SMB2_LOCKFLAG_FAIL_IMMEDIATELY	0x0010
+#define SMB2_LOCKFLAG_MASK		0x0007
+
+struct smb2_lock_element {
+	__le64 Offset;
+	__le64 Length;
+	__le32 Flags;
+	__le32 Reserved;
+} __packed;
+
+struct smb2_lock_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 48 */
+	__le16 LockCount;
+	__le32 Reserved;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	/* Followed by at least one */
+	struct smb2_lock_element locks[1];
+} __packed;
+
+struct smb2_lock_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+struct smb2_echo_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__u16  Reserved;
+} __packed;
+
+struct smb2_echo_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__u16  Reserved;
+} __packed;
+
+/* search (query_directory) Flags field */
+#define SMB2_RESTART_SCANS		0x01
+#define SMB2_RETURN_SINGLE_ENTRY	0x02
+#define SMB2_INDEX_SPECIFIED		0x04
+#define SMB2_REOPEN			0x10
+
+struct smb2_query_directory_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 33 */
+	__u8   FileInformationClass;
+	__u8   Flags;
+	__le32 FileIndex;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le16 FileNameOffset;
+	__le16 FileNameLength;
+	__le32 OutputBufferLength;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_query_directory_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 9 */
+	__le16 OutputBufferOffset;
+	__le32 OutputBufferLength;
+	__u8   Buffer[1];
+} __packed;
+
+/* Possible InfoType values */
+#define SMB2_O_INFO_FILE	0x01
+#define SMB2_O_INFO_FILESYSTEM	0x02
+#define SMB2_O_INFO_SECURITY	0x03
+#define SMB2_O_INFO_QUOTA	0x04
+
+/* Security info type additionalinfo flags. See MS-SMB2 (2.2.37) or MS-DTYP */
+#define OWNER_SECINFO   0x00000001
+#define GROUP_SECINFO   0x00000002
+#define DACL_SECINFO   0x00000004
+#define SACL_SECINFO   0x00000008
+#define LABEL_SECINFO   0x00000010
+#define ATTRIBUTE_SECINFO   0x00000020
+#define SCOPE_SECINFO   0x00000040
+#define BACKUP_SECINFO   0x00010000
+#define UNPROTECTED_SACL_SECINFO   0x10000000
+#define UNPROTECTED_DACL_SECINFO   0x20000000
+#define PROTECTED_SACL_SECINFO   0x40000000
+#define PROTECTED_DACL_SECINFO   0x80000000
+
+struct smb2_query_info_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 41 */
+	__u8   InfoType;
+	__u8   FileInfoClass;
+	__le32 OutputBufferLength;
+	__le16 InputBufferOffset;
+	__u16  Reserved;
+	__le32 InputBufferLength;
+	__le32 AdditionalInformation;
+	__le32 Flags;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_query_info_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 9 */
+	__le16 OutputBufferOffset;
+	__le32 OutputBufferLength;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_set_info_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 33 */
+	__u8   InfoType;
+	__u8   FileInfoClass;
+	__le32 BufferLength;
+	__le16 BufferOffset;
+	__u16  Reserved;
+	__le32 AdditionalInformation;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_set_info_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 2 */
+} __packed;
+
+/* FILE Info response size */
+#define FILE_DIRECTORY_INFORMATION_SIZE       1
+#define FILE_FULL_DIRECTORY_INFORMATION_SIZE  2
+#define FILE_BOTH_DIRECTORY_INFORMATION_SIZE  3
+#define FILE_BASIC_INFORMATION_SIZE           40
+#define FILE_STANDARD_INFORMATION_SIZE        24
+#define FILE_INTERNAL_INFORMATION_SIZE        8
+#define FILE_EA_INFORMATION_SIZE              4
+#define FILE_ACCESS_INFORMATION_SIZE          4
+#define FILE_NAME_INFORMATION_SIZE            9
+#define FILE_RENAME_INFORMATION_SIZE          10
+#define FILE_LINK_INFORMATION_SIZE            11
+#define FILE_NAMES_INFORMATION_SIZE           12
+#define FILE_DISPOSITION_INFORMATION_SIZE     13
+#define FILE_POSITION_INFORMATION_SIZE        14
+#define FILE_FULL_EA_INFORMATION_SIZE         15
+#define FILE_MODE_INFORMATION_SIZE            4
+#define FILE_ALIGNMENT_INFORMATION_SIZE       4
+#define FILE_ALL_INFORMATION_SIZE             104
+#define FILE_ALLOCATION_INFORMATION_SIZE      19
+#define FILE_END_OF_FILE_INFORMATION_SIZE     20
+#define FILE_ALTERNATE_NAME_INFORMATION_SIZE  8
+#define FILE_STREAM_INFORMATION_SIZE          32
+#define FILE_PIPE_INFORMATION_SIZE            23
+#define FILE_PIPE_LOCAL_INFORMATION_SIZE      24
+#define FILE_PIPE_REMOTE_INFORMATION_SIZE     25
+#define FILE_MAILSLOT_QUERY_INFORMATION_SIZE  26
+#define FILE_MAILSLOT_SET_INFORMATION_SIZE    27
+#define FILE_COMPRESSION_INFORMATION_SIZE     16
+#define FILE_OBJECT_ID_INFORMATION_SIZE       29
+/* Number 30 not defined in documents */
+#define FILE_MOVE_CLUSTER_INFORMATION_SIZE    31
+#define FILE_QUOTA_INFORMATION_SIZE           32
+#define FILE_REPARSE_POINT_INFORMATION_SIZE   33
+#define FILE_NETWORK_OPEN_INFORMATION_SIZE    56
+#define FILE_ATTRIBUTE_TAG_INFORMATION_SIZE   8
+
+/* FS Info response  size */
+#define FS_DEVICE_INFORMATION_SIZE     8
+#define FS_ATTRIBUTE_INFORMATION_SIZE  16
+#define FS_VOLUME_INFORMATION_SIZE     24
+#define FS_SIZE_INFORMATION_SIZE       24
+#define FS_FULL_SIZE_INFORMATION_SIZE  32
+#define FS_SECTOR_SIZE_INFORMATION_SIZE 28
+#define FS_OBJECT_ID_INFORMATION_SIZE 64
+#define FS_CONTROL_INFORMATION_SIZE 48
+#define FS_POSIX_INFORMATION_SIZE 56
+
+/* FS_ATTRIBUTE_File_System_Name */
+#define FS_TYPE_SUPPORT_SIZE   44
+struct fs_type_info {
+	char		*fs_name;
+	long		magic_number;
+} __packed;
+
+struct smb2_oplock_break {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 24 */
+	__u8   OplockLevel;
+	__u8   Reserved;
+	__le32 Reserved2;
+	__le64  PersistentFid;
+	__le64  VolatileFid;
+} __packed;
+
+#define SMB2_NOTIFY_BREAK_LEASE_FLAG_ACK_REQUIRED cpu_to_le32(0x01)
+
+struct smb2_lease_break {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 44 */
+	__le16 Epoch;
+	__le32 Flags;
+	__u8   LeaseKey[16];
+	__le32 CurrentLeaseState;
+	__le32 NewLeaseState;
+	__le32 BreakReason;
+	__le32 AccessMaskHint;
+	__le32 ShareMaskHint;
+} __packed;
+
+struct smb2_lease_ack {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 36 */
+	__le16 Reserved;
+	__le32 Flags;
+	__u8   LeaseKey[16];
+	__le32 LeaseState;
+	__le64 LeaseDuration;
+} __packed;
+
+/*
+ *	PDU infolevel structure definitions
+ *	BB consider moving to a different header
+ */
+
+/* File System Information Classes */
+#define FS_VOLUME_INFORMATION		1 /* Query */
+#define FS_LABEL_INFORMATION		2 /* Set */
+#define FS_SIZE_INFORMATION		3 /* Query */
+#define FS_DEVICE_INFORMATION		4 /* Query */
+#define FS_ATTRIBUTE_INFORMATION	5 /* Query */
+#define FS_CONTROL_INFORMATION		6 /* Query, Set */
+#define FS_FULL_SIZE_INFORMATION	7 /* Query */
+#define FS_OBJECT_ID_INFORMATION	8 /* Query, Set */
+#define FS_DRIVER_PATH_INFORMATION	9 /* Query */
+#define FS_SECTOR_SIZE_INFORMATION	11 /* SMB3 or later. Query */
+#define FS_POSIX_INFORMATION		100 /* SMB3.1.1 POSIX. Query */
+
+struct smb2_fs_full_size_info {
+	__le64 TotalAllocationUnits;
+	__le64 CallerAvailableAllocationUnits;
+	__le64 ActualAvailableAllocationUnits;
+	__le32 SectorsPerAllocationUnit;
+	__le32 BytesPerSector;
+} __packed;
+
+#define SSINFO_FLAGS_ALIGNED_DEVICE		0x00000001
+#define SSINFO_FLAGS_PARTITION_ALIGNED_ON_DEVICE 0x00000002
+#define SSINFO_FLAGS_NO_SEEK_PENALTY		0x00000004
+#define SSINFO_FLAGS_TRIM_ENABLED		0x00000008
+
+/* sector size info struct */
+struct smb3_fs_ss_info {
+	__le32 LogicalBytesPerSector;
+	__le32 PhysicalBytesPerSectorForAtomicity;
+	__le32 PhysicalBytesPerSectorForPerf;
+	__le32 FSEffPhysicalBytesPerSectorForAtomicity;
+	__le32 Flags;
+	__le32 ByteOffsetForSectorAlignment;
+	__le32 ByteOffsetForPartitionAlignment;
+} __packed;
+
+/* File System Control Information */
+struct smb2_fs_control_info {
+	__le64 FreeSpaceStartFiltering;
+	__le64 FreeSpaceThreshold;
+	__le64 FreeSpaceStopFiltering;
+	__le64 DefaultQuotaThreshold;
+	__le64 DefaultQuotaLimit;
+	__le32 FileSystemControlFlags;
+	__le32 Padding;
+} __packed;
+
+/* partial list of QUERY INFO levels */
+#define FILE_DIRECTORY_INFORMATION	1
+#define FILE_FULL_DIRECTORY_INFORMATION 2
+#define FILE_BOTH_DIRECTORY_INFORMATION 3
+#define FILE_BASIC_INFORMATION		4
+#define FILE_STANDARD_INFORMATION	5
+#define FILE_INTERNAL_INFORMATION	6
+#define FILE_EA_INFORMATION	        7
+#define FILE_ACCESS_INFORMATION		8
+#define FILE_NAME_INFORMATION		9
+#define FILE_RENAME_INFORMATION		10
+#define FILE_LINK_INFORMATION		11
+#define FILE_NAMES_INFORMATION		12
+#define FILE_DISPOSITION_INFORMATION	13
+#define FILE_POSITION_INFORMATION	14
+#define FILE_FULL_EA_INFORMATION	15
+#define FILE_MODE_INFORMATION		16
+#define FILE_ALIGNMENT_INFORMATION	17
+#define FILE_ALL_INFORMATION		18
+#define FILE_ALLOCATION_INFORMATION	19
+#define FILE_END_OF_FILE_INFORMATION	20
+#define FILE_ALTERNATE_NAME_INFORMATION 21
+#define FILE_STREAM_INFORMATION		22
+#define FILE_PIPE_INFORMATION		23
+#define FILE_PIPE_LOCAL_INFORMATION	24
+#define FILE_PIPE_REMOTE_INFORMATION	25
+#define FILE_MAILSLOT_QUERY_INFORMATION 26
+#define FILE_MAILSLOT_SET_INFORMATION	27
+#define FILE_COMPRESSION_INFORMATION	28
+#define FILE_OBJECT_ID_INFORMATION	29
+/* Number 30 not defined in documents */
+#define FILE_MOVE_CLUSTER_INFORMATION	31
+#define FILE_QUOTA_INFORMATION		32
+#define FILE_REPARSE_POINT_INFORMATION	33
+#define FILE_NETWORK_OPEN_INFORMATION	34
+#define FILE_ATTRIBUTE_TAG_INFORMATION	35
+#define FILE_TRACKING_INFORMATION	36
+#define FILEID_BOTH_DIRECTORY_INFORMATION 37
+#define FILEID_FULL_DIRECTORY_INFORMATION 38
+#define FILE_VALID_DATA_LENGTH_INFORMATION 39
+#define FILE_SHORT_NAME_INFORMATION	40
+#define FILE_SFIO_RESERVE_INFORMATION	44
+#define FILE_SFIO_VOLUME_INFORMATION	45
+#define FILE_HARD_LINK_INFORMATION	46
+#define FILE_NORMALIZED_NAME_INFORMATION 48
+#define FILEID_GLOBAL_TX_DIRECTORY_INFORMATION 50
+#define FILE_STANDARD_LINK_INFORMATION	54
+
+#define OP_BREAK_STRUCT_SIZE_20		24
+#define OP_BREAK_STRUCT_SIZE_21		36
+
+struct smb2_file_access_info {
+	__le32 AccessFlags;
+} __packed;
+
+struct smb2_file_alignment_info {
+	__le32 AlignmentRequirement;
+} __packed;
+
+struct smb2_file_internal_info {
+	__le64 IndexNumber;
+} __packed; /* level 6 Query */
+
+struct smb2_file_rename_info { /* encoding of request for level 10 */
+	__u8   ReplaceIfExists; /* 1 = replace existing target with new */
+				/* 0 = fail if target already exists */
+	__u8   Reserved[7];
+	__u64  RootDirectory;  /* MBZ for network operations (why says spec?) */
+	__le32 FileNameLength;
+	char   FileName[0];     /* New name to be assigned */
+} __packed; /* level 10 Set */
+
+struct smb2_file_link_info { /* encoding of request for level 11 */
+	__u8   ReplaceIfExists; /* 1 = replace existing link with new */
+				/* 0 = fail if link already exists */
+	__u8   Reserved[7];
+	__u64  RootDirectory;  /* MBZ for network operations (why says spec?) */
+	__le32 FileNameLength;
+	char   FileName[0];     /* Name to be assigned to new link */
+} __packed; /* level 11 Set */
+
+/*
+ * This level 18, although with struct with same name is different from cifs
+ * level 0x107. Level 0x107 has an extra u64 between AccessFlags and
+ * CurrentByteOffset.
+ */
+struct smb2_file_all_info { /* data block encoding of response to level 18 */
+	__le64 CreationTime;	/* Beginning of FILE_BASIC_INFO equivalent */
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le32 Attributes;
+	__u32  Pad1;		/* End of FILE_BASIC_INFO_INFO equivalent */
+	__le64 AllocationSize;	/* Beginning of FILE_STANDARD_INFO equivalent */
+	__le64 EndOfFile;	/* size ie offset to first free byte in file */
+	__le32 NumberOfLinks;	/* hard links */
+	__u8   DeletePending;
+	__u8   Directory;
+	__u16  Pad2;		/* End of FILE_STANDARD_INFO equivalent */
+	__le64 IndexNumber;
+	__le32 EASize;
+	__le32 AccessFlags;
+	__le64 CurrentByteOffset;
+	__le32 Mode;
+	__le32 AlignmentRequirement;
+	__le32 FileNameLength;
+	char   FileName[1];
+} __packed; /* level 18 Query */
+
+struct smb2_file_alt_name_info {
+	__le32 FileNameLength;
+	char FileName[0];
+} __packed;
+
+struct smb2_file_stream_info {
+	__le32  NextEntryOffset;
+	__le32  StreamNameLength;
+	__le64 StreamSize;
+	__le64 StreamAllocationSize;
+	char   StreamName[0];
+} __packed;
+
+struct smb2_file_eof_info { /* encoding of request for level 10 */
+	__le64 EndOfFile; /* new end of file value */
+} __packed; /* level 20 Set */
+
+struct smb2_file_ntwrk_info {
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 AllocationSize;
+	__le64 EndOfFile;
+	__le32 Attributes;
+	__le32 Reserved;
+} __packed;
+
+struct smb2_file_standard_info {
+	__le64 AllocationSize;
+	__le64 EndOfFile;
+	__le32 NumberOfLinks;	/* hard links */
+	__u8   DeletePending;
+	__u8   Directory;
+	__le16 Reserved;
+} __packed; /* level 18 Query */
+
+struct smb2_file_ea_info {
+	__le32 EASize;
+} __packed;
+
+struct smb2_file_alloc_info {
+	__le64 AllocationSize;
+} __packed;
+
+struct smb2_file_disposition_info {
+	__u8 DeletePending;
+} __packed;
+
+struct smb2_file_pos_info {
+	__le64 CurrentByteOffset;
+} __packed;
+
+#define FILE_MODE_INFO_MASK cpu_to_le32(0x0000103e)
+
+struct smb2_file_mode_info {
+	__le32 Mode;
+} __packed;
+
+#define COMPRESSION_FORMAT_NONE 0x0000
+#define COMPRESSION_FORMAT_LZNT1 0x0002
+
+struct smb2_file_comp_info {
+	__le64 CompressedFileSize;
+	__le16 CompressionFormat;
+	__u8 CompressionUnitShift;
+	__u8 ChunkShift;
+	__u8 ClusterShift;
+	__u8 Reserved[3];
+} __packed;
+
+struct smb2_file_attr_tag_info {
+	__le32 FileAttributes;
+	__le32 ReparseTag;
+} __packed;
+
+#define SL_RESTART_SCAN	0x00000001
+#define SL_RETURN_SINGLE_ENTRY	0x00000002
+#define SL_INDEX_SPECIFIED	0x00000004
+
+struct smb2_ea_info_req {
+	__le32 NextEntryOffset;
+	__u8   EaNameLength;
+	char name[1];
+} __packed; /* level 15 Query */
+
+struct smb2_ea_info {
+	__le32 NextEntryOffset;
+	__u8   Flags;
+	__u8   EaNameLength;
+	__le16 EaValueLength;
+	char name[1];
+	/* optionally followed by value */
+} __packed; /* level 15 Query */
+
+struct create_ea_buf_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct smb2_ea_info ea;
+} __packed;
+
+struct create_sd_buf_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct smb_ntsd ntsd;
+} __packed;
+
+/* Find File infolevels */
+#define SMB_FIND_FILE_POSIX_INFO	0x064
+
+/* Level 100 query info */
+struct smb311_posix_qinfo {
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 DosAttributes;
+	__le64 Inode;
+	__le32 DeviceId;
+	__le32 Zero;
+	/* beginning of POSIX Create Context Response */
+	__le32 HardLinks;
+	__le32 ReparseTag;
+	__le32 Mode;
+	u8     Sids[];
+	/*
+	 * var sized owner SID
+	 * var sized group SID
+	 * le32 filenamelength
+	 * u8  filename[]
+	 */
+} __packed;
+
+struct smb2_posix_info {
+	__le32 NextEntryOffset;
+	__u32 Ignored;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 DosAttributes;
+	__le64 Inode;
+	__le32 DeviceId;
+	__le32 Zero;
+	/* beginning of POSIX Create Context Response */
+	__le32 HardLinks;
+	__le32 ReparseTag;
+	__le32 Mode;
+	u8 SidBuffer[40];
+	__le32 name_len;
+	u8 name[1];
+	/*
+	 * var sized owner SID
+	 * var sized group SID
+	 * le32 filenamelength
+	 * u8  filename[]
+	 */
+} __packed;
+
+/* functions */
+int init_smb2_0_server(struct ksmbd_conn *conn);
+void init_smb2_1_server(struct ksmbd_conn *conn);
+void init_smb3_0_server(struct ksmbd_conn *conn);
+void init_smb3_02_server(struct ksmbd_conn *conn);
+int init_smb3_11_server(struct ksmbd_conn *conn);
+
+void init_smb2_max_read_size(unsigned int sz);
+void init_smb2_max_write_size(unsigned int sz);
+void init_smb2_max_trans_size(unsigned int sz);
+
+int is_smb2_neg_cmd(struct ksmbd_work *work);
+int is_smb2_rsp(struct ksmbd_work *work);
+
+u16 get_smb2_cmd_val(struct ksmbd_work *work);
+void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err);
+int init_smb2_rsp_hdr(struct ksmbd_work *work);
+int smb2_allocate_rsp_buf(struct ksmbd_work *work);
+bool is_chained_smb2_message(struct ksmbd_work *work);
+int init_smb2_neg_rsp(struct ksmbd_work *work);
+void smb2_set_err_rsp(struct ksmbd_work *work);
+int smb2_check_user_session(struct ksmbd_work *work);
+int smb2_get_ksmbd_tcon(struct ksmbd_work *work);
+bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command);
+int smb2_check_sign_req(struct ksmbd_work *work);
+void smb2_set_sign_rsp(struct ksmbd_work *work);
+int smb3_check_sign_req(struct ksmbd_work *work);
+void smb3_set_sign_rsp(struct ksmbd_work *work);
+int find_matching_smb2_dialect(int start_index, __le16 *cli_dialects,
+			       __le16 dialects_count);
+struct file_lock *smb_flock_init(struct file *f);
+int setup_async_work(struct ksmbd_work *work, void (*fn)(void **),
+		     void **arg);
+void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status);
+struct channel *lookup_chann_list(struct ksmbd_session *sess,
+				  struct ksmbd_conn *conn);
+void smb3_preauth_hash_rsp(struct ksmbd_work *work);
+int smb3_is_transform_hdr(void *buf);
+int smb3_decrypt_req(struct ksmbd_work *work);
+int smb3_encrypt_resp(struct ksmbd_work *work);
+bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work);
+int smb2_set_rsp_credits(struct ksmbd_work *work);
+
+/* smb2 misc functions */
+int ksmbd_smb2_check_message(struct ksmbd_work *work);
+
+/* smb2 command handlers */
+int smb2_handle_negotiate(struct ksmbd_work *work);
+int smb2_negotiate_request(struct ksmbd_work *work);
+int smb2_sess_setup(struct ksmbd_work *work);
+int smb2_tree_connect(struct ksmbd_work *work);
+int smb2_tree_disconnect(struct ksmbd_work *work);
+int smb2_session_logoff(struct ksmbd_work *work);
+int smb2_open(struct ksmbd_work *work);
+int smb2_query_info(struct ksmbd_work *work);
+int smb2_query_dir(struct ksmbd_work *work);
+int smb2_close(struct ksmbd_work *work);
+int smb2_echo(struct ksmbd_work *work);
+int smb2_set_info(struct ksmbd_work *work);
+int smb2_read(struct ksmbd_work *work);
+int smb2_write(struct ksmbd_work *work);
+int smb2_flush(struct ksmbd_work *work);
+int smb2_cancel(struct ksmbd_work *work);
+int smb2_lock(struct ksmbd_work *work);
+int smb2_ioctl(struct ksmbd_work *work);
+int smb2_oplock_break(struct ksmbd_work *work);
+int smb2_notify(struct ksmbd_work *ksmbd_work);
+
+#endif	/* _SMB2PDU_H */
-- 
2.17.1

