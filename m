Return-Path: <linux-fsdevel+bounces-67220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D6AC382CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE3B1A20BFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905512F1FDD;
	Wed,  5 Nov 2025 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="lreIWXya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476C2EFDA2
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381272; cv=fail; b=hfL1IXg2jEf5b7HOi/F+uOhvtdI5OPr3wMgdGmKg050KdMsNDnfCtE7DilZUbsZ0YZnlj6R5aQTrq9i//QCUyaNTSJ5sBvsLNpyRdUFxWQz79E7zfZVc2j0G3pnf5AtbZJEnJrhqhC1bGV66Z5y0AWl+foxFR4lunKYVggiYvrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381272; c=relaxed/simple;
	bh=hLLsITK+HuSLHeSm9sg7jazOse9k/fh8qLqiB9eJDDc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1o6oPN2ukunD4a87BShHEwbD1bRCqUNiLwOAkXK9iHivDrMnf31+oW+y/40botLAnBdJslrCkt3x1iKhX7AfFnEwCsgLg52mS/CCqjWZyFKhVaERMDQvok5LYOZVBFMgbpu4Y6E6u5NMO+5BGabwYSP0YoJHR9DgLGR5CLBV/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=lreIWXya; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020113.outbound.protection.outlook.com [40.93.198.113]) by mx-outbound8-174.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 05 Nov 2025 22:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDStpr0C84lnDd57SkoHyCadmPSZo60/gXKmiyz7zomnSPFXBGG0PmdYJpwR2IkdqYSghDkT4dRAjP61a3a9ntrs3hztqTYYcsRRb2WyqPgXMTMCSPaZE7ZLYUChEkVXWeXCxMgl30LRmr79EnHE/P547gei42EqeN4HUE7OuOCeB0xx4PYRGbhaaPJqzAULom5OmDfwDXj0b/urtHvk1dLh6QJZLUg2MReVp4WdOt3J9XxYXjaJNxmk+J2RIVifLEmBNokADiqASllk1ZyPK4j0bhQuY21VH/OaZz9YcZ2oa22K+ZCYqWqtxiaCyP7fdjI3ipKvFZCGOyU+4YAJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwDZBjiqlhZp/7DUZI34gS+/dSJ83i2SpSj4Q2KzXyg=;
 b=e+FYxn1VKeEN06jRUHFTmosd5tlePWY1tYIfXeSZdo7EyOm3y1sAdOO6JxunogLUo4sElRcR2Zi+zA5YGVlec/OmUJPqoMSIYa+ZzStOxHoNjFMJOoApusYcNkjQ9SH1CHUqBGRzVuDhgMB02oA3vrmWmHA+exUoe0CC1kEgf1R5tkrDDhITNU1ZX5t0zh1/9daLpakY6GxhaLKSWlkOm0r41WYpN8OrKvI9fCqb+19eb2pHjT+IPsBM2xHcw4qvTvgCaqMGqpAKbJHxStNkiNn+S8MoaItGvYqdxkUXjjIXSe6HpiKyJHj3/Co5moOMxd1bLhk7i90NmxTQ6qf69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwDZBjiqlhZp/7DUZI34gS+/dSJ83i2SpSj4Q2KzXyg=;
 b=lreIWXyanjcFzsLFmOAr8F9SqFM0RjceYM/p612lfLJ534/qbDJAhmdKdbv9Ghe0pNVkEsGLsteI/hmTmLIHhfFcjjl0I2CIjmT5LhV8QGQFbY7Pm3OIU+gyReWERknbiv69FJU2xN9VWAYnSmP/s2sum3yiNb39JkDfaXvS0is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by IA1PR19MB6250.namprd19.prod.outlook.com (2603:10b6:208:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 21:46:33 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 21:46:33 +0000
Message-ID: <cb7c4237-74b4-4220-90f7-caf59d673bc4@ddn.com>
Date: Wed, 5 Nov 2025 22:46:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Another take at restarting FUSE servers
To: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bernd@bsbernd.com>,
 Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Chen <kchen@ddn.com>, Matt Harvey <mharvey@jumptrading.com>
References: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
 <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp>
 <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <87cy5x7sud.fsf@wotan.olymp>
 <CAOQ4uxjZ0B5TwV+HiWsUpBuFuZJZ_e4Bm_QfNn4crDoVAfkA9Q@mail.gmail.com>
 <87ecqcpujw.fsf@wotan.olymp>
 <CAOQ4uxg+w5LHnVbYGLc_pq+zfAw5UXbfo0M2=dxFGKLmBvJ+5Q@mail.gmail.com>
 <20251105213855.GL196362@frogsfrogsfrogs>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251105213855.GL196362@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0105.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::19) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|IA1PR19MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de9ee85-5352-44b1-16c2-08de1cb4c98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bmdmY29nZ0xVWkhIYldhSEF2b3BYNzY2MzBwWTk1UDNENE1KMmxnUXZlTFNU?=
 =?utf-8?B?dE5FbjRLTkdZaWVYSzdyZy9Tc0YzMHlOZ0ZLRzlxa1AwcjBSUVZiQTNvK1Ni?=
 =?utf-8?B?dW9lbWgybGhpbExleUMyTUZkeHRHSzZjOVVKU2VTRTV0STZnSEtxUVlMcmJH?=
 =?utf-8?B?Y0VlUHgzUGx6N0ZrTHQrUk9NaXlaaVAwYjR6V0c3S0VHcTdDSFF3VVJHWXcy?=
 =?utf-8?B?YTFjd1BtQzZjZUhIUmpjb0VPM3R1dkF0c2prWWZDa1lxd0twOVQ0R2hDOG9P?=
 =?utf-8?B?RXhvTFJXQnZWRy82aStBL2ZXWWR6NjFXam5acFRETnByN3g0a2ZPck1kR1Mx?=
 =?utf-8?B?amEvYlp3elBtd2xGN1hIYW4waGFaU1hpemVsK0dnOWFudTZMQ05wKy9ITlVI?=
 =?utf-8?B?TmF2aDAyRS8rcmkweXhyUkhRa29JMGdHMVkzZFN0MWlkaUlzVUN1bmxtcUpP?=
 =?utf-8?B?UnlBYnZhYjY3anhpUFFzWEdnSXVhMkhrV0VHcHNJZ1ArM21WQXZnNi9oKzE5?=
 =?utf-8?B?NDU4Z3lHS3BCeG91ZVYrbXllcGZpcXpkZTdyUFFaS0xOSWY2M0xWVGxKNkxk?=
 =?utf-8?B?VG5mZGtleWNIOHVYc21UVGw4RFBLNXFzbmpEL0VYYUtIT2N0c2JqK21YaTk3?=
 =?utf-8?B?a05YYWJERTh3d3VWWE82cENabm5PS1lvYXNnOUJZeUlWdk9HVVp1TUFONStj?=
 =?utf-8?B?N1BMeXBUR3Rka0VYcE9OU1NaQW9pbXowUHlVNTNpQXNTYXV2ZWtTZnl1NVE1?=
 =?utf-8?B?Y2l5VmY5ZThBTVB1M3N0cWIwd3NHYUVVYUxTeTVreS9vOFBFUzA3SGlmYUZV?=
 =?utf-8?B?YjZYZXc2QXhSKzRXQ1dhVjk4ajZGMWhGaEpPY3NmOUpURmlSVzVQeTh1aWZW?=
 =?utf-8?B?cmFKS25rbFQ5VExzRFRCWTE5L29NZTJtZC9scFFOdTNMZE9RMWF2R29tN1V3?=
 =?utf-8?B?YnZscGtRUlJvN0FvbXh6eUVOQmxlYjRWZGNhMjAyTkFabC9WNkQ3aW1TZnlP?=
 =?utf-8?B?cVY5L0pVVTRoMHh2YmU1YVRUTFJha2NzaDJDV2VnOWxuY2pUNUllVDAvQXpq?=
 =?utf-8?B?TTJpVzRnNWlPVWNOWGxSTUNXOHZhdDMwNjZpQytRR29CeU5BUmhJUFc3Rm54?=
 =?utf-8?B?QUFqaEJuYnRJODBDK0o5RnE3a2c5Mko4eFVEOW5QMTNVSWdvajhmcW9GakhB?=
 =?utf-8?B?QjUwV1F1clNoeWw0VDg3OWlUb1NFL09rVnBsQWxPalhSTFB2SEpCTnQ4Vlhj?=
 =?utf-8?B?V0tuRG1rb3k5QW9vY1JCb3o1Y1ZBMlRhQndlcTFrUzJ5R1ptOGU1VjJrbnlE?=
 =?utf-8?B?NWNGUWR0cG9PSXI1dzhjM3B3NnRaaXkrTlg1SDdZMDlHYkhWMkJ0dEhMbitD?=
 =?utf-8?B?QWxkTHdoUjZmQ3hkUTd4SndHdTZ1VGJ6Q01RbjVXaTdZdno0dHVtcnNLem1E?=
 =?utf-8?B?OTBxMDVveGRmdmtZN09uRTBWclIyd3N3cFBrZFhMTG9haE1KS2tPQk1aNXBj?=
 =?utf-8?B?Y0Yxb0h4SktzUXF5MnNFbys5REp1ZnJEUkxpRlFWa1dKQlN1QzRCUG4zaVVK?=
 =?utf-8?B?V1VhNHdjdWJZMEVudmVrUFppNWN1U3Z0M0VXcG1kdTI4eUgzT21NMFh0T3c1?=
 =?utf-8?B?VDN2QiszbW9DTVVNbkpIK0FJZGIyZnBKYjhwdzdEQ0s4c1p5dkcyUFhrWUhS?=
 =?utf-8?B?OGRGa0RldlRwUkc5VFlkMGlDVUNIVGxLWDNkbTJUeGVpSXRveG1YcnU1TEF5?=
 =?utf-8?B?QkFTaEhNSFhWaUxvWG1tSERNdTMzNmY4c3hhU3kvcE1RWkdFVWlvdlVTdllJ?=
 =?utf-8?B?TFZiQzBVbWxmbGpMQkY5Z1dLWk5neVU5RUpJQUZ0VGJuR215UXczWU9WOTFT?=
 =?utf-8?B?N1BLVTcyNUF5TjZHUDdoelpqNmdQaG1FZG00ZlY0cWpBeENLTnJSTkhCUUIw?=
 =?utf-8?Q?n+sBc9X4c0XpHJUQo8nuNwxSzC2gh9ZA?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(19092799006)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Rk1RNGVnWldMNFZUeU91Z3BOZngrMkpEU0FtNUNicEYzL3BCc3VqZnJ1MHEw?=
 =?utf-8?B?WE8vVmVTcWFNRkNZdWNDQUdtSmZERDVEekxIa0p1dmJ1aHhsaG1ZL0hLTyt2?=
 =?utf-8?B?S2tWaUVCdVRDZzBTRlVGNzJTSXRLTVJJNDdVTEQwQ0FnVnlKVndHdGpmRTl4?=
 =?utf-8?B?dFF0dlRaU0p6Y3R4T0JTS1d4R2xBOVM1VmQvNXJkMWkzN0pSWEk2UGduSW1K?=
 =?utf-8?B?SVdYVnAvQjRpS09VWXZQK2lMYkVZbzlwNGk2YlAyaEJyZzd0WWV2aHIwWEZL?=
 =?utf-8?B?NGpZT1JsZGpyeUxHbXFoSm5uRWJzaExpTSsrYXZlRVZEY1VkWXZyN1V3TUdl?=
 =?utf-8?B?NXNhYmFKN0crZTEvaTI0MTNtbG10Nmg0OTFQeDRYdTVXTDlSUHZPNEN5Vkk5?=
 =?utf-8?B?SHdrVlBkR0hRbFhqVkxMeHd3eFRBNDg3TGlIbXVCS0t2UWNUUkthVkJ4Z2E3?=
 =?utf-8?B?WGFNRktlTXk1YzZnZGpEMERSR0lVNUJ4bFdDL3g3RjNlVUQ1NlhMeklaRzBZ?=
 =?utf-8?B?cFg0Z00rMzJKeUFtMU0yWVh4OVRsVGhlVEJZSmZuQVlhRjg4THBCcDc3K25V?=
 =?utf-8?B?YjhNOUpYWWVzdm1QY0ZlYXdSSWZiaUxIUm51eTd1bVpkWWp4VmpwZGZCa2Fq?=
 =?utf-8?B?Qy9IVmRiUDlVbkY3TnkzVXFqNU1pN051V0lMYmhMSy9TOVgxdi91bzRlQ2w3?=
 =?utf-8?B?WnFWOGJSNnRES3lud1QzR0NnNGVuNU9WT2tlbCtxdXdKckdSUXByTEQ0L0Iy?=
 =?utf-8?B?cmx2MGhDVUxxWnJDRDJBYVM1OHR3WkNsR1RKL28zWjB6VDU2NzU5ZXVDZk4r?=
 =?utf-8?B?VFJMZGlxaktUR0ExVHhCWWZOWC9CZWliTy9KTld1ZVRSZ0cxdEs0RDcvOERJ?=
 =?utf-8?B?Nkh0VURUY0w3RHBWaldPSjdoU2ZIa1hnWlBTV2owUTN4NDVvV1A5bXNGbkNB?=
 =?utf-8?B?dnYyTkZKOG9sS25OdHpQakdUYmJhdEx4ejBRWGxsSmVyYVc5TEhFdXhyWGZW?=
 =?utf-8?B?ajJuaTZlR1poazBhOFF0Wk45SGtQL2RONWh2WU4yQnV5SWVBc0d1VUU3S3Z3?=
 =?utf-8?B?S1B1VUg5UFFMQXhIZHF6TWEwTElXSzUrZkpUaUhpNDc0TnhkNEN3ejkrZ0Fk?=
 =?utf-8?B?aFNWSzZYbEZGS3VIUG4vcXFFc3BrRXBiOFNYeVpIU0hEcXY2VUpBREltNE9q?=
 =?utf-8?B?ZUMvcDJWb1RkQ1BWS05wRUZaL3hVdlBrQktHY05QT0lyZys4T2JwRDlvNW43?=
 =?utf-8?B?Qzdyd3dFT3c5Y3c0WnpvMDBpb0pPcFhaTnhSbVQ5RE14V0hDeStuUVVoZklU?=
 =?utf-8?B?NEQ2cnhPRm41cWN2QTZrL004b0xSZ0QwRTVWUUx5RTFjWTQ0eGc4bmtBS29o?=
 =?utf-8?B?bXB0bFBqdDhMWmtHWFBzZUJyR2VSRC9sOEFYVUsrdnlHSzNOVWhGK0lOSngz?=
 =?utf-8?B?SERMeEZIaEZlbmk5TExUR2FNeHVTWEpCcDhaam91L1A4a0hxaTRWQm0xMkxz?=
 =?utf-8?B?MnJncEw3U3ArbnZMdjYzd1VCZlpnNWt5Z011TGJweVEySkwyKzByalZEaVFW?=
 =?utf-8?B?ZmIyV2ozSG1KN2sydkgwWGpxZjVDeWxnRTNiSVFKVm5nMzNoa1pBd21hNjk3?=
 =?utf-8?B?SHRhQmZmTjkrWEcweHFaeXJkSXA3RVFnQ1pOd01md0liRXZCZmRNL0sybkVT?=
 =?utf-8?B?Qlp0cThXU1FOYURYNVdrSkY4YzRDOGdoc2FDeC9iZUFMM2JRVE9IWjU1c0VP?=
 =?utf-8?B?MEV4UnFRMnpPZjExT1pONkppWGFpWUtUV2t6WmhlQkkrUzk5WTgrTkdKMW9W?=
 =?utf-8?B?alpJakY5N2xjSUhYbktBMlA1T2d1a1c5MlBmV2l5YU5PbTdDNDFKTUR4V3ZF?=
 =?utf-8?B?MHAxYi8rUkw1cHZ5Mnl2Um5aYVRRb0VCKytYdVh3b3NGZWNPQ29FR292bUll?=
 =?utf-8?B?dTQ1dlhOdXduL0JsenNaUy81OFdNby9sMWd4ejRCeXQyNUEveGJJRE5ZQnh0?=
 =?utf-8?B?TXVGbWRibG13RWhNa0U2bkFlajFudDhVaDRpNEVFMUkwZGVHazczclg3Zmx1?=
 =?utf-8?B?YTJUT1FFeUowM2g5YnRjRXhNVVVVNGQ5bTBzdjUyV3ZONC9RcDZQbWV5dGhG?=
 =?utf-8?B?aTZQQWFyUWJNWXVkMXh2WStHL2JtYkNBaEdOdFF5RjZrMjBuME5keXdtaC9P?=
 =?utf-8?Q?38bBd9OFOq7X2NFD6+6aRdl6lrKgrKE1lXGPXBHfIwQH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 vKJdwUul07NBjNQiDtS7GlMofjSTHo5P+g3AaB96RvglOaUYr1SsYRuZOPke1v5Jr1khnIzDBJE/foUC2hE7UvGAP8sB0dH2ANTodlV4moLJu8eoq/fLdu9S5Zkrc4t4nu0Cj7esPDPBWLtwGdTVzYAmEPNq40k4donjln+mO7XNJmpdtTtSB/V1rPQkDzzNWVwCrvIcCLzdbX6L5bMUidW762qlx1c1jn+Zrp2P+H01beguuNW6Xw/gssHtYgkQ3bdW44I4AzMK3fsHPVZ9dxLBXH3+w7+rX2MiDa1gaw2k/o2vPJ4O6Cg0wcb84YVkXnlb4qR1b2KZh84/+LzsxzswTIQkKmjRMuOsH89sxKLudQ67rIv+J15m9/j5F1zH23jHS/YEoraIviddcYNCg/KwNWus+P9TG/oD64V20yp4aVKiphKSGyDC8qhGl+ZIqQJXqFemBckbcpneYjJ+VfoWf2V+B6veC8wrMpqeYagq2MzLy4CFh4YdeRygW8ZmE+SNGGgp8wQhO1uV+UhXMYoGLwDKYyuZP7pWsYS15qFFUWfs7s8yOA8IK6kRxtMy/k8P2G45Fq9sKxyFBvHs81EyU2lJLUYI1DVPvuINM+Ebg3h3qswKUU/QEHfBC0GA2sc2Jez9r0QxM/tq8O2X+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de9ee85-5352-44b1-16c2-08de1cb4c98d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:46:33.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiueH0nv3NFE8qsWOaL0IpRH3nDt8UtlRy9Q7KXMAoWJm2TjgR8nCUPFBsxkNS+6lFMUP6vtzpe7yn5jteUzrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6250
X-OriginatorOrg: ddn.com
X-BESS-ID: 1762381265-102222-2930-6407-1
X-BESS-VER: 2019.1_20251103.1605
X-BESS-Apparent-Source-IP: 40.93.198.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYmlkZAVgZQ0NQk1TA5zSLFND
	HV1NQgxSzVIDHVLM3UwDgp0dDMLClRqTYWAIVu5W1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268736 [from 
	cloudscan17-50.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 11/5/25 22:38, Darrick J. Wong wrote:
> On Wed, Nov 05, 2025 at 04:30:51PM +0100, Amir Goldstein wrote:
>> On Wed, Nov 5, 2025 at 12:50 PM Luis Henriques <luis@igalia.com> wrote:
>>>
>>> Hi Amir,
>>>
>>> On Wed, Nov 05 2025, Amir Goldstein wrote:
>>>
>>>> On Tue, Nov 4, 2025 at 3:52 PM Luis Henriques <luis@igalia.com> wrote:
>>>
>>> <...>
>>>
>>>>>> fuse_entry_out was extended once and fuse_reply_entry()
>>>>>> sends the size of the struct.
>>>>>
>>>>> So, if I'm understanding you correctly, you're suggesting to extend
>>>>> fuse_entry_out to add the new handle (a 'size' field + the actual handle).
>>>>
>>>> Well it depends...
>>>>
>>>> There are several ways to do it.
>>>> I would really like to get Miklos and Bernd's opinion on the preferred way.
>>>
>>> Sure, all feedback is welcome!
>>>
>>>> So far, it looks like the client determines the size of the output args.
>>>>
>>>> If we want the server to be able to write a different file handle size
>>>> per inode that's going to be a bigger challenge.
>>>>
>>>> I think it's plenty enough if server and client negotiate a max file handle
>>>> size and then the client always reserves enough space in the output
>>>> args buffer.
>>>>
>>>> One more thing to ask is what is "the actual handle".
>>>> If "the actual handle" is the variable sized struct file_handle then
>>>> the size is already available in the file handle header.
>>>
>>> Actually, this is exactly what I was trying to mimic for my initial
>>> attempt.  However, I was not going to do any size negotiation but instead
>>> define a maximum size for the handle.  See below.
>>>
>>>> If it is not, then I think some sort of type or version of the file handles
>>>> encoding should be negotiated beyond the max handle size.
>>>
>>> In my initial stab at this I was going to take a very simple approach and
>>> hard-code a maximum size for the handle.  This would have the advantage of
>>> allowing the server to use different sizes for different inodes (though
>>> I'm not sure how useful that would be in practice).  So, in summary, I
>>> would define the new handle like this:
>>>
>>> /* Same value as MAX_HANDLE_SZ */
>>> #define FUSE_MAX_HANDLE_SZ 128
>>>
>>> struct fuse_file_handle {
>>>         uint32_t        size;
>>>         uint32_t        padding;
>>
>> I think that the handle type is going to be relevant as well.
>>
>>>         char            handle[FUSE_MAX_HANDLE_SZ];
>>> };
>>>
>>> and this struct would be included in fuse_entry_out.
>>>
>>> There's probably a problem with having this (big) fixed size increase to
>>> fuse_entry_out, but maybe that could be fixed once I have all the other
>>> details sorted out.  Hopefully I'm not oversimplifying the problem,
>>> skipping the need for negotiating a handle size.
>>>
>>
>> Maybe this fixed size is reasonable for the first version of FUSE protocol
>> as long as this overhead is NOT added if the server does not opt-in for the
>> feature.
>>
>> IOW, allow the server to negotiate FUSE_MAX_HANDLE_SZ or 0,
>> but keep the negotiation protocol extendable to another value later on.
>>
>>>>> That's probably a good idea.  I was working towards having the
>>>>> LOOKUP_HANDLE to be similar to LOOKUP, but extending it so that it would
>>>>> include:
>>>>>
>>>>>  - An extra inarg: the parent directory handle.  (To be honest, I'm not
>>>>>    really sure this would be needed.)
>>>>
>>>> Yes, I think you need extra inarg.
>>>> Why would it not be needed?
>>>> The problem is that you cannot know if the parent node id in the lookup
>>>> command is stale after server restart.
>>>
>>> Ah, of course.  Hence the need for this extra inarg.
>>>
>>>> The thing is that the kernel fuse inode will need to store the file handle,
>>>> much the same as an NFS client stores the file handle provided by the
>>>> NFS server.
>>>>
>>>> FYI, fanotify has an optimized way to store file handles in
>>>> struct fanotify_fid_event - small file handles are stored inline
>>>> and larger file handles can use an external buffer.
>>>>
>>>> But fuse does not need to support any size of file handles.
>>>> For first version we could definitely simplify things by limiting the size
>>>> of supported file handles, because server and client need to negotiate
>>>> the max file handle size anyway.
>>>
>>> I'll definitely need to have a look at how fanotify does that.  But I
>>> guess that if my simplistic approach with a static array is acceptable for
>>> now, I'll stick with it for the initial attempt to implement this, and
>>> eventually revisit it later to do something more clever.
>>>
>>
>> What you proposed is the extension of fuse_entry_out for fuse
>> protocol.
>>
>> My reference to fanotify_fid_event is meant to explain how to encode
>> a file handle in fuse_inode in cache, because the fuse_inode_cachep
>> cannot have variable sized inodes and in most of the cases, a short
>> inline file handle should be enough.
>>
>> Therefore, if you limit the support in the first version to something like
>> FANOTIFY_INLINE_FH_LEN, you can always store the file handle
>> in fuse_inode and postpone support for bigger file handles to later.
> 
> I suggest that you also provide a way for the fuse server to tell the
> kernel that it can construct its own handles from {fuse_inode::nodeid,
> inode::i_generation} if they want something more efficient than
> uploading 128b blobs.

Isn't that covered by handle size defined in FUSE_INIT reply? I.e.
handle size would be 0B in this case? 

Thanks,
Bernd

