Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAA73FE17B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbhIARw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:52:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236638AbhIARwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:52:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181HOKQX029706;
        Wed, 1 Sep 2021 17:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zxrFHpHF7LiR92IiMd/PWlK5eA8W7tvPkk2kyekehR8=;
 b=hGkP8ImQXH/OQXhpH/rp3YOl6HX2hI0xNacWOhL4bkjI4kZ0xNPlpn1KMexN934sSDYD
 qRtu35GpK5QaesjJ4M1o/Ed1pyQnv+HFTvPaWfSHT4qNN6GlDH1upfQjK9sedoqSYJl8
 CAbevciVIFlTLkD4GR6g96k1lEhacVzK3xqZw1DwzlXFliJdeWL90FBcd2m/r9TUo/aw
 1H7XHjjgRXg8R2CPdtsrNa+wFUOmKEUwsYMDpPJpGoWFCGe/eWsnv9LD47hxK0Hm6JaH
 onVa6KCWut87Ve1hJedfpqWcHH1UjR86jaKNhKiHkhoP1B1/7uZl8H51gNUlprmxw3Fw eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=zxrFHpHF7LiR92IiMd/PWlK5eA8W7tvPkk2kyekehR8=;
 b=cn8xC7qHch1e/FKFsihYi5DTv8UXf0jXDvp9dstjen8/d+UZ1dGP/SNX9NCWSm34FJqs
 axM0eBu2YlRkRwGs8MIJWaUtlsY7s63jJmlv0AyOliWQc8pAK/f2k1bB26yRlr3igi4l
 G0VwZ10TRwf25orASFQBusUV2ArM/LGfDlTMVsHRP8B6REFwlTqmoU5DBf671kRIViEC
 Cd2yH7jld8s85BV7pEqhaopCBxLSox95/zSDdRPFoYRh4aQ7QH6LhjWhaNErquQqDKUg
 dgq0enOJ/OXBpsUFgYkSEJ46VKUXed3jV2IE9hAtcJZXCj5/qX/l3lPkKYD61RNfJI96 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw002r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 17:51:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181HoSwn136919;
        Wed, 1 Sep 2021 17:51:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3ate04gw2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 17:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYDABBbpnqRAeQ0aO5UlOXZ0R9ZJLwSwPRiNYJOv5Bwm09K0RYGe4c7Qsm+UCYi4jX2KMlGy7dZA433MAU9BLqCoQphFF5X8dEsWsL2OKGx+hsqgi3pyzKkLyI1oTMtEyy4dHQXu+RtVGSQB9Zv4XQNOHQELPPfJvjDE5i2ovzoU21FTdjnZpsPDIRC2RFY5qxnEJi2SHldJAQ9hlZflVwZ7FGf5qCNbh9U5ScTYwpWWDzgbBevunya/v7/fBh0Fvs9hzyqu9wjyA4zzeydupS6v4pRmYxiS7qAJJjm/zhdzQXZJEgLbUgS7E+Xog9i02fGiHFJ6RVeF0APpaLK/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxrFHpHF7LiR92IiMd/PWlK5eA8W7tvPkk2kyekehR8=;
 b=VU9UtUC1FWmkC8awHjM5bvSwQBzPe/fXbrOPDfpKtP8hHFW/+QTA52z53fKxPPpQCGS6LPfwCFZumCxWsyoTC+DENA+AeRUEapv498z3q2JSA+72XeF1Z2cm7Ha7Ibb8ukjc3wusaO4jH97rTjvaIB7kRSktZMAfrzOXGe2kfBoCVyfnuIbrprv1/17As/15koHHn3aFXCvUG1nwpMyt3QGluyl5UiaJ1e7sQFzz0zbJHNR7Oq20QTveseNMGb/yQtIc+Mktc6QuJ9S8/tbLB9zSLy+6o2i44idcptDLvyfFlaDWhu8k5BP8tW4w1YiRpOiotIGZo1O3G/tA97x7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxrFHpHF7LiR92IiMd/PWlK5eA8W7tvPkk2kyekehR8=;
 b=SKRuB/wJ6ktA5IQeoP1zqvcxFVrPrhWyqIhb8MD1imNtmXQ3MABPzRZ0TZ6R6P8oDyPqqMbKlGQNJF4OQ20w9F8EyvvdmgyiACKCTMWGUqeeHdksmfVCrNO7HZnVzk3Jih0z2RS8EefwZiHy0gRdhArCo6A5+k2m/uK7Eft+ca0=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 17:51:53 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 17:51:53 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] namei: Standardize callers of filename_create()
Date:   Wed,  1 Sep 2021 10:51:43 -0700
Message-Id: <20210901175144.121048-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.10) by SJ0PR05CA0131.namprd05.prod.outlook.com (2603:10b6:a03:33d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.11 via Frontend Transport; Wed, 1 Sep 2021 17:51:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 964e92a3-708a-40ea-6daf-08d96d712e88
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3863E8411AABAB547A1F0503DBCD9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kxTOOXJC+jHAoQdjNCznukv30BZUayfwMIJ9EUu4z1p9/uyhAl5fScZfi8AC?=
 =?us-ascii?Q?pPHe08j0Y7F/9bb35C4GApk5ekdeIDGdFNg6aAsSfvnOzfJKCa2B7R/N2cWT?=
 =?us-ascii?Q?AjYmju/qSlqgW2+SyV3zPDxKYlp/IIRFMkbv1sq2WcpLdWWwTvn1Q0jetgjn?=
 =?us-ascii?Q?aUuDa9SwhWmX/BzE1j+mFQpKs5eHfIVB2tN6MW5v9QXQ1Rhut+9qsvNIZYXi?=
 =?us-ascii?Q?77Uly8nSslpp/0SgQU8YgE3544kcTOn8q3O9xpeXvgm/eRtE/U6C7aWCicgG?=
 =?us-ascii?Q?kv5JcDtwXnS0SaC3qslGqEBriPTBeD0/hpSoMi3F35DPJ1j8nsWpjIJ1XdsY?=
 =?us-ascii?Q?JyCvIwiKyanOuQQQkufUd1LfdlqEhQ+4YccsvaXGsuzxTeKNIvCykHot0qXV?=
 =?us-ascii?Q?su6l5SacYMM5RD8/gKFBSG60DzvkPbrB9r4plG20T+4gs/4epe0Lt937NS5s?=
 =?us-ascii?Q?pKCiI1GDe3rx7qgrqhmPIF7A4ddunsJ268no75Lv7kcP7LTshx2KpdiHivXQ?=
 =?us-ascii?Q?8DYszjYjiRdJRC43m8qsrHt5GPjk3VFYDqreTl4TpSwFbptuHtto2zTvr4M1?=
 =?us-ascii?Q?iYJOffGrfOpHstgRnX7ZZg4vxKgqnhJ2Tg3pJ3B4VhtgvjgqkUrfeGBSaRHy?=
 =?us-ascii?Q?yvKIcKhfNH/W9MhGiisCHrrWKqCwfX0b7GfdlWfFBK1q1NhpW+lhUwx7Caba?=
 =?us-ascii?Q?EyWXtOwJm5tcZ+nNOuUB4D3RF8K8YK2hxeA/zmaXo6686j8pNW0xSg6LspBm?=
 =?us-ascii?Q?vCgz760TzMyFzvaH6XR/+dSPVU2QoV4b9vE2fDpl242oonDj+j4HdsqQ8UuI?=
 =?us-ascii?Q?V00J9g7mvgZG4urF39/et1GMPTeA2nze3zxeBPVCi1PaQTd+lZc8LPUrwkQB?=
 =?us-ascii?Q?LUbRZhk+cX89fKmadl95e5a0wmBbbyG63wWG0m4JM66yhAp+baPTrLXrQzva?=
 =?us-ascii?Q?+E/SgEo5bxuS2EiTP7wLlaVwgRmmZWmPqbj26P3IOgXr7ehsbyMeQ3zIxuu1?=
 =?us-ascii?Q?YpPGj1aZsW2TK756V0LzVq5gRG0DhY6wIkp6rI/09e1GSBLicp8u0qELzT4Y?=
 =?us-ascii?Q?TUTp2WwUL3hyC2jyIaLcXnTtPcxDoRu+hwemnjsNjBRR5u9leZ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(5660300002)(316002)(4326008)(38350700002)(38100700002)(6486002)(66946007)(66476007)(66556008)(83380400001)(86362001)(8936002)(478600001)(36756003)(103116003)(8676002)(6666004)(6496006)(2906002)(52116002)(2616005)(956004)(966005)(26005)(1076003)(186003)(6916009)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZ+6rWxY2/i8wyoeiN4sYd4LpmXocBRkvbi7h+OF8uV+ZlZ5OB/CqhTJBU9o?=
 =?us-ascii?Q?mal49FAgOuy8wggbMqXC/RXMeJ02o1wVHM4ddVaa/1Yfr7aOGHHc+JVPJppM?=
 =?us-ascii?Q?L7o1yWWqGEWIM22LefP0DEqxzKn7Tjbf+bU9APHdHJH2m/1qzLyZbMM8g81i?=
 =?us-ascii?Q?vD2PY6w4cueqhid8wcmSGyszJlCx+wSv4+9hWf30lUgCBFxXmJ/L1ta2NrjY?=
 =?us-ascii?Q?kApAYpLZ4MQvYyodXLdmejP8NejX8P8iKV/wsQhgr00aQLKyMgUIb0YCFKlI?=
 =?us-ascii?Q?HRU9Nd4ndtobBTjp9ivO6YALrsCK3FRbhYO43z27+YeeHVDMlCmgBGUlb5u7?=
 =?us-ascii?Q?ZH8y6tXx1duuEhbyVWeOJL5WGVIvBev1R/uqMSuVDZheUYRTUwBEqchYZ5JP?=
 =?us-ascii?Q?hT1ZHdRmsPjzBpIhAVnTFgSYVap/FTklmUcf+mzH35+FPVRdtL5f02I5gODZ?=
 =?us-ascii?Q?kLESI3zzdqW53XO0PTo/CiOJEzdLIeWZt0fso+/P+SbOT4/fHKNK1CHBcaUq?=
 =?us-ascii?Q?rT5vCnRB2h399dHgoH8V4b6rKCtJAhJtr9ChFd8Incr5GNJTywWci/w6GVgX?=
 =?us-ascii?Q?tH7rEX2sXGzxS0xtg8HdnwPOwWnX78pjAtdM4rHH+0Pcy2wXb3XpnIdj2ohy?=
 =?us-ascii?Q?EzQJDjYiIPY6ZdwMc6rtZiG0FYqhGSzOba4dTGzPkgPk0Jdy4kOsYzVLFqzy?=
 =?us-ascii?Q?5ikKNBBHVG0eO58YvdP2fv861l1yRPq1Hx3PcDHp3CnHDDk5NqZuSmdU8P8a?=
 =?us-ascii?Q?uRCBP886RIrt3EXVEeIDnCU6qPlWOr4jnrP3sDcXAdeZhZEamPvHGXr38MGc?=
 =?us-ascii?Q?O6Ucqk+KStHNDEot2J9mFrWTyYIdV6S14vcTBrUOT7qQmRVdDwOtDbmIzy7t?=
 =?us-ascii?Q?GFgQI627tBJnJJnQNCm8EY9t4ZQFi2SogQBg4EsqwdNeLOtRMojFO2F4HeKo?=
 =?us-ascii?Q?dMerwPIAYnIZvG71rumCboJYyZKpQnXwXvlJNXSBJpef0/skMQG7m1XGtRS0?=
 =?us-ascii?Q?wif4PGBu3aDgjkEu/2VrZKuOEHeXeZ42fHWAzdVnvFNU+twVnEJtHcjQ3XRc?=
 =?us-ascii?Q?gI37F42hgcbZjDEMRQllwWsN6h/3nW7llO+f6WVeShCvZrhtT8YNkgbxvZ81?=
 =?us-ascii?Q?xCbFSSDtGY/V2yM1Z07Sg24SzCAsciQiB/62y3zZ0y0cVWTWjyJ1DwWKf50g?=
 =?us-ascii?Q?FHIBaFWtFE3sNhLr1Gke7WxiQod4s7a5Mht5ped4KvKBEwU3aZXGtk4wOuuI?=
 =?us-ascii?Q?Uuly00gBXTNoKdtBP3/AFKzX07j5i1ZXsv42Iv3zJWB7VOM0BR5bxX3ePqlr?=
 =?us-ascii?Q?flEqZg/RhbYgYvHZJ2/UZdu8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964e92a3-708a-40ea-6daf-08d96d712e88
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 17:51:53.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhz6gIShadBeuEB6gssvwJcf5NboSpyeB2Sk2GcXq6goPI2lWDVOmEOOyAWV0DVL1rgWRfixuqA8m0H+6g1QPsYSkNvHLcZNWVJ6PLcKnFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010102
X-Proofpoint-GUID: CRkRZ3JYqlNKmo34u3UsE6Yrebli5Lrd
X-Proofpoint-ORIG-GUID: CRkRZ3JYqlNKmo34u3UsE6Yrebli5Lrd
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filename_create() has two variants, one which drops the caller's
reference to filename (filename_create) and one which does
not (__filename_create). This can be confusing as it's unusual to drop a
caller's reference. Remove filename_create, rename __filename_create
to filename_create, and convert all callers.

Link: https://lore.kernel.org/linux-fsdevel/f6238254-35bd-7e97-5b27-21050c745874@oracle.com/
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/namei.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 76871b7f127a..ec76f533ee3e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3622,8 +3622,8 @@ struct file *do_file_open_root(const struct path *root,
 	return file;
 }
 
-static struct dentry *__filename_create(int dfd, struct filename *name,
-				struct path *path, unsigned int lookup_flags)
+static struct dentry *filename_create(int dfd, struct filename *name,
+				      struct path *path, unsigned int lookup_flags)
 {
 	struct dentry *dentry = ERR_PTR(-EEXIST);
 	struct qstr last;
@@ -3691,20 +3691,16 @@ static struct dentry *__filename_create(int dfd, struct filename *name,
 	return dentry;
 }
 
-static inline struct dentry *filename_create(int dfd, struct filename *name,
-				struct path *path, unsigned int lookup_flags)
-{
-	struct dentry *res = __filename_create(dfd, name, path, lookup_flags);
-
-	putname(name);
-	return res;
-}
-
 struct dentry *kern_path_create(int dfd, const char *pathname,
 				struct path *path, unsigned int lookup_flags)
 {
-	return filename_create(dfd, getname_kernel(pathname),
-				path, lookup_flags);
+	struct filename *filename;
+	struct dentry *dentry;
+
+	filename = getname_kernel(pathname);
+	dentry = filename_create(dfd, filename, path, lookup_flags);
+	putname(filename);
+	return dentry;
 }
 EXPORT_SYMBOL(kern_path_create);
 
@@ -3720,7 +3716,13 @@ EXPORT_SYMBOL(done_path_create);
 inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 				struct path *path, unsigned int lookup_flags)
 {
-	return filename_create(dfd, getname(pathname), path, lookup_flags);
+	struct filename *filename;
+	struct dentry *dentry;
+
+	filename = getname(pathname);
+	dentry = filename_create(dfd, getname(pathname), path, lookup_flags);
+	putname(filename);
+	return dentry;
 }
 EXPORT_SYMBOL(user_path_create);
 
@@ -3801,7 +3803,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (error)
 		goto out1;
 retry:
-	dentry = __filename_create(dfd, name, &path, lookup_flags);
+	dentry = filename_create(dfd, name, &path, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out1;
@@ -3901,7 +3903,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
 
 retry:
-	dentry = __filename_create(dfd, name, &path, lookup_flags);
+	dentry = filename_create(dfd, name, &path, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_putname;
@@ -4268,7 +4270,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 		goto out_putnames;
 	}
 retry:
-	dentry = __filename_create(newdfd, to, &path, lookup_flags);
+	dentry = filename_create(newdfd, to, &path, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_putnames;
@@ -4432,7 +4434,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	if (error)
 		goto out_putnames;
 
-	new_dentry = __filename_create(newdfd, new, &new_path,
+	new_dentry = filename_create(newdfd, new, &new_path,
 					(how & LOOKUP_REVAL));
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
-- 
2.30.2

