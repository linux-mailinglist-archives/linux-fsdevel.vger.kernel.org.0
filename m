Return-Path: <linux-fsdevel+bounces-41116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDDAA2B285
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC13A9454
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE311ACECE;
	Thu,  6 Feb 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRqCAyNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1367239571;
	Thu,  6 Feb 2025 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871118; cv=fail; b=ZFtfD7/X9XYOQHFCBLQAg6kYDr4fYQ39EpUJOH4htYlY8+doBHnPEtsaeyUEMutcwFvChZNt/62lpqjam+pl/ETT9nzKjS/EDyI0rQHH530cDsQLAI9tru6jTlH3Be7ikfVIlP+xHnhZLCPTO3Ky2LehO9iOS2s6jd/q8PxtL14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871118; c=relaxed/simple;
	bh=TAUR8CITq0NWvA+Vq2453t9DVtds67bY33qC7or/0lg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfT1eI2pnwfMQn4o/ErEz3D7/u89xARO4qmnnwGuzcJbFUx5/c0fjNF7MWnE/RJwDwuHb4qe1V3fOjCHveP+dtVq8moKcyplsvb6eOYMXdLwOxUMfGSaClFjkE256BEGj4/2HmbtA/hTlAHTS5ml3LPLUDjcGk5ehqkBQwI0RLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRqCAyNq; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738871117; x=1770407117;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TAUR8CITq0NWvA+Vq2453t9DVtds67bY33qC7or/0lg=;
  b=TRqCAyNqy0TlWbUO1ME0MdxQOD7dz4foN30k+doL+kp7Y0KRtyDQdlMS
   btPgl3Q/1y15ldgUKZJl/TJWVGXLK84LAbU8GJrOEXIKYumcKsuKcvAwr
   gHmXG5kL62t+c7JE5rBxAbaAgs0RTmCW45zxtFAmmIOjMcmKHK5KplAjN
   tXhCPnvp8bOzTfhe2pxprDpL+KN/DW0/2Z5KOt/kTGB4xfg+qnBRoNzph
   yNHR6dlVKTDh7UXXLkfEqkxMrMb3mFf3y5m1FFuCPm0Yi/tD9xIoYxxJm
   Xj51Cd+pXG903yxznXVy2gkeH7Hl7SClIwWT7WYUhhE/6PdxztRZaMsnJ
   A==;
X-CSE-ConnectionGUID: qM+9NLOYRbudqQHSibk8Ng==
X-CSE-MsgGUID: qj7zr5FORPWWn3NC5yWuDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="27102702"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="27102702"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:45:11 -0800
X-CSE-ConnectionGUID: YAnxC5dXSrKvEgKnxmSoMg==
X-CSE-MsgGUID: KRxVrKbOQqixdWOvzFRQ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116251149"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 11:45:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 11:45:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 11:45:10 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 11:45:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2DOzGIHdghmUsxH+PouHxCntA7oJT8+7+DzkFEuhJKl0pXZMaMbIfOIPNNNBd/q0rruVmXVJTC9XEaSMABKGnPe49z7nlW0PVRC+t+ObibXaZc7CfUhQeFx5prGqjssqhQXneo8r7S4q0lBL4+GaX+A2Tp58W9FerWvUPaEwoU5aF1gVHZS6S/FyYQ8feASoMSQPSnMUUnVX4bANLl0F6IKsSFL9QpGokimMaQH9dtlydVMs0izBmYRRj9us5xu4yqbEOes22IdGfJpx/E8m28m6PjLrVbGFwV0P0kU/nFAidLWhXtIy0wA4mY+9GRTjljQN8o6V/LdYhomOR8rFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMJ1sNLL9WXBsJJGrMJJvJq50hmSatgcU29inNdcEj4=;
 b=PiLM/sBu2cY38bpUaNCoEE3c5ypRqXKGZGp2oYQYM2lIqdx1BqrfhKG6J2TJNWHToY3+Ow1urRfwa4gtBs+BMRwIx1pQaYQkxEf8f0UNOP+LSq3BuIdwejNqtY7L1IECfzQ4KAoljzu6lB0VfT3RvKGUR/8Sto4FqqyAvUhryNYtTzBJDRRoCGhzveYsiWgaXPhJpi49EobjBozM0yS66nK1zJy5t2dbciEzG3IPEzKXu1qKxe3f15jSbMMO43u/OoRjF2A2GWGjf+lDMlnF7bWKzUqa4BgqI95vZKpV21gBKbvasa12YPPHe7tywQmhuznRaBP4X/zQl5CeEhBOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8130.namprd11.prod.outlook.com (2603:10b6:8:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 19:44:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 19:44:31 +0000
Date: Thu, 6 Feb 2025 11:44:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Asahi Lina <lina@asahilina.net>, Dan Williams <dan.j.williams@intel.com>,
	Vivek Goyal <vgoyal@redhat.com>, Alistair Popple <apopple@nvidia.com>
CC: <akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>, <alison.schofield@intel.com>, <zhang.lyra@gmail.com>,
	<gerald.schaefer@linux.ibm.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <logang@deltatee.com>, <bhelgaas@google.com>,
	<jack@suse.cz>, <jgg@ziepe.ca>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <willy@infradead.org>, <djwong@kernel.org>,
	<tytso@mit.edu>, <linmiaohe@huawei.com>, <david@redhat.com>,
	<peterx@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>,
	Hanna Czenczek <hreitz@redhat.com>, German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH v6 01/26] fuse: Fix dax truncate/punch_hole fault path
Message-ID: <67a5111b2f805_2d2c29448@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <bfae590045c7fc37b7ccef10b9cec318012979fd.1736488799.git-series.apopple@nvidia.com>
 <Z6NhkR8ZEso4F-Wx@redhat.com>
 <67a3fde7da328_2d2c2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <A1E3C5B2-CCD8-41BA-BBC8-E8338C18D485@asahilina.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <A1E3C5B2-CCD8-41BA-BBC8-E8338C18D485@asahilina.net>
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: f59e907a-6dca-492c-49fe-08dd46e6ad1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OIgdx/QS0F2VfD7RcMrlPZggvaQr+lm/b3Eocp+x63W65zCENK5LqxguXCTb?=
 =?us-ascii?Q?AD4zwkboTq6R0jFaKXCayyE9yt5X7uPOtHJX/iPUdYvdb3sp+8+iRwLGDbXT?=
 =?us-ascii?Q?3YcuvnkekyiIsJpciB55VQ2DCeZmq48aNrTcp1XIAr8Yw2g5hIz71PaB/XVH?=
 =?us-ascii?Q?ApUePWjG7r2oLFLVw9VMsZWrVcoYlXh2NnocXpdE2HrvzecffmskeHv4x5YE?=
 =?us-ascii?Q?bopn6aOgZt9y2SyjCh7i9i1Oy5O2NJJo9XWJhad1BKB0q3ZM16/YtZz6rs+O?=
 =?us-ascii?Q?FKbpRJ0bjxSq1tsr6olyyjvYDL+d6quNxPDwKp2YGgEchGZUUZEFphXkxDeM?=
 =?us-ascii?Q?BD7xm0s6RuIEVKTAng/Tbw6E0qisKcuWTqQxdGeqUcbhZ82OCzHKgAfBYbMg?=
 =?us-ascii?Q?DqRdzGpN+P6T9rVi7m3TfNfV4DuIv/YLCu6FkyPKJdoB6WkMOMOdcE1Sa53y?=
 =?us-ascii?Q?pA+5V+YnI+HS24qFisfvrr9oM5QF+a+zwsdP5hIlJxJf8kCxXgOvjAQDU1Pr?=
 =?us-ascii?Q?ZkPQh4rmpBNJFEwMYY9MCqyQWRTBLPv1XiN6X4FthZUqNUMjXz/pCQWnKfD0?=
 =?us-ascii?Q?jpETDWyKxyd3ah62mzB4MVAVdC6XmKUlI4HjLtyb8LgoJ/eFmUrJc+ORLnZK?=
 =?us-ascii?Q?xh6YirfJk6oS5oDOpq7hykwZmmk05XTHP6TLXlHpTkit6IqsryXvqYb8jOzS?=
 =?us-ascii?Q?NF4eeHChjjKO8xXKDqngNDkkc6mM/6KmiT0mps0Vo3qLONkFcsg+4XNbX/+L?=
 =?us-ascii?Q?qv5y7lauKoWyFhRkvMRd0/zvc8SJSY0FWkclUK+8gl3pcet33Ga/WVzKMeYx?=
 =?us-ascii?Q?XTDPAp0CVUh+TS7CsThdX7aobv14uJ3nvBmL0LGIliMwKsdSMotgWQn8g6+H?=
 =?us-ascii?Q?CsAVqkdHhc/5i/AkPnKh09OaizoLwfdB8QwdBvVdEN9SItqGX44oZ+AIEjjs?=
 =?us-ascii?Q?/muKcjLxgQY1TZyP+otBcCINOjJdwC2qjhwsfngpv4iPm79qfeuCSo1eoRd4?=
 =?us-ascii?Q?a+aZEMQsY7lxalFY2ku1+l2XS60jarjglp96zI2Gd4XaIantnhdocglFt4pT?=
 =?us-ascii?Q?99otIrATIhUWIwMnFZBZE0JRZt5fH/VNNZtAmkSChrcyL7BL27zuCwA0HGXV?=
 =?us-ascii?Q?o6JgQ/owVhxzlLxYKM1JRosBjJ9E5WSQ8Sf7w1/lPL4yKBC0+xMFwbsFsuEN?=
 =?us-ascii?Q?CFConB5tYnjdmYUZ8/A3QV0iaMurGpt8+fajMQvJIMLj8iBTT6/c3c6VPPIL?=
 =?us-ascii?Q?BrrY4Wg9ue/gjZ7UeUgP+va5pmYtQaphBkK11PgsJThZnWE7Qizf5bBz7uhZ?=
 =?us-ascii?Q?uv4VtFoHIetDGPJ13ZsZ0iyBvlg57mZZiv7iiME9777/BTlkPoieDcJcvNNr?=
 =?us-ascii?Q?lObIiQjV0q9pdCYmpr4lGhlH22aP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7uGLCczOQuER7M5SfIyEkqSTQar39xFt+f7Z0u04lYTkjg9SKQg4r6AY/Jzo?=
 =?us-ascii?Q?U7oPBtpIgnZfnJBIBFyZ4tT8R1FHZfaTGwBLkXrgYV/k1cEqKAMy8KI/GlX0?=
 =?us-ascii?Q?Z5Fa+6ucK3XADFtZtoK7SlJiFK2bf3/fgIJ2DF3TSkZtClEcBqFHhplKKfth?=
 =?us-ascii?Q?3A8rXpkyolSSBh2AnNzbJvdxdoJd+gcVsFPAwv6W7NwOPFwBOZ/FQkWoUj81?=
 =?us-ascii?Q?ZHIpxJGU2KZGfVJRzIsdtwasS+RLsA+6hq21tjKm9F7cBY51cy0oJ403FEl+?=
 =?us-ascii?Q?87zEz8WfI4WbK5SJ07q6++otLTlF4EFi8SNw5jf2zwjy3mGPLamrBsSD6FSr?=
 =?us-ascii?Q?oS3Vua2OBE9UZY3h3EmWHQhBX/DWIeBzqI7sG9LWOmDHQq+SN5WJEChbiuFf?=
 =?us-ascii?Q?efV3e1XGNh/yjXfyLTZjqaCNgyWFxN9tqVKGY10EacWIqBSdhtP9+eE0HxJM?=
 =?us-ascii?Q?poWB9BxpHll5BpVlOVwPGEzZhSqwqFln7pxwWghUJ32nXDEQUb4nU2yR/4Fu?=
 =?us-ascii?Q?f0149tzNVLbx3+leho4wmZaqQEHUMyXnTWQt9+bD7IKO90cQyaEBXehjhigj?=
 =?us-ascii?Q?qYJnxD/X45Lbr56zDFmBIvei9/KSNR9fDeXzrBXGPwjdRbNHGrLzt/fERm4S?=
 =?us-ascii?Q?dTMAIElRCm3Pap4bQj4pqkULT1u8j0J8LK2MPtG47nGIK/rtbMry1cRSNP/P?=
 =?us-ascii?Q?i8qpClafpRpUwyL6eJE9GDwd+4ywHMQSklKZLv1E/M/LVJGNbpFL5CJrXdEb?=
 =?us-ascii?Q?F0s53GpE6CSaKoRYPn9PZu6emamk0aZjY/gYrlrHmmQv916UaUVhQrwsQ9oh?=
 =?us-ascii?Q?e/SjuURqvckuVB+05yAbIb7Ug2hxIOtKg/HevvkzCpPUDwKLReN5LzdL33nF?=
 =?us-ascii?Q?RKt6FydNRmpn2xHlRZWXV8/5JImO7eFuyYLmsHAd8GLcHNHmEDKRJQ/fDn8Y?=
 =?us-ascii?Q?j/z+CN54ShHCb8RYbt/Gg6Bc/zXPeOn0qEiwMyA4cV/zqDcym6ejP7YJqDnA?=
 =?us-ascii?Q?b0UIRPqaHJm4qR2ryAgDCPMVpWuItfK/XhFmUgmzAyPdq4mfJsjsCRjtEfJF?=
 =?us-ascii?Q?Ayb55xeyo/pm8Wtg3K7Vj+AH0XXC1aQUNhLwzqPizP0zDR4AqRurwY43GUos?=
 =?us-ascii?Q?UWfH0UkxCpucU9mBXLP065FXhwWHfD1Aoi7H4IYH54beZv3bcWDwOX5HxQ4e?=
 =?us-ascii?Q?cFtevy6kPbv18RLoJSHCSfaqGOloyH/0yIP5Hzyf97iQNon1W32tzcOWq1L8?=
 =?us-ascii?Q?nrRX9JJhW5dZ6g/Xc6LI0QjHFB+WOMyjeI/xuiGzQJGYBcMSwEjbtJ7Bi9NK?=
 =?us-ascii?Q?9ucYg6oEdVR+JY8ywt/KTZCUFipF/C3LfPed3aGQGuESpxTI5k6w2yPz0zlv?=
 =?us-ascii?Q?u+la8XsisLfR4WqZmS/MiDtUzjAts6N4ZY13ZWzWhjnDdLfe7dqILCb+lhVI?=
 =?us-ascii?Q?mDYlyhaF5l8uet9+qOGvtA1HAHFS7LYWFJ6kDvCpm5QoYv5uME+I3CB7S+CA?=
 =?us-ascii?Q?2dT6rxmzLsIvMAEBWkFIH66nmIRcchaqJ8VTvcXQwP4WoAY13OzXVJkPfqA0?=
 =?us-ascii?Q?p6t4Fm5Ut51iMaqsuDI8ueaMU+yKXIbTJijQjVtuRWN/RkagV3ZCMcpFcHDr?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f59e907a-6dca-492c-49fe-08dd46e6ad1c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:44:31.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hL+fObs4Q4imKcdifzMWJ0Esx3KVRqeHklKCHR0uqmKutoCXw9sRrRFc7+mE2n90XlEZt3UgnE/GMrwWS+HwqWxfliAMAh//0WWTeYiyXdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8130
X-OriginatorOrg: intel.com

Asahi Lina wrote:
> Hi,
> 
> On February 6, 2025 1:10:15 AM GMT+01:00, Dan Williams <dan.j.williams@intel.com> wrote:
> >Vivek Goyal wrote:
> >> On Fri, Jan 10, 2025 at 05:00:29PM +1100, Alistair Popple wrote:
> >> > FS DAX requires file systems to call into the DAX layout prior to unlinking
> >> > inodes to ensure there is no ongoing DMA or other remote access to the
> >> > direct mapped page. The fuse file system implements
> >> > fuse_dax_break_layouts() to do this which includes a comment indicating
> >> > that passing dmap_end == 0 leads to unmapping of the whole file.
> >> > 
> >> > However this is not true - passing dmap_end == 0 will not unmap anything
> >> > before dmap_start, and further more dax_layout_busy_page_range() will not
> >> > scan any of the range to see if there maybe ongoing DMA access to the
> >> > range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
> >> > which will invalidate the entire file range to
> >> > dax_layout_busy_page_range().
> >> 
> >> Hi Alistair,
> >> 
> >> Thanks for fixing DAX related issues for virtiofs. I am wondering how are
> >> you testing DAX with virtiofs. AFAIK, we don't have DAX support in Rust
> >> virtiofsd. C version of virtiofsd used to have out of the tree patches
> >> for DAX. But C version got deprecated long time ago.
> >> 
> >> Do you have another implementation of virtiofsd somewhere else which
> >> supports DAX and allows for testing DAX related changes?
> >
> >I have personally never seen a virtiofs-dax test. It sounds like you are
> >saying we can deprecate that support if there are no longer any users.
> >Or, do you expect that C-virtiofsd is alive in the ecosystem?
> 
> I accidentally replied offlist, but I wanted to mention that libkrun
> supports DAX and we use it in muvm. It's a critical part of x11bridge
> functionality, since it uses DAX to share X11 shm fences between X11
> clients in the VM and the XWayland server on the host, which only
> works if the mmaps are coherent.

Ah, good to hear. It would be lovely to integrate an muvm smoketest
somewhere in https://github.com/pmem/ndctl/tree/main/test so that we
have early warning on potential breakage.

