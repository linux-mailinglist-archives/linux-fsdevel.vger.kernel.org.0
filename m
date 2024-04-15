Return-Path: <linux-fsdevel+bounces-16971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB21C8A5C78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 22:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262E32819CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0328C15698C;
	Mon, 15 Apr 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCDxu5B2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D6156971;
	Mon, 15 Apr 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214302; cv=fail; b=UE/qCt7eCggslzClD9kuYtcJbwEkdmtfObvbrDCmwUR//7r0glI/1W43hhRsOm5DZdGJqWGEn3hLTpR42DeLx1BVT4omCGHg/9WlYnVShr3T2VayeDhOe6fjVLNRsNYMHiz7yVYDwr/UZnShE9ZGBY9kGl+443IotpX5hXOtVPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214302; c=relaxed/simple;
	bh=V+VtO9918jh2ofjDYvfuxld9MD6XOlCWB0W/LGkQRJY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TYAk250AjUu6ru/D1zka3+mHMq5txb2GLwr0/58aRtY9UDPjPTQCCPdxp48PxnQqrnsIO+mmiJTGBgFxmbRpDteokZUIPj1EVTKBggJTmmlb58mxhs2VuSH55Bz9/JlqSr8F8iTswrQXl9qvMqmjRiGL2u/Wdpw1jiCy5KWwBZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCDxu5B2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713214301; x=1744750301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V+VtO9918jh2ofjDYvfuxld9MD6XOlCWB0W/LGkQRJY=;
  b=jCDxu5B2t0xZzoc6qOHp4jXf07xXYmd+pis9ZKP/wa5TzH++lGhBA6eJ
   ieN2vxUDTUmOvOe6CX5kJb8N+bnHOQbp/zjskqrTh/e0KlZUn3Qr6ePFI
   pyASPNj6v5Y4Jr3lziHCoqZOYT2duTcfT/TQn0VT2nhAbe+BTtrNJ8I9C
   4ajlhIvcZih/NggyfoXMbHvaV7hATR1e2huCy1/OlsOb1W/aRW6mr6gvT
   LlVCHeTQOdgpnhSZfFEp7hty9ksvIg/j2DiVAJdhA4R0lrYuOAvHWPOGY
   YiEtKtXCUsCK/OT2n51KIqeIoaFJtrxBxSKjxtHe9fuQrjOBNSpw4xCnp
   w==;
X-CSE-ConnectionGUID: Ya2HzES3QkiMsuYkGIju3w==
X-CSE-MsgGUID: GO6aQVInR0W63e/J+zIZMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="34010243"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="34010243"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 13:51:40 -0700
X-CSE-ConnectionGUID: +Ilv/g7sRPS38n1GPvbHwQ==
X-CSE-MsgGUID: K92rYIN9TiCwojUGm8EKQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="21928560"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 13:51:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 13:51:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 13:51:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 13:51:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JavcYxK2hTOf458zWNV/bfpr2BP3so7CnRYdn4JPNahDE7ByN1yp1yeCKbOD2i3dyKOvdzBDRPs7IM2Etruzl03jnAWTKFL5U0ahIcZDu2Ry4YpKjLvBdC98IeRn0QPWjGAk8asyMmKoI9TG3ZqVAUjv4zfzlpDHDSWeQcnZlSvyf8FGbc7J13ttedqwsjBUXMrcEmzuTS7MG7P92dy+oKRZXXoY0MqBl0NFGjMIdDEEzBgNCplh4mBbBoKR/gUkpku6M1a7tf2p0nVqZVxeqLi0DIKI853p+QsTNTGrBVv8YSYqDkPDlbAc+d19A5wn1XDq7saBPS/TOmgFGCvcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvqcZRBsCA8jLb3hZfwTo53YaA3KioLwntO2Rzj9NEo=;
 b=ilrNbrRtNF0F26odArBQH1q7vVW9U/JQs/gRdweZFi19OSRBFvDphHsdexF27Thj7ayIenYKbSSOTNNKe0FaNoRJoBdSh847Z+lFpgMGnprUe/pUUdrMJuBsY5fZw0ls8Wa4BCxPx4hlAUYC52nwNbGKPqhUtQ+/fCQvi1IYW2GnVmHBBaWaM3cLKmqH1JMNZmZd7zUjtlbK7xJKiEKkb0q+IWb8f7PmGu3Yc19cSO/VTzGlRYndsxgLFwuNX9d8h7umQy37xUepk53PxR5BxY0H+nOIJXhMq+vVin+UKrEVX+gWXwzgmXI4Lq1CU8R+1eEyUGZIywGOTVbuPgKwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7883.namprd11.prod.outlook.com (2603:10b6:208:3de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Mon, 15 Apr
 2024 20:51:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 20:51:36 +0000
Date: Mon, 15 Apr 2024 13:51:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-mm@kvack.org>, <david@fromorbit.com>, <jhubbard@nvidia.com>,
	<rcampbell@nvidia.com>, <willy@infradead.org>, <jgg@nvidia.com>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>, <djwong@kernel.org>,
	<hch@lst.de>, <david@redhat.com>, <ruansy.fnst@fujitsu.com>,
	<nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <jglisse@redhat.com>
Subject: Re: [RFC 04/10] fs/dax: Don't track page mapping/index
Message-ID: <661d9355239bc_4d56129485@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
 <20240412152208.m25mjo3xjfyawcaj@quack3>
 <66197008db9fc_36222e294b8@dwillia2-xfh.jf.intel.com.notmuch>
 <878r1f2jko.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <878r1f2jko.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: fe954ff9-bdf4-4cbb-57dd-08dc5d8dd757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m952VCJDnxv9xvLKM7ulwPzqNX9vv5CicAqvQCEMgbnY2rINnTUH9vMX7k5KAlDI1CFQhTftHjwJ/DK6I7xMfbklqPLZL1vuTeKSmyfpotcb4OlApJmI6EfjprY9j/y80KR53jOQkvyGoS1ZTUCRfiQoq6DpDzlYzaPAaI3j7JTbBIz55kW/QSqwRTkbl7KAHJ3xD9h4E9HumnNzRXhysyvpZeywwL85WdBAao56CraDBqMwZEwe6upqrkT5D3OjTMXJV6PRFXA0DinSbgKxOQEMYnaKK06WiULsEu7qf8ZHdjcEKQOYIJxpaBAiz0dS413UmBpQNHM0yjzzmm6cHbXo3mY4Q3EZv6HVssLY7Oz29pAjl3ViPphBSgsTPeWfTz5R2DeJgcF8dFtzV1jC3yTiKRnRm+W9vmI2RuPKyhHPQzqU/LuXdgZs939o+ONE+flpQqRjqtLisbI7p/C51DLjOpkAXsTkHqA8JlxAm+JGfXQmJqJSj0eYF6rf+TqGE8l0fx0n2RsqS+899xeDQhAGyVLgHBoDyH0Xf9r73werABlJuNzrdnHf6wCt55awlBvCV0mafEtnC/w9qg8UIUfW7c9ePk1X00v3Gn2jFNcOltWyUfCG2MMwSHJq0GP8KtAiN0ps9Vg2+eRiBeQtc0z920Ll0GVeyTYkGZNeV+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XHiiGmP+OTm5MPixlclP5AYnjK6Q5imTeixxYawG+Sysk6lfL2yVQ96ZoMBm?=
 =?us-ascii?Q?ewpOmgX9oXc7I2Ps+VERKwX6t/WEVvkItcP82TQ8LHZ+PlPjS3/gNHR3Nanh?=
 =?us-ascii?Q?BjsFm9GgCtAfmGdnIzzimlSTQZ4OBGOyKfZJlAjAQBx37zD1wJi3mo7SgPiX?=
 =?us-ascii?Q?Azo75fnJhd4mQcS1s2waKIff1SGPyPmJ+zb7SkIOVCsEz30o6R/MfwwfyXU+?=
 =?us-ascii?Q?BVt+DsR1GIGyO4W7qxQO2fBGwmXmqn3ABYg57Nr1e+1SRDPrUPIrqvlYPB1x?=
 =?us-ascii?Q?DlDBe3Mur6pHb+TGJw1yV2VOq2UlbJb54WHdVhoyunsx3qyHsOfqnw7biR1R?=
 =?us-ascii?Q?e3wP7aRpjsK7RgkQT0l85PHAtFO1gNbDyslS/yHaU0q7fDglvJh9rLINn5TN?=
 =?us-ascii?Q?pSLoKfIPxEg7rY/42R9/K5HR1mHiOv6l0V2hnuQ43u0niXHOJRssSepjcDn6?=
 =?us-ascii?Q?lu1vBTN96d5RxYT4taoXmaW5X8gc+LisVERbdITMqjAi9XKIuXKxjzuC0BBi?=
 =?us-ascii?Q?WwzNrgRNu5Dvjdn3bZUiR2F/lfFUgAnZkUynPLHG2RJVkxtHjyQG9IIcNBrX?=
 =?us-ascii?Q?x+D880B1YIi47aU+WHEXzXSpV/KoBYwrdra+OrF6jQ1tQ+b7lhTP00ZVtMJM?=
 =?us-ascii?Q?g19zsf2C9KxIgoPbalXgfOegyakCXVN/G6JEvRK7M+LPo3yVpA+enIz5PCFG?=
 =?us-ascii?Q?JX7GIPoFcMiHpjUU6vOlAC0iPJ1vpbYxLN4AvgacbrgtaZWZxaPTr7/yFXsq?=
 =?us-ascii?Q?DuGcf8uBHUs8qZ0SW12Jg3f+aMxtwozc8fwtJiUmhXjwgKsymAQJGnJ/5Ens?=
 =?us-ascii?Q?8Lmq6KSdwU/ul+YUKI6Mj7SnOFwEgV9+B/mjmrBGWGIsC7seBfl+iPyGu40u?=
 =?us-ascii?Q?AVGlWo4gu7HWEtz0x+MMalKV4mBa00v/QLgB1uW9n5e8zxuBeayK1FwPk0Bx?=
 =?us-ascii?Q?O5sHbb/G+MHBBUvHOjiYD//bnytyvAJPtHOIHo4IvIJUOYgixb9YuiK1KmzT?=
 =?us-ascii?Q?w22nCTqGA9UzoU3qANtGBP+4ONeJm63emXGcdeoF29kkDm9L9ZLQ71CP+QEc?=
 =?us-ascii?Q?1SifI2Do159qstrEiyE20+aFU8FetW5kaHTOj3Iuk38xMgsNHqF9zHx0GTeF?=
 =?us-ascii?Q?ygWCUyfJ1q61tfs5ypXtMN9BKOLDIm1jUOG+RXw3lRqOEk4vm5jGsQ666wU7?=
 =?us-ascii?Q?mrhK6wNoO97GftxKR+w3GTMAlh2y2IbmzlZpSUPyk03QtoQNN1+1u0wb6k5X?=
 =?us-ascii?Q?das9+txZJV0SEr/DC8tiD9KQnCBXr9MmgzugoTEgxD8upGRxduecNtZygcdb?=
 =?us-ascii?Q?4b1DXoial+EUzikn3g237fQjJdA6nlm6RDWvaX4wzxCl7aigl3cCqFxQ70h8?=
 =?us-ascii?Q?r2TSy1hs2+DvqWOug7VLcfu0ysxYMMXyDHb2Eic/n1kWrKrTmEYyfFT2PMl7?=
 =?us-ascii?Q?/tQWCE8x6m58eSL4fGeNSnmV7eZuVKdJenyB8UrC39K1mzLgtgogVuJEOTu4?=
 =?us-ascii?Q?hjY/p3EnYOI9sjkUgWUPAIXmSz+KToWQOsDrRVPUguydfL1ADt73vjPRi8XQ?=
 =?us-ascii?Q?loMiVnobXkiEqCtw/PY4Cdj3bGxHqMFQD5TaWRPmO/Zh7TFDnlHxJzXHVqeJ?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe954ff9-bdf4-4cbb-57dd-08dc5d8dd757
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 20:51:36.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIKl96O+i+I/7FHFYIy+aV+XSakK0jGrjFKdf2XYegzZpb0yPepIUS7CD40T3DXHIlwwbZLSlHbulGfDkiiK1eUpSFHiqxVjL28dHMQt130=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7883
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> I was initially concerned about these cases because I was wondering if
> folio subpages could ever get different mappings and the shared case
> implied they could. But it seems that's xfs specific and there is a
> separate mechanism to deal with looking up ->mapping/index for that. So
> I guess we should still be able to safely store this on the folio
> head. I will double check and update this change.
> 

I think there is path to store this information only on the folio head.
However, ugh, I think this is potentially another "head" of the
pmd_devmap() hydra.

pmd_devmap() taught the core-mm to treat dax_pmds indentically to
thp_pmds *except* for the __split_huge_pmd() case:

   5c7fb56e5e3f mm, dax: dax-pmd vs thp-pmd vs hugetlbfs-pmd

Later on pmd migration entries joined pmd_devmap() in skipping splits:

   84c3fc4e9c56 mm: thp: check pmd migration entry in common path

Unfortunately, pmd_devmap() stopped being considered for skipping
splits here:

   7f7609175ff2 mm/huge_memory: remove stale locking logic from __split_huge_pmd()

Likely __split_huge_pmd_locked() grew support for pmd migration handling
and forgot about the pmd_devmap() case.

So now Linux has been allowing FSDAX pmd splits since v5.18... but with
no reports of any issues. Likely this is benefiting from the fact that
the preconditions for splitting are rarely if ever satisfied because
FSDAX mappings are never anon, and establishing the mapping in the first
place requires a 2MB aligned file extent and that is likely never
fractured.

Same for device-dax where the fracturing *should* not be allowed, but I
will feel better with focus tests to go after mremap() cases that would
attempt to split the page.

