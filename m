Return-Path: <linux-fsdevel+bounces-71601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FECCA24F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 04:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E49533021058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948827F732;
	Thu, 18 Dec 2025 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qdUUPlvF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146702B9B9;
	Thu, 18 Dec 2025 03:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027525; cv=fail; b=Qb1csNVGzniWItGGjtsXaWEKvSN13J4UwZ3hjEOmeI10iaA07lUO58BpNFo0MLYYdKT50w07smCWkc8eBfYa7YqfwTzN6zxqy6qrVBw3BcF7C9687oE9O36K9CtuL6daUu0w7HNyZE+QeqPkBObs6o1aNJFMHhbjhyKoZ31TDFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027525; c=relaxed/simple;
	bh=ZxbPjg3eSiHGndZpOxQVJ/t8NBPltzhdZU5ttHVIURE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NpJvR7Yx8mRQiRbQEnZWLuYTRscKllQg6SfD0R0VTD9JO65x+nMQuFYU29hDU1ZdaNoUS3XjPJS0/e9tkeGJdb1WiUFyWoYCquRpgp5FLeT84rIcG9QLDHrZI1MLrsQJgaj9uXISLtxqPhK5cQF3PdaaC2dqxYDeN41XrhGxFi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qdUUPlvF; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfOlQdGq4zm+WZCR+3w8v2dCzBda1zu542YHcdu/RsIhtBoKbDhzVfIlv4J46PweNC+DX66HxsN8c/xU/o2hyaiWWIsOQmwUFFUjZb6C/4SC2rnKKxsLDBekBoLtdf7mKsuO0ehYh19F2JkMbZ1GvBnhKPSY36rzn8vRtPB5x9GarSYP78MZSt38HLDOCSZB3psEhM5sxqpBeJGuZiS7FEf3c3iTceIDMnBDm9uufL8UUIiHKKL3E+Bi6bqGZSFhZkKOI2rFEN2VYVbQN1NxXBLxufW66l9Bo9xfDjBwvvemFolOkXqvTcQJeV7RhBYQF2C00n62cV6ZRNwl+eZwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ChXVrGF/UG9JeLpInwTZ0O2EBEVnwKJyYDTSOSqSZ4=;
 b=mkhdhU2Ql8GnIiqq4SgZpT3F/TpG0Abo5xZbL1MMmoVhBezBE1utbPzn/1ZJ/755AOyRnIwu0V+4d66yOhrmpdpLrkjF6tSoYrFZ0dpVBs0pzo24I+0834drHs022moDQfHG/6NQTnZOTVPxIS1T8vYYJ+2lH1cbTbfBlL4N9nfGbcgyQ5Ljagu1i10bBP7OoALtF+NStPVeviqd1JHr+NmoL6bZ5nInH92Rpzb/eCY9Q+OEKXtVwugPLEU9o6KnXr6SPks9xnZnhdTFBGrzkz3BjoTvgLHAW4BMjy910qOyujN8B/0Ya4TpFYhPK7sroMFLt54iXglPm9utCw7KHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ChXVrGF/UG9JeLpInwTZ0O2EBEVnwKJyYDTSOSqSZ4=;
 b=qdUUPlvFJITs0EGoJ7FlfzK85I30Q0UrofPQFT+3MlA/Ry0+MPt0LV8rcd9b+ZT8SYpNwWErVPOXkC/XdEP9Vo8P20qXk3iV47BGKSRuOdoIRUR1kOPRM3LG0dFgw60gTcc3EAVg6i4Qi5lC8tI8piMoTLxhGa3KmNBWy+Jd+2MshgLZWoIh3hsVms+oJMLpeZEwKaD4sNEPVzNkP0OG5uKQccuCMO9seCCeL8WrdQhhSdU0WfMYRwy8g4U7n/UkyTDW/q/a6g3DuCYP1l+lndSJ/JEwCumxf0bO3kfukcmDAZcUa+5G0Qj7yPY6BKZpcWTPD3+ag4DVPyyF1iXd4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 03:11:59 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 03:11:59 +0000
Date: Thu, 18 Dec 2025 14:11:54 +1100
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com
Cc: John Groves <John@groves.net>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	John Groves <jgroves@micron.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Balbir Singh <bsingharora@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [PATCH] mm/memremap: fix spurious large folio warning for FS-DAX
Message-ID: <7ooj3r2sxzqw3wn5mxog5kl5bi4arz3i2santgsqtxwlegsg6n@a3e6jdssdf42>
References: <20251217211310.98772-1-john@groves.net>
 <694343cc7e89_1cf51003@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694343cc7e89_1cf51003@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: SY8PR01CA0026.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::22) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: bc20a042-a6fd-4bfc-684f-08de3de3350d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y7MJJaZebE5EhQp6sbBKW/jZinyEZ8vUtTIv7u1PqM5jozrQKLfiR4eAWfSR?=
 =?us-ascii?Q?+rENX7OjJJXOIqFxpuuoy5hXt0X/3TNqXMacACh7l8WWQbhoy9iSbPpILaka?=
 =?us-ascii?Q?08irnPdw45aV/9SE79fqvGBAxgCyElSrQqmn18kIyaxm5SF0s1EOleN6wkqC?=
 =?us-ascii?Q?tALmLXODow2uKL8Zxqo10pUQMWkKOvrNAlhm7XGp5faSS4xrzkjsAZJj70pD?=
 =?us-ascii?Q?2FkZyoWfUfkmZlpFop5Twj9lR6tj2cQZBWpoH9XP8HsCjqdnsWZBjhGHg59i?=
 =?us-ascii?Q?WuoaCtWm6YJiX61A+u3FCrYl2GAC2OLMmu7aLlfNLPg/nVKwehOFkxXv4IJL?=
 =?us-ascii?Q?sLRGKXjmbt5KNMQ3bt/qrwf/1NHYKh4+djjT+HiOotBnfi8KnwtOfHmhn9CP?=
 =?us-ascii?Q?6viqQozKn6bE4ZhJ1m9crb30OmXX8mdbBfXjd78XQQPTNBx5rLQRGWFlIv2l?=
 =?us-ascii?Q?4MIbazipnzZtkxxo1FZtfelu+/3Q+T+aFaA+x0+PBTMcBj803nCz5DAv/qnE?=
 =?us-ascii?Q?qrMx8SIY/mOzdYfWfujYOSY4EA0cVjSkcBAe1FLxhpY1U8bwnktdYCC6yqeq?=
 =?us-ascii?Q?aqb2DSFj03w7Q+60BVhzVq8ahMZfsAcoFmGB1SOoGd8QtXYQIGqT2yN+7iDv?=
 =?us-ascii?Q?ByuEoJCRSnka9C7xN6skqG9wgh5l6SmI48UaiqiIthT/tVej5sdZMl1phO+2?=
 =?us-ascii?Q?wMVjCOXH3nrxeZkQMbWu7XLbnymgo8FYB4/yXUYhbk381rIvAeleb0uXPdRI?=
 =?us-ascii?Q?ChgHLJZO4j0icQnMTgUybWDMRdHnq4fpaCnubmwYBA5RUrJw4tdVm3actwzG?=
 =?us-ascii?Q?EEWge9zes8K9KaGZIfdULNbHEZdpGxYf2Ypsefqb2LX1Eg/EJp0LfrHSm4FP?=
 =?us-ascii?Q?ucw33KZwm8ssdD1+5ZGSAnHGCQ3fEO1r6BtgZywwrBsVW0eVCjspt5MNZEB4?=
 =?us-ascii?Q?gTiOKrcDi952vQUpuIHWNTUZPPwEeS54j4LpVMa6QXMLfys0hxZwEEzkns7p?=
 =?us-ascii?Q?G3qdO7yJeXQUc5IoP/AntExQ4HMhhkh3oIiYgQI1AsrnBEGEAsebZZdLGIrp?=
 =?us-ascii?Q?Ab5kFwqvj41c3EFMJW6S9HaDjZtffsGaGYBIBgDPxk7jW4MQlhG80iAnMkXd?=
 =?us-ascii?Q?YavveSdKQkTkKj+QXw+JxILS6j+RqzwWWXLX2x74fcEEDOL1suCUt7P8pMKP?=
 =?us-ascii?Q?3rv5zjkwt5Y+jfk8AakZ+HZ3h12TTlQtsgqU68hy8ditPrM3LUOlLZ/ufR75?=
 =?us-ascii?Q?8Mqapn4WUjIL/RDUFXG+P+fC1l3QCKsrflRxb8rCFwByKgmtGnen29cut8sL?=
 =?us-ascii?Q?W3HA0252TMfM+FaiavXH9k/TXcX9TWu3m7mxBFwQmclVot7rROf1r6kksOLI?=
 =?us-ascii?Q?dduztdkzD8qVKSM0HAfXAwmghVRSHO7FXTg3kXOmWAT7xV+NZhUEjrP94473?=
 =?us-ascii?Q?jVAwyBcrI3v9ICqj84Ig2m9tVHXOUZP/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/xEkecxomR70TeTM/kgH2CKZLWIZjTBEohRTt44cmpCP2cBAYgNKBydyCXQ?=
 =?us-ascii?Q?/XlVYKT7cMvWKlanloh4NwXTkYXD5CU6diEzN5oxE4wkj2IlvRyC0JbDHjCV?=
 =?us-ascii?Q?1CXchwBXg90zC+FBBpQQX82S3PLgqjeGwqBAM2zv3EygGTse0lk8RLYAZQ/B?=
 =?us-ascii?Q?+SQEdQapxXpH4kYkWIjxFqSlHDRpvARNE8KzXpqrG1qeTGb0oNH1G7T4g1zR?=
 =?us-ascii?Q?ByYyJewhFwF4CStZsKiScBw52ev2Jf045A6UegRj1YSHl3epY+BKz3y4L+Vs?=
 =?us-ascii?Q?PKGwvtxXvn5O26R/CpGCQdwWgQgIOiHMZBG/AxyhBl5t/0sfv4AvTwzjk8o4?=
 =?us-ascii?Q?V/4In+lYul9WQu0fmP7PFodsvxZmZcLjkR2WFyuUqDfBu/6pOL7plphlfxfL?=
 =?us-ascii?Q?7BCvZjYIIgvwikO6ub2H18uDY5Z9DLNQbEUVBqc4EkLVx7htWcePBZ42OqD2?=
 =?us-ascii?Q?nlAU8JHN2BxFZqIvw/g4tb14hsceiKUPAafUI4QTFQGPQTEsMU/rltEA1HNy?=
 =?us-ascii?Q?iE1VUNjGbNHL89oKjDfNx1H8rQ3Bbips8et15JLW2GbWk5qJ2bgzRpAZmjH8?=
 =?us-ascii?Q?/Xut0JyqQ1CLBXubz+Sk4nJVGYHUuRAlz1SR4qlSHzy5eAmQp8PSfIDfwurk?=
 =?us-ascii?Q?6JUrPSvMb/1ZaRv/NLkEdk1HtwIF+skWugkb9br0u53lUOOvmoPbV/SjxVBd?=
 =?us-ascii?Q?7iQ1ijwmZ7/VfCJMnUBRL0lyR/1dGTlf2xVjmBNOOL9JYBqz67DubD12Gxzm?=
 =?us-ascii?Q?ZX6kNqJtsGCu3JFZl9Aa/2ZrB0FZKeh5hc0aX7LDvaKFfTIfli5b22pbosSi?=
 =?us-ascii?Q?STJotlp5WVlCIJ1MbPPgFbbOo2t5EhKvSpe2WOcgzkfqfqL+SdQuTpgOBlCp?=
 =?us-ascii?Q?wUsNrXClFrp1VCYcX+tntdHGt7QDJfOUiKraBJWb9UrO9jI9X1WbgMArkyFf?=
 =?us-ascii?Q?clrBzBijt3GIVOk4zzacrtXD+RGGgDxeurNDBeIBAvbUeLGFWRagniYBCKSw?=
 =?us-ascii?Q?2VBWqJY4sLnlYrqeA70Tn8NfD7uGQOd9aXFKP2P1acBDhoep8VDBR3IgcmlP?=
 =?us-ascii?Q?bu9SqHdzg41V+tEGYNIzxTkYLJUNKD2Nfs9JuGPJ7n6hzpO7nuN2oHX+6SkN?=
 =?us-ascii?Q?JKRodRsJKoavtgcxs6LM5zToImNy3dMnf82xxtqHqa6jEPzedw4J6A6s39rG?=
 =?us-ascii?Q?HMs0nE3w0ZJpBHV7ACpYLF3dlcn8SFHEgeYHgYAQJvaD/0NEEOV/wG7IZtJV?=
 =?us-ascii?Q?TmFAnpuxiMNLDVHMeVb7JAFT/gwFAREmaT9HmepJlqFo4FqzEjGRNyjEdSRM?=
 =?us-ascii?Q?s9VrqGPCKNSREFPN30zK5IRtMChr45bQ+KBsBZrIiXO4rAtNNfHK4aRKSc10?=
 =?us-ascii?Q?1/yAYAwpPeyPK0mq8HhXYc4L6NVYIGq5Jf6OUQ7w3IqmE8aMiYSzzlDViYvH?=
 =?us-ascii?Q?/nHHDaHgrEFlE1rEiO2bB6oxolaQfHRlLKzOzNv+PvLzjVbH0zkkdJ0QpHTG?=
 =?us-ascii?Q?LBlm2EvMYOVyygJP9cuWvxRFCXMXEy+nFlITiofDwEksnk3fw+CiNs54SliQ?=
 =?us-ascii?Q?aGsUPo6wtUp24ox+AaYFWZ62BuMC/bPnHmGeJ8s1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc20a042-a6fd-4bfc-684f-08de3de3350d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 03:11:59.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0baBwJrHHCAmLczJl3LShw+avoSKaIZRXwofWF6FjQPeRAntDr/bhqiLoxeo72uLhQTxlI66Q7EPe6Ia4DQXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069

On 2025-12-18 at 10:59 +1100, dan.j.williams@intel.com wrote...
> John Groves wrote:
> > From: John Groves <John@Groves.net>
> > 
> > This patch addresses a warning that I discovered while working on famfs,
> > which is an fs-dax file system that virtually always does PMD faults
> > (next famfs patch series coming after the holidays).
> > 
> > However, XFS also does PMD faults in fs-dax mode, and it also triggers
> > the warning. It takes some effort to get XFS to do a PMD fault, but
> > instructions to reproduce it are below.
> > 
> > The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
> > free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
> > when PMD (2MB) mappings are used.
> > 
> > FS-DAX legitimately creates large file-backed folios when handling PMD
> > faults. This is a core feature of FS-DAX that provides significant
> > performance benefits by mapping 2MB regions directly to persistent
> > memory. When these mappings are unmapped, the large folios are freed
> > through free_zone_device_folio(), which triggers the spurious warning.
> > 
> > The warning was introduced by commit that added support for large zone
> > device private folios. However, that commit did not account for FS-DAX
> > file-backed folios, which have always supported large (PMD-sized)
> > mappings.
> 
> Oh, I was not copied on:
> 
> d245f9b4ab80 mm/zone_device: support large zone device private folios
> 
> ...I should probably add myself as a reviewer to the MEMORY HOT(UN)PLUG
> entry in MAINTAINERS at least for the mm/mememap.c bits.
> 
> Now, why is the warning there in the first place?

Lets wait for Balbir to comment but I suspect it's just a mistake in
d245f9b4ab80 ("mm/zone_device: support large zone device private folios"):

-       /*
-        * Note: we don't expect anonymous compound pages yet. Once supported
-        * and we could PTE-map them similar to THP, we'd have to clear
-        * PG_anon_exclusive on all tail pages.
-        */
        if (folio_test_anon(folio)) {
-               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-               __ClearPageAnonExclusive(folio_page(folio, 0));
+               for (i = 0; i < nr; i++)
+                       __ClearPageAnonExclusive(folio_page(folio, i));
+       } else {
+               VM_WARN_ON_ONCE(folio_test_large(folio));
        }

The warning never applied to !folio_test_anon() folios and was just a reminder
for the comment above which was deleted because it was fixed. Therefore the
warning should also have been deleted.

> I.e. what is the risk of just doing this fixup:

None, I think that is the correct fix.

> diff --git a/mm/memremap.c b/mm/memremap.c
> index 4c2e0d68eb27..63c6ab4fdf08 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -427,8 +427,6 @@ void free_zone_device_folio(struct folio *folio)
>         if (folio_test_anon(folio)) {
>                 for (i = 0; i < nr; i++)
>                         __ClearPageAnonExclusive(folio_page(folio, i));
> -       } else {
> -               VM_WARN_ON_ONCE(folio_test_large(folio));
>         }
>  
>         /*
> 

