Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA27B7A2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbjJDIgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 04:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbjJDIgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:36:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2110.outbound.protection.outlook.com [40.107.92.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261183
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 01:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJpSwh7i5MS5biTsx3YxC+fUDVmZtNLrr2DjErY+Gy0/yyxi6t1m6Tt0+jvZwvDGW43GzeBfaluMARhBX+X1y4uJ6FWY5WPrS4l0msoOH5eVhhLYoF7vMMkZL9KWvYfEDbNLgbPeRD/91BeHEiq1ojAOw6Z3/IVZSrOAUdPxWuEoitUT3wURxyvQoAtzgtg3ASmu0mf1IJt+tomw+u6XzdU3g+RKfoy6vzNsA6On1LS5qeC/SFon45mkQ0TdjQegLXw9Mi+3BxwA2HGWu8tSA1FW8yOchzQ8gfeiHUmurDuamL7OkSGcDy2t4OqlgblcsASufxB73Q6/H7u5x0EwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUu8rgTUM+xG++tl9F4AxZqeGi7Nl6ReNsarKAmkk/o=;
 b=dCRapxd3BDxHl6J6VSMkQqAkwfQMeLuRzWltXl8AnaH/JOkApRjkrxQuZMXi8MzdM8t4f9GCN7wCJnr8OcwvLezk1Usz2kviyZat5UPP2Q9KJ/QWUl/jCFzRGkYJ1Xi+Mwg4ud1PreFsXDEkYU0PYr+LVbn0Rps6Dlx7IRfyw7K+oQsKFHWEDV0ztMmen8anvrT2Vofa6CT75VVe54nvqzUi6rtvzvjbGZ3BmY/CZNaLIB1/l5ClLoHs6iPJlM7XlS0mN65cpmRcw04+kOmFgNBYJ4l+72z0caw+TjTtOdb0PmguXBmia3U9QcSpBjAdw6ix4/Ud7A0CqAOrlDg2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hycu.com; dmarc=pass action=none header.from=hycu.com;
 dkim=pass header.d=hycu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hycu.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUu8rgTUM+xG++tl9F4AxZqeGi7Nl6ReNsarKAmkk/o=;
 b=oKUd5aLPes0ciUU4vRlwcfIIpvHSY6FiOwT6CIJRnGR2bEZkrCXEsZIG6+iAkc1X7xzNDkxDuxLHqCz1YJice0tlfVPxZ4MboQ8YPjBMQ4EbDoJ8ru0pL6ZqPbN14EqANhP/WN46UHiTccKqVCmkng/sVzkI4yFrLHPmW4yhhwLrFbq1vf8ciq1NaWSewynV0lW+zml+qVuZqsyXIo/MlaMX2r3ficDo3mhwUCEUopVO/uwwlIdc/jjVxxClu7zU+Z1V0GZUKCVTaZMb0vZZ/WCCIeReJAN1P39kTzQ7NuelHPR/FEjCa3XB4Mk+Lpee2JQDirQzNkYRtLgxxH1Vrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hycu.com;
Received: from BY5PR14MB4145.namprd14.prod.outlook.com (2603:10b6:a03:20e::20)
 by SN7PR14MB5896.namprd14.prod.outlook.com (2603:10b6:806:268::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 08:36:39 +0000
Received: from BY5PR14MB4145.namprd14.prod.outlook.com
 ([fe80::76e8:8294:f42d:11a6]) by BY5PR14MB4145.namprd14.prod.outlook.com
 ([fe80::76e8:8294:f42d:11a6%6]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 08:36:38 +0000
Date:   Wed, 04 Oct 2023 10:36:33 +0200
Message-ID: <53bb6e7a159cef2942e0e4cd9509847a@hycu.com>
From:   Antal Nemes <antal.nemes@hycu.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>
Subject: Re: [BUG] soft lockup in filemap_get_read_batch
In-Reply-To: <ZRycfLxGP1CSd/ud@dread.disaster.area>
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::13) To BY5PR14MB4145.namprd14.prod.outlook.com
 (2603:10b6:a03:20e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR14MB4145:EE_|SN7PR14MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: a9761720-9751-4df1-87b4-08dbc4b506e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbgVKLp4R1q9g6xs8ZVB0y5LMQWiMU8W8vBIyi8rJBVTStEtWZF9ZKrpTYrSFCpHlf91xzjzgBu5Z+vJyY+cTq2OTOlw7RPQaWRCO1ez618YLJRiTC8Gb/E7malbAihrOevPNl1AqhE+xzZrdIllMmrNGewzqrqwwmgkq/dJvekum0gXiXbn33P+3nTQR5sfJl24RDbAJlZPGwYjoBVgnxZMeD/7FzhWdBXj26gApqXLK8q5GghbI9AnvNBoonYw6WHZg+3w0sXo+7Heb/jRuc4F6xJSxWPAp7eVAE1gjeOvcgOXkLqGopjn/r2hzuwr/mP5V2ErBe8HWgIYOfGwRRE4J+mB2GC70FwIv5ktNsIP/iZYzjZZpubQK5NEFqSI3gVsSEvvED6AOhWtpp2Rtl5gS3ScKB3Gr+8XeLCjh4CUGrlcXtu6tIqW+LpK84mvjpg/kLz9H5AfEMEPTtLmxPu5ivAgj9kLPvm2qSBJ0Fegu9fHI80F1oVpiF1iCBaLInJREURuW6UrhZduuIC3syujCKB5w/aWXGQCilEjU88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR14MB4145.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39850400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(6512007)(55236004)(6486002)(6506007)(108616005)(2616005)(24736004)(45080400002)(8936002)(478600001)(316002)(44832011)(83380400001)(66476007)(6666004)(8676002)(66946007)(6916009)(5660300002)(54906003)(66556008)(26005)(36756003)(966005)(41300700001)(86362001)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KGkYM76f95RgkF0aR+AIJJ0kStLebCNrMMqOWFo/dMJYwhx8akjL0CXabYdm?=
 =?us-ascii?Q?nRUYsY6pdAluALX6qeZiCf8vFqd8Mh8CBPdnD5fO5Hc34IyX1FRYxIgMpu6O?=
 =?us-ascii?Q?zvZ+AiE7ppIVft4nhMMh5ArqZ4gEv+uMoZ7xvnldtLLBXfel1cEn6JHIDPrM?=
 =?us-ascii?Q?Glo33jkqukv6uEqI8yVOmAdqpFYaSXedNasKj1OVkojPzmMLRuxa7cOG8EbS?=
 =?us-ascii?Q?MMzmQPB2A6E9vS9ULCtTErri4X5MytWiJIJx7tOW0d6fs8zCiLzZ25i+sFWR?=
 =?us-ascii?Q?/t3JIT09kJWkV17NBxKlds6kxObSY2cJQzDagWMuBvQGCH9BWWtAz3sa0PY1?=
 =?us-ascii?Q?kkPySgBW943WHvwfe02UDeqtmVZndgR7+BWID29CGzvs/gC21sFNIrunibcP?=
 =?us-ascii?Q?Hzt2obFYqOBraSq4b3pRWK8op5LjjSi9aWWPyA3sOpfrs5yv60Pm9dbAuKCJ?=
 =?us-ascii?Q?vmBp1b7FavJTrDnojGsuqhwb5m21sEWcZFx6k+P21qr5rusE1INTCC8tlWR1?=
 =?us-ascii?Q?T1T+KvUGAq9IEJGr2CFvv9I+WvidjLsPfc1B7kzMIec3FRSl1MsVer7XRYm4?=
 =?us-ascii?Q?qSTeFDqf8XCPm0t3cMJREdD1tuX23qpw1pEoBnK8tlilWP2x7684JMg6rVjD?=
 =?us-ascii?Q?sC/HkTeJykgzbyhxbelAQfjq0/9s2sNxyIQNYHmWaxqQZDSDmC22FivLDS2q?=
 =?us-ascii?Q?DIJj1uSqXM/h1qzrlZOkUzEMYXEtHvcyAZcve2le/1yzqH4F5mLoN9fNR/2a?=
 =?us-ascii?Q?i+T1DDwIOzFAYNKvdezr7mjaPU12OE/JUU41nogKNxC9QbSKJX1+AJis+RLe?=
 =?us-ascii?Q?+JqmpC+hHyvHLLfRDUWsH2ZoEwqQTfWhvntvNvJ4M869sNf8ze+qzkMTicYF?=
 =?us-ascii?Q?ZHI4NiuYEZcjbpu3xK34RCPsdA/jAVbRVe4mz8RukccFIXP//wYXSRnUcUae?=
 =?us-ascii?Q?kHhDZYAApJqUREu3V6K5La1NoEPp2CC2VXgpTujNPYxAbUQ3fzfLgguf5TMD?=
 =?us-ascii?Q?CbZxTAU9urA5JvhecOVEchq0GYkGNPiMoSSXPRJOkmhL2JZ+FOlRc5I4Mwr/?=
 =?us-ascii?Q?pR84Q9MEDepaGSdjOkibaCNYQ0yHU5VCL4qTsG11OZ759XI+YBU/BNEpMwba?=
 =?us-ascii?Q?0TT8iO7J/xxg/rI8HyeQzPVTanVTiKYMdbto0b8kmJgAnHwxDixD+Qcf67Si?=
 =?us-ascii?Q?cJWJuIvIW1nKBhu9ZsREXTt263rTnlRYN8/aMGW/w0GoSqIW9M7tTc8Hhsix?=
 =?us-ascii?Q?JWVB5CopRrSwQRTY7QrqMqAYXt/55dv6stsalDvR8FrvcblwEsA958gvMD8a?=
 =?us-ascii?Q?1DdDt8Vwe7HQ4Fb3zwuVUBZvU7EREXLoyes3ymgex+upH5+l3SbAUl8SiSsz?=
 =?us-ascii?Q?oAF7r1UVYKGWObPf/vbXCUkpQXRlUKxXb1zprzx9gH5KVjj2wzGA0pXK8Sww?=
 =?us-ascii?Q?zMC6kXNWE81qtEby1z9VhROHm40smw+EHh/paaTXNFb4Kf5NXr0H/phPrVu4?=
 =?us-ascii?Q?t0kB/GZbVn6tmyYS67aaNM+Qb0k+GMu8N5iFEN5CLlhQ6Mqox2APBv6FMb6j?=
 =?us-ascii?Q?wbfvKU/yeRqt7TYjiTCzDuKmedM/ARBIPJtze/PR?=
X-OriginatorOrg: hycu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9761720-9751-4df1-87b4-08dbc4b506e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB4145.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 08:36:38.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a2bad164-be70-4a5f-9b9b-cd882b76486c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/sRiZkZslI84O8W35Hqm9V3UUYbEFi0UgzMEr8UrSfuNN70RXsH8fheZi3F5PfnUa4bLtF26NN/IZ2POTIs3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR14MB5896
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 04, 2023 at 09:58:04AM +1100, Dave Chinner wrote:
> On Tue, Oct 03, 2023 at 03:48:14PM +0200, antal.nemes@hycu.com wrote:
> > Hi Matthew,
> > 
> > We have observed intermittent soft lockups on at least seven different hosts:
> > - six hosts ran 6.2.8.fc37-200
> > - one host ran 6.0.13.fc37-200
> > 
> > The list of affected hosts is growing.
> > 
> > Stack traces are all similar:
> > 
> > emerg kern kernel - - watchdog: BUG: soft lockup - CPU#7 stuck for 17117s! [postmaster:2238460]
> > warning kern kernel - - Modules linked in: target_core_user uio target_core_pscsi target_core_file target_core_iblock nbd loop nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache netfs veth iscsi_tcp libiscsi_tcp libiscsi iscsi_target_mod target_core_mod scsi_transport_iscsi nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua bochs drm_vram_helper drm_ttm_helper ttm crct10dif_pclmul i2c_piix4 crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_balloon joydev pcspkr xfs crc32c_intel virtio_net serio_raw ata_generic net_failover failover virtio_scsi pata_acpi qemu_fw_cfg fuse [last unloaded: nbd]
> > warning kern kernel - - CPU: 7 PID: 2238460 Comm: postmaster Kdump: loaded Tainted: G             L     6.2.8-200.fc37.x86_64 #1
> > warning kern kernel - - Hardware name: Nutanix AHV, BIOS 1.11.0-2.el7 04/01/2014
> > warning kern kernel - - RIP: 0010:xas_descend+0x28/0x70
> > warning kern kernel - - Code: 90 90 0f b6 0e 48 8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 <48> 3d fd 00 00 00 76 08 88 57 12 c3 cc cc cc cc 48 c1 e8 02 89 c2
> > warning kern kernel - - RSP: 0018:ffffab66c9f4bb98 EFLAGS: 00000246
> > warning kern kernel - - RAX: 00000000000000c2 RBX: ffffab66c9f4bbb8 RCX: 0000000000000002
> > warning kern kernel - - RDX: 0000000000000032 RSI: ffff89cd6c8cd6d0 RDI: ffffab66c9f4bbb8
> > warning kern kernel - - RBP: ffff89cd6c8cd6d0 R08: ffffab66c9f4be20 R09: 0000000000000000
> > warning kern kernel - - R10: 0000000000000001 R11: 0000000000000100 R12: 00000000000000b3
> > warning kern kernel - - R13: 00000000000000b2 R14: 00000000000000b2 R15: ffffab66c9f4be48
> > warning kern kernel - - FS:  00007ff1e8bfb540(0000) GS:ffff89d35fbc0000(0000) knlGS:0000000000000000
> > warning kern kernel - - CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > warning kern kernel - - CR2: 00007ff1e8af0768 CR3: 000000016fdde001 CR4: 00000000003706e0
> > warning kern kernel - - Call Trace:
> > warning kern kernel - -  <TASK>
> > warning kern kernel - -  xas_load+0x3d/0x50
> > warning kern kernel - -  filemap_get_read_batch+0x179/0x270
> > warning kern kernel - -  filemap_get_pages+0xa9/0x690
> > warning kern kernel - -  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > warning kern kernel - -  filemap_read+0xd2/0x340
> > warning kern kernel - -  ? filemap_read+0x32f/0x340
> > warning kern kernel - -  xfs_file_buffered_read+0x4f/0xd0 [xfs]
> > warning kern kernel - -  xfs_file_read_iter+0x70/0xe0 [xfs]
> > warning kern kernel - -  vfs_read+0x23c/0x310
> > warning kern kernel - -  ksys_read+0x6b/0xf0
> > warning kern kernel - -  do_syscall_64+0x5b/0x80
> > warning kern kernel - -  ? syscall_exit_to_user_mode+0x17/0x40
> > warning kern kernel - -  ? do_syscall_64+0x67/0x80
> > warning kern kernel - -  ? do_syscall_64+0x67/0x80
> > warning kern kernel - -  ? __irq_exit_rcu+0x3d/0x140
> > warning kern kernel - -  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Fixed by commit cbc02854331e ("XArray: Do not return sibling entries
> from xa_load()").
> 
> Should already be backported to the lastest stable kernels.

The commit seems to be the same as the patch referenced in 
https://bugzilla.kernel.org/show_bug.cgi?id=216646#c31 

We have been running 6.2.8 with this patch, but the soft lockup still ocurred.

From https://lore.kernel.org/linux-fsdevel/CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com/
it looks like there could be a different issue at play (locked folio with null 
mapping)?
