Return-Path: <linux-fsdevel+bounces-41835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955BFA3802F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548063A3541
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8AC217671;
	Mon, 17 Feb 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="HvAJyDf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E62165E3;
	Mon, 17 Feb 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788205; cv=fail; b=WfP6CN8IZZ25h5re9hGv41bgTnlc5++E2BpBOfTo3xSEfDBYFPZokv4fxn/KjK2z+JC03FzvqlwP7YQF3EFDxpd8TaKRu/3dh0A884XNslX1Ac2UDjMGkuTZS//kCDmtZ9kHF/I8QVfmk+f5iHxi2HViiQVxm6rsQhe9XU35Gfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788205; c=relaxed/simple;
	bh=RoMolMmAMs7tbZkYGpr2LnHDheNtZwXL8bCsf7Ez69Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XKfTEtNO8foSfXRlopRGP2XwzK9K1WWak57KLT/gbzOhvUUSTmkEnt+cl7FP1aZ76Qk9mh1Oca82nExE46NEJq3mP1BtInsrlCRYca9VDB+B5r8s9sPveRx8ydKrNlpMy09qJktgj/FUc5rck//byicOD93bD45ASXfx8TBu1xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=HvAJyDf8; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175]) by mx-outbound14-134.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 17 Feb 2025 10:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIwA04U4cNXWc4YW3DgAXw+xskqjBN4XIGheZv+WxW9jMeb7ZY9FqZSFyZvr3aHTc4a/Tkhn5YhME5mSyvSmXOo0NZqh1A6ubOrphW0z16aDYl2+Nsve0sTVuiOQUUmciU7FIoM4p44R0jCn7EbM+HlW4NaOsln2BeE0LsBiEgO1S45SXXe4Yx342WacbbA2C4PhQ55GykSodScUjmpn5NOp3Qpei3UIpJaeCUS81u17JSjfnYtAyN9muV8FQmgHDMo1i9fEak8l8MgUMCIUHGbU29Jd/vkebwVpT/pTLwrmzXdTCvzrTxiG37l/yZYegvqj8DXTr2L+Em6wn0YISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoMolMmAMs7tbZkYGpr2LnHDheNtZwXL8bCsf7Ez69Y=;
 b=eatynmcW3UTmc+e90emzYemgjWsMivFPFu25gRogPyfqPdybNnaUzqMXvQbOwxDK+Es+0IGoPzsgOAywZnZyDt6oM0/MtlCWnsOsZqU9rgrzvD/zs1u4zlbmmzuV9eoaSrchtIPdXpesWx/mL4CjMP5kQWAmMJdcfWMymBtIgO1jtKBcfxt7aRjWaSqVJHsMJNA46xkDCxBdwCe7+9Gwo0a2raDG9mzLgv50BXQZxSPXzh9lVHMIuhescmLeIoYy3SfniQvgUQmdjoiLkQaKfDYx1Q1LC/bLim928/vCJ+O9oZOHosbOhnQSP8QaS+4iuNHr8SWJTwzZKtSErscQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoMolMmAMs7tbZkYGpr2LnHDheNtZwXL8bCsf7Ez69Y=;
 b=HvAJyDf8TszGx95oJT7VnOSVzGsQBbxcilyeR0mEa8UeQSxlODy2xI0LFTdgkGCGcpE/TWPZvZBbw9QEAeLRbsEEXRQ9xUjLQzarD01WTeZsAOilEOZVhSuxl1JU94RfQLVr9E5M+MrM2OK0NlR9gRXPdjd5/nH4jjqRO1ka49c=
Received: from MN2PR19MB3872.namprd19.prod.outlook.com (2603:10b6:208:1e8::8)
 by DS0PR19MB8000.namprd19.prod.outlook.com (2603:10b6:8:12b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Mon, 17 Feb
 2025 10:29:33 +0000
Received: from MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::739:3aed:4ea0:3911]) by MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::739:3aed:4ea0:3911%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 10:29:32 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dave Chinner <david@fromorbit.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matt Harvey
	<mharvey@jumptrading.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] fuse: add new function to invalidate cache for all
 inodes
Thread-Topic: [PATCH v5 2/2] fuse: add new function to invalidate cache for
 all inodes
Thread-Index: AQHbgJLhHGevaQDFkkiuv/ibLVN4ArNKp9QAgACem9eAAAYVAA==
Date: Mon, 17 Feb 2025 10:29:32 +0000
Message-ID: <847288fa-b66a-4f3d-9f50-52fa293a1189@ddn.com>
References: <20250216165008.6671-1-luis@igalia.com>
 <20250216165008.6671-3-luis@igalia.com>
 <3fac8c84-2c41-461d-92f1-255903fc62a9@ddn.com> <87r03wx4th.fsf@igalia.com>
In-Reply-To: <87r03wx4th.fsf@igalia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3872:EE_|DS0PR19MB8000:EE_
x-ms-office365-filtering-correlation-id: ac355fe4-2328-4a14-7bea-08dd4f3df7e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVNQR0E0ZTFBekNDL3MxZUNiT2hCS3NUMnZnTTVoMkw1c2VDemkwTzVtZVMz?=
 =?utf-8?B?MWpRaEJiSjBkUVlSeDliWHR2SHpWdThjcDRLM0RVZzF3bnBGRTltR0UvRFAr?=
 =?utf-8?B?S3FqQ3BrT2tBWTUyZFcvSGJ6RVFhQ09ZbzlZQlAwRUx1eDNpa0ZmS0MyOWdx?=
 =?utf-8?B?dlZqYU1zNFZ1QlNvL1JPQ2VvNXZSOC9FNk9BMW5hVE1SNkc5dWF0SUxQR2Qy?=
 =?utf-8?B?QnI2NldvSWNDeW16RkIzQWphdnRRd1hTZm5LOWZjK3lRZjByUCtNQ3o1dWJK?=
 =?utf-8?B?ZmpCS3VlMFFPZHRhb0NzaTlSYlgreFZJL2tmeVR5WUU1SG1GUXNNMm96YldO?=
 =?utf-8?B?cDhkaVpyakpDaGdaWkwzZTBqM2Zyb29YZm9QMCtyVWVGSkoyeWRDRXQxK0JJ?=
 =?utf-8?B?UjlxNkRQVmJhSWRqU2lXYXVwRTFOS3p4SjMyMUxCY2J5VVpXUnVVayt4Mkk5?=
 =?utf-8?B?R0ltbWhXcDdBMGxSM2lIYXdKM2VZMnBnU1U3cXpMZFdLcGFTUFNydzR3a21o?=
 =?utf-8?B?YWQrT1htSGExZkpnREFMdWZudGt0ck5BNFFkWEpOY3I1blVwZ2ZqUkQzZmwz?=
 =?utf-8?B?T3plYXdDT21vZWlzbjA4MTBhR3ltQkRjSWRrQWNkL1l0bm5tTU5IMzJGWGUw?=
 =?utf-8?B?ZElRMThwUlZFYWxBRjkxWUpRNnlicTE5Y2Q2ZmJZQzhUamk0N1I3VFhRdlhj?=
 =?utf-8?B?WFlQbUMzSU92aVZIdjdUVDQ4dkRHci9yUEI4ZGpDa3RVSHZZVjhwaGR2ZG5H?=
 =?utf-8?B?MzVUNzBHU0tKRXdGaVRWMDhtMlZSWlArY1dWWW9COEtXejIyNVMxRjRoUmhr?=
 =?utf-8?B?K2xPV0kzeFN1WjBFYjY2Z3RjeEU3c1JENm4wUjdzZG5BYVNqclc2ZjdJcXlB?=
 =?utf-8?B?VElKUU9RSnkrV3J1RW1aQ2NyelFSL2l0dnlBUHdxTHFQdjVvd0pSRGpveHpE?=
 =?utf-8?B?aURiSk9BMWVRYWhWSGNhbFlxbzY0UXhQNkxhczZaT1RYT2E4em9lbmZVVDdT?=
 =?utf-8?B?K0VSZUs1SDJsZ2NpMm9ueDRtNXpCWXYxZFpwczZlTnJYVVd6WnZLcTY4WE9B?=
 =?utf-8?B?ektWdXhOQ0h5ek10YXJrSWxOcDdpRkdwVGluTnFQWnN2Wlp0Z2puN3NLdjdr?=
 =?utf-8?B?V254NGtBdHQ3SU1IUG9WeUpMYXJXVE5DTUhpS3hpemVHNE5qazFodFRIeUdI?=
 =?utf-8?B?dmxqcGlNRE9uemt0dUxIcmk1My9qaVdVc2xWTEx2aXVHOGlNK0c0cllTNzY4?=
 =?utf-8?B?Ym02MUpXVVpUazIxMDZYaURsUVZLYzRsdFhubU54QWM2Z2toVE5OUGw5b3dC?=
 =?utf-8?B?YVo2aE1ldUtNdWJiNDRmZlh0emlFY3YzaGE5OXc3dTB3L2pLelgwQk5JWjVO?=
 =?utf-8?B?VGNZVmZNZEpmMHRvbWRIZ04ya255SlhUYkFDWkZINmhyZFZRdGVoUC9scjBY?=
 =?utf-8?B?bjlvTncrc2hpdkFwMkN3Z3MxSG05OW5Vb1o0TDlEUWJHelYwSFR4VmtiRzhv?=
 =?utf-8?B?RmxFWlgvQ3libFUyQU54VkpQZ25kNjVZVThhc0VxWHpnTUExS0tnQlpkSkZo?=
 =?utf-8?B?ajZRV0dRSXluQllEL1FsR3BBOXZxYUZBd0NVbGNSeVg2WGVXekZRMFR3UitP?=
 =?utf-8?B?TTBSR2pjbklOR2NQMTNHeURLVXVkY0U1TkI0ZEVDMkcxcm9zUW54OEtmUWRv?=
 =?utf-8?B?blhYWTlMTmRxZThmQitjOCtST09EMkJ6QlZGaVI0NVZxVlBXVHNOSUhxTkVG?=
 =?utf-8?B?TVV5TjF0VzhMK3RqaW9acEdkaHl2SnluM3BmNlZJMnlYWm5DT0c1TC9UWXdD?=
 =?utf-8?B?VzE3SklOK01Gb0IvQXp5Slpyb05NUHEvK25FeHJDaThkQzgrZTFoYkpUcU5y?=
 =?utf-8?B?K1hEQzRnd1NtcGpIV3dZNTEvUTl0QlpIUU5ZVmtFUk5KUXg0Y1NsVzJxN0w3?=
 =?utf-8?Q?IRSeOKYL0xQnnOXh7rMsegEegWTsi+5w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3872.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXZCTmxPcDBOVko3UnM3VVp2dHQzYW1iN0dENmhaUWVzMDJsQU9heXk0RHBJ?=
 =?utf-8?B?WUpEUlI5TVNkZzZFUjZjeENadE1PK3hxdS9JTHh5T3dWUDgxa04wdzRUOEd5?=
 =?utf-8?B?N1UzTEk3cW1qN3V5UlczZTlDUVI2N0grTEFwaW96SHZJMXlhM3RnMTZmaTJp?=
 =?utf-8?B?QzkyUmordDZpMk1JY01MN3hmWG9MNm9GWFZkNzNRSTJTaUc5VlJYSlViRFox?=
 =?utf-8?B?d202dFpMTHBydDBKOWxtTWRHWko5OXllVEVEcWkyVHExYkd4QnNoVWdnMllL?=
 =?utf-8?B?QzlidENSTno2OGo1Sm14NEYzZ1o0YjJQb29PenZkQkRSelpEbndrN1dhMEZ6?=
 =?utf-8?B?OFg5L3NFbEdZQk93a1dWTURLZktCelRweXBOdC9GWjhIOWx5ME5Rb1puMDAy?=
 =?utf-8?B?cXFOZExsNVM3RngrUWtCUGpMYVNaeWkyWVlYYzMyUkNxdVE3aUpGbkI4bTBy?=
 =?utf-8?B?L1Z2b0pCMnVNRlZWRlFlLzh6a1JHdzJVUzd5ZkMzc005cm9xWUI3TEYvQVo0?=
 =?utf-8?B?OUNlanNmbnRrbmxIWE9YaWtQUHBod0ZNcXA2ZFR4UVVWVk52TG5GbURwTGUw?=
 =?utf-8?B?ZWp5NUkvR0lLenlJenVGdEcvR2xBb29ka2lJaTRhU2Zwd0dOc3NOVUtFUU5t?=
 =?utf-8?B?K2VlMEdqci9pSFNNbkdVUmlkM3cxWXI0MTd2cFJtWVMrTnZDNllCNW5PeFdX?=
 =?utf-8?B?cklwcWNiWHc3M1RPVENBUzR2U09BME9VN28weHhwY3RzRkJjcG1ZbUlIb1Jm?=
 =?utf-8?B?Uy92V3dqY2pSQzQ2ckNpdVNrbkMwdHpZUmRRd2VVanU0TmNrWU04a3NIcyt5?=
 =?utf-8?B?MEpyblRYK2JBRUZGUmNPUk45NGZLWVpRMXRwUU1tZUpXTEhtUFhHcklTVnZq?=
 =?utf-8?B?aElvSFR3T0g3MldmVDhtOUdsc1BwNEIwR2NWQ2lwN1FjR05WTjN2NE5BbmJO?=
 =?utf-8?B?ckpRYmJ1UHJreWNlZFVNRmplcXZUQ1pUN0J3K3h6TC9uVVlaRUM4M2JBRE4x?=
 =?utf-8?B?bFZNUlIxOElWRVFteGsxVVdoSGRSZnlrWXUrM1B0azhmVkFkMFRUQVlwOVR2?=
 =?utf-8?B?dVNzVkpycTA1SUNhdkJiWW1admEvbFdRdmNUSU5yd3h4UVVEZytWYy9yOGJL?=
 =?utf-8?B?L1hwNnl0V0pjNU1FdkJnVExFWTdCOG9mcTIrbnFyQXkxdGpSYVVPRE1ud1ZL?=
 =?utf-8?B?bUxBSzBySWhjL3JEaGx5M1dGN01sbEZ2TEROZ0NiVDB3U3RUTEN6VEUyZUJu?=
 =?utf-8?B?VmZDbURDcnhIc2FqMWpKTFR2UERyRExjS2NpckdyaXJ5V1JPeGJKRVpPZFVo?=
 =?utf-8?B?Ni9jUWFvaC9iT0hWUVdGaDNRbHVFSnloZTVXb2dubk1mUmdINW5LTWJGTWtX?=
 =?utf-8?B?aDl2NGRTU1pLYjJnaVp3MXhabUhSM0dkWFA3dllDa3oyQk50UUdQWlZ2bm5i?=
 =?utf-8?B?MVJadWowc2xpUkpvek1DaThzdk9MYkE5ek9nWjZ0L0xpcmRBY3BvMEtWRC9U?=
 =?utf-8?B?TTVlUng4SXhBWWRjL3N4NHVCVHYzdW5NQ1FoTVlvVjd3cUlrTlU0R2NCMGFx?=
 =?utf-8?B?dDRLZTgyOWw0c1E4ZXY2VndyUUJJR2k4UGdkSnhzalJEWUllR1Nya1ZaS3NV?=
 =?utf-8?B?S3RadTdJWm5pS2xONHdlUzVXbjczVWJES1EwZzNwWXRxTHFqc3BhZGlVdHA4?=
 =?utf-8?B?bzlRalUvY04rYmppYnBSUE5CK0l4cnhQaDV4NTAxdlJEeUpwdUIxbTBNODBZ?=
 =?utf-8?B?Z2gzdkNEWDQrUk9vSUpTVVRHaVJNRkhwY0lDQUJabG5oRURNODRXYTJlMThk?=
 =?utf-8?B?L1Y5ODBmcStuNGRDQjZ0OUxVdVVyam1qNE90aDlsUzI0R1ZqTXZkOTB3R2Zi?=
 =?utf-8?B?eElzWERBVkhtcUxiK2toOUgzaUZFTTdpZ1FKbEdiM2dwdnd4d0NMaDNXb1Nh?=
 =?utf-8?B?eWZwOVQ2ZFBYSzFrZ3JOeWxyNGNKN2w4OUJsUGpnUEk4VlhhR21VQ1Zmejdt?=
 =?utf-8?B?REd0WjdFYnZ5RmVJRTlaQW9yN0c5cWpxVzBwT3NBckJwdk0yVVg5bWZ4aDB2?=
 =?utf-8?B?dHV3dUlnL283dzd1aGFUN3dQSHUycU5CbjgyM0tlMVphZDJ0Zi9XOXgwSnJO?=
 =?utf-8?B?dEJ2MVVnM0QxYW52UHpBcEhPQ294N0NrTjVxMVJQcng3VTUxU3poVmMrYnJZ?=
 =?utf-8?Q?JJyAsLPk8Sd+NzmGf/IC96I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1308B13C57C3D4F845E63F4EAE3B7C4@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yMTek+mxcAthIRl+koyFYUhbaCtpI/uoY1xJ+59J8Afeau/g0rB0kpZtyhb2vhfmyFS66BmmJiaDK3va70pbJ379g9YSYaRDUQZP9+yuwhD4rp6Lu6a0FCECr/eGVUBta45hv0MzLVRi/zcBiCENDxAZMnucJGqFMcvWglWpFJ2omfQzKBScgMdvF/GOMEp0p4GWIRJTjKEwkUnOv7Ldq0LmvQB5qIZAf5HtilRoe6YN0rJiG4dGHc6ueX2zIAUeH8hdcVz3i7ICPY8tJJnGzZVQeaXYUfo+LNIbdhCUH8gNA1yCe53Aw6fYzYqLraPb9Ey3bYncyzYi6XJLAex2rCBOf+/np7x267p1cFOOAsnReV1xUtrC9lQZ5Cie8mj3tQhkGf0t7C78y7hxHLxiBFEjCI37iJF9kGRJTyRMLvblwEvbZ/4Ubl1a4l3MEQzfHkg8HA2XivLO5Ws2o5xVgzpVSG8CmW1iWs/xulHmQ/530sWPmvsA3ROdjYrtUe67O9L/tsoeoI8ytC1OUrrGgR0jT4w8DZBwUrKJpLAkbBQ8CT8ZS4KnbgNyvXNVMNxp5pnfh5K+gAiN8FOo0LGCDyuuLXF5b/pUr0CgpF76Iu6eJtkKvL2gfOIx+htFt81r4K/QtNbBOmq2CY9jz0x2kg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3872.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac355fe4-2328-4a14-7bea-08dd4f3df7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 10:29:32.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcFUJ0MHEH2wq2Fe0hTs70zThsqCTac+yPT5cxUjtixPxVM44i4dnRtF+F/MnI9duAOkORQGI3obT9trYF82nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8000
X-BESS-ID: 1739788175-103718-7582-11240-1
X-BESS-VER: 2019.1_20250210.2217
X-BESS-Apparent-Source-IP: 104.47.59.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGZoZAVgZQMM3UxDjVNNHU0C
	Qt0dTYLMkixTQpyczAzCLFMC0t1dhCqTYWAJjNpt1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262577 [from 
	cloudscan8-72.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMi8xNy8yNSAxMTowNywgTHVpcyBIZW5yaXF1ZXMgd3JvdGU6DQo+IE9uIE1vbiwgRmViIDE3
IDIwMjUsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPiANCj4+IE9uIDIvMTYvMjUgMTc6NTAsIEx1
aXMgSGVucmlxdWVzIHdyb3RlOg0KPj4+IEN1cnJlbnRseSB1c2Vyc3BhY2UgaXMgYWJsZSB0byBu
b3RpZnkgdGhlIGtlcm5lbCB0byBpbnZhbGlkYXRlIHRoZSBjYWNoZQ0KPj4+IGZvciBhbiBpbm9k
ZS4gIFRoaXMgbWVhbnMgdGhhdCwgaWYgYWxsIHRoZSBpbm9kZXMgaW4gYSBmaWxlc3lzdGVtIG5l
ZWQgdG8NCj4+PiBiZSBpbnZhbGlkYXRlZCwgdGhlbiB1c2Vyc3BhY2UgbmVlZHMgdG8gaXRlcmF0
ZSB0aHJvdWdoIGFsbCBvZiB0aGVtIGFuZCBkbw0KPj4+IHRoaXMga2VybmVsIG5vdGlmaWNhdGlv
biBzZXBhcmF0ZWx5Lg0KPj4+DQo+Pj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IG9wdGlvbiB0aGF0
IGFsbG93cyB1c2Vyc3BhY2UgdG8gaW52YWxpZGF0ZSBhbGwgdGhlDQo+Pj4gaW5vZGVzIHdpdGgg
YSBzaW5nbGUgbm90aWZpY2F0aW9uIG9wZXJhdGlvbi4gIEluIGFkZGl0aW9uIHRvIGludmFsaWRh
dGUNCj4+PiBhbGwgdGhlIGlub2RlcywgaXQgYWxzbyBzaHJpbmtzIHRoZSBzYiBkY2FjaGUuDQo+
Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBMdWlzIEhlbnJpcXVlcyA8bHVpc0BpZ2FsaWEuY29tPg0K
Pj4+IC0tLQ0KPj4+ICBmcy9mdXNlL2lub2RlLmMgICAgICAgICAgIHwgMzMgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+Pj4gIGluY2x1ZGUvdWFwaS9saW51eC9mdXNlLmggfCAg
MyArKysNCj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvZnMvZnVzZS9pbm9kZS5jIGIvZnMvZnVzZS9pbm9kZS5jDQo+Pj4gaW5kZXgg
ZTlkYjJjYjhjMTUwLi4wMWE0ZGM1Njc3YWUgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMvZnVzZS9pbm9k
ZS5jDQo+Pj4gKysrIGIvZnMvZnVzZS9pbm9kZS5jDQo+Pj4gQEAgLTU0Nyw2ICs1NDcsMzYgQEAg
c3RydWN0IGlub2RlICpmdXNlX2lsb29rdXAoc3RydWN0IGZ1c2VfY29ubiAqZmMsIHU2NCBub2Rl
aWQsDQo+Pj4gIAlyZXR1cm4gTlVMTDsNCj4+PiAgfQ0KPj4+ICANCj4+PiArc3RhdGljIGludCBm
dXNlX3JldmVyc2VfaW52YWxfYWxsKHN0cnVjdCBmdXNlX2Nvbm4gKmZjKQ0KPj4+ICt7DQo+Pj4g
KwlzdHJ1Y3QgZnVzZV9tb3VudCAqZm07DQo+Pj4gKwlzdHJ1Y3QgaW5vZGUgKmlub2RlOw0KPj4+
ICsNCj4+PiArCWlub2RlID0gZnVzZV9pbG9va3VwKGZjLCBGVVNFX1JPT1RfSUQsICZmbSk7DQo+
Pj4gKwlpZiAoIWlub2RlIHx8ICFmbSkNCj4+PiArCQlyZXR1cm4gLUVOT0VOVDsNCj4+PiArDQo+
Pj4gKwkvKiBSZW1vdmUgYWxsIHBvc3NpYmxlIGFjdGl2ZSByZWZlcmVuY2VzIHRvIGNhY2hlZCBp
bm9kZXMgKi8NCj4+PiArCXNocmlua19kY2FjaGVfc2IoZm0tPnNiKTsNCj4+PiArDQo+Pj4gKwkv
KiBSZW1vdmUgYWxsIHVucmVmZXJlbmNlZCBpbm9kZXMgZnJvbSBjYWNoZSAqLw0KPj4+ICsJaW52
YWxpZGF0ZV9pbm9kZXMoZm0tPnNiKTsNCj4+PiArDQo+Pj4gKwlyZXR1cm4gMDsNCj4+PiArfQ0K
Pj4+ICsNCj4+PiArLyoNCj4+PiArICogTm90aWZ5IHRvIGludmFsaWRhdGUgaW5vZGVzIGNhY2hl
LiAgSXQgY2FuIGJlIGNhbGxlZCB3aXRoIEBub2RlaWQgc2V0IHRvDQo+Pj4gKyAqIGVpdGhlcjoN
Cj4+PiArICoNCj4+PiArICogLSBBbiBpbm9kZSBudW1iZXIgLSBBbnkgcGVuZGluZyB3cml0ZWJh
Y2tzIHdpdGhpbiB0aGUgcmFnZSBbQG9mZnNldCBAbGVuXQ0KPj4+ICsgKiAgIHdpbGwgYmUgdHJp
Z2dlcmVkIGFuZCB0aGUgaW5vZGUgd2lsbCBiZSB2YWxpZGF0ZWQuICBUbyBpbnZhbGlkYXRlIHRo
ZSB3aG9sZQ0KPj4+ICsgKiAgIGNhY2hlIEBvZmZzZXQgaGFzIHRvIGJlIHNldCB0byAnMCcgYW5k
IEBsZW4gbmVlZHMgdG8gYmUgPD0gJzAnOyBpZiBAb2Zmc2V0DQo+Pj4gKyAqICAgaXMgbmVnYXRp
dmUsIG9ubHkgdGhlIGlub2RlIGF0dHJpYnV0ZXMgYXJlIGludmFsaWRhdGVkLg0KPj4+ICsgKg0K
Pj4+ICsgKiAtIEZVU0VfSU5WQUxfQUxMX0lOT0RFUyAtIEFsbCB0aGUgaW5vZGVzIGluIHRoZSBz
dXBlcmJsb2NrIGFyZSBpbnZhbGlkYXRlZA0KPj4+ICsgKiAgIGFuZCB0aGUgd2hvbGUgZGNhY2hl
IGlzIHNocmlua2VkLg0KPj4+ICsgKi8NCj4+PiAgaW50IGZ1c2VfcmV2ZXJzZV9pbnZhbF9pbm9k
ZShzdHJ1Y3QgZnVzZV9jb25uICpmYywgdTY0IG5vZGVpZCwNCj4+PiAgCQkJICAgICBsb2ZmX3Qg
b2Zmc2V0LCBsb2ZmX3QgbGVuKQ0KPj4+ICB7DQo+Pj4gQEAgLTU1NSw2ICs1ODUsOSBAQCBpbnQg
ZnVzZV9yZXZlcnNlX2ludmFsX2lub2RlKHN0cnVjdCBmdXNlX2Nvbm4gKmZjLCB1NjQgbm9kZWlk
LA0KPj4+ICAJcGdvZmZfdCBwZ19zdGFydDsNCj4+PiAgCXBnb2ZmX3QgcGdfZW5kOw0KPj4+ICAN
Cj4+PiArCWlmIChub2RlaWQgPT0gRlVTRV9JTlZBTF9BTExfSU5PREVTKQ0KPj4+ICsJCXJldHVy
biBmdXNlX3JldmVyc2VfaW52YWxfYWxsKGZjKTsNCj4+PiArDQo+Pj4gIAlpbm9kZSA9IGZ1c2Vf
aWxvb2t1cChmYywgbm9kZWlkLCBOVUxMKTsNCj4+PiAgCWlmICghaW5vZGUpDQo+Pj4gIAkJcmV0
dXJuIC1FTk9FTlQ7DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9mdXNlLmgg
Yi9pbmNsdWRlL3VhcGkvbGludXgvZnVzZS5oDQo+Pj4gaW5kZXggNWUwZWI0MWQ5NjdlLi5lNTg1
MmI2M2Y5OWYgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2Z1c2UuaA0KPj4+
ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9mdXNlLmgNCj4+PiBAQCAtNjY5LDYgKzY2OSw5IEBA
IGVudW0gZnVzZV9ub3RpZnlfY29kZSB7DQo+Pj4gIAlGVVNFX05PVElGWV9DT0RFX01BWCwNCj4+
PiAgfTsNCj4+PiAgDQo+Pj4gKy8qIFRoZSBub2RlaWQgdG8gcmVxdWVzdCB0byBpbnZhbGlkYXRl
IGFsbCBpbm9kZXMgKi8NCj4+PiArI2RlZmluZSBGVVNFX0lOVkFMX0FMTF9JTk9ERVMgMA0KPj4+
ICsNCj4+PiAgLyogVGhlIHJlYWQgYnVmZmVyIGlzIHJlcXVpcmVkIHRvIGJlIGF0IGxlYXN0IDhr
LCBidXQgbWF5IGJlIG11Y2ggbGFyZ2VyICovDQo+Pj4gICNkZWZpbmUgRlVTRV9NSU5fUkVBRF9C
VUZGRVIgODE5Mg0KPj4+ICANCj4+DQo+Pg0KPj4gSSB0aGluayB0aGlzIHZlcnNpb24gbWlnaHQg
ZW5kIHVwIGluIA0KPj4NCj4+IHN0YXRpYyB2b2lkIGZ1c2VfZXZpY3RfaW5vZGUoc3RydWN0IGlu
b2RlICppbm9kZSkNCj4+IHsNCj4+IAlzdHJ1Y3QgZnVzZV9pbm9kZSAqZmkgPSBnZXRfZnVzZV9p
bm9kZShpbm9kZSk7DQo+Pg0KPj4gCS8qIFdpbGwgd3JpdGUgaW5vZGUgb24gY2xvc2UvbXVubWFw
IGFuZCBpbiBhbGwgb3RoZXIgZGlydGllcnMgKi8NCj4+IAlXQVJOX09OKGlub2RlLT5pX3N0YXRl
ICYgSV9ESVJUWV9JTk9ERSk7DQo+Pg0KPj4NCj4+IGlmIHRoZSBmdXNlIGNvbm5lY3Rpb24gaGFz
IHdyaXRlYmFjayBjYWNoZSBlbmFibGVkLg0KPj4NCj4+DQo+PiBXaXRob3V0IGhhdmluZyBpdCB0
ZXN0ZWQsIHJlcHJvZHVjZXIgd291bGQgcHJvYmFibHkgYmUgdG8gcnVuDQo+PiBzb21ldGhpbmcg
bGlrZSBwYXNzdGhyb3VnaF9ocCAod2l0aG91dCAtLWRpcmVjdC1pbyksIG9wZW5pbmcNCj4+IGFu
ZCB3cml0aW5nIHRvIGEgZmlsZSBhbmQgdGhlbiBzZW5kaW5nIEZVU0VfSU5WQUxfQUxMX0lOT0RF
Uy4NCj4gDQo+IFRoYW5rcywgQmVybmQuICBTbyBmYXIgSSBjb3VsZG4ndCB0cmlnZ2VyIHRoaXMg
d2FybmluZy4gIEJ1dCBJIGp1c3QgZm91bmQNCj4gdGhhdCB0aGVyZSdzIGEgc3R1cGlkIGJ1ZyBp
biB0aGUgY29kZTogYSBtaXNzaW5nIGlwdXQoKSBhZnRlciBkb2luZyB0aGUNCj4gZnVzZV9pbG9v
a3VwKCkuDQo+IA0KPiBJJ2xsIHNwZW5kIHNvbWUgbW9yZSB0aW1lIHRyeWluZyB0byB1bmRlcnN0
YW5kIGhvdyAob3IgaWYpIHRoZSB3YXJuaW5nIHlvdQ0KPiBtZW50aW9uZWQgY2FuIHRyaWdnZXJl
ZCBiZWZvcmUgc2VuZGluZyBhIG5ldyByZXZpc2lvbi4NCj4gDQoNCk1heWJlIEknbSB3cm9uZywg
YnV0IGl0IGNhbGxzIA0KDQogICBpbnZhbGlkYXRlX2lub2RlcygpDQogICAgICBkaXNwb3NlX2xp
c3QoKQ0KICAgICAgICBldmljdChpbm9kZSkNCiAgICAgICAgICAgZnVzZV9ldmljdF9pbm9kZSgp
DQoNCmFuZCBpZiBhdCB0aGUgc2FtZSB0aW1lIHNvbWV0aGluZyB3cml0ZXMgdG8gaW5vZGUgcGFn
ZSBjYWNoZSwgdGhlDQp3YXJuaW5nIHdvdWxkIGJlIHRyaWdnZXJlZD8gDQpUaGVyZSBhcmUgc29t
ZSBjb25kaXRpb25zIGluIGV2aWN0LCBsaWtlIGlub2RlX3dhaXRfZm9yX3dyaXRlYmFjaygpDQp0
aGF0IG1pZ2h0IHByb3RlY3QgdXMsIGJ1dCB3aGF0IGlzIGlmIGl0IHdhaXRlZCBhbmQgdGhlbiBq
dXN0DQppbiB0aGUgcmlnaHQgdGltZSB0aGUgYW5vdGhlciB3cml0ZSBjb21lcyBhbmQgZGlydGll
cyB0aGUgaW5vZGUNCmFnYWluPw0KDQoNClRoYW5rcywNCkJlcm5kDQogDQo=

