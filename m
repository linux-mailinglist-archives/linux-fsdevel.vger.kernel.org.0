Return-Path: <linux-fsdevel+bounces-50098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F68AC8233
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEEB4A4F0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49E22D4F1;
	Thu, 29 May 2025 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EU5wGkB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097061CCEE7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543690; cv=fail; b=cjG+057gM0Gk77RSQpS5om4mZFZ6wAHkuBlM4ZyoC2MxzByqKAGJ+nJvjqJtRmlM6yDOdlvIH7EDMvZlPdmIc1yRRApEqcUfbHz/JqrM44ycltyAN1INVwD7crxQwdy5BvR15imdB+Yq8bgbSOVfS19Mcxmcu9/WTvRKWaFar24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543690; c=relaxed/simple;
	bh=Wj21c7yzLGfi5N7k0aboio2uusW0vu/lcalxJnCBPZI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=J72/+8sLuUTKsO3hDoOWypq3zd6+s1m7DEFd+zqpGCiLRez8YduyBzAD7howYbGD+wluFL77kxQk6aRbg6CeKDvodD09a6bQfFMnDsQ6PLLkeFuOf6NkgRKzdBAhMx9d/OOdnYDfvXNK87QR2GN1/cwWduauRoLH9YYcy1dHauw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EU5wGkB4; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TBTvnL021413
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 18:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=i0JrMP3dZCEbSTH2qr3RBgLZe3woP2M5cVBcAx4P4QI=; b=EU5wGkB4
	J/bc2waet1j/fXYzpYO/OaU87kyenTSyiMBxI+6RZuaPJWbR4tAN/iYUACNbZHar
	G9pz5nH7d8WGTeqIBZG3VKZUqMRDJDoAhQn3eqhLUKbO29Sod4ux8h8vZfn0kBye
	N6UHBsfzi3gBqT/0IloRzVtoree9SHnC0aI0KuVrZYQKjueW/lwuZLldZ4ZG185e
	km2yD6mGePWMavNGWnqiSW3obbhypNM1+96X0cYnOqeENINlEHIMv2qUrys6LPtO
	/2IIixECLbFZcPWR1HsSUCAYmQbkRGkFLOgHV0AVnTrOkW4bh221iPJvxhYflGkt
	6rEI3K+FhK4POw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gq9s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 18:34:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54TIYkix029166
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 18:34:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gq9ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:34:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54TIYkiw029166;
	Thu, 29 May 2025 18:34:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gq9rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:34:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMTJ0oYAAva3LV/vnIDVbopf3qEFAxzZ1EVWQOWPfkeT2kabhDVdhgP/bkSM2vjBp+tSmnG2Vn0xQNyFuhrkM2VQLz6MblHef4Rbvmn4UGw9eF+MQoY593lq3C5Uiol0zGYkRV+b/pJmFQwp+NC8P85S93qAh1hIx5iHpfsvZVw6KTDM2NK3sFwK2uSkRPreybK/gOEtG1YbBxtE/FcqDvoNrbqEAjDmDnKmlYN3gB4hpdDRYvO4Jrfty1iKdKoWG4/TPXifwXZHk08eTK88rRKbXiB2tMARS6MA4v1OYJSuLmBBDn/NhVGuVxUB/gR/Yqpbpovbh3OwUK9YEqIodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp31Y58uXee4zHLaylYQdZLRQzJc/+f9NK2AsW5Qq/M=;
 b=jRqtU5iG06M/hsYGIMYllF5LQcvhfjP+rpyuFPKDGV5eTxl1vzFXY5l3WAzJAr8rNEGMvs/8tVPj+TGX8rqjtV7gAiYoOYjUIiWPtcsdDZnNOvXrD0fWP4B2lh+E4r1KziplMqdUkDwz9g8nKO83pY8y3tMbU9WY8IRC8QvF3+FwOgO/CbUSe+/UAhBohMbn/a9qkpy95k3ajlMBnof8iekYLm0025KFoPeq5kTpBMKCKpLhDRRE0qXaxRGLpgXatVCHzoBMyGGVKdm/UDnBfk4vKGSxrbak3gBzNhWPOko4YjoGd17XwJ1eLcwlW30Gg+KrgzG5BewaBYkuMAsXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PR15MB5364.namprd15.prod.outlook.com (2603:10b6:208:393::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 18:34:43 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 18:34:43 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ernesto.mnd.fernandez@gmail.com" <ernesto.mnd.fernandez@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com"
	<syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v2] hfsplus: remove mutex_lock check in
 hfsplus_free_extents
Thread-Index: AQHb0F69mPG3Oz/oH0CrKLzhGUPJz7Pp7/OA
Date: Thu, 29 May 2025 18:34:43 +0000
Message-ID: <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
References: <20250529061807.2213498-1-frank.li@vivo.com>
In-Reply-To: <20250529061807.2213498-1-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PR15MB5364:EE_
x-ms-office365-filtering-correlation-id: 906c6204-37d9-4962-b7a0-08dd9edf7b2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXlJNFpOaklFVEIrNktBMnB4TTFER3ROdmEya3hnVnVnSXJYbmQraWxtN1E5?=
 =?utf-8?B?WHlWOUYxU0IrREdOWUY3ek1XaFk1YXRIa1hxSWhWdHkyZHNNb1FxTmpkMUZk?=
 =?utf-8?B?QWJ1M2dFNGhSa01Ub0JDdVdKeUhEUjVMbW95TkNud0FhSEJmUTdaa2tUM2ZX?=
 =?utf-8?B?NXB2WU9rNldSTXVyTUUzaWRVYjRwMVpkM3hFWmEyWi8zRnJwNHg4VFBUWWt1?=
 =?utf-8?B?M3lGVThqRWFvemZ1K2kzd2VQNXpiazFrVzJ4d0ZZUTJsNjgyTDdSUXNSNDhw?=
 =?utf-8?B?YStCK004OFpvc1RXS0ozK1lSQy96SDNQTG1mOHhZODkvNFhrbkUySkE4Lzkw?=
 =?utf-8?B?UUgzTkFPUW9BWU50NDhuWUxPR0xuUlhmQ1JhWlk4NHVsNUZiMm9MWS90U2N5?=
 =?utf-8?B?ZVdQUUpxUkRDVUxvWWs1SHljR1RNNUlpM292YkQzejFaRmUxd2p0YkNTWVBq?=
 =?utf-8?B?dFRwUHZWeUY1aDZCU0xCYmhsTzZWZUVMUUxNb01kVm0yWkhsbExHQ1Q0TXlC?=
 =?utf-8?B?N1BvMHZ4NUZveHJEb2NDZmdMMnVzUzRScXBIUHZYRXgyYkdqa1FWcC9GQjJp?=
 =?utf-8?B?NDdIU0YveVh2RXhPSkRDVTJ3ZTVaYVhOOWR1VWhGTUR0ckVzWUhRbkhDRXJk?=
 =?utf-8?B?QUxNK2ErOEhhN2pKMDNDVDUxeThYWGlIU20reVZ5a0FOeWpFc0s2TExYbGp2?=
 =?utf-8?B?eG5hOVhBb1lHZkh3bVI4QlZqRFJ3SitzQitYdklLMWF2ZlRwcDlaVkpJUXhB?=
 =?utf-8?B?ZW5hU2s0bld5ZDlXS2FFTWNxWUhPRFRrbHEvTi9nZDNkNERkTklRbDRsVXVi?=
 =?utf-8?B?dFRxNTdWTUxHZk56SHF0VTdqY2lDekNMOU9GcWp1SDI4TXRGTzJKeDdWV0Fr?=
 =?utf-8?B?L3JPZkdoKzUvVWxlWk5nWldQNnVwVTN1R2U3YklVR3ROdE5KNlJCWmJ3Z3hm?=
 =?utf-8?B?RVNoN054QVFtb3U5S3dMTlhjQkM0MzB3NGpNN1I4MzNsZVIxTVcweklNNWpv?=
 =?utf-8?B?dDc2SUtYeUtoS3ZBNEtPanAvTTZ6cC8vaEt2bCtOTnZ2cWJkK1E5K1ZEYSth?=
 =?utf-8?B?eFRCOGZielU0U05FRGhRUjYvOGRkbGpRbWNXdXFORnkzbWdnM0NkODJvaDIr?=
 =?utf-8?B?L0Z0SGUrR0dKVU9oY21Jc3Nwd2QrNTFadHhobTJWV1k1Vi9iUlpGY2RZOEQw?=
 =?utf-8?B?dW96QytxdkQxTlNRYjVpNWhDSDRwcEhnQThINEZqOU9QZ2ZuckpyU3k2T1BU?=
 =?utf-8?B?ci9VKzdXNVp4UkZ2RnpENkdSbGtqR0lrY3ZrR2YvcEdBUWdrZUpqYmJsSWhR?=
 =?utf-8?B?WDlMYTFPcThSRzM3T201eURmd1pBTFE2UHpBUVN2VGlyaWNxaWlFYTZHckIr?=
 =?utf-8?B?dzN0Zm1ZRlZVcWxKVzQ4NjBoYVlzTWk0RE1OSXc1WERFS3dIZUd3K3U3L01p?=
 =?utf-8?B?Y2lUc0NsWnNLanR6OEpza3F5RDJOQW5TMndDclJVT3RhQ3JSYzZJb3JkSE9G?=
 =?utf-8?B?eHNqSjhyTjk5TXpZSG15SXkrOEVKS2NkeVNlU09rSXd0bk5EN3VTR0VzUFBN?=
 =?utf-8?B?UFB4Y1A0eEhvWWNUMFNVcGE4NFhCN1lDRVN1azlvbDNKNHhGYW80U0EzZzFV?=
 =?utf-8?B?WGJuV0FrWlVjVndPSHVHNUhkZmNhUTNyOGNCT3hwWUd5QzNVS3BoVUpwQnN4?=
 =?utf-8?B?U1dNdFlkd2ZCelhnNEJleDg3V1gzSEZlbGdOQ0MvOGkvOXZYd1NLNjlJeURQ?=
 =?utf-8?B?RUJqTnZkQmMyNG1URTZwVGhnVGx6RHVpRHkyTkd2QmlCdGJVdmw3eXZGSVNZ?=
 =?utf-8?B?dncrblFTM3RZS0IvSFdqSHp3MVlLOWVDQjN2cEtIVHpzZVRBclFhYUdySU1B?=
 =?utf-8?B?eTVqUGZ4RGtjR21yajJWaVhab1A2QjlwT3B6amVUQ3h3eGR1bVp3N1JZdmJx?=
 =?utf-8?B?MkM1SzBkbGxrVGd4YlFGQlE3aTV0K244OVdwL1ZRZnBwdVdlUVo0TlZvSjM0?=
 =?utf-8?Q?UQY2Den1hkEX/eSTTltKPfROzm20h0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWx3bzc2Nm54d3BYaVVjb2lLbjcveFlrem5DYVU3eUNwZHlvN28vQU9kQnk0?=
 =?utf-8?B?eGNRVUhNLzBtNTA2aHhXbG5RMDdlOEFPOGJYSWsyRzBUbnRBRjRpZHEyaHp0?=
 =?utf-8?B?ZGYwbmdCTDd3S0RGSkc0ZU1ML1FZOGM4NnFCV3ZNWW5iSFRCK1IvQWwrVHZt?=
 =?utf-8?B?Z1FrNXA5RTlhZCtSU3pYV1dOUlhIeFNobm1OOVBYei9jenRYRlY3dW1XaXZq?=
 =?utf-8?B?a2R6b3NhVkJjejZZR3cvNFJJcVJLbys5MEViUVFrWEo2LzlZRDJpS09FaHFK?=
 =?utf-8?B?SkU5c1ZzSmd3aU9aZFJFYXhaNFFxTnJxS3hDUGJtMUFvMzZlRzgxOHBxajBJ?=
 =?utf-8?B?bjFPNnFkQm5UMmxFWmRHRkE1NVZKVjBPdW1CSHdlZEY1VXZxNmp3MzlCK2Yy?=
 =?utf-8?B?eDVFelJtMm5veUdBd1FsREtDWkxMbHlsa2orMUpicTNHd0NVb2d6NXRvaU5X?=
 =?utf-8?B?U0VOMCtmeFpCOGwwUWN5dnQwTWJnTVRGS1gyYXZFaTJHWUdHWGpiVUtXMS9M?=
 =?utf-8?B?amx6aW9qcldieDBIT2I4OGlYZXAybHdVci9hOGxaTDl2dU5rRWI4ZGMzdnFh?=
 =?utf-8?B?bi9qbVJYd2x3eW5kTk50cnV1RHIxQlNqTWpyZlduUVBjUWZnQitPR3N4UHdn?=
 =?utf-8?B?MVd4bElPTHU1YUxPZ3BEUjJMSThNYUREWFVKMmFDbzBqZzZyNUpMd1kxMC9l?=
 =?utf-8?B?eTVUM3dSS3FMb0JkSEl3azhwcFI5em1ZWlV3WEkzRXBMelRFd0pDZnJXeDF0?=
 =?utf-8?B?RUJRZmJaWStRc00wK29IL1JWMGhudWhyVm1Nb3dTOTJOYWhzMkhqb3NzRDFW?=
 =?utf-8?B?VWRDdUt1UnhDemNPa1NwcEdPQzRvVDhibUxyVmhkK0ZXUjZjQ2lQenpaNlMr?=
 =?utf-8?B?QytBSFozU1l1NmFDOVZoZ09rdDUramd4U0Q0OW5IeEVOMFlSV0lvZFNaVUNC?=
 =?utf-8?B?T0gralhQQU96d0lzNEdPTVFEM1BYWkprdGtjN1hPQlNhV2FMRzZ1TkVSYlRq?=
 =?utf-8?B?TUpoblNDdVhLd0s0aHp3dXlZNS9iNE9KQ1dvTnVxeXJ3ai9SbkZYU1VBREVM?=
 =?utf-8?B?T3ZFcGQ4VldLeEREMWpCQ3YwTHhUUUxyd3ZVdE41WDZmeVBLZXdna2hzQnZS?=
 =?utf-8?B?ZTdiY0tibklCLzVUaERSTjVmSFY5UCtudFY2YWxkWVdZK0JJUFF4dXJwV2l4?=
 =?utf-8?B?L0JlUU5lNVh5dGJCUFZjdm9zMzd4OG5FZmUxaS9xZEpmVFBMQXJKVVBxUzVH?=
 =?utf-8?B?anpPVXZId1hjNUl3bm1FRWtobmNDTmFrV1hDYVRNRXJwUCtHK3VBUTdSTStT?=
 =?utf-8?B?V1ZyYWtXMEFUVmdiR2lYYWU2bTY5MWFYMUJQYUNqNjJVSFdaNCtXRlJDVmYv?=
 =?utf-8?B?WG1yWDRJa25JcXFUdncxVjFFMVcxc3JFeVhIZHlTdVYyQnBMOTZDeDR6RDNP?=
 =?utf-8?B?Mmw3c2s5ZmsxY2FNSGs1V0p2K0phWVJtM1lsc3BrNjZzK1hOWGFJdW5LRktZ?=
 =?utf-8?B?dFhDTnRaeDBIZnREekdpTW1lOEJDSWFLUlFhTnQ4enNuSG84aldISTZWOHB4?=
 =?utf-8?B?bjRLU3JrZ3ROWWlMSStET2pvd3l5UlpVblQxdjl1L1lJY2MzZHhqUVhWK0FO?=
 =?utf-8?B?UlI5bldJWDNCQTVBNElOcTNnN2dIeE83NmdUS3ovb2dHb2xKdUhudkdSMkFC?=
 =?utf-8?B?NWpleStyS2JtWmJ4MEFWWldoeC9xZ2VHZWNGZUxFdGFSeVhGekIySDlnTng2?=
 =?utf-8?B?THRtd0VWaFlqVllSU1YzRXFsM2VDVmJ4Z1hQVXlHQUZqajdGU0ZSQlVjL09i?=
 =?utf-8?B?M1Y2QXlEdnZtUllpTHJYc2FKbzJEZUE4MnYyK2pHNFEzYnluRnJuMjRQN2VO?=
 =?utf-8?B?c3AvdE95c0tMcURFT3lXNEdreDNtazBQdHBwdXZCSzl4Z0J3RUR0Y3JjU3c3?=
 =?utf-8?B?clBaekUyZUk5eUFsQXJ5dUt4a3lmRE1KRnp3c0paTDF5cDNMc2ZUMGdWT1Ru?=
 =?utf-8?B?Z0NOcGRva0FtOUhSaVRBZ2JlMnpiaUJBZklFMjRsckE3VW1xOEpYZFJFZS8r?=
 =?utf-8?B?YW43RVpvRDRTRzloZXplUXN3MnU2M09lVnRuenZkOGRwVUQ1YXV6c284Wk91?=
 =?utf-8?B?TnppRkJjTE9JSll1YXJ2NFlYNVhoY1hwT2gydGg0L2dpMXVEaHozOCtGWG1r?=
 =?utf-8?Q?8PUwmo/c+vSarnf8j0jpiBM=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906c6204-37d9-4962-b7a0-08dd9edf7b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 18:34:43.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPqf6Yur5eBuV5wxEBezi0D6cxdHz01WyT09PmYj+UTUC8dHmj1RLYOyWQbXKLRT+X+m868L09xtbWXNcCY9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5364
X-Proofpoint-GUID: g65_AlRcB6zSKjiwrHkj8dNMokwdiMad
X-Proofpoint-ORIG-GUID: CgMyLsUihobe-Q45ITbhgxsL1fLPqsWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4MCBTYWx0ZWRfX1hcTx4Bz9vmE YulQImGrARkCYWTm866zjjXz7zQ6RG7iOVZRlXvOkQxPoY9FJ5jiTT0eX5w7fsiTARM5SE3F9Yy QyP7fN7n18MVpGuWBL0fyZrJpGSD2oRpBmcQj13ywXZco8np8RcFMMJWsJKrtWtZ1dLlaB7e6Uh
 kNGMoEenZuOdLtrXV2kcCwoyYQvcphlElb/IKDZ+nMqvcS7Gf7fs+IKSOYTn3o+YUK3/zaJUIv7 yRXr0zvJpOClb4BTLo22h+64fK5P5tWKqw3B0fB5UACViuf5oQfvJb8UKuXu8M/KNgZfJevoTGs kvHlDtdet9d7zExrohmQ7E+073ZpPpWiDGGt7e0CRMceU1yeEE/Ju/CFyl6ON5sMItdbOs2uBdI
 VO3b7RzSZwF93vgQVcG/DsGZJYDS6qEwE9oxsMbQlfgjuVczFYVA8D7GJ6mHZl57/O9ZJM9v
X-Authority-Analysis: v=2.4 cv=UflRSLSN c=1 sm=1 tr=0 ts=6838a8c7 cx=c_pps p=wCmvBT1CAAAA:8 a=VOZANKfpuB+U6b2rFtvpMw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=1WtWmnkvAAAA:8 a=7xcI3To_FT2Oi6IfD2cA:9 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC23D81096B66E4E91808C286CB1105B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2] hfsplus: remove mutex_lock check in hfsplus_free_extents
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=99 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505160000
 definitions=main-2505290180

On Thu, 2025-05-29 at 00:18 -0600, Yangtao Li wrote:
> Syzbot reported an issue in hfsplus filesystem:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346
> 	hfsplus_free_extents+0x700/0xad0
> Call Trace:
> <TASK>
> hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
> hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
> cont_expand_zero fs/buffer.c:2383 [inline]
> cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
> hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
> generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
> hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
> notify_change+0xe38/0x10f0 fs/attr.c:420
> do_truncate+0x1fb/0x2e0 fs/open.c:65
> do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> To avoid deadlock, Commit 31651c607151 ("hfsplus: avoid deadlock
> on file truncation") unlock extree before hfsplus_free_extents(),
> and add check wheather extree is locked in hfsplus_free_extents().
>=20
> However, when operations such as hfsplus_file_release,
> hfsplus_setattr, hfsplus_unlink, and hfsplus_get_block are executed
> concurrently in different files, it is very likely to trigger the
> WARN_ON, which will lead syzbot and xfstest to consider it as an
> abnormality.
>=20
> The comment above this warning also describes one of the easy
> triggering situations, which can easily trigger and cause
> xfstest&syzbot to report errors.
>=20
> [task A]			[task B]
> ->hfsplus_file_release
>   ->hfsplus_file_truncate
>     ->hfs_find_init
>       ->mutex_lock
>     ->mutex_unlock
> 				->hfsplus_write_begin
> 				  ->hfsplus_get_block
> 				    ->hfsplus_file_extend
> 				      ->hfsplus_ext_read_extent
> 				        ->hfs_find_init
> 					  ->mutex_lock
>     ->hfsplus_free_extents
>       WARN_ON(mutex_is_locked) !!!
>=20
> Several threads could try to lock the shared extents tree.
> And warning can be triggered in one thread when another thread
> has locked the tree. This is the wrong behavior of the code and
> we need to remove the warning.
>=20
> Fixes: 31651c607151f ("hfsplus: avoid deadlock on file truncation")
> Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000057fa4605ef101c4c@google.c=
om/ =20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/hfsplus/extents.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index a6d61685ae79..b1699b3c246a 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct super_block *s=
b,
>  	int i;
>  	int err =3D 0;
> =20
> -	/* Mapping the allocation file may lock the extent tree */
> -	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
> -

Makes sense to me. Looks good.

But I really like your mentioning of reproducing the issue in generic/013 a=
nd
really nice analysis of the issue there. Sadly, we haven't it in the commen=
t. :)

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

>  	hfsplus_dump_extent(extent);
>  	for (i =3D 0; i < 8; extent++, i++) {
>  		count =3D be32_to_cpu(extent->block_count);


