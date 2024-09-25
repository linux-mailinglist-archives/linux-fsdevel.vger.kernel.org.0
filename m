Return-Path: <linux-fsdevel+bounces-30096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD42986431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31838B30353
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95780188CAD;
	Wed, 25 Sep 2024 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E01pqEYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621A145B1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274181; cv=fail; b=L89ogiwDrpAOxJVPhG70z8axU4Yx0owjq8HSGI+Qp8XrjwVoEqi1FjXsJPeM58Krsg3g9lg9B7JUWcyPqVSdu4ZUMnfyY84xhDiSlG8t9GVuSZe9RHJdMty9RWaJb2+UR29t2Pkabj2iNg7eEeYsokiaem8aSKJ/vNdfJlRC3b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274181; c=relaxed/simple;
	bh=dTAcS32TDjLbINMYMKfcUbb67jYZa+xflryYgBbfpqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxqaUMBgWSc+h6dB9Pc3Pudund32jEwYi3+aixHCPqcJGyEtHs7c3ayCeWQHzBKA+gGqGMVclEr8DP/klPXolNofhei0cYXgvkpdcdP8HuK/gUc41llnVetZPcpfZG572W2sL+Pis5QdcJiTqqIXMIlt9x8pQk0Dkc6wc131Ooc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=E01pqEYu; arc=fail smtp.client-ip=40.107.117.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaVrSkiYQjHiX4mQ9iEKjGo7ckdf54Bjd0+s6AE0JdVyzZsYZ6f8kklAC8EWFujDtHMo98swUcAkAX+Gt3w7nkeXALGimfiInzETgyISzF35oThP3fCjsektW+Z/STyVh/cp5nV75MNHofndh0kVnUs881iJ3wGJ/PRtrhA2pQ8W7Exz4DdhkZ7rr0RCKQi4CNlkpzZlKbNPeOMtCwQT5gy8MisS1EmhDzGlEHNMGHFEEiUO5pp+35lZhuSJlvJGRxvVWjOgfuWglGKIhLOj2aK0aPXiENB/L0CBlF0+tuBklHWu4I7d4naapj4EG82C+TDQ1HyjgoUIWO7Gx+HWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTAcS32TDjLbINMYMKfcUbb67jYZa+xflryYgBbfpqA=;
 b=uAmyNHjHimUDV3Yjq9qR8ttH/xDX/DsOClyeLcDXDzggGhhVnjWv7mp1ktut3NpvhsWB81kH9g6sEF08pDX5m65Snsi5VD8AN6BZGeqwtgyuCLIWvsRo9P7eXWP1Q3UobcyVpK0uVpjtHuPI3lJTSTXNxJzNVG7hWPLRZRVYzsu1nJyzRdZI7qWFDFxnAisdu8mU2v699IvPwNjG47bfWSe/1fuK1Saiayw1jvQ7zqHkHbqDNaAUTFR/VwgYl0tqdBhLl0jtzAxzfh0fHygNxxX1hxpQlbmPiVnjghq64hept0wzm2U+0Nw3+yFsptKhtNwnhYLhufDc7stZYJyDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTAcS32TDjLbINMYMKfcUbb67jYZa+xflryYgBbfpqA=;
 b=E01pqEYuWOlcxgisp/h1h3+LjWbwg7lu8qqo3uHjhDkrpbVD7pHEVD7dhAdlovt4EqEVH9iLhqVgxry/ZKw9XQ32v3LZb4S7qyI1XO9QiqmJgCAVQWrhgOnWXmM/nlsE9V6ZTjyqCbkMDxLaFGsQdZLXh2FO1rlroEyFNeuBSyk=
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM (2603:1096:990:66::7) by
 SI2P153MB0718.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1ff::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.5; Wed, 25 Sep 2024 14:22:55 +0000
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5]) by JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5%3]) with mapi id 15.20.8026.005; Wed, 25 Sep 2024
 14:22:55 +0000
From: Krishna Vivek Vitta <kvitta@microsoft.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Jan Kara <jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
	<asmadeus@codewreck.org>, "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Subject: RE: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Thread-Topic: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Thread-Index:
 AdsMF7H2pA+A3TMFT7qIn4M6deqPigBk8OQAACP7Z1AACRNwgAABPHQwAAVRWhAAKioFAAAAOOwAAAVcZgAAAaOeAAAAm94AAAPF+pAAAR6dAAAAJY+w
Date: Wed, 25 Sep 2024 14:22:55 +0000
Message-ID:
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
References:
 <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3>
 <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3>
 <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f893d57a-92ec-49fc-8114-79648fdc33f0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-25T14:20:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0P153MB0999:EE_|SI2P153MB0718:EE_
x-ms-office365-filtering-correlation-id: 830669e0-3ce6-4856-a2b5-08dcdd6d8c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0k0UmhveDViNXYzWWZWdUxUamNhM1hzRzZDelNvNnlNdmthYjhxL09KRGdx?=
 =?utf-8?B?cVZTNzl1TkFDdzhIRGZFZkdCbStsNll1RDNQdVZDd1U3Q2tDMU4rVUo4NTd1?=
 =?utf-8?B?UmlQS2tWUStCeVVpa2xBZXptYzY2WU1QZCt6dVhWZmE3dmxnTWJJNXdLdXVk?=
 =?utf-8?B?OFRwWExncVk4V3VxbGRvNmxkL2p5WDZYZHJ3dVM5ZGlPblRYdzNNYURBdGtU?=
 =?utf-8?B?bCtmWlVGVm11YTdOOEQ5S01VOU1kUEt1Q2hnUE5qYlBJZi9ZYVVEOTdZYXNQ?=
 =?utf-8?B?aWZ5aHZuOC85SDEwYURaTXZIQzRnZkNzMjIrblBZcTN3Z1hTb2xSUjJQL1dK?=
 =?utf-8?B?dnJrTjRsaGJab3hoZlpuSVFMaHcvUFRVZG5RT1o0UTVsanF6K3FCVGNSbFlt?=
 =?utf-8?B?TmJERGlJQkhUbjRUWkg2dmhYQ3dZT0ZvQVFjQ28wWGJVdjFqYTRZNTdBVGZ0?=
 =?utf-8?B?dkVtSVorSjBpVUJ1bG9GcTFKclIwN2VaOHNOYWd4Sk1qcGdEaTZpeHhSdFps?=
 =?utf-8?B?SVNmMTV1VUp3V0ROWmcxeEpHYXM1Nkl2MTRjU3ZEV2N3bkFjS051TGdYakE4?=
 =?utf-8?B?UnZTajQ2NEpWRVBOL0l0NlczRDEzTGdoTG5XL2xtN3p0YTdTS090a2ZOcFJj?=
 =?utf-8?B?WGpTVU1Ed3JlS0NOckxiMXcwK3ZSQ2t5ZWJocjcwN1V1WGhQWEh3VkVFUGpn?=
 =?utf-8?B?cjhncHR6K1N6M3dSY1llL25yREc5RU00MG5CNGdxMjJlWXBzaTBya3BMRDFt?=
 =?utf-8?B?NHlQR1A3ck9tUXErVlcwMnF5azlnSGY0QzltZEJKKzh0ZUFOckpOZGVPaWVp?=
 =?utf-8?B?aVNwMmVVNFhnbTFMK1Foenh4ZUVXME9qTUNHQVhqazAxWUVUSDBIYzZxL0hV?=
 =?utf-8?B?Zmk3bmlGNDYxRnpDUHZpcS9MQm9GUFMrMFZKRHIzVGdYSWVHblRGRkU2VFc3?=
 =?utf-8?B?R2E3RGhKdThCZUpwdzJmV3FwZ2U5bDM5WWZQY0hHMElwTUl5SmNIRlNKQ1dh?=
 =?utf-8?B?c3VUemM5b3QzUXJUOHRrdlhvankvbGNzb2ZvMEFZa3o2c2RPeDhmT3oybkQr?=
 =?utf-8?B?cmhnOVM0UFZJVFhsSXZ0bTNaZUU4TG9jUmhaOEhPODRtQkF3cGo4eWZzcGcx?=
 =?utf-8?B?RkZScVlDQy9pU0YzMHAzK0ZaL0djRHN4OHI2Y1R1WUxaczhOWHB5RmR3L29s?=
 =?utf-8?B?aWRNSXhkQzRYZllTWWdNQlBhMVpjcjhXaVl2aEdkeWdUcEFUeVF0eFlMZDIr?=
 =?utf-8?B?SGgxbTJwaE1SUFVrazBGNDVjRTdhMzlxa0VPM0ZUNXVTTER6SndIOVNkN1JG?=
 =?utf-8?B?SXlreHpSdEo0cWxJTWFSYWFRQTFidEFGdGtwSVBNMVp3Y2VpTlZDRXladE02?=
 =?utf-8?B?ZWYvQ1VNQTRhQXNaV29URkF5VFp0T2diSmdVRXFSK1NudjcwWU1jQUQ3YUxM?=
 =?utf-8?B?Y1JiNEhrMGhHQnREUmRKVllFNjNIaTdZT1F6R0h1SkNqQ3JNejg5Ky95Mm8w?=
 =?utf-8?B?SDNoVVhJc3JYMGx4NXl0ZUNSSkpUQ0l3UVJlM3dMQkR2K0tET3RFZHZqTk5u?=
 =?utf-8?B?VWVvZ0dPYVdENFhNdG1SMDBGTUhPNTNaZ3JweHJvUDlFaEl2ZXIrKzNYamFQ?=
 =?utf-8?B?L05vK0VmT0RoM3JGdi81L040b05vWkNrRFZ5azNJUTgwVFJhQS85cUpxR0ZQ?=
 =?utf-8?B?R1k0QzRhcnZqaFRPRE1CeDRjQ0hFQVg4Y2J4YWRjckF6czFKQUg3aHdBakds?=
 =?utf-8?B?S1BVcGQvKzZZbGxySG5MeXVQS2VKaXZ2bU93WjV5WmFSL3dIdnNKNUxZR3Fr?=
 =?utf-8?B?S1crY1FWWUp3LytjNzZtUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0P153MB0999.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkxyblRZQVJlb3hKb2E0R3ZsZzRZSGZhSjFyaVZScHdQZ3RwUERhaThXR2M4?=
 =?utf-8?B?eDdJaXdaaGlkN0xzRXZEazR3RXJGcG1NSmwzeno4eGEwbjBXUmZydlJkS3Q4?=
 =?utf-8?B?Y0JIVXp5ckN5NmN0ajh6THl4bXdVWEd2RU9xeVNHSEFtT1NvNjJaU3VFbG45?=
 =?utf-8?B?eCsrV2FpY0tscTAvMzdsZzNoSnBEWjE5Nkpmb1lhWS8yZGtlVGZvamRLdjFV?=
 =?utf-8?B?ZHVDUmZ2MmFQSjNvMzhZOHVVcEphclljRnpKMXpvSk9nbVR1NFN6b0Q2aUxB?=
 =?utf-8?B?eFpTTmJzd09nS3NFSTFXQ2dqN25PeWVLSi9aRE1qSFFJWnZtUEozdGdLSTRj?=
 =?utf-8?B?WjdjYXhHL2VxRE1SRVVHeWcrYTUrNm5qelg2Q0tVWmVEU0daUUVDTlpzT3c1?=
 =?utf-8?B?a1hWbFo5cml1b3gxN2JudDNlaXE1YXd5aDhZZEtiZU1TMHA3emw2a3ptNis3?=
 =?utf-8?B?aTk2YUQ5aTlwSGJFM2VWM1U3SkltVDFnTFQzdzYwNWI3d0NiSTlPRTBqTmlR?=
 =?utf-8?B?Wnc5cVZCNURDN1gxVEJPalpucE9qU0FlZGJ2MGsvUkhRb0VIbVlMRnhpVTRt?=
 =?utf-8?B?d24rb1cwRU5XS21pS211VzIyK0o2YktieHZJeFhBVzJaWDVoaHlaZVYvRXhu?=
 =?utf-8?B?SUdOVHdIL2lYdUdGWEwxdlo3a2VZc2FJQWdrQW4wSlBReDluK3NJRDYwc253?=
 =?utf-8?B?cTJrWUhqdU9DUU9MWXFsRzV3RmZ1VExVZ292eFVXbjF2bGhaTjRiSkxrN3l1?=
 =?utf-8?B?cldzVzBVSk9Bc2lzS0VaY2owWkQyUUtxRmZ0cERFUkY3QXUyY3d4L1pjY2N1?=
 =?utf-8?B?OW9OWGhEbjhnNWUxMFcxSEFXUXBKSXIvNzZwU2VINVFmVzQvcGN6TVcybXFM?=
 =?utf-8?B?bUlXbWllNmJNT0hSQkRsVjA4ZFUvZjVScWt4amxwUXNKQW1SRlp5MXlja0Zm?=
 =?utf-8?B?N0ZNSjNhZmZTcTZiYVdadjEzNUdwV2RGZzI3bk1mUXF1M3F2cU5kYVFnS2Rk?=
 =?utf-8?B?VlYvS2VIbGcwZjZpNThyR01yT2pGRDRnRVRKbVY3M1N6Q0Mrcmw0a2dOWGNm?=
 =?utf-8?B?dFA2enNzL2lHb0xuWE0zQ1FOVXVNZGVrZ2JIRUI1ODZYTCtFRmYvWDhkbEhy?=
 =?utf-8?B?Y1UwbGhKUVZ3UG9jMWR1OHpvK0doM3dlWWlDdHgwTkpiSHNoK3k5V3l5MGQr?=
 =?utf-8?B?SjlrR0pKdWRTMVVURi90N2Q0bkhic3RHdkRreERGN1RMNkMzeDlBaWFlSEox?=
 =?utf-8?B?dnhKZXFzZGRSWEF5WERLME9iZFltellkeURVaWZiUklKVWVpazdrZjdDdXFu?=
 =?utf-8?B?MWtqMlljaDZyVkxTWlJoYW9ldnVieDlrRjVOSUpQT2xERnlCZkJRQStrVmdx?=
 =?utf-8?B?YjJlYjVYeXJtU01nM0VyOWJPMzFmU3RtY01sNFIzd0Y1MExQM0pQL3lvRno3?=
 =?utf-8?B?N0hIWXZjcmhWeTY5WVlCZFlWZVhlRkRxLy9YbXdIamtqYnpEVnZZc1BJL24x?=
 =?utf-8?B?Y1lTQnIwbzMzK3JUTmE5SnpPS1JTNzBnU3lnMFdwT0QvRmRwaTZOR2habUhZ?=
 =?utf-8?B?anhzaXVGVVVOTHNrYktBa1orR1ZOck9OUFB5NzJrNkJZMUlqSDZUUzhUL0E0?=
 =?utf-8?B?OHhQZG9BcCtTaG5aV25MZVpYbVcxOTNmeHhVdmI5RHJmdTRGZHVzNFVLamYy?=
 =?utf-8?B?ZFJ3MEI2ajkxSEpsUlVKbWpTaDZZczNXNlgwUkVrRzJDbG5LZmlWQXZRajFv?=
 =?utf-8?B?RUdxV0luT0VrSld5MDNVbHREeWx5RGVTQ2luanZ3ZFhvMW5aVDFVY2JNdzZJ?=
 =?utf-8?B?b0FtQTg1bjFzSnFaQlgrNXZIZWNSYXdYbjNIczNnWEp6a1VTS1h5QUxQQ0Vn?=
 =?utf-8?B?bms3K0FaZFc3WkJHMm82YTAyQnBpdldZQjF5b3NxcW5JZTMyMVgwdGVMeG9o?=
 =?utf-8?B?SnFjWDFxYXlCREZyTDVSQjRFZWhySCt3K05WVWlha1RIVnJLemNKQVRhV2NY?=
 =?utf-8?Q?F2VyPjP0mksYbCTK/e43tnMDCyawys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 830669e0-3ce6-4856-a2b5-08dcdd6d8c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 14:22:55.1757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWZ3CYmGG6G/f3hr1zJPHc2Cgzc12xF/CXCaBEAfu88vXXIlO6T9Oi075nLQmkBtSH78jLOmC2I2SWvF+72fPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0718

VGhhbmtzIGZvciB0aGUgbGluay4NCg0KQWxzbyBjYW4geW91IHRyeSB0aGUgdGhpcmQgc3RlcCBv
biB5b3VyIHN0YW5kYXJkIGxpbnV4IGtlcm5lbCBieSBvbWl0dGluZyBGQU5fT1BFTl9QRVJNIGlu
IHRoZSBtYXNrIGFuZCBzaGFyZSB0aGUgb2JzZXJ2YXRpb25zIG9mIGdpdCBjbG9uZSBvcGVyYXRp
b24uIERvZXMgaXQgc3VjY2VlZCA/DQoNClRoYW5rIHlvdSwNCktyaXNobmEgVml2ZWsNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBn
bWFpbC5jb20+DQpTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNSwgMjAyNCA3OjQ2IFBNDQpU
bzogS3Jpc2huYSBWaXZlayBWaXR0YSA8a3ZpdHRhQG1pY3Jvc29mdC5jb20+DQpDYzogSmFuIEth
cmEgPGphY2tAc3VzZS5jej47IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBFcmljIFZh
biBIZW5zYmVyZ2VuIDxlcmljdmhAa2VybmVsLm9yZz47IExhdGNoZXNhciBJb25rb3YgPGx1Y2hv
QGlvbmtvdi5uZXQ+OyBEb21pbmlxdWUgTWFydGluZXQgPGFzbWFkZXVzQGNvZGV3cmVjay5vcmc+
OyB2OWZzQGxpc3RzLmxpbnV4LmRldg0KU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IEdpdCBj
bG9uZSBmYWlscyBpbiBwOSBmaWxlIHN5c3RlbSBtYXJrZWQgd2l0aCBGQU5PVElGWQ0KDQpPbiBX
ZWQsIFNlcCAyNSwgMjAyNCBhdCA0OjA04oCvUE0gS3Jpc2huYSBWaXZlayBWaXR0YSA8a3ZpdHRh
QG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPg0KPiBIaSBBbWlyLCBKYW4gS2FyYQ0KPg0KPiBUaGFu
a3MgZm9yIHRoZSByZXNwb25zZXMgc28gZmFyLiBBcHByZWNpYXRlZC4NCj4NCj4gSSBoYXZlIHRh
a2VuIHN0ZXAgYmFjaywgc3RhcnRlZCBhZnJlc2ggYW5kIHBlcmZvcm1lZCBhbm90aGVyIHRyaWFs
IHVzaW5nIHRoZSBmYW5vdGlmeSBleGFtcGxlIHByb2dyYW0gaW4gYW5vdGhlciBXU0wyIHNldHVw
Lg0KPg0KPiAxLikgVW5pbnN0YWxsZWQgTURFIHNvZnR3YXJlIGluIFdTTCB3aGVyZSBGQU5PVElG
WSB3YXMgaW5pdGlhbGl6ZWQgYW5kDQo+IHRoYXQgbWFya3MgdGhlIG1vdW50IHBvaW50IHVzaW5n
IG1hc2s6IEZBTl9DTE9TRV9XUklURSBvbmx5LiBFbnN1cmVkDQo+IG5vIHBpZWNlcyBvZiBtb25p
dG9yaW5nIHNvZnR3YXJlIGlzIHByZXNlbnQNCj4gMi4pIFJhbiB0aGUgZmFub3RpZnkgZXhhbXBs
ZSBwcm9ncmFtKHdpdGhvdXQgYW55IGNoYW5nZXMpIG9uIHA5IG1vdW50IHBvaW50IGFuZCBwZXJm
b3JtZWQgZ2l0IGNsb25lIG9uIGFub3RoZXIgc2Vzc2lvbi4gR2l0IGNsb25lIHdhcyBzdWNjZXNz
ZnVsLiBUaGlzIHByb2dyYW0gd2FzIHVzaW5nIG1hc2sgRkFOX09QRU5fUEVSTSBhbmQgRkFOX0NM
T1NFX1dSSVRFLg0KPiAzLikgTW9kaWZpZWQgdGhlIGZhbm90aWZ5IGV4YW1wbGUgcHJvZ3JhbSB0
byBtYXJrIHRoZSBtb3VudCBwb2ludCB1c2luZyBtYXNrIEZBTl9DTE9TRV9XUklURSBvbmx5LiBS
YW4gdGhlIGdpdCBjbG9uZS4gVGhlIG9wZXJhdGlvbiBmYWlscy4NCg0KSSByYW4gdGhlIHJlbmFt
ZV90cnkgcmVwcm9kdWNlciBvbmx5IHdpdGggRkFOX0NMT1NFX1dSSVRFIGV2ZW50cyB3YXRjaGVk
IGFuZCBjb3VsZCBub3QgcmVwcm9kdWNlLg0KDQo+DQo+IElzIGl0IHNvbWV0aGluZyB0byBkbyB3
aXRoIG1hc2sgPw0KPg0KPiBJIGRpZG4ndCBnZXQgYSBjaGFuY2UgdG8gcnVuIG9uIHN0YW5kYXJk
IGxpbnV4IGtlcm5lbC4gQ2FuIHlvdSBzaGFyZQ0KPiB0aGUgY29tbWFuZHMgdG8gZG8gc28gb2Yg
bW91bnRpbmcgOXAgb24gc3RhbmRhcmQgbGludXgNCj4NCg0KWW91J2QgbmVlZCBzb21lIDlwIHNl
cnZlci4NCkkgYW0gdXNpbmcgdGhlIDlwIG1vdW50IGluIHRoZSBrdm0gdGVzdCBib3ggdGhhdCB5
b3UgY2FuIGRvd25sb2FkIGZyb206DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS90eXRzby94ZnN0ZXN0
cy1ibGQvYmxvYi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9rdm0tcXVpY2tzdGFydC5tZA0KDQpUaGFu
a3MsDQpBbWlyLg0K

