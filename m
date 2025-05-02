Return-Path: <linux-fsdevel+bounces-47888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D73AA69C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 06:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA1A9A10C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 04:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586941A23A5;
	Fri,  2 May 2025 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PC2KTLga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FC18BBAE;
	Fri,  2 May 2025 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746159914; cv=fail; b=TFg2QCo8kzFzAhLOTlKy8p1bcLOO1UI5YFeYsTJc776tKS9shzjy4WTu+sS6FP0csM+bwmiK5ihMoGfy39Tie9/feWGpn23ANaBhML5v4RGC6sb1lXTyGDF1EY2KtNjgOjFORZAoY16CfSz3FsKmnLZ/YDyUUMaljHnm/Xa+JHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746159914; c=relaxed/simple;
	bh=eDrh1VZMFB4KfQkANGrLm4puPyITD5cMi5irvpmJbYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mRJBRGwRSXRZb+DlLes5viq/9nAZoSoZl3eTl7NnZ9a9zdJ1FvubBw78SNl1dvPn2P0xTqY4BcJYmHSTt7j3ZEi17aUOPN973MyXINY7k2OImgZKW6/uEeuO9P0bfyGx/rJcrZguoZA0gI0jcfZYghI25NgJMaVF6n49dIjAAiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PC2KTLga; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746159912; x=1777695912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eDrh1VZMFB4KfQkANGrLm4puPyITD5cMi5irvpmJbYo=;
  b=PC2KTLgaimdhtNJrKySKRc1T5KFepIBkdwQdzDgmxo/jXyXLLtruV7lo
   c5buYoxv14FpdzVORV2Rxz/GPfeLpfuqcfNunS7xJu9AhUpgN1smoUelT
   rrl3d/eChtPEMUJrVCAf/QIaoz/a5lmv3JjAS24HarE8v8PTLfbsUkCYT
   d1N4YO0j39/S/DsMmYACq2jq3iG5GkAi8vVtfFBtFn4LjwDvs1aCmTyEH
   Mf9tpnkk4jUGYyGf/6dJjjKzUzcsJdWW4UnKxgqcGGdeXOJmKLa/eqTQm
   r0YdbwSa4bHAMkMwzCj10qqm+SIZCHH2dhLAnO97+zAYSjfcmP1g9Vmw6
   Q==;
X-CSE-ConnectionGUID: ZVuRizAZTHu3AQmaD81rnA==
X-CSE-MsgGUID: IfjxvKCBRmqv4MO6pRPFxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58467167"
X-IronPort-AV: E=Sophos;i="6.15,255,1739865600"; 
   d="scan'208";a="58467167"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 21:25:11 -0700
X-CSE-ConnectionGUID: RRMJDzNTSKi4DHAV8mcOqw==
X-CSE-MsgGUID: dheeiIEuTi+hkHnDwLGcUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,255,1739865600"; 
   d="scan'208";a="138572313"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 21:25:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 21:25:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 21:25:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 21:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3+uisIqztkofxvM/b4XEEtb/fdhK3oI0pLTpIwF+O5uKShV0NLTC5VdAx/Tw6Qfj+5iPwgDWH6k1AH+OwikJMRRNuNALlkUsvU9DslYF/m08CPnkDUnk5/IMTjo2+NMcJdvZPAsZhzNBTA7EtyWQVp3UcJn48Sx457JFQnxdVHM+cPMd0ESaxZSiJWbytHWlhE8mmNPltY4ku9flCm6/CHyGbf9H380Lv2agy0l89AtOaesM2xZugO0e3N00k4kG2Wu4xVZ3VNRAN0kVtaP1ahPMkx0mA++2Hf/5aWTKuitMMYaR4klbtOfJ7jmlUygzYTsbS9HkIQrGngkqPGl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcVU/rx5PMLjQkOSIPFoUJIMYbCT/NP6UimD3ZdONdE=;
 b=IwYBuLsJJPJ4xeVLX0dndSNNk8TXg/IZhuou/7ia/GKl9k8JmSV99VRvaNOORlRHtdK1hR7k1flLSZzs5PJCJAlJhTdSF5cfCmLtTTZ4YuWe4uaHRXuRhe/pTZVG5/KobnfOlycFYKWTv8tQdQB5P3m5Whafy8Q82oYz/LgfkFtTGP14udSN1J3WH83PsFaC1RSD9L2hRjkkmeNzpjbwS9NlzxSKfWJm/4uvdVJPf8+yrD186fRZh1oWvHtLdcIszjLdRPjWgdXoTYqXAEqwshjJgkEZTzv3CgVZduzREHvb4kBnzxyKmgT7r5eefPN5KUH16VQPo4cyKDjxkEh6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA4PR11MB9299.namprd11.prod.outlook.com (2603:10b6:208:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 04:25:03 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 04:25:02 +0000
Date: Thu, 1 May 2025 21:26:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Kees Cook <kees@kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Christian Koenig
	<christian.koenig@amd.com>, Somalapuram Amaranath
	<Amaranath.Somalapuram@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld
	<matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>
Subject: Re: [PATCH v2] drm/ttm: Silence randstruct warning about casting
 struct file
Message-ID: <aBRJcXfBuK29mVP+@lstrano-desk.jf.intel.com>
References: <20250502002437.it.851-kees@kernel.org>
 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
 <20250502023447.GV2023217@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502023447.GV2023217@ZenIV>
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA4PR11MB9299:EE_
X-MS-Office365-Filtering-Correlation-Id: 2616f0ae-ff66-4d2e-ef3a-08dd89314ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bxQpxbjtHFWPLnmWJwUgd/H0+elCNu2ETrXGD6wqpTFqz0Vri9qr/rNRmONc?=
 =?us-ascii?Q?HTJQFoPq6shMcgi1MPx3+sIErtvQ5QdsEneJTrorvwr9JIv18ZJJIdnjlNng?=
 =?us-ascii?Q?QgLrkiRiY8Cz9TGqreH5GgYuBe7oHuSIjSPsO89Sk6HjNfXx1pH4nDjcQ76P?=
 =?us-ascii?Q?Ef0+1Iu5wplvWJqZu/0zadJuQ0YlITIRxnadFZHwdwVRdd+JIGt8cbwHrOjV?=
 =?us-ascii?Q?6ok1cRjBPATmImouOC150+btYJFusxK46065kAkQYxSjub5etLTnconTKvsS?=
 =?us-ascii?Q?EFa1RkckEPJ+jh9w00OVs3ALhM06KVjI7kmtQWHu14tAq9Fezl95N0WPEyLE?=
 =?us-ascii?Q?OLwDmW3NUIhJYedDNkGofBJgZRVv9C1u2/Qv1+NPB0qvU17YAyBTFIrpmWuF?=
 =?us-ascii?Q?YQf48FX+lUjMSUub4vZ0MiqLE1Ps6MvS8hkIoE5L//cE2aJP6giU1HoRKWJX?=
 =?us-ascii?Q?jxhI6pgWcKrVHsuX+qqwyw3OAMfmuVH9fLqtSym0kZ3Ta3g3+bZ4+spSviq+?=
 =?us-ascii?Q?8ZfSafvplYK9Si2PiCBdcQtFULcxvrzUQQ6UaUMhOs7FDuCzzDa/tUAKBNNK?=
 =?us-ascii?Q?tzUJ7JW0kgdtwIoBbPJyQ2c2E2eVTQjpk0jJE7MwCSRsepnYAK6OCNOGbOzU?=
 =?us-ascii?Q?Bl7oIXevXxET19T9QzeS9hYh0ZuB9opAiKTbLOkO5XXMmuR5+lwWwGtbTNlm?=
 =?us-ascii?Q?Pk6r2k+hNhP4iQAo3LBAxohg5YtVm9BrLm86e4aQa9qOZkNfDBVnRqqPN5sR?=
 =?us-ascii?Q?4jxee+3cFlA81F1l+lh3o8QjPtbvtg0In1OqWhqh8RP+l6NGBEQRqvZutTuk?=
 =?us-ascii?Q?OaQjXW45FRqkX0FjmI5eWwWG78v7pYCUIhtim4fEIg+8saRv2s2TUjU2dcNa?=
 =?us-ascii?Q?qBIlFCbPEgAHGuaQBDQclqgk1oh57psa0fgTFfdCt8U4EGPTBqu4zOGfrCqQ?=
 =?us-ascii?Q?wpgcBxYleuMIdsLmf22BMNkTjhv87BZ4QPyL3hvxI4ysck1fjJc+9CNoq5pN?=
 =?us-ascii?Q?ZndKhlY9iJpHiAGyF4UVuW07pJH6CLzmU14F5iucmFUs04yjKV5f5MRow1sR?=
 =?us-ascii?Q?fmVJP4UfdEIRPe5M5uOAJIb3cTMl3kMLmf3bmfIrHpNYD6n46gcwW7dGKlGb?=
 =?us-ascii?Q?MmlmQ/hH+9B+fTCIhtIw6u/oYifbQ3fUNBLhbFn/zsBEzcyr6yfE+x4pBMo8?=
 =?us-ascii?Q?5OmlyNE1H1+aHmU9/QMZP+ILzO+8JJ5hBbRBl69bkY6w5mPxsrBs56mtqf+v?=
 =?us-ascii?Q?ETHpKW9rPXX8hjZYWCIytl6NU2rO59yxmI3DQTKf+UaImgC6rmOfb7tRdyI8?=
 =?us-ascii?Q?BJQLI5DIGA8GodMoFF7rnsU4Pwkhg4cDpb3ROZC/k3vQqUKfdIRYZsnFqwar?=
 =?us-ascii?Q?g1tXKLJUQe6I4ihoU6PgD+qIlzSBkBXbsBArvsTMt3fRPZzhrcJMU5RjiNEZ?=
 =?us-ascii?Q?tOkRDgkRQ9U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S6t/34M4gFVQ3z7TeDf1hF222f0AmcMCOIRiiYaJtTq/2dHf8VcpjTFR8S5L?=
 =?us-ascii?Q?PTiTQ8XY5QBlk+LnJLWVHuONzcrrdhlkdR3GoRcNQUi0j2mlRBD+FdTg+0HG?=
 =?us-ascii?Q?OdZZVq6UoqGRDX0wiLEOkyHtwuYjbXREBixs6ggnx1kIN/M9k5Hj2Q/zbj4f?=
 =?us-ascii?Q?iOvUO9F//8M3UVYsYTym+TnYeh4h/KW/bZUJsNrEKf4XDVf/NeXVTfYHa0Pt?=
 =?us-ascii?Q?433eEvcP486Bv6X8evVQOCwuDX9DI4uxAt+eDVcJqhlzsQNWEmEX2qdTdue1?=
 =?us-ascii?Q?9d5fhEeqDhDDcjNfnEDAqbVxWtj5E/admTrySe6Ui6ZypSjwE3utx97qqV0o?=
 =?us-ascii?Q?C9b7W4O1Cs0eyM2MU1GsjymlLUIxNpZgpjSr1Ub/6hs+lNgbbDLdKgPVL2rf?=
 =?us-ascii?Q?ur9Jjl/pvEglw90jZ9m17P3oBgSlfddW36f8ImR3dqMJ2QoFNhuPct5JIV7O?=
 =?us-ascii?Q?vLnQqVPMDuklW2vQ5NjLVyvA1SuUReWue8mLvB/RJTPOzyHFhhumbBpM+pRS?=
 =?us-ascii?Q?fW4cD2hki7dhxHL1zRaIIUfl7kXqHFhcnngJsk3gFBveEw2ny1o9c3+BnJv0?=
 =?us-ascii?Q?L896OGULQvm1w0XjHOwAmtwubCzhegisTTKugalBT5At/A1H7wPhrUFaGij3?=
 =?us-ascii?Q?wxkyow7UR900zsSmOkLIys4PTJnBAB9e3djrvy59OAN+SjTkpkjXPfs4IKDi?=
 =?us-ascii?Q?1Cl2dohARvJcTyc4jq3uMMqaRMCGQS8mG3fsSadRkim+8DjWOhoMD/ufQgfY?=
 =?us-ascii?Q?SZUrxzjbDD3FZGOeA2kG2bDGwYZYS5YcGwtY61PXMHN/LVYV+e+98eXMKfhj?=
 =?us-ascii?Q?KRw4O9OMJ4T8ITj5QCk3yAZguJJhBFzi5ZzirXFi6zZniNQslsuGRE/9yAEq?=
 =?us-ascii?Q?R/qJBnHUJZhjpxso/kXa1FAuO5J67sW5vKQcRs881Bu61sYlXVPtNXJCFGGa?=
 =?us-ascii?Q?oaiTpb0K3jtOlCiYxcUDoC2E3lUTtMZ6FfdJFPGQH7xkB6xpcu19zM4+NxXo?=
 =?us-ascii?Q?w6rWcTdz/CqrSPiT1K8FE5Tb0pOSXfj0eIsSDkD3TgynGh3F29cd3uwlWvDr?=
 =?us-ascii?Q?VpZf+cs39m9M8yS8WctHXJvL6OkHKEj8KMFoF633taszfi/diEl6LGiYDKA3?=
 =?us-ascii?Q?SiLOJzHtGpiYorRlwmJrehWBexfv6Hqely4Ew47VO7P3hd0mjBF+wCDnuuVA?=
 =?us-ascii?Q?6HfZIlhKESO65dM78CFpRSBFRLDhix7xmDoVRJOHh0t7xaJyJUFeFZZBdn4b?=
 =?us-ascii?Q?9mJT4g5Lm6SvZcUrJ8QpD6cXCu4fUSLwRPpoDu6dNoeBeIxuIyJHcGlJG98j?=
 =?us-ascii?Q?gIPbZqxDpSAGZS6cRyS+6UjsWw2+5c04p16LCPU14U1RNgV3xHcuAHBnyLaE?=
 =?us-ascii?Q?mlvAiaVl/w6fKUu7nKqFV1OYv2Q/uN2bmyX+1fQ4HEMUzvSXbJZxiByTEMHT?=
 =?us-ascii?Q?A8L3EJeeM1LTBoV7AUsiod9ur/VJbji1K/7S4gZSCPJaZCxYRKIfUyvxrjwY?=
 =?us-ascii?Q?MqRUKTT+f1pZsO83oU+AlYqMhVkn7g57uj8kZp0mezNN3Xv/5e6eIDRExR0r?=
 =?us-ascii?Q?KKzkBaTcL9LXcxxR2ajjPe5N0SybEewMNOGIcxsxHVQu8EK0QN/sUTCZEXek?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2616f0ae-ff66-4d2e-ef3a-08dd89314ebd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 04:25:02.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIC1SqhtZtzD4uArfSxzicoNEBLBMEQbr1DqQqQUyVol78y2w/fvClv+vatRKrF+T4jPkYXrgmwQaNy+0HvL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9299
X-OriginatorOrg: intel.com

On Fri, May 02, 2025 at 03:34:47AM +0100, Al Viro wrote:
> On Thu, May 01, 2025 at 07:13:12PM -0700, Matthew Brost wrote:
> > On Thu, May 01, 2025 at 05:24:38PM -0700, Kees Cook wrote:
> > > Casting through a "void *" isn't sufficient to convince the randstruct
> > > GCC plugin that the result is intentional. Instead operate through an
> > > explicit union to silence the warning:
> > > 
> > > drivers/gpu/drm/ttm/ttm_backup.c: In function 'ttm_file_to_backup':
> > > drivers/gpu/drm/ttm/ttm_backup.c:21:16: note: randstruct: casting between randomized structure pointer types (ssa): 'struct ttm_backup' and 'struct file'
> > >    21 |         return (void *)file;
> > >       |                ^~~~~~~~~~~~
> > > 
> > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > I forgot the policy if suggest-by but will add:
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > Thomas was out today I suspect he will look at this tomorrow when he is
> > back too.
> 
> [fsdevel and the rest of VFS maintainers Cc'd]
> 
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Reason: struct file should *NOT* be embedded into other objects without

I;m fairly certain is just aliasing... but I do understand a file cannot
be embedded. Would comment help here indicating no other fields should
be added to ttm_backup without struct file be converted to pointer or
that just to risky?

Matt

> the core VFS being very explicitly aware of those.  The only such case
> is outright local to fs/file_table.c, and breeding more of those is
> a really bad idea.
> 
> Don't do that.  Same goes for struct {dentry, super_block, mount}
> in case anyone gets similar ideas.

