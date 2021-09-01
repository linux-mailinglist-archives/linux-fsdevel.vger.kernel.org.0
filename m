Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8B3FE177
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbhIARwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:52:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19754 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236804AbhIARwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:52:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181HOLR5016764;
        Wed, 1 Sep 2021 17:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mrZPNwyb9BbCdc/OdJI+hLneeob28IHL3mwzE/kTTyU=;
 b=nsrbDTCk10kpdgLTONK7RxficCJFb41epvZUqz74WQUIiBx9+STHJJL0BLruueFQB0vl
 IbqaqN/q619Fi3o6E5mfSx2JgLoqK68Ap7pG+OcToi9PZJp0R/0Omh3X0ekozQhKtGrh
 3HYHcnoq8Rful3/h8ZWGQvBIRzYgrrpDly01ACVksp3lB9zUrE0IrIM1lBNepklzPN+M
 YLw6qbpj9ANyAMz170Ol6FeEpa8Qkm4Lr/+vNEVrxHcMlbwUI/X+nakUASdYqn9cwEiM
 dhAQ4GK54QVohp+KTXsvaXZ4sj3W54JDFkqMlmIeAEQSiabxrUlpIimA18PuCJgjoSBI dA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=mrZPNwyb9BbCdc/OdJI+hLneeob28IHL3mwzE/kTTyU=;
 b=UAbzgQrDe7UgnA46NjVbip0cuK1bDCCA3fhZYvhVfaH922uNwrqGkENyY1ygBOTwLKF8
 oaCz3/c0JL1wN/US/sR62XxDvo9XFmT/Oauuzq7C4ed1n8uBGi/b7HBWHcMiU+DyXrES
 Gwb0M47p7Dhuz2eO+0+s71LK6mgEftsCLjjB0OaCJqSqHj1dxw5N0/yAUcVQMgMexFl4
 9QcXGQ4qgrZsNU9t8pAnnkI+DyQz0RkGA48y0pTlC2UQ7AamogTVxe6pQtnMnQumCoZx
 EHDYsLP+RBe+MYUYVKiNk/7s9ploxIRC27zsGFiAGHZBOqTUFqzMqEqLir5Ygw7lqVz/ 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0g2jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 17:51:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181HpfKD183043;
        Wed, 1 Sep 2021 17:51:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3atdyu8u1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 17:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CelVXOwqIs7nrJYXXqZsIZou3aPi3SIwSNDqXaO876aPUHlOxBQK8YtbkR1YLKzeHmbpiIjfZ9/Vw2F5XpoeXWOVhPROM6dkqixP6RdELPt71A6eGC2FtYIk3R637Aa+6MSYnhpY/mneMsCio9Eey3N+KumJGEf9ZJ/ooV/5FOG1FbW9c+ANMJkc8GiwRTTwnosGEo3/nexPecc2kngA1DLCjwEODy/EJqPa1msP0RgujHq69vhU375l+nCGMYHGEThjbrrBNUAExRaPdoC2sIN14TWgSTWJfqUJLCXK3SJA/975ZmeVWv8f9s546MH0Y7fPozD6/kaeelQPAZBW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrZPNwyb9BbCdc/OdJI+hLneeob28IHL3mwzE/kTTyU=;
 b=A71bl+ShVrzSiuEZVrCqCkTW9opU9QRBCQxFbUYfWthrhN4pqOKbZN+Fst5/Mjj7NmZEJGxPOeCnieXgtkNu+dqbLUGJrfwc1ku51DNk1lMfIhsiDSryL4I0vwYdY188/cvhxeiYivoT0WOp9asiEBH6v9jo3sqLoyBV4iWoGMbb4wZ8uWu7EMCfTcYAsayETl5srMtTzTzzTmOkJSfrj9WI72hDzxm0f+ZjUdiR6L7U1RiBm0uGEdVa9JQI2qm+z+RRAK3Ft2gm+/UrGZVXpLkSJxsj1qSuOTnCJlkr9YrCHrMf7OFamiyAS6JGn6E4+xf41rLMrREtBD/wXSC+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrZPNwyb9BbCdc/OdJI+hLneeob28IHL3mwzE/kTTyU=;
 b=AvLgn7FMLu1BRayPS5+9UJ/a4yERN002aYylKXqBSBCqSrlzW/4e5EoytSKs7HqtZsppW08dIyYbcWw7VnTPa0frh7CgOzoGA8OfEjkSLrYFtFHywoE6ZkKas55+EMi9BESXtU2VW2fBFdyENWs6hi6zgDTCIt/20pFwVK7wCfo=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 17:51:47 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 17:51:47 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] namei: Fix use after free in kern_path_locked
Date:   Wed,  1 Sep 2021 10:51:41 -0700
Message-Id: <20210901175144.121048-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.10) by SJ0PR05CA0140.namprd05.prod.outlook.com (2603:10b6:a03:33d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Wed, 1 Sep 2021 17:51:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4f2bed7-7bdc-4e28-8b2e-08d96d712b4b
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB38637F034C295F2AC27EA29DDBCD9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fnd1zrepxoV7FY96CCZSrshBfX1lUKXnMLqWvXC5MpzmT3bhZatoIniAJTMJ?=
 =?us-ascii?Q?DzBcBo1dNHTg5LqmIGsx0KgXpRfhOJ86romyI8cbPMQt0QPSf/b9nfVZnVW3?=
 =?us-ascii?Q?IsaPvenyxy+/YGHaWlEg5nBnSNFGLWyPwyOeLXeoKuxVai2Ri6d9JSe2H2TE?=
 =?us-ascii?Q?3p8pWN28mcoslBsz/i1qfwgmiiaK81oHgON6MK71qgDDBZMC32bJO5B8a/MF?=
 =?us-ascii?Q?eJ5VMDwor3HKvDrc9LRK3TLBftpUWz6/AA9wDKwTxAITqO5sFdiaWSCWn9ei?=
 =?us-ascii?Q?xb6jucccZ9Jbr25RqraO3T8wA4EXf1gBq7mjOMrUCo3DH1x/HoBz+gvblVeF?=
 =?us-ascii?Q?1JjDVCzOMZpp7rS4mXEeY/k+aTqWOCA7vIGhu7kMVQRvRamdxObESHF/F0ri?=
 =?us-ascii?Q?FHr9TfeFw4aeY/rVONCXXhP3i8BHk6JPZ3wFKwIQdBXCqFuISrESoJcyYFtO?=
 =?us-ascii?Q?Ay8jg8MgYY+bCJbqKNIi6OPB0dL+jTb0od66n986YHUjbwMaO+Eb6GlDAC6j?=
 =?us-ascii?Q?QypucdvPYE3yfx+afo+vVSNLUY3Q9V9hcBYuw8zBTZLF0+VAJAl2W91P82kA?=
 =?us-ascii?Q?SONoKo4cTNyGDKoAiCYA/APuLXRTFIE8Ufr+4yDU4wp9p9+EBy9VXssKXeeT?=
 =?us-ascii?Q?GZvreSVj3yVpB7aJOOOxmT8WN+xOEu4VrLKQxdsaSdx3KTCaeBQvNWHaBh7o?=
 =?us-ascii?Q?5JBQrkfLVjt/zSw0vH6PXKeS8BGR74o48utYk1vwiJN+ZP1WLzpaZK9CvNoC?=
 =?us-ascii?Q?w363kT9JslJ1qOBhC9bsGZ+TYpJPl7CejTPxvr9ZBNbYDqd0VND+tAODEkTT?=
 =?us-ascii?Q?GVkZlflWIcmyZxYZdZv7hK0/oSIrYEFTJpDpeWlxt6LuvGwcNGgC05tfkPI8?=
 =?us-ascii?Q?NUiwn4x8hffIJvV1AmkqGVcn9tMs5E0YQWjvAXzDFAIMDS0CfRyszSBw7h39?=
 =?us-ascii?Q?6vpDazdOhcuL6hji0E/FNcmQe7ZzfW4kufgHV9z+jHxZlydjAZS2r9aRHqB+?=
 =?us-ascii?Q?ucQUd+yjzPd7uaqw/Gf/Mcz2pieC8LwycuJbb53pstLNYM51/q9UsLm8bMnL?=
 =?us-ascii?Q?iXmojSS5gVCmN5PoxzD913GcyzHwZnKpdP1qY8bHNC4C3LWfm3fdSXQC5gQ0?=
 =?us-ascii?Q?WsCjc4GwH9XlKqguP3HgD7WR6kDbbUdzQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(5660300002)(316002)(4326008)(38350700002)(38100700002)(6486002)(66946007)(66476007)(110136005)(66556008)(83380400001)(86362001)(8936002)(478600001)(36756003)(103116003)(8676002)(6666004)(6496006)(2906002)(52116002)(2616005)(956004)(966005)(26005)(1076003)(186003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxGJC4ODN5zSV/pV7alN514x0x7cWTpXi9ioq/KwRSEa/RpV5Gw2fQYQxKrC?=
 =?us-ascii?Q?M3jY8v8+Ze36zG0Ll15Gv6QQc6rgmNPdPlcZJlHjk8J3s4CdjnfdCqFSREeF?=
 =?us-ascii?Q?wy1Uam76uXFeN+N3prdVcYIxLyHUHKkbzYFIGjAcc/+ZMTFDHHVtZjUZGgYZ?=
 =?us-ascii?Q?kTu7tfJ20AE2Y7nFVIPyQ9lyQKhwXzVd3FI76wZ1CrVo05fpUFmcW0/lzPUm?=
 =?us-ascii?Q?e/KpuiWwh6fCqc4YnEGTZJJ9bh4a4OHhsr/JIp22pVNZm9lFtCyFbAflJ4Ws?=
 =?us-ascii?Q?FB0TNNdPLZzJR5d1POZInwuOFV3StQut51ghuR27wQUXQMNFFq1G5SA2B0SD?=
 =?us-ascii?Q?O0y0Ox+3g9fRvviDinC7jvSZL9Dxm5lSQe++VHhahURrgco6k0zvW/6H+IND?=
 =?us-ascii?Q?iT+ws55+hQtvxi/MB6K4YzMZPY4Xg1iL+darOFvGsIQDoJjf5HnsaRhhbrVB?=
 =?us-ascii?Q?iJnzJEwqGZVLic/ntxFLS2GNdmcTRuAm4u6DAFmkvOgEZVLQLTO0/ag8qECo?=
 =?us-ascii?Q?GYY/ginJu3PDvFZZZBYIFZU6IrxeBDmzBIevJlQXQ7RD2UODTVRLwGbq0BOx?=
 =?us-ascii?Q?YkiiUgTMDLJTpJYGkKJsZkl/PTqBnGo5e8h3YK/8FNcLZAgV5dRakI3RB6j/?=
 =?us-ascii?Q?Kci6RHvZ9ci1AnCUcuF05XkOlELPUASh62Lmg4BGQTKryset1KEKxddGV4Cb?=
 =?us-ascii?Q?GdXdCGqcpaPv9R9n/FmbfoO6Kd9UZM6jxZ2d4H7uib5Fqfa6/Gd7yCBc3NTA?=
 =?us-ascii?Q?68nIWaKdHMVHOjSXJYlXfVrgaTXMy+A7NlBrSnYxaXtPFILDLHmNCO4sIq1E?=
 =?us-ascii?Q?c6XLrzsgVwjO8WJQtWd5nB7GF+c23BU/Pxa330oHqULKuxhH08bY8/XFLDLP?=
 =?us-ascii?Q?oJrUB9UcQEOb0gCefAQBQF/JiEC/NnM+Jy2pNniX2CpJvKimgwg7fNjmYI0f?=
 =?us-ascii?Q?G3FQ0ruQUB+RE3ogObfHJo28tfNNFmL0KVm9k0XMWhheGyqmK+dM1wpJ/MdE?=
 =?us-ascii?Q?Dp8GeH5BpSG83omJHJNES97f3nkt9mgepf0nGqtn5Q/YaPDz+OREsp2LAFAj?=
 =?us-ascii?Q?m+kMHF5GWWCR+Jn1ANz1XI67RqXFMn9njefDlrNTjwwwbiACdW/AV5q/chGY?=
 =?us-ascii?Q?zHcOn3R4Pfmo5RRcU0xsXVPDDTMD7kooGZpJ2pYVQaxFUAExGZdV80a1VQRh?=
 =?us-ascii?Q?DZBxbLeaPsqyZHrd8GktpYDeQxuylu67wR3bexRG/YjzLV4iuN6oV6Rjz+7Z?=
 =?us-ascii?Q?HaLOcknvyM5BjJ9BkJbX2rAEE0mbxX6vTLGxvfVIHG07aL8lD0iaecBS2MB/?=
 =?us-ascii?Q?NnXeaO8xe9ud4ueB5AGrOAmL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f2bed7-7bdc-4e28-8b2e-08d96d712b4b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 17:51:47.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFkR5H0pc68KENW57OmAuxBvVK/Ju0f+hXTS5eRjMA8CygCpb7Z9znHdiTv4GVGYMvB7wWEzQpeKZ++FhMHngrJYbZX0IMf92fb5ODJiO8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010102
X-Proofpoint-GUID: p7dpRHDQA3L0qtWHM6lwwlMLZ1AuFIHq
X-Proofpoint-ORIG-GUID: p7dpRHDQA3L0qtWHM6lwwlMLZ1AuFIHq
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

