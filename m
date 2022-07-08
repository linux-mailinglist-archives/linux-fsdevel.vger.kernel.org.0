Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BBF56B704
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiGHKMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiGHKMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:12:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7533784EF2;
        Fri,  8 Jul 2022 03:12:14 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2686HZ84022333;
        Fri, 8 Jul 2022 03:12:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=mg/JdJHy3lG//CiufsHDJaVUwA0Sntok17tcu/D/eQY=;
 b=SDA3nts19MdpovVYmROfhsi7JYL+NHkQJspQ5NldzhL4MoILm1XadveaimcWsUAorm6J
 B7oKFDhNhJbWuwPN5jzGLK9Qwv6+weOZHBszfCcEp2i2XbmGtzL6HJ7TDeIeTh+c3V+V
 Vx+gNQbSmvcNAOKFKfFSlYpTZJSJJl+z6ak= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h6f69rxs4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 03:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpzMvo/DTg8s3fd2OFGU/TMf7IrXq1HE0oaly56XijezUeXvtaKgZPdqimHX6+51nDIIpE+8Gox+afUWJc6vhC57sotZmDhiWQTKTWcbXDQceyF0yXGmPqNiClBlMab3qjc7xJTsRuszgVBCFSIyzWYox2LeWVlopNxTBteJ3AN3FSl5rPTbHzTkyceabvdfCTc5STp/TRRGWD28ufMDeqTk7lZPZW7EG7WsAPDjc367XAwMb6V2mrC3Fjh/eyE7+2FWHn4iOrvQwnIPVDtfBwZOVslYLRVW4QDJIA/ZoEujEu4+QE0RiQs228+ra/bxXO6sxFCIrjIwlEm0rX2tTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg/JdJHy3lG//CiufsHDJaVUwA0Sntok17tcu/D/eQY=;
 b=nUX8qVbnyanZ+AGBvqQRVrlUOi5GDhu5b708r+lZbQzZOdsRAC7B08UbxgeI7gV6lR/ueBbNSbfkfdqQk6TIZYYmQbApLmy43uw6BkUy7ZAILZJLPEqd+N5VYikbfor/4z/x4bsf5ej7YmSDNgi5lAMcA+Arwa7ZuCTMIwO9dso2qXRfwttQJ4GDLVV+onxEAFp5G58Lvb+NWWyhM9wdQtn3GGH0TNQq7YKl3o8vMPXUMRTtIzDYgrv0bAbvMKwk1aNQ5gXMu7S2ir7KCth6tFPPw/AR46jl6m3+9udlLj29nTydw75hgoEjJfZSNfNWIMWVTaiyBfcmoIowRWULqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:12:11 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:12:11 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH 4/7] lib/cpio: Allow use outside of initramfs creation
Thread-Topic: [RFC PATCH 4/7] lib/cpio: Allow use outside of initramfs
 creation
Thread-Index: AQHYkrMwcn7RjV8qMUGa5f8X0WAuow==
Date:   Fri, 8 Jul 2022 10:12:11 +0000
Message-ID: <b298adc612237dd67c6dee77e49cbbf3278fd985.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc77a384-c0e5-46e5-31cd-08da60ca5309
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPFOJF4c5UuzCeA4qYVds6nBgBGYFXxEa0tjaNcKNQzvHZcQTbYgk3gFcLx9QAjkbAV2rDqJkGRWRy2aAr5aUMw7Fvlf7hPY/WBxJJUYivxL36ndmqBgNVuyVUzukOFjYpJpsGTvVYGXU5eBcBgPcQpkH7y5Pxoj+r1q8wt3MH6V585i4Ivd3lQ/sY89ijJ3YGj/8UCN6Hi3TFnr7Li37WQ11Z+wkSK4+Eca1sTBwGcw+6GPk92/NnLdlMAoU7Eg2yGHYbOrNEUL5K0mUtn8bx/i3sBlDUmDIT0pdNiE3p5qoxDurNyR6iZ9Cl3GJW42uOpMF7h2FRps/z/yaXSytYrqsxtdP2Yz61qnBAxEg0QhVHCA8xuf63oIZfBu0BYNC7SJc/4fm9AK9z7xmBVYZNTxYRaEbnqThIA2iv5Eu7icOpWs6INH+v7Qw35E+2t9gED/S1RTc3UitKYSwnzBsbEbMauWwtESl4Eup2hLaaPTftgUwMsA3R6GucHUPIJ+Eq0kl32Hkjeh0h1B3R+WlRme3dox64RWny9FABiFvrLCxNhfg6DtSQrEsDrEdD1jNygJWHVqZi1If35QRUYfZ8LnHCWXwt8Y7BlNg+X7GApyiI33njc727w0ATd3oU7SNqDRXXlSVbfw2EwwqhSxqUvnVxmQrMpvEhTn5OoMMAXncHeYj7TRcNd/ROGeSTOKgD9F7bJzlQoUL88zbKghf3yGCee3YVOvJT3vA7Hlw9Y+49HUeLOlgPOOlI+5HwDhfHoXwVqItgI5GSoiPRJCFkcXNUxErrxPRts7YwLGp1Th7DbwsrBFedtiGAXyNEKi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(38100700002)(110136005)(2906002)(54906003)(122000001)(316002)(7416002)(30864003)(83380400001)(8936002)(2616005)(5660300002)(36756003)(6506007)(38070700005)(6512007)(26005)(76116006)(91956017)(8676002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(71200400001)(186003)(86362001)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W7plsep5qgGCLA46Ysf/ac+dRAC6sPNo2ejM16mONHantzIkHnoSgoYZMTI/?=
 =?us-ascii?Q?4IkhdJO3xV3PSZUU7dpSdhVPb5XKDX5zZ8jI+4iX+g4DAQAUGyvy3O/9IlGc?=
 =?us-ascii?Q?RbpCcyPmghZrlwnZeXK3VKkU3Sixp+Y4fMD0DbTU00rMzIieBq9nma7/YMun?=
 =?us-ascii?Q?X5kghluWlVfapfoFRnugstc352X/FAiIOiApccGWWQ0v+qCBILN4GlOViRtz?=
 =?us-ascii?Q?quJPW5gbjAShC8r2mepwCbOVwnvwP5X+VRiNaYVWxbmJDH4keV5qCo0DRDqa?=
 =?us-ascii?Q?dQqrlfsS8IB7wEuVP9lTxvXqWuRExRQuptYLuS9tMf05Kgdpt7Fp+hgo0YGr?=
 =?us-ascii?Q?LABZqhSLgIJh3oDRrkRKiXzD3jK4fkiG3lbLVXhC+RuDOk27RZTy9L6d81vW?=
 =?us-ascii?Q?Zn3Z0Rzbmhj1pjiN1mStWHE2sTNtZ7atS/dBjRjldzwk/goLOBzl3Fl6mh8f?=
 =?us-ascii?Q?s23+ppLSPKy8Tk3VpNO71cPnGX9pqvg6bab6FMSAev8vhRcJj+XXUKgx5TaN?=
 =?us-ascii?Q?ZgjAb/geg/fbgUh4H49B5qJAdJ2BLLtlxu9Tj+t7p/SX9kWgzFIdkt4Hctc1?=
 =?us-ascii?Q?byord8zVSsL65uCSAVAvPGK3Si6Qtz54hZbolzEW04HBFu55CZZHqHo1ef7j?=
 =?us-ascii?Q?IGKAGyWGEYlcPX0hskb7/9FzTLDRcNhHw3IN/qMEmKg+7nOwWB+oPJu6PfoY?=
 =?us-ascii?Q?8J9nvpus17GxmPwsSn32NEhzr/dU8kuiHEIByMP7husojMM1NIcr3xrFNTdR?=
 =?us-ascii?Q?E6MfJun8X/6ihFZNGKu9fd2EEEyhDHmu7VDKKYsGUNfuhxnWF8nhjXDA/tm+?=
 =?us-ascii?Q?csqYw8IXthRiEX5BiUgWyxLQkRNwl9vu2CXFqIdBSGBZ1jBLHsbEopgb/xoL?=
 =?us-ascii?Q?PEZCH1pJlXDv8e9qOynyTL/IpqOHnTpfpGUcG4Udu7qTbp5DaFYn29hY3eAy?=
 =?us-ascii?Q?Jaii2XantOr6B9F937ca1JIqOjV1BUtrKvwUv63IacX3sP1U2pIc7IctRfsY?=
 =?us-ascii?Q?Hh5P3fv4PHcJcYtHWFuh0TsP2YD01EqV8JLLYMYipkhfa2k6NaEh5p5Q5IgF?=
 =?us-ascii?Q?qd0H2dIwtkH53hVF4QSh+N8whvSUooiZk37fWQBNOUN9UD+75iiF+myFOqxA?=
 =?us-ascii?Q?Zwqpf9KViMifb7Ith7MtT4StK6B2HCHf4470TLjwqo2mSZDXX1m4VwKRuRCK?=
 =?us-ascii?Q?evx2oXV27hQ3GzAp4pOwhd4zyr2ECjwON89KZcnKzoR4AbqCQlBZ8Frma7on?=
 =?us-ascii?Q?8S/l2u8K02Y6ml60tisC0lIx11QxwjRYD1FPdGRnpAtPfTZ0KQ0Fk1in4rB8?=
 =?us-ascii?Q?DTa0AqosYVFXHKuMZfBnqJkc2ebwlu8bdXUTcG3N0P+UYvIDg3v6OZ+2FnSc?=
 =?us-ascii?Q?qWAK32rh4SBX42SAn0B0xHXL/rxxIWRiD7Yo88j44u+EaMkoMFbZJaylYtVS?=
 =?us-ascii?Q?uMqs7b14AJP4KmXoo6RR4Oo3kXNpLgUY6pITldSJn64VRcaG+pfYXtLXU12y?=
 =?us-ascii?Q?WkpfKJrRhegR2Gb3LQLwGKcWHt+J9w7ZmjIDI4fQY4UxEQXOSdCJrZ3Nxsam?=
 =?us-ascii?Q?OVLiMn6ZgUZW05LC9Cb5Lokoc26euXgbdN5mGGOg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306CB3219946B499FFEBB779F9F1CC3@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc77a384-c0e5-46e5-31cd-08da60ca5309
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:12:11.8806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: of0lBE5vQJCodteXPRXiWoavoLwmctDka2QquQ08nbuw9IglLr6q+9EQzk2wahk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-ORIG-GUID: kp7xG-ALwE3gmzBmGrmQyAyR4xvFnOEB
X-Proofpoint-GUID: kp7xG-ALwE3gmzBmGrmQyAyR4xvFnOEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we no longer depend on anything that lives in __init add a Kconfig
option to allow the cpio code to be used by other code within the
kernel. If not selected the code will continue to be placed within the
__init section and discarded after boot.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 include/linux/cpio.h | 20 ++++++++---
 lib/Kconfig          |  3 ++
 lib/cpio.c           | 80 +++++++++++++++++++++++---------------------
 3 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
index d8c1344a6cc3..b05140a565cb 100644
--- a/include/linux/cpio.h
+++ b/include/linux/cpio.h
@@ -11,6 +11,18 @@
 
 #define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
 
+/*
+ * If nothing explicitly wants us then we can live in the __init section as
+ * only the initramfs code will call us.
+ */
+#ifdef CONFIG_CPIO
+#define __cpio
+#define __cpiodata
+#else
+#define __cpio __init
+#define __cpiodata __initdata
+#endif
+
 enum cpio_state {
 	CPIO_START,
 	CPIO_COLLECT,
@@ -67,11 +79,11 @@ struct cpio_context {
 	struct list_head dir_list;
 };
 
-int __init cpio_start(struct cpio_context *ctx);
-void __init cpio_finish(struct cpio_context *ctx);
-long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
+int __cpio cpio_start(struct cpio_context *ctx);
+void __cpio cpio_finish(struct cpio_context *ctx);
+long __cpio cpio_write_buffer(struct cpio_context *ctx, char *buf,
 			      unsigned long len);
-long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
+long __cpio cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 				unsigned long len);
 
 #endif /* _LINUX_CPIO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index eaaad4d85bf2..fad66ee4caed 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -743,3 +743,6 @@ config ASN1_ENCODER
 
 config POLYNOMIAL
        tristate
+
+config CPIO
+	bool
diff --git a/lib/cpio.c b/lib/cpio.c
index 6ae443a1c103..16629ad1e339 100644
--- a/lib/cpio.c
+++ b/lib/cpio.c
@@ -8,7 +8,7 @@
 #include <linux/security.h>
 #include <linux/slab.h>
 
-static ssize_t __init xwrite(struct cpio_context *ctx, struct file *file,
+static ssize_t __cpio xwrite(struct cpio_context *ctx, struct file *file,
 			     const unsigned char *p, size_t count, loff_t *pos)
 {
 	ssize_t out = 0;
@@ -50,7 +50,7 @@ static inline int hash(int major, int minor, int ino)
 	return tmp & (CPIO_LINK_HASH_SIZE - 1);
 }
 
-static char __init *find_link(struct cpio_context *ctx, int major, int minor,
+static char __cpio *find_link(struct cpio_context *ctx, int major, int minor,
 			      int ino, umode_t mode, char *name)
 {
 	struct cpio_link_hash **p, *q;
@@ -79,7 +79,7 @@ static char __init *find_link(struct cpio_context *ctx, int major, int minor,
 	return NULL;
 }
 
-static void __init free_hash(struct cpio_context *ctx)
+static void __cpio free_hash(struct cpio_context *ctx)
 {
 	struct cpio_link_hash **p, *q;
 
@@ -93,14 +93,14 @@ static void __init free_hash(struct cpio_context *ctx)
 }
 
 #ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
-static void __init do_utime_path(const struct path *path, time64_t mtime)
+static void __cpio do_utime_path(const struct path *path, time64_t mtime)
 {
 	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
 
 	vfs_utimes(path, t);
 }
 
-static int __init do_utime(char *filename, time64_t mtime)
+static int __cpio do_utime(char *filename, time64_t mtime)
 {
 	struct path path;
 	int error;
@@ -114,7 +114,7 @@ static int __init do_utime(char *filename, time64_t mtime)
 	return error;
 }
 
-static int __init dir_add(struct cpio_context *ctx, const char *name, time64_t mtime)
+static int __cpio dir_add(struct cpio_context *ctx, const char *name, time64_t mtime)
 {
 	size_t nlen = strlen(name) + 1;
 	struct cpio_dir_entry *de;
@@ -130,7 +130,7 @@ static int __init dir_add(struct cpio_context *ctx, const char *name, time64_t m
 	return 0;
 }
 
-static void __init dir_utime(struct cpio_context *ctx)
+static void __cpio dir_utime(struct cpio_context *ctx)
 {
 	struct cpio_dir_entry *de, *tmp;
 
@@ -141,13 +141,13 @@ static void __init dir_utime(struct cpio_context *ctx)
 	}
 }
 #else
-static int __init do_utime(char *filename, time64_t mtime) { return 0; }
-static void __init do_utime_path(const struct path *path, time64_t mtime) {}
-static int __init dir_add(struct cpio_context *ctx, const char *name, time64_t mtime) { return 0; }
-static void __init dir_utime(struct cpio_context *ctx) {}
+static int __cpio do_utime(char *filename, time64_t mtime) { return 0; }
+static void __cpio do_utime_path(const struct path *path, time64_t mtime) {}
+static int __cpio dir_add(struct cpio_context *ctx, const char *name, time64_t mtime) { return 0; }
+static void __cpio dir_utime(struct cpio_context *ctx) {}
 #endif
 
-static int __init cpio_chown(const char *filename, uid_t user, gid_t group,
+static int __cpio cpio_chown(const char *filename, uid_t user, gid_t group,
 			     int flags)
 {
 	int lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
@@ -168,7 +168,7 @@ static int __init cpio_chown(const char *filename, uid_t user, gid_t group,
 
 /* cpio header parsing */
 
-static void __init parse_header(struct cpio_context *ctx, char *s)
+static void __cpio parse_header(struct cpio_context *ctx, char *s)
 {
 	unsigned long parsed[13];
 	char buf[9];
@@ -195,14 +195,14 @@ static void __init parse_header(struct cpio_context *ctx, char *s)
 
 /* FSM */
 
-static inline void __init eat(struct cpio_context *ctx, unsigned int n)
+static inline void __cpio eat(struct cpio_context *ctx, unsigned int n)
 {
 	ctx->victim += n;
 	ctx->this_header += n;
 	ctx->byte_count -= n;
 }
 
-static void __init read_into(struct cpio_context *ctx, char *buf,
+static void __cpio read_into(struct cpio_context *ctx, char *buf,
 			     unsigned int size, enum cpio_state next)
 {
 	if (ctx->byte_count >= size) {
@@ -218,13 +218,13 @@ static void __init read_into(struct cpio_context *ctx, char *buf,
 	}
 }
 
-static int __init do_start(struct cpio_context *ctx)
+static int __cpio do_start(struct cpio_context *ctx)
 {
 	read_into(ctx, ctx->header_buf, 110, CPIO_GOTHEADER);
 	return 0;
 }
 
-static int __init do_collect(struct cpio_context *ctx)
+static int __cpio do_collect(struct cpio_context *ctx)
 {
 	unsigned long n = ctx->remains;
 
@@ -242,7 +242,7 @@ static int __init do_collect(struct cpio_context *ctx)
 	return 0;
 }
 
-static int __init do_header(struct cpio_context *ctx)
+static int __cpio do_header(struct cpio_context *ctx)
 {
 	if (!memcmp(ctx->collected, "070701", 6)) {
 		ctx->csum_present = false;
@@ -274,7 +274,7 @@ static int __init do_header(struct cpio_context *ctx)
 	return 0;
 }
 
-static int __init do_skip(struct cpio_context *ctx)
+static int __cpio do_skip(struct cpio_context *ctx)
 {
 	if (ctx->this_header + ctx->byte_count < ctx->next_header) {
 		eat(ctx, ctx->byte_count);
@@ -286,7 +286,7 @@ static int __init do_skip(struct cpio_context *ctx)
 	return 0;
 }
 
-static int __init do_reset(struct cpio_context *ctx)
+static int __cpio do_reset(struct cpio_context *ctx)
 {
 	while (ctx->byte_count && *ctx->victim == '\0')
 		eat(ctx, 1);
@@ -296,7 +296,7 @@ static int __init do_reset(struct cpio_context *ctx)
 	return 1;
 }
 
-static void __init clean_path(char *pathname, umode_t fmode)
+static void __cpio clean_path(char *pathname, umode_t fmode)
 {
 	struct path path;
 	struct kstat st;
@@ -318,7 +318,7 @@ static void __init clean_path(char *pathname, umode_t fmode)
 	}
 }
 
-static int __init maybe_link(struct cpio_context *ctx)
+static int __cpio maybe_link(struct cpio_context *ctx)
 {
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
@@ -362,7 +362,7 @@ static int __init maybe_link(struct cpio_context *ctx)
 	return 0;
 }
 
-static int __init do_name(struct cpio_context *ctx)
+static int __cpio do_name(struct cpio_context *ctx)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -397,14 +397,18 @@ static int __init do_name(struct cpio_context *ctx)
 		}
 	} else if (S_ISDIR(ctx->mode)) {
 		dentry = kern_path_create(AT_FDCWD, ctx->collected, &path, LOOKUP_DIRECTORY);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-		error = security_path_mkdir(&path, dentry, ctx->mode);
-		if (!error)
-			error = vfs_mkdir(mnt_user_ns(path.mnt), path.dentry->d_inode,
-					  dentry, ctx->mode);
-		done_path_create(&path, dentry);
-		if (error)
+		if (!IS_ERR(dentry)) {
+			error = security_path_mkdir(&path, dentry, ctx->mode);
+			if (!error)
+				error = vfs_mkdir(mnt_user_ns(path.mnt),
+						  path.dentry->d_inode,
+						  dentry, ctx->mode);
+			done_path_create(&path, dentry);
+		} else {
+			error = PTR_ERR(dentry);
+		}
+
+		if (error && error != -EEXIST)
 			return error;
 
 		cpio_chown(ctx->collected, ctx->uid, ctx->gid, 0);
@@ -438,7 +442,7 @@ static int __init do_name(struct cpio_context *ctx)
 	return 0;
 }
 
-static int __init do_copy(struct cpio_context *ctx)
+static int __cpio do_copy(struct cpio_context *ctx)
 {
 	int ret;
 
@@ -468,7 +472,7 @@ static int __init do_copy(struct cpio_context *ctx)
 	return 1;
 }
 
-static int __init do_symlink(struct cpio_context *ctx)
+static int __cpio do_symlink(struct cpio_context *ctx)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -497,7 +501,7 @@ static int __init do_symlink(struct cpio_context *ctx)
 	return 0;
 }
 
-static __initdata int (*actions[])(struct cpio_context *) = {
+static __cpiodata int (*actions[])(struct cpio_context *) = {
 	[CPIO_START]		= do_start,
 	[CPIO_COLLECT]		= do_collect,
 	[CPIO_GOTHEADER]	= do_header,
@@ -508,7 +512,7 @@ static __initdata int (*actions[])(struct cpio_context *) = {
 	[CPIO_RESET]		= do_reset,
 };
 
-long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
+long __cpio cpio_write_buffer(struct cpio_context *ctx, char *buf,
 			      unsigned long len)
 {
 	int ret;
@@ -526,7 +530,7 @@ long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
 		return len - ctx->byte_count;
 }
 
-long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
+long __cpio cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 				unsigned long len)
 {
 	char *buf = (char *)bufv;
@@ -557,7 +561,7 @@ long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 	return len;
 }
 
-int __init cpio_start(struct cpio_context *ctx)
+int __cpio cpio_start(struct cpio_context *ctx)
 {
 	ctx->header_buf = kmalloc(110, GFP_KERNEL);
 	ctx->symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
@@ -573,7 +577,7 @@ int __init cpio_start(struct cpio_context *ctx)
 	return 0;
 }
 
-void __init cpio_finish(struct cpio_context *ctx)
+void __cpio cpio_finish(struct cpio_context *ctx)
 {
 	dir_utime(ctx);
 	kfree(ctx->name_buf);
-- 
2.36.1
