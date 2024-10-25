Return-Path: <linux-fsdevel+bounces-32851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAB9AF8EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 06:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC7F1C21B50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 04:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3718CC10;
	Fri, 25 Oct 2024 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCqKI2dM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833C2C9A;
	Fri, 25 Oct 2024 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729830918; cv=fail; b=WcdytvdooZ0W2ahmgeGk8MECE9D8zflripZQD0fmTD1qt4LoKONWE2VvrywMxYRhpFeCMrv3NT4VUFP4OUFUTpMJRvdDPYqcijeUwRTCXW0sRaXBg3V/Q4rk1DNTYUF2xOxJHRzA6jGHbqHTBEsye7blDb7Np59ocPsE7sX/6XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729830918; c=relaxed/simple;
	bh=bxASGeT2BZrRV745L2C7JilNgKybBVEaMQ50Hiq7IY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KRgsSXe5+Ndbkvhuc97oV3qHJhInex0971hcR55MbpYoJfv+NI5Fn7axdPdBVkz+asbveGVim93yrOh2Cq2XptPAPbWEiKfHT98QBQVLQKcfH1gMjFZ3CU1fUMysPZbodm4XFXQiiBM5cuUGhmoblyXFWfxY+oCkcRS3wCjj82c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCqKI2dM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729830915; x=1761366915;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bxASGeT2BZrRV745L2C7JilNgKybBVEaMQ50Hiq7IY0=;
  b=SCqKI2dMscYXFSrIBbz8jDjZ52rRthyk73uWC72QFfNNogozrR5MtkVj
   2oVzIVxW8WTs5JVDOsRhwOfTHw4Uk2u3LEeJNhuiREnnu1JVYHcV7ziRd
   tsYNwG/eN95QG6OVyl+oIXrp2DQbLOycHXSiujf64GRlUrW7AmYqabu8B
   AWloqUBJZAaNOmD8/oNOf1LLqjz36+esYT1k4BVTu9tw368kNym9ZrtKz
   ZLnEq3HWi67rcRw3NpFMo6NcruGVcZFZCOkZltzmwChfwlUlH2vgGCDJy
   Nz83mJz9pA3DD0a3HzvgBF9OenhMEREUfcRtAodLV77eCvbwd8q6LHfGM
   g==;
X-CSE-ConnectionGUID: 5Di+uVNgSFiu0netKkVvzw==
X-CSE-MsgGUID: XiV0xsodTjKJVbonBixB/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29708757"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29708757"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 21:35:13 -0700
X-CSE-ConnectionGUID: rXfZiFjVRWe55+1DQ4PGpQ==
X-CSE-MsgGUID: ydWWa7n1RquxxejeMywVRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85916569"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 21:35:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 21:35:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 21:35:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 21:35:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1m1k5MAGvZdt0Gn02c8bCjhOQx4qYN4TekaYCkHbNKUOJ9wzCir3D0Tbt4iitH/4yOwws53oSEXbzQZOh4yA2pMTRINce+lAZ1+sBrzttD4q18ZPQAek1tJF9OZK25ezoaxPkuWDROXZFQ+kU1EtlGWUO7W8ROY/FLUMC6WZf9JnukbbCIgsZyjzku6kINyWFXDmBaJ6fV5o5B1vztRfBrGAeSP4af3axwO/GJqlYGduGcuoOmntFdJdhvYrnpjFj11+GihXXVflxWkMZKKWiDfJzWqECBv/iZuTx7CDlI5EhbpVVBagOM2iX1d1uauqTaQXDqLcicASzKYe/rPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2Q/e4vN825Qd2VGVMni/47wJQ9L5x0eoUniDp67d2E=;
 b=YQlglDIzQYLE07/PrZuO/5Vjnrhv28dlf9k4V3c3Bp/BXzh8f5TnFaGxR+WE3BfwsQrHkm2Jqv5J+6WPjvPS0R2/B8RVNLoQjJcgOFFxrgj7qixHlZsXAVYQ0LKogtCfNptu/H4tY4+qc7pLGv/u613b6rTnN9l8F9cdfqyp9B2fhb5lZ/vfPBLx6K/n1TJ9ew623y+nvQ8072222XJ2lV702bTSQu5LXumZgfCtAOO6NU0/fn4Xzw4R9J2/+0GY5+AOlIB60f6abh5rrLJWv4LsTJevufPWi9AU8hL66LDXo0O+zuWbuptPeDHnAnbh0ezlTWi5pvQHzhI6z10BGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 04:35:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 04:35:06 +0000
Date: Thu, 24 Oct 2024 21:35:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-mm@kvack.org>, <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
	<logang@deltatee.com>, <bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<david@fromorbit.com>
Subject: Re: [PATCH 10/12] fs/dax: Properly refcount fs dax pages
Message-ID: <671b1ff62c64d_10e5929465@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
 <66f665d084aab_964f22948c@dwillia2-xfh.jf.intel.com.notmuch>
 <871q06c4z7.fsf@nvdebian.thelocal>
 <671addd27198f_10e5929472@dwillia2-xfh.jf.intel.com.notmuch>
 <87seskvqt2.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87seskvqt2.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: f608fc9b-4ef2-4a49-8c83-08dcf4ae667f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?003X7Sg6yMCPEQ/WKyqA+xRyJS2Xc/NFTVZi/satp9ZXCx7fxN4zxdzdk0WY?=
 =?us-ascii?Q?3xDUFyNHF8YMeBYcTa3U1s9iYuWgMXpCQPwLQJ7pM6y8jo2F345iEDwkjG+n?=
 =?us-ascii?Q?AZsqy20JZbFyUbot9LZIe9yoPgaUnesPCUvmPfNdd6i7bQ2/h0RBOImD8dSp?=
 =?us-ascii?Q?97DzfWjoTBQqz3VJUigClxx0MeDXfBWRUWv+L2yrSDJUJzyVlFHiKoAAxd9n?=
 =?us-ascii?Q?X5WDpz9SiHsrtdeOgTgPi1ZAh3HIhCD2/2eNLVayp8MDoZH1ReVn/Akxl6Ay?=
 =?us-ascii?Q?Mk/oijnpZrpvsSCnsn3NdQ1cEIKFnfob5YEf239u94eCsOI1vDysYueF6mD6?=
 =?us-ascii?Q?nGZ5ZljlDdbqLN9dtMm3jj8HJzgWMHF70cFntGpGz2a+DEMkMMRiUDEXFA6H?=
 =?us-ascii?Q?bmbtls8KjZBZYyueoQN3OX6e0q11vLBN0W7r4uNqNUWouA0m3X0xSkxH+8Cl?=
 =?us-ascii?Q?akPwMg+YxGE5pVpjyRKAfu2lAXF6wtYsqWbIsECBeDfBLBlQEw/rfl0uKt4F?=
 =?us-ascii?Q?7MUq5Oc1O5Frvl/5flGyWjWbe7w4H7FGYxflp7dBFD0HWnzOVB2WGZB5Wt2r?=
 =?us-ascii?Q?rCqiPXyatSjbK34/OYYgjRbB+TR3hNDSAV8LillgA03y9vQIVT6s6/GdqF1o?=
 =?us-ascii?Q?/W+mddOy1sTsgiPSzuyf9dne+KobNtvKOUnFjUhdrtbvcQafkNEA1afYs0xs?=
 =?us-ascii?Q?p5etp7nw6FPIh6zS+rjXWwYK2z5n0pNv4rT+Z36Iy/wHbVZZuzZ+MbrjPsda?=
 =?us-ascii?Q?ihxB5GwWfIeu9j98o7NUbv0NW3kCmaHz4ScsVhCjoNEK2RRbQOhoq8OA1ojU?=
 =?us-ascii?Q?yTiyefeIkGCfhl7G8T27JEDrN0NvBiuv2wfRmsY2tmoahsP9HDpg8Mn9FDsd?=
 =?us-ascii?Q?e93taLKc57ywjE8qcAIANYZswfQHSpNs1CCG8KpO1vxWq6BtEUWWG1Trj1RG?=
 =?us-ascii?Q?TIXyzRfWHRjozarh3rUQ1XP+MgbNYcVNYHSlIGniYToXWQuhPFpBcNIjrBCr?=
 =?us-ascii?Q?1QHNVZlw0U6z2jRQ6Z3Gwji6w7+y492fQ58Z+LM9WRa+LLqycT39avX6k2cW?=
 =?us-ascii?Q?M6xtKnBN8+lpaJkc8w8fLTFJLbiuloGCtTg/+bfk2rdWFILgn7RKCGalqUxJ?=
 =?us-ascii?Q?ys0L5kDOyHMK23ldnaylGGjyjUAwv/o5qA0SWtK9JFneCp+uts7ncTbvPJq0?=
 =?us-ascii?Q?76mvhGrgQKx0lVSm9+cIDfoPD4Sro2rzOThZ+laABLNRvpnzpq9Uq8giJMbj?=
 =?us-ascii?Q?kKsgO/cxb31ZM7s9Gic8ocJJYtnVkmsRHGPQbGEubhv+3JmYwAL+QfOL9rfM?=
 =?us-ascii?Q?SYC0qe+gSLxhDRtibN8RT09C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XvhQDAdGRFDdCrOGWJaChz8S2vV9DsEdHxO9Nk6d2i9Zm6/fmO1zW5O3qREW?=
 =?us-ascii?Q?x2B0BalGC3zsqNcHxSf71OD0gr/OqiyqR8ZQ1PkgYIjI95GEBeggpmKdmeyL?=
 =?us-ascii?Q?WwNpGXddfxGd7OUoRp6GXThCCDrtGfq0NCMRx3WJvICcC1tshS0h0qw5SA0O?=
 =?us-ascii?Q?eh7zuKwQWoCHR7CWv5ZyiQFZeflNwgCqoj602B7FlIRPyoDvPbcmw+clMj8F?=
 =?us-ascii?Q?IzqQibPoti98DVkdNS7W3XxmEoDcUTpEuLHCnwmvhZ1l/GskNA+94kZcKlzG?=
 =?us-ascii?Q?GM1AgBLiPguu0NSElHAuyyW/AmdCl3CfUiW2MiMG/X2EOxM8esvfBS3a9Khe?=
 =?us-ascii?Q?Qb4JmYjsMjBZcToinH4pW10yYD2BDbM7Ymrlvhi55WEb0AfmqrpdPE3YKaFJ?=
 =?us-ascii?Q?nj2lbdksAvXxDo9rceX5+03xn0/sAOS0D9Tt8t8+hunu4GF79Rau982dO+q6?=
 =?us-ascii?Q?63Ly/c4qMBEUK2M7MNXuqVPVohJYUy2BoDqjrsw7VUlVhfgnJqYkcRXI4nwK?=
 =?us-ascii?Q?RYgVZj2xcOzp5eHB+NKWdCEPTVaFnkj6CPkNQw22NzR0jVNYDLJQog1mnGvD?=
 =?us-ascii?Q?5BvxTDcWsaGUaoJfMhS+LNvasYy9zZEfT4Yxv76chY3OV+bJDBdm/RO+56Br?=
 =?us-ascii?Q?vwfeVMN1YfmLoanaLVmw+avQKXuccjWrCDj3RgiFTSgpVfRyt56b+dFDAbnL?=
 =?us-ascii?Q?RKKGyaqcmkk/aWCbNv5ifP/j+x4U63wsdZ2Yq7Sfz0u820RJlNf7PDZdWtqH?=
 =?us-ascii?Q?kZmgIrhVTBAjBFJCdgrzZrA67Hs27iumDoCJOHTtjjXy47oecKHuEbRQlZzf?=
 =?us-ascii?Q?xKRXTUuyW+vTrs29vJM1DzuE408BiywvVO+wio6DtFYFgO91NfhELzX+C6jm?=
 =?us-ascii?Q?nPR7GgVpFHklXiMoIrJ09kTqw28G6beoo9eoZ5Lx8JKLnpKCfOEh1H3/E2+P?=
 =?us-ascii?Q?aavkF9SnteG+MkyXxTN5qhWyC4Zf8VZE3P1cwZkWUWz5YP8o0spBcTRIOgig?=
 =?us-ascii?Q?6vKBAPL2TQu6TMDzGN4Iy+k2W7ljEcBq2XfzUUp8o4SxF8DO2iZKhMalbcEW?=
 =?us-ascii?Q?s7JwAF0BUaaUxwvtLWeHytsxdyKNXOUOmTuG/BxD7WKWDbByayilnRDvrzRb?=
 =?us-ascii?Q?TaaPQ35pKMiOK1AjTcXct+gyu2ITrgJi7yOtIhWlwDphtL4pM28Q6T2Y+sq8?=
 =?us-ascii?Q?akEjrHeGZ1J0CvrVBjdmPa7bs2eKl7bi3iOJLZli31gSrj6zKp4M9i2gfLxp?=
 =?us-ascii?Q?7zTFTe0/LGXKv/XLlNlqw19iha3L8rZB5F33agvBTZ1RBFAgNUkT16/0ILuC?=
 =?us-ascii?Q?e4cZLe7flO+3UY9wbSJfa5Ux2ZKhIgQCkNBETCMCWy1xi3OO8wgTMT8ZtAJQ?=
 =?us-ascii?Q?inU7FSLq/4dOyvwtUTT+i7ntwKsE9xmbHQBsAwAjzzVYGBGAQWIge2eCAn+C?=
 =?us-ascii?Q?m6COXxNlD/rlVsT2s+d7IajtMMvZOgNLwJRA6gDhzQXr9PYjvE0UV/oK0qmy?=
 =?us-ascii?Q?G6VvwNgqtmWVEN6ifg00+DmEj4GWppHUvkWEX9iFErl4IZRqph68LFx57iU+?=
 =?us-ascii?Q?UWvokqM1qBHQCdtDEH4xRICZVucaMXI92p+wCITzEiwFncoeqd33MY7mPPyy?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f608fc9b-4ef2-4a49-8c83-08dcf4ae667f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 04:35:06.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLtoCm3KOuFKw2BK0k6oywu6Aqg6Lc3qz54GSLyeD9olsPUUdQElXpEIA7wTJLBywV/lxCvTNqR9DJOZ26zFp7Rr/hi66j10lw3of3DDVZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com

Alistair Popple wrote:
[..]
>> I'm not really following this scenario, or at least how it relates to
> >> the comment above. If the page is pinned for DMA it will have taken a
> >> refcount on it and so the page won't be considered free/idle per
> >> dax_wait_page_idle() or any of the other mm code.
> >
> > [ tl;dr: I think we're ok, analysis below, but I did talk myself into
> > the proposed dax_busy_page() changes indeed being broken and needing to
> > remain checking for refcount > 1, not > 0 ]
> >
> > It's not the mm code I am worried about. It's the filesystem block
> > allocator staying in-sync with the allocation state of the page.
> >
> > fs/dax.c is charged with converting idle storage blocks to pfns to
> > mapped folios. Once they are mapped, DMA can pin the folio, but nothing
> > in fs/dax.c pins the mapping. In the pagecache case the page reference
> > is sufficient to keep the DMA-busy page from being reused. In the dax
> > case something needs to arrange for DMA to be idle before
> > dax_delete_mapping_entry().
> 
> Ok. How does that work today? My current mental model is that something
> has to call dax_layout_busy_page() whilst holding the correct locks to
> prevent a new mapping being established prior to calling
> dax_delete_mapping_entry(). Is that correct?

Correct. dax_delete_mapping_entry() is invoked by the filesystem with
inode locks held. See xfs_file_fallocate() where it takes the lock,
calls xfs_break_layouts() and if that succeeds performs
xfs_file_free_space() with the lock held.

xfs_file_free_space() triggers dax_delete_mapping_entry() with knowledge
that the mapping cannot be re-established until the lock is dropped.

> > However, looking at XFS it indeed makes that guarantee. First it does
> > xfs_break_dax_layouts() then it does truncate_inode_pages() =>
> > dax_delete_mapping_entry().
> >
> > It follows that that the DMA-idle condition still needs to look for the
> > case where the refcount is > 1 rather than 0 since refcount == 1 is the
> > page-mapped-but-DMA-idle condition.
> 
> Sorry, but I'm still not following this line of reasoning. If the
> refcount == 1 the page is either mapped xor DMA-busy.

No, my expectation is the refcount is 1 while the page has a mapping
entry, analagous to an idle / allocated page cache page, and the
refcount is 2 or more for DMA, get_user_pages(), or any page walker that
takes a transient page pin.

> is enough to conclude that the page cannot be reused because it is
> either being accessed from userspace via a CPU mapping or from some
> device DMA or some other in kernel user.

Userspace access is not a problem, that access can always be safely
revoked by unmapping the page, and that's what dax_layout_busy_page()
does to force a fault and re-taking the inode + mmap locks so that the
truncate path knows it has temporary exclusive access to the page, pfn,
and storage-block association.

> The current proposal is that dax_busy_page() returns true if refcount >=
> 1, and dax_wait_page_idle() will wait until the refcount ==
> 0. dax_busy_page() will try and force the refcount == 0 by unmapping it,
> but obviously can't force other pinners to release their reference hence
> the need to wait. Callers should already be holding locks to ensure new
> mappings can't be established and hence can't become DMA-busy after the
> unmap.

Am I missing a page_ref_dec() somewhere? Are you saying that
dax_layout_busy_page() will find entries with ->mapping non-NULL and
refcount == 0?

[..]
> >> >> @@ -1684,14 +1663,21 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
> >> >>  	if (dax_fault_is_synchronous(iter, vmf->vma))
> >> >>  		return dax_fault_synchronous_pfnp(pfnp, pfn);
> >> >>  
> >> >> -	/* insert PMD pfn */
> >> >> +	page = pfn_t_to_page(pfn);
> >> >
> >> > I think this is clearer if dax_insert_entry() returns folios with an
> >> > elevated refrence count that is dropped when the folio is invalidated
> >> > out of the mapping.
> >> 
> >> I presume this comment is for the next line:
> >> 
> >> +	page_ref_inc(page);
> >>  
> >> I can move that into dax_insert_entry(), but we would still need to
> >> drop it after calling vmf_insert_*() to ensure we get the 1 -> 0
> >> transition when the page is unmapped and therefore
> >> freed. Alternatively we can make it so vmf_insert_*() don't take
> >> references on the page, and instead ownership of the reference is
> >> transfered to the mapping. Personally I prefered having those
> >> functions take their own reference but let me know what you think.
> >
> > Oh, the model I was thinking was that until vmf_insert_XXX() succeeds
> > then the page was never allocated because it was never mapped. What
> > happens with the code as proposed is that put_page() triggers page-free
> > semantics on vmf_insert_XXX() failures, right?
> 
> Right. And actually that means I can't move the page_ref_inc(page) into
> what will be called dax_create_folio(), because an entry may have been
> created previously that had a failed vmf_insert_XXX() which will
> therefore have a zero refcount folio associated with it.

I would expect a full cleanup on on vmf_insert_XXX() failure, not
leaving a zero-referenced entry.

> But I think that model is wrong. I think the model needs to be the page
> gets allocated when the entry is first created (ie. when
> dax_create_folio() is called). A subsequent free (ether due to
> vmf_insert_XXX() failing or the page being unmapped or becoming
> DMA-idle) should then delete the entry.
>
> I think that makes the semantics around dax_busy_page() nicer as well -
> no need for the truncate to have a special path to call
> dax_delete_mapping_entry().

I agree it would be lovely if the final put could clean up the mapping
entry and not depend on truncate_inode_pages_range() to do that.

...but I do not immediately see how to get there when block, pfn, and
page are so tightly coupled with dax. That's a whole new project to
introduce that paradigm, no? The page cache case gets away with
it by safely disconnecting the pfn+page from the block and then letting
DMA final put_page() take its time.

> > There is no need to invoke the page-free / final-put path on
> > vmf_insert_XXX() error because the storage-block / pfn never actually
> > transitioned into a page / folio.
> 
> It's not mapping a page/folio that transitions a pfn into a page/folio
> it is the allocation of the folio that happens in dax_create_folio()
> (aka. dax_associate_new_entry()). So we need to delete the entry (as
> noted above I don't do that currently) if the insertion fails.

Yeah, deletion on insert failure makes sense.

[..]
> >> >> @@ -519,21 +529,3 @@ void zone_device_page_init(struct page *page)
> >> >>  	lock_page(page);
> >> >>  }
> >> >>  EXPORT_SYMBOL_GPL(zone_device_page_init);
> >> >> -
> >> >> -#ifdef CONFIG_FS_DAX
> >> >> -bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
> >> >> -{
> >> >> -	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
> >> >> -		return false;
> >> >> -
> >> >> -	/*
> >> >> -	 * fsdax page refcounts are 1-based, rather than 0-based: if
> >> >> -	 * refcount is 1, then the page is free and the refcount is
> >> >> -	 * stable because nobody holds a reference on the page.
> >> >> -	 */
> >> >> -	if (folio_ref_sub_return(folio, refs) == 1)
> >> >> -		wake_up_var(&folio->_refcount);
> >> >> -	return true;
> >> >
> >> > It follow from the refcount disvussion above that I think there is an
> >> > argument to still keep this wakeup based on the 2->1 transitition.
> >> > pagecache pages are refcount==1 when they are dma-idle but still
> >> > allocated. To keep the same semantics for dax a dax_folio would have an
> >> > elevated refcount whenever it is referenced by mapping entry.
> >> 
> >> I'm not sold on keeping it as it doesn't seem to offer any benefit
> >> IMHO. I know both Jason and Christoph were keen to see it go so it be
> >> good to get their feedback too. Also one of the primary goals of this
> >> series was to refcount the page normally so we could remove the whole
> >> "page is free with a refcount of 1" semantics.
> >
> > The page is still free at refcount 0, no argument there. But, by
> > introducing a new "page refcount is elevated while mapped" (as it
> > should), it follows that "page is DMA idle at refcount == 1", right?
> 
> No. The page is either mapped xor DMA-busy - ie. not free. If we want
> (need?) to tell the difference we can use folio_maybe_dma_pinned(),
> assuming the driver doing DMA has called pin_user_pages() as it should.
> 
> That said I'm not sure why we care about the distinction between
> DMA-idle and mapped? If the page is not free from the mm perspective the
> block can't be reallocated by the filesystem.

"can't be reallocated", what enforces that in your view? I am hoping it
is something I am overlooking.

In my view the filesystem has no idea of this page-to-block
relationship. All it knows is that when it wants to destroy the
page-to-block association, dax notices and says "uh, oh, this is my last
chance to make sure the block can go back into the fs allocation pool so
I need to wait for the mm to say that the page is exclusive to me (dax
core) before dax_delete_mapping_entry() destroys the page-to-block
association and the fs reclaims the allocation".

> > Otherwise, the current assumption that fileystems can have
> > dax_layout_busy_page_range() poll on the state of the pfn in the mapping
> > is broken because page refcount == 0 also means no page to mapping
> > association.
> 
> And also means nothing from the mm (userspace mapping, DMA-busy, etc.)
> is using the page so the page isn't busy and is free to be reallocated
> right?

Lets take the 'map => start dma => truncate => end dma' scenario.

At the 'end dma' step, how does the filesystem learn that the block that
it truncated, potentially hours ago, is now a free block? The filesystem
thought it reclaimed the block when truncate completed. I.e. dax says,
thou shalt 'end dma' => 'truncate' in all cases.

Note "dma" can be replaced with "any non dax core page_ref".

