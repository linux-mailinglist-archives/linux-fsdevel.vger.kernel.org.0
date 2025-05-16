Return-Path: <linux-fsdevel+bounces-49215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8699AAB96AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147DA4E8169
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 07:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9BC22A1E4;
	Fri, 16 May 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="QGzCtci6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C252288F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381054; cv=fail; b=DyCNv43LtHXmS0yMKEWwVdRfEJwHDxe3/LpC21oi5S7blGmc2lUyBXseo3YcqS+s7k1vP6mg4MgBiS5I3hB7Y+2xT1EX2rEPu5bUlzMzQQyzbem8C8hnhtPkPi+Qu34v3DZt580FuhIjouT4/J0+AkEXLwbd1g+BKj/EF7JF6fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381054; c=relaxed/simple;
	bh=LLkeuo0AvFdtJpt96pesycUV4Fb7IaLvJzVEgeBUCtE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kfuuyY5ZZiV1BK0F6LGCKUH6ENNFFOlkIIJyDHUyyTilO2hYv2WEElUeBeOh8fUotLLiALl5pcAFbrtc5kp40ozWOXALt0mBt5Lg4kcTq8hccaeavNFKXY/NDme3eNbQSrtzpnC2O6VA7PrHi4LR+HkxaxjsOaT4MNWNjvRHgdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=QGzCtci6; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCgbSZa0ays62CHtVG0Nl2ppyiIWZnYCIgamoObm/8ClKh87hpCTe72EZcjejh6yLjt1hZtJj4DcTpXQWxnYFLlkK0i+DQNMvbxsNzG28NDI1E/nuGjixxXO3FAOYnDoQlqIbJNCEsqkolyz2Vr9plJ7D549q1BVUOdMZITOQz6M4/UNPtjrwjF1OW72hxR+4loew6Z2KOPurGuIE47ViQRH883SUG8+5nBE2D00BCqs7E1qqTMbfQSJ65xrGTudwo8UuGsn94fFACZuSvZTz1UXySKD2/1X1rW5UW0ajvC2s37O49GfmkOtr7vtnlEahOxytVM/9uKJaHIOUXNyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLkeuo0AvFdtJpt96pesycUV4Fb7IaLvJzVEgeBUCtE=;
 b=tLFu/G3Dr23Tid2ZrfiejCr+v2tUDLEr+bwY+TBul1zLJuTV1asY9w8PMIQ/ptcNZdMV9GRy4kqhpyFhTKR/hk+0TAG6jlWkrQfiJp93F+CdDvtb/D9TJOUJrnU8cZxgfNbdYGI/0567PzYSFlXST/R5JZY6FupTQnd7Vw/bkawT5ohD15FukJ+ZBKXVfKZaNKb1z1orY5FDgHR6E0bYEnX9lNKJ1CG2Pf33aVy3YF6t34TGWV35urR0hDGW0MLwMFr0AVNcTZjNdUEO/1RB5Z/BHT0czp+CHe5f2tHAMicgjXeLHleUbfxleLw+rhZSJEsBJQZNZ/1X49FI18JvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLkeuo0AvFdtJpt96pesycUV4Fb7IaLvJzVEgeBUCtE=;
 b=QGzCtci66SJO4VAibRNulYGUfrmmDSpzkbvrw+VKXnvqqPXKRjTEGNZNaV0MxTnsmn+Pr4fZkPTZyxy2aY2DbdORbTy9iyUpxabA/40MbNc/VqqMYm/QagBQgFUf65LgFkos1FzflK7thjKYQlUF5dzLTIYNGB3LXqHUpKLZ47SqFik0RnVFxUYq9Qk192iowRBSiVrlHJ95ekjsYDOaThAwTdSjD45kF6qQ9jjvTS9TWWdc2FnczGPTVV41P6alfwLP3etSNZF/XyOSuVYeA19sbQjvtm9dnGNbHmibsQOJW46l5kXnkgVdwtQjxPE1zyDF9N1wzn+d9vpV4Hz74Q==
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com (2603:10a6:20b:16::28)
 by DB9PR07MB9149.eurprd07.prod.outlook.com (2603:10a6:10:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 07:37:26 +0000
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f]) by AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f%3]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 07:37:26 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: Christoph Hellwig <hch@infradead.org>, Joakim Tjernlund
	<joakim.tjernlund@infinera.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] block: support mtd:<name> syntax for block devices
Thread-Topic: [PATCH] block: support mtd:<name> syntax for block devices
Thread-Index: AQHbxi8+7YTf6sadaUWmTxROIKAd67PU1+uAgAAGcwA=
Date: Fri, 16 May 2025 07:37:26 +0000
Message-ID: <c0ecfadc57d7e595cad87eeab8dff4d0119989ad.camel@nokia.com>
References: <20250516065321.2697563-1-joakim.tjernlund@infinera.com>
	 <aCblzTuIJzBUYepM@infradead.org>
In-Reply-To: <aCblzTuIJzBUYepM@infradead.org>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4549:EE_|DB9PR07MB9149:EE_
x-ms-office365-filtering-correlation-id: 50585631-f70a-4f60-0fb8-08dd944c8148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cldrb3dPVGlpRzdJYzBWQVFaSDdGcTFFejdGN3pyaEhzKzlVRnhQRFVSTjJw?=
 =?utf-8?B?ZmpQTW1LRDdnT0VEVHVvUWszRU9EOEQrN0pJZ0hOTzAyOW1ETzFucCs5UzNk?=
 =?utf-8?B?cXBndXNxa2hZMGt6cExHbmZIeC9JSkJSUDdjaFU0RmM1NVBLa0s0bXBXY2Yz?=
 =?utf-8?B?Yk1Db2IrbHRhRlhuM1BwKzlaYjJHRHlmQnNjRzI0aDlLL3RzM2tUckxTWE1l?=
 =?utf-8?B?YXZMQnd6TnVGRmxWNVllWkp3cmswSUl6NVJ3c1FvSWd4UzBrbktwd1VFYTdh?=
 =?utf-8?B?Qlo2cXYwbDNQRmhFNWdjUnMrSmRPdFJvRnJJdWlaNGVkZThJQmxIaVhsWjlo?=
 =?utf-8?B?RWpCL2xYaVMza2w0ZHA0SUppSDhNU2ZHS0tYRzhuOXkzKy9BOFVqVkZvK2Vq?=
 =?utf-8?B?VEtVaTY2Zno1V3QreWNpNXBsYXA2eHFrMHU0YjVtTGVVODlHd0QrSkIvT1N1?=
 =?utf-8?B?UmVWSXJWMk1OWDg2dDVDQ1JtVXVyYzBuMk9lR0l5dHVqd0w3WGFtRXRGVUUr?=
 =?utf-8?B?UndDaE92WUtjencwMnNVMks4dVhNamNhNDVSZnlIZEQ2a3JNbXpnZXVUYlh0?=
 =?utf-8?B?YXJPa0JSdjA5Mjh4V09XOExxYk83QWR3ZGdpT3hBTktIaXp3Tjd0Mmhrb0p4?=
 =?utf-8?B?WWEvdy9DYWErVzVmM21zUnZjWktHcXpndWtyaUR0REhNc0tJL2ZDS1I5eU9V?=
 =?utf-8?B?MVJJT1pKNUF0WlcwdHBMWGVid0ZERkU3NDVwLzIwem1qQnByMmdhWEZtZExr?=
 =?utf-8?B?TFkyVWpsVVVOMldLRW5VNWttdHVNc0lCcVhicGcwdVpLajVrQnFrdHRkMWFR?=
 =?utf-8?B?T3FQRm9oUEpndlptNXFrUWd6WGh6U2VQSFJUOU5RbVJpWGNzQXRBalRrOFFY?=
 =?utf-8?B?dU9aTENzZzRPM2R4OUdIbGFhUlVKZ3M3amFxUGlkTFhhaklzOEtBVVVjOWhI?=
 =?utf-8?B?WmVHL3NFdnlId2hzZUxWTnI1K1hDOE9FSUpaWUZPSUNkaUxTbTVnSnVlbUJX?=
 =?utf-8?B?QjRNb2EzczYwMlJGc1B0N3pYbzNzK3B6QmxQN3V0R0pIZE9IYUxEWTBWWW9x?=
 =?utf-8?B?SS9qVGl1cm5EQ0V2aUdJcm56eGVWczR6MWU4aDVzbTdFcGlhQTdCbktDQzNk?=
 =?utf-8?B?SW9XRnp5WVZSVE1pVW0zdlU4Z3huY3BzNzF0eThObDNXeWdQQXpLMzVBMmRV?=
 =?utf-8?B?RHRqWDlTYzk1SGhZaTJEUDRmMEtIOEtFVzdadFNpRkR3WGJXQUJ1a1VkV1R4?=
 =?utf-8?B?OGNXOVZEYnpxRG91SmpneVdWZlFKREZSdmhpVTNraE9VMmRQNm5lZVhYZlUz?=
 =?utf-8?B?aWlmNnc5RXBUNmozTk83dE9PSEJQNjNPQkpTaEZ0bk5pcG9TZzlMbldUS0s5?=
 =?utf-8?B?VlRING5xVDJsQ09Dei93WjN3ckw4UU9JcEdyMVA5dnoxdDNobGtzamt0UHdx?=
 =?utf-8?B?aDl3NjlPa2ZldWpMa0h4ZmtDdERIdFVtQ2VXbXVKTHM3aXhzeGpQNXd2RDFC?=
 =?utf-8?B?Um1sWUt2TWE2L3B1eXdaNG1ma1RTKzFSNUJ3OXVMZzc0c0ZRK0hyVmlvWDRh?=
 =?utf-8?B?U094ZDFNb09UVkt1czRCK3hSQ1pYR09xOStwM1hoVXdRZ0h1SEVRMmdneE8v?=
 =?utf-8?B?a1FYQm1WV1ZzYkEvaVFOQzZTMGpGKzJvanZhS1h4d1Z0ZmpRaDd3Q3dwYnBi?=
 =?utf-8?B?NUpubXFGV29paXllbDFNSWIya1N2aGNLU0VrWmI5OGFzVXZRRkxxMzVKZ2x3?=
 =?utf-8?B?ckRnNjYwK3lWekVSaWttWms0clRWdjAzU0tWNXB5L0syQWNaRENBUnN5eXVS?=
 =?utf-8?B?Wm5HUHVjR1RXby9LcTZXU01KZUhoenlJU05FTFBvYVV2WDk0QkM0Vmk4NHV3?=
 =?utf-8?B?cmNXWFdTYzJtRXAvdUE5Y0JmekxwN09UbFZIcGh3Y3pZUUVDRStBRklaYm1E?=
 =?utf-8?B?eWF0ak1XRlVnQWpLU0N0WGpSWnluWG84bnFHQ1N3YzkwWnBzRFRhRVBnZkl1?=
 =?utf-8?Q?jKmki53kQwmNgUiq9QF6+0+Pbxn6AA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4549.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3FuOHZWTFhLbVBtN3pJdCt3TytDdGZxcVVYWDRUT1lpWEx4aUowNFpSdmgv?=
 =?utf-8?B?S2ZpUjhPSHVRSjhjOEptOHpJdFduNXBoMnVHbXd2c0pWdEN3RWlLYUFyUzkr?=
 =?utf-8?B?RUpsMW1RcGcvQ0k1R1kyRTc1Vis3bDRXQWgyUlVSbk83NHo4dFJjK3NwV0Yx?=
 =?utf-8?B?K2plME83Sk5TWktqUy9qYWNJVzJFa1ppak1vL0NYSlQ4YUwxVVJEd2t5dGVn?=
 =?utf-8?B?aFR5encwZ2xRSm9xTjB6bTVTL29XNjdWT3JHZ3krRHpPMjJQVWhvVXNCUTBv?=
 =?utf-8?B?OEkyTzZzL3BSWHVmaWtyUUdVZVA5cklkUytnTnZxZUhLcndvL2R1T0NvY2Nw?=
 =?utf-8?B?b0JoUTJNLzBCNlRXd3hmVGxwYTVDTWJCbUh6elI3U1JSNTJtM3VKaG9iKzdD?=
 =?utf-8?B?WWJXWEl6L2hRdUJJVUUvclhEVHFYU01JQTBidWFDcWJUN2graU9WTFRhZzZB?=
 =?utf-8?B?VmtKL3UyRGY4ZEFuVFlDMkhUdFhHNVovZEM3emI4bGltM3BIdDRNTXZTQ0FF?=
 =?utf-8?B?OElObkVPOERmN0dyVFRLbUx2ekR2S3hBNytzcE10VlNzZXJ5RWRxQ3pvUmYx?=
 =?utf-8?B?aGhQaG9zNGlCalMrUi9LSjBLcm1yNjY5bmI0RExzN2tDZDIwNDF3K0NEckJq?=
 =?utf-8?B?a1NrS0Nkb1p2eFNBVldLNnZhV2h4THhkMDFybzFJa05MUkF6U282VWdOeTlv?=
 =?utf-8?B?Q0d3L3NrdXhPU3RsckJtVFA2ZkpibnpFRVBuK1RpL0FMSTB2UDJUR1RkcTJn?=
 =?utf-8?B?cDJCc2hQeW4ybHNxaWdYV0hIdEY2NVc5NUxrQUNrQnY3S1MwSjhJdFZEejVl?=
 =?utf-8?B?RmZiZ2o1S0NjQlphdWc4elBxVmxzOEFTOTRrUkVtSVg2MXpFeHVROXprMlRM?=
 =?utf-8?B?UkhMKzdYQTJhZXFLU1VWTUxkdVJnbHZ1MTJBaWg3RlJyTjBkUGpVbXl5bGxL?=
 =?utf-8?B?bmZ0dE9pU0FKMHlBSHc3b2xVRy9rSlQ5cTVzM3BHTkdrTzhSREF1cGh4Z3lq?=
 =?utf-8?B?TFdkUUxJQm95M0hQU05tbUZCZVZDblNUZ0ZGa3Vld3NRSnVXNHRGeDN5cGQy?=
 =?utf-8?B?bjl1MFlsWmlUSVE0RUtHcWdob0pYU3MyamZ5ckthSXFFUGhuclZJWG1zNEhX?=
 =?utf-8?B?QklyOVVVSXlkcXV2N250aVNwN3NMM1U0eWZxOEZiT0RQMDlBV1d5L25xMmho?=
 =?utf-8?B?b2JOOVNqYTh0bjRQNU0yNTQ1MWQzVGFtZlhmYW5FRUpPaHlwNUt4aEpnZExk?=
 =?utf-8?B?dU5scHBzVEZVdVNBeXpUck92QkRqSm9CbGxMazVKbVhuQ0xpSEpHUGxqSzFs?=
 =?utf-8?B?M2RpWmczb2gzL3hqN0ZKaUdpakJ4cXJlWjRRTlR0ZDU4NkEvNW5ONUNMejJ5?=
 =?utf-8?B?MjVta1AzUmJkQkR0MW05Nk5HNDJLNkRaeXNZVXlDMUpGOFZDL3BRaXhTMFQv?=
 =?utf-8?B?dFBiK0RxR3Ivb0dUeElQOFRXUmZKRmZ1VmlRYzFZaGpFUmpXUEJrVmJUVFNC?=
 =?utf-8?B?bkRsN21PZTJoSjUza1ZIaThsTXRwdk80aDdRR3hpcXk0MmkrOFVHVnArZ0NQ?=
 =?utf-8?B?Tnlpd0ZLWUxQSnc5b2h5MEg0ekV6OVgyeFlHMFlnVzRhTHNwelVHREo5MlFJ?=
 =?utf-8?B?eHJuaDNwczJhUVl4VHVEemx1UThoeFhQZzJpc1JBbWdOOEN0ZFU5Z0hJOEpm?=
 =?utf-8?B?T1JTMlhJbUo5Q1JUQjRtTTBwTEp5cHlZakRlVmF2WCtXcklGdUd2My9lemhk?=
 =?utf-8?B?eUxNeGQ1Zi9UWnlkeDVFenZMU3M4WGw0M0ljbnBQMWt3c1ExdnIvek03VDJm?=
 =?utf-8?B?b1RLSGFzZEF0MUpCRjJyK04vc25mMFhpd3FHN0ZWS1hOZkkzOWk4M0VMR0tN?=
 =?utf-8?B?N2FWNUpMWTFnMERxVE4rbGhQdzNaaFdDLy9YajJIZk04NDZ2ZmkyZVc2OHFW?=
 =?utf-8?B?dmhJWDFhdUQ2QmZVV0FQc2xNblhRZWw5ZG5iK1oxcHlZNUNUUEpOUVFCRDBm?=
 =?utf-8?B?RVdJcnpjc3J0cWZTNFZTUUZ1VGdzYVRpdGZYdnFmUzFCMjlmZkw0bGR1NGQ0?=
 =?utf-8?B?czRGUkpqZTU0WGhzYk5wNzlFNnlCSUdEK3NEMTViUTcwYVNNeG50MXFLYzEv?=
 =?utf-8?Q?s1poqTwOGGHpMHw2NVyaHCZ8I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0755B49D6FD3A344ABCFA92D21BC4883@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4549.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50585631-f70a-4f60-0fb8-08dd944c8148
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 07:37:26.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgPnKWLQe0eXBnW8ozBiorQMWdQqzOFFTJCfkGHD2c6F9+ZXvjEFMws7/nnRoxi7ET/DIYyMSrwfu+VyxAyZJUDlTmkSNe4Szq0JpginmAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9149

T24gRnJpLCAyMDI1LTA1LTE2IGF0IDAwOjE0IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGhjaEBpbmZyYWRlYWQub3JnLiBM
ZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uIF0KPiAKPiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVt
YWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3Blbmlu
ZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZv
cm1hdGlvbi4KPiAKPiAKPiAKPiBPbiBGcmksIE1heSAxNiwgMjAyNSBhdCAwODo1MTo1NkFNICsw
MjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3RlOgo+ID4gVGhpcyBpcyB0aGUgc2FtZSBuYW1lIHNj
aGVtZSBKRkZTMiBhbmQgVUJJIHVzZXMuCj4gCj4gR3JlYXQgdG8ga25vdywgYnV0IGNvbXBsdGVs
eSBmYWlscyB0byBleHBsYWluIHdoYXQgeW91IGFyZSBkb2luZwo+IGhlcmUgZ2l2ZW4gdGhhdCB0
aGlzIGlzIGEgYmxvY2sgZGV2aWNlIG1vdW50IGhlbHBlciB1c2VkIGJ5IGZpbGUKPiBzeXN0ZW1z
IHVzaW5nIGJsb2NrIGFuZCBub3QgbXRkIGRldmljZXMgYW5kIHRodXMgdGhlIG9ubHkgb2J2aW91
cwo+IGVmZmVjdCB3b3VsZCBiZSB0byBjcmFzaCB0aGUgbW91bnQgaWYgYWN0dWFsbHkgdXNlZC4K
ClJpZ2h0LCB3YXMgdmVyeSBicmllZgoKVGhpcyBlbmFibGVzIG1vdW50cyBsaWtlIHNvOgoKICAg
bW91bnQgLXQgc3F1YXNoZnMgbXRkOmFwcGZzIC90bXAKCndoZXJlIG10ZDphcHBmcyBjb21lcyBm
cm9tOgoKICMgPiAgY2F0IC9wcm9jL210ZCAKZGV2OiAgICBzaXplICAgZXJhc2VzaXplICBuYW1l
Ci4uLgptdGQyMjogMDA3NTAwMDAgMDAwMTAwMDAgImFwcGZzIgo=

