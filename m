Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D79C402FED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 22:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346984AbhIGUwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 16:52:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47548 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346937AbhIGUwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:52:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187HpX6O002592;
        Tue, 7 Sep 2021 20:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=tvz8+mSx/6hAxHUxDTynb8tn5ymhX7NY1MEMEv78HNI=;
 b=ChcxgB9t4YcU5MqASR2kpG7YoeJlvOnn8c6kFuK6Sj6c6OKT04C6DcMem/HyeW7H8SoJ
 V4o+Bh0NYbIltyW/+qY7gQhNU0NTl0q7aVYhDPCnGVxuYU1sooufNmHRO19KLAjH8c76
 qRdfzvffrGiRTxU+ZXZmRMYvWJ6sH1Rrr4dqE7awyKr5v25qcgNMyAFBvWR/ESMhcUs5
 Jqv3wfRD8RI56l1Cu6664ruBWLOC/r8kSyVt1afn0uqCyYZayq0kGIG3qfwYmRj2qOW6
 cTV1deILrPsPWJDr1Yisgrz5ilF55nGvpwWInp5qkaj1Stwo2eJWRb51iOCGRvtB0/Hq 9Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=tvz8+mSx/6hAxHUxDTynb8tn5ymhX7NY1MEMEv78HNI=;
 b=S5iYy6aoPHsf8dSt0TC1Sx/mwgKrqwe9MeUOPn+fi7CFSQr/kEvT6+XwniR8CU8vwuho
 eth1oJ18D96YxQLSAH6V5M9tx3E+hZK/FA+0eKXhvSyG+XpoiBYRaLp8VQH4EyFDsVs6
 r+PzPw2zVcTKncEK9VJqUL9ATWlrmR834x2h3MlkxuoorzudZaZdT5RNXfO0UAUYbdMt
 vTVSeXogMdACNwWfTByV6vIrVtXmY+ERb7O4PVGi+AS7R6dlKCzJXEFlKcMpDgGHB1Ay
 VlApYVQtg9rFBAu2CacWetsWZPfXoYxcFnk+69+i8P97fibXZTiNJnpLj00BiWDEEpez oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuq8eg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:50:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187KQFRF185832;
        Tue, 7 Sep 2021 20:50:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by aserp3020.oracle.com with ESMTP id 3axcpk7tjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsV+VQxRIJqN0oQDKedp7k4Ic0imlbB878c7iFau9juV4upgbWlzW3COCBcVXROFX+jaNbVIJtjhNiYDK6CGx2S4DjmvPTF9zVqb7b46EycJeQA0yQXLTY2IARRqDTzuXzFzNsvNI6SrnMoexc+M+1GlSHzVOIeiwgxSZtUwYCJ45AnqAul+rliOCj6h2Tdf0BEqAg0jEKaFFSxk/45Qo1J9Yf0llDRSqC1V358+eiNWrag41rxnwJytKkFGZO7ziYdWfdYYWTo72S9NRcIkRvT8338HiS1X3fR2GV2R8VzyycsVFSVpGfIsUUo4v4nkpBOWS7rn4FhnfPapzhd4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tvz8+mSx/6hAxHUxDTynb8tn5ymhX7NY1MEMEv78HNI=;
 b=UW+rR3uUg1Bkiv4BqFm76aA8RV3MSMa/Vs0swzYNXEhL0Dg5XX1d5ygdZ17qy8ZYsqrLdOzimZ7nXD1Rpq5oP1tJd6RmVcBJh7WT1PkiCsdMUfoUc8V5W8NFnnFPkHJB652ZgvaJ8uTiuiQj713fzDxaFNXwh1qxxfmqYdfaGiqtwRQ6z06YLgZLUmcLJrOV4Nt7kB2hYicEL3A0vr4X5VsZ66a7wmDnz6HhI6YLidojgr2v5AJ7UCZP6rWBQmb3J2fbBDrF/2fkRZqtW2JiAI5xuruTb82A3jsjQXPZhjbkCwNO2VtIQJTafmbX1udetLbDo6qXgw0/zKqUBddWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvz8+mSx/6hAxHUxDTynb8tn5ymhX7NY1MEMEv78HNI=;
 b=FIeL767mTiUPdglCEGp0XBn9K+5/AXZABKU5/8iZ60SefXxakaRZ9ZsY+am0xXjzgsehOq6kEhH7tJ+oiNfGDbxPFlHGAlcEmqgKcGD+StdCloBLs+V86NhVBfffCuCM0RdizPRfcj2i5ORROyKXyk/CfrZSdtijeC2JtTIYrkY=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 20:50:49 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 20:50:49 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] namei: Standardize callers of filename_lookup()
Date:   Tue,  7 Sep 2021 13:50:42 -0700
Message-Id: <20210907205043.16768-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
References: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35)
 To CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (136.24.196.55) by BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21 via Frontend Transport; Tue, 7 Sep 2021 20:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427e157f-5138-4fa2-69d4-08d972412c58
X-MS-TrafficTypeDiagnostic: CH2PR10MB4149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4149FE7CF5F6C11D9257000BDBD39@CH2PR10MB4149.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SjlOc8RWCd5Fc5dwgo5POUuUf1bf7WKgxUWLqNGHE4zdQ4nABdbMkmSXke8C?=
 =?us-ascii?Q?vghrKlltwGAUk55Q9Wk7JQ9baW8lwNPpE5ka1DyhGXyXUb2rar+ZBYPe0PIF?=
 =?us-ascii?Q?0y4RCcpyj04xJvoECSkPSufzPrvQq+55iRGvFaF9jKPeUIt3x1yIHoxOMPdI?=
 =?us-ascii?Q?3BJ09u4tYpwd+r0CT9LYX4mljn4XxxgJvVY5fT8KHpdQBuulbmXZvWQF+8Hi?=
 =?us-ascii?Q?oWoKZ1lMwCUb32R1RnJcgg0CXdqtDHtGss9xpixqhMMr8Yi8C4h3WHHKLCw+?=
 =?us-ascii?Q?gndH9/NPJmgMs3eVnR8ttdsGcrKx4/P3+zqhX6uV7edqr3z9VvDzhdfPiO2/?=
 =?us-ascii?Q?Hn/iL0p97Vl5YZ2108ci56YUsLzcifwHsgWjakhzbXIFot08MlxWPOvo+y+k?=
 =?us-ascii?Q?xVZ4IKiJjfK6w82H16SmK7ZHwXC8MjlpO0kHFe76XOR1sJvnu8K372G5aWcs?=
 =?us-ascii?Q?HVIxZQTgD9HBeuu0G2qb2jwpoGDLmiOlCsHNZ3dfWdeERavOOmCYT5WoDsK0?=
 =?us-ascii?Q?aNj9MxI03hquimd76cfznhHY71IkoOr9WxxbWHLbmSA0nsyPJqxn6CHFSR2s?=
 =?us-ascii?Q?Rzl4w2aUc8ObT1du4pW0ETyEW6/lDP9ig0f2AUke3OKrFbvu2qI7ky70Lr3F?=
 =?us-ascii?Q?31nUfZwQp5b+nMmkaeCsaIArgqIKYgvwMTwILaZZd8rmdQhABDzB8X6IodlI?=
 =?us-ascii?Q?gIGZAmQVS9l64wY819xGXAZ7Ok4JB4p4orBIsZUghi5fJthH4C2f5GiSj2As?=
 =?us-ascii?Q?nvWSvdb1GZFqrXep0wrCVURswv3CQR1NMs+hRuI7W04GuVj89aL6VFGFFgxN?=
 =?us-ascii?Q?ykJVZa14lSdl45K4+oQUqy+mO8ZkcpfwyJrSElVRJqdlBaHrnisPz3WZT+EI?=
 =?us-ascii?Q?Lw3jZ+R3JkrJ4YHDqrr9Dyu3a5rJcHbxIRQaIgTetnWKR9/VymM5VnTvALa0?=
 =?us-ascii?Q?LaN1gHB71usGBeGVQmA35WSu2om227J77i0LhnAC//I3fos5FxVeqFTO+OEl?=
 =?us-ascii?Q?uQDgMj3zmaN6k9kIYPtlK6b8DEvzhZNOHNi1Ace9wSiRWn2OViNVo5E0epN1?=
 =?us-ascii?Q?WsHADrZVrBJFoVQMIN0PACA/Y53TGLsDklz9TYIS4/LyseTbNEY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(103116003)(83380400001)(6666004)(26005)(6486002)(86362001)(186003)(956004)(1076003)(8936002)(38100700002)(2616005)(38350700002)(8676002)(36756003)(5660300002)(4326008)(66946007)(66556008)(66476007)(316002)(508600001)(966005)(6496006)(2906002)(52116002)(6916009)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BRkWAL6C5G5Z1KxQfCUhy7SL1LRYXQhHavInoBdu1asEczm+G1c/jgXMgq8g?=
 =?us-ascii?Q?NdFRpOGRWuzSBtK22u1JWlx5NsUiITSfb+EBCUdyQZrwPLhfOByo1IKACJhP?=
 =?us-ascii?Q?NhLy40WVR+1UukpFnNoFbSdTZnc0tXXBZUOX+XU8worgeinqMK5o+hIXiQIB?=
 =?us-ascii?Q?H3jwtFt+2e/HOi7R685ADYDV2G28zhOBr1XjRFFRdZi6EiLZrakRtNo1CF/Z?=
 =?us-ascii?Q?LnWaw9rPPpuU3wj6ToamuTYAJ90EhZrnJQ/6KuUhQYgpaqT2XwVgTRj6WqsS?=
 =?us-ascii?Q?9qx5xv8JvuItkoeeDcBeMVrZqsk9ZaTgbHub7o0Bbv9sAWX0CRE4rIA8LuS8?=
 =?us-ascii?Q?HYc3THUFw9VJ7hovapqzGa8hOyhI7lgn877lgroLfUQZ2LA9QOS4MvfUZ6Iu?=
 =?us-ascii?Q?NXcG6TBMzJ4UV7634fy1l0xCGxfOcWAa1n6+tlYhTXbsGW0f3IhaU5VhaxRy?=
 =?us-ascii?Q?zNszGlndQI0e85XuFc+Y1dDzvswQK5XPWy6Ahw7NWqyf3DVJSwpDmWcyeyCB?=
 =?us-ascii?Q?TLI2TbuglkITfx+LknFzdrSMM8bFUsHoutCGdeJnDC85nrSW196ogESgwfc8?=
 =?us-ascii?Q?beI8b7z+sm9r5R4fz2GjjudyBFVao2R5emPOG9ElT28nzT1aWv1EoknDXtLd?=
 =?us-ascii?Q?kXDJtOvPjSnmKo7ltEJCAmNJcG8Adp8G7fGkY49F23fahza3vqqhsYxz6J+5?=
 =?us-ascii?Q?6a550AhWCXXtxTYBftmxLcfxBaG4QMk5eYSmGGdJ6ujvjOeZ36jy/uM+I71z?=
 =?us-ascii?Q?azyHNbxuYJPNyo/URpIH7XnegSm/JvCnoXl/hA8LKblaytbrp1ORYminhAQL?=
 =?us-ascii?Q?Gwv+nDMh9UxSLNNhy5gYbhvqOzbGqzcYYFOn/1Vkh56CaQqBdA67/gSFjW2s?=
 =?us-ascii?Q?Zyp4lqH0VnnWQYcXtHT5nTsnsQXI+D6N+TltwNaB7MBNRFyVrTg4vN81TFX9?=
 =?us-ascii?Q?GCo4Y4nQviffRDTdBPQ3IFEn3nXX8SACBucdpCFy2HdhT0uFztxSXMvJ6loa?=
 =?us-ascii?Q?ZmL6QfDwSiKMGsHHsd6cdGn97DBZ94hSCB1+UVdh5FuE3Zq4jJBGZnhHSQGq?=
 =?us-ascii?Q?or+jYp2qKmPCOuhhZ5zWWulmrpjOpUA617cIFyfKjUCKYEUqxZUp61F4n8o7?=
 =?us-ascii?Q?8LYeu5UfFQN6IPibxdp3JwWfgEqd7IP9+x2hSsxrqUqbbpydpnQKYQuBEVEf?=
 =?us-ascii?Q?pbZ1T4Owv7mYgSea+TI2K26/AEK1ggbvzGkY122zSKWyT7odFZBglyty74J/?=
 =?us-ascii?Q?BWgpcOWPsNJwecM25uaEy/xkutsFC/mCyGliFvzIB6fSLu8DRKJmTtwbo/Ky?=
 =?us-ascii?Q?dFiKM0N/GrM36yQ7f5nBZc7C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e157f-5138-4fa2-69d4-08d972412c58
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 20:50:49.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXuI7uYXNEdLNg18FEtMptXw9umiDihK8Zz84qia4daxOu+d1CX80RzYSjGp3jCZMTJBylmbXhNK14G7Cj1Hbp56Z7CMOGQ3eV2UHxriPEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070130
X-Proofpoint-ORIG-GUID: a_UsUKEh1qK5YZxcKWXTdDD_5Meh9Syx
X-Proofpoint-GUID: a_UsUKEh1qK5YZxcKWXTdDD_5Meh9Syx
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filename_lookup() has two variants, one which drops the caller's
reference to filename (filename_lookup), and one which does
not (__filename_lookup). This can be confusing as it's unusual to drop a
caller's reference. Remove filename_lookup, rename __filename_lookup
to filename_lookup, and convert all callers. The cost is a few slightly
longer functions, but the clarity is greater.

Link: https://lore.kernel.org/linux-fsdevel/YS+dstZ3xfcLxhoB@zeniv-ca.linux.org.uk/
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/fs_parser.c |  1 -
 fs/namei.c     | 41 ++++++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 980d44fd3a36..3df07c0e32b3 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -165,7 +165,6 @@ int fs_lookup_param(struct fs_context *fc,
 		return invalf(fc, "%s: not usable as path", param->key);
 	}
 
-	f->refcnt++; /* filename_lookup() drops our ref. */
 	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
 	if (ret < 0) {
 		errorf(fc, "%s: Lookup failure for '%s'", param->key, f->name);
diff --git a/fs/namei.c b/fs/namei.c
index f2af301cc79f..76871b7f127a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2467,7 +2467,7 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 	return err;
 }
 
-static int __filename_lookup(int dfd, struct filename *name, unsigned flags,
+int filename_lookup(int dfd, struct filename *name, unsigned flags,
 		    struct path *path, struct path *root)
 {
 	int retval;
@@ -2488,15 +2488,6 @@ static int __filename_lookup(int dfd, struct filename *name, unsigned flags,
 	return retval;
 }
 
-int filename_lookup(int dfd, struct filename *name, unsigned flags,
-		    struct path *path, struct path *root)
-{
-	int retval = __filename_lookup(dfd, name, flags, path, root);
-
-	putname(name);
-	return retval;
-}
-
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
 static int path_parentat(struct nameidata *nd, unsigned flags,
 				struct path *parent)
@@ -2571,8 +2562,14 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
-	return filename_lookup(AT_FDCWD, getname_kernel(name),
-			       flags, path, NULL);
+	struct filename *filename;
+	int ret;
+
+	filename = getname_kernel(name);
+	ret = filename_lookup(AT_FDCWD, filename, flags, path, NULL);
+	putname(filename);
+	return ret;
+
 }
 EXPORT_SYMBOL(kern_path);
 
@@ -2588,10 +2585,15 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 		    const char *name, unsigned int flags,
 		    struct path *path)
 {
+	struct filename *filename;
 	struct path root = {.mnt = mnt, .dentry = dentry};
+	int ret;
+
+	filename = getname_kernel(name);
 	/* the first argument of filename_lookup() is ignored with root */
-	return filename_lookup(AT_FDCWD, getname_kernel(name),
-			       flags , path, &root);
+	ret = filename_lookup(AT_FDCWD, filename, flags, path, &root);
+	putname(filename);
+	return ret;
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
@@ -2795,8 +2797,13 @@ int path_pts(struct path *path)
 int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
 		 struct path *path, int *empty)
 {
-	return filename_lookup(dfd, getname_flags(name, flags, empty),
-			       flags, path, NULL);
+	struct filename *filename;
+	int ret;
+
+	filename = getname_flags(name, flags, empty);
+	ret = filename_lookup(dfd, filename, flags, path, NULL);
+	putname(filename);
+	return ret;
 }
 EXPORT_SYMBOL(user_path_at_empty);
 
@@ -4421,7 +4428,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
 retry:
-	error = __filename_lookup(olddfd, old, how, &old_path, NULL);
+	error = filename_lookup(olddfd, old, how, &old_path, NULL);
 	if (error)
 		goto out_putnames;
 
-- 
2.30.2

