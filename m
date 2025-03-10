Return-Path: <linux-fsdevel+bounces-43608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42424A59811
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84ED7A3DF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333922AE75;
	Mon, 10 Mar 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7z6GG15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0DA199239;
	Mon, 10 Mar 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618067; cv=fail; b=dMQuWF2oaURih713C1t1TXfzZXLJn24Qjh5gHLXhCP25377yPwteozM+C4PGHCJsaOiFx7tmpWlsm47w969VpE8b/0Q+6IhX7RfWXk40xWme1NFj56PppnabMhr7N50C2KCd6/GQTzBj7ccPvAnWvCNp4QVsn20sFkxvhOqw8m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618067; c=relaxed/simple;
	bh=OKS9Oy2AfAlrQ8xzCuzWOiymOpcqF9puPlrec+6ocmY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Ejhw11rDVo96MJParUGnT13HJwhXXm5GW5XyzDfNND/GIMKjqVwWxmx7K5sp97NMMt/d9+dz7+SYOuKY/8Ck8xSWu5REHG3HxXYatmSQxEALin1lK418obSXTDVJav5SCaUOMsCQE2k6kKzV6LPPSWybh91Et9zwUzq5u3pkZWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7z6GG15; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741618065; x=1773154065;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OKS9Oy2AfAlrQ8xzCuzWOiymOpcqF9puPlrec+6ocmY=;
  b=P7z6GG15/RU0+3a3az2x4HqBuE//xRPZmOQ5K2gQrZ4i1cu6tAhADQdx
   l2MYf8N4IQUA5w/w2aKFf+X2CDqpCcTmnQm3jKleMhfZ5m5N6XUbQDSPD
   bZs/hzWGQ2c4RbgJM/StReutWxL4Fp6LTmCvVagXa38rQiOiHJEpkw8Nk
   vxJAZnnsvnSjsWOSWag9nGP/sbjmwTxLjjW9FU9XOJTlB74rtooLdTiFI
   B1qNq95+FSIK7zu7nV8lOdu0A6G71x2lsJc6c0HBhulQdROJy6Dqa7C5h
   Ojn4b627AIu8AtLpJ5XX9v+1zsGOPcealx9gLJTTP5ItpyFSoqi3zqvOx
   w==;
X-CSE-ConnectionGUID: olkKhuruTOa6Gezoldw6rg==
X-CSE-MsgGUID: HP1e28c+RyGJ92SKkCfnAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41864367"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="41864367"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:47:44 -0700
X-CSE-ConnectionGUID: bJCS7hHRTVW0j4fdwRA2dw==
X-CSE-MsgGUID: +snxwknqS4OPBmJtIc/tUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119998740"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:47:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 07:47:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 07:47:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 07:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iohNQvkXjtC+EMT4NSjJ8xwM9NeKkxK2OsIZDAcXXSDTFCWHmnfeFkGVI2r42tK/ry/8nno7Sbby02mxR+D2Gw1VsKF9UU6oPQOz19EoSKx8JOqZMccK7yyKPdwPp9NeFlcTSVzgyh+djOOxhlQsoCb8WVN8mk+LHeAfkBZihdOJUci0UNtxM+0AJuPGm18tGGAsmSd6SRV5xIalq/Iy3xazgzWEljLMUAczEhFrkJv4aV9fS4+R2BSISV3ntrrX1FgcTF07R79dkDn8Q4B8yQ0k41gAFS87mmp0kd1adWqm/fDxMIW0OBpe3i7WlPb3UKFZ55LW4YW79ZjIqQHNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAVTgntgGoHHfw8OzpDCUJ04SaACk2D2FFA9GiUUa88=;
 b=P04VOjcfr6Ek0ncH2H1wcD1+a7c60GyhSKfm0ScBdZxHyVkfttyUeCQRiV+7LcQO5aZdBe4EwmOssHAjKk3dZUrjgp8N5A842vFMz38REHLdFxFazaUWV7yS3DT4UmfpmK5pDMyPTLU57CHENzQJEMTIjGHe+XiEIyyhdwy2gYjQzCSclGRNi9FsLXuEhoHSaYS76Ec/d5v5nbGLODzvQyzHPTlihsJIRNxHalQbtHW/VBdk0WiARY/wz26Yscza4oILfmHhQWic7Buf4lECapPrIlrdX13ENBjYtR89UDntkwak6gbBx9Zej6gJ+UdBQxEsGxZlwhvDy2R/MZ2qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5909.namprd11.prod.outlook.com (2603:10b6:303:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:47:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:47:39 +0000
Date: Mon, 10 Mar 2025 22:47:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alistair Popple <apopple@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Asahi Lina <lina@asahilina.net>, Balbir Singh
	<balbirs@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>, Chunyan Zhang <zhang.lyra@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@redhat.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Jan Kara
	<jack@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, linmiaohe
	<linmiaohe@huawei.com>, Logan Gunthorpe <logang@deltatee.com>, Matthew Wilcow
	<willy@infradead.org>, Michael Camp Drill Sergeant Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Peter Xu
	<peterx@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, Ted Ts'o
	<tytso@mit.edu>, Vasily Gorbik <gor@linux.ibm.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Vivek Goyal <vgoyal@redhat.com>, WANG Xuerui
	<kernel@xen0n.name>, Will Deacon <will@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-xfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs/dax]  1a785b76b0: xfstests.generic.462.fail
Message-ID: <202503102208.26319ad6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 705b02d3-0ec7-4f70-f788-08dd5fe28187
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7L45hzPR7H4cPzOyaJG5dysi1SGlp+KG5rbls3RjdOX9CMHIRsMCowh2k6rR?=
 =?us-ascii?Q?pnQVCuQfZZG+Ny06rd5mcEyTDX6Co19eHQFp/4S+vruEsg/RWAWjtbcpvv1i?=
 =?us-ascii?Q?QGXAlcOj+nLF8mViznGxG6Mw7LMpdt250vg5CZx730ZBXAYNBAtQoGODEH7Y?=
 =?us-ascii?Q?zEVfPTBOBLoxA/dxuDKQ77qrUsCKxS+J5jLwJmMlZyJeg0BZjbY/HCUit/hq?=
 =?us-ascii?Q?EC7usf9uDyipT9hkAlT0cAifafD4hzYrTWpJ7uJfa6uDddqaiGsye+ZpEZ5s?=
 =?us-ascii?Q?LOiiOZEf7Yzj9Cob677pVKtlofDLhA6Dauw9nJGpOjDQmS6OzTw25sEYymZS?=
 =?us-ascii?Q?Q6sI9P0T/YWOBTPmnIIuy67P0avzXB1ffa1EgPVUe6X91k8oT0OVdJ1uInBt?=
 =?us-ascii?Q?AqYUDCHSKBhErfGTwkh+gnRGQnyaweQsMKK/xj5DYJJJDru/PBfUYP8vonOQ?=
 =?us-ascii?Q?woyx8s8/Ztcd9mwXFZtxDpIys7GLsStAxvWsJrWTX8wh7WA3xSbB+qScsAVV?=
 =?us-ascii?Q?AKEhoD/Pf1AY8v79Q7np9FhkxsGOkzXCSYq1OKop4LNhHEDNwJR4abZdxO/F?=
 =?us-ascii?Q?Q7aYhc9TQU1OSRAmccjPdKz0l4U+nVvCWUdu1EZGgxFjCQGXIWXxYnvrMLIt?=
 =?us-ascii?Q?bBfTu5Ndtrs+hftZhry88wKlSa7aEHCwqYSp4/uQz+f3di116gcjK+iwmkyr?=
 =?us-ascii?Q?3qs24LUL8VTBa0ayKfLtNzzgzOe4M0h7Gzfx34yq70EAwY9QwuNDeI7JjyF6?=
 =?us-ascii?Q?+dB76fp9tPSqudeEP7h0oDFWegWZ4gOQTxkyQJ4V8HlIAj8v8E2RJAPZNw47?=
 =?us-ascii?Q?Ad2qmJJu9EpKOQNXjvNL2ih1ObJJUDR8WhWu/e9IqZKQbPcy1iJ1LRWj2MZl?=
 =?us-ascii?Q?0qy4yhYTm0M0tyoAHIgbqtuX/JE3P4c88qCD4iOnNjDCM0ZEUAsPFarZOCdQ?=
 =?us-ascii?Q?1sn0AlpV40Sns+6gF+fOgMSpmtEMJqno12IoNHlyxE9jwzH55aCTKzvr8+vC?=
 =?us-ascii?Q?ovGenuKtz5h/hTEZznLBzVytucIORh8/QWNKZuMHgoEGrhqZX9++c5BKZgnh?=
 =?us-ascii?Q?XxSgYxoTsjP+ksI7eIVJipc768TtShd9QP2wsOP2bFjZfuJKONxtXm9MToYm?=
 =?us-ascii?Q?5XUd3H7x4J2iAMOW65cCvDILnGY6YMpvW/u1W1t7Gj0LpFVgqJUZ/fDwtQnq?=
 =?us-ascii?Q?w7spLdYaolgJTg1InmBKjj8Xr2YTl5edw32J9ItNbqLK2fMex+uAHlU1bxJR?=
 =?us-ascii?Q?QgUN9yLrzJrsJbQtzCiuLvl3Q8iByGIclJNSzC2PjbUwwENZVQRxzg+hFsvb?=
 =?us-ascii?Q?43aJEQwTbqCK1LS47TDdOxxuBFjG0Obn/5Y9Hl77DV38oA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cNH/gsaeoUlmlw5QADVrfkFnuuFcsfn94nzfiMlcxstVeDZ3uIVqQdA/ZYd?=
 =?us-ascii?Q?JOf1so8RL+8H8YiJV9CIZEqIiuV44mnFcRjXySF2WCbGEMj2u/U7Qtf85+t1?=
 =?us-ascii?Q?85TznpZy2wJ5iRH/howRLeCLWgElLJMO6qAlVnANptLZgWkZywcHd07vr/8U?=
 =?us-ascii?Q?noXINIMAlXFKCeiMmk47wOjkI9xHKo75nX+pZmIQnnX2qDjZxkRVWX8pjb0O?=
 =?us-ascii?Q?9a8b3hDnPjY7gIaY3C0kCm2Ath21m5pkXmi/+iTTSP4HD7PalwZvPN6ij94Z?=
 =?us-ascii?Q?qXRhPKytqqImjRCmdmw0WdYfsxDxIEmnsAnQ7ON5oUdxzXGiVxePYoDLKcm5?=
 =?us-ascii?Q?XV9uGDVVUBFtlmZWDZ+snMe4JY5prqnVbc5k1uP25HVk+y9btIA6/aAmyUGP?=
 =?us-ascii?Q?qmvGnKBWSlEZwKzG9WKzlUJlAODnOjrFjD2XnLJAFO+uvmO0/9W7dakRFKB2?=
 =?us-ascii?Q?Yb8iMsfIIoo3bXQq325ZLRzrengGidO9fOi+jq5jXEgmlobWW8t6KigDLe5i?=
 =?us-ascii?Q?2z/nFIIjA+ix7X9N5QRYr8l0cwsoW/DJvSsJc8On7SsQZvBUT64shyEBj1Mi?=
 =?us-ascii?Q?cXp1Z7Xyho4/+shIYioKhSjDJSpyG3INZacUSq1xDPW2v3P24MSv0gBe1cDd?=
 =?us-ascii?Q?214J+Py6rUrh8AsUWex35opLej9DuTNNcAdsne1cxCbdieXFR9c59IFtduoI?=
 =?us-ascii?Q?kIQSMcq+fiwYDZqNSYfJPS+sENpcTbecipuncFej9Eu421QGDEzxr5onOf0E?=
 =?us-ascii?Q?r15AwylihbYr0LLFc/s0TEDE6L8OrTNS2lxsgomYZvF1MnWT/JeZTwuplzhS?=
 =?us-ascii?Q?fvs7OSVslZJTpQg0cAwcVudMH2KxCUH+y3GwN4BOer/SLdjnD1BLPXJy5Pnh?=
 =?us-ascii?Q?McRBpl0wT+5HmnKzTBo0hMQTTh1Lt5nqEBQKAk4FMlkUqey6fIwVtPlki7/+?=
 =?us-ascii?Q?+nHRVIq1+ALK3x2Z98QfX3atCQWBr4JgUWQhXLGAFF9K8lVG3+4qfxNQJobI?=
 =?us-ascii?Q?ehy5YRQycHtfVZ33iJif10VaMLH6UlKr7pPPE/9wdJlLT5N7wLaTJPZmqgIG?=
 =?us-ascii?Q?IQFLZeO5AgMWQyr4TlgqU1/XINAVtAkrv8X5n9tduDAtE5QqNUsf54Rntiyi?=
 =?us-ascii?Q?XUwUyCCLM98dP5Iz3dLK6V1kbllOtuBzCLn3uEO/CXBfUtm8eXV/3nHfCAqL?=
 =?us-ascii?Q?g3z135d0+j3/MJpDE3gjB+0eR3NJJTomJl/Ig2Y4wczFzGuhafMGk3vhKuZ8?=
 =?us-ascii?Q?VLBeEfHk26ic11UCWB598wH+/wAJ4cORR0lPLuK3kp/Ljb5xSM9CyefbtSEB?=
 =?us-ascii?Q?W7LqbA6Eth9ZeD58zVfnluTIjsF1xz3oZFcEAJ5gCpwXeJ3gn0Pz6crn7y70?=
 =?us-ascii?Q?eFZkOYW9bQ2bosnLlKNq5Y2INRRygo2sLRSwoxAG7TewotoZkogUa4YXEtJi?=
 =?us-ascii?Q?ROQ+W8NXDUnMwZDP98YFawsN3ALgr9z/55QduWgl+NgakYrAWXiieDRf9pr9?=
 =?us-ascii?Q?m4jpIKKQe3WYnc/dzcI8rajGAq3wKkKItygI1EsgSL4lupwDlvFa+t6jv2rc?=
 =?us-ascii?Q?rbq+G2bUvQKOTWvydMi1hHvSjLE9OeY6LJVzuTG57ewTrDqjJ8hqlM2Zvdx/?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 705b02d3-0ec7-4f70-f788-08dd5fe28187
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:47:39.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khzOejwLGkoINFKN0QoDzWwazG2CGZfhND0bEB9ZzBgktDLm7VQPSxP3o98H17+N0lvFDZnS7cV6y1wIzW2GNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5909
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.462.fail" on:

commit: 1a785b76b0b0203a6284d25cf9064c65d444c4ee ("fs/dax: always remove DAX page-cache entries when breaking layouts")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	bp1_memmap: 4G!8G
	bp2_memmap: 4G!10G
	bp3_memmap: 4G!16G
	bp4_memmap: 4G!22G
	nr_pmem: 4
	fs: ext2
	test: generic-462



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503102208.26319ad6-lkp@intel.com

2025-03-09 04:19:23 export TEST_DIR=/fs/pmem0
2025-03-09 04:19:23 export TEST_DEV=/dev/pmem0
2025-03-09 04:19:23 export FSTYP=ext2
2025-03-09 04:19:23 export SCRATCH_MNT=/fs/scratch
2025-03-09 04:19:23 mkdir /fs/scratch -p
2025-03-09 04:19:23 export SCRATCH_DEV=/dev/pmem3
2025-03-09 04:19:23 echo generic/462
2025-03-09 04:19:23 ./check -E tests/exclude/ext2 generic/462
FSTYP         -- ext2
PLATFORM      -- Linux/x86_64 lkp-skl-d01 6.14.0-rc3-00217-g1a785b76b0b0 #1 SMP PREEMPT_DYNAMIC Sun Mar  9 11:52:02 CST 2025
MKFS_OPTIONS  -- -F /dev/pmem3
MOUNT_OPTIONS -- -o acl,user_xattr /dev/pmem3 /fs/scratch

generic/462       _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/462.dmesg)

Ran: generic/462
Failures: generic/462
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503102208.26319ad6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


