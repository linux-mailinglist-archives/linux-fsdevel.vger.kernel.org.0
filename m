Return-Path: <linux-fsdevel+bounces-59412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12009B388CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C23981682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C89285C8F;
	Wed, 27 Aug 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oq7LN3cW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1D4086A;
	Wed, 27 Aug 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316733; cv=fail; b=PdEv30iKUe0nXMPcLDmJI/79lBvKYN0W5uDbK1ZAi9y9T3BdxaQUU4JnkhKMZH7Jrt2RTjJ6sS+BrgOoUFaMtSVUhrZ5gzkAN/JGfihWuOyDTQvUoAJJaYr3Ei5Gz+j98FbhyL+0Af+1rh8/o/t5YXYvnArdQ+rfMwVBsv0ta0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316733; c=relaxed/simple;
	bh=X/0l17+SJl1Wed4R9NJMGsecJeSIbjN1Ih63pKOuybQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YP87IENEG3TRiI/Wu5u/PLFv6KeKC1x6KjoQUXrJVs6f9/0mtxed3ddJYXhcJoxFZMyo3iUDsyWGqWyrxWgwURTqEM4yzHE+uTdc2Jiyu1ly2cB1Ie3Ip0Gb0ybkRdJBHnB+1bji37EDVtbHAOV0qXXoyNWLie6qgluuXJnjpd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oq7LN3cW; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz22UURlY4PJ/rISeRfRcd4j8NmdQ6UIwzxnWX0AidDsDS0hRHoYlW5Nnl0QvwDLMoHbiIU7Yajkx80oZPC31HztFF1FOJtcytJDy2zEGpu/qTMLed6R9Pvebze4+1zKHmvYso0AUGb2G3r2tYLNotLIgmq08h2IuTXtVOndhdlDl+n+AXlwUiFSNBi6xL7vxZqofIYhxwZdk3eUFCb09bkWVbAVxHDmJCWPv8k3uvdGxmOAbMcbeNDL6f7LD4rXzRbm8hTSkg/1s0FkwQ8IO/pB6tEvL6yobWVtMnm6CzbWU67WBSBofDxxc5YqLuBwOO2PMb1e2nga/Oe2eX74Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pVAeOETua0RdosS6xMVD28ufxJ3GGFoTCRJbn77DFI=;
 b=BpT+SS3mgXIR63akRkteKswFmQIiYFUuLCDTiIa00cwIvXj2UxQT4naSRUrRtOcI+qUfnDXomOno9QytHLzAx/Zj9TrdBbysTlxEA8OAZtsGbZ7r8ImTdxg5Bab9RSII/o4m3h6G8ZFW45gfHKOy9ABxyeHLu6zSARmnV9Bi7p6iZErKRvvf5JnV8B/vLUQ+L6C5glWXuUoac8gvBk3NQYaTkM72dS5+2p+hX7yw/Ue5jlzxveoF11zMX+WXFmBxn4iTZVWunWxTxQCAl68xffFXLcBMphCXaY+NC9EcziLSACcrr4BKPIJ9ViXRX4lxfZoNlJVAGwRks2mXbGBocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pVAeOETua0RdosS6xMVD28ufxJ3GGFoTCRJbn77DFI=;
 b=Oq7LN3cW8BLadmctgLQ/EHLk/Ygr7M4DhR/OYmt3C676+GjvuXvnSQg2ez+DuU6NwhUk1RVA+Vdj7KeasED6cEFlv3BvKWVajwz3mX+kF4Klbh6tUjiQlF7RbzpcBTAyVL7UEVyynAZc3Lp5cRalke61j9MOcTCBxv5ZzQm29WCNRx709TKGZ9YNgl6Wa1DmaaEpMtXL7oqo/WPbCzfuv9rVTOiPXqSQSKmxsEzK6Su6zBOFUgBnXN2t8oRNgp9lPf9CF7kI8MCy4iLYwnuklGS9yll6Zz4LqFn0yATQ4sXosYVWIun2SJdOApsnt7pIiFufPH8Vj8AF2hkK2A2djg==
Received: from BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 17:45:27 +0000
Received: from BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb]) by BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb%6]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 17:45:27 +0000
From: Jim Harris <jiharris@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stefanha@redhat.com"
	<stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach
	<izach@nvidia.com>, Roman Spiegelman <rspiegelman@nvidia.com>, Ben Walker
	<benwalker@nvidia.com>, Oren Duer <oren@nvidia.com>
Subject: Re: Questions about FUSE_NOTIFY_INVAL_ENTRY
Thread-Topic: Questions about FUSE_NOTIFY_INVAL_ENTRY
Thread-Index: AQHcEWHgWIwFHGDQ0EazMQvH1t6jpLRrPYMAgADFeYCACoDMAIAAThmA
Date: Wed, 27 Aug 2025 17:45:27 +0000
Message-ID: <584586F6-09E0-4186-96F7-A76E4CBE1471@nvidia.com>
References: <D5420EF2-6BA6-4789-A06A-D1105A3C33D4@nvidia.com>
 <CAJfpegvmhpyab2-kaud3VG47Tbjh0qG_o7G-3o6pV78M8O++tQ@mail.gmail.com>
 <1E1F125C-8D8C-4F82-B6A9-973CDF64EC3D@nvidia.com>
 <CAJfpegtmakX4Ery3o5CwKf8GbCeqxsR9GAAgdmnnor0eDYHgXA@mail.gmail.com>
In-Reply-To:
 <CAJfpegtmakX4Ery3o5CwKf8GbCeqxsR9GAAgdmnnor0eDYHgXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5094:EE_|SJ2PR12MB8927:EE_
x-ms-office365-filtering-correlation-id: 4dab19c7-a1f0-4eb9-bc5b-08dde5918269
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|8096899003|4013099003|4053099003|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHlpL3loWDQyV1gvY1VJR2xSZjQ3WitrL0lFeFFHUVR0WTlOMnZ5YlNjK1A4?=
 =?utf-8?B?NXVESkF3OSttRVBtMDdHeVlRbkx0cTZlcTd5SFpLMVJLM0JiU0lNd0ZZV0dq?=
 =?utf-8?B?UUtaRkVwY2M3S283KzlTMFNxVStHc1Q3Szh1bU5IZGN3YTE4TlVPcndFT2Jz?=
 =?utf-8?B?c1ZQcXkreG5ZQ1J2R2dsV3pUbnV5anpObjRBWEVsTXo4TEhubWxONUpNRkJn?=
 =?utf-8?B?WkF0WkpkUmdoMWY3clN3dWRWK2p2eFJDY0FGTXBzV0xzelo5NTIxVjQrY3J4?=
 =?utf-8?B?REFsR1YwbFFJVU8wckJBVTdVV0pSTVhIRmlsbXJtWFBTMU9uYVM1S1Y4UWNp?=
 =?utf-8?B?TVAvT2libEczWmhsZUJDTUVVWWFsaWVodk5oQzVqSW54YkJsSjAzelBOZ3J4?=
 =?utf-8?B?M2liYTUvTG5kYk9ma2lOaUg2ZFpOMlNzUWljNlZLZkNweXNFcmlQQ3VPRnJn?=
 =?utf-8?B?MFlYM3BXMkpTeWJqQUdkcXZCYWh0VjNOV3dmbDB3b0NmL3ZzMzdBQjhkYURB?=
 =?utf-8?B?WEpRRmhOQmo2RXBlbjRXK1lGOW5ud0xGMnhRSkZxQlF0NGs4UFVxc1Fha0Zz?=
 =?utf-8?B?d1VsSERqNTJoUTlNZ1lDUXE2Z3VZQW5hNFJXSFNUTk9iaFF6azFhTVBrQm0r?=
 =?utf-8?B?M0p6dlg5cTdEQ0k2NTJEQU9NRldJb1Vxb0xBVS94TTVoNGdHUTh2SUNaOWNF?=
 =?utf-8?B?UTJlai9ZRTZQVkRzRFpZdWdSYmh5OFcvNjRvYUlDQzJHTWpnTzJVemg4VGxS?=
 =?utf-8?B?eWtxVnUwUkF0TG5UTGFob29ha2NRN2FKU0UwaytnbDVMM3pSQ0F6dzM2b2Q3?=
 =?utf-8?B?V2JtbTR6RktibnJQeWMwSWdXWWxRVDYwdjBYYlhnVnVZQTNaMjIvTjNMYkc0?=
 =?utf-8?B?WEk3VkoyZ3dicHU0YjRyWDZ5YUtBK0N4a2Jrb0RuWktSUXNJQStwUk13Ykpp?=
 =?utf-8?B?bzVDUGtqa3ZEUHVNVzhYSHFRUVVjS1pDYm5BaUpRdFYwZ2xCYTJQMC82M0w1?=
 =?utf-8?B?U0Yzb1JaVkN2V2VqNGxheS96ajBKbWNOc1RWUTBrVDRzaWJpVkVOQXc3R0RG?=
 =?utf-8?B?clpIUmFJT0c5cTA4eUVDM3A5MGN0R1l2ZEJCUGVzS3Q0c2liZDdwVnVjOS9K?=
 =?utf-8?B?SktDVUFHYi80bkY2MG5UR1VpL0JSZE9KSTRhMUJWN1N4SnpFaUNsbzFaUFcr?=
 =?utf-8?B?cW9JSGJyT2sxbGNZV0MrYTc1ck5XN0tFVWxCSnRBekMrRTB6OWtkd1NadWJY?=
 =?utf-8?B?OStrd0lJT0dRTE8vL0x4YWM2NmpKaWdjbTV2TGVXYlhuUTg5cEZGY1Q0dmlS?=
 =?utf-8?B?eEVmOTdxeHNKOEZTaGZVUk1pMWtVZk8vOExqcEs4Nm9ZZzZFRWMzb0V6Zmhu?=
 =?utf-8?B?M09nT0llSlp3Y1doUDN4NDh0b2o1Mm9Xck0yNEJFbVBDdjZDeCtETStqOXFo?=
 =?utf-8?B?UUYxSFJhWm1pRGtFeUJYZFc2MDhNS1hoUTJaaWViL3FoRUs1MVhxbEc1eE5H?=
 =?utf-8?B?ZTVBNTEySE0rRnhYVURNUGFWMWdtTm9PR0srOHEwdktWL21OUy85NnFTSldQ?=
 =?utf-8?B?aFRYcjJ0S2daeHBzQ0ZmNkJEdDhZRDQwOWl5eDJkbGxlako4cFpXdkIzY3g5?=
 =?utf-8?B?cWhvT0Ezd21HdjJDUGx0OVpzZU5kWmhiQTlSMkd0QTRxMnltOHhKTkV1YjRC?=
 =?utf-8?B?TEpPMWpGSldCY3dWWDJPVTFvN2ZJVzczUW9nOCs1cGIrNWhyUHJHaU5ocWV5?=
 =?utf-8?B?SzJTNGJKS0Z3WDFpRE1zU29OZzJycEhWeU9xWlg2QWkzdG91YzNkV3FjNVds?=
 =?utf-8?B?MGlqeVI3a2l0ajh5U0lPOWZOcFU5NmZKQklEdUsybUtnUjNFMlE4cUlER3Vl?=
 =?utf-8?B?TXJsdGllZkh6dHcxN1RVQTNHOU1MZmpwcSt1djhHQTlPNWRiUEVyZkRxOFNT?=
 =?utf-8?B?c1IzTjBsanU1Um11ZkxxOU1iaTVIeEJhbFNiKzRBcHpQTERkM09NMDN1QTVT?=
 =?utf-8?B?M0tRUEsyMWhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5094.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(8096899003)(4013099003)(4053099003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWFuNVVEaWM5T2JiYTdNSnFXZlhMM1ZZL3Vob2RDUHVOdGUzcGFYUjhrbHBE?=
 =?utf-8?B?QWYzTFBJb1pwWDRKMkV0eWt3eW80Q0lvU0tDOEVVU0NxQTB5eXhBZ1V5V0Ex?=
 =?utf-8?B?WDJ2YzY4U3lhblc4RzRKZlQ2Z2Y1TnlSMSs5cHV6YlU5cFlwb0VLSGIwTElN?=
 =?utf-8?B?bGVnQllZSXVFZURlbEdLMnBYV1Axc0dJOEs5S2NDM000ZFd0WFJhR0dvU014?=
 =?utf-8?B?aklEdW5QSTBxWEx5UTd2U2tQTGxIbUc5MjJmWkx4SUZmZHVhbTBnSVU1NXUz?=
 =?utf-8?B?cFQyV25PaHc0bkRVVjgzeXZlQ2pXNldZQld4elZhdmlidS8waVJEcmprN3NJ?=
 =?utf-8?B?cFlQeGdwV2lCRkk2ZkhUMUp2cTJMOTJpdmZhU3U3SE1aRHFBR2ZkM0lQVmpK?=
 =?utf-8?B?ODM0QmQ2TldkaDdJTC9YakczQmtFTU4wMDRaYW9NT0pXZ0VnbUZyL0NhckdI?=
 =?utf-8?B?MXFZdWlOeWEwdmw4elB3WWNRZ0E4SFFZOFJkZFhuTUtOdmhneTdUY0pnMUo2?=
 =?utf-8?B?aXNRa3o1ZVI5eE1KMXFjRDNwaDRwR2thL2tjUkxIemg5Y0JzbEUzclh6ZHRB?=
 =?utf-8?B?bVYrWHc2T1BYVG9KdStja0VsSjNCSk53Y1JRNnlIZSt6VDBjenlHZUFGc1c5?=
 =?utf-8?B?VmVSaU5SM0pZZ1ZvMjcvVlVOL1Zjc0swYUZ5WWRMdEsyckZKK05CRkNYZzU1?=
 =?utf-8?B?djNGMzZrdUM4eS9CbHdsVlkySFBHaXJvdHdLRUhNZUl4R0ZtaENpUmVaS1dB?=
 =?utf-8?B?SnNxdE5NTWVMK3I4Z2dBaEhMSDA3SE1KUi91VFJ2aGZnL2Q2c2hwaVBnSHhj?=
 =?utf-8?B?T1VGajhTUXlEU0VqaFNZNzBldDQ1Z1FLVXdoajJFSk43anVMMm0wYlpaRFpX?=
 =?utf-8?B?SS95ci91UEFxWGJjK0RoZ0gyOGdRa2VyWFAxblRTVUgwSFYvR2tHMlNlSWNW?=
 =?utf-8?B?a3dCSHV2QmhkTzFKVHFRd0ZUdEU3RitCc2pPOWU5QUlKRnU0T0NycGhZTGpO?=
 =?utf-8?B?dVU4QllSdFE4ZHpwcWJ5aTg1dzdjNnUxQ083MGtpMEc1ZzNpeFppS2ZyNUF5?=
 =?utf-8?B?OGo5WFZwNkhFMjlUT2VYMEtyZ0lZcE1UWjNNSTlnTmQ0Zk1jYzF6THdHZVRm?=
 =?utf-8?B?dVNkb1hWU2Qyenc4bWlBZzlSRmo0cmdueUd0dlk4WmdGMU9vOGIxR1JMZ01a?=
 =?utf-8?B?NUluazdZUFVBRVZLWS9RTEpDWkRlYURxVDNCc3FGMVFLZUZmeXdpekhjRFBX?=
 =?utf-8?B?TWJUc0FncTkzRE0wT1pDQ01pVVhhZWtlcmlnTENteVlhRHRrZ0dvOHVqbGh6?=
 =?utf-8?B?dDZHeTgrK09DY3p5ZWZiTnp0Y3dmNE5USHpncnBPLytuZmVPUmN4bmJIK0RH?=
 =?utf-8?B?THZkQnFKU1Y3Zis5NEZGZ2hESUxGWkZ4aDhmV2k2bGNyQUJ4UmJ0UjZReHJV?=
 =?utf-8?B?TjlnZnh6Z01rQzNkSU5sSHNxOGxTRjN3YXM4ZU5HOWdFTkpzZi8vYVdNMi9M?=
 =?utf-8?B?SnRCVG1LVk90UjV1T3hXRDJPUUtxcjJRWWZPajl5TnQ5TGdXRGNKREhSNjFk?=
 =?utf-8?B?bG1ldlpqT1AwTytrNDZrZjVyU0t5WG8zR3d5SmIrbVRPb0tPcUJTTVNwVk5I?=
 =?utf-8?B?RlZ5WVFjYWtlYTByL2tCNjJYUDJYbGNrZUxGNXcwY0xGZHM5VFQvb1BBZ2Rh?=
 =?utf-8?B?RzltRFY2OXM4MGtlczJGTHgwS2NqclNxcWdwNW51cDg4YVJCb1J0MjZCM3Zn?=
 =?utf-8?B?dnNDNE80V1htUVM1R1FyTEVlVjE2TENXUzJ0aUJmaEJjbnVHck9hMmpmZTFa?=
 =?utf-8?B?RlJOVThjZWFoTFlTYlNNd2NBODIvNFg5ZGUwZmMwaFpSbEFJTU5ra09YRGJT?=
 =?utf-8?B?cGZ1NklXZVF6TzBycGZjekwyNlRSczFadk9Pckk1aDI2QU1yZEN0c3pzMHNn?=
 =?utf-8?B?V0p3Q1UxRXJzUzh2TGF1NXY4emhOdi83TkhGeXRtbzBKNDEyd2ZuaVlNQ0wr?=
 =?utf-8?B?bnA5TVdnTHZhQ3g3ZTdtdEJnWnpLSVlZdkllU20yU1J1UmlkMC8wVkJabWJk?=
 =?utf-8?B?U2Y4VGQzWk1CejJSSFE4bUNlcDIxNGxyYnZEMEY3NWFocHhtWktQdEJaS2Rj?=
 =?utf-8?Q?QzymrrDh4xblY2PjYvUFrOBEY?=
Content-Type: multipart/signed;
	boundary="Apple-Mail=_4A3B4A60-B083-456F-BEA2-57CEE80CB75A";
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dab19c7-a1f0-4eb9-bc5b-08dde5918269
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 17:45:27.7319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iM+I5nj9wy5l3nqgHr9e+2mOiJ1LYvJkYx2xpJSMCRuPi9B9NgVGY0T4gtNdWEIP9/X4s4JWnhn6yEAWxk/bnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

--Apple-Mail=_4A3B4A60-B083-456F-BEA2-57CEE80CB75A
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_D1948399-B7DB-472F-B4D4-BCEF9C09266C"


--Apple-Mail=_D1948399-B7DB-472F-B4D4-BCEF9C09266C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 27, 2025, at 6:05=E2=80=AFAM, Miklos Szeredi =
<miklos@szeredi.hu> wrote:
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, 20 Aug 2025 at 22:42, Jim Harris <jiharris@nvidia.com =
<mailto:jiharris@nvidia.com>> wrote:
>>=20
>>=20
>>=20
>>> On Aug 20, 2025, at 1:55=E2=80=AFAM, Miklos Szeredi =
<miklos@szeredi.hu> wrote:
>=20

<snip>

>>> The other question is whether something more efficient should be
>>> added. E.g. FUSE_NOTIFY_SHRINK_LOOKUP_CACHE with a num_drop argument
>>> that tells fuse to try to drop this many unused entries?
>>=20
>> Absolutely something like this would be more efficient. Using =
FUSE_NOTIFY_INVAL_ENTRY requires saving filenames which isn=E2=80=99t =
ideal.
>=20
> Okay, I suspect an interface that supplies an array of nodeid's would
> be best, as it would give control to the filesystem which inodes it
> wants to give up, but would allow batching the operation and would not
> require supplying the name.

I agree, this would be the perfect interface. Better to let the =
filesystem decide which inodes it wants to give up.

>=20
> Will work on this.

Thanks!

-Jim


--Apple-Mail=_D1948399-B7DB-472F-B4D4-BCEF9C09266C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><div =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On Aug 27, 2025, at 6:05=E2=80=AFAM, Miklos Szeredi =
&lt;miklos@szeredi.hu&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">External email: Use caution opening links =
or attachments</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">On Wed, =
20 Aug 2025 at 22:42, Jim Harris &lt;</span><a =
href=3D"mailto:jiharris@nvidia.com" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">jiharris@nvidia.com</a><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">&gt; =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br><br><br><blockquote type=3D"cite">On Aug 20, =
2025, at 1:55=E2=80=AFAM, Miklos Szeredi &lt;miklos@szeredi.hu&gt; =
wrote:<br></blockquote></blockquote><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: =
none;"></div></blockquote><br><div>&lt;snip&gt;</div><br><blockquote =
type=3D"cite"><div><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite">The other question is =
whether something more efficient should be<br>added. E.g. =
FUSE_NOTIFY_SHRINK_LOOKUP_CACHE with a num_drop argument<br>that tells =
fuse to try to drop this many unused =
entries?<br></blockquote><br>Absolutely something like this would be =
more efficient. Using FUSE_NOTIFY_INVAL_ENTRY requires saving filenames =
which isn=E2=80=99t ideal.<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Okay, I =
suspect an interface that supplies an array of nodeid's would</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">be best, as it would give control to the =
filesystem which inodes it</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">wants =
to give up, but would allow batching the operation and would =
not</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">require supplying the =
name.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><div><br></div><div>I agree, this would be the =
perfect interface. Better to let the filesystem decide which inodes it =
wants to give up.</div><br><blockquote type=3D"cite"><div><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Will work on this.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><div><br></div>Thanks!</div><div><br></div><div>=
-Jim</div><div><br></div></div></body></html>=

--Apple-Mail=_D1948399-B7DB-472F-B4D4-BCEF9C09266C--

--Apple-Mail=_4A3B4A60-B083-456F-BEA2-57CEE80CB75A
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

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
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
ggFDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgyNzE3NDUw
NVowLwYJKoZIhvcNAQkEMSIEIMCipF6AUaoSHYqLkenD5tcblRRyu3X5PKSvy6QzUaFVMGoGCSsG
AQQBgjcQBDFdMFswRDETMBEGCgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBm52aWRp
YTEVMBMGA1UEAxMMSFFOVkNBMTIyLUNBAhN4AcH5MT4za31A/XOdAAsBwfkxMGwGCyqGSIb3DQEJ
EAILMV2gWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJKoZIhvcNAQELBQAE
ggEAx/EnTg8vWj55HXwl9lMBbninh5ATbTjO/Uko12MBDzRkKFSWfU7nan2Dfvhqrw45SF0+h/3V
Q6+bDyouKFI+ah/VW5ZjgfXC0+nhX+G8Q2rbDImYM1lAniJn+rgKLvPQpP2O5AKTUl19urvz095W
2KMDDNxnPhioTQj8Roh2Z6ZwD8kCHjoJec5J23Mm+kNftqy7BYE2K6Bw5oGoAgv2nExaRv4b6AUK
dms7Zw2sxPnVIR3lwOKY2GXnB6zCxrCne1lizBdgQM2pVZt5dl2LLOJYg53Akd7PlzuXnM6YksW5
aaq7CrBr/oxL1ezOiJFJES09rJ7zda9cKr+veOaGCwAAAAAAAA==

--Apple-Mail=_4A3B4A60-B083-456F-BEA2-57CEE80CB75A--

