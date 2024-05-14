Return-Path: <linux-fsdevel+bounces-19475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EB08C5DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 00:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5117B216ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CABB181D1E;
	Tue, 14 May 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNR/+oOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6291DDEE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725936; cv=fail; b=gfOqvtVNWR1BPMD6MW91JkLypEmnzYFK42esq/mgd/IAW4cwY6rPqHlbeKUU/nWCCq6RBIjvEMYMLeH2BNNQgJrDErDhkL9UsuIW4xSEHuyC6Odd1gN1emToMFjJDlJLONOvRM1RgKK+hq6rKeJ5Ozwhx+eQ96wvB8UNktTF9OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725936; c=relaxed/simple;
	bh=5zi2kr3EqqcqhV2yZ8Q1nQFWHmPh1RqFnu8GPOIg4a4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fnZZobAx1FRXm8g8A4fhl7jb24J8I6ULRZ54TMFXdUf+jzN2v+XizPPxTGcWDOAIV6HeTBkZVwYdfsiW3B2lpG4EpfOYmPYHoDM2cpznnKAGe3PXUmmoK42WMyApypM7pBwY9Duw6hMjivE3mLlUvNVdksI1YyUw3w3jm+Gs3EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNR/+oOA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715725934; x=1747261934;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5zi2kr3EqqcqhV2yZ8Q1nQFWHmPh1RqFnu8GPOIg4a4=;
  b=GNR/+oOAdTYiUUw504vMTmhPtx/wYb3gkUeiLp/P64+UL9r1G0A7by2v
   qK3MV7O422d0rGcm644YcgHvqQT0gcKm8nZLd5PdSNdFt7JHjT597vTXu
   0F7rg5bSGXBeFSxZMz9OZ6/E4+SqgwACpT9X9Gdu7Eqm0VOi84HyMPugC
   CY85TcRbZJam+6x3j5uo5LQ3Mm2pyP6W8ve1+MJjjzC6awleQhPsLSUgk
   x3ZFO0dUwIzBUqvPUCn+oMYuNFDeGneN+9fqHIboSljkGLn03G5/z1ChS
   aRGdi0wwaFyVjxsxhPx4hg0jb6E5ASFNEVQ9S+5ULK2TQlb/8Pu01QPrM
   Q==;
X-CSE-ConnectionGUID: 0ODQj7LwQVG5YEfO1ArM+A==
X-CSE-MsgGUID: WWbHOYdaR3KpuoWHTrYRNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11688780"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11688780"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 15:32:13 -0700
X-CSE-ConnectionGUID: vb8knya4TN2nRST9h5ffCw==
X-CSE-MsgGUID: H1eFolnnQP+gkksidbIJwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="61663694"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 15:32:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 15:32:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 15:32:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 15:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnHvL+bLxyDbabVNgvMtoCe4CJuS5B+IYiZd/pOWLxELN/2IdDtmkOLZI13WoKSoZigAzh5bOv6UCqxO/dyBthbixt4Z9HTDQ7xnKCWgjLUap5MIfBEsohHJJ8qCttmQKR6b1t7T1Qqdi51tRg9CZ0CvLlDkZVNjpKyNEoX2htWZR0mT0gGKgN30iOlnUHoKi0WleMVAUTPgGTKEo/nUvAjOW4H/r61OwcVlpA1UNxLpShx4y/8ycEnblMDFSbz1SpJbwK1Jlmx4m6Ag3SoYc3Mfz2azORTAlm8DDPK1h8YdgHW0cNpn0Ljmj1s+mJkyTTEvXgQeS1xSLGemmP/bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mWzVDZjwGn3hUPa+n2gBR1eyRk5bCsBDCqmmiY3/X8=;
 b=RXz8zOi94//7dUQljtF6nrEQzcYxnrDo9ljiwkif0vGtSbgTS9BeCjmJYR1/hXRh/3d579YK3ESzL7Kj+x4tz1A+ooaB3hAbq8L7B8HqKliy2nacTt0kuWNOrL7m1NtcdFsjirJGcXfq9sww8u5QC/AirZTC9UA6TGBRiYOMpCI6JGJo72Kgz6oitXf4Q2Q3dJl8eXcP5E69D7QwIqlfovLZGWVKP1D1v4irfm8af0N/+wwSMzhXHGNK9g2EnKywtO6eyRZEdsG/81QzmsmgU5DKe3u8J49KZtiGQvi0F1Ata838vwbK0Tp+FxYgSHrZEpDsxc56RdAz7rlbrzHGng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 22:32:03 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 22:32:03 +0000
Date: Tue, 14 May 2024 22:31:19 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: John Harrison <john.c.harrison@intel.com>,
	<intel-xe@lists.freedesktop.org>, Lucas De Marchi <lucas.demarchi@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
Message-ID: <ZkPmN2KyjC3vPlZ+@DUT025-TGLU.fm.intel.com>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
 <20240512153606.1996-5-michal.wajdeczko@intel.com>
 <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
 <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
 <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
 <ZkPKM/J0CiBsNgMe@DUT025-TGLU.fm.intel.com>
 <1c2dd2d5-1e55-4a7d-8a38-0fe96b31019e@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c2dd2d5-1e55-4a7d-8a38-0fe96b31019e@intel.com>
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dbd25c-dab6-44a8-c99a-08dc7465adaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?BMEFcdHF0ppDpwi1Hd7Vo+UYEb6uE6MfSthwvwIGbmt4vk93KuisKyHzt3?=
 =?iso-8859-1?Q?Blya7B9RCCHUzE0avm9wFLKebFaaafUBVRHNFN8p69AJsfJY5u/+Ktj9ND?=
 =?iso-8859-1?Q?mwvk/i+1//2V0G45iL8APl5DNhL5S7biHRwcC7bMM89Clwyx5bs9oO+qN/?=
 =?iso-8859-1?Q?xqTDoRQH8N9cXHzBzWnQA+Z+oXJCFkVJS8cviccdcyfOD6f/yx75przdGf?=
 =?iso-8859-1?Q?XJXl++OtM4xdmncfPg3FnUDiwBP6oP1m10rn17a/V1YebpPv59dzdcHNoy?=
 =?iso-8859-1?Q?lG/t72gdFHI7RZZW8yUsjsiNrtNGwJ64I25zfHDh01wr+XtGJijJ/dplu7?=
 =?iso-8859-1?Q?ucVL5fJMXBD17LVKr6oCH51U+3oN39Xe3rlm+8nyM73sstvvFm1zZiQ5OV?=
 =?iso-8859-1?Q?9lhjNdekNzhi5oi7pWDK6DbajtFS3eS9cJFcy2wOF2t19aE3XEh8zk/Vh4?=
 =?iso-8859-1?Q?/OPgbhn3Jdyv4dnLlP71dlXCw73NqjGxyTAHFI7Pxc8SSstGPM26TdvDc4?=
 =?iso-8859-1?Q?eUIyq5deE/43ehC7kGvT2XFjGFscALV9dQ/MB3hG7d5j7TVGqHvEog8OtT?=
 =?iso-8859-1?Q?DekDwQxhY6BqUFo8mU3YhDM2p294A+2lVJZkte9q3cwxyR8n3xAmBHer3V?=
 =?iso-8859-1?Q?dRA1LX/z47H6fkkSNFEWAWPGJXnVgKf0CpDZRNys4xs6HfkVqiqMf0j09h?=
 =?iso-8859-1?Q?LWR46dsZdBnk4TQn9LQzehbsNl4n1i48VQQxmK0iMY7wZapk5+KG5hO+fE?=
 =?iso-8859-1?Q?1Ijna9UXq454ULlLjgvvGZyCqOGQb+aiPiW91cGmUr+mtOoLPrWn9tMEUj?=
 =?iso-8859-1?Q?wX6hNQ2tqQqjV0G7z7XN7hDW+sNL5aQuHMUTqoRqsyqZyQ0VRNovcgn0Ku?=
 =?iso-8859-1?Q?FZxTxIS0hUDi0PLX8UBXMF/SuMGTFjUoDQ1emXVqe/cLW3WvdEAx3eyEdQ?=
 =?iso-8859-1?Q?xQKcLR7cmxiWHRz3R/j6w1frBCJCKFUOCHe9VjIizdf4BxPjklMorrSlp9?=
 =?iso-8859-1?Q?3ayHqUztOO9fNb7xR0M9pPCN54IMx13ZwuMfrZVFE9BFRWMzbb/TI6eOrl?=
 =?iso-8859-1?Q?1Ys6J/aah4DsZAl9X1/Qzx/03LDEUChPPttFtAQAl292EhmbnnuA7B/TZo?=
 =?iso-8859-1?Q?g+lQLQnGe7ixJjxCcAxax8xuzJ0+O8stKMViFi9NnrLeyOTEg7Jvrr164s?=
 =?iso-8859-1?Q?1MLsvksMNpRBIPmp0KbB26dddvnPhdK5MFUn2Hj6B2UhSisNk2O1poRWyt?=
 =?iso-8859-1?Q?CEWAc2J1irRPerl7cmYF4FL3NL/0LlsArDt4hnmwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5CCiwUugWoiJd2lGmgGLMjaC7Vh61PyMl0+q1cWgDkKtkutvRuva1NGwYS?=
 =?iso-8859-1?Q?oSQrfyCp5LgIrsetDEP5NdLBDOl9mK/9jIJH3gaUfeBNo7MGxMKKXinBVI?=
 =?iso-8859-1?Q?NlIUOCUwT74tfUVWV9/7al06SUTy4+b3SB0EyI9Yu/cdxBZyidGsXQXIlS?=
 =?iso-8859-1?Q?RHZQ3eCyzmV9zWdwYzeyZQKaPYrNRAhi4qYUbONedhoF3IuLBTUkDFdAAz?=
 =?iso-8859-1?Q?i7CCOrh/xnf4KEEIM2zTGUthfJ68nVci7TOdwf20T62BaXTpb8dDylnhD3?=
 =?iso-8859-1?Q?VeBKzqSdjXZJDtGsThr0VqUPKI7gCiPBa/iJCk6FHq+1PWGwWHh9K+ugME?=
 =?iso-8859-1?Q?GPxmAxaRjz5Cfg8b+MNeDbeqmeyQ+azZ9qH7RgXNk0GFlf4VjO1Lav6SU3?=
 =?iso-8859-1?Q?4qLVQFQHqZIVw5twO6mtF/YHlIEkvufURkRssv7+x4zAe6CHZolnVTm06E?=
 =?iso-8859-1?Q?rcD8ZLWaflMpyX43EvcWEt/JrOJCsj87rngvu1f619iPOXMMv/u5TVQ31v?=
 =?iso-8859-1?Q?2r2mKB9el2SWVFmbm8nFtUgCNXecSY6etzjSI8lQQ+3FWdAfmpzYVo8bIt?=
 =?iso-8859-1?Q?c19GiBJrtNJYBK7v+aia9Gz1h1ogxcqOjoRhKbxOCv8waXmLKnB4siIZpg?=
 =?iso-8859-1?Q?3RFmsYTp0iPwvBYB1s/fC4LDut4dSh92qY7iuZp6m4R98e5vQ2y8twBfRw?=
 =?iso-8859-1?Q?6yh6cpy6YJjUGDF7fR7LXCexZ0SkEeRCS2sfxTSX7KpD5FHI1ccIRX41Zq?=
 =?iso-8859-1?Q?UBOiCU5UZDBIjor0R48I+hzVHZ6/3wkA5MDhxF8+utIAamrXZ2xqElcMAk?=
 =?iso-8859-1?Q?xnnl8CQxqrvoMyTcLPbgFPNT0Ghh9FVYMTTnOOtK+LFF/ZEFBZgmHFG94G?=
 =?iso-8859-1?Q?+CEp8QbKYsejXuizJZCDvb5YEOl/z3RvYD/qycJkI+xSX3WD/EtrXj+oFE?=
 =?iso-8859-1?Q?+ZbwSTf6U2FF23ALa7BtXOylMz6yNlCs1YpLWdgGUZzJ4wreBLgUYaTSUY?=
 =?iso-8859-1?Q?cbslYMQKW4rIEePA0PAPiwL724AT+Ykpf+CcRJ6lGns7C4cRtceUMpdK5E?=
 =?iso-8859-1?Q?kYIpa88DiwNk/8pvwyBupIzPk/0b5Ul71XmK6nvKZ8ltzo2+S8S3xpf9KM?=
 =?iso-8859-1?Q?jkIaBJKzjQ15cYPyGWa5b23FL4HEORbHgWluFjk7XbARpJzdgV0A3iQD88?=
 =?iso-8859-1?Q?9yAyN4HqjGhyDz4W8Vif3exGKK5Y60Mq4gnbYlqE9TPA0b9amKqTxjyq+c?=
 =?iso-8859-1?Q?ZHLotclp6RdRmQdnV4PbmhGdVjDMom2pqdOQ+uAs+iVoE6bcNcV3PkMDxW?=
 =?iso-8859-1?Q?04/0K3SZVYqA6bdoeHUoCpb9elj0gN2DlbOnom9g61KHxxV2Tkwx+MvAqW?=
 =?iso-8859-1?Q?Gt6mU3w6FPZUDrc/W/Q7iL6ONpXbVEm+cFvQw3VTM+gyvnAEmV5YLhVhLx?=
 =?iso-8859-1?Q?tXURrgCQM8QMmstIlK+qfy2r6syW65M/d4cKv1uoAgii6F2yKg2EHf4h+o?=
 =?iso-8859-1?Q?/JNxcCdPW0jpsPcbk+BbdCdPIdWGoITCAt0uREYLjWHB3Yx4RrAK8QDeyJ?=
 =?iso-8859-1?Q?5CPzVykh9I7MMPxyvcCeh6VnMj1sR3hiozKAviKFGFCs4NJzyRq6fRv8s0?=
 =?iso-8859-1?Q?r4PMcwBWx5xNi2cKCC1aT8JPUMeqBUzBbggjDv753srMHzZOpYzCzueA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dbd25c-dab6-44a8-c99a-08dc7465adaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 22:32:03.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L5LCm/jbkTLgrahfEac3askZsStxlNFXKsjGdfBue6tlBaGfb2MO+WKa/8uVo/han1tuYbUoAR76mL6grDCxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com

On Tue, May 14, 2024 at 11:15:55PM +0200, Michal Wajdeczko wrote:
> 
> 
> On 14.05.2024 22:31, Matthew Brost wrote:
> > On Tue, May 14, 2024 at 11:13:14AM -0700, John Harrison wrote:
> >> On 5/14/2024 07:58, Michal Wajdeczko wrote:
> >>> On 13.05.2024 18:53, John Harrison wrote:
> >>>> On 5/12/2024 08:36, Michal Wajdeczko wrote:
> >>>>> We already provide the content of the GuC log in debugsfs, but it
> >>>>> is in a text format where each log dword is printed as hexadecimal
> >>>>> number, which does not scale well with large GuC log buffers.
> >>>>>
> >>>>> To allow more efficient access to the GuC log, which could benefit
> >>>>> our CI systems, expose raw binary log data.  In addition to less
> >>>>> overhead in preparing text based GuC log file, the new GuC log file
> >>>>> in binary format is also almost 3x smaller.
> >>>>>
> >>>>> Any existing script that expects the GuC log buffer in text format
> >>>>> can use command like below to convert from new binary format:
> >>>>>
> >>>>>      hexdump -e '4/4 "0x%08x " "\n"'
> >>>>>
> >>>>> but this shouldn't be the case as most decoders expect GuC log data
> >>>>> in binary format.
> >>>> I strongly disagree with this.
> >>>>
> >>>> Efficiency and file size is not an issue when accessing the GuC log via
> >>>> debugfs on actual hardware.
> >>> to some extend it is as CI team used to refuse to collect GuC logs after
> >>> each executed test just because of it's size
> >> I've never heard that argument. I've heard many different arguments but not
> >> one about file size. The default GuC log size is pretty tiny. So size really
> >> is not an issue.
> >>
> >>>
> >>>> It is an issue when dumping via dmesg but
> >>>> you definitely should not be dumping binary data to dmesg. Whereas,
> >>> not following here - this is debugfs specific, not a dmesg printer
> >> Except that it is preferable to have common code for both if at all
> >> possible.
> >>
> >>>
> >>>> dumping in binary data is much more dangerous and liable to corruption
> >>>> because some tool along the way tries to convert to ASCII, or truncates
> >>>> at the first zero, etc. We request GuC logs be sent by end users,
> >>>> customer bug reports, etc. all doing things that we have no control over.
> >>> hmm, how "cp gt0/uc/guc_log_raw FILE" could end with a corrupted file ?
> >> Because someone then tries to email it, or attach it or copy it via Windows
> >> or any number of other ways in which a file can get munged.
> >>
> >>>
> >>>> Converting the hexdump back to binary is trivial for those tools which
> >>>> require it. If you follow the acquisition and decoding instructions on
> >>>> the wiki page then it is all done for you automatically.
> >>> I'm afraid I don't know where this wiki page is, but I do know that hex
> >>> conversion dance is not needed for me to get decoded GuC log the way I
> >>> used to do
> >> Look for the 'GuC Debug Logs' page on the developer wiki. It's pretty easy
> >> to find.
> >>
> >>>> These patches are trying to solve a problem which does not exist and are
> >>>> going to make working with GuC logs harder and more error prone.
> >>> it at least solves the problem of currently super inefficient way of
> >>> generating the GuC log in text format.
> >>>
> >>> it also opens other opportunities to develop tools that could monitor or
> >>> capture GuC log independently on  top of what driver is able to offer
> >>> today (on i915 there was guc-log-relay, but it was broken for long time,
> >>> not sure what are the plans for Xe)
> >>>
> >>> also still not sure how it can be more error prone.
> >> As already explained, the plan is move to LFD - an extensible, streamable,
> >> logging format. Any non-trivial effort that is not helping to move to LFD is
> >> not worth the effort.
> >>
> >>>
> >>>> On the other hand, there are many other issues with GuC logs that it
> >>>> would be useful to solves - including extra meta data, reliable output
> >>>> via dmesg, continuous streaming, pre-sizing the debugfs file to not have
> >>>> to generate it ~12 times for a single read, etc.
> >>> this series actually solves last issue but in a bit different way (we
> >>> even don't need to generate full GuC log dump at all if we would like to
> >>> capture only part of the log if we know where to look)
> >> No, it doesn't solve it. Your comment below suggests it will be read in 4KB
> >> chunks. Which means your 16MB buffer now requires 4096 separate reads! And
> >> you only doing partial reads of the section you think you need is never
> >> going to be reliable on live system. Not sure why you would want to anyway.
> >> It is just making things much more complex. You now need an intelligent user
> >> land program to read the log out and decode at least the header section to
> >> know what data section to read. You can't just dump the whole thing with
> >> 'cat' or 'dd'.
> >>
> > 
> > Briefly have read this thread but seconding John's opinion that anything
> > which breaks GuC log collection via a simple command like cat is a no
> 
> hexdump or cp is also a simple command and likely we can assume that
> either user will know what command to use or will just type the command
> that we say.
> 
> > go. Also anything that can allow windows to mangle the output would be
> > less than idle too. Lastly, GuC log collection is not a critical path
> > operation so it likely does not need to optimized for speed.
> 
> but please remember that this patch does not change anything to the
> existing debugfs files, the guc_log stays as is, this new raw access is
> defined as another guc_log_raw file that would allow develop other use
> cases, beyond what is possible with naive text snapshots, like live
> monitor for errors, all implemented above kernel driver
> 

Not opposed to this, nor is it a tremendous amount of code to carry in
addition to existing GuC log interfaces. However, adding an additional
interface could create some confusion. If there are indeed interesting
uses for this new interface, it would be helpful to post those as well.

Matt

> > 
> > Matt
> > 
> >>>
> >>> for reliable output via dmesg - see my proposal at [1]
> >>>
> >>> [1] https://patchwork.freedesktop.org/series/133613/
> >>
> >>>
> >>>> Hmm. Actually, is this interface allowing the filesystem layers to issue
> >>>> multiple read calls to read the buffer out in small chunks? That is also
> >>>> going to break things. If the GuC is still writing to the log as the
> >>>> user is reading from it, there is the opportunity for each chunk to not
> >>>> follow on from the previous chunk because the data has just been
> >>>> overwritten. This is already a problem at the moment that causes issues
> >>>> when decoding the logs, even with an almost atomic copy of the log into
> >>>> a temporary buffer before reading it out. Doing the read in separate
> >>>> chunks is only going to make that problem even worse.
> >>> current solution, that converts data into hex numbers, reads log buffer
> >>> in chunks of 128 dwords, how proposed here solution that reads in 4K
> >>> chunks could be "even worse" ?
> >> See above, 4KB chunks means 4096 separate reads for a 16M buffer. And each
> >> one of those reads is a full round trip to user land and back. If you want
> >> to get at all close to an atomic read of the log then it needs to be done as
> >> a single call that copies the log into a locally allocated kernel buffer and
> >> then allows user land to read out from that buffer rather than from the live
> >> log. Which can be trivially done with the current method (at the expense of
> >> a large memory allocation) but would be much more difficult with random
> >> access reader like this as you would need to say the copied buffer around
> >> until the reads have all been done. Which would presumably mean adding
> >> open/close handlers to allocate and free that memory.
> >>
> >>>
> >>> and in case of some smart tool, that would understands the layout of the
> >>> GuC log buffer, we can even fully eliminate problem of reading stale
> >>> data, so why not to choose a more scalable solution ?
> >> You cannot eliminate the problem of stale data. You read the header, you
> >> read the data it was pointing to, you re-read the header and find that the
> >> GuC has moved on. That is an infinite loop of continuously updating
> >> pointers.
> >>
> >> John.
> >>
> >>>
> >>>> John.
> >>>>
> >>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> >>>>> Cc: John Harrison <John.C.Harrison@Intel.com>
> >>>>> ---
> >>>>> Cc: linux-fsdevel@vger.kernel.org
> >>>>> Cc: dri-devel@lists.freedesktop.org
> >>>>> ---
> >>>>>    drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
> >>>>>    1 file changed, 26 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c
> >>>>> b/drivers/gpu/drm/xe/xe_guc_debugfs.c
> >>>>> index d3822cbea273..53fea952344d 100644
> >>>>> --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
> >>>>> +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
> >>>>> @@ -8,6 +8,7 @@
> >>>>>    #include <drm/drm_debugfs.h>
> >>>>>    #include <drm/drm_managed.h>
> >>>>>    +#include "xe_bo.h"
> >>>>>    #include "xe_device.h"
> >>>>>    #include "xe_gt.h"
> >>>>>    #include "xe_guc.h"
> >>>>> @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
> >>>>>        {"guc_log", guc_log, 0},
> >>>>>    };
> >>>>>    +static ssize_t guc_log_read(struct file *file, char __user *buf,
> >>>>> size_t count, loff_t *pos)
> >>>>> +{
> >>>>> +    struct dentry *dent = file_dentry(file);
> >>>>> +    struct dentry *uc_dent = dent->d_parent;
> >>>>> +    struct dentry *gt_dent = uc_dent->d_parent;
> >>>>> +    struct xe_gt *gt = gt_dent->d_inode->i_private;
> >>>>> +    struct xe_guc_log *log = &gt->uc.guc.log;
> >>>>> +    struct xe_device *xe = gt_to_xe(gt);
> >>>>> +    ssize_t ret;
> >>>>> +
> >>>>> +    xe_pm_runtime_get(xe);
> >>>>> +    ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap,
> >>>>> log->bo->size);
> >>>>> +    xe_pm_runtime_put(xe);
> >>>>> +
> >>>>> +    return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static const struct file_operations guc_log_ops = {
> >>>>> +    .owner        = THIS_MODULE,
> >>>>> +    .read        = guc_log_read,
> >>>>> +    .llseek        = default_llseek,
> >>>>> +};
> >>>>> +
> >>>>>    void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
> >>>>>    {
> >>>>>        struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
> >>>>> @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc,
> >>>>> struct dentry *parent)
> >>>>>        drm_debugfs_create_files(local,
> >>>>>                     ARRAY_SIZE(debugfs_list),
> >>>>>                     parent, minor);
> >>>>> +
> >>>>> +    debugfs_create_file("guc_log_raw", 0600, parent, NULL,
> >>>>> &guc_log_ops);
> >>>>>    }
> >>

