Return-Path: <linux-fsdevel+bounces-77256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJF0B+5lkmnstgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 01:33:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7E14076F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 01:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3C230131DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 00:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205B25E469;
	Mon, 16 Feb 2026 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ieHF7/uI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3B61FFE;
	Mon, 16 Feb 2026 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771202016; cv=fail; b=sgG/bRg486ywj8pOHQnvPqpR0U7ThH4t2Ok5uInDfZkEKp1rSEZDLDwoJSguVbGSnd4vtL0Zl+5PM6HTrD/ipInPj3i8fgDKQpxKVx4tG0jQUA0rNBWdFXlzUWrgQLn2BDKhVUAZr9eOBY7lgfbr6HQ3wlnQmVYteR0KFs0cy6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771202016; c=relaxed/simple;
	bh=guwNUz14O9bZU/Yyab1bKw3ktcSn7kyFu87VyGVwIio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1H+jaGIihBV1HUasuoxANg07/raZZ5ka1COXPS9YGuGLaYeehEU9vgg00hs+KPws+26Yfj7K8JW3RDJ7uNdM2ynNanQ1hdBvHaFocnajs5aGgiapWaTMmSKnnFmzTvPWtQqvZGZmYnkM13+sX80V3G8d4ZBZaCzHJe7EIolRH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ieHF7/uI; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8aYoh4Rvv///Y0Zg8C8kVKR9wnlRVVBSLmDMo2l/c/5NQkasPIpRVvyr3vvlKwK7BA8ePxUNnpYs4pBPkCEE3v0NhYen7Bx2uTjZr0cuXs7NZlQEY54ar08AGj6BIeCp0H1F6cA3vPKpfotdNwaU9u1Z/gUSUY5Z+hI0AdwK2AjG21gl/X+hS5wQMU/+A9PuRtVRA5LnbJ2FcLuZP2nqWytW4REFg4HRrZsK6jwjJW6eaxk5wGVlzia3mO7QT9zbrnBkKtW7vrvp6y7S4cyG/XN4whCNZSYmETvyCIVA+dU6A4Ey2zNcoArtO6Cgvyb1andSWRt70RVCkqo20lUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guwNUz14O9bZU/Yyab1bKw3ktcSn7kyFu87VyGVwIio=;
 b=iVtkpnw9+pKZlwFdPib3wmTIN7yDgtDh6c8vfKItQ2RA6Hgz1lOdiy1kAQX2Ep523A9zMy4U5rJV+SXfevi9ghIEDQtxuwdVsdo0We/w3DQL1IrbqbPtzL+KxsYRoUiQXXg59gq8eNPLOAUTHamsRR4cHFb85XfDmSNlff2NydJmTe85+9SZwOXj9ui+ZkB5rh5tqYVe2rGimiHtzGS82Juy0tiddgZhKj7ALu1cvlLPYgR5npKeVLYONK2mqgrJopYGt5Eq9+8SccZLLMdbHgJbPvdCKXwDObUgRIIXsXRV03PPYO6Pv47dfCdAlZZOFTufe25sJFI6j58NtVMupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guwNUz14O9bZU/Yyab1bKw3ktcSn7kyFu87VyGVwIio=;
 b=ieHF7/uI5D6LATb9ACOiIgYy+QjkilyvxAcw3HWYwGG3aFlYmocWq5BFvp7pZh0IiEHBfxGNnUvuJ9/KMZWijBWHgMefL+hR8acVtCsZTOZFrQY/tXc42ILVwU+LJ7haAnG8L0KbisJs37qqIwFb2LAYn/KuQtQAjOYKD+TkAHQnGyHKCy6iUCSmqYAaZ1FtH8JyiehXHnLaAZ8lRcdPdMFIMTs3pWpnq1LxUOfebKSih/r+TQVDU7ZgB6rir7ld8urcthDx38GeGulUGIJu2DXocXZpthZQRQFElEnAbjkvEgypgDDBfmvigg33J+HH1AFermucMB2C1vCEmVAmCg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 00:33:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 00:33:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Haris Iqbal <haris.iqbal@ionos.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu"
	<tytso@mit.edu>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian
 Brauner <brauner@kernel.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
	<javier@javigon.com>, "willy@infradead.org" <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHcm5X3JV2Wg40sGEa2ESr3cOMLpbV+sd+AgAHNaQCAA8rNAIAANn4A
Date: Mon, 16 Feb 2026 00:33:30 +0000
Message-ID: <69b62b16-0d56-4bcd-bdfc-b53e8d90a8d0@nvidia.com>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
In-Reply-To:
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7216:EE_
x-ms-office365-filtering-correlation-id: caf470f8-585d-4ea0-8142-08de6cf3028c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3FUbUhEbkVFTG9aWnoycW1hWEdDdlZMQ0xBWEl5dWxzOFhJR2JKUzNzWEZk?=
 =?utf-8?B?QTJjY1VRdHFiQlhlYy9TVjZlV3V6YVNlbFlwZmoxekRCR1hTbURZckZjYUx1?=
 =?utf-8?B?NFlEQnhsRzE0Ulo0c3NRT0ZsSFVVUysvQnlGQ2VjNTdmRlovZ0hLUE1ocmdR?=
 =?utf-8?B?YjIvOHI3aC9yeWtjNVh4UTFubnkrdWFXWjYvdnVJZXd6QzFFZ0lNM3ZhR0JJ?=
 =?utf-8?B?eEpsVFVJNDlabmFtN3oyVXRqREVscUpvdG5DUFFIUjBrNWVwTStydldIejV2?=
 =?utf-8?B?SWozRmxoeWw2cmRYNEIzbENaNUZpRWt3MHg1VlFrdXg2YUV4ZThRNTdUZzg4?=
 =?utf-8?B?NWRpVHNrVlNFQUcyTnRRcGZkT28wRGV2WFNZUUs1bGkxZlNiSStxWmlmSVlI?=
 =?utf-8?B?NUg3d3ZYL2JtK1NSTWN2UXMvUCt0cUFuUEEyUHgzZ2JaWEFTekhUMk10Slkx?=
 =?utf-8?B?c3lGQkVsR3phWDd6dERtRVdleXVvT0Jiak0xYVBXSDEyTFlSbVF1Q2VUTDNG?=
 =?utf-8?B?bDlsT2E1MndJeEZhbE1hdEFvb2tmczIwU24rcEswRkpFNFpkbGNGemlnWW9a?=
 =?utf-8?B?Skg5R1hRUnNpOVBZRGJZbEZQSEFEVW1vS3ZQVW0zRHYzVHZLL3ptZkRkWTZK?=
 =?utf-8?B?cVJXY292Mi94NU1zUnNRQ2lJMWoreTFzMGhXemRyTTlldmR2WlZkbnVNTWNR?=
 =?utf-8?B?M3VybWRrZFA1azIzUkFBMXRhZEQxRTZ5aWtQbi80TXVROVkxREpmdTk2d3E4?=
 =?utf-8?B?R1lmbTZqdW4zd292dEhCTnYxbmRhMVdKWkRmaFJwS2VuTDdSakhEV2ZSWFRt?=
 =?utf-8?B?a1R0KzlpNnhUbFJIa21MR045a2Y2U2xuTjV4eldsSi9RLzVlNUd5YVdWZ2Rk?=
 =?utf-8?B?THAwbG81ZTZXaU1aZE9hYnE3UWRFTXMzR0lDVkFId21tUTUrMTRvM1RaNmZj?=
 =?utf-8?B?LzltRTZzOExsbHhMcy9samRrNW5aNGt0Qlh4NGc2WFAwM0ltRWUvSDlMVWIv?=
 =?utf-8?B?K2dhVGxiS3oyemFjaHJLWDIwUk1jVWFqdEJuUGQ5NGtUb3U0RWNVdUprTmw3?=
 =?utf-8?B?MkVMcGhnbi9nUjcvNkdtelZuZTAvZkhDZDBNaXBzeVRQcEdWUWJMajBWM3N5?=
 =?utf-8?B?Z254endyWDgxTHRON0F1Z0dLUnZBRnRHQWxQenFzQ3QwTFlmZHM3Q2Z6bWdu?=
 =?utf-8?B?UCtjU2pGRXhNUkZQMlMvYjBjKzUzeHBJU2oxdW8yUDloQitlN1hvZFNKay95?=
 =?utf-8?B?ejYwQWVUWlpSbUtrOUwwQlNnNWtQRHdhTVRuZndTVU1ESXhXS2dHY1ErVy9i?=
 =?utf-8?B?TWkxOHFkeGg2Njh2RDltWUkrcnVYTDBvT0RpRkpnRkgrUHYyNnNDdHlSRU1n?=
 =?utf-8?B?OHJ2N0cyakhKMThIeExHcS9ESGRzNXp3VEduaXptblhUbWQ2aDFUMzdSMitn?=
 =?utf-8?B?Z3pGcURIUytXMEJrZmd3VjVBUWtsR2lKMUkrZHZoSGg0OEJ1dFRMd0xYL3BR?=
 =?utf-8?B?cFk5ZDBrU2ZBeFp1NTdxWHVpLzRZbnNGL1hCOG84V0tkWjR3b3Y0cHphVVBZ?=
 =?utf-8?B?ZWwzeGVKTTRNeDN0SjJXOHk4ai9HVGtGZjA2c24yckhjTm1XWnlrcXpFL0x0?=
 =?utf-8?B?K25NK3hLQU5TYUlaVldwT2IrVGgyeitMSlQvRTcvM1lBQTV2aHZROUcvbnRG?=
 =?utf-8?B?QUEyNk92bDFSLzdmUDdqKzRNclIzeTRLTEE4V2hGZGZPYVg2c0VLU0IvMW00?=
 =?utf-8?B?WW1VNGdUS2hUNEloUEVBVnRZeTQxWUpicEpRRGpKMTYydm5UZHJwTWNNdyt1?=
 =?utf-8?B?dlJReHZXTmYwZlNtL3FYTWczVCttMlBDU3hVOGNtN0xiS3ZHVHRIZW1lZ00z?=
 =?utf-8?B?Qm43UGlyL3pGekxwcDZrb2duYlJWb1BYVmwrakd1ZkUwTm0xOE9lcDJsWmJ2?=
 =?utf-8?B?bitENldYQ25teTExYVZNekNrdWNGSnlxL1d2a1dqU29vMWtTeFliUjB5M3Zu?=
 =?utf-8?B?L00wdnFrY3V6SUp0MWs4dXhuREc5K1JORFFwY2JRWDAyUVVxemFPdVJVdWd2?=
 =?utf-8?B?ZlNmM1A2YWFkNGlyNkxJSzQ4dG5sYzl4RDlxaUNDZk1welVuY1hiNjg5S0Iy?=
 =?utf-8?B?TU9Bb2RhUldKaStzRGNTTkRwRGJmYTdlV2xhVC9FK3V4QTFZTkYvTEUyeDVD?=
 =?utf-8?Q?l+a3CaLRzWiC8p30Xd3HCq4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVYwVlRMUVBRL3pnR0FZZHZIRnNIa2JxYnRQbHEzMjdma1Vqb1RIcHl0K1RI?=
 =?utf-8?B?YXFkQU40d2lFV0llc2Q2UmdFSjJOeUpia1F6WEJDZ3lkY09YMkZPbWRvb1Rp?=
 =?utf-8?B?MzNEUXcrWUZyNjZLY2JLTEhaaFd4NnNEU2pTNFJwcDBTTjlWbm9PbEkvSWxz?=
 =?utf-8?B?Y1lDRCtQV0JMWlc1VndoSStkYjZPdklrd012bUtHY3lrYi96OElYWjcwYU5q?=
 =?utf-8?B?S011N3QrOHlBVFk3aG5LUHFNUnBMVkdjRGdPUFFlZWkxekNiUXNsNGNrMW1R?=
 =?utf-8?B?V3BITC9LWmROVlN5NGF6MFdFbkpCS1FKd3FIQXpRaEhGTTdoVEQ5dGpwZCtH?=
 =?utf-8?B?bTJJSlBSNUxjMWxJOE4xaFpETUNuYTA1SWxuaHNVNkI0elA5M2ZjMUw3dVNY?=
 =?utf-8?B?V3FQTnZqenNMSjJhQm1EcnZmdUdKWHZSa2wvWHc2UmljNjdheXFaMmpDMDRO?=
 =?utf-8?B?WmFUdndGN2hOdkZ4dVAyb0RyYkZOSG9BVmZsT3RYRVpPNVdZdFoxcG5xMEhB?=
 =?utf-8?B?Vk5MNk0xMVd1WDRKWjlKLzBDVmlmZDNtVFhKdmZUdS8vdXFSaGtuZkdNMzVH?=
 =?utf-8?B?T2Vray82NkoxUjF6M0FsaHl1ckEwZFU3K0t1TEtoMjZwK2VGM3MvbUtHalkz?=
 =?utf-8?B?Z2EwbmdBTWNRN2Y0Mm1GaDdRWE5lR2tJS2Q4d21FbWdmWXJyZFBDM0xvY3Zk?=
 =?utf-8?B?Kzl6elIwWkpRMzlBSUkwUzQ0ZnU0MGYyYllJeDU4YUtUMmxnMmRZeXpQUk1B?=
 =?utf-8?B?YWN5Um9Iem1wNnpwY04yZlFoNFo1dllXRzVxNXhXTzdOcUVuZm9hdlVHYStX?=
 =?utf-8?B?UUFmY0E5eGRVNEJIWU51RzRpdlVYNUl4eDIrN0VkazNGWnRRRWd5TjdpSHJq?=
 =?utf-8?B?UWczU3FyeUt6MFVuajFLeUNqWWFraWk5S1BmalpHQmN6RzM2d0ozV1NVc21a?=
 =?utf-8?B?N0c3ZGxJV2NkaHBLcytiMWZhVHF4YnNqSStqZTlSRmZtc0NrTkJ6SDd0SkQ4?=
 =?utf-8?B?NThwOUo2Wms1Q2RxVllub1Q3RkpIZVFFM1NTSy81dU9Rbkt0dWh6dUJ0S1Ur?=
 =?utf-8?B?QjZVUmNFL0tWV2pWWWptMFRZdXM2cGNhK1RteXEwbmlVclBhUFc4S2FiN2ow?=
 =?utf-8?B?RUJiTzVlNnY4Y2ZlYSs1ZzRvVFlNSEw4N2J0blk5aXIrQURaUjVVekJKQnpy?=
 =?utf-8?B?b2E5TEdhUUMwTUUzTTVYclgxZDB2VVNrWHFFZVdOa3BtcEZYZGZCSmdQeWNa?=
 =?utf-8?B?RGJjeUpmZ1pLdTd3R2djYko1aEh0NXBDSU1jYUdjRldNSUhuSFp0MWFYaXZP?=
 =?utf-8?B?bTVUK0RDOHczNVhURm9mMEtndkhhODdVUGJCSHpJSktoakNnYm5RcG9VRGpI?=
 =?utf-8?B?aHF1eXhjR1hsd2Y0dUlNVTY3TE9vL21TNnFTaWx0K0ZVRElDVUhlc3hzRHA3?=
 =?utf-8?B?OGZ5dGdHMjl0WmdYbEFxSnkxOU1BbDBUSWk4UWZEM3dyVVd3ak5xZzdwMW0v?=
 =?utf-8?B?bjYxaUt2TU5WYzZEUFV5V2J5KzJLSE9yZldPR1U2VHhzSjkwaGcxZVdibG9Z?=
 =?utf-8?B?NEN0U2FTdjVTcTRMUkZONXQ4cjVGZjRKNzMydUhCRXFya1NvNHlOZkpTNnk3?=
 =?utf-8?B?cXdQWlBKQno1RnFJZnEvNEJXdllOUkMrZHVPT1BMQ3RMVHpjMWJrQW1yM0FJ?=
 =?utf-8?B?SVlhdm54MFZiWnMvdmtMWVNxd3h6ZnpETldjWmFKRUo3bUIwcnpwVGFBWW9N?=
 =?utf-8?B?a0d5S0t3SmpRcktJb2NFQ1FTU3lkNkN6MTdnencxb1VhQm12V2FpSm1rdjVy?=
 =?utf-8?B?cGQ1cFJTUlZlUENwU1hlL3lETytTTVgzRjEyaU9scG5sTzh2V05ORWh4TjJo?=
 =?utf-8?B?Nm8wRDd2TlVTV3NLV2EvQUpYWEIvN3ZBSm9wUlRUVjh0V2tsakU4NVdiaWF4?=
 =?utf-8?B?OURHMjRCWkZxc0FBREJhRUJYOW50SkFVOTRXUFowVzBQalU4czhhL3NZZFJj?=
 =?utf-8?B?TzZGWkxaQnVCUEg1ajNJd2tSSnZwS05mRDNaL3huMWwyRzUwbTliZWNBbDhp?=
 =?utf-8?B?UW1zM1lEYWhOVC9mU25WbEZDdTZDL1JHVlBRZ0NEVXd3WU0vNG9KQ3dQMi9y?=
 =?utf-8?B?K1RYcWU2TXJuWmo4ejVzejMxQ0NJZVdXdTgyUnZmdWR4UHJTV3JHQ3pJcnp5?=
 =?utf-8?B?RUlhbXNTSVJMZXYxeXVudG8xMFYzdi8wa2huaE00MisxWllZckJQakRWeXNP?=
 =?utf-8?B?K1lVdkFGZklTbGxVYldQMWsyOThuVmJvRTVnNWNPODBOcEtjbWNBZWNzUllh?=
 =?utf-8?B?K04xbkJoTUVtejJyYjM1WFM3ckhwOWZmRHVEalh5NEgzZjlMOU9VQkt0OXpx?=
 =?utf-8?Q?gYuQDwRMkzgo9xRKhalvZl7PDnsagan5iHd7kAqkLbi/T?=
x-ms-exchange-antispam-messagedata-1: 8m5m0oC4kUjmWg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <82BBB5108674764EB1F239E75280FEC6@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: caf470f8-585d-4ea0-8142-08de6cf3028c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 00:33:30.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzpFWkVHuSsR0rUDgZvozYODpTdJFMJx5cUuau8Fi5JjurTOci+AoTZtZUTkp2qa3C/UDUsAPHVgjkXI0sT5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77256-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,acm.org,lst.de,kernel.dk,grimberg.me,mit.edu,wdc.com,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanyak@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: ADD7E14076F
X-Rspamd-Action: no action

T24gMi8xNS8yNiAxMzoxOCwgSGFyaXMgSXFiYWwgd3JvdGU6DQo+IE9uIEZyaSwgRmViIDEzLCAy
MDI2IGF0IDEyOjI14oCvUE0gU2hpbmljaGlybyBLYXdhc2FraQ0KPiA8c2hpbmljaGlyby5rYXdh
c2FraUB3ZGMuY29tPiB3cm90ZToNCj4+IE9uIEZlYiAxMiwgMjAyNiAvIDA4OjUyLCBEYW5pZWwg
V2FnbmVyIHdyb3RlOg0KPj4+IE9uIFdlZCwgRmViIDExLCAyMDI2IGF0IDA4OjM1OjMwUE0gKzAw
MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4gICAgIEZvciB0aGUgc3RvcmFnZSB0
cmFjayBhdCBMU0ZNTUJQRjIwMjYsIEkgcHJvcG9zZSBhIHNlc3Npb24gZGVkaWNhdGVkIHRvDQo+
Pj4+ICAgICBibGt0ZXN0cyB0byBkaXNjdXNzIGV4cGFuc2lvbiBwbGFuIGFuZCBDSSBpbnRlZ3Jh
dGlvbiBwcm9ncmVzcy4NCj4+PiBUaGFua3MgZm9yIHByb3Bvc2luZyB0aGlzIHRvcGljLg0KPj4g
Q2hhaXRhbnlhLCBteSB0aGFuayBhbHNvIGdvZXMgdG8geW91Lg0KPj4NCj4+PiBKdXN0IGEgZmV3
IHJhbmRvbSB0b3BpY3Mgd2hpY2ggY29tZSB0byBtaW5kIHdlIGNvdWxkIGRpc2N1c3M6DQo+Pj4N
Cj4+PiAtIGJsa3Rlc3RzIGhhcyBnYWluIGEgYml0IG9mIHRyYWN0aW9uIGFuZCBzb21lIGZvbGtz
IHJ1biBvbiByZWd1bGFyDQo+Pj4gICAgYmFzaXMgdGhlc2UgdGVzdHMuIENhbiB3ZSBnYXRoZXIg
ZmVlZGJhY2sgZnJvbSB0aGVtLCB3aGF0IGlzIHdvcmtpbmcNCj4+PiAgICBnb29kLCB3aGF0IGlz
IG5vdD8gQXJlIHRoZXJlIGZlYXR1cmUgd2lzaGVzPw0KPj4gR29vZCB0b3BpYywgSSBhbHNvIHdv
dWxkIGxpa2UgdG8gaGVhciBhYm91dCBpdC4NCj4+DQo+PiBGWUksIGZyb20gdGhlIHBhc3QgTFNG
TU0gc2Vzc2lvbnMgYW5kIGhhbGx3YXkgdGFsa3MsIG1ham9yIGZlZWRiYWNrcyBJIGhhZA0KPj4g
cmVjZWl2ZWQgYXJlIHRoZXNlIHR3bzoNCj4+DQo+PiAgIDEuIGJsa3Rlc3RzIENJIGluZnJhIGxv
b2tzIG1pc3NpbmcgKG90aGVyIHRoYW4gQ0tJIGJ5IFJlZGhhdCkNCj4+ICAgICAgLT4gU29tZSBh
Y3Rpdml0aWVzIGFyZSBvbmdvaW5nIHRvIHN0YXJ0IGJsa3Rlc3RzIENJIHNlcnZpY2UuDQo+PiAg
ICAgICAgIEkgaG9wZSB0aGUgc3RhdHVzIGFyZSBzaGFyZWQgYXQgdGhlIHNlc3Npb24uDQo+Pg0K
Pj4gICAyLiBibGt0ZXN0cyBhcmUgcmF0aGVyIGRpZmZpY3VsdCB0byBzdGFydCB1c2luZyBmb3Ig
c29tZSBuZXcgdXNlcnMNCj4+ICAgICAgLT4gSSB0aGluayBjb25maWcgZXhhbXBsZSBpcyBkZW1h
bmRlZCwgc28gdGhhdCBuZXcgdXNlcnMgY2FuDQo+PiAgICAgICAgIGp1c3QgY29weSBpdCB0byBz
dGFydCB0aGUgZmlyc3QgcnVuLCBhbmQgdW5kZXJzdGFuZCB0aGUNCj4+ICAgICAgICAgY29uZmln
IG9wdGlvbnMgZWFzaWx5Lg0KPj4NCj4+PiAtIERvIHdlIG5lZWQgc29tZSBzb3J0IG9mIGNvbmZp
Z3VyYXRpb24gdG9vbCB3aGljaCBhbGxvd3MgdG8gc2V0dXAgYQ0KPj4+ICAgIGNvbmZpZz8gSSdk
IHN0aWxsIGhhdmUgYSBUT0RPIHRvIHByb3ZpZGUgYSBjb25maWcgZXhhbXBsZSB3aXRoIGFsbA0K
Pj4+ICAgIGtub2JzIHdoaWNoIGluZmx1ZW5jZSBibGt0ZXN0cywgYnV0IEkgd29uZGVyIGlmIHdl
IHNob3VsZCBnbyBhIHN0ZXANCj4+PiAgICBmdXJ0aGVyIGhlcmUsIGUuZy4gc29tZXRoaW5nIGxp
a2Uga2Rldm9wcyBoYXM/DQo+PiBEbyB5b3UgbWVhbiB0aGUgIm1ha2UgbWVudWNvbmZpZyIgc3R5
bGU/IE1vc3Qgb2YgdGhlIGJsa3Rlc3RzIHVzZXJzIGFyZQ0KPj4gZmFtaWxpYXIgd2l0aCBtZW51
Y29uZmlnLCBzbyB0aGF0IHdvdWxkIGJlIGFuIGlkZWEuIElmIHVzZXJzIHJlYWxseSB3YW50DQo+
PiBpdCwgd2UgY2FuIHRoaW5rIG9mIGl0LiBJTU8sIGJsa3Rlc3RzIHN0aWxsIGRvIG5vdCBoYXZl
IHNvIG1hbnkgb3B0aW9ucywNCj4+IHRoZW4gY29uZmlnLmV4YW1wbGUgd291bGQgYmUgc2ltcGxl
ciBhbmQgbW9yZSBhcHByb3ByaWF0ZSwgcHJvYmFibHkuDQo+Pg0KPj4+IC0gV2hpY2ggYXJlYSBk
byB3ZSBsYWNrIHRlc3RzPyBTaG91bGQgd2UganVzdCBhZGQgYW4gaW5pdGlhbCBzaW1wbGUNCj4+
PiAgICB0ZXN0cyBmb3IgdGhlIG1pc3NpbmcgYXJlYXMsIHNvIHRoZSBiYXNpYyBpbmZyYSBpcyB0
aGVyZSBhbmQgdGh1cw0KPj4+ICAgIGxvd2VyaW5nIHRoZSBiYXIgZm9yIGFkZGluZyBuZXcgdGVz
dHM/DQo+PiBUbyBpZGVudGlmeSB0aGUgdW5jb3ZlcmVkIGFyZWEsIEkgdGhpbmsgY29kZSBjb3Zl
cmFnZSB3aWxsIGJlIHVzZWZ1bC4gQSBmZXcNCj4+IHllYXJzIGFnbywgSSBtZWFzdXJlZCBpdCBh
bmQgc2hhcmVkIGluIExTRk1NLCBidXQgdGhhdCBtZWFzdXJlbWVudCB3YXMgZG9uZSBmb3INCj4+
IGVhY2ggc291cmNlIHRyZWUgZGlyZWN0b3J5LiBUaGUgY292ZXJhZ2UgcmF0aW8gYnkgc291cmNl
IGZpbGUgd2lsbCBiZSBtb3JlDQo+PiBoZWxwZnVsIHRvIGlkZW50aWZ5IHRoZSBtaXNzaW5nIGFy
ZWEuIEkgZG9uJ3QgaGF2ZSB0aW1lIHNsb3QgdG8gbWVhc3VyZSBpdCwNCj4+IHNvIGlmIGFueW9u
ZSBjYW4gZG8gaXQgYW5kIHNoYXJlIHRoZSByZXN1bHQsIGl0IHdpbGwgYmUgYXBwcmVjaWF0ZWQu
IE9uY2Ugd2UNCj4+IGtub3cgdGhlIG1pc3NpbmcgYXJlYXMsIGl0IHNvdW5kcyBhIGdvb2QgaWRl
YSB0byBhZGQgaW5pdGlhbCBzYW1wbGVzIGZvciBlYWNoDQo+PiBvZiB0aGUgYXJlYXMuDQo+Pg0K
Pj4+IC0gVGhlIHJlY2VudCBhZGRpdGlvbiBvZiBrbWVtbGVhayBzaG93cyBpdCdzIGEgZ3JlYXQg
aWRlYSB0byBlbmFibGUgbW9yZQ0KPj4+ICAgIG9mIHRoZSBrZXJuZWwgdGVzdCBpbmZyYXN0cnVj
dHVyZSB3aGVuIHJ1bm5pbmcgdGhlIHRlc3RzLg0KPj4gQ29tcGxldGVseSBhZ3JlZWQuDQo+Pg0K
Pj4+ICAgIEFyZSB0aGVyZSBtb3JlIHN1Y2ggdGhpbmdzIHdlIGNvdWxkL3Nob3VsZCBlbmFibGU/
DQo+PiBJJ20gYWxzbyBpbnRlcmVzdGVkIGluIHRoaXMgcXVlc3Rpb24g8J+Zgg0KPj4NCj4+PiAt
IEkgd291bGQgbGlrZSB0byBoZWFyIGZyb20gU2hpbidpY2hpcm8gaWYgaGUgaXMgaGFwcHkgaG93
IHRoaW5ncw0KPj4+ICAgIGFyZSBnb2luZz8g8J+Zgg0KPj4gTW9yZSBpbXBvcnRhbnRseSwgSSB3
b3VsZCBsaWtlIHRvIGxpc3RlbiB0byB2b2ljZXMgZnJvbSBzdG9yYWdlIHN1Yi1zeXN0ZW0NCj4+
IGRldmVsb3BlcnMgdG8gc2VlIGlmIHRoZXkgYXJlIGhhcHB5IG9yIG5vdCwgZXNwZWNpYWxseSB0
aGUgbWFpbnRhaW5lcnMuDQo+Pg0KPj4gIEZyb20gbXkgdmlldywgYmxrdGVzdHMga2VlcCBvbiBm
aW5kaW5nIGtlcm5lbCBidWdzLiBJIHRoaW5rIGl0IGRlbW9uc3RyYXRlcyB0aGUNCj4+IHZhbHVl
IG9mIHRoaXMgY29tbXVuaXR5IGVmZm9ydCwgYW5kIEknbSBoYXBweSBhYm91dCBpdC4gU2FpZCB0
aGF0LCBJIGZpbmQgd2hhdA0KPj4gYmxrdGVzdHMgY2FuIGltcHJvdmUgbW9yZSwgb2YgY291cnNl
LiBIZXJlIEkgc2hhcmUgdGhlIGxpc3Qgb2YgaW1wcm92ZW1lbnQNCj4+IG9wcG9ydHVuaXRpZXMg
ZnJvbSBteSB2aWV3IHBvaW50IChJIGFscmVhZHkgbWVudGlvbmVkIHRoZSBmaXJzdCB0aHJlZSBp
dGVtcykuDQo+IEEgcG9zc2libGUgZmVhdHVyZSBmb3IgYmxrdGVzdCBjb3VsZCBiZSBpbnRlZ3Jh
dGlvbiB3aXRoIHNvbWV0aGluZw0KPiBsaWtlIHZpcnRtZS1uZy4NCj4gUnVubmluZyBvbiBWTSBj
YW4gYmUgdmVyc2F0aWxlIGFuZCBmYXN0LiBUaGUgcnVuIGNhbiBiZSBtYWRlIHBhcmFsbGVsDQo+
IHRvbywgYnkgc3Bhd25pbmcgbXVsdGlwbGUgVk1zIHNpbXVsdGFuZW91c2x5Lg0KDQpUaGlzIGlz
IG15IGdvYWwgYW5kIEkgaGFkIHByb3Bvc2VkIHRoaXMgdG9waWMgZmV3IHllYXJkIGJhY2sNCnRv
IGhhdmUgYmxrdGVzdHMgaW50ZWdyYXRlZCB3aXRoIFZNLiBJJ3ZlIHNwZW50IHNvbWV0aW1lIG9u
IGEgaW5pdGlhbA0Kc2V0dXAgYnV0IG5ldmVyIGdvdCBpdCB0byBmaW5pc2ggaXQuDQoNCklmIHNv
bWVvbmUgaXMgd29ya2luZyBvbiBpdCBJJ2xsIGJlIGhhcHB5IHRvIGhlbHAgYW5kIHJldmlldyBh
bHNvIHRlc3QgdGhlDQppbXBsZW1lbnRhdGlvbi4NCg0KLWNrDQoNCg0K

