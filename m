Return-Path: <linux-fsdevel+bounces-78336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHZ3DfRknmlCVAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 03:56:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E01191132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 03:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB8C930EB6C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 02:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76329ACD1;
	Wed, 25 Feb 2026 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WAVBHzGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C0296BD1;
	Wed, 25 Feb 2026 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988160; cv=fail; b=e7QcWQDOXLa9zXDjeFQyNU7l2Bl4YtY1ZC809zJ6bDDi63Zu+9Et1vz4u0Owx4Z+2fvHJ2DIhuPX4HntbRWs1sTs1weIPeLxUkTdwDkaivZ+LEkVeNZzHySvlGv4fuTJRjllUYC8Bl+kpJt2kFCKSpXC9jnW69olmtihm/RPnok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988160; c=relaxed/simple;
	bh=7WDsbDaBG2InMsXavwTS4Po4W0I2lVyCdy86DuhKznM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WPJ5Zob62EzGivjNWtneRhLv9oRnUz87joZ3Fje1ZUFVzSbet0GXJ+cpICIHw/bZ0c2vWt5DVldGN+hYhd8CMoROH85b6yV+xEYplGT6FINk/gP6pKyTXVoP3a0M9SJFPAOy2FDeZH0LpFzhRmvpl3CUQxqKle7lygUt1oUupco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WAVBHzGb; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMWR4jwZX9Xdx3u+heOUa1IxcaoZLtw8WEFhaQbstOR621yeLWPB3zNq190ERThZ2iAz4KyiJv6Ww69t4aQLJtGwEJ5NNY18Z32tEVmv2WkLmg6AHfFLoEeCatOsfpTiZ6GX3FvrlL3JPmBXbB0yizFt5Ucs+C674sZJDEAbk9IfKY5o6qh2/oiJUdCjAlMHnU7WgH8vKXmGubNagrOpBx616UOm96TdQSN0UL8pm0hLGXS42mXldtNu1RaxzsVX8HGXFlPMI1NeqWz74O8T8hadjyw4c90p3+ijyaqssysqlUBE1z3/Dn8KMlgclDYSh0Wfggrj0Jj9RB4ojsSs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WDsbDaBG2InMsXavwTS4Po4W0I2lVyCdy86DuhKznM=;
 b=DKSHZUx/bfgVkKOCsrb1Grgbt808LRt54yuVtiTpmgjxAbL0XXW9llYLB9efXTuu8m1rsxdyThN3XF7+AWxkhh5a/JiIyhwfAICyJptQI+qXVnJ4L/PeEu9rf4lBNewaV2MxItM1LXVExiKKcREG+RuLoNQQN6Srga8taFTd3jc35mtvHP7qUXJQ4abCFiJ45sU79Mbvrl5IadtoJS+TA/MBUaKCTkEHKAByMZ3ynAGKIVUHEzS3VjrpB7tbOeybe/fbIVoZ5Dlh1TyqW/JMqkyQL9a+aeD15/bsfvPJLtTMFHxlgTdUgkWz7THfNgJTUlBr4FcJ8qAzG+9TceX1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WDsbDaBG2InMsXavwTS4Po4W0I2lVyCdy86DuhKznM=;
 b=WAVBHzGbJ+eVBANkvXVtpnAFDlGBktgvFH7U/48VJknX7u7GbWkaW81COiBAU1O7shFWMA+z+i0MJ2xdbacequoU3CD6SDosDKgQeLQm/MKJxTSuGhRahswzj9oKZucMTiy1KtI4gbUlLRU2EUIY2yQMgR1dFO7mWFhr9EzxvKnJhrDlxDzne50LS50ZY1tqp9Y5HDbxl29b41yK/M1LylCzHE2Tc+aAPQ98qW7ySHueGAJf7z5+ynEfLxQJgRJ4mY69HVG0N/0O8THvs7+HXEziTMlYxdO3LpDyJvwP+PBpfBafOQEIzTqvUYAXkJQS8XkiVJEwfy3tpBtxOScetQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 02:55:55 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:55:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Haris Iqbal <haris.iqbal@ionos.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, Hannes Reinecke <hare@suse.de>, hch
	<hch@lst.de>, Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
	<javier@javigon.com>, "willy@infradead.org" <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHcm5X3JV2Wg40sGEa2ESr3cOMLpbV+sd+AgAHNaQCAA8rNAIAMTMYAgAI2fAA=
Date: Wed, 25 Feb 2026 02:55:54 +0000
Message-ID: <7b168caf-805c-4002-9101-fda54cf8fbaf@nvidia.com>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
 <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
In-Reply-To: <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8988:EE_
x-ms-office365-filtering-correlation-id: 4abdbfd7-5cd8-4f49-533e-08de741964f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDEwVVpPLy9OaUpSQi9wZFE1eFF0M1pWWmJ6dVpTTHBHeGRoWHNLUlM0RnZI?=
 =?utf-8?B?WWl6N0NiZVArM203TkgvdjFvTWNjLzlXL1BkOW9GeDkzUHBOa1lrYzVWTHZ3?=
 =?utf-8?B?NWR0SHA2Qy9qYTlJYnhISWwzV1JIaDNqMExoaGNBdUJnT3lPQTRIelQ3Y3lx?=
 =?utf-8?B?VkJuTTduVDFGeFZxa2VRZnhaazZwRzRrbkdmdTFEODZQaC92ZGZPWEsrQU5w?=
 =?utf-8?B?bDJxVzJJRUtXeWUyQjVyK1lyc0RIWnhHYnZhTzVLRGdXbjU0Z2dGYWQ1cW11?=
 =?utf-8?B?cmE1OU1jK0hsVTZTK2lFajQwR1lLZGk2V0s0eGlnbklVSFE3WlAyV1p0aDdF?=
 =?utf-8?B?ZmFMZFdTK2k1OHY5aityc1hhNU1mTFlFeVNJU0hyTk1PMXNsWXBXZkNXcUtp?=
 =?utf-8?B?RjJnRWU4aklPRGdwNWkwWTQvZlVDSDl3QlAvOWdXSnVZTTRaU1doVGJXbU5r?=
 =?utf-8?B?QzkyejNSV3BsWCtqM1hkYTRRMEhzYitlOFBDUGo3T0FqQnIxRkFpOSt5SXVN?=
 =?utf-8?B?RkRNR1g0L1czODdSTE5iOHdvVjEwa2dFdmtnT0t4U3gvbmtsQzhYbTlJM2dW?=
 =?utf-8?B?R0paRlorVW1acjhGYm9KUGhwVFllNFVIdkVkYk1VMGpHWUx4UE1FYUJiTlhh?=
 =?utf-8?B?OTJsNVMrREMybHNCQjN5QUFNZUprMC8vZ1daam8vM2pOeUhqNGRhQVhFVGdj?=
 =?utf-8?B?VDJldEY5ZTU2ZG45R0h0Y0poQmtucnl6MUtTSkEzYjhtNkE5dGFnQjcwVXVE?=
 =?utf-8?B?Wmk0TEwzVUxKdE5jZXRtM0owTEJacHpSb25GbVV2YjllbndqbkYrSWEybGFW?=
 =?utf-8?B?K1U4YWtTc1IreDBDSHFYcXBqTUxEaWdhUDQySnYrUWZkcW9zdzJRbXZuY0JT?=
 =?utf-8?B?WTNxVWJkWUpnUkJ3MTF6WCtDSndyMjhDd0pzQmV6ZTVhdTRQcG1rQlJSeGhL?=
 =?utf-8?B?Tk5kYkQ0TS9GOWo4L1hJNUJtVmJ1ZEszbklaOHhzZXZ0UVZzRWxKVUFhdVd1?=
 =?utf-8?B?RmN4YkpZK0ZmYnVkMG5GWWtLRU13ejZXY1JkbUxpcENTOGhHUmpOOXZDSHds?=
 =?utf-8?B?c1ZaamN0RS8ySnJHcXhKYjlEMS9ITVR0ZjQ1RFU3NEJYNnNEVUNqSmxnK3NM?=
 =?utf-8?B?d2JDYVJlUUQ0Qm55MEpVMVYwYTQ5Y1pRMEhNblk1K0J4MThETjdaZitHOHhE?=
 =?utf-8?B?a28zMTR2Y08vZ1IwUnh3VFRxUkZZaDJuT29aMUFYRGZhdEtqZ0RPdFlsVjZs?=
 =?utf-8?B?OVdsQXNlaU8raFV0aFE4SVpZMUNiTk5PT2dZdkhTQVNqa0FGZTJiTWdmaU84?=
 =?utf-8?B?UWtYRDMyRWdYcVc3dWJyY1hXVWVpbndxOWtHaEV0cGo0UUFOK2ZoL2EyWjlM?=
 =?utf-8?B?SjhuTXU4VE9STnd5R0V1WGVEaDJmWkFCNlA0TnVBZWVQa1ZMOFlzeFpucGZH?=
 =?utf-8?B?cjdUUHErWXdmQWlHYXJhSlZERzQzZ0M1ZisrMDAwcDhaQnhuVExCZG9KRlNR?=
 =?utf-8?B?M01vdGU1bmhrck1qUXJ2b0VSS2VIRkMzR0ZxSU9qc3Y4YUM2czdPS2YzTE1K?=
 =?utf-8?B?bDJEaXh6VmpEaVVJQmNEQldtVHVnWk40RUJmdWlmeWdWT3lkYkpnMkRPQXdX?=
 =?utf-8?B?NnhWQ2g5QjkwMU5uYkJNaDdPRG9GM2pFT1FSSmFDTGdQeWlpeU5UNXY2RXdu?=
 =?utf-8?B?U3NBQlFTZ0RXQmkxYXh2eGdtSE9ybnBTRkRUZ2t4UHI0OFR4LzJKNThpN0hh?=
 =?utf-8?B?cmFVUEF2MmF1YTJDMWsvcUVlUlF5eHRiMlNWaFBhVTdCUkdlMUNLVUFGSmpH?=
 =?utf-8?B?S2VQWW9TdDlGZ3JCUEpTZHd4dkNtci9SZ2d3RVpxZVVXek9GRWtDS3I0bVNT?=
 =?utf-8?B?K2UzSklscnZvQVlvRTNTT0l5L3Q5M3JMWVZlZjV1ekt2bnFzVklzQnBBTEY2?=
 =?utf-8?B?WndoaUxqeFI4aFNUa1YvbEMvemU4eDl0VUZCYngwcVhra0RXY1hxSXVCdk9l?=
 =?utf-8?B?bEdLRW4zUkUxa0ZVR0lwc0pyMzBSTnhwb0haOGhrT053UGtKSnRUS1FmWlBE?=
 =?utf-8?B?TlJpWGtGK1JqREMzTE1TdEEzOFRpblNMejRVc1B1NExrK2JmdDk1UE9lcUNr?=
 =?utf-8?B?VFc2SzlCTHpZbnJFODFkbkEzWjZYM1FnSEFuWGVzZWZCcnZhU01KTGVPTml1?=
 =?utf-8?Q?V7lrnuH1BdyoeAPmEpdXDfE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFh4em94TFlMT3dQNGRFMlNzTjBGbWlWS1IxbFAxQWh2R2pTZ2pDRG1HdWh4?=
 =?utf-8?B?S2R0RUdaTjVMMG8wVDIraFpNaEVvSmxyOGtZeHRkdWtoVzFHWHBFVUFYUXZu?=
 =?utf-8?B?cGRqSmNYSENiYzBDNVBRWnUxa1JZOTNId0NGRzZBOTRQeUJOaE0vMG5aWXJ1?=
 =?utf-8?B?ZERJcWdjbGNDdzBLQVJnUkdGUlYzUzEzUkRiSXpEeWd0WEZFVFVVeVA3akYz?=
 =?utf-8?B?WHZWdnM2YlpVY0hVK3Q3a3JOeHp3eW9UK3paTXROM3hBYWFwb2xBM2xXY0d5?=
 =?utf-8?B?MnRoTU02T3kwVUlEZ2M1aG1BNWtGbEZ0ZThvdUZLT3YzS3N0TFg1dEV5bmZU?=
 =?utf-8?B?M3BWS1RmNjJubEtZZHh3QlhlYTN3OFNaWDhtcnNwemJjVTFzeGFkUGhrQmxH?=
 =?utf-8?B?YThSMGlJaWZTQUFnZzFqZ3hrMkxlc2tNTjNaUGo1ODFJRG9rQmJIeGsxTldH?=
 =?utf-8?B?bld6YWlpSmdMT2EwQWRVVTEwVDZHcDBuQW9lNWYxbzNvbnpsNzJvSHY5bkJG?=
 =?utf-8?B?eGwySVlnVU85VzU1bW9CQWgwSWJHUjZMdTArajI5alNxdmo3ZDRYbURFNDds?=
 =?utf-8?B?a3F1OVBjTkZZVkxCTHJQL1YyRWwrdnVRZUgwV1c4MFJGUVJ3bDFKc3RxNklF?=
 =?utf-8?B?VnpuMHZScE5QeWoxRm5TeGZPdTFadVphU1Z1bFV3MmlDdFE5VVVudStHK1lk?=
 =?utf-8?B?YkN5V2tHM2NlQkh3alY0Nk9iY2JSVHhSMmh3b05NNVdnU2JqRXo1RUIrVTlO?=
 =?utf-8?B?eUsxZEVqalI2UXJDOW1OZ0pGVXRMS24vc0xyaU5CNmxzMElidmEyWDBGTUVy?=
 =?utf-8?B?b0hSdHlSSkdyZzk2NHNnbU1mcnhrczljOUI2aEhmUW9YVmdFZkhDUTBpdEQy?=
 =?utf-8?B?UlAzVmhuZE1FZDRla2d2SDRLNVhkZG51ZEl6Uko2azVuRkR1RTlZSDY5WkQ2?=
 =?utf-8?B?UzlFQWVhaTA5MDVzNHlUWGROWkZjc0QyRXhMeUFBbnlaK2d5ZDVmWFVCRU1q?=
 =?utf-8?B?SlVOYnFTNHkvZlVOTDdvYVB0QmJTUWxVdy9WVmxnNGZkc3FmdGZWRTVGTUVW?=
 =?utf-8?B?MGdaVC9VM1k4eHB0U2EyR1lzQjZsamh0OEZCV2c1anVaOWZZejd6WUd3WVNL?=
 =?utf-8?B?SjlwZjBYdkNqVmlGVitQOVFBRFVHSEhmOWdpMlJ2cU1ub25oYnpVZjcySUcr?=
 =?utf-8?B?Sm5LSDB3bDBHNk1adFdSRkNiRWZ5R3pCeG5Ddm1DbWw5RTRwak1yL0lOUkRR?=
 =?utf-8?B?U0hxZFlEbEVUVmd6cnBXaTJMcC9aNWtURjhDaytqSFpFZkhtTnhGVHZqRVNl?=
 =?utf-8?B?Wk5jNEVjODIrREJGT00rOGlBMG5IQWhmZlJHSy9jbU56aHVaZU1PV210WFRC?=
 =?utf-8?B?bzhWNVlaUUpFbDkvcXgwTmJzK09PNU9sUjY3SGVKYXFtalN6NUp2OXMyb2Vz?=
 =?utf-8?B?ZDVSeFhUbmtqajBDSSszbHlIdWpidXNzbFBZYlNidWlGZ2hEZXJOS25Qc09N?=
 =?utf-8?B?ckRrTURmcGM1ZWlHMDR3a3VPNXhWQWo2Z0dEeVpjcERSb1BWZnZDMXlpNnlx?=
 =?utf-8?B?THd1TldQWXdLK3pNRTFERnhkZFVXSk9PbEJQbzlnUm1ZWlZtZkptMnE5Skhk?=
 =?utf-8?B?MDBmcndJNjhWV1U1OStibG5MbFpFQmtJR0gvSmlKMEVIMXVhSzBDUnBIMVps?=
 =?utf-8?B?QmZBUTBCcERvYm9kWVJtcW1QN3dhZEZIQmtKNFZQZmw1V01SQ21YK3lDdWNp?=
 =?utf-8?B?ZElHR1VMUTBRZVNpV1RVbmtHMXhLM0xjTHNSNitab1ZXbG9Pb2ljdC96U1hp?=
 =?utf-8?B?SnRsNW8rQW45TFhhTitwN0hBR3B5WHlXV3EwNVlnWHFBM1h3M2dLRExmait5?=
 =?utf-8?B?RE9ObEdTY28zTjZyN2pBUjZzcGpvbTdSNXpaUHZjUlV4bWIrQ25OcDBHUFhD?=
 =?utf-8?B?bk1JUVFya1krUWFOQVBvQnFYVDNWQ0prbFAwaWljMFFtRDBuMUhaTnFpNGJ2?=
 =?utf-8?B?MmxFdE9pbDVEYlJLUm1jaUppWk9YY0ZJSTNBbVhEY0hWM0RUQUtXaXJHL0xD?=
 =?utf-8?B?Ky84OWpaYlB4QkQ4YlJmNFc1d0RHaGRHSjkrdjRGS2dLa2thQlZPNUxrN3dw?=
 =?utf-8?B?TmRjdTJFWjBWWWl0akxhclNLOHZiMDB5Q2dpSEtHUGdSNVFvSEFuWkdITVRS?=
 =?utf-8?B?a2FNZ0ZsdDhybG4rMVZTNFJqU3FEQ1l5L290ZFBaT2pFQ05TdE1RZGFkd0hN?=
 =?utf-8?B?N1FSRC9pQzRNc1ZtZndUZzllenBwdDBCNDhkbDVTZ1dxTkZqU3B3cEliNVVL?=
 =?utf-8?B?dFVkdVRKd2grSWlIOGdRamh6ckFGeE5XMktzWEFMU295Yk9LN1F1VGxDMkNY?=
 =?utf-8?Q?JYeAkzbAtpfqfBIv4r8trEbSuBdc1lER3n9QsUfgeZ0/3?=
x-ms-exchange-antispam-messagedata-1: U0ilQDhok1/Gxw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA1E5570AF0A1241B23057BF8307A3DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abdbfd7-5cd8-4f49-533e-08de741964f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:55:54.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVTS0idlBUnk6KqreZN9hby4xwcSp+Akxp04SIkb4PxfpkmvycLHpUlL26a0ULJuwPNn4xgiW/XaXGxu1dI+YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-78336-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,lst.de,kernel.dk,grimberg.me,mit.edu,wdc.com,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanyak@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8E01191132
X-Rspamd-Action: no action

T24gMi8yMy8yNiAwOTowOCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBPbiAyLzE1LzI2IDE6
MTggUE0sIEhhcmlzIElxYmFsIHdyb3RlOg0KPj4gQSBwb3NzaWJsZSBmZWF0dXJlIGZvciBibGt0
ZXN0IGNvdWxkIGJlIGludGVncmF0aW9uIHdpdGggc29tZXRoaW5nDQo+PiBsaWtlIHZpcnRtZS1u
Zy4NCj4+IFJ1bm5pbmcgb24gVk0gY2FuIGJlIHZlcnNhdGlsZSBhbmQgZmFzdC4gVGhlIHJ1biBj
YW4gYmUgbWFkZSBwYXJhbGxlbA0KPj4gdG9vLCBieSBzcGF3bmluZyBtdWx0aXBsZSBWTXMgc2lt
dWx0YW5lb3VzbHkuDQo+IEhtbSAuLi4gdGhpcyBwcm9iYWJseSB3b3VsZCBicmVhayB0ZXN0cyB0
aGF0IG1lYXN1cmUgcGVyZm9ybWFuY2UgYW5kDQo+IGFsc28gdGVzdHMgdGhhdCBtb2RpZnkgZGF0
YSBvciByZXNlcnZhdGlvbnMgb2YgYSBwaHlzaWNhbCBzdG9yYWdlDQo+IGRldmljZS4NCj4NCj4g
QmFydC4NCg0KV2UgY2FuIGFsd2F5cyBtYWtlIGEgZmxhZyBhbmQgbWFrZSB0ZXN0IHRoYXQgYXJl
IHBhcmFsbGVsIGNvbXBhdGlibGUgPw0Kc28gd2UgZG9uJ3QgaGF2ZSB0byBmb3IgdGhlIHBhcmFs
bGVsIGV4ZWN1dGlvbiBieSBkZWZhdWx0Lg0KDQpXRFlUID8NCg0KLWNrDQoNCg0K

