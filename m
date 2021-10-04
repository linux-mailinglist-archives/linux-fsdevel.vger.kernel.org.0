Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF124215AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 19:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhJDR63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 13:58:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60162 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234961AbhJDR62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:58:28 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194HHFB4023925;
        Mon, 4 Oct 2021 17:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=E6I6Ubn8kkAbTq6etV9iNCfegnB2Kdi4qPLvM99SBWI=;
 b=gQ+a9+/uJHjBcej62CMcEHVDbFERGU9gvf7F7FbZge+kghhtDOb91O9d9qjAtx8umFZx
 w6m1PicevDCRNBQGkG5XA9/5f1c2+O0YMGnB7ouVt9Ckv/9ePB6FZj2PVjlevONRhJVx
 PcGVEFFdkSRkNuJYQrVdJq9PdjQ8BWaLOnlqlq0CRvDG4XVXb2NFS4tO5GHAbRUeZQx+
 r28vBbK1WqN1LOO45+Qq/CZS+ZfETN6VvvrmisftKtlOf2ofO3//0WD+lF79HH1ZR39r
 SJ8F9+SzKTwTMuLKTwfXDGUqHOoR672wfA6xP54lnfN6GtNqMBBnC1wALLa+TgeYEkHy AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gh8gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 17:56:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194Htt8j126873;
        Mon, 4 Oct 2021 17:56:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3030.oracle.com with ESMTP id 3bev7s1faq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 17:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiCBF6F6lGUcE9VdwtUOys8UORtYhKtmtReICrnTCRFTXXjELMybPjh0OxxvJSJzQSi8CUrADT2AcwbpOgFDSkljOgKEbFp7zvR1aVkwMXhjC3P+v4tRcu6SM81y4q96k8VGQcDrCxJ6Wghe0BFzFg+XOSVkEGoHKljCbnaVgbxJD6T8lfRWUJHzipO+1/t5UM0ZWPCfWRTM8+dXN4beGzHH7/dQD/vlFxhtVh8YBvJ4zDk4wX80kjiWC3aJKNCJVDXtTFV1z+i3u3wFLUYOHPGM46No5WJU5bITgtnfNw6dQolHiCVH0slH0190QsNmYIoSq7pMh09DcY4Zsb34qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6I6Ubn8kkAbTq6etV9iNCfegnB2Kdi4qPLvM99SBWI=;
 b=eb0XOSBGkXvKmLqLCF/7I6/ppu6n0oL2RJtjVQC/jHo0JG/AhG61SO6lBMhBXO1nnnD0LlCg5ULbRglKuyVNY6z6axyaNcDLepBa3gIXZ4gSjzKE4aLFcW07S5YuTRLY6aw0R95dExi/zIe4QJWOjjjXZsmpCt2kVDUmikKG1JsHJXP+a/dZiZnPm8+Aac4V0qtdypnlej8tBQWExfJmEnaooOkeOY7jlDY6dGtu0XKaK0bLM/HtOkSZvan3rqvgxdGJHrqG7gqufD0h5j6PtY2Eevpqv/QRB11PQPY28wG1b0aN8BwBsumzqBPHgKmA/f1T95TvLGeinWfsb9QF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6I6Ubn8kkAbTq6etV9iNCfegnB2Kdi4qPLvM99SBWI=;
 b=OG2TLEZAWOgeyNzBbsZiPU9AJWXR/ijlp6Ygci7VxkOeGiQfrH9m4j3XWcExxY39N+Y1NlByfHChnw+tR4G1CjXmh4idJXxhsp7flZCm3KjCFa67kKiadtibJTW8F+WhJsl9WpXTqHPeMmMtRbZ3DlsThOWT6hfzsQRr1afpI6Y=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 17:56:34 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 17:56:34 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Konrad Wilk <konrad.wilk@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 1/1] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Mon,  4 Oct 2021 10:56:29 -0700
Message-Id: <20211004175629.292270-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004175629.292270-1-stephen.s.brennan@oracle.com>
References: <20211004175629.292270-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:806:27::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.8) by SA9PR13CA0131.namprd13.prod.outlook.com (2603:10b6:806:27::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Mon, 4 Oct 2021 17:56:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef0efbcb-0aea-4562-2171-08d987604e06
X-MS-TrafficTypeDiagnostic: CH2PR10MB4278:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB42784045A092A9A10698BF7DDBAE9@CH2PR10MB4278.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dkMmHQinfzk+h52vBD/j9Sx94A3iaan4IQCcGbziRk+t+8syhojoLk4JY/YA?=
 =?us-ascii?Q?p96geVSXxmVI8K56FHa2a8M3KGN0EqlK+Go4iwtokP2h0Q0+PCcg9sFCRkhY?=
 =?us-ascii?Q?MBdIVx4Iyo0aN+WZENUF0WMAZ1bTb7qELzsC7kzjl45/p8TQJIDMOoCakObR?=
 =?us-ascii?Q?IMIHGeFqt7rXkyN8+xLxmB7fcIALc3UIVZNxEyzLhFO+/9SLyazTrujG/3NL?=
 =?us-ascii?Q?Kyu7+L1xWoYLTZI6uqSXefWbGpZvD5zsjArGKfRvWPEZ8UbkX4Nluc9RjuGv?=
 =?us-ascii?Q?PDiqBfVq/Z5HSAatNF4Q34AAHgF+LmFoaXqViFtTrXw5NGMY9G02g9azs2lU?=
 =?us-ascii?Q?Bb/dvAehG0QmKeZj9ibxyIyRg7PLzApn/JuKmHTspLLqrrCdnHhiaixnD34+?=
 =?us-ascii?Q?374rUhg4tmjXD7T7AZkNscwteqj72HfS6wbyWsjgc8CavPlBBdQY8Cosxlu5?=
 =?us-ascii?Q?eHmKgX8aZAzftpkic0qGOEoFLC5rPopUCyclJ2aQiu9iv2HHA6oR+FmxSmnU?=
 =?us-ascii?Q?Vv68osg2ZWEmncKjZBMQ3cDcjzc8YFE0FS8u5ptB7RLOxLt80RbUaQPTPlbJ?=
 =?us-ascii?Q?9SSLmhW37aCXI7q8VUu2LtX8eYfmG2xjjH3kqZNgQYXjnalxGCrNPdI/LmrV?=
 =?us-ascii?Q?/8wR3COslt8Ui0ihxPIMIJz8i6oxAH0bqc5UdEMqqkVO0WmrxRD1YdtPEKUP?=
 =?us-ascii?Q?M7ZoIE40/0usEyn+ydPGgAw0LaD3tRqPV543XJoVtw8CdT3qS9+MQyXlfrw0?=
 =?us-ascii?Q?t7lx+EUul42dL4Z5Dq78JoGiaWXvhYy3+Az3k+gRA1KvuocIGG2r2N6k6ZqO?=
 =?us-ascii?Q?6+jzXS7Fja6evhZzsehhxR52rsIPJ6KCc8d6nmEm6bSRqCzjXvt5bZWYzlr9?=
 =?us-ascii?Q?28Uk77Fa5BWsMWEOoTDwauxDVyHkDfyb7rsFUI4PkMMoVvO1Xn2CqF4I7RWA?=
 =?us-ascii?Q?vMCqR6UepjZWwRSzUN0MvBzpiwZ6EDP25fWa+4WrPKey0BeKaCY8z3Nnhg8Q?=
 =?us-ascii?Q?3stosWPIqCo4avwQ89YsUBUN3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(86362001)(26005)(1076003)(66476007)(36756003)(5660300002)(186003)(66946007)(66556008)(6916009)(4326008)(103116003)(508600001)(6666004)(52116002)(6486002)(2616005)(956004)(316002)(8676002)(2906002)(54906003)(83380400001)(8936002)(6496006)(38350700002)(38100700002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k5uiFNzSmoswzpLvGjibsI7hCZhawsNh2Ov3b5bfe04zHjiI2HxVKphopHve?=
 =?us-ascii?Q?tpe0HVad6xy0QZ1dPW3iMVk1NfBaISQyARSOUiEWL4KT0sD3Q0cnaqG/qJ7C?=
 =?us-ascii?Q?XIrW+aQfdqElZh3yYs0xp8KyB4s+LCpX6CMST8SQb+CcA5I2UILIc1pfDQe2?=
 =?us-ascii?Q?efHmgJA886Q85lR34OUGfXgLIO+qTqLz+KD2uSwL4QvXxIcqKa723eCVZyo6?=
 =?us-ascii?Q?9hEcJX1KGVziqVxyXDlhBiX+pxQGElDvJkJtNbIIhIYhOLkN2F5je2vgf34H?=
 =?us-ascii?Q?0sLZ0oMhhI6zJJ/YhMMe1oX9IT2IXlITwA/RIkjyYKAzQ6pYB1NGbVg3HPLx?=
 =?us-ascii?Q?qXcO4PfW9FPyd5OjpMpGRQMMgvplX0YUBRh7II+YPfjEE8cC8j/HOim2it2Q?=
 =?us-ascii?Q?6ZSFfXjQLLUFuwB88/jEaVR8HUiE7O8pyYJMxv1A2ZweKMziiy8N2mP5KUTd?=
 =?us-ascii?Q?arvEgBQsMkZeCRYSHVDb9UiTksO22Blvfq9+E/hes/aIv3G8k4j9DF+fP1y/?=
 =?us-ascii?Q?8WRLbQqnwp2vQCxLvUQYliRdUX8CglTYbkH/amZoKMnDe3kjO+UgwBKo/t3a?=
 =?us-ascii?Q?HuyvaVEqPZjEBeUzj3odMOhnA4jgmb/glrp96gUlMBFGa756Ryvfn5Vq2vhk?=
 =?us-ascii?Q?QToXixeKl0ZVZHKHTEMRYnwDJmKRlzW2R3I/JhfMVdiTOa4y4AHoXdhgNsTe?=
 =?us-ascii?Q?dRqzb5+KKCP8k+fjilSoBISHnXZAUHlZ1F/s1Nmdi8EtChpGmLsFmB6iBh9Y?=
 =?us-ascii?Q?lBavvfeYu5iNtFJu3bJfVJMz0JfioahI+Om+JhOF57JRxfBWXtgR+Jigax5V?=
 =?us-ascii?Q?150NS7+bCwbdMuAvUF1Kk40oWk5rPKwGz5nZUi2J5cQCyd2Do4A/99puRa+O?=
 =?us-ascii?Q?CnEg0lJnaQTpkgy9Vx2+m1qMQ9cCehH5U/2cK0/Gs8m42Shp/gW9Mv7lWl5w?=
 =?us-ascii?Q?yRepwJMHulXBU4rDDmQ1DuMheOM99XZR8njHu1iWFnH36KDcgUrPZ7SVbrol?=
 =?us-ascii?Q?blhl8oOQsmkMTd1+L4Npr/IROVnnxgdLqDVMhgZdZc+F3yE+P/Mjvw4c/p94?=
 =?us-ascii?Q?MUVL0G5bJXVAzhc4sSrwK04oA+80JOufJNEJh9hBjKqRoW+uT8G0kyWdVl5u?=
 =?us-ascii?Q?zoeIET0K8XpAZXZMo3NEjFXWLB5X6YDpfuwTiXzXmFdQDWljkwmiZUmp30hu?=
 =?us-ascii?Q?KKwe/gxoZJygVDhlKNZvF36QSCu5pLuvuaKKifRRJFMO3Z2oogRHX1qmw0vb?=
 =?us-ascii?Q?u20OIxxfZycyslgd9/XR/zkDPTUoc8mdjJcFAEawm9Q1CXp+K6q1E4Qz41nd?=
 =?us-ascii?Q?iP1NdBknNQHoG1sOHjHLDBjd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0efbcb-0aea-4562-2171-08d987604e06
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 17:56:34.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWZs4vWtkrYV25WG4NPqqr24Dk0FJ24iTUN/XYePWmsvhYMNEt4lf/UldBboJ1HFwpMV69+Q9mn5J0xw3E6HdNZyR/fuMFRfJpkHKIiSO30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=607 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040124
X-Proofpoint-GUID: Rdcs0Jn-o_01l8qR2ucbQ7eqcYFUbHmk
X-Proofpoint-ORIG-GUID: Rdcs0Jn-o_01l8qR2ucbQ7eqcYFUbHmk
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pid_revalidate() function drops from RCU into REF lookup mode. When
many threads are resolving paths within /proc in parallel, this can
result in heavy spinlock contention on d_lockref as each thread tries to
grab a reference to the /proc dentry (and drop it shortly thereafter).

Investigation indicates that it is not necessary to drop RCU in
pid_revalidate(), as no RCU data is modified and the function never
sleeps. So, remove the LOOKUP_RCU check.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/proc/base.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..3042ab418c31 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1979,19 +1979,21 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
+	int ret = 0;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	inode = d_inode(dentry);
-	task = get_proc_task(inode);
+	rcu_read_lock();
+	inode = d_inode_rcu(dentry);
+	if (!inode)
+		goto out;
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 
 	if (task) {
 		pid_update_inode(task, inode);
-		put_task_struct(task);
-		return 1;
+		ret = 1;
 	}
-	return 0;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static inline bool proc_inode_is_dead(struct inode *inode)
-- 
2.30.2

