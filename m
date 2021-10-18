Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF54311C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 10:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhJRIEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 04:04:32 -0400
Received: from mail-eopbgr1320111.outbound.protection.outlook.com ([40.107.132.111]:23472
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231223AbhJRIEZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8M+UhoRUQodCF8pPV42tJjH7FfgWmVu/zcUrP7sAD9kPlVQAWHAHnyth0706cMFrPmS5fO/by5Wjl9KMFF+369gpa2E18wCWEY3ichwh7sb1hfnyuWyug86tmGREt9meGWF0acmfyc/ic9d+vsY5HYHraisLyhlG4DdC9DaapYpD9KlS5iPT9LOdPBt4oil9O+KtrMwpQjlFBT2Qj+EWeC0B0cE8uimanASfGt8tMTRn/1nDAVoM78ScaHEnt3HC7lIpF080Pu8Watdo5ncj5htIZ/6cutPIbHS+1PFLM9w3nfaHa4h/LMJBGbJUNs8L4NruALtIxDj27zGHNgh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTXF4ly5GPJZ6C7q3gTj4faOVfRmGDwKPe4cRiF0Cpg=;
 b=I2cYITcd+KAFL4D2cx+szLgxQwv8JqIuOGuQIxJ4/fSTqaX5fvujIoOpTN7WStsS4aFdmyUUV2K6h9gW5rx/+ZL17BBfiAzqak5UdMcPMIWBrXhZDIWEJyLIYZd/kSVUZSpR/8GvkjmRSW7o1yqene7NSd9yPToVhz5idUf+MtBWZuQHtVYepHobicbSDpUA0WDoEWXlA+zatnW9dA7Q0sxKNyksF96F+S3WKAdD+6I/Y4/iBOM6gjYWiCDTSrrHfPLm1fZTO9uyfHTRsTj0riqLln1QvZ6DrrPTo0i85iaVZ84sNoSw4RXqzyVBLCs6nCainc5UEKfs1ZmyU8DBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTXF4ly5GPJZ6C7q3gTj4faOVfRmGDwKPe4cRiF0Cpg=;
 b=Xo8xnHIgTv7L9f5LMhuAiOHDeWaNXEjmb9jsuVknHPMDfChiZhCVIoLcaqKUtQ2ShmM1YW+S9BKHv+Cwp+4u83+v8sjbyRYECP1tIkWwS9VUAowHcsldD/mr0H3pBKCqiB/Rf1Urocv1dv7YKWupDc5L9Ouh1+yXkCOxi6/ACaY=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3387.apcprd06.prod.outlook.com (2603:1096:100:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Mon, 18 Oct
 2021 08:01:26 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 08:01:25 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] fs: switch over to vmemdup_user()
Date:   Mon, 18 Oct 2021 01:01:18 -0700
Message-Id: <1634544078-36968-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0068.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK0PR01CA0068.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.17 via Frontend Transport; Mon, 18 Oct 2021 08:01:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05a98934-a5f8-4a7b-2460-08d9920d7bac
X-MS-TrafficTypeDiagnostic: SL2PR06MB3387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB33877134200058C2D47A020EBDBC9@SL2PR06MB3387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4FVJ2aZpqrWtmuro4HfIoTd7Vd5FFdroudRNitmqK9sOgsKX3TCjQyXGUk+T5CGuTTXEaZacsCl3zZ4HZ80zfqF7MEC6T3F+vlc5f0koQYE+hn6HFIahKC+TQmQ2bz+CNcmxZtqaHeSfcYnNfiT2GRskgRdrsSOdaE72Ovr0Ez1i7wipE8kYCE5ZjefWXzMkv2GBZg1d92as5So68AprBXQwzDxyf6lFtRg++H0xHxX+skMYMKe5erWa2yRlgpNe8rdH6GZOiVw5fnIK9KWu17Dp2PnPcKjalUe3dwiVYmlsm7lh4rJw7sEr6jTnCTT+dFmT/QMYedcD3xbM64kb6bkIBiTAV+JVhCnB74Zgu+Z6eQchikJJB236JcofQP919+DCB7xr1Li9qW8plBc5866vBwe3dl8vsdA6PZVm7nswh7hdRl3RIZMsB71WqKJayGmfOHLF2o4AtfD0KGDgjmb4pE9WTyqGaL3jesCTlH5zejUUqvqdk12ZDnIBrrLOtccgjrbBaqBkRbmRjH78pr5I+QI1ma/WIlOf7Ixvr4ZnRp0d2eQIKIWN4PoKKtS68phhfmisuCpZFT35UVT9feeRW2p+gkvVMtGj941TjrPF0Sa/VCNfekk9wtrvORWgwcbNyWOeR5Pq2KqsMgSTweVjVDxY+Zh7b8Cjo0iSL8XmXQe/IlYVIFT2pYjYkdwdaHTFldsHzQ+Fc+35uamIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(36756003)(52116002)(6666004)(316002)(5660300002)(2906002)(8676002)(186003)(38100700002)(4326008)(38350700002)(86362001)(6486002)(8936002)(508600001)(6512007)(26005)(6506007)(107886003)(956004)(2616005)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YC1hFE8Ob+ndnwj2UT9ZHDaD8WA28BdmEMpdrBmJm0WS7KzKx8DYVfNRRqBe?=
 =?us-ascii?Q?ikBE2clbOJPBJ8ITqM9LZeGcyxFdgtkPxeK1r3kqMk9lvPKQTFW/Q0hQOaPq?=
 =?us-ascii?Q?Qx8wy3HoyIMDkdX/m4cX2itJI4BGGd0Hw0MK90f2UFni3eYAhQuOqAOTNa47?=
 =?us-ascii?Q?h2fx57milePhTlVWbJkCARZ/RqVBYtWbxRdxG/XIDmjEuy6Pv8WnmJQRx/Z2?=
 =?us-ascii?Q?ZhikLiZ506CUd/kxM8Z8ZwWCR9+WYc9f2KCX2icm6BMXSg+uKHdiwZtP8d/N?=
 =?us-ascii?Q?hl33fb4u9XKN9+Ha54THHQOwr3aA22YTOfu7NFe3AL80UakQKp2+Fy9p8Ffe?=
 =?us-ascii?Q?w/dqYqe8cSkrWbRIPCNZhWdoHGOWCYaFUQujoJLMEelEQj1P39qEdr9xUhd1?=
 =?us-ascii?Q?7lU/9ScfjvFpjfUCIZOL2JWS0t38BiJWnjI3uq/bS2KLXAk9/kfVh1anx8pq?=
 =?us-ascii?Q?zzZqfkA7+tpD6AdbQ3tEsh0YWTpfwvY/L8kr/hNUt1/nQkovlCzfD4BQUXBl?=
 =?us-ascii?Q?CruOqeN4+ZaKB1PGh+nYTl7QMVsKZQYsxe6C9M7dLwDFJmB8Zv4cS2atPGqs?=
 =?us-ascii?Q?AF3wx1uCdgxhSa2UefdGbjT4HAx8PWifYdVmEvlhM5XaBosTI4nBKGiDaWFu?=
 =?us-ascii?Q?8mifi17INBQDXdOO7s0NdW57oM0vEkktvISlZyhjDeqmVnAoiIfOx+yUPQOT?=
 =?us-ascii?Q?M94Ck9MmOHhsvgQ3i63z7/4ksCRH9irv7TMNFehwZSANtXKw8OjC45Y90F+T?=
 =?us-ascii?Q?qnU7+YrLDKWNvcyo6cgvS6ignq2YD8iR5u8/qwzm32JEmltXvT/+lYD5/efc?=
 =?us-ascii?Q?1XQ1HUxUH7pJ6yEOPHJTHYIReIJZbxaoT/h9uxNWnh0KcWLDiYHdDt0vGBbp?=
 =?us-ascii?Q?WpFKcIDaQc7G2GkmH3LwWvsf60sxps0SzcIwU6bvMXrPu19QA8uS40DPbjeK?=
 =?us-ascii?Q?Ktv/UoyoZPb+dh++SqNRXQ1h36Vo2hwqEjVT95ceHlZSIuPf1D9UR95HNK6H?=
 =?us-ascii?Q?deTSmB8/TtNrQ9B+QO9qC95TNdL48t1Ynn7//dcjci1yKoZqxaUEudZ76nj2?=
 =?us-ascii?Q?RW8vYu8KqP3qgLsgJi4xvInc3Pkbl9UOjsf5QM4Lvnyok8p1f0+3+QN22l1x?=
 =?us-ascii?Q?mEgDsbBLS4EVN7Y1/UHi3ykoKEO65bGpnBl6yKSB0Oj6tXf+KbiJl/sJfX10?=
 =?us-ascii?Q?ynz2XWOXrZWJz8vZfOkSXltpC/t4Q7tezElJNUnlaBKunCza5JouGG75CUo6?=
 =?us-ascii?Q?It2cbzlOnwx/SJLZActvuz1dofr5qzUo9WbCa0ifLdQaHyu2xzOTl641JIi3?=
 =?us-ascii?Q?hEspiNUd1sqbCpSfau3U7NZF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a98934-a5f8-4a7b-2460-08d9920d7bac
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 08:01:25.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9z8YtiZO6dFVgQlv3uU6a6LCtZQFwPfybDZ5bu4Hi8iC0xpP60+YIsP2avxSzxRbscFEMIlPBZkd1O6BEtjoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3387
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fixes the following Coccinelle warning:

fs/xattr.c:563:8-15: WARNING opportunity for vmemdup_user

Use vmemdup_user rather than duplicating its implementation
This is a little bit restricted to reduce false positives

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 fs/xattr.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c517..288daea
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -560,20 +560,17 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (size) {
 		if (size > XATTR_SIZE_MAX)
 			return -E2BIG;
-		kvalue = kvmalloc(size, GFP_KERNEL);
-		if (!kvalue)
-			return -ENOMEM;
-		if (copy_from_user(kvalue, value, size)) {
-			error = -EFAULT;
-			goto out;
-		}
+
+		kvalue = vmemdup_user(value, size);
+		if (IS_ERR(kvalue))
+			return ERR_PTR(PTR_ERR(kvalue));
+
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
 			posix_acl_fix_xattr_from_user(mnt_userns, kvalue, size);
 	}
 
 	error = vfs_setxattr(mnt_userns, d, kname, kvalue, size, flags);
-out:
 	kvfree(kvalue);
 
 	return error;
-- 
2.7.4

