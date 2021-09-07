Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A140C402FE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 22:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346825AbhIGUwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 16:52:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35098 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235183AbhIGUv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:51:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187I9PTF006454;
        Tue, 7 Sep 2021 20:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mrZPNwyb9BbCdc/OdJI+hLneeob28IHL3mwzE/kTTyU=;
 b=qHLqBvlrrlIh0ZUi15t2jRKz5hmU/m+uhIpogeOiKZKU0sDbtgJjnsa9kPj67JxfCjA9
 oDk9kdoAOBPabeoY4gy1Xr62/YYbTPWhgY250z3TMqNRzPXoU0hTl3TH7iigvqfaKrIu
 b2L6w8ArERxJBPPpvu62vKjZtfOcSlGRt0JuCdNYnAnShyyZeWD9hVtVV+Q086DMUedv
 HeoR7tkLqTLRX0ApcEHw69sAHBH9IZ4ET9l9vpWRtnKkQfiuX++uXB45ytZ8ZLIHc0xb
 czAatODDQwqplRJ6xMt1aCKrBaRdoyya+YZtkFKIcDsgyDXDi5KTly6tIpc7e716tfaz qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=mrZPNwyb9BbCdc/OdJI+hLneeob28IHL3mwzE/kTTyU=;
 b=LJAzQ5sRPslU94sH5hMYukz/p2njslxm7Ds8Trqb1ZJxNHNCAszo0jh1mj8yo5NxYcTR
 qUzko3ze6ukFHBEjtucH8Pl9zsWty4w2eMTUy8ytmxEjlmLmOq5PyNXLxSAXmiUxWYwa
 3V4AjF8vogvsXOlCcDajZIKT0dCaNXVStAhLfPZofJNUoJWg4DPtY/L/0Oj228XUMtQz
 UnKLVsgU7wGg/sZK6W7EUE8a9Hr1wKKYMMMbGOph7xZfH5fiFYmVGcwfDr+1gBmhTzu1
 S9ien7pURKSJkKPvDTntXy8mwYJDwFTPRhJ3Lla27aC0gzkIFEEvLkHWSIOV0iQqTESe wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd44rcw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:50:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187KQPNt178950;
        Tue, 7 Sep 2021 20:50:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3020.oracle.com with ESMTP id 3axcppg9g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5UQq0+GUgZeD2Pd/QwYZ4kv3u5412iKiVfLzn3AQIAazOt89+ploVm4zFtlU5ueJoF8L+hKuHQaPtHtJqBriIgGFINAH1mNZkcRSOkljPbC3DLkL/Sq+Z+czToHL4DYmngQGsYx/zRbM6/vZ0KNDy7+Xh9hMmNWHAnxoeAX29Ub3q6ffAakrgFAJs/4ifXHZ4gA0BgzOmHJWSvsd+BbFTJXp2rr1G5mRMo9+2OidLPz6XV/NBtxqUX7AZD/RHom9+ZtC94UYh53kmbqi6OSMnHL0MqzAKvf3GjbQIN5Muvcyal1dVVApTSH33idLkbNjuMN3PAPRhIjkouo7K2XKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mrZPNwyb9BbCdc/OdJI+hLneeob28IHL3mwzE/kTTyU=;
 b=eoSo6AYydGnuh1b3+cpFoIDXswZiCQ19tRB+vm75itXNdUUVp6NDHNpcLByAU3hIR5x7d1YcQmDU6Sct1pO1Crj12vhXByxdclkqaF98yX/VV/iuPsN2/vJBakDBwIwE3nvQU++yJ02NlH34plE5g9nRaUDMQMU7gHtfoglq2zli8qPgB8UKM8Wc/BSvvnIhmLGa43g+xiGng14c5M7Up5XsIax5FtCb8W67y/xsyIr9m7hLOWBPXKW7qhqCacfSqViPUKmE+ulAMZyyVK7d9wvxuSc5wUQgIUQvzTL4KX9Kz0w6g0EV8kQxF+pkj95K+dtWR5MHCjACQYPvwwjknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrZPNwyb9BbCdc/OdJI+hLneeob28IHL3mwzE/kTTyU=;
 b=l7cDYYUqoyhu/20y2Ki99e6m7sMCX/2hM+Fa4EM17vOlK7gzVL8d4atVlPOtT0Bg9NCt/H6MkkT8cebvmGeOMh+NROyoUO5qLMklBDxOQftFKiY5B/l+Di2u0Fmo1er5vPk+eP0sb/v3Nco0/En1mCw6F2W/GmVhj563sI8PPBg=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 20:50:47 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 20:50:47 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] namei: Fix use after free in kern_path_locked
Date:   Tue,  7 Sep 2021 13:50:41 -0700
Message-Id: <20210907205043.16768-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
References: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (136.24.196.55) by BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21 via Frontend Transport; Tue, 7 Sep 2021 20:50:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcb37d4a-e897-4a5e-1c8c-08d972412b10
X-MS-TrafficTypeDiagnostic: CH2PR10MB4149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB41499C2BD8DA3C4F9E6AEC74DBD39@CH2PR10MB4149.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?niDSeREQDxPquc4oLNeG5m/WTYx5d4b+nzH7LiQRf1+6IHZKSicub9jonvVb?=
 =?us-ascii?Q?g3JOj94HCAKhv634X4++dTdGZda8mIt/rk8GlD8obLLrS1f/QVLxabvO0Hnf?=
 =?us-ascii?Q?ri1r+3qj3eL/T/f2BON5644BYCgcnYy7blgEQ/oH9yMxbnVy8RzUPj4mt0wz?=
 =?us-ascii?Q?XM9dVVOdolQmIe3Rukmi/uSCENiNqYju8VmCEJcwehVS5Q0ze7ZWs6d7P3Kq?=
 =?us-ascii?Q?pG/wf4UElIHH9jg93byTjL+zg+qB8P0bohuOrS4UxY9bmtV2n/q9oD/hSa1S?=
 =?us-ascii?Q?h/5iG2mJdVh2KKSPXnvDyQ9Y22H5fh7FVaUffh/WeutOVA4EjPSWN3avwIFM?=
 =?us-ascii?Q?Iv/IXIqTkPrwp+upS+fdNqghpsKCjJeGF64t/tnbiRDRjHqIUGxlSMVbL/Lw?=
 =?us-ascii?Q?M4V+zwa6fgu4jW+U1Bq9qD3JwbDyr7DDU2LXr6DldmmeYOXZck1fvUrfg8rq?=
 =?us-ascii?Q?kRfSYEG+Zltsin3iSB8E8iFO1ORcfEUeQxSZpAY5xn7syi+AB6BtRki7Eo5B?=
 =?us-ascii?Q?+Oo2Y5CJGVtSd6f5QqXR4tyRqtlXNFeFnkq9H9ksIsiC6NQDLAHTXn9/I+4p?=
 =?us-ascii?Q?Es00FYskDHYXY6Ym1rhAZqFg6UcURLJV5CYnTJ9mvBTYw8NleFYPNiQ1K8WU?=
 =?us-ascii?Q?TMoo18XwZg+09rXDx3x6VwYqBxY8RDxC6OlNIa/QWUOZnX5uh1ehMvFF0Hrz?=
 =?us-ascii?Q?Q3Grvv0jPnos+2SLijuBEDzJ2C+sn3mqBYTNllgAZtyiulhbxD7xgmQYA38s?=
 =?us-ascii?Q?I4c0sqRlVaDltMu1z5uCwuIZtVKUpk8/23MBOxFp94PLjT9wURk4/bKRNY0R?=
 =?us-ascii?Q?ujP4PWMHsjkjbdVeYqOIwZYaTJBdc7WHK3Y6lpyAdTDp6xgov0zut3dbJA9w?=
 =?us-ascii?Q?UoLafvT+XChlONeLn3jim9uhr9qzTSyMbzqT7R6C2x/7kPYhpJoqkQy+mTgT?=
 =?us-ascii?Q?zTrHLnZhiFbk6YPaT0rLUYi7u3GsumGgpCcLBjPAjplwU+a5JEy462YsKN4j?=
 =?us-ascii?Q?UPTLXXWngcmDbEDqbgkIb8RUX84R1SbCG/E1dl0ybVT6b2bWeF348qE08wdp?=
 =?us-ascii?Q?g2/Jfj/WPazmkS2K66gZrDg/FuRHkGUb6Z7qKz+ywRIlu2+4ilamYprPAWPk?=
 =?us-ascii?Q?kiCISwoR1NFLc74NJEu6MWuUi3lk9CDwrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(103116003)(83380400001)(6666004)(26005)(6486002)(86362001)(186003)(956004)(1076003)(8936002)(38100700002)(2616005)(38350700002)(8676002)(36756003)(5660300002)(4326008)(66946007)(66556008)(66476007)(316002)(508600001)(966005)(110136005)(6496006)(2906002)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b0QyD8AeF9uuWsiajM0rxW3BBDxabT83LU1IHJatkUONSQJmDAoXY9xmnmAT?=
 =?us-ascii?Q?xQAJW56gOUxO+47KWAKdYqTVRy/JqTqLPdk8w8xGAja5B8CGgcHRHfl3nP1g?=
 =?us-ascii?Q?ecQ7aI65mEsHWqyFtWZKA3HN/j4hLcv9HAddTK03mZPMWuTtp7zTRFZqzHi3?=
 =?us-ascii?Q?gM0G+zZqUWQcIbIdOWeKTKGLbG/GT1CIN/bziAnkMTW/mrNE7NF3Th7HpfyF?=
 =?us-ascii?Q?0lgOX0lCGXfgYDzLlyKqaovA6fg83LqPDxy0o0pN4gzjgJzHTvRSEn5cQSCg?=
 =?us-ascii?Q?MVlnhrY/RAsa6eiEO63biyVIrTqMQ/te8mEkXQV4bAW48TPFjSo02fjSU2va?=
 =?us-ascii?Q?ExkcZDjOS8XhWkGT2RqehL06TC5xNsDdwKSTJ2bzQQPnP4L5kIszLWnsblmo?=
 =?us-ascii?Q?/EMllRdUDrFxVY1KhM/TgG2Zqn4nNjDSgwRmPuHkvkMSkcHfXdtMtW78zDw6?=
 =?us-ascii?Q?rTxAtEUnfKiyUd2gtmeQUdA+Rw+UODe9BfpiXmRL21x9lrj3jpMeYT6w6zmn?=
 =?us-ascii?Q?Tph/dHbCDAkm5JGSpwHEUBBMuxDccaynAxYfB/i3hDK3lfCfHJoGzxqN/W9s?=
 =?us-ascii?Q?ogi0S5JDqnb5kppYSHvZDOA69zCX+66rOvCPoINAnhK5zWnJO3car+pb43KK?=
 =?us-ascii?Q?ZZ9FOVAJiqDDVCHsEfuOwGQ5mdyXItzovWzZLrju/josTwT0UNAnpuNO2OSW?=
 =?us-ascii?Q?L44f87GN+06b7wFlTvFN8Rt5jI1Kq7w97/woQKlCNa8yGfRTrWqEIjKz7UOW?=
 =?us-ascii?Q?hPR6Qzk3Tdj85mc0RMm55ip2RIzfS8Te5rImKUJo45kAYyTOwm2l3NEcVAaj?=
 =?us-ascii?Q?s9nJhTaL5LR487lGrTimzitr0yRmgByGasGJQ4Mg9CEFR+QjznB4XMuYKmVS?=
 =?us-ascii?Q?ikf2mvd0aqRUvuv4LpOm9UKVrzAa5+f8J1ALFY6B9uZe6w0qQHdFpImAbXz9?=
 =?us-ascii?Q?FzavMqsEqVsFiM+LgHXGcy+Bibvx9uAZeHeO642M6xGNP5APOCe0ES62Ks4F?=
 =?us-ascii?Q?+ExtbF+vI3vmN2uUvFys2B0dy5yvMK0PY7qtRLXO6rZ1NvXULsqAOiuNsNDf?=
 =?us-ascii?Q?GSlIqbcVcF9P/S60gjseKuYri1Ax5Mx21K4x29waBkmbNQiZzBMzC5VSenQf?=
 =?us-ascii?Q?y6BQioGoHZkYUhuc1AizDJpufYINoUHaBgvTCdOsOXAJLuCKdNT5bGqkiSAY?=
 =?us-ascii?Q?EFrT7Atdxg6pJyUSNhuexSV8zP8mc80a3+/0q6EBAWZezoAs3YJMw8ORzxDC?=
 =?us-ascii?Q?7QC3ePF8h60FOnH9ASdH805sX2q9MT58xJTgBaGS8ccVZwWy5/NXVFk6WhHz?=
 =?us-ascii?Q?K02J2BcJu0lvkwa2ojzEK/vr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb37d4a-e897-4a5e-1c8c-08d972412b10
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 20:50:47.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWRTWYQplu4ZmBTOJQ6kNVJJwlur/HZrejFTEr0NMEM0iDqh/PQcA1yaUiToBAn4oZMRwzwMPYEflJUV2GdwiVMfSQEDsBdFaeMmuo8DvyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109070130
X-Proofpoint-GUID: 8T5xfO6vbJTeRdxhLaCDuyW__VlgV5LE
X-Proofpoint-ORIG-GUID: 8T5xfO6vbJTeRdxhLaCDuyW__VlgV5LE
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

In this case, filename_parentat() is fundamentally broken due to this
use after free. So, remove it, and rename __filename_parentat to
filename_parentat, migrating all callers. Adjust kern_path_locked to put
the filename once all users are done with it.

Fixes: 0ee50b47532a ("namei: change filename_parentat() calling conventions")
Link: https://lore.kernel.org/linux-fsdevel/YS9D4AlEsaCxLFV0@infradead.org/
Link: https://lore.kernel.org/linux-fsdevel/YS+csMTV2tTXKg3s@zeniv-ca.linux.org.uk/
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: syzbot+fb0d60a179096e8c2731@syzkaller.appspotmail.com
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Co-authored-by: Dmitry Kadashev <dkadashev@gmail.com>
---
 fs/namei.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d049d3972695..f2af301cc79f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2514,9 +2514,10 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 	return err;
 }
 
-static int __filename_parentat(int dfd, struct filename *name,
-				unsigned int flags, struct path *parent,
-				struct qstr *last, int *type)
+/* Note: this does not consume "name" */
+static int filename_parentat(int dfd, struct filename *name,
+			     unsigned int flags, struct path *parent,
+			     struct qstr *last, int *type)
 {
 	int retval;
 	struct nameidata nd;
@@ -2538,30 +2539,24 @@ static int __filename_parentat(int dfd, struct filename *name,
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
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
+	struct filename *filename;
 	struct dentry *d;
 	struct qstr last;
 	int type, error;
 
-	error = filename_parentat(AT_FDCWD, getname_kernel(name), 0, path,
-				    &last, &type);
-	if (error)
-		return ERR_PTR(error);
+	filename = getname_kernel(name);
+	error = filename_parentat(AT_FDCWD, filename, 0, path, &last, &type);
+	if (error) {
+		d = ERR_PTR(error);
+		goto out;
+	}
 	if (unlikely(type != LAST_NORM)) {
 		path_put(path);
-		return ERR_PTR(-EINVAL);
+		d = ERR_PTR(-EINVAL);
+		goto out;
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	d = __lookup_hash(&last, path->dentry, 0);
@@ -2569,6 +2564,8 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
 	}
+out:
+	putname(filename);
 	return d;
 }
 
@@ -3634,7 +3631,7 @@ static struct dentry *__filename_create(int dfd, struct filename *name,
 	 */
 	lookup_flags &= LOOKUP_REVAL;
 
-	error = __filename_parentat(dfd, name, lookup_flags, path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 
@@ -3996,7 +3993,7 @@ int do_rmdir(int dfd, struct filename *name)
 	int type;
 	unsigned int lookup_flags = 0;
 retry:
-	error = __filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
 		goto exit1;
 
@@ -4135,7 +4132,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct inode *delegated_inode = NULL;
 	unsigned int lookup_flags = 0;
 retry:
-	error = __filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
 		goto exit1;
 
@@ -4683,13 +4680,13 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		target_flags = 0;
 
 retry:
-	error = __filename_parentat(olddfd, from, lookup_flags, &old_path,
-					&old_last, &old_type);
+	error = filename_parentat(olddfd, from, lookup_flags, &old_path,
+				  &old_last, &old_type);
 	if (error)
 		goto put_names;
 
-	error = __filename_parentat(newdfd, to, lookup_flags, &new_path, &new_last,
-				&new_type);
+	error = filename_parentat(newdfd, to, lookup_flags, &new_path, &new_last,
+				  &new_type);
 	if (error)
 		goto exit1;
 
-- 
2.30.2

