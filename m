Return-Path: <linux-fsdevel+bounces-24830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF9494526B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FAB1C22AF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3B1B9B4A;
	Thu,  1 Aug 2024 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="YzSQNRaC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="M6Ct5Asv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF591B8EA6;
	Thu,  1 Aug 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535108; cv=fail; b=pU3iCEhSRb0xPRYHo1vbIf2/Xoa1oeeH/sW4TIDw2JqBVRB/kW3QEt+lKtG2EJtkDUGprfB23ScA4rYAOk/6ZZBpXodg2NXJ0TButMoE32OFuG4bC4YfjJtSkdtM+e8Hv9kKCCSDMywYFwxk2bxInPbCjq89w9TkrhlBMgz3p/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535108; c=relaxed/simple;
	bh=lYT7LOaB2m2/3Qr5zE2mneBXXemJt3n96qCiiEMWmwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B++ELO36VwzVpNzT5ApuQkITCjPvvSHKGL82KAJWpj6YUyHxoIyeh41oxrsfsuXcEm+r7c7sGBdbbGW2USqzTqnNnkumJ7Fm0pPyP9/m3pF2rOyRa2E11TAYsvWU491I4LV8j8UVBH1CdmW8/4uOuJCLdrHdWPLxuSVsPqMsfOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=YzSQNRaC; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=M6Ct5Asv reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108157.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471BkoT1002765;
	Thu, 1 Aug 2024 10:58:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=Pl0lwle3dbsxaHvM3DEpDWjWiLGjvwl1rD98I7koxjk=; b=YzSQ
	NRaCPjRE44RqOt7fhfeYIUpUhOjkNruu7cGaPG6SS3CiP6LXW4P63ac+BaAsPViY
	BVAVDX1E8QEs+GmB1eF9loFXkK1gZ1F1y2/BDTGj9SDP1UmKY+TTVYf99IA3wCOr
	oUe3yOBr7YSbNd5z1Q7EWuSS4byPGZOkJRsnaTZXdlA6797oPjC2S8/VWVGvHvT8
	0YM6ETD4Ux/atbHZhpOLXVWUHQMD/xtqT5LH7+NFvrgN7Jz/wKJBTR4/fFyOJCw9
	tBQkw0UdeMEz85d2CT6nB6j2iow4NtF7PpnxtcZrOASy6Fi3oq5946x8tEkO6uNf
	CT25Fc8RV14YbDNjwA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010000.outbound.protection.outlook.com [40.93.11.0])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 40n05h3yms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 10:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mib6ffPToAQjArBtl1tTpT/Y/Op9EKwHwHC/xeuOmvD3YXn13nEeGS5wlWHMLKSu7iU9QFaghIGcYkwewwL9ZlItvyieKr9Ig1J2tbOKCdnau2KqSPZgKWHbZX932SBTQ4DLhguSPyU6tSKNDya+y8bgZJv6GeMD0OyXDHOqVIwDtg/Mx3i4ZOn8mz32YQp54lMx4FEABDlpzpkefxuV5PyrKcepR6whBKczk/nTivyNUgNqm9KsVkUXg85VlKbJLLqUa08o5PG3OHCCAJ2ND99txEpzd2CdEUlq+DV4wEXkCV+mkYZSEExHWiV4BLuLoQ8Tb4I1o7VF3czFt2XEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pl0lwle3dbsxaHvM3DEpDWjWiLGjvwl1rD98I7koxjk=;
 b=cQxhZj66xRNLX7LMHK6WrtySeMcOqUPFC0xyrbdW6CIEI0F3jjck3tWLzIpivagMxb0aCPZfZi1QTtjNZ5a2pjHQlMIFtl36rHxvGPgwjAptxTsW7F6JXEp//aABAx3s7lV6MXrE0qkV/nIfx1YvilnYpEenUl8XUoLXzuAY95iDH6gyttZLqHB2Ao12wnbl46S1JOofew/YSfPsNgiH4IDaKRGqNeD8ZXktoz4fPu3ps+OpGqwR2ZCndvK4ID9W1UT5SXNrpRlBCNRBofjajorLPs1MjZxPausGpne6IW98tccx1LMV1soCs5Of/aWCoIObfYVI0cWA4aaVFByQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl0lwle3dbsxaHvM3DEpDWjWiLGjvwl1rD98I7koxjk=;
 b=M6Ct5AsvwyVPZEXsjqnAgTaBLVj9vQdD1nInm2r/BAbEpQTxwjOkOjRjBunZl/mOQXmYxfdzqUf3Osx1xAZxneP2p8dt2qmqqm8YRWjeXhJMl5Gok8KHYbaV2NOFmgw3SIEtsGYPliXGR690r+36wRSA3FrGmpCU6Qa2xEup/ik=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by DS0PR05MB9678.namprd05.prod.outlook.com (2603:10b6:8:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 17:58:06 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%6]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 17:58:06 +0000
From: Brian Mak <makb@juniper.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa45b60I7pFn286ESFEzPKiZWp67IRtKgWgAD81YA=
Date: Thu, 1 Aug 2024 17:58:06 +0000
Message-ID: <4B7D9FBE-2657-45DB-9702-F3E056CE6CFD@juniper.net>
References: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net>
 <877cd1ymy0.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <877cd1ymy0.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|DS0PR05MB9678:EE_
x-ms-office365-filtering-correlation-id: 7ba998c4-9be4-4d8b-f0d2-08dcb2537f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6ff8tI9upEY6vA+eFMNr8zPvDJkdR3qsy+Jj9vDVSd2E1y32lTXOiiqUu5xe?=
 =?us-ascii?Q?wtz5hdmZVPg8DxmG2Ze7WzqFXbR9raxLc6m9FAUuHGzytL69dOLSUjlic1Lc?=
 =?us-ascii?Q?9//iKAxUXKZMHTJzm4pPAvnOrgj7zVYp+xOX91/Jjiq77jPyEvyT7MvugeLR?=
 =?us-ascii?Q?QK1SRatI+Eq3DzIpV6ZBJvPukn5/P5iztpxXg/fMUIAWzKoHVvPRPw1c6NAi?=
 =?us-ascii?Q?YP2NhU+aB9Dyfj46Qh+giAoS3Guol4aYQ0gfv52a08/CjB/ayEn1iIuvA3oH?=
 =?us-ascii?Q?1GDBmiDYf3lzRREsnXcdVlCUfaxJ71Vw/sUSKLxSyavYm5snDH/2jqe0IvP1?=
 =?us-ascii?Q?fS1akjiAVbHGDtJMqlY4eQt6/ieLBfvoocH1Tc5dXFeV0xDNJjNLHKKPPQ2M?=
 =?us-ascii?Q?8oIm7Wue4lumv22fjKPVtmex92Ly8hs4aAOrRPLo+UDWT4IcUfYLfoZQTa9u?=
 =?us-ascii?Q?dYUZidP/qvUzF7Im+dvI3lqQ2blP+VuvvG42BlbEKy473aYh+zlg6Haj7gDt?=
 =?us-ascii?Q?22zu8GzG84hlmgtHHkkEFNlVpvP3Ubqn4xdqayGPWUG063AEFkYSKmmxTeyy?=
 =?us-ascii?Q?AlvtY40fCDdXYsT9ONEvfKt19pnd5W7EWCPvqOI1BsgLIL4Xp/eSNCeSgc6H?=
 =?us-ascii?Q?ejcpJ6XpT8pu8vGWUjKKTkDolriqk13kfq4LNshXpr0lPO4BTzv/9Df6PNPj?=
 =?us-ascii?Q?sy5BCoDWV/MSnL5oFL/IOiT77bQ/HWxmTXU4JMRfZ74GVU0KMnlWjTf7y8zk?=
 =?us-ascii?Q?7hCqfPTlv2WravCPtVP4sWlUEzVQMIcaZemnT/DTc0KMHPHQlgpEeY0yTp2H?=
 =?us-ascii?Q?jcKAb50AmhAy89kJZllM09nBLvUAyI5RrNn8BjqLr/osC0ijuQdgyj8ttuzM?=
 =?us-ascii?Q?kcLYI5VbitVBOPH9DD4GlSXz7T1NYnvwLkmbZw5FUtocRsamo4Uw6JV9Tota?=
 =?us-ascii?Q?OLQhK7e3yS0l6qey7KiU1cKYNN1LVFZ+UKVDrXSZWfa67c3PjsBC1YdCro/Y?=
 =?us-ascii?Q?bTVbs+taCXMarm8WndfXJC8Lo/rSmmtbQWoqlV+Aim7wxIGVaXF7Un9Bf46o?=
 =?us-ascii?Q?Tq6FaR01r47s4Z0BJNYmKDC4I+JRJCViG4EaZDSkxmyvLu3wRJY+wlLgp9x8?=
 =?us-ascii?Q?awN2JGkMMKCM3f2tTF/bneklk+eXszn8zWaK8GTdd0yL0NtqP1sBSwWT9mku?=
 =?us-ascii?Q?rl1A62n0IiJaNNWW12jxKxFIkS3tHMyEfuwuSgMA+4fU8HB70lJ3gpb1hJ9H?=
 =?us-ascii?Q?lW616OVsuoF1paASyw6KGjSJ9uVsTex8VC2Q2+d4PbjBxKa3CHuxYMp/ZffM?=
 =?us-ascii?Q?t97S5BICRKDvXFs84ExUQWDMDrZkHw5eciUmr98yXUgV0GL9hbKmGspiQfky?=
 =?us-ascii?Q?lMzXqRxEOqcepNe1CaIshiMEzzw3tKw2SB7BUj9nYbY1W+jBLQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KCjB1t/PTUlXJ3JSUvkFIVSTndOh53UWihhgsiGA/YZALiy/3YO+QkbgJtCa?=
 =?us-ascii?Q?q0p7+e6Dom2uQrBKcbWtAyAuRPbBNzJfbG4GWUJUpampMsb4jOQmMl3vmrJ4?=
 =?us-ascii?Q?2m4CxrtTobyG/85W0jylxBw0EOvbEIrQRlW0ja8FJ99Te4ys4W/7JP9a/EVv?=
 =?us-ascii?Q?7TV3oHFFavwEdice3O2m2NRu4V+LjM9Bb2q1p9pq+b5Lkr+Ax+T9lOuJs2hH?=
 =?us-ascii?Q?hquxU3vBGrSTJWcMEyUVH4LtZHs/6woyzUX/niVWCe7XkkVoLA3/u0DSlnSb?=
 =?us-ascii?Q?XpQs/huh0OHQq9r5WxTcEF4+vLU6+dqRdC10YunOejLDiUozndLtu6j1noBC?=
 =?us-ascii?Q?8RmL6GOIrvNHngbFj8mcc306e70nGJSXIgDxThL32U1L3a50Hl9KIDLkcEdX?=
 =?us-ascii?Q?L6xbLUljhmhelFmReobDQjEu6swSn51AnfOnMrQzQTJjBmhGbkO7ajeZuHln?=
 =?us-ascii?Q?an9q2409EDNNGGsF+70KVEXki+D5evnp2cReaGrPNoYbMcMdd2NQr++xZ/4O?=
 =?us-ascii?Q?DLOHnYavsdsjnNALoz4fBEAMZek4ruR2UL2fC/oBRf4ucahRs/y3NAtb1faJ?=
 =?us-ascii?Q?3MgANmOHFFHBCm7o9b8fozMPYAGXTvpwIcFqChRSxTZIPBBmxesEoM6wcId7?=
 =?us-ascii?Q?0/e/5N6j1bHFY09Xwe2MFIaDlJB81vlR/ce8IyTU0Z+TCKPiL9DRW+Y5c1+K?=
 =?us-ascii?Q?xx06CP8kxAbythY/PTiGxbRG2oLj0BkIIBGGPLcXv5S91QnBUU/xuh48Ws6y?=
 =?us-ascii?Q?Y1AOL7IY8Isk1smQufZXDlrQd7gA4i9ycpY3tPNhflY5+HjNtr6ZZ02D2Gmf?=
 =?us-ascii?Q?s7moe5sR7hOeCovUV5ViIAC24QyisNEe09xT6e/8nt9MaGpR5EOATOdgJJ/U?=
 =?us-ascii?Q?52wjGrMc/YJvCfTIn1FgI3ue+STiqi01XrHXJoggsreCZZ6POBu3p7vAYFyV?=
 =?us-ascii?Q?jgBpDsqKKK5BB/qAcBysRt7ZlALREFfROIlvFrZwirweEF8zCdK0yQBWLhJJ?=
 =?us-ascii?Q?qs+mQBCSoj5PFT6hnOj5lgjAi/SVvyWUDK2I82Zs10rG0K1Uez8q4+8BOwBZ?=
 =?us-ascii?Q?D2BjhdvQMuQV3Vu4JVdeWP5Vff13341QQZ1dAKKj2dIj56fMM6EorX2sjOSw?=
 =?us-ascii?Q?w23DjbTdtL/STfLGBdrfr1r0le8iWdCp17zgVZDpwfqswUe7du6kDEDfCgZu?=
 =?us-ascii?Q?ApUwyLESiUU1ZBWo1D8XjjCzyf68tVqD1XaajBJ+kEzxM3FwMmXtGHHn9d0f?=
 =?us-ascii?Q?HQVj+gd+Toc5g44Xcs8VAAzKBnJlKQHW+NXJ3thUenQMMr50KDiHd4E9rN/5?=
 =?us-ascii?Q?8TypWwHQ5Cw+/VoXPunHjCq+HB//p9/Yt03fpgpkcrIOwymHn8yHq8PImmam?=
 =?us-ascii?Q?PWuyID+9LHaWugO0sFAlBRJI7msJ0Gm4q86ev2fZzEcUYra2iB+E0FMmLPbW?=
 =?us-ascii?Q?T36iSu5vw9IpdNIf3NFyLk1qy+ZtJ9e/6vNoFD3oiZ9YGqX0wBlWa/bJq5yf?=
 =?us-ascii?Q?ibW3jIKzsUiDMM+j0G1P6Z9mSg0I08pgOy8jQvC4H3hkFtQKZQ+E6V8KrU8G?=
 =?us-ascii?Q?cVQwGyGtqbnzl4VhbCCt31B65fP3Xew7A8Sak68s?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13E48468060AB44CA1A39818487CFEBE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6743.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba998c4-9be4-4d8b-f0d2-08dcb2537f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 17:58:06.4079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1E5S/kSgeIK+XXEKdWEy+j1tG+Jh0EuRra1roCuAQ/W7qrxWgU3TdJ54uEyqitOG/Rf6PPM1V8G1Iljm+bkpDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9678
X-Proofpoint-ORIG-GUID: XJlgHlZACqUNBc8jFj1yK5nlWh_w9mhE
X-Proofpoint-GUID: XJlgHlZACqUNBc8jFj1yK5nlWh_w9mhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_16,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010118

On Jul 31, 2024, at 7:52 PM, Eric W. Biederman <ebiederm@xmission.com> wrot=
e:

> Brian Mak <makb@juniper.net> writes:
>=20
>> Large cores may be truncated in some scenarios, such as daemons with sto=
p
>> timeouts that are not large enough or lack of disk space. This impacts
>> debuggability with large core dumps since critical information necessary=
 to
>> form a usable backtrace, such as stacks and shared library information, =
are
>> omitted. We can mitigate the impact of core dump truncation by dumping
>> smaller VMAs first, which may be more likely to contain memory for stack=
s
>> and shared library information, thus allowing a usable backtrace to be
>> formed.
>=20
> This sounds theoretical.  Do you happen to have a description of a
> motivating case?  A situtation that bit someone and resulted in a core
> file that wasn't usable?
>=20
> A concrete situation would help us imagine what possible caveats there
> are with sorting vmas this way.
>=20
> The most common case I am aware of is distributions setting the core
> file size to 0 (ulimit -c 0).

Hi Eric,

Thanks for taking the time to reply. We have hit these scenarios before in
practice where large cores are truncated, resulting in an unusable core.

At Juniper, we have some daemons that can consume a lot of memory, where
upon crash, can result in core dumps of several GBs. While dumping, we've
encountered these two scenarios resulting in a unusable core:

1. Disk space is low at the time of core dump, resulting in a truncated
core once the disk is full.

2. A daemon has a TimeoutStopSec option configured in its systemd unit
file, where upon core dumping, could timeout (triggering a SIGKILL) if the
core dump is too large and is taking too long to dump.

In both scenarios, we see that the core file is already several GB, and
still does not contain the information necessary to form a backtrace, thus
creating the need for this change. In the second scenario, we are unable to
increase the timeout option due to our recovery time objective
requirements.

> One practical concern with this approach is that I think the ELF
> specification says that program headers should be written in memory
> order.  So a comment on your testing to see if gdb or rr or any of
> the other debuggers that read core dumps cares would be appreciated.

I've already tested readelf and gdb on core dumps (truncated and whole)
with this patch and it is able to read/use these core dumps in these
scenarios with a proper backtrace.

>> We implement this by sorting the VMAs by dump size and dumping in that
>> order.
>=20
> Since your concern is about stacks, and the kernel has information about
> stacks it might be worth using that information explicitly when sorting
> vmas, instead of just assuming stacks will be small.

This was originally the approach that we explored, but ultimately moved
away from. We need more than just stacks to form a proper backtrace. I
didn't narrow down exactly what it was that we needed because the sorting
solution seemed to be cleaner than trying to narrow down each of these
pieces that we'd need. At the very least, we need information about shared
libraries (.dynamic, etc.) and stacks, but my testing showed that we need a
third piece sitting in an anonymous R/W VMA, which is the point that I
stopped exploring this path. I was having a difficult time narrowing down
what this last piece was.

> I expect the priorities would look something like jit generated
> executable code segments, stacks, and then heap data.
>=20
> I don't have enough information what is causing your truncated core
> dumps, so I can't guess what the actual problem is your are fighting,
> so I could be wrong on priorities.
>=20
> Though I do wonder if this might be a buggy interaction between
> core dumps and something like signals, or io_uring.  If it is something
> other than a shortage of storage space causing your truncated core
> dumps I expect we should first debug why the coredumps are being
> truncated rather than proceed directly to working around truncation.

I don't really see any feasible workarounds that can be done for preventing
truncation of these core dumps. Our truncated cores are also not the result
of any bugs, but rather a limitation.

Please let me know your thoughts!

Best,
Brian Mak

> Eric
>=20
>> Signed-off-by: Brian Mak <makb@juniper.net>
>> ---
>>=20
>> Hi all,
>>=20
>> My initial testing with a program that spawns several threads and alloca=
tes heap
>> memory shows that this patch does indeed prioritize information such as =
stacks,
>> which is crucial to forming a backtrace and debugging core dumps.
>>=20
>> Requesting for comments on the following:
>>=20
>> Are there cases where this might not necessarily prioritize dumping VMAs
>> needed to obtain a usable backtrace?
>>=20
>> Thanks,
>> Brian Mak
>>=20
>> fs/binfmt_elf.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 62 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 19fa49cd9907..d45240b0748d 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -13,6 +13,7 @@
>> #include <linux/module.h>
>> #include <linux/kernel.h>
>> #include <linux/fs.h>
>> +#include <linux/debugfs.h>
>> #include <linux/log2.h>
>> #include <linux/mm.h>
>> #include <linux/mman.h>
>> @@ -37,6 +38,7 @@
>> #include <linux/elf-randomize.h>
>> #include <linux/utsname.h>
>> #include <linux/coredump.h>
>> +#include <linux/sort.h>
>> #include <linux/sched.h>
>> #include <linux/sched/coredump.h>
>> #include <linux/sched/task_stack.h>
>> @@ -1990,6 +1992,22 @@ static void fill_extnum_info(struct elfhdr *elf, =
struct elf_shdr *shdr4extnum,
>>      shdr4extnum->sh_info =3D segs;
>> }
>>=20
>> +static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma_m=
eta_rhs_ptr)
>> +{
>> +     const struct core_vma_metadata *vma_meta_lhs =3D *(const struct co=
re_vma_metadata **)
>> +             vma_meta_lhs_ptr;
>> +     const struct core_vma_metadata *vma_meta_rhs =3D *(const struct co=
re_vma_metadata **)
>> +             vma_meta_rhs_ptr;
>> +
>> +     if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
>> +             return -1;
>> +     if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
>> +             return 1;
>> +     return 0;
>> +}
>> +
>> +static bool sort_elf_core_vmas =3D true;
>> +
>> /*
>>  * Actual dumper
>>  *
>> @@ -2008,6 +2026,7 @@ static int elf_core_dump(struct coredump_params *c=
prm)
>>      struct elf_shdr *shdr4extnum =3D NULL;
>>      Elf_Half e_phnum;
>>      elf_addr_t e_shoff;
>> +     struct core_vma_metadata **sorted_vmas =3D NULL;
>>=20
>>      /*
>>       * The number of segs are recored into ELF header as 16bit value.
>> @@ -2071,11 +2090,27 @@ static int elf_core_dump(struct coredump_params =
*cprm)
>>      if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
>>              goto end_coredump;
>>=20
>> +     /* Allocate memory to sort VMAs and sort if needed. */
>> +     if (sort_elf_core_vmas)
>> +             sorted_vmas =3D kvmalloc_array(cprm->vma_count, sizeof(*so=
rted_vmas), GFP_KERNEL);
>> +
>> +     if (!ZERO_OR_NULL_PTR(sorted_vmas)) {
>> +             for (i =3D 0; i < cprm->vma_count; i++)
>> +                     sorted_vmas[i] =3D cprm->vma_meta + i;
>> +
>> +             sort(sorted_vmas, cprm->vma_count, sizeof(*sorted_vmas), c=
mp_vma_size, NULL);
>> +     }
>> +
>>      /* Write program headers for segments dump */
>>      for (i =3D 0; i < cprm->vma_count; i++) {
>> -             struct core_vma_metadata *meta =3D cprm->vma_meta + i;
>> +             struct core_vma_metadata *meta;
>>              struct elf_phdr phdr;
>>=20
>> +             if (ZERO_OR_NULL_PTR(sorted_vmas))
>> +                     meta =3D cprm->vma_meta + i;
>> +             else
>> +                     meta =3D sorted_vmas[i];
>> +
>>              phdr.p_type =3D PT_LOAD;
>>              phdr.p_offset =3D offset;
>>              phdr.p_vaddr =3D meta->start;
>> @@ -2111,7 +2146,12 @@ static int elf_core_dump(struct coredump_params *=
cprm)
>>      dump_skip_to(cprm, dataoff);
>>=20
>>      for (i =3D 0; i < cprm->vma_count; i++) {
>> -             struct core_vma_metadata *meta =3D cprm->vma_meta + i;
>> +             struct core_vma_metadata *meta;
>> +
>> +             if (ZERO_OR_NULL_PTR(sorted_vmas))
>> +                     meta =3D cprm->vma_meta + i;
>> +             else
>> +                     meta =3D sorted_vmas[i];
>>=20
>>              if (!dump_user_range(cprm, meta->start, meta->dump_size))
>>                      goto end_coredump;
>> @@ -2128,10 +2168,26 @@ static int elf_core_dump(struct coredump_params =
*cprm)
>> end_coredump:
>>      free_note_info(&info);
>>      kfree(shdr4extnum);
>> +     kvfree(sorted_vmas);
>>      kfree(phdr4note);
>>      return has_dumped;
>> }
>>=20
>> +#ifdef CONFIG_DEBUG_FS
>> +
>> +static struct dentry *elf_core_debugfs;
>> +
>> +static int __init init_elf_core_debugfs(void)
>> +{
>> +     elf_core_debugfs =3D debugfs_create_dir("elf_core", NULL);
>> +     debugfs_create_bool("sort_elf_core_vmas", 0644, elf_core_debugfs, =
&sort_elf_core_vmas);
>> +     return 0;
>> +}
>> +
>> +fs_initcall(init_elf_core_debugfs);
>> +
>> +#endif               /* CONFIG_DEBUG_FS */
>> +
>> #endif               /* CONFIG_ELF_CORE */
>>=20
>> static int __init init_elf_binfmt(void)
>> @@ -2144,6 +2200,10 @@ static void __exit exit_elf_binfmt(void)
>> {
>>      /* Remove the COFF and ELF loaders. */
>>      unregister_binfmt(&elf_format);
>> +
>> +#if defined(CONFIG_ELF_CORE) && defined(CONFIG_DEBUG_FS)
>> +     debugfs_remove(elf_core_debugfs);
>> +#endif
>> }
>>=20
>> core_initcall(init_elf_binfmt);
>>=20
>> base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d


