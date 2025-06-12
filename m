Return-Path: <linux-fsdevel+bounces-51422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90310AD6B4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3304D7A967B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965EF224893;
	Thu, 12 Jun 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BmEqgN5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF41F237E;
	Thu, 12 Jun 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718046; cv=fail; b=J6ZB+11aBQJZnBRZo5StyukARxtyyP0QPQiRSl+TlLzFI2fggxiaZdKaH7Frsn0BSxQEiSQMRt38oEIfgCY+/46kXQT5BxLC778baRYaJtVNSwEsCxvCwDhShO+3nk6UcNnTaKWzv5ryb301h0DHzP8TSlqUFC5yzbt+OLFZ3G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718046; c=relaxed/simple;
	bh=dhGa+9cyQaJO1vhkstt4fG+R/heTtow6vfnc/QDpen4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XV/fdLpd6nyYaTehI5nEugwdzLqZ0yJuGwpW4GIGtTITvB8zyoC5iGiSBdlVUxJvwQ93mOmWqWEdEZT7MEQqYyzQMPUU0h30RKIjIOcGEUainOQtwKNeplwOPOdQCSLPDw2Wvwy4C4W2Nc97kdllxBluTViDuIDkOgH3EdXTk88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BmEqgN5q; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSL9av6rLnjDPtQYRhNRYroKRPv+gLmUwgKutWEYHtOLsqcEI9nHXX7KPetIGTjxh8q1nCP1N7zufimj1VwflAF7axvvKCSfFeMiYrvUrd2kKhKzsPZo1vonT+4ZoBVYeXneQNkoiETo8/iboXRxxKKCbyMss6yhFFuCiL35Hwm5P6dIAFKdTu9rn1/OSGl/2YavDigjYk2IvYDEblTbJRb9J4wIKj36svopOX6WLHYfqr7QQEj+fWzcJqqdmmH8IxybtsvUYkaNj4oCneXDAir4CvTa/LEw2RknElocja4hZ4V+DZxFHInRUgQ9YkqrtB2AeFQdCBsUIV0ASPt5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gBLu/HtAKyzpB5+V3m/GmUdRvYCGUrHYIL5WI49w2c=;
 b=tACQnuiEjKyvPfK1IVTXMjDoyRdZskkeqmhPavraj+UE5axNWRR96ES3sM+P149acYO5uNHwpjpmzNPf6/DziLRuYe6Cd3KUeyVamsBAERAUHpc6XUmBz8AMdQujqh1t+hGi8CW7bmL/ultZsMwn4MFH2psIwmmD/vlXEz+AF+Fu1uKbCoOT5khVooE9UEinrTOQm9MCNu+3Vm9JZXofIevPRekD1bjq0Qt4ZQf16dtJNvPx2Io8NICpr68dI+vQdOmq3yBMhwcsCKP0mTk9gcS4pQdNOox3abeMnBVvTKwHd/co5uABu2t4X2MDlCHydp48hI0gKUeovdNzcxwCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gBLu/HtAKyzpB5+V3m/GmUdRvYCGUrHYIL5WI49w2c=;
 b=BmEqgN5qUJtu7ik5y+0hTpYfp9N5x7SL8NOp+S9rq0AvVGYipGxgJSi0yOG6V6ZP/82hO+k65NUSTFZgbtyoxrBuwpBq1/ddUOwRfIECJoaI5oNNHI7d34BH2O8PIIQDh+VP4LVAuxU+LDWatz7lEASv4u7qMCA6oWKIlFM2/SSqsyXjIZYgNUPNJSAqqHWeAQjBUedJKbCZ+z4USq0U4g5QJUg8uvta4kzZFcA8q0u4R0IKGy3mxz2IT5kBEbvBE6bA+swJbn3Mw0+Qt/d/ttfvtNw+Wf7dcgtzFSzqLoS0Nc2YZh1LH+OBX3vG8qgOIC98Jh5GYLR+sNJtBGaIHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 08:47:22 +0000
Received: from DS0PR12MB7728.namprd12.prod.outlook.com
 ([fe80::f790:9057:1f2:6e67]) by DS0PR12MB7728.namprd12.prod.outlook.com
 ([fe80::f790:9057:1f2:6e67%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 08:47:21 +0000
Date: Thu, 12 Jun 2025 18:47:17 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	linux-mm@kvack.org, gerald.schaefer@linux.ibm.com, jgg@ziepe.ca, willy@infradead.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, 
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org, balbirs@nvidia.com, 
	lorenzo.stoakes@oracle.com, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, John@groves.net
Subject: Re: [PATCH 03/12] mm/pagewalk: Skip dax pages in pagewalk
Message-ID: <wqzr4hv4vv4wd2mcy5m2gapy6n5ipvex7hst4locic4dbeu3cr@47crvlk4kubj>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <1799c6772825e1401e7ccad81a10646118201953.1748500293.git-series.apopple@nvidia.com>
 <6840f9ed3785a_249110084@dwillia2-xfh.jf.intel.com.notmuch>
 <20250605074637.GA7727@lst.de>
 <b064c820-1735-47db-96e3-6f2b00300c67@redhat.com>
 <6841c408e85d3_249110075@dwillia2-xfh.jf.intel.com.notmuch>
 <axbj5vrowokxfmrm3gl6tw3mn6xbzz7uwbxkf75bbgmzf7htwc@vcr5ajluw3rn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <axbj5vrowokxfmrm3gl6tw3mn6xbzz7uwbxkf75bbgmzf7htwc@vcr5ajluw3rn>
X-ClientProxiedBy: SY5PR01CA0006.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::10) To DS0PR12MB7728.namprd12.prod.outlook.com
 (2603:10b6:8:13a::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7728:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: c2da20c0-3203-4f07-f14e-08dda98dbedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qVLUNKBV672PUP59FyxRTw06X2NrNwLWk7p5KT+0CqSPGmfXD4vWXpuFOFFL?=
 =?us-ascii?Q?fbymzibWhRTt1bXMi8mKscZDFM37p5IVAykTSG8nLCU88OoWG+9DvQrzhvVl?=
 =?us-ascii?Q?3AcyL+pII45q3CsMKArPJ/JxFGxCv1QueSGrulLUUOeN6dqglnhD4LYrHWrT?=
 =?us-ascii?Q?rY+MHqTi92iAJ7OgOXpzqIAQSKVSmihpaNGSmrnvc73dKhI8tIenzKucGSKH?=
 =?us-ascii?Q?a/OVtsLCElodqSdQtWLy80Iyimv0bUsNTms89KzpvnGTdvx3QdH/ghJmYY5M?=
 =?us-ascii?Q?ErcDiviQDQBO6Xqh8fOb1VsRN/QN6WqzHdXMokSnOBcfZM5zBJ7032cZnHV+?=
 =?us-ascii?Q?eSB6VTFCkKpyZ1vi8IL3elqrFVfN86wKeN2vECXTlTLC4L4U2DHsNIYFM9qP?=
 =?us-ascii?Q?+a38WBgEgDOYkji8KMYrhy8G86mqtYkc7U0bjtB7RZOIDgME+jJGuQWgCdqw?=
 =?us-ascii?Q?3ZLAKfbYwDBCciYCAn1OwM/DnBW/d2ZsXit9H134oUcZACXeMsexcn0bE6Sv?=
 =?us-ascii?Q?TQhRhtzrJgqTmejdoRTnK3ze0ahD4CLfxrfAZbgwBNwKfAdc9WPtMXO6WmFG?=
 =?us-ascii?Q?6OCpvpuZdBo4ETX89GbylD19SBJaGGFc3kom2Sobie/+2iYMv62wjIG8LKjP?=
 =?us-ascii?Q?flWEZVltTSNAxxRMff2FfTMhLgFEgwhoVT+88o29iJYw3TlX1YY8PD+re3ix?=
 =?us-ascii?Q?rqY+pBPGlEi+a3AY8KakAv2o8FC79rzcvw0pMc42S2/uuVxRghYyRO1DUFiI?=
 =?us-ascii?Q?PiVfM/prdGwioCE5dj0aWuTtNTEbs7yajIlqrbec8KCSi4VjdMGughNldNAc?=
 =?us-ascii?Q?zaDf+s8BSDHinS46Z8q+mQUM5u30lxIQCvpPU5MUwnG7TFcQ7KPwLuwip4i7?=
 =?us-ascii?Q?d5FpN98QsmiNa4sbCacjcgjzZV1WFRmPDTXWxJRz/tAfAcSL4aTiVTtJBO4Z?=
 =?us-ascii?Q?JAPdsJrHrKKi9l66QfWiSR96onoNsgZjll1KsxKRQ+Q7yvmFZYqc7xRYlTRv?=
 =?us-ascii?Q?TY2uEb7rhEQvMtqojqzymGdA/0D2hL9145i7712RvcHZBWBj0AuO47sZo3ir?=
 =?us-ascii?Q?a3cu5ijg8UPN4Rxv98DQ87A2/8BVNexgQx7UmDLdVY6ae8zV8uUEhs53FbpM?=
 =?us-ascii?Q?hVgR56fW02Auu+CRwxtgprjhVPdlJbrCasfuyDgx6TRyTPJgpokmGYKSTzG7?=
 =?us-ascii?Q?uPF08dTv0YJN5xz2i/SBND1C9KrG1WwKX93vr4ACCn6yi6ulL9Ur7V6xC142?=
 =?us-ascii?Q?o3XzmUhjgUyWhKcIExvrEUpwNqKR2hs2TRPyMDYdrIh2evD5KxlRaexjMsrT?=
 =?us-ascii?Q?q1JpWFOGvy9Oloe8rl1eXIk13Id50qaQskQAmWKmi3y9hwcF6ANhxLvuu7K5?=
 =?us-ascii?Q?rpA/qLq3noTIub2CQoLh0jSOLJ9zcpJJHafBIYiG1LoZQKRHGZAPIFpSSeLk?=
 =?us-ascii?Q?3ZLOtfS87Jw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5KlA2IZ1GML2S6ER+/2zlr+vx9BIeU6c0/udDAp60oU2gEuOrUmHQpHAum5H?=
 =?us-ascii?Q?wh0ukWzMuLpiewTSjO2qXpI5eoKxOVpUXpxgkjfzaYcQBiXBOCgM4GmtGikh?=
 =?us-ascii?Q?1V+cghh5Elpl8QMZ6JLeDLLWVThk9ZfOayqp2mzN80xZYZmITlYnCYuJx77h?=
 =?us-ascii?Q?hw7wEZ2FI5txeO6rN536cV9f64jFezdI3Nx+OnoxfHTHc+ZqrCqj0F7GlaN2?=
 =?us-ascii?Q?Fg1nhvoKi0obfos58BnIUhYB+2vjlX/T/l+ui39q1YMZ/ddXElpcu8UjPYSZ?=
 =?us-ascii?Q?A/KYwLokHokij8m8gD5QYG3Hy+Y9lUJ2DMeGTwWKz3UJmwK8ai5CpSsZgLl1?=
 =?us-ascii?Q?8yjOhM3jtHetE44wsZH36v9Q3t2EhZi6BcokY2VYW2kRJ+aCVuxRCes06em5?=
 =?us-ascii?Q?HjkitfIMVr7jeFHcNFGwOLnCRMCXip4DpGrXD6zoLM55XEjUTQUQF69QKDxW?=
 =?us-ascii?Q?tP95W/bh7zCa+DGbECk/IWyAmHiYkLO6u1hPwCiB66qyBvr5sssHyth2TFAa?=
 =?us-ascii?Q?Xbj/c9ba4nVAiEGcw3eSRYMNC+vQPpysMfhXOm+uqFqbUlX0kBxvqoCzlL/v?=
 =?us-ascii?Q?eMLXREq6oA+toR5VdmDsFKUBadeKp5GOWoKgnNNt71M39cTf8fEdz8JQqMeB?=
 =?us-ascii?Q?RwPsk6Mssfxp1+BZOWOLN+d3S/0hHnV6U3WZaXuoz0JtWwmiCfIf5lsnzJoa?=
 =?us-ascii?Q?Ni3bJMwCMaxkqkoJKTh9eZs0tHluawxiUW/Ru2VGmlex28GbuJlKsiyO+jvA?=
 =?us-ascii?Q?ZaikE2t73Y5MBKlPzmgHcG71w+gAs6ayLE64vEmzxwfU8Uv06Qd+ijvuxBU7?=
 =?us-ascii?Q?6W46eYDkMhD+Mwib+01iUtBfegSuxNqm6POyyFawALA1KSUuLdcvcl9/ecUY?=
 =?us-ascii?Q?odsT2Njw4F1skesWBrgeiYFg5+yHP/AiqhNSShagYHqsl5QiOcg+W8+MYFxs?=
 =?us-ascii?Q?sIljPlk1nlfEtqm0OBir+y6XOgsWLEeTueoCeGtRayeLHuLLzS+HaBarajQk?=
 =?us-ascii?Q?nb1H1E1mV34DgYUAhviO9Yu+uqVuCdizDxZirMy1RnZqWKmUi2tz3qAcidg+?=
 =?us-ascii?Q?Pqoc93kFjxhomMFVShmp7pBgRH87lEOHkn/TySfSpPIlJhbgay26E4+PePy1?=
 =?us-ascii?Q?l6j8kI7Q8jXK7DHv+0wX5VOBw4OX2AERv7xZe9VrLoNrIv4sTIOpEFNrGoQU?=
 =?us-ascii?Q?GlW+0oLwr1JY12bupwBVHdG2txZbcsqZVFf/jxfv/pWsUzmB6I0nfd0oacKe?=
 =?us-ascii?Q?slN6BNOf1m6f88epmVPmC6/Jzc1fsbu/dWIF9WArgeuLdYM5RMo1mE5p9y0W?=
 =?us-ascii?Q?Q8xTl+vIK89UJa065BX/Iw6ABNl9mtlDWIB1DyidmEdoW0euI5tMe5RexotZ?=
 =?us-ascii?Q?Q4Mm0cZD09VsrC/jUaN8B4WpAHHQeoTw6yEsuj97qSOeNQj6Q7e8lTaCn5Wa?=
 =?us-ascii?Q?UFjk26XCLV99NYnmAhJr+6pkNUAN4HT6B4YdgwP4ZUG1589aqDDpWFpoCl76?=
 =?us-ascii?Q?7GVbw4dNEE1XQLxKaxj02ze9FrSmUHjpixUyp/89c1LUGqjAfHZJAE/L8cml?=
 =?us-ascii?Q?EXkLkZkF/iFid6+fAMlP69XpRr9x351ui/400k72?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2da20c0-3203-4f07-f14e-08dda98dbedd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:47:21.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ycjP1ftMoJS44LK8+Qq+frPsDFCii0bnuNtOP/7c0eCjCCO2D4tYcWbsvt0KU7r7rCME8AvPqOC5Kl3L/amhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

On Thu, Jun 12, 2025 at 05:02:13PM +1000, Alistair Popple wrote:
> On Thu, Jun 05, 2025 at 09:21:28AM -0700, Dan Williams wrote:
> > David Hildenbrand wrote:
> > > On 05.06.25 09:46, Christoph Hellwig wrote:
> > > > On Wed, Jun 04, 2025 at 06:59:09PM -0700, Dan Williams wrote:
> > > >> +/* return normal pages backed by the page allocator */
> > > >> +static inline struct page *vm_normal_gfp_pmd(struct vm_area_struct *vma,
> > > >> +					     unsigned long addr, pmd_t pmd)
> > > >> +{
> > > >> +	struct page *page = vm_normal_page_pmd(vma, addr, pmd);
> > > >> +
> > > >> +	if (!is_devdax_page(page) && !is_fsdax_page(page))
> > > >> +		return page;
> > > >> +	return NULL;
> > > > 
> > > > If you go for this make it more straight forward by having the
> > > > normal path in the main flow:
> > > > 
> > > > 	if (is_devdax_page(page) || is_fsdax_page(page))
> > > > 		return NULL;
> > > > 	return page;
> > > 
> > > +1
> > > 
> > > But I'd defer introducing that for now if avoidable. I find the naming 
> > > rather ... suboptimal :)
> > 
> > Agree, that was a "for lack of a better term" suggestion, but the
> > suggestion is indeed lacking.
> 
> I don't like the naming either ... maybe that is motivation enough for me to
> audit the callers and have them explicitly filter the pages they don't want.

Which actually most of them already do. The only ones I'm unsure about are both
in s390 so I'll be conservative and add checks for folio_is_zone_device() there.

