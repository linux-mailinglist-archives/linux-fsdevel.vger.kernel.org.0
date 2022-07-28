Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92795840B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiG1OKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiG1OKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:10:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE561D6F;
        Thu, 28 Jul 2022 07:09:52 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SA3AaR028446;
        Thu, 28 Jul 2022 07:09:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=aJE8ipRAhMVj75DqzMcPmsdE5KkTJgnRvLnquYiA1Jo=;
 b=cKboazccL4t6T1w2F80QnBhPC+sd86UpSPxIFVvD83G7J/BURNHvnPbhsrya2oePSv5C
 gR18Ldx0Mg7oQWiyVwUSPWfWx6sPGUaiRxCFEWuuBGS7Cl12yByizmbGa/xb2BrtN7jI
 tWiuzzFpm73Ujd5y5qvRaRa7ojbTwEwhT8g= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkfsk3kgw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnFjiHn/P7HaDRxx5uktrkBh2GyPgnisKcnh0aBCAbfACiFSDzAh2Gp/6st6NbiaqDws7F6e8jMZoCqu+eV0Le9B8XBYxmDNKT14nEu69FbimgNW55RpfLgGjf+IGE++xl3swBL5UhNmTGRe58frlTONR3Z2gX8HSiW7OPR+sSSlk4LoPYMOaqDnmiZB8uzBe4gXUmgK7it0xyoBhbu6PSHLMM0TNUtOscCG4VnNpnYLuBI1a4rzsEv4kcjFtcwuUZwZRn/V+hMP0LWwfCM3dxWVnOStlDIzr7HwXnYzGoc6eE2d2lc/f5bFLXqLKW0ZD8/Gxu2VL9kn6PgVJiHYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJE8ipRAhMVj75DqzMcPmsdE5KkTJgnRvLnquYiA1Jo=;
 b=dLN9e+JdLM7y2tLwL4ksJrax2DmdQrf3qU1ICK6zTB8E/LeXLFuPPb5RYu36BQlZkZCLtHNodbtH2pld1+zgXcFtjNVpq+51nzVsN/t1MjjqYt0NtdEW8pPoJrpStqSWlUYe6iVmaCusCm7WUtGg3s3Z1LBhQ4f29GtMa1loVZPESJUnLk43Ac+5gKplTKE0NYyAcjFornKdhvbTrJTuoWMFAO9WWnImCu0bQto8mYsJIaBRs+jW9TY0Stlr0l8Ie6ZteV9YBgcFTb9607Syi18Lj7fJf7tnc9kpnDQqJjMf1+u9/0Kga3RL/ifnp40bcqDlGRo5lkg8BYem5wg4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB3247.namprd15.prod.outlook.com (2603:10b6:208:3a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:09:49 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 14:09:49 +0000
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
Subject: [RFC PATCH v2 6/7] HACK: Allow the use of generic decompress with
 gzip outside __init
Thread-Topic: [RFC PATCH v2 6/7] HACK: Allow the use of generic decompress
 with gzip outside __init
Thread-Index: AQHYoouyabqQkkqDF062tKBAwVyHtQ==
Date:   Thu, 28 Jul 2022 14:09:49 +0000
Message-ID: <53e15800b5e1382bfa3ce4440908726fd808ac39.1659003817.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
 <cover.1659003817.git.noodles@fb.com>
In-Reply-To: <cover.1659003817.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 679a21a2-fc36-40f2-bd1e-08da70a2d55b
x-ms-traffictypediagnostic: MN2PR15MB3247:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+enTzvh/eMGAtDcYwA/kFu9KD0/agHty/Ibqm2mqHMwH2l5Ht9Xa/Uro1jJLRFRYhG8iWZCDkn754NA526wZVMtffbMx4nrPcj6PU85I8GlmuVX1NiFyGN+Wne7vlDxRg4ae8AyK78/uHa+lZ6QbqQqUaFgmoJec2baauERwnh5Hm/H1aGut7Nv7RvPuz+E7IrEsd2uJXsvNeWRkT/9djDYDmWoj+Dpr8GvS9rPrAvHpth/cOjc7LgZ83yu1bNZ8KLj2PDMcrautqdTLtwZ+Ima2myK+0dtJ/VV8KEF3ZJFWYARIjdN2jdbRPnCOVldsUnrjQ1AjsDuZjNG3tinyBbwJk7RWHwpo4NE8NBGWFp3w36dX5s08p1ESx9laUtyW5QEuCFDNp3SGZaw6EvI9tdhrWu/eQc5KIfPwxZVoGTwr+bVqIemqextYQO53S2bLPDyFlDJQmEE0/zy3W8xzNXAevcPCG3Ez93kA4Ag9OuKujQYhRHOZtyRVhzmF1QTm8x9AQ6zwWJPa6pWYwjI3q0aiZeX5IIxyAE17Gi1vA+Oy8lT/2sAedlyp+tEOR1Ew8mKlndwDjIkyd/yc3bdAbRVQF68TxbVSmxWoP1M5yr1jBDZkwIfq8XsMLkdgq0ZVFWweV2x2nkvK2NIr5fkPFkO+93E3ZkSPSWtoO2LvIakA1kmYPUo3vOa7CS6Qgo4tLBBz2W3nF+PeEtXfvtd65NMpfGZVIzINICwx8Dci0pONlQkqbzPbJEiZbexeotHn4aDf15Hfsi9IdCNqlG6PyzPwFCEY0Orgrhzf1ogq5y5yF+T2EmGVo69KrjlDnzwWI/NNWk3kR47dQDWxZL+dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(6506007)(54906003)(7416002)(122000001)(186003)(83380400001)(478600001)(71200400001)(38100700002)(6486002)(41300700001)(6512007)(91956017)(66556008)(66446008)(8676002)(26005)(2616005)(66946007)(5660300002)(4326008)(110136005)(38070700005)(36756003)(76116006)(66476007)(64756008)(316002)(2906002)(8936002)(86362001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?40oyHV3VcYMFSwNGgzUpLebg+qM0ANB7vrThtbrBMlMnpZXh7R8U8ySmDN1k?=
 =?us-ascii?Q?LLIfCgrldQLRIRJXlWkNGUSgQjqbsC6RG22+m1mWVIkMlmnezsnfmIi1bEd3?=
 =?us-ascii?Q?p2s6KrX4HH/r7qOQWIntURPc1Qp2989eZCFDxJnTl6U1UXubM3XExrMpEs2H?=
 =?us-ascii?Q?zSdr23rmbf8uaI2CMZA6OHSQK6ZRV2MWO1ViTOj/ukl/f8SbgIMYzTCuL8Gz?=
 =?us-ascii?Q?ltA3cRh5XfEz1lBvZ7KbQAveB979XzQCNj3uBiFXzhL039WixT/StK+Rb5J1?=
 =?us-ascii?Q?A878XKPz7xYy+9o9DxAAIUMP8p1N9yNb/wWoN/eI1+T3dzFD8kif4+9yl1TF?=
 =?us-ascii?Q?rHpCGinQ/MnCDcYED1BQIy63AyCCY8paoXrcssvfVM4NMTcYtwX/8aA25Pgu?=
 =?us-ascii?Q?BaG/rETEpKvu7OuSVBMgjB1WyRm1sh86ecpQFyql1gr/OzuvvwxxEAGqeHeL?=
 =?us-ascii?Q?2zwk1bw/+dvwmuiiTIr8KXjmjsxIlzEhSmyMbled4hCrpv0zrztM8Iyu5AVs?=
 =?us-ascii?Q?gmF+wN+s0PK9sOsUelfLhiKzL8poXuaNEj30l5VQT2FzNAEj0DiyDzQ4ast9?=
 =?us-ascii?Q?W12ZgGeBCx5+xyyO1L8WCwDBjoec2Ebsea8VlpfbuEFKw9h6xPJKU0sgcHXe?=
 =?us-ascii?Q?o/70hzVsuOOy2EB8X3siFfZEd0lzrwBdRVHIMC5zhOh7+VRLAFZB0VQuNX3E?=
 =?us-ascii?Q?/duPZxz6f63gDlZhxJO2oMVnlvP8Ru0tls0G47clEnGZ5sx7Ad1oT4LcTWh5?=
 =?us-ascii?Q?FgABhexsxRfTuCdcmEqUF1aCMUKjAl0ZKvor/rD22wZlyVOHIRW0O5+B917x?=
 =?us-ascii?Q?Tk9PTeF5OV2aR1ZzxB4pQmJ5UVxpLKRb1NIuQ6TKvqcl7RQ8efTFo7p1D17t?=
 =?us-ascii?Q?5IqkcUoGk8zAALMONBM5YDpmeT1PBmV3p9WMgj2cBCi4LqiakcsXk2St/coD?=
 =?us-ascii?Q?O2R4i1h4mjWyQnNl18e4xSHvJvYNWM3QcfeOZDyHOo54tfOBk3BOHX/QXvY4?=
 =?us-ascii?Q?0e7yHIjm5yQZCFP5VBb9NWbOchjawyiyTUTYyPObZU3lNZM8B3q4u71kkLp0?=
 =?us-ascii?Q?Ds8CLCaaxjj6m9SAst9etuDDKhjb5XuXIm/2DKk0zqrODe6k/vtOcVL5jJYL?=
 =?us-ascii?Q?CNyEToWKP621pUSa0r+ISaSud4kqaFTRdeKq5gfKTObbf9N9VSSwKl132Dp8?=
 =?us-ascii?Q?DqrhhS5QjeWvMHsFYYdL2Zf+wUjubq9YzcQlV3owXnG+9Qo/uhJZZ6GcnZcJ?=
 =?us-ascii?Q?41BmK4SrNgk1X+XFOKX9pMxV7G32OdQD/niLCX16NxUeylX5k2pBI/Fk5R+Y?=
 =?us-ascii?Q?CQtb8iWaM1qey1fVKTADsVd914t1t0IoUAhynw9rvRDLZHdE4+oF31ZQs7GV?=
 =?us-ascii?Q?bsJGZ5WTrLqGr8GY8sKKo3qjKN015/jas60MKNyhWSAY0fRrFFfDBbO2FdEp?=
 =?us-ascii?Q?r29oy233Rvkf+Aw54I+0cxDOoD0ahTNU/c9p6GltRNefvOiF/SKwYpbrwJL+?=
 =?us-ascii?Q?9rCfTOHZg+Sp200v9d0RraqHnbGzFyZGV3sPhXWF6IpQ4K+pn/+Evav1Nrkb?=
 =?us-ascii?Q?79flnI8LU1BR3VyuNpOEjgzmqRjEZxkjX5BsZFEk?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <477B2E5FBCD8064AA1D6F3FAD22F50C9@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679a21a2-fc36-40f2-bd1e-08da70a2d55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:09:49.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0cHsjhYCZ8auUr0o2oWV1iv9OEBsNnsqHZP5ECeP4X/FytRJ5duPvFs1a2yus4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3247
X-Proofpoint-GUID: wU1VxvurWmDl3lEGE7JNRuZNo4GXY5SP
X-Proofpoint-ORIG-GUID: wU1VxvurWmDl3lEGE7JNRuZNo4GXY5SP
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

The generic decompression support is only available in the __init
section. Hack this out for now with gzip for testing. Longer term this
needs rethought in a similar fashion to the cpio support.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 lib/decompress.c         | 4 ++--
 lib/decompress_inflate.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc64..89a5709e454a 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -48,7 +48,7 @@ struct compress_format {
 	decompress_fn decompressor;
 };
 
-static const struct compress_format compressed_formats[] __initconst = {
+static const struct compress_format compressed_formats[] = {
 	{ {0x1f, 0x8b}, "gzip", gunzip },
 	{ {0x1f, 0x9e}, "gzip", gunzip },
 	{ {0x42, 0x5a}, "bzip2", bunzip2 },
@@ -60,7 +60,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ {0, 0}, NULL, NULL }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
index 6130c42b8e59..b245d6e5f8a6 100644
--- a/lib/decompress_inflate.c
+++ b/lib/decompress_inflate.c
@@ -33,6 +33,10 @@
 
 #define GZIP_IOBUF_SIZE (16*1024)
 
+/* HACK */
+#undef INIT
+#define INIT
+
 static long INIT nofill(void *buffer, unsigned long len)
 {
 	return -1;
-- 
2.30.2
