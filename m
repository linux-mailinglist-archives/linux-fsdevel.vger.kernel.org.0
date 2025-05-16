Return-Path: <linux-fsdevel+bounces-49220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69AEAB9850
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A12D3A70F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265622FF2D;
	Fri, 16 May 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfnL0r6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5930222585;
	Fri, 16 May 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386349; cv=fail; b=j7yLIIp0Xqjybckf1e3sAL00WTVelYaSGOOBT6PUYv2wN0yiwi5P+dbMsQ5gNtWSF4jPuFGhxwN3Xl9z05L+OShyQX1BewNCgK7ZW5TTvknXMTjwS/W5+ld7tAoh2OduyWgiojzOEJi/ZE297tOvGDUZOARTyM4mdCbzcmMM4I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386349; c=relaxed/simple;
	bh=/nk9XPwecmalyqs3O1xRCPGWx79/kuAl00+QrD96HcY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jymPEMrd9ir1NNgrrWGjWtyUF0czGeg17uWA2FMYZOEWw/+VjZRMwIzLEuXslaId5wtCJhAl7XmXasQK+lv9a2i/QbWYcmXZwG0e4XzuihAaa6WVpYVn8VUVtEIIwa4L8yIAz1xD8BF9v5BasfXa77GoYfqlKt2WiU1TbYOYZwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfnL0r6k; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747386347; x=1778922347;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/nk9XPwecmalyqs3O1xRCPGWx79/kuAl00+QrD96HcY=;
  b=YfnL0r6kf2Ao69SC5dKy4qPXQVIYlb0O7MT1KXPZ6l6EZdnrOkza3WB5
   rzIw/e318SRaZLOOiLaP2eTQ78X3w8WYz4mb7xnErTKD5+WNXHpqJZyMf
   H4S5UXurQW+q3ztMIrz/KSZJ3oYitGA9IfV48XJxoimEp6mfuxa5XwCfy
   Dbv5KXfa2ykotxkmMk7uIcpKDkt0rVfn8sFR/iiCucVm2iiqX/ejmKTE3
   fWEzLHt9syeApqG3PEjrSDX5VG8mpt8kyClecABPV5KLE36sPVUxRBy6C
   6uGGTxgA+Me4vj0g/YKqlWMWt+q5wx6427FXCdEnG3vf6O2ZwlV1dI/8b
   w==;
X-CSE-ConnectionGUID: S1BUWu9lSmy89IpMfaEs5A==
X-CSE-MsgGUID: sIuAB9+5SoSvOJqgYK9QQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60740350"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="60740350"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:05:46 -0700
X-CSE-ConnectionGUID: yTopq+KIQWmnWTe/TGs+9w==
X-CSE-MsgGUID: kvZ2aAQeRFqj/wJs/G9zdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="175769656"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:05:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 02:05:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 02:05:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 02:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fgb1i9ueCmIgXruTVr4YzMeZav2h30+gXBe4n0zPTyXtlVxhdZWBn35n/TcXJ/pUlFd9Ei1i6ssoHXpzgS3/8WqQETyEumnS3Kawv7zoUik6oJY2ercCpKlE0o19mzPzCTgV7NykDltdW87SekhX1NeSNLspjEsPwcRmp7R2iP2zRSV0bU8VHOBVaHc3NnzeIaWs6HCjcphlQGxmC1hmvySDwrAechsE7+OlT1sXk4kbOminFFBVG4krYx6Uig6XWpOF0xAU3Uy5DEhTtIaYF+if7fYalBf2ulDlUISvTIUc8PhGh0WgM8LOf4EeEd0OTOjg6V6NdiWrAVO/qQP4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKVBoe+FVi+kNfeoD60C1PqeuHyWsPsM9qqj9QxONkc=;
 b=jqHq2mpeBanMRQbCYaWmPU4Hgi6hWpNqYUfXZLScYNepKAJL0j+EVa/3zksCExHIoqXeGv+er7a4FoS4eNnCexJS0lUtUVej+qj5c0EJ5lL2NKiO+4VS7zpyuPX/fomqqodrh4LLOlajd+DtA3GBguEXRbCxseadZw4CtyMENHRPfUQy/uLm8puYnHkAkMW+DzULQghfOEt354DJ0a/yXdd6kWHpb0cU1o/sx47QcT0U7AMtSPn9sQXVGufVtZDHMNOJQEcc9Timtdkk7ZTqMONK0AIVW6W7wM6tBAOp91PP4z72Z5bKyw/I1azjB7HA0I8euj/ifWIpkOJCp/AbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 09:05:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 09:05:22 +0000
Date: Fri, 16 May 2025 17:05:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<willy@infradead.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <yi.zhang@huawei.com>, <yi.zhang@huaweicloud.com>,
	<libaokun1@huawei.com>, <yukuai3@huawei.com>, <yangerkun@huawei.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
Message-ID: <202505161418.ec0d753f-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ec6a7c-a5de-4a1c-3782-08dd9458c9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?RGnGEsjLT2pfRjuRiqYsFajz9GzR2SKDrk+L6/MZ27Guyr7L+yh3dlfQRQ?=
 =?iso-8859-1?Q?FiZHxLGHFbCgAtX98xBwZ3cK3dEqtCUoXRez6aNUMYo8Uz8iEMUUXscpMB?=
 =?iso-8859-1?Q?bw5bxVVrzc96qF/0Wl7B9rr+OZhv6rIu2jnzyPzTBD6GwZNgSS8eOlApB4?=
 =?iso-8859-1?Q?CG0rBSq9acOGoyU3EZ8NmxcaGUNqQmKVQq/u73HrI51Hn44xGUyuprV6sB?=
 =?iso-8859-1?Q?CIv25h411hvJkRrCfOrCMt4rZywXJL7AXuuqJE66kRap6m5vS4SppnfySI?=
 =?iso-8859-1?Q?W19dOyjGtbuSeKLLfmx2yt3+mxU70IFbMBAgztqOJMigPwIcQuiaVX2nxm?=
 =?iso-8859-1?Q?vHqATes+ldHkeVAbSH7tL98DB/SMZ9DhkYyXBwyCK/0etPU4nfFbhAJrhj?=
 =?iso-8859-1?Q?qB7TKppDskJ1p1NQOFk1S9FNIq6gzLYyokVARyCvFUTKR04Jc5C7SJhHtk?=
 =?iso-8859-1?Q?F+4PwAUAuk8nnTWPSx1WyMEQNgG4qmfX+ysFq4ArMD9goeDG11ZhdxtIky?=
 =?iso-8859-1?Q?Qu6+pqq80oZ+FBSzkiXvxoUGzeMZAZ29pvzj/lyADf7Fmds7IroU31/h1H?=
 =?iso-8859-1?Q?NsLq2fzVhdfdYYg4FemZS8UpOzX+eHuXVTKJm3TRciNyNbkM8AGklxtVrH?=
 =?iso-8859-1?Q?vBjBxf6XPCI/rYZbFaiuwE4q3TGtUZGiZgkEA1BcpKQ8z4//I8nVzjqhMT?=
 =?iso-8859-1?Q?oLT6+xu9zq16/wX0jjNgcsrgHsHx209NZBkdUnrIHEFmjAJLcs9ZFJr7ZJ?=
 =?iso-8859-1?Q?wZzP4Ctp4yXauLcCk0G+PQc4GvmGaGFp1OjKGCdTXMYrT7WqIiVxS0f14S?=
 =?iso-8859-1?Q?qiDBZoLZtDsArV+WWFRR0d9GcFmW5fihXO6ESmPT7gzeoGkzN8BV96vqAO?=
 =?iso-8859-1?Q?ujFOLlZLWdVSyF8FY1Mm+NV+gtNL0JYDaf2c45ISjqCraDLv124fIaXENz?=
 =?iso-8859-1?Q?Mlsb1dWUQRzg/8i5WmKiETRuVjfDE+vWQYb0y+uzEAK+ZdBFA9v8qeD8A2?=
 =?iso-8859-1?Q?cHkWGmGQ0ZVIPjJ1q5XWSoeGYBH3PNRzLhn+JDgD3UX7tDwP5W90QuS2UV?=
 =?iso-8859-1?Q?uHLnYfoznE3jtAxKPd5GRDTqQ6T39o1Y4Pne8lpnYj/hNtGW5dfqt2NHh4?=
 =?iso-8859-1?Q?QA5adZ7A44P5E/baWtgxLrI2O6Zj1LyZRoU/FrfncoCj00dfMb5TLbph3a?=
 =?iso-8859-1?Q?LonTbrOV5V6NrVQ3ubJt6v8AqVHqVj3RWnMeaoFnGlXE6JcmwTYFxtSKsE?=
 =?iso-8859-1?Q?90XyOMCVptoe77JGpHsHIgngNYl9Okga66dBLxoX42zy+0OEXhjLTrXbnn?=
 =?iso-8859-1?Q?IdgIQuxllIHX7qAc16zL+/62JmkExkExgzUqkxY7pTzJuJ1MiA57X7bFUS?=
 =?iso-8859-1?Q?zD0eWaGhUDCbm2oRxv7NNT5FA8kt6m/eQ42PAXmddKqoPeEHAD4zP3uHKB?=
 =?iso-8859-1?Q?yz+moOaivcv5IBWy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ht+U6+pGHNuXpNi/eS9iZtDvsYVMXTptSAvE1/drjVJWgH7ByJIYvkeTxP?=
 =?iso-8859-1?Q?JlMzie9skZMtKLueg1iPehV4+FksxedbpSNk9ek3CzhE03LNIeQYXWF/SD?=
 =?iso-8859-1?Q?E4iRq6ZRVzv6GG4JOvrvOMP3Dcj+pCFl1+MGTIkBng9+BCr3JUqjDOjWkW?=
 =?iso-8859-1?Q?v6nhWp+8Y3yF1XnK2OLXkjHULJnRoiSX6wC8MBehdpXDuxdJ0g/pkcaDD5?=
 =?iso-8859-1?Q?yQ3t2du9YZbY2AdEWxZ3F65O4WqWbnqZjepxGer+iuPoBA+4CFl9Ph64hY?=
 =?iso-8859-1?Q?2YGMPqu9eRq869zfHZucln/kZjQ1HyV1KkYUvhpXUokZESDzercOe3Yt48?=
 =?iso-8859-1?Q?BIV1ZmkUlm3jip+xPk9z7yz92bwjlDa8FxlnX4LWfnNlglWZMotDpTV+tC?=
 =?iso-8859-1?Q?YzteUB3+Rc130ll1x838gsSB88y41tn6lgmy1xVDNVTboghkiremz0IM0d?=
 =?iso-8859-1?Q?8VDiOlr5qa/1au+JV2hAHvNT1Xe1wqh6bGWjPF5H39VJ7Yo3Xu1uFX82ii?=
 =?iso-8859-1?Q?o8slPjN+OzdSPb/t4ZgqsSRp8OKjX/RRMMy7FSgJQqsrZgt+AHrzVQdT90?=
 =?iso-8859-1?Q?in/VsSVG52w5nA/kmQE9s1OjxRkoc7RU158tg5vBTeuu8PLI4Q/dvRgOmv?=
 =?iso-8859-1?Q?LMxXkBUdLRtxNYP3Hx6UxcpOLzeqsGRzIz4OQAC7EAfWRwS4K0gRT4t3Ib?=
 =?iso-8859-1?Q?9dUSpUuqDkInHFkR6foFy1wk1rot3YCszIVazCHl338Lk0QZbcJDhGM1da?=
 =?iso-8859-1?Q?ScUgjUPVsZZDfWk2OlF4MgRwC4QtkxcJ+FgxgMKcyOhUDbkJqv7E9eFKjr?=
 =?iso-8859-1?Q?nz2Toom5alOP/2LC1kwW9vCL5/5AKB+46TrT09RYFd4J1usStHtBXj6YKx?=
 =?iso-8859-1?Q?MSxmOvSyPF8fXGNo1RxVq7kxrcN+Ni7cddkS5MdvTosN+cVxnZhOiBUo4E?=
 =?iso-8859-1?Q?Eo12ABIPY1BtFIKvTmKsvyREV6ZzniAVCGYgise3jIk2bkSe2/rjnDF3rA?=
 =?iso-8859-1?Q?Y1FC+5KIvRpFgsO6ZZ9oQlUcGwtUDWKkOmwYIoLIYnOdQ7RQLQXf143lAJ?=
 =?iso-8859-1?Q?PKi8KX8w9tICdmYCG8miFUWawHREQ31tlP7vZMk8+3Gu+LiUJB7LJeYOJw?=
 =?iso-8859-1?Q?L01d3fGvzTSkkxS42eUXTRvlEpBsv0wqdzkY47zlP6SJGr8PtDZeCx4SKD?=
 =?iso-8859-1?Q?7uMiG56piSOyg/FEmU2zM+0r+a69hcUk7lV+irPg+XrBbMRc8IMkF4o8li?=
 =?iso-8859-1?Q?P6QILvhhPYUIpYFrCqmOJv1urTncC5M9Cb5sZL31cxaCAFcHdY1nkmoJh7?=
 =?iso-8859-1?Q?3jsEJVlkrdLquP8i4eJGa0esUWzpfqiFgPPjuN2oKQLJCBq5yKXRxKepFU?=
 =?iso-8859-1?Q?VdHZ/1ycM7LkCbFKT92X6TrOypyjAyBzOS7MmNaLHxzrgP9peKrzX8CZ8C?=
 =?iso-8859-1?Q?7PvjWRu7F4S36hgkdQcvpRGlRll2zSuCDEY9YGVFEoP8FuuL608yibXN5T?=
 =?iso-8859-1?Q?lHn/hJzNDYJP5gOlZ9RICEGIhpUZS82IvPsPAcTc8mlSl6nrJBeODUPyDM?=
 =?iso-8859-1?Q?xNSwAPtKwy+miQscRATEef4kZoKbPL91TXCAc1kOSd5qQVrKHrNieyEuHy?=
 =?iso-8859-1?Q?PkkQ49q3BVuaTbDWaYlIhIz2VCiHjsorUy8ec/q2HnQiWHXW0A7WP3hQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ec6a7c-a5de-4a1c-3782-08dd9458c9c0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:05:22.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gg/5paYtsSIA7q8SOWrpho8HrThGJx3cLrRbFbFIHHGvV+VpRANB2z1cB+1+PABOsJGC0JeuQveQpqOrAOFGiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 37.7% improvement of fsmark.files_per_sec on:


commit: 34696dd792d839c46a280c720ab28aab2db1f4bf ("[PATCH v2 8/8] ext4: enable large folio for regular file")
url: https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/ext4-make-ext4_mpage_readpages-support-large-folios/20250512-144942
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/20250512063319.3539411-9-yi.zhang@huaweicloud.com/
patch subject: [PATCH v2 8/8] ext4: enable large folio for regular file

testcase: fsmark
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
parameters:

	iterations: 1x
	nr_threads: 1t
	disk: 1BRD_48G
	fs: ext4
	filesize: 4M
	test_size: 24G
	sync_method: NoSync
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250516/202505161418.ec0d753f-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1BRD_48G/4M/ext4/1x/x86_64-rhel-9.4/1t/debian-12-x86_64-20240206.cgz/NoSync/lkp-csl-2sp3/24G/fsmark

commit: 
  0368e6caf2 ("ext4: make online defragmentation support large folios")
  34696dd792 ("ext4: enable large folio for regular file")

0368e6caf2d6ff21 34696dd792d839c46a280c720ab 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.964e+09 ±  3%     -14.9%  1.671e+09 ±  8%  cpuidle..time
      3825 ± 20%     -24.6%       2884 ± 17%  sched_debug.cpu.avg_idle.min
     69081            -3.2%      66894        fsmark.app_overhead
    529.15           +37.7%     728.75        fsmark.files_per_sec
     70.33 ±  3%     -11.6%      62.17        fsmark.time.percent_of_cpu_this_job_got
      3.50 ± 54%    +109.5%       7.33 ± 21%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.00 ± 14%     +21.0%       4.84 ± 21%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.91 ± 12%     -14.1%       0.78 ±  8%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    691923 ± 25%     -62.0%     263011 ± 18%  proc-vmstat.numa_foreign
  12650103 ±  4%     -35.5%    8153366        proc-vmstat.numa_hit
  12607229 ±  3%     -36.1%    8052736        proc-vmstat.numa_local
    707756 ± 22%     -62.8%     263011 ± 18%  proc-vmstat.numa_miss
    806083 ± 25%     -55.0%     362335 ± 13%  proc-vmstat.numa_other
    231973            -3.4%     224103        proc-vmstat.pgfault
      3.86 ±  2%     +37.3%       5.29 ±  9%  perf-stat.i.MPKI
 1.889e+09           -11.1%  1.679e+09 ±  2%  perf-stat.i.branch-instructions
      3.60 ±  3%      +0.3        3.91 ±  5%  perf-stat.i.branch-miss-rate%
  34677646           +17.9%   40883980 ±  8%  perf-stat.i.cache-misses
      2003 ±  2%     +10.2%       2209 ±  4%  perf-stat.i.context-switches
      1.08           +14.4%       1.24 ±  4%  perf-stat.i.cpi
 9.762e+09           -10.6%  8.728e+09 ±  2%  perf-stat.i.instructions
      0.98            -9.7%       0.89 ±  4%  perf-stat.i.ipc
      7068 ±  3%     +14.7%       8105 ±  6%  perf-stat.i.minor-faults
      7068 ±  3%     +14.7%       8105 ±  6%  perf-stat.i.page-faults
      3.56           +31.5%       4.68 ±  6%  perf-stat.overall.MPKI
      3.67 ±  2%      +0.4        4.06 ±  2%  perf-stat.overall.branch-miss-rate%
      1.04           +10.9%       1.15 ±  2%  perf-stat.overall.cpi
    291.68           -15.5%     246.52 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.96            -9.8%       0.87 ±  2%  perf-stat.overall.ipc
 1.795e+09           -12.0%   1.58e+09        perf-stat.ps.branch-instructions
  65831109            -2.5%   64181687        perf-stat.ps.branch-misses
  32991347           +16.6%   38460099 ±  7%  perf-stat.ps.cache-misses
      1905 ±  2%      +9.0%       2077 ±  4%  perf-stat.ps.context-switches
  9.28e+09           -11.5%  8.215e+09 ±  2%  perf-stat.ps.instructions
      6695 ±  2%     +13.6%       7604 ±  5%  perf-stat.ps.minor-faults
      6696 ±  2%     +13.6%       7604 ±  5%  perf-stat.ps.page-faults
 1.918e+11 ±  2%     -25.3%  1.432e+11 ±  7%  perf-stat.total.instructions
     24.59 ±  5%      -7.7       16.86        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.39 ±  5%      -7.7       16.68        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     30.60            -6.3       24.26        perf-profile.calltrace.cycles-pp.write
     29.63            -6.3       23.36        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     29.39            -6.3       23.12        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     29.60            -6.3       23.34        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     29.50            -6.3       23.24        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.31 ±  3%      -5.1        1.24 ±  6%  perf-profile.calltrace.cycles-pp.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      5.84 ±  3%      -4.7        1.17 ±  6%  perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      5.79 ±  3%      -4.6        1.16 ±  6%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      9.66 ±  5%      -4.0        5.62 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     17.24 ±  5%      -3.7       13.49        perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback
     17.24 ±  5%      -3.7       13.49        perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
     17.24 ±  5%      -3.7       13.50        perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn.process_one_work
     17.24 ±  5%      -3.7       13.50        perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn
     17.24 ±  5%      -3.7       13.49        perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
      4.92 ±  6%      -3.1        1.87 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      2.60 ±  5%      -1.7        0.94 ±  4%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.78 ±  8%      -1.1        0.68 ±  7%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      1.56 ±  8%      -1.1        0.48 ± 44%  perf-profile.calltrace.cycles-pp.mpage_submit_folio.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages
      1.86 ±  7%      -1.0        0.82 ±  6%  perf-profile.calltrace.cycles-pp.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.65 ±  7%      -1.0        0.64 ±  7%  perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio.ext4_da_write_begin
      4.54 ±  5%      -0.9        3.67 ±  3%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      1.93 ±  6%      -0.8        1.08 ± 32%  perf-profile.calltrace.cycles-pp.ext4_finish_bio.ext4_release_io_end.ext4_end_io_end.ext4_do_writepages.ext4_writepages
      1.93 ±  6%      -0.8        1.09 ± 31%  perf-profile.calltrace.cycles-pp.ext4_release_io_end.ext4_end_io_end.ext4_do_writepages.ext4_writepages.do_writepages
      1.42 ±  7%      -0.8        0.58 ±  9%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio
      1.96 ±  6%      -0.8        1.20 ± 26%  perf-profile.calltrace.cycles-pp.ext4_end_io_end.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_single_inode
      1.31 ±  3%      -0.7        0.58 ±  6%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write
      2.04 ±  9%      -0.7        1.35 ±  7%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages.do_writepages
      2.11 ±  9%      -0.6        1.46 ±  7%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_single_inode
      1.84 ±  7%      -0.5        1.30 ±  7%  perf-profile.calltrace.cycles-pp.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.38 ±  8%      -0.2        1.18 ±  7%  perf-profile.calltrace.cycles-pp.folio_alloc_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.62 ±  2%      -0.1        0.56 ±  5%  perf-profile.calltrace.cycles-pp.ext4_es_lookup_extent.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin
      0.40 ± 70%      +0.3        0.67 ±  5%  perf-profile.calltrace.cycles-pp.io_serial_out.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      1.34 ±  9%      +0.6        1.96 ±  4%  perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      0.34 ±103%      +0.8        1.13 ± 25%  perf-profile.calltrace.cycles-pp.get_jiffies_update.tmigr_requires_handle_remote.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      1.84 ± 12%      +0.8        2.62 ± 10%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.35 ±103%      +0.8        1.15 ± 24%  perf-profile.calltrace.cycles-pp.tmigr_requires_handle_remote.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      4.14 ±  8%      +0.9        5.02 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.11 ±  8%      +0.9        5.00 ±  9%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.95 ±  6%      +0.9        2.89 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.brd_insert_page
      2.35 ± 10%      +1.0        3.32 ± 12%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      3.21 ±  9%      +1.0        4.21 ± 10%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.10 ±  6%      +1.0        3.12 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.brd_insert_page.brd_submit_bio
      2.21 ±  5%      +1.1        3.30 ±  3%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.alloc_pages_noprof.brd_insert_page.brd_submit_bio.__submit_bio
      2.26 ±  5%      +1.1        3.37 ±  3%  perf-profile.calltrace.cycles-pp.alloc_pages_noprof.brd_insert_page.brd_submit_bio.__submit_bio.__submit_bio_noacct
      3.70 ± 30%      +1.2        4.90 ±  4%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      4.40 ± 29%      +1.4        5.82 ±  4%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      4.96 ± 32%      +1.4        6.41        perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail
      4.68 ± 30%      +1.5        6.17 ±  4%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.68 ± 30%      +1.5        6.17 ±  4%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      4.68 ± 30%      +1.5        6.17 ±  4%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      4.68 ± 30%      +1.5        6.17 ±  4%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      4.68 ± 30%      +1.5        6.17 ±  4%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      5.04 ± 32%      +1.5        6.54        perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail
      5.06 ± 32%      +1.5        6.59        perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail
      5.07 ± 32%      +1.5        6.60        perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      5.07 ± 32%      +1.5        6.59        perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      5.07 ± 32%      +1.5        6.60        perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      5.07 ± 32%      +1.5        6.60        perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      5.07 ± 32%      +1.5        6.60        perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty
      5.07 ± 32%      +1.5        6.60        perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work
      5.07 ± 32%      +1.5        6.60        perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      5.07 ± 32%      +1.5        6.60        perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      5.07 ± 32%      +1.5        6.60        perf-profile.calltrace.cycles-pp.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      7.23 ±  9%      +1.9        9.10 ±  2%  perf-profile.calltrace.cycles-pp.rep_movs_alternative.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write
      7.48 ±  9%      +1.9        9.39 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      3.78 ±  7%      +2.2        5.96 ±  7%  perf-profile.calltrace.cycles-pp.memcpy_orig.copy_to_brd.brd_submit_bio.__submit_bio.__submit_bio_noacct
      4.02 ±  7%      +2.3        6.28 ±  6%  perf-profile.calltrace.cycles-pp.copy_to_brd.brd_submit_bio.__submit_bio.__submit_bio_noacct.ext4_io_submit
      5.63 ±  8%      +3.2        8.81 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.brd_insert_page.brd_submit_bio.__submit_bio.__submit_bio_noacct
      8.48 ±  7%      +4.4       12.91 ±  3%  perf-profile.calltrace.cycles-pp.brd_insert_page.brd_submit_bio.__submit_bio.__submit_bio_noacct.ext4_io_submit
     17.80 ±  4%      +5.1       22.94        perf-profile.calltrace.cycles-pp.wb_do_writeback.wb_workfn.process_one_work.worker_thread.kthread
     17.80 ±  4%      +5.1       22.94        perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
     17.80 ±  4%      +5.1       22.94        perf-profile.calltrace.cycles-pp.wb_writeback.wb_do_writeback.wb_workfn.process_one_work.worker_thread
     17.72 ±  4%      +5.2       22.93        perf-profile.calltrace.cycles-pp.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
     12.77 ±  5%      +6.6       19.36        perf-profile.calltrace.cycles-pp.brd_submit_bio.__submit_bio.__submit_bio_noacct.ext4_io_submit.ext4_do_writepages
     12.77 ±  5%      +6.6       19.37        perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.ext4_io_submit.ext4_do_writepages.ext4_writepages
     12.77 ±  5%      +6.6       19.37        perf-profile.calltrace.cycles-pp.__submit_bio_noacct.ext4_io_submit.ext4_do_writepages.ext4_writepages.do_writepages
     12.77 ±  5%      +6.6       19.37        perf-profile.calltrace.cycles-pp.ext4_io_submit.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_single_inode
     23.05 ±  4%      +6.7       29.71        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     22.96 ±  4%      +6.7       29.61        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     23.05 ±  4%      +6.7       29.71        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     23.05 ±  4%      +6.7       29.71        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     22.98 ±  4%      +6.7       29.64        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.48 ±110%      +9.0        9.44 ±  2%  perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback
      0.48 ±110%      +9.0        9.44 ±  2%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_do_writeback.wb_workfn
      0.48 ±110%      +9.0        9.44 ±  2%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_do_writeback
      0.48 ±110%      +9.0        9.44 ±  2%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.wb_writeback.wb_do_writeback.wb_workfn.process_one_work
     24.59 ±  5%      -7.7       16.86        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     24.41 ±  5%      -7.7       16.69        perf-profile.children.cycles-pp.generic_perform_write
     31.13            -6.6       24.56 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     31.10            -6.6       24.53 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     30.67            -6.4       24.32        perf-profile.children.cycles-pp.write
     29.40            -6.3       23.14        perf-profile.children.cycles-pp.vfs_write
     29.51            -6.3       23.26        perf-profile.children.cycles-pp.ksys_write
      6.32 ±  3%      -5.1        1.24 ±  6%  perf-profile.children.cycles-pp.ext4_da_do_write_end
      5.86 ±  3%      -4.7        1.17 ±  6%  perf-profile.children.cycles-pp.block_write_end
      5.80 ±  3%      -4.6        1.16 ±  6%  perf-profile.children.cycles-pp.__block_commit_write
      9.67 ±  5%      -4.0        5.62 ±  2%  perf-profile.children.cycles-pp.ext4_da_write_begin
     17.24 ±  5%      -3.7       13.50        perf-profile.children.cycles-pp.__writeback_inodes_wb
      4.94 ±  6%      -3.1        1.88 ±  2%  perf-profile.children.cycles-pp.__filemap_get_folio
      2.62 ±  5%      -1.7        0.95 ±  4%  perf-profile.children.cycles-pp.filemap_add_folio
      1.86 ±  7%      -1.0        0.82 ±  6%  perf-profile.children.cycles-pp.folio_alloc_noprof
      4.54 ±  5%      -0.9        3.68 ±  3%  perf-profile.children.cycles-pp.ext4_block_write_begin
      2.11 ±  8%      -0.8        1.35 ±  7%  perf-profile.children.cycles-pp.mpage_map_and_submit_buffers
      1.15 ±  6%      -0.7        0.41 ± 11%  perf-profile.children.cycles-pp.__folio_batch_add_and_move
      1.31 ±  3%      -0.7        0.58 ±  6%  perf-profile.children.cycles-pp.mark_buffer_dirty
      1.34 ±  7%      -0.7        0.61 ±  9%  perf-profile.children.cycles-pp.folio_end_writeback
      2.17 ±  8%      -0.7        1.46 ±  7%  perf-profile.children.cycles-pp.mpage_map_and_submit_extent
      1.02 ±  3%      -0.7        0.33 ± 10%  perf-profile.children.cycles-pp.__folio_mark_dirty
      2.00 ±  5%      -0.7        1.32 ± 10%  perf-profile.children.cycles-pp.ext4_finish_bio
      2.00 ±  5%      -0.7        1.32 ± 10%  perf-profile.children.cycles-pp.ext4_release_io_end
      2.03 ±  6%      -0.7        1.36 ±  9%  perf-profile.children.cycles-pp.ext4_end_io_end
      1.61 ±  7%      -0.7        0.94 ±  8%  perf-profile.children.cycles-pp.mpage_submit_folio
      1.04 ±  5%      -0.6        0.39 ± 11%  perf-profile.children.cycles-pp.folio_batch_move_lru
      1.07 ±  8%      -0.6        0.44 ±  6%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.80 ±  5%      -0.6        0.21 ±  7%  perf-profile.children.cycles-pp.lru_add
      1.11 ±  6%      -0.6        0.52 ±  9%  perf-profile.children.cycles-pp.__folio_end_writeback
      1.84 ±  7%      -0.5        1.30 ±  7%  perf-profile.children.cycles-pp.create_empty_buffers
      0.99 ±  5%      -0.5        0.45 ±  5%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.68 ±  8%      -0.4        0.27 ± 11%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.66 ±  7%      -0.4        0.27 ±  8%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.53 ±  7%      -0.4        0.14 ± 11%  perf-profile.children.cycles-pp.lru_gen_add_folio
      1.50 ±  7%      -0.4        1.14 ±  7%  perf-profile.children.cycles-pp.rmqueue
      1.09 ±  7%      -0.3        0.75 ±  9%  perf-profile.children.cycles-pp.ext4_bio_write_folio
      0.56 ±  5%      -0.3        0.23 ± 11%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.48 ±  7%      -0.3        0.18 ±  7%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      1.12 ±  6%      -0.3        0.82 ±  9%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.36 ± 10%      -0.3        0.09 ±  4%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.33 ± 10%      -0.2        0.08 ±  8%  perf-profile.children.cycles-pp.fault_in_readable
      0.33 ±  6%      -0.2        0.09 ± 14%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.28 ±  8%      -0.2        0.07 ± 17%  perf-profile.children.cycles-pp.filemap_get_entry
      0.27 ±  5%      -0.2        0.06 ± 19%  perf-profile.children.cycles-pp.__xa_set_mark
      1.40 ±  8%      -0.2        1.19 ±  7%  perf-profile.children.cycles-pp.folio_alloc_buffers
      0.28 ±  9%      -0.2        0.08 ±  8%  perf-profile.children.cycles-pp.node_dirty_ok
      0.47 ± 10%      -0.2        0.28 ± 13%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      1.00 ±  8%      -0.2        0.83 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.21 ± 11%      -0.1        0.08        perf-profile.children.cycles-pp.__mod_node_page_state
      0.76 ±  8%      -0.1        0.64 ±  8%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.20 ±  9%      -0.1        0.09 ± 18%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.16 ± 11%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.12 ± 16%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.xas_find_conflict
      0.25 ± 11%      -0.1        0.16 ± 10%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.12 ± 17%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.mod_zone_page_state
      0.14 ±  9%      -0.1        0.06 ± 15%  perf-profile.children.cycles-pp.charge_memcg
      0.15 ±  9%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.16 ± 12%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.ext4_da_write_end
      0.22 ± 13%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.xas_start
      0.35 ± 10%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.allocate_slab
      0.12 ± 10%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.try_charge_memcg
      0.12 ± 11%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.12 ± 18%      -0.1        0.06 ± 18%  perf-profile.children.cycles-pp.__fprop_add_percpu
      0.57 ±  9%      -0.1        0.51 ±  6%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.63 ±  2%      -0.1        0.58 ±  4%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.12 ± 15%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ± 20%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xas_find_marked
      0.20 ± 12%      -0.0        0.16 ±  9%  perf-profile.children.cycles-pp.__cond_resched
      0.12 ± 10%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.policy_nodemask
      0.14 ±  5%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.up_write
      0.08 ±  8%      -0.0        0.06 ± 15%  perf-profile.children.cycles-pp.rcu_all_qs
      0.10 ± 13%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.vfs_read
      0.10 ± 15%      +0.0        0.13 ±  8%  perf-profile.children.cycles-pp.ksys_read
      0.07 ± 15%      +0.0        0.11 ± 24%  perf-profile.children.cycles-pp.ext4_ext_map_blocks
      0.07 ± 14%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.ext4_map_create_blocks
      0.08 ±  8%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.ext4_map_blocks
      0.01 ±223%      +0.1        0.07 ± 33%  perf-profile.children.cycles-pp.ext4_mb_new_blocks
      0.30 ± 10%      +0.1        0.43 ±  8%  perf-profile.children.cycles-pp.__xa_insert
      0.37 ± 12%      +0.1        0.51 ±  9%  perf-profile.children.cycles-pp.xa_load
      0.52 ± 29%      +0.2        0.68 ±  5%  perf-profile.children.cycles-pp.io_serial_out
      1.40 ± 10%      +0.6        1.98 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
      0.56 ± 31%      +0.6        1.17 ± 24%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.54 ± 34%      +0.6        1.15 ± 24%  perf-profile.children.cycles-pp.get_jiffies_update
      1.98 ± 12%      +0.8        2.80 ± 10%  perf-profile.children.cycles-pp.update_process_times
      4.39 ±  8%      +0.9        5.31 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      4.36 ±  8%      +0.9        5.29 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.53 ± 10%      +1.0        3.53 ± 12%  perf-profile.children.cycles-pp.tick_nohz_handler
      3.44 ±  8%      +1.0        4.47 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.35 ±  5%      +1.0        3.39 ±  3%  perf-profile.children.cycles-pp.alloc_pages_noprof
      4.03 ± 29%      +1.3        5.28 ±  5%  perf-profile.children.cycles-pp.wait_for_lsr
      4.55 ± 29%      +1.4        5.97 ±  5%  perf-profile.children.cycles-pp.serial8250_console_write
      4.84 ± 29%      +1.5        6.32 ±  4%  perf-profile.children.cycles-pp.console_flush_all
      4.84 ± 29%      +1.5        6.32 ±  4%  perf-profile.children.cycles-pp.console_unlock
      4.85 ± 29%      +1.5        6.32 ±  4%  perf-profile.children.cycles-pp.vprintk_emit
      4.68 ± 30%      +1.5        6.17 ±  4%  perf-profile.children.cycles-pp.devkmsg_write
      4.68 ± 30%      +1.5        6.17 ±  4%  perf-profile.children.cycles-pp.devkmsg_emit
      5.02 ± 32%      +1.5        6.52        perf-profile.children.cycles-pp.memcpy_toio
      5.06 ± 32%      +1.5        6.59        perf-profile.children.cycles-pp.drm_fb_memcpy
      5.06 ± 32%      +1.5        6.59        perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      5.07 ± 32%      +1.5        6.60        perf-profile.children.cycles-pp.drm_atomic_commit
      5.07 ± 32%      +1.5        6.59        perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      5.07 ± 32%      +1.5        6.60        perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      5.07 ± 32%      +1.5        6.60        perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      5.07 ± 32%      +1.5        6.60        perf-profile.children.cycles-pp.commit_tail
      5.07 ± 32%      +1.5        6.60        perf-profile.children.cycles-pp.drm_atomic_helper_commit
      5.07 ± 32%      +1.5        6.60        perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      5.07 ± 32%      +1.5        6.60        perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      5.07 ± 32%      +1.5        6.60        perf-profile.children.cycles-pp.drm_fbdev_shmem_helper_fb_dirty
      7.25 ±  9%      +1.9        9.13 ±  2%  perf-profile.children.cycles-pp.rep_movs_alternative
      7.50 ±  9%      +1.9        9.40 ±  2%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      3.96 ±  7%      +2.0        6.00 ±  7%  perf-profile.children.cycles-pp.memcpy_orig
      4.18 ±  7%      +2.1        6.30 ±  6%  perf-profile.children.cycles-pp.copy_to_brd
      6.53 ±  7%      +2.8        9.36 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      8.66 ±  6%      +4.3       12.93 ±  3%  perf-profile.children.cycles-pp.brd_insert_page
     17.79 ±  4%      +5.1       22.93        perf-profile.children.cycles-pp.__writeback_single_inode
     17.79 ±  4%      +5.1       22.93        perf-profile.children.cycles-pp.ext4_writepages
     17.79 ±  4%      +5.1       22.93        perf-profile.children.cycles-pp.do_writepages
     17.79 ±  4%      +5.1       22.93        perf-profile.children.cycles-pp.ext4_do_writepages
     17.80 ±  4%      +5.1       22.94        perf-profile.children.cycles-pp.writeback_sb_inodes
     17.80 ±  4%      +5.1       22.94        perf-profile.children.cycles-pp.wb_do_writeback
     17.80 ±  4%      +5.1       22.94        perf-profile.children.cycles-pp.wb_workfn
     17.80 ±  4%      +5.1       22.94        perf-profile.children.cycles-pp.wb_writeback
     12.92 ±  4%      +6.4       19.36        perf-profile.children.cycles-pp.brd_submit_bio
     12.92 ±  4%      +6.4       19.37        perf-profile.children.cycles-pp.__submit_bio
     12.92 ±  4%      +6.4       19.37        perf-profile.children.cycles-pp.__submit_bio_noacct
     12.89 ±  4%      +6.5       19.37        perf-profile.children.cycles-pp.ext4_io_submit
     23.05 ±  4%      +6.7       29.71        perf-profile.children.cycles-pp.kthread
     22.96 ±  4%      +6.7       29.61        perf-profile.children.cycles-pp.process_one_work
     23.06 ±  4%      +6.7       29.71        perf-profile.children.cycles-pp.ret_from_fork_asm
     23.05 ±  4%      +6.7       29.71        perf-profile.children.cycles-pp.ret_from_fork
     22.98 ±  4%      +6.7       29.64        perf-profile.children.cycles-pp.worker_thread
      4.33 ±  4%      -3.8        0.53 ±  8%  perf-profile.self.cycles-pp.__block_commit_write
      0.96 ±  6%      -0.4        0.57 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.52 ±  8%      -0.3        0.21 ± 10%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.37 ±  6%      -0.3        0.10 ±  8%  perf-profile.self.cycles-pp.lru_gen_add_folio
      0.34 ±  6%      -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.__filemap_add_folio
      0.32 ±  8%      -0.3        0.06 ± 45%  perf-profile.self.cycles-pp.ext4_da_do_write_end
      0.33 ±  9%      -0.2        0.08 ± 10%  perf-profile.self.cycles-pp.fault_in_readable
      0.33 ± 11%      -0.2        0.12 ± 10%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.26 ±  8%      -0.2        0.07 ± 20%  perf-profile.self.cycles-pp.lru_add
      0.36 ±  8%      -0.2        0.18 ± 16%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.37 ± 10%      -0.2        0.19 ± 18%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.24 ±  7%      -0.2        0.07 ± 14%  perf-profile.self.cycles-pp.create_empty_buffers
      0.69 ±  7%      -0.2        0.53 ±  6%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.24 ±  9%      -0.2        0.08 ±  8%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.27 ±  7%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.22 ±  9%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.folio_clear_dirty_for_io
      0.26 ±  9%      -0.1        0.12 ± 13%  perf-profile.self.cycles-pp.folios_put_refs
      0.22 ± 12%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.folio_end_writeback
      0.29 ±  7%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.19 ± 11%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.node_dirty_ok
      0.16 ±  4%      -0.1        0.05 ± 49%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.18 ± 11%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.20 ±  7%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ± 13%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.32 ± 12%      -0.1        0.23 ± 15%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.11 ±  8%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.14 ±  8%      -0.1        0.06 ± 19%  perf-profile.self.cycles-pp.mpage_prepare_extent_to_map
      0.14 ±  9%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.21 ± 13%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.xas_start
      0.14 ± 37%      -0.1        0.06 ± 21%  perf-profile.self.cycles-pp.folio_alloc_buffers
      0.34 ±  9%      -0.1        0.27 ± 11%  perf-profile.self.cycles-pp.__alloc_frozen_pages_noprof
      0.16 ± 19%      -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.generic_perform_write
      0.08 ± 20%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.xas_find_marked
      0.11 ± 18%      -0.0        0.06 ± 19%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.20 ± 11%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.14 ±  7%      -0.0        0.11 ±  8%  perf-profile.self.cycles-pp.up_write
      0.05 ± 48%      +0.0        0.08 ± 21%  perf-profile.self.cycles-pp.bvec_try_merge_page
      0.04 ± 71%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.alloc_pages_noprof
      0.04 ± 71%      +0.0        0.08 ± 22%  perf-profile.self.cycles-pp.__xa_insert
      0.03 ±101%      +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.update_process_times
      0.09 ± 17%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.brd_submit_bio
      0.20 ±  9%      +0.1        0.27 ± 10%  perf-profile.self.cycles-pp.ext4_bio_write_folio
      0.00            +0.1        0.13 ±  8%  perf-profile.self.cycles-pp.folio_alloc_noprof
      0.52 ± 29%      +0.2        0.68 ±  5%  perf-profile.self.cycles-pp.io_serial_out
      0.29 ± 36%      +0.2        0.51 ± 26%  perf-profile.self.cycles-pp.tick_nohz_handler
      0.20 ±  8%      +0.3        0.47 ± 14%  perf-profile.self.cycles-pp.ext4_finish_bio
      1.39 ± 10%      +0.6        1.96 ±  3%  perf-profile.self.cycles-pp.clear_page_erms
      0.54 ± 34%      +0.6        1.15 ± 24%  perf-profile.self.cycles-pp.get_jiffies_update
      4.90 ± 32%      +1.4        6.34        perf-profile.self.cycles-pp.memcpy_toio
      7.20 ±  9%      +1.9        9.08 ±  2%  perf-profile.self.cycles-pp.rep_movs_alternative
      3.94 ±  7%      +2.0        5.96 ±  6%  perf-profile.self.cycles-pp.memcpy_orig
      6.48 ±  7%      +2.8        9.28 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


