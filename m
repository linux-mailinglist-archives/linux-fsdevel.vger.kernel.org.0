Return-Path: <linux-fsdevel+bounces-67381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A094C3D74F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DE994E685F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D530504C;
	Thu,  6 Nov 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gMki7QkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76682F3605;
	Thu,  6 Nov 2025 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463502; cv=fail; b=BP6khbiQ7/aQdBOknBMuYF3lB/XQbHDbniDmf+v9VVaJX5XmcnZs0LelJ7VvoJmjh1NrK3zMNO8lqHP2XZslQJctyPO/CnsyqnmU5S/OmQlnXAmnLLyJOSnVvDcq61QMUsPwRj6zBSX088Xnq12BrttcpWzxlnSsUzefYaw0ibo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463502; c=relaxed/simple;
	bh=2AWgy/ZuGepmVkwRDDwpvRJfD540330T2BQXSzskwk4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LPzsthyeHufxMV39nZSMixjqQ/+ZnskH2Nl+L0KYIR8PXYo67fnFYuHPciaEv7LYpRt8ZdtPT+sHYLgyAqcUXK2VKrEYjvDYjsfEDRVLwLwfawxDpBgmr+5KRz09LOnkmiOZs9CYs463QFnvl9ba3Rh879oQ3a0kxvrzk4soHqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gMki7QkD; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6I7MlP020916;
	Thu, 6 Nov 2025 21:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=2AWgy/ZuGepmVkwRDDwpvRJfD540330T2BQXSzskwk4=; b=gMki7QkD
	X8TJPp+JD+xKFITAwGA9bBNTW4sS1Fp0ty7KEIOx4LRAYEnf71HM3XTQklZND7qn
	C8t29FXMqa3WeQZn1f77QYZQ0GJYy1EzjHGEcIooH7OrgOGvuJgSYfUeDn2EAdJa
	DgUJh+UaqDMPaT/03N7KTezqIMmmwUoWlCgnTGkmsBC2cvkCD8spKV54mC7e86/x
	LiSTxPruFpNwD30wn5hWSazLa+2GDB0Q/Zuu2EFnsVIQWZIq/SgnluidAAn6nABZ
	PIOG5B7JojG64TpkUgFDYYFtuNS6jsZ9hp8lLAFAfCuvOpJoVz6J8SQT5ELInoUn
	lGUcAVdgG+gK5A==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q99h2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 21:11:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVDOjgLgWmb7KNfDPgLo2S+uilOpv/UB7fqjNsUtTlzB3DEVBrAExoAa2PaE2GM6YyMR0uLGk7NEzNwFUs3pQxARO2yP3KSZRQ5UlbloGrQqm0QenCFwGr5RwwvhQs5trJPmVHtBqW/mgHDTKldOjDkZfIyMbO5HWRq2dxKiZLVI7vcMWoXEwwbct9I6ioQwZwuCUFhqF1LZgObzXGnfG1C9uQ3/e7wWVtiCS379JNS+PnDnF4OF0HavPTAXaJkiBBzCfQo94aObxsKGR1rY0/pTPDEYfVyZyWL4yiQOtlg3IK/icvw7dyjZ8/hazrVqwDLtS1sGHWRxqzVXTmcfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AWgy/ZuGepmVkwRDDwpvRJfD540330T2BQXSzskwk4=;
 b=hlR8RfSp6vSFix00RzfKDxHaJ9/o9SpgeiwzdgGmNy7ImK4gonfjlmo5y48jAHab7uPZkQpnOxhvCtzh1Fu4OBNyM2qZ8riHDaD8AW08q8uDXWG+p2fb71LoeZnH9eEcpyEDITw+KEBfzmYI2fPut+Dn08vIJKYRdVjiVcCxh4ehpe98BkKU+W/G4UAtaG8eLN5K+B8Z9MSPbCG8yaTpMq+ih0X5sQa4VdSD70pbw0e5V98gmFrZMrjIAtosL8Y6Qj6c1+SSL426It1iyAQFOq5ymouI2OFgQvBXvoBipatnZjtVKwfvpkhF/rGyoCjZ2ovVTI1BgJ6X5uY2o69cWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO6PR15MB4147.namprd15.prod.outlook.com (2603:10b6:5:353::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 6 Nov
 2025 21:11:31 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 21:11:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "wqu@suse.com"
	<wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Why generic/073 is generic but not btrfs
 specific?
Thread-Index: AQHcT12Yh6lLNevRjkO1oS1HPlyWxLTmIW2AgAADsIA=
Date: Thu, 6 Nov 2025 21:11:31 +0000
Message-ID: <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
	 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
In-Reply-To: <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO6PR15MB4147:EE_
x-ms-office365-filtering-correlation-id: b5ec9303-63d3-47a9-6a80-08de1d790f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rk51dmhjWC9NazJwNXZjbjhYbGJoMGFaSkVOZjdhWnZzb3NCanl6RVROSG1S?=
 =?utf-8?B?L1l1K1hCdFJxWVgvUVRhSnI1WDJkYnBjSjFCc3N1d1lIVGpBQVBZMDY0dWRQ?=
 =?utf-8?B?UGg1b2VrU3RWTGRhTkFscWFMUzRmQlRheEV2NmJSM09TbVh3aVpDZDQvZnJR?=
 =?utf-8?B?UnhtLzFrM1FjdnV2ZExqeHpkMXhxSWdqS2s2Y08ydzFBTU9Qa1B3dnoyRnF1?=
 =?utf-8?B?YkdJZzlZLzRMWDBBNHZXMWJOanpha1BOYWkwY3ducENLYWxjMnV1elJPNlJN?=
 =?utf-8?B?bG5RbmJIVjUwR1RyaHdWaGNudkFEVE4xZitLSVA0T3htV0tkMTJwSWZnOUNl?=
 =?utf-8?B?WmZBYzJXTU8xNWpiMjdadjJ5dkpNZ2IwSy9nUGYrQWRadHBlQ2ZwdTkwLzEv?=
 =?utf-8?B?QWcveVBsT1VjbFl1bUFZN1JnRkUvdEczTHVhQmtoaU1maHpJQUVIbHBQakF1?=
 =?utf-8?B?U0dpNml3TTNIQzlsVTRlNVZhVTFORlJweDhhWnNmeDFiMmlhR29HTElKdTdD?=
 =?utf-8?B?NVh1YVJ4WDRwMmNRbzhBWkhyckNNcWdDTk9QTkk1UXgzQ0Z3S0RBRERhTW5T?=
 =?utf-8?B?WXdSTzVIUUVlSmI1eXlnWC90RFlUSTA2RkxVMlFrUVhHRWNKY3FTcGc0TVBl?=
 =?utf-8?B?c3VuVWlBNk5HY1RoSmtaSTRHT25JTUJqOE5Mdkd0QkZudFdTbzA3MXU0SkY1?=
 =?utf-8?B?M3hPWFhiR2F3SVBrTmlhazVtVTMzSTdreHk0OWFJMU92NG8yRGpOUG02am02?=
 =?utf-8?B?cVpBOHE0VzBZRXZYUmVuWDMyeVREVk1SWWdlc1J4K2ZFS09vUWJ4aFVlM0Nl?=
 =?utf-8?B?UDRKaC82MWlLUm1UY25hK216R2h1YTUyVWh2cHA3UVAzenBoY0ttcDJZbDIz?=
 =?utf-8?B?SUN4WTJCZndtSkc3dWNrZ0ZvdFNYQy9EdFI0VkVMVU95OElYbUxFLzlzZ1VZ?=
 =?utf-8?B?WVJUTExMOERadmV0NUp3V0htd0kwNEhmSFNDT054a2pab0JoSDNiVlhPMnYy?=
 =?utf-8?B?dGNzdWM5SW56WmxKTFFCSDBpYWM3Q3VZWHhkRVVTaVVSaHRCMG1ZSVc5TGVW?=
 =?utf-8?B?UHVwK2JuaDk2ZDZ1aDloZU13cHRMcjZJY2kzQU15VmtBSkVFUVllUHE1c2pi?=
 =?utf-8?B?QUlDR1gyM3VZQm9ZTXpuTmRNZmhyOUZCMG1LeG1nUWo4ZVZDWnVUOTRvWjhX?=
 =?utf-8?B?ZVFiWTNiR2RTYzFiSEFSNUlVUzg0MER5NUVlajd5akV4VUpZVlpxTzBOU3Ax?=
 =?utf-8?B?cWU3bDhpaVFrV0FQME5HRFQ3b0NPTUdFOUZLYlhkQ0FvTU95YmkwVktmOGk4?=
 =?utf-8?B?b1E1dkJRd2k1UVYwdEp6KzI0aWZpT1hVQmYvZFNET0pWTzRCODdmZE40ZFpJ?=
 =?utf-8?B?WUkxRWdBaDV0ckhjeUNVVzJIQkUyVGloTmVrN0gwWnpZaVJMU2E0OTFOSGw1?=
 =?utf-8?B?elhrWnN2TXl4YUtpN1VZaTJOSW9GQnZvQWhUWE1XMEo4MWlBUjVhN1hNUGxi?=
 =?utf-8?B?aTE2Wkk0Nm55U01NRG9hQU93RGhmRjZ4K29LTVp6ZG9tc0w5THRQaFp0MkVn?=
 =?utf-8?B?c2JCSGxyL3V2Q25LSHdCMlpDeFBvMHhzWEsyQ3pPN1R1Z0tDYlkyWjQrUlNM?=
 =?utf-8?B?Qk54RGZ5VTRzVEhiclhTMHlEa2g0SC9EcG1PVHN3d3J0eW5mVGJZQkdYMWxr?=
 =?utf-8?B?cnIxc2REWmptNVNEMExhRnFGUkJJamo5eWFpQTBxQ3BmWGRXcGMzTWhMTjNa?=
 =?utf-8?B?MlNBVVVhaU1XQkFiM0NldUpIcVhYNkVSVTgzTzRVVXdWN3JKeXJFL3NieFp5?=
 =?utf-8?B?OHduTEkyQnpVdU5kTlFxL1gyTG83OUdWRWc2OWIxdWtQeFlZMnM3Z1hGWC8v?=
 =?utf-8?B?bm1OR1BoeHV5WWJQZEtic0Y3SVdjZDdUaXlPanRBVGs5dmV5OGNpdlQ0Mk9Z?=
 =?utf-8?B?QjFuS3o5NFJQWDdoaWptaEkzVkpGWlpzZlk4VGlKelZSZEViMXZtMTNBOEVP?=
 =?utf-8?B?U0tXVS9iS2dQMWxBa2JYbEd1YnNCaTRmYmYySFNYbHFJWFdHZnBpdlVvSUNQ?=
 =?utf-8?Q?tY8k/K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEV6VnU4OVlvYzFLM0FDQ1QwWEdIK0w4VGdocU92R3FuUGFJYTh3c0JRakZz?=
 =?utf-8?B?aTJYZHFCZjV5UDRNNFJGN2VuR2tqNXZGY2FwOG1zb0xub3ZEK3pBSmdqWFgr?=
 =?utf-8?B?MEk5cTRHWnVTSGVWZiticFd5Ym54MFM5U1NSbkd1NXh4ZnE5aXlSdUxpQXAw?=
 =?utf-8?B?c0xTWTJEcmUyNkM5VkJoTlNzS2xxUWUzZ0NEQ08yUThJMDRWaVVPeklmVTRJ?=
 =?utf-8?B?bjlPa1lQZHBUV0kzTnlkYlRSdkg0Tzh2R0s0NG0rVXJkcWhucGtQVHRhT2cr?=
 =?utf-8?B?cXpLMG92Z2tMcDc0MzNZVnd5SkljWFlIMVJVbnRIOXg5TytjdlBBeHpRYmQ4?=
 =?utf-8?B?eVUySm5rY3FzNG96QXBvV3pZT3E4ekxrYWM3VTRTbVMyNCsxQ2x1ZGltSnhC?=
 =?utf-8?B?UjU3YkxiUnVtckJLWDQ5NXZhZFh3SUJrOHdYVzRKUngyZi9Xc0RUT2hNZEUx?=
 =?utf-8?B?d0xVNEtuN21DeFlCSUJFWThyMEdDamtXMDJLUTBUTmVpcnZ5THBXQmM2WExr?=
 =?utf-8?B?UXgyd2NlYTJ4RWNWVDVsU2tzcVJZRGtITEdwUWs2Z2kxNDVCWTVlSndGOUFI?=
 =?utf-8?B?TWdzWmhoQ0M5Q0ZpRnRhTWw4ZUF1WWNHeDF2NG1xZks5R2FmOGx4dVN1WFpj?=
 =?utf-8?B?dTk2SzI1TnQ1NWZhaVE0Tkt5M0NCVzdWNzhwV0lKOHJrM3RQNUlFT3Q1NnJl?=
 =?utf-8?B?SCtGZTdBZ1lqeHo5dUdqa0tubUppV3JKNWJFcUhwSVROTm1PdSt1Yk1oV2JH?=
 =?utf-8?B?VWh4TkdvTHpmN1gzdUR4dHM1VnBnYldXUjJDb3NHRHJud2ZrcmFZQXNKZ0Ro?=
 =?utf-8?B?R0VxakxIUW1jQnpNa1A1ekZKcFdxeHVZL1RCQmVWMzVYUjBzVXZMcCtuRUh1?=
 =?utf-8?B?RGdZWUxkYnhxa1hrT3pId0ppSTJHY3luQk9rWHlhYWpidThLV2p3a1FuSTdw?=
 =?utf-8?B?M1dHNDN2ZmEvd1FPdWZ5cFVKeG9RRGVyVnhLNTRVVmFsYU9wOEFoL3NUWHNW?=
 =?utf-8?B?U3lwNTM5aW9vWnJTZlNSTlZhTmkvWlVicjlMYmlyc0hITzNpUUlmUldUbjZI?=
 =?utf-8?B?QUphRkhHdUZIV2pJZ2dmMVpwVGo2M2V3SDArSFBBS3d3Z1VpVXZyV1M5M2hK?=
 =?utf-8?B?MEVWRDBMODhjSnBySFFzK3E0NGM3WTk0amFJdS9XZVpydGlPUGN4UE11SEU0?=
 =?utf-8?B?bHl0QmNNdVVETUNDb1hKZmlLRE1ZblorVUwrNzFCaFNXOXBOT3hSQjR0Rk5l?=
 =?utf-8?B?enREazlEempCaDN0a0J2aE9WY1ZPdVoyOEU1NW9ZTU9xTXJLTitZWU1YMlMx?=
 =?utf-8?B?RnlLdEVSVmF3RnhDWm5XNVFTM1Y5NVdYbk1keGJ6SlJyUGk4ZnRXbTJ2Q0Zs?=
 =?utf-8?B?L3FnQ0J4em4xeXQ5U1psY0hNZWFKZ1ZIL2dYemMwWUY4Nmh2NXR1ays1WXpk?=
 =?utf-8?B?ZUxRTWxSZ0EzeEYyNXN0ZUtpUENmZGd3Uk9vYmhkSmFJY3U1QXNUOXhneFBF?=
 =?utf-8?B?cjFrbGo3SVhGY0JVbGZRV3laYThqbnNKYzErVW1FY093dkZZOTlhOXZBNEhV?=
 =?utf-8?B?MENOeXljZGVBZkw3dDlmSkptSzlHanFUeWV4N1NucTN1cTJDYU1SMWlKcnJt?=
 =?utf-8?B?dmdnam5JeHBLYmNRUUthS3U3Wk13enUyc0x0VnZWL3ZTZHRZMnhXcHU4bGxp?=
 =?utf-8?B?SU90NitITGFVdlhaQzNkSG80aXIwK3pUUi81TmdnS0cvMHpHUkVUSG15Z2Zq?=
 =?utf-8?B?VHk2cTBJVFRPdmtnbVN3UWZHampEZE03VUtJTzllY0psc1ZwQ0tlWS9nVlY3?=
 =?utf-8?B?Um1KQkM4cnE2TVNCakdQaWVqQ29XMzh0Y3E1WnV1RDk1ZXFxaUtScmovSDF2?=
 =?utf-8?B?alRaQVBFSkFPZ1hvWGZTQXdnQitOR0VhSUhhbG96eVFTTFdZZU5hN0NmbGZs?=
 =?utf-8?B?VG1LNFFqamV0ZFhIcmdUUmEzVUtlS0RUK2ZxTnlkcTh0TTdHRmNRNUltT3g4?=
 =?utf-8?B?TmREUlBaTVpuMmRqK2w3SWZwOFFkTTdvbjhEZTJKYkpYbEV2KzBwNXdDVzNy?=
 =?utf-8?B?OVJyeDArQmZqbVlBMlZ2Ym03WncreDVPWDdTa1BkNmhWc1FDSnpQcUlUYUJ4?=
 =?utf-8?B?djhWbXJDeXl0b0swRU9mY1N2NnlyV2RZRngvMmFiVWRGSmtCQS84d0Racm5M?=
 =?utf-8?Q?QIURtGYqWl/idlGFq8r1VY8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA5901FC94B113429EDBB648FF962FA4@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ec9303-63d3-47a9-6a80-08de1d790f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 21:11:31.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luaSWSb3/HzwdsyFqiFCSMtm5+hK9OpijSskLln6xmB7K1YDrpieuuWXIOuP1SBQkCY4yyhFQTcHx/7GL3c5OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4147
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690d0f07 cx=c_pps
 a=tVU0SsWZS/EEg8/MReKahA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=f_fHxaJcfIz1Flf2j5oA:9
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: QIgeh-ctZnFl5A0cYVFWyM5wZxh74Cph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfXws6Q8ciLYbhg
 DENZ4SvCggvUTj253wc898fG6OxGWzXzCBnuiBjfydcXyF6SWh49bNKPj7SGymFdO+PWA5JbkwB
 C6IFF7OGuzL11TjAasNGVULwOqcIlTbXZlcUCjjJrNl9+xhO5T+efeKVQAc2P7rZ3JWgJ9gT2Fc
 eQNYoX+tmanBYmlqWMhSGFYUnI6xz3GcC7GIhIyD2frbJD+ssuEqPGMy1xWsRaASGT5P7M/yxNi
 42kVoeufXAxFLq1UAHfCe1GaCR2FL1fty4hhX8FaJsSl2XcYSXd+A0eDl4Ko5K0BueJW0Rxng47
 CBtBnR9myb5n29SjYQQEgUSpNFqURX9EZrWi9LDRiLD3q2Ufa6YvG2sIP8rdgn12/aL46GESBnS
 xdAYgJNWfRdueOuXZw/Tp4qXGqUTYQ==
X-Proofpoint-GUID: QIgeh-ctZnFl5A0cYVFWyM5wZxh74Cph
Subject: RE: [RFC] Why generic/073 is generic but not btrfs specific?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

T24gRnJpLCAyMDI1LTExLTA3IGF0IDA3OjI4ICsxMDMwLCBRdSBXZW5ydW8gd3JvdGU6DQo+IA0K
PiDlnKggMjAyNS8xMS83IDA3OjEwLCBWaWFjaGVzbGF2IER1YmV5a28g5YaZ6YGTOg0KPiA+IEhl
bGxvLA0KPiA+IA0KPiA+IFJ1bm5pbmcgZ2VuZXJpYy8wNzMgZm9yIHRoZSBjYXNlIG9mIEhGUysg
ZmluaXNoZXMgd2l0aCB2b2x1bWUgY29ycnVwdGlvbjoNCj4gPiANCj4gPiBzdWRvIC4vY2hlY2sg
Z2VuZXJpYy8wNzMNCj4gPiBGU1RZUCAtLSBoZnNwbHVzDQo+ID4gUExBVEZPUk0gLS0gTGludXgv
eDg2XzY0IGhmc3BsdXMtdGVzdGluZy0wMDAxIDYuMTcuMC1yYzErICM0IFNNUCBQUkVFTVBUX0RZ
TkFNSUMNCj4gPiBXZWQgT2N0IDEgMTU6MDI6NDQgUERUIDIwMjUNCj4gPiBNS0ZTX09QVElPTlMg
LS0gL2Rldi9sb29wNTENCj4gPiBNT1VOVF9PUFRJT05TIC0tIC9kZXYvbG9vcDUxIC9tbnQvc2Ny
YXRjaA0KPiA+IA0KPiA+IGdlbmVyaWMvMDczIF9jaGVja19nZW5lcmljX2ZpbGVzeXN0ZW06IGZp
bGVzeXN0ZW0gb24gL2Rldi9sb29wNTEgaXMgaW5jb25zaXN0ZW50DQo+ID4gKHNlZSBYRlNURVNU
Uy0yL3hmc3Rlc3RzLWRldi9yZXN1bHRzLy9nZW5lcmljLzA3My5mdWxsIGZvciBkZXRhaWxzKQ0K
PiA+IA0KPiA+IFJhbjogZ2VuZXJpYy8wNzMNCj4gPiBGYWlsdXJlczogZ2VuZXJpYy8wNzMNCj4g
PiBGYWlsZWQgMSBvZiAxIHRlc3RzDQo+ID4gDQo+ID4gc3VkbyBmc2NrLmhmc3BsdXMgLWQgL2Rl
di9sb29wNTENCj4gPiAqKiAvZGV2L2xvb3A1MQ0KPiA+IFVzaW5nIGNhY2hlQmxvY2tTaXplPTMy
SyBjYWNoZVRvdGFsQmxvY2s9MTAyNCBjYWNoZVNpemU9MzI3NjhLLg0KPiA+IEV4ZWN1dGluZyBm
c2NrX2hmcyAodmVyc2lvbiA1NDAuMS1MaW51eCkuDQo+ID4gKiogQ2hlY2tpbmcgbm9uLWpvdXJu
YWxlZCBIRlMgUGx1cyBWb2x1bWUuDQo+ID4gVGhlIHZvbHVtZSBuYW1lIGlzIHVudGl0bGVkDQo+
ID4gKiogQ2hlY2tpbmcgZXh0ZW50cyBvdmVyZmxvdyBmaWxlLg0KPiA+ICoqIENoZWNraW5nIGNh
dGFsb2cgZmlsZS4NCj4gPiAqKiBDaGVja2luZyBtdWx0aS1saW5rZWQgZmlsZXMuDQo+ID4gKiog
Q2hlY2tpbmcgY2F0YWxvZyBoaWVyYXJjaHkuDQo+ID4gSW52YWxpZCBkaXJlY3RvcnkgaXRlbSBj
b3VudA0KPiA+IChJdCBzaG91bGQgYmUgMSBpbnN0ZWFkIG9mIDApDQo+ID4gKiogQ2hlY2tpbmcg
ZXh0ZW5kZWQgYXR0cmlidXRlcyBmaWxlLg0KPiA+ICoqIENoZWNraW5nIHZvbHVtZSBiaXRtYXAu
DQo+ID4gKiogQ2hlY2tpbmcgdm9sdW1lIGluZm9ybWF0aW9uLg0KPiA+IFZlcmlmeSBTdGF0dXM6
IFZJU3RhdCA9IDB4MDAwMCwgQUJUU3RhdCA9IDB4MDAwMCBFQlRTdGF0ID0gMHgwMDAwDQo+ID4g
Q0JUU3RhdCA9IDB4MDAwMCBDYXRTdGF0ID0gMHgwMDAwNDAwMA0KPiA+ICoqIFJlcGFpcmluZyB2
b2x1bWUuDQo+ID4gKiogUmVjaGVja2luZyB2b2x1bWUuDQo+ID4gKiogQ2hlY2tpbmcgbm9uLWpv
dXJuYWxlZCBIRlMgUGx1cyBWb2x1bWUuDQo+ID4gVGhlIHZvbHVtZSBuYW1lIGlzIHVudGl0bGVk
DQo+ID4gKiogQ2hlY2tpbmcgZXh0ZW50cyBvdmVyZmxvdyBmaWxlLg0KPiA+ICoqIENoZWNraW5n
IGNhdGFsb2cgZmlsZS4NCj4gPiAqKiBDaGVja2luZyBtdWx0aS1saW5rZWQgZmlsZXMuDQo+ID4g
KiogQ2hlY2tpbmcgY2F0YWxvZyBoaWVyYXJjaHkuDQo+ID4gKiogQ2hlY2tpbmcgZXh0ZW5kZWQg
YXR0cmlidXRlcyBmaWxlLg0KPiA+ICoqIENoZWNraW5nIHZvbHVtZSBiaXRtYXAuDQo+ID4gKiog
Q2hlY2tpbmcgdm9sdW1lIGluZm9ybWF0aW9uLg0KPiA+ICoqIFRoZSB2b2x1bWUgdW50aXRsZWQg
d2FzIHJlcGFpcmVkIHN1Y2Nlc3NmdWxseS4NCj4gPiANCj4gPiBJbml0aWFsbHksIEkgY29uc2lk
ZXJlZCB0aGF0IHNvbWV0aGluZyBpcyB3cm9uZyB3aXRoIEhGUysgZHJpdmVyIGxvZ2ljLiBCdXQN
Cj4gPiBhZnRlciB0ZXN0aW5nIGFuZCBkZWJ1Z2dpbmcgdGhlIGlzc3VlLCBJIGJlbGlldmUgdGhh
dCBIRlMrIGxvZ2ljIGlzIGNvcnJlY3QuDQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSwg
dGhlIGdlbmVyaWMvMDczIGlzIGNoZWNraW5nIHNwZWNpZmljIGJ0cmZzIHJlbGF0ZWQgY2FzZToN
Cj4gPiANCj4gPiAjIFRlc3QgZmlsZSBBIGZzeW5jIGFmdGVyIG1vdmluZyBvbmUgb3RoZXIgdW5y
ZWxhdGVkIGZpbGUgQiBiZXR3ZWVuIGRpcmVjdG9yaWVzDQo+ID4gIyBhbmQgZnN5bmNpbmcgQidz
IG9sZCBwYXJlbnQgZGlyZWN0b3J5IGJlZm9yZSBmc3luY2luZyB0aGUgZmlsZSBBLiBDaGVjayB0
aGF0DQo+ID4gIyBhZnRlciBhIGNyYXNoIGFsbCB0aGUgZmlsZSBBIGRhdGEgd2UgZnN5bmNlZCBp
cyBhdmFpbGFibGUuDQo+ID4gIw0KPiA+ICMgVGhpcyB0ZXN0IGlzIG1vdGl2YXRlZCBieSBhbiBp
c3N1ZSBkaXNjb3ZlcmVkIGluIGJ0cmZzIHdoaWNoIGNhdXNlZCB0aGUgZmlsZQ0KPiA+ICMgZGF0
YSB0byBiZSBsb3N0IChkZXNwaXRlIGZzeW5jIHJldHVybmluZyBzdWNjZXNzIHRvIHVzZXIgc3Bh
Y2UpLiBUaGF0IGJ0cmZzDQo+ID4gIyBidWcgd2FzIGZpeGVkIGJ5IHRoZSBmb2xsb3dpbmcgbGlu
dXgga2VybmVsIHBhdGNoOg0KPiA+ICMNCj4gPiAjICAgQnRyZnM6IGZpeCBkYXRhIGxvc3MgaW4g
dGhlIGZhc3QgZnN5bmMgcGF0aA0KPiA+IA0KPiA+IFRoZSB0ZXN0IGlzIGRvaW5nIHRoZXNlIHN0
ZXBzIG9uIGZpbmFsIHBoYXNlOg0KPiA+IA0KPiA+IG12ICRTQ1JBVENIX01OVC90ZXN0ZGlyXzEv
YmFyICRTQ1JBVENIX01OVC90ZXN0ZGlyXzIvYmFyDQo+ID4gJFhGU19JT19QUk9HIC1jICJmc3lu
YyIgJFNDUkFUQ0hfTU5UL3Rlc3RkaXJfMQ0KPiA+ICRYRlNfSU9fUFJPRyAtYyAiZnN5bmMiICRT
Q1JBVENIX01OVC9mb28NCj4gPiANCj4gPiBTbywgd2UgbW92ZSBmaWxlIGJhciBmcm9tIHRlc3Rk
aXJfMSBpbnRvIHRlc3RkaXJfMiBmb2xkZXIuIEl0IG1lYW5zIHRoYXQgSEZTKw0KPiA+IGxvZ2lj
IGRlY3JlbWVudHMgdGhlIG51bWJlciBvZiBlbnRyaWVzIGluIHRlc3RkaXJfMSBhbmQgaW5jcmVt
ZW50cyBudW1iZXIgb2YNCj4gPiBlbnRyaWVzIGluIHRlc3RkaXJfMi4gRmluYWxseSwgd2UgZG8g
ZnN5bmMgb25seSBmb3IgdGVzdGRpcl8xIGFuZCBmb28gYnV0IG5vdA0KPiA+IGZvciB0ZXN0ZGly
XzIuDQo+IA0KPiBJZiB0aGUgZnMgaXMgdXNpbmcgam91cm5hbCwgc2hvdWxkbid0IHRoZSBpbmNy
ZW1lbnRzIG9uIHRoZSB0ZXN0ZGlyXzIgDQo+IGFscmVhZHkgYmUgam91cm5hbGVkPyBUaHVzIGFm
dGVyIGEgcG93ZXIgbG9zcywgdGhlIGluY3JlbWVudHMgb24gDQo+IHRlc3RkaXJfMi9iYXIgc2hv
dWxkIGJlIHJlcGxheWVkIHRodXMgdGhlIGVuZCB1c2VyIHNob3VsZCBzdGlsbCBzZWUgdGhhdCAN
Cj4gaW5vZGUuDQo+IA0KDQpUZWNobmljYWxseSBzcGVha2luZywgSEZTKyBpcyBqb3VybmFsaW5n
IGZpbGUgc3lzdGVtIGluIEFwcGxlIGltcGxlbWVudGF0aW9uLg0KQnV0IHdlIGRvbid0IGhhdmUg
dGhpcyBmdW5jdGlvbmFsaXR5IGltcGxlbWVudGVkIGFuZCBmdWxseSBzdXBwb3J0ZWQgb24gTGlu
dXgNCmtlcm5lbCBzaWRlLiBQb3RlbnRpYWxseSwgaXQgY2FuIGJlIGRvbmUgYnV0IGN1cnJlbnRs
eSB3ZSBoYXZlbid0IHN1Y2gNCmZ1bmN0aW9uYWxpdHkgeWV0LiBTbywgSEZTL0hGUysgZG9lc24n
dCB1c2Ugam91cm5hbGluZyBvbiBMaW51eCBrZXJuZWwgc2lkZSAgYW5kDQpubyBqb3VybmFsIHJl
cGxheSBjb3VsZCBoYXBwZW4uIDopDQoNCj4gVG8gbWUgdGhpcyBsb29rcyBsaWtlIGEgYnVnIGlu
IEhGUyBsb2dpYyB3aGVyZSBzb21ldGhpbmcgaXMgbm90IHByb3Blcmx5IA0KPiBqb3VybmFsZWQg
KHRoZSBpbmNyZW1lbnQgb24gdGhlIHRlc3RkaXJfMi9iYXIpLg0KPiANCj4gDQoNClRoaXMgc3Rh
dGVtZW50IGNvdWxkIGJlIGNvcnJlY3QgaWYgd2Ugd2lsbCBzdXBwb3J0IGpvdXJuYWxpbmcgZm9y
IEhGUysuIEJ1dCBIRlMNCm5ldmVyIHN1cHBvcnRlZCB0aGUgam91cm5hbGluZyB0ZWNobm9sb2d5
Lg0KDQo+IEZpbmFsbHksIGlmIHlvdSdyZSBhc2tpbmcgYW4gZW5kIHVzZXIgdGhhdCBpZiBpdCBp
cyBhY2NlcHRhYmxlIHRoYXQgDQo+IGFmdGVyIG1vdmluZyBhbiBpbm9kZSBhbmQgZnN5bmMgdGhl
IG9sZCBkaXJlY3RvcnksIHRoZSBpbm9kZSBpcyBubyANCj4gbG9uZ2VyIHJlYWNoYWJsZSwgSSdt
IHByZXR0eSBzdXJlIG5vIGVuZCB1c2VyIHdpbGwgdGhpbmsgaXQncyBhY2NlcHRhYmxlLg0KPiAN
Cg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhlIGZzY2sgb25seSBjb3JyZWN0cyB0aGUgbnVtYmVy
IG9mIGVudHJpZXMgZm9yIHRlc3RkaXJfMg0KZm9sZGVyLiBUaGUgcmVzdCBpcyBwcmV0dHkgT0su
DQoNCj4gPiBBcyBhIHJlc3VsdCwgdGhpcyBpcyB0aGUgcmVhc29uIHdoeSBmc2NrLmhmc3BsdXMg
ZGV0ZWN0cyB0aGUNCj4gPiB2b2x1bWUgY29ycnVwdGlvbiBhZnRlcndhcmRzLiBBcyBmYXIgYXMg
SSBjYW4gc2VlLCB0aGUgSEZTKyBkcml2ZXIgYmVoYXZpb3IgaXMNCj4gPiBjb21wbGV0ZWx5IGNv
cnJlY3QgYW5kIG5vdGhpbmcgbmVlZHMgdG8gYmUgZG9uZSBmb3IgZml4aW5nIGluIEhGUysgbG9n
aWMgaGVyZS4NCj4gDQo+IFRoZW4gSSBndWVzcyB5b3UgbWF5IGFsc28gd2FudCB0byBhc2sgd2h5
IEVYVDQvWEZTL0J0cmZzL0YyZnMgYWxsIHBhc3MgDQo+IHRoZSB0ZXN0IGNhc2UuDQo+IA0KDQpT
bywgZXh0NCBhbmQgeGZzIHN1cHBvcnQgam91cm5hbGluZy4gTWF5YmUsIGl0J3MgaW50ZXJlc3Rp
bmcgdG8gY2hlY2sgd2hhdCBpcw0KZ29pbmcgb24gd2l0aCBGMkZTLCBGQVQsIGFuZCBvdGhlciBm
aWxlIHN5c3RlbSB0aGF0IGhhc24ndCBqb3VybmFsaW5nIHN1cHBvcnQuDQoNClRoYW5rcywNClNs
YXZhLg0K

