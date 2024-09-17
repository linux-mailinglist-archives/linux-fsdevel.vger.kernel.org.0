Return-Path: <linux-fsdevel+bounces-29579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276897AF4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 13:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3CD281F08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 11:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77954166F33;
	Tue, 17 Sep 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lXg9hs+z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315F8F77;
	Tue, 17 Sep 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571623; cv=fail; b=U/Oe7pRBvuR+JZ3o9gdb2e4SRv8MluhUkDG+o/iaSplCpJWR/zNOyEeVgmQlKNjVtKn6UsEHXt40Gr0yIXx04XTVjEAkDtewlHHV0Yr0N8awiH7Eob9nAu5zTT2IH+920vn0t7RCK+1aSVb4UM0r+qZ3tjxGYRdV4ApQyhS3yv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571623; c=relaxed/simple;
	bh=Txl0aTUh9ox4Qnb8XqHjJwfodT1wSJXHzEvpej8FlZY=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=RJhqcx6K4WtjArCri1To/sNBtMFk/pALiEWQV1lteosnNfsRTMrwmhB/LPJoHuXeHfflofIz2XDWOHr7XcDEruqBAxxT9nssfxKLvWBpIZzAe7NTW/EY29dzhXv0HBkkW74FktQqd2c4AiRzNg2MhV9a20nQeGzTtnUQDUPa8Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lXg9hs+z; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H6Ktog032464;
	Tue, 17 Sep 2024 04:13:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=s2048-2021-q4; bh=oN7bKmTsNdnNWTS8Y
	3Em7nFEzXIdboGVaXR4UqVCixM=; b=lXg9hs+z2Xvu6z2IpTHUNE34+u5orcnb0
	drU4bPN2HNO5ERAqlr3gS8b2bzquDZDlZsbfl59CuGT26nI78VAE8mtYHBdoxT23
	3j56c8lXrcbgaRsVgCHMR1Bb3LzUQgEqTk7XtM9wrcGm1T/rPc+KpT1n9xXL6U2H
	wYno3/k8mSZ0rH2+XDMeG4YgKPsoeq4wFGrrYa0ZOivYXvTJI0sz3dlhgOR+VKrp
	pv+kdWPYVjymxUbvqr2350+gkW8GjRHePwJdFPAw9ymj7Rrb1J8T8vmUYpsUS4+z
	OTY5Kn2TIlu7xADMimKquYM9WRjthaVJ8NpfxYrNoyRSTBMHreg2g==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41q4dq12h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 04:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eflZrqaNBOk9YGd5CE/jbuTmd0PcloBMOen2x/9pVV5kdCoGwWDsnmxdpqhMkMPAZ5MpwyIE7uZwL/FsOAy6W1B0JyfSw4fc16OVJeFnNYb6rGNj3YAzTN5N9L65Xhs0g2odTWcyqWbNegGtkjAcgCcAy5xntHC+RPWDFBpA0ROPJ2eFGSYdapbXZ/LRpM4aSmfSVnylpTdVkgMJAweDJZ8Ba7NrTI4cIKLOEesp4hFF/1zuufEk1GN6vNj5sSq3QhoRYgCxlTawdvHYA/LzwGk4oAuW8yBv1H5kSGF9gql/Mh89CDWjp1MUfGMaZrA+mF87Dq1jgvua4w7Vo3Jpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN7bKmTsNdnNWTS8Y3Em7nFEzXIdboGVaXR4UqVCixM=;
 b=FbjZWHkIDEWy2QBzhbh7508cwT0XZTfY/3RZsl9BmQBXNzkwY8HJa8OYpAePcuueMJ7hU4cIRqBbONVrlq/mHFKj1bkgjkKb4goJgHrvE2Z35rHrFoDHJUn+S72L0Ig3zF4KP3wPCozyQ7a1YXYyU7sOWjyDU9thCMS6kUG2Gw1qtwgtKP+D3dIP22/7pCvyVUp1TjUpCNPpM6+1qujKTlDjGjbly25Syzgj9M0nwnNw9sUFAucsaERLsnuTeeletFtioOJIJmK3lE2qS8fq/ld3a6o6keCNaPCZnOicWTPov7BUh+poYCTwqGILJZomyB5V9G81Ppyf6qE3LKAXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ0PR15MB4663.namprd15.prod.outlook.com (2603:10b6:a03:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 11:13:19 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 11:13:18 +0000
Content-Type: multipart/mixed; boundary="------------Sj3V2izOM6Woksdxzan1C3EF"
Message-ID: <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
Date: Tue, 17 Sep 2024 13:13:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <ZulMlPFKiiRe3iFd@casper.infradead.org>
X-ClientProxiedBy: ZRAP278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::17) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ0PR15MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cac2929-ffb3-41ac-ab07-08dcd709bbdd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWhyRmtkaG00RkVXQlRUNGZxRktlOForTjZNbVU3Wk1lTmt5SlQ2bUZnSUE5?=
 =?utf-8?B?cE80U25ORHJkZkZnYVpDWXIzK1lEVE41VUdnWHZsWWJMeWVaUkg2dzJHYzZR?=
 =?utf-8?B?VVJHN2dtNnZwWFFiaWdHbTUzd2JhUFhrRml1djdZd21ZL2JHdWlkcS9Dby83?=
 =?utf-8?B?MGdnM1IwMDVMSWozMzZhbmNKcTYvS2ZiS1VzeWl5WkxTcC9ud2Y0RmFCN1VV?=
 =?utf-8?B?Vkxsc3RNYzFQcWlhVkQ3SmJLMFVMU1l2Y0pmNzFSbzR6MGN0U21LV1hGdFU4?=
 =?utf-8?B?cWYyNE5vRXBtREdvTkIzbExTZS9PbUN3dWFMbEFuZ1VFTFJLK3hJWHRUdkJX?=
 =?utf-8?B?QVU3c0ZMQkI2aUc1WnprbUZCQ1B5TWVIV0VzcDhzRFRHNXBLM3I1dnMwM0xS?=
 =?utf-8?B?azc0bVdMR1VmMVVJbTN4TmFRbG9pV3RhMnM0RnMzS1VHOTRZck5BVVhIQWVD?=
 =?utf-8?B?aTBzWVVHTFJsQm0wNGRQY1dNeDl2akNWVG9jQVFzcVlvTWkzL3htNExLQklB?=
 =?utf-8?B?NXNMYnduYWZsNm1YQ2pFS3QxcGJPbzNhR2kzbkJlSFh0QmM5anlWVXdad01Q?=
 =?utf-8?B?WEM1cklmL0VDbjNwU0FxWlUxMXd0c2RqQkN1VzFwQVdXOHhOR2hDRGxxWVVP?=
 =?utf-8?B?cXVkZ01zM2Yzb3Vrbi9WZDlJZitxMk1nM1VuS01yelJsZFdLbTJTd2NwOVNr?=
 =?utf-8?B?Y3BCaFJBMG8xK2dvYWtjdEdZVmFHbmtXdXFrRU5FSDhRMHRyMlp1cE9BTU0z?=
 =?utf-8?B?YzlDKzRUbk4vT1FGWGg5dWFxcGpHNC9PNHlsREtHR1VBV0E0bUFYVXhDM3Ix?=
 =?utf-8?B?Zk9DbEJsRkptUlNSZDZ1QjRBWEpIb2FtSm5sV2FvK1UvT1F6L3I5OEM3dnR3?=
 =?utf-8?B?V2c2bWRqR0t4ZGVROTZuSCtZV0h3N1BNSnErVmdBZU9KY0ZYT3JtSklJbng1?=
 =?utf-8?B?ZkJoNlkzb3hJNlV1SVpibzUxTTBOTU5wYlBZSXJPNVhpWlRKNEZ0UkdzcWRZ?=
 =?utf-8?B?d3N4Zk9QeE44VVZlZGU4YkYyVWQ5R3lsNW82a1lSemw1anBUNlBXSjMrQ3Yx?=
 =?utf-8?B?amtEcnBMQ0NmMmxjd2ttRzN5cFEweGRhU1BOYXl2Qk5xM0NwZXduZDNlNTFn?=
 =?utf-8?B?RlFmQXpOQ1Y3UzA4dEg1cUNMQnJ2VGJVdy9KNWdIRFBXeHlpa2xlNm5NaWIv?=
 =?utf-8?B?TStubUNBTHB6M1pvRFR4MW9rTUhFdUhQeDZhZ3l6MWJ5RVZBR3VkZW14Tk1O?=
 =?utf-8?B?WVZaSjBnK2MxeDNIaFAvWkZNaTFJNGYxZVEwdVRlcVpHaWtWdXgxRk5QV3Fr?=
 =?utf-8?B?QVBsMEpzL3UxNEhXS0lqRkQrNFRyM1ppZUhUMTdQRmdRK2FRWllXZEFnVjFZ?=
 =?utf-8?B?eUZvSXpCejA2eURLdndXamZkaFNwRXhHNUw4NnVRbG1waUpkUFIzMEpRUmxl?=
 =?utf-8?B?RU1qMjRONkVCcUpVRWcvd3lIc0FzQkw4NHZ6NVhlNFR3cUhYTFZvSGRhSWpM?=
 =?utf-8?B?MW5Jd0I2UnR4cTd1NlpzSE9sVDF2Ylp6U2pKTW1YRWN0UVdiRTR3Ym84TStq?=
 =?utf-8?B?V0UwcXRnZVUrTVlBbm1WL1ZSNDh2djR2eXVlRzZUclB4OHpJVE5ldzlkMzNR?=
 =?utf-8?B?Wm9lV04wR1hlbVN0TlI2MUxoQktmQU9MUWdVOU1QVXp6dHZpclRoa0FOYXdl?=
 =?utf-8?B?UTJWRXRKN1Nxams3VEdWdjY4Ymw1aTFvNTZvMWo5NE1iOTFZWVJaWEpDQndP?=
 =?utf-8?B?N3dPZm5tZm9haVlPTWt3ajFFT0V3ZjNXMTRpVmlId2xnc2pQbjJwK09aak5X?=
 =?utf-8?B?ZGlOKzlnbWhaeTh3WVhndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnU5bm9nbjFhQ2pnb2ZoanFxazFFY2MyK0tsb0RFeFJXMkVQV0MrT3pBSWt5?=
 =?utf-8?B?YTdjWVpXV0l3azl4Y1l5QTVxS1Njc2RqR0hUMHZKNStwTERnOU5McFg4alJI?=
 =?utf-8?B?aEw2QllhYm9OV25Yc05RVGgvOWdmZDY5WWk1c0pyRjJYTDZNQzA3WXo5L2o4?=
 =?utf-8?B?Vms5S1RBYk9TY05XWEQ1Wm1GM3VsSk9aekx3a3UxdHQ1ak4wL3R6dnc4VDZH?=
 =?utf-8?B?Z003dFdDak45TXBLZy9JZkZOMW1SeDYzYUdXbENCUUhLN0FZNFRiZnIxUnZI?=
 =?utf-8?B?OENGRzd4c0xqeXpGV2djRGM3N1VOQnpZZFhBR29JU25PU2l0V2hNYkQwQUJz?=
 =?utf-8?B?WTNMS1orMlVoYWI2MzBKcXNqN3gyYXV6OWNjTER5b0M0TGdEM1lJOHNkMU5y?=
 =?utf-8?B?UWZ5STRCeG9YQWMxTndRZzBtd1RRazZZK05xbURrVC9rNmVqUjRRaDF4R1dJ?=
 =?utf-8?B?OFRnb0RZNUd3YkJsSHN2eUlNNFp2NDRwaXM0SCtuVi90bENpRWYzZ3lydUpC?=
 =?utf-8?B?Qm9RVUJ1VENVaXNyNmdVMjNSUWZheGR3b3pJaGVubUtaM3FncjI0UW9LTmpu?=
 =?utf-8?B?eUVYNFA3anFha3N5OThkeE84U3NneFBQTGM3L3Z5M291OUxtNjJxN3JqanJ6?=
 =?utf-8?B?alNkemZEWFhhaklwVTNjQXpxaG1oSVJmNFMzVXJHdkRvb0FodzFRTi9rTjdS?=
 =?utf-8?B?cWRqbG42Z3JSY24zcVJGNm5UTzgrbTlaZGV5UExQdXQzckFxVGhTRFFKNjFW?=
 =?utf-8?B?TVV2cnlDMHZod3VBR0hONW1KMUZrRDdyOEpkV0ZQaHFkQWFRNS85dkVCckVw?=
 =?utf-8?B?K2dkdmhQNURmOUUrZ1VxVm1xYXNzbGdxazRWeldUcUFaMjFoZEY2aHBEbVVr?=
 =?utf-8?B?dzRTaSt4RmNERjVkWldjOUR5VnlhR1F1cXIrMis3S1ROUUtMcksxeEF2eDVp?=
 =?utf-8?B?c0hSNHl0WHZrR01EZWJQWW9jTk0vQ1ZLMDF6RVFQNGtoVGw1ZnlsZk9ZS0Na?=
 =?utf-8?B?OXVvT2pyWURUb1hYTnQ3dXQzQ3V1R0dPV0hCTzNWSFIzQ0JNRjN2eGV0aWdJ?=
 =?utf-8?B?YVcxdGxWOFpTMDVHaDJzd1ZWT2VaU1p4TEtMVzYrV2w1TnJxZmU0RVJuTmww?=
 =?utf-8?B?ZTU4WlBETDhQSUsrNVpEUTZWV1F4V0QrN0NNSURNSFR1SHRTekNlTTFaOXdq?=
 =?utf-8?B?T2hwN2pCUjE3UlJpOXp3L1NPSnNMQ2hnOTZxRTVrR29rWFZRdXkyZGVRNDMv?=
 =?utf-8?B?ZkxYcHdzYnhUMVVtUUwrb1FZVDBKUlFLaWFWNzRlaDBtU2p3NHRHVjZqcmhr?=
 =?utf-8?B?eXBveldGcFhOSGRoWG5ySjhBSithWWp0OEd2UW5wZTd4UE5CREZCeWZWSjRV?=
 =?utf-8?B?T1NoWXh3eGowUVdkQWpxRjBuMWRpSEVOQk9LcU9NZngvai9hdDk4Vkdna2sr?=
 =?utf-8?B?U1dqdDUyV2tYL2pGTEwvSWFmUzh2ZytQWlgyOWQ4KzM0cXhwTFNIaDBsb0pz?=
 =?utf-8?B?VzNTY043QUVaaEFWYUYvTytFUHRUaWVlbjhWcmhLcUdjdEtrVDhJQ3RhT2Fp?=
 =?utf-8?B?MkV2MUxIRDIwMDhGajhyQVpXRkhSdG1qeTZnVmFrL0hLYzcwT1VVQkE2TFBi?=
 =?utf-8?B?TUhsVG1mT2F3aUttOVFoU1NJcG5jVTU3TUQ2NENsbTJzL21mdStUMGc5UWY2?=
 =?utf-8?B?djBSTm5uMktha01ueUVlZkNHcjNQMFUxTzNNUXBvY1NEbzhjL1lnVEY3NlZR?=
 =?utf-8?B?c3RuVkVTUG5IRUJ6VWRyYWxGSmg1SHRUNkM5TnBvL01GbGVTa0xUTkE2RUJN?=
 =?utf-8?B?TFY3VHkyQW9ROWJsZmYzYmdQQlM1WWk3Q3RvakdrWGlLcGJ3ZHpoM2tYeTNI?=
 =?utf-8?B?OUozdStNZDB5M2xNNFY3QlJ2SDkzU2d4QThzN3dRc0xoUFlOSndWeEtLUFJj?=
 =?utf-8?B?eEd4aFByRGZJdUJMcVZtTE4xNU5qTWtpWGVSbXQ4NXhHWUNKZHlmRUFnQ1g3?=
 =?utf-8?B?blhsMGJiWkpTTzNaeXN0QUpscTBBUTVKQk1QNTRIWXU3eVlQYTdCRThjWUF0?=
 =?utf-8?B?Z3gvamlIZUxlQ21aREpqYWpJOHhUWXhBMVVPVHgvaHZiRVN1OXpod2g1UFlN?=
 =?utf-8?Q?wphw=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cac2929-ffb3-41ac-ab07-08dcd709bbdd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 11:13:18.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEfMFHSzHlqpmv9JEw1fALUEH/OATw9BLNl/WvMmw0KSoTKebopQh3/LiSs/LhsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4663
X-Proofpoint-ORIG-GUID: MA_7V2ZDI6tA_boPnitMJtPpHuTjFHyS
X-Proofpoint-GUID: MA_7V2ZDI6tA_boPnitMJtPpHuTjFHyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01

--------------Sj3V2izOM6Woksdxzan1C3EF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/24 5:32 AM, Matthew Wilcox wrote:
> On Mon, Sep 16, 2024 at 10:47:10AM +0200, Chris Mason wrote:
>> I've got a bunch of assertions around incorrect folio->mapping and I'm
>> trying to bash on the ENOMEM for readahead case.  There's a GFP_NOWARN
>> on those, and our systems do run pretty short on ram, so it feels right
>> at least.  We'll see.
> 
> I've been running with some variant of this patch the whole way across
> the Atlantic, and not hit any problems.  But maybe with the right
> workload ...?
> 
> There are two things being tested here.  One is whether we have a
> cross-linked node (ie a node that's in two trees at the same time).
> The other is whether the slab allocator is giving us a node that already
> contains non-NULL entries.
> 
> If you could throw this on top of your kernel, we might stand a chance
> of catching the problem sooner.  If it is one of these problems and not
> something weirder.
> 

This fires in roughly 10 seconds for me on top of v6.11.  Since array seems
to always be 1, I'm not sure if the assertion is right, but hopefully you
can trigger yourself.

reader.c is attached.  It just has one thread doing large reads and two
threads fadvising things away.  The important part seems to be two threads
in parallel calling fadvise DONTNEED at the same time, just one thread
wasn't enough.

root@kerneltest003-kvm ~]# cat small.sh
#!/bin/bash

mkfs.xfs -f /dev/vdb
mount /dev/vdb /xfs
fallocate -l10g /xfs/file1
./reader /xfs/file1
[root@kerneltest003-kvm ~]# ./small.sh
meta-data=/dev/vdb               isize=512    agcount=10, agsize=268435455 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=4096   blocks=2684354550, imaxpct=5
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=521728, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
Discarding blocks...Done.
[  102.013720] XFS (vdb): Mounting V5 Filesystem c3531255-dee1-4b86-8e14-2baa3cc900f8
[  102.029638] XFS (vdb): Ending clean mount
[  104.204205] node ffff888119f86ba8 offset 13 parent ffff888119f84988 shift 6 count 0 values 0 array 0000000000000001 list ffffffff81f93230 0000000000000000 marks 0 0 0
+[  104.206996] ------------[ cut here ]------------
[  104.207948] kernel BUG at lib/xarray.c:211!
[  104.208729] Oops: invalid opcode: 0000 [#1] SMP PTI
[  104.209627] CPU: 51 UID: 0 PID: 862 Comm: reader Not tainted 6.11.0-dirty #24
[  104.211232] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  104.213402] RIP: 0010:xas_load+0xe4/0x120
[  104.214144] Code: 00 10 00 00 76 c4 48 83 fa 02 75 ad 41 b8 02 04 00 00 eb a5 40 f6 c6 03 75 12 48 89 f7 e8 44 f5 ff ff 0f 0b 49 83 f8 02 75 10 <0f> 0b 48 c7 c7 76 58 98 82 e8 7e 3b 1a ff eb e8 40 f6 c6 03 75 0a
[  104.217593] RSP: 0018:ffffc90001b57b90 EFLAGS: 00010296
[  104.218729] RAX: 0000000000000000 RBX: ffffc90001b57bc8 RCX: 0000000000000000
[  104.220019] RDX: ffff88b177aee180 RSI: ffff88b177ae0b80 RDI: ffff88b177ae0b80
[  104.221394] RBP: 000000000027ffff R08: ffffffff8396b4a8 R09: 0000000000000003
[  104.222679] R10: ffffffff8326b4c0 R11: ffffffff837eb4c0 R12: ffffc90001b57d48
[  104.223985] R13: ffffc90001b57c48 R14: ffffc90001b57c50 R15: 0000000000000000
[  104.225277] FS:  00007fcee02006c0(0000) GS:ffff88b177ac0000(0000) knlGS:0000000000000000
[  104.226726] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.227768] CR2: 00007fcee01fff78 CR3: 000000011bdc2004 CR4: 0000000000770ef0
[  104.229055] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  104.230341] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  104.231625] PKRU: 55555554
[  104.232131] Call Trace:
[  104.232586]  <TASK>
[  104.232984]  ? die+0x33/0x90
[  104.233531]  ? do_trap+0xda/0x100
[  104.234206]  ? do_error_trap+0x65/0x80
[  104.234893]  ? xas_load+0xe4/0x120
[  104.235524]  ? exc_invalid_op+0x4e/0x70
[  104.236231]  ? xas_load+0xe4/0x120
[  104.236855]  ? asm_exc_invalid_op+0x16/0x20
[  104.237638]  ? xas_load+0xe4/0x120
[  104.238268]  xas_find+0x18c/0x1f0
[  104.238878]  find_lock_entries+0x6d/0x2f0
[  104.239617]  mapping_try_invalidate+0x5e/0x150
[  104.240432]  ? update_load_avg+0x78/0x750
[  104.241167]  ? psi_group_change+0x122/0x310
[  104.241929]  ? sched_balance_newidle+0x306/0x3b0
[  104.242770]  ? psi_task_switch+0xd6/0x230
[  104.243506]  ? __switch_to_asm+0x2a/0x60
[  104.244224]  ? __schedule+0x316/0xa00
[  104.244896]  ? schedule+0x1c/0xd0
[  104.245530]  ? schedule_preempt_disabled+0xa/0x10
[  104.246386]  ? __mutex_lock.constprop.0+0x2cf/0x5a0
[  104.247274]  ? __lru_add_drain_all+0x150/0x1e0
[  104.248089]  generic_fadvise+0x230/0x280
[  104.248802]  ? __fdget+0x8c/0xe0
[  104.249407]  ksys_fadvise64_64+0x4c/0xa0
[  104.250126]  __x64_sys_fadvise64+0x18/0x20
[  104.250868]  do_syscall_64+0x5b/0x170
[  104.251543]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  104.252463] RIP: 0033:0x7fcee0e5cd6e
[  104.253131] Code: b8 ff ff ff ff eb c3 67 e8 7f cf 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f3 0f 1e fa 41 89 ca b8 dd 00 00 00 0f 05 <89> c2 f7 da 3d 00 f0 ff ff b8 00 00 00 00 0f 47 c2 c3 41 57 41 56
[  104.256446] RSP: 002b:00007fcee01ffe88 EFLAGS: 00000202 ORIG_RAX: 00000000000000dd
[  104.257800] RAX: ffffffffffffffda RBX: 00007fcee0200cdc RCX: 00007fcee0e5cd6e
[  104.259085] RDX: 0000000280000000 RSI: 0000000000000000 RDI: 0000000000000003
[  104.260365] RBP: 00007fcee01ffed0 R08: 0000000000000000 R09: 00007fcee02006c0
[  104.261648] R10: 0000000000000004 R11: 0000000000000202 R12: ffffffffffffff88
[  104.262964] R13: 0000000000000000 R14: 00007ffc16078a70 R15: 00007fcedfa00000
[  104.264258]  </TASK>
[  104.264669] Modules linked in: intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel bochs drm_vram_helper drm_kms_helper kvm drm_ttm_helper intel_agp ttm i2c_piix4 intel_gtt agpgart i2c_smbus evdev button serio_raw sch_fq_codel usbip_core drm loop drm_panel_orientation_quirks backlight bpf_preload virtio_rng ip_tables autofs4
[  104.270152] ---[ end trace 0000000000000000 ]---
[  104.271179] RIP: 0010:xas_load+0xe4/0x120
[  104.271968] Code: 00 10 00 00 76 c4 48 83 fa 02 75 ad 41 b8 02 04 00 00 eb a5 40 f6 c6 03 75 12 48 89 f7 e8 44 f5 ff ff 0f 0b 49 83 f8 02 75 10 <0f> 0b 48 c7 c7 76 58 98 82 e8 7e 3b 1a ff eb e8 40 f6 c6 03 75 0a
[  104.275460] RSP: 0018:ffffc90001b57b90 EFLAGS: 00010296
[  104.276481] RAX: 0000000000000000 RBX: ffffc90001b57bc8 RCX: 0000000000000000
[  104.277797] RDX: ffff88b177aee180 RSI: ffff88b177ae0b80 RDI: ffff88b177ae0b80
[  104.279101] RBP: 000000000027ffff R08: ffffffff8396b4a8 R09: 0000000000000003
[  104.280400] R10: ffffffff8326b4c0 R11: ffffffff837eb4c0 R12: ffffc90001b57d48
[  104.281705] R13: ffffc90001b57c48 R14: ffffc90001b57c50 R15: 0000000000000000
[  104.283014] FS:  00007fcee02006c0(0000) GS:ffff88b177ac0000(0000) knlGS:0000000000000000
[  104.284487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.285539] CR2: 00007fcee01fff78 CR3: 000000011bdc2004 CR4: 0000000000770ef0
[  104.286838] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  104.288139] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  104.289468] PKRU: 55555554
[  104.289983] Kernel panic - not syncing: Fatal exception
[  104.292343] Kernel Offset: disabled
[  104.292990] ---[ end Kernel panic - not syncing: Fatal exception ]---

--------------Sj3V2izOM6Woksdxzan1C3EF
Content-Type: text/plain; charset=UTF-8; name="reader.c"
Content-Disposition: attachment; filename="reader.c"
Content-Transfer-Encoding: base64

LyoKICogZ2NjIC1XYWxsIC1vIHJlYWRlciByZWFkZXIuYyAtbHB0aHJlYWQKICovCiNkZWZpbmUg
X0dOVV9TT1VSQ0UKCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNs
dWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5o
PgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN5cy9zZW5kZmlsZS5oPgojaW5jbHVk
ZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZXJyLmg+CiNpbmNsdWRl
IDxwdGhyZWFkLmg+CgpzdHJ1Y3QgdGhyZWFkX2RhdGEgewoJaW50IGZkOwoJc2l6ZV90IHNpemU7
Cn07CgpzdGF0aWMgdm9pZCAqZHJvcF9wYWdlcyh2b2lkICphcmcpCnsKCXN0cnVjdCB0aHJlYWRf
ZGF0YSAqdGQgPSBhcmc7CglpbnQgcmV0OwoJdW5zaWduZWQgbG9uZyBucl9wYWdlcyA9IHRkLT5z
aXplIC8gNDA5NjsKCXVuc2lnbmVkIGludCBzZWVkID0gMHg1NTQ0MzMyMjsKCW9mZl90IG9mZnNl
dDsKCXVuc2lnbmVkIGxvbmcgbnJfZHJvcHMgPSAwOwoKCXdoaWxlICgxKSB7CgkJb2Zmc2V0ID0g
cmFuZF9yKCZzZWVkKSAlIG5yX3BhZ2VzOwoJCW9mZnNldCA9IG9mZnNldCAqIDQwOTY7CgkJcmV0
ID0gcG9zaXhfZmFkdmlzZSh0ZC0+ZmQsICBvZmZzZXQsIDQwOTYsIFBPU0lYX0ZBRFZfRE9OVE5F
RUQpOwoJCWlmIChyZXQgPCAwKQoJCQllcnIoMSwgImZhZHZpc2UgZG9udG5lZWQiKTsKCgkJLyog
ZXZlcnkgb25jZSBhbmQgYSB3aGlsZSwgZHJvcCBldmVyeXRoaW5nICovCgkJaWYgKG5yX2Ryb3Bz
ID4gbnJfcGFnZXMgLyAyKSB7CgkJCXJldCA9IHBvc2l4X2ZhZHZpc2UodGQtPmZkLCAgMCwgdGQt
PnNpemUsIFBPU0lYX0ZBRFZfRE9OVE5FRUQpOwoJCQlpZiAocmV0IDwgMCkKCQkJCWVycigxLCAi
ZmFkdmlzZSBkb250bmVlZCIpOwoJCQlmcHJpbnRmKHN0ZGVyciwgIisiKTsKCQkJbnJfZHJvcHMg
PSAwOwoJCX0KCQlucl9kcm9wcysrOwoJfQoJcmV0dXJuIE5VTEw7Cn0KCiNkZWZpbmUgUkVBRF9C
VUYgKDIgKiAxMDI0ICogMTAyNCkKc3RhdGljIHZvaWQgKnJlYWRfcGFnZXModm9pZCAqYXJnKQp7
CglzdHJ1Y3QgdGhyZWFkX2RhdGEgKnRkID0gYXJnOwoJY2hhciBidWZbUkVBRF9CVUZdOwoJc3Np
emVfdCByZXQ7Cglsb2ZmX3Qgb2Zmc2V0OwoKCXdoaWxlICgxKSB7CgkJb2Zmc2V0ID0gMDsKCQl3
aGlsZShvZmZzZXQgPCB0ZC0+c2l6ZSkgewoJCQlyZXQgPSBwcmVhZCh0ZC0+ZmQsIGJ1ZiwgUkVB
RF9CVUYsIG9mZnNldCk7CgkJCWlmIChyZXQgPCAwKQoJCQkJZXJyKDEsICJyZWFkIik7CgkJCWlm
IChyZXQgPT0gMCkKCQkJCWJyZWFrOwoJCQlvZmZzZXQgKz0gcmV0OwoJCX0KCX0KCXJldHVybiBO
VUxMOwp9CgppbnQgbWFpbihpbnQgYWMsIGNoYXIgKiphdikKewoJaW50IGZkOwoJaW50IHJldDsK
CXN0cnVjdCBzdGF0IHN0OwoJc3RydWN0IHRocmVhZF9kYXRhIHRkOwoJcHRocmVhZF90IGRyb3Bf
dGlkOwoJcHRocmVhZF90IGRyb3AyX3RpZDsKCXB0aHJlYWRfdCByZWFkX3RpZDsKCglpZiAoYWMg
IT0gMikKCQllcnIoMSwgInVzYWdlOiByZWFkZXIgZmlsZW5hbWVcbiIpOwoKCWZkID0gb3Blbihh
dlsxXSwgT19SRE9OTFksIDA2MDApOwoJaWYgKGZkIDwgMCkKCQllcnIoMSwgInVuYWJsZSB0byBv
cGVuICVzIiwgYXZbMV0pOwoKCXJldCA9IGZzdGF0KGZkLCAmc3QpOwoJaWYgKHJldCA8IDApCgkJ
ZXJyKDEsICJzdGF0Iik7CgoJdGQuZmQgPSBmZDsKCXRkLnNpemUgPSBzdC5zdF9zaXplOwoKCXJl
dCA9IHB0aHJlYWRfY3JlYXRlKCZkcm9wX3RpZCwgTlVMTCwgZHJvcF9wYWdlcywgJnRkKTsKCWlm
IChyZXQpCgkJZXJyKDEsICJwdGhyZWFkX2NyZWF0ZSIpOwoJcmV0ID0gcHRocmVhZF9jcmVhdGUo
JmRyb3AyX3RpZCwgTlVMTCwgZHJvcF9wYWdlcywgJnRkKTsKCWlmIChyZXQpCgkJZXJyKDEsICJw
dGhyZWFkX2NyZWF0ZSIpOwoJcmV0ID0gcHRocmVhZF9jcmVhdGUoJnJlYWRfdGlkLCBOVUxMLCBy
ZWFkX3BhZ2VzLCAmdGQpOwoJaWYgKHJldCkKCQllcnIoMSwgInB0aHJlYWRfY3JlYXRlIik7CgoJ
cHRocmVhZF9qb2luKGRyb3BfdGlkLCBOVUxMKTsKCXB0aHJlYWRfam9pbihkcm9wMl90aWQsIE5V
TEwpOwoJcHRocmVhZF9qb2luKHJlYWRfdGlkLCBOVUxMKTsKfQo=

--------------Sj3V2izOM6Woksdxzan1C3EF--

