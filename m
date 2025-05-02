Return-Path: <linux-fsdevel+bounces-47890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD99AA69E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 06:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9241BA6F70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 04:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA31A3166;
	Fri,  2 May 2025 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="OE2mQ7S0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD5189513
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746160754; cv=fail; b=Khurt+TPC6ZXf7c4ohf52z3hJDNviNDYtHmiqAHyvOgto5+fVQebL9Pgy/IDTgjTA/3txBCkcbeyRVqikmN2F3v4H/vREVujxV4kuGfINWfGEgbAh/hh/AM0ufSdCcrjNozhQekLSdjF8MBsDiSJlsi06xB6cgHAvywvu/NnIic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746160754; c=relaxed/simple;
	bh=eZ7HYlgvke4FjFjYTnnLFwDZkqXJerU+IghFdt4qlrY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E5eWPE8Rn2mTzbzFkVxwDzZ9RGUbVEEI7Dff/G664IKjyjj4yj7RTmj5/NYhjT0tbaYxzDUOQ2PeKuA9kXbWMA/X0ARzwXI7JVW8PLHe6m9qRsKOXCoM1PSM0t1tJOIEtVi1yuEY3oaAzcQOLfgZvZKIITnMf8GEbAwW8ZGMl6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=OE2mQ7S0; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168]) by mx-outbound20-166.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 02 May 2025 04:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv75bbDRmnOWYFVxf/FSC4ieegSjkkmyIj8KOz8uq8D0XCY1HWBHoRz8lxvKZ+wB0qtvpJ7Jfrt4t1SFjv+L6D20YmRO2ArCGlClw2WIvtmOqtyzNUFzSek3tH0wj2pvuDZxNrQ9+n0l/JrHmAkUuuYD0N+c9PGan8wIUm0UpgGthrfdn5K3R8/MEMy+7EydzXUOJWGt7KIbgEwSL9G2QgFlrJ5lGi/rI/1MSg1gQGTUFRJcFCRP1sjJwkPsRj+zq0w1N88WWmuzwN6FWGqfYb465LpXpMU52nHkVT3n1ai/QpgQqmh99/b0n3fu+jPnpsFB+k/6CqDNuNsrBR6s+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTtQvZegScFNhwbUipbPC98g+pB3V/BKbGAyWpCw1yw=;
 b=OXDTBs4JoId1J/ul6LLeR5pB+tNMMX7skfcKu0vFQtODQH54lm3r4uMI25KcvaE+FbOGyaFue4YlKAF4CYrzcrqMjWUclSM4BHhRYJU69OJ+kfhICb4jJ7f0uAd4MphSL38HFRtfXO21VZfo9p8bRNWiMfov6z2Lzjx7B9HXPgm4b1JrfJgnYFOzLJs6gHrkoto3AWS+Fdb3Gvq8LG4kQ/zPskntWYCg4yD1j7ShDJ9HiUrLNL0dASOV/VV0VmA9w6S2grwvK/fVW7ivNnOovkGJSuDNtB4S8DBkWNlxlNKjZtCIjCFMO3NBV7zgRZI5fnXJGei2twwBZzStUCo5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTtQvZegScFNhwbUipbPC98g+pB3V/BKbGAyWpCw1yw=;
 b=OE2mQ7S03TA/C7+jc6rYxeEdZueZTQWyUfVMfhzdfzVhcrCzW7zQtORSZ1lavCWes/aCJrIsx+iwEqrQPB5ZsNHsngN/MHi4XN6UU9A0oz5bjUi+Z2/TitZcda2HSOFXbPf2eF/zBiNojC1tNa14iMrm2jdBUZ2HgRwql1uXWbA=
Received: from BN6PR19MB3187.namprd19.prod.outlook.com (2603:10b6:405:7d::33)
 by DS0PR19MB7647.namprd19.prod.outlook.com (2603:10b6:8:f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Fri, 2 May
 2025 04:04:21 +0000
Received: from BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00]) by BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 04:04:21 +0000
From: Guang Yuan Wu <gwu@ddn.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
	"mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: [PATCH V4] fs/fuse: fix race between concurrent setattr from multiple
 nodes
Thread-Topic: [PATCH V4] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbuxZ+73TnsOONbEC2ThPZ7yblRA==
Date: Fri, 2 May 2025 04:04:21 +0000
Message-ID:
 <BN6PR19MB31871E9C762EDF477DC48CE5BE8D2@BN6PR19MB3187.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR19MB3187:EE_|DS0PR19MB7647:EE_
x-ms-office365-filtering-correlation-id: 4635852e-b447-410f-3e09-08dd892e6afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+S+/qhJXWYjlk7HiU5484IU65xEBBMjAcXdgvg0ZmWP7cw2+uRHRQqB3Ot?=
 =?iso-8859-1?Q?gYBht84t+7WHMDYSEKfA8s+Ovi14GyP/W4SEnYYMi+99e7Vv6IUFGn/7dJ?=
 =?iso-8859-1?Q?PuUZria0XmqLYljaKra8/msb/2cqUhElYOek3BXy9KAlxCsNZAc3f+xY+w?=
 =?iso-8859-1?Q?BCu/dqkLsLdSxbcDGMpVXMQMqq7CO5iwyHtA3CwZzqiyjhByzYom4Jhx0T?=
 =?iso-8859-1?Q?aIXdAMafj4fxpk0VfjI9IKLsMADupBsXLK5bcq9yO1iwWYnoHTjrjmpXdY?=
 =?iso-8859-1?Q?Vf6+JT26FsuDnXi1e1d8YuVjS3LkaYBgpGIYFJrpNf85WuU91K71lXGwAE?=
 =?iso-8859-1?Q?uy8n3WpHEAzTOocJ1Zct9pPzJJj+SZeyGJhtbGF/tCjeXsMSJt3xC+nEVi?=
 =?iso-8859-1?Q?jS/aSNp2mC/3sqzrVTmwW1CZ9F0DAyvxsyyJoadWiVjC4mGbKyD1eZ8lqw?=
 =?iso-8859-1?Q?7APIs1i5g7RhVAbC4+5rXN1KflHwP57sO0o5latOg1ydFBWzJt5IJzc6/E?=
 =?iso-8859-1?Q?xs4qS5TdhteCbhJigHanD2uX1DkooFmInAAQwO6aMxMl6tyBZdBb9ed4nh?=
 =?iso-8859-1?Q?tMqcKAI6nggqUTRjlmiXthjxYq46VuyEFv8x8oAeCPm1jbT5pSVs5nLnC6?=
 =?iso-8859-1?Q?KIT0FIAxlWhiwGWWo58V3/7TWP4xAcLoebSTLRIkeWKB71ryg8cMOhxCmv?=
 =?iso-8859-1?Q?Ssb+SwEWNXl1UbDM25MGDy8wFdXMBtNGhTGDgdWuv9nmRaHHNniBuJ4G+L?=
 =?iso-8859-1?Q?lVNfaS0B9DfOzkvQ8TIzVYOS7WtxMr3e/5LMV6dYaPZcIpgnKh/C/W8Z30?=
 =?iso-8859-1?Q?d7afXzRs3+o3zneu/R8HMug2A/U9wS4b60Y4yMsHaWE7RWhCFwgSGzW8I/?=
 =?iso-8859-1?Q?0fPE8VhMtUSXGkdBHI+sHJ1pXofWywX+SZ8OpJN3clbAxXhYRJOjOSVYkZ?=
 =?iso-8859-1?Q?TZNd/ttMmVDu+7QgWkBxFutlf8obByKr85CR++FyGWfpHD1HTpg8ZyfGz/?=
 =?iso-8859-1?Q?+EmVka4vy8oFWwtI0xkXEgOXUyke49+4CihuTLKNP7dYbvkCaBqdu38neP?=
 =?iso-8859-1?Q?gKodW9ajpZirjAj2UVSvvQME6Y9dEH1VO3cP5OTMK6nRdLny5EUA3+XAaI?=
 =?iso-8859-1?Q?kiMPb4wvRzx3goexWR/BL6ZTKqJQ4AIZhZpT01dvdc+WTK3dA1nqMLtWa8?=
 =?iso-8859-1?Q?zbyuigBaTOqF5CugfAkQdTzHbZFapYOFFfGMuXgGMgwyWuN2DezmCWGvV7?=
 =?iso-8859-1?Q?nn8uw4TaZhEEVVgw73jBqCDBpIV1x8dq2jJ5Av2276HmDL+ameopXg4biR?=
 =?iso-8859-1?Q?PoFWZz8zDK3L96P6YQD0vdRo6RXsIo9/tbLIioXaJWaxB9TtH263jL6P9H?=
 =?iso-8859-1?Q?frOlUG29lcIBecEh1vpMx1vUDFtw2j1nAhRmHDPEKUEA9Otv06Td/Vjv98?=
 =?iso-8859-1?Q?FOHucL5z9xOlsAnyk3sk1HoVEN7gCXYq5Q0DDic3xoDk3Q0IVjLLJiHfo+?=
 =?iso-8859-1?Q?DXZSzjsIhpVg8QtSv+UNhjKE7IYlheM2W4CZ3Y/v9rMA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR19MB3187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?d1I3AF/qgbUY6dwZzkZCRyDfO/07lQCEWVnoUma2T8jbn33+H8wNEyeWxf?=
 =?iso-8859-1?Q?hdOWlBxOkf83RAEq37auj1Rj2T2THK/VyrVtUj3q5e641QuJmxupwjBnrh?=
 =?iso-8859-1?Q?q2CMOhvCs2RdqXGszkXfZ4p8aP59iQBH2he/6o7w4n3zoelr7guWaQ36FE?=
 =?iso-8859-1?Q?i0/qcexoRZe6/7MgG6XfzEWBcVsuLTXlJZbvrDzZZeIIw4ZQYoFrJfXr8T?=
 =?iso-8859-1?Q?EekM/iMq8Wg3Abutb9DtTpg64EUsSe9bTAv+54SNBombz+GrbnZygTRzud?=
 =?iso-8859-1?Q?IW0P0QYZcYiRanOsFqkgvrnfI79KU6YGIz8IDyEl2vJHAjMRz26ycHWPvJ?=
 =?iso-8859-1?Q?WqyWcWDQSsVgujoPkMxf2n8wzH55hOmm5uWW8G09xjop7uySra3P/SSfaJ?=
 =?iso-8859-1?Q?NLMvlQ67737ruBtyCeyBmhsWuufQmQx2rTOI5N/TNcUM7PV6cOu6gnzAKE?=
 =?iso-8859-1?Q?tQVNDZb5KVjGPmU/HiPLzm2RX3WF778lon9nwufXk8BDNtgVmvQj8iXqZL?=
 =?iso-8859-1?Q?MBvJcRFyNC3TmpEW3eVBmhp3OAZJ0zzMWl5ViFD/aKZFIuXHFJiEsbslPm?=
 =?iso-8859-1?Q?K5JlD5BkQtZSArDfLJMjcfou/RjY/xuzN7w7m4cFSblzSqV56JvAqOeTWU?=
 =?iso-8859-1?Q?omGoi0x+CSHO9KXRT+pPtPS3w57W9iBUoSowitAz6USU1s93K44qEuAFzU?=
 =?iso-8859-1?Q?dvZPDClC3+FYlFSMuZNTE8mj3tEyxWWflJ9gm0nQ++ALLvNYvD7SHl4ZUh?=
 =?iso-8859-1?Q?IdejNxc0E0Uf/Y6MkMyuhsry1o4vDTP3fmBBDtWLEzWHfngh/Y0ADIU8OM?=
 =?iso-8859-1?Q?tBOEM4Z4ohO7l2DRZLNCnpTs5JDaGb0yUm2uZXfGkfzu2tjDHTwb9i6GX8?=
 =?iso-8859-1?Q?aGeX5pJ2pDIcLkGxAvnVZKcUZLQkbABPVcnzc0ruwjPfXzpGqDUGP9zmJ+?=
 =?iso-8859-1?Q?5tKHXQfsv1IZKv4DTA5+4DZWfZZfz3ss8uZm8SSkx2eVWe/245zcU23Uzx?=
 =?iso-8859-1?Q?roAnMNJszhy9XpMjDmTMeizoK2qWVQk9wGVGiJ9EwaiGbqMMtu6HETBsqk?=
 =?iso-8859-1?Q?48Va/QfhqTx4LrVcwyIt6nxkL9rGwqGr+t3gSCdJwDrmegfxsW4kF19hwa?=
 =?iso-8859-1?Q?ZF8nfG/rBBlnwaEp8fefaXextm0f5OXxW3pZwQjknhfnPOj52Ga9PCD3tA?=
 =?iso-8859-1?Q?QTjEBrIyWYI/3MNWY1hkAjXxWmoxoMedrEOQghehqh/uYhUdTkm/XvzjvQ?=
 =?iso-8859-1?Q?cNW2JLwABeIQ7ljMeMMYas5G94sTEGkMkYHZmvL/HuMaDwOsMWIUK6IgTq?=
 =?iso-8859-1?Q?XoBAY7/J6oMYNfP3Lz6yPMNxrmaJT9Pir+58b0ycjJlZcvMKvrMD+PPA86?=
 =?iso-8859-1?Q?0kAJ322JDsK2Dnap5m7gblLPEXEMJ/zzpSpNrUuK3liSVenP0mpBNvfuh4?=
 =?iso-8859-1?Q?LtyEJtHdM7tM2/KpsXtDaAFo6V7RGQzVU6h0XuPJAwcTeWaySk1A6902YE?=
 =?iso-8859-1?Q?mWdbSZ2XUTwH3hYdG8ND5zGFNgKNKqjybKOQLwvZJFb5pvgXwvlb53X7db?=
 =?iso-8859-1?Q?IzzjGeK9IBv0IId8/Yc+S8A0s+W8fvh8Oggbc4o1Qph5AqXZoA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7A7T1+khcxgKmTZjHC6g5Jb7DIOtTEYg+rz+6VR088eIccmla2vBVMR/F4Wg5tacl/Jcpqw880eAWQeRkDFdS9e7z+L5IwqQK9udxUuVhgojEI3UC2M8r6ZVXZu7fQS5CVvLxrupnp5iFgrHf6tFspiHtfrIkxNnfuhwxs4xoRCK8uVTS1H2EFsde9mKPaUiLiEO7Yu0ybe/Bd3cqXw4WuWzGr5b3QwphU5gpMbEeVto+mfEHuwslakTtAJtXIK7Xy0DUS6stIwKiS+CzcaTiPievBblVQBjL2go7mURQ2h9hpp16EHqeffQy0zS6cm3IPHabTHr1vu9C644GMgarr/1IBfxdRO9iPtHgDuUwzmC6sSxOm1bBMcBCAbhj3z4LvEGl+GhJJqKoNHj48153riZHcxFi8A9n864jxPOoY3eXJDxASfLZMJ/XFu04nEUCVpi80j7+73BVDsnnb/ylV0BFwBgTMeiWHdAYmvijuArPZw7b+ey86ERmV3CeLaaZecimoti/mNbRarWdW89JLqKD+a/1WdGf4f48+umzPsMx7jVbIJbTe303gRH7Y7oBWbbNuuqB4RrGgXDodWQb61SW0Z/Wp7+LI+BU7rz1funPAkuNcYJlCKgSWVEqVsgFe50AI4oUxU7uUjQiVse6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4635852e-b447-410f-3e09-08dd892e6afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 04:04:21.2723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzuaP56RHQVBRjNubr0KMEdCqFf8cvqOJ3SMCjIf66qTpRh24GpWlGvLrX0nKuTH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7647
X-OriginatorOrg: ddn.com
X-BESS-ID: 1746160744-105286-8594-29288-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.73.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaG5iZAVgZQ0MDYJNEyydzSyN
	wyyTA5zTjZxMzYyDjF2MTc3MDEwthYqTYWAHaAvahBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.264299 [from 
	cloudscan8-8.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

    fuse: fix race between concurrent setattrs from multiple nodes=0A=
    =0A=
    When mounting a user-space filesystem on multiple clients, after=0A=
    concurrent ->setattr() calls from different node, stale inode=0A=
    attributes may be cached in some node.=0A=
    =0A=
    This is caused by fuse_setattr() racing with=0A=
    fuse_reverse_inval_inode().=0A=
    =0A=
    When filesystem server receives setattr request, the client node=0A=
    with valid iattr cached will be required to update the fuse_inode's=0A=
    attr_version and invalidate the cache by fuse_reverse_inval_inode(),=0A=
    and at the next call to ->getattr() they will be fetched from user=0A=
    space.=0A=
    =0A=
    The race scenario is:=0A=
    1. client-1 sends setattr (iattr-1) request to server=0A=
    2. client-1 receives the reply from server=0A=
    3. before client-1 updates iattr-1 to the cached attributes by=0A=
       fuse_change_attributes_common(), server receives another setattr=0A=
       (iattr-2) request from client-2=0A=
    4. server requests client-1 to update the inode attr_version and=0A=
       invalidate the cached iattr, and iattr-1 becomes staled=0A=
    5. client-2 receives the reply from server, and caches iattr-2=0A=
    6. continue with step 2, client-1 invokes=0A=
       fuse_change_attributes_common(), and caches iattr-1=0A=
    =0A=
    The issue has been observed from concurrent of chmod, chown, or=0A=
    truncate, which all invoke ->setattr() call.=0A=
    =0A=
    The solution is to use fuse_inode's attr_version to check whether=0A=
    the attributes have been modified during the setattr request's=0A=
    lifetime.  If so, mark the attributes as invalid in the function=0A=
    fuse_change_attributes_common().=0A=
    =0A=
Signed-off-by: Guang Yuan Wu <gwu@ddn.com>=0A=
Reviewed-by: Bernd Schubert <bschubert@ddn.com>=0A=
=0A=
---=0A=
 fs/fuse/dir.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c=0A=
index 83ac192e7fdd..a961c3ed7b26 100644=0A=
--- a/fs/fuse/dir.c=0A=
+++ b/fs/fuse/dir.c=0A=
@@ -1946,6 +1946,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct d=
entry *dentry,=0A=
 	int err;=0A=
 	bool trust_local_cmtime =3D is_wb;=0A=
 	bool fault_blocked =3D false;=0A=
+	bool invalid_attr =3D false;=0A=
+	u64 attr_version;=0A=
 =0A=
 	if (!fc->default_permissions)=0A=
 		attr->ia_valid |=3D ATTR_FORCE;=0A=
@@ -2030,6 +2032,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct d=
entry *dentry,=0A=
 		if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))=0A=
 			inarg.valid |=3D FATTR_KILL_SUIDGID;=0A=
 	}=0A=
+=0A=
+	attr_version =3D fuse_get_attr_version(fm->fc);=0A=
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);=0A=
 	err =3D fuse_simple_request(fm, &args);=0A=
 	if (err) {=0A=
@@ -2055,8 +2059,14 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct =
dentry *dentry,=0A=
 		/* FIXME: clear I_DIRTY_SYNC? */=0A=
 	}=0A=
 =0A=
+	if (attr_version !=3D 0 && fi->attr_version > attr_version)=0A=
+		/* Applying attributes, for example for fsnotify_change(), and=0A=
+		 * set i_time with 0 as attributes timeout value.=0A=
+		 */=0A=
+		invalid_attr =3D true;=0A=
+=0A=
 	fuse_change_attributes_common(inode, &outarg.attr, NULL,=0A=
-				      ATTR_TIMEOUT(&outarg),=0A=
+				      invalid_attr ? 0 : ATTR_TIMEOUT(&outarg),=0A=
 				      fuse_get_cache_mask(inode), 0);=0A=
 	oldsize =3D inode->i_size;=0A=
 	/* see the comment in fuse_change_attributes() */=0A=

