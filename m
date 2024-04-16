Return-Path: <linux-fsdevel+bounces-17000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6548A5F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 02:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33B61C2128F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 00:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80988A47;
	Tue, 16 Apr 2024 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0bPhZgC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226A36E;
	Tue, 16 Apr 2024 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713226614; cv=fail; b=JOVGyZle86ZTQ2P9yNvGjnCz5pEtSRJi6+A7HTOjw26oD0xsAeuciegjdhh2CoKdBzI5wJBAga8gwSDVBqS9k1o0nLwVMiqugqoZlToEgeoqDvLDj+cF2/5fhsa1wyVKYAPk9JdYm4jG9e/rdvkKmcrUmX5mAPvBO8+h5+/G8pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713226614; c=relaxed/simple;
	bh=Qd4t3XeCPvm7UqTayqJFb9VviL4mI9j5l61X8hZ70Bs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=XERcMlWS+2r4kmWjaE6dSXWhK5yPIvWzV5/Oz2dLOjl01frk65EJZovMo73r1P0xrpjJdekYhn/crwrw7CuAZL+y0FaaQyVDJvl9XfDhpFpwhvKFTstkvwOFwiZcTGr8nItwiDA+sjqVq6+2NxKh5hXelMiYrg5AoeS2EBk9QXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0bPhZgC; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT7oPkUvN0SXo1vVv47TX21tTDncWe3NwYDmUFMZbDGIX//OA43HQa8UQYwdFRyZyaWTWjMQyMeQUKksJX/NF36JGD6Gf+yvYJfSybJgWUMndDmh1hQjiYH3V2LHQQKoXKFS0NoD0ZpEJIzaJBT4QGf4D2awUWzQT5WxfdJQOUMDXJD3YLfaSedU1aZzZTd1/oD2fWLxPrKdkWqcoCX5+HHf/4v1EtRT9wVrV8o7FciL2AK8Gewd8Othm29ydtPOHdUlAq+aZKmRVHM6Fu400w1FdDnnjNiz1ETQKLH+OQsAHFyn24yqo7Ag5iZuqKIqQawIy3ASGUNdomZVmXIBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RDwLI4+uMyP32r1wV0AlcJEgJ34KnJ0v5Rdfslm0SQ=;
 b=Mr7hm9ltX3ytoOFH4+f+DEoXVm6YZ62Soz8DvHuXeVF3xC38I6T6zNKfNvUvPYyb5rmOJnACdX7tVDgDjY3iWzNTkO2XRcS4aym40Vd1RMvOBsgFFeAHZcmI14geKLZyxSkFvLgc7PzjBiYL821S+tILD/RtTpMgLIlBjlOJAcMjQHe0vCcxwaVRHng4ATpT5YeddDbC+PRf5d0aOZ0RZe04kEq1iGU1xw/7b5b61IYkpXGMmzcrL9YGMfFhZJnQsYRto5Zr8oONntcSjYFgCcMwBfGwXxbvGoBQcwwlB2qAXLqfTuThMJ1FldhbRGKLCxsorKLrf8G9TVxkFk97lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RDwLI4+uMyP32r1wV0AlcJEgJ34KnJ0v5Rdfslm0SQ=;
 b=n0bPhZgC+coDB/QAahMfsEO++9dynic1nkrQ2/FEl+DzjsPOnIwEVbCIZK0pDQGTIJ02+xUfNQUN4+eKy66k4A+/n7mHRMxoyxLEVssU8AbGdAasCd5dgyy29er3uPLpjfNkHCOPuKGEf67Vf97tcX5ePymGYuDE42aIdFftvcUPfljHUQ0co7bTTuJFVf47ehRGmJHTrBUtmxJ9ftr2hNBIg6u+RFdjFok/PTHfvC653quRoObAE7lR8ahJt5rKH/HTJVV6n5WXMUPcO4bvPJL1pU1rTpIP51C6RfiRXv2x26ulAxQBkvLhCmDrR9dhFTQh9WMp9aoB1z6hw2S2og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 00:16:50 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309%7]) with mapi id 15.20.7409.055; Tue, 16 Apr 2024
 00:16:50 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
 <20240412152208.m25mjo3xjfyawcaj@quack3>
 <66197008db9fc_36222e294b8@dwillia2-xfh.jf.intel.com.notmuch>
 <878r1f2jko.fsf@nvdebian.thelocal>
 <661d9355239bc_4d56129485@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
Date: Tue, 16 Apr 2024 10:07:16 +1000
In-reply-to: <661d9355239bc_4d56129485@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <87h6g2b1qs.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0020.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7a7bc6-a3a4-4461-f7e5-08dc5daa82ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0kyftUYbp8YdysnNgRnDLkMv+Cycdj4Swi0VP5uH/ocUi6GBP2cynP//VmFeGqjo7pcdlR8kTNfTSDKSctQpb8gbccTLSCersT5J4cUnMFPqYiZGIjERii+jhOtv4FcGnXDh0YnWDWcyJ/sFKP9Ouk035gdd2mGQuiRO/8RQkqoOWaT/5nDVfmP0eTK3N+1foPUVSrJIqUkkv7RYwEtKHWuOfQdgw8ZqzNKL0WSFH/cNLm78be61Y+7QZDleyGXourxVJXFe8DQurzZqeuFUiYpBSC5hCDwe2gHS8k7oBe7Xsvm+cmXpVz/MqiJlzTrPMW3BwEqd6BmhgMNltIm0rPGHNm3dd9UOb+RsFfd6Ljdg9pv+O/oqH58eIIRH1qCL352UHI6QVaFeKcsXA9DQQdk0jPRm5oGOip+nncFaYzetn6CWbliMYrYqi+Up+vXvZK6PEKCu2V+tkj01C7Gxm5H0ubKqPKLfV8LXjnJLF8Rtm0KXPrPmwBle2/wEP0UFjkov/81e2ZRHNvuFSl5e9RMNRxOG0QnEjpNELTloo7UQI3pWDuHMoY77I4xC7M8fIg69VBYExdR2fwaINUOhenJN7kVEbP9r2WisWpHU4jR5Ayw7I4mRZb+qdoP1DX5Nkzp/k7e83qOJ7qkzydxThpq7NWvOo9jYhWy8s/ceHis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uvr2ZsR2hYkU4CywJklD26nFxTn2y1dsoe9Ekp8Oq54t0oDjf3Mx3G9vvmb5?=
 =?us-ascii?Q?ZpZk1kIOt1A1EYFU2QmCgsHOwpM5mx3/AsBGBXlo0RWIT9PFSB1KjSHQIQfg?=
 =?us-ascii?Q?xd62KlDXA+75PJQbmFE9AWff237BH9r+3sPtcsURh0Ra0q193a7bOZKyPwDC?=
 =?us-ascii?Q?WEPzWvOBecW9YF4nnnI2a9DYTFXQdiofrrB/AtGz8o147A+cRaiWDKUEXUn0?=
 =?us-ascii?Q?xt22D6f9p4pOmowWxxhmJk1WmBVpGt9AadrRkYCxXxCchtXdEAZnOcnFZh+v?=
 =?us-ascii?Q?3uuAd3Juay6op05gZtKwhKjpGIcI37Qjii292e0hdBHsk9R0XHeUsrf58ws6?=
 =?us-ascii?Q?N8kHYGnIrgFN/O+FupXmpTMhMpYYweWthK36Fsr/3JFxYNS0A0ksGkUG7R15?=
 =?us-ascii?Q?GbQNvK8Tg956Kk84alooFhOmUY4CWRzKgftujB+KcHGDAwPnXhA+LrihNst8?=
 =?us-ascii?Q?ldOZEUQF87v53XkNB7IG5e1SAigPwkSQlWOZl7xo2UU9eYsudH59JmoFeBA9?=
 =?us-ascii?Q?fXKDETdJhA9myM+6xH6NTkEn7Q+ez1LqBLzeI8uP+Lvo3yo/dyxOBQRw6hY5?=
 =?us-ascii?Q?4+CQ1JKYsLbNJMVwMwBMa0rMQVUHttCTBXaevlHU55iZJoCmrFY070Q5JG/I?=
 =?us-ascii?Q?z6NlydInVtYX3hK1Q60H/haAf/tQXsBnrIv0UzD4phDZJSO0hliRhwoyl0Zp?=
 =?us-ascii?Q?s5v9LiU/4ePUoGK1g7Lpj8bJ3lC1yXY1Wgh65pc5x1c7WuWixddcEa1kXgjm?=
 =?us-ascii?Q?EhwYr3BgT8mOU3X/zWwvt/+nuNHcnOejs4RvfexQCxvSIO9ZO55QJKkjEqVZ?=
 =?us-ascii?Q?HweoKM+TVjLzF1Bu8A5lkZDBXckh7DYpJyqBPSUaFa7eH4z4LzOC0cGe0I7M?=
 =?us-ascii?Q?EK8NZBfY/PBhPa2vwjtAQgZQgjvveCCHOnJxSgywshId8NWNLAEhd1aGWnTm?=
 =?us-ascii?Q?4PeWkLCX9txLx03FfofF5GH82qs6LSswRbW/dF0P8VxO9cam/g07TCDbQ4sH?=
 =?us-ascii?Q?mG1GVsG+Yh/TXTzz7A5b8FkBSzPWRsKB7J985xODosn9/c9PaTj/SGkLTS9L?=
 =?us-ascii?Q?RF/S5lC5lBpfbQHk7iICKU5dGaBGBtbkC5KNFUQxYQ3NhRBRIh1y5T3AP3+G?=
 =?us-ascii?Q?IbpO7ojUwtUHTay8rZV1K68JiEPqO5XpcbhJ3R5Hdh6Yj5nhOxNoTTftuPi7?=
 =?us-ascii?Q?6gJcfTXU9VN5XiqBxGomvmxOlrtXC7T0dLRyfUFxPOnZuKOYwG6QDTtCPhJw?=
 =?us-ascii?Q?TdbHBoG9uCCT6E/7yT3MKzUX5cxX2UNySgABoo4j3hkd1wgv96rVBTYcf+26?=
 =?us-ascii?Q?SRsjYpcKhOC5LrcdrNSRyJRNlJRQT3URUiRHDvfykBO+v/LgVIWmnHbygwPw?=
 =?us-ascii?Q?Z4CM6XiMnL93wZFjVWHWpdX/eR4f9BqSKiSjlI36QZ/lI8ymAaYy8imgKGYn?=
 =?us-ascii?Q?/skz7CbwsSlAK6qvtwQqEdieG0EfPCrXM4vIcro7qmqqrQXyrdjuJINNMFNT?=
 =?us-ascii?Q?fXQwMsLypjqV8qIE4SpNOTImEAFTj7tSbklTLdWDi7O7mV8VBaqmHh6XEHRa?=
 =?us-ascii?Q?pqwdNLcwMGb1RbLJpdZtNFo7+b5GabLfFGZkTqSx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7a7bc6-a3a4-4461-f7e5-08dc5daa82ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 00:16:50.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfilfvRJ2IuIfy+2RqtrB2aI7S0Thc44ADuKJ1qTFk8LuJ5hNwUEN934ZMHialbTmiom5jpsEaOz6K9x6a+nKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> I was initially concerned about these cases because I was wondering if
>> folio subpages could ever get different mappings and the shared case
>> implied they could. But it seems that's xfs specific and there is a
>> separate mechanism to deal with looking up ->mapping/index for that. So
>> I guess we should still be able to safely store this on the folio
>> head. I will double check and update this change.
>> 
>
> I think there is path to store this information only on the folio head.
> However, ugh, I think this is potentially another "head" of the
> pmd_devmap() hydra.
>
> pmd_devmap() taught the core-mm to treat dax_pmds indentically to
> thp_pmds *except* for the __split_huge_pmd() case:
>
>    5c7fb56e5e3f mm, dax: dax-pmd vs thp-pmd vs hugetlbfs-pmd
>
> Later on pmd migration entries joined pmd_devmap() in skipping splits:
>
>    84c3fc4e9c56 mm: thp: check pmd migration entry in common path
>
> Unfortunately, pmd_devmap() stopped being considered for skipping
> splits here:
>
>    7f7609175ff2 mm/huge_memory: remove stale locking logic from __split_huge_pmd()
>
> Likely __split_huge_pmd_locked() grew support for pmd migration handling
> and forgot about the pmd_devmap() case.
>
> So now Linux has been allowing FSDAX pmd splits since v5.18...

From what I see we currently (in v6.6) have this in
__split_huge_pmd_locked():

        if (!vma_is_anonymous(vma)) {
                old_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
                /*
                 * We are going to unmap this huge page. So
                 * just go ahead and zap it
                 */
                if (arch_needs_pgtable_deposit())
                        zap_deposited_table(mm, pmd);
                if (vma_is_special_huge(vma))
                        return;

Where vma_is_special_huge(vma) returns true for vma_is_dax(). So AFAICT
we're still skipping the split right? In all versions we just zap the
PMD and continue. What am I missing?

> but with
> no reports of any issues. Likely this is benefiting from the fact that
> the preconditions for splitting are rarely if ever satisfied because
> FSDAX mappings are never anon, and establishing the mapping in the first
> place requires a 2MB aligned file extent and that is likely never
> fractured.
>
> Same for device-dax where the fracturing *should* not be allowed, but I
> will feel better with focus tests to go after mremap() cases that would
> attempt to split the page.


