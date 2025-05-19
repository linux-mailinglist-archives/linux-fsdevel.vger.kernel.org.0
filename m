Return-Path: <linux-fsdevel+bounces-49392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FBBABBB04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C4188E86A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E590B2750FC;
	Mon, 19 May 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ansys.com header.i=@ansys.com header.b="URU8jJ31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2139.outbound.protection.outlook.com [40.107.95.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB085267B95;
	Mon, 19 May 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650221; cv=fail; b=jZAOVgptwJ5xm3zv3705+sL5HE8PFD6zBf8dCF0zZYETlEuVcXI+AGrSWXUd0JpMTqmMjvO9jybmwcbu88P5QeXXYecRPHkzSH4/MKUpm9G79aWl8QgyEApiEzbOAjTu1QBwpaQ9CzNkBZGZdf4ssNhZnPsmo/X4fmb/PR0Iy0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650221; c=relaxed/simple;
	bh=+3V+FE+m6M1X62KV9+ikkhZqqXyr4mlpM6j4Llc19F8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrjnP6fGrjnr1EidUrQtZFG2WBk6wZQHANuGXvRq1Ksy9FxjQfr6E9szLd5XImrEZ00rokrztAq9Z2/me60Qs0oaRi/fQSB6vDwIBJT4JKAMTn2Henm4hIQt6XA2g+kBHDB5e8rulgdHPDTigYLSB85v+ffwALp365BUxinAFbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ansys.com; spf=pass smtp.mailfrom=ansys.com; dkim=pass (1024-bit key) header.d=ansys.com header.i=@ansys.com header.b=URU8jJ31; arc=fail smtp.client-ip=40.107.95.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ansys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ansys.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHOv5gB7y+D3kfzz8s2Fmi1rU/qoJfVLJloDhPoqrF82o+qFd6ABY07Rr9KIHaldQaGHYaC0i/wCbc+7SamLwj6g3vmh2/63Hpd0uO035FUlyV5dzsYtCrIQvu0KUdqVZy2ly2Pw4Y9b/qfn0H0xFjm5mfhkRlOZdi9XtH6xxxxMu/xN5XJiNalSw/AgXBpKIvwb8HhB6Epskyuk4PjpqjVhMNZL3GrhpR4xESq+pZDXUuqMOtL6qYnZkIPzI17CI0cOsj+jttNh1NiO3dFIsCMyc/cPgBe2gL8gW5/pKgonXnDfDRffzSqRJ5yTOHcq15RlDXCnFZkpwvgQOlXy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3V+FE+m6M1X62KV9+ikkhZqqXyr4mlpM6j4Llc19F8=;
 b=zSLLgB+/PtwyvBUsiQyUNyKKjSKS2pK5WD68J5Hn6tpJELF5kboB4RoGkyg20faO7WwMjcoVZmQOFgvb1HQ+ZWNFdoETxYZt7CCYuUgtFvdTmcjmQCHUCzFPkjJ+Z0Hi55uei9thCWuiraa0RFdrNQBUn4KIFjJgO0GHYQ469NwhW8MelegBpanlURWHlYoPztG7+95boeyGChhT35bfluMp+lZGQ/TB1BGVilhrbFHjOMAhZsjpm8+LT0KbimBzFdFNS4ExknEHWMkuydWC+9AV38oJeDHFBDOkH65Sjs7VpT0SEs7un8ZIU19APrPuyjFXkRygdkrjd7Ktj7DxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ansys.com; dmarc=pass action=none header.from=ansys.com;
 dkim=pass header.d=ansys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3V+FE+m6M1X62KV9+ikkhZqqXyr4mlpM6j4Llc19F8=;
 b=URU8jJ31BK0ZbzcrWP8428nGlB3PDRfPVIVcppgtEjaytADyHiD2SR5WP7MLkXePb4B7yDT9EPtd7e2bvHmhwDY+WKymBCZi39JVBJ2MQ+y1n7wr12/HhbpJMmTcopolbJqn7OFdEYlBSsfwkME70C1ioFZONUYQyisKTt9dUMo=
Received: from SJ2PR01MB8345.prod.exchangelabs.com (2603:10b6:a03:537::11) by
 DM4PR01MB7859.prod.exchangelabs.com (2603:10b6:8:6d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Mon, 19 May 2025 10:23:36 +0000
Received: from SJ2PR01MB8345.prod.exchangelabs.com
 ([fe80::6b00:1585:571d:c7a9]) by SJ2PR01MB8345.prod.exchangelabs.com
 ([fe80::6b00:1585:571d:c7a9%3]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 10:23:34 +0000
From: Bharat Agrawal <bharat.agrawal@ansys.com>
To: "hughd@google.com" <hughd@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "rientjes@google.com" <rientjes@google.com>,
	"zhangyiru3@huawei.com" <zhangyiru3@huawei.com>, "liuzixian4@huawei.com"
	<liuzixian4@huawei.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"wuxu.wu@huawei.com" <wuxu.wu@huawei.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
Subject: Re:  mlock ulimits for SHM_HUGETLB
Thread-Topic: mlock ulimits for SHM_HUGETLB
Thread-Index: AQHbyKcHO9z3CBT88UaaZrmPml1IQ7PZvpe2
Date: Mon, 19 May 2025 10:23:33 +0000
Message-ID:
 <SJ2PR01MB834515EA00BD7C362A77972F8E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
References:
 <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
In-Reply-To:
 <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ansys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR01MB8345:EE_|DM4PR01MB7859:EE_
x-ms-office365-filtering-correlation-id: 302cbb92-14f4-4a09-cce6-08dd96bf35ab
x-ansys-tr-msexprocessed: True
x-ansys-tr-senderinternal: True
x-ansys-tr-recipientexternal: True
x-ansys-tr-notconnectorflow: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YXAhPTdkIH6OuofNhHiPCxkvQ+vRfxI5Rg60YOmqWFgQVOEKdC5i6uZ8L7?=
 =?iso-8859-1?Q?SUcCzSof4RAOnfWmErZlR3Uet5ONc5Cf3xqHiPg3AaY1yRZFfFUazziBuN?=
 =?iso-8859-1?Q?klbR06UhGERGzm5z1Navy3fbYGkEKjcJOSOGPo//Wz09aSEU+DdxP812bG?=
 =?iso-8859-1?Q?Xd9Ezvqu1jgh/fcRZq3kSALZIOBw+oU6qyS98xLmB1NaFKko9ifFBFmcql?=
 =?iso-8859-1?Q?3gXAwnW/jObJM6fLPOa4mXbOtp02W84Sp0fgKUFy8pViT4e6Lys64lWDdY?=
 =?iso-8859-1?Q?1V8D19br3pjFItPeI6bGFKEZQDGqWBDKQAZQdgnRpL+sRDFcl7iTdmau/C?=
 =?iso-8859-1?Q?ONElI5rz36jH8/SOQbcIE7IjOVyUQtZSs7v1oa1rP2hAGHoZ12B+YaijcR?=
 =?iso-8859-1?Q?XfS33Ah1MqWSY1SLajUkbrAAZtTXkG7S5M3Q+VWIoDOywahAmZvKN5aO8f?=
 =?iso-8859-1?Q?h6mcdGeIDd/gamHiZGEYzmIZ8tPRQwlFQoeVYgLeRre/H9Q24HDTNLseiG?=
 =?iso-8859-1?Q?FylR6/4Y8Ls+5FCqAefCnPMnkFlV4rnEiXmaXDEwoQsZlk9cz/Mg2L9wjC?=
 =?iso-8859-1?Q?DsVCCE0rEtTe62CgVEBo9YGCyDOaoQlwmwLxntBPr9OmvphAZxAI59RY0n?=
 =?iso-8859-1?Q?Gnf/CV4XEYz265w+/FokVk90iQtaY/o//T7MvaC6NNol4OFMQg7/tWZmXn?=
 =?iso-8859-1?Q?PIjos0VJsqEYwnLG8XGU/YsU5TaRagh87s1xkGtnDZSnt8iUOC17Rruex7?=
 =?iso-8859-1?Q?sgbJ8GzO3EG6rvsoZnjlf1PnluVjnyZEgvQ+7X86PAe/n+4ghs/Ae6GOgB?=
 =?iso-8859-1?Q?tm2vin3Gjkui6pjSf5Q14u/MQwH//+XN2orW4vGGyCD2uvf5SGWf0wLepj?=
 =?iso-8859-1?Q?kaWlsBGkSVI8U5hCdjxZ+4CWMBxMdzTO0Ob5WdaKHvc05nN0k85cYdRo3u?=
 =?iso-8859-1?Q?il5PjBzoRF7UN+gBjHvY4xgMIbZTe4nD0If0nn3j3xFNRe/AWn2xbWIzwn?=
 =?iso-8859-1?Q?u5tEFMc5BPryKqxM6sWIMo4f/dtOUY0VkhQnl/F43xJKjYNON/+O1kN9Co?=
 =?iso-8859-1?Q?UbcyvK5uSSVRHdDxRwpFaDn150WGJh80iD4Izv34bxD2DiWhEQC+D5ObYH?=
 =?iso-8859-1?Q?ejB9QWDkEpGMY4uzfQPLuXNms9WelfQNF3wT/62AzAc8J7zvCpYxupI8gD?=
 =?iso-8859-1?Q?wH97SXKo4nlssQTsI4krz+dYSt5dLmKdDlm0pwCwk0BJHoiHdTc2hiscN1?=
 =?iso-8859-1?Q?RpxXmbsGTg7EWCk4nJQO6hAtoCdkEwCxc9zXg4/1FyjnDZPSA+KNylROBG?=
 =?iso-8859-1?Q?ISb3ckMgteDgidDpnI8/YPYJYbQnci7X4brwAygpAWnsqMGTZzm5DXzkaB?=
 =?iso-8859-1?Q?g/mI7u3tU1yC/2BPieSE0cPp4AI1bWKe3AwHm2IvfiLpJs3UfPOAb6VCA0?=
 =?iso-8859-1?Q?+bOCUT02gwqV86Pervc4G8NgVupcUNFfUMJ/IUz3AakFz2k/Pxr6aHrRGD?=
 =?iso-8859-1?Q?IYBg9ZQWB+SyCwyPCai7ayUtbi6+XdVq7TQMYrEeG2dCZHIfr5ch0bNS/b?=
 =?iso-8859-1?Q?vaYfZwM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8345.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?G0J1bkN5WUOjp1zKEZaNwWd19g/gTWRrUNwR6oInQzt5yMrq1GVcdoqlVV?=
 =?iso-8859-1?Q?bLb/qzu6LcT8+UZUeXvWalXtxbiiQmsqg9aW5xOgYQoxuasHxVv2K5Y9Iq?=
 =?iso-8859-1?Q?8ucI/TBwZOEWyjVuMkqF4Z4MF+Z1SBw3nk8Zjt8zQj/hvaf2aB+qgK5eOK?=
 =?iso-8859-1?Q?fu2Zo6DIXTzxyxPyWr0UlHWtwrIShAePKTFih7vBy/fAxtArmC8dzDOXHn?=
 =?iso-8859-1?Q?elPcrarO8rl5+Bx503wblz881QEhDqMfE5tzfU9KvGkb1sbZX2Y6wGMoL/?=
 =?iso-8859-1?Q?xTLwJls4X59EOMLl+Vtk7WHRBQpwjLfHsLHBREzQF+85PjUfHfcrLBOwYg?=
 =?iso-8859-1?Q?AXhc92n6NMU/A5MdyEf08GCpDv2DfX3X0bASCEGhKo0m3DwA/Ant9LwvTI?=
 =?iso-8859-1?Q?KtaiCfaIu9MtX0yzBPUPHoMHEvFRPEt3nuSKMKmly1t6wNz2B9IfCvXmW8?=
 =?iso-8859-1?Q?TfhUpKSXN2EOXyEvkPtteNcR4wSOVF+gMosWZsMLbFU6i27KB3USEcC5v8?=
 =?iso-8859-1?Q?wODXJAKQv9hado15Dp3bGEK0p7ljVadnam7bZIcrrBQ2sCOSGXZojrfbxE?=
 =?iso-8859-1?Q?NFDqsLCJevXlaPZkzS+npYD6uH8ehjRgDRi6vmPN4FcyAWwXABt1xfYoU6?=
 =?iso-8859-1?Q?j/J0CEWwMmRrbZ7QQZus+ou+ML6O1+kXTFrX7iyVn2/uPIO0JbT6sZaD1+?=
 =?iso-8859-1?Q?qA/ndwagx9QOdqKEA/x5MNiSxlMMihyteXfaHPDTVDy6GXdA4yTlgLaOIX?=
 =?iso-8859-1?Q?wiANGs48C6d0NlkPINEH03tAZAExSfPpqCjctbP+5isfFr85Rf8BxDTfSc?=
 =?iso-8859-1?Q?Tng+KquRNNt0MxTpdP6euPeyqug3Sr+VVGFP9Ru1WFrXlKMEhVzz0H5DYe?=
 =?iso-8859-1?Q?ZOLbdc2ACYa7CJfzp7VOOY+vUw+Vy6krCsBkVUUxQyW4QYQTjzwlQNBv72?=
 =?iso-8859-1?Q?u0ZoJjeZxTYXCS3Ly7tUk5Fc033BuD1CuNIfw7UoVTW2jcHkVpdck9CgIt?=
 =?iso-8859-1?Q?gPdcGvzk1dzZNcipmdsJIdw7EOnxGdXM3aLeIUBaDQ6vaf79GSzTbHd8K2?=
 =?iso-8859-1?Q?jNKv/8uDqbEil/FB7S2r5Lde7p9NBvxoxL+y2dk9NWKNvfbr7z2wyTX3l8?=
 =?iso-8859-1?Q?BT6uhOLuXXA7DXEy1/4IuvXT9O8mxRZdvXufZi8tWWv6zXDLylg5cOosJ/?=
 =?iso-8859-1?Q?g3EfMnQ+svAtnZXVIo2ubXi3sq3iTJiP53AzNoJm+xrJ704nkA2S4QyaH1?=
 =?iso-8859-1?Q?Hu2vx8NXG64fAVO8zW0/AEMS2XfN7oPIGnseUG+acxtk7b2p28y03NqkfF?=
 =?iso-8859-1?Q?nTP5QoE6BPaTHVfX2L42PFfBlIjPVwwM2gTEu6Dc6etYPMA37AF0MVPome?=
 =?iso-8859-1?Q?ODq16QykXjnBswiOwz9ikEqnPSug8vvmyY1Tm8vREd/jER4IZ2e3hDw3+m?=
 =?iso-8859-1?Q?pnEYgOT0g8MBI0nqPN8IlIfhaQoFkaSpL4eoXCSgEbHE2qFtZ1bZmVxiFa?=
 =?iso-8859-1?Q?hnjMsUVO4r53HJ9pBdHGOJf6ecclCq9IICfTj/7FRzwZtdAQ/4WZKtFYVA?=
 =?iso-8859-1?Q?7JSPwgTMfYt+XX2q9lO67qtLgxrFd8dJ4hxHM+IQa6x71k+tVu2T1HKbOC?=
 =?iso-8859-1?Q?EuVUc6nCvKuyKRFnTl2o1yNlZT7LGWrK/d?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ansys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8345.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302cbb92-14f4-4a09-cce6-08dd96bf35ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 10:23:33.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34c6ce67-15b8-4eff-80e9-52da8be89706
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZZ8q30TkM6B9xfAJvbIJ+tCFTo5Ckuytiq2E4062Bt+0f/NV7U1upR+H8UPXXX2C651ukawGQwwp+pkNgS/v3qT0TZT5lTyjky+SKyWJus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7859

Hi all,=0A=
=0A=
Could anyone please help comment on the risks associated with=A0an applicat=
ion throwing=A0the "Using mlock ulimits for SHM_HUGETLB is deprecated" mess=
age on RHEL 8.9 with 4.18.0-513.18.1.el8_9.x86_64 Linux kernel?=0A=
=0A=
Best,=0A=
Bharat Agrawal=0A=
ANSYS, Inc.=

