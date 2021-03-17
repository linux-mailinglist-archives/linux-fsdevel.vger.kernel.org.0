Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2129B33F5C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 17:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhCQQkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 12:40:37 -0400
Received: from mail-eopbgr00110.outbound.protection.outlook.com ([40.107.0.110]:9089
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232666AbhCQQkR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:40:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y08B1laFQKrD4QnyICFC3PJSFtdHV6qS0Yizw4ftE/XI28GCrqCF0hNmujp0SnCR4FmUnFg8wompO4rMoAOlCKRg7y3gsvj6O9//yvwtCtoZP8GBUllWTu6fIq+C14RlwDv1d2aKQGrq4t3mD2616rSiF5nrz77Sz4p9eQiDaWq/dWs6KzWnqICELsytaOyQuNM1yxo9G49iSuVQPDsqOLZGsRIrvDob+jV2KUBQzNaw8dRcPjAhCNAJ4gp5rbjrd3P/FWnNulix4/XG0G8IvWiUHyUmAI/MROzbVKoDN+tVqKidcVSbW44SnljhqWdBaYKCXg5Co9ujfDZ5a6unjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY1N0EnNSdu+rv7H3kcBSYwzAR8BPva/S2msG1JwlZI=;
 b=Xw9DZW7bcQm6jJs7/PlILsxMxRDHPgXq/6SEo4Y49fJxGliKl+FSOloMNbgRDO9Xd+laALrxmqiAlnjy5qv+zlfqO3YJpiy0oNfM/gg6OGdcW9CkblFV28K66O1wWWVs48xjMca0UWTYoKDwBKgKaJEc0ZMR73klPpjpEV8k9nPfOeKb571xHjhe7jkwYYv3UU5DhdsienWkbZZpMUFa2gMNCFuuViR7NTp+t85VWxIOEBkaRCPwcBW3XqNOmifwO7eIzbJK/PVgqDEc83pXmASBlmuSo/Bz3bAl8/H9ZEXwyrsT+sz8MNZ+WMNAyFEqQMDA4gRXun2xuv0XKjxQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY1N0EnNSdu+rv7H3kcBSYwzAR8BPva/S2msG1JwlZI=;
 b=nzhJAejBoXHkmcVMqh8Mbs51Zq1gJMBoM+0Zt82Kgp8AsilevLNdCsEZ5eO68vQ+EJclEZruTQZgLmknv4WvQNfdsKmlXypnsSNMdjBqh3XIbc/A/YbkzbEsgO9fO+cnZdpKyzt4xRswEMjkiA+Bs14lnA8mvG6jViIUhpMj0EM=
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com (2603:10a6:20b:ad::22)
 by AS8PR04MB7719.eurprd04.prod.outlook.com (2603:10a6:20b:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 16:40:15 +0000
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::d582:5989:a674:bfab]) by AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::d582:5989:a674:bfab%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 16:40:15 +0000
From:   David Mozes <david.mozes@silk.us>
To:     Eric Sandeen <sandeen@sandeen.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "sandeen@redhat.com" <sandeen@redhat.com>
Subject: RE: fs: avoid softlockups in s_inodes iterators commit
Thread-Topic: fs: avoid softlockups in s_inodes iterators commit
Thread-Index: AdcapuBpHwWWXKfESnKJze+uh6myxwAJencAAB5CKWA=
Date:   Wed, 17 Mar 2021 16:40:15 +0000
Message-ID: <AM6PR04MB563935FDA6010EA1383AA08BF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
References: <AM6PR04MB5639492BE427FDA2E1A9F74BF16B9@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <4c7da46e-283b-c1e3-132a-2d8d5d9b2cea@sandeen.net>
In-Reply-To: <4c7da46e-283b-c1e3-132a-2d8d5d9b2cea@sandeen.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sandeen.net; dkim=none (message not signed)
 header.d=none;sandeen.net; dmarc=none action=none header.from=silk.us;
x-originating-ip: [37.142.234.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd33a7b9-a550-4df2-b2fb-08d8e9635788
x-ms-traffictypediagnostic: AS8PR04MB7719:
x-microsoft-antispam-prvs: <AS8PR04MB77199427F4A3FCA74DC343FFF16A9@AS8PR04MB7719.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:136;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxbM7KudiDrQrML2yEZgthUy+tEi47XCcCARizk3bK7ajNK7gk/6G0aNSgMrIxVS+avUUhqd51eZ9iO8CYGifuvOr82ZrCJVC5rClvOb2R5gHsPQuSWcEogGA4feBkuo9B+AlZKEJMpXpu4SYizACDlHAh9FxQt+ci0v+JpO6gPCEkFXNJv/bhjsU60ze41APbKU2Z4NJX4vrziNE8DigAJNHCHj/npx99L+ipaibgyAKVKarhhSIc4GqT9hgqG1bAVAnGPXUfSW3L6HV+9N4YeGMaCPV0dbYpsBALA4NQr8CjbjKdYF1szqWgCkItqZtu3W1qvhO/Hzf+4bfunT+vfNM+nD994xMaPBzUSCmbbI2wOiTZ18jV5rZwE9cdFbPdMbfZY1q9nzuDbpl9n2CSlo53QqYtdEteE59RqTN9bs6NzudAQ9bCtpqLvHk1ODBgrqu4uj4eGAVxiNuvtugwsZ6itw0yA58zENRKqfPhLiv+WIrumVy1gN+MvFDAyCSQnaTWR/Uk/zD3FkxoGmlLfhhpwu1FacTOBoTYKtywQmige7iYdOj6K+IcOWWsHB0pRyMlnr4oHzQFvkc2ZFAql2MPfPknwHXfV/lFx3c7Z2aF78L9y8NSJez9zQ4Sc0Flt7AkLCjUhmFzYLqPZWlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5639.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(26005)(8936002)(44832011)(83380400001)(4326008)(110136005)(55016002)(316002)(33656002)(478600001)(2906002)(9686003)(45080400002)(76116006)(66446008)(53546011)(5660300002)(8676002)(66946007)(66556008)(52536014)(66476007)(64756008)(7696005)(86362001)(71200400001)(6506007)(186003)(80162006)(80862006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r14LM5olsCfIyMofyA+ZhmlE5ood51C08TqxEV5YsCM95Ig0AVRa/MevF0YK?=
 =?us-ascii?Q?vP2ymEW6dwV4qGQl6Eb3CH9wCOxO29Z/5kqrq0AbzNCBlodPBGZ9//9zcTr2?=
 =?us-ascii?Q?24et3b9CfZFAkyegioD261P8VWwgGDiWzUcE0Bv73IDWFNTfl7qeuUGjjq3p?=
 =?us-ascii?Q?nzgRWxiXvpcAm6DaqtFWsLEbBbQ98hZHE+0kyKRFEszO3zn/b0N+JPG0ctAg?=
 =?us-ascii?Q?VOCrGJnxYFCZAIudDFAjzZA46gwCnw/glPw+JBE9yLFXbQarfjZgm7ykb4Wl?=
 =?us-ascii?Q?fTIi0C2tV/7tcT0GV/xM0Fd0oHeQrchqs8f6VVfOQnx31dx+TEeCRYkgtHh7?=
 =?us-ascii?Q?2CYE7gjxvR5DAkVc4U3v0pYwcgHSjC7v0oQbTOg7AkdprRl/ctJwivVmq0JQ?=
 =?us-ascii?Q?VVESsvqOqAm54HqvzeD3CvUUBp3IKW6B6qXLBCmnsNTP1SHp9PPNy7n4NbZU?=
 =?us-ascii?Q?RPRgzP2wJbP8881VfiqDyTwpsVX3CoNdvBh0e46IBDlieEwUX18pC8KCfmKR?=
 =?us-ascii?Q?GCwUh986eZBl4YCfx11eoZ1SKGPc+Gix8tJU1+gvanskf7PeP2U6pU6ooheb?=
 =?us-ascii?Q?wNSMNKJM0LTTY6HIiH6tvLlZtB2f/hMEkBoZjT7wdAEc59ULZyULb+aafzOv?=
 =?us-ascii?Q?WSypV1j35B4G62K5T/3utOv4kzk9NCx0MQVgDiKYfDtOsU/kwjM//epOnziE?=
 =?us-ascii?Q?DCKX//3vNT9vYbqgCA8AyQYTJ/1Ycz1NTfNVt2JCvoboZZy4HCXy7RgJVmUk?=
 =?us-ascii?Q?0Fu55SPKkzPcHeLzxJzC9V8olBeXfDa12XAZUqUPzmwQXgl8LaP8dauPclDp?=
 =?us-ascii?Q?wOWS852BI9L0GOa4rCXb6ukXMiLFwS3GPiiyUb7yMJhUq5BE8mcwEEbat/mO?=
 =?us-ascii?Q?Jvwd1AnvtOaBO6M6pZ5i0O8N5eZZoXVHGdXbA05O89EP58cFzhiQQ+2kCEiI?=
 =?us-ascii?Q?TD4u+rTHE7/WZXGcTXtXR9d8sG30UIUMDTmoLIUChOvKRi/gq9CxO7/KspNf?=
 =?us-ascii?Q?FXpzziCWkEshrgeiEx/ulI6tNFDPNq5EbN9YqMvRu/HbdHYEIPGmH7UNG0Ow?=
 =?us-ascii?Q?nkMdZBGyunJTg0fShnBrCUfx6mXW418H980yZtQiItdCUGxmxDDoZYaOFfU/?=
 =?us-ascii?Q?Zl+LWK6MnTtmIKPeCUoJIA8mgdlHqiuvj51svCscbgGe6aBPYNI2dKliOLwx?=
 =?us-ascii?Q?xpCA8OvGnJMrrKwyUSqb31MGd+ljJTJdB4sOh74W2hhK0+300+nk3n0dtl0r?=
 =?us-ascii?Q?DhqaqSKnyHC1U+6URNkQOPQMPdDbsp0GK/WUEJkZfAfqsFpXnVEBJadmhre5?=
 =?us-ascii?Q?susCWBVVTuD/WM1YGAvZfanb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5639.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd33a7b9-a550-4df2-b2fb-08d8e9635788
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 16:40:15.1456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08vY8elRywaZycBJXGBZ6Moc28ob0VtUlC2LZazdsFvEc3ZI7LxHblC/l0B2/7mrV+yoLj/p9g0EWZ/hzk8VFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7719
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sure Eric,
Send details again=20
I run a very high load traffic (Iscsi storage-related IO load )on GCP.
After one day of running, my kernel has been stack with two typical cases i=
nvolving page fault.
1)	Soft lockup, as described in the first typical case,=20
2)	Panic as described in the second case.

First typical case: (the soft lockup happens on several CPUs):

Feb 21 07:38:52 c-node02 kernel: [242408.563170]  ? flush_tlb_func_common.c=
onstprop.10+0x250/0x250
Feb 21 07:38:52 c-node02 kernel: [242408.563171]  on_each_cpu_mask+0x23/0x6=
0
Feb 21 07:38:52 c-node02 kernel: [242408.563173]  ? x86_configure_nx+0x40/0=
x40
Feb 21 07:38:52 c-node02 kernel: [242408.563174]  on_each_cpu_cond_mask+0xa=
0/0xd0
Feb 21 07:38:52 c-node02 kernel: [242408.563175]  ? flush_tlb_func_common.c=
onstprop.10+0x250/0x250
Feb 21 07:38:52 c-node02 kernel: [242408.563177]  flush_tlb_mm_range+0xbc/0=
xf0
Feb 21 07:38:52 c-node02 kernel: [242408.563179]  ptep_clear_flush+0x40/0x5=
0
Feb 21 07:38:52 c-node02 kernel: [242408.563180]  try_to_unmap_one+0x2ae/0x=
ae0
Feb 21 07:38:52 c-node02 kernel: [242408.563184]  ? mutex_lock+0xe/0x30
Feb 21 07:38:52 c-node02 kernel: [242408.563186]  rmap_walk_anon+0x13a/0x2c=
0
Feb 21 07:38:52 c-node02 kernel: [242408.563188]  try_to_unmap+0x9c/0xf0
Feb 21 07:38:52 c-node02 kernel: [242408.563190]  ? page_remove_rmap+0x330/=
0x330
Feb 21 07:38:52 c-node02 kernel: [242408.563192]  ? page_not_mapped+0x20/0x=
20
Feb 21 07:38:52 c-node02 kernel: [242408.563193]  ? page_get_anon_vma+0x80/=
0x80
Feb 21 07:38:52 c-node02 kernel: [242408.563195]  ? invalid_mkclean_vma+0x2=
0/0x20
Feb 21 07:38:52 c-node02 kernel: [242408.563196]  migrate_pages+0x3cd/0xc80
Feb 21 07:38:52 c-node02 kernel: [242408.563197]  ? do_pages_stat+0x180/0x1=
80
Feb 21 07:38:52 c-node02 kernel: [242408.563198]  migrate_misplaced_page+0x=
15e/0x270
Feb 21 07:38:52 c-node02 kernel: [242408.563200]  __handle_mm_fault+0xd80/0=
x12f0
Feb 21 07:38:52 c-node02 kernel: [242408.563202]  handle_mm_fault+0xc2/0x1f=
0
Feb 21 07:38:52 c-node02 kernel: [242408.563204]  __do_page_fault+0x23e/0x4=
f0
Feb 21 07:38:52 c-node02 kernel: [242408.563206]  do_page_fault+0x30/0x110
Feb 21 07:38:52 c-node02 kernel: [242408.563207]  page_fault+0x3e/0x50
Feb 21 07:38:52 c-node02 kernel: [242408.563209] RIP: 0033:0x7f27fffb9e73
Feb 21 07:38:52 c-node02 kernel: [242408.563211] Code: 89 6d e8 48 89 fb 4c=
 89 75 f0 4c 89 7d f8 49 89 f6 4c 89 65 e0 48 81 ec c0 06 00 00 4c 8b 3d 3c=
 a1 34 00 49 89 d5 64 41 8b 07 <89> 85 dc fa ff ff 8b 87 c0 00 00 00 85 c0 =
0f 85 b9 01 00 00 c7 87
Feb 21 07:38:52 c-node02 kernel: [242408.563211] RSP: 002b:00007f12a37fda10=
 EFLAGS: 00010202
Feb 21 07:38:52 c-node02 kernel: [242408.563213] RAX: 0000000000000000 RBX:=
 00007f12a37fe0e0 RCX: 0000000000000000
Feb 21 07:38:52 c-node02 kernel: [242408.563214] RDX: 00007f12a37fe200 RSI:=
 00000000017a9453 RDI: 00007f12a37fe0e0
Feb 21 07:38:52 c-node02 kernel: [242408.563214] RBP: 00007f12a37fe0d0 R08:=
 0000000000000000 R09: 00000000017c7550
Feb 21 07:38:52 c-node02 kernel: [242408.563215] R10: 0000000000000000 R11:=
 00000000000003f8 R12: 00000000017a9453
Feb 21 07:38:52 c-node02 kernel: [242408.563216] R13: 00007f12a37fe200 R14:=
 00000000017a9453 R15: fffffffffffffe90
Feb 21 07:38:52 c-node02 kernel: [242408.604094] watchdog: BUG: soft lockup=
 - CPU#45 stuck for 22s! [km_target_creat:49068]
Feb 21 07:38:52 c-node02 kernel: [242408.604095] Modules linked in: iscsi_s=
cst(OE) crc32c_intel(O) scst_local(OE) netconsole(O) scst_user(OE) scst(OE)=
 drbd(O) lru_cache(O) loop(O) 8021q(O) mrp(O) garp(O) nfsd(O) nfs_acl(O) au=
th_rpcgss(O) lockd(O) sunrpc(O) grace(O) xt_MASQUERADE(O) xt_nat(O) xt_stat=
e(O) iptable_nat(O) xt_addrtype(O) xt_conntrack(O) nf_nat(O) nf_conntrack(O=
) nf_defrag_ipv4(O) nf_defrag_ipv6(O) libcrc32c(O) br_netfilter(O) bridge(O=
) stp(O) llc(O) overlay(O) be2iscsi(O) iscsi_boot_sysfs(O) bnx2i(O) cnic(O)=
 uio(O) cxgb4i(O) cxgb4(O) cxgb3i(O) libcxgbi(O) cxgb3(O) mdio(O) libcxgb(O=
) ib_iser(OE) iscsi_tcp(O) libiscsi_tcp(O) libiscsi(O) scsi_transport_iscsi=
(O) dm_multipath(O) rdma_ucm(OE) ib_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(=
OE) ib_cm(OE) ib_umad(OE) mlx5_fpga_tools(OE) mlx5_ib(OE) ib_uverbs(OE) mlx=
5_core(OE) mdev(OE) mlxfw(OE) ptp(O) pps_core(O) mlx4_ib(OE) ib_core(OE) ml=
x4_core(OE) mlx_compat(OE) fuse(O) binfmt_misc(O) pvpanic(O) pcspkr(O) virt=
io_rng(O) virtio_net(O) net_failover(O) failover(O) i2
:

Second typical case PANIC:=20

From the cosule:

[123080.813877] kernel tried to execute NX-protected page - exploit attempt=
? (uid: 0)
[    0.000000] Linux version 5.4.80-KM8 (david.mozes@kbuilder64-tc8-test1) =
(gcc version 8.3.1 20190311 (Red Hat 8.3.1-3) (GCC)) #14 SMP Mon Jan 11 16:=
21:21 IST 2021

Mon Jan 11 16:21:21 IST 2021
[    0.000000] Command line: ro root=3DLABEL=3D/ rd_NO_LUKS KEYBOARDTYPE=3D=
pc KEYTABLE=3Dus LANG=3Den_US.UTF-8 rd_NO_MD SYSFONT=3Dlatarcyrheb-sun16 no=
mpath append=3D"nmi_watchdog=3D2"



From the vmcore-dmesg:=20

[121271.606463] ll header: 00000000: 42 01 0a ad 0c 02 42 01 0a ad 0c 01 08=
 00
[122656.730235] sh (27931): drop_caches: 3
[123080.813877] kernel tried to execute NX-protected page - exploit attempt=
? (uid: 0)
[123080.813887] sched: RT throttling activated
[123080.821706] Kernel panic - not syncing: stack-protector: Kernel stack i=
s corrupted in: serial8250_console_write+0x26e/0x270

After I comment out=20


After I comment out the cond_resched(), everything looks more stable.=20
I Will try another run as Eric sagest with the:=20
cond_resched()=20
before the:
Invalidtated_mapping_pages=20
See and report regarding the behavior.
I think we have a very stressful environment on GCP for testing that
Thx
David



-----Original Message-----
From: Eric Sandeen <sandeen@sandeen.net>=20
Sent: Wednesday, March 17, 2021 3:28 AM
To: David Mozes <david.mozes@silk.us>; linux-fsdevel@vger.kernel.org
Cc: sandeen@redhat.com
Subject: Re: fs: avoid softlockups in s_inodes iterators commit

On 3/16/21 3:56 PM, David Mozes wrote:
> Hi,
> Per Eric's request, I forward this discussion to the list first.
> My first answers are inside

ok, but you stripped out all of the other useful information like backtrace=
s, stack corruption, etc. You need to provide the evidence of the actual fa=
ilure for the list to see. Also ..

> -----Original Message-----
> From: Eric Sandeen <sandeen@redhat.com>
> Sent: Tuesday, March 16, 2021 10:18 PM
> To: David Mozes <david.mozes@silk.us>
> Subject: Re: Mail from David.Mozes regarding fs: avoid softlockups in=20
> s_inodes iterators commit
>=20
> On 3/16/21 3:02 PM, David Mozes wrote:
>> Hi Eric,
>>

...

> David > Not sure yet,  Will check.
>> 5.4.8 vanilla kernel it custom
>=20
> Is it vanilla, or is it custom? 5.4.8 or 5.4.80?
>=20
> David> 5.4.80 small custom as I mantion.=20

what is a "small custom?" Can you reproduce it on an unmodified upstream ke=
rnel?

-Eric

