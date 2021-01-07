Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9AD2ECC41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 10:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbhAGJE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 04:04:26 -0500
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:34633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbhAGJEY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:04:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGzgthBcu0HVYGBk4bWkR8qbOqd3gIj4RGnds/YWfKQJb/VORCI+m/EHn72CYLRhFdtPD7SbcamZFP8Mb9RVPIjTC4LoM9kxKxTwx7is9SdbwnYdR9dAQKGvdD4nG8AhE3n8+R2mMkkndQfcZ6sUcFjzV2F8MbgnYGreBAVsW9mWiNveQZmsI+3LmjREbo8jvxzWNlpMNAIj82zSjtFbJYVweGKtRshpYR/6+i4Ajjz1TKvdl5nxwaJ1RBLxep+trwJ4dj+0IilE9bS5IM/SOyPdcSP6UDVOfOEzG8Z7SVmtqqk9+Bz2C/exVpBaVUEorX668TXWNTDMQxg5Vsaa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ysOWxZwvertn9BJz2VVm0H/gkyHAailSk+Qcpp8ksk=;
 b=KUMGOBsXGD21VqWlE438QTXbI6N+71KFtBlcTLdIakMH4aUGK3eLXyg+y7qLEP+AvRV13QbuNvYwoCA1cd79qZPjq8ddJz5hTtN2YPLtQgEdeCcEHXNNe5GwBKpag3USh8KQAXM1S9OVhZmhr07CV1/CMO+l22uNn7dcWxA5Q3Cy7w/rU4tsAuENBnaav3cHwigUb4pYUWb0StfLJlZax9jgdhj1JCPnFco2VhygdUSGkPw1JVJ/uw1EHO+7uhYY7S+++IZv9MlkPUPWS0E0X7v6Rs24LZ0IvEj2xnK/L8RTGFQrh7IbhsPGFje7ZpVetILdac0G2SvERrtv26Azfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ysOWxZwvertn9BJz2VVm0H/gkyHAailSk+Qcpp8ksk=;
 b=bSbxl0dtnMajwQrBHUBkYLYYFksdjdn+oekZTnhWa/BlZ1N/5QNoWqgRDhK0uq5ggIdBE7S/toYMswe0nUKf2mM0DDpGBQVpshDXv/B+n7gs0kSg+8nl63xmcYc04FFFh4gzGCSe6yAaIxsAZ4GnMx+PjxcZJhha7NlAbtDRJT8=
Received: from DM5PR11MB1674.namprd11.prod.outlook.com (2603:10b6:4:b::8) by
 DM6PR11MB3596.namprd11.prod.outlook.com (2603:10b6:5:13a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Thu, 7 Jan 2021 09:03:41 +0000
Received: from DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::b41f:d3df:5f86:58f7]) by DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::b41f:d3df:5f86:58f7%10]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 09:03:41 +0000
From:   "Gao, Yahu" <Yahu.Gao@windriver.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "Gao, Yahu" <Yahu.Gao@windriver.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Review request 0/1: fs/proc: Fix NULL pointer dereference in
Thread-Topic: Review request 0/1: fs/proc: Fix NULL pointer dereference in
Thread-Index: AQHWzh1mOQ6BeYWdSkiqqAJfnADH4KnvT5fygCy7zhc=
Date:   Thu, 7 Jan 2021 09:03:41 +0000
Message-ID: <DM5PR11MB167466A8A782CAD4AAEB40BA99AF0@DM5PR11MB1674.namprd11.prod.outlook.com>
References: <20201209112100.47653-1-yahu.gao@windriver.com>
 <87zh2mprwl.fsf@x220.int.ebiederm.org>
In-Reply-To: <87zh2mprwl.fsf@x220.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM5PR11MB1674.namprd11.prod.outlook.com
 (15.20.3742.006)
user-agent: mu4e 1.2.0; emacs 26.3
authentication-results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9aad8a2-f300-40a2-9173-08d8b2eb20fe
x-ms-traffictypediagnostic: DM6PR11MB3596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3596E5D47CB3081158B3E8FC99AF0@DM6PR11MB3596.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SKT3inDPaHuUVTWX29YehWrFKt60ij6VpwHs2zv/gdwI7YBS3yFLUhL2AUZFDDtaY7II9uo2ZL0Rsaal3SFHtM4dxQ1ZTHnqfaBtzMWRP85/bcrtEsDxtd3eYU6A7f168VY7em74WSA3xgC839ySVdA+n5JlrZOIytZ/LJun+emF3QzmWcoxKPxIt6pgkuFm9mmvDTHPj5vS9MwG7ivfztrHlaELMk1IPZyTDghNuqea1ttQSKDxk2CbD6eGp/6fgVzLG0scAzON8uJcw/drOgTRG4xxFjUnwY6bjhUtB+0H/wf10ehWx7KfCmtjzyoKJQOlhM+jyKvelli9qr4EiNkexSExh5Oj2JxQ6kjPdovL2X3zCF0HcChD+Eu7s0gb5d7T9X7pJexgvyEelDtzWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(366004)(136003)(64756008)(66446008)(76116006)(66946007)(66556008)(71200400001)(66476007)(316002)(6916009)(6506007)(52536014)(54906003)(7696005)(55016002)(478600001)(2906002)(45080400002)(8676002)(9686003)(33656002)(4326008)(186003)(26005)(86362001)(5660300002)(83380400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?kmb4FgOXLp2BRhzyGukXHRigipgk4NFn7t+XugXKTlaf1dpWGb7L7ptSx0?=
 =?iso-8859-1?Q?gIgmXjxGT5pA140XtdXHxWfVBUL8pnnYJt5TMqe4Tv43FX8ncQrhUrRoH6?=
 =?iso-8859-1?Q?JncSvREVmrWQounMu7JwEpaRS1oSNOgZpR47gaOGsNdyAEzqnVxrDSdUpx?=
 =?iso-8859-1?Q?89xMg42zNmSC5EE0+fVxqOwsGmafIErkf5qVuS45SQ7pK06amBR9AY/S37?=
 =?iso-8859-1?Q?Vnr8HqoF5EUMh20sia6JfX6mmyhI5lrjxqaaQmcF9Mw4GWTdqoQD40rLxM?=
 =?iso-8859-1?Q?nYl2LuQ31B3RGzbl1kGV0rYDn3Ch6T6LDw/fTdlhPNP5+8Rx1D6t317W/D?=
 =?iso-8859-1?Q?f4B0anPZrYqKHZv068wMfoNQll4Qd227WQdySjQ3CivEMz1XA32o18EtyY?=
 =?iso-8859-1?Q?lbmFWLCUh8dskJOEOv4dhDE8HKcSRbMLZbvIfSTHoBSlTjhMQ9P5iwb/xY?=
 =?iso-8859-1?Q?jc1AA5ujTMdZ/wzxvMjzYhZKj5JgT6+U6PJpWRti6WxiY6AHd86GXw/mz8?=
 =?iso-8859-1?Q?vbjkMIVTdEQ5ygeYit3ukbn4BfBWoPYH4QFeGDKtErutnqx1EP/9B9hibE?=
 =?iso-8859-1?Q?CcwiFsCfn99DR5Gi9IV9V9iLr9Sj5FL8jwSx98PXQpodTZ4Q9Ia/rUawjZ?=
 =?iso-8859-1?Q?wNd3W/Pl4pTiTnW6JOmPdKa8a+hRsuL5vZnCKxM/dpT/xwqEvdond6rL0r?=
 =?iso-8859-1?Q?6OrbIl8SfUk1GZiAWYNUiTUcsaklIVfiA422kBJz8gymGZP2TNH+4lvJ8y?=
 =?iso-8859-1?Q?TfV409/GmTIwEQXuLZoBlkhxIj/FW+nCOLz5KkN0DqVBN4RBWcdpAK34z6?=
 =?iso-8859-1?Q?eicRLCS3Fjql+6uh6wsX110BDkjDUk0fxIuwONIZClMc7HvlckILQ7kleM?=
 =?iso-8859-1?Q?x3+v27NWIGMtfloTsFoOKc/CWA3MOpZgLqFS7oIZmHtkmUUKD8q/MYE1Ij?=
 =?iso-8859-1?Q?gJjNActLY5FwQGvfDm1z2zXkZG3l8ae87dcguZh+iwl94cNU6l8nsqiiDs?=
 =?iso-8859-1?Q?xremW8TIHBPpNQsXo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aad8a2-f300-40a2-9173-08d8b2eb20fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 09:03:41.2788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qB26qot3FCXC3XwZT5l9VWTpaNm+b99FBZEMXNcZWwaIjBTKoJiJYTzZ0v21l2VQhjhaYSko3Q0olkaC0qnISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3596
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=0A=
Eric W. Biederman <ebiederm@xmission.com> writes:=0A=
=0A=
> [Please note this e-mail is from an EXTERNAL e-mail address]=0A=
>=0A=
> Yahu Gao <yahu.gao@windriver.com> writes:=0A=
>=0A=
>> There is a kernel NULL pointer dereference was found in Linux system.=0A=
>> The details of kernel NULL is shown at bellow.=0A=
>>=0A=
>> Currently, we do not have a way to provoke this fault on purpose, but=0A=
>> the reproduction rate in out CI loops is high enough that we could go=0A=
>> for a trace patch in black or white UP and get a reproduction in few=0A=
>> weeks.=0A=
>>=0A=
>> Our kernel version is 4.1.21, but via analyzing the source code of the=
=0A=
>> call trace. The upstream version should be affected. Really sorry for=0A=
>> havn't reproduced this in upstream version. But it's easier to be safe=
=0A=
>> than to prove it can't happen, right?=0A=
>=0A=
> Except I there are strong invariants that suggests that it takes=0A=
> a memory stomp to get a NULL pointer deference here.=0A=
>=0A=
=0A=
Sorry for late reply. I took a long time to find root cause of memory stomp=
,=0A=
but got nothing for now:(=0A=
=0A=
> For the life of a proc inode PROC_I(inode)->pid should be non-NULL.=0A=
>=0A=
> For a non-NULL pid pointer ->tasks[PIDTYPE_PID].first simply reads=0A=
> an entry out of the struct pid.  Only pid needs to be non-NULL.=0A=
>=0A=
> So I don't see how you are getting a NULL pointer derference.=0A=
>=0A=
> Have you decoded the oops, looked at the assembly and seen which field=0A=
> is NULL?  I expec that will help you track down what is wrong.=0A=
>=0A=
There are two messages I had found:=0A=
1. 'Unable to handle kernel NULL pointer dereference at virtual address=0A=
 00000008'.=0A=
2. In kernel 4.1.21, the members of 'struct pid' likes follow:=0A=
(Apologize for missing this message at first)=0A=
...=0A=
struct pid=0A=
{=0A=
        atomic_t count;=0A=
        unsigned int level;=0A=
        /* lists of tasks that use this pid */=0A=
        struct hlist_head tasks[PIDTYPE_MAX];=0A=
        struct rcu_head rcu;=0A=
        struct upid numbers[1];=0A=
};=0A=
...=0A=
The offset of the member *tasks* from *struct pid* is 0x00000008.=0A=
=0A=
Based on the above message, I thought we got a NULL pointer of struct=0A=
pid.=0A=
=0A=
Regards,=0A=
Yahu=0A=
=0A=
>=0A=
>> Details of kernel crash:=0A=
>> ----------------------------------------------------------------------=
=0A=
>> [1446.285834] Unable to handle kernel NULL pointer dereference at=0A=
>> virtual address 00000008=0A=
>> [ 1446.293943] pgd =3D e4af0880=0A=
>> [ 1446.296656] [00000008] *pgd=3D10cc3003, *pmd=3D04153003, *pte=3D00000=
000=0A=
>> [ 1446.302898] Internal error: Oops: 207 1 PREEMPT SMP ARM=0A=
>> [ 1446.302950] Modules linked in: adkNetD ncp=0A=
>> lttng_ring_buffer_client_mmap_overwrite(C)=0A=
>> lttng_ring_buffer_client_mmap_discard(C)=0A=
>> lttng_ring_buffer_client_discard(C)=0A=
>> lttng_ring_buffer_metadata_mmap_client(C) lttng_probe_printk(C)=0A=
>> lttng_probe_irq(C) lttng_ring_buffer_metadata_client(C)=0A=
>> lttng_ring_buffer_client_overwrite(C) lttng_probe_signal(C)=0A=
>> lttng_probe_sched(C) lttng_tracer(C) lttng_statedump(C)=0A=
>> lttng_lib_ring_buffer(C) lttng_clock_plugin_arm_cntpct(C) lttng_clock(C)=
=0A=
>> [ 1446.302963] CPU: 0 PID: 12086 Comm: netstat Tainted: G C=0A=
>> 4.1.21-rt13-* #1=0A=
>> [ 1446.302967] Hardware name: Ericsson CPM1=0A=
>> [ 1446.302972] task: cbd75480 ti: c4a68000 task.ti: c4a68000=0A=
>> [ 1446.302984] PC is at pid_delete_dentry+0x8/0x18=0A=
>> [ 1446.302992] LR is at dput+0x1a8/0x2b4=0A=
>> [ 1446.303003] pc : [] lr : [] psr: 20070013=0A=
>> [ 1446.303003] sp : c4a69e88 ip : 00000000 fp : 00000000=0A=
>> [ 1446.303007] r10: 000218cc r9 : cd228000 r8 : e5f44320=0A=
>> [ 1446.303011] r7 : 00000001 r6 : 00080040 r5 : c4aa97d0 r4 : c4aa9780=
=0A=
>> [ 1446.303015] r3 : 00000000 r2 : cbd75480 r1 : 00000000 r0 : c4aa9780=
=0A=
>> [ 1446.303020] Flags: nzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment=
=0A=
>> user=0A=
>> [ 1446.303026] Control: 30c5387d Table: 24af0880 DAC: 000000fd=0A=
>> [ 1446.303033] Process netstat (pid: 12086, stack limit =3D 0xc4a68218)=
=0A=
>> [ 1446.303039] Stack: (0xc4a69e88 to 0xc4a6a000)=0A=
>> [ 1446.303052] 9e80: c4a69f70 0000a1c0 c4a69f13 00000002 e5f44320=0A=
>> cd228000=0A=
>> [ 1446.303059] 9ea0: 000218cc c0571604 c0a60bcc 00000000 00000000=0A=
>> 00000000 c4a69f20 c4a69f15=0A=
>> [ 1446.303065] 9ec0: 00003133 00000002 c4a69f13 00000000 0000001f=0A=
>> c4a69f70 c35de800 0000007c=0A=
>> [ 1446.303072] 9ee0: ce2b1c00 cd228000 00000001 c05747b8 c05745cc=0A=
>> c35de800 0000001f 00000000=0A=
>> [ 1446.303078] 9f00: 00000004 cd228008 00020000 c05745cc 33000004=0A=
>> c0400031 c4a68000 00000400=0A=
>> [ 1446.303086] 9f20: beb78c2c cd228000 c4a69f70 00000000 cd228008=0A=
>> c0ffca90 c4a68000 00000400=0A=
>> [ 1446.303103] 9f40: beb78c2c c052cd0c bf08a774 00000400 01480080=0A=
>> 00008000 cd228000 cd228000=0A=
>> [ 1446.303114] 9f60: c040f7c8 c4a68000 00000400 c052d22c c052cd8c=0A=
>> 00000000 00000021 00000000=0A=
>> [ 1446.303127] 9f80: 01480290 01480280 00007df0 ffffffea 01480060=0A=
>> 01480060 01480064 b6e424c0=0A=
>> [ 1446.303143] 9fa0: 0000008d c040f794 01480060 01480064 00000004=0A=
>> 01480080 00008000 00000000=0A=
>> [ 1446.303150] 9fc0: 01480060 01480064 b6e424c0 0000008d 01480080=0A=
>> 01480060 00035440 beb78c2c=0A=
>> [ 1446.303156] 9fe0: 01480080 beb78160 b6ede59c b6edea3c 60070010=0A=
>> 00000004 00000000 00000000=0A=
>> [ 1446.303167] [] (pid_delete_dentry) from [] (dput+0x1a8/0x2b4)=0A=
>> [ 1446.303176] [] (dput) from [] (proc_fill_cache+0x54/0x10c)=0A=
>> [ 1446.303189] [] (proc_fill_cache) from []=0A=
>> (proc_readfd_common+0xd8/0x238)=0A=
>> [ 1446.303203] [] (proc_readfd_common) from [] (iterate_dir+0x98/0x118)=
=0A=
>> [ 1446.303217] [] (iterate_dir) from [] (SyS_getdents+0x7c/0xf0)=0A=
>> [ 1446.303233] [] (SyS_getdents) from [] (__sys_trace_return+0x0/0x2c)=
=0A=
>> [ 1446.303243] Code: e8bd0030 e12fff1e e5903028 e5133020 (e5930008)=0A=
>=0A=
> Eric=0A=
=0A=
