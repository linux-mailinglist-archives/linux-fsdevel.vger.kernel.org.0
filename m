Return-Path: <linux-fsdevel+bounces-29340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1C9784EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A421C21153
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B556BB4B;
	Fri, 13 Sep 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eVE+lz1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12822D502;
	Fri, 13 Sep 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241482; cv=fail; b=GVrsqTpYvZ7SShOQ2ZqOyc9E5yQJRHOtvEc+tMDlk1T6xUm0LjpGAtE6i8+QgPtxCP/kSnGZcgMmxIlgxSaUAcACst1YWhvryINqh5iK+vpgTwikwMxZYYFTaoT4XvqwKsm+Gb136NLKEoQe+yeTk3fSU8nNcYUefSaNQAkku4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241482; c=relaxed/simple;
	bh=wT1+phQPJz0lkzghseP4fVkEBWUiYRf8TNN2sVQuzas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=seAju00FiXjqEvLHdvhXbU14mJhGcMtDBC6oH7cBgV9Jqdrt2zZ8IXHX4lLYOW8pSmYR2dY6wdeAF35ifr3chbm4SzoC760nZuYjsnFab3XQZYtHK4U0DeCjyEXAB21Pr7NxKmsfkJJm0wuwwWPzALJBlgPHquhCE5jjruhUa/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eVE+lz1H; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DCTOZq002869;
	Fri, 13 Sep 2024 08:30:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=Cr49Om7Nm/q77lFKcYMu6DvcskxYMtja5TFNuy+5jYs=; b=
	eVE+lz1HSoRUuC2hmpHCggtee6cegs/cox/vR6IZTdyPVeU2Ef3bOl3TPG6rqQCB
	nisFhB7b36n9LxLcADLrES0OrgB/HF3QqW3E75+9nntx2jq4D8ng+d5dM2s6E/eC
	eJTTK7AlOHxeXzFRSHHvfxrToYervDNDjpBv0Yz64QikQFhUyvWVU6AEDalk5suD
	OFTZlA+l0jEepogSC9eFFH4IkmmSDGluU7v+o88TUrLDrTP1HqSXCfF/9pOd2nYB
	pg8pYyveufJ0dtOkBuHi4yJmZf180hnLvidqLC/pRIBC3b3OWubO3kZ1om9jShZT
	sS5yCmgCAlEECVpm0w5/aA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41mneds1mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM9LhFYBjXHs3HSwQ4MTM+6wEzXijq1JMhrstsAF31xY1xqAPNmiW25XeNkNkW/giRivGH9+oCNneRpMDa0D/WI18RRJnSiSuF659ShNaEThleQ5GXoHPbqVfENqLWKycbYVGTGXXb5NSLr4vfpRTWobj3IVZfxLXOOucmQFUY61vEbarME2GYHout21j6hAkXP3Sc1HCDZfFnoeMhtMhOi0usU3JFr1hIemD7FMzlpwfIqKkPBMd7wcL/0+OxbHus5xhiORPwDRBhB5Xi0EXl4nIhgLBVJnmy0VRReXjNzc9VLrU+hkLKLfeBG31KKF8IoaeeA+XQ6QZEZJn5Z/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr49Om7Nm/q77lFKcYMu6DvcskxYMtja5TFNuy+5jYs=;
 b=hbTitZhjQpsIFYaGv9hW4bd5lB13lLu6tPXST+Xe9z9/9dvyjw0p39BdqSSTS8uy1hU8OHajmPzNZfAIuWPb5hgsIoZ0iqtdoe/mmy2NFMTraCFC3BLMMPRn+88lKad6qK/vpOOytCqzSEE1mkrG7nySbAThGZYj5bceISElLw2PIggaSWvtlonb4RqjaePbhkZqANr8rmzOS9xCJ2cZBe1//iQCwb8EvDDjDctKzqaAYATq9fOG2gxBr8U4fh8Eo+fpzHCjiCPU4Vbfcv+Q+qt3fDPgE3lFxpYumllvagiWm5PqDc+NVrvT9N+2NccbA7FLdIwXqLbc39r1lvXbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by LV3PR15MB6660.namprd15.prod.outlook.com (2603:10b6:408:26f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 15:30:50 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7939.017; Fri, 13 Sep 2024
 15:30:50 +0000
Message-ID: <d4a1cca4-96b8-4692-81f0-81c512f55ccf@meta.com>
Date: Fri, 13 Sep 2024 11:30:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, Dave Chinner <david@fromorbit.com>,
        regressions@lists.linux.dev, regressions@leemhuis.info
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0918.namprd03.prod.outlook.com
 (2603:10b6:408:107::23) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|LV3PR15MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 97aa111a-74c3-4ebb-8e1f-08dcd4090c01
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzFFVkEwMkcvejNpSTNrMHU2b2lscDdVck4xbnB3blZlN0NZNGZpblcwSGc3?=
 =?utf-8?B?UGQzQkhCSTVmNnl3WXdjY2pTWXpwdEFNeW1qYWRMdTFET09kMk1vV0xMeG5I?=
 =?utf-8?B?ZFQ0cC9iNkUzMWhlOHJic3FxUlFwWklWUEhTZVNNdU4wSUZGSlEwakRFd2M5?=
 =?utf-8?B?NkUzRERCN2RId2RCZm9UUGZKN0UydEZ1U01kZ0ZRMUVsSTJlak1aM29NZWgx?=
 =?utf-8?B?MVVuaTNaREIzaVZ4UjA1eDJoeDFYekRGam1vcjdaUlNhaWZDWUlNeXA3S1NO?=
 =?utf-8?B?TVVyWHRFRUVreEtTYzNlWit0c1EycWVQckZYb2dxYTd5WjZScEFFSktkeWZ5?=
 =?utf-8?B?dG1rTFBiRWIrSUZHVjVyS2lhVTFnZXZVWDJaOXdzMUZQWjRrUVFPZlc1Nzcz?=
 =?utf-8?B?UHl4YmRVVlJRN0RtUkhabG0yZmIxUXlZU096ZGoxb2loWU5PYWlhMWp0VzRV?=
 =?utf-8?B?d1NPSHZ3Q3F4Nm5xWENIaXhndG5xSTdUcnhheWxYOG1wOWZSTnhwdWdRKzl4?=
 =?utf-8?B?ZW43OVlJVW8rMXZ4TldndERLRW1RM0JaM2l0Q3ZVUDFQSEpaK0NLdDRLVVlm?=
 =?utf-8?B?b3NvSjYrOVF4WERlbUU0R1FFK3J6bUFqMzR2SWRhMFpLeE1TRVZLSVRGQVlp?=
 =?utf-8?B?ZElrK3dzMEhneGpFaUlsSVdGRU9kazgxQ3RKQUxnRXRwUGY2U2hvWTlWMS8x?=
 =?utf-8?B?aUlFMVUwdEdXOW16UVNSVklHemlYWWtSK0N2enA0emgxUWpTUm1UZUt0eFRE?=
 =?utf-8?B?bVdFVloxbHlpOUhEM1Z5V0Zmek52RUY0cE0vdXRJSzEwRkloUEU3RHBmY0U2?=
 =?utf-8?B?U1ZyaldKVXorcFNYbldvanBROFN0VnEvWmZiOGJJVVJ3L2tvMXlyV2pMdUVL?=
 =?utf-8?B?THVia2xESG5MYlpUS3RsZ08rS0pjZkFSS0ZwU3Zsd2srdnlXRk1LVjMvVWV3?=
 =?utf-8?B?NEtZZ29oaWRCZktFb2E2S05HUzRIcGx3QzBvKzU5SHJNdzEzMG5kZWlubDl1?=
 =?utf-8?B?WFBHd0tsRk5MM3RENlN1U2o1ajVvQ2ZUNUMySVVEMm9TZkJZNjVXSktSd21q?=
 =?utf-8?B?M0ZIcHBUZENsUTJmVkRwZW1hWnNtWXQrNzhPUGRmZ2ZFV0hZK2RIWEtvV3Nw?=
 =?utf-8?B?b0JEb0l1SUhrWVRHdnArWDN6cGZaK0RqeXFEWkFERTZPNi9RRHZJMnhjWmhB?=
 =?utf-8?B?dmdTRUVJZ3RkSWFuL3hVK1MrR1FUSTJXRTkyMG5KTXBTNnJ1OHR4M1RndE5M?=
 =?utf-8?B?dE9aeW9HSlZnOEJiWDdIK09KZStPb0ozcVJQSDhqUjVKOXNCZEJ6YWM0SGVV?=
 =?utf-8?B?MFF6NEdrRDhvWXh0Uk5SZi92ZTBodVJaNGdMM1RGWjhxclJ1cW5VeERZNHZL?=
 =?utf-8?B?cjJtRFBhZUJXU3NUWFBaVU1sNTNXcUo3Wm05TjVMTXdYOGt5cm02bXpmcVQy?=
 =?utf-8?B?T1FLZUQ4dGdlZ2hHT3I2RkE5MFFOUjVLQUQ5eHkvUDdUOUNGbzhubmZFaFQ1?=
 =?utf-8?B?UkJzRkVReCtMaE5nTjljREMvN0t2dWV5ZDFvRzEwVDhObTNnMTVGcmNQRmw2?=
 =?utf-8?B?ekNrVm84VmNJNTBuYmMweDhTaXBlZXl5SEdDTEIybHNHcklSOHorOUc5Q292?=
 =?utf-8?B?bG1Ja2IwQWRUNmZzNDNPMUNzSlAvcjlKWHZEZW0vcnhPQnNrcnR2OHozK3U0?=
 =?utf-8?B?TkFxQ2ZsbktmZGdPbVJaQUJXQkhOMENJaFBRWC9YUkJUdi8wL2lLZUNIK1Rs?=
 =?utf-8?B?a0lKdmRFVjdzTGUvcHdXbWhlNjg0THVQcGFEL2pHcGNJeCtRWGttZEl6RVZT?=
 =?utf-8?B?K0RnTGl6dHRkaW91cThiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NElWTnNEY0xmdEg3TUNjWEpsWFJDeVNPdllEbDV4azRrMVVtWXJXWDNnWkFY?=
 =?utf-8?B?T3pOT2NkN2UwVXRnRG5wd0pQQVdQM3pDSlBYTzZReFFuUEhpemxMdVBiSTNZ?=
 =?utf-8?B?MEdHTi8yRFhiS3FmUHpoT21RM2NaNlpyQXNGZUhMZEgvLzRKakFWNWtUY1g4?=
 =?utf-8?B?UUpZb283YVU0N2NKYURPWXBhUUszQk50eDhhS2ZQNk5TQzFESmpjSWxzbzN1?=
 =?utf-8?B?S2JQajR5NTZlMkVabkdkSittRGp4TlBzaVRZVFVTL01kOTREY2VLVkNhMEcw?=
 =?utf-8?B?dFpXNTV1Qk94L1RrVmtOUlVWZ2RhQ3JncGdQTmR4eGFVbWR3azVnMGl0cEpa?=
 =?utf-8?B?bDNhekpLb3pud2tIREd0ZHdZVlFqV0t6UW1rU1J3RUlNQWN0L0FYMlhlWkVT?=
 =?utf-8?B?cWw3eFd4QThzZTRBK3dZTXZJY29pUitTU3E1T0dsenN3YnBsUzUra1lrYkw5?=
 =?utf-8?B?RFVnUXdNRFpJNisyWFk1aWRIbmd6TFBqM1d0Q09sK214UFhNOEIyS01GbXNY?=
 =?utf-8?B?cDMzYU01Y0luS2JURHR1dWpwQ2VRdkdRa1V2dVpvM1daWmxJZDlZSEUzdFBO?=
 =?utf-8?B?Z3FJc043V0FPYTBHRFpXNjIxRSsrTlB3MWZ6cXMxZ2tZRDhCMVEwYm1iNUJm?=
 =?utf-8?B?RzFtN2JtUUVTMWYwMS9XdFdpemRGemJvRnYxUmhiWnVaNWtRMXZ1Nk9WeDhM?=
 =?utf-8?B?eU42R3JxUUpicTdtTWthcjFFWUpiczB1Z2I1aHlxUlVHVU5wb2FUWFhPZG44?=
 =?utf-8?B?ZHExMlIyV2N5TG1VRnFNLzFzUE8yV3dTMzJTSmhkamZ0TjFpN2pYeHlXd3ps?=
 =?utf-8?B?Mkx5Yy9kL2Q5Y0N3VmY4aWJnZTdwV3B4NWdzQWVlUUZiUmlSUldRRmZKcThy?=
 =?utf-8?B?QnFqcHJEYUxMYWt2TldDMnZnUjVmRUZ0dmdzYU1sZFB0dzduSG45QzdsWmIy?=
 =?utf-8?B?MTJSZW02VHhILzZnRWQwSnNEYkNQNnBWMzlxbkFJdXVSaC9kajJqYnFIRTdZ?=
 =?utf-8?B?ZzVsNlp2ZDVBQThzQUZ3b0xEK2x5TGpkY3dNOE4rRGhvcVdMMlZ0b0kvM2Qy?=
 =?utf-8?B?NUJHNmgxeEFEa2NQWmhMdlkvQVArdUZQTEcxajIreWMwbjlld3dwZTBUYzUw?=
 =?utf-8?B?dG4yTjZRYUFTNSttZDFGSGJQeTI4Sk52UU1GejY4SVE5VEpmaS9GR3QrUXdm?=
 =?utf-8?B?cDkzNHNENzBFYmgwUkQvVmk4dGYxUm1ISGx1L2ViQ25ZNW5XcUI5OVJRYnI5?=
 =?utf-8?B?TDJZejdkNzh4NHBXYnRQSVBma0ozM1dQbXQxOEhyYWNlSHZrY0NXajc1Tndh?=
 =?utf-8?B?Z0dNOWYzVDE2a1R5N2MzV2tOVDdoR05sbkZHTGtVVENtWnduZlpvNGFWT3ox?=
 =?utf-8?B?VEJCMHBwUnU0bUJUcnhucWQ4ZjBTOFl1czlGTVhjR05CUU5iL2lyUDMvODJ6?=
 =?utf-8?B?RG5jZVdLZHRpckpGM3NFaWY3NHE3dGJBMHJjWDlGYVN2Wnk0U0FVS2x0VGg2?=
 =?utf-8?B?QkhXTSthMU5VNExkRXViRHB6aWduV1p4akRFMlZwVnc5QzdtS1hMSys2alBV?=
 =?utf-8?B?dlAwNGV1VlQ2SS8rNFFVbWxWelc1ZEo3TTJNTFVMY1REWlpEVTMvZUxlNmNw?=
 =?utf-8?B?OStESUlJOW1pK0liUEtIcUNRVU9ibmlObjVaVW5XTHVXamFUaGJ0emVTVVJH?=
 =?utf-8?B?eU1DRjJvNGdSVDJXV0hCeU5SNVZxNEZ3cEVjZWVOR20wUGhRVEkxQm5mejdN?=
 =?utf-8?B?SVpPaytJdkFkdjhxVkZXdU9mdko1d1NpMCttdTRwRXVxNllweEhjN3FsNTgv?=
 =?utf-8?B?Nkl3RDRYNTNWTHlDL2s5bFNmVHIxbjNuQ2gvYUxLUkpZNmh2U21wa0pvSGxK?=
 =?utf-8?B?ZVRQa3htLzVoYWpoay95NUdoVVRyd2dEOGd3TnR5WHdOOC93eVk3dTRSOXR6?=
 =?utf-8?B?NmlxTnJEMHFpK3htdHVNTUt2Nlh3M0lyYUFhRXdGa2xQZU5ieklHQ2NJaVV1?=
 =?utf-8?B?T014MjJ6Vmk1YnQ5bEcvdHI5MXlsQ2N2VFJwdWEzZ2o2MGg0NHBKR3l0UWdE?=
 =?utf-8?B?M2o5RWhqbUdrNS85ZGpGN2ZERll2clNIenZBc00xcFgzR0pSRi9aUm0xdWxo?=
 =?utf-8?Q?gK4k=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aa111a-74c3-4ebb-8e1f-08dcd4090c01
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:30:50.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQs+sWuv1/Rsi/6S2iRyLFIjfYASKPblhCnaSvWT/vRM1PC4jUPkDrkeT06Ty28v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6660
X-Proofpoint-ORIG-GUID: SuwVA-1tEtNygELp76Sm1Wsu3rpHo5Ar
X-Proofpoint-GUID: SuwVA-1tEtNygELp76Sm1Wsu3rpHo5Ar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01



On 9/12/24 6:25 PM, Linus Torvalds wrote:
> On Thu, 12 Sept 2024 at 15:12, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> When I saw Christian's report, I seemed to recall that we ran into this
>> at Meta too. And we did, and hence have been reverting it since our 5.19
>> release (and hence 6.4, 6.9, and 6.11 next). We should not be shipping
>> things that are known broken.
> 
> I do think that if we have big sites just reverting it as known broken
> and can't figure out why, we should do so upstream too.

I've mentioned this in the past to both Willy and Dave Chinner, but so
far all of my attempts to reproduce it on purpose have failed.  It's
awkward because I don't like to send bug reports that I haven't
reproduced on a non-facebook kernel, but I'm pretty confident this bug
isn't specific to us.

I'll double down on repros again during plumbers and hopefully come up
with a recipe for explosions.  On other important datapoint is that we
also enable huge folios via tmpfs mount -o huge=within_size.

That hasn't hit problems, and we've been doing it for years, but of
course the tmpfs usage is pretty different from iomap/xfs.

We have two workloads that have reliably seen large folios bugs in prod.
 This is all on bare metal systems, some are two socket, some single,
nothing really exotic.

1) On 5.19 kernels, knfsd reading and writing to XFS.  We needed
O(hundreds) of knfsd servers running for about 8 hours to see one hit.

The issue looked similar to Christian Theune's rcu stalls, but since it
was just one CPU spinning away, I was able to perf probe and drgn my way
to some details.  The xarray for the file had a series of large folios:

[ index 0 large folio from the correct file ]
[ index 1: large folio from the correct file ]
...
[ index N: large folio from a completely different file ]
[ index N+1: large folio from the correct file ]

I'm being sloppy with index numbers, but the important part is that
we've got a large folio from the wrong file in the middle of the bunch.

filemap_read() iterates over batches of folios from the xarray, but if
one of the folios in the batch has folio->offset out of order with the
rest, the whole thing turns into a infinite loop.  It's not really a
filemap_read() bug, the batch coming back from the xarray is just incorrect.

2) On 6.9 kernels, we saw a BUG_ON() during inode eviction because
mapping->nrpages was non-zero.  I'm assuming it's really just a
different window into the same bug.  Crash dump analysis was less
conclusive because the xarray itself was always empty, but turning off
large folios made the problem go away.

This happened ~5-10 times a day, and the service had a few thousand
machines running 6.9.  If I can't make an artificial repro, I'll try and
talk the service owners into setting up a production shadow to hammer on
it with additional debugging.

We also disabled large folios for our 6.4 kernel, but Stefan actually
tracked that bug down:

commit a48d5bdc877b85201e42cef9c2fdf5378164c23a
Author: Stefan Roesch <shr@devkernel.io>
Date:   Mon Nov 6 10:19:18 2023 -0800

    mm: fix for negative counter: nr_file_hugepages

We didn't have time to revalidate with large folios back on afterwards.

-chris

