Return-Path: <linux-fsdevel+bounces-44541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A349CA6A3D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D523B2E7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1128224253;
	Thu, 20 Mar 2025 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfTOVxHV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PhRxSkEV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED3214A98;
	Thu, 20 Mar 2025 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467124; cv=fail; b=U2Mf5XpmmyYEtE+Uoh14xSJGg/UWfyUjJE7FTCPs2VjQHu8SgBXzVFVuc3Fr6wblfqW5d3GJX6ByaeMpeyE4IV3RvozrcuhRq+GRqUT9LQFFzVff0MKfk6p9XigvXtU8+4/Fua8sigDe1JtUhASWnzSNZbZY5MWZ/g6Ml/5WFlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467124; c=relaxed/simple;
	bh=c6W+y+MCDrKAJK0z7DXLt7QLAfVebEGGAUDH5bYnA5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G6YmxBYvnrlf4n9SDtEOFPD+pVRubunhY0PaYwJNgX9Tlv/L83j6CDWz9mhIFLCVbe8CIP0yHOCKhmvl7BnpcT5jgXn9ZEIufI0GfP+7zjEC4UIDCxiJhsRt8l2QJ1O5ok+kvkQipC9fVTbZp4nfdejuzWYyV+D8h/MlVbKLWkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KfTOVxHV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PhRxSkEV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8C6qk004923;
	Thu, 20 Mar 2025 10:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lDKP0oQx3FrVoqiurw
	fim7ZeCB5QbFffjnXsocIAnHY=; b=KfTOVxHVsvxty93bIxY+D8iKd3LIK8vqs4
	x3pEVdQlIk1DclPxG+Zw3Z4ul+ipJDI0W+YOVD1JNthSm/YUIlEv6naGcoR8ZdKl
	FW7jEKq8hjLt/egKb7i+coNkKxgsFW+n3gr4853kT362yE+10QqwUO+akE3TrKfG
	Kw5E0aYiOI1RSLuA+/tO3FTuq2A399ziDhEYJ4o+F68ORw/zUm2IT30MpUiRvM97
	3gSGCBzuii6p6+yF29HVFSWwSNR9Bwyc2qChiR6hSqmFb3RQ4Rfpn4Z8NzlVU5kn
	evqWm2qdSi0/TGbIU6/UCYcjVDR+Hid5YcBbC/klN72PCaqWpe1A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1ka5v5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 10:38:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52K9f6aG009760;
	Thu, 20 Mar 2025 10:38:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm2fmju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 10:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO0rqoMjorJVmu2GoASzsQaa4z7muoFEmPXn3a2KzJnzEk6dwtp8EeGd/VpODGF73dYIQq6CleO/0bhdtRDT5EdIg/5arKfA0sXeljhp9Zlcf1DpE1pY4aOZ4tab9B4gTAFEoxbzaRY8AB30zg4b5T5pHl/ewry00FmorVa6LTrwBjYGeFmOAk4t9+TEFQFSJkaEVnJ+8BL7RZBzZRtkEI5sJxf90RCt48P7MR8Ng4jzJfBoENAsL/t1B9M2dDfNhfw8bTl/ZpYHMhNv5oZzBDLR2yQ4rjw+t/qdlNBj2xPqm3sERtE9SFPsfg1A34nxY06suXuEp185p5TB+F2Rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDKP0oQx3FrVoqiurwfim7ZeCB5QbFffjnXsocIAnHY=;
 b=bguNEwp6aomx+L9XUEnscwKtX9lW1gZds+p45pEHIIrouQJBagnE6zYEfBK+yJC7z6mqj9Q7AHH6f+wQHyYbS4e0Gj/Jxrd0frvqKqJme2iuAINcOMvlmO1u34Yv0UsXxHMwDKx53kLvfbdy4cxpellVSNYOWNicgB0RdraB++on/6E00L2/YtmzgeDrSL1fJUoBXZQ9vdwCWw+e/AmgbikGivkNQpQYgefQDIRLRE52qGJiv+er2GeaG+bozapGjc42qBKeE3izLjug6ZPoGVZVbg4Zb9O963ZLISvhapYB01zDRtYMj5rk1uIptfK67iShExzhrxMKhn//9ern/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDKP0oQx3FrVoqiurwfim7ZeCB5QbFffjnXsocIAnHY=;
 b=PhRxSkEVIjOgOfO39YEx5/L8HRBIKPiuUAegog6rcu8v5NPhFq6KrKgI/orQeVIG5U6wAKa/A8hCRTCKbvKp4y0IFhMAbnBCkokRUKahU4B7sJy2gy3ajrLxxbwRUfR1/nwj4u5F+ivBeO25aBVtigWTWAZIgT2FeHEb3EYu+Qk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8152.namprd10.prod.outlook.com (2603:10b6:8:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 10:38:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 10:38:26 +0000
Date: Thu, 20 Mar 2025 10:38:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/2] selftests/mm: add PAGEMAP_SCAN guard region test
Message-ID: <90d37a32-d913-4e15-bba3-1fd12747ff82@lucifer.local>
References: <20250320063903.2685882-1-avagin@google.com>
 <20250320063903.2685882-3-avagin@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320063903.2685882-3-avagin@google.com>
X-ClientProxiedBy: LO4P123CA0581.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 35563487-7eba-4d35-eec3-08dd679b5894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MzTfsdmyY0cIAhNsOo1osXPcjPsX3abZGyy8RaRiF3mni6SoiIqB20bG7TBE?=
 =?us-ascii?Q?GR+lzxzJPZKkNnqtGrQyuCSjhF3YVLuMQRjMcN0qDBhq87rIbg2On4BXndKb?=
 =?us-ascii?Q?9QYW0iN1B7YLQDApssfvlxSYz/OJRGoylWf9bvzOKZcOFSV2tC9WmcLncmYO?=
 =?us-ascii?Q?21sM7mFB3GmbVuZ0Hz2pJL+JVGAQeGUta3hsZ06Hq5ZglzXfO22HEM98jXKh?=
 =?us-ascii?Q?KY8QrzJbsDn30Z5mNU2+WvEUhC3y+HKa051AnUmNKAjJ1OVM/b494WB23Tw6?=
 =?us-ascii?Q?ud0t3JXU2e3xu1tPc76U/MjbUnnKloOxr+zyAAc+soxLurwUB1rS+cX1awJI?=
 =?us-ascii?Q?MDr7tz2qxKsb78pp5Fqdn5IsAActrng77ax738dBYiP5mQ+tKgKAnzK7m9Cq?=
 =?us-ascii?Q?yrxKEdSNCYCcZ94JZXaZAiTHqisfMsWkrpeQcMS0YUQ3AR2QMl/FMDQc8I9N?=
 =?us-ascii?Q?NTrnr3MUWVf2mpuT8J1/MVS/UQ8o7/pEpxq5b4I1EpdUufVaA/eswoNBGBO5?=
 =?us-ascii?Q?mod76bjV0CyGJffimcjXC4deExAvdXqhX1HKI0fWNnTs/UZhqnEIENMrLb68?=
 =?us-ascii?Q?JPorEw76p6h9rMzo7tvBOFQQP3P3mXa2y1h/e++DDS/5m9bQzRcZid19L93w?=
 =?us-ascii?Q?1E6BaWgrYwkjoK9wEb9+v93/scAhuZOhwH5hGyS7TXrLzI7UJrl753XT4I25?=
 =?us-ascii?Q?tv6p0bumq0pBClMVVZqfX4ViD6rqPmaW04n9bdanOzXvXG09fawf2BkG2yKQ?=
 =?us-ascii?Q?uXo7ygYXCr0aHRHXJMIgfyUggP+8ec2HzkNqyar4IfFOvAz+6cCUAx0Rq98V?=
 =?us-ascii?Q?U7QExAYjWWRkDri3wulpOKv2K0daNuERyQLmBn5ISH0qsjyOEAef+FDSdiP3?=
 =?us-ascii?Q?4QNrgXRYnk1tE3aiBO0qYPH6HGCgdOH5Ic3vu1xqSwL3S/ZP9dYpxt5ZT3V8?=
 =?us-ascii?Q?K7c49U4B0cY//c+o/c3RpRtNgTAf3DbXe8VCF/+BFXsXLxYCTpsXv9OiNN7j?=
 =?us-ascii?Q?ndqLM5GaeQVtcSqeYNWzdkLCQh00ELrdPcWqAj7na1ubw8y4hhaYXK0p0AOS?=
 =?us-ascii?Q?j5SiI08BRGL0fNg2npX1A7HgPXYWipVPyTXC9SOH4vh/Gs1dAtsTq7ZfYEbi?=
 =?us-ascii?Q?YRyPcle/M/u58p1HZKvTtetfqz6is0i+9dstATWTW6uY+D1aok6+NkxrzQ1E?=
 =?us-ascii?Q?nHJvehsKrfykwCq1OUa5jAMEXmYRW0q/8yKmlNTAdn3yrK+DrqCBJIK2IC7x?=
 =?us-ascii?Q?dImMQB2Ckwzj/q9siNQkFtMU0tIR8CQPuqwBroz641Mhs+7EzL4RnYOqAJlx?=
 =?us-ascii?Q?18p0eLtE8vq3AYo4QgRqLn1A8e/FlhiRvBxWJ5MgU2AIIi9kqKVV5h4FZU1A?=
 =?us-ascii?Q?EwNCcr3DbuRuGJAYO1rENuJ5cfyx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSjpWQxjn+PEBYu6W640r8/qq6A6AyxXGqMYkXpG3DF8Z+NdlL1h/XZxBRgM?=
 =?us-ascii?Q?Yt+oJi4f4mi0IWudkn1xD/i7pH58QxW0AMLgaZIH6g+tt/kjgII2EORqcPdh?=
 =?us-ascii?Q?d3pyPW04E2mmBff2Jye+5T95EIhnc7HyTbELDOR5vpcNS58Q/8oroSwVrbbs?=
 =?us-ascii?Q?kjbGlhB9jNdcXRfHTErFe8LwXPxibiZTrh78LIP2y9YNXErDPYLXj4UWEn2E?=
 =?us-ascii?Q?v3JvJWq0IxKvc46wYdDch6AFxRafd4R5X3Zu861q1XTMBC9iEM8qs5oSTAbE?=
 =?us-ascii?Q?V8DmFtBb6Sgw766sffKQr3bmbiK8Dcs7LbPdDsm1jigM28zZzV1Hw6ibVEH3?=
 =?us-ascii?Q?Xar8QRpeu1++8vM4wk3bBDHFt9Xnua0UurbacO47Pg1DA/gspHJwE9tpa6tk?=
 =?us-ascii?Q?QxsoVGmtvw0UnedQ3bXQHe6flylPIz0zv5CXtofLYUegCb6zOqbhTkpu7Kf+?=
 =?us-ascii?Q?AgR8HdF25wRz51Jje8cxHd954+VAuBOtKg40+wj+gL9MtVimIcgOH0IMyFGa?=
 =?us-ascii?Q?cE2GbbfHUPZniI471/RqDTYJbNIvii+PLpj53RuiyeJavCOZX2GqJeK4TXLq?=
 =?us-ascii?Q?apNZeUqFap1q5pMp+E8RIutIeaeCwthK37sFU7IAoCSDxfjnOkYQRP613Kzs?=
 =?us-ascii?Q?q9BdZ5cMpk+XD8/yT1Xu7lysz8X5ZRjGLNkUAmXG7EfdACejkPpLXWf4+Hmw?=
 =?us-ascii?Q?CrvI+RQU5hX3scsk/zS0SbE0QDzu2QRNGZmBSkrG1PunZG+dbAWdyjpIqZk0?=
 =?us-ascii?Q?sooCNaDZz7MPnJpOuzqrZSY0X/OUoPHiHnhKw8QxvbvgFFjetW00kjNxGZUm?=
 =?us-ascii?Q?UwrVRSXLlOYfe5yAZaI6sPxkibon1kWtL+2ZJOFnpzOq1ZRkEQXD2xPVCWtx?=
 =?us-ascii?Q?ISl1jje8rGck9TM4zvmzGKohlAiz0g1Qa9Bhtd+7Lkv6t2OkWGLUroQoyd0A?=
 =?us-ascii?Q?XnWIootaGwsMkstMaXr2+kvd3nmOd+FMVUzkB86gDuUL/eq+GKrdfjzexhjf?=
 =?us-ascii?Q?d6mz7hoMNMUGFpZM1XM8Xn6fzOWkSN28vixaCKwrDwkAA7+4j5h/BA7KOLEl?=
 =?us-ascii?Q?WOBZ8duw5ZkqaUnAyCOruFUvNuo1or1TBCSbtsAA4Xz1EYIre1eqCxGlKJ5N?=
 =?us-ascii?Q?7YFQfcMohZjYGh45o54whAz1rUWELSB3/z4yTiHm441uGedmHS1KRhEOos3h?=
 =?us-ascii?Q?nnKk2zIXdxaf+UCjvnqBgv5Xgw+GiRKii1pWMc/i2es2KtVhvZ/q9mmOs1vp?=
 =?us-ascii?Q?8737qm7QvORItBlgu6f9eu9tj5eFAi7vd2eqyo/PGZ9irUSKnGe//pK1wqG8?=
 =?us-ascii?Q?9gmZB2MO3pABTtEqACmUFtk4O5criYnnTnqGiTCIeugqmIbqSNaSdBq9l0Y8?=
 =?us-ascii?Q?NOAhmOSzSpafWcob9lm7xg3C75iDT3HF88/iDlGH5q7zm1uyuuPG1ajsyY2m?=
 =?us-ascii?Q?hgb8b5soohNrucAimAVcZwcin33soEw1AZBXhvF46aGOI3NxYUNNmheExRe+?=
 =?us-ascii?Q?LCeRshAoxljioOszlmBhm+3eJaZ/68tvj4EXe6ITYBwWev92E04RmrlE9abq?=
 =?us-ascii?Q?lsk6PxblFshkR27KPjAeRENao5JYJ2mpXRabwMThPbUisk2qrNoG3GTcRcwh?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vIUg4Hr2sseByS2QyuUh11c0547XUEu7h5me7t1x254GTE5Ku9bx0JWmrETrAHCkAOaCkSXtpwJg2M18vBj67qeOukYwQZb4pyiupraSre8/kP1x27yZF153UxpB0lTsXZ9whLpnBcTpg7smCaS3/kXyE2oZGW+MTfXOsbpzuBoUGmueKSFljxGj7/RoBMZxAXgeKUZNNyiR0vcCp/TUA7xsy03WamNpkGJ7tZ96kzmHFmAFvAb/VmIg4V6kXacMCW5mxTRSnptxKTNn652UWtlg9Gc37uThcIW183ugnrkHZXzXjUASI3IK5u9ipHbduFw84nC0BjEdT1ypAt9AJgsNPQzoyIO7apU3OF3SwTWCrGj/s0UymUdW/ubV6iju0UkSxmtyb/2DSJaLyFKHZEl/iEyV1wMspMOKVFMjL71+ESGSlx72SjSZbxTFa5/J1DwnKOK3rixtBD5rV/UcPZU4eOko3AddEYst/sf+v3YXnuqDVNr2GsN9jSdLoKoqRwhy1VXp6jAHUJ4hLYra8KM9CqOkC5F4VAEF8cNiyFKIZ0ysoYjXACDT+pPJMQr76AoKfCCy4C1Fw6Y55ubfpo1QcPLt1i5jhj0zqZZlPPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35563487-7eba-4d35-eec3-08dd679b5894
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 10:38:26.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6aQLq407k4nCtvJ016pUiln4of1ajsBikXB3wqyJmbtBON7ulLlhbmThmjhEbAmO4WhsrpuEwMRtBXEVjiI16Reb+EG0FPGnlqOsju2RBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200064
X-Proofpoint-GUID: 8SXyf0fSdxUXGOVPjjpSqA7xS5RdAyfX
X-Proofpoint-ORIG-GUID: 8SXyf0fSdxUXGOVPjjpSqA7xS5RdAyfX

On Thu, Mar 20, 2025 at 06:39:03AM +0000, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
>
> Add a selftest to verify the PAGEMAP_SCAN ioctl correctly reports guard
> regions using the newly introduced PAGE_IS_GUARD flag.
>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  tools/testing/selftests/mm/guard-regions.c | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index 0c7183e8b661..24e09092fda5 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -8,6 +8,7 @@
>  #include <fcntl.h>
>  #include <linux/limits.h>
>  #include <linux/userfaultfd.h>
> +#include <linux/fs.h>

This is insufficient, you also need to update tools/include/uapi/linux/fs.h
- we don't want to have to rely on make headers for these tests.

Basically just:

cp include/uapi/linux/fs.h tools/include/uapi/linux/fs.h

And commit this (you can see format of commit messages like this in git log
for that file).

Thanks!

>  #include <setjmp.h>
>  #include <signal.h>
>  #include <stdbool.h>
> @@ -2079,4 +2080,56 @@ TEST_F(guard_regions, pagemap)
>  	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
>  }
>
> +/*
> + * Assert that PAGEMAP_SCAN correctly reports guard region ranges.
> + */
> +TEST_F(guard_regions, pagemap_scan)
> +{
> +	const unsigned long page_size = self->page_size;
> +	struct page_region pm_regs[10];
> +	struct pm_scan_arg pm_scan_args = {
> +		.size = sizeof(struct pm_scan_arg),
> +		.category_anyof_mask = PAGE_IS_GUARD,
> +		.return_mask = PAGE_IS_GUARD,
> +		.vec = (long)&pm_regs,
> +		.vec_len = ARRAY_SIZE(pm_regs),
> +	};

Yeah this interface is quite nice actually... :)

> +	int proc_fd, i;
> +	char *ptr;
> +
> +	proc_fd = open("/proc/self/pagemap", O_RDONLY);
> +	ASSERT_NE(proc_fd, -1);
> +
> +	ptr = mmap_(self, variant, NULL, 10 * page_size,
> +		    PROT_READ | PROT_WRITE, 0, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	pm_scan_args.start = (long)ptr;
> +	pm_scan_args.end = (long)ptr + 10 * page_size;
> +	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 0);
> +	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
> +
> +	/* Install a guard region in every other page. */
> +	for (i = 0; i < 10; i += 2) {
> +		char *ptr_p = &ptr[i * page_size];
> +
> +		ASSERT_EQ(syscall(__NR_madvise, ptr_p, page_size, MADV_GUARD_INSTALL), 0);
> +	}
> +
> +	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 5);

Nit but might be worth saying that you're asserting 5 because every other
over 10.

As trivial as;

/* Assert ioctl() returns the count of located pages */

Which I presume it does right?

> +	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
> +
> +	/* Re-read from pagemap, and assert guard regions are detected. */
> +	for (i = 0; i < 5; i++) {
> +		long ptr_p = (long)&ptr[2 * i * page_size];
> +
> +		ASSERT_EQ(pm_regs[i].start, ptr_p);
> +		ASSERT_EQ(pm_regs[i].end, ptr_p + page_size);
> +		ASSERT_EQ(pm_regs[i].categories, PAGE_IS_GUARD);
> +	}
> +
> +	ASSERT_EQ(close(proc_fd), 0);
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}

Generally test looks ok though, thanks! Passing in my setup.

> +
>  TEST_HARNESS_MAIN
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>

