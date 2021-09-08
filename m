Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82BF4031BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 02:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347223AbhIHAFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 20:05:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59518 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347211AbhIHAF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:05:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LTZC8015703;
        Wed, 8 Sep 2021 00:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=eXe1cDPrmwEam8jFfF07xwr+AbpqC3g7UhIrlqDWgq8=;
 b=CCRdabzhV7VES499ACtmGBD3QXNNHlWDiWI+8skcdLR1YDUQAQCVNvBvrc8FjV8totVf
 09ddrdm9uWcImIHYGtYfWW2W5ElJnRglGm1VR22GJu9OfoxMiS+VWnYzljQgMFTceM0l
 KvIjpZgSmpv3bbbBrOdbNdQpgT1Sg3B8LUhEYdNuW0ubxBpLks7D4msmw7snABzekXYU
 lHkegqEwBOAdYwIBogEdjj6Q6FJHwW4vqWxyD/bI2zYeXxKxM3dOPKExFHnbxg3Npvbe
 64jpQlex47QFywiMB0SomLUr5sW7KjYeqCAh9Fy7RF1Ro3lCwEeZFoSyUHB1nAeeeHEv rw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=eXe1cDPrmwEam8jFfF07xwr+AbpqC3g7UhIrlqDWgq8=;
 b=K5yJMMgaZ52anyI2ASoSriKFuYjxCVfgjOvw4DqHET9fcoOLXnU7HtqUIB3eGGuq93x3
 Eos0Q9TILXT698csDVi7k2pE2govvw5BwrQWFrq/5i2wsxmMvepvFaHKD//FIVoAGZPt
 UT3d4KwEHdMmCuyLf4w1CC5vAi0ciIOyejoMdwN2UVFD3dBqidoxVwzKP5gWVfuR6yI9
 FkqKZ/BG4nKEwcA4rTkfeUPQXZ3+jt4o3347pdmY7Dy9eXDZNUWjPdE+dLTO9R4jRYRk
 F9OOAP22c0UXukCuP02yJl4TqCsq/emEPhq/HRL06ecmDIiPhmgpDieRrl4JtUQeGQ5c yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuq8t6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188001NE017221;
        Wed, 8 Sep 2021 00:04:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3axcpkebt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFVLFz3goRJYrf6+tLkVy2agJy8lr5J2rDjfm/8LLt+Y5U9Hm5+KMSOQuJJv2oTFGq3ESdRwYW+V7SJ6twomZ2/tpklq1QNQuXogK/c6ZKXfCmD295yGrl5E4eFAlRrLO7ATXIYeTu7l/c0DmV0BkZLBPlh7QXtT3ChQvuMMqOHd1NPGvNPkj+ngKBvqi4a2Zsa82S9Khf4rXRuYaQkC82M7tRJfCsYLOW1roFuw7XtgezKT1O5nLrymp5JaI3IN1c/G5NeoFqShL4g+x75+BpEa0K8sA+N1urO7t6seQMOxYU+LZbOBZFWb2iQN5c0xqVetcaydj8NY3awXgtSCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eXe1cDPrmwEam8jFfF07xwr+AbpqC3g7UhIrlqDWgq8=;
 b=ApeQiM7x+jYHMp3OsBkhZK1DwTgLLOEtB09H9SzlQpNTDW1sAXOmtMQXunW/DZpZRHlEdS33DeLlx64ijeDnI1sjYt32yRzYeZq5UH2detOLI79Tdlp7H2M5p2RkG7Mw/kopZHDOk+fQZMCRyAcDGmcjYKkwzGSXNPgre7zyQ2MFz2uYWWIVD+hVYp4vP9HBnYwaJ5Sri9I4TWhMZyGx0+Pp00hnNoXPBMlzJX2ibRT+V8Gb1O7AtEDueDgCwnW8+pEXU5k3xVW+K4LtG5F4ATAcC6dC1a+kA052kWZCsS8XZgUPUlz0FV1qnuhGyfuCLGebLvofUf6fkg+E+PVd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXe1cDPrmwEam8jFfF07xwr+AbpqC3g7UhIrlqDWgq8=;
 b=LB6mTlmUwjAWoxwKbqpguerQSZh/yiE4WRQtzUc7zwZC8IbJ9hbOwSUZuqWyn9/3yd2yjGTHbwe9/4Rmj5016QrwNP1jt+Kbr4GYj8DTXWFM0a2scn51aCmbzL7YT6SoFTEH1mOhCEpk9jkO2KlE9t1/GuVSz7qqe3Gxio2O//g=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5147.namprd10.prod.outlook.com (2603:10b6:610:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 00:04:19 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 00:04:19 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] namei: Standardize callers of filename_lookup()
Date:   Tue,  7 Sep 2021 17:04:12 -0700
Message-Id: <20210908000413.42264-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
References: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0046.namprd05.prod.outlook.com
 (2603:10b6:803:41::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.7) by SN4PR0501CA0046.namprd05.prod.outlook.com (2603:10b6:803:41::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 00:04:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 851969b6-f0ff-44de-6bd4-08d9725c34ae
X-MS-TrafficTypeDiagnostic: CH0PR10MB5147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5147BBB8DEB7689AF1180681DBD49@CH0PR10MB5147.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a2Qg+YuooEjGpKL2fd7QHEgLPpYJdHqtTE3t5F8L7LmCy0Wv7eyW6QjA4YJD?=
 =?us-ascii?Q?PuFjqyo9/CHbXFmZUu/BCbSLhRL0q+w9UqEkIr26THddUU0cI0PzljXHW8gz?=
 =?us-ascii?Q?TFOp5y1uFUUVnbpO3GS9FlZ+mblFj3ZOuXTs31MJYZSnCydsjIv0+29FSSLf?=
 =?us-ascii?Q?j0i5x4Nba024giH6xiZyhjfqtJggqSufO/eAp/bCZH0+RcnSnbwnxgFoNNYk?=
 =?us-ascii?Q?aj1gJ5Wx5hQf1DNhDpNnQQRXMNKJ8nzj0y0t1Q101Rd2MlD+wg4aWdYzPd+L?=
 =?us-ascii?Q?5v5RB7B0RA211JRDeo1/R2iVZSjE+ebpyGjpZztiKOMXSLpsYOpY0njHQeoK?=
 =?us-ascii?Q?5lf0d1kyL03aTP1CmtZjTZtRYUxovTfhxT9h++1rXMq0cd5bIbal5UALNruk?=
 =?us-ascii?Q?mQ2qlvPmjoBNtfx8gCOeULEmK8yd8GyDfkHTgO3NNeszQH/Jm1mSrAl888Ov?=
 =?us-ascii?Q?cwiaOXNThCG9fJC6koTNMYO/bFwfo753oOA8aLsRFWhnG450Qky4ugs2JaJw?=
 =?us-ascii?Q?VODuFdL+xyR51yqRQQ66G/p+ew+qtaZ6wp9GkQaHkc46vh/QX5vY8Hu5WsYE?=
 =?us-ascii?Q?gJ/A77m8kh5Lbrdj6DKSvr256gXbfeXxVd0NCNLoFwTi5zIUEcum5d/DNC0h?=
 =?us-ascii?Q?sgCrOjlLLGhReIJ5Ff42KszEnmXqY/Ay7Wmwh6Dx7Aa3OyK8b7Q1L80YQf0b?=
 =?us-ascii?Q?Qz6zX+l6aM3eUHEnInky9ATt+INDpGOymDR9gc4jdPK8cp5xbMe8FpzMkZkG?=
 =?us-ascii?Q?UPfc3fGP/teavaHp7GgfFq6ALNSFTjAvhfP8qwPRxK+k1GdaMI9EBl6DcJW1?=
 =?us-ascii?Q?u8rn7X+HIDy9xmt/6O4ldk4SQ1MojQd0WoalLeqtju/VJp4hzWNBIJ4a4p/c?=
 =?us-ascii?Q?/U5E7Yv1KqgY3gegHdHFYqBlbw1i2H9k1vuYn/mB1b2xwnng/3aYGpiSKSdr?=
 =?us-ascii?Q?U+4HoGOxRSvSXkXCTntUHu+xQajWhMKcXq+CgHyS6zW9PW5zWZ0+9IAsPn9D?=
 =?us-ascii?Q?QCLSO1L6zERNcAFknQNIGiczQTomMcmgGo9t08XTCpSAJkMBLBLcTvL3uvAD?=
 =?us-ascii?Q?4XwDAIy/FfZpOnUVuJIIU2OU24qgfqvHXPbDGRO74eTJS8bXizA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(8676002)(2906002)(6666004)(8936002)(103116003)(478600001)(66476007)(52116002)(956004)(316002)(66556008)(38350700002)(38100700002)(36756003)(6486002)(6496006)(966005)(86362001)(2616005)(1076003)(26005)(4326008)(6916009)(186003)(83380400001)(5660300002)(66946007)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qlriMw9RwPZnto7A9cHXnFROrz9EA/UU3UHvJjj2UChhuLqIrWj/kCKNEM+h?=
 =?us-ascii?Q?b1rNRilj5GhV+dO+w0CTLYPsud3ixdCqJ+76Mn43HJqrQaWeXW5VsC05G6yh?=
 =?us-ascii?Q?txJhbWFi8SuSx4B5pWSTVcpZF2Wq9mBxu8VPr1s28+F+lopk7APXsM/HcLIP?=
 =?us-ascii?Q?FYYKMkLTfVaQmLzRlQVFhSFf3pMopDv3hfBo/5qlmcc+JN6zFcIKbr7kibQg?=
 =?us-ascii?Q?N3V12HPCnD920y9hv7sYt8og3RsU6AElAz4ge4usnOS68sNfZs06+wZrV6Ub?=
 =?us-ascii?Q?6332Adn1SGJEJ98scSM+am7gWv0ef8VWTat/U8sd4xSOTRd6Sr6jUqrBgXC+?=
 =?us-ascii?Q?CDcxriXbJJHdZjyroH5909Y0dNsAkGB+oq+OXSUGp+1S+LkGzQNFwCU5reTH?=
 =?us-ascii?Q?uGvIWQeSRh+FRWGOReAmBSNdNuXiAc+gHZncrrxpNg1ssBYdbc+fBTwtvDB9?=
 =?us-ascii?Q?RDqxA+JRo4Dqxpselo1hnjLzhnKf5iSbnkr0g4BaTPNUisohJNh+Aov2YBWq?=
 =?us-ascii?Q?IZehT+LfhaHnoZ7G9w38aUkcT0KAiFcr6mH5to5TAeZNSb2YkzBGUou3hGXm?=
 =?us-ascii?Q?bBgx3wvJ3oA1sNZ0wyHCQhwli7Ldqu+ySzLWLDX9vS5EB9o020Of/X02Ewjn?=
 =?us-ascii?Q?EJOmuXJ8U6kj6kZHC2gxIJ9v7eURF0FY4jlDw9Y23VXsfjilKdoxgkvuVWPh?=
 =?us-ascii?Q?uGkfjBQnbzmOrVWu3nXfyaqrm9/n5BALYi91zwulOWlXqsTACwF9wHSOCje3?=
 =?us-ascii?Q?TgQDejEXir5eqkptiClvKzU+9YIt/YZM+aD8UCQ1wuUSOkgFuQOZcsoLYvZv?=
 =?us-ascii?Q?B9qPiW4j2utjUj2WZW2rZ2m47puMohtmw1tbLoel8tcH+RAOIbTyw3EsvD9P?=
 =?us-ascii?Q?nXTS/BEt09Wmuc7VFdCDHRV9paampxXxtqryKoDr6IiMYizDw2rUSqBSGi5R?=
 =?us-ascii?Q?LE0w2ApBWAzlm8s+OMo1ZA0L2UR8pajhOIKqpXG9h64uc0jy9lrhuQ8ESDGi?=
 =?us-ascii?Q?ccMKezxUN9PSbS2XPkQrIKWHGpm5FkQEPr9CjYeYgxOb7cZACVpBaT+6Fy2C?=
 =?us-ascii?Q?/MBLnuKa9tW+g0bi7iAR2UzNq0oCJwd4Vf1KJVJANKU+vz3uBJGy0yB/0Lua?=
 =?us-ascii?Q?Ls331Fu26r2553uo3BJpSfux9SLLLb9QEYkLhpgH5zUKo9NluUk8h+PylwT4?=
 =?us-ascii?Q?3acUnfOq+udifGy0L+Aoceh1tL4nfPT0VrIPUtwo5vLOPFUAPk3pSAvZtYxa?=
 =?us-ascii?Q?mqKWkf5indE16sDYkYyUUQNK1zNL9eWs82dqvx9zBa937B+pq3fN/oJM1m5i?=
 =?us-ascii?Q?EpXktfCiZEnvEdumjEkGan1W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851969b6-f0ff-44de-6bd4-08d9725c34ae
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 00:04:19.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzRZAINVD8+vn5BguxpfDIhlTENPWkjAjOqcIinSJxGjozSdn1vuso4pfV7+6SHCJo7eF8zyR5Yjyn576nJ2ik3iDtK7TqPJk6dIKEXgCkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070152
X-Proofpoint-ORIG-GUID: DZsvoV4iGOGFvKaQlvpH8R4K9Xl7ud_r
X-Proofpoint-GUID: DZsvoV4iGOGFvKaQlvpH8R4K9Xl7ud_r
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
index 33f60d1b3a87..7bd3d1c90e52 100644
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
@@ -2574,8 +2565,14 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 
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
 
@@ -2591,10 +2588,15 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
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
 
@@ -2798,8 +2800,13 @@ int path_pts(struct path *path)
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
 
@@ -4424,7 +4431,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
 retry:
-	error = __filename_lookup(olddfd, old, how, &old_path, NULL);
+	error = filename_lookup(olddfd, old, how, &old_path, NULL);
 	if (error)
 		goto out_putnames;
 
-- 
2.30.2

