Return-Path: <linux-fsdevel+bounces-40360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D2A22968
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 09:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DD63A6A1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8F1AAE01;
	Thu, 30 Jan 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgcjyLeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C491A840D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738224517; cv=fail; b=ktv/k3Wg63FGiGKWlWi3cFJrDC2TAroADmHibvKfZ7CWeN2lAahgJUKLEkDX75xixzUpi4GeIQB48Sfb/wC6jb93mmhIAROmbxRO/Z4tkY+Snl+inJPNEavPm1FW0lu4xC5jd3XyoJXBfPM/jj17UKWQ6doqHXhNz3Y8CcrcUjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738224517; c=relaxed/simple;
	bh=J0QalXACFolXtez4Y/NBWes5/IURYGLpgj0yc0b26qs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oWlEQJgW+3oZcDVK557rIfvKnZ1hTLYHzzDKHfUITF84+OW63WXETPCW5xmjqdW9nEAtO/aYn79ilr7pNdtYvaqA0HuI7CBWSa6GRz3pOs2lH6Q+VsWq2IBLjxlIfzIwV0QOFasnosuuonAb8jRebbTxEYeeNjj0vKwevVOkDi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgcjyLeV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738224515; x=1769760515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J0QalXACFolXtez4Y/NBWes5/IURYGLpgj0yc0b26qs=;
  b=KgcjyLeV+AnNoeRGIralsavGdKhv0Voafdq16EmFg3QIS1S8SPIfjG0y
   XqIcfbPXveNnac8ULPSllNrp2/zYGlLCR+KSDTO4mRe/h8xyA2a2PLMek
   bUjzAgPZGZlUPCaV6CA+LtrQGsr9t4fHFAjJtFAutRAEKUgTktnrb+Ggj
   QN4xHhlwxaHmDr6d3aQYrp77oqBG9sYF1K11rzGHcLvPZYAWRmAUzIbbT
   GFAdssB30KCcwHgIZOXNGCxOKcPpgIB312F6Ecpd1RPyeQZ26ZWA9vJNa
   7awrkeE3yjqbVIkNsypZJgjI+VkXxqWq5bxDIsSbx2dI8Ei5WEZlQER0k
   w==;
X-CSE-ConnectionGUID: USScIprgSxawPhnjNL44OQ==
X-CSE-MsgGUID: A8WlyrwkT42otx88lJuCtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38926132"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38926132"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 00:08:34 -0800
X-CSE-ConnectionGUID: 1rtmxHTHTyuWwui0+6ozJg==
X-CSE-MsgGUID: fTYK2B5BQvGRrb74yowO1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110169762"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2025 00:08:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 30 Jan 2025 00:08:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 30 Jan 2025 00:08:33 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 30 Jan 2025 00:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2D42KgzO1UBQWV8he0npiY+obRjfYluPiPV9ajrxz/fF1hyQUCQZe+7q65JyOguBfcfTotn7hlblIwY34lK+V5xybyxx7B5Rg09V2VLUP8AWNi6swS9c1MB3fsyJ4QKR40NcJRIipfKxES5x1w5zBMAS4yJSPQtFpKxxVmpoTCD0fRPoQnOs3Y7iLbZvf7fYVKqm5mfpe4Yw3LhotaBlKaZZ/brv5N38IIcdJlOtoCG77zL6MKoOmAU95q0cZqpwJgcnUbUaFUptxvakFhIKEjiCl0Cfcj4ZS8dEdH4TdstSNcSwcEsmxPIv0NO5y/UwcfPci04U45TjzTm+54u1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZfSyUKC6BL63Fq5reyMeqCqiEiWKfHLDETmbHq0E3g=;
 b=ppjARf3srCOw86VgZI8nV8nELlSp/HQIjRiYsV7FISpGrGWR6QTta35qYWKBnY0lC2hLIOeOhnJaH013sbwS6MYpnU0eGvCzAE2mwwRVBeBg6t5bGW2v8hC3Q3VEJmwaY4/L1JQcj6cfEwrgD/eY6OYb/vcGhCxpTaUXU0C8BMpvizPjolEfIrXe0xU/TnTaPNTbnx4xy23fISik9y+uFl8tapf9ot4Z2ESrKsvMXQJ7MhV5eISWZfBUTEP3aiMu8sDeOfMZ2dSY0YeqZV92qRkMHPHVDIza9b4hgL66X0/sFZJU+nph75mYy1rb/woDXqstWjUk4YQEzHGCcP99yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 08:08:31 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%3]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 08:08:30 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro
	<viro@zeniv.linux.org.uk>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: RE: Regression on linux-next (next-20250120)
Thread-Topic: Regression on linux-next (next-20250120)
Thread-Index: Adttq6oN2zvxaQC4Q86QyAJ6tLuOCQAF5fmAAJHYpoAAG5FWAABJCcigABqZbwAABXFCAAAZYCmAABlVuwAAAYDRAA==
Date: Thu, 30 Jan 2025 08:08:30 +0000
Message-ID: <SJ1PR11MB61297857686D10DD3F65645AB9E92@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
 <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
 <20250127050416.GE1977892@ZenIV>
 <SJ1PR11MB6129954089EA5288ED6D963EB9EF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250129043712.GQ1977892@ZenIV> <2025012939-mashing-carport-53bd@gregkh>
 <20250129191937.GR1977892@ZenIV> <2025013055-vowed-enjoyment-ce02@gregkh>
In-Reply-To: <2025013055-vowed-enjoyment-ce02@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|CY5PR11MB6414:EE_
x-ms-office365-filtering-correlation-id: 22a56423-734f-42ad-4f3c-08dd410548a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/lUgBS4OCImBBwY25vBDPMDalnbDttQ1xbXiwbSghpcNaNvJzWQwNp42mc2y?=
 =?us-ascii?Q?0tE2DjVOoJKGH3khxX9t/snldjxyoJEYPyHKnEawKRyt/0M67txgVhyfRamS?=
 =?us-ascii?Q?qma/lenP4c3cEorQdJaUwinf46ICb7njbzAfa8l+AO/HKM8smbVzwt8nJGAY?=
 =?us-ascii?Q?HU6fm5Jkg/ytHMoIfP334nV/itd9KIP7mK4FF6FqmZVw4E53E1Gkc/7K4LGa?=
 =?us-ascii?Q?EA7LCBr6bVzZv8zkqCUB2QC8JEEwFXB/NtjnvQf2SdJcI5LmgOD1w3YZzPp1?=
 =?us-ascii?Q?Bq69HTV9IFVC7M8odwrXD3JvtlKYMUnKekdXKBLcgUNb1IWwWm0Do0mGj8Tj?=
 =?us-ascii?Q?GgKf2o5tgqdNACfrEQFiBev+2lqU9HqeHhLgkhosLfaPhbF5j5t5NkCfFiF1?=
 =?us-ascii?Q?KnI87ptnn8KIKK9TyyfJIUIRHabazywmn4NZBZIZrBLHLyCqi6NASbOx04nh?=
 =?us-ascii?Q?wgFNbku43O63rdIu9S9nHfd1S7g57/up643rFf07sm06ykl64inymZz6Z66l?=
 =?us-ascii?Q?s/+o3Ucqp5e+ttM/hhzU7xQAv6/iojDhYyCS/4MbHFT4iObcGTw9yUEp9yrc?=
 =?us-ascii?Q?L1WsQxPtyf3xi2P6kcUiFZDcBF8mWABmYfbgzed26RkLyzb6Gf3Fqo25zFUN?=
 =?us-ascii?Q?TPXc3mt0LKMyfaqexrX3s0TaeAbjooWBjcevo9D9GDyzOg7UIYsMcriy/03v?=
 =?us-ascii?Q?0RHlL4b8KopiNnKGvajCCMVpg568t+dST1vJWAd6iH6YF6JvTerX7T1vWTWC?=
 =?us-ascii?Q?Sl37/Y+mbg57BYAvLsE3BJnh7rVXys1RBr/cZsIDDkYJtC1gbYC0/HhA2tvW?=
 =?us-ascii?Q?NzG5dcC8AlTLCudM9nry+Nzi2Ei4WpCfT47PwAJxJ2YKkWIu6wC1qqaCF0D7?=
 =?us-ascii?Q?vlN4vQ04kd56GZjaktr/Ki7EIHu+yziuippU6iECGk3y0/wfAolyJfepyiFx?=
 =?us-ascii?Q?tpOr3QdkK8x3dsWUoBRkOYKS/DIwoe3cAVOc8Ez3VbDMk4maRujoxaxSP4VB?=
 =?us-ascii?Q?npWEhRMx4hzE7i+4r3SCEyTaBIuWTddOkjrLt3v+z4vjbwb8tdNTkojWc/Wz?=
 =?us-ascii?Q?+MImjKSG3a4wMnk0EMY4ZToP+9jTtGUZ/jK+CwfH7/0lIlwUxniZjzxioHwN?=
 =?us-ascii?Q?3cpLoLFaBhtLfQAsSz/+0wikGzcOJi5R7t0+Dzj+mhkO2ebMoR60BXxnRbZG?=
 =?us-ascii?Q?ECuPPOkxc+LTolk/FdwMP12yV8Pn2iFQ2b+IUdKg6T21J8TU9eJjfOC93587?=
 =?us-ascii?Q?h9bgQbTU/gst0WsnRdc/6l1ccXIUGD8Z1twZEjfC3Mku/U4/+8Fe0YCdWZvp?=
 =?us-ascii?Q?MOEvvSvW3jwpCmZOsJmBwHesabkmpDgCigCKCfrDWr2GAMJcovqLLverI3Y8?=
 =?us-ascii?Q?f404pvUkE4lvPsSQdvzasoR4kXaHItZ9M3xK23NoDzGXdbeLK9dNgNwDSy9Y?=
 =?us-ascii?Q?Z25CCHgm1QI51FadfO+OSJlAkGugQYTb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jhjaUeDfr1nmU8eq9M9Un49Uwe4kBWEr+ZKF777Ee2dnmIN66i+Y2Xw6ixQZ?=
 =?us-ascii?Q?qKQNJijAhePMRCLmfIWAQVLBJu/eftf1B8crlARf6ZhnjKBsMJGRKuJVoOu/?=
 =?us-ascii?Q?WCG0dfRvBIX35glc3hj4XQXesyflAdnQLNrGjt1ormMqjqhjXjkPnVm6zfO/?=
 =?us-ascii?Q?UIHkQcHF8NX7tmtJTcOIcRpH631BUYZt+GbHEx/8Pw7nO5ojk3fwnlKb7RC5?=
 =?us-ascii?Q?bmt+LkszhgZnmBcESQqFtOTXwQlTfGrbUTanT6tchudYRLVn4YlMof94fN0H?=
 =?us-ascii?Q?nheCuRHSYOnRL38ZVNheMZLWNk9psvCaBzNMzjFuKCLdlU1uUD5MikmGkEFM?=
 =?us-ascii?Q?9dlx5WpC/no2BhZCLuX09j+nSfyZC9ow4/8RrLpcZAnTKa6RRkW6TUfYqoFM?=
 =?us-ascii?Q?yeS4aKkp8k+unXRkL3N0aLC7vlxkOTQVYdbJ0VI1HZO3bIJweU8CDiq2JaIL?=
 =?us-ascii?Q?+pXj6zu62B/DKcFdrCqfFGEHeC/+BZiFJ6Oq9C6cSB4hSi1SIiG27q6zKhEl?=
 =?us-ascii?Q?qkRJFoVEQqGeh229QgEwJessARGqX9tXFTp9OKNNeNLK4ptn/Bn5vM4DQUhy?=
 =?us-ascii?Q?6auvvEA3wYXWJnviqfxxYn8/BQEJfSAtEj7TxgHSkb8Y983/XHvlM3W99oO5?=
 =?us-ascii?Q?wONMea1nud8ZUixdbB1eSG4ggXJnUVcmhcv2/JuIMj9qevVLyDiq9GQDaXtX?=
 =?us-ascii?Q?nm8YQKZYgy0naxUyhltvwQeEGnwgUr8cj1o1qh+ISfgwR02BGR3kPwnxBiCH?=
 =?us-ascii?Q?ftUaff0++tyABTtHKgB4CzkperzFwfJ9b41kiTkIeA6OV61it5OO96Q/M0MZ?=
 =?us-ascii?Q?oaPwF4BW4TI5otCqtOklby0Gt/wxnaSj6t8SyulSTYnVcs8Q8I8NVz1g25q0?=
 =?us-ascii?Q?RIoUWU6nA/KZlMC+gauFCpeWq10CAAXzJyqEjsx//mvn+5KaZrQ7vV9nwRIa?=
 =?us-ascii?Q?XCdF9BbHtS4O/j1exotisMDkCF47HWx9wiQ8PeHBe6sqXKDoRAcAtFIqDsZ8?=
 =?us-ascii?Q?0cNTWWOpRjG7IVqo3/Glt+DiEZ9JYh0k6FF+FQal3rKJ+nTFYFYsJz8ZzmKa?=
 =?us-ascii?Q?2X9FSvZi2U5O5owmNG7YYwB/LhJ05Nd+8FntHYwrNEjonwvYpsvU3CdJmnUI?=
 =?us-ascii?Q?uSpAQLeA9p3W1OcGN2mYCVCe/DpzEMZP7NlCFcWN1ujiIoUONOJYnDJg7eBs?=
 =?us-ascii?Q?0QPfVqxRGHeq66U9tBlK71vBKECCO0o1bAlFgomWI3hJL9iw2SzSmcRmHEZu?=
 =?us-ascii?Q?jD1fCnuiyn5KvnZNVq1x/1c7DyxWuOvmvqfq1rtyZk24thJovSoJZPw8Q1CI?=
 =?us-ascii?Q?BlPqNFXUhParOCy7cI9DH6Syk2+BaI7sTGDwcsVwK3ejACwdevizT64aR1+G?=
 =?us-ascii?Q?5Mbc+3gz3cgvt/ig3ydPcKKotFByg5GHE0WIRFyz0s9RyQb3Sv1KI5YWRlmu?=
 =?us-ascii?Q?uzcJ9UpNeW39wf/EoqOuFfgGl8w9jzT6ogM2j34Y5WWkUGOvFTuISjOYCAlb?=
 =?us-ascii?Q?tYJRQbzxDqcsSLu+KaZWvcjpFZV13V/DevZRXx0GCu3PIlMqc8TzpgAUoB8k?=
 =?us-ascii?Q?ruX3tpoQ9fHhS/84ypB/Adhx2oTupsU7YV5BJmFm7kpSQt76anUbY38TRM1i?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a56423-734f-42ad-4f3c-08dd410548a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 08:08:30.5939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9cxso0pGMqqMPS4nhedHkWGXFhIy2JveEzBWAT4WbTgBs5QNYEaNK2m4egnSfghNPc2meN0yNJbGRI8LSiy69g2U+hIEzPyX1ympwkGUmKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, January 30, 2025 12:55 PM
> To: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; intel-
> gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org; Kurmi, Suresh
> Kumar <suresh.kumar.kurmi@intel.com>; Saarinen, Jani
> <jani.saarinen@intel.com>; linux-fsdevel@vger.kernel.org; Alexander Gorde=
ev
> <agordeev@linux.ibm.com>
> Subject: Re: Regression on linux-next (next-20250120)
>=20
> On Wed, Jan 29, 2025 at 07:19:37PM +0000, Al Viro wrote:
> > On Wed, Jan 29, 2025 at 08:13:02AM +0100, Greg Kroah-Hartman wrote:
> >
> > > > Both are needed, actually.  Slightly longer term I would rather
> > > > split full_proxy_{read,write,lseek}() into short and full variant,
> > > > getting rid of the "check which pointer is non-NULL" and killed
> > > > the two remaining users of debugfs_real_fops() outside of
> > > > fs/debugfs/file.c; then we could union these ->..._fops pointers,
> > > > but until then they need to be initialized.
> > > >
> > > > And yes, ->methods obviously needs to be initialized.
> > > >
> > > > Al, bloody embarrassed ;-/
> > >
> > > No worries, want to send a patch to fix both of these up so we can
> > > fix up Linus's tree now?
> >
> > [PATCH] Fix the missing initializations in __debugfs_file_get()
> >
> > both method table pointers in debugfs_fsdata need to be initialized,
> > obviously, and calculating the bitmap of present methods would also go
> > better if we start with initialized state.
> >
> > Fixes: 41a0ecc0997c "debugfs: get rid of dynamically allocation proxy_o=
ps"
> > Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
>=20
> Thanks, now queued up.

We can confirm that this change works.

Regards

Chaitanya

>=20
> greg k-h

