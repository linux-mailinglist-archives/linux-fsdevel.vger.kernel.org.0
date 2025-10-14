Return-Path: <linux-fsdevel+bounces-64158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E01BDB0F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78C554E854C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496CC2C15A8;
	Tue, 14 Oct 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cYLEQqw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D672BDC17
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470155; cv=fail; b=uguLXLOwOihRJExpyySpp9oAhp8jqX/nyH40JcDAyTx1RYc50RQjY6MBZXShCsIAArraXG5MCJa0qT4cM2mdA7eG2jhKpV4OWTdK5MLNxSGXhbvynhddW4OyVC6jDNJUBTjyQZs/+2UbKg1HzVbK1Fu/NVEyA3uWD/fFCCF4gVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470155; c=relaxed/simple;
	bh=P/jTIH0sr9m0C5pyZZXGReUOM5oVZkiLGnUuAGVVc7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJpmp7GFAwwNpTcLr4YpDqyebNumvCPYZCDl2dIvLTUBQCW2YWHLsuukrwBH9XyDJMFSu05mFKpByguJZM3fBHl69kUNekpEreU7GQ2p7ksVJVi/Gc2gdMS6oqIY1jdVrNIleJxAhTA1iThWja3s7LaYHVL2KjCAHGL68ubE/a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cYLEQqw+; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfSxLQpDqdw9ZYQB9aGr863v+H70NWcQL0846qhVdyw8+Ru86K6GhrL5X2+iSTQHTkbvW8mgZbyrjALs/+c0nAmDnykVriqPT5X/F0shf/QBgfrWdsc8Bl/XxrCYjT3CvBgJrJVhvacEX+Nx1jAE03jpscM9csJrltvHk01xH5meJdPZEpEYyY1I9AceppkrcSEGCPsdh/2n+nn9LxU6SmzG4nIFy/BQgtN8O4T1FS/8eR77YbsBlDBztw8F+DsA8wHF0kH8idwB5xzX/CNI9WmdnF2RWpiEe4sWx+NGYDokbJl41vWk3diN/JfyRoJl0HuxJJ1JJyBNlbXGh7/NXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShkLcclEf9UZZs9Ce6egyfu1kMXyywxiD7Vl4321/bc=;
 b=rz64DtVHxzp9x+I1MM45HVBnzt8oVBPM80QcIwILoOQSVi16i6/9D1EJ8XIpVk75HYFB+m9VstFocs4NmgbFbqtqOxF0OMUJ1gg6g1rHf0ZVl8GFWJjjWIyooIrZ7kfkq++29dikBUE8nnjqe5EXEiTEbJ7aiT2rZ0yfmm6zqCpdYfcH6J0z5kEj5t1FV/A3aAtax8BAGBYkz+VKscZBbSGHfhzeNLjMmGHg8vx7cogaplN/ZVnfOxRbYZ1ZnyAYNt4+4KD27Zi/+yLu0D1ohuRMF/XK17p6VPyqc9ImdfCIm1EWx2U/AFhkwiPeT5CAGx7348Z5DewRAq3jSHrE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShkLcclEf9UZZs9Ce6egyfu1kMXyywxiD7Vl4321/bc=;
 b=cYLEQqw+gBuflGUTylv2IIEQtDzDFGFrkc7eS0B/BTIpTmCFQcTCRKG6Xp2IUWdLP9XEw8e3aUNGRavzBVdoS+v7lDVqEh1bDizFu2W5dqe4HiJ0IrQveerisDx3YOzkzqwjjMnH1V6kwmfYUU/EgC+Ae7Xv34dcnIL1ueAT2qWbBikN6qOLViMQrHkOtHwIKebeXpMjTdOM3E8EL3uFPWvc9jbQd/USh57Nc98dI8hqpCoEMraRE6AtOhY2KQkXZrrkyAk57vKZD6mSctiHn9C8DV7IsndMfGTBTqJ8dmhSwROuXGgpYGnknIvq+8ohp97UirYoRTmEgDR/Q2mx5A==
Received: from BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 by LV8PR12MB9691.namprd12.prod.outlook.com (2603:10b6:408:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 19:29:09 +0000
Received: from BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb]) by BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:29:07 +0000
From: Jim Harris <jiharris@nvidia.com>
To: Miklos Szeredi <mszeredi@redhat.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] fuse: add prune notification
Thread-Topic: [PATCH 4/4] fuse: add prune notification
Thread-Index: AQHcHBe8NaGypsm8bUq3QBN7h6whwbSDh5sAgCkeVwA=
Date: Tue, 14 Oct 2025 19:29:07 +0000
Message-ID: <0BA8FCE6-FAAD-4F10-80D6-D33D378EEFD0@nvidia.com>
References: <20250902144148.716383-1-mszeredi@redhat.com>
 <20250902144148.716383-4-mszeredi@redhat.com>
 <C28127D1-D1AC-4F85-AB84-E77A50C39FE2@nvidia.com>
In-Reply-To: <C28127D1-D1AC-4F85-AB84-E77A50C39FE2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5094:EE_|LV8PR12MB9691:EE_
x-ms-office365-filtering-correlation-id: d07f9183-0040-4ed9-a305-08de0b57f1a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nkh5MXZsZkQ2UzhHVmRFeitNclh6VHEvdW1ybHJ3MXBXdlpWVWhaKzVZbk9B?=
 =?utf-8?B?Slp2TVVGVGNNTDQzWVZzd0NxcUQ4ODBSbWEzay9mTEx6K3BIdVpoOUpmdCt6?=
 =?utf-8?B?M1BGMGZ6V3VJZWhoTFdrMDJrbzZMSzhNZUEvLzZ4SkFjZnNRRmhlYnVSTURD?=
 =?utf-8?B?QlJmWW50SXNjV3ozWHJNbk9SRm9kcjk3RTJDb2wrd2d6bEVLdExMZDFWQ3ZS?=
 =?utf-8?B?RVpiM2NXUldGTFAwNDJqUXdIbFExRXBSbzEzU1U4MEpvSnB2QitkZjYyZkhq?=
 =?utf-8?B?WENZQm16ZFUya3NpMnFLQitra0NsNllGQTRCZVcxR1NyNzRRTjNnK2l6WS80?=
 =?utf-8?B?ZU90UUFwQUVkZHdhN3I5UnJkV0F3YUNYdkhhV0lhcWJYa3J2enhTRC93Uldh?=
 =?utf-8?B?QVhra2ZNN3Rxb0c4dTFYUUFFRFVyeVdBQjJyVG01UTFFK2JINlRlWkZLN3k5?=
 =?utf-8?B?V251anZBTnJmQ21VYkVMMnVuMlZpaE5remx1MEZiVTFkeHpQbWN0QkdCbjhr?=
 =?utf-8?B?MGtsTGZPYXIwRXBweTJiaW5IbjlQeTBxZ2hOZkRFUmZMeGs2dEdGUUlwWWpU?=
 =?utf-8?B?c0dleXEyS2U5UDc2RGpnU3dSNytmSVpQNWFTb3dKc04vUjk0c0x2bDAzZzAy?=
 =?utf-8?B?cHlka0l1NW1mYllwaEdYaHVaeUt6dEJMY1QzK25XSmx5UTlOZ3JmUDNQY2Fk?=
 =?utf-8?B?ZXVCU2VkcUsvZmppOHZWNzcraFliZiswaHRmdlJUbUtQblFZaUVuV2QzdmQr?=
 =?utf-8?B?SFByaXpTSkVtYjlCQ1N1M3pmd0krVUdqaDFGTnh5UEtYeTcxb3lRdXhDN2x6?=
 =?utf-8?B?VWN6R2hscUtpSmxZeEc2T2p6OUJxbHZLT1hvcStwdEpXcGhSN25CMHlCTE0r?=
 =?utf-8?B?TEdHOWRzOWlMTzdJdWJ6emdzVmxhNUVQR0lxZzU4NFVkVW9mYlBiVW1NZ3Bt?=
 =?utf-8?B?enQ3SXBaa01FYjBBazVFeGU1VDZwRjR5UHFvL3d1Z3I2T1U1Y24rYXdmaUl0?=
 =?utf-8?B?RDZpeUl6OE9rc0ZYSlphTXpNaGhCUkZyTUZZb2dObEJpdWFUVnJ2SVc1Vm9L?=
 =?utf-8?B?S2tCSExSN2Y1NmlEWncrS29sa1JrWDdwMk1XbzQyWUhBUnpVK3ZZU3phWUt0?=
 =?utf-8?B?dVplNG85USsyZzVrL3hwRU42NHBwRUFPQnc2Y0FiSTFuM3F0R0E1ZkxISDZS?=
 =?utf-8?B?K3RPVHlXa0FkTkhwNnltNlVKRnZLTTRsbnVaTUp5ZFRnVUJEeHFhdnVHTlFQ?=
 =?utf-8?B?Zit4LzZvOHE5dGNsanhpOWgzSkFGbUI3alhFVW1ReVRGVk85NEpRUG51allx?=
 =?utf-8?B?SzhEZlR3aDBaejZKKzZ1Um1TU2xwVUdVSTRvOGIybEtJNFBuc0M3TExXZjlK?=
 =?utf-8?B?dUw5MFdtaXZFVC82Z2ovakZxRmJzQ2lZL2J0dktxNXBwMzBib1dWREtZdXgy?=
 =?utf-8?B?cHVVdGtzRlByQXNjcjY3bUtDWnoxWWFzaXVhRTRVenBROG9iTFN4eEVFK2Zy?=
 =?utf-8?B?dUxseXJjdW4rSHNnWDZJanZYZy9SS2t0cEVOT09LRm9FS0R4bTMwSUY5Yi91?=
 =?utf-8?B?U21PYlp4d1hNTTBTRmxscHBBYzRTbEFKak8zaERzZlppTWlNOGNtbEtuaGQw?=
 =?utf-8?B?dVc4ZkRzaUxmN01JVmtWRWJuNTl2Z1NZUmZ5dFl3NDlCYVR6RWZ6UVRjQ01I?=
 =?utf-8?B?Q2o4QnRnbWptMEhEdnQzaEVZNk9IRVVuMzJUZVcwL0VYb1RLamVPTkdCb21S?=
 =?utf-8?B?OTN3ZS9vQnViQTNyM0VYYTdwSWE4UXZROUd4TUlXSDI1R2ZEaW8wQUxuQzMv?=
 =?utf-8?B?OFpScVpWRkN0YkpLa3c2ckF5eWtoZ3B1N1NPZGJSeHczUmc3VnNVbkdFSnpz?=
 =?utf-8?B?KzhVVUZjUUFtQUs0YVNKdHgzY2pqSnQyRXpQN24rd3lFMGlFRUU1QWhtNlh6?=
 =?utf-8?B?M3VOUmYwR0hNalMzb1dZTE94RTBaSi9EUmZnRVRqeGFxUW8weDFDY0xlb2Va?=
 =?utf-8?B?UXd2M0JFVFQreEFjekE1cFNzNmJyOUw3a202UWJHdTRqUXlYOXVoM3d2S2Mv?=
 =?utf-8?Q?UjNvth?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5094.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGlwYVo3S3NCMXphNGx6RENlZW94UGpHekt1b2xNL2lsRWlzdmluR3BYZko1?=
 =?utf-8?B?a0lqNndGNmk4a3ltWmNkcm5ZL2g4MG9HdFptZXgrSE5PSHRCTVBVd0VmWklO?=
 =?utf-8?B?bm13b2JycklJaFNsMlVkQ2RDb1hITlBVc2pCM1RycXhrNlU3VTBxQ2RGRU52?=
 =?utf-8?B?VlkxYVNkYW1Qek9TOHljRVlQaEtlUmVhV1BqeDFvdlBVS1FoRjdzNUFvczhk?=
 =?utf-8?B?c2h0TEd6YWNSMWNncGpmb1RhT1BwYUNsSVRPclROYWZVanlnVUUySk9sWkdp?=
 =?utf-8?B?VUlYUWE1OHZNVGszNVVRVVZ6cXZxc08vbHRuOGZ5MU82Ylh0dER4eFpndTlZ?=
 =?utf-8?B?TUhYUzllODVVbS9TcVB2TWNwTHl0WnNLeVlQdnJuaHlrZHFDWHM1K1ZRY0xx?=
 =?utf-8?B?VTBpMm10KytKU2ZGd05HZVZKZTNjNGRjRWJGaXRBd3B2TElWdG03RWh2cUpC?=
 =?utf-8?B?QUFtenc1NTN0WEpsL1JlVWRsMkZBdGplcXZYZHhDdGF4L1JiM01vVlhPQis3?=
 =?utf-8?B?WVJSSE9SRTVOTTdjSTBoK1h5bnhKSi9ab0lnVTY1QmNIeFhZZkFaYzBmS1pu?=
 =?utf-8?B?R0N6Z240cG5nb3hSWlhjdXFGVEVlYU9HUjlvQTF1aUxRMFBqdW13TzZWVlpi?=
 =?utf-8?B?ZVl5M2FoN056WTNVeUxiVkdKVDJsNnpVaEdFYzUxZlRXa1R1aFpQb0l4bVho?=
 =?utf-8?B?UjY2eTBHNFZidlRlaUZ4Zm14cEJLVFNxS1hOYUZTenQ2MEY5RVBEby9DSUtT?=
 =?utf-8?B?UUppYWZhdjRRa2Q0V0lOc1NETVNLaUZpbGdFaThjZEF1d0llNUMwQXp1akNj?=
 =?utf-8?B?dEFnZUtXV0hpSnVJWXdIbDdIcGFHdGJLZWFOY0Z4TnpTUGdjQ3hPbEVxSlY4?=
 =?utf-8?B?R0dPTWVUV2pMM3pCYUl1Qks2TC9VUUcyUVp6M0J1cHMxR1V0NHFObjZvSjYz?=
 =?utf-8?B?ZXpoTGJWYm5EemUyWUo0cnhhVFV2b1kvdlFLUkZMQ0FacC8yaG9sbzI5aUtn?=
 =?utf-8?B?SFptdVBROXdIQmJoaTUrUFZsSm9DcHVoM25wOTZ1UVl5eE54eXFHUmRXcERY?=
 =?utf-8?B?Zzd3MStVWXNyNjRROXhUbXk0L1hSRFNHREY0cFhhODgvQks2RU1UVW82VmVh?=
 =?utf-8?B?L2UyZlN1Q29UbmJKZVQ5NzFlK0NTbWt2M0QxNEtDdEJyNkNXYU90T09uREJ5?=
 =?utf-8?B?c0tIeDVveFRuTUtKUHBWdlJmRmlkSisydjlCM0JwVXBqemNXamI2ajhKZlow?=
 =?utf-8?B?ZWNUMjllYkpDb3dwdzZydE1UcW8rV0lNWDE3YW1EVjhWeGFacDJnWTNKUzc5?=
 =?utf-8?B?TTNEWGJOYjFwZkdUOTVRRDladEZpdXdaOU91QllKdDM5OGZ6L3V3Qm5iYzVq?=
 =?utf-8?B?VWVtNW5FLzkza1NwMWd4aElRRjYxMEx4aXZXRnpOcERsTFlmcnR1UElSVHFJ?=
 =?utf-8?B?QVVrR0JOYnZtQWNJbTNHTVdEY3pBMml6bWJPb2FBaUZxSVBvbitSV3hBclNj?=
 =?utf-8?B?cGRuYitUWGw2eUtHeHN5aUJGL2xFdXhKSGlvSjVTWGlxYXFqSE5jV2loZzlO?=
 =?utf-8?B?UjlNK095cmhWNjN1dmp3c1ROd25WRWVFdk1IT2gyUUY2eXlVdm9oVEw4TEcx?=
 =?utf-8?B?MzhRQm5mRDFCL2E0NnpaL2xPT29iYmlBWTRPVXNoZTlFWnpyaC9Kb1BkZE9w?=
 =?utf-8?B?VnhLVERGK0UyZU9xUWNOMUp6UGNzNjJzcHpzTHB6VEVGWUJZYkVTSE9iNFRq?=
 =?utf-8?B?WllYcXBLcUZ6SjNCN2VGSEhSeU5GRElYVGxjcUVlKzlmdDRHSEJYS0JFLzFN?=
 =?utf-8?B?NUlwTkIwa2RDb0Z0Q2t3QUM4RWY5QThhcTNYNmpMZlFvdGxPZ04vTXJiMjNQ?=
 =?utf-8?B?b05abHFjNnBGd0F6dVcwd2UzUWw2Y3FucmVBL3VKVXk1ZUZ3TVJDTXZrOWNC?=
 =?utf-8?B?VzVWTm5CMWJQUCtQL20rSCtMZkJtWUVkOVJ6VXNZUzgyQ2kyTFB6TVRNb3F2?=
 =?utf-8?B?OFNXVDJuMEZnZVBEWGlNYU16YW1Lc2s5Rm8wR2wwZjhFaEQ4Uk10VitzNEdn?=
 =?utf-8?B?NHJ6TWlYUVhOZHhMQSs2NlJ6U1QvRktqZ0pnQjRTVlgyVzhPMlRkKzVTRnFY?=
 =?utf-8?Q?X+KM39GDDTsVa7FN/VcWD4G4S?=
Content-Type: multipart/signed;
	boundary="Apple-Mail=_236AB6AC-99CB-4FB3-8CC5-8B183EA7451D";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07f9183-0040-4ed9-a305-08de0b57f1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 19:29:07.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCA6X+LjXB8iJsvsrub0g0lyidK2k5fMuP7/+xBf9Aiw7drNqZxl1k6yqj0VKR3WTt1AnqTOhEO2r3ogPHXaBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9691

--Apple-Mail=_236AB6AC-99CB-4FB3-8CC5-8B183EA7451D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Sep 4, 2025, at 2:07=E2=80=AFPM, Jim Harris <jiharris@nvidia.com> =
wrote:
>=20
>=20
>=20
>> On Sep 2, 2025, at 7:41=E2=80=AFAM, Miklos Szeredi =
<mszeredi@redhat.com> wrote:
>>=20
>> External email: Use caution opening links or attachments
>>=20
>>=20
>> Some fuse servers need to prune their caches, which can only be done =
if the
>> kernel's own dentry/inode caches are pruned first to avoid dangling
>> references.
>>=20
>> Add FUSE_NOTIFY_PRUNE, which takes an array of node ID's to try and =
get rid
>> of.  Inodes with active references are skipped.
>>=20
>> A similar functionality is already provided by =
FUSE_NOTIFY_INVAL_ENTRY with
>> the FUSE_EXPIRE_ONLY flag.  Differences in the interface are
>>=20
>> FUSE_NOTIFY_INVAL_ENTRY:
>>=20
>> - can only prune one dentry
>>=20
>> - dentry is determined by parent ID and name
>>=20
>> - if inode has multiple aliases (cached hard links), then they would =
have
>>   to be invalidated individually to be able to get rid of the inode
>>=20
>> FUSE_NOTIFY_PRUNE:
>>=20
>> - can prune multiple inodes
>>=20
>> - inodes determined by their node ID
>>=20
>> - aliases are taken care of automatically
>>=20
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>=20
> Thanks Miklos, this looks great. I=E2=80=99ll give this a spin in our =
virtio-fs FUSE device.

Hi Miklos,

I was finally was able to give these patches a spin. They work great, a =
nice
simplification compared to FUSE_NOTIFY_INVAL_ENTRY. Feel free to add:

Tested-by: Jim Harris <jim.harris@nvidia.com>

Best regards,

-Jim


--Apple-Mail=_236AB6AC-99CB-4FB3-8CC5-8B183EA7451D
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDckw
ggYyMIIEGqADAgECAhMgAAAALrvyv+m6ZpdVAAYAAAAuMA0GCSqGSIb3DQEBCwUAMBcxFTATBgNV
BAMTDEhRTlZDQTEyMS1DQTAeFw0yMjAyMjcwMTI0MjVaFw0zMjAyMjcwMTM0MjVaMEQxEzARBgoJ
kiaJk/IsZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZudmlkaWExFTATBgNVBAMTDEhRTlZDQTEy
Mi1DQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALXlPIG4W/pcHNB/iscoqFF6ftPJ
HTjEig6jM8wV2isRi48e9IBMbadfLloJQuwvpIKx8Jdj1h/c1N3/pPQTNFwwxG2hmuorLHzUNK8w
1fAJA1a8KHOU0rYlvp8OlarbX4GsFiik8LaMoD/QNzxkrPpnT+YrUmNjxJpRoG/YBoMiUiZ0jrNg
uennrSrkF66F8tg2XPmUOBnJVG20UxN2YMin6PvmcyKF8NuWZEfyJx5hXu2LeQaf8cQQJvfbNsBM
UfqHNQ17vvvx9t8x3/FtpgRwe72UdPgo6VBf414xpE6tD3hR3z3QlqrtmGVkUf0+x2riqpyNR+y/
4DcDoKA07jJz6WhaXPvgRh+mUjTKlbA8KCtzUh14SGg7FMtN5FvE0YpcY1eEir5Bot/FJMVbVD3K
muKj8MPRSPjhJIYxogkdXNjA43y5r/V+Q7Ft6HQALgbc9uLDVK2wOMVF5r2IcY5rAFzqJT9F/qpi
T2nESASzh8mhNWUDVWEMEls6NwugZPh6EYVvAJbHENVB1gx9pc4MeHiA/bqAaSKJ19jVXtdFllLV
cJNn3dpTZVi1T5RhZ7rOZUE5Zns2H4blAjBAXXTlUSb6yDpHD3bt2Q0MYYiln+m/r9xUUxWxKRyX
iAdcxpVRmUH4M1LyE6SMbUAgMVBBJpogRGWEwMedQKqBSXzBAgMBAAGjggFIMIIBRDASBgkrBgEE
AYI3FQEEBQIDCgAKMCMGCSsGAQQBgjcVAgQWBBRCa119fn/sZJd01rHYUDt2PfL0/zAdBgNVHQ4E
FgQUlatDA/vUWLsb/j02/mvLeNitl7MwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0P
BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUeXDoaRmaJtxMZbwfg4Na7AGe2VMw
PgYDVR0fBDcwNTAzoDGgL4YtaHR0cDovL3BraS5udmlkaWEuY29tL3BraS9IUU5WQ0ExMjEtQ0Eo
NikuY3JsMFAGCCsGAQUFBwEBBEQwQjBABggrBgEFBQcwAoY0aHR0cDovL3BraS5udmlkaWEuY29t
L3BraS9IUU5WQ0ExMjFfSFFOVkNBMTIxLUNBLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAVCmUVQoT
QrdrTDR52RIfzeKswsMGevaez/FUQD+5gt6j3Qc15McXcH1R5ZY/CiUbg8PP95RML3Wizvt8G9jY
OLHv4CyR/ZAWcXURG1RNl7rL/WGQR5x6mSppNaC0Qmqucrz3+Wybhxu9+9jbjNxgfLgmnnd23i1F
EtfoEOnMwwiGQihNCf1u4hlMtUV02RXR88V9kraEo/kSmnGZJWH0EZI/Df/doDKkOkjOFDhSntIg
aN4uY82m42K/jQJEl3mG8wOzP4LQaR1zdnrTLpT3geVLTEh0QgX7pf7/I9rxbELXchiQthHtlrjW
mvraWyugyVuXRanX7SwVInbd/l4KDxzUJ4QfvVFidiYrRtJ5QiA3Hbufnsq8/N9AeR9gsnZlmN77
q6/MS5zwKuOiWYMWCtaCQW3DQ8wnTfOEZNCrqHZ3K3uOI2o2hWlpErRtLLyIN7uZsomap67qerk1
WPPHz3IQUVhL8BCKTIOFEivAelV4Dz4ovdPKARIYW3h2v3iTY2j3W+I3B9fi2XxryssoIS9udu7P
0bsPT9bOSJ9+0Cx1fsBGYj5W5z5ZErdWNqB1kHwhlk+sYcCjpJtL68IMP39NRDnwBEiV1hbPkKjV
7kTt49/UAZUlLEDqlVV4Grfqm5yK8kCKiJvPo0YGyAB8Uu8byaZC7tQS6xOnQlimHQ8wggePMIIF
d6ADAgECAhN4AcH5MT4za31A/XOdAAsBwfkxMA0GCSqGSIb3DQEBCwUAMEQxEzARBgoJkiaJk/Is
ZAEZFgNjb20xFjAUBgoJkiaJk/IsZAEZFgZudmlkaWExFTATBgNVBAMTDEhRTlZDQTEyMi1DQTAe
Fw0yNDExMTIxMjAyNTZaFw0yNTExMTIxMjAyNTZaMFoxIDAeBgNVBAsTF0pBTUYtQ29ycG9yYXRl
LTIwMjMwNTMxMTYwNAYDVQQDEy1qaWhhcnJpcyA2MzZFQkM4OC0yNThCLTQ2QkYtQkU2RS1ERTgz
Mjk3NEVFMkYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDsK5flcFLKT/1ktmlekKTA
8JwI64E20ekPEvj4KcEynk2b/aaS1Vol+gDoCmp8Q2YKca4RO3IPmWYGMEKWyOwh3R/X+NDC3kEn
xR9FRyPKixPVaVIJOBvpLgTHlTGo6sBECGARmWLNcq/VP/IOEfynt+o0ycfhfMmVCLNeTpVnTDfr
2+gA+EzrG3y7hFlf741+Iu27ml7F2Sb+OuD8LaaIvbUH+47Ha9c7PNbS8gGCOqJ+JqpFbz6nyiVN
KzcxsvQph1p1IlvctilnvGOLNCSQY24IPabPY4mh2jOOELalk8gKhIgeZ4v4XnuDGKzG3OQXjvNW
ki++zsKA+Vb5MH1HAgMBAAGjggNiMIIDXjAOBgNVHQ8BAf8EBAMCBaAwHgYDVR0RBBcwFYETamlo
YXJyaXNAbnZpZGlhLmNvbTAdBgNVHQ4EFgQUXogZtTPa9kRDpzx+baYj2ZB5hNUwHwYDVR0jBBgw
FoAUlatDA/vUWLsb/j02/mvLeNitl7MwggEGBgNVHR8Egf4wgfswgfiggfWggfKGgbhsZGFwOi8v
L0NOPUhRTlZDQTEyMi1DQSgxMCksQ049aHFudmNhMTIyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPW52aWRpYSxEQz1jb20/
Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlv
blBvaW50hjVodHRwOi8vcGtpLm52aWRpYS5jb20vQ2VydEVucm9sbC9IUU5WQ0ExMjItQ0EoMTAp
LmNybDCCAUAGCCsGAQUFBwEBBIIBMjCCAS4wgaoGCCsGAQUFBzAChoGdbGRhcDovLy9DTj1IUU5W
Q0ExMjItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9bnZpZGlhLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBWBggrBgEFBQcwAoZKaHR0cDovL3BraS5udmlk
aWEuY29tL0NlcnRFbnJvbGwvaHFudmNhMTIyLm52aWRpYS5jb21fSFFOVkNBMTIyLUNBKDExKS5j
cnQwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLm52aWRpYS5jb20vb2NzcDA8BgkrBgEEAYI3FQcE
LzAtBiUrBgEEAYI3FQiEt/Bxh8iPbIfRhSGG6Z5lg6ejJWKC/7BT5/cMAgFlAgEkMCkGA1UdJQQi
MCAGCisGAQQBgjcKAwQGCCsGAQUFBwMEBggrBgEFBQcDAjA1BgkrBgEEAYI3FQoEKDAmMAwGCisG
AQQBgjcKAwQwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggIBABaxnmlH
ePMLNtYtyCN1iDp5l7pbi5wxLNXCULGo252QLCXJwKTosiYCLTT6gOZ+Uhf0QzvbJkGhgu0e3pz3
/SbVwnLZdFMZIsgOR5k85d7cAzE/sRbwVurWZdp125ufyG2DHuoYWE1G9c2rNfgwjKNL1i3JBbG5
Dr2dfUMQyHJB1KwxwfUpNWIC2ClDIxnluV01zPenYIkAqEJGwHWcuhDstCm+TzRMWzueEvJDKYrI
zO5J7SMn0OcGGxmEt4oqYNOULHAsiCd1ULsaHgr3FiIyj1UIUDyPd/VK5a/E4VPhj3xtJtLQjRbn
d+bupdZmIkhAuQLzGdckoxfV3gEhtIlnot0On97zdBbGB+E1f+hF4ogYO/61KnFlaM2CAFPk/LuD
iqTYYB3ysoTOVaSXb/W8mvjx+VY1aWgNfjBJRMCD6BMbBi8XzSB02porHuQpxcT3soUa2jnbM/oR
XS2win7fcEf57lwNPw8cZPPeiIx/na47xrsxRVCmcBoWtVU62ywa/0+XSj602p2sYuVck1cgPoLz
GdBYwNQHSGgUbVspeFQcMfl51EEXrDe3pgnY82qt3kCOSzdBSW3sJfOjN0hcfI76eG3CnabiGnVG
ukDrLIwmyWQp6aS9KxbJr4tq4DfDEnoejOYWc1AeLTDaydw7iBNAR/uMrCqfi5m4GjnqMYICzTCC
AskCAQEwWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJYIZIAWUDBAIBBQCg
ggFDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MTAwMTAxMDI0
MFowLwYJKoZIhvcNAQkEMSIEIMNz7uozjSGBVYbY4JL+SxBCzGYxtxDk2jpRypOI5gN5MGoGCSsG
AQQBgjcQBDFdMFswRDETMBEGCgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBm52aWRp
YTEVMBMGA1UEAxMMSFFOVkNBMTIyLUNBAhN4AcH5MT4za31A/XOdAAsBwfkxMGwGCyqGSIb3DQEJ
EAILMV2gWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJKoZIhvcNAQELBQAE
ggEA4bE+M7L85lnpKirBUWmwfroX7TIs0QylcnZ2Gkhiqr2Z7Txs+jBRqXbZTL5ADYkkQJNzawcs
4ZSqI9d7BQmFmBMxN0GFZB3l5Mow7bVmLG+zTmrKOLyrwkvk4/GjczGAk3xcpYyh6c/kOMNGGy2Q
tfaJVD5pJlySKr1DHyoK6pApVG1lUKzAVuxe33t7sMY75ViNjKtE7qJp7vRQDnvjwSU1HFc4GQZt
u7A91nksChkmSmKDVLqInQKWLtXYJRVjsMH28O7QTa0Cq08n1B+lF0p+fdAPrgvtwmPoI5MAQ2VE
Lj27hz64lp71QHCUGuNgt8xsYAiR1qOP+k5SIFo5tQAAAAAAAA==

--Apple-Mail=_236AB6AC-99CB-4FB3-8CC5-8B183EA7451D--

