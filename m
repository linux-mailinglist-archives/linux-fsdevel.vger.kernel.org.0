Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42B736764E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbhDVAjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:39:18 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40661 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343942AbhDVAjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:39:15 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210422003840epoutp010840f4f6e4a7cdb1d5dec41c8c0262d8~4BySoxhVW1755917559epoutp01w
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 00:38:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210422003840epoutp010840f4f6e4a7cdb1d5dec41c8c0262d8~4BySoxhVW1755917559epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619051920;
        bh=39y3sHoIPozwDl8Srgvp46Kwrr4stsRaGWnynwPKmNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOk1T6awdD5iFIw7duFVuy1X2mESSmbuWJvVomQOheNKVGEkJyGg2X7/5be94ui6X
         7GBSKjZYO+zyEu5+KlBICiUI36hzzhLhOUPS69FRE7s36kLEa9Bw4vU9czCcl72+EC
         m8XxDvhtmpVPPn91bhEgQTZPjUQrNjDDEVvh/8t8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210422003839epcas1p42d7e54410569fe27ea2f9ef76d9a46f2~4ByR-qto_1344213442epcas1p4O;
        Thu, 22 Apr 2021 00:38:39 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FQdnp0c1rz4x9QD; Thu, 22 Apr
        2021 00:38:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.4E.09736.D85C0806; Thu, 22 Apr 2021 09:38:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210422003837epcas1p48d3a9bc060df8e8dca3fab76201000fc~4ByQU5G_z1344213442epcas1p4G;
        Thu, 22 Apr 2021 00:38:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210422003837epsmtrp150911d51c085030044557d1107a0a145~4ByQT3IGT2325623256epsmtrp1r;
        Thu, 22 Apr 2021 00:38:37 +0000 (GMT)
X-AuditID: b6c32a39-ea97ca8000002608-1f-6080c58d66a9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.E9.08163.D85C0806; Thu, 22 Apr 2021 09:38:37 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210422003837epsmtip139ad6c7a25163dfd6761f4bd429428e4~4ByQEX5h91951419514epsmtip1B;
        Thu, 22 Apr 2021 00:38:37 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 02/10] cifsd: add server handler
Date:   Thu, 22 Apr 2021 09:28:16 +0900
Message-Id: <20210422002824.12677-3-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422002824.12677-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmnm7v0YYEgwM91haNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e32LP3JIvF5V1z2Cx+TK+3eHsHqKK37xOrResV
        LYvdGxexWaz9/Jjd4s2Lw2wWtybOZ7M4//c4q8XvH3PYHIQ9ZjX0snnMbrjI4rFz1l12j80r
        tDx232xg82jd8Zfd4+PTWywefVtWMXpsWfyQyWP9lqssHp83yXlsevKWKYAnKscmIzUxJbVI
        ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hFJYWyxJxSoFBAYnGx
        kr6dTVF+aUmqQkZ+cYmtUmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTkbD9YnsBR+6
        mCqmHF7O2MDYcYuxi5GTQ0LARKLn/g8gm4tDSGAHo0RPyxYWCOcTo8T0+d3sEM5nRonulnds
        MC33H95hBbGFBHYxSsx9Kg3X0blwE1ARBwebgLbEny2iIKaIgL3E7cU+ICXMAoeYJb5e6QNb
        LSxgLHF45nQmEJtFQFXi+cztzCA2r4CNRMvzbcwQu+QlVm84AGZzCthK/NqwEursCxwSs4/z
        QdguEl9+7oO6TVji1fEt7BC2lMTL/jZ2kBskBKolPu6HGtnBKPHiuy2EbSxxc/0GVpASZgFN
        ifW79CHCihI7f88F28QswCfx7msPK8QUXomONiGIElWJvkuHmSBsaYmu9g9Qizwk2i+qQ8Jj
        AqPEtZkH2CYwys1CWLCAkXEVo1hqQXFuemqxYYEpcnxtYgSnYC3LHYzT337QO8TIxMF4iFGC
        g1lJhHdtcUOCEG9KYmVValF+fFFpTmrxIUZTYMhNZJYSTc4HZoG8knhDUyNjY2MLEzNzM1Nj
        JXHedOfqBCGB9MSS1OzU1ILUIpg+Jg5OqQYms/LZ8neUoyxe2/4x+l5QePMZo8LfLW2K1jF5
        capWqwM0NFItL+RcC1AL3/buz0yTnbc+nJF4zOHTPjfyc/qZENPCrhdT9baUBomWZeb8qjFR
        ///tRtC6t7+8Zy/mWxl1K/2NeSnL6+JNfV15s7cyKMU2fZrzfEfPWq/ewtTjhbclZj9zCNh6
        LGK7g7ZecFHfpPpnBknTHjH9lLsgWSliHXhCYuNtntQrJ6RfseyrV77CUhOQtPFxwK6kmMUH
        jTqmO+m+5i+cweT3yOT0aSvG83ouv42kw97MkeBdt3/Nto+zZwUkL2kV8XZdHvbmmUvZxF9v
        fx3cK8KyynDT3Sd3fWMX7/BKWS/IZHszxu2tEktxRqKhFnNRcSIAYJAKIUoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnG7v0YYEg7W3ZC0a355msTj++i+7
        xe/VvWwWr/9NZ7E4PWERk8XK1UeZLK7df89usWfvSRaLy7vmsFn8mF5v8fYOUEVv3ydWi9Yr
        Wha7Ny5is1j7+TG7xZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7zGroZfOY3XCRxWPnrLvsHptX
        aHnsvtnA5tG64y+7x8ent1g8+rasYvTYsvghk8f6LVdZPD5vkvPY9OQtUwBPFJdNSmpOZllq
        kb5dAldGw/WJ7AUfupgqphxeztjA2HGLsYuRk0NCwETi/sM7rF2MXBxCAjsYJda+eckMkZCW
        OHbiDJDNAWQLSxw+XAxR84FR4sacR2BxNgFtiT9bREHKRQQcJU5MXcQIUsMscI1Z4tv2CWAL
        hAWMJQ7PnM4EYrMIqEo8n7kdbD6vgI1Ey/NtULvkJVZvOABmcwrYSvzasBKsVwiopmn6VZYJ
        jHwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER4yW1g7GPas+6B1iZOJgPMQo
        wcGsJMK7trghQYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5O
        qQYmjq+bU1+vDm6T2bB2HTtfVKmS5zStN1m15RF8dx5cdnT8P//+ZMnKN+qblz8NtsucsTt2
        FYNjaUf+3E8LrzuzShfpR57NP7rVMblRc5WJYQzbY8/cGToN1qZBJ6f8LU62Fr6u8YnhoMp7
        xrf6noLz/liaPjWxDPh+wbR4+Yol31/zNfW5F3VuqlfarLRA7J37XDmLj5zV0bMNTnWHZdV1
        /8i3UluspPYq+SKP7zSr/jtKHyx7HzQlMr8VVP8dPaVddrPEyiIB1cvK7LofL6V0b50w65bZ
        b7/kpay3z2+1y3FzSrhgrx+w+IhaoUbW5C++xhlvhUzdGeYlfLxmldUpK18wd3PVnzWn9idP
        MlJiKc5INNRiLipOBACq0jqUBwMAAA==
X-CMS-MailID: 20210422003837epcas1p48d3a9bc060df8e8dca3fab76201000fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003837epcas1p48d3a9bc060df8e8dca3fab76201000fc
References: <20210422002824.12677-1-namjae.jeon@samsung.com>
        <CGME20210422003837epcas1p48d3a9bc060df8e8dca3fab76201000fc@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds server handler for central processing.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifsd/glob.h         |  64 ++++
 fs/cifsd/ksmbd_server.h | 283 ++++++++++++++++++
 fs/cifsd/ksmbd_work.c   |  93 ++++++
 fs/cifsd/ksmbd_work.h   | 110 +++++++
 fs/cifsd/server.c       | 631 ++++++++++++++++++++++++++++++++++++++++
 fs/cifsd/server.h       |  60 ++++
 6 files changed, 1241 insertions(+)
 create mode 100644 fs/cifsd/glob.h
 create mode 100644 fs/cifsd/ksmbd_server.h
 create mode 100644 fs/cifsd/ksmbd_work.c
 create mode 100644 fs/cifsd/ksmbd_work.h
 create mode 100644 fs/cifsd/server.c
 create mode 100644 fs/cifsd/server.h

diff --git a/fs/cifsd/glob.h b/fs/cifsd/glob.h
new file mode 100644
index 000000000000..ffeaf8aa5595
--- /dev/null
+++ b/fs/cifsd/glob.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_GLOB_H
+#define __KSMBD_GLOB_H
+
+#include <linux/ctype.h>
+
+#include "unicode.h"
+#include "vfs_cache.h"
+
+#define KSMBD_VERSION	"3.1.9"
+
+/* @FIXME clean up this code */
+
+extern int ksmbd_debug_types;
+
+#define DATA_STREAM	1
+#define DIR_STREAM	2
+
+#define KSMBD_DEBUG_SMB		BIT(0)
+#define KSMBD_DEBUG_AUTH	BIT(1)
+#define KSMBD_DEBUG_VFS		BIT(2)
+#define KSMBD_DEBUG_OPLOCK      BIT(3)
+#define KSMBD_DEBUG_IPC         BIT(4)
+#define KSMBD_DEBUG_CONN        BIT(5)
+#define KSMBD_DEBUG_RDMA        BIT(6)
+#define KSMBD_DEBUG_ALL         (KSMBD_DEBUG_SMB | KSMBD_DEBUG_AUTH |	\
+				KSMBD_DEBUG_VFS | KSMBD_DEBUG_OPLOCK |	\
+				KSMBD_DEBUG_IPC | KSMBD_DEBUG_CONN |	\
+				KSMBD_DEBUG_RDMA)
+
+#ifndef ksmbd_pr_fmt
+#ifdef SUBMOD_NAME
+#define ksmbd_pr_fmt(fmt)	"ksmbd: " SUBMOD_NAME ": " fmt
+#else
+#define ksmbd_pr_fmt(fmt)	"ksmbd: " fmt
+#endif
+#endif
+
+#define ksmbd_debug(type, fmt, ...)				\
+	do {							\
+		if (ksmbd_debug_types & KSMBD_DEBUG_##type)	\
+			pr_info(ksmbd_pr_fmt("%s:%d: " fmt),	\
+				__func__,			\
+				__LINE__,			\
+				##__VA_ARGS__);			\
+	} while (0)
+
+#define ksmbd_info(fmt, ...)					\
+			pr_info(ksmbd_pr_fmt(fmt), ##__VA_ARGS__)
+
+#define ksmbd_err(fmt, ...)					\
+			pr_err(ksmbd_pr_fmt("%s:%d: " fmt),	\
+				__func__,			\
+				__LINE__,			\
+				##__VA_ARGS__)
+
+#define UNICODE_LEN(x)		((x) * 2)
+
+#endif /* __KSMBD_GLOB_H */
diff --git a/fs/cifsd/ksmbd_server.h b/fs/cifsd/ksmbd_server.h
new file mode 100644
index 000000000000..442077a1e77b
--- /dev/null
+++ b/fs/cifsd/ksmbd_server.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ *
+ *   linux-ksmbd-devel@lists.sourceforge.net
+ */
+
+#ifndef _LINUX_KSMBD_SERVER_H
+#define _LINUX_KSMBD_SERVER_H
+
+#include <linux/types.h>
+
+#define KSMBD_GENL_NAME		"SMBD_GENL"
+#define KSMBD_GENL_VERSION		0x01
+
+#ifndef ____ksmbd_align
+#define ____ksmbd_align		__aligned(4)
+#endif
+
+#define KSMBD_REQ_MAX_ACCOUNT_NAME_SZ	48
+#define KSMBD_REQ_MAX_HASH_SZ		18
+#define KSMBD_REQ_MAX_SHARE_NAME	64
+
+struct ksmbd_heartbeat {
+	__u32	handle;
+};
+
+/*
+ * Global config flags.
+ */
+#define KSMBD_GLOBAL_FLAG_INVALID		(0)
+#define KSMBD_GLOBAL_FLAG_SMB2_LEASES		BIT(0)
+#define KSMBD_GLOBAL_FLAG_CACHE_TBUF		BIT(1)
+#define KSMBD_GLOBAL_FLAG_CACHE_RBUF		BIT(2)
+#define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION	BIT(3)
+
+struct ksmbd_startup_request {
+	__u32	flags;
+	__s32	signing;
+	__s8	min_prot[16];
+	__s8	max_prot[16];
+	__s8	netbios_name[16];
+	__s8	work_group[64];
+	__s8	server_string[64];
+	__u16	tcp_port;
+	__u16	ipc_timeout;
+	__u32	deadtime;
+	__u32	file_max;
+	__u32	smb2_max_write;
+	__u32	smb2_max_read;
+	__u32	smb2_max_trans;
+	__u32	share_fake_fscaps;
+	__u32	sub_auth[3];
+	__u32	ifc_list_sz;
+	__s8	____payload[0];
+} ____ksmbd_align;
+
+#define KSMBD_STARTUP_CONFIG_INTERFACES(s)	((s)->____payload)
+
+struct ksmbd_shutdown_request {
+	__s32	reserved;
+} ____ksmbd_align;
+
+struct ksmbd_login_request {
+	__u32	handle;
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+} ____ksmbd_align;
+
+struct ksmbd_login_response {
+	__u32	handle;
+	__u32	gid;
+	__u32	uid;
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+	__u16	status;
+	__u16	hash_sz;
+	__s8	hash[KSMBD_REQ_MAX_HASH_SZ];
+} ____ksmbd_align;
+
+struct ksmbd_share_config_request {
+	__u32	handle;
+	__s8	share_name[KSMBD_REQ_MAX_SHARE_NAME];
+} ____ksmbd_align;
+
+struct ksmbd_share_config_response {
+	__u32	handle;
+	__u32	flags;
+	__u16	create_mask;
+	__u16	directory_mask;
+	__u16	force_create_mode;
+	__u16	force_directory_mode;
+	__u16	force_uid;
+	__u16	force_gid;
+	__u32	veto_list_sz;
+	__s8	____payload[0];
+} ____ksmbd_align;
+
+#define KSMBD_SHARE_CONFIG_VETO_LIST(s)	((s)->____payload)
+#define KSMBD_SHARE_CONFIG_PATH(s)				\
+	({							\
+		char *p = (s)->____payload;			\
+		if ((s)->veto_list_sz)				\
+			p += (s)->veto_list_sz + 1;		\
+		p;						\
+	 })
+
+struct ksmbd_tree_connect_request {
+	__u32	handle;
+	__u16	account_flags;
+	__u16	flags;
+	__u64	session_id;
+	__u64	connect_id;
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+	__s8	share[KSMBD_REQ_MAX_SHARE_NAME];
+	__s8	peer_addr[64];
+} ____ksmbd_align;
+
+struct ksmbd_tree_connect_response {
+	__u32	handle;
+	__u16	status;
+	__u16	connection_flags;
+} ____ksmbd_align;
+
+struct ksmbd_tree_disconnect_request {
+	__u64	session_id;
+	__u64	connect_id;
+} ____ksmbd_align;
+
+struct ksmbd_logout_request {
+	__s8	account[KSMBD_REQ_MAX_ACCOUNT_NAME_SZ];
+} ____ksmbd_align;
+
+struct ksmbd_rpc_command {
+	__u32	handle;
+	__u32	flags;
+	__u32	payload_sz;
+	__u8	payload[0];
+} ____ksmbd_align;
+
+struct ksmbd_spnego_authen_request {
+	__u32	handle;
+	__u16	spnego_blob_len;
+	__u8	spnego_blob[0];
+} ____ksmbd_align;
+
+struct ksmbd_spnego_authen_response {
+	__u32	handle;
+	struct ksmbd_login_response	login_response;
+	__u16	session_key_len;
+	__u16	spnego_blob_len;
+	__u8	payload[0];		/* session key + AP_REP */
+} ____ksmbd_align;
+
+/*
+ * This also used as NETLINK attribute type value.
+ *
+ * NOTE:
+ * Response message type value should be equal to
+ * request message type value + 1.
+ */
+enum ksmbd_event {
+	KSMBD_EVENT_UNSPEC			= 0,
+	KSMBD_EVENT_HEARTBEAT_REQUEST,
+
+	KSMBD_EVENT_STARTING_UP,
+	KSMBD_EVENT_SHUTTING_DOWN,
+
+	KSMBD_EVENT_LOGIN_REQUEST,
+	KSMBD_EVENT_LOGIN_RESPONSE		= 5,
+
+	KSMBD_EVENT_SHARE_CONFIG_REQUEST,
+	KSMBD_EVENT_SHARE_CONFIG_RESPONSE,
+
+	KSMBD_EVENT_TREE_CONNECT_REQUEST,
+	KSMBD_EVENT_TREE_CONNECT_RESPONSE,
+
+	KSMBD_EVENT_TREE_DISCONNECT_REQUEST	= 10,
+
+	KSMBD_EVENT_LOGOUT_REQUEST,
+
+	KSMBD_EVENT_RPC_REQUEST,
+	KSMBD_EVENT_RPC_RESPONSE,
+
+	KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST,
+	KSMBD_EVENT_SPNEGO_AUTHEN_RESPONSE	= 15,
+
+	KSMBD_EVENT_MAX
+};
+
+enum KSMBD_TREE_CONN_STATUS {
+	KSMBD_TREE_CONN_STATUS_OK		= 0,
+	KSMBD_TREE_CONN_STATUS_NOMEM,
+	KSMBD_TREE_CONN_STATUS_NO_SHARE,
+	KSMBD_TREE_CONN_STATUS_NO_USER,
+	KSMBD_TREE_CONN_STATUS_INVALID_USER,
+	KSMBD_TREE_CONN_STATUS_HOST_DENIED	= 5,
+	KSMBD_TREE_CONN_STATUS_CONN_EXIST,
+	KSMBD_TREE_CONN_STATUS_TOO_MANY_CONNS,
+	KSMBD_TREE_CONN_STATUS_TOO_MANY_SESSIONS,
+	KSMBD_TREE_CONN_STATUS_ERROR,
+};
+
+/*
+ * User config flags.
+ */
+#define KSMBD_USER_FLAG_INVALID		(0)
+#define KSMBD_USER_FLAG_OK		BIT(0)
+#define KSMBD_USER_FLAG_BAD_PASSWORD	BIT(1)
+#define KSMBD_USER_FLAG_BAD_UID		BIT(2)
+#define KSMBD_USER_FLAG_BAD_USER	BIT(3)
+#define KSMBD_USER_FLAG_GUEST_ACCOUNT	BIT(4)
+
+/*
+ * Share config flags.
+ */
+#define KSMBD_SHARE_FLAG_INVALID		(0)
+#define KSMBD_SHARE_FLAG_AVAILABLE		BIT(0)
+#define KSMBD_SHARE_FLAG_BROWSEABLE		BIT(1)
+#define KSMBD_SHARE_FLAG_WRITEABLE		BIT(2)
+#define KSMBD_SHARE_FLAG_READONLY		BIT(3)
+#define KSMBD_SHARE_FLAG_GUEST_OK		BIT(4)
+#define KSMBD_SHARE_FLAG_GUEST_ONLY		BIT(5)
+#define KSMBD_SHARE_FLAG_STORE_DOS_ATTRS	BIT(6)
+#define KSMBD_SHARE_FLAG_OPLOCKS		BIT(7)
+#define KSMBD_SHARE_FLAG_PIPE			BIT(8)
+#define KSMBD_SHARE_FLAG_HIDE_DOT_FILES		BIT(9)
+#define KSMBD_SHARE_FLAG_INHERIT_OWNER		BIT(10)
+#define KSMBD_SHARE_FLAG_STREAMS		BIT(11)
+#define KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS	BIT(12)
+#define KSMBD_SHARE_FLAG_ACL_XATTR		BIT(13)
+
+/*
+ * Tree connect request flags.
+ */
+#define KSMBD_TREE_CONN_FLAG_REQUEST_SMB1	(0)
+#define KSMBD_TREE_CONN_FLAG_REQUEST_IPV6	BIT(0)
+#define KSMBD_TREE_CONN_FLAG_REQUEST_SMB2	BIT(1)
+
+/*
+ * Tree connect flags.
+ */
+#define KSMBD_TREE_CONN_FLAG_GUEST_ACCOUNT	BIT(0)
+#define KSMBD_TREE_CONN_FLAG_READ_ONLY		BIT(1)
+#define KSMBD_TREE_CONN_FLAG_WRITABLE		BIT(2)
+#define KSMBD_TREE_CONN_FLAG_ADMIN_ACCOUNT	BIT(3)
+
+/*
+ * RPC over IPC.
+ */
+#define KSMBD_RPC_METHOD_RETURN		BIT(0)
+#define KSMBD_RPC_SRVSVC_METHOD_INVOKE	BIT(1)
+#define KSMBD_RPC_SRVSVC_METHOD_RETURN	(KSMBD_RPC_SRVSVC_METHOD_INVOKE | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_WKSSVC_METHOD_INVOKE	BIT(2)
+#define KSMBD_RPC_WKSSVC_METHOD_RETURN	(KSMBD_RPC_WKSSVC_METHOD_INVOKE | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_IOCTL_METHOD		(BIT(3) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_OPEN_METHOD		BIT(4)
+#define KSMBD_RPC_WRITE_METHOD		BIT(5)
+#define KSMBD_RPC_READ_METHOD		(BIT(6) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_CLOSE_METHOD		BIT(7)
+#define KSMBD_RPC_RAP_METHOD		(BIT(8) | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_RESTRICTED_CONTEXT	BIT(9)
+#define KSMBD_RPC_SAMR_METHOD_INVOKE	BIT(10)
+#define KSMBD_RPC_SAMR_METHOD_RETURN	(KSMBD_RPC_SAMR_METHOD_INVOKE | KSMBD_RPC_METHOD_RETURN)
+#define KSMBD_RPC_LSARPC_METHOD_INVOKE	BIT(11)
+#define KSMBD_RPC_LSARPC_METHOD_RETURN	(KSMBD_RPC_LSARPC_METHOD_INVOKE | KSMBD_RPC_METHOD_RETURN)
+
+#define KSMBD_RPC_OK			0
+#define KSMBD_RPC_EBAD_FUNC		0x00000001
+#define KSMBD_RPC_EACCESS_DENIED	0x00000005
+#define KSMBD_RPC_EBAD_FID		0x00000006
+#define KSMBD_RPC_ENOMEM		0x00000008
+#define KSMBD_RPC_EBAD_DATA		0x0000000D
+#define KSMBD_RPC_ENOTIMPLEMENTED	0x00000040
+#define KSMBD_RPC_EINVALID_PARAMETER	0x00000057
+#define KSMBD_RPC_EMORE_DATA		0x000000EA
+#define KSMBD_RPC_EINVALID_LEVEL	0x0000007C
+#define KSMBD_RPC_SOME_NOT_MAPPED	0x00000107
+
+#define KSMBD_CONFIG_OPT_DISABLED	0
+#define KSMBD_CONFIG_OPT_ENABLED	1
+#define KSMBD_CONFIG_OPT_AUTO		2
+#define KSMBD_CONFIG_OPT_MANDATORY	3
+
+#endif /* _LINUX_KSMBD_SERVER_H */
diff --git a/fs/cifsd/ksmbd_work.c b/fs/cifsd/ksmbd_work.c
new file mode 100644
index 000000000000..eb8c8a34acab
--- /dev/null
+++ b/fs/cifsd/ksmbd_work.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include "server.h"
+#include "connection.h"
+#include "ksmbd_work.h"
+#include "buffer_pool.h"
+#include "mgmt/ksmbd_ida.h"
+
+/* @FIXME */
+#include "ksmbd_server.h"
+
+static struct kmem_cache *work_cache;
+static struct workqueue_struct *ksmbd_wq;
+
+struct ksmbd_work *ksmbd_alloc_work_struct(void)
+{
+	struct ksmbd_work *work = kmem_cache_zalloc(work_cache, GFP_KERNEL);
+
+	if (work) {
+		work->compound_fid = KSMBD_NO_FID;
+		work->compound_pfid = KSMBD_NO_FID;
+		INIT_LIST_HEAD(&work->request_entry);
+		INIT_LIST_HEAD(&work->async_request_entry);
+		INIT_LIST_HEAD(&work->fp_entry);
+		INIT_LIST_HEAD(&work->interim_entry);
+	}
+	return work;
+}
+
+void ksmbd_free_work_struct(struct ksmbd_work *work)
+{
+	WARN_ON(work->saved_cred != NULL);
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_CACHE_TBUF &&
+			work->set_trans_buf)
+		ksmbd_release_buffer(work->response_buf);
+	else
+		kvfree(work->response_buf);
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_CACHE_RBUF &&
+			work->set_read_buf)
+		ksmbd_release_buffer(work->aux_payload_buf);
+	else
+		kvfree(work->aux_payload_buf);
+
+	kfree(work->tr_buf);
+	kvfree(work->request_buf);
+	if (work->async_id)
+		ksmbd_release_id(&work->conn->async_ida, work->async_id);
+	kmem_cache_free(work_cache, work);
+}
+
+void ksmbd_work_pool_destroy(void)
+{
+	kmem_cache_destroy(work_cache);
+}
+
+int ksmbd_work_pool_init(void)
+{
+	work_cache = kmem_cache_create("ksmbd_work_cache",
+					sizeof(struct ksmbd_work), 0,
+					SLAB_HWCACHE_ALIGN, NULL);
+	if (!work_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+int ksmbd_workqueue_init(void)
+{
+	ksmbd_wq = alloc_workqueue("ksmbd-io", 0, 0);
+	if (!ksmbd_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+void ksmbd_workqueue_destroy(void)
+{
+	flush_workqueue(ksmbd_wq);
+	destroy_workqueue(ksmbd_wq);
+	ksmbd_wq = NULL;
+}
+
+bool ksmbd_queue_work(struct ksmbd_work *work)
+{
+	return queue_work(ksmbd_wq, &work->work);
+}
diff --git a/fs/cifsd/ksmbd_work.h b/fs/cifsd/ksmbd_work.h
new file mode 100644
index 000000000000..28a1692ed37f
--- /dev/null
+++ b/fs/cifsd/ksmbd_work.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_WORK_H__
+#define __KSMBD_WORK_H__
+
+#include <linux/ctype.h>
+#include <linux/workqueue.h>
+
+struct ksmbd_conn;
+struct ksmbd_session;
+struct ksmbd_tree_connect;
+
+enum {
+	KSMBD_WORK_ACTIVE = 0,
+	KSMBD_WORK_CANCELLED,
+	KSMBD_WORK_CLOSED,
+};
+
+/* one of these for every pending CIFS request at the connection */
+struct ksmbd_work {
+	/* Server corresponding to this mid */
+	struct ksmbd_conn               *conn;
+	struct ksmbd_session            *sess;
+	struct ksmbd_tree_connect       *tcon;
+
+	/* Pointer to received SMB header */
+	void                            *request_buf;
+	/* Response buffer */
+	void                            *response_buf;
+
+	/* Read data buffer */
+	void                            *aux_payload_buf;
+
+	/* Next cmd hdr in compound req buf*/
+	int                             next_smb2_rcv_hdr_off;
+	/* Next cmd hdr in compound rsp buf*/
+	int                             next_smb2_rsp_hdr_off;
+
+	/*
+	 * Current Local FID assigned compound response if SMB2 CREATE
+	 * command is present in compound request
+	 */
+	unsigned int                    compound_fid;
+	unsigned int                    compound_pfid;
+	unsigned int                    compound_sid;
+
+	const struct cred		*saved_cred;
+
+	/* Number of granted credits */
+	unsigned int			credits_granted;
+
+	/* response smb header size */
+	unsigned int                    resp_hdr_sz;
+	unsigned int                    response_sz;
+	/* Read data count */
+	unsigned int                    aux_payload_sz;
+
+	void				*tr_buf;
+
+	unsigned char			state;
+	/* Multiple responses for one request e.g. SMB ECHO */
+	bool                            multiRsp:1;
+	/* No response for cancelled request */
+	bool                            send_no_response:1;
+	/* Request is encrypted */
+	bool                            encrypted:1;
+	/* Is this SYNC or ASYNC ksmbd_work */
+	bool                            syncronous:1;
+	bool                            need_invalidate_rkey:1;
+	bool                            set_trans_buf:1;
+	bool                            set_read_buf:1;
+
+	unsigned int                    remote_key;
+	/* cancel works */
+	int                             async_id;
+	void                            **cancel_argv;
+	void                            (*cancel_fn)(void **argv);
+
+	struct work_struct              work;
+	/* List head at conn->requests */
+	struct list_head                request_entry;
+	/* List head at conn->async_requests */
+	struct list_head                async_request_entry;
+	struct list_head                fp_entry;
+	struct list_head                interim_entry;
+};
+
+#define WORK_CANCELLED(w)	((w)->state == KSMBD_WORK_CANCELLED)
+#define WORK_CLOSED(w)		((w)->state == KSMBD_WORK_CLOSED)
+#define WORK_ACTIVE(w)		((w)->state == KSMBD_WORK_ACTIVE)
+
+#define RESPONSE_BUF_NEXT(w)	\
+	(((w)->response_buf + (w)->next_smb2_rsp_hdr_off))
+#define REQUEST_BUF_NEXT(w)	\
+	(((w)->request_buf + (w)->next_smb2_rcv_hdr_off))
+
+struct ksmbd_work *ksmbd_alloc_work_struct(void);
+void ksmbd_free_work_struct(struct ksmbd_work *work);
+
+void ksmbd_work_pool_destroy(void);
+int ksmbd_work_pool_init(void);
+
+int ksmbd_workqueue_init(void);
+void ksmbd_workqueue_destroy(void);
+bool ksmbd_queue_work(struct ksmbd_work *work);
+
+#endif /* __KSMBD_WORK_H__ */
diff --git a/fs/cifsd/server.c b/fs/cifsd/server.c
new file mode 100644
index 000000000000..a4a4e10cf172
--- /dev/null
+++ b/fs/cifsd/server.c
@@ -0,0 +1,631 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include "glob.h"
+#include "oplock.h"
+#include "misc.h"
+#include <linux/sched/signal.h>
+#include <linux/workqueue.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "server.h"
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "buffer_pool.h"
+#include "connection.h"
+#include "transport_ipc.h"
+#include "mgmt/user_session.h"
+#include "crypto_ctx.h"
+#include "auth.h"
+
+int ksmbd_debug_types;
+
+struct ksmbd_server_config server_conf;
+
+enum SERVER_CTRL_TYPE {
+	SERVER_CTRL_TYPE_INIT,
+	SERVER_CTRL_TYPE_RESET,
+};
+
+struct server_ctrl_struct {
+	int			type;
+	struct work_struct	ctrl_work;
+};
+
+static DEFINE_MUTEX(ctrl_lock);
+
+static int ___server_conf_set(int idx, char *val)
+{
+	if (idx >= ARRAY_SIZE(server_conf.conf))
+		return -EINVAL;
+
+	if (!val || val[0] == 0x00)
+		return -EINVAL;
+
+	kfree(server_conf.conf[idx]);
+	server_conf.conf[idx] = kstrdup(val, GFP_KERNEL);
+	if (!server_conf.conf[idx])
+		return -ENOMEM;
+	return 0;
+}
+
+int ksmbd_set_netbios_name(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_NETBIOS_NAME, v);
+}
+
+int ksmbd_set_server_string(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_SERVER_STRING, v);
+}
+
+int ksmbd_set_work_group(char *v)
+{
+	return ___server_conf_set(SERVER_CONF_WORK_GROUP, v);
+}
+
+char *ksmbd_netbios_name(void)
+{
+	return server_conf.conf[SERVER_CONF_NETBIOS_NAME];
+}
+
+char *ksmbd_server_string(void)
+{
+	return server_conf.conf[SERVER_CONF_SERVER_STRING];
+}
+
+char *ksmbd_work_group(void)
+{
+	return server_conf.conf[SERVER_CONF_WORK_GROUP];
+}
+
+/**
+ * check_conn_state() - check state of server thread connection
+ * @work:     smb work containing server thread information
+ *
+ * Return:	0 on valid connection, otherwise 1 to reconnect
+ */
+static inline int check_conn_state(struct ksmbd_work *work)
+{
+	struct smb_hdr *rsp_hdr;
+
+	if (ksmbd_conn_exiting(work) || ksmbd_conn_need_reconnect(work)) {
+		rsp_hdr = work->response_buf;
+		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
+		return 1;
+	}
+	return 0;
+}
+
+#define TCP_HANDLER_CONTINUE	0
+#define TCP_HANDLER_ABORT	1
+
+static int __process_request(struct ksmbd_work *work, struct ksmbd_conn *conn,
+		uint16_t *cmd)
+{
+	struct smb_version_cmds *cmds;
+	uint16_t command;
+	int ret;
+
+	if (check_conn_state(work))
+		return TCP_HANDLER_CONTINUE;
+
+	if (ksmbd_verify_smb_message(work))
+		return TCP_HANDLER_ABORT;
+
+	command = conn->ops->get_cmd_val(work);
+	*cmd = command;
+
+andx_again:
+	if (command >= conn->max_cmds) {
+		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
+		return TCP_HANDLER_CONTINUE;
+	}
+
+	cmds = &conn->cmds[command];
+	if (!cmds->proc) {
+		ksmbd_debug(SMB, "*** not implemented yet cmd = %x\n", command);
+		conn->ops->set_rsp_status(work, STATUS_NOT_IMPLEMENTED);
+		return TCP_HANDLER_CONTINUE;
+	}
+
+	if (work->sess && conn->ops->is_sign_req(work, command)) {
+		ret = conn->ops->check_sign_req(work);
+		if (!ret) {
+			conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
+			return TCP_HANDLER_CONTINUE;
+		}
+	}
+
+	ret = cmds->proc(work);
+
+	if (ret < 0)
+		ksmbd_debug(CONN, "Failed to process %u [%d]\n", command, ret);
+	/* AndX commands - chained request can return positive values */
+	else if (ret > 0) {
+		command = ret;
+		*cmd = command;
+		goto andx_again;
+	}
+
+	if (work->send_no_response)
+		return TCP_HANDLER_ABORT;
+	return TCP_HANDLER_CONTINUE;
+}
+
+static void __handle_ksmbd_work(struct ksmbd_work *work,
+		struct ksmbd_conn *conn)
+{
+	u16 command = 0;
+	int rc;
+
+	if (conn->ops->allocate_rsp_buf(work))
+		return;
+
+	if (conn->ops->is_transform_hdr &&
+	    conn->ops->is_transform_hdr(work->request_buf)) {
+		rc = conn->ops->decrypt_req(work);
+		if (rc < 0) {
+			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			goto send;
+		}
+
+		work->encrypted = true;
+	}
+
+	rc = conn->ops->init_rsp_hdr(work);
+	if (rc) {
+		/* either uid or tid is not correct */
+		conn->ops->set_rsp_status(work, STATUS_INVALID_HANDLE);
+		goto send;
+	}
+
+	if (conn->ops->check_user_session) {
+		rc = conn->ops->check_user_session(work);
+		if (rc < 0) {
+			command = conn->ops->get_cmd_val(work);
+			conn->ops->set_rsp_status(work,
+					STATUS_USER_SESSION_DELETED);
+			goto send;
+		} else if (rc > 0) {
+			rc = conn->ops->get_ksmbd_tcon(work);
+			if (rc < 0) {
+				conn->ops->set_rsp_status(work,
+					STATUS_NETWORK_NAME_DELETED);
+				goto send;
+			}
+		}
+	}
+
+	do {
+		rc = __process_request(work, conn, &command);
+		if (rc == TCP_HANDLER_ABORT)
+			break;
+
+		/*
+		 * Call smb2_set_rsp_credits() function to set number of credits
+		 * granted in hdr of smb2 response.
+		 */
+		if (conn->ops->set_rsp_credits) {
+			spin_lock(&conn->credits_lock);
+			rc = conn->ops->set_rsp_credits(work);
+			spin_unlock(&conn->credits_lock);
+			if (rc < 0) {
+				conn->ops->set_rsp_status(work,
+					STATUS_INVALID_PARAMETER);
+				goto send;
+			}
+		}
+
+		if (work->sess && (work->sess->sign ||
+		    smb3_11_final_sess_setup_resp(work) ||
+		     conn->ops->is_sign_req(work, command)))
+			conn->ops->set_sign_rsp(work);
+	} while (is_chained_smb2_message(work));
+
+	if (work->send_no_response)
+		return;
+
+send:
+	smb3_preauth_hash_rsp(work);
+	if (work->sess && work->sess->enc && work->encrypted &&
+	    conn->ops->encrypt_resp) {
+		rc = conn->ops->encrypt_resp(work);
+		if (rc < 0) {
+			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			goto send;
+		}
+	}
+
+	ksmbd_conn_write(work);
+}
+
+/**
+ * handle_ksmbd_work() - process pending smb work requests
+ * @wk:	smb work containing request command buffer
+ *
+ * called by kworker threads to processing remaining smb work requests
+ */
+static void handle_ksmbd_work(struct work_struct *wk)
+{
+	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
+	struct ksmbd_conn *conn = work->conn;
+
+	atomic64_inc(&conn->stats.request_served);
+
+	__handle_ksmbd_work(work, conn);
+
+	ksmbd_conn_try_dequeue_request(work);
+	ksmbd_free_work_struct(work);
+	atomic_dec(&conn->r_count);
+}
+
+/**
+ * queue_ksmbd_work() - queue a smb request to worker thread queue
+ *		for proccessing smb command and sending response
+ * @conn:	connection instance
+ *
+ * read remaining data from socket create and submit work.
+ */
+static int queue_ksmbd_work(struct ksmbd_conn *conn)
+{
+	struct ksmbd_work *work;
+
+	work = ksmbd_alloc_work_struct();
+	if (!work) {
+		ksmbd_err("allocation for work failed\n");
+		return -ENOMEM;
+	}
+
+	work->conn = conn;
+	work->request_buf = conn->request_buf;
+	conn->request_buf = NULL;
+
+	if (ksmbd_init_smb_server(work)) {
+		ksmbd_free_work_struct(work);
+		return -EINVAL;
+	}
+
+	ksmbd_conn_enqueue_request(work);
+	atomic_inc(&conn->r_count);
+	/* update activity on connection */
+	conn->last_active = jiffies;
+	INIT_WORK(&work->work, handle_ksmbd_work);
+	ksmbd_queue_work(work);
+	return 0;
+}
+
+static int ksmbd_server_process_request(struct ksmbd_conn *conn)
+{
+	return queue_ksmbd_work(conn);
+}
+
+static int ksmbd_server_terminate_conn(struct ksmbd_conn *conn)
+{
+	ksmbd_sessions_deregister(conn);
+	destroy_lease_table(conn);
+	return 0;
+}
+
+static void ksmbd_server_tcp_callbacks_init(void)
+{
+	struct ksmbd_conn_ops ops;
+
+	ops.process_fn = ksmbd_server_process_request;
+	ops.terminate_fn = ksmbd_server_terminate_conn;
+
+	ksmbd_conn_init_server_callbacks(&ops);
+}
+
+static void server_conf_free(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(server_conf.conf); i++) {
+		kfree(server_conf.conf[i]);
+		server_conf.conf[i] = NULL;
+	}
+}
+
+static int server_conf_init(void)
+{
+	WRITE_ONCE(server_conf.state, SERVER_STATE_STARTING_UP);
+	server_conf.enforced_signing = 0;
+	server_conf.min_protocol = ksmbd_min_protocol();
+	server_conf.max_protocol = ksmbd_max_protocol();
+	server_conf.auth_mechs = KSMBD_AUTH_NTLMSSP;
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+	server_conf.auth_mechs |= KSMBD_AUTH_KRB5 |
+				KSMBD_AUTH_MSKRB5;
+#endif
+	return 0;
+}
+
+static void server_ctrl_handle_init(struct server_ctrl_struct *ctrl)
+{
+	int ret;
+
+	ret = ksmbd_conn_transport_init();
+	if (ret) {
+		server_queue_ctrl_reset_work();
+		return;
+	}
+
+	WRITE_ONCE(server_conf.state, SERVER_STATE_RUNNING);
+}
+
+static void server_ctrl_handle_reset(struct server_ctrl_struct *ctrl)
+{
+	ksmbd_ipc_soft_reset();
+	ksmbd_conn_transport_destroy();
+	server_conf_free();
+	server_conf_init();
+	WRITE_ONCE(server_conf.state, SERVER_STATE_STARTING_UP);
+}
+
+static void server_ctrl_handle_work(struct work_struct *work)
+{
+	struct server_ctrl_struct *ctrl;
+
+	ctrl = container_of(work, struct server_ctrl_struct, ctrl_work);
+
+	mutex_lock(&ctrl_lock);
+	switch (ctrl->type) {
+	case SERVER_CTRL_TYPE_INIT:
+		server_ctrl_handle_init(ctrl);
+		break;
+	case SERVER_CTRL_TYPE_RESET:
+		server_ctrl_handle_reset(ctrl);
+		break;
+	default:
+		pr_err("Unknown server work type: %d\n", ctrl->type);
+	}
+	mutex_unlock(&ctrl_lock);
+	kfree(ctrl);
+	module_put(THIS_MODULE);
+}
+
+static int __queue_ctrl_work(int type)
+{
+	struct server_ctrl_struct *ctrl;
+
+	ctrl = kmalloc(sizeof(struct server_ctrl_struct), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	__module_get(THIS_MODULE);
+	ctrl->type = type;
+	INIT_WORK(&ctrl->ctrl_work, server_ctrl_handle_work);
+	queue_work(system_long_wq, &ctrl->ctrl_work);
+	return 0;
+}
+
+int server_queue_ctrl_init_work(void)
+{
+	return __queue_ctrl_work(SERVER_CTRL_TYPE_INIT);
+}
+
+int server_queue_ctrl_reset_work(void)
+{
+	return __queue_ctrl_work(SERVER_CTRL_TYPE_RESET);
+}
+
+static ssize_t stats_show(struct class *class, struct class_attribute *attr,
+		char *buf)
+{
+	/*
+	 * Inc this each time you change stats output format,
+	 * so user space will know what to do.
+	 */
+	static int stats_version = 2;
+	static const char * const state[] = {
+		"startup",
+		"running",
+		"reset",
+		"shutdown"
+	};
+
+	ssize_t sz = scnprintf(buf,
+				PAGE_SIZE,
+				"%d %s %d %lu\n",
+				stats_version,
+				state[server_conf.state],
+				server_conf.tcp_port,
+				server_conf.ipc_last_active / HZ);
+	return sz;
+}
+
+static ssize_t kill_server_store(struct class *class,
+		struct class_attribute *attr, const char *buf,
+		size_t len)
+{
+	if (!sysfs_streq(buf, "hard"))
+		return len;
+
+	ksmbd_info("kill command received\n");
+	mutex_lock(&ctrl_lock);
+	WRITE_ONCE(server_conf.state, SERVER_STATE_RESETTING);
+	__module_get(THIS_MODULE);
+	server_ctrl_handle_reset(NULL);
+	module_put(THIS_MODULE);
+	mutex_unlock(&ctrl_lock);
+	return len;
+}
+
+static const char * const debug_type_strings[] = {"smb", "auth", "vfs",
+						"oplock", "ipc", "conn",
+						"rdma"};
+
+static ssize_t debug_show(struct class *class, struct class_attribute *attr,
+		char *buf)
+{
+	ssize_t sz = 0;
+	int i, pos = 0;
+
+	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
+		if ((ksmbd_debug_types >> i) & 1) {
+			pos = scnprintf(buf + sz,
+					PAGE_SIZE - sz,
+					"[%s] ",
+					debug_type_strings[i]);
+		} else {
+			pos = scnprintf(buf + sz,
+					PAGE_SIZE - sz,
+					"%s ",
+					debug_type_strings[i]);
+		}
+		sz += pos;
+	}
+	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
+	return sz;
+}
+
+static ssize_t debug_store(struct class *class, struct class_attribute *attr,
+		const char *buf, size_t len)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
+		if (sysfs_streq(buf, "all")) {
+			if (ksmbd_debug_types == KSMBD_DEBUG_ALL)
+				ksmbd_debug_types = 0;
+			else
+				ksmbd_debug_types = KSMBD_DEBUG_ALL;
+			break;
+		}
+
+		if (sysfs_streq(buf, debug_type_strings[i])) {
+			if (ksmbd_debug_types & (1 << i))
+				ksmbd_debug_types &= ~(1 << i);
+			else
+				ksmbd_debug_types |= (1 << i);
+			break;
+		}
+	}
+
+	return len;
+}
+
+static CLASS_ATTR_RO(stats);
+static CLASS_ATTR_WO(kill_server);
+static CLASS_ATTR_RW(debug);
+
+static struct attribute *ksmbd_control_class_attrs[] = {
+	&class_attr_stats.attr,
+	&class_attr_kill_server.attr,
+	&class_attr_debug.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ksmbd_control_class);
+
+static struct class ksmbd_control_class = {
+	.name		= "ksmbd-control",
+	.owner		= THIS_MODULE,
+	.class_groups	= ksmbd_control_class_groups,
+};
+
+static int ksmbd_server_shutdown(void)
+{
+	WRITE_ONCE(server_conf.state, SERVER_STATE_SHUTTING_DOWN);
+
+	class_unregister(&ksmbd_control_class);
+	ksmbd_workqueue_destroy();
+	ksmbd_ipc_release();
+	ksmbd_conn_transport_destroy();
+	ksmbd_crypto_destroy();
+	ksmbd_free_global_file_table();
+	destroy_lease_table(NULL);
+	ksmbd_destroy_buffer_pools();
+	server_conf_free();
+	return 0;
+}
+
+static int __init ksmbd_server_init(void)
+{
+	int ret;
+
+	ret = class_register(&ksmbd_control_class);
+	if (ret) {
+		ksmbd_err("Unable to register ksmbd-control class\n");
+		return ret;
+	}
+
+	ksmbd_server_tcp_callbacks_init();
+
+	ret = server_conf_init();
+	if (ret)
+		goto err_unregister;
+
+	ret = ksmbd_init_buffer_pools();
+	if (ret)
+		goto err_unregister;
+
+	ret = ksmbd_ipc_init();
+	if (ret)
+		goto err_free_session_table;
+
+	ret = ksmbd_init_global_file_table();
+	if (ret)
+		goto err_ipc_release;
+
+	ret = ksmbd_inode_hash_init();
+	if (ret)
+		goto err_destroy_file_table;
+
+	ret = ksmbd_crypto_create();
+	if (ret)
+		goto err_release_inode_hash;
+
+	ret = ksmbd_workqueue_init();
+	if (ret)
+		goto err_crypto_destroy;
+	return 0;
+
+err_crypto_destroy:
+	ksmbd_crypto_destroy();
+err_release_inode_hash:
+	ksmbd_release_inode_hash();
+err_destroy_file_table:
+	ksmbd_free_global_file_table();
+err_ipc_release:
+	ksmbd_ipc_release();
+err_free_session_table:
+	ksmbd_destroy_buffer_pools();
+err_unregister:
+	class_unregister(&ksmbd_control_class);
+
+	return ret;
+}
+
+/**
+ * ksmbd_server_exit() - shutdown forker thread and free memory at module exit
+ */
+static void __exit ksmbd_server_exit(void)
+{
+	ksmbd_server_shutdown();
+	ksmbd_release_inode_hash();
+}
+
+MODULE_AUTHOR("Namjae Jeon <linkinjeon@kernel.org>");
+MODULE_VERSION(KSMBD_VERSION);
+MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: ecb");
+MODULE_SOFTDEP("pre: hmac");
+MODULE_SOFTDEP("pre: md4");
+MODULE_SOFTDEP("pre: md5");
+MODULE_SOFTDEP("pre: nls");
+MODULE_SOFTDEP("pre: aes");
+MODULE_SOFTDEP("pre: cmac");
+MODULE_SOFTDEP("pre: sha256");
+MODULE_SOFTDEP("pre: sha512");
+MODULE_SOFTDEP("pre: aead2");
+MODULE_SOFTDEP("pre: ccm");
+MODULE_SOFTDEP("pre: gcm");
+module_init(ksmbd_server_init)
+module_exit(ksmbd_server_exit)
diff --git a/fs/cifsd/server.h b/fs/cifsd/server.h
new file mode 100644
index 000000000000..b682d28963e8
--- /dev/null
+++ b/fs/cifsd/server.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __SERVER_H__
+#define __SERVER_H__
+
+#include "smbacl.h"
+
+#define SERVER_STATE_STARTING_UP	0
+#define SERVER_STATE_RUNNING		1
+#define SERVER_STATE_RESETTING		2
+#define SERVER_STATE_SHUTTING_DOWN	3
+
+#define SERVER_CONF_NETBIOS_NAME	0
+#define SERVER_CONF_SERVER_STRING	1
+#define SERVER_CONF_WORK_GROUP		2
+
+struct ksmbd_server_config {
+	unsigned int		flags;
+	unsigned int		state;
+	short			signing;
+	short			enforced_signing;
+	short			min_protocol;
+	short			max_protocol;
+	unsigned short		tcp_port;
+	unsigned short		ipc_timeout;
+	unsigned long		ipc_last_active;
+	unsigned long		deadtime;
+	unsigned int		share_fake_fscaps;
+	struct smb_sid		domain_sid;
+	unsigned int		auth_mechs;
+
+	char			*conf[SERVER_CONF_WORK_GROUP + 1];
+};
+
+extern struct ksmbd_server_config server_conf;
+
+int ksmbd_set_netbios_name(char *v);
+int ksmbd_set_server_string(char *v);
+int ksmbd_set_work_group(char *v);
+
+char *ksmbd_netbios_name(void);
+char *ksmbd_server_string(void);
+char *ksmbd_work_group(void);
+
+static inline int ksmbd_server_running(void)
+{
+	return READ_ONCE(server_conf.state) == SERVER_STATE_RUNNING;
+}
+
+static inline int ksmbd_server_configurable(void)
+{
+	return READ_ONCE(server_conf.state) < SERVER_STATE_RESETTING;
+}
+
+int server_queue_ctrl_init_work(void);
+int server_queue_ctrl_reset_work(void);
+#endif /* __SERVER_H__ */
-- 
2.17.1

