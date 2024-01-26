Return-Path: <linux-fsdevel+bounces-9036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA683D402
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 06:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355701F23EF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A5BBE4C;
	Fri, 26 Jan 2024 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Rzl09a78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C4BA33
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706247843; cv=fail; b=i97bWQROPUInVj5WNp/2wwwfgUYaq7KUGl5lbsoTab6F1TA+SlqdnmUrSWcrf7O45EoVB5ZMY1JnQEstNs2eZaxQ95EoMqRbXhjXdVMKwTz+Cv7ZIngyw0O2B68qXP0fxLp5jbs+B3hmTJu6YwaeOY4simc2COasRhQnofRGXks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706247843; c=relaxed/simple;
	bh=wL+oJ6ETQFCKQR01uG7ufWyM4xlU4zC7d/I1D06lw70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kGZU3L30x7C8kf+9Mx5sFSmnfEN0dFrngFrFUq59D2axpggmXuV3p0xYWrp99M1jIGbtKWGfcOZkzEP+37b4albZduo9wvAPl/sugPNZA5goVndXA4xS+KjFuy5Xmhkab7yWL47qIWKyVpcZa+l+b8l2kwc76VyNvz7xSZMzkSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Rzl09a78; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PMjKD0007164;
	Fri, 26 Jan 2024 05:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=wL+oJ6ETQFCKQR01uG7ufWyM4xlU4zC7d/I1D06lw70=;
 b=Rzl09a78wvceiOq2JgsknrmJJ5nybh09h9OFCg/HV6gUjJ6ElxSVt0MPTMRLhWKHDygQ
 F643Te0n1xtXetjHCaacNyLbjZZdKfRIIPAYxgojW/tQ5IKJMi5TdgyqfhMjcreGyRv9
 W9OmVTPpHP1CNP93UzPb7lBA+oflRV8djwGauGLhWA0lIqxdn7DZmcSvChUiepJrfB8n
 6irdn8cCvI8/oLX7eNAn1XvV+WuXoYA2xYOBGJToniQSP6TCWrWD7fyy/V5tNBCsXp+a
 cmYBeR5mOX58qiexILwu+YaObyKL5Ys7rW3f8+5eF8dfpCCUEjP2TN9bhxKn2HmDHMds VQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vrbje6dac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 05:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avJ4SiQ8m/y2nH777Z2nWgxngC+J67rn/NiSEG/etuxQ+sKNLaCR37nuLLHYqqg8A5gfax8cyfzFTVsQxPiJV+VPfdPFTF+RQgRQrIISDcsnzQF1M4uKcsFXMtsb9ZXHaOqVuQ887TJs9kiK8e3JvRzZril9/VzwCpcCcbSlmoj+cULKJJj97r46uSoH4F2fqB8/skdMN7MJ+ilPu6MkPbRY1pmtLE+y+1iZuC1jWcauOfyXLB3roJvVasKuX3YOFZAGqJpyagemJlXAHWOW5zFmRnovkx8wu7DE9rzOgk7x+jrks+GItzYQfpoL8FJCDwSklmYpdGt3dsbwTI59fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL+oJ6ETQFCKQR01uG7ufWyM4xlU4zC7d/I1D06lw70=;
 b=kj+cSyKZGSVnOeNnGS45qSdu3IjkgJYCxbJ74DDmntRyUUyNYYTJ5yr6EI2LtLbyBw33uWurqgeknK5yHGsIynlCLDnoRU3FLPiBkCDBaGtnX+unR1PRC5bWeShwg1QXJQyIolWmQEX1dYGg1Y+YuyumpWwL7ykMlGzBBweDs68zrafxs23IL7SwyJeEYNQuxZ++FVSI1m+7svV/wtlGxn6Z+c6q/kkz0RhVo/u08URn82eDYGuuaoDHXgLFIzfs/+6tuEjKSQQffFYKNH94kHp8X2ur/nDlSseYq3+R/kFHOF/kD2nNefGmUrshnmjBgebOXh7PxUkTUz77T7+b9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB8351.apcprd04.prod.outlook.com (2603:1096:990:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.40; Fri, 26 Jan
 2024 05:43:19 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 05:43:19 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Thread-Topic: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Thread-Index: AdpN3FSy7vLvoUe1T5GfQPH9ulVGdwApZEFgAADSXYAABhDDoAAMIaSAAFMQwQA=
Date: Fri, 26 Jan 2024 05:43:19 +0000
Message-ID: 
 <PUZPR04MB6316E6B88D88BBEDC046394381792@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbEYd-JfKMTDN-Tv@casper.infradead.org>
In-Reply-To: <ZbEYd-JfKMTDN-Tv@casper.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB8351:EE_
x-ms-office365-filtering-correlation-id: 8fe7925b-d7b4-4479-eb1f-08dc1e31b37c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fm1QKQ1JSKU5JDqoTOqwpvfIAiE98woL1I3ejqefzlEd8BbL1nsiPLkN/OPGHmqECWLRIv442ymHtmyAmbPnfPlBwCwMb/Z8FZvT0I4FhmW1SZxkf1BMnOyWOBdo77yxnrnQIe6chQbxeP/Wq33vbMly8+lv4VtiyiMtXFiOCp9nQop4waWlBXD54N+W0Qss7xFK5dIstrbT20gSHLclURWADzLBIId8XrUeE+IUbr3u0ECMXC3e7xxYa2hQYM/VOG3kSNXilM1PZn0+w2VmFi550zXC8lT8ZBQG3SNA7wb3prR88VdR9kTKqqu+KXbw1JvnzonX88ZyejRCfFSi2Oz27xEpPuc9avH959/v0OYcz7NWLXuSvbrZgyb7q3lPxsvTZ7L+FDuDSEkXj7Xk67hUw7ZhJlw1rvSuOha5ryDnZyW+bygTpt1y501gWTnxw4TeVpmU4vtt5nqdSlruwD6rE8ok877/HsfztvNCe157DA7yFb8eU9YhemXdMOUnff3CMbn2Qls0YTX1fXboC4Mh/3p2ygafydisubSNM6VxPn/BbsxXoKWJ+divGw43ntlkG0EwqDGG0ZiO+Y3l4++bkc/FxqTEXmzFagdAiyEi/SlLIy4bfyg3SMSN5CZz
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(26005)(55016003)(38070700009)(478600001)(9686003)(82960400001)(7696005)(71200400001)(53546011)(83380400001)(6506007)(122000001)(38100700002)(76116006)(2906002)(5660300002)(66556008)(66946007)(66476007)(64756008)(66446008)(86362001)(8676002)(6916009)(316002)(52536014)(33656002)(8936002)(54906003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d2JxWVBpblVWaytndkZWOFlDTU84OG5WM3FVWGVqV3VpNVFaYjBSWGN6ak5M?=
 =?utf-8?B?ZGhJMCtEMC8rdlJtWGNtVmROTzlaSGE5dHkzOHhvMUVyNmlyVDlybkVhSFBu?=
 =?utf-8?B?TVdNcmE1U29zbk1ua3pDSTJXSVdhVmcwWVRuR1JidXYrUU9Rbm5hUUhDTVBW?=
 =?utf-8?B?U0ltN0d2Y2NiUk11NE1lL1dNc0tJUzkwUVVzYmNsY1VFS2ZWRTdJUnJHUW5t?=
 =?utf-8?B?RCtIMGxLeVVFYjQrUFc1ZWZyNy94VTJFb2FlcnVSRUVUY3BzRHU4ZldOMVQx?=
 =?utf-8?B?STh3OXhZd1NYcEsrbzd2aVNLMXEya3h1dElWcWl5MWxqTDNNMXd0SjZ6OUxw?=
 =?utf-8?B?Q0p3ZHU5cVRYVDRDckVFMkc3L0FXWVlQbDlZSnJtZFlybkIwbHhqaGdxL25N?=
 =?utf-8?B?TG8xcWptYTRIVUgwTGQyUUhNM1dmUGJtU2pzZmtGczA1VmRVbVJrYmtPb3hX?=
 =?utf-8?B?NDEyQ05zRjVzeUhmWnl2N2ZzVUtGS0xROHN3Q29DVDE5cWEvK3pSeUJBOUUw?=
 =?utf-8?B?YkhMTU9iQVZURzI3RlZpbWtlWSs1c084RDhWeWdYQzZOaVJUOTkzRGh0dUpp?=
 =?utf-8?B?S0sxS2kvR1U3ZGtCUDQ2aDFQR0dJL1lubDF4eFNSYzZPUXIwWkNoRzVLRzZT?=
 =?utf-8?B?UlhpUnhvZlRmRm5aMUhhZXpCV2I0dWFQbThXWnhIYVZpOCt3WG5GWVJ2Q1Na?=
 =?utf-8?B?dHdPbDcwaXMxRzRmdzNPd3EyRkRHSGcybUFnVUlwbWYvUSt1b0psT3RFYnoy?=
 =?utf-8?B?QStKcjFDaXcxYzJRdEVFaFVBR0JCemJqQ2VEZVJwU0FRSVY4MXFGTkpmY3Yz?=
 =?utf-8?B?RW5Yc2dJSUxObGl1RDNHL2NFOUNneis0ZDFUUktaUklDdzlDU0Z2ckYzTzA2?=
 =?utf-8?B?c3o1a1BUeW5WT3E3dm51a0hKTWhsU2theUhDZ2ZZR2NHb21OYzRONXZSMStX?=
 =?utf-8?B?WUo2QnNMaFNCaW5qdDhTaFZaODB0SkMyQmgvNUhOeUgxcTVNbS9aQWRTZW51?=
 =?utf-8?B?VnJDa0VkV2J6dHl2dmpRMGdXS01qSlRnMThpamxwMGJhK1pIYXlLNWhyVXhw?=
 =?utf-8?B?SkVHMmFPZjFmdlRlTTlwT2pEV2RseTZXcmtSTEM0V0tvVUtKdU1JRjZkd0Z0?=
 =?utf-8?B?Z0F0b1NKRytTSlRGbmo3Z0NtUSs4TkswTnBjakJ0NVl2TmJqblk2cUZ2Z0dI?=
 =?utf-8?B?TWhkdTBGd2ZBOGxaOFNPRUI4NXE5ZVJKVVRxT3M4endzbkFvdkV1cGNWemVj?=
 =?utf-8?B?Sk1hSm1XTkVqRjEwTktKaWJSZE01UjVBL2FMQjlJdlZLN2hWYVRjZ0krbVRC?=
 =?utf-8?B?T2tYNytPNU1QalpHUnBqaktqUVNUOFhUSkE5bVQ5V2Z0RWxJN3F3OVRzd3U3?=
 =?utf-8?B?eDZBVVNZQ2V3cnkrVWtQQjU4ZlJQN3JneXprMG1sZFI4YzQ2M0lxWmR5MlYx?=
 =?utf-8?B?VU1rUVN4MTA2RkJoMmlQN1l5dFVDRm5zZ3Q2eWhNUUM4S0FLM1Nzbm9aakMw?=
 =?utf-8?B?YzRhOENudFl6OWZqRDBHdXNqVHhXaGo1UFdTbVQwemRMSjh0enNYeXhsV3Jz?=
 =?utf-8?B?TlhDUmRpMEVNb2hKMEQreVcxeGd2N2ZCYk9wV1o2QlY3R3BwN2hmVDNtNnQy?=
 =?utf-8?B?VEN3cFF0N0QzR05hWTZRZCtuV0Fwb1RtbUYvVXdzTEthc1NsVmxWWkNENHVE?=
 =?utf-8?B?a0I1Sm1IVnRNaTFNb0RHNW13OVF6SVZwRUwxSEwreWFKb0VhdjVFUXZUR2RR?=
 =?utf-8?B?c0VsSzJwRlRTeGpjZGdLNDJyU0JONHcwZEYxbzJUNmJwdmwyQ2RrSTFKNWVa?=
 =?utf-8?B?UVhPdDRqM3huNlh6d09lVmZHdkJMb1YxMEJtZnpDeUdPNThiSTNFaVR4VTNu?=
 =?utf-8?B?QkY2cWF4MkVZZU8vK0RIaXhrQVI5Mmd1KytkKzJhV2RCcnFyUUJSSVdqNFFk?=
 =?utf-8?B?TmczTHR1WUNDSW5HVzJ3andYY0lzT2trd2JzMWJXL1VadlhEK0tYYmM1R29O?=
 =?utf-8?B?TkFwZ29BOHVtVWtUd1MyME5kdnpSMTd3cGtNaFJza1k3ZTVzV0J0MzNLd3R5?=
 =?utf-8?B?czFHRDVSb2EySGFVSzdqTUVxR3JmOVZyYU1oUjh2c3hhK2RySE9oYzMwOTBU?=
 =?utf-8?Q?univw86BBLGs6CODna+9LIaFT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	duwYefXcMgw6T60h+PsLkeAHLQ3E/IEmDPr5vEv1r4gyasFVRM9VNf7Br+G9ke6ny6gOlErzR4fxCi4jQx5q7sFAILldytJVRfzUQ8LnBGU5c+D++AgKpSL2PsvW4oHUoB23OSITDSMQh5YwS38/zzxViV70R9bRnFGDFM6LHIUrpGZFeITlwGfRxRiiuGuPFUfVBpGQMCuqiAeKgZ4jMi31J6ZyAw5SHZAocPfhQ7VwGF54kNyt+9OMjv8vtf1JAXslW30aZnnaDSSkMlhtVEsvho+r1rSF4h4bcvcduRo6XfhiIycsKPsR6Eh8HpgOdS4KuFSjCBr+w9j6aDoxu5LrPZC+0BM5KWxGN4iareKsrcbuJr1vQq44cGCpK9iycmKXiDLyK2inQLKgu91AO5x9XLIAS9GeXVhWF22lLc0X661R2PPkUs1UxcALWsfRUV06mN9szPo7AvDGNgMi3Bu9jp/HU2kpcMGiAoh7O1v8+9PPSE8hFoiJVnXbCWyOU/9Osc2r7aZywuwssii34C91bBL9bljT2W9r8zQOI0Dr2KTBR0o+v6vyZewroALme4Um4EQzZnxNHlzr/UhkV0LQ8AoU5dN38ciWoFSgW/+sc6BtBJ6mZfJXSUeqwHmB
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe7925b-d7b4-4479-eb1f-08dc1e31b37c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 05:43:19.3210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pySIIPj6L6tt6N2O/cKsoVnmmbxNw6CnxmKMAKH9DRn1pqWZkK9Q8tLE56azjGv9U01oo1S22vuRCl0w5F0XIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8351
X-Proofpoint-GUID: Ie9v70Q9ErMwItPRpojrcBbmztkcOyW1
X-Proofpoint-ORIG-GUID: Ie9v70Q9ErMwItPRpojrcBbmztkcOyW1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: Ie9v70Q9ErMwItPRpojrcBbmztkcOyW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02

PiBGcm9tOiBNYXR0aGV3IFdpbGNveCA8bWFpbHRvOndpbGx5QGluZnJhZGVhZC5vcmc+IA0KPiBT
ZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjQsIDIwMjQgMTA6MDMgUE0NCj4gVG86IE1vLCBZdWV6
aGFuZyA8bWFpbHRvOll1ZXpoYW5nLk1vQHNvbnkuY29tPg0KPiBDYzogbWFpbHRvOmxpbmtpbmpl
b25Aa2VybmVsLm9yZzsgbWFpbHRvOnNqMTU1Ny5zZW9Ac2Ftc3VuZy5jb207IG1haWx0bzpsaW51
eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBleGZhdDog
Zml4IGZpbGUgbm90IGxvY2tpbmcgd2hlbiB3cml0aW5nIHplcm9zIGluIGV4ZmF0X2ZpbGVfbW1h
cCgpDQo+IA0KPiA+ICgzKSB4ZnNfaW8gLXQgLWYgLWMgIm1tYXAgLXJ3IDAgMzA3MiIgLWMgICJt
d3JpdGUgLVMgMHg1YSAyMDQ4IDUxMiIgJGZpbGVuYW1lDQo+ID4gICAgICAoMy4xKSAibW1hcCAt
cncgMCAzMDcyIg0KPiA+ICAgICAgICAgICAgICAgLSAgd3JpdGUgemVyb3MgdG8gMTAyNH4zMDcx
DQo+ID4gICAgICAgICAgICAgICAtICAidmFsaWRfc2l6ZSIgaXMgY2hhbmdlZCB0byAzMDcyDQo+
ID4gICAgICAgICAgICAgICAtICJzaXplIiBpcyBzdGlsbCA0MDk2DQo+IA0KPiBUaGF0J3Mgbm90
IHdoYXQgdGhlIGNvZGUgc2F5cyB5b3UgZG8uICBJcyB0aGlzIGZyb20gYSB0cmFjZSBvciB3ZXJl
IHlvdQ0KPiBtYWtpbmcgdXAgYW4gZXhhbXBsZT8NCj4NCj4gICAgICAgbG9mZl90IHN0YXJ0ID0g
KChsb2ZmX3Qpdm1hLT52bV9wZ29mZiA8PCBQQUdFX1NISUZUKTsNCj4gICAgICBsb2ZmX3QgZW5k
ID0gbWluX3QobG9mZl90LCBpX3NpemVfcmVhZChpbm9kZSksDQo+ICAgICAgICAgICAgICAgICAg
ICAgICBzdGFydCArIHZtYS0+dm1fZW5kIC0gdm1hLT52bV9zdGFydCk7DQo+ICAgICAgICAgICAg
ICAgcmV0ID0gZXhmYXRfZmlsZV96ZXJvZWRfcmFuZ2UoZmlsZSwgZWktPnZhbGlkX3NpemUsIGVu
ZCk7DQo+IA0KPiB2bV9lbmQgLSB2bV9zdGFydCB3aWxsIGJlIDRrQiBiZWNhdXNlIExpbnV4IHJv
dW5kcyB0byBQQUdFX1NJWkUgZXZlbiBpZg0KPiB5b3UgYXNrIHRvIG1hcCAzMDcyIGJ5dGVzLg0K
DQpJIGp1c3QgZ2F2ZSBhbiBleGFtcGxlIHRvIGV4cGxhaW4gd2h5IHRoZXJlIGlzIGFuIG9wZXJh
dGlvbiBvZiB3cml0aW5nIHplcm9zIGluIGV4ZmF0X2ZpbGVfbW1hcCgpLg0KWWVzLCBpdCdzIGJl
dHRlciB0byBleHBsYWluIGl0IHdpdGggdHJhY2VkIGRhdGEsIHRoZSBkYXRhIGluIG15IGV4YW1w
bGUgY29uZnVzZXMgeW91Lg0KDQo+IFVwZGF0ZSAtPnZhbGlkX3NpemUgaW4gdGhlIHdyaXRlYmFj
ayBwYXRoLiAgSWYgSSdtIHJlYWRpbmcNCj4gZXhmYXRfZ2V0X2Jsb2NrKCkgY29ycmVjdGx5LCB5
b3UgYWxyZWFkeSBjb3JyZWN0bHkgemVybyBwYWdlcyBpbiB0aGUgcGFnZQ0KPiBjYWNoZSB0aGF0
IGFyZSByZWFkIGFmdGVyIC0+dmFsaWRfc2l6ZSwgc28gdGhlcmUgaXMgdmVyeSBsaXR0bGUgd29y
ayBmb3INCj4geW91IHRvIGRvLg0KDQpEbyB5b3UgbWVhbiB0byBtb3ZlIHVwZGF0ZSB2YWxpZF9z
aXplIHRvIC0+cGFnZV9ta3dyaXRlKCk/DQpJZiB5ZXMsIHdlIG5lZWQgdG8gY29uc2lkZXIgdGhp
cyBjYXNlLg0KDQooMSkgVGhlIGZpbGUgc2l6ZSBpcyAxMktCICgzIHBhZ2VzKSwgdmFsaWRfc2l6
ZSBpcyAwLg0KKDIpIG1tYXAgbWFwcyB0aGVzZSAzIHBhZ2VzLg0KKDMpIE9ubHkgdGhlIHNlY29u
ZCBwYWdlIGlzIHdyaXR0ZW4uDQooNCkgTmVlZCB0byBiZSBkb25lIGluIC0+cGFnZV9ta3dyaXRl
KCksDQogICAgICAgKDQuMSkgTWFyayB0aGUgc2Vjb25kIHBhZ2UgYXMgZGlydHkoQ3VycmVudGx5
IGltcGxlbWVudGVkIGluIGZpbGVtYXBfcGFnZV9ta3dyaXRlKCkpDQogICAgICAgKDQuMikgTWFy
ayB0aGUgZmlyc3QgcGFnZSBhcyBkaXJ0eShkbyBleHRyYSBpbiBleGZhdCkuDQogICAgICAgKDQu
MykgVXBkYXRlIHZhbGlkX3NpemUgdG8gdGhlIGVuZCBvZiB0aGUgc2Vjb25kIHBhZ2UoZG8gZXh0
cmEgaW4gZXhmYXQpLg0KDQpJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/IElmIHllcywgaG93
IHRvIGRvICg0LjIpPyBBcmUgdGhlcmUgZXhhbXBsZXMgb2YgdGhpcz8NCg0KPiBPaCEgIEkganVz
dCBmaWd1cmVkIG91dCB3aHkgeW91IHByb2JhYmx5IGRvIGl0IHRoaXMgd2F5Lg0KPiANCj4gKDEp
IHhmc19pbyAtdCAtZiAtYyAicHdyaXRlIC1TIDB4NTkgMCAxMDI0IiAkZmlsZW5hbWUNCj4gKDIp
IHhmc19pbyAtdCAtZiAtYyAidHJ1bmNhdGUgNFQiICRmaWxlbmFtZQ0KPiAoMykgeGZzX2lvIC10
IC1mIC1jICJtbWFwIC1ydyAzVCA0MDk2IiAtYyAgIm13cml0ZSAtUyAweDVhIDNUIDUxMiIgJGZp
bGVuYW1lDQo+IA0KPiBOb3cgKGF0IHdoYXRldmVyIHBvaW50IHlvdSdyZSBkZWxheWluZyB3cml0
aW5nIHplcm9lcyB0bykgeW91IGhhdmUgdG8NCj4gd3JpdGUgM1RCIG9mIHplcm9lcy4gDQoNCkZy
b20gdGhpcyBleGFtcGxlLCBpdCBzZWVtcyB0aGF0IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9u
IGlzIG5vdCBnb29kLg0KDQpJIHJlZmVycmVkIHRvIG1tYXAgY29kZSBvZiBudGZzMywgYW5kIG50
ZnMzIGFsc28gd3JpdGVzIHplcm9zIGluIC0+bW1hcC4NCklzIHRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uIGFjY2VwdGFibGUgYXMgYSB3b3JrYXJvdW5kPw0KDQo+IEFuZCBpdCdzIHByb2JhYmx5
IGJldHRlciB0byBkbyB0aGF0IGF0IG1tYXAgdGltZQ0KPiB0aGFuIGF0IHBhZ2UgZmF1bHQgdGlt
ZSwgc28geW91IGNhbiBzdGlsbCByZXR1cm4gYW4gZXJyb3IuICBJdCdzIGEgYml0DQo+IHdlaXJk
IHRvIHJldHVybiBFTk9TUEMgZnJvbSBtbWFwLCBidXQgaGVyZSB3ZSBhcmUuDQoNCmV4ZmF0X2Zp
bGVfemVyb2VkX3JhbmdlKCkgbmV2ZXIgcmV0dXJucyBOT1NQRUMsIGJlY2F1c2UgZXhmYXRfZmls
ZV96ZXJvZWRfcmFuZ2UoKQ0KZG9lc24ndCBjaGFuZ2UgdGhlIGZpbGUgc2l6ZShpLmUuIG5vdCBh
bGxvY2F0ZSBuZXcgY2x1c3RlcnMpLg0KDQo+IA0KPiBJdCdkIGJlIG5pY2UgdG8gaGF2ZSBhIGNv
bW1lbnQgdG8gZXhwbGFpbiB0aGlzLiAgQWxzbywgaXQgc2VlbXMgdG8gbWUNCj4gdGhhdCBJIGNh
biB3cml0ZSBhIHNjcmlwdCB0aGF0IGZsb29kcyB0aGUga2VybmVsIGxvZyB3aXRoOg0KPg0KPiAg
ICAgICAgICAgICAgICAgICAgICAgZXhmYXRfZXJyKGlub2RlLT5pX3NiLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAibW1hcDogZmFpbCB0byB6ZXJvIGZyb20gJWxsdSB0byAl
bGx1KCVkKSIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0LCBlbmQs
IHJldCk7DQo+DQo+IFRoYXQgZXJyb3IgbWVzc2FnZSBzaG91bGQgcHJvYmFibHkgYmUgdGFrZW4g
b3V0IGVudGlyZWx5IChtYXliZSB1c2UgYQ0KPiB0cmFjZXBvaW50IGlmIHlvdSByZWFsbHkgd2Fu
dCBzb21lIGtpbmQgb2YgbG9nZ2luZykuDQoNClRoZSBlcnJvciBtZXNzYWdlIGNhbiBiZSBzZWVu
IGRpcmVjdGx5IGJ5IGRldmVsb3BlcnMgZHVyaW5nIGRldmVsb3BtZW50Lg0KSG93IGFib3V0IHVz
ZSBwcl9lcnJfcmF0ZWxpbWl0ZWQoKSA/DQo=

