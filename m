Return-Path: <linux-fsdevel+bounces-64099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59158BD85C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 11:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 172414EA6C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459222E6CA7;
	Tue, 14 Oct 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="SUWQFowm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E891E3DED
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433168; cv=fail; b=GsxTreFULJ1gGbEE1F0j8pxnsbQ9b9m9TobswhmWoFaz58BdcOLd+47TOM2wswxQDee/iII/wDe0/OroMWDB2BnMuXC5ekkOpMinZr03Y5R5z1awSZpswPuP066bOactyE+TTjTZ8lajVOR9U/24WqFmkTSNM5f6PRkk+NUVqp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433168; c=relaxed/simple;
	bh=zwhRNY+LB96iGf4UXxMs4vyXb1kzU/uxevVSVqoOGhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRO6cQB/Veuw1EhAfG+wYHoHju3yMeJXMOjcErtad1EloUksturAEvG9fdDXq3U4+9/MrVyKDk0ewQzZqnRR8zSsvGUqub9hpNuE4kPxU4QgTwjssjtQFNF87xxZW+lqMZk7SKbLFk3kWR2k5WkzAOgJzICkR26bxNc3z570diI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=SUWQFowm; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020116.outbound.protection.outlook.com [52.101.56.116]) by mx-outbound40-59.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 14 Oct 2025 09:12:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLvRANNPkS/y33WTbz4lRg3VGh4KCd7sHWTWr5vhVSvBhDJIYhPxKjM3hc6sgHU6J5+wiBESXCu2v9Ta7FmDbvchpL7ayjZuBOtCGspmb1S2petKKHaeZNjdNtfg5tcJv/9ISbce4xBxogdnfJhRN5wtWru/nY3bt+H/75/394qMyPUjwGJp7dYIcwxE+lPnC4yImbA4wo33BKAUxph2RxEGlTFzbwh5L1sT1pdeaqVp89XIqrcRQAe0v5s5LW791WQ3M/6/Xl1MeN+1SeRl4phpvM+eHyraOwcA+085p7hpHos6WBk8fO+/kItSHCrc05XrOitkP0IW72UteIwYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwhRNY+LB96iGf4UXxMs4vyXb1kzU/uxevVSVqoOGhY=;
 b=D14YBtvwPGB6EbDTiJmYFoJ8Kl+YPHxLvQ+gMxH+Pv/iOcegrTdX3PC5R1zhuy80fWVNOeMDNYMF0bar1QMtyyi3RxvB9cX6UhIv1p3K/orDgNzRR0zZn2zuowSuCdQjCyoRbqFhQ1eYMGtdEMti7tHermC4B80jbVTBtSzvdttv+0/znLX9jnug0EiB5416P2FAl+YqCE0VAMv3LTO0ILpMdC+Sq6j438hwZLA9hvvD3mw85ITNtc121YLAHGR4302eMP/tO+l0FMn6hGjVeY9hwlENMJuJHD7/Bka1J0bTPo5NziWpklAIzDLhPbqJgy3yY8IRP02QO01a+YWIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwhRNY+LB96iGf4UXxMs4vyXb1kzU/uxevVSVqoOGhY=;
 b=SUWQFowm98xqy1KOV99MbG6eNy4wwGhdbWbaAhqFuaD4+fmZFbXhEQsFoy4O5UH9z36pF2no7iRj98Wfu9nGH2Ga/QSz3v531jRKdEKiKWh5UGo9XtjEZaTR/yei0ynXECiuwMGfOEBunGD8ZLWjsJLK8Aqpj+2za3qzTY78yCE=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by IA1PR19MB6348.namprd19.prod.outlook.com (2603:10b6:208:3e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 09:12:18 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:12:18 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Miklos Szeredi
	<miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
CC: Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fuse: Wake requests on the same cpu
Thread-Topic: [PATCH] fuse: Wake requests on the same cpu
Thread-Index: AQHcPGayUTbOYVXBAUaqYMgIHrtXsbTBPoKAgAAd9oA=
Date: Tue, 14 Oct 2025 09:12:17 +0000
Message-ID: <9a39bba7-1ffb-4dd5-adb5-bf7516578288@ddn.com>
References: <20251013-wake-same-cpu-v1-1-45d8059adde7@ddn.com>
 <f2906e44-413f-4153-a378-5a87a49298d4@wdc.com>
In-Reply-To: <f2906e44-413f-4153-a378-5a87a49298d4@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|IA1PR19MB6348:EE_
x-ms-office365-filtering-correlation-id: 7b614326-f18d-4f64-71ce-08de0b01c627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|7416014|376014|1800799024|366016|38070700021|921020|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZisvTlFFZTBKZFhYYjVDRGI0cEkvb2pXMkFuT3JheGlDQ3ROUEhuZXFlOHRK?=
 =?utf-8?B?YkF6Yis0V1lHamtxcWFzZDVWRVRBNWcxZXJWVWhQR1psQlM4d3FoWk9ZMXFs?=
 =?utf-8?B?TlhFMVhsdEZEVDU5bVFIZjlnTXRkdVVmZ0VWS0hOTGR3dWZLejl6TmtaZDhI?=
 =?utf-8?B?NnE2VjZINzFVYXJyenZveHJLeUNwTzcxTkFNbEQ3SE5PRUJRZTd4N1Fkcmlu?=
 =?utf-8?B?YWFkSlpwazJoWDY0TXA2Z1pvQmxxUERtL0E1aFVyMnU0TlE1ZEp1bnY0Si81?=
 =?utf-8?B?aFlYbEY3YWU4QUpQcDlqV05vMW1UUGdieHE5MmlKUkpWRUkyTVBzL3hIWlpU?=
 =?utf-8?B?OFZkN0lGZjdKRHFQbWZxR3JDSXVteGhyS0VoeGticFJTSTFqeUNweG5adXcy?=
 =?utf-8?B?ZmVzM3B5THlDQXN0UkpncTl4YlR5eHNtMTlDMnB0eHhTU0VQY0Q3bG5zMjJC?=
 =?utf-8?B?ZDdXL002Q2gxbjBaQnV6a3RPOEsxSnkvTnN2Mnc4eGtNQWQ4OHdlcExCWE9D?=
 =?utf-8?B?ekF0dGt5R1VpeElYZXo4M3R5UktMUmlUdDZXRFRTYmVWaHc1QWg4RHJOSXlt?=
 =?utf-8?B?N0hQUGJvNXZhQXdHUVVzTGx6bll1djBJdlZGZmVaMXhWaEhsQVZEeFQ4cnpu?=
 =?utf-8?B?L0RzMStuWDRWbzRyUmRoa2tsVFRDeVFNTnVkZWhCanRTUldua1VtQ0RGTWty?=
 =?utf-8?B?bXp0VlVMVVo4bmpoYzJRNzZ1NVdsd0JjeWFJRmh5TTVXQ0lNSHlVWFhFclZK?=
 =?utf-8?B?SG1qL3AvTFJtdlhKVC8vRzhqMklqZHhPSlB2SVhJV211b1BWSGl1YkdYcUd5?=
 =?utf-8?B?VFRTMnp3QmswSUhRdHg1QjhmU01JNzV4TzgzV1FBZ0ZlbnpYRUNkK25USGNM?=
 =?utf-8?B?aTR4dmYwTnhPWC9DYVNscjVTdStKZ0pNellkOVcvQlRycGpBalNubnpjR2lp?=
 =?utf-8?B?Q0NOVko3TGxNK1lWWmJtaVRvaHArVE0zQWhGaERDZzlobUY3MDJrRmNIT3hs?=
 =?utf-8?B?eFJPSHlGUnFrT2s5bEhTYUJhcWhBeStDc3Bzak5YMlVmMVNYWDlSSllXTXhn?=
 =?utf-8?B?Y1p4Wm9NYk9aV3F2ZjZGN1RXbGo5WWJFRzBWTzlGVkI3UVMwLys4QUxZSVYx?=
 =?utf-8?B?R0E1R0k1VElqWE1KZmpQUEMyTHJMVXJ2NXRFQVZRRmtJNkJqaEhxTGFGZWdM?=
 =?utf-8?B?UmkvS3VtQ2FseWhkZzJoRHNtNjZvZjM4MS9ENy9nKzljK1VyeFZCalUzUUZI?=
 =?utf-8?B?OWxOK0ZjZU94MGtsaGcvUGZZbFl6cnk1V05pTTU1b3FIZ0VvcmhIUEZxSnFp?=
 =?utf-8?B?dTQydVJyMGhrNEJpREN6OVNWWlNUNU43bDhmZTU1MVlxa3MweXh5WldYTklu?=
 =?utf-8?B?alU2dDhYZzN4dVRud2txRERrSHNKeVN0Uy8vVEtvbWNjL0RIVFZRM052Zm1W?=
 =?utf-8?B?cmNEdXQrcXAzM1JoL01jdENXeURwMWtzN1ZBektFc0lOR1plUFNCYk1CcklH?=
 =?utf-8?B?Y1ZPYTZzWDRZSmxLbld4cjJJSEVLWFhUZ1VTdGIvMlJ2UE9MR1JCaVMxendN?=
 =?utf-8?B?SEhRYmU5NFlNNTZLek56QUkrR2N4UDVtbXZlWjhIMi96QnR0eWEwZ1lxYVow?=
 =?utf-8?B?NXhPMU1lVGs0WEZpWFhOTUVIYks4MVpPNTFHeVF4MmF6ZmR2WjQrdmZDSUJi?=
 =?utf-8?B?VllhZ3NsWGtOOWwvc0o1NVE3WUR0Wng2QjRTNFpvaExmakpwT2hzRVZYNTk0?=
 =?utf-8?B?UG1WMDBwcHZKNFBES1dXZVNUb0lkQWhZREg2RVNBNXJpcUZHWFZCSXJCTTF1?=
 =?utf-8?B?TngybUFFUVBubzcrb3JJVEFnOEZ5clR3eDFLdmhyb3hta2M1NVMxRDdrbVJ4?=
 =?utf-8?B?Unp1dTBHU3ZPWUpJYjF1UzloU2Z0dEdTMG1PNTVGRTVjeFlpNWZ3MjhybXJQ?=
 =?utf-8?B?NW1EN293MUptaDY5bElEdWEyNnU3Z3FVZld1ZjFjakZKY0V3bGQ2QlhDMHdp?=
 =?utf-8?B?eU1ma0F3dHBORDJZVk5QeHdIU3JmZitORmZOQWxaU1FNRjF3aFNBd3pFZG1q?=
 =?utf-8?B?YUNuckZsTDk4S3ZCTWF3UEUvcGRCZWVuMXNFZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0syYmJnZmMxNWl5U2ZvM3dDb01YVkp1d3JSMFNLR0hnd0lQb3NEZUVwNHI3?=
 =?utf-8?B?L2pyV2p3allNYWRabUxDRlQrSm5ZUWJoZ2V0MzBSYis1VEdxaDU4R29ZQjBh?=
 =?utf-8?B?VThXdktoNzJlSndRYzlnem5VU0VjVlJ2cHFlMFVtWUtJL3MycS9CcjFNT0Rx?=
 =?utf-8?B?M3lCMURnQ211YUovWDRHVFpGblJpZklDQ0FYRmtFY1RJL0NLMmI4VTR5VFFi?=
 =?utf-8?B?dCs2Ylp5Y2kxOWdHb2grcmFnSGxERzVGMTJ0dVJXcGZKUmNvbXN0U1dycHFs?=
 =?utf-8?B?cS8rcmlPTW1yc25JQ1BEV0hoaG1MbFpzZ05jV1UzTWZPMXp0NVQxMVpNeEVP?=
 =?utf-8?B?NnhqdlZJZkJPU0xObFlzVnBkcDYxSjBsTTM2UnY2TisxL24ybnlIUU1sazhi?=
 =?utf-8?B?aHRkR3FkUm1QVUhVTHdhNk1rZlNVU1JyQy9JR3ZrVSt5bHZkREZ3cE5VTTVL?=
 =?utf-8?B?cDBNYlZSQVc4TFVLUThmRkx3Z2JCa2ExeHVZL1RRM2JzT1RML3lHK2JxbXhC?=
 =?utf-8?B?aW5mMjJTWWFUOGhCMnNLbjJEazVxakdSTGRPaDFJaGNTc3ZTbFJmRzEvNWFV?=
 =?utf-8?B?ZE9rcTYvZW5CdUk1N080OHFrSWR5RG1Vclkzck1JZVRrKytoNllIVFozNUhU?=
 =?utf-8?B?SG9rRmREYVpXdERyRWg1WUkwSGJrVHFNODRGNHBSVy8yVEFwenJOWlRLTlhB?=
 =?utf-8?B?UFFPUG9mdXY1RGQrQVpYcHpxZ2JOYmNMcWFHaWVHK1A3SHNndThhb1Q4VklS?=
 =?utf-8?B?UUEvZ2FoQk9EK0liSmtWc0ZIOHdnSWZESTdNaGNKRlNXK0hRVWtROXNGSmFr?=
 =?utf-8?B?TEtyc2Y1Q3NrYVhlNHpucTU1aExBcW93anQ0WXR2TkFWcGxuNGlsTTNMd2Y4?=
 =?utf-8?B?TlBOamNVQldWWFBzRU16OEZEUTdwN0xsampNTU1pRU92L2EwRTNjdXhYbTNQ?=
 =?utf-8?B?SW1YTXJ0QnFuSHB0TTJDNm95MWtEWmNRbk9qTEhLZmpjNlZOLytQLy95SWsv?=
 =?utf-8?B?VGNmZFhKUlZJc2JoUTVrUG40YTRuUjYvemRUWTh3MjB2cXZSd3pSQUpIcHF2?=
 =?utf-8?B?dElKQUlRN3lxT0dvQUM3MzVVK0NGS1BCQVJ0amVMQUp1MUEzVW1lN2RnVkx5?=
 =?utf-8?B?WHkydmFQemhONit0ZS83N1Nlczk5aVdmSWc5cDgxRWY2TnVEQlZQM29ObUwx?=
 =?utf-8?B?SzJDZGFyNlZSQnZJbzU4akJ6L0ZHZXd6SHZDdGNqTElWQ0JXRDA4cHI1N3VW?=
 =?utf-8?B?R296b1p1MGw2YjBvZkRETDBmYU5hTFR0Q2p2M0Y4dTlWaGk1TlB5VVE1eDN0?=
 =?utf-8?B?MTV5dU9ScENPTmxhZmIwZEFta0dkenR2TmlyMmhNOVU3djh2VEVtbG1kOFFH?=
 =?utf-8?B?NFFLMHRpd3hseXcrRVRxN2EwQkw5UXdLSjNSNnByQm9aZU9iWVptdDJ5aDBK?=
 =?utf-8?B?MHY3b3dvbXJCZlVUcEFDTndQdmt3RUdHSlFKZUE3QW93bWFWUWRscVN2STZE?=
 =?utf-8?B?eWdWNnhPaDZqOTdzSTY2UUppSUp6R2JodTJZSjhJYnc2dW1ZUDROT2RaRGF1?=
 =?utf-8?B?TExrTjlMQjMxRVFLRUxwZjZ6ZHJiSGFzWXJXZWJST3dJWHNKQVNkNGFEUTll?=
 =?utf-8?B?N29qc2VFRmh3YUJtV3pSSzVUNFBDanJScTNhZURGK0tlWlltUmVrangvL3Rk?=
 =?utf-8?B?YWtUamk0ckdzRkxlWU41eXdEZFc5ZHBoZHRTRm8rY1g2ZndqNjNKdVdtSmFZ?=
 =?utf-8?B?Rnp0bm93RGhGaXl6WElNM1hzK2FwZzdVZ2hOZkxEM3psWnV2SzFKeFJPWjQr?=
 =?utf-8?B?L3ZsODE1Unl3L2RYM05FUFNFNExFVTdRdVNzNHVoQWI3YWFuNEx6VXl6WDk3?=
 =?utf-8?B?emFxU2tRQVdVVFUzV2YzS3haYTJscHpLeFkxODI4TlErcTFQVmFURytQRElr?=
 =?utf-8?B?RFViUTExeHJvUG5sUk15RVB3allmSDFKT29rWm5Mc0ZvbmdXQU1OVmg2RVd5?=
 =?utf-8?B?aEJzVFZZZHp1a1VlR2laNklnUnNCU3MyL3FuNlhzQkovL05SNFhrd1Q4d1RD?=
 =?utf-8?B?c2pBeGd1SFdRVnRmcm9lTFZCQ0xSc3UxQnpjTHJRSDVxalZPaUNkaWZiRlpI?=
 =?utf-8?B?VnpSTjdJYkdYVndSY3llN1U0QnpqSzhFS21qSGgvc1pIZGR5bjhnTFRxS1Rt?=
 =?utf-8?Q?q4TGuyQTnnFqsTqYKfujffQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF23DAF44C085343A8032669CEE11523@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zUzr36BydWIQsUfsAY0iiWji6Mu9W3uReCAfKU0itW5w0d2rW61mPqeIkotnQaV/uEIRojBhLoEf2NbYl+6ylpEh/zwbbfDnhk3IZe+XK+BZbJth1mEEbJVAG/8KyOJFZP9yyy1LaRzJ0d32SW5a0mlvuObKeovbHX8SqX+PGR/FxWQFI7AA1IZnoBR8XsgiXVi9tRWxXkZYwiFVlLGyINoc6SOCwQQMP6yEtgRdtQA6C46nSCR/T9tL/0lLDRsHbKrbXjAnnEmc/BK65yKBmwptcYBoKbjTP/YIU3xjLSK7muwkwa552rsHvUpw0FLVHtt0TrSME3Z4WeusF3tBGn4aTkwrIHdvmHcQaHVwc9sF/knjon/cIVdYYUI+OaBFoemxli4FP1oKRqREzV66VSS2J8cQMopwJqmZFJM1L1FC1nLudIyfTURn7wt4Qvy+wtkz36v4wYCGQcRKpGboOS050QMK9hhRImVIJigG6pTcbhsbwxeREUXuhzW5oXcp6F2sxN+EAgwcU5UUH4nwbfpxyAnoh+n5Sznu8WZhsBFUZtpT787QJuQ/3LVCFBhOk03wu++yp62j9j25bfR7eXOKoKk/1L/iTJzbGM7KtyKlCkZRNvBY+o7Z6skqd3Yo2+uk1+qFUO8LthfufgZ6vQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b614326-f18d-4f64-71ce-08de0b01c627
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 09:12:18.0017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhWg1+eFCOUZJMVIMnW4v3fql8G1cwEn/ERfqIHSx/1tVuwSkaZNbGwZIOIAzVKYWO96sw2nWIkcVHo7SPhURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6348
X-BESS-ID: 1760433140-110299-9198-337-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.56.116
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZm5kBGBlAsKdEiNck81TzFMs
	0gKTklxdjYPM3A0jjVwjjZyMgwOU2pNhYAPaNDO0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268198 [from 
	cloudscan14-188.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMTQvMjUgMDk6MjUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gW1lvdSBkb24n
dCBvZnRlbiBnZXQgZW1haWwgZnJvbSBqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbS4gTGVhcm4g
d2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJ
ZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBPbiAxMC8xMy8yNSA5OjAxIFBNLCBCZXJuZCBTY2h1YmVy
dCB3cm90ZToNCj4+ICsvKioNCj4+ICsgKiBfX3dha2VfdXAgLSB3YWtlIHVwIHRocmVhZHMgYmxv
Y2tlZCBvbiBhIHdhaXRxdWV1ZSwgb24gdGhlIGN1cnJlbnQgY3B1DQo+IFRoYXQgbmVlZHMgdG8g
YmUgX193YWtlX3VwX29uX2N1cnJlbnRfY3B1DQo+IFsuLl0NCj4+ICAgdm9pZCBfX3dha2VfdXBf
b25fY3VycmVudF9jcHUoc3RydWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVhZCwgdW5zaWduZWQg
aW50IG1vZGUsIHZvaWQgKmtleSkNCj4+ICAgew0KPj4gICAgICAgX193YWtlX3VwX2NvbW1vbl9s
b2NrKHdxX2hlYWQsIG1vZGUsIDEsIFdGX0NVUlJFTlRfQ1BVLCBrZXkpOw0KPj4gICB9DQo+PiAr
RVhQT1JUX1NZTUJPTF9HUEwoX193YWtlX3VwX29uX2N1cnJlbnRfY3B1KTsNCj4gDQo+IA0KDQpP
b3BzLCB0aGFua3MgYW5kIHNwb3R0aW5nISB2MiBpcyBjb21pbmcuDQoNCg0KVGhhbmtzLA0KQmVy
bmQNCg==

