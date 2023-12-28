Return-Path: <linux-fsdevel+bounces-6981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913281F53C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3CC1C209C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 06:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B35671;
	Thu, 28 Dec 2023 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fmtAALpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE75380
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS3gfMp019601;
	Thu, 28 Dec 2023 06:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=9aEat5jpRfNCXPHqsxpidsDdlP+cU+rq/gmZBV0mvXg=;
 b=fmtAALpKz9kpPOsoZR55s9vSjp0vHsTV2sGgI3lxCijR4qD/dbT7vuphha60/nTju1Uh
 Gfsuq/yja904q9q3hPpWxX7aL2tiJJkEASkuRG6YZzsHpE76sFRgiQD1j4JceeO5ffOE
 g2s8qQjDcIER7RNxwmsdvSmf1jl0NQvnEdMp2Jn+PPTcYiWr3C8z1RQAw7Et96z3BA5+
 KaCun1ST1LBqyZYVlgoign8v6A8K2bd7j+mpBi2jhnAtoql97FReLSzq33SiDeihTQPo
 5UDEvS+2mH0XoQzWevQ5U+v4l62vgTL5pc2A+t9ekTjl16vF1h6C5Y9GyqqZFk2wUduo FA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5qxtbseb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 06:59:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgIsKTeL0c+JUyqgEfq6DxbcZC7JTebnzPf9SD+lhFbAFw40i2cFiw7U8pRGvSbU/n78gAWatDaHD9UP4xcUZ2sab5He/yJdjdCQ3o+gk/rviH0iTmWE156KYKD6gdo/zBDH0UQ+g/cBooGaIg7EZwrwYV2ym57hrbTAG4rK9fQ4DPVrZdAHKNCtHTjiCM1dzmdLZf+N8252h9jdSRIbQ64+SDif0A3cW4xH9WFeqpGGaUzKQAvrYMPBe5GMwO22vX3Nc3LEFhBGC1q75ZqKnxg3cgo0jJFcE089F7EJLd6alGz2+Z+ToYiQCDc062sHPuyq+Rd66jLFlqxXrXOHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aEat5jpRfNCXPHqsxpidsDdlP+cU+rq/gmZBV0mvXg=;
 b=W+cNoy1QZhPjAJ0lPl+bEZ56vBH1s5do8/IJt2qjtPvxUFJ22kPiS6x4oLD06L45LXqB37L+zUf/okSAX8JB9XJl+DFeSJwdMe2BXetWp60aRnVTUZ07/XzG26QIHbNQx3BTmjCMEhEobbvfOJWVcE5Q3JGP5BYYAgORtG4hFB2qztMJHltJsIDsMukCYhW+fc6X2QX75byvPI6S+SOBppq3ByEa4Hmw+sq67VTPzf7DGp1S+uZy0GkRO1HW3GDojBPfRUn8LZf1/URTX5V1PnAq+JhscjgOrp7ZqdnXMAGNvu2ZxX10Ma324obaizC1Nc0wytBrCOmjXQmaKGTD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6878.apcprd04.prod.outlook.com (2603:1096:820:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 06:59:29 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 06:59:29 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2 03/10] exfat: convert exfat_add_entry() to use dentry cache
Thread-Topic: [PATCH v2 03/10] exfat: convert exfat_add_entry() to use dentry
 cache
Thread-Index: Ado5WWe+YqWTBtMuRk+HhqyeamrfBw==
Date: Thu, 28 Dec 2023 06:59:29 +0000
Message-ID: 
 <PUZPR04MB63166803BDC3697C634BA727819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6878:EE_
x-ms-office365-filtering-correlation-id: c413ab52-5c95-4afe-23f4-08dc0772895f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Prn3cQUrphXhP1Ha3pnAny24I3Tbts0fH5L9ngzCMjBUTjgISoHLxufdMXRXO6GZMDK3GGdQUHBrpKymd5ktCLflqxW8gAy8LOWH1yenW6eirIM062vzmq5ryCd/dOLl8Joku+gXOR8eTozSKMK8pttQjG8oVvRpjO5DAlnL+heA3sxMn+VbgruKxMxDR0n7stTW/Wlz7Oc8/6+Z6ID2JPHuCj1R65oc5iFyHtjofiEJ1ZRGX00ZfOUls3pGSzTIWNwxvM35v1K/zFOTn+iE2/uEEdTtFgWP5leM87jdeQejxilI6pJL3XZThwHfZKrAaEX8Izju+eNJCIDWGk1K+osbQ4s+clccuvH0+IK7abpRshB+1v054CGuAhghSx47oYAqcxrSCCsKQ7Bl0QsgRjo8D46x3ofn/pdKXn8/nZrPtT+qQUHI2bF9cr80QFuI7eYJHxtBUBPNZUDy+omF2mpCZNd/ObFEA/1Y0uqOx46x2IElX4vfjqEm3tK3Wqk0mEO4ks6wyNXfC57ApXGPT9NRwqKxH+S8PxPwUMO/VmMHTqJG8BFLYyHzOCgqIZBukBQKy+dMxh/k2hTGbiCSOcGXNhDjRzYZOlcvl0l8nyxo2XgIYFCK1bMZOP5SlnhR
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33656002)(9686003)(6506007)(71200400001)(83380400001)(7696005)(478600001)(107886003)(26005)(38100700002)(122000001)(82960400001)(41300700001)(316002)(54906003)(110136005)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(8676002)(8936002)(52536014)(5660300002)(76116006)(2906002)(38070700009)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZVY1cUtwOTRvZVc2bFowbW5iYldZVHRVRFVhS2NuOVRQRDdjVnh0QTVrcDd4?=
 =?utf-8?B?QnV6bFF5QmtRVk5KVkQwTzNMaTF3QXAxZ1EvRnM5SmkxS2pYNGtNZ1lFRjNl?=
 =?utf-8?B?aERZNUx4REFXREcxc1N1a1R6NitKU3Q4L1VTNktEMEJEMzc2R21rUXFrNDkx?=
 =?utf-8?B?dkduT3oyd0V5L0M3cVVCS251ZXllcHdhTkFHcThxVXV5V2JJaTQxYVJlZERh?=
 =?utf-8?B?VnZ2NXQ1UkxJVEs0VnY1RmM5dzQ4STVXQzdOaXRNb1FWUVdZZVVzMkFKNGZh?=
 =?utf-8?B?aWViT1N6NUlpejZSQ2Y4WmFjc0VTakFTQmp3SlJFdk1uNWRLQUhPYXpLbWcw?=
 =?utf-8?B?NGVBQTI5YkZDZElPaHZUc3JjbE1sbWkvMXNOR3QwaEpVdit6ZTFoSFA2SFZu?=
 =?utf-8?B?QWtzVWpwZUVyS2ZaQW9yR0lyYmJoaG9OVG50b3pzM1JkTElaeW44dlBOTHFN?=
 =?utf-8?B?M3NSSTNLaitoY29rZjAyL1lsUWxmeFh1aFh2dXNIL25MckgyQUtieGF6L3hr?=
 =?utf-8?B?MXNMRzNmOVRpRDd1SWQ0UXJRTXRtL2NIb2ZUc0VnUzFRd2wxa1dsdHRrQXp3?=
 =?utf-8?B?TUI0dkdveUliTmtLK256SW01a3Q0eHhINVl5UU5KVVkyQStWYS9jNm1Hei82?=
 =?utf-8?B?OUh0ZVQrSDllT1BnSHNYQ0Y1SHkyNVQ2WEViSjF0YWorVWtacGlXSjlmcG9R?=
 =?utf-8?B?b3NDblV3SkdFMlY4RjQxb2FodlE2VnJOSVk2ZEs1a2xOOUhpTXZhRWtKbVRW?=
 =?utf-8?B?dkpPVnlRWXpwdDFNNlBxUERMUjVuSlJoNEJXQ2xJemh0Zk9zbkhncGt2YkZu?=
 =?utf-8?B?VE8zbGxNY1pxUm56Y3ZQZzJEbnNMT1pSSndvd1Z5eVQ0eFl5aFc0YkdjT1ZD?=
 =?utf-8?B?M29SZlUrNGNVT0NVSE0wcnNLMElqQWtTMDQ1VDlNQjViQmVmakRUVHdiZVNP?=
 =?utf-8?B?bUowQmlUNEtFNkM2UTlPWFJEcDdEcjhhamRkNEJtNVJFdktZZ0Q2bEVNOTZR?=
 =?utf-8?B?bzQ2bFE2L0hxVlNMRWlaRm5Tc1N2cnJmaHJQdVIrZkQxUVVablRFSjdyYXl1?=
 =?utf-8?B?VVJockN3YzlHL3pCM2lCSXVyQ3JjeWR2WGI1V1FjaUdqNHBoaUNWaUhmREJ2?=
 =?utf-8?B?VzdrSHNLVzd5LzZoS25WREpFb0hoV0FKaEZ6VmVna1MyVTg0K3dLSy9IQUow?=
 =?utf-8?B?Y091K0pCV1FmN2p1UWpIdVRkS0M3TDdiSFc3THlZZG5MbHhSUWtBY0pQWXpw?=
 =?utf-8?B?ajRhMUlmeUs4MC9tWGd3ZU1Ha1JYcWc5SDBCcGR5TmJWcDY3c2gxeFBmNE5Y?=
 =?utf-8?B?alROQ0hubjdiUEluQTROWWJlZ01ocnh4eUZUb3hrUE1WeU1mMm1BMHZPaVRY?=
 =?utf-8?B?Mkd5Y0NVVnlWR09tVm9DQ2E5SUJaZkFTM3VmWlB4bCs4SDhia3hQTWJweTA2?=
 =?utf-8?B?Z3kybFVyWC9uWW5hcEd1bllDNHNPVjIzd3BPci9ta0tzTDZ0SEVvWURiditN?=
 =?utf-8?B?LzhOeVNPZ3RWVHNZV3pONnFwQWRNM29MbjVLR25tQlQvSUVKRzY1c1AwbW9i?=
 =?utf-8?B?Z2ZGZU9aaUdHOVNmZVlDa09tMUlSZEJDODcrQ0huL2RnZXJEQmNud0YwYlZX?=
 =?utf-8?B?VmJwOHRTZEZhdExadys1VXBwZEJDNGkySXpNckNXWlJsR3BKNWRzRGprcmtx?=
 =?utf-8?B?TFhyQStWR0NHdlp5eXhnRmUrSG1VTmtqakt2bkwxa1ZjcDZjbjBBMXRRQXln?=
 =?utf-8?B?ai9HUHhNRmFtUll4ODJaVHZDRmNmaGZsZThRbGFxaEVDZXY5N0QyT0tlNGl6?=
 =?utf-8?B?cUtyNm5LMTU3c1BCNndPSzJpYUVxekgxc0VsMkJMTkt4Vk9QZVR0anJMaU04?=
 =?utf-8?B?eXkxOGo0eXg3ZWdlTVM4Y1BtZ1orVUhzWnJmNTNKRVk2MVgzOExUUlRFcDg3?=
 =?utf-8?B?QVA4T0ZUTHVBRWlMZW5VeEtGRUtCM2J2NkFGRWk0ZHc5djZDb2lOSVAzanUy?=
 =?utf-8?B?dXZLZ011aTgzOWRhclhZTjArODRGRmxyMGFiRk5LdHZxM0dETndhOEg3Qk5w?=
 =?utf-8?B?WEpxaEFCOVVSTTRhdHA3OEZxWHFFdkNEOU0vR1RlQm1QdzZUMk14QUg1Mlh2?=
 =?utf-8?Q?YLuVUp6IbJS5jtEb9GbhPwLfr?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PCngojDGt0mqf/IrvwLII8AR4cWvcXCMaetMNMaiUOD1NuG7UXwRd7O37eoZsu3fY6xOXvbE+e5X7HEbzi++Kw2ZEmSlVzCSfOHoIyxdsVqBzXQzAMZ6pb0jXJd7uhe3S/gDZwedOKBou7j7/lQYwCLSe3KlLnf4Ve78WTdFBnUass/Q3xXqXjOGXqf1NG3YqpkyYgJjgWt73ZIbOMZ64E8qH7BWAmIg8nXnRqbDTOsmr/6839b2Z7DTJQiJATLjtS6/sbGawx/i+r2B/7E5b071SV8aVnuJ7En19WLppEgde3+B6MchFNldEDv12yoYmFZy805NWUDcgRG6SowJ74nGxvBT6EAAhi9le8T5pX0VfR/dX/dtMDbkBYDMO3o5+g7AKLmhEF9nN4WEgQyrh18tGVasJ5lCuvJ/U7pjtjfYryhrSGwLVx2eB6yv0S1WToUTLVDH2wuIbkqPMCzk1jzjOXWmmBV2ct+YSsgEPj8wpMDJ2McFEAzYVHScLIJKHj+J/aNHUszkxLgAMVOS5nY5VWMT+n7Bdy/eW6RsjwikQvthkuv6aLiM3EW9kdAC0p6cFVUkME/NnngGOt6o7+ik79iseYvKZTDKdU5iZyKtDRpcev2ysPnYwnl9DFyy
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c413ab52-5c95-4afe-23f4-08dc0772895f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:59:29.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAyUSpEtLcpTish3wM1DIEEZT3bOGtNNunmKuX7uG5kJun0LY7eodv1jxWh/67jzCcunAurQjAg1F3YUwYOq/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6878
X-Proofpoint-GUID: di4rX-cnHdT_nmLuzjt4w99uaH9_HSQB
X-Proofpoint-ORIG-GUID: di4rX-cnHdT_nmLuzjt4w99uaH9_HSQB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: di4rX-cnHdT_nmLuzjt4w99uaH9_HSQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

QWZ0ZXIgdGhpcyBjb252ZXJzaW9uLCBpZiAiZGlyc3luYyIgb3IgInN5bmMiIGlzIGVuYWJsZWQs
IHRoZQ0KbnVtYmVyIG9mIHN5bmNocm9uaXplZCBkZW50cmllcyBpbiBleGZhdF9hZGRfZW50cnko
KSB3aWxsIGNoYW5nZQ0KZnJvbSAyIHRvIDEuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1v
IDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNv
bnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5j
b20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAgICAgIHwgMzcgKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgNiArKystLS0NCiBmcy9l
eGZhdC9uYW1laS5jICAgIHwgMTIgKysrKysrKysrKy0tDQogMyBmaWxlcyBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rp
ci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IGE1YzhjZDE5YWNhNi4uNDJmOTZlZTZiOWQzIDEw
MDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rpci5jDQpAQCAtNDQ4
LDUzICs0NDgsMzQgQEAgc3RhdGljIHZvaWQgZXhmYXRfaW5pdF9uYW1lX2VudHJ5KHN0cnVjdCBl
eGZhdF9kZW50cnkgKmVwLA0KIAl9DQogfQ0KIA0KLWludCBleGZhdF9pbml0X2Rpcl9lbnRyeShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KLQkJaW50IGVu
dHJ5LCB1bnNpZ25lZCBpbnQgdHlwZSwgdW5zaWduZWQgaW50IHN0YXJ0X2NsdSwNCi0JCXVuc2ln
bmVkIGxvbmcgbG9uZyBzaXplKQ0KK3ZvaWQgZXhmYXRfaW5pdF9kaXJfZW50cnkoc3RydWN0IGV4
ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQorCQl1bnNpZ25lZCBpbnQgdHlwZSwgdW5zaWduZWQg
aW50IHN0YXJ0X2NsdSwNCisJCXVuc2lnbmVkIGxvbmcgbG9uZyBzaXplLCBzdHJ1Y3QgdGltZXNw
ZWM2NCAqdHMpDQogew0KLQlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7DQor
CXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBlcy0+c2I7DQogCXN0cnVjdCBleGZhdF9zYl9pbmZv
ICpzYmkgPSBFWEZBVF9TQihzYik7DQotCXN0cnVjdCB0aW1lc3BlYzY0IHRzID0gY3VycmVudF90
aW1lKGlub2RlKTsNCiAJc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXA7DQotCXN0cnVjdCBidWZmZXJf
aGVhZCAqYmg7DQotDQotCS8qDQotCSAqIFdlIGNhbm5vdCB1c2UgZXhmYXRfZ2V0X2RlbnRyeV9z
ZXQgaGVyZSBiZWNhdXNlIGZpbGUgZXAgaXMgbm90DQotCSAqIGluaXRpYWxpemVkIHlldC4NCi0J
ICovDQotCWVwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgcF9kaXIsIGVudHJ5LCAmYmgpOw0KLQlp
ZiAoIWVwKQ0KLQkJcmV0dXJuIC1FSU87DQogDQorCWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNo
ZWQoZXMsIEVTX0lEWF9GSUxFKTsNCiAJZXhmYXRfc2V0X2VudHJ5X3R5cGUoZXAsIHR5cGUpOw0K
LQlleGZhdF9zZXRfZW50cnlfdGltZShzYmksICZ0cywNCisJZXhmYXRfc2V0X2VudHJ5X3RpbWUo
c2JpLCB0cywNCiAJCQkmZXAtPmRlbnRyeS5maWxlLmNyZWF0ZV90eiwNCiAJCQkmZXAtPmRlbnRy
eS5maWxlLmNyZWF0ZV90aW1lLA0KIAkJCSZlcC0+ZGVudHJ5LmZpbGUuY3JlYXRlX2RhdGUsDQog
CQkJJmVwLT5kZW50cnkuZmlsZS5jcmVhdGVfdGltZV9jcyk7DQotCWV4ZmF0X3NldF9lbnRyeV90
aW1lKHNiaSwgJnRzLA0KKwlleGZhdF9zZXRfZW50cnlfdGltZShzYmksIHRzLA0KIAkJCSZlcC0+
ZGVudHJ5LmZpbGUubW9kaWZ5X3R6LA0KIAkJCSZlcC0+ZGVudHJ5LmZpbGUubW9kaWZ5X3RpbWUs
DQogCQkJJmVwLT5kZW50cnkuZmlsZS5tb2RpZnlfZGF0ZSwNCiAJCQkmZXAtPmRlbnRyeS5maWxl
Lm1vZGlmeV90aW1lX2NzKTsNCi0JZXhmYXRfc2V0X2VudHJ5X3RpbWUoc2JpLCAmdHMsDQorCWV4
ZmF0X3NldF9lbnRyeV90aW1lKHNiaSwgdHMsDQogCQkJJmVwLT5kZW50cnkuZmlsZS5hY2Nlc3Nf
dHosDQogCQkJJmVwLT5kZW50cnkuZmlsZS5hY2Nlc3NfdGltZSwNCiAJCQkmZXAtPmRlbnRyeS5m
aWxlLmFjY2Vzc19kYXRlLA0KIAkJCU5VTEwpOw0KIA0KLQlleGZhdF91cGRhdGVfYmgoYmgsIElT
X0RJUlNZTkMoaW5vZGUpKTsNCi0JYnJlbHNlKGJoKTsNCi0NCi0JZXAgPSBleGZhdF9nZXRfZGVu
dHJ5KHNiLCBwX2RpciwgZW50cnkgKyAxLCAmYmgpOw0KLQlpZiAoIWVwKQ0KLQkJcmV0dXJuIC1F
SU87DQotDQorCWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIEVTX0lEWF9TVFJFQU0p
Ow0KIAlleGZhdF9pbml0X3N0cmVhbV9lbnRyeShlcCwgc3RhcnRfY2x1LCBzaXplKTsNCi0JZXhm
YXRfdXBkYXRlX2JoKGJoLCBJU19ESVJTWU5DKGlub2RlKSk7DQotCWJyZWxzZShiaCk7DQotDQot
CXJldHVybiAwOw0KIH0NCiANCiBpbnQgZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW0oc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwNCmRpZmYgLS1naXQgYS9mcy9l
eGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggNTQyMTM2YjE0YTJl
Li5iNzdjZjY1NDc1MGEgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQorKysgYi9m
cy9leGZhdC9leGZhdF9mcy5oDQpAQCAtNDgwLDkgKzQ4MCw5IEBAIGludCBleGZhdF9nZXRfY2x1
c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgY2x1c3RlciwNCiBleHRlcm4g
Y29uc3Qgc3RydWN0IGlub2RlX29wZXJhdGlvbnMgZXhmYXRfZGlyX2lub2RlX29wZXJhdGlvbnM7
DQogZXh0ZXJuIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZXhmYXRfZGlyX29wZXJhdGlv
bnM7DQogdW5zaWduZWQgaW50IGV4ZmF0X2dldF9lbnRyeV90eXBlKHN0cnVjdCBleGZhdF9kZW50
cnkgKnBfZW50cnkpOw0KLWludCBleGZhdF9pbml0X2Rpcl9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KLQkJaW50IGVudHJ5LCB1bnNpZ25lZCBp
bnQgdHlwZSwgdW5zaWduZWQgaW50IHN0YXJ0X2NsdSwNCi0JCXVuc2lnbmVkIGxvbmcgbG9uZyBz
aXplKTsNCit2b2lkIGV4ZmF0X2luaXRfZGlyX2VudHJ5KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRf
Y2FjaGUgKmVzLA0KKwkJdW5zaWduZWQgaW50IHR5cGUsIHVuc2lnbmVkIGludCBzdGFydF9jbHUs
DQorCQl1bnNpZ25lZCBsb25nIGxvbmcgc2l6ZSwgc3RydWN0IHRpbWVzcGVjNjQgKnRzKTsNCiBp
bnQgZXhmYXRfaW5pdF9leHRfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0
X2NoYWluICpwX2RpciwNCiAJCWludCBlbnRyeSwgaW50IG51bV9lbnRyaWVzLCBzdHJ1Y3QgZXhm
YXRfdW5pX25hbWUgKnBfdW5pbmFtZSk7DQogaW50IGV4ZmF0X3JlbW92ZV9lbnRyaWVzKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQpkaWZmIC0tZ2l0IGEv
ZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMNCmluZGV4IDljNTQ5ZmQxMWZjOC4u
MDc1MDZmMzg4MmJiIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhm
YXQvbmFtZWkuYw0KQEAgLTQ5OSw2ICs0OTksOCBAQCBzdGF0aWMgaW50IGV4ZmF0X2FkZF9lbnRy
eShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpwYXRoLA0KIAlzdHJ1Y3QgZXhmYXRf
c2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOw0KIAlzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgdW5p
bmFtZTsNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGNsdTsNCisJc3RydWN0IHRpbWVzcGVjNjQgdHMg
PSBjdXJyZW50X3RpbWUoaW5vZGUpOw0KKwlzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlIGVz
Ow0KIAlpbnQgY2x1X3NpemUgPSAwOw0KIAl1bnNpZ25lZCBpbnQgc3RhcnRfY2x1ID0gRVhGQVRf
RlJFRV9DTFVTVEVSOw0KIA0KQEAgLTUzMSw4ICs1MzMsMTQgQEAgc3RhdGljIGludCBleGZhdF9h
ZGRfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwgY29uc3QgY2hhciAqcGF0aCwNCiAJLyogZmls
bCB0aGUgZG9zIG5hbWUgZGlyZWN0b3J5IGVudHJ5IGluZm9ybWF0aW9uIG9mIHRoZSBjcmVhdGVk
IGZpbGUuDQogCSAqIHRoZSBmaXJzdCBjbHVzdGVyIGlzIG5vdCBkZXRlcm1pbmVkIHlldC4gKDAp
DQogCSAqLw0KLQlyZXQgPSBleGZhdF9pbml0X2Rpcl9lbnRyeShpbm9kZSwgcF9kaXIsIGRlbnRy
eSwgdHlwZSwNCi0JCXN0YXJ0X2NsdSwgY2x1X3NpemUpOw0KKw0KKwlyZXQgPSBleGZhdF9nZXRf
ZW1wdHlfZGVudHJ5X3NldCgmZXMsIHNiLCBwX2RpciwgZGVudHJ5LCBudW1fZW50cmllcyk7DQor
CWlmIChyZXQpDQorCQlnb3RvIG91dDsNCisNCisJZXhmYXRfaW5pdF9kaXJfZW50cnkoJmVzLCB0
eXBlLCBzdGFydF9jbHUsIGNsdV9zaXplLCAmdHMpOw0KKw0KKwlyZXQgPSBleGZhdF9wdXRfZGVu
dHJ5X3NldCgmZXMsIElTX0RJUlNZTkMoaW5vZGUpKTsNCiAJaWYgKHJldCkNCiAJCWdvdG8gb3V0
Ow0KIA0KLS0gDQoyLjI1LjENCg0K

