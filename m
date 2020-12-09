Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB692D40F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 12:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgLILWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 06:22:02 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:46049
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730694AbgLILWA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:22:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqd6i/TXIUkw/2Dk1G/6sTtoYOjXDNPDWjIbwZ5NXAWctnNKpl2TG7N6UI67HegNtRQ3w9UynRV7dLLTGzht2DMYVa94RudZnJME2Il4UqjWpOwgWG2DGXkLM0y2Zpxhv59tkgf3iX9SYwYlYbMqZGe42LSAAVPgIY60TsWt924Vlo+shCvrJRwapWrHfEwxT6+tIuwcuEKyWMzMCmUVwIg26qmZfZAKkp1ElSSsqmsqrLrjlDpNsz7FBprEfuYWii4UM5WJfDrIeDE+1zaWOOLpC30VwWVpH38SjrAm8rVdQL+RJwi0h3ADT+W4RHIjUns4u/P1yIjwvhmtNFoTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IMNZ7tvrzZm4PF6zUY0Z9GNv4IuVJKmv7eyMGNUuHM=;
 b=Rms++chfs8i43z7AZIDAQwZ1wq4DXbZAyK/EqgT4MDiPmgRvi5sD9NV8XI1dJtBzPAGToa/GExaP1uHLYH4XzVwPNuj17mbd02bmbLaFbW+eplfpbWKr+hDvRzaq0dV4MUp/izqTIkct44bgCu5pDNiLr1/kplp+D3KbaHTjwCSAzD9K+wtCef4FgHzhXMcPu0KgQGFYSS4gnYW6+5E9PBF/iObonKenHqHZiOt77CUERr5/XeWL9CNE5aez3ZFBg1T89QdqeIQayTYt+0OOB9EBKpX27Cmga2mANjK6Ky8OzBLxAXULSt7NFa551Z7ut7nn90xinDboM2fPDBfhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IMNZ7tvrzZm4PF6zUY0Z9GNv4IuVJKmv7eyMGNUuHM=;
 b=aY3w6HSvxUUeEK9EDQBthlLurc0R6oNuPNe26ktLsW0zHFFweqA8RquGywrStXE9prDoWwL1C6q3HIgb7HQFRz8IbzXfQusp1ZyWDNziVJZX4rcFXlejY34gDdXm3d/d5JeOE1gpMHr9f35KDS9CoyymU1KDqPvpVmhLWsEHX7g=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM5PR11MB1674.namprd11.prod.outlook.com (2603:10b6:4:b::8) by
 DM6PR11MB3515.namprd11.prod.outlook.com (2603:10b6:5:6c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Wed, 9 Dec 2020 11:21:12 +0000
Received: from DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::b41f:d3df:5f86:58f7]) by DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::b41f:d3df:5f86:58f7%10]) with mapi id 15.20.3632.018; Wed, 9 Dec 2020
 11:21:12 +0000
From:   Yahu Gao <yahu.gao@windriver.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yahu.gao@windriver.com
Subject: Review request 0/1: fs/proc: Fix NULL pointer dereference in
Date:   Wed,  9 Dec 2020 19:20:59 +0800
Message-Id: <20201209112100.47653-1-yahu.gao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To DM5PR11MB1674.namprd11.prod.outlook.com
 (2603:10b6:4:b::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-ygao-d1.wrs.com (60.247.85.82) by SJ0PR13CA0086.namprd13.prod.outlook.com (2603:10b6:a03:2c4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Wed, 9 Dec 2020 11:21:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bf918a0-3d62-4333-db27-08d89c348929
X-MS-TrafficTypeDiagnostic: DM6PR11MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3515AE22DE7A17929F06EC8999CC0@DM6PR11MB3515.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7dxISkIr0XSHwM8Faj5d3bskfZ5kCMFWul2i2/cCtj1xzj7SmgAl+Yz1f/SqVO5wg41JN5TQPjvcYruIv3i0urq2sCXH09CYWB2Xvun58gg5xTKRJ+07lVzg1UTXBjkIejLW/zbdKmy9Grcr7+y3vGrNMz3fejeos/y0/eKSrYQDQLeAG7Bq/ewBftHPBAsIAX7Lb8OUDKWiLrxTQQ4Hs8GIszgFmcQiWiSVX53BEboN3cpMkU97ZlTMOkxQg201/g7oPJsHSlcWmt3jN1hR+625gvihLVvwAHvH4Wqn7AD0ud2elSSQk5kwTCvSnbPLEmtoC9F+2HMWkTpVLoGS14b1EWXFq4j0T3Vhv8xYVvprCe+iKbJlXLrCp3DCdl2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(5660300002)(66946007)(44832011)(16526019)(6916009)(508600001)(66476007)(26005)(186003)(45080400002)(6512007)(86362001)(4326008)(6506007)(2906002)(52116002)(66556008)(2616005)(8676002)(34490700003)(6486002)(107886003)(36756003)(6666004)(1076003)(956004)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Iv1DFBWi7c8lfMD829fWBzV9IUvQNZuVubalB97y25V5ZynSvPLDk8MQJaqU?=
 =?us-ascii?Q?vniAiNOMqxNCJ39eiUPUt2ZkPu5NcGv/UPvb0gtbYUfFB2rmSG01u78I8vtN?=
 =?us-ascii?Q?3VM3kLiUmL4LuS0R3EbBGLC9Me7G7pbZIsiVjgQfZ5E0toNoAg7rShDSKdRV?=
 =?us-ascii?Q?Am1GCAdBhovWTlGtx5Nxk33t0EmAaYzB/Zo4boK6zRuDUtgaMKVtjx9gnAlu?=
 =?us-ascii?Q?Akv5gJrmuVrYgSMUg+Y+8l8n1xlG8cDW9dLlWdoPmOgFj/KN5Fq3AXRuQCG6?=
 =?us-ascii?Q?J/nM3WsNkQfi7l/fpY7ZJ9UuZodxKQ1o0aOw8h7cdH6+eL3Y/GDFiMJrXW8z?=
 =?us-ascii?Q?CEby2VoyuYoZv6O80p7mSX2NrNo06J0QpLaLwbCjkCK/nhOQVzSjAvUYF74J?=
 =?us-ascii?Q?txDF6soG185XDP0hgD1WQMRsJxkKmjrPfHWJA1+50elCLuBXjGa35jhNBX5E?=
 =?us-ascii?Q?AUAav7ysdtQB8u6XXcLr/FKGOlTTtfIAzS3pZVAhIGY3Q6qsPk/gF4Xc89/w?=
 =?us-ascii?Q?rW7WAn8GvyO4oDYF0uM9VVFpIsAqhEKhc/NJoKbzOZT7RlNaSr3GvxP+MBNr?=
 =?us-ascii?Q?4I6e2Bbc1fNDwAPQUDf5rBPLRfFWOM3ziqYNkgxLVJB0Q9auAfhhwHfvDPZX?=
 =?us-ascii?Q?Gy3z/57/xS9whaz1md0TxDU1vqPlOHsSPH9SwUXfADUsmeyVVbHW19z+RTyX?=
 =?us-ascii?Q?mjF8I2U6/TIt0s8nr5oVnWGX59TBuriaJ4qfoXR5uDepO8qhwwWHwAN2yre3?=
 =?us-ascii?Q?6Z/xcvxN7GYzpfiVU/5Bra1oGuaxdE7Gse9rZ40SqiULk+l3QV4fHld2T0IM?=
 =?us-ascii?Q?gJLstbXhpwxr5cBnSq4fJ3VC2vxm6QmcLAFniZGRn8Kham6dvpCAprfTd9Fm?=
 =?us-ascii?Q?82Ar2iH/qQDFOtA3kdTi8KHYo/HEPoOoG56ROKuhGvE2xoPrCuu8yQ+DKBQE?=
 =?us-ascii?Q?V4TeHcullTk0b8WnKXrqbH/R3sYLHyIY6JcRuF1O7s4=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 11:21:12.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf918a0-3d62-4333-db27-08d89c348929
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/iRuc7IYZpRkbeJyS6VlvrWx5sps9bH53WCl/71CCr/kJT2v78y8OO3d/7lt9tpNNvHyed7EtE9Tn/ZFJ9v/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3515
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a kernel NULL pointer dereference was found in Linux system.
The details of kernel NULL is shown at bellow.

Currently, we do not have a way to provoke this fault on purpose, but
the reproduction rate in out CI loops is high enough that we could go
for a trace patch in black or white UP and get a reproduction in few
weeks.

Our kernel version is 4.1.21, but via analyzing the source code of the
call trace. The upstream version should be affected. Really sorry for
havn't reproduced this in upstream version. But it's easier to be safe
than to prove it can't happen, right?

Details of kernel crash:
----------------------------------------------------------------------
[1446.285834] Unable to handle kernel NULL pointer dereference at
virtual address 00000008
[ 1446.293943] pgd = e4af0880
[ 1446.296656] [00000008] *pgd=10cc3003, *pmd=04153003, *pte=00000000
[ 1446.302898] Internal error: Oops: 207 1 PREEMPT SMP ARM
[ 1446.302950] Modules linked in: adkNetD ncp
lttng_ring_buffer_client_mmap_overwrite(C)
lttng_ring_buffer_client_mmap_discard(C)
lttng_ring_buffer_client_discard(C)
lttng_ring_buffer_metadata_mmap_client(C) lttng_probe_printk(C)
lttng_probe_irq(C) lttng_ring_buffer_metadata_client(C)
lttng_ring_buffer_client_overwrite(C) lttng_probe_signal(C)
lttng_probe_sched(C) lttng_tracer(C) lttng_statedump(C)
lttng_lib_ring_buffer(C) lttng_clock_plugin_arm_cntpct(C) lttng_clock(C)
[ 1446.302963] CPU: 0 PID: 12086 Comm: netstat Tainted: G C
4.1.21-rt13-* #1
[ 1446.302967] Hardware name: Ericsson CPM1
[ 1446.302972] task: cbd75480 ti: c4a68000 task.ti: c4a68000
[ 1446.302984] PC is at pid_delete_dentry+0x8/0x18
[ 1446.302992] LR is at dput+0x1a8/0x2b4
[ 1446.303003] pc : [] lr : [] psr: 20070013
[ 1446.303003] sp : c4a69e88 ip : 00000000 fp : 00000000
[ 1446.303007] r10: 000218cc r9 : cd228000 r8 : e5f44320
[ 1446.303011] r7 : 00000001 r6 : 00080040 r5 : c4aa97d0 r4 : c4aa9780
[ 1446.303015] r3 : 00000000 r2 : cbd75480 r1 : 00000000 r0 : c4aa9780
[ 1446.303020] Flags: nzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment
user
[ 1446.303026] Control: 30c5387d Table: 24af0880 DAC: 000000fd
[ 1446.303033] Process netstat (pid: 12086, stack limit = 0xc4a68218)
[ 1446.303039] Stack: (0xc4a69e88 to 0xc4a6a000)
[ 1446.303052] 9e80: c4a69f70 0000a1c0 c4a69f13 00000002 e5f44320
cd228000
[ 1446.303059] 9ea0: 000218cc c0571604 c0a60bcc 00000000 00000000
00000000 c4a69f20 c4a69f15
[ 1446.303065] 9ec0: 00003133 00000002 c4a69f13 00000000 0000001f
c4a69f70 c35de800 0000007c
[ 1446.303072] 9ee0: ce2b1c00 cd228000 00000001 c05747b8 c05745cc
c35de800 0000001f 00000000
[ 1446.303078] 9f00: 00000004 cd228008 00020000 c05745cc 33000004
c0400031 c4a68000 00000400
[ 1446.303086] 9f20: beb78c2c cd228000 c4a69f70 00000000 cd228008
c0ffca90 c4a68000 00000400
[ 1446.303103] 9f40: beb78c2c c052cd0c bf08a774 00000400 01480080
00008000 cd228000 cd228000
[ 1446.303114] 9f60: c040f7c8 c4a68000 00000400 c052d22c c052cd8c
00000000 00000021 00000000
[ 1446.303127] 9f80: 01480290 01480280 00007df0 ffffffea 01480060
01480060 01480064 b6e424c0
[ 1446.303143] 9fa0: 0000008d c040f794 01480060 01480064 00000004
01480080 00008000 00000000
[ 1446.303150] 9fc0: 01480060 01480064 b6e424c0 0000008d 01480080
01480060 00035440 beb78c2c
[ 1446.303156] 9fe0: 01480080 beb78160 b6ede59c b6edea3c 60070010
00000004 00000000 00000000
[ 1446.303167] [] (pid_delete_dentry) from [] (dput+0x1a8/0x2b4)
[ 1446.303176] [] (dput) from [] (proc_fill_cache+0x54/0x10c)
[ 1446.303189] [] (proc_fill_cache) from []
(proc_readfd_common+0xd8/0x238)
[ 1446.303203] [] (proc_readfd_common) from [] (iterate_dir+0x98/0x118)
[ 1446.303217] [] (iterate_dir) from [] (SyS_getdents+0x7c/0xf0)
[ 1446.303233] [] (SyS_getdents) from [] (__sys_trace_return+0x0/0x2c)
[ 1446.303243] Code: e8bd0030 e12fff1e e5903028 e5133020 (e5930008) 

