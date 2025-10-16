Return-Path: <linux-fsdevel+bounces-64397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6DCBE59DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFD834EA647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011512E54A9;
	Thu, 16 Oct 2025 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="C1C3udTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6F2E0916
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651660; cv=fail; b=b4ijL/z/AYmcrtEoZUKgApoWqTF7y64+w0PK+/MYL1gC9fE3Zd+cPZjDZS3uucpwk66YTFyYg4ou0lwbrtr8sAPtGu0JW5eySFhwyLF18QbL16qCkG5VUBGQfggqKx7B5OvRZFGnmGp3PVQoOUPzNDoG49/F+U62bMUmTTcEIpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651660; c=relaxed/simple;
	bh=6CGrbZslgS6O19QqMn2MEwjrQ1+BvkHaskmF8ayLEPE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bXmkQMqbOsVcGwKVSw0B9yC0q8mH/aTSPjEu+39Shh/MPXrYl7nNw7aAjJWWG2VxXwsNuqquugA/lLbRudlm0MP5IbnFp954lRNcBJsjoqNUkNmAvJa6v6VvO95JVuq0pht47lXimYjcNW82fj5EGjqOHS4davlvBuIOMpR4Izk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=C1C3udTv; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020087.outbound.protection.outlook.com [52.101.61.87]) by mx-outbound23-3.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 16 Oct 2025 21:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVFLK2Utj7WXmkzn1tExM6NACgHBVX0nxdj4HWWHzQg+fkXXzRsui6x23SUqFVqklzLAIJa6aHo3n1IJ7CNuH+tGyvWV1sfX/X8nRdW2/KN3362Jj3JSpOhuLQz6VZJtmkQuZ0KcGyZOeMI9qQU8z7++34b7a+9QkgtSZgOmPpVjKZRI0ZtrUHgQauf2Tn73S1yPNxt/GGiR/vjtBD4IMlLzIaN4UPR+tWo0CELrfq1qJsM+IzcyrPoro3RYk8M8fk6djXRBlvmPUNyXcPIbUk9EY0bPizi+2Juc903ycJUuDXnUs5x8uf+AryA+uT5G6PIaf+w55EWYI5H4NQnh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CGrbZslgS6O19QqMn2MEwjrQ1+BvkHaskmF8ayLEPE=;
 b=ljygJwh0RVTtVF6Zukq1IEALb0R5kuJxQaOtgUptaJbqiT9qfspu8LR9APvOZHYqeG83+OozV5vM9RUoNdWrzqGkeuPWOnd8XcZxunoVWF7SnGlTFAP0TSJcYJLGRe9gKGXdsRVEAnPTrPT5DPooB03LBfHBBTMoMag2PnRV6tc4YYdBbcvkGYs8rmHz/2wlJpMcaePBcduxy4oPMnubV9d2u1PST6VZxddHUEvBp7ft07f49gNfPFUvqeo0Hfm6pDZCabEtMaY4yDOBpIGMUt4Mxx1j2wpqUhp1SYx8is3PWqjw0gF8RM/EKqBTHeKODV0Mlr5PZAvUwimyPklC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CGrbZslgS6O19QqMn2MEwjrQ1+BvkHaskmF8ayLEPE=;
 b=C1C3udTvZUGIgmguYOlvffNWXXrmp9/7XlCN9yjBk9msvlpAfbm/VSeWmJC3JKvd7+ocqdyd9IPozN9pCz0nPP8fVg9uOdVXUD/poolZkbZQzqofiq7ug+qMRgDW5xRbAqvrBRrJzZnoGewOoMeZ5HoszGFBLKxUh5B+WBGzDhg=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SJ0PR19MB5446.namprd19.prod.outlook.com (2603:10b6:a03:3da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 21:53:48 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 21:53:48 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Luis
 Henriques <luis@igalia.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
Thread-Topic: [PATCH v2] fuse: Wake requests on the same cpu
Thread-Index:
 AQHcPO/nbyrTRFPZK0ucXvW1McZpVLTCRdCAgAERdQCAAHJpgIAAsnOAgAAAl4CAALwBgIAAHBmA
Date: Thu, 16 Oct 2025 21:53:47 +0000
Message-ID: <90ecb50a-926b-45f1-b047-95e07f2e6e6f@ddn.com>
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
 <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
 <CAJnrk1b9xVqmDY9kgDjPpjs7zuXNbiNaQnMyvY0iJirJbHi1yw@mail.gmail.com>
 <20251016085813.GB3245006@noisy.programming.kicks-ass.net>
 <20251016090019.GH4068168@noisy.programming.kicks-ass.net>
 <CAJnrk1aoPZj6KWKhBhPSASs-kgWDxipfY3MjPDBtG4v-zay3rg@mail.gmail.com>
In-Reply-To:
 <CAJnrk1aoPZj6KWKhBhPSASs-kgWDxipfY3MjPDBtG4v-zay3rg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SJ0PR19MB5446:EE_
x-ms-office365-filtering-correlation-id: 54dac7dd-dc77-4b77-ef09-08de0cfe7c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzVvblZ3MXB6ekJVNkRVUTBTSUxNVjgzaTRnbk9WbWR0Qjl1dEg2c3ZaVFpJ?=
 =?utf-8?B?QUwyak1NTGxNN0c0VFFpTVNIVjJiOUxROS9BMzdOWTZQb1VBMnVZcnVpdGI2?=
 =?utf-8?B?akRxSmFpYlFSNUdlNy9OMGpuZHh1aUx2Q3grRW0vRS9jMEpWeEZQbDJ2dldU?=
 =?utf-8?B?SXV2NFI0eC8wQlN3V0JzL0hsOVUxVEdPeTRNMUUwUENCQThOa05rNFZHcDkv?=
 =?utf-8?B?OS9iRnZ2SEJsa1dUNnZlN1Q5bWhwbG1FbXBmSm0xTlBKUURvaExEZXZQTWJs?=
 =?utf-8?B?YWY0MFpkRWdja29TQmNZWXplV3VLMmx4QWxuYnpDNUFwLy82K2tVcnBncDl0?=
 =?utf-8?B?Q2NoM0dqM2E5b3lDZXluQnZOVzBnenprcTBMRm12Rk9sS0pRVXVRTXpYQkhy?=
 =?utf-8?B?RWt3MUxxUkZ0NGZQbXZMdEI4eXFCYWU3Q3l4TDFLOTFKOGNTd0o1QVNDSnZz?=
 =?utf-8?B?QmpTWVF2bnoyQS9OTExrYlllUjgxbjZEZDd5SnFTS3p0Y0wrR25ldTdubFpJ?=
 =?utf-8?B?cEZ5VnIraDRXRTdvSmxEWnlyK1JnZHczRnZJZDFQWW01T2s5VkMzNHYwMENr?=
 =?utf-8?B?ZHlNM3BJV20zUlBwOEVKUVZJcHI1Wkg2ZjN5Y1RSc0o5U1NabkdrRVA2bFg5?=
 =?utf-8?B?aHFsdEVuNTZ4YlY2VGt0aGpmZ3ZjL0wrSmg0Rk56OTE3cE53akU5U2JFTUVr?=
 =?utf-8?B?WnV3TEZHaHl4OUFwMzFQSFBHZU1keVhUOHJ0RnNLRTBEeVEwUHJrQUpEd0FI?=
 =?utf-8?B?OWdleXluM0dLSk9XVmdLMVUyQ3BWUlJpdHBJcEtiS0lxb2FybUM2T3ZmZHp4?=
 =?utf-8?B?U3VzS3M3ZzN3MlJTZ0VXVDZ5SVpYVTMyc0hBMEdONUZrQXRuNnN6V0REMndr?=
 =?utf-8?B?SzIrNGd1ckphNndCTkw3WCsrWFVtTnVHN2hldDRMV0N6TGJsQmN5QjU0aWRo?=
 =?utf-8?B?K29wT1hac1Fua0JJVlRNQjMyazhwSVczUzNPekY2R0htcEVaVE00bHRkVVJF?=
 =?utf-8?B?cDBRWEtYaG5tSGlISWwyRUtxQkt2SFVkN2NIc1cxK29xbjNsbkFLaTZybTAv?=
 =?utf-8?B?cDlRa3ltK2hGNzlYVnJMZ0RDSmZFMWVpOXFsMVFYY2dqajZCclBrYm83Tkor?=
 =?utf-8?B?dytZYzY4RWZ1K0JDTVc1Rm5SVEYrNitEMEczTGpTeDN2WkdKbXE5NTREUlk0?=
 =?utf-8?B?Z3ZNaWFUR2Z3c0thV0lZM1NZQS9CQnh2UTZSQklUN0txbGRpWVR1U0YzM21m?=
 =?utf-8?B?Qm9CMDVlYzFhaVlPUm1sdTZNL0tweERmTHhzZDVzRU5UWWxOU0JSZktmWHJ6?=
 =?utf-8?B?VENISVdFUkQ3amFSYmpaVHZjbjAwckpTQjZZVFpmVzJMQUM2dWJNZnNobGxB?=
 =?utf-8?B?T3J2S1FqRjQ3NE9BRWNxbUZYeXVjaUJVRkVxMXZCVzNRL0FRUGFlYkllcWcz?=
 =?utf-8?B?Z053Z283ZU9DaXVyNTkzcld3bkczY0poZjIySCtjUXNEOGxYNmtJZERTNHhl?=
 =?utf-8?B?bkxLRXBIOURZaEFRVkUwcWtyclo1OTZzbTV2R2M4dFl2dFI2WmtmUDhjK0o0?=
 =?utf-8?B?bUJncG9xWndnaFFDcHpLS2tmc2pLOElqVWtsQVhwUHZsNXlzYjBCeGtadHg2?=
 =?utf-8?B?VUV3eFo0Vm5PVkRxOGt0YjFlSWxmQXp4UmVrNXNhTXpnK1NpbHh0ZERyU0E1?=
 =?utf-8?B?bGtoSTlLeDJmVDkvdWR1YmZIbXBSM0hhcDluRFJKaWFmVUhobWNlRzE1VUg5?=
 =?utf-8?B?UHVVb0QrbURyMjJmb1ZrdGVtRDdvZUNKamVBYnFEVUlmOFFRUGxPQU1LUnpP?=
 =?utf-8?B?bUNldlhkdXJia1k5Tit6WVFHb2Yyb3AyL1BPeThMM0gybitIOHRhTXRrRmhG?=
 =?utf-8?B?V3o5WCtrcmlEVEFmbUQ5RFVnMmVUUzM5VE9vTlFCTnZoUU96c3lreTZEbHp2?=
 =?utf-8?B?cXUybGVBN01lY2Yrbk9yRXRqejVubVFXNE9rWEh6bGVjQ093UjIyWTZsOEd0?=
 =?utf-8?B?VDV4Y3RuMm1vUEhQSW9rWm56U0JoSmdEcHFwRjc4bm5yZTduZ3o3SWsvWWhv?=
 =?utf-8?Q?MshTxO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3BwWHpuNzRrSGJiVHNwZXZCYnNmZ0xTVm1SVCs4NDY4Nzd3OTFWUXdyOS8y?=
 =?utf-8?B?ZG1EbmNQMjkrTDZZTUdFNGtSakRGUmZqQ1FoTXFXMGJZejZCelJmL1oxMHp1?=
 =?utf-8?B?NnZpSlh6L2szczhlUUZleEw4RkI4TUU3NnJrN3owU3VmZWxpaDREZWtLbldW?=
 =?utf-8?B?Q3MzM004OW5pNmRjeVIrZEwwQldYUFZ6SUhTV3Q3Uk9ra2hpcXJYaUdzR2gv?=
 =?utf-8?B?aENyZ0o0THlzZUk0aFplZDZ0WUw2RzNBNi9YSVhrbm9MdnFXd1IzQmFUZlBQ?=
 =?utf-8?B?OXhXMjB2R3NaQXUxZEZxRlFHT3c0eXVPV2lXSmVIUlBWaXJPRUMwcllkYzR4?=
 =?utf-8?B?d3BHd21SMkRQQU1iZ1Z0ekhqR0t3WGQ0eFFINStwaXJ0NzhqaERqejRiSFpy?=
 =?utf-8?B?bStnRDZhQnErWDNoVG1YOVZ6U1ZqN0lFYUoyTDUrN3MreTNyQi9xOGJkZVpD?=
 =?utf-8?B?Tjg2bzNzaHBXVFF1MnFhQnFOU3FtZ0NVTXVBUE5UQlYwYnEyWVROL1M4THpl?=
 =?utf-8?B?R1hldnd0azR5VlZXUDQvS1JJTXJONjcyYVNkVEFoOXdCTWdCUWtZWFdYWmhj?=
 =?utf-8?B?bzgrWWQ4SGNBcHEreTRMUUZqcG9kSkNkQUdLcEhLNEFocjJlcWRJWXNwNlNw?=
 =?utf-8?B?cTMweEZPdUszS0NpN2l4K3VNT0Q5NzI1V0plenRqbFUyMDBycjJiSFNwL1Vi?=
 =?utf-8?B?aE5mRjAyQUpmNS9hMnJIckRCTXZZVkdwUnlJS0VTZjhDMDhUUU5TRElRT3pW?=
 =?utf-8?B?TVJpdkEvblRrcXBIaDlyY2R2c2E0a3puVjQxNHZRU1E5dmp3OHdpRUszSWQ1?=
 =?utf-8?B?MVlJTXNBellvbDlaYXdvbkRnVDd2bmFlL1EzRE1KdUtwbEptZzZJU3lQNS9Z?=
 =?utf-8?B?aTRwd3FUTmg5amhtWGU4ejJzQklQZm5QVkNIalM1TWVmcG9RZzNkRkYyR3BP?=
 =?utf-8?B?blJWTGRGVFNvSXdJTE1qWkZqVjBIUUJ1RUlSMWlka2dxREx2czc3c0JBNzJu?=
 =?utf-8?B?NGo4R0NMVFRXd1Y5RkxtWnVkeDFiajZXQjlWa2E2YjQzMHhLdmtYa2xWT0Vl?=
 =?utf-8?B?dHdlM01rN1MxbVJ4SG5tY2VTSG5zeldEbFVxbVZzd3g2b0xNTFR6emFpNnM5?=
 =?utf-8?B?RFhmSlZObVoya3JGMXJUa0UwTUYxRVZYTnRXL2R3dkVGQjdKNXhRU1ZXK095?=
 =?utf-8?B?NzFDQkZwY0NxVHdnQ0Y5RkdkdkV2MnUxclRVd1VVK3Y0UXpKVzBZOUszeGRo?=
 =?utf-8?B?Wnk0ZnA1RWVGL0ZQUDJOZFJPaklFNkQzb2hlSU1vOFI1eWlNUlRWUjZ3aUtM?=
 =?utf-8?B?bmNwb3RhUGhrc1FpR3I3dmgxY2FuRWdlZDFYQkhMMDNsWTJjUU05U1VEUzZo?=
 =?utf-8?B?QkdwKzdSS0xERHJpUG1nSGxHTG5WREwreExTVys0M0ZiUjlML2Rmb3c1VFR2?=
 =?utf-8?B?TlRlQXdndWpRZFhaQ3cvTXF5NTZad013UlR4U1NkN0tqTHV3WFNkNUs1OWlT?=
 =?utf-8?B?b0tObkNCYnlpSEhUWlhpOE83Y1lSMm9NWkhLU1FmZ2J5bTJnS1ArcTlKa0VP?=
 =?utf-8?B?ZlRWYnZIKzgwYVdnNjdaUXVCbEo0cFhxaDlYVTlwZHR1NDVFczQrRWhPMnR0?=
 =?utf-8?B?eDdUcXNkMzk2bE1ZOVNSeGgwMHZrUzFQV2xITDVTd2MzNytEWUloQVAvam55?=
 =?utf-8?B?SGd3R1ptSnhmRTFIb3NXSW5yL1ZDdEZHMHhPa3lOS0JhYWhxZGR1aFg0bmVL?=
 =?utf-8?B?Mm1GK25mSTZmOElPbTBEdTVCaUJaaFAvVnI2Ni9mWFI0b3NMN1YrbHFnUkZS?=
 =?utf-8?B?YVVlQzh2ZHVQVC8wQWVQQ29RYnFZS2pKdjY5QzdHS0lSYldEdjladDBxakNr?=
 =?utf-8?B?WWNHVEJjQXR5cFhUQzJuTVc4QzBvMncyK1lKMlZzRjZiV3lCdjFlcys3NHEx?=
 =?utf-8?B?TGo0N0doVTFtY2RwOWJ1UGJtTm50RWk0N3l2eFN5YkpLUEx0K1J4SGRaRjZn?=
 =?utf-8?B?UVRqYVVDdzNKUGNQOEk4bWRpRGE3TitVWmkyOWZqYmxjd01WQTF6WHozbjdj?=
 =?utf-8?B?elVCQUdmYjA1WU9xWXdzSFZPWldwN1ZyRUNvR3pRUStUMHlPR2ZXcVlTZnFk?=
 =?utf-8?B?d1daV2ZSejdnUktybjcxWGlxRS9BbnM3NEtzUHR1d2IvbXZhckIzY3oveTRu?=
 =?utf-8?Q?AEI1PUKL1VuRp9RyoE9n4Iw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC8702E8E4946444820A67BCAA4BFD77@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8xsfFe0fveRFeJt/La+b8GkCPGmN11VydLpa0sr4IWjFTwlkdMM85fVG0L6vY9qVr1Jv1kL1Kb8FGzaYV7XGHQzokgMtDTZd1K3VFf6xWtacxFAu7KiVUg7VdFOv5BgxX3BgIG1319cfmafX2uoYGiv6Q1xUCiHTX1l47zXlNFTbpzbcyU71ECUyiaJXosRUYHV/1WMPMkyzeq2cFDccKkj6TOQ/1tbsD4ENEdBztIteL0bhXat0AnOWw9f/WswjuaacYsSjgRvYQ36MYb6JWHy0ZSfiVFGmaoyGmhLEkrECROPYMVd8Bml+pXHbnXbIzseVihRVKPkrdyxW6SJd71Oda9nLQ0LUKqYKZBWy+bCeU0ACb0CbU4D7JctuRe4Z52tbs01Wa19ylHP2Y1WKB998WQJyLXP+9/9lC88Eg2q6p8hNGEHbLH4hUjFzMRsLrYFqOYRzbExhIhcq+euUJT42YFT28WICYLJnA41VEJ11eVTKEqcYkjXVYHE2ED3u6sUEhjqGXRTgT7xFK/IcAuyTNfy4olWkqXS4+XM/G2/OpAEhj8om2F0XVolKaIdIHULNzStPfZ89lYyzSV2OvC5D21HbYnizIEqMub7CBdrm9fNhf670cjZdAIYWP2riG9y0Or37LPy9K50bE6+WUQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dac7dd-dc77-4b77-ef09-08de0cfe7c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 21:53:47.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dv5C3MN46Hl7aEvZflMCcSxbgjcPGQNkliURwmpTFYBUjO754fge71NH4xAif19/yx3skX0BvpKwl8hgSVpJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5446
X-BESS-ID: 1760651630-105891-11837-10955-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.61.87
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbGliZAVgZQ0NzYINnUJDnF2M
	QiKdXAOMUs1cIk1TQt0cjcKDE1ydhCqTYWAI5b29BBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268259 [from 
	cloudscan21-84.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMTYvMjUgMjI6MTMsIEpvYW5uZSBLb29uZyB3cm90ZToNCj4gT24gVGh1LCBPY3QgMTYs
IDIwMjUgYXQgMjowMOKAr0FNIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4g
d3JvdGU6DQo+Pg0KPj4gT24gVGh1LCBPY3QgMTYsIDIwMjUgYXQgMTA6NTg6MTRBTSArMDIwMCwg
UGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4gT24gV2VkLCBPY3QgMTUsIDIwMjUgYXQgMDM6MTk6
MzFQTSAtMDcwMCwgSm9hbm5lIEtvb25nIHdyb3RlOg0KPj4+DQo+Pj4+Pj4gV29uJ3QgdGhpcyBs
b3NlIGNhY2hlIGxvY2FsaXR5IGZvciBhbGwgdGhlIG90aGVyIGRhdGEgdGhhdCBpcyBpbiB0aGUN
Cj4+Pj4+PiBjbGllbnQgdGhyZWFkJ3MgY2FjaGUgb24gdGhlIHByZXZpb3VzIENQVT8gSXQgc2Vl
bXMgdG8gbWUgbGlrZSBvbg0KPj4+Pj4+IGF2ZXJhZ2UgdGhpcyB3b3VsZCBiZSBhIGNvc3RsaWVy
IG1pc3Mgb3ZlcmFsbD8gV2hhdCBhcmUgeW91ciB0aG91Z2h0cw0KPj4+Pj4+IG9uIHRoaXM/DQo+
Pj4+Pg0KPj4+Pj4gU28gYXMgaW4gdGhlIGludHJvZHVjdGlvbiwgd2hpY2ggYjQgbWFkZSBhICct
LS0nIGNvbW1lbnQgYmVsb3csDQo+Pj4+PiBpbml0aWFsbHkgSSB0aG91Z2h0IHRoaXMgc2hvdWxk
IGJlIGEgY29uZGl0aW9uYWwgb24gcXVldWUtcGVyLWNvcmUuDQo+Pj4+PiBXaXRoIHF1ZXVlLXBl
ci1jb3JlIGl0IHNob3VsZCBiZSBlYXN5IHRvIGV4cGxhaW4sIEkgdGhpbmsuDQo+Pj4+Pg0KPj4+
Pj4gQXBwIHN1Ym1pdHMgcmVxdWVzdCBvbiBjb3JlLVgsIHdhaXRzL3NsZWVwcywgcmVxdWVzdCBn
ZXRzIGhhbmRsZSBvbg0KPj4+Pj4gY29yZS1YIGJ5IHF1ZXVlLVguDQo+Pj4+PiBJZiB0aGVyZSBh
cmUgbW9yZSBhcHBsaWNhdGlvbnMgcnVubmluZyBvbiB0aGlzIGNvcmUsIHRoZXkNCj4+Pj4+IGdl
dCBsaWtlbHkgcmUtc2NoZWR1bGVkIHRvIGFub3RoZXIgY29yZSwgYXMgdGhlIGxpYmZ1c2UgcXVl
dWUgdGhyZWFkIGlzDQo+Pj4+PiBjb3JlIGJvdW5kLiBJZiBvdGhlciBhcHBsaWNhdGlvbnMgZG9u
J3QgZ2V0IHJlLXNjaGVkdWxlZCBlaXRoZXIgdGhlDQo+Pj4+PiBlbnRpcmUgc3lzdGVtIGlzIG92
ZXJsb2FkZWQgb3Igc29tZW9uZSBzZXRzIG1hbnVhbCBhcHBsaWNhdGlvbiBjb3JlDQo+Pj4+PiBh
ZmZpbml0eSAtIHdlIGNhbid0IGRvIG11Y2ggYWJvdXQgdGhhdCBpbiBlaXRoZXIgY2FzZS4gV2l0
aA0KPj4+Pj4gcXVldWUtcGVyLWNvcmUgdGhlcmUgaXMgYWxzbyBubyBkZWJhdGUgYWJvdXQgInBy
ZXZpb3VzIENQVSIuDQo+Pj4+PiBXb3JzZSBpcyBhY3R1YWxseSBzY2hlZHVsZXIgYmVoYXZpb3Ig
aGVyZSwgYWx0aG91Z2ggdGhlIHJpbmcgdGhyZWFkDQo+Pj4+PiBpdHNlbGYgZ29lcyB0byBzbGVl
cCBzb29uIGVub3VnaC4gQXBwbGljYXRpb24gZ2V0cyBzdGlsbCBxdWl0ZSBvZnRlbg0KPj4+Pj4g
cmUtc2NoZWR1bGVkIHRvIGFub3RoZXIgY29yZS4gV2l0aG91dCB3YWtlLW9uLXNhbWUgY29yZSBi
ZWhhdmlvciBpcw0KPj4+Pj4gZXZlbiB3b3JzZSBhbmQgaXQganVtcHMgYWNyb3NzIGFsbCB0aGUg
dGltZS4gTm90IGdvb2QgZm9yIENQVSBjYWNoZS4uLg0KPj4+Pg0KPj4+PiBNYXliZSB0aGlzIGlz
IGEgbGFjayBvZiBteSB1bmRlcnN0YW5kaW5nIG9mIHNjaGVkdWxlciBpbnRlcm5hbHMsICBidXQN
Cj4+Pj4gSSdtIGhhdmluZyBhIGhhcmQgdGltZSBzZWVpbmcgd2hhdCB0aGUgYmVuZWZpdCBvZg0K
Pj4+PiB3YWtlX3VwX29uX2N1cnJlbnRfY3B1KCkgaXMgb3ZlciB3YWtlX3VwKCkgZm9yIHRoZSBx
dWV1ZS1wZXItY29yZQ0KPj4+PiBjYXNlLg0KPj4+Pg0KPj4+PiBBcyBJIHVuZGVyc3RhbmQgaXQs
IHdpdGggd2FrZV91cCgpIHRoZSBzY2hlZHVsZXIgYWxyZWFkeSB3aWxsIHRyeSB0bw0KPj4+PiB3
YWtlIHVwIHRoZSB0aHJlYWQgYW5kIHB1dCBpdCBiYWNrIG9uIHRoZSBzYW1lIGNvcmUgdG8gbWFp
bnRhaW4gY2FjaGUNCj4+Pj4gbG9jYWxpdHksIHdoaWNoIGluIHRoaXMgY2FzZSBpcyB0aGUgc2Ft
ZSBjb3JlDQo+Pj4+ICJ3YWtlX3VwX29uX2N1cnJlbnRfY3B1KCkiIGlzIHRyeWluZyB0byBwdXQg
aXQgb24uIElmIHRoZXJlJ3MgdG9vIG11Y2gNCj4+Pj4gbG9hZCBpbWJhbGFuY2UgdGhlbiByZWdh
cmRsZXNzIG9mIHdoZXRoZXIgeW91IGNhbGwgd2FrZV91cCgpIG9yDQo+Pj4+IHdha2VfdXBfb25f
Y3VycmVudF9jcHUoKSwgdGhlIHNjaGVkdWxlciB3aWxsIG1pZ3JhdGUgdGhlIHRhc2sgdG8NCj4+
Pj4gd2hhdGV2ZXIgb3RoZXIgY29yZSBpcyBiZXR0ZXIgZm9yIGl0Lg0KPj4+Pg0KPj4+PiBTbyBJ
IGd1ZXNzIHRoZSBtYWluIGJlbmVmaXQgb2YgY2FsbGluZyB3YWtlX3VwX29uX2N1cnJlbnRfY3B1
KCkgb3Zlcg0KPj4+PiB3YWtlX3VwKCkgaXMgdGhhdCBmb3Igc2l0dWF0aW9ucyB3aGVyZSB0aGVy
ZSBpcyBvbmx5IHNvbWUgYnV0IG5vdCB0b28NCj4+Pj4gbXVjaCBsb2FkIGltYmFsYW5jZSB3ZSBm
b3JjZSB0aGUgYXBwbGljYXRpb24gdG8gcnVuIG9uIHRoZSBjdXJyZW50DQo+Pj4+IGNvcmUgZXZl
biBkZXNwaXRlIHRoZSBzY2hlZHVsZXIgdGhpbmtpbmcgaXQncyBiZXR0ZXIgZm9yIG92ZXJhbGwN
Cj4+Pj4gc3lzdGVtIGhlYWx0aCB0byBkaXN0cmlidXRlIHRoZSBsb2FkPyBJIGRvbid0IHNlZSBh
biBpc3N1ZSBpZiB0aGUNCj4+Pj4gYXBwbGljYXRpb24gdGhyZWFkIHJ1bnMgdmVyeSBicmllZmx5
IGJ1dCBpdCBzZWVtcyBtb3JlIGxpa2VseSB0aGF0IHRoZQ0KPj4+PiBhcHBsaWNhdGlvbiB0aHJl
YWQgY291bGQgYmUgd29yayBpbnRlbnNpdmUgaW4gd2hpY2ggY2FzZSBpdCBzZWVtcyBsaWtlDQo+
Pj4+IHRoZSB0aHJlYWQgd291bGQgZ2V0IG1pZ3JhdGVkIGFueXdheXMgb3IgbGVhZCB0byBtb3Jl
IGxhdGVuY3kgaW4gdGhlDQo+Pj4+IGxvbmcgdGVybSB3aXRoIHRyeWluZyB0byBjb21wZXRlIG9u
IGFuIG92ZXJsb2FkZWQgY29yZT8NCj4+Pg0KPj4+IFNvIHRoZSBzY2hlZHVsZXIgd2lsbCB0cnkg
YW5kIHdha2Ugb24gdGhlIHByZXZpb3VzIENQVSwgYnV0IGlmIHRoYXQgQ1BVDQo+Pj4gaXMgbm90
IGlkbGUgaXQgd2lsbCBsb29rIGZvciBhbnkgbm9uLWlkbGUgQ1BVIGluIHRoZSBzYW1lIEwzIGFu
ZCB2ZXJ5DQo+Pg0KPj4gVHlwaW5nIGhhcmQ6IHMvbm9uLS8vDQo+Pg0KPj4+IGFnZ3Jlc3NpdmVs
eSBtb3ZlIHRhc2tzIGFyb3VuZC4NCj4+Pg0KPj4+IE5vdGFibHkgaWYgVGFzay1BIGlzIHdha2lu
ZyBUYXNrLUIsIGFuZCBUYXNrLUEgaXMgcnVubmluZyBvbiBDUFUtMSBhbmQNCj4+PiBUYXNrLUIg
d2FzIHByZXZpb3VzbHkgcnVubmluZyBvbiBDUFUtMSwgdGhlbiB0aGUgd2FrZXVwIHdpbGwgc2Vl
IENQVS0xDQo+Pj4gaXMgbm90IGlkbGUgKGl0IGlzIHJ1bm5pbmcgVGFzay1BKSBhbmQgaXQgd2ls
bCB0cnkgYW5kIGZpbmQgYW5vdGhlciBDUFUNCj4+PiBpbiB0aGUgc2FtZSBMMy4NCj4+Pg0KPj4+
IFRoaXMgaXMgZmluZSBpZiBUYXNrLUEgY29udGludWVzIHJ1bm5pbmc7IGhvd2V2ZXIgaW4gdGhl
IGNhc2Ugd2hlcmUNCj4+PiBUYXNrLUEgaXMgZ29pbmcgdG8gc2xlZXAgcmlnaHQgYWZ0ZXIgZG9p
bmcgdGhlIHdha2V1cCwgdGhpcyBpcyBwZXJoYXBzDQo+Pj4gc3ViLW9wdGltYWwsIENQVS0xIHdp
bGwgZW5kIHVwIGlkbGUuDQo+Pj4NCj4+PiBXZSBoYXZlIHRoZSBXRl9TWU5DICh3YWtlLWZsYWcp
IHRoYXQgdHJpZXMgdG8gaW5kaWNhdGUgdGhpcyBsYXR0ZXIgY2FzZTsNCj4+PiB0cm91YmxlIGlz
LCBpdCBvZnRlbiBnZXRzIHVzZWQgd2hlcmUgaXQgc2hvdWxkIG5vdCBiZSwgaXQgaXMgdW5yZWxp
YWJsZS4NCj4+PiBUaGVyZWZvcmUgaXQgbm90IGEgc3Ryb25nIGhpbnQuDQo+Pj4NCj4+PiBUaGVu
IHdlICdyZWNlbnRseScgZ3JldyBXRl9DVVJSRU5UX0NQVSwgdGhhdCBmb3JjZXMgdGhlIHdha2V1
cCB0byB0aGUNCj4+PiBzYW1lIENQVS4gSWYgeW91IGFidXNlLCB5b3Uga2VlcCBwaWVjZXMgOi0p
DQo+Pj4NCj4+PiBTbyBpdCBhbGwgZGVwZW5kcyBhIGJpdCBvbiB0aGUgd29ya2xvYWQsIG1hY2hp
bmUgYW5kIHNpdHVhdGlvbi4NCj4+Pg0KPj4+IFNvbWUgbWFjaGluZXMgTDMgaXMgZmluZSwgc29t
ZSBtYWNoaW5lcyBMMyBoYXMgZXhjbHVzaXZlIEwyIGFuZCBpdCBodXJ0cw0KPj4+IG1vcmUgdG8g
bW92ZSB0YXNrcy4gU29tZSB3b3JrbG9hZHMgZG9uJ3QgZml0IEwyIHNvIGl0IGRvZXNuJ3QgbWF0
dGVyDQo+Pj4gYW55d2F5LiBUTDtEUiBpcyB3ZSBuZWVkIHRoaXMgZGFtbiBjcnlzdGFsIGJhbGwg
aW5zdHJ1Y3Rpb24gOi0pDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbiEgSSBmb3Vu
ZCBpdCB2ZXJ5IGhlbHBmdWwuDQo+IA0KPiBJbiBsaWdodCBvZiB0aGF0IGluZm9ybWF0aW9uLCBp
dCBzZWVtcyB0byBtZSB0aGF0IHRoZSBvcmlnaW5hbA0KPiB3YWtlX3VwKCkgd291bGQgYmUgbW9y
ZSBvcHRpbWFsIGhlcmUgdGhhbiB3YWtlX3VwX29uX2N1cnJlbnRfY3B1KCkNCj4gdGhlbi4gQWZ0
ZXIgZnVzZV9yZXF1ZXN0X2VuZCgpLCB0aGUgdGhyZWFkIHN0aWxsIGhhcyB3b3JrIHRvIGRvIHdp
dGgNCj4gZmV0Y2hpbmcgYW5kIHNlcnZpY2luZyB0aGUgbmV4dCByZXF1ZXN0cy4gSWYgaXQgd2Fr
ZXMgdXAgdGhlDQo+IGFwcGxpY2F0aW9uIG9uIGl0cyBjcHUsIHRoZW4gd2l0aCBxdWV1ZS1wZXIt
Y29yZSB0aGUgdGhyZWFkIHdvdWxkIGJlDQo+IGZvcmNlZCB0byBzbGVlcCBzaW5jZSBvbiB0aGUg
bGliZnVzZSBzaWRlIGR1cmluZyBzZXR1cCB0aGUgdGhyZWFkIGlzDQo+IHBpbm5lZCB0byB0aGUg
Y29yZSwgd2hpY2ggd291bGQgcHJldmVudCBhbnkgbWlncmF0aW9uIHdoaWxlIHRoZQ0KPiBhcHBs
aWNhdGlvbiB0YXNrIHJ1bnMuIE9yIGFtIEkgbWlzYXNzdW1pbmcgc29tZXRoaW5nIGluIHRoaXMg
YW5hbHlzaXMsDQo+IEJlcm5kPw0KDQoNCldlbGwsIHRoZSBudW1iZXJzIHNwZWFrIGEgZGlmZmVy
ZW50IGxhbmd1YWdlLiBBbmQgSSBzdGlsbCBkb24ndCBzZWUNCndoeSB3b3VsZG4ndCB3YW50IHRv
IHRha2Ugb24gdGhlIGN1cnJlbnQgQ1BVIGF0IGxlYXN0IGlmIHdlIGhhdmUNCnF1ZXVlLXBlci1j
b3JlLg0KVGhhbmtzIGEgbG90IEBQZXRlciBmb3IgdGhlIGV4cGxhbmF0aW9uLiBUbyBteSB1bmRl
cnN0YW5kaW5nIFdGX1NZTkMNCnNob3VsZCBkbyB0aGUgdHJpY2ssIGkuZS4gd2FrZSBvbiB0aGUg
c2FtZSBjb3JlLCB3aGVuIHRoZSBjdXJyZW50IHRhc2sNCmlzIGdvaW5nIHRvIHNsZWVwIGFueXdh
eSBhbmQgdGhlcmUgaXMgbm90aGluZyBlbHNlIHJ1bm5pbmcgb24gdGhhdCBjb3JlLg0KRm9yIGEg
YmxvY2tpbmcgSU8gd2l0aCBxdWV1ZS1wZXItY29yZSB0aGlzIGlzIGV4YWN0bHkgd2hhdCB3ZSBo
YXZlLg0KDQpFeGFtcGxlDQoNCisgZWNobyAnUnVubmluZzogZXhhbXBsZS9wYXNzdGhyb3VnaF9o
cCcgLW8gYWxsb3dfb3RoZXIgLS1mb3JlZ3JvdW5kIC0tbm9wYXNzdGhyb3VnaCAtbyBpb191cmlu
ZyAtbyBpb191cmluZ19ucl9xcz0yIC90bXAvc291cmNlIC90bXAvZGVzdA0KDQoNCkFuZCB0aGVu
IA0KDQpic2NodWJlcnQyQGltZXNydjMgfj5maW8gLS1kaXJlY3Rvcnk9L3RtcC9kZXN0IC0tbmFt
ZT1pb3BzLlwkam9ibnVtIC0tcnc9cmFuZHJlYWQgLS1icz00ayAtLXNpemU9MUcgLS1udW1qb2Jz
PTEgLS1pb2RlcHRoPTEgLS10aW1lX2Jhc2VkIC0tcnVudGltZT0zMHMgLS1ncm91cF9yZXBvcnRp
bmcgLS1pb2VuZ2luZT1wc3luYyAtLWRpcmVjdD0xIA0KDQoNCldpdGggV0ZfQ1VSUkVOVF9DUFU6
IFJFQUQ6IGJ3PTI2OU1pQi9zDQpXaXRoIFdGX1NZTkM6ICAgICAgICBSRUFEOiBidz0yMTRNaUIv
cw0KV2l0aCBwbGFpbiB3YWtlX3VwOiAgUkVBRDogYnc9MjE3TWlCL3MNCg0KV2l0aCBXRl9TWU5D
IGFuZCBwbGFpbiB3YWtlX3VwIEkgc2VlIGEgcGVyc2lzdGVudCBjb3JlIHN3aXRjaGluZw0Kb2Yg
dGhlIGZpbyBwcm9jZXNzIGJldHdlZW4gdHdvIGNvcmVzIG9uIG9uZSBudW1hIG5vZGUgLSBzbyBt
dWNoIA0KYWJvdXQgTDEvTDIgY3B1IGNhY2hlLg0KV2l0aCBtb3JlIGZ1c2UtaW8tdXJpbmcgcXVl
dWVzIHRoZXJlIGFsc28gd291bGQgYmUgYWRkaXRpb25hbA0Kc3dpdGNoaW5nIGZvciB0aGF0IGFu
ZCBldmVuIGxvd2VyIHBlcmYsIGJ1dCB3aXRoIG9ubHkgb25lIHF1ZXVlDQpwZXIgbnVtYSB0aGF0
IGdldHMgYSBiaXQgcmVzdHJpY3RlZC4NCg0KTXkgZ3Vlc3MgaXMgdGhhdCBXRl9TWU5DIGRvZXNu
J3QgZGV0ZWN0IHRoYXQgdGhlIGN1cnJlbnQgbGliZnVzZQ0KcmluZyB0aHJlYWQgd2lsbCBnbyB0
byBzbGVlcCBpbiB0aGUgaW9fdXJpbmdfZW50ZXIoKSBzeXN0ZW0gY2FsbA0KcmF0aGVyIHF1aWNr
bHkuDQpJIGNhbiB0cnkgdG8gZ2V0IHNvbWUgdGltZSBhbmQgZmlndXJlIG91dCB3aHkgdGhlIGZp
byBwcm9jZXNzDQpib3VuY2VzIGJldHdlZW4gdHdvIGNvcmVzLiBJIGhhZCBhbHJlYWR5IHN0YXJ0
ZWQgdG8gZnRyYWNlDQp0aGluZ3MsIGJlY2F1c2UgZXZlbiBXRl9DVVJSRU5UX0NQVSBpc24ndCBp
ZGVhbC4gQWx0aG91Z2ggdGhpcw0KZGlzY3Vzc2lvbiBoZXJlIGdvZXMgdGhlIG90aGVyIGRpcmVj
dGlvbi4NCg0KDQpUaGFua3MsDQpCZXJuZA0KDQoNCg==

