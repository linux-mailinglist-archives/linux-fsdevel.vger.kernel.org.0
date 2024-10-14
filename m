Return-Path: <linux-fsdevel+bounces-31845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACED599C0D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68511283BE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E88C148317;
	Mon, 14 Oct 2024 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7iXTq7R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AD4C7C;
	Mon, 14 Oct 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889978; cv=fail; b=HJdVKvKKfo6KQpKpxAZz77ergCTlG0e5kPbkCoZcuI8b4YDJgstvUpxBAa9IObceI0HsK9sX3lbDKacqTjfXxj0LqIRzrlWl1jU9tWJ9wY9fUE5GZqHZ0znE56ZYGi+hFTP60nas5wVEh8vMMje+fU84vZLf9eTpAjbAWqp16eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889978; c=relaxed/simple;
	bh=ut5HZrfJiIh1fusAwDef/4Dv1quQenYfTZI7THCJoKE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=OHc82cYMNCjWnDpQIVqxh8OzRKLO27nk2UPooJPfXvGR7hq74Q3OudsepsCZTOjr1W8Ajgpwp44LKnbcfsqgISaMX/pmJAwfSWyp2egwW1ev+qxlRTLSbh48yShrgNa8UvbklOwQq3Zm5NpgB7cXovswas3YZy7tjMKMhKcWhoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7iXTq7R; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvl5b99QXM4gHU3gC0M6Oz54TmyhyxHotNx3aVsjMPmCaTLunJMcz0ziSGnAAYSRMgFxA5dAQ8HdJzphacLGIh2EhlPnQ7wCPOv3brQf8nUjNeFMdWkyW1xRHb5M2r5UDyx3p+65DmdqBBG5Ijr5UtcWdT6H+sfEs5lyfjccmUrHE8QKpFWRh2wA5zZ38zeLkTOehxlSqFtAWj/qsXJ0Sg79o56GL16hgKUVpHJ7xrw2JLI0p9N1PW8l3TxAvYlPxaLe3XsNg3u3V2ZFmWvm93RfwZU45lxPJUInSPzCM+QDH6zJNu5frz11OUNAlEnJUFBRlyRjOZBruy8di7aluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihgsHPv9HiudpCHEw7i7pBartkdlM+Z7p+nFvFDj9M8=;
 b=I3bqTGlPAdHEyyHe3BTNCCuJx2iUZg+2INBhG4K3rooBL4Yk6PylfNoxrcuk93PjAvlvr8CuYe5KDTezD2Ln+etn6NSg9DYAJ8dmnUKpAdb20jqZh1JX/Te/9r29Im7753rtPnaxrVeLP+ShmeavNTLLHD+B2+Jgda3gbymUDbFWG6r59LCMD6+HEESOJNYtlYR4jRdvkV6Rez7hpyGqnjT05N+ijqpt9Sf77bcnWUCATTU+lj2oICHLNmiX5EG3vfOLCmD+WLbhgjewWxBbgxz2UTKog678bA7ImIPCo0Vv1Z0M6wye71pvFNAseCOBNTakzxLNfh2QCtEksLjg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihgsHPv9HiudpCHEw7i7pBartkdlM+Z7p+nFvFDj9M8=;
 b=O7iXTq7RrzUjD4dtVlcWP68EkJP+TDAASz/96RPKcTSAszA/y8hwucNMxgUqReIMzKPPtnTk10n+n7ZTIrVaeuTuctne01E+uxXJDNHOHdNZEziMeEBINklx9qA9sHqS0oL0s2FwJ6QAldeeMdtJhjXGTNLvTBrwTTymG/4jkedi4WneK+ic5GKIft7YwaWvb16hnHuVE3rppwuHRRmB2DcT8V6BzZAY87FcpoBnVQ9BZ+R7WJ7HZsVOJWKrJRYuQrvHisZ+jwfvOdvqN4jV9DV82evv24WQvbtzGTvVuaLqftfH0vqoT79TaPNirGtNZCUaOPt1iC5naVqBNmH1yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 07:12:51 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:12:51 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <78b49fc7e0302be282b4fcbd3f71fa4ae38e2d5f.1725941415.git-series.apopple@nvidia.com>
 <66f3567f76762_2a7f29441@dwillia2-xfh.jf.intel.com.notmuch>
 <66f61e05dcab1_964f22945d@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
 logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH 08/12] gup: Don't allow FOLL_LONGTERM pinning of FS DAX
 pages
Date: Mon, 14 Oct 2024 18:03:17 +1100
In-reply-to: <66f61e05dcab1_964f22945d@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <877cabnonk.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0077.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 626c7e94-14f7-43b1-d4bb-08dcec1f9dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K+R2bPfKE+S6BYKg+aUpkOHQZAazznc7GNByuYFFS/z/ScDnMP8pvarlLmBW?=
 =?us-ascii?Q?fWiQJbQjQdXqCplJP0w9wizSu/fCSQSL0QAP9h8SAW1rf87+1r3T0vff3Gca?=
 =?us-ascii?Q?H90OZDQkUgqF9+Wm3NpFBPRHFVki6ZoXOpMpjDeiBuGzr026lbIPXX11Y1WP?=
 =?us-ascii?Q?DUNjuha+9Ekmc28OQgvbqYAqPTc/+GjJXTjocnsUNu5rNKhXmoIm5999M3tu?=
 =?us-ascii?Q?28tR3dS0DMK8CWrrwqp01rDL3UQoMK1IzHeDdaDbDWMTwsCe1oAoA8KS2Bfh?=
 =?us-ascii?Q?7ypsK4FIOd9X4L6oMrVN0RLUSsnxn13kAwfFXUNgNk6DJNic9b4K6rYi0FoT?=
 =?us-ascii?Q?Q1cnSwYKjm9eZYSk4/kBih+BumW+g1eRgSoIpCCdFv1z0jHI9tx5/OL6TLf0?=
 =?us-ascii?Q?nGlaO6M5tjWV4j29mRBTuKryt7TyJAJqwZKaRee1sCkKi0ztvzLwsqbeDKrE?=
 =?us-ascii?Q?1Xfj602iuoH2yu32KViwCjar6sP3WT/gq5WAxOauAgDw+BJMNcWqp+ispL9T?=
 =?us-ascii?Q?VJqvUm++Wg21KJWJ8PffR9M7pj9br31KIcFKoS3nSfECkjn7m1UJpCs03O8m?=
 =?us-ascii?Q?HUzUI0xg7XKplGPX66ixfV93nxCLDDHV6coLSdWq2n+QBx8gz++swsB86mKD?=
 =?us-ascii?Q?mRBJNgUQXyEWEjyGGg2QJFuvAR8d5I6Gz4M4b73iLmBdyNa5f7L6jn+8cjaE?=
 =?us-ascii?Q?lvx9QNQoQy65DzAZd8Aor3L11qTO2dHpvUemoFQEKb9lD3aUBVClIC6DyUBB?=
 =?us-ascii?Q?oAnIg8U7T4DtJxgHTFRBiV1L/OME5HCHu6vXz5a3jiTjFGz4MAJNBmLS6sXx?=
 =?us-ascii?Q?KCsgDSyp+biLC7QKhUrmZI/m9wbP48xhqSHzgMaH/OVVxbwRaDSxQ3mm4ASi?=
 =?us-ascii?Q?UH6acRCWvMYf8N0H2b+7jxi4NvRRNsTfCqf2KJAl0SfxNrAIw9f/BllJ8bh0?=
 =?us-ascii?Q?1nxjbOSL9jAYbKHrLJIuvX0P2wLglOSF5TTCySFQPK1I/CthcMFkOyuP0geK?=
 =?us-ascii?Q?l5dxk/PvQovt8o82XevsPKdPbRSzKEXUGHyR0re7Jo30spq9nNpIGqXb8ZdV?=
 =?us-ascii?Q?bGl5Z+Jt/dgTLskhr5+OnoCSGvwfXEUtoxwnnMUs8Z/wp9AC8dLwKSTfUFkh?=
 =?us-ascii?Q?iAYSwN2BjlWP44HbQaJxeRLMdkmJBd6rfdhzL3qI93Cqea3SUMy+u95q8fNI?=
 =?us-ascii?Q?EXaydaXHCCt4dU//JQ3s23L2v++b7e5oXLkwwaBiVAmnv21c8tRMvGvswX5k?=
 =?us-ascii?Q?2rEdZbeklsAeNMFKpFXVYf1X4UWRqKrbPTtacuJ1Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ghcW9I5aIaJx1oZpCjpaNCdAov4eR2G8i3kdGzB8HEWWJLKBOHD3cIfCK085?=
 =?us-ascii?Q?1LQ/Y3pckd3PlXOSBfEb+HgZv20SPf3cKMfnclZmISqlLL/Yybva4V43Rguy?=
 =?us-ascii?Q?N8q1H39DiFJquDe29ViNkgJlLomr8Ha1DIaQBX688XSzFgK4kVCSitw84zsc?=
 =?us-ascii?Q?P73VH+stcZBv0631jXg4/v7wrTs3/9kYqdVToWLTLey3ZvAiVWXf6qXLLEtZ?=
 =?us-ascii?Q?Zj5PCKhVprIR8uXgIXprjEUcQyIdPnKxeIuNG3fmKLdGadvrfVAdWu8rLuTD?=
 =?us-ascii?Q?/3LVWcH/JdRER0Txe3/XHPAy2Hf8im9Mt2q7mX8oBIq3EWJhW6pcdaiIk2SA?=
 =?us-ascii?Q?kU5M5OsMS1oMf6BDqq9q9WDIsu6hk/q2QPyp5RMtESphpn8Nuxq1etpxj3F/?=
 =?us-ascii?Q?zOuUELfrQbXA/w9z2FQeE2K8UEl/OkOzx5XR2SbQFw68t3fyaK6rQNMxBV3o?=
 =?us-ascii?Q?DAmPK4/aW1ypTEQmzSYGnl59zeFnv370EFNtEHKOza2+UJkkAqTxLqYjVWRw?=
 =?us-ascii?Q?x5/ePHVW0fVJ95CWmg66rEzsd2jX/o1EShuFgYZ1V95ySGBHzaiijTf6Dxbe?=
 =?us-ascii?Q?6qJ0VaZxdWA5bcuOUCUQUNqnLCRPOHqwMSI1tHejiJSjy7idVmLcWKxyi1zl?=
 =?us-ascii?Q?PNdG87Puq5Zpj6Xm99Gi6PL4A4osZxyHgClW0MAMXM1OXt6MkmQ3++9oSfx8?=
 =?us-ascii?Q?7G2LKUJyUtmfJpAMk1yqnGGQ1azMXAroQ55HRTRwvKExOApvINsTOG8JfkJD?=
 =?us-ascii?Q?1lNHcPTRC0YLE/v8/jIM4KxRzQ3St0VoATx3/sp9v8Ds4uJ8k4URao18Zy7o?=
 =?us-ascii?Q?iKF15M2YfeOpN6SYLx2BjVrKtGY2hAMVW10M4JTrzYtLXcRZoAic5v7ZRmf5?=
 =?us-ascii?Q?Y4hqOPOhc4I7c2UcYQinQ4cZojoqZqOQV3eLcjtDs0X9AnK3Z/jgB8knlV++?=
 =?us-ascii?Q?+PLqu3OD+9qp3IV39JUAE5KGHhBhyjAvUbnR3w2Git7HqGuWhfrvjZwCv3Ap?=
 =?us-ascii?Q?IOn27sw7ivbs/IyCIEikYY+FgDQEBeeuMKX6OFHfCzv4KNxuIQy6mbpapDQF?=
 =?us-ascii?Q?GOW6UarrhKjrnS9/b6Gu3sTA87Iy7qQOjo0m5R2Q2Up5k5Qj+R1EVBq1ksdJ?=
 =?us-ascii?Q?BuyqMDmdNCxwwWTIyYdD+qjOtObrIVvJRUmFP0kxllte7qAISYbH2/L0Mvvv?=
 =?us-ascii?Q?GtL2DJEpzcEwEl6tJdM0vUFvqwpb8EcWWRhyOCOCWSAxdrC/byHjsZ9Vb7m0?=
 =?us-ascii?Q?w85CsbnkEIWMrTCP4Bw67gRnVUIyTLcBngsKzye4U2aUZUtfQF4sNtKIjqSd?=
 =?us-ascii?Q?jGtbejUgaXCxRdOkjPfW8LOZ278DMG+afYYpLIHtasWV9Gb8xpbM60QiBvQF?=
 =?us-ascii?Q?hY0Vo7NL5LATe9QcHTQWJiY8W0LLqkWozY5LgFHlwy0Kjj6GTUW4DLhcjUkZ?=
 =?us-ascii?Q?st4NL970vj4n1kfBju2DCNuY0JR0BvFVTE09Yn6mj0HzqtBnJSMh0I78iBpZ?=
 =?us-ascii?Q?b0Ch9XhHDV6WVoBhPebFwo9llgS3uJyjLGQauaDM7KGXpi3tnB1UN+VoHdc6?=
 =?us-ascii?Q?l4w+rm2yEFcxuV2agM/UBMlbQNuNCtUHDQKFI793?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626c7e94-14f7-43b1-d4bb-08dcec1f9dc6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:12:51.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fO1txldBhzppGAHfEEz7Park8c7GLZ/5TeU1rULeLGhvuh8P4g7TtGJIuTBoOoiIrQoeW3t4JO32qNfG++whw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818


Dan Williams <dan.j.williams@intel.com> writes:

> Dan Williams wrote:
>> Alistair Popple wrote:
>> > Longterm pinning of FS DAX pages should already be disallowed by
>> > various pXX_devmap checks. However a future change will cause these
>> > checks to be invalid for FS DAX pages so make
>> > folio_is_longterm_pinnable() return false for FS DAX pages.
>> > 
>> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> > ---
>> >  include/linux/memremap.h | 11 +++++++++++
>> >  include/linux/mm.h       |  4 ++++
>> >  2 files changed, 15 insertions(+)
>> > 
>> > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> > index 14273e6..6a1406a 100644
>> > --- a/include/linux/memremap.h
>> > +++ b/include/linux/memremap.h
>> > @@ -187,6 +187,17 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
>> >  	return is_device_coherent_page(&folio->page);
>> >  }
>> >  
>> > +static inline bool is_device_dax_page(const struct page *page)
>> > +{
>> > +	return is_zone_device_page(page) &&
>> > +		page_dev_pagemap(page)->type == MEMORY_DEVICE_FS_DAX;
>> > +}
>> > +
>> > +static inline bool folio_is_device_dax(const struct folio *folio)
>> > +{
>> > +	return is_device_dax_page(&folio->page);
>> > +}
>> > +
>> >  #ifdef CONFIG_ZONE_DEVICE
>> >  void zone_device_page_init(struct page *page);
>> >  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
>> > diff --git a/include/linux/mm.h b/include/linux/mm.h
>> > index ae6d713..935e493 100644
>> > --- a/include/linux/mm.h
>> > +++ b/include/linux/mm.h
>> > @@ -1989,6 +1989,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
>> >  	if (folio_is_device_coherent(folio))
>> >  		return false;
>> >  
>> > +	/* DAX must also always allow eviction. */
>> > +	if (folio_is_device_dax(folio))
>> 
>> Why is this called "folio_is_device_dax()" when the check is for fsdax?
>> 
>> I would expect:
>> 
>> if (folio_is_fsdax(folio))
>> 	return false;
>> 
>> ...and s/device_dax/fsdax/ for the rest of the helpers.
>
> Specifically devdax is ok to allow longterm pinning since it is
> statically allocated. fsdax is the only ZONE_DEVICE mode where there is
> a higher-level allocator that does not support a 3rd party the block its
> operations indefinitely with a pin. So this needs to be explicit for
> that case.

Yeah, that all makes sense. I see what I did - was thinking in terms of
is this a zone device page - is_device - and if so what type
_(fs)dax. folio_is_fsdax() is much clearer though, thanks!

