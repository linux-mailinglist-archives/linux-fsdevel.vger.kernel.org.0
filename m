Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC64739CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 01:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbhLNAxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 19:53:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61376 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244537AbhLNAxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:53:51 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLEcaK022072;
        Tue, 14 Dec 2021 00:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dwvIyrhIsntRrKYmTr6Qm6a0l+8t8q8Ghg1xyJtv19k=;
 b=b9ZzREdYj0je6W4NRFLIGoP36QGnBETSh7WOQ7suaAmlIRez5w5SSIumA5Yq+/k4gHWU
 MkSbkrDjVMm0eLpSjSqL9gxAQj9BYj3lw3VqzYjEfsO2L/g5ooPCFO4PArMG/uzJL7t9
 Ls6HShdOFi8/nvzVZ8ymmbsbCXP/KP7fEQSp2EJbgBzSOHPUoePp6+jRchAihGYSxOnC
 QL7cJ/ZWmRSY4bQpJZkco9HFDdxvlBOfoJ3+9xP4p43BLNTnsZMMim1LDoDmL10osJEv
 qViWttJS0xI+yMZS/Q3XAmCSy/76MUAANaCyx1svVicepJD3GNfFifQBE2C6Tusc82fa uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfaf9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0f2SX133129;
        Tue, 14 Dec 2021 00:53:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3cvnep17bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkWfu+rLSINvARyKg2BraOJHpw7IYZFkc0dx5PQZpcvKkd859CjSVXMrUNc998Cbmv4QLoxAP6jPOGjKGnnU3SB08w1RoWwvJhPMRZkw0OPsnCdBB6UOVQr17q5sWdSh2Ha7+SmOGtpvmxIOiEio47ppiDa91RyLupexw3lK+8xx1sxvSI2EdBf7/iOYKCntCDOXXdo0gDxtRT1AKoHRU+70M6ORI693dlm3M1KfnzS/LLuvKIlA2wxE5OI8VzJgx6Q8c7/pT4ze1G6IZ3aMaSnCH/bCmrDvrG2jdmvNT9L1IWy0bSACIavMmWOiC7AY6KoSdu1ru97V+vFZJlzlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwvIyrhIsntRrKYmTr6Qm6a0l+8t8q8Ghg1xyJtv19k=;
 b=igJcwz1XhxDli+JBkrBfHGTu6v5YRM+MATEUaZA0gr3QfzC4QOuUCfINg+9tT64sJY1aYdYUwENFTpT8u2a0a+7rTZ94jVgdCnp52jOpnEwzZWwEAVvUqVCRJDsC1FnypXjMh3OuDjCqiY3zkwHSI2j94tA4F5u+KxsUhvyR+HRrLS7qwqTE9GDNv994lHLUh49w4DvKB640H49wtRZPivape05rddQNyTcRA7KksJr0Yon5Z/97M4b7YdW013GW/K/DbFBKGdZ8NUBBz26huvqiH5dsVUpix62fxVu3cay17tfBHBGzJaMI/5YLnh1s+P29M7hCm4VisKa8nzHpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwvIyrhIsntRrKYmTr6Qm6a0l+8t8q8Ghg1xyJtv19k=;
 b=PVtqMLHZoDFETdeVY/rboubIAVjxaIS5SgqOPvvaExZw+IElef/WbpWuUTQ1/HM/PezZYa3bpNkkfVbQ7IOD8GVdgabInC5D0DE1shmxvYU2PXa8JjH/CGmIHj87tUq7GJqQt0E6pn46O5uJ6K2wKROhP4jkaVpFNl5KB6S6W8M=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3893.namprd10.prod.outlook.com (2603:10b6:610:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 00:53:45 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:53:45 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] fsnotify: stop walking child dentries if remaining tail is negative
Date:   Mon, 13 Dec 2021 16:53:35 -0800
Message-Id: <20211214005337.161885-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
References: <20211214005337.161885-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:806:27::24) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45239b2b-1602-4196-bba0-08d9be9c2e9a
X-MS-TrafficTypeDiagnostic: CH2PR10MB3893:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB389384C4008FFFADAA3D0CFBDB759@CH2PR10MB3893.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rK8ht0i5uAvABR96Vi7kmq+Z3xdBwowkYKSkygCIczrsb+xkytPzPagGV4xQYkJIZhxAN5mEKZaXsqtJoG9aOS8ewtAI9XN3//Gs9vvF5H1SiwhfYbkr549gQoWDXCLTb4mkwSuOFTG3zwxcM8DRG8Xp1cG6J5+rmoaiIuXSD1Yvnm1rR8CS52z9/7ymwKxypTUqI3HSQ/cor8nRJ/qROJTUIC8MKsuTMu3Wm4UPtu+VnKHW0rVJOFuABWlnzN2P/EYJ2mCpqgvPz2e905u49dHHnkSXvggH3P1Aqez5Q44FRuLJA1LkzykF08u2htHbHBkZBElmlYYJ/TBEcMkvzJ1SCY8zE+POa12s/6zS042PK8AT3bgWi1i4qXworYl0xbt+/BWWy7uBREl7dtzskQOW1lbzTBrPDfZ13nJkpOIdPi0XquXFFZ7hB1rT5xIeiZCNM+7d4eyHcYGDTZlbslJl+ruxDtTFSgEdNalnrLBt1RARzt7UxWJRt6LWtpzwZeTG3Jl+WvHLmZw8ToEPPIpIkNGWVpRPkjKDUcpKLp8Yz9pUiDvEEy+iOhtb/05Gl7YTmVQRBT4FAfX9iqb7oiPznvCjOV2M7L5T5ZqV6t/LvN0JtaYQmgPyyXFoLnzYu57tjjgJ9PnEqKqxfpdxYpISqylS0cJWAY/np7QIGW5UbdZvkdW1S+jpbRJaBr8qAkKw8w60fodiqDC+aSFR7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(36756003)(66556008)(66476007)(26005)(6506007)(6486002)(83380400001)(103116003)(38100700002)(38350700002)(6512007)(66946007)(316002)(4326008)(110136005)(1076003)(54906003)(8936002)(2906002)(186003)(6666004)(8676002)(52116002)(5660300002)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DjNs2joLNUXo12mpCAUyqyXJmN/wL6gxMdYuPn9+l4qu8HPuANRLz0TCbtTe?=
 =?us-ascii?Q?jDbsI83DBnubsQ0o9EY9TQGYHbd2ZchLWucLSMcmUvLJajG8vuR9KowAuFuA?=
 =?us-ascii?Q?j9uWQI6kPPLSGbqxcPcCdbWw0R80Ly/i95qMJCoufcLcrpVEh0/wDv2mQ9go?=
 =?us-ascii?Q?9Jnp9bvUVzeRLPd5LZIgVS2u9GMvRMnEbe7woeAn3eO6hD7CBUEfo7LVXFWX?=
 =?us-ascii?Q?KR7YuqJo/+24HkAz10fp0W85WKOwbyk2dVK3MHsdW6vadBuiXKDh7uwfeHPh?=
 =?us-ascii?Q?hlH3BI+lJMPQ4u9kZ0jd9hEu1cL5hpDeOHKO1SPDVnXihAjruz3wNRgh00RG?=
 =?us-ascii?Q?5ZEAZz4OzI9irk9L0kGVsjC7QiezqZ0ErLO152ULMEZ4KoZEfqT0kEVzDE6E?=
 =?us-ascii?Q?qVCiYZsI9B0LusQGMpBHnAOlHNfFegmv9N4LRT6C0lPeFTZxodIv27sH/Oq3?=
 =?us-ascii?Q?jbTOBL3gTKwk5tmR+aWdqXuwOYFtwGvdiMHH23c+f10UYYKk0DqocxlXQM04?=
 =?us-ascii?Q?1sZntKEEjJbqbSy0bkpu2Ej10vQ0LYcc66GeN5NqqVUIKmdKRFEU3vy6/8og?=
 =?us-ascii?Q?QDwoR0wqQZL0LkRPlecntvBZqc7yhUbfl6/VB8Ecb8FPR9PgqMh2z5wLmDzC?=
 =?us-ascii?Q?N1oEjb/Ol7Ge9H+WXIRdFpjZtTHN1+ahjygci9QTG7MwPYZ+1/b8XJMmBWcT?=
 =?us-ascii?Q?Q9WZ55w5BW0ZYO+Z4jKaqMSDAW90TwRuqCIqc2XYVHCNrxgdp4A5hp8xxQ8+?=
 =?us-ascii?Q?c73Eur1sntHZfDImOkHAe3DvdE2cIy/7NW03ef6vMbteMB8zhk9HcerhPcw+?=
 =?us-ascii?Q?8Er2pzkhoop/XIRtuwLjJojKDNl9uh32bMkDNryPD9aFaj9xV1bW6s6i2mdq?=
 =?us-ascii?Q?P8pRXyq7wJYaqt07xsZi8Qg1jcq/gWyR6kG4z3NcdoPJlmnXAotoKtzWo6Jg?=
 =?us-ascii?Q?u6ektfH82yTYGNrUlTDigNDWe8gPm0Sx7DUXh3c13BdUqfsGuQ3lNdnHlnC4?=
 =?us-ascii?Q?xQHpZOSWW8vduArI3NrHSU3zQLXZMOYYUHqHQf3uHMsaB+k7Fg8QbKKvhjW2?=
 =?us-ascii?Q?aLAqr8GLzzHSDqXxUOnVyayZuh2T/aBMn5he9koQRG4PXPej9JGx/duVWYNw?=
 =?us-ascii?Q?nTINwVy6JLWABkfMYnBIWWgt34QdpruVykiTMHZM1JjnhjQpHGwp/5wAtvqk?=
 =?us-ascii?Q?KQ1RsZGWBswREQC6KxTstPKbr5cURu6r+O/2XifjG446PCwsLTNv1wRR/feV?=
 =?us-ascii?Q?ovPVpVDpqMEc6O9+7Q4YTJYL1IUTUwJtq/9ux4AqBNJ66mnyyf+TW3KzgmAJ?=
 =?us-ascii?Q?juOFUjSo1irLdr1vZ57HVy/itWfes62AXnFokxx6havWfFWtQRT9TEOmA2Qw?=
 =?us-ascii?Q?2fPoPTToQ2St1syovWvAtmj4F0Ts7h/hBTQFg5su5L+JVlqUfHHgEgwG1r/y?=
 =?us-ascii?Q?GO9X4FTQ2gqFMK79lua/NyMspoEjclA5hLvMSbffcJkwPXoXtJzgD2MkCwFx?=
 =?us-ascii?Q?1DNk7M/RjiJI6HJ3IR60Dpoi8k/jTIPOUYPcEqoBHlG4CDmZtYJCszg9R1cG?=
 =?us-ascii?Q?Nq6QvP8SuFN1SfYpjUXUkAtF8Sg9MdmM0D/cfRPjZR4znqAEY7lQrNsp1N+r?=
 =?us-ascii?Q?+WAwVgwHhsEHhEoCqI4VDghhQQmT9WdemF3468Ui9QP7zgw2+MalvV02lmr/?=
 =?us-ascii?Q?u44iXQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45239b2b-1602-4196-bba0-08d9be9c2e9a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 00:53:45.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZX3NymnrUkTd72eWyzpPcmT+0ItCVwMBW2010uORIBADlNnQ1tUQdEavocYcAuA49TuWGDcro+/jmIU3AYfeW4+vGk8+KD35ePz9/t3vcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3893
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140001
X-Proofpoint-ORIG-GUID: 0gsDhyom31aHsqAv3MZpChdIQ17kVwJY
X-Proofpoint-GUID: 0gsDhyom31aHsqAv3MZpChdIQ17kVwJY
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

When notification starts/stops listening events from inode's children it
has to update dentry->d_flags of all positive child dentries. Scanning
may take a long time if the directory has a lot of negative child
dentries. Use the new tail negative flag to detect when the remainder of
the children are negative, and skip them. This speeds up
fsnotify/inotify watch creation, and in some extreme cases can avoid a
soft lockup, for example, with 200 million negative dentries in a single
directory:

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

Co-authored-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Co-authored-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/notify/fsnotify.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 4034ca566f95..b754cd9efbad 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -127,8 +127,12 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 		 * original inode) */
 		spin_lock(&alias->d_lock);
 		list_for_each_entry(child, &alias->d_subdirs, d_child) {
-			if (!child->d_inode)
+			if (!child->d_inode) {
+				/* all remaining children are negative */
+				if (d_is_tail_negative(child))
+					break;
 				continue;
+			}
 
 			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 			if (watched)
-- 
2.30.2

