Return-Path: <linux-fsdevel+bounces-47405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239EA9D026
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203A89E5BE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6252153D2;
	Fri, 25 Apr 2025 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bIoByqzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F14214A98
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604151; cv=fail; b=TaU4EV1HGTq0pK6qbuvqoobG0bT4mD+3RjNdGmdm6znwFwr3DISXYBmUnhSZAQqK6fQ5dreDqw46984dRZX31m/ZPUR3xAfuK0y9Ydp1w0ukohwQCbHO0WLtRmcLV6WmUGz0Te+awW4LmmgzUENQv7JYDvefzzI4o/bw7EBd9yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604151; c=relaxed/simple;
	bh=XPyDojdKILDK3DmkaYcx3VrInK6a1qOY7Ur3Z+Nty5c=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=GoWivF0Ni4icUfJx0/AqcsjujvcHtTMCac+bmAbpsaSj/fmS67LxdyB7mljOdsRzWZCDVX31jTanV48iEVf/zz0/kYhpYlTFmKk4xyUiBLN5/ferJUBwgSgy2XTPuLxrvT0VCn318OI87ebgUy1GWrV9gHDGry3PXobLVxN2Z50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bIoByqzk; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P96mrd000360;
	Fri, 25 Apr 2025 18:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=XPyDojdKILDK3DmkaYcx3VrInK6a1qOY7Ur3Z+Nty5c=; b=bIoByqzk
	/mLCu0z5MDWZOewOxSFsOZPzlpt44a+qgy+VWlcrB2PEVAS69yByWDO8jnfwJ1EX
	0ChkM8PvaLkS3zRltn5+P7K2lv1Cy1cfBJf8oWkAO/vBIRRaMWl3Ul7nuLy91fBU
	kT1X5Vuhu0Q7VecV2B4LBg3Wpp+VwyLyBxPrzoIwSgiA6zNFbnx2PclY55dGBrw+
	+jljJl7PbSdalowzRMZraGSRXTbAgJzj/gLKaEly7fZEon3C6kfSXXXNnlQGtx0Z
	LP4tdGzrCxqHllGLLzZDIuAux+92euyZIlE28oI0BlQSQnyg/kud0NmeacBRAkRf
	OofQY6upQBTU5A==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467vvkw03s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:02:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iURVo8sYe+/T9RyLjW8IZbzi+jNZwftC67jyZwuT5glVgWqzhlU+rXuZA3saJS56AZHUvEkgPViJ7xsSbPpUH5oW2mogcA0KgGnPxJdeko4chMxDGLFvkY8IVEttBquQhTW4K2633O/QP86Bo4Ry9mA/MB6CRmuHqbdtKxB/nysjJF0YJKtAvNDBqm6+tQnLs2VvyS5PLmzXFK9OTBLLzmDBOJ+2pViYnhF15vE8k4kKfiAlIvSWAb/c+zdqMBf1cRGdcjA0u/vZ1MP9PS42l6Dzb30CZLf9y8JivgzJdzZrYuYbbopHHG789DgmE/gaFm06Idw4XsrYiXewFGVd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPyDojdKILDK3DmkaYcx3VrInK6a1qOY7Ur3Z+Nty5c=;
 b=Wx6JbBjr/bkvEtUWR2ciWwKRV7gE1LBPiCV/bsYrVyQUATOHfUGCUzBX6Mf+8gxbaOWkPxvrIVHfpzRW5nKCBQQdcwEVXw7GB3dG07gc6QAfi3+jq60xicQncjkWaBYUJAgsuemou1y+0i0MuSCIxG0EkeDW5cFWMvaMQApKSUDd1Yt4wRmrub9CVTo6jL2chW4erzT81Xdi1WGn7yDDWtExThyoUyeXt88JGz18e6FEPiMQy+mzxN5eEyG2zYuuCdPqnyqJptBdvdrL1rssY6cUmQ7Aw/zQPQKojNVGgzLNASYTuoapJ25oZoXQOATtC/dF0T26sDVQvG+13SHdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS7PR15MB5352.namprd15.prod.outlook.com (2603:10b6:8:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:02:20 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 18:02:20 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSDlm57lpI06IEhGUy9IRlMrIG1haW50YWluZXJzaGlwIGFj?=
 =?utf-8?Q?tion_items?=
Thread-Index: AQHbtctAn2x08Zy3nkyFRw/8SgRFHbO0rMiA
Date: Fri, 25 Apr 2025 18:02:20 +0000
Message-ID: <a5560fe32b5869a029891599f2e2d4b9e3d02a6d.camel@ibm.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
					 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
				 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
			 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
		 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
	 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
	 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
In-Reply-To:
 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS7PR15MB5352:EE_
x-ms-office365-filtering-correlation-id: eacc273b-b0ba-4a8e-80ce-08dd842352dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzIwdFpZTEliVHRlZHh4ajVKZmZranBVc3V4cWV6TkhJOG9yRGszWGgzOXJY?=
 =?utf-8?B?Rys2bEdaRzVoeVBQaG9mUVB3eCttWXNNNWwwQmhNS2dIOFJ6UExxZ2tmODdt?=
 =?utf-8?B?SDdBWVM2cDdSYTFUNEVqMlJwYnBHQVZZM0tvcGlvYzAxelA5R1hsejJMQkUr?=
 =?utf-8?B?L09vcnFkc0s3dU5HV25IcXZOVkhhNmtDbTBVY3NpRkpEOENOUXJ6QVEwZ2ZD?=
 =?utf-8?B?U3J0alBKOHp6Y210cjU3UWQ0WEdrNjVSZzlLVksxZEsxTkdGQXB2WjZzbndx?=
 =?utf-8?B?bWVXN1VqNUdDNjZRMDZZUFdaZ0xuTHhyc3NSTDRlZm1zRVhLUXdtNnZVTWdw?=
 =?utf-8?B?OHUvQUFPQ0ZWUEJsdFJVY24xZWNkUy9tMFE5MWlubXhkeWNIdlpMOERuMjg5?=
 =?utf-8?B?R2pwVFhzbUk0OWtzS2M5M292eG91M2lmamRNN3Q3ZFFxMWl4RWtFQ1NKOXdj?=
 =?utf-8?B?MndkWmhYS21iTDVYRjRVSHhHYVQybGNpa2ZVZ21lb2JFaDdkVHFnUnM5Vi9v?=
 =?utf-8?B?ZDZjVnVvVWxSZEx3cG1leGNrYnBsbGEwTmpaOU8vWkJjVTMvSUhmSVpMcXlF?=
 =?utf-8?B?YWE3cGx3QUVwZVV6YmtoUi9VcHpTd1l0WEN6c3VxUjY4Zzl3YTEwQURvWU1p?=
 =?utf-8?B?ZEloOFgwTUVjdEJrQjNCQmhlM2JzV0NuTE1xbTEvaGtqQ081aVZ3c3pRbVMr?=
 =?utf-8?B?b3FSMHl2aHNaZGFMSkhzWmxNeWhDYUNuVUhJVHl2bmpPbkx3VFBKRytKWmxs?=
 =?utf-8?B?eU5pSjJJNXBXZmF4cnMrTmhKMmRWMWJRcEVGVjlORHllNmxjVHpCSlRUcEtj?=
 =?utf-8?B?VVpwZGFaWFZRQUR5ajRvbkVXcWV0N0o0Zys0ekk4c3RxSWJXamhvT283bTUz?=
 =?utf-8?B?b0M3NkFFUEo5R1FDdktSbVFGM1VQbjRzMm9Db041bFM1Rm55RnEwK2Ryc2tz?=
 =?utf-8?B?WjE3a1grbWlJTGphQ1JSeE5TeldROEswRVlHaC9lWTVwcGZSUDJRZnh2L3JI?=
 =?utf-8?B?QnFRNEhUSWduUDB6NFJ1M1crR09DQmlHbDJzQlFWeUw0eE1NS1J2cDdlejdu?=
 =?utf-8?B?Z3hXL3Z2N2xWTWkxTkNqazRKbWh2VmFZYUNnaWF3emc4bkQ5YXNNVmx1dXFh?=
 =?utf-8?B?T2ovRnA4TnQ2anVHSXZCcldaWk9nZ1RTbEM5eVlRZnVKSzBFNG5LeXZwY0d2?=
 =?utf-8?B?ZE9HTk1Tb0ExZFc0WVJSNnZubUtqTXpDd2JIVkZjallhVVRFVkkzVit6K292?=
 =?utf-8?B?N21meDJNYnpzbkF6Tzg3WUNiRkU1UkN2L3czS3Z4dFM2WnJSOTBGK2JNMlVF?=
 =?utf-8?B?TFJxS1dOS3ZadXpHWlZ1Q2tOMDhGUVpTVCtFOG8zNllTMWhyeDl1RVVTNXg5?=
 =?utf-8?B?TDdmYkZvK1IvNkJaSjFwTC9PM1lCTkxPZmFtU2pTbzZ4Z0NwaVNQN2E5REtF?=
 =?utf-8?B?VGNvRWlIM1M0eFRvZ2QyNllRbVM5NjhKcnhDNDJRMzhCdENROXpZbUY4MHQ2?=
 =?utf-8?B?YUtHMnlLTGFJZzl1YUNBYzZZS1Z6Z1J5MHdFb0dIV3RlVE4wL1RtdWRUenc2?=
 =?utf-8?B?MWFHZXJJWlZDa2lvbTRNV0lSQlZYcVhaWDBIUkJBT2tGRlJKR1ZyTDJOWkJD?=
 =?utf-8?B?VmtCN25rSVFZc2MvLzVkMVd3UDB4bENpS3JHejFVUHRiL0c3Wm01TmQyQlVy?=
 =?utf-8?B?aG5STzhFOGhpOCtxakpWN0I4Vkx5dHRzVURweHYybFd0TmJpYUFTVEJWdDgr?=
 =?utf-8?B?aGVBSHhXbEcxRW4ra2tLOVBvMzlXZHpIK0lpVXpzdHBDbmpXd1FIb0NpLzkr?=
 =?utf-8?B?b2tXWEY3N2UzdFZHSzdmZkJXVEhZRVhSUkxKWThMcUtUT3FsamVQaEJYcytu?=
 =?utf-8?B?Ny9xcjh5aUNXdjZiUmJMUHdNd0Ywb0JYcjJBdloyK2hlRmZZd29aR1U5dkhs?=
 =?utf-8?B?dXdSOS9XYThrY1ZQZFdxUFN3MlRSWGRqZjViNk9PZ0oycFVCamplaXRaNWtQ?=
 =?utf-8?Q?HMzlFg1UeXO8T9a0Oq3jBS48p1Q54U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0dpWHJMamlvVFk5OFdRb2NGMDgvWFhjVVl4eEFrbmlYdlBYVUtmWlphcS9G?=
 =?utf-8?B?WmZuMTVvU3pXbjBEL0VrcnBmL3RQZGVpN09zb2JJNGk5STUrRnVhTnM2azMy?=
 =?utf-8?B?dGxPeW96ZnZ0SjBKM2owRnN2OCtaQ2hLallRU2RVNVR6SnlYVDQ2OXhOQmMz?=
 =?utf-8?B?eW4xWVIyL2ljOHFGa2dTdmN0MmVDYlQ5ZUYvNHBSWUh3TzA1NFJZSmp6L1I2?=
 =?utf-8?B?SFNVZmtXUm1RU0JKdk9mZHR0WGVWV044ZmlkZFFLYmJxeWd5Y3V0bVFQczdZ?=
 =?utf-8?B?TU5UbEFNam1heVRvZFI2cEF3bFllMTVQbTU4N2pUOWtMS0RJcEQzbjJBS3ZL?=
 =?utf-8?B?OFVJMGx6eUlhUUJoamswSXFrQXlkR2FKMTI2c0NyZEgzMDd5K0QyaC8weFBD?=
 =?utf-8?B?VmhkMXZMRm9RR1QzS0VPQUV3Lzd5MExudndVZFZob2M5Qnh0SzQ4OUVERktM?=
 =?utf-8?B?NlkyNkxndk9qYUtMQi8xSzNRMHlBQzRyUTEzazNzVVppaDlhdWFMaERwUy93?=
 =?utf-8?B?MDZpVzBkUmtuTVF2RFgxb2RURENkVFpLU1lqQWkycHdXQVFMbm5QT2hOZDZS?=
 =?utf-8?B?czNTY1V1dzF5bDFLdm96U01wL3RQN2ltaFdyM0pjZ0Q5dGJ0UzgrRW5lTmVC?=
 =?utf-8?B?Um1rSGl4K2ptakRHK0lvQTlnMExkTXBzd0RCMk9MZGtxUkFwR24wYXFwSHVV?=
 =?utf-8?B?b3pYU1B1ekNwNW5SV3hsbmN2RnR3Y3RmZHkzNlVxVUhLRE1xV3RueFhEUXZW?=
 =?utf-8?B?V3B2UVZkczdUWDJQOFZEUkhKUHpScXB2TjBQSzF1TE42dzNmUUxqZUUyYmIw?=
 =?utf-8?B?ajIvMGJKYmtCcmNOK1FqVDVzdG1OWDNwbFVYYUg5WkhHS3ZGVG9zdTAyL2Z6?=
 =?utf-8?B?a3VvR3J4ZVpKSVM0cWZPdVNhcEJxLzNKa0thSXcxZkROZXFrTEozZ2lnSzhr?=
 =?utf-8?B?bjRyMlpFaXo5Ujg4eG9BenQ5UmpZWDlON05hMWxtYytwZkNjckc1SldkTUl5?=
 =?utf-8?B?Y2xLd0ljUmp2MTlKaGpwK3g5VEdSZk52Nm9ucENQbnAyZ01wbEYrMUZ3TUJI?=
 =?utf-8?B?TVNxNkVXTWFDcHlHR0ZueWY0U1dLc3M3Nk4wRG1saFVZUlRxVkhvekgrTTFk?=
 =?utf-8?B?cTZCOFpCS053bWdXUTNZNWJVUk9CTVNza2lpL3ErbFFmTDhjVTd3RXpkd0Rx?=
 =?utf-8?B?azh0bmdLRWdQKytXWDhCd2ZXaElCbHdvNnNpR0p0Vzdoa3lIaDl6dXYzcUJU?=
 =?utf-8?B?OWhmeDhCdEo2cnlYUWVwQUVMbmQzN21CWWR6TzZPWXZUYmFZSHBFVlcrV3Er?=
 =?utf-8?B?bjFEU2NwNWxUT2I2dG1zZUZScFhnaVByMTN2OTNqdUhFeXBYQUdINDNhd1Y0?=
 =?utf-8?B?aTJBeXZ6RHc3dGEyYXpwMGd6cmUrL3R0ejVFLzh4d1JlS0hCNzZkMmRpVlhU?=
 =?utf-8?B?enVtTFZ4QklYMHZXYW5haTUzbXNpdDZYR1pNblFyZDVXUGN4SmhXREhmVzlH?=
 =?utf-8?B?WVdqK1Y1dm55b1hmclhiOU4xbmU3TzY0RUpSNTNRMDRGaWE0V0JXRzhtc3Iw?=
 =?utf-8?B?dVdlcVphbUxPRUpOQXlXZXBlTk9vdmJGOXdZWkxEd2czZFhqWjJTS2s4WDR2?=
 =?utf-8?B?ZW8zb0F1L3NpVElGbnJMdXdXbWNYdWdWVHpCdmNqaEpYVzIzQ2dBdm9SZ1RV?=
 =?utf-8?B?MUI2UUdFc3N5ZnNXVXNJK2ljb0xFUnZZSDZIdEhGM2prMEpnZU9mdFk0R2g5?=
 =?utf-8?B?elRRWE90NDkzNVhYU1ovK21sVU9OUkxzNTRvdDFNMFlRVVZCSVF5N2pRZU1Y?=
 =?utf-8?B?RlEwbUNjZnlLaExuazZGdnZHbHFXMHE0c3c3TVJRZDAzQ0V2ajFvZHRHbFEr?=
 =?utf-8?B?SDMyQStRYXQ2dThNS1BLMUxSdUZQenJNcU1tOWNJK2ZjVjJwWnNLN3BSQ1pB?=
 =?utf-8?B?SXJPZElPOVFYV0VWWldhQm1kSWkxNWJYR2VmUVlsbDBuNkpWR052S01PaXpt?=
 =?utf-8?B?R2NQaDZaeEJpbmZlRnJ5QnJaRzJJeStyQ0RIcnZVclEzQ0JLak8zRk50WmZr?=
 =?utf-8?B?Njc1WTNHSFkzUm9qcE9IYmJMRXJneDVVYnl4SGNFQlBrMmd2UUJxR2Jac0Rz?=
 =?utf-8?B?VDFEa0F4cTNiNXhCS0dBTE5UeUQwZ3JhOHFDbDc2WklmSXdTQ0RmTFJMTVNu?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B095ADFA18896145B35CE53DBEF00310@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eacc273b-b0ba-4a8e-80ce-08dd842352dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 18:02:20.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmlHJVIjP/AGAst8eS406iTzxTQJtv2/2XbD8zzyV8M8cq+dOC/Ea5LnrM8KgLKqeRQORzrSB8/rScQGi1N86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5352
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEyNSBTYWx0ZWRfX5biStD+6GJ4/ jHZUVGs23fULiQffDXdzwm+EH91KiqX5eGdZCxq/Zgo5aVwnpyJyaKPK/3p8gbPwrNv66SA+r2A G2CeUV0y+us0YGA9CPZQxDQ64PUVMe/a3KTJgWIGKcUXN8NWiowTnZYSpK5Oawsp7TuQxYDGBTx
 OPKRpioViQSf4k8SZdvyy7FdwT7odAvjTD23eAWgHYVbCO+L0yzoZ1E8k8iR1X7zTDZBlNdkn5+ kwB4u8F96OA8n33miBIrnTvePqEuWOA0lyZ8PMPPbfQ17qwXKw1Q36OwCCeIpBjOf9sU3PbCYLK /e6nL/0vHn7/lbSCTf2QAOxOKhsnWxR9+7s5d5ONFx+tbCqRfs+cshoPEZ4p5EK+jNjuz8ta/ex
 qLAaXrpqlbDWzAWaJZ5J8BLNdAUz4I7CuSzjaUPBAWaH4T4xZ4n3BPt9lse4jXa7Eia1/kKK
X-Proofpoint-ORIG-GUID: 2ijwmw_PvSUF3Zt4HweUVOKVmIS34fii
X-Proofpoint-GUID: 2ijwmw_PvSUF3Zt4HweUVOKVmIS34fii
X-Authority-Analysis: v=2.4 cv=HoF2G1TS c=1 sm=1 tr=0 ts=680bce2e cx=c_pps a=G+3U1htxrnhIFlrbIuZW0A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=5KLPUuaC_9wA:10 a=8jXEtL0VJQd0iLkve0QA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
Subject: =?UTF-8?Q?Re:__=E5=9B=9E=E5=A4=8D:_HFS/HFS+_maintainership_action_items?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=921
 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250125

SGkgWWFuZ3RhbywNCg0KT24gRnJpLCAyMDI1LTA0LTI1IGF0IDEwOjE3ICswMDAwLCDmnY7miazp
n6wgd3JvdGU6DQo+IEhpIFNsYXZhLA0KPiANCj4gPiBTbywgd2UgbmVlZCBhdCBmaXJzdCB0byBj
aGVjayB0aGVzZSBpc3N1ZXMuIEFuZCBpdCdzIGEgbG90IG9mIHdvcmsuIDopDQo+IA0KPiBUaGF0
J3MgYSBsb3Qgb2YgdGVzdCBmYWlsdXJlcywgcHJvYmFibHkgbWFueSBmb3IgdGhlIHNhbWUgcmVh
c29uLg0KPiANCg0KUHJvYmFibHksIHllcywgYnV0IHdlIG5lZWQgdG8gY2hlY2sgaXQuIElmIGl0
IGlzIG9uZSBvciBzZXZlcmFsIHJvb3QgY2F1c2VzLA0KdGhlbiB3ZSBhcmUgbHVja3kuIDopDQoN
Cj4gQXJlIHRoZXJlIGFueSBjaGFuZ2VzIHRvIHhmc3Rlc3Q/IEhhcyB0aGlzIGJlZW4gc2VudCB0
byB0aGUgZnN0ZXN0IG1haWxpbmcgbGlzdD8NCj4gDQoNClRoaXMgaXMgYSBnZW5lcmljIHRlc3Qg
Y2FzZXMgYW5kIG90aGVyIGZpbGUgc3lzdGVtcyBjYW4gcGFzcyBpdC4gRm9yIGV4YW1wbGUsIEkN
CmNhbiBwYXNzIHhmc3Rlc3RzIGZvciBDZXBoRlMga2VybmVsIGNsaWVudC4gU28sIHdlIG11c3Qg
dGhpbmsgbm93IHRoYXQgaXQgaXMNCkhGUy9IRlMrIGlzc3VlcyB1bnRpbCB3ZSBjYW4gcHJvdmUg
dGhlIG9wcG9zaXRlIG9uZS4NCg0KPiBJJ20gYWxzbyBwbGFubmluZyB0byBzdGFydCBkZXBsb3lp
bmcgYSBsb2NhbCB4ZnN0ZXN0IGVudmlyb25tZW50LiA6ICkNCj4gDQoNClNvdW5kcyBncmVhdCEg
SSB0aGluayB3ZSB3aWxsIG5lZWQgdG8gZGlzdHJpYnV0ZSB0ZXN0LWNhc2VzIGNoZWNrIHRvIGF2
b2lkIHRoZQ0KZHVwbGljYXRpb24gb2YgZWZmb3J0cy4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

