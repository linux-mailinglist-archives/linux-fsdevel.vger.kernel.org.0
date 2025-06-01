Return-Path: <linux-fsdevel+bounces-50265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1336AC9D70
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 02:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311F718966EA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFE87485;
	Sun,  1 Jun 2025 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3zNnUbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB0137E;
	Sun,  1 Jun 2025 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748738285; cv=fail; b=sKauq8V7FWR5/n8neLvxpcbtQQtYVa6Qqasz+EdnwbkVUdMXOLIGA88J6xKMwxv74NFGJeZNyYmuHRtZzffGh1ldGmrkSnN50Gj5u95pLL0CPlTRJgkO0GDkOfOn4uVvKWxB09U+smbZ1sB7lcspEtta/yhqsLcxB/T08o6P5cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748738285; c=relaxed/simple;
	bh=Op+PCINUiYWr0go2R8+fSCn3kqv+LynPCX1Yo2YYke4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aW7S33G3wpBD3EgtkF4PszaLdBHrVI6hhXulK/Ce9jLdofzbHLQkZxBWCe76l8/6e5QJUwjHQ1GRIBiqsg9p4CAeB2OjRX0WIQwjAEBory2LuQpajp/EV9+B5INmojdLsN65egm4DDp7d2MI3sAjLhIrhVpMwRm6lA8R8tJiRoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3zNnUbS; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748738283; x=1780274283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Op+PCINUiYWr0go2R8+fSCn3kqv+LynPCX1Yo2YYke4=;
  b=L3zNnUbSQrnXKGWt2PDmHgPAnSBbJUnv3/zZSbwnWTHjKXPK5UXorKrF
   +FeBX/XUwAZtIDBchwTsuFbSA1qDevO6e62vk2V1/0Hiei4hQjUA4UcXl
   Q/Fmoj3tM2+V4xIzJichVqMmBAZOzurPHQqCSNxwbMzc6KQPi7mLgZntP
   5A005VwM8M7o7xzElwb/tz2ga3e/08cJIrRf6LoE01mz7XVhNe4BLPuVl
   Y8T0QW2EphtmwALfglUXJS59IxvGFZ3u0ceYZuu9sNsa10spCE3U88+oW
   qT6ibPjrT3HQGpHo4n5U5Gm0Nf09ejplxkOc0Bs4WrTOsmeKwxhSl/Qny
   g==;
X-CSE-ConnectionGUID: khSpHDSfR8uwL6zkQrxiGQ==
X-CSE-MsgGUID: rMFmg/llTzyfz3+65ir2aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="62142158"
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="62142158"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 17:38:01 -0700
X-CSE-ConnectionGUID: zpaIxgRqTcW4Cpn099WpYQ==
X-CSE-MsgGUID: jO9aj1laRGSoBbIlyESvNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="144532409"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 17:37:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 31 May 2025 17:37:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 31 May 2025 17:37:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.58)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sat, 31 May 2025 17:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOPfrmcCpr+RgknlKK1osi38o5ZqqxHriUqufIciHbx45N7qq9Ph3AFx2BcoRw1sWv58f6cLwi+NE2Phi+TqS6C5SqUr0nJuJ8TRKSHvYY5OFA98T7Ls7oLQ0MGWnko9J1hMTF4Ae9phYJQfP23NXj4dHdva4ZFsOkPnM1LzGQAudFgns3nyhnGWIa7BPlNCt9JtJVyc8vvJb16n3UXjjC0iQwurjtuAuGj2iobzFwR4nb/MYXxeGDKdvSU3RMcdlmOICTngkPBkb3xE+G1T6uxuxX6pf4hJwixXCl+cUWU7oQRIUgNdih/38cQ3hC5ElSesbs1MaDIsjY+M07ZRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otFFrhabfW9QxezSUL7NDo+N97ojwJYNKzu5v7ipvUE=;
 b=hS6wz50K1QUWdFnzxs4MPhitEfg7Eb0moX2gwbRNHa8dIfwR4d99NjLSfhB9zqknS40Zl9ml2XHEuEJbwYHfG99DEI0XfzdXlAZNgHU9vtt7eZQzNVkuvTDRxRoTn3fQx/m295CnNFxJFxS6tEwBBalDfZQz+blBX3xoLkYGssTMojt2cb51JnjampM/wmyNNjLa2SS70wfhK+BHx2uKA2KDz1hSRz+IUr4RcX4BC1TvuVgud3Kxlpmyq7PEgKOEzkdgt9piRoT6QucPZGIIuVQj5SJTWdjTcVBnlSYq7Se6gSZvkBKDMUUuAETsMcWhJaDGCkmROX9ter7t7L8jzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ0PR11MB5151.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Sun, 1 Jun
 2025 00:37:42 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::d013:465c:f0c4:602]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::d013:465c:f0c4:602%5]) with mapi id 15.20.8769.022; Sun, 1 Jun 2025
 00:37:42 +0000
Date: Sat, 31 May 2025 19:38:22 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Ackerley Tng <ackerleytng@google.com>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <ackerleytng@google.com>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jroedel@suse.de>, <jthoughton@google.com>,
	<jun.miao@intel.com>, <kai.huang@intel.com>, <keirf@google.com>,
	<kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<michael.roth@amd.com>, <mpe@ellerman.id.au>, <muchun.song@linux.dev>,
	<nikunj@amd.com>, <nsaenz@amazon.es>, <oliver.upton@linux.dev>,
	<palmer@dabbelt.com>, <pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <pdurrant@amazon.co.uk>, <peterx@redhat.com>,
	<pgonda@google.com>, <pvorel@suse.cz>, <qperret@google.com>,
	<quic_cvanscha@quicinc.com>, <quic_eberman@quicinc.com>,
	<quic_mnalajal@quicinc.com>, <quic_pderrin@quicinc.com>,
	<quic_pheragu@quicinc.com>, <quic_svaddagi@quicinc.com>,
	<quic_tsoni@quicinc.com>, <richard.weiyang@gmail.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<steven.price@arm.com>, <steven.sistare@oracle.com>,
	<suzuki.poulose@arm.com>, <tabba@google.com>, <thomas.lendacky@amd.com>,
	<usama.arif@bytedance.com>, <vannapurve@google.com>, <vbabka@suse.cz>,
	<viro@zeniv.linux.org.uk>, <vkuznets@redhat.com>, <wei.w.wang@intel.com>,
	<will@kernel.org>, <willy@infradead.org>, <xiaoyao.li@intel.com>,
	<yan.y.zhao@intel.com>, <yilun.xu@intel.com>, <yuzenghui@huawei.com>,
	<zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 23/51] mm: hugetlb: Refactor out
 hugetlb_alloc_folio()
Message-ID: <683ba0fe64dd5_13031529421@iweiny-mobl.notmuch>
References: <cover.1747264138.git.ackerleytng@google.com>
 <bdd00f8a1919794da94ba366529756bd6b925ade.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bdd00f8a1919794da94ba366529756bd6b925ade.1747264138.git.ackerleytng@google.com>
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ0PR11MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a3867e-d009-4061-5f06-08dda0a48371
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k/EGfBEnkiAUd2KS1kl7uYzfmNbC2qRUjtRZ++Ur6jGNTuucKTj9GUqP+mGc?=
 =?us-ascii?Q?3aStdr8Bncazf78vPKpI2m2qMOellYCcmOWKtznRhY4iKHG+V+II0JUSWFn8?=
 =?us-ascii?Q?+on6LzlxVxbnvaZ7cFnzF5QXp/qgQq8m0eJaIeJ7W3IgxzquX5vw+YSkwP2F?=
 =?us-ascii?Q?m4hUhIskExJx6cJCvECg4w0Rx6DnlPl4M5Y3+0r/QfG4SG9u5eM0kq5BnsfK?=
 =?us-ascii?Q?BhrrNJsnFGDHb7FmhHawT9J6O82z52cHtcRVrlGainduY9zoF3lzXf+Ze165?=
 =?us-ascii?Q?5orPH7w7U7c+NfX9oD9vbqcCWaIq4l0REYkurB3S0U5ywvYMuby8xYUkVX36?=
 =?us-ascii?Q?iJCxdePGk22uoYKcqqkmpHl756bjJV1Vng2RRmyWwlV5EAoTg4PXBt4lFBAy?=
 =?us-ascii?Q?LCBl2fmHQQz9oUVEE3McJNceJ9RXU4OI23cIoKw1haB6Cjnwce6DQMdlqkv4?=
 =?us-ascii?Q?utPlrlf5EaFuHVgqD+6yxT16MHfkWyhk8TntxJ/8e/DYZw/uqba/QpONxFAO?=
 =?us-ascii?Q?8Q/1eJMvW/YoJZ9ql54H60hv4VcdD44rnkxFWHRWew2iGZXo9Rdl9d7wgsuF?=
 =?us-ascii?Q?WBuqVXjemO0coDaZtHoE7tQvAHVR+B1xLrhXgcbAzC9MiJAFq0sCMJg7RB5f?=
 =?us-ascii?Q?3KZxwDUAgVCZz3SpZ8TtAYAUED6BrmPCymETPDHeBpWQ5329TE/op1THZ/CR?=
 =?us-ascii?Q?KkbD6uI7g354DyV+2l+hxEqmKTroNXckx+PDRRmmWxpPHvvFnpP7jbcMz4r5?=
 =?us-ascii?Q?NCwDHj3ld9IVlWDh0TDos+scmEbXTCkwGqOLdtju01Yg3AMUzTr53r8ZNw5R?=
 =?us-ascii?Q?opgYFyIebGd7TMp/k46dpSx60Jg0jx06oPBGoBZjysH6WQXbTtx3BQhiCyxs?=
 =?us-ascii?Q?Sipfl0K0G123svJ0iTxybjiPDNTyo9oOR40ZePbnzx8AvDcDPFEmvpz/wonC?=
 =?us-ascii?Q?V88j4L6J6HDzI1EXFfQCEngTbhM1kW9g4OpCfzxdR1ko/tldCAWAletyrbke?=
 =?us-ascii?Q?JdLOMu2MhBqumKe/WhTbjtX/gY/kLgVkP1LSsruW4itbVoD7+QzegTGLNzI4?=
 =?us-ascii?Q?NAlYrN0QgtXsBNiKeNk4oP7zPVArGquGmR3gp1jNQpxMVjprV/+w0YKVtvx4?=
 =?us-ascii?Q?n64NxU1YU2yfogi5ODnfl+eukqqj7UPD1u2Ekk7KH5z6FwPOqI+Sc8sNTrsV?=
 =?us-ascii?Q?/dHDdjto0gWkFchRGBo7gsCwe4eutfH2nj95EwI7Xzrq72NPbGlBM89diDof?=
 =?us-ascii?Q?MhnlYTXM7OKB/yHfW8ejSZvbIT1e1BHaxnE4oE7Bxgyf4nmZDDuJLO+bI8Lr?=
 =?us-ascii?Q?NqvdD6yWhXZtwI2URZzBrDWz0esQ5OcJT912BFcJBFKmIRcs/fPlmK83y7Pm?=
 =?us-ascii?Q?9HrRbUiyAM0ZIgUVMRIY67DxsfyzGzM8wNDQC7njzSU380zYUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lXgYrU9xyW1Dz/XuARyVbKXs8DC/W9zyDK/S4sjvM3Yju7YfdxtKk7aFAgag?=
 =?us-ascii?Q?WjpjEGyZ97B2JGwLhVyOSbocSYodcj+zmvHgIHf9pdOqrmDF68vdihWEVVgy?=
 =?us-ascii?Q?Jj26vK2+b2Duw+nT8IHMSJug2nG1PRyz7uBowNWW8joqkPytPXoGbN+9hm2b?=
 =?us-ascii?Q?HUcQEhILgD4Sx5zNZ2tJcMu5ZBvKrpIJCo+prO/dwOIVYjGDMoHYRyK1gsVZ?=
 =?us-ascii?Q?bZaO0JTUd+GRt0yte010Kb1y6KlTGcThtGJVV/YJK1r9nw9BVPsOOnvbAER8?=
 =?us-ascii?Q?H9iueXV7Lm4yQeC81t3GXCGNXIaqaKW/OOtiw8nJQyX+2kVH5oYJbV2nb4J7?=
 =?us-ascii?Q?X2QXUgXIydpOhEGvtMQfXlQ3EX905XL2TVDT3/ExidRJzynZLJ0iK4FG0IAX?=
 =?us-ascii?Q?xy+i6aTSs0tV5s83DEwB8Mo6ErIAzpYkE+J5JCEFUlK4euhzibUQLMZkz/1W?=
 =?us-ascii?Q?srF3IpDG04U2iL62mehwJcLdMrIAD6qbHVjn2+4GbyLI23khZJ/RWHUWouN0?=
 =?us-ascii?Q?GSZ0koWlZmQozOA69qsiU7WE8acUxIS/esuyPkMojWWnEaUH4LpTXsMNy0vT?=
 =?us-ascii?Q?L7EPHaMC/XFm+MMZwdrv2XBQ/qXSdrp++l8lgcB2SNjoJZ86HsVFpxmBfFat?=
 =?us-ascii?Q?y2YGQjHGr1JHNnrGd1+hnF5l7tFbOjz22+CXCOdDBajz6kA0YcBTVomW2+zI?=
 =?us-ascii?Q?roiCw2UTqHYRcqTMtliWzJHaOyU+wAAs45lAkMzmDYRkmC+ZN4ereJBX1ABx?=
 =?us-ascii?Q?7Al8y7vQNm6JzJlHGuiQLsjDGRBJ9WGpqet307uYfiIvU/iS2/aax1Ef95md?=
 =?us-ascii?Q?wzoPdwe05X+utRCP3rMHFmjY96Q7K3D5gZX0Q/MKtP1ahEdhogjSAPw+AQUR?=
 =?us-ascii?Q?BYNe4hyDF5QQo2cls7bgs57eERkUtLwrHhxR98Eqo23LXKVjmJYUU7KWEdDg?=
 =?us-ascii?Q?DOuBOGD6UF45HT8vkY4lbJ1S5QiYSWGsczVbkH2vv0OGbzeuwUaE6ve2ru6y?=
 =?us-ascii?Q?jpszR1feDg+BxzLWggls4mOjpywcXgV4hKmygQO3m1V/y5Ce1LWfRkNujmx4?=
 =?us-ascii?Q?Xcli5SEqYhceqWBYIT8/R45rYrQk/Oj7eNsLY0cSPPuij4dfgpRWeIeUgX6G?=
 =?us-ascii?Q?vkAjA+0IJoB0Cg83HE3CtPzF+Te/d1IgPeYUuKVNPZ/oEbJ0rH7mR6BZfx8E?=
 =?us-ascii?Q?947EQmGzvir0IBARPC/mKzUul6u+UnokZTCGlYvOXxUicvLTnnxdEFwwd1lJ?=
 =?us-ascii?Q?Z0+xIxpogkvG9tgVHp3Z0qvdibobK/acAVIhYLPmxyO+Y4h5oOA+ekjLaHaV?=
 =?us-ascii?Q?ndKOUABksi/7zVl0JifamRaPZzuJleXBLB26Czj/8BvbTbgCb7xLISC+OPLn?=
 =?us-ascii?Q?9lYi1Z/CYMxH7mfSbr/QA1XEFu05Y14YucepvdXAYliXE449OsSFOuB9EOyc?=
 =?us-ascii?Q?DEFXfvPQkRf6VgmzHUu+ciDJip49zmgU5msKGOmTj7ejTry1wydIFDC5mDVW?=
 =?us-ascii?Q?xPGgWDRMVoF4DTowBHP8KEhzXnRyod21cS7l363BBZPrYCJx/A0afl6xpy22?=
 =?us-ascii?Q?yRWCFUE3hj47cUHM0mVajlQGrVzi7EfxqLDIwU7h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a3867e-d009-4061-5f06-08dda0a48371
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 00:37:42.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfG0ZEhR5HJufNrrkpWu4PywYkDn659hZl3mikH98Q6cfBDDmQ0mZQ0P+lY5mI6161cDHZFen1dYXMkd+7xsgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com

Ackerley Tng wrote:
> Refactor out hugetlb_alloc_folio() from alloc_hugetlb_folio(), which
> handles allocation of a folio and cgroup charging.
> 
> Other than flags to control charging in the allocation process,
> hugetlb_alloc_folio() also has parameters for memory policy.
> 
> This refactoring as a whole decouples the hugetlb page allocation from
> hugetlbfs, (1) where the subpool is stored at the fs mount, (2)
> reservations are made during mmap and stored in the vma, and (3) mpol
> must be stored at vma->vm_policy (4) a vma must be used for allocation
> even if the pages are not meant to be used by host process.
> 
> This decoupling will allow hugetlb_alloc_folio() to be used by
> guest_memfd in later patches. In guest_memfd, (1) a subpool is created
> per-fd and is stored on the inode, (2) no vma-related reservations are
> used (3) mpol may not be associated with a vma since (4) for private
> pages, the pages will not be mappable to userspace and hence have to
> associated vmas.
> 
> This could hopefully also open hugetlb up as a more generic source of
> hugetlb pages that are not bound to hugetlbfs, with the complexities
> of userspace/mmap/vma-related reservations contained just to
> hugetlbfs.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Change-Id: I60528f246341268acbf0ed5de7752ae2cacbef93
> ---
>  include/linux/hugetlb.h |  12 +++
>  mm/hugetlb.c            | 192 ++++++++++++++++++++++------------------
>  2 files changed, 118 insertions(+), 86 deletions(-)
> 

[snip]

>  
> +/**
> + * hugetlb_alloc_folio() - Allocates a hugetlb folio.
> + *
> + * @h: struct hstate to allocate from.
> + * @mpol: struct mempolicy to apply for this folio allocation.
> + * @ilx: Interleave index for interpretation of @mpol.
> + * @charge_cgroup_rsvd: Set to true to charge cgroup reservation.
> + * @use_existing_reservation: Set to true if this allocation should use an
> + *                            existing hstate reservation.
> + *
> + * This function handles cgroup and global hstate reservations. VMA-related
> + * reservations and subpool debiting must be handled by the caller if necessary.
> + *
> + * Return: folio on success or negated error otherwise.
> + */
> +struct folio *hugetlb_alloc_folio(struct hstate *h, struct mempolicy *mpol,
> +				  pgoff_t ilx, bool charge_cgroup_rsvd,
> +				  bool use_existing_reservation)
> +{
> +	unsigned int nr_pages = pages_per_huge_page(h);
> +	struct hugetlb_cgroup *h_cg = NULL;
> +	struct folio *folio = NULL;
> +	nodemask_t *nodemask;
> +	gfp_t gfp_mask;
> +	int nid;
> +	int idx;
> +	int ret;
> +
> +	idx = hstate_index(h);
> +
> +	if (charge_cgroup_rsvd) {
> +		if (hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, &h_cg))
> +			goto out;

Why not just return here?
			return ERR_PTR(-ENOSPC);

> +	}
> +
> +	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, &h_cg))
> +		goto out_uncharge_cgroup_reservation;
> +
> +	gfp_mask = htlb_alloc_mask(h);
> +	nid = policy_node_nodemask(mpol, gfp_mask, ilx, &nodemask);
> +
> +	spin_lock_irq(&hugetlb_lock);
> +
> +	if (use_existing_reservation || available_huge_pages(h))
> +		folio = dequeue_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
> +
> +	if (!folio) {
> +		spin_unlock_irq(&hugetlb_lock);
> +		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
> +		if (!folio)
> +			goto out_uncharge_cgroup;
> +		spin_lock_irq(&hugetlb_lock);
> +		list_add(&folio->lru, &h->hugepage_activelist);
> +		folio_ref_unfreeze(folio, 1);
> +		/* Fall through */
> +	}
> +
> +	if (use_existing_reservation) {
> +		folio_set_hugetlb_restore_reserve(folio);
> +		h->resv_huge_pages--;
> +	}
> +
> +	hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio);
> +
> +	if (charge_cgroup_rsvd)
> +		hugetlb_cgroup_commit_charge_rsvd(idx, nr_pages, h_cg, folio);
> +
> +	spin_unlock_irq(&hugetlb_lock);
> +
> +	gfp_mask = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> +	ret = mem_cgroup_charge_hugetlb(folio, gfp_mask);
> +	/*
> +	 * Unconditionally increment NR_HUGETLB here. If it turns out that
> +	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
> +	 * decrement NR_HUGETLB.
> +	 */
> +	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
> +
> +	if (ret == -ENOMEM) {
> +		free_huge_folio(folio);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return folio;
> +
> +out_uncharge_cgroup:
> +	hugetlb_cgroup_uncharge_cgroup(idx, nr_pages, h_cg);
> +out_uncharge_cgroup_reservation:
> +	if (charge_cgroup_rsvd)
> +		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, h_cg);

I find the direct copy of the unwind logic from alloc_hugetlb_folio()
cumbersome and it seems like a good opportunity to clean it up.

> +out:
> +	folio = ERR_PTR(-ENOSPC);
> +	goto out;

Endless loop?

Ira

[snip]

