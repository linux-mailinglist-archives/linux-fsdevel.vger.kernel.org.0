Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66B4739D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 01:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhLNAyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 19:54:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65200 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231908AbhLNAxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:53:54 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLBGN5021573;
        Tue, 14 Dec 2021 00:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zIfhDDpSMs7x3BIxMmfYRyCBaLwg1LOuB8LVcVYO8K0=;
 b=uM8XF+ZaWhUZzdtPxmX3jJ454eWaVgZbm7BPr85Y/rolHyiWMAxECi345soupcC9X7kf
 AN4AXpihal9CMuCh5O5C2DvZxJy4iUzDn49kAcj96O/+SYn32m/HmpCGh/wZMiG04lf2
 40XVX+d76ehQEdaNPvqOJuDH15goRPRvxEjLCoHNlYhaguNezDY0QCbv6HScqrCUkwxI
 VtownbrD24m5TqJzQTR1RUdmM0WVeztoD8GV2oFd6IU8d+GSigYNEFgzmuDThiSSeyOh
 dflgkuE60jGFRY1D0gtTEfJczCWizmVlYMrSuoYt0egVsNq9Dh9XbGRGzgEnyDtfy96Y aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3ukab9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0fWGB190002;
        Tue, 14 Dec 2021 00:53:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3cvh3weegj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvrfddpDrB+cPhHZocwQ4oP1rKsdRge3TrUVUJlU1jqcp2KaoqI+vV7D0GvnOgjRKhL3jlk2QLE3F4QfG11uqY840soipRgpfxVBTqVlzs86gjc1WqaZskJoYJ5RkD3IGXT0NO3Cxz5r3a8vOFFbbJZ60Aooi14OpXStNvAEQyLoTXoOWKbk9nq1tUAb8RD+qAnacTBEQFZrXD7vRDmmzDb6fI341lrORevMRIbB7ZgTzIMLJE0pz1QaCdMKbDgHNH+wwkUCe/181wCpUwmulJez/tbxfmQ0fURgnx7VfcmB61SEkRU04pFtW7WfKciKjROPWJ3Y8AUp04vQqhoOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIfhDDpSMs7x3BIxMmfYRyCBaLwg1LOuB8LVcVYO8K0=;
 b=UzPXp3ftxP+hFpbxF9fR7W9oPWMsdC4J2KUFJ85+iNzX6uh+7z4CIb+BWGjPL/phMLLIssLTaH9KbzGw3wYbzM/xZzJ148wkY0wM7Zx7w7Awh2Tf5c0utMPa278SP5gBNipuQOoKFr6J6L+I1c9cjdcH6hKA4Wfr8t6N5S+mYffFiRjB7ae3niNMOGO1TAciUoaST5PUTSttvAFS7DiTheT5L/Sp36RX6OzIa8Pasm/ltPz/3u9sF4ar+mH/4ffUQN9NJ8yMLXSqL7OFdlkBC9Jd0pJUTNuEcna9Rb0xmTMYAMsuwpROwtKrAXb8ipd+ZIX/whnzVu20fvcI77u1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIfhDDpSMs7x3BIxMmfYRyCBaLwg1LOuB8LVcVYO8K0=;
 b=ogk7CdvY9UHpXNxoGk7IfD6W1FOsU9qnhV+Kqm2WMh0oBwRttbtyO45ZUZy+tRF1BpDIkA3js+LSqVXc5qco5pQuz2+WCZyJl3NXkIaUpb6930KqWhkaxSBlPUcPAJXsuh6zqqsnEYghvnZCVhJWv4OYPIaHP7+mnSzO6b1S2Bw=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3893.namprd10.prod.outlook.com (2603:10b6:610:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 00:53:50 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:53:50 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dcache: stop walking siblings if remaining dentries all negative
Date:   Mon, 13 Dec 2021 16:53:37 -0800
Message-Id: <20211214005337.161885-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
References: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:806:27::30) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e9ae71-8d34-41d2-6b42-08d9be9c3168
X-MS-TrafficTypeDiagnostic: CH2PR10MB3893:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3893C1DEF30908EDD0C6E209DB759@CH2PR10MB3893.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6Hoha26YZJ8dij8UUsTWxwKOS8mjT/wKsc7/v4aFyP7rK+57fCGAHq0uBQv1/1sQjD2Yddv96x8jw+XcaEVJbsAG/6JlFaPzEzzDLII0+PhFPPPdau1LYewig+MAf5JLxkurJPdRC13QQFb43kKaPNqbrZ6rvgZgLX40X4+VZ733tBWTFpde05yDyk3Gv90Q7yMhuMzQ2Bd1ZJ3PrqBSHVz641pYHX46d9lvdKVQ8Bn1cKHlvNRUnLsNUx2AeU/g/+aVi6UD6KbydI8JcUytDd62oUEnzLJG1yLF2ZJaL6T5sAz5HA+5RmjG4OnJDebXaPInjdXnen8DKos8JHhmFAuBSsENX/pvc4LJEM0UYvZBRqQiFv0BZRRtiYlZCmj13Xqb2wIF83XCQFsA9y+ZhdBuF12/16ADOw1V1vqDwynxoZRv1HQ3brPNgzHuCE5qQ1IPsG4QwcZrMDLzKsz1L1IqqCGiv8oeFQ8VgNZzt2kYUvtb70I+VnSTq+KrP+KfzD4P5gg5loJBkdv1czA/cuhCjDnJZquynq8AccX+30p4nTSqxdHcNAVukRQVMGoAMTpH3gdTMDpXtx2CISM6CB4o3W87EQcXJNQ/Vbqpmq+xrNmgzv8PcqxJ/dvHTgRdfy+/rONRpTpPcDj5D7er95XaTVXrmWe/2QEhQjSvPLboLGQfszJ2r/L7Nuli6yxgU6yto7sapI2o6XqV5GNgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(36756003)(66556008)(66476007)(26005)(6506007)(6486002)(83380400001)(103116003)(38100700002)(38350700002)(6512007)(66946007)(316002)(4326008)(1076003)(54906003)(8936002)(2906002)(186003)(6666004)(8676002)(52116002)(5660300002)(508600001)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mYCbIzaviqapGepHfSPzTIn1RE/px0dPclaeckwDMHoPJXRQWprAnxT154n9?=
 =?us-ascii?Q?bOLHJfqf7cQQ2LltY0J57CIMngwJYGK70KRuquxgoFkMJij/MWAHApoCylHd?=
 =?us-ascii?Q?VK7ZwcsJYZT17nz2BrDAWJKS+qxw4GBSSDnQYRsCs3pejPEZj6/hDTYB8psj?=
 =?us-ascii?Q?fWTzpTIFbC4LKG7/476bwj5wRBVVfcsoV+M0iq77LMuzT4Ib4b7kgyxAoJFR?=
 =?us-ascii?Q?wOJXq7eFbVEMbRivwpAiPpdJzrB6/6i5H3ZBAmwU3wuTK+7k3mednwc9U5P4?=
 =?us-ascii?Q?+iXZ6V7FjXoYMslG/hTXPbvMqYCbWnxGWBxzUylI3y5ZrOrUwYkoomvhzXLb?=
 =?us-ascii?Q?Bb8EfwfjTiZamFNPzO0aUgrlnofQA/J/UuANZsdQ8heXhYa1azjJxKBUtBSJ?=
 =?us-ascii?Q?gVqHkfRtprGDEmo41uJlow7329qGQh+Vmb3rGVehY7S2nhPr1VqGkHBh4n0b?=
 =?us-ascii?Q?ljS3gdwh53pa53aZhc74Xj0rSMoMNEztUyOSTVRqfTd50Uvg8o8nADrmI+oi?=
 =?us-ascii?Q?SyXl1LeCgFylsT0pDZK4CLHS6W1ekgs56krCHRrIQlRhNVYK70uOt/ihWbvg?=
 =?us-ascii?Q?NME+r6jh2b773sVxRdGMbNnVlyvA3gWQLvy7seF34rMaUf67LDed0TJU/h0h?=
 =?us-ascii?Q?Ux+Ot+7Gq92biKPXSlZwVs6O9tT3ZDVunuIvA+XXcbVbXJ1kFYP32P1ZQZ85?=
 =?us-ascii?Q?Ii4SoLJdIC+q7tTyh/gAGP5f6+q5jrmpKuV3LIXdO4+OijkedjoGMDFCIFY+?=
 =?us-ascii?Q?9yxchQOhbWCUn9d65dA1tGLwp+jKbTQIqyABh6IY2KTcsuOm7+/rFEZwYiin?=
 =?us-ascii?Q?A/1E/b/7vu7WjkUx944+/D73ukppal8YLN4mkcGNuCUzJH+5UL2fIPnbzwBn?=
 =?us-ascii?Q?K3TT44zP/aPYR/vv/Ki6346O6LGy7gZpxxCNlJ2tFZyLhg8Z4zq6i7So/m05?=
 =?us-ascii?Q?ZL5LzLQ6tkHreJ9nJUKJLLhnktfzDWEJGkIDCuaM4F1V9ZadK7qxJxv42VXS?=
 =?us-ascii?Q?Q4AX/QehXCwO/eZbA+pS0iAZP7d2Lyw71AvJD7BcAvtrBpzDo2g2UH0j1DQJ?=
 =?us-ascii?Q?k6r33yQ0nMGZQrTbj+NqOHRWV8ZLdOUIJZh7znZhS6qBAlJk0OLMpSTIMT8s?=
 =?us-ascii?Q?g1t3GBqlGa79o2ut4zwg5LotvvDxQBpXrOxpAKqF5liAa4C9YdMiK7BSaJh4?=
 =?us-ascii?Q?ETrZWPnYXANKdEgiPQKxvxylqlQH1crmBeijAMzABYlxrJX++6LnVdL0XzqO?=
 =?us-ascii?Q?2DHZ01MQ2MtLEHpF9ASX6GiGbcRGz1423d7FiL2ebubYwVYy8MponfrgDK+a?=
 =?us-ascii?Q?3uekpf5ZeBdKdg4zdjJ//lNQtULy09+nrjDH106U1ACM6FNBzJgEzO3mD++V?=
 =?us-ascii?Q?o8CW1GynRsMBoXGdKHxdtwSyJxvk7qNHdorTFSFnQwLcQYEXga3hQYvzBFS9?=
 =?us-ascii?Q?EM3ux2iGM6+ZCzTtJew0Xm60NjfGPa15TMcQFYveOODfElMDKamUm8CYidEm?=
 =?us-ascii?Q?TgOf9VyWTJJTDLqurwHx3/lqdavY9I8O3nNh5REZn3tw77lIjSVB2k2z+1Xr?=
 =?us-ascii?Q?8cmaMNYc9uMd56O9KHIJrsE1zc5n6x6pXBVcDAekZWu12oXG9xmFGXgtt3Jz?=
 =?us-ascii?Q?T1ULepUbzMTJ0oNJvek1/NGZKU3L8M8VcxhQhzEg4XLECv9uHqh0skT3r+oO?=
 =?us-ascii?Q?NxB6ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e9ae71-8d34-41d2-6b42-08d9be9c3168
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 00:53:50.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE6imNkkmwvrgKKAIkL6J8FAxB56J91xwIV9qlfkviRFalRfz1elE1m2SuODWHhGhV1NxGdXBdfyQ63f5yLj+PgJsBew5oDz65F3cRe09WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3893
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140001
X-Proofpoint-GUID: tqjzWpEJ83S9ccxRnTzL-IPdmgLOswWe
X-Proofpoint-ORIG-GUID: tqjzWpEJ83S9ccxRnTzL-IPdmgLOswWe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Most walkers are interested only in positive dentries.

Changes in simple_* libfs helpers are mostly cosmetic: it shouldn't cache
negative dentries unless uses d_delete other than always_delete_dentry().

Co-authored-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Co-authored-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/dcache.c | 9 +++++++++
 fs/libfs.c  | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9083436f5dcb..85f33563936b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1505,6 +1505,8 @@ static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
 	struct check_mount *info = data;
 	struct path path = { .mnt = info->mnt, .dentry = dentry };
 
+	if (d_is_tail_negative(dentry))
+		return D_WALK_SKIP_SIBLINGS;
 	if (likely(!d_mountpoint(dentry)))
 		return D_WALK_CONTINUE;
 	if (__path_is_mountpoint(&path)) {
@@ -1751,6 +1753,10 @@ void shrink_dcache_for_umount(struct super_block *sb)
 static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
 	struct dentry **victim = _data;
+
+	if (d_is_tail_negative(dentry))
+		return D_WALK_SKIP_SIBLINGS;
+
 	if (d_mountpoint(dentry)) {
 		__dget_dlock(dentry);
 		*victim = dentry;
@@ -3231,6 +3237,9 @@ static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
 {
 	struct dentry *root = data;
 	if (dentry != root) {
+		if (d_is_tail_negative(dentry))
+			return D_WALK_SKIP_SIBLINGS;
+
 		if (d_unhashed(dentry) || !dentry->d_inode)
 			return D_WALK_SKIP;
 
diff --git a/fs/libfs.c b/fs/libfs.c
index ba7438ab9371..13cb44cf158e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -411,6 +411,9 @@ int simple_empty(struct dentry *dentry)
 
 	spin_lock(&dentry->d_lock);
 	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
+		if (d_is_tail_negative(child))
+			break;
+
 		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
-- 
2.30.2

