Return-Path: <linux-fsdevel+bounces-75642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLd6NiYaeWmPvQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:03:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B99A2E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 937463015488
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04A2DE6F5;
	Tue, 27 Jan 2026 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O52S8ndk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F508625;
	Tue, 27 Jan 2026 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544220; cv=fail; b=VaoFvCZ4Mg7J7DC29oDKhYKYy4Wts3deVFxMwU76+IQNIPxwml3rv5UN+FGjhgZgR+Ate+NjuHC8YtDfCKz6XRqQYR1+HVzStUiMqpiflosMz474yqgEytMSYflZXNwPMNtCpLpT1Q+7aEjHf9GuZyq+rhDHE4PKRaZuRKx9X+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544220; c=relaxed/simple;
	bh=DTeZopToOez4URvHaO48uEgYcY6cknrsnnOAhu2q6yg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMJ80riyG7yKtwDXYf5h8KPhzgcc1nqcuYn9h35nIsX6SoNbixjMy7rg18X50fZqykVvU7XnUJZ25RxNo8lsvgSMTIEHxgIl/EkEaJMGo09xNPBiF6ECLhcghYQrdO1lJVQWPvpQy6PVe/efkZ0Stf3/NIoQbFshPu0MWH+MuzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O52S8ndk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769544217; x=1801080217;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DTeZopToOez4URvHaO48uEgYcY6cknrsnnOAhu2q6yg=;
  b=O52S8ndkurWTiB4ghJqx4VnbhIWrKTMFiSMHYiVxeCQzEmJBI9Grzk8u
   ujBJJUAVDu7mSTcI1oItoUqo2aWZYwJ+r64tQqfjpvzHVm20LobXlQvud
   Lr0DIGEdLzEFUmyGYIckMzLOKAbUthPuPLsgqXXLHQdqfLxy9TwU0FwwE
   YBCTF8JDJArbPFG+BgQkrofFsT7uuovdvHqopQyXLMF97nywIudLTZApj
   80s6q7rl13MGrymawwzXRKj3XHYQiqJDuxa1WkIcyeZKqMPWMfv4gYvns
   haGqeedhJYyujsAWZODCQdKbspX8D6s/ke1YDuZdxYVqxEnp/YCNk3HTZ
   g==;
X-CSE-ConnectionGUID: sRbNQjIUQnOupu1p3tlwnQ==
X-CSE-MsgGUID: cZAyvC9qSsaL6y9LjSHIKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="74375167"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="74375167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:03:36 -0800
X-CSE-ConnectionGUID: lbxyO6JkSM+pCxTRbT1fTQ==
X-CSE-MsgGUID: 4vfxTpemRTO6xKXV4ZXxBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208512672"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:03:35 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 12:03:34 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 12:03:34 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 12:03:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+WQmMXTk/nh0k9pnigEAZ/37WMedU66GwfynuE3UDAKZqzwYNDr50FkIEaWDLx44SDhlJz/n8rntRCu8dJxEtNw72cQJaO1CYvOBw8OKg46HbQaw70J8/pOeOPgJCaYjAz955nAgdcY9V691TxqfFVVL2nv76c/JnOUdCYnhFcXSgkTUPCX+i6ay4YlfprOGwDwDuGOzAg3DMevxz3IsPW6AuGUogPX1ff9BdiVp7Sxq8cZtJ7fLRDrMN8ee478+fwvXQKFhpL+sg3L03eCNrxRpxe5wkbng6ixeMTJ++ipUrPr6J5yFBRenijROe3o7NAzpwC5gXNLBigj5ShAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySbqJgsl72ub4wHZ00hHO94brE3nh2IlwTF+d0ZUBR4=;
 b=b1TniEWG9or0NoSNIQN+8GR3JMsdZoqatTAewnduZv/blDw+rG/pBj8iMzYn5rw8Chvs+nVmZkrQadXzQCWVwpc44eulJlnbAKp6datVgqvLQrYVu4pFAjJTKl6hgcvsCDVPSG+WOVPrJmVsefgGszAbx/WO+9BGetP2ef+mtnpwreEVHzTRkQv1DKNrH2BIvgxQonDgTPw8cYVN4spVKrQf92nfUMMyQf+J9WVb5gqleprPEc8Llx2UCacRbnpkVymjaBndtLr8pO2c6an6LxdOz6yV/Qudy4KBdnmsMXXXfOzyAmE6PmVuaaCLRgIYFkQQ/MsOiCDchCxfnJz98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPF1CEB6B7EF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 20:03:31 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 20:03:31 +0000
Date: Tue, 27 Jan 2026 12:03:25 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Subject: Re: [PATCH v5 5/7] dax: Introduce dax_cxl_mode for CXL coordination
Message-ID: <aXkaDbpeqtABP3y7@aschofie-mobl2.lan>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122045543.218194-6-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPF1CEB6B7EF:EE_
X-MS-Office365-Filtering-Correlation-Id: e76621fa-8199-4aa4-866e-08de5ddf24b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I6Y5wKs8+aE+evqgNGjFq7TjzwlW6cd1m1iu4UkaDnchbaMlTWWCJDmSD8uV?=
 =?us-ascii?Q?Jx40SImZk8tM0IwqRQPYKJ+egbIuqm1IbBkzt5HuUKV7plXiEa4c6M63Enfu?=
 =?us-ascii?Q?njh3wMc0ZtCSRKq0HBGx7IynajihJo9IM+oYcBrQv6ri5u+dp/oXspK7Jm+L?=
 =?us-ascii?Q?+MvGcGbLnFyaJo0Nre84U8WeTXWIq0/ZPjazF0b2fWLfuiGkWUfiX1jrR6lo?=
 =?us-ascii?Q?JL8dOEzPITr8l4xDRfnGLZJnupTBZPTOt+HeHWxUvSDwmG/t69xcntyl2tX2?=
 =?us-ascii?Q?DSTOI3sJb6jMcrp31bL1SxyzlHyGESAOc8u3hgXFi7kdiltYHP5jExqOoIgK?=
 =?us-ascii?Q?Aju8+Imp9Iz1zauR7rpAQiSxwhWHyqAaGIhA0dbiO0bBMUWutMZBf/lqwWlz?=
 =?us-ascii?Q?TgOY8Yne8loMbGTuGJEvXPyp2DM2qLscNmKYXYHS1rkpVYqSFu2AXsRdEdwJ?=
 =?us-ascii?Q?6QpAUd+uJD4UoXwQYJuu7CWdpAx5q0IhrO2xhaa4IPRSjp1OA+m/Bq26QXgO?=
 =?us-ascii?Q?Ysu2/7HxEpMUioHM+N2oOwIrWtlcP0wyZgl7yknjJfge8K6AlEH6hesU3A47?=
 =?us-ascii?Q?FhmiCyyY+YncCG+o+SV+pqZ+9u7zMXeOiO/xhOHYKQQO8FRwM7AvUvT5ZQu+?=
 =?us-ascii?Q?ZOkeB5SzxfMimhnhzsMUrsT5BM+ry9QTi8rREhWolUvadCcBSxPKpudRUabP?=
 =?us-ascii?Q?UpA50RXq2efXNryf6O+wdtnQUEmNj2rskE1CAjAqe2IrQJslaX6FVzjBGHWa?=
 =?us-ascii?Q?679q0BsFgFn/L9IG4C/pj6pHKJCGNV70+aq8xEWq6nrUNkUnHUm0nlS+QzM/?=
 =?us-ascii?Q?rBRfTkWABF0Asz4TphqPg34AWCTX6axCTvaKgfGL7ZtJjcF+Ax9NyCGkUo1S?=
 =?us-ascii?Q?zvKKhzQ2MxQLJLMa2KWOU+XHGJdrUHquJJ5f5gHJWl+6H/9K2fBR2lg3EkUq?=
 =?us-ascii?Q?ClLlfu+iRnQxpWTwMZmvTDewl/8YWSBR30HVstcGInqv5oMAAvyzVq/PfI2y?=
 =?us-ascii?Q?Y8Pgc30qXOLUzj7NqPQtMvcVULGjURZag7qjy3Fqw2caPsJ5dLpWtk+T3Mc5?=
 =?us-ascii?Q?k2luruV7JltOvksaFb924M8AkeqykrR0lOlOrwoV1uW8c0PwX0bDsPO6pV5s?=
 =?us-ascii?Q?T7Gu++zTzVPChUpGoodEO0E1jjvkOn2zBegeAWuKXAONlNCamrF2VRPi1YCX?=
 =?us-ascii?Q?mqrq7RFWCOrVWylbay30YG480JCKpN7A2f5rv+kFz644JJ9cMWUYir66PlPB?=
 =?us-ascii?Q?AvsacuLFw32nPKb6x/qS/8Kmz268V+xPiycUXcgZq6b4T9CO5Ztk4rqE7a9b?=
 =?us-ascii?Q?d+sPJBD86OEH04g9I39h+KbQKxYE5NiQ9kDV8DPS7vWc6I/1gTidGqchLRtl?=
 =?us-ascii?Q?jx2w94IwmoNQTXp4/DPHHi027OY9bfx2fh6MLLWVmdps2fkNhR2C+8l1p37Y?=
 =?us-ascii?Q?fSUwtNmHo8uGSeQj1q8GcOVOwGB0hGzIyL9xo4Pk3Yary10iOv3NOBeRjIhc?=
 =?us-ascii?Q?qLENDH2nTjhkWsVfuNf0jTyVul9MYlCqiDGr2g/xCRtNhYegG7Zo8pEA9++g?=
 =?us-ascii?Q?qWFC2bB1A+3BgG+phxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dxz/+Ogo8ejZPlAigGKVBgVQR9bZgpTdELNWWrTURoTwq8qkVBZe6D6kr9wl?=
 =?us-ascii?Q?YCzzvGlmw3/LniQX3486bcNwBdBdMRicYO0JbKlIcTQNA8X5zuY6K18Ihni7?=
 =?us-ascii?Q?B5/Quqd7AAMvSxdp95SFXXjZ30pyiw5lkqVQmJ/gpFh56eCLtPhHmljDGnqK?=
 =?us-ascii?Q?2HSXr5DxYu7Qa5XKYwfDpUC7jfe9QP5XKg19Blx1BWAPxrAqh8GqR5pCAvg1?=
 =?us-ascii?Q?QTKO7fzxAVuEEUG/RpBlAJSpnHyrsNGgN9WqeswLGXif06iIFbOKUEyvOraI?=
 =?us-ascii?Q?23Tq9ykcPizpIm5Ug3FbEppu8NBLkCYs8zR8unwsoqhE50i/fSJkAoFhuAtU?=
 =?us-ascii?Q?1nut23wE/eYJK7CImix+MUVPT14CnLb7D3pC0gRqioM1gZZisfxTxuCoghOd?=
 =?us-ascii?Q?lfKRlSuWUKkThgFkPvT2vRjwoh0TwNHBI/ho3WPt7Ul0AYoGL3IGPDJtg13T?=
 =?us-ascii?Q?fRuGyBeBLwEdqXD6r3ZGrdoutZxU1CWnG6ocFKYO81wMQC2jySDr4L7PnD0z?=
 =?us-ascii?Q?/uiR91/NtNn/OUlscw/0YiBZhGTFxK43YU5dESw6+dsvsxLPKinXo4WGB6So?=
 =?us-ascii?Q?B3oV9jMD00oAXWH0ZEHuHITAWZfn7cDdhZUtMAl1FZzm9UVMCEEjrbVCpgjI?=
 =?us-ascii?Q?L1K5q+dFuu+B4KytJIm0GHi3NcRDXy95vfcn7w7LOm1E7xQoutFfRa8Q7iPM?=
 =?us-ascii?Q?uQasfGWXUWlIV3aYWjzFMt9Y6JWbKwcnB9hRWZ/IqkHw6kHMz6/kokc1fjaW?=
 =?us-ascii?Q?THIh+S2P9Md/Q8mX6mWE8OcSU9ONX2swlzKpgia/3JVOU9EDtUPLddYJ2f9o?=
 =?us-ascii?Q?ZyzcMeP+b/QNS40VxcLyOSLYFIux1RLFVCCT6KKnta2KTvBbAzvojY9yd729?=
 =?us-ascii?Q?FN2Ikh7pErcxQvB+OXx3sqc5Bqpp1WSpKuSA8eTUbdidASCY/uzDStJYwG4u?=
 =?us-ascii?Q?urWh9QmDJPD92RqEh6CRRxabmvH3OR8UkZqU6piFS6xNhATAMv5w7ZbNzIt6?=
 =?us-ascii?Q?0LAnbczm5NvJQWWNY+PaAw06J5swhllvNEmP+aTJvgX05gumhT8OqamIm+Rp?=
 =?us-ascii?Q?hmGzH8qivucneJhOTNtBm5FQpJ/r1iwRUJq3ZZIboxXCZDe1a7VzrjKsBUCF?=
 =?us-ascii?Q?gYfqkGIMDmoslyJOh6W+yY0IZNSWIeBSuc8aII7YrGohvYEWiswGz2coXW64?=
 =?us-ascii?Q?Xko1a6kxmZ01tlrJMHwWtd7GichkbDiCfgMeaNoQ7WX0su68QICGmnPHjVbr?=
 =?us-ascii?Q?UdM3cy5PWtzoMAVgE8hdtwo7Ai+ADKUOD2mQt6CG/ZEICJh/ZchNZvmp/AYg?=
 =?us-ascii?Q?qPfolJRIjx9HnrsLR7ehxFLbeCJ/tqhFtOHKMkYQAUizAB1CExjsPWIGAcXc?=
 =?us-ascii?Q?am6W29E4wuhG5wDHIX/eqgFDsH/x4z32foQy6XbxSNOeZJIR66yNK28exeqb?=
 =?us-ascii?Q?QVaqRUNWcuCqry44oFg0F+sz7/L5AEcor/k+38JM/HyL6u9NcUp1k213N/hz?=
 =?us-ascii?Q?CuFUB52pP9jFhyTnSc3XOpQAd/pU48z59oA2g12u7CRtPStti98Kxm3IS1ny?=
 =?us-ascii?Q?A+B/IH+jMKVLtAfUPn3VTo4eQpqjIHVIPoMRWNWB7r19G+vUmWM4Xnnh4u51?=
 =?us-ascii?Q?/Hn/oBrpafPTxsK2mbMH4a7DMGfGnJkwYwn2g4o/FzLKgIVsswNMP3Jhoedh?=
 =?us-ascii?Q?iBzpXletoiuJvtsnJ3D6V5xGEAo4G8+KvZSGaPfeAyTWNDaK698/CtM9mVl5?=
 =?us-ascii?Q?XyKDCNX2tic9QDgvBCTG5O8ukPqsSEA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e76621fa-8199-4aa4-866e-08de5ddf24b4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 20:03:31.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI0Pv1qJ+HbC/3HfSjQUv/wsNDz3v6s9daTbp2X+e3GyhWlk29VHT+D+L/ftjiXfEBRqsqjEscQCwpbSqZ3l7snEBmqLZsqJEBZgIrECWDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1CEB6B7EF
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75642-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 903B99A2E6
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:55:41AM +0000, Smita Koralahalli wrote:
> Introduce dax_cxl_mode to coordinate between dax_cxl and dax_hmem when
> handling CXL tagged memory ranges.
> 
> This patch defines the dax_cxl_mode enum and establishes a default policy.
> Subsequent patches will wire this into dax_cxl and dax_hmem to decide
> whether CXL tagged memory ranges should be deferred, registered or
> dropped.

same as DaveJ comment. Fold into next patch that uses it and grow the
explanation of the state machine in that commit log. Also add in
code comments to this enum.

> 
> No functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/dax/bus.c | 3 +++
>  drivers/dax/bus.h | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..72bc5b76f061 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -24,6 +24,9 @@ DECLARE_RWSEM(dax_region_rwsem);
>   */
>  DECLARE_RWSEM(dax_dev_rwsem);
>  
> +enum dax_cxl_mode dax_cxl_mode = DAX_CXL_MODE_DEFER;
> +EXPORT_SYMBOL_GPL(dax_cxl_mode);
> +
>  #define DAX_NAME_LEN 30
>  struct dax_id {
>  	struct list_head list;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index cbbf64443098..a40cbbf1e26b 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -41,6 +41,14 @@ struct dax_device_driver {
>  	void (*remove)(struct dev_dax *dev);
>  };
>  
> +enum dax_cxl_mode {
> +	DAX_CXL_MODE_DEFER,
> +	DAX_CXL_MODE_REGISTER,
> +	DAX_CXL_MODE_DROP,
> +};
> +
> +extern enum dax_cxl_mode dax_cxl_mode;
> +
>  int __dax_driver_register(struct dax_device_driver *dax_drv,
>  		struct module *module, const char *mod_name);
>  #define dax_driver_register(driver) \
> -- 
> 2.17.1
> 

