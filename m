Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA44031C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 02:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347233AbhIHAFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 20:05:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64642 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347250AbhIHAFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:05:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LTME0028195;
        Wed, 8 Sep 2021 00:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=gpWYEQKiL77b6Ey3rqWOqOghf509PhteOC7e97is3WE=;
 b=zfn/CQPCCIr4CiIjmg514KrfrGNPtwvEKxKlCF08dLRCfomQe9RbeVcxgP/ejLJExsfg
 koadz3G5u2njd4n5gTYBHYETVp1pjy4HV5KZQr8Mn8ZYsmyZsk47ZN199cezI5vqKybH
 Za0G5ubt6wgXPh0IzZ+izPJIRfBn7UHDeMgBV/CTvniTsscerSLV+AW+KFiczxbyb0h2
 xHFQj6WCY7KBuVT8XnfEauW0HLuzrTDrZO8jLVIYGc8LhU9vuGHbntpO8M1R8rKmQ21H
 AuUZ/2R5MDV97d+bLvR/0gBU/zBuV/is88QeQ76Y0w72vb5ljiCQAne9BrYjn0F6DZAt kg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=gpWYEQKiL77b6Ey3rqWOqOghf509PhteOC7e97is3WE=;
 b=tC16jgkzTdgZvLVQib8LqBZ2NNhEtAszMzucc+1oVT7GpYbBbR1DKBOgkqf796l0vaCv
 VxTmK3qy/VwD1cgTTt5Y+ivY6cK1O2NjBFLUlkFFRYvbjRGKDXyI1wzoVsiTbOlo/ZQS
 etkq4SvJhWbvPUb7slDPRRrE2Ev/OUnt2LccaRK9oL2WDIw8sHEYZAWigHxY/VxaBU8J
 8+nyiVnPrbjC7pHKNEOBgfOakdxabxykslCS+QI+/mf99MlDj+2waVQIc38UGyBAJZoE
 sdi4cORL7WurF8erhrmxqxNMIIDhlxgKvE1QUvuHNMN+PaFnGg0AKkB4rctg4c4TuHKc MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw68tqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18800mJi029133;
        Wed, 8 Sep 2021 00:04:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3030.oracle.com with ESMTP id 3axcq0g2cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZY/Tnwv9LKy+ZmBmXdQiuxiwKPr7arigZONBE4rwpxQrx9qlPHuDsa7cb3ct6EBBsdX3RlaAQFlhzgWoDudpSiIv5cpPv0SehsSrkCn7VV14gkde14uztui3QFYGzqwFbX4fa0ABxHrHgussRKiZg6VJRsFO+SHA+vdCBIFf2Lax3czMmmHMt+PwSrqYwXh90Yi2V5XpVR8xo7VOiiDQPSlC+m/6zDBO4gY0HAgjxuu42pdh0bxlSXN59z4mbYfBTNVTWW+95dZ7AB+lUDo6RcZpL0WD4HBLCwl6kJQExVmDws/00/E+mPmM8fjZiFUWbNfmPl6LoFCTQcberk89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gpWYEQKiL77b6Ey3rqWOqOghf509PhteOC7e97is3WE=;
 b=CcWlMLtYqbByG88T36AP+T7qfCmBnw2qd2kcdCdZ7XAT/QlrDzyVv6zrgszQYS/F42MCqD6liQEEYuIROuVo8fENCsrZxLI/NrlgxaXUUd+CzswD+degsil9rwyCinXWFmas7sVn/zRIG46OWK2yEflk74+4bYPk6SotfdaoSErcdf7TLm9D7pYmMRCz8dx81MAFy6RhRd7yi7WlDukLN4B6dcsLpxA2OaSgQZcWB47Wak27WW1AEJ1AQCQ94sjkTfcUTUdCL/ZVUlQt3FDg+5alcAG1T5SAdbuervigncwrpXmUU6gGgCuJy4+v7mOdeYYUU0SJkxIiCFURAM1AYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpWYEQKiL77b6Ey3rqWOqOghf509PhteOC7e97is3WE=;
 b=tIE+3tL5Rqth3RVPEjmSKIpM7NHKdrEHEqxH3GOLIZWnoXln27pnOKLxTldqwdG8GQCWRWJlViF86pA3PAiS8CYKNZEBrIT6vopWndZ2ZaPLvuwcK6v/aPTaUjsr4X3Pr2M9qEczP0wdzPSuSAWBP4/yC2FrSXvO0EHpCQxrCAI=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5147.namprd10.prod.outlook.com (2603:10b6:610:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 00:04:22 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 00:04:22 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] namei: Standardize callers of filename_create()
Date:   Tue,  7 Sep 2021 17:04:13 -0700
Message-Id: <20210908000413.42264-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
References: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:805:f2::46) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.7) by SN6PR04CA0105.namprd04.prod.outlook.com (2603:10b6:805:f2::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 8 Sep 2021 00:04:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3773015b-1abb-4127-b063-08d9725c3666
X-MS-TrafficTypeDiagnostic: CH0PR10MB5147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5147DC5202AEE2141CDAC14EDBD49@CH0PR10MB5147.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b14HRE8WcVbVEb/m81xcWflIK4E6+f8/4YbqIxAq5Lul5U85iHGJfe+zD7zM?=
 =?us-ascii?Q?xp/j0v5dHDBPrd9m6535VWWGZwhqiqXUdwmqgtK2EqwHPNPo/19jZF4Mj4RX?=
 =?us-ascii?Q?5GSvK/qsrD/6PBmc0XoBnVNjtF94pCVkBpZHXkj/6o4fEGiUM2kHC9XZ2Xk5?=
 =?us-ascii?Q?0rzcBUfIFACsOaztkHh7iDmB7cuhBgY7OsfeWwoEeCo6a69h9dFKqFGdXSts?=
 =?us-ascii?Q?OwTrtGdxpe7ss6YPfjK27WPQpHnKg7Uqf+riyeXP6VcP7Dp7FE0Cy8dos48e?=
 =?us-ascii?Q?mtTZDstPnVlzQsaiOU67z0zAYvKWjSb3clYTYUZEp19lelWoKUZR6LzQjoI5?=
 =?us-ascii?Q?iPtdybHwqV/kMxKdhPIBbpfB7BgmaVat0ZjRj+5PW3mYFexcC0qzVlOMYkjR?=
 =?us-ascii?Q?5mR5InXA6o22kNlibP+HiNavALbcicdW5H167aYMTbRbVRjRSg24Mt8HTDuM?=
 =?us-ascii?Q?VtST14H1E/Utl4KDWPo292s2Wb9MFoWXOCw2bpO1DGm94fxcdF7mKivpK0Ey?=
 =?us-ascii?Q?l5Dv9ZCW9CZOqmUmDhcFTjufu7xvGSSlJZ3nbOegOKTnhTq3n/q1ZZqT0T8h?=
 =?us-ascii?Q?ZIilpMQf7jZhM5lBqQi9DOZdN8gZC1/Uh/HNaHEdJmbvLhVUsKk9a3uD4W64?=
 =?us-ascii?Q?b4o6lptSeBv7XG8UGxP/Hv+4f9Bcxsou3puJJE06+AYDNkQBu5lA/hxJl3sL?=
 =?us-ascii?Q?8fvSpZlGSxavetoqg7AfYNq6cLP1ziXvKQqkjlkc4GIuj0VfhMEySGdYrNOM?=
 =?us-ascii?Q?gcPF0Aw3NglrTxyHWKn5YfFIAmxvDzs4ruf6WL/anMApn7scqrOp1FkL2xUm?=
 =?us-ascii?Q?f2dyyI0/mI2fgLyYpJNlYoZrtuGHyHhiPyuD7Mw6CkT9U5kkuzH2I3rTXu+i?=
 =?us-ascii?Q?25TLRy1FK/8+jZlh8SFT468t+H6rt3NzdKhZPNcKT3o1sO7LAVv03GcSt7qQ?=
 =?us-ascii?Q?s09ckt06Ao0iAhlJkwnHwd4Csqve/luCGnUw09VwlXORCYk70B3ykiv4N5an?=
 =?us-ascii?Q?iqcAlvvRL6NiEPHbbGCz6N6UbOuKCGcALwBOsIycKdXkUdzIoH/bvm4+S4SE?=
 =?us-ascii?Q?eLaaaxK2h8tLdeyHWxhTOW0hwmeVFLPNZ1G5VXxZ56wvLbFjiDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(8676002)(2906002)(6666004)(8936002)(103116003)(478600001)(66476007)(52116002)(956004)(316002)(66556008)(38350700002)(38100700002)(36756003)(6486002)(6496006)(966005)(86362001)(2616005)(1076003)(26005)(4326008)(6916009)(186003)(83380400001)(5660300002)(66946007)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WopiRuJqYRpu+c09h8SG+jobvKCF6DrtOqnDcmFUCx0Y8YGkXYshNek4qA9O?=
 =?us-ascii?Q?vHUshcorF64Ln95tOSlyp3ll/M62EyPq+sRAtjEVqwwvsVyoISnO+psl7l/u?=
 =?us-ascii?Q?5RiR+03LRSzftYn5a/AKhkjDVxAkPdh7jNckv1+rtMAI+vamM2UsczmmmAAG?=
 =?us-ascii?Q?GcW/1duxVIJN+T2/7VuaVdHmIscnFdy9JhtlWs1t86TZEhjYpmZw733zZsoL?=
 =?us-ascii?Q?LCiOZMc6W2cHcgb5ILp508QktaoqCLXJnKhcrxb8w5RNzSU4kvxlaV2tN0dD?=
 =?us-ascii?Q?NQCBGtC1aGGVgl7azt8Kamqr8X0UzTMDYIcA58Z6nBjgeOwGKnavMXVU8EmJ?=
 =?us-ascii?Q?Eshv9fooDblWXMRo+qhfhb7WtImX7u3JQTR6fiiEHjjo+ohO1lr88DQPBS0L?=
 =?us-ascii?Q?73ZN9+cF6bJsKSX76gPdLrrEpK5rroRntHBZtSHONpbNWjbSH8uBevU3WNnr?=
 =?us-ascii?Q?OXyH8/2Eb8yYaLeK0TW9W4N5xMPreH9ttstbQtOJOJmiDQh0GLsLjOq47wWF?=
 =?us-ascii?Q?HtP01VZCqlIIHsWb6kldg+j0tyDtXkoxylv6qDG0y33xmQM5E/zefw/A10xo?=
 =?us-ascii?Q?xPKw5sWIitpxik0hSacHhhch5upjOviRUcAuTkL8ZivIWuF5HWwHNy/ngXOw?=
 =?us-ascii?Q?n5eWD+yF+VNCV+eEu3hJgoPJQsQy+mG8irJvJuNO8/Pkp0HKvU8wV5zwKSAn?=
 =?us-ascii?Q?GJKP+urcX7D3H+TVxRzM/4t0gfn9DupWOHc+T6O5XouDEtmDUgKQTc4FzOJx?=
 =?us-ascii?Q?7QYDJNg78JmJIxco12DbKI0iREGlZgQ9eqM1Y8DbIpfvlG9yxz+xWgcqsGcj?=
 =?us-ascii?Q?CFw+vumLA3+3EoTgQwZmoMfCKql6AkIigzBYfQpfW7cucEq5JqC5qnxBpzlu?=
 =?us-ascii?Q?MF1pGuZkLR7NbIPTdQ8eiG8zZSon88fkH0oKa4dgwnLtReGh8NVzdEV1Hcxh?=
 =?us-ascii?Q?dpqE0YtLqH+5qh8f5FSB1PuYdg2wDYPKS7kbWZQoOiK6g4PZfIVgbIlO8pSm?=
 =?us-ascii?Q?fppgS8VoN8gCUXSwFfE7PXwJ6lF7iKAkfMfDc9It1YGeZ3LJGkxxfuFvo0aU?=
 =?us-ascii?Q?P3zDwA02l15hobgpjPkaMbX4wbwT/HeuzdZsqIFrd5UDjVcRRlfIxkG7E4SE?=
 =?us-ascii?Q?uQ7fwT2n5Xoej5bfvlwHILWvtdxSTuJTGaYDJtXCdeVqaqp3phNEkl4CDGst?=
 =?us-ascii?Q?BzKr89Fs9LaxD5Spd1J+Uds9aBz5AItAjllKRHIGUWLxnZyaC34Q5wFgLxdt?=
 =?us-ascii?Q?KqCChuR9CbzwtPq30IOmuUXQx5i24kUA+5uael0tSjDrQ8hDfEuEKcJisS2M?=
 =?us-ascii?Q?Mn1PTInvTvOfdPYNkmHof+l5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3773015b-1abb-4127-b063-08d9725c3666
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 00:04:22.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSXBrKgtXATm9lVGwsDxXHJpDF1Y8vYqcG2DW/XdwPVzVMkmvxIrg615MNaOhatIaoHoTpMs24yMYHKcxMPJAtu3sWDnWIeDzOYDVf6GUk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070152
X-Proofpoint-GUID: Gs1ztt_lbBd99-qzfoM_fXS9AXPUN1Hq
X-Proofpoint-ORIG-GUID: Gs1ztt_lbBd99-qzfoM_fXS9AXPUN1Hq
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
index 7bd3d1c90e52..88cdc379255c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3625,8 +3625,8 @@ struct file *do_file_open_root(const struct path *root,
 	return file;
 }
 
-static struct dentry *__filename_create(int dfd, struct filename *name,
-				struct path *path, unsigned int lookup_flags)
+static struct dentry *filename_create(int dfd, struct filename *name,
+				      struct path *path, unsigned int lookup_flags)
 {
 	struct dentry *dentry = ERR_PTR(-EEXIST);
 	struct qstr last;
@@ -3694,20 +3694,16 @@ static struct dentry *__filename_create(int dfd, struct filename *name,
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
 
@@ -3723,7 +3719,13 @@ EXPORT_SYMBOL(done_path_create);
 inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 				struct path *path, unsigned int lookup_flags)
 {
-	return filename_create(dfd, getname(pathname), path, lookup_flags);
+	struct filename *filename;
+	struct dentry *dentry;
+
+	filename = getname(pathname);
+	dentry = filename_create(dfd, filename, path, lookup_flags);
+	putname(filename);
+	return dentry;
 }
 EXPORT_SYMBOL(user_path_create);
 
@@ -3804,7 +3806,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (error)
 		goto out1;
 retry:
-	dentry = __filename_create(dfd, name, &path, lookup_flags);
+	dentry = filename_create(dfd, name, &path, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out1;
@@ -3904,7 +3906,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
 
 retry:
-	dentry = __filename_create(dfd, name, &path, lookup_flags);
+	dentry = filename_create(dfd, name, &path, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_putname;
@@ -4271,7 +4273,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 		goto out_putnames;
 	}
 retry:
-	dentry = __filename_create(newdfd, to, &path, lookup_flags);
+	dentry = filename_create(newdfd, to, &path, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_putnames;
@@ -4435,7 +4437,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	if (error)
 		goto out_putnames;
 
-	new_dentry = __filename_create(newdfd, new, &new_path,
+	new_dentry = filename_create(newdfd, new, &new_path,
 					(how & LOOKUP_REVAL));
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
-- 
2.30.2

