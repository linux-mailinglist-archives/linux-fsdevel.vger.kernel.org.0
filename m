Return-Path: <linux-fsdevel+bounces-78937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YENBIFe9pWn8FQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:39:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA01DD0CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 17:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BBEE309135E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7337C421887;
	Mon,  2 Mar 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B66nIzRj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAE41C0DA;
	Mon,  2 Mar 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469175; cv=fail; b=tIKCTyvvSNlK0CnQFXj2NJ8cB6lgwXmAIhIc8etqt7MGnqmtUpH/GieS8NbdVOteodAkb05lLL9Y8LWZL84bzXM3FnTHH9xDdL7xyjWnzwIPAqt+NBX8VYFTsYOYDDfCAQo1dQYd5zQvOi7VAXbtL2hZcOGWlETaVsJVX6fYvH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469175; c=relaxed/simple;
	bh=BNTde6jgVNvMF+tbZzNYo0Te5KxQ79/cJMAZgRYvJrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uaOgbvHIogDOEbpeLwl6LBOVMaKpWd/orFRSkpZ/G0VeJXD52e6t/bLpl4qt0OZupWJgWeTvspn6loyb4SfZSBRt0pWOA8Z0mNUNqurcSf3FKZqW0fhH8kVFfJJznIQkEIrqHvRaPtK6o/QMZCtN2OELk0afBYPaqFrVsr27Kt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B66nIzRj; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYc0zVhjd3JoxmnN2uwt2wvv3hSOAO1V878/h1kf3j0vpEvfEAuNJrQElLVaJP6y4m7dSFNxGa6QihHjBwBbxLR3iUF17pWCpWIK+S6Q+fojR8lKt8xEu+sr9fpbmDUnUlFXbnW31Vc8sr9vGZquy0qBw3amjdEdHUpPQpI7FPadAkLMbxmAkmYvkvz9VuQn+LPXk6LvJF2CZTLniCEBNCk/QZbJcc/gBi9mdsiWOHxGpJp26fnVLhP8PZYtbFjhng+K25qxjY+NbdP/CRNhz1srWeVC+dKeioAmoEsAIqibtQ14xPXNaOUJRYQUDlrL7am2PjejWs5h/AnKkX37aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96/z9kV5tl8DmdNDAkqdNXPSRRvTFkL7agbtGVEdxcg=;
 b=WH6/KTrniwy9sWRUyYe9FdyQHTrMwHsCVpspGycU9XuRt6dZsEUxWQ2Lk2vhpE4wrOy2nedmUanfDVT1bqz6wIiQBIiwnmHC/2b/yOFUb+PjE/SPiQE4s4sULKZ1yiOjiEu5gc7zZI2bi7OWEbYVYu4bltCKrJE2zKXs6su/GuSQI9j33GPZ7Yfeejtyn4vlEpNmrjDl6bE/6+2ip07jhBV54idajMw8Quo2/DwudG41OJIZQWW/vBbYcwhj+gISTyqMkHwZ+hjFrRblc6nq87aVjMgkHHis1mViLPEG6wgVqRKN27ZzHjUHF+jZP5xo8GlA9ttiwb5JpjTUESEdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96/z9kV5tl8DmdNDAkqdNXPSRRvTFkL7agbtGVEdxcg=;
 b=B66nIzRjUoAx6DNPrrS8P67psTyygmZxZFkN5pMw5q2DQr6r83MQ0lG2aktjxVDxNHANreGtxOUVoRj1whUzX3DRTQe0JsS6/TpinQTVE/McQbznF+vKRyEy5Yzz50kUjzpBuHUy0mjdV+CmEYGv3CaAt9e7jnhuPa+qJS0DUvH3acv0GbFnSviOx3egh/82PcGcm4Cc8mKvBg/wenuufEdQ5IMYOh8wd1Rnd6IlKFvNXA6V+rLUlFRC/2l2fSbdJGHkSfj6jYJQSTabsCsvBIYToD4D5c5CE+2WyrHjYkulFoMm3bXAFZKXQWtiEaJO3/edgxrHpBRoObIR8wXb0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.18; Mon, 2 Mar 2026 16:30:45 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:30:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix a folio_split() race condition with
 folio_try_get()
Date: Mon, 02 Mar 2026 11:30:39 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <34AA9329-A6F3-48C4-A580-8BE3E4F9A3A0@nvidia.com>
In-Reply-To: <54a4d554-d4cd-47d2-bdc1-8796c5d7d947@lucifer.local>
References: <20260228010614.2536430-1-ziy@nvidia.com>
 <54a4d554-d4cd-47d2-bdc1-8796c5d7d947@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2161c800-b509-4124-c862-08de78790ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	I6ZRb7L1aKjm9q3th768MhO3opX8YIDO3CbnCebDmXjuqR1vbXfoO5XbyFQhoIiX5RoPH5NZIvyYoPcTnXixy0We8x8mgHYWvmFcx35EIcvhCn+OZSGKdaSlaS6+j40aMCeyPFXt3CGpx+l/OG+8gurGQldiIL8mcFq7QPouJoxqafrStulfI6rsi5kFZhzLaRagLO6Bh5yeSnWIy1tDS1OmR81qEYKwXuceTo9KuQwaDJN/UPSo5k5O/ae7vZ0wA0rgphhO8dft0e7PeyWrfHVBZVDluAZd80T2iM5iLXrkF6pRUjh4Cm4vS23EbVTgeORYI1zcxy2f4odyuJXYLUcFxUihRYt1YO7Mb/5ElCxuGD1Gb+oQBVlDfpBNGYOc+/q0v1PxeiDkeMybzG7AgQKDG0qYIS7OCNZZdW20jvyyTgtNpBh6Fue4y7scr2rDUANSih3rGfLUCOkCTe/DtU+uwyCdX9HT7AK05wfIK3TqTaeHuhFaPzXr/w5+oztxPpD3nlnkgGDugnW/cnMRe+ges3jPE9tw3OT5Ei9e7WcELrPM42ZNTJqE36sSB4Bq0dsuYoherB5BWoKowxL+hXpzZUMGcK3TKfwkry4atD/xdW9wgE0Ki+3bhC9HiEMXPdgYAXKmxtl5HLs2Td3Fq8lIaeOipCZmHBh5+W6K+OnZVlJtysjURUjujvLMNKIVoPxWyGigDNJQOP+XK+Yfv+mraUTAiCCDEYIBtySrcaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8yS/48ZCOdZRvqZ259wDGgfDq5omH2n2uPPR1nrjzkXdnIIHLjgvyfrV2vo?=
 =?us-ascii?Q?0gzOOBdcjumh+OxWOO9PN6dCsadzIBr7OR80oywze1U3E8z1+KheFwa87ad9?=
 =?us-ascii?Q?XAIwMEKg2zYa7FibubpEFam8GkGa3a4+3zCuvJJfaNjy2rVfk4LPA6FmdAlL?=
 =?us-ascii?Q?D+Nehd0mNIB3M5bpiLKHsSb4M75WFDUViBNZ63tMsNN+GkJezU8ZQxnNbHfV?=
 =?us-ascii?Q?1nNDwbHbO93xXtEgTpWSzxfG2DjrU7i1WfNihP2jpEQqBRh5mRk2yDbpz90T?=
 =?us-ascii?Q?TAtJbH5KrbVaX7Xhw9dC8aVVDZydEzGgX5wZlSdhsHviET9FszIn6fCOxTgH?=
 =?us-ascii?Q?n+f7oZsN/K1RE5DPH2F55EuJKbkmGD4Wlzj/cs5spMGNtRKxLrLiDuKXw0zo?=
 =?us-ascii?Q?QlbEVxaGYpWa+yOZQ4bhsBq7/4TNyfPdIZC9FDrQLurMGpMHQDEQ7SfcB3FM?=
 =?us-ascii?Q?uGYnO19ILYOGovWbvNR2zEZ1zSD2q/JkadaZ1Eew1DWhf081uGpDgpa5vxL1?=
 =?us-ascii?Q?9f2AVoSVyTvjQJ3HvENFh930CG/B3+k3Ooe38X5tLyhFGeq5fdAng4tnFdx9?=
 =?us-ascii?Q?+FZZuQJBkHu4RmxnwUMxGU/soVQJHVCHg8vHc9Bh99UgHvVQ0Q0pQ2ThN6hp?=
 =?us-ascii?Q?gcdRGn/Lug3VnhtM3FNoSi/qSSZeAWeXnCW6u2YhUuL67qp6MCyjpJ0P3hoa?=
 =?us-ascii?Q?QLpYN92GD2hx51DcZplwzVqzRf91rqqSM5WlS+NpsQ/er6bedgabwTj1cRkc?=
 =?us-ascii?Q?WqeJUpH6xyGNRB16lkQEZGT3iNIHyzFsqqpnuZUCBYaYOLJdNUdVJZgbMqgY?=
 =?us-ascii?Q?CApNJO2FdsHkqfpuJ5ryzFbHDnVyEpcWQODTw1Nqja7Nntig0p/DfSwZlCne?=
 =?us-ascii?Q?1loQZ1MhuyBJz2fQKXtw/6rNMSesFAsJlL2EWMBR72EFrXsBNWVQYkXQpSA2?=
 =?us-ascii?Q?YPrGgGjTa+rjnMeLdsXRm/O9EFROyR7OaR0bcxbX4ocz8YHj8pDWR1CWgccR?=
 =?us-ascii?Q?8+bVw/ZbFquN51QO66FQCyX8tR9yYXIqsX9Azx8Y6PLFLyv/+c1puCko+mhs?=
 =?us-ascii?Q?P4oSiUVfq6gExOMUcPXYxz5/lLAfnKq4zls6jgHquor1hvauR7fsQI6YA1VG?=
 =?us-ascii?Q?igZ+2JV5pGfxAt1c7qIzKJPM8BEe34ckNo7HWTuRy7wnF7UPiyZWIyyxQ2mt?=
 =?us-ascii?Q?Ba2QjSSkcjgV+Jc4Doao/65ZODA1ZbBfUhgfp6/s79E4I4QE2wTVdEcOsjmn?=
 =?us-ascii?Q?9iLg0V5/BjDQAU1uolkAwRFa410nWZ6XSyI+RSt9pAJwvokTM0xtSf0B5wyu?=
 =?us-ascii?Q?F6/kklQHEmyqeO99UprV6gJ6fxeoF2zfuUf3cX5KEPDJNu/v/egzYFytXHbj?=
 =?us-ascii?Q?NSlfW6XgQFE82hXl4hH0KfkvTcLF4/XzAUev9nGhEcBM/Mbx0xH0qk11aTrO?=
 =?us-ascii?Q?Ovfdc4UGmC/31XuGxw5snIFzo0wKvVtfmJ1pgQvGSj00admUl+bTlNaKqs0m?=
 =?us-ascii?Q?yul4+KQ+fEUVQ35H/bGBtBceKAC+AO11Cmbmjg2vXlzR4AyP1W6+G1w0B8O2?=
 =?us-ascii?Q?juXU4qA84sTeb/mY/uzbXG/cAB4rEVeu0VNOKe1xi74zNpSWVxu+5qxUix7p?=
 =?us-ascii?Q?20lziZv18QZU3mcvpnVBE/4i9PuXONq5RHwm3zblyUkEMEs/YM5+NvQPlQjL?=
 =?us-ascii?Q?MvIjCRYtDuovH9WeWoHDkUTanBobs0QV0uvnOfZdD9ckF8dOcW+a2CmIr84P?=
 =?us-ascii?Q?NEiNDDedeA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2161c800-b509-4124-c862-08de78790ded
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:30:45.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ep8qeqNDemG0/JpFjR6d7zBCzdRgOXF4uUVHRfuu5B2Ckvw9NFU8tLx7B2N6w8U2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
X-Rspamd-Queue-Id: DBEA01DD0CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-78937-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On 2 Mar 2026, at 8:30, Lorenzo Stoakes wrote:

> On Fri, Feb 27, 2026 at 08:06:14PM -0500, Zi Yan wrote:
>> During a pagecache folio split, the values in the related xarray shoul=
d not
>> be changed from the original folio at xarray split time until all
>> after-split folios are well formed and stored in the xarray. Current u=
se
>> of xas_try_split() in __split_unmapped_folio() lets some after-split f=
olios
>> show up at wrong indices in the xarray. When these misplaced after-spl=
it
>> folios are unfrozen, before correct folios are stored via __xa_store()=
, and
>> grabbed by folio_try_get(), they are returned to userspace at wrong fi=
le
>> indices, causing data corruption.
>>
>> Fix it by using the original folio in xas_try_split() calls, so that
>> folio_try_get() can get the right after-split folios after the origina=
l
>> folio is unfrozen.
>>
>> Uniform split, split_huge_page*(), is not affected, since it uses
>> xas_split_alloc() and xas_split() only once and stores the original fo=
lio
>> in the xarray.
>>
>> Fixes below points to the commit introduces the code, but folio_split(=
) is
>> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() =
in
>> truncate operation").
>>
>> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) func=
tions for folio_split()")
>> Reported-by: Bas van Dijk <bas@dfinity.org>
>> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OL=
umWJdiWXv+C9Yct0w@mail.gmail.com/
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  mm/huge_memory.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 56db54fa48181..e4ed0404e8b55 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3647,6 +3647,7 @@ static int __split_unmapped_folio(struct folio *=
folio, int new_order,
>>  	const bool is_anon =3D folio_test_anon(folio);
>>  	int old_order =3D folio_order(folio);
>>  	int start_order =3D split_type =3D=3D SPLIT_TYPE_UNIFORM ? new_order=
 : old_order - 1;
>> +	struct folio *origin_folio =3D folio;
>
> NIT: 'origin' folio is a bit ambigious, maybe old_folio, since it is of=
 order old_order?

OK, will rename it.

>
>>  	int split_order;
>>
>>  	/*
>> @@ -3672,7 +3673,13 @@ static int __split_unmapped_folio(struct folio =
*folio, int new_order,
>>  				xas_split(xas, folio, old_order);
>
> Aside, but this 'if (foo) bar(); else { ... }' pattern is horrible, thi=
nk it's
> justifiable to put both in {}... :)

I can fix it along with this. It should not cause much trouble during bac=
kport.

>
>>  			else {
>>  				xas_set_order(xas, folio->index, split_order);
>> -				xas_try_split(xas, folio, old_order);
>> +				/*
>> +				 * use the original folio, so that a parallel
>> +				 * folio_try_get() waits on it until xarray is
>> +				 * updated with after-split folios and
>> +				 * the original one is unfrozen.
>> +				 */
>> +				xas_try_split(xas, origin_folio, old_order);
>
> Hmm, but won't we have already split the original folio by now? So is
> origin_folio/old_folio a pointer to what was the original folio but now=
 is
> that but with weird tail page setup? :) like:
>
> |------------------------|
> |           f            |
> |------------------------|
> ^old_folio  ^ split_at
>
> |-----------|------------|
> |     f     |     f2     |
> |-----------|------------|
> ^old_folio
>
> |-----------|-----|------|
> |     f     |  f3 |  f4  |
> |-----------|-----|------|
> ^old_folio

This should be:

|-----------|-----|------|
|     f     |  f2 |  f3  |
|-----------|-----|------|
^old_folio

after split, the head page of f2 does not change,
so f2 becomes f2,f3, where f3 is the tail page
in the middle.

>
> etc.
>
> So the xarray would contain:
>
> |-----------|-----|------|
> |    f      |  f  |   f  |
> |-----------|-----|------|

This is the expected xarray state.

>
> Wouldn't it after this?
>
> Oh I guess before it'd contain:
>
> |-----------|-----|------|
> |     f     |  f4 |  f4  |
> |-----------|-----|------|
>
> Right?

You got the gist of it. The reality (see the fix above) is

|-----------|-----|------|
|     f     |  f2 |  f3  |
|-----------|-----|------|

But another split comes at f3, the xarray becomes

|-----------|-----|---|---|
|     f     |  f2 |f3 | f3|
|-----------|-----|---|---|

due to how xas_try_split() works. Yeah, feel free to
blame me, since when I wrote xas_try_split(), I did
not get into all the details. I am planning to
change xas_try_split() so that the xarray will become

|-----------|-----|---|---|
|     f     |  f2 |f3 | f4|
|-----------|-----|---|---|


>
>
> You saying you'll later put the correct xas entries in post-split. Wher=
e does
> that happen?

After __split_unmmaped_folio(), when __xa_store() is performed.

>
> And why was it a problem when these new folios were unfrozen?
>
> (Since the folio is a pointer to an offset in the vmemmap)
>
> I guess if you update that later in the xas, it's ok, and everything wa=
its on
> the right thing so this is probably fine, and the f4 f4 above is probab=
ly not
> fine...
>
> I'm guessing the original folio is kept frozen during the operation?

Right. f is kept frozen until the entire xarray is updated. But if the xa=
rray
is like (before the fix)

|-----------|-----|---|---|
|     f     |  f2 |f3 | f3|
|-----------|-----|---|---|

the code after __split_unmmaped_folio()
1. unfreezes f2, __xa_store(f2)
2. unfreezes f3, __xa_store(f3)
3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4,

and a parallel folio_try_get() that looks at the second f3 at step 2
sees f3 is unfrozen, then gives f3 to user but should have given
f4. It only happens when the split is at the second half of the old
folio.

>
> Anyway please help my confusion not so familiar with this code :)
>

Let me know if you have any more questions.

>
>>  				if (xas_error(xas))
>>  					return xas_error(xas);
>>  			}
>> --
>> 2.51.0
>>
>
> Thanks, Lorenzo


Best Regards,
Yan, Zi

