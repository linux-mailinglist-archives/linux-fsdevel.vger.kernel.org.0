Return-Path: <linux-fsdevel+bounces-7699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03F829878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B26282E3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4380E47F7C;
	Wed, 10 Jan 2024 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGqc9xUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4647F56;
	Wed, 10 Jan 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704885121; x=1736421121;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o8agLMDnk3QVGH6YTppZNpDyWnGpLGwzOMPAOZfccQg=;
  b=NGqc9xUQBgrFaHef5trjUR5TlbuO9JrR1H9UcYMnJPrgt7sFnE4Bgf3w
   siBYXPcxiYa1W4mlMs/5bIZuJNpnFpqRyfGX0yf+SPT0Q4/t8l7or2BTE
   HoqYua5mF7VrhxPo7mzRiwK4fv57XvpPjZ3VuseAqi6+xIHjQI0nqJjga
   MY6S0KLWZ4jdojdrc5IiTssmJInz6to/h+kz/e5UGvmsC+GaxF+nc3sFt
   2aPdunB5zy9UqjixULzuNkJUvlh7AOkw6/MekPr9y+G6/cmxPWO/7x3Q/
   q4L6q345SHDq8sbwJ72ldUYKewWIuQOg0Rw+t/lK1ZhRo+qygeLkqeeuV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11968215"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="11968215"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 03:11:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="30571594"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 03:12:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 03:12:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 03:12:00 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 03:12:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPTDHLunmKfVC6Q11iFxzlRHbpAxNtG5N2CI4AeBVKeXYrJUbLgRxYSx8DlfHrRhZl07Akr4/mh/wwW+fOQTXjEjH7SIW7kFyzC48lOPhUyN8fkJipPGT/p/D1Tn0F5EG65HEdHoN4gNbayKQ+APNcEIQsJMV1WwFdJsEi5Ux14EylYo4IU9fA7iDfYOb+A73q87+Jn+IjFQ2RhQwKO5z3aDt0jPvXOHSOXwuEGUqFn98M+/pDt7NcnbEsD5VjmeKCHM1RxJBZDaVEoqUxUhRuYIJhiJwWf+dVFeVbdGfXYV0bBYzihe+4/ixg4QENaquKTiW19dioh6qmpmA31WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO9oRQ50d5Wj/3COiNiEkvIdYO6E6J2+Om99Rj0QZ5U=;
 b=F8KyG9coHSOimrszKIEzDfZyIwLz+KdB1EBXgbpGOtauorHlsBGH8pdpQWt7nFOGPL9X9x8I24g+P3Y7a2cBwFyQL8uKRCsIiRLBPd15I/4vpieIxewNjt/GT3lOpFcnQDUIoUKAqMhH6D/lg9GssX7DNjLUBqdb1EDhJ7W3NMQFnGbQBAkteDinhzbC+rt53XsKI6k64uR+5kFK3ymlmLFDxAsU/lDGVUpkricdP+3eMhV+pJfKtcI9YTbM9ImpoQUvV86xEUG/ljfLR8k6go78UvHTT+OrdPGYuWWiBmDKDkUT+WOwzjEm9l+GaIR5yiQw7G6+Qj3UNt45DCBTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA0PR11MB4768.namprd11.prod.outlook.com (2603:10b6:806:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 11:11:58 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 11:11:58 +0000
Date: Wed, 10 Jan 2024 19:06:24 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <eadavis@qq.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Simon
 Horman" <horms@kernel.org>, Markus Suvanto <markus.suvanto@gmail.com>,
	"Jeffrey E Altman" <jaltman@auristor.com>, Marc Dionne
	<marc.dionne@auristor.com>, "Wang Lei" <wang840925@gmail.com>, Jeff Layton
	<jlayton@redhat.com>, Steve French <smfrench@gmail.com>, Jarkko Sakkinen
	<jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-afs@lists.infradead.org>,
	<keyrings@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list
 header
Message-ID: <ZZ56MMinZLrmF9Z+@xpf.sh.intel.com>
References: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com>
 <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com>
 <1843374.1703172614@warthog.procyon.org.uk>
 <20231223172858.GI201037@kernel.org>
 <2592945.1703376169@warthog.procyon.org.uk>
 <1694631.1704881668@warthog.procyon.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1694631.1704881668@warthog.procyon.org.uk>
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA0PR11MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: 408fe738-c9f7-41b7-146b-08dc11ccf63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKEhdGKNSg5Al3PPZGBB/Soz9FVVDNp8DUlQVjgQzFBNzgnPZ4bVRtC+u3RtcsMj77dx3LaW1vYeaiCwlEoSQvfgKPrKXLky2SdaSA0tNTpOTwogeOjs/VLXsbi4wMYHX36+actYnAsRcOWA+5AMIzkxQZq0sij16/oNq0YDBx9oMcY6xDhEmPj5Vq/YHbp3VfUI/bPW8FKyc1MB8xfYGjhbjUy443uVjShMmh4Hr+7SGrfO/tNdia7WaGoGkhQ3hWDHdSRqKBs0VZnk486uk4CNWml4yaQjFy9QxWFOt7D2adg8PvFSrwKJbYqOAOJQzIRISv3GoZYnAJSOP7J+cldGw3LBGahOWej48oUuBKhZDcimPEgnyyU9SAZwG5vzXCvl9h8f/3ge4RzwzM9MU1YW3e4B1vu/LMZyV05V6NmtXEpx5KMEdVZl1ocpH3Hw666o1c3/3y6SH04+kSypodD570bzVDhe0UtAxP6eJW9l9rhuIGLFNnlCCNxGK+fLu8WaQJnI20OTQiFbLSH9zPrxVor/fTJo6tVP3T+Aawv5g2pT1lKnNZKm/Tbmb4TH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66946007)(6512007)(107886003)(26005)(38100700002)(4326008)(5660300002)(53546011)(44832011)(8676002)(7416002)(2906002)(6486002)(6506007)(6666004)(478600001)(54906003)(8936002)(6916009)(66476007)(66556008)(316002)(41300700001)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pSA+tKUdo5oJOJnXYrBvGcvjoaNJVOMXP30QCjoc1BxO9G2JNJ/QHNh35Jpu?=
 =?us-ascii?Q?SB4NuCqupUjQnotm0LEQZkPilMK7poFBRzEh3i4wJmq0G5msqvbk94VbbinK?=
 =?us-ascii?Q?txRYXnkA+zrTjWr5wxmoQN+e1dEjdA+BQrm8CNGUMfZnKAuvTMYQlyU5nBC4?=
 =?us-ascii?Q?rRWbSU8tJiVATg0b2gL246E0KRKJnTfAhlwBu7V6wpd1cPetyB7//AFSAG/i?=
 =?us-ascii?Q?fg3byOdqQTMXsre7zhNCNeyqXODVIal2F1sdBVyWgWKa49CDRS7tK5KRHVbS?=
 =?us-ascii?Q?gcKGy4Ej+vwyBEZiaAUSyQY4O/a/QGqHn4TYKnG800zNsdp4DkbImWYWakQh?=
 =?us-ascii?Q?EndA6x32qokPq+6mK88YoEjFbBtkzdzycL9y+a3HSVXuXlZmBClQVrJmIg2i?=
 =?us-ascii?Q?HmWG8FejQYy7Pc5qa3gumtEGwnImphU3QPQT0obxl3jgMZPOV+0g0F4Lp1Vl?=
 =?us-ascii?Q?4HxuN/7pNoeZyzDS6WOklBf/YjcsXjtBpm0gPx3tZChDptGR5T6E2eQvqX4I?=
 =?us-ascii?Q?WTFNsvz4VrmUo+slfmH9pZ/T7xDXKOlk8HNMqVULBFBOU7p5X1nCN1eZ2WY9?=
 =?us-ascii?Q?KBBIzqN50rSZrSn3BeSCOOg8NeVcfiRiAyYRuSnCTOFLQOYCaKMyRrzhNuPc?=
 =?us-ascii?Q?WQ/WbpDmVGJTPoHivepgtiM4PdCa2xZOiMZ5Usacsg0cR8gidASXdHvZ2cnw?=
 =?us-ascii?Q?amiZOFjgP4QWHl9StXbUO3X0+S5OsSH8kT1APlenU66ETP1KT2zjzvmuqeaB?=
 =?us-ascii?Q?P08E8ONTTpPMwifgLvWpid0B4ODJSo6sD5XtMfLHJGsJPDbvJCGk5CFZVInG?=
 =?us-ascii?Q?HJWveED2jJjGq4Hr9XqcWLUq12yUm925KBCw/6Xp08tvtGRwtD/oCYVdX2wL?=
 =?us-ascii?Q?5A6zu9TxIquKktdVSdAdqKaueOcVEENnFP1luD1w2b5QHgDbOoWkUJWRmSWX?=
 =?us-ascii?Q?3iIOTbQc6cbIg+CfXnrxl+D+npZiRtKU6SkjPDIyectDsfwVkxm0jmuGYTlf?=
 =?us-ascii?Q?opIlwsoxq4fAT0xs1EPjXQujDgrWKVTvmJrRcZ47F2A5dK73FJ9Hz99xVR5U?=
 =?us-ascii?Q?o8vjjJ4Pjyj9F0knsJ9GgsQsoePCmA42kPR8pfP1F+MTrMT3GabVf874if+B?=
 =?us-ascii?Q?IdORnEaJ5IeQnEV9fALk5QoUK9OegUZgFZEL2jQjaXJtwtSoytZKyA1OVdTl?=
 =?us-ascii?Q?A3Y7EEdeTHWAZ6vA4RvrPPOJ13STNUXhUzwQ//vsg+notyx1pfeXYY8DGLPN?=
 =?us-ascii?Q?x4/30fmnEtF75wo7Yea/zdSlfR89EbJ3LHkifCX9E4SvlEkQwHxf/zhFOb+T?=
 =?us-ascii?Q?5caFAW+tbKnhyaDgUAJQnlJb38voVxOS+ELtt2+S+4aJMLosvMLECSGynLzx?=
 =?us-ascii?Q?D4fdQAZsEa72dGGME1epMYpxU9mH5/sN1yxDKcMM4OcSAoPKrizfnz2f6fx0?=
 =?us-ascii?Q?pFXoQpn+0rpU2GMkoUBjwKKzQTWY6alk+Y9OhgLzAfjy3OwU/er8M7VrKvGx?=
 =?us-ascii?Q?86eAQ/Th0l6KeirD3NT8KNvgUgm4kXoaFdtAU6j5q5QDxxfpXXCy7XJmkBqS?=
 =?us-ascii?Q?Ey53cNfFUmHszCNkZ+UxWhU3DI+FnVQpyKVh1bd/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 408fe738-c9f7-41b7-146b-08dc11ccf63f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:11:58.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwbnswRQ0J/gS+aFFvzmEg8m25qbSK7R9hN2vcD8CIVAoS2I/X+x10iNW+anHuEMCrKIaI9sJ5OSc+g/9ID+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4768
X-OriginatorOrg: intel.com

On 2024-01-10 at 10:14:28 +0000, David Howells wrote:
> Pengfei Xu <pengfei.xu@intel.com> wrote:
> 
> >   Bisected info between v6.7-rc7(keyctl05 passed) and v6.7-rc8(keyctl05 failed)
> > is in attached.
> > 
> > keyctl05 failed in add_key with type "dns_resolver" syscall step tracked
> > by strace:
> > "
> > [pid 863107] add_key("dns_resolver", "desc", "\0\0\1\377\0", 5, KEY_SPEC_SESSION_KEYRING <unfinished ...>
> > [pid 863106] <... alarm resumed>)       = 30
> > [pid 863107] <... add_key resumed>)     = -1 EINVAL (Invalid argument)
> > "
> 
> It should fail as the payload is actually invalid.  The payload specifies a
> version 1 format - and that requires a 6-byte header.  The bug the patched
> fixes is that whilst there is a length check for the basic 3-byte header,
> there was no length check for the extended v1 header.

Thanks for description!

> 
> > After increased the dns_res_payload to 7 bytes(6 bytes was still failed),
> 
> The following doesn't work for you?
> 
> 	echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p

I tried as follows, 6 bytes failed and 7 bytes passed:
"
# echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p
add_key: Invalid argument
# echo -n -e '\0\0\01\xff\0\0\0' | keyctl padd dns_resolver desc @p
74678921
# uname -r
6.7.0-rc8
"

Thanks!

> 
> David
> 

