Return-Path: <linux-fsdevel+bounces-49401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3AABBD4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 14:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A63AA591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F983276034;
	Mon, 19 May 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ansys.com header.i=@ansys.com header.b="XBqq/2ES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2092.outbound.protection.outlook.com [40.107.92.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1913D52F;
	Mon, 19 May 2025 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656362; cv=fail; b=fzf0iF29n/xg0LcaAVrma9ZAHgtiHCWemvnqTN9NxibLb1iG53os6r8hmSOkVK1R/vkJ1068o7lH9ozyGrZSruTswq67IguRhh+sDyxHe48Z5z1UHor4pgGdKyp/uXK1fyhvbn538emuK6cScOnWXl+ZrJs19Dc0P325MglWggQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656362; c=relaxed/simple;
	bh=I4/B6sahnwFM/AL4puipQCvN1sdctVigonLINaxD4Sw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hDLsKA8mv925ubshss2fowDZ2qhO48jbCzETWDk//frx/QwLmCvA4YYknM2I0wnFnGjusS7zFl3cRSnGjYzXvrE1FQ+BqcptsF8zV0ZAiP+mJNmDdGySA7YidCtiZIt9HQQvwVnzu4D4hjFiB0Dat58W0IND7StG+s4ugBA/xWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ansys.com; spf=pass smtp.mailfrom=ansys.com; dkim=pass (1024-bit key) header.d=ansys.com header.i=@ansys.com header.b=XBqq/2ES; arc=fail smtp.client-ip=40.107.92.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ansys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ansys.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7Yw3v+tqAwh1RM0ep4ksZ5Ing0TbcRaXoEsRLF7K4Df1yqZVFqeLmSwSsLKUQOrsv8L7MFXWDYeBH8jyZpKRRFKGGuD6HLswtTL/QGRUmwq3FdwfnATnuP+EG18EhHT2B4tqL5wl9B4eNXhxz4WUvorroJn846lAB7zazqc0vyt2PxBhQrDVjw9uw8gahiTkQf+F43t2vOZdq/+KdnOjtPWOMVz4hrt/gK7wUktcdnpNMmYL3eamb9T6WF6G3lV6ZktpzEDc1u8AvIDFUY4hDWRjz9XpVOTJni8DAZPxrdUwZq70W9jGKLPTPgP57pVOGPr1uyqKmManIkcl4geSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4/B6sahnwFM/AL4puipQCvN1sdctVigonLINaxD4Sw=;
 b=Q0lm8GeCvwYSjdO6aO0cv20uVbqGySqQUCnvdUvquDlJKWAmXbkJMJ1XpYbUXbzP4jsZy2VvQEnIuPQ+SKBDBfo1dhhHB9+tj7lWWDvUqvFNmNalmPuY6Vdfe+KpBZml0JUOn6QYzXATTFVmGJ6Os6J8tPduaXF+UYOk5zlEABY8tPwItCN37p08m1JxRbvTB19u3ugy9UIVZzdC2h3VuOHnyaN5+mrINZuRQnv77fRjVQyUEmXjHWwHA6z3pK37Er3/nByoeYf3a1r9Cs+UmSOEQMwrPaVWtO4jGsOi193xfMlo0zfrgn+vzP4zaZCeK2j5hTt2ybsSDvDNWhVxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ansys.com; dmarc=pass action=none header.from=ansys.com;
 dkim=pass header.d=ansys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4/B6sahnwFM/AL4puipQCvN1sdctVigonLINaxD4Sw=;
 b=XBqq/2ESm8xb0JGky2q5i1xYnv1dGd1hDSPww1GGAnuGMiyM/YdRRuWcHh4T8MdtADnh/YAbGWWpg1Cow7/OBMBrF7uKsa1iqCyKkBIIU/T7ioBtEkY8saEb5fS9xgG0rSWFZS9KNis8cxDvmMYGZvKmc+OjlsDBB9bK6/cTyf4=
Received: from SJ2PR01MB8345.prod.exchangelabs.com (2603:10b6:a03:537::11) by
 CO1PR01MB6584.prod.exchangelabs.com (2603:10b6:303:f1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.31; Mon, 19 May 2025 12:05:55 +0000
Received: from SJ2PR01MB8345.prod.exchangelabs.com
 ([fe80::6b00:1585:571d:c7a9]) by SJ2PR01MB8345.prod.exchangelabs.com
 ([fe80::6b00:1585:571d:c7a9%3]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 12:05:55 +0000
From: Bharat Agrawal <bharat.agrawal@ansys.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "hughd@google.com" <hughd@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "rientjes@google.com" <rientjes@google.com>,
	"zhangyiru3@huawei.com" <zhangyiru3@huawei.com>, "liuzixian4@huawei.com"
	<liuzixian4@huawei.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"wuxu.wu@huawei.com" <wuxu.wu@huawei.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"legion@kernel.org" <legion@kernel.org>
Subject: Re: mlock ulimits for SHM_HUGETLB
Thread-Topic: mlock ulimits for SHM_HUGETLB
Thread-Index: AQHbyKcHO9z3CBT88UaaZrmPml1IQ7PZvpe2gAATngCAAAb6nIAAAh4t
Date: Mon, 19 May 2025 12:05:55 +0000
Message-ID:
 <SJ2PR01MB83456E99684DBBAAEAD7F9288E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
References:
 <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
 <SJ2PR01MB834515EA00BD7C362A77972F8E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
 <2025051914-bounding-outscore-4d50@gregkh>
 <SJ2PR01MB834507D46F44F65980FE09668E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
In-Reply-To:
 <SJ2PR01MB834507D46F44F65980FE09668E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ansys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR01MB8345:EE_|CO1PR01MB6584:EE_
x-ms-office365-filtering-correlation-id: 3a9ff1eb-ec4d-4e2e-18d7-08dd96cd8234
x-ansys-tr-msexprocessed: True
x-ansys-tr-senderinternal: True
x-ansys-tr-recipientexternal: True
x-ansys-tr-notconnectorflow: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?J2Wrml9OMEjuI1r+LBX9DrAZoRSoDmaU85y+5f9PXHn1sgKhN9D6/+Hzdh?=
 =?iso-8859-1?Q?X8pMX3F1IgKJ/TAYGfsDauDMUFKLfsTKzdz/jSRj2LR5pssCDVKgd/dvxK?=
 =?iso-8859-1?Q?OM8vHaM4IAdjCSk87l9dkpq9u7BOQGCgpUq/c7FMh4MGxWFjC/puouwlQo?=
 =?iso-8859-1?Q?y3a5nFL7Vxab4kVRosGO61538IGMqr2kEr+mspKFbxcDQMPDMWiNXFo14/?=
 =?iso-8859-1?Q?TTi2uPf1XMM/OZvs1O5hTDy6fZiHKna1SlbBEIBcjzkJWrxcNTsDODOd76?=
 =?iso-8859-1?Q?UwDyM3OdigG2IBau8G7sPcc0UJKjrA7zHt2yyOIhDpx6jhxkkYROAMOick?=
 =?iso-8859-1?Q?8AqJoZud1OVf497MziGV/5ZHtmJQizHzh/oDIWnPsVh0ozt4rmkpdHE/7y?=
 =?iso-8859-1?Q?wC6uFPBHYwfJHA6W7flE7q4tLVVoMmAz/evW8dOKjf3O+yT53jDRhxR8hI?=
 =?iso-8859-1?Q?SlUmK6G5YM5rKwivt6FCfDEqZNsJHpUnl401zNK8dKxVQwvIOXi14JiTkY?=
 =?iso-8859-1?Q?bDRhQGz/kBmn/lwXI4vY0CxH3UuQcY6nHddPLLqfyDRYhSAklWyBbcuQMy?=
 =?iso-8859-1?Q?oOv2dQLmLm3pTqcsp1xXTaET7tBCHAtIg/Gtq00Oh7xmCQON0sZeerM+p2?=
 =?iso-8859-1?Q?SeZOYpp2pgzx/bTxkoyFYanIfGwh8DDHa8RBAuj1xrTmbUhqHgrhUkH51l?=
 =?iso-8859-1?Q?RkzKeDIRDLY4AVLQLCEaAgpDdIPYewwoqOSy0aasP/n2qYVNOLQrNDTeUf?=
 =?iso-8859-1?Q?BSy1ZM+iRqPXnoqy51bNnLT0mNtYvoBOQkgc/X0j6AYLmm0lBne5BbCz6z?=
 =?iso-8859-1?Q?vyuXa5s2Suc4LmrHX030/1YFknBBTCVF6hLhfaL2veLgcvJIgNaS3zwk2m?=
 =?iso-8859-1?Q?Jbh4yx9g8uVHZo44YtIxQO5g6IOx9DLPH89STr2jns4hNJTiB5iktHKU6Y?=
 =?iso-8859-1?Q?UOvGv57o8ecfmeXhSMV+uPezL6IYm5+Fsn9Ecn8CC1fw3CevQ8C3M5Exqb?=
 =?iso-8859-1?Q?j6JvB4bGEpu7ZeRNsVT7fS9xaFMz/fQDC0xqRqf4QVrFVMtJinuAJKcrPa?=
 =?iso-8859-1?Q?sHZLB1S/QnzFRCUpAlQJVym/V3VuHN+TaToEWSviimjHUtP8XvfmJzxCbH?=
 =?iso-8859-1?Q?Y1bwxPeuqqwLOw+4s7YvagBYURReA1+odb3zqT9yHyUyo+/+ew+iyq3Qdg?=
 =?iso-8859-1?Q?s7wbypVJCiPnZ87C/W3niiSeUnJE+0pW/+MuuhmZnDo4X+wcxR8O+A6XtB?=
 =?iso-8859-1?Q?VFmACMl7iV4UnQ90L+vZfhHRry4+z6gu1+3cUPYn9bqBesaxvDFS8PwVey?=
 =?iso-8859-1?Q?UTKB/cbPuQlMLy3j6yKh5nlY5P7pjNWR1Fc5ibUS/QMOwbuo7+J7VhbypO?=
 =?iso-8859-1?Q?6P6smAwhbIpgxXlEQgJbGcJLNwEHgWJrcfiH7RiU55i5qh3lmrnLHsShm6?=
 =?iso-8859-1?Q?IWstF7BuWWq8k1wx/dhtsy7k4oEMFu0EJAdhFIWbx+Tj36ZOGYBxX+JaPw?=
 =?iso-8859-1?Q?ZW+d9giF+iY133wag9bHBLur5ovZp7AnVz4UyvVh1X6OIhB7azR27B+RjF?=
 =?iso-8859-1?Q?jkgfVR4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8345.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MV0FNLralsylV58tNPV66zmz/yUV6txdge2kaCsHe3mUsrd7jqHkJuGlEt?=
 =?iso-8859-1?Q?Cdnws7slvQpOwK9tYOz6kwg4TRt+Inxg/rZoCfg+kLSDqh2LcpdaD3wZyX?=
 =?iso-8859-1?Q?jnokXKHGBI7401XMG26CJYvsRn7Tfcf/ftfSFkMG2paYXswq0je2cek4Vx?=
 =?iso-8859-1?Q?KF/Z4J0tugiZnU93hL9RxdZTFMMYoXzv8OH2zNUo0ggWfxY17GhCzZMT/I?=
 =?iso-8859-1?Q?WI0p9u+CXc9aPpPvzbYkk3TuVdUtJvh0Tku3qShVj19aYe0HAlvp+Ufy2h?=
 =?iso-8859-1?Q?QQKi3kkWzqxbi+X5SEKao69XbtobtAn7hojoMuXN29fkVOHDXpDETO5zXa?=
 =?iso-8859-1?Q?54jDvUq5zXMsDgnvq2O5Mom9XX0vZQXPjnKw7vJ3MC7sOJggcLJpgjNrIK?=
 =?iso-8859-1?Q?Ik/B7zVv4NegzHFe/IK95IeLnfOnV85TecbMOzhPEgStxPUPou9gsyIul/?=
 =?iso-8859-1?Q?kcdge+j2rBGYz1rJJJA9HK8zvQx3JLMqrcfxB+T216/DRxCXLlIlDXWBa5?=
 =?iso-8859-1?Q?T68hnrN06MQq6LJfzTlTn+oAK/FsNDazXwHBFMR6dGSzp3z+QWynOuTine?=
 =?iso-8859-1?Q?QO8IUDYF1JJGIOuAxnHwM5sdUNX7DlCi2OBYN79QrJLi7TO1SVeNJYNsmF?=
 =?iso-8859-1?Q?Xk13dHIak2xd7IJ/ZiPEAn76HBWbnmDvnzhVVdSRJ7DPQ2LiUe1NKC4xo4?=
 =?iso-8859-1?Q?yzQNIzCvbXzh15+fuOh6LkgKnHlmRzZDHdFVjQ+56d9OZjtg0Rhb8eRtU1?=
 =?iso-8859-1?Q?OFIm7X9YST9Zjhjjw86lEmb8bAlz/4q4pK98ES9/j/JT7Rud8ded2njO8/?=
 =?iso-8859-1?Q?XG3Y0SNaMCa/yhkC98Qyjtz+sA2VEE8WB0zWd+Y/ugiDPm9F5sFOATXdkB?=
 =?iso-8859-1?Q?rgEKv8DWJQp2ScddAgxlOtY3uBGiR0oFwytHlOWzkzBfShqMzozkScIFij?=
 =?iso-8859-1?Q?EfoiiC9tC/I2cQEDYLjmdD4PYG3ABdkO0Z5uA1fyzZwIpyfIfwgPhCkIF0?=
 =?iso-8859-1?Q?pqzN30/8PKOtM/bBmqehCaGnE7yFKCbQFW+zh5yhTJZERiMnlzSfVwssz3?=
 =?iso-8859-1?Q?pNyFEPp6nhbywyYeLKzfTcBYktgEoalqOf9RUGYDV6LlVfQB2nlY7uRo6k?=
 =?iso-8859-1?Q?v215ySsElRH3rOaKYX3JsqA++iV+UJEunWRaR4SLKvGj6Mc870QeXVo9hO?=
 =?iso-8859-1?Q?5RKpEmngpDkdS7TH1QEHi2t5N1QH8UzZDcE5Qf7f/bbCL2eY6rI0DHb/l4?=
 =?iso-8859-1?Q?vIHjwBswRObvQzV1sagywj+L+xx1AEe4FRSjG+GfGmpLBeoBvHdexJ+36L?=
 =?iso-8859-1?Q?tVhKuZkfjXkNlubbVjf6CC3oz6En6Gk7es/7I8adPc5GCFD3rnVKXWzhu4?=
 =?iso-8859-1?Q?ixqIacmtFxItjT+T1penTIzxUiu1P0eEhOjfbp5S1r9kU5DW31i9ZGIkwA?=
 =?iso-8859-1?Q?B5zSNq/PEPw4s97D5e5IUVMofOIu7Ckc0J7m9gdFxOY/U156fxPYV/gZ5K?=
 =?iso-8859-1?Q?vT/xUC+v06kYQehSeAPrZr1fvDeaB0Ddd8VArkHqeXmnZgmI1mzEe7TB7I?=
 =?iso-8859-1?Q?Q5A+fh0qwWJ6OM2vE5+2SXVZqNONv75iTOnLpbbHfLlvIWfU266kVSzyVN?=
 =?iso-8859-1?Q?TJJlttvXY1fZR4X3So5Bd9KLEZhFmOgA92?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9ff1eb-ec4d-4e2e-18d7-08dd96cd8234
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 12:05:55.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34c6ce67-15b8-4eff-80e9-52da8be89706
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSAyC/y1+cCBCdaO+bGuEid0hcA29Z/Nxc99jmh4/Smoq43MgAq0dMqN8XsHWpWEjAG3rrp3YHn2yfqnLIZRuNOAau2SyhxXENdLyAlPuXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6584

Thanks Greg for the response. RHEL has not been very helpful. I'm not looki=
ng to ask for patches because of the old versions.=0A=
These messages appear in production runs, raising concerns about possible f=
ailures. Thus, the question is: Can they be ignored safely?=0A=
=0A=
=0A=
Best,=0A=
Bharat=0A=
=0A=
________________________________________=0A=
From:=A0Greg KH <gregkh@linuxfoundation.org>=0A=
Sent:=A0Monday, May 19, 2025 05:02 PM=0A=
To:=A0Bharat Agrawal <bharat.agrawal@ansys.com>=0A=
Cc:=A0hughd@google.com <hughd@google.com>; akpm@linux-foundation.org <akpm@=
linux-foundation.org>; rientjes@google.com <rientjes@google.com>; zhangyiru=
3@huawei.com <zhangyiru3@huawei.com>; liuzixian4@huawei.com <liuzixian4@hua=
wei.com>; mhocko@suse.com <mhocko@suse.com>; wuxu.wu@huawei.com <wuxu.wu@hu=
awei.com>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; l=
inux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-api@vger.=
kernel.org <linux-api@vger.kernel.org>; linux-mm@kvack.org <linux-mm@kvack.=
org>=0A=
Subject:=A0Re: mlock ulimits for SHM_HUGETLB=0A=
=A0=0A=
[External Sender]=0A=
=0A=
On Mon, May 19, 2025 at 10:23:33AM +0000, Bharat Agrawal wrote:=0A=
> Hi all,=0A=
>=0A=
> Could anyone please help comment on the risks associated with an applicat=
ion throwing the "Using mlock ulimits for SHM_HUGETLB is deprecated" messag=
e on RHEL 8.9 with 4.18.0-513.18.1.el8_9.x86_64 Linux kernel?=0A=
=0A=
Why not ask RHEL support, given that you are paying them for that in=0A=
order to be using that kernel version, right?=0A=
=0A=
Also note that 4.18.y is VERY old and obsolete and not supported by the=0A=
community at all.=0A=
=0A=
Good luck!=0A=
=0A=
greg k-h=

