Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9156B6DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 12:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiGHKMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 06:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiGHKMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:12:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E66684ED8;
        Fri,  8 Jul 2022 03:12:35 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2686IFFj028448;
        Fri, 8 Jul 2022 03:12:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=D5UZlRMEIRV2T2pFb6Ty03JZQMkDGOiv12a6PyZkxmk=;
 b=H9wQj4vFte9ukhIZaD7o7/VUIQ/WwF++Clqe0DPgwrXzwTdyz7INADkzmBXGQTXO3L/1
 K44A6T7afbX0o6BiZhlKE9zfEvo0cV3Ln45ScwDNcay5f9OjsSFBkrNUNZGqMFwMsr9R
 N+BqNpYO0fQX0XEI69yMD7IfH9PptfUAnS8= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h6f69gxqs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 03:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz8HRg13MdJPlupmouOJCpvnDK9r7ZaFDD1W59BD+A7fDnxqfjWW59w7RBgnZOACUF5LEAEqsxUHEEvwPX1H9t/DlMzmCtj2/bUOrEpsJmV61Bvw+Tvnw6XXNheN4D3MO/9SBgbXlJRPPUmXYlYetSQ6MnrAZxCQ+t5yEjwEmBopH203tNsy7xZaahLPp/941crJ6pUW+5rqOkfG+lCltbEkJWzvBtqTrzVf8T81xwgjQmqVT1ndQDMK6Arszm8MbOggPa+PbZFPNrLmzRGIMxbHzodcF7tLx6yUF4gyCPOS5VN+6NotFkQYbZOQJJG35xb5bJMaHNBKqWa1ccNp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5UZlRMEIRV2T2pFb6Ty03JZQMkDGOiv12a6PyZkxmk=;
 b=iA+2v5w8uESd3GLqd79E6ek10YASlh5dOEg1d2Q4A2p37SuOOGMzpBKTWGdb7d22Do53gS4/MDjWMrqZSKOs6q8iEoB9s8m9RvRjua9bpNTjf231/u476XB0XUL+Ew3YdQdiQmufgWrpHOIgHk9B5uZsi8RyeiVJ3m7DfmIntjdf9eZsOREEr+P7bC5mWbnZE9UEIMt4Yo82DkzduAjPb7DXAOkE70MBNs3/B3gqDbN2ZyTktAse/mra3GJhWGGO7o5kexftjJdAXLed6svvFXZw/HvR+CwdrsJgZkTs9shaA30iiOX1bEwBlrtIIQMzDA2pPGrXm87yJk4IHQ7QTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:12:32 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:12:32 +0000
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
Subject: [RFC PATCH 6/7] HACK: Allow the use of generic decompress with gzip
 outside __init
Thread-Topic: [RFC PATCH 6/7] HACK: Allow the use of generic decompress with
 gzip outside __init
Thread-Index: AQHYkrM9uTGnvX3+A0mmGfCUTcA11A==
Date:   Fri, 8 Jul 2022 10:12:32 +0000
Message-ID: <942e53a4062d7915b5e90e370742f18f42741fbe.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ff9d7a-e73e-4b80-6bea-08da60ca5f90
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xz89tZ6E1RWzoPXNXP7EPQ/yhEWYzB0wLh0Be+JSMntO9ycXHt67EsWMYYlH9zk+2RL8qXKthKdcZGKXdLCiy/2EcOGrc5XQebtpsNM8jyD3BAALzdSq/aNxc8F7OAh6dGBpImJTAGHmWtHxkGlce4u4s7Mihr1tLYKLKhJoMZQNBEOgB5CxcXvHoxe30BnduYTeCLCvc0Qli8WDLsDQuO4jPx6zYc/Mulv2MuLlQRTeZ2XzMCxC0sO6ESy87KkgpOqsrKcpEg916xvoyRp2yjfKeOonHlQ4ahAdXV7u2SCoIM3sXQWaA8IaUEe6FJ7emETWBaOgDd6CPGtjEz4Z7Q/9GomKoVc7wPF/URaRrlzR0zQHH2a4xP8TS8dXbnl5lKZSw906DUGg2F9lXOgXaoBzojVhNEzMU1wvggpnXozUuwDL+4YCN2SJHeUDjs0y9LcLqvqhg3Hx5oSPegJvU0epFo29axGnaa0JeWHTD4hBmxbNu5tvk9LoHsGk+09e0Tm1Zq4UmNBADjgMJRgdmoXcTLMM0mujNB7vqOJxF6Wdl7FAq/Mh4VUAhLVSggsjN0Yl3wJwfW9nUJ7LYaoff7XzslZDVB7y9t0Ghbinwni4kLe1ClDXpErDEjBQ5BGGSRcsnAKW/7SK787dQ7jfutNEMEzgnCAz5kCUgbN3KdU8Y52b4PS9fEktZ1jBJ+a5OEv/wg6s1r+UyJK/HDDePPUnNyEPauEeD4R5BYoslsn4qMNcTVGKrPgESOIV2JY7q/4xoXqyMBaryhoSNAnT8d8r0CJKyb4iUo0Y0s9L9dxj/3E1A3FXiIUQSdQuo4W+VN1KGmrxLLnBNV4Cl05lNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(38100700002)(110136005)(2906002)(54906003)(122000001)(316002)(7416002)(83380400001)(8936002)(2616005)(5660300002)(36756003)(6506007)(38070700005)(6512007)(26005)(76116006)(91956017)(8676002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(71200400001)(186003)(86362001)(6486002)(478600001)(41300700001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xuIsnMou8Xm2uXRyfS1tNT0ZNqYxL3DGCa9ndwigcx679+VajcF976vbXzHX?=
 =?us-ascii?Q?gMhwUkpPQe92Fmun8TOhR09TMD3jY/fP1f09UP1pMdbNicZxfrg9aEoS8IzF?=
 =?us-ascii?Q?ooir+CmS/LWQ3bObLNijvye0lpG1gp2nOuqcxD+q8ysJm/NHCUZRINsK/h+G?=
 =?us-ascii?Q?HKp0GpgGMRkp0DeZ3ceQk4KtFHzAgQeFPqrbdsZaWIMPxLa04uVBk7+j+/Ta?=
 =?us-ascii?Q?jZSy7+qc2FYDVIiVHai6AI2E7Wn6dUHVwlL/fzJXfKFHR9wtRDTAoXQyxgSm?=
 =?us-ascii?Q?5RWEW6nvlSNex+pIZftUjTNFo22a7Jc6FjUlyYbhApAmkiTyFxcpwPzjizZe?=
 =?us-ascii?Q?bwlFaDo7hxhsvLmBsl93ouUVdVBOv05C0vsU86/y8JC6KXA3LuAMEvmcMm9V?=
 =?us-ascii?Q?mrUZetU/+LATxc4eVrhdXbvPxNKvgv7POz7rAgwVebfoBFJaR1vGQlOyGBGc?=
 =?us-ascii?Q?HJnnOabN+M2X8LucszGittTyTIHRPHnOctbZM3V4motiKFU7k1Orb8Wgi87R?=
 =?us-ascii?Q?lr8YwpuZpoAOagc+5X3irxNWDlI34stsd+REHpDEa3a+Q7aJpBZmDpZIeXZN?=
 =?us-ascii?Q?rjZb9CZmwO9SPO20ea429iayTVJUryboGKzObb/AoBIi8a71YUYvB3YEc2L8?=
 =?us-ascii?Q?NYGeoCnV9foS6hP83NqcwRuMRaIH3QRaH7I6QvqAcDx227ImYjwLL28KQ4ej?=
 =?us-ascii?Q?ik+HvekwCCcfrVLhBlxBTy82/M0JBssXpKYNk3BtxI84qUpUqx08Tr0rNpr9?=
 =?us-ascii?Q?MBBIStzz33tEXw4JRJToAkv5St99VZMpCJh/1Ub/RU36UmBF5jnwyJa1S15J?=
 =?us-ascii?Q?Iatv0S4EmEOa+LNF9doK7wSWf29EVkG18lj4jFn0UjOge9fVDV8D6dXx8moo?=
 =?us-ascii?Q?Obh3mffwqI4GxI/BHl9GTr0NvZze3ww0wsinUmcPnjamWg47pGbhBBQhVMeN?=
 =?us-ascii?Q?/UK7e0xjml5pfhSHp2151nw6LGukLxyFdqNwQVx6uaR/cdFPDEC9NZlINZJr?=
 =?us-ascii?Q?Qul8kp/KDhHpqkO1G3n0NDTo5qwtD5aaFW3/yyWw01j79vdWJenaUdiQKqYG?=
 =?us-ascii?Q?3Ps9G0/qi3nOAEXTcWvgtavlhhcdVHqT0Wp0F4TgkWn1mhoVjOjjRAnqbsNk?=
 =?us-ascii?Q?BH4FELx2dU/s4IsHyQp75Jq0C4YDBJXdWvAv+sGKhFZZ2Rj4lYy75Ry58s1E?=
 =?us-ascii?Q?AhO49MZwSFLxmE+3ahpoMXnn3SShgcK4uMVQmVLNXBfuaN9LZzgwN+cIUXAb?=
 =?us-ascii?Q?V8u81/RCn9k7U46RUN2MKnRrONuY0KYFPANmEzxm3x/AZfPIKXQC/dpj9YGd?=
 =?us-ascii?Q?spUD1VnlY7AFO6bK5mby33dTP3HoOy+MJVJwIlBbVrj9tjdXLpYs9h/KDuDy?=
 =?us-ascii?Q?iQe69ecqCiH/+mfM2ihYW53GPpk3+OxadBGm+FWrUZ+3sj8ByNaO6RLO8Lem?=
 =?us-ascii?Q?9AWrb+TihJc+Qbnr9hTIlBqYscR2c6vVXfZVq++pTtrtqLUiRkDur75u49qm?=
 =?us-ascii?Q?3dLYK9VUg9R0ndy8acdlRsQdZX7lG7u99nBdiVp/cMi1wXyhJ3NZqsV9DmGN?=
 =?us-ascii?Q?CPKhl+fh+n+xx8H0cDYrk0/Jv4PCMhu2E9myBCLY?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD90B919620B584AA0A24A0A7FF54A67@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ff9d7a-e73e-4b80-6bea-08da60ca5f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:12:32.8993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6BSxXFMrnJOxc1pTr/X9jvGxn4fAj2UamSfHNamJZqRtngLLQX00wZcemkgACHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: 2mNxPY7shnpBdOyeUn52qduFvv0AaXmj
X-Proofpoint-ORIG-GUID: 2mNxPY7shnpBdOyeUn52qduFvv0AaXmj
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
2.36.1
