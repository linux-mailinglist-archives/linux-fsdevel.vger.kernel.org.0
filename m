Return-Path: <linux-fsdevel+bounces-58350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307CBB2D00B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 01:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A3E1C27401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6281C272E5D;
	Tue, 19 Aug 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BeiwcHjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBA26D4F1;
	Tue, 19 Aug 2025 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646505; cv=fail; b=mZVAuC7Yz+t3SyrcQ32yTCbqHPJOGd6afnQ3XktkFcBfmQ0pK0VMfUkD82zjBvo/o5RMhJHm4QDYFLM3BaXX44QHHdwpzd1rFu9V+MghlRZfhxuMpGmnG4DqDQJ5N1EFZ0gLUdt3ortpTZag+RaD4knac2bxOwW2qa3TeoDVrYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646505; c=relaxed/simple;
	bh=lyW9r/NPiC87r90uUqxPifpXXqKxxu6379+Mi2o6kbQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EtOxhAS/c4oJGxprFqON07PD+ZCJmpWsbidRlU8KuhSiFyWhdK3GrHFr0N970HECAvZbYgk71nrQ6493C9cTWvok+b7bhSk1fSDLuMMQplqESJTdOvJZOPfoR+uIp1/1GKz53gejdN66NK2bM/qPmGO92apjTeA1FIXS5x2N6ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BeiwcHjK; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+d1dSbFepdErIxKvTwy6qorJpQYmlifOtJ6QSOBmVC0GBeHAxDPZska2kk7E2KpzAv9XVNJ1xbSMsqQKth0RzSSytIvUfxlHy3kWdkz0mDX1jNsrL/idh3m3+WZAexNXvqNls2NrXLUFw75BjiJEepbWRCYlskl3vFKHUNWEMZDQUpI2w4ZJT+OgYVXhVqShPku86ocrk98RmDEPh56Kx/9RtYXW1/OvdNIs4pQTRKLFxcWBW1wXtBqNQFlaZc3LkxzoMqgQ8SuVBMEX5Ml1+WhuhSOJ0lfmRBwwBZyx3utL7CkqQVV+3JfGgOHxuKRn4u2N7l4rVEEZ0ldhp6Zbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXBS7qACfUGkgkHC4gClF8VMBtU2H1y6x+P1QmAkl1g=;
 b=YftHp1jWH4LA7ap8bYw6Xy9vdjDpFpXlb8ezilfLm5/WOJ/Db51SG16pPEq82vdlU2Om6e/zK+YpBEuouiNYkF/t8D3H/M5VukSCSFA+pUEXPOaX0/yzorZ0l2ja1HFtFJHuTmRY07ipO9a8PMqkVGautSm3EzuucY/O7SmfP6aQZ430GaGBbLZA3QJt9wD1cDEx518xHITadXSNSdK3Iitq/qsOBouIb+OYGNYbUV09jXZPzG0AgR8cmAFFOGLZIIhuJz7woFDgoz+NtbIOAOzIcFmM84+tD6joHyTog8kf4F12k+YDY5AyC4ZWczH122PdiG4dgSVGHvDyaxcRXA==
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
Thread-Index: AQHcEWHgL2DEpMqwGkyuQXvUOGlm5A==
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
x-ms-office365-filtering-correlation-id: 3742f24a-2a2d-4005-1ec2-08dddf7902d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iA+ANGsDaNmM06XKw8wAbUtiMfan0b6MeHlPnB7ta7v2EwiPbnL5GcYRneUs?=
 =?us-ascii?Q?1L90VloNpvdFW5AKtnM81mTgxH9so+opjuuXS7PX7ylKeZsPvuTPcDqMIZrn?=
 =?us-ascii?Q?G7x8T1DR8TVj/Q6AAl+z+Vd8rmRSc9w202yMlceaCztp084lzdzk6UtWS6Fx?=
 =?us-ascii?Q?L8PxOXJUfeuw4siDbObDMbr3s6556psgyBAGZYLFXl8pn5Uyw3vQYfPDy+Ng?=
 =?us-ascii?Q?8OXT6GLA0MkMV+nG7TqDElo1esQKfqlW0LJQ9O/0HFVcJ4lxcG9Tw/sVJuku?=
 =?us-ascii?Q?epnQ6XX+qb5nrHNFPC5ZhQYjjYarM3NNss9+r94DJjx1J30ejrbGI4Al3gh+?=
 =?us-ascii?Q?VdUpw5oPRUMJus4PrzlGVjuEr/rpw0W4DFlnoGNx9RVt3FE6e5b6D5fQik14?=
 =?us-ascii?Q?8v9MJUxH3PJd3Atth6R4l8yNHttYCsLlfKIdEmBN8xZ8mpGtZvkxXKS4VQqK?=
 =?us-ascii?Q?6cdYwRSTJRueDnUsEBPPhBuxt0VOq62aQ9bDEFQHiwSXaXU24854XGjs3lCA?=
 =?us-ascii?Q?B9icYnZjdBQMBmNg1YEahQR8YhPCbmivg6Nz3cRrKsa5D9T5GbB+lHSWfdRU?=
 =?us-ascii?Q?YzE2ZoJfBCwcUKUN6EEkFVINPids1EWw9blsuwJdnXIIfrP7dZcEa/YxtHXL?=
 =?us-ascii?Q?MOBsGy15444v1ARe5ZrZuyHaF7vF6BrlkjBOJMYErThnWJTqsjGCClCW+Mq+?=
 =?us-ascii?Q?vqtoyrTJNuV0FgtgzsTrj/BfV7iracPxM7LWo+d4AlyetkzxKYExXx44GMHW?=
 =?us-ascii?Q?jleX369bN4uvoekDNigDHKq8ptf9mrGnHbbYQXqw9dT4/Q2oYFT/c1Ueg1Aw?=
 =?us-ascii?Q?7eH4bUoLncqfhVoNC63DtRZpC1MxRFl4IUsf5bjwwH8WBLA/rMynFn/VuYg2?=
 =?us-ascii?Q?8X3FtZuX8OUSZSD7aEMiz5hVNK3uZC5y0kDnR1b8S0xp5+DuZsafemtZVUIB?=
 =?us-ascii?Q?0RJvWJ3dltIO12gpSPyFpa//N4CHpQaufbkzyspaz6xn4+qvOSsnC/eESkM/?=
 =?us-ascii?Q?kCV0nTy1tuKn4jmqlguuL8FmMXBKJ02671Qcp27sDwVxWcQKgYZHe25+FF1s?=
 =?us-ascii?Q?Ztn5/ArQ2aV7jzEaaMgS7GATaP/xNsSh+0OwOYFde940rIv1mJn0MNghpTOa?=
 =?us-ascii?Q?DIhxdCf+n775njrPd7GqcruspkEaFqRFwa5H6xOgmIGK83edSrrp5pqzunPT?=
 =?us-ascii?Q?Cw2noKzxqAaVOiikdFo2VEYcX8RFZLTtAm8/Xn5BTezmYGNhqhTmQaRVVppj?=
 =?us-ascii?Q?MDyCK570LRZqIUCpahqcqHu8oTLQxsBtd+7wvdqvLzAMt7/vDj1+K5q/lTjv?=
 =?us-ascii?Q?iVtPbGxBUEYPUVXn9wEF7Ig2nMJqLRPNqlD8C0D2FBhG3O8HMqWEviFvd/su?=
 =?us-ascii?Q?tI6OHkwmIrigCR/qBQiDeBM0pwmdp7T2w+NaDa4NfMKuYdfL5yP6rfDuQjcH?=
 =?us-ascii?Q?+8lUPgGm/MF7m8U4Ro13wN99KMBl78IeEhRhb0yeLJG8HDpYV938CWPDZ1T8?=
 =?us-ascii?Q?guW2m9HHhiwPm08=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5094.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EXmd8R8nMW9QJY0JLlambMe8AltZ6VBDz2NNzu975bQi6yVYCDLdt9h8zxcC?=
 =?us-ascii?Q?qTVFIGOuDrpQy0JbBpdcq98zKzoZOplaXBzaAMfBXajil6t4j1i+D8YwM35w?=
 =?us-ascii?Q?4Pa1XVI+s8XhQz4IhdUjHDddzIRLzx7JPgwSm3uuFW7wgv+l/RghL4EfBa6g?=
 =?us-ascii?Q?eUYbBMYU/WZt/HIjLVsdqpsm5w+3M4pA7ZX4vkPalGI2VGmilQI+l6GjxitR?=
 =?us-ascii?Q?CP23YW0PYd81WyrZgVfV8TYGTXgzH1IgNP7oS31syGsMyDBpqyecDJQsZeb1?=
 =?us-ascii?Q?MbDLD+/CeUC1EXnuuM5U1tPtH6/FYXsuC5KN/W0lRKIyircvKpSbvr9cyjA/?=
 =?us-ascii?Q?N/vHk9SdwB6VYkxJAQOVocDROEB2BWGxkwHgjdYJhZPFv5C3uiDq1TyqE6JD?=
 =?us-ascii?Q?lVpQ7b9c36OXpQIao7DILnjzaLGMJmofd/yqHJKk6zmayDX1hKk1ZYJVt9MM?=
 =?us-ascii?Q?OaelQwTOJoqHB38O6OajgES+zeneTsazv4/QIPRkM3i7V+M2AOERCrIs5tyd?=
 =?us-ascii?Q?ykE9e4L9eX1jyia0B3out2+UfpLo2wdcsMmIBfEUw3HaWw8YMtBx93Ns03Bc?=
 =?us-ascii?Q?XnCqLzMv6tGnbtBsDujnlkoFWL+a+VieIMmuKiuJz3NlSNhOVTbMEH5TRnfA?=
 =?us-ascii?Q?+1PpXi8bL7qEwup97OJiKybXIv4xY6Q8i1KcSG9oABYjx54TJhVnuKMcCkwO?=
 =?us-ascii?Q?lrwrDZ8v+4OWKKKiaZ+R8xK+C2s3QyRnWlQnaPNWFM9H0yp4CxZ3u5zD86KY?=
 =?us-ascii?Q?udJL/NzkuP1Wzg46oXKM7PNx1oU/yjBJs+5CwqHS9tG9wKxv+Llrsce+dN78?=
 =?us-ascii?Q?UbAPbi+nypuPog4o6YiJ5Wf0H41obaU+5MHalrH0x83gKbG66Kss9BCkdEiN?=
 =?us-ascii?Q?1ktliVQxlJDtX6gwpmUZpXp55+cb0BoQt7vufU9uGPqXZRNvVa7RK81FaKGl?=
 =?us-ascii?Q?x662QrIcbpm+bUlvI3nP22wDLxcxvQPyKqmz2O+TMSJQPLITcloq0fxDtHDQ?=
 =?us-ascii?Q?k8tzog43rBhXWdZ9OoVcCCB2laiFyYdC0wunrgrhegjXxvi7mp87TVSqM+Gp?=
 =?us-ascii?Q?/enlpHqLxeK+wXO3qJHBVnZSy8xIgw5z10FDXjg29gV9BukDiUk7ANnjzMF/?=
 =?us-ascii?Q?X8jGpuVf9KBMak9fVc67sGwA4GDewIhH9hfnbP8GIE/6EamJmL+YScPiusxi?=
 =?us-ascii?Q?DIvDxb5yNylxmCr/iOKPnIE32rVfOwEcKkOwHqQ4HbPCJ+FdwH2HIUJ3hR/R?=
 =?us-ascii?Q?+zw3523rVRGm/tcEJcDldefaJRA4pM3a36CsfNJHF9zAmA64+DoWNbZ4IZ0N?=
 =?us-ascii?Q?0Go214PKfjJTRrD60yIkTEWdVvPoh9w1yqUgvZ4MaVmqELC7r0GYEXTO/pfz?=
 =?us-ascii?Q?uj6RhCrkA8d9KzDuH0SBqgHl3kGEvrGE01wdDXI+HjacEYLLTkTMwUciVKPp?=
 =?us-ascii?Q?dhFMnq8HP3TI6meqdX+Rv2UR7N6GyyhSQ3zWYD0UL6JZeeJwUID+yv3GAvlp?=
 =?us-ascii?Q?WqL9YjLTSwOQe4lJdDR4tKx3Bf0aQOLXYzj0LaFEzNTu/GMHb2BjXSo6yuL8?=
 =?us-ascii?Q?iwuFez7+u5P3ZY/p7HNmSQQJ2hbNC2duEIVqHZT7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3742f24a-2a2d-4005-1ec2-08dddf7902d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 23:34:58.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2NeCQSt31MdPwBtYh4r+em9kyggRZVRwjRjFWKEshBMjE9Ts9sIpiGmcmn6/uYTgwiksCYw/qB86+TGb55JUA==
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

