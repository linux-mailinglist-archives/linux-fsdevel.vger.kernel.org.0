Return-Path: <linux-fsdevel+bounces-13428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D586FADF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 08:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E4C1F228C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6614A87;
	Mon,  4 Mar 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="AW/tRL70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C417C73
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537437; cv=fail; b=C7GkGE2TP2btZmvPyXfhmuv/NM9utM3M81W7G3qm87fMOg0F/ITl9JNZUjdSHoJc465PCDdn2pDuJPI/D4yP8XgaEI3mSZ6z/ZCzLf7lVIyVGG2KKmSLBF4aeeDHJ+7z2V4yI4EnurR2cotb0YIUS0pbMy3L8ACBG5GYda49gYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537437; c=relaxed/simple;
	bh=XcZwZ9v0a9u3am4qU1bEazRwzGgcARPWtIvOicjQ1WY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=nn85KZoo69yJCZm8+pHPbSH/gRj0BKYiLwAjyEMvKHW+9ZUjfcC7uM9QwL6RWDNSotrfndTfzXJ2XanGtWLMqV8z2evT8DhmygGg5+U/FhmDRX/ylpvBAxUTggza0jCNXr46KQTMWuLamqXfbkSEhKT8Eo7i4sWVgGOf/+q8mBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=AW/tRL70; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4244FqY5030176;
	Mon, 4 Mar 2024 07:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=XcZwZ9v0a9u3am4qU1bEazRwzGgcARPWtIvOicjQ1WY=;
 b=AW/tRL70ausJAX1G1uz/IffT1wBquL0KtOW+vckxbIX1e4/auChAZp/n/dgtziEhFRxh
 tHrYxZbhY+jSmokhbRaDDjSlQ1bAGBM0au6wB1eHk5dAiBrvHGT9xUsR5Dqow7Ik6r1P
 GFQsVtrrL7kx9cDRepvTfkUTqxM/CTUQQzZGgMC7Mv2P4GvmY9fECRebJqlHp+g+igl0
 LNpMDKwfMuhYA08hXmP5owxVvMPQG8L/wwfkvSDRLzBBj97Esn4/2ql67mn9i2I74TG1
 OuOLhqEmFuUnobq+Es8/pRPyxiRENalj96ubs4Pp46xzL6HhA+hKdLdgVWCKRvn6g+cp gg== 
Received: from sinpr02cu002.outbound.protection.outlook.com (mail-southeastasiaazlp17011010.outbound.protection.outlook.com [40.93.129.10])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wktw7h96w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 07:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkR5zzctQRWPPmjqGG92I4WbQ26WZm2qzAlwO/W/yT39/OX9kdSJF3FMjaxKgYuU/otTwrYefQCyI8Hzp45GSiPV/R+8exqUhBJ8CqQLyGhnRsNN6rhdX2oEqRVN3sDXONmYfORdMAQE6iujeOebWBIt53YJyhlPXncfzttD0qKGGNfHyvRAKtTpLYMt7aCtus3lm6RGUKWJgeRpT+F5lB3PfiCeBs614Xr29I2MMv0IJq/pA4Y5w8RaviVrdutjK4nWiSNxce0SbAjuXK30SVQdd4fa3dDGVTSuQaIHJEofdHbla07sXJlGi1ltGV2tCpx734FleddMph9BO3UinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcZwZ9v0a9u3am4qU1bEazRwzGgcARPWtIvOicjQ1WY=;
 b=ghC8x+L5dgqQBWQBP1jpRvwfcG+VfKyGacDsjZQnCM5z2nzpDEbbZ2EJjcbQ6DCI+hGQ5qLtbqPky/8GW8u1KABD7tkc97vZrV/v1bTmO4kqwAFWOGX/WOMFf1ao15inS7hmxn9ynatNGVImNN8LvmQuudImGzA7cdexA32cdG+GSHvhpqhE6kGqFVlKfzhNYSNeEEi2aBdeH7FiwzrNOxIIp7SWfNeTOdbAAHFB+lVfbgo9zc0hsVhKyFDBAFvoasMBkbSY6FkPsHSsQCcSsBeT+NrSe8qqwgoviilPw8HuLNWpBs+KB0ZOt/6p82YBPGuAR6ctoDS78mSrGVVOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB6342.apcprd04.prod.outlook.com (2603:1096:400:329::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.45; Mon, 4 Mar
 2024 07:29:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 07:29:59 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Topic: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Index: AQHabfTBkMYHj72XUE6nA81OpkBY9LEnLUGQ
Date: Mon, 4 Mar 2024 07:29:59 +0000
Message-ID: 
 <PUZPR04MB63166D7502785B1D91C962D181232@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <CGME20231228065938epcas1p3112d227f22639ca54849441146d9bdbf@epcms1p1>
 <1891546521.01709530081906.JavaMail.epsvc@epcpadp4>
In-Reply-To: <1891546521.01709530081906.JavaMail.epsvc@epcpadp4>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB6342:EE_
x-ms-office365-filtering-correlation-id: 6f720524-1f15-42c9-53e1-08dc3c1ce5f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2af45zlbOqviM5mS/9lWdr0Gtiop1zs23Y44NmxVKjCZDhNsl36UQHSvmmWUCW9IuN84KiG8fIJrwSTolDUD5iuADVW5Q+sIy+eX9cRY2VCzVjeXjBvxlupwD/ZmO7OYaVQrPKZ3FwwDcFVNsND7gc70l9f96EpSDBArMJGak/hZsJRkY1hYDUfnmaCcxupVylYSNW+IeojGV2tXN5oVdf+TxoMkBbCm9I2T/h4EEk3Yf9U4baccB9WvHi1fNVeX96xFSdNSIRVtyUhUCEb02YhsDyREBpiF5PYjQE1/KDJoAmMNMyUYFXeDctVTIPMS9KyqidNTBCOWnwi+v0yzW+ox9KB6c9j72QKDenP2LzfxKrJgx1N+MeIzyKwZU/yMM6digzFuw6t5oVnXx1LhwQEHlIbV+7derPDcF53NWRtP3gwwIbnH3Ftkl8haRj1Ev88JfnIH+jdMQXMaevptJ7h1m/rfxrRgS3RtCogInPVcRSNPW/WhZgTc9d6NVhv12lMS8kkHM1fW2Wb5MR35M/gXGUZ0vA4zV79T1uxY4xYD+vfM5ESHB5QBua11AMHGkugE3jQwIuE52z0xt2zXQQheYULrmQ45Pj5/DOSXI7T+NANB4qbAT/nxOSROjaNNPB9ENUWjQCFUpqkCk6ZViu0CC1fOPxzdMXQWFsliIomL4ZJhWQ1Ff6wLskue2uq/q9VyM4reGJ003rVyn9qonowTxJBXpE4boKMVMCDe5H0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YkZETGFpeWI3T2ZmVzVweWVPbFBoL2dwK3VETnpIQUVJQlY2dTJKV3pOWU54?=
 =?utf-8?B?VWRJZTZHeDFwa3c1SHpZbGkxWWJQbWwxTEVRMWVvMHZiZWx6QzdWb2VBMExW?=
 =?utf-8?B?emhRbDQveTdOTE5HV2JrOGRsSW04WTZYZllCd3QrOUZCMEc2U3ZFc3pvNzZX?=
 =?utf-8?B?UXpYTFNDb2hTUFovT3BwYXpaUEJvOFFzMlp5aW9oZkIwSDhGQnRHQitTNXZo?=
 =?utf-8?B?TXp0Y1JIamtjTUF2UCtRdlIwRE9OQUNaYzhEL1JEWStkbnFWaHB0QmYya2Vr?=
 =?utf-8?B?N1VJTWs4Y1ByZTRKWmlJRUN5N0hITEFKVFU5ejNFYU5LUUkvWkNDVzJyYnhF?=
 =?utf-8?B?RDg2NzdGL0E2VVBBU0loS3F3YU5TNkRXS2ZLcE80ZS9ValN0bDBjVXJOZk0v?=
 =?utf-8?B?L0lNZEx1UzZ2YzQ0d2NCQ1dMQXhVMTlJUlR1UWdwUVJKcUE4Z1VMUFRYd291?=
 =?utf-8?B?MnlaVlBNTzYwWDdJSEgvdkZ2VmNVc1ZzSy9RRkJKQW9pS1NoVktIYXBuSUpZ?=
 =?utf-8?B?VldDY2tuOXh4SWhrM05OK0NoQ2ZVaU9CbXhmY3VCZlc0TC9oYnczck01ams5?=
 =?utf-8?B?NHlMZXF4eFhyWmwrSlNDcEpEQmlZNUZTOEdaMjFUdXBLZURSYTg3bFlBUWJI?=
 =?utf-8?B?cS82WTgwQWUvSm9RbFFBWHp6blR4VFVrM0JwVmJnVE5FT1kyVkpVT3pWUU0r?=
 =?utf-8?B?NUczNHdsVEpWUFlUeExsTmVlWDV6bVBQdEdxVEY4TEVKRWhLc2tPM05LUXBi?=
 =?utf-8?B?alBXb1hiVi9scFBqc2hsODNEc2Q1ckdZM0xVbmlFMGl5eE00QzVvNEdwMFB2?=
 =?utf-8?B?ZXN1OUxwMWkyZ0g0UkNvZExVTTBCK2N6cEV0bytNK04vQkV1M05kTFZrcjRv?=
 =?utf-8?B?dlM1MDBwdTNDeGNOeUtSR1FvaTNrSkZtU29IM2svWGNjUzdvRitsTkFGemt3?=
 =?utf-8?B?WTZ1SUsyQWl5K0M4YWFGSnpRTXZ2VWFENTFrUmhUV1ZVVWtzWCtuNFhYYWp0?=
 =?utf-8?B?alIxSTE3ZE5LWjFpUW1uNFlTaDk5RCtlZmR3S1VkNkpKdG9wK0syaFpEbUhI?=
 =?utf-8?B?S0dyMUl5dVNncXJCU0s1c1JQMTRKc0N0N2FwcS9IYXk0SmVvVXg5ampsUEtX?=
 =?utf-8?B?blZxS3FTYjFkRCtLbjFydDNValVKTmt3d25wa2NiN1hJSllYV2FoZDhSaFVR?=
 =?utf-8?B?NUkvaUJKMzRKcnRXRlNpMGdjQnNPQ2FpUkR6TmJDQUVtc1VTNm1rdEJBZ2sy?=
 =?utf-8?B?VDdZMnpiN1FPOUdOcEl2TTg2RkM2cHBIclBiNXBPbi9EdmJERCtrcG45QlJy?=
 =?utf-8?B?NXUxbUpsQjhwMm1FTFpGSExyMXY4YVBSQlNPUmNXZGwvdHk1bXVtNFJGczBy?=
 =?utf-8?B?TFVsNW02Vzl4aW1WK3lucmwzcTBWRW9KbVE0YklXZW94bUtNbVNLbXh6aW8z?=
 =?utf-8?B?eXdadHJrUkp6SHI3NEUvSUU4dUxaVEQ0MDVrUGlUb3BqMHcweHNYbnp5OW1U?=
 =?utf-8?B?VzJKNlR0b2t4aUx3SnphZk13WU9kbGY3a2V4VzVrVnRNR0ZTMTJQemJHMjh4?=
 =?utf-8?B?YjYxNm9yRlJxbTMyQ1BwRUZ4dTkyQVozbjJJS1U5UXJlOHY3RDB4Mlc4UUVn?=
 =?utf-8?B?empWTFhkUElhVkcrNGJJaFdvUmoxRjIzWmVGQzVDOEpRaUVQM1JVMzhrVDh2?=
 =?utf-8?B?NEQzR1Z3OGQvN1F1Z01NZElPZkd2eXRoU3ZaYkFVdWFaT2hONEpFL2NsVmR6?=
 =?utf-8?B?SEV4eXUxUzFNNEFXRUlBU0w4QVJQQklXQWFDc0dUdVJxQWdqNHpOOVhCMElY?=
 =?utf-8?B?QmRyUGRVZUtmTHpvQmxycDdIOXhub29pem5pU1ozUUo0Ritiby90N0g3NC9K?=
 =?utf-8?B?VHdnZ2tmSDBMTnhNOVFZekc5ZU54MmtYb0lYOHFWVEh3amNGdGRCUkxCekdX?=
 =?utf-8?B?b3FmSG1FaXFjc1VGazUwU2M5TE5TMFJ6cEl4bVovMXRaL1hWeTFMbSt3RWRN?=
 =?utf-8?B?OUI5cXdFWXhyZ3RlVkFGYWh5Si9ZaGVXTzFhQ3JmbDk1RHFCcTVjbmxSRUhn?=
 =?utf-8?B?cHNvdFNkYm1jZ01LUzV0Mnd2cVUrc0RwY0E4eDl2THBpM0V0WDVoRnYweUhM?=
 =?utf-8?B?cm9yQXV2dW15MVlOcXFNQzAzd1o3MHN0eS8yUHc1Z09uSjllZWxJRG9WNHg0?=
 =?utf-8?Q?UcnT19bZLPCCUq1A08K5vAs=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3FLXgL9of9yqeq9mxaWseAP5gcfAhFUl6jeDv1zq+lBUx+NqIXO+JK3M6JASDT0+BTQUffSe6o0OOnZjkpWjJpiCz6iEfEE88DJRoZ9XYxyJoHSi2XwFkAp3l1jveoKpKoM3I6u0fA+w/Caja2/d5edhnssuMol5HyZsnxVSlgTi6bUMNoi4l9jgp1Dq8xuiYhoBJbEPU3VBt6lTBvURj8jnw4JwsfEIES/25aqoX1/sB5hoqYpGWireofzA9jblmAPMPGx6ruPeuKPaMbnpSpGk4z0l7yFGKQ0xpvJ8BtvqJPWLizHk7MOcKBT2+w+4Ob7/pOrNUzZ9/RDVkZCyGevnV7JHxoqt1s9ucLcP13ljgo7w0oMm/LekySq32DQzkKWpZOGPVFb82T/JFqdx6Ttfd7YGNUZZhyer6bn7RV+2VfqgF4Sap3Ea5WhoZKV57iGUF5q6GbbQvEVf+LF5aNx3xTmGryMoa2wwQaU6Fmi4pUMyBuj0FF125Zt/grtNN8QXunGNi/l0FHzISq5E6GHVJfCvBG1SCyrES8tp+Z2dAlYhkRCSZ1Q/jiENUWJZMHSWJ9yFs5yehoV+LskG/1j0sOQ7B7UlyL4xTZDUSfljk/S4BByROOnJo6yLHAuG
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f720524-1f15-42c9-53e1-08dc3c1ce5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 07:29:59.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xY43qPvd0pjzvYIZhzhQ7e2eLBehoxluTylmCL5Q1uvp2ogx/qYRf557uGwhITmEASQGDWRSspslAsQ92Sykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6342
X-Proofpoint-GUID: lQWKaEr4mJchWo_Wc442XEmqj42ykSgk
X-Proofpoint-ORIG-GUID: lQWKaEr4mJchWo_Wc442XEmqj42ykSgk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: lQWKaEr4mJchWo_Wc442XEmqj42ykSgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_03,2024-03-01_03,2023-05-22_02

PiBGcm9tOiDshJzshLHsooUgPHNqMTU1Ny5zZW9Ac2Ftc3VuZy5jb20+Cj4gU2VudDogTW9uZGF5
LCBNYXJjaCA0LCAyMDI0IDEyOjQzIFBNCj4gPgo+ID4gVGhpcyBwYXRjaCBzZXQgaXMgaW50ZW5k
ZWQgdG8gaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2Ugb2Ygc3luYyBkZW50cnksIEkKPiA+IGRvbid0
IHRoaW5rIGl0IGlzIGEgZ29vZCBpZGVhIHRvIGNoYW5nZSBvdGhlciBsb2dpYyBpbiB0aGlzIHBh
dGNoIHNldC4KPiBZZWFoLCBhcyB5b3Ugc2FpZCwgdGhpcyBwYXRjaCBzZXQgc2hvdWxkIGtlZXAg
dGhlIG9yaWdpbmFsIGxvZ2ljIGV4Y2VwdAo+IGZvciB0aGUgc3luYyByZWxhdGVkIHBhcnRzLiBU
aGUgcmVhc29uIEkgbGVmdCBhIHJldmlldyBjb21tZW50IGlzIGJlY2F1c2UKPiB0aGUgY29kZSBi
ZWZvcmUgdGhpcyBwYXRjaCBzZXQgYWxsb3dzIGRlbGV0ZWQgZGVudHJpZXMgdG8gZm9sbG93IHVu
dXNlZAo+IGRlbnRyaWVzLgoKV2hpY2ggY29tbWl0IGNoYW5nZWQgdG8gYWxsb3cgZGVsZXRlZCBk
ZW50cmllcyB0byBmb2xsb3cgdW51c2VkIGRlbnRyaWVzPwoKVGhlIGZvbGxvd2luZyBjb2RlIHN0
aWxsIGV4aXN0cyBpZiB3aXRob3V0IHRoaXMgcGF0Y2ggc2V0LiBJdCBkb2VzIG5vdCBhbGxvdwpk
ZWxldGVkIGRlbnRyaWVzIHRvIGZvbGxvdyB1bnVzZWQgZGVudHJpZXMuCgo+IFBsZWFzZSBsZXQg
bWUga25vdyBpZiBJIG1pc3NlZCBhbnl0aGluZy4KPiAKPiA+IFBhdGNoIFs3LzEwXSBtb3ZlcyB0
aGUgY2hlY2sgZnJvbSBleGZhdF9zZWFyY2hfZW1wdHlfc2xvdCgpIHRvCj4gPiBleGZhdF92YWxp
ZGF0ZV9lbXB0eV9kZW50cnlfc2V0KCkuCj4gPgo+ID4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChoaW50X2ZlbXAtPmVpZHggIT0KPiBFWEZBVF9I
SU5UX05PTkUgJiYKPiA+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqDCoCDCoCBoaW50X2ZlbXAtPmNvdW50ID09Cj4gQ05UX1VOVVNFRF9ISVQpIHsKPiA+
IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAvKiB1bnVzZWQgZW1wdHkgZ3JvdXAKPiBtZWFucwo+ID4gLSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGFuIGVtcHR5IGdy
b3VwCj4gd2hpY2ggaW5jbHVkZXMKPiA+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB1bnVzZWQgZGVudHJ5Cj4gPiAtIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICov
Cj4gPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZXhmYXRfZnNfZXJyb3Ioc2IsCj4gPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgImZvdW5kIGJv
Z3VzCj4gZGVudHJ5KCVkKSBiZXlvbmQKPiA+IHVudXNlZCBlbXB0eSBncm91cCglZCkgKHN0YXJ0
X2NsdSA6ICV1LCBjdXJfY2x1IDogJXUpIiwKPiA+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZW50cnksCj4g
aGludF9mZW1wLT5laWR4LAo+ID4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBfZGlyLT5kaXIsCj4gY2x1LmRp
cik7Cj4gPgo=

