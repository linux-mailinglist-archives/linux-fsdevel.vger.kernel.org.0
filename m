Return-Path: <linux-fsdevel+bounces-43209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5894A4F636
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 05:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63903ABD63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 04:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E91C701C;
	Wed,  5 Mar 2025 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFVfsg1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEE1A2388
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741150495; cv=fail; b=dRajNiCBSF8j2qDQTuGvf2hq1kvDwpXt6dXghML8LFx0r7UZrfVU+vElP3Ax3tr37JOlvJdPXJlPWNCzX+ExZeWCjs3vNbg1AHb5BKyQ7W2EDAxoBS5dFiDsFJJSVN7xCit1yuo6ByIumiKdUGBzbtQJQGplRqZKwlMsO9YEV9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741150495; c=relaxed/simple;
	bh=B5GU22+EjZS8U6eqFNPF17EKOpAOD6kFFU7zew3aO64=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BmoyNBweBcTkGnzzSkka7ggOJpihr2E8AqaJ/9vxYb7pEgYM31t4JP8ftywsoQsHF3C3/LZ/zZVD1DiR7Eob8WLXiiWapK2eEOgjMxkHzWYiM4EbdsNe3rs53BAIeZMCUdZeKHY/C8ckbyYyLKHg3u2bj9/pvSXCUanvhGWG2kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFVfsg1e; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741150494; x=1772686494;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B5GU22+EjZS8U6eqFNPF17EKOpAOD6kFFU7zew3aO64=;
  b=SFVfsg1elKtqfMg1tdtxsf94D06qeDUEXNIyMuCTUBdgrlBqoONC5Bq3
   D6z98YIZkXuL40IWOQkZcjgJ6fvowNKGpxb2y40QPm58aO8azRSSbhg4P
   //KeizJJRp3pXDO/5RK+Z+khfVzrXe8XvKbO2MgB56iKlmLWXraxClieu
   BF+CXxPhZuqum67mRd/fIVpJh/r6Jsi2O4dnJeZv7YroH35Hjr+Av2s98
   cr5ngSaR9y4nvoMacW/I/rg3XQsU6n1Lrae9kZ7dsidYN3c3ab3tr2n0L
   8ywq+3FPfW4XtxkIeazVqNCYSpMzZbWtHEIONuCkr0boC7qw3FdlJGLeM
   w==;
X-CSE-ConnectionGUID: S5DBjgkvRm6ZiPiPXi1iSw==
X-CSE-MsgGUID: 2YluLstgRdaNuoFj/KtVEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41953268"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="41953268"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 20:54:53 -0800
X-CSE-ConnectionGUID: Y8BmjxFvT+qHeUamq/qWng==
X-CSE-MsgGUID: S0m6Kf29TTmxd/IFJv80Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="149357118"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 20:54:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 20:54:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 20:54:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 20:54:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fr5CGbC7peWtbxnLfSUx9n+ehAOVYvzn4Tpxhyt3dEXh62YHmm1Rk83eUJS09Ap7b40ojpZjCKzn5LLFTWShezuaP3vftBuKqXy5jTx9e3PCXZyOKMb8pBMd3s/DFcVlR70xzpwW4h0lg2KJ9ywxVcK4unJwZNaOhg+h5JJ1eUekmeo5LYixJi/7ruN4eD5G0Bgr22pRMjL0itu+JKdB5uh1Xa60+sCybqeAbcy95VdX33CDJ5SI7WXS69/EBliDqKop9Yc+MPwmWjLeVljinsKP9YzOvraGYkvH8IXssaQOhAm++PJ/L9QAy7nyURC8HI/dPHUH9gQqEeqM38mIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiEmQUz1ZdTCYOn7L+EaZQg6cDlFbYHM38M698QUUgg=;
 b=ShYI/tt2m+S8WbA2BIU02L40kGjcLvMTXN1ZE9KPJvoD2zc8jYRV1PUYLITqLmNFOmBo9cCJ4qGxi2T9glkRnrkryvME2LhPzInYm7+MlyxZ6z3KN05qH0OqVaTIjtfbxWJMmVeoIRlSC1m6Div4gfAFqbMPcCiQbG6J3G/VMZa3VusCqqdQYzbcGUHhjdIEJ8aJD6uUOxqkDLcK6rQklwn0jwZDm6qyvycxyZKRFuYzuG/VQOE+SPztT5NZfJH4xVh4nUvCRBHJlgpu8ffbUf3KTEL+3NWHU0NPInmsnUoeyz9YX3Bt5sS4wAFg1u7jEbprjTWaUTIUibMklQNmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Wed, 5 Mar
 2025 04:54:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 04:54:44 +0000
Date: Wed, 5 Mar 2025 12:54:36 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [fs]  becb2cae42:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Z8fZDIYqR37n31YI@xsang-OptiPlex-9020>
References: <202503041421.38b0d0c-lkp@intel.com>
 <20250304-beiwerk-gefischt-89dcf567973b@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250304-beiwerk-gefischt-89dcf567973b@brauner>
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8bb0ea-84a3-4ea3-4458-08dd5ba1d928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x8tGjI62/PzGAKfaeYjG/uHmM2JBPPeKQJ1nTUMzvLhOXJad9yB5pwSeNaZS?=
 =?us-ascii?Q?IzCtFCKikNeTJ5JSywBYMkkZo+r2nz9yvqsq8PCG0mCY4qHdNDHKYSW+F9yY?=
 =?us-ascii?Q?mVkWvO9njnsYv3MrqP8XhrBBPSg/vu0JFWiVK3LnBrO/FSNN9MHB3ELp460w?=
 =?us-ascii?Q?yZqlNqK6H0UQV38+mdp6644UscTyVWCnFsJuCevqQ7QxKA/dACA2xuF/uoD5?=
 =?us-ascii?Q?nyVal5vXY2GAB9FjChRHgirSDME0pTLDicsfGMbc2RuElaWP5YsTGT5Krrd0?=
 =?us-ascii?Q?ibKCcSAMwag/v8zC58Fu+r3P4unDT3fv5aBLmpKlFmskaQ8uF57/58dkxvG8?=
 =?us-ascii?Q?Ai9uDYLiHFiqUF2oD0QRRc/Vdnuu7n6hHTQA61z+Jd2n+cE92QPb7zrE6Z0A?=
 =?us-ascii?Q?vz/m3As+qnFj/4XcWQ5+Cgx4P7qaK+It5ckw2uOF80+D2aqaVqAbdBvENjig?=
 =?us-ascii?Q?hRw2wyGjtmtr5FEXhtG0XlCEYGMgZ1P3qVFi8Pl0yzD7PW1x72jZ+XuHmpZJ?=
 =?us-ascii?Q?wivYs9tA3OhGiUmO3tZJKuj1hBnzrV3oz0+Pv7ITO/sIV78kztrdg3T7LAR4?=
 =?us-ascii?Q?FCiRRC8LyUro7+pwTacV0RFPytvTZ3wHhJDaUSoZ5B0V0BW0N2KKaOy8GMSk?=
 =?us-ascii?Q?tSf0wET3n+pWyvGjgIMPMDfPndDi9OFtaHJbijJjMDDJrvk8svK4FIJsZpPx?=
 =?us-ascii?Q?bAAHHT0OM4z2Dte1VLhPkTLXzSgOv/7X9a7JhboqfXSi8+9734FKCS9QZlLG?=
 =?us-ascii?Q?1shwKh2Jjc8JsKfjyDd9DssUWxOXbZosla8/ioH1QlaT8QraI1rXAVA++0DU?=
 =?us-ascii?Q?WskkJWF39Ux4rbaW0F3rp5QwvLNrdgiLCeG6e3+kqrYrRdjOT87wSUWVRA0T?=
 =?us-ascii?Q?l1P7H+anFLeEfIjkQk4KxWfsPzTSNYm7bOOmwj06gTGX9P0fKhODzQdP4UgG?=
 =?us-ascii?Q?8UwrrWkxxq/MEeV31IzwnXvCWQZCYUb9UnccCOOVS2DNbOttqPF7T35sfUDw?=
 =?us-ascii?Q?MiL8mXNv+BygyUeM338qqHWC78JyM/9NwhCRtZrrzGxV6XVKCMKU5+MKY1HA?=
 =?us-ascii?Q?0kWlXYlO45SHEc7jlIEzxICvJvuCvDQ6ncbGmnN798rwKx2RXHtLj2TmgJZQ?=
 =?us-ascii?Q?ZRI1hczDpB7CVluDfxQuVdfA0Z5SQCnMP4q1bfQXHgMhoVOR0Fq88U80m9JX?=
 =?us-ascii?Q?oXCJmcvFAaL7k9ClpOXFiE6yc7YZPmgIpUvqZdkFDkrtOo8RJCyfvJ34sNGB?=
 =?us-ascii?Q?9wpN8gJGWoQln+L0GV87PdDxZOJQEUcbt7HJC+nyRV8ygwkSQjhiwDj9+7P2?=
 =?us-ascii?Q?yZecYTitGc7f5HQ9+AYiYHGp22gYTaTog+PoA4EUfMuAlbV4DJclTu5SbLuz?=
 =?us-ascii?Q?4LEZ22pVBeqh0MUeBOwBr2FCrzB/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JBKp+p9uV846xz2QDUYKGcwvkQHSP2I1YtUgrgU2AAPNbul6FCFsN8f2iOy6?=
 =?us-ascii?Q?Qs+C7tADbnirIoWTAVjxnDhl6brTKS7AY898DJwCNOZHOZxDc7Se5NUeYFCC?=
 =?us-ascii?Q?CjJ9dGYE4Zu9GOdbmpTNzCugUE/G5cwjABfiZ7WOXl4fT6C9k9NZS7jOjHcz?=
 =?us-ascii?Q?TdoiJOi+obnLcHqLb1zH2DV3J/PS7J66k4RtZzy+uxRJYC8QG3FDjbgqI66P?=
 =?us-ascii?Q?VQQIgakQMaFfiIEWfURWdg8rTvWbOF4JyGAMy3z5Vs5hsZSsVTO9nejj7VWi?=
 =?us-ascii?Q?560uDIakGhXc6+lomxTDwqrl0IntaLsrO7XzLlXi/QJY8hkBi8pJm8A74z3u?=
 =?us-ascii?Q?fSTDQPLQqQ+YY8cyVe1iveQDABVycUAEPPEhjHYp0oO1AEWrL4A5zo5+1Y0P?=
 =?us-ascii?Q?sas34rWOx/dKHnnzi1hElzYhhUBpwNL4uZAObYkR096shynRNhvJw5hwW+A5?=
 =?us-ascii?Q?NkOHs/VPNhzp2aEXptp5UMdmCeD8NBER7MlwMR/5sFOkE8Vor/2Rm16ulwwy?=
 =?us-ascii?Q?k1Rr3Uwon7xTmGPjXGVwed+tcm9e3jpifrTqXDN0PSfBwPfciyo6VAeHKbhi?=
 =?us-ascii?Q?3fnm+Xx8QqvH6MRNeqR1w/0y8TAVXVDC9xTP17RokqEgz0QEfIX7J4c1NZY8?=
 =?us-ascii?Q?Pf6fhJftEOgBo+7QB7JijCf4lyVssWp8gvA3Dk1tq90jSCePy2JXIFoxucQj?=
 =?us-ascii?Q?0DUqszS8oDUMBc80uIpYTfsktj6AONnHzK+PRELWK/teKQYmPzrkjCKSMRwO?=
 =?us-ascii?Q?fZLFj522zZkKOGeFgi6ATZHZZ7LjMEngQdWuF3LccjTyuk1K8Z8t2NPuaSvi?=
 =?us-ascii?Q?evxVoOEjyHQh3kETSmRLT60VtuJMr2X4E6/3yHLQAlf+SCoxdcK2B24lYZPU?=
 =?us-ascii?Q?2h6yqy0YquS/CrYxGk54EN7kyLb/EwVUJcT3AhQZqYq2+ZB2DzzNhhmeZY6H?=
 =?us-ascii?Q?9gFEHuqRPRJNIV+viNfMG65Mph+aTHF7UDA6JeWbZ8ohsdarJ0Wf1jnFyYq+?=
 =?us-ascii?Q?qOA/SzXN3illASN/01aXwmzRyaLyGwkJGEGr3YIqM+rp2B1+MnSZn8Y3z8og?=
 =?us-ascii?Q?HD6pWD0URXKfi5I8aEl0Mpmi077vZh5Rbs9tj3zYR7HNUqEk7Po7ODR+pI06?=
 =?us-ascii?Q?ev55o/za1QGKbfvGtqYqy+xcSVh8IDOpCKgv5bIIh1OLmxrEh7YyI6AJVCnO?=
 =?us-ascii?Q?cdF39oK5N8OqnpU5VCOv/fiVWV7ypAL+X+B+4tuLrMwndopnRZuHNS3S7QYE?=
 =?us-ascii?Q?xeocyQMW3r3uy1eb0i08A1xPgOvX4jDTt6sBBh1o6kmC64iQvObaPf5BsvDt?=
 =?us-ascii?Q?HqItHQs8VgaofeBrNXcD4QH3dIF/xDnCyXC/RMgEQgL8mRUGm0/l2RrZs7F+?=
 =?us-ascii?Q?bBa5BjGJRP7MtSFi12kd4TfY3fSSuUX3IpCJGxOY956mU8Nz3Hk+SsJOujgs?=
 =?us-ascii?Q?5xIMoklFvhrxrMhUtTSmKRQ8UTE19HHouDb/EWjDgQcgT8xX+dp9ax7+kgpQ?=
 =?us-ascii?Q?DsJnKr/XkcSHl5RfR00o6tipPwByOq892u79pECvP1T1tWMAmK4E7AIz+Xyn?=
 =?us-ascii?Q?xPoABk7sgxowJ2x7Pyy5Ak/zFlZbEdV/32IPhlzGRVHaeQXr6x96Hk5cZ6Kx?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8bb0ea-84a3-4ea3-4458-08dd5ba1d928
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:54:44.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz2p5Xwoa0F9DQNg+qk786mHV03iAKyIfO9+yAYGkVcob/4PYEbkgBVwOmIMMMD5scxJ4oC7x/+x3MO9KtA7IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com

hi, Christian,

On Tue, Mar 04, 2025 at 09:32:25AM +0100, Christian Brauner wrote:
> On Tue, Mar 04, 2025 at 02:14:55PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > 
> > commit: becb2cae42ea9092ad4fca06c85328e1f7f7312b ("fs: record sequence number of origin mount namespace")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> Should now be fixed, thanks!

you are welcome :) thanks for information!


