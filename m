Return-Path: <linux-fsdevel+bounces-41555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A09A31C59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 03:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AB162CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 02:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780891D7E37;
	Wed, 12 Feb 2025 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNcpafPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CC1D47AD;
	Wed, 12 Feb 2025 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328710; cv=fail; b=UywShjOclnlTbHUBV4xfK+Di2FpO6WunzUBqXRHcCYwkJ4yR9P4zb4Xk/YGHE7KHg3jKyXSULl4j11vrxw7ne+9OTKrIHRIQRWibQ+EKD6t/UdyThbcfBwp+UC6R1r9f+lDGcnS0/ivqXyP/P6TzhXbj9wdNkFa68BBQBtC8Aqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328710; c=relaxed/simple;
	bh=OHe6DhHOKDF3vmDl61oTVDxo33fQiS53wy88i7l0vHo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XnqZHzRf0U1Vfnt2QBPCTkLQhT8Immph6gUavYXC8w78qk3B5tNCc8GEv4XrL2NhzqN9rSQcc3fTLKm3fjw9Cz2FVv5E8krwBTY18XSUTmu80Uwf/+rGlBXAuSEGQYgZGiYLQXb5MEa3LS0FO27AOAqPrEqQjBgHOceDAhf/b9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNcpafPy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739328709; x=1770864709;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=OHe6DhHOKDF3vmDl61oTVDxo33fQiS53wy88i7l0vHo=;
  b=jNcpafPyKPKe1T9P32+vN4YmdbwOWwEyNhQgq9m/8Ks6Sn99tq/pj0mg
   gRbUTlfuHLgWIoWpbs2J2iguUzFoaHmNuWefZp899jt0+/ns5J+C02tQB
   bCnNVADfHsFgok5UwPbBdB4ilkdaKRdl5KA5s5vwgHIupST5KhkYf6FGq
   sT5B0NoZWJpCVHVY7PPrzVXAU0XGC0ETuX2S0RtAWUsY3zs2NxCMfEyP1
   W8AT5Xn7KzfXfO7a23q1gYCnE29Z+vre6EO09d5NqZHfmZXQXMqQnQj2l
   SLPEzrjgc0ENOUd23vlOMJ5UXyHP3izn+7vohq9W7rX/IAZZnFeyQWADo
   Q==;
X-CSE-ConnectionGUID: 58kFVDBsQX2+8ymZ3JWyig==
X-CSE-MsgGUID: n7Kz0++JSNW1u6VDRaLqPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40092947"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40092947"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:51:47 -0800
X-CSE-ConnectionGUID: wr1ZyT08TnakuDzZtECCjw==
X-CSE-MsgGUID: QbQ4U/uqSdW6wWDM47bZQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117710421"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 18:51:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 18:51:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 18:51:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 18:51:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGqHRw1rkSE9g1T5luRxqd+SvwP5wCozpNiDfZUDc44T77m06LDKx7XrUv2joZyu6sdoKlfTSU5QK6st+bnliEhwqsjDkSNm4LgimIyFOhbAfPl6xlLzDNH7UrJv8HF0a5N+hcvAHyKzHx3fcttQmd0H2thEjn98vSzoUj8js4ga3QZORiUNn/j1lykP3K7NCDzF2fGcF4QtJ84gtdeO2GrCB39Tc337OvxbCpyWNfre8j2vXwSoN0wUHDfhEFttzPt5AfMxseT8s/XClWymNgVRFtT6IARoUslZ6fbSMV/DnLBMqhljcXUffYhd4+O5MPPGIRSxdtGUh7LmOOi6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NujVCjvrn3Ckz49n+JRH1mcS7VoHxaKBzUDmxhLoV9Y=;
 b=YdvBRDXDAEeeaOnf0IY57dYn+3z1mGqxs6Toy5EIhquQtlIMBS1N+NNWX44/xv33OpzBo1mwFsSLyZDkwE/A6FgKCOS5p9hMNwjJmI4Ypi9XSJVt8Mjd48AnKP8tNy6ZO1C5Pi2uOIL0UNjvCi284QsaEyxq8Afe7STUnr896O7MyzLHxDAu7Bme2AhJj3yw+gdofkl+9Bs90rCtJ6NgyL3Ds8zeS7U/1Z0WkgOKzJ3bT+YjCEOhN9/9rfeTx1VbLSt01Xo4qsoU3ogL/ZKDFjrVmHLLJvTXm2h8F1vCec2NXKBXPkmfFPYVATWyduB3Cy8LyCsjOQkdCtvklZq9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8502.namprd11.prod.outlook.com (2603:10b6:510:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 02:50:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 02:50:56 +0000
Date: Wed, 12 Feb 2025 10:50:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: NeilBrown <neilb@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-cifs@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Kent Overstreet
	<kent.overstreet@linux.dev>, Trond Myklebust <trondmy@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, "Steve
 French" <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>, Eric Paris
	<eparis@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-bcachefs@vger.kernel.org>, <audit@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] VFS: add common error checks to
 lookup_one_qstr_excl()
Message-ID: <202502121009.f7bc8e67-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207034040.3402438-3-neilb@suse.de>
X-ClientProxiedBy: KL1P15301CA0063.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd3c174-ef29-4be4-db00-08dd4b1012cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GSWp05s1Tjo9RbP+uSWohBkZhTZRutKmKzGoP67jzLd24kJJ7Gv3EDXqXtcv?=
 =?us-ascii?Q?08c6EHscJP445KBRE4ja6L/pO47p4XSAWcPEuTLB0+heUZ02W02McuXROaeR?=
 =?us-ascii?Q?RjXkOl4UZPTfNVp6dCR3bBrVCtgFJ+A8mqJ+7XcwoRLweGWWFh14/QroRdS1?=
 =?us-ascii?Q?6K86/7GHiNHzccDjbLebRd4VWnPToJ1xtXOHKq8Qffdgvut6FJJVA03k5xYN?=
 =?us-ascii?Q?e8R48/Y3zAKh7ivbk4G39L3dK1e/GLC5GvgyaoFQai5tUmZxS0ZbCk62kkHE?=
 =?us-ascii?Q?nJ+jBrYFfbVzFRILvERioZEvx0x73IsL5w3DpFBjA01L239rkEePI5NJaUkj?=
 =?us-ascii?Q?wgKLXBvn42y3tOcaRyKTvoVDpr+Jw7wBHi15UAPGXVa3qB/ZFWCbGsL7iOTA?=
 =?us-ascii?Q?lfIiYUoZOEBK9vcR10v905tVuLKTZRgGh04V7bB91VYvrOXG0iuRucMWZDn4?=
 =?us-ascii?Q?lzJID8420jmt2G/qV8FdnkdH0DR81eQeVgw99Ch07sDEJzJeOOFV6sn1u1lj?=
 =?us-ascii?Q?OiyyzU1sRYXfvEH5Ngehqhn/D817q9xDvBy2W6tYV7s+qZOxCEwbmEC4bmdl?=
 =?us-ascii?Q?Vyx+uXyIRtfuUJPvTB7aP4yf65xNMr5z3ySrHFIFwt9pIb+WxCLjMgb6YQCy?=
 =?us-ascii?Q?QRXvI7tCnPZA042Veh8+/hZttvTeZmqYBUOZhvdY3Q//bGpLzZ9DIanS05Jb?=
 =?us-ascii?Q?fwvNnllq0+oTcTItCypmtn6qvXBwMpO5bvItIQMLffmmROcWkfMZDIOZNVWj?=
 =?us-ascii?Q?gaW/ac2YgYcHAqIfrRwxljAY5nPiwHDttcXqWWz8TQu575g5OEtmSeI7YA2H?=
 =?us-ascii?Q?UNJT3BDc3maeyJ0S/Jim+PCh+AiBv7bg1rJj4HwxcxwjJ2hf2fpJDAM6lKdX?=
 =?us-ascii?Q?ke+jY5dEkpi0JrqNPqPKD0VTSj2Mt3j2i5xpPUjS3gA3x5c1KKR4zt6O7ubs?=
 =?us-ascii?Q?o3qp8WNu1qW87yKqRp5za0dKZjQUCo0R+0loJBruXO3f9hJ66diroCCU7x1j?=
 =?us-ascii?Q?BGXZbLh1/NKchW7C/Be2ipwVOkpg41ysRalBVFpPeghTYuStz3+KMJeGiaQ+?=
 =?us-ascii?Q?ZGGLQtmGa+c0yd+zeBxUOSF1h3r/LgHDe9W8dEvLRxU/lbx7jK+PnO9am5dx?=
 =?us-ascii?Q?XmihEQqsYUxI4WBq0k/ouWbwj1tcHap+8q/Xr44CGeq0WXlZCwmub/N3kqN5?=
 =?us-ascii?Q?rQxQessgbSPXEu/RXSqd14k5D66LgFiVOPAu+91IYxxwoufgVy1DGNZl1vo5?=
 =?us-ascii?Q?5QlV0sM8DBSTgqaTEPBmSCxfBRknqQePThrwZ3sflWMF1qPZ2Xzqd+0h49bd?=
 =?us-ascii?Q?qNelKtb8TqG2zGYhuf9rhLiW9OKqftXjjvVQb7tBrPG7RQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VfXZ0ruhp3P4GM8L9NgfdMiv/rJbHvgnyyFyuR2QHI5iJFDjDmXX8ZUeK4vR?=
 =?us-ascii?Q?Ih4uANZKzClGHD4GZ6tpJ8GYTjEA3NlRSwjVI3MSIlPUu4iE6l2zG9+LX5k9?=
 =?us-ascii?Q?rDv4JFg8bVV22wN7+wQGTKucAW+Mu8c+cL18CosliR9pixFb8hELcRt66two?=
 =?us-ascii?Q?K8ciNOMJEtjxZtsCfMIREU9iP4jUqPecFFhnbImax44Zk1MYFNET2BLqCF5u?=
 =?us-ascii?Q?TDLy0xJTJb/Dz3MGjGBGMW4mNBPqU/NmVEJWtDNkpkUbe57BjJhJ7UaTtFOE?=
 =?us-ascii?Q?uk0mYVv9dtBkskPz429e7jqId08Hban4kwEIJpLeyLy6ApQuTsu++naWzMz0?=
 =?us-ascii?Q?hBUXdPvpDdBEZHtHeJ8w/ROZfZupprbV/U1DCeI1gfexM6OA+5RUyPSU9GuN?=
 =?us-ascii?Q?FgzlhB7qX3lbgIwGXSgmUFtXgb1pyfE8DKR6j+O6r36Lo4QiHOGfmitqhLIZ?=
 =?us-ascii?Q?rijJ79aK0+1jzqEBlMwjx1i4MRsIOjEaU5sI+ewvGimm5fzXPgwpgS8OkAFT?=
 =?us-ascii?Q?cXYEoIVsaKBUoxLqRXQNPmx0RUClUMpvUzlCMRlezxhxnN+iHzs9tLUP1B++?=
 =?us-ascii?Q?eKRydPMtgXhBOLsN+rWvTvOgOpH7ZA6QkeOD8fNy90v2+sywkTeWqPmTc6q6?=
 =?us-ascii?Q?Hg9BJmClzu6k6+3Vi4xnQRHhwOP6EJuq4T5HrcROTXywaSRyE4R4qZdoHHwV?=
 =?us-ascii?Q?ShWd3jHId7nBfg9gqyVhVeDpkt1UcVqXzsyl+CHWRm4pMBk2xkPlwiFNNzt7?=
 =?us-ascii?Q?rJa5/ob/3gqAmjt5FsPWINqyhC3mlZCxRSgV7lvCjnDwJaDayLTa32gmTHYF?=
 =?us-ascii?Q?pjhec8O7uHwj586xIHTeLeK+QWfiRHMBxesTH48Ap3ibB2G4gdz5mHz1EW+W?=
 =?us-ascii?Q?Aw/41veJwB4dDv6ad/uYT0Z9o/cvDPOebqyxvuGTUJ8Q4FqsmUk/077bCZbC?=
 =?us-ascii?Q?ePj5YoghDmnf5T1GWn8e6ak7TV2iENWsV1WV69A8WpiyB+06iTwfepINXrAa?=
 =?us-ascii?Q?ONQ3j8v3VjmnLtHa4fiFTAV1TCeLWcVJn8i2+gqZ3T7yHRbH6tlZw9+qT/Qw?=
 =?us-ascii?Q?DxwduOXFk+GLCCqlhpmbxXqqsI9fq72szVp1rZSb9YjKuCm4IqSo2luf387F?=
 =?us-ascii?Q?w9RGAMZvsRIBxnS1Ab1XrqEVKcy05uOQstUUxi1vHrC7fFWSWn4j9m6xMK31?=
 =?us-ascii?Q?IIdMwgZhk4AgzW84gw5GbdtertzwrNrYIxP9puFStTxjIqkeUDWi8wgfROB8?=
 =?us-ascii?Q?2XZSnDMJ58uF70PNoT+xEYytN4XT6JdROQG6BBqD3ADXXPG3j/JU3G2v4/eC?=
 =?us-ascii?Q?N1QJbvBLbQ/5fpQGUc5bJNl6FHR+v2wXR95IpsMFKkiYrI54VdrjKy8Mta2k?=
 =?us-ascii?Q?k01txsf/4xjirU2Tai/WP0/l3Zr6td6JGSVoe5k8lbl1XkM87sOYzjHDqX9M?=
 =?us-ascii?Q?tAXFyahJZJ9BaE3Amgm3uomSJKqJZkPYDinAX+H6XbK1kTaHbL9Ha0wgnLuK?=
 =?us-ascii?Q?YmJh5JERbXDE9KHHQmMP3y49VHxKtJeNt2jBehcsyxg3kBVtJp3MnXUrXnm2?=
 =?us-ascii?Q?aUw4BOaWbS38/oYAhniazhGsBEOYqZCdVWp4mVtbd165VayHunVGlVRkHT4N?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd3c174-ef29-4be4-db00-08dd4b1012cf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 02:50:56.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ebq7d849Z/fVNKcZ+KG4T9w3FVrRa0lEYBoYWvZPKuNMNvuhQlM/EtCrTTz6whv1bu1yDLAJA4Hy16z0iU5xpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8502
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: 9a292bc4cbb25ca84f90dbacdf3064a9d6e7804f ("[PATCH 2/2] VFS: add common error checks to lookup_one_qstr_excl()")
url: https://github.com/intel-lab-lkp/linux/commits/NeilBrown/VFS-change-kern_path_locked-and-user_path_locked_at-to-never-return-negative-dentry/20250207-185417
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20250207034040.3402438-3-neilb@suse.de/
patch subject: [PATCH 2/2] VFS: add common error checks to lookup_one_qstr_excl()

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



config: i386-randconfig-053-20250208
compiler: clang-19
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502121009.f7bc8e67-lkp@intel.com


[  163.118842][ T4188] BUG: unable to handle page fault for address: fffffffe
[  163.119485][ T4188] #PF: supervisor read access in kernel mode
[  163.120015][ T4188] #PF: error_code(0x0000) - not-present page
[  163.120523][ T4188] *pde = 026d3067 *pte = 00000000
[  163.120971][ T4188] Oops: Oops: 0000 [#1]
[  163.121339][ T4188] CPU: 0 UID: 65534 PID: 4188 Comm: trinity-c3 Tainted: G S                 6.14.0-rc1-00084-g9a292bc4cbb2 #1
[  163.122321][ T4188] Tainted: [S]=CPU_OUT_OF_SPEC
[  163.122717][ T4188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 163.123520][ T4188] EIP: lookup_one_qstr_excl (include/linux/dcache.h:416 include/linux/dcache.h:421 include/linux/dcache.h:467 fs/namei.c:1696) 
[ 163.123973][ T4188] Code: 5e 89 d8 89 fa e8 62 ed 00 00 85 c0 74 58 8b 7e 18 89 c2 89 f0 89 d6 8b 4d f0 ff 17 85 c0 75 4d 89 f0 8b 75 f0 b9 00 00 38 00 <23> 08 89 f2 81 e2 00 00 02 00 09 ca 74 13 f7 c6 00 00 04 00 74 17
All code
========
   0:	5e                   	pop    %rsi
   1:	89 d8                	mov    %ebx,%eax
   3:	89 fa                	mov    %edi,%edx
   5:	e8 62 ed 00 00       	call   0xed6c
   a:	85 c0                	test   %eax,%eax
   c:	74 58                	je     0x66
   e:	8b 7e 18             	mov    0x18(%rsi),%edi
  11:	89 c2                	mov    %eax,%edx
  13:	89 f0                	mov    %esi,%eax
  15:	89 d6                	mov    %edx,%esi
  17:	8b 4d f0             	mov    -0x10(%rbp),%ecx
  1a:	ff 17                	call   *(%rdi)
  1c:	85 c0                	test   %eax,%eax
  1e:	75 4d                	jne    0x6d
  20:	89 f0                	mov    %esi,%eax
  22:	8b 75 f0             	mov    -0x10(%rbp),%esi
  25:	b9 00 00 38 00       	mov    $0x380000,%ecx
  2a:*	23 08                	and    (%rax),%ecx		<-- trapping instruction
  2c:	89 f2                	mov    %esi,%edx
  2e:	81 e2 00 00 02 00    	and    $0x20000,%edx
  34:	09 ca                	or     %ecx,%edx
  36:	74 13                	je     0x4b
  38:	f7 c6 00 00 04 00    	test   $0x40000,%esi
  3e:	74 17                	je     0x57

Code starting with the faulting instruction
===========================================
   0:	23 08                	and    (%rax),%ecx
   2:	89 f2                	mov    %esi,%edx
   4:	81 e2 00 00 02 00    	and    $0x20000,%edx
   a:	09 ca                	or     %ecx,%edx
   c:	74 13                	je     0x21
   e:	f7 c6 00 00 04 00    	test   $0x40000,%esi
  14:	74 17                	je     0x2d
[  163.125537][ T4188] EAX: fffffffe EBX: c3e7e540 ECX: 00380000 EDX: 273874b2
[  163.126145][ T4188] ESI: 00060000 EDI: fffffffe EBP: ebef9ef4 ESP: ebef9edc
[  163.126716][ T4188] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
[  163.127324][ T4188] CR0: 80050033 CR2: fffffffe CR3: 2b2df000 CR4: 00040690
[  163.127872][ T4188] Call Trace:
[ 163.128178][ T4188] ? __die_body (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420) 
[ 163.128552][ T4188] ? __die (arch/x86/kernel/dumpstack.c:434) 
[ 163.128898][ T4188] ? page_fault_oops (arch/x86/mm/fault.c:710) 
[ 163.129329][ T4188] ? lock_acquire (kernel/locking/lockdep.c:5851) 
[ 163.129723][ T4188] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:737) 
[ 163.130222][ T4188] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:784) 
[ 163.130687][ T4188] ? bad_area_nosemaphore (arch/x86/mm/fault.c:833) 
[ 163.131129][ T4188] ? do_kern_addr_fault (arch/x86/mm/fault.c:1197) 
[ 163.131569][ T4188] ? exc_page_fault (arch/x86/mm/fault.c:1479) 
[ 163.132004][ T4188] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:4408) 
[ 163.132482][ T4188] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1493) 
[ 163.132999][ T4188] ? handle_exception (arch/x86/entry/entry_32.S:1048) 
[ 163.133429][ T4188] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1493) 
[ 163.133946][ T4188] ? lookup_one_qstr_excl (include/linux/dcache.h:416 include/linux/dcache.h:421 include/linux/dcache.h:467 fs/namei.c:1696) 
[ 163.134390][ T4188] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1493) 
[ 163.134919][ T4188] ? lookup_one_qstr_excl (include/linux/dcache.h:416 include/linux/dcache.h:421 include/linux/dcache.h:467 fs/namei.c:1696) 
[ 163.135354][ T4188] filename_create (include/linux/err.h:67 fs/namei.c:4091) 
[ 163.135763][ T4188] do_symlinkat (fs/namei.c:4676) 
[ 163.136166][ T4188] __ia32_sys_symlinkat (fs/namei.c:4696) 
[ 163.136593][ T4188] ia32_sys_call (arch/x86/entry/syscall_32.c:44) 
[ 163.136967][ T4188] __do_fast_syscall_32 (arch/x86/entry/common.c:?) 
[ 163.137377][ T4188] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 163.137774][ T4188] do_SYSENTER_32 (arch/x86/entry/common.c:449) 
[ 163.138146][ T4188] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[  163.138542][ T4188] EIP: 0xb7f61539
[ 163.138845][ T4188] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 0f 1f 00 58 b8 77 00 00 00 cd 80 90 0f 1f
All code
========
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	0f 1f 00             	nopl   (%rax)
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	0f                   	.byte 0xf
  3f:	1f                   	(bad)

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	0f 1f 00             	nopl   (%rax)
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	0f                   	.byte 0xf
  15:	1f                   	(bad)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250212/202502121009.f7bc8e67-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


