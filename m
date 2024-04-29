Return-Path: <linux-fsdevel+bounces-18109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2958B5B3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 16:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339421C21478
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542CA7C6C8;
	Mon, 29 Apr 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n2ExqiwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE47C0A6;
	Mon, 29 Apr 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400979; cv=fail; b=dG+unOKD9SnUdQI64pkdKLClH3beCREuVv3+GcsAYC+EDp01iwGJ6kgNZMq7kNFB9eg1mU4VkGHntrohJd/PbVxCbqkxsb1hICuAaoG+GkUNZEuOLMHX0MUQ2FcKH6j/oaNV3aKS/OetLu9dBf4cVLmxQ4i7H49S9xv+kr4BCnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400979; c=relaxed/simple;
	bh=5e8RI6W47IBu0UtfWxFcy+vRv34UAisKA7Hf+LagcEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2elZbz7wT6yhU13sPRcod64QcVelzf2AQ5udUf0jI7xwqLHw1wVXNCiPJsH/UHap63TIyAQnPyLmXIFeOJVQzTQr3fVedV46+fFfGriJVzumFPhVcY0spaNCn2f0cEIulD6HxAbeLZBCy9OfEayT4jqT0VZVIAYHHO0MqtxnIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n2ExqiwL; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fztIosGqlLwHAsHaqnjLdyuUQUFhdOAf5U0ZnWOfhRWE0bSU2D7cMYtjOYgvNpZESwQrI3sd1Pv9ak79UtnPP3mCY9EgfIaQ0tt2JF0r2hSU7p2lVrQcQaSbuoWaySmVWvi1a/HL7HMdffNWYYxLC68B1Iabf4Ea7ubVOZhGQEE88RYU07d5I6azE0rFtRZfWAno5ttvtRYXlQj0Zdm06v4vep03nptsNjjBZ/N+owZZZm8JyO5ahSblYcoIR8nEmy4iyZDa+FuFY11wTKbGcT+MjxBnJVeHNXYo1rCqYcMK+hZvaw/iN+m5R7dwgWzOw8r75D5OdrXIz39ab+wJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynYzX5dw2zS9ty4VpRnvnw/htccmtXO4bQLpKRuupkA=;
 b=InEf93Lmh997Kxwjb9LHtIbO0K9E9bzTM05PRw6WaYL1UfDXeMRNU5+xjQei6fKsTh+9iQbi37mOMndaT6VwfRGZqzUa5/ga5+wUxPvvat+nI/o5+hUb0fYVb6jSTurVbZAWjEMVFVY1ITp/Z/479UkEZv/e2z+mN3FIwGXUKjlXHO/8zyINwIuwF9iNt5AsR963RCgRO0u2YUDYx9gsT2MTJLVV/1a/9RkmmgFXpLd7NW8MJ0aoPzgZHTGPfcP1gP/iFSZENQr8i6au/TYetJWfFmJIvXLt6E/IQ0+Fp3Oaex1FEMylwtAGIFLvKCHZcrGHVH4cpTHN+yT0+jh7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynYzX5dw2zS9ty4VpRnvnw/htccmtXO4bQLpKRuupkA=;
 b=n2ExqiwLJUzpCv/Oo2WRtU92AXvvhqZZmguE1UGsBqXiTuWorDEMzi6VdDJWpgNUN5jY0HBSx+k0oaFleuXxDRpL0hNZ53ZNneELkzWkZ+WGMKYVWbmRuQIo+pc3t0IZL6Uj1l5M/BbIz0ydKy562jXTaA+CZx6sfGEsRvC7JNJpYa0ybQZ/8ySZKvYmEtglNKn9559ICPuhrRJd6JUYXAngXwmXryPQ+FLiSaERwuhpuOpkfzf7cBO6n5wmJSX+agYNoK3fsx7XYkDWLVb27X87myrmM/BI+wzh556lhISXR8O34AS5vpUg7AdQnLg+2XQ6HmfOTz3D2rTslACucA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 14:29:34 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:29:33 +0000
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
Date: Mon, 29 Apr 2024 10:29:29 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <6799F341-9E37-4F3E-B0D0-B5B2138A5F5F@nvidia.com>
In-Reply-To: <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
 <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
 <Zi2e7ecKJK6p6ERu@bombadil.infradead.org>
 <Zi8aYA92pvjDY7d5@bombadil.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_3CFDE44C-20AD-427E-9C6C-D6F7E093DEE1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: ac40d570-8f53-4546-f2b9-08dc6858ca20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGRmeRdZAzoSI7OhNN4uopmjEAhrGfhz+T0N0rVTM4oWj5FoV1EibjRTIB5C?=
 =?us-ascii?Q?HqgLbVSY06YlpOlgZoFsieDs+zMZgOYb2foL0p6JEfiweWjIzQwfcyH1kzRT?=
 =?us-ascii?Q?qLgsyU8+0KZN+USoHixObs7hirJUXvaGx+sqS3WRi2fkBk6RZuQ7sV8YElfA?=
 =?us-ascii?Q?Svy4mKSGjjgL6XqT59TZkrYvOICSW3DOUC4pTNtNUGuiLjNrrFzYz899kuY3?=
 =?us-ascii?Q?7McRZY0ueF7rsc2f6ZNZQJ6f3vBljjmszWNyBCdKAYP0a8lzinVTKX/DDZ1S?=
 =?us-ascii?Q?n0lbUkTT6S87q6amsgKTNZg0X7fM1q6gzjuS0XUpprFqwfME5WQFAIeHSc8F?=
 =?us-ascii?Q?TZg2gCmHz47fN4fhuB9fJklUcw6GVudHQhu+lnnjCNXJ5hR840adCFWWocGT?=
 =?us-ascii?Q?k+b4Pka9nHLVHvJP+DyApIiJUYO+fInZqYRZjY2JTQ7obouXBmMCX/uzwQlK?=
 =?us-ascii?Q?sZkpEscGV3YwcaNnnWxpLeOr2KFm8qkDI77iPCde+acrC5aYptBVV0lAOrX6?=
 =?us-ascii?Q?BKF9VIFFKtcEqnF1czgTVYFvWZ2wGNlD01wBocNGIHho2MOqDEFRatjc32VC?=
 =?us-ascii?Q?/ur++VJtKGa5K4anJ2izSGY4cJOA/VVHIqQSF8XgkDcIiLEQDetr/Qs9Kv8S?=
 =?us-ascii?Q?u6bg8ddUm/Me9PMPp1BKM9gFr/xUTTQJSXkz1xkbiUYOUWyJKA7ZS4J/QPXR?=
 =?us-ascii?Q?HFhSbPEezdme7bqjg2AWv2E/0oA8R0DnAKE1d+aSAHy7zil1flDc3JtXZqTz?=
 =?us-ascii?Q?LjrdD8aCcetmAj+tKL19C6GjBNFw4ePM/ELlXHW/dyvHJm+A6NiS8qvwFpvz?=
 =?us-ascii?Q?h7R3yA4fPFHXNIASFLFYDkG0EiK+dvUEuI9KT/5DXqQcF5peFPgSeWEPgFle?=
 =?us-ascii?Q?tvmeEzIQzMfVjPpMQBlyHbmx7phjR05VjKIAmx+tfKg4yCJRH3kIPhimnAqG?=
 =?us-ascii?Q?0W0jUUKQJkzyzqi7amNX1PogZckhRAPr/pyQRyHIl3NINpszs/0BaVk1+ZEB?=
 =?us-ascii?Q?Ykm010rI4QydTPBcNxi40WBWhBz175IaMVxsgTCwjRjJZK25qNtTfC8A5Cen?=
 =?us-ascii?Q?vAE8IKrgDruRTv3W2xguKA1kzhGurTKCvRm5z5BW/irHCWbFPaEdgyOPCY2E?=
 =?us-ascii?Q?s1/imO8XJY8sSDrRsJAGTNOd6SVuaFE9IWxi/emP8mKHXWa+E6Z/xFIKdulW?=
 =?us-ascii?Q?GW9KFVyLq5FwDwTHVkasOCWWkfveoBzKV2nwoFjB7CM5GzGQM22Whw+qUpow?=
 =?us-ascii?Q?ujIhxD2RQxpj0wEh33E1AsTZKmVEHMavRXutV2ZuVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DbPX2NcneEYnamAnGPrxjVkA+a0NpmScUbSPjzUnxasHdh2LJhDGfiv6QrhZ?=
 =?us-ascii?Q?aWC/FPBnpscQeujXY032m0cw/OYma7qFyiRIEi0giqEmyv0/UZOL5FVRGJN3?=
 =?us-ascii?Q?X/EWL3356j9CLN96MfHrccDaDaoowMcxLdWYV4FOVW5VjoScwh5TFoj12j8D?=
 =?us-ascii?Q?mJmN8B14KLea7xb40aYMMUblitebKLm5pmfUMgYA+5l9jQ20l+3D9s6lxatT?=
 =?us-ascii?Q?Gvuf0ovLIRLOJf3mCR37RBqB9PKKA59UzTSOW0Tku7tS8kBsO2LnMEkcPdzR?=
 =?us-ascii?Q?n2IGo/IZQUOnQCqluN/F+8s9xfcUmwX2VUa3LPOcecWNQj8l22h1uiLJwlET?=
 =?us-ascii?Q?OuA+8z9nEAe0eLLxP4qh2BCBSZIRJ/Oo4ndSgn9ngvG302GfwQPf3IxTFUu+?=
 =?us-ascii?Q?41iyEs5dN2GNxbblYUF16zl6E/0p+k/1N0YWYIjRVEC90W4Jg9xNxEw3kim/?=
 =?us-ascii?Q?nIVfQU7IHCUpdRiO9916nYkqvnTKHuvfI/h2nL+HfRI+Fdr+ydUgdPJeMARK?=
 =?us-ascii?Q?2dVaTDDIvQYVUwwgCl3HcCKDOFeD4PkM8aq1ElazElRqLpWp+MYV24t8oXBr?=
 =?us-ascii?Q?5ld09zM4yTT++1iKFTiGQJsqy+zb4CD8dTgBOl7O8k+dGB5P24weJD+/8e05?=
 =?us-ascii?Q?DHX/hV6+taMkFJAQLxnnPfELBeYJK9BT4WMiOvqiVAIkeuiQqgmTpQpfNFuY?=
 =?us-ascii?Q?xcerUyNTxJOoOUKDs2hDAgR4+bjZOTg52pxi3AmSWKLbJk5bypArfnGLDD1k?=
 =?us-ascii?Q?B+QGRtMHSzVhBvEU0YAOfFrXB51zlqoiICGLh3tMDxazVLoTcvUYsKwpT0rC?=
 =?us-ascii?Q?o7OsDlNZgCPDD8eXYY2BfGPaezOJ6YC/G2Qc8Ntc4X5KsHtwCI3JPIyNrxkP?=
 =?us-ascii?Q?o6BzXrvNK18ZIEPwwcqqCwUTTeoDhmZzrHZfkmWDuYDui4GjIgAPGNsnQfSW?=
 =?us-ascii?Q?nBNc/ztcFLKTBk8VYFvCjCYbDnkZicpMMQ44GEVdCkvTtWPMOBuwXfxliANx?=
 =?us-ascii?Q?aXYzvav+97HEw6XQWHisBOFvSKpFS03gcjkBVcTi1E4fDZmABDuZAXkHzl8T?=
 =?us-ascii?Q?dxh1jFMFburaOzdMEaAhtLq43mmiH7Fjv7jO0Wk54R66wPe72hpVSg9/emb7?=
 =?us-ascii?Q?b7UsW7HGQ4K7Os79RyMrt2kKCOyd1aHY1tnoMMPMmqCIW0jiFr9ZHqlho4tf?=
 =?us-ascii?Q?6gqP8W2zi1dE5BTyYs/Puwd30qveAgadbLD/V6e/LI1Y5U/d2bAyQsW5i1Pe?=
 =?us-ascii?Q?LDqLrkm0U6kIRUXlccqwVh5ziMWDFXDrf/YtfuSDeM5PeSo/CDcb+a8wTnK+?=
 =?us-ascii?Q?wUCwOkCpPhs2h/YWxfJ6HzpXajxGNIpHyZZPHuk7OEhBFftw8w+MErk3pUJJ?=
 =?us-ascii?Q?1Y+Pe26q6NeiJTapfE1exBl/sSiH28wxSMyYuFlbMpWZx+I4KQ13Q7GI54/f?=
 =?us-ascii?Q?cDjbpRcNdryTcOdwY6YxDw+HQNH9W5oh0ZZGXnyx+Fsy3vEvmE8YtEjifkkY?=
 =?us-ascii?Q?kcxu8Wsfbtsa3xv5jFHKqgrwwM4MetBE2olq3kVOTwx80jNhU53FB02F4kwl?=
 =?us-ascii?Q?wRU22ucg/UEgFUhEjnc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac40d570-8f53-4546-f2b9-08dc6858ca20
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:29:33.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mwVVCfvMCzYUIIjl/cOQekcgPBEhlokb26zfg22Z5Sb0V2XhmTa9mxXdiTFDNu8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801

--=_MailMate_3CFDE44C-20AD-427E-9C6C-D6F7E093DEE1_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 28 Apr 2024, at 23:56, Luis Chamberlain wrote:

> On Sat, Apr 27, 2024 at 05:57:17PM -0700, Luis Chamberlain wrote:
>> On Fri, Apr 26, 2024 at 04:46:11PM -0700, Luis Chamberlain wrote:
>>> On Thu, Apr 25, 2024 at 05:47:28PM -0700, Luis Chamberlain wrote:
>>>> On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
>>>>> On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung) w=
rote:
>>>>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>>>>
>>>>>> using that API for LBS is resulting in an NULL ptr dereference
>>>>>> error in the writeback path [1].
>>>>>>
>>>>>> [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397d=
f
>>>>>
>>>>>  How would I go about reproducing this?
>>
>> Well so the below fixes this but I am not sure if this is correct.
>> folio_mark_dirty() at least says that a folio should not be truncated
>> while its running. I am not sure if we should try to split folios then=

>> even though we check for writeback once. truncate_inode_partial_folio(=
)
>> will folio_wait_writeback() but it will split_folio() before checking
>> for claiming to fail to truncate with folio_test_dirty(). But since th=
e
>> folio is locked its not clear why this should be possible.
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 83955362d41c..90195506211a 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3058,7 +3058,7 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
>>  	if (new_order >=3D folio_order(folio))
>>  		return -EINVAL;
>>
>> -	if (folio_test_writeback(folio))
>> +	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>>  		return -EBUSY;
>>
>>  	if (!folio_test_anon(folio)) {
>
> I wondered what code path is causing this and triggering this null
> pointer, so I just sprinkled a check here:
>
> 	VM_BUG_ON_FOLIO(folio_test_dirty(folio), folio);
>
> The answer was:
>
> kcompactd() --> migrate_pages_batch()
>                   --> try_split_folio --> split_folio_to_list() -->
> 		       split_huge_page_to_list_to_order()
>

There are 3 try_split_folio() in migrate_pages_batch(). First one is to
split anonymous large folios that are on deferred split list, so not rela=
ted;
second one is to split THPs when thp migration is not supported, but
this is compaction, so not related; third one is to split large folios
when there is no same size free page in the system, and this should be
the one.

> Since it took running fstests generic/447 twice to reproduce the crash
> with a minorder and 16k block size, modified generic/447 as followed an=
d
> it helps to speed up the reproducer with just running the test once:
>
> diff --git a/tests/generic/447 b/tests/generic/447
> index 16b814ee7347..43050b58e8ba 100755
> --- a/tests/generic/447
> +++ b/tests/generic/447
> @@ -36,6 +39,15 @@ _scratch_mount >> "$seqres.full" 2>&1
>  testdir=3D"$SCRATCH_MNT/test-$seq"
>  mkdir "$testdir"
>
> +runfile=3D"$tmp.compaction"
> +touch $runfile
> +while [ -e $runfile ]; do
> +	echo 1 > /proc/sys/vm/compact_memory
> +	sleep 10
> +done &
> +compaction_pid=3D$!
> +
> +
>  # Setup for one million blocks, but we'll accept stress testing down t=
o
>  # 2^17 blocks... that should be plenty for anyone.
>  fnr=3D20
> @@ -69,6 +81,8 @@ _scratch_cycle_mount
>  echo "Delete file1"
>  rm -rf $testdir/file1
>
> +rm -f $runfile
> +wait > /dev/null 2>&1
>  # success, all done
>  status=3D0
>  exit
>
> And I verified that moving the check only to the migrate_pages_batch()
> path also fixes the crash:
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 73a052a382f1..83b528eb7100 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1484,7 +1484,12 @@ static inline int try_split_folio(struct folio *=
folio, struct list_head *split_f
>  	int rc;
>
>  	folio_lock(folio);
> +	if (folio_test_dirty(folio)) {
> +		rc =3D -EBUSY;
> +		goto out;
> +	}
>  	rc =3D split_folio_to_list(folio, split_folios);
> +out:
>  	folio_unlock(folio);
>  	if (!rc)
>  		list_move_tail(&folio->lru, split_folios);
>
> However I'd like compaction folks to review this. I see some indication=
s
> in the code that migration can race with truncation but we feel fine by=

> it by taking the folio lock. However here we have a case where we see
> the folio clearly locked and the folio is dirty. Other migraiton code
> seems to write back the code and can wait, here we just move on. Furthe=
r
> reading on commit 0003e2a414687 ("mm: Add AS_UNMOVABLE to mark mapping
> as completely unmovable") seems to hint that migration is safe if the
> mapping either does not exist or the mapping does exist but has
> mapping->a_ops->migrate_folio so I'd like further feedback on this.

During migration, all page table entries pointing to this dirty folio
are invalid, and accesses to this folio will cause page fault and
wait on the migration entry. I am not sure we need to skip dirty folios.

> Another thing which requires review is if we we split a folio but not
> down to order 0 but to the new min order, does the accounting on
> migrate_pages_batch() require changing?  And most puzzling, why do we

What accounting are you referring to? split code should take care of it.

> not see this with regular large folios, but we do see it with minorder =
?

I wonder if the split code handles folio->mapping->i_pages properly.
Does the i_pages store just folio pointers or also need all tail page
pointers? I am no expert in fs, thus need help.


--
Best Regards,
Yan, Zi

--=_MailMate_3CFDE44C-20AD-427E-9C6C-D6F7E093DEE1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYvrskPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUY/AQAJIqwPsNtL3RZCEp0irMLEgWWP6dCzsybB82
c1lJFSHDx8gWcTJ5mm3ZWywewh+KBwUXS//2524KCWk5VRr2IFl/7eydM91WAcbq
Zo6i17nh84KXEwzHFmYs80t6qYIxJufdo2HM0yk8U5RidHkKbyshHlPu/G3lEqD1
+WInHkspt4XfZK7q6ALoS8aZkpkYE2cH1Zjjx9tCy2kUdgY/Jj8iBvaGQXyqgBxt
0J75x1EVewP1dEKhKgPDJ8bA2eEcvWRm4PfS9E60SKX2F8b7lDHtxBufAzeqcjNh
DKnQ9rNGRfYZvMPlBrVKQmAD1awLW7BUF893XXgzh/qLkkXInBnpINzti8n92LCe
ISDEuiUUgSX2WEqqPdRkr2fUy8DcBnpJv3Eet3kEYhGw/16zSFZTtS5KBfrsaxMe
HClVLDrb0bZoSv63tkIn1eIt/f3XkE98/vEab09XHYX1qQGIihz/4xnZt/ccmy10
yYdicuWpDT7LOyPpll9RHxOz0WpMEAu6Sl0S1zStZtB7C7OjITEqsE40bzFtw1M0
5P8OtQCgSyf9g3z/zFo1A+bnYgVG9QtE1vKHJF8EKycX4WduU8ebVMy7AghTghyW
8rvN6Zc4kvTeaep7eTtxciNDXHOPJR85uF0FTlqZe9Nvsp9sYPT4n32Vf2z5cpwk
KgZh6ZCS
=VRI5
-----END PGP SIGNATURE-----

--=_MailMate_3CFDE44C-20AD-427E-9C6C-D6F7E093DEE1_=--

