Return-Path: <linux-fsdevel+bounces-69838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8232BC86BFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361F53B0DBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AAA284B3E;
	Tue, 25 Nov 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f7R1NMju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5561A9FA7;
	Tue, 25 Nov 2025 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098178; cv=fail; b=OTSL5bJnW7xP2v6cu/Ei9GALu9Ok4dIZ+4DT95azvloZS9NVuVWaOwjPtvU+gNKBsQX/Hr1J1p3BHmyJ7A0IKZtlDMANmdzt8knkpHDhWGslN0p1UAnjydXOhVMbji4iTBUJ/Nrzhsr/VQEM830rA2Og3KJRpvLm5m6PDorQb88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098178; c=relaxed/simple;
	bh=UJvAfSBCXxS8yHTK9APXrtkXSKt0vgpvx1g2wLP0Sw4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=EUR8koEXCQkXaW0kyz4SRQbkMQR2T3v+XkFOYDUePquakvY/uhgVQOwcRJNz65nYVIkNkAAYbJTjhmcwFfoHHSRd+z5wk+GPLuTlhcqWKqjo7FASLtE5sJrfquEx1FmiejgheuXUrQ01jAeUpnRqY8gpSsTbBcqiLDO0p9R+ZkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f7R1NMju; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APImmMM027288;
	Tue, 25 Nov 2025 19:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=UJvAfSBCXxS8yHTK9APXrtkXSKt0vgpvx1g2wLP0Sw4=; b=f7R1NMju
	9zW1gX3mc1/k1t0ANZl9imp4MiPdBwFbhwV9TU7CcUJkOfBW+YLWZpmeQf5inRAB
	/W1lXHhlmo02JxiPLbIHk3ESbDafBQG34/+cVYYGVZ2WviwxFbucW4cYeefa1YUh
	R2wFEtOWYmh6PqJgcui8DIVnsYQTi4idrn6sff9R/T8X9/xlJWRtjYiRgjXnkOcX
	EVY4La3cYFDIZFMr/yRTjMlUlotXJ+OdC+6sz54314rHeMqyxG9IkXKxnRD6SXtY
	ERA5aAJvC899X7OPPZK9m6hzYTbIICoIbpnwuOxIFpgTGNLWMUO7P1dcLp9Xy1Vv
	lEznqpfrxFZYTA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4phypkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 19:15:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWW/QnnDTZ7J+vfppjU/2vvANMVt2rWk1zG1jhHKMZkzurvj0thYPiVX+IuXDvqd8mt/soTQKC6TDEHYp2nOl3GIaPwH30YNEVItXd2pkv59cmr//QYgRe+gN1klN+0yDtpFxKC0GiMmKwqZYrFeBXM9LsS5IoBwdjE3LSSlzr/UAwod/GVi0LsoxmprJZ+1+CN3vNWkSAQXDEEDisg/+Vsqtx85S/V8ionqM2mnKh7Jg1/N43Xe6CILxyRvTQflnHItTOB+smXmit15Xr1H2patTBhhrK2p5fpmlZFkdFOj0SneLyzsoPFE3YgsSuNBOcn8HTa8LlKK8suL0S1d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJvAfSBCXxS8yHTK9APXrtkXSKt0vgpvx1g2wLP0Sw4=;
 b=xQa4uvW3BZQbjSrBAFaOBZDY4REDD/x5C2ukPCZpksKgF5ytrj1mOraFqUsfGdjTd6qlbVnpmDSCWHiivho1Haa6m1eCcJNYdlGIAXoPhG83BimpVxt8QOAF0XVPtBwWoAVWFQm5cV9SfnWuTZsofQRAlPW+uFMHqJLaQJaUwQpFtWQoQZVUOpSr2nQlgI3FS5F0kDnJg7h228vuaTDaSKzPGRxyoEcRxDjY9uCp7nxUx8YFl2wUbyFPc+rDzXytbXfEF0Ci5Kd8ExVVN5/FKIILYAHZB2KSwJc/6x2lZjQdZnc82+nkoDBj+NmCQRLJmhvVIktHoN5Gq9NuyjsnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB5017.namprd15.prod.outlook.com (2603:10b6:303:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 19:15:48 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:15:48 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "penguin-kernel@i-love.sakura.ne.jp"
	<penguin-kernel@i-love.sakura.ne.jp>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] hfs: Validate CNIDs in
 hfs_read_inode
Thread-Index: AQHcUxpPkd/kQAITXEWhDP6QPRYmTLTuEp6AgBSAYICAAUabgA==
Date: Tue, 25 Nov 2025 19:15:48 +0000
Message-ID: <be86c750a1cd2ddcd3968237995f1e5162eb381e.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-3-contact@gvernon.com>
	 <df9ed36b-ec8a-45e6-bff2-33a97ad3162c@I-love.SAKURA.ne.jp>
	 <a31336352b94595c3b927d7d0ba40e4273052918.camel@ibm.com>
	 <aSTuaUFnXzoQeIpv@Bertha>
In-Reply-To: <aSTuaUFnXzoQeIpv@Bertha>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB5017:EE_
x-ms-office365-filtering-correlation-id: 7f7c031f-2222-4167-7b16-08de2c570a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlJDdVM5dHYrSmVpR3pDb0VnSU0vU2dHY1ZiZC8xZjZmaWRQU3VSZ3BZYTZG?=
 =?utf-8?B?REJZenlJWmh3S1pqMGxVTitZeWdGdXJOVFhxdHRJNnIrbk5QWHFCRW9MdlVU?=
 =?utf-8?B?WFh3ZGorN1FTQUhYSzFvVWVjeEFLS1ZVblVualdJb2RMRWNkWTArc0w3UkNV?=
 =?utf-8?B?UGduOGJXRHJlTTEvMmtyUTRkVVZBVTNHL1ExSEMrNk5BNy9KS0E0Qm1ZM0Yv?=
 =?utf-8?B?ZnlLazJzN0tGczRVb0M0eUI3UzN5SHJvcGlTMjRCclY1OTc0K2kyZE1KYXFO?=
 =?utf-8?B?cEZVZXNnclhzMXhucG5mbEI4RVRKRTJDNWpTMXRNL0RWbjBvTzRCRWh0eU1x?=
 =?utf-8?B?c01HRWF0dGp1V1RCUGppUDR5QUJzbmpmR05VMURISUp5UDQza3F6N1FqY0lS?=
 =?utf-8?B?U3YwTmU5Z1greXBZQjRjRXNTZElRelNES0tHSG5vYWoyWE1xcC9uaGFGY2hM?=
 =?utf-8?B?UElhTFVvZVNLRXdzdmp3b1l0OStEdWNmNHc4L1RPcThaVHJJU2J5QWdWWmhu?=
 =?utf-8?B?YkU2b2l0ZXhDRUZpR3dXbTVOMXF5TkNBWk1nY282bkpJQjhaaFFtZThQVmlG?=
 =?utf-8?B?T0hML2FFRXFsQkhDYXZSdU53c2dic21rQTZHdlhYT2hvcW43L1hmM1FFa3A4?=
 =?utf-8?B?eU40UnpGeldUTkl0TnFLcnRHcm1GVklhK0lQLy9BY3prcVpkL3pBMWlBOHJ4?=
 =?utf-8?B?a0R3U2pQaUVZZlJvb1lYNWUyQkw0L1IvZ3h5dFl4cXVWK0E2R0Z3akFHNldh?=
 =?utf-8?B?WHVkUFpyMGdnekhDdUd2NU00SW5CWEcwS2V2SDZwNTRsRjFvYVpmcnpaUTNp?=
 =?utf-8?B?L1had2xVTmJsVVB4emtXbVA0ZXNoemFNU05vUFBDNTNXd0h2MTRQdnpDVTlP?=
 =?utf-8?B?T3FSbHVjT3N3N1FnN2lYN09hYUF3QjJydXVtcTdYR0JZVnhRWTZySURWcEtT?=
 =?utf-8?B?VWdTV0xHczlOU1NNT3ZJWlJ4SFZWUzN3OVc4akJzYnA1cWpGa2hTM0gzOFly?=
 =?utf-8?B?MDhoeWMxcDNWZ05JU0hNelA3SmNSUkFXMk9sS3JMOW9xc0VOS1hRdjUyRXhm?=
 =?utf-8?B?TFI4TG9nSTMveGZJRDU2Y2VZNlFxTnAvdTM3YStQUU5SVjRCL0FoQ1BzcDhh?=
 =?utf-8?B?U05pc2VCV3VibHJKTXZIMGsxU29DQ21QQ1JDRFYwRUVVM2xQb05mZitaRGli?=
 =?utf-8?B?VnlTMkJVclg0TFJ2NXJZeW9uc3N6Wkc5ZEl5aGZidU5uRVYxRmhodlpKdnhQ?=
 =?utf-8?B?QWhvcE5FWm1hREF4b3hTTXZYTWdCbnFETUtjT3pWUE05QUZ4U21TRWNkZG1P?=
 =?utf-8?B?OWVrYVFFNjd2YlFXSjd2WkFTT2dIcTZGTzZMcHR0cW9xL0s3dkQ3R2JTK1da?=
 =?utf-8?B?K044c3JUL0YwN1FmbHB2MGVZRVA1QWUxWG1XSDIxc0E3TG5PNUtNc1AxbnQ4?=
 =?utf-8?B?K0tkOU93WFFwTzArYjhlTDdYd1pFWSs3L2hNODNWZjBwallVLzhoTVdLRk1L?=
 =?utf-8?B?NTJLVEZMUk1oTmxacHRQdHM1dHp3WXdOQzJFaE50WTRRcjg5eUp3WDBQaHBj?=
 =?utf-8?B?QkgvVzBrSHBGcSs2T2VubVRSWmJFRGk1STgrWmdiMGtTVWg0VFVnZEFORUs2?=
 =?utf-8?B?RWxxV3YxdnlSNE45c010eW9FcHBUT09pck1WR2lQckh2cG5jWmhTcFl4U280?=
 =?utf-8?B?a29sT2J5a0xFZmVIcUdmWFcxZXY5a01mZ2VsenZqR2RZbHZydkN4MGhOZ0pa?=
 =?utf-8?B?VHpTT1grT3Yzc0duSEJLK0lncXQxMjEzLzM3TmUwTkx3cFBmNHRQbnRnRXk5?=
 =?utf-8?B?R3NDSEd5SWFWeUdFZEdtOEh4d3BtTDlHdGJZSFl1NUlHUXN0U2NRTklqNytF?=
 =?utf-8?B?Wk9NUVVIajQxSDAzcUFBbjJiWGhDY0VEOXRFaGV3RnYzZTUxcUdkcjB4UlJD?=
 =?utf-8?B?ZDZaa1l5dEZWSFhYRXpSemc1Rng2dDVsS1M4NkRraFd6M3JMU0k1QUwvS2dr?=
 =?utf-8?B?WU0rWCtDN2ZVbjh3VmJtc0FUcTJGRHNpaTd3cXZ3REpRM1RIOC9ndC9lS2dD?=
 =?utf-8?Q?BbXZ+L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yjk3VWtoRXZFZTc0dDRuNnhuc2ZDQ255U0ZwZkNDVnVIbWFNSXZSUDdCcFVY?=
 =?utf-8?B?N3BJbC93ZlpkQXRkaC9Rb2Zmd1I5UVcvc1pSNklVNEQxeU5yOXB4L0V2Vm4z?=
 =?utf-8?B?em5oYTYzK0I4K0F1VlpmWjFyZ2VRQVVDM09nOXY2UnV2TFk0RFdHNGJLQ3Br?=
 =?utf-8?B?NkJMOWIxdy8zdXdxT0dYR0wrYVljcWhrd25zdWh2azJzcjNrQThXYXJiVzM3?=
 =?utf-8?B?RGZFRkhqQVU0SDUrSVBla1I2emdqanduV3hyNUdTRENJMnVHd0thRWNYbmRv?=
 =?utf-8?B?bWpMYm5SUzM0Um0xZGpJMTdsbm1lOVdDTjl5NXd1UGdBekU3b1pTTU1JYUZZ?=
 =?utf-8?B?OUxrUW5oeVgvZ0VLRTJsWWZnQWdmZE94RFR3Wkt0RnMyS0tycTRpYlJDYUdo?=
 =?utf-8?B?T0RZVXNYbXlBQ2FlUUVDSTZTK1U0ZUR6c052bUxKQ3ZieVZQZlErUUJhajZZ?=
 =?utf-8?B?MVo4MmJwMGFYQ2o5RStyYkl1ZFZlL3hRVVAwck1JWkU2UnN3M2h5eTR1eTJp?=
 =?utf-8?B?bXU5d1Q3UEx5aS9nTGdHS0VHcEhhMkRNNGJVbzRHTnVmR1Z2RWh3TG4vckVh?=
 =?utf-8?B?c3VLcHV5U0I1YmFFaTV0ZzJGcnJJM0ZDQmRUNmJZVEJXT0N1c2ZBM0VJWXJS?=
 =?utf-8?B?a3dFZ25sQXNKQTBkTDdITTdGWlAyajJXSWtiRFR4SG9TT281aWNndlZDVDdF?=
 =?utf-8?B?a1hUYUpwOGhCbmhoNDYra2lPWDcxbjN5WDh1UU5tTUo0ajgvc0JGcFpwMXFS?=
 =?utf-8?B?clEvSkI5SjBWRWRJRU9tdVF0b0lsNEp1OWZoeEF3UE9HWVdHMDQ2aGVxakNY?=
 =?utf-8?B?SXpqeXk5WDhOcmdHZVJxMkVDNWtHaUJmY2xFSjd4VnhiUThBUWxsZ2V3cE9o?=
 =?utf-8?B?T2lSa1NVWFZUeGJrNFJEL2pwbTVlalNWeXZpUmFtSDh4SjRybDd1MTA1bllO?=
 =?utf-8?B?ejk2TWdwY1oxL01Kb3VFK21nenhPL3VNVWRta2E1VElLT1F6WTVldkl5alN6?=
 =?utf-8?B?VmtTR3pnSjhtNlZVWXdLUmM0aGJ0YUo2UVJJODdDUVVEdHNTUnRNU2dmNkE4?=
 =?utf-8?B?T0NYR3FRT1FhWUpyUjUvOWc5MmRqUm1DOW13NlVyakJuZ05KQlEvZHBzeVJj?=
 =?utf-8?B?ZWhmNFJJQ3BWOFVXRXhkQVprdjlOR2JnMWRib28yT0JHRHhqVituYzRvWmpr?=
 =?utf-8?B?aWNPOGdtUVJDUFJpbU9uZTgzZEgzWGhHQ3JZSCtvNlQreDlSbDNzS1dIQzVY?=
 =?utf-8?B?bmVpcW01K2xPT3Q5NThrRXNDRXptN1pZa1hJenBrSXBrM0ZtekMrRklhYnZW?=
 =?utf-8?B?dUIvdStuMVlQeUxmRnlydzlKd21POEVOaitrMTBoMEtMZ3RuM0J5NE1zMHpX?=
 =?utf-8?B?UTV4SEg3QkRwNDNaRXBOc1pBQ0d4dU54L2hTdzJHZlpkRjNndUtkb1ViT1FD?=
 =?utf-8?B?ZHg4bVdtbkFqQmJKMlJ6aVZTeStqT0NKcDhMeWNXTmVHV2hYNGhiekdRWU5R?=
 =?utf-8?B?KzJCOTVqTnovSFUzMGJSNUtzaWphcFF2QkU1ZXRlZ2tmVFp2S1UzbjcvR0tL?=
 =?utf-8?B?a015OEY2dUFHdGt6ZFIyMzR3dGdOWHF0djdXUFhHcVZQRk9Tc2o4ZFU2Rmxi?=
 =?utf-8?B?Tjg5QXI1NHhNWVdNVTgySjYzMGdpeXJuaTkvemEvZmZkYXJLWUZFalRZcVNF?=
 =?utf-8?B?ZFc5UUFOMkJwKzZPcmZraWowbWlqNmNBMWxVRDZjSDQrNXBYbkdaNFk1RENq?=
 =?utf-8?B?OFRBQkVISkx4Yzl5K2tFMEl2VzNtWHRvTUltcXYwbEQwMjkrZVh6Sk95YWg1?=
 =?utf-8?B?c1ZmZko4TElCT09PSElRVHJTRGkvemhGajVZQlBGQW5yY2lscjNqbFE1T0lS?=
 =?utf-8?B?RWp3eVlJbm12QUMvUUJ3bC81Qm10RHFtYzY4VnozL01JSVozZXNYeFhNTjBn?=
 =?utf-8?B?NDlaV3k5UHp5Tk53VzJMN3ZHOUVNcEdNdEpPSXVmckV6MDZTOG01STYzM3VJ?=
 =?utf-8?B?bU9mQTJPcEVyS3RwZUk3TVVlLzVVZjZWMUZlYVpkengvZjdtSWxKQ3BtRllZ?=
 =?utf-8?B?dUtCY2o1MjJEbE9KZjdMWTllcXE2WTdscDFCcHBkODRiNGdNT0Zyc2F4T1pt?=
 =?utf-8?B?dWtNekF2VWFJTjBFeG5vYmpKM3FuR0VIZ1A1SDQ4VjZBL21HMFhtQlRCb0hW?=
 =?utf-8?Q?6GMRXZBpxu3LQeNK5sb3t8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23C0FD700587F448AF7738D75998A91D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7c031f-2222-4167-7b16-08de2c570a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 19:15:48.1869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ciHU8FHadh3FhVX2h/ZgduaYgcfPKl5N8S7DOi9zg+gI0GRw0dSew4xoKqx37Z1z+yVeSiy7zlTiDJfVCT8Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5017
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX5CCdAzzAJ29a
 N5UA9uvkapt7i2s5YH+EJwleM17zoTWPKlUUNQZCxsjk4SdSJryBOSYwMvQ/tJEYOoX7bNh+Wnu
 Y0WWdeMLKzaHJljXj80GBJtpcoSVZCUj6/D29iymzg/HXWmuBkK13PQnI8ZXx/TdNTmDZzMgAgJ
 sOvp76bSFaoGtY7D0YwIp6xW2qL9dW8si0wGTKUrYtsk87l4f86+osL8aDmA5ZulEenSpRLqIt3
 S0d/72IqV2KkVRdZcd8zfdpk/ZTvkMXtzSWhAXqeOX1oGOU/e3O6QysGlXfEDsHgT1yeIM1QJy7
 4ZkrDC0/Ca9Te5f6D41dZBB/i6HlLviD3OX1zwUtnwRe+/JwG/Klj9NWOuIFA47C86m5eO5WfvF
 NjiIxQGku+eX8utOCJ6ABRQZHm1Peg==
X-Proofpoint-ORIG-GUID: KD2fnpXI9ZhprQPKzjqL6lIZL7JmmRyz
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69260067 cx=c_pps
 a=6F35cL4xT6GZaKJ9H0o0MQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=eM6yK1XMUkZXLYQQt7AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KD2fnpXI9ZhprQPKzjqL6lIZL7JmmRyz
Subject: RE: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

T24gTW9uLCAyMDI1LTExLTI0IGF0IDIzOjQ2ICswMDAwLCBHZW9yZ2UgQW50aG9ueSBWZXJub24g
d3JvdGU6DQo+IE9uIFR1ZSwgTm92IDExLCAyMDI1IGF0IDEwOjQyOjA5UE0gKzAwMDAsIFZpYWNo
ZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjUtMTEtMTEgYXQgMjM6MzkgKzA5
MDAsIFRldHN1byBIYW5kYSB3cm90ZToNCj4gPiA+IE9uIDIwMjUvMTEvMDQgMTA6NDcsIEdlb3Jn
ZSBBbnRob255IFZlcm5vbiB3cm90ZToNCj4gPiA+ID4gKwlpZiAoIWlzX3ZhbGlkX2NuaWQoaW5v
ZGUtPmlfaW5vLA0KPiA+ID4gPiArCQkJICAgU19JU0RJUihpbm9kZS0+aV9tb2RlKSA/IEhGU19D
RFJfRElSIDogSEZTX0NEUl9GSUwpKQ0KPiA+ID4gPiArCQlCVUcoKTsNCj4gPiA+IA0KPiA+ID4g
SXMgaXQgZ3VhcmFudGVlZCB0aGF0IGhmc193cml0ZV9pbm9kZSgpIGFuZCBtYWtlX2JhZF9pbm9k
ZSgpIG5ldmVyIHJ1biBpbiBwYXJhbGxlbD8NCj4gPiA+IElmIG5vLCB0aGlzIGNoZWNrIGlzIHJh
Y3kgYmVjYXVzZSBtYWtlX2JhZF9pbm9kZSgpIG1ha2VzIFNfSVNESVIoaW5vZGUtPmlfbW9kZSkg
PT0gZmFsc2UuDQo+ID4gPiAgDQo+ID4gDQo+ID4gQW55IGlub2RlIHNob3VsZCBiZSBjb21wbGV0
ZWx5IGNyZWF0ZWQgYmVmb3JlIGFueSBoZnNfd3JpdGVfaW5vZGUoKSBjYWxsIGNhbg0KPiA+IGhh
cHBlbi4gU28sIEkgZG9uJ3Qgc2VlIGhvdyBoZnNfd3JpdGVfaW5vZGUoKSBhbmQgbWFrZV9iYWRf
aW5vZGUoKSBjb3VsZCBydW4gaW4NCj4gPiBwYXJhbGxlbC4NCj4gPiANCj4gDQo+IENvdWxkIHdl
IG5vdCByZWFkIHRoZSBzYW1lIGlub2RlIGEgc2Vjb25kIHRpbWUsIGR1cmluZyB0aGUgZXhlY3V0
aW9uIG9mDQo+IGhmc193cml0ZV9pbm9kZSgpPw0KPiANCj4gVGhlbiBJIGJlbGlldmUgd2UgY291
bGQgaGl0IG1ha2VfYmFkX2lub2RlKCkgaW4gaGZzX3JlYWRfaW5vZGUoKSBvbmNlIHdlDQo+IGhh
ZCBhbHJlYWR5IGVudGVyZWQgaGZzX3dyaXRlX2lub2RlKCksIGFuZCBzbyB0ZXN0IGEgY25pZCBh
Z2FpbnN0IHRoZQ0KPiB3cm9uZyBpX21vZGUuDQo+IA0KPiANCg0KTWF5YmUsIEkgYW0gbWlzc2lu
ZyBzb21ldGhpbmcgaW4geW91ciBwb2ludC4gQnV0IHlvdXIgZXhwbGFuYXRpb24gc291bmRzDQpz
bGlnaHRseSBzdHJhbmdlIHRvIG1lLg0KDQpBdCBmaXJzdCwgVkZTIGNvZGUgdHJpZXMgdG8gZmlu
ZCBpbm9kZSBvYmplY3QgaW4gdGhlIGNhY2hlIG9mIGFscmVhZHkgY3JlYXRlZA0KaW5vZGVzLiBT
bywgaWYgd2UgY3JlYXRlZCBpbm9kZSwgdGhlbiBpdCBzaG91bGQgYmUgaW4gaW5vZGUgY2FjaGUu
IEl0IG1lYW5zIHRoYXQNCndlIGRvbid0IG5lZWQgdG8gZXhlY3V0ZSBhbnkgcmVhZCBvcGVyYXRp
b25zIGZvciBzdWNoIGlub2RlIG9iamVjdC4gU28sIHdlIGNhbg0KY2FsbCBoZnNfd3JpdGVfaW5v
ZGUoKSBvbmx5IGlmIGlub2RlIG9iamVjdCBjb21wbGV0ZWx5IGNyZWF0ZWQgYW5kIGl0IGlzIGlu
DQppbm9kZSBjYWNoZS4NCg0KUG90ZW50aWFsbHksIGl0IGlzIHBvc3NpYmxlIHRvIGltYWdpbmUg
c2l0dWF0aW9uIHRoYXQgdHdvIG9yIG1vcmUgdGhyZWFkcyB0cnkgdG8NCmFjY2VzcyB0aGUgc2Ft
ZSBpbm9kZSBJRCBpbiBwYXJhbGxlbCB3aGlsZSBpbm9kZSBvYmplY3QgaXMgbm90IGNyZWF0ZWQg
eWV0LiBCdXQsDQp1c3VhbGx5LCBuZXdseSBjcmVhdGVkIGlub2RlIGlzIGxvY2tlZCB1bnRpbCB0
aGUgZW5kIG9mIGNyZWF0aW9uIG9wZXJhdGlvbi4gU28sDQpvbmx5IG9uZSB0aHJlYWQgd2lsbCBj
YWxsIGhmc19yZWFkX2lub2RlKCkgYW5kIG90aGVycyB3aWxsIGdldCBpbm9kZSBvYmplY3QgZnJv
bQ0KdGhlIGNhY2hlLg0KDQpTbywgaGZzX3dyaXRlX2lub2RlKCkgY291bGQgaGFwcGVuIGlmIHdl
IHRvb2sgdGhlIGlub2RlIGZyb20gaW5vZGUgY2FjaGUuIEFuZA0KdGhpcyBpbm9kZSBjb3VsZCBi
ZSBnb29kIG9yIGJhZCBvYmplY3QuIEJ1dCBJIHN0aWxsIGRvbid0IHNlZSBob3cNCmhmc19yZWFk
X2lub2RlKCkgYW5kIGhmc193cml0ZV9pbm9kZSgpIGNhbiBiZSBjYWxsZWQgaW4gcGFyYWxsZWwg
Zm9yIHRoZSBzYW1lDQppbm9kZSBvYmplY3QuDQoNClRoYW5rcywNClNsYXZhLg0K

