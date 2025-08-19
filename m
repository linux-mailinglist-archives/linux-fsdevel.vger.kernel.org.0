Return-Path: <linux-fsdevel+bounces-58349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9227B2D007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 01:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C63E1C2745B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 23:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D0B26F2A9;
	Tue, 19 Aug 2025 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BeiwcHjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA922D9E9;
	Tue, 19 Aug 2025 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646503; cv=fail; b=ToT8LNAn07pYHayg92LWDbypeB5MTJ0TQKxvdL/346EQ+pZ/qd7+qhxjJVazDy0cHewaa/bUpFM0cK9Mr+2iYFYXHm+7a0rmYgzFPDsJKzRSv7aKeYYZBxIIvMEfE2OaevONiFcUMiJYEAGrA0ORmV8w2gTB3R5sSa0Ur0nqVgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646503; c=relaxed/simple;
	bh=lyW9r/NPiC87r90uUqxPifpXXqKxxu6379+Mi2o6kbQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UxwsF7cMC8RiX8MfhqiugKQESiMnVKM0JHrQ9UyepY21bEyO5R+A2ilu65hkClGB2QbbzhG0XKU2S2l2VRUO+af4mU/vj+qY4tXuBubrlyhejVqMJrMEGbpCHE2U34Amq4hHMitAoJ2FEfzajoVhOgxh0w5NZyaFQFFQayUMldQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BeiwcHjK; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr+MkOd+bf8+/NrVuS9cCdQ5JNirEHrmVzUy6JhhmqTdldQeWG30tALYEk+dX523e5yVMd9uYpNkhc7regk2AqsW12aPUujodjaTJoXIAvQD/2UWzQaLtfqwkF4B2frQrncdGBuwyBRqxZj6ViqO3h1gkoFCTZvBoUW/zbfP+f/WPZXDLPkAwixZPSWvowiQPzwIb4DFJeoppLrer/qHAZMx3q/DTzxax+7WH6SkzAWYFYP6wZfnNyITlusQ4HwYD6MOSHuEiuYb3rNb63QesSaW+1/NAgB/Ms4E6/jX7+Lu/KbEkX/TXqCHO8sfXLqLUowqb36zkGW8qSIp+u2AeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXBS7qACfUGkgkHC4gClF8VMBtU2H1y6x+P1QmAkl1g=;
 b=uXyQwVNWTrciFOYXdOjOsPQaJnCRKwoojKkBrMGIV0rxwsoGkBoJ6wg/b+ZEW5hxt5GQ7P0lDZVhkeR+VHj97H4Wl2kVoQlVVw1A39GG+xnAHX3kOkj8YuRobYV+IUP2/rGbJFzxj5Xm3OA/MY1Yr1pJ7mLgbmF0xKKIR/JmcWBgYWzgM7U1rYB15Lh0cOO1vpQ9RmmamHY2l2iFIaIWAXFHRtQv+o7+OlcKesOIaCKzw9ePVef4lBzDQmE9FlmYOgDadAWPG+5psAdyBX8F3UCd4g43qHXgoU0YanlcUO7Pj/LDDRMOCLlSTvskHmgyDgVzfHWcYjgUWWKhRGYX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXBS7qACfUGkgkHC4gClF8VMBtU2H1y6x+P1QmAkl1g=;
 b=BeiwcHjK4fXNO/mZ1TeB+aDo0QM2yJfz369y7uYd984M0nhCA2PLuzR7iHsUjLMgIW6FKKe3B6Z6sNLDNiMVh/vHlZ0WIk5q0njIxLNkuQyFaRLYXQLfpG9KiL8E7N65WAEAS1njvMl2CmXqCWA44NRmX3ZEh1V5a8VCkk5Rfef3sM4qIOETpQCZ1qp0UvePRs2YkXunwA4Do7oXWLgbSn3r/4uMXroSXy+j6xUZH/akRYe+Nhu/I0WJBXrk82k0g5wgUZVC7FyAA3eJlv5gSbiEBNEVRmgVHL2gUE4g9S9imH4x0YN+9TuBfFdF1CyBnTNBEdFuP2LK1XsN5fjO/w==
Received: from BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 23:34:58 +0000
Received: from BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb]) by BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb%2]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 23:34:58 +0000
From: Jim Harris <jiharris@nvidia.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>, "stefanha@redhat.com" <stefanha@redhat.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>, Roman
 Spiegelman <rspiegelman@nvidia.com>, Ben Walker <benwalker@nvidia.com>, Oren
 Duer <oren@nvidia.com>
Subject: Questions about FUSE_NOTIFY_INVAL_ENTRY
Thread-Topic: Questions about FUSE_NOTIFY_INVAL_ENTRY
Thread-Index: AQHcEWHg2DNqwChSOUqNyrcE7/HsZA==
Date: Tue, 19 Aug 2025 23:34:58 +0000
Message-ID: <D5420EF2-6BA6-4789-A06A-D1105A3C33D4@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5094:EE_|SN7PR12MB7933:EE_
x-ms-office365-filtering-correlation-id: e9b8dc23-590e-4143-03cf-08dddf790294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b2uRHqVxCVbTohYGbCa1QDoe4Ck/7zrmNW1ljWGQ46GF/TEZIScOYwNIzoKw?=
 =?us-ascii?Q?zKz84BnczqEHwSb6PbjjuK7zt8bjpBg3TCzEh5QUzNsXy7cSVY8rul84Pk32?=
 =?us-ascii?Q?o8r7qbGu+o2eQck925zcYWs5AR1O7MxSnolNp0lZ3ySK3jbMQjzyy8MhdCkx?=
 =?us-ascii?Q?TrgQh0Ikvz4ld5fGyeParkBDU7skAMQb7pDOip2jRNuEowama9ZnbjxVP4hq?=
 =?us-ascii?Q?pGM/c9NaWj8Fypne2fy/aBUFCuyPntjnZhBqzdW33W00pwQl1Y5qcyE7jIPp?=
 =?us-ascii?Q?KyN330tNhfrOSyUS5PZr6kCeP5M93N8uHfTWS5B+BjR1ZUNKwHZP0IfHvtgc?=
 =?us-ascii?Q?+ObZJI+wnD8rpkdxfoyzSJAxhjIkPMf1BoJPNKu2e9evRLhlL0t9WV2WHkDN?=
 =?us-ascii?Q?zPhxuPfXqss9e3ShBwsgiWKusBmyhH257mVMywBicKlJr0bKQy1tjwwfEDJE?=
 =?us-ascii?Q?1H+Uryg7+BDRa2lN+Omb1pXVjV1+7y7qkqnodMr1n9XeE7E+cD4aVF/bkbLm?=
 =?us-ascii?Q?d1qKVCxKIJaaQXkfj+7F+CfNH4Kteh60NpGLHAlJ1brheoLdc1ASziA92kWc?=
 =?us-ascii?Q?VoPLhM70E5EW012ZXcKwUyps9uP2qfTEit3upTHOBuIuJfDna8GZSke0tkla?=
 =?us-ascii?Q?ka2Q/I7zbXECDJ6KQT9ExC3apdYwmdAyvSgiPLZkx9JErzyWpQ9erev+KfZU?=
 =?us-ascii?Q?jcH0mt8XjbfX5CQQUSq+pcAEqXVghm5YKpIRADCjDoPD3gnlo0E3+J51YZZG?=
 =?us-ascii?Q?rW44OyEbm6PX8afkJXjCu3DSsKYqI+53pPtFB3hMxXyjQ1hP/JAHZJkx7vq6?=
 =?us-ascii?Q?/zZ5axwHZne9+WReAzxIors+goYXlJam8uLWHtANfNgqMpnGjl/fA6cM5KMm?=
 =?us-ascii?Q?IraoqihBAhZPSspRjtszjlbABC7UCCzGgtp8oL9twCEb90PefIZqCDaVWJiK?=
 =?us-ascii?Q?b7i+7fmkEunyK5ReAyY6JExQPnfrHXVCxK/Jhx7gcPVkQVUEtPweMv6YcZ9E?=
 =?us-ascii?Q?W0OIYyGmHJErpPAnSdR13feRfvgyBYdLGbh5z/Xn7RZrFDCe7N2I5Tii3lsg?=
 =?us-ascii?Q?99JdQJ1qUJ3/0ZzpCiQvRdmhbYv4cC3IM10W4HXedoLy1svGbgRR061hB4PH?=
 =?us-ascii?Q?xI8MVNQIxN4AjSwfJzuFkfWWuErgKdbowzTJzNWBHSJIfx5K/RRXkEMjcaWm?=
 =?us-ascii?Q?d8oSadHo5PPirotzIy5NPql8/hD4GEr4acdaP8himJT2OTlakvkLkeJl670I?=
 =?us-ascii?Q?bqhgHIp5grORhDue42zzl5MBlnmLsqDkXuEnq77gIuRa/3MFGublv41e5AXQ?=
 =?us-ascii?Q?ZAO9cY6Qkgj5cflIFK8E1Th+lNPdKQntsJLucNzXJAvNi5PXP0lgNNZpDdYw?=
 =?us-ascii?Q?ru/rNQjQqObdH1FmBOZN17W9dyQfxih102FtkwiDbm71TkixJQ+XhL0B4K45?=
 =?us-ascii?Q?aPG3LBoPBCBuV0aYHCNG15h0UG90nFNlZcPtjOEGczow0eYpMivLIKpcls6M?=
 =?us-ascii?Q?lJ2+fsN2NwOxvEg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5094.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i+s8QH10t3TZlWp7xkOb+htjKHWL/DGpKNwk0t5tZV7IbkPtUWl9W2cC1pme?=
 =?us-ascii?Q?t26A3Nwixvt9amd6894FX60NG39DI9ci/fr3F//XqJew8RRiNS2xQcI9r1l7?=
 =?us-ascii?Q?3NhU2HyoJ6yhwEOfbSyaISW3oXu0/MAkAIZTTWxcdtuuOcZ7RwPhuxjn09M4?=
 =?us-ascii?Q?f+Hv4gd/i7AXDyiXqO4yAUfqmNf+6RFef9lEd8v7UwPUx6YezPLLdLqphyUI?=
 =?us-ascii?Q?jbo8NlCh/FtUUHEcOzfqe3NWGVu5HtC1h5ylTxn4PscIV/YtL9qfInSLY33T?=
 =?us-ascii?Q?EMgNG8Xb4bgkCrRhMZ1mJMAIouhONl74/yN0+IgarZiVXkj2W3Mpsu87r4N7?=
 =?us-ascii?Q?bGJdIVi4ERQCZQ145kyqWgx11jFTgCGkCphNpkcBd5Fosu8zLvIf7SW5k85K?=
 =?us-ascii?Q?zDKgDe3KjAaRwXkqMWTQKNN9DYcHD/NimDxnAZ/Djt8SdYBdrKBJhjBt+5I6?=
 =?us-ascii?Q?J3dikpqzCSdOx5LU1oNekgoyF0yGaUU+Wk+EQPphYnl7Ofift6ZrtKV1ms5s?=
 =?us-ascii?Q?W43CU0k6qrj1RJ+rYYl11X9WtGT6IQhSXI4c9p/PGTIZzX/wlVqLci8cSWNr?=
 =?us-ascii?Q?SKrfU4Q9CIZPBGWGkt6KWJCtzP0+RpX3o6IRv+FkJZhw8+wN8XxsHv7xCRok?=
 =?us-ascii?Q?PidEbqEOhHInssbVvVPd3HMAh34GZvI/2FnzX6J0Sf/xUFH9hh43ovY1xo4y?=
 =?us-ascii?Q?Bo58QarBNV28iJhpAZk/dmukfRKobGwnM6PHrN6csVO2qJu4EHxtyGetjR/D?=
 =?us-ascii?Q?yZwPRjyS1eG51EdwJLhLPnshCtARLnzZ2xLcw0qgFQN5+Yq4rsrFfCAgQ6hu?=
 =?us-ascii?Q?ncBkijgz8jO9AqwJ3dJ/kHnuinr5ge5paIEWDdrxu5nZivecWfwg0R6/Zy48?=
 =?us-ascii?Q?/LLAjZNFLK+EDXNoDrvHmaq6uDAaFWk7TRV440twvdYgDFfTuC5utkgFZFB/?=
 =?us-ascii?Q?wGtk13wHBeyeG8qSpLgOOu64gwxulNa3e8R7nJehsLkOyYCn6l704Jol24fr?=
 =?us-ascii?Q?AwdFXZ7o6mS00dSA4z8lpDb4PfjsfafdN2O6Ju93cmC1FYI8Etox4yH4TAME?=
 =?us-ascii?Q?cMljTzzwPysGoX66PIzlD2W86AQlkMgS17mPrORCMznIPf/GX4am1hkN/bw9?=
 =?us-ascii?Q?LuwWN9FmdRhcNztVs7o5KogEvM4DBeZSIWhjgC3PGgBxRgQmTzVH0jDDlB4H?=
 =?us-ascii?Q?4LB+6dg2PFRSRD6yZ2IOrTznRntY406KHTTUB5Si6AB45LaI3j0Ykgf64vmo?=
 =?us-ascii?Q?IW5nsdFBiKjPzFp9Sue5lGvgHlJ5rPNORupnbK82vR18BlGbV2U0wD8KdmFG?=
 =?us-ascii?Q?QiCwF3dZpAm1ZtM7qCZ/GLdBQ/mZKrrTtv8mBE0Nk59ako6zrpecXOGZHkoZ?=
 =?us-ascii?Q?rjMoOUj7GV2hp4lshHxh9jQMO4sBUhj4G4eFUCOvEy2/QuadBYn14gGduukC?=
 =?us-ascii?Q?aVVcR/W7VD6a4ZS6e7wBpQ7FzFotEx7ArZkxUvGQkbabc9X3VjMMyss2pw/x?=
 =?us-ascii?Q?Nv0RsM0vcfgHV9uSTwLEFCaWAj/QB+QnKvB3kPw7aMBYYwEykk6YXWOshw/H?=
 =?us-ascii?Q?f9t++EPf+zfYHG92h2ozB25Ez16uzk+lNy6SDkKJ?=
Content-Type: multipart/signed;
	boundary="Apple-Mail=_74BACB81-2C9D-4139-B038-D3D421652735";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b8dc23-590e-4143-03cf-08dddf790294
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 23:34:58.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgyVF3G/1fIWuVxvPbEQHw7QdQgwx0udBLc8OTmg8CpIzq9EM4V8DfI9ikG3wz3tn0vp6y4zEV19XBkXItgXIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

--Apple-Mail=_74BACB81-2C9D-4139-B038-D3D421652735
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

We have a case where our virtio-fs FUSE device (running on Bluefield =
DPU) needs to invalidate some of its internal file objects, so that it =
can free memory to be used for file objects for newly looked up files. =
We cannot rely on the host to invalidate entries itself since it =
typically has far more memory for its caches than is available on a real =
hardware device for its file object caching.

We would like to use the FUSE_NOTIFY_INVAL_ENTRY notification to ask the =
host to invalidate inodes, triggering FUSE FORGET commands that will =
enable the device to free its associated file objects for those inodes. =
We cannot find any documentation that explicitly says =
FUSE_NOTIFY_INVAL_ENTRY can be used for this purpose. But initial =
testing and code inspection indicates that this does trigger the FORGET =
commands that allow us to free some of the file objects in device =
memory.

Can we safely depend on the FUSE_NOTIFY_INVAL_ENTRY notifications to =
trigger FORGET commands for the associated inodes? If not, can we =
consider adding a new FUSE_NOTIFY_DROP_ENTRY notification that would ask =
the kernel to release the inode and send a FORGET command when memory =
pressure or clean-up is needed by the device?

Best regards,

Jim Harris=

--Apple-Mail=_74BACB81-2C9D-4139-B038-D3D421652735
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

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
LTIwMjMwNTMxMTYwNAYDVQQDEy1qaWhhcnJpcyA2MzZFQkM4OC0yNThCLTQ2QkYtQkU2RS1ERTgz
Mjk3NEVFMkYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDsK5flcFLKT/1ktmlekKTA
8JwI64E20ekPEvj4KcEynk2b/aaS1Vol+gDoCmp8Q2YKca4RO3IPmWYGMEKWyOwh3R/X+NDC3kEn
xR9FRyPKixPVaVIJOBvpLgTHlTGo6sBECGARmWLNcq/VP/IOEfynt+o0ycfhfMmVCLNeTpVnTDfr
2+gA+EzrG3y7hFlf741+Iu27ml7F2Sb+OuD8LaaIvbUH+47Ha9c7PNbS8gGCOqJ+JqpFbz6nyiVN
KzcxsvQph1p1IlvctilnvGOLNCSQY24IPabPY4mh2jOOELalk8gKhIgeZ4v4XnuDGKzG3OQXjvNW
ki++zsKA+Vb5MH1HAgMBAAGjggNiMIIDXjAOBgNVHQ8BAf8EBAMCBaAwHgYDVR0RBBcwFYETamlo
YXJyaXNAbnZpZGlhLmNvbTAdBgNVHQ4EFgQUXogZtTPa9kRDpzx+baYj2ZB5hNUwHwYDVR0jBBgw
FoAUlatDA/vUWLsb/j02/mvLeNitl7MwggEGBgNVHR8Egf4wgfswgfiggfWggfKGgbhsZGFwOi8v
L0NOPUhRTlZDQTEyMi1DQSgxMCksQ049aHFudmNhMTIyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPW52aWRpYSxEQz1jb20/
Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlv
blBvaW50hjVodHRwOi8vcGtpLm52aWRpYS5jb20vQ2VydEVucm9sbC9IUU5WQ0ExMjItQ0EoMTAp
LmNybDCCAUAGCCsGAQUFBwEBBIIBMjCCAS4wgaoGCCsGAQUFBzAChoGdbGRhcDovLy9DTj1IUU5W
Q0ExMjItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9bnZpZGlhLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBWBggrBgEFBQcwAoZKaHR0cDovL3BraS5udmlk
aWEuY29tL0NlcnRFbnJvbGwvaHFudmNhMTIyLm52aWRpYS5jb21fSFFOVkNBMTIyLUNBKDExKS5j
cnQwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLm52aWRpYS5jb20vb2NzcDA8BgkrBgEEAYI3FQcE
LzAtBiUrBgEEAYI3FQiEt/Bxh8iPbIfRhSGG6Z5lg6ejJWKC/7BT5/cMAgFlAgEkMCkGA1UdJQQi
MCAGCisGAQQBgjcKAwQGCCsGAQUFBwMEBggrBgEFBQcDAjA1BgkrBgEEAYI3FQoEKDAmMAwGCisG
AQQBgjcKAwQwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggIBABaxnmlH
ePMLNtYtyCN1iDp5l7pbi5wxLNXCULGo252QLCXJwKTosiYCLTT6gOZ+Uhf0QzvbJkGhgu0e3pz3
/SbVwnLZdFMZIsgOR5k85d7cAzE/sRbwVurWZdp125ufyG2DHuoYWE1G9c2rNfgwjKNL1i3JBbG5
Dr2dfUMQyHJB1KwxwfUpNWIC2ClDIxnluV01zPenYIkAqEJGwHWcuhDstCm+TzRMWzueEvJDKYrI
zO5J7SMn0OcGGxmEt4oqYNOULHAsiCd1ULsaHgr3FiIyj1UIUDyPd/VK5a/E4VPhj3xtJtLQjRbn
d+bupdZmIkhAuQLzGdckoxfV3gEhtIlnot0On97zdBbGB+E1f+hF4ogYO/61KnFlaM2CAFPk/LuD
iqTYYB3ysoTOVaSXb/W8mvjx+VY1aWgNfjBJRMCD6BMbBi8XzSB02porHuQpxcT3soUa2jnbM/oR
XS2win7fcEf57lwNPw8cZPPeiIx/na47xrsxRVCmcBoWtVU62ywa/0+XSj602p2sYuVck1cgPoLz
GdBYwNQHSGgUbVspeFQcMfl51EEXrDe3pgnY82qt3kCOSzdBSW3sJfOjN0hcfI76eG3CnabiGnVG
ukDrLIwmyWQp6aS9KxbJr4tq4DfDEnoejOYWc1AeLTDaydw7iBNAR/uMrCqfi5m4GjnqMYICzTCC
AskCAQEwWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJYIZIAWUDBAIBBQCg
ggFDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgxOTIzMzMy
NVowLwYJKoZIhvcNAQkEMSIEIO2YLSpDH3061190ALve7nbK89/1ueWqvXrugkEqlJv1MGoGCSsG
AQQBgjcQBDFdMFswRDETMBEGCgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBm52aWRp
YTEVMBMGA1UEAxMMSFFOVkNBMTIyLUNBAhN4AcH5MT4za31A/XOdAAsBwfkxMGwGCyqGSIb3DQEJ
EAILMV2gWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJKoZIhvcNAQELBQAE
ggEAuTzMP487w+1YCXmuUcZRBXh5vbjMXZPbARI0hoVZkceLkILCZTd6mDyZVlHnn0aBUaHnnfEp
gC5jg6dzvSzKvkc6YTE6U/gOchO5epwgN3kWzPSotgbeA/kve692jD/XW+KF+HYLbLA71rmrzFMi
90FqdFJlcmt884D0FveU9vLpSKr6OqJAkFVxlYjW8b6cKympC1n3I+KXCbkQJfWw/K891YzCyQUS
5EpL0he4oX2JCOvFJ+HpFHnM6mZgU9cMlmsoDbWZKmleyjl0AHe5erJpNuIRCL8n0KRmI8fw9cc6
nqlMpzgQRzHF5kf1bs6PWf4NHw8eowDKTpLhXOlQqwAAAAAAAA==

--Apple-Mail=_74BACB81-2C9D-4139-B038-D3D421652735--

