Return-Path: <linux-fsdevel+bounces-34542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB679C6247
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C036A1F23449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7C219CB4;
	Tue, 12 Nov 2024 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/lr8dwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257120ADEC;
	Tue, 12 Nov 2024 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442291; cv=fail; b=DRGrViAI4FcD48cuBColQ+B6rAqBFFHhpit5Ftjm8/uACLToFQ2rm5CzwTRCdKMCuoKFkL4cqEvjK31kuYeuQjdArC83vap8B1+RM0KRLXlHIGLcUgggXRN5q26I1QAdQYz31F7jnYFQ3ph0J7tVh6oWzZbfvuu2zrpuSE6DEX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442291; c=relaxed/simple;
	bh=QHd2zWZfTPJ+w/KwSfRuwFY1JGoJDTKiaIcvr4yTieE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dh0pjD9AXOmKaJykFxCI89aEk9h8S71CSQKIzS27TzoV6dxC9xuB/MJ34p1T+T9Gxl5nv2OnBejtSKGWxcjl9ELt7VDpQMMXTglSnkCxRKloKGRDLD3Pt8USozuaEc586qhtTExmOoSozPZax61d6vEFrSuLUV2UsspHTK0/rxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/lr8dwr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731442289; x=1762978289;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QHd2zWZfTPJ+w/KwSfRuwFY1JGoJDTKiaIcvr4yTieE=;
  b=b/lr8dwrPfqLrxbBfuktxlxOpiHQTjx0vCkSqysyiKQjgIlFLL+pmiNV
   2N5Lc6lOiouXhXXpVerIwX4ay/nRG0JGdHM4D0KSSSzu7AoTqyRBCaQCi
   QUXFTFqLdLd2e3qNzY0FS5IAcBI3TG82fIfaUhg5h8flelu/RHRrHovhi
   3JeOk0Ciz9srXfCmPJgDfmBuUD2ICajalNuzeyhFV+53m2txrUtAMpz4N
   +4ldv0U3cqNJaT60lzLYadG7pRHzPtvgGJZiXY+rodKJXkG85AfwSn3Pq
   Cc85t064qwuzIBKRrRn0TeByz8DCzKw/MNWuXQ9sSnn0lqttWoCT0Wgpe
   A==;
X-CSE-ConnectionGUID: j5eNgobeTcyu7rojKpj3cQ==
X-CSE-MsgGUID: 6+/CDAbZSumrOrePP3//cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42709467"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="42709467"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 12:11:28 -0800
X-CSE-ConnectionGUID: sUs2kKpHSD2UlDKAEQI6Bw==
X-CSE-MsgGUID: vUgap2NCQWOlAlUdu8qKrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92566667"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 12:11:29 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 12:11:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 12:11:27 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 12:11:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe9+Wrpjf7JT6gPp+LMocPqnXGkJMGpBCCtWerIwIZUS+8z0s4LyL3DBqG72PW/dXhcvkQcaApUyQ4Toni8HkvcxwLsxmitrZQ0MgVxvI47QU5wnYnYfiahWlXHbiJP0ttPsKI+0J+z9pKGrMKtPdVcm8b9XQMRqM5c69rbwKO0gtmS6JuOU1DENoN8/CUFlgsufcLJE7NoJ/YM2Vh/uarRFzsp1n9a8wXfq7YATlScqtBqpTQn9ZzZdpg/Lv/urZIU6keRtsL/ltduGI4h2MjFbJeTS8ss7V+k6xb0Gi7Qdb48oJtskrqL1UzXyMQBTAQ2E09gEjuB5LPARAN/biQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8dUrxbhifg5SBU5bsg18AuiZFiLjqmue1MR2sN+yZk=;
 b=h1MMTtFl0ahIL6/ACdyrgm2pHzKGwQY5Km4cm3B815uOEWNmAGyVbbkX8zHFhCtamN70vnB5r9iO4mKcMB28FQhr5/Juo+YnOBgq4CjsiyUgmpQ2QwYf4ViFvzYVujTGL96Ov/3SDa/1rnQrnmRrDq71Uwm2mPTXxjrWuL8Lxc2xz2mE7gnVlQmSIyFQpJ9qi2UN1hKv+OnZCjbXkXtyPPPXD2vd8xGqV3sxg55ZcfEwOWcAiH/9s7/P3D+b4AV/MIrGsRgQkI1h/w0FR1L/nK7SFlTzXJ/rbeok6IX6ig9txH2K7ouRReGdLxM1xiQNMkIlnDIN1RAX55n5mYcu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 20:11:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 20:11:22 +0000
Date: Tue, 12 Nov 2024 12:11:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Asahi Lina <lina@asahilina.net>, Miklos Szeredi <miklos@szeredi.hu>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Sergio Lopez Pascual <slp@redhat.com>, <asahi@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Asahi Lina
	<lina@asahilina.net>
Subject: Re: [PATCH] fuse: dax: No-op writepages callback
Message-ID: <6733b667ea3de_10bc6294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241113-dax-no-writeback-v1-1-ee2c3a8d9f84@asahilina.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241113-dax-no-writeback-v1-1-ee2c3a8d9f84@asahilina.net>
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 14409c92-e01f-4b80-5806-08dd03562d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ix/uUBkmpIvbKjuty3UReRX610XkLFnbgg4llTL8HarJd1im3uLMgrlSQrrE?=
 =?us-ascii?Q?4naMPH7PaDRJh6r3eFIqDuUMYJtltAAmYnYxVkLKNzW2/1PrpAXS9xomoIMF?=
 =?us-ascii?Q?D5OU9qOrCVfvVBPfG+0OPWdbz1PVHZQzPcUoptrifcQtnj9OmNm+PNluV7hd?=
 =?us-ascii?Q?Tihd0oZCIFJzmGmbKzDnOCzbiv/WkL9fbvlVCU5GtBWD20uGdbgxT1ihmNHW?=
 =?us-ascii?Q?4kHqBoR5Lrrdjpg5h53O538/Xpo3w+bLJuHHYceLGzcdeJeJ0q57M/aU2kkD?=
 =?us-ascii?Q?OSDIDXOWvDZMi+oIkw6Vx4nDtMtV/7nbnXqM68oyjDjQTROHK4KaUv7VZqdj?=
 =?us-ascii?Q?suplVBX1F+E4VKxzUlVVY8M8ykgamLkJCBC9pzknTCh7ttIqyMoA/yaK+ckV?=
 =?us-ascii?Q?5VVJoLXSOAUhdF3X8/PVjKfaBmzhiLVxfvGdhV6q4Ab2w3BMM78kD1fR3uHy?=
 =?us-ascii?Q?IE+TsxqIVAg2lMRq8ThBoANDA376cdkF4JZXgHUB++XJ98g2Vz2neR5zw0zi?=
 =?us-ascii?Q?qpdQLUnqbg3FsjiOTeEEUtQDaiyZVS5gULMhdElw18QVeYncv1Lwjyn4h9K5?=
 =?us-ascii?Q?jfQWrd675ppeiWE7Pho4EU5gfIwKJYs/QpIiT1x2GDh7H7ENgFDHU82k4/+i?=
 =?us-ascii?Q?W8zDJfNRgvyWI6maP2JoTPxkAWzP0o+n3JSwKYOVo0437EMIIlPof7sIRVbh?=
 =?us-ascii?Q?LK3MKlroSxeRpQMxTHUboFd2Y+AMVjSG2ZJeOpUtTVmacu7vEfV9vckYwOMc?=
 =?us-ascii?Q?U2sD2vAhG1gUs3DzHl927+WUMxCNpcUxliPwJwVGxY7i6v8b0wxhCfIdbZaO?=
 =?us-ascii?Q?Zl+GibNx8JLLxpnQLdY6nBSGjKRItHYI/uw4UEJE/HcRa8Xu43kbEZ2ZrLbi?=
 =?us-ascii?Q?dgwKRY8zzcx5dDh7tw38nZ1J9slaDtpLsAUD3MjSOyTFLNLAiJ9dd1EWZC5p?=
 =?us-ascii?Q?acmv9ExmK9jg9+Ts1YoP/wm7IRbbHBQLAjqc68bZtyukEeEC37jMB0VaqOZP?=
 =?us-ascii?Q?JT3nqHfjb/CcSPWUulTGsTxGS6qJksJXh7ErOc/mZqhJAu7mOoaqF8N59BbW?=
 =?us-ascii?Q?vC4d9aaxwB7Ju+szXNA/9uN/FrVZtfMmH4aIS9kBJj8n+Y9caX3S4eyq4j7M?=
 =?us-ascii?Q?iKsfIJjodNIWCUBf2GpQTuH/VPu62uuAUIuqSIWMAmqAMAYz8L9VFzetwdH+?=
 =?us-ascii?Q?aPgM6GPNmDgFayXPdilbb8uMTZx1fyH5sSZtHOxPrn1bVPZM43QVpAfMX8ON?=
 =?us-ascii?Q?EB0xPHTFzOIocRYJRpgI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PrBN41HazwRpA2Hz5GEQ57n456GBkpcbsDK6VTnxiizUR2KEHKcCR+K+87gh?=
 =?us-ascii?Q?YJ1okkFMV2idS0MecVsdtzFS6HyWfgw7BGRbrac9ZGipwIlPougqqbX/9zg2?=
 =?us-ascii?Q?F9wQiuE3J3cX2gEe9PCl1WqX+PU4gjkvWZlwfNrpZpz6ITL58AG4Vk7KIig7?=
 =?us-ascii?Q?ClJQd9A+0kStE9Otr5vLVMpVk55EyjUAoCeJ8D4peOIUuiZGBc2ZMQCX1nLM?=
 =?us-ascii?Q?P36gThngdoIWOnyUJ4fKIp90sUmOFUlSFjp32Z3WBRC5O07v64R8dsHsGd3D?=
 =?us-ascii?Q?zZVZ0Y+rUE0I0MtTfiyBgd45lRLrosDYGSH6G/eYimhXdxkjC6LrhtDQy0x9?=
 =?us-ascii?Q?jX3LF1L9Svd1iGh9gjBVBgpqywEifKcxz+HKo1S8NtvsUBKkLN851cGxhTJn?=
 =?us-ascii?Q?nOgipVWN8vKpISfN/Du0rpN3aguhFIUZioZpjwKTtMApnnHw/6C0O3Mk9OAH?=
 =?us-ascii?Q?WDMLhgJu52A/y3An+HnkpCtb6dMN6vr9HkwCgtiy1MlDGhfWrPD9sjl4p7lp?=
 =?us-ascii?Q?aXeKuPHuJSU4AH169H9QpWAZkN3mPUOSQ1qjBTBRmfkdnRAPhw0Bf4/6qBJe?=
 =?us-ascii?Q?Ixq+cQyrYFNGQulCX0PFtnpMge3pOUbtSIuBrwzPfscRdAUNGzELgQGy4i69?=
 =?us-ascii?Q?LSd1OLuEW1Yl81+b9uw1uXJ5ExOqaQNRn694Wnnd/nI4a5XzKiISMb3ofpRk?=
 =?us-ascii?Q?jE2lGleTsMwILhZeNX6aKak5s+DKgF3xk48vZIPLNhJ4q/KMBwbbhGfAQNM5?=
 =?us-ascii?Q?5x1Jb0t1SQQIpwymMZsH8EapCK8wbJ2HNwNoPpj2s9bXwA/asSBTKwW1yoLd?=
 =?us-ascii?Q?SVvBKrOKHU3c/wO9sWseaQcg1vYedyyeyg1f596+SqK54YXd4fIKi+Kssipx?=
 =?us-ascii?Q?5vIcRLGg76OrSvEZHNi1cnaroBXyK4FNv8l5xNLUkgzEdUNdwSp+gAIge8Lk?=
 =?us-ascii?Q?O6nSxE8ehUGpb3HB0mw0e31zENrXsBsRaauTJtaNDlI1pKJ/15aKRRlVYmSA?=
 =?us-ascii?Q?MWBSYCOXsjkqNgkokY4MBXYnF68G0vm5/jafwX46Zl0OStT6wodOfTppqwg9?=
 =?us-ascii?Q?l8N2tmGdFHRCmh84PxTW8vQMEVoNYTSRMvu7ZqtluQijTPMaCi4kiZ/Gr5Lk?=
 =?us-ascii?Q?U74jtZXUaUf+FXhxFP1Qo3/cd/5iNgAES8OOBBxZCvi8KYa00+9ddoPg8fh+?=
 =?us-ascii?Q?jU5A+SkjXgMRIWhFYJLrBCllG4zmVoVaH38zH1YW03iSlEaRdcfk2ojGODvV?=
 =?us-ascii?Q?eKSHFiuqrUVdLz2fS3z4aaQWVkyUTr0twAwKtnmw0g4s3IzRxe4c14588guv?=
 =?us-ascii?Q?Tbyn/GQWb1v+HnsVX+FBRI70PBjVnaVTSIl4p3bzs4IQUCw5TDzkjJk0qNXG?=
 =?us-ascii?Q?+FgdEmRREtShRouwrBDikzP1/oqd7tFW2qsOw4PSBeltLg2a2ZAQLbAm0uns?=
 =?us-ascii?Q?C+wQvZ93ZUJ1nx+Ny0KFA4qalambqMCts6PnrwlcaQEFZvcgKqQK9qrPV5XC?=
 =?us-ascii?Q?bXdqTqe8haWXqy941Z/e5QJjmq6uQR/9S8LDaFcLi9T+/FnYqFJ73W7/yGK/?=
 =?us-ascii?Q?VzxRRvT4qq6bWcPN9zG+a6/frD17tgOblLEp+CemsGQRvwYMJNU5DpLLwxq2?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14409c92-e01f-4b80-5806-08dd03562d90
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 20:11:22.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf9WIXIkSKBA5XAQ88WohHff21MPqA/huwdAuCo+RSIVaOkEy+KKYs6PEmOpcmt9nPkuCXzrjFSuqMcjJd7bkwrExIya4d9e989QUlXeGl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com

Asahi Lina wrote:
> When using FUSE DAX with virtiofs, cache coherency is managed by the
> host. Disk persistence is handled via fsync() and friends, which are
> passed directly via the FUSE layer to the host. Therefore, there's no
> need to do dax_writeback_mapping_range(). All that ends up doing is a
> cache flush operation, which is not caught by KVM and doesn't do much,
> since the host and guest are already cache-coherent.
> 
> Since dax_writeback_mapping_range() checks that the inode block size is
> equal to PAGE_SIZE, this fixes a spurious WARN when virtiofs is used
> with a mismatched guest PAGE_SIZE and virtiofs backing FS block size
> (this happens, for example, when it's a tmpfs and the host and guest
> have a different PAGE_SIZE). FUSE DAX does not require any particular FS
> block size, since it always performs DAX mappings in aligned 2MiB
> blocks.
> 
> See discussion in [1].
> 
> [1] https://lore.kernel.org/lkml/20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net/T/#u
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  fs/fuse/dax.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Looks good to me, thanks for the discussion on this.

Acked-by: Dan Williams <dan.j.williams@intel.com>

