Return-Path: <linux-fsdevel+bounces-18204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5218B680A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 04:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1152D2832CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 02:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A34DDA6;
	Tue, 30 Apr 2024 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A40oOwct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7728BF0;
	Tue, 30 Apr 2024 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445007; cv=fail; b=or5hyoz11ICJO3wBYyphZuNP79sf2vPcgi92l0WhqXkrTqK7PMzTIG6A3ZNRe6tT2DqqFSxcgPRA3HjCbDtWK8MkT3DNvU98cly4eaz3XshNjNDoDf3Lo7ZxIcu3yqj8SLfoXgw1psoVXi0Z+0sN2y+omWeSCKgOgf/G5ann7KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445007; c=relaxed/simple;
	bh=y2BnX+ERJP31mZA2S3Oa7dkfkZq8PpWawmL2DUelWjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HquIyz38LPQMjDKiqSAJnjCsHT1NKsI4ZaNpJCv0K4LfV8sIwr6qDafJklGwuevNtx3+4U+KaNQH/GY9AL+eFb9wi+2tcOi20vlazkJGZo1bKjMTbI7JvgyfDV6SP+ziDKB/rYj7dsstL891BxaYmGTbo/NyR68EDIWS+qSQH/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A40oOwct; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds/+/kz8edUEX4sxOIUjzA5o/RQ24Fu7UlM+YyuGo+/hpUMqmw2L/K7Vy5dsQGqmUZ0RugxkPP8RFvKWY6B3tZ/EPuVqIqaqMVT/T/QT+l++iK4nZqpIo4VhuOwSYNAIo9SivQOT0iCFWiAuueKjY7Rt/pAcDjCxjtBzHQODZ5Pj/rLih5Tj3HqtqeHog+nEzdvsfzKDDzLtfXzo3iT+40aVN64bz2PR+2UBMqdiJYlnGDHAlKmPu78rDgY9nDBwqQ+8ua4p855C9L83Q4hibPfYGGDu9xM2jHtn/75L0S7oJ5UW2plEOFTJOf/pKTVOS+8EXp4wzwaMJLIvCysVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G47UzO0tV1p2HmRRgskrenu8DCrIi2/2Nu4VbqTcgtc=;
 b=mg7RboMGQjcwbBgGjogdFkFOeOSd+z2ilhFSJ5OmaT0NZrF4a4U8dP+JgSQ9fS5QZMBfg2Axhb26gXmA9iAy6DeNEJzwFJX9vo7/6ehjyPpd8g2A/I1GG/A2Wt6GJt6lsdMd7Id5wgZfFIj5yzJ50OxixJwGOex2KCd57gfi0K15gTYYayOqm4gEyZSFwOKKSrxcOZ0YZPRD3fNspUGaBugvOcFK2ty6TNftzjHECWpry3EvWjaD8vOa3jvgVE1thp+g31DsnNoxlNIpzrhoVvvmamWRqftgghNCyLGW9tRSdmZC/JrI7i3wOYZebn+xa72JWqMYAPW6rJTQ0k0URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G47UzO0tV1p2HmRRgskrenu8DCrIi2/2Nu4VbqTcgtc=;
 b=A40oOwctiO356ngv+vB6VTcLh1nwviGfzJA9/XROVFS1j24TYIF2A00xX0ZPoFxaxGazKzexFgo+nU1ULJoNsBSPppdyhgDSAp1vPkGSFiglWd3d/7aJH9tw+Z6BViJA71bR3XevTXbZ+FAyqvrb08H4PaO6ig0NjtN74H1F6Kma9dqux7FYfmuyugv2O2br9jM5T/CEbk/xdj4p522G/ZR1R8fr3zK10F9WX9qwaG6ZvucTUeNBTbPrBLPOp5IFPp+0F5Yw0h3qhRKcZJG0Fg+SiycaeJ9mTdAWF1+buEDfdTy5UvNvugL9HAuni7SMnpv9hg0/ao70DPo2kBypew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 02:43:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 02:43:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Sean Christopherson <seanjc@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, djwong@kernel.org,
 brauner@kernel.org, david@fromorbit.com, chandan.babu@oracle.com,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
 gost.dev@samsung.com, p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum folio
 order requirement
Date: Mon, 29 Apr 2024 22:43:16 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <202988BE-58D1-4D21-BF7F-9AECDC178D2A@nvidia.com>
In-Reply-To: <ZjA7yBQjkh52TM_T@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
 <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
 <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
 <6799F341-9E37-4F3E-B0D0-B5B2138A5F5F@nvidia.com>
 <ZjA7yBQjkh52TM_T@bombadil.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_EF07321B-D700-4B40-8B3A-E5EC5A712FCA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a78ba4-0438-4ae3-9ccb-08dc68bf4caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hpl+OmR5uMDGIhtYrrRxa96O1AwF4mENzIwPlK2BYyjcZ0zuWReBWcNencET?=
 =?us-ascii?Q?aGDZ4zlH/JozwGAUQ9Mbe77xn2LXBOtGWrFK4h4FhbY8RrJthSYOTE3L2E9o?=
 =?us-ascii?Q?BENYKz6+V4A7RjGm+jwUPlI5ZNOKOD7iF3wnopSQCyFLDAmF4HheclRGlj1p?=
 =?us-ascii?Q?T3Ur8cV2A/+pdflenjqHhd4Nm93FFXbI3sONWLMGyKZhmQIUvwz5LRd02STj?=
 =?us-ascii?Q?Bi0znDDp+/LrNm6UD4oH1MKzLKKvkgpXwLbMMMdXMqByErdCk+oWL6SpcSj7?=
 =?us-ascii?Q?NGTwzjVr7ZtQuT71Ztt1nBj0F06e9JgDY4Ere1kXfJG3CsiFbQ/zm0qBFPny?=
 =?us-ascii?Q?CNDZ7XdWO0Bb4CLuVJZY7EMf8rDCSNK6oKqz3izX1EzUOFkvTDTSPJi3ei4B?=
 =?us-ascii?Q?5oEkNOLWkBmczuSR36O8TLK4uRX9LYs3MSnxG1uCIUpBjEhphZ1JNezeLFXJ?=
 =?us-ascii?Q?xEFdV53Ay4DGq/oqMRtgIDOEnfr0Ecprl7H3Qz1r9TVPJAUMZ/DjS494sa9s?=
 =?us-ascii?Q?ta80tHQv9EcqID+f723PdpAG/TeXMP/B/5U+87AmMgX3wPelWVeKwE0Om2HA?=
 =?us-ascii?Q?fjIn/ttmDkxPEljOhEPlqFjp7wdRfzavJtfY4CV63jFk9bIkbUSyA75yarDo?=
 =?us-ascii?Q?FQXIlu2pcmQuwE2PeiA7QvrKXyfJxfWDvR+6+TgV5IBB7OSfrH/gUS8WZD6M?=
 =?us-ascii?Q?GqlKZ5+VMPh0IKeOHWxVedMez18u2QebL/QMownDCc2u0kdStafcCzcY7t4s?=
 =?us-ascii?Q?9lsH3C3yXzuk1wXIhtVuVmARQJgLQB0iCq4yIgnGGplQ/3zlC9FXN8jNAhMx?=
 =?us-ascii?Q?kK/kMiLEect8jYLvtgxmfZkopTA13twMlAveuj9h+i+ADpdwt5cpaPZzQ3qg?=
 =?us-ascii?Q?APFVjkrCpZPUOknX0jDoZQtY9UYCZisdhrB70EejpBljKLsiBsCv2As5M7m6?=
 =?us-ascii?Q?L5moH64g7sjEzrDKLGM4M7yjlpfdhPuQ3sWE8DY5UG9taLUjOi/o7mUfDZvL?=
 =?us-ascii?Q?zve177eJ1wbIdU+fixbQFTBMP34sayFPVz4IdS9DGul+e7ks2F3KOjG7dQmn?=
 =?us-ascii?Q?7paOHXPvS93CbDDKp1bKaawW/ty0RAEKA+M/wAzVoKfuuhvPg/VnlMgjWGsj?=
 =?us-ascii?Q?R8V1eUHp3CEI0zpuxrfcxUFe4pFv+jEYXzMIW71S5W9I+TawDUL8Jd4zr7/k?=
 =?us-ascii?Q?q1zk0iR89n/OiBzqM5cuowdMIkp7dMeB0orSZWYV/G3f5MX2qeXT8YT/1TLg?=
 =?us-ascii?Q?Zs2pZA7HwoATUvjZ5r7q+nH/ZwDKdw986vFLBqZ60A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/IhShNg9CbX+69F3wPdlp1sLDkgzahl7FCeG5fG0wWYZu7D7y/yUjj/5XP5?=
 =?us-ascii?Q?W3piryhPGCwJEcbdeQC/u+nN4c9Rmov9MkWgt5CVkBJ+3O6A3kj+k8JA7JXY?=
 =?us-ascii?Q?ioMB0CjA9sXLjcZrdKk+4E0L1X1wiSztxbgyKHwCy7R/MhhBGmCgRKfAf56c?=
 =?us-ascii?Q?3iGB39yr3Ctk1PlbmD+lCXsf7ICSaGHJ3MfesZ/zTg2eOX6GFQI4U7FEvE6v?=
 =?us-ascii?Q?VLgMXRGp9U81+BIAuKkw/GCP5MUgH7Aqhc5vdInWxEpwqhPd29iqMWoeurnd?=
 =?us-ascii?Q?98r53EKEwxWUniEpOKply1yXoOEoYfyuPJN41dIU/K1M1wYXVNdVR4IoA0Uv?=
 =?us-ascii?Q?vslgoO3Df/okl8iuaEFOgNFlFYlsMG8q+MIt797V14kPb4V1aeGaXYhblzcq?=
 =?us-ascii?Q?CtdeBpO7sioAXtJgcb7z6lx88p1iU+KwsDxIMbubXUzXXFI3kEvNOjJFrMo8?=
 =?us-ascii?Q?q90nEeVSzC0NGnuChTPMrEQ1GCnzNKQN28qpW3PLdnvsz4XobPp8nkOsoVqj?=
 =?us-ascii?Q?o07pQ1KCgokRxoCOorEdgbSGifZSKyrtKaZdEjppGtb/4ORlIohNVFgN0ta5?=
 =?us-ascii?Q?IXmrTgkDA70+GRoOxfog70oy4Bf+CCP6V0lEoS1b+jvJmiLFTF7/lYWgGlYA?=
 =?us-ascii?Q?ngfwmoWhiPyzOrBKUvljT8yFfUEEXfRAIJ04WgZ2frYks9f30CeaV0zunp5X?=
 =?us-ascii?Q?+GtqQWfEAa8oRe4070sWi+yXe5yrr2W2UNy91ePi9FSRd/wYvwrESAB6XEWW?=
 =?us-ascii?Q?/ya+VXuPh8PRNC2yVsZ33ItYJQyCbBo6StnyG8omh4p95qBp2Fs3CenhOnSA?=
 =?us-ascii?Q?x5FlrXBD2Exeqm4kKXaC8EtzrrLdiX2fSzftnDKvQSeY2YGFL3f0T5+GEPyD?=
 =?us-ascii?Q?LIZLDZmv3rp2yUdsMH03TnyJK2jyU+EeqC3pb2ClFqyijC9qsgzqXuEvRnNY?=
 =?us-ascii?Q?/Ete7Os1sT7uxGM1mbhCSkYETcJQGU5Z4n2Frfp1Umxih3DZir6yHcNDNMNS?=
 =?us-ascii?Q?3GwWobs1TiQYzKJeQ6d4bu9RncwArlBwM5ZYLa3mrhug1EK4n+6qsty/Cx3q?=
 =?us-ascii?Q?OE6/uwnVHxLWQJlmXn/JWJrfSd38ehPc+7gkqRZNZcLGvKmkL6aOZ+XFhljC?=
 =?us-ascii?Q?2VaOn8ZQeK/jVlTIWhm2GUnwbkdWH7zCtmdjuxc7NQwy+IicttNTHkigmL2i?=
 =?us-ascii?Q?1x0IXcksCiD3tTZaktgvYlhREqWyVqz85hIjiTyfBqVD1Q9CsCDVc+mjrkEt?=
 =?us-ascii?Q?CH+cIo4m4CCoPxUuNJg/Vkg0hnEeM5bhsAHy2w32uL7cqMk5LDPFWbH3iInK?=
 =?us-ascii?Q?5fx/NWVjNjh0Z7aLPAyCyuZwTMHzyhZdJbvmkChjb2EoUhUwps9MlLxNZeUF?=
 =?us-ascii?Q?A50Dulv3Kv74N3SV+Tl9Oy4+TbFrK40TZIv9PfCE2vXrHYOHGyZwgoBh4eoa?=
 =?us-ascii?Q?RXDL0vW46Bg0BaiI3u5QFaRHRe3hFpkn+/IIkgbGxKkFxZgtMXQ0MZuDkvcI?=
 =?us-ascii?Q?v2i+oE0Xtdbw0dRchmPpJ0WU7ftd+xE45JIs6W5mDj4uIV8mqDQzeoLJffox?=
 =?us-ascii?Q?JpBLP4A8hXklu/9qk9zU2rnhqyw1l7Whh+uBHhWQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a78ba4-0438-4ae3-9ccb-08dc68bf4caa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 02:43:21.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ejd9RH30JxKV6Wfhlxgvitf42HiTGXtqF8b0XSbH/kOdirWwjg3VmiDBb4sILhCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942

--=_MailMate_EF07321B-D700-4B40-8B3A-E5EC5A712FCA_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 29 Apr 2024, at 20:31, Luis Chamberlain wrote:

> On Mon, Apr 29, 2024 at 10:29:29AM -0400, Zi Yan wrote:
>> On 28 Apr 2024, at 23:56, Luis Chamberlain wrote:
>>
>>> On Sat, Apr 27, 2024 at 05:57:17PM -0700, Luis Chamberlain wrote:
>>>> On Fri, Apr 26, 2024 at 04:46:11PM -0700, Luis Chamberlain wrote:
>>>>> On Thu, Apr 25, 2024 at 05:47:28PM -0700, Luis Chamberlain wrote:
>>>>>> On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
>>>>>>> On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung)=
 wrote:
>>>>>>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>>>>>>
>>>>>>>> using that API for LBS is resulting in an NULL ptr dereference
>>>>>>>> error in the writeback path [1].
>>>>>>>>
>>>>>>>> [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c39=
7df
>>>>>>>
>>>>>>>  How would I go about reproducing this?
>>>>
>>>> Well so the below fixes this but I am not sure if this is correct.
>>>> folio_mark_dirty() at least says that a folio should not be truncate=
d
>>>> while its running. I am not sure if we should try to split folios th=
en
>>>> even though we check for writeback once. truncate_inode_partial_foli=
o()
>>>> will folio_wait_writeback() but it will split_folio() before checkin=
g
>>>> for claiming to fail to truncate with folio_test_dirty(). But since =
the
>>>> folio is locked its not clear why this should be possible.
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 83955362d41c..90195506211a 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3058,7 +3058,7 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
>>>>  	if (new_order >=3D folio_order(folio))
>>>>  		return -EINVAL;
>>>>
>>>> -	if (folio_test_writeback(folio))
>>>> +	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>>>>  		return -EBUSY;
>>>>
>>>>  	if (!folio_test_anon(folio)) {
>>>
>>> I wondered what code path is causing this and triggering this null
>>> pointer, so I just sprinkled a check here:
>>>
>>> 	VM_BUG_ON_FOLIO(folio_test_dirty(folio), folio);
>>>
>>> The answer was:
>>>
>>> kcompactd() --> migrate_pages_batch()
>>>                   --> try_split_folio --> split_folio_to_list() -->
>>> 		       split_huge_page_to_list_to_order()
>>>
>>
>> There are 3 try_split_folio() in migrate_pages_batch().
>
> This is only true for linux-next, for v6.9-rc5 off of which this testin=
g
> is based on there are only two.
>
>> First one is to split anonymous large folios that are on deferred
>> split list, so not related;
>
> This is in linux-next and not v6.9-rc5.
>
>> second one is to split THPs when thp migration is not supported, but
>> this is compaction, so not related; third one is to split large folios=

>> when there is no same size free page in the system, and this should be=

>> the one.
>
> Agreed, the case where migrate_folio_unmap() failed with -ENOMEM. This
> also helps us enhance the reproducer further, which I'll do next.
>
>>> And I verified that moving the check only to the migrate_pages_batch(=
)
>>> path also fixes the crash:
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 73a052a382f1..83b528eb7100 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1484,7 +1484,12 @@ static inline int try_split_folio(struct folio=
 *folio, struct list_head *split_f
>>>  	int rc;
>>>
>>>  	folio_lock(folio);
>>> +	if (folio_test_dirty(folio)) {
>>> +		rc =3D -EBUSY;
>>> +		goto out;
>>> +	}
>>>  	rc =3D split_folio_to_list(folio, split_folios);
>>> +out:
>>>  	folio_unlock(folio);
>>>  	if (!rc)
>>>  		list_move_tail(&folio->lru, split_folios);
>>>
>>> However I'd like compaction folks to review this. I see some indicati=
ons
>>> in the code that migration can race with truncation but we feel fine =
by
>>> it by taking the folio lock. However here we have a case where we see=

>>> the folio clearly locked and the folio is dirty. Other migraiton code=

>>> seems to write back the code and can wait, here we just move on. Furt=
her
>>> reading on commit 0003e2a414687 ("mm: Add AS_UNMOVABLE to mark mappin=
g
>>> as completely unmovable") seems to hint that migration is safe if the=

>>> mapping either does not exist or the mapping does exist but has
>>> mapping->a_ops->migrate_folio so I'd like further feedback on this.
>>
>> During migration, all page table entries pointing to this dirty folio
>> are invalid, and accesses to this folio will cause page fault and
>> wait on the migration entry. I am not sure we need to skip dirty folio=
s.
>
> I see.. thanks!
>
>>> Another thing which requires review is if we we split a folio but not=

>>> down to order 0 but to the new min order, does the accounting on
>>> migrate_pages_batch() require changing?  And most puzzling, why do we=

>>
>> What accounting are you referring to? split code should take care of i=
t.
>
> The folio order can change after split, and so I was concerned about th=
e
> nr_pages used in migrate_pages_batch(). But I see now that when
> migrate_folio_unmap() first failed we try to split the folio, and if
> successful I see now we the caller will again call migrate_pages_batch(=
)
> with a retry attempt of 1 only to the split folios. I also see the
> nr_pages is just local to each list for each loop, first on the from
> list to unmap and afte on the unmap list so we move the folios.
>
>>> not see this with regular large folios, but we do see it with minorde=
r ?
>>
>> I wonder if the split code handles folio->mapping->i_pages properly.
>> Does the i_pages store just folio pointers or also need all tail page
>> pointers? I am no expert in fs, thus need help.
>
> mapping->i_pages stores folio pointers in the page cache or
> swap/dax/shadow entries (xa_is_value(folio)). The folios however can be=

> special and we special-case them with shmem_mapping(mapping) checks.
> split_huge_page_to_list_to_order() doens't get called with swap/dax/sha=
dow
> entries, and we also bail out on shmem_mapping(mapping) already.

Hmm, I misunderstood the issue above. To clarify it, the error comes out
when a page cache folio with minorder is split to order-0, an NULL ptr
defer shows up in the writeback path. I thought the folio was split to
non-0 order. split_huge_page_to_list_to_order() should be fine, since
splitting to order-0 is not changed after my patches.

I wonder if you can isolate the issue by just splitting a dirty minorder
page cache folio instead of having folio split and migration going on tog=
ether.
You probably can use the debugfs to do that. Depending on the result,
we can narrow down the cause of the issue.


--
Best Regards,
Yan, Zi

--=_MailMate_EF07321B-D700-4B40-8B3A-E5EC5A712FCA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYwWsUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUJkQP/jJlwSz8+lc0hwOI2L5zXe7/wlA2yju2qPCz
U4zkdzfN854ZaBXOoA+lk/J2Y4sS/j/jf/mP4+wCqzHPcMY7meif+dx8z1wi7Kc6
Qqzw2DPKUivLoxaJK0GFfTpYnWb1azweGdx3cbUtWBc8cwCDkidEdyIzrnFDWvIe
t3y33+jGVhEX/xv98qKUiHDZy2IfzocEsyrO890Hlgq6cWCbe/Ip8qfbgtqrMwej
M/Sc5WjEKcRdJZKEr3n3jEaN0EM6jmgz92wQeu4uagxvoXWMpndUf6+N3j56oQU5
/TSDFXE48tNKub22EfwfvlKsowH9PbUDRLBzh5xbWQ9JqKRaGCQ28LkhjoFKgIzc
nUH/UDGBAqNvDJrzFoYfEOEiKp1M9MPpUJC81KYi4SgeibwafYLBQf9WTQo4F7ld
IEZWbhtldTybQuNO7eMvNNo4mu7Hk9vKTZnn04sfFw9D2ig6ny3ZEV59lvbixv7y
8/zBDVwWtZFG+Ym9QAwnz/ilfhMNzNqognAl5coaaznVZo7yAxhRWrI/CWI/zMC5
W0WqcO2zdCiIm7pZvh3J0ciJUOp4dOBGrjUJs0M/BSySCwle1GXsP6oUZiWWm74q
hIqoNU0iAo0OV7LgFdmHyff03jYmbokLcbHKXFcLLeUcxvfcleJjjs/JWmnt2kXN
OycMFdjC
=V0Y6
-----END PGP SIGNATURE-----

--=_MailMate_EF07321B-D700-4B40-8B3A-E5EC5A712FCA_=--

