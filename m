Return-Path: <linux-fsdevel+bounces-30217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B741C987E7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405081F2364F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 06:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA78F176AAE;
	Fri, 27 Sep 2024 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g78iVQMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE43158557
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727418876; cv=fail; b=Gp7RJFVt2YPNJmQVvVIj7PGTy6h52E+YBGGWJbOF79YDUsXpYqlnVAIfizyTeO9ksEQKt805rZIV4IGc41dgBeCakbkNCMnMoN6vfBsx5k+69JxwllLsfWWGxKZKYbD4Ljd/aYzP/U6wcbRj7tR+tNfjCtSjL5r4d+KKySSATHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727418876; c=relaxed/simple;
	bh=enpVpoD/TKJQsjIOOmrMjzmSWgbTdily6HmCsFNQyeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iiwGI2wj2bRuBAF/32S1DeLZx4a3e84YnLZFsSVMNcmw07zwS9XRoCAfydqfzjZ/h2TQ0xyD40Pax8q+EwXrzRdQuMsxsICINIIsErSUVpwpGj9jXPedFHqFiUFZeVS9Zx4qGPMN3isOrfzF/uVgQNY7jbQDpEIforysldL8xbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=g78iVQMY; arc=fail smtp.client-ip=40.107.215.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtTFkZy1ebEFbmW91GeOUo6j3SFRlwhMMZZAK/8bH+LetjqymKVFJn+mq6EscuhEGmN6+moSKV91tlrYg0hD7Dtd4etq7VzLqQOcD5emYwhEfi6AlJgoUTctVXarnDm2GBdB0DIYqucfe+s/dBUfoUAy2RqAwSo4mW4l45FrvGRCvfv2EqocknfIc+vp0Ja/dvxw/YCNAuaUQ/8D1Y9JaqHpIM3Lgp0K4p713Kmhlz84xH4SE/+CEs0efl3vRBH5vujVHw9e9+i7Pseu7WFiRMVXwwKGeN2ofhDaegRhkIyJB5b+qDd0ecLjTbrZZ8u2M2E9OYltprJu/BcExRqqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enpVpoD/TKJQsjIOOmrMjzmSWgbTdily6HmCsFNQyeU=;
 b=uNpRwfDUhHitP5IIEF3cfKYi8xkJVnYnncpw1k/L/RnwND4dXFyK7CWPXcOSh7cOd3VsFk9M5QeDr5M7+4ui4BBU+kovnvtpyOjBBp8F46Bg5l0vbMDY7nQYIPXGNhMifix8Ek1DTSRYJ+vNUTQYaAcVCG0BKRx/7NhDeHbxcdDrCGy6I0rThzL7ajT7ZjM5UZ6HiwID74ODMY1zMcU0/HAvHk6xkU91UBsJlPaGJIlxgCANps6RL0ZSK71e9SALEQI6zl3eMTQpDhOeKJJkNCVy4zj//0lZqVl6JPaFpQeyUf2b1W7J2J78DdFklMSr6J32XgMGZTOEEPDFtTeq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enpVpoD/TKJQsjIOOmrMjzmSWgbTdily6HmCsFNQyeU=;
 b=g78iVQMYVciMrfHOtStvSZ8NAgh2xPKtaXEjj1CLysOBCyXGEvv3DzI9YTX784+HP2qsuQsZP8tlIw6b1L2GGDRyn2hhn4EmmOvuufFXh6xDJirMLH8FOYZafj4QLjIfuOWLwAUQmalblqRfZyAydiTQLRGRjQ2Tx2DJW1DQH74=
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM (2603:1096:990:66::7) by
 SEZP153MB0661.APCP153.PROD.OUTLOOK.COM (2603:1096:101:90::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.9; Fri, 27 Sep 2024 06:34:28 +0000
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5]) by JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5%3]) with mapi id 15.20.8026.005; Fri, 27 Sep 2024
 06:34:26 +0000
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
 AdsMF7H2pA+A3TMFT7qIn4M6deqPigBk8OQAACP7Z1AACRNwgAABPHQwAAVRWhAAKioFAAAAOOwAAAVcZgAAAaOeAAAAm94AAAPF+pAAAR6dAAAAJY+wAAGPMoAAInJjcAAD3IQAABdEcYAAA5GXAAAPt18A
Date: Fri, 27 Sep 2024 06:34:25 +0000
Message-ID:
 <JH0P153MB099961BA4C71F05B394D0D6FD46B2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
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
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
 <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
 <CAOQ4uxivUh4hKoB_V3H7D75wTX1ijX4bV4rYcgMyoEuZMD+-Eg@mail.gmail.com>
 <CAOQ4uxgRnzB0E2ESeqgZBHW++zyRj8-VmvB38Vxm5OXgr=EM9g@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxgRnzB0E2ESeqgZBHW++zyRj8-VmvB38Vxm5OXgr=EM9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=454fbd94-a3a6-468a-be67-55b325868cfb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-27T05:40:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0P153MB0999:EE_|SEZP153MB0661:EE_
x-ms-office365-filtering-correlation-id: 174f0377-3d58-451e-e17b-08dcdebe6e89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yzg0MEtUUFB1SHBtUE1NanhIRWpWcFk4K0NOQkt3MGZkNTIyRUtTTnViRTdG?=
 =?utf-8?B?azhNSTM3YXlXMzdHRHowOEF0NnB6ZGUvWU5tL21Jb1pOYmtscHNiUW1qdG1y?=
 =?utf-8?B?MkNZcGtaVHE0RTI1eXNwdGVSSHozTlFqY3ExRDVud1pHM0E3Q0RJT2xwSHR3?=
 =?utf-8?B?bGVpdjhkNXE3enE0ZGtuSGhpUkwxMVQ0bUF0QmdWNjRndmN6K3hCRmhVL3lv?=
 =?utf-8?B?UldsKzVDVGo1LzRGd25YMUlZazZWQUNUNklaMERqSHBiT2s2L1pncit6OXp3?=
 =?utf-8?B?aVk3ZytNeWkxc2xTSUNLVlZQS01uVWJIbmVnRmxtSzE1dnUreTBhaGNyNXBv?=
 =?utf-8?B?elp5eGxDRWZENUZBYjdaNXU2WU4zVWhQTmpHQk9OeEJQOHZJUUZTL1VaL2pS?=
 =?utf-8?B?WVBPVWtxUlpuaU5zR3NqOHpPLzdHMDlmVURkc2RGVEtWcnFnN2pxZldiZlJC?=
 =?utf-8?B?TWQxSE9oczdGZDJSMUlXL2l2ZjVvZXlQQzY1bSs1ZThCYmxNWWRvWE1qOXZz?=
 =?utf-8?B?UHBNcGplbjNkZ0hqRjBXYnRtaWxhV2NxRlM4ZU9LRiszN0Z2QVdvdGozRHIv?=
 =?utf-8?B?VTh5M0ZUQjZjd0JaRlJEYk1IYnlxWUlIVFFQeW0zWURXcUQ1OWhYRnV3c1Zr?=
 =?utf-8?B?YlZLOER0b1JoWUQ5czZHWVV0aUpnQXF6TkZtR08xRUpUUWRZQ2xiNzU5TXdY?=
 =?utf-8?B?OWVwN0ZVVjhBKzdOUDZyRmtXdlQ3cXNGWTU0Mi9aeVlPQVhuanVyNkVBMkUw?=
 =?utf-8?B?VmxicE1SMlBaUFAwcFZhQlVubFZhTjRQdVlObUVmSzVIZklOa0wwdFdaYzNp?=
 =?utf-8?B?YnRhR1d1NWRadlZ4Znc0aTZXNjhkd3FjMGhtdU5lTS9kdFFnRFpFYjFzNk8y?=
 =?utf-8?B?Wk8reWxON2Q0by8rejhFTEp1YUtrckI0K0VQK2Z0V05uUXZjcjViVkM4TWNo?=
 =?utf-8?B?cUdNUVlMZ1ppcGczcjA5SjZYR04vYzlnVytaSjYvbFAzOHZHVnlFTjhBMUth?=
 =?utf-8?B?RE9qeU9XZkVLTis4Y2Y2dG1wMEhQVlJrOFB1dkNoUmxIYW44empUMGlkMzA4?=
 =?utf-8?B?bkFFZXVvc3A0ZTNnRHRXT2twclhLSXhTc3lsMjFVaTZ3S3FDelpKQmpMbyt4?=
 =?utf-8?B?V3VWYmp2N2kydVgyT2xydTZ4bDNpK3Z4VlVlSnJSSjZVMDdrZ2d3cWpKYUhz?=
 =?utf-8?B?eHpFZktUeXpabUtHdTdEQmE2MzlIazJ1YjhLREJ5RmdkYk1HdmF0eCtIaHk2?=
 =?utf-8?B?UjRqbzFTOUpYVGk2QVhXRFVoczBxTlBzTWFKaUU1aC9ROVJRSUdPendVQ0VB?=
 =?utf-8?B?NytWc0lEdm56TDYzT04weUI0bEpJd0FqeERuT1hKRUwxUkNMTjlWS3lvZHY3?=
 =?utf-8?B?ZFBwdmI0UlA0VlNvakhlRnhVRVVvanpFNkVNaENFQVc4K0NlOE5oTlMxRUlP?=
 =?utf-8?B?djEvTnp0NXZ3SGVvWDQ2a1hWTkQ2VllvTzRrZ2U0cWNId1BhVjhYVU13T2tE?=
 =?utf-8?B?T2MzTmVabTJ6ajN0S21YL1JlU3BobW5nR0RiNHVQUEhHUFNFeTRNdmwrWG5n?=
 =?utf-8?B?Mmwwb1lPbkxyaXZta2VTT1ROZlFMejBoRExpeXJUM3Vqd2kramlBWDBTL3Jr?=
 =?utf-8?B?djVIVGNSaDd0V3RILytTeXViNDdRejNlMTVzTnp1TVVTQTA4N1BYVG9ZM1BP?=
 =?utf-8?B?eUxIYkhpRlVBRmFjUGN0L1ZlRHRYbEJ2SnZxenRxQUEyOHVrNkZJUEllbFVK?=
 =?utf-8?B?QXF3WHRCZzlOU21CMjlkeEorbGNrdVVYSy85allkSUY5akdMVWI1d0JabUtV?=
 =?utf-8?B?TE5WZDFzbFlIUUZvN0VyQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0P153MB0999.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkNLQ3IzZFZRQUVpa0NFL1NZeTkydUI4NVpXS3Qrb1FyeUI1ZVNKZXFEWFRD?=
 =?utf-8?B?ZUxHZEluYy9ERGNFSWFCUzNIaW9ScmJWY0F5QVR0K3BXZkFTUCs1bVI4UWVo?=
 =?utf-8?B?clpqRnBCeVJtUDRMSCtncFlhbE1TZEc2bWtWNUNrZm5WNFZaT1l2K2pySmwy?=
 =?utf-8?B?c2Q5WFhxNDluaXEvRDl5VzNXUjhhQ1VKbDFNVmk2MTNJZldacUhaNUsvaGk1?=
 =?utf-8?B?SWZ2Y2YxcnBmR0tZZVl0TWhUMElyb0ZUZld3TjY4QTdoQkRDYWJDL1BmVC9h?=
 =?utf-8?B?YnpPcWo1ZHVBdXJLTzZ0dFhGcWI1Qm01dytac0FNdENsVllGYXl3RnJ4S1gx?=
 =?utf-8?B?VzU3MXdKV01icnpvUk1zUENadDVJZlpEMGU0bHdUbTNCQ3Z3RE9MZzJGWnMy?=
 =?utf-8?B?K3czUlpVckxhaEZYTVJiUlh1RGw2NHhVclp0WUZZeWxOMWhVZXBWT1Q3UXdH?=
 =?utf-8?B?cGVRRWo2KzZyOGh0RW40TFh1alVoQXBFaEl1MXBpZm8vekFicGlqd0tKTm5Y?=
 =?utf-8?B?bExTa29XRE1HNEJtZXFGUWcxVUJhUWhZeWhxUFVyeVVUNnV0SWhYSFZzOXU5?=
 =?utf-8?B?NWdJNWJsM2dzZ05JakhzYmtyYklidW13ODFBNHM2WTZORDFFbnBrUkRKTTFn?=
 =?utf-8?B?TVNBQlZHd0diQS9QVmtmNkFhZEMvc1ZBakk2bjhvRnRKcE1rcEYrbkR3Y3gr?=
 =?utf-8?B?U2wwckowVmxPUzJmYTBPdFFLSjMxdCtydXlqZ1VUZkR1cEdOZHlOQlNCL3Iw?=
 =?utf-8?B?anhHbnlHWjhQb2EvU09VVTIwTVRCQzVjd1o4LzAzMThuTkhKQzE2cWxNMExY?=
 =?utf-8?B?MnZpa0lVWDBpaTNMVmUyU3V6WE9kd3FUVmV3TzgxalA3VjFJOThZb2VaQTZ1?=
 =?utf-8?B?Um5SYUVDNHhrQWsvd2p6SmtnSzljb3NoUWVsNFVDSFloM251NG1WK1VqaE1z?=
 =?utf-8?B?cmVHQjB2YWtnZ2JCSXRyNkVSdWdXMEw3emx4amhsMXZ5a0VjVFBYb3p4OEls?=
 =?utf-8?B?WkJnTVBncGlMUE4yQU9BUS8ycjR0aDFLTFErNXNla2tVeTFBRlpjam8ydWhJ?=
 =?utf-8?B?MlZ5bnJ6TmpFRStYMnV4anA0ZE1uWHVGV2RPeHNOVThoaURJUitndWVvMXhI?=
 =?utf-8?B?aFpyZ1Z4MFFQcWE4RXhoSk4weG1GdDVHK3RjMFFaMjV2M1BBekNEcFJhdklk?=
 =?utf-8?B?bGRjcUF0RzJEZE9sS1R3VWlPMG9DQkVlZDY0NWcrcmt4Z25qTWxDa3BBS0Jj?=
 =?utf-8?B?MlhqNDAyQWpxemxndzF3Y0l0NHZOcldIU0dkZEJ4K1hpK09zVVByMTNqUi8z?=
 =?utf-8?B?ZjNOT2NyYU5FbUxTWGViUVNzRGZnTGRoRjZ1bGV4SjY1MzM4NWJCWU4rVlcv?=
 =?utf-8?B?aE1ZS1hsKzBrYVdLblpFNnRFaVRVQVFJenF6VFpIdDhxdTA2MVV5Zk9YdmRs?=
 =?utf-8?B?ZUFieHJGUDFIQW9pd3htdzVRSEJ6RVFrTmFkR2oxRmpvQXRjbVIyVnB3ZlRI?=
 =?utf-8?B?WTdVSk44Vm85K3ZadUNSVHVQMkQ3WWNFUXFlNDBoU2FsTkxEcUtMMzFNcWYy?=
 =?utf-8?B?cENNRnQwZER3Y1NTTU9VWWkrRktZVUdENlIwVjRWaGwxNWxGYnpSVDJzZENT?=
 =?utf-8?B?NkN2bGliR0QxSVgzZzlSRlNMQmJZTEIzQ3NGb2pMck9paGtBN0xabFJScEt4?=
 =?utf-8?B?VnJuU0cvcmJyVHhaVkdGc01wL3htZG0xSXZpdm9lYU40OCtYd2tpN25uMURP?=
 =?utf-8?B?SUJCWWk0eXZqaXpER2N0UlB1NGRPeXRnRVBKTENwYmtmWkRiZjBaQjgxT080?=
 =?utf-8?B?SVFZM3V2SXBQS2l6NU93emZ2RFJqdWZpc1RXUzc1Sll1dmgvY2lWVURGMGln?=
 =?utf-8?B?VkdoM3ZoOUx5bXExSkR2bkRjengwamYxYW1MV3NUTGFweFpLUlNvTUhTTW5y?=
 =?utf-8?B?cG9wU1d0Z2hFRk4xZjZ6WEdvdmJ5TldCVmxvaUp6K3pZUjJvdlN0RnYyL01T?=
 =?utf-8?Q?z/7QqSjy5VZMhsldXbvKihzdGLETyI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 174f0377-3d58-451e-e17b-08dcdebe6e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 06:34:25.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcIyHJ55czKPNj0w/fdPJ1LKgNLC/LhPLFRXHJ13PQfN1UeywXqGGvdzvKqbsmU97G6sAz4TiTpHvhite87XPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0661

SGkgQW1pcg0KDQpUaGFua3MgZm9yIHRoZSBleHBlcmltZW50LiBUaG91Z2ggcmVwcm9kdWNlciBw
cm9ncmFtIGlzIHN1Y2NlZWRpbmcgYnV0IGZhbm90aWZ5IGxpc3RlbmVyIGlzIHRlcm1pbmF0aW5n
IHNpbmNlIGl0cyBmYWlsaW5nIHRvIHJlYWQgdGhlIGV2ZW50LiBSaWdodCA/DQoNCkNhbiB5b3Ug
ZWxhYm9yYXRlIG9uOiAiIFdlIHNob3VsZCBjb25zaWRlciBhZGRpbmcgaXQgYXMgaXMgb3IgbWF5
YmUgcmF0ZWxpbWl0ZWQuIiA/DQoNCkRvZXMgdGhpcyBtZWFuIHRoZXJlIHNob3VsZCBiZSBhIGZp
eCBhdCBmYW5vdGlmeSBzaWRlID8NCg0KQ2FuIHlvdSBzdW1tYXJpemUgdGhlIHByb2JsZW0gc3Rh
dGVtZW50IGZvciBvbmNlIGluIGxhcmdlciBpbnRlcmVzdCBvZiBncm91cC4NCg0KSSBhc3N1bWUg
dGhlIHdob2xlIG9mIHRoZXNlIGV4cGVyaW1lbnRzIHN1Y2NlZWQgaW4gZXh0LCB4ZnMuDQoNCg0K
VGhhbmsgeW91LA0KS3Jpc2huYSBWaXZlaw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4gDQpTZW50OiBGcmlkYXks
IFNlcHRlbWJlciAyNywgMjAyNCAzOjQwIEFNDQpUbzogS3Jpc2huYSBWaXZlayBWaXR0YSA8a3Zp
dHRhQG1pY3Jvc29mdC5jb20+DQpDYzogSmFuIEthcmEgPGphY2tAc3VzZS5jej47IGxpbnV4LWZz
ZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBFcmljIFZhbiBIZW5zYmVyZ2VuIDxlcmljdmhAa2VybmVs
Lm9yZz47IExhdGNoZXNhciBJb25rb3YgPGx1Y2hvQGlvbmtvdi5uZXQ+OyBEb21pbmlxdWUgTWFy
dGluZXQgPGFzbWFkZXVzQGNvZGV3cmVjay5vcmc+OyB2OWZzQGxpc3RzLmxpbnV4LmRldg0KU3Vi
amVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IEdpdCBjbG9uZSBmYWlscyBpbiBwOSBmaWxlIHN5c3Rl
bSBtYXJrZWQgd2l0aCBGQU5PVElGWQ0KDQpPbiBUaHUsIFNlcCAyNiwgMjAyNCBhdCAxMDoyOOKA
r1BNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiA+ID4g
V2hhdCB3b3VsZCBiZSB0aGUgbmV4dCBzdGVwcyBmb3IgdGhpcyBpbnZlc3RpZ2F0aW9uID8NCj4g
PiA+DQo+ID4NCj4gPiBJIG5lZWQgdG8gZmluZCBzb21lIHRpbWUgYW5kIHRvIGRlYnVnIHRoZSBy
ZWFzb24gZm9yIDlwIG9wZW4gZmFpbHVyZSANCj4gPiBzbyB3ZSBjYW4gbWFrZSBzdXJlIHRoZSBw
cm9ibGVtIGlzIGluIDlwIGNvZGUgYW5kIHJlcG9ydCBtb3JlIA0KPiA+IGRldGFpbHMgb2YgdGhl
IGJ1ZyB0byA5cCBtYWludGFpbmVycywgYnV0IHNpbmNlIGEgc2ltcGxlIHJlcHJvZHVjZXIgDQo+
ID4gZXhpc3RzLCB0aGV5IGNhbiBhbHNvIHRyeSB0byByZXByb2R1Y2UgdGhlIGlzc3VlIHJpZ2h0
IG5vdy4NCj4NCj4gRldJVywgdGhlIGF0dGFjaGVkIHJlcHJvZHVjZXIgbWltaWNzIGdpdCBjbG9u
ZSByZW5hbWVfb3ZlciBwYXR0ZXJuIGNsb3Nlci4NCj4gSXQgcmVwcm9kdWNlcyBmYW5vdGlmeV9y
ZWFkKCkgZXJyb3JzIHNvbWV0aW1lcywgbm90IGFsd2F5cywgd2l0aCANCj4gZWl0aGVyIENMT1NF
X1dSSVRFIG9yIE9QRU5fUEVSTSB8IENMT1NFX1dSSVRFLg0KPiBtYXliZSBDTE9TRV9XUklURSBh
bG9uZSBoYXMgYmV0dGVyIG9kZHMgLSBJJ20gbm90IHN1cmUuDQo+DQoNCnNjcmF0Y2ggdGhhdC4N
CkkgdGhpbmsgdGhlIHJlbmFtZXMgd2VyZSBqdXN0IGEgZGVzdHJ1Y3Rpb24gZ2l0IGNsb25lIGV2
ZW50cyBkbyBub3QgYWx3YXlzIGZhaWwgb24gYSBjbG9zZStyZW5hbWUgcGF0dGVybiwgdGhleSBh
bHdheXMgZmFpbCBvbiB0aGUgY2xvc2UrdW5saW5rIHRoYXQgZm9sbG93cyB0aGUgcmVuYW1lczoN
Cg0KMTc3NiAgb3BlbmF0KEFUX0ZEQ1dELCAiL3Z0bXAvZmlsZWJlbmNoLy5naXQvdGpFek1VdyIs
IE9fUkRXUnxPX0NSRUFUfE9fRVhDTCwgMDYwMCkgPSAzDQoxNzc2ICBjbG9zZSgzKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgPSAwDQoxNzc2ICB1bmxpbmsoIi92dG1wL2ZpbGViZW5jaC8uZ2l0
L3RqRXpNVXciKSA9IDANCjE3NzYgIHN5bWxpbmsoInRlc3RpbmciLCAiL3Z0bXAvZmlsZWJlbmNo
Ly5naXQvdGpFek1VdyIpID0gMA0KMTc3NiAgbHN0YXQoIi92dG1wL2ZpbGViZW5jaC8uZ2l0L3Rq
RXpNVXciLCB7c3RfbW9kZT1TX0lGTE5LfDA3NzcsIHN0X3NpemU9NywgLi4ufSkgPSAwDQoxNzc2
ICB1bmxpbmsoIi92dG1wL2ZpbGViZW5jaC8uZ2l0L3RqRXpNVXciKSA9IDANCg0KSSBrbm93IGJl
Y2F1c2UgSSBhZGRlZCB0aGlzIHByaW50Og0KDQotLS0gYS9mcy9ub3RpZnkvZmFub3RpZnkvZmFu
b3RpZnlfdXNlci5jDQorKysgYi9mcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnlfdXNlci5jDQpA
QCAtMjc1LDYgKzI3NSw3IEBAIHN0YXRpYyBpbnQgY3JlYXRlX2ZkKHN0cnVjdCBmc25vdGlmeV9n
cm91cCAqZ3JvdXAsIGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoLA0KICAgICAgICAgICAgICAgICAq
Lw0KICAgICAgICAgICAgICAgIHB1dF91bnVzZWRfZmQoY2xpZW50X2ZkKTsNCiAgICAgICAgICAg
ICAgICBjbGllbnRfZmQgPSBQVFJfRVJSKG5ld19maWxlKTsNCisgICAgICAgICAgICAgICBwcl93
YXJuKCIlcyglcGQyKTogcmV0PSVkXG4iLCBfX2Z1bmNfXywgcGF0aC0+ZGVudHJ5LA0KY2xpZW50
X2ZkKTsNCiAgICAgICAgfSBlbHNlIHsNCg0KV2Ugc2hvdWxkIGNvbnNpZGVyIGFkZGluZyBpdCBh
cyBpcyBvciBtYXliZSByYXRlbGltaXRlZC4NCg0KVGhlIHRyaXZpYWwgcmVwcm9kdWNlciBiZWxv
dyBmYWlscyBmYW5vdGlmeV9yZWFkKCkgYWx3YXlzIHdpdGggb25lIHRyeS4NCg0KVGhhbmtzLA0K
QW1pci4NCg0KaW50IG1haW4oKSB7DQogICAgY29uc3QgY2hhciAqZmlsZW5hbWUgPSAiY29uZmln
LmxvY2siOw0KICAgIGludCBmZDsNCg0KICAgIC8vIENyZWF0ZSBhIG5ldyBmaWxlDQogICAgZmQg
PSBvcGVuKGZpbGVuYW1lLCBPX1dST05MWSB8IE9fQ1JFQVQgfCBPX1RSVU5DLCAwNjQ0KTsNCiAg
ICBpZiAoZmQgPT0gLTEpIHsNCiAgICAgICAgcGVycm9yKCJGYWlsZWQgdG8gY3JlYXRlIGZpbGUi
KTsNCiAgICAgICAgcmV0dXJuIEVYSVRfRkFJTFVSRTsNCiAgICB9DQogICAgY2xvc2UoZmQpOw0K
DQogICAgLy8gUmVtb3ZlIHRoZSBmaWxlDQogICAgaWYgKHVubGluayhmaWxlbmFtZSkgIT0gMCkg
ew0KICAgICAgICBwZXJyb3IoIkZhaWxlZCB0byB1bmxpbmsgZmlsZSIpOw0KICAgICAgICByZXR1
cm4gRVhJVF9GQUlMVVJFOw0KICAgIH0NCg0KICAgIHJldHVybiBFWElUX1NVQ0NFU1M7DQp9DQo=

