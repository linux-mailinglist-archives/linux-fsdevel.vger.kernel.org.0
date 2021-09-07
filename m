Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF071402FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbhIGUwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 16:52:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39270 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346837AbhIGUwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:52:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187HsjPl028050;
        Tue, 7 Sep 2021 20:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4sTvAgC4wLd3w7mcFPV08K3eue6H6jOyAAAWiW9dwSA=;
 b=sTfaF+Km+euupxyxHiP4oX4Q0u0hvzNBIa+y9vjoCKU6iXdbjjCVb6F55k5NJmUQqHm0
 +R/P5sH7Nv/60Ohu5xbufSWRLQCiEu8Kuor7QYdKgv77fW2uSQPqVtNMN/tE7QCozUoZ
 TG9jojbd+YPYcK4j6qqsAXRu9/nfopcqvxMa6cl/IVi7rrRgJ4keyfDsh3Ck9ngf91Lt
 8CADRi4s5FrXIp8X7Y5PEdKASKNICIMzgR/bB8NuwQTXG0jPw9p3jkiuFl6J1HGFQIia
 CB6OlVgnMMNcHz8TE3sD2neEXblJr8QYx4HgXAVftKk9iq/oyoLGtudRoqDvlqTFqTyL Vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=4sTvAgC4wLd3w7mcFPV08K3eue6H6jOyAAAWiW9dwSA=;
 b=te29K1kbP+E+7kY7OTcq98C+BV56MQjUvhv8qFfsSqxo8qwuGR80++TKj0Re89okQ6ko
 v6mbxyp3v9rkKXWYPU4Ah6XQ1JzODxNJjvX+pahwkFXGg+ZG6y5oLm4M+bgOlytL5JkB
 ELsgLpfk8uppUE6T/xo9ep2qdbtgfTO81IjZEoB8s0841k7Mm8SmlCk9HRcQgmoWPP+8
 N4nbnmdt583+g4Zm3/wZfEBlMFadieiQOjKPpgirc+Di5oSE32Cg7MRq54XioP70lhmS
 Xm6U2M6EE8/9CGKekFheSmjIyPM69yn394oVIuCX1984/KzIjm8gn2MDrzstSBUvCoPG hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw68eme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:50:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187KolUj083023;
        Tue, 7 Sep 2021 20:50:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 3axcq08k3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7Hu2PoC+YulQh1xWcSkEFB9EbpjYjMSoQ5noNsQYjKVJUGmYNrpUZSBnbfYfmitKHbzrtIlHDtS3sM6uFkIaDfkUiQvlPx2ymxS5dK+AX4jLHfhrqebuXIDiYughQzs4VAmVu6qfGbCtzz4/a36TUVMAYg1S6hWrdxx59LQfETLKQekx4ulhSGCtLDKln/p2eQYDv/FoGjKTzE7150y4IhVJnrYHxsYOrPeucSDZR0JmpJ8p7YA9jiRTx1oMFqydd9xdIDBH4AkdNmAfW6uGs3UccKlimVq01uJugaKwMB/+vj71pW+hTN2gbyZ3PCVh66mvYDPXNJQGkMZ1UQ5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4sTvAgC4wLd3w7mcFPV08K3eue6H6jOyAAAWiW9dwSA=;
 b=Zo1df3PLpP3rPoMDpzLNTk2f+Lbv2RbFjHdTTsKy17k7R9AofjUlSB9YE5Idxqx86Cd/8w4856EizI1tUa6AT3Qgs6tBdG7y/X6Hvpy684V/yhDyeCGaTWHh3LPKkZM4TNdNoKgqULwN+t0qM18He9AXHay09pFo2AbFgNIG2Ds3ob/1spoaFP760XHnrp1Sp/+5f1WWKzUM2sjFuoni1f6TYMsK8K3iYLZoW8r0MgNpkQCQ1C0/VhmLGCl8CC24JBYtvrCwW5XyfjIhC+6Sos7SrTFoGgiT/KlzuBf9EDYR1Al2fBmFhm/vFTfMQARXUULIjQCA273ESsAcK/kKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sTvAgC4wLd3w7mcFPV08K3eue6H6jOyAAAWiW9dwSA=;
 b=ogWy1vE5uXtmNVZgh7Wg5gHbfHKuoV768iXM3Uqn7Ct7DfvHZj238F6D+CGCI76NduLy2bg2+WLyeVEHl2HgDrPEvaYbJXbpFxRfhbRbml+ww2KCIHR2SuGFtMTqArLzQLjOhWdiWfc5rLqmhE8dHAmo0FQbENQrHVO+opWIABY=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 20:50:51 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 20:50:51 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] namei: Standardize callers of filename_create()
Date:   Tue,  7 Sep 2021 13:50:43 -0700
Message-Id: <20210907205043.16768-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
References: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42)
 To CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (136.24.196.55) by BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 20:50:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba3443c-dc9e-442d-d30e-08d972412d7f
X-MS-TrafficTypeDiagnostic: CH2PR10MB4149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB41494A8EB02831CBDA1A5551DBD39@CH2PR10MB4149.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n9tj/IqDPh8EcLjX2pezP9sN/eW0v+HQSkW12xErocS2+x/49TDP4LkAY+pg?=
 =?us-ascii?Q?hKra9Bnz2qcrdbU32Ih7WGk3nOel4Y8dJDYbl5L+kQyRiJ2AERTYAMQrUlXG?=
 =?us-ascii?Q?Ohs1gBFV+N67BYuieyYDsMAGdx836AVs9zqFertwo87xmtsYiK7X+ZGgid/l?=
 =?us-ascii?Q?HWrphvBXtEgGlhLygt2FCwKXoDEpDd2MXA9aiWjeINcGO4+SrUKMWzsTu8aM?=
 =?us-ascii?Q?2g6KmU1TweTrWumiGPvV5c71lo+8vis3DSiu3uge04nAjFlMpiOfAO6zw/rE?=
 =?us-ascii?Q?Awh29Ab3LVEVPgLAK1+xWqtXVceRkofEr7TOENesPTq1CFhuEaibna67CzJV?=
 =?us-ascii?Q?Du2NJ+ARaKGwpMJ0hzv/GuX+m5NHh7zD5/0vv+HtusEmB7D9o111M0RjI2bF?=
 =?us-ascii?Q?W+7PqgzJsGMAAsKXnnok9tzOIsm0wUKeLQX8vpfwFClw0kU3ehqBeJ1m+AO7?=
 =?us-ascii?Q?rS/r1kgi4A6lJY+KjcfnZI/L7UqpnLL8OKXUwK9GxQOvZwS/YScE857IKdyh?=
 =?us-ascii?Q?nd61rdUh9XfCcLxReZ+cmGT3SQginnfgfH6ynkjD6ivMHYBOLF1SQ6i1+AvI?=
 =?us-ascii?Q?JnGVcvFv1wO4rtnwmdCNrNpKt7iQkbOqKqbWyWSfmj3wc5MkEl3DaItpawUf?=
 =?us-ascii?Q?Bc90E2+IA59tnVk4gyJElyH1RFbP6LkiltiYp8YwoWF98jVABf6L00XMQ5Nw?=
 =?us-ascii?Q?EufIKKG/tOdipW3jltsWikogQJnwBLOCIsAwTJtxQekhiuSNKXCjQscgMXvw?=
 =?us-ascii?Q?Z0IpZXKcjYpcuoKwunDKUp4aCzse+CrbR5kOC4QR+kf4kukg6K41Pn9a21DF?=
 =?us-ascii?Q?a+l2Djwk13elNjgeByZ0P4PES7iyjEhSlYYLa8v5z2BhG32HYYzT/2XYWPQa?=
 =?us-ascii?Q?ppKZozFAc3dpYCB7Du5C77QdDOhInDBinioilIu6j2td6f0GHcykJhahScwN?=
 =?us-ascii?Q?WnK4lOPY9Qb7Dc69snkaPb8m1g4EDyUGzns/eDbYcPyoNJ6yohJq/mLr6WDv?=
 =?us-ascii?Q?qbaRhZJ6OKVqWOtYgQvu2wvi1RS68iN929dk5O07uw15+2NCBQuXBpZ/D0s8?=
 =?us-ascii?Q?5vhZUW9mZHVa9bMeWlUHb/UQk/zyumtm22+/6SJjokECWeojNyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(103116003)(83380400001)(6666004)(26005)(6486002)(86362001)(186003)(956004)(1076003)(8936002)(38100700002)(2616005)(38350700002)(8676002)(36756003)(5660300002)(4326008)(66946007)(66556008)(66476007)(316002)(508600001)(966005)(6496006)(2906002)(52116002)(6916009)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amTw9SKoDpED4j+AerHHxxOMseU+hBZbgtnLt7IpQQ5/u1zjqeMSuD1eJby1?=
 =?us-ascii?Q?e+oSR46xCbP/Snmaa3FzUfYOxiv4NvOhrfi8UqCfkY0ObGaoMxbXwnHTo2uE?=
 =?us-ascii?Q?5nfHVN3k2GDWrp5UJKWZuDK541+HUPQ6UiFDStjcN7WA8sNyTYnvYE5POXke?=
 =?us-ascii?Q?e6fG3ncqXUVNY5c6fhFQmhZfLK/okH5KUU7ldW5sNnv4L3MlZgQT/1NIqyr/?=
 =?us-ascii?Q?1jG6iRX/8SLz6vFwUUG95L1ibj/C6eRSybvIJis6LOPT34ly3JCeCQiUtnBk?=
 =?us-ascii?Q?SwTollnGAt8fS1W7j18JDsdx8fF/CbLW/i40cqZkJ3Q5Q/5HDMCct9ra+PPn?=
 =?us-ascii?Q?eV6V3kJTXebNxd/rOMcOSJm3ItLQA+JUWNOmIY7NgnnYDw5n2h494zZZXxXm?=
 =?us-ascii?Q?Et2UnTegmZpkhKQlljly4oN/i93tBUjqhEdXp2EGVd8Sz6jZBp4KEcbtbhWa?=
 =?us-ascii?Q?7CnWJY7H9j67SVQkDn5OXfib441XbprTjzdtQA3Mq96n4Sb4u1+bmY/hixRC?=
 =?us-ascii?Q?fuLuuQ6gibbJ4hqPW6mFIXlgaphf925kAeKDRpCo3w1lgj2bYVPI38apNkvN?=
 =?us-ascii?Q?r6xeG2E/q3B4OVqqIFa4wx/3WJthzSvRj/KVInMu6YfexvtHdAq98fupL4UB?=
 =?us-ascii?Q?Hs1MjgORQzOG13WHos8wLJto4vJ/yccOiT7bBHvOBRRQ+dFd58s04mEHNZ3R?=
 =?us-ascii?Q?b7yz9nqzmtFIgMfEuh70qGXUaAFuH2l3pBsYvTUaUycoBumGpdnjid/ySQ34?=
 =?us-ascii?Q?Cw8/xckTnNGePmv8UBLi+JBXehOVie1EU6JZ/8fo14E3Q56WerBGfumcdDxv?=
 =?us-ascii?Q?XzXZ+TZ7+jBQIV10oxiAMaSUfaZ+ch421YXp5mk8nkR1SbuFGV91Ro177F6B?=
 =?us-ascii?Q?TRZBHiBsujkvIIWEcttda/C2kgHWBUPAm0oSN77QYc0yg7LSsOMIToZXN5kB?=
 =?us-ascii?Q?Gpr8EP9fWQlrMv9rT0uwLTS9xddL1aY4A0vWejBKXg2ukEzB6iNfKTXnH6vG?=
 =?us-ascii?Q?hTRS6VJOQofKsAjC3cmhnScTLqVZ20zaoorOPZizL7O7Edh+dRausu5Q6fAN?=
 =?us-ascii?Q?RQ6y0P+kPUuiwTlCaSVgFiABCcbEDqPOG5zk5uPIauOL0jLSuzbx325tHfoj?=
 =?us-ascii?Q?e0i/ftlZXaQqK5jr4FI7T3JwWU8sThHMGTFGZ/voHVcqfdrpKV4qlSPhnQ9O?=
 =?us-ascii?Q?nkQYaOWvP+rUpwiXqf7o7T9Ij7BetH8gok9Id0l+K0SdhuGOywtYO96ps3TJ?=
 =?us-ascii?Q?7sinJGA6ud/L1+rIyEJk08K/sVbuqZwL1yGu3fmVlcxNR5NsF7ZtAbwLhs8v?=
 =?us-ascii?Q?RMRjnlhLwikHkmCB1dcAkD5O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba3443c-dc9e-442d-d30e-08d972412d7f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 20:50:51.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVRJFRFsrEJU5y+K3y1ycZkqe0esdN60836k5K6iifurcoKt+YvpZjnXVLd5/DkYk1JSj6yBBGI9Us9YuQ25wRrPzSU/TTbAb8z/9tjFxOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070131
X-Proofpoint-GUID: mAO8BuZGWe5F7iDUMjg3BycVH2RO640E
X-Proofpoint-ORIG-GUID: mAO8BuZGWe5F7iDUMjg3BycVH2RO640E
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
index 76871b7f127a..0d3ce04c55ad 100644
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
+	dentry = filename_create(dfd, pathname, path, lookup_flags);
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

