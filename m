Return-Path: <linux-fsdevel+bounces-44715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A21A6BBB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 14:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8677A5B62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAB822ACFA;
	Fri, 21 Mar 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="f7y/VX6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020135.outbound.protection.outlook.com [52.101.169.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2201F2BB5;
	Fri, 21 Mar 2025 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563587; cv=fail; b=p3R9PB7ezlMbfwFcRM/D4ktCxY4OE5jnCZ9ryoGHMkefQozbf8+cJmhJwfdGuE5OFrSU/LkERfVH7nkpoq5SQSrQ2PPEXIWZ1WWo0pe70ou1KXJ1tnCe9E473ggC2oeCXymcEKMOg7dcqTVCOC7ob+nNWHu9srnCK5CxlEhLJbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563587; c=relaxed/simple;
	bh=UJLMAeXlsm2fbR2t267fIIFxXS3pTyIyrmRyz22JLCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVhEsh1GD4WaNLwG8o9yaL3k/CCpjp4suBwpJHMYkaP0CsfbJPXDKsWu+aip24CCzuE6PxOKJ/nGidqcmRul2ZzH1LAFos8KIQDpIKqJ0glbrq49rsl79XR+DNHhOu5dJWDw0G3skJZXDf1kZBj1LPDxkf9gO+PSF2OfB32mf6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=f7y/VX6i; arc=fail smtp.client-ip=52.101.169.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUsyE+NY2MkDx+0yL4xJoM40jzNT8Iy0DiP9rr+pRRzH3nYhDz7QxRnbEWsPvduEafRHnL+ZStZUMoF2Fg8ohAa2bqs6niZUdtRtnX9huZspU8EzlK3k1RCOZ/Z0f+zP4Ei8M0YeQ0YM7iTWBxoFo2PWTbg//nxZvZDSrPXIxd10yz5ukOidX07/f4De5z1BZjlY8JPKdsTPnQ5mpJielgHkaoqvNfMCSulVfafRvloMZVULFiyRO8Nspckwm8qjWf8BhLUOJxN8kOMoc1SaRyTF3H2t6q/qikstvWwMK1yJrmaUh6KxHzuN3HtDh28Pq06+g5MkGVhuA4Zg6yrwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJLMAeXlsm2fbR2t267fIIFxXS3pTyIyrmRyz22JLCU=;
 b=UiO3fQRNxYchyWemNbEILzDJ/WKYYDhl7kCWqNlejBHAdZGVZCGogIZZ98wUSufpG1QxvSXclt0WlQH74/ZQ5dznUm2Fm+Pe6UCCSbJEOkJkF+viQQa/6pQ9zWh4AyiLSl93h+/P1ersmOMEbxFPFP6qY8FmEya2Thi9TASKlrz7mzYmUcUJJJYAZ4aJeTwa053kumRbDTxlYhraxeNtRzhw//kK2+HKzxyGTKIh1THb1uImuRkOM18GSYtpXI9buzq7MKe+asLCZOfGv5XbE7oiCO1WV6T+zOrtqjaHVDmLWWl2Yb8+s15sRu/Ch5JqarkH7O+H48fPfuKYkoir0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJLMAeXlsm2fbR2t267fIIFxXS3pTyIyrmRyz22JLCU=;
 b=f7y/VX6i6PNGwfZ8SJTkNKFUf9HFM44J+yKBN/WjnOlpX/Yb6lZfH1lxOgPC1YSL3mH/1jcxT3tqcdFJQUDnOTG55P0Sci0GglGihSiFjn6cRhPJO2OGzAZ5kg+2wxlr433KRMqAwZn9GWLzJCKmKv/Yz8spYXudRRHARysQVaoMWQeo/oOzpgVf2NWAnLtjjtGyOnR+3022Q6xV8Ze2lQoa1pgSaRX5TAIZouTr9o6hTa7RcskRijC8sq5DpXSQ65B91tNmC5P8VhEZKHpb+iYN/fK3b5brm3VfOqV87J8DaovbnlxEMsPTUgLt1mVds5QFnn4y+/6nabtt4pyfmw==
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::7) by
 FRYP281MB3185.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.36; Fri, 21 Mar 2025 13:26:22 +0000
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423]) by FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423%3]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:26:22 +0000
From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
To: "thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>
CC: "hch@lst.de" <hch@lst.de>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] initrd: support erofs as initrd
Thread-Topic: [PATCH] initrd: support erofs as initrd
Thread-Index: AQHbmc5FhigEqeqdAEenfkqes+M237N9UE2AgABFwYA=
Date: Fri, 21 Mar 2025 13:26:22 +0000
Message-ID:
 <aaae4d846c4f9bf2964af2a71c78f66c9a8c2533.camel@cyberus-technology.de>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
	 <20250321101029-8a3a1fea-223a-42c3-8528-a3239fb4b24e@linutronix.de>
In-Reply-To:
 <20250321101029-8a3a1fea-223a-42c3-8528-a3239fb4b24e@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2329:EE_|FRYP281MB3185:EE_
x-ms-office365-filtering-correlation-id: 948f71d4-c5f1-420d-4308-08dd687bf8cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elNJdEpYTnd3S1IwUzBmaitZaVpqRVJrdUZLWWVXSGhWaFdkV0hxRTlueE5k?=
 =?utf-8?B?akFnSnBZVWhlakJ1eUlSU3gxRWFrZG00SkUvNzdhZHdjZ20rdnk4WHpqQTdD?=
 =?utf-8?B?NUZ1N3N6VUVjd2RwWlEwNjd5eldPcUZ0UDBYTTA1YlV4bWcvK01jemV4TkhY?=
 =?utf-8?B?SFNyOURBYWFBWk9tTHQrMm1lZUVUWmd4dmNLY3R5eVU0Y1dvckxUQTg5Si9u?=
 =?utf-8?B?SkZPeUlpSVppQXhJVjFKYThsdFZCaTh6Ym83ZXpTUzBJUnFEMmJyUEtQcTRG?=
 =?utf-8?B?OFgxTkdEZkRTc3hVVmIwQ1VCUU4rZUpTVU9WdG5aS0VJc2ppemNDZmdTR1Vx?=
 =?utf-8?B?Q0ZBeDB6NndSUlZBUXNSTWRJaXlrTXV2SzV0MUxHaVlROW9SMnVZY0xhdmRH?=
 =?utf-8?B?b0E3TTkybUtieXZ5b1RZWW1IYXNZSHUrcnhuZzRRNzM2cHVucW93YUFJang2?=
 =?utf-8?B?d3U3VytXSkRYVzBERHlrcmtDZGNGaHRTS2xGSFc4S3JTc0RFakpJSm1obEYz?=
 =?utf-8?B?UUxnOG1XYmhSSEttbXU2OTQ5WGpCZmwzOHdGbE1zbUE1Rkd5ODlZSVpUZUtl?=
 =?utf-8?B?aVNhK2JuRjJscVY1ZGpGZThYcGYwenpjSkN6VWw2SnV2YzlsYlhNZkt6clVX?=
 =?utf-8?B?bXBlNFFFQzBibVFJT2dQQXJnRVBocTVHazFtcmZmS1Y1bUdTNDlrb3RTWmVI?=
 =?utf-8?B?QTR5cm1MaFBiY3RTOUd1bG1ZU1k2cU9MUHJsL05GRkxQYlJBMTZGZXRwbU9o?=
 =?utf-8?B?aDNKZ2t6c1MycXUwNm1iYzZUMGlzeU82djRCaHJGTkxjZlJvdmlYWUsvVzV6?=
 =?utf-8?B?VEpSUzNhZGMxYkpJL1N5UGMrdzh1ZWRMcjJCNUlBb2ZkVFNJaHgvNXZqcFdI?=
 =?utf-8?B?N2RXOUVrU3NTaVpLVG56anJ2VlJlQ1crUFdKWG1uYytFeFNVWkpNQ0hsaHJR?=
 =?utf-8?B?M0xZNHFGZE9HY1Zua3V4TkJydmV0MWpFZldVT0lEMnJReEh3Zytob3BIN0E4?=
 =?utf-8?B?Z0JCNVVyZ0tPc3ZxWnk1LzZaN1JLV0JSdmp6M3QxV1hBbXQ5UFhLNzBMRG5m?=
 =?utf-8?B?MG4zbmdoRjBRVU9naGZ3cUc5SUZhN1prSVM5M1lEZWlGNDg5NzVyTjlEeHpo?=
 =?utf-8?B?Y1FQR280VTVidTV0bXVEY3R4Q2xCKzlUVmxaQ0YzSlNoeldqUzVtT0twWlJ1?=
 =?utf-8?B?WU0yYmlmVWlhT053R2tsUGVBL0kzSXRyb3ZJeTFlWGxqdlczN0RjNzlrcE5N?=
 =?utf-8?B?YU5FOUdmbDBUalcvbDJzeTB1bUgydkZDSjI2NmpZRkQzc3FTZzZNUXZOMlF0?=
 =?utf-8?B?OHphTDdKM0lnbUcwQjkzOFVBajBodG1HVlord3FQTUEyc3FER1lyN2h5aXF1?=
 =?utf-8?B?eUlJZFpqQWR4THJlbEVKYlRDY3ZmQjNTaFd6bmM5c3J6eFd4d3YvZ0QvaWww?=
 =?utf-8?B?NlJ0amhZOW5HVUxTc05neDF1V3I1VExaQ1VZaUFjdTRnbVppQk8yM3NNNkxa?=
 =?utf-8?B?Umd1cys3WmZob25tMXRNVDFDenl4RzVXZ1JsSWVwalJQVm0yS3FWSDVxam1t?=
 =?utf-8?B?RTcyeEwvTDFrR21wUm5QOTRBY0hFK29ZaG00ZjhXbktXZ1U2ejlCazBCMitX?=
 =?utf-8?B?Q0JFMEE5NzRvbXh3b0hFN1B0NGt3elRlMkp5VFo2UlRpVW13QVhOQThRYSt4?=
 =?utf-8?B?M2JBUEQ1cFQzWWptOVo5K1g1WHZ5MS9qZjRZdnJVZUpESjBuZmI3c29XSk16?=
 =?utf-8?B?bGNXZ0puRjlneDZreGNQT0ZRQTFMMnBnOXp2NlA1Ti8zeWJ5WFpUa2RHSmJp?=
 =?utf-8?B?bWR1ZktOQ0xYRzNzUUIwaW5tNlphUTQrWUtUa3ZHWmszeGJzUU5KLzJ6RXhl?=
 =?utf-8?B?NVZpK21KV3RBVWZGZlQ3Z1dBd2o2MDRUVkc4ZUxCZERaMFk4b3pab1VJMmx3?=
 =?utf-8?B?NnNqaHFtWCtmb1RwL20rTk9aaGMyU1FXR2I3dUpGYk40eWk4MEpKQy9rVkJJ?=
 =?utf-8?B?d1pVZys4bjlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0RlSlg5UXdRRW43TFFuWTNTS3hWRklLNGN5bTlVcXhMMXRmdnF3TXZmdmhX?=
 =?utf-8?B?azFGUkQwTlFkTTBWVlRzOUFwUXNZWmsxSXVsbzFvQTdKUzRzbzEvcmRnUnpP?=
 =?utf-8?B?TmQzcVBzenZkbnNIVHBVb3Z6KzU1dnJaajdCK3YzUFFVcUhFZjBzR0hXUmJ6?=
 =?utf-8?B?d1ZIODJWR2hEdXJrY1BWcjhaM0l5YVNlN1Q5ZTQvdWZ5QURqVHB4R3NONnl0?=
 =?utf-8?B?TkhxQVJseHpsNGxlN1ZjaTRKcmFoc0pOZUN2Sk50aFU2UDBZTi8xMGVpbHZp?=
 =?utf-8?B?T0NqQm5Uc0x4bDRaTkFUTVVvVzhGWW15eXZRVWhvbm91SXJFTUZhaFlDYjhn?=
 =?utf-8?B?MGpra3BIUUtUUUpmMzhkRU44b2RROVhxV3ZidDBPMmFmRHdveFRIZWJqZ3ly?=
 =?utf-8?B?SDVlMDVMMW5YQXJNdEVENTlmN1J4U2FXRm5Zd1MxdGQxTjBiOTV4UGNGcGNX?=
 =?utf-8?B?ak0xWGk5NDRTNFE2Mmx6bWFtM0xLSWtYUTJMQ3N1OG9wQ2QyaFF4UlBtYURs?=
 =?utf-8?B?eEFiY3llbGxFUVoyaFlhUm4wKzlKbXdaQkl0RGpnYzJPWFpTM2pjTGlrUkZt?=
 =?utf-8?B?OG9TVkgyVnVUUW5xdzI2SzdueWZINi9oTFBiSFV3ZVVmeE5uMngxT2dzN21I?=
 =?utf-8?B?OTM1cHMxenRQTUVXc1NUWmswQXVXR0d0OXk3K3pPd1duSlZTVzBMNWlXMVhU?=
 =?utf-8?B?dE8rdWdudWlvVldMLzRxdVRnM0pZdHRpbVhGeCt2RWlqeHlsVnQvbGh2aHo5?=
 =?utf-8?B?cnlUNlo0QkpZRkdvZDlPTTZQcVhkd0c3aEpJdkFjN01UeEZBODFVZHptSXgr?=
 =?utf-8?B?ZmdWMHRaZ1dPZm1JOU5nU2crbXUvM1VQRnFUMU11SDZNSzdqRFhHbzlqMVNO?=
 =?utf-8?B?UzhkeVBRd1dlY0hqSFJKSjI1L0xuSGY5M0s1bG1Ib1NPMjJzRmRybnhJVDM3?=
 =?utf-8?B?S2VPR2VTd0VDK3hwRy8vbVlDN3NjNmd4UDdSOTFRUUNBWXlGYi8xWXBzTGQr?=
 =?utf-8?B?T0dCRXpJNjhMckJIV3VkRVhEQjJqYVNsUWRrN3BUUkpUWTZiekxXV2hOd0Vv?=
 =?utf-8?B?NmVDOHJsOVp5U3hNeEczNjFXMzgwN3ZNdytjY3JjZWlSamVTWG5zVisxYWtG?=
 =?utf-8?B?bmFxc2xJOW5DcWdBdGVudk90ZHVmZlkzb0s5SGFsbDJ2RnZEUUI4UFB4WXIw?=
 =?utf-8?B?UW1idGMxeG1UNVZaakdlSjhFVnhsQjJpRXJrM0picms3VFo3ZURSV0t0Z3Mr?=
 =?utf-8?B?VlNTZTR3SWh1UFcwYm5GWHpJRzZzN3RNaUppMUdpMlZSUThrKzNZRHZqL3hv?=
 =?utf-8?B?SnlyVXMrc0hoRkdtVGd6VzdIZDk0SWx4dWhEWlhkcEdSOU9ueTdjWkhpa1A2?=
 =?utf-8?B?bzNYM1hNN3ozTlRLVWdrT2daWUN1UjhBY1FtRkVFVWJieWVTUWttalZTenN5?=
 =?utf-8?B?ZkhGVzhLd3JrTWVYa090K0h0akJLa25LSkE0Ykh2MTJ6QzBPVjFhbzNZeG5C?=
 =?utf-8?B?NnQ2bGJuM0Q3K0VBcEhsbmRYUVlueFFHUldCNk5rYUpqTXpGWm9TTlE1Yk90?=
 =?utf-8?B?WHRIZ2MzUzVRc0tQbHN4ZnpVWnhabDl6cmRCRDhJU1VKN0k5SmFJTkd6N1No?=
 =?utf-8?B?OGhUdGlPT3V6UWRsWGs2enovNnhtWjk3MDZURjRiMVRWNGtmVVExa0NPZWlQ?=
 =?utf-8?B?eEdabjFKd1NLc09NODBPYlE2MkxBZU5BSW5uOFcyZ203NlhnMWxwQ1VHUTJk?=
 =?utf-8?B?RFlkemY1cy9RRmM0MnFubmNWK2ZBczh3SnZESE9ZaGZ0aXR1ZGdmQSs2SFZF?=
 =?utf-8?B?R0paNmpDaWl3cnVlNmpxWExSTE1uV3hkZmQxZnNUVklMUTRFZFlZVFdvUEtO?=
 =?utf-8?B?N1pFY2U2RytNSkk4eUM4TzNSSUs0Z3NvcWtmcERXUXlPbmFkTWY5cTJkNVBl?=
 =?utf-8?B?MWZmWkVITUhGZ2pIVmN6M2JqNERsakZVSmhqYmtYOFFVTG9rbzNzekhGUWZv?=
 =?utf-8?B?THJiMEVTeU04bjNvdWhrOG02ZXVSWmxVdm51aEpPUlE1UGpGT3hGb0hPSW9Z?=
 =?utf-8?B?Vk5PcEJWT2hZSmlyZHZ3T0NmTjJ4YjN0WlF4ZUdtWHJFWXhyK0cvemlUNkcw?=
 =?utf-8?B?MFl1REM1d3pzYjNFQnBFQm5FK2lwdWxMdnltN2oxOGNMOGNURUVPK3BXTTd5?=
 =?utf-8?Q?lt4hQM/wesVCaL8Ig8Hdfwi1vxPKd+j2A7/fb6JALOCv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <997038A999F64545BFA6240C82392B94@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 948f71d4-c5f1-420d-4308-08dd687bf8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 13:26:22.0808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDryQ+UiRHnL7HOy2h0mawXzVYvIr8YLo/1gmsC0vzdVuTy1ir3gdb07L+tJ3SPP7Idlx5X4KbI+j6TSuJvDA1lY+7i1eNoO36u/MVi6kFZXCFUuEoIqwOMO66NHlCtA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3185

T24gRnJpLCAyMDI1LTAzLTIxIGF0IDEwOjE2ICswMTAwLCBUaG9tYXMgV2Vpw59zY2h1aCB3cm90
ZToNCj4gT24gVGh1LCBNYXIgMjAsIDIwMjUgYXQgMDg6Mjg6MjNQTSArMDEwMCwgSnVsaWFuIFN0
ZWNrbGluYSB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+ID4gRnJvbTogSnVsaWFuIFN0ZWNrbGluYSA8
anVsaWFuLnN0ZWNrbGluYUBjeWJlcnVzLXRlY2hub2xvZ3kuZGU+DQo+ID4gDQo+ID4gQWRkIGVy
b2ZzIGRldGVjdGlvbiB0byB0aGUgaW5pdHJkIG1vdW50IGNvZGUuIFRoaXMgYWxsb3dzIHN5c3Rl
bXMgdG8NCj4gPiBib290IGZyb20gYW4gZXJvZnMtYmFzZWQgaW5pdHJkIGluIHRoZSBzYW1lIHdh
eSBhcyB0aGV5IGNhbiBib290IGZyb20NCj4gPiBhIHNxdWFzaGZzIGluaXRyZC4NCj4gPiANCj4g
PiBKdXN0IGFzIHNxdWFzaGZzIGluaXRyZHMsIGVyb2ZzIGltYWdlcyBhcyBpbml0cmRzIGFyZSBh
IGdvb2Qgb3B0aW9uDQo+ID4gZm9yIHN5c3RlbXMgdGhhdCBhcmUgbWVtb3J5LWNvbnN0cmFpbmVk
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEp1bGlhbiBTdGVja2xpbmEgPGp1bGlhbi5zdGVj
a2xpbmFAY3liZXJ1cy10ZWNobm9sb2d5LmRlPg0KPiA+IC0tLQ0KPiA+IMKgaW5pdC9kb19tb3Vu
dHNfcmQuYyB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2luaXQvZG9fbW91bnRzX3Jk
LmMgYi9pbml0L2RvX21vdW50c19yZC5jDQo+ID4gaW5kZXgNCj4gPiBhYzAyMWFlNmU2ZmE3OGM3
Yjc4MjhhNzhhYjJmYTNhZjM2MTFiZWYzLi43YzNmOGI0NWI1ZWQyZWVhM2M1MzRkN2YyZTY1NjA4
NTQyDQo+ID4gMDA5ZGY1IDEwMDY0NA0KPiA+IC0tLSBhL2luaXQvZG9fbW91bnRzX3JkLmMNCj4g
PiArKysgYi9pbml0L2RvX21vdW50c19yZC5jDQo+ID4gQEAgLTExLDYgKzExLDcgQEANCj4gPiDC
oA0KPiA+IMKgI2luY2x1ZGUgImRvX21vdW50cy5oIg0KPiA+IMKgI2luY2x1ZGUgIi4uL2ZzL3Nx
dWFzaGZzL3NxdWFzaGZzX2ZzLmgiDQo+ID4gKyNpbmNsdWRlICIuLi9mcy9lcm9mcy9lcm9mc19m
cy5oIg0KPiA+IMKgDQo+ID4gwqAjaW5jbHVkZSA8bGludXgvZGVjb21wcmVzcy9nZW5lcmljLmg+
DQo+ID4gwqANCj4gPiBAQCAtNDcsNiArNDgsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBjcmRfbG9h
ZChkZWNvbXByZXNzX2ZuIGRlY28pOw0KPiA+IMKgICogcm9tZnMNCj4gPiDCoCAqIGNyYW1mcw0K
PiA+IMKgICogc3F1YXNoZnMNCj4gPiArICogZXJvZnMNCj4gPiDCoCAqIGd6aXANCj4gPiDCoCAq
IGJ6aXAyDQo+ID4gwqAgKiBsem1hDQo+ID4gQEAgLTYzLDYgKzY1LDcgQEAgaWRlbnRpZnlfcmFt
ZGlza19pbWFnZShzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IHBvcywNCj4gPiDCoCBzdHJ1Y3Qg
cm9tZnNfc3VwZXJfYmxvY2sgKnJvbWZzYjsNCj4gPiDCoCBzdHJ1Y3QgY3JhbWZzX3N1cGVyICpj
cmFtZnNiOw0KPiA+IMKgIHN0cnVjdCBzcXVhc2hmc19zdXBlcl9ibG9jayAqc3F1YXNoZnNiOw0K
PiA+ICsgc3RydWN0IGVyb2ZzX3N1cGVyX2Jsb2NrICplcm9mc2I7DQo+ID4gwqAgaW50IG5ibG9j
a3MgPSAtMTsNCj4gPiDCoCB1bnNpZ25lZCBjaGFyICpidWY7DQo+ID4gwqAgY29uc3QgY2hhciAq
Y29tcHJlc3NfbmFtZTsNCj4gPiBAQCAtNzcsNiArODAsNyBAQCBpZGVudGlmeV9yYW1kaXNrX2lt
YWdlKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3QgcG9zLA0KPiA+IMKgIHJvbWZzYiA9IChzdHJ1
Y3Qgcm9tZnNfc3VwZXJfYmxvY2sgKikgYnVmOw0KPiA+IMKgIGNyYW1mc2IgPSAoc3RydWN0IGNy
YW1mc19zdXBlciAqKSBidWY7DQo+ID4gwqAgc3F1YXNoZnNiID0gKHN0cnVjdCBzcXVhc2hmc19z
dXBlcl9ibG9jayAqKSBidWY7DQo+ID4gKyBlcm9mc2IgPSAoc3RydWN0IGVyb2ZzX3N1cGVyX2Js
b2NrICopIGJ1ZjsNCj4gPiDCoCBtZW1zZXQoYnVmLCAweGU1LCBzaXplKTsNCj4gPiDCoA0KPiA+
IMKgIC8qDQo+ID4gQEAgLTE2NSw2ICsxNjksMjEgQEAgaWRlbnRpZnlfcmFtZGlza19pbWFnZShz
dHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IHBvcywNCj4gPiDCoCBnb3RvIGRvbmU7DQo+ID4gwqAg
fQ0KPiA+IMKgDQo+ID4gKyAvKiBUcnkgZXJvZnMgKi8NCj4gPiArIHBvcyA9IChzdGFydF9ibG9j
ayAqIEJMT0NLX1NJWkUpICsgRVJPRlNfU1VQRVJfT0ZGU0VUOw0KPiA+ICsga2VybmVsX3JlYWQo
ZmlsZSwgYnVmLCBzaXplLCAmcG9zKTsNCj4gPiArDQo+ID4gKyBpZiAoZXJvZnNiLT5tYWdpYyA9
PSBFUk9GU19TVVBFUl9NQUdJQ19WMSkgew0KPiANCj4gbGUzMl90b19jcHUoZXJvZnNiLT5tYWdp
YykNCj4gDQo+ID4gKyBwcmludGsoS0VSTl9OT1RJQ0UNCj4gPiArIMKgwqDCoMKgwqDCoCAiUkFN
RElTSzogZXJvZnMgZmlsZXN5c3RlbSBmb3VuZCBhdCBibG9jayAlZFxuIiwNCj4gPiArIMKgwqDC
oMKgwqDCoCBzdGFydF9ibG9jayk7DQo+ID4gKw0KPiA+ICsgbmJsb2NrcyA9ICgoZXJvZnNiLT5i
bG9ja3MgPDwgZXJvZnNiLT5ibGtzemJpdHMpICsgQkxPQ0tfU0laRSAtIDEpDQo+ID4gKyA+PiBC
TE9DS19TSVpFX0JJVFM7DQo+IA0KPiBsZTMyX3RvX2NwdShlcm9mc2ItPmJsb2NrcykNCj4gDQo+
ID4gKw0KPiA+ICsgZ290byBkb25lOw0KPiA+ICsgfQ0KPiA+ICsNCj4gPiDCoCBwcmludGsoS0VS
Tl9OT1RJQ0UNCj4gPiDCoCDCoMKgwqDCoMKgwqAgIlJBTURJU0s6IENvdWxkbid0IGZpbmQgdmFs
aWQgUkFNIGRpc2sgaW1hZ2Ugc3RhcnRpbmcgYXQgJWQuXG4iLA0KPiA+IMKgIMKgwqDCoMKgwqDC
oCBzdGFydF9ibG9jayk7DQo+ID4gDQo+IA0KPiBUaGlzIHNlZW1zIHRvIGJlIGJyb2tlbiBmb3Ig
Y3JhbWZzIGFuZCBtaW5peCwgdG9vLg0KDQpHcmVhdCBvYnNlcnZhdGlvbi4gV2lsbCBmaXghIA0K
DQpKdWxpYW4NCg==

