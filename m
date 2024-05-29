Return-Path: <linux-fsdevel+bounces-20493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD70D8D409C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 23:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BFF284CA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF11C9EC2;
	Wed, 29 May 2024 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="O4zu5oHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457A225D6;
	Wed, 29 May 2024 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019990; cv=fail; b=TpzVDbLSsoMRe9E/tIU7COhymEfzV6qpW4on75iQX5/qbqWubrrKPuyGin0uED9ausllwTMJu9oqcmcHo4HR80LJW1hGqKNWtZ+LomTEbS63+xYUtB8xXhIrIy3Zt2bYkrwfwZBc/gXaPK05SsVGUFhvNwAXxYMmZj1A+jaBY8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019990; c=relaxed/simple;
	bh=7Pzz9U+rCz7LCacy/D1INA4AFIarQ1S7mzty+FALSc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a5cTmLCdiDAbUNIosUUEiQ0qeejxhYr0pWyKaZWkEm3WmgOqQUzBKzwgAzdeYTzpJtNwSBdYBe+N+xdp6HefFsx5QZhQR2iQdwRkHYiUKJEC7f1/csPnxmkAMSe5cNjd7LUX4PNwQKoL5E5unBXpVFXSYYWULniVVhxp6TDkKLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=O4zu5oHJ; arc=fail smtp.client-ip=40.107.223.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3FAXwfMlMgtYoG4S0ZrBAjaoXn5msJ7hSviQr7oVyDoDCwsWDNiInl/S7Md1zAVxhYz+Wmf97nfm1zcVlEam3TWMokz2bqU3Fbd3IiIQcSHQDsQ19kR/xo/Q8fTnFQUw8CZzYhnD3rdIvjv1T9/jtuIym8A395jV9wPNQGiNGDxJJxM4dvHCJ6ZUh92FqLiIHeURR2kXxoRuYU5LvHwP1duPLZudkGsyYBrYd8n9Tipf/HTVCNMhLDMOtdpExEy32FL9fJVcHvVJ89xcUfX1pRD4pMXKPXKzQSbYedoc7Q0vuDpZDt6A6Z1qNPc0PqEsK8G3eZpBKkssW08Fw7YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Pzz9U+rCz7LCacy/D1INA4AFIarQ1S7mzty+FALSc0=;
 b=ijiDJ0feFhJUVhV4tcuNfWx0UQnjbKUIeDuQDZfNhINEQ3f/c9mmZbF/89cdJVVJ7gV2wyfTezCjBqOsW81E6Hx1gSN/87X5bkDb0RLJLyzhqz7N7YKO6QmQtT6ua7ZgQsH5cvfAc+O6Rx9AKQHsMIYUHf2jKkMYGH/ZI0sqbqMtqj/YKIvC6G5U159+z5KmTkXXD89KbLqaV+6JioJ10/vISd/hR6tX1kku46rq5NGuHYtUFI/l8G7ddYfoyq4mbCP3Hgp7x55F+7mLczm9w8DcjZVUIhyHOblvUtIYmIELaqIPbt1dH8jzvab0vMylMcCtwLdAsXtH9fNw7uo4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Pzz9U+rCz7LCacy/D1INA4AFIarQ1S7mzty+FALSc0=;
 b=O4zu5oHJye4+DVWpPRhqHrsdga7H9Wld58djkwp8i5J52SknHcSqMifg3Ez5jOPYGtjX3bI2NFXVPu8BU8t/PGmnN9ZjrNbc/ThyDENI76IdnrE+8zU6Tgvf1+gEgviOpigZig3/P4LW8kZqGNpncNy+5LrGSBWn0UbBsbEX9wY=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SA6PR13MB6928.namprd13.prod.outlook.com (2603:10b6:806:41b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Wed, 29 May
 2024 21:59:45 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 21:59:45 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@lst.de" <hch@lst.de>, "anna@kernel.org" <anna@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: support large folios for NFS
Thread-Topic: support large folios for NFS
Thread-Index: AQHasFQEtVPFzJw4R0eoRu1V26ovVbGuxl2A
Date: Wed, 29 May 2024 21:59:44 +0000
Message-ID: <777517bda109f0e4a37fdd8a2d4d03479dfbceaf.camel@hammerspace.com>
References: <20240527163616.1135968-1-hch@lst.de>
In-Reply-To: <20240527163616.1135968-1-hch@lst.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SA6PR13MB6928:EE_
x-ms-office365-filtering-correlation-id: c5b30d36-c0e1-416d-fc70-08dc802aa670
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2YyQTM2bmZPc2ZFMkpuSkdaT1B4NnR5QytpbzRCZ0pHMTNIOG93MENESXlp?=
 =?utf-8?B?WkxpZkJqeXlUcTdmb1NnVTJBTnhBeExsZklUTG9EMlVVUnhaQXZDTmNCbXZq?=
 =?utf-8?B?bnVCeDQxNExVTlFwY2pmRS8xREY0U0QxcjVvYW5wV3FoQlVTWmdxY3hmSCtU?=
 =?utf-8?B?QlNhckN3ZzVEK2VSTEg3emkrRm5CRGtob0t1VFVhN01sWVk2TllibzVvNENQ?=
 =?utf-8?B?cDJ4a1dBT1JQNnQxVlBOL0MxVlRmZWpOT1VhdzIzSmNnaWVPYUVjY3plWVBY?=
 =?utf-8?B?ZXB6cTVkcEd1bGVlaFpvNDkwWHU3MHBsOHl1OU00WTN3aVdrTGZjWXpZbEg4?=
 =?utf-8?B?a3A5WWszaXRXWkZ4T2tpalhsTG5LRS9JakdrR1pockZiSWtJaVJmd2V1UjZ1?=
 =?utf-8?B?K2FsSDhVWExkY0dKaklRcUV6OFViVEMxNVVyR2hEMXpjeE9GV0FWUUs2aVNN?=
 =?utf-8?B?UFI4UzBsVktYLzlmWnlJS3F6MjB5V21EYy9mZDZ0SGoyMjlScm1ZRWo2bDRF?=
 =?utf-8?B?OTlXNEcvbUVJWUxvVFZYK3JJaVJhTjJmYi8xME1nUEdWamJGYlovaDEzNytp?=
 =?utf-8?B?Y1ZhY2VwOUxlVWxSYmdZaU0wTG5Wd1ZkWkZaMjl4Ull6SURXNEZ5T2hNckpC?=
 =?utf-8?B?NmhkWGp0cVoyQUxza0ZYRnpCcFJhK2NxeEJveDRPVWo3QU83N2t0OTRpZ29l?=
 =?utf-8?B?dTNiRXFTMjlKSVIzYTFLa1J3L0pGSFZpTzVKdzJCZCt0ZzYxcDc4YzltRTNM?=
 =?utf-8?B?VzJTOGpla2xSN2tFdlhBSE9WV3RJZHZDdzEzcHMyTWlQRjJxYVk1RVhPQ0Rw?=
 =?utf-8?B?Q1R0OWYxbU9aeFkrMDQvQUZtQVhaSngwWG9UVCtSMTlRYk5WSzdLdmt5Q25L?=
 =?utf-8?B?bXZyQ0VNcGgzZ3JPc3B1ODJLNnMwaFJSMnFWR2xHOUxQUjFtUGRDQm9HY0Uw?=
 =?utf-8?B?eWhXK2p0cEw2RXpZdXp1N01taGdkbm9UNFpKM2I5aGpFUDUzbTFpYUFjQTh3?=
 =?utf-8?B?SU50OVBsMWtxbVc0MUVDdXJodVpaV21UdFdsU01Kdmw3em9sUjZYZlQ2Y3Bm?=
 =?utf-8?B?dU9qN0M1LzdVc2lkd2FYTDlzSStwZUZiTFBMTVZtdVFHMHFKeG8rbmJrUzBa?=
 =?utf-8?B?U05FSHcxWk9iT2ZrOVJ6YWhzRkExT2JQTzJNSVpqTGRnK2lydjBPdGVRVlZx?=
 =?utf-8?B?bnoxVzRTUnNaNy9DK1JRY1kvRllrZ21GOS9UYXBoK2RrczkyTENBeDlFWmc1?=
 =?utf-8?B?UCtUWkRBcjQxZVVkSkozYWsyL2V4aVVYejRwMUswN3YxTmFtS2MvVWhVTDlQ?=
 =?utf-8?B?WDdaUHAvMWRvSEFnakFHMk4rMWlVd1dJY3o1NEE4blRrZ1J4ME9qSGxuWjZ6?=
 =?utf-8?B?UUhoalFOQ1dwRTBoQTBVTFRuQ2FoakQ3TGRnd0F3ZjQzU1V3dStnTzRPdjVs?=
 =?utf-8?B?Z1huL2dwWTZKQTJLaXA1alJvWlE1ZEhXdEY4WlZvZDdHUnBOOHJ6ZXluY1l6?=
 =?utf-8?B?WEMwZEw3Ny9tSzBmcHlwYjJQUVR6T3VqejBDNnJQNGpPaitFS0lFZGdtVGRW?=
 =?utf-8?B?M2xlUk1mUU9VL1BQY1pMUFFwY09iaURHNHJXaVJvWDkvRER4TWt4Mm1Sd2E2?=
 =?utf-8?B?MFA5djBlN3I3TDZhQTdsUG9LZU12b2srWTlnekR5K0FsZEtXQUZJV2s4cHZ3?=
 =?utf-8?B?UXlCMkVDZWtmVURBR3ZCVUx3bk10MU9WQjlib1NmamZjQjZMYzBTMTM5dnFM?=
 =?utf-8?B?Tmg2OWdvMEJQelUzRlhVQ3huRTZmNFIwU3BRQ1Zsc2NiZk94SkJhNi85QkY2?=
 =?utf-8?B?QnFyUjc5c0VHNll5eXVjUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2dzQ2hLRWpUblNRNFlEYXpaS1lLMU9iUGk4MkhTV2xMNko4RE40N3dNSjFI?=
 =?utf-8?B?d3RrRjBjdjVGck8wMStLRVZOcXRSOCtKWE96TXdjNzQ5NzE1bjhDYngySUtJ?=
 =?utf-8?B?N01id1hyLzhOdnlBTlp2Z1BIYjJqcVM4VGo4UlRLZW9pRXR1eGFlaVdtVHZ0?=
 =?utf-8?B?WmVBc3F3TXI0bXVGcStDNnFDM3VkWlVBYTg1cU9nbHREYy8raDl6ek1mcGJv?=
 =?utf-8?B?WHZJdTQvaDJyV3QzWHYyNU9HaFFjdE1NcC9ZZjl5amV6L2l2SnIybDl6UDZP?=
 =?utf-8?B?RVJaOTZXUWtYcitNajVBcVNBUEpmUFNwdXRLaEo2akI2L1hSVkpLRVp6L2Zy?=
 =?utf-8?B?bElMUkpsTU9PUmlmYm5kVjBVcTRmUHdaclBadkJkRndXamxKbmc2QjZ5ajU1?=
 =?utf-8?B?NFZ1eHlWRjlVc29LLzNqMSt2b2RveHJwWGRmVk45d3hFZjhSQXl3dENpam1x?=
 =?utf-8?B?YU1TNmRISExjNHMwdEY4aDJSSjdCVGl5VzF3NCtkelp4MTFsb2VMY1dCeTlj?=
 =?utf-8?B?ZUVvY1IrNWlHVjVYSUp1Y2FuQ0h6Tk5iUDRvVWZEVXZ5K1B0cGF5VGR2cGFs?=
 =?utf-8?B?cGp1QzdYd3NjeWNIcnhmaHZXU3ZubU02VWk4SWlVcjAwUVBsK3ZoN2dnL1B4?=
 =?utf-8?B?NW8rSWRqUE1ud0tXRTJrRXZ6cVRTQlNoS25kOVNQK2lvKzFKL0Q5dVpPV3F2?=
 =?utf-8?B?OVZtSWd3ank0aWcydDVka3Rra214MUJWWE1vaDNFUmpadHd3UTFTbWFpYWwr?=
 =?utf-8?B?OHl2RUQrVUdKN2Z1R0ovN3lSK29wL2xEWXZwMHZuMTdDblUyeUhQNlJyMlM0?=
 =?utf-8?B?TXFyTnF3NCt4Vks3My92WC9iQ2RtTmtMQ29TUDcvU2ZpOXhxL0wzbUNIaEVx?=
 =?utf-8?B?ck9RVjZuaHRrczd3TWdlK1UwS2FCN0dxK3JPTTJhelNzbzNUUHJiaG9zYVBa?=
 =?utf-8?B?NDhYODFjRjhWTG1QZzNVRFpmcXY4SFpzQWU5c0FhOHlSRjc5cUpDdWZCZkxs?=
 =?utf-8?B?WmZ3b0orOE9rZEZCNGJtSUdxLzYyRHFGZ3JnM1FndXVldk9CeGZLRzFIRWlw?=
 =?utf-8?B?a2J6bUNhY3hhYnQ0bitLNlUyTEt4NXMwUlZxbUlVSFBwTVlXSVhoYXRnT21a?=
 =?utf-8?B?UUJjaG9aY2dPWTNXSHozUnY5cm92blY4cGF4dFgrYWJ2QmRNZzdiZ21Nb1Rt?=
 =?utf-8?B?a2U1UzhrSzlMU3p4RnJJaC9oTlk3U29PbmhBcWx2dVdLdGNuamYyQy9qelVq?=
 =?utf-8?B?UElTQmpNRnBBdkNGQUJDWHFRT3dLdmM5TGJidTd6akVkT3d4WUJ3SFdWMDdo?=
 =?utf-8?B?K3NaM0tuaFVpQXMvZlZLSlZUNTEzbWpJc3gveDdEMUg1b3AwdXZrNTFVM3lG?=
 =?utf-8?B?WW9OaFJGdSthZGFrZEV5T25EdXVIV2o4cFk5WmVBWTVHS0V0TTZkYnI2YkY0?=
 =?utf-8?B?MWhUS1lZTndGQzhqYnVwVWhjVDZiZzhlRnh5T0NZNVhoYXNwaGY3N3Yyc3I2?=
 =?utf-8?B?QmMra2xMUGtOakxvSGplVnppUUlhMnJoSlBBSjVVVkJ2aE9hdENyK096aVdm?=
 =?utf-8?B?Yk1HTXEzMWYwYTJpWjhYOU1JOENVWjdZbEFqcHFQdzdrK2hxQytIU1l6aTA0?=
 =?utf-8?B?U3ZuQlRyS2V1dTdLc2lPMGYwK2lzMGM4QUhCQ29jQi9VYno2andPTjZLYUJK?=
 =?utf-8?B?Yk1XSUlWa3dBa2NLWUFjZDV2VVI1U3c4cHRPaTRtL01mejdqbVdlb3JFc3Av?=
 =?utf-8?B?akZrNlA4a3Y3Z1B1VThGMmtlVUZuUDB3cUJPMlB1YU1RWnV5MjFweTFMK2xo?=
 =?utf-8?B?bm5kb0lRT2s2V1pFMUxxOG5kSnJxamF1MTh1NUwzU1Yyd2pnL2cvN2xNRlU0?=
 =?utf-8?B?UStLTmJiOFp1N05kNFFXNDNHRFhka042VlI4MEVod3NtSEhCOUZTVVhzVUlB?=
 =?utf-8?B?OVV4TVVTR0RsZWlxYjQyMWFiU25FR2szV2xSVUZYMWN3VEJ3SC9MMVRySDdu?=
 =?utf-8?B?WkZ6M04xSCtHcHJ3SThIYkdXc2FYTjl3Y2daSTgyNVlMaFNMM0dLWGZVSXAx?=
 =?utf-8?B?WVY3ZEZDM1BMNFhPbHc3b1BkemlUQ05qWHVmcGdudVBUR2dyTnc3WmRJRlNx?=
 =?utf-8?B?MlNEeDhGMjkzeTV6R2t1STFLRVNndUNlTi9aS0RGWHloWjNyK1VVbDBValFZ?=
 =?utf-8?B?NVpFNThQeFB3WnBZbjFONkxndGQ4MW5OQ2E1ck9CbDFqTVgwY0lVUXFZd3o4?=
 =?utf-8?B?Lyt0UytsRTM1RjVjTDA2VFI2M0hnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10A8CFC4AE596F48A217BDD4C304E91C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b30d36-c0e1-416d-fc70-08dc802aa670
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 21:59:44.9109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHW6e7epDJMJN7e9RffGj9/Ue9nhV0pGv6k4KqWiCdR5YBIAJ0G94hoFwietv/NB4GUeKG1lcx0H/8QQ5zJgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB6928

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDE4OjM2ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gSGkgYWxsLA0KPiANCj4gdGhpcyBzZXJpZXMgYWRkcyBsYXJnZSBmb2xpbyBzdXBwb3J0
IHRvIE5GUywgYW5kIGFsbW9zdCBkb3VibGVzIHRoZQ0KPiBidWZmZXJlZCB3cml0ZSB0aHJvdWdo
cHV0IGZyb20gdGhlIHByZXZpb3VzIGJvdHRsZW5lY2sgb2YgfjIuNUdCL3MNCj4gKGp1c3QgbGlr
ZSBmb3Igb3RoZXIgZmlsZSBzeXN0ZW1zKS4NCj4gDQo+IFRoZSBmaXJzdCBwYXRjaCBpcyBhbiBv
bGQgb25lIGZyb20gd2lsbHkgdGhhdCBJJ3ZlIHVwZGF0ZWQgdmVyeQ0KPiBzbGlnaHRseS4NCj4g
Tm90ZSB0aGF0IHRoaXMgdXBkYXRlIG5vdyByZXF1aXJlcyB0aGUgbWFwcGluZ19tYXhfZm9saW9f
c2l6ZSBoZWxwZXINCj4gbWVyZ2VkIGludG8gTGludXMnIHRyZWUgb25seSBhIGZldyBtaW51dGVz
IGFnby4NCj4gDQo+IERpZmZzdGF0Og0KPiDCoGZzL25mcy9maWxlLmPCoCB8wqDCoMKgIDQgKysr
LQ0KPiDCoGZzL25mcy9pbm9kZS5jIHzCoMKgwqAgMSArDQo+IMKgbW0vZmlsZW1hcC5jwqDCoCB8
wqDCoCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+IMKgMyBm
aWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQoNCldo
aWNoIHRyZWUgZGlkIHlvdSBpbnRlbmQgdG8gbWVyZ2UgdGhpcyB0aHJvdWdoPyBXaWxseSdzIG9y
IEFubmEgYW5kDQptaW5lPyBJJ20gT0sgZWl0aGVyIHdheS4gSSBqdXN0IHdhbnQgdG8gbWFrZSBz
dXJlIHdlJ3JlIG9uIHRoZSBzYW1lDQpwYWdlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==

