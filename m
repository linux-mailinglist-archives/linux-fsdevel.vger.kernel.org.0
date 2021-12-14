Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2195E4739C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 01:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhLNAxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 19:53:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53422 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231908AbhLNAxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:53:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDL46tr021596;
        Tue, 14 Dec 2021 00:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hTC1WVhwXwmoUC2HH8zcaExQLghAPMbgDvXAVqJo+jo=;
 b=0tLYKi2SGhIeCJS4GHOrXnauOsUrBy+YPQr5IRC9fBkNv+Yhm8e2MLS3C/zphL+C58cn
 q+bDyCIMoop1zG86VMYdZaJnsy6cs2P8XVbOH9hSckxi/znjR1kynffAEWf2v3Z5+ECB
 dtvvhE/VlGaP6Ixuehw4HoqWfUigVArcmPaq00wajRkP6XUfzbOVNSKbLLmLulkz3M+H
 zBrjVz9AddEMUaaIIi9BO6LjebgXM2gYXVPloyI/vuwP2OkuE8DG/T9e3k9ASBb56szI
 O3GOKjI/8J+4E0aHPbiU/AbMTWv1sfuocxfGb3t3ww62k3MyZji1IpYLq0PrLhH3UPVC ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3ukab9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0fZF5190267;
        Tue, 14 Dec 2021 00:53:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3cvh3weedd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJE/8Zs6r5Y07LSJFnFJJmO5fLeDZ7sq3q1dVV/J7+e6USvtb84+H7ioLnECZKvgyCyU+LGAA8seHkx+i+v9rxwtOn4AGtwTKqVVRJ8iuJET/b3PMwWNOuFtOaiPYcqgav6ailPuLH+TeIc5H/zre8qFPHoeFknCnNYq6xz77qTqYla6kWnjP7Hd6Z9GNbxipP9472xu9Twjsd6saMyNH8DZBPBj+e7GiRHUKqUKgKRdnPgyctcVLTNr0Tu+6nb30cdqHZc3FDCOKW3yRc24WULySqGb8utFRbjOknkP3orG5OrCpJWOQpTm4bHQNNpLraCCTeU3E1qts/NgTOGQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTC1WVhwXwmoUC2HH8zcaExQLghAPMbgDvXAVqJo+jo=;
 b=Qw9CFnDAj+N6qiQCbxA+PxghGHMkMOalZ4c2oa0sRfQ8JCJJ8pWhoNfHk7AUSznu5Kf7QPKaQs6rvn/vBhZz9/Njuo7LI2+VfPxB5SAonfFkwUUaZT/OQpidZApfUWuni5AqJL4JgPIPVV6lYXUhLPH0ZRp41DqehW1zXq+suR2+PBBh/LYoZQnJAtNCPhq6JzvqKupogf9p3g9cFF8jZGValeBsCFp7zgPBJEhSya38PZBwZ6RSIgRzRJmHklTnW/ga+449UAoVWIGFX4uaMlHMYDVpCGL+ALEBIbu9iWRwJqa2bBNNXCSrQcKGwqxXkRHqcIIocV/NcaGIa1e3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTC1WVhwXwmoUC2HH8zcaExQLghAPMbgDvXAVqJo+jo=;
 b=I09IhtgSVqK3ot1POoHTQziihP6axVT5Vf5NvL6as/J1KStdi1S7l8SkDUWwdzWsYddGBdendVfPUOBLh+ce6oDrss+GsfMrjeiKSy54bQVtcB+Tv1WxjGOEqI32+Kjp/DMsloOhlNOJUGpvCyZpS1LTaDJrCrhZd+M/HAdH3qE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3893.namprd10.prod.outlook.com (2603:10b6:610:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 00:53:40 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:53:40 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] Fix softlockup when adding inotify watch
Date:   Mon, 13 Dec 2021 16:53:33 -0800
Message-Id: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2a732df-34ad-4308-9a6a-08d9be9c2b76
X-MS-TrafficTypeDiagnostic: CH2PR10MB3893:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3893347B9F01ED85266BA509DB759@CH2PR10MB3893.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8OMEnFbUKpDCKKBRuLYA+vh/kE1jcCtFBHnaQlLFMx/E20qJ5c8uj8BeHFKIhI4YATe5m9AVQ/Je3WMjn30AZWoLAUuYw90pG6H5dWGHvm/Ck9DdXWpDiMZal6n5cF23torpg2tlox97XiqnAtfBqjnzUWqFy1I4ejG0y3vFiBoRfzBhjBeAKRONnoc8Cdz4iiH1rD/TTkmC0AM7OGdjW0Sl/aUzGKa0xwXBJ0iIe8CRWUHWrnwJVRMQ2YKaDjcb397qnUBnnRUYR3t4B9JUV+TKCT1ERUT9nDJmP0LWA9LvPm+QzQ+KbBXwKOmILW0jbc5Y2YWtABvqaIUQZKnUsvmeVWKHgleyRukOBJKhE0JhZlE6Xn1TnDED8BQIWswf1lNPQHS0J5GVRq5SXSaQ3iLhFqr4O/agLjvyTb6pswL/Zk0x4mV/HjWESjQurk/oIZPYfHGFLdb11LOjPyZ20caQHphsPwFwaL0OtUOocsDBEndVc/rW70myiEK7Xmw89igQqYlk95MQywfffeWBJ9zdrOy9W4YAk03RHUwaKzEg0N1TRH3qtWK1F+IEkH6syFYijVP1Mz5Y+8kjMlrWbdwkMbM/75VpnX6sCMRf9ra0xr6mTpaI7Sdql5PeD3tmyNdVMGbuMCFNCjevkFqYi02ObgcArwTlDPea5rG9d45MfwTwy1hYpo3JozdnkcdB3wuhbIF/NTDBoAkdaBnFhBltehs19p4iRs0kqZeNehmpDDbQww2nxQ97xW1GKSxgIfhUdIv8llvyGYzrf/EzrlbYlT/Vmsclkh8f/vWhZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(36756003)(66556008)(66476007)(26005)(6506007)(6486002)(83380400001)(103116003)(38100700002)(38350700002)(6512007)(66946007)(316002)(4326008)(966005)(1076003)(54906003)(8936002)(2906002)(186003)(6666004)(8676002)(52116002)(5660300002)(508600001)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xl98IE/n9RF39homeP8Itfrl5YZdM4SpqW2YhlWNqiNOnmrooUyyzZdfukmg?=
 =?us-ascii?Q?3mA2jFC3f42oco+naZG9kF/oUqWfdD7X1oTczKvfizpJZ3YmvpORYx02Re8h?=
 =?us-ascii?Q?ofrLCZoiE+WO7AKMIaG7dkvVejlZMzYL42OJbQLdyPyp9rJqy74g9gxMkzg8?=
 =?us-ascii?Q?OoRPfREje30XSzJGzGcNpV7Zbv+5nnngN0flSpwF2kt3OEwvkftYlU572OJj?=
 =?us-ascii?Q?3tJV/GF5Y86fLpGIBjMAZTORD9SeSSylQpcId1PbyCsu6M4n2egy2ELINqVa?=
 =?us-ascii?Q?qKAHaxF04Dj3VIEUuWNSDJlhrAgIODrt1a/0J4ev1exdrJTGdJjdJm3RryLs?=
 =?us-ascii?Q?3lka7n5Q6NjvaLSKvrrlH8VnkbwclkdvnwB0McX0Uz8ycOUMEp/8rHHDlXHf?=
 =?us-ascii?Q?2VCIxVNfJGKIx2qubdwVthaT5IWbz8kyN0o7bJoqsqG6eOPt5SvjIzH3rALX?=
 =?us-ascii?Q?EYxUrd0sLX920j+Y4FFsDeGtel2apP26jc1QtWcGqNx4ps56LW5J9UhveztX?=
 =?us-ascii?Q?1CPs3y18PM8cQa5pIHrQGy3LMCryZMzfTayuzPq2AX34oMSLSBLZXmZRnb3K?=
 =?us-ascii?Q?NR2okbJyaAdeqZsPD/cfycSZhYuilONQNEn/xcNw62ybCsMwwDReL6rjVKgQ?=
 =?us-ascii?Q?OWal/GcL1eq6n7YOHtuO8kvdNA8diCTksDKDR7R+tkuwSq4072KfiwTHjTki?=
 =?us-ascii?Q?lBs5VPov9y9r6Or9ShCaOvUJMAGsNL60VWK2KGl9xToFHWI9CpAayOFnAq9Z?=
 =?us-ascii?Q?lyULvYU1YL4ExLKQm3YMR43ZK25ukDCBmrH+kCgNoU/XpIpA8ZKWPDGaW+2H?=
 =?us-ascii?Q?gdpKLTZLAER69cJmtldxgc5LinQ3vhFVW9ggbuwrYjKBfcIokiMo5rslKiWz?=
 =?us-ascii?Q?XHo8IoVrVNcenX+Q0/tYNlQ+QItnn4d8nEHUtnJsKWwKoJEeXNQvO/ImE4R2?=
 =?us-ascii?Q?KNW4rjxPJZLHbn0732ty/rxHXTQQpJz4uXvYIXNyMvb4SjrximMcwWXGJEaY?=
 =?us-ascii?Q?tserch4TDWj0V77RR6rsvubIGohocwRf//8/dF6oWRnFxVdeBXH/TPU8fqEE?=
 =?us-ascii?Q?BFxGrnTo39j5Qe4g/1i2gOfirtdCsbfpWgv49Tm8tCxFKmCKuoBbYB057u1u?=
 =?us-ascii?Q?36mVysv2l4rP5VkmOUVSsNgEywNnhB/qkrNzijtUkrbH6cOh4Y9WW/YBnloA?=
 =?us-ascii?Q?yqzZuadhvx+jD1u8p0atzlTzKFpxO030kkmOVV4CM7NNI0CNq/9i1kskOQzK?=
 =?us-ascii?Q?pE0kNrQZz8gGb4wbnI8s3/1OtRwWROyDdkS8M5oXFBQ3o8m24svj1UoYZaul?=
 =?us-ascii?Q?B+VhvnAuIz3ladr7yRXEuz8OT1e8JX0CfYgIcM0V799z0m+lMicu6TfJam2U?=
 =?us-ascii?Q?otf1nAoWoWLBQy2/9ZQjE91lDhEYO+DyWLSl/RMs5I4ScysIEkoLfmo/i2r3?=
 =?us-ascii?Q?WlaSZspm+N6VU+y54Ek6G6IUoiKb1QiTjmCYFADit//+9sErZ2SYqTdMM2d9?=
 =?us-ascii?Q?+Q6uBxtw2ODspxUmlcZ0ilgcsdToVbHW8eUoOsjIZvEptCpE7KFu6EqaeSNx?=
 =?us-ascii?Q?ZFzdX31eylu/ann5xozwZ8Z8UziEj/8KLYDh8QBlkpyXwgdwsJtMITBPqoUd?=
 =?us-ascii?Q?CQDvHOp+TPWFGxbRFvczf+IMAofI9UAonKo69YHcPDddSwpp4Uw6yyqGW8zF?=
 =?us-ascii?Q?vP0RTQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a732df-34ad-4308-9a6a-08d9be9c2b76
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 00:53:40.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+UC+kkCErOXnaoLQz6CLmX3YlIGxAY8G/YQVOxd1cj7yl/5AM8sX3m16ZEJyoC2lxlrTI1rfazSjUYu0r40cp4eLINDSheKKhji9f3ieXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3893
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140001
X-Proofpoint-GUID: pFoibDuK9EO4Q4l1GfATl_dbFhjaDQRk
X-Proofpoint-ORIG-GUID: pFoibDuK9EO4Q4l1GfATl_dbFhjaDQRk
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a system with large amounts of memory has several millions of 
negative dentries in a single directory, a softlockup can occur while 
adding an inotify watch:

 watchdog: BUG: soft lockup - CPU#20 stuck for 9s! [inotifywait:9528]
 CPU: 20 PID: 9528 Comm: inotifywait Kdump: loaded Not tainted 5.16.0-rc4.20211208.el8uek.rc1.x86_64 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.4.1 12/03/2020
 RIP: 0010:__fsnotify_update_child_dentry_flags+0xad/0x120
 Call Trace:
  <TASK>
  fsnotify_add_mark_locked+0x113/0x160
  inotify_new_watch+0x130/0x190
  inotify_update_watch+0x11a/0x140
  __x64_sys_inotify_add_watch+0xef/0x140
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

This patch series is a modified version of the following:
https://lore.kernel.org/linux-fsdevel/1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com/

The strategy employed by this series is to move negative dentries to the 
end of the d_subdirs list, and mark them with a flag as "tail negative".  
Then, readers of the d_subdirs list, which are only interested in 
positive dentries, can stop reading once they reach the first tail 
negative dentry. By applying this patch, I'm able to avoid the above 
softlockup caused by 200 million negative dentries on my test system.  
Inotify watches are set up nearly instantly.

Previously, Al expressed concern for:

1. Possible memory corruption due to use of lock_parent() in 
sweep_negative(), see patch 01 for fix.
2. The previous patch didn't catch all ways a negative dentry could 
become positive (d_add, d_instantiate_new), see patch 01.
3. The previous series contained a new negative dentry limit, which 
capped the negative dentry count at around 3 per hash bucket. I've 
dropped this patch from the series.

Patches 2-4 are unmodified from the previous posting.

Konstantin Khlebnikov (3):
  fsnotify: stop walking child dentries if remaining tail is negative
  dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
  dcache: stop walking siblings if remaining dentries all negative

Stephen Brennan (1):
  dcache: sweep cached negative dentries to the end of list of siblings

 fs/dcache.c            | 101 +++++++++++++++++++++++++++++++++++++++--
 fs/libfs.c             |   3 ++
 fs/notify/fsnotify.c   |   6 ++-
 include/linux/dcache.h |   6 +++
 4 files changed, 110 insertions(+), 6 deletions(-)

-- 
2.30.2

