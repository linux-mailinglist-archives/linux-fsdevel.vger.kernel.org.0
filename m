Return-Path: <linux-fsdevel+bounces-37399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769379F1BFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 02:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8284C16589C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 01:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BA617BB6;
	Sat, 14 Dec 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSK6CCbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3E12E5D;
	Sat, 14 Dec 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140428; cv=fail; b=reQZo2LNaaMw4mvEmGBGaFtknT5rSq03aLOQjNPyojybopB1uUCjTftxpM2Csc8t3KVjDJRegroZym8h+no7TvX0/LXempQ5T0nFTJZAAPRywmZSbeoBK1KWEQinOUtvZGrpVySDsWHfWZGRGmBWG+unaIbA+Hd13+16ujnWhcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140428; c=relaxed/simple;
	bh=ppIkqj4Zkp78bKTvw2F0rlfW4619DyLKaw1j+ODci5s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FmMc1gorw3vYR4/Mx2yOkul4weu/BPZUhdI2GX/GTPaspK8JUjl5un1HY8vGNiJqhJNB7bk0aj2f7bjDWHr8gOq3W4BctNz040wd7mEO8SG0oVjp9zkLiB5N6Z6Et2osGpsnjZNPNVu/mFiPyWTVdxHi7imm2LRpaFf4RRDcbTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSK6CCbG; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734140426; x=1765676426;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ppIkqj4Zkp78bKTvw2F0rlfW4619DyLKaw1j+ODci5s=;
  b=LSK6CCbG86gnQjf1K4ho6zDXv3rUJKhKlwNJfuzSKRlWQwJ6CU0D+ZYQ
   MG/BnSuRGlky/VKGCFRo1ORxKw1JoydjlvfhVCXZ4tT35859wq2TTmR6g
   hvx1vUuYJfQN7VT3Ye6t0gFSMHgaASrIUcPTAgSFqKskXLpHbsqHwT8VT
   f8JOB+xUT/nOguaC9ip0JpDIJOrtRqSc/QK9imUrOy6H25ZObfCeoC35l
   dvo0FYQMME+Py/oNgY/9UCESDg1b1q6aiH5Jn+WyD/H20a4fsMOF2ygzQ
   aoYZt0b4mD6+733T5RP4QyOrZyOL4M6TY+sZhvpGZy706vCMsDsSpCCgO
   A==;
X-CSE-ConnectionGUID: EUv4rMk+RTulnWlUX7hSCQ==
X-CSE-MsgGUID: 6o6/RCNSSMurt8Pl6VKjdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="33909075"
X-IronPort-AV: E=Sophos;i="6.12,233,1728975600"; 
   d="scan'208";a="33909075"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 17:40:25 -0800
X-CSE-ConnectionGUID: pkpu753ISh6WBtWgxbmt6w==
X-CSE-MsgGUID: vtHqTsqlR5iBYJbCOm7CxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97480408"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 17:40:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 17:40:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 17:40:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 17:40:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQcNtFSQkHlBrSoBQVBhKA9cfURjNJHfm7r9BtRv57zRO8XNqLq16T+drJLSZg8e7bcdBDyawZjuCmy5SW0OuguvOuEkpVpQoNU5LbZlERNieq65DHnidjTRAtresytz4lYHeqHad920+XAM0cznYLlk5cLx8h1+3+jnVec4mTuM1xigASQQiI9zIREAdYXbW/qZrSxcFlr7kZ0lhAFMvV+u6OFPC7+DPyXrw4hy26VKUruaVUsiD7HSmQyeQ277tolJqbln6fOLFnuRoxY1smNYPSy2LZYp//tT9HbNDY/PMIH7PkxtDXe2toY5BUUPUg1siRjVxeIcrybLUnu3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEU6DxsZtnGG0dTembF9SUhTjIbhwhtiQZ9LnIX5+OI=;
 b=Z8hFjy5dSWkgtavRthb22iEga4IEAPNqTKev52V7h+TVLWhdmkRRzqmX5I073Jp3JHmo2Vmimgh0i1Oye1+liPMdp8I/bdPJRXPKiYXD5DhnGlgyD7DK0c59wCJL2ghN7tpjZpvjggHINbBpG44P2otPXo2ijBoWnMeBHCOFjj6Y/LD5buy7OhpmFRPY8T3WPcMlsF2WYuXJd7aw2G5QMUN/evx8pTs+38FMpb/oBW+UxEBTR+ut5JOR8BuasXEntQNjeEu3IiukEBDUlATQnFMk4Dxxls1UBbLHTlOeBvpSbgvhTpLa5ihF+UihfRqCd8hs93zMmq83K2SUSQnCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Sat, 14 Dec
 2024 01:39:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 01:39:54 +0000
Date: Fri, 13 Dec 2024 17:39:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <lina@asahilina.net>,
	<zhang.lyra@gmail.com>, <gerald.schaefer@linux.ibm.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<david@fromorbit.com>, <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Message-ID: <675ce1e5a3d68_fad0294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 3041327b-00e4-4fe2-67aa-08dd1be03561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TK73NVZwSoF33rO6nKPBXmFH+r70xfVTQoB/oj7gNSvPkx8ckdNKHfDGhX5E?=
 =?us-ascii?Q?HabjxgkamSaHOy0qQPQh9IKYhbVctbLYCxMdjjzo6IhRTOW363okeS5BfSLP?=
 =?us-ascii?Q?HXXlFbOW/F9jKB7xbZOQ1xduoQduZoGSGekSfA4ASEKuI+UYKQmh4xbCBM8b?=
 =?us-ascii?Q?BZ3oEcheM+cKp1sre+Y8kdrFhdQeOxqgJCNLsBi1Lhj5x0hFQhqDpaphQ1xv?=
 =?us-ascii?Q?B8I7gNBMh67A5b8mLd206su4V570dF6Gv3vuZKv557J+eHpROSDHJFbrmJAh?=
 =?us-ascii?Q?sUrOQWZxP0C6RNTY8Yo5F6QGQubxUuDzXOsl2XXvtk+CwAOkAbsvFwfhTrFo?=
 =?us-ascii?Q?ISM/TUxq6uh4DXmrdbKK0EzKxSQGZB3aP/G+qLqG+YvFdOP2X3i8cbwil6yo?=
 =?us-ascii?Q?WR7lAe3wEzMRhLXydLieLiudpiQyGwaoPk7pt0FSpWp3nO/Z5PkbIQJrDJdn?=
 =?us-ascii?Q?r6OZyFz//Pmkvj8x7uvfn7si5vkq3VZfep/SFMukNbfV9OTeg+tAKbAV5Rnc?=
 =?us-ascii?Q?KcrI1jUVYCPWAd3tQ/ETfP3WyvMYFzWMdlIjDUTufVooA4dXvYLr3321Iikv?=
 =?us-ascii?Q?VY/Jj8gUcu55zhrxE0dPzd2nWIGeg77tQ/NsuK2q3JnrHo6mBnqtDr9MJFjE?=
 =?us-ascii?Q?DHkB8mrhkXPmYeCbiB8oWf69jzUxtos9SUor+IX1XtmIVdbwlSCZhtNMwoJd?=
 =?us-ascii?Q?7uW8/66IisxpORESxtfD8mwEUZx8Ia5U3Mp5vpaKvDJTEDuQD7XkVVli2VjV?=
 =?us-ascii?Q?qlqPW0AwgWFxND1K5Fbq9uRYt34MZZ6QVBXauje3jXLVwpeiIujIvoI0LChl?=
 =?us-ascii?Q?WXi7FvExhSwb5pVkd7IsIGAdQpdtwN1Z0G6ZOJuY6gnYuNdROfaGPKu/+mmc?=
 =?us-ascii?Q?F33iHcjWnzVzrPvS7w4i3VIbAbr5M3LkqdS7lO0ELPpSSz7FUn/LpBVTQVfh?=
 =?us-ascii?Q?4y5hm6tnFwR8A5D9DYG8vwLijlsK1WOscnF5MDeLgCNGr93HW1bATYfyBi/F?=
 =?us-ascii?Q?sSm88TojwLSB2RAJbqT1EYJnn/8b1zX1aA7V6UnNwAtVKRrOQLnIaB6tXTXl?=
 =?us-ascii?Q?U4ltoULKj99of0bH4zH2NZZSCBTQ3InynKmPvreC6WwuyCVU0/wZqKmMV+pB?=
 =?us-ascii?Q?8fwcb/G6JJu3Rju/etCudbFYk8s/fQAQoJp2Ubr2tWxlRUxATwFSqeWE4nbk?=
 =?us-ascii?Q?RtIaL/LzZeS/R55EUnrelEWceV5ckAUHqh2lLK1ASJnx657hXkR0KJxCMou3?=
 =?us-ascii?Q?myprTZISazbNTgW3YXoecuSYI9fF91XRRK/UBpwbG+xTCkbt+xvMz390clU9?=
 =?us-ascii?Q?acTh2tc8I5ca4HSBBI6vP0fJBwDTpQ+kE02lwF7K/Ox0GCufre6Djl7pW+PO?=
 =?us-ascii?Q?PRNT4CCTn/E9y5Y93TZLOlCF9VSd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SJ2DClowv5L5ZyuV8wEu4uoY9w3k2OryblMN/f09IKrsl1MSrWP6Qw7nr8D/?=
 =?us-ascii?Q?TocTplr765RyR8y6NdR987J6HCDBRdK1oNicepdL5ZMY2vIC1TTCsltwHwN0?=
 =?us-ascii?Q?2VjwCItIhT0IQxloAG/T9lRBEpXBjs/IXtwa0WXcLFL7w9nAAzQ8InSuQuN5?=
 =?us-ascii?Q?whCQbID+rnzM++ZSRNXiyAq3C1l9b7Ph+HDNQvXKl6M8r7CkinCFymGpBN13?=
 =?us-ascii?Q?IJbdUtoT7A55CcY+nf9gfrpfZyE5kApYxp63eOPvgclna2AzU8e65PC0PTIC?=
 =?us-ascii?Q?VX/GPBzUaggdCJeO1nQuLOID8Me1Yt3zwIeQYXRlFI959wmSOqmWOwKn/uxU?=
 =?us-ascii?Q?0cmNGa8djowzVzUZ5p+6st/4KdNFXNNlfZVeAN8BVaRBtE/ZW27hb09L6eX4?=
 =?us-ascii?Q?Q7qKT67KZkdreizHYOzWHlvGBnRWlob+uJGlC4fBhwRsopQDF1IkxzfRm8z/?=
 =?us-ascii?Q?pOhPhKTygvdc4OGlXxL2XATny2o6Ud4xcA9xSb6vQXtPsbV1oC9hO5Pjvc+q?=
 =?us-ascii?Q?vLwMsUh3oPlVw9F6c/U4xjm4m00SWI7jpftnZzZuFw7RzzQqXaDKMKmKg3Bb?=
 =?us-ascii?Q?WxpBEdMvCjvj+tfMGjvuSdN9Y4pnqmY9QN0z6Pe+h/vTdbEbl8dTTA0PRPAB?=
 =?us-ascii?Q?lxftGjmzzFy7a33NWEcXLFLxeor0KYU1fToS23y2Ncctj+Rm+7wRO6dfo8Pt?=
 =?us-ascii?Q?AeX1U6kXRwF4eS6yXkzQyDaooBg8jKQufhDOlPlLJo38gf9sKyhiQtNJ8wy8?=
 =?us-ascii?Q?udpM2wbZxZ0bM1yZo9prlA6tLZA98Sc8s3gFrviK5WSLXcOYFAeNcVNzVcOJ?=
 =?us-ascii?Q?k6V8dDLWzQVNFsab6xUm7v4UaD2LoHg9sWYxdfBckGijYKOjtezYT00d91BG?=
 =?us-ascii?Q?MXInRPX5GV2R24Ec7ZtZSGT6fFmHio4O7KvOqNmbj2Ye6g4YNtOBE1G4XxPj?=
 =?us-ascii?Q?Hgwa96hXg5iqiDkshOIgI+XGtuVHYYetlM0vIfyGIvj85Fmqk8eXclcCxzZW?=
 =?us-ascii?Q?aq/IXl/TEWo8vPYiT1PIcXhyrvTzxVHL8vyb+RCMgW3nm9HkoKYACG8C2KRB?=
 =?us-ascii?Q?MoRw+As4bfl5pTzEGqJsP7cS4J29pySup0tvqFDvJ3hNEo8DCP4IA4/hL4Lt?=
 =?us-ascii?Q?Grj5tL+c1Tmq0wlSmmznFSfW6KBcUfTCbQhB5kP16eHEUjKe8yGx4yedu6Vm?=
 =?us-ascii?Q?lc7JlgtzDf7xRZIZPoTHpB1dan7p3mOPpo55UiuJTNmeGT+W5onTJwC4GqCN?=
 =?us-ascii?Q?rYnTFtnnEDNLobHhi6hzAOrZEG2jJIEMQW146hjOKTVawpejxIy/f2H+9jpz?=
 =?us-ascii?Q?hWXryJiNDqLYecdgf2sjOOSVQe9iK1gStFdcY/MG30Wxgja23622TtN8+h5d?=
 =?us-ascii?Q?Zwsot5za7KX4xYSzM0ayOR5iE2MXkDES7JzF6Le0sSi3FRQSnWCMF3pS+iTD?=
 =?us-ascii?Q?o01DXqETz0qlvqKFpS/BNR72Jorl6x7dwJ5supFumweH2gxuEl+PX3ZKoS0N?=
 =?us-ascii?Q?roAyCYH1lY2hn2q1NOc2Ek2NCSpw9RAvX3lkHkhdzjWeQRT5RMk8g2R092Bq?=
 =?us-ascii?Q?709ZyLzwgGr5fTzCcNQPamQsjXsa2czDOlIsbwpu8+Zm66ZlCmGqx4ICzJiu?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3041327b-00e4-4fe2-67aa-08dd1be03561
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 01:39:54.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osZcSL+1rBPyGtVhX28u1GrGkdShfWpIeoTUMewCuAzhdLgcohmQNzNCuiBJtd3pou/XaMBSOdLMQG8Vhi+pTqBtTP2tzKJwVv8S7A9n22c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

[ add akpm and sfr for next steps ]

Alistair Popple wrote:
> Main updates since v2:
> 
>  - Rename the DAX specific dax_insert_XXX functions to vmf_insert_XXX
>    and have them pass the vmf struct.
> 
>  - Seperate out the device DAX changes.
> 
>  - Restore the page share mapping counting and associated warnings.
> 
>  - Rework truncate to require file-systems to have previously called
>    dax_break_layout() to remove the address space mapping for a
>    page. This found several bugs which are fixed by the first half of
>    the series. The motivation for this was initially to allow the FS
>    DAX page-cache mappings to hold a reference on the page.
> 
>    However that turned out to be a dead-end (see the comments on patch
>    21), but it found several bugs and I think overall it is an
>    improvement so I have left it here.
> 
> Device and FS DAX pages have always maintained their own page
> reference counts without following the normal rules for page reference
> counting. In particular pages are considered free when the refcount
> hits one rather than zero and refcounts are not added when mapping the
> page.
> 
> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> mechanism for allowing GUP to hold references on the page (see
> get_dev_pagemap). However there doesn't seem to be any reason why FS
> DAX pages need their own reference counting scheme.
> 
> By treating the refcounts on these pages the same way as normal pages
> we can remove a lot of special checks. In particular pXd_trans_huge()
> becomes the same as pXd_leaf(), although I haven't made that change
> here. It also frees up a valuable SW define PTE bit on architectures
> that have devmap PTE bits defined.
> 
> It also almost certainly allows further clean-up of the devmap managed
> functions, but I have left that as a future improvment. It also
> enables support for compound ZONE_DEVICE pages which is one of my
> primary motivators for doing this work.

So this is feeling ready for -next exposure, and ideally merged for v6.14. I
see the comments from John and Bjorn and that you were going to respin for
that, but if it's just those details things they can probably be handled
incrementally.

Alistair, are you ready for this to hit -next?

As for which tree...

Andrew, we could take this through -mm, but my first instinct would be to try
to take it through nvdimm.git mainly to offload any conflict wrangling work and
small fixups which are likely to be an ongoing trickle.

However, I am not going to put up much of a fight if others prefer this go
through -mm.

Thoughts?

Here is the current conflict diff vs -next:


commit 2f678b756ddf2c4a0fad7819442c09d3c8b52e4e
Merge: 4176cf5c5651 0f26a45ef326
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri Dec 13 17:37:32 2024 -0800

    Merge branch 'for-6.14/dax' into for-6.14/dax-next
    
    Fixup conflicts with pte_devmap removal and other misc conflicts.

diff --cc arch/arm64/Kconfig
index 39310a484d2d,1d90ab98af3c..81855d1c822c
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -40,8 -38,6 +40,7 @@@ config ARM6
  	select ARCH_HAS_MEM_ENCRYPT
  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 +	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
- 	select ARCH_HAS_PTE_DEVMAP
  	select ARCH_HAS_PTE_SPECIAL
  	select ARCH_HAS_HW_PTE_YOUNG
  	select ARCH_HAS_SETUP_DMA_OPS
diff --cc arch/riscv/Kconfig
index 7d5718667e39,2475c5b63c34..c285250a8ea8
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@@ -41,9 -39,7 +41,8 @@@ config RISC
  	select ARCH_HAS_MMIOWB
  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
  	select ARCH_HAS_PMEM_API
 +	select ARCH_HAS_PREEMPT_LAZY
  	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
- 	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
  	select ARCH_HAS_PTE_SPECIAL
  	select ARCH_HAS_SET_DIRECT_MAP if MMU
  	select ARCH_HAS_SET_MEMORY if MMU
diff --cc arch/x86/Kconfig
index 77f001c6a567,6a1a06f6a98a..acac373f5097
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@@ -96,8 -93,6 +96,7 @@@ config X8
  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
  	select ARCH_HAS_PMEM_API		if X86_64
 +	select ARCH_HAS_PREEMPT_LAZY
- 	select ARCH_HAS_PTE_DEVMAP		if X86_64
  	select ARCH_HAS_PTE_SPECIAL
  	select ARCH_HAS_HW_PTE_YOUNG
  	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
diff --cc arch/x86/include/asm/pgtable_types.h
index 4b804531b03c,4a13b76b9b97..e4c7b519d962
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@@ -33,15 -33,12 +33,14 @@@
  #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
  #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
- #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
  
  #ifdef CONFIG_X86_64
 -#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
 +#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) */
 +#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW5 /* No PTI shadow (root PGD) */
  #else
  /* Shared with _PAGE_BIT_UFFD_WP which is not supported on 32 bit */
 -#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit */
 +#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit (leaf) */
 +#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW2 /* No PTI shadow (root PGD) */
  #endif
  
  /* If _PAGE_BIT_PRESENT is clear, we use these: */
diff --cc include/linux/rmap.h
index 683a04088f3f,4a811c5e9294..07a99abcaf2f
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@@ -192,10 -192,11 +192,11 @@@ typedef int __bitwise rmap_t
  enum rmap_level {
  	RMAP_LEVEL_PTE = 0,
  	RMAP_LEVEL_PMD,
+ 	RMAP_LEVEL_PUD,
  };
  
 -static inline void __folio_rmap_sanity_checks(struct folio *folio,
 -		struct page *page, int nr_pages, enum rmap_level level)
 +static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 +		const struct page *page, int nr_pages, enum rmap_level level)
  {
  	/* hugetlb folios are handled separately. */
  	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
diff --cc mm/internal.h
index 39227887e47b,50ff42f7b783..c4df0ad37423
--- a/mm/internal.h
+++ b/mm/internal.h
@@@ -733,9 -687,8 +733,7 @@@ static inline void prep_compound_tail(s
  	set_page_private(p, 0);
  }
  
- extern void prep_compound_page(struct page *page, unsigned int order);
- 
 -extern void post_alloc_hook(struct page *page, unsigned int order,
 -					gfp_t gfp_flags);
 +void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
  extern bool free_pages_prepare(struct page *page, unsigned int order);
  
  extern int user_min_free_kbytes;
diff --cc mm/madvise.c
index 49f3a75046f6,ff139e57cca2..1f4c99ee5c82
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@@ -1030,214 -1017,6 +1030,214 @@@ static long madvise_remove(struct vm_ar
  	return error;
  }
  
 +static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
 +{
 +	vm_flags_t disallowed = VM_SPECIAL | VM_HUGETLB;
 +
 +	/*
 +	 * A user could lock after setting a guard range but that's fine, as
 +	 * they'd not be able to fault in. The issue arises when we try to zap
 +	 * existing locked VMAs. We don't want to do that.
 +	 */
 +	if (!allow_locked)
 +		disallowed |= VM_LOCKED;
 +
 +	if (!vma_is_anonymous(vma))
 +		return false;
 +
 +	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
 +		return false;
 +
 +	return true;
 +}
 +
 +static bool is_guard_pte_marker(pte_t ptent)
 +{
 +	return is_pte_marker(ptent) &&
 +		is_guard_swp_entry(pte_to_swp_entry(ptent));
 +}
 +
 +static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
 +				   unsigned long next, struct mm_walk *walk)
 +{
 +	pud_t pudval = pudp_get(pud);
 +
 +	/* If huge return >0 so we abort the operation + zap. */
- 	return pud_trans_huge(pudval) || pud_devmap(pudval);
++	return pud_trans_huge(pudval);
 +}
 +
 +static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
 +				   unsigned long next, struct mm_walk *walk)
 +{
 +	pmd_t pmdval = pmdp_get(pmd);
 +
 +	/* If huge return >0 so we abort the operation + zap. */
- 	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
++	return pmd_trans_huge(pmdval);
 +}
 +
 +static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
 +				   unsigned long next, struct mm_walk *walk)
 +{
 +	pte_t pteval = ptep_get(pte);
 +	unsigned long *nr_pages = (unsigned long *)walk->private;
 +
 +	/* If there is already a guard page marker, we have nothing to do. */
 +	if (is_guard_pte_marker(pteval)) {
 +		(*nr_pages)++;
 +
 +		return 0;
 +	}
 +
 +	/* If populated return >0 so we abort the operation + zap. */
 +	return 1;
 +}
 +
 +static int guard_install_set_pte(unsigned long addr, unsigned long next,
 +				 pte_t *ptep, struct mm_walk *walk)
 +{
 +	unsigned long *nr_pages = (unsigned long *)walk->private;
 +
 +	/* Simply install a PTE marker, this causes segfault on access. */
 +	*ptep = make_pte_marker(PTE_MARKER_GUARD);
 +	(*nr_pages)++;
 +
 +	return 0;
 +}
 +
 +static const struct mm_walk_ops guard_install_walk_ops = {
 +	.pud_entry		= guard_install_pud_entry,
 +	.pmd_entry		= guard_install_pmd_entry,
 +	.pte_entry		= guard_install_pte_entry,
 +	.install_pte		= guard_install_set_pte,
 +	.walk_lock		= PGWALK_RDLOCK,
 +};
 +
 +static long madvise_guard_install(struct vm_area_struct *vma,
 +				 struct vm_area_struct **prev,
 +				 unsigned long start, unsigned long end)
 +{
 +	long err;
 +	int i;
 +
 +	*prev = vma;
 +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
 +		return -EINVAL;
 +
 +	/*
 +	 * If we install guard markers, then the range is no longer
 +	 * empty from a page table perspective and therefore it's
 +	 * appropriate to have an anon_vma.
 +	 *
 +	 * This ensures that on fork, we copy page tables correctly.
 +	 */
 +	err = anon_vma_prepare(vma);
 +	if (err)
 +		return err;
 +
 +	/*
 +	 * Optimistically try to install the guard marker pages first. If any
 +	 * non-guard pages are encountered, give up and zap the range before
 +	 * trying again.
 +	 *
 +	 * We try a few times before giving up and releasing back to userland to
 +	 * loop around, releasing locks in the process to avoid contention. This
 +	 * would only happen if there was a great many racing page faults.
 +	 *
 +	 * In most cases we should simply install the guard markers immediately
 +	 * with no zap or looping.
 +	 */
 +	for (i = 0; i < MAX_MADVISE_GUARD_RETRIES; i++) {
 +		unsigned long nr_pages = 0;
 +
 +		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
 +		err = walk_page_range_mm(vma->vm_mm, start, end,
 +					 &guard_install_walk_ops, &nr_pages);
 +		if (err < 0)
 +			return err;
 +
 +		if (err == 0) {
 +			unsigned long nr_expected_pages = PHYS_PFN(end - start);
 +
 +			VM_WARN_ON(nr_pages != nr_expected_pages);
 +			return 0;
 +		}
 +
 +		/*
 +		 * OK some of the range have non-guard pages mapped, zap
 +		 * them. This leaves existing guard pages in place.
 +		 */
 +		zap_page_range_single(vma, start, end - start, NULL);
 +	}
 +
 +	/*
 +	 * We were unable to install the guard pages due to being raced by page
 +	 * faults. This should not happen ordinarily. We return to userspace and
 +	 * immediately retry, relieving lock contention.
 +	 */
 +	return restart_syscall();
 +}
 +
 +static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
 +				  unsigned long next, struct mm_walk *walk)
 +{
 +	pud_t pudval = pudp_get(pud);
 +
 +	/* If huge, cannot have guard pages present, so no-op - skip. */
- 	if (pud_trans_huge(pudval) || pud_devmap(pudval))
++	if (pud_trans_huge(pudval))
 +		walk->action = ACTION_CONTINUE;
 +
 +	return 0;
 +}
 +
 +static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
 +				  unsigned long next, struct mm_walk *walk)
 +{
 +	pmd_t pmdval = pmdp_get(pmd);
 +
 +	/* If huge, cannot have guard pages present, so no-op - skip. */
- 	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
++	if (pmd_trans_huge(pmdval))
 +		walk->action = ACTION_CONTINUE;
 +
 +	return 0;
 +}
 +
 +static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
 +				  unsigned long next, struct mm_walk *walk)
 +{
 +	pte_t ptent = ptep_get(pte);
 +
 +	if (is_guard_pte_marker(ptent)) {
 +		/* Simply clear the PTE marker. */
 +		pte_clear_not_present_full(walk->mm, addr, pte, false);
 +		update_mmu_cache(walk->vma, addr, pte);
 +	}
 +
 +	return 0;
 +}
 +
 +static const struct mm_walk_ops guard_remove_walk_ops = {
 +	.pud_entry		= guard_remove_pud_entry,
 +	.pmd_entry		= guard_remove_pmd_entry,
 +	.pte_entry		= guard_remove_pte_entry,
 +	.walk_lock		= PGWALK_RDLOCK,
 +};
 +
 +static long madvise_guard_remove(struct vm_area_struct *vma,
 +				 struct vm_area_struct **prev,
 +				 unsigned long start, unsigned long end)
 +{
 +	*prev = vma;
 +	/*
 +	 * We're ok with removing guards in mlock()'d ranges, as this is a
 +	 * non-destructive action.
 +	 */
 +	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
 +		return -EINVAL;
 +
 +	return walk_page_range(vma->vm_mm, start, end,
 +			       &guard_remove_walk_ops, NULL);
 +}
 +
  /*
   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
   * will handle splitting a vm area into separate areas, each area with its own
diff --cc mm/pagewalk.c
index e478777c86e1,576ff14b118f..a85c3319c6d5
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@@ -133,25 -109,18 +133,24 @@@ again
  
  		if (walk->action == ACTION_AGAIN)
  			goto again;
 -
 -		/*
 -		 * Check this here so we only break down trans_huge
 -		 * pages when we _need_ to
 -		 */
 -		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
 -		    walk->action == ACTION_CONTINUE ||
 -		    !(ops->pte_entry))
 +		if (walk->action == ACTION_CONTINUE)
  			continue;
  
 +		if (!has_handler) { /* No handlers for lower page tables. */
 +			if (!has_install)
 +				continue; /* Nothing to do. */
 +			/*
 +			 * We are ONLY installing, so avoid unnecessarily
 +			 * splitting a present huge page.
 +			 */
- 			if (pmd_present(*pmd) &&
- 			    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
++			if (pmd_present(*pmd) && pmd_trans_huge(*pmd))
 +				continue;
 +		}
 +
  		if (walk->vma)
  			split_huge_pmd(walk->vma, pmd, addr);
 +		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
 +			continue; /* Nothing to do. */
  
  		err = walk_pte_range(pmd, addr, next, walk);
  		if (err)
@@@ -200,26 -164,14 +199,25 @@@ static int walk_pud_range(p4d_t *p4d, u
  
  		if (walk->action == ACTION_AGAIN)
  			goto again;
 -
 -		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
 -		    walk->action == ACTION_CONTINUE ||
 -		    !(ops->pmd_entry || ops->pte_entry))
 +		if (walk->action == ACTION_CONTINUE)
  			continue;
  
 +		if (!has_handler) { /* No handlers for lower page tables. */
 +			if (!has_install)
 +				continue; /* Nothing to do. */
 +			/*
 +			 * We are ONLY installing, so avoid unnecessarily
 +			 * splitting a present huge page.
 +			 */
- 			if (pud_present(*pud) &&
- 			    (pud_trans_huge(*pud) || pud_devmap(*pud)))
++			if (pud_present(*pud) && pud_trans_huge(*pud))
 +				continue;
 +		}
 +
  		if (walk->vma)
  			split_huge_pud(walk->vma, pud, addr);
 +		else if (pud_leaf(*pud) || !pud_present(*pud))
 +			continue; /* Nothing to do. */
 +
  		if (pud_none(*pud))
  			goto again;
  
@@@ -868,11 -753,7 +866,11 @@@ struct folio *folio_walk_start(struct f
  		fw->pudp = pudp;
  		fw->pud = pud;
  
 +		/*
 +		 * TODO: FW_MIGRATION support for PUD migration entries
 +		 * once there are relevant users.
 +		 */
- 		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
+ 		if (!pud_present(pud) || pud_special(pud)) {
  			spin_unlock(ptl);
  			goto not_found;
  		} else if (!pud_leaf(pud)) {
diff --cc mm/truncate.c
index 7c304d2f0052,ee2f890dedde..cb29feac4624
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@@ -73,34 -83,51 +73,47 @@@ static void truncate_folio_batch_except
  		if (xa_is_value(fbatch->folios[j]))
  			break;
  
 -	if (j == folio_batch_count(fbatch))
 +	if (j == nr)
  		return;
  
 -	dax = dax_mapping(mapping);
 -	if (!dax) {
 -		spin_lock(&mapping->host->i_lock);
 -		xa_lock_irq(&mapping->i_pages);
 -	}
 -
 -	for (i = j; i < folio_batch_count(fbatch); i++) {
 -		struct folio *folio = fbatch->folios[i];
 -		pgoff_t index = indices[i];
 +	if (dax_mapping(mapping)) {
 +		for (i = j; i < nr; i++) {
- 			if (xa_is_value(fbatch->folios[i]))
++			if (xa_is_value(fbatch->folios[i])) {
++				/*
++			 	* File systems should already have called
++			 	* dax_break_mapping_entry() to remove all DAX entries
++			 	* while holding a lock to prevent establishing new
++			 	* entries. Therefore we shouldn't find any here.
++			 	*/
++				WARN_ON_ONCE(1);
+ 
 -		if (!xa_is_value(folio)) {
 -			fbatch->folios[j++] = folio;
 -			continue;
++				/*
++			 	* Delete the mapping so truncate_pagecache() doesn't
++			 	* loop forever.
++			 	*/
 +				dax_delete_mapping_entry(mapping, indices[i]);
++			}
  		}
 +		goto out;
 +	}
  
 -		if (unlikely(dax)) {
 -			/*
 -			 * File systems should already have called
 -			 * dax_break_mapping_entry() to remove all DAX entries
 -			 * while holding a lock to prevent establishing new
 -			 * entries. Therefore we shouldn't find any here.
 -			 */
 -			WARN_ON_ONCE(1);
 +	xas_set(&xas, indices[j]);
 +	xas_set_update(&xas, workingset_update_node);
  
 -			/*
 -			 * Delete the mapping so truncate_pagecache() doesn't
 -			 * loop forever.
 -			 */
 -			dax_delete_mapping_entry(mapping, index);
 -			continue;
 -		}
 +	spin_lock(&mapping->host->i_lock);
 +	xas_lock_irq(&xas);
  
 -		__clear_shadow_entry(mapping, index, folio);
 +	xas_for_each(&xas, folio, indices[nr-1]) {
 +		if (xa_is_value(folio))
 +			xas_store(&xas, NULL);
  	}
  
 -	if (!dax) {
 -		xa_unlock_irq(&mapping->i_pages);
 -		if (mapping_shrinkable(mapping))
 -			inode_add_lru(mapping->host);
 -		spin_unlock(&mapping->host->i_lock);
 -	}
 -	fbatch->nr = j;
 +	xas_unlock_irq(&xas);
 +	if (mapping_shrinkable(mapping))
 +		inode_add_lru(mapping->host);
 +	spin_unlock(&mapping->host->i_lock);
 +out:
 +	folio_batch_remove_exceptionals(fbatch);
  }
  
  /**
diff --cc mm/vmscan.c
index 78e9360a20aa,34ff5a6635b4..f0c8eac63972
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@@ -3362,12 -3303,9 +3362,12 @@@ static unsigned long get_pte_pfn(pte_t 
  	if (!pte_present(pte) || is_zero_pfn(pfn))
  		return -1;
  
- 	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
+ 	if (WARN_ON_ONCE(pte_special(pte)))
  		return -1;
  
 +	if (!pte_young(pte) && !mm_has_notifiers(vma->vm_mm))
 +		return -1;
 +
  	if (WARN_ON_ONCE(!pfn_valid(pfn)))
  		return -1;
  
@@@ -3387,12 -3321,6 +3387,9 @@@ static unsigned long get_pmd_pfn(pmd_t 
  	if (!pmd_present(pmd) || is_huge_zero_pmd(pmd))
  		return -1;
  
- 	if (WARN_ON_ONCE(pmd_devmap(pmd)))
- 		return -1;
- 
 +	if (!pmd_young(pmd) && !mm_has_notifiers(vma->vm_mm))
 +		return -1;
 +
  	if (WARN_ON_ONCE(!pfn_valid(pfn)))
  		return -1;
  

