Return-Path: <linux-fsdevel+bounces-30103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D12986349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE26289056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B307481B7;
	Wed, 25 Sep 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="foYBk0QU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020074.outbound.protection.outlook.com [52.101.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10762D600
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276609; cv=fail; b=gjQO3XK+xq/+XTEkE2Lcwqvm6LiO0QjWypGfBPR6NOLf7+USGDanVemSkOHPcYvLjzpLCF12qiIpLLNbDePC6W6zxQlkMQp9JUgygROhNHT9NOiGYmX/18T1XIg3ozyjAm2Rk7yIScllMvwcezEixLRiMi/OwTOylHEHIxlDo6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276609; c=relaxed/simple;
	bh=QXetdcIyxjP/UqjEDshepGreOf2ViXsjl9DC1MJMGC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sxsOM1Gp319VHBgXuM1hrS0aKL+ZuFIx2D+ehJpdzpHB41G73H+1sxJVJS3N79Re7o5UX5e5S7MUSaJQqKN8cLXRtuQxgFyppKMIeXkOUfUCvd9dY7dn8SSWVK4kFvbIP35+077KH1Sh6KUJ6BvtY9rwBwWEi40vFHsiyforqic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=foYBk0QU; arc=fail smtp.client-ip=52.101.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfNw4voSQP+/agXUqKeORgk/79FsZKR9uoVaVZO/rcZrEl4BfZ9/59D/0ARUwlBL2nj7vfdlvy+DsqZaKA7Lco56hJ44D6PDaV88qF2pTM8X9XCc0MM7k0tKx3klQ2UN6skcLi70K3W89v2RpA0SVUFsSTxNSTlZcuex+ek3kdgdDiU76OvdfGealLSrkEk+WwLJqijLtFmjLolFY+vIXhOtGm/LUqGzK0yft2CquY/VawSKeC/arYqXZJfmiy+OUn5S5ekybd0bvqLuHCXpoLW7v16lwIrZ6HNWuYMlyTR2hawBRJ3UeRoYEdSfuNDo4sT2ApQ5Nc5JSiIybJJGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXetdcIyxjP/UqjEDshepGreOf2ViXsjl9DC1MJMGC4=;
 b=Kauqr1ouwluNp8hEIlzMy3VPsHSvEegUTuRyPub+6+3hus9i8ywkCR6M3lGlIL8Dy9F2XB5G4NWETxIJKTuSGwrSyq2Wfy9gr4AknaiwojIwvHwGuAIRxmyGZa39kOeSoCwVak2xaPuP+BfW5GxqJ+ACu/pIGvUfDRlkwPPaVwvhe8ttlMTQ83fZvL+sGVcCkllba5z/iWB2sC3fNHx3jYAFt9kX+q7YKKn8pZRx59P3xZIT1TfS38qgfMYdzD/cYKhMt9TQYeB13K83W8SIy0znBcodKgHCJE2X0wyUlrXcR76o9Ab0LcMCsFm6GPPmLHxY3Bc+GhH7qIF1owdZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXetdcIyxjP/UqjEDshepGreOf2ViXsjl9DC1MJMGC4=;
 b=foYBk0QU/mwHrXBRKS8e21mlWQUo0Wq0AYRkpO38MBOukYZRlSnaiHj9Jv95AMpfbE82jdZeO4HfYVemKrNYvmRIueW6DX706/UV+rIRF8kZKrpmUfcVBrKhin/Uha9YSGmEaak3EyyY/TvYpKDn5avhfea2XqcAP4M53quMTSk=
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM (2603:1096:990:66::7) by
 SEZP153MB0694.APCP153.PROD.OUTLOOK.COM (2603:1096:101:91::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.8; Wed, 25 Sep 2024 15:03:22 +0000
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5]) by JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5%3]) with mapi id 15.20.8026.005; Wed, 25 Sep 2024
 15:03:22 +0000
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
 AdsMF7H2pA+A3TMFT7qIn4M6deqPigBk8OQAACP7Z1AACRNwgAABPHQwAAVRWhAAKioFAAAAOOwAAAVcZgAAAaOeAAAAm94AAAPF+pAAAR6dAAABZHsQ
Date: Wed, 25 Sep 2024 15:03:22 +0000
Message-ID:
 <JH0P153MB09997D6D26BC3F84968EB20FD4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
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
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f9eac978-0989-468e-9610-6e4fe7304481;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-25T14:55:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0P153MB0999:EE_|SEZP153MB0694:EE_
x-ms-office365-filtering-correlation-id: 061064cd-279c-4700-fcd1-08dcdd7332ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWxLRUNuRDNWaUcrRmJEaFZZdG5PZ1BxeGtVNlRQTGcxZ3BzNWYzamY5a1Y4?=
 =?utf-8?B?dTFnN1p2bzhUOHk4QS9pQkpFK05tSFpuSW1uRktNUEJ5N3c3MVNGZGZvSXlh?=
 =?utf-8?B?L1ZIVkU5MFFHYm9MQ1c2Y3lBR0MrZldDc21DK3J3OTFLK1hKdytOWjVOYmFs?=
 =?utf-8?B?UjlucmdkVWplblhZdTdkN2x3SVcyL3RiZU9tY2g2NWdqZ2ZhMFM5bW9zZXNH?=
 =?utf-8?B?TERWSWoxTGlIZUdlMlgrQU1WUWN1K0pacXgzZE5ZYVhQQmlJZm4zbHFpL1Jy?=
 =?utf-8?B?cmtPdzRaSlZENmRVc2VVWUsydy80L2Z6Ulp0YXJwN0grWWFyMEc1SFpHRDdT?=
 =?utf-8?B?b1Y2QmdITkt5emY2OFFxZWdkWTdYeDVMT3pFUnAwWVAyaWovdUZleUdmcy9T?=
 =?utf-8?B?NSs5eC9nS3RTckxqdGFCSHo4WnNFTlBRQmN6VWZYcW5vSnIzK3J4aTIwY1BU?=
 =?utf-8?B?N2RCSERISFdOOU1MTjMrQnEyK1I3VU5zcEU2Slc2Nm1nd3FqNUlzYmt6UWxH?=
 =?utf-8?B?aWg0QnV3SzRKbWl1cXRCemtCMVl3Qjc4MjhMb09FZmtTckFVQ3VvV2FRVDRD?=
 =?utf-8?B?TGJqYnpSU2hISUVEMnZPaWF2Q0hlMjdOd1BTRUprS0dDZzdwUmw3V1pBdHVH?=
 =?utf-8?B?Ylg3TVVKdFRabVlZRmtmNHFyV0Y3aEVMMitNdk1CcTF4TjJKRkorWjBBei9M?=
 =?utf-8?B?NktJT3lDN1NIalZ2MFppdVk5b2taMHZYSmpTQ3RULzdqS25zQUJpVXNqWmtZ?=
 =?utf-8?B?V1JTOG81bEVzNmxmWW9XRGdMZWtHT3VoenRJczJ5WHlINUZrL0d0QXZESWpV?=
 =?utf-8?B?bXBaWlhFUDUvQUJrMnpSWVJKc050NnhaRi9wRkQ2T1Z5aEIvOU5MNUxEU285?=
 =?utf-8?B?R0xoZlVzbHJGdHJLTE80N1EwSmNmL00rTnliejZodWwxTEhPY1lBbmprOWg5?=
 =?utf-8?B?czZaZDJ1QnNrOWwzRzJxQk9keGVBeURPOWhLdFNqU2VZLy96alpKZVM2M0Zk?=
 =?utf-8?B?S2ZoNVJMbmsvWmNEZnFrdkJCUlhRL3hNSDJmL2NJbFhYZ0pRbjhCTjdqK3N6?=
 =?utf-8?B?Qy9hNnUzalBIUEV1RWxOT0JZVTVORXRyVVExM0RaM2E4UTNMSDJQS2tUZDE5?=
 =?utf-8?B?c2h6ekpvcDNmTzZOdlZBekU5azBJY0F2NTVBOW1RUEl0V0R6dWtzT1JNQ2RN?=
 =?utf-8?B?czdvNkdDMEFiT0lrSGZxdTFBaFRjSXNwM2EyT2QvOFRzUDN1M1Q4QytVdjQv?=
 =?utf-8?B?bE9EVU56NTVNa0VhaHJuUjJMT05aajRqamZNV0ZXM01tcWo1RDlnaE5RREN5?=
 =?utf-8?B?SW9kek02Y1g2c3lnRjdtNy9ranUySkZMMlZXVTc3VG5GTkdZd2VLb0NTb1dO?=
 =?utf-8?B?V3RiWG94VGMveHhJZ0E5OFVXNVBKbEFoa25hOXJSK0RrQkNBcmhBVlJYTHBL?=
 =?utf-8?B?T0I1cjgxSndPbVlBeGtrTmRpdlg5ejNXdGF1WXBtdmZ4U0V5RzVHdmNBekRU?=
 =?utf-8?B?OVJBRWFTUFllUEcxblVWNHppcUZlSkNVdlM2ZFJuaGJIUmtpb0ZkK3BVZG1D?=
 =?utf-8?B?RVNPRlJJVkdOdzA2YVYwY0UxWENTc2JWd0RjMmJ1eUxCZTJlUTlZdjc3OWVM?=
 =?utf-8?B?VzFucXNQOENoa0xNcGx5V3pxaWVTTVVjMU5nRCtHVjkrV1I4RUFtYThyWGI2?=
 =?utf-8?B?NzF6RjlBSy84d25xc1Vkd1N0ZWdocnNDM2dsSjl0Rk1DNXlWY3dhT1BFSmxw?=
 =?utf-8?B?SXppa01OTlVDVDk4azhRajZoTXY0M0dDczQ3UUNYbVI2QUpxVG8rTFIxZkpC?=
 =?utf-8?B?MXdqKzZza1h0UFJnV1o2UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0P153MB0999.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anZqTHZ5VXJMT2s0Um9UMklOM0gxTXBqUXZQbjArYUVKWnVlT0xuWnBiOGRL?=
 =?utf-8?B?bVQwR0FCTk5PUDM4bmZGWk9Mdk1IZ2dMVmZDRms5NnFZY240UmhzOVp2akd4?=
 =?utf-8?B?Y0tjWERGV0IweUJKelpjZml3WDFPZmtiWkd6TzNnT2NoL0pCL0wrSWNjcjFF?=
 =?utf-8?B?QXpHdDByM1BWZUNqcEViQ1duRDVPbkVNLzdGVjBiMk45eVpXMno5MHczbVZk?=
 =?utf-8?B?RUpaK2JJcFU5NkF6SExvTEI3OWRTZmUxUDluN0xnMUpLbGZBNkJra003UGpj?=
 =?utf-8?B?d0VCV2FNZGhwTUtSS2tnYUI2anR1NUFNSlhoTnBvYjFVbXQ4MUN4dFpYSDhT?=
 =?utf-8?B?TG1DTDdNM3RGWW11eVBZZmZwQ2UwL3V2dUxYczF6VUl5aHpzek9PVXRwWlpt?=
 =?utf-8?B?M0F3N0x0djVWK3FzRVAycEYyUUQ3eTNIS2Y2UjcyZEtKTTAwdURrNEhmRGxC?=
 =?utf-8?B?RndFTXdqVXF6OExwa3d1S09Ld3h4Z0M3cWRPMlduUzNoRVJ1OW5lOWVERE5Y?=
 =?utf-8?B?bEtKbFpnYXhhMFJxdHMzdlU3SVY0Wi9lek9NUC82ZGpqeHVaTUVtT0RDTENT?=
 =?utf-8?B?UFRaSS9rcEpLZDZKSTl1K0JWUFZSbTVOdVo2NHljTjhLVGNLQWRoM0FCb0lL?=
 =?utf-8?B?VTJqOWM3WjEyQjhXbVBEL1JJaWVZSDBnM0ltNkV6THorNnZvcnRuVjRBWXdV?=
 =?utf-8?B?RThwa1lpbWgvVk1qOXBOSzJXNms0UjRlSnFqcEZDVnA3ekV1OWpXTEZuWDBu?=
 =?utf-8?B?bEg3bW01cm12bXBHb3Z4Nmd4K1NZSG93L2lSVG9md0RheXlvTzltUG15K3ZB?=
 =?utf-8?B?Mkc4djNZOVFUR1ZHRkpLNDJramxFVlh5bStqVEsxV3M2RVliMFFwUS9xckVL?=
 =?utf-8?B?UExlR29ndHBuYWJCRm1QVHBSaFArc0JzcHZsTWNka1pKdjJ3RVowOWszZjRh?=
 =?utf-8?B?eFhwbk0vSWkyNndmbDFzWXpzUHVsVjJPK3RrRDhpK0l6azJSNEQyd1k0TFpo?=
 =?utf-8?B?K2FiMzVYemRSQ2YyUFpFeHhpMm1ySmFNRGVsOGIzWHJQNTU3UW4rNWo2dFFX?=
 =?utf-8?B?Syt5QzQ4RkwrTmhEWkw3NWdvS3Q1eit1SnhNTXE0bVErU3hZc1VhR0xVUDli?=
 =?utf-8?B?S0NOUnJhKy9TdTArdkEzNzdjbXc1eUMrMVRDdnNPWkhMa1QvYkJOcVVBMzFH?=
 =?utf-8?B?TVNsdENLRmZSRFRGZTJpZ0ZMelZIUVorQys3NzBzVTRkWXl4akc3TENISVlw?=
 =?utf-8?B?Z1A5QmQ2NElaKzBEMnU5TjliQXZRN2lOd1ZpQVR4dDdSY0diVGZPY2daajIv?=
 =?utf-8?B?c0RBOTFHaXBLZmhQVnlDL2Z2b0xmYTRTaU4vUTFvVUdUTy9kRDFDcC9UZEIz?=
 =?utf-8?B?NDJ1R1VFeXBoVTBhNUJRRW43ZktRcGN4S3BkSFJSQkw1NnpMbng4ZDJ3YkVV?=
 =?utf-8?B?L2xoc29EajZnYXVrbXBMUXRWVWRrdmZoUTM4TUNRTjVCVVFxc0N5dTFFL25W?=
 =?utf-8?B?YXlDZTRWaTMvZkUyWFhIVnU1Ukp3YzVpeGF0QzY5Y1RPZlZpUXhVbmk1K2Rh?=
 =?utf-8?B?Snd6RDEwRkdyclJSWGRXYXA1ZjZ3Q1NUZ3Z6VkZ0R09XVkdJV3hBeHZwTWFZ?=
 =?utf-8?B?RitHalJRTUFXYkRMd1pDN2FFekRzZzRFdStwakVuVFp1NW1QcGdMR29iY1Az?=
 =?utf-8?B?L2NqQmhmZ0xGMkQzMEdyUi8zdmtaZzFiZVcwREUyYXhGRWFSSUtkWENnb1B6?=
 =?utf-8?B?WWljNnhITDNxZGREKytodklzRktNMVVDQjFmL09Jd3pKY2JOYnR5NGZVZzRF?=
 =?utf-8?B?U3MyZTkyd3JwYmh1YmR2WXlGZWRJNjZGZ2YwNXJuc3JicjVza0VqTnRhVW5j?=
 =?utf-8?B?TDNZMmFSM3o5L3BGOWloNG9lSVFzMUlJUlRlbVY4L3kwczl5bmJzVUF1NStV?=
 =?utf-8?B?cGxwL2JuYXl1R0llb0tmanNhSjFIdTFDMEJXVUZSSUtCNEtGRGVyWDd6Z2tK?=
 =?utf-8?Q?3fQcyMEhf8EAo8Dxb2gpVx2y+z8zG8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 061064cd-279c-4700-fcd1-08dcdd7332ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 15:03:22.4682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJTxrhBPdSOSfUlK6h2M3BsWwerh2WzGD6k6WFDcqjX3Qsz1IO6qvFaxjmdD95cM+WVT9tOuksUkH1zGmhvcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0694

DQpPay4gSSBhbSBhbHNvIHVuYWJsZSB0byByZXBybyB0aGUgcmVuYW1lIHByb2dyYW0gd2l0aCBm
YW5vdGlmeSBleGFtcGxlIChqdXN0IEZBTl9DTE9TRV9XUklURSkgb24gYSBwOSBtb3VudCBwb2lu
dC4gSnVzdCB3b25kZXJpbmcgaWYgeW91IGNvdWxkIHRyeSBnaXQgY2xvbmUgb3BlcmF0aW9uIGFu
ZCBjYW4gc2hhcmUgdGhlIHJlc3VsdHMuIFRoaXMgY2FuIGlzb2xhdGUgYW5kIGRlZmluZSB0aGUg
aXNzdWUgcHJlY2lzZWx5Lg0KDQpUaGUgcHJldmlvdXMgcmVuYW1lIHRyaWFsIHdoaWNoIGZhaWxl
ZCB5ZXN0ZXJkYXkgd2FzIHRyaWVkIG9uIGEgc3lzdGVtIHdoZXJlIGZhbm90aWZ5IHdhcyBpbml0
aWFsaXplZCBieSBNREUgc29mdHdhcmUgYW5kIHRoZSByZXN1bHRzIHNoYXJlZCB3ZXJlIG9mIHRo
ZSBzYW1lLiBBcG9sb2dpZXMgZm9yIHRoZSBjb25mdXNpb24uDQoNClRoYW5rIHlvdSwNCktyaXNo
bmEgVml2ZWsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFtaXIgR29sZHN0
ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQpTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNSwg
MjAyNCA3OjQ2IFBNDQpUbzogS3Jpc2huYSBWaXZlayBWaXR0YSA8a3ZpdHRhQG1pY3Jvc29mdC5j
b20+DQpDYzogSmFuIEthcmEgPGphY2tAc3VzZS5jej47IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJu
ZWwub3JnOyBFcmljIFZhbiBIZW5zYmVyZ2VuIDxlcmljdmhAa2VybmVsLm9yZz47IExhdGNoZXNh
ciBJb25rb3YgPGx1Y2hvQGlvbmtvdi5uZXQ+OyBEb21pbmlxdWUgTWFydGluZXQgPGFzbWFkZXVz
QGNvZGV3cmVjay5vcmc+OyB2OWZzQGxpc3RzLmxpbnV4LmRldg0KU3ViamVjdDogUmU6IFtFWFRF
Uk5BTF0gUmU6IEdpdCBjbG9uZSBmYWlscyBpbiBwOSBmaWxlIHN5c3RlbSBtYXJrZWQgd2l0aCBG
QU5PVElGWQ0KDQpPbiBXZWQsIFNlcCAyNSwgMjAyNCBhdCA0OjA04oCvUE0gS3Jpc2huYSBWaXZl
ayBWaXR0YSA8a3ZpdHRhQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPg0KPiBIaSBBbWlyLCBKYW4g
S2FyYQ0KPg0KPiBUaGFua3MgZm9yIHRoZSByZXNwb25zZXMgc28gZmFyLiBBcHByZWNpYXRlZC4N
Cj4NCj4gSSBoYXZlIHRha2VuIHN0ZXAgYmFjaywgc3RhcnRlZCBhZnJlc2ggYW5kIHBlcmZvcm1l
ZCBhbm90aGVyIHRyaWFsIHVzaW5nIHRoZSBmYW5vdGlmeSBleGFtcGxlIHByb2dyYW0gaW4gYW5v
dGhlciBXU0wyIHNldHVwLg0KPg0KPiAxLikgVW5pbnN0YWxsZWQgTURFIHNvZnR3YXJlIGluIFdT
TCB3aGVyZSBGQU5PVElGWSB3YXMgaW5pdGlhbGl6ZWQgYW5kDQo+IHRoYXQgbWFya3MgdGhlIG1v
dW50IHBvaW50IHVzaW5nIG1hc2s6IEZBTl9DTE9TRV9XUklURSBvbmx5LiBFbnN1cmVkDQo+IG5v
IHBpZWNlcyBvZiBtb25pdG9yaW5nIHNvZnR3YXJlIGlzIHByZXNlbnQNCj4gMi4pIFJhbiB0aGUg
ZmFub3RpZnkgZXhhbXBsZSBwcm9ncmFtKHdpdGhvdXQgYW55IGNoYW5nZXMpIG9uIHA5IG1vdW50
IHBvaW50IGFuZCBwZXJmb3JtZWQgZ2l0IGNsb25lIG9uIGFub3RoZXIgc2Vzc2lvbi4gR2l0IGNs
b25lIHdhcyBzdWNjZXNzZnVsLiBUaGlzIHByb2dyYW0gd2FzIHVzaW5nIG1hc2sgRkFOX09QRU5f
UEVSTSBhbmQgRkFOX0NMT1NFX1dSSVRFLg0KPiAzLikgTW9kaWZpZWQgdGhlIGZhbm90aWZ5IGV4
YW1wbGUgcHJvZ3JhbSB0byBtYXJrIHRoZSBtb3VudCBwb2ludCB1c2luZyBtYXNrIEZBTl9DTE9T
RV9XUklURSBvbmx5LiBSYW4gdGhlIGdpdCBjbG9uZS4gVGhlIG9wZXJhdGlvbiBmYWlscy4NCg0K
SSByYW4gdGhlIHJlbmFtZV90cnkgcmVwcm9kdWNlciBvbmx5IHdpdGggRkFOX0NMT1NFX1dSSVRF
IGV2ZW50cyB3YXRjaGVkIGFuZCBjb3VsZCBub3QgcmVwcm9kdWNlLg0KDQo+DQo+IElzIGl0IHNv
bWV0aGluZyB0byBkbyB3aXRoIG1hc2sgPw0KPg0KPiBJIGRpZG4ndCBnZXQgYSBjaGFuY2UgdG8g
cnVuIG9uIHN0YW5kYXJkIGxpbnV4IGtlcm5lbC4gQ2FuIHlvdSBzaGFyZQ0KPiB0aGUgY29tbWFu
ZHMgdG8gZG8gc28gb2YgbW91bnRpbmcgOXAgb24gc3RhbmRhcmQgbGludXgNCj4NCg0KWW91J2Qg
bmVlZCBzb21lIDlwIHNlcnZlci4NCkkgYW0gdXNpbmcgdGhlIDlwIG1vdW50IGluIHRoZSBrdm0g
dGVzdCBib3ggdGhhdCB5b3UgY2FuIGRvd25sb2FkIGZyb206DQoNCmh0dHBzOi8vZ2l0aHViLmNv
bS90eXRzby94ZnN0ZXN0cy1ibGQvYmxvYi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9rdm0tcXVpY2tz
dGFydC5tZA0KDQpUaGFua3MsDQpBbWlyLg0K

