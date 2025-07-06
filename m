Return-Path: <linux-fsdevel+bounces-54029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBADAFA41E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D86C3A7A6B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE831BD9C1;
	Sun,  6 Jul 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="VOunFbQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287E15D1
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751795175; cv=fail; b=akQgXL8UJOeM0do/egK3sB+N/75MvZiq7Se5g3PO0yARbVzzdB/RCDdoyuUEqZ5Yq9uwGiQTBEzZX0NqJn5pqn44i/hS1JJBTzFcXV+W+y47bQ4mcFMyiWFSmWOiCWJzcwdo76SxCmU/kvJAkHzgUqKMr0qW2K/wpZMUk0eZ8AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751795175; c=relaxed/simple;
	bh=9pIoDMfpob+umEEB3H7CRRPY4iVlsZvrRrM7q+DVVv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vF2edecYywyRHBhWqOfxC7vfApykJ93to7tIR7wPPot97DidNH+7Obc8siObXZUbWZEylBMgMmdNSwzDew4tbzt8r4i5zJXucG+iN5SNHliHqQxLhS1flRRXBXsf5CPfj8v91XDg89pYE8UjxxSRa1fH2G3LZvQ/K/c3ubwij5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=VOunFbQC; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7JjCm/pqiyA8QrE3vEJ8pUp1hJqDi+vxUYcrhAoNHEY01+S5USnJeOHL7aR3wyQQd3+J4OH50Ijfh0w9Eojv3CdG4TeC+Xky848nPIhfmWiHRDiTTnTW5iqZb80587Frecd3Tg663/dc8v6EIwE+KUcB5CWABD4jiAUv1+0Tkp/CipQR+PjDCEI2jB7ss5RWmfpzbO7H0I+ZMfslspdhpdNa53oT8orYfA4GJsgoddKAo+4Fjs6Sz/wdqJktMXNNLgi7b/C6Y5Dr2vTmitjxcerc8vyIbtLfVHrAzQ26ZrsU5PA/gDvZaijZWEAQ0ZAWKcdSECyrQQy95d03KCLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pIoDMfpob+umEEB3H7CRRPY4iVlsZvrRrM7q+DVVv8=;
 b=UUW5rXM1Xd4nwi2eo1c1dCWtxm6wmXyivoz3/GVdM0t+P8f7Lrmsyx/lACNyjuxahSnGhjxGlfe4oC0R982yBNDVu5xwlj2CvGIpedQGjR9fe2JMtSi8LkI3VfCyqpapeBo2+IGWjpIpz2jcchMfwe/RNO8FmkJXxOUMQ8p2WeNQNYwhg40CQyYzmxI3R3gy9E7W87Ea9DRdhX/x0Gss+IIBDLO1nLQm+MH6unbDBnePGd7PCM0I4/pBWcg5w1ZJSflS/9NjJKLxBcI8wz9Prv01Ky6S2O3DpiW25LXhECugYkA/38f01vgefDwuWRhhspcACDXdZGb9+njpY6GgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pIoDMfpob+umEEB3H7CRRPY4iVlsZvrRrM7q+DVVv8=;
 b=VOunFbQCr5FlxCmCBh0XpHoz5xgV5+QUKGjXo/Jcs1zaSz2cP40y3YxxW1H9rb70vR1onq8Ptje6o2HgusFjP3r7rwzzquef0Zh6b0ZRfXUzQ/2gMxpA9lPnjw0zZOdz8CDVWVSqi1G7CuTYLw3B13Fk3J6dYW7FoueeOLC2aYaWWeQN4PxgqeQD7K1e4QFj9H4A0JE12yZzw26I0Jz5KVxZMxX/uvIov3Y6W81PjDX6olZNbmeATOK6SpKzAAxbtrOaXf03tNfulVaR2PQDWQInETzDApoxhWRuuez2liKP2CeHs0KQkU8IZr6C4xn2DyM1AXmoFM3xegttYuJPWQ==
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com (2603:10a6:20b:16::28)
 by PAWPR07MB9760.eurprd07.prod.outlook.com (2603:10a6:102:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Sun, 6 Jul
 2025 09:46:10 +0000
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f]) by AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f%4]) with mapi id 15.20.8901.018; Sun, 6 Jul 2025
 09:46:10 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: Phillip Lougher <phillip@squashfs.org.uk>, linux-fsdevel
	<linux-fsdevel@vger.kernel.org>
CC: "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>
Subject: Re: squashfs can starve/block apps
Thread-Topic: squashfs can starve/block apps
Thread-Index: AQHb5nGdF4RIk2KD1kCWx8Hz+RNSl7QVf/0AgAztRQCAAnt0gA==
Date: Sun, 6 Jul 2025 09:46:09 +0000
Message-ID: <a215768cad23860c2e185e909472697a5bd4708f.camel@nokia.com>
References: <bd03e4e1d56d67644b60b2a58e092a0e3fdcff57.camel@nokia.com>
	 <88b54d9a1562393526abc4556a6105ef1aca7ace.camel@nokia.com>
	 <443821641.1977435.1751658706057@eu1.myprofessionalmail.com>
In-Reply-To: <443821641.1977435.1751658706057@eu1.myprofessionalmail.com>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4549:EE_|PAWPR07MB9760:EE_
x-ms-office365-filtering-correlation-id: a51f3e25-8bce-4aec-e481-08ddbc71f003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3lSdnFyR3hkT2RYbHNXWlRQNnFFUk1IaTcxajdtWHhHOE9RT08xMTVmMjRj?=
 =?utf-8?B?aVBIaXc4bnRaSDdlZHJLOGQrN3Z3YVl5SDF6b0t6OWlPQ2U1MjA0TE9mNEta?=
 =?utf-8?B?dFhXOTVhMDFPbzV6SlBoWmp3ZjkyRXpBOTRhS29UVkRWbHlRaC8rQTNiNkYz?=
 =?utf-8?B?WXZmL1pKRWpMNlhwTXdqaWxEM25JdEtuVmpscUhrWDRMMlJVb0VSVHJZOGdZ?=
 =?utf-8?B?bkt5NVpBM1gwdEVMMDJPMFlpeHV1dGdNRnVjK0NCT1V5RXQ5OCtGMWNZSkti?=
 =?utf-8?B?aVpyaGxBK0hWbVVkbGJhbnM0U1UwTHdNOERTd3k5cWVaSHBCWUkrRWlNVzh3?=
 =?utf-8?B?SjArKzMwaFZLN0lXYlVGVUVvT3I4R0pvanBnNmxJTEFVVEZrNWlMUFM0SVJW?=
 =?utf-8?B?NkdzcDRwUFc4SVFoT0kxanp4YzlyUlFqQmIzcjZlL2N3dER1OFRlUThZZmc1?=
 =?utf-8?B?Uy9GWGNLMjJSMm53aklEazhTRit6YWtidFRZM1FpaXQveXJuUUxQakZzRUJY?=
 =?utf-8?B?NWUzRjBvc29NTVF6VFYyVFI4d1Y1Z3Y4YnFmbk5nWnRIRHlIT0Z3UVViVS9F?=
 =?utf-8?B?Z2kwRVlWT2U3K2pEbEVaR2FMMGZPTXBnNjdVTEJZaHBrZ3V1QnFGNnZ4YUFt?=
 =?utf-8?B?U1U0OVpIRXFOTU16aXJ2OHhqS2VXSWkyTjlmTmxNeVNVUWMrUWhJdXZNT1Mr?=
 =?utf-8?B?alpQc3hnWTdtNko0ZjFUU1JTa1RVazlhV1htOTZHZDlYMjUyN3JCbEw4d2N0?=
 =?utf-8?B?N3MrTGRseHB5Tnk1MFIxZ21ZT2hCMHZLTWdvTnZyMWFuNjFvR1lBMEhpS2U0?=
 =?utf-8?B?SGFSTE5UaVNiSUQrUXNJemlMcDNtdXFFdHQ2bldFZHJjYk5rYWg3cW4zNWpi?=
 =?utf-8?B?VlFHcGVaZHpnVUxQMVl4amsxdElOYjNOQzlERVVaY3pJaXA1YU5SRXJzSFQx?=
 =?utf-8?B?NG1uZjdTNUxZM2lVUitJU1NqeUpaTGNjUC9ORTVWSm5sQ3BDN21FaUhQdllO?=
 =?utf-8?B?aTJyM01kdVF2R29uMlF2Y1Z0UkJJOFFwOUNiU3pUdytFY05VcDhLUWtmLyt2?=
 =?utf-8?B?QkNhNEYvNlFjOWwzdm1BSEsycncwUVEvbmN0VE9wbEhySkY5eHNSWDBuVTUw?=
 =?utf-8?B?NExXdWI5Rm9RbEp1QS8rMkpaZDFydU1uczhYOW1lSjNGSi83bktSak1Eck9r?=
 =?utf-8?B?a3c4VHA0cXhDZm5DWk9RKzIzNmpxVSsxRkw3S1plaldxNmFGb00xQTY0VjBX?=
 =?utf-8?B?Q2tDVE5jM1VNeXZNaW1sVEE2bGxnSURyMk9OekpPNDJFQ1hEV0orVGhyVUZD?=
 =?utf-8?B?RElua0w4aloweCt6OXg0djN6ZG4zaXpWYWFXY3AvZjRxSFJvQytNWVl5UHUw?=
 =?utf-8?B?Q3JlNWlWOHo0N1RiRkVRYWplblY1cnhZTnEzeHl3UTd6elBFNkFaSHpIWXFM?=
 =?utf-8?B?K0E3MDc1UEhmWkdpMEh2SWxsU3ZDTk96bGpHVUd3YUhTVWJpOHA0QWMvTWww?=
 =?utf-8?B?TzRVSm1kOFd3THd0R2E4UDFrcmJzQ01uKzlLRGs1dGZNQlVhYURuRENQaWJx?=
 =?utf-8?B?eC96a21aa3AxNWRteWF4c1JKN3dGVHRaWFZSdmxzRlBUZGZ2cmRJOVRIb2dq?=
 =?utf-8?B?dE0zNkRhQ3FOTjZnSFU5V1l4YlhqZGVhZ1ZUWHJHMlQ0VWlUdWFoZzJhemNh?=
 =?utf-8?B?SEtWWUhkbmw4LzdoNlpmWTJZVWUwVHF5SE8zYWpiMG13am1hYnhIS3p6U0hX?=
 =?utf-8?B?SE5LdHBaWjFRVzE5L0x3L0NsNXkycm5FV2w3SHpoZjJtcHlOUkQ0KzJIZERu?=
 =?utf-8?B?QytKNUY1amNtK3I5azJRbXo4cExGWlRZUTJKYlUydi9qdHZ4OTRXNXBaU3hR?=
 =?utf-8?B?S2huUytJdTExZ0xjWURvSG9WR1QxU0EwQjRVRTk4U0w3dDBKVitmcXcyc2Nk?=
 =?utf-8?Q?hZdmeDJfJ5o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4549.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUpUampxdkhvTlRtbjY0a08wTFBrYzR0eFBzSStsbUQyaCtLcnJPTzFuUkVC?=
 =?utf-8?B?UndkVG1ocTlzL21QWmJhc1YxdC8ydzEycmJFeDdGQkdJV2YvZklBUndqa2p3?=
 =?utf-8?B?TjQ0RDFoUHdSTHZseHNoOXNoRXhEVmYrYTM2QXczbjJkb1JXZEhHaFZFUmRJ?=
 =?utf-8?B?ZFJNekl1ZVBHdUVxeWxUR0lJK2t1ZWRqS3pieWd1blJ4bGlhSHJqdlM4dGdG?=
 =?utf-8?B?a3Q1ZXVVRFNVZC9kbEVoVnU4RUFFOGR6UUJQRzExM2pOenBKN0p6L25NVXIw?=
 =?utf-8?B?WjVQV0tqcWtONjFoUHNNQUJxMnhSazc5RXVweWRzaUMzT2ZKclhmZkxSWmhw?=
 =?utf-8?B?ZGk2UVJsc1FOMFFZczMxUy9pTEQyMDVxTFNJWTRoOVV4M25rMDN1Z0VySlFC?=
 =?utf-8?B?STlzVG5nQXFaMlc2R1UxUDZ6Q2xDcVRBM3RXUkNyZ0NHUWpLRUJpNnpSL0w0?=
 =?utf-8?B?OTB6eUpWampsV2xIckIySVlIT3MrZnE4cFl5MFplN3pueUZ6VXhHVER6VXYx?=
 =?utf-8?B?elhFakk1K0tNZTRRMjVsUHdlSGtRUkxUallvcXN1bUoxb0daTzJtZmtVSWYv?=
 =?utf-8?B?ZHI5dGEwMkd5ZU9OSXJJaWVIdmNSb3ltbjQySDZ3Q1liSmhrMVNUb05YTjJI?=
 =?utf-8?B?QmErVzBlQ0VLSkJJN0JndC83cjh2Q2RQUGdGbkFhN2RuOXNEeEp0c3RGMnBx?=
 =?utf-8?B?TEJsT1VJUU5BU205MWJJMlFWYmc3eklKbDJpR2ZIZVVFUVRMMjlZWVVpN1g1?=
 =?utf-8?B?eXNpQkdPeEpNSHJFRFpBbG5nbDRZSXhXakxGVGczTk5va3JEUWhWdCtzaXQ0?=
 =?utf-8?B?UkdQQzZFaDR6QXpqY3Q5WFVMNjRrSUc2Z2JPTFVyM0hDc3cyZE0rbWlVMEFW?=
 =?utf-8?B?clUzWXRXb1A2eTNtc1FIOXBRVWhUVGY2bjdmK0xmS2lRSUQvRjF5Y2xuSmtu?=
 =?utf-8?B?bnBlZlBmOWNqeVRWanliVElQU1BmNkhWYmFqUC84dm1EbERJMVJ1QVpTbUVk?=
 =?utf-8?B?RUQrUGxYT3ZzVkVoSjNERlFSVnpuekRsVndsTExRTXNQSytFcktzbm1oT2p4?=
 =?utf-8?B?cG00RnN6ODdSMzN5Ni9WT0JSMFY4OWtSQjNyUXNLck5hUFhxV2RNOEp5N21E?=
 =?utf-8?B?WDNDc2pPTkxiVy9hbCtUZWNEcXIzcGN4byt3UURoeURmU3ZtdTR1dlBrWFdW?=
 =?utf-8?B?VER0TTIvVjJsVUJpQ05KV3hFZWtZK1h1bWYrL0xzS1Y2WXNpbjNvUjFybkVG?=
 =?utf-8?B?RG5kTEttWXlKemZUaWs2TUlZZ0tUdkZ6eUdEZEVvOXVoZzdjVEZEM1RoZFJB?=
 =?utf-8?B?VzJIRHY5STFrZW52eWxCNlIvUW5xemFmZWhFQlJtWHpNL1ZZWVU4UzRKcWtR?=
 =?utf-8?B?Q2p2UGhUWnFXcmlQSEE2VHpaMDRGVDJaWXVLUWlaL1YzLzMyam5TQUhEMDNO?=
 =?utf-8?B?Z3hMbnAzbDhpS0l1c2JLSm4zZjdQd25TWUZma1hXb21WQWZZNXJzUkcxczN6?=
 =?utf-8?B?TlVFUGs5N3RrTFA2YXNjd0wweG5MRnB0MWF1ZS9IM3lQZTZOSlpzekU4Mjh4?=
 =?utf-8?B?MC8rTHlDQ3kyRVhxemdXUWRSOWpxNEV4S2dPRHNScm1IU2dyRTJpb3V2ZTl0?=
 =?utf-8?B?THJyTVZQSW52YVpQaWwyNDhhR2RUZUJtZDhHelV1dE9ScnZJU1RQUGZxemtt?=
 =?utf-8?B?M21PWnBtQktxa0I3K2dBVk5XWnBaNmhaR21KMi9lVTg5UUk4aWFTS0xnUVVU?=
 =?utf-8?B?TDNESDcrSlRjajE0aWx3d3JVTlJRUDQ1Y2lVUEJCSFN1SlMxTVMrYVlabjZV?=
 =?utf-8?B?S2dqOWpyWWVYVkxjTzlnQWdYLzNzZ2Z0ZVFiSGJPU0V4c2IzdHFoRGliYllI?=
 =?utf-8?B?ZUJhbUNyTTZSS25CVmRFN2J1OStudFdOYmt2Mm81a3dZK2R6VVZGS09ocWJ6?=
 =?utf-8?B?dDFmNWl0Q2d1dlNiV2h0OHN0MHJJVHNsRW5wdk5YWUFrMXVlYlNzVythb0p3?=
 =?utf-8?B?em9IU05CQVdQWHlwbXBkOHZjMmpPUFk1NDNBa2tFaFE3RXlWRGROcDlZeUhY?=
 =?utf-8?B?SFJPTTVINm0yT2tDTUhQMmg3NmNwR0hKd0pqbitIVnk1Yllrc2dCd0dON3Zi?=
 =?utf-8?Q?anVUrQj8Gt7IlQttqfPAbLlUa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF9859AD83D67842B9596931923E447B@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a51f3e25-8bce-4aec-e481-08ddbc71f003
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2025 09:46:10.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZotKBTRAFT+Nwqxxkel1TOLksEaVLUxlzhe0FZxvjKWmx0lsMxbhV2ihBZNgz3N6UjuexcDDQR702TO0VzMnK4up2BYs9HsmGYPt6tSCYjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9760

T24gRnJpLCAyMDI1LTA3LTA0IGF0IDIwOjUxICswMTAwLCBQaGlsbGlwIExvdWdoZXIgd3JvdGU6
DQo+DQo+DQo+ID4gT24gMjYvMDYvMjAyNSAxNToyNyBCU1QgSm9ha2ltIFRqZXJubHVuZCAoTm9r
aWEpIDxqb2FraW0udGplcm5sdW5kQG5va2lhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9u
IFRodSwgMjAyNS0wNi0yNiBhdCAxMDowOSArMDIwMCwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToN
Cj4gPiA+IFdlIGhhdmUgYW4gYXBwIHJ1bm5pbmcgb24gYSBzcXVhc2hmcyBSRlMoWFogY29tcHJl
c3NlZCkgYW5kIGEgYXBwZnMgYWxzbyBvbiBzcXVhc2hmcy4NCj4gPiA+IFdoZW5ldmVyIHdlIHZh
bGlkYXRlIGFuIFNXIHVwZGF0ZSBpbWFnZShzdHJlYW0gYSBpbWFnZS54eiwgdW5jb21wcmVzcyBp
dCBhbmQgb24gdG8gL2Rldi9udWxsKSwNCj4gPiA+IHRoZSBhcHBzIGFyZSBzdGFydmVkL2Jsb2Nr
ZWQgYW5kIG1ha2UgYWxtb3N0IG5vIHByb2dyZXNzLCBzeXN0ZW0gdGltZSBpbiB0b3AgZ29lcyB1
cCB0byA5OSslDQo+ID4gPiBhbmQgdGhlIGNvbnNvbGUgYWxzbyBiZWNvbWVzIHVucmVzcG9uc2l2
ZS4NCj4gPiA+DQo+ID4gPiBUaGlzIGZlZWxzIGxpa2Uga2VybmVsIGlzIHN0dWNrL2J1c3kgaW4g
YSBsb29wIGFuZCBkb2VzIG5vdCBsZXQgYXBwcyBleGVjdXRlLg0KPiA+ID4NCj4NCj4gSSBoYXZl
IGJlZW4gYXdheSBhdCB0aGUgR2xhc3RvbmJ1cnkgZmVzdGl2YWwsIGhlbmNlIHRoZSBkZWxheSBp
biByZXBseWluZy4gQnV0DQo+IHRoaXMgaXNuJ3QgcmVhbGx5IGFueXRoaW5nIHRvIGRvIHdpdGgg
U3F1YXNoZnMgcGVyIHNlLCBhbmQgYmFzaWMgY29tcHV0ZXINCj4gc2NpZW5jZSB0aGVvcnkgZXhw
bGFpbnMgd2hhdCBpcyBnb2luZyBvbiBoZXJlLiAgU28gSSdtIHN1cnByaXNlZCBuby1lbHNlIGhh
cw0KPiByZXNwb25kZWQuDQo+DQo+ID4gPiBLZXJuZWwgNS4xNS4xODUNCj4gPiA+DQo+ID4gPiBB
bnkgaWRlYXMvcG9pbnRlcnMgPw0KPg0KPiBZZXMsDQo+DQo+ID4gPg0KPiA+ID4gIEpvY2tlDQo+
ID4NCj4gPiBUaGlzIHdpbGwgcmVwcm9kdWNlIHRoZSBzdHVjayBiZWhhdmlvdXIgd2Ugc2VlOg0K
PiA+ICA+IGNkIC90bXAgKC90bXAgaXMgYW4gdG1wZnMpDQo+ID4gID4gd2dldA0KPiA+IGh0dHBz
Oi8vZnVsbGltYWdlLnh6Lw0KPg0KPiBZb3UndmUgaWRlbnRpZmllZCB0aGUgY2F1c2UgaGVyZS4N
Cj4NCj4gPg0KPiA+IFNvIGp1c3QgZG93bmxvYWRpbmcgaXQgdG8gdG1wZnMgd2lsbCBjb25mdXNl
IHNxdWFzaGZzLCBzZWVtcyB0bw0KPiA+IG1lIHRoYXQgc3F1YXNoZnMgc29tZWhvdyBzZWUgdGhl
IHh6IGNvbXByZXNzZWQgcGFnZXMgaW4gcGFnZSBjYWNoZS9WRlMgYW5kDQo+ID4gdHJpZWQgdG8g
ZG8gc29tZXRoaW5nIHdpdGggdGhlbS4NCj4NCj4gQnV0IHRoaXMgaXMgdGhlIGNvbXBsZXRlbHkg
d3JvbmcgY29uY2x1c2lvbi4gIFNxdWFzaGZzIGRvZXNuJ3QgIm1hZ2ljYWxseSINCj4gc2VlIGZp
bGVzIGRvd25sb2FkZWQgaW50byBhIGRpZmZlcmVudCBmaWxlc3lzdGVtIGFuZCB0cnkgdG8gZG8g
c29tZXRoaW5nDQo+IHdpdGggdGhlbS4NCj4NCj4gV2hhdCBpcyBoYXBwZW5pbmcgaXMgdGhlIHN5
c3RlbSBpcyB0aHJhc2hpbmcsIGJlY2F1c2UgdGhlIHBhZ2UgY2FjaGUgZG9lc24ndA0KPiBoYXZl
IGVub3VnaCByZW1haW5pbmcgc3BhY2UgdG8gY29udGFpbiB0aGUgd29ya2luZyBzZXQgb2YgdGhl
IHJ1bm5pbmcNCj4gYXBwbGljYXRpb24ocykuDQo+DQo+IFNlZSBXaWtpcGVkaWEgYXJ0aWNsZQ0K
PiBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9UaHJhc2hpbmdfKGNvbXB1dGVyX3NjaWVu
Y2UpDQo+DQo+IFRtcGZzIGZpbGVzeXN0ZW1zICgvdG1wIGhlcmUpIGFyZSBub3QgYmFja2VkIGJ5
IHBoeXNpY2FsIG1lZGlhLCBhbmQgdGhlaXINCj4gY29udGVudCBhcmUgc3RvcmVkIGluIHRoZSBw
YWdlIGNhY2hlLiAgU28gaW4gZWZmZWN0IGlmIGZ1bGxJbWFnZS54eiB0YWtlcw0KPiBtb3N0IG9m
IHRoZSBwYWdlIGNhY2hlIChzeXN0ZW0gUkFNKSwgdGhlbiB0aGVyZSBpcyBubyBtdWNoIHNwYWNl
IGxlZnQgdG8gc3RvcmUNCj4gdGhlIHBhZ2VzIG9mIHRoZSBhcHBsaWNhdGlvbnMgdGhhdCBhcmUg
cnVubmluZywgYW5kIHRoZXkgY29uc3RhbnRseSByZXBsYWNlDQo+IGVhY2ggb3RoZXJzIHBhZ2Vz
Lg0KPg0KPiBUbyBtYWtlIGl0IGVhc3ksIGltYWdpbmUgd2UgaGF2ZSB0d28gcHJvY2Vzc2VzIEEg
YW5kIEIsIGFuZCB0aGUgcGFnZSBjYWNoZQ0KPiBkb2Vzbid0IGhhdmUgZW5vdWdoIHNwYWNlIHRv
IHN0b3JlIGJvdGggdGhlIHBhZ2VzIGZvciBwcm9jZXNzZXMgQSBhbmQgQi4NCj4NCj4gTm93Og0K
Pg0KPiAxLiBQcm9jZXNzIEEgc3RhcnRzIGFuZCBkZW1hbmQtcGFnZXMgcGFnZXMgaW50byB0aGUg
cGFnZSBjYWNoZSBmcm9tIHRoZQ0KPiAgICBTcXVhc2hmcyByb290IGZpbGVzeXN0ZW0uICBUaGlz
IHRha2VzIENQVSByZXNvdXJjZXMgdG8gZGVjb21wcmVzcyB0aGUgcGFnZXMuDQo+ICAgIFByb2Nl
c3MgQSBydW5zIGZvciBhIHdoaWxlIGFuZCB0aGVuIGdldHMgZGVzY2hlZHVsZWQuDQo+DQo+IDIu
IFByb2Nlc3MgQiBzdGFydHMgYW5kIGRlbWFuZC1wYWdlcyBwYWdlcyBpbnRvIHRoZSBwYWdlIGNh
Y2hlLCByZXBsYWNpbmcNCj4gICAgUHJvY2VzcyBBJ3MgcGFnZXMuICBJdCBydW5zIGZvciBhIHdo
aWxlIGFuZCB0aGVuIGdldHMgZGVzY2hlZHVsZWQuDQo+DQo+IDMgUHJvY2VzcyBBIHJlc3RhcnRz
IGFuZCBmaW5kcyBhbGwgaXRzIHBhZ2VzIGhhdmUgZ29uZSBmcm9tIHBhZ2UgY2FjaGUsIGFuZCBz
bw0KPiAgIGl0IGhhcyB0byByZS1kZW1hbmQtcGFnZSB0aGUgcGFnZXMgYmFjay4gIFRoaXMgcmVw
bGFjZXMgUHJvY2VzcyBCJ3MgcGFnZXMuDQo+DQo+IDQuIFByb2Nlc3MgQiByZXN0YXJ0cyBhbmQg
ZmluZHMgYWxsIGl0cyBwYWdlcyBoYXZlIGdvbmUgZnJvbSB0aGUgcGFnZSBjYWNoZSAuLi4NCj4N
Cj4gSW4gZWZmZWN0IHRoZSBzeXN0ZW0gc3BlbmRzIGFsbCBpdCdzIHRpbWUgcmVhZGluZyBwYWdl
cyBmcm9tIHRoZQ0KPiBTcXVhc2hmcyByb290IGZpbGVzeXN0ZW0sIGFuZCBkb2Vzbid0IGRvIGFu
eXRoaW5nIGVsc2UsIGFuZCBoZW5jZSBpdCBsb29rcw0KPiBsaWtlIGl0IGhhcyBodW5nLg0KPg0K
PiBUaGlzIGlzIG5vdCBhIGZhdWx0IHdpdGggU3F1YXNoZnMsIGFuZCBpdCB3aWxsIGhhcHBlbiB3
aXRoIGFueSBmaWxlc3lzdGVtDQo+IChleHQ0IGV0Yykgd2hlbiBzeXN0ZW0gbWVtb3J5IGlzIHRv
byBzbWFsbCB0byBjb250YWluIHRoZSB3b3JraW5nIHNldCBvZg0KPiBwYWdlcy4NCj4NCj4gTm93
LCB0byByZXBlYXQgd2hhdCBoYXMgY2F1c2VkIHRoaXMgaXMgdGhlIGRvd25sb2FkIG9mIHRoYXQg
ZnVsbEltYWdlLnh6DQo+IHdoaWNoIGhhcyBmaWxsZWQgbW9zdCBvZiB0aGUgcGFnZSBjYWNoZSAo
c3lzdGVtIFJBTSkuICBUbyBwcmV2ZW50IHRoYXQNCj4gZnJvbSBoYXBwZW5pbmcsIHRoZXJlIGFy
ZSB0d28gb2J2aW91cyBzb2x1dGlvbnM6DQo+DQo+IDEuIFNwbGl0IGZ1bGxJbWFnZS54eiBpbnRv
IHBpZWNlcyBhbmQgb25seSBkb3dubG9hZCBvbmUgcGllY2UgYXQgYSB0aW1lLiAgVGhpcw0KPiAg
ICB3aWxsIGF2b2lkIGZpbGxpbmcgdXAgdGhlIHBhZ2UgY2FjaGUgYW5kIHRoZSBzeXN0ZW0gdHJh
c2hpbmcuDQo+DQo+IDIuIEtpbGwgYWxsIHVubmVjZXNzYXJ5IGFwcGxpY2F0aW9ucyBhbmQgcHJv
Y2Vzc2VzIGJlZm9yZSBkb3dubG9hZGluZw0KPiAgICBmdWxsSW1hZ2UueHouICBJbiBkb2luZyB0
aGF0IHlvdSByZWR1Y2UgdGhlIHdvcmtpbmcgc2V0IHRvIFJBTSBhdmFpbGFibGUsDQo+ICAgIHdo
aWNoIHdpbGwgYWdhaW4gcHJldmVudCB0aHJhc2hpbmcuDQo+DQo+IEhvcGUgdGhhdCBoZWxwcy4N
Cj4NCj4gUGhpbGxpcA0KDQpZb3UgYXJlIGFic29sdXRlbHkgcmlnaHQsIGFib3ZlIHdhcyBsb3cg
UkFNIGR1ZSB0byBmaWxsaW5nIHRoZSB0bXBmcyBSQU0uDQpCdXQgd2hhdCB0aHJldyBtZSBvZmYg
d2FzIHRoYXQgSSBvYnNlcnZlZCB0aGUgc2FtZSB3aGVuIHN0cmVhbWluZyBYWiB0byAvZGV2L251
bGwuDQoNCkFmdGVyIHNvbSBkaWdnaW5nIEkgZm91bmQgd2h5LCBzb21lIFhaIG9wdGlvbnMgZG8g
bm90IHJlc3BlY3QgIi0wIiBwcmVzZXRzDQp3LnIudCBkaWN0IHNpemUgYW5kIHJlc2V0IGl0IGJh
Y2sgdG8gZGVmYXVsdC4gT25jZSBJIGNoYW5nZWQgZnJvbQ0KICAiLTAgLS1jaGVjaz1jcmMzMiAt
LWFybSAtLWx6bWEyPWxwPTIsbGM9MiINCnRvDQogICItMCAtLWNoZWNrPWNyYzMyIC0tbHptYTI9
ZGljdD0xMjhLaUIiDQpJIGdvdCBhIHN0YWJsZSBzeXN0ZW0uDQoNClBlcmhhcHMgeHogLWwgY291
bGQgYmUgaW1wcm92ZWQgdG8gaW5jbHVkZSBkaWN0IHNpemUgdG8gbWFrZSB0aGlzIG1vcmUgb2J2
aW91cz8NCg0KIEpvY2tlDQoNCg==

