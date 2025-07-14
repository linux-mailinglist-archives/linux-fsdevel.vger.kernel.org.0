Return-Path: <linux-fsdevel+bounces-54902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B220B04C56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 01:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4218C1AA1170
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 23:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615712397BF;
	Mon, 14 Jul 2025 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uy6awcyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96C2236E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535847; cv=fail; b=fQOiYPQrrJ1KBoYhHC7qh2cTjKWo30oaJdWOt0VrtR/wX3xfOU2ftXvE9b13RYN1lKJekFKXZkMFx8klFjkTg8lrxkLpmYsm0tBxwjBdhDpJftTYluA0LV/cK/WivzmxT4MVfSSUu36JvmpdX5RLSzHv5qgk+vkAVGaNWZrupLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535847; c=relaxed/simple;
	bh=NopM2XOLU6NrAdVWE6n5URmDE+j3VNnEJWdtuEaWtIk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HJ0pe3MSFZDlS5PJQmX54ypcJJFTwDQCR3yHgKxDHI/KQhqOs4jic9af3vMhCxn7WF4FeI4IiHyNcKfPMFY+iZlotdGlwzJWsT4Dg6U9MGhPhmF77AxFNhdF030C3IvK6BsFmIy651xq++EGLNDhKRxHWxWqVPJFPZ6dtMLnyaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uy6awcyw; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELbHI3004602
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 23:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=30Hx0mmDqYX6hG3z/Ae3zaOlOFb6O8yJgs+a14mgSGc=; b=Uy6awcyw
	Jb3byKO0h9Z/n9Crrg3835f3cKvgns9VeX7rMMg2yisQIQZhrtUI6gTa8JMHVM+p
	NRv/CvrZdwnbj04dh3v68xrefdu9493kdV6+9X6Q3tJtTTE/aQGO20moJO4MpiG3
	EadjWIEbtSybYtjKOyVWfVpE1C9Xk4W+wuFIiyYyM1SX+OQkDxjD/B0gcYe1N9N1
	LUtQzJZ+eMg6CPL9xOrOBbMovzp1vJDXzH4nqvUIqTzIFPkhWnO2qNSCuWiMKS27
	yRdGsJfqlxImIvTF11AI317/r0KW/QNpc5YSGuRrEkeIwGJYts6wtSIRh1bpT//5
	qNUca5P3h10Prg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6uyfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 23:30:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56ENUiSa028750
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 23:30:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6uyfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 23:30:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSK9Um7kd/UtX9y5VDNQpa8/c3xeg8E8LJA4YX4s9WQe6CHIGcP2Gxki4QH1hvLh08bhBTAvS8b9mllx1yOUmHDYYMpQtTQxsCLTmaZAuOcVbKfjKYGsbmyOG7hmRMOVjOi1jD2iwXOqY4T+Ms5bzwIQi62Sy1M9KlBASF8I6g8ryf04Eb/rDYSb1P82Is5pql9S4bPHwZJoe1f586AuLiOWVRvWM1EhF+TgMJQZxW3F2Otdox6yd/k4Jm1iTH608B6ZR88NjltqMjexHzS8xqnheQQKcd+0XthvtfilVmks4wlUOOzWRVnuSYATQxgcXj+XNUFN1fOZZ6O1/Xu+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HL9WMHheOGuiWCIaQ9HPSBmhCIl+JY7Ii0DpFb3IN8=;
 b=ilwyeey1bNsqSpz/r5IshK3HHlCs1jle38h+LijS3VK5ArePANZl/jvkt7/XiFyTUMjHnJTjGeaI9VNl7tjSCZSsxI4c090J31T/tXyUgO2b03JjWThnMxUoI0BUsHX+GSB/7/3s3TI4ha8vDCCEsXTnUsbfaGQ4w86GRDNDGfXmAJOETQjdWnRJDHp+DfXKx2L7c9ceiAc0og0845IFBfZgEaq6+4CyTF7hgfJ1O7VnNI+0H1WWhwbW/b/shdqIdDi6WjJV1gWHX4nrmiIUgjk7/p7sjiHP8xdcsSUZhCUuxBn0vmpg+OI9R4+j9w5bJAiuMl6hkaypS1npzILIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV8PR15MB6390.namprd15.prod.outlook.com (2603:10b6:408:1e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 23:30:41 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Mon, 14 Jul 2025
 23:30:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
Thread-Index:
 AQHb70qjLuneU93t80+qPqT+jd4L9rQmvPcAgABIC4CAAtCIAIAAS+wAgAA6ggCAAnVPgIAAYIWAgAEuFQCAA/ApgA==
Date: Mon, 14 Jul 2025 23:30:41 +0000
Message-ID: <22cddf1f1db9a6c9efdf21f8b3197f858d37ec70.camel@ibm.com>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
	 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
	 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
	 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
	 <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
	 <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
	 <316f8d5b06aed08bd979452c932cbce2341a8a56.camel@ibm.com>
	 <3efa3d2a-e98f-43ee-91dd-5aeefcff75e1@I-love.SAKURA.ne.jp>
	 <244c8da9-4c5e-42ed-99c7-ceee3e039a9c@I-love.SAKURA.ne.jp>
	 <ead8611697a8a95a80fb533db86c108ff5f66f6f.camel@ibm.com>
	 <b6da38b0-dc7e-4fdc-b99c-f4fbd2a20168@I-love.SAKURA.ne.jp>
In-Reply-To: <b6da38b0-dc7e-4fdc-b99c-f4fbd2a20168@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV8PR15MB6390:EE_
x-ms-office365-filtering-correlation-id: 3df5fbfc-1fdd-4d2e-62ae-08ddc32e72b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzhKaVM3U05XdEJLVFFsYjRzTDVlRUhTSDQ4anRPbHAwWWdiRENORXZrMFdK?=
 =?utf-8?B?QWtEa0lyeGpRMTRCaEV2aTU3My9SQU1EVy9rOG05eXNpVHlUSDhxdkFSeFV2?=
 =?utf-8?B?VHJGTE5TWW16ZngyK1U5WkRndFF3b2orOVV6RUdZWHdVUG44dG1zSFFLTzN3?=
 =?utf-8?B?eEd1aU82eWxNdjJ4QTFyM0w1ZG5WL2VsVmVSNmw3MXZOeFM4OU1QU1VNRVA4?=
 =?utf-8?B?T3BEVjZZd2w2WERUY2lpYXBwUnRiVk93V3RWWXplbEFTZGFFOCt3aGZHa3Yw?=
 =?utf-8?B?YkJUMjhRdTgzRmIza0xja2xTcDJpb1dISGZHa2FuNlB4QSt2WU0zZ0VpUmk1?=
 =?utf-8?B?ZmNTbTdnSVhHUFEwd0ltS3VMalVZZmJiN2JTTksxcmN5WXkxL01VVkI1NG1X?=
 =?utf-8?B?VHJEakxjYXZDQTZrc2RiQ2dBaEtFYnoyK3M4RExrWVQyb0Q1bUlTRnRIVDV3?=
 =?utf-8?B?MXo2bFpiRTAvdTRQc0J0UlpIVEUzZnI4RHptUGlWd0xsdmNRcERYZkkxTGcr?=
 =?utf-8?B?SDZ1M0doNldEL1VZdWhnSm54cUJkRWM2V2tONjVTeVdLNEF1RjFGL1ZjOGUx?=
 =?utf-8?B?MVk3cG5hOWRtSi84cnhmYTRLYnFzVWx0WkdWNTFiTHkzQjVTVkZ0emZ3UUVp?=
 =?utf-8?B?MXF4TjB3aWRMQXJVY0N1SkVKRTNnOWFhd2M1NVpMV1luM21nZ25LK1QwdTU3?=
 =?utf-8?B?R0tNU29hTlpWaEhnYkRaNWN3NUp0K0JCdkNXbEJGeXY0TVhJakRjVTBqTk9v?=
 =?utf-8?B?eHp4WVlITWNPKzE1eFRHQzIwQ3hISGNCc0FqcE82MEZLV0YyTmxYeTU4bmFz?=
 =?utf-8?B?OVZkM3NxUHRiNjhmdW5DbHZqRytOblJ5bytkeEhBZTM4czhBV1N6QUVTazZP?=
 =?utf-8?B?djJ6TjFVdDJyM3Q4NlVWRzh1eURoNjRQZC9nNlI0RzVLZEdxZ2xLUUtJYTR4?=
 =?utf-8?B?TkhFamUxa3NWSlpIK1QxSGRRS2NJMmx6bkZBN3ZlR2dxWkl6dVU4dFgxSExs?=
 =?utf-8?B?L2xxQm85VndsMUV4UnAxQ1BVaUhwUDhXNTI4SWxLWkZydmdoZDlwbmZTMnFm?=
 =?utf-8?B?Qmd4NFdYNDdLOUQvK2h0MU55R3dPZWI1UStOSkNac3AzdVlwdS9iMUkvMncy?=
 =?utf-8?B?RlMwYTdMdnZHRXZMbEJkUVpTYi82RGNJdG9qMHIxdkNBVTF3dDJWTC8vdUJh?=
 =?utf-8?B?MnRLMlNnWERkZm9GWmtxU0ZnWHNOZ09Yd1JoVStDdUlPc2wrN1NiUlJDVitM?=
 =?utf-8?B?cjI5ejcybEpPczRMOTFhek9YN05DdDVtVEpIRFdYWmpBQzM0YVBWTlZ3TnZn?=
 =?utf-8?B?amVhNHVUcWd2RTg0WG9OQkV0RHRCeGNwYzQyLzRoWU93WXBmQzk1S3I5cUR6?=
 =?utf-8?B?MENUVzlzRXJBalg2REdZQzRGTjZsMGtHSEhaQ29TUGkxUWFtWFRhY2pnNS9w?=
 =?utf-8?B?UGl0Q2xQOTJTY2IzWUYvZmtOSzdEc3BqaXZEQmM5ZExiMXBydXU3ZzJDaGV4?=
 =?utf-8?B?RGo2V0tvTFlrZkZhNFBIQmQ3bnlDR2lvZEpVSGdvNm9ScWl2emRtMzY5QTZo?=
 =?utf-8?B?c2x5d1Z1YThUcFNMaThZUVVhN0c1TVZsNy8xVGpVK2Y3cWNSb3IxMENkYW84?=
 =?utf-8?B?UWcvck50VVJTamswMmtEUC9jVW5qZDdLc0ZmQlhKYTkrTTNsb1dycnJlUERu?=
 =?utf-8?B?Yjd6UjA5MHhrb1JJMXFBNHNCRFVZckEvdFJRRDc5K1RrTXQ1RUVUQlMxeFhz?=
 =?utf-8?B?ZFN5RGVmdnI3MncvSGgwb3lGY0p2VTRLaHJMaGdnVTZtYVNJNmlzNTNXdzJj?=
 =?utf-8?B?ZjYzS1F6NVoxMDlIQ2xTdnNyZERwSnNWQUxnMkcwQVNLTU5ldnY4dmxKWkNK?=
 =?utf-8?B?RjhldmRLYTdNd3FwMDF2NUMwK2lHZTBvSm9XU25Ib1BJQkVVRDNyRG1FeXN3?=
 =?utf-8?Q?74mBC+EA1vk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3A1TnRiT01wQnllV25DdndjL0tNakh4VlltamNReDYvK2dadkptT0FQcTNG?=
 =?utf-8?B?a0xkM0xPTG96ZEhPTVlxSzlwOUh4ZmNnUEpxeVFOSEVrUHlyMEwwcGRBNlB5?=
 =?utf-8?B?THNFQjJmWjZjL3lBRmZKbnNYbnJnRk1RS3pJSVlNSmJYdjBQMnIwSDdsMFlU?=
 =?utf-8?B?aXppYndQQnJOWEZlMlhuNkJHUVl3d2VKb21DSyt1VDY2T0hBSDExQXlyaHYr?=
 =?utf-8?B?N2hZY0pHU0c0Uy92cWxTSC9nVHU3MXRzYmxHTkl2VWI5ODEyR0R6QzFaOWZC?=
 =?utf-8?B?amFXQVRjQ0pjK1lBMXlIbjRkRmMrcUtoU2tLbHpQMkpnNEc4NXFScDRqVlZy?=
 =?utf-8?B?STcreWNkUkhmWStkQkNpaTlDYmU3SUQ2MTd0NSsyOWNWM0FHRkY1QnJoRWdw?=
 =?utf-8?B?TmNUREdDU3E1akRPc2pWbFM4SHdLSklMSDB3Zk91WTNhWVZ3dVF6RGt3MGlm?=
 =?utf-8?B?Zm14SDFOMVoxUkVEUEVEUFlDSU9adUtnWVFEYzVhYkh4eVY2NmtVVmN1R1Yw?=
 =?utf-8?B?ZDRiVDhxZlNIankra0xJSXJQZklWelNURDF4OTcyY2ErNUkyeHVCY2hYR0RM?=
 =?utf-8?B?NEN3WG9NaWVyZnZlNWx6a2lBVkp1WERkdkJFaWQvcW1zbmZ6UVVjdUZPbDBs?=
 =?utf-8?B?Yk8rUmdOUUJYaTN6SXA3Z0U2QUtzOHNVby9CaVVpUElNbGk0M1I1YUs0ZVZM?=
 =?utf-8?B?NFprY1lsRnYzNnh1L1QyZXJqOW5MVnJ3NXFrY21zdjlObHpUb3I3VFkxaDls?=
 =?utf-8?B?SUZwVHBkN2Q2RnF3NHRRZ0d3WkdpT1IvUG53RTlVS2drTS9xakxSY1E1dVhL?=
 =?utf-8?B?anNZc2w5d0RBOWdDZEY5VjJVWUE0OFJxejE4S0ttcUdFRk1Zam5pM1R1ZVY3?=
 =?utf-8?B?NzRvQ0laSExNVDJWSlVGTmgzRysrazM3ZG16NXNONm93Q050dWJWTHp2VXVD?=
 =?utf-8?B?SUFYRjhPNjlyaUJLZXFSMXI4SzdmWnRCTktubDZmdE4vSG5lTFRYM3ZhWWRF?=
 =?utf-8?B?b0I0d3krMXR2Y1lqcXpTbHltQzFWcW9qZVl2MHpKQmIxSEhqSlJWV0lDYWlt?=
 =?utf-8?B?UWRYVFlSRVJkREdCckkrTEhtMVVteGYyRjhxMzdrOE1NTmowSlhrY1Y0NkNZ?=
 =?utf-8?B?SWNiZFRxd0ZKWUZ1aUhEbk9iMURrWUJJTThZTUV1eE54dm1DVE82Z3loZkxP?=
 =?utf-8?B?WFhOYS9zdEx5Rjl6R1pRekhQSW1VZVBaUTc0UDgzOUJ1c2FCbnA5Y05TcFV1?=
 =?utf-8?B?c1hPZ3R2OU5NVkh4amMwVVFRZnA5Uk12WjZzYXlGa2orcVEvQjFWbStpV1RM?=
 =?utf-8?B?bmZpcjgzUmV5c1VwZlhkRzlxMHhpWUo3cmlUcFJEUHh5bUsva1BIR2NUMzRM?=
 =?utf-8?B?dnpGNHZyc2ZWN1pXM25scXFSdjlTaEZMRDNDaVZIK2kzNG40VCtkamFMTWpF?=
 =?utf-8?B?ZURMdG01YnJCaVRhRjF6U2VZMUxkSzVOeGdremZWdUpOaFhBYnlRREFrekZ1?=
 =?utf-8?B?d2ZDN21LbG9sbzJ4Yks0N0tKUnU3ckNvdi9LYXVIcE41TmM0VmY2T3NhSGM0?=
 =?utf-8?B?NmNobnlkUW0rTlVBSVpCdFRWeTNsSGNPK283T0cxaUJsNURqOElMQlRqWXN3?=
 =?utf-8?B?Z1VTNkJwTTZsb0p6eFJtQ1RHbFRkdW5QblZNSDF4VWdlR1dLbHpqVURwbndk?=
 =?utf-8?B?MWEzQ2pFKzFxaFprc0RJL2hHNHgzQ3RmWkZmRnFLTXR3d2gybjlWYmZ5Q2My?=
 =?utf-8?B?OVd0WVhxTWZlNndEMkU1SjBMZzJTUmU1by9YcU5lVE1TTHJiVHFLb1RXblNi?=
 =?utf-8?B?OHVNNFkvbnFtV25wckV5YVlVOTlEUFRqTEJPNlZnYVFQYkpOMWIvQkNEd1JQ?=
 =?utf-8?B?akNiRkVtdkZZeVFYL3dQQnp3a3dLVFljcmFJY0RrV3RoSTQvU0dWZTN0MVIy?=
 =?utf-8?B?KytCY0hVUk53NWh4a2xPQksrM1hGaW9MZWc3NDVyc0FqcFh0djF0VXZmRWor?=
 =?utf-8?B?MllTcE02UXVLanhsRlNzbEI3RENJOENaSGJBVDNNRDFnZDhhcGtoS2N6UU9o?=
 =?utf-8?B?WGwzYk44NHFTTGp2NmY3cW1aS3F3ZTZiUEU2K01PbGNJTGJ2aUxyTWlkSmJD?=
 =?utf-8?B?VXg3bXdoWGFtT29hekszaGpBQXhGcFQ4S2lIU1dDMHlDMjZySDlHNFpCVW44?=
 =?utf-8?Q?O56sp5WOYUVY7Zh5xroZ5Qo=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df5fbfc-1fdd-4d2e-62ae-08ddc32e72b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 23:30:41.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uGILd9FrXWAOe045lGpEnyw17L2XTlUTW670NlAi3pSsZODZ5XU61UNfP6z6m0EVysuQbvSecO4nWdxT8sunA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6390
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=68759323 cx=c_pps a=vMXbnMUpKwCM72X2iuP73g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=edf1wS77AAAA:8 a=Dj8CoM2HvXOrBWOLfNEA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE2NCBTYWx0ZWRfX69SyDVp3rIYQ SEmoXzO7GGAWjVU6v7IymGmy/OUXv+tigq5OG1UCn3S9+DuSgSuntlJinr2w8i1E1VAW3DGfINg QfBuKo5exyzjtYHj/AWu4OfwA1YrNb0dNtZA1Dl0KovP5ERuZCy4w71/Huz3643GD8/TgNuw2I5
 jZRvbzZySSZXG0nJHcDxRdnZ9iYwVg23EHIfR+0oq9jtAlADiBZxc04XafjKOlBn5Adg7bbN2AN MqYVuqrEzgThNkWtDlxDW5S3hUqMUeGs7+gaFz/Wt6mEuevSp0NhWc7Y4ClrgoHdTTQVor97ieY oTSyzDZpCjmk2WQ3WErEVcxIOlmHCWHhQn4DCVCNdVAIl0TyDSEnGaK59XccN3ZBbdVoP+ZuatS
 5HbGtm10Z00+pukqTr1uoqF9SoGxXoQf6MudLIhUlDiLgcqvgti2JK/FKPwZqnoyp2yqx7Qi
X-Proofpoint-GUID: BEaOpr55tq3xTn87P4hYeuMWkivOjDX5
X-Proofpoint-ORIG-GUID: BEaOpr55tq3xTn87P4hYeuMWkivOjDX5
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E882522532C9B45AD193DFDF9A1D6F7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507140164

On Sat, 2025-07-12 at 20:22 +0900, Tetsuo Handa wrote:
> On 2025/07/12 2:21, Viacheslav Dubeyko wrote:
> > Frankly speaking, I still don't see the whole picture here. If we have =
created
> > the Attribute File during mount operation, then why should we try to cr=
eate the
> > Attributes File during __hfsplus_setxattr() call? If we didn't create t=
he
> > Attributes File during the mount time and HFSPLUS_SB(inode->i_sb)->attr=
_tree is
> > NULL, then how i_size_read(attr_file) !=3D 0? Even if we are checking v=
hdr-
> > > attr_file.total_blocks, then it doesn't provide guarantee that
> > i_size_read(attr_file) is zero too. Something is wrong in this situatio=
n and
> > more stricter mount time validation cannot guarantee against the situat=
ion that
> > you are trying to solve in the issue. We are missing something here.
>=20
> I still don't see what you are missing.
>=20
> When hfsplus_iget(sb, HFSPLUS_ATTR_CNID) is called from hfsplus_create_at=
tributes_file(sb),
> hfsplus_system_read_inode(inode) from hfsplus_iget(HFSPLUS_ATTR_CNID) cal=
ls
> hfsplus_inode_read_fork(inode, &vhdr->attr_file). Since hfsplus_inode_rea=
d_fork() calls
> inode_set_bytes(), it is natural that i_size_read(attr_file) !=3D 0 when =
returning from
> hfsplus_iget(sb, HFSPLUS_ATTR_CNID).
>=20
> At this point, the only question should be why hfsplus_inode_read_fork() =
from
> hfsplus_system_read_inode(inode) from hfsplus_iget() is not called from h=
fsplus_fill_super()
> when the Attributes File already exists and its size is not 0. And the re=
ason is that
> hfsplus_iget(sb, HFSPLUS_ATTR_CNID) from hfs_btree_open(sb, HFSPLUS_ATTR_=
CNID) is called
> only when vhdr->attr_file.total_blocks !=3D 0.
>=20
> That is, when "vhdr" contains erroneous values (in the reproducer, vhdr->=
attr_file.total_blocks
> is 0) that do not reflect the actual state of the filesystem (in the repr=
oducer, inode_set_bytes()
> sets non-zero value despite vhdr->attr_file.total_blocks is 0), hfsplus_f=
ill_super() fails to call
> hfs_btree_open(sb, HFSPLUS_ATTR_CNID) at mount time.
>=20

Yes, you are right here. I was missing that we have corrupted state of the
volume.

Related to reworking the mount-time validation logic... I think it's not ve=
ry
good idea because hfs_btree_open() will:
(1) allocate memory: tree =3D kzalloc(sizeof(*tree), GFP_KERNEL);
(2) get inode: inode =3D hfsplus_iget(sb, id);
(3) try to read memory page: page =3D read_mapping_page(mapping, 0, NULL);
And, then, we need to free memory and to make all necessary cleanup. It's t=
oo
much activity for the really empty tree.

But we can make some improvement of the initial patch. We definitely know t=
hat
it's the volume corruption. So, from my point of view, it makes sense to add
comment that explains the whole situation and change the pr_err() message w=
ith
recommendation to run the FSCK tool:

if (i_size_read(attr_file) !=3D 0) {
    err =3D -EIO;
    /* explain here how we detected that volume is corrupted */
    pr_err("HFS+ superblock contains incorrect Attributes File details. "
           "Probably, volume is corrupted!!! Please, run FSCK tool!!!\n");
    goto end_attr_file_creation;
}

You can modify my comments as you like. :)

Thanks,
Slava.

> You can easily reproduce this problem by compiling and running the reprod=
ucer
> at https://syzkaller.appspot.com/text?tag=3DReproC&x=3D15f6b9d4580000   a=
fter you run
> "losetup -f" which creates /dev/loop0 needed by the reproducer.
>=20
> I noticed that the reason fsck.hfsplus could not detect errors is that th=
e filesystem
> image in the reproducer was compressed. If I run fsck.hfsplus on uncompre=
ssed image,
> fsck.hfsplus generated the following messages.
>=20
> # fsck.hfsplus hfsplus.img
> ** hfsplus.img
>    Executing fsck_hfs (version 540.1-Linux).
> ** Checking non-journaled HFS Plus Volume.
>    The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
>    Invalid extent entry
> (4, 1)
> ** Checking multi-linked files.
> ** Checking catalog hierarchy.
> ** Checking extended attributes file.
> ** Checking volume bitmap.
> ** Checking volume information.
> ** Repairing volume.
>    Look for links to corrupt files in DamagedFiles directory.
> ** Rechecking volume.
> ** Checking non-journaled HFS Plus Volume.
>    The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking multi-linked files.
> ** Checking catalog hierarchy.
> ** Checking extended attributes file.
> ** Checking volume bitmap.
>    Volume bitmap needs minor repair for under-allocation
> ** Checking volume information.
>    Invalid volume free block count
>    (It should be 179 instead of 180)
> ** Repairing volume.
> ** Rechecking volume.
> ** Checking non-journaled HFS Plus Volume.
>    The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking multi-linked files.
> ** Checking catalog hierarchy.
> ** Checking extended attributes file.
> ** Checking volume bitmap.
> ** Checking volume information.
> ** The volume untitled was repaired successfully.

