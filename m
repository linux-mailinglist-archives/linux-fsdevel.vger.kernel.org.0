Return-Path: <linux-fsdevel+bounces-70369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5C5C98EE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 20:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FA24345C7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 19:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C9225A334;
	Mon,  1 Dec 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NBD3+XYZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776E36D513
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619065; cv=fail; b=GxbPTBqX4UHj5ZDCZe7SPEnFASOE53Tt1lfel2w4W0ZjtqSxfhVCizOKCKVBADyYMfTo0OeO/ezKwyXshCMbl88pTIBMpJWpjr1lgCGpuROJM/QQ8X4JOetNDJUxjyUQoPa7i9k8JAGBouO4PxSzt8ySaBtljptgEtpY9f3NtZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619065; c=relaxed/simple;
	bh=wX66C9EyVFHKt8AaD8wDqBTKiSM/o6zs2VaJW7X7cp4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kt+uKW2z9J8u3lhT89/+G05ymtkxe8uCjZsFpJ0Bh18rXh/2eqSoLtmn8+/oyGKrQd9RaB82rtOMbyB5V76KKtwDQL1YR/TEWnDFaykoFr/yy6x5nx4KfH92FE3UhdJPol2fDGvnooHYVC6tllxOLhFrTav7sA+z7/L3E0TzXkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NBD3+XYZ; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1Cdond010952
	for <linux-fsdevel@vger.kernel.org>; Mon, 1 Dec 2025 19:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=2Z45zNkN0zTB40NxfQopVxTjCkwx5dcqt3ciGlU4yNY=; b=NBD3+XYZ
	pLy7v5JFMYp0xilfbOXwBj9mLR4CafJDZBYolO9UlwNPJ/MNz1Hkr1896S9mkiFs
	KL2yeUkQmKIGorRkQ1frOMqth6LnJvByec3oylLuWkMU3y/tEYsoCHl6HriUWINp
	dsp/xXqFv4vJ/EqTT9EKdKjR1hs0ndnb/vK9afDpk3RUnJSqgqD/JWA4gv82WjNS
	ySgwd1kHoK2E1uHX121sO7FDxTvuRks4VEZ6OdDmH983izcd35RpnOuiLwFxzWs5
	PYNzyptitU81SWbg0/VkZoY1VU6DQjJLi+5uWeaMs6cw43I38aZLMbLEh9OJpl3d
	1yXU8IEyH2vsKw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh6s6pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 19:57:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlNiiDVxTzl0qwNX/DS0EnaqyvvAb+gllsidv9sGzOxzuv3BLf1lZpIHXjDGUNHpiqxhHhWx4Zkeno4r+k/+Nu4CkHMrTxciiuZ4Ud5syvQGXj9kzGGviT+Dob2ZQ/se62eJRk4HymeitwWoha+XX0jiCv5YSyaL54WP4IMPmQ6qeX5TOtOP9ZDOTD8n4HytJpOq8Cz31t5HXyvC0133K42iVD059pxr/dd8ts9lKUJJuz/Ayrsa07m5FTYiBSDvC2RZX/dWUyYSdQe1zZzgmvbBoBIP/9AnHT3iXO4VbOeeVNz3jZ9rFyuujpZ4NtFN+K9XbTGX6mfLVtSd/5udmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUibX05EZPiQo+IW+868rFQfO8FXdVfEXE7ChlhnFCo=;
 b=fUHru4dAU41EpISlg3rDLYPhIf9Mv0kjmhRWltJYPi8y+LXmCTkXIeF1w3jnVXVsNis0ce28oJhkzNUkFBocVjbmIONNhKIEayyxjkD/1MczMPIm6gDItl8zXgiHz5ivXQB3tkNrwlORXBICbFglWxcAidfjgG0Xhu7nrkSrcNYjiu2rLZbHveVyCC9ug0XYnt5GZsT+odyyRvUqhJoi4cze5GMJhr6AuqtsYeJgl0iwWf4FOJ/66vbFnVSr+hEJ+W7ya1f90MZNxnOTF92ClmrKRGK7AplHZdNMJdM57nKk80QpdKTqmembDYjNVJ1cYGq5t92kZ4Zwob6YS00pCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5735.namprd15.prod.outlook.com (2603:10b6:510:28a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:57:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:57:38 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com"
	<syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] hfs: replace BUG_ONs with error
 handling
Thread-Index: AQHcYji9bfNeKdSA0keMcO3nIJ+XxLUNNQqA
Date: Mon, 1 Dec 2025 19:57:38 +0000
Message-ID: <01e9ce7fb96e555f0ab07f27890b0ed3406a92ae.camel@ibm.com>
References: <20251125211329.2835801-1-jkoolstra@xs4all.nl>
	 <18cf065cbc331fd2f287c4baece3a33cd1447ef6.camel@ibm.com>
	 <299926848.3375545.1764534866882@kpc.webmail.kpnmail.nl>
In-Reply-To: <299926848.3375545.1764534866882@kpc.webmail.kpnmail.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5735:EE_
x-ms-office365-filtering-correlation-id: a62ad84c-a55b-4c0e-6146-08de3113e15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlFjeHZuZ0xjZVY3STRjWWJIMU9wbFYyem9qYTE4b3lGUHZMUElaUGwvWjVL?=
 =?utf-8?B?akg1Z09OMitQOFNnZWpsTGd1aFU0WW5HT1YxcGNoaEdiQkRteTlySGJKVlY3?=
 =?utf-8?B?SFBjS2YyNVhlcS9KMVpXZDQ1Z1ZWZmlnVlNzRjF3YlNReUN1L2VGdXVnYjdR?=
 =?utf-8?B?VDNsT3YvMEZZQitjRjhzaURKK2h2aktvYWV6ZDBkWHY5NVB3ZnBDMTI2VkdD?=
 =?utf-8?B?WmhldFBWckV4cUg1Z0pUdWh1OE9POWd2V2VjZHJ2SmljbDZUeEFIU1hHaE9q?=
 =?utf-8?B?Ly9ad0lVbVhUbWxRM1FTNzBXdlZ1bHVEQkRVMS9GUXR1L2dwOThuZHExYTZa?=
 =?utf-8?B?TXkzaDhRQ1ZlckI4SEVuY0s3UFdyRVdsbm5tc0ZRSEtzcGFpdVZkWUU1cXUx?=
 =?utf-8?B?dXlVNVMvbGNsUUMweTZxc2JYZjZ1UzhUN0xuNlZ3MEw4S3VISUJhK0N2R0Vt?=
 =?utf-8?B?R0IwakVoVmZka0p1a0tNdXM2VzdiNW5CYjFwT0ZmU2tabCtiRjJQUzEyMFdw?=
 =?utf-8?B?NGgrSWoxSWxuMndhQzFTWFBTYUdua0grSDdta0U5cEtMNHM2OEVIYkFUWnBD?=
 =?utf-8?B?NUVvMFc1aE5VMDZNOFkyZFh0Vmx5Y0Y3ODNScFdmbk1uSnN2VnNKdEZPM21B?=
 =?utf-8?B?MXZ5QmdOeGNBOWJOa2M1ZjhSdVlhL1VYWkFkNkdKd1JDbGM5Wkg2TUZ6K2ZD?=
 =?utf-8?B?UVRZeEh5TVN4TjZQSlFJbERoUUNWYVF1aWgwNXhmMk1sR3lCbWNoL1Btd0dO?=
 =?utf-8?B?Q3hLL3ZsdU9ZVEtleitxNDFZTTdadU1sekd4cXZlc3pVMFhpdkhDNzJpWTN0?=
 =?utf-8?B?MlJMaTFycHpxR0lMOS9BZ0NuOWUxTnhBdGxPNGQ2UWxTWFdmclJFRDFpMlU3?=
 =?utf-8?B?VXdFbkFlT3ZXUSsvRUtsZEtKNU55TXRKMjhxdFgwckZFVXVZMG93eDZHenN1?=
 =?utf-8?B?anhZQ0NtQ0NtNXRmQVJ0WkpKVkZOL3pLd2EvWGNQTFplYXBSM21sT1pkWkgy?=
 =?utf-8?B?ei9vWGhyVytZYjJWdjFLSk8xd2N1ZTQwNVRCUWdCTHVZNVRVQytGaWVCejFm?=
 =?utf-8?B?ZlpyekQzdEV6WWZUWEdyZTd6M0RINXBJRkdQQ3ppZzNuczRIS21FM2dxWnBa?=
 =?utf-8?B?SFcrUWZlWW9zMGlybkVnblREOXdaWDAra2tJN1lKWFJjU3RpR1pZUFJ2cDZj?=
 =?utf-8?B?eEt4VHJmaW5rbVUwdVZBaUh2MWlOaXR6bnZMVFFqZWJXT25raTFpUXdGTDln?=
 =?utf-8?B?aWpZWlAyN0ZETXduYWVJdVdSMWRpS1M3T3NncExCWUJBc01TLy8yRjVWY1F4?=
 =?utf-8?B?Y0l3WTh0SEg2VGdjaWI5Vm8xMU5VK2ljS2dlU0lDeXM0WjVyREp4YmJrVFRN?=
 =?utf-8?B?dzhDcDVmR2IrMDhLVElIMDZmZFJIQ2xDaWtLRCtTcUN6QTQ5VHpXaWJMVUdV?=
 =?utf-8?B?TnY4NmYrZFBIcC8yYThoNXR4RDFyNjV3SFVjb2JHOWYxR1Nqdnh1ZUZkbU1W?=
 =?utf-8?B?RzhibHYxa1J2bUtITzNTMkMrSlJzdDYvRUdLMDV2bXZHS2lhRldkdmlabFNu?=
 =?utf-8?B?MDgyVmpDaGZqdGNFUjZjS0kveHJXR3dvYWlMcjFOZmJQUUZzRnRyV2c4Tks0?=
 =?utf-8?B?Q2FZQVAyVUtWNVRjbkw0cHQwTjA4cHlGNUlhelZESjdHamVseksxNkprMlRj?=
 =?utf-8?B?NTd5UTE1MFROcGs0M0FaOXRXZjcveUNQSW1SK2lqeXNGZlAvV0EvMXlCMUs4?=
 =?utf-8?B?K1QzRTByelJEa05LbXpwVDhjODhHYlUzY3I5QTRYSndHbjFiTWxndldKcndB?=
 =?utf-8?B?Z2huOWxZbTR0UDBvc05UcGJ4QVZXaG5qZDlZM09IVlZLR1hTYzVvaU1IWnYy?=
 =?utf-8?B?N2paNC9KQmxRSTZXempHTHJ6c0wvM0lRRm5jNkNPaHZxK1IrcFpqRUJKbHpS?=
 =?utf-8?B?VmgyVSt6amYxNTc1NWN6SXhvdDI4SEkra0JSN25hUFYyZCs0R0VYeVE1eE03?=
 =?utf-8?B?OFhpWEFublFMcGw3S094Tmg0V1VFODVGaitiSE8weGh5K2lvckovckg3VkNL?=
 =?utf-8?Q?jMVJOB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2huajltZ21wTmxyWThBemwrcGtEa2xZeEtTVkZ1SU5IUTVDdzdQRVNrQkdX?=
 =?utf-8?B?T2R1YXV5U0wvUVpvNmYzcmkrYVB0MyszMFlIZzQ5cWlYcjI1TEdaNmd3SG9K?=
 =?utf-8?B?NlJUb1pWZWg3U3Eza0l2THJ4U2hTc1hVQzdJWCtUWDRyS3BRWWFBRjRpTW5i?=
 =?utf-8?B?Snp3RW5mQzBzaGtXbXlCZFBuYTF0bUlXeEI1Z2pQaWVFY1FqdThGNFh2MFVa?=
 =?utf-8?B?YlR5ZUk2SlFMNmZvUUFqazJDN1hjVVc3aEhHbXJhdEJURmZraGhpeGQvTGk1?=
 =?utf-8?B?OUpJWmpLZFZZQVM3VzFKOGRVTjJQcUJjNjlPTjh4UXprOHQrK29VSHdyV3h3?=
 =?utf-8?B?NlRDSXJhdWlXU0FLeE9ERk1pM0tkWnpBV3BaVGZSMXY5dFBPN09TcG5VQ0ZK?=
 =?utf-8?B?eUZHMFVJM1JIY3dZNzU4TW5URWNKNlRrcmcxaWJXSDRuZzV0dEl0c1ZORFkz?=
 =?utf-8?B?b2loOHlreUoyem93d2xkeXM3Wjl5UzBPd2M0Tm0yRVlhR3ZaNVU4OXA1dnJZ?=
 =?utf-8?B?aVBxamJtRm9pOExNTXBuYmdINW91OEpMWWwxQk5MSGUwNml4NjZBRDBpMlhN?=
 =?utf-8?B?TEVMRmNvS08xM1pXOGRxSWN3NEZIY3FJOXFtSnFuQkdKb0Q5NFMvYXBaeUNN?=
 =?utf-8?B?T1J0bDJHdUplYnVEQkJhYnVJRzQxZ0V5WWRrcmlDS1FMcjlDc0FtbzdnSmhJ?=
 =?utf-8?B?T1lpY1I5RUNiM21xTnRiWjEyNjFOKzJjSDJSRk1aMXc0U21WWUdLejdKOGow?=
 =?utf-8?B?Sm5aZHIvd2dNVDBROHhhWVN2cmxldVdhcXlOSFlBV2VmdUovb1RSQW9nYWNP?=
 =?utf-8?B?UHp3VU5rL3h4OW93Y29FSGxyWlA1NHhWa3RGZVh1VDRRQmpOSTNVN0xsOWtN?=
 =?utf-8?B?ekorayt6U29HenJIWkRYWXVkV2pRejFSMjRpWkdjY29yTUozSWR1a1I4dnZu?=
 =?utf-8?B?ZUYreUprMXdtK2VDODlVUG0xRXFzWUsxcStIVDVxMHBjMkVDUjF4dW12cU9m?=
 =?utf-8?B?Vmx1bWx1ZUFFcG5hZFZQd2tCVTNxYk9wVGFCMzhFOEI0b3NlZ09JY0ltNi9V?=
 =?utf-8?B?T3BYcmVBOWpzL21LNHZLUWFqWG5ieHV2ZEhzb2VKZ3VqWjFLbkV5ckRyMm9C?=
 =?utf-8?B?T2hGMzlGN3VmNElsTUpndTNRY3ZTbGMrYnNGaVNLejV6RHRLTTBJdWNHRXBU?=
 =?utf-8?B?bk1oRE40Um16andoRkV2VHpnM2R5TFJLS1NhYnVrUWVBcUZ2QmFNdFZndVVH?=
 =?utf-8?B?Q1JEc2t1K0tWY3labTlkektoait1cTYxeVZMNThWNjNaL2RFSU5iNXpQZEJm?=
 =?utf-8?B?aXR2VmIvR0JwRGgvcyt3bTdoVFpFUk92Vm5sOHJZdEMwS2s3M0Z3MThUa1dl?=
 =?utf-8?B?SW14RkExQU92Q1R5aEpWQkxjeG5IWGU1T0hJR2J5ZHJmdTRzUzNIeklDSEVk?=
 =?utf-8?B?eS95bW4wYW4vZzVEaWRtS1N5bnpvN0RxWndSMkZPTGxZd0lPMDAralRPWHVa?=
 =?utf-8?B?VHhPNWtDS0c1ODJuSG5ueHRQUUQvSGV1WlI2NGFBVEVINEVPYUFWNFdsSXkx?=
 =?utf-8?B?OUMxKzduWllML2gvWCtSMUd3b2dCNzNGcWRWL2VFbkVNMTFTcTFWMmZHRFV4?=
 =?utf-8?B?SVdqYnJPYVRYR3lZWERqMmQvSC90Zmk5d3dZVm5RdUZmRXZMdGpYU3Y5U0Qx?=
 =?utf-8?B?WGxSYVlSSEFxM3Z2U3V0YTE1d0lJZEphN2JFVmU5RmlxbUNSQVRsb1ZJRzNk?=
 =?utf-8?B?ZjFzTmRjTmZsbmFJMEh1cEdSdWFMMytaTzRDTHpMZWZwaXg3QVk0RWpyalVk?=
 =?utf-8?B?RzNhazZ2VGNVMUVOZUV4dU1TVGdFMFYzRWxyL0VXVEoxaWtCM2c5ZnJ0NHlE?=
 =?utf-8?B?SkloWHBhTlNHeVd0cmhNYnU3REV2RjFLNFhpOFVjNzFHdWduKzBQaVRta0Fh?=
 =?utf-8?B?SHBITmQ1dEJnMVg2am12RSt4aE54T1pkK2dTOTBqcmRJR1NiYjZSMkszemo5?=
 =?utf-8?B?NXVCWnVkdmpkbFRoYkYvVS82ZTRTaFZMUDJLZjFCTHBac0EwZ3VkUXlhVTJh?=
 =?utf-8?B?LzhKU1Vxek8vbmlxMldwZnNSYThxTnVaK2V3eURBRXdkUnEwMFd2RDNZVWR4?=
 =?utf-8?B?cnV5RGRPQWt4eW1Ka1pHV2pGb2JrckhDN2Q5VDg2WTZpWFZoVG82dGhWWVpw?=
 =?utf-8?Q?fvM/dIhg0fGoFb5O5ZNM3eA=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62ad84c-a55b-4c0e-6146-08de3113e15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 19:57:38.8208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErlWWevnMhO+lp8O+Hcknr+hZDX31MOG/+LQuZXSTiPkps1fj0rN/wCQgGwrafPWJHNKQvGC8Uq26Ojcw5aSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5735
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=692df336 cx=c_pps
 a=xHz2x/H0+t1Z4EfVAX8SiQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=D19gQVrFAAAA:8
 a=a40-EIyirOd4eF8q9MYA:9 a=QEXdDO2ut3YA:10 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-GUID: ua31UFgW2jXKiAFa8vi_4ZEkJfEdRYkr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX5KzlUdXQhgwx
 I30euZKhGnIL7AXJGR/mdWei05CZlEpdu3IRyUJfu/BazehR99iEoYXWlDm8xMF0kEOculgiHdL
 unGmMJIz865ubXwaxg9pBKU3pwyAiuoY/a9TeLwKS5l6nhBCPgIv7zxYzhYAfFxrK9b8EqPI+X5
 IhzV094ArpNsO1sOwx3fIeC5BQB671H3tC1H64fk/roNF8LN4w1UjVodgQ+o7VX/SpKppkICN5E
 fGA+Mzo0QPrXopqdbbkn/V6tPnP7+k26BEa4hpkWOHeFeAv11BlvYN3VJlNCYqBKBR7qKJe47RY
 ykH+w7vtFnV3py6VDeM803Mho0Z4F+WeDcdb7qXC/91imkxlXiPBfrPxPH7/5JNW8nxKPqC7+pA
 +qNlADXWo9oamc7upE7O/v4rM61Ajw==
X-Proofpoint-ORIG-GUID: ua31UFgW2jXKiAFa8vi_4ZEkJfEdRYkr
Content-Type: text/plain; charset="utf-8"
Content-ID: <A94FA900AD18D64F93CB4BF6228FAC44@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] hfs: replace BUG_ONs with error handling
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

Hi Jori,

On Sun, 2025-11-30 at 21:34 +0100, Jori Koolstra wrote:
> Hi Viachslav,
>=20
> Thanks for your time to write such a detailed answer. Your comments are v=
ery useful
> to someone like me starting out in the linux kernel. I really appreciate =
it.
>=20
> > > @@ -264,9 +264,9 @@ static int hfs_remove(struct inode *dir, struct d=
entry *dentry)
> > >  		return res;
> > >  	clear_nlink(inode);
> > >  	inode_set_ctime_current(inode);
> > > -	hfs_delete_inode(inode);
> > > +	res =3D hfs_delete_inode(inode);
> > >  	mark_inode_dirty(inode);
> > > -	return 0;
> > > +	return res;
> >=20
> > This modification doesn't look good, frankly speaking. The hfs_delete_i=
node()
> > will return error code pretty at the beginning of execution. So, it doe=
sn't make
> > sense to call mark_inode_dirty() then. However, we already did a lot of=
 activity
> > before hfs_delete_inode() call:
> >=20
> > static int hfs_remove(struct inode *dir, struct dentry *dentry)
> > {
> > 	struct inode *inode =3D d_inode(dentry);
> > 	int res;
> >=20
> > 	if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
> > 		return -ENOTEMPTY;
> > 	res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
> > 	if (res)
> > 		return res;
> > 	clear_nlink(inode);
> > 	inode_set_ctime_current(inode);
> > 	hfs_delete_inode(inode);
> > 	mark_inode_dirty(inode);
> > 	return 0;
> > }
> >=20
> > So, not full executing of hfs_delete_inode() makes situation really bad.
> > Because, we deleted record from Catalog File but rejected of execution =
of
> > hfs_delete_inode() functionality.
> >=20
> > I am thinking that, maybe, better course of action is to check HFS_SB(s=
b)-
> > > folder_count and HFS_SB(sb)->file_count at the beginning of hfs_remov=
e():
> >=20
> > static int hfs_remove(struct inode *dir, struct dentry *dentry)
> > {
> > 	struct inode *inode =3D d_inode(dentry);
> > 	int res;
> >=20
> > 	if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
> > 		return -ENOTEMPTY;
> >=20
> > <<-- Check it here and return error
> >=20
> > 	res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
> > 	if (res)
> > 		return res;
> > 	clear_nlink(inode);
> > 	inode_set_ctime_current(inode);
> > 	hfs_delete_inode(inode);
> > 	mark_inode_dirty(inode);
> > 	return 0;
> > }
> >=20
>=20
> That sounds good. But maybe we should do the check even before the ENOTEM=
PTY check,
> as corruption detection is perhaps more interesting than informing that t=
he operation
> cannot complete because of some other (less acute) reason.
>=20

If we are not going to call hfs_cat_delete() and hfs_delete_inode(), then it
doesn't need to check folder_count or file_count. So, this is why I've sugg=
ested
to place these checks after.

Again, we could have complete mess of in-core file system's data structures
because of bugs, memory issues or anything else. But if we prevent this sta=
te
from writing to the file system's volume, then no corruption of file system
volume will happen. So, we cannot say that file system volume corrupted if =
we
detected incorrect values of folder_count or/and file_count before write. B=
ut we
can say that file system volume could be corrupted if we read inconsistent =
state
of metadata from the volume.

> > In such case, we reject to make the removal, to return error and no act=
ivity
> > will happened. Let's move the check from hfs_delete_inode() to hfs_remo=
ve(). We
> > can ignore hfs_create() [1] and hfs_mkdir() [2] because these methods s=
imply
> > processing erroneous situation.
> >=20
>=20
> One thing we can also do is what happens in ext4. We introduce an errors=
=3D mount option
> which can be set to readonly, panic, or continue depending on the desired=
 behavior in
> case of serious error (like corruption). I already implemented this for m=
inix fs, and
> the patch was fine. However, the people responsible for minix felt that i=
t was more
> sensible to deprecate minix and write a FUSE driver for it. [1]

I had impression that HFS already has it. But even if it is not so, then it
sounds like another task. Let's don't mix the different problems into one
solution. Otherwise, we will have a huge patch.

>=20
> > > +#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
> >=20
> > I don't think that rename existing error code is good idea. Especially,=
 because
> > we will not need the newly introduce error code's name. Please, see my =
comments
> > below.
> >=20
>=20
> For context, I took this from ext4.

I still don't see corruption here. :) Please, see my remarks above.

>=20
> > > --- a/fs/hfs/inode.c
> > > +++ b/fs/hfs/inode.c
> > > @@ -186,16 +186,22 @@ struct inode *hfs_new_inode(struct inode *dir, =
const struct qstr *name, umode_t
> > >  	s64 next_id;
> > >  	s64 file_count;
> > >  	s64 folder_count;
> > > +	int err =3D -ENOMEM;
> > > =20
> > >  	if (!inode)
> > > -		return NULL;
> > > +		goto out_err;
> > > +
> > > +	err =3D -EFSCORRUPTED;
> >=20
> > In 99% of cases, this logic will be called for file system internal log=
ic when
> > mount was successful. So, file system volume is not corrupted. Even if =
we
> > suspect that volume is corrupted, then potential reason could be failed=
 read (-
> > EIO). It needs to run FSCK tool to be sure that volume is really corrup=
ted.
> >=20
>=20
> I get your point, maybe just warn for possible corruption?

We can consider this as corruption only for the case of mount operation. So=
, we
can share warning only if we are executing the mount operation. But
hfs_fill_super() is the right place for such warning then.

>=20
> > > =20
> > >  	mutex_init(&HFS_I(inode)->extents_lock);
> > >  	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
> > >  	spin_lock_init(&HFS_I(inode)->open_dir_lock);
> > >  	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_i=
no, name);
> > >  	next_id =3D atomic64_inc_return(&HFS_SB(sb)->next_id);
> > > -	BUG_ON(next_id > U32_MAX);
> > > +	if (next_id > U32_MAX) {
> > > +		pr_err("next CNID exceeds limit =E2=80=94 filesystem corrupted. It=
 is recommended to run fsck\n");
> >=20
> > File system volume is not corrupted here. Because, it is only error of =
file
> > system logic. And we will not store this not correct number to the volu=
me,
> > anyway. At minimum, we should protect the logic from doing this. And it=
 doesn't
> > need to recommend to run FSCK tool here.
>=20
> What if e.g. next_id is not U32_MAX, but some other slightly smaller valu=
e, that's still
> not possible, correct? And then we find out not at mount time (at least n=
ot right now).
> Maybe we should just check at mount time and when the mdb is written if t=
he values like
> file/folder_count and next_id make any sense. I think they indicate corru=
ption even for
> much smaller values than U32_MAX, but I could not really distill that.
>=20
> If we have this, then the other BUG_ONs should not indicate corruption bu=
t implementation
> logic issues. Correct?
>=20
>=20

It's easy to make conclusion about inconsistent state of file/folder_count =
and
next_id if these values are U32_MAX. Otherwise, if it is smaller than U32_M=
AX
but still huge, then the check of these values correctness requires of chec=
king
all of Catalog File's entries. Usually, we cannot afford of doing such chec=
k on
file system driver side. And this is responsibility of FSCK tool, usually.

Thanks,
Slava.

> > Probably, it makes sense to decrement erroneous back.
> >=20
> > Potentially, if we have such situation, maybe, it makes sense to consid=
er to
> > make file system READ-ONLY. But I am not fully sure.
> >=20
>=20
> See my comment above.
>=20
> Thanks,
> Jori.
>=20
> [1] https://lkml.org/lkml/2025/10/28/1786 =20

