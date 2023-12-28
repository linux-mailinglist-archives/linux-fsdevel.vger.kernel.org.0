Return-Path: <linux-fsdevel+bounces-6984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA57D81F53F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 08:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600B1281A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37F963AA;
	Thu, 28 Dec 2023 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="BHUd2vkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11663AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS6KLia020276;
	Thu, 28 Dec 2023 06:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=8Z8lKm/tN8zOAaHNvIHOs279XEQJO/kpBKk2dmXLyE0=;
 b=BHUd2vkheyP1MklTgyJYJ8+uEM8NuIVoHG7qKZ+oB1TOl2WDMArfRUNDMaGesBRGZbfa
 lcn/hLvTisA126cG4d0+2ori9q5NFAL7DNPVVF0cEYBMb2CP0DRcZ2phLlAqGSXXvfjO
 k1oYRAbHbJwdA0vkig8+j647raBXfoiyq8hT8GFsg4dz3nEAWlh7o2kyjQjIVeL8G/rX
 F9juDl0mlV+66Fgclm6FWDYuFAV5mvq0Hm6XxAJrRAq4rr/q09CWR5//UilxTB/zd9v5
 hx6g/8CxV+aSVk+e44R65YPIfdMKCG/7KJr53kLplN7Ap19sRCWfqu9okCI63AV6oLBg zw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5qxtbsed-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 06:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey+hP0xPn8AHWraBjnVP2VvWA3JJST9dtychj8XpbvMT4AesR8Fmtpih1U61FaAOPuqrJjUN3Pxb4HbBHRTNS0UrD05GjbJMC1lP3YdX1K8x5ESxi1UfS1I0Nl0Sal9fpzZmGUSrvBdA1CUerKylw0li19XFrDHv5ixfqU5R01gruaROCwzG50ll9x0T5oZnyEJWDrGT2n8fBmkYStVi3S9Q02NfPA9d+seTUFMERUrID85hv5DyUthj2wOBlOk5slkQPGSrcUS++daYwMqkb87Ck89Hf+Fl5G96uR9x3EWTM7ORsecA/7mtjvvaK12BRs74SuPYakBncxbviWu2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z8lKm/tN8zOAaHNvIHOs279XEQJO/kpBKk2dmXLyE0=;
 b=HyzyUQe/KzK4313pV1fnFqITWCDR6BSv7QXdmWcMNR9D1U2+FtLeoOh0iw9GZihu48GWdNuEvrO1OfwhJNtSF7G3Oom6bshO6Bj5KWwNV5vqVbbN+PGcBy7eQ6jM8r3h3PlkoFILOl0f7ET/yfqwfT5CAXMaeKvBgBwF70HKfH5B9MyuzX6/ccIZkPjYs5oQ06egdd5ihPZDLDyrbDkWDwuT16n5Bt5kxYIeZ94z3VTwj/+hc+COBesWHysF3bwWWe1CxwDU7R1W1wS7WMZ8q1U9e+0+1+uDfhSQSy3bzTlZodbyPt9RGHB7Kb6mpp6HZLW7JWFXRDsD/3k+t0gQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6878.apcprd04.prod.outlook.com (2603:1096:820:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 06:59:43 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 06:59:43 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2 05/10] exfat: move free cluster out of
 exfat_init_ext_entry()
Thread-Topic: [PATCH v2 05/10] exfat: move free cluster out of
 exfat_init_ext_entry()
Thread-Index: Ado5WfYsa/OP+3nnTw2Q1KJfPdkIMg==
Date: Thu, 28 Dec 2023 06:59:42 +0000
Message-ID: 
 <PUZPR04MB63160BD4A0D054F70CACF29D819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6878:EE_
x-ms-office365-filtering-correlation-id: de2ee97d-35db-48ba-4994-08dc07729191
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BN/T/umrvU9HKPC0H8Jq8YI89CTuqikEeYUf0D2mZHAWbzg1nt/SNtm6OtM4SHpA+TjLMdZTEBeTPPmcjqYEBfYpK41WWr8/AqUNBhWXp7pMvfLUeSFE1X1eZpqtySPGu+1UWe5CPp7EK1binfYHiAaBAvEp8gSmc15jF1MlZwwHgMD+5IkYqOryFo8nkhXuQGHXS8zLo2uH57Vl7P9U48tjzewQxuiA6jNPHFa3TQuOeotjuMvLRXQhByPZbcAHk/sUmOHVWGAO5cSWChX6GGdSWdatS+0QlumhvuLJRBwsHWxT4FvZndiX9pSXLIrASBGZ4hfXbF60Y7AdSLCbgNfgJhmrOtd6tlLtOQt0rAF7zdDv9rWE9VRr9MHHEriZVQ+aJYOKkitIranZMW4jrC+Rrln8TVlc+jT6pT7/9J5UeRRa6qkmyBCoE9mDLZ+Q4ZWK3LmOz95KCDe/tyHj5HfMM1L2DHUIqdY9O+Q2T5X7XMxR4u6Qy94E8vmBfrFfLuuJL8lpBjeoAudbgVV3H8KaCd7IHz62Yio+1tIPiXqX/bNvVSj79x8zhfKJA8qGVWHh8BvnHoLtLsLjReIJju7wQWEALcTbgW+a3h3KdAm6qv60RyhmpmuG+HafEk0q
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33656002)(9686003)(6506007)(71200400001)(83380400001)(7696005)(478600001)(107886003)(26005)(38100700002)(122000001)(82960400001)(41300700001)(316002)(54906003)(110136005)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(8676002)(8936002)(52536014)(5660300002)(76116006)(2906002)(38070700009)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eDhrdFFKZWlUMFNiSEJTMmpkYkhtYkw1eTVhWTFkSVNpT3BwbEhjaGhpK1Vh?=
 =?utf-8?B?TkZ2SWp0U2pQTXZUSWI3N1ZNZlc4anJrRE9MQzIzNGVaRHdUWFRpTFY1VW5I?=
 =?utf-8?B?emU5dEQvL1VvTGVnS0k2K01vMHBuR0V3bXJpTWhHZ3RyVTVwVldXQWJPVVl6?=
 =?utf-8?B?ZU5tczVqVDllWXJRYlc4RUJoN09yd09WdGUzUFUwMUJPM2JnOUYvdGR0Ti9K?=
 =?utf-8?B?N25uNFh4ZmZ3Nm02bWFJQmFOMHdqK2FDWkRWd1hYWGhNcDVxSXBaQnF6TEtR?=
 =?utf-8?B?dmsrcXM1Qy83NmN6SmlJTko3QldKUnB4cXo1R1IyaXhNTThaa2FvN09TOFlD?=
 =?utf-8?B?Q0VFa2hRazVQTExwd2VRbmFPVW5hRmg0UWFZMWlFVHBmUFl4d0J2QiszTzZv?=
 =?utf-8?B?VWJlMWNsMkc1OWIrVFFJWlBmdEsxbXVEbjBlM0l0Z3REek5BQ3hvekc5WDFN?=
 =?utf-8?B?bldmbG4xb0g3TFBIRXpFUUpuQWkwNnMrdnhSMkkzSU1HWEc4MWZ0ZTVoVVRY?=
 =?utf-8?B?RCt1VjFKMVdWc0wxamJBQWJqTzcyYzFsVi9YZXVRTW85T0pDMnB4Q0ZFWFda?=
 =?utf-8?B?Ri90S3ZJR2dHZHRtQTNsRlIwM2RzTnRSRnFUSTVvN3JOc0d4NktkZW1ER0Qv?=
 =?utf-8?B?S1lZQTl2NlYxVDFQQ1Q1VEJITy95aXRyREdJS0NjajlDa3hhNkdJS3NvRXhv?=
 =?utf-8?B?WEpmblpuTEZUR3A0Mzl1TzZaZTU1RXkrcnd0dzZQdmNMU1huTlZSdUZaU3VC?=
 =?utf-8?B?Ny9oV1N0Rmg3czdzUDJ5bW1KenVyekdTR1RHbXJjZmhCYjZMZVVnSkpXZmZD?=
 =?utf-8?B?c0J2YmluWXV2WDg5eEt1YnZSREJwWFgwTnh2RTVwbTkvTDZrYWYzNjUzbVJ5?=
 =?utf-8?B?TjNCQkZ6K2diQ3orRlNNT2crRHNPbU1yYWZXNTBEaENlUG1rSGdYQXFnKzQy?=
 =?utf-8?B?RWdnenN3Z0lJdDNvbC9ZZ0YyQU1Mc3lzZ2pSNFJmaEFSMUdJNWNRdVV0bUJl?=
 =?utf-8?B?V0JzN0E4UFIwRU5nbER1UFg2R1pySTFSWlA3eFJhY0dtc3d0RHg5cC9VR2xM?=
 =?utf-8?B?MkR2N0pTblF1UjdPU1FNLy96MW1CamF6N1ZONUEwa3lFQlNSLzNSZEp1Q2hH?=
 =?utf-8?B?bmlCcXRid1k3Uy80UzgrZ25VUWt1VDQ2OXNyMVVFYVVOTlVHK0FmVENKRVl5?=
 =?utf-8?B?Tko1R2Z2OGJORFJLUTRUZ09hb1NwQjF4a1JxdEFwRHVHM05oaHgycVdzRElu?=
 =?utf-8?B?cXZ6WEFJRnQzYlRDeURhK3JMbzJvb3BGNWJPR3QxT2k2NWVaQlo3b2h2eVJO?=
 =?utf-8?B?dHBhMTB3MHVZdGt0RTVFOXQ0NmYvRGdSQ214K2tvWFhPMTR1SWphVzloRXpS?=
 =?utf-8?B?TzFSZysrcjIvMWQ1K1FMWHJ2SVhQSk52YlJYZGtoNTdMTmpXVlQ1NnhsYURX?=
 =?utf-8?B?WWYzMndJd0JvVHhTOWtWOGF4b0M1cWZwT09GUk02QVgydG5GNkxWcDlZTTcr?=
 =?utf-8?B?WGtFWUJodFdDWk1WajJRV0F5L0Uybkw1OEt4ejZQRmVjVVZtSndaYzltMGFx?=
 =?utf-8?B?UTRJbGNPZlpHM29KdjlHOXd4QlBSZ1lUZFpGNzFad0dHdEp0ejdaa05JcEdG?=
 =?utf-8?B?M0o0UytEMGhadFlub0o5VDBqTTVhVzRXMXJDbmxPY3FOSDQvOWZwM2NXT3dr?=
 =?utf-8?B?cCtBbEZXN3Y3WEhxVkR5Z3VzcjRZeUQ1dWdzTEpGUXVJM1pEL1lGSGtDcGkv?=
 =?utf-8?B?WkdoVWFEL093M01reEpUUXVCamd0akNBbVpNY0tUQVlTekpKU09VTGhlMkdO?=
 =?utf-8?B?dzFQM3BUV1Z3bHZMY095UkFsbnl0Y2p3WWdrTnp1TWhRelJDV0RXbW5mOExJ?=
 =?utf-8?B?eW85Ulp3em5hbEdQYy9nUlRIUkZiOENwZjd3enZ5Vjk2TjlyaW8zMjIxVzcy?=
 =?utf-8?B?cU9yVk1CUmFaZkpMb2hMeERRYkNaT1FYNk8rNmVPSVFEU2NTOGxlSzRvVUNE?=
 =?utf-8?B?Mk9QQkF6U21MTmRDSGQvSUtQMlJOc21welpNRXBuZmlJMmJnMkozM0x3b0Zr?=
 =?utf-8?B?NnRpbG52UkdQYkR4TTJKWFNWLzM2bWNVR016MzRTeWJyQkFCYW1aL1QzMm04?=
 =?utf-8?Q?hVB8oSRu2UchENXW68MPWQl0o?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EjdRxblOSvkj3S4DR2qutP+5QMUw7twCHapzGMOowY78DoeMl2n3oXOeb+iIc7PMeT4LfO7ru0o9PqzTySllBXfTPLrT/5af/2BN1C0L3eLHGkMYPYoACtdZN8z19IA4EIyDqfvM+OPdWFJRRX6rvc2/mWjE/RytaDVc+T7n/hOS6XLCUgsYuy2Wu1jtarNuhu2jGyhktvj/+VM1PBR+CBzRTRzdeQeuB7h+pUfTJOizJAax1us5aNVfOIcBMEmpq++yzld24QGaV3+MjhSGBCxLbi6C3FEjI6jD0MX53x4akBNM86F2V3uAk0E7LcsudWH0jdRCXXNvl4pblMcIPTCMEuXjxhR+MNE6LBtOBihTyjnzbJLV9jecHnbaQzHIIVZM5DMwnUhgSX9GWaOWTATq4MtDKfHyvjeWEltkI46K3q5Q+7kvORhOqpgLGqIKyJzdVuyTgPhfouy2z9pCgDF8ScOKUjV709BOIBouGmSo5M5GrCFaeRpi0fGwwUpalF3HVLzSgf3Qjbl21UwZe+jhs7+9R5aCsoT2FvnTQjnYoBochtCfdWfiiKggoCkZZFqzg5joFhjz9dBzY3vpPHJc3g4vyIKJT7FJgidT7r/qEcqRDILqmhmOUzyr+Zqk
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2ee97d-35db-48ba-4994-08dc07729191
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:59:42.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ChK33ja7f0IRGn8f3pOmrDJ29LIaImf9rtHcGvrBNukyul9mWGXgjd+42rb833DbusFwpUcALq80wM8I3Cy1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6878
X-Proofpoint-GUID: OxJbzNjlNZ0TC-zfmtCCUJTrx2A-HIqf
X-Proofpoint-ORIG-GUID: OxJbzNjlNZ0TC-zfmtCCUJTrx2A-HIqf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: OxJbzNjlNZ0TC-zfmtCCUJTrx2A-HIqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

ZXhmYXRfaW5pdF9leHRfZW50cnkoKSBpcyBhbiBpbml0IGZ1bmN0aW9uLCBpdCdzIGEgYml0IHN0
cmFuZ2UNCnRvIGZyZWUgY2x1c3RlciBpbiBpdC4gQW5kIHRoZSBhcmd1bWVudCAnaW5vZGUnIHdp
bGwgYmUgcmVtb3ZlZA0KZnJvbSBleGZhdF9pbml0X2V4dF9lbnRyeSgpLiBTbyB0aGlzIGNvbW1p
dCBjaGFuZ2VzIHRvIGZyZWUgdGhlDQpjbHVzdGVyIGluIGV4ZmF0X3JlbW92ZV9lbnRyaWVzKCku
DQoNCkNvZGUgcmVmaW5lbWVudCwgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5k
eSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRh
cnUuYW95YW1hQHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQvZGlyLmMgICB8IDMgLS0tDQogZnMv
ZXhmYXQvbmFtZWkuYyB8IDUgKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhm
YXQvZGlyLmMNCmluZGV4IDMzYmE5NmEwNTU0My4uZDM3Njc2Nzk3NDVhIDEwMDY0NA0KLS0tIGEv
ZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rpci5jDQpAQCAtNTY0LDkgKzU2NCw2IEBA
IGludCBleGZhdF9pbml0X2V4dF9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhm
YXRfY2hhaW4gKnBfZGlyLA0KIAkJaWYgKCFlcCkNCiAJCQlyZXR1cm4gLUVJTzsNCiANCi0JCWlm
IChleGZhdF9nZXRfZW50cnlfdHlwZShlcCkgJiBUWVBFX0JFTklHTl9TRUMpDQotCQkJZXhmYXRf
ZnJlZV9iZW5pZ25fc2Vjb25kYXJ5X2NsdXN0ZXJzKGlub2RlLCBlcCk7DQotDQogCQlleGZhdF9p
bml0X25hbWVfZW50cnkoZXAsIHVuaW5hbWUpOw0KIAkJZXhmYXRfdXBkYXRlX2JoKGJoLCBzeW5j
KTsNCiAJCWJyZWxzZShiaCk7DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4
ZmF0L25hbWVpLmMNCmluZGV4IGY1NmUyMjNiOWI4Zi4uYmU2NzYwMjk3ZThmIDEwMDY0NA0KLS0t
IGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQvbmFtZWkuYw0KQEAgLTEwODIsMTIg
KzEwODIsMTMgQEAgc3RhdGljIGludCBleGZhdF9yZW5hbWVfZmlsZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KIAkJCWVwb2xkLT5kZW50cnkuZmlsZS5h
dHRyIHw9IGNwdV90b19sZTE2KEVYRkFUX0FUVFJfQVJDSElWRSk7DQogCQkJZWktPmF0dHIgfD0g
RVhGQVRfQVRUUl9BUkNISVZFOw0KIAkJfQ0KKw0KKwkJZXhmYXRfcmVtb3ZlX2VudHJpZXMoaW5v
ZGUsICZvbGRfZXMsIEVTX0lEWF9GSVJTVF9GSUxFTkFNRSArIDEpOw0KKw0KIAkJcmV0ID0gZXhm
YXRfaW5pdF9leHRfZW50cnkoaW5vZGUsIHBfZGlyLCBvbGRlbnRyeSwNCiAJCQludW1fbmV3X2Vu
dHJpZXMsIHBfdW5pbmFtZSk7DQogCQlpZiAocmV0KQ0KIAkJCWdvdG8gcHV0X29sZF9lczsNCi0N
Ci0JCWV4ZmF0X3JlbW92ZV9lbnRyaWVzKGlub2RlLCAmb2xkX2VzLCBudW1fbmV3X2VudHJpZXMp
Ow0KIAl9DQogCXJldHVybiBleGZhdF9wdXRfZGVudHJ5X3NldCgmb2xkX2VzLCBzeW5jKTsNCiAN
Ci0tIA0KMi4yNS4xDQo=

