Return-Path: <linux-fsdevel+bounces-43150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF1A4EBC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945DA165B73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8819204874;
	Tue,  4 Mar 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mm5Nm7qH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3A23959A;
	Tue,  4 Mar 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112500; cv=fail; b=hgRQlzfDxcWUIxBLmrsTx9hXmajn/ZU8DEdMCD1TYJkqtW0Sa/PyBX0Ks7UpwOvXOY2Bhyhj6gxHEjISlhwaY9FfHI6sAj13uBUhRIW5xPdF2NwzLm3LdPnp7bXCS83LOK8IAnCj8diFAcX6zWoZcbzvbJ3si2wE8ZhDSqgwIQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112500; c=relaxed/simple;
	bh=Z1diV2rTo181tIlhC9pr1haEIBe/X5lz71ht5kB5Nko=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qOWvfZhlliwajmUGJKVgdJZ13ZPRt65T324HEIpWinjkb8DE4/WH1PxfaqR+j7q1iipw6bhA4bQODEJydZdjiJQiJX9lrG4UAYE6rytW0HK8KxjLGBTxXM5KKPXK7feubjFKv4kVhdJuOT6vx9D9fA1f1+1t3VDkOXYmElDJYNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mm5Nm7qH; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524CSB7P006711;
	Tue, 4 Mar 2025 18:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Z1diV2rTo181tIlhC9pr1haEIBe/X5lz71ht5kB5Nko=; b=mm5Nm7qH
	I+C8nssXmcN+XkqXYfHP3Cd/cPF/fy/n8Zdrj499gJGwaRuACJ/nTL/z3PQltVOp
	wQoftkZBNvQIDkKoLzaCtnCR+/kRYHdn3yIhabKdI5z30wgQfcOw/m2d7sgLfVZZ
	yOqQk+ICluRr8Kql50hYGAqbhipbXLTSmRRCNWxSQTWBVP/D9AOYVBGDM1/cG+0C
	shBJH7D6yUqiusdgpPZ/TibyUxWiLWSgyKTwBabXjq40ailQjYUzRMzTLjTiQYSW
	yq/n0h9ZHc0FFoXuOGFbVuArbT13kH3K7La3HuEgM7MhjlrO8CNud0DqUjTdGqAG
	oxoG4lv9EoOCeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j31s9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 18:21:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 524IJTPs014553;
	Tue, 4 Mar 2025 18:21:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j31s9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 18:21:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOYQW3Ip3P3tTn4sgrl/vi9CtNUPRog8FTij356Mw0LEaYJbvBwEV1JHPA82/ZSvLYq43mJV0wTTcVovrsShh6RjEvtO2VRjWTIfO18vOYwQvEp57/ZTGhxg5j58sIMwjcoNfdx6HAJAkiBY9bvARPQClVp0wU43cxQY9nHzlNwxenYfPod94D73f7+yAdayvmLZnUhf6Gc4sy7RpK5FOYGI1MIBoj8EDOApsdQORRB3hrDJc/ponXJ8qjv/K+13us8U2tWXNxsJmfjZpiaWx3UeJLjh1DjARDcLrPM2qFRgx02qo+ZZBtI3pnLyzhQfwdVTdKwKXaUbTL1TWZrohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1diV2rTo181tIlhC9pr1haEIBe/X5lz71ht5kB5Nko=;
 b=g9ADsuP8K4WOt7CANAFxbU03/NsT33q3K5BXMcv5DwXicuTXhhkZHbq7HesL3sQ06TWGLqmuosm9uAqsv/g/76hjw9Q9J6+OY9g6IIQDxmmYg87DtvT6kx5e6Zjfj6MJzuuxAFilkoqLBvdYoFDPmFh459arn5WIIJhya4rnHOrKmbqy8bsBng+JBIW5IvLiQol4tBDNoucUUVYqtIPep6aVjnpiMfX8TCIKfyW+zG7muUdXoFrUpW/4P70uZBcmw+fTb7cV5kqIn5/+NZIFbtfECYabRP6+buVJQv6oI/ZdRJxBAGy+8BRTVf92Ml2UVSZYef5qcouC24b8SO8SJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4607.namprd15.prod.outlook.com (2603:10b6:510:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 18:21:30 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 18:21:30 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        David Howells
	<dhowells@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Patrick Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
Thread-Index: AQHbjONroLyY6ltA9k6hReQldORXA7NjSriA
Date: Tue, 4 Mar 2025 18:21:29 +0000
Message-ID: <18c0b9b9a4df7b9b25a83b9e6e69908be75027ea.camel@ibm.com>
References: <20250303203137.42636-1-slava@dubeyko.com>
	 <3896161.1741078617@warthog.procyon.org.uk>
In-Reply-To: <3896161.1741078617@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4607:EE_
x-ms-office365-filtering-correlation-id: 1fe1b3f9-3625-4f54-76c6-08dd5b496279
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3pxTlRBUXlZUlUwalV2bWhvdUlrcHJzOWREbVVQNDh4TXBad1M2TjAzc1Zm?=
 =?utf-8?B?cjM0SHYwRWdKUFhkVTFmdEFxNlg3ZDFzSXJFendjV20yYW1NOVZsMk1pYzFv?=
 =?utf-8?B?UHBjN0xLNnV2SUVEeHJYS3JrY3ZaclBvVTBKK2J2M24valNwcGx3bUVBZ0Fh?=
 =?utf-8?B?cURSOXVYbFVIZmV5OHRrYWx0U0pNK2VEZVNtaFhmRmJPcXpyYm5udjhFSWx5?=
 =?utf-8?B?RDhSdmRBNlRoQldNTUZoUWhFQkpzZWVRMkZlL0kwb25xc2xMRG9BSDRwUzU3?=
 =?utf-8?B?U29vamRpcVkvSWJOUE1xUEpOcVNDajRxOXhrUnBzbkVwVGdSTDVIRUhWekt0?=
 =?utf-8?B?ZHZRcXRDT1doM3UwWnEwWUFMY0JQRHhUKzhLUVBIbmFub1BMOVdpdzR6VXBh?=
 =?utf-8?B?d0lFZkVva3BBc0tUYXpSWUpUNmRQbWdaZFdQaVVUUWdGMWVBRkV4UHd1Zjd3?=
 =?utf-8?B?TEM5dTdrb08yNUZNbVdGUkswNVdxdjhrdG84bE0wME5wdFNhQmdmMnoxRHpQ?=
 =?utf-8?B?V3lCSTVRaVVVMlpWWXFwU3R1cmk0THdsd2NjV1RWZjcwRnlHOW9WNTZRWkhU?=
 =?utf-8?B?ZkZ2U2RoS1NEM3pOdDNhVk9vTkVOM3c0bkh0a1pCUnBLeU5ObCtPV1FHOWJE?=
 =?utf-8?B?cUFYTVdTdjZZTzIxVmxCMlNuaFV0OUd4OVRocllSSmpJZlNZNllaRldmRmhD?=
 =?utf-8?B?aG1NbGdjbjBHSGRqa04yMjhWeFlHbmtOZUM5ak1OVFp1QXZRU003QytjVk9T?=
 =?utf-8?B?YUZuT1BQK0ZDZ0NUOXk5ZFpyQTZHQlZ1czZrZlpFRDREQVk2U2NhTTBwUmsx?=
 =?utf-8?B?U0lyZnF5dFkxTUZtcGdVb2NXRW4vdk83OUh1WnpZTmNkZG91aUtLN2QvRmkx?=
 =?utf-8?B?dDQ4MnBFSmJlUTZ3MndCMWF2QzBXcmVZdXJGM0lmdjBNS3l2b2crQ05kZDVa?=
 =?utf-8?B?MGxQVkF5KytsbjEvbEFCQzJtb3VFSWRGZDRmKzYzRGN0NXBUeHFQL0lvMGxn?=
 =?utf-8?B?alZEamc0Tkd3SUJUNWdqc2ZBSUNnTFM5U08zM0t5YnBzRFJJTmF2TUVnN0JG?=
 =?utf-8?B?bkFiZlMxdEhQZ3gxZ21id3U5c2JWNWJia2xmOTBKUjNHRzBCbDNEYXQ0K1lI?=
 =?utf-8?B?b1ZSU0lPdDV5QjV4WmZ4bVRKdjlxcmlESkJ3WnhvRkF5cTkzRkVubEcvNWpV?=
 =?utf-8?B?d0FhblZPRXZiV2RBT1h1U2lLZHZxL3R3dndxS3ZDalNOTnRpZWt0aEdwSk5v?=
 =?utf-8?B?ZmNMSEQ1MldscXk3REdxb2c1YTBreGxBcFBwelcxdEtTY0FHaTFwZHRSUm5M?=
 =?utf-8?B?UzBCWFJFUC8vWC9oL1NJcjFGc0w3bzNTWm9HOVVma21hZWRlMFozNGJnT3p0?=
 =?utf-8?B?THRkYzdyZitxbGt5YnJPZllmeENRTHFMMVNIZ1FuNXJHUVRHd1k4anZRREtl?=
 =?utf-8?B?d1BTdG8vUlNXU3NVcjZSU3U0VVNCSmZiQnlGSElXQ3BiZk9lY0w2UzQrdWpi?=
 =?utf-8?B?TVJxTHlaa1NtK0pBVElUWEEyYk9XSUpkUVlzT1FZKzRiQjJjdFdMbGYya2N3?=
 =?utf-8?B?cVdSaVJDeXRuSmNzOVV4azNXa3pRMU5Wb3NtNkI3R1BoNG9XSm9mT1o3cytC?=
 =?utf-8?B?TVBPa3dsc0kvUDg5ZlhmM3IxdGQzQURpK2tyTFRyVEtmZFpaSUVVWk9mQmli?=
 =?utf-8?B?c2c1SnFyenZJQTl3YU1Gcm1kMmJOYWNMN1IvREE0elNiQjFsU3ZiaHRFdDIv?=
 =?utf-8?B?R3Q3V200TE80Uk5NdjNOSXhCTEhWWVJSa1ZsNUljdFBHOFQ3RTY1TGVKRStv?=
 =?utf-8?B?Y0t1cFp6eExJd0Q3SGpQL1ZXODJycDlRRjFxV25jOVNOOGI4Q2Y0SUZaYk0x?=
 =?utf-8?B?QjE2RXBBcDhWYUdaUnN3V01LNDZqeDd3aFpsM3hwdDBBVXQydUxtNUJzZXZq?=
 =?utf-8?Q?mtcJrIwGP9PvlAmFZGbGPSyGlq7xrCzN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z096WUxLaTcxQytQeWpzT0pQS2RZaEZjVlJJRVVBUGppRktaSERUVnFEY3l4?=
 =?utf-8?B?UE81S3FxRm1EWEpIeDN5cVJ5Z0xMd3NabjNXNTY5VWJYdTk0RnRBWjl3Kzhn?=
 =?utf-8?B?ZWZxUjVNd25tNGh1Z0IzSUZ4TDRBZ1ZjOC9TdzR4WHdZVytBZnppS01za3BZ?=
 =?utf-8?B?WHpPc2s4Z1c3WllEVXpJTXNTSVk3SjZ2VldiVWhBQmZpMk1ycDJQWFR2SVlQ?=
 =?utf-8?B?N3ZtMFVYaVlZVnlCa2tBWnRHeGE1WUlsbGZZeC8yUW9Tbk1FeFBYQW1wZjZy?=
 =?utf-8?B?N2t4b2I4WWhaUG55eFM2anNFQnFSNmJ6YkxSVWNoTzBIWU1SSTdrdDZzRWlj?=
 =?utf-8?B?UEk3cWxrRUZoU3BMQURkSHlMV2tZRUJxNXJFeWgrbTdMaGE2VFcxdy9wQ001?=
 =?utf-8?B?ZEJPdkl3ajc0UTM2MHhNZFkzMVNORW5wdG1ldmNoVlFlalZGK0g3SVR4OU0z?=
 =?utf-8?B?b2p4WWRKSXhlK0ZJMzI0RkZ2Q1p3dWVYcHhJT2d1N3dpQzVsQVhYV2tBczlu?=
 =?utf-8?B?amJEUjVMUGJrdTUzYWhQeVVWMVFIUERjbjJLbnA4MmhyeWRqOUdTV3c3KzJ3?=
 =?utf-8?B?KzVyQUQ5WCtjY0J6QWlPSlRnNXZ4cUUyS0ZFVC9qSFFRSWpuOUJ2Z2ZzQzls?=
 =?utf-8?B?ekZmMk1MVHFObXhVUUFIaC9CNi9BQTNwU3hmczE0bWFtS2lMc0lqRW5tY2Zp?=
 =?utf-8?B?UGlKZGVqT29NTVZEZC8vSjhQVkc1UDBJZk9Jd1VhOTVlZzk1N0QyRlNYcGpK?=
 =?utf-8?B?QlR3UnAwdHpUZmFCeU1jem5mYW9ERzJ0YnlGc3FhUlpSaGpYZThKeHNhVUZH?=
 =?utf-8?B?aFpjckNBZXVzV3ZrUEtEWlNBSzF3OHVNNEV6L294NG5heHpjdHF3Znl0NFNX?=
 =?utf-8?B?SG1uTDE5MGUydGxEL3VHQU5WOUZGOVA4YkljMjRDUVk1TU1xZHNNUWJpSlZl?=
 =?utf-8?B?eldrVjlhTGNKQW42azRBVkZlM0JReWN2Rkw3UUN5MDd1QXF4UTYyeTNwWUhW?=
 =?utf-8?B?MnpaeUMvdk4rMzdjL0MzU2ZDTVo2ZnlpblpldGdSaTE0SzFzMDVPNG9meExM?=
 =?utf-8?B?MnQ4cXZKUUFtZnZBejJLVVc2OEJJWUFBeUhpdnNHRXoxcUYyWFA5cDBuSzBY?=
 =?utf-8?B?UFo3b3RXRTVUNUFDSFlSNzhWTEVXeEtRUUhCblhzNmU3bFBvSTlxN3lsOEZx?=
 =?utf-8?B?M2RzOTM3dzZmR2RJS2lyTmkvcGF0bTdSRkJoOUlnUTBRZE9HM1hIclZxV1cy?=
 =?utf-8?B?UXNRQkFUTW9jQjcrMEJERitYOTl6MllvdmxFRm9QWEIrbGhxdkhqQ2p4ekw5?=
 =?utf-8?B?MW1HWjR4Mi9wTVNpY3Z0Uk12VHFKZDJmK2MwR2RRWGpBUENKcUNmaGJhNC9W?=
 =?utf-8?B?WlU3Y2w5cDRFelQrb01TS1pQdVJEZ0VZV0taeVRrSW5raHdCWGlSb2loZ3Fs?=
 =?utf-8?B?NGpSUHpZaFZ3NGdhQURCeHNmbEdwUkdSby84UWVIVTJIOThRbzNiWG5PaFl1?=
 =?utf-8?B?ajRqa0FqQnVnSVJSRTl3QlhsZm1zbkIxSjhLdTBzdGJjVjFOUEN1UDk5Q3dX?=
 =?utf-8?B?eXBxUHhUdzdkaVVsMXppbURlenFJL0M5MWZaTzdGTlBSelNYck15dDcxcEQ3?=
 =?utf-8?B?RGp4QjJ6a0JObGhNZHVkdldZZnJRSjFpZHRXZXVWUGJxbEJtZGpjRGZHSGpu?=
 =?utf-8?B?SDF2MkxEcnlteGd4VzZyQ0lsdWNhY1pXek5wLzh5NitMd2FaU2N0azZMczNB?=
 =?utf-8?B?MExTSG1ROXd2SXZieVhUK2JuRDR6Qjc2VU5vTkxUcDRTR2g4UWhQc1ZiOHg1?=
 =?utf-8?B?T2t2andTSEVrbzBPTDBPQlo1ODFrUldva0tZWnJvTWNXVEMzRTNUcWl2NXM4?=
 =?utf-8?B?Q3o0T3hUTlhPNERCaTZyMkhVWWJyK1FzWGdyTTkxaW9vZWU5bndOdFQzOEdV?=
 =?utf-8?B?d1F2OXNBZllkb2s3RUJvV2hObWlQNlQ0SXl3VHl0aktFVnB5VlpIdXZvU1lt?=
 =?utf-8?B?aHZ1bWJWRGRGcnlRc01QV0UvS1Q4N1lseHFLdktpSjlLdUE5NDlTZGx3bUE0?=
 =?utf-8?B?czQ1Wi8zamVBeHFENUhFL2lsUnNrckhoUDJyQlVDcWpBdnRCNFI3Mi9WVDl4?=
 =?utf-8?B?elZZZkRtaUIwQTZncEEwZUcvZnNzMFg5RjMwd2hKdTZaTUUwS3U5dTlyTHo4?=
 =?utf-8?Q?jcI2IIFDC8kexDRKhGYx/dQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF9338F95B87A64F9D9168CA5C544F34@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe1b3f9-3625-4f54-76c6-08dd5b496279
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 18:21:29.8776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJ0HI+LfuYwz2m/Tp1ZrhcCC1lOSkxWCkSJNCAafqZSS8+TQ5m0rpGDIfqlqZWROPxALEvJDfcV8npDMisHf3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4607
X-Proofpoint-GUID: TDvg8VVqzkkTa4n9ET6-IEgrAJaHc2PL
X-Proofpoint-ORIG-GUID: 2LpS_3ls9O02v3Ry8gUodvIlMdq4UH4A
Subject: RE: [PATCH v3] ceph: fix slab-use-after-free in have_mon_and_osd_map()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=648 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040144

T24gVHVlLCAyMDI1LTAzLTA0IGF0IDA4OjU2ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPiB3cm90ZToNCj4gDQo+ID4g
KwltdXRleF9sb2NrKCZtb25jLT5tdXRleCk7DQo+ID4gIAlrZnJlZShtb25jLT5tb25tYXApOw0K
PiA+ICsJbW9uYy0+bW9ubWFwID0gTlVMTDsNCj4gPiArCW11dGV4X3VubG9jaygmbW9uYy0+bXV0
ZXgpOw0KPiANCj4gSSB3b3VsZCBkbyB0aGUga2ZyZWUgYWZ0ZXIgdGhlIGxvY2tlZCByZWdpb246
DQo+IA0KPiAJbXV0ZXhfbG9jaygmbW9uYy0+bXV0ZXgpOw0KPiAJb2xkX21vbm1hcCA9IG1vbmMt
Pm1vbm1hcDsNCj4gCW1vbmMtPm1vbm1hcCA9IE5VTEw7DQo+IAltdXRleF91bmxvY2soJm1vbmMt
Pm11dGV4KTsNCj4gCWtmcmVlKG9sZF9tb25tYXApOw0KPiANCg0KTWFrZXMgc2Vuc2UgdG8gbWUu
IEkgbGlrZSB0aGlzIHdheS4gTGV0IG1lIHJld29yayB0aGUgcGF0Y2guDQoNClRoYW5rcywNClNs
YXZhLg0KDQoNCg==

