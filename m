Return-Path: <linux-fsdevel+bounces-1913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 334567E0211
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 12:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DC3B213D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2114F9F;
	Fri,  3 Nov 2023 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SZO/53Nq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033C14F86
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 11:17:58 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B501BD;
	Fri,  3 Nov 2023 04:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9mYx/+HDn0fpZ6U18/gghJkij8fe8hJq4vMylYGC3LdWWX39nCDXOPfYSx0TIUvZN/CaBNvPDNwVH1m+QCbuUpfUhs7uDOYAAgKqA9h9uzWGlLwidr9wZ6UKM73JYQ/vLuzoDY0ZHSvAtakxkijL1n0NgiENZ9gTi2TH3gdA7PvzF8/+smvBtnHeUp8acAf39l0IX40blC1QvZHDLbgkzgWW1jDBzxZgInF/HCXvPtsfG1xo21Jlcg15V8sZzkp0Jeg66LzCCUZ4KcdorihGJb8EnigsMn15zGne8SJ+jDTZk4QaEOeWVFVHVJAZou4TC84m+VdsdgvTPv4wIpAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWHSp4L/QFa4imII+bNVx8ezcUOxRf49u+cMpi9IxF4=;
 b=RlZNgoGf1zwTohYVYwE1sfMmPiU/FGBEQhAzYqby62wbth4Qp2p+4Ij1n2jzll788IE8xCbnFxGftCFxRk2KuvAe43xFvYqrJz3itRjFydb0kSYFCInpmVUpUsQrHbRTilhLQeqB+PP9wJ3SEtIk39XfZ7JBYSesuu8IoFc81RMIT+X5EaE00roMz42qbS2Dp75Y0HaDOgUgeoVkPzTeiKmu0C+hfcPZgjhd6/g9ZlzB0kRJitd1X332fgRgBY+GnfaLWXPwTI8TXVLw6OogDr7K9zff7Zun2gFjjLCn8AO06QSeC9hHrZP+Nc85tiM4SHR6s7pAnI/5WMQmq2/VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWHSp4L/QFa4imII+bNVx8ezcUOxRf49u+cMpi9IxF4=;
 b=SZO/53NqHz5khwthri2AdzrGlZIsYkSHUztlC57Or362E2SM8PMYTY+CmAC4n8zMy1ahC0aQn39b9wUbPwNL53NMC5+bBzGJVrroqCh/iosTNTdw5vuZubmOi+X2L2og5ZN/90c4Hs9zDo91BTY0haVYgSmhcNQG/1r6KTu3H9UeoIAlEAGFMPxRIkWJN/iJ6W+VzXdBjUouxfXfibZtgc2x28dvEvE47ULNWo/jbydMb7cTJBzIv86idFSgifN+k5ZqxbuhO1hi1EIqCM+5+FOPfdE0mjwBv2VnwPrS599L5Iyyiu0xsk/gIDxTKyUlySNYs0Xn1pjt/z4iDNreVA==
Received: from AM9PR10MB4338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26f::16)
 by VI1PR10MB3343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 11:17:51 +0000
Received: from AM9PR10MB4338.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::327c:78b1:7b3d:fbbe]) by AM9PR10MB4338.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::327c:78b1:7b3d:fbbe%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 11:17:51 +0000
From: "carsten.schmid@siemens.com" <carsten.schmid@siemens.com>
To: Aleksandr Nogikh <nogikh@google.com>, Thomas Gleixner <tglx@linutronix.de>
CC: syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
	"tytso@mit.edu" <tytso@mit.edu>
Subject: AW: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
Thread-Topic: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
Thread-Index: AQHaDIZZW5UR1HqD5EWJAELZX43HQ7BlbUWAgAGEZQCAAYDX8Q==
Date: Fri, 3 Nov 2023 11:17:51 +0000
Message-ID:
 <AM9PR10MB433861B49A1EBB837087742895A5A@AM9PR10MB4338.EURPRD10.PROD.OUTLOOK.COM>
References: <000000000000cfd180060910a687@google.com> <875y2lmxys.ffs@tglx>
 <CANp29Y7EQ0cLf23coqFLLRHbA5rJjq0q1-6G7nnhxqBOUA7apw@mail.gmail.com>
In-Reply-To:
 <CANp29Y7EQ0cLf23coqFLLRHbA5rJjq0q1-6G7nnhxqBOUA7apw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-03T11:17:49.741Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Intern;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4338:EE_|VI1PR10MB3343:EE_
x-ms-office365-filtering-correlation-id: 19e69caf-552b-492a-a4d5-08dbdc5e84a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 77xavg5EzcZbCiQCBQt2dU01h9VcXbOJRxV9u5IzNs8Yb6kyqQDDmnDjPtj7mugbSqMenftWUZ7VQrE8RMvnF5RGegOBJJiZjTKPv5IVMskk4OYqYyomdyRmsZQd/+RaYfSfBciQy5D3MyBWfxEzwLD767bjmx/DXwjDxk47Z93MobhT3kHATdXwXoxvrhnVPFplv6vNLEsEv3SdCQ0iOaiELqrXtfsZj1/bQw3dch9ZGB5X48J/NNyZwvXLWCyibmBHvf22+31DbjsSv+W+hnr1h1xARE33XNfwYaNCehB3kPbxjWi5knNXYIThOtk/h4IbRxdlSBwW4Xn7kMBMArhbaIsApthlEw1OtEwJhzi+M9rJAJbUlbpno4IyrW7Y3TnOLydfZykqjHBw8BjMWniLCKSaeLtD/sadl7IsPz6sBDZdc7Q0S/BckIhzngmQVbsBmxjJJE2hD1NhTNxrBKRPgnB2BVs8VUa1GdtaB7HdSdFXRGFEf2HfE+7xoUsJhhW5UzPWGqrel0NPyWRsoL1jop4nMQRwLUpZKQyrSo/v9uFvT1stNvBmkqJ0+13amom43kVzTfAoHn1GuTYsc2qhmLNad/Off/iL79v3DXsYwRCGGJOfnoP/KjzmCBzA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4338.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38070700009)(52536014)(8676002)(4326008)(8936002)(5660300002)(41300700001)(2906002)(83380400001)(55016003)(45080400002)(33656002)(71200400001)(6506007)(55236004)(7696005)(9686003)(26005)(82960400001)(66446008)(122000001)(66476007)(54906003)(66946007)(316002)(91956017)(66556008)(110136005)(86362001)(76116006)(478600001)(64756008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vyHyUveS+SzQx8XY7p8hqBV7TmyDWZrRve/DPr8j3J/JIcRAEBi1uhD7Gt?=
 =?iso-8859-1?Q?kJ7PV2gKwfhXIyMowhC+gC0o/8hCI+IX/lAuHoh66/w145ilbGbZJODq5C?=
 =?iso-8859-1?Q?PVWfsvDNuDtKPITbURNeyxQ8a20uB8v8a4ckuOIjvHNmN0ljSRGTMm2AAV?=
 =?iso-8859-1?Q?oiBYUJEukMylp8sPJamAwEpUUVh6urf1rAyJA/WTONSFRh/yw3au5Chn1+?=
 =?iso-8859-1?Q?WLyFVQ3rbYx6tIvjx9XW54qWUEE721QMNdN1ViU/UczxMk1Uywb/P8xfbc?=
 =?iso-8859-1?Q?VULJvnzePQEZy9sM9hT3zaYSB+6nQ3ZkavR4KYj1wI3kwXIwvvfV36n9qP?=
 =?iso-8859-1?Q?qmPaJlnA4L9vy39WMKagvcRlrIzT15gnuz3PdpF4g2xyEKx/X3MUplVAFi?=
 =?iso-8859-1?Q?KsDmgzeL+xdhxgDec0QbsULLMIhEC3jttlAh+vyHzxBzva0stNavFbzgZT?=
 =?iso-8859-1?Q?dxgV7RuEyLGEqi7ClOHz+S70gNg2zHT6rMa1f/aSwjw/u384r3RAFcDLC3?=
 =?iso-8859-1?Q?q7oguT572YLcpZMx9tCkyLUc0FNQwpfQiJSQg5e10Ka4IjdpDAf4I85D50?=
 =?iso-8859-1?Q?zk2eq1eglajZDtK42xRNeDajT111VeOtLDhK50iOYzOgdMBo9mDXFkUiAG?=
 =?iso-8859-1?Q?UYmeXw6l46zgpYeYnjWCQYXBuIpV6WasWxL0+iImBagxGIV7CPQZxF2C1V?=
 =?iso-8859-1?Q?n+CQQ9ZWXUoXVG58Ky11HC5URFRvbT/zMmQjPZg422utFfrsPjkkaRC2HP?=
 =?iso-8859-1?Q?nvUBSC+u8A2ZmE8zflYcqs1WqOQepieCKv0ArapX+uTfaaR65ZLSOhOJZO?=
 =?iso-8859-1?Q?dntjudGQDD1xlShPeMVuXoT4vBx3uNVtfQgkN1x1uxRl/kBPD0WGzrBvV3?=
 =?iso-8859-1?Q?A0tYZGtLPLIXg3MoqlRQ9eUsfpedBJXDduXBXjxTjiCDg7xgSfPGiO0tLe?=
 =?iso-8859-1?Q?mZQnhEStfm2n7xrn5JD7KShxwmwqi4CUampRS5gjTO2J3FytwS0MaUz/ii?=
 =?iso-8859-1?Q?8ry9n3wJBKtEHLa2U9Hvp7YMR/O/3WftSVsxCIglW6pdxijutAyAfvC13r?=
 =?iso-8859-1?Q?IQSVFg7SzAKp9PCW9Kvng8urM/eAPPsaGNv3qOwQ5XDVmQTQfO1nKqpCKF?=
 =?iso-8859-1?Q?JXs/HaHfcXHTEygnBSfOeBxlBTXnAv50+WqvtreJDBhaozvdyWTO+CGugS?=
 =?iso-8859-1?Q?49kjcuS1PdRCVzAryl+LrVZjX+hCPSE5WIGVn5KuXL904/Z1e6FdssGlBd?=
 =?iso-8859-1?Q?K6+JaQqi2x2VIpPTqBPavOuWCIc12ToHtZ8/udYDcnihb0awet2icFYcHs?=
 =?iso-8859-1?Q?AMIIF0cSHYMu3b/ZGdM7g8cHSkxWwu90zOUPgMr0sVLFcA8TOBoL3i6V/k?=
 =?iso-8859-1?Q?0JkMRXL6r84qyHMU2g16/Ljd3KmCnYDvjIo8xL4bIQm8nzKwD5o3HngozT?=
 =?iso-8859-1?Q?hKJ9WKhsoVrt8IQrK+tBkH1uRNi1x0y9XZbrkQKWu8EfPuCpNswG6SJJjR?=
 =?iso-8859-1?Q?Mp0hq15XcKXOAybVO52vyVXJghjzWBtv8HBLYnSIjriOxL8a1pIAgd8XZi?=
 =?iso-8859-1?Q?s3NS1hu1cTZv+MgN4kyGjN449mKqW6uyq0Uh2/sEB6z7jDWR0O/7i9dLPY?=
 =?iso-8859-1?Q?cxSqDN7Ba+pY2zMHlhEX6W6tiX+RoBggHC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4338.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e69caf-552b-492a-a4d5-08dbdc5e84a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 11:17:51.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzaFyb7A7bcGNS6P9Sm/28NDo64x2ih1KHC0vAE7GATZTmGH26OA8Q1GFkxTnh+4e6ujVXnIkiMWIFty3gFKKhCdF0m5uyvnOz36tSBOAxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3343

Hi,=0A=
=0A=
> [  125.919060][    C0] BUG: KASAN: stack-out-of-bounds in rb_next+0x10a/0=
x130=0A=
> [  125.921169][    C0] Read of size 8 at addr ffffc900048e7c60 by task kw=
orker/0:1/9=0A=
> [  125.923235][    C0]=0A=
> [  125.923243][    C0] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.6.0-=
rc7-syzkaller-00142-g888cf78c29e2 #0=0A=
> [  125.924546][    C0] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)=
, BIOS 1.16.2-debian-1.16.2-1 04/01/2014=0A=
> [  125.926915][    C0] Workqueue: events nsim_dev_trap_report_work=0A=
> [  125.929333][    C0]=0A=
> [  125.929341][    C0] Call Trace:=0A=
> [  125.929350][    C0]  <IRQ>=0A=
> [  125.929356][    C0]  dump_stack_lvl+0xd9/0x1b0=0A=
> [  125.931302][    C0]  print_report+0xc4/0x620=0A=
> [  125.932115][    C0]  ? __virt_addr_valid+0x5e/0x2d0=0A=
> [  125.933194][    C0]  kasan_report+0xda/0x110=0A=
> [  125.934814][    C0]  ? rb_next+0x10a/0x130=0A=
> [  125.936521][    C0]  ? rb_next+0x10a/0x130=0A=
> [  125.936544][    C0]  rb_next+0x10a/0x130=0A=
> [  125.936565][    C0]  timerqueue_del+0xd4/0x140=0A=
> [  125.936590][    C0]  __remove_hrtimer+0x99/0x290=0A=
> [  125.936613][    C0]  __hrtimer_run_queues+0x55b/0xc10=0A=
> [  125.936638][    C0]  ? enqueue_hrtimer+0x310/0x310=0A=
> [  125.936659][    C0]  ? ktime_get_update_offsets_now+0x3bc/0x610=0A=
> [  125.936688][    C0]  hrtimer_interrupt+0x31b/0x800=0A=
> [  125.936715][    C0]  __sysvec_apic_timer_interrupt+0x105/0x3f0=0A=
> [  125.936737][    C0]  sysvec_apic_timer_interrupt+0x8e/0xc0=0A=
> [  125.936755][    C0]  </IRQ>=0A=
> [  125.936759][    C0]  <TASK>=0A=
=0A=
i had sporadic similar issues with 4.14 kernels (several maturities, .147  =
.212  .247  .300) in the past 5 years where stack looked quite similar:=0A=
=0A=
[  432.041880] general protection fault: 0000 [#1] PREEMPT SMP NOPTI=0A=
[  432.048697] Modules linked in: intel_tfm_governor ecryptfs coretemp i2c_=
i801 sbi_apl snd_soc_skl sdw_cnl snd_soc_acpi_intel_match snd_soc_acpi snd_=
soc_core snd_compress snd_soc_skl_ipc xhci_pci xhci_hcd sdw_bus crc8 ahci s=
nd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core libahci snd_hda_core libata=
 snd_pcm usbcore mei_me snd_timer scsi_mod usb_common snd mei soundcore fus=
e 8021q inap560t(O) i915 video backlight intel_gtt i2c_algo_bit drm_kms_hel=
per drm firmware_class igb_avb(O) ptp hwmon spi_pxa2xx_platform pps_core=0A=
[  432.099672] CPU: 3 PID: 5729 Comm: dlt_segmented Tainted: G     U     O =
   4.14.244-apl #1=0A=
[  432.108909] task: 00000000504d2561 task.stack: 000000007d0046fd=0A=
[  432.115530] RIP: 0010:rb_erase_cached+0x31/0x3b0=0A=
[  432.120683] RSP: 0018:ffffa31d84f77d40 EFLAGS: 00010006=0A=
[  432.126517] RAX: 0000000000000001 RBX: ffffa31d84f77e30 RCX: 00000000000=
00000=0A=
[  432.134485] RDX: 0000000000000000 RSI: ffff9ed077c1bb10 RDI: ffffa31d84f=
77e30=0A=
[  432.142456] RBP: ffffa31d84f77d40 R08: ffffa31d84f77e30 R09: 0000a31d80a=
77c90=0A=
[  432.150426] R10: ffff9ed077c1bee0 R11: 0000000000000400 R12: ffff9ed077c=
1bb10=0A=
[  432.158394] R13: 0000000000000000 R14: ffff9ed077c1bac0 R15: 00000000000=
00000=0A=
[  432.166366] FS:  00007ff718cce700(0000) GS:ffff9ed077d80000(0000) knlGS:=
0000000000000000=0A=
[  432.175403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[  432.181819] CR2: 00007ff7182ca3e4 CR3: 000000026175c000 CR4: 00000000003=
406a0=0A=
[  432.189790] Call Trace:=0A=
[  432.192526]  timerqueue_del+0x1d/0x40=0A=
[  432.196617]  __remove_hrtimer+0x37/0x70=0A=
[  432.200898]  hrtimer_try_to_cancel+0xa0/0x120=0A=
[  432.205769]  do_nanosleep+0xa9/0x180=0A=
[  432.209765]  ? kfree+0x169/0x180=0A=
[  432.213370]  hrtimer_nanosleep+0xbb/0x150=0A=
[  432.217849]  ? hrtimer_init+0x110/0x110=0A=
[  432.222134]  SyS_nanosleep+0x6d/0xa0=0A=
[  432.226126]  do_syscall_64+0x79/0x350=0A=
[  432.230218]  entry_SYSCALL_64_after_hwframe+0x41/0xa6=0A=
[  432.235861] RIP: 0033:0x7ff7199b7240=0A=
[  432.239850] RSP: 002b:00007ff718ccddf0 EFLAGS: 00000293 ORIG_RAX: 000000=
0000000023=0A=
[  432.248309] RAX: ffffffffffffffda RBX: 00007ff718ccde20 RCX: 00007ff7199=
b7240=0A=
[  432.256282] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ff718c=
cde20=0A=
[  432.264252] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000=0A=
[  432.272222] R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffe333=
ec72e=0A=
[  432.280190] R13: 00007ffe333ec72f R14: 0000000000802000 R15: 00007ffe333=
ec730=0A=
[  432.288161] Code: 89 f8 4c 8b 4f 08 48 89 e5 4c 8b 57 10 74 0a 48 3b 7e =
08 0f 84 a6 02 00 00 4d 85 d2 0f 84 28 02 00 00 4d 85 c9 0f 84 03 02 00 00 =
<49> 8b 51 10 4c 89 cf 4c 89 c8 48 85 d2 75 0b e9 65 02 00 00 48 =0A=
[  432.309346] RIP: rb_erase_cached+0x31/0x3b0 RSP: ffffa31d84f77d40=0A=
=0A=
Looks like it's worth to dig inside that.=0A=
Unfortunately i wasn't able to reproduce this, and i'm still not. So i can'=
t help digging but wanted to tell that this seems not to be related to a sp=
ecific kernel ....=0A=
=0A=
Thanks=0A=
Carsten=0A=
>>=0A=
>> Thanks,=0A=
>>=0A=
>>         tglx=0A=
>>=0A=

