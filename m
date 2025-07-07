Return-Path: <linux-fsdevel+bounces-54041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F2DAFA9F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 04:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5181A7AC2B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 02:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9821C7017;
	Mon,  7 Jul 2025 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQhp3gMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A11C5F10;
	Mon,  7 Jul 2025 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856717; cv=fail; b=pHlq2FsQWiF8PTtI1R7joj1P/IOE7ip+0DI1A4rn9hmmuRQ+Ihgi+84gTvf/NTAu94xMS0lI5sDJ7Aw3tIlnSichx21+eg1anNheM/WCpAcuyUFEexXn70jqqXd8C948ywGODjJHvcHRu92Tw61e8e7pdImajt8E4EKrxHwILEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856717; c=relaxed/simple;
	bh=bClxJz/R8FVFJZ4wUFdcGvVWHLUSEagqJoQjpo3o5Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j71FM3nXiqPbXDOf5IQfJxa+Ft+R11JmzhlKmaelq4bSlmAU2wtZqifJII7kcAN+t0TEunWZrbz9Y2EVRKvjOaUl4u+wXRJztZ3Hi5fQc1ATlfwz6te4f5rchFEpbmGmjdhYxsJszMHd7hBAbSTHb22YXvE/NX+jk8toywusZsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DQhp3gMu; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya/TPhRViUSgQWHdQj4W7DUJV5eYFZvht3RoqdlllxujYu4YhS2hZU5/plUbdlt9TcBFt8lXi1hLLMEXvwMrpLFCp3DtCcIALrbGv/IZvBbOUEs0oXm0H70rN9Ij5vMQJLYTAkC9aqthRngLggr/tNinz1gK3bGAH9Cj+/VS59JARJG6hgCitczqlaRjXX5bUgdmm8syBrzmNcPfz3Nc0oJO5gQnxGl8eXb+M77Iy1yBuV5domcO0Fs34LMchF8+LHmTbkHFbvuKZ29qvUGJCCVzKcOj5MjWSfPsRKWeqDYOaSre4emVP9WiNo9qzxdoewhZV2IRLlVkfWQN+yjhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znYXkndLmRuweLSWHV1PgSaBwtvu3vdMNBfA28KYgFs=;
 b=uRr0nkUdxDILHaDChmjSnDTTkZwmGU/3CobGB6ueWcEEMXUkoiRhiNx/D9LOWTtfith9Fz7VlFehdFyR8YAQ4fT1i87FJjPE75EnT4H/BAvikUJS7KOVtx5v4kDy3bq63jIeSbaGefJcThoGmkUiKZ01hiWegz+KkYRSSIBRmd9NcFoT3ExGzI9du3iihIsZqd9zitSp04JzBULVv/m4M4GRPn8xfbND6jOPZFhFsWNU48Vbgxf+ACnFlpy1D7eUP+7+1fQzq7b4yMIqC1Smnmp0g11cHmt36NyWgaxmjyPFa0x9HdoSEIm1gp+A0u6zu6rzxGhcfN7WdKypo9YY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znYXkndLmRuweLSWHV1PgSaBwtvu3vdMNBfA28KYgFs=;
 b=DQhp3gMuGrum2yRiByxtDp1v03WRV94cjZ8B41trG6L3qz1mnylZAt/tFqR8sZicyCxvRxYjwUKlXep7wnsdBCmkvvk9gUZOSRWgVoRMA13RjXd89IzervOKO7HK0ceUYEexw1Qw4KZCnyNOZq4FZwCey2d0+SmAPBo4YhjK5x5IUk+Rtv2Pgdg1ae8IAVa89nW3om1YYNbCozatNbnEjNT4lFPp66MYijX1M4Mmr92qeE+MgP0YXnpG6f65vSA/9trbcp7q6t/J5ZecS8YmZrDdB5Ei+z3FaKVMeV9J/aNhJ2pUKIAUizaJooKxZP3lHcExWCoMJTaNpqGdO+s1sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 02:51:52 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 02:51:52 +0000
Date: Mon, 7 Jul 2025 12:51:48 +1000
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nvdimm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH RFC 05/14] mm/huge_memory: move more common code into
 insert_pud()
Message-ID: <5v7yaq6o3v42zcye4hdab5qeoujccndkuygnho7adnxyexdbhq@hqz6fucsavf6>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-6-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-6-david@redhat.com>
X-ClientProxiedBy: CH3P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dac23eb-425d-4ba3-6ac4-08ddbd013a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkTzTa8yo65HC61RQLRXFPdwnGuYiwWq7YqXwmseXlNSQDFwGG8sqSW3PdyO?=
 =?us-ascii?Q?vm7MadgzkcdWN9k1OQN/Bg7KYEFes9tqpcYBOo0hPvQd2kz1XuvXP7ulpxhi?=
 =?us-ascii?Q?GsOe76mUGUhHL7o+TadsLezIWOCfI27FhSax0Mr5vfsdV7SHIMvSgAVZ6fVp?=
 =?us-ascii?Q?/YxgKfDj0qh4mJKDhPOY+VvRvCx3Uj/x9jGVNmBS0/KfUFajm08I+rFHl/Lu?=
 =?us-ascii?Q?Pbc9ox6Rg/N/392mO5pWEpGULkPBhibw7r8dJwdaOe27VfUVvuD4TSr1tn7O?=
 =?us-ascii?Q?2U9oRm/PcHKPidH2SyA7FSyoX7Hj+dt3cqZkEtJh9XvWvFSBQsYVLxaOizCN?=
 =?us-ascii?Q?ZnxHdj2S5fqX9YCio9t7KZQoeQ5OSysWWBEvVz+BatLnzcMOYQadz0mz1o1r?=
 =?us-ascii?Q?OLzfCtkHZCDgA1Dtyvg+rrwIFqU6j0pIdmpeAh+mQg9ENMdDY06RDnG5+mUK?=
 =?us-ascii?Q?i8F+nFHR1iKS2eRkMNmqCog2L7qq4zTnWLkEy6y/dVCEiBl21SaWi/uwkvNc?=
 =?us-ascii?Q?JQKuJlpIxl4XHsdljkkNHY3JV0Vog7JusgR+Hgw3ppJZ5HeAUChv2AgL/qKs?=
 =?us-ascii?Q?WaN3zKln+AOOI0GME6XKP96Hg8bzfug06xqlxliHqP/CYGKgQNJrfVyfKKHP?=
 =?us-ascii?Q?MBKBNuOe53C856B2RryfUiuwG/fdwyK88Ok42rhcfdDZTjYy4kDqr4wEtA33?=
 =?us-ascii?Q?+EQo+BZdwPBLooC1ne+mW/PSpi/Z1BU40PnzHC470BiidO+NJSbnz2bOYsJM?=
 =?us-ascii?Q?Y7j7CAizo/wIlmZrSZ4ulEgVlgv7BfI89KauWUVHGZWD5Bjdvmf3QGhGK2VT?=
 =?us-ascii?Q?yPrvPGDbOLpm8XjdnInZXtYzkLQCdtRUOdwBCQGf7F5sCytnpZmF5I84nyIs?=
 =?us-ascii?Q?5QZjQemENtqzyweBhZlAX+/2rkdwVhtUZmnbC8us6Muh9QfJIXQoPOOOzyYW?=
 =?us-ascii?Q?lg6XYz4Vli3UtY2LeXnhLFR+JzQs3Hv/M0TZTrmJQ2lfkNO7NSTYuQj9sD31?=
 =?us-ascii?Q?lcVotIHKyow6yYTDQ3XysC/xXZdU7Y8EmbT6uKc+iHsrMwDIURYB96Bh5osq?=
 =?us-ascii?Q?W52RIw/mfN5S1sXO1zJWfWVNNANXw22oll3dDYWXR22Segi7Rhq3y65ciXZe?=
 =?us-ascii?Q?si7nCHjYPX1noCdr/GLAh8qBTiE6o6gjnM6hisvtMuykIWrAGjNUiDhZklWo?=
 =?us-ascii?Q?YA2fUMFtHs28PVX5ZIq+1s44eHdxOYVGjWsYtAakE6o1QSvIEIZ2Pwqsqkh4?=
 =?us-ascii?Q?zLBGwLNx4Fin95AuGFqnU7rpfTmUoE5LDx+2eif6veG2yjKn3BPnQu6jPPXh?=
 =?us-ascii?Q?a8cbLivZZj6OabyqZf4xebxAb0PF2AJEAukcx4xaG1mhw+1zzKNksnRH/RkU?=
 =?us-ascii?Q?5TGinwsnmIJKomLOaYbEY/5NchfqdGHb9G3D7Z3ezvRuLxe0TAeWF4+KoUtE?=
 =?us-ascii?Q?I0bTBMHdMy8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?REwcFVujST8HjOYpDozq7LYwNjnnWb4bcpR2N6INnF3ZtMQi4l3kKbvXYOlO?=
 =?us-ascii?Q?RDprdeU5OGH8RVUImEz+AdsW4FygKffx7VIBiTk7U0gY86g5h7oPzA+8ssqw?=
 =?us-ascii?Q?EpIhkqtbGk6VlV31T21YHE2aYgipQ3lv7lsAb0IfP9aHp1j7wO1/usZ/V3UM?=
 =?us-ascii?Q?WTuCLDodHnRp8h9Z7/MtAHHfPXn+8vm3YOJjESHyekGnlqdQOxa1k5/8FurC?=
 =?us-ascii?Q?fk+tYnX1ltOMBaK6xoSp/alpZOsTlAZ0xWiM69BU0iyRxXGOEg+O//Sw3Q0j?=
 =?us-ascii?Q?Y0zzQMxO/wcVm+uNnfUheW5xggWqxGBc50+8uOHPI5LKiazEMmksXvyWgXAT?=
 =?us-ascii?Q?ql+5Fszt/N1/Rjl99x7tZ5+zeR9b06dd+hbiAPMvuRD1fk53zYkvPvIJrBir?=
 =?us-ascii?Q?p36gP5XN8OdoTkXomVal46qSDLUiDT7YTICYvnZiz9IV18+Fs2GR4/o2WBRW?=
 =?us-ascii?Q?8qB6sKXI8W6wH2bfAGo8TM2U0+z08oXAO9mPLMRKQIukXOe+hZP25oL5m5CJ?=
 =?us-ascii?Q?UgZY7eG/6ZgpFMHZNsCFRs7gDJ74a+DoOOiUWahPTGOyGNrNoTcjs0secc9h?=
 =?us-ascii?Q?aZ3K4fwYk/PQ7fkxsAf7x7PDi1QSFdI/HbWTZJ2N3XIF68vIVFJ8zum0n4tR?=
 =?us-ascii?Q?HKHmWxDz79Yb/mYgqJpuPgixKlpNrsgyCvWlUWg44gLXGd7J2cKvcT8vgpyD?=
 =?us-ascii?Q?cohqayrOyUsZDccJ4Cex/n0OUbda9E4qBipz7Mlc9cMWnL6IaWY9dF83pg61?=
 =?us-ascii?Q?CIg5sFyZBnpR3CnXiCvFISbyf3AMMf/5Do1kUPNIRNiok390egvE3piLUWie?=
 =?us-ascii?Q?tP6AJS/ot7H6wSvdHc1mVlPiwLMHOxeGbAAdEJkVn1rAizuYT01+JaigHey9?=
 =?us-ascii?Q?C+WjXfvKUoIRNoD5GHJajo4VFsHVzH030i4totl7usrdTOV/9cabw5G5L9nm?=
 =?us-ascii?Q?PjjOr6/8H6bHQvShRvLL1URK8yIN/RCWO9O1lKyizYPnI2/fr0jboVu5S5qs?=
 =?us-ascii?Q?SIdn5i1fG8o8rb6eKtJogiwHRCrQ8iiLaPTvvySQ6U+wa5cy7AWXBPZ8mzMX?=
 =?us-ascii?Q?hqlzyD3gH5uCcxXvg+OZmEQ6sYBVpoFfA1MMmH7bHugumWa6FuC9CkoeYUv1?=
 =?us-ascii?Q?VaF7cwbUW0hUuXJzWA/2ux9tbfXsbC2+w9DI0Eo4XC3AQDkNjliuKE1CGoU3?=
 =?us-ascii?Q?3TgKVzvzYVewinx5i3kA+1G7VzqIZWs3fqdgR7LzPUQtUNfUM1dXk7dVI9DQ?=
 =?us-ascii?Q?wte7+qY98wQDMUaFPjPKSsWr0ymJ89rPg37IMlhG4/HZXeSh5mEGwdeAyYD4?=
 =?us-ascii?Q?qbT7tVv4MZqi41Jo+IMsrxNhM0o5zvTvr+yufPoK2kRSJBA4Zo7LHw83jL+w?=
 =?us-ascii?Q?eR39+3kPuqpe9l7/PhvVse6b8CXNRbZD1+0rTRmzdixiu0W8e7/mfJ79RaTl?=
 =?us-ascii?Q?JGWMI1SmpetMVMwwXeRKxAhOnTtHNFYf6ZUEKvOhyj+fgCvbEYtP+kZzvTxq?=
 =?us-ascii?Q?GvmyQFjBxkozXAgGiT8G5FXq6Uff7WiuquD78H5q6e7mC94IUeNaUndQcPJ4?=
 =?us-ascii?Q?RfnK+hLCNy8aollrOXq+8CSfXxc+h2FdE6EOLYU8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dac23eb-425d-4ba3-6ac4-08ddbd013a15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 02:51:52.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo9+D1zCptN4n2CtosMV8kCpUmG2Zwu8iCUQYZvHqKnZwmrgGqtp5NF/MHG/kpiPKAffqaAuUt9GOU5xdHaokQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684

On Tue, Jun 17, 2025 at 05:43:36PM +0200, David Hildenbrand wrote:
> Let's clean it all further up.

Looks good:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a85e0cd455109..1ea23900b5adb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1507,25 +1507,30 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
>  	return pud;
>  }
>  
> -static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
> +static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
>  		pud_t *pud, struct folio_or_pfn fop, pgprot_t prot, bool write)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> +	spinlock_t *ptl;
>  	pud_t entry;
>  
> +	if (addr < vma->vm_start || addr >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
> +
> +	ptl = pud_lock(mm, pud);
>  	if (!pud_none(*pud)) {
>  		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
>  					  fop.pfn;
>  
>  		if (write && pud_present(*pud)) {
>  			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
> -				return;
> +				goto out_unlock;
>  			entry = pud_mkyoung(*pud);
>  			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
>  			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
>  				update_mmu_cache_pud(vma, addr, pud);
>  		}
> -		return;
> +		goto out_unlock;
>  	}
>  
>  	if (fop.is_folio) {
> @@ -1544,6 +1549,9 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
>  	}
>  	set_pud_at(mm, addr, pud, entry);
>  	update_mmu_cache_pud(vma, addr, pud);
> +out_unlock:
> +	spin_unlock(ptl);
> +	return VM_FAULT_NOPAGE;
>  }
>  
>  /**
> @@ -1565,7 +1573,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
>  	struct folio_or_pfn fop = {
>  		.pfn = pfn,
>  	};
> -	spinlock_t *ptl;
>  
>  	/*
>  	 * If we had pud_special, we could avoid all these restrictions,
> @@ -1577,16 +1584,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
>  						(VM_PFNMAP|VM_MIXEDMAP));
>  	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
>  
> -	if (addr < vma->vm_start || addr >= vma->vm_end)
> -		return VM_FAULT_SIGBUS;
> -
>  	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
>  
> -	ptl = pud_lock(vma->vm_mm, vmf->pud);
> -	insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
> -	spin_unlock(ptl);
> -
> -	return VM_FAULT_NOPAGE;
> +	return insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
>  }
>  EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
>  
> @@ -1603,25 +1603,15 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long addr = vmf->address & PUD_MASK;
> -	pud_t *pud = vmf->pud;
> -	struct mm_struct *mm = vma->vm_mm;
>  	struct folio_or_pfn fop = {
>  		.folio = folio,
>  		.is_folio = true,
>  	};
> -	spinlock_t *ptl;
> -
> -	if (addr < vma->vm_start || addr >= vma->vm_end)
> -		return VM_FAULT_SIGBUS;
>  
>  	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
>  		return VM_FAULT_SIGBUS;
>  
> -	ptl = pud_lock(mm, pud);
> -	insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
> -	spin_unlock(ptl);
> -
> -	return VM_FAULT_NOPAGE;
> +	return insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
>  }
>  EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> -- 
> 2.49.0
> 

