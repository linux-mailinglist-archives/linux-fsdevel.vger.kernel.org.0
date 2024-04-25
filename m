Return-Path: <linux-fsdevel+bounces-17787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BF8B2328
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A111C20E78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1031149E07;
	Thu, 25 Apr 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKf4TA7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3F12BE8C;
	Thu, 25 Apr 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053021; cv=fail; b=EGVagLc/HWbu6SanQISlMjNkyNMYPa/PTSqA0GprK5uIONkVJMOyousMgi8oeQL1ez5XZmcIdDkQrUzQjaOvJmo/+IPQWj/YNbpSF2+hYj1WeONZcjVvd+d87dvACCGEGSts30NtF4zpoX+gHepSagBRM5zgbnh7r82r1m2mGkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053021; c=relaxed/simple;
	bh=9c+TyxOUEiM/NrxBkykp/3M2DU+leDjgvt4AJRUEpnQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bAC/iDIZj1tzsHPx+S7sx5pjgwQf+e7o1ra24bCx5iKLl+dNy/rtR77pk6Kf8i8eM5R8mcuKgxhfnjOo1i24XFoejBhUYGoTZuta/JnOs06/4U5E0aTR79YIkGF2WwzievySSS0OcsXUnOWrPCYF9CAXYuN1XIG4oYAIwcwjTdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKf4TA7I; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714053019; x=1745589019;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=9c+TyxOUEiM/NrxBkykp/3M2DU+leDjgvt4AJRUEpnQ=;
  b=PKf4TA7IzIZ9O56jOo3laku8aurqmPHCt64yzBL5iUaHCOn3rXRk69LT
   XMY+DalVexrJOeWHJ/DPN8ul6rboM4iD0li5dtqN5JPMAevSh+IX1N81C
   EREm6DKRl+eVjZpr7HhcYkR5Um9fb3f5C+UGuytZFBJMzQHK+tx9sB19T
   8Cm7x3WFsJ+duturwPUHaHuFMnp8DscTnpIJO2Wcmu4yeR788BQpqE94C
   Mp4Mwgk+SUSIrYhgrRQXSJrD/b7RPnmM5I9NTil5bB2xDfUqBhBTlspLl
   cpZfqhaCLK+0FPdMC2ZDeMQYOFthuFTuEBmUGnp9Q+yWP7e6GmpfBeG+D
   Q==;
X-CSE-ConnectionGUID: HwpB1+DcTyW4HE4z6j9/Pw==
X-CSE-MsgGUID: 0ujmZUoeSvyeh/4OWzKeTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20353107"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="20353107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 06:50:18 -0700
X-CSE-ConnectionGUID: yyyupI4fS/WqBUq0CkEGfA==
X-CSE-MsgGUID: ShihJ3UARAW/ebpZdSv8gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25143909"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 06:50:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 06:50:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 06:50:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 06:50:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 06:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTonVOyy1IAIObD8ptfoo8+4b0Z+BsxA+4raIrCCMRPB4aiiOO6Nk9eYWqnOEH1bi1Zquss7s+g11VmbnHKR0ReV8X2xFV0o50aW1rRUZcPyKfObhlbwpOWXjgoQV00rpRX11tP6cyAv0sp194Ke9DqGNzbVbGXxbkZLt5+8ovBiFslSM+fBGQUCwMWJ3HLvrRZk/UVqqlt9yJUOg1W/PqZ+AfX8BzMNzx++qKbAEXA6MLTKliAEnPfe3pAMC88Nbd/T+b2ECW02D9lElpjUKQdtmLphBH4puPyx1C4ujnG3UT3GYHXRz0KH1N52yKQiz5lg90sedsugAXV+7DCNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nknNf/XsaeXzVWtdZoBiUUaCtvp6CbBd605CVL4r4YI=;
 b=QSy30B+gGI3D+BEuuX4mt2Dk++aRIJeimC83WlfOOrI5VdwczwXOVYBX8OvA3aB0A5abHNSLCSb2dBS+43E6t/2GeP9hM63jO4PEktNMuYuv6VGufMB72TiTfDhbLb8lV14/qDDqt493oImiTDnT9Ku/+OqogeTdKwcFPVzPlrnP2eg9NczcSt67bHxDTRmoeBzfVHmm8nio5TtH3wB0TnKxjUzkk1aKd/o4lXxU/23ey9j2HV0I+DIN74jo8t7/lC80u1RqiBkUNnjlUdJin37U9g8bwnxUHb4q3U1eQjnoVJI9yEuF29EOXz5TQy49gfs1hvsO/ThQxWjlKqZo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Thu, 25 Apr
 2024 13:50:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 13:50:15 +0000
Date: Thu, 25 Apr 2024 21:50:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Stas Sergeev <stsp2@yandex.ru>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Stefan Metzmacher
	<metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton
	<jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Alexander Aring
	<alex.aring@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian
 =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stas Sergeev
	<stsp2@yandex.ru>, David Laight <David.Laight@aculab.com>,
	<linux-api@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Message-ID: <202404252107.3c18eed2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424105248.189032-3-stsp2@yandex.ru>
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6a34a2-5b3f-4e1a-8dc6-08dc652ea2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4mBdbxtKwTUWbKWQkF3jSwqBS04Ua4XUQhcBhdRPpqmNeBFeOkRZhfZKEC0w?=
 =?us-ascii?Q?UMSC+wtmxud7LfNCMgnnPAeux3GzjYQ5GTF7Cj1LxRWi8WuWeQA/uuyy6X0X?=
 =?us-ascii?Q?LPaeqr8ahwT2U6GXgKvOS95wDvEcXGDEFyFeJHfyyJEBiSQGG/5jDfz5eaPE?=
 =?us-ascii?Q?ZT9MAHM1+B+juCJe/ZTVdHy82Hk7tgly9lCTJT2SdZodr9d3WjG/c3MJ6Od2?=
 =?us-ascii?Q?GjxoxsxFMIjpEeghaHtclaEfzJVG+zS0SaXUaZmTXkyaxZcFGe4njbndAY7Y?=
 =?us-ascii?Q?U2YumZmrPoiTxCx8hrsMQMecWQ594zKE1E3fMDCAb14G4zJh+uKgFs4daHHI?=
 =?us-ascii?Q?t2klvULcD8gmVLC/wFALB0VPZqVhpVW1oDXJAmCsovRkZ2vXxFUC0rb3Gr4Q?=
 =?us-ascii?Q?4eFJJ0u/9k4690uT1KXnhLFaY/Sdt4aVRQvEcZnqHU1X8V77+7M+MwXlUiLE?=
 =?us-ascii?Q?u4VuY/yhE7BXopvinzmfwDwM6EIxVMZa0eeg2t+1ZeGb0SQ1oa7uvHsUsto7?=
 =?us-ascii?Q?RK61iNmfKdHUnN0KC29tWTYYB2d3KqQ/QArCCFjvQZja9KNTtbagOsK53SlT?=
 =?us-ascii?Q?1Pyq4UE5Izcy+8BSfCnxrkffs+/mU0XpY19i7xlxfVU3ntAj1VUKBA3iso10?=
 =?us-ascii?Q?joR55fpSGb4v0epTwFmaFX5yPa7Y3kZJsblOo3YUSui9sw3roOyLoBSxlM+D?=
 =?us-ascii?Q?Soi5iGKj2nmxVCUZmJBUbfGUmDtLVoG0Q8CPTU6ue4jqrhL/9283kvVsnxsK?=
 =?us-ascii?Q?B8h4dp1LH5UCjEVdu480ZG4lNrluf60kbOTPSBttK+GqtOk73nVr25l7pMxT?=
 =?us-ascii?Q?HuiRxGsFHMgGVmKz/i1g2HbARVonH0QUNtYwFJKYt2L6ueiae7nw2DTaRdSc?=
 =?us-ascii?Q?VXbAWBv0yN//5KI6ioxpEtobCDbN3iBsBNEQxuc5KTsIgZCBkw6UQ3azm2iU?=
 =?us-ascii?Q?u3IYsXBxG6GjqDTgiPZTNmuV/bGOzr/blVUxS2INYogUeQc8okOJwOLBfigh?=
 =?us-ascii?Q?eBT/VZ4DVXT0eFJY/+izvK6I0f3RoIs9WqXZ1rYQVT5ozSHO0Um0sAFT8Qeb?=
 =?us-ascii?Q?9+92Q+BQOUVQ+8mTkbYb9m3K1lQqfvCpFRvnZTRvTQMEl2w2zODn8fkP2H3y?=
 =?us-ascii?Q?eU00dhllCISN2sCL2HppcXPqiKbUWVpdRRcU8wIIYj5GjkLmYVzTNlJzIpi6?=
 =?us-ascii?Q?+Fxo5VD8zNPYkvAne137CjO7SaIU2DzLGyxe+U2TwjcfVzbRRL3wEJn3FxM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMCS86YniZzxbRUzkDtA3ih1tN0EFBwTKDA3Wq8fJMq7qpAiUW/06nJxW4ti?=
 =?us-ascii?Q?jzBHtubkYYPg09hl5sUQrDH3HeenEqwxmSYUNQI0YNAFZBq7oXjHqeXxrMl6?=
 =?us-ascii?Q?WyN1Md+cjTEbQj0Gb0hgg0xY3zEtYvEjE1GSyNvAcOrmrE2e+xueDPCWBLVB?=
 =?us-ascii?Q?N/7oTLOcT+XanyWGlgUcvyDukixcehLvmLdEMka7OfrDoS9Xyj7TBrq7MHa/?=
 =?us-ascii?Q?rEXbovqwJjtTnGu2kC+m+XdhFA9eZwMfReEj1qE5ADL+npNVXNkorlMb6IzF?=
 =?us-ascii?Q?TUCPgvjPWpYe1p3pBo0LVCGq8CFAJoJIl32mtWXJi5q8rSSFDsJH6Kdw9GxM?=
 =?us-ascii?Q?yngQu18BhSn0AhG12yeAKGQJU1qgvLAuj9lzlfra+MKiEIa9zfZh+As9UFMz?=
 =?us-ascii?Q?vGQaGEEkK9/LtDtm3q1+JkHP0uaKNVdU+w8+A7Cb3F/yTylpCQzyakS4Fxd2?=
 =?us-ascii?Q?K3D7RDFlNsOO9mNBvBzgxMXJ8DU3QfPxM3Ju+qmLQlg95Eczwy087s/UDWmQ?=
 =?us-ascii?Q?DYYj12u/tMaHU5UzJqxy8tffSIieqKjr37nCk8CbbCCiqGyYZy3Z87C4nBqD?=
 =?us-ascii?Q?fCok+aVV7QUuy78hI9fsannIH79seodu7VAF/GE7CbSCXbSC82NSQ9jpxObV?=
 =?us-ascii?Q?O0UDR1OZvCss9H12DR5ZX/sYdrzlGMaMoaRp1jtCIzMmzHcTonzKquwQkhNP?=
 =?us-ascii?Q?F/8RFPkOoIHRltOkJGXpox2jJc3nqy0gQkqt78pLubOsDfszsebQBJoWaOr7?=
 =?us-ascii?Q?HcCE5RVztVJeg/S7P0rcTqAkGsyYYTxl2GO8SROt5UHFNafiipMETtjZEaHc?=
 =?us-ascii?Q?RZSD03BGVYeMneaZErABKgqO6m1RF/pq0D0QNFUpBjZmvCc/mXQr011+nmsH?=
 =?us-ascii?Q?VaNK68VhzjM0018S37lhfxXLkH6rnAyxerCBkdqNl4SjWz9aLhk4nM9L/5Ct?=
 =?us-ascii?Q?xQyueTvLnXv0on03O3o3hi3+rZT+oRXR+/y9j8Qpd5ToK7vwj8vfbI+EWGwG?=
 =?us-ascii?Q?EbUOxnvGjbk7CyQn0ifBSx1duqNMJ5ZRUn2TJYLsAYwZ6wCRFRSH0SLOU1sH?=
 =?us-ascii?Q?HV/aWuX5usP/prOw+s6zPB8bNbgBCAuUZnEBBedMSYeWN3XEipEXOocma0mV?=
 =?us-ascii?Q?ODa3CgNwMczp8Mfy9cTdCibSuPjEGDHnVaKosDDAhtGlmrC+5KZyVl7fkb4o?=
 =?us-ascii?Q?esM0F/TffLw5CDKTnLiggrJ3zMRFctShryLc5kVLyJAzoXTCSFKzOR8CVtxo?=
 =?us-ascii?Q?CokEWRGpJCd2DfUJ3qi6xR8QetkpymewZGItpHpSeHegolZTJC/JviEaACwN?=
 =?us-ascii?Q?VrOX/f6DzDt8KitXuz9mb8e55sf2zE2Oe4pvrKG8OtAcxpOXuQn91r8Jsp7p?=
 =?us-ascii?Q?WRkQ1a/vWq0q41h8eJZ9rH+e/ubbEPa6K2R1jgOxnWB1UJYimirF25bahOT8?=
 =?us-ascii?Q?i7ek+H4T32HJCZUj1LvDnQQmT2o0xIKwIGgYNuMZagsZk1PfMgoy7yfr5rm1?=
 =?us-ascii?Q?XD3mR7ILh10fsQ/3P/FCr0hl5UnQbb9uvQMQvsW1QtWm+VQDyK3h8hfVcEVZ?=
 =?us-ascii?Q?rVcVz5EBirEz/L/2ThJCpkwee1W2LsyzcMITXLMDSWinbvgKHQIdVtBgWBBI?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6a34a2-5b3f-4e1a-8dc6-08dc652ea2b3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 13:50:15.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwz4LoPm9t+XFgesftC2xA3h2723SfBpih8xaKO5yYoKjg/aHxaB7ZTu5pP46eAJW3fXNvZzqTDOKjk9AfkTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:wild-memory-access_in_terminate_walk" on:

commit: 97bb54b42b1d6150e9ae11a7bf7833ed9f8c471d ("[PATCH 2/2] openat2: add OA2_INHERIT_CRED flag")
url: https://github.com/intel-lab-lkp/linux/commits/Stas-Sergeev/fs-reorganize-path_openat/20240424-185527
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 9d1ddab261f3e2af7c384dc02238784ce0cf9f98
patch link: https://lore.kernel.org/all/20240424105248.189032-3-stsp2@yandex.ru/
patch subject: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------------------------+------------+------------+
|                                                                                       | 831d3c6cc6 | 97bb54b42b |
+---------------------------------------------------------------------------------------+------------+------------+
| BUG:KASAN:wild-memory-access_in_terminate_walk                                        | 0          | 12         |
| canonical_address#:#[##]                                                              | 0          | 12         |
| RIP:terminate_walk                                                                    | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception                                              | 0          | 12         |
+---------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404252107.3c18eed2-lkp@intel.com


[ 2.555857][ T16] BUG: KASAN: wild-memory-access in terminate_walk (include/linux/instrumented.h:? include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/namei.c:702) 
[    2.556181][   T16] Write of size 4 at addr aaaaaaaaaaaaaaaa by task kdevtmpfs/16
[    2.556181][   T16]
[    2.556181][   T16] CPU: 0 PID: 16 Comm: kdevtmpfs Tainted: G                T  6.9.0-rc5-00038-g97bb54b42b1d #1 c90cc2d91176f38ca16e85ead0a72934082854cd
[    2.556181][   T16] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.556181][   T16] Call Trace:
[    2.556181][   T16]  <TASK>
[ 2.556181][ T16] dump_stack_lvl (lib/dump_stack.c:116) 
[ 2.556181][ T16] print_report (mm/kasan/report.c:?) 
[ 2.556181][ T16] ? kasan_report (mm/kasan/report.c:214 mm/kasan/report.c:590) 
[ 2.556181][ T16] ? terminate_walk (include/linux/instrumented.h:? include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/namei.c:702) 
[ 2.556181][ T16] kasan_report (mm/kasan/report.c:603) 
[ 2.556181][ T16] ? terminate_walk (include/linux/instrumented.h:? include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/namei.c:702) 
[ 2.556181][ T16] kasan_check_range (mm/kasan/generic.c:?) 
[ 2.556181][ T16] terminate_walk (include/linux/instrumented.h:? include/linux/atomic/atomic-instrumented.h:400 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/namei.c:702) 
[ 2.556181][ T16] path_lookupat (fs/namei.c:2515) 
[ 2.556181][ T16] filename_lookup (fs/namei.c:2526) 
[ 2.556181][ T16] kern_path (fs/namei.c:2634) 
[ 2.556181][ T16] init_mount (fs/init.c:22) 
[ 2.556181][ T16] devtmpfs_setup (drivers/base/devtmpfs.c:419) 
[ 2.556181][ T16] devtmpfsd (drivers/base/devtmpfs.c:436) 
[ 2.556181][ T16] kthread (kernel/kthread.c:390) 
[ 2.556181][ T16] ? vclkdev_alloc (drivers/base/devtmpfs.c:435) 
[ 2.556181][ T16] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 2.556181][ T16] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 2.556181][ T16] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 2.556181][ T16] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    2.556181][   T16]  </TASK>
[    2.556181][   T16] ==================================================================
[    2.556184][   T16] Disabling lock debugging due to kernel taint
[    2.556901][   T16] general protection fault, probably for non-canonical address 0xaaaaaaaaaaaaaaaa: 0000 [#1] KASAN PTI
[    2.558131][   T16] CPU: 0 PID: 16 Comm: kdevtmpfs Tainted: G    B           T  6.9.0-rc5-00038-g97bb54b42b1d #1 c90cc2d91176f38ca16e85ead0a72934082854cd
[    2.559653][   T16] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2.560181][ T16] RIP: 0010:terminate_walk (arch/x86/include/asm/atomic.h:103 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/namei.c:702) 
[ 2.560181][ T16] Code: 03 43 80 3c 2e 00 74 08 4c 89 ff e8 01 61 f4 ff 49 8b 1f 48 85 db 74 41 48 89 df be 04 00 00 00 e8 dc 61 f4 ff b8 ff ff ff ff <0f> c1 03 83 f8 01 75 25 43 80 3c 2e 00 74 08 4c 89 ff e8 d0 60 f4
All code
========
   0:	03 43 80             	add    -0x80(%rbx),%eax
   3:	3c 2e                	cmp    $0x2e,%al
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 ff                	mov    %edi,%edi
   b:	e8 01 61 f4 ff       	call   0xfffffffffff46111
  10:	49 8b 1f             	mov    (%r15),%rbx
  13:	48 85 db             	test   %rbx,%rbx
  16:	74 41                	je     0x59
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	be 04 00 00 00       	mov    $0x4,%esi
  20:	e8 dc 61 f4 ff       	call   0xfffffffffff46201
  25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2a:*	0f c1 03             	xadd   %eax,(%rbx)		<-- trapping instruction
  2d:	83 f8 01             	cmp    $0x1,%eax
  30:	75 25                	jne    0x57
  32:	43 80 3c 2e 00       	cmpb   $0x0,(%r14,%r13,1)
  37:	74 08                	je     0x41
  39:	4c 89 ff             	mov    %r15,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	d0 60 f4             	shlb   -0xc(%rax)

Code starting with the faulting instruction
===========================================
   0:	0f c1 03             	xadd   %eax,(%rbx)
   3:	83 f8 01             	cmp    $0x1,%eax
   6:	75 25                	jne    0x2d
   8:	43 80 3c 2e 00       	cmpb   $0x0,(%r14,%r13,1)
   d:	74 08                	je     0x17
   f:	4c 89 ff             	mov    %r15,%rdi
  12:	e8                   	.byte 0xe8
  13:	d0 60 f4             	shlb   -0xc(%rax)
[    2.560181][   T16] RSP: 0000:ffffc9000010fc40 EFLAGS: 00010246
[    2.560181][   T16] RAX: 00000000ffffffff RBX: aaaaaaaaaaaaaaaa RCX: ffffffff811e4a0f
[    2.560181][   T16] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff8792adc0
[    2.560181][   T16] RBP: 0000000000000011 R08: ffffffff8792adc7 R09: 1ffffffff0f255b8
[    2.560181][   T16] R10: dffffc0000000000 R11: fffffbfff0f255b9 R12: 1ffff92000021fc4
[    2.560181][   T16] R13: dffffc0000000000 R14: 1ffff92000021fc1 R15: ffffc9000010fe08
[    2.560181][   T16] FS:  0000000000000000(0000) GS:ffffffff878dc000(0000) knlGS:0000000000000000
[    2.560181][   T16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.560181][   T16] CR2: ffff88843ffff000 CR3: 000000000789c000 CR4: 00000000000406f0
[    2.560181][   T16] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.560181][   T16] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.560181][   T16] Call Trace:
[    2.560181][   T16]  <TASK>
[ 2.560181][ T16] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 2.560181][ T16] ? die_addr (arch/x86/kernel/dumpstack.c:?) 
[ 2.560181][ T16] ? exc_general_protection (arch/x86/kernel/traps.c:?) 
[ 2.560181][ T16] ? end_report (arch/x86/include/asm/current.h:49 mm/kasan/report.c:240) 
[ 2.560181][ T16] ? asm_exc_general_protection (arch/x86/include/asm/idtentry.h:617) 
[ 2.560181][ T16] ? add_taint (arch/x86/include/asm/bitops.h:60 include/asm-generic/bitops/instrumented-atomic.h:29 kernel/panic.c:555) 
[ 2.560181][ T16] ? terminate_walk (arch/x86/include/asm/atomic.h:103 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/namei.c:702) 
[ 2.560181][ T16] path_lookupat (fs/namei.c:2515) 
[ 2.560181][ T16] filename_lookup (fs/namei.c:2526) 
[ 2.560181][ T16] kern_path (fs/namei.c:2634) 
[ 2.560181][ T16] init_mount (fs/init.c:22) 
[ 2.560181][ T16] devtmpfs_setup (drivers/base/devtmpfs.c:419) 
[ 2.560181][ T16] devtmpfsd (drivers/base/devtmpfs.c:436) 
[ 2.560181][ T16] kthread (kernel/kthread.c:390) 
[ 2.560181][ T16] ? vclkdev_alloc (drivers/base/devtmpfs.c:435) 
[ 2.560181][ T16] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 2.560181][ T16] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 2.560181][ T16] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 2.560181][ T16] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    2.560181][   T16]  </TASK>
[    2.560181][   T16] Modules linked in:
[    2.560183][   T16] ---[ end trace 0000000000000000 ]---
[ 2.560820][ T16] RIP: 0010:terminate_walk (arch/x86/include/asm/atomic.h:103 include/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instrumented.h:401 include/linux/refcount.h:264 include/linux/refcount.h:307 include/linux/refcount.h:325 fs/namei.c:702) 
[ 2.561462][ T16] Code: 03 43 80 3c 2e 00 74 08 4c 89 ff e8 01 61 f4 ff 49 8b 1f 48 85 db 74 41 48 89 df be 04 00 00 00 e8 dc 61 f4 ff b8 ff ff ff ff <0f> c1 03 83 f8 01 75 25 43 80 3c 2e 00 74 08 4c 89 ff e8 d0 60 f4
All code
========
   0:	03 43 80             	add    -0x80(%rbx),%eax
   3:	3c 2e                	cmp    $0x2e,%al
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 ff                	mov    %edi,%edi
   b:	e8 01 61 f4 ff       	call   0xfffffffffff46111
  10:	49 8b 1f             	mov    (%r15),%rbx
  13:	48 85 db             	test   %rbx,%rbx
  16:	74 41                	je     0x59
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	be 04 00 00 00       	mov    $0x4,%esi
  20:	e8 dc 61 f4 ff       	call   0xfffffffffff46201
  25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2a:*	0f c1 03             	xadd   %eax,(%rbx)		<-- trapping instruction
  2d:	83 f8 01             	cmp    $0x1,%eax
  30:	75 25                	jne    0x57
  32:	43 80 3c 2e 00       	cmpb   $0x0,(%r14,%r13,1)
  37:	74 08                	je     0x41
  39:	4c 89 ff             	mov    %r15,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	d0 60 f4             	shlb   -0xc(%rax)

Code starting with the faulting instruction
===========================================
   0:	0f c1 03             	xadd   %eax,(%rbx)
   3:	83 f8 01             	cmp    $0x1,%eax
   6:	75 25                	jne    0x2d
   8:	43 80 3c 2e 00       	cmpb   $0x0,(%r14,%r13,1)
   d:	74 08                	je     0x17
   f:	4c 89 ff             	mov    %r15,%rdi
  12:	e8                   	.byte 0xe8
  13:	d0 60 f4             	shlb   -0xc(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240425/202404252107.3c18eed2-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


