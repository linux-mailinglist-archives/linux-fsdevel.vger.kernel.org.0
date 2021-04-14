Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196F335F9AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhDNRS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 13:18:28 -0400
Received: from mail-dm6nam12on2123.outbound.protection.outlook.com ([40.107.243.123]:23182
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349625AbhDNRS1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqNlf3dAnwH+fNFmBeW893RAOwgtVVzVzWyZemh9SXMarLeXuzbQG5HZtzRsGQUap1HWdqqVY9HPYB2/DpVPUmaQV8Azc40fMiQFgodgODd6U1cwRA41gQqEDawdpeOwiSv8JWizprG2CuZctMJufxe2cgLVyg9qeJWQ2mLjnqOL8Vw1w2qmWn68w/gp/vOaLb3R8RdpauQazcPT+IKqAXWDkea12KY0tKXHeKJ0LHQAKSgdGer3wDYGvTa1gF2kFmjcbILX2drNcfZpOV4+iRLOHoIk2z8Ho0WfmtucJBv/PdMMHBF40J4coIx/Ngc1rTf6oGkauYqyNkIHtFSB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUao4kEV7c0l/DD+Uh3tS1Is1ksZm0iKq2zxDDoMu+I=;
 b=enYSa9I1u0Xq/ZJWESgGs1+ZWfuiXzmpyHQjhvk4wJg03Cp513KdtTTo678VYP4OO/1xloYrJfOMK8Gvh6gxj8Hr0Faap8ARClEJMtsmyNJCeL21Bl29q0iz24FX+EZ9VTsrg1z7myNTUa0zXgThSuhNgQds9TZVHNYHfycoOPCNnOLaXGEVwZHXDixz4XX4dXoDEzk6+1dovwGHGbsL+W5XMclXHVxKNDd5BN5yu5Artcie4XOlvbOA6L5GpDAWma5p70Pu7V3QrN3trYC5naCD9zW1KuJI6KVv+G1oGV5wfgFGuywOiDCIACgONe2N7nZl53tvq5tePIlntM/Lgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUao4kEV7c0l/DD+Uh3tS1Is1ksZm0iKq2zxDDoMu+I=;
 b=KJd2ySXJT/6IvgIJOUE9HjB6g8tOFIOFVopFt1jmbz4DOOzEXXx6kI79487+loXAK6KeUGfPpH9yLJ3cCEmbf4Fv1l6x/3S10jHxgbOkvkLmY70sqlwqMPMg3Ng1MIbaOEUV9tfA69ah5nO8nyXR2KEKYf8mkvsjb2X3ttra4Fw=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1832.namprd22.prod.outlook.com (2603:10b6:610:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 17:18:05 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fd2f:cbcc:563b:aa4f]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fd2f:cbcc:563b:aa4f%5]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 17:18:05 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "hch@lst.de" <hch@lst.de>
CC:     "zhangdaiyue1@huawei.com" <zhangdaiyue1@huawei.com>,
        "qiuge@huawei.com" <qiuge@huawei.com>,
        "chenyi77@huawei.com" <chenyi77@huawei.com>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: A concurrency bug between configfs_dir_lseek() and configfs_lookup()
Thread-Topic: A concurrency bug between configfs_dir_lseek() and
 configfs_lookup()
Thread-Index: AQHXMVIhJa1wQhfpXUeAfFXThKGNPw==
Date:   Wed, 14 Apr 2021 17:18:04 +0000
Message-ID: <580AFC85-44F4-490C-A048-D03B92341ABC@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: evilplan.org; dkim=none (message not signed)
 header.d=none;evilplan.org; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 680339c6-7076-469e-9361-08d8ff6943fb
x-ms-traffictypediagnostic: CH2PR22MB1832:
x-microsoft-antispam-prvs: <CH2PR22MB18320BE7BC41D3AFEC5DEB02DF4E9@CH2PR22MB1832.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8yauGTVhl6BvkbHea5BPWgACLNXzLmHgns3WuCKPKlrYblIVI+/qWPW0W0j9Ea3DKrEZB3w+wLmITyhdsqNNGPJVfV6HRzW5qGuE1YdDAdDlj2lKg8g/vgl6VuAVGkacZY4rbvlC778AcY5sbuTKjZ3SbU5aaFewIWRefsGE5n7vuLLuBHMvzezMwUQDl5R2ru85kdnGgnQq/7qscRIhh9Mn2P0srD/YGoCQ0iBtkLcHJzrr/9ZLrYRe+fXlhpRHzvZEQYcEMKvm/KxHl8hgLSHprNpvRrvU/KTSx37MZm6b3Pw27gmMPsVer/48snlofvo/B4flyqal3tt8Qh3bwAvvUER32bHlty4sqronRZCVtiFbFFRVWhY7gv2O/zv2+Bfgr6d/XyVodnGDwnMFQqegnFCht19LFLBcjVZYLNCutmq8D+2EbkPubHZ/AK9HlR5ke+Z9RylEyE45o18ux3y2IQdC54xPMYrp2zPSZNpV0GoITvIbacG93kmaBcIlI1bQutAqQzU2/Mr3jXojhhTZCO3BkJ191z5yPfAUn+jkNDY+4AOZaDvs9cZ7y9M5OP3eJJwiwdwOWP+4tN7T5+7erWFVQXKBZuTllBPWas/mprAgoM0P7JOcl2ooNEvKQDV4NtH2evm3iXwEYlBW80pkvzCgkgOmjEpTxglNMHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(39860400002)(376002)(5660300002)(6486002)(26005)(186003)(71200400001)(122000001)(38100700002)(83380400001)(6506007)(75432002)(2906002)(33656002)(6512007)(86362001)(2616005)(478600001)(64756008)(66556008)(66476007)(66446008)(8936002)(66946007)(8676002)(316002)(4326008)(76116006)(36756003)(54906003)(110136005)(786003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N9GKNzZ/UUEBAeqN6GZLFp+GnLSXEpDNdPd6prh1i/++LJzES0SngiEvGH3J?=
 =?us-ascii?Q?7WmZ36YOss6IxHlKwjuURyCVtCdD0suun+C3ugZiUVPdUFU+oSI/tpYEU2OC?=
 =?us-ascii?Q?RrL9lVkqagEGZxyu1QKHdG0kCXp3HjVgRn7mGohsTuHjJFdP16U/w5GEVkRp?=
 =?us-ascii?Q?Y2LkoN9DrCQgNXaJQrZLqfD95O/z1PNr5ZPq/PliHwImIu2UKd6ECTdShjr5?=
 =?us-ascii?Q?BfNVi12BRG2fp0vDtD/7R4RGxbT5YRbOBFjpLQQTqtcj9p/QzANCJWjzjFBu?=
 =?us-ascii?Q?VxZRKN0FRUgXoTWjxV2EsV37Am1eTffO2WKEZkmLSLPCdK9Wc1IHczgEogIt?=
 =?us-ascii?Q?ZgKTqHG4A+HFJ9Ma581rhAGJfrFqyc1PGB1nsIE7REY2t03I8gulslpk2rhs?=
 =?us-ascii?Q?S5DQxiDqn/URmz1ilx9F7hd6uwr5VY9XDgHqlwL+8tcv9JSX2oqkT7m9HZV6?=
 =?us-ascii?Q?xH/ax90kfU+rrfrOb0UZkY86BOaz+f0pIE11f2lcEFZNdzGZwPktRJkLT39u?=
 =?us-ascii?Q?rbOzK89Yn6igu2wiwAb+Ht8bbN3a8iBderA8CEYqI3Z1untP8omYDBaWV9To?=
 =?us-ascii?Q?Tkib44DBWDpmelHWn6JibdhdYDms4Gt6TOaGmOZ4m8dBKLZOJyrgTDyf9daZ?=
 =?us-ascii?Q?J+wz/fvqVSvtRNFnaS6q9AvbJ9DPiDLMg5Npc2GJSPDdrv78X1DOqpfjby3W?=
 =?us-ascii?Q?+Jcu3DP/kShqggxdoPiZfyvfYJYN6ep+TpgxmzdzwBFn0tewN+VKadh2Igmz?=
 =?us-ascii?Q?/bcaBJMJTkHHtJXBxoA6ikERf3iT5NPn6MvaGDGWvxqxoJ6nJlc+GE6bCTn1?=
 =?us-ascii?Q?gJAbfdWgDn4JyLkV0hW7YKhocRKH05aiDWoWr5ta9Xv40RkFuKZLPjE3tpnp?=
 =?us-ascii?Q?+5A87uGK/lmoMZrtnNrrG22ct1BFwu8EXYuZ033Mb9YcG5a+3KYQ1RXBDvuc?=
 =?us-ascii?Q?2gohew2lfj9p8jRgIZWXGJAGfni+8eDHgZZu65UwChJxF7sjzrhdM0hLibM3?=
 =?us-ascii?Q?JuTAS6sdVaKI59cPwzPM4S010JBxM6r0gWEgr7+a6xAdRYEmyormgLeY+Dyb?=
 =?us-ascii?Q?zr+X7gqrY/H21JFkfE7WXAYnc4kpu8muSmTDZHAdDXDfhj/kgERuDmqh+RMb?=
 =?us-ascii?Q?yAD1+m7Kon19/J8YSG9kP/yxTzYlIeI+N/fQ1LVqlB8spC4TVaAWyKK/0SPZ?=
 =?us-ascii?Q?cDRVqP1shqZGYJYC9HtRDjXb/Irga4mTGTSRE1yOhWCuHQWpJ2wQIenoWqXn?=
 =?us-ascii?Q?Anyd2nTnye5x7AxnB1vdBCgTQvioI91cqoWQSLWsqydnqwcw2T0+Kw4VS8q1?=
 =?us-ascii?Q?ZY5goRoSfDtClDtR/eulJYf38pgNHNR7XJC6ch9GRS2WnQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <518D5E7E82D0804DAF6DB7B649CEE54F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680339c6-7076-469e-9361-08d8ff6943fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 17:18:04.6311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mD7RsTC0NuqB98mgU/QmhyF689Rmwh8biV6+rLqKcpNDnaX7DkUnV50j6PDA20Q8TtiMQvkQlEW2RFBUfh3KjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1832
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We found a concurrency bug in linux 5.12-rc3 and we are able to reproduce i=
t under x86. This bug happens when the two configfs functions configfs_dir_=
lseek() and configfs_lookup() are running in parallel. configfs_dir_lseek()=
 is deleting an entry while configfs_lookup() is accessing that entry, as s=
hown in below.=20

------------------------------------------
Execution interleaving

Thread 1								Thread 2
configfs_dir_lseek()						configfs_lookup()
								=09
										if (!configfs_dirent_is_ready(parent_sd))
										// configfs_dirent_lock is released after configfs_dirent_is_read=
y()
										list_for_each_entry(sd, &parent_sd->s_children, s_sibling)


spin_lock(&configfs_dirent_lock);
list_del(&cursor->s_sibling);
										list_for_each_entry(sd, &parent_sd->s_children, s_sibling)
										// error happens

------------------------------------------
Impact & fix

Eventually, this bug can cause a kernel NULL pointer dereference error, as =
attached below. We think a potential fix is to use list_for_each_entry_safe=
() instead of list_for_each_entry() in configfs_lookup().

------------------------------------------
Console output

[ 809.642609][T10805] BUG: kernel NULL pointer dereference, address: 000001=
18
[  810.198062][T10805] #PF: supervisor read access in kernel mode
[  810.836171][T10805] #PF: error_code(0x0000) - not-present page
[  811.361680][T10805] *pde =3D 00000000
[  811.869905][T10805] Oops: 0000 [#1] PREEMPT SMP
[  812.386532][T10805] CPU: 1 PID: 10805 Comm: executor Not tainted 5.12.0-=
rc3 #3
[  813.377094][T10805] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[  813.896812][T10805] EIP: configfs_lookup+0x44/0x1a0
[  814.431935][T10805] Code: 01 b8 f8 15 2f c4 8b 5f 20 e8 08 fd bb 01 b9 f=
e ff ff ff 81 e3 00 04 00 00 85 db 75 2f 8b 47 10 83 c7 10 8d 58 f8 39 c7 7=
4 10 <f6> 43 20 0c 75 26 8b 43 08 8d 58 f8 39 c7 75 f0 81 7e 18 ff 00 00
[  815.925387][T10805] EAX: 00000100 EBX: 000000f8 ECX: fffffffe EDX: c10d1=
cb0
[  816.450272][T10805] ESI: cd029900 EDI: c3c50930 EBP: cf54ff04 ESP: cf54f=
ef4
[  816.986662][T10805] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS:=
 00000286
[  818.033135][T10805] CR0: 80050033 CR2: 00000118 CR3: 0efd3000 CR4: 00000=
690
[  818.567560][T10805] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000=
000
[  819.109192][T10805] DR6: 00000000 DR7: 00000000
[  819.666769][T10805] Call Trace:
[  820.179775][T10805]  __lookup_hash+0x50/0x80
[  820.702414][T10805]  filename_create+0x70/0x130
[  821.238903][T10805]  do_symlinkat+0x4e/0x100
[  821.776290][T10805]  __ia32_sys_symlinkat+0x10/0x20
[  822.375670][T10805]  __do_fast_syscall_32+0x40/0x70
[  823.000644][T10805]  do_fast_syscall_32+0x29/0x60
[  823.494806][T10805]  do_SYSENTER_32+0x15/0x20



Thanks,
Sishuai

