Return-Path: <linux-fsdevel+bounces-37269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A69F0442
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 06:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD41698CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 05:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C1718A6C1;
	Fri, 13 Dec 2024 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="EeZQZDH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568E33EC;
	Fri, 13 Dec 2024 05:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068593; cv=fail; b=hvz3CmOUp/FhSsw6AE2M5y5jib9w4Iayjnl6bYA7qpx92RP7q7wi0nvZzDQdSq0UeYQ3Mcqx8LKuVhxpF5dhacVXgGVo76ROD7Xn2LdKgWtH4szsWXxYfhg6LHFnUf3Uv6Z+V+/79V/miwOHfY79MdNts0l36HHAzgCWjOsLx88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068593; c=relaxed/simple;
	bh=LqMk+XuHKFxl82GLTtZ3iepOi2Cz0ZXQ7QL7Ibw6m1I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=otU3vqfXFLQNMbIBMIA7SRmUxRhspJ5SgMGrJAOPOs0TxN6UZJyJ+ypxdu30lWfXEYxu55b0BpoacsvEXVpprTCORTSZ6GFoi1zSuGSAc0/LpA4GlWAdngUVLWvY43tVLK0Iyowbqd22SBv8EPFVt9rGMxHuYrj6B7CyWnO3EDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=EeZQZDH7; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD0FSqT002876;
	Fri, 13 Dec 2024 05:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=u4qriRg7SNa1zg4HU3qTVz1paTWEc9T
	+SYhYhx1jXrM=; b=EeZQZDH7Z+LNBdaK1mxgM6+Yr3ADrTf8kdQTfaUK4yT7YWk
	4GebWO60f27sQQV8GMF+ZvDhs5wFSt3MzEFxhj/k+59ZJTEIhOnfuJMBzv2voMhI
	wsqwZuo/xENVBbI5spLtu/xFxmBmLp9xlqh0pDGTGofgtS1BbyNxAxMjTcQmBRS6
	9OkAd7eJ2tHsNIjcMoDAmelNq+RSNcR/w1YuQCovUd6srsWiDQ+/nPb94NfyAz3U
	hBCOomdjGuAt2xBmapjMkBLSe0iH2EoRTs9F6c0F/vAEFryD4RvFet+iiEnsRMot
	RQU4EhjO8FiTro1dKAEaboHMQtSs29fjIQazSQw==
Received: from hk3pr03cu002.outbound.protection.outlook.com (mail-eastasiaazlp17011031.outbound.protection.outlook.com [40.93.128.31])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43cc8hw7yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 05:42:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRkcYTsx1W2u8ioJAwWBQ0R5N7HArbIGlXpxVPFQ7h0jPyIag/ZkQhOV709G6o9fCA4i+NdXxlE4zBmTfOqAplB7J37jCD+CLw6nt//oiDEb4Ik+EUUiQirxQZqAvd4h/k3zajP+qFsC9gVONeSV8Nq1YIAsewgxOnpfz966Z3opXTHCFPKMf5U9+t1PNT0rxOMdbVNeWJ4HivOlYHi3omkuhIfySMidoe+iEbywYA+dvd1QGgcMqPxeBbvxTXZ4LTfxUYZbsoGw2E8eXBp/2eicYkuVz0YdIA5L8mz/ZU1sMXYIx16WJkm1KPm8Jn0Da6nlhkAyLbnqCg84rcQZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4qriRg7SNa1zg4HU3qTVz1paTWEc9T+SYhYhx1jXrM=;
 b=ZN8eTN5bY5SKKxBXJ1QfC/HqKmvGe2mNzwylkNClmYfa5WnIas+SohLa5Gk5j4AmFZpX0gitG0sqHq0WJjtu/498LsiMn09g0up10k2K8FmFcglB2MNk8LIbiTz5kCN/KMZfU9D268zJRs+GvOsx89MUNPo7jtZ17NWkQYnOtMlCJzFGZpX00tmFTmJjUvtbq8Qhyq0P/h5/cPJyzldn6j/K2BdV2temsAtVzf16LrENfPJjTfk7wgGRLBWppWZAChnGatf8aWVWXqIa4yz/LGTvuSkux/8NmPloplPGd08R3+xJXiN85Cg4xhkk7BKAeQNKmnKMUnSHjzDDrON8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6332.apcprd04.prod.outlook.com (2603:1096:820:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 13 Dec
 2024 05:42:32 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 05:42:32 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_sync_fs
Thread-Topic: [syzbot] [exfat?] INFO: task hung in exfat_sync_fs
Thread-Index: AQHbTAolB2dOUZDQuEWUFNUD0l+44bLh8H2igAAHUgCAAbNnew==
Date: Fri, 13 Dec 2024 05:42:32 +0000
Message-ID:
 <PUZPR04MB631683FE95D7335DAC257CCB81382@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB6316AD522079C7FEB8E44540813F2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <675a5bc6.050a0220.1ac542.0015.GAE@google.com>
In-Reply-To: <675a5bc6.050a0220.1ac542.0015.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6332:EE_
x-ms-office365-filtering-correlation-id: 305a2bd1-3a99-4398-f6f8-08dd1b38f080
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EBQLyVp/Q3VjTiCYiLm7J6i9gH+JJKv4fq01OEKoNePx3qzifUgwvNTXST?=
 =?iso-8859-1?Q?Oio4pYsd4WS36QFtyS7e8bIAMEO+IlYYNaPRmflZjP9QZ+aKHrrQsbZcTO?=
 =?iso-8859-1?Q?FGU2GqmBkdnCvxh8gQuODsiBFuZJ03TXshVeZqjViv7u+7p2UYCX55wtWk?=
 =?iso-8859-1?Q?lQgTIYDhH/pfraHkjoenR689f4/bB/aFaW5smCoxHoEHcTLDFJ7nzxJ/s7?=
 =?iso-8859-1?Q?n+HPFM8f8a1NtN2qwqHFoKpPcuoNSu20td0hjZsGTgoA2igJUN1n8CgO1G?=
 =?iso-8859-1?Q?SivP4zHHncFVTMs3ZdSbp9v2He3p0GcZnjzH8jYj/4aNlqXkrxZyZX1ZBs?=
 =?iso-8859-1?Q?qMlJZmGpEJrIIAoTHL6OznqB1/cZpC7qq1fb44HDDrBnviWdWThMLWN0+u?=
 =?iso-8859-1?Q?O6MBADHDDM4w+3w8V3Vec0FR4Lt6oQvuqvzdFRd3JVWAdhb95H79F9nG9f?=
 =?iso-8859-1?Q?/a9cwaMLLTTFm30eDUj3whLD8JS4z4/sAChwSX3glUl/GMK8v7sfPInjcS?=
 =?iso-8859-1?Q?P5V1QBcKYIfAXWd36sMME2ZAKsDbdbZQi6nYBPBLIgKs902qni/fBDTMg8?=
 =?iso-8859-1?Q?l0Y17H3YR57i8wD/xlQ5nZp9vbTDGnOKsd+vfY89cPi7iQijEvwrqU7A2r?=
 =?iso-8859-1?Q?Ft58+l/8iGE4fvkIgoJvtobin6B8iDGbNdyMZ5sqajRRyG+WKZO5mbys+w?=
 =?iso-8859-1?Q?aR2ePrqs8PBB5Qrj18bM/W0SZgUZLVVCznU/mGdudm91nvZQKnqwkM15fw?=
 =?iso-8859-1?Q?KKs7nKq/ykQ65p3LoAJr4xsO/IF8zyZSTc6rv4+R4KT6HoMMXmdohD9izD?=
 =?iso-8859-1?Q?Nry79jW21xcoO067mX1TNIryMrxc1wv9s7iD41GgoPIkkeGOoKzmoOeDXi?=
 =?iso-8859-1?Q?okZIMPuE1UwKCAFmeFp/YfGrTuCf6RwbAsTS3K/nm0JTULYX/L1IOiS108?=
 =?iso-8859-1?Q?nsLNGJtvA4yhPCpYEKtj4x/575HmKKzh5WpjPE6msjwC9N3I6aIi+7KcA/?=
 =?iso-8859-1?Q?rU7LEvTfPNtF6dSEyKZn3SeMzxvkcaIRxFHBxZG7gkq5B/D3e5t8pztq7K?=
 =?iso-8859-1?Q?8w0GOz14g9cCqawIV9VuLcp/fJhCN8+AECvQveW8E+xyYD1trXzu3Rn/gL?=
 =?iso-8859-1?Q?0jNywwbZPjVHe+ZRqlur8sh3vN5//6hfLQIL0UwN8ke90epHOCoK+uXETV?=
 =?iso-8859-1?Q?qBTi5WFHgT2XUQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Pc2pYB4rWD0PAcIr+85mErSQ+ijX7ZAjWiU4c67dgylfc8+G0SC3DTakEN?=
 =?iso-8859-1?Q?lHGsKF+/s9md4EV0Ew5+ivh9mliTbwptCcIVMMJDIfPjU42yN1rhneMydr?=
 =?iso-8859-1?Q?5EYPfFMCoc9QOi99ojPU6CwWXBtfKqMasZlRmYITY4aZeXDQha38JtzP8f?=
 =?iso-8859-1?Q?qfTbbP8L8GZmeKWgm642Redb69s92A9vz42FNB8s4mTscaNvHTa0c/kfXg?=
 =?iso-8859-1?Q?hL1esO9ROH+Q9KKtbMRfhDZXWgbJSpo1AESm7vdxsXwfC2uOLXi73NYFT+?=
 =?iso-8859-1?Q?mh0iF4/JDEdabd5nfBCNvKM9h4ooOwQ91vxUK7Cl3J/D644ypJhlqkQgEi?=
 =?iso-8859-1?Q?Q4tjPJRs/caIRsIGsCuKIXpKZqAmQK6AagaP5rEWhqYKYE7Z9YUJ5KmO0w?=
 =?iso-8859-1?Q?joMPr/mI24tpeUBVq2m3HdqLREyarDS7ks9LFQULkL7N/6P8xIaAgPMCH5?=
 =?iso-8859-1?Q?4/warYFHr0i9eYSnyZaExWPGI+NIpUvTcjuBpUylCEtnFdLd3lHyuhXPbj?=
 =?iso-8859-1?Q?qxS68w/NOHHrBp4/cbpWts+RUVbxQUSFWbtRQosbsYlLtITHQoaceYHR3U?=
 =?iso-8859-1?Q?QY9A3lWoBZ+6A4H99vUmmNzxrYEWCbCgYtnpoKisxUrw50FPl8KyB/S4nX?=
 =?iso-8859-1?Q?7j8lw9DCHXHWJHsxYPH+Uyd51uEjr8rwU3Eb7VUOUycuH/oX4ZqRAxR8Ox?=
 =?iso-8859-1?Q?xddE8YK0fOJh3A50BK9vErKZwasoBnYda1i2dYUs81ev80CFnejJAkC6O1?=
 =?iso-8859-1?Q?ZYFRNYX4h9m040MaBCtE3x5TcheeUQU/FCy0TfqYX/se91tEAUX6FANuJK?=
 =?iso-8859-1?Q?r1WTVORswB20c5VSgVkB9sx0AGHdZFo2Rblm8vdrNi6az8Jtfo6ZgAxadh?=
 =?iso-8859-1?Q?3Gv7vyf3jryZ6NbGY9QdP249RuAw8NbanHbDokCG7QeP7hazOCPb6HVMaO?=
 =?iso-8859-1?Q?g7vIgZm/Ki2BOtQEArEmUTdfDXOsl9iNREwMrUtDTDKDJeLpGaUgumHnkI?=
 =?iso-8859-1?Q?uJ+RUFVtyTY5U7A/HCjVUbwnbpX9oRftIt1bRuDrqNWEftel2t2qFsrb0s?=
 =?iso-8859-1?Q?TJBPjy7qtc0cwf/80jvdSeTmcjz5gD/dm5TCWB5f1B+awavVfdPMYksrrv?=
 =?iso-8859-1?Q?u5XXOp2rYPNbUJYwORZ+4+QKi19Tdr2c7x02249xlJ+jBIwR6vbrWT+5np?=
 =?iso-8859-1?Q?/R4AdaiBtW6tvkknAIpTK3ql78XuWV/y49XKtdMrbHQyatDs/gFmvY8JZx?=
 =?iso-8859-1?Q?KULBCGj5MnRcgrWLYWTkpmrPBlJpLAUixaqOnBkDhel8BZ9hi3f1VJW5FR?=
 =?iso-8859-1?Q?eNCy66SpDN/JJU1fTsJ34mGRj0wDHv1hAV/Bh7/3EeHl8DF3+sUiiSdLVK?=
 =?iso-8859-1?Q?hAXZxCOSYFm7M/eGeqitZ9dkSeMGlRBl88Xv2l9R4J3avFht1FLR8GtCrW?=
 =?iso-8859-1?Q?U7mhjdzIQMI+iXU9e68WLbw+vu7NyW8wXF2s6neQHqdBZS62+FWIshVCu9?=
 =?iso-8859-1?Q?SusdCQMKuRgZuya9cllfkW8pup2NoO8e8CRmzvObENsPB6vYBC/JaAExBH?=
 =?iso-8859-1?Q?l6eSDOFXS3FnWMlGXZqmTXVaEIqcdVGpNIa8kdDcw4DUPjYjWSBKUv5LBC?=
 =?iso-8859-1?Q?TC78QzBN9lVJGZ9OEzprB32vMLAT3ut0MREQkHUgD2c84qZsT8BxSH34St?=
 =?iso-8859-1?Q?aXy93mSPi2fqZ1F/XzI=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB631683FE95D7335DAC257CCB81382PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2MapkTmDKOcFfHsZcgTSEf6NIHwm5yZieIdKHgHd0B5RALPaPQtKdS8cjy/0B1UHZYW1CFIYUGGjPeal8x1RD+CcSPPJzrwNTb/YBPpm0miud+Od+1eluwKwg9nesOUn5OmDIoDgMtt8tRndYAhxTQpcWSZ0+OPSijWaRNTJpu6/rZKzga/H9VNGwj/LOIbafnUZ5m2wsp+HrpErYmIrs+TnacfctuYiRuhiznYpDBu7hgq/Yj39md4OlW4nzszTzzBfxwFpMOwi9rcB+fqnNohDqaorZdEwK0inG91+QLBMoF5w8sZLyROMRVH3lWtzVMyb5yltKpOEMknOgt9KqhuMnuFn2y0JpqTun9XGfeRyNf0xwAqOqmzONe6yKT3WSCOF4x6x0I7m/xPRHnB5ZpOmVDd/EQiSz9fsYR6rR+vvFIift++Y2R1iKUQZw6P72z/rA2bn+eJ9MGIXsMIwwTnwZDFXpZEfxebqIMkQ7P39nu4Xtv1WRRcbrSNg7Ajz4QOsbWu1X5oOB+o8AWohw+IaSAcPi+h3Jatp7eLdCPcgrYB9i7eREpxyguUkqFsIfotXmnYXVP9mA07sd83tPQvT8wRcw0QsS81ZlwtnANwwhd2iGibCo0qpf07/PWKY
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305a2bd1-3a99-4398-f6f8-08dd1b38f080
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 05:42:32.3126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48CvBAHBfDTXhsNmCVLvDzxMw/MmzKHGzGm1o7qF1KzSpQSWqDCgDQwb/R7+s5rmJVNnLipJNmhZJbi08ZRzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6332
X-Proofpoint-ORIG-GUID: GRRtpyivpmr7j1zuhacJb0xquYSVT_y_
X-Proofpoint-GUID: GRRtpyivpmr7j1zuhacJb0xquYSVT_y_
X-Sony-Outbound-GUID: GRRtpyivpmr7j1zuhacJb0xquYSVT_y_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01

--_002_PUZPR04MB631683FE95D7335DAC257CCB81382PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=0A=
=0A=

--_002_PUZPR04MB631683FE95D7335DAC257CCB81382PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-the-infinite-loop-in-exfat_readdir.patch"
Content-Description:
 v1-0001-exfat-fix-the-infinite-loop-in-exfat_readdir.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-the-infinite-loop-in-exfat_readdir.patch";
	size=1355; creation-date="Fri, 13 Dec 2024 05:41:59 GMT";
	modification-date="Fri, 13 Dec 2024 05:41:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYmE5NmU2ZTQ5MjNmMGFkMGQxYmJjYzA3N2U4ODdkNWQ3MDMxYmMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IEZyaSwgMTMgRGVjIDIwMjQgMTM6MDg6MzcgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZml4IHRoZSBpbmZpbml0ZSBsb29wIGluIGV4ZmF0X3JlYWRkaXIoKQoKSWYgYSBjbHVz
dGVyIGlzIGxpbmtlZCB0byBpdHNlbGYgaW4gdGhlIGNsdXN0ZXIgY2hhaW4sIGFuZCB0aGVyZQpp
cyBhbiB1bnVzZWQgZGlyZWN0b3J5IGVudHJ5IGluIHRoZSBjbHVzdGVyLCAnZGVudHJ5JyB3aWxs
IG5vdCBiZQppbmNyZW1lbnRlZCwgY2F1c2luZyBjb25kaXRpb24gJ2RlbnRyeSA8IG1heF9kZW50
cmllcycgdW5hYmxlIHRvCnByZXZlbnQgYW4gaW5maW5pdGUgbG9vcC4KClRoZSBpbmZpbml0ZSBs
b29wIGluIGV4ZmF0X3JlYWRkaXIoKSBjYXVzZXMgc19sb2NrIG5vdCB0byBiZSByZWxlYXNlZCwK
VGhpcyBpbmZpbml0ZSBsb29wIGNhdXNlcyBzX2xvY2sgbm90IHRvIGJlIHJlbGVhc2VkLCBhbmQg
b3RoZXIgdGFza3MKd2lsbCBoYW5nLCBzdWNoIGFzIGV4ZmF0X3N5bmNfZnMoKS4KClNpZ25lZC1v
ZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KLS0tCiBmcy9leGZhdC9k
aXIuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9leGZhdC9kaXIuYwppbmRleCBm
ZTBhOWI4YTBjZDAuLjMxMDNiOTMyYjY3NCAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvZGlyLmMKKysr
IGIvZnMvZXhmYXQvZGlyLmMKQEAgLTEyMiw3ICsxMjIsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3Jl
YWRkaXIoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90ICpjcG9zLCBzdHJ1Y3QgZXhmYXRfZGly
X2VudAogCQkJdHlwZSA9IGV4ZmF0X2dldF9lbnRyeV90eXBlKGVwKTsKIAkJCWlmICh0eXBlID09
IFRZUEVfVU5VU0VEKSB7CiAJCQkJYnJlbHNlKGJoKTsKLQkJCQlicmVhazsKKwkJCQlnb3RvIG91
dDsKIAkJCX0KIAogCQkJaWYgKHR5cGUgIT0gVFlQRV9GSUxFICYmIHR5cGUgIT0gVFlQRV9ESVIp
IHsKQEAgLTE3MCw2ICsxNzAsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlYWRkaXIoc3RydWN0IGlu
b2RlICppbm9kZSwgbG9mZl90ICpjcG9zLCBzdHJ1Y3QgZXhmYXRfZGlyX2VudAogCQl9CiAJfQog
CitvdXQ6CiAJZGlyX2VudHJ5LT5uYW1lYnVmLmxmblswXSA9ICdcMCc7CiAJKmNwb3MgPSBFWEZB
VF9ERU5fVE9fQihkZW50cnkpOwogCXJldHVybiAwOwotLSAKMi40My4wCgo=

--_002_PUZPR04MB631683FE95D7335DAC257CCB81382PUZPR04MB6316apcp_--

