Return-Path: <linux-fsdevel+bounces-75325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKDeEpACdGlA1QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:21:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C88827B756
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39EAC3006110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A203283FD6;
	Fri, 23 Jan 2026 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QXmQeO2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7E1990C7;
	Fri, 23 Jan 2026 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769210506; cv=fail; b=TRYjf1yq/pi11092uNtMAP4KLTgxrSPLTdeCtPQbDTZ37n144WW8A/PS6t8f62AO30ODsIPfevvFxnMH8kfi7jZSn4wEWu92Wuxif8a/deRwRvmhkxh27EdDSV/z3WbkD0R928ptTzvVY/klevpUeQeI25MuzxrLsL0WwaOPK5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769210506; c=relaxed/simple;
	bh=g6XwPvdpe4SjK9wBEoT4Dxka+nObxhyIUre9RRsLJCY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lTG5URimnBMD+CnUmIq6HKLIvKvAQOoqiYQxZnzGa4JJkiRc18Csn4PVHOOPHDcihgBNVu4MLUgTHuaFuND7CGGjkqjJjY7J67DJzerqSTU2qWYJv4csQy/xYsnHNwQJmeSO4wfd+dohZrlwWwp4tAkBeLe749DGlhRHQ23HgtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QXmQeO2S; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NDk5Jp019542;
	Fri, 23 Jan 2026 23:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=g6XwPvdpe4SjK9wBEoT4Dxka+nObxhyIUre9RRsLJCY=; b=QXmQeO2S
	H1c7VERd7DbmYemDJyVl5qknhTWplQ2o4tY/ZSdJzfni5xd+Y5aYdYGgU+tpB/0c
	zesRJb/QZJab3OCGFoNweqR0aElCQ0WeDOTYi045BnfGgIVwhxX/ScpLl2e87aH7
	H/4xWlowpR+F3chi4Ha0uyb/QZ3+iHXqDZnZvlCyxp0f2JJK2fA+epbL5bQ0OsYF
	11vS0lycNBWfaARhLm7ptiqS8toriOtfs2q+JLNrhw15WmFC+ifGfeBpYgHdKPQ1
	LQOFhwlz1ybpGKp75101zOhzHIDw6KL2K5fAyjoz62MIM9emEvRMEMeClANKRJVP
	p30A9uCtTen5Bw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256ju0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 23:21:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60NNLcDl006893;
	Fri, 23 Jan 2026 23:21:38 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256ju0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 23:21:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3RkoywpW7Olq67vE+gAyK8RLtWpJpB+3d+ghE/vuVymiZN6pu75KVLa2FgxsYUVP3DkgwI2zTTu1aeawaz+obaTDjk0I5IThPVUS9DFwiw1FWayNdEmLdY9JUrezkpO5PExjjTSkGVthsmuHTRJRHahKjMO9087tBTL6U2c2IVMfNl45okuJZwNJZMJeu6bA4mhOIC7TtC94htvht8kPRgSl+/0HXpU6xJGtASvvDDDFfQVMAIU7OMTRCUOhicPtNTHAWMl3IVT/kE268b7JTl6JcE5rSDngAxT8H+9Po4cric3VSydxN43KxNvyvs447TMFAdt5LFthMqwMqHiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6XwPvdpe4SjK9wBEoT4Dxka+nObxhyIUre9RRsLJCY=;
 b=tRvDSYEPH5CGrootOfT9Ta9Di2Ho4GnKDmHi+sruvL3RhlwzlxRIYNhOJ4SoicCMYmmHMpQx13QeOZYWkFcdFgApuSlCYRKG5v3Ht3b1I5yujZRfX+3C8lOJwgDLwInh+5wWstG/MqqWieg7jWCn0ff1wwSc1Tb581BjfNR3BgQr/VHczNqRdYfOzFTTM8LoPi0hqPH8jTz8NGYpuT205/hMBk8rG4A/YWq28i9o+GTpoDjoZzEEJDn/G1Bh6WlSrrl0Ej8+JDThSY8VmoFOJcVG2u1Ai3z709dDzDYDwyKKDxbbZPvAHy/+xjkDXjj1Ii74dLxhqA4qS13g15M80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5781.namprd15.prod.outlook.com (2603:10b6:8:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 23:21:36 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 23:21:36 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: fix uninit-value in
 hfsplus_strcasecmp
Thread-Index: AQHcip7gBQv9tICp4U+VJX3elcUj9bVdDvkAgAHwkYCAAWlAgA==
Date: Fri, 23 Jan 2026 23:21:36 +0000
Message-ID: <eefff28b927ccc20442063278e65155c1ed5acd8.camel@ibm.com>
References: <20260120051114.1281285-1-kartikey406@gmail.com>
	 <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com>
	 <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
	 <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com>
	 <CADhLXY6wFsspQMe0C4BNRsmKn2LaPaBFfOh1T+OBibuZVSo70g@mail.gmail.com>
In-Reply-To:
 <CADhLXY6wFsspQMe0C4BNRsmKn2LaPaBFfOh1T+OBibuZVSo70g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5781:EE_
x-ms-office365-filtering-correlation-id: 37b5a500-e913-47a9-6a1e-08de5ad6276a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjY3QmZCNW1mT1RYQk1OY0p6NjZDK2hoelBZSjRYWnU4NmR1WkFFQ1k2Rys0?=
 =?utf-8?B?ZHRpYXFtWjhZZUE4Vk9VMmhZSzhIMGtsNlpzKzYzOGxCcllwOHVwQzJQOHB3?=
 =?utf-8?B?VXQ5NEVOUFc1QUVZUm9yY0dHemZ4aEFzM3h6TStlL3F3R2FNdW1OZEJJOXFw?=
 =?utf-8?B?QkY2ZytaR1VndC9uK0ZIeWd1MXRYaTBGajRrbFkxTWNjZjI4NXV1cXdsZHpX?=
 =?utf-8?B?anV1TTlXMW9MblNZUUVqb0ZXQ2dqYXNGZGRSbS9LbloyK3g2OUpuQ1g4cUJv?=
 =?utf-8?B?cWd0Y3FMelpSbDNBb1lFdVhUazJLZ2hKa0RnWWNvdTBlOHFrUXYwZlVFaEZX?=
 =?utf-8?B?Mm5RNkp6M2s2K3hGdnlFWkRGYmhMNEFRYUxhV3BIMk1QL202bGFqaVJIZytW?=
 =?utf-8?B?SmtPRm51RUR4VDRsbU9DZS9FNXJVTlZ3WG9IUzAvN0ZsV3J1dUtud2pyaEpO?=
 =?utf-8?B?Nzg1T2x5SVhxNHBpRzlqWFI2YlEwTGs5RytkYlhoU2RrZkFkQWMrU2UvMEJO?=
 =?utf-8?B?Q0hkT1AySDlJa1RJMjhRblRHVHp3S2JNZnU5K3pYa1BjTm9nMmI0YkdTRGJs?=
 =?utf-8?B?dEVuVXd1VEFFZUhCamZuSHBGRWpXRHQzc0N1SGd5dVJORG9mU1JzZzBaTE12?=
 =?utf-8?B?RHRtVVJxbS9RVno1M1M1Yy9iNGlMZExCQ2xVM0hHWThIVzFsYlh6akJsLzBh?=
 =?utf-8?B?UVh6U2Z5bS9KQ1dSQXN1dDdpTmxad3R3c0d0Z0lQQlNXZC9qNGxsK3Q2UTdX?=
 =?utf-8?B?cVZjbUtPZUtNRkdoZGhqTnpHbFRVTFd5NEE4VTVrbDdTRXc2ekZ0c1g3QVVY?=
 =?utf-8?B?dVlpcERhMUg3eXlrajlLN3VuUTVBd1hpNk56Q1FJZGpLY3I5U2NpcFhUOTdL?=
 =?utf-8?B?NmtmMytMS3ltbFEyNjY4S2l2OFdDWE5VSktZUloyd3QvWHVhK05NOEJsL0NU?=
 =?utf-8?B?ZXZwK2lyNEtWYkJ1UWlFSTdHRGZ1UkM5dlFWaVZyU2liVjhDd2Jvb2ZTMWZB?=
 =?utf-8?B?NW8ybmhyT3pHZUs1LytzdmwvNjE2RkVDRjJ1OWlSMURLWWhMOElBelA1cVBz?=
 =?utf-8?B?YldyUHNVc1RrcFBlU0p4MkFTNFpPemsrd2JBTVYzT05iODZEdERKcHNIRE9Z?=
 =?utf-8?B?N3hDbjc2enlNbG03dFl0czFORVpZUmswMG1VZHcvWU9RYTBQYzNlUzd4UEFJ?=
 =?utf-8?B?V1VxbTAxQlphMStKQ0NvQ0tPRGNISzN2QU5YVmUrdFZ2aXhPK3U3THF5TGZB?=
 =?utf-8?B?c3gvN2sxRTBCcXU0cTMzWFV1aUlOY1RRZkV0d21pem5hNGV6NmhRdnpPenAx?=
 =?utf-8?B?cWRLdzFVQVF0eFVRWjdSTTV6ajZ0aU5QZ1RBS0QrbVd3UFFUSk43emltUnRW?=
 =?utf-8?B?dk5jMnNGVUxqUzNNb1p2L0lLbWx3bDJBT2lYUWdja0VvSzNIT29HNVh0ZE9Z?=
 =?utf-8?B?SVVPR0J2MzJXVC8rZFFGNENGSE1DZnJwcVd5c2doeUc3THlQZ3RIaW9qbmZp?=
 =?utf-8?B?Y2tNUFNpZFltdm40dE1XNFowQ2lyL0xLTVl1WVU0RzUya3ZQU2dNUXQxYjdH?=
 =?utf-8?B?SldwQWN4b0FSZ3lWTVZkUjl0dHZpRnJRUFdaR2VrR1hmVlFaT2wwaGRkak9Q?=
 =?utf-8?B?c0E2VjFTdXRxRnJOVVZwYm4vWWY1cWZpWEJhbUFCZWdxbGdhaWpJdVlmSEFj?=
 =?utf-8?B?VndNRkJVd2R5dUdxYzhlZFRaSWIvSkNCQUdtamgzK00rYXg1THpCbXE2bXdS?=
 =?utf-8?B?bUcvL3hkakZQM0NPU1Z5a1FudU9tNGRrZXNzRFBJdDdrZFpld3k1ekdWVk9C?=
 =?utf-8?B?eTFTd3hsTDZicFZGMW94QzhMOENoYTI5LzVYQk13OGswNElIcTV0Lzdjekk5?=
 =?utf-8?B?Y2ZCU0g2Ui9OS0xjWVFtODNHdG5RMUZHVVhYRDJpVUxsRi9WWm51b2lGd3p0?=
 =?utf-8?B?d1VKeEpNVThrU3oyYnppZGpFSG5Yd3JGSHg2ZVRyM2xKU0NjL0NibjBlT1FO?=
 =?utf-8?B?ODJ6K2RrWjFRcTYyNVQ0SC9YTk5uUWVaNEZDWnNRNGY5U0NMOGdwcTc3Zzlh?=
 =?utf-8?B?bWhma29xZFJ1aUF5eVZYLzVrcVpUcXlIU0lTNjBkT0x4RjFnaW1SQjBxZjhi?=
 =?utf-8?B?L3pvdkUrRWo2cHJsVTdCOUhVNzVRUC8yaFdyTW0rc2pFU1JGb0dsVzVqQzBk?=
 =?utf-8?Q?GxH6shFNZidcLXP95vNOLfI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFh3ZU9acVZlNDk3WVV4QjNqMS94MjQvdk9TckV0MmpIcVV3bytEd2lsVlFT?=
 =?utf-8?B?MUY2OUdDSEV5b1ZQS1I0REdhVjNjc2d6VnUvNmwzK2FSR1A1dVY0WXpYQ0hU?=
 =?utf-8?B?Vmw2azFjMDZWN0VoSTBjMlcvVXhkVjJRaE1QL1A4WnNwdUdTU1h5S0dFMExp?=
 =?utf-8?B?SGZaZ00vWmNMUDY1TE4rZjBpMWtJQjlqYUEvMklrRDQ0MjM4ME9vZjJCck92?=
 =?utf-8?B?cTZDRVkzelQwMTk5M1g2c0g4SE0zeTFwZ05VaXorcWFWZEUzQ0JUOUcxTlo2?=
 =?utf-8?B?eXB4VDc0UzlweTlYekxPZkFKTEhKeUNTbVB0WXAxazhHVUQ2NVBUb2JQZG5q?=
 =?utf-8?B?WDlzZm9YQkNXMHBiWk5vNThmNlA2ZnJCVXFxZVExN1pHbVRiSjBnZ09FME50?=
 =?utf-8?B?b0U5OG9EcFlwanduM05zR1RxaytEM0piT1MvanE2alcxdThBWWMrdVg4azRJ?=
 =?utf-8?B?ck0xSWhvVDEvTVlqM3BHcFZER013UFlKdWJ0eTZidzZrV1prc3lLODZRYyto?=
 =?utf-8?B?anRpYXpUTjJna01xYnJwdXFmc0pGRTdLaDJjRUFLUC8xdXdDZ1Q3ZmdKMGJi?=
 =?utf-8?B?d1ErK0pOL0hTNmdNcVJxK3dQWndubXJlaC9YNVBBNGFXM09GOUI3RXgzc3Ny?=
 =?utf-8?B?S2VCNEV0aDErVHloaVJzdnM2UitIb3Z6aklCWmtrQWwzSjFXdy9WNitPS0RC?=
 =?utf-8?B?MjVySWJVV0lHNkxnblJWOEVNdkRQMlNhTXFKSEtLWjRTQlNPdVJjclpuTTZ4?=
 =?utf-8?B?L2tMaUVHSVVIUCtyWHQrTWlwOG4rMDMxVkhNZ1hhR3BKd0czeEE1UkRBMjR2?=
 =?utf-8?B?cXUzTDJLa2RBbStZUTBqWi8waHpkNUJ2WVgwdkNkai9yTGRuRUhidUd4TU9E?=
 =?utf-8?B?R2FmREErYVhkS2U2S3N6UnptSklTTjFPOGxWV1JZalJ6VC9tbVBMdVhzRytO?=
 =?utf-8?B?VSsvOTA2ZEVYRTQrWEpjdzVBWjVuVzBJa2F4ZDdwdGo4RWQ5em9vbjQvMmxu?=
 =?utf-8?B?d3BDNjMxeERETG50M1JsbWZMUFZ5d3I0ZmN1ZDU3MkVHcWh0ZFA3cUpBV2Rq?=
 =?utf-8?B?azhacFdsSnZ0N0NLRUJYUDAxazJtN3htb2x0Y1dmRERXNXZiMEd3bktObE8v?=
 =?utf-8?B?SGtUMFJLQU9RUzhKalEyd1RnY0pFZHJpTzArellIUkttSXE2RTJUZFF1MXRa?=
 =?utf-8?B?K05MU1hoVmd6WlZTUUpzTDB3NHAwZ0c1NncyVlE2c0hOWnZlK1l1Zm1zRkxE?=
 =?utf-8?B?aXRDY25DdmhDTVZhbjFsZE01VWNJcjlCMHV4d0xGaFl6cnRZdlFPOUxCUWNs?=
 =?utf-8?B?YjlIVCtNQlU4RS9QenA5Skl0aFRpSm9mYWtMckZyTGZGN2NMMHl0Z3dTVHBU?=
 =?utf-8?B?NXZzdjVuNWpJL0NLY3pzUnpUdHNZMTJ6KzlMZWVxZFZBOERwSW1iL3Q2MFJM?=
 =?utf-8?B?Tm14ZUZJMVc3eWdwRysyRU5xbkhkaVFzR3IvTy9kZklGa2x6WDBob0MwNVVK?=
 =?utf-8?B?bFdVc0loVVVZZEFiYUpqdnhaMVpndVRFUzhLbDh1RWN1c1JrQVQzQkJnVGtE?=
 =?utf-8?B?VGFkc3dBSmZNVlRoM0s5Y0J6ZS9Dbkp6Q3FpMERuMWpscW9ZTDN1a29wZER4?=
 =?utf-8?B?MG0vSXoyM2VNR3JOU2JRQmJDSHNJM2tTbHdQMVZuS2s0czd4bGZZNmsxZk92?=
 =?utf-8?B?WDVnWm5EL1BzNDlvQUg3VTgvY29rZFVaZ1IrbXFyL2E4N2tORTNUT1QzeGVr?=
 =?utf-8?B?T0x4Um1YMjZLeUlseVJvRXRWTWtoaFhiaVJqY1IzN1UwdkRUUmtsNnptVE0x?=
 =?utf-8?B?cHdZY2pLb0FGREVFSVRDQ2J0a0dGb3JGRnFmWWJqcmtWdFRZYjVyd1NjTlBy?=
 =?utf-8?B?bzFsR1Q0NGxGS3N2dnU4Q0F1SFJsV1piTU1VZFByejhKdmFmVWYxNmN2YkZE?=
 =?utf-8?B?SHlkQlFwcjBpdWpPeVJrUFhkaHk4T0V0QWJCUVJXMzZETElsUHJpMklSQXFm?=
 =?utf-8?B?TmpUeGRwendzdG9EUmZPQmJESldLY05KZ21YMkd3eUVtcnNtc2FEbzQ0cTU0?=
 =?utf-8?B?RzZjcWZZck9pZXExai9vN1NReGNIa0s5b2FxdnYyNk1yMGtXNElRT3ZsZTdQ?=
 =?utf-8?B?QXJjVHlvdjFuLzVuVW4yNUs3LzRmS2FBTGN0OXZiVWNReXh1eEszemdUUERB?=
 =?utf-8?B?endPZUI0SjR6ZnJzZ0pLM0tQYnhMMnBWN0tsYXN6THk5MWdQT0crT0hJcWVL?=
 =?utf-8?B?S0ZqdnduZWZrMGQycjUydm9pT1MwUG5nMG9jcmlvd1FwRjlQUWlBL1JCSHQ3?=
 =?utf-8?B?amVXekRuTTNBYXU2Rk5EaThzckpMei9JdDhkOCtyQ1pURWMrdXpnVG43U3lh?=
 =?utf-8?Q?mYp1v4q8vFQib05sDlINFgquuipPeQYcziQhJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F62731E7B923394FB125F8E18CD2E02F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b5a500-e913-47a9-6a1e-08de5ad6276a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 23:21:36.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vV0Nr20i0v0S93a2i3hi0wVdWVuHvJNDCnIGfNX8djxY3a272w6WAXSBX/A7oq4T4BUTUV1rr/76kKvJkaceMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE4MSBTYWx0ZWRfXygn3bHDk7wvN
 Qoffz4lSEwIZf0IoHZeGt21okARDIsFhaU/xPPETIvf3kv3FIOsyIZ9tImiw3jif3u2rE7azrp9
 UnKgs4uRuFrZ4gQZxxbWIlcQpFupm3Te+ct8X9tzIW30Gsd8Dsm+nWin/ESA40q+wecSYrrosed
 A5WJdLeAy6m0RLKiDvJXW8p22PkWGiGMaZpyTfzrL1vnh1UAEoNhZKRW+E+phF1DUK2kWfzwrJw
 hy9DMOyNcMy1daF4PrcOsPEusyjr6+1zncCnLovcdnkqS6ni08TDQogeUuIHjTJ8AblMJRQlU4O
 V4KqoLenBjr6uW702ama0TnERK9EQyGqD/SS4eAPF3qycLQXJbwh//UqlnKptImOQvLHJ/b0NPa
 6Ew6rsTnXHWJSmAljXc9r7BmEDEZt2jhIH57UPeVh/iJSRGugJjO9O9EwllwdJp4idUDqLkzt+s
 gxOoCKW655T95rlzMSg==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69740283 cx=c_pps
 a=R3Nq4yRH+PcKhTCrdXTq7w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=6BuZVKP7xb0G_X9Sv-IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FSv8FT39kZtVnxaQd1S4sqFsXEIiKa3V
X-Proofpoint-ORIG-GUID: oFnHIqomQ3_58JtRbS9mPR9qPqnxKlMv
Subject: RE: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75325-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C88827B756
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAxLTIzIGF0IDA3OjE4ICswNTMwLCBEZWVwYW5zaHUgS2FydGlrZXkgd3Jv
dGU6DQo+IE9uIFRodSwgSmFuIDIyLCAyMDI2IGF0IDE6NDHigK9BTSBWaWFjaGVzbGF2IER1YmV5
a28NCj4gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSSB3b3VsZCBs
aWtlIHRvIHNlZSB0aGlzIGV4cGxhbmF0aW9uIGZvciBjb25jcmV0ZSBwYXJ0aWN1bGFyIGV4YW1w
bGUuIFdlIGhhdmUNCj4gPiB0aGlzIGFzIHRocmVhZCByZWNvcmQgaW4gQ2F0YWxvZyB0cmVlIFsx
LDJdOg0KPiA+IA0KPiA+IHN0cnVjdCBoZnNwbHVzX3VuaXN0ciB7DQo+ID4gICAgICAgICBfX2Jl
MTYgbGVuZ3RoOw0KPiA+ICAgICAgICAgaGZzcGx1c191bmljaHIgdW5pY29kZVtIRlNQTFVTX01B
WF9TVFJMRU5dOw0KPiA+IH0gX19wYWNrZWQ7DQo+ID4gDQo+ID4gc3RydWN0IGhmc3BsdXNfY2F0
X3RocmVhZCB7DQo+ID4gICAgICAgICBfX2JlMTYgdHlwZTsNCj4gPiAgICAgICAgIHMxNiByZXNl
cnZlZDsNCj4gPiAgICAgICAgIGhmc3BsdXNfY25pZCBwYXJlbnRJRDsNCj4gPiAgICAgICAgIHN0
cnVjdCBoZnNwbHVzX3VuaXN0ciBub2RlTmFtZTsNCj4gPiB9IF9fcGFja2VkOw0KPiA+IA0KPiA+
IFNvLCBJZiBoZnNfYnJlY19yZWFkKCkgcmVhZHMgdGhlIGhmc3BsdXNfY2F0X3RocmVhZCwgdGhl
IGl0IHJlYWRzIHRoZSB3aG9sZQ0KPiA+IGhmc3BsdXNfdW5pc3RyIG9iamVjdCB0aGF0IGNvbnRh
aW5zIGFzIHN0cmluZyBhcyBsZW5ndGguIEV2ZW4gaWYgZmlsZXN5c3RlbQ0KPiA+IGltYWdlIGlz
IGNvcnJ1cHRlZCwgdGhlbiwgYW55d2F5LCB3ZSBoYXZlIHNvbWUgaGZzcGx1c191bmlzdHIgYmxv
YiBpbiB0aGUgYi10cmVlDQo+ID4gbm9kZS4gSWYgeW91IHRhbGsgYWJvdXQgImhmc19icmVjX3Jl
YWQoKSBtYXkgcmVhZCBwYXJ0aWFsIG9yIGludmFsaWQgZGF0YSIsIHRoZW4NCj4gPiB3aGF0IGRv
IHlvdSBtZWFuIGhlcmU/IERvIHlvdSBtZWFuIHRoYXQgbGVuZ3RoIGlzIGluY29ycmVjdCBvciBz
dHJpbmcgY29udGFpbnMNCj4gPiAiZ2FyYmFnZSIuIE15IG1pc3VuZGVyc3RhbmRpbmcgaGVyZSBp
ZiBoZnNfYnJlY19yZWFkKCkgcmVhZHMgdGhlDQo+ID4gaGZzcGx1c19jYXRfdGhyZWFkIGZyb20g
dGhlIG5vZGUsIHRoZW4gaXQgcmVhZHMgdGhlIHdob2xlIGhmc3BsdXNfdW5pc3RyIGJsb2IuDQo+
ID4gVGhlbiwgaG93IGNhbiB3ZSAicmVhZCBwYXJ0aWFsIG9yIGludmFsaWQgZGF0YSI/IEkgZG9u
J3QgcXVpdGUgZm9sbG93IHdoYXQgaXMNCj4gPiB3cm9uZyBoZXJlLg0KPiA+IA0KPiA+IE15IHdv
cnJ5IGlzIHRoYXQgYnkgdGhpcyBpbml0aWFsaXphdGlvbiB3ZSBjYW4gaGlkZSBidXQgbm90IGZp
eCB0aGUgcmVhbCBpc3N1ZS4NCj4gPiBTbywgSSB3b3VsZCBsaWtlIHRvIHNlZSB0aGUgY29tcGxl
dGUgcGljdHVyZSBoZXJlLg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBTbGF2YS4NCj4gPiANCj4g
DQo+IEhpIFNsYXZhLA0KPiANCj4gVGhhbmsgeW91IGZvciBwdXNoaW5nIG1lIHRvIGludmVzdGln
YXRlIGRlZXBlci4gSSBhZGRlZCBkZWJ1ZyBwcmludGsgdG8NCj4gaGZzX2JyZWNfcmVhZCgpIGFu
ZCB0ZXN0ZWQgd2l0aCBzeXpib3QuIEhlcmUncyB0aGUgY29uY3JldGUgZXZpZGVuY2U6DQo+IA0K
PiBIRlNQTFVTX0JSRUNfUkVBRDogcmVjX2xlbj01MjAsIGZkLT5lbnRyeWxlbmd0aD0yNg0KPiBI
RlNQTFVTX0JSRUNfUkVBRDogV0FSTklORyAtIGVudHJ5bGVuZ3RoICgyNikgPCByZWNfbGVuICg1
MjApIC0gUEFSVElBTCBSRUFEIQ0KPiBIRlNQTFVTX0JSRUNfUkVBRDogU3VjY2Vzc2Z1bGx5IHJl
YWQgMjYgYnl0ZXMgKGV4cGVjdGVkIDUyMCkNCj4gDQo+IFNvIHRoZSBleGFjdCBzY2VuYXJpbyBp
czoNCj4gMS4gaGZzcGx1c19maW5kX2NhdCgpIGNhbGxzIGhmc19icmVjX3JlYWQoJnRtcCwgNTIw
KQ0KPiAyLiBUaGUgY29ycnVwdGVkIGItdHJlZSBub2RlIGhhcyBmZC0+ZW50cnlsZW5ndGggPSAy
NiBieXRlcw0KPiAzLiBoZnNfYnJlY19yZWFkKCkgY2hlY2tzOiBpZiAoMjYgPiA1MjApIC0gRkFM
U0UsIGNvbnRpbnVlcw0KPiA0LiBSZWFkcyBvbmx5IDI2IGJ5dGVzIGludG8gdG1wDQo+IDUuIFJl
dHVybnMgMCAoc3VjY2VzcyEpDQo+IDYuIEJ5dGVzIDAtMjUgYXJlIGZpbGxlZCwgYnl0ZXMgMjYt
NTE5IHJlbWFpbiB1bmluaXRpYWxpemVkDQo+IDcuIHRtcC50aHJlYWQubm9kZU5hbWUgY29udGFp
bnMgdW5pbml0aWFsaXplZCBkYXRhDQo+IDguIEtNU0FOIGRldGVjdHMgdGhpcyB3aGVuIGhmc3Bs
dXNfc3RyY2FzZWNtcCgpIHVzZXMgaXQNCj4gDQo+IFlvdSB3ZXJlIGFic29sdXRlbHkgcmlnaHQg
dG8gcXVlc3Rpb24gdGhpcy4gVGhlIHJlYWwgaXNzdWVzIGFyZToNCj4gYSkgaGZzX2JyZWNfcmVh
ZCgpIGRvZXNuJ3QgdmFsaWRhdGUgbWluaW11bSBleHBlY3RlZCBzaXplDQo+IGIpIGhmc3BsdXNf
ZmluZF9jYXQoKSBkb2Vzbid0IHZhbGlkYXRlIHRoZSByZWFkIHdhcyBjb21wbGV0ZQ0KPiANCg0K
SSBoYWQgbmFtZWx5IHRoaXMgZmVlbGluZyB0aGF0IHNvbWV0aGluZyBiaWdnZXIgaXMgaGVyZS4g
OikNCg0KPiBIb3dldmVyLCBpbml0aWFsaXppbmcgdG1wIGlzIHN0aWxsIG5lY2Vzc2FyeSBhcyBk
ZWZlbnNpdmUgcHJvZ3JhbW1pbmcgLSBldmVuDQo+IHdpdGggYmV0dGVyIHZhbGlkYXRpb24sIHdl
IHNob3VsZG4ndCBoYXZlIHVuaW5pdGlhbGl6ZWQga2VybmVsIHN0YWNrIGRhdGEgaW4NCj4gZmls
ZXN5c3RlbSBzdHJ1Y3R1cmVzLg0KPiANCj4gV291bGQgeW91IHByZWZlcjoNCj4gMS4gQ3VycmVu
dCBwYXRjaCAoaW5pdGlhbGl6ZSB0bXApICsgc2VwYXJhdGUgcGF0Y2ggdG8gYWRkIHZhbGlkYXRp
b24/DQo+IDIuIENvbWJpbmVkIHBhdGNoIHdpdGggYm90aCBpbml0aWFsaXphdGlvbiBhbmQgdmFs
aWRhdGlvbj8NCj4gDQoNCklmIHRoZSB3aG9sZSBmaXggd2lsbCBiZSBzbWFsbCwgdGhlbiBvbmUg
cGF0Y2ggaXMgYmV0dGVyIHRvIGhhdmUuIE90aGVyd2lzZSwNCnBhdGNoc2V0IGNvdWxkIGJlIG1v
cmUgYmV0dGVyIGZvciB0aGUgcmV2aWV3Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiBJIGNhbiBw
cmVwYXJlIHdoaWNoZXZlciB5b3UgdGhpbmsgaXMgYmV0dGVyLg0KPiANCj4gVGhhbmtzIGZvciB5
b3VyIGd1aWRhbmNlIGluIHVuZGVyc3RhbmRpbmcgdGhpcyBwcm9wZXJseSENCj4gDQo+IERlZXBh
bnNodQ0K

