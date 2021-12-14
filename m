Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644EC4739C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 01:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244528AbhLNAxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 19:53:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57028 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244517AbhLNAxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:53:48 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLAFXS017988;
        Tue, 14 Dec 2021 00:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=tWlwNnaPepD7uR03pYKq8nSXn+RnqrVUtViv7aTlCtg=;
 b=VwyaEaZHsc6Vtp2oU6/A3JZ7kMEsxXFLOgABJUQsxYigEkt3RN7TdK6qhip2dBFhvYFj
 aX/8uBh9MZByk3UOWk9AUmmhDEmVjYoJgCS0gjksQhBCLPX1sD9XwGl+aDhiWQ0iz2gn
 0/aydX26zY6BrpVFNA3MXYuDER2T969jh0gI1IoODmTTnrhduDA+9olXu8Sq7aC61/5k
 phbeWsXRyyB8i8/h73ETlIkjHIqhyv4G0TjFOa4wueMuslxV7gUXt/+1/xGTMnJfN1qR
 J7/kt4fIoaQhcGjShpto8YIrrKJwBvipopKSJZbc7l7mr6lwN8znhsEVASVtRMRsinFC zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5aka3bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0f2FS133040;
        Tue, 14 Dec 2021 00:53:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 3cvnep17at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU/ppbfFp0aWHn5HuZ3eeX8wLGVSxB2ZslESwWasOa/MbA1LvcWBgmtuTk+P1G/HmM+AgOI/aYwfLmWaQBiPqiO39p/GD976uk+xG0f4cq9WxtxU2q9NUnT4WcMeA2gg1PdTXXuOUcBRmxl/0eN6P5qtcs8jR2ng4G0ZUU1fEuWduMJ7eaIW7NtZM+9l8mFA4+dWCAqkTHIvnEV1PlpWKky9fqWqwIcMR3FtttjUCfgfL/vBOLSdPrjqIlzIXfMciwMch5m8GJlIKmV+2t17TbrW2vdfhxZ8Rz3FouU53N2TJuP8M31txtP0XmeYUksp23SADgQvUfYkM0HUSOSfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWlwNnaPepD7uR03pYKq8nSXn+RnqrVUtViv7aTlCtg=;
 b=T2783BmKUgervi6iGhl8DXx3Fe2lgLyCHgga/eiQCp/mQ/bwjnk8/s+4NAup6YQlZclMnQGb5lxN0rt4ToG/2tke20nrXdOVVCZ7kKzlLp8CRnI/Lk/L11sKEVmwceZ52fUNYH83wNRtVPYtwzUMTdlC2fseVUBnj4pX4nZxWRzZZlJ2G6zqOqwF7+1W19Z7vVoR6HAD2yyukxes+cavoDnG+nAoyG2S9/lfDLqBcqAkiKHL9lJLTI7cOVpSECvyw9aVjI4olahY7RynVKnXvxFhpFHhGdmXTHiIXJxZkD3WUl4YF3pi3VXtsdhvBt1y/JKdm4c1FeXT9dnHUJNeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWlwNnaPepD7uR03pYKq8nSXn+RnqrVUtViv7aTlCtg=;
 b=vIb4eo4iubJEEvmd+GzbQKYp1vREXzUNLJF4vasse/bsSV9CMj3ONzhSC/YpwqVx3gvWELDLTevSxvq9YDnHjgWQ8fA8WRrs4Jx7aoaZmtK3NaBKtoB83pmgmHj+yCc4qiNZLKfduvzsE9bhcznW69XH4wL2pkTsuoOUfhhlvUc=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3893.namprd10.prod.outlook.com (2603:10b6:610:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 00:53:43 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:53:43 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dcache: sweep cached negative dentries to the end of list of siblings
Date:   Mon, 13 Dec 2021 16:53:34 -0800
Message-Id: <20211214005337.161885-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
References: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::10) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b6a089-9444-4594-d75f-08d9be9c2d2d
X-MS-TrafficTypeDiagnostic: CH2PR10MB3893:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB38935F3C5B057A955CDBB8E7DB759@CH2PR10MB3893.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UX1WF1CZ8sGmmRqluxhMu5yKTPr40rn6ly7/CjxXgXmhbF1IFSrtu7hBjecF4w/vMWpwSJ/tKC8fVrA5GL9qdfB0gxiZyrhD8eWWEaMNamMkzhDUQWBta00Hjc4DIXdJY+9Bcdyj2+45yXlw8pqw5E6zK9HSUZ+1zdnACq0+aKW4HDyjnUsPOy/b2MNXmNcgUo87J771o6f4J7C88DX5T2fE01/KP5/o42DSrROkjipYLi6MSpfEIQExpUZNKChzx7wJ1ntNCjzWc1Rlzl46P6dgx60TAZKUr4psJF6gcszwzG3OoYnh+D9pQxTVAViMwdonGIa19RVTNhY9QBm/0Tce5G1CntKuho1OcQ8cpyPyBQzlkPMOyE+jRraVBFao4cUUB8bxpPEMVe5HZEF7OV3Hw6bTw3PCJaVC7hfyjTHl7LuHP1+6lvgqW8b7Xm3aI32BG6j0U4gKPM8yrSpp1VcSJu3tez7ZhyLszUlfy1r7A+yS20jhoWtMq2Vm0s9VtgRREvvklDJgxifHj+c8xg4RUS8VSs2AQrFk0IGGK0kYXVW5Gb4q41RZgssbXQBAsaI6F5CU99JveffsmbA0gTkRDD4N71/wn0RS7/s3CjdWPu6b/kb1+FU29UCdO5yxWdFIz6Cpa16FBgwOfcHSHaHEzb7j32suzxpoe571v6XSqE4yZPjCeTn7hGCKxCjhZKZ8x8LScs2ntCVV1qXQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(36756003)(66556008)(66476007)(26005)(6506007)(6486002)(83380400001)(103116003)(38100700002)(38350700002)(6512007)(66946007)(316002)(4326008)(1076003)(54906003)(8936002)(2906002)(186003)(6666004)(8676002)(52116002)(5660300002)(508600001)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyccbAX/9a7rX12rrd1NV0Tai1CEBlMIhp9CtClI19y/bWmuMxta+tk12i54?=
 =?us-ascii?Q?GbrYLJxwMiX1qIglpxRDfDHJu4kz1kpGA5QgsK6ZU8FF+phQYIdHV55kw6Z7?=
 =?us-ascii?Q?TPcS2u1V1/ON2aV0rkxpYW6WtD214g8BYvAiJ6DISvNCNm+xgy7Wf1FhMvcW?=
 =?us-ascii?Q?PaGOy4+vetlO8HyvxoSnQS+rWtxI1Vp3nx6F4FJLzrDoR6llDZCmZu/dUUvZ?=
 =?us-ascii?Q?9m+Ai1AmfivU+CPk4xBXU2MTUstL0YCKuIz+e/m+h55YLnoBHEImP3iqWeux?=
 =?us-ascii?Q?QP4JZzqQ/r1Aztvd63M75kEvu3W0rUIwWsiD0uWPNOkvNDWsJcCUVsnt+QwN?=
 =?us-ascii?Q?dVMdA/IiVGMpM02dySVuumZ/adbtv8QCADpCTC2c2Sjqr6r4rIUNCu9tUfnb?=
 =?us-ascii?Q?PrAJeJWrrKuOGQ1NccZ0y8nLFf9hhtiYBbY+7qBk5tYd2fNXJreRW/uvQ3Ra?=
 =?us-ascii?Q?EykdtY2aIlL5vfhhPzXuESKcFDaiN+zw9tDaPgAjIZY/+00mq7zm8RuGED2P?=
 =?us-ascii?Q?9eKrRYeJE+VcvgrUsAIIQ45JeDE93MMhHztksWGktnPCkGbW8uz2YEPFOkRH?=
 =?us-ascii?Q?hs4rrw+xsnhEL+1RLZW73mSxdOASGUb3cCxcGpe7cmVc7b//kv3m66RYCxv/?=
 =?us-ascii?Q?+yg3aAqxVZT9EJ5bALnHDmaex28Ll4k5XmWoiL+4TeVEXLT4O5xmTc8IMt5e?=
 =?us-ascii?Q?NuMJWG14wcWwzLHnzQwc/myuQKJO9Xk+5eld683JKwXU48JEibPFxCfvJWEr?=
 =?us-ascii?Q?ZVATjV0IAGCLyvXT9SUC78frCuoZt2QpLWfveRWdU1/YDe+mywdcqQygcRTd?=
 =?us-ascii?Q?3KJ48fDIyhQIgKb7PRGUGvB2HKUZM+wI6Aj2qV1MfuQH5DBi5wKqL4WD3560?=
 =?us-ascii?Q?ejYdH4zsl1mYr82l5LxvZx28XckFpEQpk9xU5fVDuQG3axlNp0u/8jC+Upsy?=
 =?us-ascii?Q?E0g6z5gjxa4T2LeYB8kGbAjM5igsF3qEzoIHVt1oW/t7t34N/8rTZI8a4SWi?=
 =?us-ascii?Q?x8ORu0l9D3aF4/Iq2IiufHJ2GoutPf9Fa3vRmSYo+YSQiS2iPV12fSfnL2tg?=
 =?us-ascii?Q?mutapYUiZL7Zyr3TFf5xtaWaQyVg52dunRoA+/1JbakhASOs+/tlglkzF02d?=
 =?us-ascii?Q?ScsY3a9RwUjKA1oMyEP4WjNKauKUenPPP3Bmug2E2r7L8LuClZyhOB8i0ZRO?=
 =?us-ascii?Q?hXGRDqc9ngJNwHhJ7jYpFbn+EjCeLWXezfxt+eSIkj04hu22E1MkASPvvaMm?=
 =?us-ascii?Q?TOEPsseQVAoVdG1hI1wRHXIJm3lqumc5CpJyetVCrQ7MFkvT7KkKr4hDB/PF?=
 =?us-ascii?Q?GcKfoNkE5XcGmf3bEarAeWldzgvLCudCS5hsTNhAdS7X5ZzCS7KPe6N6AdsS?=
 =?us-ascii?Q?Bq3nLP8L9SS684bK5jiTlCuTk+JaVTJiU3ivIEgsLyaziPa1Dx1vFr0o4tQb?=
 =?us-ascii?Q?li0trVukXjCk1ELoDCZ+Iug05mm07FTJUY40qee07jUYB1OscU56kCtLomzm?=
 =?us-ascii?Q?drmnqJacw50VhgrzKDLg0kHlbi7kOnELRdqIX6bcQxIE/7AXE/t4lhI0d1d4?=
 =?us-ascii?Q?MGqc+O2MoBKUQjGHYllKkNdL7vR8QkdDwkDoBSk9j/yFhZKn5V699sFUbiuO?=
 =?us-ascii?Q?/fmE+vRBcvkyMXWMCBNROdfUpzprly0byNfdv4U2A2wWvIirfrUZU5kvC8S0?=
 =?us-ascii?Q?a1PIuw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b6a089-9444-4594-d75f-08d9be9c2d2d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 00:53:43.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soFor40QsX0F53RfjdAlYQPI0d0H8i2Fc6L7rbUQSPEYn+s6ANVATudc2il7s4Ca2x4VdbgHNYZW/uWpiZmfYcs4WtOjrZdMOJcogKTbwWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3893
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=979 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140001
X-Proofpoint-GUID: WH6hsbOQrgjBpuEKhYI8kZvu_goT7stO
X-Proofpoint-ORIG-GUID: WH6hsbOQrgjBpuEKhYI8kZvu_goT7stO
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For disk filesystems result of every negative lookup is cached, content
of directories is usually cached too. Production of negative dentries
isn't limited with disk speed. It's really easy to generate millions of
them if system has enough memory. Negative dentries are linked into
siblings list along with normal positive dentries. Some operations walks
dcache tree but looks only for positive dentries: most important is
fsnotify/inotify.

This patch sweeps negative dentries to the end of list at final dput()
and marks with flag which tells that all following dentries are negative
too. We do this carefully to avoid corruption in case the dentry is
killed when we try to lock its parent. Reverse operation (recycle) is
required before instantiating tail negative dentry, or calling d_add()
with non-NULL inode.

Co-authored-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Co-authored-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Previously Al was concerned about sweep_negative() calling lock_parent() 
when it held no reference, so there was no guarantee that dentry would 
stay allocated. I've addressed this by adding an RCU critical section 
into sweep_negative(), ensuring that all writes to dentry occurs within 
the outer critical section. Thus, the dentry could not be freed yet. By 
checking d_count once the lock is regained, we can be sure that the 
dentry has not yet been killed.

This is not necessary for recycle_negative(), since it is called by 
d_add and d_instantiate(), both of whose callers should hold a 
reference.

The other major concern for this patch was that not all ways for a 
negative dentry to be converted to positive were caught by 
recycle_negative(). I've moved the call into __d_instantiate(), and 
added a call for __d_add().

 fs/dcache.c            | 85 +++++++++++++++++++++++++++++++++++++++---
 include/linux/dcache.h |  6 +++
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..685b91866e59 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -635,6 +635,58 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 	return __lock_parent(dentry);
 }
 
+/*
+ * Move cached negative dentry to the tail of parent->d_subdirs.
+ * This lets walkers skip them all together at first sight.
+ * Must be called at dput of negative dentry with d_lock held.
+ * Releases d_lock.
+ */
+static void sweep_negative(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	rcu_read_lock();
+	parent = lock_parent(dentry);
+	if (!parent) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/*
+	 * If we did not hold a reference to dentry (as in the case of dput),
+	 * and dentry->d_lock was dropped in lock_parent(), then we could now be
+	 * holding onto a dead dentry. Be careful to check d_count and unlock
+	 * before dropping RCU lock, otherwise we could corrupt freed memory.
+	 */
+	if (!d_count(dentry) && d_is_negative(dentry) &&
+		!d_is_tail_negative(dentry)) {
+		dentry->d_flags |= DCACHE_TAIL_NEGATIVE;
+		list_move_tail(&dentry->d_child, &parent->d_subdirs);
+	}
+
+	spin_unlock(&parent->d_lock);
+	spin_unlock(&dentry->d_lock);
+	rcu_read_unlock();
+}
+
+/*
+ * Undo sweep_negative() and move to the head of parent->d_subdirs.
+ * Must be called before converting negative dentry into positive.
+ * Must hold dentry->d_lock, we may drop and re-grab it via lock_parent().
+ * Must be hold a reference or be otherwise sure the dentry cannot be killed.
+ */
+static void recycle_negative(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	parent = lock_parent(dentry);
+	dentry->d_flags &= ~DCACHE_TAIL_NEGATIVE;
+	if (parent) {
+		list_move(&dentry->d_child, &parent->d_subdirs);
+		spin_unlock(&parent->d_lock);
+	}
+}
+
 static inline bool retain_dentry(struct dentry *dentry)
 {
 	WARN_ON(d_in_lookup(dentry));
@@ -740,7 +792,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 static inline bool fast_dput(struct dentry *dentry)
 {
 	int ret;
-	unsigned int d_flags;
+	unsigned int d_flags, required;
 
 	/*
 	 * If we have a d_op->d_delete() operation, we sould not
@@ -788,6 +840,8 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * a 'delete' op, and it's referenced and already on
 	 * the LRU list.
 	 *
+	 * Cached negative dentry must be swept to the tail.
+	 *
 	 * NOTE! Since we aren't locked, these values are
 	 * not "stable". However, it is sufficient that at
 	 * some point after we dropped the reference the
@@ -805,11 +859,16 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
+
+	required = DCACHE_REFERENCED | DCACHE_LRU_LIST |
+		(d_flags_negative(d_flags) ? DCACHE_TAIL_NEGATIVE : 0);
+
 	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
-			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
+			DCACHE_DISCONNECTED | DCACHE_DONTCACHE |
+			DCACHE_TAIL_NEGATIVE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
-	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
+	if (d_flags == required && !d_unhashed(dentry))
 		return true;
 
 	/*
@@ -881,7 +940,10 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
-			spin_unlock(&dentry->d_lock);
+			if (d_is_negative(dentry) && !d_is_tail_negative(dentry))
+				sweep_negative(dentry); /* drops d_lock */
+			else
+				spin_unlock(&dentry->d_lock);
 			return;
 		}
 
@@ -1973,6 +2035,8 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	WARN_ON(d_in_lookup(dentry));
 
 	spin_lock(&dentry->d_lock);
+	if (d_is_tail_negative(dentry))
+		recycle_negative(dentry);
 	/*
 	 * Decrement negative dentry count if it was in the LRU list.
 	 */
@@ -2697,6 +2761,13 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 	struct inode *dir = NULL;
 	unsigned n;
 	spin_lock(&dentry->d_lock);
+	/*
+	 * Tail negative dentries must become positive before associating an
+	 * inode. recycle_negative() is safe to use because we hold a reference
+	 * to dentry.
+	 */
+	if (inode && d_is_tail_negative(dentry))
+		recycle_negative(dentry);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
@@ -2713,7 +2784,11 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 	__d_rehash(dentry);
 	if (dir)
 		end_dir_add(dir, n);
-	spin_unlock(&dentry->d_lock);
+
+	if (!inode && !d_is_tail_negative(dentry))
+		sweep_negative(dentry); /* drops d_lock */
+	else
+		spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9e23d33bb6f1..b877c9ca212f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -221,6 +221,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_TAIL_NEGATIVE		0x80000000 /* All following siblings are negative */
 
 extern seqlock_t rename_lock;
 
@@ -499,6 +500,11 @@ static inline int simple_positive(const struct dentry *dentry)
 	return d_really_is_positive(dentry) && !d_unhashed(dentry);
 }
 
+static inline bool d_is_tail_negative(const struct dentry *dentry)
+{
+	return unlikely(dentry->d_flags & DCACHE_TAIL_NEGATIVE);
+}
+
 extern void d_set_fallthru(struct dentry *dentry);
 
 static inline bool d_is_fallthru(const struct dentry *dentry)
-- 
2.30.2

