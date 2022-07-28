Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7858409E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiG1OJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiG1OJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:09:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C11222AD;
        Thu, 28 Jul 2022 07:09:17 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SDKdrT005372;
        Thu, 28 Jul 2022 07:09:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=4CZ1hZn2cbkt7i9J+NMQpIdxxO0FwrubGh36izgjG4E=;
 b=XJPDQmukAr8gN9WyMQicItDFKbbIVPeGC/kAzFD/QzViq76QnU4MenTC/AhUkSu6GigH
 iWzKr3RhaKPZ9lePqCv/OibMPv8ze8r9EGn0Lksrso0ojfzALDLDULLSg2Wg8P6Wd6Ya
 OaW564wsl68XmhpV+ed74EX4N+eqazyMZDs= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hks0ps38f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqOPwDAXyJf9aqv4JqCNpB1cAKA/3i0xtcEcbdR+EunEB0kuB9Fna61VxlUTAntPT6fOqP6RAYTJvni18rKR4U/bbEjsZv8zJ/GLzdpYmhrKLDYiQ6Gvk8Ni8Ftaa9zdwVnLfqVY0m2K43i1IFLD/C4yYREDztNe9xYGnjrvDPAtwqdC88J/8mVtWAJ4BV7JZeXYMQSGf8ih8vhbyU0+IGfIafQGZJ0Dq4co+0RH//FKiluAf5QMmMmd/XywuFhEF6qHVE5AOZTjK8pwBY6cU5TeHA0/oSQSllRPgT+dJN/U7zoDIKmnK8xuOV0deU/eIle/Xez1LRc9KR17juv6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CZ1hZn2cbkt7i9J+NMQpIdxxO0FwrubGh36izgjG4E=;
 b=YAestAJ84w59bPkO7O46rWepRkb1Vv6lHxzg8GvdaN+vnX9Go9cpiniwsHsaYzD2eDkhJJ3xJr6zfcERwnQkgx2BZaBRCIg5zaHerPydOLRLEBcVtyJcSaIKA/waoJaxx5OsWa8s8L+S7cuYqxcSeu62juYDNJ3aTn1OHzYhH+iK8IOnpKTqsePqxySuCijtL5oyPqYXX1dpxHxaYgAPlRqOen1JnGx00+L3COdU0jw6cdVikhqdJgYbk+R6jtwH0Z3A/pdCdihiqg5UNkdzrPo7Pf+mTftZFnQ4RyTZIOeuS7DCk5crFqxaRtJBgEbb6jEaxye+FC00Oedw8Dyn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB4256.namprd15.prod.outlook.com (2603:10b6:208:fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:09:12 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 14:09:12 +0000
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
Subject: [RFC PATCH v2 2/7] lib/cpio: Improve error handling
Thread-Topic: [RFC PATCH v2 2/7] lib/cpio: Improve error handling
Thread-Index: AQHYooucwp+PEgLZlU+UDY/xIbZ3dA==
Date:   Thu, 28 Jul 2022 14:09:12 +0000
Message-ID: <f0dba8907e02cbaf3615e60446b394ee3fb9a847.1659003817.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
 <cover.1659003817.git.noodles@fb.com>
In-Reply-To: <cover.1659003817.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1781041f-13c8-42ae-7160-08da70a2bf41
x-ms-traffictypediagnostic: MN2PR15MB4256:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDBlBD0ZAeQkzMTvVW2VIIs21A/TNqigbzdu2RQW++bWB1Qzk6GQvyp701FYpnK5oRQr99rPQO/JqPsTJy/bb2zhEwuZd/hzXOSS47GJgA3mIHCXID80Acgo7BjPr8NVfPrOmOC1VcG7ZE1pFkjs6OzvfadDI2NPE4fxS+K4qX46PEj5P6NWAOBgcjYbKJrCCk1+64EVkjwo7t/Gl+lA6PY3OWpjKeTrfOjbf+EChhqwZ2+0XeAS8jMwExWiZatWSwn9zbE0DgM3A7n+3uPONlFYuC7Bpd1M/zYMQmxDREW0vrAZX+g8vCbtDYl83gynEvyBaO5QdDFj1R3A9vMjgnWQYmUhdfCL1AknC0wHfikqbHmHTOQwyHmwJi36l6Kg7giUIWIfVEZ1mtQGpf6X+5CuquEU8NY/C0Fmj2/UpOPTCs1vS6aYvY5cFQK76qMzXSUA4lfPV9G2ZdBw+pLzNO+PnBkkAsRwcVe9SBUVKZ+FjZedL+BJERxaSNKswdif+4EVrJgsmf8bVv5bgN+muk9CywyzPgciqBWeDxLn9doTROlt2iWRhS9NT/HO6YoodWG2Dh+2WGBFGJxjw3LkKoHNwPMkHb67CXVU7hGCcxUSvY8342NKdH9byGj45tElL8BWsA8bRmm7hwoyOW1bllTua+eFMfBLu0FfcYHPQhqjxl81qeCfTT3xp7+cQgdoMeWvSwYpA5PGRAhh15edlT1znAPXAv59x6cfu17q9nTezl11EYhJSKECFoBUUEAzyQ5BI9+xCdM4GKkuil9t9vAbkx3zJDqQN64wD4FWNRf+Ko+XjeT7Lrfig0rDY6lt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(7416002)(2616005)(2906002)(478600001)(122000001)(41300700001)(6506007)(86362001)(316002)(36756003)(186003)(5660300002)(38070700005)(38100700002)(66476007)(4326008)(83380400001)(6486002)(6512007)(91956017)(110136005)(54906003)(26005)(71200400001)(76116006)(66946007)(8676002)(8936002)(64756008)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RKhrI78mQM3liZfyitw56Kwcc08hUDhHoIOQhDHD3lSqyLp9S5iBFHzXylBa?=
 =?us-ascii?Q?zexj5Ai8YYjDcBBks24PQg4S0ti5QVFGjj923xGBFvzvrsq/2et058CJ+411?=
 =?us-ascii?Q?tqvPXUp1QWrMEUQp86T/kWdMxLMQ7uKieFB2zbWyGikXE6jcbdkcsj280YEU?=
 =?us-ascii?Q?q+jTbsImbqxeEyXsk0uumPjYYyy/C/dY2WsJQZlQtImhFbjVTXWX00mqMeDZ?=
 =?us-ascii?Q?+kP9ml+gJeBl+/KkUh8o07pOp/Th/7yt+ftMQV0ubwI1GEWJvaMgrY+AXAE+?=
 =?us-ascii?Q?aml6HXivpZrBhG2Wa2VVVadGLueEGSwf5Z3Y4mew9zKONkt50eFtN6m4bh3W?=
 =?us-ascii?Q?/+ZRTRT+eEtIWz39EqQl8Ekh+XUdlH5VqC8ojWl2dm1gDFiEyxdqftI543Vo?=
 =?us-ascii?Q?TWXgaemjzi5wGzPmuGqLcHTT7V4BXU6jkwxhDggV7IiSktGuKM0P016neg1X?=
 =?us-ascii?Q?x3qBUIq/o7CEqMrEE7wj9Lk824EXOsa06uvCuSQ7ckrubhsn+ocRXkGH2Dtk?=
 =?us-ascii?Q?lpaUGrPZLaIWVsvaKofUY7otKCo5Iq7GkQaALBIWakLI09RQdBWck13ZEywk?=
 =?us-ascii?Q?+6s1qTdLLznKgpgpLXYQOsc0GcXNGzpc1FKWWAJ0X1uQqtr3+j1Mgjw6gJFN?=
 =?us-ascii?Q?UKulewmN7NHmtpx3VmlZF5MAYpTH2r5zdFHADJrtTWTwSeS/qsW/5VBndPED?=
 =?us-ascii?Q?4WmWgwNNZnkmckOnEoWsC2ROWWzDr4+PwkVF4jdGxq/zgYPZEB84NDY+fHVI?=
 =?us-ascii?Q?H8mTy9Z67XWIKpFh1uwfP5++aI5F5AFkouXTyfSQgfvhX7i5m7ry4x0iGnP+?=
 =?us-ascii?Q?YyyADOYbhvE8RHdxINkf84/4wkskj5siru38J8q4mrSsqrgz/2j5BHMQQgsu?=
 =?us-ascii?Q?W2j9IinqY21Vy/nJFCTxNKm/vZ6t3R6++dTLWngRSW+GHU3RxFRns+N2kSK4?=
 =?us-ascii?Q?NM9dX+FUiBxAJcDm3c541ddC9cSWYQH29nYL9upKhakxLVSo+GTsOqUNYh1d?=
 =?us-ascii?Q?+b8PZOYKd+E0diXtlLEUa5Xgl9mkKAQSDEz5qCbVjPYblzFiDCV52Lcn8rDS?=
 =?us-ascii?Q?daPBTeU88TNG3ikGTV4pZa2SPhLcSyKEIzdW07VVEXQwDm+LpSqBtHVKMnbk?=
 =?us-ascii?Q?FpriSetMqg/INMn+8FD0dO3aqiOo7fV1oMk5w6FA4vH6AvRbpOaMpmE3UQug?=
 =?us-ascii?Q?Ucz+Ki2BCcgif6yNFRFTYe6bsqRCenmKc2PPLmhucB1XbgzVQsahGmIzUAxM?=
 =?us-ascii?Q?gcEubtqOwgK/Qa0MApcrN8gHApTlqkVH7p4/JiH6M+SW7iP+e2vBDAsYecRn?=
 =?us-ascii?Q?ZbMWJAkwaC3gdNO8UTzq1EnXqfIz226nywu9hJmj7+jGedpPNo6ibtnFZpRZ?=
 =?us-ascii?Q?yAPv9co3X51NHZNa1xv+cAMkXkI+9JEdCQDSCWbpB7NixQzXopVtPS+WO9eS?=
 =?us-ascii?Q?HW2qOE3UuWfJONljVZb05T4Jgq9QX/w/zp2KrunYwah1V4aILQrov+EFudpi?=
 =?us-ascii?Q?8T+5VVAq9AvUiTG5z+lWczCFHIKQ0QfTqJKk5BOrXCgys6wQUzdQBwLOoMm7?=
 =?us-ascii?Q?WbiasTs+egNJQC6n7zxBRedOCyrEuq/c0nLRVJoS?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57B1A3003B6BC645847C0278A259714B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1781041f-13c8-42ae-7160-08da70a2bf41
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:09:12.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1dM+25bc+EbZ4EfZUTcFMujTVBLzV+TblRx/krICe4gS/ht43MvCGlwwBUrhF68
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4256
X-Proofpoint-GUID: ghVbqN44zCxuA6Sli_WTQJnW_C2DVTxi
X-Proofpoint-ORIG-GUID: ghVbqN44zCxuA6Sli_WTQJnW_C2DVTxi
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

As preparation for making the cpio parsing routines more generally
available improve the error handling such that we pass back a suitable
errno rather than a string message, and correctly exit execution when
such an error is raised.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 include/linux/cpio.h |  1 -
 init/initramfs.c     | 10 ++++++--
 lib/cpio.c           | 56 +++++++++++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
index 2f9fd735331e..69a15fffa5c6 100644
--- a/include/linux/cpio.h
+++ b/include/linux/cpio.h
@@ -44,7 +44,6 @@ struct cpio_context {
 	unsigned long byte_count;
 	bool csum_present;
 	u32 io_csum;
-	char *errmsg;
 
 	char *collected;
 	long remains;
diff --git a/init/initramfs.c b/init/initramfs.c
index 00c101d04f4b..79c3a3f42cdb 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -62,10 +62,16 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		if (*buf == '0' && !(ctx.this_header & 3)) {
 			ctx.state = CPIO_START;
 			written = cpio_write_buffer(&ctx, buf, len);
+
+			if (written < 0) {
+				pr_err("Failed to process archive: %ld\n",
+				       written);
+				error("failed to process archive");
+				break;
+			}
+
 			buf += written;
 			len -= written;
-			if (ctx.errmsg)
-				message = ctx.errmsg;
 			continue;
 		}
 		if (!*buf) {
diff --git a/lib/cpio.c b/lib/cpio.c
index c71bebd4cc98..5d150939704f 100644
--- a/lib/cpio.c
+++ b/lib/cpio.c
@@ -221,12 +221,10 @@ static int __init do_header(struct cpio_context *ctx)
 		ctx->csum_present = false;
 	} else if (!memcmp(ctx->collected, "070702", 6)) {
 		ctx->csum_present = true;
+	} else if (memcmp(ctx->collected, "070707", 6) == 0) {
+		return -EPROTONOSUPPORT;
 	} else {
-		if (memcmp(ctx->collected, "070707", 6) == 0)
-			ctx->errmsg = "incorrect cpio method used: use -H newc option";
-		else
-			ctx->errmsg = "no cpio magic";
-		return 1;
+		return -EINVAL;
 	}
 	parse_header(ctx, ctx->collected);
 	ctx->next_header = ctx->this_header + N_ALIGN(ctx->name_len) + ctx->body_len;
@@ -266,7 +264,8 @@ static int __init do_reset(struct cpio_context *ctx)
 	while (ctx->byte_count && *ctx->victim == '\0')
 		eat(ctx, 1);
 	if (ctx->byte_count && (ctx->this_header & 3))
-		ctx->errmsg = "broken padding";
+		return -EFAULT;
+
 	return 1;
 }
 
@@ -344,23 +343,29 @@ static int __init do_name(struct cpio_context *ctx)
 
 static int __init do_copy(struct cpio_context *ctx)
 {
+	int ret;
+
 	if (ctx->byte_count >= ctx->body_len) {
-		if (xwrite(ctx, ctx->wfile, ctx->victim, ctx->body_len,
-			   &ctx->wfile_pos) != ctx->body_len)
-			ctx->errmsg = "write error";
+		ret = xwrite(ctx, ctx->wfile, ctx->victim, ctx->body_len,
+			     &ctx->wfile_pos);
+		if (ret != ctx->body_len)
+			return (ret < 0) ? ret : -EIO;
 
 		do_utime_path(&ctx->wfile->f_path, ctx->mtime);
 		fput(ctx->wfile);
 		if (ctx->csum_present && ctx->io_csum != ctx->hdr_csum)
-			ctx->errmsg = "bad data checksum";
+			return -EBADMSG;
+
 		eat(ctx, ctx->body_len);
 		ctx->state = CPIO_SKIPIT;
 		return 0;
 	}
 
-	if (xwrite(ctx, ctx->wfile, ctx->victim, ctx->byte_count,
-		   &ctx->wfile_pos) != ctx->byte_count)
-		ctx->errmsg = "write error";
+	ret = xwrite(ctx, ctx->wfile, ctx->victim, ctx->byte_count,
+		     &ctx->wfile_pos);
+	if (ret != ctx->byte_count)
+		return (ret < 0) ? ret : -EIO;
+
 	ctx->body_len -= ctx->byte_count;
 	eat(ctx, ctx->byte_count);
 	return 1;
@@ -392,12 +397,19 @@ static __initdata int (*actions[])(struct cpio_context *) = {
 long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
 			      unsigned long len)
 {
+	int ret;
+
 	ctx->byte_count = len;
 	ctx->victim = buf;
 
-	while (!actions[ctx->state](ctx))
-		;
-	return len - ctx->byte_count;
+	ret = 0;
+	while (ret == 0)
+		ret = actions[ctx->state](ctx);
+
+	if (ret < 0)
+		return ret;
+	else
+		return len - ctx->byte_count;
 }
 
 long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
@@ -407,11 +419,13 @@ long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 	long written;
 	long left = len;
 
-	if (ctx->errmsg)
-		return -1;
+	while ((written = cpio_write_buffer(ctx, buf, left)) < left) {
+		char c;
+
+		if (written < 0)
+			return written;
 
-	while ((written = cpio_write_buffer(ctx, buf, left)) < left && !ctx->errmsg) {
-		char c = buf[written];
+		c = buf[written];
 
 		if (c == '0') {
 			buf += written;
@@ -422,7 +436,7 @@ long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 			left -= written;
 			ctx->state = CPIO_RESET;
 		} else {
-			ctx->errmsg = "junk within compressed archive";
+			return -EINVAL;
 		}
 	}
 
-- 
2.30.2
