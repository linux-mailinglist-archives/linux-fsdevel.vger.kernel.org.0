Return-Path: <linux-fsdevel+bounces-53209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36FBAEBF02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27495606C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A082EBBB0;
	Fri, 27 Jun 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaHUwoa8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1935957;
	Fri, 27 Jun 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048795; cv=fail; b=pHAL6SQskrbWFGgnHSgUKYmg+sO6nWtsku0akVGsT5zWiOVn3Yt78DjYdGhUhwLYL/GkbF4EOYN2Kn+s0zGMiRntjO+nyoMREMMuCagXw6nHr/z4wVXbBFbJ479gpZPR2e5vdHWkzK/oxrzjXXuRZnzqjJ5uxfF4bRyBPtM6A3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048795; c=relaxed/simple;
	bh=9x9HFdapjehl+9itqZ+BfFx9E/+rM7dXX/yGEZec7/E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sg6uSvpJ93XPbFppcjYDiLCODRK9pjNC6BbAWEOYZ+Ck97i69QIWLZ5AfuwFEMSGQTpNVPgzE99qy7g32hZjbL07mNjjBvc3/DDeM8FoZHSeLZMGG2trzA/PoMX2ypBhOJRllAdJueC7rxyXRlSdnJdQMteSH2TKYTXxB99K7b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaHUwoa8; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751048793; x=1782584793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9x9HFdapjehl+9itqZ+BfFx9E/+rM7dXX/yGEZec7/E=;
  b=UaHUwoa8BQVJPyhaVTH5V9+vXNP5rVe19CJt70ipPUEKXngMbX9gaL2Q
   9KzyEMUVA4Yil53N7di94QOmmn1H6LDy+/AqOMMdu5cS5+Lw17e7ko3EF
   2xrsuffjoAyJoXoL97Zs47Tsjus5T4sWX5BvB32dn0INqks5B23Rpe4fY
   dIjFhWPkPkGsWpK2uOX2HYfwd6lxCb7mXg/dHENrXHABsN4ywXrh9t6ri
   foPKHBTe6xV2CgEn3I5mcdMxhGFkPyxmIK4MmSfJxnc/5PtlWnQqZ1i7E
   NudmE2iaKC3C5o8/kGisRJUsEAIJNmcCsWuJzoFx8AgLVDxm60rdfN9Ci
   w==;
X-CSE-ConnectionGUID: Ej+MYmH2Se+eTEW6L6vzyw==
X-CSE-MsgGUID: uPjvSvLiQTiZ8/ZdzBFJhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="64814454"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="64814454"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:20:03 -0700
X-CSE-ConnectionGUID: e2oCco9MSG+ANyOGBlsA6A==
X-CSE-MsgGUID: XHm1Ml9lTPutIpGrmRrXtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="153359296"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:20:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 11:20:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 11:20:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 11:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVILgP+1VTuY3Wv0CSATutzOtMP5XTTEg2Q1vGHT2y+E47uqx+mwj7pixEHY5AmZAyzusAB7W6LrvLGBx4B+CD0eKrqUZUwPWczK0Ldx8aqh3WR0N+9K4z4Zbl2qWyYXbBciAE58jKDxzHMKdjLl+1JTxnWbatcSkGJkblHhytdNJ28jyqCD6zMZ4vedh0uVOJzWOhVgUPPjZuQW3KUOksMU6wPzVcjIWyCKTfOGh1qWE5OxP7rTBOnv/LHtlaRXcIAj8AUylI8GzFujnGgbVKTNC60YjuuY1f8zkHTgR1Qv9yQPbrQP0Be6lpzBpyXykNLxq64KpWOx86rObW8aWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhuUwmBcGlLXyOj8y6eGvBeEcEfnmWId8VdE31NysKc=;
 b=g0mZMXkgN/HGeCX1f49si6H4fHBznkb6bIhY/hB38EjqIZ9v1cgEg+iNF1dzePRJCpMmyEj/XxnnksEzQv51HAv0ZjB9Pbs6fSDgZXon+kPtnhFpdnBc4QgRws1ng02Ez1tEf9PliHUw/ov9oORuntKnZMXW/CmObAii43vnFxUE53ODSzLqUaLtRerXVezT54jHaHLokHB1hE6uCfFtuUS06F6EV2xiBSv2B+6372gwTectBV17TkQZ+iZaG8kuCnCR99ao/S2k8Wb+7srsDuEYHaDZWkAAGVL6wevkI1IHWQbvXC30oTZW1vFKn0iklGRRvBkqqG97w5UGIXsIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MW3PR11MB4715.namprd11.prod.outlook.com
 (2603:10b6:303:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 18:19:59 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Fri, 27 Jun 2025
 18:19:59 +0000
Date: Fri, 27 Jun 2025 13:21:17 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Shivank Garg <shivankg@amd.com>, <david@redhat.com>,
	<akpm@linux-foundation.org>, <brauner@kernel.org>, <paul@paul-moore.com>,
	<rppt@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <seanjc@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
	<pbonzini@redhat.com>, <tabba@google.com>, <afranji@google.com>,
	<ackerleytng@google.com>, <shivankg@amd.com>, <jack@suse.cz>,
	<hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>,
	<roypat@amazon.co.uk>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH V3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <685ee11da5119_2ec7172946a@iweiny-mobl.notmuch>
References: <20250626191425.9645-5-shivankg@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250626191425.9645-5-shivankg@amd.com>
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MW3PR11MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e31ac9e-b0b9-4429-6585-08ddb5a739ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMRX2UGK50RkIhgy+X2ABq6Qlwm39OVnVNxKf6xh9YcAv1ApAiOyQ2SYgthO?=
 =?us-ascii?Q?Qx9HVzJUnZderqv/skmtDzF3gzN0wutun/VCA66DgzkuwP7FGLuBAp0pca+y?=
 =?us-ascii?Q?CTMLXv7tsiCUHnFvSsZ4BZizn5VANv1VPA3/rjvAnzC7vSNLGn7RGZztw9Nt?=
 =?us-ascii?Q?Vly8C9XNxwa1QVaRSTZu6zyGDWrJntuLo5/al8icWROpyMy6nmn1AOGeTbjt?=
 =?us-ascii?Q?3GhZcGUjc+7mKmtnEAbFkiCjCshfrpv+evurBaGQCjGBTtnNUEGxR2p/tGAV?=
 =?us-ascii?Q?hi+rry1PFhohLQtnJNHp1WZbOJtVFAFPb2VR+0ylbPpvAMeCZ92/RxH9TxX9?=
 =?us-ascii?Q?jn0M2gz8nydSEwycnkEb+DaEorKpQxhTKPPJsYA/6L4r4qr3VNmWgXFqDbMr?=
 =?us-ascii?Q?qkuhHe2N0pOrBiAfuxmvh//dx81026O7nL7ZNI+BWBX+qwmmedSZ2tTQxau1?=
 =?us-ascii?Q?KIqz41nRHgMypuurveyhhZOdNVKOd7P8jsW/nu2+8+c9/PXbUyr3v1BoWOP/?=
 =?us-ascii?Q?6dzkdCmM35mCBZ6Sr3qOKN9SQpFRXJ6TLMxbkhnw3w7+WprAA20KGja+RBP6?=
 =?us-ascii?Q?4HVItJAht8TfMGkZhrSqbFl/Hu+fV8BNCxl2RIu1TchSsA1J2WvkhpaL8TMV?=
 =?us-ascii?Q?/p7THoJYeQ7oFpZnTvr+n2Kckv36iOn86JbHCZxU00H15wYZx9ocpcoJAPfA?=
 =?us-ascii?Q?Cdcb1PCaunmgkxoauyjqmBl8QnQtFp5dSe4dHLcBFXNhXl9QCwgFDpsnH8Nd?=
 =?us-ascii?Q?HAwSWMwd6mHH8BKAYbU4Sv7rz5z/QnqcUTqsZyu1mr7LGGglW8pejRKwB6pI?=
 =?us-ascii?Q?7m3Gidy8IlADta7lGdx0v4XLZ2gVvDp2HTq5zcCnCwYUYU+d9AZfhpe3/Gl4?=
 =?us-ascii?Q?18kr/hJtO0Q6VvumLRo87P97d4i3L9MFrNixlvlGm0I3N37AG1oMDhBD7OqS?=
 =?us-ascii?Q?uykhIr+yVz6oZTO7IVULUcDH2PQljAfxS8gqZ7SbrTJb19u54IGx5VCtHsZJ?=
 =?us-ascii?Q?9BvMfsVyqbTOyxaO3Ss0uJtaYOxAQZAJyyICgEewuO9RIgP8mqR1r5Ui0ZMs?=
 =?us-ascii?Q?iFi1B4gic0+0n9LQrr53UnxPehCI9LrTajsmxmh03y74kKd8vDSPWT/rwm+n?=
 =?us-ascii?Q?r5lxZoIZPT3kp0MvyLyIaGjVoUv02JFF+2vxnb+/FrUpbbuhO/7dgsziEmoP?=
 =?us-ascii?Q?cesQ8I5C2XwBfo6kzChr+J0rSQGfHIMyi8b8VSYtpzdW3vUqaLVL+jz/NiB4?=
 =?us-ascii?Q?SbDVzC7Acm9TknDwwUqhnrUj4qU9dohydIsjYnTvoMaWRYB3zP++4qtIypB8?=
 =?us-ascii?Q?cYNmmSBMz7ogJhPqcbO8mUs7UAqAwCRFvQs5/XcaHe45Bkw8jWsESQ9Xe2hi?=
 =?us-ascii?Q?bsDXngrg2FMy3sntxNaRkNs1gDaRjXP+7/uh3n/c2RW1iI7S3h8sCorLUvva?=
 =?us-ascii?Q?G3jMm1iafXY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VSe55YbxOFHn8hMAzhfwRcjfA8IXSCpcJikAZZL6TUItM/qiTUZTCUABNWug?=
 =?us-ascii?Q?oLEciFraAgx4p011y22DzXWDYB46XVWnCs4T60bb9a9ZeL9WGIcZMJCUfgLa?=
 =?us-ascii?Q?o9KH9GPJOnUV9wdApDDdwmlH+RVnznAWaCoHt7Rm+tT7mw5v8xdQZ/LvyOVS?=
 =?us-ascii?Q?JWVs3mtJ27XGsPEWSc6e/xK4YnXyBtSKnFzhgdZhySLb6n4WnwZmkfIjXF7Y?=
 =?us-ascii?Q?mXIjF9teuvPS42aIwxnK/wgiC5/842CZXhJfHM/elAL4e+J8EYAH16c/DIgF?=
 =?us-ascii?Q?+sjhTTOnb+D/aRekt6Wx+R9StyDpm79WTaeFIcBJG+Ful8R0jqM3t46LT6TJ?=
 =?us-ascii?Q?wgz8Q2uAcN4ybt9Z2MCkzm0LqHxHtJOOlEchne+sIJOKhMO1x1uP35NkCmQK?=
 =?us-ascii?Q?vlmJN2oiSv0PINMQXsuRPNDYKn/+WZspDV+ZkaxCQCFAAoyomEzJ/Do07g7D?=
 =?us-ascii?Q?l9gS41keP10nkRDRf/nK7YvH18Olf0ca2ivl7VFkLc6gHiumb1W2jQbJdRg+?=
 =?us-ascii?Q?BRRGcDJ861F12TWMYrOoq8s25fe1AzmkuBOQvuC7q+AFoOIgclcPmSL1cRpR?=
 =?us-ascii?Q?0rHxCHJHE7zGX0renV6w96R0dOpmvGYtm485a5Err1KZ7eZdfpQxPKcI2BlV?=
 =?us-ascii?Q?vCpdse0MwfVkCv9Hfj30eQu+QgoSQJ09K7FzMBvGVUdPc2WarvuX14ZtzXGW?=
 =?us-ascii?Q?QmFznZOXtpXw30BcZ4U9eEbo8aRyysyDdtAuCGqooLDn6Jf9jjJ9fpbYJgf4?=
 =?us-ascii?Q?wIwMghyYQZy6qPeuMJFCesIkRp8L9Hw9YhchG/yxmA1vMfGK8Q9bBYBmYiBl?=
 =?us-ascii?Q?kjpmCchGD3WFlYQq5/kMVRL0s2NptPu2dysKybTUXdMKwvjD27/GsL0z+2en?=
 =?us-ascii?Q?Mom2xVUxv4Ky9KOl3SevajDmuILAaNkYHRXfyIi8/0uTS5FistY1BJYf5Neq?=
 =?us-ascii?Q?DE9P4XqHqt6YJGT3KHWurk0AOcGMZSt+YpvYCph8Io1BWAT+kbcs1f+YILCG?=
 =?us-ascii?Q?tOHqwA0Yfz265zyGc+w69vxYpDPWT9V40gIfiHpgmO5gDF8Z58CifbQcc6BT?=
 =?us-ascii?Q?iZjEvb0OQ4ZgIYbS8nFWJZb3SALXD5VnZv4jdufSHBBidPNNdGWTf/nQwS74?=
 =?us-ascii?Q?+yUM3CVdepWcRzTyDuPbd1vu7SepJpVKeY/cBJ4grw0N1wwZRctCHc86cHej?=
 =?us-ascii?Q?stEFStUkj5/wM3GijaC4GPxrCm9SomjF4I50E7E/DFx0bjWO4Fe6/+Hl4rsS?=
 =?us-ascii?Q?Ls+uHbtfqxz0nuLQ4eRqrQsSD/kcIXeipa1ev0I0veYv61+it7hDHuegNM9F?=
 =?us-ascii?Q?8kzlgB7PBKkwGSO50Ye68PjiyRhoafhHUTTK2Zh0W+di5CSV1N6wfvkuF8r9?=
 =?us-ascii?Q?dc15ulz4fF4TF6ei1laoKMSb/8gUvbvslcIx8YawDQhW4iT0eWHfrkUGtjEp?=
 =?us-ascii?Q?HxrCPU5emdblFJndfeQevpJmzPgyg5HbCsbw77UhwLUKTO0GD4hDeeLjyx5l?=
 =?us-ascii?Q?xALst0Ssrsl8yhKPTP4gZotxA/+FHG2+teAqZYAaY/96mwMGdTBgaHJgVKHy?=
 =?us-ascii?Q?8zEf9DBndozBRxBayEx6YZk3HWa10me+wZI8CYY7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e31ac9e-b0b9-4429-6585-08ddb5a739ea
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 18:19:59.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GAVCdQuXzZuqRtTDavpeV4Z4wymrA4bHPeN6yRecE8nEM0A1yQz/VL22ds7BoBWM+kqCdtU078Qz292uL6q5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-OriginatorOrg: intel.com

Shivank Garg wrote:
> Extend anon_inode_make_secure_inode() to take superblock parameter and
> make it available via fs.h. This allows other subsystems to create
> anonymous inodes with proper security context.
> 
> Use this function in secretmem to fix a security regression, where
> S_PRIVATE flag wasn't cleared after alloc_anon_inode(), causing
> LSM/SELinux checks to be skipped.
> 
> Using anon_inode_make_secure_inode() ensures proper security context
> initialization through security_inode_init_security_anon().
> 
> Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

