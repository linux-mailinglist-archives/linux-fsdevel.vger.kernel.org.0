Return-Path: <linux-fsdevel+bounces-18202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E608B67F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 04:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC84B282817
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A50D529;
	Tue, 30 Apr 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AiylHusS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11024030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017BD27E;
	Tue, 30 Apr 2024 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443789; cv=fail; b=SV1Hp0+Oivt8rbyZAvlEi8NMgiMJvVZ+hAE+meW3O8lpUhoDTcoEQsu3NzRAC7XUym2wKck6CjOxKntrvcNt0mTL4kiAblN2OaXgZBVH7uedpyH/sDDxblBn05v/xR0kORGAghRsnHokgP3cOvKnrKJfNvS9geltztRIiG2MzDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443789; c=relaxed/simple;
	bh=oK80EA//+Ay9OMIcizttYYWRqYT1qPOIO8/gsH606cQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqeMYkr961WxRQPjmCe32QcHcS7smmcwrnueHQpqMbbDoqL2UiRi7osnaYrXZokBmAkmXb3IYFFstCmrAhPQc3T4j53wWiOQ6fZ1mEK1sR9oRra6Loio1MEhGu3zvYWQnX4fVmCEsuMjs2c8SM8CkBPJJU9ydnVePOJ8Tg0TKHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AiylHusS; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMZXNEjca1p82x1ZfNh1oCAXPM5LpSKJordldtkZWvVp0gIrI7qJfM58OoSzOYx0DBjpASjA3sYmdrPPMoIfs7gwM0mvMyT0s0FdrduBiY5SlHeUJBuUwkkVpeHW23+n9KN7Ci6WklcwNyyhyKCMYVpc3eZ+k9e84LN3qQSC6Yo/XaF5lPK5I2u2AodV++ap3Y+bFDwNqRPwWpa7nsHxxzYjF7rJjRs+kwA8B+/X7BwzSCwjHHhkR4BNJKrZXI+Cbfqmi1q6PYPVXGqPTzlMcBXBX8ATJWQzkfKg/Q0Mgx/vl7eKwf+1aWK34P702opi51oRbwLzNBEJo5IpGmS5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX06X+SP/gmseQA4JOgOM0Q/NHpN04siQKOreRS9FpY=;
 b=Ab8G8Pzbci9EheEVNzwzsSrDNYnQCdNhEll7rBNXRnINGeWjnCnc2hBsQUXefrGh/bw2zgCteWtMq0h8tHmTJmWihpBPSlvXizbnKwJekuYkWIfTZT9OKOoYT3/q7vxstSMsC+Ycj4qxLwwn1++6ddN1HQxyIB4nxUcazfZwVKOSithuzDvGOygKdYI7/p/BrKnANfaU4jzUhC7BKis9nsKnu+Yy49X9OfuqlaVX0NI4DobcBvzSNr5srfciHFcieFGtc2Dkyumr5bDyBPMhB82uWj82Jq3XuPKxiJ1ZOifbggPb/ASA9BAZyeDDOm7I/9GinlWlIFswMtTJttKDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX06X+SP/gmseQA4JOgOM0Q/NHpN04siQKOreRS9FpY=;
 b=AiylHusS2epdjW58OuIEDz+/PC9q9yKADEKzzkWqLJ6m2vTn2vGe8Ao0HQTaqEbDuvtsR8NO4GfhETk9nJx3n47I1QIzQ55hm1j02h5ZDbEoHI807pJuOmYzZsSx1zb01rMtVDhQ634r2gGLzDXWMIbEJ35Kd3W50o6wPEgHEYo=
Received: from MW4PR21MB1890.namprd21.prod.outlook.com (2603:10b6:303:64::10)
 by DM6PR21MB1433.namprd21.prod.outlook.com (2603:10b6:5:251::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.23; Tue, 30 Apr
 2024 02:23:04 +0000
Received: from MW4PR21MB1890.namprd21.prod.outlook.com
 ([fe80::25ce:8539:f7de:dee3]) by MW4PR21MB1890.namprd21.prod.outlook.com
 ([fe80::25ce:8539:f7de:dee3%4]) with mapi id 15.20.7544.019; Tue, 30 Apr 2024
 02:23:04 +0000
From: Steven French <Steven.French@microsoft.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Kairui Song <kasong@tencent.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Huang,
 Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, Barry Song
	<v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown
	<neilb@suse.de>, Minchan Kim <minchan@kernel.org>, Hugh Dickins
	<hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed
	<yosryahmed@google.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, "Paulo
 Alcantara (SUSE)" <pc@manguebit.com>, Shyam Prasad
	<Shyam.Prasad@microsoft.com>, Bharath S M <bharathsm@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 05/12] cifs: drop usage of page_file_offset
Thread-Topic: [EXTERNAL] [PATCH v3 05/12] cifs: drop usage of page_file_offset
Thread-Index: AQHammhzJrsE0Xg8qUSGz+RQruipXLF/r7BQgAACgwCAAGNMwA==
Date: Tue, 30 Apr 2024 02:23:03 +0000
Message-ID:
 <MW4PR21MB18900803310D7D7887554BE3E41A2@MW4PR21MB1890.namprd21.prod.outlook.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
 <20240429190500.30979-6-ryncsn@gmail.com>
 <SA0PR21MB1898817BA920C2A45660DE65E41B2@SA0PR21MB1898.namprd21.prod.outlook.com>
 <ZjACcpyw1BDRT0dO@casper.infradead.org>
In-Reply-To: <ZjACcpyw1BDRT0dO@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba2b31bb-3b66-4722-9850-cee5dbb9d317;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-30T02:21:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR21MB1890:EE_|DM6PR21MB1433:EE_
x-ms-office365-filtering-correlation-id: a24f0d80-af0d-4dd0-85f9-08dc68bc770c
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|366007|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9sbvfxydr4pA3H/VFwvrCeD5zU57D/01fe1qfCVGgazl+BeCrmq0K+ovefDh?=
 =?us-ascii?Q?5qIe/WmA48HxgDJv3WUuH4oq0yYgDyD19/BUKJosY8hjK5no6/JxKLTODlYo?=
 =?us-ascii?Q?uMuH8gkb2PsEkAtxo0zXYBJQWLL+7iGoNvhpgwN1auzyFaNWnzxDkns09wjU?=
 =?us-ascii?Q?wWOy7qH5jX8J1SQvDt4K1r65hceTlxZ2LyrL1JqzssneLuVfeRg0/nK2Y9LZ?=
 =?us-ascii?Q?SM724ySx9U6rKdLHL40Rqllb93BnE46ShJGkdILH6x5McAWQDWgeKdOiK1uO?=
 =?us-ascii?Q?PUAfj0sXf9MiAikHY//Cr04W8d0yxjre/U90P7SuH0i/NAwe4qknoCRT6nIo?=
 =?us-ascii?Q?6BTJJFW8Ex9io9VG3jQJRuM5wEswlFDC5iovdM21NPrnwbPHBBN8yhNk838I?=
 =?us-ascii?Q?3jXi58ITm23+QvrLwNryibzK+/DrpIH0BqiU1InSISWvzsZmZZpkBNB1eKpQ?=
 =?us-ascii?Q?6uBR3LKO+lgbqzS2qB44dxT1DXzYQ0dNTqrotLrS5y+cRnbhr4xm2jsgJ0Jl?=
 =?us-ascii?Q?iGbINYN85w+Ps6vL3tw2egIS4TuMQWonF9yn+aLet33PMRQYX1idKfJ1t368?=
 =?us-ascii?Q?O4W8KZEbJ0JWzuC0El+WtOJGbWSXMASmQFHnRyxacd8oq+lIFUnWPw9Mmmkr?=
 =?us-ascii?Q?rzChPo3vEcWK+z0SwvFn+IWc8eP7GpagEgoxzg6ReEQlElZrz9iio0lkA5Vo?=
 =?us-ascii?Q?3zdy9GH/S7P8BlcuPq4oYamA+Xj0vjsrAAyeBK4zD6YwS9viak57avtVWGpc?=
 =?us-ascii?Q?m+MaSnXCoVglG7LZSARcmqa8BTtJL6Fiq8oGeIL5/OFleE/27ymcQIfMj6fb?=
 =?us-ascii?Q?309HUrsjN70Hc1JaL+EsAjRPYM/BDv79Teyaa4M2tXYnPsCHwOJyTh6Pb5jU?=
 =?us-ascii?Q?sK7ieDgLydWRx0wSHkeLe3BnjzqB7+tIi07psVNV21FzXUByn/NZK9FbXnmu?=
 =?us-ascii?Q?5cYB3QX3u/AoKFRxWlgRB3VZvUKuHr5LLtqYgM5cgb8XD0KLuZGqnRNDEd1h?=
 =?us-ascii?Q?MBWHFS7TKD5dA/XBTFy58MstXblMiqC317j76fpMl2o5C7DVQ/eq8qCpSkQG?=
 =?us-ascii?Q?mNRb8vewBVO/Ntl3ifEK0bDRaJUvuStsEzQgNIHFg3SX+C2NBbsJGhrKu0q5?=
 =?us-ascii?Q?q7ocYsBc/9m7veY1EJ22ziw+RHvtO5GLpRQvwiQn7UIzLwxchU8IncoXPXuN?=
 =?us-ascii?Q?ug/Mc+T42YZ2VA6frH8JEe9KP8LgY3qoz0BiKYgtz4UAxL4haNnm3EW1sG19?=
 =?us-ascii?Q?wVn3WNujUAk9sPmve37tMYb7kGkxf8XQ1A+zxK8D+wRzz5r5enOHZFErm1+3?=
 =?us-ascii?Q?sSctM1ZYvPp3Fhs02T3noGB1BRcbOvfHb0iBn7ILqjjZYw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1890.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yEP4ejmgeBzbLeIiQ1DN53JhrREPScNe4D7Gq73BOrhjeW/RWmggN+K+6ogq?=
 =?us-ascii?Q?XTEYo2K2y7fd8FLOpcdvzM/07+JHDxWU77QbYMMbUFt49nQvCkp9FfNw3AvK?=
 =?us-ascii?Q?JcflHgBvXLRoE9qxOE3PFKjzhBZHwCzK17cccYfodz1kREHNVAySu8OmqZ1u?=
 =?us-ascii?Q?A2TQA0rJfrS4x6ZIAnT5X5p/QgbzqnyyoJiKPleyfsf9kXtbf9yBxNMCn9Tv?=
 =?us-ascii?Q?5GHpSQ8V/Tf40pMjnyiyhaZCJAjUCoTlMB32uqYDJNVVUWu5w3pXsUh72pIb?=
 =?us-ascii?Q?snipvHmfu3QnBwFCFMaQ+Ului8N0tCdDt5mQuhVGDqkkCMIrREYdIvUVrwj6?=
 =?us-ascii?Q?Ybqz19765JeF8tALmvsm6p6a6Zn3dfdpJX7OfBD2lOlPnXL51yzlfhLe4lmS?=
 =?us-ascii?Q?gK8CcMF3p4lRH/HOIu4hNI593vPcw/RFYmZ38umcpjI9umFvtEDw0u08mJ/q?=
 =?us-ascii?Q?Hm9KT80+csQuVI5aKAN8N9nt00C9wqrNeWVElMGVujVXVyi7K7ZEH8PCze2E?=
 =?us-ascii?Q?4uX4UCsPK8jtotpRKWRAKf8J9Z796mV/8264yPIjRgRVdg4m+3p2SZIEiFbV?=
 =?us-ascii?Q?cinOM8xzQY4RjXlRJYGzrZpaGwfUeB8Bzem0i+Xsbjk075cSAFC1BroDiKRV?=
 =?us-ascii?Q?kylTs1kdZZSKg9ejMQAxqfByXMPp2FuyL4JoSo+ElTko69LVjpkPerVO34kq?=
 =?us-ascii?Q?CQQ3A3NNTt9aB9NPjk42jYl6BGussIucEX24GSg9i29wfrjdoo93zHadHsK8?=
 =?us-ascii?Q?ZW3XqOgHweombGa+HlrrlmflA70PPQuTMyUfLeegKcTxoG7+MvmNBK3dpibC?=
 =?us-ascii?Q?RE7S8qS0VVFzq4JoRLEx8ctRSCbPWzL2vxPiEGdt2bU0i2wh7hk8/4fhpO7n?=
 =?us-ascii?Q?IT/o1QNkgRL9YGgy6bAY39roVqwSPd0NmMO27GBzLQMpsQmgw8g2+cv59HHY?=
 =?us-ascii?Q?jwZSeG5Szcjyr6BhQvcVd+CUn0GvnrAisJ85j22Rsy4MEzJR5EX3uVSSr7Ax?=
 =?us-ascii?Q?Zq1uofXv1KnDj6zm71vJQF1tClUeI7iAv20qhg/loE+3RBQ0qMLrk5OGkWQy?=
 =?us-ascii?Q?tv7BGyJfRnb72rSYkBcu9cpCjMMBE5wZQ3I/gz5wJjwSzftz3VmLs78dhexu?=
 =?us-ascii?Q?4VfF/T4qkdur8IF88+1vbC3NZj4bAFpe3vWg5lING+cNdZGSYq3FUWDnDL50?=
 =?us-ascii?Q?lvpxIe1Tq1ql94t17P5gV1GJy9Ze96yU63YA4snrEZKWjDGqsUgkzcllUipi?=
 =?us-ascii?Q?tfGgESZfRQKqaipd16Jef6kORW8JqiUgruIZjEjPjKRzbb0vQn7ZGrDlQaz8?=
 =?us-ascii?Q?YUPMysp2boXFxhAr9fnVCjwv9TZ6kBcgF/LG4bKVg4DL5HVUJzliPgpVQuiW?=
 =?us-ascii?Q?2KETRDvY0phG4ZZ6XEdRF+BCVMUG01Pf99RlACZxqrEGX6dX+bsnUqqIfsf6?=
 =?us-ascii?Q?9SnJZQbqLJ3ynmcATuJck2nmJ8vDE14jOJiZflFyIeHPJ66FMxyqWGKY3fpz?=
 =?us-ascii?Q?qAPOuSsfuHxZnfxkxS/lhu3EiNEKAb8cmEMEQ5jbB75qu37DvE1nsCHccN8V?=
 =?us-ascii?Q?+ZISyuYlbQejuT7oi53Z95Wchrfq6gZJpSPs/+rtqk1B98sfx2bmcRT9uW/3?=
 =?us-ascii?Q?oU7h/Vc7xgPMMAU5BFvf9J27QiQ2boVqFoKWsm5SFWRA?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1890.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24f0d80-af0d-4dd0-85f9-08dc68bc770c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 02:23:03.9703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PN42rXfZ0r4TGA1gs67yqlbbPq++q59McFZaOQUzpY/5lcszQIA87/KkBSiLNkulgfbvUFJNMf9cnhlt5fWXVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1433

Makes sense - I will try to look at this fixing the swapon and reading from=
 swap over smb3.1.1 mounts in the next few weeks, but if you have a good ex=
ample of sample code (from one of the other FS that does this well) that wo=
uld help.

-----Original Message-----
From: Matthew Wilcox <willy@infradead.org>=20
Sent: Monday, April 29, 2024 3:26 PM
To: Steven French <Steven.French@microsoft.com>
Cc: Kairui Song <kasong@tencent.com>; linux-mm@kvack.org; Andrew Morton <ak=
pm@linux-foundation.org>; Huang, Ying <ying.huang@intel.com>; Chris Li <chr=
isl@kernel.org>; Barry Song <v-songbaohua@oppo.com>; Ryan Roberts <ryan.rob=
erts@arm.com>; Neil Brown <neilb@suse.de>; Minchan Kim <minchan@kernel.org>=
; Hugh Dickins <hughd@google.com>; David Hildenbrand <david@redhat.com>; Yo=
sry Ahmed <yosryahmed@google.com>; linux-fsdevel@vger.kernel.org; linux-ker=
nel@vger.kernel.org; Namjae Jeon <linkinjeon@kernel.org>; Paulo Alcantara (=
SUSE) <pc@manguebit.com>; Shyam Prasad <Shyam.Prasad@microsoft.com>; Bharat=
h S M <bharathsm@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH v3 05/12] cifs: drop usage of page_file_offs=
et

On Mon, Apr 29, 2024 at 08:19:31PM +0000, Steven French wrote:
> Wouldn't this make it harder to fix the regression when swap file support=
 was temporarily removed from cifs.ko (due to the folio migration)?   I was=
 hoping to come back to fixing swapfile support for cifs.ko in 6.10-rc (whi=
ch used to pass the various xfstests for this but code got removed with fol=
ios/netfs changes).

It was neither the folio conversion nor the netfs conversion which removed =
the claim of swap support from cifs, but NeilBrown's introduction of ->swap=
_rw.  In commit e1209d3a7a67 he claims that

    Only two filesystems set SWP_FS_OPS:
    - cifs sets the flag, but ->direct_IO always fails so swap cannot work.
    - nfs sets the flag, but ->direct_IO calls generic_write_checks()
      which has failed on swap files for several releases.

As I recall the xfstests only checked that swapon/swapoff works; they don't=
 actually test that writing to swap and reading back from it work.

