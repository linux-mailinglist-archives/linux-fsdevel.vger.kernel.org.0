Return-Path: <linux-fsdevel+bounces-4863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BCE80507C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 11:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A7F281864
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D32455771
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="VQolO8gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D07E1707
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 02:16:49 -0800 (PST)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B56Qawi013397;
	Tue, 5 Dec 2023 10:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=ITZgvUeR24PxtiCoVh5bk7z35mnk8a/6uDYKvWct7BY=;
 b=VQolO8gdPbQrRhKvYzamcQPKJbeDgHqxbnyisMFlvDJzFKh3RfnZ2xtqUkZVtZTZCuPW
 eXakaOYbBKGc31m/lXVK0P7MONwVh2aO73AnB/zDdNPBcALvDFXTwsgEcyyxFb8khj9S
 pjEXCqIBD8GjGWmo17UioUurMM9+CNvQONw+0sVTwQQJIPOwOBEc5yQX1fxVSUmJ+KXW
 PCK6Ah93KD4i2PS+H2QFibrx/G4hlariNEHnm/BdbLGogczyikpL3+Devoigniz/1Io+
 BcBMo2gF98uEXFkrPTl3fGOp+PDhmVTVVGCGQni1IKZ0j20mQecpiZCM5fdpX28qMliS sA== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uqvytjnux-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 10:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdfDZjrjxgMR7i1r0fFitlb/QW5OwfoUb6u0SJm3dRm3jCDzytsgOGovq0Sf2KeBzvqRt37H9WMAxaT4SmHCYsB+ZYvjMR4R8ZlUGCzVfPDpQo7b6xpllJG1gZRKg5vCdMWtR0xI5g81QWPNe4OyNRiT6Gw6oGfpd6ipXOFAQx5iTNlC5ItFvS1s+Os6GeT7DNQz2Q68YDouHY5zgbCor+tDj0SrI5k5BvlxABv+1PHvxA+yASLcyyAnm0qmt6f+W+GvKHjmPT9USiQT9wORYcWW3p8jjZzXZfsh3VGxLlWfW/US3mOtr+7FfNXVmP9tBqMA+HEt3g8VS2BkLLMmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITZgvUeR24PxtiCoVh5bk7z35mnk8a/6uDYKvWct7BY=;
 b=RuL7Ezcomlr/x8aDi48D4CekmKIwneIMs8vNbJfERZ2B4qAvLnyRjJ80tepHpUUUToGaCUjTElzfcpsHgLWz4Iscq2Q106Q5EWFlHW+BejcznOh+knuRpRwOi1eB5K/FRAp5QkcW5J6dnVNSulcyXPW1YuoMEE8BqE7SxlZstCMqEI5LJ0OEltEXxC2w9gKC1cYwal1yvbb1BTd9zNIo9lbLqZizw8p8MVsWmdJAR/bfLAVRoNGyKjM1y5DiovWV9awS2gJM8us42Vf0SunPonPVPHV2R9V5nJEexDy1NACmI87zw+pkd63w6ULdBRSkzKnuvciq3LcByb2URB0czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB5633.apcprd04.prod.outlook.com (2603:1096:400:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 10:16:31 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 10:16:31 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v6 2/2] exfat: do not zero the extended part
Thread-Topic: [PATCH v6 2/2] exfat: do not zero the extended part
Thread-Index: AQHaJ2Qdtym2rS1EE0O6pSv/WwmGAg==
Date: Tue, 5 Dec 2023 10:16:31 +0000
Message-ID: 
 <PUZPR04MB6316B91A6ECD661064B39B768185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63164691A5119414706F66998182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: 
 <PUZPR04MB63164691A5119414706F66998182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB5633:EE_
x-ms-office365-filtering-correlation-id: 80086963-2332-4d8e-20c9-08dbf57b404e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 26JXjnBoNVPuHz9ve9y2zZ/1r13c4q7Bo3C9VCQUc5VOS1TPaffR6pNcZn7TVgYnZOP9x1ixZR54xS+Ehc2S45EwosoZimjVyitTjaHRdwBeowHY2NQTxt8JPVPSjEsZJ589kMfDSf6q2Ma2jOeV16q/H85yC9ORkBK7bxWxH5352ToF9DDg4KI5XQXc3fU3Yhl1YfGAY9d3Sr7z9JqDrbeEVJeDUY3Sb/ByYecrGimfMayeHsqGSnuJ5uGNxuK+B00gWvu7KoUWMK75pynCXRZ8cV6cl8jOBIKooEQTjGZ1bpwqNNomrC3m1ta4rppWQpf8gsruXeJ1BG5bB0KKCdXTQ772ipnEyCwXsbyNSpv8fUc9Xt0Uad+7zySdbnQW+Uwt9xCdv/d08q9UaOADTkHDRhyjszEav0d/ckEWPfWCJNtVPYfj46D4pKqIPls3jo26Dnpyl8yk6kk4+Llo1kT6AcD6/bEVeVGCRUjhsvkZ885N6iOTssYdu2sP//6s1ddJb2k3gqH3kZwXoTZmDb0uUyhLhYnWcrHGSS6Xa1HvGWwmuR5TNTGwaVTOuLAW7VHt8uNJNKanSPzpBeTffAUlVRXXveCxeV7Kr6vSQM0FLPdoz/ZJ/teyVpuYzPqq
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(76116006)(110136005)(122000001)(83380400001)(71200400001)(478600001)(6506007)(7696005)(82960400001)(66446008)(38100700002)(8936002)(8676002)(4326008)(66556008)(54906003)(66476007)(64756008)(316002)(9686003)(55016003)(26005)(66946007)(86362001)(52536014)(5660300002)(2906002)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZUNEa1NGV0RnNzdDR2tmTjdnb25KdGpSQzNxRkw3SjBabUQzd3BYTExYS0Ry?=
 =?utf-8?B?QW5kbHU2Yk5UVUFmYXViWXZaMk0zVXU1YXNlWFNsVnNHMmo1dng5MTJPbit3?=
 =?utf-8?B?aGw1U1pMdHBRUTRvK2RJcmxXQlJkVk9lRTI5MGtGcFNaSTFDa2xHRjF4THox?=
 =?utf-8?B?MVNOK2hDSlIyZmlHa2dwRnJJNHdKYlZUMnlnMDY0UE9xRXpSbGFOY1UwZXQv?=
 =?utf-8?B?L0M3Y2FPVkpiUERQT1NXTzlVc2Y0M3pMbldsMVpDM3MxN0lBK2tGeEhjR0pE?=
 =?utf-8?B?TXJhRTU0VitMM3RiVWVzTkNXL1VuMjdyMHhWcVM0bDFiS2haYzdnRVZPbjI4?=
 =?utf-8?B?ai9wWFc0d1FFeEc1Ym54d2w2WUsxS01BS2pENnJWUnBreG1YZFpxb05UbXlN?=
 =?utf-8?B?OGthbXJSalpRUThRa2QxTWgySFZCM25VRnJaTFVocHhHRWhMWi85NTYyNWc1?=
 =?utf-8?B?L2t0dWcxUUxzUmJBSGJ6NlRlV0FnVmk5TTNaWVhkQmZrRk9MNjdMeTBjaWhm?=
 =?utf-8?B?T2xIZTd5Uk1FVmtCejhLdjMzam01b0VXdG9EZnB0TVQ3TVlCVFBETFM3VEVK?=
 =?utf-8?B?c0FZYWJkbEdjcWNXSm9jcThCSXEvWU5iUUZiOFF0WlN5MUdBSGJSQkI0UFpV?=
 =?utf-8?B?Y0htdXd4SnZrakNaSDZHSk1lVS9FaklsME9Hb0hNdEJHR291ZExJekx1VWRH?=
 =?utf-8?B?blpUcW1hNnpuVFNEZWJaVlVnUU92ZWZ5d0VPYjFtbXpQZTJkSFMwZkVzUXRZ?=
 =?utf-8?B?S1E3Vk9RMUtKM1NnTy8vTm15QnlrYnU3bTA1VUJkaVhnU1JxcUpoV0xaUHVx?=
 =?utf-8?B?elZ3TTJEYjZQQkVyRnh1YkpBTGdYMEl2UWkrWFl4TENwcmxmR0t2OWZVUktl?=
 =?utf-8?B?R25xQWFHaUwvUXdUUEJvVGxLZTlQT05uUXNCSnA0WTc0ckk2a0tWZkxOZS9x?=
 =?utf-8?B?OGJTWEM0Z2ttd2g3TUI1WFkxTTc1QnZuVWh3V2pnSjB2UUxQbkNyd1NKellr?=
 =?utf-8?B?QzJ5b1lMWmZuWEZnWUJqUHFEclhPZzVva2FJQ0dTRjVkL0VoeEU1eDhzR3NZ?=
 =?utf-8?B?KzdlK0U0NUMrKzQ0bHVQYUN2ZTV4cGtzT05CQmVIQ0FtUXgweEZUSzBnV2hZ?=
 =?utf-8?B?Ym9YSURpYURURGpqYlduVmJCeVBKR0g5L1o4NVo0aHRiK2tuUWMxcldtTVc2?=
 =?utf-8?B?cVl1Z1l5WCtET2tCeVpnbzNucWxHeFk3YlFvQmxOMm82OWplTGRHeThvVWFQ?=
 =?utf-8?B?ekZJUE1uUXhRVTNVRHVJTGhYZE5oMVdiL2pYL1JQa1BYZmplU1dXQzE2eEI5?=
 =?utf-8?B?ejlmZGZuUFN1TGw4QWFCeUJCUUNtc0ZmYm55ejJKT2RtaC9CcEJoVDZtdmkw?=
 =?utf-8?B?N3dodkRrZlV0ZTlrS2RQb01nZDlXdFNWUU9UL1M4emc5SzA3ODlid2NLYzZv?=
 =?utf-8?B?b3QwWG1zL1JLUnVWNmVGYU50UExONys1bEJuYVBwaWo5UmMrV2V1K3pmZGN5?=
 =?utf-8?B?MjZQY0xLUmtyVUV0QmFwejNKNUtTZlNVWkNFYnloRXp2TzRMa2hSRTNHdy9F?=
 =?utf-8?B?WU5IZ3FpU1BDS25JZnVDYkNDNXZRdGUzaWEyZDVtOHpKbDM5cHZwRlFLaURu?=
 =?utf-8?B?bWRkU3BPM1g4VHVOSm5QRlluWWlOT1Z3V05senZjTG0zQ1p4K2JtVWozMDNE?=
 =?utf-8?B?V1pkaTFKb2lDODZoQlh3Nk1LZjBRcUJTbTRRcys5K2NqM3JTdVVEZTVKZlZL?=
 =?utf-8?B?T01OOWl2MmNhbTV2UGVIeGxRVlRMdjdERjNJZXJrSWhQOWk2VEt0L2JZZllq?=
 =?utf-8?B?MGRzVWh5dFpJUys3dTRJYXNMREtOK2FNUmZqdE5TWlVYQVJKRlIwdHd3RFgv?=
 =?utf-8?B?K2MwMDFsM2xrUXd6WURiMlUyNUxaaXBBakpZNDkySGoxT3lyVjZlTFllS09o?=
 =?utf-8?B?YmloSm9lNkxIeXExT2tkZk0zWFlrOWJWY3hyWE5QQWc4OFZTZ0hlcDExTGRR?=
 =?utf-8?B?bjVHZGFsSjNiMjg0Z0UwNTIzYnNiSG1XdzJ0a2M3N2RHMU9XbjRvZDIxYno4?=
 =?utf-8?B?QXV2Z1MrcEdVYlJqWXlWNHJpcmwxMzFpcUVVWTN1R1ZvT2JOVE41WnhVbzdi?=
 =?utf-8?Q?7jDq3CQQWb3uZh0nWyeT7B/09?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WTVcqTA4CJFSimLJA0dR5Spu7ugHkPXEpfMf82uXWqt4a6GQlRAfO9PaydH4CoTj5k8ZJaUW9zEGowxpglJXaBTTQ27iegRWLVl9SYYEudL7KFlxr0qj+QPlcMfdIOiHQTPSVtwmWSY1xq27Ik3jqWvJon7RZcSvv9PXCAezYIRRtNTpjUCUb8JSuZWLAO4BwfaXoNcXWFFCY+LJLGul7oKUBFI+XmRTQIOahU4v5qgcxjaXPpFmyeoDu3nrmgaqWMdkv/b35ktUY/f35V/gzGapGvK879ji9agK2FbryVvl2oA/yX8oSXFzYp+h0a20A1Z02Sp7Qc8l6C/Hl8ASiw5VBjWFYMhcIeEOMm86R0Ih7vhrgyTC+lWiZcNlOq+7HknsnDGHcgvCuvW58RQgXYZyLPWLX074HiQKuvp15+Iw0dXa+V7JTe4cOop6pEi15nnBSYC9K7fvUq9b8zQSt2AAnMYc/dh2hFJySOZDSVFS9LKbBGQ0ndb5zkcL9jnAeXmwWnFA24ekWacjRw4VqWiEirNL+00v4gf5ZaYTdCEa3+fdU5Q7eSlP7XIzLdJ6SOsvjdMP9/8p+Zvq+Aoq51ZvgneJIxGsCqE/USwuS1rWQwuI1hKp2RjpPShDeEbO6RgOm/B+ow6WoGa8Z8NW6UiCsJFIvFzygmRvGSKXpc/0tgRRj+pfBKm2O1Y4tBt4swGoPyEuiBw4QZiGMJ3I3yFu2eR29v9aBPoS6WaVdu9ond6ao/ZvB7/Dk54vL78nEuxKSWHtCT2tP095njMBuWh+eaFZwBG1tRR/wP2I3SwJrZoY9gEDNzake4D0hh1lrDtU3/LbRQtCs4em4V/Chlfwn37LQzA2SuHmXnJYtBPCEfIt/Ehp3klEmYpRwUSY
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80086963-2332-4d8e-20c9-08dbf57b404e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 10:16:31.1496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECkqXe2YBNOYlD4VoW9RX+70T8JTFjAwn8JP53CItWWjeh0xP4UOaXTFs9P6OUk7WjIQqiVkS48oNGiWKf+zxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5633
X-Proofpoint-GUID: cDzq66cGDkv8Z5DM9J4sxnnyT4V-sjai
X-Proofpoint-ORIG-GUID: cDzq66cGDkv8Z5DM9J4sxnnyT4V-sjai
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: cDzq66cGDkv8Z5DM9J4sxnnyT4V-sjai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_04,2023-12-05_01,2023-05-22_02

U2luY2UgdGhlIHJlYWQgb3BlcmF0aW9uIGJleW9uZCB0aGUgVmFsaWREYXRhTGVuZ3RoIHJldHVy
bnMgemVybywNCmlmIHdlIGp1c3QgZXh0ZW5kIHRoZSBzaXplIG9mIHRoZSBmaWxlLCB3ZSBkb24n
dCBuZWVkIHRvIHplcm8gdGhlDQpleHRlbmRlZCBwYXJ0LCBidXQgb25seSBjaGFuZ2UgdGhlIERh
dGFMZW5ndGggd2l0aG91dCBjaGFuZ2luZw0KdGhlIFZhbGlkRGF0YUxlbmd0aC4NCg0KU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8
d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZpbGUuYyAgfCA3NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiBmcy9leGZhdC9p
bm9kZS5jIHwgMTQgKysrKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCsp
LCAyMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZpbGUuYyBiL2ZzL2V4
ZmF0L2ZpbGUuYw0KaW5kZXggMjcwZTJmOTM0MTI0Li5kMjVhOTZhMTQ4YWYgMTAwNjQ0DQotLS0g
YS9mcy9leGZhdC9maWxlLmMNCisrKyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KQEAgLTE4LDMyICsxOCw2
OSBAQA0KIA0KIHN0YXRpYyBpbnQgZXhmYXRfY29udF9leHBhbmQoc3RydWN0IGlub2RlICppbm9k
ZSwgbG9mZl90IHNpemUpDQogew0KLQlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGlu
b2RlLT5pX21hcHBpbmc7DQotCWxvZmZfdCBzdGFydCA9IGlfc2l6ZV9yZWFkKGlub2RlKSwgY291
bnQgPSBzaXplIC0gaV9zaXplX3JlYWQoaW5vZGUpOw0KLQlpbnQgZXJyLCBlcnIyOw0KKwlpbnQg
cmV0Ow0KKwl1bnNpZ25lZCBpbnQgbnVtX2NsdXN0ZXJzLCBuZXdfbnVtX2NsdXN0ZXJzLCBsYXN0
X2NsdTsNCisJc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVpID0gRVhGQVRfSShpbm9kZSk7DQor
CXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsNCisJc3RydWN0IGV4ZmF0X3Ni
X2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsNCisJc3RydWN0IGV4ZmF0X2NoYWluIGNsdTsNCiAN
Ci0JZXJyID0gZ2VuZXJpY19jb250X2V4cGFuZF9zaW1wbGUoaW5vZGUsIHNpemUpOw0KLQlpZiAo
ZXJyKQ0KLQkJcmV0dXJuIGVycjsNCisJcmV0ID0gaW5vZGVfbmV3c2l6ZV9vayhpbm9kZSwgc2l6
ZSk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwludW1fY2x1c3RlcnMgPSBFWEZB
VF9CX1RPX0NMVV9ST1VORF9VUChlaS0+aV9zaXplX29uZGlzaywgc2JpKTsNCisJbmV3X251bV9j
bHVzdGVycyA9IEVYRkFUX0JfVE9fQ0xVX1JPVU5EX1VQKHNpemUsIHNiaSk7DQorDQorCWlmIChu
ZXdfbnVtX2NsdXN0ZXJzID09IG51bV9jbHVzdGVycykNCisJCWdvdG8gb3V0Ow0KKw0KKwlleGZh
dF9jaGFpbl9zZXQoJmNsdSwgZWktPnN0YXJ0X2NsdSwgbnVtX2NsdXN0ZXJzLCBlaS0+ZmxhZ3Mp
Ow0KKwlyZXQgPSBleGZhdF9maW5kX2xhc3RfY2x1c3RlcihzYiwgJmNsdSwgJmxhc3RfY2x1KTsN
CisJaWYgKHJldCkNCisJCXJldHVybiByZXQ7DQogDQorCWNsdS5kaXIgPSAobGFzdF9jbHUgPT0g
RVhGQVRfRU9GX0NMVVNURVIpID8NCisJCQlFWEZBVF9FT0ZfQ0xVU1RFUiA6IGxhc3RfY2x1ICsg
MTsNCisJY2x1LnNpemUgPSAwOw0KKwljbHUuZmxhZ3MgPSBlaS0+ZmxhZ3M7DQorDQorCXJldCA9
IGV4ZmF0X2FsbG9jX2NsdXN0ZXIoaW5vZGUsIG5ld19udW1fY2x1c3RlcnMgLSBudW1fY2x1c3Rl
cnMsDQorCQkJJmNsdSwgSVNfRElSU1lOQyhpbm9kZSkpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJu
IHJldDsNCisNCisJLyogQXBwZW5kIG5ldyBjbHVzdGVycyB0byBjaGFpbiAqLw0KKwlpZiAoY2x1
LmZsYWdzICE9IGVpLT5mbGFncykgew0KKwkJZXhmYXRfY2hhaW5fY29udF9jbHVzdGVyKHNiLCBl
aS0+c3RhcnRfY2x1LCBudW1fY2x1c3RlcnMpOw0KKwkJZWktPmZsYWdzID0gQUxMT0NfRkFUX0NI
QUlOOw0KKwl9DQorCWlmIChjbHUuZmxhZ3MgPT0gQUxMT0NfRkFUX0NIQUlOKQ0KKwkJaWYgKGV4
ZmF0X2VudF9zZXQoc2IsIGxhc3RfY2x1LCBjbHUuZGlyKSkNCisJCQlnb3RvIGZyZWVfY2x1Ow0K
Kw0KKwlpZiAobnVtX2NsdXN0ZXJzID09IDApDQorCQllaS0+c3RhcnRfY2x1ID0gY2x1LmRpcjsN
CisNCitvdXQ6DQogCWlub2RlX3NldF9tdGltZV90b190cyhpbm9kZSwgaW5vZGVfc2V0X2N0aW1l
X2N1cnJlbnQoaW5vZGUpKTsNCi0JRVhGQVRfSShpbm9kZSktPnZhbGlkX3NpemUgPSBzaXplOw0K
LQltYXJrX2lub2RlX2RpcnR5KGlub2RlKTsNCisJLyogRXhwYW5kZWQgcmFuZ2Ugbm90IHplcm9l
ZCwgZG8gbm90IHVwZGF0ZSB2YWxpZF9zaXplICovDQorCWlfc2l6ZV93cml0ZShpbm9kZSwgc2l6
ZSk7DQogDQotCWlmICghSVNfU1lOQyhpbm9kZSkpDQotCQlyZXR1cm4gMDsNCisJZWktPmlfc2l6
ZV9hbGlnbmVkID0gcm91bmRfdXAoc2l6ZSwgc2ItPnNfYmxvY2tzaXplKTsNCisJZWktPmlfc2l6
ZV9vbmRpc2sgPSBlaS0+aV9zaXplX2FsaWduZWQ7DQorCWlub2RlLT5pX2Jsb2NrcyA9IHJvdW5k
X3VwKHNpemUsIHNiaS0+Y2x1c3Rlcl9zaXplKSA+PiA5Ow0KIA0KLQllcnIgPSBmaWxlbWFwX2Zk
YXRhd3JpdGVfcmFuZ2UobWFwcGluZywgc3RhcnQsIHN0YXJ0ICsgY291bnQgLSAxKTsNCi0JZXJy
MiA9IHN5bmNfbWFwcGluZ19idWZmZXJzKG1hcHBpbmcpOw0KLQlpZiAoIWVycikNCi0JCWVyciA9
IGVycjI7DQotCWVycjIgPSB3cml0ZV9pbm9kZV9ub3coaW5vZGUsIDEpOw0KLQlpZiAoIWVycikN
Ci0JCWVyciA9IGVycjI7DQotCWlmIChlcnIpDQotCQlyZXR1cm4gZXJyOw0KKwlpZiAoSVNfRElS
U1lOQyhpbm9kZSkpDQorCQlyZXR1cm4gd3JpdGVfaW5vZGVfbm93KGlub2RlLCAxKTsNCisNCisJ
bWFya19pbm9kZV9kaXJ0eShpbm9kZSk7DQorDQorCXJldHVybiAwOw0KIA0KLQlyZXR1cm4gZmls
ZW1hcF9mZGF0YXdhaXRfcmFuZ2UobWFwcGluZywgc3RhcnQsIHN0YXJ0ICsgY291bnQgLSAxKTsN
CitmcmVlX2NsdToNCisJZXhmYXRfZnJlZV9jbHVzdGVyKGlub2RlLCAmY2x1KTsNCisJcmV0dXJu
IC1FSU87DQogfQ0KIA0KIHN0YXRpYyBib29sIGV4ZmF0X2FsbG93X3NldF90aW1lKHN0cnVjdCBl
eGZhdF9zYl9pbmZvICpzYmksIHN0cnVjdCBpbm9kZSAqaW5vZGUpDQpkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IGIwMjY3N2M5ZmQ0NS4uNTIy
ZWRjYmIyY2U0IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMvZXhmYXQv
aW5vZGUuYw0KQEAgLTc1LDggKzc1LDE3IEBAIGludCBfX2V4ZmF0X3dyaXRlX2lub2RlKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIGludCBzeW5jKQ0KIAlpZiAoZWktPnN0YXJ0X2NsdSA9PSBFWEZBVF9F
T0ZfQ0xVU1RFUikNCiAJCW9uX2Rpc2tfc2l6ZSA9IDA7DQogDQotCWVwMi0+ZGVudHJ5LnN0cmVh
bS52YWxpZF9zaXplID0gY3B1X3RvX2xlNjQoZWktPnZhbGlkX3NpemUpOw0KIAllcDItPmRlbnRy
eS5zdHJlYW0uc2l6ZSA9IGNwdV90b19sZTY0KG9uX2Rpc2tfc2l6ZSk7DQorCS8qDQorCSAqIG1t
YXAgd3JpdGUgZG9lcyBub3QgdXNlIGV4ZmF0X3dyaXRlX2VuZCgpLCB2YWxpZF9zaXplIG1heSBi
ZQ0KKwkgKiBleHRlbmRlZCB0byB0aGUgc2VjdG9yLWFsaWduZWQgbGVuZ3RoIGluIGV4ZmF0X2dl
dF9ibG9jaygpLg0KKwkgKiBTbyB3ZSBuZWVkIHRvIGZpeHVwIHZhbGlkX3NpemUgdG8gdGhlIHdy
aXRyZW4gbGVuZ3RoLg0KKwkgKi8NCisJaWYgKG9uX2Rpc2tfc2l6ZSA8IGVpLT52YWxpZF9zaXpl
KQ0KKwkJZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBlcDItPmRlbnRyeS5zdHJlYW0u
c2l6ZTsNCisJZWxzZQ0KKwkJZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBjcHVfdG9f
bGU2NChlaS0+dmFsaWRfc2l6ZSk7DQorDQogCWlmIChvbl9kaXNrX3NpemUpIHsNCiAJCWVwMi0+
ZGVudHJ5LnN0cmVhbS5mbGFncyA9IGVpLT5mbGFnczsNCiAJCWVwMi0+ZGVudHJ5LnN0cmVhbS5z
dGFydF9jbHUgPSBjcHVfdG9fbGUzMihlaS0+c3RhcnRfY2x1KTsNCkBAIC0zNDAsNiArMzQ5LDkg
QEAgc3RhdGljIGludCBleGZhdF9nZXRfYmxvY2soc3RydWN0IGlub2RlICppbm9kZSwgc2VjdG9y
X3QgaWJsb2NrLA0KIAkJCQkJcG9zLCBlaS0+aV9zaXplX2FsaWduZWQpOw0KIAkJCWdvdG8gdW5s
b2NrX3JldDsNCiAJCX0NCisNCisJCWVpLT52YWxpZF9zaXplID0gRVhGQVRfQkxLX1RPX0IoaWJs
b2NrICsgbWF4X2Jsb2Nrcywgc2IpOw0KKwkJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7DQogCX0g
ZWxzZSB7DQogCQl2YWxpZF9ibGtzID0gRVhGQVRfQl9UT19CTEsoZWktPnZhbGlkX3NpemUsIHNi
KTsNCiANCi0tIA0KMi4yNS4xDQoNCg==

