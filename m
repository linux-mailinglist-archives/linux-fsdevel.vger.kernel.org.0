Return-Path: <linux-fsdevel+bounces-50470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E8BACC7E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8C81895792
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163AB23182D;
	Tue,  3 Jun 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cyDwxgun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05B2253EC;
	Tue,  3 Jun 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957589; cv=fail; b=ZnzVQeZfp5G3T1oDPpQNHnqD6DKK6ySvU41GS70JJ3U86LKyDbH54FKYX65lU6Kc9JhDO6U4NYCbeRQT6AU7pczpSrrnIiSyfqVNXUdt/vUFeIe8dPOBe02BHIS1JiRNYLjVM51nR9dQrL10qlvXSL+Z6JIU4X2vVaxgdw6J23o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957589; c=relaxed/simple;
	bh=5O5pW7wWDl7qmc0YvPgVF9V4SE+IqaRgQ5tZ/dNVjRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fibcdEL+e7Ca7zuTYAMqwScdPz+MZ8gyQjpevlXceABLMJ12o5sbRVlMh76+VB3rnVaiVcSDqjHni49g6P9Ou69Ngdg/Fh+nFV4NYtIvnjTGgOEH4giODWGBPOGLj/r3wx0NE/TbgUzXwUMJL1jMU53P6u5cE3Qv5TJUxqZhkUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cyDwxgun; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3TPDHjjS9MKPSfLfR6oJnovrOvse3WaCwySOZOEuuzLcx7RCZOhiGWLSA+qVao+ZX7CMp2k+QKAw8aUVUcJwI4OHb0SAEQqXLt7Z/+bftX4frrP88MGR7rtUDe3uxuBZCCOfw9Z+wEnS1rNvBvJ+asP2iPlFWMr4tlr+x8CmpXFuZmonlxtphNr9qjcAEmvSoZCV87Sbb3IDMhSi7Kvr+gyOlyL7ZWkpOwPKu4+ici/sjrOR4/mVFtA/EpquEK8H6RSeUgKwyzLBDjfUAswQ7BTQkZUG0P0TLTY4QpKJ1Fn/j9gT9EEwbPasZvrY4aPGXdSmIpsPThOjhYvz+4vPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4kywAxvBWbWQn+61aiYS6gS/NOZR9hihycGCIQI5QQ=;
 b=K6njZj5yP/+uu8ocbSuQsp9tCbEqMqJGZkP8aliFMa4xy5fVG3Fz2BMVbxKrMJJ4SaIDMEQLlUu+4XqMfAqgY8GnmSjQ6QH7VIBDFv3Iwk9dhwnCWIb8mtiMyNdvwJvfqIDxSV4gqYkXDLohdnVcyqaEG7T7J3xz/rrYk7F8XaS1MQvUe9JUd8/18X7NF/7eIyOw/Sr8fWsz+wq0TRKkokxzFNVq4SwAqMs6zvjzJY2agi+6OaoMma1AWit/TJZ0FJVj+DztXWehEj8WmLtREsm9KzAQD5DrHemQp9qVZDHRl2Z6sPsc3lnwF5ebSepZfa3/4ic9VvBpo0mm/r4fkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4kywAxvBWbWQn+61aiYS6gS/NOZR9hihycGCIQI5QQ=;
 b=cyDwxgunpt2dQzWRgdVpQoQAe4cUGdouEQjTGd9QvyY3EIkDNQCRBXcS7/9nU/tfvEPfwx3t1PPAwaudMe66ZzBbZK5QCOjbyufHKL2Rgj1eAce47eEqDvVWvozVcPMlZRudRuEy80RZNHoNHfJ/aAWNLKm52nlQ3MDENAnVN+30CqIcXS4tuVyxNeq+YWuhjOES6w1f7l1FjXNWFJA6VzRqm9c+0tlQb+li1+Ftv356yl1+mlCigHWFxp+wFqAmop2JlPHDDqtvRbd68ZzZTwAKN6AYSv2V1XeOUuQopQbsZAu0eGH4n0kw/e+tewMMj+pay6eNBRAiVuOhTi5wqw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:33:02 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Tue, 3 Jun 2025
 13:33:02 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jan Kara <jack@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: warning on flushing page cache on block device removal
Thread-Topic: warning on flushing page cache on block device removal
Thread-Index:
 AdvMbvrhAHapLL5SQLSXHQ+FhiQIJwB7b58AACZikZAAAg9cAAAAQBBwAATDYIAAAA6IoAFeHfSQ
Date: Tue, 3 Jun 2025 13:33:02 +0000
Message-ID:
 <CY8PR12MB719567D0A9EAE47A41EE3AC4DC6DA@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
 <CY8PR12MB7195241146E429EE867BFAF5DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <pkstcm5x54ie466gce7ryaqd6lf767p6r4iin2ufby3swe46sg@3usmpixyeniq>
 <CY8PR12MB7195BADB223A5660E2D029C4DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To:
 <CY8PR12MB7195BADB223A5660E2D029C4DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA1PR12MB8095:EE_
x-ms-office365-filtering-correlation-id: d86ad8d3-83ad-4b06-c72e-08dda2a32a0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aQw9Ei05oqaxhJqq1cJ+dK2zdtJPnjlh1cBPEoelM/Y62k6uiJjEGYPaoGdn?=
 =?us-ascii?Q?Y03D1nM+a5fIo/V8JtmQ3QzLbj1HsABg2Z/FAFo1Z40zCKseZbJ/4exhJLZM?=
 =?us-ascii?Q?z4wCeHYmp17SNOv9/XQi/C2W8ZaaTCzO57VPJiwsg4f2TmQJHE3N5Nk1BZcg?=
 =?us-ascii?Q?u9D/EKxSq4aQXL8VEKXEzt50pwFom9qh3560nApYNvrUtmpqueFbiZ6JtFLd?=
 =?us-ascii?Q?jzdz/qKnExC3rtX2194Pb3/q4Vt2LwmHYBpQd7B2ZvxMaLJZnGWiV4flPQ6X?=
 =?us-ascii?Q?h+z81fiacDn+gUtI2Brd9034YfvKhlWvbBKlW84FSBkZVyiMgrj+6LZIYjua?=
 =?us-ascii?Q?BtWKk9YjCESeBp90CsPtmeO4NLo7izdBhMKucBFgu70rpSJadV0uq3cTojGP?=
 =?us-ascii?Q?vRsT5I8q3QsPpNCwCErFtx1HVVan49UrMYU7BshG8J4dlwcrW7sChjM6u59L?=
 =?us-ascii?Q?HHLylmt86N65/1dJJocJ4j5pY7GUQcmszO+AQeGz+8pYxIiLQmnGQsXfyR6S?=
 =?us-ascii?Q?7yCmwAGaAONLfBogCMdbF1v3hvKya8XlDfR9WY7Zl9/3equdG+OOHmVKo52q?=
 =?us-ascii?Q?TsK3X49sSEoCuqI3p6AiJes31mYhr9GYA5ng8wiPjUqBPczBYdYBzCKjsnRR?=
 =?us-ascii?Q?q3d4aDijJCsMJVw8Hh4GsdQAptcutvqm5a72C2oKkb/0HD83pOjDtmTQYLbR?=
 =?us-ascii?Q?BcUlwR5eIc26ivH2QkdbtZq4ZOOL+GXJ5ndOuBl+Z0pgC3rSzOm9BN1Hjjs6?=
 =?us-ascii?Q?fPF+3b+8BgMcC3VBG26w4nL4HyI1BFll42bGMp2mcNhWC0odpRqCJlfaHTf1?=
 =?us-ascii?Q?oQWxDIcxgVi/Qgvu8omH0BTU56WvO/M0rY0mUZ+74K/LQ0NI/QsUfKCvKxt4?=
 =?us-ascii?Q?jAzg6K557ZpLDduHqi1r5RHyI4twRwSVTWbaSS5kju+LP3Jc1QhQfEv2XpsS?=
 =?us-ascii?Q?+dDXbtN97wEds/uRbjs4KAI1IjYyRutHLDSXlNhHGbxU5K8rViaVSvSQe3/2?=
 =?us-ascii?Q?x/k2txKT2aBk76nhzylf99Q2GLEYwPfwCzKkWyDRc+m5iRnGLl1/Ry7qBisx?=
 =?us-ascii?Q?uSyeJ3sEr+3thOB1MyIc3GjnL1e/sIGyw6ldtxgsSz25o+UKgIn6aYN6Ai3H?=
 =?us-ascii?Q?soqNdgbNLQ6O22FyOdNiq+s4s+dd1hLnHVWs5HuEwz+IlBLHZaD56TEVjS2a?=
 =?us-ascii?Q?+KepEQAOsAcRPTKwui9H/48O+rNnzJXfi/eDFpMjC0khAi+YGpkD/evcA6ms?=
 =?us-ascii?Q?7DaNzleTqW+q6Gj2JOdEl2GFxPpaqDZDcCGWabsUbxfmDyX9sORL5O1m18YY?=
 =?us-ascii?Q?hJSW2m6zhSVz2lucsVmsTpoy3MinxYwFLR6apRDn0wehdncvflG8IXF7oJKp?=
 =?us-ascii?Q?bwMVYEcq8DoTLeeCLrnL/SEBKr8lEUcAQ57+0OZsXvKTQwQZb8qxRCjCerlr?=
 =?us-ascii?Q?LCxqugQRoXKWo7kggFEbwh9++2g5wYnGru3DIGNu7GcnMSh0QpxFkXwbL70n?=
 =?us-ascii?Q?sd3yEfmduVB2Tnc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RzoBWUBkc98AGiHdAEYxSTQuL6EtKX3JIw4wCTUu0LE3ib3zxMBNkePL5J0P?=
 =?us-ascii?Q?PqG4kyfM+jTwfoKOpw6i4elFf3fEycOcRol3SR2W0L9DdtJ7G1HTeF5L6aEq?=
 =?us-ascii?Q?oFzyEcxaQqPC1GLIv8TOhOfFmW7BxXCtcLBG8q1vTD0/izo5jDOAKVvLwxuV?=
 =?us-ascii?Q?JMNtnEzZopBx9j8usy5uvQYbBQNGiTkpY06fMPqmOmcY222wM6N91jMVjYPh?=
 =?us-ascii?Q?FXIlmv+JuCR2gJw5v4labpe8faO+t0EZlby56791KH45apBpvjhIC7Fu/GN3?=
 =?us-ascii?Q?vcR+pgNupUcnvSDt2f7/CYwye6qcsols/um4uuoyv5rId3ovonKccSAZuraZ?=
 =?us-ascii?Q?Vw+JnVjy9ZToq6BujTg7qMJCzxafvdDt1aqC75fk49Y1kFltLS8g4AOgQsyT?=
 =?us-ascii?Q?h4J/q3Js7FuhapPuy/YzxfxurSoA5McZK+J+JFqtRBESG5eHzNOyiJ4pDKGC?=
 =?us-ascii?Q?5DhZCnBnDRqd9878iqqN7a2ZrYmAkT+mPuM0+aIB9Zhe5Umq0rMfDvCjeHZO?=
 =?us-ascii?Q?zgXuV4q9r7chyAfhhFvXMHj30RIJshqRqzdpCVE1EJVK5uAsi4D6NCQAWrYJ?=
 =?us-ascii?Q?abfB221GZLwQJ1VgdiRXKY8rKxrGOj0DjBVh87a48ffcPgvk9v2T50ykcTCW?=
 =?us-ascii?Q?gGgh/EZyBxbv1HEd09ipGPEijFdBviXGUUXoWIE6YAZ1cbbIMuYs2WpZsBBP?=
 =?us-ascii?Q?Ruu1E8vMq/VW/Y/cbIZsMa2EQ5i/5oXtFw05Vc6469QgVO3S1+4SrKvOvJtj?=
 =?us-ascii?Q?e4nrg1ocEP6Fmi8QdeH48o9wmYNTAdhjJZevXuDlmxDkfOWHFJvGNn+EdNgt?=
 =?us-ascii?Q?rXQ70kxJ6Lpc7xsPkPTGFqJm0lUjfXLQhpbPMTz/Cn2mMH6w+5OUFQQOL244?=
 =?us-ascii?Q?913BTCO6SDI2vfcnWPwqlq4Fckxe8dR+dnNRSWSDZmbRHdvnWG0Q9Ywsq8Tx?=
 =?us-ascii?Q?yDzUAQjXmQu/urw84+eVpWxexlBqhOC7SM8WMxKpKF6fDbU/M7TZyaUo7U30?=
 =?us-ascii?Q?Lkk6Vxccq8LZ3tU2uvT0FwspYw5o2vpzCVbVI6m/ObfJWEz4K7sqebOI/g/z?=
 =?us-ascii?Q?FUzA3it9jL7kuylkAG9ZX8lteVSzL3jdcoSQ29hv0aKmho3J+1Az2iWNtwIB?=
 =?us-ascii?Q?Tr8LXurgOr9wrVLWTsOhQRZ6T9OJ6DBHn/fLFsqUqn4Aoe3z1qCCsljcrbeZ?=
 =?us-ascii?Q?yLj/LaEc2lXH3MhgW/V+mhzhiZ3XEgLO42eFoywzGv4kxImXvsUyqiCasY1y?=
 =?us-ascii?Q?QxVGJDZXq9B+p9OVzTEvbpnzBWCj72i55oFUIs938FdHY2jZyE5KKZlOJupW?=
 =?us-ascii?Q?AZnSUzemUs9MZRDMsE9W0Zx6cFNCLYzGFCkkDqCEx1Mpo0Vc173I/3fxjfm8?=
 =?us-ascii?Q?tDi5vRm/pburhSAhyNmV2SfppMmajF247+HGVT4eysa2FPJTjN14zTGvnoCK?=
 =?us-ascii?Q?mN/FQaulrIA/BvwwV87pmTqr+FAwqimiiDtUy/rjOU28U0a61hoPx/gA43JX?=
 =?us-ascii?Q?4trEkXKGa1+hr8KQPH9ggPWgscOmHs816CMBIoonb+I7oj6s7uqF63sKJTX5?=
 =?us-ascii?Q?BJQHvpB0CbXkI2HmBGI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86ad8d3-83ad-4b06-c72e-08dda2a32a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:33:02.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHqmWOC0H/ybQ2XwMCDNlJDO4N8Qxzm76P2laan0zA47vX+o0sNIUW/ZypySwsX56w5RdZBHgJ+BcEsFo4EV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

Hi Jan,

> From: Parav Pandit <parav@nvidia.com>
> Sent: Tuesday, May 27, 2025 7:55 PM
>=20
>=20
> > From: Jan Kara <jack@suse.cz>
> > Sent: Tuesday, May 27, 2025 7:51 PM
> >
> > On Tue 27-05-25 12:07:20, Parav Pandit wrote:
> > > > From: Jan Kara <jack@suse.cz>
> > > > Sent: Tuesday, May 27, 2025 5:27 PM
> > > >
> > > > On Tue 27-05-25 11:00:56, Parav Pandit wrote:
> > > > > > From: Jan Kara <jack@suse.cz>
> > > > > > Sent: Monday, May 26, 2025 10:09 PM
> > > > > >
> > > > > > Hello!
> > > > > >
> > > > > > On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> > > > > > > I am running a basic test of block device driver unbind,
> > > > > > > bind while the fio is running random write IOs with
> > > > > > > direct=3D0.  The test hits the WARN_ON assert on:
> > > > > > >
> > > > > > > void pagecache_isize_extended(struct inode *inode, loff_t
> > > > > > > from, loff_t
> > > > > > > to) {
> > > > > > >         int bsize =3D i_blocksize(inode);
> > > > > > >         loff_t rounded_from;
> > > > > > >         struct folio *folio;
> > > > > > >
> > > > > > >         WARN_ON(to > inode->i_size);
> > > > > > >
> > > > > > > This is because when the block device is removed during
> > > > > > > driver unbind, the driver flow is,
> > > > > > >
> > > > > > > del_gendisk()
> > > > > > >     __blk_mark_disk_dead()
> > > > > > >             set_capacity((disk, 0);
> > > > > > >                 bdev_set_nr_sectors()
> > > > > > >                     i_size_write() -> This will set the
> > > > > > > inode's isize to 0, while the
> > > > > > page cache is yet to be flushed.
> > > > > > >
> > > > > > > Below is the kernel call trace.
> > > > > > >
> > > > > > > Can someone help to identify, where should be the fix?
> > > > > > > Should block layer to not set the capacity to 0?
> > > > > > > Or page catch to overcome this dynamic changing of the size?
> > > > > > > Or?
> > > > > >
> > > > > > After thinking about this the proper fix would be for
> > > > > > i_size_write() to happen under i_rwsem because the change in
> > > > > > the middle of the write is what's confusing the iomap code. I
> > > > > > smell some deadlock potential here but it's perhaps worth
> > > > > > trying :)
> > > > > >
> > > > > Without it, I gave a quick try with inode_lock() unlock() in
> > > > > i_size_write() and initramfs level it was stuck.  I am yet to
> > > > > try with LOCKDEP.
> > > >
> > > > You definitely cannot put inode_lock() into i_size_write().
> > > > i_size_write() is expected to be called under inode_lock. And
> > > > bdev_set_nr_sectors() is breaking this rule by not holding it. So
> > > > what you can try is to do
> > > > inode_lock() in bdev_set_nr_sectors() instead of grabbing bd_size_l=
ock.
> > > >

I replaced the bd_size_lock with inode_lock().
Was unable to reproduce the issue yet with the fix.

However, it right away breaks the Atari floppy driver who invokes set_capac=
ity() in queue_rq() at [1]. !!

[1] https://elixir.bootlin.com/linux/v6.15/source/drivers/block/ataflop.c#L=
1544

With my limited knowledge I find the fix risky as bottom block layer is inv=
oking upper FS layer inode lock.
I suspect it may lead to A->B, B->A locking in some path.

Other than Atari floppy driver, I didn't find any other offending driver, b=
ut its hard to say, its safe from A->B, B->A deadlock.
A =3D inode lock
B =3D block driver level lock

> > > Ok. will try this.
> > > I am off for few days on travel, so earliest I can do is on Sunday.
> > >
> > > > > I was thinking, can the existing sequence lock be used for
> > > > > 64-bit case as well?
> > > >
> > > > The sequence lock is about updating inode->i_size value itself.
> > > > But we need much larger scale protection here - we need to make
> > > > sure write to the block device is not happening while the device
> > > > size changes. And that's what inode_lock is usually used for.
> > > >
> > > Other option to explore (with my limited knowledge) is, When the
> > > block device is removed, not to update the size,
> > >
> > > Because queue dying flag and other barriers are placed to prevent
> > > the IOs
> > entering lower layer or to fail them.
> > > Can that be the direction to fix?
> >
> > Well, that's definitely one line of defense and it's enough for reads
> > but for writes you don't want them to accumulate in the page cache
> > (and thus consume memory) when you know you have no way to write
> them
> > out. So there needs to be some way for buffered writes to recognize
> > the backing store is gone and stop them before dirtying pages.
> > Currently that's achieved by reducing i_size, we can think of other
> > mechanisms but reducing i_size is kind of elegant if we can synchronize=
 that
> properly...
> >
> The block device notifies the bio layer by calling
> blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue); Maybe we can come
> up with notification method that updates some flag to page cache layer to
> drop buffered writes to floor.
>=20
> Or other direction to explore, if the WAR_ON() is still valid, as it can =
change
> anytime?
>=20
> > 								Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR

