Return-Path: <linux-fsdevel+bounces-72575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DABCFC191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 06:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F07E83043F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 05:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476BC26B973;
	Wed,  7 Jan 2026 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Zjy4zA51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013080.outbound.protection.outlook.com [52.103.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E3255F57;
	Wed,  7 Jan 2026 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764220; cv=fail; b=WdQh8D40QZMxoX2ujOOQImD4dhoYRXrgu5iRkB1zEC/w7p0T62ck8iG3nMquEQmnN8g+zmY0HQ6aJ4WMuRrEXjRmITnvbhRQAR7iWzL3suKZetVQBntM3ZPLl55/IKF7T0peJZPp6XqW2f1FHCW0OooNsXvVuW9Qih4/5nAyLAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764220; c=relaxed/simple;
	bh=vfBXSn97KYY7xDkNqCnjf3VFvohrimchkrvUYoxcCZw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GTN2VOKbRpNRdkWrn6Xkuy7y7+1ZKMjJ3XmXOkOutJ3bpkinNqmIiQuwmtVD/0y7n6EG3VEM7eBPldp3kyl6M2NAEMcDtiqa65/wjCFnMUXPyvT5aN0EFKWSq669iCBC3xl4px5AJ47kLMRxT8J4dS9DXAso3edFvmMEYzQKpz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Zjy4zA51; arc=fail smtp.client-ip=52.103.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BE3HXiaT/Pb4D+VeA42xCvgNz5f7fxWAHRjdsasgoCiUDnFpjuuGGlcKw/1XoWBEByHV6feoefybUWyfgETTANttiybm5mKAjYqebynGgSkZ+jW0bwf7Yp328Btwiv1/A886Rl2P9JCZ+KHEMR8x8Z7+kUuaPmM3+qlbR1ZljgnYRR6vYzX/swJnI8uPNyn44RzG/IRwWPfoxyS0ql4KSVez3wj/4Aq+NWV8wFv8iJqWFvrlUuM4VXU6lYEWJ28Z2oziOc54yBAUieEItFO+pV6+eQtqq8Jb8FK5HbjnyrEKt4M/QRNnNGT5mdP/4cnxfnEFyAtdKhxVmTa3GZDqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfBXSn97KYY7xDkNqCnjf3VFvohrimchkrvUYoxcCZw=;
 b=WsPtYzYEqzxZLcs0CA31UAIMcIZGoL93WH3jx2jMPnewJVbk7EjHELmIIvqe+jHfEBIy+oGwm09t7wKRdFq1vBPmr61F8Dfm8czckSplC7fqn0xxHnnQYtsJPm33KUbTl7lSCyypLAO0miVEyaDf4kwAqMRThzR9VqqcqjoNh8jFpfqvY5+SZhUDLrgpEF7wWm68DyhnNJHzMZMignx4TpG7JWINyNQ/5QAs3siKJYHQE+BEBUNfwddc05cxOJGxcwsbM6TzauKxfaZv1SlhAvYcCsk57fRM+Q+Pye55WtneZzHsqNYzFLIvUrk3jBcr0YZzGOWU6nekR4oA3cOeDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfBXSn97KYY7xDkNqCnjf3VFvohrimchkrvUYoxcCZw=;
 b=Zjy4zA51Wm1DSOtNjO0qgtGdiD69Box7xyBBX+MAB7fTT5kPKHw7P0kjGrgd0UMgEJMFGy0kVKdhCJilQwr9h6xLj3WMrffwKCnganWse7Wm8WthUAmVQdDaO0r2d+BQMf/5A31UZEDeIsuIv37dCKMcBCC2T0IFy7ZNGbdUy/Jy3ZucGG7syr971wjhc8qi2S55ff6jyjVWtwM9idV1c1F47WRiXyK93EBq/nrKpmmnYBK6qlEaqSj9FRuu4V7XL/opRH12Loxc+aQqp362Q1dlVPZ5Iy0pBgaPlIG903XMhC4wiWHzLUdj+UykmW1Oh9Qgk39cok489bXmo6TIzg==
Received: from KL1PR03MB8800.apcprd03.prod.outlook.com (2603:1096:820:142::5)
 by TY1PPF6FE718230.apcprd03.prod.outlook.com (2603:1096:408::a5c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 05:36:55 +0000
Received: from KL1PR03MB8800.apcprd03.prod.outlook.com
 ([fe80::95dd:dd8:3bbf:2c16]) by KL1PR03MB8800.apcprd03.prod.outlook.com
 ([fe80::95dd:dd8:3bbf:2c16%6]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 05:36:55 +0000
From: "WangzXD0325@outlook.com" <WangzXD0325@outlook.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>
Subject: Subject: [BUG] rcu: stall detected in __dentry_kill during file
 teardown
Thread-Topic: Subject: [BUG] rcu: stall detected in __dentry_kill during file
 teardown
Thread-Index: AQHcf5eY5TLNSudu8kCb3bY1LT8FUw==
Date: Wed, 7 Jan 2026 05:36:54 +0000
Message-ID:
 <KL1PR03MB8800D80C595910CA2E765B70A184A@KL1PR03MB8800.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8800:EE_|TY1PPF6FE718230:EE_
x-ms-office365-filtering-correlation-id: 498bcee2-00be-4485-a48a-08de4daec48e
x-ms-exchange-slblob-mailprops:
 xgbIMsDSu2YQP4YTVSfAdmvv3RzbJgGlfZmV6n35G/YHarE1AzHI727BLD1kaMKatzeXpK0p2RquDlNisfXaC7Nt9ZMf09OnBeRj3E/dkZzgOqubZGuIxlef5Zv7qKr70Ew/wJIEPjIWmIsS71XjS/ph7EH2RjeUkqz1KK2kqCppE5OkVWi0sJJvrQOG/Fufrn8qVFbDjAeDyx7C86DsiiH0XEU2/BaFw6AZpICye7uSDY0X5zdFX7rF/bCfrlhNWCeqiUh7c7eXOzGo4Mo16TCoBuj0//AJnqilCO4UZJaFy1DIpSCPNoZuATM7YOwFpH/BrbrRd5s+5u1oASpDk44JHNqcK/dambCMLxiiItxlNL38VcDFiAqnd+0oam0Eo3Xk93vDn9BrCUHeUm0ximIJRSCL2R8jjKPA4NqUHPo9sJQO9UZVz67Jr9dhZm6MSsgsT+n+l4VqxYtJuAFP9s9Zxv3l2kAfmkPHYYU7BulLMOrultuOqL6r/3ucn9C9O1f3g9fNn5YmjrjUVArcD+2cJTnua32GWgmOYQFVR1/5KnV2nuLJugKqx4GP+2uROI3JmX6mybacJqIkPApLmxRI+4oZRJ7m/ximYMzYXVp4judQ5YxOg0MlBWB05Gd3XIFdEIwMrzL9IW5j3zHnBHIpDEniy8LGTGYl/6dP82E11+nm5HO/GlBeDs67bPvQ3LNpc4UtdcDTklyY/iND7zDBQuDuGwDDbh5WQw5xdElaKzSkxZe4dqQcP7juoTtD9YutQdSaxOVLhn/OWs9JKa3Bxd2Q87Ga
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|12121999013|19110799012|15080799012|8062599012|8060799015|15030799006|461199028|440099028|40105399003|52005399003|3412199025|102099032|3430499032|26104999006|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?H0RvoOP74oEfuoKo+p7Oi4waiL4Wj+rMNRwM2Jf64AR+y8nvnN17/M8pl7?=
 =?iso-8859-1?Q?jgV/ueM9Kez3dXZdwARh6rOofMswuFCBMTsNnMEXbAEn7u3dVdymbUnLrd?=
 =?iso-8859-1?Q?7GwpEf3nXM2FgEvS6YqzC4jLvzpSap4hTyxu1uybVMcmRLYlo0jUHbpgfr?=
 =?iso-8859-1?Q?1F3XsyFofcV9O05Vo9RfjQYnvbkjZg6MRFYpfWDWyKim3yEsi3/YFp5IJ5?=
 =?iso-8859-1?Q?aumyW5sO6oaal4+S85E9ej0pgTNUUWjsdF4WnlFadTmDDkiT0YQrKKtQlP?=
 =?iso-8859-1?Q?xAfCcp7difOGAe43XOdMhGzA0e+xjzd4C2DC4pPsAueuXhiIr4YbheNBVo?=
 =?iso-8859-1?Q?QjMKOesWd6r67V6N6aQscfC902nM4VyhDITw0y2oIiyFoSA2q21eDtgFdL?=
 =?iso-8859-1?Q?fR67X80DEgwX4ZqSUJHdmh5kOSq9OI433q5SQjHH5OhnileFiLfTJiaHsC?=
 =?iso-8859-1?Q?jpIgbi3b8NVIKUJbSxktJJJMEa4fiqYcXFVrnwGFVTC7EWk16pquQgI6+Q?=
 =?iso-8859-1?Q?Ga97RslmLT3jVfdLq7B+IuxU2FzfEPYW3lg/vmr6COwMU4UG1E+hptxldi?=
 =?iso-8859-1?Q?mNw9fGkIUKpuFeHQISEEecy0Hm1RJsP2UcSL/QnDLQoTfVwz6q1X5UnycK?=
 =?iso-8859-1?Q?SScrITBCW22HBcP6UKdwzPJ267cNNzBAPPLbxmy0pNLkbHUcz4BiHiRQ+1?=
 =?iso-8859-1?Q?ME+/AjBCL8+lPLRl/IEdTKTJQtPBxBdYuFGMGuMJDq89XFMIspYUQ1fQBP?=
 =?iso-8859-1?Q?hqj9p5NHfEtuuUhM7AWyKUBEfEUQVCH5rDLJxBL6uLcUxBU/GXwXVTZBaH?=
 =?iso-8859-1?Q?Ecvtt73nFg/GGmJMnKSlN8AySMUbQxivBS3NwbaN+xw06UKi+4Rw2NnAkJ?=
 =?iso-8859-1?Q?qcZDs+0QKIuxawk0r/5zRhocq1EBB7s6+oEPb5Cb8QFjrTZUO95obxy8P8?=
 =?iso-8859-1?Q?ld3VW3Gz1d1DbfEFp/zsjDHJ7oxXyPdKflikXBWOzlNGB75g+eri30Zj9T?=
 =?iso-8859-1?Q?57fBLTCU1HThAQU7R/j6TOrElK8Q3f8Rcei0hoyxhCkxXTEyQH8hTHic+6?=
 =?iso-8859-1?Q?m6Rer5Vybbsb0iI7cgqaVm4nxWnZhqqi0DcVswwIP8Xgp+fq04OwbEPCC6?=
 =?iso-8859-1?Q?SWg5MixDYqDfCD/uVzDcBLNhRk0RjFjPOcKnleSFOvYxx6I3k0Y38MX8Ge?=
 =?iso-8859-1?Q?KBIs3johui1NoWuAhvyXSyoEKsUML0Qing7T9pfmsIIdd0+4eYN/60P4MQ?=
 =?iso-8859-1?Q?HuIKHFumJbOQJz1rJiQnAbN/YIYudtxyFZRCwVjm7bZNH3m4GX0hvmtf+1?=
 =?iso-8859-1?Q?qEi5v31o7pAnFU7pAJ0Dnenzx5Uay2eQP3Q6qn0vjsyIiWM2Znz81kBTqM?=
 =?iso-8859-1?Q?2a+gWNjbJA?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?I8I5sS1dhNiZHEcocX3DbOKLpjS7NpNA8VhvEES6Z0BJxRy+0oxXZ44aZY?=
 =?iso-8859-1?Q?8umjOge+FKdB9cCNIb7j2tYa5a+S/hYstV2pV9DJqa8F4kJLk4OPxRVh5q?=
 =?iso-8859-1?Q?OUNaveKrQDDWH7WSdouCGn8yTpJZ8QsM1sCX/JVLD7/ZVwJhiy5BxEciVC?=
 =?iso-8859-1?Q?LF93jQANo1KofZq5Grq/+UwDLVBXGWPaq84fmJRHMwEjv/HIKUooCBKGMe?=
 =?iso-8859-1?Q?2XGUyBEEu4/FR0dXi0M4y32CCsdI45H48YISRfQ1Z8Qxh9MRTqAUwbPOmV?=
 =?iso-8859-1?Q?feSLHisII7dGCSpLgI1MgIoxGMKo0Y40t0dvK1B6bhPIAzht1cIeJJ3SkH?=
 =?iso-8859-1?Q?D4pPPuh4N94m6tIpbyRao/fdJPcAzYve7Nl/udSBwVpQLj8JileTNQcDDm?=
 =?iso-8859-1?Q?+JpapAYhYCaLNEktg2qrAhOfa8mTOdUD3s+tZyk3DzLq7HSlVsDiW/DevF?=
 =?iso-8859-1?Q?skchwOZ6i6Oj4QyNX2N8cH7MMCypuZ+PXL0qL+qDfXzoMANiSrwo1lY9Z8?=
 =?iso-8859-1?Q?agUoJyN9QF4xey6Z8zQgZ6hy3AKRSmrT5O7sddJfCHcQYJIfvUvIgYcffa?=
 =?iso-8859-1?Q?QN7vpgAwlrOrFdvvgcBWbinIIGGcf8omAdiymTL53pfZ3huU7xUu1AWV15?=
 =?iso-8859-1?Q?IxT3R0xy/U8rWtSpuivFr00CoMLAaBJw0Oj7eG4T6LBgJJu6oDjczGa/gm?=
 =?iso-8859-1?Q?XKHRSKwx4JUFsaV8TJoGVAT9uAf+1MRc5w0n82TOO9v1fvalc0MwRGlSTm?=
 =?iso-8859-1?Q?7F+U8xN4zYPSmz6GAQ7usQG5+/9F59c7cSv8tlvd9vpedQ8RGMTIoiU1yh?=
 =?iso-8859-1?Q?jQXnftJbqCw7bG8xCezykwdXopMTdi1QHxkunug/PeAJGDmdlLHt5qWIwC?=
 =?iso-8859-1?Q?lf+jpb1YlITTA3zHdR0sFAJr1WK+65xFNeu4lAfzueLbCMTuHedRebRg3b?=
 =?iso-8859-1?Q?YpNs1p6B37IBW2f529GvZfIOxKl1gk0E+7BwAPcKQFqRLVBtWFoW4Ifzmf?=
 =?iso-8859-1?Q?mtMVX9A7drlGeGX13mW77ZC87uyCIvXBsTCMl0WotSJ6hN85d1De7swCT5?=
 =?iso-8859-1?Q?lGLzIn4Ib/571up9WnJ+NDAiXL7OzDKA9zSZCj0Tzz3UsPx6UGMp/zyNsW?=
 =?iso-8859-1?Q?UMilwQ2k9/NIy6yxCoKaJ/boyO3WuSf0jcYcK/mQIgQcCzL+PFI8eM5C8N?=
 =?iso-8859-1?Q?UzSYPWLHulS0eexAnLhYwdbYvQz88oQHkSGm6fOJyByBy8aufmg2LN0+B/?=
 =?iso-8859-1?Q?a/FaOROaxofmNhQXEaDO5QiR4p/ErOrAQkQ1fMVctwCYerQAdDe3zu6Zit?=
 =?iso-8859-1?Q?7wwNtYIvWWG8Xj1O4kQElJ9YKBsS2MraqLkcTgRdZyWMRYGPTgqaoWbP7P?=
 =?iso-8859-1?Q?aLsY3Pcy312rryWgl9p/oT1LY4ZGuMFCVTIClq9SCVqrqsy/0BRCOICu6o?=
 =?iso-8859-1?Q?g9hr0KQik5w5OUXX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8800.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 498bcee2-00be-4485-a48a-08de4daec48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 05:36:54.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6FE718230

Hello,=0A=
=0A=
I am reporting an RCU stall detected in __dentry_kill(), which was=0A=
observed during syzkaller-style fuzz testing. The stall eventually=0A=
leads to prolonged RCU grace-period starvation and system instability.=0A=
=0A=
=3D=3D=3D Summary =3D=3D=3D=0A=
The kernel reports an RCU preempt stall involving __dentry_kill()=0A=
during file and dentry teardown. One CPU remains stuck in a filesystem=0A=
cleanup path while holding locks, preventing RCU grace periods from=0A=
completing.=0A=
=0A=
The stall is detected reliably under syzkaller fuzzing.=0A=
=0A=
=3D=3D=3D Environment =3D=3D=3D=0A=
Kernel: 6.18.0 (locally built)=0A=
Config: PREEMPT(full)=0A=
Arch: x86_64=0A=
Hardware: QEMU Standard PC (i440FX + PIIX)=0A=
Workload: syzkaller (syz-executor)=0A=
=0A=
=3D=3D=3D Triggering context =3D=3D=3D=0A=
The stall is detected while a syzkaller executor process is exiting and=0A=
releasing file descriptors. The problematic task is in process context=0A=
during file teardown:=0A=
=0A=
=A0 do_exit=0A=
=A0 __fput=0A=
=A0 dput=0A=
=A0 __dentry_kill=0A=
=A0 dentry_unlink_inode=0A=
=A0 iput=0A=
=A0 evict=0A=
=A0 shmem_evict_inode=0A=
=A0 shmem_truncate_range=0A=
=0A=
At the same time, other CPUs are observed handling DRM-related atomic=0A=
operations and vblank timers.=0A=
=0A=
=3D=3D=3D Warning details =3D=3D=3D=0A=
The kernel reports:=0A=
=0A=
=A0 INFO: rcu detected stall in __dentry_kill=0A=
=A0 rcu: rcu_preempt detected stalls on CPUs/tasks=0A=
=0A=
The stall persists for over 10k jiffies, triggering NMI backtraces on=0A=
multiple CPUs.=0A=
=0A=
RCU also reports starvation of the grace-period kthread:=0A=
=0A=
=A0 rcu: rcu_preempt kthread starved for 10502 jiffies=0A=
=0A=
=3D=3D=3D Call trace =3D=3D=3D=0A=
Stalled task backtrace (CPU 3):=0A=
=0A=
=A0 lock_release=0A=
=A0 _raw_spin_unlock_irqrestore=0A=
=A0 hrtimer_cancel=0A=
=A0 drm_vblank_disable_and_save=0A=
=A0 drm_crtc_vblank_off=0A=
=A0 drm_atomic_helper_commit_modeset_disables=0A=
=A0 drm_atomic_commit=0A=
=A0 drm_mode_obj_set_property_ioctl=0A=
=A0 drm_ioctl=0A=
=A0 __do_sys_ioctl=0A=
=0A=
File teardown path involved in the stall:=0A=
=0A=
=A0 __dentry_kill=0A=
=A0 dentry_unlink_inode=0A=
=A0 iput=0A=
=A0 evict=0A=
=A0 shmem_evict_inode=0A=
=A0 shmem_truncate_range=0A=
=A0 __fput=0A=
=A0 do_exit=0A=
=0A=
=3D=3D=3D Observations =3D=3D=3D=0A=
The RCU stall occurs while tearing down dentries and inodes, suggesting=0A=
that a filesystem cleanup path may be holding locks or disabling=0A=
preemption for an excessive amount of time.=0A=
=0A=
The presence of DRM atomic commit and vblank timer activity in parallel=0A=
may exacerbate scheduling delays, but the stall is ultimately detected=0A=
in __dentry_kill().=0A=
=0A=
This points to a possible locking or preemption imbalance in dentry or=0A=
inode teardown paths, potentially triggered by adversarial userspace=0A=
behavior.=0A=
=0A=
=3D=3D=3D Reproducer =3D=3D=3D=0A=
No standalone reproducer is available.=0A=
The issue was observed during syzkaller-style fuzzing.=0A=
=0A=
=3D=3D=3D Expected behavior =3D=3D=3D=0A=
RCU grace periods should complete without stalls during normal or=0A=
malformed file teardown operations.=0A=
=0A=
=3D=3D=3D Actual behavior =3D=3D=3D=0A=
RCU reports prolonged stalls in __dentry_kill(), leading to repeated=0A=
NMI backtraces and RCU kthread starvation.=0A=
=0A=
=3D=3D=3D Notes =3D=3D=3D=0A=
Additional logs, full kernel configuration, or syzkaller artifacts can=0A=
be provided if needed.=0A=
=0A=
Reported-by:=0A=
Zhi Wang=

