Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C958409C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiG1OJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiG1OJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:09:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2539020F7E;
        Thu, 28 Jul 2022 07:09:12 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SA39HK028393;
        Thu, 28 Jul 2022 07:09:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=TRQxI525O1sONmlMXp0vyGKZgiWiTs/6ZhGBzp1JYFk=;
 b=YE69gdOqMAUH7x8lFK/s0+B2obq61PCUWYtl9lz0FeA0+592jsdpEWo9jMUZQwEWzBI4
 QHOfCPaxsVGJPYrvWarzfZYfkCxaez73UR4QI7Vo7SoyCwPGEXGEEqQ970YNM/LGTAVv
 10/Fs432cTI5X9LtuHDUqlsvNZZSsoHE6Fs= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkfsk3kc9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFb44V//Ko2bGSIYmBuZp6s+NsCNiVk42zOkXp11PF7xWvcxoJjlbsGIldnWtT0Dz0lfJUHsEdYE5TMs/vPYKO+VUVHvkL6UOuWAu7haHExRm2CdJyui504JRYHnRESPGbPiFTHv/Px41tc+JkgwtYu1Wng78yZvHIQpsVnXQZLB4Dt2iE7N4nlVxq5ycECcapa6uO4mm/IXyvj3mFaYp+BeTH0mN/eoQK4NPeq31jUheH69Wq0FC2yVtIDDDzs8zcgLLUHSg1BIpBz13BYuTnL/hxykmJKnyG9N8c5MQNnv2wtbl/cdIHgVLD2E6Sj68zxHbFE9KWfmMDg4MGA/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRQxI525O1sONmlMXp0vyGKZgiWiTs/6ZhGBzp1JYFk=;
 b=n4FjrGbVNNkZPRN9LC97HM8WXRtyoD/Un9MEbTkGUchHYlveLtQTvDWGvDcQha4s8nZkqNbwp+DQkQEAD36A1owHA6yXhokr8r9T73n47lo+KgnEdZX1VvatCuRUXapjtFmYmJXPnjEqiXfQulmr3RcdMxfEoP/RJRQp75UFnzJ+OSZ07Wf1DvLDImcO+orc6fz9gii5Ns3rtFvpXgYl8dWUyEBU47CR+BjXp3CytQnhhlBNjHXwM+H70ghwnaN4ioavEUGuM8P7zoZW1vijSVmNO6R7rx1FEdSUm4Xfb+qljWZKcmFebyro6SztPpIXknggpYQ0UD+59dLCEDk9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB4256.namprd15.prod.outlook.com (2603:10b6:208:fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:09:04 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 14:09:04 +0000
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
Subject: [RFC PATCH v2 1/7] initramfs: Move cpio handling routines into lib/
Thread-Topic: [RFC PATCH v2 1/7] initramfs: Move cpio handling routines into
 lib/
Thread-Index: AQHYoouYmGug1fd2iUm/OP4sgeIyNQ==
Date:   Thu, 28 Jul 2022 14:09:04 +0000
Message-ID: <bbf0513a72c6f7e06dea38b04a606a3e739ce82d.1659003817.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
 <cover.1659003817.git.noodles@fb.com>
In-Reply-To: <cover.1659003817.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03cddf9b-4942-4ea8-57ee-08da70a2ba89
x-ms-traffictypediagnostic: MN2PR15MB4256:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gug2OU3P/Qk9Q/y0boy28pagmwhJo7s7ohPpupszW9bN2p1fbSsnh0ffCXqGjq7bYJZ1Ko30pvfu5WrnzAXfgszP2aVa/fAXDVd8tchBZdsNWywlWkIMLKYtqXJq0mFWRNuWFXmFewB2OpUjg3uVGPv3D76uHUHo8Xs7BQ6UNNX5SeRLu85T9YSH34PsYNhOXQ6ksOwUCBZQUyiRwEt0J/RtIgQvnk4zyfdZ6pk68WIh97zw/OduPVUS7neeOi5Ta42tVupJOv3opbP5FIVQ9/74dYBY1M4v3HU56+VEItPoMJHuhSurkKYmddalASnWMV0vgfHUmXzEaJK/ZcEtGfbvn3pTVmhe+ITdlu01nsRHvz4dRdeBfrT6V/WBtQp144YGNcH9Ld9p0+wFHC+jdl9gkemfp/cvO+/V8wtiFccisk9ErWsjNIk8vg7sWZBpXw5oDDJb4EJh/y7rgpDfEWWQ1TovZ+QM7+/rsx8S1P8dUOsLFu4wt0K51eszin70qFLtTVNHl3yqqmvm1QXyw1CF5gwqANd/2DecpgtdivXhXB6fO8bagi3Z/DwA8V9QoLsZ6ZsCupkZASmUgTQgAPnLOeUmvlQLhwX+aasLGz9spI2tWwyLVtCpVnqennfo81X6BPo8ll0AcpQWAGgxcJQ46B3jq2s6f9HNRGKV+95K5mHkTRP+zsj7CN8AMcIZOLr6C0yEgizJX1diWxukQUILVLm6YI8GDsC5NYLZkXZRrNs2JpMwQgISTIemT44ibt+C6j64oWSLuGaThWe6YmVDniFuPps4/+Rg8e/ubb/N16qAXUXp7MDTg5CZ1p4T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(7416002)(2616005)(2906002)(478600001)(122000001)(41300700001)(6506007)(86362001)(316002)(36756003)(186003)(30864003)(5660300002)(38070700005)(38100700002)(66476007)(4326008)(83380400001)(6486002)(6512007)(91956017)(110136005)(54906003)(26005)(71200400001)(76116006)(66946007)(8676002)(8936002)(64756008)(66556008)(66446008)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VP2uvNI2Vi5pFRgG0UKjUIX26lh6THbgOItmlaZgAlTpurbxBPg0XWkyp7ht?=
 =?us-ascii?Q?tLI7ri21soGsgaCXy1TFZ31jAyWJ0y2fbsb6hOGlDOl/chgW+Vggg/XJCbQv?=
 =?us-ascii?Q?MpqIdGnTIzB1otw+ORU+NLr4JA85b7+8H0kWRi3pr4r09skCdeLS1EGRSnnQ?=
 =?us-ascii?Q?v1neHn7Zapv5xB0p9Rc1mrgl4AI5g1b0jZvgV8qtwWTtdf0nDvkIh0d2PoXg?=
 =?us-ascii?Q?zsX6CExM9GI1REsU0s7zcmmVpeK4hwllM2fAi6DKl0+VPT8hBr7w2qWS+/eN?=
 =?us-ascii?Q?IKobVADGA8DlUjpnpDn7mGS6HIpYbGIc/YOlBkpdXAKZ+qei4cq0t0yw1ghc?=
 =?us-ascii?Q?A8uDK/Fq6XoqI87eg/HXORmIRdyabEtSRkKHnSomGeTZhPSS6RIbuik3+5Jz?=
 =?us-ascii?Q?vd3dh0334U52uqlqD2j15t/YiSZatAMF1+SQ4mXEqPGD0mkepxToe2cmIVjt?=
 =?us-ascii?Q?zkYWNxf901usgr2SlJjZbNv3WM1j4GC+j9SSaZxqtE4V44kANohmLLNMk8NY?=
 =?us-ascii?Q?7lrx7QFrr9tbxvhXeIrBayy3Qd1sn4EdC4trrbHcjgpPn7czu4S0PLpgLped?=
 =?us-ascii?Q?luq3EBiG545ppTTKK4G9KwbkVMXqxaCG3GMLOfVf0CJywr+1cTxMRwPBYZVi?=
 =?us-ascii?Q?ZZ1Qkk0WxfKLTSiQXA3YuXveRUPvie/ug1R7xA4TUFkCVBuSRfntllWmKlFD?=
 =?us-ascii?Q?Lekmujd3GVIYtRA4n2qhTyvGWdk06Toxrio8s5mkiMacG8xtYL599lGyMauD?=
 =?us-ascii?Q?jaUsqhFt7xcj+vNtJuPQP7zb6xHl9fkkaHgpjV6JOPSGUVxdeUYfaY/RTrVr?=
 =?us-ascii?Q?qpvkQCZvlSJiNT3URZvNTnzPhPsE6HXB939HJCJO9EMNx8W4YnCJYhir7qhH?=
 =?us-ascii?Q?1XsBjq0h+NBOBWeJ7tPvdf/NMhk+h3/pHDpbJ226VuUex3KGr/n56eyASuAE?=
 =?us-ascii?Q?unvGepaAOYsuxDLdWpauqh+aP55LG4FQ87eZYEotYADYiukFrDVu62KMTsBs?=
 =?us-ascii?Q?c9r77EshphFuEy+U87nHDBxhjkJWQubbDlpCti/L5OXWGikc8c/lhCRnXXSk?=
 =?us-ascii?Q?44skodl7ZmYUtche26eRoIpOsLM0UmiP0kUO5sGM5hqJfzrh2y/3pQAb5Ly0?=
 =?us-ascii?Q?LzuN9kEsDM2u949B7T9qIJF1mjUZC1JiJuyTht1okLFTwR8KXzsJ3Z3IHCAy?=
 =?us-ascii?Q?b9t6XWSQO16Tm+pqRjI5rKae0BbfRNYKt7BSrU+cTJe0L7KvYjmAbnhDcOb+?=
 =?us-ascii?Q?AdIr2CnOdqiJfqMrEGpVX5hBpPscilO7hxVG5JzCHlCZDJR6/Re1qUL5cBM3?=
 =?us-ascii?Q?SvmkrKeOPowahHjvrmjedoWSN9a32/RYX3iu1Yk7J6oequ7nZDAPX08kpjdg?=
 =?us-ascii?Q?r4Ue/gcmNzwQfaPGUBO9qQC2Fp1V8IwuqbJR3LwoAQ/0SRYG0Ol+b/sM1W/Z?=
 =?us-ascii?Q?37YUvVGOgemzwmrQvZ/oazkJxZ457ZabqZ0OX/4DVfSTUhYNWWsDQS8Z1iYY?=
 =?us-ascii?Q?4OJOBHnUNgSGxpBHVlmhJnDiLQiuJgwXdwa1liIYeAA52dT2u7udmOTmq/tI?=
 =?us-ascii?Q?wCxAfghtbKaqVttDpATkltxyCJ6DKQPHYoQYJrIC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2118936A27D66648B667D6D212945885@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cddf9b-4942-4ea8-57ee-08da70a2ba89
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:09:04.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cs6M/irsHavNSuKcjZ/lngF7rJrHn8m1/uVPZ0FyqE3aX0JOVfHRBgYGxN51S+RW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4256
X-Proofpoint-GUID: lEf015fXqgCGuSEtYHojfkWyWp_XTlUG
X-Proofpoint-ORIG-GUID: lEf015fXqgCGuSEtYHojfkWyWp_XTlUG
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

The cpio handling routines can be useful outside of just initialising
the initramfs. Pull the functions into lib/ and all of the static state
into a context structure in preparation for enabling the use of this
functionality outside of __init code.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
v2:
- Fix printf format string in populate_initrd_image (kernel test robot, i386 build)
- Include <linux/limits.h> in cpio.h (kernel test robot, uml build)
---
 include/linux/cpio.h |  79 +++++++
 init/initramfs.c     | 518 ++++---------------------------------------
 lib/Makefile         |   2 +-
 lib/cpio.c           | 454 +++++++++++++++++++++++++++++++++++++
 4 files changed, 579 insertions(+), 474 deletions(-)
 create mode 100644 include/linux/cpio.h
 create mode 100644 lib/cpio.c

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
new file mode 100644
index 000000000000..2f9fd735331e
--- /dev/null
+++ b/include/linux/cpio.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CPIO_H
+#define _LINUX_CPIO_H
+
+#include <linux/init.h>
+#include <linux/limits.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+/* Must be a power of 2 */
+#define CPIO_LINK_HASH_SIZE	32
+
+#define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
+
+enum cpio_state {
+	CPIO_START,
+	CPIO_COLLECT,
+	CPIO_GOTHEADER,
+	CPIO_SKIPIT,
+	CPIO_GOTNAME,
+	CPIO_COPYFILE,
+	CPIO_GOTSYMLINK,
+	CPIO_RESET
+};
+
+struct cpio_dir_entry {
+	struct list_head list;
+	time64_t mtime;
+	char name[];
+};
+
+struct cpio_link_hash {
+	int ino, minor, major;
+	umode_t mode;
+	struct cpio_link_hash *next;
+	char name[N_ALIGN(PATH_MAX)];
+};
+
+struct cpio_context {
+	enum cpio_state state, next_state;
+	char *header_buf, *symlink_buf, *name_buf;
+	loff_t this_header, next_header;
+	char *victim;
+	unsigned long byte_count;
+	bool csum_present;
+	u32 io_csum;
+	char *errmsg;
+
+	char *collected;
+	long remains;
+	char *collect;
+
+	struct file *wfile;
+	loff_t wfile_pos;
+
+	/* Header fields */
+	unsigned long ino, major, minor, nlink;
+	umode_t mode;
+	unsigned long body_len, name_len;
+	uid_t uid;
+	gid_t gid;
+	unsigned int rdev;
+	u32 hdr_csum;
+	time64_t mtime;
+
+	/* Link hash */
+	struct cpio_link_hash *link_hash[CPIO_LINK_HASH_SIZE];
+
+	struct list_head dir_list;
+};
+
+int __init cpio_start(struct cpio_context *ctx);
+void __init cpio_finish(struct cpio_context *ctx);
+long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
+			      unsigned long len);
+long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
+				unsigned long len);
+
+#endif /* _LINUX_CPIO_H */
diff --git a/init/initramfs.c b/init/initramfs.c
index 18229cfe8906..00c101d04f4b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
 #include <linux/async.h>
-#include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
@@ -14,43 +13,9 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
-#include <linux/init_syscalls.h>
 #include <linux/task_work.h>
 #include <linux/umh.h>
-
-static __initdata bool csum_present;
-static __initdata u32 io_csum;
-
-static ssize_t __init xwrite(struct file *file, const unsigned char *p,
-		size_t count, loff_t *pos)
-{
-	ssize_t out = 0;
-
-	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
-	while (count) {
-		ssize_t rv = kernel_write(file, p, count, pos);
-
-		if (rv < 0) {
-			if (rv == -EINTR || rv == -EAGAIN)
-				continue;
-			return out ? out : rv;
-		} else if (rv == 0)
-			break;
-
-		if (csum_present) {
-			ssize_t i;
-
-			for (i = 0; i < rv; i++)
-				io_csum += p[i];
-		}
-
-		p += rv;
-		out += rv;
-		count -= rv;
-	}
-
-	return out;
-}
+#include <linux/cpio.h>
 
 static __initdata char *message;
 static void __init error(char *x)
@@ -69,423 +34,17 @@ static void panic_show_mem(const char *fmt, ...)
 	va_end(args);
 }
 
-/* link hash */
-
-#define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
-
-static __initdata struct hash {
-	int ino, minor, major;
-	umode_t mode;
-	struct hash *next;
-	char name[N_ALIGN(PATH_MAX)];
-} *head[32];
-
-static inline int hash(int major, int minor, int ino)
-{
-	unsigned long tmp = ino + minor + (major << 3);
-	tmp += tmp >> 5;
-	return tmp & 31;
-}
-
-static char __init *find_link(int major, int minor, int ino,
-			      umode_t mode, char *name)
-{
-	struct hash **p, *q;
-	for (p = head + hash(major, minor, ino); *p; p = &(*p)->next) {
-		if ((*p)->ino != ino)
-			continue;
-		if ((*p)->minor != minor)
-			continue;
-		if ((*p)->major != major)
-			continue;
-		if (((*p)->mode ^ mode) & S_IFMT)
-			continue;
-		return (*p)->name;
-	}
-	q = kmalloc(sizeof(struct hash), GFP_KERNEL);
-	if (!q)
-		panic_show_mem("can't allocate link hash entry");
-	q->major = major;
-	q->minor = minor;
-	q->ino = ino;
-	q->mode = mode;
-	strcpy(q->name, name);
-	q->next = NULL;
-	*p = q;
-	return NULL;
-}
-
-static void __init free_hash(void)
-{
-	struct hash **p, *q;
-	for (p = head; p < head + 32; p++) {
-		while (*p) {
-			q = *p;
-			*p = q->next;
-			kfree(q);
-		}
-	}
-}
-
-#ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
-static void __init do_utime(char *filename, time64_t mtime)
-{
-	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
-	init_utimes(filename, t);
-}
-
-static void __init do_utime_path(const struct path *path, time64_t mtime)
-{
-	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
-	vfs_utimes(path, t);
-}
-
-static __initdata LIST_HEAD(dir_list);
-struct dir_entry {
-	struct list_head list;
-	time64_t mtime;
-	char name[];
-};
-
-static void __init dir_add(const char *name, time64_t mtime)
-{
-	size_t nlen = strlen(name) + 1;
-	struct dir_entry *de;
-
-	de = kmalloc(sizeof(struct dir_entry) + nlen, GFP_KERNEL);
-	if (!de)
-		panic_show_mem("can't allocate dir_entry buffer");
-	INIT_LIST_HEAD(&de->list);
-	strscpy(de->name, name, nlen);
-	de->mtime = mtime;
-	list_add(&de->list, &dir_list);
-}
-
-static void __init dir_utime(void)
-{
-	struct dir_entry *de, *tmp;
-	list_for_each_entry_safe(de, tmp, &dir_list, list) {
-		list_del(&de->list);
-		do_utime(de->name, de->mtime);
-		kfree(de);
-	}
-}
-#else
-static void __init do_utime(char *filename, time64_t mtime) {}
-static void __init do_utime_path(const struct path *path, time64_t mtime) {}
-static void __init dir_add(const char *name, time64_t mtime) {}
-static void __init dir_utime(void) {}
-#endif
-
-static __initdata time64_t mtime;
-
-/* cpio header parsing */
-
-static __initdata unsigned long ino, major, minor, nlink;
-static __initdata umode_t mode;
-static __initdata unsigned long body_len, name_len;
-static __initdata uid_t uid;
-static __initdata gid_t gid;
-static __initdata unsigned rdev;
-static __initdata u32 hdr_csum;
-
-static void __init parse_header(char *s)
-{
-	unsigned long parsed[13];
-	char buf[9];
-	int i;
-
-	buf[8] = '\0';
-	for (i = 0, s += 6; i < 13; i++, s += 8) {
-		memcpy(buf, s, 8);
-		parsed[i] = simple_strtoul(buf, NULL, 16);
-	}
-	ino = parsed[0];
-	mode = parsed[1];
-	uid = parsed[2];
-	gid = parsed[3];
-	nlink = parsed[4];
-	mtime = parsed[5]; /* breaks in y2106 */
-	body_len = parsed[6];
-	major = parsed[7];
-	minor = parsed[8];
-	rdev = new_encode_dev(MKDEV(parsed[9], parsed[10]));
-	name_len = parsed[11];
-	hdr_csum = parsed[12];
-}
-
-/* FSM */
-
-static __initdata enum state {
-	Start,
-	Collect,
-	GotHeader,
-	SkipIt,
-	GotName,
-	CopyFile,
-	GotSymlink,
-	Reset
-} state, next_state;
-
-static __initdata char *victim;
-static unsigned long byte_count __initdata;
-static __initdata loff_t this_header, next_header;
-
-static inline void __init eat(unsigned n)
-{
-	victim += n;
-	this_header += n;
-	byte_count -= n;
-}
-
-static __initdata char *collected;
-static long remains __initdata;
-static __initdata char *collect;
-
-static void __init read_into(char *buf, unsigned size, enum state next)
-{
-	if (byte_count >= size) {
-		collected = victim;
-		eat(size);
-		state = next;
-	} else {
-		collect = collected = buf;
-		remains = size;
-		next_state = next;
-		state = Collect;
-	}
-}
-
-static __initdata char *header_buf, *symlink_buf, *name_buf;
-
-static int __init do_start(void)
-{
-	read_into(header_buf, 110, GotHeader);
-	return 0;
-}
-
-static int __init do_collect(void)
-{
-	unsigned long n = remains;
-	if (byte_count < n)
-		n = byte_count;
-	memcpy(collect, victim, n);
-	eat(n);
-	collect += n;
-	if ((remains -= n) != 0)
-		return 1;
-	state = next_state;
-	return 0;
-}
-
-static int __init do_header(void)
-{
-	if (!memcmp(collected, "070701", 6)) {
-		csum_present = false;
-	} else if (!memcmp(collected, "070702", 6)) {
-		csum_present = true;
-	} else {
-		if (memcmp(collected, "070707", 6) == 0)
-			error("incorrect cpio method used: use -H newc option");
-		else
-			error("no cpio magic");
-		return 1;
-	}
-	parse_header(collected);
-	next_header = this_header + N_ALIGN(name_len) + body_len;
-	next_header = (next_header + 3) & ~3;
-	state = SkipIt;
-	if (name_len <= 0 || name_len > PATH_MAX)
-		return 0;
-	if (S_ISLNK(mode)) {
-		if (body_len > PATH_MAX)
-			return 0;
-		collect = collected = symlink_buf;
-		remains = N_ALIGN(name_len) + body_len;
-		next_state = GotSymlink;
-		state = Collect;
-		return 0;
-	}
-	if (S_ISREG(mode) || !body_len)
-		read_into(name_buf, N_ALIGN(name_len), GotName);
-	return 0;
-}
-
-static int __init do_skip(void)
-{
-	if (this_header + byte_count < next_header) {
-		eat(byte_count);
-		return 1;
-	} else {
-		eat(next_header - this_header);
-		state = next_state;
-		return 0;
-	}
-}
-
-static int __init do_reset(void)
-{
-	while (byte_count && *victim == '\0')
-		eat(1);
-	if (byte_count && (this_header & 3))
-		error("broken padding");
-	return 1;
-}
-
-static void __init clean_path(char *path, umode_t fmode)
-{
-	struct kstat st;
-
-	if (!init_stat(path, &st, AT_SYMLINK_NOFOLLOW) &&
-	    (st.mode ^ fmode) & S_IFMT) {
-		if (S_ISDIR(st.mode))
-			init_rmdir(path);
-		else
-			init_unlink(path);
-	}
-}
-
-static int __init maybe_link(void)
-{
-	if (nlink >= 2) {
-		char *old = find_link(major, minor, ino, mode, collected);
-		if (old) {
-			clean_path(collected, 0);
-			return (init_link(old, collected) < 0) ? -1 : 1;
-		}
-	}
-	return 0;
-}
-
-static __initdata struct file *wfile;
-static __initdata loff_t wfile_pos;
-
-static int __init do_name(void)
-{
-	state = SkipIt;
-	next_state = Reset;
-	if (strcmp(collected, "TRAILER!!!") == 0) {
-		free_hash();
-		return 0;
-	}
-	clean_path(collected, mode);
-	if (S_ISREG(mode)) {
-		int ml = maybe_link();
-		if (ml >= 0) {
-			int openflags = O_WRONLY|O_CREAT;
-			if (ml != 1)
-				openflags |= O_TRUNC;
-			wfile = filp_open(collected, openflags, mode);
-			if (IS_ERR(wfile))
-				return 0;
-			wfile_pos = 0;
-			io_csum = 0;
-
-			vfs_fchown(wfile, uid, gid);
-			vfs_fchmod(wfile, mode);
-			if (body_len)
-				vfs_truncate(&wfile->f_path, body_len);
-			state = CopyFile;
-		}
-	} else if (S_ISDIR(mode)) {
-		init_mkdir(collected, mode);
-		init_chown(collected, uid, gid, 0);
-		init_chmod(collected, mode);
-		dir_add(collected, mtime);
-	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
-		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
-		if (maybe_link() == 0) {
-			init_mknod(collected, mode, rdev);
-			init_chown(collected, uid, gid, 0);
-			init_chmod(collected, mode);
-			do_utime(collected, mtime);
-		}
-	}
-	return 0;
-}
+static unsigned long my_inptr; /* index of next byte to be processed in inbuf */
 
-static int __init do_copy(void)
-{
-	if (byte_count >= body_len) {
-		if (xwrite(wfile, victim, body_len, &wfile_pos) != body_len)
-			error("write error");
-
-		do_utime_path(&wfile->f_path, mtime);
-		fput(wfile);
-		if (csum_present && io_csum != hdr_csum)
-			error("bad data checksum");
-		eat(body_len);
-		state = SkipIt;
-		return 0;
-	} else {
-		if (xwrite(wfile, victim, byte_count, &wfile_pos) != byte_count)
-			error("write error");
-		body_len -= byte_count;
-		eat(byte_count);
-		return 1;
-	}
-}
+#include <linux/decompress/generic.h>
 
-static int __init do_symlink(void)
-{
-	collected[N_ALIGN(name_len) + body_len] = '\0';
-	clean_path(collected, 0);
-	init_symlink(collected + N_ALIGN(name_len), collected);
-	init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
-	do_utime(collected, mtime);
-	state = SkipIt;
-	next_state = Reset;
-	return 0;
-}
+static struct cpio_context ctx __initdata;
 
-static __initdata int (*actions[])(void) = {
-	[Start]		= do_start,
-	[Collect]	= do_collect,
-	[GotHeader]	= do_header,
-	[SkipIt]	= do_skip,
-	[GotName]	= do_name,
-	[CopyFile]	= do_copy,
-	[GotSymlink]	= do_symlink,
-	[Reset]		= do_reset,
-};
-
-static long __init write_buffer(char *buf, unsigned long len)
+static long __init process_buffer(void *bufv, unsigned long len)
 {
-	byte_count = len;
-	victim = buf;
-
-	while (!actions[state]())
-		;
-	return len - byte_count;
+	return cpio_process_buffer(&ctx, bufv, len);
 }
 
-static long __init flush_buffer(void *bufv, unsigned long len)
-{
-	char *buf = (char *) bufv;
-	long written;
-	long origLen = len;
-	if (message)
-		return -1;
-	while ((written = write_buffer(buf, len)) < len && !message) {
-		char c = buf[written];
-		if (c == '0') {
-			buf += written;
-			len -= written;
-			state = Start;
-		} else if (c == 0) {
-			buf += written;
-			len -= written;
-			state = Reset;
-		} else
-			error("junk within compressed archive");
-	}
-	return origLen;
-}
-
-static unsigned long my_inptr; /* index of next byte to be processed in inbuf */
-
-#include <linux/decompress/generic.h>
-
 static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 {
 	long written;
@@ -493,36 +52,34 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	const char *compress_name;
 	static __initdata char msg_buf[64];
 
-	header_buf = kmalloc(110, GFP_KERNEL);
-	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
-	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
-
-	if (!header_buf || !symlink_buf || !name_buf)
+	if (cpio_start(&ctx))
 		panic_show_mem("can't allocate buffers");
 
-	state = Start;
-	this_header = 0;
 	message = NULL;
 	while (!message && len) {
-		loff_t saved_offset = this_header;
-		if (*buf == '0' && !(this_header & 3)) {
-			state = Start;
-			written = write_buffer(buf, len);
+		loff_t saved_offset = ctx.this_header;
+
+		if (*buf == '0' && !(ctx.this_header & 3)) {
+			ctx.state = CPIO_START;
+			written = cpio_write_buffer(&ctx, buf, len);
 			buf += written;
 			len -= written;
+			if (ctx.errmsg)
+				message = ctx.errmsg;
 			continue;
 		}
 		if (!*buf) {
 			buf++;
 			len--;
-			this_header++;
+			ctx.this_header++;
 			continue;
 		}
-		this_header = 0;
+		ctx.this_header = 0;
 		decompress = decompress_method(buf, len, &compress_name);
 		pr_debug("Detected %s compressed data\n", compress_name);
 		if (decompress) {
-			int res = decompress(buf, len, NULL, flush_buffer, NULL,
+			int res = decompress(buf, len, NULL,
+				   process_buffer, NULL,
 				   &my_inptr, error);
 			if (res)
 				error("decompressor failed");
@@ -535,16 +92,13 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 			}
 		} else
 			error("invalid magic at start of compressed archive");
-		if (state != Reset)
+		if (ctx.state != CPIO_RESET)
 			error("junk at the end of compressed archive");
-		this_header = saved_offset + my_inptr;
+		ctx.this_header = saved_offset + my_inptr;
 		buf += my_inptr;
 		len -= my_inptr;
 	}
-	dir_utime();
-	kfree(name_buf);
-	kfree(symlink_buf);
-	kfree(header_buf);
+	cpio_finish(&ctx);
 	return message;
 }
 
@@ -672,9 +226,11 @@ static inline bool kexec_free_initrd(void)
 #ifdef CONFIG_BLK_DEV_RAM
 static void __init populate_initrd_image(char *err)
 {
-	ssize_t written;
 	struct file *file;
+	unsigned char *p;
+	ssize_t written;
 	loff_t pos = 0;
+	size_t count;
 
 	unpack_to_rootfs(__initramfs_start, __initramfs_size);
 
@@ -684,11 +240,27 @@ static void __init populate_initrd_image(char *err)
 	if (IS_ERR(file))
 		return;
 
-	written = xwrite(file, (char *)initrd_start, initrd_end - initrd_start,
-			&pos);
-	if (written != initrd_end - initrd_start)
-		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
-		       written, initrd_end - initrd_start);
+	count = initrd_end - initrd_start;
+	p = (char *)initrd_start;
+	while (count) {
+		written = kernel_write(file, p, count, &pos);
+
+		if (written < 0) {
+			if (written == -EINTR || written == -EAGAIN)
+				continue;
+			break;
+		} else if (written == 0) {
+			break;
+		}
+
+		p += written;
+		count -= written;
+	}
+
+	if (count != 0)
+		pr_err("/initrd.image: incomplete write (%ld != %ld)\n",
+		       (initrd_end - initrd_start) - count,
+		       initrd_end - initrd_start);
 	fput(file);
 }
 #endif /* CONFIG_BLK_DEV_RAM */
diff --git a/lib/Makefile b/lib/Makefile
index f99bf61f8bbc..8db946deb71c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
-	 buildid.o
+	 buildid.o cpio.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/cpio.c b/lib/cpio.c
new file mode 100644
index 000000000000..c71bebd4cc98
--- /dev/null
+++ b/lib/cpio.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpio.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/init_syscalls.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+static ssize_t __init xwrite(struct cpio_context *ctx, struct file *file,
+			     const unsigned char *p, size_t count, loff_t *pos)
+{
+	ssize_t out = 0;
+
+	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
+	while (count) {
+		ssize_t rv = kernel_write(file, p, count, pos);
+
+		if (rv < 0) {
+			if (rv == -EINTR || rv == -EAGAIN)
+				continue;
+			return out ? out : rv;
+		} else if (rv == 0) {
+			break;
+		}
+
+		if (ctx->csum_present) {
+			ssize_t i;
+
+			for (i = 0; i < rv; i++)
+				ctx->io_csum += p[i];
+		}
+
+		p += rv;
+		out += rv;
+		count -= rv;
+	}
+
+	return out;
+}
+
+/* link hash */
+
+static inline int hash(int major, int minor, int ino)
+{
+	unsigned long tmp = ino + minor + (major << 3);
+
+	tmp += tmp >> 5;
+	return tmp & (CPIO_LINK_HASH_SIZE - 1);
+}
+
+static char __init *find_link(struct cpio_context *ctx, int major, int minor,
+			      int ino, umode_t mode, char *name)
+{
+	struct cpio_link_hash **p, *q;
+
+	for (p = ctx->link_hash + hash(major, minor, ino); *p; p = &(*p)->next) {
+		if ((*p)->ino != ino)
+			continue;
+		if ((*p)->minor != minor)
+			continue;
+		if ((*p)->major != major)
+			continue;
+		if (((*p)->mode ^ mode) & S_IFMT)
+			continue;
+		return (*p)->name;
+	}
+	q = kmalloc(sizeof(*q), GFP_KERNEL);
+	if (!q)
+		return ERR_PTR(-ENOMEM);
+	q->major = major;
+	q->minor = minor;
+	q->ino = ino;
+	q->mode = mode;
+	strcpy(q->name, name);
+	q->next = NULL;
+	*p = q;
+	return NULL;
+}
+
+static void __init free_hash(struct cpio_context *ctx)
+{
+	struct cpio_link_hash **p, *q;
+
+	for (p = ctx->link_hash; p < ctx->link_hash + CPIO_LINK_HASH_SIZE; p++) {
+		while (*p) {
+			q = *p;
+			*p = q->next;
+			kfree(q);
+		}
+	}
+}
+
+#ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
+static void __init do_utime(char *filename, time64_t mtime)
+{
+	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
+
+	init_utimes(filename, t);
+}
+
+static void __init do_utime_path(const struct path *path, time64_t mtime)
+{
+	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
+
+	vfs_utimes(path, t);
+}
+
+static int __init dir_add(struct cpio_context *ctx, const char *name, time64_t mtime)
+{
+	size_t nlen = strlen(name) + 1;
+	struct cpio_dir_entry *de;
+
+	de = kmalloc(sizeof(*de) + nlen, GFP_KERNEL);
+	if (!de)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&de->list);
+	strscpy(de->name, name, nlen);
+	de->mtime = mtime;
+	list_add(&de->list, &ctx->dir_list);
+
+	return 0;
+}
+
+static void __init dir_utime(struct cpio_context *ctx)
+{
+	struct cpio_dir_entry *de, *tmp;
+
+	list_for_each_entry_safe(de, tmp, &ctx->dir_list, list) {
+		list_del(&de->list);
+		do_utime(de->name, de->mtime);
+		kfree(de);
+	}
+}
+#else
+static void __init do_utime(char *filename, time64_t mtime) {}
+static void __init do_utime_path(const struct path *path, time64_t mtime) {}
+static int __init dir_add(struct cpio_context *ctx, const char *name, time64_t mtime) { return 0; }
+static void __init dir_utime(struct cpio_context *ctx) {}
+#endif
+
+/* cpio header parsing */
+
+static void __init parse_header(struct cpio_context *ctx, char *s)
+{
+	unsigned long parsed[13];
+	char buf[9];
+	int i;
+
+	buf[8] = '\0';
+	for (i = 0, s += 6; i < 13; i++, s += 8) {
+		memcpy(buf, s, 8);
+		parsed[i] = simple_strtoul(buf, NULL, 16);
+	}
+	ctx->ino = parsed[0];
+	ctx->mode = parsed[1];
+	ctx->uid = parsed[2];
+	ctx->gid = parsed[3];
+	ctx->nlink = parsed[4];
+	ctx->mtime = parsed[5]; /* breaks in y2106 */
+	ctx->body_len = parsed[6];
+	ctx->major = parsed[7];
+	ctx->minor = parsed[8];
+	ctx->rdev = new_encode_dev(MKDEV(parsed[9], parsed[10]));
+	ctx->name_len = parsed[11];
+	ctx->hdr_csum = parsed[12];
+}
+
+/* FSM */
+
+static inline void __init eat(struct cpio_context *ctx, unsigned int n)
+{
+	ctx->victim += n;
+	ctx->this_header += n;
+	ctx->byte_count -= n;
+}
+
+static void __init read_into(struct cpio_context *ctx, char *buf,
+			     unsigned int size, enum cpio_state next)
+{
+	if (ctx->byte_count >= size) {
+		ctx->collected = ctx->victim;
+		eat(ctx, size);
+		ctx->state = next;
+	} else {
+		ctx->collect = buf;
+		ctx->collected = buf;
+		ctx->remains = size;
+		ctx->next_state = next;
+		ctx->state = CPIO_COLLECT;
+	}
+}
+
+static int __init do_start(struct cpio_context *ctx)
+{
+	read_into(ctx, ctx->header_buf, 110, CPIO_GOTHEADER);
+	return 0;
+}
+
+static int __init do_collect(struct cpio_context *ctx)
+{
+	unsigned long n = ctx->remains;
+
+	if (ctx->byte_count < n)
+		n = ctx->byte_count;
+	memcpy(ctx->collect, ctx->victim, n);
+	eat(ctx, n);
+	ctx->collect += n;
+	ctx->remains -= n;
+
+	if (ctx->remains != 0)
+		return 1;
+
+	ctx->state = ctx->next_state;
+	return 0;
+}
+
+static int __init do_header(struct cpio_context *ctx)
+{
+	if (!memcmp(ctx->collected, "070701", 6)) {
+		ctx->csum_present = false;
+	} else if (!memcmp(ctx->collected, "070702", 6)) {
+		ctx->csum_present = true;
+	} else {
+		if (memcmp(ctx->collected, "070707", 6) == 0)
+			ctx->errmsg = "incorrect cpio method used: use -H newc option";
+		else
+			ctx->errmsg = "no cpio magic";
+		return 1;
+	}
+	parse_header(ctx, ctx->collected);
+	ctx->next_header = ctx->this_header + N_ALIGN(ctx->name_len) + ctx->body_len;
+	ctx->next_header = (ctx->next_header + 3) & ~3;
+	ctx->state = CPIO_SKIPIT;
+	if (ctx->name_len <= 0 || ctx->name_len > PATH_MAX)
+		return 0;
+	if (S_ISLNK(ctx->mode)) {
+		if (ctx->body_len > PATH_MAX)
+			return 0;
+		ctx->collect = ctx->symlink_buf;
+		ctx->collected = ctx->symlink_buf;
+		ctx->remains = N_ALIGN(ctx->name_len) + ctx->body_len;
+		ctx->next_state = CPIO_GOTSYMLINK;
+		ctx->state = CPIO_COLLECT;
+		return 0;
+	}
+	if (S_ISREG(ctx->mode) || !ctx->body_len)
+		read_into(ctx, ctx->name_buf, N_ALIGN(ctx->name_len), CPIO_GOTNAME);
+	return 0;
+}
+
+static int __init do_skip(struct cpio_context *ctx)
+{
+	if (ctx->this_header + ctx->byte_count < ctx->next_header) {
+		eat(ctx, ctx->byte_count);
+		return 1;
+	}
+
+	eat(ctx, ctx->next_header - ctx->this_header);
+	ctx->state = ctx->next_state;
+	return 0;
+}
+
+static int __init do_reset(struct cpio_context *ctx)
+{
+	while (ctx->byte_count && *ctx->victim == '\0')
+		eat(ctx, 1);
+	if (ctx->byte_count && (ctx->this_header & 3))
+		ctx->errmsg = "broken padding";
+	return 1;
+}
+
+static void __init clean_path(char *path, umode_t fmode)
+{
+	struct kstat st;
+
+	if (!init_stat(path, &st, AT_SYMLINK_NOFOLLOW) &&
+	    (st.mode ^ fmode) & S_IFMT) {
+		if (S_ISDIR(st.mode))
+			init_rmdir(path);
+		else
+			init_unlink(path);
+	}
+}
+
+static int __init maybe_link(struct cpio_context *ctx)
+{
+	if (ctx->nlink >= 2) {
+		char *old = find_link(ctx, ctx->major, ctx->minor, ctx->ino,
+				ctx->mode, ctx->collected);
+		if (old) {
+			clean_path(ctx->collected, 0);
+			return (init_link(old, ctx->collected) < 0) ? -1 : 1;
+		}
+	}
+	return 0;
+}
+
+static int __init do_name(struct cpio_context *ctx)
+{
+	ctx->state = CPIO_SKIPIT;
+	ctx->next_state = CPIO_RESET;
+	if (strcmp(ctx->collected, "TRAILER!!!") == 0) {
+		free_hash(ctx);
+		return 0;
+	}
+	clean_path(ctx->collected, ctx->mode);
+	if (S_ISREG(ctx->mode)) {
+		int ml = maybe_link(ctx);
+
+		if (ml >= 0) {
+			int openflags = O_WRONLY | O_CREAT;
+
+			if (ml != 1)
+				openflags |= O_TRUNC;
+			ctx->wfile = filp_open(ctx->collected, openflags, ctx->mode);
+			if (IS_ERR(ctx->wfile))
+				return 0;
+			ctx->wfile_pos = 0;
+			ctx->io_csum = 0;
+
+			vfs_fchown(ctx->wfile, ctx->uid, ctx->gid);
+			vfs_fchmod(ctx->wfile, ctx->mode);
+			if (ctx->body_len)
+				vfs_truncate(&ctx->wfile->f_path, ctx->body_len);
+			ctx->state = CPIO_COPYFILE;
+		}
+	} else if (S_ISDIR(ctx->mode)) {
+		init_mkdir(ctx->collected, ctx->mode);
+		init_chown(ctx->collected, ctx->uid, ctx->gid, 0);
+		init_chmod(ctx->collected, ctx->mode);
+		dir_add(ctx, ctx->collected, ctx->mtime);
+	} else if (S_ISBLK(ctx->mode) || S_ISCHR(ctx->mode) ||
+		   S_ISFIFO(ctx->mode) || S_ISSOCK(ctx->mode)) {
+		if (maybe_link(ctx) == 0) {
+			init_mknod(ctx->collected, ctx->mode, ctx->rdev);
+			init_chown(ctx->collected, ctx->uid, ctx->gid, 0);
+			init_chmod(ctx->collected, ctx->mode);
+			do_utime(ctx->collected, ctx->mtime);
+		}
+	}
+	return 0;
+}
+
+static int __init do_copy(struct cpio_context *ctx)
+{
+	if (ctx->byte_count >= ctx->body_len) {
+		if (xwrite(ctx, ctx->wfile, ctx->victim, ctx->body_len,
+			   &ctx->wfile_pos) != ctx->body_len)
+			ctx->errmsg = "write error";
+
+		do_utime_path(&ctx->wfile->f_path, ctx->mtime);
+		fput(ctx->wfile);
+		if (ctx->csum_present && ctx->io_csum != ctx->hdr_csum)
+			ctx->errmsg = "bad data checksum";
+		eat(ctx, ctx->body_len);
+		ctx->state = CPIO_SKIPIT;
+		return 0;
+	}
+
+	if (xwrite(ctx, ctx->wfile, ctx->victim, ctx->byte_count,
+		   &ctx->wfile_pos) != ctx->byte_count)
+		ctx->errmsg = "write error";
+	ctx->body_len -= ctx->byte_count;
+	eat(ctx, ctx->byte_count);
+	return 1;
+}
+
+static int __init do_symlink(struct cpio_context *ctx)
+{
+	ctx->collected[N_ALIGN(ctx->name_len) + ctx->body_len] = '\0';
+	clean_path(ctx->collected, 0);
+	init_symlink(ctx->collected + N_ALIGN(ctx->name_len), ctx->collected);
+	init_chown(ctx->collected, ctx->uid, ctx->gid, AT_SYMLINK_NOFOLLOW);
+	do_utime(ctx->collected, ctx->mtime);
+	ctx->state = CPIO_SKIPIT;
+	ctx->next_state = CPIO_RESET;
+	return 0;
+}
+
+static __initdata int (*actions[])(struct cpio_context *) = {
+	[CPIO_START]		= do_start,
+	[CPIO_COLLECT]		= do_collect,
+	[CPIO_GOTHEADER]	= do_header,
+	[CPIO_SKIPIT]		= do_skip,
+	[CPIO_GOTNAME]		= do_name,
+	[CPIO_COPYFILE]		= do_copy,
+	[CPIO_GOTSYMLINK]	= do_symlink,
+	[CPIO_RESET]		= do_reset,
+};
+
+long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
+			      unsigned long len)
+{
+	ctx->byte_count = len;
+	ctx->victim = buf;
+
+	while (!actions[ctx->state](ctx))
+		;
+	return len - ctx->byte_count;
+}
+
+long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
+				unsigned long len)
+{
+	char *buf = (char *)bufv;
+	long written;
+	long left = len;
+
+	if (ctx->errmsg)
+		return -1;
+
+	while ((written = cpio_write_buffer(ctx, buf, left)) < left && !ctx->errmsg) {
+		char c = buf[written];
+
+		if (c == '0') {
+			buf += written;
+			left -= written;
+			ctx->state = CPIO_START;
+		} else if (c == 0) {
+			buf += written;
+			left -= written;
+			ctx->state = CPIO_RESET;
+		} else {
+			ctx->errmsg = "junk within compressed archive";
+		}
+	}
+
+	return len;
+}
+
+int __init cpio_start(struct cpio_context *ctx)
+{
+	ctx->header_buf = kmalloc(110, GFP_KERNEL);
+	ctx->symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
+	ctx->name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
+
+	if (!ctx->header_buf || !ctx->symlink_buf || !ctx->name_buf)
+		return -ENOMEM;
+
+	ctx->state = CPIO_START;
+	ctx->this_header = 0;
+	INIT_LIST_HEAD(&ctx->dir_list);
+
+	return 0;
+}
+
+void __init cpio_finish(struct cpio_context *ctx)
+{
+	dir_utime(ctx);
+	kfree(ctx->name_buf);
+	kfree(ctx->symlink_buf);
+	kfree(ctx->header_buf);
+}
-- 
2.30.2
