Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1C7B6ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjJCNs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjJCNs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:48:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05EAD
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 06:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhpQxlan4vCBbW10L7y6iD6LyJV8eoiodtDgSgfjDZa4V11BmZ4lQNnMEZsSJEMdCd7mv8t6iIHgMFmucQqC8nQD3FOU1Zp0NSMYLWGAhtzjvnaq9A+hp3wnVXJeSF/btq/zaRr8+hr02SfIFNPxfaoozVGsApTh64NCZuF9HJOw2T1cVbDf2260fFcRwIPOfpdDiTfE0XzeIYSTZJAprutJPwS4PdqLvhKBip8gs6+iHeBGadZtfSqSCHMCf1LGC6zZNarePCxvNs3+MK8s2qxzKawdcyq/ONtcat3zaYeYv+QnQ5+k5DF0B/L6Xndlfy/SYg2CKTAa+Iy8BG0r/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7mUJOvfbq3xx2kWSPdGpryX+/g+fmXYnXeQRqbE7Cg=;
 b=VBGKGWgPGMyEWlfkUEfOLTTlvIwrgfVE9SH/Fm9QfOzQfUCbpa7Fq3JPKyp7ilixr7IcO2IooG9+Bog9M8rWRdEfmQ6CgAjr3EbZJLtWYOe6WKbD1AjfM6vJxFsFD7EZ0OHOjBu/gBRCOTcnJlM5KaReppu5ev2XfsTp5niUcwIntV/iXNaWyblAXiMuR46nNg0QXNvWYNopytBOl3DNFw2dGYlRn82TNLOlTBIGav8A9rnkwvR0fHhIn6QfCL9kdSJhlLreCMog+xqCrHCSGnkbKMDHZwROC1vsnB/e6YW1aUHnZf/4+Kmez6mbPwpaDEwlg4Gq0fVbaYVsL+1Qsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hycu.com; dmarc=pass action=none header.from=hycu.com;
 dkim=pass header.d=hycu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hycu.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7mUJOvfbq3xx2kWSPdGpryX+/g+fmXYnXeQRqbE7Cg=;
 b=HwxAG8wK7KNSdUoVfgo6UUrWq1Lz+VA7NagEnqQpm2shasEHVBv+g6LOQdhGfYx3pnn189J4Wx+2CyNjzkcnOVc+gXfaNlQV0w1w4cjiTp9arefvBmeJIFpALwIHf8+cNc0Xkqi1nWFE14WudjBqcPTkBiID34f71kGb8eJT0T/MVrxCony1E//ZfFPCz7ukR/S/d3W7eODV2YTm9EdNyTEHLu9LEm2HdT1IjX1x1n5Ryj3W+Kv4VU+Az/AlYpoGc8++OAQZsofJlb1+owZynWAA4Bq12eF5kT6cUG6ke3q3PXrNmJpaZ10senZ4mveMeqFU0vV0V0LiIQLQbcb1Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hycu.com;
Received: from BY5PR14MB4145.namprd14.prod.outlook.com (2603:10b6:a03:20e::20)
 by DS7PR14MB6857.namprd14.prod.outlook.com (2603:10b6:8:d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 13:48:19 +0000
Received: from BY5PR14MB4145.namprd14.prod.outlook.com
 ([fe80::76e8:8294:f42d:11a6]) by BY5PR14MB4145.namprd14.prod.outlook.com
 ([fe80::76e8:8294:f42d:11a6%6]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 13:48:18 +0000
From:   antal.nemes@hycu.com
Date:   Tue, 03 Oct 2023 15:48:14 +0200
Message-ID: <95d6033195a781f81e6ad5bd46026aae@hycu.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>
Subject: [BUG] soft lockup in filemap_get_read_batch
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0057.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::6) To BY5PR14MB4145.namprd14.prod.outlook.com
 (2603:10b6:a03:20e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR14MB4145:EE_|DS7PR14MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7e7a1f-5781-43d8-8522-08dbc417666d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKw8Zu4xuIECIk/+NUsyXDcdNdRWWYrSyfzPKqUGSllszGbcmOAXH5FO+5U0jEYkKLYJVsw6zfWEWy1b2XZanc5WFT2WdEtVHjAPu+CKL6zCxwDtmhkniRNEUUEZ2z5FSxQd3lbu5JqZ/6BlXc6CGoUMKBPX5Po0hy9mLrWbZNyDcnnDTOto1bsBJfl1pnYmjszCUFDMwxXjgFQaoYcCqN0KMndJrq7LiWqAks5fzo915yXuch/xkly35D/+TM2dN+TTVZP8wm6vxj4z9wcLDdfML2ntvW/kmPVtzk4NCNPLLs/TP5MGDODmmrspgl0FGXf2vWQEr1elS+Kh73cWEVqv1vSYrgkaCAj9dM+lj0EB/fEf0OYTGVPj5eJ9kxvRkhNPrbeC/M2tu3K703LvIMpoNhCkB+zzSjDBbEsVPGFTRDZyZxFy0XiL6/dqqnD7/fvlKNV8fsBklya7feB1yNiEqxOGM3+gU7M1hBxys0+6t9TrcheOOjoYiMAYqTibh99OpHW7CTE1lqnkeIMQeTBdCmMw7nnLRpD5gVUovrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR14MB4145.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39850400004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(66556008)(316002)(66946007)(66476007)(6916009)(9686003)(36756003)(4326008)(26005)(8676002)(8936002)(41300700001)(2616005)(108616005)(966005)(45080400002)(6506007)(6666004)(478600001)(83380400001)(55236004)(24736004)(38100700002)(6512007)(86362001)(6486002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?poglTEGnfSFP6BXmHRxJlAo4pjsmPwdsZ29dIzg2WY8dPJDZfhACDjrJxdlP?=
 =?us-ascii?Q?Dq0dIlK7ai1lqBvpzRSL07iJb5tT8tTZfg92+RoqfMB+1ygkfJz3mF/KJ7op?=
 =?us-ascii?Q?hBqwvsmSsetjDjdxaAnKiF8LGdkomO/KLSfRU6+tw+F7Mg+prAgR5AqGxh6S?=
 =?us-ascii?Q?z1rgpS/4UI+M1MNymMNP+si8HvPP/gwjkrvoRlTIhqZ3oHhK+3DYfYr8WUYt?=
 =?us-ascii?Q?E7a0XFpu7IGmLIQx1jpgclV8BLC7VptjLyQhN4f0U2bAu8NY7yotOaJO+Z9O?=
 =?us-ascii?Q?G7vD4sbHnomcQyQimbCDivCHw6b5+ngkZvAu/ya/YfiSaze59UdxhJa4UbCz?=
 =?us-ascii?Q?IY3RjsA0zkxOVeMprmCBQCzYqgBm1lBBwwIH+a1CUSImPCyfgWTerc6Mx2b1?=
 =?us-ascii?Q?yGuosDCcCZCkxV2KMO/UDpIo03RAyIp9aklCqE/WIobJoJ80DrwmfJu9dPJw?=
 =?us-ascii?Q?3ZiuCc7Ncxprafom5E+Ak/Nyru8MhZSJIbwBjHLzeGK980MaXIFotlIhKjHs?=
 =?us-ascii?Q?rjcznOyD9zbBAir84JLwoXREemlsTP05Ap//uGskTuGrL4UDjaptBTWCxI4B?=
 =?us-ascii?Q?yOWdxhIkohYvvs3eaUX6n01yefLP8ztSBUUGibOjFlpdAkVPJb4JsV1hTCcb?=
 =?us-ascii?Q?2/GpZd8UVdwXyH/PgZvx03LAfad7Nk93vk9m5ShTS0hnBCgZI+4mi/FOpIMY?=
 =?us-ascii?Q?HvQYt8tUPA0kEMGl0IEFgdLCI4i+X8OA6UpIC93ewE+CUhnSOUwgn1ecllQD?=
 =?us-ascii?Q?/3MkGYJWe0pJAVC0hcjAoZCr9RpztG0S7OoQGjDn2k7jP0wJypmJBbAWEbWt?=
 =?us-ascii?Q?cPkirjBf8bOpnAvpco9x9S7XZ7nwHiM1xbGxhvLlDIATikOZSLlkY7RUTKtY?=
 =?us-ascii?Q?wTI2alU0vk+rHKaZ4tAq5n4re1yrEvs6parhoHvawWeda3zTpAWXY4dZ7ro6?=
 =?us-ascii?Q?k4x/+uBg0vXdkDNc0zl3CzvrXHQ/JwHE6F0ZUy1JP/l4Lf4seJBEz2wzgq4m?=
 =?us-ascii?Q?McNkisou4gUrPEXrC4eqI/TPZv50ZqD8MSljW5ouKYzSayiKoIQoi7myu79K?=
 =?us-ascii?Q?BOUY8LT8o196kgJvxqOAzWBfl/Ud6tfxN9MHnU8Om8zY1kbs323VW8voLN63?=
 =?us-ascii?Q?sLTpzjfzKv40mGFUqpZFaN7z2zdG+jBD+M1gxed96RUQEw0tgO1hNRg0+cat?=
 =?us-ascii?Q?Fq6LZgO+pJ8zi3Hv06rUdvYqO3nva0PffPsjQXYaslNbUwAWoGC9c+Pqsf9i?=
 =?us-ascii?Q?GcQoBRJN9Hhd9tXazXy1vAxqRbZKtIPOmhb3ajGY8N6RoBVcZuth6sHy1Efy?=
 =?us-ascii?Q?hrkZjhBp51lrnv2kSm7gJb8C1MjTgXQ4FB0sKBYruvAqRuQcBlFar58THEi5?=
 =?us-ascii?Q?QR7I1mXAR/gk7bCENCr9LQzJRtkgj4xg1Reg6bJ4DCzCnUf5OIhiDZgGop3F?=
 =?us-ascii?Q?J7fV8+MPRARQsxuuS5OXLx/1p5zGlVDo6JDsamSH19pG1N4SN5l6R/nMYWw1?=
 =?us-ascii?Q?npom7xJGJe2epryN1E0ly42WcT99tOMc1scku3Fph36lmcenHT1/8VpN//rm?=
 =?us-ascii?Q?fTEhNXqdQGa26Ecegt0luvCao1a9aeL6p0yR03Cu?=
X-OriginatorOrg: hycu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7e7a1f-5781-43d8-8522-08dbc417666d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB4145.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 13:48:18.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a2bad164-be70-4a5f-9b9b-cd882b76486c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HZReKVGA2kEK8daI1BGMwR6u5LY7ahT1MtkBtQtFoKgTq89w/Ocr3pTqT3KzSjPaF68qFLSi3p2hjBtBgw/KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR14MB6857
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

We have observed intermittent soft lockups on at least seven different hosts:
- six hosts ran 6.2.8.fc37-200
- one host ran 6.0.13.fc37-200

The list of affected hosts is growing.

Stack traces are all similar:

emerg kern kernel - - watchdog: BUG: soft lockup - CPU#7 stuck for 17117s! [postmaster:2238460]
warning kern kernel - - Modules linked in: target_core_user uio target_core_pscsi target_core_file target_core_iblock nbd loop nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache netfs veth iscsi_tcp libiscsi_tcp libiscsi iscsi_target_mod target_core_mod scsi_transport_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua bochs drm_vram_helper drm_ttm_helper ttm crct10dif_pclmul i2c_piix4 crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_balloon joydev pcspkr xfs crc32c_intel virtio_net serio_raw ata_generic net_failover failover virtio_scsi pata_acpi qemu_fw_cfg fuse [last unloaded: nbd]
warning kern kernel - - CPU: 7 PID: 2238460 Comm: postmaster Kdump: loaded Tainted: G             L     6.2.8-200.fc37.x86_64 #1
warning kern kernel - - Hardware name: Nutanix AHV, BIOS 1.11.0-2.el7 04/01/2014
warning kern kernel - - RIP: 0010:xas_descend+0x28/0x70
warning kern kernel - - Code: 90 90 0f b6 0e 48 8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 <48> 3d fd 00 00 00 76 08 88 57 12 c3 cc cc cc cc 48 c1 e8 02 89 c2
warning kern kernel - - RSP: 0018:ffffab66c9f4bb98 EFLAGS: 00000246
warning kern kernel - - RAX: 00000000000000c2 RBX: ffffab66c9f4bbb8 RCX: 0000000000000002
warning kern kernel - - RDX: 0000000000000032 RSI: ffff89cd6c8cd6d0 RDI: ffffab66c9f4bbb8
warning kern kernel - - RBP: ffff89cd6c8cd6d0 R08: ffffab66c9f4be20 R09: 0000000000000000
warning kern kernel - - R10: 0000000000000001 R11: 0000000000000100 R12: 00000000000000b3
warning kern kernel - - R13: 00000000000000b2 R14: 00000000000000b2 R15: ffffab66c9f4be48
warning kern kernel - - FS:  00007ff1e8bfb540(0000) GS:ffff89d35fbc0000(0000) knlGS:0000000000000000
warning kern kernel - - CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
warning kern kernel - - CR2: 00007ff1e8af0768 CR3: 000000016fdde001 CR4: 00000000003706e0
warning kern kernel - - Call Trace:
warning kern kernel - -  <TASK>
warning kern kernel - -  xas_load+0x3d/0x50
warning kern kernel - -  filemap_get_read_batch+0x179/0x270
warning kern kernel - -  filemap_get_pages+0xa9/0x690
warning kern kernel - -  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
warning kern kernel - -  filemap_read+0xd2/0x340
warning kern kernel - -  ? filemap_read+0x32f/0x340
warning kern kernel - -  xfs_file_buffered_read+0x4f/0xd0 [xfs]
warning kern kernel - -  xfs_file_read_iter+0x70/0xe0 [xfs]
warning kern kernel - -  vfs_read+0x23c/0x310
warning kern kernel - -  ksys_read+0x6b/0xf0
warning kern kernel - -  do_syscall_64+0x5b/0x80
warning kern kernel - -  ? syscall_exit_to_user_mode+0x17/0x40
warning kern kernel - -  ? do_syscall_64+0x67/0x80
warning kern kernel - -  ? do_syscall_64+0x67/0x80
warning kern kernel - -  ? __irq_exit_rcu+0x3d/0x140
warning kern kernel - -  entry_SYSCALL_64_after_hwframe+0x72/0xdc
warning kern kernel - - RIP: 0033:0x7ff1e5b20b25
warning kern kernel - - Code: fe ff ff 50 48 8d 3d 0a c9 06 00 e8 25 ee 01 00 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 f5 4b 2a 00 8b 00 85 c0 75 0f 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89
warning kern kernel - - RSP: 002b:00007ffe1a5d8d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
warning kern kernel - - RAX: ffffffffffffffda RBX: 00000000035345c0 RCX: 00007ff1e5b20b25
warning kern kernel - - RDX: 0000000000002000 RSI: 00007ff1dc9c3080 RDI: 0000000000000032
warning kern kernel - - RBP: 0000000000000000 R08: 0000000000000009 R09: 0000000000000000
warning kern kernel - - R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000002000
warning kern kernel - - R13: 00007ff1dc9c3080 R14: 0000000000000000 R15: 0000000001452148
warning kern kernel - -  </TASK>

Lockup is always reported from postgres process with all data and config on a XFS filesystem. 
Because this blocks a postgres process, lockup has a bunch of knock-on effects 
(invalid page errors, hanged or aborted transactions, tuple accumulation, etc). 
All occurrences eventually required a reboot to remedy.

Issue coincided with our rollout with the 6.x kernel. Previously we ran Rocky 
Linux 8 with 4.18.* (clone of RHEL8 kernel), so I recognize that this issue may 
not be new (AFAICT, livelocks were sporadically reported since folio merge in 5.17).

Issue takes anywhere from 2 days to 30+ days since boot to materialize, and lockups
are reported for duration ranging from 1min to 7 hours (the latter until it was 
manually rebooted). This is followed by a  period of relatively high load averages
(~2*#cpus), but low CPU usage. Memory usage was < 70%, so it does not appear 
to be a high-psi condition.

We are unable to reproduce the issue at will (i.e. by load/stress testing), but
the affected hosts have had multiple occurrences across reboots, so we should
be able to observe effects of any patches over a longer span.

From what I can tell, this appears to be similar to what was reported in
https://lore.kernel.org/linux-kernel/CA+wXwBS7YTHUmxGP3JrhcKMnYQJcd6=7HE+E1v-guk01L2K3Zw@mail.gmail.com/
and 
https://lore.kernel.org/linux-fsdevel/CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com/

> > We also have a deadlock reading a very specific file on this host. We managed to
> > do a kdump on this host and extracted out the state of the mapping.
>
> This is almost certainly a different bug, but alos XArray related, so
> I'll keep looking at this one.

I am not sure if the deadlock that Daniel observed matches our stack trace. 
Assuming yes, has there been any follow-up on this?

We tried the patch from https://bugzilla.kernel.org/show_bug.cgi?id=216646#c31 , but the
soft lockup reoccurred with the same signature.

Is there anything we can do to further aid in troubleshooting? If this is a folio
lock issue, would it be possible to trace where the lock was taken?

Best regards,
Antal

