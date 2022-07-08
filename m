Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6850A56B706
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiGHKLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbiGHKLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:11:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6283F3D;
        Fri,  8 Jul 2022 03:11:38 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 267KPdlF003834;
        Fri, 8 Jul 2022 03:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=CkiMO6lYmM9ZcbH4jMe7VqhibWZBjDLd8iYa71HkU/M=;
 b=ZLZxbkd68rZ/P9TGzjB/O/1tLjexbuDPOcsG45DOFFmJbCaIWdMe+l+XmvrhtXtooOtr
 Fox2CDjzzhmLUY1XS2jJQ7JwR4/GE1zbinmAV0VNTkwgrYW6CQVskIy5tFQjskdNFmHi
 C0WsQyT3wLl09mwOwNNJrSTrhTttt2yeYMA= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h5yeqq1nw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 03:11:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE23rLjPQDNApcfkpz5Gw9aSbswMJ4c3g7MBS8HILFH2SQ3lq8mjEh4DiUGkCpNhxgFUkdVIJ0qwQ3i8DqvtCMCx03g5CjyVugheeAYj1eL6Xa9wQx6r+tnP6tOiGlUFM9rMR9tQkJAqTncBLVoDy/w5g10nYwrIrFgAzMsVRUuJ4Hn4dLADjzrDZIaZ+L8iw59mK/G3GrFsu6dQCuZeM6VdwBHGR9iwRT64aD2no11LFoWoZLARw2qENEYjXnIswohxYDyIV3taSX8PIWvB/C3JPE/dmKTcv/luYygyj9dlOVlEdBTWYweEi02jln+oxF6ubRIEbbz9S3d2RfwZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkiMO6lYmM9ZcbH4jMe7VqhibWZBjDLd8iYa71HkU/M=;
 b=nErX6+UKSa2kjUaKntl55LsGlzCgbjSRqqs+ASDAXPuZrVQ6esXuDHRAEWN0VwE+WV3j869eFRE0imsK3AXFIN+Zxb8z5pK3wSVGqOvXW1ilmlSwjT62Ad6jzouB/GJVSnWqDITTSQt9Fz+3Henb2eJl0H4oQPMfVcNdcK179zX7AnWsaCSpzmONP35yE1bydA8qPMQOtT+bYoLl+qTtfqHy49LIWUV384IeKP+nCGmU4kVF+Ka/8Seome5twuyfURb1ajd/5PXOuA2J4sG6JT3rwmIJ6UUEfJq+m5z1ghtI1P9PW8cDp96t3QAHO5npvcVDrRO1uop3j5ANoNwavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:11:33 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:11:33 +0000
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
Subject: [RFC PATCH 1/7] initramfs: Move cpio handling routines into lib/
Thread-Topic: [RFC PATCH 1/7] initramfs: Move cpio handling routines into lib/
Thread-Index: AQHYkrMZ5DDpxnKkiUCBiG2/Nktz+g==
Date:   Fri, 8 Jul 2022 10:11:33 +0000
Message-ID: <de73ebe1c3c621d8b844a456763d482c8c5d6f6e.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80e563d5-a932-4d61-bd98-08da60ca3c42
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFu+7RKcICfiRPClrcLo07E7E4e21vXl2UCneTswBpqh3eiW+1cEzPVIpueMJP//d2f+T3cMp/wQvxni3mwMfgQAajjsw0E6o0HdTeLAzn9JUgMKT8+3KirrE+blwhjlYDEiYXgnUqq8Yk0u6+YR67xE2fsXnUVrsUptn42E+Aqlf4nXXQW1uwtO7v7HH8OAYX6VmkrfaVdeea4qTnDmyA3eHQu66cKahuoIxpxEzmHOg5tSsG+IDXdfDCLurYmGQJRDNoGh4bijKItwMmkcV4x2jh6Vulx32HSHkyRwKJzSOt0AkaV+MlF5evQqbP77uaJYsqpP1CGhR74L4xMw/r5hFc2zzrgcDg7FvZ7/XiRZ2p2fJAozxUaiF3EtmS9YHnAem/f7bxd628iz5Hw+4/FP1v0lk71q8OfRl5HqRRO+rhAwO2VWNgFP0aQy9AMFeoRY23zff5kP+XFdgGG/4yYs7MPxMsJ9YM1EctxqGT5OAOt7ZTTGgtR0ms9j6Jam2NDFXrnlSI76fWTYnFibzLJ3oSatsWnGKyxbCvqzi943cq/LTorxtfRw+b82s4jyWNm14yjuJzmB7H2zHX2NQMfElSbiQPeADJgdaxfR7XCMt/+lTonaEpSC8HrHq+fgfggpdnROnU4Yu+32vh90JlNdLk4KEaeBYaBj7rRK2sNP2iztOjykI3OsdsI9s6a9BMRfXrstOwjt7PKVfwe7PD2Dh+HjRnyMnchISU1uZy87QuIjEF+psjwgIyS62jLyR2+X/0xVPafqve5MROarNHAHEMVfdpvnrKOPZK/zkCGqpsuPPf6qtgRGH8yM9fp0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(76116006)(91956017)(8676002)(4326008)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(38070700005)(6512007)(26005)(186003)(6486002)(478600001)(6506007)(41300700001)(86362001)(54906003)(122000001)(316002)(38100700002)(110136005)(2906002)(36756003)(30864003)(83380400001)(7416002)(8936002)(2616005)(5660300002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yXSO7/TzYblG1qHPDTb/WtN4HqqNzyMJ08LpxDeC3XeQEk8dmyAwS7qwftxi?=
 =?us-ascii?Q?TAqTDCWF9Z2vDbCJbLnkXFiyWPF+mOGym/sI9kYPjueY+ctwaeYSXMZT0Dlo?=
 =?us-ascii?Q?kGeZUatu5cMr0yMHiykamNIhmpXK/OPYP/yYXcq6KOP4l7WmnMly/Hh+1egg?=
 =?us-ascii?Q?eD29gXZLoCZyjk5tj3+FCGlOCqw7bmXlYgrV9nL+o7VPe5ok9qNXcL/HwLoE?=
 =?us-ascii?Q?t1A48i5AAdZeG5RgHYULFOwncEURJaAS2QdY6DRNfLxg4EJMiT6q/i2gICna?=
 =?us-ascii?Q?1tbZHE4khPy+43ktWsC5noljmqXEW3OT9PEZ6F1bOJ8OHJ7GfO1JyA/9Q8no?=
 =?us-ascii?Q?kgPbSZ8M9PEsamrcYUwg3a81Qv6sRyhSkQ3t5+ri3bYYzdnPmHewjGCGMGRS?=
 =?us-ascii?Q?xZFzHv/ql+mLdq0nK2V+EnLhBc1dH/HNPtWH1GulO0MDtls8DrROmXOUZB/d?=
 =?us-ascii?Q?6NMzjJKmCvZIj/lZ2RqxgnP5IGP2VUA3JDpHw1h6s3CPnRaVeqiiCrvchXmf?=
 =?us-ascii?Q?aLSu6gcTr1N6NoVvPYkHgMXmEpJWJ7TzZXZCm8qa/UgQd8oiJiXPPpKMKnex?=
 =?us-ascii?Q?SG3YHz033+qMzgKSMTdaUmasATIZuZZxvfNIpfmVVByc22heBe3GHl18WLHa?=
 =?us-ascii?Q?85lNkQNXuH5Jhcpx7BuMZ8v5ewXjkTNKzw/DlQmFFLOu4beKfq6WH8N6wTZA?=
 =?us-ascii?Q?tucUSQSewqwBkrSdX9+SFNYG6fKAtgjrdgeNQi9zml81g6N6F4HM2Ca8OFZB?=
 =?us-ascii?Q?VYa+ZV6Q5b67K29bhaaZoaMFaEbVLyN6ZH3SDrJJMGf5c+cQ4cb2Tr8CrSSw?=
 =?us-ascii?Q?a7rB7fh0BdlYSQsdxrGm5eXagrd9MSJK5dKG0JG8ruJQaB7ltok1f49fCMty?=
 =?us-ascii?Q?tW7KlXx1Z10TH2/BPfhTY58SkM+/nP59Dqi8g+kidbu+4d76h4Xm8IOA1lAL?=
 =?us-ascii?Q?SlklnFcU65Z2bhaqJkJRlHHpABcJJ1g1uM9ouhAEG8Qs2C083fStYlNpui9n?=
 =?us-ascii?Q?x7NSUKkbuQguq9pT1+kG6zno8sgq0bU9nHZYCFTTu0bnlMiLS5Yg1LH/2PSY?=
 =?us-ascii?Q?wP6ImPYahFW9KJVdpIL5UjwLI/cwvMR2lCFinxHyKL39RJ0haoLCuEQb9VG5?=
 =?us-ascii?Q?8L1fb0x5R/fOBlCnqMBWzjQcAgQi0WYTs8rCJ80MXmCvr0apEXJuoxB+gPfy?=
 =?us-ascii?Q?CD+6n/rFt4sbl/YdgmPCOVFlq+ogUb1SgYzc/2LdqDTe9tYW7WiNkx4go7LP?=
 =?us-ascii?Q?YBGobfLCHcU4j6Zl0bHOMs6+rYQEuKB1DgN6qM3FB+vtHb1qY+BmHe9AKdJ4?=
 =?us-ascii?Q?hv+jixfxgKLmXCXxJL5EXe3uuL7BWNEwW09qNhbOTPkKWZNPYPJV4bAwi9DB?=
 =?us-ascii?Q?Eh6nQShoc1zJc/xLNsemerot/P7PZATslVgsn40QIoAAHZdd4hLcQWkjF0vJ?=
 =?us-ascii?Q?fVPhsZHSocd9z/e+KvwcB4k6VQ4nMRIx7MTRMUy8OBlScTjUbRiBdvULH4e2?=
 =?us-ascii?Q?Y5iHJZ8SqMARwGvyxVFUOBdokqlaniJGeWv9UfBGQDqOLk0LK/t3unsZlZlY?=
 =?us-ascii?Q?hSMQfywEO9c31SHrGXDXFg67kPD5ERKaDjwEiM+Z?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EBFAEBBEBE2F14B83BB77699C847083@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e563d5-a932-4d61-bd98-08da60ca3c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:11:33.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UcvvNFxF7hUdNGddbVigjjv/mszWTYIXx5K3qCkA6Kus/M6J8/NW5VSJ9ufl9jG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-ORIG-GUID: 8BTq2uEt2vUFRTb38McBF6el6vSPNOdg
X-Proofpoint-GUID: 8BTq2uEt2vUFRTb38McBF6el6vSPNOdg
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

The cpio handling routines can be useful outside of just initialising
the initramfs. Pull the functions into lib/ and all of the static state
into a context structure in preparation for enabling the use of this
functionality outside of __init code.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 include/linux/cpio.h |  78 +++++++
 init/initramfs.c     | 516 ++++---------------------------------------
 lib/Makefile         |   2 +-
 lib/cpio.c           | 454 +++++++++++++++++++++++++++++++++++++
 4 files changed, 577 insertions(+), 473 deletions(-)
 create mode 100644 include/linux/cpio.h
 create mode 100644 lib/cpio.c

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
new file mode 100644
index 000000000000..f90b53fda6b5
--- /dev/null
+++ b/include/linux/cpio.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CPIO_H
+#define _LINUX_CPIO_H
+
+#include <linux/init.h>
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
index 18229cfe8906..5e3abc1e51cc 100644
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
 		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
-		       written, initrd_end - initrd_start);
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
2.36.1
