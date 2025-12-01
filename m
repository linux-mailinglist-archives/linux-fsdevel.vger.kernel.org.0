Return-Path: <linux-fsdevel+bounces-70375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC08C990C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 21:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CE7934596C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 20:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C282580CF;
	Mon,  1 Dec 2025 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ff7Vsape"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070A217F29;
	Mon,  1 Dec 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621443; cv=fail; b=B0rl6v2DRvFkqqJyPV62VhV0Mq8gQ+jijZJ+N/DPIgBWBHXwaAZn6Dm3hwtu86BGJ92QUQG9iOWt9Djpgelr1glwRfyVCIFijaDEFI07+UMrRK4zJe/WBqA8XeEEqz+96GqweLyIWwkRfMbZcWFai4xgAWf3Gpp5LVlj51vanrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621443; c=relaxed/simple;
	bh=NmBFg3ebZ5wYJrR+e0XxzFlmmyZJoXtYYbXmDzo4Usc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=h8L30dAoNwpbWNOJMfO2tn/4pbZb4cbvaAtGWrqNpx9KDmCs29xlzhNd69XIiljS0Lv1A9eVt2bAtWZjAHqT1NOHbhPsjcnOFNjKLHO7moamJcMKm6YhHhRu/RvTNOMwcXuuxqJSEsTyk/AqsrTBMp2uMOcmW/1dXsvfe2GF74c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ff7Vsape; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1CHIUO010288;
	Mon, 1 Dec 2025 20:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=NmBFg3ebZ5wYJrR+e0XxzFlmmyZJoXtYYbXmDzo4Usc=; b=Ff7Vsape
	ZMl2NN1K7nTCPHHp754APIYTsl5pxx9OnqjmoNj7pYltV4GKZBryJiaTxCIXV2mk
	PED5PvmGkaJ+DeMl/Ophr8qx0buJm+IsMWRc0B6zjP2Aqx3I+kIG17GfAyyKyNgt
	9YNI1MImdPKBvbWIwN7HPlmrYrMmOkdGPX0FG1qGescjlC3CJ1vJZYn8FIw3gTOo
	chOokctasaUGMwvhqEZGd4AOLEzR7AXgyjj1TzskFRp1Y0+Kz+G4NfMmivHyyNKk
	PHCEXho7C2k18JCF88tMWC1xvKV5slaWj2vjag1LvDb3cjQsMsOGBfhxvggdRG7e
	xMZAVRBrasAIqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8psd22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 20:37:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1KVSrT017775;
	Mon, 1 Dec 2025 20:37:07 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8psd20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 20:37:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2kXeoO+n7cVPNctoHvCAvxO+E87si42009Drd/Mj3Lb5IkBzBINegvv7opYBBBT+v/GNAvPeew+tU6yQph4E3RFvdOMRDE0xnVvAx/N2ByTrEidVeP+j7xfw7FM18QXcEvY9piPcsdSA/9cdgHTLzEWQmh2+iVGc/tH5ChpFNX7yOe+M3Nr0PjsLzGReCiQK5ubnY2/MjyP7fR4iXZhFIsElg24s+IE/AL05Vn7d0Gd59wB3Cfu/EWF549YFP4q0QsAXdIl/WyYKXp8DJPeQMs9tA8O93QQpO4VZVcQweWeRRTanoDNxJtX3adTQkm4XdnHNHqSCvrkOBBatXIf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmBFg3ebZ5wYJrR+e0XxzFlmmyZJoXtYYbXmDzo4Usc=;
 b=LCUu+JV+pqoXlJ0NhEsnyfQiNXjpjHAv6c5LGXSKV0oEIfrFgNvIHod9gtGzvwGoWDzsQyxHvodnSlsF4jrkEJ/+9MXGtuwm+KLSY3GbsP28hjk7wOFZl+bzVQI4CVzVzetyA5N27zID0ukoOFW3HQL0UYgO7ekyM7gnP+S2ZbVvne8ww3HZ9aFXQwoNFCjB1u4ritRbEUhsCm6+X/HnRsxwT13H0Pg4w4WdUTXjwTZq/65lto3sOqenTZtxXRXguEijVsGnlmFCyeAg8b3nKXrHic2EGxM5k+5C8PPuBD4X2BM5/QPZTWVC6JRiFbe2nZxXX8w6/bGvAixqF//+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PR15MB5596.namprd15.prod.outlook.com (2603:10b6:208:438::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:37:04 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:37:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>
CC: "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index:
 AQHcXtteFGhLPrTb/UieBFUI+djHs7UFH4+AgABrQ4CAAK/KgIAAvdEAgAKmrwCAA5NDgIAAIGmA///0AAA=
Date: Mon, 1 Dec 2025 20:37:02 +0000
Message-ID: <707dd64fa75fbc922cf921be46e7cf023d8bac59.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
	 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
	 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
	 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
	 <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
	 <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
	 <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
	 <2795a339-dc82-4a1e-8c97-87dd131a631f@gmail.com>
In-Reply-To: <2795a339-dc82-4a1e-8c97-87dd131a631f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PR15MB5596:EE_
x-ms-office365-filtering-correlation-id: 2f7e5a69-0daf-4273-6d7f-08de31196271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzlleW02NVU3eEo3NkxXREtDamhyeUhpQi84eFhSbGcrVkFaaFVrajJLWWZi?=
 =?utf-8?B?UjJOeE9qYjNOQitXSm5xbWJRNDBJc2hxK0RTSk1hbzBBNFRmUUdrZGdQTzdi?=
 =?utf-8?B?MktUTllaT1B4UHBibTdKVW5pSFRyMENlblVZNGxQUzdFZUJKczBoYVJLUm00?=
 =?utf-8?B?TlIzRzZtRFBIdzF4aGpTLzQxMVZCMDBuTjZZZ1Vqd01KZ0JXTUpjbDl2bnBB?=
 =?utf-8?B?UDBDTUNaV3FmendrUkMzNGMzdEZLVDArWWF5QjluSGljbWk1TkVDMWVQVTBD?=
 =?utf-8?B?OUxWQWE0QTZobU5DUzBGWStlY2ZmbThJOWNxNVI5d285ZEhKazdIUzhWcmdD?=
 =?utf-8?B?dmF5Vm10Tmxja2RUZlRIUkhPemEyd3RYWlUyNFNZejJRLy8xbzNrTk42N24y?=
 =?utf-8?B?SjN0YTUyU1VFR0NRRDBsU0NrWUtZYTRaTzRNZGg3VFJnWkRvZWloSi8zdDha?=
 =?utf-8?B?bXN3ekpjN1NKT29oRWI5RDBBYk5oOWYyZmlQUHV4M0p1WW9yWEkzUTBZY2Y0?=
 =?utf-8?B?Y2p3bE5PZDVndEpmbzZsNEtxcTJNS2lramRvbjc1TTlwZ1JzUVpCTmF5OGNp?=
 =?utf-8?B?ZjdOQXRucjhRNUc3QmtvcTE0RjF2Ukt2MWpIeEJpMXR6UDFZQkhEZ2dTZmNH?=
 =?utf-8?B?Q28zSzlTaHhxSXArRDAzbkdBVmFpdXRpRVBzNTdzTlZvT0NEa2hhWUphOFVs?=
 =?utf-8?B?NjNEeXJDcHFUSnhYYngxZi9jaFg1K3psS1Q2dWVPbGZ5a1c2aFh3dHV5aGtH?=
 =?utf-8?B?TExoRTBVNlFWSFR2L3NsZEhTWERnZXpoNXVUM1lHaWM0V09McFhZM1VBcGht?=
 =?utf-8?B?NUJtazE2cHFQK2lUejV3NlBZRWJRRHk4dmZ3Q1dzZ3p3S0p5Mm1tUkszeWZv?=
 =?utf-8?B?Rklmd1VFUVIxQ3g2UEpXSUVGb1RydWNHcWJiOWE4enVTSnI4TFErZjFIS0ZD?=
 =?utf-8?B?WHRScGJ3RVVQemxCVzh4ZTBwYTFQejNKU0orMWpDblpqcFJyZmhPWkRKMXVE?=
 =?utf-8?B?NmcxN0Y5Wk5ZNE9QVHB2cFpIeDJ4Rkg2QXhpMmJ2WkxpaWEzbWVFSzdhSTFo?=
 =?utf-8?B?OFFNUzJocUFqS2NxdDRsVHg4UkloTXNyaUJpdzhMVTUyREFSTmt4aEtXVkZz?=
 =?utf-8?B?ZE1lT2c0MlVHWDZZejVUK0hMZ2NhSWNDb200dmc1Z1ZaK3JtVHpJK25PTlNS?=
 =?utf-8?B?WnFWdGEyMVBtWEVsUXJwQWFJUlVqa2lTbXE2bjhwWFg5MXczMkQwUWVTK3hl?=
 =?utf-8?B?VDFzSkMwKzRrckczVXhzVkdPbDloOEVlNG9CMGI5RDZFcEV6Z0RYUjJHMEJ0?=
 =?utf-8?B?RVovb3RWZlFjaVJSMitmU0ZkeHFtZmlmY1JtZFVjOG1HU2hManF4amswdklY?=
 =?utf-8?B?NTNmYWVQYmRueitad2FWTnFIT1JLMThKaVRORXdycXJvSGJFaFlTdUliNUtR?=
 =?utf-8?B?bGpLNjBiMys1RmR2djJGVG1CMzMxUW5LM3NzNmVmRUl5Um5uZnhXdmlPWDQz?=
 =?utf-8?B?cDl6YmpmSm8xZkdIQ0FPWlF1eFFpY1g3dkF6WFJIbERwS3RKYm1LQ1FGd21H?=
 =?utf-8?B?TmFjcU9xN2EwUE9JN3p0bzBSS0dYZFhuL1VOVXF0ZE0xTlNSYTRtMVl5SUU1?=
 =?utf-8?B?VGhtM0ZoTjhhWXZqZndvQ29VMDVKWnZoSTZCZXM3ZFhieFl0YTYrL0VXRlEr?=
 =?utf-8?B?RnVFcFp2Y2JEelRkMHVOOFB1Y2VrZDlHUmFrOGhkQWx3ZkZlbERlTWxRK24z?=
 =?utf-8?B?SlZzTWdvakRpVlBNVlppRVNjM0ZRd2pjVjBNTStaSXNSSkpFdE5yL2ZJWmV1?=
 =?utf-8?B?RHNzUUcvRHBEUS83d21sUXAydWNNWUx5cGRYekNEQVlPTTduQkc1UjJybFRt?=
 =?utf-8?B?dTRKOVFHL0FiYzE1YXIyNC9URExsdHpvRVcxS2lpaDVZTTlnVDRJUHpscjJR?=
 =?utf-8?B?V1Vib0JYRzJiMm1LVFlPQTFFL21Cc3J5ZUJjeSs4bVhwSUx5aEFkeWQ2TWt0?=
 =?utf-8?B?TXp0VlUvdjRpWGRxb0l0ZkNmRHJKaE9FcW9nMzQrT2toc0hYZ0xXdEVaNXJ5?=
 =?utf-8?Q?qqNyoU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTA2VHZUanNjbE9lZVZrRTgycE45a2p4NE5qY1FEek5PVEVOMG9hcURVb0cw?=
 =?utf-8?B?QzVSempTdkVDNUhRMUlKY3pKTnRyS3l0ak0yc1RaRGphMXhSY1N2TjBaT2ZG?=
 =?utf-8?B?ODdOUjlPWmMvU0RpbURKbFErc21XZ3FiKzR6bFkybE9MdGxZV3o0blhJbTAr?=
 =?utf-8?B?Y0Z6VVFXZjdIMGhGSy81SFB3eFR4WUkvemRidFMxaEJGWEIvUEV6WHpVTWdD?=
 =?utf-8?B?N3RxVUtVMTV0TTJhcXBwMkZsb09MbTY2S3Fpa0tVL3B5M3hYOTJNa3NaRWFv?=
 =?utf-8?B?dm1RM0lod2N6d2xoeTNuK2xLNlptWnpadE0zL0hjTCtrM2xxMTJGNDRrOUl5?=
 =?utf-8?B?cVc4cUVOMmtPWVIxSE1lNGlqdm8zY2R1S1Vya1FoMVh2eVk5T2hva3FUQjFs?=
 =?utf-8?B?SHYveWJpMThycmlza3kyTExoalN5SUFVTUhHWWFPUmFpdE5QbnpsbnRnb05S?=
 =?utf-8?B?Y0xWOE9SbFNVVWFTT0VYQ3JITTRJSWJ1Q0p5Skpoa0lITGtaWEtwY0dteUFT?=
 =?utf-8?B?Vk5OcFNrUyt5YTI5UDFFbXkyTS9JbDZlUUF5T3IrTktEN25BZjh4Y05Ddmlz?=
 =?utf-8?B?Yzg3eG5LNHVuaHMra3lUdlVpaXUzdmQvZTZXR01LWmQxbE1Wa1IzY3Yrb0JM?=
 =?utf-8?B?bWkwZFBNRWhiYitKWjRnTTFvdGI3VlYwTGJPVVh6VHRDZTNIRUZ3ZDN4aEFk?=
 =?utf-8?B?MEpMRGh4VUZFQ1lvckpPS3BscnYydmtRdjJJUnhLRCsrQndwcE9ocHY4VFZM?=
 =?utf-8?B?Nmswb2VxY05qNEVTb0VZMnE4SGRPZDczd2h6WUhhTlBvQzA5bWxQV3BDSEdr?=
 =?utf-8?B?dkNUcHRNbGk0ckZLK21MOVRyMmRlUzVNQkwwU3EySFB1ditmVkFMQ2FjbTNl?=
 =?utf-8?B?MFpEM0hocTNBcDB2Unk5b0Z6Rnl0elliR0I0SVdIRGZZMmhLYXZrc216L3g2?=
 =?utf-8?B?TkdIb0RNV0swbk1GeGVHbC8zY2NHZFhaTlB0amxsV3REYWdJRWNHZnBtSjlJ?=
 =?utf-8?B?TjlVMUhRUXNubHdBbFVnaHhlcmtsTDNQY1lmVzF5NUsxWU9heHJKV2FrNStl?=
 =?utf-8?B?Wk9sTnNtQVZjUmFjeVEyY1lWSGhQUXQ5QWpFM2xpWWZLNVp2cGRENVk2ZWVi?=
 =?utf-8?B?emtWbU1HRzRyQ2JLRDZCbXpFN3FQY2NabG9lSC9wY3VvMVhSUXM4ZzgvUlV0?=
 =?utf-8?B?WjBQVng1WXZ1d0paSjZ1RitFeGxYWXJObXdWRlRHS1JBc0xqQUx6SkllSUIz?=
 =?utf-8?B?R01nejZMUTNWcUZHcFExdEIxTlBCUjYwR3MwUm5lY3lFRTFPaTNPejhSaWc2?=
 =?utf-8?B?T1U3VU50NjZ4UmdERDRna1FhTmliM2FNQnNUUWdnK0hDZHU3QUtVOVNEUEZR?=
 =?utf-8?B?SDFFUzRQWTQ3QXNhb1BlOVlxczRyRkh5b24reFdBaVY1UWRJclJaRVZhWkxL?=
 =?utf-8?B?MVB0bTVycDlWTnBYVFJRWDVhV3hMeXBYcklsaWMvcWtBUDBtOUthYng5TkxN?=
 =?utf-8?B?aGpIM2oydGJ5UVYxaThCK3dkYlFyUm5UdDVvQzc2d2dQRkYvZkJxZkQ0TmZw?=
 =?utf-8?B?Y0ZUUXp6NU9VU3duMFpDb0ZqNSt3Z09CYnh0dlF6MlNNc0FNQUNWcmRZTThL?=
 =?utf-8?B?TkJaUXVXeDNmUysveVkzMmRFdW1zOEJTN0tCK04vWVR5ZExsSDE0MU9leTlr?=
 =?utf-8?B?Y3JDa1ByZklESXJyU3hEQ2RDMG5VZGJ5aXpveC9mVTEzYWlJUHdKRUxwTW1O?=
 =?utf-8?B?M0tiQ3p6YWdzMXl6T1RmTjlDbnR5NEZlOURyVGlZQ2pSS3JVTUZJcjVKanJx?=
 =?utf-8?B?ZTRPZmIrbVRidXFNU3hKTU9lMkRVbUVuMm8zWHNGSzRKb0ZWcTdWSnB4SDhR?=
 =?utf-8?B?WSt1S0NuSkRjQlpXYkhnTExaTFFvanI3R0RZK2dNSXZ2NDdzbCtUMmNxd0xs?=
 =?utf-8?B?N0xsOXA0UHBCb3lKd2xUVklKc3Rid1VvV3psb3c3V0FXSTQ2TjMweVBzTkhs?=
 =?utf-8?B?VXdjRXUyS3J3azV5Rko0OUR0L3NGZG9NNXpLMGFMR09wM3F5RUhZdzBBQytX?=
 =?utf-8?B?aW9YUUFicjdkUTBBTFdvN3ZCZ1JGMEw3cFQ2cDB4SkZGSUw1OXRDalhrcERI?=
 =?utf-8?B?S0hkZjYzOUNjQ0k4UVE2MktQMWhtOWZoWE5LTk1DTmJ0Vk9tclhSSUxrMW1S?=
 =?utf-8?Q?USDaMMFrqAOG6fN2s4eNprw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAC63534D56F004CADA2485622CC329F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7e5a69-0daf-4273-6d7f-08de31196271
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 20:37:02.8666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XS5XTg94FyzXb63DCmjlualpJgdXvPa9u2v7H4gCP/qpLGQIjBRrVleHU0RgLS4NhD03BL8+6wjfJqcKjhHiwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5596
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX1GSKz6lVJjjb
 +aMBNYRU4Bb6a5hLsvPkDg38UBh3tDMCydTMqSM4ebj5BBpDz8vuWxJLLklpNT+p7IRcsqVdi9R
 5gAqwdT+0oJbDhS7RdwmrtzGj4/XWFvHlCa9eqqAJoyqQgurzsn3DIlvJ9dsCixTOftfbV9NS5x
 4WmkbxwV0X5GMfiidSvp53Kyc2n0qhy8sqYt2+xx/gLeayLT+oNxjyr2KQ0t+1j0FhoUCcXkGES
 LZh4bTcWp2kZksDrki/qfjAkimGU/1CkMmvlBukoC23ezosZPdOuH+W3E96EXkIzlcYSuAptGTA
 uhCvsgq2o6Vcb1e/MGDVhQ29WUCPZnBW2yaxvQa+LvWuUSx6EqZMWd2UKZUgIWS4K+yaPUOp7xb
 Q3r9T6PM0aQIjjGRh4tkZONbO7amRQ==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692dfc73 cx=c_pps
 a=e24IK3jsPB00aLvKg+wNHQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=D9v_i85cmq7yiCMFt94A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uBpbSZtMsT6gWlwPQW6opExR_tvU3D41
X-Proofpoint-GUID: 9iniYCE3mPKZr6-QAvyagkGbhpLBKt_W
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

T24gTW9uLCAyMDI1LTEyLTAxIGF0IDIyOjE5ICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZh
IHdyb3RlOg0KPiBPbiAxMi8xLzI1IDg6MjQgUE0sIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToN
Cj4gPiBPbiBTYXQsIDIwMjUtMTEtMjkgYXQgMTM6NDggKzAxMDAsIE1laGRpIEJlbiBIYWRqIEto
ZWxpZmEgd3JvdGU6DQo+ID4gPiBPbiAxMS8yNy8yNSA5OjE5IFBNLCBWaWFjaGVzbGF2IER1YmV5
a28gd3JvdGU6DQo+ID4gPiA+IA0KPiA+IA0KPiA+IDxza2lwcGVkPg0KPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhlIHNpdHVhdGlvbiBpcyBpbXByb3Zpbmcg
d2l0aCB0aGUgcGF0Y2hlcy4gSSBjYW4gc2F5IHRoYXQNCj4gPiA+ID4gcGF0Y2hlcyBoYXZlIGJl
ZW4gdGVzdGVkIGFuZCBJIGFtIHJlYWR5IHRvIHBpY2sgdXAgdGhlIHBhdGNoZXMgaW50byBIRlMv
SEZTKw0KPiA+ID4gPiB0cmVlLg0KPiA+ID4gPiANCj4gPiA+ID4gTWVoZGksIHNob3VsZCBJIGV4
cGVjdCB0aGUgZm9ybWFsIHBhdGNoZXMgZnJvbSB5b3U/IE9yIHNob3VsZCBJIHRha2UgdGhlIHBh
dGNoZXMNCj4gPiA+ID4gYXMgaXQgaXM/DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJIGNhbiBz
ZW5kIHRoZW0gZnJvbSBteSBwYXJ0LiBTaG91bGQgSSBhZGQgc2lnbmVkLW9mZi1ieSB0YWcgYXQg
dGhlIGVuZA0KPiA+ID4gYXBwZW5kZWQgdG8gdGhlbT8NCj4gPiA+IA0KPiA+IA0KPiA+IElmIHlv
dSBhcmUgT0sgd2l0aCB0aGUgY3VycmVudCBjb21taXQgbWVzc2FnZSwgdGhlbiBJIGNhbiBzaW1w
bHkgYWRkIHlvdXINCj4gPiBzaWduZWQtb2ZmLWJ5IHRhZyBvbiBteSBzaWRlLiBJZiB5b3Ugd291
bGQgbGlrZSB0byBwb2xpc2ggdGhlIGNvbW1pdCBtZXNzYWdlDQo+ID4gc29tZWhvdywgdGhlbiBJ
IGNhbiB3YWl0IHRoZSBwYXRjaGVzIGZyb20geW91LiBTbywgd2hhdCBpcyB5b3VyIGRlY2lzaW9u
Pw0KPiA+IA0KPiBJIHdvdWxkIGxpa2UgdG8gc2VuZCBwYXRjaGVzIGZyb20gbXkgcGFydCBhcyBh
IHYzLiBNYWlubHkgc28gdGhhdCBpdCdzIA0KPiBtb3JlIGNsZWFyIGluIHRoZSBtYWlsaW5nIGxp
c3Qgd2hhdCBoYXMgaGFwcGVuZWQgYW5kIG1heWJlIGFkZCBhIGNvdmVyIA0KPiBsZXR0ZXIgdG8g
c3VnZ2VzdCB0aGF0IG90aGVyIGZpbGVzeXN0ZW1zIGNvdWxkIGJlIGFmZmVjdGVkIHRvby4gSWYg
dGhhdCANCj4gaXMgbm90IHByZWZlcnJlZCwgSXQncyBva2F5IGlmIHlvdSBqdXN0IGFkZCBteSBz
aWduZWQtb2ZmLWJ5IHRhZy4gQ29tbWl0IA0KPiBtZXNzYWdlIGZvciBtZSBzZWVtcyBkZXNjcmlw
dGl2ZSBlbm91Z2ggYXMgaXQgaXMuDQo+IA0KDQpPSy4gU291bmRzIGdvb2QuDQoNCj4gQWxzbyBJ
IHdhbnRlZCB0byBhc2sgMiBxdWVzdGlvbnMgaGVyZToNCj4gDQo+IDEuIElzIGFkZGluZyB0aGUg
Y2MgZm9yIHN0YWJsZSBoZXJlIHJlY29tbWVuZGVkIHNvIHRoYXQgdGhpcyBmaXggZ2V0IA0KPiBi
YWNrcG9ydGVkIGludG8gb2xkZXIgc3RhYmxlIGtlcm5lbD8NCj4gDQoNCkkgdGhpbmsgaXQncyBn
b29kIHRvIGhhdmUgaXQuDQoNCj4gMi4gSXMgaXQgbm9ybWFsIHRvIGhhdmUgdGhlIFJlcG9ydGVk
LWJ5IGFuZCBGaXhlcyB0YWcgZm9yIHRoZSBoZnNwbHVzIA0KPiBwYXRjaCBldmVuIHRob3VnaCB0
aGUgcmVwb3J0ZWQgYnVnIGlzIGZvciBIRlM/IEkgZ3Vlc3MgaXQncyB1bmRlciB0aGUgDQo+IHNh
bWUgb2YgdGhlIGRpc2NvdmVyZWQgSEZTIGJ1ZyBzbyBpdCByZWZlcmVuY2VzIHRoYXQ/DQoNClNv
LCB3ZSBoYXZlbid0IHN5emJvdCByZXBvcnQgZm9yIHRoZSBjYXNlIG9mIEhGUysuIEhvd2V2ZXIs
IHlvdSBjYW4gY29uc2lkZXIgbWUNCmFzIHJlcG9ydGVyIG9mIHRoZSBwb3RlbnRpYWwgaXNzdWUg
Zm9yIEhGUysgY2FzZS4gQW5kIEkgYXNzdW1lIHRoYXQgRml4ZXMgdGFnDQpzaG91bGQgYmUgZGlm
ZmVyZW50IGZvciB0aGUgY2FzZSBvZiBIRlMrLiBQb3RlbnRpYWxseSwgd2UgY291bGQgbWlzcyB0
aGUgRml4ZXMNCnRhZyBmb3IgdGhlIGNhc2Ugb2YgSEZTKyBpZiB5b3UgZG9uJ3Qga25vdyB3aGF0
IHNob3VsZCBiZSB1c2VkIGFzIEZpeGVzIHRhZw0KaGVyZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoN
Cj4gPiANCg==

