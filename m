Return-Path: <linux-fsdevel+bounces-18188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0F8B6362
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 22:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8172835C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E91411EE;
	Mon, 29 Apr 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EN6E08/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8B73535;
	Mon, 29 Apr 2024 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421978; cv=fail; b=EUTYI7vvI/YDtABzyhpbCTXg6jdHVDVmWpQfs+fHBgvXb5MIrS4zG/52jEz5OaBv2E6BsSlFNhH/4z879qdRcemiJrd3sgCj3fmfgTB3r0HY/3VNhTA43HAWNgQf7ETAOTcfj0H+6pKvawXZuM1DIuL8cTZntFQ9IAGClQYUwik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421978; c=relaxed/simple;
	bh=A2g5tkkZvpLeldF6i4fJeVpiNUghQJQ7sCSRJMEEaqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A7kUMO9arDIlIagcOC2E2VRm5Yumdqb5dAe/ydQwFcbf9E0xfCPaxevSkzsIM1YP5aK/4LXiB65rR57V93YNZcUTC8W1pCoPoQ0O/na1dwQqxl9nOB5JadM9UynMmLd2h6zBmarh9a6swl2458RMf8BCunzl/KNs84FTGB/zU/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EN6E08/P; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWPUmcqlvxqq8R238YAm1HBAw/RM/a+a6ms9Dr5JB3gPPisezS8w6D4I19kfBdsj7/1Tqt36FnbP8yIAYwj/hBiK8Arto1SnR6vgIEaDidmOe59yMBPR/Ks3IUudDRnHRUxvjfjkDzpWh9285G0s29Yy4KmmI0azJGdU98shre+4xDCzP6qKPHXDIfNxqNb049md6iRrtsfrwYg/Uy0JmkbRKaYD/lyIrdC5TUjPTOq7EK0jRutXrMR4/bCx+z0zc2me1g86S8pPE0Z2IouyXkAX3jzFFZT/PYzBx9ihcJnbWy12rHUfMhGdnSiU1xgdSVoEsioqZ/u4pnRNEJoWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh5LLGwx9ZD3YNCcHEjheJSqKxSER9yeMWoLJr6wB9Q=;
 b=WRMkcR7hhuxR7M8einjz63nxkxU86CYYQp5hUlOu0y3zKrpmUJxi+wqcbqOBjAYzO7CLTBSHIqSloa6bnzVh/UvHqtHnfYJqbeTx3I5O9jkigm1wrhIphiXzZNYaH0bn1Wr36USTL9IjdTJeJlyGnvbhbx5WB2Yuh62GpdkWM6u3WhbALVq4bqKuIYULh/bo5F7vt8psJ6ItNL4eJe9j+DSo6DOFoOnYryJ1CBfBsWWWio7p7JxvrOF4cc/SdodrD009S3/0oXX5sJGwF4p3CpzTyWtXSHQdzFVyX68bqE+ag82hovB0GzAddTz2KPF7otTDXUx/7m/f6Ynaj2+IFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh5LLGwx9ZD3YNCcHEjheJSqKxSER9yeMWoLJr6wB9Q=;
 b=EN6E08/PSu4LrnWKf9bSx4+dd5TlOYImxkPn/Iamjpsdwq84Ha/SLVkS6jn3MbMv9JZnTvMfKO69qxqphdC7507DK8wFRsoNBgmZf9S6Y0uum2d9uj/ib9EE73i8dgW4iHmeMnY60cKgELAZlDLIiAjdVmtOXnunNeEg9jAMOqo=
Received: from SA0PR21MB1898.namprd21.prod.outlook.com (2603:10b6:806:ed::11)
 by LV2PR21MB3253.namprd21.prod.outlook.com (2603:10b6:408:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.23; Mon, 29 Apr
 2024 20:19:32 +0000
Received: from SA0PR21MB1898.namprd21.prod.outlook.com
 ([fe80::1657:31fa:bcd3:e49f]) by SA0PR21MB1898.namprd21.prod.outlook.com
 ([fe80::1657:31fa:bcd3:e49f%5]) with mapi id 15.20.7544.019; Mon, 29 Apr 2024
 20:19:31 +0000
From: Steven French <Steven.French@microsoft.com>
To: Kairui Song <kasong@tencent.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
	<ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, Chris Li
	<chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim
	<minchan@kernel.org>, Hugh Dickins <hughd@google.com>, David Hildenbrand
	<david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Namjae Jeon
	<linkinjeon@kernel.org>, "Paulo Alcantara (SUSE)" <pc@manguebit.com>, Shyam
 Prasad <Shyam.Prasad@microsoft.com>, Bharath S M <bharathsm@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 05/12] cifs: drop usage of page_file_offset
Thread-Topic: [EXTERNAL] [PATCH v3 05/12] cifs: drop usage of page_file_offset
Thread-Index: AQHammhzJrsE0Xg8qUSGz+RQruipXLF/r7BQ
Date: Mon, 29 Apr 2024 20:19:31 +0000
Message-ID:
 <SA0PR21MB1898817BA920C2A45660DE65E41B2@SA0PR21MB1898.namprd21.prod.outlook.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
 <20240429190500.30979-6-ryncsn@gmail.com>
In-Reply-To: <20240429190500.30979-6-ryncsn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6c13ae0a-f3ca-4c72-a28f-a440cd6486c9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-29T20:17:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR21MB1898:EE_|LV2PR21MB3253:EE_
x-ms-office365-filtering-correlation-id: cebf0ef3-9317-42ab-f7b0-08dc6889ae02
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nGGURDbAnLW2GaQLtc0uNdhnzYnv7stSZaoLEztqfLs6hed098tdN6yONt81?=
 =?us-ascii?Q?4nqsqlewHnU3/9mMsaOKbFH4POjyM+kXLPty2gyccs3aIipuqfTcOLTy5Z08?=
 =?us-ascii?Q?RJ+Bwhxy0rJwundEwlewQgw1PrmaOW5n6H2Rh1pucVUi0mloAnqf/f1u6xrD?=
 =?us-ascii?Q?Kh+BP/BauOXMMMu+doAEzjxsAbVh8CqYSRLZzt1JCldCLfsAAUjQ6isyq3XE?=
 =?us-ascii?Q?Lvp2et3EBiQAqYy0xA9CYV8Hzi8zGDLHv17SsAQ45Rf+3bB3uAzaThmhpwKG?=
 =?us-ascii?Q?JBaNEjfiYL2lkoylQxgvSAKvTAKfDAt6QrVKNErhesUPjm+9P07BLwNkB9A2?=
 =?us-ascii?Q?n3R7Pf0CNlz/CZawiJmDJvS/SShWpypb7xbXPF/HbLyXJfKGxLqm4jXIuQEF?=
 =?us-ascii?Q?193zST1nru3bLFtavlfA4bfy/GWQLl/oWpoyI6nBnWW0pn+Nm95lBTtgxVr+?=
 =?us-ascii?Q?baXwrs528J9M+9UpUBbvJD4q2swsXh1LkQIonOc+3/vjT2VbDexUb55B0plB?=
 =?us-ascii?Q?pac4pjR7ZD9L1wrq9q8i8eghxHK/Vi/HeHOAvaToEHEFOCcYQdKhiwEoZxbI?=
 =?us-ascii?Q?1ChYw1ZkeVnb7I92G43d2ua2E1GPR99M3daprpvAu823LJTpGfuI9RRBdk7r?=
 =?us-ascii?Q?WxYTtl6gCvsXPPe3OnaJ0xGtwc4N0OmcbF1qrhyw0D5CzaHeUMaaQVBt+q6w?=
 =?us-ascii?Q?vyJy5CIDK8M1iBuZEsDwe1uKVOTrzlGQGjrdynWtRCTuUO9/HOQyFOKKtzuP?=
 =?us-ascii?Q?g7/4pIwaB1ntMH0XDQ07TzYvUu/OMr1i2Of3AJJfd7qrtqyNt1X91EOl+5oF?=
 =?us-ascii?Q?s37UlGVdSuQCU7SJ0wjR1L3UNM//ofh0nZdP0v/cgjGSp7RYNYEUmhYq23/a?=
 =?us-ascii?Q?pyCU6sSet5ifxhrXs7PHGohailViANDIoH5U7ihoeTVBltI2KnjGmw0swBfI?=
 =?us-ascii?Q?EfM4atKL5hLoFm+0CotLsN//vU3krVl6fDMb0ES2O3UmpeAJJ5vUJnuMcJYH?=
 =?us-ascii?Q?ngMjiCnUysBWgGUwuXXVnFKQ0ItYitsIsfXp6Qx1giZYH+moRlQ4ro27nIrN?=
 =?us-ascii?Q?x3O6daRv7WTAgsgERPUypgSqVoi4zMf2hbBOXorGjGKbq6sgnfiw74i5P0KP?=
 =?us-ascii?Q?I5cGioKXnr6e06/9CvTsgvdCVaI08GT5I9qEpUYA0JBWDii1ewoxtGOfQ9nD?=
 =?us-ascii?Q?ru46k2syeC9lSaP+Ez2+c4JGFmorvxbdpeWeIxwh0jb5F57bUqBiv2iEy+8L?=
 =?us-ascii?Q?wdekkIYrFGxJaMq31/xXRGmJzZ5W6G39sAw4Yc0I82FeHBJ5LPTpaHDzKZEf?=
 =?us-ascii?Q?sR17Ab2MhwZ++cfqOQ9E8j2OKaRi+LOeoZrg2gL/k7YK7A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR21MB1898.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lCIEvkTSO3gPInv8zHpf47l06982D8msPCUvaWVfvzibJpjgeVCtrSVA+RDZ?=
 =?us-ascii?Q?Nckj8WYO7aTLCT1MRnF4FtxH9zzbYSYjvdYO5RT3Y3ueBawQmNelluHiiVvu?=
 =?us-ascii?Q?vuvexbBCeamfM4VVUDIfSVwKCnTfsUAwlNTVCgZ1j2GA7BSJ5Mh7c1VKMooz?=
 =?us-ascii?Q?FUK0ahtqXk1t/dSdH5G+GGYb3jiB7cis7gIDaQ7JBBw+GAusHAsVPRMdPF3j?=
 =?us-ascii?Q?iTPFjjko6LijQ9JO/UvNtbUECHVQESneIlQqGulAd4t+LbXu0Z+BVJtXDZGp?=
 =?us-ascii?Q?qq+3SNXKnbl3qvzezteg7jcbhW6vhkUDmcQ1E1PYimNDuHzL0WMWwLnOlc7X?=
 =?us-ascii?Q?cgEP1SwQbi813Z/GLjxgkvc+FNoWBkt3tXa27BJ3UZUVljLHCK2S5aQHtbNY?=
 =?us-ascii?Q?UKhWFogJEpfq3j7UNi46IWvK/mN5s/an/hbcIYFL+be7gX1N89BmtsG3psWX?=
 =?us-ascii?Q?qtgdnI8OZuLozQVN+jEeEugcpe4kvB4Jv5GaZEJ/x0ROBwvwMYzQdPGvpCIo?=
 =?us-ascii?Q?hk6taRcCEnpp9LF2jyuvq0H+F8CH68Fobzv5NUhusCF1vJiL6dUOD4oDsRv4?=
 =?us-ascii?Q?Ele1J4x9wsLVlh8Q/iQoh09891DKhrUU8dRmFZLscYbXgy7++ldK1FMdVrZg?=
 =?us-ascii?Q?S05jrzDfKxGRxvFKcNp5VIa7QwMdNEjdf0RUgdw5RlfT+7agBVz5rI3xx2pC?=
 =?us-ascii?Q?yxiOL/yd73UylSTo81epqZ/GhGZsWcE3SBuJXIffzChnZATLNpMrXn2Mc0hd?=
 =?us-ascii?Q?LQ02Q5dk7cvRfcmIPwqbFmF/I6ozVu4mbSIBrR7u7x4hJ24LaLcyLet4AgYy?=
 =?us-ascii?Q?J3/ZHFAbsU13WFBp4q2AHX4gOjMeshSBXU+6qzQawzUMeVsOmXIuthcNpn2q?=
 =?us-ascii?Q?907sD4JlpRK9NaOXzrq2HgxoYiEXLUYv/9HEbVQNUHfZozOLLHYGzMkaG/Fb?=
 =?us-ascii?Q?NTxUD0r1tRWKkBqgrkOvJ6qCLUI4GDkoKmc24x0sHKxSJse58oMRa3YBIoIm?=
 =?us-ascii?Q?LTiBzSnYb9cw7vfilNknYbSE4Qdd/H8ePHFCNW5lBlr30QtjkTlO4DzOxRe9?=
 =?us-ascii?Q?UtMUhjx8PF5VW1QTuORsW2WIF2Us9gcqBbBoY4eTroyplI2fynOepblUVsPf?=
 =?us-ascii?Q?lWBRpzioJGqwkTQL0jTBLTmewoxDt4ZSKT/sd6FF08zv/Cb+2IjhL+1SQhaA?=
 =?us-ascii?Q?K5CsDeeOoJOMIEh03zyKWui/Ho1KTjaOTkMNn4ywT5a7kdw9K33+rR3+c2se?=
 =?us-ascii?Q?9jtYnmXA9Glhv1DbIzDYybiJgta3IsE8LegG2YsKZbh6+zntExOadYptGvGZ?=
 =?us-ascii?Q?+16cNcv5eQarPk8kEauUfs1hLFF8RVKAbl8ET5Ofehg7BQ8ybvR5P/xqy/kr?=
 =?us-ascii?Q?kgF36m1XMkcbFBiSl+DFjKr4KkAzF4J8UHvDbNSapWz0MPvq2J4FbY0cMrmT?=
 =?us-ascii?Q?dd1cFgoPgZCqPa0vbal4AFdarrlIT8NI7zX4OffDqc4nCENIdfQVWJh2nZah?=
 =?us-ascii?Q?Zbk/gAjrzV13rdehfTrjkVp+Ym9EDv2aj7TwBGCXMAGcRpDoMf1Y6Oi3jnPx?=
 =?us-ascii?Q?OTAnNlJUUXCrnGlu/gVH8+6PPNiWNe+oqZhjHbByNQSg4QsB/27+ke544lT7?=
 =?us-ascii?Q?VjpGQUJAtBjr4+R4wpe7W+pMaeKNiySdgSK7YX6wCfFe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR21MB1898.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebf0ef3-9317-42ab-f7b0-08dc6889ae02
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 20:19:31.8423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epicSffkXlwEhClPY9OOYxjQzYGrJEC7pkVpOQUBWWErRGUcyk/T6pVHJqcLa4rP3tuSvd4KJkk1XZzvCf9IvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3253

Wouldn't this make it harder to fix the regression when swap file support w=
as temporarily removed from cifs.ko (due to the folio migration)?   I was h=
oping to come back to fixing swapfile support for cifs.ko in 6.10-rc (which=
 used to pass the various xfstests for this but code got removed with folio=
s/netfs changes).

-----Original Message-----
From: Kairui Song <ryncsn@gmail.com>=20
Sent: Monday, April 29, 2024 2:05 PM
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>; Huang, Ying <ying.huang@inte=
l.com>; Matthew Wilcox <willy@infradead.org>; Chris Li <chrisl@kernel.org>;=
 Barry Song <v-songbaohua@oppo.com>; Ryan Roberts <ryan.roberts@arm.com>; N=
eil Brown <neilb@suse.de>; Minchan Kim <minchan@kernel.org>; Hugh Dickins <=
hughd@google.com>; David Hildenbrand <david@redhat.com>; Yosry Ahmed <yosry=
ahmed@google.com>; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.=
org; Kairui Song <kasong@tencent.com>; Steven French <Steven.French@microso=
ft.com>; Namjae Jeon <linkinjeon@kernel.org>; Paulo Alcantara (SUSE) <pc@ma=
nguebit.com>; Shyam Prasad <Shyam.Prasad@microsoft.com>; Bharath S M <bhara=
thsm@microsoft.com>
Subject: [EXTERNAL] [PATCH v3 05/12] cifs: drop usage of page_file_offset

[Some people who received this message don't often get email from ryncsn@gm=
ail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIden=
tification ]

From: Kairui Song <kasong@tencent.com>

page_file_offset is only needed for mixed usage of page cache and swap cach=
e, for pure page cache usage, the caller can just use page_offset instead.

It can't be a swap cache page here, so just drop it and convert it to use f=
olio.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Steve French <stfrench@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Bharath SM <bharathsm@microsoft.com>
---
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c index 9be37d0fe724=
..388343b0fceb 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4828,7 +4828,7 @@ static int cifs_readpage_worker(struct file *file, st=
ruct page *page,  static int cifs_read_folio(struct file *file, struct foli=
o *folio)  {
        struct page *page =3D &folio->page;
-       loff_t offset =3D page_file_offset(page);
+       loff_t offset =3D folio_pos(folio);
        int rc =3D -EACCES;
        unsigned int xid;

--
2.44.0


