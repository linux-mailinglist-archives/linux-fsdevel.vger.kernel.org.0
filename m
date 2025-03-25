Return-Path: <linux-fsdevel+bounces-45051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBFEA70C69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 22:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791E6175085
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547A26980C;
	Tue, 25 Mar 2025 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="1CxLOuYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1603267B9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939652; cv=fail; b=kZYWvkuSY+CZS4gxA57kjUBtyZvdDJGqYy7DyaHpZ1v0k+HDzSmh4Gn7HFE7LSQqGBjKrjeeI7BZUXoVzcguk5extHKN2i+Vds1+BmuOM8z3NgDxLYjYndUv0IvYafXwgEh7qb6lkhSLjNtXWuqaCTQpkXXS4E5XMale35ju2Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939652; c=relaxed/simple;
	bh=nml0YEknrU2y9WrZZpYSmyIujMMoFOf3ppMM92OJleg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dpwv17AeU8SP8D6mN0ZmAaqHuhI10AO8kwlk6Xckk753aLvMgiu8d5yNWXDAC5TEjIsJv7tZPBUmPQkuFaLUJVwH+5S5R4r37rBpTd7qsFBRGmxDWwRRG+uoZtTMJZ6U0fXO2d/BJzR8kjIivxcZRIYIE8T9BLPtbnRiR7HPlcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=1CxLOuYd; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46]) by mx-outbound23-22.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 25 Mar 2025 21:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGmwc7OJ32CIpSvty8tXigN32VnIZMOHQ8DXjN87WhANHaBD6QQ7G12hAfHuylf15jJMVF33CsMVC7cGf+28v0l9tO54ipesu3ANVrf1gX07kCvXpDPqnihp9WeP0OgJZ9tURknDD3oyNRT8k5tAO9yjCTOpi0kN25udOp6GiyJqDIxfXadDNvL5+FSzLfslXEXqUGg4qz8Oc9lMnYUAzxSCD6y8DeX0u/6Np9gCnmx8l3D+sHCTMkNsf1cbmP3vBK5CWfnSOV4FstxMjBwJpQk/Ug2rH9klB+oy4Yy2XU+PAhyMcLDWgyyizSRiUnBJUrbz+hYz64RMMrSf1JKMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nml0YEknrU2y9WrZZpYSmyIujMMoFOf3ppMM92OJleg=;
 b=DK9UV0NCTrzTs2IZYrytHl/ey4A5YfpnfIMq7HICtNfVItnGNcFVZdTyzLG3W9oNxfTkkHrtIajyZB+jMv9fhkV7SlGTzHMXXgseYffHzPEW9FCxqdEn/50+rcC4HRWZgtFd9sbf7m535MyZf0T+UgfglCuAtD4kMtw2Xt1wet23IEt4uI9yna8402GyeRgJaS2Ihs+paBJh6PckadE57BcCAahdktZoyXDDllASqdldeFtLpPoVOLWN1O9UHhqmk3bDe7ULctWp2F1rD3Y9e3qIkl/TmY2/Sg4Ob6GD2LMOtnK76w3swY9r4W05ukxqFP1CLf4Q+PSl42sT2Qcxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nml0YEknrU2y9WrZZpYSmyIujMMoFOf3ppMM92OJleg=;
 b=1CxLOuYdqwB4H/XJWp0DUbtujvk344I+yMQazQAS8Sgg4KgRPNUoEkJe+yAms8cKXz3fXGzrHISRW5MoxP8kQQQuTYC9PuJxDZU6pApLiaUAZMfldcHLf1N1vyxuY2Fsrwet+3BmXZjNP6A0/2RzmEEXgbilBkKcjJioxWjKDg4=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CY8PR19MB6939.namprd19.prod.outlook.com (2603:10b6:930:60::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 21:53:39 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 21:53:39 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH v2] fuse: {io-uring} Fix a possible req cancellation race
Thread-Topic: [PATCH v2] fuse: {io-uring} Fix a possible req cancellation race
Thread-Index: AQHbnat+CS38rN0kUkaAU4oT7DFW+rOEYTs+gAAEKAA=
Date: Tue, 25 Mar 2025 21:53:39 +0000
Message-ID: <01d4007d-4f25-4014-b8a0-a59cf6d17aeb@ddn.com>
References: <20250325-fr_pending-race-v2-1-487945a6c197@ddn.com>
 <87pli4u6xy.fsf@igalia.com>
In-Reply-To: <87pli4u6xy.fsf@igalia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|CY8PR19MB6939:EE_
x-ms-office365-filtering-correlation-id: 3c5ee526-62d0-4400-aef1-08dd6be7807a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zy9LY0tjSXBMcjhWbVFYelVOSm02dE1vZDVpNkNORVduWVdueUdWZTArUXZN?=
 =?utf-8?B?WlBTQXY1RkY3MlllWHRoN1B6b3I0WEluTmFUNFNJT2JhRVJ1UjdWZmZXaXUv?=
 =?utf-8?B?bzZESWVYQUgxbEQxZk5QZ1ppMkNjMDh2aC9iSlZReWpEUnVUSXliUFhSd043?=
 =?utf-8?B?TUJidEhZWWJmUjlYNkd3cmtYYVNQc3FSek5oOGhWV1RjdG95c1hpRU1BYWZT?=
 =?utf-8?B?eFhoK2pMbGFBdXBVancvd1l3ZklnLzIrSGZsNW9KY0hDQVBxOEdRa1kwOHpx?=
 =?utf-8?B?U0wvYzhSYzdmczNpTkk2UkJ6Z1dRQytaTHQvbHd6RGRja2hRV3ZiRTIxM2Jr?=
 =?utf-8?B?aDJGYm56VnBrb2FPSW0yaXRXbER5Y1BWd0YxUkF2VVNua21DZUxSWG1CRUwx?=
 =?utf-8?B?bHhWZm1iVEJjUmc2QTkzVzQ5SUdkQ0NmbVZnSU1HN1hQbEtTdWlweUJ2TWs0?=
 =?utf-8?B?WWJrY3FGa3cwL2grQTAvMmwrMmpWVGNhSWovMmkzOHFWWTZkQ3A2UVRBeGp2?=
 =?utf-8?B?UlNHL1I1OHR6cXJkY2ttVGJQTFZlMTl2Z0dWN2daN3VRcUtXZXNJdDVnS3pz?=
 =?utf-8?B?bWszOGhYK2FuK3dzMFJ4VnhnbktwTmpDUmU3eGMvT2IwY2FYeTVnUGd2eE1y?=
 =?utf-8?B?d1NwenN6blp0ZGZJUWFObW95U1lGWEtjVEFUVDU5bVM0amdSeVpYNkdKUW05?=
 =?utf-8?B?aWl1SHc1bk80RFpwYXl4RmlqQ2JnMGljdmw0SVFZSW9KV1p4RnZxbFFxSCs4?=
 =?utf-8?B?NU1rZkRnTnV2VFV1c0FQTE85ZFd5WmJhMUl0K29yTldFSmF6L2dXYUgrOFdz?=
 =?utf-8?B?eWxIbm02Q2l6b0czMzVCQ1ZTRlEyZkN6UWJZNFlGdVRrbG5YUnB4R0RZaC9x?=
 =?utf-8?B?WXlhWE9yc3Fwdm0wUDlLRUdFTitmdVVYNXlzV2cyUkxZZ29rSUY0dUhtdGpS?=
 =?utf-8?B?bU5wUGZmcWNQMzNJeVlmSFhkMlJ0WTh1RlJKR2ZndmkvQkFIOWtsUlFKMEhu?=
 =?utf-8?B?ZlhPVkt5ZXBEQm5IMVZ1SFd5QW9SZHFuNkt6am1Yc1ZLYVNKME9DNDVoZU9u?=
 =?utf-8?B?QXRTZUc2a3dwcE9MOFVodnppU0M0L2w5djByMnQzTVVONXBQVDBMbTNIRDNr?=
 =?utf-8?B?UDY1MExuaGI4SW1vSFRBZXN4ckJldUdSNStQdXB4NjhpcngvR25vVUxuczJE?=
 =?utf-8?B?VkVjTGxyYUNBZFRkbFp1Uzd5bzJibUxoWGFhQ0MzRi9iQ3FwNGJlSEIwZytH?=
 =?utf-8?B?bHVGM2lrbUdzTEVoQ20rSTl2cCtjL2wvaHMxVTkyUnQvK3hvNnJGWUxYdnhT?=
 =?utf-8?B?V2FDYmJTeXdDTWhJVFhIalNOUm1WeCtMSzYxZWEyYW1LbXRLNUlsQTdodFJX?=
 =?utf-8?B?SnBnNUVTWGt0MGl1T0c4TnRHd0F5YzhDS05hdnNFOVZxR2FXazhIL2NRNGZo?=
 =?utf-8?B?dWk3Tlk0M3kzQkl5TnVyZzVHTytHankwRU5mdys3VlN2d3grcyt1c3VlWnIv?=
 =?utf-8?B?ZTNMOFJxL2pGZllpTWZxQ2lZU3IwbS9EaUE0OWtHMGx5b0dLQmJDa2pvSm9L?=
 =?utf-8?B?QndBQ1FXQiszc3haaEd0Ym9mRkhZb2crUm9CUGh3WnZHckNJSzhCaFZhQ1hX?=
 =?utf-8?B?WTN6bGd4SGtUaWh6ay83ekQ0TlVmajBPOTdHUng0VnBrSS9QNUVNTmlBZ2tT?=
 =?utf-8?B?aFVVekJubmlRVGxSOXhYVkJyK1BZMHlWTEFhamZWdXd3cVVPYnZTaEdleC9T?=
 =?utf-8?B?TUxPR2lxYkRYYVBWSnRWQVRuajZPRDVJcm0wWjJ4d215M005TUZycUlJNmtQ?=
 =?utf-8?B?dm1Rc21KanhYOFIvVWdibkc0aGtVYWxsbWROakRkUHc2YThBSFVyOWMzaGdD?=
 =?utf-8?B?Uk14cVFEd3JpVUVwYTBISTJIVVo3b1V6b0pid1AvNEVsRjh1QlVGbldJc2JY?=
 =?utf-8?Q?Rszvmu+OkNn7IVgTwUrP31zwvzQ8rrC1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnRKQldHZXp0a1FpR01hY1J0VDV0ZXZ6T3JxZm5oYmVZeHFPMXQ4YlZHVU9w?=
 =?utf-8?B?WHFNamI0WVNabS9WdWsrMUIwMWhLMGpUVDRuZEYvU3dUV2YvaTJEMEgyWWlX?=
 =?utf-8?B?MUdoclZiQlRNbnVEM0VGM20xV1M3cld2bk5URUdIaFh1N21zZ1hFR2ZlUFBU?=
 =?utf-8?B?eTk0TGQ5WW5qWkJkZzF6REZmM0ltNTNERnlIKzgrUFRHNW82Q2pmQitqK2w2?=
 =?utf-8?B?TFVoZklPUm1nRWdoR2dSUS9OUU5xUHF6bTNralRmdzIzV0t3SGJvaHM0N0Ja?=
 =?utf-8?B?ZGRjV2ZJQUFYd0NOQ2FvKzAzR1NndS93UGZlblgrbEtLb0FBdCtZOE5rQzN2?=
 =?utf-8?B?YlpRSTNzdTVtRXk4dFNndFZMa2RWbnBtcVpVRzFOSHNNc24yeVB3dVdhcVRZ?=
 =?utf-8?B?cDJaMVhtWnBaZDVZRVQramJOTWpoY3huRXBzaktMNGs4Q3FqMENmZTU0MVpn?=
 =?utf-8?B?T2J0d2hHNWJxd1BsV2RzYWkrM3NsOXcrT2xNc25nbFhqeGJ6YXJLWUxwTXN5?=
 =?utf-8?B?aU9CRzNVdWRLc2V4aWZSSXFpdUo0WVkreXNvVUlmeTRFZFNTUS9UYnlVajB4?=
 =?utf-8?B?cmlNWEQrZDRnTWZQN3dRSDZaL1RJZ0NJeVpidFdDYWxNaVJuNkY0S1NGVE9h?=
 =?utf-8?B?bkd6ZEMvaUVvV3JrRDcvbk5xS0tKUjZnSVNobDJkVS9sMTIxMVBWNVpGWWFH?=
 =?utf-8?B?UG4rSW93WW1mb2pNQjN5U3JLODR5WmJMTy8yeTh5Yi9wOEtJZlJWYVJtbzFQ?=
 =?utf-8?B?R24rdXNoQmF5cGRLSlpQeGQzZmdweDZSdkpBR25ZcXphSE1RdXoyS2wvczk2?=
 =?utf-8?B?RzBTR1p6RW1WR2ZaR2o1MWEyaXJvN2U5S2ZkZHI1THczREQxNlRtbHg0NlVT?=
 =?utf-8?B?ZW42QkVDQzNkcmtrVGl5cXprQkxjRVQzVitaOGxwUnNPbDZUOTZGOWpFMnpr?=
 =?utf-8?B?ZE1OZGYvbzJuUVRCNlRvbmwvaVFpa0ovL0IvWHVSVW9VTldvWUFsTXFNZ3Mr?=
 =?utf-8?B?cEZPSEtCQ2JmTUQ2RHlvUmx0OG1SaXBRN1BMUVZsdk8zOXVZSXlxQTIvODk0?=
 =?utf-8?B?SklFUUNza1AvU0tXbFpmSHV4djdRYXFwTmY1ei9SZlVFUiszK0hpaVhySjVr?=
 =?utf-8?B?bUhYRlJmVGxTWFNnby8xMDBYeHUrbk5BbFNvLzhtTThZc3N2WUwwc3IxUitm?=
 =?utf-8?B?YjVXaG9OeGZ2TWYrd1BETEc1M1VWWUlYU1RCNnYwZTlUK1J4YWlHd2d2S2Rp?=
 =?utf-8?B?dDhzK1lIL0xUVXFJb2ZUOTFzTlY5Rmo4eE1Cb2JlcDZlQTlQbjhNdEpIVk05?=
 =?utf-8?B?N2E1M2xHWDFrR213SndyYmE5Tm82OWhpREkvVUNTT1c3eXE3OE1BZy9FWFo0?=
 =?utf-8?B?dVdGR2p3dHVBSXJQVVZ0eVF4dnpTcXRZR0syU0NaK1NzbkgwRVRESG9KV3lN?=
 =?utf-8?B?NUxiUFNVU3lMejVlcnBzTlVxNzBESTNXeHllejE0RVpuVDJOdFpxc3RNQ2V1?=
 =?utf-8?B?d0xZZW90MDF3K3RPMkpxdnI3bE11YnVKSERwSEVuQTh4YWRnMUVSQWxOaU9m?=
 =?utf-8?B?R2w0ODh5VEtKWEJiYkRBZHg5V3B5cXlmRXl2Q01uMEk4Y1d2RFBmL1ppc3Qy?=
 =?utf-8?B?dVFLdHcyQ0REeFUzSEtweVRySWJEQVJKU25Ubm5naFpJMUlWaDI4a3NPdENS?=
 =?utf-8?B?U2ZXMmlWblRoU05sL0FGRXl2dEdIaDIyMzdNcEUvRHdESzh2Z2xaSEVvNFRo?=
 =?utf-8?B?OEg4cHNFUFAwNkprV0JqSWc1eVJRV25kdW5pUGRnQjdBVnQ3Ymw1MWVDMzN1?=
 =?utf-8?B?amhPNkUzOHNPN2RhSmNnMEJUWEROMzFIV3BacklySHd5SUhkUko2N3dzMzVW?=
 =?utf-8?B?VG5BaDI2Y21XUVIyc1BHemR1ZWJCNlJDLzBYbEFtMXRoWnRXL0pyOTFxNWxr?=
 =?utf-8?B?RTN2Q1RUT0Z4YlRpV2diUVRlTVR4R1pDSFhJVWRhc1d0Z0M4R3cxQVI2MEt3?=
 =?utf-8?B?ZEFUUFpqbzc0amhORVB0TFJOMS9MRmJBWkRpa01yVXZZbVkyT0Y0bmorci9B?=
 =?utf-8?B?bVF2VGRGSlJ3MmtIMDFwcGk4dy9qcEZCNDlmY2E4dDA5a2FzNFBrZ1NQekhQ?=
 =?utf-8?B?WkxRUWR4eWsxWkZHWERFbFZNekp5Z2tBMmJZUlJmL2MxR29qMDAyc284Y2Vp?=
 =?utf-8?Q?CfA5/ewzO7RCqnRBENIiG74=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3DB5404BCBF8248B317833A563515EB@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZXwNfxCHJcqu9FQxAYhXEMMJUCdlDiJN0d/dMm3S1c9LJJZUUhBkIFZ/A+Bo6C/w5tqSN1Hd1BOo2gE3s5FfMnd2WOUT4jtyvvw+Gj6ErYdxaLMnaHgkhsJjcNalhUMHCaRX+/bszdOekMmsWfTIT4ZSBX5Q+w3uFpYymCuTNyu7IHjx96hYk/yy1GYeSZKRyrPIlbQbJsZxcuB7nTvJSNm5uUVAqXjC8irrNj8HSR//K8l52Js8KwzZVvdfDgYXKhbzZ2h8cp3AtpMMPR7zs8fbgSQH3nZD9HF+UutqGAiwfUWM0m/gEvsZiwYNyQ8ViJaxqj7btjECvrTbAy/HX4lt1p/NKR/EFvZBzzAxfaosaF+E/INROTUpR+h8/n5/ZesGLLIW5Znj89idYru5cGL5LngXZBuJWDDXJEjja1gmF1uY6DnqhmSUgyFSK0Jenf5KnMbK+DKdvU5jvQHW6slbrLBDr3lzdg8/rjgr4qbhrRbsPGAiWYs1tsmnG933YsFvOhHHM7YWvpQJVO/rKc0VFOmVj+Kba6ZrAy1rGcj7hGropegnmV6d4XZYw6d4zyE65olSnCrhBrBubtivnfY8Ifm9KnB2obADoPAPgUJu+XreOyoTcfm5EC3wvCXpefHYkyyeGAOIUb1EfaX5Rw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5ee526-62d0-4400-aef1-08dd6be7807a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 21:53:39.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfLBMsF/R9Q3V3D5mACiXBLLcWkSfISOtsny7Z2TVVHlMaaWs3wVSgiAzShlgq3hGCJ+vBjO+ddThrhrKcirMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB6939
X-BESS-ID: 1742939622-105910-21859-16488-1
X-BESS-VER: 2019.1_20250319.1753
X-BESS-Apparent-Source-IP: 104.47.66.46
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZGBuZAVgZQ0CDR2CDN1NTYIs
	3M0tjQJMk0ydAiJSk5zdw0LdUgMSVFqTYWAIf3oVlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263417 [from 
	cloudscan11-88.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMy8yNS8yNSAyMjozOCwgTHVpcyBIZW5yaXF1ZXMgd3JvdGU6DQo+IEhpIEJlcm5kIQ0KPiAN
Cj4gT24gVHVlLCBNYXIgMjUgMjAyNSwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+IA0KPj4gdGFz
ay1BIChhcHBsaWNhdGlvbikgbWlnaHQgYmUgaW4gcmVxdWVzdF93YWl0X2Fuc3dlciBhbmQNCj4+
IHRyeSB0byByZW1vdmUgdGhlIHJlcXVlc3Qgd2hlbiBpdCBoYXMgRlJfUEVORElORyBzZXQuDQo+
Pg0KPj4gdGFzay1CIChhIGZ1c2Utc2VydmVyIGlvLXVyaW5nIHRhc2spIG1pZ2h0IGhhbmRsZSB0
aGlzDQo+PiByZXF1ZXN0IHdpdGggRlVTRV9JT19VUklOR19DTURfQ09NTUlUX0FORF9GRVRDSCwg
d2hlbg0KPj4gZmV0Y2hpbmcgdGhlIG5leHQgcmVxdWVzdCBhbmQgYWNjZXNzZWQgdGhlIHJlcSBm
cm9tDQo+PiB0aGUgcGVuZGluZyBsaXN0IGluIGZ1c2VfdXJpbmdfZW50X2Fzc2lnbl9yZXEoKS4N
Cj4+IFRoYXQgY29kZSBwYXRoIHdhcyBub3QgcHJvdGVjdGVkIGJ5IGZpcS0+bG9jayBhbmQgc28N
Cj4+IG1pZ2h0IHJhY2Ugd2l0aCB0YXNrLUEuDQo+Pg0KPj4gRm9yIHNjYWxpbmcgcmVhc29ucyB3
ZSBiZXR0ZXIgZG9uJ3QgdXNlIGZpcS0+bG9jaywgYnV0DQo+PiBhZGQgYSBoYW5kbGVyIHRvIHJl
bW92ZSBjYW5jZWxlZCByZXF1ZXN0cyBmcm9tIHRoZSBxdWV1ZS4NCj4+DQo+PiBUaGlzIGFsc28g
cmVtb3ZlcyB1c2FnZSBvZiBmaXEtPmxvY2sgZnJvbQ0KPj4gZnVzZV91cmluZ19hZGRfcmVxX3Rv
X3JpbmdfZW50KCkgYWx0b2dldGhlciwgYXMgaXQgd2FzDQo+PiB0aGVyZSBqdXN0IHRvIHByb3Rl
Y3QgYWdhaW5zdCB0aGlzIHJhY2UgYW5kIGluY29tcGxldGUuDQo+Pg0KPj4gQWxzbyBhZGRlZCBp
cyBhIGNvbW1lbnQgd2h5IEZSX1BFTkRJTkcgaXMgbm90IGNsZWFyZWQuDQoNCkhpIEx1aXMsDQoN
CnRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCj4gDQo+IEF0IGZpcnN0LCB0aGlzIHBhdGNoIGxv
b2tlZCBPSyB0byBtZS4gIEhvd2V2ZXIsIGFmdGVyIGxvb2tpbmcgY2xvc2VyLCBJJ20NCj4gbm90
IHN1cmUgaWYgdGhpcyBkb2Vzbid0IGJyZWFrIGZ1c2VfYWJvcnRfY29ubigpLiAgQmVjYXVzZSB0
aGF0IGZ1bmN0aW9uDQo+IGFzc3VtZXMgaXQgaXMgc2FmZSB0byB3YWxrIHRocm91Z2ggYWxsIHRo
ZSByZXF1ZXN0cyB1c2luZyBmaXEtPmxvY2ssIGl0DQo+IGNvdWxkIHJhY2UgYWdhaW5zdCBmdXNl
X3VyaW5nX3JlbW92ZV9wZW5kaW5nX3JlcSgpLCB3aGljaCB1c2VzIHF1ZXVlLT5sb2NrDQo+IGlu
c3RlYWQuICBBbSBJIG1pc3Npbmcgc29tZXRoaW5nIChxdWl0ZSBsaWtlbHkhKSwgb3IgZG9lcyBm
dXNlX2Fib3J0X2Nvbm4oKQ0KPiBhbHNvIG5lZWRzIHRvIGJlIG1vZGlmaWVkPw0KDQpJIGRvbid0
IHRoaW5rIHRoZXJlIGlzIGFuIGlzc3VlIHdpdGggYWJvcnQNCg0KZnVzZV9hYm9ydF9jb25uKCkN
CiAgIHNwaW5fbG9jaygmZmlxLT5sb2NrKTsNCiAgIGxpc3RfZm9yX2VhY2hfZW50cnkocmVxLCAm
ZmlxLT5wZW5kaW5nLCBsaXN0KQ0KICAgLi4uDQogICBzcGluX3VubG9jaygmZmlxLT5sb2NrKTsN
Cg0KICAgLi4uDQoNCiAgIGZ1c2VfdXJpbmdfYWJvcnQoZmMpOw0KDQpJdGVyYXRpbmcgZmlxLT5w
ZW5kaW5nIHdpbGwgbm90IGhhbmRsZSBhbnkgdXJpbmcgcmVxdWVzdCwgYXMgdGhlc2UgYXJlDQpp
biBwZXIgcXVldWUgbGlzdHMuIFRoZSBwZXIgdXJpbmcgcXVldWVzIGFyZSB0aGVuIGhhbmRsZWQg
aW4NCmZ1c2VfdXJpbmdfYWJvcnQoKS4NCg0KSS5lLiBJIGRvbid0IHRoaW5rIHRoaXMgY29tbWl0
IGNoYW5nZXMgYW55dGhpbmcgZm9yIGFib3J0Lg0KDQoNCg0KPiANCj4gWyBBbm90aGVyIHNjZW5h
cmlvIHRoYXQgaXMgbm90IHByb2JsZW1hdGljLCBidXQgdGhhdCBjb3VsZCBiZWNvbWUgbWVzc3kg
aW4NCj4gICB0aGUgZnV0dXJlIGlzIGlmIHdlIHdhbnQgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBG
VVNFX05PVElGWV9SRVNFTkQNCj4gICBvcGVyYXRpb24gdGhyb3VnaCB1cmluZy4gIE9idmlvdXNs
eSwgdGhhdCdzIG5vdCBhbiBpc3N1ZSByaWdodCBub3csIGJ1dA0KPiAgIHRoaXMgcGF0Y2ggcHJv
YmFibHkgd2lsbCBtYWtlIGl0IGhhcmRlciB0byBhZGQgdGhhdCBzdXBwb3J0LiBdDQoNCk9oIHll
YWgsIHRoaXMgbmVlZHMgdG8gYmUgZml4ZWQuIFRob3VnaCBJIGRvbid0IHRoaW5rIHRoYXQgdGhp
cyBwYXRjaA0KY2hhbmdlcyBtdWNoLiBXZSBuZWVkIHRvIGl0ZXJhdGUgdGhyb3VnaCB0aGUgcGVy
IGZwcSBhbmQgYXBwbHkgdGhlDQpzYW1lIGxvZ2ljPw0KDQoNClRoYW5rcywNCkJlcm5kDQo=

