Return-Path: <linux-fsdevel+bounces-78472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDHmLxNGoGmrhAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:09:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6951A61DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A4F430FD746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BE30AD02;
	Thu, 26 Feb 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXkehMmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA93043BD;
	Thu, 26 Feb 2026 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110988; cv=fail; b=PtMs/Md7zo9U64mTeTHWRGr6p9+xykGG6+Carg9VBMpMS8ikPK6R80e5772SX1bndxi/lB8aubyXKQCHV6wa+pqw7l4S6sRibhcZ6FFqkD1HiPECXprzQvcgZn8SMagzwBbEdVkEjWv8/G8y99wkdZitr4ZKbk6W/g1RzTapT2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110988; c=relaxed/simple;
	bh=ymD1BOq3ejQ3/2dAm0Sr5Qtb9SoTRSnsO8+gdDm2gI4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qJ8PoLgqtD/IKIMUCQiybpiU6cxWxqS0IU/FE6R9GQMPRHH6UpLD06UHENPD8W1MnuqDYZsDgIanklHTXlF8tZGGWqYEJ7cQDudHZJ22vmW6R1/lCvXvso+WsJBJDjcbrTu0yNLK8+l/F+A/xtzP6Q6VBk2ZIubhwWe/57+7+bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXkehMmY; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772110987; x=1803646987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ymD1BOq3ejQ3/2dAm0Sr5Qtb9SoTRSnsO8+gdDm2gI4=;
  b=FXkehMmYnfuzNSjOr7aNoBqd5x7BJzStTcquPN2WJaKRir1CNGpIPqfx
   F7hIC805edRN5nwhdzaDYRROa0wS5dUKE4WcyADnav/fsbH8OYaas+CbH
   23OWKpncMsVYQzxdtVWeqlVJ6sfmkRmyBkD3KVrMgyeXbPalnDC79KAt2
   S5mHG87hBXGSJPjwCCQSUx6TR106M5XTYUyW/wPGyLynO9PLgoaXn1Z62
   gXK1v3KeoiEDhUQHgBrAGKFJQ0tRf2PXxmqnp6+xjbWqBrvluHK+GJQCW
   SfsLH/wp67oS6u474YtwOhhNAPPO2hJxlNIg+/c654PiCovwt/zLKRnbw
   g==;
X-CSE-ConnectionGUID: TetmCEKuT62NLnsHTLDACA==
X-CSE-MsgGUID: KzFKykj2SrqUzNlHArL6pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="95786794"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="95786794"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 05:03:07 -0800
X-CSE-ConnectionGUID: iu4vKxcBR1qI8SFeOkwu5g==
X-CSE-MsgGUID: dHzcfaGuTGq2wb2s7VNTRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="239549161"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 05:03:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 05:03:05 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 05:03:05 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 05:03:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+gf0+ojDoE9GEV53L51Mid7s6Sy0Ai3y4uIfPshUxhf6NtyUtDJYrC8ARHumHF8MOqo0lQ8ZYe+PA+XQsA1BHjqDoBZvdUvBVevdCDC05vdafX4WKoHzG57sOIyBxPahaEoXmVvXjbIXtCv4KbwQW/00c65jaVC3/qYk8LFsuHmiZphp+AMQuZh7rqSXjnPEQ9vRwoL8xZiVaybe6nf2jj9vrDkDIK0no7jPJ++6PA7iykofdKJS1dY7CNG9kxEBafVU5bl3W1PHKger84sW8lBzmmU1WsrEHu/V9vWpIkF71i5IhBqtr1bqw9tmpd2QycV2U6Otk6yGWs8aCjUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLCT6EXRW5gAPXCg1G5HjTD+PNK5L1Y7omAGZQwnF5k=;
 b=DYmdWDHONOjitzb01Ozp7VmPd2UPPZF0K6ZggzUAlLro7lDiM7NYX7UO8toR8Y77WZldHXsgP+IO+8hct4OT+oDh9dlXNLHO44MPGMLXZdYqE20iGxfVrVoPdBgqpWR8F7m0N5R8fn2Ze8hGDzXIWl5YgjDg8ZEy8KxJy3qo/6JnEwprnsqK5IXuvA6q7P1DWQslC1hWLZeGoELUfVZA+P+NndzC4By7vaNEqZ8k51LWIvzRoST62+mj5j/n3PgLJB9bRxNphrnv2YkZl7scTG3Pb/gnEJQiTuKLkRnDZ/B9afuqtnfrZHhKzoiATOxlc2H4M53FotsgUSIYywkfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7871.namprd11.prod.outlook.com (2603:10b6:208:3f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:03:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:03:02 +0000
Date: Thu, 26 Feb 2026 21:02:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-nfs@vger.kernel.org>,
	<devel@lists.orangefs.org>, <linux-unionfs@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fs]  761475268f:
 BUG:KCSAN:data-race_in_atime_needs_update/touch_atime
Message-ID: <202602262015.d00ee0c9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e4857b-ef74-4a90-5dba-08de75375fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: dAeIMkDv7G4kqmRwYs3TWodHKDPuwcOViay013OEV4/5KzqJn/uDJhxia2Uf4eXVUqV935/eiElVb4YZnv1fzFPAf3RIdB+I3c2tlBhpkV/JhSrv9jY7hvbzNmAPQMhMUPWm6AtVfWlDcK3Z+pNhu47kVjOqZxtpHWELr6bsk0lUUnUfoYNETMdMy1hQUwQ8Eno4290aeoVjGj0Fjk12a7aFUiNxsPzMlccyDp3BJP4PUlJ2PNgFyzparbniewQ09qSvKn68J56CCzAyx0Merijd//jIrJgbqBpf7iueS3gk0mH5tY01e0h5RHymILYwIuk3sFhW9vtQ77LkFbWJi5JOnH+QT8TWySVOiDorVa4Tn/LfiZvkto1rWcgIyfXcxejUG5QhfuiNMtaLYHFfQipsn214Ai//asGGgeY6mbtcpJylRAkJUlaXFnD1V0w9vwt9hzlL1dH8sGd/I8wDi4us1oG+OwZJITBa6lQ7lIpmVQxJ1PJ8FdObefTPOqJ6U3GnZLnitl8xcvjuEZjvbXoBKlSHXbOJ9ofyS0HzitCpM+vXk/skJAHQPhyyqsiDsdX/KcC4m802TWndoqwoKCfshWc+9/HhKI/kMCjHxsXTLsPlYM/0QDwc1uMeQc6IP5/sMgvx1HAjdX3/bMY2PFI5AB2oxkP/woXbZRndkasBKozQh/8rQDaKcC9uyULk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYVweZdNkHdbawzadXh0PqqD6XgxU4QezXQHYwIU1fVfFQJGkSVmyfkkSuVj?=
 =?us-ascii?Q?sPVVldC67T45I0Y0g49Ve8tE0orh2SIvTwcXQNcUCiuPY1wJ5/ukdiXdKQ8J?=
 =?us-ascii?Q?uQ0gamNqsdewc1Rzqjom4HMKI1OAWRUL6SDCbtDSuLjtnJlFHaJPtVZ9Cmiw?=
 =?us-ascii?Q?3imgMQE86l9huiior0rbsL2uINzbuFGg0Na8gMtj/sktnpQvyuljSM5rlMI/?=
 =?us-ascii?Q?zZdiIDHYqZ4XlfOTdcaTEl3++uZ7yjwcLSRmrvJbd3XvEQxkVS5H7Z/6/EMv?=
 =?us-ascii?Q?W4WWxv2KXZn+lzYjvfiT+KALNG2UH0s8deKGC1Miq4NOYbvsEtN3ROC1Wkyu?=
 =?us-ascii?Q?eVAR6q+Zqd5T8uENBXjeytuaIre+aH/h2wfUeXhcUhqA+iL8I6mWBQjfuOaz?=
 =?us-ascii?Q?H3ozoWNEex+uZ+qIV60EgOo7OCv7sniUm9a6Yta1zu9ZfOmRcKjzXxgoeGg+?=
 =?us-ascii?Q?yJp6S83akIVlHd0lG5YF2FQgClnCs7fPFsEmfjzOAhbj8LdRnfm4DI2ywjjN?=
 =?us-ascii?Q?dsfUXZB+ApHjuF2hD66ZE680oNZ8BskmgQXKJE1ThtpwnsRc9+weQbFR2oSU?=
 =?us-ascii?Q?iO8eaS1nJ7vBfqFvssp2icn3cavm4qKogBEs4aPX2oloy6X0Ya3KOqK2+eHZ?=
 =?us-ascii?Q?4CZtfSA8dYBUWOHaJfWnj3DiArT8AbI+69oRPwhCQdyzhyr6/lqzcp+mtsON?=
 =?us-ascii?Q?aG0XxnXyzqr3Fgaj8UWktxE6btNXjJIRxZhCOSsb2agpnkLzHn9ChKsjd5H+?=
 =?us-ascii?Q?3AjCy9UCIghV+eNo1v909xNZQ3i+nsOyjT1fNeqa47n4hxhXwn0Z7PVfIJKA?=
 =?us-ascii?Q?QkgEA5MeiEBue6o2dg2qrSMShpMbkQUkqPynBy8Z2cpCd3LdkicL5XJz5B8z?=
 =?us-ascii?Q?1NsOXKOdBNWnXaOnbEOQ2FzRVbE/U56vtitF2V8xdwIgnOiLQl6+SQlkZgFZ?=
 =?us-ascii?Q?m7ZA1zbPUpPKGqjv8qla4BAXjyJTXNYKpd1O+VScRILVmsz/dcwuiU8SRzMT?=
 =?us-ascii?Q?3VxVVe5b+uJzZKCrA8v3LO53BrO0uwTvKF8Kh+Xth9xWX9IvnWRdHora5Fbe?=
 =?us-ascii?Q?oc5bFEU5ExR+DZZOu8xJyk4Hqrl1Rxn2uOu3t9dErjnOrsrmFDjLxpzrvLzY?=
 =?us-ascii?Q?7SGmweGncTWijkYX+UdaRAsG2NuLpO8vgD+4ECEfYp3kMl+ita/VRVTkbMUj?=
 =?us-ascii?Q?S/RSP0sGlStYVdef2vGbNx51x54wsmIFRdI9V4xpXuAD1pTUPQTSMC4omqoK?=
 =?us-ascii?Q?n9J7FW3uZZIiqneN7SPMEvcsy+PWSlBCe87DeZCvCnGS/Yl8B3ontGd3pULc?=
 =?us-ascii?Q?4Ik7nDdVe9sxp+NmNLMwoN93+LjSBQwDgMDxlgvnMOuc35mUz8d/eZNIqYKw?=
 =?us-ascii?Q?7R+QW8wX4ZrINed7tFq2qfZ9HMZ02cnTa7+NW0Vl45T3ImY1Mb8mqoyecse0?=
 =?us-ascii?Q?v3GjT+/PIeJSaRABRLylL7sXtjQLI3niWuieuJzDf47R1EvmPijMRxs6vV8s?=
 =?us-ascii?Q?JydWjTUrp9XnYBEZXfJNOqI4awVtlG2GzX3lU4dpjONrusTc03dD4gaQumzC?=
 =?us-ascii?Q?XZi1idkPxMZFi4x3vmzRSiCMT/1lVbiOEze+MiSGMQSPkBsC6/K26BRlCajb?=
 =?us-ascii?Q?5+RpOYRfDfNVDTXJjY515jaYYkp/BWBHroMv4xbJC0HFOJ0wBlAX4K+fVK6r?=
 =?us-ascii?Q?1ysB1VlcuQCD/1DbtMMNovzWxIJtLqqa7bAHPqT5C3T0d0wZAoQhO9aOO6UE?=
 =?us-ascii?Q?EtBcnVsEHQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e4857b-ef74-4a90-5dba-08de75375fe8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:03:02.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tly7fc2h+iZueUAa7IlWxo9KhCik31RxqsEBimhaik8QY5TuRx81GBmaRUaiNEAGIrFe/zDuyHOc4w2CM8mrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7871
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78472-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1A6951A61DD
X-Rspamd-Action: no action



Hello,


it seems to us this change causes the stats changes for various (random)
KCSAN issues. just FYI what we observed in tests.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
  vm-snb/trinity/yocto-i386-minimal-20190520.cgz/x86_64-randconfig-013-20260223/gcc-14/300s/group-01/5

1cbc822816758b26 761475268fa8e322fe6b80bcf55
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          1:200          2%           4:200   dmesg.BUG:KCSAN:data-race_in_alloc_pid/copy_process
          1:200         -0%            :200   dmesg.BUG:KCSAN:data-race_in_atime_needs_update/inode_set_ctime_current
         32:200        -16%            :200   dmesg.BUG:KCSAN:data-race_in_atime_needs_update/inode_update_timestamps
           :200         17%          34:200   dmesg.BUG:KCSAN:data-race_in_atime_needs_update/touch_atime
          1:200          0%           1:200   dmesg.BUG:KCSAN:data-race_in_credit_init_bits/try_to_generate_entropy
          2:200         -1%            :200   dmesg.BUG:KCSAN:data-race_in_crng_reseed/try_to_generate_entropy
          1:200          1%           3:200   dmesg.BUG:KCSAN:data-race_in_file_update_time_flags/inode_set_ctime_current
          2:200         -1%            :200   dmesg.BUG:KCSAN:data-race_in_file_update_time_flags/inode_update_timestamps
          6:200         -3%            :200   dmesg.BUG:KCSAN:data-race_in_generic_fillattr/inode_update_timestamps
           :200          6%          11:200   dmesg.BUG:KCSAN:data-race_in_generic_fillattr/touch_atime
           :200          1%           2:200   dmesg.BUG:KCSAN:data-race_in_inode_set_ctime_current/inode_update_time
         22:200        -11%            :200   dmesg.BUG:KCSAN:data-race_in_inode_update_timestamps/inode_update_timestamps
           :200         10%          20:200   dmesg.BUG:KCSAN:data-race_in_touch_atime/touch_atime


kernel test robot noticed "BUG:KCSAN:data-race_in_atime_needs_update/touch_atime" on:

commit: 761475268fa8e322fe6b80bcf557dc65517df71e ("fs: refactor ->update_time handling")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5


config: x86_64-randconfig-013-20260223
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602262015.d00ee0c9-lkp@intel.com


[  180.177701][T23712] BUG: KCSAN: data-race in atime_needs_update / touch_atime
[  180.178300][T23712]
[  180.178556][T23712] write to 0xffff8881005bf140 of 4 bytes by task 23711 on cpu 0:
[  180.179221][T23712]  touch_atime (include/linux/fs.h:1624 fs/inode.c:2092 fs/inode.c:2135 fs/inode.c:2158 fs/inode.c:2236)
[  180.179620][T23712]  pick_link (fs/namei.c:1989)
[  180.180009][T23712]  step_into_slowpath (fs/namei.c:2066)
[  180.180442][T23712]  open_last_lookups (fs/namei.c:2091 fs/namei.c:4575)
[  180.180870][T23712]  path_openat (fs/namei.c:4784)
[  180.181260][T23712]  do_filp_open (fs/namei.c:4814)
[  180.181665][T23712]  do_open_execat (fs/exec.c:783)
[  180.184266][T23712]  open_exec (fs/exec.c:823)
[  180.184645][T23712]  load_elf_binary (include/linux/slab.h:957 fs/binfmt_elf.c:919)
[  180.185075][T23712]  exec_binprm (fs/exec.c:1671 fs/exec.c:1701)
[  180.185469][T23712]  bprm_execve (fs/exec.c:1735)
[  180.185898][T23712]  bprm_execve (fs/exec.c:1781)
[  180.186295][T23712]  kernel_execve (fs/exec.c:1919)
[  180.186707][T23712]  call_usermodehelper_exec_async (kernel/umh.c:113)
[  180.187226][T23712]  ret_from_fork (arch/x86/kernel/process.c:164)
[  180.187637][T23712]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[  180.188059][T23712]
[  180.188315][T23712] read to 0xffff8881005bf140 of 4 bytes by task 23712 on cpu 1:
[  180.188962][T23712]  atime_needs_update (fs/inode.c:2056 fs/inode.c:2201)
[  180.189403][T23712]  pick_link (fs/namei.c:1983 (discriminator 2))
[  180.189795][T23712]  step_into_slowpath (fs/namei.c:2066)
[  180.190229][T23712]  open_last_lookups (fs/namei.c:2091 fs/namei.c:4575)
[  180.190657][T23712]  path_openat (fs/namei.c:4784)
[  180.191075][T23712]  do_filp_open (fs/namei.c:4814)
[  180.191479][T23712]  do_open_execat (fs/exec.c:783)
[  180.191885][T23712]  open_exec (fs/exec.c:823)
[  180.192256][T23712]  load_elf_binary (include/linux/slab.h:957 fs/binfmt_elf.c:919)
[  180.192683][T23712]  exec_binprm (fs/exec.c:1671 fs/exec.c:1701)
[  180.193082][T23712]  bprm_execve (fs/exec.c:1735)
[  180.193537][T23712]  bprm_execve (fs/exec.c:1781)
[  180.193922][T23712]  kernel_execve (fs/exec.c:1919)
[  180.194333][T23712]  call_usermodehelper_exec_async (kernel/umh.c:113)
[  180.194850][T23712]  ret_from_fork (arch/x86/kernel/process.c:164)
[  180.195265][T23712]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[  180.195684][T23712]
[  180.195936][T23712] value changed: 0x2160ec00 -> 0x22921900
[  180.196415][T23712]
[  180.196667][T23712] Reported by Kernel Concurrency Sanitizer on:
[  180.197175][T23712] CPU: 1 UID: 0 PID: 23712 Comm: kworker/u8:0 Not tainted 6.19.0-rc1-00005-g761475268fa8 #1 PREEMPT  0fd055f61ee6c01889a41da1288262ad66e4a70f
[  180.198323][T23712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  180.199162][T23712] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260226/202602262015.d00ee0c9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


