Return-Path: <linux-fsdevel+bounces-44102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A3A625C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 05:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD1419C0605
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 04:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910EE18DF89;
	Sat, 15 Mar 2025 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dmkMH3Mf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010010.outbound.protection.outlook.com [52.103.11.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D318A6B5;
	Sat, 15 Mar 2025 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742011771; cv=fail; b=bw8RUjvBdqw+WLNLDP2IpWcYzOqLeulI1qK9j01Abpz3ZaEI95Uo0qbOh41zAWkZuCIvBtYgXqACj9tlbmtzojc4afRkKAJhVTD8nRqs/s0sYnvFTi/pPdAR3L6MfP/3U4vGWAluSxEuWM/VsoROHz+48FoPWGujGQgNmwvM8o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742011771; c=relaxed/simple;
	bh=5xGxf7aDhr8h0zdWRw2/FkLNzZUr0huGTdOjNQlc2jI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lsheNaE8m67rUMT17ufnb7ySd6tXTVwcwjo5O3KI4MMt4sH0rEEbe5jlCfz3w/y/q0ryKqDR+vU17hqTeJcjephbhgtsFiQ0KTK3ULaiUHtEhvOky+cZYlLQI0pJj8ee7SB5SbJJKMvYXtDNYXii/fgqum/hGjtmh18Mg6fRQbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dmkMH3Mf; arc=fail smtp.client-ip=52.103.11.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQzpwH+lO9jpic+ItF7Ii44puVZpqFWqXsjSWNtZaUAg6Qb2oF4d4JpQuOrR9d/B+nNFTqYGlQDPNXHMU1+4uWOTqyFCJx4j7jvj7Ew2gW7SOvlnlCiAcvDIk6MvvmhMxzZtmsrM2oIkGLNLpTvrjk/x23pqEYy6hOU3RSzSRI4xPL2F1WPYj0LJIv3uMzHmeZB3RQnSz6493JDyGkvjkmGS8P7V905ICOTq65W47OkXMj9YVOGOnQsYYoosMhfC2U0sLywzyW2qn9J30f0Qr/P2eMzZivSnsx/2WGbPBiorPWoe6Jws5w4hWAl9F1Z+yUborijhAD13TD6Cl34W8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64mYpXW+f131fQnCaBygXOJ3YNrUCNaVkPytPqvI030=;
 b=LewznFo4SQK2O2qXcvtznpeehv6IbEO4LAZG6bh/oSMZlAGjV/xAuXEpA93i+rBBE8GjKb0sINNd3DS2FOgxDgwq8HJrqDe1C3/zQOD62yPKMhmezNipK5H4PREWvbnERD1bO+XFVoXe9jSi3ZnBvNT5QGocOc8gSdSagtUKrYqUHyrsTzCoLkFmNEoJiF1588HH0ITCQ72I04kEgpzqR+42sCixy9Yd3i/4S50BOttt5MgXOxgjXzh9gARXJtZuAp7YHNAEpctNveJ7fL//TIjfhulsuG5ABDPL97OlyvgLZjhnSJkfUMdaY81CT41TOOA+c8/kdKUIy5SpDar9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64mYpXW+f131fQnCaBygXOJ3YNrUCNaVkPytPqvI030=;
 b=dmkMH3Mf6gOpsbjQIfw63N1BpGauARGZJk0bPAOt9+9M9oJ1iDdWukeciis/rmit41rrw7oFalkGnqF2GjPuYY0mGfEF0AZnBVpE1H5HuJp8pDXiXWpwbfKpsvY5cxEjkVX0mMml2k6q9FLndH1KV4X1/poA2ACNe/8/dr4tYtBwo7GbpVWPiBvFrvXaaedZxmvzvdl48Z52WzVlXf0fmgAUnAMvdr6gNGQ5rHY48KgdAikzfxNXZCSdDjRkbWqdjsF/Jk0nEb1wFFC+W65EztZk7xpr03tl7oD2XeID5d0G0rm8Q/I7f8HzGdZN40IRmIw+80XN7GAwZtWFkElxkQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 04:09:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 04:09:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nico Pache <npache@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: "alexander.atanasov@virtuozzo.com" <alexander.atanasov@virtuozzo.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "roman.gushchin@linux.dev"
	<roman.gushchin@linux.dev>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "jgross@suse.com"
	<jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mst@redhat.com"
	<mst@redhat.com>, "david@redhat.com" <david@redhat.com>,
	"yosry.ahmed@linux.dev" <yosry.ahmed@linux.dev>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"kanchana.p.sridhar@intel.com" <kanchana.p.sridhar@intel.com>,
	"llong@redhat.com" <llong@redhat.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>
Subject: RE: [PATCH v2 3/4] hv_balloon: update the NR_BALLOON_PAGES state
Thread-Topic: [PATCH v2 3/4] hv_balloon: update the NR_BALLOON_PAGES state
Thread-Index: AQHblSmRG3n+QHZh2UuvvmIQtVK9S7Nzk1Gg
Date: Sat, 15 Mar 2025 04:09:25 +0000
Message-ID:
 <SN6PR02MB4157924B97EF67299E751082D4DD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250314213757.244258-1-npache@redhat.com>
 <20250314213757.244258-4-npache@redhat.com>
In-Reply-To: <20250314213757.244258-4-npache@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7153:EE_
x-ms-office365-filtering-correlation-id: 5e196a76-6ccf-4672-aa10-08dd63772cba
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8060799006|19110799003|8062599003|3412199025|102099032|440099028|21061999003|12071999003|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Joa5iZXqQKE7NVUcCzXjSnFMEIgdycBpAyBc8g5GNyArUUVMIhxfohXYA7MT?=
 =?us-ascii?Q?nVscz1F/GjckkqFqVTRb4sTDvZMrPhuQVFYeYJM1xv0xiJgIFM6+huWTB3Tq?=
 =?us-ascii?Q?JX4rjbbjpiryUwmssA7NZTzoKf6KuX39c3UqGwmjXax2u4CnEhJplupbXzJE?=
 =?us-ascii?Q?OCv53VXg/TssJJO2JEVKG9If+OirO6cJ0LIptXWW4tlMZZLBUVMZ8vyH2m60?=
 =?us-ascii?Q?3Je1xp5z2/IWu1znH6pZBBGJhy8hkjk8ny1yS3VIs0u33jCyTBQHehWbl+pc?=
 =?us-ascii?Q?jABCzIKG3ZiamgfExxCnI5a5i+QW+BfOM4XCNyIX57NY1EQxzMNddjA6iWz/?=
 =?us-ascii?Q?oxAdToaXP/0En8wlEyDEpHlFVz+xsdkFemyRubGG17h1EmYNj+zhcKaODvQ2?=
 =?us-ascii?Q?ShORWOs3MfubnnSDmMhPB/ejD7b9AWkvNvK5bcCnMMD/SV80wlRlou3R/fcP?=
 =?us-ascii?Q?EQ/EPpHXEB2shhtcS4YzZ3tDNZ1uL//bcKyQcIk+OGzhiI3Qtt2KR4W5OtCg?=
 =?us-ascii?Q?bsCZdQdsW7MtfVciEsvIsaHT+kHkwlrJXGWfl+m2dC+1cGjQ43485nqXghJM?=
 =?us-ascii?Q?mN6auZ9JZgZewfhaPu+nDDwUBAuy1OAUziSoVMKRHtb1pq49P2W6S0te9+xX?=
 =?us-ascii?Q?uyb3BnfPyKqwUcYKruWcATl8OyuI+AiljrN1rUUmS6Vy4IEKBZkii98d22Dm?=
 =?us-ascii?Q?DI7pT/aY1RFeyF1urZr8F9u6FfWVq4JfX+EzLgm7IpPpTDAFwoBRQenFKAQL?=
 =?us-ascii?Q?FQ1iS2Q2gp+wI14KVYIBzEteR2tN7/hBbIJy8kLD59gxq+fLAGrVOs7U5WUd?=
 =?us-ascii?Q?jDJjwWyWwr6Kgmo5QvYTKxh8etMjBKH8jDfnvCjQRo3kQ4xyASNdJqt5TAad?=
 =?us-ascii?Q?B+b2lsqtlVJMjMbNQ77OBIB6GwQbDtJsnFreL3FIdnsIkKUk3usDNf2w39NQ?=
 =?us-ascii?Q?eAWP5G/kZUx5QXxMDa0GD9LvuJBjclzsVeOslRzNas5k98hcUEOATSolB1SP?=
 =?us-ascii?Q?1mK4M8C9Q5fTjkfG2TjE7c8MSImWLUNOp8rYk8DdsFZjk8kt+lcrUYAtPeGJ?=
 =?us-ascii?Q?dykh+tIi5GNdb4P0H2NlhDOAeZmtyRsIF18Nau128bUVY71ak4M8xm7fjqzF?=
 =?us-ascii?Q?KKTXVtBsn50qTv/pt0a0GffSoeCJ4O/r7/10hlKW8rlXRiyXkisyjqsAwe5h?=
 =?us-ascii?Q?VtpIsLxOKIFgTWP8Rzwj74p7dx0QrivHjrQhMQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eScN9FUXkCFumpPxKilEpYL3A6pcx2OeV9QVYttctOZtaFitafTQwH/BR9Sm?=
 =?us-ascii?Q?cQrs4WjbYFhWVZAFnnpSgW6/O0kFUUgKDDVScjJS+9ZOzQgVPFfWV/WAiPsJ?=
 =?us-ascii?Q?9ACDbtKenrqV0C6eLpjPLb45dwB+9hF7k9iDmd9ohbTvIkt6Ce1BhXOaeV6F?=
 =?us-ascii?Q?KbRJ6QJUG/S4BBrJIBFow5M6xY/Kr7NnNriWQdJf3Fivwu1tIg2y0Sr1HhM5?=
 =?us-ascii?Q?aS13crVE/cNy2yHlI7eiyh+XzMGoeTP8lJxfkXTxnlWOKGhorxTGw0wNEK9k?=
 =?us-ascii?Q?ujrLXAWNaHqPZOM3pQDnaovsX5oVj9uwodKSKX6wsvsMcv8o1nXLp2Z3M4yn?=
 =?us-ascii?Q?br5+o+Nps5786UQsunf4GBIRQsJaP01AVqF0S3C23e0HQM+His4K+FhTEyJ/?=
 =?us-ascii?Q?1aYCv9PlMrB0YDTPYYdzydplPWB78ACTwrXGZ44PyiFTMTJZ8lgZ8zoav0O7?=
 =?us-ascii?Q?PaF8nzH47xjpQs+xp2alSe05e2jf27vMvBeQ7vy76uDwuMfImy7ORvMRN9PO?=
 =?us-ascii?Q?uFRVR1Vk7pRB8Gqbv/hQHhtO5XW4EmMT6JBPNDHvnjg3/iyWmw9POxTx877g?=
 =?us-ascii?Q?OlfgBvR+DYJG7axa0cS0ABmHtge75SCfJOHTg6Mb3Nu5NzkbavQfj36Aprx0?=
 =?us-ascii?Q?aSalBwu+EZnhKr2iwojXjut/9aqJyZ78+6wj0NMp6TDI2bgA/wCWvE+4yW/1?=
 =?us-ascii?Q?IDAZIB4h4PQ5SlCYmXv5WXlmY89K9X7hGHQrGihegqpz4LFdIlcqXddRO3S8?=
 =?us-ascii?Q?/26HultOgyKovp6i/dEBGMc7+BGBlvn3xWqd/famkzqlOLTE1QLJ2IYyXCXe?=
 =?us-ascii?Q?xndnIX2oOzVrIYqqy9v9Y1Wlst0KFdAeAbPtWN/xOXg4j0zWE7oz8axwb1ke?=
 =?us-ascii?Q?TBG55JqFXh1uzcllR1TcC6e+UXcEhh3aRTYaVgAOzFemfz6tM/kERy4zlKmq?=
 =?us-ascii?Q?oaBl8WO8YcIXKqp6uJhKR+CAn7xozXulwpEWXIPt1toprBCsnCYblQ7lz7Cy?=
 =?us-ascii?Q?XNQlpAfN7yEAaBSRj/fG7jFaQLfRB4Ul6U9Abc3x9TviK3XtmjgdH/WRuIiO?=
 =?us-ascii?Q?0jcN3nT4AFg2pYa8JPBzL/Aoeh79w9hJ54UN89XJ8udKyQKRcQShxvh3IuC8?=
 =?us-ascii?Q?+Qxv27OQjjmHrj/PgJfwMe5E+7fwJKE0maocY5B1AdrssLa0VYHThfghwar3?=
 =?us-ascii?Q?EHEv/T/U1QajrdOZ8Ia+5hBiH07HZ4N7MfAyzy+xEMWX0nXouv4tYqT8M18?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e196a76-6ccf-4672-aa10-08dd63772cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 04:09:25.8815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7153

From: Nico Pache <npache@redhat.com> Sent: Friday, March 14, 2025 2:38 PM
>=20
> Update the NR_BALLOON_PAGES counter when pages are added to or
> removed from the Hyper-V balloon.
>=20
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/hv/hv_balloon.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index fec2f18679e3..2b4080e51f97 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1192,6 +1192,7 @@ static void free_balloon_pages(struct hv_dynmem_dev=
ice *dm,
>  		__ClearPageOffline(pg);
>  		__free_page(pg);
>  		dm->num_pages_ballooned--;
> +		mod_node_page_state(page_pgdat(pg), NR_BALLOON_PAGES, -1);
>  		adjust_managed_page_count(pg, 1);
>  	}
>  }
> @@ -1221,6 +1222,7 @@ static unsigned int alloc_balloon_pages(struct hv_d=
ynmem_device *dm,
>  			return i * alloc_unit;
>=20
>  		dm->num_pages_ballooned +=3D alloc_unit;
> +		mod_node_page_state(page_pgdat(pg), NR_BALLOON_PAGES, alloc_unit);
>=20
>  		/*
>  		 * If we allocatted 2M pages; split them so we
> --
> 2.48.1
>=20

As is evident from the code, the hv_balloon driver already has accounting
for the number of pages that have been ballooned out of the VM. This
accounting and other details of the hv_balloon driver state is available in
/sys/kernel/debug/hv-balloon when CONFIG_DEBUGFS=3Dy. But it seems OK
to also report the # of pages ballooned through /proc/meminfo, which
works even if CONFIG_DEBUGFS=3Dn.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


