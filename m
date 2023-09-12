Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8A79DC5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjILXCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 19:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjILXCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:02:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2119.outbound.protection.outlook.com [40.107.237.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D64189;
        Tue, 12 Sep 2023 16:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy1xyPJs3tzDPOExCLao5jP5LiXT5j6M7pyfUsE5oLQBkoZ+ypu1f2ez7/v6zJM5t0yfZAHXbaHK1uunxDJMuGCTnBZM0QzyIWpO29dGl0W0ewhfiMYP8c+QnMrsORI1+TV+9xj97pNkhkAYi8QmVoW7bcN9S1agh9f5fEykoofeRf2dinIUdDkwuTWRgS7xYBa6aqjxyOBdr2k6TCtxcSBWiMtChwouQas/h04Uj871IcBlTLtZ3Kbe4Sl7ye/Mk6i5sviZSd8S+6Z4G9b89yooG2o0EoCQyX4IEPqsAylUJ3up0eSggYj0rRf9fW1MhzOfhzppf3RVSqiAdMdo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE2Kp3WvxEQ0hgBpUgslgx3b5ISZevv7BfEGAWDD6hQ=;
 b=clzwtmG1OG3UBZaG5I5uigY0GcwbxU96C8wI1qEP6JqitrDJj2+OTTzRoaY/SZicLFsU7kQJZiVLapZuPtTx49p1XTGomWpZLtw8YtpZih4X1CO81ZNNrnZaf2RdJQG8EV7lY1Rd4TNc6aWeH111HgIbwvdKaqVrfvtsVvpdQAQHi5+2UgPOck94SEvFEbESd+i8WSmzMPeJh3bXLaNUkTeUYonZAKCKAD2Lw1k5r8JAfdfPhJTf0g+k8Z1KgSQZxJlAQJdoRMDGeJLYZSG6bOx//cfYf5W0AIj3F38uKgmFn2g4RoTliFliendE3taP24cuKt4wIi9UgGaNCwysrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE2Kp3WvxEQ0hgBpUgslgx3b5ISZevv7BfEGAWDD6hQ=;
 b=fGu9R8p9wBbu8ZkMwLp4swNtwH9i/WNNX5iA2CKmQawk+dYBW/rX0R3eQyf19mLm+Kimo5Y1WeZqOdCrRVWH8HBujtJsoJtUmIiXNQ3c8UAsq0M4iLDUCZS6LaX79Qqj7kMe6jXlL0WoKbKRAq53VVFeuxcJX+RJVQWInUIFi/c=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 23:02:25 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 23:02:24 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: KASAN: null-ptr-deref Read in filemap_fault
Thread-Topic: KASAN: null-ptr-deref Read in filemap_fault
Thread-Index: AQHZ4ct+BhcsU4wXUESm4cg1aigSwQ==
Date:   Tue, 12 Sep 2023 23:02:23 +0000
Message-ID: <BL0PR11MB31060BABA61005C5C8CBE092E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|DS0PR11MB7531:EE_
x-ms-office365-filtering-correlation-id: 1a5b1094-3d20-4e6d-2831-08dbb3e4539f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmap95hIFA2NljtLx3X3DshvLBBCmbAwdhRS7kC7RT0gUg6YKFsJt9KXlezyyJIATHnTJxbzM43o4XgUJWUmZ1lNF3oI2U3seV6RKNBcn880mSyJOMFLMcc1LWtkUfkJ04QmyBVGpkcfPSlgcli1jGJxK7F24/+Mc7tifF7OJbglRwdioVaW5YGeIl03HoGC/+DBvGOpCLviZ3zHh9IivYGERS3UzHwW2X0x0M5Ef/4VT4Wq7C5Dl1V2hdiy3vmn1qi1Pj/RGcy/jhYPy76qIKnHkqQ9R/yoxKUgAd/oaCbeK+INq228M2WmsK5LW97eljwZd+J8FaO7c5ayNIs/Y+dsKs0WGjNn3830zWZrrAtyOOGhKUPHbzdnpmQpnG3pecpvHX4ucfhvErqOg+vYeVEMmGghKhDR4fCBVa1/6sSKeOgJuQnHZOaM9KASm1Igh8Nvtlrm9qsgUQmJVk2fWNw9HJNjc9oU+UbCw8OvPgBJL90R4ED/xzphUHnxWKa89WQS4OPnxz7ndWxIr6R5B1xp8uqPEn/sZixHjeSVmoWeRjz6TNbqtQZLQZ6sKvfdYKhPFacITH7Qe0FLve3fINIWPelkMc+oyY6xIOZXA919bjU3tyEM+37NOZBcBLbEZbvn+S8HpUORPJa9hZ2juKTatjUbHDQhLgynuI7Aqoo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(366004)(376002)(1800799009)(451199024)(186009)(122000001)(5930299018)(6506007)(7696005)(71200400001)(33656002)(75432002)(38070700005)(55016003)(38100700002)(478600001)(45954011)(83380400001)(26005)(45080400002)(52536014)(86362001)(2906002)(9686003)(41300700001)(64756008)(966005)(76116006)(8936002)(8676002)(5660300002)(4326008)(110136005)(54906003)(786003)(66946007)(66446008)(316002)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sGraPi2hfVDqMOvGoqfZnJ0PZ5KNm/nEB/stW5oKP7CuqH89o2Q54ziHxf?=
 =?iso-8859-1?Q?rRtF2O0nhhlzQX2CqxSbRGK27mo1r862kxUxKZajBVLtLzvCsN0S2WSbJF?=
 =?iso-8859-1?Q?oais8QgTbWtc92EmB7hNrrwATSxw/ez1QzJkvi7vUJSevd4TCrDXHmXghV?=
 =?iso-8859-1?Q?3HW+JMpDYEyHEt6rzEHhUso4TVGrk3kmHbdoBW9Z+hItFKGJIHNrkFz/Gf?=
 =?iso-8859-1?Q?FRf8+IEsVWoonE9mDw9/OF0TfyWUdIhBSxPo1KSoLCUE9MftNR2QL3IYMH?=
 =?iso-8859-1?Q?6REg3rr9c3rzdBCOr+9A9aLS3PjKus0w7kemWcPPTvc74Lbl94p7nv9MON?=
 =?iso-8859-1?Q?mVoK4eEtXvrlz7ekinjSMLsuwY41Wgas6rO0uBGf/vlZROabJ4PQpdPZxm?=
 =?iso-8859-1?Q?VCGiYE9FpM0jlPhQuxSmn8twvd0wAgdm30lGBqxiGcbE0bph7Lx2z8P6NV?=
 =?iso-8859-1?Q?1/s+fBV5ggnxj40TUozG23l+XcTuXyawmGw23og33Gw5qosAfCFX6skVPb?=
 =?iso-8859-1?Q?wK2RMoT7rqibFVyAoNCq5RgKUaGsTWeXZYdE6J4e3ta+QMn+ipvWo1XT73?=
 =?iso-8859-1?Q?cnTXNFRTI5NdH/tPXKj7ehu7Syu12f8m4AJbst6pKcZeP3jcoTpHtwV43y?=
 =?iso-8859-1?Q?L3C14g8NedlMxrezcYsQ9mU0kRbqV26/aGq+/LHK/jh5HvjjkGxv4DvS39?=
 =?iso-8859-1?Q?z38eijuHrBQQwRtbdmpcDmWCW3zNiUdjID/JGljKTjSToixgyTe9qYswMo?=
 =?iso-8859-1?Q?/aEdlT0MgUpdy4UTfYwbA5XRbl7wSBsJPvry/QNxqi6IiVQFzZVanHL6a6?=
 =?iso-8859-1?Q?ASOGshHRI1oJ/C7u9b3XqOZ31/kZJgPy4MQl8y8jSUnJLWRWPka15d76B4?=
 =?iso-8859-1?Q?7NuHew3i0af9PazeIr68bWASH0Y7Eo6YovYRcncei6hE+z6BgMUZjMH/a/?=
 =?iso-8859-1?Q?CSuHFjubyspO8laUBhLvVlccVwSFFO0WoMerGI4LzxFv+GkuIytnDctIu9?=
 =?iso-8859-1?Q?ewB8UBDPDjrsVE//PwGnsaVE+OoZX3eU726Pmlhwo5+WXSJdq72CRoQKZT?=
 =?iso-8859-1?Q?8qh4MPAvUIyP5I9JGOH55m88d6abybfttImviaRD2JlXIJN9qFaQ/kDzEw?=
 =?iso-8859-1?Q?CvsmjCvihHx+76RnVMtbgMqwQeWAeFy88no9lGfMeWuiq3VMsyFL8jMX8y?=
 =?iso-8859-1?Q?WAY67D2XEuBefE4mfMayn0nM7m3lYrlLKaXw1J76ztprzKZhmOuibO8589?=
 =?iso-8859-1?Q?HiG6WyUmite22EwWgeMNQrXXWHTD2Di2xCclBA9E4HeBMNYxigs12K7ZSI?=
 =?iso-8859-1?Q?gx89ss32si+ALJ+zbGLxJyUAOYd7i+KqV1u/UjR0mXNbZejmDFv6taaMTE?=
 =?iso-8859-1?Q?2rI/u2bYHFblRsoZDDp4OJtcmtVH+sS1rlgLS5umQfNDMjZhTlNznsV4/H?=
 =?iso-8859-1?Q?OlTWEZyGJCdtKl0GwnTeWR9O6Zw6POVmv/ozJkIrNqoDf5N/AlMlwh2nvC?=
 =?iso-8859-1?Q?NuR0r1CUsQDbziLLscMeqaRjmMTrKqk1ZeuejdtQaLLbF4Vj8kYZ1Y/RMN?=
 =?iso-8859-1?Q?a73IKnDhKlM3rsM5F+ge/U6xGzU4eBhVNvpvvuFHlZzy1sjYzLDhkleb29?=
 =?iso-8859-1?Q?jzFUP6M0BJIZM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5b1094-3d20-4e6d-2831-08dbb3e4539f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:02:23.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUlQAAh0pnqcFoeb7Lp3+AUsGs1DF772TIzirAchOXmEVMbAP1XSbOPHQWTA5zKVRnaefSWJjyvrjpgVG4cPNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch: 6.3.0-next-20230426=0A=
Kernel Config: https://drive.google.com/file/d/1QmELMwhyVxAejCYF8VHxvAsExK6=
GtR8F/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1Qfns0v9ZZO6kge192F5wUzyFRcM0lH=
YU/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
BUG: KASAN: null-ptr-deref in filemap_fault+0x538/0x2500=0A=
Read of size 4 at addr 0000000000000028 by task syz-executor.2/5967=0A=
=0A=
CPU: 5 PID: 5967 Comm: syz-executor.2 Not tainted 6.3.0-next-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Call Trace:=0A=
 <TASK>=0A=
 dump_stack_lvl+0x178/0x260=0A=
 kasan_report+0xc0/0xf0=0A=
 kasan_check_range+0x144/0x190=0A=
 filemap_fault+0x538/0x2500=0A=
 __do_fault+0x103/0x3d0=0A=
 do_fault+0x68a/0x11c0=0A=
 __handle_mm_fault+0x106f/0x2660=0A=
 handle_mm_fault+0x1ab/0xa90=0A=
 do_user_addr_fault+0x583/0x12e0=0A=
 exc_page_fault+0xb6/0x1d0=0A=
 asm_exc_page_fault+0x26/0x30=0A=
RIP: 0033:0x7f6be40bc12c=0A=
Code: Unable to access opcode bytes at 0x7f6be40bc102.=0A=
RSP: 002b:00007ffc198c1350 EFLAGS: 00010297=0A=
=0A=
RAX: 0000000000000000 RBX: 0000000000001601 RCX: 00007f6be40bc11f=0A=
RDX: 00007ffc198c13d0 RSI: 0000000000000000 RDI: 0000000000000000=0A=
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001=0A=
R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffc198c13d0=0A=
R13: 0000000000000000 R14: 00007ffc198c144c R15: 0000000000000032=0A=
 </TASK>=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
general protection fault, probably for non-canonical address 0xdffffc000000=
0005: 0000 [#1] PREEMPT SMP KASAN=0A=
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]=0A=
CPU: 5 PID: 5967 Comm: syz-executor.2 Tainted: G    B              6.3.0-ne=
xt-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:filemap_fault+0x549/0x2500=0A=
Code: 00 00 e8 8a be d3 ff 49 8d 5c 24 34 be 04 00 00 00 48 89 df e8 98 08 =
23 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 48 8=
9 d8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b=0A=
RSP: 0018:ffffc9000b457b70 EFLAGS: 00010216=0A=
RAX: dffffc0000000000 RBX: 0000000000000028 RCX: 0000000000000000=0A=
RDX: 0000000000000005 RSI: ffffffff81d1bdb1 RDI: 0000000000000007=0A=
RBP: 00000000000000ac R08: 0000000000000007 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 74206c656e72656b R12: fffffffffffffff4=0A=
R13: ffff88810d9b34c0 R14: 0000000000000008 R15: 0000000000000001=0A=
FS:  0000555556b73980(0000) GS:ffff88811a280000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f6be40bc102 CR3: 0000000055006000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 __do_fault+0x103/0x3d0=0A=
 do_fault+0x68a/0x11c0=0A=
 __handle_mm_fault+0x106f/0x2660=0A=
 handle_mm_fault+0x1ab/0xa90=0A=
 do_user_addr_fault+0x583/0x12e0=0A=
 exc_page_fault+0xb6/0x1d0=0A=
 asm_exc_page_fault+0x26/0x30=0A=
RIP: 0033:0x7f6be40bc12c=0A=
Code: Unable to access opcode bytes at 0x7f6be40bc102.=0A=
RSP: 002b:00007ffc198c1350 EFLAGS: 00010297=0A=
RAX: 0000000000000000 RBX: 0000000000001601 RCX: 00007f6be40bc11f=0A=
RDX: 00007ffc198c13d0 RSI: 0000000000000000 RDI: 0000000000000000=0A=
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001=0A=
R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffc198c13d0=0A=
R13: 0000000000000000 R14: 00007ffc198c144c R15: 0000000000000032=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:filemap_fault+0x549/0x2500=0A=
Code: 00 00 e8 8a be d3 ff 49 8d 5c 24 34 be 04 00 00 00 48 89 df e8 98 08 =
23 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 48 8=
9 d8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b=0A=
RSP: 0018:ffffc9000b457b70 EFLAGS: 00010216=0A=
RAX: dffffc0000000000 RBX: 0000000000000028 RCX: 0000000000000000=0A=
RDX: 0000000000000005 RSI: ffffffff81d1bdb1 RDI: 0000000000000007=0A=
RBP: 00000000000000ac R08: 0000000000000007 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 74206c656e72656b R12: fffffffffffffff4=0A=
R13: ffff88810d9b34c0 R14: 0000000000000008 R15: 0000000000000001=0A=
FS:  0000555556b73980(0000) GS:ffff88811a280000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f6be40bc102 CR3: 0000000055006000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess):=0A=
   0:   00 00                   add    %al,(%rax)=0A=
   2:   e8 8a be d3 ff          call   0xffd3be91=0A=
   7:   49 8d 5c 24 34          lea    0x34(%r12),%rbx=0A=
   c:   be 04 00 00 00          mov    $0x4,%esi=0A=
  11:   48 89 df                mov    %rbx,%rdi=0A=
  14:   e8 98 08 23 00          call   0x2308b1=0A=
  19:   48 89 da                mov    %rbx,%rdx=0A=
  1c:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax=0A=
  23:   fc ff df=0A=
  26:   48 c1 ea 03             shr    $0x3,%rdx=0A=
* 2a:   0f b6 14 02             movzbl (%rdx,%rax,1),%edx <-- trapping inst=
ruction=0A=
  2e:   48 89 d8                mov    %rbx,%rax=0A=
  31:   83 e0 07                and    $0x7,%eax=0A=
  34:   83 c0 03                add    $0x3,%eax=0A=
  37:   38 d0                   cmp    %dl,%al=0A=
  39:   7c 08                   jl     0x43=0A=
  3b:   84 d2                   test   %dl,%dl=0A=
  3d:   0f                      .byte 0xf=0A=
  3e:   85                      .byte 0x85=0A=
  3f:   7b                      .byte 0x7b=0A=
