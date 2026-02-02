Return-Path: <linux-fsdevel+bounces-76069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLHOCmjfgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:31:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A4CF9F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10689300F12D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163CB38736D;
	Mon,  2 Feb 2026 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NuPHNwBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB221FF38;
	Mon,  2 Feb 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053477; cv=fail; b=ftIaGX5eyoPcVLAAd1TIUDEPIU7B8DNfRzJBbzRgTGKOILRU2NxlQD4PPd49F1OBlnSpYYBZhcqnQKXSSbL5JzpgSiQuRc7dAMJ6C0QdniQrlKkHFUwYi8ti0jIEcj+26/dLKbsOcuCDf6U4AbFx5yuY7IN7KrL3T4VSoz6Ripo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053477; c=relaxed/simple;
	bh=NG3r9zBQ21QO3iDbvRuZc14W9Z8m5t6HUyn/Yo/6RXM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KuFH+pyGTULWeaKDEzes0TyJHDl6g38Di/bSa7OIMgAs4/ZpNIhfTC5pgXN94etxlNhuwVJNdYt0cbewCBAzxtyGnKwoNRgnjiKUwo1Cazw9wuCf6FWvnJLqUCBhQqU3b/cGrZWLhXBCgv4OOqmmAH5HyLPHptcWR3zCd8801lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NuPHNwBM; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612F7jZH009119;
	Mon, 2 Feb 2026 17:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=NG3r9zBQ21QO3iDbvRuZc14W9Z8m5t6HUyn/Yo/6RXM=; b=NuPHNwBM
	7rrnP9Poqg6TSCQ8/nNbvgBXr85237Lkyi96QN57Znu5HUYIf9AGqwVQOwmfHlub
	p+d5lAKLzjCoieccWkTuPUcKfNHTssMxo0P4LqsQKoPW1VtPhemjesdvCI2IXRes
	DUUEevI9QmR73X0w8FGh6ACVTa4j189HsTQs77yNpen9J+y4Hy3gUMj+TIiy5aiF
	Klx/ExLUvSP52zbJ0jVXe+69o3UCosA+sxsi7TIhfX3IBVQPMBXyNiOs7B9AvTE8
	PkNEljGAc5sZ4Z2YjptKDzTvFAr/NhRYKCX2mMVi9ysnETEHeON8tCQFv6tE9gDi
	yYBKMeMaQd07aw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f69kjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 17:31:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 612HV2Jp023797;
	Mon, 2 Feb 2026 17:31:02 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f69kjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 17:31:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOoJB+FAWxK9JcD353pc65opFuZ2tJ/T2ulzXvPJnNK7UY2Rh3w/Khtbj+DQbCeCR+rZjGZMjJLvMeH8oJ4X0kwBcLD50n/QG4Bb0g0UWw2ZLEpuW1fDKIPkPaKJqqfOohUGvlFLDDxZp/9yLJHmYvZivnI6FhhqvN89nhu2lOStPXyed0lXVISSCYH8MCnoMPjO2vCr8QcvmWDpEBLBFr2jW+JEhHwXYZxhzTIZdKswSyB6wwiB8n4bjVFhCwPUNIZKuJZQ/hTFNul7lQker6JZH3MJD+HgzSZPdYDs1uFQfpwErqYlkN2qquqaHbfv2aDEhy2plloy288G8N7pSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG3r9zBQ21QO3iDbvRuZc14W9Z8m5t6HUyn/Yo/6RXM=;
 b=rIS0B8isgRLFjckVK4FIHqEF+/Yughh/OUjRlilqutt6WVu95fRDcC0H/jigw00igj4QUbhAX0nYdD1skvt8Fp52CBlTJPBGrxspMUBvOOvlVCJwUctBO06WTig0AY+XivoBK1WISVfzSRzPR2duVMCbjS90HhbwC2pPNUr8WE7cm3Y+r08Wx5nSd8NS5Yod0t+u/WpftfaZMOA471Mn8JyV5ME5IbLziZGVLxZy3x6AVfmC3nyZDVe2JO5jGGAMYJvnhChkuBm3nDTwHrOSkFq7rTmRSn/wk0pcI5jQ9m0sp4Ist3PVW6yujBtsRAOiljbDyHCFB4XXKz7+jN/E8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB6160.namprd15.prod.outlook.com (2603:10b6:806:2ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:30:58 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 17:30:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "brauner@kernel.org" <brauner@kernel.org>
CC: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com"
	<syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kapoorarnav43@gmail.com" <kapoorarnav43@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfsplus: pretend special inodes as
 regular files
Thread-Index: AQHchGprpbzFOmP7qkq/BjkOY+a4vbVQWHyAgAF9xQCAG4BkAIACc+YA
Date: Mon, 2 Feb 2026 17:30:56 +0000
Message-ID: <de541759cfa4d216e342bf15b07f93a21f46498b.camel@ibm.com>
References: <da5dde25-e54e-42a4-8ce6-fa74973895c5@I-love.SAKURA.ne.jp>
	 <20260113-lecken-belichtet-d10ec1dfccc3@brauner>
	 <92748f200068dc1628f8e42c671e5a3a16c40734.camel@ibm.com>
	 <20260114-kleben-blitzen-4b50f7bad660@brauner>
	 <ad88d665-1df2-41f8-a76c-3722dcb68bb6@I-love.SAKURA.ne.jp>
In-Reply-To: <ad88d665-1df2-41f8-a76c-3722dcb68bb6@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB6160:EE_
x-ms-office365-filtering-correlation-id: 94ebcc5a-2c01-41a5-8f15-08de6280d2f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWhjQlZQRk00K2FpMUpVMk91RGJ3bWRxYmFiNXVuWjduTWYyZXhONXVsWDJT?=
 =?utf-8?B?VG12UU52MFlyQ2hpREZsVXMzVFJGMW1STzdFak5LV3pzNE9xMWRERFY1WEZY?=
 =?utf-8?B?VEFLOFNjUVRLVnBDNWJCQjhTWS9HbGhNdUpxajFOcXJyQTVnZWttTUlzVkMr?=
 =?utf-8?B?Sy94elRMajlFWDdubUhIYUtsUTNNZW4yemNmZ0FNN2pCY2x0LzdvcmxWT1RV?=
 =?utf-8?B?bFdCRzVqMU9vOUN4aGs5d2E0ZEpLeDlzaDVBcmxKdmgyMUIrUGRtWEI3Z2Jw?=
 =?utf-8?B?Z2dzV1JPbFhSK1d3S2I0ZEVDcWdwMXA0eUpvTTF0cjhGQ25xSVlubzRPNUxl?=
 =?utf-8?B?blF3OTRiTXVnVjFXQ2ZBWXozOHVIN1pDU2VTbzNzVGMvUDhreUF2czdNQzAy?=
 =?utf-8?B?S3g1QUJnWGRWbjVXTWFhMExnd2RONHF0cmFmUU96UU44bWdudVNwZjVNeEZF?=
 =?utf-8?B?eXRMcmxGN0JrUkFEbHdZTmJwazFHbnY2c1VJTVBFb1hWZmlJSjRVdzAzRXln?=
 =?utf-8?B?T2NHekFLMUdyaXE4YWI2RnJwRGVWc3ByMWtKaVMwVjh6MFY4Rlh2TzM0eEND?=
 =?utf-8?B?Y0UrbUIvUTFpajFuL3J0TFEyYzRGYnlEd2tHS3AyeUpKSmx4R2Z4MXVWdWl3?=
 =?utf-8?B?c2N0VXNDbU1GRzZZVXpRTDFEdW5CUStXdDVjNFY4cVlzTmtoM0paOE1TbVRS?=
 =?utf-8?B?dnBtV1k5UWIwbjY0a3dtLzM0Z2lhc1kxWHlCWExZZ1VkTjBoUDI4ckd5U0d3?=
 =?utf-8?B?ejFMOEdIMkNhUnFxSDVoeVJsYjBUME5La1JDNEpNN0FFVzA3MWZ0UmVwZ3Vo?=
 =?utf-8?B?NzdmU1liMU5OQzlkblpOSWkwZXl1ajFPZE9STVhBcTFFeTdSWEpXWG11cm1q?=
 =?utf-8?B?Y3ZmZTh3bWhKZXpUbUNUV3BqN3lMYXlPckdoUTFkUU5YaDRlNkZRY0JkSlVn?=
 =?utf-8?B?OVhuVlNxd0ZqL2oyU3dMd3dRVENGZldtWmE3Q0hPOWlWVXluaGNYcTJVU2wv?=
 =?utf-8?B?R2k3anBMVHpaQUdwaE52TXQ5UGFkeVV5b214QTQrOTN0ZU1MUU0vYmlXN0Js?=
 =?utf-8?B?eVRTUS8yMCt5NitQek92RXVNS1RWVUhBdFdBTnJUamYvTjdYRWh5aG9CdHJl?=
 =?utf-8?B?WHloU0s1ZkF5NDl1eFBsdmExdDlGM1V0bTZ5eUowV09hUzVBUW5FTFdzSkdJ?=
 =?utf-8?B?Qzgwc0FOU2xlM0s5SVZBYzN0aTAzODBvZ1ZORDJ3Zi8zY29SeTZOaEdUYXNp?=
 =?utf-8?B?bU8vaWtaVW9iK1lvUmJaZWVDZ2dGYzQxSW42c2tQOTRKWlNOWHpnc1FqYUx0?=
 =?utf-8?B?WnVrUTF3LzRzTnpLbXdxTXV3aUVUUm02TGVoUjQ2bjh2WWdybEdaamFhbDVm?=
 =?utf-8?B?aitVcFFNLzBXMnpDVXNTMUlsR215azVkU0RhcG9JeExGZDhCYWlNMVFOcml3?=
 =?utf-8?B?U3FudStNYmN2VDVEcEdFMGE0N1F2VkNTRVJsaDFkMHdRQmV5ak1RVkxib0tE?=
 =?utf-8?B?S3ltODV4cGdnMm93bFBVa2pUdVBENkZDR1lWemwrRGpFYkFNREdMMmx1RTF5?=
 =?utf-8?B?czlhalYyMjh0a1I1czFEUlhTMFp5cENwTHJsb0RWWEU4WUxXSGJPWVJ1Y2Nv?=
 =?utf-8?B?dmd2VE90YWNHUjN5UEpkK3EyUTFkVmx4NnBFMCtKQUluV0FWWnhKVVBIQmNn?=
 =?utf-8?B?OVcva2RibFpYVE9mK25xL1JrTWVzQlVKMk8rSG5SSzBIbi8zK1ZIUTBKb3hP?=
 =?utf-8?B?ZnptcmpFeHBOM0pWeTVrbmUxN3kyM2RtN2Rld0VJYzd3S2FvRjQ0clVab1Bk?=
 =?utf-8?B?aittSFlUWlVsYTY2cXFOM2Zsc3Vpc2NpVTJWWGJuVWVZNWdMM1hxbTNiSEla?=
 =?utf-8?B?b0ZkRU5TaTBVVlJqMVFiWFh0UjNQOXE2TGJnQ0FpeEZhajBYSUFUUkVNamJz?=
 =?utf-8?B?dC9tL2VJd3Y1WThINHlFY0REYmRNVDJoYlJmTWhOMlc1Y2NRbUZWc0tubjJ6?=
 =?utf-8?B?SkFwT0NJWHYxeWR2YUpBRndJZnI2aTB3UGl3YlRiTjQ5alJrdUF5Y1JWelNV?=
 =?utf-8?B?eTZYOVgvWUpvZmFmZHlNSEQvallIOUQzNHJwa05ibllhbjgyQjR4Qy8rQkNj?=
 =?utf-8?B?eXAxbGZZSFhjTm9mWXBYVGRGdUtnaGwzbDdZZ2hZRDJLVC9GYU8xODc0bCtv?=
 =?utf-8?Q?orMAxbwRFlUhUS63cBEMkqo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0ZUMU9xNHd2UVAvenNuT0VYVGx0NzIyUmZKVmpiY3JGMWdtU0VDcjNlTVhk?=
 =?utf-8?B?L3k4V1VKa0RYRldXSmxXcllZL20wZ1RXUWJ6MlpROFkzajhQc0Jxc0tZclo5?=
 =?utf-8?B?TXJtZmpHaWFmNUJYMjZNUlJpbWNkT0dsT0JqVXNqd3VXSndGWkhmOXlhRDk3?=
 =?utf-8?B?RGt6RkREdHZ3N3JQTXE3bVB4aWIzWm1pMmFZcHNVRDhxcFYvUEJDbnV5Tk0w?=
 =?utf-8?B?ZGJCNzk3ajl5VG5CMVY4dFZyQmdydEdOL3F3V0FFUEgxeTlmMVFWYVIwMDlz?=
 =?utf-8?B?RnVsRklkNlJpUUpxU2xlVjJBWlBpZ3hNTkc3aDIwU1RnRm81NTFGaXRMZlMr?=
 =?utf-8?B?Zis3VEpkMlRBa3lEWXhzcUhDM2ZqYi9HWjA2SExtQXZZNkJieFVxMzNjUEFJ?=
 =?utf-8?B?OER6bDE1SzFGTjJ1eEF0azAxTllCQmRUd1EwUFdzd1dKU1ArUkg3WXpBaU1V?=
 =?utf-8?B?VWh4R25QS04zaGhBdUZhbDlUVDhhNmkwbHBBb256d3A3VWVtbWVXV2FFR3NY?=
 =?utf-8?B?WnFuNWVRTTVaYmEvZHBYQlhEZnd5OElVRzFscmZjNkdyT1hGNWlnQ0J2NXNa?=
 =?utf-8?B?VXBoTWY0QTZXbWRweDZFaSs0TUY2azNCNFU0MnpvT1NndnQ1cExKM2Y3Uy9Z?=
 =?utf-8?B?YWJXUEdUR3NJZWIvQWhMYmMza3ZKUEZqTE52dk0yZjZNNDBGZkYrSmU0Rldh?=
 =?utf-8?B?VEkyam4xcnd5cW1VbXBaVXhiNmdlaXVXVnI3cmtJWkJ3Sm5iTlFYb3lVOFBZ?=
 =?utf-8?B?UXVQZTdsMllMNS9PaEU0b0tYUmlLM1JsQ3hKMEhZQlJrTkwzWU4vUWgzZUZi?=
 =?utf-8?B?TGs5aGtsMlczem9aTTRKNVgyVFNJSEpTZGFrcm02Tzd6VUxxMVFEVEFTTU4r?=
 =?utf-8?B?eEw2eGNqN2s1T3VQOS9sT3dxQUNvYkkwcjkzbERwcWlNaVdaMWRTRktzT2JJ?=
 =?utf-8?B?VEVGZ2gyY1gvcDkzd29EZHJQRmlMdTd6VHU4MXh2aHBGSDluRGN0U29GWlM5?=
 =?utf-8?B?YmkvR3Q2dnlNOHkreFBLRCtMM0cxcTFEWXpyZm95L3JiYnQ4RVFPbGFCLzZZ?=
 =?utf-8?B?WDJrR3g5NlVsd3FPR3U5QVI2bnFMSk0wU0tOTXRqVUxMSjM2UDE4YWo3Q1NS?=
 =?utf-8?B?dWNIdFBGWG9YL2M1K2w3c2NPRnhUdWNFSUFCSmpYOFFiN2FEaWc5ZVdtL045?=
 =?utf-8?B?MUhTRkRrOEdXelBWQ3FCdnVyTXBteXVBNVhVbk5ESys0a0ZlcXJjTFdQNVd6?=
 =?utf-8?B?ZzNMN0MzOWtkV1ZaWkNxeWRnMk9ScFovTmFFRDdPTmp6cEdxZnU4U2JCYW1O?=
 =?utf-8?B?QkpxekpZMUNtL1hSUURYV05qK29kcHNvbXVmeWhOV3JVQ0JKZlMrREREUnBy?=
 =?utf-8?B?SFdnaGRYWk5yQW5hY1pYVVNteTQyT3VwcDhiQWtoSUswaml5YUg2cE5LR1ll?=
 =?utf-8?B?dHY1WDMrVllKNkRiRWl0b2hlWkoxRUlMOTE5d1loVUxoOFVrTk5EUkpTcUJ4?=
 =?utf-8?B?VkpjZGc1cTlnM2R1b2RuWGF4a21FS2t1THVEM2NPaXlTNjhuUHhPVmJsSXpr?=
 =?utf-8?B?U2RlUlpXUlJPcE0ydUh4ZWI1YnBLU2k3OHMwT05TdWNuNXp6N0hXVG5ZdlNM?=
 =?utf-8?B?QnQzTXhUa2o1STBtUWlnU0NEUjVoNUY3ZnB2c1lYVVpGd000Njh1K0gwOHVE?=
 =?utf-8?B?bXRjR1VTVWNiU09JTWZKcVlPTGxkOVViaWNjZ3hadUQ1TW1UZTlmOTlNeVo1?=
 =?utf-8?B?SUJWNDdRdzBkVmcybEF2QzNXUUxxTVZvLzkzdjBQTHlpMHQ3dWxLNzBuQnVa?=
 =?utf-8?B?d0loL2FlU1lhWVFsUWpMVVZvMUlFL0YxUGtQUGltVG9vUjNqTHpYYTN1bXpZ?=
 =?utf-8?B?MzgrWUs3Y2FUUnVYMHBGS2YvMTJ3V2xqcUVId2ZrZGNOaU1NWk9YN3k0TDdE?=
 =?utf-8?B?SjJHOE4yWDZFWmtvL1dyMjVTWjVRZU1EV0tEaXB3MTdQK1R4OXFDU3Y3TENW?=
 =?utf-8?B?QjNkeG1UeWVHUjhEc2lzMW8xSkFNekt6WUpSckk4UXNtQVZuV0hzUEZ4b2Nn?=
 =?utf-8?B?aUVDcXQvdVpEcTBzdG50V0xzNHhsM0tva2lhTDQ4ZzRKWlR5N0ZtYVBqcktx?=
 =?utf-8?B?Zm9CaGF3NDl4d09rWksxeFRHRnBScnM5TytxRWV4ejdLbEEzeDRqdkg2VGQ2?=
 =?utf-8?B?cWtOTmhlM1J6TDQ3amhTSWxPNEhCcmlCVDArYjlnUGZMUEVlRGVQOTNJQUVY?=
 =?utf-8?B?OWFxZHNxbGJQYUFvKy81TkpUalQ4TG5SczZ4K0tIc0ZDQlByeDFJSDRMWGtj?=
 =?utf-8?B?L290QnhqaGk5eUdZblgwOS9URmJMMTNrckFPZEZnZ3NNeGwxeFkwR1NYdHZB?=
 =?utf-8?Q?yABgv9Dl5XVRY5pmQcsOZSWb+rAtJs2wIoAo/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <063846CF274B9D48AF5D2E0E43211903@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ebcc5a-2c01-41a5-8f15-08de6280d2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 17:30:56.7098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSnVlf+jfUcF5vDeDLPwXqzAP4ZpkTFvVDB2t5dQ4c8fFEvsv4PDw0HYVcTn26IqucTodGbHlQx5efcHcIMAzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB6160
X-Proofpoint-GUID: RvGWt6FSTR8SHaacpbWXiFKqxSSMfu0M
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=6980df56 cx=c_pps
 a=VmiGRewH7mEIsprpaxNw0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=K1T8KNkMvT8hTke01bwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mMMtynavxPCLQNFG6YhdIjvFPu3L8blG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEzNyBTYWx0ZWRfX+z+jqX7aUNhI
 jxrUcFdgYtM9s7KPwuWmX3oZhn0Mv6NlyBPrKcq+OFLpnio4I82RpiKTnil4GJIoNm3ZOW0jUFm
 dprAumqcchE2b+ZEKV1cyDjyq+OZRJVv0zZtmFsIOKEka/gmBkfyVbkrYYpgMooUHEiBtm0PRke
 /NFSvVANlnuAr6OnTdeZB16+qHRV7hNNjFcDwtoQDQcwVI+3Ulcpy6XqZwsobyc8uPuNHDzbX77
 YV1axtd9hohyaMzWhG39x4qdIL0/wTXFj+JGCGyH1DZbuFBr0PvrzPcbzpMPSet44a7Ces4P6A1
 mhQo61gShKSKuNzutcMDx0cfKp9PoFIjC9B1MYef2TCpG24onc55M/scD/sbhWGOUV9SGBpEpkl
 Jb+tzqC9Gz017CeJ3JEv+ATeObTExw5hhDjKKgubapI35N96XU7rnM62AzyT5yufN17Y+bpiw9a
 wh2xWkkrhA1xkAQgAlA==
Subject: RE: [PATCH v3] hfsplus: pretend special inodes as regular files
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020137
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[suse.cz,vivo.com,vger.kernel.org,dubeyko.com,syzkaller.appspotmail.com,googlegroups.com,physik.fu-berlin.de,zeniv.linux.org.uk,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76069-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,f98189ed18c1f5f32e00];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C22A4CF9F2
X-Rspamd-Action: no action

T24gU3VuLCAyMDI2LTAyLTAxIGF0IDEzOjAzICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjYvMDEvMTUgMTowNSwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+ID4gT24gVHVl
LCBKYW4gMTMsIDIwMjYgYXQgMDU6MTg6NDBQTSArMDAwMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdy
b3RlOg0KPiA+ID4gT24gVHVlLCAyMDI2LTAxLTEzIGF0IDA5OjU1ICswMTAwLCBDaHJpc3RpYW4g
QnJhdW5lciB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCAxMiBKYW4gMjAyNiAxODozOToyMyArMDkw
MCwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+ID4gPiA+IFNpbmNlIGNvbW1pdCBhZjE1M2JiNjNh
MzMgKCJ2ZnM6IGNhdGNoIGludmFsaWQgbW9kZXMgaW4gbWF5X29wZW4oKSIpDQo+ID4gPiA+ID4g
cmVxdWlyZXMgYW55IGlub2RlIGJlIG9uZSBvZiBTX0lGRElSL1NfSUZMTksvU19JRlJFRy9TX0lG
Q0hSL1NfSUZCTEsvDQo+ID4gPiA+ID4gU19JRklGTy9TX0lGU09DSyB0eXBlLCB1c2UgU19JRlJF
RyBmb3Igc3BlY2lhbCBpbm9kZXMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiBBcHBsaWVkIHRvIHRoZSB2ZnMtNy4wLm1pc2MgYnJhbmNoIG9mIHRoZSB2ZnMvdmZz
LmdpdCB0cmVlLg0KPiA+ID4gPiBQYXRjaGVzIGluIHRoZSB2ZnMtNy4wLm1pc2MgYnJhbmNoIHNo
b3VsZCBhcHBlYXIgaW4gbGludXgtbmV4dCBzb29uLg0KPiA+ID4gPiANCj4gPiA+ID4gUGxlYXNl
IHJlcG9ydCBhbnkgb3V0c3RhbmRpbmcgYnVncyB0aGF0IHdlcmUgbWlzc2VkIGR1cmluZyByZXZp
ZXcgaW4gYQ0KPiA+ID4gPiBuZXcgcmV2aWV3IHRvIHRoZSBvcmlnaW5hbCBwYXRjaCBzZXJpZXMg
YWxsb3dpbmcgdXMgdG8gZHJvcCBpdC4NCj4gPiA+ID4gDQo+ID4gPiA+IEl0J3MgZW5jb3VyYWdl
ZCB0byBwcm92aWRlIEFja2VkLWJ5cyBhbmQgUmV2aWV3ZWQtYnlzIGV2ZW4gdGhvdWdoIHRoZQ0K
PiA+ID4gPiBwYXRjaCBoYXMgbm93IGJlZW4gYXBwbGllZC4gSWYgcG9zc2libGUgcGF0Y2ggdHJh
aWxlcnMgd2lsbCBiZSB1cGRhdGVkLg0KPiA+ID4gPiANCj4gPiA+ID4gTm90ZSB0aGF0IGNvbW1p
dCBoYXNoZXMgc2hvd24gYmVsb3cgYXJlIHN1YmplY3QgdG8gY2hhbmdlIGR1ZSB0byByZWJhc2Us
DQo+ID4gPiA+IHRyYWlsZXIgdXBkYXRlcyBvciBzaW1pbGFyLiBJZiBpbiBkb3VidCwgcGxlYXNl
IGNoZWNrIHRoZSBsaXN0ZWQgYnJhbmNoLg0KPiA+ID4gPiANCj4gPiA+ID4gdHJlZTogICBodHRw
czovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC5rZXJu
ZWwub3JnX3B1Yl9zY21fbGludXhfa2VybmVsX2dpdF92ZnNfdmZzLmdpdCZkPUR3SUNhUSZjPUJT
RGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFr
RWx2VWdTczAwJm09NE5SYlMxaTktOXJHbzJZUWozamdhY0pOM0owWUxsOFM1NG43eUJiRHdxbWlH
UDNvSVVRdzE5aGwzTElQUXBaNiZzPUtoYWxTTzRCUkVxMl93cHRJek5DSmlnN2E5UGx2bHZHWGtQ
c2VHUGdMVncmZT0gICANCj4gPiA+ID4gYnJhbmNoOiB2ZnMtNy4wLm1pc2MNCj4gPiA+ID4gDQo+
ID4gPiA+IFsxLzFdIGhmc3BsdXM6IHByZXRlbmQgc3BlY2lhbCBpbm9kZXMgYXMgcmVndWxhciBm
aWxlcw0KPiA+ID4gPiAgICAgICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIv
dXJsP3U9aHR0cHMtM0FfX2dpdC5rZXJuZWwub3JnX3Zmc192ZnNfY182ODE4NmZhMTk4ZjEmZD1E
d0lDYVEmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJm
TVdLcTRZNFJBa0VsdlVnU3MwMCZtPTROUmJTMWk5LTlyR28yWVFqM2pnYWNKTjNKMFlMbDhTNTRu
N3lCYkR3cW1pR1Azb0lVUXcxOWhsM0xJUFFwWjYmcz1MQkZoTnlYQzc1aG5WcDhhS3BKalE5VUYt
X3E4QUlmYmVvaTdDYWo0ei1jJmU9ICAgDQo+ID4gPiANCj4gPiA+IEkndmUgYWxyZWFkeSB0YWtl
biB0aGlzIHBhdGNoIGludG8gSEZTL0hGUysgdHJlZS4gOikgU2hvdWxkIEkgcmVtb3ZlIGl0IGZy
b20gdGhlDQo+ID4gPiB0cmVlPw0KPiA+IA0KPiA+IE5vLCBJJ2xsIGRyb3AgaXQuDQo+IA0KPiBJ
IHN0aWxsIGNhbid0IHNlZSB0aGlzIHBhdGNoIGluIGxpbnV4LW5leHQgdHJlZS4gV2hhdCBpcyBo
YXBwZW5pbmc/DQoNClRoZSBwYXRjaCBpbiBIRlMvSEZTKyB0cmVlLiBJIHdpbGwgc2VuZCBpdCBp
biBwdWxsIHJlcXVlc3QgZm9yIDYuMjAtcmMxLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

