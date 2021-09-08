Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE984031BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 02:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347218AbhIHAFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 20:05:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30574 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347185AbhIHAF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:05:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LTUC1018860;
        Wed, 8 Sep 2021 00:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=WpJDEHRKCZUIj9sBlrG8dZl8Er9MMawNvkT262xqaLM=;
 b=OuMsGh6RZdMoBAL/c6bhKUIUCpDmdUiWLCae2cbwNT9SGFaJrTIkoGHlXnwwOFKt79uo
 XBzFHTVIh2q93KqYgsM2GZnxVzXw95iU6I/toq6fpcbfwjDS02RUUfcwdlxDGm5p7cSz
 xZlIjYTfEcwIgWWQ94sxmUrV2EeU2R/3HPZgcidKDCIKqJHnD+t97ePYzJIZfgWDRRBL
 Y3gLHOSvE+/VWsdPVJWcf0UfsTAbgKASFrm/9YDZsRc+Vv2Dv4khNhifDvrLeJxM9Gts
 /Zs3GydAgaL+pET3cyCro3E9HbTIMuQzPittQ3rqNRUcDfI729m+GSPFnBv2orWh84OW KA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=WpJDEHRKCZUIj9sBlrG8dZl8Er9MMawNvkT262xqaLM=;
 b=TcHbOXfVF3n0TqdqxCiFXANXUvWgD2yayYsj9DRRoAZm1XBD7P/2UBDGZxGBV+cqAvgk
 rrbiwjmxKookD4fPGFd7VQOtVbA2CErJQn0EMT7aRuzHq2VnCPD1qgU73ZPtvCkU5HTB
 +9tEwSUWD42PtQCtLUemrNH4vtXmSwLBvumZZTEFsArlt0Led+4cTNBJYuTcPjvLQD0H
 KvaG2zPiKcTP0tY6kKb803RRj8ytYlYjVb9BeH+3UH2HFuxkCo0LjuxcMcA3nDJ3JRXZ
 3O5awGFMAXJew2DukCPhpujMSJYCZ8PIeiAB/nSF2QPqAshByW5GII+2occcIph0tkfw nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd7t8rf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18800FJ8006507;
        Wed, 8 Sep 2021 00:04:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3020.oracle.com with ESMTP id 3axcppraa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsjpRMu4FmW3accLV6TJwVGyzZx4fWrEYytDj+IM79cW2zU1GYwvJzdppYgaxigmWh0SHi7yZak9Ig6NVbKwQyhP5kMG6k6t+AFZ3m0fvAS/KHlzqmVBlFCRz8CBOtx/aTdoJnsiey9+gh7pibXrKwIuUTx8KiGdRAXZkT8ICyh3Gv0r7dW1r6GZ7uTl9Ts9Gx3Khn6X7Y7M5SjWsxHazhq8HaEeUDyskgTPTwl3LDmPIfAESkmwI63NIP+krj5zio4jKFrlFq7dII5lu/YNvSjizbTou/TTVkHhKuUBMQdjBB/wXtp78iLP45Ex57SViM0BwVjqlCMTK5cYTYSi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WpJDEHRKCZUIj9sBlrG8dZl8Er9MMawNvkT262xqaLM=;
 b=dCgN+0WvwUzEJsR9yk/GDArjo1AfjuR/RozkH7hsJAZV8hGm/OpxaEgrtFC0vbrEgRL+U5Rn/unW+MPtTOuhApjXtt974fcaOmGQBBUnumM7izA4shzb2kMbgQUqse1wSTfP9mVnx48Q074AYeECIN6kIrREnEILegXpuf2nW0q7cKHZu8MaHkMvAvh5QWAuXhhf9XHA2rVGaYEJ19CrsVL8Oxi/d0o2qgQu8qeOxL12nzHGWbwFPNkiageLPGxmpCp6DRMTnFlCmamVVAb6krg6dJ1yezJXjokB6RcaHE3ESgKJYUcnpMcz/NVqzPOPk67PIQj1ibp+0ykqj49HAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpJDEHRKCZUIj9sBlrG8dZl8Er9MMawNvkT262xqaLM=;
 b=Y7zzMHPv2DDMu6c3RgLpdGQX4BXzYoQrb3Xc/NhBvhhpLtavwScPZRQiwL6HsjMxp7YNr2uzRo2BN7QVqcUDmsTlZdkVcD1lYhAEyzG3LrwInG+aBBLicoWUWGZvfj1riwwP8CZLZQMfkHXwK5x+gZviujBMDSG2wr4i0mW79ME=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5147.namprd10.prod.outlook.com (2603:10b6:610:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 00:04:14 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 00:04:14 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] namei: Fix use after free in kern_path_locked
Date:   Tue,  7 Sep 2021 17:04:10 -0700
Message-Id: <20210908000413.42264-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
References: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0090.namprd05.prod.outlook.com
 (2603:10b6:803:22::28) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.7) by SN4PR0501CA0090.namprd05.prod.outlook.com (2603:10b6:803:22::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Wed, 8 Sep 2021 00:04:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20e113d2-a03d-4e5c-2db6-08d9725c314b
X-MS-TrafficTypeDiagnostic: CH0PR10MB5147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5147DDBB81D337ED802FC521DBD49@CH0PR10MB5147.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bIlgYGAy+Niaf9LHEqIcocMYgFUn7leO6MtLW9Vkz1pp8m4hagZisvAghArC?=
 =?us-ascii?Q?2oxYmg2qvNNX02YsRUQypPbTkOlZViiNdFYyidEVNajOY4vRBZmbyAUOKd0t?=
 =?us-ascii?Q?RQ4u/TN6R2SRdjuFGcK6zH6N/fqAQLcoBL8Q8lFJK2YGcoUM5Ddaqs7B9rDc?=
 =?us-ascii?Q?19DUCXpRZrT+kNJjn0J3EufAEqDoLsdOV5fi7NxcuM1Yp3bjDOerWChjqDeK?=
 =?us-ascii?Q?uCNKUuupkSHBfjiXAHskmY6yUw3TTVhfkAqtSNkp66vM1ZtHI/p/pOTn3x1C?=
 =?us-ascii?Q?1Jnc0Xq2Iem9k67W4GAatOJCXDND4vinhQm+vwlfuEczm2groHFANDrqxky9?=
 =?us-ascii?Q?L0mn+0qeY/3v9hvsOZVq7N093Vmit5wsh01y0nwn/HCr+Ygck14lUpn99jBO?=
 =?us-ascii?Q?6LaqJQeR4r8Sq60SUmFPCJ1EPL21H4GOhSNRGz8lqhlRrPsGHJ3cQOy0wEDO?=
 =?us-ascii?Q?Go2hCEAA1C7X46EEvZ6M2KCCQta/NnCDG/IhcH2/GoijnbwgrNiGSnyi5FUG?=
 =?us-ascii?Q?ma1H9yV0qC9mFKNcy3WwtSpv+Xp+DEgIWHJWivU8T98zA1gvVYCJd2Ie+4pC?=
 =?us-ascii?Q?cD7GuiFk2R2RvhF7EKiAmpf7/aJ4vi85D+nmfCzA3Zy41wqKOxDPT5Lb+Bh3?=
 =?us-ascii?Q?yc0wb6WDwEQdnQMtMY9XsnM/p6OM116/CqTbyRBiqfc8es3nGiYhK/TOZVhm?=
 =?us-ascii?Q?RFpR8gBPpjgut67wGNKF4DOiZe82lZk0H47mpU66dUoHKxvzI7s9KC0bGw9c?=
 =?us-ascii?Q?8U5AoVSzDemnVwu/Mlcr1nXsl1nycUpYMDYG1QwmahCemPaRJYow3fL2KJFR?=
 =?us-ascii?Q?i6Um28aFIb8gIstA1qbrQ82g0R3I96hxSAvFF7B8j5BwRP433e4phWCAxsnj?=
 =?us-ascii?Q?Kqr6dExj90InieL/NSls97apOVtgkGUJi48k4RrSjpfnY2SMaFtkhV90s/6G?=
 =?us-ascii?Q?7lgbnNILbdHidyJG08Y3wkj4Y5qxh4qd6J4rT3XKE5Y59T8Z8iYC1cnb5hPI?=
 =?us-ascii?Q?6jwWq4dtvLb/zXPwQtgSSRSdYkf6xofco/hLo9bh1NfphdNrzvu/zlbOUyF3?=
 =?us-ascii?Q?e9HbibvFbCyPbuA/sjhS13APAXcjAWzxGJgyaydUzQK3AzAomsk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(8676002)(2906002)(8936002)(110136005)(103116003)(478600001)(66476007)(52116002)(956004)(316002)(66556008)(38350700002)(38100700002)(36756003)(6486002)(6496006)(966005)(86362001)(2616005)(1076003)(26005)(4326008)(186003)(83380400001)(5660300002)(66946007)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XonR0pnmO98HA2yIdG0AbI0WoXim6MeP9PSXB4x5cCV0xTp7EkQ+0To4HfOn?=
 =?us-ascii?Q?mBDrQK37caxJ6icKe0wJEpHAnOGyfPnIjh/nxk2hstsFEthFI655ZB8CH+Ja?=
 =?us-ascii?Q?GJKERrvUmmRHp+0aeZFo9YsGTRYZXRalZbCzAJwfpdti7p61AhKCgRRUe0Ic?=
 =?us-ascii?Q?t18drc+0b89ZWdDte+7WP5hMxacnbGjgmxA5+FA3YVGHUZ969lODhIV+jMPE?=
 =?us-ascii?Q?Lt2oJ6bxOF2VXe34KxpSaaIRwtxwe8rwKbk4Ds7F7K709q98k4JI28w7hfqn?=
 =?us-ascii?Q?vjU7Qmdms9yq3TBGbgQD5s6hEK8BxImf+1N9wz0F/FyxPvRioS+Eo9c6dv2A?=
 =?us-ascii?Q?qb+v8PsSstjQfMq5wsr6FxwIhaeCs3cjIXyhpJ/JALLbsyVAmvQTYD5uxhL7?=
 =?us-ascii?Q?tSNztj+Y6Yj7WyCa0MLP+LrsTU8DBNg1CibYgxbl/V4iE4MCPHJewgX542e0?=
 =?us-ascii?Q?tHBtX+N9CwGUrqhvYHpaxW3IiiBhDpEl71RusnbYiA0TLEApO3r2sKUjm3uk?=
 =?us-ascii?Q?bCqWkXEa6DRoxIbqDl4wOg9zKkASSusSFqJ8NQFIyoRKnEZZekCk8s9z73HG?=
 =?us-ascii?Q?skVXo6HTF3g1zq5kFGaXW8x+yZma6/nn9mUjKqrtbLt5Qm8djtr9bvJPI5ud?=
 =?us-ascii?Q?LIcTaw3mo+IBDCk7ta4twmuEZGNrIFq3YnIKKDOOLaFuZzI9g+blX/7TakBi?=
 =?us-ascii?Q?h6Yy8x1Ict0baCojdexirGZpc9e+zo/Vzud0QloQ19F+6/pPJHKKmA+xoFdJ?=
 =?us-ascii?Q?+G6LGpyO3zCBT8FKRLBVfePo1wd5Y7jUjopwUW/wGsNwwVu5u28Fk9sFDSkh?=
 =?us-ascii?Q?C0ImZ1c9WipNxQ80yRXipBbe1XqRRx7Z6p3eINLDqtswGKTQNNr/eERdhE74?=
 =?us-ascii?Q?1sIbbKnaAV7BqtE/g86PYF9qA/iPmmKvNJ3b+2/24KPrnbcy4nmHiGTACJkP?=
 =?us-ascii?Q?l0+mJ6MLNwyI3ludUyccCRhZW1uceif8dRqxihyMoh/pW2TUUq6ASsBuPHKf?=
 =?us-ascii?Q?4W2Q6Eo6GqfZDYeWW0RS+i0T6RgbzcZYZuY+N80Fl6LorNZ3BasvAXPBpA6c?=
 =?us-ascii?Q?5bDhhEl4vvDRVjgatfx6Bz7biEuBxhcXbYFFKt/tKG7h3Q5PT6pIj1EWeJce?=
 =?us-ascii?Q?fLFg0oLPneAD9HV+V8P5FvS/SJUn3vcF+fjh7RrRolTsVBIBW1r6GGk1+kCV?=
 =?us-ascii?Q?j/edxgs7JKLf5pzF7Qj/Gq+zMm5aOlKweomrUnAiAQoIy7RCYqcIkdahqdtO?=
 =?us-ascii?Q?jm3iBj0S7N68dO/0W3hKQslFYgQERY1d/0se/BQcPSMe0i5xolya0/5ba32u?=
 =?us-ascii?Q?GrLHjweCrMvJM+CiVKN3DoS3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e113d2-a03d-4e5c-2db6-08d9725c314b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 00:04:14.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOoMYkJCCeJ5Ej04VCaQPfnAg6qEbYHOEjgXnyoxx0WvQZBlfDd1259umZfY6pj1nbx+xhTOvSRmUr1hthKmDtlYGQ0Lm8DAIMiQVwx5+Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109070152
X-Proofpoint-GUID: OE6hsEy7A-tx8C6hGXUS0ud739v0Zk5k
X-Proofpoint-ORIG-GUID: OE6hsEy7A-tx8C6hGXUS0ud739v0Zk5k
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In 0ee50b47532a ("namei: change filename_parentat() calling
conventions"), filename_parentat() was made to always call putname() on
the  filename before returning, and kern_path_locked() was migrated to
this calling convention. However, kern_path_locked() uses the "last"
parameter to lookup and potentially create a new dentry. The last
parameter contains the last component of the path and points within the
filename, which was recently freed at the end of filename_parentat().
Thus, when kern_path_locked() calls __lookup_hash(), it is using the
filename after it has already been freed.

Switch to using __filename_parentat() to avoid freeing the filename, and
wrap the function with a getname and putname instead. Remove
filename_parentat() as it is now unused, and it is inherently broken.

Fixes: 0ee50b47532a ("namei: change filename_parentat() calling conventions")
Link: https://lore.kernel.org/linux-fsdevel/YTfVE7IbbTV71Own@zeniv-ca.linux.org.uk/
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: syzbot+fb0d60a179096e8c2731@syzkaller.appspotmail.com
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/namei.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d049d3972695..d6340fabaab4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2538,25 +2538,15 @@ static int __filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
-static int filename_parentat(int dfd, struct filename *name,
-				unsigned int flags, struct path *parent,
-				struct qstr *last, int *type)
-{
-	int retval = __filename_parentat(dfd, name, flags, parent, last, type);
-
-	putname(name);
-	return retval;
-}
-
 /* does lookup, returns the object with parent locked */
-struct dentry *kern_path_locked(const char *name, struct path *path)
+static struct dentry *__kern_path_locked(struct filename *name,
+					 struct path *path)
 {
 	struct dentry *d;
 	struct qstr last;
 	int type, error;
 
-	error = filename_parentat(AT_FDCWD, getname_kernel(name), 0, path,
-				    &last, &type);
+	error = __filename_parentat(AT_FDCWD, name, 0, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM)) {
@@ -2572,6 +2562,15 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 	return d;
 }
 
+struct dentry *kern_path_locked(const char *name, struct path *path)
+{
+	struct filename *filename = getname_kernel(name);
+	struct dentry *res = __kern_path_locked(filename, path);
+
+	putname(filename);
+	return res;
+}
+
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
 	return filename_lookup(AT_FDCWD, getname_kernel(name),
-- 
2.30.2

