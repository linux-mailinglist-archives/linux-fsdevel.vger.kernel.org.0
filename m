Return-Path: <linux-fsdevel+bounces-13977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3213875D35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 05:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804DE281B10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B382DF87;
	Fri,  8 Mar 2024 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QxZ0W5MU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFED2D634
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 04:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872638; cv=fail; b=dPLiQffoA2mTCFKwDUpIBz1p+n1g+TJdFKiCLshZM/TiU8pkHIAfnVTZVr1k3cEfC0NYYjoaeMCx1yd6KwUCAVwcQo5oTsCkvYKvNiByxlhbIQusjlsos0axle+sJ+PrIPOQkqElvI467gosZtp0acqGVc5hampSUV285bEO5vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872638; c=relaxed/simple;
	bh=+GzP1GqYFbsG8kq+b0QRqu69jqFrsG61ia6x1EiAqHk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nnkCX2FtawQgTjyW9GOvGT/ECm/bpcIXYQZhhUI2UFPwzLx5z1ih08CvBTglhMfTkIiGL2kzNVKCOPCglo95HkfMyrfTk+08hDa+fXDDM+TDmiId3s20bxNVQfajWJNWLw+YxDRGowK7M9pYTfArkaS4sqvZYjzIkxp+j/4wWjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QxZ0W5MU; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODeUz4K6fwypEp0doNYzWC2doL/MfbqLRb21Tv+ZElLoAUsG8oyhuCILopQ32X3FlO6XDXStRyXdtga3i842ZkyDTVyJDqbzC+muBN+myIYLXXcDm0B34dnM5RToCYQEWmhlJG/V02lU13D2qvDqemE7kYVZn1Om9GNUxAHnITocBSdxBh6scpJ9WnOFKKW/gveiwPCB8ExUewN4eAH86F9VaeOIrlLfaL3AoZAxl9Apb1Y/L6vrIgK3knPQGZ6Ge/nqrxUFA/lgSRLmIjRk+ILXhM65BlGOgJ7n0Blc2YUPcVc+M+8D1px2MAEBbwUs1Ae2gWXqQJeZeQ/mS/jROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN6rpEOBCngq/2EpSi86+Zl4+zTNVXuqjVn0jS78Wcc=;
 b=lpF5vajQ2ujGjH3koLIz3P0o7i+Xvut2r2lYWfAlCoXkIBWq5kWNKNkajCMozng6P4Xc7SC5QUdKdCnOleYyhpomF2FoFtsVbsKGvBnD2aNsakqDXHZd3bIyhsVoA1WaLqr0RA0FrkCRNz6+NjG1VOOimGvp9kiSv2avXwoDimkKyyE1mb3XK1hYdF3TAv19eeSpUQob6LjKgTkLgrS27uKPwJssW9pU7wlRrXx3kjGLkxArjQAUzjHct8ny0fWB3Rz6R0qQyAKPJdkxn+17gIvtnYIekg/yPcb9xSkEZ7pM/u7wW+0snFaTCe5iOb+wJMTurlZquAFvVa+aov4o7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN6rpEOBCngq/2EpSi86+Zl4+zTNVXuqjVn0jS78Wcc=;
 b=QxZ0W5MUU/WyYl+Lo9odPAHxSSEDl6TQlmBkFIQCMMFtA3bhxrRfCBAWwV3+zIq5cCZTIvCzYcvE5wunV6IsyTwAk9ai7UhfD/ktaOHaYRCIDkhu0rbH1WiPmkiPga6VgsVGlCIpjT4jkhfFyDewiAx4bP5fwXXecN8GgqR7dPiSBnkfaFRHHg3FybrcGQa3bW98M4+pcHSmH3hm6JfmYq6ZQVoqQ1SeIgHvCFhDbyK/VROXvg7ikRlQlhNt3azbdArk09Jq21ulK59U98A5RMc8DFmo96PVXTDPP5SgwlLhtwocg+Op811tx9pPoCGBg7Vj946DWGcg/8GkWcCnwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 04:37:13 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 04:37:13 +0000
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
 jgg@nvidia.com, dan.j.williams@intel.com, david@fromorbit.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
 hch@lst.de, david@redhat.com
Subject: ZONE_DEVICE refcounting
Date: Fri, 08 Mar 2024 15:24:35 +1100
Message-ID: <87ttlhmj9p.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0070.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::21) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: a8480782-5d06-4b5b-4295-08dc3f296ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8kBGZ3nNBqna6p5KX7ki8vnXOEOQ6o5mqLzUuSu1mewAwkHC4FBMHmizc0Wg/kQkUxvJ0rwSKQ01G3yTWQUkPxaRCd+67FstG1nCjqalKJsAnK7ux6hMWFEBl3dn+a4urg6wcuKIG4FfyUP42Yq1MxMRh9UcpLIYnd2yG+REH//DeW8NZKf6FkAmUBAS7qG6ss4nT9CP1P9zT9uPb4RS1zJ/5mbEWhXS1JMD7q2lapx0o+6syw51gcQX9ziVa06yGsIVwxBIOCVyAK8gdL73PQx4btD4fZDbWakro8HYBiRkyuxRyXd9MB0g+tBzMjmItAz1/SuzAjowS3lsBFyEZ5LMYSNF3qupghhUL9q9l+euKlBgC/UZJ4yVFNuPpwkytcx7RyRiOxO71VaNms/BnpBXArYRMhcwrrVBWQk48ivAAHAOxjnEQpETrF+8uMFLw1Wk17iY/e9jPcfRNqW3ls4fwrdU3Gs5iAH6922O85CI5vTZ1SU/1J/xCga7LtMJ0iSrnbpxVUwUVCOi1W5qFERbLaBR6+0EZqUJhkHHwN9oUQwEzFhHqqI9PgvTGkekPl0YFcDc5PeBfFDetkcIk9nmdZ5GIfbDhaSpcziQuXibkh2msPlp2+98MhVluP65J5spW2VT43SURGhhbXpk2PfSeHKaUMhQcblrTfdxTQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJdCsvPvK3LlTku66YpyejMyr6we2jC0DHxbIAfwMakj80/nnm3hyj4mOr/b?=
 =?us-ascii?Q?NPz5bRGF13THSMKblGGJnjkCvdCkHVEqVqhS7NlcSuHKhtttrpymvKLbb50c?=
 =?us-ascii?Q?xiDg7to0cWCbzvEWFTuLGum2oFpR5/8Ot8ClzalhEdEf8E/IHUuJf4muEHDi?=
 =?us-ascii?Q?Pt02ujyWw5oUNLn1Ug2jKBEBC3sFpBYanUG8UgqX1lbrI5JsvMZWL/Wn72o6?=
 =?us-ascii?Q?RSMz5MlZ2hZJLnMxYB0LCqT510kBxIu3EmcjPLR/T9XqHoHY+kaeCjA5tMkw?=
 =?us-ascii?Q?vY5Ri1mSfXrA/+hdPoPtKS38vfrJExBcmCY8mjxxkvTkap+76nKenSvZq9pl?=
 =?us-ascii?Q?+B5qej6P1i0oyPt69I9O4r5RMVV2dObjqqe6hXzd7w39+99YG9lD6Whp8Jza?=
 =?us-ascii?Q?hndwP59MTUFxTScjfhTjpooC1Nn46ZsVC7yuL9yNGvOqvWsYCOO2HvOy1jgg?=
 =?us-ascii?Q?WNyua0fS3IUNchb3ZKnPVxrn46T6ViRoUZWYwu1NRJZAAGyMrYIZEjIWobec?=
 =?us-ascii?Q?qj7eUap4W+UfygLnM7RSay0FNg43pdlPPYSBxItpB4IU/9HyurSAxoErw2kF?=
 =?us-ascii?Q?BET1/eJg1pl9CZY6JwUdZeRH12/OysQPj4jF7kAbHl19fAVhSOUCg4D42MAb?=
 =?us-ascii?Q?Gao3MpZZDVkfG9JatzrWHOa05UKamCJxTtz5dQo3a5WUYtTJOyndo1QRr5bO?=
 =?us-ascii?Q?Xsc6/SYZuOgQpQbUknYmGt92vIDFRL5A/cEUEqnRtgo1h2p7WOrvddcZEGSi?=
 =?us-ascii?Q?H63FwALWfA4Sofi0TxRWgcZHW/lOpFPakZaWD2uOcgxesRKoFR8sk6rVixyG?=
 =?us-ascii?Q?guHU5GSrDDO/pAMRg9/eEoy9Fhn9VWIlZcM2n5pT0yPYyxgn5d1o5JAygU04?=
 =?us-ascii?Q?jNXnLxxUvzrtm42QR3j5Wgq4TlDdrdDQ+d3qeOo7D2crwrgbHJjkkh41/QkV?=
 =?us-ascii?Q?xHi+oBSIMaZLFN0qfCuG16F8dtRVhhLXNi8udWGAtXK4rXKxv1tBfvU9pWxd?=
 =?us-ascii?Q?icTYlJH+/QrGBxt/3msUYkXYW3tBKaEHMOBmdxyjWM2KGHw7n6VJQl77c5MY?=
 =?us-ascii?Q?AsktbfXhJzmnIplgNpksfms+Iy02gwUf2YbY0LxF1S/bDGiPhNIsXGaIoJub?=
 =?us-ascii?Q?q737iQYMWpRU89x0nNX43ZIGkfZuPzCCs1eu2nZHWTOMFzqJ2F7BGJ8BC1/+?=
 =?us-ascii?Q?1fVULxRdD5ATiAZoAEkyM4GFADgOH+dDtXdOAkkmFlufmCkp5F4sPPE0nJaF?=
 =?us-ascii?Q?7jv+xzpW8XAzw81VmNvSmJRGGxUPwxyNtBOKSy2fpuVTIHGing+c9HXFmcUI?=
 =?us-ascii?Q?89jDnI369yvZsU1xKFRhMhNKQ3R/WeBgAdegr7fBN1xFcLtAJoH3HArNzrG8?=
 =?us-ascii?Q?gcbSsD9+YXJk7jrMSeabwOSlgS3c3Irl1HE7+4Nf3KIfORpmmqLy5qiJ9tlL?=
 =?us-ascii?Q?X8v0NV85OH3XLgclVKBG6oC3AhqMrnF//NSVP1DkBpk7N3DmhLcVi5tAQFi5?=
 =?us-ascii?Q?aDpEjLK3H1SGHh2VpbAZRKFcp/SUEG3i+6gDVucI5AWQq0gloEts4TEM0jNt?=
 =?us-ascii?Q?ydnur/CeQ5TWSPyrdfE6VRJQvhM2ugTdeCTwh9lv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8480782-5d06-4b5b-4295-08dc3f296ca2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 04:37:12.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4Lioj3jGJEsUe3K5qrknBNAORKloVMGNzZ7kjLcIecwvYl+1NjjzgudISavM6MQgyRwco1cEC+S8z/yuoCkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207

Hi,

I have been looking at fixing up ZONE_DEVICE refcounting again. Specifically I
have been looking  at fixing the 1-based refcounts that are currently used for
FS DAX pages (and p2pdma pages, but that's trival).

This started with the simple idea of "just subtract one from the
refcounts everywhere and that will fix the off by one". Unfortunately
it's not that simple. For starters doing a simple conversion like that
requires allowing pages to be mapped with zero refcounts. That seems
wrong. It also leads to problems detecting idle IO vs. page map pages.

So instead I'm thinking of doing something along the lines of the following:

1. Refcount FS DAX pages normally. Ie. map them with vm_insert_page() and
   increment the refcount inline with mapcount and decrement it when pages are
   unmapped.

2. As per normal pages the pages are considered free when the refcount drops
   to zero.

3. Because these are treated as normal pages for refcounting we no longer map
   them as pte_devmap() (possibly freeing up a PTE bit).

4. PMD sized FS DAX pages get treated the same as normal compound pages.

5. This means we need to allow compound ZONE DEVICE pages. Tail pages share
   the page->pgmap field with page->compound_head, but this isn't a problem
   because the LSB of page->pgmap is free and we can still get pgmap from
   compound_head(page)->pgmap.

6. When FS DAX pages are freed they notify filesystem drivers. This can be done
   from the pgmap->ops->page_free() callback.

7. We could probably get rid of the pgmap refcounting because we can just scan
   pages and look for any pages with non-zero references and wait for them to be
   freed whilst ensuring no new mappings can be created (some drivers do a
   similar thing for private pages today). This might be a follow-up change.

I have made good progress implementing the above, and am reasonably confident I
can make it work (I have some tests that exercise these code paths working).

However my knowledge of the filesystem layer is a bit thin, so before going too
much further down this path I was hoping to get some feedback on the overall
direction to see if there are any corner cases or other potential problems I
have missed that may prevent the above being practical.

If not I will clean my series up and post it as an RFC. Thanks.

 - Alistair

