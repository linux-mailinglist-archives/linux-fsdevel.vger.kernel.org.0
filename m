Return-Path: <linux-fsdevel+bounces-14096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A7877A55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FF71C20F0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597C510795;
	Mon, 11 Mar 2024 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="PVaKXJSq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB62DF41
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131110; cv=fail; b=m7A1KB9h9Sgs6V0uiVO8syyQBVMI1H2fhsnK45c4jRvznFa74m96hTIsZT46S/YjSYwAfsI3Lt4w+pW3zRZXrL90j4pDqERcJpJwhrDN6ReonYSyYoGr01PupsSpkDEPGWAa7KJfgZD7d9iVCbZzrSz4mnYmfQVv6Tpbaq2rUdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131110; c=relaxed/simple;
	bh=pvo0EiKX8AgLZ9hQQsHQ4GWCXMQL+AEmjxDv2EL01gg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XLTV8b1sHU7FwNiiJDfNW5eKbPsCXjN2sO+sx18weHdj29Jqiv2d2Vc00RKF5gAIJu/c8wd2PjLIGtU4MCC8PrrLNy/G8jXan+sohUqaj6BLafmTbL5XmCg6Ec9sRHkYgHEkkMw0xvWwNUsZUQJDvwmgB9E6EY56slZUR+NQfz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=PVaKXJSq; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B0NPOi022127;
	Mon, 11 Mar 2024 04:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=pvo0EiKX8AgLZ9hQQsHQ4GWCXMQL+AEmjxDv2EL01gg=;
 b=PVaKXJSqfQBw/p5K4RZUSxa2IxSrlIfN0ELYqV7WmOMdk+/CpM1A0g2j6Di6Ok3AK6en
 FwJnfieoN2fWKrfrHyWaolEZ3R4qQlQbCGH3Gvj1lCnaxupbif84dvVnrSyuGzbDAuGC
 TR6vi7qJmMxeE6dwkh5c3sXaQcD+sjUY7eW+blcHQI0qA+0Crn4Z8090AXxlABNdwwSa
 jslDz7XbHRmHaYDVzoLdROb2utzVmYsnCuQCAQZ+E+pWy35kbx2FF3RNZtzfHqDiCfBU
 BUfHcelOO+E9o4ZuZIBv15FXUkLY3Q07HIFSbLlTqvJS/v7GHpBVtvTs4xDhCencOaYk bg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wreb6sdau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSEPTmvFoEZnE4uyuoogGC+dXPhAxnU39C/aQ4/vMAOysnLSDHVp6YcVvsssWv+vQ2+NErWVtU+Q0N1kFzEnJDWLGJaa9LKJ/fNnpTT7rMxxED3Dws+UolyVQc60dBHHQemooFA55nNXr4COL6Lz8FzzvQHDpRP/SmmnyGqaNs4/mzpCcQ6VfvNrvlfzEXwG3tQ7ohyZKNozmDu7R5LyJkQZ7v50w7uczW5cWvtBnJtttC9pMn1e00r6k68eiZw3cqknZQ2EEuE1vrXUHUwdevAWIIfk4DfniRHKPg9bv7zW34yCLRhQD2Fv2JcZaQo+kXmELCzREne8jYSycahAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvo0EiKX8AgLZ9hQQsHQ4GWCXMQL+AEmjxDv2EL01gg=;
 b=SEvbv+mvlLu61WJUFYIqIY1O3DTCAVoihZ/SsxYdHR7g058CgxgWj8GlmUKjF8PihM7uUBOlwP4+wZOkQ90zqqraymnnxlQLr5CkTlKWoZ7+IIqB7yRRZ2+m+F+AJS8LfTSSVX7xgfDd5Bq7TMXZBDBsdXbecMUarPtM+onIOeFwIOYDsGI+NUl7+qxVBXzMJTg658bm3dk605cU/YdAYM97Xx/QbU0gm2rVDPqQ/SYaE2cMsgOd6ZcLaQgx4/SsixdwDZ4Vs38FnBEsxTgp/dAR4HscmN+rXi9/w7ntLDC+EvjYRgx5GILK85Fx/J24WYkFCnJzORnmkx8AQHfgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by SEYPR04MB7362.apcprd04.prod.outlook.com (2603:1096:101:1a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 04:24:46 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:24:46 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 01/10] exfat: add __exfat_get_dentry_set() helper
Thread-Topic: [PATCH v3 01/10] exfat: add __exfat_get_dentry_set() helper
Thread-Index: AdopyBE5MTMUlvobQIejoYD2xnrYkRJoXQdw
Date: Mon, 11 Mar 2024 04:24:46 +0000
Message-ID: 
 <TY0PR04MB6328DF26DFDA701A810229C081242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|SEYPR04MB7362:EE_
x-ms-office365-filtering-correlation-id: a5e50f92-64b2-4768-dac8-08dc41832f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /wa1M7WsDBC5bX4ftJi9HBYECD/abQ6fLlBjj7Sp+weKbXA5vEiedxw1BbGZmGjyZEHEB47OpGR4254Oyam9kHYVqELz8OQOVT1fMbM5MNr+SOURsf8fB4Rhtb28vIke+l/gZMyQMPX3843E4LMfJA0c2asgSrT8DIlo1gLC9bObkEwdEHPG4HL+PTlg1JRkphByEMwiQroKkSSThypc1S2YJgy7jfuKAbMejt/nr+OjwmdjHJYfolxtHBbtKMhZUEFFSg0xdvp585RXnMgQngIgXcUixRagsuBbvuHTbLWpm5gzPaz8gmu940K7he2VKk3UK496gjw6Rn84ObDt5TiJ8zJc5cyhXieNbjAO1KTY0X8/SmyMe+gpYyoGSgSTOsrKmlFSZZso8l928AxFJVBqQaXfegC6gylsPM8mbajZNailOwlmtlIyF1lSPWUkc5BAH77OA8Y6h0NPS4vVExgzvitFiAHfL77zr7O3BQJcDuhxuKUOOXJGw00LXHnQJjtaTFNH+bZmyBoCHVMYOMwtlLagWTZdO4r+flKgFzx/WdHJ4J+8MZzxgdMACwIz7jO2u3LibwPtErmZlL2gTZqnQhj/KXr0LZPMUvllqjsAwnTzpeXnFx23MWCNy4VMAA4oWvJgLRckylvk99mX7C1MH5w79+M6wvSDrK31RpWzPqxNLT0CSwvwvE5dIrhk0UQCJiKruYqV+VaWY5v3665I2XA69d57KVOE6jtOTBg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SnFVZUN0ZzlaNXVXQlFyUEtlL1ZGMU1MemljMWFabzM3K2dLUkJIRVExQm93?=
 =?utf-8?B?T1UvYW5DZ1NEM0tSNzI0ZXFXeE1TRjJ0bjFLbFhvZVJHODgyZ2dSdWNIdHJC?=
 =?utf-8?B?ZFR5eGhaYTMvakVKQTRkZ1RtTlZpenl4MUhuSkFsbHlTVUNBSHQ3OGRnKzEr?=
 =?utf-8?B?Smx1RkxxVDEyZHB3b25hS00rNkF2NEpUOVMwVm1RMG1BZTh3dWZHSFc1TWdz?=
 =?utf-8?B?UTNTWXU1SVJhRDBrbUMyc3EvT1pGQXJFc2ZiRTRuaTZOVC9pczE4Zk05eDk4?=
 =?utf-8?B?Szl2dktBdVZra3BaVnFQYndZZm9OSFhHT2lybG5vSWowTkZqemdlaGpZOFkv?=
 =?utf-8?B?a0tpYVV4NVltY1M5TXdPemdLTEZKSzIvTjBxTEF0VWJ6VzczSUR0bDgyQjRs?=
 =?utf-8?B?WUdTRFE0bTVlVWRTZDRzUVE5WnZubzgvS0hUY2IxRE5CY1VFV3hNcXZUcFFS?=
 =?utf-8?B?Uks3TlhFRlBVMHRVOFk1d2RESkF3REtFWlAyaDV2alZnZnYzdTNBajUzbm9w?=
 =?utf-8?B?Y0UrOG5MRTZUdG96NDhVSzc1Rm0vYzcxRjVaaS95S29pT0hTa0lhNXlMM3RF?=
 =?utf-8?B?dmloa0tVelFrMHZvdkdJTmFYU05IT3lkOUtuNWMrT1NidnljUDlIVmdraWJl?=
 =?utf-8?B?TkJiY0NXUGk1MmUvR1RTMjg1NTNRbWRkeFkzVWk4VGRCc2RxbE1NMHZYbTQ4?=
 =?utf-8?B?NEpyMXlkQTRBRU9NcTkzZTNFRHpDQ29jai8yUXpDaVIrT3J1NGd5M1dRSFRV?=
 =?utf-8?B?b3BQTTlYYmV4T05DSTZ4eWVVVk84d2MzMkhJRC91eHY2dis2S2ZZaVZoUXpx?=
 =?utf-8?B?b2ZGZncwN0hzS1UyTWFNZ0dmWDUrRGRxU1UreVpsNUFsbGNvZzd3Ym1aS3R3?=
 =?utf-8?B?S1J6T2ZteWhib3RRMXl4aGtlRVJKbEpGTEdldTNJL2JTeUw3QU5Tam5yaSs0?=
 =?utf-8?B?ZkN2RVRzaTVDcGQ1QUREY3F4dXB1UnptYjA1b2lqSGlQdVhRb2VhRTU5a0c4?=
 =?utf-8?B?TUVoM240VTBVdjZpTkhiR1N6eXRTV3hYemE1dHNXdTJYM1FHZ1diWEhLVzZ3?=
 =?utf-8?B?eEJiLzV6ODBhWTVvL05HK3MzaGxOaG03R0YyOG1PWE93Ymw4d05GMTZGdkJP?=
 =?utf-8?B?amZhdGtPWGs3aEtmV2d1TUJrdmcza1EyUUx3VWg0Nm8zbHUxeSt3Wm5SanVZ?=
 =?utf-8?B?ZmRTdExZK0tjbHBxMXJLdjM1RDhBK2hvVUV3MXZ3S1BsZTVMbkVRVGVGc2Zn?=
 =?utf-8?B?elBsTE1YWkVKZ1lxMlhvY3c3TjB2MnZYemIrY0g0WWgzMko4L2hUamp0TXVi?=
 =?utf-8?B?YUd6cUlnN1VTS2NxbWpaOG9KbGNPOVU5bXVvWWh6c1NvbjlwTVhvSW9BbXNy?=
 =?utf-8?B?d2dTR1V2TCtsL2NFcFRKWXlsR3hhMGQ2aHQyd3J1Y2JVOU5qQlAyZlFrRkJL?=
 =?utf-8?B?SG1ZcUM1emlhR1MrWHZYajBvOXJHSjUxWURlSG5FQ0EvN1drV09vOVJSZzFW?=
 =?utf-8?B?N0FuN2FLcnJBNmpsUjBOZzZjdzdsZDlSems0SnFSalA4MU1IMFVJTGdjQWlY?=
 =?utf-8?B?c051My9hOHVWVUQxejhFWUcxa2Y3c0x2K1ZpcG1kbnBPaHZpcUx1NVlWOEwv?=
 =?utf-8?B?MzIvZ0FXdUJCcENtTmtBQWQzMGZIQ2o1WFg1MXJlSWphUXBQMGdtbWFkUG4z?=
 =?utf-8?B?b290a3R0c2ZYQkZQZ3ZsT3lPemdweERuNUMyYTFtanF3MkgvejlJSFBFZnN0?=
 =?utf-8?B?ME9sendTb1dJL0VwQi9OS2lQMnZnR1BJWFhzWHYvTzBWQVROSS81cHl5eWxS?=
 =?utf-8?B?aDBhUStPbjI0bThxdnNGK09SOEZXWDQ3bUdqa0k2UXlpS0NGdHRhbjlycy9D?=
 =?utf-8?B?THJjeE5DQWZGLzl6SzgzejY4WGsxK3p6eTNrY2VVbE5oSTNnSU14SWtMdXVK?=
 =?utf-8?B?UTdyTG9NcnJ4Q2hFODMyMXJFUHcxT2k2ZlBVVHIra2REWlAzdVA5RTYzRElX?=
 =?utf-8?B?U1FrcEt2ZERQbFpDOVJ1ZHE3Sy9jR2N2RTBlQW5PV2F3R3Q3aDRMaURtUEZD?=
 =?utf-8?B?aFY1YmY0VldJRnVmdmcrcXlnZTNCSlV3T3JtTzI4UU5WRjVsTkV3R0xNQWIz?=
 =?utf-8?Q?XUWqJN22QKY5gnO54zqP3J5TK?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZQ+7vdM1BhOzFc81OGiFZSdJX5EouNFJ9ELT1Y6zSH+43pWG1zMtkaDWogJarTGHHR14LI2FZ/xC2x970HX2l1C9b0URn6QuuwFqC55lgJdwXVwo5s1iYY2BivIR1INwdlsdBzPpl2H7mawA0kPC67m9dK1swEXPGXfsT8bEHXJ1Qt/0tI8g/4CD2m1TJzqI+2LVXFX8grJwluz6I04pu1RkQHpE0bYMDGltK2/1msh6bujamzNzL2r2xFe46Xp/TbPjWaIpCcHs8GCWDhAr/Z7txD1semXBHBvQ6y8siIslIfB3o15JJhHDCf2PEZW83j2zeYLRGA9P0oqQfNfDX8cnKPsntIY1X9erdHhBSw5YA5SaW+68XrzPKKdTqn9JRptOMUaC/jd8fwQaDKzd/izC0CpMTJR6ztued0KVIGwZTzPB+f/3U9/p9LZWVKIJy1+foN00y3+Jf2sjSvzYvYBvMLT6WO96TzEmMNMYrWP6O4My9etAZengDhfe0llCYj8fuHRGt9xLNGY6nTZKhg5g0biwaPE2n25heFK2GKrMt8wrnkzLX3Hy3RjGoaWveGJbvG5Y/Q4YyO9eXGpPmNH1W+3uUV4MQMHmYKRfUBv8KTN6mKQN3zGJAefCOQsk
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e50f92-64b2-4768-dac8-08dc41832f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:24:46.8687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGUZAOzMjmH+0wpMcxSSO19tzGrwVoXR7M4KqEE1SFdEWg1Au75D8Tco9ue7eRoSc1/WZjheJ41nUrgY7jV+vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7362
X-Proofpoint-GUID: iYGzSnvhyO9MB-9M_HgO_peEOu3V_DHY
X-Proofpoint-ORIG-GUID: iYGzSnvhyO9MB-9M_HgO_peEOu3V_DHY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: iYGzSnvhyO9MB-9M_HgO_peEOu3V_DHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

U2luY2UgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKSBpbnZva2VzIHRoZSB2YWxpZGF0ZSBmdW5jdGlv
bnMgb2YNCmV4ZmF0X3ZhbGlkYXRlX2VudHJ5KCksIGl0IG9ubHkgc3VwcG9ydHMgZ2V0dGluZyBh
IGRpcmVjdG9yeQ0KZW50cnkgc2V0IG9mIGFuIGV4aXN0aW5nIGZpbGUsIGRvZXNuJ3Qgc3VwcG9y
dCBnZXR0aW5nIGFuIGVtcHR5DQplbnRyeSBzZXQuDQoNClRvIHJlbW92ZSB0aGUgbGltaXRhdGlv
biwgYWRkIHRoaXMgaGVscGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhh
bmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4N
ClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KLS0t
DQogZnMvZXhmYXQvZGlyLmMgICAgICB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMiArLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCA5ZjkyOTU4NDdhNGUuLmNl
YTkyMzFkMmZkYSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysgYi9mcy9leGZhdC9k
aXIuYw0KQEAgLTc3NSw3ICs3NzUsNiBAQCBzdHJ1Y3QgZXhmYXRfZGVudHJ5ICpleGZhdF9nZXRf
ZGVudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQogfQ0KIA0KIGVudW0gZXhmYXRfdmFsaWRh
dGVfZGVudHJ5X21vZGUgew0KLQlFU19NT0RFX1NUQVJURUQsDQogCUVTX01PREVfR0VUX0ZJTEVf
RU5UUlksDQogCUVTX01PREVfR0VUX1NUUk1fRU5UUlksDQogCUVTX01PREVfR0VUX05BTUVfRU5U
UlksDQpAQCAtNzkwLDExICs3ODksNiBAQCBzdGF0aWMgYm9vbCBleGZhdF92YWxpZGF0ZV9lbnRy
eSh1bnNpZ25lZCBpbnQgdHlwZSwNCiAJCXJldHVybiBmYWxzZTsNCiANCiAJc3dpdGNoICgqbW9k
ZSkgew0KLQljYXNlIEVTX01PREVfU1RBUlRFRDoNCi0JCWlmICAodHlwZSAhPSBUWVBFX0ZJTEUg
JiYgdHlwZSAhPSBUWVBFX0RJUikNCi0JCQlyZXR1cm4gZmFsc2U7DQotCQkqbW9kZSA9IEVTX01P
REVfR0VUX0ZJTEVfRU5UUlk7DQotCQlicmVhazsNCiAJY2FzZSBFU19NT0RFX0dFVF9GSUxFX0VO
VFJZOg0KIAkJaWYgKHR5cGUgIT0gVFlQRV9TVFJFQU0pDQogCQkJcmV0dXJuIGZhbHNlOw0KQEAg
LTgzNCw3ICs4MjgsNyBAQCBzdHJ1Y3QgZXhmYXRfZGVudHJ5ICpleGZhdF9nZXRfZGVudHJ5X2Nh
Y2hlZCgNCiB9DQogDQogLyoNCi0gKiBSZXR1cm5zIGEgc2V0IG9mIGRlbnRyaWVzIGZvciBhIGZp
bGUgb3IgZGlyLg0KKyAqIFJldHVybnMgYSBzZXQgb2YgZGVudHJpZXMuDQogICoNCiAgKiBOb3Rl
IEl0IHByb3ZpZGVzIGEgZGlyZWN0IHBvaW50ZXIgdG8gYmgtPmRhdGEgdmlhIGV4ZmF0X2dldF9k
ZW50cnlfY2FjaGVkKCkuDQogICogVXNlciBzaG91bGQgY2FsbCBleGZhdF9nZXRfZGVudHJ5X3Nl
dCgpIGFmdGVyIHNldHRpbmcgJ21vZGlmaWVkJyB0byBhcHBseQ0KQEAgLTg0MiwyMiArODM2LDI0
IEBAIHN0cnVjdCBleGZhdF9kZW50cnkgKmV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKA0KICAqDQog
ICogaW46DQogICogICBzYitwX2RpcitlbnRyeTogaW5kaWNhdGVzIGEgZmlsZS9kaXINCi0gKiAg
IHR5cGU6ICBzcGVjaWZpZXMgaG93IG1hbnkgZGVudHJpZXMgc2hvdWxkIGJlIGluY2x1ZGVkLg0K
KyAqICAgbnVtX2VudHJpZXM6IHNwZWNpZmllcyBob3cgbWFueSBkZW50cmllcyBzaG91bGQgYmUg
aW5jbHVkZWQuDQorICogICAgICAgICAgICAgICAgSXQgd2lsbCBiZSBzZXQgdG8gZXMtPm51bV9l
bnRyaWVzIGlmIGl0IGlzIG5vdCAwLg0KKyAqICAgICAgICAgICAgICAgIElmIG51bV9lbnRyaWVz
IGlzIDAsIGVzLT5udW1fZW50cmllcyB3aWxsIGJlIG9idGFpbmVkDQorICogICAgICAgICAgICAg
ICAgZnJvbSB0aGUgZmlyc3QgZGVudHJ5Lg0KKyAqIG91dDoNCisgKiAgIGVzOiBwb2ludGVyIG9m
IGVudHJ5IHNldCBvbiBzdWNjZXNzLg0KICAqIHJldHVybjoNCi0gKiAgIHBvaW50ZXIgb2YgZW50
cnkgc2V0IG9uIHN1Y2Nlc3MsDQotICogICBOVUxMIG9uIGZhaWx1cmUuDQorICogICAwIG9uIHN1
Y2Nlc3MNCisgKiAgIC1lcnJvciBjb2RlIG9uIGZhaWx1cmUNCiAgKi8NCi1pbnQgZXhmYXRfZ2V0
X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQorc3RhdGljIGlu
dCBfX2V4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVz
LA0KIAkJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2Rpciwg
aW50IGVudHJ5LA0KLQkJdW5zaWduZWQgaW50IHR5cGUpDQorCQl1bnNpZ25lZCBpbnQgbnVtX2Vu
dHJpZXMpDQogew0KIAlpbnQgcmV0LCBpLCBudW1fYmg7DQogCXVuc2lnbmVkIGludCBvZmY7DQog
CXNlY3Rvcl90IHNlYzsNCiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNi
KTsNCi0Jc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXA7DQotCWludCBudW1fZW50cmllczsNCi0JZW51
bSBleGZhdF92YWxpZGF0ZV9kZW50cnlfbW9kZSBtb2RlID0gRVNfTU9ERV9TVEFSVEVEOw0KIAlz
dHJ1Y3QgYnVmZmVyX2hlYWQgKmJoOw0KIA0KIAlpZiAocF9kaXItPmRpciA9PSBESVJfREVMRVRF
RCkgew0KQEAgLTg4MCwxMiArODc2LDE2IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1
Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCiAJCXJldHVybiAtRUlPOw0KIAllcy0+Ymhb
ZXMtPm51bV9iaCsrXSA9IGJoOw0KIA0KLQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKGVz
LCBFU19JRFhfRklMRSk7DQotCWlmICghZXhmYXRfdmFsaWRhdGVfZW50cnkoZXhmYXRfZ2V0X2Vu
dHJ5X3R5cGUoZXApLCAmbW9kZSkpDQotCQlnb3RvIHB1dF9lczsNCisJaWYgKG51bV9lbnRyaWVz
ID09IEVTX0FMTF9FTlRSSUVTKSB7DQorCQlzdHJ1Y3QgZXhmYXRfZGVudHJ5ICplcDsNCisNCisJ
CWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIEVTX0lEWF9GSUxFKTsNCisJCWlmIChl
cC0+dHlwZSAhPSBFWEZBVF9GSUxFKQ0KKwkJCWdvdG8gcHV0X2VzOw0KKw0KKwkJbnVtX2VudHJp
ZXMgPSBlcC0+ZGVudHJ5LmZpbGUubnVtX2V4dCArIDE7DQorCX0NCiANCi0JbnVtX2VudHJpZXMg
PSB0eXBlID09IEVTX0FMTF9FTlRSSUVTID8NCi0JCWVwLT5kZW50cnkuZmlsZS5udW1fZXh0ICsg
MSA6IHR5cGU7DQogCWVzLT5udW1fZW50cmllcyA9IG51bV9lbnRyaWVzOw0KIA0KIAludW1fYmgg
PSBFWEZBVF9CX1RPX0JMS19ST1VORF9VUChvZmYgKyBudW1fZW50cmllcyAqIERFTlRSWV9TSVpF
LCBzYik7DQpAQCAtOTE4LDggKzkxOCwyNyBAQCBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc3Ry
dWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQllcy0+YmhbZXMtPm51bV9iaCsrXSA9
IGJoOw0KIAl9DQogDQorCXJldHVybiAwOw0KKw0KK3B1dF9lczoNCisJZXhmYXRfcHV0X2RlbnRy
eV9zZXQoZXMsIGZhbHNlKTsNCisJcmV0dXJuIC1FSU87DQorfQ0KKw0KK2ludCBleGZhdF9nZXRf
ZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCisJCXN0cnVjdCBz
dXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQorCQlpbnQgZW50cnks
IHVuc2lnbmVkIGludCBudW1fZW50cmllcykNCit7DQorCWludCByZXQsIGk7DQorCXN0cnVjdCBl
eGZhdF9kZW50cnkgKmVwOw0KKwllbnVtIGV4ZmF0X3ZhbGlkYXRlX2RlbnRyeV9tb2RlIG1vZGUg
PSBFU19NT0RFX0dFVF9GSUxFX0VOVFJZOw0KKw0KKwlyZXQgPSBfX2V4ZmF0X2dldF9kZW50cnlf
c2V0KGVzLCBzYiwgcF9kaXIsIGVudHJ5LCBudW1fZW50cmllcyk7DQorCWlmIChyZXQgPCAwKQ0K
KwkJcmV0dXJuIHJldDsNCisNCiAJLyogdmFsaWRhdGUgY2FjaGVkIGRlbnRyaWVzICovDQotCWZv
ciAoaSA9IEVTX0lEWF9TVFJFQU07IGkgPCBudW1fZW50cmllczsgaSsrKSB7DQorCWZvciAoaSA9
IEVTX0lEWF9TVFJFQU07IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykgew0KIAkJZXAgPSBleGZh
dF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQogCQlpZiAoIWV4ZmF0X3ZhbGlkYXRlX2VudHJ5
KGV4ZmF0X2dldF9lbnRyeV90eXBlKGVwKSwgJm1vZGUpKQ0KIAkJCWdvdG8gcHV0X2VzOw0KZGlm
ZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRl
eCA5NDc0Y2Q1MGRhNmQuLjgwMGFlYTI5NDNlMiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0
X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC01MDAsNyArNTAwLDcgQEAgc3Ry
dWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoc3RydWN0IGV4ZmF0X2Vu
dHJ5X3NldF9jYWNoZSAqZXMsDQogCQlpbnQgbnVtKTsNCiBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9z
ZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQlzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBpbnQgZW50cnksDQotCQl1bnNpZ25l
ZCBpbnQgdHlwZSk7DQorCQl1bnNpZ25lZCBpbnQgbnVtX2VudHJpZXMpOw0KIGludCBleGZhdF9w
dXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywgaW50IHN5bmMp
Ow0KIGludCBleGZhdF9jb3VudF9kaXJfZW50cmllcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBz
dHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyKTsNCiANCi0tIA0KMi4zNC4xDQoNCg==

