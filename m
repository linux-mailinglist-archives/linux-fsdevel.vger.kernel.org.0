Return-Path: <linux-fsdevel+bounces-71125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB59FCB6434
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC9F03015E3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D0296BB7;
	Thu, 11 Dec 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marel.com header.i=@marel.com header.b="MgkVIv27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023093.outbound.protection.outlook.com [52.101.83.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A729A1;
	Thu, 11 Dec 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765465336; cv=fail; b=o5ApCtADYgFgwC+cjPkoXJoYqopWJtaQ7WenWgsDgEDterfaIhLoCP7t8G6mXeordYrWw5zGGa0bLk+g8T/1unfuP2jdhoaIlFlUk9kx9L0eznVcJbmJweIpFIRV+ql0IQJgL9iSlALz09XQabNUyIdY02HuIUJITM6dKFDxmS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765465336; c=relaxed/simple;
	bh=BxyPyKYrisfmoUPdae1fmI3Jv63eatgrppFL/JTLygE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QGOpaSSAYCSwNkmPcb3fQZ/erUOaW1GqLJwYDRUdMbjk2ytQGdMvzylFCvnhcbPZOIfEQXmLhE0qdU7+fWh95Yqeh/iYpTOgmJw8xNdyjAbpM82VUniFuk6FSf4Sp/SXSX2Z/a38BOAvccbbAz/8bHcvDrHTJ2u55zaiti8Er68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marel.com; spf=pass smtp.mailfrom=marel.com; dkim=pass (2048-bit key) header.d=marel.com header.i=@marel.com header.b=MgkVIv27; arc=fail smtp.client-ip=52.101.83.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marel.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR0DI67qE7mVTyM10K4x09mib92q9uDKvn6ymq0D4zlnw6aE6K/Lz5S88/EuPxUAal4C++ijbB3mnlTGWsg5cHFy/v3anivUfFqTggw/FQPziR/F0se9nlN8CBJpDtiJwmb3ShDQ2i2uMZbbNdfj71uag6lFn0jDqxhNgoWu1PePa3i7ixbaYGeBjGwrcGd+wOI1MSrQjDwjRTT0CQn3ECPl7hG4FIJqqG4PCXNPrvVsAKXOp7u6OQb0QRw4KAQw3Z7aOl+alRxzmBz7zcbkvKXHyzt/zVyTF9AQB6tRkqh9inLVpp7IMZd4qs2v2mOStQxGyNboHrDxYIRQxX4nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M50KlMKy1BO23Bei/AK69minfRsGdkOXRjPx5csbAE=;
 b=vs+U+++mGW5xxNwW7S9ksJQcyiOguOHA/KB8MT1zB+nx1Qt/vWldrHVl5Zf9Qdqg//pdWLnun0WmBh7K4Jz/DwenEv8snx8wCJ0VmiErVTKZqN/eERD4YL9rkBC9bx6Is46i5VUeNhUbDY4D2/k5jeV1U6fs8nfNeddF56CpQ1uqFTyfHJxfv9/sCIZME9vcVsRJrWt4tmjFFAfIeqy1hrcwMmbV1Dk4XGVOljgkmfhZjT34bG28euXjDSBjlnyH83KqPoeYg7GkT3ajvVytcGSCpA0QatoW5Q0XktGEQHeKre19s/Gkb2lwaQDckROg/OCbM7gpQRHwFQbNaU/q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marel.com; dmarc=pass action=none header.from=marel.com;
 dkim=pass header.d=marel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M50KlMKy1BO23Bei/AK69minfRsGdkOXRjPx5csbAE=;
 b=MgkVIv27htFWQOEqXm54lJPbAJqapcgrwYSAds6xwHeG5gUMaEKJxHOIoi+ZqsN12cbKURG7PrguXzWGn7frIQflYzFThKp8mMtNICYSq2yhIRgO0mT9+WPai9zXV2BZvkh0KpBnOIv9o/pHgJJQcczcbSp/+BCoq0yjcrD8LcHvXjca4/t5TDa87lQY4wUqFLQONIIIn7nBIaOG661Hgt60v2/k9YAzo39jg2kH+COlyRFWqfzR5M3zx4pg3i0YLImGHFNz1r7NXfwJSh7bnQdLXksO9tt8+ZlR3b+Mzp1/Lp9Xd7PRmdX7tkNOS9sF40x+VcZERQ/trwx60V4pNQ==
Received: from DB9PR05MB11014.eurprd05.prod.outlook.com (2603:10a6:10:4c0::11)
 by PAWPR05MB10850.eurprd05.prod.outlook.com (2603:10a6:102:361::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Thu, 11 Dec
 2025 15:02:12 +0000
Received: from DB9PR05MB11014.eurprd05.prod.outlook.com
 ([fe80::ef4c:ed93:3918:a8db]) by DB9PR05MB11014.eurprd05.prod.outlook.com
 ([fe80::ef4c:ed93:3918:a8db%5]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 15:02:12 +0000
From: =?iso-8859-1?Q?Gabr=EDel_Arth=FAr_P=E9tursson?=
	<Gabriel.Petursson@marel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Bug: Opening a file under /proc/<pid>/ after process exit may return
 ENOENT
Thread-Topic: Bug: Opening a file under /proc/<pid>/ after process exit may
 return ENOENT
Thread-Index: AQHcaq5kKelqckRp10+uRFgxVe6o5w==
Date: Thu, 11 Dec 2025 15:02:11 +0000
Message-ID:
 <DB9PR05MB11014E5806668445342EDE9DAFDA1A@DB9PR05MB11014.eurprd05.prod.outlook.com>
Accept-Language: es-ES, en-GB, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR05MB11014:EE_|PAWPR05MB10850:EE_
x-ms-office365-filtering-correlation-id: 1c8ca295-a91b-45ac-398b-08de38c6437f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EJpxzMubLYPSSf9I+XRCXIVtrIuGNfdy2C05LOVMVVkJkUA9ZN8rV37PRc?=
 =?iso-8859-1?Q?I0mZKWPFnhfGmg1ZmcRm2anWRnt4IiN1EewmxXX76EY3EeJ7q5Qchuj4e0?=
 =?iso-8859-1?Q?uXfIuY5qmDm8liqv3CAKy3gnD94gNyW3vE7ww/UGyFTRwITnOx4+L4/opb?=
 =?iso-8859-1?Q?Zc+gSTXuriySlXrFQM45+oKx0p8zcakg0P+rR03Hy/Ti2HrJKbWM3uQxZL?=
 =?iso-8859-1?Q?t2dmAfpWj/p1VWF/8KV609oNB9RWceeUCgXR8r+sc4T85TH/x9POasJRHj?=
 =?iso-8859-1?Q?CPxxlvRlOntA0WruwWAbpCLYIzNZK1zCC+ZvREXpPiPvfPPH37CxPUL6pP?=
 =?iso-8859-1?Q?eFztHIOR2r783V3rokIQpHLNZ/kez8DuBzDGaAPzmeBYWS558KsoGJCVJT?=
 =?iso-8859-1?Q?XzNY3VC/skkSX0qLo4ZHQKFM1EIy4wMJ1KY3wZaLt1UXVfz5xHYmoGhhBf?=
 =?iso-8859-1?Q?Fb8lzXrDhQdKIwQnBmUQbbI+rW8k7bTfnQu3UuOrvdluWB28XPnKOOPhUE?=
 =?iso-8859-1?Q?Yk4ZjH8aWZpKTEpKkTk5K8ykCNKOeujgQjgCQ5sJVoj+k2rKx9ZZdZRdzq?=
 =?iso-8859-1?Q?h6Zik7+xKq62u54YUeJndOfOTyZ4+kaHQU0lr0J8OKyYzjZB0/0ThFvjef?=
 =?iso-8859-1?Q?ZYEZqNkEM2jM5UTSV1X6gzQmA1wtIorPVX1OhVec0A5GJzS5pAwv1W9+gE?=
 =?iso-8859-1?Q?FwwWRixAQuBbYBweGiRsW4ZVt+TM0sRGGyhXsWspeZzqH6ZEMcR9LJflm4?=
 =?iso-8859-1?Q?C9+mhrN/jp6KlgSogANkMj36Uu8MtXII5IyvPLgCsZZoTT2letusqxxhoa?=
 =?iso-8859-1?Q?UPWyNQVVhnWtLXGlN2wR6eVjDx16NaQflkj2zG1jDsjvT4psXk61lmFEUW?=
 =?iso-8859-1?Q?lsgyEBZB0rA/P+MzBrl9xCWK2TCPdvHJJx1A2g/fhtQU5j8OtDzV5iNFX7?=
 =?iso-8859-1?Q?qPpADL0hVv1m223ftU3DxDcbQhrfChETWbV0cGrJQ+JZW6TyaVQqN+rbS2?=
 =?iso-8859-1?Q?LWLud93axbDeJlnK7US0w8f6msqe0v2ce/E6BunBEMHMriVtRCeD3df0OB?=
 =?iso-8859-1?Q?LEhRtSQNE88u54rLs6VBIBQnJt94UYItkVXQfRNqxLFrCOU9CyLsqB7Mcu?=
 =?iso-8859-1?Q?W4II0ZIE1+euLTii375RjjO2oHCdS+pT6UvF6n5OznMN+cXDJxb9fMUnzT?=
 =?iso-8859-1?Q?0f/YqoZBOzUfLsHFhxQaHxmd0TgDmZDG/7A6Ir4InJNUXsmaVI5VIsRteA?=
 =?iso-8859-1?Q?YncsUkMWy01klYqQYHNG9VRa/n7AowyGtEBjN0ENst2sQHXvtorv+IutRT?=
 =?iso-8859-1?Q?SAyDOuuR4Um3BuXXA5p4zbOZLRqvOiaLS3ghBrtepAF3c/0TDTSVz1msXg?=
 =?iso-8859-1?Q?PoG45BeuKEUXQF5jhp4bquXKDCxICGyiDyRmDBQXRchmUmf/PrTSI41Bm8?=
 =?iso-8859-1?Q?/hyx/qUnZd29f4aUCY2Pa9MBNXvAfvgN3ZEntUIdnfLZajjOfYTbhZLzJ3?=
 =?iso-8859-1?Q?WVytciy4QHaUFhEQQfcn6+kVudvz7Qagk2KrvvhscF9DmasGHbh8sZU7Bd?=
 =?iso-8859-1?Q?fE+7CTPeyfgfqvx1ekPBEL106K1b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB11014.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oLqA/OcXjpop5H6KWjBX4bQA0WWbd+73bbC8veQk3FhY6eHzqVJ+gUeYHg?=
 =?iso-8859-1?Q?yOLKDYrWW3EnYGG35vRdIrnkYJRxtsU2kc8LQidT4b2hKM61oy3uXGnGtT?=
 =?iso-8859-1?Q?aG/mFAejQegFYujDKcDqwun9VnrvAbJ2NEDelOXb4bAR8CwSOvlfPtI2nR?=
 =?iso-8859-1?Q?gItPwVsuE0c+Kwf/aHwW/TB8kAGM/Xnzh/eZxkjVryK/vPeojN/GlstRTZ?=
 =?iso-8859-1?Q?wFNiL1pIys0zvyyrh++fTToCC8vUupAb6Sc9ig2NG87lvZdSlIXLdQqjBm?=
 =?iso-8859-1?Q?G5brJpWhwK2jYujOONYaAT9BMW1GmdJGIsn2dIkvZa2ZcYw8ezZ73G5vRK?=
 =?iso-8859-1?Q?OlGkZsOuX5XMDTfIPf2Y2Yt7vLtvSk46rkKUXPR3OUxg4BPe3oCG58VGtR?=
 =?iso-8859-1?Q?dCkadfyezkiHHjq2RbGYO6vD3WuKR8DWYAbGHebMUXpPyR0zNnrFLQeCKX?=
 =?iso-8859-1?Q?HpfqjXKUTxZnGpk2jxxBw0t0Y9laOAnuuAxozUwlATKhWun2kCqx2iDMC3?=
 =?iso-8859-1?Q?ufl8JbJV8ugWEDxwbyG7KjyXWt/8h0nC/upD9qlzGWc6wowLi1gQ3xT17K?=
 =?iso-8859-1?Q?ruzf+uvUS+AgZvEwKGRVGMYuwmV06eNUDrBGm5IvQASrw7PLArz3ngI3qJ?=
 =?iso-8859-1?Q?NmCzSNTd0ArHYvRh2u97rac+flEqtevZocTYh4eXq+v96HxpRA2x2KeI2n?=
 =?iso-8859-1?Q?Osni4NMGXk88sLQkLE2AJWhGT2xuDEwXlYiURxfj5A7Ca0HYaqGgb3cb0p?=
 =?iso-8859-1?Q?10IyLdlxxns2ZL0yCDMO8s5VLmhf6o0GC8HKgK5MhgI4RRkB6dWESJs3lf?=
 =?iso-8859-1?Q?IDuaU1r9TZbKGe9ZqIIKhG2xdv1Amh+FMKH6lqZZX2A3p5Caz2jZKoTs9Z?=
 =?iso-8859-1?Q?QsFkJvzASW6B6v0wNNUWB53Zwh2uSC4PIjVrJLW4k7wc3JgZwan0fomwgp?=
 =?iso-8859-1?Q?kHgam1UcEHhnW3z+RoMI+0pl5ZIMJpCLEaZHegcKldLRf+KirwjOSNUo2N?=
 =?iso-8859-1?Q?hw4n0ZlQKctuwX8w55hVOK9fDpCVphDFUBVABz9YSVTzIupBIYU1AQMJ2S?=
 =?iso-8859-1?Q?eEZLfxalce5CSSdDLFSHwZ/ByGGkBITaSPktoJ5vG+hP6VUSaKyIeZ2Xjl?=
 =?iso-8859-1?Q?jGDcJNZuk1gKdJFfKxYwkRAChczQ/S+hByso3A8a7hwgVhoPBjHrpUI26g?=
 =?iso-8859-1?Q?+Oy2iawK8K9rvN/lFGB5fZAvLnW2JKB7+Q3n+Md5SJ5xVnxmKrKOzlWcOp?=
 =?iso-8859-1?Q?5vuR58TWlq3VEsL7hek6rDinkOtoWOTy0Vj66YEBCfi1d+w6juk8yYPPxB?=
 =?iso-8859-1?Q?mgwbS1WK7H+OMDBx9gSW7Y1hTke3YXggaVoldcyCwRJPF9BCLOmgM6biaH?=
 =?iso-8859-1?Q?+C8dTOxrqSYoWBgeMCOySAceFddH+yfRPdvpYGiZgEmCu1cV9U/u9E+ft1?=
 =?iso-8859-1?Q?Xl8Tja5+3Qj0LvF9u8jPq2sZSddBL07gqh5mVKHlHdIqozaOhxwqUDl5g+?=
 =?iso-8859-1?Q?RJtmn4LBX87V/7SSVpCdFDEBRqdc1pmBme99HeAxJS4T7peUQLtHP0cLWr?=
 =?iso-8859-1?Q?gepN8lpFqCZ26Uc2x+osnh4DXCTOvK++kSO6WVUMQOD3PwjJRAcoxu29b7?=
 =?iso-8859-1?Q?8cfRrN5ovVL7FcvNWNMHN9neIpVxJRow02?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB11014.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8ca295-a91b-45ac-398b-08de38c6437f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 15:02:11.9766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5f498be-7303-45fd-a594-9e3fd22a77d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOKDCq2DK8KMUfBQBR93GF5cUNUaZjR1l18wtvysqwuOETmp912BhGcwgziU7S2NUIDq/2pV4XBBpPu9QwSnd+c1XkChtrv9CfsYsMwyo9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10850

Opening a file under /proc/<pid>/ after process exit may return ENOENT=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Given an open directory file descriptor to /proc/<pid>/, there exists a sma=
ll=0A=
window after a process exits in which opening a file would fail with ENOENT=
=0A=
before the expected ESRCH error.=0A=
=0A=
The following C program demonstrates the issue:=0A=
=0A=
	#include <errno.h>=0A=
	#include <fcntl.h>=0A=
	#include <stdio.h>=0A=
	#include <stdlib.h>=0A=
	#include <unistd.h>=0A=
=0A=
	int main() {=0A=
		while (1) {=0A=
			int r =3D open("cmdline", O_RDONLY|O_CLOEXEC|O_NOCTTY);=0A=
			if (r < 0) {=0A=
				fprintf(stderr, "open failed: %m\n");=0A=
=0A=
				if (errno =3D=3D ESRCH) {=0A=
					return 1;=0A=
				}=0A=
			} else {=0A=
				close(r);=0A=
			}=0A=
		}=0A=
	}=0A=
=0A=
From the shell, pick a process under /proc/ and run the program. Once the=
=0A=
process exits, one may observe the following output:=0A=
=0A=
	root@kotek:/proc/3414924# /root/a.out =0A=
	open failed: No such file or directory=0A=
	open failed: No such process=0A=
=0A=
Affected versions=0A=
-----------------=0A=
=0A=
We've tested and reproduced the bug on:=0A=
=0A=
	Fedora 43 with 6.17.8-300.fc43.x86_64, and=0A=
	Ubuntu 25.10 with 6.14.0-35-generic=0A=
=0A=
Thanks in advance!=0A=
=0A=
Please let me know if any additional information is required.=

