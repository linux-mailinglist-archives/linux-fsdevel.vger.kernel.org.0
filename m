Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495C54B0103
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiBIXOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:14:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiBIXOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:14:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844AE00D0E1;
        Wed,  9 Feb 2022 15:14:23 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KXZvF013346;
        Wed, 9 Feb 2022 23:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bpeYHvOJuUKnD8/LQm3J7tZfnWqoei/xTnK6oZFPZ8M=;
 b=QELSGKIwiknzIffv5H0Xt46x7Dt+Q+XJXCL9h3xB17PcZ+oAjfROXU6qnROt0sW/NNl4
 dM3vS2bfzh60GlaN48UFYadsdD+ewlJ+BNMce1bPvxs0pemeduQ2xu4tRJsOU1UQyIRa
 4JYXcs2xEE8hGzWnfNEiRpU7Tweyy6CrlNF8ojxd4ua28O7lUMF5NAyjKmWoYEZmCamu
 HcYJRdiwLi5oPV7XFBnZSqrNOoiRUFQrDROSUd2cbYSmNe8vonV18lLdzbCs/KrC+aNC
 pHanw+oHGMf2ApaJwgVUiTT0ayl6nVIV3BEDCaPoEx9hVFppeGENfpVOLE/B2GJ8btHC wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368ty83v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NAQHP039290;
        Wed, 9 Feb 2022 23:14:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3e1jptxqpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLOXeM+Z1PZ736we88QJEPPZ9PHKjnh9ZhNJ7af+hpQbGT57Ri9dEo2lruIPqdoyuBMXoXpXKYRYDedNEm3BeGjXKZTzqibHipHPIe87UPduAjlLvUkOvkizD7X+A/5CYU5iS+qB9m12AuvbMI0imCvve1ffAQ9SjOElv7OhAanZvlSy6UIiWWw/Iugb3uwP6bCY4fY2kuvVUt2PKyqRZM4l3dW+NtuurqSJpyQdS3p8JI0OvLIsVRRy8Ucly+STh8ho4GX3vFO3gGmSISiSZmz5feWe9G8fmpDJA9pvrz7vPkX6YPMvdhydmOyRjE9JT2NnvCUF7KfXTUZi4RtnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpeYHvOJuUKnD8/LQm3J7tZfnWqoei/xTnK6oZFPZ8M=;
 b=AVKOV2EMxBa6HLlNAETzKXAhH8QJtcyWg3NA9Q3cyEu+y9On5Hg3egGuQIRTvPunEJ76FZr/yPybfKbF7bdFC4rlBJk1TsP5GasYaG1toX3j5NPR8UDZW4e+pm0QVSTc3dFIBwE48361oIuhZL2lsgnBvX/ZlEcxkHTpJHK8OHKjYgb+8lJwKCHsPIJ/hN0hoXcjYUJ8ZRYcuHdYlSWWiljw7kiKYW5nv6etYXBhWrgfwq1l4eq2D+r/0NNnTMrmQ3QDkzf5kJGiuwLJ+re4ErW2RIsdqkgK3rcELS9rDiHCFEpcO+XecM3t35PXe6WEblQjP7Q1urHoyuHYLJfEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpeYHvOJuUKnD8/LQm3J7tZfnWqoei/xTnK6oZFPZ8M=;
 b=FvFFsCvh57k3pG0YJNzNKx9U0raQpx8bbAnozGQksRyDTpmr9vg1RTYOo1mE8goH+GXIzDkZnYZbf9bThDwMAJ1DZSqyRGm+t+SuwuiuVg41Yn3hlYviKzoVKgJn9vB82BrVtN836t2s85ia++i6LJI63Q5X2Cw1Bx3sl4sg34A=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 23:14:09 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 23:14:08 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 0/4] Fix softlockup when adding inotify watch
Date:   Wed,  9 Feb 2022 15:14:02 -0800
Message-Id: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c289e84-994b-44de-2540-08d9ec21dffe
X-MS-TrafficTypeDiagnostic: BLAPR10MB4884:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48845F935CCD598733BBF201DB2E9@BLAPR10MB4884.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ux+/7vEFQ3dzKk5wnuDCoTch7VysPZq4rpkI8rrA+x9ug33RXAoDa3TMYCw4Ogke7DPBK+R7AESwT6k8noRJeu6M7ShmHhIbgcTerRD65dkAul5WPgFgopW/UtvCVEgSeqPVa8WeDesSd0sJJ3HN5pSDPKrI5+rCs3y6pqI5PwjWlCKjFjLR2ICiTotI/jPGEy56OrefD0ZIVGwcVmZkmG73cM8Q65ogADY8UqGS//Dg/i8I6K/8mUGEoii1S/LYQUkOGpJZr4pnAaXNvFd4v29cOXfr5LWHUsg+W1BtxNnxBzRWZfNYzLp7sxGW3cUsegdtUEmH4zqLek49k19VAzSaX2faHHD8LAHVPEVm2yZ8KduUPNYk0BDgoedG1Xc09KtjAUJgEnyxnTn6DpxuWhgv4qdml756p5LztSidjeAWGWu467Dc/AEfK0z4UOfKkimW2CCSiCqBzsx8Gw+7rB/t0Aw1LB9RKmpa1fJMKSAP4yTipPcZ62V8B7Ylh4OjtfhK4xJxEHJsFKt5egdXRBm+Za/45yiqJpGnvVHhfNQE8qmzicGZbQg9U5ecCYAZPBgD4zWTQXd3/CcbPOZPaOZunelyzDY0faARvaqH/9bLCCCfoqgDnLMnFF8Vk9z8PScK/7VyXhz6p1ahEG6/RSOaaESVFyV6mSZuL50dnakJ6cDnmwxyXb40xWE+eeVAwy+8xUHk2Y/GthO6Ek9CGIJIXt4sk+F18mClY6nTGAbVsdtvwlo7EieSyaeCoLar3x1fIghUwnXOl47AheKUEBxXZj3Qw+IYXYT7new1ahfkVocAYWH+iOTvbevAlSBwV++1qlZVJCwXdb4yuEha0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(86362001)(52116002)(8676002)(6666004)(6506007)(8936002)(103116003)(66946007)(83380400001)(66556008)(508600001)(4326008)(2616005)(38100700002)(1076003)(186003)(26005)(54906003)(2906002)(110136005)(5660300002)(6486002)(966005)(38350700002)(36756003)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHjjDlKv61GihOmcZqZ4glA4/CdcqwdUZfaBpAyiUwxuPwuLBRjsq2D0hzNP?=
 =?us-ascii?Q?MhivBAG588ZxZn+rwLSsvjEQm9we6gH6AzNfLDni5JCjqzxYA5qxlIWzR7wS?=
 =?us-ascii?Q?f+ktiIBAyYBe8jnbuai1QCVOl9FCJ7bA9QcCB4pS11mpO3bUoz0mpCSWvDfU?=
 =?us-ascii?Q?WI9HOVlBS7ZXz4Rg1+SOgmM2nzUAYTmap69J274lpxIsII1syFYmC0k6hbUk?=
 =?us-ascii?Q?iqnf0I4HyBTmNFUFSQZkXmTSIVHi2mJgee+UW9pidkyR+x/Lk0rxWEQ0xxWl?=
 =?us-ascii?Q?1Y0DgtUnLah/vR1yX96gaUwZnm7qJrHPEDz8n8LFE0mc/WKymVpIm8hpQ+nm?=
 =?us-ascii?Q?3bLDFm9ItYFKU2YzmflQe4bChq0LsEtk23oI8UhV3cYt4gIRp3Oi21lVNP5m?=
 =?us-ascii?Q?1jzLdWLQFf+8DxMEmZX5QdQl6PcHQ4uhkdDDJtMld29B75LpocFP41xl968h?=
 =?us-ascii?Q?GExdEEd/OCqcyBz+p2uDPUy6TS2HA/eeRcVV1boAmMBwbrajBcrK+UDtPDyE?=
 =?us-ascii?Q?bGupEiD2ATBMem0NnYKtZnJhmR53DpqlFsOjtvh9L9NOTnT9SkhnbceyMYXt?=
 =?us-ascii?Q?h2wx7AMIfPre9j0b/D1hdFL023jXkPeiXYKKt/Qvt9StOF/5FKaokcgcIRwR?=
 =?us-ascii?Q?mo/Bjo83O+kP+2z52EQT82/rbW8MTtKEuG1Stfx0px3gYsdbk20lkLD37LpB?=
 =?us-ascii?Q?28XbQWlHGAYbi2diHafYYVcBPdTEV1AUngt1ne33eAgW4vXOpst0iwnhOpHQ?=
 =?us-ascii?Q?mhUoc45fvkc6P68TimzHXlZTS/s9/8HwDqEBE0Gzp13qCZrNfWgNAYAqtQtf?=
 =?us-ascii?Q?/u6ByzgfEsMiyad21W5M8qFMQLD/f0CeBSQp2EVCUyGMTFli+sLmK5iilkwt?=
 =?us-ascii?Q?hTIeGUDn4jqebESm7qY7MWbWbsoMLhG548SzCuxykr8neIqDTMqSm1EUOSpO?=
 =?us-ascii?Q?L8C8Ay16kDVmMg3Mt/knHVciwHavYa/6GgmUDFI6OfmZqlD9ioZc1lyDWVnp?=
 =?us-ascii?Q?uD1q6/ZtqEq+Tf/0q4meYYOUjXBwhi+ds4sYiAPLDcAxu/uOFZGKjC+XcyZ9?=
 =?us-ascii?Q?p0ePC6geW9UIQUd/wBAWOIGQ4HgbfiOJ2d1nUhsZVmjLqPoC8TZGTmRqgoq/?=
 =?us-ascii?Q?12rx+UIr7XcUwwuPvqRhyQL1uctt67bB5r5aS1Lebq1VT2IQxuMhKNcG/tqz?=
 =?us-ascii?Q?uaYwieIgahh2f8E/yXLJhbO/dw7BqPMHNKkXPIvw/76tpbL5fOeFKSDmtWXs?=
 =?us-ascii?Q?iwksgNJM+VTjNq2fBpktyvouxiMiSSaoo1v9cFBYZXC2QBC3P59CA+DqgYHy?=
 =?us-ascii?Q?8lPtRKbkmKOB3qLz/CROEfjm4rTpPI4+6STsGxgaVQif/tlXYE7ll+94v1a7?=
 =?us-ascii?Q?LBrWvEKwUkiej9o1F0QkkzMPJLASKVLqRcDxXZryBg6NnACog/0DaJ5Sz6uB?=
 =?us-ascii?Q?5IbhIR9c+DWc/hOoazg8UwQlzb9cgdp6jEfiS6AW5p2KeGr7EQ9HAhFMGs6L?=
 =?us-ascii?Q?HdpGA4/9LMiZ90q+WmTdFDZt43+W1xhpzViXTn522MYeDuKYOK8EWhsNZQGe?=
 =?us-ascii?Q?STDhaspvcSVEbYVr/y9LdUGx4817qb9J4xL4L5Rc6dThMdeyNqhF8d3EveBH?=
 =?us-ascii?Q?dXx+KK3xFJd1HzI8jhhB03AGQa+VRiHqjUfnD9OLLzy0LY4bRta9KiexLdFg?=
 =?us-ascii?Q?tbAggA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c289e84-994b-44de-2540-08d9ec21dffe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:14:08.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Yr4aajQZPU87QIDZJ9sulIphrT+p50CoAN+i/IKLA07L4NLKu0abOClXF6vCo+dgJYn4nc7ou3qPavUZ0bTEiMlo4TfNDPv6jc349R8118=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090121
X-Proofpoint-ORIG-GUID: bTReoCX5ernxfBYeYrH7sOqheQYwhkF_
X-Proofpoint-GUID: bTReoCX5ernxfBYeYrH7sOqheQYwhkF_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al et al,

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

In v1 of the patch, a warning was triggered by patch 1:
https://lore.kernel.org/linux-fsdevel/20211218081736.GA1071@xsang-OptiPlex-9020/

I reproduced this warning, and verified it no longer occurs with my patch on
5.17 rc kernels. In particular, commit 29044dae2e74 ("fsnotify: fix fsnotify
hooks in pseudo filesystems") resolves the warning, which I verified on the
5.16 branch that the 0day bot tested. It seems that nfsdfs was using d_delete
to remove some pseudo-filesystem dentries, rather than d_drop, but it
expected there to never be negative dentries. I don't believe that
warning reflected an error in this patch series.

v2:
- explain the nfsd warning
- remove sweep_negative() call from __d_add - rely on dput() for that


Konstantin Khlebnikov (2):
  dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
  dcache: stop walking siblings if remaining dentries all negative

Stephen Brennan (2):
  dcache: sweep cached negative dentries to the end of list of siblings
  fsnotify: stop walking child dentries if remaining tail is negative

 fs/dcache.c            | 101 +++++++++++++++++++++++++++++++++++++++--
 fs/libfs.c             |   3 ++
 fs/notify/fsnotify.c   |   6 ++-
 include/linux/dcache.h |   6 +++
 4 files changed, 110 insertions(+), 6 deletions(-)

-- 
2.30.2

