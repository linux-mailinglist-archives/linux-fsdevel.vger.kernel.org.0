Return-Path: <linux-fsdevel+bounces-51831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74460ADBF9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3260D173661
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 03:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05334238151;
	Tue, 17 Jun 2025 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iWhwc8j6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2137.outbound.protection.outlook.com [40.107.223.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C0212B28;
	Tue, 17 Jun 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750129977; cv=fail; b=s/y+WCmqlTQYiWRPRPd7OlYj0b72r0SeD6db9yBNM7938QL42GZMh1blQeEMafjaQmh7gVMPhPLR743i9IXq71Z1uf9lJF0VElrOQarwgEWFttpfuBrJxhNRWRbcEYRtq+0rVZdqspy2u2nYdqmu3dKhAg6lw2ueTuhtT5fmeO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750129977; c=relaxed/simple;
	bh=DOLBZkZeTn3qXigT1MF9jlBp4BS3d0bspS6Sxlz8ryk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLkn/ZMvKKbOJ8At2JJqCz/7Nt1pOAcC87lM628QOqtNJK8tscIlHTv7u+fNeTjDBqkxlLDKkmOOAVQNSVz1HkDk2u8e9vZNnWklLPNsmmhXKnqi01Mktezlg91CdpfbovZrBOc4Z/EzOj1jqV0w9q9PC/AP7GOWt3+MRkcnIFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iWhwc8j6; arc=fail smtp.client-ip=40.107.223.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0UPfDOS6NjhrEJCSeYsXwf6C9bdFebDpzmLp0mxfJ8RpePiWs3yQCHAhnj4GDD6aBt5ZXi6Ksfct7Rk6DcAm+iGUt54173GBe4FS8QvGCq4sZuho03lo525IL3indlMV7DbDG4V/EzjQqUN5QKqMgJMt+ABnlKGc+q4hnoW5yShM0m/2ILz8oXRFg1UcfNOTLe6wf0YuNyXhMXcD0Km+OY0fk2F6HQbQTBT5W+XLNfbhwP1Jj46PtsER5tjEzbT8O+ZoDyNlVhS1OmJeEMYr9kILNdZHl4a6i85p3aZzwupoFYJvqMyupHfs5Q+koExUQkuf/WgpfcrspnRAvwg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBGOw4BqxZMKtTSWGY+3OB+ZcqaJ+HEpEgiMSqbvC6I=;
 b=WHOfHxyJgfHas2QZDGf5r3SNPOYCv+95ALieYfIfOk+HVMVZhKn+bEd/9qptUHuf2Ao4pmZDLwxkyuPtqPlr6SmAWStHw4vX5nGNLqWDcVDh0Zqk933NWgybqDwyYrpD9aKnFP42/WywCCSGW50BssKD3ktLM+TulbbSmDuZ8ZZwPGMu+t7DIxElrsBXii8+hJcF5HFE4f3chBdLntG+vxusv+7FYtgOi1VGtRfw/hILmCZIwwrkeo4MPwkWcz/u9MSJ3KMSMiHNY9RjKuy3JYx/H7QUKMby/aCXMX90DnKdC3XX4HAI2zj/K3GrCH0VAQ+Pguh9U8sEVzs6xQLIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBGOw4BqxZMKtTSWGY+3OB+ZcqaJ+HEpEgiMSqbvC6I=;
 b=iWhwc8j6Kb+F2nFMllY+8uOgHElxn37j12wP3BcVfvait3DkWKAi/wmVMqTbfuxUymRlQI04+Lk4ZSUckCEk0buE9pXLQTHAAcm97oxvGAFo9uk1plI//cYwqdKutUFMKo7+6pjernZrhmq6KbbKWaatxNDWxPmREoTDk6fAvDY=
Received: from BL0PR2101MB1313.namprd21.prod.outlook.com (2603:10b6:208:92::7)
 by IA4PR21MB5072.namprd21.prod.outlook.com (2603:10b6:208:557::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.6; Tue, 17 Jun
 2025 03:12:53 +0000
Received: from BL0PR2101MB1313.namprd21.prod.outlook.com
 ([fe80::41a:7834:dfad:d2da]) by BL0PR2101MB1313.namprd21.prod.outlook.com
 ([fe80::41a:7834:dfad:d2da%4]) with mapi id 15.20.8857.015; Tue, 17 Jun 2025
 03:12:53 +0000
From: Jason Rahman <jasonrahman@microsoft.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "kbusch@meta.com" <kbusch@meta.com>, James Bottomley
	<james.bottomley@microsoft.com>
Subject: Re: md raid0 Direct IO DMA alignment
Thread-Topic: md raid0 Direct IO DMA alignment
Thread-Index: AQHb3y3UX9tqZun5hUeSu5vBGRb8NrQGrNp5
Date: Tue, 17 Jun 2025 03:12:53 +0000
Message-ID:
 <BL0PR2101MB13139669A82AEA178FA2D940A173A@BL0PR2101MB1313.namprd21.prod.outlook.com>
References:
 <BL0PR2101MB1313AA35D88E8F547132B505A173A@BL0PR2101MB1313.namprd21.prod.outlook.com>
In-Reply-To:
 <BL0PR2101MB1313AA35D88E8F547132B505A173A@BL0PR2101MB1313.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-17T03:12:52.325Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR2101MB1313:EE_|IA4PR21MB5072:EE_
x-ms-office365-filtering-correlation-id: 827c5526-c1fb-4178-81c9-08ddad4cd942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/Wh0Zkyun7E9mCTCUQA6rtlhABsMmhwdAKwXvD9cxHIX/4PT/awwBP3YyW?=
 =?iso-8859-1?Q?8Np+6lCUWciMgXr93Px+OSFyteYOWKyMmTIMIBIl9Xueh2Pfh78QlMWksp?=
 =?iso-8859-1?Q?ZWcXy0fPCTJGduGxlWUBpLt+EXmYyJjO+Vt2oKiSS2u3mq88ps+IGjbEEr?=
 =?iso-8859-1?Q?uo1qjf3kx7q8LyA3zG7fRUcGrJxJl+wUSKYEkugfaGVKOo5gDhY5XZiLAq?=
 =?iso-8859-1?Q?P87/ITLEuCPkc/GE0wxc+nW0RRYKjXRr4bWshyx8hyylFkCK/+LPXaepEN?=
 =?iso-8859-1?Q?MXuCZ8lFwCOqYTqPeppEWAYMjjnRxeSBpFcqUxtq5ofXUy9zfQeBYoyeGl?=
 =?iso-8859-1?Q?/08mApYWuGSNKo16pWrU1IsdSCC33bD9qvmllgxiGek1KKInJFLohcM8Er?=
 =?iso-8859-1?Q?dl3aTAA8HzxKqjYEEo/P6ngLN65Aoz1tRqEE0t9UVesxDRkgA5u+Af693D?=
 =?iso-8859-1?Q?2LiOqIuJiKY4O6lvyQE+L5CFW9bZOWnQQo4Mv3sZPrMbauTmZlYztmDfZP?=
 =?iso-8859-1?Q?X0xbErRCOo03AINhs72y/TmdL/KVTMyylyWkm3ObTywKEFs+LQ48cxlMMr?=
 =?iso-8859-1?Q?34j+5YuECALy+ClVNPB7PGVsZuAssMzkqTdhSMfs6mT+iu3Wlu9RDthP6Y?=
 =?iso-8859-1?Q?6Cbi+uEJnaHF3gEAyx8wYhUxxJLnx/WBjlNV6bFhv6XmaOz+38CCk9uoRt?=
 =?iso-8859-1?Q?7uHkTgPXm71eCXACu9fqqkv/T3nTdwrzSMoqHRnBvmSGSStXFXCioG9R8k?=
 =?iso-8859-1?Q?4oQi7KUHIhDlDYtgFG+JNnphZ41oHOg0A3jm13EBRrxduTg0YTEJPn1/Yk?=
 =?iso-8859-1?Q?dr6uTqhdTT2iEsPRPfnN3xSHqCE61KjK7FonCzjn/fzT6o/eNzrIP4rNLv?=
 =?iso-8859-1?Q?OiutZRcOwGnPULyJqKf7htSyIyT0niBqhOo8eSj7jXgQl5NLkhNx4bYitv?=
 =?iso-8859-1?Q?17im1AQHmpH35AQviiwcagTPUuBqsgCPL1EYuk2aGjDtCXRS52/Nq/tSoz?=
 =?iso-8859-1?Q?4IiKdaiRtgYn3vJjO7XXWVyArt8mPNhbkgjwICYK+bC+3an5Jaw0M3tZ1G?=
 =?iso-8859-1?Q?Pp1yZ8mTzg/Owoaix8f2ofOMhUSjK2HFZpx0IwYJ6IjOb0wXwZUXzKzJce?=
 =?iso-8859-1?Q?fHrE366jWs1jBW3dA1dyOJwlkz83SHuzWDJSsRhSwJTwW6h9rDAbi0vnlg?=
 =?iso-8859-1?Q?MQz7q5PU1x58SDOz/RXEVtTYfI6kVunoPAc4LKfGUVefJTcfGB69i6eZ2g?=
 =?iso-8859-1?Q?4cDB448g3idumLBXhfg62YLrqG8wT5akSjUbsL2qMmIGjrwaB8dUfdvCJb?=
 =?iso-8859-1?Q?Ma2yXbkMk2NTcb5bHv3eYBeUPIaw7RZCEO8LRnSLytxJcVuogeYliqNske?=
 =?iso-8859-1?Q?Dztqv4redhiHdjHjbUpki+XO2vHV/8JAWVIgU6beLSpKo91zB576BmC6xs?=
 =?iso-8859-1?Q?rkpVe8fHYDIunv1qFUn4sv7IQ9sOPfnUVVIHPzTsFwW6UDKKLz7yDAQATy?=
 =?iso-8859-1?Q?ItKV6VYJHbm38H0uP1Lx7E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1313.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zjeCO3g9pn9k70IOKtFEHowsKBNIhxgUDAVaIOxeF2dUa72QWAd/YwvITz?=
 =?iso-8859-1?Q?s8yT5xKG0YVbwjEvaX9ngfVg22yI4uax2JZA2da04ZwPpoLLMbnNlF53QX?=
 =?iso-8859-1?Q?qR0EJkukpvtRYEWvLCHk7+BDT+kwnlJnCwSnpKQdM48HkWp9/Jtj/G+n6B?=
 =?iso-8859-1?Q?UoDrBQOKUgwDfAeKvX+ChDDT2/sPCkVta6bZNouazSipOjHkOOLNgV7PiZ?=
 =?iso-8859-1?Q?turxiNwY+4Jp5mfpKt+Hg0tXFZRymXu3FIXo4IQQg1SotMW9YpsTkxXcnO?=
 =?iso-8859-1?Q?w/bubbAZ4SZLDrCgnm8jE0etdngYufjsqlayerapG3a35kPnuOKDM6P2/W?=
 =?iso-8859-1?Q?PseaGkX+F7uRkhNrCaJeiy3+VNSGMRszr3VJ3P7BTCAc0WHycqzMWQhDWh?=
 =?iso-8859-1?Q?NWQ6pAbFywXh/IgY7sanEXTMuI5biz32OQxS2z/M43rYmrKA+qMccsQOSS?=
 =?iso-8859-1?Q?28I2Nm4s9seoncou8T9dv6TsZN+i9VZ/n3iD1mvBmCWQKz3Q38n3KvwBE2?=
 =?iso-8859-1?Q?Mupi7uT23eeEeKlbhTWoZnXID7gNEQBZfnIzsEQh/bCVL3k24oWAu9BhVp?=
 =?iso-8859-1?Q?ZuNfyVxrqtnfgQo4pVu8YPT2LfMDLZaeRt/2GOwJzeekV1PuyASVxDWQ5x?=
 =?iso-8859-1?Q?fFBdMCR6H2ZH/40s9TRYxOGn1yHWvK9VlOFFT7o2yfVV0EbDhw2KYzlXOM?=
 =?iso-8859-1?Q?/BqiGjJtCO2tuHonIs94AhyqN+yzh+xVGXPPWlqD/DolOtgBdEhN3eQGdt?=
 =?iso-8859-1?Q?amq1xfKkrVAxrsUcPvZzJ2ftMV3B18QWKmse5p/L1qU6XwXicPcTkikQxZ?=
 =?iso-8859-1?Q?0tQnLT9H2YkPZYC5qQmKTUNoI3hnqP1mpUhT8A2cfp1B3q/mqfsoBEwAln?=
 =?iso-8859-1?Q?Bj7bwAGDiBqEwddoNY+6sGB167qQRAygDrHG69bgUHbg66vwjO8bnFJ1PP?=
 =?iso-8859-1?Q?uaiwUxSW+g1tFdU6LYlf9KbUzxKvixE0vXv27AgFmfVYfJoz6T8y5sj8Bj?=
 =?iso-8859-1?Q?DgBsmgU7i/guHlKQVtqweJicr14P3smEdgcDc7849ZmHGhcs69oGuU+7MC?=
 =?iso-8859-1?Q?J5L4tQ/8ytiS43wKKYuh88QRux9g+8RyYbIFQMdbsIItqZiOHUj87R9ltT?=
 =?iso-8859-1?Q?nifZ8p68CIULGW6PwyiWt3HA89ICmnLx8J2BAg4dAhzDQ/gxLQRz6BdjCz?=
 =?iso-8859-1?Q?Sq6x7BE9HIXsXmEs46y8kgbHWy2JpZAsoC3WWs2ih7AKtCt5XFfM9ogdlI?=
 =?iso-8859-1?Q?pBa7t8oDcmOdjyYq6girAoBMPgrEPGSWKt505Ns5SosPVJLvHbDQeEm8kv?=
 =?iso-8859-1?Q?McG/4oUrTA9djN8WFQycZ8VQvNfKMx2Q2vWBrNMmbuGQ6FplcjOf51xHe7?=
 =?iso-8859-1?Q?4vdBmjDn9ky9/tx+pR0ZjqUTLKmr42jgVdANOtlNo3cieprURVmc1yzk5R?=
 =?iso-8859-1?Q?1qrCWiyjL8Jc2oyOFIuJjm3PPjRgOGGnf56gIszVJ+5SOEZUJTG2EAR+TR?=
 =?iso-8859-1?Q?DGbwS9NdErk5Cwq/ZEBA/u52tCgU5HW5C1fliVMu3ZEz2nEFqyfVB7Md1U?=
 =?iso-8859-1?Q?Z6Ohm1/U48K6sXFwUbYtFMMxCnXy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1313.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827c5526-c1fb-4178-81c9-08ddad4cd942
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 03:12:53.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLP0BeIkcdjm76hS3FqacE2zxdUYWxQ+jvWo6o6T3tNeZv6q105tZnclQexNaCwWtcQ3KbxwLwVOUsRw+lNVclwsI5cIwqS7IYMf70PVu2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR21MB5072

And apologies for the unintended recall message on the list. Meant that for=
 a separate, prior version of the email. With that said, any input or thoug=
hts here would be greatly appreciated.=0A=
=0A=
Regards,=0A=
   Jason=0A=
________________________________________=0A=
From:=A0Jason Rahman <jasonrahman@microsoft.com>=0A=
Sent:=A0Monday, June 16, 2025 7:19 PM=0A=
To:=A0linux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-fsde=
vel@vger.kernel.org <linux-fsdevel@vger.kernel.org>=0A=
Cc:=A0Adam Prout <adamprout@microsoft.com>; Girish Mittur Venkataramanappa =
<girishmv@microsoft.com>; kbusch@meta.com <kbusch@meta.com>; James Bottomle=
y <james.bottomley@microsoft.com>=0A=
Subject:=A0md raid0 Direct IO DMA alignment=0A=
=0A=
=0A=
Hi, I have a question around DMA alignment for MD block devices (RAID0 in o=
ur case, but applicable to other MD array types). Many underlying block dev=
ices support more permissive DMA alignment requirements. For example, in ht=
tps://github.com/torvalds/linux/commit/52fde2c07da606f3f120af4f734eadcfb52b=
04be#diff-dc92ff74575224dc8a460fa8ea47dd00968c082be4205ecc672530e116a0043bL=
1776=A0the NVMe controller DMA requirements were relaxed to only require 8 =
byte alignment on the buffer provided for Direct IO.=0A=
=0A=
=0A=
=0A=
However, when NVMe devices (or any other devices with less restrictive DMA =
alignment) are used to back a MD device (RAID0 in our case), the dma_alignm=
ent on the block device queue is set to a much more restrictive value than =
what the device supports. From initial exploration, I don't see why that is=
 necessary. If the underlying devices support less strictly aligned Direct =
IO buffers, and the sector/block sizes are a multiple of that alignment, al=
l possible addresses handed off to the backing devices will be correctly al=
igned. For example, even if the buffer is split across multiple stripes on =
a mdraid array, since the IO starts with sector alignment on the disk, any =
multiple of sectors from the start of the buffer will still be correctly al=
igned.=0A=
=0A=
=0A=
=0A=
Within the md driver and block layer, when setting up the md block device q=
ueue limits, md_init_stacking_limits() is called which in turn sets up defa=
ult values from blk_set_stacking_limits here: https://github.com/torvalds/l=
inux/blob/9afe652958c3ee88f24df1e4a97f298afce89407/block/blk-settings.c#L42=
. The DMA alignment requirement initialized there (SECTOR_SIZE - 1) is far =
stricter than required by many/most actual backing devices. Then when the m=
d layer later calls into mddev_stack_rdev_limits, it calls into queue_limit=
s_stack_bdev which takes the max of dma_alignment on the current queue limi=
ts and the next device in the mddev.=0A=
=0A=
=0A=
=0A=
It seems that rather than setting dma_alignment to SECTOR_SIZE - 1 in md_in=
it_stacking_limits, it should be set to zero, and as queue_limits_stack_bde=
v is called on each backing device, the dma_alignment value will be updated=
 to the largest dma_alignment value among all backing devices. Are there an=
y thoughts/concerns about updating the mddev dma_alignment computation to t=
rack the underlying backing device more closely, without the minimum SECTOR=
_SIZE - 1 lower bound today?=0A=
=0A=
=0A=
=0A=
Regards,=0A=
=0A=
=A0 =A0Jason=0A=
=0A=

