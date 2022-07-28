Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941635840A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiG1OKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiG1OJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:09:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A165650;
        Thu, 28 Jul 2022 07:09:34 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SAlHgU000921;
        Thu, 28 Jul 2022 07:09:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=d7rtdrLnuw6c0rXZn1h6CU3mT+PfQNaZdzxmBwpNA2s=;
 b=G6BOyJ4GTpRsqK5CPXcHJfIz8CW0lF2RzFlGqQ0lGztPb8iDk91sv5Lsy8wTwiFiVIOW
 FjRv2bMrDG84wRXWpJecsLgEet+KUF7/whRMZZ+Kgl2Y0w6wno6pE/6TNTs9OTlJ3Esd
 YjU93Fluy9pPIVTzEeVPovlejwYWh067OJg= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hks0ps3aa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:09:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUtUzeBYjIgb3DGZLfzxI+9M9PlRGOmk4mUyfFcEuD/KvLSokoWTw/Ju0pYSOfIS3NXL1X71XMrXvZd859naULj73WAKTMpqJatiMKUNyjnt+tcu6w//oxHm8V6s33Tv2MFUxG/LlNzSZ1zb1capcsqzjCcYkWWL8VROu3rIPkcSfCDGwZzLRJIxiL9bWt1jqgCrZ6PujIlG130qJ29dF8b8allVhlNeHaSEA7zSon8XcMcfPSI6qk1KGAd/AkbMF2NlW9l6aKwY2Ktc6lfqWdFvAVLiLsK5zGf+njNl4cC2HQDkbzPAocWudXnurSo5ssKEbo6yDCHQO7KTPKinxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7rtdrLnuw6c0rXZn1h6CU3mT+PfQNaZdzxmBwpNA2s=;
 b=P4NTGT4hY2v19UQJlbo/bB32ArQOWGXLCShdX2b2X9oT8R6mqMRLIL8g9GuRY9L6n1D8gCLfD79JDBR/Rp4Et+fK7hxJ6CGClRtWHqqpo0jlRMB81j1Z8iM7MWqsWtF58FndQ/BPzGOGd5Yc404KtrMNdOv7At3DNCKZgOJ523dl4FMMsRyvzPPFmvgVdSbFWMhCUrGu+npYeMb5JucAouhvZaHM9gdlicarkEtuxYBUWZURyIKQLlEk/Y70gxHYZgviNMDLyCbus6PUsY6wC3megiTYuR/bi0sfhv4j2K6cIUr8ofYmWpifYtvTcJ7GC/OVzpugHLmqWYHMK01Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB3247.namprd15.prod.outlook.com (2603:10b6:208:3a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:09:30 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 14:09:30 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH v2 4/7] lib/cpio: Allow use outside of initramfs creation
Thread-Topic: [RFC PATCH v2 4/7] lib/cpio: Allow use outside of initramfs
 creation
Thread-Index: AQHYoounBlqU8+fP1UiT63PdDmCcnA==
Date:   Thu, 28 Jul 2022 14:09:30 +0000
Message-ID: <187b606266722c4df9ecfb1b5d5892a17c45575a.1659003817.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
 <cover.1659003817.git.noodles@fb.com>
In-Reply-To: <cover.1659003817.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32f97a5b-0e5a-4adb-19e0-08da70a2c9f6
x-ms-traffictypediagnostic: MN2PR15MB3247:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTi5Eg/5xFEB8bqorSWwCv9ona0Pp4LdOhSvL28OetzvfT6xbB+nSaKK7CULtmLIMescbbUYdyW7au4MVEVCHgAADrT52YQkbPGjltWzFUb79EsnU/W8/qcVVrVKnvBH/gBz2322kNUFC9uXA8JhA+pAaLe87xhKA0xwPRZaGXsFYOztGyxfCYTxTVb4jYlCMS9/Za9KZv9qt8jE8d8ec5OblCKi5T6ecGuVzlythzYdbrTExD8KvI7c6PFGS2x08WzIHgC1XaVIRdv/oqTw8b1flcgc2Z8i/Kms+t41UVgJ7tmZqAH1mhYRlQG8C76JB0JAiKbKzW/tNKHF7D1QQL64ew98gSa2JVcmO0JUiplwuLF9beLUVDBmk468qB/nfI9AZ3YxVR3FIBuQv8BRIdNYlX1Q6T9pS9VqJA5VCYmdyZr4tka9uX05a8lXzl3DT3AKlDJIPMvhraAYmtVcmi46X12ozeU2Wq74XZUUYRMwryCjrDi3hNGLOBSrX57VXbWy7/tTuk3D2+TKB7iKXEq9EGaasb0bqvmZZuD2O4IvoBgm8TQjL+Z70cMUGp1BTKOLKQZQjwLtOgfeV02jkZodgQyECIiJ4N972Ap00Kd3iu2hbXKuk0I2gnMx1VPJENATW8OKb29LZhLxNI4LTVgldcWBxw8Hi8aZiqeSj4xONlMVQc6uTpPKW3qAVYypmIvJjGD3YS0q9+Yxp7d63jEv5HxWC0qIyPx8PD+w4kr5b8UDFdfV5yPK7nGwYp/sZNq0IVtDWcZWv81v7NhSALM7YzQ0fAZrnAeNCFTbr+wVt1+ZdQzqIDqln2Z/+DLF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(6506007)(54906003)(7416002)(122000001)(186003)(83380400001)(478600001)(71200400001)(38100700002)(6486002)(41300700001)(6512007)(91956017)(66556008)(66446008)(8676002)(26005)(2616005)(66946007)(5660300002)(4326008)(110136005)(38070700005)(36756003)(76116006)(66476007)(64756008)(316002)(2906002)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zpf3C3k6cCEExaqIcMFrYTuFQwzntVFzV9ffI3phm2mB9Un1ARlQOw0vHm98?=
 =?us-ascii?Q?IafyP80B6T5cd5l3FC8y2h65X8KIEhsvvzBkOHBlz7mAq3LV+vIJaMNWGxXu?=
 =?us-ascii?Q?Jz5Kl3hNKJrF61Psumg+UchDqM+dqh1lNm3uMHGJuz1SyXLmhuLI5b/9+B2f?=
 =?us-ascii?Q?uW2xaGsDlAhYFYXwofxpwKLlRJblWMgwUYKjuiqxm/IZ8PeiNWcAbHJaEnTc?=
 =?us-ascii?Q?ew/aCaYbhSf63QMfeEq6vrg4kdgNZkbOFtPyESw9S3pSnJ3DLxmQE9kYB1Gu?=
 =?us-ascii?Q?hSgJQO9xgyGBivdxIW3e1xjBMibTQeiUdE9oRvSawICf8jfcPW94+sxnDdTy?=
 =?us-ascii?Q?RamfzLqnMUImtZqpMXgWzlNhOxHMZ98ySrym6CkGjhhadjlcbxX5onABDX9D?=
 =?us-ascii?Q?pe3uDcg09CyJ5afCv9pjKqLEWwfNfl9DqCWjGaoYTBLYvOz3fHwbySTsVjAP?=
 =?us-ascii?Q?vJyXlHj04gcQn3HXA6/eMqUL+afkbM1BTzFeC664f75XfD05IaXIoqRIXDQE?=
 =?us-ascii?Q?Ws8/l4r7gHvYnd41Dh2/70BXQJqfCnM3tc7LRhI2dIYyGQHjJ7YD+Uk9DbSs?=
 =?us-ascii?Q?YhF8FaydXie26LGQJhPhKj+kDs9IsEOY03TMg940pBi9H8VtIqdMW4iF35lI?=
 =?us-ascii?Q?s6h8zzn2GpWOxufsGb0Wm7LcBsoBQmI3cYDlObQlLB10G66diP27XCJ9NwU8?=
 =?us-ascii?Q?7UlmqqCX/wOxvikzBd2e6AWDzkqYEoxidfkqhno2MNeTps5sp7De0eJVc+A0?=
 =?us-ascii?Q?PwbqOY56LqP0FBeHX2AQKUX967S5fgwfgYyq0WApoVa5rs3QTjaHhmsmeGZ3?=
 =?us-ascii?Q?5kuaOa53blntdZ/HAioml30ifjrjBUyr7kkeolFsh/NlQvEpNxb2z9IieJ+K?=
 =?us-ascii?Q?ATbnb2Dj/cXTH191dI6DFoZrndN44Yk/BN/Ooj4/3ppHuhWlqadGUjYTjZQU?=
 =?us-ascii?Q?EV/lHsN2dGAUl98SYAS96E8nuJXdq53QiUh1hZ7OW9gZCPgvsK+j4EcFn1W8?=
 =?us-ascii?Q?noTfTjzuFBTFsf2D9zuHa/ptUOZKFA34SLcWrnMXErCxipBE+ZWBLnv5ogic?=
 =?us-ascii?Q?d5H8JD8EX9IMqNyMcw4SglvUfFsLEhmZeEenvQxlY434f9qtwKA/oV2fcQcd?=
 =?us-ascii?Q?qQFFoo2VCARwFLXdaPU3zvJcoRp7BsELerEWx1XooNVVigOKe+iv1BNgPLvD?=
 =?us-ascii?Q?nHBGHQKnqhA3ch5FSomEX0TNe4hFgc0u8rYXVrX/vlrZz1HF0o+Q9X9FiwHg?=
 =?us-ascii?Q?24Us/kByat4pMzB2ljYNS+6uSyfR16n+cBoo3oznU7Uq/h0SbxUltLJCPgGB?=
 =?us-ascii?Q?dlfVgAKQZar4oBCzxKc+pmBB4nzTdoCA8eW7qR6GXDN2r6jRyHSzkBIRlUR9?=
 =?us-ascii?Q?6rDHlb8bP57JuWS0reQ1F6tPz2CegYviEB67/vM1VqtcnX+UgdkhjC+aJxaj?=
 =?us-ascii?Q?PSx4Qtw7sfxaexFBUb94JkoYvgzCLH1yz9Qyg5CIUvuzHaeIBo+USRwlUI0h?=
 =?us-ascii?Q?gZFUb/2V3QJrjKqBKVRFgTtYTf1dSawUnnZa22JZsb5/mH0dMcn9c+TrHkWC?=
 =?us-ascii?Q?aoCnTGZ5WFZKG1Um8QN4KPsR6CxqMhlwOw8o9Y1H?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3BFB9A1D09458642AE85F797DAE62C36@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f97a5b-0e5a-4adb-19e0-08da70a2c9f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:09:30.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsJPiHym66/Th+kSi9Jo9MEFU5tvh9/37b3WKg4BjXf7FDWYWrBiY2jmK2u8GuhS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3247
X-Proofpoint-GUID: LloWI6nYaOJ3zhE4dFnD5aAbec7yqwEm
X-Proofpoint-ORIG-GUID: LloWI6nYaOJ3zhE4dFnD5aAbec7yqwEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_05,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
v2:
- Move directory EEXIST checking to patch 3
---
 include/linux/cpio.h | 20 ++++++++++++---
 lib/Kconfig          |  3 +++
 lib/cpio.c           | 60 ++++++++++++++++++++++----------------------
 3 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
index 69a15fffa5c6..7e9888e6a1ad 100644
--- a/include/linux/cpio.h
+++ b/include/linux/cpio.h
@@ -12,6 +12,18 @@
 
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
@@ -68,11 +80,11 @@ struct cpio_context {
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
index 9a0120c638db..03967e063c76 100644
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
@@ -444,7 +444,7 @@ static int __init do_name(struct cpio_context *ctx)
 	return 0;
 }
 
-static int __init do_copy(struct cpio_context *ctx)
+static int __cpio do_copy(struct cpio_context *ctx)
 {
 	int ret;
 
@@ -474,7 +474,7 @@ static int __init do_copy(struct cpio_context *ctx)
 	return 1;
 }
 
-static int __init do_symlink(struct cpio_context *ctx)
+static int __cpio do_symlink(struct cpio_context *ctx)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -503,7 +503,7 @@ static int __init do_symlink(struct cpio_context *ctx)
 	return 0;
 }
 
-static __initdata int (*actions[])(struct cpio_context *) = {
+static __cpiodata int (*actions[])(struct cpio_context *) = {
 	[CPIO_START]		= do_start,
 	[CPIO_COLLECT]		= do_collect,
 	[CPIO_GOTHEADER]	= do_header,
@@ -514,7 +514,7 @@ static __initdata int (*actions[])(struct cpio_context *) = {
 	[CPIO_RESET]		= do_reset,
 };
 
-long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
+long __cpio cpio_write_buffer(struct cpio_context *ctx, char *buf,
 			      unsigned long len)
 {
 	int ret;
@@ -532,7 +532,7 @@ long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
 		return len - ctx->byte_count;
 }
 
-long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
+long __cpio cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 				unsigned long len)
 {
 	char *buf = (char *)bufv;
@@ -563,7 +563,7 @@ long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 	return len;
 }
 
-int __init cpio_start(struct cpio_context *ctx)
+int __cpio cpio_start(struct cpio_context *ctx)
 {
 	ctx->header_buf = kmalloc(110, GFP_KERNEL);
 	ctx->symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
@@ -579,7 +579,7 @@ int __init cpio_start(struct cpio_context *ctx)
 	return 0;
 }
 
-void __init cpio_finish(struct cpio_context *ctx)
+void __cpio cpio_finish(struct cpio_context *ctx)
 {
 	dir_utime(ctx);
 	kfree(ctx->name_buf);
-- 
2.30.2
