Return-Path: <linux-fsdevel+bounces-49915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B885AC50DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED64B1BA1E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A872798E2;
	Tue, 27 May 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eSkwACVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB619CD16;
	Tue, 27 May 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355913; cv=fail; b=nyojAIWI2vp3SuM/TB9a1Vgxo9E8EULS+P7EUywxYYyNAwE4Dm68W59BvEyTdamE9AkmEE4r7yn7POG/jyRetzMFtFbOask2xRzAGW6BVtwTC053otroRTr+1bzJIi5ncUghBKuWaaLuuVpIDKlb2RcC7U93eIaDRdWCLeIkXUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355913; c=relaxed/simple;
	bh=n8mF7rRauG9s2g8WCxdqMXa7dLOsyf8xBlNJcn91lic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S6y5sQclPU53dNSty//k8XtkvANQLnW3B+GuPxKPweh0qvswKB9KdDkBe8p/NwZulutcksx+GrKIeE2yPNayLDO8a8mcQvX7Esbma2d+5PhCd7LnVhr5CcPePbHo8jJUyC0Lole2tlK0BZhy2W0HPPjP49r6M+l2L8sac00XLtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eSkwACVY; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pb8WjeO4XqPYPO1/Fxu0R/aL3myuth4+AXEc8nHnOV0vfhMTwCrTlHlN+8i+QrYtlEzfuB3N9WofXkegQTcKQsXavUHwZBdti49EBK50u1mNzvdxMzMA9cAI3Ivf9Do+TpTna3fv7y3HIE3L1lNZyn+XeGBdjqSpky2NxS8wV3mRw7o5NpKf4Txsq2tU9pHXdwuziLBnlzVONGnYvFo1Uig98+SaeF6jtXX8y2vgkcPl8J+lX4c2kBReoJvLjOUxnHvMH1gFSEZj0dFNhUswyqFHW1bVIhqeCPQhGVwkiZCznQpmqEe64oG4KdMC1PZTchg3+q7UpYYKXKRlCZ1QjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2cSwr7dswWSvANtxh4n/jYDXSFX+wFXsdDgnnx7TzU=;
 b=UUN9yiI6RWBIz3lbJ86pyOoDraTjRPuHsl8zu0me8xMykd2LE7yMHeW4E5XfeBSiRsn0Ub4o+H2V5U0qlIgBa4AMS5kQlyvqXXMX2AjUetTzSK9lhuTn2XPqmngYwOLliKnVpiwNNfDv95qbYghBLqjmCSRmVMgTLbFDrUAQ9dpmYSS6d8L/poFlzEmMU5dTjBIYuRq40k61b19PryMtYvkghFo/p8mxH6ayC+DkXiyht8YN8OtP00FcwoK65BlgZlU3HpBaJugPVu8A3z2fPftf5v0ukkxmBVQtBmttJW3/tLq+mhNLdBB0Z3yU/hFbycIj1dSRtVaKPwklpPiPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2cSwr7dswWSvANtxh4n/jYDXSFX+wFXsdDgnnx7TzU=;
 b=eSkwACVYaLoHMrYg/tfgVtjUDrRvxJWPaaDjg9ybC8lp4wA8ovdevmb7A2VdNI1Z3QQAyFcBtXtce9sRND1GlvgLU+ywo+kL2SF3GLDfQxxKSG8xu9qmZMIGZ5npSvnff7yCv9z1ICBuB6M4oyOoiTnVVXqsZJ5l3rKbCOdfQROMKuaboZ66OfyKKqkiQqmohcsLK0kcDtSMEHabNyyjYo9wBUOTz60tx5cv8aQPPE2rs0bUKbtyWhjXjGI39/2yi01ytWYWK/pfj733kcz4pVTfR07WiGF6lzjpZWM556fmZdClG8JkfM31KHsoKl+K3zjxJuzNe9O7s+0xeXarOg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 14:25:08 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 14:25:08 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jan Kara <jack@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: warning on flushing page cache on block device removal
Thread-Topic: warning on flushing page cache on block device removal
Thread-Index:
 AdvMbvrhAHapLL5SQLSXHQ+FhiQIJwB7b58AACZikZAAAg9cAAAAQBBwAATDYIAAAA6IoA==
Date: Tue, 27 May 2025 14:25:08 +0000
Message-ID:
 <CY8PR12MB7195BADB223A5660E2D029C4DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
 <CY8PR12MB7195241146E429EE867BFAF5DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <pkstcm5x54ie466gce7ryaqd6lf767p6r4iin2ufby3swe46sg@3usmpixyeniq>
In-Reply-To: <pkstcm5x54ie466gce7ryaqd6lf767p6r4iin2ufby3swe46sg@3usmpixyeniq>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CY8PR12MB7291:EE_
x-ms-office365-filtering-correlation-id: 22aea69f-2fa9-4f9c-46fc-08dd9d2a483c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/PvPZcV/z9KT8PdYaY5YprCLK2lu8ad0AuBDu3KhF6q4AA9Ay1gSAXfoIebM?=
 =?us-ascii?Q?1DFuIg2YEQo5QAcQSYCCIfxj0PU1OIrR2P8+1Gk5Mfs1MZjilphNdeiZBNGR?=
 =?us-ascii?Q?5Q/N51ES1Z8HdHg4avpfQTlYNl2FFQPx9aBH5jHuTQU+8J2HUDejmT9Wg7C7?=
 =?us-ascii?Q?kRXzsl7LXRRaTu78aeFkBZs5o4DrTCTqYP5mijfyVCi1CLayZhdv7OTJDSDb?=
 =?us-ascii?Q?BinoSHyDC2XdoLLZQdBztiE2RRX/fqGCqL/bv/Y1XTPc6FWjJC5mdDiGQbKz?=
 =?us-ascii?Q?W1kbZfo/OJI2Z35CdAaWQ9n/nPbmdVxgmFAdR08bcL7JJXKHhzXTeQYUSN5S?=
 =?us-ascii?Q?hUFsbg9DrIW0LM2q1h9oFTb3x+KTQurJ7QErH6HdkBfTrCz8XhPAWlspOANw?=
 =?us-ascii?Q?49/M/1E590i/+DFMbHo0jrOsWjQC1kmsbIFTOZvbMQctXVGMT4TZYlDscg+k?=
 =?us-ascii?Q?S/LKpkhNlAoEtVIWcFi6yAubGlSW6dETrk7jIASokqx2gULRWEK3EmAq4Yd4?=
 =?us-ascii?Q?51cd0drCZcevi+MKjjxahlZaWIgHJO4cbVVFg8RPHsu3CSPS6dcT8H3X7tbE?=
 =?us-ascii?Q?JDxPPbPxCkHhTWJFLQoUWVNQ/XiEcAKF7Sk7AO8aDdpNjmSIGbYcQK+kINrT?=
 =?us-ascii?Q?JUj6+IUJZo18DWbS9w0rcgsaRimNtFO34A26exwuPdX4tpWWNoKsVfeVIvK9?=
 =?us-ascii?Q?/tBaPhxu895wIwhSMwU/DfscS9njijTUyN5k2LatgbktCH/2rODmN4m/72qk?=
 =?us-ascii?Q?L8SfI6XwpdgabSmvcRMWzOsryzpbBUBQ9d4aU8I6qFqrAuh6GFE3sPh7Mf/m?=
 =?us-ascii?Q?L3rzH0KqLfzZ6YztVJcmdusW5iZXFallod7ABKuWvYm2zm7XpxYLAE3jvQtS?=
 =?us-ascii?Q?q6Sjzc3vUFo0+d/9Jv5kg2ldZpVh75X0secR/QVtzVploVTub33YmeyGwlzn?=
 =?us-ascii?Q?aQwdQmV9JTIlCP9fzWwXvJ1CxAWEt5E/4idcZw8Pcm2FCWFT9fZGNJuuqnlN?=
 =?us-ascii?Q?n36YQJh4EShYkrye1JHW0JVxoW1Ep1IWQVkekccKm6GLesidMMagWb2uhvrK?=
 =?us-ascii?Q?J9oi4ryG5OBKb/qFCZtY7ErO0ECBQlKTg7FOWiEwKsTiKX+455s8sLrG3sld?=
 =?us-ascii?Q?MXFioZTSkC/s2QvBwgh9/kEOKUEB1XXb4WKwdWh60wEbB8Z1b3p+jAEct2YE?=
 =?us-ascii?Q?iWi0aAoCMwEr/z3m07Vae/zxh4JQG78yOLwhVSRBc5mZmIf3W8tUBusOTH1Y?=
 =?us-ascii?Q?p3k8dvfrmZDqIDKUxRld6c3YXL2l2myz1oBuHlA6rXDjJ/fZeifHWMCcJsFQ?=
 =?us-ascii?Q?nG6f5N3jy06IcKtEM8z7kc9UrviqK2aixPlUuWRUpTdS+mPopmxCq7SDvAo0?=
 =?us-ascii?Q?U5UY+rz1DqZqBQ4q3Hk+7OQeqTL1BcS8ZjE6hmECYO+3Dw0hDMw1/WO8iWNm?=
 =?us-ascii?Q?LWNSINI8MYA57lRYSQDgeLN3/VZFAfkPQvGK+KkQoM3evMVdw+nen2yQX1MP?=
 =?us-ascii?Q?3b2Na0at+ni8vCA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?acJe+6bU7KqvXGiybqJRc2d6ULUDL33pjCWvo4ZPBvjcdqKwIZRgcvjekDwv?=
 =?us-ascii?Q?y9mForrBDYShEM6DnEEFGbtXVxR5YGKOmyw7nEKGk35NSqJy9jSkmWGBfMkt?=
 =?us-ascii?Q?o2hl2lX7vbIEH4G5oJw8+bwk9iKvRoESvQRfVFUIEUcms7o+dRwVKRDxSacZ?=
 =?us-ascii?Q?XXtvfWcCIS5PR+x71RdhsCPK1srGQbxc5QWA2RmcKUx+tH5MFsqwcZO9xQkf?=
 =?us-ascii?Q?vNBP2AppNO2u/ffRQ3uX45sZ01gL6mx6VW3emkPcimzFLWNWTGBxr+L/np8T?=
 =?us-ascii?Q?eOGh0xbfWu+ysd0dYc1CB/qc0hph0HjOsFmwUaK2K5fiByF+VOr2TFaeXOLI?=
 =?us-ascii?Q?Ei9ofvnW8enGnTdOArSjmsaYTMHAbLqUSrm8zO07/91zXNw+8ZB+dLrHX2cP?=
 =?us-ascii?Q?zQBpLb65jexu83d0GCgpL7OI8f2wSu1MuIhgptrnKPCdxRgpJyEjoZlQDpGj?=
 =?us-ascii?Q?UsWjKxXGnq6khRBcN+UQaxjSWM7vdOu6rJyRzlbF6WOWUmxmD7oDU8+vF7EH?=
 =?us-ascii?Q?ae0InWxaC4ycHItiAxg8GHgAfoILkdK+iA1VGAhYclQ9xBTBqQMEBob8Ng1S?=
 =?us-ascii?Q?FlqWCVM4Yu7ybkRpHjqRth0CaXgqwEcwrjBMTlya2AlEnxf8liwMsVW3+WQ2?=
 =?us-ascii?Q?EvTz6ziGbVbXI05r/GTDOjOjIjQ/dH/ISYZ+A2h3GjnWFMYmAOAr9RluDRr7?=
 =?us-ascii?Q?s7Qm8QjBOJK4U4l3aKmZbxekTL2CsvlMumXc+oQfRJjIRpq7ODImFjfmNQfT?=
 =?us-ascii?Q?YvXs2QkK14AOggPdHrGck8zMNiW0czKnFQ1v6NqcpVb1J+qda9zGG7TTzHtN?=
 =?us-ascii?Q?RjknCA2Jl9XVejSJ9aVNC8zEtWLpQhIfC4ZHBmlUTXcpxk9RW/TVNTuqdg10?=
 =?us-ascii?Q?mMWVkpXqAxQHHAlPNJMh8U/MVr0oDPD8UCpAK1vRg7RPL8hfPrQ13iqzDBo3?=
 =?us-ascii?Q?vAh1p1gyGqEyK9LImBpqIV9yGC1SOVuNyJW1G1etZqP3bG4iyr+YMSA9mQ+i?=
 =?us-ascii?Q?GK8M40M0k3XK6J+f8O6lCZCIzqev1exG7QxuodlRnpLnJihnTee9vWd30NKd?=
 =?us-ascii?Q?AHhdvTOiuswqYsM61BJfaSrTozZRAdRmC9v4sL7imSp4nzNanEYT+O8uqe7l?=
 =?us-ascii?Q?2EMhSnwpJiU9Ggqu0kUgOevKkJ122CAX4/2cVWErFaA73FmcE9XeJ/mjzinj?=
 =?us-ascii?Q?aIWRZkC75h+KKCGTEmsyYIc5UxttFyEZCc+fIx2eNaZMJOmUvdlYnSAPwhbs?=
 =?us-ascii?Q?APLKbCSqxv2Hf41rY2EoigPkNM4vE8peX7wUvjZoLQB1UymLPK74G0LK/BNZ?=
 =?us-ascii?Q?qye95365tHVzh5sZbSCtKcj2k4xPJnkWYgca/y785al6Qet7kAxp9zSue8fL?=
 =?us-ascii?Q?cw0oa1Lodnsq2VE4JBIPImoPEUTwPxDsXVgKaSwyjUd51DapH9+unn9/Gygh?=
 =?us-ascii?Q?lLmwNX3hqe/TcY6JUprTWBggZzTmp02cbJmavale0k1Ls4KLeL6noJy4gyac?=
 =?us-ascii?Q?UY/aQpSNDr6abyInNVQG42vpYD+W6d7+U10AjODakGl38N2b88hU6NswQ654?=
 =?us-ascii?Q?f+etMXYrQrGh7dnxMJAL8ARs9zSBDgSlH/GsiNgX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22aea69f-2fa9-4f9c-46fc-08dd9d2a483c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 14:25:08.2495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfpk1TpITjO6vhkksPwpqpGkYegjnSi86O5K32XZu6q5ipleuAeEpKAH1L0pXdjLUotpjaFJ7ClQA9mr9Jr+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291



> From: Jan Kara <jack@suse.cz>
> Sent: Tuesday, May 27, 2025 7:51 PM
>=20
> On Tue 27-05-25 12:07:20, Parav Pandit wrote:
> > > From: Jan Kara <jack@suse.cz>
> > > Sent: Tuesday, May 27, 2025 5:27 PM
> > >
> > > On Tue 27-05-25 11:00:56, Parav Pandit wrote:
> > > > > From: Jan Kara <jack@suse.cz>
> > > > > Sent: Monday, May 26, 2025 10:09 PM
> > > > >
> > > > > Hello!
> > > > >
> > > > > On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> > > > > > I am running a basic test of block device driver unbind, bind
> > > > > > while the fio is running random write IOs with direct=3D0.  The
> > > > > > test hits the WARN_ON assert on:
> > > > > >
> > > > > > void pagecache_isize_extended(struct inode *inode, loff_t
> > > > > > from, loff_t
> > > > > > to) {
> > > > > >         int bsize =3D i_blocksize(inode);
> > > > > >         loff_t rounded_from;
> > > > > >         struct folio *folio;
> > > > > >
> > > > > >         WARN_ON(to > inode->i_size);
> > > > > >
> > > > > > This is because when the block device is removed during driver
> > > > > > unbind, the driver flow is,
> > > > > >
> > > > > > del_gendisk()
> > > > > >     __blk_mark_disk_dead()
> > > > > >             set_capacity((disk, 0);
> > > > > >                 bdev_set_nr_sectors()
> > > > > >                     i_size_write() -> This will set the
> > > > > > inode's isize to 0, while the
> > > > > page cache is yet to be flushed.
> > > > > >
> > > > > > Below is the kernel call trace.
> > > > > >
> > > > > > Can someone help to identify, where should be the fix?
> > > > > > Should block layer to not set the capacity to 0?
> > > > > > Or page catch to overcome this dynamic changing of the size?
> > > > > > Or?
> > > > >
> > > > > After thinking about this the proper fix would be for
> > > > > i_size_write() to happen under i_rwsem because the change in the
> > > > > middle of the write is what's confusing the iomap code. I smell
> > > > > some deadlock potential here but it's perhaps worth trying :)
> > > > >
> > > > Without it, I gave a quick try with inode_lock() unlock() in
> > > > i_size_write() and initramfs level it was stuck.  I am yet to try
> > > > with LOCKDEP.
> > >
> > > You definitely cannot put inode_lock() into i_size_write().
> > > i_size_write() is expected to be called under inode_lock. And
> > > bdev_set_nr_sectors() is breaking this rule by not holding it. So
> > > what you can try is to do
> > > inode_lock() in bdev_set_nr_sectors() instead of grabbing bd_size_loc=
k.
> > >
> > Ok. will try this.
> > I am off for few days on travel, so earliest I can do is on Sunday.
> >
> > > > I was thinking, can the existing sequence lock be used for 64-bit
> > > > case as well?
> > >
> > > The sequence lock is about updating inode->i_size value itself. But
> > > we need much larger scale protection here - we need to make sure
> > > write to the block device is not happening while the device size
> > > changes. And that's what inode_lock is usually used for.
> > >
> > Other option to explore (with my limited knowledge) is, When the block
> > device is removed, not to update the size,
> >
> > Because queue dying flag and other barriers are placed to prevent the I=
Os
> entering lower layer or to fail them.
> > Can that be the direction to fix?
>=20
> Well, that's definitely one line of defense and it's enough for reads but=
 for
> writes you don't want them to accumulate in the page cache (and thus
> consume memory) when you know you have no way to write them out. So
> there needs to be some way for buffered writes to recognize the backing
> store is gone and stop them before dirtying pages. Currently that's achie=
ved
> by reducing i_size, we can think of other mechanisms but reducing i_size =
is
> kind of elegant if we can synchronize that properly...
>=20
The block device notifies the bio layer by calling blk_queue_flag_set(QUEUE=
_FLAG_DYING, disk->queue);
Maybe we can come up with notification method that updates some flag to pag=
e cache layer to drop buffered writes to floor.

Or other direction to explore, if the WAR_ON() is still valid, as it can ch=
ange anytime?

> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

