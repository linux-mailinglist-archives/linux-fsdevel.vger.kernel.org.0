Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514423DCC8E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhHAQCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 12:02:19 -0400
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:12199
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232240AbhHAQCS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 12:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxJWqvvw7MuZ3sPC6aeORvNtJwqGnPT5Z0KBTHU8rKLU0QNA5n1bRPsdvS8jaQPlwdGtr9nSLC8a3V719TDha8/uMdJo4aVRStmvGkUjphX1v7tylFNNLlPxxg+ER1/raVYl06k03AE2wu4jc3sLbtoM5HYVfzJ12bWZtJfMtMikOwEOo4bwpp0SdgNPPa16ClYffi2jX8tDYjOAsN7T1QKv4aD3v2yGQ7S22q/LfR5B8q4PoxApiv3QklGPiIkJ25Wtox0061B2fe71E9l/YFeQz1KBJZiOfOAxsZYigQBm8g9MGGyORwHSGaiIGLktHyVBpDvWLAVut4WIRfS2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAfhg1yXWHGC1cbH3uO9p4dloP6puQJkVZWVdXrIs8g=;
 b=fXOhebWJozH98hxfmyjxd93JF1VM5BEcfKTX/ZRL0khQZSidcisJbnqs6v7jaZIjPggC6UCdzi4dr6Tp4i+u5VrUcMJtXP1xWNlvUkg4Q9ks4bFPNXxK4hL97wCgR/Nyv9kGUcOLHjn6I7FNc3YQUkTMBNrzMJeDF7Z/iWtKpwfIVtm3Kr2a/oPpmVQpSDB+4Pva9f+GAHyQdMg40woUhgmcD3Tq2R7qJJZ1Dhk2X/ln4n40kJGFGz+ogPHLHhOp3No6wTKGDfc7KG0tS3jjvCAy8KhOHU1p0nL7PFykIOMRGa0Wlqxbxt5+JRe1q0lbolO+tno9bNBBe+MhAWoO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAfhg1yXWHGC1cbH3uO9p4dloP6puQJkVZWVdXrIs8g=;
 b=eToF4RJbrgNlLlYivPvIVgxAGr4wa3Dm6PIwVGU4j63mzf7W49jJIYIvrVmbV/aUH6X5MIuQV8IH2JKa46dNK2kjmLLgfTiJvyIS3WAfJNdaTikEzlw5PugE1BMWT7zmBjPnSADa7RKpQ499EOGqTS3GNfrIOrF0TF4aIjFOutw=
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 (2603:10a6:800:2b::12) by VE1PR04MB6592.eurprd04.prod.outlook.com
 (2603:10a6:803:124::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Sun, 1 Aug
 2021 16:02:07 +0000
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f]) by VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f%11]) with mapi id 15.20.4373.026; Sun, 1 Aug 2021
 16:02:07 +0000
From:   David Mozes <david.mozes@silk.us>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "inux-kernel@vger.kernel.org" <inux-kernel@vger.kernel.org>
Subject: sysfs_emit problem with iscsi with KASAN
Thread-Topic: sysfs_emit problem with iscsi with KASAN
Thread-Index: AdeG7iY62YINDrhmTCScGJboMWmJTg==
Date:   Sun, 1 Aug 2021 16:02:06 +0000
Message-ID: <VI1PR0401MB2415C23902672C9E5E11B188F1EE9@VI1PR0401MB2415.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silk.us;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e44e3e95-6606-4a43-a051-08d95505b64b
x-ms-traffictypediagnostic: VE1PR04MB6592:
x-microsoft-antispam-prvs: <VE1PR04MB65928D3AC095945B94E1D502F1EE9@VE1PR04MB6592.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYKn29oYvlszcnDyYFzWWgJ8cqxfZaZPTnuhXs1h1oIYextPloucgpCUmoG4MHl4FODROgc96vtwOP/8NsH8eqh1BbUKs3f//toIdaJMmFsJJel1MU2iHezeDfgMO0qk9wxwpeSYe/15vjKHibA6nI0NOySFNMJi7IcvMADFwZykTxujptMkdWx8z5MK6OFEWkFCDNQgiWeF8cVN6Mu3132j+OSZIPB9K2AcdgRseTclaIIfKbMKx3KAagSJp6UL71UBdqyLwRRuZpi2P3+INA9FOo01dKq6KjuhxhwyGIcBijC8KMbmTp5qaJwxz50URfnohCJphAUfDO8LzR29hDGn2SQVzdKACKeZ2ka+sM7tTwD72DzRlgoqoMLSw4gZxWWP4D8J2Xm2Nv2LLAdaDb9FNboFLKnDfqQrV01+1ctvpTfv9vb1rPgCs1HXPmnt3iBXalgQ3YU578OfKydJwpJnOlbASE4lfzrzBGX+Vb+t+UfdUbPEIWZvrMgrQTrj2x2x14cn7oBTDZpBXWhNHv//E3KGLc7wTYGeK70zJxXJFLECWZ3ttbNJCawZtpl5q/butyYNh3LMnNAndPiJ+zQleNSjbP4bUEiyt5NuULItUY1Ntr13q3kr63hI7P2JR3ULxcDoZSM3ZRzw2Sk2yNy6XnnVEhBQ1qRCg5gUXrQwaFt1/MZa1mcKU5xp7QCWdR02Im9UEP1LLCFr/LwALysFI4gyXowLzfa87CeQ/9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(39860400002)(376002)(55016002)(9686003)(52536014)(33656002)(45080400002)(186003)(44832011)(122000001)(38100700002)(508600001)(2906002)(8676002)(26005)(8936002)(6506007)(7696005)(450100002)(83380400001)(76116006)(66476007)(5660300002)(86362001)(316002)(66946007)(110136005)(66446008)(71200400001)(38070700005)(66556008)(64756008)(80162008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k7YqD5OYoWUx8UAugddsUy73LXJz3qAQjo5rW3N0EvJPKsckuvU7InY1M2Ra?=
 =?us-ascii?Q?EFOM3GBekVLnmnfyAZjdLBG2iD+FZTaRSowPQnLXWK/j3KGso1Cy7n38wRmc?=
 =?us-ascii?Q?aBdstWIpd1jo7GlGUbNI97MAla0X8M214C/JonCm38lz0yU9doqIT7wTXg9W?=
 =?us-ascii?Q?d/EGkZKDDsg6FYvnBJAVSzKVrapq2PoCN5oqp1KL9Ky45wfsFGIId3hWnPyd?=
 =?us-ascii?Q?MweocLdOlAePhOeUtaZzC9l31cxHslE1mF2ZnbTlX2pE58og1/q/xW2Q+NQO?=
 =?us-ascii?Q?nQOylJiOI7liOX7lh/zSZUnJe7R+0syjE7QytrJ6BbwsAgpD9rS+UznU5osU?=
 =?us-ascii?Q?p6+nOVmvA9DNsKAQPLc6/3kfW8oLoE+vuNci0rYuLHnrT+EwA2FGvkZk6GYa?=
 =?us-ascii?Q?f0tbh0X9daBX+buq274e9UW4Yf8RYDeHeB5FT6DV+5pBeHpG/ZGIpM6BOGjo?=
 =?us-ascii?Q?caJHAbjifHT2fJt7ZxMdQNSiNNF733B6iN38JCc9EhlE7GQiLCtHhnPcA3jA?=
 =?us-ascii?Q?6cxK7ydgWrjBFmgknensWHub+bwY12lqDRiySECHh5Z2r1Re7N4sB+sRComx?=
 =?us-ascii?Q?yw4p3I/hVgdsyRpPH87eDLxDEOmGwdD87g8wLHttDor6GMGjGBDMpq46M5CX?=
 =?us-ascii?Q?xbUzdWrsbVyiIPYD1yqp5IjszSLpwhnrRwYIQNh32dQSQOzIZLPxwEVpwzVX?=
 =?us-ascii?Q?B0MC6r9weuCXyJIAXXl603ufyH/rCOVjnSdR1IhpuIkuP9XYpBnCBqxRKR6Y?=
 =?us-ascii?Q?928uyvYTmHqi1s4rl+fVvLrqje11m/hOTvPDYEdfBr6THggCZfYE99WzeNbZ?=
 =?us-ascii?Q?oOVuIdF3Ks//rEjOlXrnOpI8W+CbcGMMQWBOy0P/+VvkMokHBv+a5+QDd781?=
 =?us-ascii?Q?onSUU9iqri79N2kyY1h+Zr8kgtR00A+YEGv+XvCluoF6gz4nr+XSzH1xRTq0?=
 =?us-ascii?Q?xllpTJxU3jXA6/1TMoeaoKmY2tf0xhXkaa7W6VWm3Jz8qf0UcS9XfYlTagwd?=
 =?us-ascii?Q?dg0PfL3OV+pFTCCcdM2l3KvMdPjpLpSe3Bg79tx3DBQa3fOCDK2qiPfTKlNq?=
 =?us-ascii?Q?SET+b+kWeaK2GscV7jLZjIN7IVafQXsOuSmBscIeNECWeom8Mw6HwZoxXu32?=
 =?us-ascii?Q?WDA72fJ/oqKoCjko66yBl56JRuRM50S4S+xQoVqB0B6DvpTS1S95BLqDF+j0?=
 =?us-ascii?Q?28AMEI8OWnsC92rw/k4JzSGJwKO51Tw507BTaNT42TxIhBZw7198wy9EMdU7?=
 =?us-ascii?Q?C00b44YkhmSmEgbK0hRrQebrFFmkhVbjQUSFamYLdGFZ3EXU232K1Sza6BYy?=
 =?us-ascii?Q?Gm8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44e3e95-6606-4a43-a051-08d95505b64b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2021 16:02:06.9353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AqskCMn+1PPSYys0DRkrWFztcKXFP4ZMg6sV+e1cpcAB1ib78MkSBmrqcn1cOHzCcEUNIuI+uBre2M0cFNIrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6592
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
I got the below trace after I enabled KASAN on kernel 4.19.195
Any idea why we got this unaligned problem with the sysfs buffers?

Thx
David=20

=09

Aug  1 17:25:54 c-node04 kernel: [  362.068757] invalid sysfs_emit: buf:000=
0000044a7eadd
Aug  1 17:25:54 c-node04 kernel: [  362.068777] WARNING: CPU: 11 PID: 30435=
 at fs/sysfs/file.c:576 sysfs_emit+0xeb/0x100
Aug  1 17:25:54 c-node04 kernel: [  362.068778] Modules linked in: be2iscsi=
 iscsi_boot_sysfs bnx2i cnic uio cxgb4i cxgb4 cxgb3i libcxgbi cxgb3 mdio li=
bcxgb ib_iser(OE) iscsi_tcp libiscsi_tcp=20
libiscsi scsi_transport_iscsi drbd lru_cache loop 8021q mrp garp nfsd nfs_a=
cl auth_rpcgss lockd sunrpc grace ipt_MASQUERADE xt_nat xt_state iptable_na=
t nf_nat_ipv4 xt_addrtype xt_conntrack nf
_nat nf_conntrack nf_defrag_ipv4 nf_defrag_ipv6 libcrc32c br_netfilter brid=
ge stp llc overlay dm_multipath rdma_ucm(OE) ib_ucm(OE) rdma_cm(OE) iw_cm(O=
E) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx
5_fpga_tools(OE) mlx5_ib(OE) ib_uverbs(OE) mlx4_en(OE) mlx4_ib(OE) ib_core(=
OE) mlx4_core(OE) fuse binfmt_misc mlx5_core(OE) mlx_compat(OE) devlink mlx=
fw(OE) pci_hyperv hv_utils ptp pps_core h
v_balloon hv_netvsc pcspkr i2c_piix4 joydev sr_mod(E) cdrom(E) ext4(E) jbd2=
(E)
Aug  1 17:25:54 c-node04 kernel: [  362.068826]  mbcache(E) hyperv_keyboard=
(E) hid_hyperv(E) hv_storvsc(E) scsi_transport_fc(E) floppy(E) hyperv_fb(E)=
 hv_vmbus(E) [last unloaded: lru_cache]
Aug  1 17:25:54 c-node04 kernel: [  362.068835] CPU: 11 PID: 30435 Comm: is=
csiadm Kdump: loaded Tainted: G           OE     4.19.195-KM9 #1
Aug  1 17:25:54 c-node04 kernel: [  362.068836] Hardware name: Microsoft Co=
rporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
Aug  1 17:25:54 c-node04 kernel: [  362.068839] RIP: 0010:sysfs_emit+0xeb/0=
x100
Aug  1 17:25:54 c-node04 kernel: [  362.068841] Code: 00 48 8b 4c 24 58 65 =
48 33 0c 25 28 00 00 00 75 1f 48 81 c4 90 00 00 00 5b 5d c3 48 89 fe 48 c7 =
c7 a0 c9 53 bb e8 25 cd 68 ff <0f> 0b 31=20
c0 eb bf e8 0a d1 68 ff 66 2e 0f 1f 84 00 00 00 00 00 0f
Aug  1 17:25:54 c-node04 kernel: [  362.068843] RSP: 0018:ffff88977dcff898 =
EFLAGS: 00010286
Aug  1 17:25:54 c-node04 kernel: [  362.068845] RAX: 0000000000000000 RBX: =
1ffff112efb9ff13 RCX: 0000000000000000
Aug  1 17:25:54 c-node04 kernel: [  362.068846] RDX: dffffc0000000000 RSI: =
0000000000000000 RDI: ffffed12efb9fee1
Aug  1 17:25:54 c-node04 kernel: [  362.068848] RBP: ffff88977dcff930 R08: =
ffffed13cbd3629f R09: ffffed13cbd3629e
Aug  1 17:25:54 c-node04 kernel: [  362.068849] R10: ffffed13cbd3629e R11: =
ffff889e5e9b14f7 R12: ffffffffc13c34f0
Aug  1 17:25:54 c-node04 kernel: [  362.068850] R13: ffffffffba2ac690 R14: =
ffff88c00ccbf900 R15: ffff88977caad688
Aug  1 17:25:54 c-node04 kernel: [  362.068852] FS:  00007feab717f700(0000)=
 GS:ffff889e5e980000(0000) knlGS:0000000000000000
Aug  1 17:25:54 c-node04 kernel: [  362.068853] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Aug  1 17:25:54 c-node04 kernel: [  362.068854] CR2: 00007feab6c2bab0 CR3: =
00000017829cf002 CR4: 00000000003606e0
Aug  1 17:25:54 c-node04 kernel: [  362.068858] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Aug  1 17:25:54 c-node04 kernel: [  362.068859] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Aug  1 17:25:54 c-node04 kernel: [  362.068860] Call Trace:
Aug  1 17:25:54 c-node04 kernel: [  362.068864]  ? sysfs_remove_bin_file+0x=
80/0x80
Aug  1 17:25:54 c-node04 kernel: [  362.068869]  ? memcg_kmem_get_cache+0x2=
02/0x810
Aug  1 17:25:54 c-node04 kernel: [  362.068871]  ? mem_cgroup_handle_over_h=
igh+0x130/0x130
Aug  1 17:25:54 c-node04 kernel: [  362.068875]  ? __free_insn_slot+0x4d0/0=
x4d0
Aug  1 17:25:54 c-node04 kernel: [  362.068887]  show_transport_caps+0x5f/0=
x80 [scsi_transport_iscsi]
Aug  1 17:25:54 c-node04 kernel: [  362.068892]  dev_attr_show+0x40/0x80
Aug  1 17:25:54 c-node04 kernel: [  362.068895]  ? memset+0x1f/0x40
Aug  1 17:25:54 c-node04 kernel: [  362.068897]  sysfs_kf_seq_show+0x227/0x=
410
Aug  1 17:25:54 c-node04 kernel: [  362.068900]  kernfs_seq_show+0x1c0/0x26=
0
Aug  1 17:25:54 c-node04 kernel: [  362.068902]  ? kernfs_vma_open+0x1b0/0x=
1b0
Aug  1 17:25:54 c-node04 kernel: [  362.068905]  seq_read+0x3db/0xfc0
Aug  1 17:25:54 c-node04 kernel: [  362.068909]  kernfs_fop_read+0x107/0x5c=
0
Aug  1 17:25:54 c-node04 kernel: [  362.068911]  ? __kasan_slab_free+0x125/=
0x170
Aug  1 17:25:54 c-node04 kernel: [  362.068913]  ? kernfs_vma_page_mkwrite+=
0x200/0x200
Aug  1 17:25:54 c-node04 kernel: [  362.068916]  ? __fsnotify_inode_delete+=
0x20/0x20
Aug  1 17:25:54 c-node04 kernel: [  362.068919]  __vfs_read+0xde/0x970
Aug  1 17:25:54 c-node04 kernel: [  362.068921]  ? __x64_sys_copy_file_rang=
e+0x5e0/0x5e0
Aug  1 17:25:54 c-node04 kernel: [  362.068924]  ? do_filp_open+0x24c/0x370
Aug  1 17:25:54 c-node04 kernel: [  362.068926]  ? cp_new_stat+0x71a/0x920
Aug  1 17:25:54 c-node04 kernel: [  362.068928]  ? may_open_dev+0xc0/0xc0
Aug  1 17:25:54 c-node04 kernel: [  362.068930]  ? __ia32_sys_fstat+0x70/0x=
70
Aug  1 17:25:54 c-node04 kernel: [  362.068933]  ? __fsnotify_update_child_=
dentry_flags.part.4+0x450/0x450
Aug  1 17:25:54 c-node04 kernel: [  362.068936]  ? simple_attr_release+0x50=
/0x50
Aug  1 17:25:54 c-node04 kernel: [  362.068939]  vfs_read+0xe9/0x2e0
Aug  1 17:25:54 c-node04 kernel: [  362.068942]  ksys_read+0xe7/0x270
Aug  1 17:25:54 c-node04 kernel: [  362.068944]  ? kernel_write+0x130/0x130
Aug  1 17:25:54 c-node04 kernel: [  362.068948]  do_syscall_64+0x149/0x4e0
Aug  1 17:25:54 c-node04 kernel: [  362.068951]  ? syscall_return_slowpath+=
0x330/0x330
Aug  1 17:25:54 c-node04 kernel: [  362.068954]  ? __do_page_fault+0xad0/0x=
ad0
Aug  1 17:25:54 c-node04 kernel: [  362.068957]  ? prepare_exit_to_usermode=
+0x220/0x220
Aug  1 17:25:54 c-node04 kernel: [  362.068959]  ? enter_from_user_mode+0x4=
0/0x40
Aug  1 17:25:54 c-node04 kernel: [  362.068964]  ? __put_user_4+0x1c/0x30
:
