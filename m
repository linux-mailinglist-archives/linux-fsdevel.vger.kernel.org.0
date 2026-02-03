Return-Path: <linux-fsdevel+bounces-76232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNTWAEyGgmmDVwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 00:35:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28BDFC5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 00:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BCB730C5646
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 23:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C0232B992;
	Tue,  3 Feb 2026 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hdcw13QR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9230FC32;
	Tue,  3 Feb 2026 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161733; cv=fail; b=Zokw/cLA7ZrdqoE2jeGftO2awLlGx06aAXW9Wr+F904Mu04HtkdEy7MOdDjz9fWTQP1Sq8rSC1R1uQ4fWxL8BgJiTzM63WACHHzXoxbATQqB0MilWA1wrefah/DbZ0FDXv40hIEVHvI1pgmZ1UcRyd+HZtM1Ry22987V9Opry7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161733; c=relaxed/simple;
	bh=RN66N1sgGU6toK/JHIJqzOxExh3fjz6O4diYIxZHXOs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=iJGPDYkYRN9CBb5XCjyH5SHN9YdFuV6urPNBL6HHko4flSHSxQGxaH53w42DGadgs1s8laN54A/5FXzIdvOGk3hFqv4bUXJ+kFyhW3ULZOOYvqtLKyntNOsV1xb1lXJ+ekw4DEjRYcdOdV8Qy3ukU6U1ecoRwso0SKaD2NwUtT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hdcw13QR; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6139avGV023046;
	Tue, 3 Feb 2026 23:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=RN66N1sgGU6toK/JHIJqzOxExh3fjz6O4diYIxZHXOs=; b=Hdcw13QR
	sbtC9W/tkKWa+i7FhPx8gNKrz2mSVT6eaXBqiQlUVmQ2nH6UMZ6HlX9F8Ln8MHI9
	jPMepO2TJbhdLia4KHO0fH1+XMx/FJTbFRFLGAi5MEK70UBTlDaEV9VcjomlS25S
	E9FNVYY02+AhBUUqIbnapgQol3GBM/5HhwQlFcmxs647wKqvRZlxA6wKqfPYaJ5Y
	R4RFhbnPvyNBkLfunvyALks1DHHHI/AOWpZwrVHIfYE4jWlWvRQpBE5F2vI0r3KA
	F1rJe1WbVi2H7h0fdZDdvQmYvuuBNmCnfTZYM8XzaR2PNU9wnowReK6715jhWRVN
	0YLvYkif/C/FJw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt7jh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 23:35:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 613NZKTT015416;
	Tue, 3 Feb 2026 23:35:20 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt7jgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 23:35:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrFh190o+ZRXpE7YrbsDbHYKCoKk3rAqIkEAQC155MK844F0iGLNuGsy4+snFj5NLddmmY7R4gE6zXw9AX/AcXyDub/ToaOX+JtW0BW9zove3S3F7wgYfaBSyWz7pZQzZCm2tI+A4UpT3plkvR764rMPRiio47xss72FqDDP6R2MaK4ggmPYC9Uc1GGmALHcc1euJRJUrOY2oCoKSVcvFERWWOwRi4idm3cuqis2KkkyVqpdhVdn1ny8CYTJpwXSz0WIkHwsTHZauQDRKtR0SAeygfmpqPeN+Pij+0HH0VYvsuKGoZukp/xnAurnuGDgryUZG0455KwGjyPCBMsHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN66N1sgGU6toK/JHIJqzOxExh3fjz6O4diYIxZHXOs=;
 b=kKmtEJ/rb36FVsbBQJBtnpyHiHthWzMe1ZvxTOV0LHosFdgTNfc4tTwLqN4gZt0dMu53/dKv3+mfyGCCLsbEs6dCF1Ieqtu90lGVym922a+wgKp2HEoqJVpYDLgwC3W8UslRj7VOxGOSfPj7DtJvWMRItVmdQw+BmP2sIMy2DQ44zXCxU4L3Bl92qpQiYoH4Q4R7HTFJzdHMt25Q82gyZREIMM4H7xXF2VMHseJKqtrr/Gw4+EfvyXqOw7qJwxxtqBiqreicY5ZOYnedUs8m1rqWbh1MZwEu2sOhc5f6NqnNjbSXagwPMyRNnoftv009tWkKAvCq0HVjXsSFBQgSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPFDFF869DF9.namprd15.prod.outlook.com (2603:10b6:f:fc00::9c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 23:35:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 23:35:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
CC: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
        "syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com"
	<syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount
 setup failure
Thread-Index: AQHclMaiKtTJZ48RZUCMz1LaYapWfLVxofOA
Date: Tue, 3 Feb 2026 23:35:18 +0000
Message-ID: <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
	 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
	 <20260203043806.GF3183987@ZenIV>
In-Reply-To: <20260203043806.GF3183987@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPFDFF869DF9:EE_
x-ms-office365-filtering-correlation-id: dccda178-f6b5-442b-eccd-08de637ce3bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2FuMWx2dnFRSG52V01wREN4Tkl4SXNqc2ZzM1hqeWFnL3VpQUxlQngvTzlO?=
 =?utf-8?B?bVV2ZUszRDlweExDbG9kdTBTWDUrQU5iNm5vdlRIamlSVmxQWFdId0psWVpG?=
 =?utf-8?B?OXFVWlFhZkx1ejViT0I1TkNkaUxCSGR3SDV2UXNuRk1mMG9aZERNRFFyWnRW?=
 =?utf-8?B?WE9RWDJrb3B3ZWZZQUx6UDVYTlkzNUNjVS9pOGIxeml3VXdaRWwzK2NIbmt0?=
 =?utf-8?B?eFg3bEdtQVU0d1cwTlJCR0lZNExNY3Vjb3dERDhFS2Jnbit1dlhQbGNNVENw?=
 =?utf-8?B?amtDRWplNUlETDBmUjVoaTlNWVNCaUxSZmZLODA1RVluQTdwQzBrb2RVYW1X?=
 =?utf-8?B?NkpTbUIwN1lwVkdwdG1wU2NVYmpSSWgwKzFDRk1jM1puTXNPMlBiZ1JFckFv?=
 =?utf-8?B?VUY2Kzd1YmFqTUNBQ1hNVnorSXdmNDJLUytQZllDREwyUTAycTYxVys2eENv?=
 =?utf-8?B?VVFoUnBOSVZYdFBEbVdKcUIzd3BKQVpMV3M1YkhkdllyRDFFTDk0NG1wNjhI?=
 =?utf-8?B?WkxIdDJqRTFZcUlTTWgxNTAwMGpFQUpFcTBHNEhLdE96MWJvY05XODdhMkVk?=
 =?utf-8?B?WlRiUW5YWFhBQ0pKbHFva01JZDlQZit1d0NBS2hoQkNham51SzZydFZKVTB5?=
 =?utf-8?B?dXRMY1ZxVkxJekVlL0prck9TTkdJZkE5djJsbWgvZUd2ZFVrMHV3MTJMOHJk?=
 =?utf-8?B?RlNiOTMrL3MyL3BCMTdWZTBtUDlKZUVQUlNLYWhGeWd1bENZK1AvbU9HOXlW?=
 =?utf-8?B?L09Nek0vZlhjSDc2dENiZm5CZWVENlJtUG93Y05XNzNsTjlnVEljL1dHeCti?=
 =?utf-8?B?SzZiTk5DTnFiVHpNKzZYTyt0T2x0Z2k1SUFRNk5ZWFBWTHlKNTdwSVNnU0g4?=
 =?utf-8?B?UXFHUTFGcWplWFQzcVBxLy85aGV0TmdIK2lVNjdqc2xURjhib2U2L1oxSWhQ?=
 =?utf-8?B?THJSZTdhY3NIQndyNWg0a2V3bkVKUjVIbW51T1daWG9TMC82cm1SMm1FRFEw?=
 =?utf-8?B?MDZ0YzZhK21Qb09BTmVuU0lTUDlOUUdMVnNPZ3JVUHVxZ3BxMWEwYmhualRI?=
 =?utf-8?B?bjFlbjZnTjg1UjYzQnc3MjFMZXNuTHNJZDBaa0p5M2R0VUF0THZrUWpYM3o2?=
 =?utf-8?B?NFp3QnNIbityRm13cWszTm5VM3djK21MdjlDWWE2ckJRZzhkRE5CWlBhdTJm?=
 =?utf-8?B?UlU4QTBhUFQ3MW8zc1V5K1pQR05JdERINUFLZXZWaEU1dGxXWUZGWWIxNjhY?=
 =?utf-8?B?RTFoT01aOG10V3l4VFArZmhIUGIycy9LRWhSWG10ZjFETEtYZFVvM0VJVWdF?=
 =?utf-8?B?QnJFb3ZJTElBSHNsdjNoTnZnc0NRSXFjbXhHaU9XRjlHRUQ4M210YWdvR3pk?=
 =?utf-8?B?U0dLRGlxMFcxZnNoSGNWM2xUd2pPbGxxTlJmU21FK0NHSGhmeHBiN2xoaDVK?=
 =?utf-8?B?UFQ0aWsxbEF4TmVzUE5NeDdzY2Nnd3NZcko1SzF4UlFPNC9GcVNPeDBnRW1X?=
 =?utf-8?B?RmZ6RWNlM1dRZFcrVzRpT1loRndLWDdTbHd2eVZhTno2NURxakU3SkNoT1ds?=
 =?utf-8?B?d1pycDcxV3BNLzZnVE9GTjRrMXhOcExNeHE4MGl6RjA0b055K3hHWUxiMzQ1?=
 =?utf-8?B?YUthdEJWTENKNXVCQ2lLdmF1cGVNZXNuVElvcWhUUlFpQit6ZXFMZXhkVTgr?=
 =?utf-8?B?dTVBZW5TUUs5dENRZ2lsSThjYWptOWNIMVVRS1VkZmVOOTZ0ZDhsSnpUcFcv?=
 =?utf-8?B?UkliWm5YK1FpWWJEbjV3Yk53cllYWHJhMFVBeXFrQWt2czI1clVKVTMzYWJU?=
 =?utf-8?B?N09zT3ZzRVFmT1FtQlpRNCs0NGxaUTM1QUg5Zlhmc25uTHRIU1RCeThBV0xY?=
 =?utf-8?B?MTJZcW9IMzNVZW5hZG42RUhDRWdPb1hKdjJBUkRaOUdKVmhXY2lqZEsrZlVD?=
 =?utf-8?B?TDhUSVB0RlZuNmhkMkhqQWRTb0t6OCswMnVoL0VrWU83b0ZBeW1lTk1zYjN1?=
 =?utf-8?B?eFBIcCs5WitKOGlXNE14WW9wclFUTnNlMmJPRDlMeFo0dEJpNlM0clozQWs4?=
 =?utf-8?B?UExiZWFqNy8xYW0ycDJrZW1UZ21mU3J5OU1ac2NqSkJvMDREM1FLaGxBNFda?=
 =?utf-8?B?NUQvSGg3Qkd2dlZVeENKTzRRbFVOaUU4Ylg5UStsNEdtQUxTeXNlTHpxZ3pt?=
 =?utf-8?Q?+M2NLEzNfhaqMVgDlZRw3y8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R09ZQzlDcXdVcVM0M3RtQnBaVUFrMU1GaTY1RkYwN0c2d3NWdjZYRGhBdGZC?=
 =?utf-8?B?djdNQkFBeEw5TWtndGxHSGJYQUpWeHZSb3lJUnBJbVRLWlhRd0NGZDRQYnVv?=
 =?utf-8?B?SHdYZzAxb2ZLNE40bFJEWnJwSGpCaDJwVWtyOWhENHhWRFVEYlI1dUt6ZzhP?=
 =?utf-8?B?TFR5RGNQbER3OTBDUHZHUzJvbkRzbGJ6NWNjYjg3NWtvbEM2M2w3VWZNRHFr?=
 =?utf-8?B?cU1UL1JOZ2ZlNmZTVE1IME9aTjdndUNxTEF1RGo5OVZxS00zWWFPV1FYMnU4?=
 =?utf-8?B?VUV3VnIwVHZpdDFPcW9rWWJwWEpMZW5mRmdKQzA4U0dtN3EvMFBQQnVXN05C?=
 =?utf-8?B?NWtnczRpWUZySzBoNmt5Uzc4RUlwSUpOOFF5MzZoOXBrY3A4a04zQ1VZM0hm?=
 =?utf-8?B?R0kwN3BVZS9mTi9ieUw5bDBYTUJYSktNeXFGODVjVjJSd3c5UnQxV1pKd3py?=
 =?utf-8?B?R0hOMEp3Z3pKcWpHQSsrY0JsZFJzWXlIRjN0cE1oVUVSdGlPVWorcEp3aDBQ?=
 =?utf-8?B?MlF2bTZLTi9Jd2Q5cWRteDRHcTdTT1FkbFNWZFZXQk1GWVpZaVo3bFI1dmo4?=
 =?utf-8?B?czllWXdHY2JneUhqcFJQSGh1c3RtSVY3UXZTMUZHZkVnbnRaZHc5azhIeG5Z?=
 =?utf-8?B?TXdnNW1nTWc4cTh2cU45WDdxQlptK2ZYMFdJb0FXVlZLMTFiUUVxKys5Mjk3?=
 =?utf-8?B?eFZSd2oraTdzOXVuMzNmamtjOVczcERPejZGd08rcUN5TEpWSFhleFpwUVo1?=
 =?utf-8?B?T1AvYjUyYUlIWkJJRlRPQk5DS1dYTHl0eGtOV1orS1FKODJFdkhTdDVqUXdB?=
 =?utf-8?B?THFaeDdydTFGeEFRZ1lGY3Nma0ZwRnE3cGh0dFU2YnR3dFlZejBRMVNIQldw?=
 =?utf-8?B?Z2xpa0RPMDkwbXI3SHBjd3g4VHg2cUZINFh6NXl5R2NabWplaHBvQ1V6c1Rk?=
 =?utf-8?B?UVp2SDI2a0lmZE5DOFJJaDgrdktKd25qSGs2UGNGMnh6Ukx2K3Q3YVhvVSt0?=
 =?utf-8?B?VW45Yy83UDFPRGdWekNVQnV2MFlBNjIwMyt0SUxxaDFIZ0JXT3NJZGtRSGtL?=
 =?utf-8?B?NUFQY1VzM092dnBxei8wVU43U1lIQWpMaE1iczhQYWkrS0tKUDQ3cU5yZjRx?=
 =?utf-8?B?Tjg2eG1SZlNsS08zazJaWjdydmxhODYrUy9VN0hFTEt0YWY0S1ZGYndvaUdu?=
 =?utf-8?B?emhNemJITHZSRnVNWW93ajV0b0NSQTlCZ3B1cU5oR24vNjQybWtQTFNjMDRS?=
 =?utf-8?B?c0xBZEFJQlJTelo0Si9yQThUL3Q5ZVdpbmhjVUREZUhhYjNkTUZJbVNDUnJ2?=
 =?utf-8?B?RUpLTkRoWU4veU1KTkIvVE42Z0dyUlpIdUdHZ0doNmZqRkI2VDdCMFZBY2E3?=
 =?utf-8?B?RnZpZXFvUnV4WE1Jb3dzVnRveVI5SjJQcTBNWm1sbi9hR0ZCRW9ZZGR1NzZG?=
 =?utf-8?B?QzhrZU9mSzdMUDByUXpXZHFrUFAxSW9VODk5Z0ppdXcxOTY0KzQ2c1pSamUy?=
 =?utf-8?B?OE5WeHpCZVpSYWY2UEVKNjBrQjFiTktWeEE0YWFwNFlWNjRXT09QdDBYNXJ0?=
 =?utf-8?B?ZkVwclpDNllBVjBLN2YvclNMUitBckR2c0lLRTdVUkgwcTZGMiszKzliYXdN?=
 =?utf-8?B?bDl1WHQ4SmtueDB5c0FRcWJlRVNPclp3N2t4TTcyVll3V01JT0t6bmd1SUtD?=
 =?utf-8?B?WnNPNVBpRWVjL0tTM3BZWlcyZTF0VEtuUHRxUFh5VUh5a00weG5MTEdnTTFC?=
 =?utf-8?B?Q3doZXE5OGV1TUpGMFcyK0ZZQVp3akN1ZVdVK0NENWptL3FBcjZoK2hUTW9x?=
 =?utf-8?B?bkJIdmoyU2s5VFYvZXRzZkNrVlU2Z29aelpORVdmdGxyQkZqS2lxRnZiU0wx?=
 =?utf-8?B?WWxUWUxUak0rTjdQVnZVUjI2ZmFZZWQzRjQ5ODI5KzRCSGdlajJ2cVNKUjlX?=
 =?utf-8?B?TFJtRG80R3NqMzNMMDFqdXIrSWJsbFdIUXZIT0J2QU12NUVyeDJlNnUySG5x?=
 =?utf-8?B?Uml1M3ljditHSG1ROGpiay9mWGhJemxhbG9WekU2c2VxR1ZZM2hoNUhMVXBw?=
 =?utf-8?B?eFFjdlFKNXBMcXdHaWZzd0ZsanlTMlRHejlSYUtCZC9nSGl1cW1Hbm1RbzFi?=
 =?utf-8?B?c3kwcWcyNWtFNzF4RitZTjdkOXJHaFZSVTdVNTF5ZWRCRDQ5a2hsWWZTRzV4?=
 =?utf-8?B?TUdJRk53UEdBUVBCT3pZS2FQZmFrY2NWV1EycmdBREZpc3VVRC9pUk9XYWhk?=
 =?utf-8?B?bzRZUDRZUGNOVWp0L20wZncrbkZmRFhVV29zaTRqMHY0LzZFVW9CaTN1bXN5?=
 =?utf-8?B?aFowR0RwcmpZTHJENVNxSlU3SDBOeGlTUlF5eFNSMGR0QndHeGNYZTROYXJI?=
 =?utf-8?Q?ArxVPGBW281IPCF4a6PJquX/vEl9HQ2kGlRiY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFFFADF6A8A135459100E4A2C084AB98@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dccda178-f6b5-442b-eccd-08de637ce3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 23:35:18.0728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8m6FxRbjqNmW5E2wBaK3owDXHwNMgiMGDGMUCnMoE+P+yMUc4qPDYEHPvVGAqEef8hE6cYeXnXQwflehAZVBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDFF869DF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE4NCBTYWx0ZWRfX2JgdpnNKy0zo
 BdGjLU09PDXfZyUGGYYzbd65mti7KLhQSMYLKj5kr9PuJ013oFXuNU5f6xrY7KcRzyNtNpwlV7C
 fSGXFDlPV0HNTsvxHa5j3acyk5HVKOSdcBXjZlcyrUDseFQJXCF/IrWOrXMo38SG1IMI8ZLBH8z
 SgmdYsUWKXgYhsnHIeYUPcU8zvX9MHvYJh9tvdOd4O/xFnKvdNyGq3FeJmvxhmRfBNy99MGBN5B
 97+XYNP5D3H9FZ2NiySYdsLrEgjV0r0vxN1hroG2NhJswlcHIxdTRcJqw2ioOb1QgrnUtGwTLPX
 SZCnQqGS3Np6Zfcv+yYJcl3qWLIKRwGhRu+jDXnrGyff5z4q4AMldpfyZLsOQlSlaNoEIY2oJeP
 xyLd4oYS3XPp8xrbRqDqUB3IY1j5kzwaUc/+8jThmu/jVMcqRBgF8LykpHbJdxbVFtFbFTbc2kZ
 5YnQbxZ6Sh0CNjclwBg==
X-Proofpoint-GUID: 2M6k93Lp4AOTKge49v6AGOQ2YIw46uD5
X-Proofpoint-ORIG-GUID: h5dxMlLJ3CIjmmeNT2NB8ePd6WAEblSv
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=69828639 cx=c_pps
 a=zwUidnFXtIpczQ2t7519XA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Eqn0Z7CKeYMcC7G6kHUA:9
 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602030184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76232-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5C28BDFC5B
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTAzIGF0IDA0OjM4ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBN
b24sIEZlYiAwMiwgMjAyNiBhdCAwNTo1Mzo1N1BNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gPiAgb3V0X3VubG9hZF9ubHM6DQo+ID4gPiAtCXVubG9hZF9ubHMoc2JpLT5u
bHMpOw0KPiAJXl5eXl5eXl5eXl5eXl5eXl5eXl4NCj4gPiA+ICAJdW5sb2FkX25scyhubHMpOw0K
PiA+ID4gLQlrZnJlZShzYmkpOw0KPiANCj4gPiBUaGUgcGF0Y2ggWzFdIGZpeGVzIHRoZSBpc3N1
ZSBhbmQgaXQgaW4gSEZTL0hGUysgdHJlZSBhbHJlYWR5Lg0KPiANCj4gQUZBSUNTLCBbMV0gbGFj
a3MgdGhpcyByZW1vdmFsIG9mIHVubG9hZF9ubHMoKSBvbiBmYWlsdXJlIGV4aXQuDQo+IElPVywg
dGhlIHZhcmlhbnQgaW4geW91ciB0cmVlIGRvZXMgdW5sb2FkX25scyhzYmktPm5scykgdHdpY2Uu
Li4NCg0KWWVhaCwgSSB0aGluayB5b3UgYXJlIHJpZ2h0IGhlcmUuDQoNClNoYXJkdWwsIHlvdSBh
bHJlYWR5IHNwZW5kIHRoZSB0aW1lIG9uIHRoaXMgc29sdXRpb24uIENvdWxkIHlvdSBwbGVhc2Ug
bW9kaWZ5DQp5b3VyIHBhdGNoIHRvIGZpeCB0aGUgaXNzdWUgZmluYWxseSBieSBjb3JyZWN0aW5n
IHRoZSBwYXRjaCB0aGF0IGFscmVhZHkgaW4NCkhGUy9IRlMrIHRyZWU/DQoNClRoYW5rcyBhIGxv
dCwNClNsYXZhLg0K

