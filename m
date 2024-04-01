Return-Path: <linux-fsdevel+bounces-15843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9E8945FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 22:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5322E1F230C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101E53E1B;
	Mon,  1 Apr 2024 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="XUPY+Qwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66D47A53;
	Mon,  1 Apr 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003327; cv=fail; b=H7V89Fq3Iw0WVO8XYxmtPpsynK+aNjAZ4SjYGWTY5sb27xyBSa5ZeKF68CQsFMz3VirNAaIh8nWIqI/UzZ43NAiurYK0ci7XIyTpCK7hkX92LwZEfnHtDSZdUtZmWXWCZ12Jj2XMZkjNGlf2x1Iji8RETn6Ta3mSoV7TCbtBTXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003327; c=relaxed/simple;
	bh=WTwboFga6Y/xRoLt8ARDQnkpcDyBGO4888VaL28zywM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JHaRnw9sZGKfmh31LtzJLk0crVpT3Qe3rqSY9GjyQUSdRGVY1QKryxSE8oCecAN4flajbvAGvj2oHwqVUTHiriN7TjrfQ92giEZIyjKxAUI7lRFOMc8LHvmiN2t7Xk6/O8bX0OIvVLcdsJcdv5R+iJ2bEcFk04giCgHTZRbH93Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=XUPY+Qwl; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound14-247.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 01 Apr 2024 20:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJC/ObjWvNgn37vqdpnIv7ZginalqADbJt/iAF4GY+fv4xFqnhNrg/k2odUnanOEl88t65/mBiqDZqJ0ly/Iu3Ts+9tUHXb4tJiDLsWCjmXXQdpPsX1pOkpW0kTaVZwAp0twlsDYWsHDHL3PWFeFJOrR+7SHUqAi4CorzeTX7uTaP30wEfVeazRmUtENSPsSQfWLSMBGldC0GZYs8PsEyDJdA22HfKUqDg9XnIFAOmXHVzHzHAzhdFeWxjqH4dVf9fNjlcgKt3i8JvIJNdK65AOknBom9dAvPyGMxE3l9AM7rBOavz6VLx70/tmAuddSrpouDqKR7lObLGWgMm4H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTwboFga6Y/xRoLt8ARDQnkpcDyBGO4888VaL28zywM=;
 b=GqE56Gr07OeVj3QMVXKcMkYOmrpbh4QJ8nM1V/U+2AZP1T4anhrjDvxzN6tDbSsb4LTyXhRAWfsv19m9jmjySM36y1SHZn8ffjpfS9P+bUWADcM+zjSs+EfQbHCngpeRgzJBCjIEFwTz4sy1FC+g2kDPKG0BIDN1Rcp0Y5ka6+EOgy0JczD6hg0TGYgOpw9GCqXZgcjUHuJX6k596NnnCYxdBJEEWBdpkonx7fXWfQ1h6ssGawUhv35dBL2sezK16zw4FtOr6HvwEk4f3FZFcytXB+JmDlMrYPVaKGkj2MgyV4ZJp1VQqzOhIW4jhERZS2u8XHC1BEC4g9BH9U888Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTwboFga6Y/xRoLt8ARDQnkpcDyBGO4888VaL28zywM=;
 b=XUPY+QwlNSTSLWc1TMHSEv2ymcjo3z4dtm63H8bslLAi/UBbr/YmM5MYqE92QmCBLzXDqlJCuR1CTtt0UdOrJ2K4GyhzhtvwbUJ8GoeNChYavSXYUpwTI62Vigmhyktwu/78DQBZojkdxqKvx7Mevq31EQ8IJwz1hyk1M8VRwyM=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM6PR19MB4261.namprd19.prod.outlook.com (2603:10b6:5:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 20:27:55 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::56da:efcb:e6c4:8ef]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::56da:efcb:e6c4:8ef%7]) with mapi id 15.20.7409.038; Mon, 1 Apr 2024
 20:27:55 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Amir Goldstein <amir73il@gmail.com>, Daniel Rosenberg <drosen@google.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko
	<mykolal@fb.com>, Christian Brauner <brauner@kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [RFC PATCH v4 00/36] Fuse-BPF and plans on merging with Fuse
 Passthrough
Thread-Topic: [RFC PATCH v4 00/36] Fuse-BPF and plans on merging with Fuse
 Passthrough
Thread-Index: AQHagaSmPDWp/jRQbUmYhZCU2Zu3srFPd8EAgAQK4ACAAGA7gA==
Date: Mon, 1 Apr 2024 20:27:55 +0000
Message-ID: <bdf73614-0f74-4cb1-be2f-a2786e1f1850@ddn.com>
References: <20240329015351.624249-1-drosen@google.com>
 <CAOQ4uxhLPw9AKBWmUcom3RUrsov0q39tiNhh2Mw7qJbwKr1yRQ@mail.gmail.com>
 <CA+PiJmQR17nwkHaZXUhw=YRM06TfF14bhozc=nM9cw51aiiB6g@mail.gmail.com>
 <CAOQ4uxiyS9viEpOwT8f2Np=wuMdWwUqqyHFRrBX9+Acy_i3OHw@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxiyS9viEpOwT8f2Np=wuMdWwUqqyHFRrBX9+Acy_i3OHw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DM6PR19MB4261:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wgOIfsE1f6+EQhFJEvxd6S/RevA8QEHAqYLW4VnkUBCtrUeeUt8d2mZO2UpkSx8fJCxrH9CP6rjkk11+JAmYTyCGfa+F+AsLauJ4e94Md1sRiQjiUSZn0iGtqkWV6DHvW5mO08IlJeDy3bsQpsSDns6lltvhOOWraFEG/GLi3LDvTz4jk1iNTIoeWLxbM6J/zUZOLB3X2Q0x3VQRZEYLQkNNyWvkKAvxBa1NZUlRaW3RY3uuZ/bXogsnSzdp2SUJZcIkEyQ+FP7phAp0XDO+TO+9hvwM8Q4pCxhK9ScCTF0h4spmH/JZ84GcVqrgQ5MS09kRaEgjKATKn2nTysLSzFohrnWTs6LtVsK4bqTxLCJRwHeqGKMeEFaDevYMCNvJsqTPQW22Bb5TiaOTBvhxf/8EhZfc+ng02U47VFUq6lby8qmL8hL93csQSh5VJ//o9STv7dQCRK04mmt4iKfG+utyE1LLh9J0FKz0MSnsGLOmd+MowZDs5FpbNcVPyuwzsJbArjFkwzEwxQVzD6ux3b1QhORzbEAAXQ5uWSvIjmtfBtfcQ4r+YvpDLc9NoiBRsKlWSVTi5L3h4j2e2HtEEPzP/L98grzEcS16jM/zAMQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THN3QXV6aDNSTDYzYUxCbTNtQXVESkM1SEVyTTJEY0tjQjkzSEN2TG81Nnhm?=
 =?utf-8?B?YUE0S1pqVzdkdEk0UnYwLzlCTjRWVFpiZjM5RXJxUzQ0eFBNYnkzNUxNU2wz?=
 =?utf-8?B?S2ZjUWdsSE1LbGd5eitzQjJ0YWt1eG9NNUY5VmljNm0vQmF3d2FjcHdreTRs?=
 =?utf-8?B?bGlXZWtGZDBIekE5bnF2TWkvRmZRSlkxUTJ0SEkxa0hzVEE0YldtZStrWEdG?=
 =?utf-8?B?YUY0dVI0aEpmc0grckFGL1JCd1ZxeUVzVW5BSm9QUUNFL0YzbHZ5bk1mQnF1?=
 =?utf-8?B?ZU5ZTWcyWDc4TXViNUJzZEtmOFI5TGNidFJ4dkVpWG52VWpwMFhEekNENjBk?=
 =?utf-8?B?VzBveTg4NUZCYXJOcWNieDJjNFFLN1dML2lkazcrVnZwUHRSWEtRZCtxcjBY?=
 =?utf-8?B?Znd5d2ZwcjJWRHlzSXd1eCtnYm9jeVg1VGtEWkpjV2hEWHI5dlArMVpmQlJq?=
 =?utf-8?B?VkRPRmxlQTJoMVdpd3dOSmd2WHNQZU9wN00wbkdXcUdQcjQ3RTNncVVTaTds?=
 =?utf-8?B?aFZhNWM1Q1NtZTRpemFYeTlTQzBseG9CZ3U0SVg1MHR3Q2pESVQ0b1htM2tY?=
 =?utf-8?B?NW9BZmQ0T29MVi96OUc2cnYzcWhGKy9PUWQ3cFJjSlVGWXo3YTFjSEcyaUJ3?=
 =?utf-8?B?d0o3YU5jYzZPcnJtdUh1QTFRVWVaTHg1bmc2YzVwNWtyTXFWdWw5Nm13UVpZ?=
 =?utf-8?B?RG1rYWh6TDNGalBIbmNwbGtjWDhKSlk4NGF5YVBwdXNjQnlmRnFYakRFTkhZ?=
 =?utf-8?B?djNoeEpqZUN2WGJDNEJwOElGaWwxL0srRnQ4L3UxT2VzT1IyajI2UkZnUEl1?=
 =?utf-8?B?UzYrOStnN0txejlLdkV6Mm9KU1llR1BVT1FXZFdmRk5RQ0RoNDI5SlNEU0pM?=
 =?utf-8?B?YWVqM2loZFBZN3ZDUlZ0bzlPYVVydngwaFhXc3MxQW96b2JyNnhyc2IxTGdk?=
 =?utf-8?B?dEZsTkhjWXE3UzJ1Sm96OWFKNmRuUU55VjMwWUl5eEk3TFVLYjZrb21CSFRW?=
 =?utf-8?B?VGVHb25zcVFmb0lsMEtQM2pqTkE5ZVdaT241L0FSMFZlZWkyc2tJQktGTzdQ?=
 =?utf-8?B?VDNudEoxRmQ1bkc1aFVHdzNNVlFIdUMzYW1BMmRrMGFtMEI5V29YelRlVGpF?=
 =?utf-8?B?Tk1BZVBMdTRlYmhZemZKQjkvNGZneWczRXdOZHlDUkFUNmNtMlJLNWcrMzdz?=
 =?utf-8?B?Q01EbExuMDNlZC9hb2dsd2FsMjBGYVRLM1RHRU5YWGU3ckhvcFBzTmtXWStW?=
 =?utf-8?B?VlF4L2E2NHBTQ0pBZjhvcnJSN0lDVjNWc1RZNHphc0RhZUJtcVNEK04rVURD?=
 =?utf-8?B?RGU0R25ETFFiYTRqOFBTeFFnVTNpTk16UEd3MHJmNk53SHJndzZBUWZkeUdR?=
 =?utf-8?B?RzFUSG5rVnVrWm5HZ1V3cDFhclkweU9EQzlEMjZUVlUzQ1JLb010WmF1aTZw?=
 =?utf-8?B?eVU1QkFuRjI4WDVFUFoyTkpyaVBrV2lENlFQdTJtVDJ4eHAwTU52aUsyUk52?=
 =?utf-8?B?c2dQOFBUZzgzV0dRbWxKSGdjR1o1N04rMFhQQlR5RVVNcWR6YjNNWk1ucEtz?=
 =?utf-8?B?SitKOUh4T0UrK2dPSzZ2ZC9OUzl0TFl4WmVhYjZuVHkyWFhteWtkYkp4Mno3?=
 =?utf-8?B?MzEwQmdlSExrNkswcE9NK1N3eWRPOUc2TTh3VjU2U0xlNW5IU3YwVU05WGpq?=
 =?utf-8?B?aGY3MkRaRGhYeEdibUpJem1haEsvRnNuSlZuaWg0MGpwNjZTdk5HaHBRbjZv?=
 =?utf-8?B?SkhDV1FIUVgvODUxWHVJTi9FWUUvQXNENEZXVGtmdTN5REZHWjRFd3FCTXVx?=
 =?utf-8?B?b1pnOXBuRWdsR092TnQ2QmdhblNqb3JDSzYyNG4rRHIvbUNPcG4yQi9oZ21H?=
 =?utf-8?B?a2ZSMTlrZFNXVnkyMFRoN3l0Qzc0MWV1YlI0Z0RVSUduZWNDcDhyMHRDVjBT?=
 =?utf-8?B?T2JwRDU2OGo1TXlGak9LUU5WUno1TTc2TnFlTGVvZDk3d3kyQmJaeElRN2h3?=
 =?utf-8?B?VW1Sb2ZvMy8zSnZFQzBFNVhjaWg4N3JRb252STQrZTR0MjF1eDRvUUxtNG96?=
 =?utf-8?B?cmJ5cTZQaVJJUitZS3FQemtiRlJWeWsyV3pmU2xyWGZxTkxmWFBDRi9qaUtu?=
 =?utf-8?B?akNHRmxlWnVkSFExenBqSTNIZjhwT1RJOCt4bXRaOXlKb3M5Z0Q1VFlFWk9S?=
 =?utf-8?Q?gjBB2tQGu54JGbU4t8ZT7VQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <361C2EF375635C4892C19513D232089A@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MZh4PWWvWtuZivvdKYhkSVtkfkKDBcjIBsacrzu/49nQAhvTM81x0SZOmDb2JFqldvUihP6+tqn7th7+jhaFw0IY9e3wxNo8jnd26aSTc81nis+CGjIkPXozbgJtzB9jPc3ZBNnx/4OK0pWbSAXOPcrmxIg/yZfrtUqlC5DI1OP1KtoIYmZQyQKra7wYAg9hfdCwNB5GyAg0BZALzaDk73/Kfemrdd4MpfyzNjkDRH0dnXMhYisYeujQKdUEENQ9qjZr8zLKFo7wAj62TVb0wYc+5SbihbaKPj8K/rsRpf+l5BTMTdC+9jAgx3ByRmjYd4CyytHlA+AtSrYs09LVfJ36556UmOuLu5NUphfytIS4lai+Br8i3bLApDUsxPSBzTXDSGiAhoiQ+Ix+kD3JzV2ExvNVRrm3ndq7QTWaIvoO1SKHWg5MZVjM6oKX564GPOT0zYQtCTXS6CAtWdkKC9+Ojh2ryEYXtNlvHtRMigCFWfpLnM6Y7jJ3DoAFWC6I6LoWVIX0+Mz2E44WHwZZGqJdxb1E+xwz874ilG1r2vkYloa7UKg2l2XO7wB3T0ETye1aFmB0nb/HU3p2n8rVRH0l/f0m2boNyvOjY6YkM06zYAqEPyr9pIPmI5whKN3jtaA4R6h3rDmQj6KWdXx/jQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02c97cc-f5b7-4f4a-0f6c-08dc528a3665
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 20:27:55.1271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/rM+rXy1nXRg4nkNSYSKL0VnrcHV954iChOYXGU/tUHao7Am73C8K1oAuQs+36WcYxetZOdCl0RJ+Nklh/0nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4261
X-BESS-ID: 1712003279-103831-12751-24136-1
X-BESS-VER: 2019.1_20240329.1832
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGxhZAVgZQMM3IIM0i1cAwLd
	EwxcQk1TLVwsTI2BDITzJOS01JSVWqjQUA1fC8ekEAAAA=
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255274 [from 
	cloudscan22-160.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNC8xLzI0IDE2OjQzLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gDQo+Pg0KPj4gQ2FuIHlv
dSBub3QgcmVhZC93cml0ZSB3aXRob3V0IGludGVyYWN0aW5nIHdpdGggdGhlIHNlcnZlcj8gT3Ig
ZG8geW91DQo+PiBtZWFuIEZPUEVOX0RJUkVDVF9JTyBzZW5kcyBzb21lIGZpbGUgb3BzIHRvIHRo
ZSBzZXJ2ZXIgZXZlbiBpbg0KPj4gcGFzc3Rocm91Z2ggbW9kZT8NCj4gDQo+IEZPUEVOX0RJUkVD
VF9JTyBzZW5kcyB3cml0ZSgpIGFuZCByZWFkKCkgdG8gdGhlIHNlcnZlciBldmVuIGluDQo+IHBh
c3N0aHJvdWdoIG1vZGUuDQo+IA0KPj4gQXQgdGhlIG1vbWVudCBJJ20gdGVtcHRlZCB0byBmb2xs
b3cgdGhlIHNhbWUNCj4+IG1lY2hhbmljcyBwYXNzdGhyb3VnaCBpcyB1c2luZy4gVGhlIG9ubHkg
ZXhjZXB0aW9uIHdvdWxkIGJlIHBvc3NpYmx5DQo+PiB0b3NzaW5nIGJhY2sgdG8gdGhlIHNlcnZl
ciwgd2hpY2ggSSBtZW50aW9uZWQgYWJvdmUuIFRoYXQnZCBvbmx5DQo+PiBoYXBwZW4gZm9yLCBz
YXksIHJlYWQsIGlmIHdlJ3JlIG5vdCB1bmRlciBGT1BFTl9ESVJFQ1RfSU8uIEkndmUgbm90DQo+
PiBsb29rZWQgdG9vIGNsb3NlbHkgYXQgRk9QRU5fRElSRUNUX0lPLiBJbiBGdXNlIGJwZiB3ZSBj
dXJyZW50bHkgaGF2ZQ0KPj4gYnBmIG1vZGUgdGFraW5nIHByaW9yaXR5LiBBcmUgdGhlcmUgYW55
IGVtYWlsIHRocmVhZHMgSSBzaG91bGQgbG9vayBhdA0KPj4gZm9yIG1vcmUgYmFja2dyb3VuZCB0
aGVyZT8NCj4gDQo+IE1heWJlIHRoaXMgcGF0Y2ggc2V0Og0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1mc2RldmVsLzIwMjQwMjA4MTcwNjAzLjIwNzg4NzEtMS1hbWlyNzNpbEBnbWFp
bC5jb20vDQo+IA0KPiBCZXJuZCBhbmQgSSB3b3JrZWQgb24gaXQgdG9nZXRoZXIgYXMgYSBwcmVy
ZXF1aXNpdGUgdG8gZnVzZSBwYXNzdGhyb3VnaC4NCj4gQmVucmQgaGFzIHNvbWUgZm9sbG93dXAg
ZGlyZWN0X2lvIHJlLWZhY3RvcmluZyBwYXRjaGVzLg0KDQoNClRoZXkgYXJlIGluIHRoaXMgYnJh
bmNoDQpodHRwczovL2dpdGh1Yi5jb20vYnNiZXJuZC9saW51eC9jb21taXRzL2Z1c2UtZGlvLXY1
Lw0KDQpHb2luZyB0byByZWJhc2UgaXQgdG8gNi45IHRoaXMgd2VlayBhbmQgd2lsbCBzZW5kIGl0
IG91dCB0aGVuLiBJIGhhZA0KYmVlbiByYXRoZXIgb2NjdXBpZWQgd2l0aCB3aXRoIGRkbiBpbnRl
cm5hbCB3b3JrIGFuZCBkaWRuJ3QgaGF2ZSB0aGUNCnRpbWUgc2luY2UgRmVicnVhcnkuLi4NCg0K
DQpUaGFua3MsDQpCZXJuZA0KDQo=

