Return-Path: <linux-fsdevel+bounces-37278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5E69F0996
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 11:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C60281792
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722D1B87E2;
	Fri, 13 Dec 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="y25aLz0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C231BBBDC
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086109; cv=fail; b=oeKKhqVoORu+4AlhAVLJuPDRUniqoD7xdcDBLX3GVs3DYg50qOxMz3wO6dg8O2sxh6GzridUIUVursX8THkUTk9hswj9ym7q9LECwKQbgXT40rkaQzH+zmNosHbAteLE/ZLCJIBGWewhDF7DYGOL1uI6m65v5/xiamPEIGbFZJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086109; c=relaxed/simple;
	bh=M5r0itoyCEwCaxAIxVHmI43AS7nWnlLBmqKODkFKGFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gtv66R+4xoDXK8fvqTRDtUjoCfjb+vKUzckXvEJbIH5YFgt0oEdxENS5K2OOvqC6hjUfrG/CEwD2zKz9a9t7fV1UDu79hpv6dcRes+PrYbr5sea2Ji7P/TuT/HELN5OpdiKlK+R4aUyySJf+l2oR4068S1uL7ssAe8xSLcEwE+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=y25aLz0c; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49]) by mx-outbound11-50.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 13 Dec 2024 10:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofBHP8Qvr1CHFnIieh8D62Mg0OOVnSt+2TVChCkT/3Zcqh3Q4J1ZE7qUd2ITiOxe1O9pUKej1nxGPk2dkg7l3VQuACkYBjD5K/7/4myNIYvoHHMJq1NtWsvGy7ZtLDGf3LXX9smVpfpbD/3yJV85BFq9S6zmn4foK9qF6zpXtm/DojSoVa1bFYss3Lpi4LhprcjSRu7JaQfXSFMjgMndAYNuu4iB40Nw8pXDY4tx13OXX+ilzKqaRrjofYR/ZRSeqUUBb/MZE/YEZM+lFjcxbB8uveovVut54qwIW4MVCgr4NWMhLFJR0p1GZvrvEYvWr6aDbDlE/U+YtdWAEccXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yyntgG1zmsTGdJ/GuCbvtdJpiG1cCyEhY/RPv90jtg=;
 b=vRCm7iFm2SfounuKbNKWwLnKVScQWz0wfh3YQPrjauGZYE7hdDAhTTsTE7syCk+Yfi3N2LWbqspV2rWTsQFL+CG/SFwHbHUrEpxDvIzRxP3y/+8isj1lFPgk2lBzjAGf57h+M+CsyHzpisGjKj7s43h9e6dwiTZZRd2p299zDHAi0PEEUYbtQkDENRuRuLfMIGmOSBpPCERMU3HK+o+dNLpxq/EnYHzx3N1Xnx/WXAbkdxZW9o6Y+pS28DoTrXLqKWeQx0GXpQZLZs4HK5181IPj2SGtM7vautQ9ezSwHw527o2q3Fzvddl6uflY87zuMccJZ/W1TpzIix4WVCP+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yyntgG1zmsTGdJ/GuCbvtdJpiG1cCyEhY/RPv90jtg=;
 b=y25aLz0cyzP8CE/BXmyj1oR0eZ5wttRprjYownF3VMhJ3busFXnilMFPDrgH6JVIlBwQitXB50XfmUAcJMjTJH/NRJTOE0RMhXXyWh39qorKrf+67232ORwmRJC1igdM2zh+m8QOmtf4+ZI6p6zn6xc3xhadEJebdzegSX/VNNg=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SA1PR19MB6765.namprd19.prod.outlook.com (2603:10b6:806:25d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 10:34:40 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:34:40 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Shachar Sharon <synarete@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
Thread-Topic: [PATCH 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
Thread-Index: AQHbTN/j4OCqFzzHpEybrFwBRYrQlrLj5deAgAAVooA=
Date: Fri, 13 Dec 2024 10:34:40 +0000
Message-ID: <63512803-2b8c-4a5f-af7e-4cdc09d1f339@ddn.com>
References: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com>
 <20241212-fuse_name_max-limit-6-13-v1-2-92be52f01eca@ddn.com>
 <CAL_uBtdkKPyugSmE_axmNa-wv472vBUO5N12J9veKkxGuy2MYg@mail.gmail.com>
In-Reply-To:
 <CAL_uBtdkKPyugSmE_axmNa-wv472vBUO5N12J9veKkxGuy2MYg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SA1PR19MB6765:EE_
x-ms-office365-filtering-correlation-id: aaf13deb-2dcb-4414-b996-08dd1b61bfce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjltbDNYWHM4MlIxZzMrUzJaQmFmbGs5NjhYUzZwdmt6U1I5VTcrTEgwY2x4?=
 =?utf-8?B?dWdqREFIM3hjQ1lBek1xL3pNVWhpL3paZi8yTjN5U09LRWlQMnJZUWtnV1Vu?=
 =?utf-8?B?ZWlmZDA0MFd5SHU1T3NDWnVFVS8vY2d5dFBaMzVhN3NuR2dOcjZCVyt0YmVp?=
 =?utf-8?B?VzhlbjYzQm1WQjVTRHBUMlNydWN5cVd3MGplY3ZuY2haRDJ6UnNrSFJWenRQ?=
 =?utf-8?B?VDhaTFU5R1pLZHVHdlJlc01WM3NhOW9sZG1xTHBuTmUrWWJjeFVrMHNpdlNk?=
 =?utf-8?B?UTZLZEx4Sm1TWFhnN3Z1V2VyL3d2TTFiMmdzWm9hU1NLOUtGdEdZanhuMzRy?=
 =?utf-8?B?ZFUxa085YXU3ampuWHJKNXAvaDdkN1d0aEVLbm9vTVZxeks1RGRqdHdOeU5T?=
 =?utf-8?B?MmhoWm1ncHFGY3llcXZWeVFxTXhhL052Q2N5d2tjeEhLd2dDZ3FwbFIwVzlF?=
 =?utf-8?B?OThVdzM0YndmeG5INzd3ZDh6aUFPNkNUb2Vjak1yUjZ3OG8wY0xsK3VLeTNP?=
 =?utf-8?B?NjZqaStLWVI5VnBKSk9KSzlkZlhtSExzMi9vNStjU2FKRVljODlGQkF2RTNt?=
 =?utf-8?B?R3NOSnp6VkVkMjVsZ3dTNUZVMS9wT0hiV0REbDZoTFM0RTdHUXVaMVdYVnl0?=
 =?utf-8?B?T1AyMm5jZ3FwVCtTblFOSFpTazFmVVhiaC91Z3RMcUtuNGJpcXovRmIvM0U4?=
 =?utf-8?B?WXRWVThRd05YRjYzVjI3WFArMHBiYzhGTVhDME9DWThGTmZZV3dxaGM5U2VU?=
 =?utf-8?B?ZGdPODhMeTJRUERFY0JjVjZEVUI3dEwzdjFleVBZbDhsK1dOdGZkZ0ZMNEVy?=
 =?utf-8?B?TVZieUhlMi9SMEkxRkVGRUwvTTR3STlhS3pxQkZ6N0VObW1Sa1pBUEJ4MHkx?=
 =?utf-8?B?VzdtSGQ3NFRvYVAxek1aSzh3KzhYZGVCMHc0U2FQRURXRERzSmllbUk1NjZo?=
 =?utf-8?B?dnlVRVNWckplSHRqNklRMWw2VDhjRTZ4UUN0dEQ5dFc3djQxT0F4T1ZGZ1VK?=
 =?utf-8?B?bFc5bmRHdHJQbHF2ZGlUUjJrOHE5M0g1RVlXNzd3YWdMTE9JcDJzeGlhVTNJ?=
 =?utf-8?B?L1B2TjUzem4vRUpKdEpkY2RjWEpzY0Q2eHZ5djhUWUE4MUh3NXRiZzFMMEtn?=
 =?utf-8?B?QlFueHQ2bzIwaEdmTEhaTTVvT1FyYnpLSk9sNUtwclFHR1JQdGRSVC9STFNU?=
 =?utf-8?B?K01RTllvSU0zVVVyaHBGeEhzUEc5VmI0d2IvemFKZVAxTVBXWVhPTy9uNUtV?=
 =?utf-8?B?V0xKWDJvMFhUVnl5eE4zY3gxdzBvVFZaSEtDSUk3ZXJhbTNZdW8wNUNzZ01J?=
 =?utf-8?B?T005WlBrYWtKT3VXT2t6RGhYUUMwbW1SUFRzNy9JK0FGVXNhK29zZ0RxMlc1?=
 =?utf-8?B?OVBBL0doMCtJVDkzMVFhd2U0OVF5UFNlN0dZaDY2amdSUzVwSCtsK1Qva09L?=
 =?utf-8?B?azZzbTM1N0lqVWdzSDZxYzJGY2hQd0pLNlNIRmYwN1FuQk5ueVVIcjU0NTZB?=
 =?utf-8?B?TkE2WHEyWkJkMFo2QklxZjlEWlY2SDZHby9FLzB1WWdodCswVnJzRGF1ZUNt?=
 =?utf-8?B?V2Y2ZzhkSC9QVGJzU1FUUzFndzE1N0VUNkVUaU9ta2I4aU1CdVNMZjk4NnM3?=
 =?utf-8?B?N1EzbE1xYjlHYzA1SlVISjV4US82KzVOdExYbFQrbkJlMzlWUFY1YzFLeDYr?=
 =?utf-8?B?VU1UUWhZNGl0NEk0NkdnSllvZkhPdUYvUWVHbXlCYXZ5N1BhbXZhaGJtTEc4?=
 =?utf-8?B?UFZGbGhzamwrUngrY2VkVHVMYXdITy92WSsvdCtRZGNmdGU4WVJMakcwQm1l?=
 =?utf-8?Q?8CfvYNyzcBCyut5vQ15DdZSdBTlb8L0ndXG9o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWhVUHJSOEF4RU5Ta2RGVWYxeExLRFYzMGwrV3VKNXJlR0F1dUxMdXFQWkxz?=
 =?utf-8?B?VU9NbERZL1JzU2FhY3FiK2pzait1RE5VWFM1NEpwcmhhMVZRTmxwMjBQVThW?=
 =?utf-8?B?dy9YbE1RWnRoTU9JL0pFNGdYMk5oYVdjdlhNK3hnRTVRYnNaS1hQY21Fc2Fa?=
 =?utf-8?B?bXIyc2s0QXFBRmEveVlZZzF5dHJzUnBEaXJSQUszTGtyM0M4OEg2d0hGR1Bs?=
 =?utf-8?B?ckhiOTZUZ2sxV3NQUmR3bEV5NURLWFdCWVRvSW9IdHRXWDFoYlFQZ0tkY0Va?=
 =?utf-8?B?WG8zNHcwVzY1L0hRMDh3bFRURndLYnQ0ellTT2tRTGwrd0JCY1hzYllQQS9i?=
 =?utf-8?B?SW5JWHlCZmRUUTUrNzRZU2pXNG9ETVNIYUhwK09FajVIL0dYa0xzeFVNaTdn?=
 =?utf-8?B?VTQ2WHlGdk1lNHcrV2RCNDNkcHhSSlhkUDVXRStRcllYOXFLMzNXRjVCeUk1?=
 =?utf-8?B?Wk1SVEtEMXZ5TitTN2JYTUpEUEsxNTJlb1c4REF0YVpIWVllcXlhTk1kL0RO?=
 =?utf-8?B?T1UyK3pXcHdFT0R0NEo4R0wvVE1XejRsZFl1TTE3dDNnUHhIUGlXWlp2V2FI?=
 =?utf-8?B?ODFnUThZNG1TRGJxMEVEVWxMd1M4cjZsOVhJNThHTjlVR1Nxd1pKamU2WGM1?=
 =?utf-8?B?TGRvWStQZGNtclhMVlhRRmVyS05EZ1JLN01XbldOOHJHN0NUVHhNdHkyM2p1?=
 =?utf-8?B?eVVQWEphaG9WRlJhWnpycmpvOFZ4clMwaVhta2U5bDNIdlBlcDcyYmd1U2xk?=
 =?utf-8?B?VUxCVE9wSUlZWDRCYngwMVNnL0xmb0lpRzYybjI1K3BFSVZUTXNvbUtiNmly?=
 =?utf-8?B?TU1qYzZlVTZSTEI2UW93WWZqVGxlWHpYTEVKWWRMRmY4Z1kycnNyaDdNQks0?=
 =?utf-8?B?aU1tZ3pjVGI0NHZVbVZIMXRNYkYrUXRRbWxoODlpTDdjUTV3RWdZcFFUZ1JY?=
 =?utf-8?B?cEdUTWh4TEc3YkVyb0VCTkxvRFRTUHdtSmJwQnRjWlVKdXptSXlDN1JPbzFP?=
 =?utf-8?B?WHF6dVJEYUladGpTOHRhenlBdEVPREZlVnRPSWxnR1ptU3Y4eERybkJocFhP?=
 =?utf-8?B?VzVGQUVIdDAwNHU3N1lVa0xoSkJod0o0eUU5Q2JuTkxrU3pSNVNiaUovbHZG?=
 =?utf-8?B?YU9OcE55a2wwM1NsQyszc1pUSWRtNk9kT0tubU5NOVVWM0NvTFNmMjZUQlV5?=
 =?utf-8?B?RjdCTU5OcFpsTGNHUXJ4WWsrZ1ZIYWcxRHNLU2gyUjRBWHR4MjBuMWFmTlJp?=
 =?utf-8?B?eG1xTVpzVHg2Y3pDakJUcHRCdzhBNUxTTEdQTU13REt0YVdqNEo2c1JBOU5I?=
 =?utf-8?B?NUpiOGxVN056TTdhczAyWUJ1aURLb1E5MjBERSs5TFZTNWlFeStGWVgrMlE5?=
 =?utf-8?B?ZVBwUmhQNFRUSzBaZXpMb1hyUTNPV3dGVkM5Zm1Xb2t1dEY0bGhCYmMrSE9N?=
 =?utf-8?B?L1hxajNtK002aVNZdXlHWDRGbDRMMUJLZ3VnQklPZmt2dldqTlNJbStjZVpi?=
 =?utf-8?B?b0o4cUwwa0plcEM3ZG8yd2RPZnRzQVZqU1NmWnRXU3A1cU4yZWtGbjVUTFdD?=
 =?utf-8?B?cERPVXZqTTRsL1BMcjVSLzl4V25oZGVVMlU4U25sQjM2TURYRk1iL3FOc0JV?=
 =?utf-8?B?ZjRWOWZMMjVFS0w3ZEJ0SzdTVXlnVEtlQUhDN1RSWUdXQUtpbkF5MjdlK0hx?=
 =?utf-8?B?dnh4TENhSjVMcU50dEFCRjVPMjlHdEg1SE8rVGxiS0t2NFdBWk0yc3UrSXgw?=
 =?utf-8?B?d0diMVdpRitoZzl5VFhZQUI1bzRhVkI5VVNINGgvd1AxUXFGTkVEN0ZRWktE?=
 =?utf-8?B?MHF6UVlOZXRHNlVRYTE4OWhQUTVMWjVxdy9iWjZDeXRrV2FDU3BacEtacDVM?=
 =?utf-8?B?RjdRWlFDT3NvaVFqeldaY1RVNjBVTHNXa3VMYjUxR3lqeWl4N2g5MFNDMHNV?=
 =?utf-8?B?OUFxQ29JTnZ0Mlg3enFiVjNiSm0zOUVQLzZhTGdJQmx0elFtUVFZeGRWbXdD?=
 =?utf-8?B?b3N5cTQ0ckxlaVRyUXdpVEgrQ1ROTGM0d09kNjFJSzZOM2Z6cCttMnRjOGpX?=
 =?utf-8?B?TUlhL2IzSVdLMG9RY2V5eDdXMmtBT0hUQ1UzeFlMNUZ1Y2R1OThwalZzMkhR?=
 =?utf-8?B?MkJxTUdzMy9Dam8rUHdBYzNUTGZKSFR6dzMybDIxdEJvQXZmeVlmQVNsZnNW?=
 =?utf-8?Q?xkfIQG7Kqtqtz5bTpMPv5O0=3D?=
Content-Type: multipart/mixed;
	boundary="_002_635128032b8c4a5faf7e4cdc09d1f339ddncom_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dWU2rIOqulaxvpxWNZ9lJ5Q5A3SYTI15QrP9cXeGn1OuXdTZMGPn8nRtKMEOA9CZhJ02hPmeehX8Sm5gPfkQRwx2cv1HtbxkNcXyyOvKjB/e9M2/c7i7r8cll3J2RqEh7UggIUOu1m+L9GATE3TLh++H0L9SeGHuyqcWYbzGd5veOOVU3+KUIBZOQ3zBE2hu+7BAiHKJM1QPfYJv/R82MTOL5TbckfwELCzcTs7B1oj/7S7CShMSXZh9h/CMn9HDIlCUNybcX7vlYfR2KCdl2e8VIwhDuL1UMdTYKGtyL36dFYmfMeiPX47fx2aC/GikDDBHT8OMQkYtH11m9AJByrIT0DEIqInypvGwbne0CKPyho1RnMA56Io/anWAhYVQrDPeuO6uNW9aOUoCTswZy8KTIaXg5XolV2Ytv3xKzNzQeKNgaT9Kf5R6Okt+oeeptljiPjs39pOh9ViNISYd6TWBgilUaF7df6k4CCHVomqE5QLer4LsZ46XH8uhpyfvwYw0j/0Smyeo4XTjBWmCvTEyOE/z2bMjLBirBmaxjuWyr8XB9pytWgy2m3bN2it1tvmGx60UoBYglZrOWyhQEWYNydelFlkzXQGyEirwhFZmEjNEOW1OPVhnC+qJ3LnIb133ek79AjpDuxv8dI3jYw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf13deb-2dcb-4414-b996-08dd1b61bfce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 10:34:40.0132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q77jS5B0Ms1R5KH7D+BaZNBo8NorfhU8oYvPKWx0TnBHhUY91/ssqCnDJ//6UaJSEisd8YWydFG9po1s/pu28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6765
X-BESS-ID: 1734086084-102866-13351-26331-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.58.49
X-BESS-Parts: H4sIAAAAAAACAzXLMQ6EMAxE0bu4prCd2CFcZbWF7QTRUUCBtOLumwKa0ddI7/
	ODfp2wwDl2gv2AhRKWUds4naVmNVqZopkHzrWgOpL18GQC9/T6Y3t45vzo2t0Kh/DcaU
	UPaUxJijclzpoU7u8fWzLoyH8AAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261082 [from 
	cloudscan10-216.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

--_002_635128032b8c4a5faf7e4cdc09d1f339ddncom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7C909720EE78845A5E9A50B02531053@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gMTIvMTMvMjQgMTA6MTcsIFNoYWNoYXIgU2hhcm9uIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIHN5bmFyZXRlQGdtYWlsLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMg
aW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlv
biBdDQo+IA0KPiBUaGUgPGxpbnV4L2xpbWl0cy5oPiBkZWZpbmVzIE5BTUVfTUFYIGFzIDI1NSAo
X25vdF8gaW5jbHVkaW5nIG51bCkgYW5kDQo+IFBBVEhfTUFYIGFzIDQwOTYgKGluY2x1ZGluZyBu
dWwpLiBJdCB3b3VsZCBiZSBuaWNlIHRvIGtlZXAgdGhpcw0KPiBjb252ZW50aW9uIGFsc28gb24g
dGhlIEZVU0Ugc2lkZTsgdGhhdCBpcywgZGVmaW5lIEZVU0VfTkFNRV9NQVggYXMNCj4gMTAyMywg
b3IgaW4geW91ciBjYXNlICgzICogMTAyNCAtIDEpLiBJIHRoaW5rIHRoaXMgaXMgdGhlIGFsc28N
Cj4gaW50ZW50aW9uIG9mIHRoZSBjb2RlIGluIGZ1c2Vfbm90aWZ5X2ludmFsX2VudHJ5Og0KPiAN
Cj4gICBlcnIgPSAtRU5BTUVUT09MT05HDQo+ICAgaWYgKG91dGFyZy5uYW1lbGVuID4gRlVTRV9O
QU1FX01BWCkNCj4gICAgICAgICAgIGdvdG8gZXJyOw0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcs
IEkgY2FuIGNoYW5nZSBpdCB0byAoMyAqIDEwMjQgLSAxKSBvciANCihQQVRIX01BWCAtIDEpLg0K
DQo+IA0KPiBPdGhlcndpc2UsIHdlIHNob3VsZCBmaXggdGhpcyBjaGVjayBhcyB3ZWxsIChvdXRh
cmcubmFtZWxlbiA+PQ0KPiBGVVNFX05BTUVfTUFYKS4gVGhhdCBzYWlkLCBrZWVwIGluIG1pbmQg
dGhhdCB1c2luZyBkaXItZW50cnkgbmFtZXMNCj4gbGFyZ2VyIHRoZW4gTkFNRV9NQVggd291bGQg
YWxzbyBjYXVzZSBFTkFNRVRPT0xPTkcgYnkgZ2xpYmPigJlzDQo+IHJlYWRkaXJbMV0NCj4gDQo+
IC0gU2hhY2hhci4NCj4gDQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vYm1pbm9yL2dsaWJjL2Js
b2IvbWFzdGVyL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3JlYWRkaXJfci5jI0w1Mi1MNTkNCg0K
WWVzLCBJIGhhZCBzZWVuIHRoYXQgZ2xpYmMgdXNlcyBOQU1FX01BWCwgYnV0IEkgaGFkIGFsc28g
dGVzdGVkIHRoZQ0KcGF0Y2ggdXNpbmcgdGhlIG5ldyBtZW1mcyBbMV0gYW5kIHRoZSBhdHRhY2hl
ZCBzY3JpcHQuIFlvdSBjYW4gdHJ5DQppdCBvdXQgeW91cnNlbGYgLSBsaXN0aW5nIGxvbmcgZmls
ZSBuYW1lcyBhY3R1YWxseSB3b3JrcyAob24gYQ0KRGViaWFuIDEyIHN5c3RlbSkuDQoNCg0KDQpU
aGFua3MsDQpCZXJuZA0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2xpYmZ1c2UvbGliZnVzZS9i
bG9iL21hc3Rlci9leGFtcGxlL21lbWZzX2xsLmNj

--_002_635128032b8c4a5faf7e4cdc09d1f339ddncom_
Content-Type: application/x-shellscript; name="long-file-name.sh"
Content-Description: long-file-name.sh
Content-Disposition: attachment; filename="long-file-name.sh"; size=424;
	creation-date="Fri, 13 Dec 2024 10:34:39 GMT";
	modification-date="Fri, 13 Dec 2024 10:34:39 GMT"
Content-ID: <32FAAF6E27B67C4D9E28260EC871438A@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNldCAtZQoKZGlyPSQxCnByZWZpeD0kMgpsZW49JDMKCmlmIFsgLXogIiR7
ZGlyfSIgLW8gLXogIiR7bGVufSIgLW8gLXogIiRwcmVmaXgiIF07IHRoZW4KICAgIGVjaG8gIlVz
YWdlOiAkMCA8ZGlyLW5hbWU+IDxmaWxlLXByZWZpeD4gPGxlbmd0aD4iCiAgICBleGl0IDEKZmkK
CnByZWZpeF9sZW49JHsjcHJlZml4fQpsZW49JCgobGVuIC0gcHJlZml4X2xlbikpCgplY2hvICJh
ZGp1c3RlZCBsZW46ICR7bGVufSIKCnB1c2hkICRkaXIKCiMgR2VuZXJhdGUgYSAyMDQ4LWJ5dGUg
bG9uZyBmaWxlbmFtZQpmaWxlbmFtZT0iJHtwcmVmaXh9JChwcmludGYgJyUwLnMxJyAkKHNlcSAx
ICRsZW4pKSIKCgojIENyZWF0ZSB0aGUgZmlsZQp0b3VjaCAiJGZpbGVuYW1lIgoKZWNobyAiQ3Jl
YXRlZCBhIGZpbGUgJHtmaWxlbmFtZX0iCg==

--_002_635128032b8c4a5faf7e4cdc09d1f339ddncom_--

