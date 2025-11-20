Return-Path: <linux-fsdevel+bounces-69189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C02C724A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 07:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A919F2C066
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 06:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15D205E02;
	Thu, 20 Nov 2025 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="La5+IQG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B9179A3;
	Thu, 20 Nov 2025 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763618513; cv=fail; b=OUXTOn2O5sUY/YMgMMMsZ2I2Zq5UoicXw8y6FiVaqTj9D0L8blGA1Q6AfBz6MLRlfpQqOSiNrnigjcU+zMMgXSGLZu8Q9yzuIXCsX5bmIyQSfMIACjxku/5G/rKXlRDsXltESOGAGqVOlY9lsIGe7IDSDp+p+d6nkVYP1tcFb+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763618513; c=relaxed/simple;
	bh=Bl3uMcjnB87tmEJxzQFpBTyPSm06zLw7rWgFBrShybM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gai5SYv0u/vhlOPbM2Zi9kyz35HH/P/lWYnsAESNktHLgW45RpyC84lnGwJmPliq/zEbypdLOc7j8FAmXA1UfxqDiy9Xe1hgh7R5RsWuJQrUku89QGNcEudiIWnNRg2i284CNtQQMow6FTQrsdJmRcl2ZlNpokr3FLIqgI7OJOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=La5+IQG/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763618512; x=1795154512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bl3uMcjnB87tmEJxzQFpBTyPSm06zLw7rWgFBrShybM=;
  b=La5+IQG/SbHVoKPky3bJB7c68Kd4kHak/l1xUc7XAf/7brKxB9jxUSyO
   vZbWpCA1dF1htQVMbMyTpOcI0VzWTgR53LU2aZORSuSZIMe8gNq1J0Zyh
   yHFmFNB1hguNegpaYVVrTzcEvZR78TBl/GLcs7vZYGwz231QlsmERTYLM
   f1j/b/zkCJWVT0rPbkEkQwiZsxcspYc/UmAiP1tmSxXfk+9VdtV+0AuU7
   nvO/7z/v2rNjNcJuN+bQDrqO3rFGhPHgaGBwl8ZOrmg4PeWjqP57jZOxk
   qPc8RZGvtKe8Vpf70zlMWlJeqEfO+CPBY4I0WKSVMxCmyvo5+ofJ4Yfh6
   g==;
X-CSE-ConnectionGUID: zAj0RbDZT82TTlj9pozEzQ==
X-CSE-MsgGUID: S3AZkqEVTdiu8mNCAKB3LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64681057"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="64681057"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 22:01:52 -0800
X-CSE-ConnectionGUID: TritE+BhTymvYz+AAWZjNQ==
X-CSE-MsgGUID: yo7JCu08Sw60HHyZHjqzQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="192066341"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 22:01:51 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 22:01:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 22:01:51 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 22:01:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDihphp8z8tIWDrTYARmlabw3PChLNh36dm6XfZ3eC3rL13QUHazhJeYRZw2vLfpczf2ilLFiwg0EgiLCTnLv3DnghksH0kv50s3YIfbaXhDSZdk5DRTW4zfKQ1bLMbxrTU4SM/uyhjxBr/w0vJipn8tz4UsuQPhEsZBqN12trBBjf1gTRoRnY/vVE7mJYfaWoszbE1ue0E5QMhcHSCMwQF3yh1uOpYP0YpA/fBfxacpnFn/jgo1Oq95yX2RtzsO5Fiy2QkpWbvrF09EeEi+BdKZWarsQLfP1eZK2VLBm5viQ4UgdrXMfjTlLULNP3GAu+Ox2Fi6+yFb30MBD50dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yEPC3dsm4NBoT+OEYw7fvRsI9CmbLKkGTV6OmKX2/8=;
 b=XZ0m799HXmHxQ8B+xmoODCbniBU3KBX5tQOq1sGb3mHHBGQmrFebJlr0F7puXmO/olDw5lw5Vk3IAMo/42Vt8+tkqYewbymJ+H4juGWP/tYFnfqg7+IzxOElyW67jRN/3ZmlaplLz1toOsjQ+kPRo9Opk1tUxtkcAE/8bfc4ZEbzBfzeO1vWtdnNv/XbD79kHPcavVtMYNTTR4gAJuxWAbPI/2Gx1+HpEx2BIALME6+79avIbwJtXZVuYRRirzusKeIe95dM4XGiCn280OSRZjc/e+c8BgSJSGk+eP8tCt2KIn8bJZ8hkFjzWS5j95Zb5JwzVQ4vHJESZYIUDQXzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB5068.namprd11.prod.outlook.com (2603:10b6:806:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 06:01:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 06:01:45 +0000
Date: Thu, 20 Nov 2025 14:01:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong"
	<djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [iomap]  f8eaf79406: xfstests.generic.439.fail
Message-ID: <202511201341.e536bf55-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1P15301CA0064.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aeed76f-ce93-4242-7361-08de27fa48e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cI3YkkdbyhXCzaXErbZ/uvxy03+38FHzI5eXMkj+ZYAeUJj5CC9xGBRPgfBN?=
 =?us-ascii?Q?JKCJFXwymG8tfPTKsv/SIWM8IXfhgfRZQ+SiMcsjaDq4Zfqydceq82VJmc7U?=
 =?us-ascii?Q?ELXid3IWrBoYfCqhmjo0fAxqBtqSZMvGy8JLS1aHfDwa9oUy35ZwpXV3HsQF?=
 =?us-ascii?Q?WYrMfJOfD41aN3syUvkFc797Yz+MKRJ+Cmkz1687ZRWpz0FyxsCpiEjaVMD0?=
 =?us-ascii?Q?aW5FiuVame9N7mHvEZtI7SS8NZHb05yitbeebhewz100IFHcmocJVNUOQ2tl?=
 =?us-ascii?Q?xgID2oK7C0GQs8yCbkm7Jgm/WGh9CSifkmSlfqPJT/ryw4+0FwpEIdiwtgS5?=
 =?us-ascii?Q?rK6fsbdBRQfpFSXzhWhvDVoPcchzYoOUaMmdFGRDIzta3t/ZM7GU0o8wQJys?=
 =?us-ascii?Q?TJpSGNJYVQ/U34KAVYhUIyRcRavtCCm//S6It9TAjPPRrHe9iJRRFMqETl7+?=
 =?us-ascii?Q?n85yIiw+QMH+u/H3b3+8XTqdux3rQAtvwzgnMXOUGy5eBz62t5a69awVRJeB?=
 =?us-ascii?Q?LU39x8eR0w60cIc1o1a97KfbQlJcGgfPczPbKO2kH+a64YAzCk21tgNmgWw4?=
 =?us-ascii?Q?3795V0Q5/A7dqN8zjk9hsyLIeI3M1ux8o4F4RFEMmPV0WVYK2o8CswfwZ9fZ?=
 =?us-ascii?Q?W+t4CZ74st+BULjIaeI/jZRNyJJRI9sEbVSh+vOqc/5xlhnA1e6ey8AZob6c?=
 =?us-ascii?Q?60MWXgo5o8vDulUpEC43M+B6xOKYtxbJwKfBuoRn7kiYkRHXmOooOQjEr0N5?=
 =?us-ascii?Q?LE3Vl7cYkShY4wSUxB3sEwNUVLVahqJ2EL/MlinoEVRonUy6ii++gqu1nHbC?=
 =?us-ascii?Q?6TMnXBLpsJvBCE4vgS8jtl0Gf9S6UPJbfsfmSY+kgZMaQybqK32rQMyQtKkJ?=
 =?us-ascii?Q?5/4KWGVRUUv+xjSSVT3MKKq+fyXKXYotIZJv53j98Pt1JpguefN+svXxdLAC?=
 =?us-ascii?Q?rXwq21kuHx68QLJ3B1O6M/3Y2aOLtudqPc9oJclGCDJV9ayonCdZbXw89L4W?=
 =?us-ascii?Q?XA5X+lXdqnZKcI/vqnznoeHwurrroF0DMl84dz31CAXg/Fx2ASZgu+iF7PzD?=
 =?us-ascii?Q?8vaaW8TW21gcmFwmOrl8GTUknkAPpiP+T77VkIATfDq0uAS0+0v3nVcUG1uc?=
 =?us-ascii?Q?Bzs0HMWJXlOY7MsMcFdGt/kPZwDCCUpxGOoo4fXwZOBEXPTrTDY5XY2hc7CY?=
 =?us-ascii?Q?4CQgLcBh2J78HmLVze9ExNoMJiMMfmS/iw5D3k7B9XhxUMpMDdljF7+qWFUV?=
 =?us-ascii?Q?9SYNi/MgZIB2LSwAEzbA2Po/x8gHRvX89HEHIUwM88/0gk6DCQWyk4b1xdZF?=
 =?us-ascii?Q?Ck7E56/9l8UYLeLcnDNeYyxPhm4CmXqA+iyYDlALyRKKKmbv3z34JsO7Ez1Y?=
 =?us-ascii?Q?VSJ2bkRiYZ0xZmakGMBNonjs8UjEX+kUwDf13UxIcfnz7oGHRh59hG0H8Qyv?=
 =?us-ascii?Q?ioMhdsWb8/AJVb2iEREaifhYukLTwUE2QNCxDsnGwVLEIrR18px++g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Uyc2j+aAg8tdVZ5BkP+vpHT71xJZcmgZm40sgvvGO4GDRh62Be0hHF9kvFt?=
 =?us-ascii?Q?jhl+/qy6JTusXV9RkF6zFqAwR5q5DmRoN+m6ihh2AS8HfcXrZxM6Zjm+zCC/?=
 =?us-ascii?Q?qG2S+f4VkcWK/ICLTZMFSfLzAUp1qbs0ezPZcjr9XMw6EAv9Dk4xguMQ4a/Z?=
 =?us-ascii?Q?8BC2NA+13cjRJnscZ9uXbN7BeBs+HWde2cFsjJYRVR/3v6K0CLpLlFbD6PTu?=
 =?us-ascii?Q?muvYysZfBToKEGaG20Xke6dmkFCH6/0O5GUdBUduIq4aRG83x32hHWlMf/p8?=
 =?us-ascii?Q?GI6m53CKZtC4LwhZhBjvz2bBV57UMU419qGc24wmTWCRm4NK1Njy/xu0PwLv?=
 =?us-ascii?Q?zZDondG0keR6mzhWON+19G9E0iO6zzCK4QdQtNj/hYK3530xZyFJqb5VGvP4?=
 =?us-ascii?Q?GFCS2kmrwItAFdAuxKZQStZ/7MBIINGdIIttp+l6E0ochXOqsEa08TtWxOre?=
 =?us-ascii?Q?j9XCgHfcCEUC++dSjXALRW9Vo7FhlcfCwnOcR1q52zjPnTbtDOFyQvFVEr2+?=
 =?us-ascii?Q?OCTNQ7BFfZ8Kvy9wkFiD2zU7rkmROYOxJR1BVpROFWJUndfXOL+Ht3gOhPXN?=
 =?us-ascii?Q?wVOu5u9BaembQeLVllDzSCWMlMIZLCXvL7STuwz+NXXTvfyOtgjOkoFQW6Xz?=
 =?us-ascii?Q?j6OIuQlyGSxp4tqSOZvTGs0N1nNh+6qe1GmvvYlVu9krT22YtXnsk38whv3R?=
 =?us-ascii?Q?e4a3CBz6c8ZWA03Vv4YaVUlP6hotRz/CqAEYH0liLMgEfIeRt8VO1Urk2cGu?=
 =?us-ascii?Q?90iH4BV8N6r45UYG+dHjRxrVtIFrpe7nVZ0nto4ymzM9n/cbclUN3t6QGX9I?=
 =?us-ascii?Q?NXHQ4C/xO/PJPFiw5LykWJYXRQS1pHR9BD0umK9CUp6hRducOho5kemmEw2d?=
 =?us-ascii?Q?BdqI6zS3zr3/0/ThhqSlTuWRx3lljGZY3igy7fR/eU+Q7q4fwmLVYurBX0IV?=
 =?us-ascii?Q?+n07JQDmt6xJW4Q8pycgN4oNyV5I5ss5SDbB1/UHegdiGPC9Ge2P6Uewft52?=
 =?us-ascii?Q?DQd2q2KAlxjohZctEDQ8g1I2cxy9U4E6bmKgikVXK3PeSQioBmTRZ8WK+qAy?=
 =?us-ascii?Q?WblgQbVsAERu3uiaTnbCY4RLTq9nAvADpaGJZAfTlAcPzhuzDiI550H4GzSC?=
 =?us-ascii?Q?1MqWsQj78K6TqrQ8wBbpB+5WFS1MOAwCBaa2LdsiDIppU2PKuzSKSwyvD50W?=
 =?us-ascii?Q?Luw4eVwhJH6co+L4lhKe60sNdCXqi3YgrxF37sprNodPPrZNnYFIJazQW1rZ?=
 =?us-ascii?Q?qHsUu6Vmume+vBLU5eYMUsYLhlKV4+lz0FNNAUmvBKZEbxqI/+tiywxtFzBK?=
 =?us-ascii?Q?rmZwhhpRco8WgI/JymV7WsFY4kxFNexmx53tItZ85UCRrvqYhWED54RIimqa?=
 =?us-ascii?Q?BUhJUpJynC7J71BKKCX6FAnuqvcB1/2SWLuEz8JZx4FQy+defW76FI9g22fF?=
 =?us-ascii?Q?1ZEJX2Bi4/4M/f+uttWh55G3UiWQCul+rjMZ/1Qb4+gHAIuD0F+gIlRGm/kI?=
 =?us-ascii?Q?W3elUi7ec3zq+QP4t/f3OlmcLDuWXthNsW9svUhInnd8zyUug080xt27xStM?=
 =?us-ascii?Q?mkCuKp0gQp3nENUe8zyCDA5JTUeF6W9jZkgOgdwnALqykGmVfCKQAFBNaQMb?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeed76f-ce93-4242-7361-08de27fa48e2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 06:01:45.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5d+ohpY7pV0aOpm0sfSwG8pFRljmFDBevhcpXG1ry0sSYCl7xUvBjmdNwF76//IojxQ0h/bhPcZrVMH2Cc+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5068
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.439.fail" on:

commit: f8eaf79406fe9415db0e7a5c175b50cb01265199 ("iomap: simplify ->read_folio_range() error handling for reads")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master fe4d0dea039f2befb93f27569593ec209843b0f5]

in testcase: xfstests
version: xfstests-x86_64-5b75444b-1_20251117
with following parameters:

	disk: 4HDD
	fs: xfs
	test: generic-439



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511201341.e536bf55-lkp@intel.com

2025-11-19 08:42:31 cd /lkp/benchmarks/xfstests
2025-11-19 08:42:32 export TEST_DIR=/fs/sda1
2025-11-19 08:42:32 export TEST_DEV=/dev/sda1
2025-11-19 08:42:32 export FSTYP=xfs
2025-11-19 08:42:32 export SCRATCH_MNT=/fs/scratch
2025-11-19 08:42:32 mkdir /fs/scratch -p
2025-11-19 08:42:32 export SCRATCH_DEV=/dev/sda4
2025-11-19 08:42:32 export SCRATCH_LOGDEV=/dev/sda2
meta-data=/dev/sda1              isize=512    agcount=4, agsize=13107200 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
         =                       exchange=0   metadir=0
data     =                       bsize=4096   blocks=52428800, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
log      =internal log           bsize=4096   blocks=25600, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
         =                       rgcount=0    rgsize=0 extents
2025-11-19 08:42:33 export MKFS_OPTIONS=-mreflink=1
2025-11-19 08:42:33 echo generic/439
2025-11-19 08:42:33 ./check generic/439
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.18.0-rc1-00033-gf8eaf79406fe #1 SMP PREEMPT_DYNAMIC Wed Nov 19 16:30:42 CST 2025
MKFS_OPTIONS  -- -f -mreflink=1 /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /fs/scratch

generic/439        _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/439.dmesg)

Ran: generic/439
Failures: generic/439
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251120/202511201341.e536bf55-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


