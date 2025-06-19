Return-Path: <linux-fsdevel+bounces-52264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77056AE0F12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 23:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5F71893245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0669B25F798;
	Thu, 19 Jun 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kLNqyO8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5430E852
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750369170; cv=fail; b=Gvb6BgGmbRZawJKJGz7x+dO7YtkfzUntRgUbVqst0Mw3XD2yjJVrtxDo1gEwNCBgav4pExDHEKEf83UNzSqOhNg6Coq0IZU+/+C9ouP/vGIZ0YAoRHqgOM+2N9cw7qNoJ4CaFKSxeRZWeV2ndSKDZn62GAWhr9skoYcGIzoDx3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750369170; c=relaxed/simple;
	bh=JrPAViWiTjKi6Wp/zUwxCWky54x0sM9MgqTrvqG55hY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=XSWiu4AJoFTGHORyhmLydPADU4od1qJK+GXYoIJ5ea73oP0XhgCe4u1yp0M5osrnyjYI7pREkwkPcF/D1IHtCPH8tbe/F/gEbk/V0Y1CPEmM9ZLwbz442VebkgOkhpo0+kEhGyAEzCLOKFngWHczwcahycHD35djzCpPw59n+lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kLNqyO8c; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JKBWOo016163
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=JrPAViWiTjKi6Wp/zUwxCWky54x0sM9MgqTrvqG55hY=; b=kLNqyO8c
	hlhG8B+Z+ZcuaLLWIW5fRUG7qMAA4PuahjvFv71DvZGGFsQ40FlOiV/h8YqELtEC
	cbVPpvOW2724CRaGS+3/eTwO9dfM6ngnvL4V1ehCZGPHi1rxOZ2JMP3kmJVElOW8
	+tcbDa0hjROPibh6RriwwBho6xLvtDni3iroR+aVuIdT2ACPqYrsVAyy+XVWiGVJ
	vLv+Y++R1MGkq6cdzw7crTMaytGVpUrJLLErnmFLtF5nkjvv/uwqz8z7aosgCK1f
	rSUVqyUSmxbH0jUjYgkJpJDtFdsNorrT0hKpFf6BjjOdIzcASVWs1nLFDy4yDh/g
	exy84Gnf1fgjlA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnqk2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:39:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55JLdRWi032652
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:39:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnqk2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 21:39:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZHseYwTKa2442WVRmKDoym9UQ6g+aI/kKRE4HWIji5G9Vn5l9faO3kBy3kAuFigiH6LCKvMtTq/d0xGBGAlEobuHeUC5zGFDgZj2TUTTcyBSN5Q/O84/ASRaMzbONgqatheDLrF04i8rtVtCAJ7z1q8Sh+5qA+3cQ9VWiGdRpXUMRQGCUFy3Wdby518SAp+gwpxdj8rCebuOMPnqCzHdSjGgs0uWq5vnM1vyKfikwbTlalYaJkDw9swVzLW2QRnzbJK3RuIfr2BTqWULULHPJBIqje0x8oTOUDhIuKu0fhH/FnNYN4PMmFXdiEfGH8vxFo4br9yRCZPw4vYm7LGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AhXAqmYzfCl4gLDKOmyBgmUhJRjgDf/PkjFVfUWSLs=;
 b=ul5vRBz70u71fAePSNoiVlzLyIbD+sYyvnHf6am3X9IL4ulufJ+6vH0I9YMedqnGcQZgLoOKtuUGEMiLU7cLrSi4rjK9Hyd8AsrFnASrvP/yunBpjbbS5PGVgm181bnKwRrgVVszxgsGXmdTJnU63uB6v9QpvAl1EAleSNHc8cf/BHRnzLhD4WW02thu4ZeoRhpAZ73Nh3L9LCiW7IoRTb82danXsvUq5z3XGjXNhyKCuuDv2dtIW1ubG2UHZiO+RJyKBcEvg2mlSavg03uQF4mZgxMPIDsdpK47JXGStLW+Iiikk9sf0/iSb1oOioc6bc4DRbu8phEnLmT32/vZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY1PR15MB6103.namprd15.prod.outlook.com (2603:10b6:a03:528::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 21:39:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 21:39:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "lossin@kernel.org" <lossin@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Should we consider to re-write HFS/HFS+ in
 Rust?
Thread-Index: AQHbz2CpCY7FD08WfUuZLsiXLlP+iLPn/LoAgAA8YoCAIsotAIAAIzOA
Date: Thu, 19 Jun 2025 21:39:23 +0000
Message-ID: <a9dc59f404ec98d676fe811b2636936cb958dfb3.camel@ibm.com>
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
	 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
	 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
	 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
In-Reply-To: <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY1PR15MB6103:EE_
x-ms-office365-filtering-correlation-id: ee59045f-045c-4051-f468-08ddaf79c224
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkRZSHVpYXNKMUR2WTI3NlcxRjF3RkVTZWNWdjN1QXI2eXB3clAvZk5SOUJ0?=
 =?utf-8?B?SUlYem4xNGQ2cHdoczkvcU1PeEJVZExuMWw5L0ZSRS9pQVJWeWdRQ2o3bVZr?=
 =?utf-8?B?c1FIem8zbkJQWG1mcjVWMk9ZVmpYNDY1bXdFY0tRbVpyakgxa2gwU1Vwb01U?=
 =?utf-8?B?cDdmWkp6TkdjbW5TNUNzY3RkQ0lSazA3bnlRRGVYQlJPTUZNbXh5ZHNXbzJs?=
 =?utf-8?B?enlhc1dhYmlnKytYOWtwbUp5UUY1VFI4RExoTm1QbjZ3eStOMFc1VzRnYk0v?=
 =?utf-8?B?MXRtUG1HQmwxb1VpdDQxeUE1S2VmUmZZRGwvbCtPd1lzc0ZBbGxlTWVtNmhu?=
 =?utf-8?B?TldvcVdMN25NRGVnaTR0OUdCQ1dGSHl5ODhDVG8yN1IwRlFXc3FxOEVTU24v?=
 =?utf-8?B?NS9BdFBQczZZSVB6clZ0cEJNdysxSTJlRCtGR3U1MFgvVC9XdkRxSXd5dWZ4?=
 =?utf-8?B?YmFsY1F5OFljVmJ3elpLdkUwUWdsK0gra3QwbTl6YlR6Q0ZFNGJZck5aNWpv?=
 =?utf-8?B?enFXUFBNc1paK1h6cDJhdlB3MGF3b3BERkZqQW42VjMrNzlLd1BVZW4wT2hV?=
 =?utf-8?B?WVhBZzk5WDdHZW9HK2NBSjlxOTNaNFMxby9DaTlZOHpkRzNJaEpZOFErOE9N?=
 =?utf-8?B?Sk1FR3ZtUTBFb1ZFV2w1T05HMC94Nnhmako5OHRDVDV5TWJUNUlwS0VTS2ti?=
 =?utf-8?B?ZW1kYWcySVl2Q3ZZK0hraHJKczFLdk1GU3NaY2tiancwQlgvRFE3Q1dWM2tr?=
 =?utf-8?B?V2RWQVkrQS9uNjlER1V6dTVrKzRCT0VicHBmWGtpK3BrVnloRjdiZ0NnUThF?=
 =?utf-8?B?QmVWY3BJSVFsMFBGNFNraFlYenV0Vzc3aWg0anRRRUlvcXZjZVRXRnhQOG9q?=
 =?utf-8?B?QVhhWE1mUlVaWEsvMzd1NEFkVk5sZERaejhVU0xrYkMxZXBHb21KMEpUdEJs?=
 =?utf-8?B?QjRHMGE3Yk42dlBLSHFqM0dzUEhUcVpQSEdRWnRyYTJtVkNEV24vU0pWcEkx?=
 =?utf-8?B?dFN4T3V3TWlZeDZER2xOK1VzSHczek80V2NBR0ZOOUxrOTVMVFlrdzN2bmJS?=
 =?utf-8?B?NDlZU052dGdORFYveGNHTU5veUFHeWszK3M0QXp2akJPdEY2K2YyUHV2TWI3?=
 =?utf-8?B?QmlvdHJGdGtyU0ZQQm12MEdTOXBGOE12YlkvSnBHNjkzK2RDRVRnblhTN3Zz?=
 =?utf-8?B?T0lOMVFLbklwVVMrSFg1SmZOa3g5WDlKa0ovZFVLL25ueWZ1TEJBc0ltL0Qz?=
 =?utf-8?B?ajhvcStyRWU2Vk14NkVPU1lzWlFHNldENGtZTXFwN3Z2QnlCcU5WdVFLSTMw?=
 =?utf-8?B?ZStsOVNWRzA4V2hIWjIzVW5memtndmtydFdiMlRad3FoL1VGV2p2VlJCNVZV?=
 =?utf-8?B?cGs1eCtia2dYTzF3b0FtbnBpb0wzdUdHd2VNWXJZc1BJSjRuU1FCTnpIR2gv?=
 =?utf-8?B?OE9wbmpJdWpQa3hMbENXdHowUWswMWRDNEhPcTM0YitGQ0sreTF0Y3U1Z3NI?=
 =?utf-8?B?TjdTWDI2NVhkVDJ6K3pGdzBsSTl4S016dlR1WllBbEFvU2JSV3V6N1BWb1N3?=
 =?utf-8?B?dnhXT2xpcHFXdlRMZU8yU2FzUzZsRnRGZS9yVHorejRhRUZ6NWxyOHlnajV5?=
 =?utf-8?B?RmVrTTQ0aUVzbE1BdVdjSG9CalFqWTVScnBxQjdaU014c0JJQm82MFhNQU1v?=
 =?utf-8?B?VHh2ZWFXcDJkNERCcURrenY5c2ZVMmM1QVN2dmNZdDJoOHUwcUp2dzVtS0FM?=
 =?utf-8?B?bG1sR0RDZzZIU1FqZ3l3YzlFMnovR0pVS0JpYUx6d3dLQXdrOUp0TytuSDZT?=
 =?utf-8?B?NjZ0end0NGZmNkZRRG1kWUkzOU1jQ0REeVZiZWZtYlcrWGNFZHRybm5WSnpT?=
 =?utf-8?B?R0NxT3p5Y2dSWjQ5SC9sS1FYc0NxdXhJdTFmOUhSdnFFcVk0c1MwRHdhd2xC?=
 =?utf-8?Q?LA7MZrB196M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czVWYXJtMEdjblNZRnY3MnlGaW1zajllTHcvYzA3bitrUllNVTgwdytMRXVX?=
 =?utf-8?B?a1NxL2t1Uk1VOTdERFdtU0g3Nkdzb2lJcklLLzl1d3hSOEFvN2FGRll5akho?=
 =?utf-8?B?NU1CM24xZ3JYWWVtbVRwMklJYitmRElPN0pwdWVGT1V6N01Idy9vS0hUZmpa?=
 =?utf-8?B?b2pBbmdoUU1Ka1JkWVN0MWk0cnpkVkZlTUQxT2dtc2NWT2lTd3ZiUEFET25H?=
 =?utf-8?B?Y0xSR3lCL3ZIUTVoZWZGejF6SzU1b0FSNmI0bVBqUld2blRvbnFVRGhLZ1Ex?=
 =?utf-8?B?SWRoK1JmbWxCalhRRHBUeGJBSWN1WHZIOElvY3E3QlM3M2diT3N0bmo2amVD?=
 =?utf-8?B?ZEp6VUF0dmR2bEtCNUV1WmZvSkkvOFdOYTM2a1BEL0FXb25iMjdNYysrZExE?=
 =?utf-8?B?RnpXU2lFQUwwQmk2Q2FuMTVwNzlYRWpPdGxtY2U0b1ptRHpqMXk2b00wbERT?=
 =?utf-8?B?eW1Vc29WR3dWa2ttOUVGZWZ3cDQwQmdrZzdmWlF5ZURtOXZGZmhOWlM5NElC?=
 =?utf-8?B?TkhzbWUyY25UTElyeGtySGhvclovWFlFTGFQWXNiY3d3THJJSUx0cGp1eUFr?=
 =?utf-8?B?bFg5ckJWdmt6RCtreGVPRWxPZ29CSnY2N1RJU0d6V2c0dXRNdHJ3aTQzKy8y?=
 =?utf-8?B?TTFVYm9xRm9qRG90emFVcThTdWJQR0VWd1NTNWtSMWJGZmFQc0NmeTFKWGFz?=
 =?utf-8?B?bVAyRFFaSStXOGp1ZWxDNHd0M2VLVnZxWTUxTmFrb3pwWklheUJ2TUprWCs3?=
 =?utf-8?B?eGFJMkNaRWM3Q01idTZPTGZ2QndLMTdINCtDcGl5d1RDMW05bTZoejA2VWEz?=
 =?utf-8?B?dm8xOHUvR05YaXpSSlI5dG1yUGh4ODVjeGxaWUUzRXI3Tlk2cnZsbjhzY2dY?=
 =?utf-8?B?cXdRRUNsak5QbStuOXhsWkFlLzlhRmF0ZVhVS1FmLzd2RzROUFQ0NHlWNWlt?=
 =?utf-8?B?KzRWNTlDSWFhWVI3YlJady9oUE9nREJhcDlwMXNYRnNwTG9QbnNHZEVQY1g3?=
 =?utf-8?B?YzYwNytJb3Q3VVdpVmRHYXd0TGNSNk9kYlkrRUUzK2xtdHZvdU1ONGk1dnkx?=
 =?utf-8?B?ZUZnSlNTYlU3TFNpUFI2ZStrUWRhbnRNaGswSFdqRHIvaXdlRnJQRVVEaW9x?=
 =?utf-8?B?Tis1ZGZ2bUFqd2pkS1hENjh3Mms3QzFpTS8zY2kyMHEzRmdRaXF5TFl1SGZr?=
 =?utf-8?B?S00vTmYzeDJwcjloMGR1UExCaER4YjJjem5udnQwVEx5RWhLbmlCRWdKUlFO?=
 =?utf-8?B?eFYwdit6RkFUS3UwRi9UVWJha3NRREdWS0QwMXBQNVdJczB3VW41MUJpMWZ0?=
 =?utf-8?B?NWRsbjdsQXp3T1oyZGJFeWFSRldXNzRVUUtBMkpLM09NTlQ4NUF4ZFV5TGFK?=
 =?utf-8?B?T1gxWnUydmVxaEpzaUhCMEFCZUE1Qm9ONXRsWncvMUFGK2FFNGVLNWpaSU12?=
 =?utf-8?B?OVJySC9JSVYvaHROblVVVWMwT1U4SGVRL1R1MXgzYkM0eTRvVnhMUnkyUzVj?=
 =?utf-8?B?bVZRaWhZQ2ttQ2Fjb3F0T2ZIOEZrMDBPemVTeUZlMFhUNFo3TFBuT2hoL3pH?=
 =?utf-8?B?VHg1WHBwY2d1TXRhSDg1cVlHbXZHWld4RytOSTVTclo0blhwZFIxOVpVTTBo?=
 =?utf-8?B?S2FQdFZuMnZmUzBUbDNFYmw2UVVtTWdPV2REYmFYMjNJQTVHOWdaVURRSW9M?=
 =?utf-8?B?K0VGQ1o4YXpCek5qWWUxeEU5SlBab0tEV2E2MjB2WGFjZEFLeHpNN3JSTWpN?=
 =?utf-8?B?djcyN2d6cktjQ1dNcUwxVHBpQUtRY2RnbHJLYVdGejN5Y1YyM1pOR1ZYVEtV?=
 =?utf-8?B?Mk1OcytFVUFsNGZueUFQVDNRSEdXUUVBbDk1OHc1elVoYkNDVXUvWE1TRkFo?=
 =?utf-8?B?N1pLSENJK05kQ0NFdXZ3akpRSjhRYWNBK3grYmt4SGNXekFMMnV4dENUZm1n?=
 =?utf-8?B?WmVGdi8wRGp2dldheEpURG9YaTAzc1ZQbWZOdFJYMFYzM1kxQ3hZdlp3NnhK?=
 =?utf-8?B?cFQ0RFBUU0Y4RXRnZkJLRXpFZVRWbTRGdERKdWIxK1NrUndQRWwzQmlkTzdp?=
 =?utf-8?B?c21JZjhOSFRHZVBIQ2RuTkE0ZjhwbkhiMCtsQ085ZUlLZkNnUU9FdmphMTBr?=
 =?utf-8?B?bkJOQWZSVWhwbTNOTWhCNTk5NGtBR2M0d1RWaU8wUzUrd21vV1VEWThxZHJn?=
 =?utf-8?Q?SWLej0becMS1atFZgNofb6I=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee59045f-045c-4051-f468-08ddaf79c224
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 21:39:23.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpI4WM08NnxnPS0joYM7zk34P5EKkLAa3fRh4ZyNnQ29/blNr/9Xl6/G+N3uOMufmcvbEZIvI8aimMvCtN7pAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDE3NSBTYWx0ZWRfX74XLwsR5vWTd F6WqlEN/vLeWI/YT0h2thOkIQPoPAscyA6I7hm3mKPDWvMgqSxqv5KkcchYmlixPluYLuoT/4nk v7BPs6YsP6Q1qeu/MO104mmdXTL3ABE04fB3dyuJG+i0nUMB+YPzZcd7CqNs5BxhX04bqLbIwlU
 QaeUfUy6MCjSBfINwBrbJQ2VbAmuYWTphWrHQ17ZXRL2QoBNhzvQgSpF+PG/+sn3hYLwiuxeDAh UmCT/zTG/VjnISQWHEmRrf99r4pIjHseJWA+hDo0njo/jx39VeL7jpQO4ssQI4Oq6T5aBW+K3Nh zdlAX1ZPM748IF3VR786E0CZPmEyXcGqKopqpDarnuszUGcwlZHtr5UjVFmYqOQl09gCp3wQFpb
 3okauO39l5qR2qX8mnruZD/TDGt+Q6JJkRZmvOIeMJ6aiAdLN5n37Xe0jMLY/C6+A0pRrJs/
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6854838e cx=c_pps a=k3z6I4pdfs0t3+GLVInSVw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=rIH98O22OktHME4k:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=PfD2oos9AAAA:8 a=ou8YDYwo2MVcXs8r3QkA:9 a=QEXdDO2ut3YA:10 a=oXWlT9oWAVMySZ1Hvsws:22
X-Proofpoint-ORIG-GUID: qUduFYkbRNYWC2e9OYgarOJuZOJxWEln
X-Proofpoint-GUID: qUduFYkbRNYWC2e9OYgarOJuZOJxWEln
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAD820F7D354FB4DB1156340D532AAF1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_07,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=998 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2506190175

On Thu, 2025-06-19 at 21:33 +0200, Benno Lossin wrote:
> Andreas Hindborg will most likely reply with some more info in the near
> future, but I'll drop some of my thoughts.
>=20
> On Wed May 28, 2025 at 6:16 PM CEST, Viacheslav Dubeyko wrote:
> > On Wed, 2025-05-28 at 20:40 +0800, Yangtao Li wrote:
> > > +cc rust-for-linux
> > >=20
> > > =E5=9C=A8 2025/5/28 07:39, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > > > Hi Adrian, Yangtao,
> > > >=20
> > > > One idea crossed my mind recently. And this is about re-writing HFS=
/HFS+ in
> > > > Rust. It could be interesting direction but I am not sure how reaso=
nable it
> > > > could be. From one point of view, HFS/HFS+ are not critical subsyst=
ems and we
> > > > can afford some experiments. From another point of view, we have en=
ough issues
> > > > in the HFS/HFS+ code and, maybe, re-working HFS/HFS+ can make the c=
ode more
> > > > stable.
> > > >=20
> > > > I don't think that it's a good idea to implement the complete re-wr=
iting of the
> > > > whole driver at once. However, we need a some unification and gener=
alization of
> > > > HFS/HFS+ code patterns in the form of re-usable code by both driver=
s. This re-
> > > > usable code can be represented as by C code as by Rust code. And we=
 can
> > > > introduce this generalized code in the form of C and Rust at the sa=
me time. So,
> > > > we can re-write HFS/HFS+ code gradually step by step. My point here=
 that we
> > > > could have C code and Rust code for generalized functionality of HF=
S/HFS+ and
> > > > Kconfig would define which code will be compiled and used, finally.
> > > >=20
> > > > How do you feel about this? And can we afford such implementation e=
fforts?
> > >=20
> > > It must be a crazy idea! Honestly, I'm a fan of new things.
> > > If there is a clear path, I don't mind moving in that direction.
> > >=20
> >=20
> > Why don't try even some crazy way. :)
>=20
> There are different paths that can be taken. One of the easiest would be
> to introduce a rust reference driver [1] for HFS. The default config
> option would still be the C driver so it doesn't break users (& still
> allows all supported architectures), but it allows you to experiment
> using Rust. Eventually, you could remove the C driver when ggc_rs is
> mature enough or only keep the C one around for the obscure
> architectures.
>=20

Yeah, makes sense to me. It's one of the possible way. And I would like to =
have
as C as Rust implementation of driver as the first step. But it's hard enou=
gh to
implement everything at once. So, I would like to follow the step by step
approach.

> If you don't want to break the duplicate drivers rule, then I can expand
> a bit on the other options, but honestly, they aren't that great:
>=20
> There are some subsystems that go for a library approach: extract some
> self-contained piece of functionality and move it to Rust code and then
> call that from C. I personally don't really like this approach, as it
> makes it hard to separate the safety boundary, create proper
> abstractions & write idiomatic Rust code.
>=20

This is what I am considering as the first step. As far as I can see, HFS a=
nd
HFS+ have "duplicated" functionality with some peculiarities on every side.=
 So,
I am considering to have something like Rust "library" that can absorb this
"duplicated" fuctionality at first. As a result, HFS and HFS+ C code can re=
-use
the Rust "library" at first. Finally, the whole driver(s) could be converted
into the Rust implementation.=20

> [1]: https://rust-for-linux.com/rust-reference-drivers =20
>=20

Thanks for sharing this.

> > > It seems that downstream already has rust implementations of puzzle a=
nd=20
> > > ext2 file systems. If I understand correctly, there is currently a la=
ck=20
> > > of support for vfs and various infrastructure.
> > >=20
> >=20
> > Yes, Rust implementation in kernel is slightly complicated topic. And I=
 don't
> > suggest to implement the whole HFS/HFS+ driver at once. My idea is to s=
tart from
> > introduction of small Rust module that can implement some subset of HFS=
/HFS+
> > functionality that can be called by C code. It could look like a librar=
y that
> > HFS/HFS+ drivers can re-use. And we can have C and Rust "library" and p=
eople can
> > select what they would like to compile (C or Rust implementation).
>=20
> One good path forward using the reference driver would be to first
> create a read-only version. That was the plan that Wedson followed with
> ext2 (and IIRC also ext4? I might misremember). It apparently makes the
> initial implementation easier (I have no experience with filesystems)
> and thus works better as a PoC.
>=20

I see your point but even Read-Only functionality is too much. :) Because, =
it
needs to implement 80% - 90% functionality of metadata management even for =
Read-
Only case. And I would like to make the whole thing done by small working s=
teps.
This is why I would like: (1) start from Rust "library", (2) move metadata
management into Rust "library" gradually, (3) convert the whole driver into=
 Rust
implementation.

> > > I'm not an expert on Rust, so it would be great if some Rust people=20
> > > could share their opinions.
> > >=20
> >=20
> > I hope that Rust people would like the idea. :)
>=20
> I'm sure that several Rust folks would be interested in getting their
> hands dirty helping with writing abstractions and/or the driver itself.
>=20

Sounds great! :) I really need some help and advice.

> I personally am more on the Rust side of things, so I could help make
> the abstractions feel idiomatic and ergonomic.
>=20
> Feel free to ask any follow up questions. Hope this helps!
>=20

Sounds interesting! Let me prepare my questions. :) So, HFS/HFS+ have
superblock, bitmap, b-trees, extent records, catalog records. It sounds to =
me
like candidates for abstractions. Am I correct here? Are we understand
abstraction at the same way? :)

Thanks,
Slava.

