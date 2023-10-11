Return-Path: <linux-fsdevel+bounces-64-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741437C5524
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58D61C20E1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4A1F92A;
	Wed, 11 Oct 2023 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hycu.com header.i=@hycu.com header.b="Hex6gPN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF41F5E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 13:21:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2118.outbound.protection.outlook.com [40.107.220.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25F98
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIFoZWoC6Eaxif+QRoawviknlKCqKRyhOURSufuyA7bUG1V87REE+FgluYOv4UtRY0gTALlxv7fibhobeSSmCX13Q+Vm8Z4UEozepnmjVSL/0qJ9tQmG99HY6mMFEx2p2/wx2zyVlA+lPwXMK0sBJOtsmwj+aMr5sAQQQUmbULkN82LL44BzPY2q0yI18Y+YYwWWLOJnktFB1oucJRKvmkvksE/TqPUy9/LUQXXcmUGaRH4dhzX4gu5d6xBbGkoigvcFw7PEPvkrdL3oi3qTBRNFdA4YG3P6JxMO1VGPTMdNyV7ZUg3Zjn6knMl02Nl8m8btN8bIHBRdV47hFnI2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhg4Hrxskjoa7cisQGlW7Yxo1pWa5BomGeDH1XgTj+g=;
 b=nyc8FZf3QQ90x9m1Vr850ladP5zWJQd8vtKmruARLAimg97KIegnJU0oYKyWRiuNHJRjhDWLXRqRz0t12SCfrQkywfk0ZICad695U9O46TQaFdzqO90krc5nU3DTKdgzuibvxHPNlywyuHR4zL1fDpMbP00pEieDAmbZmQXy0woGUs40UeW1hb5jOzSS2cKCoAZ0mwhRdhzkhAlgH6hStd2PKSAKcI3LpBcRenr23CUXtTGG2RdMYSSh6meVUX8JHC0PGqEX8M4diC823uUTjFJUy1MK3HpBuCadUDlKY/DvZmP01D+UjornE3np0cZiLN+7jhyNcmVzWwso/641Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hycu.com; dmarc=pass action=none header.from=hycu.com;
 dkim=pass header.d=hycu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hycu.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhg4Hrxskjoa7cisQGlW7Yxo1pWa5BomGeDH1XgTj+g=;
 b=Hex6gPN2QUOQmBzNXrz3nkaBUNotBKlcWR7g2pkqGL1ATGU/J8hr8nGTwwUotpkjs5/g4FpcMPAb7UA44rpUFaXcw8lI2O/MY+dcK4Qhm5lnZbW7R8l2NcjRKBMT9CbLxACW8/t3HedpXGqZwqtnyXG5kpe6vkdijLpM3+HKVw1Zggfd0FDxMQi7IyYIQfVNgNmztA34MuOPKnVxRDVZ2ItpUNrswfh1ZqMBQTF0+nAzJsaDxUUgUMkDu2DymuOMVtCTy6LHXoefSvwzuHm8phDVSIhpOs4Ge/BfcROBBrXbrkBdM2Cy1QmU7AhFw9fy4xekLSlT8fa/nls/+2l9tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hycu.com;
Received: from BY5PR14MB4145.namprd14.prod.outlook.com (2603:10b6:a03:20e::20)
 by SJ0PR14MB4742.namprd14.prod.outlook.com (2603:10b6:a03:374::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 13:20:57 +0000
Received: from BY5PR14MB4145.namprd14.prod.outlook.com
 ([fe80::76e8:8294:f42d:11a6]) by BY5PR14MB4145.namprd14.prod.outlook.com
 ([fe80::76e8:8294:f42d:11a6%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:20:57 +0000
Date: Wed, 11 Oct 2023 15:20:52 +0200
Message-ID: <5b9ab143618b2d5bfeeed4619a34c7a8@hycu.com>
From: Antal Nemes <antal.nemes@hycu.com>
To: Antal Nemes <antal.nemes@hycu.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>
Subject: Re: [BUG] soft lockup in filemap_get_read_batch
Reply-To:
In-Reply-To: <53bb6e7a159cef2942e0e4cd9509847a@hycu.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::37) To BY5PR14MB4145.namprd14.prod.outlook.com
 (2603:10b6:a03:20e::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR14MB4145:EE_|SJ0PR14MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b26512-6c9a-4c5b-a86a-08dbca5ce73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Sn6l/xupXby0zyd2VN5Rdc0yy8hXvPKTSYpBIK5Zmt6FHwX88VF/Lyu47ZgP6TTD+uTSDBN/c1T6j7t8US67l4RiqyKHBbp1mDpneER+QTTukgrGLwqjI6sr8m8KzGFxsdIKE78xIh/Ts+lNDc/yErHK+INStZwIuzCYTWr98+akXxQvVOSd3BC4NcjYWf0S7K2on8K1EPD4j3/2s9DKX/gE99j5ftguHX9W3mQJxAISsHXnKCNxnS1jCp3yvj9AkrzeYsj5t84pOmD/ZVIvozNR0GTXKHxA9oS7YBfnlHoY9d7QOy1CrWT8NhZvc4zR0A4fqciMN/rz6nf/lpAZU/7JuFD0krkUFs62mtYwBMlsdMt7RSKirPLLc9s6RLJOcKbSj50ATYwVxnWp0hzqgWiPI1bBgXrAGTB3lyD4c78/WJCYiJlEYlmDFmhdb3XozlZhsGmdXZIvRd6evpiUB04WLdzCmQ5q/5g88VefCgNcQNw0QCQc3GMU1N7DbXP4INMq8IINN1cYhBH13yn73G4mfra8V3pf3ROoUJvZdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR14MB4145.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39850400004)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(2906002)(41300700001)(6200100001)(66476007)(66556008)(66946007)(37006003)(54906003)(86362001)(5660300002)(8676002)(4326008)(6862004)(44832011)(8936002)(966005)(6486002)(55236004)(24736004)(6666004)(478600001)(6506007)(108616005)(38100700002)(36756003)(83380400001)(6512007)(45080400002)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHtr4GXE82NaXa3FDpa7vzLgDC7CEYY8jY2bShi65AaXElFK1fEnNYfc6zei?=
 =?us-ascii?Q?uh6fb0NbMsM7IZPa3uZDg58qwUg0vFkb+4lnkSZPQ/2NbvXk+VPeB75YTgJb?=
 =?us-ascii?Q?oTckxUSzj/QBml4Ns39nSWlKs6LRK2zvPtx16QjqSW4Kuua//WIg57ffOQa0?=
 =?us-ascii?Q?eVF9EpliKTilb6EBA1euUvl9Lb+8MZoVXFWknQoIXSB+XiOtlctxpOdWKuAc?=
 =?us-ascii?Q?zuaU1zskheB0jW7lfmJU/BAAOzz/7YKzMxuW9S+5tbaOo+UgZs3m1azOuV7d?=
 =?us-ascii?Q?VD+nN5ulWROFEeyDjY8mK41K0q0JKoiQkaqZlWx8KZVYWr6sFNyEinP14x7n?=
 =?us-ascii?Q?79qaPNx6CtaJ/U4C3fwrEiyFEad6hqz0PFtCmoD2+MIMF5vPm/ywAiRtOA7F?=
 =?us-ascii?Q?DNAOZTSLjfIYdO6lnMI0ryFuj25q0yoV4QiCvuYp9mBZfwp5zF0oapvDHq1d?=
 =?us-ascii?Q?U1SndOF9xRtOcbkUA6b/M7Kh1JSsKUzmG80yMRc5nzx4IkNRVCDeqVUf1sRh?=
 =?us-ascii?Q?KFYzMgnaKi5ncIiANsM9tfAfSokgyqdPNwoy0Ql6WYZRsOGHUZVakOUGOmC2?=
 =?us-ascii?Q?D7s5yyztYa7KZ/pzFEDFZPavZAiJc/kLhCEbKQo820TKN8qR27rXmg56puNS?=
 =?us-ascii?Q?siquTlC7rp6VoPb9GRpZR32VqeIQn4+X0EuIiy1J0uE+nD30tHUdXdjBZp9O?=
 =?us-ascii?Q?PKstLdEd6sVIPzV6dlgRn4WJVc8J27EiWuM7Smprfdwug2fsmB+gcTxH6XxJ?=
 =?us-ascii?Q?Z4wEPkFij2zjAVF/6BSujbHPrKkDeGLWFjtOEmHFPXUvutH/EAONoG6z/kgk?=
 =?us-ascii?Q?cdqETouSl58G5qNFHz9FCCRHPKBsKDBGe7SDyu5JQE2ZC3NhbMA6Pqdor+g0?=
 =?us-ascii?Q?5uAa7naBrs1A9BbXkLeR0OA0F4wRRPDTLrspW9ZMhD0PEvjLijHZt6sW/qP2?=
 =?us-ascii?Q?7VGJdAWlVq6EUn2WTHUvTgb2EskLgNl7U/Hh/ucfv0O5Xz/oITFF+ecXNnLA?=
 =?us-ascii?Q?R0+7bB/MTLdy3v3uC2iu91w+hSoLeEr57ssQhA00CEYeVId+7Xcqe6UiGfV9?=
 =?us-ascii?Q?LGUvR50XyLNMNSgzFpxGbwPTpZz8g8aaSPcLvPbHGO7gJI8+MXO4UEAeQPlJ?=
 =?us-ascii?Q?LkfoSKjeyf3HPWZqnYSA+bJru2vXd4LJ3H+aaUHdNo7yQhO6EYsk5CwKuwQ2?=
 =?us-ascii?Q?7AdlrMEv+RVB/vMHMZxBN8B98YQuzpjHSf9UCm9rg60j3W+tThtpAoe3y+Vs?=
 =?us-ascii?Q?hnOdkjoODPm8Y95jLafSDeRpHq+Ah19ZUBmjENtkM3JghYXusRREw2PAjYqq?=
 =?us-ascii?Q?Nub6vM6HsscAIHxDtv1vL91SKr11ASZXnzAN7Tz7qaVYHDsaoP8oAo4SKr+S?=
 =?us-ascii?Q?QQ9RYxJmgMRzDZYhSPi6coLiUpQScZBEsAZdcMC4H/1iIu8pYKCEYh05TSgx?=
 =?us-ascii?Q?ftyJmX+yV6Wusw2nJR90ut5XS2KR3Iih0OEJXmIN7Cc5CTE8ZZ/v4b5ehGWy?=
 =?us-ascii?Q?O7JDopAwBl5k3aAZEMKE2gdmyC3WpCn82iSu7d+c/5D2MJqiTiQabvE8KMYm?=
 =?us-ascii?Q?RZw9Y4tNgNpKkWFEVcwcb8WAdildtQTaPC39olxe?=
X-OriginatorOrg: hycu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b26512-6c9a-4c5b-a86a-08dbca5ce73c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB4145.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:20:56.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a2bad164-be70-4a5f-9b9b-cd882b76486c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CLB7lw52cPUgKK+WTYO19up2XUnNHNnemDQiRU17o12HG/ncwvS8y++hdlrVJCoJtRBV540YRILmsq84OhAmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4742
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 10:36:33AM +0200, Antal Nemes wrote:
> On Wed, Oct 04, 2023 at 09:58:04AM +1100, Dave Chinner wrote:
> > On Tue, Oct 03, 2023 at 03:48:14PM +0200, antal.nemes@hycu.com wrote:
> > > Hi Matthew,
> > > 
> > > We have observed intermittent soft lockups on at least seven different hosts:
> > > - six hosts ran 6.2.8.fc37-200
> > > - one host ran 6.0.13.fc37-200
> > > 
> > > The list of affected hosts is growing.
> > > 
> > > Stack traces are all similar:
> > > 
> > > emerg kern kernel - - watchdog: BUG: soft lockup - CPU#7 stuck for 17117s! [postmaster:2238460]
> > > warning kern kernel - - Modules linked in: target_core_user uio target_core_pscsi target_core_file target_core_iblock nbd loop nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache netfs veth iscsi_tcp libiscsi_tcp libiscsi iscsi_target_mod target_core_mod scsi_transport_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua bochs drm_vram_helper drm_ttm_helper ttm crct10dif_pclmul i2c_piix4 crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_balloon joydev pcspkr xfs crc32c_intel virtio_net serio_raw ata_generic net_failover failover virtio_scsi pata_acpi qemu_fw_cfg fuse [last unloaded: nbd]
> > > warning kern kernel - - CPU: 7 PID: 2238460 Comm: postmaster Kdump: loaded Tainted: G             L     6.2.8-200.fc37.x86_64 #1
> > > warning kern kernel - - Hardware name: Nutanix AHV, BIOS 1.11.0-2.el7 04/01/2014
> > > warning kern kernel - - RIP: 0010:xas_descend+0x28/0x70
> > > warning kern kernel - - Code: 90 90 0f b6 0e 48 8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 <48> 3d fd 00 00 00 76 08 88 57 12 c3 cc cc cc cc 48 c1 e8 02 89 c2
> > > warning kern kernel - - RSP: 0018:ffffab66c9f4bb98 EFLAGS: 00000246
> > > warning kern kernel - - RAX: 00000000000000c2 RBX: ffffab66c9f4bbb8 RCX: 0000000000000002
> > > warning kern kernel - - RDX: 0000000000000032 RSI: ffff89cd6c8cd6d0 RDI: ffffab66c9f4bbb8
> > > warning kern kernel - - RBP: ffff89cd6c8cd6d0 R08: ffffab66c9f4be20 R09: 0000000000000000
> > > warning kern kernel - - R10: 0000000000000001 R11: 0000000000000100 R12: 00000000000000b3
> > > warning kern kernel - - R13: 00000000000000b2 R14: 00000000000000b2 R15: ffffab66c9f4be48
> > > warning kern kernel - - FS:  00007ff1e8bfb540(0000) GS:ffff89d35fbc0000(0000) knlGS:0000000000000000
> > > warning kern kernel - - CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > warning kern kernel - - CR2: 00007ff1e8af0768 CR3: 000000016fdde001 CR4: 00000000003706e0
> > > warning kern kernel - - Call Trace:
> > > warning kern kernel - -  <TASK>
> > > warning kern kernel - -  xas_load+0x3d/0x50
> > > warning kern kernel - -  filemap_get_read_batch+0x179/0x270
> > > warning kern kernel - -  filemap_get_pages+0xa9/0x690
> > > warning kern kernel - -  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > warning kern kernel - -  filemap_read+0xd2/0x340
> > > warning kern kernel - -  ? filemap_read+0x32f/0x340
> > > warning kern kernel - -  xfs_file_buffered_read+0x4f/0xd0 [xfs]
> > > warning kern kernel - -  xfs_file_read_iter+0x70/0xe0 [xfs]
> > > warning kern kernel - -  vfs_read+0x23c/0x310
> > > warning kern kernel - -  ksys_read+0x6b/0xf0
> > > warning kern kernel - -  do_syscall_64+0x5b/0x80
> > > warning kern kernel - -  ? syscall_exit_to_user_mode+0x17/0x40
> > > warning kern kernel - -  ? do_syscall_64+0x67/0x80
> > > warning kern kernel - -  ? do_syscall_64+0x67/0x80
> > > warning kern kernel - -  ? __irq_exit_rcu+0x3d/0x140
> > > warning kern kernel - -  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > 
> > Fixed by commit cbc02854331e ("XArray: Do not return sibling entries
> > from xa_load()").
> > 
> > Should already be backported to the lastest stable kernels.
> 
> The commit seems to be the same as the patch referenced in 
> https://bugzilla.kernel.org/show_bug.cgi?id=216646#c31 
> 
> We have been running 6.2.8 with this patch, but the soft lockup still ocurred.
> 
> >From https://lore.kernel.org/linux-fsdevel/CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com/
> it looks like there could be a different issue at play (locked folio with null 
> mapping)?
>

Daniel successfully worked around this issue by reverting 
6795801366da0cd3d99e27c37f020a8f16714886 (xfs: Support large folios).

We will follow suit for the time being.


