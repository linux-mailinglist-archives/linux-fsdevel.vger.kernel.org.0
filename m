Return-Path: <linux-fsdevel+bounces-30215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C35987D30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 04:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E7F1F23D9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1E16FF3B;
	Fri, 27 Sep 2024 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLbR3Dvq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0C79CD;
	Fri, 27 Sep 2024 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727405585; cv=fail; b=XvHjbrkPqiI2aPhS9O7TZZ37xTB/4bQc4KMaEec21IiNEAJvDcXBf81SxlbDssNofGZuTjmp3XTzGfSc1wBVoXv/88fptP7Mr5AS1qopRy1JZFSo4cm0n/mGaKEQZOtALI/PmpJVcYTU//MFJsdSXIZJprnjI35jjBaeJNJdu5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727405585; c=relaxed/simple;
	bh=qGOS1MrL/swSC6XWR4TufzIhm6XvXabBfVjClsZjsjM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NENCSnl9x/Sff7fiwUEQDwpOhpJhwmEK4WZsgOz0pOm3IgY0sqM5xCW8g/F52e1mlwpIEGErOkLdRlmxFhbQSchiEXYiQ5HROqxYewgP4ejcPeRALSOlwiWyyhbHIBDz8vhjv3xhY3TFzs7uXYyXL6BAeEdeZdDPZKS4CTBnm6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLbR3Dvq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727405583; x=1758941583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qGOS1MrL/swSC6XWR4TufzIhm6XvXabBfVjClsZjsjM=;
  b=cLbR3DvqjwqP2aOuWyLIEj6Dd0Oyx5T6rseeBwd/5Tcxc9ixGzxolsYS
   BuoKuyxMrp7hUcHDdylTsv3daBDDmzVQKnA2Sr72UJJwPgAl08MghbIHl
   HbL92KgMTDn1BFHwdZwIc4UhBhLL082Nh/rMeeDHqbpaIE+KxczXPI4Uy
   Jg6ibPovRV/M9LExDHSS8PRIkImTjz9L6ameq7EhygbxVJo/tVX9Z+HxY
   YnduuhcMly6aZbb2bPwEQ5lXMDuvGHWsaIyQfXNfEMAnfujUvnWKggyc/
   x6GQ9cV0PXRl4A03XaSrYE8MmKvhTrumtKxI3w9611rVS2zYUvX19VlPe
   A==;
X-CSE-ConnectionGUID: xxFPp61EQw2nX6oTjYXOAg==
X-CSE-MsgGUID: hJw348qFQMyVLOfUrT6ynw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26485893"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26485893"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 19:53:02 -0700
X-CSE-ConnectionGUID: slMudO9MQl2rOOMSbql1Rw==
X-CSE-MsgGUID: WNwR/KYpQN6fsxhQrA1hLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="73175711"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 19:53:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 19:53:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 19:53:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 19:53:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 19:53:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4TUtatHDhVc/swesmuLTYUiqz8VAoapSco1xrOtPDWW17WSM9g5E/In9W4BqRXFRcArIaWuB4SvNvlsmkNFN1JmKhNJUD/KgWJXa4iiSRi43maArnksTm6CIWa3jyK2j2p4RpOldyJ2xjLx2wHHQm9bz8oyvO60yXA9fXCvvWi1H8gwT4pEVWfBg5ZGXHCKyyJKXi79nYCsMJCxtdX4Ujjr34m6K796JXL2lElWBi9cPUfTdDntXkID6Baxvkr5pttgMVvcBjClfjBzZzu3KGJrIrF+TKlnosxT/PvpUKzWC2PXqwN43eqZU07uZkGWm9mwAZ25d+1lINYCBHvmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvfLx3n/QceWj6k7tIWf7K4MFu/ksbdFXoZSyMTCTpI=;
 b=oIfppxYfY/3ripzG9VeqhyA8JxUgmmBoWs3Y2Ptvu7Da9uE01QGuW6PtaHbxYHMk93wwX1pIIPeSz1b2wFH1gIqguIK6X85Ig20A6yVKLlAy8BUfHMlvmklShK7FGoVvJ3jgVEJoybaSU98VLy7lwDwdCVmqTcG0EhjN4eJrJGqT9PMbradAKA55tY37E2EafZd9TSFTgGyMp5xcRtncPRpa17iPPm3/BMNQyoc68e65pFDHDyL8aQ3RiXpHtcokBEMgTtCYbcCoIVTIO0tWcAeNqUNqFJ24pMhU4ZWIFDk1BKPEMJct3KZDFatZM6NODy+Q7/1Uc44GaFxz/cmkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 02:52:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 02:52:58 +0000
Date: Thu, 26 Sep 2024 19:52:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Alistair Popple
	<apopple@nvidia.com>, <linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <vishal.l.verma@intel.com>,
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
	<jhubbard@nvidia.com>, <hch@lst.de>, <david@fromorbit.com>
Subject: Re: [PATCH 08/12] gup: Don't allow FOLL_LONGTERM pinning of FS DAX
 pages
Message-ID: <66f61e05dcab1_964f22945d@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <78b49fc7e0302be282b4fcbd3f71fa4ae38e2d5f.1725941415.git-series.apopple@nvidia.com>
 <66f3567f76762_2a7f29441@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66f3567f76762_2a7f29441@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1446ab-e254-43ab-dede-08dcde9f7e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fMfhJGyWTpnfhMEQSr+6abOVYQShWwq7nSWywvmzOScjnz0vdtrvIRk3UzYa?=
 =?us-ascii?Q?Pt9goIZGyOKvbxk+FwjjKVoZAXAUPDalwUzcbKcdcOXLKYItI4bJjJ8Q9I1f?=
 =?us-ascii?Q?PDb8V8PgVs2TVcn1x8G7MRd1SQ0f+1c4dtilN4a/Rx0+JcYfpgwFLVmAX3Q9?=
 =?us-ascii?Q?+bFzmbZIvhpfUTyc3NB4K1zssxcwQG8Ys5DFZobArjtX3fYDSiVA1c3ZCTWP?=
 =?us-ascii?Q?URaUU93UARntQudTaDCREzJ1MPSoi0oiy303eD2Y7uWMp4kQ0xTLgugU+fgw?=
 =?us-ascii?Q?k/pg/ifxAOljl/HmnbPf0h4I8QUKW8yPN/QklFg7FSRnUw4p+X8clx6ADGeB?=
 =?us-ascii?Q?87LEm/Fsr7phGW9IqOrBMDKn/Zy/ve7fLycI8Z5K1/klqD2MyhvqYO2A5zRl?=
 =?us-ascii?Q?7WqxOi1cI/n0qaWaH9IaXQzuqOjc/IST8FygpbFzmW+soHa/MTkAqRwAJHLi?=
 =?us-ascii?Q?69QMfzaFmB7fAor7F2d2HWGDS1t/qfV9KIoBpxy7svScu2QwgMuyyAgSOghP?=
 =?us-ascii?Q?kTlBFKysz/5n9s07xBxLnbaC4PpIxKwhJT+dKkMjGC3Rkd/r4HADUCITNT0F?=
 =?us-ascii?Q?pNJFHphAHWx42+1JRnffwAoz7bM/FXVU5KfdUkG5ctaPWMvXwznN8NZ5eg+V?=
 =?us-ascii?Q?eHVZrTBtYmVObKqak3n/Ck6HSrAm4+i9jiU2xjQ9k0/7h3MqJYiyeIBE/V5P?=
 =?us-ascii?Q?JVZwIR6bLFgpv3P2RXJmUPQd2w16BrJ9K7YiV3D5q1/s1SJk8JwvjW3ixv84?=
 =?us-ascii?Q?CXOfDOfn8pMwZZNJ5rHKQbX44h1JXUvVovbZxBwwUuzAf0VR6WUtlFNhIj54?=
 =?us-ascii?Q?xxpmrLPlP2B9zVUG9fQodgRXZFVsPv5FyCs4cvoUjgulj9ZF+WcVky7hZoFg?=
 =?us-ascii?Q?yOQCsTBRTRb+6IaA1P8bijKgPKHqvlx/e7GDHQ6rkZX8JccjMv+8DazcHGjm?=
 =?us-ascii?Q?THwieebQSjD4WnQjiYvSjYYlc6SSLgqK7YYp4RnVBylbCwHi3UmFJHBxK7cw?=
 =?us-ascii?Q?7suHGgGav9stCH29ZNNG+NQC9gqQKzB57n8e+C5egfawIRYhJlfclw63VUb4?=
 =?us-ascii?Q?CTzs+VJGISEnmaBXuma5mIpp8ORc3B3dc0FBMxrts5OM+CvAN1vqWjGnc7Oj?=
 =?us-ascii?Q?nz1fi2cHsRnHtBbN7UVXhTmx8r7GNdzgq2lc6xRcf4X68CXdN5HNnADzPUjG?=
 =?us-ascii?Q?CeS6SqkjeT3+8U3F4+fsUpt3d9CK1XDxNGRvWVuA3n2RQhjgoTedTVTDpKqI?=
 =?us-ascii?Q?4VVD4TukpBJ9Ah9xB9zNWY7JYdyYnGpH4F4xWeX2/e7YeYqxNU52Rrs4TLX/?=
 =?us-ascii?Q?KvI+PO7YywtWU5X2jrAdG1t+hnSHT413a6UudpWoFOmCLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ej4MD3XCmBr/V6T7CNvD+WueRnkgEp85lJgabYWWumRn7DsczSOkZKUyGsPe?=
 =?us-ascii?Q?8mQg97ok7cZhot5lz7LtUlq67Wc/yvONFcH/HMi669nHVBkLgjc+T5s1vnM9?=
 =?us-ascii?Q?dDEm8BdwpMgBfoBzy6J9XTeBHoRyBDt+8bWk2KlNmhOElQgQxTvE47GfP/HO?=
 =?us-ascii?Q?ta9fTeHF4Nb24yPHB97FUdTHODBFeGEu9MbH6/hSXK7dIcuXAs7HhnXpd59H?=
 =?us-ascii?Q?W/g3XAW6whadQ/IScirBlAjRqDJ7gPJVKnP99AvBnGNULYXWprlT5X1p485h?=
 =?us-ascii?Q?lmudvUiDveSfUddB5KKR8blGJing5A5KcQKikaZ6qcUtoSIPl6rEHBZTNW4L?=
 =?us-ascii?Q?Vljh9802DpK6ZaiwbJuk+up9ojJmSxF43ysqPf0YavU/XXiyYNBl7fk5jS5H?=
 =?us-ascii?Q?55AMu+lSIBb9sbc6KGeEs+Jf/vS5lKHBT/tHcF1sO/rldYhy1NGGtv2kgzNK?=
 =?us-ascii?Q?m2EF7TPATB2Rq8V2LVK4D7XsjL7iv2DCSdJNB79cxhZ4H1I7E8xQZHZCHU4Z?=
 =?us-ascii?Q?kqp+TLft0iRO+S6+cmQjrzDgRR4TU/qVoXch/ihdfRrxdEHNnmdFhfp6sVPF?=
 =?us-ascii?Q?dnzQrDKaDibYSDMB4Twe9UdkSI7misQff43JdsC9Gtw2xs76J4kTPFpRPNx3?=
 =?us-ascii?Q?/JH5v2xVTPkRuELi/EHmBPnHVBuWKCfkOKmhb6bHdZsfX6rM5KAY2RFxkTez?=
 =?us-ascii?Q?zZPPs4f1fHNHfLkyWRx1mSLzycImfUDwpNYW3/wdTiIwvBkXLlyQTBadGDCk?=
 =?us-ascii?Q?y3jwtHUwJbrvlGEFeY4gmf6ORUkkW7bYGMjd1cJQw+lgTfa3J9NSi7mF0wmw?=
 =?us-ascii?Q?f6nKCbnvIYb5CZc1o1fZpMCjV0pPgEO3WwrM+0FNTFA/Ix1QS7B8V+2IGfUf?=
 =?us-ascii?Q?PLH6iVzha8Ob0GTuj7F0oAfuze4swA+sFI1DIQn6QC0bWEBNfNcJVstoHUqM?=
 =?us-ascii?Q?oq29ezCLBRQCQqprRBBuruktUjsR2Fheny2pNmkDjoesQNt1IvUWdTzAq9Sl?=
 =?us-ascii?Q?HezqQ/jq86fshyDoudH1tvtDWaCnQo3zqTzRzWVKAVDdlBYXeFfVLxW0pWNh?=
 =?us-ascii?Q?TJsuzwEjJyY/gnw7/hcVMRmibhkGCrnk0TsRHBw2Yf6HNTVImho+GA2WiT7O?=
 =?us-ascii?Q?tdEESSZFtpvlvE3FgnMAzqmVN/lfu5/lmvB9wD/c/3+LyoyB1y61HtOBNUit?=
 =?us-ascii?Q?vuDxGjRC1IB5sIfJguDBkmTn4PaUPUNbj9aCtPmoCr6l+m0fxNRI3yufDgf3?=
 =?us-ascii?Q?hDHN1dkI2n3p/D7ohMqn+SZw5bV0MhFZhzEiHagUQCmQm6vylBoJbJWpQPxO?=
 =?us-ascii?Q?y2bggw/oXNIm78xJnIDu9EnFVauO5Jz1yz4+ClT5q8qIDFah8raEfqDE7AGQ?=
 =?us-ascii?Q?JyPpG7OyByBACQf3Zqzqu+kJol4YNYYQ8Mfj8IjjSaSp7aLQW00yLDdI4vrz?=
 =?us-ascii?Q?DVJTMeKc1OySW+oeTg1tIrYVQrOKJ8x25vrlhaIT9xbatXtmSkvB8YTiJTcO?=
 =?us-ascii?Q?sde2miBWdiIQGAXFqWkrHT5eAc5VDLnacDeWVgvxtzvLAnP9FgKu8QdTy6xk?=
 =?us-ascii?Q?SSPtSyMF7wvlJ0RQWOMg24bC2r3D/Fj1KXnc2b3kMZ2m8Wy5T81KuKJ+uook?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1446ab-e254-43ab-dede-08dcde9f7e21
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 02:52:57.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr6p3xsCYkprTwTeV24UWgPX4O1aDD/MQm7Uox2G/YUE5/bajQuJa0G3EQVw0ndDGfJjvyMN9s60+NPb5FVjgwCVGr70TQ05dHTlyc/jZlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Alistair Popple wrote:
> > Longterm pinning of FS DAX pages should already be disallowed by
> > various pXX_devmap checks. However a future change will cause these
> > checks to be invalid for FS DAX pages so make
> > folio_is_longterm_pinnable() return false for FS DAX pages.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >  include/linux/memremap.h | 11 +++++++++++
> >  include/linux/mm.h       |  4 ++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > index 14273e6..6a1406a 100644
> > --- a/include/linux/memremap.h
> > +++ b/include/linux/memremap.h
> > @@ -187,6 +187,17 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
> >  	return is_device_coherent_page(&folio->page);
> >  }
> >  
> > +static inline bool is_device_dax_page(const struct page *page)
> > +{
> > +	return is_zone_device_page(page) &&
> > +		page_dev_pagemap(page)->type == MEMORY_DEVICE_FS_DAX;
> > +}
> > +
> > +static inline bool folio_is_device_dax(const struct folio *folio)
> > +{
> > +	return is_device_dax_page(&folio->page);
> > +}
> > +
> >  #ifdef CONFIG_ZONE_DEVICE
> >  void zone_device_page_init(struct page *page);
> >  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index ae6d713..935e493 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1989,6 +1989,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
> >  	if (folio_is_device_coherent(folio))
> >  		return false;
> >  
> > +	/* DAX must also always allow eviction. */
> > +	if (folio_is_device_dax(folio))
> 
> Why is this called "folio_is_device_dax()" when the check is for fsdax?
> 
> I would expect:
> 
> if (folio_is_fsdax(folio))
> 	return false;
> 
> ...and s/device_dax/fsdax/ for the rest of the helpers.

Specifically devdax is ok to allow longterm pinning since it is
statically allocated. fsdax is the only ZONE_DEVICE mode where there is
a higher-level allocator that does not support a 3rd party the block its
operations indefinitely with a pin. So this needs to be explicit for
that case.

