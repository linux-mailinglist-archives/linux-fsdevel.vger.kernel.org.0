Return-Path: <linux-fsdevel+bounces-79745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJuJKaGJrmnKFgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:49:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D55235ACB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61671301D941
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AF633EB07;
	Mon,  9 Mar 2026 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqDHocEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EBB3101A2;
	Mon,  9 Mar 2026 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046169; cv=fail; b=UH5fzE3TkQYhKFP5sp+rQ4+NJCORWlTeZmwjyLrzMRm7/1k/7dVLTQZRbgXA364Ijjm/PzB42S81IPRXoH979o3KkCGiw2PCbFyNPmzoNfrxOQ63PhgHcR8mii9ff+1wcydSk1OZ9oSG+BQpQSUDlm6kgf8ya9JKBwfGpV+KERk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046169; c=relaxed/simple;
	bh=md2X6yZNUML7vv2RsI0BQIZa9DfZUwL6vPLNOaPD+DY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JxwiQrKU77uBDVltmrL7w+ajRbXziA+6JTnqybRp1PCOqratbsufr3+9ObaCtXTd9UZNXsj5mNvlBSngd7/5iSVFQEmjpmBMeYdwXFYYFUHuhFyks4Srs8I0htBBgWjC2hNGmyIobO1m/zODZtmymLjM9kJIklj0EoH/F4qJbMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqDHocEs; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773046165; x=1804582165;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=md2X6yZNUML7vv2RsI0BQIZa9DfZUwL6vPLNOaPD+DY=;
  b=dqDHocEseTmTjhBXRA7QSlSEaZx4VF++l0kE78R0sTENOMV6xkf9eBUc
   xPG2scstUEFL7FQtqxncvmek4686BLhbp0L0ryzc5ASA6yfPXmMl1Jgl9
   Tzli1SN69kdps9V9YLO5TFC0ZhbvFzGGHo7QuqrQ94w9/PcctGZEV6dL6
   i1vDPfQbxiiOwappjc7oTxSdu+DCuT1df02l3kIyA353eUQIm+ZiMAb0t
   1mgsndELSUhsnWln3X4mRiE8GuBQA6Y6yBKpT7TmaOlu4gv4vb8v5SmaS
   8KEEUQlxUvY6I7JVT+7itms9zm4ecX1VsJvWdqB9CkNANrtetamGi7s4U
   A==;
X-CSE-ConnectionGUID: G0diSZWMSFWWVFZ8I4wU+g==
X-CSE-MsgGUID: e+I/IQL1RHCZg2Wrmm39Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84697973"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84697973"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:49:25 -0700
X-CSE-ConnectionGUID: 4gYJcxUKSY6yXIDNyZQlfw==
X-CSE-MsgGUID: 860vW5tFSa21yOy4U2sn9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216224890"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:49:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 01:49:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 01:49:23 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 01:49:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWnIvlC0lVvT5Kh5KpGqohdu09T4qdphWgORjIu8lO6EwU/y35wpilQhYTd1hMKum363802coXPr64LSEreMtGqFsp2C7CQmB2d6qDwN/GPwE2UsAylTrBgZ2urIXwm9S0Uz3/ckPjgwrPQZ5tyWSBYNvXeELB9Y1r0XRRu2ejD0x+WSe68xjfh1gKSiXi4ykU0Pi7NJO8bZgrchmITvEAaADp/XKHUSM9LrzQgUB08FwgLsrqJF0TTmeq1fDAvsCp7I+/NeQ6WlLqROZ8JXaRlrrTs4G1Bt7f1el5WZmcY49s3gaoZwvv3+4uI3qh6kyC7jQXZBy+hsoJTRa6XsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqIIdif1QbJaker6aS84ZpSO6fUpeebjH+VjA1ND+aI=;
 b=QHR66o3NsMtN6O36zbKnz6+jB/p6GmXkPYr52UuPu6SKAJmdHX8TDh4weJOmqcjBTcOMA80lTXNj+j9DGFN64LYU7OlWZb3xNNKWnZcgSeuMJjPhf3+d3F74kUho71/g+4FtRoJ4H0bppDuR+FplMIsQNfyg2Yy3ro5Z7FoIAiwJNLWjm+ptWhyNDWtvjPZ1lUotX+GWFz+rr01JMtMAeTOdchB/3W47GLwfCqr2tpzit4bUQA91y0djjwI8/FpaMJSgtUc1dxy9gc4La6BlcAnxct1bP9pVbn+BVIPylZg4ZjiVGzAJFF0f5kIcAN4V/g8+EjSe0PzTO78Fv3ggNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4033.namprd11.prod.outlook.com (2603:10b6:405:78::25)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 08:49:19 +0000
Received: from BN6PR11MB4033.namprd11.prod.outlook.com
 ([fe80::2c28:2983:2947:24b1]) by BN6PR11MB4033.namprd11.prod.outlook.com
 ([fe80::2c28:2983:2947:24b1%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 08:49:19 +0000
Date: Mon, 9 Mar 2026 16:49:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [iomap]  cd3c877d04:  fio.write_iops 5.8% improvement
Message-ID: <202603091510.4445c895-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To BN6PR11MB4033.namprd11.prod.outlook.com
 (2603:10b6:405:78::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB4033:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: d41a8e9a-f934-4bc4-5166-08de7db8c044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: EFFlEH4KKyfz5LZRfIXa9GkuCdc2i8a4XDWYAjHKk6FDGne3IEfxN4sQuaWfjjTOVI2dccDMt/VHjDFiJBasTpUxYFD7Il0w7bon4Fn/0+bDF3jXd0JJRtXoWGiXd2sAm449bhiqpEQpbhrcareSRN+NRth1qOBp7z+1K8e7kiqUkGvRVibVG7Htb1G6vnORcKNuGHHl1DgcL/+cc2cfp4H4GKm7K61VUoUQCNp/mXRfL9RIR9oyzsEcCNm/RoUHcsYOvbHfgZzy+jBPwxal76MqH9oMM/25G7X9VGlmcLL4TBkL7TkeLs1iBXVoh/e7mBDJzYsDWAhBK8FE1MfphhwtGPQz0/VFtrjsviu2GPPoUJ6z8yc2VBLUFPI6apHoCYBHf5EolhGQtDBOCVOpwKfVOZtHmNwpJ3IeK1Y+Jeik2K9qXkpsAuAEtC4U0W5zzyUgvgzkTIhvyxI93VQVBT+al2NsARSRtEfNHdCJ6XuVhJNHQV34n0yAvrDZd95vaVaOjnhJaq12erEkmpJazScztVn89psnvz/4fC5iPREyafb6Cwv15lToOp/ae0c2bthyTGWUQafgpVBjnDEjrS49nPbXEndJ8wMANeGV6Q+3LFMwl+ZT1fWkMfBk6XdmPjsv62VNXCwxi0hrEosHYasVVGqPLj9WsfX4wemC5z0PNVbprwIp3HBCuMwhIRBNl1EcX9T23cJFe7ygFgEFQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o3WyaRRP2ZlSx90UCzi2AC+Psvq91MnfJqucM8qJT9qNVBwjc7bBWU4yQC?=
 =?iso-8859-1?Q?a/DAJmO3oaXPoEuXf6C55zkCNZp9otKhGynY2kGNzv+1OR43jH+AnN7DNG?=
 =?iso-8859-1?Q?hC9HlyTepaW2ezo0j+YyqftKp+91Tg11fyFoLcEpxOsM+O/JisR1M+wCH0?=
 =?iso-8859-1?Q?C84DaduRXSAAcsb5sFrG/MXi/mzk1b6v3aiMkEbbX6cM74AKC9d7URHOyl?=
 =?iso-8859-1?Q?GnFegFziJdgIJngE6sA3OHXR3OXu+gjGTukDc0SqnDyji2kil2Kow2bZ0l?=
 =?iso-8859-1?Q?wp3O0UVLlmSGsk0kROrQ5uR5gF3suxXC2MPkVZD0R8YgMrV43ajdN4siyf?=
 =?iso-8859-1?Q?2bkCh/3KCojUgKNwEv8ahVMajwaqMV4sf78MVxy5VguGEPJDwbRbp9TaL2?=
 =?iso-8859-1?Q?lLM3Sso7mobWHoy7s6/SY8NH2/rrVjWwSGtp32uEbZKkCtSttigo9PX3Jb?=
 =?iso-8859-1?Q?AUqDdMKnEsXUvh1EOdu/YDX1GMJEJGfuUGWjp4uFZQltp3HXPzTcBMAjiQ?=
 =?iso-8859-1?Q?fp+XioqWHQMVqMCZ2yZRuh6lvKDIz1BxbnhzVRRW2aJlGSPlr00o1p9dnN?=
 =?iso-8859-1?Q?uYPUnkHCHo8q9htkpjDEET7A9/ANbHaOp0tPK1y7YrsWsIapILVjCo5baV?=
 =?iso-8859-1?Q?P2nK2weUGCUu5VhBHDU+p1exyY4snqT44xYXDltiE8FuEfwruDLHJMaVqS?=
 =?iso-8859-1?Q?7vWIX5naAZARQC46HTHuDly3C7quj5hcUW+kLhFxxafEIop01EZMMYYqAL?=
 =?iso-8859-1?Q?GZCbpCWT53cv6Q+cp2obVPhHeh8yeRy2rNQw1yu0r8KKVOqwDNRocztwny?=
 =?iso-8859-1?Q?8HJunzUX1Ut/v8hWHJvagITTTzOvFqbTcA/MQYAGcJmAyDp2H6J/8ff/Tc?=
 =?iso-8859-1?Q?g/O5iUOUJMLC040GJZffyVpzjenSO1IIwezoGWJoUPQM19h2O+apwE64UU?=
 =?iso-8859-1?Q?nsFYlou2pPn3ZtMYfeDpccc2TVFdRw2xnx+De0W/t0lBE7/Z+oOsz/bCIf?=
 =?iso-8859-1?Q?js/w8dlTLF/C6nYFQPdRCCAf06qBfAdIcjgEw82RRCbypVLUK7lQPZa2C/?=
 =?iso-8859-1?Q?hRlGos6ICMBQhacIVmvWjzd+N43gIPN7J6U2lVTyCnTQhxFwvcKGnNykyd?=
 =?iso-8859-1?Q?DXP5ulsYzUCW8DHNguk+SxM7Z1jJJQx45DjhrEbtoX85otHL7NW3zTA81Q?=
 =?iso-8859-1?Q?8Ytjwp+E6I1TAmPyA4ehTo6WAeXHJHrebXkQodKKp/1OQZ7Se5iRPbPmRt?=
 =?iso-8859-1?Q?xKo8/TvPJfkZ7FOCr4e73ICh7zc33XmRnLnxLcosCiqfxpnaHzaRWc0s6N?=
 =?iso-8859-1?Q?GLiv3WYSJ6nfratqiJMzQH0nT6IyQtbZSZgu2C/bacn5K8LqkhHzYAEoje?=
 =?iso-8859-1?Q?QVHzMYMZh0epc9gg9IkCcrsbHsPnBMdQarHArCIIAuI2e+S39pVS6zjgsX?=
 =?iso-8859-1?Q?BhJEMRZP52lwHR/PzlPMDVcm7XEZs5QiQx9aeUKcxeqDoslJb4WwyleWxN?=
 =?iso-8859-1?Q?DCbIePoXPolLbzJYOPWpbWv5cbQLzItprIKXt+1helOLAYakzYc1cJttP5?=
 =?iso-8859-1?Q?+X3NPda8hBibuWbw6M5t2Bmdqoackr6K9hUY3VubZ+BH8pfhC8y/Nl4n81?=
 =?iso-8859-1?Q?Jq+LpmQaIyXjJII0kRAuJepO0N+6jfPTiP8E942WEGH1zxutyZlGBT1E4c?=
 =?iso-8859-1?Q?tF0sxn6zbhEQOUSHxB5vpXy+n2vR+crIwv+4y3YsFa+wJDdiKyJ9RVia4r?=
 =?iso-8859-1?Q?ZVsHzh8UPb0T0XvMZVEW4nhem4VpEPBVX1yL1gx1cRIw9q8fXcBeDaR2We?=
 =?iso-8859-1?Q?Vv26aGtmGg=3D=3D?=
X-Exchange-RoutingPolicyChecked: vy0e7Dg0zgaltrRKu9FjrtLGcSDa+hKGJGA4Q9VRVEz0OQgT+r/4vpXsOguG1zknoOYsAzxA6dU/AVnNq83vdLiZYtVhKdZoIcr9JhZ2mKwXJTY4BCB8Mr8yPrX0BZFve5b5GCGeqSlzsZ84nHANS7CYiGATb72/go+alDq1QJUYkZZswFltnTj1ZpqIM6cH6UE5Us6fjEUi7Ic02rstk6HYF0hX2c02xRwMPc7wOWtiL4q6dX1y6Qxsyo/7hhsx1flSlKfGnZW0nGzQewfKVxFSdx8Aep6luW8UZY8zmgUtAD8SsZaruR4UTF2lgCZOEQTykFZreaAFAifYXQHE4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d41a8e9a-f934-4bc4-5166-08de7db8c044
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:49:18.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEEAxJsfvZG3xAs7+Us8sMb75PdejON1PIzQg7HlkGJvUAiqxFaO8tdknBdqThHqdCHrsiHp+kXtHKn+cPj2Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 31D55235ACB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79745-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[system.in:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,max.ms:url,intel.com:dkim,intel.com:mid,01.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.976];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



Hello,

kernel test robot noticed a 5.8% improvement of fio.write_iops on:


commit: cd3c877d04683b44a4d50dcdfad54b356e65d158 ("iomap: don't report direct-io retries to fserror")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: fio-basic
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	disk: 1HDD
	fs: xfs
	nr_task: 100%
	test_size: 128G
	rw: write
	bs: 4k
	ioengine: io_uring
	cpufreq_governor: performance
	fs2: nfsv4



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260309/202603091510.4445c895-lkp@intel.com

=========================================================================================
bs/compiler/cpufreq_governor/disk/fs2/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
  4k/gcc-14/performance/1HDD/nfsv4/xfs/io_uring/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/300s/write/lkp-icl-2sp9/128G/fio-basic

commit: 
  d9d32e5bd5 ("Merge tag 'ata-7.0-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux")
  cd3c877d04 ("iomap: don't report direct-io retries to fserror")

d9d32e5bd5a4e576 cd3c877d04683b44a4d50dcdfad 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     32.84 ±  4%     -17.8       15.00 ±  9%  fio.latency_100ms%
      0.04 ± 47%      +0.1        0.10 ± 28%  fio.latency_2000ms%
     14.03 ±  5%      +5.2       19.28 ±  8%  fio.latency_20ms%
     29.56 ±  2%      -6.2       23.36 ±  3%  fio.latency_250ms%
      4.81 ±  4%      +1.1        5.92 ±  5%  fio.latency_500ms%
     18.08 ±  7%     +17.4       35.52 ±  9%  fio.latency_50ms%
  53963461            +5.8%   57074346        fio.time.file_system_outputs
   3248835           -99.3%      22377 ±  8%  fio.time.involuntary_context_switches
   8741088           +35.0%   11799621        fio.time.voluntary_context_switches
   6745432            +5.8%    7134293        fio.workload
     87.80            +5.8%      92.85        fio.write_bw_MBps
 2.599e+08 ±  2%     +20.0%  3.118e+08        fio.write_clat_95%_ns
 4.089e+08           +10.3%  4.509e+08 ±  5%  fio.write_clat_99%_ns
  91094036            -5.4%   86132167        fio.write_clat_mean_ns
  88204930 ±  3%     +19.7%  1.055e+08 ±  3%  fio.write_clat_stddev
     22476            +5.8%      23769        fio.write_iops
   9081090           +25.5%   11394409        cpuidle..usage
      0.07            +0.0        0.08        mpstat.cpu.all.irq%
  11565087           +25.1%   14468228        turbostat.IRQ
     88771            +5.8%      93888        vmstat.io.bo
     93282            -5.0%      88579        vmstat.system.cs
     36858           +26.5%      46632        vmstat.system.in
      0.10 ± 15%     -49.5%       0.05 ± 35%  perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     46.25 ± 75%     -65.3%      16.03 ± 13%  perf-sched.sch_delay.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.10 ± 15%     -49.5%       0.05 ± 35%  perf-sched.total_sch_delay.average.ms
     46.25 ± 75%     -65.3%      16.03 ± 13%  perf-sched.total_sch_delay.max.ms
      2.02           -15.8%       1.70 ±  2%  perf-stat.i.MPKI
     23.30            -3.6       19.71 ±  2%  perf-stat.i.cache-miss-rate%
   3487094 ±  3%     -15.4%    2950796        perf-stat.i.cache-misses
     94028            -5.1%      89274        perf-stat.i.context-switches
      1556 ±  2%     -25.7%       1156 ±  2%  perf-stat.i.cpu-migrations
    687.84           +21.8%     837.57        perf-stat.i.cycles-between-cache-misses
      1.34           -10.5%       1.20        perf-stat.i.metric.K/sec
      1.77 ±  3%     -16.5%       1.48        perf-stat.overall.MPKI
     23.73            -3.6       20.17        perf-stat.overall.cache-miss-rate%
    718.82 ±  2%     +17.8%     846.85        perf-stat.overall.cycles-between-cache-misses
   3475736 ±  3%     -15.4%    2941224        perf-stat.ps.cache-misses
     93714            -5.1%      88974        perf-stat.ps.context-switches
      1551 ±  2%     -25.7%       1152 ±  2%  perf-stat.ps.cpu-migrations
      8.90 ±  9%      -3.9        4.99 ± 18%  perf-profile.calltrace.cycles-pp.fio_ioring_commit
      8.37 ±  9%      -3.6        4.74 ± 17%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fio_ioring_commit
      8.20 ±  9%      -3.6        4.64 ± 17%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fio_ioring_commit
     13.70 ±  6%      -3.0       10.73 ± 12%  perf-profile.calltrace.cycles-pp.__iomap_dio_rw.iomap_dio_rw.xfs_file_dio_write_aligned.xfs_file_write_iter.io_write
     13.73 ±  6%      -3.0       10.77 ± 12%  perf-profile.calltrace.cycles-pp.iomap_dio_rw.xfs_file_dio_write_aligned.xfs_file_write_iter.io_write.__io_issue_sqe
      7.27 ±  8%      -2.7        4.56 ± 17%  perf-profile.calltrace.cycles-pp.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.fio_ioring_commit
      6.46 ±  8%      -2.4        4.09 ± 16%  perf-profile.calltrace.cycles-pp.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.fio_ioring_commit
      6.39 ±  8%      -2.3        4.05 ± 16%  perf-profile.calltrace.cycles-pp.io_submit_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.72 ±  9%      -2.0        2.76 ± 17%  perf-profile.calltrace.cycles-pp.io_issue_sqe.io_submit_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64
      4.39 ±  9%      -1.9        2.51 ± 18%  perf-profile.calltrace.cycles-pp.__io_issue_sqe.io_issue_sqe.io_submit_sqe.io_submit_sqes.__do_sys_io_uring_enter
      4.36 ±  9%      -1.9        2.49 ± 18%  perf-profile.calltrace.cycles-pp.io_write.__io_issue_sqe.io_issue_sqe.io_submit_sqe.io_submit_sqes
      4.23 ±  8%      -1.9        2.35 ± 19%  perf-profile.calltrace.cycles-pp.xfs_file_write_iter.io_write.__io_issue_sqe.io_issue_sqe.io_submit_sqe
      2.47 ± 12%      -1.2        1.25 ± 13%  perf-profile.calltrace.cycles-pp.blk_finish_plug.__iomap_dio_rw.iomap_dio_rw.xfs_file_dio_write_aligned.xfs_file_write_iter
      2.37 ± 15%      -1.1        1.24 ± 13%  perf-profile.calltrace.cycles-pp.__blk_flush_plug.blk_finish_plug.__iomap_dio_rw.iomap_dio_rw.xfs_file_dio_write_aligned
      2.27 ± 15%      -1.0        1.23 ± 13%  perf-profile.calltrace.cycles-pp.blk_mq_flush_plug_list.__blk_flush_plug.blk_finish_plug.__iomap_dio_rw.iomap_dio_rw
      2.18 ± 17%      -1.0        1.23 ± 13%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_list.blk_mq_flush_plug_list.__blk_flush_plug.blk_finish_plug.__iomap_dio_rw
      1.45 ±  6%      -0.6        0.87 ± 13%  perf-profile.calltrace.cycles-pp.dd_insert_requests.blk_mq_dispatch_list.blk_mq_flush_plug_list.__blk_flush_plug.blk_finish_plug
      1.11 ±  7%      -0.5        0.57 ± 45%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dd_insert_requests.blk_mq_dispatch_list.blk_mq_flush_plug_list.__blk_flush_plug
      1.06 ±  7%      -0.5        0.54 ± 45%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dd_insert_requests.blk_mq_dispatch_list.blk_mq_flush_plug_list
      1.47 ±  6%      -0.5        1.00 ± 15%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt
      1.47 ±  6%      -0.5        1.00 ± 15%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.pv_native_safe_halt.acpi_safe_halt
      1.46 ±  7%      -0.5        0.99 ± 15%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      0.73 ± 11%      -0.4        0.31 ±100%  perf-profile.calltrace.cycles-pp.tick_nohz_restart_sched_tick.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
      0.72 ±  7%      -0.4        0.31 ±101%  perf-profile.calltrace.cycles-pp.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten.xfs_bmapi_write.xfs_iomap_write_unwritten.xfs_dio_write_end_io
      0.84 ± 10%      -0.4        0.46 ± 72%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.04 ±  6%      -0.3        0.71 ± 21%  perf-profile.calltrace.cycles-pp.xfs_alloc_read_agf.xfs_alloc_fix_freelist.xfs_free_extent_fix_freelist.xfs_rmap_finish_one.xfs_rmap_update_finish_item
      1.15 ±  8%      -0.3        0.82 ± 16%  perf-profile.calltrace.cycles-pp.sched_balance_update_blocked_averages._nohz_idle_balance.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single
      1.03 ±  6%      -0.3        0.70 ± 21%  perf-profile.calltrace.cycles-pp.xfs_read_agf.xfs_alloc_read_agf.xfs_alloc_fix_freelist.xfs_free_extent_fix_freelist.xfs_rmap_finish_one
      0.99 ±  2%      -0.3        0.67 ± 15%  perf-profile.calltrace.cycles-pp.__sched_balance_update_blocked_averages.sched_balance_update_blocked_averages._nohz_idle_balance.handle_softirqs.__irq_exit_rcu
      1.00 ±  6%      -0.3        0.68 ± 20%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agf.xfs_alloc_read_agf.xfs_alloc_fix_freelist.xfs_free_extent_fix_freelist
      0.93 ± 13%      -0.3        0.62 ± 46%  perf-profile.calltrace.cycles-pp.xfs_btree_lookup.xfs_rmap_lookup_le.xfs_rmap_convert.xfs_rmap_finish_one.xfs_rmap_update_finish_item
      0.72 ±  5%      -0.3        0.42 ± 71%  perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_write.xfs_iunlock.xfs_iomap_write_unwritten
      1.12 ± 10%      -0.3        0.82 ± 15%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_slowpath.down_write.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
      1.18 ±  7%      -0.3        0.89 ± 20%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.schedule_timeout.io_wq_worker
      1.10 ± 17%      -0.3        0.82 ± 19%  perf-profile.calltrace.cycles-pp.xfs_rmap_lookup_le.xfs_rmap_convert.xfs_rmap_finish_one.xfs_rmap_update_finish_item.xfs_defer_finish_one
      1.10 ±  7%      -0.3        0.83 ± 21%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.schedule_timeout
      8.98 ±  9%      -3.9        5.06 ± 18%  perf-profile.children.cycles-pp.fio_ioring_commit
     10.98 ±  9%      -3.2        7.74 ± 19%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.76 ±  9%      -3.2        7.60 ± 19%  perf-profile.children.cycles-pp.do_syscall_64
     13.72 ±  6%      -3.0       10.75 ± 12%  perf-profile.children.cycles-pp.__iomap_dio_rw
     13.73 ±  6%      -3.0       10.77 ± 12%  perf-profile.children.cycles-pp.iomap_dio_rw
      8.57 ±  8%      -2.4        6.20 ± 21%  perf-profile.children.cycles-pp.schedule
      6.46 ±  8%      -2.4        4.10 ± 16%  perf-profile.children.cycles-pp.io_submit_sqes
      6.39 ±  8%      -2.3        4.05 ± 16%  perf-profile.children.cycles-pp.io_submit_sqe
      2.55 ±  7%      -1.0        1.56 ± 14%  perf-profile.children.cycles-pp.blk_finish_plug
      2.50 ±  7%      -1.0        1.52 ± 14%  perf-profile.children.cycles-pp.blk_mq_dispatch_list
      2.55 ±  7%      -1.0        1.57 ± 14%  perf-profile.children.cycles-pp.__blk_flush_plug
      2.52 ±  7%      -1.0        1.53 ± 14%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      1.72 ±  6%      -0.7        1.01 ± 13%  perf-profile.children.cycles-pp.dd_insert_requests
      2.14 ±  6%      -0.6        1.51 ± 17%  perf-profile.children.cycles-pp._nohz_idle_balance
      2.35 ±  6%      -0.6        1.74 ± 17%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.11 ± 10%      -0.6        1.51 ± 21%  perf-profile.children.cycles-pp.xfs_iunlock
      2.12 ±  8%      -0.6        1.52 ± 19%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.81 ±  8%      -0.6        0.23 ± 20%  perf-profile.children.cycles-pp.queue_work_on
      0.86 ± 10%      -0.5        0.31 ± 24%  perf-profile.children.cycles-pp.kick_pool
      2.34 ±  4%      -0.5        1.79 ± 17%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.77 ±  9%      -0.5        0.23 ± 20%  perf-profile.children.cycles-pp.__queue_work
      2.21 ±  4%      -0.5        1.68 ± 17%  perf-profile.children.cycles-pp.handle_softirqs
      3.52 ±  2%      -0.5        3.00 ± 10%  perf-profile.children.cycles-pp.try_to_wake_up
      1.84 ±  5%      -0.5        1.38 ± 17%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      1.78 ±  6%      -0.4        1.36 ± 17%  perf-profile.children.cycles-pp.enqueue_task
      1.66 ±  6%      -0.4        1.27 ± 16%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.44 ±  6%      -0.4        1.08 ± 17%  perf-profile.children.cycles-pp.xfs_buf_read_map
      1.34 ±  6%      -0.4        0.99 ± 17%  perf-profile.children.cycles-pp.xfs_buf_get_map
      1.45 ±  6%      -0.3        1.12 ± 17%  perf-profile.children.cycles-pp.enqueue_entity
      1.05 ±  6%      -0.3        0.72 ± 21%  perf-profile.children.cycles-pp.xfs_alloc_read_agf
      1.03 ±  6%      -0.3        0.70 ± 21%  perf-profile.children.cycles-pp.xfs_read_agf
      0.85 ± 12%      -0.3        0.52 ± 20%  perf-profile.children.cycles-pp.update_curr
      1.18 ± 10%      -0.3        0.86 ± 17%  perf-profile.children.cycles-pp.blk_mq_sched_try_merge
      1.10 ± 17%      -0.3        0.82 ± 19%  perf-profile.children.cycles-pp.xfs_rmap_lookup_le
      0.31 ± 16%      -0.3        0.03 ±101%  perf-profile.children.cycles-pp.put_prev_entity
      0.99 ±  6%      -0.3        0.73 ± 17%  perf-profile.children.cycles-pp.wake_up_q
      0.88 ±  6%      -0.2        0.64 ± 15%  perf-profile.children.cycles-pp.xfs_buf_lookup
      0.77 ±  9%      -0.2        0.54 ± 25%  perf-profile.children.cycles-pp.up_read
      0.55 ± 18%      -0.2        0.32 ± 28%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.86 ± 10%      -0.2        0.63 ± 19%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.60 ±  7%      -0.2        0.40 ± 25%  perf-profile.children.cycles-pp.set_next_entity
      0.73 ± 14%      -0.2        0.53 ± 13%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      0.75 ± 11%      -0.2        0.55 ± 19%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.47 ± 11%      -0.2        0.28 ± 14%  perf-profile.children.cycles-pp.pick_task_fair
      0.74 ±  7%      -0.2        0.54 ± 19%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_unwritten_real
      0.55 ± 14%      -0.2        0.36 ± 28%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.53 ± 12%      -0.2        0.34 ± 23%  perf-profile.children.cycles-pp.update_se
      0.78 ±  9%      -0.2        0.59 ± 18%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.55 ± 11%      -0.2        0.37 ± 16%  perf-profile.children.cycles-pp.wakeup_preempt
      0.42 ± 13%      -0.2        0.24 ± 22%  perf-profile.children.cycles-pp.elv_merge
      0.35 ± 25%      -0.2        0.18 ± 36%  perf-profile.children.cycles-pp.xfs_buf_item_init
      0.64 ± 11%      -0.1        0.49 ± 15%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.65 ± 13%      -0.1        0.50 ± 13%  perf-profile.children.cycles-pp.scsi_mq_get_budget
      0.34 ± 10%      -0.1        0.20 ± 20%  perf-profile.children.cycles-pp.__enqueue_entity
      0.40 ± 12%      -0.1        0.26 ± 20%  perf-profile.children.cycles-pp.up
      0.52 ±  7%      -0.1        0.38 ± 13%  perf-profile.children.cycles-pp.xfs_buf_find_lock
      0.41 ± 12%      -0.1        0.28 ± 21%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.46 ±  8%      -0.1        0.33 ± 11%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.40 ± 20%      -0.1        0.28 ± 22%  perf-profile.children.cycles-pp.__pcs_replace_empty_main
      0.32 ± 16%      -0.1        0.20 ± 19%  perf-profile.children.cycles-pp.sched_balance_domains
      0.44 ±  8%      -0.1        0.32 ± 15%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.40 ±  6%      -0.1        0.28 ± 10%  perf-profile.children.cycles-pp.down
      0.38 ± 20%      -0.1        0.27 ± 22%  perf-profile.children.cycles-pp.refill_objects
      0.31 ± 14%      -0.1        0.20 ± 23%  perf-profile.children.cycles-pp.xfs_ilock_nowait
      0.28 ± 10%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.__down_common
      0.28 ± 10%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.___down_common
      0.26 ± 16%      -0.1        0.15 ± 35%  perf-profile.children.cycles-pp.xfs_lookup_get_search_key
      0.28 ± 16%      -0.1        0.17 ± 25%  perf-profile.children.cycles-pp.down_read_trylock
      0.36 ± 11%      -0.1        0.25 ± 15%  perf-profile.children.cycles-pp.sched_balance_rq
      0.30 ± 11%      -0.1        0.20 ± 14%  perf-profile.children.cycles-pp.prepare_task_switch
      0.38 ± 12%      -0.1        0.28 ± 21%  perf-profile.children.cycles-pp.memset_orig
      0.28 ±  9%      -0.1        0.19 ± 24%  perf-profile.children.cycles-pp.__dequeue_entity
      0.25 ± 13%      -0.1        0.16 ± 26%  perf-profile.children.cycles-pp.wq_worker_sleeping
      0.33 ± 11%      -0.1        0.24 ± 18%  perf-profile.children.cycles-pp.io_wq_worker_running
      0.26 ± 21%      -0.1        0.17 ± 19%  perf-profile.children.cycles-pp.__refill_objects_node
      0.38 ± 12%      -0.1        0.29 ± 14%  perf-profile.children.cycles-pp.__resched_curr
      0.22 ± 13%      -0.1        0.13 ± 25%  perf-profile.children.cycles-pp.elv_bio_merge_ok
      0.21 ± 12%      -0.1        0.13 ± 26%  perf-profile.children.cycles-pp.blk_rq_merge_ok
      0.41 ±  9%      -0.1        0.33 ± 15%  perf-profile.children.cycles-pp.irqentry_enter
      0.18 ± 21%      -0.1        0.10 ± 18%  perf-profile.children.cycles-pp.elv_rqhash_find
      0.27 ± 13%      -0.1        0.20 ± 23%  perf-profile.children.cycles-pp.xfs_inode_to_log_dinode
      0.11 ± 26%      -0.1        0.04 ±104%  perf-profile.children.cycles-pp.xfs_rmapbt_init_key_from_rec
      0.23 ± 13%      -0.1        0.16 ± 20%  perf-profile.children.cycles-pp.io_free_batch_list
      0.13 ± 14%      -0.1        0.06 ± 53%  perf-profile.children.cycles-pp.__dd_dispatch_request
      0.17 ± 11%      -0.1        0.10 ± 29%  perf-profile.children.cycles-pp.dd_dispatch_request
      0.19 ± 11%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.___perf_sw_event
      0.12 ± 18%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.__pick_eevdf
      0.15 ± 15%      -0.1        0.10 ± 22%  perf-profile.children.cycles-pp.elv_attempt_insert_merge
      0.17 ± 27%      -0.1        0.12 ± 33%  perf-profile.children.cycles-pp.__kmalloc_noprof
      0.09 ±  7%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.wake_q_add
      0.15 ± 15%      -0.0        0.10 ± 21%  perf-profile.children.cycles-pp.place_entity
      0.14 ± 12%      -0.0        0.09 ± 22%  perf-profile.children.cycles-pp._xfs_buf_obj_cmp
      0.14 ± 18%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.xfs_trans_log_buf
      0.12 ± 23%      -0.0        0.08 ± 33%  perf-profile.children.cycles-pp.fio_ioring_event
      0.11 ± 10%      -0.0        0.06 ± 46%  perf-profile.children.cycles-pp.mm_cid_switch_to
      0.16 ± 20%      -0.0        0.12 ± 24%  perf-profile.children.cycles-pp.xfs_bmap_validate_extent_raw
      0.11 ± 19%      -0.0        0.07 ± 23%  perf-profile.children.cycles-pp.blk_attempt_req_merge
      0.08 ± 13%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.__sbitmap_weight
      0.13 ± 13%      -0.0        0.10 ± 14%  perf-profile.children.cycles-pp.hrtimer_cancel
      0.08 ± 18%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      2.78 ± 11%      -0.8        2.00 ± 22%  perf-profile.self.cycles-pp._raw_spin_lock
      2.30 ±  4%      -0.6        1.72 ± 20%  perf-profile.self.cycles-pp.__sched_balance_update_blocked_averages
      0.40 ±  9%      -0.1        0.29 ± 13%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.28 ± 15%      -0.1        0.17 ± 23%  perf-profile.self.cycles-pp.down_read_trylock
      0.25 ± 14%      -0.1        0.15 ± 14%  perf-profile.self.cycles-pp.__enqueue_entity
      0.36 ± 11%      -0.1        0.27 ± 19%  perf-profile.self.cycles-pp.memset_orig
      0.33 ± 11%      -0.1        0.24 ± 18%  perf-profile.self.cycles-pp.io_wq_worker_running
      0.22 ± 11%      -0.1        0.13 ± 23%  perf-profile.self.cycles-pp.update_se
      0.37 ± 12%      -0.1        0.28 ± 14%  perf-profile.self.cycles-pp.__resched_curr
      0.22 ± 19%      -0.1        0.14 ± 16%  perf-profile.self.cycles-pp.update_curr
      0.20 ± 12%      -0.1        0.12 ± 28%  perf-profile.self.cycles-pp.blk_rq_merge_ok
      0.24 ± 21%      -0.1        0.16 ± 19%  perf-profile.self.cycles-pp.__refill_objects_node
      0.17 ± 21%      -0.1        0.10 ± 18%  perf-profile.self.cycles-pp.elv_rqhash_find
      0.31 ± 11%      -0.1        0.24 ± 14%  perf-profile.self.cycles-pp.irqentry_enter
      0.20 ± 16%      -0.1        0.13 ± 23%  perf-profile.self.cycles-pp.dequeue_entities
      0.31 ± 12%      -0.1        0.24 ± 19%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.10 ± 21%      -0.1        0.04 ±104%  perf-profile.self.cycles-pp.xfs_rmapbt_init_key_from_rec
      0.22 ± 14%      -0.1        0.16 ± 23%  perf-profile.self.cycles-pp.xfs_iext_prev
      0.20 ± 12%      -0.1        0.14 ± 19%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.24 ± 10%      -0.1        0.17 ± 18%  perf-profile.self.cycles-pp.iomap_dio_complete
      0.09 ±  9%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.wake_q_add
      0.18 ± 12%      -0.1        0.13 ± 20%  perf-profile.self.cycles-pp.elv_rb_find
      0.11 ± 24%      -0.1        0.06 ± 57%  perf-profile.self.cycles-pp.__tmigr_cpu_activate
      0.11 ± 20%      -0.0        0.06 ± 46%  perf-profile.self.cycles-pp.dd_insert_requests
      0.13 ± 11%      -0.0        0.09 ± 20%  perf-profile.self.cycles-pp._xfs_buf_obj_cmp
      0.13 ±  7%      -0.0        0.08 ± 23%  perf-profile.self.cycles-pp.xfs_trans_log_inode
      0.12 ± 15%      -0.0        0.08 ± 27%  perf-profile.self.cycles-pp.prepare_task_switch
      0.12 ± 19%      -0.0        0.08 ± 18%  perf-profile.self.cycles-pp.___perf_sw_event
      0.10 ± 14%      -0.0        0.06 ± 16%  perf-profile.self.cycles-pp.set_next_entity
      0.10 ± 12%      -0.0        0.06 ± 47%  perf-profile.self.cycles-pp.mm_cid_switch_to
      0.10 ± 13%      -0.0        0.07 ± 21%  perf-profile.self.cycles-pp.xfs_bmap_add_extent_unwritten_real
      0.08 ± 10%      -0.0        0.05 ± 47%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.02 ±142%      +0.0        0.06 ± 21%  perf-profile.self.cycles-pp.tick_nohz_handler




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


