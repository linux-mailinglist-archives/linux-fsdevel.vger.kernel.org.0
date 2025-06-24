Return-Path: <linux-fsdevel+bounces-52657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1DDAE5904
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 03:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3762A3ACDA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 01:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC1917332C;
	Tue, 24 Jun 2025 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnEK3K0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62269219ED;
	Tue, 24 Jun 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750727809; cv=fail; b=F39kSECD95aiWhnnO+aU58vmwXgMzovIqyAOoQgrxOh2ru5/KFjn/srTnxkTEu4djBewCl8E4ijC6xnl+gnKChB7Ef/yQFxQ1vs0G7AegeOiMubX5t3BcVWT9Btib1jFLHlb/TZwOa/nDk27TMo321YlucUsk9fkNakAwF3JW2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750727809; c=relaxed/simple;
	bh=KpOR9l8/V89d9fEmfiQF5j5uJ2SAnt/ZspnusNHDlY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iLalbo3s0K13ThbXsHC9llrsVetQNK9Sx6yrO1N5x+KMUQufpUQm5nZ/j3elplnSuZojJNNrB2LTaZDirUcH3f5cSTSwGOU0WYNX9MWfFxRS1iICI/LGWP6aza7vfduN/AQTIa8iO+/ebGqQSAvzqUGGwoQuMVHINu9pJYQH/QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AnEK3K0n; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEXoLPBKLD9iMi3Taqq/XikwM6ykSavWGXablZYMhVMjLPJ7ACCMDn2KQAFGlKA2zeoznefvDGGn/eEGirCflRE/xvDqU0N1FZDEQ5xY/zfa5GKlK4evOrVO926gIrwSAhOugO9qGqdxz1xoIZjnlW5oLjw/tNSQ/gxgIEtehOcre6bMKN2ejb8DxTWn+5Gcy08dG4E2uhE+jDzcIx8XG6f6skXdbvudZdgyRCmzLxOCGdwTXxy9VcEHfDT68ts3/xDl6ERz61JNmPCSyNH3U2mlEQwCSvAwnGj3PW0LJBJYyW+lW0UHa/+VQzUIFuVwRpzri0xAVo6dQEd4l/Jnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkgWOrwcKajsmItDAl2UZozV1/PvnYZb+T7BSuq7GKo=;
 b=ychUjq4/tF4XD2h+U43EndhaIXqJkA8l4l3wAqj3aBZtTcP0L3ywov+09Ez2P9YyQjP0mM3K3pQSBZHi0EnXDjDB4LVCE5wuBDUm6Qxf9zOUB8BjbGM0/zLGHuT6HINn7QVKpxFUh9CGe1Zpq5mRi0D+D+GNK/hto0Oe9ia38nTzPP/tnMOW+5kUPMbiuhAq203309hxAi2mNiCuJHLdPMKeiP5oKM9dchPWUFeSbIigG0/HwXyQzXOyL3wDYRhwDHPOrwMY9Joj02k+tFsXYIrINgKqbj1OUy1jAd2Z/exUsrTnbNrQPLEWuRgdcJ0tKt5+KJ0UsFWE9l1GSwpQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkgWOrwcKajsmItDAl2UZozV1/PvnYZb+T7BSuq7GKo=;
 b=AnEK3K0nC0BsZBV5LeuAo16MWoCEfKxrUQHG+aLuGCeeIOv2jXcuAmcxPRP/fKwS7lajTjjRNUeOZacb6bzn7TF3pmYW1aDenFmW51NQuF2ydw5XtCdgSjxir5xkG/Qlbhdtq8i980ImGGKtzJnDTnyYlQxQyZHC+3XJlor2+TBDZCBW2FyAKFVFMC7y7GTkUg3RK+FSTcRaUScXe4kveffV+witsyI2S+wn1/D8UiZErTMOxzgLQzIo0ijnSt3U0V+6AP4GuT+juCphZcTGe09MeHCAvgVMwH16b3FAbHDRw+8sZIFsYOGBB1LwLfe/1K3YTcHG+DKgQKDWA/YYEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 01:16:44 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4457:c7f7:6ed2:3dcf]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4457:c7f7:6ed2:3dcf%7]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 01:16:44 +0000
Date: Tue, 24 Jun 2025 11:16:38 +1000
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
Subject: Re: [PATCH RFC 07/14] fs/dax: use vmf_insert_folio_pmd() to insert
 the huge zero folio
Message-ID: <cneygxe547b73gcfyjqfgdv2scxjeluwj5cpcsws4gyhx7ejgr@nxkrhie7o2th>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-8-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-8-david@redhat.com>
X-ClientProxiedBy: SYBPR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:10:3::31) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 29106d87-fe44-4d54-a123-08ddb2bcc7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SBsi3Onb/yPW9qEv0BkI913QxivHCu7eDcb4rmr2lsHoVJ3R9QtcKHJonpdF?=
 =?us-ascii?Q?aWlSN4bmQpy5kuNIOl6mT5IuNsTYfHYpscWHgxf2h5nLbe8JZM8ViqhGaNqS?=
 =?us-ascii?Q?iMh3mHHVN465bTYbCshBnK+J0nThMExjrq9ZQVpwC5klMpsk4o5l9ZZQwEHr?=
 =?us-ascii?Q?emEAMibF9HXZtQ7ucuJLS799LF2j0QgPFNeegrjXgTig+H0xC2NXVbo7BW+7?=
 =?us-ascii?Q?7kzVmKyOa2H1t13IAghugwpIRujL3RmDJ1SVbI1R5SUL4U5F47yzPJY2yvfQ?=
 =?us-ascii?Q?bsj+/kNELdNhYvno492X+Ed4NGfIJ/6sQoG7Fmr+uFjIPEbP4cEdaXEPOT15?=
 =?us-ascii?Q?GJ1Squz0wHzTvUouYMP0hVs1Kg/lWhY/2vFdhu3LqqsbqEOYuFR9wZ5+24WZ?=
 =?us-ascii?Q?ha2gEpKRSjDUBh4M9dak4WzeUlr+rDyUXAhItgtnv48R9XH9y36mTz+jsgyZ?=
 =?us-ascii?Q?PyMyQC1Cc0GguzVrllYl1GSnaNz4tRbcThph53IrYeP5tA4nPdjDXp5z7FVt?=
 =?us-ascii?Q?ez9l7lLI7aHBq6tRtozLFPHZJxew2YDjMurzzrTJAHEGiUcdh62VHDlRU1mJ?=
 =?us-ascii?Q?Owo1E/h/YXGdyyEAOcSxbBOBJ20wrzU3UrSTU4cRrwZDpima08wx9UXfu0MH?=
 =?us-ascii?Q?AuXgPPV3LUnAWH39DB2zlc/2F06ZLQML8gF0qCw6dDODhEPDB99oOvSe1sC1?=
 =?us-ascii?Q?Q6/Y8JPXdetfnV//WPseapSYz10f5wr8PH7ehd8ZZAKaMi/xAoh3YJrSKAaL?=
 =?us-ascii?Q?Z1kZlXm4Pebwfb98zXvQFV+A4QyxaGGHKJEO7j21pS64fY2MKjQzr6/v92Z7?=
 =?us-ascii?Q?fj8RDbNGyOp0uemoVdvWj56CObi9/R9W7k384h0DilL/qigw4mIVSB8ZBJjX?=
 =?us-ascii?Q?vAwwECtrCEXFy5LObEIQct48kJPWjiQVlKcByjMMyEHwnnXJMPdXCV+VTwiE?=
 =?us-ascii?Q?UVhUD7Qplg7c5oIkHBMG3XTfYOMiPSWDh3TtL+XJDkAOXQnx9uRIky9V5vO+?=
 =?us-ascii?Q?RBAb+U6mG8P1M1ysrFpRf9c/QnALDbeReK61CvVrqJMeuJPygYRWfwqoHvPt?=
 =?us-ascii?Q?sCw0uqJr0me2uxEtirFWGET9JLTilKl1hcgrUalqx2SRILcvX9DLoGkkrj0W?=
 =?us-ascii?Q?rehli47t79n5YuEkMcclTc2ls1g7kvMlJ0DeNr3bWQwIbouIeaVEW6lN4qvS?=
 =?us-ascii?Q?RV/x5+7ljjCRTMTPPKcKtUuLWuSHtKQZ8yshIELhfBzpsjX65gUWIcQYws0J?=
 =?us-ascii?Q?xMZps6uOk7HZBERA5iWqVPKZbMQgdYSDUL9I0oGNjSVrNd3Rm6nldeqqDCAy?=
 =?us-ascii?Q?aGpbVHbTEDXKPdKOo6ykOYCWWrg3emw1xca31pziekISNCPPmHA8gRrSFE7J?=
 =?us-ascii?Q?OyDOI0Pxf/ymf7SVTjhTVneycwUqb5k85rohdKtF7MoaWM/bsyJADfi6lNmM?=
 =?us-ascii?Q?JQWXsmwgyXs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lNtyZpYjYpOo3YOyyJkWy9LJ30ISxkDgc8ZJmqUaRyRAVR/4GRt0EzEZjemp?=
 =?us-ascii?Q?nvBOpe6hyOKcQccuQ1uQqlbJM3GC3QWtM3SqEJt0ydL6jpUy03Ml7vZTcZXc?=
 =?us-ascii?Q?Kb8hVv5M3yTqBUZltS4wgIVLhShgPR73axUya6SgiO/6vGq6N1uq+GXu/jGr?=
 =?us-ascii?Q?ere1YAgtVq+3Smi7PV1O4cMFf/nwoJaJYCYL6/CgXrbXyTTwA5l5iXpV7EnC?=
 =?us-ascii?Q?HCzRNv6PHM2K3qSq/SRbFMDVIrCkx48Xu+mPTwrXcdMaql/pvxZ2kBn5OiJa?=
 =?us-ascii?Q?+Du95rXFEZjfw+2ZtXoz8Ovo6+/oYDseNr1UoDfXy0oz70UkLzCQZFXEyZNA?=
 =?us-ascii?Q?CIHTdIVoTMlosGxMQbpH3y6oZWTC9qTyLa6eQLawlvKHIrxUKT5xLdwkPgve?=
 =?us-ascii?Q?FJaGHPlXbb+ZNlEbkILOIxVmP96tt5YmvVchR+yYqpOnGM8QIjQ07iYETyLt?=
 =?us-ascii?Q?tg86c8iR8AoTFZC506NDXZuuGEhYXtPasb87VVn/66q8+Z/oPYycpjDcxSY2?=
 =?us-ascii?Q?0qThwu6AdeZzfSgzzcsYHg56W4k4h3lkF6dCO7giO/K6z16ze0p33uEZM7rp?=
 =?us-ascii?Q?dyShl1ZuK8/ttpOS0IUxozbh162bo1OFTUXxTQ2xuOUwYlTz61XrB9+KTCo+?=
 =?us-ascii?Q?CbJLOcFzOXHmqktvPspO8yZrMotz4zbnw2p6rPzNpFj74wp8ugS87sJeLPNr?=
 =?us-ascii?Q?aIv3MrhWfWIbrAYUiCpddcb80ayNX5W8sjrce0gfZD2CBz/QtgWBLVkWwSpH?=
 =?us-ascii?Q?0LM1y07kJFtsBpAykF5CVE5PmseLQT0P0AXaKRYu+SaFt5RUaLZJ7MxCK+bT?=
 =?us-ascii?Q?8NzrsSqcHOFfEtUJW1/78dVDTQoDIdZ8An99Cl4aOa53It/1n7b1FvfgW1Tn?=
 =?us-ascii?Q?IRT9OiirwCv1b7fcu/lmO0gphTdde+R62n0NwFgDj6cZd2PnVg7c/vY+rQJb?=
 =?us-ascii?Q?ZZOW0E9gyyfJdll9dMXDBRnta3KNBt0Uy45XuLPn7xfuCvcQz4xAHDhrxaK7?=
 =?us-ascii?Q?84AT+E/GT9jpiX/z5CFjTaaSQk0Qx5Bql7gMsWyPfESUJiIFxVaKj/WUzPx+?=
 =?us-ascii?Q?5RK7ggWcjrlXXDEqnb6XC9OmmlcOymQiD62OQLyqxzUsjR1XxgLUrAHBe+Cy?=
 =?us-ascii?Q?KMsuzVBQhSAamF02zceiUc2hgfF69uyL2x5Jp0XBpyxX968/0kUg5Y13GUdl?=
 =?us-ascii?Q?72VgTHvykb8dOY5zeF/78gZ7yNLYP4IUu8X1rw7jn/cFXTYTTZx/zoD9MU3e?=
 =?us-ascii?Q?SQ1dxxFDetXyCPgCHpHMIS6W3jbphQvAoqMb2vO7m8RpMdAjAG833WsIJqKZ?=
 =?us-ascii?Q?4wiO76g49ewF2al94AUqtBQFw7/JPYx7/oiMaKAXdodPfv7F9tL7/wD/X9OX?=
 =?us-ascii?Q?0GwdnXUCHZjZzwFPKqardRM/Cw3FA9zgiw5CbUHyQVMJXecTVwVsZXCq0SXq?=
 =?us-ascii?Q?q5y9Dg4uH3wa80kYJ1unmTZcpdOiFV8KKC2QWnFwS9PCSEu92mLXMU+mctph?=
 =?us-ascii?Q?Fvq0v7dDACZ0VsTcsfyp5sHEkdmrz7sMivxhNMw1eppoMq8FIFZErptPgAy5?=
 =?us-ascii?Q?RAAUJhQbo2E/Vt6FPs9cTVCXyAvp1S3NutRVaH0E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29106d87-fe44-4d54-a123-08ddb2bcc7fe
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 01:16:43.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgkZWTaKFKSys0KPQUnH8g1dqJoGQwZpWsLPvQgk3YCRsj3BsofPPjGI0WcsgWQgy8+Xx+FBwBmSaGPpSGHOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360

On Tue, Jun 17, 2025 at 05:43:38PM +0200, David Hildenbrand wrote:
> Let's convert to vmf_insert_folio_pmd().
> 
> In the unlikely case there is already something mapped, we'll now still
> call trace_dax_pmd_load_hole() and return VM_FAULT_NOPAGE.
> 
> That should probably be fine, no need to add special cases for that.

I'm not sure about that. Consider dax_iomap_pmd_fault() -> dax_fault_iter() ->
dax_pmd_load_hole(). It calls split_huge_pmd() in response to VM_FAULT_FALLBACK
which will no longer happen, what makes that ok?

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/dax.c | 47 ++++++++++-------------------------------------
>  1 file changed, 10 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 4229513806bea..ae90706674a3f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1375,51 +1375,24 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  		const struct iomap_iter *iter, void **entry)
>  {
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> -	unsigned long pmd_addr = vmf->address & PMD_MASK;
> -	struct vm_area_struct *vma = vmf->vma;
>  	struct inode *inode = mapping->host;
> -	pgtable_t pgtable = NULL;
>  	struct folio *zero_folio;
> -	spinlock_t *ptl;
> -	pmd_t pmd_entry;
> -	unsigned long pfn;
> +	vm_fault_t ret;
>  
>  	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
>  
> -	if (unlikely(!zero_folio))
> -		goto fallback;
> -
> -	pfn = page_to_pfn(&zero_folio->page);
> -	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
> -				  DAX_PMD | DAX_ZERO_PAGE);
> -
> -	if (arch_needs_pgtable_deposit()) {
> -		pgtable = pte_alloc_one(vma->vm_mm);
> -		if (!pgtable)
> -			return VM_FAULT_OOM;
> -	}
> -
> -	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
> -	if (!pmd_none(*(vmf->pmd))) {
> -		spin_unlock(ptl);
> -		goto fallback;
> +	if (unlikely(!zero_folio)) {
> +		trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
> +		return VM_FAULT_FALLBACK;
>  	}
>  
> -	if (pgtable) {
> -		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> -		mm_inc_nr_ptes(vma->vm_mm);
> -	}
> -	pmd_entry = folio_mk_pmd(zero_folio, vmf->vma->vm_page_prot);
> -	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
> -	spin_unlock(ptl);
> -	trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
> -	return VM_FAULT_NOPAGE;
> +	*entry = dax_insert_entry(xas, vmf, iter, *entry, folio_pfn(zero_folio),
> +				  DAX_PMD | DAX_ZERO_PAGE);
>  
> -fallback:
> -	if (pgtable)
> -		pte_free(vma->vm_mm, pgtable);
> -	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
> -	return VM_FAULT_FALLBACK;
> +	ret = vmf_insert_folio_pmd(vmf, zero_folio, false);
> +	if (ret == VM_FAULT_NOPAGE)
> +		trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
> +	return ret;
>  }
>  #else
>  static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> -- 
> 2.49.0
> 

