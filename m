Return-Path: <linux-fsdevel+bounces-27327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480AB960487
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E262E28415F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C6197A83;
	Tue, 27 Aug 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/dXeabn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51F198A2A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747670; cv=fail; b=ZPQinxm0JAogaG4p2Y9kQkXVj4BXJreblYN6eHkVlL9Cb2u4J/uvPYpRlC7Ox/WZFmoEm4G6r7WXTREXDhJz5s55dAMo4fIeENI3OAIeArI0Y1FdPNeI3stXy1Iq6zH+4HfSs97XM+nZatZBprsTJe8lCpUTBkz8aCqRM1ps1nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747670; c=relaxed/simple;
	bh=ngebz335swirqcMlJ1f93ctHR93XK+nGJgFrxSUD55c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=o2t+Zwr9xlmhCL7LfSCklhNfbjZIWqIChSuIHRD9124atPGy78dJCEEN4P460c3MfIx7xJytTpOc0wrVmNHxYBDc0Tj78aG8MlFb5UTQxEG8rJrftOuRis2FwjdsH5smyzGQ18wSKUD7mU5lyCORb+P/ReRCjNnvlW/GDFz3zQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/dXeabn; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724747658; x=1756283658;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ngebz335swirqcMlJ1f93ctHR93XK+nGJgFrxSUD55c=;
  b=A/dXeabn5k5Hclki6xPHfPwmChAjeWouA2ce6eWxLFaDdJhTTErENF3d
   ZDWBtaTacbxG9Dlkq14gHScFCVqbU2/OPCgAW1Jx2OIjolU/CEPvZ32eW
   yDKqwUa0HnckP0DEG8dn64NJ9wRrh1lp0ov/E+e4IsE4ORPdrOWN/Ou8G
   3DqIHFTLVR50ghIk8UZNG8wRCPhpHwEZqeVhWWMPdAxljA7x8zkupl3gU
   0SjxkqpO0047gNHyagYtlDaj+h85a8OeDo0EiZSAlwGzERlspU+2+Q43U
   otEzR0YcaIRJEXucH4ogY8fqQpw2NaDfUuUiVDGPCLQXZaTfwwLiy5D7Y
   A==;
X-CSE-ConnectionGUID: iogekToIQiOK+V/+YQl98Q==
X-CSE-MsgGUID: 3V+VWywDRua77gH8OZNHNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34618854"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="34618854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:34:17 -0700
X-CSE-ConnectionGUID: klbtBwmLS9aScjeyokJzMg==
X-CSE-MsgGUID: /jU6GZ4ISB+gHlwxs7/0WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93586666"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 01:34:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 01:34:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 01:34:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 01:34:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 01:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALqf4gPj/qdZYWreoMkouVRnC9DBJbWszILjnz16wT6MY2ah7ka0s/wPIT0ud47i7FMaFD7sT9OPh+lrYMaKmW8OuvKb20YAS6MMc4EyLwErhCt7LKZyEcPPnblIMumLQXkeH+mqfCFEyLQfiM6vVWHltafEotvmRhmV4TLylnJk2Pnac9OEPNMQ8a64nP+vcT+JY6pIGRoHVFPwsCZgi/2ivpQcis57hEk/HU3+tTag7KrKkluRYNhGQTr63p8rrtrnxpl3S/7i9jWoGwFW4Ngbf53PGFbHoh0upKo+GUgUSp1vKpt+SlkXyqqqw2/wUyGsFGbCmZvGo6sdZzszOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM9uyDlQn6dCvp9+N+CNqZfhVn9yEtXMsWXkYi5Vhpw=;
 b=ZhMbJA0AZ0I1PvMVE2isAWdewUUkSi/hDGfbMBxEaHMaq7sydzvwmjjLhQpma3ZYhJXRMiEOwvIwkZgVfYtY6aKaHeMRTnVXkBrzKNIYyLhSrKd14krxlIB6DED4qfbQNrCrmjqzluznLay5ja2EpYDpr0Gl/8zVlzff8+ptnQYqiwBqhXL6+sd800KPbPzV8SWglL+h0NeCex+uhavAMCbFYFTfVWf6H3Or0AnWK4uHa1OLIYOWhuVYa7LlPd5hYznCcXqRu2a8TQboMPPKEQpFmTj8tbgRZm0ymvph9cZSdzsnIJQ3IY8kDZHqBYULcif2H4XESFPwve/iYLxYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 08:34:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:34:07 +0000
Date: Tue, 27 Aug 2024 16:33:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [brauner-vfs:work.dio] [fs]  155a115703:  fio.write_iops -2.3%
 regression
Message-ID: <202408271524.6ecfb631-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb3aedd-1855-4766-8b40-08dcc673036f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?dD7WUDhid/5XCPG+xZtsa66IbZNL71xGtabCfjP8PIfdIVAlxw5UqWa4dI?=
 =?iso-8859-1?Q?xaLfKaNlv9Tv5FJf4yT+35Mae/YqHWJNoDiAzjWcDqpp2+GferMa2eCSW2?=
 =?iso-8859-1?Q?vkdrvQU2n1m590y5ZrOKa/RF4v8xv/T6pAyifL8HpW3hkNthVlIzFqRgLt?=
 =?iso-8859-1?Q?OQfxs4enR6getzKeUHc33Jg5O1XEZpkadRTJoGP8dhBp0wVnqc+7px5rt5?=
 =?iso-8859-1?Q?93IY0znYCRQ7t9P5CpzfMuqwW85zQTyN8ixHC0QCgZcZzeLvR/67CZVbwI?=
 =?iso-8859-1?Q?PgJzFD/TS0dvpz20QbolU8EypK9Rc9YjtX/9PvZjI8pYDWba8Wu5yhIqUF?=
 =?iso-8859-1?Q?281gI9bE6BJpQE/xuLwZYR7tsLGor6wKX/KNugJLJ9jY9/okej5Jpwx2sW?=
 =?iso-8859-1?Q?kiF95bP1yE0Rky+RBgCJN5i2Cr17bA93WBbWRvUa9bSyhM3BT0d3j/x7aO?=
 =?iso-8859-1?Q?e8OWCvptN3duO/x7XHxTbT6uqdfyhGKCnJG/ztAVx0V5tu9uFtqghwKem1?=
 =?iso-8859-1?Q?Jkf8QUznADy2WNN9uefH0KhVK6rECEyWjHuKnvRqIazbflGvjNXW7Js2pL?=
 =?iso-8859-1?Q?jySjNz3qTtffp1H0GS1GnCwJ2uh7j0nMGLW4jI3LclGycVOUhwgXdsNliD?=
 =?iso-8859-1?Q?DJztLslGw8Pv5fU3r5xzDUYZsr/rKzXfCgmOt+HJCge8bWSBeCW1zKR7bq?=
 =?iso-8859-1?Q?C4pkitMs+/+DDF3y7As3Re4KGM/yHkt4P0WvraZDKUT8rnypFo96PD553r?=
 =?iso-8859-1?Q?71p4w8Ttam0VeufTMbO4mKiso1ybX1TxNzlgpsswn2fvCwD94ZTmazvJrH?=
 =?iso-8859-1?Q?Fxh9OOM0q1HmDACY4cjdLD9UA6KL1i/q+vhK6xhSTVVauiX2LK0R05OFo/?=
 =?iso-8859-1?Q?K8fOiUSDEYV+uR/3BuTfdsDnGdn9B9xcsmQ9yvmdCMVdnh2A+UBnf/9SfG?=
 =?iso-8859-1?Q?JGxuBHavNe3nli6j/kzQSBFWXkxbinxkXwDYd8x1ZI7+Cjs4uP0xRZ+wRq?=
 =?iso-8859-1?Q?UFZ17aXXBG1umiGD66nJRS5PjRslwOwRJS/E7oYe3roHnm8hUfa24z6aCy?=
 =?iso-8859-1?Q?YGWparaKrIfM2cOy31KvyiUrB89gZ+bc7xJMcytxZ76aNeLEL+6jL5MO+2?=
 =?iso-8859-1?Q?2B4jcky4wyn+Pl88ezgRLmfj3CRB9WG9w5qPn/WD0UENJRu4ShBit+UQHM?=
 =?iso-8859-1?Q?WOYDVJUvueEwsh6FxSQYg1bC2JFHsotl4v1QHkVWPR4aDolHJG/ZT84Sjj?=
 =?iso-8859-1?Q?3IbSUgzuygKtNibgIui1blNrNpDh/Y1JRsJFO09vVF8toyA0c8WV5fib6W?=
 =?iso-8859-1?Q?V4X8S6RtGx2vjHHVB2LefQRsH7iasv+CWCWb/ju38dcp0WXRuxVDhs02Na?=
 =?iso-8859-1?Q?YBrlX8EprK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sycdR8hmH9B2f3G+XQOyUc7lbcWR+PouDObLe2c+wKJ3MvfOgBUaNgMa0X?=
 =?iso-8859-1?Q?e9s87BrjpZZQOYsv23fXj6diTuNszhI2UhSDDYlW7c6AbcKejLTeCSxjCc?=
 =?iso-8859-1?Q?ItHQVvxMeVtwLg3i0ETsOHkxj6gGej/VDuoMrr8RnTIbW4e7x4aQes3EQt?=
 =?iso-8859-1?Q?WSuEPzOp4+u+tOLrO5+f5xErnSIVCaBx/PdVO3qIMO5WCVf8yFOJBWAKpJ?=
 =?iso-8859-1?Q?zA8A1/Zl2dbd7nrFwmOJMQZmF5sJqx6+IueEhsYi+YjhfkihWlJzNQQ8s+?=
 =?iso-8859-1?Q?AUNB2n6xx3Hmrbn3ZYqsug72WLxddXzVoKhmiZ0cQtkPGdyRZj16Ld5K6d?=
 =?iso-8859-1?Q?yWo4KDvS3iXnTjLx7F8VQSrETT3nHmgOBy9KXGsb0EgOgT8IoZgCgKTztp?=
 =?iso-8859-1?Q?1vZob/uEZmCRBJcZknZN5R8GtExTA+BA1hA/AaxVM6jYi741/l6ublIQt6?=
 =?iso-8859-1?Q?AnCNIITemuQarA9u2bPBM6Hh+j6i3t94s1PUwxMaM6SXucGRmvZiRKPk9a?=
 =?iso-8859-1?Q?QCSF6Aj7m8QS3kpU8XwsxJKk8zFfiTZAOhpBxxGjJlJY96JmWcq5g3OJZH?=
 =?iso-8859-1?Q?KugcMIrsdiGZg6Y2xW/TVaBjdc7XgzbbUGTQFRg7bJAiVF6YypFsyuPxXz?=
 =?iso-8859-1?Q?+65jv13IWaUX/G2/0Ky5zfYEOwK8/790FUnMHRKsida9a503zdc/1pCc8E?=
 =?iso-8859-1?Q?z0cggUXGln7DGWje6nZ9npMsSgn7kBEMr8o6WMDq7Qzbo5eQUb9PMr7kTd?=
 =?iso-8859-1?Q?8O2xwUHBK1wjdkYCMIfvR4vGqHDQhACFQEoebcfhck4SklUtha0mNgimaO?=
 =?iso-8859-1?Q?qq0aX+FWDX5WUf/JRrZlBQh9jmRE1dmWX2DI5vSTDlOkJfwj6/mT4BuaDB?=
 =?iso-8859-1?Q?qTt0SqoZ6ZcIYyHCfBefpTOXdqoongCI20WMP0pTXWjh4KCRbVXSN+Hzfd?=
 =?iso-8859-1?Q?X/HpmStlYdFzHfucjmClrxxV4qdm3frnHgzjEcUCHs7lW+i4K6geYuZOar?=
 =?iso-8859-1?Q?IrjaDDZp4/4l3dEBAsFU/vfTaZsKi1Oo/ZoHE1xainWLmiUCCIWs7whFwM?=
 =?iso-8859-1?Q?D2EX1Mc8dUx+8D8iViTPvNE8xQxflOluakrhgjAliE3Z8Mldwd2LA3BFqK?=
 =?iso-8859-1?Q?QHUUmdnEPDsPjvUFMYjO5N95DKtWiHzvt2srTE/E0lWvaTh6sUkbrjPodP?=
 =?iso-8859-1?Q?1EiS+YnfDLbMTiZDCLrhFAVQI8G72PhMD3+hFt8fMADuO6VTeFY8kmjzEO?=
 =?iso-8859-1?Q?U5DFDDOe37/2w5mDPUsdGMPLxn1iSWcfgLM9pmljtytxoZhcRz2F7TD8oV?=
 =?iso-8859-1?Q?LbSlU/lLdu/4NSG5gke9e9USl6BFXSJmHTbmCPYw+iLS8mEsqwZN5boCJm?=
 =?iso-8859-1?Q?3DCLJ7jPYdJhfKOahdbDm8SfIuBP2IlQu9bGxI+HkuA3/59OKcfPJh7ZKW?=
 =?iso-8859-1?Q?X6B/PNYHfJVHmzOkvDIIOd1owTDBC/hLGFOmClFJ01HGruZ6rv3pjHFHeu?=
 =?iso-8859-1?Q?Ddu77H1NONK4GwlwJj2ZcFy3MDThJG2rPf4byTsoiBSbz4anubp5LZspwo?=
 =?iso-8859-1?Q?/bMsIWK7cPko19HAJMqrrq31Vt13XmBxSH7RrZr6VRdQkrInBhhVoPnjwl?=
 =?iso-8859-1?Q?yIbfT+pUdar18rTRG1CKeCfO7nOPXvoGuqLv9TTdF5hh+G3C3SqK0ojA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb3aedd-1855-4766-8b40-08dcc673036f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 08:34:07.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8yikY1HKM0YLx5aB8IF+qE4TEfLKw1RPeKd3Xj/zCejjuS9LgfHExESrcrQgDfnFqsGXk6J7uFJ2Glp3YRpYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -2.3% regression of fio.write_iops on:


commit: 155a11570398943dcb623a2390ac27f9eae3d8b3 ("fs: remove audit dummy context check")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.dio

testcase: fio-basic
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	disk: 1HDD
	fs: ext4
	nr_task: 1
	test_size: 128G
	rw: write
	bs: 4k
	ioengine: ftruncate
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408271524.6ecfb631-oliver.sang@intel.com


hi, Christian Brauner,

we do not really understand why this change could cause this small regression
in our tests, but in below detail compare table, we noticed below perf-profile
data seem relate the changes in 155a115703.

just FYI what we observed in our tests.


	       0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
	       0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
	       0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
	       0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.try_to_unlazy_next.lookup_fast.open_last_lookups.path_openat
	       0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.try_to_unlazy_next.lookup_fast.open_last_lookups.path_openat.do_filp_open
	       0.50 ±224%      +0.0        0.51 ±225%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
	       0.23 ±331%      +0.2        0.43 ±224%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.open_last_lookups.path_openat.do_filp_open
	       0.46 ±223%      +0.2        0.66 ±173%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
	       0.96 ±184%      +0.2        1.17 ±119%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
	       0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
	       0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
	       0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
	       0.27 ±331%      +0.2        0.51 ±225%  perf-profile.calltrace.cycles-pp.proc_pid_make_inode.proc_pident_instantiate.proc_pident_lookup.lookup_open.open_last_lookups
	       0.27 ±331%      +0.2        0.51 ±225%  perf-profile.calltrace.cycles-pp.proc_pident_instantiate.proc_pident_lookup.lookup_open.open_last_lookups.path_openat
	       0.27 ±331%      +0.2        0.51 ±225%  perf-profile.calltrace.cycles-pp.proc_pident_lookup.lookup_open.open_last_lookups.path_openat.do_filp_open
	       0.96 ±184%      +0.2        1.17 ±119%  perf-profile.children.cycles-pp.open_last_lookups

Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240827/202408271524.6ecfb631-oliver.sang@intel.com

=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
  4k/gcc-12/performance/1HDD/ext4/ftruncate/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s/write/lkp-icl-2sp9/128G/fio-basic

commit: 
  ac4db27567 ("fs: pull up trailing slashes check for O_CREAT")
  155a115703 ("fs: remove audit dummy context check")

ac4db275670c1311 155a11570398943dcb623a2390a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 2.543e+09            +2.8%  2.614e+09        cpuidle..time
    193795 ±  5%      -0.3%     193198 ±  5%  cpuidle..usage
    204.96            +0.1%     205.08        uptime.boot
     12702            +0.1%      12710        uptime.idle
     35.68            +0.1%      35.71        boot-time.boot
     25.33            -0.5%      25.20        boot-time.dhcp
      2072            +0.1%       2074        boot-time.idle
     98.21            +0.0%      98.21        iostat.cpu.idle
      0.08 ±  6%      -0.3%       0.08 ±  6%  iostat.cpu.iowait
      1.20            +0.9%       1.21        iostat.cpu.system
      0.52 ±  2%      -3.8%       0.50        iostat.cpu.user
      7.50 ± 34%     +31.1%       9.83 ± 35%  perf-c2c.DRAM.local
     34.17 ± 26%     -16.1%      28.67 ± 22%  perf-c2c.DRAM.remote
     26.83 ± 23%      +5.6%      28.33 ± 31%  perf-c2c.HITM.local
     14.50 ± 43%     -10.9%      12.92 ± 32%  perf-c2c.HITM.remote
     41.33 ± 18%      -0.2%      41.25 ± 23%  perf-c2c.HITM.total
     98.22            -0.0       98.22        mpstat.cpu.all.idle%
      0.05 ± 13%      +0.0        0.05 ± 10%  mpstat.cpu.all.iowait%
      0.01 ±  9%      +0.0        0.01 ± 12%  mpstat.cpu.all.irq%
      0.01 ± 32%      -0.0        0.01 ± 35%  mpstat.cpu.all.soft%
      1.21            +0.0        1.22        mpstat.cpu.all.sys%
      0.51            -0.0        0.50        mpstat.cpu.all.usr%
      2.00            +0.0%       2.00        mpstat.max_utilization.seconds
      5.19 ±  4%      +1.3%       5.26 ±  3%  mpstat.max_utilization_pct
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
    101572 ± 23%      -6.5%      94966 ± 20%  numa-numastat.node0.local_node
    120867 ± 14%      +5.9%     128032 ± 11%  numa-numastat.node0.numa_hit
     19295 ±102%     +71.4%      33066 ± 69%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
     84261 ± 27%     +10.3%      92930 ± 21%  numa-numastat.node1.local_node
    131179 ± 13%      -3.9%     126075 ± 12%  numa-numastat.node1.numa_hit
     46917 ± 42%     -29.4%      33145 ± 69%  numa-numastat.node1.other_node
     38.65            +2.3%      39.55        time.elapsed_time
     38.65            +2.3%      39.55        time.elapsed_time.max
    323.83 ± 23%      -5.3%     306.58 ± 26%  time.involuntary_context_switches
     10388 ±  3%      +1.2%      10511        time.maximum_resident_set_size
      2331            -0.1%       2330        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
    101.33            +0.1%     101.42        time.percent_of_cpu_this_job_got
     28.75            +3.3%      29.70        time.system_time
     10.60            -0.3%      10.57 ±  2%  time.user_time
      4151            +2.4%       4249        time.voluntary_context_switches
     97.90            +0.0%      97.91        vmstat.cpu.id
      1.01            +0.2%       1.02        vmstat.cpu.sy
      0.15 ± 16%      -6.0%       0.14 ±  7%  vmstat.cpu.us
      0.03 ± 34%      -8.5%       0.03 ± 32%  vmstat.cpu.wa
      3.00           -18.3%       2.45 ± 43%  vmstat.io.bi
    202.31            -2.1%     198.10        vmstat.io.bo
      5547            +5.8%       5867 ± 12%  vmstat.memory.buff
   3247661            -0.0%    3247524        vmstat.memory.cache
 2.591e+08            +0.0%  2.591e+08        vmstat.memory.free
      0.01 ±141%     +22.7%       0.01 ±118%  vmstat.procs.b
      2.64            -1.2%       2.61 ±  2%  vmstat.procs.r
      2747 ±  4%      -0.2%       2743 ±  5%  vmstat.system.cs
      6250 ±  2%      -3.7%       6017 ±  4%  vmstat.system.in
      0.01 ± 44%      +0.0        0.01 ± 30%  fio.latency_100us%
      0.01 ± 41%      -0.0        0.01 ± 13%  fio.latency_10us%
      0.01            +0.0        0.01        fio.latency_20us%
      0.01            +0.0        0.01        fio.latency_250us%
      0.01 ± 84%      +0.0        0.01 ± 84%  fio.latency_2ms%
      0.05 ± 14%      +0.3        0.40 ± 76%  fio.latency_2us%
      0.01            +0.0        0.01        fio.latency_4ms%
      0.09 ±  7%      +0.0        0.09 ±  3%  fio.latency_4us%
      0.01 ± 84%      -0.0        0.01 ±100%  fio.latency_500us%
      0.01            +0.0        0.01        fio.latency_50us%
      0.00 ±173%      -0.0        0.00 ±331%  fio.latency_750us%
     38.65            +2.3%      39.55        fio.time.elapsed_time
     38.65            +2.3%      39.55        fio.time.elapsed_time.max
    323.83 ± 23%      -5.3%     306.58 ± 26%  fio.time.involuntary_context_switches
     10388 ±  3%      +1.2%      10511        fio.time.maximum_resident_set_size
      2331            -0.1%       2330        fio.time.minor_page_faults
      4096            +0.0%       4096        fio.time.page_size
    101.33            +0.1%     101.42        fio.time.percent_of_cpu_this_job_got
     28.75            +3.3%      29.70        fio.time.system_time
     10.60            -0.3%      10.57 ±  2%  fio.time.user_time
      4151            +2.4%       4249        fio.time.voluntary_context_switches
  33554432            +0.0%   33554432        fio.workload
      3418            -2.3%       3340        fio.write_bw_MBps
    951.33            +2.5%     974.67        fio.write_clat_90%_ns
    954.67            +2.6%     979.33        fio.write_clat_95%_ns
    963.33            +2.8%     990.00        fio.write_clat_99%_ns
    942.72            +2.6%     967.66        fio.write_clat_mean_ns
    589.05 ±  8%      +4.2%     613.57 ±  9%  fio.write_clat_stddev
    875228            -2.3%     855211        fio.write_iops
     18261            -0.0%      18256        meminfo.Active
      2983            +0.2%       2989        meminfo.Active(anon)
     15278            -0.1%      15266        meminfo.Active(file)
    245803 ±  2%      -0.3%     245102        meminfo.AnonHugePages
    654066            -0.0%     653992        meminfo.AnonPages
      7408            -0.1%       7402        meminfo.Buffers
   3170033            -0.0%    3169990        meminfo.Cached
 1.319e+08            +0.0%  1.319e+08        meminfo.CommitLimit
    984567            -0.3%     981771        meminfo.Committed_AS
 2.552e+08            -0.1%   2.55e+08        meminfo.DirectMap1G
  14757034 ± 10%      +1.8%   15027200 ±  8%  meminfo.DirectMap2M
    180990 ±  9%      -4.4%     172969 ±  9%  meminfo.DirectMap4k
      2590 ± 30%      -1.7%       2547 ± 35%  meminfo.Dirty
      2048            +0.0%       2048        meminfo.Hugepagesize
    662047            -0.0%     661938        meminfo.Inactive
    657122            -0.0%     657028        meminfo.Inactive(anon)
      4924 ±  2%      -0.3%       4909 ±  3%  meminfo.Inactive(file)
     92477            -0.1%      92395        meminfo.KReclaimable
     14535            -0.2%      14507        meminfo.KernelStack
     34421            +0.3%      34522        meminfo.Mapped
 2.575e+08            -0.0%  2.575e+08        meminfo.MemAvailable
 2.586e+08            -0.0%  2.586e+08        meminfo.MemFree
 2.638e+08            +0.0%  2.638e+08        meminfo.MemTotal
   5183137            +0.1%    5186083        meminfo.Memused
      6463            +0.6%       6501        meminfo.PageTables
     26274            -0.4%      26171        meminfo.Percpu
     92477            -0.1%      92395        meminfo.SReclaimable
    167699            +0.1%     167816        meminfo.SUnreclaim
     10280            +0.0%      10280        meminfo.SecPageTables
     15591            -0.2%      15562        meminfo.Shmem
    260177            +0.0%     260212        meminfo.Slab
   3150635            -0.0%    3150635        meminfo.Unevictable
 1.374e+13            +0.0%  1.374e+13        meminfo.VmallocTotal
    246543            -0.0%     246506        meminfo.VmallocUsed
   5207221            -0.0%    5205293        meminfo.max_used_kB
      0.04 ±  7%      +3.4%       0.04 ±  8%  perf-stat.i.MPKI
 1.636e+09            -2.3%  1.598e+09        perf-stat.i.branch-instructions
      0.35            +0.1        0.45        perf-stat.i.branch-miss-rate%
   6390545           +23.6%    7896679        perf-stat.i.branch-misses
     10.35 ± 15%      +0.7       11.10 ± 16%  perf-stat.i.cache-miss-rate%
    328247 ±  8%      +1.1%     331825 ±  9%  perf-stat.i.cache-misses
   2351375 ±  5%      -3.0%    2280367 ±  6%  perf-stat.i.cache-references
      2535 ±  5%      -0.1%       2533 ±  6%  perf-stat.i.context-switches
      0.50            +2.1%       0.51        perf-stat.i.cpi
     64009            +0.0%      64012        perf-stat.i.cpu-clock
 4.005e+09            -0.3%  3.995e+09        perf-stat.i.cpu-cycles
     73.90            -0.1%      73.82        perf-stat.i.cpu-migrations
     29023 ± 21%      -4.6%      27701 ± 20%  perf-stat.i.cycles-between-cache-misses
     8e+09            -2.3%  7.813e+09        perf-stat.i.instructions
      2.06            -2.2%       2.02        perf-stat.i.ipc
      0.00 ±223%    +150.3%       0.01 ±206%  perf-stat.i.major-faults
      2536            +0.3%       2543        perf-stat.i.minor-faults
      2536            +0.3%       2543        perf-stat.i.page-faults
     64009            +0.0%      64012        perf-stat.i.task-clock
      0.04 ±  8%      +3.5%       0.04 ±  9%  perf-stat.overall.MPKI
      0.39            +0.1        0.50        perf-stat.overall.branch-miss-rate%
     14.00 ±  8%      +0.6       14.63 ± 11%  perf-stat.overall.cache-miss-rate%
      0.50            +2.1%       0.51        perf-stat.overall.cpi
     12274 ±  8%      -1.2%      12132 ± 10%  perf-stat.overall.cycles-between-cache-misses
      2.00            -2.1%       1.96        perf-stat.overall.ipc
      9223            +0.6%       9283        perf-stat.overall.path-length
 1.595e+09            -2.3%  1.559e+09        perf-stat.ps.branch-instructions
   6240735           +23.7%    7718764        perf-stat.ps.branch-misses
    320443 ±  8%      +1.2%     324372 ±  9%  perf-stat.ps.cache-misses
   2294156 ±  5%      -2.9%    2227395 ±  6%  perf-stat.ps.cache-references
      2474 ±  5%      +0.0%       2475 ±  6%  perf-stat.ps.context-switches
     62392            +0.1%      62442        perf-stat.ps.cpu-clock
 3.905e+09            -0.2%  3.898e+09        perf-stat.ps.cpu-cycles
     72.06            -0.0%      72.06        perf-stat.ps.cpu-migrations
 7.799e+09            -2.3%  7.624e+09        perf-stat.ps.instructions
      0.00 ±223%    +149.8%       0.01 ±206%  perf-stat.ps.major-faults
      2473            +0.3%       2481        perf-stat.ps.minor-faults
      2473            +0.3%       2481        perf-stat.ps.page-faults
     62392            +0.1%      62442        perf-stat.ps.task-clock
 3.095e+11            +0.6%  3.115e+11        perf-stat.total.instructions
     13441 ± 36%     -22.0%      10483 ± 64%  numa-meminfo.node0.Active
      1589 ± 18%      +8.3%       1721 ± 19%  numa-meminfo.node0.Active(anon)
     11851 ± 41%     -26.1%       8762 ± 76%  numa-meminfo.node0.Active(file)
    163895 ± 70%     -61.8%      62643 ±170%  numa-meminfo.node0.AnonHugePages
    410156 ± 61%     -26.5%     301376 ± 63%  numa-meminfo.node0.AnonPages
    414695 ± 60%     -26.8%     303552 ± 63%  numa-meminfo.node0.AnonPages.max
      2090 ± 57%     -38.0%       1295 ± 95%  numa-meminfo.node0.Dirty
   1229354 ± 99%     -11.2%    1092156 ± 99%  numa-meminfo.node0.FilePages
    414395 ± 60%     -26.1%     306213 ± 62%  numa-meminfo.node0.Inactive
    412173 ± 61%     -26.4%     303551 ± 63%  numa-meminfo.node0.Inactive(anon)
      2221 ± 78%     +19.8%       2662 ± 73%  numa-meminfo.node0.Inactive(file)
     44799 ± 51%      -4.7%      42697 ± 45%  numa-meminfo.node0.KReclaimable
      7938 ±  5%      +0.0%       7938 ±  7%  numa-meminfo.node0.KernelStack
     15813 ± 79%      +6.4%      16818 ± 67%  numa-meminfo.node0.Mapped
 1.294e+08            +0.2%  1.296e+08        numa-meminfo.node0.MemFree
 1.317e+08            +0.0%  1.317e+08        numa-meminfo.node0.MemTotal
   2305371 ± 53%     -10.8%    2056197 ± 49%  numa-meminfo.node0.MemUsed
      3640 ± 21%      -5.6%       3437 ± 14%  numa-meminfo.node0.PageTables
     44799 ± 51%      -4.7%      42697 ± 45%  numa-meminfo.node0.SReclaimable
     96223 ± 11%      +5.0%     101078 ±  9%  numa-meminfo.node0.SUnreclaim
      5140            +0.0%       5140        numa-meminfo.node0.SecPageTables
     12834 ± 10%      +2.4%      13146 ±  8%  numa-meminfo.node0.Shmem
    141023 ± 20%      +2.0%     143776 ± 17%  numa-meminfo.node0.Slab
   1211439 ±101%     -11.1%    1076577 ±101%  numa-meminfo.node0.Unevictable
      0.52 ±331%    -100.0%       0.00        numa-meminfo.node0.Writeback
      4828 ±101%     +61.1%       7778 ± 87%  numa-meminfo.node1.Active
      1398 ± 21%      -8.9%       1273 ± 25%  numa-meminfo.node1.Active(anon)
      3430 ±142%     +89.6%       6505 ±103%  numa-meminfo.node1.Active(file)
     81747 ±140%    +123.1%     182406 ± 57%  numa-meminfo.node1.AnonHugePages
    243968 ±103%     +44.6%     352690 ± 54%  numa-meminfo.node1.AnonPages
    247343 ±102%     +44.5%     357471 ± 53%  numa-meminfo.node1.AnonPages.max
    498.41 ±208%    +150.9%       1250 ±121%  numa-meminfo.node1.Dirty
   1948154 ± 63%      +7.0%    2085294 ± 52%  numa-meminfo.node1.FilePages
    247802 ±101%     +43.6%     355884 ± 53%  numa-meminfo.node1.Inactive
    245094 ±102%     +44.3%     353636 ± 54%  numa-meminfo.node1.Inactive(anon)
      2708 ± 65%     -17.0%       2247 ± 86%  numa-meminfo.node1.Inactive(file)
     47690 ± 48%      +4.2%      49698 ± 38%  numa-meminfo.node1.KReclaimable
      6570 ±  6%      -0.5%       6540 ±  9%  numa-meminfo.node1.KernelStack
     18814 ± 67%      -4.9%      17898 ± 63%  numa-meminfo.node1.Mapped
 1.292e+08            -0.2%  1.289e+08        numa-meminfo.node1.MemFree
 1.321e+08            +0.0%  1.321e+08        numa-meminfo.node1.MemTotal
   2877997 ± 42%      +8.8%    3130032 ± 32%  numa-meminfo.node1.MemUsed
      2819 ± 27%      +8.6%       3062 ± 15%  numa-meminfo.node1.PageTables
     47690 ± 48%      +4.2%      49698 ± 38%  numa-meminfo.node1.SReclaimable
     71492 ± 15%      -6.6%      66740 ± 13%  numa-meminfo.node1.SUnreclaim
      5140            +0.0%       5140        numa-meminfo.node1.SecPageTables
      2815 ± 47%     -12.1%       2473 ± 43%  numa-meminfo.node1.Shmem
    119182 ± 24%      -2.3%     116438 ± 21%  numa-meminfo.node1.Slab
   1939196 ± 63%      +7.0%    2074058 ± 52%  numa-meminfo.node1.Unevictable
     58.67 ± 13%      -7.1%      54.50 ± 14%  proc-vmstat.direct_map_level2_splits
      5.67 ± 29%      +2.9%       5.83 ± 28%  proc-vmstat.direct_map_level3_splits
    747.28            +0.3%     749.43        proc-vmstat.nr_active_anon
      3820            -0.1%       3816        proc-vmstat.nr_active_file
    163519            -0.0%     163501        proc-vmstat.nr_anon_pages
    119.95 ±  2%      -0.2%     119.66        proc-vmstat.nr_anon_transparent_hugepages
      1057 ±  3%      -0.9%       1048        proc-vmstat.nr_dirtied
    647.17 ± 30%      -1.6%     636.62 ± 35%  proc-vmstat.nr_dirty
   6427082            -0.0%    6427008        proc-vmstat.nr_dirty_background_threshold
  12869878            -0.0%   12869731        proc-vmstat.nr_dirty_threshold
    794376            -0.0%     794362        proc-vmstat.nr_file_pages
      6.75 ±  8%      -4.9%       6.42 ±  9%  proc-vmstat.nr_foll_pin_acquired
      6.75 ±  8%      -4.9%       6.42 ±  9%  proc-vmstat.nr_foll_pin_released
  64644777            -0.0%   64644057        proc-vmstat.nr_free_pages
    164304            -0.0%     164280        proc-vmstat.nr_inactive_anon
      1231 ±  2%      -0.3%       1227 ±  3%  proc-vmstat.nr_inactive_file
      2570            +0.0%       2570        proc-vmstat.nr_iommu_pages
     14497            -0.2%      14469        proc-vmstat.nr_kernel_stack
      8878            +0.3%       8901        proc-vmstat.nr_mapped
   1047552            +0.0%    1047552        proc-vmstat.nr_memmap_boot
      1615            +0.7%       1627        proc-vmstat.nr_page_table_pages
      2570            +0.0%       2570        proc-vmstat.nr_sec_page_table_pages
      3912            -0.2%       3904        proc-vmstat.nr_shmem
     23119            -0.1%      23099        proc-vmstat.nr_slab_reclaimable
     41924            +0.1%      41954        proc-vmstat.nr_slab_unreclaimable
    787658            +0.0%     787658        proc-vmstat.nr_unevictable
      0.13 ±331%    -100.0%       0.00        proc-vmstat.nr_writeback
    970.75 ± 30%      +8.0%       1048        proc-vmstat.nr_written
    747.28            +0.3%     749.43        proc-vmstat.nr_zone_active_anon
      3820            -0.1%       3816        proc-vmstat.nr_zone_active_file
    164304            -0.0%     164280        proc-vmstat.nr_zone_inactive_anon
      1231 ±  2%      -0.3%       1227 ±  3%  proc-vmstat.nr_zone_inactive_file
    787658            +0.0%     787658        proc-vmstat.nr_zone_unevictable
    647.30 ± 30%      -1.6%     636.62 ± 35%  proc-vmstat.nr_zone_write_pending
     19.75 ± 70%   +1438.4%     303.83 ±305%  proc-vmstat.numa_hint_faults
      3.25 ±223%     +53.8%       5.00 ±307%  proc-vmstat.numa_hint_faults_local
    253901            +0.9%     256148        proc-vmstat.numa_hit
      1.00            +0.0%       1.00        proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
    187688            +1.2%     189930        proc-vmstat.numa_local
     66212            -0.0%      66212        proc-vmstat.numa_other
     16.50 ± 48%   +1711.1%     298.83 ±311%  proc-vmstat.numa_pages_migrated
    578.50 ±  8%    +132.1%       1342 ±184%  proc-vmstat.numa_pte_updates
     59.67 ± 33%     +20.9%      72.17 ± 17%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
    279411            +0.8%     281627        proc-vmstat.pgalloc_normal
    155410            +2.2%     158896        proc-vmstat.pgfault
    153444            +2.2%     156845        proc-vmstat.pgfree
     16.50 ± 48%   +1711.1%     298.83 ±311%  proc-vmstat.pgmigrate_success
    124.00           -16.7%     103.33 ± 44%  proc-vmstat.pgpgin
      8141 ± 14%      +4.4%       8497        proc-vmstat.pgpgout
      7592 ±  2%      +2.6%       7788        proc-vmstat.pgreuse
     32.00            +0.0%      32.00        proc-vmstat.thp_collapse_alloc
      1.00            +0.0%       1.00        proc-vmstat.thp_fault_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    228.33            -7.8%     210.50 ± 28%  proc-vmstat.unevictable_pgs_culled
    398.05 ± 18%      +8.4%     431.40 ± 19%  numa-vmstat.node0.nr_active_anon
      2962 ± 41%     -26.1%       2190 ± 76%  numa-vmstat.node0.nr_active_file
    102554 ± 61%     -26.5%      75357 ± 63%  numa-vmstat.node0.nr_anon_pages
     80.03 ± 70%     -61.8%      30.59 ±170%  numa-vmstat.node0.nr_anon_transparent_hugepages
    863.00 ± 43%     -29.2%     610.92 ± 82%  numa-vmstat.node0.nr_dirtied
    524.09 ± 57%     -38.2%     323.99 ± 95%  numa-vmstat.node0.nr_dirty
    307339 ± 99%     -11.2%     273040 ± 99%  numa-vmstat.node0.nr_file_pages
      3.25 ± 73%     -33.3%       2.17 ± 86%  numa-vmstat.node0.nr_foll_pin_acquired
      3.25 ± 73%     -33.3%       2.17 ± 86%  numa-vmstat.node0.nr_foll_pin_released
  32347619            +0.2%   32409883        numa-vmstat.node0.nr_free_pages
    103059 ± 61%     -26.4%      75895 ± 63%  numa-vmstat.node0.nr_inactive_anon
    555.32 ± 78%     +20.0%     666.33 ± 73%  numa-vmstat.node0.nr_inactive_file
      1285            +0.0%       1285        numa-vmstat.node0.nr_iommu_pages
      7929 ±  5%      -0.1%       7919 ±  7%  numa-vmstat.node0.nr_kernel_stack
      4056 ± 79%      +6.9%       4336 ± 66%  numa-vmstat.node0.nr_mapped
    523264            +0.0%     523264        numa-vmstat.node0.nr_memmap_boot
    910.08 ± 21%      -5.8%     857.59 ± 14%  numa-vmstat.node0.nr_page_table_pages
      1285            +0.0%       1285        numa-vmstat.node0.nr_sec_page_table_pages
      3209 ± 10%      +2.4%       3287 ±  8%  numa-vmstat.node0.nr_shmem
     11199 ± 51%      -4.7%      10674 ± 45%  numa-vmstat.node0.nr_slab_reclaimable
     24055 ± 11%      +5.1%      25270 ±  9%  numa-vmstat.node0.nr_slab_unreclaimable
    302859 ±101%     -11.1%     269144 ±101%  numa-vmstat.node0.nr_unevictable
      0.13 ±331%    -100.0%       0.00        numa-vmstat.node0.nr_writeback
    777.33 ± 56%     -21.4%     611.00 ± 82%  numa-vmstat.node0.nr_written
    398.05 ± 18%      +8.4%     431.39 ± 19%  numa-vmstat.node0.nr_zone_active_anon
      2962 ± 41%     -26.1%       2190 ± 76%  numa-vmstat.node0.nr_zone_active_file
    103059 ± 61%     -26.4%      75895 ± 63%  numa-vmstat.node0.nr_zone_inactive_anon
    555.32 ± 78%     +20.0%     666.33 ± 73%  numa-vmstat.node0.nr_zone_inactive_file
    302859 ±101%     -11.1%     269144 ±101%  numa-vmstat.node0.nr_zone_unevictable
    524.23 ± 57%     -38.2%     323.99 ± 95%  numa-vmstat.node0.nr_zone_write_pending
    120383 ± 14%      +6.1%     127728 ± 12%  numa-vmstat.node0.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node0.numa_interleave
    101088 ± 23%      -6.4%      94661 ± 20%  numa-vmstat.node0.numa_local
     19294 ±102%     +71.4%      33066 ± 69%  numa-vmstat.node0.numa_other
    351.13 ± 21%      -9.0%     319.60 ± 25%  numa-vmstat.node1.nr_active_anon
    857.72 ±142%     +89.6%       1626 ±103%  numa-vmstat.node1.nr_active_file
     61007 ±103%     +44.6%      88197 ± 54%  numa-vmstat.node1.nr_anon_pages
     39.87 ±140%    +123.4%      89.08 ± 57%  numa-vmstat.node1.nr_anon_transparent_hugepages
    184.08 ±205%    +137.4%     437.08 ±115%  numa-vmstat.node1.nr_dirtied
    124.59 ±208%    +150.9%     312.63 ±121%  numa-vmstat.node1.nr_dirty
    487037 ± 63%      +7.0%     521324 ± 52%  numa-vmstat.node1.nr_file_pages
      3.50 ± 70%     +21.4%       4.25 ± 40%  numa-vmstat.node1.nr_foll_pin_acquired
      3.50 ± 70%     +21.4%       4.25 ± 40%  numa-vmstat.node1.nr_foll_pin_released
  32297133            -0.2%   32234111        numa-vmstat.node1.nr_free_pages
     61278 ±102%     +44.3%      88427 ± 54%  numa-vmstat.node1.nr_inactive_anon
    677.15 ± 65%     -17.0%     561.97 ± 86%  numa-vmstat.node1.nr_inactive_file
      1285            +0.0%       1285        numa-vmstat.node1.nr_iommu_pages
      6545 ±  6%      -0.4%       6522 ±  9%  numa-vmstat.node1.nr_kernel_stack
      4855 ± 67%      -5.4%       4594 ± 63%  numa-vmstat.node1.nr_mapped
    524288            +0.0%     524288        numa-vmstat.node1.nr_memmap_boot
    703.51 ± 27%      +8.4%     762.65 ± 15%  numa-vmstat.node1.nr_page_table_pages
      1285            +0.0%       1285        numa-vmstat.node1.nr_sec_page_table_pages
    703.15 ± 47%     -11.9%     619.30 ± 43%  numa-vmstat.node1.nr_shmem
     11922 ± 48%      +4.2%      12425 ± 38%  numa-vmstat.node1.nr_slab_reclaimable
     17873 ± 15%      -6.6%      16685 ± 13%  numa-vmstat.node1.nr_slab_unreclaimable
    484799 ± 63%      +7.0%     518514 ± 52%  numa-vmstat.node1.nr_unevictable
    182.42 ±207%    +139.7%     437.17 ±115%  numa-vmstat.node1.nr_written
    351.13 ± 21%      -9.0%     319.60 ± 25%  numa-vmstat.node1.nr_zone_active_anon
    857.72 ±142%     +89.6%       1626 ±103%  numa-vmstat.node1.nr_zone_active_file
     61278 ±102%     +44.3%      88426 ± 54%  numa-vmstat.node1.nr_zone_inactive_anon
    677.15 ± 65%     -17.0%     561.97 ± 86%  numa-vmstat.node1.nr_zone_inactive_file
    484799 ± 63%      +7.0%     518514 ± 52%  numa-vmstat.node1.nr_zone_unevictable
    124.59 ±208%    +150.9%     312.63 ±121%  numa-vmstat.node1.nr_zone_write_pending
    130223 ± 13%      -3.9%     125086 ± 12%  numa-vmstat.node1.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node1.numa_interleave
     83305 ± 27%     +10.4%      91934 ± 21%  numa-vmstat.node1.numa_local
     46917 ± 42%     -29.4%      33145 ± 69%  numa-vmstat.node1.numa_other
      5768 ± 12%      -1.9%       5661 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.avg
     38669 ± 35%      -9.7%      34924 ± 33%  sched_debug.cfs_rq:/.avg_vruntime.max
      1090 ± 27%      +8.9%       1187 ± 22%  sched_debug.cfs_rq:/.avg_vruntime.min
      6779 ± 28%      -4.4%       6482 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.27 ± 13%      -2.4%       0.26 ± 14%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.50 ± 33%      +0.0%       1.50 ± 33%  sched_debug.cfs_rq:/.h_nr_running.max
      0.46 ±  5%      -0.2%       0.46 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
     19.80 ±149%    +341.3%      87.37 ±173%  sched_debug.cfs_rq:/.left_deadline.avg
      1267 ±149%    +293.8%       4989 ±192%  sched_debug.cfs_rq:/.left_deadline.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.left_deadline.min
    157.13 ±149%    +303.2%     633.50 ±187%  sched_debug.cfs_rq:/.left_deadline.stddev
     19.77 ±149%    +339.3%      86.86 ±174%  sched_debug.cfs_rq:/.left_vruntime.avg
      1265 ±149%    +292.4%       4966 ±192%  sched_debug.cfs_rq:/.left_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.left_vruntime.min
    156.95 ±149%    +301.9%     630.82 ±188%  sched_debug.cfs_rq:/.left_vruntime.stddev
     29912 ± 26%      +8.4%      32438 ± 38%  sched_debug.cfs_rq:/.load.avg
   1572864 ± 33%     -10.9%    1401472 ± 35%  sched_debug.cfs_rq:/.load.max
    194729 ± 33%      -3.6%     187764 ± 33%  sched_debug.cfs_rq:/.load.stddev
    162.34 ± 25%     +15.7%     187.85 ± 21%  sched_debug.cfs_rq:/.load_avg.avg
      1740 ±  4%      -1.9%       1707 ± 36%  sched_debug.cfs_rq:/.load_avg.max
    375.33 ± 12%      +6.3%     398.82 ± 16%  sched_debug.cfs_rq:/.load_avg.stddev
      5768 ± 12%      -1.9%       5661 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
     38669 ± 35%      -9.7%      34924 ± 33%  sched_debug.cfs_rq:/.min_vruntime.max
      1090 ± 27%      +8.9%       1187 ± 22%  sched_debug.cfs_rq:/.min_vruntime.min
      6779 ± 28%      -4.4%       6482 ± 26%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.27 ± 13%      -2.9%       0.26 ± 14%  sched_debug.cfs_rq:/.nr_running.avg
      1.50 ± 33%      +0.0%       1.50 ± 33%  sched_debug.cfs_rq:/.nr_running.max
      0.46 ±  5%      -0.4%       0.46 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
     98.05 ± 41%     +18.9%     116.57 ± 30%  sched_debug.cfs_rq:/.removed.load_avg.avg
      1011 ±  2%      +1.0%       1021        sched_debug.cfs_rq:/.removed.load_avg.max
    285.41 ± 23%     +10.4%     315.20 ± 13%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     33.83 ± 38%     +14.9%      38.89 ± 35%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    514.42 ± 14%      -3.5%     496.25 ± 14%  sched_debug.cfs_rq:/.removed.runnable_avg.max
    108.70 ± 24%      +5.1%     114.23 ± 22%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     33.83 ± 38%     +14.9%      38.88 ± 35%  sched_debug.cfs_rq:/.removed.util_avg.avg
    514.42 ± 14%      -3.5%     496.17 ± 14%  sched_debug.cfs_rq:/.removed.util_avg.max
    108.70 ± 24%      +5.1%     114.23 ± 22%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     19.77 ±149%    +339.3%      86.86 ±174%  sched_debug.cfs_rq:/.right_vruntime.avg
      1265 ±149%    +292.4%       4966 ±192%  sched_debug.cfs_rq:/.right_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.right_vruntime.min
    156.95 ±149%    +301.9%     630.82 ±188%  sched_debug.cfs_rq:/.right_vruntime.stddev
    473.42 ±  6%      +2.1%     483.49 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      1553 ±  5%      -4.6%       1482 ± 13%  sched_debug.cfs_rq:/.runnable_avg.max
      0.00       +8.3e+100%       0.08 ±331%  sched_debug.cfs_rq:/.runnable_avg.min
    344.76 ±  7%      +2.1%     351.91 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    464.20 ±  7%      +2.5%     475.67 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1359 ± 14%      +4.9%       1425 ± 17%  sched_debug.cfs_rq:/.util_avg.max
      0.00       +8.3e+100%       0.08 ±331%  sched_debug.cfs_rq:/.util_avg.min
    325.97 ±  9%      +4.0%     338.94 ±  9%  sched_debug.cfs_rq:/.util_avg.stddev
     51.55 ± 17%      +6.2%      54.73 ± 19%  sched_debug.cfs_rq:/.util_est.avg
    974.67 ±  6%      -0.8%     967.33 ±  6%  sched_debug.cfs_rq:/.util_est.max
    168.22 ±  5%      +0.4%     168.93 ±  7%  sched_debug.cfs_rq:/.util_est.stddev
    694149 ±  3%      -0.5%     690441 ±  2%  sched_debug.cpu.avg_idle.avg
   1000000            +0.0%    1000000        sched_debug.cpu.avg_idle.max
      3642 ±  5%      -4.2%       3490 ± 10%  sched_debug.cpu.avg_idle.min
    260377 ±  4%      -1.7%     256044 ±  6%  sched_debug.cpu.avg_idle.stddev
    165707 ±  2%      -0.6%     164692        sched_debug.cpu.clock.avg
    165709 ±  2%      -0.6%     164694        sched_debug.cpu.clock.max
    165702 ±  2%      -0.6%     164687        sched_debug.cpu.clock.min
      1.45 ± 19%      +3.8%       1.50 ± 17%  sched_debug.cpu.clock.stddev
    165448 ±  2%      -0.6%     164433        sched_debug.cpu.clock_task.avg
    165693 ±  2%      -0.6%     164678        sched_debug.cpu.clock_task.max
    157683 ±  2%      -0.7%     156636        sched_debug.cpu.clock_task.min
    991.10            +0.4%     995.46        sched_debug.cpu.clock_task.stddev
    579.29 ± 17%      -1.5%     570.36 ± 13%  sched_debug.cpu.curr->pid.avg
      2538            -0.2%       2534        sched_debug.cpu.curr->pid.max
      1009 ±  6%      -0.4%       1005 ±  5%  sched_debug.cpu.curr->pid.stddev
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.avg
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
      4294            -0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            -0.0%       4294        sched_debug.cpu.next_balance.max
      4294            -0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 33%      +9.0%       0.00 ± 44%  sched_debug.cpu.next_balance.stddev
      0.27 ± 14%      -0.5%       0.27 ± 14%  sched_debug.cpu.nr_running.avg
      1.50 ± 33%      +0.0%       1.50 ± 33%  sched_debug.cpu.nr_running.max
      0.46 ±  5%      +0.9%       0.46 ±  8%  sched_debug.cpu.nr_running.stddev
      2190 ±  3%      -0.4%       2181        sched_debug.cpu.nr_switches.avg
     10860 ± 16%     +13.9%      12372 ± 18%  sched_debug.cpu.nr_switches.max
    347.42 ± 15%      -6.8%     323.92 ± 17%  sched_debug.cpu.nr_switches.min
      2227 ± 13%      +3.5%       2305 ± 11%  sched_debug.cpu.nr_switches.stddev
    165705 ±  2%      -0.6%     164690        sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            -0.0%  4.295e+09        sched_debug.jiffies
    164541 ±  2%      -0.6%     163526        sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.min
      0.00 ±182%     +25.5%       0.01 ±171%  sched_debug.rt_rq:.rt_time.avg
      0.30 ±182%     +25.5%       0.37 ±171%  sched_debug.rt_rq:.rt_time.max
      0.04 ±182%     +25.5%       0.05 ±171%  sched_debug.rt_rq:.rt_time.stddev
    166279 ±  2%      -0.6%     165267        sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_base_slice
   6237751            +0.0%    6237751        sched_debug.sysctl_sched.sysctl_sched_features
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      1659            +0.6%       1670        slabinfo.Acpi-State.active_objs
     32.54            +0.6%      32.75        slabinfo.Acpi-State.active_slabs
      1659            +0.6%       1670        slabinfo.Acpi-State.num_objs
     32.54            +0.6%      32.75        slabinfo.Acpi-State.num_slabs
     17.25 ± 14%      +0.0%      17.25 ± 14%  slabinfo.DCCP.active_objs
      0.96 ± 14%      +0.0%       0.96 ± 14%  slabinfo.DCCP.active_slabs
     17.25 ± 14%      +0.0%      17.25 ± 14%  slabinfo.DCCP.num_objs
      0.96 ± 14%      +0.0%       0.96 ± 14%  slabinfo.DCCP.num_slabs
     16.29 ± 14%      +0.0%      16.29 ± 14%  slabinfo.DCCPv6.active_objs
      0.96 ± 14%      +0.0%       0.96 ± 14%  slabinfo.DCCPv6.active_slabs
     16.29 ± 14%      +0.0%      16.29 ± 14%  slabinfo.DCCPv6.num_objs
      0.96 ± 14%      +0.0%       0.96 ± 14%  slabinfo.DCCPv6.num_slabs
    762.67 ±  8%      +1.6%     774.63 ±  9%  slabinfo.PING.active_objs
     23.83 ±  8%      +1.6%      24.21 ±  9%  slabinfo.PING.active_slabs
    762.67 ±  8%      +1.6%     774.63 ±  9%  slabinfo.PING.num_objs
     23.83 ±  8%      +1.6%      24.21 ±  9%  slabinfo.PING.num_slabs
    102.67 ±  7%      +5.2%     108.00 ± 10%  slabinfo.RAW.active_objs
      3.21 ±  7%      +5.2%       3.38 ± 10%  slabinfo.RAW.active_slabs
    102.67 ±  7%      +5.2%     108.00 ± 10%  slabinfo.RAW.num_objs
      3.21 ±  7%      +5.2%       3.38 ± 10%  slabinfo.RAW.num_slabs
    100.75 ±  5%      +0.0%     100.75 ±  5%  slabinfo.RAWv6.active_objs
      3.88 ±  5%      +0.0%       3.88 ±  5%  slabinfo.RAWv6.active_slabs
    100.75 ±  5%      +0.0%     100.75 ±  5%  slabinfo.RAWv6.num_objs
      3.88 ±  5%      +0.0%       3.88 ±  5%  slabinfo.RAWv6.num_slabs
     18.51 ± 13%      +0.4%      18.58 ± 13%  slabinfo.TCP.active_objs
      1.42 ± 13%      +0.4%       1.43 ± 13%  slabinfo.TCP.active_slabs
     18.51 ± 13%      +0.4%      18.58 ± 13%  slabinfo.TCP.num_objs
      1.42 ± 13%      +0.4%       1.43 ± 13%  slabinfo.TCP.num_slabs
     12.00            +0.0%      12.00        slabinfo.TCPv6.active_objs
      1.00            +0.0%       1.00        slabinfo.TCPv6.active_slabs
     12.00            +0.0%      12.00        slabinfo.TCPv6.num_objs
      1.00            +0.0%       1.00        slabinfo.TCPv6.num_slabs
     47.00 ±  7%      -2.1%      46.00 ±  9%  slabinfo.UDPv6.active_objs
      1.96 ±  7%      -2.1%       1.92 ±  9%  slabinfo.UDPv6.active_slabs
     47.00 ±  7%      -2.1%      46.00 ±  9%  slabinfo.UDPv6.num_objs
      1.96 ±  7%      -2.1%       1.92 ±  9%  slabinfo.UDPv6.num_slabs
      5595 ±  6%      -1.0%       5539 ±  6%  slabinfo.anon_vma.active_objs
    145.52 ±  6%      -1.0%     144.12 ±  6%  slabinfo.anon_vma.active_slabs
      5675 ±  6%      -1.0%       5620 ±  6%  slabinfo.anon_vma.num_objs
    145.52 ±  6%      -1.0%     144.12 ±  6%  slabinfo.anon_vma.num_slabs
      6659 ±  4%      -0.7%       6610 ±  3%  slabinfo.anon_vma_chain.active_objs
    106.79 ±  3%      -1.0%     105.73 ±  2%  slabinfo.anon_vma_chain.active_slabs
      6834 ±  3%      -1.0%       6766 ±  2%  slabinfo.anon_vma_chain.num_objs
    106.79 ±  3%      -1.0%     105.73 ±  2%  slabinfo.anon_vma_chain.num_slabs
     56.67 ± 16%      -2.9%      55.00 ± 13%  slabinfo.bdev_cache.active_objs
      2.83 ± 16%      -2.9%       2.75 ± 13%  slabinfo.bdev_cache.active_slabs
     56.67 ± 16%      -2.9%      55.00 ± 13%  slabinfo.bdev_cache.num_objs
      2.83 ± 16%      -2.9%       2.75 ± 13%  slabinfo.bdev_cache.num_slabs
    101.33 ± 13%      +6.6%     108.00 ± 13%  slabinfo.bio-120.active_objs
      3.17 ± 13%      +6.6%       3.38 ± 13%  slabinfo.bio-120.active_slabs
    101.33 ± 13%      +6.6%     108.00 ± 13%  slabinfo.bio-120.num_objs
      3.17 ± 13%      +6.6%       3.38 ± 13%  slabinfo.bio-120.num_slabs
    789.28 ±  7%      +6.3%     839.09 ± 10%  slabinfo.bio-184.active_objs
     20.84 ±  7%      +4.2%      21.71 ±  7%  slabinfo.bio-184.active_slabs
    875.23 ±  7%      +4.2%     911.73 ±  7%  slabinfo.bio-184.num_objs
     20.84 ±  7%      +4.2%      21.71 ±  7%  slabinfo.bio-184.num_slabs
     16.00            +0.0%      16.00        slabinfo.bio-240.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-240.active_slabs
     16.00            +0.0%      16.00        slabinfo.bio-240.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-240.num_slabs
     16.00            +0.0%      16.00        slabinfo.bio-248.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-248.active_slabs
     16.00            +0.0%      16.00        slabinfo.bio-248.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-248.num_slabs
     25.50            +0.0%      25.50        slabinfo.bio-296.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-296.active_slabs
     25.50            +0.0%      25.50        slabinfo.bio-296.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-296.num_slabs
     66.50 ± 17%      +0.0%      66.50 ± 11%  slabinfo.bio-360.active_objs
      1.58 ± 17%      +0.0%       1.58 ± 11%  slabinfo.bio-360.active_slabs
     66.50 ± 17%      +0.0%      66.50 ± 11%  slabinfo.bio-360.num_objs
      1.58 ± 17%      +0.0%       1.58 ± 11%  slabinfo.bio-360.num_slabs
     21.00            +0.0%      21.00        slabinfo.bio-376.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-376.active_slabs
     21.00            +0.0%      21.00        slabinfo.bio-376.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-376.num_slabs
     18.00            +0.0%      18.00        slabinfo.bio-432.active_objs
      0.50            +0.0%       0.50        slabinfo.bio-432.active_slabs
     18.00            +0.0%      18.00        slabinfo.bio-432.num_objs
      0.50            +0.0%       0.50        slabinfo.bio-432.num_slabs
     85.00            +0.0%      85.00        slabinfo.bio_post_read_ctx.active_objs
      1.00            +0.0%       1.00        slabinfo.bio_post_read_ctx.active_slabs
     85.00            +0.0%      85.00        slabinfo.bio_post_read_ctx.num_objs
      1.00            +0.0%       1.00        slabinfo.bio_post_read_ctx.num_slabs
     62.00 ± 21%      +0.0%      62.00 ± 19%  slabinfo.biovec-128.active_objs
      3.88 ± 21%      +0.0%       3.88 ± 19%  slabinfo.biovec-128.active_slabs
     62.00 ± 21%      +0.0%      62.00 ± 19%  slabinfo.biovec-128.num_objs
      3.88 ± 21%      +0.0%       3.88 ± 19%  slabinfo.biovec-128.num_slabs
     35.51            +0.0%      35.52        slabinfo.biovec-max.active_objs
      4.44            +0.0%       4.44        slabinfo.biovec-max.active_slabs
     35.51            +0.0%      35.52        slabinfo.biovec-max.num_objs
      4.44            +0.0%       4.44        slabinfo.biovec-max.num_slabs
     36.83 ± 25%      +3.8%      38.25 ± 19%  slabinfo.btrfs_extent_buffer.active_objs
      1.08 ± 25%      +3.8%       1.12 ± 19%  slabinfo.btrfs_extent_buffer.active_slabs
     36.83 ± 25%      +3.8%      38.25 ± 19%  slabinfo.btrfs_extent_buffer.num_objs
      1.08 ± 25%      +3.8%       1.12 ± 19%  slabinfo.btrfs_extent_buffer.num_slabs
     61.33 ±  9%      +0.0%      61.33 ±  9%  slabinfo.btrfs_inode.active_objs
      1.92 ±  9%      +0.0%       1.92 ±  9%  slabinfo.btrfs_inode.active_slabs
     61.33 ±  9%      +0.0%      61.33 ±  9%  slabinfo.btrfs_inode.num_objs
      1.92 ±  9%      +0.0%       1.92 ±  9%  slabinfo.btrfs_inode.num_slabs
    183.00 ± 13%      -0.8%     181.50 ±  9%  slabinfo.btrfs_path.active_objs
      5.08 ± 13%      -0.8%       5.04 ±  9%  slabinfo.btrfs_path.active_slabs
    183.00 ± 13%      -0.8%     181.50 ±  9%  slabinfo.btrfs_path.num_objs
      5.08 ± 13%      -0.8%       5.04 ±  9%  slabinfo.btrfs_path.num_slabs
      1222 ±  4%      +1.4%       1239 ±  4%  slabinfo.buffer_head.active_objs
     34.98 ±  4%      +0.7%      35.22 ±  5%  slabinfo.buffer_head.active_slabs
      1364 ±  4%      +0.7%       1373 ±  5%  slabinfo.buffer_head.num_objs
     34.98 ±  4%      +0.7%      35.22 ±  5%  slabinfo.buffer_head.num_slabs
     57.50 ± 20%      -6.7%      53.67 ± 20%  slabinfo.configfs_dir_cache.active_objs
      1.25 ± 20%      -6.7%       1.17 ± 20%  slabinfo.configfs_dir_cache.active_slabs
     57.50 ± 20%      -6.7%      53.67 ± 20%  slabinfo.configfs_dir_cache.num_objs
      1.25 ± 20%      -6.7%       1.17 ± 20%  slabinfo.configfs_dir_cache.num_slabs
      2028 ±  2%      +0.5%       2039        slabinfo.cred.active_objs
     48.30 ±  2%      +0.5%      48.55        slabinfo.cred.active_slabs
      2028 ±  2%      +0.5%       2039        slabinfo.cred.num_objs
     48.30 ±  2%      +0.5%      48.55        slabinfo.cred.num_slabs
     21.00            +0.0%      21.00        slabinfo.dax_cache.active_objs
      0.50            +0.0%       0.50        slabinfo.dax_cache.active_slabs
     21.00            +0.0%      21.00        slabinfo.dax_cache.num_objs
      0.50            +0.0%       0.50        slabinfo.dax_cache.num_slabs
     47195            -0.1%      47149        slabinfo.dentry.active_objs
      1134            -0.1%       1133        slabinfo.dentry.active_slabs
     47647            -0.1%      47589        slabinfo.dentry.num_objs
      1134            -0.1%       1133        slabinfo.dentry.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-128.active_objs
      0.50            +0.0%       0.50        slabinfo.dmaengine-unmap-128.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-128.num_objs
      0.50            +0.0%       0.50        slabinfo.dmaengine-unmap-128.num_slabs
      7.50            +0.0%       7.50        slabinfo.dmaengine-unmap-256.active_objs
      0.50            +0.0%       0.50        slabinfo.dmaengine-unmap-256.active_slabs
      7.50            +0.0%       7.50        slabinfo.dmaengine-unmap-256.num_objs
      0.50            +0.0%       0.50        slabinfo.dmaengine-unmap-256.num_slabs
     40.02 ± 21%     +11.0%      44.41 ± 26%  slabinfo.dquot.active_objs
      1.25 ± 21%     +11.0%       1.39 ± 26%  slabinfo.dquot.active_slabs
     40.02 ± 21%     +11.0%      44.41 ± 26%  slabinfo.dquot.num_objs
      1.25 ± 21%     +11.0%       1.39 ± 26%  slabinfo.dquot.num_slabs
      5408 ± 11%      -5.3%       5120 ±  7%  slabinfo.ep_head.active_objs
     21.12 ± 11%      -5.3%      20.00 ±  7%  slabinfo.ep_head.active_slabs
      5408 ± 11%      -5.3%       5120 ±  7%  slabinfo.ep_head.num_objs
     21.12 ± 11%      -5.3%      20.00 ±  7%  slabinfo.ep_head.num_slabs
     26.50            +8.3%      28.71 ± 25%  slabinfo.ext4_allocation_context.active_objs
      0.50            +8.3%       0.54 ± 25%  slabinfo.ext4_allocation_context.active_slabs
     26.50            +8.3%      28.71 ± 25%  slabinfo.ext4_allocation_context.num_objs
      0.50            +8.3%       0.54 ± 25%  slabinfo.ext4_allocation_context.num_slabs
    814.00            +0.0%     814.00        slabinfo.ext4_groupinfo_4k.active_objs
     18.50            +0.0%      18.50        slabinfo.ext4_groupinfo_4k.active_slabs
    814.00            +0.0%     814.00        slabinfo.ext4_groupinfo_4k.num_objs
     18.50            +0.0%      18.50        slabinfo.ext4_groupinfo_4k.num_slabs
     28.00            -4.2%      26.83 ± 14%  slabinfo.ext4_inode_cache.active_objs
      1.00            -4.2%       0.96 ± 14%  slabinfo.ext4_inode_cache.active_slabs
     28.00            -4.2%      26.83 ± 14%  slabinfo.ext4_inode_cache.num_objs
      1.00            -4.2%       0.96 ± 14%  slabinfo.ext4_inode_cache.num_slabs
     18.00            +8.3%      19.50 ± 25%  slabinfo.ext4_prealloc_space.active_objs
      0.50            +8.3%       0.54 ± 25%  slabinfo.ext4_prealloc_space.active_slabs
     18.00            +8.3%      19.50 ± 25%  slabinfo.ext4_prealloc_space.num_objs
      0.50            +8.3%       0.54 ± 25%  slabinfo.ext4_prealloc_space.num_slabs
    144.50 ± 13%      -5.9%     136.00 ± 17%  slabinfo.extent_status.active_objs
      1.42 ± 13%      -5.9%       1.33 ± 17%  slabinfo.extent_status.active_slabs
    144.50 ± 13%      -5.9%     136.00 ± 17%  slabinfo.extent_status.num_objs
      1.42 ± 13%      -5.9%       1.33 ± 17%  slabinfo.extent_status.num_slabs
    747.42 ± 11%      +1.4%     757.96 ± 12%  slabinfo.file_lock_cache.active_objs
     17.80 ± 11%      +1.4%      18.05 ± 12%  slabinfo.file_lock_cache.active_slabs
    747.42 ± 11%      +1.4%     757.96 ± 12%  slabinfo.file_lock_cache.num_objs
     17.80 ± 11%      +1.4%      18.05 ± 12%  slabinfo.file_lock_cache.num_slabs
      1506            +0.3%       1510        slabinfo.files_cache.active_objs
     32.74            +0.3%      32.83        slabinfo.files_cache.active_slabs
      1506            +0.3%       1510        slabinfo.files_cache.num_objs
     32.74            +0.3%      32.83        slabinfo.files_cache.num_slabs
      3170 ±  3%      +2.4%       3248 ±  3%  slabinfo.filp.active_objs
     99.26 ±  3%      +2.4%     101.64 ±  3%  slabinfo.filp.active_slabs
      3176 ±  3%      +2.4%       3252 ±  3%  slabinfo.filp.num_objs
     99.26 ±  3%      +2.4%     101.64 ±  3%  slabinfo.filp.num_slabs
      5183            +0.0%       5183        slabinfo.ftrace_event_field.active_objs
     71.00            +0.0%      71.00        slabinfo.ftrace_event_field.active_slabs
      5183            +0.0%       5183        slabinfo.ftrace_event_field.num_objs
     71.00            +0.0%      71.00        slabinfo.ftrace_event_field.num_slabs
     51.00            +8.3%      55.25 ± 17%  slabinfo.hugetlbfs_inode_cache.active_objs
      1.00            +8.3%       1.08 ± 17%  slabinfo.hugetlbfs_inode_cache.active_slabs
     51.00            +8.3%      55.25 ± 17%  slabinfo.hugetlbfs_inode_cache.num_objs
      1.00            +8.3%       1.08 ± 17%  slabinfo.hugetlbfs_inode_cache.num_slabs
     37447            -0.1%      37411        slabinfo.inode_cache.active_objs
    720.15            -0.1%     719.45        slabinfo.inode_cache.active_slabs
     37447            -0.1%      37411        slabinfo.inode_cache.num_objs
    720.15            -0.1%     719.45        slabinfo.inode_cache.num_slabs
    262.97 ± 13%      +1.5%     267.00 ±  7%  slabinfo.iommu_iova_magazine.active_objs
      8.22 ± 13%      +1.5%       8.34 ±  7%  slabinfo.iommu_iova_magazine.active_slabs
    262.97 ± 13%      +1.5%     267.00 ±  7%  slabinfo.iommu_iova_magazine.num_objs
      8.22 ± 13%      +1.5%       8.34 ±  7%  slabinfo.iommu_iova_magazine.num_slabs
     88.21 ± 20%      +6.9%      94.29 ± 19%  slabinfo.ip_fib_alias.active_objs
      1.21 ± 20%      +6.9%       1.29 ± 19%  slabinfo.ip_fib_alias.active_slabs
     88.21 ± 20%      +6.9%      94.29 ± 19%  slabinfo.ip_fib_alias.num_objs
      1.21 ± 20%      +6.9%       1.29 ± 19%  slabinfo.ip_fib_alias.num_slabs
    102.71 ± 20%      +6.9%     109.79 ± 19%  slabinfo.ip_fib_trie.active_objs
      1.21 ± 20%      +6.9%       1.29 ± 19%  slabinfo.ip_fib_trie.active_slabs
    102.71 ± 20%      +6.9%     109.79 ± 19%  slabinfo.ip_fib_trie.num_objs
      1.21 ± 20%      +6.9%       1.29 ± 19%  slabinfo.ip_fib_trie.num_slabs
    442.83 ± 20%      -1.6%     435.73 ± 22%  slabinfo.jbd2_journal_head.active_objs
     13.54 ± 15%      -0.9%      13.42 ± 16%  slabinfo.jbd2_journal_head.active_slabs
    460.36 ± 15%      -0.9%     456.17 ± 16%  slabinfo.jbd2_journal_head.num_objs
     13.54 ± 15%      -0.9%      13.42 ± 16%  slabinfo.jbd2_journal_head.num_slabs
    128.00            +0.0%     128.00        slabinfo.jbd2_revoke_table_s.active_objs
      0.50            +0.0%       0.50        slabinfo.jbd2_revoke_table_s.active_slabs
    128.00            +0.0%     128.00        slabinfo.jbd2_revoke_table_s.num_objs
      0.50            +0.0%       0.50        slabinfo.jbd2_revoke_table_s.num_slabs
     38967            +0.1%      38987        slabinfo.kernfs_node_cache.active_objs
    649.46            +0.1%     649.79        slabinfo.kernfs_node_cache.active_slabs
     38967            +0.1%      38987        slabinfo.kernfs_node_cache.num_objs
    649.46            +0.1%     649.79        slabinfo.kernfs_node_cache.num_slabs
      1795 ± 11%      +3.2%       1852 ±  9%  slabinfo.khugepaged_mm_slot.active_objs
     17.60 ± 11%      +3.2%      18.17 ±  9%  slabinfo.khugepaged_mm_slot.active_slabs
      1795 ± 11%      +3.2%       1852 ±  9%  slabinfo.khugepaged_mm_slot.num_objs
     17.60 ± 11%      +3.2%      18.17 ±  9%  slabinfo.khugepaged_mm_slot.num_slabs
      1986            -0.2%       1981        slabinfo.kmalloc-128.active_objs
     62.12            -0.2%      61.99        slabinfo.kmalloc-128.active_slabs
      1987            -0.2%       1983        slabinfo.kmalloc-128.num_objs
     62.12            -0.2%      61.99        slabinfo.kmalloc-128.num_slabs
     12952            -1.6%      12744 ±  2%  slabinfo.kmalloc-16.active_objs
     51.41 ±  2%      -1.3%      50.75 ±  2%  slabinfo.kmalloc-16.active_slabs
     13161 ±  2%      -1.3%      12991 ±  2%  slabinfo.kmalloc-16.num_objs
     51.41 ±  2%      -1.3%      50.75 ±  2%  slabinfo.kmalloc-16.num_slabs
     10295            +0.1%      10303        slabinfo.kmalloc-192.active_objs
    245.17            +0.1%     245.33        slabinfo.kmalloc-192.active_slabs
     10297            +0.1%      10303        slabinfo.kmalloc-192.num_objs
    245.17            +0.1%     245.33        slabinfo.kmalloc-192.num_slabs
      2036            +0.8%       2051        slabinfo.kmalloc-1k.active_objs
     64.41            +0.2%      64.54        slabinfo.kmalloc-1k.active_slabs
      2061            +0.2%       2065        slabinfo.kmalloc-1k.num_objs
     64.41            +0.2%      64.54        slabinfo.kmalloc-1k.num_slabs
      2644            +0.2%       2648        slabinfo.kmalloc-256.active_objs
     82.71            +0.2%      82.87        slabinfo.kmalloc-256.active_slabs
      2646            +0.2%       2651        slabinfo.kmalloc-256.num_objs
     82.71            +0.2%      82.87        slabinfo.kmalloc-256.num_slabs
      1461            -0.0%       1461        slabinfo.kmalloc-2k.active_objs
     92.15            +0.1%      92.27        slabinfo.kmalloc-2k.active_slabs
      1474            +0.1%       1476        slabinfo.kmalloc-2k.num_objs
     92.15            +0.1%      92.27        slabinfo.kmalloc-2k.num_slabs
     23947            +0.1%      23973        slabinfo.kmalloc-32.active_objs
    187.68            +0.2%     187.98        slabinfo.kmalloc-32.active_slabs
     24022            +0.2%      24061        slabinfo.kmalloc-32.num_objs
    187.68            +0.2%     187.98        slabinfo.kmalloc-32.num_slabs
    538.34            +0.0%     538.59        slabinfo.kmalloc-4k.active_objs
     67.32            -0.0%      67.32        slabinfo.kmalloc-4k.active_slabs
    538.59            -0.0%     538.59        slabinfo.kmalloc-4k.num_objs
     67.32            -0.0%      67.32        slabinfo.kmalloc-4k.num_slabs
      5319 ±  2%      -0.5%       5290        slabinfo.kmalloc-512.active_objs
    166.56 ±  2%      -0.6%     165.55        slabinfo.kmalloc-512.active_slabs
      5330 ±  2%      -0.6%       5297        slabinfo.kmalloc-512.num_objs
    166.56 ±  2%      -0.6%     165.55        slabinfo.kmalloc-512.num_slabs
     25010            +0.2%      25051        slabinfo.kmalloc-64.active_objs
    391.09            +0.2%     391.74        slabinfo.kmalloc-64.active_slabs
     25029            +0.2%      25071        slabinfo.kmalloc-64.num_objs
    391.09            +0.2%     391.74        slabinfo.kmalloc-64.num_slabs
     19691            -0.0%      19686        slabinfo.kmalloc-8.active_objs
     39.00            +0.2%      39.08        slabinfo.kmalloc-8.active_slabs
     19968            +0.2%      20010        slabinfo.kmalloc-8.num_objs
     39.00            +0.2%      39.08        slabinfo.kmalloc-8.num_slabs
    241.36            +0.0%     241.40        slabinfo.kmalloc-8k.active_objs
     60.40            +0.0%      60.41        slabinfo.kmalloc-8k.active_slabs
    241.62            +0.0%     241.64        slabinfo.kmalloc-8k.num_objs
     60.40            +0.0%      60.41        slabinfo.kmalloc-8k.num_slabs
      4630 ±  3%      +0.1%       4636 ±  2%  slabinfo.kmalloc-96.active_objs
    117.70 ±  3%      -0.4%     117.18 ±  2%  slabinfo.kmalloc-96.active_slabs
      4943 ±  3%      -0.4%       4921 ±  2%  slabinfo.kmalloc-96.num_objs
    117.70 ±  3%      -0.4%     117.18 ±  2%  slabinfo.kmalloc-96.num_slabs
    330.67 ±  6%      +3.2%     341.33 ±  4%  slabinfo.kmalloc-cg-128.active_objs
     10.33 ±  6%      +3.2%      10.67 ±  4%  slabinfo.kmalloc-cg-128.active_slabs
    330.67 ±  6%      +3.2%     341.33 ±  4%  slabinfo.kmalloc-cg-128.num_objs
     10.33 ±  6%      +3.2%      10.67 ±  4%  slabinfo.kmalloc-cg-128.num_slabs
      2334 ± 10%      -3.1%       2261 ±  9%  slabinfo.kmalloc-cg-16.active_objs
      9.12 ± 10%      -3.1%       8.83 ±  9%  slabinfo.kmalloc-cg-16.active_slabs
      2334 ± 10%      -3.1%       2261 ±  9%  slabinfo.kmalloc-cg-16.num_objs
      9.12 ± 10%      -3.1%       8.83 ±  9%  slabinfo.kmalloc-cg-16.num_slabs
      1438            -0.2%       1436        slabinfo.kmalloc-cg-192.active_objs
     34.26            -0.2%      34.20        slabinfo.kmalloc-cg-192.active_slabs
      1438            -0.2%       1436        slabinfo.kmalloc-cg-192.num_objs
     34.26            -0.2%      34.20        slabinfo.kmalloc-cg-192.num_slabs
      1217 ±  3%      -1.4%       1200 ±  3%  slabinfo.kmalloc-cg-1k.active_objs
     38.04 ±  3%      -1.4%      37.51 ±  3%  slabinfo.kmalloc-cg-1k.active_slabs
      1217 ±  3%      -1.4%       1200 ±  3%  slabinfo.kmalloc-cg-1k.num_objs
     38.04 ±  3%      -1.4%      37.51 ±  3%  slabinfo.kmalloc-cg-1k.num_slabs
    287.38 ±  3%      +0.5%     288.79 ±  3%  slabinfo.kmalloc-cg-256.active_objs
      8.98 ±  3%      +0.5%       9.02 ±  3%  slabinfo.kmalloc-cg-256.active_slabs
    287.38 ±  3%      +0.5%     288.79 ±  3%  slabinfo.kmalloc-cg-256.num_objs
      8.98 ±  3%      +0.5%       9.02 ±  3%  slabinfo.kmalloc-cg-256.num_slabs
    295.74 ±  5%      -0.8%     293.24 ±  8%  slabinfo.kmalloc-cg-2k.active_objs
     18.48 ±  5%      -0.8%      18.33 ±  8%  slabinfo.kmalloc-cg-2k.active_slabs
    295.74 ±  5%      -0.8%     293.24 ±  8%  slabinfo.kmalloc-cg-2k.num_objs
     18.48 ±  5%      -0.8%      18.33 ±  8%  slabinfo.kmalloc-cg-2k.num_slabs
      4134            +0.4%       4150        slabinfo.kmalloc-cg-32.active_objs
     32.30            +0.4%      32.42        slabinfo.kmalloc-cg-32.active_slabs
      4134            +0.4%       4150        slabinfo.kmalloc-cg-32.num_objs
     32.30            +0.4%      32.42        slabinfo.kmalloc-cg-32.num_slabs
    301.67            -0.2%     300.99        slabinfo.kmalloc-cg-4k.active_objs
     37.71            -0.2%      37.62        slabinfo.kmalloc-cg-4k.active_slabs
    301.67            -0.2%     300.99        slabinfo.kmalloc-cg-4k.num_objs
     37.71            -0.2%      37.62        slabinfo.kmalloc-cg-4k.num_slabs
      1050            +0.1%       1052        slabinfo.kmalloc-cg-512.active_objs
     32.83            +0.1%      32.88        slabinfo.kmalloc-cg-512.active_slabs
      1050            +0.1%       1052        slabinfo.kmalloc-cg-512.num_objs
     32.83            +0.1%      32.88        slabinfo.kmalloc-cg-512.num_slabs
      1064 ±  7%      +0.3%       1067 ± 10%  slabinfo.kmalloc-cg-64.active_objs
     16.63 ±  7%      +0.3%      16.68 ± 10%  slabinfo.kmalloc-cg-64.active_slabs
      1064 ±  7%      +0.3%       1067 ± 10%  slabinfo.kmalloc-cg-64.num_objs
     16.63 ±  7%      +0.3%      16.68 ± 10%  slabinfo.kmalloc-cg-64.num_slabs
     16425            +0.3%      16467        slabinfo.kmalloc-cg-8.active_objs
     32.08            +0.3%      32.16        slabinfo.kmalloc-cg-8.active_slabs
     16425            +0.3%      16467        slabinfo.kmalloc-cg-8.num_objs
     32.08            +0.3%      32.16        slabinfo.kmalloc-cg-8.num_slabs
     16.78 ±  6%      +2.2%      17.15 ±  5%  slabinfo.kmalloc-cg-8k.active_objs
      4.20 ±  6%      +2.2%       4.29 ±  5%  slabinfo.kmalloc-cg-8k.active_slabs
     16.78 ±  6%      +2.2%      17.15 ±  5%  slabinfo.kmalloc-cg-8k.num_objs
      4.20 ±  6%      +2.2%       4.29 ±  5%  slabinfo.kmalloc-cg-8k.num_slabs
      1210 ±  5%      +1.8%       1231 ±  4%  slabinfo.kmalloc-cg-96.active_objs
     28.82 ±  5%      +1.8%      29.33 ±  4%  slabinfo.kmalloc-cg-96.active_slabs
      1210 ±  5%      +1.8%       1231 ±  4%  slabinfo.kmalloc-cg-96.num_objs
     28.82 ±  5%      +1.8%      29.33 ±  4%  slabinfo.kmalloc-cg-96.num_slabs
    162.01 ±  6%      -3.3%     156.70 ± 11%  slabinfo.kmalloc-rcl-128.active_objs
      5.06 ±  6%      -3.3%       4.90 ± 11%  slabinfo.kmalloc-rcl-128.active_slabs
    162.01 ±  6%      -3.3%     156.70 ± 11%  slabinfo.kmalloc-rcl-128.num_objs
      5.06 ±  6%      -3.3%       4.90 ± 11%  slabinfo.kmalloc-rcl-128.num_slabs
     85.75 ±  6%      -2.0%      84.00 ± 10%  slabinfo.kmalloc-rcl-192.active_objs
      2.04 ±  6%      -2.0%       2.00 ± 10%  slabinfo.kmalloc-rcl-192.active_slabs
     85.75 ±  6%      -2.0%      84.00 ± 10%  slabinfo.kmalloc-rcl-192.num_objs
      2.04 ±  6%      -2.0%       2.00 ± 10%  slabinfo.kmalloc-rcl-192.num_slabs
      2418 ±  5%      +0.9%       2440 ±  7%  slabinfo.kmalloc-rcl-64.active_objs
     38.21 ±  5%      +0.8%      38.50 ±  6%  slabinfo.kmalloc-rcl-64.active_slabs
      2445 ±  5%      +0.8%       2464 ±  6%  slabinfo.kmalloc-rcl-64.num_objs
     38.21 ±  5%      +0.8%      38.50 ±  6%  slabinfo.kmalloc-rcl-64.num_slabs
      1174 ±  7%      -1.2%       1160 ±  4%  slabinfo.kmalloc-rcl-96.active_objs
     28.08 ±  6%      -1.2%      27.75 ±  4%  slabinfo.kmalloc-rcl-96.active_slabs
      1179 ±  6%      -1.2%       1165 ±  4%  slabinfo.kmalloc-rcl-96.num_objs
     28.08 ±  6%      -1.2%      27.75 ±  4%  slabinfo.kmalloc-rcl-96.num_slabs
    337.33 ±  7%      +0.8%     340.00 ±  7%  slabinfo.kmem_cache.active_objs
     10.54 ±  7%      +0.8%      10.62 ±  7%  slabinfo.kmem_cache.active_slabs
    337.33 ±  7%      +0.8%     340.00 ±  7%  slabinfo.kmem_cache.num_objs
     10.54 ±  7%      +0.8%      10.62 ±  7%  slabinfo.kmem_cache.num_slabs
    704.50 ±  7%      +1.1%     712.50 ±  7%  slabinfo.kmem_cache_node.active_objs
     11.50 ±  7%      +1.1%      11.62 ±  6%  slabinfo.kmem_cache_node.active_slabs
    736.00 ±  7%      +1.1%     744.00 ±  6%  slabinfo.kmem_cache_node.num_objs
     11.50 ±  7%      +1.1%      11.62 ±  6%  slabinfo.kmem_cache_node.num_slabs
      7086 ±  5%      -0.1%       7081 ±  5%  slabinfo.lsm_file_cache.active_objs
     41.77 ±  5%      -0.3%      41.66 ±  5%  slabinfo.lsm_file_cache.active_slabs
      7100 ±  5%      -0.3%       7082 ±  5%  slabinfo.lsm_file_cache.num_objs
     41.77 ±  5%      -0.3%      41.66 ±  5%  slabinfo.lsm_file_cache.num_slabs
     42359            -0.1%      42303        slabinfo.lsm_inode_cache.active_objs
    662.09            -0.1%     661.17        slabinfo.lsm_inode_cache.active_slabs
     42373            -0.1%      42315        slabinfo.lsm_inode_cache.num_objs
    662.09            -0.1%     661.17        slabinfo.lsm_inode_cache.num_slabs
      4026 ±  3%      -0.7%       3999 ±  2%  slabinfo.maple_node.active_objs
    156.57 ±  4%      -1.6%     154.01 ±  4%  slabinfo.maple_node.active_slabs
      5010 ±  4%      -1.6%       4928 ±  4%  slabinfo.maple_node.num_objs
    156.57 ±  4%      -1.6%     154.01 ±  4%  slabinfo.maple_node.num_slabs
    250.42 ± 18%     +17.5%     294.28 ± 36%  slabinfo.mb_cache_entry.active_objs
      4.49 ±  5%     +10.0%       4.95 ± 18%  slabinfo.mb_cache_entry.active_slabs
    328.11 ±  5%     +10.0%     361.06 ± 18%  slabinfo.mb_cache_entry.num_objs
      4.49 ±  5%     +10.0%       4.95 ± 18%  slabinfo.mb_cache_entry.num_slabs
    813.98            +1.0%     821.95        slabinfo.mm_struct.active_objs
     33.92            +1.0%      34.25        slabinfo.mm_struct.active_slabs
    813.98            +1.0%     821.95        slabinfo.mm_struct.num_objs
     33.92            +1.0%      34.25        slabinfo.mm_struct.num_slabs
    575.75 ±  5%      -0.3%     574.00 ±  5%  slabinfo.mnt_cache.active_objs
     13.71 ±  5%      -0.3%      13.67 ±  5%  slabinfo.mnt_cache.active_slabs
    575.75 ±  5%      -0.3%     574.00 ±  5%  slabinfo.mnt_cache.num_objs
     13.71 ±  5%      -0.3%      13.67 ±  5%  slabinfo.mnt_cache.num_slabs
     17.00            +0.0%      17.00        slabinfo.mqueue_inode_cache.active_objs
      0.50            +0.0%       0.50        slabinfo.mqueue_inode_cache.active_slabs
     17.00            +0.0%      17.00        slabinfo.mqueue_inode_cache.num_objs
      0.50            +0.0%       0.50        slabinfo.mqueue_inode_cache.num_slabs
    256.00            +0.0%     256.00        slabinfo.names_cache.active_objs
     32.00            +0.0%      32.00        slabinfo.names_cache.active_slabs
    256.00            +0.0%     256.00        slabinfo.names_cache.num_objs
     32.00            +0.0%      32.00        slabinfo.names_cache.num_slabs
      3.50            +0.0%       3.50        slabinfo.net_namespace.active_objs
      0.50            +0.0%       0.50        slabinfo.net_namespace.active_slabs
      3.50            +0.0%       3.50        slabinfo.net_namespace.num_objs
      0.50            +0.0%       0.50        slabinfo.net_namespace.num_slabs
     23.00            +0.0%      23.00        slabinfo.nfs_commit_data.active_objs
      0.50            +0.0%       0.50        slabinfo.nfs_commit_data.active_slabs
     23.00            +0.0%      23.00        slabinfo.nfs_commit_data.num_objs
      0.50            +0.0%       0.50        slabinfo.nfs_commit_data.num_slabs
    175.00 ± 18%      +1.3%     177.33 ± 17%  slabinfo.nsproxy.active_objs
      3.12 ± 18%      +1.3%       3.17 ± 17%  slabinfo.nsproxy.active_slabs
    175.00 ± 18%      +1.3%     177.33 ± 17%  slabinfo.nsproxy.num_objs
      3.12 ± 18%      +1.3%       3.17 ± 17%  slabinfo.nsproxy.num_slabs
    437.34 ±  7%      -3.3%     423.02 ±  8%  slabinfo.numa_policy.active_objs
      7.29 ±  7%      -3.3%       7.05 ±  8%  slabinfo.numa_policy.active_slabs
    437.34 ±  7%      -3.3%     423.02 ±  8%  slabinfo.numa_policy.num_objs
      7.29 ±  7%      -3.3%       7.05 ±  8%  slabinfo.numa_policy.num_slabs
     65.93 ± 25%      -7.6%      60.95        slabinfo.pending_reservation.active_objs
      0.52 ± 25%      -7.6%       0.48        slabinfo.pending_reservation.active_slabs
     65.93 ± 25%      -7.6%      60.95        slabinfo.pending_reservation.num_objs
      0.52 ± 25%      -7.6%       0.48        slabinfo.pending_reservation.num_slabs
      1403            +0.0%       1403        slabinfo.perf_event.active_objs
     58.65            +0.2%      58.75        slabinfo.perf_event.active_slabs
      1407            +0.2%       1410        slabinfo.perf_event.num_objs
     58.65            +0.2%      58.75        slabinfo.perf_event.num_slabs
      1787 ±  2%      +0.8%       1802 ±  2%  slabinfo.pid.active_objs
     55.87 ±  2%      +1.2%      56.53        slabinfo.pid.active_slabs
      1787 ±  2%      +1.2%       1808        slabinfo.pid.num_objs
     55.87 ±  2%      +1.2%      56.53        slabinfo.pid.num_slabs
      2902            +0.9%       2928        slabinfo.pool_workqueue.active_objs
     90.81            +1.0%      91.70        slabinfo.pool_workqueue.active_slabs
      2905            +1.0%       2934        slabinfo.pool_workqueue.num_objs
     90.81            +1.0%      91.70        slabinfo.pool_workqueue.num_slabs
    161.17 ± 10%      -0.5%     160.40 ±  9%  slabinfo.posix_timers_cache.active_objs
      5.04 ± 10%      -0.5%       5.01 ±  9%  slabinfo.posix_timers_cache.active_slabs
    161.17 ± 10%      -0.5%     160.40 ±  9%  slabinfo.posix_timers_cache.num_objs
      5.04 ± 10%      -0.5%       5.01 ±  9%  slabinfo.posix_timers_cache.num_slabs
      1599            +0.0%       1599        slabinfo.proc_dir_entry.active_objs
     38.08            +0.0%      38.08        slabinfo.proc_dir_entry.active_slabs
      1599            +0.0%       1599        slabinfo.proc_dir_entry.num_objs
     38.08            +0.0%      38.08        slabinfo.proc_dir_entry.num_slabs
      4151            -0.4%       4133        slabinfo.proc_inode_cache.active_objs
     88.42            -0.5%      87.99        slabinfo.proc_inode_cache.active_slabs
      4155            -0.5%       4135        slabinfo.proc_inode_cache.num_objs
     88.42            -0.5%      87.99        slabinfo.proc_inode_cache.num_slabs
     16034            -0.0%      16032        slabinfo.radix_tree_node.active_objs
    286.76            -0.1%     286.58        slabinfo.radix_tree_node.active_slabs
     16058            -0.1%      16048        slabinfo.radix_tree_node.num_objs
    286.76            -0.1%     286.58        slabinfo.radix_tree_node.num_slabs
    155.21 ± 21%      -9.9%     139.88 ± 34%  slabinfo.request_queue.active_objs
      6.50 ± 15%      -5.8%       6.12 ± 22%  slabinfo.request_queue.active_slabs
    221.00 ± 15%      -5.8%     208.25 ± 22%  slabinfo.request_queue.num_objs
      6.50 ± 15%      -5.8%       6.12 ± 22%  slabinfo.request_queue.num_slabs
     23.00            +0.0%      23.00        slabinfo.rpc_inode_cache.active_objs
      0.50            +0.0%       0.50        slabinfo.rpc_inode_cache.active_slabs
     23.00            +0.0%      23.00        slabinfo.rpc_inode_cache.num_objs
      0.50            +0.0%       0.50        slabinfo.rpc_inode_cache.num_slabs
      6496            -0.1%       6490        slabinfo.scsi_sense_cache.active_objs
    203.04            -0.0%     202.96        slabinfo.scsi_sense_cache.active_slabs
      6497            -0.0%       6494        slabinfo.scsi_sense_cache.num_objs
    203.04            -0.0%     202.96        slabinfo.scsi_sense_cache.num_slabs
      1088            +0.0%       1088        slabinfo.seq_file.active_objs
     32.00            +0.0%      32.00        slabinfo.seq_file.active_slabs
      1088            +0.0%       1088        slabinfo.seq_file.num_objs
     32.00            +0.0%      32.00        slabinfo.seq_file.num_slabs
     11960            +0.3%      11999        slabinfo.shared_policy_node.active_objs
    140.71            +0.3%     141.17        slabinfo.shared_policy_node.active_slabs
     11960            +0.3%      11999        slabinfo.shared_policy_node.num_objs
    140.71            +0.3%     141.17        slabinfo.shared_policy_node.num_slabs
      1976 ±  3%      +0.1%       1977 ±  3%  slabinfo.shmem_inode_cache.active_objs
     45.98 ±  3%      +0.1%      46.04 ±  3%  slabinfo.shmem_inode_cache.active_slabs
      1977 ±  3%      +0.1%       1979 ±  3%  slabinfo.shmem_inode_cache.num_objs
     45.98 ±  3%      +0.1%      46.04 ±  3%  slabinfo.shmem_inode_cache.num_slabs
    897.96 ±  2%      +0.6%     903.08        slabinfo.sighand_cache.active_objs
     59.86 ±  2%      +0.6%      60.21        slabinfo.sighand_cache.active_slabs
    897.96 ±  2%      +0.6%     903.08        slabinfo.sighand_cache.num_objs
     59.86 ±  2%      +0.6%      60.21        slabinfo.sighand_cache.num_slabs
      1425            +1.1%       1441        slabinfo.signal_cache.active_objs
     52.00            +1.1%      52.55        slabinfo.signal_cache.active_slabs
      1455            +1.1%       1471        slabinfo.signal_cache.num_objs
     52.00            +1.1%      52.55        slabinfo.signal_cache.num_slabs
      1661            -0.1%       1658        slabinfo.sigqueue.active_objs
     32.57            -0.1%      32.53        slabinfo.sigqueue.active_slabs
      1661            -0.1%       1658        slabinfo.sigqueue.num_objs
     32.57            -0.1%      32.53        slabinfo.sigqueue.num_slabs
    256.00            +0.0%     256.00        slabinfo.skbuff_ext_cache.active_objs
     13.00            +0.0%      13.00        slabinfo.skbuff_ext_cache.active_slabs
    416.00            +0.0%     416.00        slabinfo.skbuff_ext_cache.num_objs
     13.00            +0.0%      13.00        slabinfo.skbuff_ext_cache.num_slabs
      1516 ±  6%      -0.4%       1510 ±  3%  slabinfo.skbuff_head_cache.active_objs
     48.12 ±  4%      -0.9%      47.71 ±  3%  slabinfo.skbuff_head_cache.active_slabs
      1540 ±  4%      -0.9%       1526 ±  3%  slabinfo.skbuff_head_cache.num_objs
     48.12 ±  4%      -0.9%      47.71 ±  3%  slabinfo.skbuff_head_cache.num_slabs
      1910 ±  4%      -1.8%       1876 ±  5%  slabinfo.skbuff_small_head.active_objs
     38.12 ±  4%      -1.9%      37.42 ±  5%  slabinfo.skbuff_small_head.active_slabs
      1944 ±  4%      -1.9%       1908 ±  5%  slabinfo.skbuff_small_head.num_objs
     38.12 ±  4%      -1.9%      37.42 ±  5%  slabinfo.skbuff_small_head.num_slabs
      1194 ±  7%      +1.6%       1213 ±  7%  slabinfo.sock_inode_cache.active_objs
     30.62 ±  7%      +1.6%      31.12 ±  7%  slabinfo.sock_inode_cache.active_slabs
      1194 ±  7%      +1.6%       1213 ±  7%  slabinfo.sock_inode_cache.num_objs
     30.62 ±  7%      +1.6%      31.12 ±  7%  slabinfo.sock_inode_cache.num_slabs
    650.60 ±  7%      +2.6%     667.56 ± 11%  slabinfo.task_group.active_objs
     12.76 ±  7%      +2.6%      13.09 ± 11%  slabinfo.task_group.active_slabs
    650.60 ±  7%      +2.6%     667.56 ± 11%  slabinfo.task_group.num_objs
     12.76 ±  7%      +2.6%      13.09 ± 11%  slabinfo.task_group.num_slabs
    683.90            -0.2%     682.28        slabinfo.task_struct.active_objs
    344.31            -0.3%     343.29        slabinfo.task_struct.active_slabs
    688.62            -0.3%     686.59        slabinfo.task_struct.num_objs
    344.31            -0.3%     343.29        slabinfo.task_struct.num_slabs
    483.18 ± 13%     +10.1%     532.17 ± 14%  slabinfo.taskstats.active_objs
     13.06 ± 13%     +10.1%      14.38 ± 14%  slabinfo.taskstats.active_slabs
    483.18 ± 13%     +10.1%     532.17 ± 14%  slabinfo.taskstats.num_objs
     13.06 ± 13%     +10.1%      14.38 ± 14%  slabinfo.taskstats.num_slabs
      1176            +0.0%       1176        slabinfo.trace_event_file.active_objs
     28.00            +0.0%      28.00        slabinfo.trace_event_file.active_slabs
      1176            +0.0%       1176        slabinfo.trace_event_file.num_objs
     28.00            +0.0%      28.00        slabinfo.trace_event_file.num_slabs
    436.32 ±  2%      +0.5%     438.42        slabinfo.tracefs_inode_cache.active_objs
      8.90 ±  2%      +0.5%       8.95        slabinfo.tracefs_inode_cache.active_slabs
    436.32 ±  2%      +0.5%     438.42        slabinfo.tracefs_inode_cache.num_objs
      8.90 ±  2%      +0.5%       8.95        slabinfo.tracefs_inode_cache.num_slabs
     16.00            +0.0%      16.00        slabinfo.tw_sock_TCP.active_objs
      0.50            +0.0%       0.50        slabinfo.tw_sock_TCP.active_slabs
     16.00            +0.0%      16.00        slabinfo.tw_sock_TCP.num_objs
      0.50            +0.0%       0.50        slabinfo.tw_sock_TCP.num_slabs
     51.00            +0.0%      51.00        slabinfo.user_namespace.active_objs
      1.00            +0.0%       1.00        slabinfo.user_namespace.active_slabs
     51.00            +0.0%      51.00        slabinfo.user_namespace.num_objs
      1.00            +0.0%       1.00        slabinfo.user_namespace.num_slabs
     35.46 ± 14%      +4.3%      37.00        slabinfo.uts_namespace.active_objs
      0.96 ± 14%      +4.3%       1.00        slabinfo.uts_namespace.active_slabs
     35.46 ± 14%      +4.3%      37.00        slabinfo.uts_namespace.num_objs
      0.96 ± 14%      +4.3%       1.00        slabinfo.uts_namespace.num_slabs
      7036 ±  2%      +3.3%       7267 ±  3%  slabinfo.vm_area_struct.active_objs
    154.26 ±  2%      +3.0%     158.87 ±  3%  slabinfo.vm_area_struct.active_slabs
      7096 ±  2%      +3.0%       7308 ±  3%  slabinfo.vm_area_struct.num_objs
    154.26 ±  2%      +3.0%     158.87 ±  3%  slabinfo.vm_area_struct.num_slabs
      9783 ±  2%      -0.9%       9690 ±  2%  slabinfo.vma_lock.active_objs
     97.47 ±  2%      -1.0%      96.52 ±  2%  slabinfo.vma_lock.active_slabs
      9941 ±  2%      -1.0%       9845 ±  2%  slabinfo.vma_lock.num_objs
     97.47 ±  2%      -1.0%      96.52 ±  2%  slabinfo.vma_lock.num_slabs
    110777            +0.0%     110825        slabinfo.vmap_area.active_objs
      1978            +0.0%       1979        slabinfo.vmap_area.active_slabs
    110777            +0.0%     110825        slabinfo.vmap_area.num_objs
      1978            +0.0%       1979        slabinfo.vmap_area.num_slabs
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.calltrace.cycles-pp.common_startup_64
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      3.35 ± 86%      -1.6        1.79 ±119%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.35 ± 86%      -1.6        1.79 ±119%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     40.79 ± 14%      -1.5       39.29 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.79 ± 14%      -1.5       39.29 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.72 ±128%      -1.4        0.30 ±331%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.72 ±128%      -1.4        0.30 ±331%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.72 ±128%      -1.4        0.30 ±331%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.72 ±128%      -1.4        0.30 ±331%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.86 ±127%      -1.4        1.45 ±132%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.85 ±201%      -1.3        0.60 ±331%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.46 ±133%      -1.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__evlist__disable.__cmd_record.cmd_record.run_builtin.main
      2.29 ±105%      -1.2        1.06 ±143%  perf-profile.calltrace.cycles-pp.__d_lookup.d_hash_and_lookup.proc_fill_cache.proc_pid_readdir.iterate_dir
      2.29 ±105%      -1.2        1.06 ±143%  perf-profile.calltrace.cycles-pp.d_hash_and_lookup.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      2.86 ±127%      -1.2        1.68 ±113%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.36 ±118%      -1.1        2.26 ±103%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.88 ± 94%      -1.1        1.79 ±119%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.38 ±154%      -1.1        0.30 ±331%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head
      7.08 ± 34%      -1.1        6.00 ± 23%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main
      7.08 ± 34%      -1.1        6.00 ± 23%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main
      1.31 ±119%      -1.1        0.22 ±331%  perf-profile.calltrace.cycles-pp.mutex_unlock.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
      2.31 ± 81%      -1.1        1.24 ±119%  perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      2.33 ±120%      -1.1        1.27 ±120%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.exit_mm.do_exit
      4.11 ± 56%      -1.1        3.06 ± 96%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.11 ± 56%      -1.1        3.06 ± 96%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.04 ±187%      -1.0        0.00        perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      1.04 ±187%      -1.0        0.00        perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      1.70 ±146%      -1.0        0.68 ±174%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      1.46 ±128%      -1.0        0.45 ±225%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      2.24 ±105%      -1.0        1.24 ±150%  perf-profile.calltrace.cycles-pp.fstatat64
      0.98 ±224%      -1.0        0.00        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ±151%      -1.0        0.48 ±224%  perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      1.25 ±119%      -0.9        0.30 ±331%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      1.25 ±119%      -0.9        0.30 ±331%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.23 ±157%      -0.9        0.29 ±331%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl
      1.70 ±143%      -0.9        0.78 ±174%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      1.70 ±143%      -0.9        0.78 ±174%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      3.83 ± 73%      -0.9        2.95 ± 62%  perf-profile.calltrace.cycles-pp.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      5.71 ± 25%      -0.8        4.88 ± 25%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      5.71 ± 25%      -0.8        4.88 ± 25%  perf-profile.calltrace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.get_signal
      1.37 ±152%      -0.8        0.55 ±224%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      1.37 ±152%      -0.8        0.55 ±224%  perf-profile.calltrace.cycles-pp.ring_buffer_read_head.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.82 ±233%      -0.8        0.00        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.82 ±233%      -0.8        0.00        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.01 ±142%      -0.8        0.19 ±331%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.79 ±236%      -0.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__disable_cpu
      0.79 ±236%      -0.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__disable_cpu.__evlist__disable
      0.79 ±236%      -0.8        0.00        perf-profile.calltrace.cycles-pp.ioctl.perf_evsel__run_ioctl.perf_evsel__disable_cpu.__evlist__disable.__cmd_record
      0.79 ±236%      -0.8        0.00        perf-profile.calltrace.cycles-pp.perf_evsel__disable_cpu.__evlist__disable.__cmd_record.cmd_record.run_builtin
      0.79 ±236%      -0.8        0.00        perf-profile.calltrace.cycles-pp.perf_evsel__run_ioctl.perf_evsel__disable_cpu.__evlist__disable.__cmd_record.cmd_record
      0.79 ±231%      -0.8        0.00        perf-profile.calltrace.cycles-pp.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.26 ±149%      -0.8        0.48 ±224%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      1.46 ±128%      -0.8        0.68 ±174%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      1.25 ±119%      -0.8        0.48 ±224%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      1.25 ±119%      -0.8        0.48 ±224%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.77 ±230%      -0.8        0.00        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.77 ±230%      -0.8        0.00        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.74 ±173%      -0.7        0.00        perf-profile.calltrace.cycles-pp.get_cpu_sleep_time_us.get_idle_time.uptime_proc_show.seq_read_iter.vfs_read
      0.74 ±173%      -0.7        0.00        perf-profile.calltrace.cycles-pp.get_idle_time.uptime_proc_show.seq_read_iter.vfs_read.ksys_read
      6.46 ± 34%      -0.7        5.73 ± 43%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      6.46 ± 34%      -0.7        5.73 ± 43%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      6.46 ± 34%      -0.7        5.73 ± 43%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      6.46 ± 34%      -0.7        5.73 ± 43%  perf-profile.calltrace.cycles-pp.getdents64
      6.46 ± 34%      -0.7        5.73 ± 43%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.72 ±233%      -0.7        0.00        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      3.36 ±118%      -0.7        2.64 ±101%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.50 ±165%      -0.7        0.78 ±174%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      1.02 ±142%      -0.7        0.30 ±331%  perf-profile.calltrace.cycles-pp.balance_fair.__schedule.schedule.smpboot_thread_fn.kthread
      1.02 ±142%      -0.7        0.30 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.balance_fair.__schedule.schedule.smpboot_thread_fn
      0.71 ±236%      -0.7        0.00        perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      5.91 ± 36%      -0.7        5.20 ± 42%  perf-profile.calltrace.cycles-pp.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.71 ±124%      -0.7        1.01 ±143%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.90 ±242%      -0.7        0.22 ±331%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.19 ±186%      -0.6        0.56 ±224%  perf-profile.calltrace.cycles-pp.__close
      0.82 ±233%      -0.6        0.19 ±331%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.32 ±182%      -0.6        0.72 ±176%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.77 ±174%      -0.6        0.19 ±331%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      8.27 ± 33%      -0.6        7.70 ± 31%  perf-profile.calltrace.cycles-pp.main
      8.27 ± 33%      -0.6        7.70 ± 31%  perf-profile.calltrace.cycles-pp.run_builtin.main
      0.56 ±223%      -0.6        0.00        perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.56 ±223%      -0.6        0.00        perf-profile.calltrace.cycles-pp.kernfs_dir_pos.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.56 ±223%      -0.6        0.00        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.vfs_statx
      0.56 ±223%      -0.6        0.00        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.56 ±331%      -0.6        0.00        perf-profile.calltrace.cycles-pp.security_file_release.__fput.task_work_run.do_exit.do_group_exit
      1.10 ±141%      -0.6        0.55 ±224%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.ring_buffer_read_head.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
      1.10 ±141%      -0.6        0.55 ±224%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head.perf_mmap__read_head
      1.10 ±141%      -0.6        0.55 ±224%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head.perf_mmap__read_head.perf_mmap__push
      0.55 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.55 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__wp_page_copy_user.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.55 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.__wp_page_copy_user.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.54 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.task_work_run.do_exit
      0.54 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.security_file_free.__fput.task_work_run.do_exit.do_group_exit
      0.54 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.put_ctx._free_event.perf_event_release_kernel.perf_release.__fput
      0.54 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.try_module_get.do_dentry_open.vfs_open.do_open.path_openat
      0.54 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.54 ±225%      -0.5        0.00        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      0.53 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__p4d_alloc.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      0.53 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.get_zeroed_page_noprof.__p4d_alloc.copy_p4d_range.copy_page_range
      0.53 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.get_zeroed_page_noprof.__p4d_alloc.copy_p4d_range.copy_page_range.dup_mmap
      0.53 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.try_charge_memcg.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one
      0.53 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.mmput.exit_mm
      0.52 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.strtoumax
      0.52 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.strtoumax
      0.52 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.sched_clock_noinstr.local_clock_noinstr.local_clock.__perf_event_header__init_id.perf_prepare_sample
      0.52 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
      0.52 ±225%      -0.5        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.52 ±225%      -0.5        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_add.free_pgtables.exit_mmap.mmput.exit_mm
      0.51 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__ctype_init
      0.51 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__ctype_init
      0.51 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__ctype_init
      0.51 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__ctype_init
      0.51 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__ctype_init
      0.51 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free.__exit_signal.release_task.wait_task_zombie.__do_wait
      0.51 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.perf_event_task_tick.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.50 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc.copy_pte_range
      0.50 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy._free_event
      0.50 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.50 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc.copy_pte_range.copy_p4d_range
      0.50 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      0.50 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.pte_alloc_one.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range
      0.50 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.rcu_all_qs.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      1.71 ±124%      -0.5        1.20 ±120%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.50 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.event_function.remote_function.generic_exec_single.smp_call_function_single.event_function_call
      0.50 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.event_function_call.perf_event_for_each_child._perf_ioctl.perf_ioctl.__x64_sys_ioctl
      0.50 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.generic_exec_single.smp_call_function_single.event_function_call.perf_event_for_each_child._perf_ioctl
      0.50 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.perf_event_for_each_child._perf_ioctl.perf_ioctl.__x64_sys_ioctl.do_syscall_64
      0.50 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.remote_function.generic_exec_single.smp_call_function_single.event_function_call.perf_event_for_each_child
      0.50 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_for_each_child._perf_ioctl.perf_ioctl
      0.49 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.48 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.mem_cgroup_update_lru_size.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.48 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.p4d_offset.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.48 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.remove_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      0.76 ±173%      -0.5        0.29 ±331%  perf-profile.calltrace.cycles-pp.perf_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.72 ±174%      -0.5        0.25 ±331%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.47 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      0.47 ±223%      -0.5        0.00        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.69 ±228%      -0.5        0.22 ±331%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.47 ±225%      -0.5        0.00        perf-profile.calltrace.cycles-pp.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.47 ±225%      -0.5        0.00        perf-profile.calltrace.cycles-pp.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork
      0.47 ±225%      -0.5        0.00        perf-profile.calltrace.cycles-pp.move_queued_task.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread
      0.47 ±225%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      2.07 ± 71%      -0.5        1.61 ± 85%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.mmput.exit_mm
      0.46 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__cond_resched.change_pmd_range.change_protection_range.mprotect_fixup.do_mprotect_pkey
      0.46 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__output_copy.perf_output_copy.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event
      0.46 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.affinity__set.evlist_cpu_iterator__next.__evlist__disable.__cmd_record.cmd_record
      0.46 ±331%      -0.5        0.00        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.45 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.do_notify_parent.exit_notify.do_exit
      0.45 ±224%      -0.5        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.complete_signal.__send_signal_locked.do_notify_parent.exit_notify
      0.70 ±174%      -0.4        0.25 ±331%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.70 ±174%      -0.4        0.25 ±331%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.70 ±174%      -0.4        0.25 ±331%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.45 ±224%      -0.4        0.00        perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.74 ±174%      -0.4        0.30 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair.__schedule
      0.74 ±174%      -0.4        0.30 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.balance_fair.__schedule.schedule
      0.74 ±174%      -0.4        0.30 ±331%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.balance_fair
      1.45 ±146%      -0.4        1.01 ±143%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      1.45 ±146%      -0.4        1.01 ±143%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.42 ±331%      -0.4        0.00        perf-profile.calltrace.cycles-pp._find_next_and_bit.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq
      0.80 ±173%      -0.3        0.46 ±223%  perf-profile.calltrace.cycles-pp._compound_head.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      1.01 ±141%      -0.3        0.67 ±174%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.31 ±273%      -0.3        0.97 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.82 ±173%      -0.3        0.48 ±223%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.56 ±223%      -0.3        0.22 ±331%  perf-profile.calltrace.cycles-pp.locks_remove_file.__fput.task_work_run.do_exit.do_group_exit
      0.78 ±174%      -0.3        0.46 ±223%  perf-profile.calltrace.cycles-pp.mutex_unlock.perf_event_release_kernel.perf_release.__fput.task_work_run
      0.50 ±224%      -0.3        0.19 ±331%  perf-profile.calltrace.cycles-pp.vsnprintf.snprintf.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      0.53 ±223%      -0.3        0.22 ±331%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.__vm_area_free.exit_mmap
      0.56 ±331%      -0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.mod_objcg_state.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.seq_read_iter
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.clear_bhb_loop.fstatat64
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_next_sibling.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exec_mmap
      0.30 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exec_mmap.begin_new_exec
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.path_lookupat.filename_lookup
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.read
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_find.unmap_vmas.exit_mmap.mmput.exit_mm
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.unmap_vmas.exit_mmap.mmput
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.update_rq_clock_task.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      0.29 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma_batch_add.free_pgtables.exit_mmap.mmput
      0.51 ±224%      -0.3        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      0.51 ±223%      -0.3        0.23 ±331%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.mmput.exit_mm
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__cond_resched.kmem_cache_alloc_noprof.getname_flags.vfs_fstatat.__do_sys_newfstatat
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__kernel_text_address.unwind_get_return_address.perf_callchain_kernel.get_perf_callchain.perf_callchain
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__update_blocked_fair.sched_balance_update_blocked_averages.sched_balance_newidle.balance_fair.__schedule
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_lookup.d_hash_and_lookup.proc_fill_cache.proc_pid_readdir
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.getname_flags.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.in_gate_area_no_mm.kernel_text_address.__kernel_text_address.unwind_get_return_address.perf_callchain_kernel
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.is_vmalloc_addr.check_heap_object.__check_object_size.strncpy_from_user.getname_flags
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.kernel_text_address.__kernel_text_address.unwind_get_return_address.perf_callchain_kernel.get_perf_callchain
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.getname_flags.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_ascend.mas_next_node.mas_next_slot.mas_find.free_pgtables
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_next_node.mas_next_slot.mas_find.free_pgtables.exit_mmap
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sched_balance_update_blocked_averages.sched_balance_newidle.balance_fair.__schedule.schedule
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.strtoumax
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.unwind_get_return_address.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      0.28 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_domains
      0.47 ±223%      -0.3        0.19 ±331%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__do_fault.do_read_fault
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__call_rcu_common.__dentry_kill.dput.step_into.link_path_walk
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_topiary_replace.mas_split.mas_wr_bnode.mas_store_gfp
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_openat
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__do_fault
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__perf_event_disable.event_function.remote_function.generic_exec_single.smp_call_function_single
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__vm_munmap.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.pte_alloc_one.__do_fault.do_read_fault.do_fault
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.rep_stos_alternative.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.atomic_dec_and_mutex_lock.x86_release_hardware.hw_perf_event_destroy._free_event.perf_event_release_kernel
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.brk
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.rep_stos_alternative.copy_fpstate_to_sigframe
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.elf_load.load_elf_interp
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.elf_load.load_elf_interp.load_elf_binary
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.rep_stos_alternative.copy_fpstate_to_sigframe.get_sigframe
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.get_vma_policy.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.rep_stos_alternative
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.hw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release.__fput
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_gfp.do_brk_flags.__do_sys_brk
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.elf_load
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_topiary_replace.mas_split.mas_wr_bnode.mas_store_gfp.do_brk_flags
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_gfp.do_brk_flags.__do_sys_brk.do_syscall_64
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.memchr
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.pte_alloc_one.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.rep_stos_alternative.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.x86_release_hardware.hw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_lru_noprof.proc_alloc_inode.alloc_inode.new_inode
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.path_lookupat.filename_lookup
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__init_rwsem.inode_init_once.setup_object.shuffle_freelist.allocate_slab
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.__exit_signal.release_task.wait_task_zombie
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__x2apic_send_IPI_dest.generic_exec_single.smp_call_function_single.event_function_call.perf_event_release_kernel
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.alloc_inode.new_inode.proc_pid_make_inode.proc_pident_instantiate.proc_pident_lookup
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_lru_noprof.proc_alloc_inode.alloc_inode
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.cpuidle_governor_latency_req.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.get_cpu_device.cpuidle_governor_latency_req.menu_select.cpuidle_idle_call.do_idle
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.inode_init_once.setup_object.shuffle_freelist.allocate_slab.___slab_alloc
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru_noprof.proc_alloc_inode.alloc_inode.new_inode.proc_pid_make_inode
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.number.vsnprintf.snprintf.proc_pid_readdir.iterate_dir
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.policy_nodemask.alloc_pages_mpol_noprof.get_zeroed_page_noprof.__p4d_alloc.copy_p4d_range
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.proc_alloc_inode.alloc_inode.new_inode.proc_pid_make_inode.proc_pident_instantiate
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.refill_obj_stock.__memcg_slab_free_hook.kmem_cache_free.__exit_signal.release_task
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.setup_object.shuffle_freelist.allocate_slab.___slab_alloc.kmem_cache_alloc_lru_noprof
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.shuffle_freelist.allocate_slab.___slab_alloc.kmem_cache_alloc_lru_noprof.proc_alloc_inode
      0.27 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.strcmp
      0.97 ±185%      -0.3        0.70 ±173%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.97 ±185%      -0.3        0.70 ±173%  perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      0.97 ±185%      -0.3        0.70 ±173%  perf-profile.calltrace.cycles-pp.mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      0.77 ±173%      -0.3        0.50 ±230%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.00 ±190%      -0.3        0.73 ±177%  perf-profile.calltrace.cycles-pp.uptime_proc_show.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      0.49 ±226%      -0.3        0.22 ±331%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
      0.49 ±226%      -0.3        0.22 ±331%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__perf_event_header__init_id.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.move_queued_task.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.pmd_install.finish_fault.do_read_fault.do_fault
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__close
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.kfree.single_release.__fput.__x64_sys_close.do_syscall_64
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.local_clock.__perf_event_header__init_id.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mas_wr_walk.mas_preallocate.vma_expand.mmap_region.do_mmap
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.move_queued_task.migration_cpu_stop.cpu_stopper_thread
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.pmd_install.finish_fault.do_read_fault.do_fault.__handle_mm_fault
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.proc_exec_connector.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.seq_printf.task_state.proc_pid_status.proc_single_show.seq_read_iter
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp._IO_sputbackc.__isoc99_sscanf
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.get_zeroed_page_noprof.__p4d_alloc.copy_p4d_range
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__isoc99_sscanf
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.get_zeroed_page_noprof
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.get_zeroed_page_noprof.__p4d_alloc
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.mutex_lock.perf_event_ctx_lock_nested.perf_ioctl.__x64_sys_ioctl.do_syscall_64
      0.26 ±331%      -0.3        0.00        perf-profile.calltrace.cycles-pp.perf_event_ctx_lock_nested.perf_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ±175%      -0.3        0.48 ±224%  perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.74 ±175%      -0.3        0.48 ±224%  perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.56 ±223%      -0.3        0.30 ±331%  perf-profile.calltrace.cycles-pp.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.51 ±224%      -0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__exit_signal.release_task.wait_task_zombie.__do_wait.do_wait
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__folio_mod_stat.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.__folio_mod_stat.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__rb_insert_augmented.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.complete_signal.__send_signal_locked
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_epoll_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_create
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.call_function_single_prep_ipi.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.complete_signal
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.can_modify_mm.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_epoll_create.__x64_sys_epoll_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_create
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_create
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strtoumax
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.mmput
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.epoll_create
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.epoll_create
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.strtoumax
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.generic_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.generic_permission.inode_permission.may_open.do_open.path_openat
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.get_unused_fd_flags.do_epoll_create.__x64_sys_epoll_create.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.inode_permission.may_open.do_open.path_openat.do_filp_open
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.may_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.rcu_all_qs.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.complete_signal.__send_signal_locked.do_notify_parent
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.update_rq_clock_task.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.46 ±331%      -0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.cpu_util.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__getrlimit
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__legitimize_mnt.lookup_mnt.__traverse_mounts.step_into.link_path_walk
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.__exit_signal.release_task.wait_task_zombie
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__traverse_mounts.step_into.link_path_walk.path_openat.do_filp_open
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.lookup_mnt.__traverse_mounts.step_into.link_path_walk.path_openat
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.put_cpu_partial.kmem_cache_free.__dentry_kill.dput.__fput
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.fstatat64
      0.24 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.22 ±119%      -0.2        0.99 ±190%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__freading
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.change_pmd_range.change_protection_range.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.change_protection_range.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.cpuidle_state_show.sysfs_kf_seq_show.seq_read_iter.vfs_read.ksys_read
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.d_path.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.from_kgid_munged.cp_new_stat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.map_id_up.from_kgid_munged.cp_new_stat.__do_sys_newfstatat.do_syscall_64
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mprotect_fixup
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mprotect_fixup.do_mprotect_pkey
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_read.vfs_read
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.schedule.pipe_read
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.show_state_time.cpuidle_state_show.sysfs_kf_seq_show.seq_read_iter.vfs_read
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sysfs_kf_seq_show.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__check_object_size.seq_read_iter.seq_read.vfs_read.ksys_read
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_ctx_enable.event_function.remote_function.generic_exec_single
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__mt_destroy.exit_mmap.mmput.exec_mmap.begin_new_exec
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__update_load_avg_cfs_rq.update_load_avg.task_tick_fair.sched_tick.update_process_times
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.mmput.exec_mmap.begin_new_exec
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist__cpu_begin
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.build_detached_freelist.kmem_cache_free_bulk.mt_destroy_walk.__mt_destroy.exit_mmap
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.check_stack_object.__check_object_size.seq_read_iter.seq_read.vfs_read
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.clear_bhb_loop.__close
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist__cpu_begin.__evlist__disable
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist__cpu_begin.__evlist__disable.__cmd_record
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.evlist__cpu_begin.__evlist__disable.__cmd_record.cmd_record.run_builtin
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.irqentry_enter.sysvec_reschedule_ipi.asm_sysvec_reschedule_ipi.acpi_safe_halt.acpi_idle_enter
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free_bulk.mt_destroy_walk.__mt_destroy.exit_mmap.mmput
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.try_to_unlazy_next.lookup_fast.open_last_lookups.path_openat
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mt_destroy_walk.__mt_destroy.exit_mmap.mmput.exec_mmap
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_ctx_enable.event_function.remote_function.generic_exec_single.smp_call_function_single
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.smpboot_thread_fn
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.smpboot_thread_fn.kthread
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist__cpu_begin.__evlist__disable.__cmd_record.cmd_record
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.stack_access_ok.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.sysvec_reschedule_ipi.asm_sysvec_reschedule_ipi.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.try_to_unlazy_next.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.up_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap.mmput
      0.23 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler
      0.71 ±236%      -0.2        0.48 ±224%  perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.45 ±224%      -0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__send_signal_locked.do_notify_parent.exit_notify.do_exit.do_group_exit
      0.45 ±224%      -0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.do_notify_parent.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group
      0.45 ±224%      -0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.50 ±131%      -0.2        1.28 ±149%  perf-profile.calltrace.cycles-pp.swevent_hlist_put_cpu.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
      0.47 ±225%      -0.2        0.25 ±331%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.76 ±175%      -0.2        0.54 ±226%  perf-profile.calltrace.cycles-pp.filp_flush.filp_close.put_files_struct.do_exit.do_group_exit
      0.44 ±223%      -0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__mmdrop.finish_task_switch.__schedule.__cond_resched.__wait_for_common
      0.44 ±223%      -0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.__evlist__disable.__cmd_record.cmd_record.run_builtin
      0.44 ±223%      -0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.__cond_resched.__wait_for_common.affine_move_task
      0.50 ±224%      -0.2        0.29 ±331%  perf-profile.calltrace.cycles-pp._perf_ioctl.perf_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.task_work_run.do_exit.do_group_exit
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__rb_insert_augmented.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.copy_fs_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_elf_binary.search_binary_handler
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.elf_load.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.move_queued_task.migration_cpu_stop.cpu_stopper_thread
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.enqueue_task_fair.move_queued_task.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.getname.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone.__do_sys_clone
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free.task_work_run.do_exit.do_group_exit.get_signal
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mas_wr_walk.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_load.load_elf_binary
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.task_work_run.do_exit
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.copy_fs_struct.copy_process
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.elf_load
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.complete_signal.__send_signal_locked
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_tp_event_match.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.complete_signal
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.complete_signal.__send_signal_locked.do_notify_parent
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.seq_printf.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.sched_setaffinity.evlist_cpu_iterator__next.__evlist__enable.__cmd_record
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.move_queued_task.migration_cpu_stop
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_binary.search_binary_handler.exec_binprm
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_prepare.__split_vma.vma_modify.mprotect_fixup
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.proc_pid_status.proc_single_show.seq_read_iter
      0.21 ±331%      -0.2        0.00        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      4.18 ± 58%      -0.2        3.99 ± 49%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
      2.07 ± 71%      -0.2        1.89 ± 71%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.mmput.exit_mm.do_exit
      0.60 ±331%      -0.2        0.43 ±224%  perf-profile.calltrace.cycles-pp.fput.remove_vma.exit_mmap.mmput.exit_mm
      0.60 ±331%      -0.2        0.43 ±224%  perf-profile.calltrace.cycles-pp.remove_vma.exit_mmap.mmput.exit_mm.do_exit
      3.62 ± 88%      -0.2        3.45 ± 73%  perf-profile.calltrace.cycles-pp._free_event.perf_event_release_kernel.perf_release.__fput.task_work_run
      1.50 ±101%      -0.2        1.34 ±119%  perf-profile.calltrace.cycles-pp.filp_close.put_files_struct.do_exit.do_group_exit.get_signal
      1.50 ±101%      -0.2        1.34 ±119%  perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.46 ±331%      -0.2        0.31 ±331%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.44 ±223%      -0.2        0.29 ±331%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu
      0.44 ±223%      -0.2        0.29 ±331%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable
      0.44 ±223%      -0.2        0.29 ±331%  perf-profile.calltrace.cycles-pp.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable.__cmd_record
      0.44 ±223%      -0.2        0.29 ±331%  perf-profile.calltrace.cycles-pp.perf_evsel__enable_cpu.__evlist__enable.__cmd_record.cmd_record.perf_c2c__record
      0.44 ±223%      -0.2        0.29 ±331%  perf-profile.calltrace.cycles-pp.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable.__cmd_record.cmd_record
      6.17 ± 55%      -0.1        6.04 ± 48%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.17 ± 55%      -0.1        6.04 ± 48%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      6.17 ± 55%      -0.1        6.04 ± 48%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.17 ± 55%      -0.1        6.04 ± 48%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.53 ±223%      -0.1        0.42 ±224%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.__vm_area_free.exit_mmap.mmput
      1.54 ±100%      -0.1        1.43 ±100%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap
      1.48 ±136%      -0.1        1.38 ±100%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.48 ±136%      -0.1        1.38 ±100%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.48 ±136%      -0.1        1.38 ±100%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.29 ±331%      -0.1        0.19 ±331%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk.path_openat
      0.28 ±331%      -0.1        0.19 ±331%  perf-profile.calltrace.cycles-pp.mas_find.free_pgtables.exit_mmap.mmput.exit_mm
      0.28 ±331%      -0.1        0.19 ±331%  perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.free_pgtables.exit_mmap.mmput
      0.50 ±224%      -0.1        0.42 ±224%  perf-profile.calltrace.cycles-pp.snprintf.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.30 ±331%      -0.1        0.22 ±331%  perf-profile.calltrace.cycles-pp.__memcpy.arch_dup_task_struct.dup_task_struct.copy_process.kernel_clone
      0.30 ±331%      -0.1        0.22 ±331%  perf-profile.calltrace.cycles-pp.arch_dup_task_struct.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      0.30 ±331%      -0.1        0.22 ±331%  perf-profile.calltrace.cycles-pp.clear_bhb_loop
      0.30 ±331%      -0.1        0.22 ±331%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.53 ±223%      -0.1        0.46 ±223%  perf-profile.calltrace.cycles-pp.filldir64.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      2.81 ± 72%      -0.1        2.74 ± 69%  perf-profile.calltrace.cycles-pp.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release.__fput
      0.48 ±223%      -0.1        0.42 ±224%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.51 ±224%      -0.1        0.45 ±331%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      0.51 ±224%      -0.1        0.45 ±331%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
      0.28 ±331%      -0.1        0.22 ±331%  perf-profile.calltrace.cycles-pp.__d_lookup_unhash.__d_add.simple_lookup.__lookup_slow.walk_component
      0.28 ±331%      -0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.fput.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.__memcpy.__output_copy.perf_output_copy.__perf_event__output_id_sample.perf_event_mmap_output
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.__output_copy.perf_output_copy.__perf_event__output_id_sample.perf_event_mmap_output.perf_iterate_sb
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.__perf_event__output_id_sample.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.perf_output_copy.__perf_event__output_id_sample.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.write
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.__d_rehash.__d_add.simple_lookup.__lookup_slow.walk_component
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.dentry_unlink_inode.__dentry_kill.dput.__fput.task_work_run
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs.free_pages_and_swap_cache
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.new_inode.proc_pid_make_inode.proc_pident_instantiate.proc_pident_lookup.lookup_open
      0.85 ±173%      -0.0        0.81 ±174%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof
      0.98 ±142%      -0.0        0.94 ±141%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.97 ±185%      -0.0        0.93 ±184%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.52 ±224%      -0.0        0.48 ±224%  perf-profile.calltrace.cycles-pp.__kmalloc_node_noprof.seq_read_iter.seq_read.vfs_read.ksys_read
      0.27 ±331%      -0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_lookupat
      0.27 ±331%      -0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
      0.27 ±331%      -0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_lookupat.filename_lookup
      0.27 ±331%      -0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.23 ±331%      -0.0        0.19 ±331%  perf-profile.calltrace.cycles-pp.__d_alloc.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      0.23 ±331%      -0.0        0.19 ±331%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.23 ±331%      -0.0        0.19 ±331%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      0.23 ±331%      -0.0        0.19 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel.__lookup_slow
      0.23 ±331%      -0.0        0.19 ±331%  perf-profile.calltrace.cycles-pp.format_decode.vsnprintf.snprintf.proc_pid_readdir.iterate_dir
      0.29 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.down_write.free_pgtables.exit_mmap.mmput.exit_mm
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.cpu_stop_queue_work.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.cpu_stop_queue_work
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.wake_up_q.cpu_stop_queue_work.affine_move_task
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.cpu_stop_queue_work.affine_move_task.__set_cpus_allowed_ptr
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.wake_up_q.cpu_stop_queue_work.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.26 ±331%      -0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      1.79 ± 85%      -0.0        1.76 ±136%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.do_exit
      0.81 ±246%      -0.0        0.78 ±174%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter
      0.81 ±246%      -0.0        0.78 ±174%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable
      0.81 ±246%      -0.0        0.78 ±174%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.mas_wr_walk.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      0.24 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.24 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      1.45 ±146%      -0.0        1.44 ±102%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.45 ±146%      -0.0        1.44 ±102%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.45 ±146%      -0.0        1.44 ±102%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.45 ±146%      -0.0        1.44 ±102%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.45 ±146%      -0.0        1.44 ±102%  perf-profile.calltrace.cycles-pp.execve
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.__tlb_remove_folio_pages_size.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp._atomic_dec_and_lock.iput.__dentry_kill.dput.__fput
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.fstatat64.setlocale
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.iput.__dentry_kill.dput.__fput.task_work_run
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.single_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.__pte_offset_map.__pte_offset_map_lock.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.23 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.__schedule.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group
      0.23 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.23 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.do_task_dead.do_exit.do_group_exit
      0.23 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.do_task_dead.do_exit
      0.23 ±331%      -0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule.do_task_dead
      2.02 ± 90%      -0.0        2.01 ±117%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.do_exit.do_group_exit
      1.22 ±119%      -0.0        1.21 ±156%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.22 ±119%      -0.0        1.21 ±156%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      0.52 ±225%      +0.0        0.52 ±225%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.cp_new_stat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_unref_page_commit.free_unref_page.kmem_cache_free
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.kmem_cache_free.__dentry_kill
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.free_unref_page.kmem_cache_free.__dentry_kill.dput.__fput
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.kmem_cache_free.__dentry_kill.dput
      0.67 ±242%      +0.0        0.68 ±173%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.50 ±224%      +0.0        0.51 ±225%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.__mmdrop.finish_task_switch.__schedule.__cond_resched
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.__virt_addr_valid.check_heap_object.__check_object_size.strncpy_from_user.getname_flags
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__disable
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__disable.__cmd_record
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_event_task.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.__evlist__disable.__cmd_record.cmd_record
      2.07 ± 71%      +0.0        2.09 ± 79%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.mmput
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.find_vma.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.mt_find.find_vma.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.error_entry.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.__fput.task_work_run.do_exit
      1.24 ±119%      +0.0        1.27 ±154%  perf-profile.calltrace.cycles-pp.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy._free_event.perf_event_release_kernel
      0.27 ±331%      +0.0        0.30 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.27 ±331%      +0.0        0.30 ±331%  perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.47 ±225%      +0.0        0.50 ±223%  perf-profile.calltrace.cycles-pp.proc_pid_status.proc_single_show.seq_read_iter.seq_read.vfs_read
      0.26 ±331%      +0.0        0.30 ±331%  perf-profile.calltrace.cycles-pp.finish_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.27 ±331%      +0.0        0.31 ±331%  perf-profile.calltrace.cycles-pp.elf_load.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm
      0.27 ±331%      +0.0        0.31 ±331%  perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.99 ±142%      +0.0        1.03 ±197%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__dentry_kill.dput.__fput.task_work_run
      0.26 ±331%      +0.0        0.31 ±331%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__close
      0.26 ±331%      +0.0        0.31 ±331%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__close
      0.26 ±331%      +0.0        0.31 ±331%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__close
      0.75 ±173%      +0.1        0.80 ±173%  perf-profile.calltrace.cycles-pp.fput.filp_close.put_files_struct.do_exit.do_group_exit
      0.52 ±225%      +0.1        0.58 ±331%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.__dentry_kill.dput.__fput
      0.24 ±331%      +0.1        0.30 ±331%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.51 ±224%      +0.1        0.60 ±331%  perf-profile.calltrace.cycles-pp.generic_exec_single.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release
      2.28 ± 80%      +0.1        2.38 ± 78%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.21 ±331%      +0.1        0.31 ±331%  perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_final.free_pgtables.exit_mmap.mmput.exit_mm
      0.21 ±331%      +0.1        0.31 ±331%  perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma_batch_final.free_pgtables.exit_mmap.mmput
      1.81 ±107%      +0.1        1.95 ±124%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     17.02 ± 32%      +0.1       17.16 ± 21%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.30 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.30 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.30 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.30 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.30 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      5.62 ± 22%      +0.2        5.78 ± 21%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.main
      1.76 ±159%      +0.2        1.91 ± 72%  perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      0.54 ±223%      +0.2        0.70 ±173%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.cmd_sched.run_builtin.main
      0.54 ±223%      +0.2        0.70 ±173%  perf-profile.calltrace.cycles-pp.__evlist__enable.__cmd_record.cmd_record.cmd_sched.run_builtin
      0.54 ±223%      +0.2        0.70 ±173%  perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main
      0.54 ±223%      +0.2        0.70 ±173%  perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main
      0.54 ±223%      +0.2        0.70 ±173%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.__evlist__enable.__cmd_record.cmd_record.cmd_sched
      0.26 ±331%      +0.2        0.43 ±224%  perf-profile.calltrace.cycles-pp.kcpustat_cpu_fetch.uptime_proc_show.seq_read_iter.vfs_read.ksys_read
      1.79 ±130%      +0.2        1.96 ±116%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.79 ±130%      +0.2        1.96 ±116%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.79 ±130%      +0.2        1.96 ±116%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      1.79 ±130%      +0.2        1.96 ±116%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked.__set_cpus_allowed_ptr.__sched_setaffinity
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__do_set_cpus_allowed
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__do_set_cpus_allowed.__set_cpus_allowed_ptr_locked
      0.53 ±223%      +0.2        0.71 ±176%  perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.mmput.exit_mm.do_exit
      0.53 ±223%      +0.2        0.71 ±176%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__vm_area_free.exit_mmap.mmput.exit_mm
      0.23 ±331%      +0.2        0.43 ±224%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.46 ±223%      +0.2        0.66 ±173%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_lru_noprof.__d_alloc
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.__strdup
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.tcgetattr
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.cpu_util.update_sg_wakeup_stats.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.do_mprotect_pkey.__x64_sys_mprotect
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.free_swap_cache.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.get_jiffies_update.tmigr_requires_handle_remote.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm.copy_process
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.mas_wr_walk.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.do_mprotect_pkey
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.perf_mmap__consume
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.ring_buffer_write_tail.perf_mmap__consume
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_find_dst_cpu.select_task_rq_fair.sched_exec.bprm_execve.do_execveat_common
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.sched_exec.bprm_execve
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.tcgetattr
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.up_write.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.sched_exec
      0.00            +0.2        0.19 ±331%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      0.28 ±331%      +0.2        0.48 ±224%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.seq_read_iter.seq_read.vfs_read
      0.55 ±223%      +0.2        0.75 ±175%  perf-profile.calltrace.cycles-pp.__d_add.simple_lookup.__lookup_slow.walk_component.link_path_walk
      0.55 ±223%      +0.2        0.75 ±175%  perf-profile.calltrace.cycles-pp.simple_lookup.__lookup_slow.walk_component.link_path_walk.path_openat
      0.96 ±184%      +0.2        1.17 ±119%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.23 ±331%      +0.2        0.45 ±225%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
     24.10 ± 10%      +0.2       24.31 ± 12%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.10 ± 10%      +0.2       24.31 ± 12%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
     24.10 ± 10%      +0.2       24.31 ± 12%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     24.10 ± 10%      +0.2       24.31 ± 12%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.10 ± 10%      +0.2       24.31 ± 12%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.23 ±331%      +0.2        0.45 ±331%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.26 ±331%      +0.2        0.48 ±223%  perf-profile.calltrace.cycles-pp.fstatat64.setlocale
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__memcpy_chk
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__rb_insert_augmented.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__wake_up.ep_poll_callback.__wake_up_common.__wake_up.__send_signal_locked
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up.ep_poll_callback.__wake_up_common.__wake_up
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__x2apic_send_IPI_dest.ttwu_queue_wakelist.try_to_wake_up.ep_autoremove_wake_function.__wake_up_common
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_wait_for_writeback.evict.__dentry_kill.shrink_dentry_list
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__memcpy_chk
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.d_invalidate.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.__do_wait
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__memcpy_chk
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.down_read.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.ep_autoremove_wake_function.__wake_up_common.__wake_up.ep_poll_callback.__wake_up_common
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.ep_poll_callback.__wake_up_common.__wake_up.__send_signal_locked.do_notify_parent
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__memcpy_chk
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.generic_fillattr.pid_getattr.vfs_statx_path.vfs_statx.vfs_fstatat
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__memcpy_chk
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.inode_wait_for_writeback.evict.__dentry_kill.shrink_dentry_list.shrink_dcache_parent
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.manager_get_unit_by_pid_cgroup
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.mutex_lock.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.restore_regs_and_return_to_kernel.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache.release_task.wait_task_zombie
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache.release_task
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.try_to_wake_up.ep_autoremove_wake_function.__wake_up_common.__wake_up.ep_poll_callback
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.ep_autoremove_wake_function.__wake_up_common.__wake_up
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.vma_merge.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp._IO_setvbuf
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.vma_modify
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__schedule.schedule.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.access_error.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._IO_setvbuf
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault._IO_setvbuf
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._IO_setvbuf
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault._IO_setvbuf
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.fsnotify_open_perm.do_dentry_open.vfs_open.do_open.path_openat
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.get_stack_info.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.idle_cpu.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.vma_modify.mprotect_fixup
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_callchain_user.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_task.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.put_prev_entity.put_prev_task_fair.__schedule.schedule.irqentry_exit_to_user_mode
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.put_prev_task_fair.__schedule.schedule.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.schedule.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.up_read.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.up_read.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.update_curr.put_prev_entity.put_prev_task_fair.__schedule.schedule
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.proc_invalidate_siblings_dcache.release_task.wait_task_zombie
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp._atomic_dec_and_lock.iput.__dentry_kill.dput.proc_invalidate_siblings_dcache
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp._find_next_or_bit.__percpu_counter_sum.__mmdrop.finish_task_switch.__schedule
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.alloc_empty_file.path_openat
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.dput.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.__do_wait
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.exit_mmap.mmput
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.folio_mark_accessed.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.iput.__dentry_kill.dput.proc_invalidate_siblings_dcache.release_task
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.kvm_guest_state.perf_instruction_pointer.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.lru_add_drain.exit_mmap.mmput.exit_mm.do_exit
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.exit_mmap.mmput.exit_mm
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.exit_mmap
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.malloc
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.mas_find.exit_mmap.mmput.exec_mmap.begin_new_exec
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.exit_mmap.mmput.exec_mmap
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.perf_instruction_pointer.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_update_blocked_averages.sched_balance_newidle.pick_next_task_fair.__schedule.schedule
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.setup_object.shuffle_freelist.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.shuffle_freelist.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.alloc_empty_file
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.update_rt_rq_load_avg.sched_balance_update_blocked_averages.sched_balance_newidle.pick_next_task_fair.__schedule
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.vm_get_page_prot.vma_set_page_prot.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.vma_set_page_prot.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.00            +0.2        0.22 ±331%  perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.folio_mark_accessed.shmem_get_folio_gfp.shmem_write_begin
      0.58 ±223%      +0.2        0.81 ±174%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__mmdrop.finish_task_switch.schedule_tail.ret_from_fork.ret_from_fork_asm
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.__mmdrop.finish_task_switch.schedule_tail.ret_from_fork
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_wait.kernel_wait4
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.finish_task_switch.schedule_tail.ret_from_fork.ret_from_fork_asm._Fork
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.hash_name.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.exit_mmap.mmput
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm._Fork
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm._Fork
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.schedule_tail.ret_from_fork.ret_from_fork_asm._Fork
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__count_memcg_events.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64.setlocale
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__pipe
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap.mmput
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.__x64_sys_pipe2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__pipe
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp._find_next_bit.flush_tlb_mm_range.ptep_clear_flush.wp_page_copy.__handle_mm_fault
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.alloc_inode.create_pipe_files.do_pipe2.__x64_sys_pipe2.do_syscall_64
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.fput.path_openat.do_filp_open
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.ring_buffer_write_tail.perf_mmap__write_tail.perf_mmap__consume.perf_mmap__push
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.cgroup_rstat_updated.__count_memcg_events.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.check_cpu_stall.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_nohz_handler
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.create_pipe_files.do_pipe2.__x64_sys_pipe2.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.do_pipe2.__x64_sys_pipe2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__pipe
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__pipe
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64.setlocale
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.do_task_stat.proc_single_show.seq_read_iter.seq_read.vfs_read
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_write_tail.perf_mmap__write_tail
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__pipe
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64.setlocale
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.ring_buffer_write_tail.perf_mmap__write_tail.perf_mmap__consume
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.ptep_clear_flush.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.inode_init_always.alloc_inode.create_pipe_files.do_pipe2.__x64_sys_pipe2
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always.alloc_inode.create_pipe_files
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_write_tail
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.mas_store.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.perf_mmap__consume.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.perf_mmap__write_tail.perf_mmap__consume.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.ptep_clear_flush.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.ring_buffer_write_tail.perf_mmap__write_tail.perf_mmap__consume.perf_mmap__push.record__mmap_read_evlist
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_rq.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.security_file_free.fput.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.security_inode_alloc.inode_init_always.alloc_inode.create_pipe_files.do_pipe2
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.task_work_add.fput.remove_vma.exit_mmap.mmput
      0.00            +0.2        0.23 ±331%  perf-profile.calltrace.cycles-pp.up_read.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.21 ±331%      +0.2        0.45 ±223%  perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.18 ±153%      +0.2        1.42 ±101%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.18 ±153%      +0.2        1.42 ±101%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.27 ±331%      +0.2        0.51 ±225%  perf-profile.calltrace.cycles-pp.proc_pid_make_inode.proc_pident_instantiate.proc_pident_lookup.lookup_open.open_last_lookups
      0.27 ±331%      +0.2        0.51 ±225%  perf-profile.calltrace.cycles-pp.proc_pident_instantiate.proc_pident_lookup.lookup_open.open_last_lookups.path_openat
      0.27 ±331%      +0.2        0.51 ±225%  perf-profile.calltrace.cycles-pp.proc_pident_lookup.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.26 ±331%      +0.2        0.50 ±331%  perf-profile.calltrace.cycles-pp.task_state.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__cleanup_sighand.__exit_signal.release_task.wait_task_zombie.__do_wait
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__do_wait.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__mod_lruvec_state.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.kernfs_fop_open.do_dentry_open.vfs_open.do_open.path_openat
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_free.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.path_openat.do_filp_open
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.mutex_unlock.kernfs_fop_open.do_dentry_open.vfs_open.do_open
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.__do_wait.do_wait.kernel_wait4
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.up_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert_after.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.wait_task_zombie.__do_wait.do_wait.kernel_wait4.__do_sys_wait4
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.put_prev_entity
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.mmput.exec_mmap
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__vfs_getxattr.do_getxattr.getxattr.path_getxattr.do_syscall_64
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.__fput.task_work_run
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_fault.__handle_mm_fault
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.do_getxattr.getxattr.path_getxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.lgetxattr
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.lgetxattr
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.getxattr.path_getxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe.lgetxattr
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.kernfs_vfs_xattr_get.__vfs_getxattr.do_getxattr.getxattr.path_getxattr
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.lgetxattr
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.ring_buffer_read_head
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.path_getxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe.lgetxattr
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.perf_output_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.put_prev_entity.put_prev_task_fair
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.put_prev_entity.put_prev_task_fair.__schedule
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.refill_obj_stock.__memcg_slab_free_hook.kmem_cache_free.exit_mmap.mmput
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.strlen.xattr_full_name.kernfs_vfs_xattr_get.__vfs_getxattr.do_getxattr
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.mmput.exec_mmap.begin_new_exec
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.update_curr.put_prev_entity.put_prev_task_fair.__schedule.__cond_resched
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.xattr_full_name.kernfs_vfs_xattr_get.__vfs_getxattr.do_getxattr.getxattr
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kfree.seq_release.kernfs_fop_release.__fput
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault._Fork
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.strnlen
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.cgroup_rstat_updated.__mod_memcg_lruvec_state.mod_objcg_state.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._Fork
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strnlen
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault._Fork
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.strnlen
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._Fork
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.strnlen
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.kernfs_fop_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.kfree.seq_release.kernfs_fop_release.__fput.__x64_sys_close
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.mmap_region.do_mmap
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.__kmalloc_node_noprof.seq_read_iter.seq_read
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.__memcg_slab_free_hook.kfree.seq_release.kernfs_fop_release
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.proc_task_name.proc_pid_status.proc_single_show.seq_read_iter.seq_read
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.seq_release.kernfs_fop_release.__fput.__x64_sys_close.do_syscall_64
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.strnlen
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.strnlen.proc_task_name.proc_pid_status.proc_single_show.seq_read_iter
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.task_work_add.fput.filp_close.put_files_struct.do_exit
      0.00            +0.3        0.25 ±331%  perf-profile.calltrace.cycles-pp.update_load_avg.put_prev_entity.put_prev_task_fair.__schedule.__cond_resched
      0.70 ±174%      +0.3        0.96 ±141%  perf-profile.calltrace.cycles-pp.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity
      0.56 ±223%      +0.3        0.82 ±174%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.47 ±225%      +0.3        0.74 ±173%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      0.49 ±224%      +0.3        0.76 ±175%  perf-profile.calltrace.cycles-pp.getenv
      0.23 ±331%      +0.3        0.50 ±223%  perf-profile.calltrace.cycles-pp.igrab.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.__do_wait
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.calltrace.cycles-pp.find_ge_pid.next_tgid.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.calltrace.cycles-pp.idr_get_next.find_ge_pid.next_tgid.proc_pid_readdir.iterate_dir
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.calltrace.cycles-pp.idr_get_next_ul.idr_get_next.find_ge_pid.next_tgid.proc_pid_readdir
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.calltrace.cycles-pp.radix_tree_next_chunk.idr_get_next_ul.idr_get_next.find_ge_pid.next_tgid
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.___pte_free_tlb.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.___pte_free_tlb.free_pud_range.free_p4d_range.free_pgd_range
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.___pte_free_tlb.free_pud_range.free_p4d_range
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.__percpu_counter_init_many.mm_init.dup_mm.copy_process.kernel_clone
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.exit_mmap.mmput.exit_mm
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_ptes.set_pte_range.filemap_map_pages.do_read_fault.do_fault
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.free_p4d_range.free_pgd_range.free_pgtables.exit_mmap.mmput
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.free_pgd_range.free_pgtables.exit_mmap.mmput.exit_mm
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables.exit_mmap
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.get_task_pid.proc_pid_make_inode.proc_pident_instantiate.proc_pident_lookup.lookup_open
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm.copy_process
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.pcpu_alloc_area.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init.dup_mm
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init.dup_mm.copy_process
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.pcpu_block_update_hint_alloc.pcpu_alloc_area.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      0.00            +0.3        0.29 ±331%  perf-profile.calltrace.cycles-pp.put_ctx.perf_event_release_kernel.perf_release.__fput.task_work_run
      0.44 ±223%      +0.3        0.73 ±173%  perf-profile.calltrace.cycles-pp.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.44 ±223%      +0.3        0.73 ±173%  perf-profile.calltrace.cycles-pp.__schedule.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      0.44 ±223%      +0.3        0.73 ±173%  perf-profile.calltrace.cycles-pp.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity
      0.00            +0.3        0.30 ±331%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range
      0.00            +0.3        0.30 ±331%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      0.00            +0.3        0.30 ±331%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_ptes.set_pte_range.finish_fault.do_read_fault.do_fault
      0.00            +0.3        0.30 ±331%  perf-profile.calltrace.cycles-pp.readdir64
      0.00            +0.3        0.30 ±331%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.3        0.30 ±331%  perf-profile.calltrace.cycles-pp.up_read.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.generic_file_mmap.mmap_region.do_mmap
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.generic_file_mmap.mmap_region.do_mmap.vm_mmap_pgoff.elf_load
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.get_unused_fd_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__close
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.make_vfsuid.atime_needs_update.touch_atime.generic_file_mmap.mmap_region
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.touch_atime.generic_file_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
      0.00            +0.3        0.31 ±331%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      9.45 ± 43%      +0.3        9.77 ± 24%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.exit_mm.do_exit.do_group_exit
      3.67 ± 52%      +0.3        3.99 ± 49%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
      3.67 ± 52%      +0.3        3.99 ± 49%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      2.81 ±125%      +0.3        3.15 ± 76%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.65 ±234%      +0.3        1.00 ±142%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.perf_c2c__record.run_builtin.main
      0.65 ±234%      +0.3        1.00 ±142%  perf-profile.calltrace.cycles-pp.__evlist__enable.__cmd_record.cmd_record.perf_c2c__record.run_builtin
      0.65 ±234%      +0.3        1.00 ±142%  perf-profile.calltrace.cycles-pp.cmd_record.perf_c2c__record.run_builtin.main
      0.65 ±234%      +0.3        1.00 ±142%  perf-profile.calltrace.cycles-pp.perf_c2c__record.run_builtin.main
      0.24 ±331%      +0.4        0.60 ±331%  perf-profile.calltrace.cycles-pp.__smp_call_single_queue.generic_exec_single.smp_call_function_single.event_function_call.perf_event_release_kernel
      0.24 ±331%      +0.4        0.60 ±331%  perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.generic_exec_single.smp_call_function_single.event_function_call
      0.54 ±225%      +0.4        0.91 ±141%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.60 ±331%      +0.4        0.97 ±144%  perf-profile.calltrace.cycles-pp.perf_remove_from_owner.perf_event_release_kernel.perf_release.__fput.task_work_run
      0.00            +0.4        0.39 ±331%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.ring_buffer_write_tail.perf_mmap__consume
      0.00            +0.4        0.39 ±331%  perf-profile.calltrace.cycles-pp.sd_pid_notify_with_fds
      5.38 ± 26%      +0.4        5.78 ± 21%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      1.04 ±187%      +0.4        1.44 ±101%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.51 ±223%      +0.4        0.92 ±142%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.78 ±173%      +0.4        1.19 ±120%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
      1.54 ±130%      +0.4        1.96 ±116%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±331%      +0.4        0.70 ±173%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      0.00            +0.4        0.43 ±224%  perf-profile.calltrace.cycles-pp._copy_to_iter.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00            +0.4        0.43 ±224%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault._copy_to_iter.seq_read_iter.vfs_read.ksys_read
      0.00            +0.4        0.43 ±224%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._copy_to_iter.seq_read_iter
      0.00            +0.4        0.43 ±224%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault._copy_to_iter.seq_read_iter.vfs_read
      0.00            +0.4        0.43 ±224%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault._copy_to_iter
      0.98 ±142%      +0.4        1.40 ±149%  perf-profile.calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98 ±142%      +0.4        1.40 ±149%  perf-profile.calltrace.cycles-pp.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64
      0.98 ±142%      +0.4        1.40 ±149%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      0.26 ±331%      +0.4        0.69 ±173%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      5.67 ± 95%      +0.4        6.11 ± 60%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.4        0.45 ±225%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_open.do_open.path_openat.do_filp_open
      0.00            +0.4        0.45 ±225%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.4        0.45 ±225%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
      0.00            +0.4        0.45 ±225%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.4        0.45 ±331%  perf-profile.calltrace.cycles-pp.startswith.manager_get_unit_by_pid_cgroup
      0.00            +0.4        0.45 ±331%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__get_user_nocheck_8.perf_callchain_user.get_perf_callchain.perf_callchain
      0.00            +0.4        0.45 ±331%  perf-profile.calltrace.cycles-pp.cfree
      0.00            +0.4        0.45 ±331%  perf-profile.calltrace.cycles-pp.time
      0.00            +0.4        0.45 ±331%  perf-profile.calltrace.cycles-pp.up_write.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.46 ±223%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_wait.kernel_wait4
      0.00            +0.5        0.46 ±223%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.schedule.do_wait
      4.31 ± 74%      +0.5        4.77 ± 66%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.5        0.46 ±331%  perf-profile.calltrace.cycles-pp.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      0.00            +0.5        0.46 ±331%  perf-profile.calltrace.cycles-pp.__get_user_8.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.5        0.46 ±331%  perf-profile.calltrace.cycles-pp.avg_vruntime.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.5        0.46 ±331%  perf-profile.calltrace.cycles-pp.native_irq_return_iret
      0.00            +0.5        0.46 ±331%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.26 ±331%      +0.5        0.73 ±177%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.__do_wait.do_wait.kernel_waitid.__do_sys_waitid.do_syscall_64
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.do_wait.kernel_waitid.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.waitid
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.kernel_waitid.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.__do_wait.do_wait.kernel_waitid
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.wait_task_zombie.__do_wait.do_wait.kernel_waitid.__do_sys_waitid
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.calltrace.cycles-pp.waitid
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp.pid_getattr.vfs_statx_path.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp.static_key_slow_dec.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp.static_key_slow_try_dec.static_key_slow_dec.sw_perf_event_destroy._free_event.perf_event_release_kernel
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp.vfs_statx_path.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp._atomic_dec_and_raw_lock_irqsave.put_pmu_ctx._free_event.perf_event_release_kernel.perf_release
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp.do_dentry_open.vfs_open.do_open.path_openat.do_filp_open
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp.free_unref_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
      0.00            +0.5        0.48 ±224%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00            +0.5        0.48 ±223%  perf-profile.calltrace.cycles-pp.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.51 ±224%      +0.5        1.00 ±143%  perf-profile.calltrace.cycles-pp.__mmap.setlocale
      0.51 ±224%      +0.5        1.00 ±143%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap.setlocale
      0.51 ±224%      +0.5        1.00 ±143%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap.setlocale
      0.51 ±224%      +0.5        1.00 ±143%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap.setlocale
      0.51 ±224%      +0.5        1.00 ±143%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.29 ±331%      +0.5        0.78 ±174%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.23 ±331%      +0.5        0.73 ±173%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.21 ±331%      +0.5        0.71 ±173%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.__evlist__enable.__cmd_record.cmd_record.perf_c2c__record
      0.00            +0.5        0.50 ±223%  perf-profile.calltrace.cycles-pp.__close_nocancel
      0.00            +0.5        0.50 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +0.5        0.50 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +0.5        0.50 ±223%  perf-profile.calltrace.cycles-pp.put_prev_entity.put_prev_task_fair.__schedule.__cond_resched.__wait_for_common
      0.00            +0.5        0.50 ±223%  perf-profile.calltrace.cycles-pp.put_prev_task_fair.__schedule.__cond_resched.__wait_for_common.affine_move_task
      0.00            +0.5        0.50 ±223%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_lookupat
      0.00            +0.5        0.50 ±331%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.5        0.50 ±331%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      0.00            +0.5        0.50 ±331%  perf-profile.calltrace.cycles-pp.kmem_cache_free.single_release.__fput.__x64_sys_close.do_syscall_64
      0.56 ±223%      +0.5        1.07 ±142%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.00            +0.5        0.51 ±225%  perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      4.05 ± 84%      +0.5        4.57 ± 67%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.29 ±331%      +0.5        0.82 ±174%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio
      0.29 ±331%      +0.5        0.82 ±174%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page
      0.29 ±331%      +0.5        0.82 ±174%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.00            +0.5        0.53 ±226%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.__open64_nocancel.setlocale
      0.00            +0.5        0.53 ±226%  perf-profile.calltrace.cycles-pp.pid_nr_ns.next_tgid.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      0.00            +0.5        0.54 ±224%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      1.28 ±119%      +0.6        1.83 ±117%  perf-profile.calltrace.cycles-pp.next_tgid.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      1.53 ±124%      +0.6        2.10 ±126%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      1.53 ±124%      +0.6        2.10 ±126%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.00            +0.6        0.58 ±331%  perf-profile.calltrace.cycles-pp.mutex_unlock._perf_ioctl.perf_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00            +0.6        0.58 ±331%  perf-profile.calltrace.cycles-pp.pcpu_block_refresh_hint.pcpu_block_update_hint_alloc.pcpu_alloc_area.pcpu_alloc_noprof.__percpu_counter_init_many
     12.54 ± 30%      +0.6       13.12 ± 19%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.38 ± 48%      +0.6        3.99 ± 49%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
     17.02 ± 32%      +0.6       17.64 ± 23%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     17.02 ± 32%      +0.6       17.64 ± 23%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     17.02 ± 32%      +0.6       17.64 ± 23%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.27 ± 96%      +0.6        2.89 ± 88%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.48 ±136%      +0.6        2.11 ± 75%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.98 ±183%      +0.6        1.61 ±133%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.6        0.64 ±173%  perf-profile.calltrace.cycles-pp.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk.path_openat
      1.79 ±130%      +0.7        2.44 ± 86%  perf-profile.calltrace.cycles-pp._Fork
      0.27 ±331%      +0.7        0.92 ±142%  perf-profile.calltrace.cycles-pp.vfs_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.75 ±174%      +0.7        1.40 ±149%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      0.75 ±174%      +0.7        1.41 ±127%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.__evlist__enable.__cmd_record.cmd_record
      0.27 ±331%      +0.7        0.94 ±141%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.27 ±331%      +0.7        0.94 ±141%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.27 ±331%      +0.7        0.94 ±141%  perf-profile.calltrace.cycles-pp.wait4
      4.31 ± 74%      +0.7        4.99 ± 72%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.00            +0.7        0.69 ±173%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_wait.kernel_wait4.__do_sys_wait4
      0.00            +0.7        0.69 ±173%  perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      4.30 ± 54%      +0.7        4.99 ± 40%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.04 ±187%      +0.7        1.73 ±118%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +0.7        0.70 ±248%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.7        0.70 ±248%  perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.7        0.71 ±173%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.exit_mmap.mmput.exit_mm
      0.00            +0.7        0.71 ±173%  perf-profile.calltrace.cycles-pp.put_pmu_ctx._free_event.perf_event_release_kernel.perf_release.__fput
      0.00            +0.7        0.71 ±173%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.__fput.task_work_run.do_exit
      0.00            +0.7        0.71 ±173%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__fput.task_work_run.do_exit.do_group_exit
      0.56 ±223%      +0.7        1.28 ±194%  perf-profile.calltrace.cycles-pp.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.23 ±331%      +0.7        0.96 ±141%  perf-profile.calltrace.cycles-pp.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.__do_wait.do_wait
      0.00            +0.7        0.73 ±177%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +0.7        0.73 ±177%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +0.7        0.73 ±177%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.58 ±223%      +0.7        1.32 ±151%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof
      0.00            +0.7        0.73 ±173%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      0.00            +0.7        0.73 ±173%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      0.53 ±223%      +0.7        1.26 ±193%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      0.23 ±331%      +0.7        0.96 ±244%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule
      0.23 ±331%      +0.7        0.96 ±244%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair
      0.00            +0.7        0.73 ±177%  perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.23 ±331%      +0.7        0.97 ±182%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule.schedule
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_hrtimeout_range_clock.ep_poll
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.schedule.schedule_hrtimeout_range_clock
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64
      1.78 ±137%      +0.8        2.54 ± 90%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write
      1.52 ±137%      +0.8        2.31 ± 77%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     17.31 ± 32%      +0.8       18.13 ± 25%  perf-profile.calltrace.cycles-pp.read
     12.30 ± 32%      +0.8       13.12 ± 19%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00            +0.8        0.83 ±243%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk.path_lookupat
      2.62 ±120%      +0.8        3.46 ±123%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.52 ±113%      +0.9        3.39 ± 46%  perf-profile.calltrace.cycles-pp.setlocale
      0.54 ±223%      +0.9        1.41 ±127%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__enable
      0.54 ±223%      +0.9        1.41 ±127%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__enable.__cmd_record
      0.54 ±225%      +0.9        1.44 ±127%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write
      0.54 ±225%      +0.9        1.44 ±127%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.00            +0.9        0.94 ±141%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.9        0.94 ±141%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.94 ±141%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +1.0        0.97 ±144%  perf-profile.calltrace.cycles-pp.mutex_unlock.perf_remove_from_owner.perf_event_release_kernel.perf_release.__fput
      4.00 ± 54%      +1.0        4.99 ± 31%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn
      4.00 ± 54%      +1.0        4.99 ± 31%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn.perf_mmap__push
      4.00 ± 54%      +1.0        4.99 ± 31%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen
      4.00 ± 54%      +1.0        4.99 ± 31%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      4.00 ± 54%      +1.0        4.99 ± 31%  perf-profile.calltrace.cycles-pp.write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      4.00 ± 54%      +1.0        4.99 ± 31%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      3.74 ± 55%      +1.0        4.74 ± 34%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.07 ±142%      +1.0        2.10 ±126%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.07 ±142%      +1.0        2.10 ±126%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.53 ±124%      +1.0        2.58 ±117%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.10 ± 56%      +1.1        7.21 ± 72%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ±127%      +1.1        2.60 ±102%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      3.74 ± 89%      +1.1        4.89 ± 52%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      3.74 ± 89%      +1.1        4.89 ± 52%  perf-profile.calltrace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      4.83 ± 80%      +1.1        5.98 ± 83%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      5.82 ± 55%      +1.2        6.98 ± 67%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.41 ±128%      +1.2        2.58 ± 91%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.41 ±128%      +1.2        2.58 ± 91%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.38 ± 48%      +1.2        4.58 ± 64%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     16.89 ± 16%      +1.2       18.10 ± 11%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      3.51 ± 57%      +1.2        4.74 ± 34%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.00            +1.2        1.25 ±150%  perf-profile.calltrace.cycles-pp.kmem_cache_free.exit_mmap.mmput.exit_mm.do_exit
      0.29 ±331%      +1.3        1.57 ±148%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +1.3        1.33 ±184%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.75 ±173%      +1.4        2.10 ±126%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      1.41 ±128%      +1.4        2.80 ±104%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.41 ±128%      +1.4        2.80 ±104%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      1.41 ±128%      +1.4        2.80 ±104%  perf-profile.calltrace.cycles-pp.open64
      0.23 ±331%      +1.4        1.64 ±152%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      1.07 ±142%      +1.4        2.48 ±138%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
     16.68 ± 17%      +1.4       18.10 ± 11%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
     13.58 ± 28%      +1.8       15.39 ± 25%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
      8.33 ± 36%      +1.9       10.23 ± 39%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
     13.29 ± 27%      +2.1       15.39 ± 25%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      8.07 ± 34%      +2.2       10.23 ± 39%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
      7.96 ± 47%      -2.7        5.26 ± 70%  perf-profile.children.cycles-pp.vsnprintf
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.children.cycles-pp.common_startup_64
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.children.cycles-pp.cpu_startup_entry
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.children.cycles-pp.cpuidle_idle_call
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.children.cycles-pp.do_idle
      3.62 ± 91%      -1.8        1.79 ±119%  perf-profile.children.cycles-pp.start_secondary
      4.39 ± 93%      -1.6        2.76 ± 84%  perf-profile.children.cycles-pp.do_mmap
      4.39 ± 93%      -1.6        2.76 ± 84%  perf-profile.children.cycles-pp.mmap_region
      3.35 ± 86%      -1.6        1.79 ±119%  perf-profile.children.cycles-pp.cpuidle_enter
      3.35 ± 86%      -1.6        1.79 ±119%  perf-profile.children.cycles-pp.cpuidle_enter_state
      2.56 ± 91%      -1.5        1.06 ±143%  perf-profile.children.cycles-pp.__d_lookup
      1.72 ±128%      -1.4        0.30 ±331%  perf-profile.children.cycles-pp.kthread
      1.72 ±128%      -1.4        0.30 ±331%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.46 ±133%      -1.2        0.22 ±331%  perf-profile.children.cycles-pp.__evlist__disable
      2.29 ±105%      -1.2        1.06 ±143%  perf-profile.children.cycles-pp.d_hash_and_lookup
      4.39 ± 93%      -1.2        3.18 ± 75%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.72 ±128%      -1.2        0.53 ±225%  perf-profile.children.cycles-pp.ret_from_fork
      1.72 ±128%      -1.2        0.53 ±225%  perf-profile.children.cycles-pp.ret_from_fork_asm
      2.88 ± 94%      -1.1        1.79 ±119%  perf-profile.children.cycles-pp.acpi_idle_enter
      2.88 ± 94%      -1.1        1.79 ±119%  perf-profile.children.cycles-pp.acpi_safe_halt
      2.33 ±120%      -1.1        1.27 ±120%  perf-profile.children.cycles-pp.free_pgtables
      1.35 ±151%      -1.0        0.30 ±331%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.97 ±125%      -1.0        0.93 ±142%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      1.97 ±125%      -1.0        0.93 ±142%  perf-profile.children.cycles-pp.do_vmi_munmap
      1.04 ±187%      -1.0        0.00        perf-profile.children.cycles-pp.copy_p4d_range
      1.04 ±187%      -1.0        0.00        perf-profile.children.cycles-pp.copy_page_range
      2.50 ± 91%      -1.0        1.49 ±100%  perf-profile.children.cycles-pp.fstatat64
      1.67 ±126%      -1.0        0.67 ±174%  perf-profile.children.cycles-pp.__split_vma
      0.98 ±141%      -1.0        0.00        perf-profile.children.cycles-pp.sched_tick
      0.98 ±224%      -1.0        0.00        perf-profile.children.cycles-pp.pipe_read
      1.44 ±169%      -1.0        0.48 ±224%  perf-profile.children.cycles-pp.perf_event_mmap
      1.44 ±169%      -1.0        0.48 ±224%  perf-profile.children.cycles-pp.perf_event_mmap_event
      1.23 ±157%      -0.9        0.29 ±331%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      1.23 ±157%      -0.9        0.29 ±331%  perf-profile.children.cycles-pp.ioctl
      1.23 ±157%      -0.9        0.29 ±331%  perf-profile.children.cycles-pp.perf_evsel__run_ioctl
      3.83 ± 73%      -0.9        2.95 ± 62%  perf-profile.children.cycles-pp.proc_fill_cache
      3.33 ± 93%      -0.9        2.47 ± 88%  perf-profile.children.cycles-pp.dput
      8.20 ± 41%      -0.8        7.35 ± 60%  perf-profile.children.cycles-pp.seq_printf
      1.37 ±152%      -0.8        0.55 ±224%  perf-profile.children.cycles-pp.perf_mmap__read_head
      2.31 ± 81%      -0.8        1.49 ±130%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      1.01 ±142%      -0.8        0.19 ±331%  perf-profile.children.cycles-pp.vma_complete
      0.79 ±236%      -0.8        0.00        perf-profile.children.cycles-pp.perf_evsel__disable_cpu
      0.78 ±242%      -0.8        0.00        perf-profile.children.cycles-pp.__call_rcu_common
      0.77 ±173%      -0.8        0.00        perf-profile.children.cycles-pp.pte_alloc_one
      0.77 ±230%      -0.8        0.00        perf-profile.children.cycles-pp.terminate_walk
      0.98 ±187%      -0.8        0.23 ±331%  perf-profile.children.cycles-pp.rcu_all_qs
      0.97 ±226%      -0.7        0.22 ±331%  perf-profile.children.cycles-pp.getname_flags
      1.70 ±110%      -0.7        0.96 ±141%  perf-profile.children.cycles-pp.__cond_resched
      0.74 ±173%      -0.7        0.00        perf-profile.children.cycles-pp.get_cpu_sleep_time_us
      0.74 ±173%      -0.7        0.00        perf-profile.children.cycles-pp.get_idle_time
      6.46 ± 34%      -0.7        5.73 ± 43%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      6.46 ± 34%      -0.7        5.73 ± 43%  perf-profile.children.cycles-pp.getdents64
      6.46 ± 34%      -0.7        5.73 ± 43%  perf-profile.children.cycles-pp.iterate_dir
      0.95 ±223%      -0.7        0.22 ±331%  perf-profile.children.cycles-pp.inode_permission
      2.57 ±113%      -0.7        1.85 ±107%  perf-profile.children.cycles-pp.number
      1.02 ±142%      -0.7        0.30 ±331%  perf-profile.children.cycles-pp.balance_fair
      5.91 ± 36%      -0.7        5.20 ± 42%  perf-profile.children.cycles-pp.proc_pid_readdir
      0.70 ±174%      -0.7        0.00        perf-profile.children.cycles-pp.__fdget
      1.71 ±124%      -0.7        1.01 ±143%  perf-profile.children.cycles-pp.exec_binprm
      3.36 ±118%      -0.7        2.67 ± 86%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.66 ±233%      -0.7        0.00        perf-profile.children.cycles-pp.vma_prepare
      2.16 ±110%      -0.6        1.52 ±101%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      1.19 ±186%      -0.6        0.56 ±224%  perf-profile.children.cycles-pp.__close
      1.37 ±152%      -0.6        0.74 ±176%  perf-profile.children.cycles-pp.ring_buffer_read_head
      8.27 ± 33%      -0.6        7.70 ± 31%  perf-profile.children.cycles-pp.__cmd_record
      8.27 ± 33%      -0.6        7.70 ± 31%  perf-profile.children.cycles-pp.cmd_record
      8.27 ± 33%      -0.6        7.70 ± 31%  perf-profile.children.cycles-pp.main
      8.27 ± 33%      -0.6        7.70 ± 31%  perf-profile.children.cycles-pp.run_builtin
      0.57 ±223%      -0.6        0.00        perf-profile.children.cycles-pp.mas_split
      0.57 ±223%      -0.6        0.00        perf-profile.children.cycles-pp.mas_wr_bnode
      0.56 ±223%      -0.6        0.00        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.56 ±223%      -0.6        0.00        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.56 ±223%      -0.6        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.56 ±223%      -0.6        0.00        perf-profile.children.cycles-pp.__do_fault
      0.56 ±223%      -0.6        0.00        perf-profile.children.cycles-pp.kernfs_dir_pos
      0.55 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.__wp_page_copy_user
      0.55 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      1.07 ±142%      -0.5        0.52 ±225%  perf-profile.children.cycles-pp.sync_regs
      0.54 ±331%      -0.5        0.00        perf-profile.children.cycles-pp.copy_page
      0.53 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.update_rq_clock_task
      0.53 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.53 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.__p4d_alloc
      0.53 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.get_zeroed_page_noprof
      0.53 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.try_charge_memcg
      0.52 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.strtoumax
      0.75 ±175%      -0.5        0.23 ±331%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.75 ±175%      -0.5        0.23 ±331%  perf-profile.children.cycles-pp.security_file_free
      0.52 ±225%      -0.5        0.00        perf-profile.children.cycles-pp.unlink_file_vma_batch_add
      0.77 ±174%      -0.5        0.25 ±331%  perf-profile.children.cycles-pp.lockref_put_return
      0.51 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.__ctype_init
      0.51 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.51 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.perf_event_task_tick
      0.50 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.__pte_alloc
      0.50 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.copy_pte_range
      0.50 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.vma_expand
      1.71 ±124%      -0.5        1.20 ±120%  perf-profile.children.cycles-pp.bprm_execve
      0.50 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.event_function
      0.50 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.perf_event_for_each_child
      0.50 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.remote_function
      0.50 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.skip_atoi
      0.72 ±174%      -0.5        0.22 ±331%  perf-profile.children.cycles-pp.__check_object_size
      0.49 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.copy_page_to_iter
      0.97 ±185%      -0.5        0.48 ±224%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.49 ±331%      -0.5        0.00        perf-profile.children.cycles-pp.generic_permission
      0.76 ±173%      -0.5        0.29 ±331%  perf-profile.children.cycles-pp.perf_ioctl
      0.72 ±174%      -0.5        0.25 ±331%  perf-profile.children.cycles-pp.init_file
      0.47 ±223%      -0.5        0.00        perf-profile.children.cycles-pp.poll_idle
      0.69 ±228%      -0.5        0.22 ±331%  perf-profile.children.cycles-pp.strncpy_from_user
      0.47 ±225%      -0.5        0.00        perf-profile.children.cycles-pp.cpu_stopper_thread
      0.47 ±225%      -0.5        0.00        perf-profile.children.cycles-pp.mas_preallocate
      0.47 ±225%      -0.5        0.00        perf-profile.children.cycles-pp.migration_cpu_stop
      0.47 ±225%      -0.5        0.00        perf-profile.children.cycles-pp.move_queued_task
      0.45 ±224%      -0.5        0.00        perf-profile.children.cycles-pp.complete_signal
      0.99 ±142%      -0.4        0.54 ±226%  perf-profile.children.cycles-pp.filp_flush
      1.78 ±114%      -0.4        1.34 ±119%  perf-profile.children.cycles-pp.put_files_struct
      1.45 ±146%      -0.4        1.01 ±143%  perf-profile.children.cycles-pp.load_elf_binary
      1.45 ±146%      -0.4        1.01 ±143%  perf-profile.children.cycles-pp.search_binary_handler
      0.73 ±175%      -0.4        0.31 ±331%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      1.01 ±141%      -0.4        0.60 ±331%  perf-profile.children.cycles-pp.generic_exec_single
      0.83 ±246%      -0.4        0.43 ±224%  perf-profile.children.cycles-pp.remove_vma
      0.81 ±173%      -0.4        0.42 ±224%  perf-profile.children.cycles-pp.mas_find
      2.23 ± 97%      -0.4        1.86 ± 97%  perf-profile.children.cycles-pp._raw_spin_lock
      1.89 ±128%      -0.4        1.52 ±101%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      1.27 ±119%      -0.4        0.90 ±142%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.27 ±119%      -0.4        0.90 ±142%  perf-profile.children.cycles-pp.tick_nohz_handler
      1.27 ±119%      -0.4        0.90 ±142%  perf-profile.children.cycles-pp.update_process_times
      1.35 ±161%      -0.4        0.98 ±189%  perf-profile.children.cycles-pp.__memcpy
      0.80 ±173%      -0.3        0.46 ±223%  perf-profile.children.cycles-pp._compound_head
      0.82 ±173%      -0.3        0.48 ±223%  perf-profile.children.cycles-pp.wp_page_copy
      0.56 ±223%      -0.3        0.22 ±331%  perf-profile.children.cycles-pp.locks_remove_file
      0.77 ±174%      -0.3        0.45 ±225%  perf-profile.children.cycles-pp.mas_store_prealloc
      2.81 ± 72%      -0.3        2.49 ± 64%  perf-profile.children.cycles-pp.sw_perf_event_destroy
      0.54 ±224%      -0.3        0.23 ±331%  perf-profile.children.cycles-pp.__count_memcg_events
      0.50 ±224%      -0.3        0.19 ±331%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      1.04 ±190%      -0.3        0.73 ±177%  perf-profile.children.cycles-pp.step_into
      0.30 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.mas_next_sibling
      0.30 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.mas_push_data
      0.74 ±174%      -0.3        0.45 ±225%  perf-profile.children.cycles-pp.mas_wr_walk
      0.29 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.29 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.sched_balance_trigger
      0.29 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.29 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.string
      0.54 ±331%      -0.3        0.25 ±331%  perf-profile.children.cycles-pp.mas_store_gfp
      0.51 ±224%      -0.3        0.22 ±331%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.51 ±223%      -0.3        0.23 ±331%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.53 ±224%      -0.3        0.25 ±331%  perf-profile.children.cycles-pp.down_write
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.__ctype_b_loc
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.__kernel_text_address
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.__update_blocked_fair
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.evm_file_release
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.in_gate_area_no_mm
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.is_vmalloc_addr
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.kernel_text_address
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.mas_ascend
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.mas_next_node
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.sched_balance_domains
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.security_file_release
      0.28 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.unwind_get_return_address
      0.53 ±225%      -0.3        0.25 ±331%  perf-profile.children.cycles-pp.__output_copy
      0.53 ±225%      -0.3        0.25 ±331%  perf-profile.children.cycles-pp.perf_output_copy
      0.50 ±223%      -0.3        0.23 ±331%  perf-profile.children.cycles-pp.clear_page_erms
      1.71 ±124%      -0.3        1.44 ±102%  perf-profile.children.cycles-pp.__x64_sys_execve
      1.71 ±124%      -0.3        1.44 ±102%  perf-profile.children.cycles-pp.do_execveat_common
      0.46 ±331%      -0.3        0.19 ±331%  perf-profile.children.cycles-pp.d_alloc
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.__do_sys_brk
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.__perf_event_disable
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.atomic_dec_and_mutex_lock
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.brk
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.do_brk_flags
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.get_sigframe
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.get_vma_policy
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.handle_signal
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.hw_perf_event_destroy
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.mas_topiary_replace
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.memchr
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.rep_stos_alternative
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.x64_setup_rt_frame
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.x86_release_hardware
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.__init_rwsem
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.get_cpu_device
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.inode_init_once
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.menu_select
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.policy_nodemask
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.proc_alloc_inode
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.put_dec
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.strcmp
      0.27 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.try_module_get
      0.97 ±185%      -0.3        0.70 ±173%  perf-profile.children.cycles-pp.begin_new_exec
      0.97 ±185%      -0.3        0.70 ±173%  perf-profile.children.cycles-pp.exec_mmap
      0.97 ±185%      -0.3        0.70 ±173%  perf-profile.children.cycles-pp.perf_iterate_sb
      1.00 ±190%      -0.3        0.73 ±177%  perf-profile.children.cycles-pp.uptime_proc_show
      0.49 ±226%      -0.3        0.22 ±331%  perf-profile.children.cycles-pp.check_heap_object
      1.50 ±131%      -0.3        1.24 ±119%  perf-profile.children.cycles-pp.mutex_lock
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.local_clock
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.local_clock_noinstr
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.pmd_install
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.proc_exec_connector
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.put_dec_trunc8
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.sched_clock_noinstr
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp._IO_sputbackc
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.__isoc99_sscanf
      0.26 ±331%      -0.3        0.00        perf-profile.children.cycles-pp.perf_event_ctx_lock_nested
      0.56 ±223%      -0.3        0.30 ±331%  perf-profile.children.cycles-pp.kernfs_fop_readdir
      0.51 ±224%      -0.3        0.25 ±331%  perf-profile.children.cycles-pp.__exit_signal
      0.54 ±223%      -0.3        0.29 ±331%  perf-profile.children.cycles-pp.put_ctx
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__folio_mod_stat
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__x64_sys_epoll_create
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.can_modify_mm
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.do_epoll_create
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.epoll_create
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.may_open
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.nd_jump_root
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.path_init
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.wake_up_new_task
      0.47 ±225%      -0.2        0.22 ±331%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__getrlimit
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__legitimize_mnt
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__traverse_mounts
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.lookup_mnt
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.p4d_offset
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.put_cpu_partial
      0.24 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.shmem_write_end
      1.22 ±119%      -0.2        0.99 ±190%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.53 ±223%      -0.2        0.30 ±331%  perf-profile.children.cycles-pp.vm_area_alloc
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__freading
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.affinity__set
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.change_pmd_range
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.change_protection_range
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.cpuidle_state_show
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.d_path
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.from_kgid_munged
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.map_id_up
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.mas_update_gap
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.show_state_time
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__mt_destroy
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.__x64_sys_pread64
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.build_detached_freelist
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.check_stack_object
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.evlist__cpu_begin
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.intel_bts_enable_local
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.irqentry_enter
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.irqtime_account_irq
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.locks_remove_posix
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.mt_destroy_walk
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.perf_ctx_enable
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.stack_access_ok
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.sysvec_reschedule_ipi
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.task_tick_fair
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.try_to_unlazy_next
      0.23 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.unwind_next_frame
      4.22 ± 52%      -0.2        3.99 ± 49%  perf-profile.children.cycles-pp.unmap_vmas
      0.45 ±224%      -0.2        0.22 ±331%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.45 ±224%      -0.2        0.22 ±331%  perf-profile.children.cycles-pp.__send_signal_locked
      0.45 ±224%      -0.2        0.22 ±331%  perf-profile.children.cycles-pp.do_notify_parent
      0.45 ±224%      -0.2        0.22 ±331%  perf-profile.children.cycles-pp.exit_notify
      0.47 ±223%      -0.2        0.25 ±331%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.45 ±224%      -0.2        0.23 ±331%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.50 ±224%      -0.2        0.29 ±331%  perf-profile.children.cycles-pp._perf_ioctl
      2.07 ± 71%      -0.2        1.86 ± 71%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      2.07 ± 71%      -0.2        1.86 ± 71%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.21 ±331%      -0.2        0.00        perf-profile.children.cycles-pp._find_next_and_bit
      0.21 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.copy_fs_struct
      0.21 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.enqueue_entity
      0.21 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.enqueue_task_fair
      0.21 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.getname
      0.21 ±331%      -0.2        0.00        perf-profile.children.cycles-pp.perf_tp_event_match
      0.70 ±174%      -0.2        0.50 ±331%  perf-profile.children.cycles-pp.__x64_sys_close
      0.44 ±223%      -0.2        0.25 ±331%  perf-profile.children.cycles-pp.update_load_avg
      0.48 ±225%      -0.2        0.31 ±331%  perf-profile.children.cycles-pp.elf_load
      3.62 ± 88%      -0.2        3.45 ± 73%  perf-profile.children.cycles-pp._free_event
      1.62 ±159%      -0.2        1.46 ±127%  perf-profile.children.cycles-pp.fput
      1.50 ±101%      -0.2        1.34 ±119%  perf-profile.children.cycles-pp.filp_close
      0.44 ±223%      -0.2        0.29 ±331%  perf-profile.children.cycles-pp.perf_evsel__enable_cpu
      0.45 ±224%      -0.1        0.30 ±331%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.56 ±223%      -0.1        0.42 ±224%  perf-profile.children.cycles-pp.mas_next_slot
      6.17 ± 55%      -0.1        6.04 ± 48%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      1.54 ±100%      -0.1        1.43 ±100%  perf-profile.children.cycles-pp.folios_put_refs
      0.77 ±173%      -0.1        0.68 ±238%  perf-profile.children.cycles-pp.perf_prepare_sample
      0.76 ±174%      -0.1        0.67 ±174%  perf-profile.children.cycles-pp.up_write
      6.38 ± 58%      -0.1        6.29 ± 44%  perf-profile.children.cycles-pp.x64_sys_call
      0.50 ±224%      -0.1        0.42 ±224%  perf-profile.children.cycles-pp.snprintf
      0.30 ±331%      -0.1        0.22 ±331%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.30 ±331%      -0.1        0.22 ±331%  perf-profile.children.cycles-pp.dup_task_struct
      0.53 ±223%      -0.1        0.46 ±223%  perf-profile.children.cycles-pp.filldir64
      1.22 ±146%      -0.1        1.16 ±119%  perf-profile.children.cycles-pp.mod_objcg_state
      0.49 ±224%      -0.1        0.43 ±224%  perf-profile.children.cycles-pp._copy_to_iter
      0.77 ±243%      -0.1        0.71 ±173%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.51 ±224%      -0.1        0.45 ±331%  perf-profile.children.cycles-pp.get_perf_callchain
      0.51 ±224%      -0.1        0.45 ±331%  perf-profile.children.cycles-pp.perf_callchain
      0.76 ±173%      -0.1        0.71 ±176%  perf-profile.children.cycles-pp.__vm_area_free
      0.28 ±331%      -0.1        0.22 ±331%  perf-profile.children.cycles-pp.__d_lookup_unhash
      0.28 ±331%      -0.1        0.22 ±331%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.24 ±331%      -0.1        0.19 ±331%  perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.24 ±331%      -0.1        0.19 ±331%  perf-profile.children.cycles-pp.select_task_rq_fair
     24.36 ± 12%      -0.1       24.31 ± 12%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.98 ±142%      -0.0        0.93 ±185%  perf-profile.children.cycles-pp.perf_tp_event
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.__perf_event__output_id_sample
      0.30 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.pipe_write
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.__d_rehash
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.dentry_unlink_inode
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.uncharge_batch
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.allocate_slab
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.new_inode
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.setup_object
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.shuffle_freelist
      0.98 ±142%      -0.0        0.94 ±141%  perf-profile.children.cycles-pp.alloc_empty_file
      0.74 ±173%      -0.0        0.70 ±174%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.52 ±224%      -0.0        0.48 ±224%  perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.27 ±331%      -0.0        0.23 ±331%  perf-profile.children.cycles-pp.alloc_inode
      0.23 ±331%      -0.0        0.19 ±331%  perf-profile.children.cycles-pp.__d_alloc
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.26 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.wake_up_q
      0.95 ±142%      -0.0        0.91 ±223%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.78 ±173%      -0.0        0.75 ±175%  perf-profile.children.cycles-pp.simple_lookup
      0.54 ±223%      -0.0        0.51 ±225%  perf-profile.children.cycles-pp.___slab_alloc
      0.50 ±223%      -0.0        0.48 ±224%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.__vm_munmap
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.refill_obj_stock
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.security_file_alloc
      0.24 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.folio_add_lru
      0.71 ±174%      -0.0        0.70 ±173%  perf-profile.children.cycles-pp.try_to_wake_up
      1.45 ±146%      -0.0        1.44 ±102%  perf-profile.children.cycles-pp.execve
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.kfree
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.single_release
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.task_state
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.children.cycles-pp.__pte_offset_map
      0.23 ±331%      -0.0        0.22 ±331%  perf-profile.children.cycles-pp.do_task_dead
      1.22 ±119%      -0.0        1.21 ±156%  perf-profile.children.cycles-pp.seq_read
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.children.cycles-pp.cp_new_stat
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.children.cycles-pp.__free_one_page
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.children.cycles-pp.free_unref_page
      0.67 ±242%      +0.0        0.68 ±173%  perf-profile.children.cycles-pp.mprotect_fixup
      0.24 ±331%      +0.0        0.25 ±331%  perf-profile.children.cycles-pp.strlen
      0.50 ±224%      +0.0        0.51 ±225%  perf-profile.children.cycles-pp.lookup_open
      1.25 ±119%      +0.0        1.26 ±193%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      1.25 ±119%      +0.0        1.26 ±193%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.25 ±119%      +0.0        1.26 ±193%  perf-profile.children.cycles-pp.update_sg_lb_stats
      1.48 ±100%      +0.0        1.49 ±163%  perf-profile.children.cycles-pp.sched_balance_rq
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.children.cycles-pp.perf_event_task
      0.44 ±223%      +0.0        0.46 ±223%  perf-profile.children.cycles-pp.__mmdrop
      0.44 ±223%      +0.0        0.46 ±223%  perf-profile.children.cycles-pp.finish_task_switch
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.children.cycles-pp.find_vma
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.children.cycles-pp.mt_find
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.children.cycles-pp.error_entry
      1.50 ±131%      +0.0        1.54 ±125%  perf-profile.children.cycles-pp.swevent_hlist_put_cpu
      0.47 ±225%      +0.0        0.50 ±223%  perf-profile.children.cycles-pp.proc_pid_status
      0.27 ±331%      +0.0        0.31 ±331%  perf-profile.children.cycles-pp.load_elf_interp
     10.42 ± 39%      +0.0       10.47 ± 22%  perf-profile.children.cycles-pp.exit_mmap
     10.42 ± 39%      +0.0       10.47 ± 22%  perf-profile.children.cycles-pp.mmput
      3.93 ± 52%      +0.1        3.99 ± 49%  perf-profile.children.cycles-pp.unmap_page_range
      2.38 ± 84%      +0.1        2.44 ± 64%  perf-profile.children.cycles-pp.mutex_unlock
      0.24 ±331%      +0.1        0.31 ±331%  perf-profile.children.cycles-pp.get_unused_fd_flags
      6.73 ± 74%      +0.1        6.81 ± 64%  perf-profile.children.cycles-pp.handle_mm_fault
     30.26 ± 16%      +0.1       30.35 ± 11%  perf-profile.children.cycles-pp.do_exit
     30.26 ± 16%      +0.1       30.35 ± 11%  perf-profile.children.cycles-pp.do_group_exit
      0.21 ±331%      +0.1        0.31 ±331%  perf-profile.children.cycles-pp.unlink_file_vma_batch_final
      1.09 ±195%      +0.1        1.20 ±120%  perf-profile.children.cycles-pp.clear_bhb_loop
      2.32 ±114%      +0.1        2.44 ±100%  perf-profile.children.cycles-pp.__dentry_kill
      1.81 ±107%      +0.1        1.95 ±124%  perf-profile.children.cycles-pp.do_anonymous_page
     17.02 ± 32%      +0.1       17.16 ± 21%  perf-profile.children.cycles-pp.vfs_read
      0.55 ±223%      +0.2        0.70 ±248%  perf-profile.children.cycles-pp.___perf_sw_event
      0.55 ±223%      +0.2        0.70 ±248%  perf-profile.children.cycles-pp.__perf_sw_event
      0.30 ±331%      +0.2        0.45 ±223%  perf-profile.children.cycles-pp.shmem_alloc_folio
      5.62 ± 22%      +0.2        5.78 ± 21%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.77 ±173%      +0.2        0.93 ±185%  perf-profile.children.cycles-pp.__perf_event_overflow
      0.77 ±173%      +0.2        0.93 ±185%  perf-profile.children.cycles-pp.perf_event_output_forward
      1.36 ±118%      +0.2        1.52 ±101%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.01 ±141%      +0.2        1.18 ±159%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.54 ±223%      +0.2        0.70 ±173%  perf-profile.children.cycles-pp.cmd_sched
      0.26 ±331%      +0.2        0.43 ±224%  perf-profile.children.cycles-pp.kcpustat_cpu_fetch
      1.79 ±130%      +0.2        1.96 ±116%  perf-profile.children.cycles-pp.__do_sys_clone
      1.79 ±130%      +0.2        1.96 ±116%  perf-profile.children.cycles-pp.kernel_clone
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      0.28 ±331%      +0.2        0.45 ±223%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      0.26 ±331%      +0.2        0.45 ±225%  perf-profile.children.cycles-pp.rw_verify_area
      0.26 ±331%      +0.2        0.45 ±225%  perf-profile.children.cycles-pp.security_file_permission
      0.23 ±331%      +0.2        0.42 ±224%  perf-profile.children.cycles-pp.cpu_util
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.__strdup
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.flush_tlb_func
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.get_jiffies_update
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.sched_exec
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.sd_pid_notify_with_fds
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.sd_pid_notify_with_fds@plt
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.00            +0.2        0.19 ±331%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.55 ±223%      +0.2        0.75 ±175%  perf-profile.children.cycles-pp.__d_add
      5.91 ± 90%      +0.2        6.11 ± 60%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.96 ±184%      +0.2        1.17 ±119%  perf-profile.children.cycles-pp.open_last_lookups
      0.85 ±173%      +0.2        1.06 ±142%  perf-profile.children.cycles-pp.rmqueue
      0.27 ±331%      +0.2        0.48 ±224%  perf-profile.children.cycles-pp.do_dentry_open
      0.26 ±331%      +0.2        0.48 ±224%  perf-profile.children.cycles-pp._atomic_dec_and_lock
      0.26 ±331%      +0.2        0.48 ±224%  perf-profile.children.cycles-pp.iput
     24.10 ± 10%      +0.2       24.31 ± 12%  perf-profile.children.cycles-pp.get_signal
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.__memcpy_chk
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.__wake_up
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.d_invalidate
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.down_read
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.ep_autoremove_wake_function
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.ep_poll_callback
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.evict
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.generic_fillattr
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.inode_wait_for_writeback
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.manager_get_unit_by_pid_cgroup
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.shrink_dcache_parent
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.shrink_dentry_list
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.startswith
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.startswith@plt
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.vma_merge
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp._IO_setvbuf
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.__unwind_start
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.access_error
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.anon_vma_clone
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.fsnotify_open_perm
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.get_stack_info
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.kernfs_iop_permission
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.perf_callchain_user
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp._find_next_or_bit
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.cfree
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.free@plt
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.kvm_guest_state
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.malloc
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.perf_instruction_pointer
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.time
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.vm_get_page_prot
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.vma_set_page_prot
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.workingset_activation
      0.00            +0.2        0.22 ±331%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.58 ±223%      +0.2        0.81 ±174%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.__get_user_8
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.avg_vruntime
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.copy_strings
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.hash_name
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.schedule_tail
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.unmap_region
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.__pipe
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.__put_anon_vma
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.__x64_sys_pipe2
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.create_pipe_files
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.do_pipe2
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.do_task_stat
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.getopt_long
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.inode_init_always
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.mas_store
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.perf_mmap__write_tail
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.sched_balance_find_src_rq
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.security_inode_alloc
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.00            +0.2        0.23 ±331%  perf-profile.children.cycles-pp.switch_fpu_return
      0.24 ±331%      +0.2        0.48 ±224%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.48 ±100%      +0.2        1.72 ±140%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.21 ±331%      +0.2        0.45 ±223%  perf-profile.children.cycles-pp.vma_modify
      1.18 ±153%      +0.2        1.42 ±101%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      1.18 ±153%      +0.2        1.42 ±101%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.27 ±331%      +0.2        0.51 ±225%  perf-profile.children.cycles-pp.proc_pid_make_inode
      0.27 ±331%      +0.2        0.51 ±225%  perf-profile.children.cycles-pp.proc_pident_instantiate
      0.27 ±331%      +0.2        0.51 ±225%  perf-profile.children.cycles-pp.proc_pident_lookup
      0.82 ±235%      +0.2        1.07 ±142%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.21 ±331%      +0.2        0.46 ±223%  perf-profile.children.cycles-pp.__percpu_counter_sum
      2.33 ±119%      +0.3        2.58 ±117%  perf-profile.children.cycles-pp.vfs_fstatat
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.__cleanup_sighand
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.kernfs_fop_open
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.do_getxattr
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.getxattr
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.kernfs_vfs_xattr_get
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.lgetxattr
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.path_getxattr
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.perf_output_sample
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.seq_write
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.xattr_full_name
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.kernfs_fop_release
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.proc_task_name
      0.00            +0.3        0.25 ±331%  perf-profile.children.cycles-pp.seq_release
      0.70 ±174%      +0.3        0.96 ±141%  perf-profile.children.cycles-pp.affine_move_task
      0.47 ±225%      +0.3        0.74 ±173%  perf-profile.children.cycles-pp.proc_single_show
      0.49 ±224%      +0.3        0.76 ±175%  perf-profile.children.cycles-pp.getenv
      0.23 ±331%      +0.3        0.50 ±223%  perf-profile.children.cycles-pp.igrab
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.children.cycles-pp.find_ge_pid
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.children.cycles-pp.idr_get_next
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.children.cycles-pp.idr_get_next_ul
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.children.cycles-pp.radix_tree_next_chunk
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.___pte_free_tlb
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.acpi_os_read_memory
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.free_p4d_range
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.free_pgd_range
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.free_pud_range
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.get_task_pid
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.mm_init
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.pcpu_alloc_area
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.pcpu_block_refresh_hint
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.pcpu_block_update_hint_alloc
      0.00            +0.3        0.29 ±331%  perf-profile.children.cycles-pp.set_pte_vaddr
      0.26 ±331%      +0.3        0.55 ±224%  perf-profile.children.cycles-pp.finish_fault
      0.44 ±223%      +0.3        0.73 ±173%  perf-profile.children.cycles-pp.__wait_for_common
      0.46 ±331%      +0.3        0.76 ±177%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.00            +0.3        0.30 ±331%  perf-profile.children.cycles-pp.nmi_restore
      0.00            +0.3        0.30 ±331%  perf-profile.children.cycles-pp.readdir64
      0.00            +0.3        0.31 ±331%  perf-profile.children.cycles-pp.atime_needs_update
      0.00            +0.3        0.31 ±331%  perf-profile.children.cycles-pp.filemap_get_entry
      0.00            +0.3        0.31 ±331%  perf-profile.children.cycles-pp.generic_file_mmap
      0.00            +0.3        0.31 ±331%  perf-profile.children.cycles-pp.make_vfsuid
      0.00            +0.3        0.31 ±331%  perf-profile.children.cycles-pp.touch_atime
      0.00            +0.3        0.31 ±331%  perf-profile.children.cycles-pp.xas_load
      9.45 ± 43%      +0.3        9.76 ± 24%  perf-profile.children.cycles-pp.exit_mm
      3.67 ± 52%      +0.3        3.99 ± 49%  perf-profile.children.cycles-pp.zap_pmd_range
      3.67 ± 52%      +0.3        3.99 ± 49%  perf-profile.children.cycles-pp.zap_pte_range
      2.81 ±125%      +0.3        3.15 ± 76%  perf-profile.children.cycles-pp.do_fault
      0.24 ±331%      +0.3        0.58 ±223%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.65 ±234%      +0.3        1.00 ±142%  perf-profile.children.cycles-pp.perf_c2c__record
      3.37 ± 48%      +0.4        3.74 ± 50%  perf-profile.children.cycles-pp.zap_present_ptes
      0.48 ±223%      +0.4        0.85 ±244%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.54 ±225%      +0.4        0.91 ±141%  perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      5.38 ± 26%      +0.4        5.78 ± 21%  perf-profile.children.cycles-pp.perf_mmap__push
      0.28 ±331%      +0.4        0.68 ±173%  perf-profile.children.cycles-pp.dequeue_entity
      0.28 ±331%      +0.4        0.68 ±173%  perf-profile.children.cycles-pp.dequeue_task_fair
     24.36 ± 12%      +0.4       24.77 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.04 ±187%      +0.4        1.44 ±101%  perf-profile.children.cycles-pp.dup_mmap
      0.51 ±223%      +0.4        0.92 ±142%  perf-profile.children.cycles-pp.do_open
      1.54 ±130%      +0.4        1.96 ±116%  perf-profile.children.cycles-pp.copy_process
      0.28 ±331%      +0.4        0.70 ±173%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.4        0.43 ±224%  perf-profile.children.cycles-pp.free_swap_cache
      0.00            +0.4        0.43 ±224%  perf-profile.children.cycles-pp.perf_mmap__consume
      0.00            +0.4        0.43 ±224%  perf-profile.children.cycles-pp.ring_buffer_write_tail
      0.98 ±142%      +0.4        1.41 ±149%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.98 ±142%      +0.4        1.41 ±149%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.98 ±142%      +0.4        1.41 ±149%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
     18.14 ± 18%      +0.4       18.57 ± 11%  perf-profile.children.cycles-pp.task_work_run
      0.24 ±331%      +0.4        0.68 ±237%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.24 ±331%      +0.4        0.68 ±237%  perf-profile.children.cycles-pp.lru_add_fn
      0.00            +0.4        0.45 ±225%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.00            +0.4        0.45 ±225%  perf-profile.children.cycles-pp.vm_area_dup
      0.00            +0.4        0.45 ±225%  perf-profile.children.cycles-pp.tcgetattr
      1.19 ±147%      +0.5        1.64 ±127%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.28 ±331%      +0.5        0.73 ±176%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.5        0.46 ±223%  perf-profile.children.cycles-pp.lru_add_drain
      0.00            +0.5        0.46 ±223%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00            +0.5        0.46 ±223%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.00            +0.5        0.46 ±223%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.5        0.46 ±331%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.children.cycles-pp.__do_sys_waitid
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.children.cycles-pp.kernel_waitid
      0.74 ±173%      +0.5        1.21 ±156%  perf-profile.children.cycles-pp.waitid
      1.48 ±100%      +0.5        1.95 ±121%  perf-profile.children.cycles-pp.schedule
      0.23 ±331%      +0.5        0.71 ±173%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.58 ±223%      +0.5        1.06 ±142%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.00            +0.5        0.48 ±224%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.5        0.48 ±224%  perf-profile.children.cycles-pp.pid_getattr
      0.00            +0.5        0.48 ±224%  perf-profile.children.cycles-pp.static_key_slow_dec
      0.00            +0.5        0.48 ±224%  perf-profile.children.cycles-pp.static_key_slow_try_dec
      0.00            +0.5        0.48 ±224%  perf-profile.children.cycles-pp.vfs_statx_path
      0.00            +0.5        0.48 ±224%  perf-profile.children.cycles-pp._atomic_dec_and_raw_lock_irqsave
      0.00            +0.5        0.48 ±224%  perf-profile.children.cycles-pp.free_unref_folios
      0.00            +0.5        0.48 ±224%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.00            +0.5        0.48 ±223%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.5        0.48 ±223%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.5        0.48 ±223%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.5        0.48 ±223%  perf-profile.children.cycles-pp.task_work_add
      0.51 ±224%      +0.5        1.00 ±143%  perf-profile.children.cycles-pp.__mmap
      1.01 ±181%      +0.5        1.50 ±102%  perf-profile.children.cycles-pp.__lookup_slow
      0.23 ±331%      +0.5        0.73 ±173%  perf-profile.children.cycles-pp.__page_cache_release
      0.00            +0.5        0.50 ±223%  perf-profile.children.cycles-pp.__close_nocancel
      0.00            +0.5        0.50 ±223%  perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.5        0.50 ±331%  perf-profile.children.cycles-pp.strnlen
      1.19 ±147%      +0.5        1.70 ±107%  perf-profile.children.cycles-pp.__evlist__enable
      7.51 ± 67%      +0.5        8.02 ± 49%  perf-profile.children.cycles-pp.do_user_addr_fault
      2.07 ± 71%      +0.5        2.59 ± 68%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.00            +0.5        0.53 ±226%  perf-profile.children.cycles-pp.pid_nr_ns
      0.00            +0.5        0.54 ±224%  perf-profile.children.cycles-pp.anon_vma_fork
      0.21 ±331%      +0.5        0.75 ±175%  perf-profile.children.cycles-pp.mtree_load
      2.56 ±129%      +0.5        3.11 ± 90%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      1.28 ±119%      +0.6        1.83 ±117%  perf-profile.children.cycles-pp.next_tgid
      1.53 ±124%      +0.6        2.10 ±126%  perf-profile.children.cycles-pp.filename_lookup
      1.53 ±124%      +0.6        2.10 ±126%  perf-profile.children.cycles-pp.path_lookupat
     12.54 ± 30%      +0.6       13.12 ± 19%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.00            +0.6        0.58 ±223%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.24 ±331%      +0.6        0.85 ±244%  perf-profile.children.cycles-pp.llist_add_batch
      1.50 ±125%      +0.6        2.11 ±102%  perf-profile.children.cycles-pp.format_decode
     17.02 ± 32%      +0.6       17.64 ± 23%  perf-profile.children.cycles-pp.ksys_read
      2.27 ± 96%      +0.6        2.90 ± 88%  perf-profile.children.cycles-pp.do_read_fault
      2.02 ±137%      +0.6        2.64 ± 86%  perf-profile.children.cycles-pp.__open64_nocancel
      0.98 ±183%      +0.6        1.61 ±133%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.81 ±246%      +0.6        1.45 ±155%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.00            +0.6        0.64 ±173%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      2.40 ±126%      +0.6        3.04 ±135%  perf-profile.children.cycles-pp.sched_setaffinity
      0.28 ±331%      +0.7        0.93 ±185%  perf-profile.children.cycles-pp.update_curr
      1.79 ±130%      +0.7        2.44 ± 86%  perf-profile.children.cycles-pp._Fork
      0.27 ±331%      +0.7        0.92 ±142%  perf-profile.children.cycles-pp.vfs_open
      0.85 ±173%      +0.7        1.52 ±101%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.30 ±331%      +0.7        0.97 ±144%  perf-profile.children.cycles-pp.perf_remove_from_owner
      0.27 ±331%      +0.7        0.94 ±141%  perf-profile.children.cycles-pp.wait4
     16.04 ± 29%      +0.7       16.71 ± 20%  perf-profile.children.cycles-pp.seq_read_iter
     18.40 ± 19%      +0.7       19.08 ± 14%  perf-profile.children.cycles-pp.__fput
      4.30 ± 54%      +0.7        4.99 ± 40%  perf-profile.children.cycles-pp.vfs_write
      1.04 ±187%      +0.7        1.73 ±118%  perf-profile.children.cycles-pp.dup_mm
      0.98 ±142%      +0.7        1.68 ± 86%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.7        0.71 ±173%  perf-profile.children.cycles-pp.put_pmu_ctx
      0.00            +0.7        0.71 ±176%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.74 ±173%      +0.7        1.46 ±177%  perf-profile.children.cycles-pp.__do_wait
      0.74 ±173%      +0.7        1.46 ±177%  perf-profile.children.cycles-pp.release_task
      0.74 ±173%      +0.7        1.46 ±177%  perf-profile.children.cycles-pp.wait_task_zombie
      0.56 ±223%      +0.7        1.28 ±194%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.23 ±331%      +0.7        0.96 ±141%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.23 ±331%      +0.7        0.96 ±141%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.00            +0.7        0.73 ±173%  perf-profile.children.cycles-pp.put_prev_entity
      0.00            +0.7        0.73 ±173%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.00            +0.7        0.73 ±177%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.00            +0.7        0.73 ±177%  perf-profile.children.cycles-pp.mas_walk
      0.00            +0.7        0.74 ±174%  perf-profile.children.cycles-pp.__x64_sys_epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.children.cycles-pp.do_epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.children.cycles-pp.ep_poll
      0.00            +0.7        0.74 ±174%  perf-profile.children.cycles-pp.epoll_wait
      0.00            +0.7        0.74 ±174%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      7.00 ± 53%      +0.7        7.74 ± 66%  perf-profile.children.cycles-pp.__x64_sys_openat
      7.00 ± 53%      +0.7        7.74 ± 66%  perf-profile.children.cycles-pp.do_sys_openat2
      7.51 ± 67%      +0.7        8.25 ± 50%  perf-profile.children.cycles-pp.exc_page_fault
      2.15 ±118%      +0.8        2.90 ±101%  perf-profile.children.cycles-pp.__schedule
      0.76 ±174%      +0.8        1.52 ±156%  perf-profile.children.cycles-pp.__slab_free
      1.52 ±137%      +0.8        2.31 ± 77%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      1.52 ±137%      +0.8        2.31 ± 77%  perf-profile.children.cycles-pp.fault_in_readable
      0.00            +0.8        0.81 ±174%  perf-profile.children.cycles-pp.set_pte_range
     17.31 ± 32%      +0.8       18.13 ± 25%  perf-profile.children.cycles-pp.read
      2.52 ±113%      +0.9        3.39 ± 46%  perf-profile.children.cycles-pp.setlocale
      1.01 ±193%      +0.9        1.89 ± 96%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      6.10 ± 56%      +0.9        6.98 ± 67%  perf-profile.children.cycles-pp.path_openat
      0.54 ±225%      +0.9        1.44 ±127%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.54 ±225%      +0.9        1.44 ±127%  perf-profile.children.cycles-pp.shmem_write_begin
      0.00            +0.9        0.93 ±141%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.9        0.94 ±141%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.00            +0.9        0.94 ±141%  perf-profile.children.cycles-pp.kernel_wait4
      4.30 ± 54%      +0.9        5.25 ± 37%  perf-profile.children.cycles-pp.ksys_write
      4.30 ± 54%      +0.9        5.25 ± 37%  perf-profile.children.cycles-pp.write
      0.46 ±223%      +1.0        1.42 ±168%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +1.0        0.96 ±141%  perf-profile.children.cycles-pp.__legitimize_path
      0.00            +1.0        0.96 ±141%  perf-profile.children.cycles-pp.try_to_unlazy
      0.00            +1.0        0.98 ±182%  perf-profile.children.cycles-pp.up_read
      4.00 ± 54%      +1.0        4.99 ± 31%  perf-profile.children.cycles-pp.record__pushfn
      4.00 ± 54%      +1.0        4.99 ± 31%  perf-profile.children.cycles-pp.writen
      3.74 ± 55%      +1.0        4.74 ± 34%  perf-profile.children.cycles-pp.generic_perform_write
      3.74 ± 55%      +1.0        4.74 ± 34%  perf-profile.children.cycles-pp.shmem_file_write_iter
      1.53 ±124%      +1.0        2.58 ±117%  perf-profile.children.cycles-pp.vfs_statx
      6.10 ± 56%      +1.1        7.21 ± 72%  perf-profile.children.cycles-pp.do_filp_open
      8.30 ± 64%      +1.1        9.42 ± 51%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.46 ±127%      +1.1        2.60 ±102%  perf-profile.children.cycles-pp.filemap_map_pages
      1.02 ±142%      +1.2        2.18 ± 79%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.41 ±128%      +1.4        2.80 ±104%  perf-profile.children.cycles-pp.open64
      8.83 ± 33%      +1.4       10.23 ± 39%  perf-profile.children.cycles-pp.event_function_call
      0.74 ±173%      +1.4        2.15 ±115%  perf-profile.children.cycles-pp.do_wait
      8.57 ± 32%      +1.7       10.23 ± 39%  perf-profile.children.cycles-pp.smp_call_function_single
     13.58 ± 28%      +1.8       15.39 ± 25%  perf-profile.children.cycles-pp.perf_event_release_kernel
     13.58 ± 28%      +1.8       15.39 ± 25%  perf-profile.children.cycles-pp.perf_release
      2.75 ± 97%      +1.9        4.66 ± 66%  perf-profile.children.cycles-pp.kmem_cache_free
      1.31 ±160%      +2.0        3.31 ± 74%  perf-profile.children.cycles-pp.lookup_fast
      3.32 ±112%      +2.2        5.57 ± 64%  perf-profile.children.cycles-pp.link_path_walk
      1.85 ±129%      +2.5        4.38 ± 72%  perf-profile.children.cycles-pp.walk_component
     81.33 ±  8%      +2.9       84.27 ±  6%  perf-profile.children.cycles-pp.do_syscall_64
     81.33 ±  8%      +2.9       84.27 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.86 ± 99%      -2.1        0.79 ±174%  perf-profile.self.cycles-pp.vsnprintf
      2.28 ±106%      -1.2        1.06 ±143%  perf-profile.self.cycles-pp.__d_lookup
      2.31 ± 81%      -1.1        1.19 ±157%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      1.04 ±142%      -1.0        0.00        perf-profile.self.cycles-pp.folios_put_refs
      1.62 ±159%      -0.9        0.74 ±176%  perf-profile.self.cycles-pp.fput
      0.86 ±173%      -0.9        0.00        perf-profile.self.cycles-pp.perf_event_release_kernel
      0.78 ±242%      -0.8        0.00        perf-profile.self.cycles-pp.__call_rcu_common
      0.98 ±187%      -0.8        0.23 ±331%  perf-profile.self.cycles-pp.rcu_all_qs
      0.74 ±173%      -0.7        0.00        perf-profile.self.cycles-pp.get_cpu_sleep_time_us
      0.95 ±142%      -0.7        0.23 ±331%  perf-profile.self.cycles-pp.__fput
      0.70 ±174%      -0.7        0.00        perf-profile.self.cycles-pp.__fdget
      0.56 ±223%      -0.6        0.00        perf-profile.self.cycles-pp.kernfs_dir_pos
      0.55 ±223%      -0.5        0.00        perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      1.07 ±142%      -0.5        0.52 ±225%  perf-profile.self.cycles-pp.sync_regs
      0.54 ±223%      -0.5        0.00        perf-profile.self.cycles-pp.__open64_nocancel
      0.54 ±331%      -0.5        0.00        perf-profile.self.cycles-pp.copy_page
      0.53 ±224%      -0.5        0.00        perf-profile.self.cycles-pp.update_rq_clock_task
      0.53 ±223%      -0.5        0.00        perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.53 ±223%      -0.5        0.00        perf-profile.self.cycles-pp.try_charge_memcg
      0.75 ±175%      -0.5        0.23 ±331%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.77 ±174%      -0.5        0.25 ±331%  perf-profile.self.cycles-pp.lockref_put_return
      1.22 ±146%      -0.5        0.71 ±173%  perf-profile.self.cycles-pp.mod_objcg_state
      0.51 ±224%      -0.5        0.00        perf-profile.self.cycles-pp.perf_event_task_tick
      0.47 ±223%      -0.5        0.00        perf-profile.self.cycles-pp.poll_idle
      0.45 ±224%      -0.5        0.00        perf-profile.self.cycles-pp.init_file
      1.25 ±119%      -0.4        0.81 ±174%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.73 ±175%      -0.4        0.31 ±331%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      1.35 ±161%      -0.4        0.98 ±189%  perf-profile.self.cycles-pp.__memcpy
      0.80 ±173%      -0.3        0.46 ±223%  perf-profile.self.cycles-pp._compound_head
      0.56 ±223%      -0.3        0.22 ±331%  perf-profile.self.cycles-pp.locks_remove_file
      0.76 ±174%      -0.3        0.45 ±225%  perf-profile.self.cycles-pp.up_write
      0.30 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__count_memcg_events
      0.30 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.mas_next_sibling
      0.30 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.proc_pid_readdir
      0.30 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.zap_pte_range
      0.74 ±174%      -0.3        0.45 ±225%  perf-profile.self.cycles-pp.mas_wr_walk
      0.29 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__do_fault
      0.29 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.29 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.sched_balance_trigger
      0.29 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.string
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__cond_resched
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__ctype_b_loc
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__update_blocked_fair
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.evm_file_release
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.in_gate_area_no_mm
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.is_vmalloc_addr
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.mas_ascend
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.path_openat
      0.28 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.put_files_struct
      0.50 ±223%      -0.3        0.23 ±331%  perf-profile.self.cycles-pp.clear_page_erms
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__perf_event_disable
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.atomic_dec_and_mutex_lock
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.get_vma_policy
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.memchr
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.page_counter_uncharge
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__dentry_kill
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__init_rwsem
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.do_dentry_open
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.get_cpu_device
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.policy_nodemask
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.put_dec
      0.27 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.strcmp
      0.95 ±142%      -0.3        0.68 ±237%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.kfree
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.local_clock_noinstr
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.proc_exec_connector
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.put_dec_trunc8
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.vm_area_alloc
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp._IO_sputbackc
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp._copy_to_iter
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.event_function_call
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.pipe_read
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.rw_verify_area
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.skip_atoi
      0.26 ±331%      -0.3        0.00        perf-profile.self.cycles-pp.unmap_page_range
      1.01 ±142%      -0.3        0.75 ±175%  perf-profile.self.cycles-pp.next_tgid
      0.54 ±223%      -0.3        0.29 ±331%  perf-profile.self.cycles-pp.put_ctx
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.generic_permission
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.handle_mm_fault
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.mas_find
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.nd_jump_root
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.record__mmap_read_evlist
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.sched_balance_find_dst_cpu
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.vma_expand
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__getrlimit
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__kmalloc_node_noprof
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__legitimize_mnt
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.put_cpu_partial
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.seq_read_iter
      0.24 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.shmem_write_end
      1.22 ±119%      -0.2        0.99 ±190%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__freading
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__page_cache_release
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.d_path
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.generic_perform_write
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.inode_permission
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.link_path_walk
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.map_id_up
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.perf_output_copy
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.sched_setaffinity
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.show_state_time
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.simple_lookup
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__mmdrop
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.__vm_area_free
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.build_detached_freelist
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.check_stack_object
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.intel_bts_enable_local
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.irqentry_enter
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.locks_remove_posix
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.sched_balance_rq
      0.23 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.stack_access_ok
      0.45 ±224%      -0.2        0.22 ±331%  perf-profile.self.cycles-pp.__rb_insert_augmented
      2.38 ± 84%      -0.2        2.16 ± 78%  perf-profile.self.cycles-pp.mutex_unlock
      0.76 ±175%      -0.2        0.54 ±226%  perf-profile.self.cycles-pp.filp_flush
      0.44 ±223%      -0.2        0.22 ±331%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.45 ±224%      -0.2        0.23 ±331%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.21 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.exit_mmap
      0.21 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.getname
      0.21 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.perf_event_task
      0.21 ±331%      -0.2        0.00        perf-profile.self.cycles-pp.perf_tp_event_match
      1.56 ±154%      -0.2        1.37 ±159%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.45 ±224%      -0.1        0.30 ±331%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      1.73 ± 85%      -0.1        1.63 ±114%  perf-profile.self.cycles-pp._raw_spin_lock
      0.53 ±223%      -0.1        0.46 ±223%  perf-profile.self.cycles-pp.filldir64
      0.28 ±331%      -0.1        0.22 ±331%  perf-profile.self.cycles-pp.__d_lookup_unhash
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.self.cycles-pp.__d_rehash
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.self.cycles-pp.dentry_unlink_inode
      0.27 ±331%      -0.0        0.22 ±331%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.29 ±331%      -0.0        0.25 ±331%  perf-profile.self.cycles-pp.down_write
      0.50 ±223%      -0.0        0.48 ±224%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.self.cycles-pp.rmqueue
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.27 ±331%      -0.0        0.25 ±331%  perf-profile.self.cycles-pp.refill_obj_stock
      1.00 ±191%      -0.0        0.99 ±143%  perf-profile.self.cycles-pp.mutex_lock
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.26 ±331%      -0.0        0.25 ±331%  perf-profile.self.cycles-pp.__pte_offset_map
      0.48 ±225%      +0.0        0.48 ±224%  perf-profile.self.cycles-pp.filemap_map_pages
      0.23 ±331%      +0.0        0.23 ±331%  perf-profile.self.cycles-pp.__free_one_page
      0.24 ±331%      +0.0        0.25 ±331%  perf-profile.self.cycles-pp.strlen
      0.21 ±331%      +0.0        0.22 ±331%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.27 ±331%      +0.0        0.29 ±331%  perf-profile.self.cycles-pp.___slab_alloc
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.self.cycles-pp.mt_find
      0.23 ±331%      +0.0        0.25 ±331%  perf-profile.self.cycles-pp.error_entry
      0.21 ±331%      +0.0        0.23 ±331%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.26 ±331%      +0.0        0.30 ±331%  perf-profile.self.cycles-pp.do_mprotect_pkey
      0.21 ±331%      +0.0        0.25 ±331%  perf-profile.self.cycles-pp.update_load_avg
      0.21 ±331%      +0.0        0.25 ±331%  perf-profile.self.cycles-pp.x64_sys_call
      0.24 ±331%      +0.1        0.30 ±331%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.47 ±223%      +0.1        0.53 ±225%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.24 ±331%      +0.1        0.31 ±331%  perf-profile.self.cycles-pp.get_unused_fd_flags
      1.77 ±136%      +0.1        1.85 ±107%  perf-profile.self.cycles-pp.number
      1.09 ±195%      +0.1        1.20 ±120%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.29 ±331%      +0.1        0.42 ±224%  perf-profile.self.cycles-pp.mas_next_slot
      0.55 ±223%      +0.2        0.70 ±248%  perf-profile.self.cycles-pp.___perf_sw_event
      0.26 ±331%      +0.2        0.43 ±224%  perf-profile.self.cycles-pp.kcpustat_cpu_fetch
      0.00            +0.2        0.19 ±331%  perf-profile.self.cycles-pp.__strdup
      0.00            +0.2        0.19 ±331%  perf-profile.self.cycles-pp.do_mmap
      0.00            +0.2        0.19 ±331%  perf-profile.self.cycles-pp.get_jiffies_update
      0.00            +0.2        0.19 ±331%  perf-profile.self.cycles-pp.kernfs_dop_revalidate
      0.00            +0.2        0.19 ±331%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.00            +0.2        0.19 ±331%  perf-profile.self.cycles-pp.ring_buffer_read_head
      0.00            +0.2        0.19 ±331%  perf-profile.self.cycles-pp.sd_pid_notify_with_fds@plt
      0.00            +0.2        0.19 ±331%  perf-profile.self.cycles-pp.security_file_permission
      0.26 ±331%      +0.2        0.48 ±224%  perf-profile.self.cycles-pp._atomic_dec_and_lock
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.down_read
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.generic_fillattr
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.new_inode
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.set_pte_range
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.snprintf
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.startswith@plt
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.vma_merge
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.access_error
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.do_filp_open
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.fsnotify_open_perm
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.get_stack_info
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.kernfs_iop_permission
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp._find_next_or_bit
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.exc_page_fault
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.free@plt
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.kvm_guest_state
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.malloc
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.setup_object
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.vm_get_page_prot
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.vm_mmap_pgoff
      0.00            +0.2        0.22 ±331%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.58 ±223%      +0.2        0.81 ±174%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.copy_strings
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.do_syscall_64
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.hash_name
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.ksys_read
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.put_pmu_ctx
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.cp_new_stat
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.do_task_stat
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.getopt_long
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.mas_store
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.sched_balance_find_src_rq
      0.00            +0.2        0.23 ±331%  perf-profile.self.cycles-pp.switch_fpu_return
      0.26 ±331%      +0.2        0.50 ±230%  perf-profile.self.cycles-pp.step_into
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.__cleanup_sighand
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.release_task
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.walk_component
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.anon_vma_fork
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.perf_output_sample
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.pid_getattr
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.seq_write
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp._free_event
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.strnlen
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.tcgetattr
      0.00            +0.3        0.25 ±331%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.49 ±224%      +0.3        0.76 ±175%  perf-profile.self.cycles-pp.getenv
      0.23 ±331%      +0.3        0.50 ±223%  perf-profile.self.cycles-pp.igrab
      0.27 ±331%      +0.3        0.55 ±224%  perf-profile.self.cycles-pp.radix_tree_next_chunk
      0.00            +0.3        0.29 ±331%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.00            +0.3        0.29 ±331%  perf-profile.self.cycles-pp.acpi_os_read_memory
      0.00            +0.3        0.29 ±331%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.00            +0.3        0.29 ±331%  perf-profile.self.cycles-pp.get_task_pid
      0.00            +0.3        0.29 ±331%  perf-profile.self.cycles-pp.set_pte_vaddr
      0.00            +0.3        0.30 ±331%  perf-profile.self.cycles-pp.__d_add
      0.00            +0.3        0.30 ±331%  perf-profile.self.cycles-pp.__do_sys_newfstatat
      0.00            +0.3        0.30 ±331%  perf-profile.self.cycles-pp.nmi_restore
      0.00            +0.3        0.30 ±331%  perf-profile.self.cycles-pp.readdir64
      0.00            +0.3        0.31 ±331%  perf-profile.self.cycles-pp.make_vfsuid
      0.00            +0.3        0.31 ±331%  perf-profile.self.cycles-pp.uptime_proc_show
      0.00            +0.3        0.31 ±331%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.4        0.42 ±224%  perf-profile.self.cycles-pp.cpu_util
      1.01 ±143%      +0.4        1.44 ±101%  perf-profile.self.cycles-pp.proc_fill_cache
      0.00            +0.4        0.43 ±224%  perf-profile.self.cycles-pp.free_swap_cache
      0.00            +0.4        0.43 ±224%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.24 ±331%      +0.4        0.68 ±237%  perf-profile.self.cycles-pp.lru_add_fn
      0.00            +0.4        0.45 ±225%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.00            +0.5        0.46 ±223%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.00            +0.5        0.48 ±224%  perf-profile.self.cycles-pp.static_key_slow_try_dec
      0.00            +0.5        0.48 ±224%  perf-profile.self.cycles-pp._atomic_dec_and_raw_lock_irqsave
      0.00            +0.5        0.48 ±224%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.00            +0.5        0.48 ±228%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.5        0.48 ±223%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.00            +0.5        0.48 ±223%  perf-profile.self.cycles-pp.task_work_add
      0.23 ±331%      +0.5        0.74 ±173%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.00            +0.5        0.50 ±223%  perf-profile.self.cycles-pp.__fdget_pos
      0.26 ±331%      +0.5        0.77 ±174%  perf-profile.self.cycles-pp.swevent_hlist_put_cpu
      0.00            +0.5        0.53 ±226%  perf-profile.self.cycles-pp.pid_nr_ns
      0.21 ±331%      +0.5        0.75 ±175%  perf-profile.self.cycles-pp.mtree_load
      0.00            +0.6        0.56 ±224%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.00            +0.6        0.58 ±223%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.24 ±331%      +0.6        0.85 ±244%  perf-profile.self.cycles-pp.llist_add_batch
      0.21 ±331%      +0.6        0.82 ±175%  perf-profile.self.cycles-pp.fault_in_readable
      0.98 ±183%      +0.6        1.61 ±133%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.81 ±246%      +0.6        1.45 ±155%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.7        0.67 ±174%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.00            +0.7        0.68 ±173%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.7        0.73 ±177%  perf-profile.self.cycles-pp.mas_walk
      0.49 ±224%      +0.7        1.23 ±119%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.76 ±174%      +0.8        1.52 ±156%  perf-profile.self.cycles-pp.__slab_free
      0.52 ±225%      +0.8        1.28 ±120%  perf-profile.self.cycles-pp.kmem_cache_free
      1.24 ±150%      +0.9        2.11 ±102%  perf-profile.self.cycles-pp.format_decode
      0.00            +1.0        0.95 ±144%  perf-profile.self.cycles-pp.zap_present_ptes
      0.00            +1.0        0.98 ±182%  perf-profile.self.cycles-pp.up_read
      0.73 ±174%      +1.6        2.29 ± 97%  perf-profile.self.cycles-pp.seq_printf
      7.56 ± 41%      +2.1        9.63 ± 34%  perf-profile.self.cycles-pp.smp_call_function_single



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


