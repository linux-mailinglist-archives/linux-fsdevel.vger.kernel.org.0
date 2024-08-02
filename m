Return-Path: <linux-fsdevel+bounces-24903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9159465E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 00:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AC4B22202
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708E1339A4;
	Fri,  2 Aug 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="lYLGcNTk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="GqUv9h/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F11ABEB6;
	Fri,  2 Aug 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722638276; cv=fail; b=c+oai4tAGKlPJmc6H0Kd9lo/K1cTnegnv1rmgUzMFKMKMdZc20GQNeiQ3P9//CDP2KHjeSVLE5dc0usIdz5lajGp5YHTPKP1BcwpEafP9cwo/aDjaMxKvY0b0SLjM675jcJ91Lk9VhwXp0r+hCpw0h7p6pkEe+U3MUPPbnlzi+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722638276; c=relaxed/simple;
	bh=BX4ld017pPdAUsQ+DMhlmUGJ8N8AHDiZQ/EcHgmWwN4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o16XrR7juqbqdt1uz5IHRDOTpXt2JA30zOf52+Ymqg3R9IC8VxWHnBIuKtONezRKRpgEnidlvGOwsMl23u1CeNCXrXEoGYxXyimSIOzh7Ro57asR8k0+Ftw8k76xDZIAzGwKllw9uHixyhdgEvR10W3X6iWa+xxasoauak3eXds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=lYLGcNTk; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=GqUv9h/C reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472ITlkl018314;
	Fri, 2 Aug 2024 15:37:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS1017; bh=YNG8Ew/NWAPAh
	8pu7dohZmYYKAKO+ze9L7LbrIJbAjc=; b=lYLGcNTk5m9iGwX+8PmO6CxWzk394
	bna7J5+NHvKJ+EU+BM75u3O6gf1hExkrS+wgb18Khg6y7MePpvtXwSMlunc+lHJl
	DBkrIxaXbjXCvBg4Wsy2YoXzgIWuZ9taXaN+g8pVzfP/mXdCWy+vUDvOpVZVsQ9R
	k4SDj6+1G73V8lrwgM8a9B/ftNqu/Rq9GIU6CU2wZTdNifEmk1p4qvL3IfKpcUvH
	UmCApu8AnCpEH4u/8UwU2eeR64nkYZWX7bYz4sp0Suk9izStI92RcXNLkDQHjXx9
	UP7z/yP1bHpG5oXqKWZOcP9q3XFkSGhGKbvRBEvNxlLtl3eJNyp6Ck08Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010004.outbound.protection.outlook.com [40.93.12.4])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 40rjdk40gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AveIP0cx+U2XGMKb0LIfMREeL1S7sd4O6xAXH1STSApA77kS6JZ4sq1Fb3NMuswFjB9QlH/9iq2PNkdijbcdUdCQx/aLD1ngvk4L6kwL3ZqbtUfb5JZmok0uQlJzjWlKp54mMLUIqcPuoRTKaLXj53pLqcCOyQrwLSDV4yQHfw1LyFsNmMN1GSWQtGbdCCVd9CN66SEhKwsim8zJJQg1vFu5GUvfHJEo4p/d54i59hBgKNZp+b4qKsHR78me2hEm8jLBWU7xVr/QNFNqxQ63w4L8j2UnTpgbe9GJhAE4hEzuSkD51lAmponrYJRxxVWh/ORyPUPY/BsYE9mHoSsw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNG8Ew/NWAPAh8pu7dohZmYYKAKO+ze9L7LbrIJbAjc=;
 b=HRWnMmo661o33Zh55d1e5LD61IaOH9tLHbqhU46dEuAdh08YNjmG2VUMxE34U0UgXRvt0EVQy0cfNynoB5HGjPGsJc6F2hXMkx28AI/zBXLSYHrlLDRBHGeQj3TaJTPE7FRv7LDyYUuhtUeR/8UEl3EsvFISsKcmBuo0urO4dLxQdN6hnNyrBxxUjm8dZcUJToDlk9dhKkfcDSI6uAT22YNO5wwK5oQxfhCTrT3RbYVjIDMWmDFj1J2MNc+7wK8jLNCNw/PZ+KBW3RL+ggAsraKuBMUBCmxlRhqzCUaUFeRrOXvKM0abL8whjyjEBu7D/ft6J/GjB5/6EudQNuUwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNG8Ew/NWAPAh8pu7dohZmYYKAKO+ze9L7LbrIJbAjc=;
 b=GqUv9h/COkfBwRtQqwPl0V9fEJkN+EyxuUf294Y6APNaRWuYx9GwLUU51xkGyiIbqMplUHR8zwnf54UBDoe8ic8DQZQV/OyJseovf+H/2N3fbQY1qF/MZOIMKTZ68Rgu/FvCM1+/Tz4cWgdzE2w0UCF5nUQ71Rvvuga0WKAB3d4=
Received: from SN6PR05MB6752.namprd05.prod.outlook.com (2603:10b6:805:bc::31)
 by DS0PR05MB9151.namprd05.prod.outlook.com (2603:10b6:8:c5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Fri, 2 Aug 2024 22:37:38 +0000
Received: from SN6PR05MB6752.namprd05.prod.outlook.com
 ([fe80::919:cd1e:18d2:5bd2]) by SN6PR05MB6752.namprd05.prod.outlook.com
 ([fe80::919:cd1e:18d2:5bd2%5]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 22:37:37 +0000
From: Brian Mak <makb@juniper.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v2] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa5SyT0fa0xUD8R0S0K3p3byXrDg==
Date: Fri, 2 Aug 2024 22:37:37 +0000
Message-ID: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB6752:EE_|DS0PR05MB9151:EE_
x-ms-office365-filtering-correlation-id: fa8bc306-3838-439d-62af-08dcb343b61a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?un5n852M6qo+4OXm1k9p6pPrAkzKEs0dcWRvekQZC1nwmjSQgCgWSQ0ueHwX?=
 =?us-ascii?Q?JHAsXREaMz/4cIHxQ+KJIvdG81iHPnSbFCIl/pJbS3F3yCbAjg+IAiBz1O2e?=
 =?us-ascii?Q?QBdl1J2YYUvrpnwNIyL9aVWIu458383SJ3FUFMG63HxAIS7zSzD/fCDA/PTB?=
 =?us-ascii?Q?bNjT1hZ6ZG1lSWDyKdCKJrtBrpuGeVGne+Ka+npISvA0HlB8TRsAaX9Je6Ou?=
 =?us-ascii?Q?GveUDKPQJ3I0R1a5DWlv9cbrtVXYFRIEJf1FrA6QFYbRRkrZQW1Qwyn+oUx4?=
 =?us-ascii?Q?k9dGdvrtZ9NxEnqNE+EZ52Bmvs264mFNs3PaxRaX7BInw4MR+rnp2/B6vBhY?=
 =?us-ascii?Q?DhyUejeQIt4Y8hWY+6xRJo3HAVmN4A0ilqtVirUiqmcIzQt9ZiwJ5WUpK26I?=
 =?us-ascii?Q?T2K3Mf5TnaEtzSooKaULre2IxeOQMF9ynbJXjS3S0wTKQFuGOK2VEiIJSVm9?=
 =?us-ascii?Q?RN5Alhx8N5Cb5le461g0q7yDS8NZ2fDOI79iZE441Qsfq/zwBn2LcwDiNUJs?=
 =?us-ascii?Q?xAb6qyO9Ux107UdKTxsgM935HZW1pmQO/5dpr1NvUgikr/3YNWkfJn3+KIaM?=
 =?us-ascii?Q?CdHdd3K5G+Wa/TF3kVr3bgmf9xUlhym6mquN7Pp1hZRQnfGwjVkcssJs86LL?=
 =?us-ascii?Q?tpqWjgG20uwhJkxDdrbWGunyGDwjajIPI5d1mv8wE8O88KuESWjWXMt78cdp?=
 =?us-ascii?Q?KX3xUD9TjjtXx/j7Q5AvZgn6nsBpXG0g6ez6pFM8j8ESazvCQomNQ5y8DvF/?=
 =?us-ascii?Q?YWwH6Cj/fp9E1R9UQCZsG/r6g54JCtdHvN7y6p8IXLoxojEgsqeUaqbgcbql?=
 =?us-ascii?Q?vM1kHgCPtLXOJjoSF+e23BOe/B1boDQQAUuzDk5WKByNrDFp259eYqM4Vwi8?=
 =?us-ascii?Q?k6QhEec9GcvbBNh9q4FnfT01BbNB2fpwiNatKrj3HG4NVbUvU8Ewz5nIcLoM?=
 =?us-ascii?Q?HywTjnJmmXOWtT/OunEVA5e4/rw0bI+zq3JhNhBBiFGOq713XsvRtnl47JcA?=
 =?us-ascii?Q?sNwm5cpxSsSyeuUzLbihYBUPDWXYz8HT00APjEVfB12HxmgPjnPoZo4Khftn?=
 =?us-ascii?Q?rFF7dCUSXxdIqNC8riGNHPUEV9QIjP3AmtEs3yKN03aHnv4IpTJvF9hXO1y8?=
 =?us-ascii?Q?YgR1Hv26cWDq2Q2wHmx0neo9fhtAr4eD3EZrmdtZwMiDJme3yzRmCWRa2FeI?=
 =?us-ascii?Q?4wDhDvknTy7UM6rdXAUipwTbBhUdAgqcOIaNzkKfHwqmF2ld0DKixJ0LUhmI?=
 =?us-ascii?Q?5RnrWT9dE8L0ppv2SDpQRgY08KyibfuAOdwcxbJVT8X5vvXCCASRSD/kgPiJ?=
 =?us-ascii?Q?Es6gs4GenRS4ZkR/MC/ISO5jpxXQ/FD5pGgz5SjVs7zoa7MK4ChGXVbhhrZT?=
 =?us-ascii?Q?w/ECvKbGOOvZGwvg3uHF0h7B5caHisMEoIK/oTyJj9ir8gubSA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR05MB6752.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2B1T6Y/gYygUG1HzWJD5K3yYOL0iiRxcdpaB/xok89m+kINT7pwwdJp5dIH5?=
 =?us-ascii?Q?nenoVcnsRgdipk+ypLXSrxEsagzR0BsKzYYmgp8RGRkW4F3Y89ACXqEp2lbi?=
 =?us-ascii?Q?XY7iBbKYH4TTOFsI9QlJDv9EfVsGpyKWVL180AhOtbA/RRYd75hG573oYCFa?=
 =?us-ascii?Q?6LsXS1pPHQ/ODIjNyXLjqexTwIgU1lDr9Zj0Z45oYNqEAn95sYyB2LMmJ02A?=
 =?us-ascii?Q?zW/IAKsJbSaADxH8s46zKnnABJtVahAFrst/f7oIugApQIwVlGqFuHoJLAD/?=
 =?us-ascii?Q?2776qvCejqk/z7hd8wbfNUKiHzkHb26X9W7FFN35/OTh0olWmVkCxknCa1rT?=
 =?us-ascii?Q?VUXIdIqMHgJi9IocB88CG7k3gAJMaXQF4C1u27CTZPSzlLrav91uIfAEf2qe?=
 =?us-ascii?Q?8G3oMfakrfYtT3FoWAUhAlfuVtanPDhxIFmHALMlQQN5Rm+oawkxy6WMh/lS?=
 =?us-ascii?Q?Qwl0YrpQhgoD1DkQV0+l88/2lYx4ktjduuipVclNH5R7LyreMDoIzc1UNnAd?=
 =?us-ascii?Q?bTqYa6b5MddXr0FgJ5NIGT1tLokJGaJl6/7J6ZZkkFSdrzoKamwuFlDFvY60?=
 =?us-ascii?Q?Il/iM7sl52T2iS2w+WMnDLEMD9RP/YPs+L2RK/fM6DizhXtB64fow+TRhxnK?=
 =?us-ascii?Q?bny0NYPbIfe7KdiADAwSjqBTFS7sqVRdnvcLGUVDKO/BhKLkca6cfZbAhkVU?=
 =?us-ascii?Q?/2s9D7l7GxOkaTj9LC8SWuPN+gqqVsJleZj5v2J1Qq3HQK/eWaDOTpEpBM4W?=
 =?us-ascii?Q?RnZqhYXEtmkwrkzNPKjloGb3aSi89tsX3S7iNN0zYcSUJkXcecxXnd3m7fZZ?=
 =?us-ascii?Q?aHPenJtTcC56m5Ol6kkQMtRpT9Ov9XRWCtE4/+j8LeITN//WFywTWaI+e2/0?=
 =?us-ascii?Q?qzeLDzhFR7+mOywW5KLsJ2Zz9cAlnfdfzvsUveLbjeCvEuek5TJ9tj2W9lk8?=
 =?us-ascii?Q?Tgpjy2iAh0hu9hzOQb1Og1oerPq9IF8KB/1uio5uEFVceu0y+NhjY0eIzCV7?=
 =?us-ascii?Q?boO2IARj2CxMYtBz9KSOPvzE6boqDMHml/Og63t/MsT1XyNqvcJXjdraFlsL?=
 =?us-ascii?Q?yzv6sfA/DUwIjXeJVbH4gfqfNiNP8VQWZ50jLtxRWEJWs2PhnCjxAcLEh8Kr?=
 =?us-ascii?Q?Zqmp6e6MO2tWyyuxqPcThAbHXoxIl7OU1qZYYsF45NX1KIXqKFWNuTXyGlxf?=
 =?us-ascii?Q?CAl3rL09mp/NIVnaYZC1dTiS7M09NB0jIWk0SGv55M+AAUWjZqwxqDmXDLFH?=
 =?us-ascii?Q?1Q+OF3IRrfQVEnHlPeg9tyIs9oGMjQsHgXudeZRk1vno3E4zQvGVYgGDElIM?=
 =?us-ascii?Q?9Uo9n6FM6N2Uzp+91RxqqfWuAPmqYrqfnOBVua1QTan/d4cjSGunN2W/5XND?=
 =?us-ascii?Q?0QFbU2Avj4Ppff1wjlxJCOwXN/tQxrnaHbCtBgyRoHdDENmkOpyyffQUWSWE?=
 =?us-ascii?Q?wYs+AJqS6EussNlUYPBKV2Ux+ESocaoIqNkWoEuq201QKPXg3w10kzEr2AbO?=
 =?us-ascii?Q?T4OqpNf63cvg0+F6QFtik+vIfYvTxaf/h8zxgIamwUylG2ouB9MfNQbrGCB5?=
 =?us-ascii?Q?Pi3gy9CkNF2Q6wWoVooy7dH3KDjC6Q4Cu/plnW1a?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1566CC8F20ACAA4D871883ADB800A869@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB6752.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8bc306-3838-439d-62af-08dcb343b61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 22:37:37.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFsIZBUyInzyHrBg/EkoUUH0+6K1HCx3wBl75zo4APza1mwm+ot//rFeBOugCdadUPJxx5fbuiMKiL69w5+gpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9151
X-Proofpoint-GUID: iWcQCK7Q0GgfB8-e4uD5ET2FlX5AFimG
X-Proofpoint-ORIG-GUID: iWcQCK7Q0GgfB8-e4uD5ET2FlX5AFimG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_18,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 malwarescore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=849 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020157

Large cores may be truncated in some scenarios, such as with daemons
with stop timeouts that are not large enough or lack of disk space. This
impacts debuggability with large core dumps since critical information
necessary to form a usable backtrace, such as stacks and shared library
information, are omitted.

Attempting to find all the VMAs necessary to form a proper backtrace and
then prioritizing those VMAs specifically while core dumping is complex.
So instead, we can mitigate the impact of core dump truncation by
dumping smaller VMAs first, which may be more likely to contain memory
necessary to form a usable backtrace.

By sorting VMAs by dump size and dumping in that order, we have a
simple, yet effective heuristic.

Signed-off-by: Brian Mak <makb@juniper.net>
---

v2: Edited commit message to include more reasoning for sorting VMAs
    Removed conditional VMA sorting with debugfs knob
    Above edits suggested by Eric Biederman <ebiederm@xmission.com>

 fs/binfmt_elf.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 19fa49cd9907..7feadbdd9ee6 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -37,6 +37,7 @@
 #include <linux/elf-randomize.h>
 #include <linux/utsname.h>
 #include <linux/coredump.h>
+#include <linux/sort.h>
 #include <linux/sched.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/task_stack.h>
@@ -1990,6 +1991,20 @@ static void fill_extnum_info(struct elfhdr *elf, str=
uct elf_shdr *shdr4extnum,
 	shdr4extnum->sh_info =3D segs;
 }
=20
+static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma_meta=
_rhs_ptr)
+{
+	const struct core_vma_metadata *vma_meta_lhs =3D *(const struct core_vma_=
metadata **)
+		vma_meta_lhs_ptr;
+	const struct core_vma_metadata *vma_meta_rhs =3D *(const struct core_vma_=
metadata **)
+		vma_meta_rhs_ptr;
+
+	if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
+		return -1;
+	if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
+		return 1;
+	return 0;
+}
+
 /*
  * Actual dumper
  *
@@ -2008,6 +2023,7 @@ static int elf_core_dump(struct coredump_params *cprm=
)
 	struct elf_shdr *shdr4extnum =3D NULL;
 	Elf_Half e_phnum;
 	elf_addr_t e_shoff;
+	struct core_vma_metadata **sorted_vmas =3D NULL;
=20
 	/*
 	 * The number of segs are recored into ELF header as 16bit value.
@@ -2071,9 +2087,20 @@ static int elf_core_dump(struct coredump_params *cpr=
m)
 	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
 		goto end_coredump;
=20
+	/* Allocate memory to sort VMAs and sort. */
+	sorted_vmas =3D kvmalloc_array(cprm->vma_count, sizeof(*sorted_vmas), GFP=
_KERNEL);
+
+	if (!sorted_vmas)
+		goto end_coredump;
+
+	for (i =3D 0; i < cprm->vma_count; i++)
+		sorted_vmas[i] =3D cprm->vma_meta + i;
+
+	sort(sorted_vmas, cprm->vma_count, sizeof(*sorted_vmas), cmp_vma_size, NU=
LL);
+
 	/* Write program headers for segments dump */
 	for (i =3D 0; i < cprm->vma_count; i++) {
-		struct core_vma_metadata *meta =3D cprm->vma_meta + i;
+		struct core_vma_metadata *meta =3D sorted_vmas[i];
 		struct elf_phdr phdr;
=20
 		phdr.p_type =3D PT_LOAD;
@@ -2111,7 +2138,7 @@ static int elf_core_dump(struct coredump_params *cprm=
)
 	dump_skip_to(cprm, dataoff);
=20
 	for (i =3D 0; i < cprm->vma_count; i++) {
-		struct core_vma_metadata *meta =3D cprm->vma_meta + i;
+		struct core_vma_metadata *meta =3D sorted_vmas[i];
=20
 		if (!dump_user_range(cprm, meta->start, meta->dump_size))
 			goto end_coredump;
@@ -2129,6 +2156,7 @@ static int elf_core_dump(struct coredump_params *cprm=
)
 	free_note_info(&info);
 	kfree(shdr4extnum);
 	kfree(phdr4note);
+	kvfree(sorted_vmas);
 	return has_dumped;
 }
=20

base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
--=20
2.25.1


