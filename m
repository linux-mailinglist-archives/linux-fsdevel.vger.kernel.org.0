Return-Path: <linux-fsdevel+bounces-72209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94606CE8219
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 21:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 178D83015A83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833012620FC;
	Mon, 29 Dec 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ozq/QYYC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA2245014
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767040120; cv=fail; b=i5X99r2umSuiCI4Z9RnkB9dqY9UF0WhU06DHmTmUHf8bqZhPc8VQ36EGdpFxA+/BZJpVmHzR8H50ulrqE+XO5avnHyJVPHKlsoRZUHhuRl63RI/8pERWYvk/9kQ0TxGBtEumKoRG271/VKTkNWdiJX/QO3uiciItHs0saC7ebbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767040120; c=relaxed/simple;
	bh=7qmq6l/4m/j8Dib8m5GQzc7J1ZObYkZzt/5WA3iD0zQ=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BpBV0t+QDvIqfjBInJYnaVaIgqAbzvtwdvljocxw0CUB1vHgQuFyRCswOPrPZS6BAoPeeouDVSYvN+sXCQ61hpsqce0oudG8xct5GzBXSkszNdwiA5NJPVsL3QdQME3k0DASDjNur23K2l/gCPKe5en0GOofTAga7jgJZ+FhZHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ozq/QYYC; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTBATWS026394
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 20:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Ap6RYQWDwEOoMV+11ISf9YMYIegzExx9IZ6o8QnZ+XQ=; b=ozq/QYYC
	D+Yng3s/JkabM9LnW4hrF5DEEnhyA+4Mj9rJZiE1fqUseISe8h1abL4FCRjGBoVK
	GWcxIg5itedbkY5UY5mYliUcedf4EEQNeGguRSk19feJtB3IEbLWU3teLWA7Dnd5
	yI3Q8jR2bUHsiWUUNsvrPk684iMINNaflUukasLAcc4mbJK2FyMAw2JduOLFQrOb
	UAY33HBGHzeNmCuTcFxiQP3LT4XjrqGchbRLgjZIZ+Zqyk4mzZo/qv41tdai5vpG
	1Y+nxho/KPYGOutmEz85BH/8eoU3ZRBEOPIgIh/OL/UIwnOsfsmnAfR9B4TcXI2Y
	zuayyGktzJxNDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vqucy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 20:28:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BTKNGsp001483
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 20:28:37 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vqucv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 20:28:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKLPrMwZuP7S8H+lr4PKOHH0DyFSkJOW9o4+JVVyXT1LMoVGzr9MWYBuToFT0WzcRfK7tXYUCZFumuRrfI5/8I3lbdNvt9sGsFcAKvzWjeT3u1d88VQAAVfbD7SGeyM40D+kdkJ8daDKzKAM85SObgAMFj0xmu/CGOyJ0dLSf56fTqo7vu9lJORlnMoMDgynBguNOnOFcapx6ccsVb1fBXzLANarZtQ/csW3pIRIY86DOo8HWRCcLWOCPtL/lKpmsGcpSpglV0rHAFckYp/nJbVy9WVfJ/yDUXQsodLEj5fM6WlHFFpzWxCZa5usUh1ryFTqSLLncj2wwOqAZInqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc89EoaGzuNGOXBgZAdaA/58VAwoeM4v5RL8fbQJ50o=;
 b=JmoOHCIrLe3zPGxXRf+zYeh8pyauzU4PKV/nWQ5ktft6ftKPFQp/+mOKQk+v9sUb4BAlnz2S5sOekh8jXc528+W/XGF94qJsJsvH61RWa05Z9vR1ZRiOGMLLCoEqa9LfSVwGe0fR3o5mMkjbgEmxLd+ZdarCC8dgfHudJRQhZjCYlwOrC7+0M/ndyZFTEQjXmIcn9nbXTC9n2DjYOHRcvv+MdXxqhKlY/ZdUr2UnuJsiYVV8T5ZbXpxT4zcEC7UUwWE55K5gBhPgPJ7xvbgtvOdEjVoeeuSJr6j3C12H1ARLud9lv2LMt9Yl7DCJV5x8C+uERGe7Wx6r8MyUC5X4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPFBC4F5764E.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 20:28:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 20:28:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: pretend special inodes as regular
 files
Thread-Index: AQHceLg9SqtQfRgddkaClBMaexLhM7U5EfcA
Date: Mon, 29 Dec 2025 20:28:34 +0000
Message-ID: <86ac2d5c35aa2dc44e16d8d41cf09cebbcae250a.camel@ibm.com>
References: <8ce587c5-bc3e-4fc9-b00d-0af3589e2b5a@I-love.SAKURA.ne.jp>
In-Reply-To: <8ce587c5-bc3e-4fc9-b00d-0af3589e2b5a@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPFBC4F5764E:EE_
x-ms-office365-filtering-correlation-id: 9bc6d4aa-48e2-45ce-8f5d-08de4718d74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QW1lRldkdFVjZzh2Q005YTUxMzJ5WnlsZ0dMU3hiUWR6YW15MVRrbVJQRms2?=
 =?utf-8?B?NWNJRjBsSElvOHUxb0pncmlVR3N1bTFzS0kzMmxJOUZvRkFCRllud3B3VUxl?=
 =?utf-8?B?ZGlvRzFZbVJHY2ZLQWMwcFpVNUd3QThMVVI2Y2dNQlhwZ1RMYkdEc3RFWmh3?=
 =?utf-8?B?RWJsQU9JeXFzcUtaNmJQdncyNG8vME5CeFVrVUs4NS9BWWtZS1prVHBieUlH?=
 =?utf-8?B?bUNPVWQvR0svL28xRDVVQzF1cEpqVTFYTDhpamh1bVI0bXFuMUJRL1Z0dy9L?=
 =?utf-8?B?Q0lJR2QyeXBBYnlibDFXM0MzQ3RJbjJ6alJRUWliamNqME1LOVlnam9CTUZQ?=
 =?utf-8?B?bkk3akh3RVZzU09yZjQxaTkwcmdCODJ4WnRZdXlZdWNzQ2dQMEVYTjExaE5J?=
 =?utf-8?B?Yk4ySkUvMUgrZUoreWNoR0NibTMzSW0xSVNobHJoeUE0d1JqVm1JOUdUT2NM?=
 =?utf-8?B?bTFMQzh5TzNEczlDRXlnWGpFWFlPdWU1RGpJUDcvUmhNYWRQbFdpT3l1dGYx?=
 =?utf-8?B?a2pEOWVsNHQycDBRclZPbFpJdVkzVnVTbFRzZzJrYmZ2MEVCL0pKYWlsemw0?=
 =?utf-8?B?ZjJWaWM4TkhmdnRGRTZRQURKSmNRbnMyN05OdWhqR05ROHZOdC9PWVZxL2p4?=
 =?utf-8?B?Tm5EMEhUUkVQOEJxVWFadUhCVG5uaS9Gd2kyQ3psTkxrQ0hVVWdnajMyM2J5?=
 =?utf-8?B?dTU5SmdDVkM3a2dSZUF1QUFPMGExVTZ4V0FvMXREdjZwMDdNUXJ5Z3JqOWYx?=
 =?utf-8?B?OGdpaEdJZW96RlB6R0NHRXJzSkRvN2U5U0xRRVEyQ1BjMGNHeERETU5xaUZs?=
 =?utf-8?B?ankvb0hjdnpBM0ZUY25TdFNERi9TOTB0Tnd3TVYzYXpFVEVpWUZreGlFN1Bs?=
 =?utf-8?B?V1lnNUxmRW5QZjB5RCt5QkVxNE1HK3Fwdzg5R213Vk50cEFKbjZxTDMyaDZR?=
 =?utf-8?B?Wml1cDFMckJWUlhGaHRzUWNTS3hYdmc4V3ZsR0t1Rkc2TU1lN3licUFWaVNx?=
 =?utf-8?B?Yjk1UWFoMWZmZEthejVGbHRUbVZlLytQMFlwUHpCOFkzdWx3NXlERms5cmFD?=
 =?utf-8?B?am1mQkdwejJWTnFiQ1VDQis3ZEhVNmxQNXhSU1RUNmZtMmRJNXN2aUJKK0F4?=
 =?utf-8?B?SHp3UFdLTlhwTXRESGN6aXdobnZsOVI0Mm5KL3lMOGNuazMvTHpYcTFLWWlH?=
 =?utf-8?B?SFlxSnhPTS92SVVGMjVMUlN6VEo2QjA1dDhFNUpEMjdKcFdGc2Q0TEFSUnlK?=
 =?utf-8?B?M0VkV1FBSjNYSFFDZmYrRGRGb1MwbmgzUkc2TUZMN0J5anVKSlBzZWFKWEZo?=
 =?utf-8?B?NEtoVHBxbXFyUVFJS1l6UGNpSDVUZ1hHYWNuS2xxREplZktaSFVycTVCb2pS?=
 =?utf-8?B?ZWdEdFFVZVdqYXdLRFdhL2RUeGVaZmw5RWs4WkxJek9QdGZwT0NoM0NGeFRQ?=
 =?utf-8?B?N0VRc1Myd0xoT2Q2dUpyemhJV0hzVjNrU3VvcE1ENjhsNHlsWEJXdzdqVTVQ?=
 =?utf-8?B?VnQ4SXpzRDltRldHd09WcFVKNVMxRDNNUnRwaUJ0cE40em1CU0R0RUJrUnJN?=
 =?utf-8?B?U2xmMmQ5bC9VdUJRb25JQUU3eTA2cVNKMlZuOEhNN0V6Wklzem5GaUFRNnov?=
 =?utf-8?B?bm92OWRINCtTZi9HUkU5Q1h0ODdHUkZjdy91aXZwRG9JbUY3dk9INEh3ampH?=
 =?utf-8?B?bDd4Y3ZmNzRGZVZPMWl4THpPM2tycURYQ3FjREgzTk5tQTNEZ3RsdlZrSGwr?=
 =?utf-8?B?OE1XSW41WERvbnQwZmtKS1hjblNDNjk1TW1pVHZWR29ZNmR0dDVXVnREQXY5?=
 =?utf-8?B?bzFCUXJMTlJKNlVBMGk3K0xndzBFSEx3bXBKcjNzZHBsNlNqQ3pCb3ZxcEtD?=
 =?utf-8?B?YVA0NkRNT3MwM0xEVDFNQ1RxUHZiU0huUDVxUjNPVUNXcExyQVhCRStTcEEw?=
 =?utf-8?B?bEtDMkdiYXltbk1adFh6TjhyTUxZcWs1VXJ0elMyWmEvQWlscG1Fbkx6WFd6?=
 =?utf-8?B?Z2owZEdPaU5RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDBML3prMlJrbTBiNk5SWVdKdXdTa0lZQkZDYWZQTmhhL1Y5NnQ4Z0dLUndt?=
 =?utf-8?B?WFA2ZmZ4YTQ0b1hKVE9OWlRIeHVYalJHU1BZMTM5TFRleGVMVnNBR2NpTWI3?=
 =?utf-8?B?ZHZQUjR0a3BIcHc3dFJSaWpaU050MldKNXRiUnZycDNXcUFld0NSN1U0RlJ6?=
 =?utf-8?B?WXFaaE9MaGZyVW81NUZIWUk5QXVjTVI2TklhUlZGbFVTMjRuZ3c3cFV4YXlB?=
 =?utf-8?B?eWxRQU9ZdnFxYlY3U2dXQlJXRkNoQ3RlWHNHdXFIa3oxNXVvWVBzaTI0alFZ?=
 =?utf-8?B?WjQ3ZUhlVUhvUlAxbWhPS00wU05xSkdvT3FvZkdmWVBnZVlIN1Z6SkwxVk5x?=
 =?utf-8?B?WlhyYmpTbGY5ZDBMYVNQYU1hakJUT1MrbmNBcW42b0tDbGhwSlVjd1psTzFK?=
 =?utf-8?B?a0ZZYVFyKzhjWDJkUlZPckhEY0pPNm5JRWNIbDJQYmwwZWEwcGhVTEU3TXpL?=
 =?utf-8?B?ckc1a3JvVHh1eDZZY3VtTTZmZjkzYlphTlBFV2JJVTJXdkxxM2J0YmFFaW83?=
 =?utf-8?B?ZVBlbXVabjdGMko4WXVTMFgxUW1BbDM5c05DR3c3Z0dYSEcxUHh2T0RYOFFp?=
 =?utf-8?B?YTJXY0JXQlppbUFQSnFxSmQvYk42U0RKazVFUmR5V3p4RmdUaHVreVl4K0g1?=
 =?utf-8?B?S2o0QTBDeTJuZUJxS1pZOW1xNUtlT0RIM2JSQW1MZDRvbUcwQ05DSFc1Zkcv?=
 =?utf-8?B?azNOYVNUQUNwWkxkOUlwMHp4RXhFdjJ4clZBR1dwMml5ck9wcXliOXF6Qmp3?=
 =?utf-8?B?SGxiVVFKdGNoS3RQbmMxWjNNV1lybnJmRzY0TEF0d3BhMTVlQXBtU01RRFZq?=
 =?utf-8?B?Vk54RVpLTFhhVEc3S0RYc3MvbTlrUW5kSHFiUlJueC9TRDFsN3R2ckFxamts?=
 =?utf-8?B?dzArNTA4RCtGOXpkMXZiZkY0RmJJd2VLRTZNNU9ubXRDd3hiRnNZckRXckM0?=
 =?utf-8?B?U0Z4Y3dBbHlITm8xTEtXVHdsaU92ZVlYNmNQRnRkS25HZG8yQjh2dnp6b1dE?=
 =?utf-8?B?MVJ1R3hUcE1rOTdDY3hudEI0a24wem5aQ2pHa3k5UnFhWUYzNnVuck5Pdm85?=
 =?utf-8?B?VkxyNUFaSFdudUlRM3A2dFNDWHpVV1FXR3ZDa2FYNmR2aGJ5RGttKy9sMHBL?=
 =?utf-8?B?RmtlVy9henlTejVtcFVzOEcrR1VGaXg1V0dsd3dNNVVmVkhabC9QWHR3WFVh?=
 =?utf-8?B?WXdyYnRnK1lJK0gydlVOYlhiUFpJTnJkcDJPdzJJVFA2TE5DVGYxNG4xLzhZ?=
 =?utf-8?B?bVdib09POHRWZjhmbUwvU2xKM1diOERzRGhxSlVwT2NNYjYxTFZ0S0NCdlI2?=
 =?utf-8?B?dExrc3V6Z0kxdGNvb3p2WHBMb3k3eElOMFlZTFRvdzEzQ1lqaGRRcVVPWXh6?=
 =?utf-8?B?czZSejJmUGViWU1vSkdQWHNxMEwyNE5EK2trY3NZc1RacDZqdVBsV1Z4Z2RF?=
 =?utf-8?B?cWs0NEloV09Pb0ttUCs0QUN2MnVJKy9jOWdJS3A3OExMRmVRM2hEaDh1S21z?=
 =?utf-8?B?Q3BFbzQzT3dLWU81Uk44RTNtUDQwNldqNnMvcGdCZFRZTkJORFF5MXFyZVVZ?=
 =?utf-8?B?MWxnVitSakNBUGo1UmJoelFidDk5YWNpek83YTRUSllkc2VTNEhlem0zWXFD?=
 =?utf-8?B?U2RoZjlmc3VzMU9DOWNPQ1o0dWZqNXA5aVZ1dk9adFZmY3E0WjBOc2dIcTQy?=
 =?utf-8?B?ZUNWZEZUeGJwQUd5b3ZUanN5bC9zY3YyNTJYVCsvbHdzZFdLbFF3aGVSbkww?=
 =?utf-8?B?cnlycHVJcDZDNkltVVJNdEViaXh1dHdHNWZINUoyajc3YnhjTWxTcFFrR21i?=
 =?utf-8?B?R0ZOTEErbHNEaC83ZWwzaGlNTDYyMnY3bVJJMUFEdmFSZjRSUFBUWFpIb1FM?=
 =?utf-8?B?Rm9Qa2M5d2hMcGh2Wlk3dE1PajJEQ01HUXFVWCtORmh1MUQ5VUF3dWxxcHd0?=
 =?utf-8?B?NzhOVThkNGtERGxKaFZPL1lqcUY1S2FZWHI4SEdTcmJXU0RmTTlObGNWUVhY?=
 =?utf-8?B?QUpRb3ExVXFmbzZqTkNwbDZCbzJ2NFdQc0xZbkZPUi9yNld6d1Rsa3dpVnV3?=
 =?utf-8?B?TEszbXRka2JFZFl0bzFPYzgrU0JVWXEyRlJaWmUvOXY0YW8xd0dad0l5K2Zj?=
 =?utf-8?B?Mk5RL0NUdlZVd3NlTzBQb3ViWHorYy9ZZXllRDRGZnVrYlNoNFRRbFBiWlRH?=
 =?utf-8?B?YWFxaGVRTnJyMk9QbXFUbTFZZHluTEduZXVPNmZvemxXdjVrNzdoOGMyQm5p?=
 =?utf-8?B?NDd4TEZHZWR2NFZCSlBDdm1xOVR4Wnp6cnJIdzQyQnpTTThhVWdDQkZ2cTRQ?=
 =?utf-8?B?ZXY2VjA0NW1DWVVmaHZlekVoWldhUlRCMlJYZ0hkdlRpNTNrSlJoZkdLcnpV?=
 =?utf-8?Q?pY2/9KayMpuz75UOQHHcKjCG3EZvNMsXaYXgp?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc6d4aa-48e2-45ce-8f5d-08de4718d74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 20:28:34.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LQCisTFp7obEbP/pXj/LnbvLdAeYUhkxyoGRheZKZniOFJA/c+7H6KWceupW8b2qaqdl7giXclm+rT9EqsIjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFBC4F5764E
X-Proofpoint-ORIG-GUID: 2-xvSyiDwguFW47x8DiXBKq4So64bB1x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE4NiBTYWx0ZWRfX9MYwAvVvmIfW
 FIQTtidcDm1eSMu58ilQ/DgfaO01NwhT4mEO2FmyhCcdZ2HSwcs4BfljgcZk46cn2f7oHI7++G/
 mDjphvruSvMKwOeqxypYfh7NWtVk1bcR11nh4HrqvEiUcuydWOjmeFBT6ZAmsxEO4UVS8qAupUN
 cyArkAB5KEf+eUCyqNY1amQQP97xZmxfMRmXo1obQClJ9quEKfRNuSjyq1vPB3Z8mY+DQui3OVF
 ++GQ/qEQWyTgVpyJ5YsLbD11t8jf4wd/+GpkVnASmwcH3vIKcs/+UV3/l8khwv4YWspew8odiQg
 O4xDhJiNfw9+QyzKqcXgSNVXDeIOc2l4Hvtm0YZukPCBF1j0DOptsmHtzVeLuaeEMpELb5Qes9F
 gN+ezifr+rR4vBaSmxj1d4qMJOQf4d1oDagDhIFnnqsTtw7z1BzHeBGQRtfq4s7NteygMnLCckP
 h+1Qp+iS7MmTGc5WgAA==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=6952e475 cx=c_pps
 a=RV/m/49WaDJDQ/P4gGxFUg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=N73YG26MLR48llx0jLgA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: 2-xvSyiDwguFW47x8DiXBKq4So64bB1x
Content-Type: text/plain; charset="utf-8"
Content-ID: <8122E417A6F24C49A297698F2B1D53BB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH] hfsplus: pretend special inodes as regular files
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2512290186

On Mon, 2025-12-29 at 20:42 +0900, Tetsuo Handa wrote:
> syzbot is reporting that hfsplus_system_read_inode() from hfsplus_iget()
>  from hfsplus_btree_open() from hfsplus_fill_super() succeeds with
> inode->i_mode =3D=3D 0, for hfsplus_system_read_inode() does not call
> hfsplus_get_perms() for updating inode->i_mode value.
>=20

Frankly speaking, commit message sounds completely not clear:
(1) What is the problem?
(2) How it can be reproduced?
(3) Why should we fix it?

So, could you please rework the commit message?

> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D895c23f6917da440ed0d =20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hfsplus/super.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index aaffa9e060a0..82e0bf066e3b 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -52,6 +52,7 @@ static int hfsplus_system_read_inode(struct inode *inod=
e)
>  	default:
>  		return -EIO;
>  	}
> +	inode->i_mode =3D S_IFREG;

It's completely not clear why should it be fixed here? Currently, it looks =
to me
like not proper place for the fix. Could we use already existing function f=
or
this? Why should we use namely S_IFREG for this case?

Thanks,
Slava.

> =20
>  	return 0;
>  }

