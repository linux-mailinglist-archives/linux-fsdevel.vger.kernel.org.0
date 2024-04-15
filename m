Return-Path: <linux-fsdevel+bounces-16903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3288A48A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 09:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446811F23474
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B620DF7;
	Mon, 15 Apr 2024 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c9kwfq/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AB208A1;
	Mon, 15 Apr 2024 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164661; cv=fail; b=A72kW9LjEAzTf6z+ncDY8O55tQvyiWvJbOaLmuhnzFJ64XZ0hqd1pWfxE90uCJcsyyf0A3AuQGfVt6mOibAwUb6RdWWiInCm5Jxfw66TOh2PsotsZYcF2arhu+gYtYnewWAeXFJgvGys3Or4FRbgssNABjBYDE4gpdaypkiLl6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164661; c=relaxed/simple;
	bh=cttoIjtBHodnNSF4KhyqGrfB9Y+2RwNW8DlxQTNWCtI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=UCZfgNqbXMXARwzx60I8nh+kkC+85UWSiyCBzZGn2dM9qhKfGAr/osKVxX3yucydI0ex1XR0mM1P+i1K7XnKyHVgidYBcv9PkvtttV/5qaNrV7NlkKh5gCKRS1EAnVbS24AGh6/0OBf2sHOll36hheYmqJL+mHttYN8Smn0LCCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c9kwfq/U; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPQlFHfeg7/RWnz48Jnz9OrdxiFFZlQ3hbuF2XyiSKDDqQwuiNrlGJ/aginaT2YiLxdhaNXRtmZxRnsxTs8KdMKtQY8yP2yEulaij6TJTANlJzy2+ypyHZJXUOY1yGyJrFHX++INZjAgrXT2sbukh5G15aQ0S5txY4mtWLopyCMN+ZgrF8zyVimLtKNGXwVDwf4s9Iq0WaqNrb2Y3vgNx39nbTLj8xlDddyW4BY9nVbie1MfjEHqoHxsmXcj8ptRUJs+ezmcj1CQ/IszUx6Roh4oN2cg3nfpgIkgoyOWuXR2O42z65q0VJDfJG3kSe7chQIvvAMg9SlVbi7MyO2t6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIeuIvjipcZiQ8v4UiMDxXQexn9rRxYy6tu8l6VlE2o=;
 b=L3XjIgJA4Vj0RYgAVNZY8+ESs+nG2ZGodIzhfLV+IWqnpLIVZvqtRcF9yocRHnJ6Scitfoa/v7rVUjoY47qVQCzASgj/708o1xR3R5v3V0N6ihSrOER1sQcV/v5J6EjXMeE6ypuMQWAk25SccK758bFRkYmAdOgzTtqY/Cpx2JVWlHkV8SwjPBSdmIW9gagqh+n9eQw1QQ1xXcG6JCqJs9F+4r/38NZ8IRNbAmezXemh4fveM5Yg1bxYnhXpfmHl7Eo7cUPW+IdSFUEFdreMlayeoQqmKRaDhcaV2ukEPo8o9fUZE0gwR4aC9LHo4zX4BlGjR5AI1dvgAnLKWrV8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIeuIvjipcZiQ8v4UiMDxXQexn9rRxYy6tu8l6VlE2o=;
 b=c9kwfq/UvhwSEn/OnNA4OY9VsZIOROH9yt6iixH8dV5/zQkdKs5Rtmh3dOL5T7myEdbX9yUcXGVMWbu3wzWU7HFgyG4Q/P21DTndVITtKolYJyAlD4rlzJswkOgtftCKgZA+zASwPQ0uePf3GikG8NLMm4fZXkBELCm34QlmOgfmU0bknozblnZ8woddjFQA35gXrEi/oo3jPICggD26Aw8qP+HLBqWliLNknR3ypGA5gbRjyA7CKRnMRoJl411n/FFmmT75oLgdE7exqCb8L+NZ4M9ckyNq7vqa1PMmx+5sF63eT/ywKlAjk4rLe/FxhW7dvYFvJomXXVDFA7+XUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 07:04:14 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309%7]) with mapi id 15.20.7409.055; Mon, 15 Apr 2024
 07:04:14 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
 <20240412152208.m25mjo3xjfyawcaj@quack3>
 <66197008db9fc_36222e294b8@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, willy@infradead.org, jgg@nvidia.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
 hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 04/10] fs/dax: Don't track page mapping/index
Date: Mon, 15 Apr 2024 17:03:48 +1000
In-reply-to: <66197008db9fc_36222e294b8@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <878r1f2jko.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0202.ausprd01.prod.outlook.com
 (2603:10c6:10:16::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: e3265b72-f6c5-41eb-6deb-08dc5d1a41e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lLoK5JQH7xpsRPXCnTAEErxrasv5KoHIgTpvuGzveXq3GMJgBauOkZcePNZz0hne5SdUvSdJMy+UQa27SFY3FnCkKcZTLDbepmz3r8fC+mS4NpKurOb+i0Tyzii6yF9Tg5qpP20nRsV8bOhV/PuhOm58YL7ellAy7HLVEVu8nu4L58mGdXhtHaYHJ/Xdx62fhAZrC2H7EAquJNQ8hY7izLU9flSMwTGd4EY51tLhxNPQOA2hD3a/CA9xFaWCrMhtDcmxrBzMj5bel/VepQ4R36C9RD5KyTPvpfGmhb5SbPcMGvIhY1tPKjANhIl28DsbvIQbAOJsCScOTBYn0zWdd3FXouVjTRzICsHlTz0OlPL4J1cC8TMvK/oprYn/gVKQ1uq+g/VKvKGkV+Bh84UI3HUIXRBw7qhsfCX/gtW/Tj7OJ55lOkKESg2aI0cLp+SQp25yQQF4bryOICPpEaU+SkoWSAspD3pZ0F8VEfKc2JQDtWc71tKl+ow7lf/+DZLNcb9zBcS38osFvaiVpAIm7ueMCtY6WXR6IeZN4vkC8TaGCTw0zgmjZry+cqPJyf/1sLA/EQ14mvKZrj8CNTbjjcX/CH06QrRPMud4Cn3IBSK/co08VCUgiuML9HtlrvaS6q3IOenTpfX6IoQUd2aJDH5fncLfGTFcgu5l20hlpg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oxbs4m8nVJL9yCv2LFWsfhlnfP7OPK6q4kGCkjdi+Q95DTBXkexjnNjhoRD5?=
 =?us-ascii?Q?1mjDf1zJWuC0LIQFZdFg5f6ZOO5+o+oXdDo8QF1SjeZy192r9G/y3j3HR3o9?=
 =?us-ascii?Q?R2UpEtCKOWXpdAUlzpUKlfn81w9lTe/M1lczCDsxNLt0EkBshLbSthzhyYxa?=
 =?us-ascii?Q?ruMSm+BxjyCi7GMdJwnNDD3SG0IwzowpZBFh808RmRABJ8+ESb4PJOHE1h1S?=
 =?us-ascii?Q?TrRztrNjGbntmgi/NqsCLUK61yRlH1A03/YIXb47ppUjxQA80V5fymBkLNXW?=
 =?us-ascii?Q?n3GqM0I9greq/5v6Jm8wjF+5gyDeODqn+hIyEkEL8GP0qEWP44RDmU+BIBl+?=
 =?us-ascii?Q?YCp8Dvr94n5AtHSyqMXs+5pzwahTo7xyulSBOOL37ZAxdfU1EJqLFxAM2OXj?=
 =?us-ascii?Q?KC2CLkWF7RyBhFLSl2Ygr6nLG795HffWFgyWmuUXi30bIkgPJV72F1h9Avjc?=
 =?us-ascii?Q?RW4cdMK/ZTlsrI3V1rV7OA/dM2zdg2JXuVecwAj9G75UuuBxawP9hQNLePkl?=
 =?us-ascii?Q?LasOLaQ98xPeHCC4xiRkTDAi286HlE6ViMrpKGbIyS3XcvQvmIVafbojM45O?=
 =?us-ascii?Q?WcmJfmzYdRmcVzn5H2UtoYmmL/ohb4ePPUc9fDTAolYm6puab2pHNW+tLUjP?=
 =?us-ascii?Q?HYzzooacG6+oD06aEnmumyn9n+fpUtFUrhtZTGfTlLe7sqqs2VBKHL3FuMis?=
 =?us-ascii?Q?r7hvf005AXfbueTzdOoNPrJ2ES/1qSQXyg1jIyIJUz7F5P6GIqzNXnaGNsXF?=
 =?us-ascii?Q?mTPZ6JMBKC7LvTpPcA8J1F2+X+JxobjYYyHk5wo6ZNSeFBIGrxqhdt1fIybB?=
 =?us-ascii?Q?nEltrOpXMEeWaxh9uKpHz2cU8+uJ8WNhoosonpvgWop4YYW5WWeLjBDBWign?=
 =?us-ascii?Q?SqrLb4NFKBJxSJhmhtXZOfUlIsKLPJd4xxRD556sGeopUnDuN5iAxhGGwyMs?=
 =?us-ascii?Q?UPafooVKexWzNwlBduxn64w+6HJHyqUhiZ2JpVf6ldlVspIiAaEOdn/mUbPn?=
 =?us-ascii?Q?mUHEUwElLRAsNx0tZZJT7aHRsoIHhyw6uJ8w3uMj+tcR6yXi28jVCGEd7mEL?=
 =?us-ascii?Q?8e0Et8oI1SVOm0VgEs1YBG1A8PaMpVmCjGh4vBUP9krO52jIyk7rJeG503PP?=
 =?us-ascii?Q?ik/1DHAzqylfnxIIL5jmwbHQ9BTtPBhEyyaouKNhuMGXSsZan1OvY6CRtuxL?=
 =?us-ascii?Q?fdChzm/CzCRzLSbo1tF6PsiCPZo0zqPzmtXc/69T1n+vTlysODA+/F8+Z9CV?=
 =?us-ascii?Q?9HgXmTtnCGiOa00DDMeo7VEgutzxdDG3utUMVem/gnTed6+4U7mKF75Nf1Ww?=
 =?us-ascii?Q?LuGTq7INjZQVvwbCg7WwxQG2CAGLPJzqCshwoxi9VDaV37iCJoCXkZdghjGr?=
 =?us-ascii?Q?vCfDK+1f6hwIDvx/jFCTf3bc1MuPFVnwt9ZC5XFV3AXHkP1oKVnA+361Y2qY?=
 =?us-ascii?Q?nZC07cO5O9k+wiBjsudXlSx+xCVu2nIn+Y98ZF0IVP1T9fVvvhOQnsZ+yKxr?=
 =?us-ascii?Q?8k6Bzchoz1rsGWLmAvs/+xtGMa91sEjc+7NGg3sSMRvZZm4iV6xfRMjTOn4o?=
 =?us-ascii?Q?KRIE/QhQ/qdkSW9PrQS1KTAy6wyR+MNCTMiooYL5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3265b72-f6c5-41eb-6deb-08dc5d1a41e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 07:04:13.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a90xIsbIwgelkM03tc12ef60bgLCh5/tbcC9pWPoUyYQs2pws7/qiDukOd60DGmIXpFjX8yYgB0PSvuKNLpXDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775


Dan Williams <dan.j.williams@intel.com> writes:

> Jan Kara wrote:
>> On Thu 11-04-24 10:57:25, Alistair Popple wrote:
>> > The page->mapping and page->index fields are normally used by the
>> > pagecache and rmap for looking up virtual mappings of pages. FS DAX
>> > implements it's own kind of page cache and rmap look ups so these
>> > fields are unnecessary. They are currently only used to detect
>> > error/warning conditions which should never occur.
>> > 
>> > A future change will change the way shared mappings are detected by
>> > doing normal page reference counting instead, so remove the
>> > unnecessary checks.
>> > 
>> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ...
>> > -/*
>> > - * When it is called in dax_insert_entry(), the shared flag will indicate that
>> > - * whether this entry is shared by multiple files.  If so, set the page->mapping
>> > - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
>> > - */
>> > -static void dax_associate_entry(void *entry, struct address_space *mapping,
>> > -		struct vm_area_struct *vma, unsigned long address, bool shared)
>> > -{
>> > -	unsigned long size = dax_entry_size(entry), pfn, index;
>> > -	int i = 0;
>> > -
>> > -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
>> > -		return;
>> > -
>> > -	index = linear_page_index(vma, address & ~(size - 1));
>> > -	for_each_mapped_pfn(entry, pfn) {
>> > -		struct page *page = pfn_to_page(pfn);
>> > -
>> > -		if (shared) {
>> > -			dax_page_share_get(page);
>> > -		} else {
>> > -			WARN_ON_ONCE(page->mapping);
>> > -			page->mapping = mapping;
>> > -			page->index = index + i++;
>> > -		}
>> > -	}
>> > -}
>> 
>> Hum, but what about existing uses of folio->mapping and folio->index in
>> fs/dax.c? AFAICT this patch breaks them. What am I missing? How can this
>> ever work?

I did feel I was missing something here as well, but nothing obviously
breaks with this change from a test perspective (ie. ndctl tests, manual
tests). Somehow I missed how this was used in code, but Dan provided
enough of a hint below though so now I see the errors of my ways :-)

> Right, as far as I can see every fsdax filesystem would need to be
> converted to use dax_holder_operations() so that the fs can backfill
> ->mapping and ->index.

Oh, that was the hint I needed. Thanks. So basically it's just used for
memory failure like so:

memory_failure()
 -> memory_failure_dev_pagemap()
  -> mf_generic_kill_procs()
   -> dax_lock_page()
    -> mapping = READ_ONCE(page->mapping);
 
Somehow I had missed that bleatingly obvious usage of page->mapping. I
also couldn't understand how it was important if it was safe for it to
be just randomly overwritten in the shared case.

But I think I understand now - shared fs dax pages are only supported on
xfs and the mapping/index fields aren't used there because xfs provides
it's own look up for memory failure using dax_holder_operations.

I was initially concerned about these cases because I was wondering if
folio subpages could ever get different mappings and the shared case
implied they could. But it seems that's xfs specific and there is a
separate mechanism to deal with looking up ->mapping/index for that. So
I guess we should still be able to safely store this on the folio
head. I will double check and update this change.

