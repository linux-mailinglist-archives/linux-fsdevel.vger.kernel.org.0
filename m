Return-Path: <linux-fsdevel+bounces-46288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E66A8617F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FCD16CB38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F320C485;
	Fri, 11 Apr 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="IaBtFCed";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="IaBtFCed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020075.outbound.protection.outlook.com [52.101.188.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304320C009;
	Fri, 11 Apr 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384489; cv=fail; b=Ab51222xcWn6NS1ek1h2x8ByPRUez/HqSLcX+wAAhWxHc6MJv6bz2bcoulQ6+a1Ms9jurRopjQHH+P/bJCYW4NjhO8GcwX1WIAcCP5H3P8mUit/lIuMtJqkZMAUfNcq2hBp4HkSxc0m5Kf6JDOrC3O9ntGVVJ/V2M1YH/GuS99U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384489; c=relaxed/simple;
	bh=63GBqObIlK1rxBgjOxIxr4B2n3tBMDJ09U307h5tkYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rp9fnpX7xTAILi/zfS0BEMipNuEv5MKdG4409ahrQHpsIbWwUukEMJNgiPvnnZ0cuXOWS9O5kmq8AA6toO6Ox3CgeHmS9aUqO9yTw34Kd9CjbCZesDQe5jEiFYVoevRcuUSlbPRmkNY3jxqlQXfO1FG3K1tEjolrjWS3HZeX+M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=IaBtFCed; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=IaBtFCed; arc=fail smtp.client-ip=52.101.188.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHW3iu6LC1EZuDLNvPwgO75AlncPjTeOEZlwY0tSnlbC4byJPWWRL3hLcptFNzhP14K70RZdy1/RHKhduM9kgh+PWtNK3tA0FA2KqwGH8hXGLfeLUOy+2fsUq6WFC++kzpnA92yYJsxNyUz7gPMKtAHVfX0oLVVjmbt1s9oI4IaebSVLGDGgd6X5yGYnBjJBiUU/vlxOOspeB6dij5Q2RI7zpm6mQOMz/Oh9MXCUJK2QjiEoYsybThTPc6MxJ86FcPg4Oc/TTxPPQ6F8Be5pm3YGuAtL+1kQ5duXE8Cpg0m0pYwtwk4kjg5YDwUSwmVJ0CAM2EzTHo45lQ1Ut42Mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63GBqObIlK1rxBgjOxIxr4B2n3tBMDJ09U307h5tkYE=;
 b=U+HWNEayztwZuPIDW8pus9UgSvZFC9wQXm1deTCKJT7mD7TbtXusm+Uh2lYgzbevaExzbOy5vb1JKUZCBuMow20asgMoGL8o6BhrYU8+P9YoL0oiluCXbGHt/8nRzpxLaJBtEShc4EafC+Wui3Qu/isPVsOymUdhv9BXSRnh9pwAQiekGJOPQfv/KY+Rcykjl9TFCNPnyPbNclAKIsQoWHQpyUBEFvojWb/hLS5g1wl8oKiLeAftV5lhTH2IbcZKyKu34z+husR80euv4njKnOxkFBdzQO0Splf7yQqzG5o5bjyohJ2EUOSio5bf7nZO3yYJjk6r1uhifZJ4gTSkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=ddn.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63GBqObIlK1rxBgjOxIxr4B2n3tBMDJ09U307h5tkYE=;
 b=IaBtFCed9A4CuJobiXEnmbga/+M0scoDuZSTEok3gwE1IfEshL6/Q7Peo+FWx2rEwBBgyHQjlLl3V7C31zRDifXfuXvDw6JwKT+SaSsX/GdJCop7CCiD1oyrQRHTU/zCkYv0gS6jqXrKilZfwK1fLv5sw6BBVkIF0KQXwBVwdb0=
Received: from PA7P264CA0528.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::13)
 by GV0P278MB0768.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 15:14:42 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:102:3db:cafe::39) by PA7P264CA0528.outlook.office365.com
 (2603:10a6:102:3db::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 15:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Fri, 11 Apr 2025 15:14:42 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=IaBtFCed
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012048.outbound.protection.outlook.com [40.93.85.48])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 5C8477FC88;
	Fri, 11 Apr 2025 17:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63GBqObIlK1rxBgjOxIxr4B2n3tBMDJ09U307h5tkYE=;
 b=IaBtFCed9A4CuJobiXEnmbga/+M0scoDuZSTEok3gwE1IfEshL6/Q7Peo+FWx2rEwBBgyHQjlLl3V7C31zRDifXfuXvDw6JwKT+SaSsX/GdJCop7CCiD1oyrQRHTU/zCkYv0gS6jqXrKilZfwK1fLv5sw6BBVkIF0KQXwBVwdb0=
Received: from GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:42::7) by
 ZR2P278MB1148.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:60::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.28; Fri, 11 Apr 2025 15:14:39 +0000
Received: from GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4336:6bd9:d554:87f1]) by GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4336:6bd9:d554:87f1%4]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 15:14:39 +0000
From: Laura Promberger <laura.promberger@cern.ch>
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
Thread-Topic: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
Thread-Index: AQHbiC78vz1B7dg/NUOfn0lxItJH+rNn26CXgATK8YCACqiPWoAniS0P
Date: Fri, 11 Apr 2025 15:14:39 +0000
Message-ID:
 <GV0P278MB0718DC3A40975C51918E967685B62@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
References: <20250226091451.11899-1-luis@igalia.com>
	<87msdwrh72.fsf@igalia.com>
	<CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
 <875xk7zyjm.fsf@igalia.com>
In-Reply-To: <875xk7zyjm.fsf@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic:
	GV0P278MB0718:EE_|ZR2P278MB1148:EE_|AMS0EPF00000199:EE_|GV0P278MB0768:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c14ed41-1513-4626-a928-08dd790b95df
x-ld-processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?fXxAqoA5A0U5rVuB56hKMmWVVN2A0ikiZbeyq4/sJ8kLkum0N8FNjvgfkF?=
 =?iso-8859-1?Q?8zpOB8t2+4/CR75wYG+d75JWEQy9k5ObrXLMu1DsFOAvkRnheCC9HtBc0T?=
 =?iso-8859-1?Q?tkvVxh9KtQUKQpWGOt1o3FBoIRGFM18jGXMiEEVD8Sr2TCwtvRLZKiCaTo?=
 =?iso-8859-1?Q?dZMNDavTtyqT3Wwu5Fssvlxc7EDQ7kJuGK9pH03bgP4alISQxgr6X0uMsC?=
 =?iso-8859-1?Q?pcNLddJhGzc+Gh97xpj5rclOfsr2z0FHHttvAxf4OomriSBOFaaj4GuR0T?=
 =?iso-8859-1?Q?KZtCIDbPWQ4b8Eo/qeInT2A1eGppDLNdXE95vLbhdYL8z74Ks84xt72vXy?=
 =?iso-8859-1?Q?v0IKUeluerktTKMKxB0Ko0Xw6gLu+lGWyibTQDGsZAFRPfMph+wPH7vxfr?=
 =?iso-8859-1?Q?QytFEyQaVMzBhUeXpPgHhntf1uA6EQrW8zKLYA1u/qWQev3EIns8GO1rab?=
 =?iso-8859-1?Q?dZTr9EEPIs4HIlL19uQUBQ2EL6GxXuYQ/m8zhG0NNMWHeyd1uP5DWuq2A1?=
 =?iso-8859-1?Q?A6Y/rY5UWjltYbUsm8RswHJv61QDN+ZTMYTGHtJnNF1n5bFUGJ2v/MJjxU?=
 =?iso-8859-1?Q?KDZL0dEHk3pgcbCUBZ/EM/qxs9UPGyM/aWzl6Okrs5w8o0WGNrJdz+kRne?=
 =?iso-8859-1?Q?MViehLQgHti24dKPC0ElOJLYAGvZMfaXkpItlsF/LbfiErq23CgrdTPLiP?=
 =?iso-8859-1?Q?lEskUwlX6mDy+8a2VuLpTxAZGCD8Udmx8QdPI07+m147LoXs1K/jLm7mT9?=
 =?iso-8859-1?Q?N2522mJwgNrdrCmcDNjQAvqTVziHH4zxcLIhlCUAOPYZYF0kDVdbRbuaxu?=
 =?iso-8859-1?Q?tpiNUnXGV5dsS5wO96edld+cChnn4cXOw+9YH40Srw2xDiDhMZw2HZhCgb?=
 =?iso-8859-1?Q?n7lmRkiF9okmIWwpFmzm2w+eEVRYIJFYSi7FB/3usnyfzkuOdLGWCdMjIj?=
 =?iso-8859-1?Q?HAG+yBGtp4R5vADzDizNekDlEWvovLSWfrOuqpa81LiPlhbifQsEkcgsXh?=
 =?iso-8859-1?Q?ETMyUvTqb8Ac9R9f+5kgpOhCapDLrIambUxVvfwCeAVEhnYu2Wn4anZmg2?=
 =?iso-8859-1?Q?O9Fk2t71nQtv6BZnRU8qZu7KhJ2tS6RFhcDpKPzMtHlDViDLuDt+J4K5aw?=
 =?iso-8859-1?Q?eZuzKSyG2+Dbqk1e0rIUcEnpH9jZDuNk+piK1Jf88kbKWgyNOgvkSdoS5k?=
 =?iso-8859-1?Q?pcYJWbPrebGsJV7FEDAtai/Cl6vvasXXu5Jni4Nrd3TYOn0V/4TgBPjbMI?=
 =?iso-8859-1?Q?Js+cqul9dssgu+Lj/tNu/niIamgciKKOr7f0c91YBHo2NkNTA5d0/u7E7M?=
 =?iso-8859-1?Q?XA6kl5hayyCzL+h48g4NfpFy7d9NaLWyGvQhfHnyhclZenBhyRybCkAQrE?=
 =?iso-8859-1?Q?c39EA7Qh88T2qythl++vf3FvJutkV5Ep6o56E974Xx0Yxh4Avcqu68ImAn?=
 =?iso-8859-1?Q?2Edg5NIU2GWY5U8QCMw5jujfepXstMFd2Bg4tKI4n26xsvZro/IUbxTNfx?=
 =?iso-8859-1?Q?5Sv5ZNna40e7vi1KK86Bw02eYRgEHfCX40SdBjudUEI1QK7IxucrXKkDe9?=
 =?iso-8859-1?Q?+Xv7jQc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1148
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cbd73ecb-4914-472f-634b-08dd790b9464
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|82310400026|14060799003|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ri7yIdWTwW7o/8v6VKd0krrNowvUrnhhrJhK8KkwjeCnmQMZxdzHNpSKst?=
 =?iso-8859-1?Q?lK/xxUB2Yz3cUqPg6pFjXjFB5Hx8v49RjYc4BU0jf0kcNlduiQ7BorUsXW?=
 =?iso-8859-1?Q?uj4gJToTymjaz4CWX/Mb+uxzOLXDduzxs62BC3clqWe7rH5MxpM2ddtJTM?=
 =?iso-8859-1?Q?h84NZ7QBwmzag3ciBkTBKZkr85h6SEOuUbt9NPeNIYAWEeTj1XjqW0gJrn?=
 =?iso-8859-1?Q?gfF8+BINXg2cWDHzmc3UPTwXi5ahF7qfcH8YopLljCRH0ctm38NGZ9ShrH?=
 =?iso-8859-1?Q?Kg3ZzaqihkVPh9rqYmbW+uJ4j5jUb4fLmAz0tuc1LDNv7xCapBzecoQTuf?=
 =?iso-8859-1?Q?4d3jRU85lOekge05NIcMBFrFj65NEQ9Pw4Kp8bW3nxuEvqurstDaMvFFM2?=
 =?iso-8859-1?Q?x9OjEmaQyd3T12NdXxUbO1L/DiaADn8C4Ex4vMs5rHtYllM/UljhonEhxO?=
 =?iso-8859-1?Q?UrpvyH90YC4tnTqlNKn75HWt6yTeZ1Jw8faGDbJtYX1WCLVHnZFN36g7GO?=
 =?iso-8859-1?Q?EXt61VAvM226y9lZjfKoXFGEf4AE8n3Hubm+BxmwFbbPuPTEF9CKF/pf69?=
 =?iso-8859-1?Q?I9Rm4Jn8ZTjL2/+RkwT3ONJDgn4tzWFgNLW9maDjokCYrK6B+ear/QCkJd?=
 =?iso-8859-1?Q?t6exqWLRN2lRGpXNLFLGLZyRTKHVxBVI0vXM4g5jsJTNntlPykYUgqnEUD?=
 =?iso-8859-1?Q?jYM8h4quxYnucbq9CgMPf9Cfz/l53s9JRYbwBvDz78aaqmDzIzBgIe5gtk?=
 =?iso-8859-1?Q?k2DIrAAd5Kt7r1SBrdtmQsNAn9xPziSrtfkStuZujJIfhvByZBDztgPBmn?=
 =?iso-8859-1?Q?YwsZ6eo+OTp2wMxWUf0MRCAameOAbTjngzzHHPJS10OsExQwsCD51C7s8A?=
 =?iso-8859-1?Q?mClptU9I+KrOJ95WU8zI3mZT6MKwYwx6uQv9HHq5fyIRpvnWsIFoDYQCXu?=
 =?iso-8859-1?Q?mHs+fKvNLlOXGPWmzW6UxhndQu49HvMkPYR1pY/egdQxsf7E6k2uE4abED?=
 =?iso-8859-1?Q?4hRpbWFrkt/pL16bpUE4z5DPiA7bf7f61fftFDEzi3aJsf3snts8WMFlWx?=
 =?iso-8859-1?Q?loJH0OkSK5V9eDX+j4BzB5m97HMU4Sg96MrZChUVDbY0ZhRs/o00UglG7x?=
 =?iso-8859-1?Q?8kXODb4Tvyvf3W5dTFfilLswNGd4sHt1TERh3nTjirt/inoxx9gJM6kHzA?=
 =?iso-8859-1?Q?F/pAHwINzbKQiIBzc6VM5p0Ua7+i7s0psVPfuk2/+RWPmoPRMQ64LMPqpr?=
 =?iso-8859-1?Q?el6kMBQi2/XM1AAAur0xqqgh2Jh84IUSPNOmJmaLLpwFB17sGYmCXE1mIN?=
 =?iso-8859-1?Q?AP6F3rcNTlpv7J5GdFcIsS+fh3k2AtbFFEzfTlbHmChE93vzm0N4AtAjiV?=
 =?iso-8859-1?Q?PGzVCaZy/dAAgvCa5LRhSXeluUiwoz3CjLj2xv2FpeFTGy2Nr6Uot2tzDL?=
 =?iso-8859-1?Q?gKkb00LDcp4j/SSavhv+9EXxzQzKpopANrWirBGYVykg2EyeNNwa07rUeK?=
 =?iso-8859-1?Q?d7SSHbFxsboqXlsq+DdswLkzmpEgQEVst/hjbki6Mf/TSdZEU5jNr+tquI?=
 =?iso-8859-1?Q?5nF4eCr4oc4YlJoKEVldy6uherzmGItWO6Lzfe8s5oiOxjkOAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(14060799003)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:14:42.1917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c14ed41-1513-4626-a928-08dd790b95df
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0768

Hello Miklos, Luis,=0A=
=0A=
I tested Luis NOTIFY_INC_EPOCH patch (kernel, libfuse, cvmfs) on RHEL9 and =
can confirm that in combination with your fix to the symlink truncate it so=
lves all the problem we had with cvmfs when applying a new revision and at =
the same time hammering a symlink with readlink() that would change its tar=
get. ( https://github.com/cvmfs/cvmfs/issues/3626 )=0A=
=0A=
With those two patches we no longer end up with corrupted symlinks or get s=
tuck on an old revision.=0A=
(old revision was possible because the kernel started caching the old one a=
gain during the update due to the high access rate and the asynchronous evi=
ct of inodes)=0A=
=0A=
As such we would be very happy if this patch could be accepted.=0A=
=0A=
Have a nice weekend=0A=
Laura=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Luis Henriques <luis@igalia.com>=0A=
Sent:=A0Monday, March 17, 2025 12:28=0A=
To:=A0Miklos Szeredi <miklos@szeredi.hu>=0A=
Cc:=A0Laura Promberger <laura.promberger@cern.ch>; Bernd Schubert <bschuber=
t@ddn.com>; Dave Chinner <david@fromorbit.com>; Matt Harvey <mharvey@jumptr=
ading.com>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; =
linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH v8] fuse: add more control over cache invalidation be=
haviour=0A=
=A0=0A=
Hi Miklos,=0A=
=0A=
[ adding Laura to CC, something I should have done before ]=0A=
=0A=
On Mon, Mar 10 2025, Miklos Szeredi wrote:=0A=
=0A=
> On Fri, 7 Mar 2025 at 16:31, Luis Henriques <luis@igalia.com> wrote:=0A=
>=0A=
>> Any further feedback on this patch, or is it already OK for being merged=
?=0A=
>=0A=
> The patch looks okay.=A0 I have ideas about improving the name, but that =
can wait.=0A=
>=0A=
> What I think is still needed is an actual use case with performance numbe=
rs.=0A=
=0A=
As requested, I've run some tests on CVMFS using this kernel patch[1].=0A=
For reference, I'm also sharing the changes I've done to libfuse[2] and=0A=
CVMFS[3] in order to use this new FUSE operation.=A0 The changes to these=
=0A=
two repositories are in a branch named 'wip-notify-inc-epoch'.=0A=
=0A=
As for the details, basically what I've done was to hack the CVMFS loop in=
=0A=
FuseInvalidator::MainInvalidator() so that it would do a single call to=0A=
the libfuse operation fuse_lowlevel_notify_increment_epoch() instead of=0A=
cycling through the inodes list.=A0 The CVMFS patch is ugly, it just=0A=
short-circuiting the loop, but I didn't want to spend any more time with=0A=
it at this stage.=A0 The real patch will be slightly more complex in order=
=0A=
to deal with both approaches, in case the NOTIFY_INC_EPOCH isn't=0A=
available.=0A=
=0A=
Anyway, my test environment was a small VM, where I have two scenarios: a=
=0A=
small file-system with just a few inodes, and a larger one with around=0A=
8000 inodes.=A0 The test approach was to simply mount the filesystem, load=
=0A=
the caches with 'find /mnt' and force a flush using the cvmfs_swissknife=0A=
tool, with the 'ingest' command.=0A=
=0A=
[ Disclosure: my test environment actually uses a fork of upstream cvmfs,=
=0A=
=A0 but for the purposes of these tests that shouldn't really make any=0A=
=A0 difference. ]=0A=
=0A=
The numbers in the table below represent the average time (tests were run=
=0A=
100 times) it takes to run the MainInvalidator() function.=A0 As expected,=
=0A=
using the NOTIFY_INC_EPOCH is much faster, as it's a single operation, a=0A=
single call into FUSE.=A0 Using the NOTIFY_INVAL_* is much more expensive -=
-=0A=
it requires calling into the kernel several times, depending on the number=
=0A=
of inodes on the list.=0A=
=0A=
|------------------+------------------+----------------|=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | small filesystem | "=
big" fs=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | (~20 inodes)=A0=A0=
=A0=A0 | (~8000 inodes) |=0A=
|------------------+------------------+----------------|=0A=
| NOTIFY_INVAL_*=A0=A0 | 330 us=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 4300 us=A0=
=A0=A0=A0=A0=A0=A0 |=0A=
| NOTIFY_INC_EPOCH | 40 us=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 45 us=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=0A=
|------------------+------------------+----------------|=0A=
=0A=
Hopefully these results help answering Miklos questions regarding the=0A=
cvmfs use-case.=0A=
=0A=
[1] https://lore.kernel.org/all/20250226091451.11899-1-luis@igalia.com/=0A=
[2] https://github.com/luis-henrix/libfuse=0A=
[3] https://github.com/luis-henrix/cvmfs=0A=
=0A=
Cheers,=0A=
--=0A=
Lu=EDs=

