Return-Path: <linux-fsdevel+bounces-22904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FCC91EB9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 01:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAC71F22322
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 23:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E590A1741EE;
	Mon,  1 Jul 2024 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="No4ehdGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439116F0DD;
	Mon,  1 Jul 2024 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878010; cv=fail; b=uC5mJUJ18F4qbJQE1A1LrV71iV+CBY1gN+8JSSIu77D9zD3fvFHtYjApsn2GkMObdw4RjAFXimlaI/TKSApMXbGHfgsayAmtJY+qWo6YRTKTM3MlfcTSiIEC9at7tNcRl7T+AxxXcGNrwCz43DvAH+FVvwBf97cEZySGXhmmQ3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878010; c=relaxed/simple;
	bh=Gu1zydKx8BvrqcPz8f811s2PKkip9bG3/r6ipqK8s1c=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=VnCo4vsuDog7dU7lf0dK7iv1o3lapBJECzvzAI1NP9i/iArMWWINGiVtZq9vwvWq701C5I7U6AsLndNhEMtI8ff0Bgel0hyBsR7RS74yZzX7gOKrzL4zQ8Pyf5WValaT8ngC7RFy0GuBsUDQHHpct8mrTyt/PlajDmElSQrWBCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=No4ehdGc; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzkbgFLDG83aigF8U7vWLtW00L0Fno1uhQwXZH0J1CPuinPqN7sO9THJCaiwUL8MLpGM0uc06ZcAO/F7uBv/CS3DSfmKSGGmHM5u2Dujy+nBEiskMZwZbmgokPATB0RMeC6OKF/4l5rYvgclFd7joqBT5Yrcpg8Hld4pev9EyeKMNRnkgwzl/BEx3xLk+Qz/El5RmAxvd9qGTUVcrF03tIYYuIHf5IeEh6ajW+cRzx8QoPQzJXdubOBcPZ7gFyO4ZGTXCL1vABWqc1GgOsUF2PPbBbDNm5p6LSyk2QeEoNNpwrvy0aQ7hv6WNzJ8zjNOrQolwWpMAZH3U6IrdZqNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vz7haZsFj1gyNIs9Hvqqy12vPgWsa7xrQknuTdinxv0=;
 b=IrmCrVMA6GT6bHmYvJx9YM61JGo7MCbAu166m+H/qUnMWeqWmwc6Lbu8sn7OXVG9S7iOIaIyD9ZE5AS045oPVGrXyl03Yx/8FYKGztd70GIi/292gVVy+5IvD7Kl+vFFcWcOcjWLZf2Ai+JPDtsQbzsZB5JtomvYRUFcEwYmpstry9su1USXQD6YFVD9bCBGgJvkPtuZgSM8bv/1EL2fqY3BrzeXm5Ct1QsMrPtw7ReNKCkZ56fD5qfrXZ04IhWl4J7zV1Spn1MjrdXdc+zCncQtdNF4yXc134CmRKJjgUO9yTn8Y8fzCEqw++n8t3j8P91Dp8VNLwKy/FyJDuLozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz7haZsFj1gyNIs9Hvqqy12vPgWsa7xrQknuTdinxv0=;
 b=No4ehdGc74tkhPesz0WG8j+03OUgrdaLCpdJtbi3UeXD5Bu3k81AsI/QRjmQ8RAPLAptmnl769wu5ZFhIF86G67MI3aV3dqh04ZC081/boFdSTsF04bolYu+begF9+jzET8W/JqTEX7LwxlnLlfM2xPac1GWqT9ZuFFhq6GU+7MNF1W8PUiL5senZxv8rEtWXOQYUcmMpwJ3nc1tUU7E9C2fpdz+cWht0vrmiVGne20fpjRIaDjvYu9V0nSIbvdSIdmshYToq/sXSVgxGe3y7bnkKp0ewdIMAmqv0P3j8yJN8gR6XsLGQSW/e4YEWuj5IjL8Si7zEYL0ewX0ci+ZWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Mon, 1 Jul 2024 23:53:21 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 23:53:21 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <74a9fc9e018e54d7afbeae166479e2358e0a1225.1719386613.git-series.apopple@nvidia.com>
 <f9539968-4b76-41a9-92d5-00082c7d1e96@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
 tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 09/13] gup: Don't allow FOLL_LONGTERM pinning of FS DAX
 pages
Date: Tue, 02 Jul 2024 09:47:03 +1000
In-reply-to: <f9539968-4b76-41a9-92d5-00082c7d1e96@redhat.com>
Message-ID: <87le2klleb.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0115.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: af2a5d09-3cd5-4c37-1ec5-08dc9a28fcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awaVA54tfcgdrNViR3wcYggMjMJylzTwaIHx8amfkRN/kHRD4lR/PQWRkg4r?=
 =?us-ascii?Q?hu2rVPneL6Sd14HEvEPjSBRI8eS6NUOXJYjB+2f1FJ4zsYjokL86+qpWqhyH?=
 =?us-ascii?Q?UG8fxCnFWhRYBMmVxxUR5ixxQWV/WWa1u3VGDo1wNy7TCsGrfkHizDR7/N59?=
 =?us-ascii?Q?o+0RWH5enMp8PtdVUEY9lCKarECrdsrHQjc8DQShUByHxNGjh1deC+UwNKE4?=
 =?us-ascii?Q?NgCpcVuolJvtEsILMbOt6XKa1/LlPG6pcRKcC68Wa9w00Az7cuXz4McEMMpI?=
 =?us-ascii?Q?qTlahGDrKCrUANeHKbL2mLLgiNRF1Wl2m8cHKasvb6X0HiqXWKw4+qwYULUb?=
 =?us-ascii?Q?2RdKckaPD38Q1ErKSU1b7w+dXzGjeMDWw+MRrFniBRyUfQ106dr9ekcspdmz?=
 =?us-ascii?Q?LWf/Komt77AGpfBs2Gx9onfG9gNtxvRhupwxH5yVslqSawKIay+j6kTz45tf?=
 =?us-ascii?Q?w3gVC+bKcDB5Rc5kdrq7g2LM8I1dS+dJr/8uQq9Y0qKG73DfG1L1KTDp187A?=
 =?us-ascii?Q?f/4caSBAo21Q7+0wbim+8a3re9fw8PKsz0BlcrF1qVBbAHxQgGXovhq015jY?=
 =?us-ascii?Q?Y7m9LF/nvWLfxkJFq5G2sOsCgDF6e0Wi38qAPxmJ7eCVIKg/zjeZgX4RMKrw?=
 =?us-ascii?Q?GJHMGd1oH454LnqTrOMyiiko5Nku62JaD/xWIlU+zCI6YLcD5Y0A8Au8QbIS?=
 =?us-ascii?Q?QHaKI+CB2PFnrFAMy5+PDOR0lOYqS4IzFVHyBz4YkjtttFWx7AAnnLu2KLO6?=
 =?us-ascii?Q?BeKrD2f9F7Lyn4QlgU0/4Oq/7q1BnpUDzTylYoYHlAvOkzJdFHWEsOJ1xLpU?=
 =?us-ascii?Q?qJ2KT0ysFSHLHN3FQ/aS3SifgYxJXHrdSg2RkLzi8YOGf8C44UZsSi0f2u53?=
 =?us-ascii?Q?V3zaKvBBcRWe9ZH/fpHSANWlJXqSIIw3MTbrZmCdBVJWDsfwFB9pZy2H3BRx?=
 =?us-ascii?Q?LUnKUbx3/33qo6XHLZYrZwq+M0N1H2/0mGrxKvRmyWaunYElSWIK0ZacCdXi?=
 =?us-ascii?Q?CVcj/aCqATNYQ5iqrttTj+jMH9PaWMutiHvE0QHL3adabicD0cnHi32gB13i?=
 =?us-ascii?Q?rqmk/eiyBDUxRoVMJSBnn/xYBFFBncTdKpmPK7F/1Jn5Wn3pKCpZ22Lgq9GB?=
 =?us-ascii?Q?iNT58jOovrSaCQR/hd74z8deRAVK/LjJrbf5cN2vaN6w/au+/qK2OheRKy/Z?=
 =?us-ascii?Q?DwtOBZ3zgULwCN6nbPd/djOC09OkU+q6b+XC89Xv3Di5vCRNXTvKBvK4y1Ly?=
 =?us-ascii?Q?Rd1u3EIbPcudAP876elljGcc56g2sLQSbgPxnWMItzwlYIduj1c7IIvIZPz4?=
 =?us-ascii?Q?zbfq5BKbBH8PtyJcuPeJwH3p34BILVeBQ16bMGRXI+gmuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xe0yQIRcPVBK0BwbP3AnvC996VouGtgurZz7olMWyshhM0MlGosOHOKVXnMK?=
 =?us-ascii?Q?l44GPmfyEcUE6VJe+i8sPKMYA22bfA3c2oZfJJdHEwKKE1wTtjSoXJ7+5BNP?=
 =?us-ascii?Q?qZIANRbGNOinQzmrzAk6zQeKDT/OAep2HRASCCcDG7b4tQteKgd1zmU2nEjw?=
 =?us-ascii?Q?bUaTC5+64mBoBQ90DISCls+wjHhbs4i7Cuqu4b/sXUHV7QUbMx4z+BY6i5na?=
 =?us-ascii?Q?yk+OWU8owCwCpSakFeiem10YiofqX4ZuLWdGaQDa+VUnbfwhYYhJdzwEN3HV?=
 =?us-ascii?Q?6GYgAlxOouhAjbThmY8EBH7s35AvfMqd1rQL1kSi20cOZNJXAS6uApgQQzgh?=
 =?us-ascii?Q?ocBMtmcSWv+Eskb7irEd1jDUOexMUf7S847CzZoM/+XZdxRkl9UKITPIPneJ?=
 =?us-ascii?Q?hju5x1oa0ULBr0uJNqkZqKhBVoQeLQpUHQEnLQo+oXcdvaJqdWqYh+PPmS/e?=
 =?us-ascii?Q?HOUmrX1n4NzDh1GkInfBG3Zkbov1+YUoVGph749oM2jUCkFdcy2pCQfUR6v6?=
 =?us-ascii?Q?N4vrYh9iCYFgFwvQgcxe8pF64HEC6wfOxDClqTKxOn+kObUPHZ70f22Yuf3w?=
 =?us-ascii?Q?UhU7RsC3S9qtTfYrpcQIMQM5SxAyHhKhWvm2K+Vk10HeaROuOXKeWI/pA49s?=
 =?us-ascii?Q?XslsDJFA4apDksDCRXzWdQ4+iSQvNdGXB9s/84T6FIAv4jUVL1RSLgX6Ly5o?=
 =?us-ascii?Q?QuUJ/Vg+leQtxk5sIdQkjfZnsDhOHAwA0y1n7Moxp7IIvDCZ6CKnDruHyHgE?=
 =?us-ascii?Q?bZzE+n7YWmAsl1gZBsyVlbHZD8ivUXpXDG6gStJX/9udBKP9WH7AMe9SxDlo?=
 =?us-ascii?Q?dib+CySsSkCRCxQY36bTprlvK5yIDDhkP+TEdsocJU5++cYWuXUwmEXLOG/S?=
 =?us-ascii?Q?wxlLnNEpAgAqbQU4O9ZUBdLZDgIfHhUFP6gVz6plven09QyeDEiKU55F1g1Z?=
 =?us-ascii?Q?HMcvfO0nRJDgd5Sm8KE+BT+0rHmPJxnVkdV0taLtsfmnjufUdzmqTWoNrBXH?=
 =?us-ascii?Q?bf61DdRDD2AqzjyEdPtvoHhZ06BEWdwzAqy0/STbBUdvfGr2XBylzJGxnloU?=
 =?us-ascii?Q?XZRz8jq5sALAwxy4NlQxoS1L9ynbBXhVliFwvz9J8CeVqnXq7PWpYwWnogmL?=
 =?us-ascii?Q?UPEnNz99RFHIiAVesDSTCB71dL0SWmOM14cqWwBbyl+trGTdxuJNVwG7RRa/?=
 =?us-ascii?Q?GOc8y/i1cthGIxQ3B9DzNOmj0QgGMCFbjISO9BMmyh3ye454MjR9O16ur1/Q?=
 =?us-ascii?Q?Y/PaNeXw87ERGIND85Oh2f+fsI5os0R1zk39zasYFTNdjlf3XyRgR/PCbCLE?=
 =?us-ascii?Q?Q5hSTEmE1Ig854vXDsOC9NtXYxMJU1bscYDeTsbUuVVFRcC8OkBCOI0N2F5q?=
 =?us-ascii?Q?BjcnkqLR5mmghRu4R/cpTEKAJ4OATTm4+YLiiM8GqSYjwUrm7iACk3BhHZDb?=
 =?us-ascii?Q?/jYCSyUuXLiD7//i4wgVBCCoRRxC7AFeaWZiWkMIvlwbP5F+TOeC7wBXqOJq?=
 =?us-ascii?Q?noSkT7KvoEGGBNQy6pX98KiuGWn4txb0y5yivll0eAtj2mTd8DlgH1RgJsYh?=
 =?us-ascii?Q?z4rBH8KGkudiktw2rRUTjjcEPAet9pK5Rb/3J0zR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2a5d09-3cd5-4c37-1ec5-08dc9a28fcee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 23:53:21.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8MokSv5MtbPOkmJIu4uqpiS0O32Vb/43yvJvOacsjjLmmAEhpdVC1H1GGdGxtUGRUJDgEioe82oNVgO8lSsYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326


David Hildenbrand <david@redhat.com> writes:

> On 27.06.24 02:54, Alistair Popple wrote:
>> Longterm pinning of FS DAX pages should already be disallowed by
>> various pXX_devmap checks. However a future change will cause these
>> checks to be invalid for FS DAX pages so make
>> folio_is_longterm_pinnable() return false for FS DAX pages.
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>   include/linux/memremap.h | 11 +++++++++++
>>   include/linux/mm.h       |  4 ++++
>>   2 files changed, 15 insertions(+)
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index 6505713..19a448e 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -193,6 +193,17 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
>>   	return is_device_coherent_page(&folio->page);
>>   }
>>   +static inline bool is_device_dax_page(const struct page *page)
>> +{
>> +	return is_zone_device_page(page) &&
>> +		page_dev_pagemap(page)->type == MEMORY_DEVICE_FS_DAX;
>> +}
>> +
>> +static inline bool folio_is_device_dax(const struct folio *folio)
>> +{
>> +	return is_device_dax_page(&folio->page);
>> +}
>> +
>>   #ifdef CONFIG_ZONE_DEVICE
>>   void zone_device_page_init(struct page *page);
>>   void *memremap_pages(struct dev_pagemap *pgmap, int nid);
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index b84368b..4d1cdea 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2032,6 +2032,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
>>   	if (folio_is_device_coherent(folio))
>>   		return false;
>>   +	/* DAX must also always allow eviction. */
>> +	if (folio_is_device_dax(folio))
>> +		return false;
>> +
>>   	/* Otherwise, non-movable zone folios can be pinned. */
>>   	return !folio_is_zone_movable(folio);
>>   
>
> Why is the check in check_vma_flags() insufficient? GUP-fast maybe?

Right. This came up when I was changing the code for GUP-fast, but also
they shouldn't be longterm pinnable and adding the case to
folio_is_longterm_pinnable() is an excellent way of documenting that.

