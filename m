Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13D5840AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiG1OKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiG1OJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:09:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3DD6610C;
        Thu, 28 Jul 2022 07:09:43 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26SA3KON028760;
        Thu, 28 Jul 2022 07:09:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=yLO2fDxoKF+qQQ6krmpZVBN+5J3Uy5TbMmCSOCWLvow=;
 b=hwT/eTKA82IiGme+Y5gPQWDQWP/4BPSwJv8SVNx1J4hX6ALMnop2JE6dfRQky5Wtt4QY
 O4163qb2dI6AjYp+eaN6lTQiEXZzFtPExW9rGQjNNFmd0+YzRwiQ4JPm/R/1D8tntVR0
 /FKwYIzGZIr4CJOYPY5vZ/O5J93f6knlgA8= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hkjkmtue4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2XnmxHpVXEyPY/vmOmGw/mB2kfgG52XqwOlWHRSoT7PKgBjl7FPOVp2NAeKsyGQliWHAaULA5GlutwLPmgg21Iv+aw2AZADQEg4sNtpRo8Du2dv7R7H7S06ngaDP82keVXB/Y//nn105M+19vsBS9UID8rDhH7+9CcGOpxz8RqFkLYB74QkWBe7gZJvbN+PryxAXUnlhB4MoKr6EbGf6vuz8d+/7hpXnhmFZuRac4zy5R31i9Wskg8sxs4zvM9pGcdRVeUFvD/0zpnIihKsbOQzwgpnBEvo5XvNBTNNWAf2Hr0mee4UczK2RkCRJN8+Unvsbycv+qwMM9BT1i9NwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLO2fDxoKF+qQQ6krmpZVBN+5J3Uy5TbMmCSOCWLvow=;
 b=L56f0XqSTYDuAAdCeWNbquH84ZnpEnT2vqR3Ra+wr4s43u7C/dUnVrqJlqZyuUPR86hSEGwySdam0+8NGctat64LDoJ4Uut6r3OJZhyCH0bXxBCdJIl3bcayss+jmsSSjlacSYRRmEmGVR7KxZEUZurGahafVNB3VXU56qrY+8nY/Uu/4lHa0BBuXvLBxIPOEtd/QDPZBTSIpNaCXgSOLFeIFz8TZYnzyB/e8IdXq9WXhIqj+9fLqpl4ba0IUToUkSD7ekU8aQn0ro5kZA9PIRwBTQiczBuuTTsspSh2vScjMxAf30UeuFRinn1wjvB7kJEnRyUslUal1LNeVCscQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB4256.namprd15.prod.outlook.com (2603:10b6:208:fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:09:38 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 14:09:38 +0000
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
Subject: [RFC PATCH v2 5/7] lib/cpio: Add a parse-only option that doesn't
 extract any files
Thread-Topic: [RFC PATCH v2 5/7] lib/cpio: Add a parse-only option that
 doesn't extract any files
Thread-Index: AQHYoous319EjwaYY0eBZQOcYf/Drw==
Date:   Thu, 28 Jul 2022 14:09:38 +0000
Message-ID: <f610468635ef9933d03b130aa81cc07f8bfc6d00.1659003817.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
 <cover.1659003817.git.noodles@fb.com>
In-Reply-To: <cover.1659003817.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59139d2f-1a5e-4541-d202-08da70a2cec4
x-ms-traffictypediagnostic: MN2PR15MB4256:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiOPLuUkEZ8eUa7Hg5wtgGo5gyxMeSwH3cY9iP1gTIhFRdGQ4bVzVbmXeihXoC4shri+/lSQvCdhZ5WUrhDI2M8HJM/KsHJz33GQEeGWWeHKRPEp76qibBVp5+G3JgxKugRpfb3iAVId2Sj1xyhflV9u7n7DEExXc/6BFqqUEvBGt0llvNEL7oJgb7CmUCsjmq+sXTALUFX1YsXsrPBWeJbhJPebtsf/9fB0zF4biNnwURkU4AYvmKmVjMdZv3LVn+8BVXWSU4CVuarNCa0aySZuRGrHAy1kKn0cee3yG9puDhzU/rXnbFfIq8MhHTmIdUgGlRG34+Kem8rGS/B4b23dNHOq59ScfF0GPGkSPVivuMxMfqij/toAZKppeo7s26jcC0W0+IEs2OPIkDXZwX+a37aofQwxACk7yvymhN5BQ29/QdUgGtTXBk8LFZoZw7tc0b94eTqB/laG131C4LDmKltBWx/TOPRLdlq+zrA83U0wNLEkNNHOwIZJL2S5cGTcVlIk9RDn2upOlalisPdMZtVFifpdv4Z8OKAkzkP0G2uJ5LDMFOhDmKXzv+eWjeBW6BVtCnUdxsEJyqfBoPcB08woXgwMu5/Yj0p9QniJXwzZyadk2ALLzuJ11HlZJtlPz886OASzLIXFiSrPt36PRR+gFOMqJ0nuh6W7nLwATFmuCntewmNMQk69HDozcuqxeDxUFqR07O7mtfOISAXLOWOyC6z/XP5hBdZp1vW6kzul6Rx26kzyCHkjbz3zFym3dY+IjAlsBRFmhhEBrOeax9GkXzm8EQhmdarcQvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(7416002)(2616005)(2906002)(478600001)(122000001)(41300700001)(6506007)(86362001)(316002)(36756003)(186003)(5660300002)(38070700005)(38100700002)(66476007)(4326008)(83380400001)(6486002)(6512007)(91956017)(110136005)(54906003)(26005)(71200400001)(76116006)(66946007)(8676002)(8936002)(64756008)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bx3KFSqiMpPS5t9QLclG1mxtEhs/Iv2Cuj9kPtiLoYpI1SQokSO4iao7cn+1?=
 =?us-ascii?Q?Ilx08WzfBk6723vjmz0e8xmr1+1dRsN0CqZ5Qtv8M9XETcRuZM1l6QtFWKVW?=
 =?us-ascii?Q?c8IVo6huYnc1ksDJYOv7AVisDYezr0tqbdt4b/lMhnRZwrm3WVB7aYD/P+gL?=
 =?us-ascii?Q?v1PfGYbvf1WPGzd9vRJTR4iUgWDHRiXVI5VfPlt+F3FCIiWzR72Cx1RHFlDS?=
 =?us-ascii?Q?Whqdwi/pKXk9Zv9pL7dhH4sgY+ZoTwohT/B4tMk1zeXTfZJr0JrBIeX+2Z/F?=
 =?us-ascii?Q?Wf5IFc0g0/tJ8I77iCj1MAgKrA2BHWLA0fdf8shTxgHFeGfM6ANy0GJJP2Ob?=
 =?us-ascii?Q?0hgdc96LNORqTU/W/kRXbpEITvi96WsCPJq9G8JIhnwZv9fyuSV5xRhM3uY0?=
 =?us-ascii?Q?AYTZtaJmgNnUtO0QKYAvppGusqZ8/oPiiJZqOgcGk69RSdqZSac9bKua1EsF?=
 =?us-ascii?Q?qOq4I3ZTFApRcKE7il+ckYyzDTgp9a9kBF/8zdvicWfGyp8UpowmmeGsaNgc?=
 =?us-ascii?Q?Pr/Q3lccHOjxXrlD9FJ1Wn4Qvg+0Qz0Y84k14Eb1Co6fk3Ynq5vQR5wXkPIg?=
 =?us-ascii?Q?H9VlBSEMC2Cyv1r++5Zc/sDFzbmgmS0wV7fut+xjpCij1IR1USVqpYhb9iT+?=
 =?us-ascii?Q?enyVa/wPh8iZtYLKp6wIx3Df83XeSOZ4Jtrvu30brjQzrLvAG3G7GSf/wtqq?=
 =?us-ascii?Q?ZYPls6lh5a9xoRYXgKttSAWaPfehIv0ONEn2dP+2peuE9Vvrv0uAYNglgH+X?=
 =?us-ascii?Q?ZrfVaRX0FyvZej6PndaAZ7uWz6HoSw3cC3ZFoN7Jbzokv7Gjys5gRN7yetnQ?=
 =?us-ascii?Q?QBwA1dwSCY7YhdLA6RYNBvqeV1kKGCdh22tgwMC91f9ZBznDdTSf/6xqbANb?=
 =?us-ascii?Q?9Tr8UlCeZLMbDSogsoE/AvDL7WAhv0dlOvQQ4fdnHuGy/pDLHLUk202Aux3/?=
 =?us-ascii?Q?apXGjNy/u2G6m6IunTsBpT8+loWK033ES0hPpl7QEjGQmR2YEND1RfbUXL/n?=
 =?us-ascii?Q?unA1etfVSR4gUVHhO0CnAcxkVUUPTWF4f2Q0lrf8r1XeCd9JuuBtgsD2R1A3?=
 =?us-ascii?Q?QXx19GHeN0Toh5f3WxF5LNz5+ILb5a/7re1gDsVNWm8dy1etj0y14m1Ne0Gp?=
 =?us-ascii?Q?KVT2PwDXNMCYpVdeijzAEf2Ztgz7dDY9i5EfTJ/PtT9+AOKqHJenumwhUQds?=
 =?us-ascii?Q?bTKdDf/W591OSOO2JE9TVNVGIN5TTTvh6og+SO3wZGSlHBqLs3Q9B/LWCF4K?=
 =?us-ascii?Q?IpgKf+Kr5IU/GAO3u9j0IewHQyIageG+K6v445RM86FzwJ21gdXHaywpWGnR?=
 =?us-ascii?Q?VnqmF3clSDZTicaYI7/dqq4tlEgNzpjOD3ezItGS8c7UzciKUu433So2a+er?=
 =?us-ascii?Q?Dz4ylrrzZLpwWbv6/ZFAQM65TjEMzR8f6dwpUD5+aLeJYvdwRjSVzxaEGenW?=
 =?us-ascii?Q?YgkRXzGyHx8Grwahe/s+3UTy9J3cnPS1zEiGyOItdlkOVb+LeGdjn/wdVinA?=
 =?us-ascii?Q?3U04iXvOX8uVyGO2oRQQp4gHEjHKf2hJX12UKaKVnbYyaCFWWa/b+B2fGMHO?=
 =?us-ascii?Q?G5umCyc8+gPHA1ERW15TFJUUEOnhnoBQc07Fj/zo?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <940BB3465600F6468A643DC4314EA569@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59139d2f-1a5e-4541-d202-08da70a2cec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:09:38.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfVg9SrrKs87y2y4bFpQBZLzjdSGN4r6/zPIRObr7vh2g1O+ZtgjVAA9NHm+yzHG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4256
X-Proofpoint-GUID: RkXfWCIFQVgFVZ9NQfsBnce4eCOzl3AF
X-Proofpoint-ORIG-GUID: RkXfWCIFQVgFVZ9NQfsBnce4eCOzl3AF
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

In order to allow a CPIO archive to be parsed without actually
extracting anything add a parse_only flag.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 include/linux/cpio.h |  2 ++
 lib/cpio.c           | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
index 7e9888e6a1ad..5b897d1d3143 100644
--- a/include/linux/cpio.h
+++ b/include/linux/cpio.h
@@ -78,6 +78,8 @@ struct cpio_context {
 	struct cpio_link_hash *link_hash[CPIO_LINK_HASH_SIZE];
 
 	struct list_head dir_list;
+
+	bool parse_only;
 };
 
 int __cpio cpio_start(struct cpio_context *ctx);
diff --git a/lib/cpio.c b/lib/cpio.c
index 03967e063c76..37e2e2071c8d 100644
--- a/lib/cpio.c
+++ b/lib/cpio.c
@@ -15,7 +15,12 @@ static ssize_t __cpio xwrite(struct cpio_context *ctx, struct file *file,
 
 	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
 	while (count) {
-		ssize_t rv = kernel_write(file, p, count, pos);
+		ssize_t rv;
+
+		if (ctx->parse_only)
+			rv = count;
+		else
+			rv = kernel_write(file, p, count, pos);
 
 		if (rv < 0) {
 			if (rv == -EINTR || rv == -EAGAIN)
@@ -136,7 +141,8 @@ static void __cpio dir_utime(struct cpio_context *ctx)
 
 	list_for_each_entry_safe(de, tmp, &ctx->dir_list, list) {
 		list_del(&de->list);
-		do_utime(de->name, de->mtime);
+		if (!ctx->parse_only)
+			do_utime(de->name, de->mtime);
 		kfree(de);
 	}
 }
@@ -374,6 +380,13 @@ static int __cpio do_name(struct cpio_context *ctx)
 		free_hash(ctx);
 		return 0;
 	}
+
+	if (ctx->parse_only) {
+		if (S_ISREG(ctx->mode))
+			ctx->state = CPIO_COPYFILE;
+		return 0;
+	}
+
 	clean_path(ctx->collected, ctx->mode);
 	if (S_ISREG(ctx->mode)) {
 		int ml = maybe_link(ctx);
@@ -454,8 +467,10 @@ static int __cpio do_copy(struct cpio_context *ctx)
 		if (ret != ctx->body_len)
 			return (ret < 0) ? ret : -EIO;
 
-		do_utime_path(&ctx->wfile->f_path, ctx->mtime);
-		fput(ctx->wfile);
+		if (!ctx->parse_only) {
+			do_utime_path(&ctx->wfile->f_path, ctx->mtime);
+			fput(ctx->wfile);
+		}
 		if (ctx->csum_present && ctx->io_csum != ctx->hdr_csum)
 			return -EBADMSG;
 
@@ -480,6 +495,12 @@ static int __cpio do_symlink(struct cpio_context *ctx)
 	struct path path;
 	int error;
 
+	ctx->state = CPIO_SKIPIT;
+	ctx->next_state = CPIO_RESET;
+
+	if (ctx->parse_only)
+		return 0;
+
 	ctx->collected[N_ALIGN(ctx->name_len) + ctx->body_len] = '\0';
 	clean_path(ctx->collected, 0);
 
@@ -498,8 +519,7 @@ static int __cpio do_symlink(struct cpio_context *ctx)
 
 	cpio_chown(ctx->collected, ctx->uid, ctx->gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(ctx->collected, ctx->mtime);
-	ctx->state = CPIO_SKIPIT;
-	ctx->next_state = CPIO_RESET;
+
 	return 0;
 }
 
@@ -581,7 +601,8 @@ int __cpio cpio_start(struct cpio_context *ctx)
 
 void __cpio cpio_finish(struct cpio_context *ctx)
 {
-	dir_utime(ctx);
+	if (!ctx->parse_only)
+		dir_utime(ctx);
 	kfree(ctx->name_buf);
 	kfree(ctx->symlink_buf);
 	kfree(ctx->header_buf);
-- 
2.30.2
