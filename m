Return-Path: <linux-fsdevel+bounces-8692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A583A657
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0791F23D25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C2182DB;
	Wed, 24 Jan 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="EdappbdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B3182C5
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090762; cv=fail; b=Z2Au3DcU74UqV9hiukcvVmUfDFuaL6hRHTnZYTol12b7tXVdeqxfCeRSKe0vvNhLuYn/LiJcTpvHnpfmrvwrKho6E1mPFAZMhx4UMqyCcyAonK0JWabf2sGLBPPUpvQ3NKB0UL1F/HS/tEsBtzxSeCWEbThqvwQOgqRBzp8OQdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090762; c=relaxed/simple;
	bh=kr2Ue9q71q+gd/vqKhZdhyEK4XOIKUd7dYPSErH0iJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LX5EUFjJ0J3NfDIHOhT3QwjiNTdoLwKKUx67PGHSZ5PKOwjuErupyjQS+th14l9WHLKW93olatLTmN7iLfWhwDrLSzYV98klHEFhYu5SoK79VfrIt/w55nKWzY6rZWWDI1LMMwYu/5I3V9bGlgCgaFxM0P6deRVFQESJD7sr0Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=EdappbdM; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NLQ9aR023759;
	Wed, 24 Jan 2024 10:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=kr2Ue9q71q+gd/vqKhZdhyEK4XOIKUd7dYPSErH0iJM=;
 b=EdappbdMwuSQXh2iHKx+OylU93HkMiHiEAtsLAsyQGnpAbIBN20pOrAqqM+42y+ulLfr
 qfEoI1uvVTJ56Z7TPOTQXEaEl580xV4YA51tfIUHJjub0sIHanlyhrwcNIWrc3t4fd7r
 QzrJuPTCM6sIlEv6J9obgQ2MVnvAT2dFA5J1mcYnBUkFpG1K2jfoxLD1/6feVP+FPCcV
 1MfKsi7TZf8SFoimn/gph0Nhn9wq6x0eqVe6kZ13u3xpr9zcEclroppBrQ61Z5ogIFqY
 Adz1UTaiIevBwFFO1PJJU8rnr683S8U6xad4JcnS3ubK2CL23GGhJsnH1QPnMShmlQrZ 6w== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vr7j5c9x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 10:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3sL1LnZEUWnnuumF/L30Po6JaaZmtHcYPbSQNvcAolKr8Ece23IZGSlU6ZFlCm+oCNQCEyH+EYUlDzgywh7fcUTMau7GA7fK8STtj6oAiHFWNoVQsFyTjKDLY6Y26uae88EVYXGP/d3YifuZF7wDYaA5lRt/qMxLrOFKjFzjL3cXwvIZHk4MwwoQPQgrf9FVx8dpiii6WuS3gIlH4rAp0Cl7wt09hyZK8TWsXCUT1kTjPWVpET/KkZDd+qE7ORAy7YDTojN/qihIjvmpBXsHYGHmyOoYOs9vuR7fiN1nJSWG1PggOKMqUnUCWTWi8NBuf6cr/ReMyFVBtKi/1obPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr2Ue9q71q+gd/vqKhZdhyEK4XOIKUd7dYPSErH0iJM=;
 b=M+M2DV2P3eQWJUt/gsjSktDygdGtjL8r/OKaLFUH6YRpGNfphHAUsbq8Wh8e5quIfqpaHPeVKXNVP/MG8wt5MnMlZjwGP3NngmQaWbHBNcWX+SETV0DnbarfkKH3V86BJRv25xJe42Uybp/am5GHbTpNOARbg0eLdKlCHHSx9e6e41neIxWeqZMS2D5yRf2yk69J93FFLR/VFJyVfXR4aOW1WwmX2CIohURtUpmhzVAwD3Slg5yf97n5fBAS3N2qR26lDO/IBaQEKLu7aPaQ+54ZCH2UnpFweVbXg1ing5bNXUcTUce6O/Rji0wGKahv/jSWfYe/UOW9opjl5W9VHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB8507.apcprd04.prod.outlook.com (2603:1096:405:c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 10:05:15 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 10:05:15 +0000
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
Thread-Index: AdpN3FSy7vLvoUe1T5GfQPH9ulVGdwApZEFgAADSXYAABhDDoA==
Date: Wed, 24 Jan 2024 10:05:15 +0000
Message-ID: 
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
In-Reply-To: <ZbCeWQnoc8XooIxP@casper.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB8507:EE_
x-ms-office365-filtering-correlation-id: 682fedab-bd7c-4a98-0014-08dc1cc3f636
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hzahU0+B6CcUfR0F1SYjJmB5Axgrr+LiYEtzYeFtdMfxxFcLkBxyae21iOOxxPX+3AT9db1Mbtx0xBOYkAzj8k3Xf1LtobIrxX/FfB6/uxZ4EJH+7IqQOCG7KT+8vNbXvI63YeRgXwYlnZA7llH7j7N+Qhk7yxBrsgLFzvRKmdArmYQJWa07DtREKp+VwXNWdOhEHf/q+TyFJbf2r00QNLlLsAaw6pXZIAdKmJHO/+sEzkiXfh9HFhH4wFw0/p7Y0PkKgoa8Wap3Ic69H4RErqcBpSSNTpr4vmegwKjoZj4vEgjgJf7O9JVMPXtoQgB6HGn/ZZvkpmn1Uyksl3DoXdNsh/OIPdJjdw3bHEPlppH9myIRA2PD7L0pJDHfpV+JrB8uTkeO35tF3iwSez9KBaCDfImiaj7SMs1k+HZTGFTM9UQAFurFkBKBXuYPvGEsGYomJYwl4O58dRYng/WhJh6vC2gaxjVi7CZmYYKfDuPQcd+pg/H0sU/+eKzC2PWP3XR6iwpvUI+rTqF6Xul6A2TZU+EYG1MR3+9xVyx1NREpIa+8PLgK+IY3Tb4owaDq8kYucznvZa50x2hvyeHZ8L71ZNT4BhZQxTt5wYSbUe/e6sbUA0sQvMKI2EcNz0+o
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(6916009)(66446008)(5660300002)(66476007)(64756008)(76116006)(66946007)(66556008)(71200400001)(26005)(6506007)(53546011)(7696005)(9686003)(478600001)(54906003)(316002)(52536014)(83380400001)(4326008)(2906002)(86362001)(38100700002)(122000001)(8676002)(41300700001)(38070700009)(82960400001)(66899024)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L0xFVWhiV3V5Vis2YTh6aExVTDlxOFBNenVwYmxPdmQ5NWNENWc4R1pCa2VG?=
 =?utf-8?B?SkQybEdQbEhUaVBzTWtxT2hLN1kxVnU2VmFZTzBQc0UzTVVkZFFPRzBNZHJl?=
 =?utf-8?B?VnhOTGplZE1hQjJpYTRRdkpSL1VVQ1UzdWZhMVN1SzMrOVBKNlVHY3RBdHRr?=
 =?utf-8?B?dFNZdmNBdzczaXNIaTRaU01uYnFhZHRyWDBLRXRtRWJmdkVrWS9BM1BSMk5C?=
 =?utf-8?B?QlY3SnJXMlM0aVhnTENueUhIcHBJeVlORzlwZFJUaFFTMnU4cHVOMkZCTE14?=
 =?utf-8?B?ZExYZDM0eWp4N1g3aWMySkd2T1ZhdWVuZld2VEx0ZTU4QUF5WExCTm02STFD?=
 =?utf-8?B?aXc2aE51dHhFMzhzUGlraHQxaDFrdkRJTkJHZ0lTTjNMQ1JhZTVNOUpNZE84?=
 =?utf-8?B?aFlYSFZDQVZCekE5NVRTS09tcU4vcjJTRmJubFk5bU9PYWo4SHl6Q1Viejh5?=
 =?utf-8?B?WWdGUmV3VUoyU09aUFJTbTEybmxNcndmZ1hENWRXMFZ1NlB0czZUcFRNV0Qz?=
 =?utf-8?B?TWNpMG9sN0tMS2JVM3ZxWDNrdjhEYngrUmk2eE5oWUF3bzJ4UXo0Z1RMMGts?=
 =?utf-8?B?KzdnU2VqYkJWeGNzUWJLMy8yN3AxenUzTTFlb2RjNkdmekNBTnl0UTlIQkh4?=
 =?utf-8?B?NVpWaCtqOVc2bXlmM0VtalJxMlArU0t3VnJtcERFcnp0bG9CeTJ1QmljM2FX?=
 =?utf-8?B?ajd4MWJLQXU4YktNNWNtN25hM3lhUWQwQlo3TEZwZDUzRFdOdGZWQmpkYWty?=
 =?utf-8?B?YXM4MmRMdTJkcUFySitVZUtCZzdzTEkwU1VuTHpxQ3lOV1RtRzVoM3g1amgx?=
 =?utf-8?B?T0FSTkR5S3pxSzFSelBkNmJ5T2tzdkVDWnVHVkFiWUYwQlFNVGZzdXRabC9B?=
 =?utf-8?B?K00xQTl3WVA3cEF4c1NybXdLMW11SWxncGtEUXJDaGZjaVZiNjlJZnJzV3BG?=
 =?utf-8?B?WlRVVW1wZGE5Q21pc0VPR1h6MUE0cUxqdFRqSndaTS9OWkFJUHRha3d0MDFj?=
 =?utf-8?B?OGVEUW5SdnVIalJjRW9ka0ptWloyb0FHS1FMdzJvTWdkV2h2SjZxaHR0MEhq?=
 =?utf-8?B?T2h5Z3BaZWFqZWgyb0pUaXFtTml6UStqSEZ4NHQ1YWZaemx2dTF3WTBuTXZI?=
 =?utf-8?B?SlVxS2FzNFBSa0JNdldaMy9lUTZxUDJ0SEVwQWtkblljSzNkYkt1eGY3ZllL?=
 =?utf-8?B?Y0RWb21GMHBHMWIxRkZXSDFaSWZVVmw3L0c3VUZzU1owSFRuTVBjTHRia1VQ?=
 =?utf-8?B?RzRXZy9oeXVlVjg0MUNBZndRSmg1dWd5QjNudkhKYXVKanYwZlVkWEdBQTZw?=
 =?utf-8?B?K0tIMGtvNFV5aVF5NldDUUs5eHFxT3NsczJud0ZyQ0J3ZDkyN1ZUUlZQb0dn?=
 =?utf-8?B?TjlqQnFYZmZOWkhFdjMxVmFxT2JsMDRrdENhUnA3WWlvdDB4VWFEZzRwZTRE?=
 =?utf-8?B?ODZjKzlQZHVtV2NNaFhYdUtUYnpBdTBGLzhySHQyTHN6VTd6QUM4Z3BaVkVn?=
 =?utf-8?B?WEVrZFFvc3NFeG5Tek05K3RYNFZpTzVMRWVBOHFYZWpBWXpwanROaHFhenV5?=
 =?utf-8?B?eVJtMnd4cHN4ZTMvUW9pbFNWUzAzY3VXeHBqUDE2SVJDTmdDVDUrREsrVS83?=
 =?utf-8?B?Y0xSM3J4Y1RONk5uZHhBT01FOGZKSGNxWTBQNzlGaU9pcis2ajYxSExUdTRW?=
 =?utf-8?B?LzU1YzVLNlo1UHd0Zkl1S1VUTytuSzdFaXlqT0toQlNGbE13eE4weUNNbXhu?=
 =?utf-8?B?MXV5aW5iMkJ6dEtROHNVWTRUTHBJd2ZJOXRLSXJMU0p5RzJIbVRZaUhxNkt6?=
 =?utf-8?B?S2VPeTVrQVJJWmVta1pzNXVQWkpzb2ZKSW9sWThOUDQ0N2FvWitGMmFwa25u?=
 =?utf-8?B?YzU3Uno0eDJJUjJtWUh0ZjNOOGhxaVpWVWhka2l2OXo3VFh5NXVRWk40NE4z?=
 =?utf-8?B?SEFMZG9DR0xzUU1NckVOT0dZVzZqcFpaaThleW5OOURsQXM4UndDYWJidk9m?=
 =?utf-8?B?NzFqRFVRT25KcmcxL2xMcm9CaDE3MmpEV3BzVjl4K3dabUUveW95anNLYWZW?=
 =?utf-8?B?ZHMrbHlCU001VXRtbVA2OU42Yk1Gb0o4cHZCU1pKTlRwZWlXNWV0dytlVDlp?=
 =?utf-8?Q?veXLfTWW66jy9/XuvJbyiBd7/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mtYoHw9prNBDbrIaxacxr9Oo18XVkwWLJtxEEYeHqZKN7gHIRqi1E/QGMupcz6yAgMvjt6XLCXfMCxwOQWFcK0sncXAVpgoDixM8WdMEyv9NpkNHvj6n/GoyGY2Oa6yA89hKsq5Q72lNAEb1aliNGh7poU1EwPYD2QIQLY2yGvnYfsH5vNbVZU+2HUW0dPpYyPJ2xotUV55nQI9HzM8ddBybO4hzJnd9kAz6w/osABR/SMAI8ks1dZXd63nsKemQ4VAy2iHOkgzI93cgidg2p7cUWEpjXyZnuZlfVtf4tbJcQJBQjjYpIyYnxtQfMqoxnucsHR3HcFD4ms6CyvbTUjqSBsZqV9UEROe6xM00AXYWBV/DqauEHDUPdz4s3YswgLtERKG1Ho8+kfI9Vrp0mGCMaNExuqqc9iGXo1xHeqNSrlpjgepm/KhXq+vq9GWz2IxiPl3c+/P2iSCXjo+Xp1QK8PfF2Vs6xW94dd3hpSQ9y3uFgV+Af0IOmFPvliA4fLSGIDamHnw7NmbjKk9npWwAzllWbJRfAytHw5KdLgPhTowHXdqpWb6W0zdVHOiV6MJbs0rspK3tNPJRthc9dw9j1wm05FDOH4lEbVfhWmDCny8c52EDbaWf5khlpPa7
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682fedab-bd7c-4a98-0014-08dc1cc3f636
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 10:05:15.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bc0ukDiNrZHweW6OLTlv46LspaecBZ2ZVkcwvbI0IeVTJmha0Mxb+F1x9j6M6bB1jI8PNUh+MwlmAkbrjfOaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8507
X-Proofpoint-ORIG-GUID: 1yW1tgN3X-NJW2ouNhLGdVyvQZCYTPYf
X-Proofpoint-GUID: 1yW1tgN3X-NJW2ouNhLGdVyvQZCYTPYf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: 1yW1tgN3X-NJW2ouNhLGdVyvQZCYTPYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-23_02,2023-05-22_02

RnJvbTogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+IA0KU2VudDogV2VkbmVz
ZGF5LCBKYW51YXJ5IDI0LCAyMDI0IDE6MjEgUE0NClRvOiBNbywgWXVlemhhbmcgPFl1ZXpoYW5n
Lk1vQHNvbnkuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZXhmYXQ6IGZpeCBmaWxlIG5vdCBs
b2NraW5nIHdoZW4gd3JpdGluZyB6ZXJvcyBpbiBleGZhdF9maWxlX21tYXAoKQ0KPiBPbiBXZWQs
IEphbiAyNCwgMjAyNCBhdCAwNTowMDozN0FNICswMDAwLCBtYWlsdG86WXVlemhhbmcuTW9Ac29u
eS5jb20gd3JvdGU6DQo+ID4gaW5vZGUtPmlfcndzZW0gc2hvdWxkIGJlIGxvY2tlZCB3aGVuIHdy
aXRpbmcgZmlsZS4gQnV0IHRoZSBsb2NrDQo+ID4gaXMgbWlzc2luZyB3aGVuIHdyaXRpbmcgemVy
b3MgdG8gdGhlIGZpbGUgaW4gZXhmYXRfZmlsZV9tbWFwKCkuDQo+IA0KPiBUaGlzIGlzIGFjdHVh
bGx5IHZlcnkgd2VpcmQgYmVoYXZpb3VyIGluIGV4ZmF0LiAgVGhpcyBraW5kIG9mICJJIG11c3QN
Cj4gbWFuaXB1bGF0ZSB0aGUgb24tZGlzYyBsYXlvdXQiIGlzIG5vdCBnZW5lcmFsbHkgZG9uZSBp
biBtbWFwKCksIGl0J3MNCj4gZG9uZSBpbiAtPnBhZ2VfbWt3cml0ZSgpIG9yIGV2ZW4gZGVsYXll
ZCB1bnRpbCB3ZSBhY3R1YWxseSBkbyB3cml0ZWJhY2suDQo+IFdoeSBkb2VzIGV4ZmF0IGRvIHRo
aXM/DQoNCkluIGV4ZmF0LCAidmFsaWRfc2l6ZSIgZGVzY3JpYmVzIGhvdyBmYXIgaW50byB0aGUg
ZGF0YSBzdHJlYW0gdXNlciBkYXRhIGhhcyBiZWVuDQp3cml0dGVuIGFuZCAic2l6ZSIgZGVzY3Jp
YmVzIHRoZSBmaWxlIHNpemUuICBSZXR1cm4gemVyb3MgaWYgcmVhZCAidmFsaWRfc2l6ZSJ+InNp
emUiLg0KDQpGb3IgZXhhbXBsZSwNCg0KKDEpIHhmc19pbyAtdCAtZiAtYyAicHdyaXRlIC1TIDB4
NTkgMCAxMDI0IiAkZmlsZW5hbWUNCiAgICAgLSBXcml0ZSAweDU5IHRvIDB+MTAyMw0KICAgICAt
IGJvdGggInNpemUiIGFuZCAidmFsaWRfc2l6ZSIgYXJlIDEwMjQNCigyKSB4ZnNfaW8gLXQgLWYg
LWMgInRydW5jYXRlIDRLIiAkZmlsZW5hbWUNCiAgICAgLSAidmFsaWRfc2l6ZSIgaXMgc3RpbGwg
MTAyNA0KICAgICAtICJzaXplIiBpcyBjaGFuZ2VkIHRvIDQwOTYNCiAgICAgLSAxMDI0fjQwOTUg
aXMgbm90IHplcm9lZA0KICAgICAtIHJldHVybiB6ZXJvcyBpZiByZWFkIDEwMjR+NDA5NQ0KKDMp
IHhmc19pbyAtdCAtZiAtYyAibW1hcCAtcncgMCAzMDcyIiAtYyAgIm13cml0ZSAtUyAweDVhIDIw
NDggNTEyIiAkZmlsZW5hbWUNCiAgICAgKDMuMSkgIm1tYXAgLXJ3IDAgMzA3MiINCiAgICAgICAg
ICAgICAgLSAgd3JpdGUgemVyb3MgdG8gMTAyNH4zMDcxDQogICAgICAgICAgICAgIC0gICJ2YWxp
ZF9zaXplIiBpcyBjaGFuZ2VkIHRvIDMwNzINCiAgICAgICAgICAgICAgLSAic2l6ZSIgaXMgc3Rp
bGwgNDA5Ng0KICAgICAoMy4yKSAibXdyaXRlIC1TIDB4NWEgMjA0OCA1MTIiDQogICAgICAgICAg
ICAgLSB3cml0ZSAweDVhIHRvIDIwNDh+MjU1OQ0KICAgICAgICAgICAgIC0gInZhbGlkX3NpemUi
IGlzIHN0aWxsIDMwNzINCiAgICAgICAgICAgICAtICAic2l6ZSIgaXMgc3RpbGwgNDA5Ng0KDQpU
byBhdm9pZCAxMDI0fjIwNDcgaXMgbm90IHplcm9lZCBhbmQgbm8gbmVlZCB0byB1cGRhdGUgInZh
bGlkX3NpemUiIGluICgzLjIpLA0KSSB6ZXJvIDEwMjR+MzA3MSBpbiAoMy4xKS4NCg0KSWYgeW91
IGhhdmUgYSBiZXR0ZXIgc29sdXRpb24sIHdlbGNvbWUgdG8gY29udHJpYnV0ZSB0byAgZXhmYXQg
b3Igc2hhcmUgeW91cg0Kc29sdXRpb24gaW4gZGV0YWlsLg0K

