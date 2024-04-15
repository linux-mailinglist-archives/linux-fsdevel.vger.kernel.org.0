Return-Path: <linux-fsdevel+bounces-16917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E9A8A4DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 13:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B5A1C218E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8145FBB2;
	Mon, 15 Apr 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="C6+fJfkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2092.outbound.protection.outlook.com [40.107.103.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B55D471
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180778; cv=fail; b=Yr849fiCQOrqfD2eUv5Th6ji/D5uZK8/doL+imlflUSnddHmvSlc41RECy2zwHq6rwJrc7RofMF0pYQsXYpBVg9oKR2puhfzFORD6YQ6H0w8+ELGnwPqcfWUjtIsjKp3aklHONY6UqH4C5wVEeoAuEGg2ZnmSqxj1retbjcZ7EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180778; c=relaxed/simple;
	bh=SeE7qrStUzlyxjaew2KOR4v5neVQyyaN7JuQcyLDHEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tTVBRYEkTuTxjtTh8v++Ub9Cfa00XVQ8xfdFNTX18dlM1s4mDO34UOACYEKlbr+slI3dBQul/gGjdvVWKZdDzfCYS4AeSvGSufpitYROOBNoZNcja2C0K9uSFUp1NwUEHcLDzXmyJz+zKxgaOx3fE5C/9LewTb7zaGTLgvf5hUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=C6+fJfkt; arc=fail smtp.client-ip=40.107.103.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7AbQwyRFcnkMa9T7ZxAL0OBsBOB2DDL83uXHzVtX2MosTbvBLeydLxFW7kXm7IULqc9cbpcX6Dr0MIdLZVrytk5u839auZMGrWJWDIIINTJwvdAMfz00IOVzRvAoOWuqoOTJUjW0S51kO/xgwGe3lgn5Qg/sXtJBRw6zAaWPfNr2ZxkmhSILEwZ6C9hrK5SsH8276E0ropCKRsxG2jN9CEKfjBYinLL2XVhkA3qKGKhcTk+q2Kv9DZdvKd6uoCnE71qnxd+XEPDv0MScWRynEVLj9OVCvnzF99PLCj8YjNGWu7SkOnlHGR/wg0/uQ7i23ZU+NH+e2P8Yi9/fXjPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5aQWToyboryED+4OpF2jPolTj6FvWTCkS9Xalyx6HI=;
 b=Z+7wu+lLEhXnXTUmqIc7AFQxu70KnJWosRBEupzs61ITPO2AuJa/EwvH67yh8g+JgYioC2OwPKUw+RPn9qpRLfcZ4nLZsHuygzqbuSmpdw7a4pVAyCN3A+GOFsXaTGrfVrGwWhnNC/t9+b5BawsV+K995cipHI08BiCigM+O8g0MNfPPzO1Q4UuoUKst1JjUgQLmskDQVfCVifZoMXhxN8un1VrgRR0EpzysQPuJhDDJzOpg5CCAdTuALCQbVgD8uH7+s3CeHDX5Vu+BeI5r3tKvZLHzIxuPP3HZNrQskS4bYIM87v/ozyNnmN+XtdfyJR9jOF9QIYvSCglJGl4IkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5aQWToyboryED+4OpF2jPolTj6FvWTCkS9Xalyx6HI=;
 b=C6+fJfktyNSnKDe599vwY9I8UYwK0H+mGMT2JXiRIJvOWdQsCgrPzBe/tTK5Yrl0W1D0+9otA0G78a92EmFeHU42k7o/UaHniKKuLkhT5i6o/6TcyhxRWwEBXI2/7r/pX9pcgLFEs1RTVt/1MWqgeqBQWxdc9Hco/GoUwmLny9CE4cu9ZbZtUB6InlyNZqKPjAJerhrkMNbq8ZJj04t/a38t5xOqZp7NlthbhbrW7fjpILsdItzxC3Z/mNa6UHB/Jqhy7fYgQbcN/dCzerS3JYP8/5eEb6EzUUxFZzecRegWRgkshk76guzc14m71pjrX8FifVM465xpOwDJ/GuO1g==
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com (2603:10a6:20b:254::18)
 by GVXPR06MB8994.eurprd06.prod.outlook.com (2603:10a6:150:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Mon, 15 Apr
 2024 11:32:51 +0000
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::2664:11aa:434c:516c]) by AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::2664:11aa:434c:516c%5]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 11:32:51 +0000
From: Anton Altaparmakov <anton@tuxera.com>
To: Johan Hovold <johan@kernel.org>
CC: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Linux
 regressions mailing list <regressions@lists.linux.dev>, Christian Brauner
	<brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Namjae
 Jeon <linkinjeon@kernel.org>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, Linux FS-devel Mailing List
	<linux-fsdevel@vger.kernel.org>, "linux-ntfs-dev@lists.sourceforge.net"
	<linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Thread-Topic: [PATCH 2/2] ntfs3: remove warning
Thread-Index:
 AQHafo9yVVZa6MRFs06pO1qKZgTUNrFIPKEAgAAfsoCAD3RtgIALMgEAgAY15ICAAAdNgIAAFC4A
Date: Mon, 15 Apr 2024 11:32:50 +0000
Message-ID: <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
 <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
 <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
In-Reply-To: <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR06MB7239:EE_|GVXPR06MB8994:EE_
x-ms-office365-filtering-correlation-id: a664e31e-8141-4c51-98a8-08dc5d3fc89b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uSxb58Wdotp+2CGqmjZSDHoF9yO8S6sBMHGmHsEI7DdlyMzDUmwyI2nfMzcAZiCvjbgZj0o+2Vu7GsF7N5WWLozuzPuZ21UyLCUG9L4YOOsBnQaaYciRfhJ3KIhJrAgQzv9tnpeMxseTEz6VAvhsy4u/E6gdRz2HB7jQbJSpXxz9K8FWa8+gAy3K/GbAHxtCA8f7kAiE+BTr71d6u4cYVczPTaPjTVD0hFhbhvvVP+/szg3GRZrDBVAhXqLezAyDPuiqvtuJXb0eOweYU+g2GLDCaF5HPJfh6L7TTOPl8vOU1blrV+pci+e+BdxgULDdAsLHzONiYXjTdK8rUdYjNuAZuP8wZ9nGLp4JVibwQEOfycwiu1hld/wvYIpRooHSAjl6ikh1DSimDS9GwsC4+jiC1gdVLEZpy2K19GT+ZxlOUtT8L7h8BgbjEzxb0xzV1pICK1CzolzfHobwfmOvGq5X3yOuIPD2zmEYaFxmfmieJLefigEhwAgphaRCJKEBasqoY7IvxyH8r7vMeesbWZ1qLaa+Ho4IOmypjhG5OzH116UCaYJdLnaifZ8+O1SK3CbJyMggoswQw5lZzihSq495PKNeznEbv1RhK2N/+OZgDrBqoUlzgL2u7kG5yGaxRi1s4a/XFcYTWcbdM7nmnzgguKcn85dk6M/nM1dR/3M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7239.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nykmQCZcswl4dWg/Vq7Pec7BVLj8F4QJ2MQjSieC6CaNu9/ISq3Iq3duvJRZ?=
 =?us-ascii?Q?S3PLyZRTX3BFZAIkGIUexyGbNbeEJcoZN6M9DQVm47SK5Eb6iLezSNJby4P3?=
 =?us-ascii?Q?okk3B4KN72cm38ndzzjubHaB60m8ZEV9S2CUmEZGTgkybm60LE8t1AJb84q9?=
 =?us-ascii?Q?svPgBd2xcTqWTTVI6e5n2OKXA0TKYz+cARLdD7wcEJfMXWiEC5lMOq8sgT+f?=
 =?us-ascii?Q?Q5HVy1XdxQZATMlTOgOb8mMeIr/fhrQLsMqsyuL9q2QON1mTJEccuCmnqV83?=
 =?us-ascii?Q?FUJ7y3RyVuYqqOOz7Jv7iFYYFGqyMs3C415xYyFfcUXm1E8Uz2J/3zZ+P+sV?=
 =?us-ascii?Q?RGBO4X38tmqTWULDbjO/6sS9BgFlIcar4ccbe6KE2Qg1fkYzUmxUSRRAk4Bz?=
 =?us-ascii?Q?tNwV9RfUp38DUfBbOETSp82+SL3IeSKG++arcrdgfK5YXzmkb0cDkdmVjBqr?=
 =?us-ascii?Q?QQMnzWDsAKzNt7tLk2figkz07SxnG+P9KTqr7eSgxUXQK1mMututeUrWvmAX?=
 =?us-ascii?Q?2oBxAEyrTmJLD7sQEu2KDS9yZXVhqzkF5lUZ+5VHRQFaP4qjk+lBm2GMzjkO?=
 =?us-ascii?Q?wT+6gm/IaJW8X8AapIpbaVz+ZXzzN3C9KOE1T39e1WUTffqVBtiJtMB/8glH?=
 =?us-ascii?Q?DKeOChVV0+5+d+vfewJhRHKTO7ksCjuylVaMl5IVRmzCYWQO37ZOzpRbBCT/?=
 =?us-ascii?Q?/NDJ5/5KGMGpvR4kJ6Y5kU5UGR3o9k61xyBb+661MhU9MSSr5527AHRYVKfs?=
 =?us-ascii?Q?xJg32C3vDzIRxJx2fTtt4575Cup14bojqM1kXwN6F4RXMUXsFEcyUKSlwosV?=
 =?us-ascii?Q?anECY5Pluzne2Bn9bgX4T76rIUlGGEJI7QGIwQ/cotRdl3MXVQ4TCKEbUQDK?=
 =?us-ascii?Q?L38WE0Fre3PjBaI0ZKC5oSUIF02+bS3uffjyokISBO+ZHeUKXug7hpcVEUTS?=
 =?us-ascii?Q?gmHQsfKTTPkauJB/zP2/5Em8+hcf1H50n4/2f9YP94woD71wcePAStRvaMtN?=
 =?us-ascii?Q?Uoc0QxrETCkoA5my4L0aswhyRG8FzlV4LsXpXPDPGTO0tZ1gPiaTL6Cc6HJ1?=
 =?us-ascii?Q?5yzZuSKpuyPHf5+xtCUlymWOUa/6nIUrXFXOudDGvBoV6DQWvY6zYbza7sUh?=
 =?us-ascii?Q?JFUhbFRtN8FtDN+hyXhGISF/h39MD6bAUgoqtsUeFxOpeZCiNCdO6NCx0CBi?=
 =?us-ascii?Q?NzeJ0VQW71b0WabEz5od3p2N3nrFFUdao09S700h4fAV/8A2q+eYk5zPbj5V?=
 =?us-ascii?Q?IKTV4vTBMp+uXXIi91NWxItqCKC/CjqMON4752VF7xuHsX7XxuIkBlp3jeUn?=
 =?us-ascii?Q?PyAO5/YEaDgX2BqmkMGwBLZWYHYMW4bGw6/l6UoTexjovDuWPRtucB8geDpI?=
 =?us-ascii?Q?oHMgZDWG/9oWqAgHAmYnJXXICraumUUyLb0uLSX+/Lft6/JO5ls9VWvezP3K?=
 =?us-ascii?Q?DkAHr61+PRQ8pJ8qD/JADVyPmvA5mVP8fYe3l/LLkbKKSKK8j91R31CBzRRj?=
 =?us-ascii?Q?wOiQ4tDDMqPXRZSeGxW1Qlr/RbnTw/Vsw2Ic+XRW/fUWYmnG49wx7UVTfnvj?=
 =?us-ascii?Q?L/Fr7bUQ0eFTe9OKpDT8HQtEunW/lDfyXMHCjumZ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <940485923C1B9349BBE9A37B9D14E22A@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB7239.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a664e31e-8141-4c51-98a8-08dc5d3fc89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 11:32:50.9205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXDnrmMz1G634ZiWLjacKb9yHMDGJv7Peo+gQ0WXZsz6ivVMkAPwDM8V3fe1zcGUFl+mcrsrlOd8l3H6xfbD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB8994

Hi,=20

Had a look at ntfs3 code and it is corrupting your volume.  Every such mess=
age you are seeing is damaging a file or directory on your volume.

I would personally suggest you modify your /etc/fstab to mount read-only.  =
If it is getting simple things like this wrong who knows what else it is do=
ing incorrect...

Best regards,

Anton

> On 15 Apr 2024, at 11:20, Johan Hovold <johan@kernel.org> wrote:
>=20
> On Mon, Apr 15, 2024 at 11:54:19AM +0200, Johan Hovold wrote:
>> On Thu, Apr 11, 2024 at 02:03:52PM +0300, Konstantin Komarov wrote:
>=20
>>> Messages like this:
>>>=20
>>> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
>>> index eb7a8c9fba01..8cc94a6a97ed 100644
>>> --- a/fs/ntfs3/inode.c
>>> +++ b/fs/ntfs3/inode.c
>>> @@ -424,7 +424,6 @@ static struct inode *ntfs_read_mft(struct inode *in=
ode,
>>>     if (names !=3D le16_to_cpu(rec->hard_links)) {
>>>         /* Correct minor error on the fly. Do not mark inode as dirty. =
*/
>>> -        ntfs_inode_warn(inode, "Correct links count -> %u.", names);
>>>         rec->hard_links =3D cpu_to_le16(names);
>>>         ni->mi.dirty =3D true;
>>>     }
>>>=20
>>> can also be suppressed for the sake of seamless transition from a remot=
e=20
>>> NTFS driver.
>>> However, I believe that file system corrections should be reported to=20
>>> the user.
>>=20
>> A colleague of mine also tracked down a failed boot to the removal of
>> the ntfs driver and reported seeing similar warnings with the ntfs3
>> driver.
>>=20
>> We're both accessing an NTFS partition on a Windows on Arm device, but
>> it makes you wonder whether these warnings (corrections) are correct or
>> indicative of a problem in the driver?
>=20
> This is what I see with a recursive ls on that partition (I've added
> rec->hard_links in parentheses):
>=20
> [   38.287555] ntfs3: nvme0n1p3: ino=3D2e1e7, Correct links count -> 1 (2=
).
> [   38.288593] ntfs3: nvme0n1p3: ino=3D75ff, Correct links count -> 1 (2)=
.
> [   38.289887] ntfs3: nvme0n1p3: ino=3D1b4e1, Correct links count -> 1 (2=
).
> [   38.290144] ntfs3: nvme0n1p3: ino=3D78c6, Correct links count -> 1 (2)=
.
> [   38.291313] ntfs3: nvme0n1p3: ino=3D8781b, Correct links count -> 1 (2=
).
> [   38.291823] ntfs3: nvme0n1p3: ino=3D8781e, Correct links count -> 1 (2=
).
> [   38.292289] ntfs3: nvme0n1p3: ino=3D87820, Correct links count -> 1 (2=
).
> [   38.292978] ntfs3: nvme0n1p3: ino=3D87823, Correct links count -> 1 (2=
).
> [   38.300531] ntfs3: nvme0n1p3: ino=3Da324, Correct links count -> 1 (2)=
.
> [   38.312235] ntfs3: nvme0n1p3: ino=3D882c3, Correct links count -> 1 (2=
).
> [   43.286846] ntfs3: 5479 callbacks suppressed
> [   43.286856] ntfs3: nvme0n1p3: ino=3D14aa, Correct links count -> 1 (2)=
.
> [   43.286998] ntfs3: nvme0n1p3: ino=3D14ac, Correct links count -> 1 (2)=
.
> [   43.287194] ntfs3: nvme0n1p3: ino=3D12cc2, Correct links count -> 1 (2=
).
> [   43.287386] ntfs3: nvme0n1p3: ino=3D12ccd, Correct links count -> 1 (2=
).
> [   43.287576] ntfs3: nvme0n1p3: ino=3D12d15, Correct links count -> 1 (2=
).
> [   43.287667] ntfs3: nvme0n1p3: ino=3D12d19, Correct links count -> 1 (2=
).
> [   43.287877] ntfs3: nvme0n1p3: ino=3D12d3a, Correct links count -> 1 (2=
).
> [   43.288051] ntfs3: nvme0n1p3: ino=3D12d88, Correct links count -> 1 (2=
).
> [   43.288265] ntfs3: nvme0n1p3: ino=3D874, Correct links count -> 1 (2).
> [   43.288326] ntfs3: nvme0n1p3: ino=3D875, Correct links count -> 1 (2).
> [   48.288211] ntfs3: 7735 callbacks suppressed
> [   48.288220] ntfs3: nvme0n1p3: ino=3D33391, Correct links count -> 1 (2=
).
> [   48.289115] ntfs3: nvme0n1p3: ino=3D347a4, Correct links count -> 1 (2=
).
> [   48.290214] ntfs3: nvme0n1p3: ino=3D3553f, Correct links count -> 1 (2=
).
> [   48.291193] ntfs3: nvme0n1p3: ino=3D35793, Correct links count -> 1 (2=
).
> [   48.292818] ntfs3: nvme0n1p3: ino=3D358a0, Correct links count -> 1 (2=
).
> [   48.293529] ntfs3: nvme0n1p3: ino=3D38f54, Correct links count -> 1 (2=
).
> [   48.293901] ntfs3: nvme0n1p3: ino=3D391f6, Correct links count -> 1 (2=
).
> [   48.294303] ntfs3: nvme0n1p3: ino=3D39324, Correct links count -> 1 (2=
).
> [   48.294729] ntfs3: nvme0n1p3: ino=3D394a0, Correct links count -> 1 (2=
).
> [   48.295063] ntfs3: nvme0n1p3: ino=3D3956a, Correct links count -> 1 (2=
).
> [   53.289392] ntfs3: 11442 callbacks suppressed
> [   53.289401] ntfs3: nvme0n1p3: ino=3D6293e, Correct links count -> 1 (2=
).
> [   53.289972] ntfs3: nvme0n1p3: ino=3D61df1, Correct links count -> 1 (2=
).
> [   53.290241] ntfs3: nvme0n1p3: ino=3D61df3, Correct links count -> 1 (2=
).
> [   53.290578] ntfs3: nvme0n1p3: ino=3D61f3b, Correct links count -> 1 (2=
).
> [   53.290881] ntfs3: nvme0n1p3: ino=3D62025, Correct links count -> 1 (2=
).
> [   53.291045] ntfs3: nvme0n1p3: ino=3D629af, Correct links count -> 1 (2=
).
> [   53.291181] ntfs3: nvme0n1p3: ino=3D61e3c, Correct links count -> 1 (2=
).
> [   53.291463] ntfs3: nvme0n1p3: ino=3D61e22, Correct links count -> 1 (2=
).
> [   53.291743] ntfs3: nvme0n1p3: ino=3D62882, Correct links count -> 1 (2=
).
> [   53.292099] ntfs3: nvme0n1p3: ino=3D61b3d, Correct links count -> 1 (2=
).
> [   58.291790] ntfs3: 5373 callbacks suppressed
> [   58.291799] ntfs3: nvme0n1p3: ino=3D6d5a5, Correct links count -> 1 (2=
).
> [   58.292106] ntfs3: nvme0n1p3: ino=3D6d7f6, Correct links count -> 1 (2=
).
> [   58.292372] ntfs3: nvme0n1p3: ino=3D6db43, Correct links count -> 1 (2=
).
> [   58.292653] ntfs3: nvme0n1p3: ino=3D72557, Correct links count -> 1 (2=
).
> [   58.293244] ntfs3: nvme0n1p3: ino=3D728d8, Correct links count -> 1 (2=
).
> [   58.294306] ntfs3: nvme0n1p3: ino=3D72c6e, Correct links count -> 1 (2=
).
> [   58.294944] ntfs3: nvme0n1p3: ino=3D72ff7, Correct links count -> 1 (2=
).
> [   58.295666] ntfs3: nvme0n1p3: ino=3D73271, Correct links count -> 1 (2=
).
> [   58.296281] ntfs3: nvme0n1p3: ino=3D735fd, Correct links count -> 1 (2=
).
> [   58.296991] ntfs3: nvme0n1p3: ino=3D73880, Correct links count -> 1 (2=
).
> [   63.295009] ntfs3: 13921 callbacks suppressed
> [   63.295017] ntfs3: nvme0n1p3: ino=3D6be65, Correct links count -> 1 (2=
).
> [   63.295902] ntfs3: nvme0n1p3: ino=3D6c08e, Correct links count -> 1 (2=
).
> [   63.296252] ntfs3: nvme0n1p3: ino=3D6c2e3, Correct links count -> 1 (2=
).
> [   63.297581] ntfs3: nvme0n1p3: ino=3D6c610, Correct links count -> 1 (2=
).
> [   63.298321] ntfs3: nvme0n1p3: ino=3D6c7f9, Correct links count -> 1 (2=
).
> [   63.298730] ntfs3: nvme0n1p3: ino=3D6cb24, Correct links count -> 1 (2=
).
> [   63.299079] ntfs3: nvme0n1p3: ino=3D6ceda, Correct links count -> 1 (2=
).
> [   63.299408] ntfs3: nvme0n1p3: ino=3D6d288, Correct links count -> 1 (2=
).
> [   63.299727] ntfs3: nvme0n1p3: ino=3D6d533, Correct links count -> 1 (2=
).
> [   63.300080] ntfs3: nvme0n1p3: ino=3D6d77b, Correct links count -> 1 (2=
).
> [   68.299457] ntfs3: 8228 callbacks suppressed
> [   68.299467] ntfs3: nvme0n1p3: ino=3D3e248, Correct links count -> 1 (2=
).
> [   68.301391] ntfs3: nvme0n1p3: ino=3D5d7b7, Correct links count -> 1 (2=
).
> [   68.302440] ntfs3: nvme0n1p3: ino=3D5853d, Correct links count -> 1 (2=
).
> [   68.303123] ntfs3: nvme0n1p3: ino=3D3ca2e, Correct links count -> 1 (2=
).
> [   68.303722] ntfs3: nvme0n1p3: ino=3D59a98, Correct links count -> 1 (2=
).
> [   68.304292] ntfs3: nvme0n1p3: ino=3D59a9b, Correct links count -> 1 (2=
).
> [   68.304981] ntfs3: nvme0n1p3: ino=3D59a9e, Correct links count -> 1 (2=
).
> [   68.305629] ntfs3: nvme0n1p3: ino=3D59aa1, Correct links count -> 1 (2=
).
> [   68.306120] ntfs3: nvme0n1p3: ino=3D3214f, Correct links count -> 1 (2=
).
> [   68.306539] ntfs3: nvme0n1p3: ino=3D2077b, Correct links count -> 1 (2=
).
> [   73.302727] ntfs3: 8502 callbacks suppressed
> [   73.302736] ntfs3: nvme0n1p3: ino=3D5aa99, Correct links count -> 1 (2=
).
> [   73.303992] ntfs3: nvme0n1p3: ino=3D50ee9, Correct links count -> 1 (2=
).
> [   73.304744] ntfs3: nvme0n1p3: ino=3D20420, Correct links count -> 1 (2=
).
> [   73.305080] ntfs3: nvme0n1p3: ino=3D258c, Correct links count -> 1 (2)=
.
> [   73.305470] ntfs3: nvme0n1p3: ino=3D5a30d, Correct links count -> 1 (2=
).
> [   73.307283] ntfs3: nvme0n1p3: ino=3D5a54c, Correct links count -> 1 (2=
).
> [   73.307890] ntfs3: nvme0n1p3: ino=3D5c9de, Correct links count -> 1 (2=
).
> [   73.308495] ntfs3: nvme0n1p3: ino=3D3d82d, Correct links count -> 1 (2=
).
> [   73.309581] ntfs3: nvme0n1p3: ino=3D3d839, Correct links count -> 1 (2=
).
> [   73.310016] ntfs3: nvme0n1p3: ino=3D25c77, Correct links count -> 1 (2=
).
> [   78.304861] ntfs3: 11462 callbacks suppressed
> [   78.304868] ntfs3: nvme0n1p3: ino=3D5c714, Correct links count -> 1 (2=
).
> [   78.305579] ntfs3: nvme0n1p3: ino=3D57d11, Correct links count -> 1 (2=
).
> [   78.306151] ntfs3: nvme0n1p3: ino=3D5842d, Correct links count -> 1 (2=
).
> [   78.307412] ntfs3: nvme0n1p3: ino=3D34e6, Correct links count -> 1 (3)=
.
> [   78.307843] ntfs3: nvme0n1p3: ino=3D5bb23, Correct links count -> 1 (2=
).
> [   78.308509] ntfs3: nvme0n1p3: ino=3D5c722, Correct links count -> 1 (2=
).
> [   78.310018] ntfs3: nvme0n1p3: ino=3D5d761, Correct links count -> 1 (2=
).
> [   78.310717] ntfs3: nvme0n1p3: ino=3D33d18, Correct links count -> 1 (3=
).
> [   78.311179] ntfs3: nvme0n1p3: ino=3D5d75b, Correct links count -> 1 (3=
).
> [   78.311605] ntfs3: nvme0n1p3: ino=3D5c708, Correct links count -> 1 (3=
).
>=20
> Johan

--=20
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/


