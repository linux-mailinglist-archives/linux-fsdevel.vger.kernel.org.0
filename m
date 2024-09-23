Return-Path: <linux-fsdevel+bounces-29825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A7B97E710
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E59B2090E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1562A02;
	Mon, 23 Sep 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaUtQCP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A6BE5E;
	Mon, 23 Sep 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078528; cv=fail; b=h3Cj5tAeLnUxnK+diiMmpbBaeMFZmRHapPxnAXEYWvXULl71FjbTuZ8IFa55pQ6ATIeUf1Ceyy8jtrgNDK90WGJU/IBXyhJiWuLku1v/WpEKIYi8qJempVavRtQu4a/sd7Y5VCSa/hDz8S0hZKsxW+rEdvfX+UiQS35rnXnYLkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078528; c=relaxed/simple;
	bh=qM6Ox095xbS48f9xv/x5Eul1154oZYWdpoau+vYEYjQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iLJB/HxU13PTUs1tVE1TviwgNy5sMhWFD6sq0VvUeQh8pDn6YcbqP5F/MB5Z3mRpnI74VROL5tBoDP6VmyqpfyU5m1dIa5gzB+VupHT+/ABuK29paDhl4SJldMoAk/UtetEt5kHgmMepA/f0n59BDT0v7WI2WDU59gN69uE9Gus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaUtQCP4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727078526; x=1758614526;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qM6Ox095xbS48f9xv/x5Eul1154oZYWdpoau+vYEYjQ=;
  b=iaUtQCP4xs+1gEBiAS3iaz7LfY9ZNYmxtBrtNBsu+cVn+rIaiQmROT+C
   m5JpkaV2mKryPu0aC+NnLcCk+zeY4Kksq0pi1J39ODdbHc6XUTV/09lwE
   Tk+U8oxa7T3rPBnMzp7QPAxvoBdNMBBlpLoecZMB/bEQ4Pl5mqzvteUuR
   tjWOhTHJ3VL/5lhFt4tW0Jo2lsEZTpbfn37qTpeElXAh/GKgztGAl4wu5
   YVH3Dtpz6+kz+2KhqGl5Ib2QaVMh9iB/xOQ3jOHp2NyIuBgEwgA8TMTSd
   ltPQ0UXuXRRV65kEUNmfVdGVWTXQBoSGQFPF7Zj6UuHv+mXq4AksABI1o
   A==;
X-CSE-ConnectionGUID: w4zhnwmzTz2XhsuwtXUO5A==
X-CSE-MsgGUID: deLjV9ROT4SewmXNH56gcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="37148944"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="37148944"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:02:05 -0700
X-CSE-ConnectionGUID: LHyDlwcyQIueRUM9oF7QnA==
X-CSE-MsgGUID: 87SRjGBzRnmB7hspxx6SLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="75937129"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 01:02:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 01:02:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 01:02:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 01:02:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 01:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvVXUKkXRyuLSMf6RF37ImLIzN2NBc7SvtOXqEBHyAgdpimtk0X13CTcGL9nFHcmWJidC+ACfLNSYoquZdVIwBpbkGP3Re1pYw5yF6MJQUVXcON1Fzsyi5lou4VmgTFgj4pqGamGasD/Km/554vH3DMw6BR4C0ti3pwu7WMIBGNfxR4baaZtD2N/TAgNOqYXfBS9IdkOg3PVzO8ob7o6z/nL09ZwwTzTf0JUiKOrgSpw5PS8jG2oqgdmevyVTfmDgaf1LO1P0BCuTWLHKYAWDa8b6vcxcQcDu7M7OUAK9mvVSnmzNeE1yDOOJ585ouZ0JElI3pvyP9Ng7o3EblAx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t3cMytmC3fanzEciag9l3qMG8p6Vb2+68zAJ0WsSUI=;
 b=gKwxE1wq++2B+X3sdOeBjQTmS4akImoy7TetKyyu2dOz8P0t4jumKYZqixSRKeCk+3W5O2g5cSxWJS5yUokMrvM3jCt7uV4CsVp405JwJHLJsLewP5olWhSs55tgFXjb8v4EQhdikNOyJuWY+qEWOyziov8sdHUDfINvJrcR3iJbRWavuoS3o5Vn7MVWCjG45eEbbgcsARhg6Q4RZPzxTLrb7uvA7ieVtCaLPRgsjudsOVpu9TEJk/7q5TtJ+eJEgLrgQoAw/6CRjRDPgsLNaQcsSFmYlCZ+N9pDA1H1jwda9xnTXBEZwlCCe4lU97OIettVpNXbd1qI7TLq53jyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:02:00 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:01:59 +0000
Date: Mon, 23 Sep 2024 16:01:47 +0800
From: Chao Gao <chao.gao@intel.com>
To: Shivank Garg <shivankg@amd.com>
CC: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>, <acme@redhat.com>, <namhyung@kernel.org>,
	<mpe@ellerman.id.au>, <isaku.yamahata@intel.com>, <joel@jms.id.au>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <bharata@amd.com>, <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
Subject: Re: [RFC PATCH V2 1/3] KVM: guest_memfd: Extend creation API to
 support NUMA mempolicy
Message-ID: <ZvEga7srKhympQBt@intel.com>
References: <20240919094438.10987-1-shivankg@amd.com>
 <20240919094438.10987-2-shivankg@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240919094438.10987-2-shivankg@amd.com>
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CH3PR11MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1cae5a-8869-4146-b906-08dcdba60021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lPVJTxoyd9uIHALKEEBxvSFc1hdjnwUctkgW/l3iAu88ZXCkk6Y9hTajudln?=
 =?us-ascii?Q?sUl8R67tzHabmAdqszavoGyqom0cXcRPvJTvSAjlMU2tw27CUpD+0o8GZjXX?=
 =?us-ascii?Q?V0NXwxFh1bmyzSV07VPHXRnF1FgiUPBphQoRAfaGH2oXd9sEPj5wgpHeV/IM?=
 =?us-ascii?Q?jjmvrv/CHOObOkx3IGado/8uiLjXyO3uISAceRIucVmH3OAn1/EcfHhJ4rDu?=
 =?us-ascii?Q?oXLE2YFgugu+sCaiT3v1I58Pk7NWVhHsNNduXIZaxcLNwob5ZVUPmTf/r8wd?=
 =?us-ascii?Q?b5QGEytTPRLt2R13HPShKvQTsuwxZPQZqz+a0m4K+/CFXPzX+wSeTu/8yBxW?=
 =?us-ascii?Q?QCwJRFf2B/FKJRzN6MdQtuM52QZMTc3/vGqMlKnRukWBZYo3oTdwxPV7he2K?=
 =?us-ascii?Q?xGJBVHlEs52841tNPeDbZIi+sBgLyjI+grAq4JvQyf40YuzIING1D05ZaoH5?=
 =?us-ascii?Q?9St6oGvnJjbAzqy/pErNT86e//mlG8oxodu1TrSdd6Y0heNLFmbvSEULx1z3?=
 =?us-ascii?Q?+QuaDH9h+ZVUejwut6PCpT59W3uy9tVGmBX8IQe2uS3juxAtdDDQ+5WVCJ8a?=
 =?us-ascii?Q?YYr0SQhqhc00ssN4ssaVfjUAg84UOP+w3o5XURmphRhQ5IBFRfwDQB8E3vVr?=
 =?us-ascii?Q?zi7O3YTkJ5xRVyXQqG/MklBeg6WoIOwaXBmVgt5B/3j4RbbsYb486kM+l7Q9?=
 =?us-ascii?Q?9cg+XZhfpY+6+ZR6Ebr+ugA6ct2Hj+H2mSZDs+7WLZeXzB5ABL6oYnlIaXgL?=
 =?us-ascii?Q?3lAIiBIirnSCYXP479Ky/OsC+PQw3uAY6bMN8I0M9IZ4fOwSQTuB1v8qM4Bk?=
 =?us-ascii?Q?oFbWaAxb9oMIFMv3iaYxgq6LELLyyXdVK7W46m0+ow1MozzmolyMTuGShMFX?=
 =?us-ascii?Q?4yZtE90ICfZts+QyUVHxi6KTaFqrpWCGUV6E9Hd3USWfTevXz+RrK7s1MJuI?=
 =?us-ascii?Q?sp0UKsmkGIcBbwmorGJDyOft/YwKA3F0HLXVA8NVPP4ZAam/DZt/ZGYRnAP4?=
 =?us-ascii?Q?1V8YGdbjbnStW2vOFK7yOPFak4pf9/BiUYfcg3hfAXrZ9X1KCQZSVwYkSSV5?=
 =?us-ascii?Q?1OMlMXiOLfnkAq3HE+eZG9ol7cDsfh3va1zFfWiVcTe1UkDSl/bxM8RPsOgb?=
 =?us-ascii?Q?J0rdcrTh8rgchwEC3eGOdnPDrnrbUYuIeWnapWhmWknnIGHSPAZzfKETM/Sg?=
 =?us-ascii?Q?h1i+P9nUNtB43gk2GU3NSTDSoeGhWaK11UxUV8fnZPjpYJtIR58WEtX0xk+n?=
 =?us-ascii?Q?SkK6yNZeR1a/jTtMdAqH1iJhdDWhgCn+abScSymVbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CzJUjXOePmAR3MG2G5CP7YHzBTMvTWx1RaP5MiQadf8UXS+XrW2AKF0xaBj4?=
 =?us-ascii?Q?qKfxIRiy/9Q2vDgzsJvEDORkCnLhhGPdpfLDmMh1KOSAn61hi0G4Jy4K+yNK?=
 =?us-ascii?Q?GK1yI2/iSI9UbuRmEodRsRybmYQP6Y8lMDVAW5UND5MP4AC0SBsWg+WGzsnR?=
 =?us-ascii?Q?WnYxw+cKUB+JIdtX9OpwNRW8toecCP0heFs70okgVoK6+n1U8FW+lc1E9pat?=
 =?us-ascii?Q?wKRnTEqEKC+38gs8jdKM6VhJQwMb0a9qKzguFnaAC3ch/1K7PPFNfcLemLrF?=
 =?us-ascii?Q?gW3UmCwdoEj+FDAaahkhvEiN4Bt5zM0eRlWPYlCEmQ3pP6bXUK9Pp+WbqJZ1?=
 =?us-ascii?Q?RbQznCVvcD0k0yX0zdtXjGeaeRr6SetiaruMM65srRJdyaipWcz7n0H4cwkm?=
 =?us-ascii?Q?qNAi3eBUmRct8IzxUKlU5jJkgCw8PHnUpr14NVHnchmoUoQjMUkSYEb9r3/b?=
 =?us-ascii?Q?SGgMFy/aV8VVmvpk5oSrMvQEjz88tEBrqUkfcMeqhmvVFBk0L9i+5wY6Lxyy?=
 =?us-ascii?Q?oJoof8Oiumz417oK+5gytVFHfLQ2cbPL66rw45mmmgES4b6fwweTKX9poGho?=
 =?us-ascii?Q?5/z8BGgOdJ8XfEFDeHL6U81U/fmjjuk+4ZQ/b/KeerdBUTFd0vA4WjlIN6SR?=
 =?us-ascii?Q?oF9YMvhSdI/iXfX0t4axL1sqlLX4dLvsut/qzoP6r/oxEYXQgidfTrqBnHMh?=
 =?us-ascii?Q?ELcSn4bEJUvWVTJ9WRBKROhJnpOwIvY4OYuIb6U5YZMi98AoVOMPijSH+eYj?=
 =?us-ascii?Q?xt2arq3mN+t0bsTMIVa5qlq/9P+e3NDyafl6WjKCpjJoV5uDe45haLuUxiQx?=
 =?us-ascii?Q?Cr3j/1r7ONbTEgRn/a9Wa4Uu3SgEiW5qcNBRXtvOLOSc4aQz8Ck7nF1KLB/G?=
 =?us-ascii?Q?hfSChy8IAO05kjPWn+FYMDWFfTmn0uYkHpY64iQZuLCFFH+F7JvCBboLg08M?=
 =?us-ascii?Q?ymCXb/delt2cKkhSsbkY752j4Pi4RzgJDdKSAS9vVoINjD3vlfoorGUJpY9C?=
 =?us-ascii?Q?A4QqSFPl+oWkctnORL84OKtt2+RebAn/M/8sQN5XP3UefUDOpU8P4QB9XYOx?=
 =?us-ascii?Q?z1FU9rOFJyVFHqs0YFBi0CfXoTyhIbBC97hPaDBSf6FV0LLuD78iqKSoLtYM?=
 =?us-ascii?Q?DbwIYzwOPoG7gdg2fjz+7NHGknjBtVnlVW23xqO5RKS17kAH03F8JXcM6leM?=
 =?us-ascii?Q?BgtL5sL42hjQUEB1qrzQgBZ8jR5w6ewRCJEkRi8Qm2FkxarS+Rqz/tsf82ns?=
 =?us-ascii?Q?MjCTJips7cRh1sUplwVeSpEGVH2ZJSDNbPTedH6O89yKwpN6UHGk9ZZki9Bk?=
 =?us-ascii?Q?wWyW4lnS5SoMWQKyNf6uDfjr4XmtBLsSWi6Z0sgiVSdjgE4uLHa1OHtRAith?=
 =?us-ascii?Q?AFMEzlQIrTz0UwmkNOlXn7hCMQJP6DBpLt0RgkSq1OQak0bhihPVLK7Bplmy?=
 =?us-ascii?Q?Bsk3DG63OBl2b52GVl8wMdYFiI30cbnlAzIUQYQHJVlSqL6hsZoDfrAsG7nC?=
 =?us-ascii?Q?ke4gZ9707aEJA/cW6U9dfPIXiEWbTWe4eJ5orX0ef24coIBWMg5s17fL7pCP?=
 =?us-ascii?Q?cFn80HqI/0E/q2xeZQCiDYKzIDtU3sSQy//ETxS2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1cae5a-8869-4146-b906-08dcdba60021
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:01:59.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jc+V/inll2JiDbpdInP5UTF4QlkxH10WsBhUaxjULNrGzdg2MQ3wwJ+Y+wgiO0f9muJnCYYgMn11/ayPtxnxeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
X-OriginatorOrg: intel.com

On Thu, Sep 19, 2024 at 09:44:36AM +0000, Shivank Garg wrote:
>From: Shivansh Dhiman <shivansh.dhiman@amd.com>
>
>Extend the API of creating guest-memfd to introduce proper NUMA support,
>allowing VMM to set memory policies effectively. The memory policy defines
>from which node memory is allocated.
>
>The current implementation of KVM guest-memfd does not honor the settings
>provided by VMM. While mbind() can be used for NUMA policy support in
>userspace applications, it is not functional for guest-memfd as the memory
>is not mapped to userspace.
>
>Currently, SEV-SNP guest use guest-memfd as a memory backend and would
>benefit from NUMA support. It enables fine-grained control over memory
>allocation, optimizing performance for specific workload requirements.
>
>To apply memory policy on a guest-memfd, extend the KVM_CREATE_GUEST_MEMFD
>IOCTL with additional fields related to mempolicy.
>- mpol_mode represents the policy mode (default, bind, interleave, or
>  preferred).
>- host_nodes_addr denotes the userspace address of the nodemask, a bit
>  mask of nodes containing up to maxnode bits.
>- First bit of flags must be set to use mempolicy.

Do you need a way for the userspace to enumerate supported flags?

The direction was to implement a fbind() syscall [1]. I am not sure if it has
changed. What are the benefits of this proposal compared to the fbind() syscall?

I believe one limitation of this proposal is that the policy must be set during
the creation of the guest-memfd. i.e., the policy cannot be changed at runtime.
is it a practical problem?

[1]: https://lore.kernel.org/kvm/ZOjpIL0SFH+E3Dj4@google.com/

>
>Store the mempolicy struct in i_private_data of the memfd's inode, which
>is currently unused in the context of guest-memfd.
>
>Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>Signed-off-by: Shivank Garg <shivankg@amd.com>
>---
> Documentation/virt/kvm/api.rst | 13 ++++++++-
> include/linux/mempolicy.h      |  4 +++
> include/uapi/linux/kvm.h       |  5 +++-
> mm/mempolicy.c                 | 52 ++++++++++++++++++++++++++++++++++
> tools/include/uapi/linux/kvm.h |  5 +++-
> virt/kvm/guest_memfd.c         | 21 ++++++++++++--
> virt/kvm/kvm_mm.h              |  3 ++
> 7 files changed, 97 insertions(+), 6 deletions(-)
>
>diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>index b3be87489108..dcb61282c773 100644
>--- a/Documentation/virt/kvm/api.rst
>+++ b/Documentation/virt/kvm/api.rst
>@@ -6346,7 +6346,10 @@ and cannot be resized  (guest_memfd files do however support PUNCH_HOLE).
>   struct kvm_create_guest_memfd {
> 	__u64 size;
> 	__u64 flags;
>-	__u64 reserved[6];
>+	__u64 host_nodes_addr;
>+	__u16 maxnode;
>+	__u8 mpol_mode;
>+	__u8 reserved[37];
>   };
> 
> Conceptually, the inode backing a guest_memfd file represents physical memory,
>@@ -6367,6 +6370,14 @@ a single guest_memfd file, but the bound ranges must not overlap).
> 
> See KVM_SET_USER_MEMORY_REGION2 for additional details.
> 
>+NUMA memory policy support for KVM guest_memfd allows the host to specify
>+memory allocation behavior for guest NUMA nodes, similar to mbind(). If
>+KVM_GUEST_MEMFD_NUMA_ENABLE flag is set, memory allocations from the guest
>+will use the specified policy and host-nodes for physical memory.
>+- mpol_mode refers to the policy mode: default, preferred, bind, interleave, or
>+  preferred.
>+- host_nodes_addr points to bitmask of nodes containing up to maxnode bits.
>+
> 4.143 KVM_PRE_FAULT_MEMORY
> ---------------------------
> 
>diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
>index 1add16f21612..468eeda2ec2f 100644
>--- a/include/linux/mempolicy.h
>+++ b/include/linux/mempolicy.h
>@@ -299,4 +299,8 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
> }
> 
> #endif /* CONFIG_NUMA */
>+
>+struct mempolicy *create_mpol_from_args(unsigned char mode,
>+					const unsigned long __user *nmask,
>+					unsigned short maxnode);
> #endif
>diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>index 637efc055145..fda6cbef0a1d 100644
>--- a/include/uapi/linux/kvm.h
>+++ b/include/uapi/linux/kvm.h
>@@ -1561,7 +1561,10 @@ struct kvm_memory_attributes {
> struct kvm_create_guest_memfd {
> 	__u64 size;
> 	__u64 flags;
>-	__u64 reserved[6];
>+	__u64 host_nodes_addr;
>+	__u16 maxnode;
>+	__u8 mpol_mode;
>+	__u8 reserved[37];
> };
> 
> #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
>diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>index b858e22b259d..9e9450433fcc 100644
>--- a/mm/mempolicy.c
>+++ b/mm/mempolicy.c
>@@ -3557,3 +3557,55 @@ static int __init mempolicy_sysfs_init(void)
> 
> late_initcall(mempolicy_sysfs_init);
> #endif /* CONFIG_SYSFS */
>+
>+#ifdef CONFIG_KVM_PRIVATE_MEM
>+/**
>+ * create_mpol_from_args - create a mempolicy structure from args
>+ * @mode:  NUMA memory policy mode
>+ * @nmask:  bitmask of NUMA nodes
>+ * @maxnode:  number of bits in the nodes bitmask
>+ *
>+ * Create a mempolicy from given nodemask and memory policy such as
>+ * default, preferred, interleave or bind.
>+ *
>+ * Return: error encoded in a pointer or memory policy on success.
>+ */
>+struct mempolicy *create_mpol_from_args(unsigned char mode,
>+					const unsigned long __user *nmask,
>+					unsigned short maxnode)
>+{
>+	struct mm_struct *mm = current->mm;
>+	unsigned short mode_flags;
>+	struct mempolicy *mpol;
>+	nodemask_t nodes;
>+	int lmode = mode;
>+	int err = -ENOMEM;
>+
>+	err = sanitize_mpol_flags(&lmode, &mode_flags);
>+	if (err)
>+		return ERR_PTR(err);
>+
>+	err = get_nodes(&nodes, nmask, maxnode);
>+	if (err)
>+		return ERR_PTR(err);
>+
>+	mpol = mpol_new(mode, mode_flags, &nodes);
>+	if (IS_ERR_OR_NULL(mpol))
>+		return mpol;
>+
>+	NODEMASK_SCRATCH(scratch);
>+	if (!scratch)
>+		return ERR_PTR(-ENOMEM);
>+
>+	mmap_write_lock(mm);
>+	err = mpol_set_nodemask(mpol, &nodes, scratch);
>+	mmap_write_unlock(mm);
>+	NODEMASK_SCRATCH_FREE(scratch);
>+
>+	if (err)
>+		return ERR_PTR(err);
>+
>+	return mpol;
>+}
>+EXPORT_SYMBOL(create_mpol_from_args);
>+#endif
>diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
>index e5af8c692dc0..e3effcd1e358 100644
>--- a/tools/include/uapi/linux/kvm.h
>+++ b/tools/include/uapi/linux/kvm.h
>@@ -1546,7 +1546,10 @@ struct kvm_memory_attributes {
> struct kvm_create_guest_memfd {
> 	__u64 size;
> 	__u64 flags;
>-	__u64 reserved[6];
>+	__u64 host_nodes_addr;
>+	__u16 maxnode;
>+	__u8 mpol_mode;
>+	__u8 reserved[37];
> };
> 
> #define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
>diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>index e930014b4bdc..8f1877be4976 100644
>--- a/virt/kvm/guest_memfd.c
>+++ b/virt/kvm/guest_memfd.c
>@@ -4,6 +4,7 @@
> #include <linux/kvm_host.h>
> #include <linux/pagemap.h>
> #include <linux/anon_inodes.h>
>+#include <linux/mempolicy.h>
> 
> #include "kvm_mm.h"
> 
>@@ -445,7 +446,8 @@ static const struct inode_operations kvm_gmem_iops = {
> 	.setattr	= kvm_gmem_setattr,
> };
> 
>-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
>+			     struct mempolicy *pol)
> {
> 	const char *anon_name = "[kvm-gmem]";
> 	struct kvm_gmem *gmem;
>@@ -478,6 +480,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
> 	inode->i_private = (void *)(unsigned long)flags;
> 	inode->i_op = &kvm_gmem_iops;
> 	inode->i_mapping->a_ops = &kvm_gmem_aops;
>+	inode->i_mapping->i_private_data = (void *)pol;
> 	inode->i_mode |= S_IFREG;
> 	inode->i_size = size;
> 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>@@ -505,7 +508,8 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> {
> 	loff_t size = args->size;
> 	u64 flags = args->flags;
>-	u64 valid_flags = 0;
>+	u64 valid_flags = GUEST_MEMFD_NUMA_ENABLE;
>+	struct mempolicy *mpol = NULL;
> 
> 	if (flags & ~valid_flags)
> 		return -EINVAL;
>@@ -513,7 +517,18 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> 	if (size <= 0 || !PAGE_ALIGNED(size))
> 		return -EINVAL;
> 
>-	return __kvm_gmem_create(kvm, size, flags);
>+	if (flags & GUEST_MEMFD_NUMA_ENABLE) {
>+		unsigned char mode = args->mpol_mode;
>+		unsigned short maxnode = args->maxnode;
>+		const unsigned long __user *user_nmask =
>+				(const unsigned long *)args->host_nodes_addr;
>+
>+		mpol = create_mpol_from_args(mode, user_nmask, maxnode);
>+		if (IS_ERR_OR_NULL(mpol))
>+			return PTR_ERR(mpol);
>+	}
>+
>+	return __kvm_gmem_create(kvm, size, flags, mpol);
> }
> 
> int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
>index 715f19669d01..3dd8495ae03d 100644
>--- a/virt/kvm/kvm_mm.h
>+++ b/virt/kvm/kvm_mm.h
>@@ -36,6 +36,9 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
> #endif /* HAVE_KVM_PFNCACHE */
> 
> #ifdef CONFIG_KVM_PRIVATE_MEM
>+/* Flag to check NUMA policy while creating KVM guest-memfd. */
>+#define GUEST_MEMFD_NUMA_ENABLE BIT_ULL(0)
>+
> void kvm_gmem_init(struct module *module);
> int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
> int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>-- 
>2.34.1
>
>

