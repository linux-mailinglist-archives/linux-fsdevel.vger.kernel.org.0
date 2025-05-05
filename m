Return-Path: <linux-fsdevel+bounces-48143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C88AAA5D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 01:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D54468019
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 23:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5DE319A7D;
	Mon,  5 May 2025 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nR6z6BdC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25528DF07;
	Mon,  5 May 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484282; cv=fail; b=CTvCmd+fgjUm2jlf/NJMr67Hx/kD+Z6hOfHJCwJAHHlq4vKeuWQcI+r9t62R+dpfze+D/q4mNCTY2vcrIazCnZ8513MU6pJYcIDwz2RCxljZ4SQT46FTnLKGi5PyaAk3sMMtbb/hG9aBrFoEj4cIiY3wm8ACaBe/2q7WeTJN5bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484282; c=relaxed/simple;
	bh=pFk1G3gnDLS2Gc9M81GR2Wk50pGTxr41uU0k7oaHWaQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=n7vyo0gCQPAKmbDce519hpfSejyv3O8ea+PTH5cw90roI6Gw3VavhmSXE4xTjufQNQdZdOZbpzmIs0onfBhxNAjpFcfiTv4n24G+G/XTb3SGL87vYwCofPASWA7THuo8UEgLqzk4zXmsdPmDArDPnSxhbsWpNbg66TgI8jCdMGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nR6z6BdC; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545Ji6bY017269;
	Mon, 5 May 2025 22:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=pFk1G3gnDLS2Gc9M81GR2Wk50pGTxr41uU0k7oaHWaQ=; b=nR6z6BdC
	N84xAN9FOHj0l/RFanzBwXHPzDcZzp8cqMZxjkpQFNwrKRh+NrSZSirlaiim2eRv
	u53kc4hmoRJVSnEQXHYMsXGyKE0x6gHlFRrHnKiKFitMByzdyelbFOWrijXXcdBq
	p3KfJCTDXPeiUDzjCmH+HVKH4ryUUZ31PieXPXXBfq4GwYHrPUYGwJCrdYOxBcQK
	TRRTHPU+WpkZd/AJCp/uxStUse5izHFFG9MwuWzw57bKT47y1LjVP8h+N0lZDcT4
	fx/trKXlTf9GX8O/58Wnn5ICJDnB7HGjjjM/aA/yJ9HjRvJrpHh/B6b6+R0ammns
	aXKIMYZ8/RJwmg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46eu8jk9gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 22:31:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWTJGwX2P3aHAaSft1G21ans/11PjxGlkifN8Q2CnclMzvPpo89xyHP0vFpYr+AXh8HwDlO7xx7U0dSy1pKXch378lP1N2IeK6bzFbjujPZmmKlVinWtHPe7QPXrck+PeBLe5Ea7cx1kEKXLeJrtPyvRsQnZvWoQmx8JEU98wO7zognzYjDiANEZJD+tL+Wk5Hmrsvm2Ljg3/iop3sTKQsunvdQTnxTNn9WcB6bWi9X6O60HYurm57NRGZOcpL06WmbPJV0cwFyNNX560+E5UI87IXUdyHhJx9WAfeKcuXGTh4NbjfZsXFLS1NT50xDaOnIb6MiwjlXMsOoIRFluGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFk1G3gnDLS2Gc9M81GR2Wk50pGTxr41uU0k7oaHWaQ=;
 b=HByNhjz3ErZwPdrwNi4/PY7PvJeTra0K2ILKhBQdHjg4Eia3iHpSzOmerdr5paocBx8jS3jVBcMOxnvDHuy7ElAGxIl5SwXnyrUGmzLDJ7+AlfHz318C9BDWRV9a/iZ49cgJJUj8icQNMw8Sq2+Q4lGHHwW4gXEGeUeeX64Pm97PU3fp5Lbhm1FtotqjgcHaO9wEBCkX07wK59NSuiaeqWhhqNlDvtqLY8khHihW8m8LESFlVGXfSlZWnyzEqVlZ7wfs5+jjNPzg1qq1uabix48j16DoDWPVI1SQcFqXJ5TKakg9wk1gOAt2R4bg/LzORstTHM1H+BX4tej/Z2R70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6722.namprd15.prod.outlook.com (2603:10b6:208:51b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 22:31:11 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 22:31:11 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "tytso@mit.edu" <tytso@mit.edu>
CC: "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSBSZTog5Zue5aSNOiAgW1BBVENIIDEvMl0gaGZzcGx1czog?=
 =?utf-8?Q?fix_to_update_ctime_after_rename?=
Thread-Index: AQHbu2Elr/wMpKcY2EKgeFpmqpMQyrPEpAoA
Date: Mon, 5 May 2025 22:31:11 +0000
Message-ID: <a47f5e856b38dd817f0f11c1f04f5aedb269878e.camel@ibm.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
	 <d865b68eca9ac7455829e38665bda05d3d0790b0.camel@ibm.com>
	 <SEZPR06MB52696A013C6D7553634C4429E8822@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <b0181fae61173d3d463637c7f2b197a4befc4796.camel@ibm.com>
	 <082cd97a11ca1680249852e975f8c3e06b53c26c.camel@physik.fu-berlin.de>
	 <72b00e25d492fff6f457779a73ef8bc737467b39.camel@ibm.com>
	 <20250502125255.GA333135@mit.edu>
In-Reply-To: <20250502125255.GA333135@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6722:EE_
x-ms-office365-filtering-correlation-id: 4516c9a1-3842-489d-b8ff-08dd8c2489d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnlsZU9HRGpIVXFoTVFBY2ljVzNtTy9hbmpadGl3MUxhdk81OHB2eWtOclVV?=
 =?utf-8?B?djNqNWkwQURDdE9NdkkxbzBtWUJXdlZETlQxYmxXaU45enUvaGw0RXc1QkhJ?=
 =?utf-8?B?TjFSOHZ4UmJMTFJMd3ExcG1oQUFBNVZnazRxSHBPOG0yUllMRnh0NFJxci82?=
 =?utf-8?B?ZjdGU3hXS25IL1R6ZjRydVNmNURVTlUwb3VZcnpUSGRjWHRRaUFVOERmMmRn?=
 =?utf-8?B?alJKZVZvblVqVlpWU3FRT0NiVm92d0JGVG1nZzAxd2dQK1RkSnhOZ24rZWNW?=
 =?utf-8?B?MjlmQXVJS0RuQUFSS3hyR3RIOUR2UkZqaEYxbmQxN2k2cmR3TUJQRG9oYkwr?=
 =?utf-8?B?dVErWXJkbHFYeGRNSGxTSko1WE9zVjFZVUtqa0t5RzNhSWtESElyLzNzQVZU?=
 =?utf-8?B?QXZJNUVGdmVIS2p5N1dFUHp4M01qQVBFTGVJVGUyK0RVa2tEVHhyUTRLb3BY?=
 =?utf-8?B?SERYNVVKZ1VpdmZiQ09XTkkzeVZOeE9Fc25IK21yUCtwdVFKUmNiaFd0Sjg2?=
 =?utf-8?B?RXFCUGVGTzZsSHUwL05NKyszRUx5S3RVSVhFZXl1dVhyQlYvUmhoUDArYm5a?=
 =?utf-8?B?dk1OQWJyaWd4VHNFMVVGQVV1dzVCa2FMdDl0RDdBWlFvUVZsWWswRWRPU1VL?=
 =?utf-8?B?NFBzYk9WaUFsVk44Z21ReFdCVUIwR2syM3Z6bEJrZy9MVElsNkpWODFLaFhR?=
 =?utf-8?B?UkcvK3NxOUhyd1dBTmVGN2cwaEt4WUxnZWZDTW1HSzNiekxuOUh6UDhJOWJR?=
 =?utf-8?B?V1hUZ2orSVJEd2syUXQ1bkY4RXRacGVMQ01pUDREclpYQ2gwKzM2empzWVR4?=
 =?utf-8?B?b3FWUCs3ZjRER0tEUE1rdnI3UFh2SGJkeTYwVXJKM1UrWTNMdVdxRFpHQTZR?=
 =?utf-8?B?V29EUzZXQmxuVmJUdDlkaVdKYTUwOXBYNWdwNEFuMGw2RDRuS0NCUlB2QW0z?=
 =?utf-8?B?RjgrKzdaWTdReUxkMGZtdDRtb3k0VTJlOStCekt4MHArZ3E2NFd1bm1ZZElL?=
 =?utf-8?B?N2FsbVlvUld4V0Z5Zi8zNUlUVlJCNWxJSG52bjEzd3Bsdmo3cU5aMnpIRFNY?=
 =?utf-8?B?enM4Vm1qOXJ5eWlOZzU0cXd3OG8vYTdsRzlkSE5uYlFEUld1VmRHOU5BK0lB?=
 =?utf-8?B?TDZSU0VBQUM4RE5NNDZ4UGl4ZTk2a0MzT3dpVnNsbWs3cmx5TlVCb1BTRWV6?=
 =?utf-8?B?cUZBTm91bTg4TTN5K2x6cU5HckZ0VkRsdkdDaVA4Qm96LzBnSFhhK0hnR2pq?=
 =?utf-8?B?L0I5MlFFbDdvazNUZURuZVlCSncraTBRd1huajlFbXF3WmswcFF6eEpybEE1?=
 =?utf-8?B?Y0QxcHF1REYza09yaEdxZFF4b0hVVlRYZ2xWZlNjY05NU2VxYVdiUVdnWk9S?=
 =?utf-8?B?MWZ1K1VRKzlqRVBsS2dFUVRVOWFYRyt5VGpQdUt3bHphekpiWHFpaFdubkRQ?=
 =?utf-8?B?V2ZVT3dLc0x0OVk4UnFsNUhMUXJnVHhtaE1qcFNKeDFJejRNR0JmVmJoOUh2?=
 =?utf-8?B?bTNCSE5VUWNqelBGclJwNm1icjV5ejJGbjZqRXE5elF5bUNFNlltOU9IUzhy?=
 =?utf-8?B?TkU0Q28yb3FWQm5uZnFoRWdNTWhwMzJMTEExV09pUnd6R3YyQzVUTmp2N1hU?=
 =?utf-8?B?QjFvRkdjT3lxK0lpQ2tHbzhjWmNZUkkrTkVra0dBTzFUK2V5bm5DeEhKcmFF?=
 =?utf-8?B?WHZWYldRNnBnQVNwTER2bVhkZzJ3aWRTQVhuTjNEZ2lrMktSUHo1dkxtU01P?=
 =?utf-8?B?cUF3dEEwdUE2VnZ6dmt3VHNaY1RRL1l5cG9CQ3pZRGFRMVVOa0YrZmd5cWxM?=
 =?utf-8?B?dkIwc2RMYkFGYkhxakw2Q3A3Q0swQ2htdVgybHRKdjZuMkRPL0RjR20vYmNU?=
 =?utf-8?B?Z3h0UGRRaDNOOXg2NnBveWdRRnp1dTFNVUk0eDBXUnNQb1U4d2xmYVJmZzFV?=
 =?utf-8?Q?UbFcJBTXDHsFmQyzLoLyn21aoDDkHz3d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEUwTlNlNm9QeitPTkVEdzFmZEFzVEV6b3JIMDdWc2VEdW9JVmFtM2o3SnZX?=
 =?utf-8?B?eTQyemRIdGptTnBYQTZhUDZOeEZCdWNvdkI4emFKSXV6K3diYnYwUk1nZ2h0?=
 =?utf-8?B?NVZyMnR5L3laVjRsTXBxcTZjMlBWeXE4WGFHMVlsOG1PQUtTTlUySUJmbWk1?=
 =?utf-8?B?T3N6R3U0aGQ4VG5nc255M0RYYmwvTzRES08zZ0tuMjNLWFJ0M1ZFZURXVlF6?=
 =?utf-8?B?T25YSUpqQ0FtY0xsdVkrSHlhUkN4ZmJKbjZCM0FrZk15ZzR3MHpCdEZVUjZP?=
 =?utf-8?B?bGtxbDgvc3VQN1lWODBVTFp4d3UvV3RaNU0yUlg1MXpYSHFyRjZ6b2xWMGp2?=
 =?utf-8?B?SlB0aUlVNythekVuNHhIcnM4MXAvVzUzMVhPQ2Z3V0ZQcW1GUzkzWGlYcmx2?=
 =?utf-8?B?ZkxWdm8wckFpOUtOUUpMVCtkSFZqVkRLZXlzZjBYajRqbjdGZ3lJNjR1eU1n?=
 =?utf-8?B?UUlwTWpvV1hRNlk1a1gzQ2VtajV4ems4NTJ4YytVU0s1ajd5NmY3WHAycGtx?=
 =?utf-8?B?d2wyNHVhcVkrVFRGY1lyVkYzQTZiMXhPSEZOT2wrVG1xeVlXbklIb09YVEla?=
 =?utf-8?B?QlpTMkhZT0pLZHlCbEE1RnJ1OGszWU94OWszVWhqNTFDVnZjZG5rdmF5NTZI?=
 =?utf-8?B?WkdhWDdTT3ZnT0RTUmNETHZCL0Ixajk4UW1jVUZCcWZoYm95T1JWN2NVM3Bo?=
 =?utf-8?B?L2Fza2hFYXlDUXZRM2lFV3VzbTdaT3o0NGU4YlRzUklPb0NnQzQ3SGZSbjRJ?=
 =?utf-8?B?V2tGWHJNWWRGTDh1YnYydVNGamljdllsb3ZMRGJmdzUyY04xVWVET05rZkY2?=
 =?utf-8?B?WTNUZ2lYamxzOHNyMU10UFdvZ2ErQjZjb256aGpjNTFIeEJyYk5JQTBOL2R2?=
 =?utf-8?B?dGNZV2hJSlhRQ2NCV0tNdlZPTWJVSFEzZUtMYi9MRk5NNUhVcTBzQW4ybitt?=
 =?utf-8?B?RFo0SmNxTTN1TmlQYUxJclVsTXFjN0ppTUVacnUzbkdET0tQRDNybDdvelpS?=
 =?utf-8?B?d3dDMXhGVEJWeURWSXhYMmZ3dTFWbzNzWVpmbkpCWk5KWHVKMnNXcnkxRkc1?=
 =?utf-8?B?cGRyQUdZdTN2RU0rOWQwZWcyUjgvbHYxazlKQnRkWno4dzUvVTlUSHBYVUha?=
 =?utf-8?B?R3VWNFlTQXZOUDdFaHdmOWhwaUp5RGF0VFR5dEtMUUZ2NUpCSVcwMkI4YTRj?=
 =?utf-8?B?bjBmNWJlRXBleENqNGN4b2NHOEdlSzVWcmNIZW5sdS81SGJYb0pHTnJOYlAr?=
 =?utf-8?B?MWhBd1lUQU9CZ2pib3hLTzdZODRGVVpkZ2tZOUt3cGo2UjlCcE5KSHBPQ0Va?=
 =?utf-8?B?Qi9nOHNkcmZsRHFFUWxWOXIybVdmZmNoQWppQmErZ2xuZjdYZUFDdGFKelFU?=
 =?utf-8?B?YUtQNWUxa2lhY2kvVDJNS0xDQndoYlpSL3FWUyt0WklnUTlhdUlZUVdDbzVX?=
 =?utf-8?B?UDAyOW5mMUlybDBZMGNJZW1UdCsyblhxSExqNWRFeHR4VXovWXdiaDJhUDVM?=
 =?utf-8?B?S25CSGFRcUxsOHdvRCtiSE1iRDAxQnN6MHBZZG9LaXNybnN2RGlBOGFkWkVm?=
 =?utf-8?B?RW1tNUcrdDZ4REw1REJyWDNid1YxQ0VNYmREamxYZnJId001NTRWbklBSC9i?=
 =?utf-8?B?VitVYjZtT01HZjkvcXRpVVZxV2VXNkNReExKbjM1c0VBbkdVSkM0NXJ3SGpZ?=
 =?utf-8?B?V0ZOTmgrdFBPYU9lbXU1QS8vZzBoNzlBNklNbUpHdnUwUFhraGRML3VlVHRM?=
 =?utf-8?B?eWVJWjl2bm5UL3ExaHQ4bHdseTFVSTU0NlRxMU1oSk1ka2dxQ3FaeG5ISTBl?=
 =?utf-8?B?ZjRKcDJsNnVQYkp5WGlleGpDUTA4QXNpOFR4UXBGTmd6RUY0dVEyQURyTTk1?=
 =?utf-8?B?YTh4eFhPUHIzeTVIbmNCYlpqR1NseG1YbXBqcTlkR0RFSFlBWHg0MnVDUEhB?=
 =?utf-8?B?dXl2ZE9uNDViR0NXRjUzSGhYTkppejVZL1VzL2RmalFlTHcwS0E1OHdBUkZm?=
 =?utf-8?B?eWJMZmRqamNWV1RhVWJ0S1g3NE5oeVBOTWRZek02WDRRbStiUEVCMk1IdDhX?=
 =?utf-8?B?aTl6NHV6OXhFTDEyNmVTODVYcWl0a1RyTklmRzVTVTZTaHl4RG5pQS8xV0Nu?=
 =?utf-8?B?NlRpTU1Rak91VXphU0hlRUppWFJZRE5EcWpZTnNUZGRURmtUVHN0UGJwNDdr?=
 =?utf-8?Q?7v7KEOioS9tvGkxsZK74e4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E83A6FD28C3D4498BF77A936D5E24F5@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4516c9a1-3842-489d-b8ff-08dd8c2489d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 22:31:11.5572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOEZHPOAcpBgiTvjycujtV1uXMTz5QwgNlFjJUMZW71l8lvHY6XnJDac/5Qwafd85hvwbbATOaPtljLFgO5HUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6722
X-Proofpoint-GUID: O2dCTev3m__PvVNuxewcgOSXBC4OguC4
X-Authority-Analysis: v=2.4 cv=DcMXqutW c=1 sm=1 tr=0 ts=68193c32 cx=c_pps a=smr7v+wKk2SgYJk0SwJNKg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=7kEikVcRrmiNxC5frgYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: O2dCTev3m__PvVNuxewcgOSXBC4OguC4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDIwOCBTYWx0ZWRfX1rk4ex43k6c4 0m2ZoFDEMT/QBlHgGpeAoNqgQ2oCxPFWL9rwLtMV3pKv7+whz1+fmyjY1t3JUoBUyB1Jqqbndvk 1CK/cpUt3nKcpPmx+kcuU64heQuMkMsmw1siHwp2iTeixpMjRSK6ibQABHHRDkOzZVLWA69Y2Gh
 fDaxElga03oiVUT02pB+qmfZXxX2xUcxmGec1BN7KE/MoT3LPKxiER+FCzmAevMkQEaQSn5EROm ThQuOCwBFu8o3lJJUCRo5BCB+77jx4gl2y4AFC1Ffdr+OrcloLYBOKB1bvcQU92iQwSGlmfQ7RS 3MA//i59hsXGmyzbEQAyjdgpNwOuXkiP3kzPj4HxfaD84kdYq+KoLdyhzVPjlL8q4cwB9oyPtqu
 obw5xmMBsJrNFOLzLXYWVoq9JCd3/jeiNEdow7oqhxIp3sL8Y/AlZk8bgJ2LLB4A5rEIorXo
Subject: =?UTF-8?Q?RE:_=E5=9B=9E=E5=A4=8D:__[PATCH_1/2]_hfsplus:_fix_to_update_cti?=
 =?UTF-8?Q?me_after_rename?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_09,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050208

T24gRnJpLCAyMDI1LTA1LTAyIGF0IDA4OjUyIC0wNDAwLCBUaGVvZG9yZSBUcydvIHdyb3RlOg0K
PiBPbiBUaHUsIE1heSAwMSwgMjAyNSBhdCAwNzo0ODozNVBNICswMDAwLCBWaWFjaGVzbGF2IER1
YmV5a28gd3JvdGU6DQo+ID4gPiANCg0KPHNraXBwZWQ+DQoNCj4gDQo+ID4gPiBCdHcsIGNhbiB5
b3UgcHVzaCB5b3VyIHRyZWUgc29tZXdoZXJlIHVudGlsIHlvdSd2ZSBnb3QgeW91cg0KPiA+ID4g
a2VybmVsLm9yZyBhY2NvdW50Pw0KPiA+IA0KPiA+IERvIHdlIHJlYWxseSBuZWVkIHRvIGNyZWF0
ZSBzb21lIHRlbXBvcmFyeSB0cmVlPyBJIGhhdmUgYSBmb3JrIG9mDQo+ID4ga2VybmVsIHRyZWUg
b24gZ2l0aHViIHdoZXJlIEkgYW0gbWFuYWdpbmcgU1NERlMgc291cmNlIGNvZGUuIEJ1dCBJDQo+
ID4gYW0gbm90IHN1cmUgdGhhdCBJIGNhbiBjcmVhdGUgYW5vdGhlciBmb3JrIG9mIGtlcm5lbCB0
cmVlIG9uIGdpdGh1Yi4NCj4gDQo+IElmIHlvdSBoYXZlIGEgZm9yayBvZiB0aGUga2VybmVsIHRy
ZWUsIHN1cmUsIHlvdSBjYW4ganVzdCB1c2UgdGhhdCBhbmQNCj4gdGVsbCBmb2xrcyB3aGF0IGJy
YW5jaCB0aGV5IHNob3VsZCBsb29rIGF0Lg0KPiANCj4gR2l0aHViIHNob3VsZCBiZSBqdXN0IGZp
bmUgY3JlYXRpbmcgYW5vdGhlciBmb3JrIG9mIHRoZSBrZXJuZWwgdHJlZSwNCj4gaG93ZXZlci4g
IE9uZSBhZHZhbnRhZ2Ugb2YgaGF2aW5nIHNlcGFyYXRlIGZvcmtzIGlzIHRoYXQgb25jZSB5b3Ug
c2V0DQo+IHVwIHRoZSBrZXJuZWwub3JnIHRyZWUgZnJvbSB5b3VyIGxvY2FsIGdpdCB0cmVlLCBp
dCBiZWNvbWVzIGVhc2llciB0bw0KPiB1cGRhdGUgbXVsdGlwbGUgdHJlZXMgdmlhIHNlcGFyYXRl
IGdpdCB0cmVlcy4gIFNvIGZvciBleGFtcGxlLCB3aGVuIEkNCj4gcHVzaCBvdXQgY2hhbmdlcywg
SSBtaWdodCBkbw0KPiANCj4gZ2l0IHB1c2ggcmEgICAgICMgcmEua2VybmVsLm9yZyBpcyBhIENO
QU1FIGZvciBnaXRvbGl0ZS5rZXJuZWwub3JnDQo+ICAgICAgICAgICAgICAgICAjIGFuZCBpcyBl
YXNpZXIgdG8gdHlwZS4gICA6LSkNCj4gZ2l0IHB1c2ggZ2l0aHViDQo+IA0KPiAuLi4gYW5kIHRo
aXMgd2lsbCB1cGRhdGUgbXkgdHJlZXMgb24ga2VybmVsLm9yZyBhbmQgZ2l0aHViDQo+IGF1dG9t
YXRpY2FsbHksIGFpbmNlIEkgaGF2ZSBpbiBteSAuZ2l0L2NvbmZpZyBmaWxlOg0KPiANCj4gW3Jl
bW90ZSAicmEiXQ0KPiAJdXJsID0gc3NoOi8vZ2l0b2xpdGVAcmEua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdHl0c28vZXh0NC5naXQNCj4gCWZldGNoID0gK3JlZnMvaGVhZHMv
KjpyZWZzL3JlbW90ZXMvZXh0NC8qDQo+IAlwdXNoID0gK21hc3RlcjptYXN0ZXINCj4gCXB1c2gg
PSArb3JpZ2luOm9yaWdpbg0KPiAJcHVzaCA9ICtmaXhlczpmaXhlcw0KPiAJcHVzaCA9ICtkZXY6
ZGV2DQo+IAlwdXNoID0gK3Rlc3Q6dGVzdA0KPiANCj4gW3JlbW90ZSAiZ2l0aHViIl0NCj4gCXVy
bCA9IGdpdEBnaXRodWIuY29tOnR5dHNvL2V4dDQuZ2l0DQo+IAlmZXRjaCA9ICtyZWZzL2hlYWRz
Lyo6cmVmcy9yZW1vdGVzL2dpdGh1Yi8qDQo+IAlwdXNoID0gK21hc3RlcjptYXN0ZXINCj4gCXB1
c2ggPSArb3JpZ2luOm9yaWdpbg0KPiAJcHVzaCA9ICtmaXhlczpmaXhlcw0KPiAJcHVzaCA9ICtk
ZXY6ZGV2DQo+IAlwdXNoID0gK3Rlc3Q6dGVzdA0KPiANCg0KTWFrZXMgc2Vuc2UhIFRoYW5rIHlv
dSBmb3Igc2hhcmluZyB0aGVzZSBkZXRhaWxzLiA6KQ0KDQpBZHJpYW4sIFlhbmd0YW8sDQoNCkkn
dmUgY3JlYXRlZCBhIGhmcy1saW51eC1rZXJuZWwgb3JnYW5pemF0aW9uIFsxXSBvbiBHaXRIdWIg
YW5kIEkndmUgc2VudA0KaW52aXRhdGlvbiB0byBib3RoIG9mIHlvdS4gSSd2ZSBtYWRlIHRoZSBr
ZXJuZWwgdHJlZSBmb3JrIFsyXSBhbmQgSSd2ZSBzdGFydGVkDQpvZiBjb2xsZWN0aW5nIHRoZSBr
bm93biBIRlMvSEZTKyBpc3N1ZXMgWzNdLiBTbywgd2UgY2FuIHRha2UgYW5kIGFzc2lnbiB0aGUN
Cmlzc3VlKHMpIHRoZXJlLiBBbHNvLCB3ZSBjb3VsZCBoYXZlIGEgV2lLaSB0aGVyZSB0b28gWzRd
Lg0KDQpTbywgd2UgYXJlIHByZXBhcmluZyB0aGUgZW52aXJvbm1lbnQgc3RlcCBieSBzdGVwLiA6
KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9oZnMtbGludXgt
a2VybmVsDQpbMl0gaHR0cHM6Ly9naXRodWIuY29tL2hmcy1saW51eC1rZXJuZWwvaGZzLWxpbnV4
LWtlcm5lbA0KWzNdIGh0dHBzOi8vZ2l0aHViLmNvbS9oZnMtbGludXgta2VybmVsL2hmcy1saW51
eC1rZXJuZWwvaXNzdWVzLw0KWzRdIGh0dHBzOi8vZ2l0aHViLmNvbS9oZnMtbGludXgta2VybmVs
L2hmcy1saW51eC1rZXJuZWwvd2lraQ0KDQo=

