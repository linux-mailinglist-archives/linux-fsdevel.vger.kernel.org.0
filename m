Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF83AC679
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhFRIto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 04:49:44 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:20278 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231295AbhFRIto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:49:44 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I8hEvu030536;
        Fri, 18 Jun 2021 08:47:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-0064b401.pphosted.com with ESMTP id 398k62r5kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 08:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5bxhVWe+i8oTty2OWQrSl4pjO4DrR5HcROBWf0sm/9GeBGgKIuGFSXCX+lifrmvi1BbnNlVJKbgrowPpMmydqJROmEdjOOpv1Ahwh6eP6c99ffeiTzQhHhN7Kk2oIb/dQ4jFJweg7RuCJ1O/Dj4VryMwWbdVfbIcKHKNyu0OHOysOHE3vV0rkemN6jPiqV+JP3p6z5QnVteoOwgHT5SxaiYtKiYJvklbvFgki+2Fhr0pZmymjEawQddrfelbIH5NZj3LoS1sFxMVmQMsD6FNiUW9BHhFq8q9FCr1KaxOdPxXZi4bV88WqtSyBXBjt99UAWQTAMVmg30M0i7gzCm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WepxGmDRn7tL5JNzfvQ6ZOuRufYs7VazI6JlZYiKaQg=;
 b=J65cb/bpPjU0du10j7Jts0TezCK2lXpsozUaqBdzpQLltvUe4JUlkdChZF0O7TKH2T/Pq43ey+p7dSgiWinotM2926ajxVIiua3+oAzhh36FV09mcOGwMfUNtHtuVj61QVPZlfDydPQ+SkYtw5Yna6i9fumenAWOqPfJQLG016xgFAP9emAVk6C7jWfNbkmD0kiN6q7Jlt2L6so1slGyw+GsmwZiQ9WwLmQOMTlvmnVbI3AMeQXHABNb6SyaV7jfdT6iRxflcobSRVF7lFO9TqKz6G6BUpUL+StHflOG/UCdaoKvi6iH4auGaZKS++xmSsTZLCijXDvV06Q5nVQoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WepxGmDRn7tL5JNzfvQ6ZOuRufYs7VazI6JlZYiKaQg=;
 b=dV7kRFHNgcbpHAaE+aAADDKWwemM9b25JwuJxM2kA7g49hF/b51aM6UZRvUi0YbUwHVxP+xR0jGnpgcDAqe9CLQFH+DMpBQXudOTlMmpSFMuAathm55WRUkuLkTCjj2gwUb5B3gh+9P2Lb+23RP8/I4aL4LBGP+G9O8vC1lLQcs=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by CO1PR11MB4817.namprd11.prod.outlook.com
 (2603:10b6:303:98::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 08:47:10 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c5c:9f78:ea96:40e2]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c5c:9f78:ea96:40e2%10]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 08:47:10 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     xieyongji@bytedance.com, mst@redhat.com, jasowang@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qiang.zhang@windriver.com,
        zhe.he@windriver.com
Subject: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Date:   Fri, 18 Jun 2021 16:44:12 +0800
Message-Id: <20210618084412.18257-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CACycT3t1Dgrzsr7LbBrDhRLDa3qZ85ZOgj9H7r1fqPi-kf7r6Q@mail.gmail.com>
References: <CACycT3t1Dgrzsr7LbBrDhRLDa3qZ85ZOgj9H7r1fqPi-kf7r6Q@mail.gmail.com>
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HK0PR03CA0099.apcprd03.prod.outlook.com (2603:1096:203:b0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Fri, 18 Jun 2021 08:47:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd09178b-f290-49e0-b13d-08d93235a8db
X-MS-TrafficTypeDiagnostic: CO1PR11MB4817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR11MB4817F9DAD2E61F87FC5601A88F0D9@CO1PR11MB4817.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8T5GBalhfSCkIW1K0QsgKsXfdzuHuVnHtFdREinG5uj2T99VjP3xitCcqa529viHjdQAWHTPzsyYEPK8TIvZb1CpoNJaZQiRDNrJVcc7Kj8JQ6uqPiT6Fu6l4WA6THqWSpKyxPBkycFbjgg1T4hJzMwUBYjEGMjbbBlyrTMwMJjdJ5hARLxgaDoyx1NfPu8uPDkzhh/ia74RGRbHKmU2nowlUS+bfu7wMuMTIv9wGLLaTgHDdNBCTnlbtcqFxsX3u6roa3EiInLJxzljLp1Qx7bguEFbGmRSSxjpjol+KUsBwB3vTkKKWwIaJ/sCiUczaOWkkQm+3d6VTEjRBig7rlrUXznSPgjbogG7G98pEEcVz5t886fk3RCsXKD7YIE29/zpzSOMZYlKc+hU/27bHu2HUvAmLR5spwYMGEOzscj7hj1WzGwbF1rkASpL/NDTsV6Wq1/c7gPJiuJS64sHNMVwWLs8YIzpUub42H0MwO4a/No8sDJpgiBFnTbSWlRTVf924xoqAZY2ZsTIIOp9O9YEXh2kEHe5Bm8H/s9ntgNdRKb3Kz+adD2FOI5p6XHgqnXG6tYVznXAHBao6l15SBUIg0r2LqCWkhhUc+2R8/r61RWILZgH7dpi5ki8aIvX2uGBfKIJMk+vZ87rFlFULbMV5p9uzksGjmqdA3TF05HuhDr8yuvbL439EqRlqVlYN5gfJHAhXeMPtAOY6Ce1tIqH+BNoGaNU0B2UrZ2/dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(396003)(136003)(346002)(1076003)(7416002)(5660300002)(316002)(6512007)(8936002)(478600001)(956004)(2616005)(6486002)(8676002)(86362001)(36756003)(38100700002)(2906002)(83380400001)(16526019)(186003)(26005)(66946007)(6666004)(52116002)(6506007)(38350700002)(66476007)(66556008)(921005)(161623001)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t1pJWMYhEbN3BAjnIJ9Ci2mdgoAHqNeAiZrJodWCmZTIOoO1F3AQUquUcKg4?=
 =?us-ascii?Q?ZB0220Y8AJG6lAPNkVKRfCiL28CRQe824Ok4reowg/Er5rpvcwKs3b9bUk/m?=
 =?us-ascii?Q?gSm+P4w7AJ6psOLrTz5O03of3iKdg4LdNd/heKNHE3q9V/7Qq6WpdMIigg+i?=
 =?us-ascii?Q?iwQss/eQiIKv/Fu4ESCMCPCjWkDL/kkRwrd2D19ih0lFmBhtCb0vDHn+v0/0?=
 =?us-ascii?Q?HgpuFkXaF5toyILSrvLxj6syKkzydlRwMtzBVt693H7TfheIDvwSxS0eWsLo?=
 =?us-ascii?Q?WmUxEwF/+AuiFc4xPrw3vEddpYPPG1WaPEySS/Bf7bNrGlHCm2a7SlEPiO2U?=
 =?us-ascii?Q?l3ypeBhPzGNl9/kEQprGUJ4VAL5x9BfYae6p0evO4zA4BlIdf0ijTwdCvaSQ?=
 =?us-ascii?Q?qfsbAzAkoSaQVWjmPG0aFIhhZyan7a23aTxiPMnn30pIAli0ILQrKO/ib1xP?=
 =?us-ascii?Q?yf7Q7ylux+hJHN6GE1wvcgx6vMSJEMiavgZk790Y/opXRDYOuqQPF1kRmx3L?=
 =?us-ascii?Q?qZw1o6U6eQUWjTUnAXlW+L2ltkuf3aLkPa9ZOSLQUnJFfj18ow5BVHOJsuKa?=
 =?us-ascii?Q?EvpIuhknFVp4nERiT8G9WioCPzME4X1YeHK6kw1ULOhlf4RAoTWn/Td6Scp3?=
 =?us-ascii?Q?A7B1vegWNzZb7CWqgD/7fT9KOvSAAPirkYV7kO8qnI9omaGrG/kDJURu3QFK?=
 =?us-ascii?Q?mMApXYoPsJOxk0NsmUWGwAOi/xW0A0uzIkGnRQR99I5LT9QNBKlZNn1eMElK?=
 =?us-ascii?Q?Y5nyIgrtLM8tQblQFRHJsn8fBOJaDl1xX0ORqr7J5Q6qljo+cGqubpWpSezC?=
 =?us-ascii?Q?/Y+mfR06xlSlrVes0JufDbO+NYNgimglyj9/nLk1yWqaLAAmKxNhZrUusPod?=
 =?us-ascii?Q?y5CAbslynWT4EjPxKE9KmvkSnOV//t/SPjIquCxFpcAwxKN9yfWjPydd0+g8?=
 =?us-ascii?Q?l0KYAupL9AORhybqTEKJmk8bJ+45iqjSqW/xxD6pG4+X0MnotoQl+ySTntjY?=
 =?us-ascii?Q?fnY65lhuPSvkFHXFQH3RoDCaBQZUZVN5O50zjqy0zHIW3BX73sQIgFy7XaOE?=
 =?us-ascii?Q?2A+vj57ECh510RqE1ShStEwS0FMmNOEGjejVXVWBn15UMzekoQN0v8KU0Fi5?=
 =?us-ascii?Q?2wA2sgG67MOuw2fAd4Z3wxhZoFOn1JdL/EaGkLpcA9/yli8cd+LHOAXzQPye?=
 =?us-ascii?Q?4N83Rp5HUgyZBPfI1pTOPEWxFjYl0+DaYJVCl9xAc+yide1tclPPgiCEsyKM?=
 =?us-ascii?Q?9jReVswLnzHTiVr2KFh6uJ7FB/eVHrGinTu37ItYKUqzluN1GOkW0jj9Ru8A?=
 =?us-ascii?Q?HgVkEWqvrlJjd+8QAbZEXDpC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd09178b-f290-49e0-b13d-08d93235a8db
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 08:47:09.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L31OlygYudXwkVfUYGJGcVvkDUwJRGoHbWYDN71CSHMq+ymw5uzLOIBh9n6cKjSagZLopemQOEpAnX4qbaZOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-Proofpoint-ORIG-GUID: ugHlmLXunpNnw6okHRVS4U8aruk8iJdD
X-Proofpoint-GUID: ugHlmLXunpNnw6okHRVS4U8aruk8iJdD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-15,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180049
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
introduces a percpu counter that tracks the percpu recursion depth and
warn if it greater than zero, to avoid potential deadlock and stack
overflow.

However sometimes different eventfds may be used in parallel. Specifically,
when heavy network load goes through kvm and vhost, working as below, it
would trigger the following call trace.

-  100.00%
   - 66.51%
        ret_from_fork
        kthread
      - vhost_worker
         - 33.47% handle_tx_kick
              handle_tx
              handle_tx_copy
              vhost_tx_batch.isra.0
              vhost_add_used_and_signal_n
              eventfd_signal
         - 33.05% handle_rx_net
              handle_rx
              vhost_add_used_and_signal_n
              eventfd_signal
   - 33.49%
        ioctl
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        __x64_sys_ioctl
        ksys_ioctl
        do_vfs_ioctl
        kvm_vcpu_ioctl
        kvm_arch_vcpu_ioctl_run
        vmx_handle_exit
        handle_ept_misconfig
        kvm_io_bus_write
        __kvm_io_bus_write
        eventfd_signal

001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
---- snip ----
001: Call Trace:
001:  vhost_signal+0x15e/0x1b0 [vhost]
001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
001:  handle_rx+0xb9/0x900 [vhost_net]
001:  handle_rx_net+0x15/0x20 [vhost_net]
001:  vhost_worker+0xbe/0x120 [vhost]
001:  kthread+0x106/0x140
001:  ? log_used.part.0+0x20/0x20 [vhost]
001:  ? kthread_park+0x90/0x90
001:  ret_from_fork+0x35/0x40
001: ---[ end trace 0000000000000003 ]---

This patch enlarges the limit to 1 which is the maximum recursion depth we
have found so far.

The credit of modification for eventfd_signal_count goes to
Xie Yongji <xieyongji@bytedance.com>

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 fs/eventfd.c            | 3 ++-
 include/linux/eventfd.h | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..add6af91cacf 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -71,7 +71,8 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) >
+	    EFD_WAKE_COUNT_MAX))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524baed0..74be152ebe87 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -29,6 +29,9 @@
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
 
+/* This is the maximum recursion depth we find so far */
+#define EFD_WAKE_COUNT_MAX 1
+
 struct eventfd_ctx;
 struct file;
 
@@ -47,7 +50,7 @@ DECLARE_PER_CPU(int, eventfd_wake_count);
 
 static inline bool eventfd_signal_count(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return this_cpu_read(eventfd_wake_count) > EFD_WAKE_COUNT_MAX;
 }
 
 #else /* CONFIG_EVENTFD */
-- 
2.17.1

