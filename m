Return-Path: <linux-fsdevel+bounces-71776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F09AFCD1B6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5F4030133C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5718C33A6FC;
	Fri, 19 Dec 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLgMTVz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A627462;
	Fri, 19 Dec 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766174977; cv=fail; b=qNkwCvMC8JYP9tHbIAPg6WVL0/F7l2iDPjqYlAx/+msQ5k+jIj8dhpiG6mGIFRFYNZfQgKrI6l/tz+oguSeG6Wijur6nQxq6h1W5kuqoKbZgZQRZ8vyHAcsRpxPtf3Wgiksmly+KL57f+x4hv7N4PhWJsXP6ra+EBkEzEockLxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766174977; c=relaxed/simple;
	bh=fPh2SCsz/yYDOUOCr/sCVuodYOgoK3dKz6tgAexpQIY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EavrtGsYhH1t9x7Ddi4tHSE0ABCMX4mg0Wofhl2Uw/ERWZByw6NO69ip9lPcR944lVMGWppKlL9bZQlAocu6Vl0kOtNchASelWO5jcR2l5FSACDHCH3CqUrNs9hGeWzOzhCuVY4YBN/cRilozLNxNf2eghl4MxD/y4Zv07Dm2C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLgMTVz+; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766174976; x=1797710976;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=fPh2SCsz/yYDOUOCr/sCVuodYOgoK3dKz6tgAexpQIY=;
  b=cLgMTVz+xx/UxKeoRKUmYl7oESx5CzEGx1bxpHxP2mTxyk6vYoaUVOWv
   NP3SyGwIQxLn7onQEFqGhU3+b+4m5Qwfe7wD5q+snivnV3EgLih992rzY
   YJ91nESvrvO+8uDMFHK4oruHkdIzGZyeo3pUgipw29WEckhKjL1n1xUPg
   lcyy7CwNJRkzdAaof182zEy8KhkKw6J+wWnqsJtM7x0v7j6q8ltYrX4To
   +nqizmofktnQndvkAk0W+ajPb4pz5+TYDsLiTvu6qDXzK/OoRqKTO1qNS
   v6t4KO2QCwB6PTxCCU0kKKMtNJaLo2XS/BSmw/pY2M01cIc3Uey6oURH/
   w==;
X-CSE-ConnectionGUID: uXmY6nrnRYaeZIJTtZqzbA==
X-CSE-MsgGUID: lCs4RFD0RqulTcoodix1jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78853644"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="78853644"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 12:08:53 -0800
X-CSE-ConnectionGUID: m4vvNz+5S/qBgmcvdjpaSA==
X-CSE-MsgGUID: t6RZFUH3QlSE1cNiRBx+tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="198202394"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 12:08:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 12:08:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 19 Dec 2025 12:08:48 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 12:08:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRE4DP+2nEDSi2P2VzS7RhWMMbqwNqGY8Tiu6XvQg+fRKD/lkJ4Fe8KolBuRQ0UXsu4GlwVqeAq+/tgqK70EFAByNi/FY1L9ttTHKtQLoIwStQXWEd8XOc7K/YwE3biQwQZ1kiz16XWaOCqAatyqzzEHbo8bb5GQ5J2tkaMv0Aqckj3uqVHcZ4FFnH4jG/GAlMgR+A3Wq5MBwpY60fN0F1ilHb6TWMMlP5M/u8bvpaUmoarjhl8dV9yLddk20bNDg4cCvZAqCrS3pf/nn6XoBd/oWk8xt60MVGHLp8baSp1nRiZuTaLDQBoj6txOsp4MbNdEhrxsAI972VEgexrXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiLSgw8nmf8f1MgKMOR00gdgBTUVY+zhs+D5OQjoqnM=;
 b=A96B7PhF94/huifsRrgoQpmTRPwgkdyqCyQO9Y4BXE4ZWK/+8Tq+aQMFA1Y72WbourhUb9/uLVE/ZvFLb8F4croMHGk1zulvHrQD6jvCrCi3sWcI5U3+N5HNgQEnX8J/VfbFo9nnf/AMHYxSlLe6YIOyLCwB6AM9/pfnvkaEdlWgYMqpzcQgp0tzy7zX83r+zGiwFoK/9bXHr7picv5f5hureejMdVHqTAabzbPTsx/YIdqnd/+bfQvNbiIUJl9IFSivbVgN09je1OEgk+poOASqVnvgW2QveLfx7HXyAhr0ZSEnPQjR2oKRz1Hf6XRxqDnTrW8Aek76/Bw0alv9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 20:08:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 20:08:40 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 19 Dec 2025 12:08:38 -0800
To: John Groves <John@Groves.net>, David Hildenbrand <david@kernel.org>,
	"Oscar Salvador" <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: John Groves <John@Groves.net>, John Groves <jgroves@micron.com>, "Darrick
 J . Wong" <djwong@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Gregory Price <gourry@gourry.net>, Balbir Singh <bsingharora@gmail.com>,
	Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Aravind Ramesh <arramesh@micron.com>, "Ajay
 Joshi" <ajayjoshi@micron.com>, John Groves <john@groves.net>
Message-ID: <6945b0c636de7_1cf51005e@dwillia2-mobl4.notmuch>
In-Reply-To: <20251219123717.39330-1-john@groves.net>
References: <20251219123717.39330-1-john@groves.net>
Subject: Re: [PATCH V2] mm/memremap: fix spurious large folio warning for
 FS-DAX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9faf6412-ea2f-45c1-4b4d-08de3f3a66d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0ZYRWliWU1iMWhVVmZRR0dsZmxIS2dBVTBFNlNHdEIwNWlZRnBxelBoNXFk?=
 =?utf-8?B?WStxTmF3aXM2VGFsb1JWZ3dOSmY0SnNDUGM0TStHa0ZrTmNoMDZnRjZhUE0y?=
 =?utf-8?B?Tjd0K3BhTmkvdUw3bmZkSTM2Ykxrc0FxRktFM2l5dGxYbUFjMVZ6VXdzaFdx?=
 =?utf-8?B?Ym84ZCtqQ1dUa0ppNWwyTm45bzB1MFd5ZE9mN3hzc3hoQzZMdXhMaTFLRWEr?=
 =?utf-8?B?eUlScXR6OWpLYm41NHdFOU5yOWJsRTcwTFRGNXova1Z4WFViLzFoNnkwbHdL?=
 =?utf-8?B?MkJvbUg4RUJleHAvMUw3RzdjeG1FTFpSbjR2UDB2MG0zVVNMV0tlTFVrSkRh?=
 =?utf-8?B?bXEzV2NwSnZBZGpOcmFmTGZSVmtYZyt3V0JrNGs1U1Avd3BFN3pWdGFtR09z?=
 =?utf-8?B?UFVraUViOVlhZnhTQUovYldFYkZ4WkNIcWFTN3FVWm9aTU1sdDBqK25nTmZi?=
 =?utf-8?B?OUNLZWNaMVZZRVpXakRHNDJmYWllVVNiSW03eG5wUitXeUQxaThacWxuUmRk?=
 =?utf-8?B?ajVUWUdLNzAvUkFGbXB1ZkdwOTVpMlA5QXR5VDNac1pFTElzTjkwWEtRTEo3?=
 =?utf-8?B?RFErMWM3cGFVOVI3b25SYk5Kd0tQb1Z2bFRWV3VaNi96SXZFZFhCK3lxNkFF?=
 =?utf-8?B?aVZSWlV5QWg0NUh1Ny9vZCswZlJyQW1WcG9GV21jTFFTQnQ1ZkpyejlETlY0?=
 =?utf-8?B?SENPam9kWk1CMmRpMG52dmFoSGJ2TWFBTXRlUXhRMEVSSlJhT1p1bHFkQXpa?=
 =?utf-8?B?QjEwNll2aFlGWXdqTXRaL0xiME1kOUdsMGZaZzJYSzN0K25UR0dTQitta2xx?=
 =?utf-8?B?M1ZLaHFQckNpWk45eHZ4ZFF6TlNxTnJBVlI1R3I2eG1Na0pLeEllMkliS1FM?=
 =?utf-8?B?dUF0T0p3Z3Zoa2dBeHRBUDNlQldYSm1MdWV4OWtBZ3VNR1crRlNYS0xqWXBQ?=
 =?utf-8?B?U3hCRjBPUm5HdklIUm9lcUswNlpLUDBBVEJyakQ5aXZxczFmOVlneDB4Q1Yx?=
 =?utf-8?B?MjZHRWVOSHVyRXJ6cWY2UHVoQlJzQmtnMWM2TXRoaHU2blJhZWVJYmhQQTQv?=
 =?utf-8?B?WFgzN2ZVSDFEalErKzlqOUtQOWxLcmdWRXJFL2VzMXp4OHBYZlN4T2FEaVBB?=
 =?utf-8?B?cjFXWDRYWjNvUlpOdW5TOFlxeE9DV2pkc1BpcGVkclAvSnNOYkpSNFFuY0FS?=
 =?utf-8?B?cWs1MklSTG5VVTFWWHNKZ1VZQmxEcXhTeVkrK2FqUUZSN1N5bG1JU2VtUkZJ?=
 =?utf-8?B?SWxBYWFZeTAyRkhrQVNwQUlpY2FWYmEvcUo4VHdpSmVhSlNIZVVKakRqeDJa?=
 =?utf-8?B?MFpOa1M5YXlCMnNwVk4zbyt6c1ltYVZtMFdNbW1WcGVXcFdFMlV0djVmU3pk?=
 =?utf-8?B?OFZhWWZ6MUNsdWZQd3BiMXZkeWNFY3MraEp1TmwrWU1jUE90ZXlUYnAvS3R5?=
 =?utf-8?B?bm1GQUo0bGdJcmpUb0p4ZElBdi9heHpjTUpaYnNteWgxOU85dmx1b2ZHN1g0?=
 =?utf-8?B?ZG4yS1RjUXVLK0ZyRTZORlErdzlLYzRFeGRReHkwS3VSYUVjdkNvWUg3c0VE?=
 =?utf-8?B?TWVnZk1Cd0dyZ2VIN0lubXRCY0V2cTMraU9GRzlRaVJjM0dDNERGYmErdWpX?=
 =?utf-8?B?azZmNURvUjZBMHp2aytNVkhlc1NrZUtxdlRWRDdaTXpCMFY1ci8vYUdscVk4?=
 =?utf-8?B?ZW9BeFNFakNyQTFmTWxjSHFhajRQN0FSS1dHR0p0cklpRXl1MCt4bmM3cUg3?=
 =?utf-8?B?cm4zaGlKVGtLd0R1bFF0Tk5zRnc3dW9vYzZOR3kxYzM0a05Ea0pxWktjYWM2?=
 =?utf-8?B?M0RQeFIzaGlPWU9IMkNwU1dlTE82SU5NNDNtSlBsUnhzSHpYMFlHVW9rdWVV?=
 =?utf-8?B?TGhuZER3M0o2WGZwaldRbFRqcHROcTRWeXB2TldUWmxOMGlPSkpVeExqeVJN?=
 =?utf-8?B?MkxEaDd1U1oybkhZVjAvckxtL2FCLzFCWngrU01xbG92ZTdsTFhQaEpuVWlH?=
 =?utf-8?B?VUVFTDZLa2FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC94MHpvdnM3VU9pYnZzNjdteDZ1VlY0dHZvQVRrUmRUMU9HbWNBZnYwMjhH?=
 =?utf-8?B?SlhYTnhxRThUM0Ewc0VtVE5lVnlRVGZuU0lsbEpWN25uM0ZwZXRxdHp5SWhW?=
 =?utf-8?B?Z1AwalVNVkNndUZVODBaV3BubkMvaVJaTSthZHRBQWVSTUl0NnQ5ZUVFVlNh?=
 =?utf-8?B?Q3BWRXZNNi9lNUJ1SFpQQkJ3YllmYTk2c25lT2gvWVZFU2dvQi9mZ0w3UUl2?=
 =?utf-8?B?bGJ2SjdrNVNKTk4yUUFxRzVhVy9sbGoyRlpnTWtKNTVtVTdySSt3UEZPZzNa?=
 =?utf-8?B?ZlNBQjlYZDJrMkNMdzM5YmdlaUdBWk5kenFJSEFHNHJrOUgralNCTlNTRzdk?=
 =?utf-8?B?aXRvYWI0MSs5WFlKUUhwbGZXdThSM2RtMzBSNy9Cb2ZDTldFWk9XYW9Jc3V4?=
 =?utf-8?B?d3EySlRVY3M0NlliTGMzYXA0UHI2eVRDYkNvMmE1NTM4WmFYQ3Rkai9DckRx?=
 =?utf-8?B?amJTY3I2Y21oREpiYnYyWkdoNEs5VWdrUWtBTTFRTkdIVU5VQncxYTlzV1Qr?=
 =?utf-8?B?QWtkM3lNY2REcDBMeVREZnJIMzU3cWYreDBMMHdhbDg4M3BLdlN4bWI3QTVU?=
 =?utf-8?B?QklROUZxSVNtTFhGVUJkNndZQnhRTzd1bDVwYWtVek84REQ1MFhlN05RMlNq?=
 =?utf-8?B?azAvU05pdVN1QkNreU5YTEt2OUQ5YTQvbTMrU3RGbmpLcEhRb1VnTHhtZHBK?=
 =?utf-8?B?UzJoY09nWXNNZ3IrQWhNYmJnaVVTQW5vRnRrUUlPVlNTUXB2TjlaYlBDaDlI?=
 =?utf-8?B?WElmRDljZ0RBUDFBbkt4d3JkUm1ObWh4MjN1Tld6NlJRcm04Q3E0S1Z3UlBJ?=
 =?utf-8?B?QmdKd0tnY25TOWhFTU5abzQxZTdoZktqUTZqazNXOWNxMVJoaThhMXVpaTRO?=
 =?utf-8?B?OHF1blZmVmRxQjVQc0FxNE14RzFJNkQxU1RIWi95RDNYL05IbXBzaGxVQUJw?=
 =?utf-8?B?R0ZraHE2WUpIRmFwV3FJM1kwUFhua3N5RzFhd01xcUpmeFhvZFNpbmxlWkda?=
 =?utf-8?B?SWx3UWZlNXlVcm9WV0wvaStCajJiWWpPYkdhV2ZHZWNBTWpUSEsyWnZWVEhP?=
 =?utf-8?B?Q0VrZTB3ckd6a0VVdlRlUStzWTA0MFl4OFlLU0VrSE95ZUF1M0JqRnJVbUFp?=
 =?utf-8?B?N3BTcTI4bWxHOHpxMkNscnpMUkhWKzdDQTZLdWF0bjdMVlNISnZlQUtIQ0Fi?=
 =?utf-8?B?eTNGN0NYblBhbW9ydWd0a3dGeDJsQXp0OXN0MWVBOU5EblhGelJ0ajJHMGZ1?=
 =?utf-8?B?cERrMFNqUzBoakVZcnZ3d2h3cGtFYkNnbHNxa2lHTkNHVGpqSDhZdCt6WVpY?=
 =?utf-8?B?ZTJNYlY2bmlSdmlyUDFWa3JMQU1GNEpJWkZBWVl4L2lEa3dwRjZZV2dsV2dZ?=
 =?utf-8?B?ZEhwcW9HOEFNNGo2QUJ4TE9PYXNSN3dDNEl1cnNmUGFkaWJPc3lUTzhZOWJ1?=
 =?utf-8?B?Q3UrRC9ybDU2cWVISTNKYVlWWlA5QzFSdURObGpVNU9qL05UNkJxUW5BUE03?=
 =?utf-8?B?QVFpbDQrdXRPVTgrM0lCOFVQQkFnVnFUMmFxVGlER1dwQnpaMmorZFlTa21u?=
 =?utf-8?B?OU5rQWFjWVUzWGhyZ0I3d1NvNWJaOHdobm9IdklhcUpZemhpbittWEMxanI4?=
 =?utf-8?B?bmFXUTdLZXdCbDVYaUU4a0dVNlVic3RWaW82d0FVZWFUV2w2Y1R3N1ZmOVZ3?=
 =?utf-8?B?ekxLK3dYVkREdnJHL1dqQUpWMzFBM2xRQ1Y3Skk5d3NRRGFKdzIxR0FFa2pa?=
 =?utf-8?B?Njhjc1VoVmhqYUd5UEdQR0MyTFRVQ2lwUVVWa3lXWFljMVdvVGMzQUNxbDFr?=
 =?utf-8?B?NUVCNXMzZzR5enlvS2UybEVDcnE1ZnpLVjZSa1BzZU9LS3RYSUFQWktwWnU0?=
 =?utf-8?B?eUdhcndPUjRDZk1GUkV3cFJHSkVLMFRXeU82SmdIblZKMVNpNm5FdWVwaHk4?=
 =?utf-8?B?WVdiNFBDNUd5MVpCOG1TWXZRNC90c1dPbTVPb1BnTkFET2VSemsrbmF2Q2ll?=
 =?utf-8?B?eXlsUVhXd1VwYWlCV0YyOXphTWx6TlhlWWNtZ3czd2Jsb3hFNFRnUXhibWFy?=
 =?utf-8?B?QW4vV2dWWVprQ2xnbnI2ZlcyaUpZZkNVTWF3Y09jblA0eTQyL1dMbmVJTVY2?=
 =?utf-8?B?OWdacEhNREM4d3kwaU9WdGZXRmsva2J0bkZBYUdqNkVOWTd3UkZlcFdyQTBp?=
 =?utf-8?B?b0xKb1hYT1lJOUg3ZUZFeW5aN1ZPNjVHcDU0RVVmWlplTHBiYVJEbVY2cmNl?=
 =?utf-8?B?Z0hoOEh4SFRBNUQ4N1lBbUpmcTViaFpkRGFPYUgyUzhtT1NFNmRkUmZERHhV?=
 =?utf-8?B?K0NURlhrV3ZnWjNyajNDV1ZmanZGTnRuVXE0Z0c2c2RCOG4wdzhtSG5GNGVh?=
 =?utf-8?Q?3xdp2ZNsOqZKf3z0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9faf6412-ea2f-45c1-4b4d-08de3f3a66d2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 20:08:40.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IZmcLskM7rednTYYWnm/ykwKbne4GkVqYfod9RU+x2b7/ryuWXQNTnp69tGchL5cRiqS/7cYLaW2d6DH+C5nVl7IJSrZfDPFats2rrb7Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5273
X-OriginatorOrg: intel.com

John Groves wrote:
[..]
> The fix is to exempt MEMORY_DEVICE_FS_DAX from the large folio warning,
> allowing FS-DAX to continue using PMD mappings without triggering false
> warnings.

As you note, this patch no longer exempts MEMORY_DEVICE_FS_DAX explicitly, it just
removes the bogus warning, so maybe Andrew can adjust this note on
applying?

> Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
> Signed-off-by: John Groves <john@groves.net>
> ---
> 
> Change since V1: Deleted the warning altogether, rather than exempting
> fs-dax.
> 
> === How to reproduce ===
> 
> A reproducer is available at:
> 
>     git clone https://github.com/jagalactic/dax-pmd-test.git
>     cd xfs-dax-test
>     make
>     sudo make test

Thanks John, outside of the fixup above, this looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Now, my first thoughts when seeing this were:

"ooh, I want that test in the regression suite"

...then:

"wait, that sounds exactly like the existing dax.sh test [1]"

[1]: https://github.com/pmem/ndctl/blob/main/test/dax.sh

Alison reports that indeed that existing test triggers the problem which
indicates some process problems to solve.

- Folks touching mm/memremap.c (and anything dax related) do not know
  about / run the regression tests.

- The bespoke nature of the dax testing environment needs some work to
  get it into a kselftest amenable flow, or otherwise need more
  automation to run those tests automatically upon seeing those files
  touched in linux-next so folks see breakage like this earlier.

