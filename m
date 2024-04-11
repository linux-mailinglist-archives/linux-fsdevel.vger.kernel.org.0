Return-Path: <linux-fsdevel+bounces-16643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1E38A05A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 03:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432A31F22988
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 01:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D360EF9;
	Thu, 11 Apr 2024 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiTjVkEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5F1E487
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799754; cv=fail; b=L9BHyc6MQG0l4kivht/kXbnJGAV0XhqLxjC6y4Padi73n2m2Rbus3/R2UaG8iwFWiI6JDMlY42Mc+Wjbh9esjPV7UrKWw5i0i/UypJvoPH2TVIhvWgoGXMn9cqfmqbFptFACUsmYNvvHqbGLpyHC3nPTle5D1IT3DaSkZAD6Fmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799754; c=relaxed/simple;
	bh=RhFJbaEnF011bE+A/Vpqc0ZfeuwhRQistv61vzf0ITY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CnlMkCkOp5ryoF66myuoU/O8VxWvGHPKnIRjtpPiJya1Et7W8P7rxDoFmzrAgCaXZEKVWsRkrhDTpB4TLYTNKkP7AnqYCM4JUBI/CryTopBKkBE11UCNRokF5TL2nvBKdVYR7O3Xc62Ls0wJImC+dCRPoAENbxXbOXuYzEKMVPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiTjVkEY; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712799752; x=1744335752;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=RhFJbaEnF011bE+A/Vpqc0ZfeuwhRQistv61vzf0ITY=;
  b=MiTjVkEY7aI1pR17Dq5ETORBN/fyT80E06lsBrHYbEHgmEj0kgeBe6bi
   pZRctHn/s6HE6cKdAiOhOLILhUMp1KC2I0i0nohz3z7O46XtWbf75gS+x
   9ly14fgFCfceexPdFAtC02tn2MQb96gsP6EdgazczkoRNZEHM8BGGa4ga
   hvKhGxJUBklotESRZ81tLSsCxCtA2ROyvN+0zwq0KsWn9nigMZeUG/6aQ
   0XB3jQ3aNBMFOyh4NIb33FVuyIQmtAOwl/rMA8XOf8o96bZzsTNweZdlp
   XsLUo4iWS5KwmktBIPYgcE6U0gQgHEqLTYa0CXVNz7F5/s7LrXKg0LIo+
   g==;
X-CSE-ConnectionGUID: VQY0f2a3TsWBnPd4DqJlUQ==
X-CSE-MsgGUID: 9hSlGqvqQVKSMWa8ZLuTIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30677222"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="30677222"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 18:42:31 -0700
X-CSE-ConnectionGUID: oe9wysMkTMO5MCngapbsuA==
X-CSE-MsgGUID: EncT0uasSTe3odFaTgK7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25266321"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 18:42:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 18:42:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 18:42:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 18:42:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 18:42:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtKSlQAC9OIK+v4djlpv9RELgbsUL6wi62jp/irPNbYGWvI73dqlPNpSUL8oNP25Fu0bL+NeNVomRRN7Y8G4ZzGnG7HKNJGExGOHG9qQGLPo1I8u/yYOL0hBAJScOleKQ0reuBfr1YI5AUjFjyj8nS7yDv44rhkgLOzFS8bg1ZkiJJgIYHMFJn8fNrEdfzRY+Yy6b1rwcRapkqufXJkMhuUmsENAGI2EPpBi5b0gkiPPTHGmowJ1r/FGyEkfwf+c0u5pOWBkwC5BDMZhxJNejSg5+srpk7l0NNA7nL42NqebTJdIEMlPD/9xYRUE0VMhyDQNO8SupUDPIUWgN8TjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8tWiwOawfkWvpJqa5cxsjdjWUq87R0WdL6lpU9ueuI=;
 b=OJx+Nj/Ht7oUSlmxVzxTkdMALavjJ5A/22OPQ5GFktFheYFqgdeAMEcpAsE9/lkMtoo5bLy5k61m/D9g6LjbRjncW9/wkmGv4qLqW+CRtm6zYWvlhC+FQPV/8ReARCoLi6pTjyqcNw+LZONjNplceuBaiNMhStPF7L4a0E6JJsDydwPba52T6nZSh2RwBxry6aqhTJo9EUs1nqoRFLknfqH+GcSp1iv+1O3FgtSNgRiXuIskQuUQrUTwuR7fXbnRzdzwLXe2EsFsGVOewyZIpeH8b30xSk/LNSs/yOhDTR0hP2tN0kIwygnwbrymmw/JfShk0HjEITB6OqHm7qVN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 01:42:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 01:42:22 +0000
Date: Thu, 11 Apr 2024 09:42:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fsnotify]  a5e57b4d37:
 stress-ng.full.ops_per_sec -17.3% regression
Message-ID: <202404101624.85684be8-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6909:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EQjM/+3TSj2NE/trl1ozRJyL1LlYWBYOBI7v2NZDt17fOOoe2FtpiTMqy3ZwHw7/hXFLBl9NkL4OFBdnDYdP7dM7RkSGtq2o4PlbfkkGqlluEYgulBcrkEsBIWLtIqwx3/xX9Z//o9DWMfi9/bWhZcGbLlld8RkByplkicj8lgejozFHC4Bai5WsgSjoWo/kYJJi4qO+Pmj7Cd0U+isWcMm7NcpxUQyEspeLEZ2JdB1aQaolrfcxdvX9fryKMXsb5ANioQz/umvBDSgLnwhDFBFq4EKYsQro0fViGPx3NIKYXXoErIUO43t6EYY13y2C1zoPKTaRzyOpEgqxSG6XDY59fYoXS27tuSEWZFT3Hepu9q1RHAnUY6rn+AP4NLVBgSEyUxhLtNj6TJtC9ozYfGu7n+UnNTaQZJwhy2FOUfvi3eTyd2rxHinxXLdZAD+HGQLEkiQeDkXCumNVsvMoMiHjEuB3tCXv2fxnKmCLnkGSMujamxjDmB6XTdupo/ne7fEpuSvbNJEGcP6RCKVhlIwq6oJgY8wQYpSAj0hDJUqXBDK7yPHIR+Jbbr6cLkbM7EDOmHhLeEHJgd2DVP/UtQoPxzjUOZelPlKUwzYfTyXNnfAPVq7jkYlnKcbmaQT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?a0uTnX8V4rG4bWcsiINTV7s99JBXX4I8dZEBYWdP7jHZAyoaTO2Wz3rBF7?=
 =?iso-8859-1?Q?3Rx97QCdOKHgJ/D6EkPAsQItk9UC3W7Ar7OeJ53c3NRS5hxhuXCpBbZfDh?=
 =?iso-8859-1?Q?yhFJ1jsRWyn45LnHLL7gEE0qle8jYQF3eSURp+ZIjOGYxD8F3YmwA7SGkI?=
 =?iso-8859-1?Q?9gFaiKkut52UBFohH7XadYC+bedjKoAr/taqBejCZXk/tq6J/Ry2wQw2hf?=
 =?iso-8859-1?Q?1x/H+0EfFq0TK3c6dPlCUXgwxdhzl3CYbBsOnWtPB0BUQ4OmvY8XTyYCRa?=
 =?iso-8859-1?Q?fqZlSp111TbCHNHvVmldn3pvOVSiGAweriA2MQB1uV5+OFc7UKdLYrZj8a?=
 =?iso-8859-1?Q?4Ik6uPJoSiX48sttO7lbZeCml5qQ+DwULfCLZvz3gvvUIJ6954PwZUK1K8?=
 =?iso-8859-1?Q?giqYoa2KCjTnCHncvgSQizmkHAfy8G00g6Bh+GjgEXHs2aFr++GgDvXWbi?=
 =?iso-8859-1?Q?NgdKK3EiOtZEZXSdRPJ83UXBfTSqs4zZsNpodqAh+7FU14GcUfOmJXkqin?=
 =?iso-8859-1?Q?JY0CsPwVgTbEGpwxporJyaCcKqpVy5rClFt22teBp2UHu0nObnsdY+am9z?=
 =?iso-8859-1?Q?Ckj0SMqZDV9Tl/m0cFNRdfKpZkvqxo3xqDaA6g1S6aSzsIagSfvQujx3yf?=
 =?iso-8859-1?Q?Q9Km7E8WqmaM11ri8dEbjs4Ubc3WfQjTumhZWScgDoYKb82PuOTxqok2If?=
 =?iso-8859-1?Q?5Jw2AorVBl0NkUBBG2px9sMkQWK0YzLlf4fkJA61TWqpywMhQ/qdxRv5TA?=
 =?iso-8859-1?Q?kG1Ez0AV2ixbbh0D+6Rcy/QvsNoQzRYF69jHPsBm24yMumG5L4PIgS44LM?=
 =?iso-8859-1?Q?GxayB5OBrwc2Amw5P6FpS8Z8Qi8dJLUmLJR6/av2NVRYchBjLUormbLc+4?=
 =?iso-8859-1?Q?2ZuMrfyEwY9WWwQCVc+UaYqXcvKbrRe8QBaNWN81OEBmnpkgOYKmj7c3Ms?=
 =?iso-8859-1?Q?oV+vhtlgTTu+g7a5FIiufyzy9WETRjTy3J+gAalvFItIs5GzJjftucAOC2?=
 =?iso-8859-1?Q?qRKR9u1fKbaI6XA3e5ZlY1lfa2t4s6bK4l+Fkh6iWP8nlsnOpEdaSj9QT9?=
 =?iso-8859-1?Q?q28Rz89P0VG6R4tYop9ZpmkE8dl9XBkFU3JgeZibZpS2Pxjm7gVHov8rgJ?=
 =?iso-8859-1?Q?UraIYq3j9EIdM4SRoYVAZ0nNmnSeqGQzOxFLHuQXgg0J2NaDK4F+KXj+x4?=
 =?iso-8859-1?Q?x+XFTgnXyvrFUMNNbX2pb3SIx8k5ZPvQ3wHIom7ynhpHTyGFG9zkYb6Ail?=
 =?iso-8859-1?Q?u9B7O2I0S99BSQEPArsB6v2CFv6SBKhW3KNwqndXwS9pvKrHZqvAl2sQ6K?=
 =?iso-8859-1?Q?c0Bg8vgr4Og6JGQAkX0UBKrGJzWnWHfYuqwFP6fcYSYzjdoJmvEJMU0i3u?=
 =?iso-8859-1?Q?V1ClcEAWep6HUvTM6P8yoRm/wMlszzCdSKyv8y16f2FN6m5t66K3sennI/?=
 =?iso-8859-1?Q?yPHgN8Mhz39g/uRPlCyEaRwliRjPF36OuuMkZAC+P8Qe7NyLEDD0TvY84U?=
 =?iso-8859-1?Q?EVXGRbnjLiM3lhsrPjSMjffInkgMgEC7U71w0uEoI87pZLMATkvGeXvQ8k?=
 =?iso-8859-1?Q?JWqaDgE9hsgfNFIQnaH5QuiEeH4BRZBG0UNHjwPeUmWtwulwkWp6MhLLK/?=
 =?iso-8859-1?Q?aRy4AtfqdfqJ4kV5GmHBt26yr1lvqtZFOxEMrYwicy/XgW4b2iOpmhdg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f22e41-c6c1-4528-3bbc-08dc59c8a16b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 01:42:21.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+SQ+JRF/219pDV9m8Dbtfd8shwXcy+cr7UQF46zaJqVDYSTNbmxHt9dRSpKp0bSSNwdmmZYQAz5avBLNzqJNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6909
X-OriginatorOrg: intel.com


hi, Amir,

for "[amir73il:fsnotify-sbconn] [fsnotify]  629f30e073: unixbench.throughput 5.8% improvement"
(https://lore.kernel.org/all/202403141505.807a722b-oliver.sang@intel.com/)
you requested us to test unixbench for this commit on different branches and we
observed consistent performance improvement.

now we noticed this commit is merged into linux-next/master, we still observed
similar unixbench improvement, however, we also captured a stress-ng regression
now. below details FYI.



Hello,

kernel test robot noticed a -17.3% regression of stress-ng.full.ops_per_sec on:


commit: a5e57b4d370c6d320e5bfb0c919fe00aee29e039 ("fsnotify: optimize the case of no permission event watchers")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: full
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput 6.4% improvement                                                |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | nr_task=1                                                                                       |
|                  | runtime=300s                                                                                    |
|                  | test=fsbuffer-r                                                                                 |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput 5.8% improvement                                                |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | nr_task=1                                                                                       |
|                  | runtime=300s                                                                                    |
|                  | test=fstime-r                                                                                   |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404101624.85684be8-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240410/202404101624.85684be8-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/full/stress-ng/60s

commit: 
  477cf917dd ("fsnotify: use an enum for group priority constants")
  a5e57b4d37 ("fsnotify: optimize the case of no permission event watchers")

477cf917dd02853b a5e57b4d370c6d320e5bfb0c919 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     20489 ±  7%     -19.2%      16565 ± 13%  perf-c2c.HITM.remote
    409.48 ±  9%     -14.0%     352.13 ±  5%  sched_debug.cfs_rq:/.util_est.avg
    217.94 ±  8%     +12.9%     246.07 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
 1.461e+08 ±  3%     -17.3%  1.208e+08 ±  5%  stress-ng.full.ops
   2434462 ±  3%     -17.3%    2013444 ±  5%  stress-ng.full.ops_per_sec
     71.04 ±  3%     -16.6%      59.28 ±  6%  stress-ng.time.user_time
  9.95e+09 ±  4%     -13.4%  8.617e+09 ±  3%  perf-stat.i.branch-instructions
      0.48 ±  3%      +0.1        0.55 ±  2%  perf-stat.i.branch-miss-rate%
      4.36 ±  4%     +17.1%       5.10 ±  3%  perf-stat.i.cpi
 5.162e+10 ±  4%     -14.5%  4.416e+10 ±  3%  perf-stat.i.instructions
      0.24 ±  3%     -13.8%       0.21 ±  3%  perf-stat.i.ipc
      0.46 ±  3%      +0.1        0.54 ±  2%  perf-stat.overall.branch-miss-rate%
      4.38 ±  4%     +16.9%       5.12 ±  3%  perf-stat.overall.cpi
      0.23 ±  4%     -14.5%       0.20 ±  3%  perf-stat.overall.ipc
 9.781e+09 ±  4%     -13.4%  8.471e+09 ±  3%  perf-stat.ps.branch-instructions
 5.075e+10 ±  4%     -14.5%  4.341e+10 ±  3%  perf-stat.ps.instructions
 3.111e+12 ±  4%     -14.5%   2.66e+12 ±  3%  perf-stat.total.instructions
      8.39 ±  7%      -2.8        5.56 ±  4%  perf-profile.calltrace.cycles-pp.__mmap
      8.09 ±  7%      -2.8        5.31 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      8.05 ±  7%      -2.8        5.28 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      7.95 ±  7%      -2.8        5.19 ±  4%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      6.80 ±  8%      -2.7        4.14 ±  4%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
      7.46 ±  8%      -2.7        4.80 ±  4%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      6.78 ±  8%      -2.7        4.13 ±  4%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
      4.12 ± 14%      -2.0        2.09 ± 10%  perf-profile.calltrace.cycles-pp.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.54 ± 14%      -1.7        1.81 ± 10%  perf-profile.calltrace.cycles-pp.apparmor_mmap_file.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      3.46 ±  8%      -1.5        1.99 ±  6%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      3.15 ±  8%      -1.4        1.71 ±  7%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      3.06 ±  9%      -1.4        1.63 ±  7%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      2.95 ±  9%      -1.4        1.54 ±  8%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      5.50 ±  7%      -1.1        4.39 ±  5%  perf-profile.calltrace.cycles-pp.fstatat64
      5.34 ±  7%      -1.1        4.26 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      5.32 ±  7%      -1.1        4.24 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      5.27 ±  8%      -1.1        4.20 ±  6%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      4.95 ±  8%      -1.0        3.91 ±  7%  perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      4.78 ±  8%      -1.0        3.77 ±  7%  perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.75 ±  9%      -1.0        3.74 ±  7%  perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_fstat.__do_sys_newfstatat.do_syscall_64
      1.74 ± 12%      -0.9        0.83 ± 11%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.__x64_sys_pread64
      1.75 ± 12%      -0.9        0.84 ± 11%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.__x64_sys_pread64.do_syscall_64
      2.08 ± 13%      -0.9        1.17 ±  9%  perf-profile.calltrace.cycles-pp.write
      1.78 ± 13%      -0.9        0.88 ± 13%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
      1.77 ± 13%      -0.9        0.87 ± 13%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      1.68 ± 15%      -0.9        0.80 ± 13%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
      1.68 ± 15%      -0.9        0.80 ± 13%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
      1.68 ± 14%      -0.9        0.80 ± 14%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open
      1.68 ± 14%      -0.9        0.81 ± 14%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open.path_openat
      1.90 ± 14%      -0.9        1.02 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      1.88 ± 14%      -0.9        1.00 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.82 ± 15%      -0.9        0.96 ± 11%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.77 ± 15%      -0.8        0.92 ± 11%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.74 ± 15%      -0.8        0.90 ± 12%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.72 ± 15%      -0.8        0.87 ± 12%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_write.ksys_write
      1.73 ± 15%      -0.8        0.89 ± 12%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
      1.32 ±  5%      -0.5        0.80 ±  5%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.31 ±  5%      -0.5        0.80 ±  5%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
      2.72 ±  2%      -0.5        2.24 ±  6%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68 ±  9%      -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.kobject_put.cdev_put.__fput.__x64_sys_close.do_syscall_64
      2.48 ±  2%      -0.4        2.07 ±  5%  perf-profile.calltrace.cycles-pp.get_unmapped_area.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      2.39 ±  2%      -0.4        1.99 ±  6%  perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      2.22 ±  2%      -0.4        1.84 ±  5%  perf-profile.calltrace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap.vm_mmap_pgoff
      1.54 ±  2%      -0.3        1.27 ±  6%  perf-profile.calltrace.cycles-pp.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap
      0.91 ±  8%      -0.2        0.66 ±  6%  perf-profile.calltrace.cycles-pp.cdev_put.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.17 ±  3%      -0.2        0.96 ±  6%  perf-profile.calltrace.cycles-pp.mas_rev_awalk.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area
      0.64 ±  2%      -0.1        0.57 ±  4%  perf-profile.calltrace.cycles-pp.ioctl
      2.80 ±  7%      +1.7        4.48 ±  6%  perf-profile.calltrace.cycles-pp.__libc_pread
      2.65 ±  7%      +1.7        4.35 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pread
      2.63 ±  7%      +1.7        4.33 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      2.58 ±  7%      +1.7        4.29 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      2.79 ±  8%      +1.7        4.50 ±  7%  perf-profile.calltrace.cycles-pp.read
      2.53 ±  8%      +1.7        4.25 ±  7%  perf-profile.calltrace.cycles-pp.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      2.64 ±  9%      +1.7        4.37 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      2.62 ±  9%      +1.7        4.35 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.57 ±  9%      +1.7        4.31 ±  8%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.52 ± 10%      +1.7        4.27 ±  8%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.77 ± 12%      +1.9        3.64 ±  8%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.71 ± 15%      +1.9        3.64 ±  9%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.8        2.79 ±  5%  perf-profile.calltrace.cycles-pp.fsnotify_open_perm.do_dentry_open.do_open.path_openat.do_filp_open
      8.50 ±  7%      -2.8        5.66 ±  4%  perf-profile.children.cycles-pp.__mmap
      7.96 ±  7%      -2.8        5.20 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      6.81 ±  8%      -2.7        4.14 ±  4%  perf-profile.children.cycles-pp.security_file_open
      6.79 ±  8%      -2.7        4.14 ±  4%  perf-profile.children.cycles-pp.apparmor_file_open
      7.48 ±  7%      -2.7        4.83 ±  4%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      5.14 ± 14%      -2.6        2.51 ± 12%  perf-profile.children.cycles-pp.apparmor_file_permission
      5.18 ± 14%      -2.6        2.54 ± 11%  perf-profile.children.cycles-pp.security_file_permission
      4.13 ± 14%      -2.0        2.10 ± 10%  perf-profile.children.cycles-pp.security_mmap_file
      3.55 ± 14%      -1.7        1.81 ± 10%  perf-profile.children.cycles-pp.apparmor_mmap_file
      3.47 ±  8%      -1.5        2.00 ±  6%  perf-profile.children.cycles-pp.alloc_empty_file
      3.15 ±  8%      -1.4        1.72 ±  7%  perf-profile.children.cycles-pp.init_file
      3.06 ±  9%      -1.4        1.64 ±  7%  perf-profile.children.cycles-pp.security_file_alloc
      2.95 ±  9%      -1.4        1.55 ±  8%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      2.18 ± 16%      -1.2        1.02 ± 14%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      2.16 ± 16%      -1.2        1.00 ± 14%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      5.55 ±  7%      -1.1        4.44 ±  5%  perf-profile.children.cycles-pp.fstatat64
      5.27 ±  8%      -1.1        4.20 ±  6%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      4.96 ±  8%      -1.0        3.92 ±  7%  perf-profile.children.cycles-pp.vfs_fstat
      4.78 ±  8%      -1.0        3.77 ±  7%  perf-profile.children.cycles-pp.security_inode_getattr
      4.75 ±  9%      -1.0        3.74 ±  7%  perf-profile.children.cycles-pp.common_perm_cond
      2.16 ± 12%      -0.9        1.25 ±  8%  perf-profile.children.cycles-pp.write
      1.78 ± 13%      -0.9        0.88 ± 13%  perf-profile.children.cycles-pp.security_file_post_open
      1.77 ± 13%      -0.9        0.87 ± 13%  perf-profile.children.cycles-pp.ima_file_check
      1.86 ± 14%      -0.9        1.00 ± 10%  perf-profile.children.cycles-pp.ksys_write
      1.81 ± 15%      -0.8        0.96 ± 10%  perf-profile.children.cycles-pp.vfs_write
      1.32 ±  5%      -0.5        0.80 ±  5%  perf-profile.children.cycles-pp.security_file_free
      1.31 ±  5%      -0.5        0.80 ±  5%  perf-profile.children.cycles-pp.apparmor_file_free_security
      2.73 ±  2%      -0.5        2.25 ±  6%  perf-profile.children.cycles-pp.do_mmap
      2.50 ±  2%      -0.4        2.08 ±  6%  perf-profile.children.cycles-pp.get_unmapped_area
      2.41 ±  2%      -0.4        2.01 ±  6%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      2.24 ±  2%      -0.4        1.86 ±  5%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.52 ± 23%      -0.3        0.23 ± 14%  perf-profile.children.cycles-pp.ima_file_mmap
      1.58 ±  2%      -0.3        1.31 ±  6%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.91 ±  7%      -0.2        0.67 ±  6%  perf-profile.children.cycles-pp.cdev_put
      0.44 ±  3%      -0.2        0.22 ±  6%  perf-profile.children.cycles-pp.__fsnotify_parent
      1.21 ±  3%      -0.2        0.99 ±  6%  perf-profile.children.cycles-pp.mas_rev_awalk
      0.69 ±  9%      -0.2        0.50 ±  6%  perf-profile.children.cycles-pp.kobject_put
      1.13 ±  3%      -0.2        0.96 ±  4%  perf-profile.children.cycles-pp.read_iter_zero
      1.09 ±  3%      -0.2        0.93 ±  4%  perf-profile.children.cycles-pp.iov_iter_zero
      0.96 ±  2%      -0.1        0.82 ±  4%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.76 ±  3%      -0.1        0.64 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.21 ± 24%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.aa_file_perm
      0.31 ±  7%      -0.1        0.20 ±  8%  perf-profile.children.cycles-pp.down_write_killable
      0.75 ±  2%      -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.ioctl
      0.59 ±  2%      -0.1        0.50 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.31 ±  9%      -0.1        0.23 ±  8%  perf-profile.children.cycles-pp.fget
      0.52 ±  3%      -0.1        0.44 ±  5%  perf-profile.children.cycles-pp.stress_full
      0.34            -0.1        0.27 ±  5%  perf-profile.children.cycles-pp.llseek
      0.30 ±  3%      -0.1        0.24 ±  8%  perf-profile.children.cycles-pp.kmem_cache_free
      0.34 ±  2%      -0.0        0.29 ±  6%  perf-profile.children.cycles-pp.mas_prev_slot
      0.29 ±  2%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.16 ±  5%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.16 ±  6%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.07 ±  5%      -0.0        0.03 ± 81%  perf-profile.children.cycles-pp.ksys_lseek
      0.25 ±  3%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.mas_ascend
      0.18            -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.mas_data_end
      0.19 ±  2%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.11 ±  7%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.open_last_lookups
      0.07 ±  4%      -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.mas_prev
      0.11 ±  4%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.__fdget_pos
      0.07 ±  4%      -0.0        0.04 ± 51%  perf-profile.children.cycles-pp.process_measurement
      0.06            -0.0        0.04 ± 65%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.06            -0.0        0.04 ± 33%  perf-profile.children.cycles-pp.amd_clear_divider
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07 ± 10%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.walk_component
      0.35            +0.0        0.40 ±  6%  perf-profile.children.cycles-pp.link_path_walk
     97.57            +0.4       97.94        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.40            +0.4       97.80        perf-profile.children.cycles-pp.do_syscall_64
      2.85 ±  7%      +1.7        4.53 ±  6%  perf-profile.children.cycles-pp.__libc_pread
      2.85 ±  8%      +1.7        4.54 ±  7%  perf-profile.children.cycles-pp.read
      2.59 ±  7%      +1.7        4.30 ±  7%  perf-profile.children.cycles-pp.__x64_sys_pread64
      2.58 ±  9%      +1.7        4.31 ±  8%  perf-profile.children.cycles-pp.ksys_read
      0.00            +2.8        2.80 ±  5%  perf-profile.children.cycles-pp.fsnotify_open_perm
      5.23 ± 14%      +3.0        8.19 ±  8%  perf-profile.children.cycles-pp.rw_verify_area
      5.06 ±  8%      +3.5        8.53 ±  7%  perf-profile.children.cycles-pp.vfs_read
      6.77 ±  8%      -2.6        4.12 ±  4%  perf-profile.self.cycles-pp.apparmor_file_open
      5.01 ± 14%      -2.6        2.44 ± 12%  perf-profile.self.cycles-pp.apparmor_file_permission
      3.45 ± 13%      -1.7        1.77 ± 10%  perf-profile.self.cycles-pp.apparmor_mmap_file
      2.93 ±  9%      -1.4        1.54 ±  8%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      2.14 ± 16%      -1.2        0.99 ± 14%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      4.74 ±  9%      -1.0        3.73 ±  7%  perf-profile.self.cycles-pp.common_perm_cond
      1.31 ±  5%      -0.5        0.79 ±  5%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.43 ±  3%      -0.2        0.21 ±  5%  perf-profile.self.cycles-pp.__fsnotify_parent
      1.07 ±  3%      -0.2        0.88 ±  6%  perf-profile.self.cycles-pp.mas_rev_awalk
      0.68 ±  9%      -0.2        0.50 ±  6%  perf-profile.self.cycles-pp.kobject_put
      0.95 ±  2%      -0.1        0.81 ±  4%  perf-profile.self.cycles-pp.rep_stos_alternative
      0.20 ± 25%      -0.1        0.10 ± 14%  perf-profile.self.cycles-pp.aa_file_perm
      0.28 ±  8%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.down_write_killable
      0.57 ±  3%      -0.1        0.48 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.31 ±  8%      -0.1        0.22 ±  9%  perf-profile.self.cycles-pp.fget
      0.50 ±  3%      -0.1        0.43 ±  5%  perf-profile.self.cycles-pp.stress_full
      0.22 ±  6%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.cdev_put
      0.15 ±  5%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.24 ±  4%      -0.0        0.20 ±  6%  perf-profile.self.cycles-pp.mas_empty_area_rev
      0.28 ±  3%      -0.0        0.24 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.24 ±  3%      -0.0        0.20 ±  6%  perf-profile.self.cycles-pp.mas_ascend
      0.18 ±  3%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.do_mmap
      0.14 ±  5%      -0.0        0.11 ± 12%  perf-profile.self.cycles-pp.chrdev_open
      0.19 ±  2%      -0.0        0.15 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.20 ±  3%      -0.0        0.17 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.20 ±  4%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.vfs_read
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.16 ±  2%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.mas_data_end
      0.07 ±  4%      -0.0        0.04 ± 50%  perf-profile.self.cycles-pp.process_measurement
      0.16 ±  3%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.vm_unmapped_area
      0.12 ±  4%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp.mas_prev_slot
      0.14 ±  2%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      0.10 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.open64
      0.15 ±  2%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.15 ±  2%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.ioctl
      0.09 ±  5%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.write
      0.07 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.__close
      0.11 ±  4%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.link_path_walk
      0.01 ±200%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.75 ±  2%      +0.1        0.89 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +2.8        2.79 ±  5%  perf-profile.self.cycles-pp.fsnotify_open_perm
      0.05            +5.6        5.63 ± 10%  perf-profile.self.cycles-pp.rw_verify_area


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s/lkp-csl-d02/fsbuffer-r/unixbench

commit: 
  477cf917dd ("fsnotify: use an enum for group priority constants")
  a5e57b4d37 ("fsnotify: optimize the case of no permission event watchers")

477cf917dd02853b a5e57b4d370c6d320e5bfb0c919 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1339661            +6.4%    1425877        unixbench.throughput
 5.765e+08            +6.4%  6.131e+08        unixbench.workload
 1.159e+09            +2.2%  1.184e+09        perf-stat.i.branch-instructions
      1.49            +0.0        1.54        perf-stat.i.branch-miss-rate%
  10449249 ±  2%      +6.7%   11149426        perf-stat.i.branch-misses
      4514            -5.3%       4273        perf-stat.overall.path-length
 1.156e+09            +2.2%  1.181e+09        perf-stat.ps.branch-instructions
  10430168 ±  2%      +6.7%   11128869        perf-stat.ps.branch-misses
      7.02 ±  2%      -3.3        3.70 ±  3%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.45 ±  3%      +0.2        1.62 ±  3%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      1.24 ±  3%      +0.2        1.44 ±  3%  perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.filemap_read.vfs_read
      2.55 ±  8%      +0.4        2.91 ±  4%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
      3.04 ±  6%      +0.4        3.44 ±  3%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
      1.94 ±  9%      +0.5        2.42 ±  3%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      8.62 ±  3%      +0.5        9.14        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      7.90 ±  2%      +0.6        8.51        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      9.29 ±  2%      +0.8       10.04        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      4.43 ±  7%      +0.8        5.28 ±  2%  perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read
     29.04 ±  3%      +1.8       30.80        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.06 ±  2%      -3.3        3.73 ±  3%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.77 ±  6%      +0.1        0.88 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.26 ±  2%      +0.2        1.45 ±  3%  perf-profile.children.cycles-pp.current_time
      1.66 ±  3%      +0.2        1.90 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.72 ±  2%      +0.3        4.03        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.56 ±  7%      +0.4        2.91 ±  4%  perf-profile.children.cycles-pp.apparmor_file_permission
      5.72 ±  2%      +0.4        6.08        perf-profile.children.cycles-pp.entry_SYSCALL_64
      4.40 ±  4%      +0.4        4.81 ±  2%  perf-profile.children.cycles-pp.rep_movs_alternative
      3.10 ±  6%      +0.4        3.52 ±  3%  perf-profile.children.cycles-pp.security_file_permission
      1.94 ±  9%      +0.5        2.42 ±  3%  perf-profile.children.cycles-pp.__fdget_pos
      8.68 ±  3%      +0.5        9.20        perf-profile.children.cycles-pp.filemap_get_pages
      8.37 ±  2%      +0.7        9.05        perf-profile.children.cycles-pp._copy_to_iter
      9.52 ±  2%      +0.8       10.28        perf-profile.children.cycles-pp.copy_page_to_iter
     29.25 ±  3%      +1.7       30.99        perf-profile.children.cycles-pp.filemap_read
      6.94            -3.2        3.72 ±  3%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.77 ±  6%      +0.1        0.88 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.83 ±  5%      +0.1        0.97 ±  7%  perf-profile.self.cycles-pp.current_time
      1.66 ±  3%      +0.2        1.90 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      3.52 ±  2%      +0.2        3.76        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.42 ±  3%      +0.3        2.67 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.92 ±  6%      +0.3        2.20 ±  5%  perf-profile.self.cycles-pp.apparmor_file_permission
      3.92 ±  4%      +0.3        4.25 ±  2%  perf-profile.self.cycles-pp.rep_movs_alternative
      4.38            +0.3        4.72 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      1.16 ±  8%      +0.3        1.51 ±  2%  perf-profile.self.cycles-pp.ksys_read
      1.85 ± 10%      +0.5        2.36 ±  2%  perf-profile.self.cycles-pp.__fdget_pos



***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s/lkp-csl-d02/fstime-r/unixbench

commit: 
  477cf917dd ("fsnotify: use an enum for group priority constants")
  a5e57b4d37 ("fsnotify: optimize the case of no permission event watchers")

477cf917dd02853b a5e57b4d370c6d320e5bfb0c919 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4709035            +5.8%    4980152        unixbench.throughput
 2.026e+09            +5.7%  2.141e+09        unixbench.workload
 1.034e+09            +1.4%  1.048e+09        perf-stat.i.branch-instructions
      1.56            +0.0        1.59        perf-stat.i.branch-miss-rate%
  60950726            +5.3%   64193405        perf-stat.i.cache-references
      0.02 ± 30%     -36.7%       0.01 ± 39%  perf-stat.i.major-faults
      0.78            -0.0        0.75        perf-stat.overall.cache-miss-rate%
      1145            -5.4%       1083        perf-stat.overall.path-length
 1.031e+09            +1.4%  1.046e+09        perf-stat.ps.branch-instructions
  60812120            +5.3%   64047513        perf-stat.ps.cache-references
      0.02 ± 30%     -36.7%       0.01 ± 39%  perf-stat.ps.major-faults
      6.22 ±  3%      -2.9        3.30 ±  3%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.43            -1.5       47.90        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     52.39            -1.0       51.34        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     55.16            -0.9       54.29        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     56.49            -0.7       55.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      2.40 ±  4%      +0.2        2.64 ±  5%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_read.vfs_read.ksys_read
      2.59 ±  4%      +0.3        2.86 ±  5%  perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
      6.88            +0.3        7.23 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      2.26 ±  3%      +0.4        2.64 ± 10%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
      7.90 ±  3%      +0.4        8.29        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      2.68 ±  2%      +0.4        3.13 ±  8%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
      8.47            +0.4        8.91        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
     32.80            +1.8       34.63        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.27 ±  3%      -2.9        3.34 ±  3%  perf-profile.children.cycles-pp.__fsnotify_parent
     49.50            -1.4       48.07        perf-profile.children.cycles-pp.vfs_read
     52.46            -1.0       51.45        perf-profile.children.cycles-pp.ksys_read
      1.16 ±  4%      +0.1        1.28 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.46 ±  4%      +0.2        2.69 ±  6%  perf-profile.children.cycles-pp.atime_needs_update
      5.03 ±  3%      +0.3        5.30        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.66 ±  4%      +0.3        2.94 ±  6%  perf-profile.children.cycles-pp.touch_atime
      3.27 ±  2%      +0.3        3.59        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      6.96            +0.4        7.31 ±  2%  perf-profile.children.cycles-pp.filemap_get_read_batch
      2.27 ±  3%      +0.4        2.64 ± 10%  perf-profile.children.cycles-pp.apparmor_file_permission
      2.76 ±  2%      +0.4        3.20 ±  7%  perf-profile.children.cycles-pp.security_file_permission
      8.52            +0.5        8.98        perf-profile.children.cycles-pp.filemap_get_pages
     32.99            +1.8       34.80        perf-profile.children.cycles-pp.filemap_read
      6.16 ±  3%      -2.8        3.32 ±  3%  perf-profile.self.cycles-pp.__fsnotify_parent
      1.19 ±  3%      -0.4        0.81 ±  6%  perf-profile.self.cycles-pp.rw_verify_area
      1.55 ±  3%      +0.1        1.64 ±  2%  perf-profile.self.cycles-pp.filemap_get_pages
      0.70 ±  3%      +0.1        0.81 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.31 ±  4%      +0.1        1.43 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      2.15 ±  4%      +0.1        2.28        perf-profile.self.cycles-pp.entry_SYSCALL_64
      4.00 ±  2%      +0.2        4.22        perf-profile.self.cycles-pp.read
      1.06 ±  4%      +0.3        1.31 ±  5%  perf-profile.self.cycles-pp.ksys_read
      3.09 ±  2%      +0.3        3.36        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.89 ±  2%      +0.3        4.19 ±  3%  perf-profile.self.cycles-pp._copy_to_iter
      1.66 ±  2%      +0.3        2.01 ± 13%  perf-profile.self.cycles-pp.apparmor_file_permission





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


