Return-Path: <linux-fsdevel+bounces-75810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN5DAaGAemmc7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:33:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763B9A9232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE1583009F09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06BB337689;
	Wed, 28 Jan 2026 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GB3Slc7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA062D6E75;
	Wed, 28 Jan 2026 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635991; cv=fail; b=CJjWpPsyST48MYoi2MYWzKe3IfxpjFQBDq9ArTprghyA2TD1tahNfA4igKFMiVoMJHv0hun/HwZpI/eWI3LC5AB6CAqG9/9nPD3RSCHHC1i9HnhcdhJLnvPmK8btQ6iIYhj5wTaXap5N1b1rLzYrZk5d3S8k+8CwusnRLXMtIwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635991; c=relaxed/simple;
	bh=ljSHahchgQ3KTZv74dZ3FJ+QyqI7kCxQYhRa5YqeDXM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ANPWMsFl/m6GIp2OYddPNaetG/n02SRBDJ2B5Mmk5SBpxfzAsErPUrJPFAfFLCXFx6rXTVSYpx+pXm2HajU/6YvQU5FtFCERnTztLcLjEmvOD/lwcL0HsKBnI21/H9KpXQUYJ+W1HvrY0/zfOsntgIGV1yV7o4K9kP+4Fg3a8vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GB3Slc7G; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769635990; x=1801171990;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ljSHahchgQ3KTZv74dZ3FJ+QyqI7kCxQYhRa5YqeDXM=;
  b=GB3Slc7GSZ8q89/oHrIzuuZ3O2AsZkS0J6XufNNj7zXNnK4L0QMgv11A
   wqXsFe7ABitG+K/x+syIM0/KI+Q7vVTfxFn98shh7772ShHC/Mx1LCeUq
   vdUvem5A+ecy9oWpUAuexIhn3EGBxIFWTNMnmeKZMTwjjoVtUwNwGeFAN
   TkKyCE+7M59bpATCf55WXtIxENf1KzWQ6AR0a1PCbarUY18t+sPpNRAtJ
   A2he7DGmlxGgdH9N9aY+leaDZnWofi/xECeFdzdIFrPlrdUJnDwwRQhrs
   nxfeVwtTV0zYLXIIfavYMSfGcajiQeK1YkOKsPASKpCDZKJ79cCdQZ2MN
   Q==;
X-CSE-ConnectionGUID: F/IVZPMySc6RbsMbclT5Pg==
X-CSE-MsgGUID: pkITuNBYTk6wXG12p62Icg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74723903"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="74723903"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:33:09 -0800
X-CSE-ConnectionGUID: 7A9OQbvHTPuLZWN2LSHm+Q==
X-CSE-MsgGUID: BiNxPchGStuhugZKWJ8K5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208619104"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:33:08 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:33:07 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 13:33:07 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:33:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWRrpRuLybaSCr9Do/AoBHTQt2bmA6t5OqpBU3+i4sew5CpZKX/twEXj6riXEDKLheeTNsBRDFX2E52KGqk7HRLqSIICcvQ9WsUHcGz/i5Mkf/kRpMHJ+j0lTz9b9/AYKyoHbDMFgr5wCqXPBwFCG6w3eQjXeCgnMXDhoEVEfyClLQbrmsEELSbV74/2xyzv0P+Lam4pJ/5E1P8n1kIfMRGrrzLwd4ZoqoyHnt2yRBJphQjQMN0qbsW4os16x3sSdYWyxyWfL2gq6qm3z7rLNJ8YQc9BBINd2GUnx1WG8fUsqgCMGDJsEbwP1TCTl+1UGnv3/qSC3iKXPBsq12gAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljSHahchgQ3KTZv74dZ3FJ+QyqI7kCxQYhRa5YqeDXM=;
 b=fTn4+dMaivPAxEJjlrfOaA39mtlrToODgPVQLRI/V78mwFjMAz0uSGi3+iIQzgiFL4l53KOVDVd4vuYjDucNgziYJWEFBTd/ySjBRxF6l7MjKpplt688dFatx7+6xHG7Yl4KEiarlve0kfnJaHpRiug9qTe55Jgs3S+tXivbs31q8nWA2Vsi15tgFScEHSfVua0aufrEwaZbLSbv2s/lUv6HAYaYkDLFtV22DnGQJbsG/NjM+hKzl1xof0Z3Tnnt531tNPxlR0OGTL8RKZeSZnnlQYaBjzYnKaoXIB8XJ2pZ3gEETMdLukojlOh2pGzRXLP977D9VpbCL1KxNXRlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6448.namprd11.prod.outlook.com (2603:10b6:8:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 21:33:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 21:33:04 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 13:33:02 -0800
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Message-ID: <697a808e8f420_30951005e@dwillia2-mobl4.notmuch>
In-Reply-To: <cd63a6b8-94f1-436e-bb5b-fd8de1074def@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-5-Smita.KoralahalliChannabasappa@amd.com>
 <697935261679_1d33100de@dwillia2-mobl4.notmuch>
 <cd63a6b8-94f1-436e-bb5b-fd8de1074def@amd.com>
Subject: Re: [PATCH v5 4/7] cxl/region: Add helper to check Soft Reserved
 containment by CXL regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0f5d22-3e11-45e9-6955-08de5eb4d1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmhqZWRzc2F1bTIzUTVHcDVSWE5UenRYeU9XVmJoUzJXdS9VUDh5Q0svZmJr?=
 =?utf-8?B?REtudzRHa3YvdG00Um93dEVCRGZmWGxBbVk0MjdtZElkd2lsd2c5QXROY2tJ?=
 =?utf-8?B?RW1QVzVzRnVURzJVeWtpWk42UENhM1JBRW5VbjVKU1VVVXdjWHFwanQybGRO?=
 =?utf-8?B?cG81MjM1NGNuamRhWTVMZDdnTDV2aHBLVkVHbitOTjdVdjE5KzNnMDd2U2lR?=
 =?utf-8?B?UnpYZHNGZUw1bVVBeU9pN0JjZTJsSS9jb0dwMmZsY2RQN0xPL1FvVTNtdUxC?=
 =?utf-8?B?R25rVG4yQXlsYUVLQmE5dzcwUmJZUFlSNTRmQWhwWlg3aTBXd0F4eWUxUDBM?=
 =?utf-8?B?bmtJZW5ndG5kbVM0cHNjcVlYemdraEJJUnRhbkkzaHFHNXVxNHp5LzNNUDEy?=
 =?utf-8?B?cWFXa1hkdXRaN3JWTWp2NHRFMHZVd3BtRXFCM2NURDlmN2p3WlNiWlhRVStu?=
 =?utf-8?B?TitYOWFselkvb01lWEJnQ3QvK3MvcklvVVF2TFZzRDNzSDZtRTlBRldKWmdF?=
 =?utf-8?B?N1o4S3VSN1F3R2RZb2MrRW9mZ2I3SjRQRkZXdE1EVHRGSGFOaUJHa3RsYU1o?=
 =?utf-8?B?VkFqUm4wWEdKQ0Eralg4SlU4RG5OSFI4Y3UydzdnVGwvTGpIWmdHNW5vSzhq?=
 =?utf-8?B?Y3llMjA4cWlFWlhKcGQ1Zk5aNzF5Q1VucUhvTXp0em1mN3JFLzlkOUVMNitC?=
 =?utf-8?B?V3crOW8wU0ZtWDVwaXA4djN6VUlTUTQwZFdXQUtFZDVyVEs2dnFEM2RveEpR?=
 =?utf-8?B?VUl1YUF5NGU1aDVha0FCMGh1UlpHQkVsM2NlSTg1L0FMaFJ5WnRLalovU2hB?=
 =?utf-8?B?bTZzRHVUREZ6YjhhaW5JalpqSUxma2RlRiszak5PNDFUK01aNlNnRUFzTlVY?=
 =?utf-8?B?QmdWZi9DWnpIbHBQSHJpL0RUVTRHRm9qZ2xDTnFrQWRlbGxQUStCekxqUHZG?=
 =?utf-8?B?UnZFdWxza2RPaUhSOWpadHhUM0VEQ3Raa25kejlTMm43YWs2cmlxWDNIcG1S?=
 =?utf-8?B?T1RJN2NqS3YxOUlnSkNzTm9CRFRQRjcyc01QZ0pRQmVzblpRMmU4TzJzczlQ?=
 =?utf-8?B?blV0WTFsTklPb2xJTGRiL3diVWtZbUd3d0hrdlhXa2FKZmF2RW9mUFp5SUlq?=
 =?utf-8?B?RndXdUpPRmQ5N1BxVFlqRnZVbkVpVnFEKysrd3ljTEZQZUVvek81OXhtQkg2?=
 =?utf-8?B?Zk5rN1g4dEs2dGxpNk9ieEw5eTVYdk0wUVlhR0w5TmJLdmVwWURNa2dXMVIy?=
 =?utf-8?B?SDJjdnd5YkdzQi9tbzZXcWNKMUZRRGUzakJDWXNWYm5zVklOenBnOUttS3Vr?=
 =?utf-8?B?bWZuTzVtZytyNW41QU1TM1A5TTRyZXo1K2FjSUxGcDNHc1JvZE0vT0RYTDht?=
 =?utf-8?B?bFNZQXFXbTV3T2RYTVRYdTFtNHVPNUhEdDNyclhraENpT2NqK3BMRjRyT1RK?=
 =?utf-8?B?b2s4Q3llSTVySjM0R1RSTUJ2cGZhUkhjVHhkbVdkYkhpaXJCNENaZ1VjcWJa?=
 =?utf-8?B?QVlQTWlSSGVmblg2N05VKzZ6ZUVYOWtRTTkwUjVQNWV6SHpsWVNpK1JFR2Fj?=
 =?utf-8?B?MmVaR2dRd0RFRmtPVlFKdjBqd3FRWkZzQ3NiMnBZbkFLVFl2VjdwWXVTRmlM?=
 =?utf-8?B?dzdOTS9LWTBuWmVRZnpnejluMzZ2Y1dkeldlcFNkdFZhcVRUSVBySFFPOTNj?=
 =?utf-8?B?VG53bUhPQjNoSzFLRXY4VHpIVU40VGdZc1pTU2t5UGp2RkxTbEluL2g0MWEr?=
 =?utf-8?B?YUhONk9GblpPTDdFZG83Ujloam15UUJPUGE3a2xqTEFzQ1QwLzVjU1V5RDNs?=
 =?utf-8?B?dzhUaGZWU2FQUHJZUytQRG5wWTFYS1cyTk15L2E5eXo0emxoV3dMR2hHc3Vn?=
 =?utf-8?B?UElxU0l0bS9vL2I3MXJRZkh4U1JneERYZHYzTmFnZkZlNDBmbmZzWWJBalVQ?=
 =?utf-8?B?UVBHUDJJejE5b1RZZWxTUWJGek54aEJnUTM3TDljdVJWUzMwR0h0NkpCRVAx?=
 =?utf-8?B?YUZHNlRyaittUjZWMEZuOXpXbFRRM1c5TW4yQkFsOUNWVElYanVYSVBrVnd4?=
 =?utf-8?B?d0lPSklMUkorQTVxeFRHdmdJVHVTaThkT3hRcWJOOHVyTXRmRWZSVDdCT0Vn?=
 =?utf-8?Q?kyt0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2k3SlExaE5zL0k0WlU3bWdaZitIRGFjMUNOTkF4TFU4bzYrZFdBdVV2Zjls?=
 =?utf-8?B?OGZQWTFqYkw3WGhSSGJVZitPZm9aMmEwZmdXcXIyOXNGVEloNmtQTmJGWHpo?=
 =?utf-8?B?ckFWRlVBckVuTGMxcVJZWGp3TEVnRVdvdWh5VmJKWW0vTVNzQjdlQTEyYU9X?=
 =?utf-8?B?VTV1dHNQOHZJLzdLZVJTVGNBUDN3UG9OMjlUUUVQMzlXWDRSZEZ1TithYjJN?=
 =?utf-8?B?WWhuZFFVVFZ5L2F2YjdDRnFWanFDdTFnMzBwMEZrbjNqMUpjd0FLa2FnK2Nt?=
 =?utf-8?B?eEZsZ05aRmZzMEtSdFhWV3ZuUmlheFJ0SkZDVTNCUU91VHBMY29kQzJ5RitW?=
 =?utf-8?B?WmY3VUdVaDJVd0JzM1l5NEp6RlBjbXQvT1RrTFZuMUl2ODBxVVE0b2pkaHg5?=
 =?utf-8?B?akgxSGoyRzdTMWRLN1VhYVJTTCtzNXhaeC9mTTNaVEc4Y2tuQTllTmEwUlFR?=
 =?utf-8?B?bUp4aUpuRUZUUXIyMEc2UmdYb1VpZDlPZDFpZVlxaFAvWCthN0JGNDBjUW54?=
 =?utf-8?B?OTJTYmY5WW5XS21iU1MzcDh6ZGRXeXpidnBKOTFJdW91TXhiY0V6cVpaMHRS?=
 =?utf-8?B?OUJIWGZPN05GWEFCeG1rQk5XK3hadXZzL0pyakFzVWx4K2lsTUpvTGVFOE42?=
 =?utf-8?B?SlV6bGJXVWZXeElEMUdvaTdaWFVoR2RJNkV4YmNJemF3MFZYWVBYUHZkNVlD?=
 =?utf-8?B?V25Nc2FucU9oU3NtcW1CSktJK2lBLzY5SVU3T3pSSGVGcDBiUXBsT25mOHJV?=
 =?utf-8?B?WTRzNjJ0Q2FuOVdsTXhmalltbDZpc2Nqb2NRZndxRVc0aHRlSk5TeGt6WS9W?=
 =?utf-8?B?OXlONFZ6M2lDUjhIQUFhbHBxRkFCWHNVZXpkSGlDNjg4Z01jQXQxREJXYkxT?=
 =?utf-8?B?TkVxeG9vWE1UNUdhRVFIVmdLQjBzMGZlKytjUk56WGhvKzZ0N294Wll0ZjZk?=
 =?utf-8?B?MExjMkJQZWxTdHlSbUE5WUt2Um5sejF2eWd2Slgxcm16WlJTTkljVHhSZElX?=
 =?utf-8?B?SWlXRGZacmZNeUFkTGtrZkR6bW54RXhnZjRzQ2xHYXU3R1ZjSnZtdUtXSTNZ?=
 =?utf-8?B?QlNBV0RyNU8xUmpmZE8zdUpyeHVMOUFVY2o2KzF3ejk5Y0YzNEcwVDBZR04y?=
 =?utf-8?B?aStVLzUvbkFDaFZFNTJzUEJWQ08vQm9ORlFKMy9uOWlORXRhN3FibjJEekcr?=
 =?utf-8?B?ZUlKK2M0TE5rQTVYU1ZySFhPMnk3eTJ2cVZWMEduTnY4cVV5UmdkTGt3WVFG?=
 =?utf-8?B?QjI4QmhOVnp1dE1BcnhzSWQxNytwTktJRE41SnQzNnRhNGRaUU1vL0sva0pz?=
 =?utf-8?B?RVk0Wk1IWitGb1JLYXAzOXNOa0dNWmZrTVFCT2pmVHRoUGpMTGIxS2tGbnZ0?=
 =?utf-8?B?by8vZ3pWckdwS0ttNStYMXVLVHhjWG1hdjB0YlZmZlJ0WWtMR2MyMDJzSUZt?=
 =?utf-8?B?WTYwd09URUxIbXZsZ2dDU3Y0OXVQR2Z0RDRRRnF3Um41bzlqVGJXWEdhOW9U?=
 =?utf-8?B?UDc4Q0pCNFNodXhEeGt4WXFRZ0pLVnBqL2JjZ292V0I2NDBjOVlMWFVnSXhw?=
 =?utf-8?B?alg2dVMwZWFyZkNQcDQvRHluNUExN0NVM1AvbXh6WG9rRHowMHN2eUMvUUdB?=
 =?utf-8?B?Z1BScll6bktjY0Eya0Y1SnIxMnArcytSWnJNT2FNajNybHRBZWwwb3Q3RDJy?=
 =?utf-8?B?SUtMWFNJRVRoWjNDSC9WdVZsNkFIWkJhZTE3bWo1Y04raEgzVVdLejRIdVNK?=
 =?utf-8?B?bTZwbEhac2NCbStWa2UyRmZmQ2RuV3NUQ2Nxa2g3NFNZMzgyMXd1dW5WM0VZ?=
 =?utf-8?B?NnhHRFg2R2JjYm1lT0FPM1Q1WlVOcDBuZk5Oa1RUUUlYNTkwMDJFSVFYelNW?=
 =?utf-8?B?eXRzenFuc1JRWk1oV1ZkdlBJTVdLdjRQaFF3UXBNRGxqUnVBM1hjcjl4VVA3?=
 =?utf-8?B?cWloN3dQVmIwRDJJWEdselE3Rnl3SmdQMTRSZUg4VVBIRE9rd1YzWVdveWNk?=
 =?utf-8?B?QjIzK3J1Qms0N3JBakJNK1QwWkllR2ZEWWxyc2NoMlJpZTVzRXNYTnAxNkhI?=
 =?utf-8?B?MnlDZWJ3bjY3dktST3lwc3plR0Q4VXBUMUtSVFdkc0c0Qk0yY0hpdCtZVHRa?=
 =?utf-8?B?OVM1Umd6ZzdzK2lsbmQvejROS0E2ejRiWEtJYXY3dG5wejFTZTJ4UnpKZi90?=
 =?utf-8?B?YXY5TkdGa3I5NHZtOE04ZWQ2TzdRekJmb2Z5SWJ4NDYwOHJDRGp2RWM5OTJ0?=
 =?utf-8?B?RCtERk93M21GdkkyOFhIY0VmWW56TXFtNXpwYTVhR3hFdGd3aXNIUnNnQW12?=
 =?utf-8?B?VEcrOTVJWlNxbi9GcDE2YjByTUJaT3hHZ1BlMHdueWcwazkzbzJIeW51SUcw?=
 =?utf-8?Q?ZXu3w0LYLgG86QDA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0f5d22-3e11-45e9-6955-08de5eb4d1bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:33:04.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YytdDDiiCpm79nMYTwH0RscQ7TU2p2+oMTyE8n9jfDbCxMoF1eQyo97uA/44sND1/1TF2Y4lxElN1ebMlLraHbqZb5UdhOfbKF8oTAR+qlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6448
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-75810-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dwillia2-mobl4.notmuch:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 763B9A9232
X-Rspamd-Action: no action

Koralahalli Channabasappa, Smita wrote:
[..]
> > There is also the problem with the fact that firmware does not
> > necessarily need to split memory map entries on region boundaries. That
> > gets slightly better if this @res argument is the range boundary that
> > has been adjusted by HMAT, but still not a guarantee per the spec.
>=20
> Hmm, My reading of your earlier guidance was that this logic is meant to=
=20
> be coarse, and is acceptable to fall back to HMEM if firmware=20
> descriptions don=E2=80=99t line up cleanly.
>=20
> If firmware takes liberties and publishes ranges that don=E2=80=99t neatl=
y=20
> contain inside a committed region resource, my assumption was that=20
> failing the containment check and falling back is acceptable.
>=20
> However, given that the SR ranges HMEM walks are already filtered by=20
> ACPI HMAT, and that there is a relatively low likelihood that a single=20
> HMAT range spans multiple committed CXL regions, it would be sufficient=20
> to treat any overlap with a committed region as acceptable?

Oh, am I reading the polarity wrong...? /me reads patch 6.

Yes, I was missing that cxl_contains_soft_reserve() is doing an
"overlap" check and then cxl_region_contains_soft_reserve() is making
sure it lines up exactly.

So yes, the way you have it matches what I expected and I was confused
reading patch 4 in isolation.

I think cxl_contains_soft_reserve() might want to be named differently
since it is validating that any overlap is precisely contained. Perhaps
soft_reserve_has_cxl_match()?=

