Return-Path: <linux-fsdevel+bounces-20202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C878CF776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 04:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79392B20C77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161B322E;
	Mon, 27 May 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXl23Yw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993E1A2C08;
	Mon, 27 May 2024 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778173; cv=fail; b=nJrdWyeGX28VNu+KGvsxB3SizTOLRUdbr83/hnIqsngkzbeU7BE7k+GQKyY774r65f9GYlMsopx31UcFm2zD/xsJb+ickedjo1yUfHSu9trosO4J0uTdO41ozNAV87XRCEUEYSA/aJ9Qzd7qjNTibIeiczVzCU5135leu/IO6CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778173; c=relaxed/simple;
	bh=1+Al1tQyzbvV+tAhUit1ADb7sKZucCVR8vyTeb7QYOc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aBLNj3WpA45HfqKUvCktNEziGDzXd17WHzrWdqZwQqeHK+FPoeyDW2dkoWYwjtGsQeK2UYi0ABgYeJ5S1+wocva7NstElYvX7DXyBhVpFyoS5S/vuit8jwsly62fYH0mr5KvtTNONCzpMctR2aEKzUBNbUJEetJKJmEuSukOMlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXl23Yw2; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716778172; x=1748314172;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=1+Al1tQyzbvV+tAhUit1ADb7sKZucCVR8vyTeb7QYOc=;
  b=dXl23Yw2vf2Vf2n6C1jlDlmxSW3ArcWCBYgTTBmpF7RgHDL0N4wZ2Zlq
   wt2vyzI8lLJhLiRfxnP9pAbtLve+Wb+em1qNnnXoJrtpLryTNcaRfbS+J
   RjQe61PNFBkHQHTAij0/Htm95y0YPwB3Dc21WxWt02AOep4rDJc9lGkbC
   HlF5EAXryi9gZ4D8yW9LbdRaKL4E3fLYX/ncH55g5Sy4F3dG14QWFc6ll
   qoSndBhw/4eSoiIv8Ewjo9RkmuA+LzYG36p992cO9RnNtm5O5qw/ALQfa
   u1qLW09FASF3RIRadjXJ0NrbAvv0M4izOenZYBSFO0yxRE+FHRaUydln9
   Q==;
X-CSE-ConnectionGUID: Dw5Pp8oFTyGCZwrokvzYiQ==
X-CSE-MsgGUID: ggZrMxOcQIiDsZd/q2LHyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13194626"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13194626"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 19:49:31 -0700
X-CSE-ConnectionGUID: 27T9jVrZTKi8anmGQ0TcqQ==
X-CSE-MsgGUID: 5ZkUSVxlT/24dHTLor/4TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="34595347"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 19:49:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 19:49:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 19:49:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 19:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZEQErfNcpyKchHJfxFQ3putCr5F+KudSfKbt350ClUPTegh7Ry2j6uWLTsnPsIWrHWOo5xHIi9A8urRUanAgUj5zc8qt9kLaWa8RrJBWy+57cTFKsBeFs+DHPXJJvqNCfapnwcChbvhkgXZ+9Pu0wEPdiIz+bZLRJeToAnR5plVnpJ9O0li8BGKh2JKeY4agg5IMqE36WTo+Gdhye+0ItzKnW3PQswal1UopnCdf2uGD18P9VB5Lg6QoGf9mHDrWYIYlviUxb4A9g9GvYOVgP2rDYyFyuOeGv66ywxl1JuAaFD5jvN+N+TV0u0/QVVBj1dLsuUXmfb9xMesjw6ISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJFC7ZD+Xv1jS7kSXqqaxVS5irqZBmakbLqLEZiQRX4=;
 b=iotMlTd5gacpyY0DWjqlNfrynVgkaU0UvlxKw1N2DJ7PEOViVKc4pxjbhR5+qUlenEluQlqJNqZNxh92gIuJ1Y3EK5r++Nm+XQs0oZ7BZbso1jM73PPc2o09BMXrQUuau53bLPDBzN+bpcLiXEgd5L3O4qhgYxf7XS56ThvJkubKL/oyQB7i3OqZOLY00Xd0UCcAnx587fcKJleufUxHvgjdNGbAaD6P1quL1+AUY2L+rR2kRzQGSTeIhfWCMYZapWy26bWlx52Pw8l4uoAlkheiUfuPTLG909b+jJ/nkjDcULsRzETYKhR96wv6EbKZGVsb1lE2g3IAPptgGOnzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6503.namprd11.prod.outlook.com (2603:10b6:8:8c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 02:49:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 02:49:27 +0000
Date: Mon, 27 May 2024 10:49:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>, Amir Goldstein
	<amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner
	<brauner@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH RFC] : fhandle: relax open_by_handle_at() permission
 checks
Message-ID: <202405271007.7e95eb21-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
X-ClientProxiedBy: KL1P15301CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 46db0de2-f5f6-4d9d-fa97-08dc7df7a002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wWJRLAnlS5JYCx/SJmWhas8CA/vh2ExgDv/8XRZtEDsSfrsGCEcBKbg7QzjL?=
 =?us-ascii?Q?guJr7IP92xxQwgIJuC3hNf1IQCsiFPdK/wMBQ6EgXYquCBWRZqxu1f7SKrJk?=
 =?us-ascii?Q?ODgXAUqkZ3F8s5OpisypHBggRqh5fqWVzfUI+W5wU0q+WtfGnUTTHQoPTTwc?=
 =?us-ascii?Q?FSpb4LNM4HinvqTen4+nhxx0zACfr9GNyMpJt7VZGUsj0KkYRoKPWkf7TLsA?=
 =?us-ascii?Q?8n8/kZpO6zfRK2UJQnpeyHGjolHl8wo3LdP+jzSJiLolMDUyWY3twWqyfWi5?=
 =?us-ascii?Q?uqfvPauxFwfgkw92Dqu5xEu7fF1gxMBPTJpTlFKfdNWfedqHK19TuAAYY4ts?=
 =?us-ascii?Q?T6O8IMPWf3gU+kweZK0JLdqYHoaIu1/XnnoII9W6fMSXBV8rA5qQO0UufVrb?=
 =?us-ascii?Q?NX7GZBWJoM47xEvHYuRi+Sc+oDPiXnOBLbfw/G6b7UyhMcatkISAGUMGbNn7?=
 =?us-ascii?Q?t5Y0oNc5qI6mTFjT4ldF5Bw6ilbKM829TQpRakwFODa7k0KOtQSKRvlpP1me?=
 =?us-ascii?Q?sGOe0Mi1Q6+UgcQrendyR1uC+AyVtUg+Z1SgmiCUD0EDuA9JTKOTyKw5GQr2?=
 =?us-ascii?Q?YdHM6EJgZh7/urYI7ABhgDu7Hz8LhSzqtyG/u2zg6Ln/77zfwvxONlrwsFdu?=
 =?us-ascii?Q?TAPOgDPgSeNc4uccDK4N7DuD/uXjQ3PJD9j3cPui/9DPdAxbdAVlyimC/COd?=
 =?us-ascii?Q?fugVTlKWBFlIdKuzhd/gdlAkUQQuNdseIUtDiYVGgVLgH6QWKH3M5n+anT7I?=
 =?us-ascii?Q?bof0dVK3H9CUOqe6Ax56wAkPALzdeZbBBmdp84tg28wBnM1qb6pt8dnUrzjI?=
 =?us-ascii?Q?B76+EkvpVtJoz0KZuYzDe8sI18Vg3mR9wVPjLm0mTKLzifR70cjqF5gMXIOy?=
 =?us-ascii?Q?pK5v6k6ilAoBoeYxChVMDNt3RZLZdnPz8sxOwfrJWkA1blqLq7j5xnbCVe3n?=
 =?us-ascii?Q?Q8+AerUfTCmtsqyDk+zAd4ySkyywD6kHBVpEYjLtlsg7HPLmlUgiKfwf5ojv?=
 =?us-ascii?Q?hsJytlr0QnFRESTe16mW0Fn/NZhzR1l2AVX2pP90dlp69OFD4kT1t8mUJML/?=
 =?us-ascii?Q?XzujkWQe0qM4CfKHp0kf6CrKCVQ6CqZ092Cn4fd8ZaKAZaemoa2VVpo/kBB9?=
 =?us-ascii?Q?s7geNaDKD3c56bC8Ymv4PqNzLOgJ0uV/RsTeMubj3oonVM1OI4NMTE1Fyf/Z?=
 =?us-ascii?Q?c2xOxw06pxbbfekbt10R89/+h2gXnkc0GS5kVLMl3SV76wN+M7sw9qdCm9I?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXsMngZ501q7+hcp5Q9QYY9HsKY+MjTsyZiG0lrJKKDz6wWoQpU2x8ijue+O?=
 =?us-ascii?Q?ETpWK5Xht/283/353YgGbRDcUk+n+yLO4+EOXu6aNfl4ejl85fCKV+1BzlPJ?=
 =?us-ascii?Q?PMYdGDkIey6Y2Y0Z0jgogSY0WVtzmcIUtlu8WPKjaJT58zE38dV0HaCkP8j7?=
 =?us-ascii?Q?Kerf8oAQ1M9nrNQNUAI9fU8dZo/ILo5LAyFOgF82G38xxPzjUJ6k3Wa8EGZu?=
 =?us-ascii?Q?oXvm6ApWVJm8og7TFBLU+7OFUVMfvF0mohRhRL4fHwmZOgGrqffY+PxoV8RM?=
 =?us-ascii?Q?lgXiRZrdFqBCQ8Q1FGQsdnPV7ErTcROV+JonL+VF4C2gCmucCPnw634f8qR2?=
 =?us-ascii?Q?/qECKwaQMpCvHzAVnI4kQIBYbu7mG0fSDKbIUb/MsRFIP+2zvQ/tMgS+jGLI?=
 =?us-ascii?Q?GoYwSnaKgW4ZhsyHtYwPtgcPZY98ZK4LgDEb4FvHnd2Xf5M2VWAZq4VT1wxK?=
 =?us-ascii?Q?Cd0qrP55uE7ShmjYvSTAVmEq9nOeONOdGVjU2FjmrH2rPO13fyUTsZdrQg/c?=
 =?us-ascii?Q?soI310PdU8CPm+5iwNfzDx8m/Hl4gx1WSQOFFZGU3+rHdRMt9l2nYs3TJ31R?=
 =?us-ascii?Q?TA75JpfaYPar4xgcJOeXx7W+mgJlNbOTXeYRQ/ln9+Y2V+KGGseMBCHUhycK?=
 =?us-ascii?Q?rP8CU/5FYs5WnajREEUAl2TGgIDjwfsKZWmPoAuUJqNUzPBGoO8FPfL3+beV?=
 =?us-ascii?Q?P/1/v60hg7hxJSJhrsn0fcW6xHGBvPTxAgiY2u8hrnDxsz8DQWE/+q3bFLKd?=
 =?us-ascii?Q?jRdcJt1Snjd5ws5bEtl8s4IeIyloaxeq1dES7wBjAaOfeT9FBF3BYcOaw/BS?=
 =?us-ascii?Q?ecVWHjNnurEd/p1kOaCyipRUdHgXtJORhqJ8lmVHZficBS4yOtGQsxaB3ujA?=
 =?us-ascii?Q?14JW8DT3HexyuDmpt2gqT4kBONq1ZC2P3WnKEd1Gwyj5rTGecneCdzEx6qes?=
 =?us-ascii?Q?4uvx0VRu/EhDEYL3FhWWs1KspOM60gGOGVoH/LduzsUHzxN2VOKZ5QzE3Zfu?=
 =?us-ascii?Q?ZkKKOHjnLdmXlzerhaK2PelcU1NElpbJceV2zXcx5gqCpEBgYn+uDaFQR10U?=
 =?us-ascii?Q?vuletqvFKKAN2rJ1bz397WNzyrdTLEDzaGsroukIpBSuhheXMWmEcb5RZfbC?=
 =?us-ascii?Q?Dpv3EEZ+8/EuDNas5a7YRhCvTIoiyqhGDiURcEuh/NToN5ZOQEMraSvD5/rC?=
 =?us-ascii?Q?6eNsNJ8qvj53YLdewUenw7kp9K4GHudE6Cyt8JGqwDUI5X7u+24xVOAywFzf?=
 =?us-ascii?Q?kwdD9YZZlK9tOPAgn6FUd+skaSEfBh9Dx8d9GBMpFGfRbKpFGsRKQTFxHeGO?=
 =?us-ascii?Q?IcKsO6zsc+7wvz3TlmOkHaL9PHDk3Q1s3hXuL54QxlB4y4hkV6tcGCopT0e6?=
 =?us-ascii?Q?Ik6cXXnGqmP924cE5IRWAe4vxZfWhgzlBHGhiFPAkTdyJcOsHru1eo2lta1D?=
 =?us-ascii?Q?dLGOSTtJKyjXbG02+1oXs8ad9rWsURKT28GApTapyncfFlOgDiWO84ZZErrB?=
 =?us-ascii?Q?H/bjEcexBSkRWtVK23DgzKGIRfXAaLgDilmid/MXZF3wNv3LsCVXaWrZqgPZ?=
 =?us-ascii?Q?Y3dJ/R4akuG6QWGb3U2ZWvWDuRpSxQRh/jjyLeKg1f/kfjr2Et608NGEisZa?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46db0de2-f5f6-4d9d-fa97-08dc7df7a002
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 02:49:27.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKx3ke3bNr8ZgXfC22vZVhog/55mOFrIh+s/tabS/1awya/ERwYpOUwKbKQRgxEznVXC7ZUnwZGAWn1kwDpOJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6503
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 9ca8b65e411ba759831af5d678f8d01e141816a1 ("[PATCH RFC] : fhandle: relax open_by_handle_at() permission checks")
url: https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/fhandle-relax-open_by_handle_at-permission-checks/20240524-182059
patch link: https://lore.kernel.org/all/20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org/
patch subject: [PATCH RFC] : fhandle: relax open_by_handle_at() permission checks

in testcase: trinity
version: 
with following parameters:

	runtime: 600s



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 8f6a15f095 | 9ca8b65e41 |
+---------------------------------------------+------------+------------+
| boot_successes                              | 4          | 0          |
| boot_failures                               | 0          | 6          |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 6          |
| Oops:Oops:#[##]                             | 0          | 6          |
| EIP:handle_to_path                          | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 6          |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405271007.7e95eb21-lkp@intel.com


[   20.927410][  T678] BUG: kernel NULL pointer dereference, address: 00000002
[   20.928271][  T678] #PF: supervisor read access in kernel mode
[   20.928887][  T678] #PF: error_code(0x0000) - not-present page
[   20.929607][  T678] *pde = 00000000
[   20.930090][  T678] Oops: Oops: 0000 [#1]
[   20.930616][  T678] CPU: 0 PID: 678 Comm: trinity-c0 Not tainted 6.9.0-10324-g9ca8b65e411b #1
[ 20.931662][ T678] EIP: handle_to_path (fs/fhandle.c:259 (discriminator 1)) 
[ 20.932243][ T678] Code: f2 ff ff ff e9 95 fe ff ff 8d b6 00 00 00 00 bb ea ff ff ff e9 85 fe ff ff 8d b6 00 00 00 00 8b 45 d8 ba 15 00 00 00 8b 40 6c <8b> 40 18 e8 c1 3a de ff 84 c0 0f 84 5f fe ff ff 8b 45 d8 8b 55 dc
All code
========
   0:	f2 ff                	repnz (bad)
   2:	ff                   	(bad)
   3:	ff                   	(bad)
   4:	e9 95 fe ff ff       	jmp    0xfffffffffffffe9e
   9:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   f:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
  14:	e9 85 fe ff ff       	jmp    0xfffffffffffffe9e
  19:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  1f:	8b 45 d8             	mov    -0x28(%rbp),%eax
  22:	ba 15 00 00 00       	mov    $0x15,%edx
  27:	8b 40 6c             	mov    0x6c(%rax),%eax
  2a:*	8b 40 18             	mov    0x18(%rax),%eax		<-- trapping instruction
  2d:	e8 c1 3a de ff       	call   0xffffffffffde3af3
  32:	84 c0                	test   %al,%al
  34:	0f 84 5f fe ff ff    	je     0xfffffffffffffe99
  3a:	8b 45 d8             	mov    -0x28(%rbp),%eax
  3d:	8b 55 dc             	mov    -0x24(%rbp),%edx

Code starting with the faulting instruction
===========================================
   0:	8b 40 18             	mov    0x18(%rax),%eax
   3:	e8 c1 3a de ff       	call   0xffffffffffde3ac9
   8:	84 c0                	test   %al,%al
   a:	0f 84 5f fe ff ff    	je     0xfffffffffffffe6f
  10:	8b 45 d8             	mov    -0x28(%rbp),%eax
  13:	8b 55 dc             	mov    -0x24(%rbp),%edx
[   20.934542][  T678] EAX: ffffffea EBX: c38458c0 ECX: 00000015 EDX: 00000015
[   20.935354][  T678] ESI: ede5bf48 EDI: 00000000 EBP: ede5bf70 ESP: ede5bf2c
[   20.936199][  T678] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
[   20.937022][  T678] CR0: 80050033 CR2: 00000002 CR3: 0370d000 CR4: 00040690
[   20.937713][  T678] Call Trace:
[ 20.938034][ T678] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 20.938520][ T678] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 20.938942][ T678] ? debug_locks_off (lib/debug_locks.c:44) 
[ 20.939502][ T678] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 20.940033][ T678] ? kernelmode_fixup_or_oops+0x5c/0x70 
[ 20.940759][ T678] ? __bad_area_nosemaphore+0x113/0x1b4 
[ 20.941504][ T678] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 20.942005][ T678] ? up_read (kernel/locking/rwsem.c:1623) 
[ 20.942838][ T678] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835) 
[ 20.943483][ T678] ? do_user_addr_fault (arch/x86/mm/fault.c:1452) 
[ 20.944138][ T678] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 20.944774][ T678] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 20.945558][ T678] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 20.946219][ T678] ? keyring_search_rcu (include/linux/refcount.h:192 include/linux/refcount.h:241 include/linux/refcount.h:258 include/linux/key.h:308 security/keys/keyring.c:923) 
[ 20.946845][ T678] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 20.947517][ T678] ? handle_to_path (fs/fhandle.c:259 (discriminator 1)) 
[ 20.948115][ T678] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
[ 20.948896][ T678] ? handle_to_path (fs/fhandle.c:259 (discriminator 1)) 
[ 20.949505][ T678] ? __lock_release+0x54/0x170 
[ 20.950147][ T678] ? __task_pid_nr_ns (include/linux/rcupdate.h:810 kernel/pid.c:514) 
[ 20.950699][ T678] __ia32_sys_open_by_handle_at (fs/fhandle.c:317 fs/fhandle.c:357 fs/fhandle.c:348 fs/fhandle.c:348) 
[ 20.951279][ T678] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 20.951859][ T678] ia32_sys_call (arch/x86/entry/syscall_32.c:42) 
[ 20.952409][ T678] do_int80_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:339 (discriminator 1)) 
[ 20.953037][ T678] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   20.953604][  T678] EIP: 0x8097522
[ 20.954040][ T678] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 cc 3c ad 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 f4 3c ad 08 85
All code
========
   0:	89 c8                	mov    %ecx,%eax
   2:	c3                   	ret
   3:	90                   	nop
   4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   8:	85 c0                	test   %eax,%eax
   a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
  10:	75 d8                	jne    0xffffffffffffffea
  12:	a1 cc 3c ad 08 eb d1 	movabs 0x9066d1eb08ad3ccc,%eax
  19:	66 90 
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	66 90                	xchg   %ax,%ax
  21:	66 90                	xchg   %ax,%ax
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 10                	mov    (%rax),%edx
  3a:	a3                   	.byte 0xa3
  3b:	f4                   	hlt
  3c:	3c ad                	cmp    $0xad,%al
  3e:	08                   	.byte 0x8
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 10                	mov    (%rax),%edx
  10:	a3                   	.byte 0xa3
  11:	f4                   	hlt
  12:	3c ad                	cmp    $0xad,%al
  14:	08                   	.byte 0x8
  15:	85                   	.byte 0x85
[   20.956462][  T678] EAX: ffffffda EBX: 00000136 ECX: 00000001 EDX: 00033f01
[   20.957337][  T678] ESI: 000001b6 EDI: fffffff9 EBP: fffffff8 ESP: bf997c98
[   20.958254][  T678] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   20.959207][  T678] Modules linked in:
[   20.959695][  T678] CR2: 0000000000000002
[   20.960372][  T678] ---[ end trace 0000000000000000 ]---
[ 20.960979][ T678] EIP: handle_to_path (fs/fhandle.c:259 (discriminator 1)) 
[ 20.961566][ T678] Code: f2 ff ff ff e9 95 fe ff ff 8d b6 00 00 00 00 bb ea ff ff ff e9 85 fe ff ff 8d b6 00 00 00 00 8b 45 d8 ba 15 00 00 00 8b 40 6c <8b> 40 18 e8 c1 3a de ff 84 c0 0f 84 5f fe ff ff 8b 45 d8 8b 55 dc
All code
========
   0:	f2 ff                	repnz (bad)
   2:	ff                   	(bad)
   3:	ff                   	(bad)
   4:	e9 95 fe ff ff       	jmp    0xfffffffffffffe9e
   9:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   f:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
  14:	e9 85 fe ff ff       	jmp    0xfffffffffffffe9e
  19:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  1f:	8b 45 d8             	mov    -0x28(%rbp),%eax
  22:	ba 15 00 00 00       	mov    $0x15,%edx
  27:	8b 40 6c             	mov    0x6c(%rax),%eax
  2a:*	8b 40 18             	mov    0x18(%rax),%eax		<-- trapping instruction
  2d:	e8 c1 3a de ff       	call   0xffffffffffde3af3
  32:	84 c0                	test   %al,%al
  34:	0f 84 5f fe ff ff    	je     0xfffffffffffffe99
  3a:	8b 45 d8             	mov    -0x28(%rbp),%eax
  3d:	8b 55 dc             	mov    -0x24(%rbp),%edx

Code starting with the faulting instruction
===========================================
   0:	8b 40 18             	mov    0x18(%rax),%eax
   3:	e8 c1 3a de ff       	call   0xffffffffffde3ac9
   8:	84 c0                	test   %al,%al
   a:	0f 84 5f fe ff ff    	je     0xfffffffffffffe6f
  10:	8b 45 d8             	mov    -0x28(%rbp),%eax
  13:	8b 55 dc             	mov    -0x24(%rbp),%edx


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240527/202405271007.7e95eb21-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


