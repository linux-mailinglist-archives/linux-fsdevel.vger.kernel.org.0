Return-Path: <linux-fsdevel+bounces-3201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B229B7F14A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C6E1F24739
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF8D1B280;
	Mon, 20 Nov 2023 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8alprSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79159E;
	Mon, 20 Nov 2023 05:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700488154; x=1732024154;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=hKRGrNEV/LtKeUX2Kxkm9qL6GcHFeZk/mcYnUS/GTUM=;
  b=V8alprSjnYE314bMP1mi5MfLsXFtknzDlJx8w8jq/G6VE6KtgtOssOQZ
   uT4C/h6leJriAM+YZSFb78NQjnbDhMAq+2iuO2oH56iyu52ymEzzD/lYj
   SHkjiiNLclgo+xmPLkL1z+JGXoRuOu9k3svAv7GsvbzjloXbI25zYGzia
   oEyXaY421Upou3KB3TSuAQovVRYfaJTKMjK+abCLCxjRnbDc6iUl/sSlu
   t8p10wY/ina5rgVL+KAvOx+31stBNtElQfxWZwhqg+2WxNRXQ8lWHWtLW
   iQCSv0F1gBdRz7dGUAL31i9YSQLO2pqfLhN5pJwu/JxPBWqyMz5/0OdIH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="370963852"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="370963852"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 05:49:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="889921907"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="889921907"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 05:49:12 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 05:49:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 05:49:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 05:49:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRBkK9YULEwKrfK40T0vrVH9QKvIYJ/aeGa1RmRoCxVKSfhJ6WFY8w/eLsb2Axj0WzcTdoM3xcB8welSpKIdaRsllfaGJwaR4h3iF6tNdE5i6q681Q1qcac9xxanCgCXG6gWKY1TOwYrgnOY8epPMOrk0QG+na9ZtOTgj8iLpE311Ay9vLYL6AG5W4ADKVVI9alx1RtxTcHmKjNQZzG09EYB1WLkdkyWmcQuKZMBG7UnONkZEXk3tA6IqR74LLM4fIGLA4/nz+cB+ApscOh+jc1Uu1I7O1z2JfGDoHu/VuNZ0KSOY8rs+sRsfTrOtC2XVz49ikHV6j9zPch60LOthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYLa3Sd8DAp5ZcnxeZkAtaWGmCcsonOLtAF/Lahfniw=;
 b=CZpScMCOUkL5m5h7bQ/TOJlntVYS2tldL5uS0zRj1hczx1TbEME0QWoJlGrqAk/yZFKM741X0G5fgy0dfi/r9eWLAeup47XpdQpvHvUJKOXIVV+IOpUp1PaL1+cGVLQ2si2WGcjnBSAW02Lz6BerdZBq0vQSgUyx0Jnm4gHlGs2T6oaK1WcMBLqLZErAUFvOA7h/u84rG5thB4PkwD6udswPyFatdLqMYw82Y7xy9fpgNLQP8RTpe/ulSbjel3SVexiadIv2LbEn844K6iNS8FUZkx8QRku4zFJ45htDFXgTmgibdkzYCvTVAGoebsnaFLTi0NlaWLtBpUjVBL+0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 13:49:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 13:49:00 +0000
Date: Mon, 20 Nov 2023 21:48:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yin Fengwei <fengwei.yin@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, kernel test robot
	<oliver.sang@intel.com>, Feng Tang <feng.tang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <fengwei.yin@intel.com>
Subject: [linus:master] [filemap]  c8be038067:  vm-scalability.throughput
 -27.3% regression
Message-ID: <202311201605.b86d11b-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc1ae1e-7c3c-4ba9-4b85-08dbe9cf71dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/O0olIYfuxhmbkwJSnPWGWz+JgpmI0LgRkgkJOCZEbwVp1WCy/V4gJqI7j/BKlfG70L656QpC3bbx4QdQ4T+GYYxUKORn9LEl0f9lczqn/ro2LQztYcKRCYT9WYLlXAsSl2+lInmVhGIQrDAOOLeVw/tH14vUdC5IeHlOc6UAKZAqHl3vDXYCJOawd12+KlcmgDdWdkGQM58djMZKToUgcPuTsEB7UzO4do965trOz9eFcKHQw1hWG0j4nwlgQUBp7hqJamu2SjwQyW7428AWS92nKpq2KK3Pz69i6mfwHaP87fxQs7tYXaflbzgrDwGxYP6W0B5bxNwDYmsSIDc4Cbf+qZ1CJgfwcgwPjNHbxMT3YxDS1y8tfYJxd84lqyc1yZcaCddQQTv6vYMpnwOth7mia95tljEd4E3lIFMYBCEteIXvgJjGl7B65sljGcnfgsQ7cqFxBvyKm+QIPMc1VfVj9Y1GvUMme/yw05N4DF/PCld6V09/u68GSz0Uqp/owfpEbqigRRBa+kvmTfxT/vaOSxstoUdo4GFlLUahgEzKGB1ZXLaOdikMZtqW34bTgg29qQkwM5GV0wg8AC4fgbGlLvaszK0NDp88RIQDRsM+1tnw3j3nDdb46vvLH+pzSXfzynPPKnkL8wNSawH07aD1FNx7o9MrmptqNgiZ6tqWf6sAFx+ooQEuGl5iBr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230373577357003)(230922051799003)(230473577357003)(1800799012)(451199024)(186009)(64100799003)(8676002)(6862004)(4326008)(8936002)(82960400001)(30864003)(26005)(36756003)(38100700002)(6666004)(2906002)(54906003)(66476007)(66556008)(6636002)(37006003)(316002)(66946007)(19627235002)(86362001)(5660300002)(478600001)(6486002)(966005)(6506007)(2616005)(107886003)(1076003)(83380400001)(41300700001)(6512007)(559001)(579004)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3ZhPjujACXiMS1yA6Au657gb6wFN7ji5Ccl8tBmyiUbjmKymh5RE9y2AUE?=
 =?iso-8859-1?Q?1fztAXh8A2ayl2SimWQZYV2CMwNCXo84R1g6RNAQIa9Ttod8JYXa9ugA2s?=
 =?iso-8859-1?Q?Wr3ezGdLB5ZOKG19MgwBVvJn83iVe9MNDbWn9npezfpPnljz5M2ldP+xrW?=
 =?iso-8859-1?Q?ewldCSfW8HGoc3MPOSB/KhsX69t0J7Kv2djBV1Aalv0PrfuAhlFsNRcgkf?=
 =?iso-8859-1?Q?pJD3QkwtJI4YEkN5J/DUKEW8wlYXqfdUoncbEQO5V8N3hGodp23AoG+WJS?=
 =?iso-8859-1?Q?SvYfXYifq5rvz6HqFPz0WldQfQd+5oP/Z2QyEcIyzVIY7oZ5u2ipcE7wLE?=
 =?iso-8859-1?Q?n+tV5CRjb7R/81a6bDE1WXSXcW9BacJBR8CfOm2Fa4h1o4eV3xxY0v9MV6?=
 =?iso-8859-1?Q?CZCuB3xrnQPpLrD8iiq9J7cYee1us+0sMcsQY1oL8jdvTIP5QnrAv8yyGk?=
 =?iso-8859-1?Q?wWg4HV/gIlQXPdt4pcAIUqhOz4ndZQ8JQ3cNxu22B+iMx/HNo5EuUw8G2i?=
 =?iso-8859-1?Q?2ofPaf/sWi/NMS0bSxqbMyuG1par2KCZmfiWis7todRcX1A5Hz9nLUiOs6?=
 =?iso-8859-1?Q?T05YEkLvde8yIf0YG7k6gHK8THTQQxMfWgZ9/SK/HOZj4/Nb/zd1lH2sFX?=
 =?iso-8859-1?Q?t/FcfDZDm+drjKKV0ZcymPrN6VT4sIPUhz0RFJtbGnfVCPG8fUJv3HvQ1n?=
 =?iso-8859-1?Q?Zvzrveywd0l4DmthHgZrvE0UtUx903hIyiCOpTkvdv+kPjqJQVFJ8Ce6CP?=
 =?iso-8859-1?Q?XgQ9GpzTYOHSrF2zgTyyg8KMvVOvOjBCJvYewAaCRlYZsSxwfD/NPAWfIM?=
 =?iso-8859-1?Q?phdo1Dz/RQJg0E58byI9M847l0M/dPkQ0n7lCfELT9XTgMeBd2mhVtccml?=
 =?iso-8859-1?Q?229Nm6HqWJU54xu9oBkk9bchxZdbfh+C0mhtaq/QmUsApwyx6fXpKpEBhs?=
 =?iso-8859-1?Q?9a8UtXrtXjCVpBlAIpzJgPFMx0tBLHlRyzbN8ZI0WSw9DhXOuiDWC0VnPd?=
 =?iso-8859-1?Q?WyclP4ihNVQPSMhtVJHnj1O0RH9lF8ah9MSeWKLEvst+G0wTsvsxiYTqOI?=
 =?iso-8859-1?Q?KZh/EwffR34FPxv9rZEFV1KPZyORpfvMmt+BnxjAV7zqs6QWr+EyDU1wIq?=
 =?iso-8859-1?Q?W0+87wsi7RNMow8Is/3cbA33oTaut5zb2bqR7m893DsxPtOE6bVT3JAmBu?=
 =?iso-8859-1?Q?Pvte7o7K6XTySnH1JKAbeCYV5ar/f0G2kv4ZUOr0pg8+m1XhTkggr+L71p?=
 =?iso-8859-1?Q?d7WWCHnDA9iCAt39brOhagQz2XxFduAVtI2Yq3fsaIU6OxpJq1iWNVkCIM?=
 =?iso-8859-1?Q?aapyTrYkOtRu0rZzyT7qa1eFN952vx02Vm8HlSWMSgY9p/yPOigTY2ROHn?=
 =?iso-8859-1?Q?C978bBDMQG1fngvkDW5VBA+XO8JLZzf3mlCfBPFJo1S//nej1CKEXwub2P?=
 =?iso-8859-1?Q?HjOHg04tRuu5qo+vAEyoZPRB1A9izvN1aKlxaSodq7S8VNuit9KCiIS46p?=
 =?iso-8859-1?Q?oqgT2him1FrdZtDG09O7V9l6bAprlvVZjuaoC3sp9fgkNghgS5Au/kiWMy?=
 =?iso-8859-1?Q?SI6fgLJkfoJlDjFCm2egmKTdIrwQtKizUuz06EeouRUpxtfJEmr3WYjowq?=
 =?iso-8859-1?Q?bwQPyGmWXxUd4/0wrS1jKRsCLxvy0PLJy+9jyOGW7PilrVGrx2pIjS9A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc1ae1e-7c3c-4ba9-4b85-08dbe9cf71dc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 13:48:59.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ9hcPuOuD5SjX933m9sB2Cs9tGZMvpiu6SoV4MjP8gbEpRoODCDHZuecCs4SoxRNi0SbmwgBZJRX/chaFbSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com


hi, Fengwei,

we noticed c8be038067 is the fix commit for
de74976eb65151a2f568e477fc2e0032df5b22b4 ("filemap: add filemap_map_folio_range()")

and we captured numbers of improvement for this commit
(refer to below
"In addition to that, the commit also has significant impact on the following tests"
part which includes several examples)

however, recently, we found a regression as title mentioned.

the extra information we want to share is we also tested on mainline tip when
this bisect done, and noticed the regression disappear:

# extra tests on head commit of linus/master
# good: [9bacdd8996c77c42ca004440be610692275ff9d0] Merge tag 'for-6.7-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux

the data is even better than parent:

  "vm-scalability.throughput": [
    54122867,
    58465096,
    55888729,
    56960948,
    56385702,
    56392203
  ],

and we also reverted c8be038067 on maineline tip, but found no big diff:

# extra tests on revert first bad commit
# good: [f13a82be4c3252dabd1328a437c309d84ec7a872] Revert "filemap: add filemap_map_order0_folio() to handle order0 folio"

  "vm-scalability.throughput": [
    56434337,
    56199754,
    56214041,
    55308070,
    55401115,
    55709753
  ],


below detail report FYI.


Hello,

kernel test robot noticed a -27.3% regression of vm-scalability.throughput on:


commit: c8be03806738c86521dbf1e0503bc90855fb99a3 ("filemap: add filemap_map_order0_folio() to handle order0 folio")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: vm-scalability
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	runtime: 300s
	size: 2T
	test: shm-pread-seq
	cpufreq_governor: performance

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.bad-altstack.ops_per_sec 43.7% improvement                                    |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | class=memory                                                                                       |
|                  | cpufreq_governor=performance                                                                       |
|                  | nr_threads=100%                                                                                    |
|                  | test=bad-altstack                                                                                  |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.zombie.ops_per_sec 19.1% improvement                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | class=scheduler                                                                                    |
|                  | cpufreq_governor=performance                                                                       |
|                  | nr_threads=100%                                                                                    |
|                  | sc_pid_max=4194304                                                                                 |
|                  | test=zombie                                                                                        |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.stackmmap.ops_per_sec 20.9% improvement                                       |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | class=memory                                                                                       |
|                  | cpufreq_governor=performance                                                                       |
|                  | nr_threads=100%                                                                                    |
|                  | test=stackmmap                                                                                     |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311201605.b86d11b-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231120/202311201605.b86d11b-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/2T/lkp-cpl-4sp2/shm-pread-seq/vm-scalability

commit: 
  578d7699e5 ("proc: nommu: /proc/<pid>/maps: release mmap read lock")
  c8be038067 ("filemap: add filemap_map_order0_folio() to handle order0 folio")

578d7699e5c2add8 c8be03806738c86521dbf1e0503 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    146.95 ±  8%     -83.0%      24.99 ±  3%  vm-scalability.free_time
    233050           -28.1%     167484        vm-scalability.median
    590.30 ± 12%    -590.2        0.06 ± 45%  vm-scalability.stddev%
  51589606           -27.3%   37516397        vm-scalability.throughput
    454.36 ±  2%     -27.4%     329.84        vm-scalability.time.elapsed_time
    454.36 ±  2%     -27.4%     329.84        vm-scalability.time.elapsed_time.max
    447644 ±  7%     -56.5%     194562        vm-scalability.time.involuntary_context_switches
  57615129           -34.3%   37879833        vm-scalability.time.maximum_resident_set_size
 6.643e+08 ±  2%     +14.5%  7.603e+08        vm-scalability.time.minor_page_faults
     20023            -3.6%      19307        vm-scalability.time.percent_of_cpu_this_job_got
     78240 ±  3%     -22.1%      60979        vm-scalability.time.system_time
     12755 ±  3%     -78.8%       2707        vm-scalability.time.user_time
 1.551e+10           -27.3%  1.128e+10        vm-scalability.workload
 2.879e+08 ±  5%     -15.1%  2.443e+08 ±  2%  cpuidle..usage
    512.49 ±  3%     -23.9%     390.01 ±  4%  uptime.boot
      5.67 ±  7%      +3.6        9.23 ±  3%  mpstat.cpu.all.iowait%
      1.34 ±  3%      -0.3        1.07        mpstat.cpu.all.irq%
      0.09 ±  3%      +0.1        0.15 ±  2%  mpstat.cpu.all.soft%
     12.81 ±  4%      -9.1        3.68 ±  3%  mpstat.cpu.all.usr%
   4191734 ±  8%     -48.8%    2146395 ±  3%  numa-meminfo.node0.PageTables
   3918649 ± 12%     -45.2%    2145986 ±  3%  numa-meminfo.node1.PageTables
   4093747 ±  4%     -47.6%    2146844 ±  3%  numa-meminfo.node2.PageTables
   3644113 ±  8%     -41.2%    2144379 ±  3%  numa-meminfo.node3.PageTables
   1045695 ±  8%     -48.7%     536280 ±  3%  numa-vmstat.node0.nr_page_table_pages
    977386 ± 12%     -45.1%     536191 ±  3%  numa-vmstat.node1.nr_page_table_pages
   1021288 ±  4%     -47.5%     536413 ±  3%  numa-vmstat.node2.nr_page_table_pages
    909161 ±  8%     -41.1%     535798 ±  3%  numa-vmstat.node3.nr_page_table_pages
     10645 ± 23%     +87.6%      19975 ±  4%  perf-c2c.DRAM.remote
     13229 ±  4%     -11.9%      11651 ±  4%  perf-c2c.HITM.local
      5092 ± 22%    +112.9%      10841 ±  4%  perf-c2c.HITM.remote
     18322 ±  7%     +22.8%      22492 ±  4%  perf-c2c.HITM.total
    733.20 ±106%    +188.1%       2112 ± 15%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     16.20 ± 79%    +246.3%      56.10 ± 10%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    359.49 ±101%    +111.3%     759.52 ± 10%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.47 ± 76%    +189.7%      12.96 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
 2.277e+08 ±  6%     -22.2%  1.772e+08 ±  2%  turbostat.C1
 3.494e+08 ±  3%     -14.6%  2.985e+08        turbostat.IRQ
      0.93 ±  6%      +0.8        1.77 ±  3%  turbostat.POLL%
    789.58            +4.0%     820.94        turbostat.PkgWatt
     20.85           +14.7%      23.92        turbostat.RAMWatt
     12.69 ±  4%     -71.5%       3.61 ±  2%  vmstat.cpu.us
  43706776 ±  4%     -41.2%   25695100 ±  2%  vmstat.memory.cache
 1.343e+08 ±  2%     +19.3%  1.602e+08        vmstat.memory.free
     15.21 ±  7%     +56.7%      23.83 ±  4%  vmstat.procs.b
   1319482 ±  5%     +24.5%    1642387 ±  2%  vmstat.system.cs
    753408 ±  4%     +16.4%     876599 ±  2%  vmstat.system.in
  10069412 ±  6%     -55.0%    4527666        meminfo.Active
  10069234 ±  6%     -55.0%    4527493        meminfo.Active(anon)
    499090 ± 11%     -21.0%     394130        meminfo.AnonPages
  43465935 ±  4%     -41.3%   25536132 ±  2%  meminfo.Cached
  41769100 ±  4%     -43.3%   23701253 ±  2%  meminfo.Committed_AS
  31178698 ±  6%     -40.1%   18682318 ±  3%  meminfo.Inactive
  31177590 ±  6%     -40.1%   18681205 ±  3%  meminfo.Inactive(anon)
    238806           -16.4%     199571        meminfo.KReclaimable
  29902607 ±  5%     -38.5%   18383780 ±  3%  meminfo.Mapped
 1.337e+08 ±  2%     +19.3%  1.595e+08        meminfo.MemAvailable
 1.343e+08 ±  2%     +19.3%  1.601e+08        meminfo.MemFree
  62315868 ±  4%     -41.5%   36466667 ±  2%  meminfo.Memused
  15903037 ±  4%     -46.1%    8577584 ±  3%  meminfo.PageTables
    238806           -16.4%     199571        meminfo.SReclaimable
  40748291 ±  4%     -44.0%   22818495 ±  2%  meminfo.Shmem
  64615117 ±  2%     -40.7%   38289223 ±  2%  meminfo.max_used_kB
   2514263 ±  6%     -55.0%    1131771        proc-vmstat.nr_active_anon
    124787 ± 11%     -21.0%      98542        proc-vmstat.nr_anon_pages
   3334444 ±  2%     +19.3%    3978641        proc-vmstat.nr_dirty_background_threshold
   6677042 ±  2%     +19.3%    7967011        proc-vmstat.nr_dirty_threshold
  10863166 ±  4%     -41.2%    6387601 ±  2%  proc-vmstat.nr_file_pages
  33573793 ±  2%     +19.2%   40025214        proc-vmstat.nr_free_pages
   7793920 ±  6%     -40.0%    4673828 ±  3%  proc-vmstat.nr_inactive_anon
   7475026 ±  5%     -38.5%    4599491 ±  3%  proc-vmstat.nr_mapped
    188.57 ±  8%     -76.8%      43.66 ± 63%  proc-vmstat.nr_mlock
   3972992 ±  4%     -46.0%    2146293 ±  3%  proc-vmstat.nr_page_table_pages
  10183498 ±  4%     -43.9%    5707934 ±  2%  proc-vmstat.nr_shmem
     59695           -16.4%      49897        proc-vmstat.nr_slab_reclaimable
   2514264 ±  6%     -55.0%    1131771        proc-vmstat.nr_zone_active_anon
   7793920 ±  6%     -40.0%    4673828 ±  3%  proc-vmstat.nr_zone_inactive_anon
   2766628 ± 57%    -100.0%       0.00        proc-vmstat.numa_foreign
    391489 ± 35%     -75.4%      96332 ± 18%  proc-vmstat.numa_hint_faults_local
  21486275 ±  7%     -13.3%   18621685        proc-vmstat.numa_hit
  21138181 ±  7%     -13.5%   18274190        proc-vmstat.numa_local
   2766891 ± 57%    -100.0%       0.00        proc-vmstat.numa_miss
   3115092 ± 51%     -88.8%     347931        proc-vmstat.numa_other
    109110 ± 24%     +61.3%     175954 ± 12%  proc-vmstat.numa_pages_migrated
  14982706 ±  3%     -35.2%    9710595        proc-vmstat.pgactivate
  24430375           -22.9%   18834204        proc-vmstat.pgalloc_normal
 6.666e+08 ±  2%     +14.3%  7.621e+08        proc-vmstat.pgfault
  23271087           -23.6%   17779395        proc-vmstat.pgfree
    117073 ± 24%     +50.3%     175954 ± 12%  proc-vmstat.pgmigrate_success
   4330444 ±  4%     -21.9%    3380121 ±  5%  proc-vmstat.unevictable_pgs_scanned
  38672501           -32.2%   26213957        sched_debug.cfs_rq:/.avg_vruntime.avg
  43533749           -39.3%   26445435        sched_debug.cfs_rq:/.avg_vruntime.max
  32662438 ±  2%     -23.3%   25039048        sched_debug.cfs_rq:/.avg_vruntime.min
   2639076 ±  5%     -96.1%     103315 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.26 ±  4%     +16.9%       0.30 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
  38672501           -32.2%   26213957        sched_debug.cfs_rq:/.min_vruntime.avg
  43533749           -39.3%   26445435        sched_debug.cfs_rq:/.min_vruntime.max
  32662438 ±  2%     -23.3%   25039048        sched_debug.cfs_rq:/.min_vruntime.min
   2639076 ±  5%     -96.1%     103315 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.23 ±  5%     +29.2%       0.29 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
     66.12 ±  4%     +33.7%      88.40 ±  4%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     66.12 ±  4%     +33.7%      88.40 ±  4%  sched_debug.cfs_rq:/.removed.util_avg.max
    833.32           -12.0%     733.62        sched_debug.cfs_rq:/.runnable_avg.avg
    822.67           -11.1%     731.70        sched_debug.cfs_rq:/.util_avg.avg
    703.41           -11.5%     622.45        sched_debug.cfs_rq:/.util_est_enqueued.avg
    291437 ±  9%     -36.3%     185610 ±  6%  sched_debug.cpu.avg_idle.avg
   1373747 ±  7%     -53.5%     639110 ± 21%  sched_debug.cpu.avg_idle.max
    311766 ± 10%     -80.0%      62273 ± 19%  sched_debug.cpu.avg_idle.stddev
    259159 ±  3%     -22.4%     201226 ±  4%  sched_debug.cpu.clock.avg
    259253 ±  3%     -22.4%     201258 ±  4%  sched_debug.cpu.clock.max
    259061 ±  3%     -22.3%     201193 ±  4%  sched_debug.cpu.clock.min
     55.15 ± 25%     -66.2%      18.61 ±  2%  sched_debug.cpu.clock.stddev
    255520 ±  3%     -22.0%     199182 ±  4%  sched_debug.cpu.clock_task.avg
    257528 ±  3%     -22.6%     199345 ±  4%  sched_debug.cpu.clock_task.max
    243929 ±  3%     -22.9%     188111 ±  5%  sched_debug.cpu.clock_task.min
      1355 ±  4%     -44.4%     753.86        sched_debug.cpu.clock_task.stddev
     13033           -14.5%      11147        sched_debug.cpu.curr->pid.max
      1721 ±  4%     +13.1%       1947 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 19%     -52.5%       0.00 ±  4%  sched_debug.cpu.next_balance.stddev
      0.26 ±  4%     +16.0%       0.31 ±  3%  sched_debug.cpu.nr_running.stddev
   1701953 ±  4%     -27.9%    1226353        sched_debug.cpu.nr_switches.avg
   3143553 ±  6%     -59.2%    1281519        sched_debug.cpu.nr_switches.max
      3343 ±119%  +33494.7%    1123165 ±  2%  sched_debug.cpu.nr_switches.min
   1097318 ±  4%     -97.9%      22912 ±  4%  sched_debug.cpu.nr_switches.stddev
    917.29 ± 22%     -34.7%     598.55 ± 16%  sched_debug.cpu.nr_uninterruptible.max
    259060 ±  3%     -22.3%     201193 ±  4%  sched_debug.cpu_clk
    258191 ±  3%     -22.4%     200325 ±  4%  sched_debug.ktime
      0.34 ± 48%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.avg
     75.78 ± 49%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.max
      5.05 ± 49%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.stddev
    259849 ±  3%     -22.3%     201989 ±  4%  sched_debug.sched_clk
      9.17 ±  3%     -42.0%       5.31 ±  2%  perf-stat.i.MPKI
  65435643 ±  4%    +104.3%  1.337e+08 ±  3%  perf-stat.i.branch-misses
     34.90 ±  3%      +7.1       42.03 ±  2%  perf-stat.i.cache-miss-rate%
 3.085e+08 ±  5%     +61.5%  4.981e+08 ±  2%  perf-stat.i.cache-misses
  9.19e+08 ±  3%     +25.9%  1.157e+09 ±  2%  perf-stat.i.cache-references
   1302191 ±  5%     +27.3%    1657210 ±  3%  perf-stat.i.context-switches
     26.50 ±  5%     -71.4%       7.58        perf-stat.i.cpi
      2681 ±  8%     -37.9%       1665 ±  8%  perf-stat.i.cycles-between-cache-misses
      0.03 ± 10%      +0.0        0.05 ±  3%  perf-stat.i.dTLB-load-miss-rate%
  10965806 ±  9%     +56.5%   17158984 ±  3%  perf-stat.i.dTLB-load-misses
      0.02 ±  3%      +0.0        0.04 ±  2%  perf-stat.i.dTLB-store-miss-rate%
   1654494 ±  4%     +70.3%    2817035 ±  2%  perf-stat.i.dTLB-store-misses
 5.977e+09 ±  3%     +16.6%  6.969e+09 ±  3%  perf-stat.i.dTLB-stores
     57.89 ±  2%      -9.5       48.43        perf-stat.i.iTLB-load-miss-rate%
   6831330 ±  3%     +44.5%    9871864 ±  2%  perf-stat.i.iTLB-load-misses
   9529695 ±  6%     +24.0%   11815915 ±  2%  perf-stat.i.iTLB-loads
      0.15 ±  2%      +7.8%       0.16        perf-stat.i.ipc
      0.80 ± 10%     -87.8%       0.10 ± 40%  perf-stat.i.major-faults
    375.07 ± 10%    +137.2%     889.49        perf-stat.i.metric.K/sec
   1414824 ±  3%     +59.5%    2257244 ±  3%  perf-stat.i.minor-faults
     90.52 ±  3%      +5.2       95.72        perf-stat.i.node-load-miss-rate%
  37916208 ±  8%    +171.5%  1.029e+08 ±  2%  perf-stat.i.node-load-misses
  21342086 ±  7%    +204.5%   64985024 ±  2%  perf-stat.i.node-store-misses
   1414825 ±  3%     +59.5%    2257244 ±  3%  perf-stat.i.page-faults
      2.67 ±  2%     +55.8%       4.17        perf-stat.overall.MPKI
      0.18 ±  3%      +0.2        0.37        perf-stat.overall.branch-miss-rate%
     33.42 ±  3%      +9.6       43.00        perf-stat.overall.cache-miss-rate%
      6.79 ±  2%      -6.7%       6.33        perf-stat.overall.cpi
      2542 ±  5%     -40.2%       1519        perf-stat.overall.cycles-between-cache-misses
      0.03 ±  8%      +0.0        0.05 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.03            +0.0        0.04        perf-stat.overall.dTLB-store-miss-rate%
     41.77 ±  2%      +3.8       45.55        perf-stat.overall.iTLB-load-miss-rate%
     16702 ±  2%     -27.5%      12109        perf-stat.overall.instructions-per-iTLB-miss
      0.15 ±  2%      +7.2%       0.16        perf-stat.overall.ipc
     90.48 ±  3%      +5.5       95.99        perf-stat.overall.node-load-miss-rate%
      3449            +3.7%       3577        perf-stat.overall.path-length
  66272060 ±  4%    +101.5%  1.335e+08 ±  3%  perf-stat.ps.branch-misses
 3.092e+08 ±  5%     +60.8%  4.973e+08 ±  2%  perf-stat.ps.cache-misses
 9.247e+08 ±  2%     +25.1%  1.156e+09 ±  2%  perf-stat.ps.cache-references
   1322674 ±  5%     +25.1%    1654989 ±  2%  perf-stat.ps.context-switches
  11227627 ±  9%     +54.8%   17376410 ±  3%  perf-stat.ps.dTLB-load-misses
   1683857 ±  3%     +67.2%    2816043 ±  2%  perf-stat.ps.dTLB-store-misses
 6.064e+09 ±  3%     +14.9%  6.964e+09 ±  2%  perf-stat.ps.dTLB-stores
   6920435 ±  3%     +42.4%    9856085 ±  2%  perf-stat.ps.iTLB-load-misses
   9666427 ±  7%     +21.9%   11782628 ±  2%  perf-stat.ps.iTLB-loads
      0.78 ± 10%     -87.9%       0.09 ± 39%  perf-stat.ps.major-faults
   1439311 ±  3%     +56.6%    2253893 ±  2%  perf-stat.ps.minor-faults
  37981755 ±  8%    +170.6%  1.028e+08 ±  2%  perf-stat.ps.node-load-misses
  21277078 ±  7%    +205.0%   64901471 ±  2%  perf-stat.ps.node-store-misses
   1439312 ±  3%     +56.6%    2253894 ±  2%  perf-stat.ps.page-faults
 5.349e+13           -24.6%  4.035e+13        perf-stat.total.instructions
     10.51 ±  3%      -7.1        3.41 ±  2%  perf-profile.calltrace.cycles-pp.do_rw_once
      1.79 ±  5%      -1.0        0.81 ±  2%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.38 ±  4%      -0.3        1.06        perf-profile.calltrace.cycles-pp.__wake_up_common.folio_wake_bit.filemap_map_pages.do_read_fault.do_fault
      1.20 ±  4%      -0.3        0.88        perf-profile.calltrace.cycles-pp.wake_page_function.__wake_up_common.folio_wake_bit.filemap_map_pages.do_read_fault
      0.56 ±  2%      +0.4        0.92        perf-profile.calltrace.cycles-pp.folio_add_file_rmap_range.set_pte_range.filemap_map_pages.do_read_fault.do_fault
      0.98 ±  4%      +0.4        1.36 ±  2%  perf-profile.calltrace.cycles-pp.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.97 ±  4%      +0.4        1.35 ±  2%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
      0.91 ±  4%      +0.4        1.32 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.folio_wait_bit_common.shmem_get_folio_gfp
      0.64            +0.5        1.14 ±  2%  perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.6        0.57 ±  5%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.00            +0.6        0.62 ±  4%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.00            +0.6        0.63 ±  4%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.00            +0.7        0.69 ±  4%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      1.32 ± 10%      +0.7        2.03        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.8        0.80 ±  6%  perf-profile.calltrace.cycles-pp.up_read.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +0.8        0.82 ±  3%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.io_schedule
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.io_schedule.folio_wait_bit_common
      6.82 ±  8%      +1.0        7.84 ±  2%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.2        1.16        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
      9.41 ±  7%      +1.2       10.61 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      9.41 ±  7%      +1.2       10.61 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      9.45 ±  7%      +1.2       10.66 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      9.40 ±  7%      +1.2       10.61 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      8.67 ±  7%      +1.4       10.10 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      8.28 ±  7%      +1.7        9.94 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.26 ±  7%      +1.7        9.93 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     10.84 ±  9%      +3.0       13.85 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     60.08            +3.6       63.63        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     82.57            +3.8       86.34        perf-profile.calltrace.cycles-pp.do_access
      0.87 ± 10%      +4.8        5.67        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_wake_bit.do_read_fault.do_fault
      0.91 ± 10%      +4.9        5.79        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_wake_bit.do_read_fault.do_fault.__handle_mm_fault
      1.11 ± 10%      +5.2        6.27        perf-profile.calltrace.cycles-pp.folio_wake_bit.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.78 ± 10%      +5.6        6.39        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault
      0.97 ±  9%      +5.7        6.65        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault.__do_fault
      2.69 ±  6%      +6.9        9.59        perf-profile.calltrace.cycles-pp.folio_wait_bit_common.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
      5.00 ±  4%      +6.9       11.94        perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      4.98 ±  4%      +6.9       11.93        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      3.22 ±  5%      +8.5       11.75        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault.do_fault
      3.79 ±  8%     +11.3       15.11        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_wake_bit.filemap_map_pages.do_read_fault
      5.70 ±  7%     +11.4       17.13        perf-profile.calltrace.cycles-pp.folio_wake_bit.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      4.03 ±  8%     +11.5       15.52        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_wake_bit.filemap_map_pages.do_read_fault.do_fault
     68.49           +15.3       83.81        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     69.65           +15.4       85.07        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     68.64           +15.7       84.30        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     69.02           +15.7       84.71        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     69.00           +15.7       84.70        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     66.77           +16.5       83.30        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     66.75           +16.5       83.30        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      8.38           +28.3       36.67        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      8.41 ±  2%      -5.3        3.15        perf-profile.children.cycles-pp.do_rw_once
      1.17 ±  3%      -0.7        0.43        perf-profile.children.cycles-pp.try_to_wake_up
      1.06 ±  5%      -0.5        0.59 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.99 ±  6%      -0.4        0.57 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.89 ±  5%      -0.4        0.48 ±  2%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.34 ±  5%      -0.2        0.09        perf-profile.children.cycles-pp.select_task_rq
      0.67 ±  4%      -0.2        0.42 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.48 ±  3%      -0.2        0.29        perf-profile.children.cycles-pp.ttwu_do_activate
      0.27 ±  6%      -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.32 ±  4%      -0.2        1.15        perf-profile.children.cycles-pp.wake_page_function
      1.09 ±  4%      -0.2        0.91        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.37 ±  2%      -0.2        0.20 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.28 ±  5%      -0.2        0.12 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.23 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.54 ±  4%      -0.2        1.38        perf-profile.children.cycles-pp.__wake_up_common
      0.22 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.20 ±  5%      -0.2        0.05        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.34 ±  4%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.23 ± 35%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.sync_regs
      0.36 ±  4%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.activate_task
      0.30 ±  4%      -0.1        0.17 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.18 ±  6%      -0.1        0.06        perf-profile.children.cycles-pp.available_idle_cpu
      0.33 ±  4%      -0.1        0.21        perf-profile.children.cycles-pp.enqueue_task_fair
      0.30 ± 12%      -0.1        0.18 ± 11%  perf-profile.children.cycles-pp.xas_find
      0.17 ±  5%      -0.1        0.05 ±  5%  perf-profile.children.cycles-pp.wake_affine
      0.25 ±  4%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.16 ±  6%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.llist_reverse_order
      0.16 ±  3%      -0.1        0.06 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.21 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.41 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.40 ±  2%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.38 ±  3%      -0.1        0.29        perf-profile.children.cycles-pp.schedule_idle
      0.16 ±  3%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.llist_add_batch
      0.20 ±  6%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.56 ±  2%      -0.1        0.50        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.35 ±  2%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.36 ±  3%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.09 ±  5%      -0.1        0.04 ± 50%  perf-profile.children.cycles-pp.__switch_to_asm
      0.09 ± 23%      -0.1        0.04 ± 65%  perf-profile.children.cycles-pp.update_cfs_group
      0.09 ±  3%      -0.0        0.05        perf-profile.children.cycles-pp.prepare_task_switch
      0.10 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__switch_to
      0.28 ±  2%      -0.0        0.25        perf-profile.children.cycles-pp.tick_sched_timer
      0.26            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.18 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.21            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.07 ±  6%      -0.0        0.05 ±  5%  perf-profile.children.cycles-pp.mtree_range_walk
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.08 ±  3%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.mas_walk
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.16 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.26 ±  4%      +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.10 ±  5%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.08 ± 11%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.down_read_trylock
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.idle_cpu
      0.40 ±  3%      +0.1        0.47        perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.folio_unlock
      0.21 ±  5%      +0.3        0.47        perf-profile.children.cycles-pp.finish_fault
      0.00            +0.3        0.26 ±  4%  perf-profile.children.cycles-pp._compound_head
      1.29 ±  3%      +0.3        1.61 ±  2%  perf-profile.children.cycles-pp.__schedule
      0.13 ±  4%      +0.4        0.49 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      0.10 ±  4%      +0.4        0.47 ±  5%  perf-profile.children.cycles-pp.__perf_sw_event
      0.98 ±  4%      +0.4        1.36 ±  2%  perf-profile.children.cycles-pp.schedule
      0.98 ±  4%      +0.4        1.36 ±  2%  perf-profile.children.cycles-pp.io_schedule
      0.06 ±  6%      +0.5        0.59 ±  4%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.07 ±  6%      +0.6        0.63 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.64 ±  2%      +0.6        1.21        perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.08 ±  6%      +0.6        0.64 ±  4%  perf-profile.children.cycles-pp.find_busiest_group
      0.10 ±  5%      +0.6        0.71 ±  4%  perf-profile.children.cycles-pp.load_balance
      0.21 ±  6%      +0.7        0.88 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.14 ±  8%      +0.7        0.83 ±  3%  perf-profile.children.cycles-pp.newidle_balance
      1.33 ± 10%      +0.7        2.04        perf-profile.children.cycles-pp.poll_idle
      0.73 ±  2%      +0.7        1.46        perf-profile.children.cycles-pp.set_pte_range
      0.12 ±  8%      +0.8        0.91 ±  6%  perf-profile.children.cycles-pp.up_read
      0.20 ±  5%      +1.0        1.17        perf-profile.children.cycles-pp.filemap_get_entry
      6.84 ±  8%      +1.0        7.88 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      6.83 ±  8%      +1.0        7.88 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      6.16 ±  8%      +1.2        7.33 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      9.41 ±  7%      +1.2       10.61 ±  2%  perf-profile.children.cycles-pp.start_secondary
      9.45 ±  7%      +1.2       10.66 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      9.45 ±  7%      +1.2       10.66 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      9.45 ±  7%      +1.2       10.66 ±  2%  perf-profile.children.cycles-pp.do_idle
      8.70 ±  7%      +1.4       10.15 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      8.31 ±  7%      +1.7        9.98 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      8.30 ±  7%      +1.7        9.98 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     84.90            +2.3       87.25        perf-profile.children.cycles-pp.do_access
     60.22            +3.4       63.64        perf-profile.children.cycles-pp.filemap_map_pages
      0.99 ±  9%      +5.7        6.67        perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.69 ±  6%      +6.9        9.59        perf-profile.children.cycles-pp.folio_wait_bit_common
      5.00 ±  4%      +6.9       11.94        perf-profile.children.cycles-pp.__do_fault
      4.98 ±  4%      +6.9       11.93        perf-profile.children.cycles-pp.shmem_fault
      3.24 ±  5%      +8.5       11.75        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     68.51           +15.3       83.82        perf-profile.children.cycles-pp.__handle_mm_fault
     69.68           +15.4       85.08        perf-profile.children.cycles-pp.asm_exc_page_fault
     68.66           +15.6       84.31        perf-profile.children.cycles-pp.handle_mm_fault
     69.04           +15.7       84.72        perf-profile.children.cycles-pp.exc_page_fault
     69.02           +15.7       84.70        perf-profile.children.cycles-pp.do_user_addr_fault
      5.13 ±  8%     +16.3       21.44        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     66.78           +16.5       83.31        perf-profile.children.cycles-pp.do_fault
     66.76           +16.5       83.30        perf-profile.children.cycles-pp.do_read_fault
      6.82 ±  7%     +16.6       23.40        perf-profile.children.cycles-pp.folio_wake_bit
      5.46 ±  9%     +21.7       27.18        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      8.40           +28.3       36.68        perf-profile.children.cycles-pp.next_uptodate_folio
     45.04           -36.6        8.40        perf-profile.self.cycles-pp.filemap_map_pages
     14.17 ±  4%     -12.6        1.58 ±  2%  perf-profile.self.cycles-pp.do_access
      5.52            -3.1        2.42        perf-profile.self.cycles-pp.do_rw_once
      1.76 ±  3%      -1.6        0.17 ±  7%  perf-profile.self.cycles-pp.shmem_fault
      1.65 ± 16%      -1.2        0.47 ±  6%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.23 ± 35%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.sync_regs
      0.25 ±  7%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.18 ±  5%      -0.1        0.06        perf-profile.self.cycles-pp.available_idle_cpu
      0.25 ±  3%      -0.1        0.17        perf-profile.self.cycles-pp.__schedule
      0.14 ±  7%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.llist_reverse_order
      0.16 ±  3%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.llist_add_batch
      0.09 ± 23%      -0.1        0.02 ±100%  perf-profile.self.cycles-pp.update_cfs_group
      0.36 ±  3%      -0.1        0.30 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.09 ±  5%      -0.1        0.04 ± 50%  perf-profile.self.cycles-pp.__switch_to_asm
      0.10 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.10 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__switch_to
      0.07 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.update_load_avg
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.mtree_range_walk
      0.07 ±  6%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.06 ± 12%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.xas_load
      0.08 ± 10%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.down_read_trylock
      0.21 ±  4%      +0.1        0.28        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.idle_cpu
      0.38 ±  3%      +0.1        0.46        perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.13 ±  4%  perf-profile.self.cycles-pp.folio_unlock
      0.47 ±  5%      +0.2        0.65        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.3        0.26 ±  3%  perf-profile.self.cycles-pp._compound_head
      0.28 ±  5%      +0.3        0.61        perf-profile.self.cycles-pp.folio_wake_bit
      0.11 ±  4%      +0.4        0.48 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.04 ± 65%      +0.4        0.44 ±  4%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.10 ± 10%      +0.6        0.65        perf-profile.self.cycles-pp.wake_page_function
      0.64 ±  2%      +0.6        1.20        perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.22 ±  3%      +0.7        0.90 ±  3%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      1.29 ± 10%      +0.7        2.01        perf-profile.self.cycles-pp.poll_idle
      0.12 ±  6%      +0.8        0.91 ±  6%  perf-profile.self.cycles-pp.up_read
      0.67 ±  5%      +0.8        1.51        perf-profile.self.cycles-pp.folio_wait_bit_common
      0.17 ±  4%      +0.9        1.08        perf-profile.self.cycles-pp.filemap_get_entry
      5.43 ±  8%      +1.8        7.27 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
      5.46 ±  9%     +21.7       27.18        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      8.05           +28.3       36.31        perf-profile.self.cycles-pp.next_uptodate_folio


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/bad-altstack/stress-ng/60s

commit: 
  578d7699e5 ("proc: nommu: /proc/<pid>/maps: release mmap read lock")
  c8be038067 ("filemap: add filemap_map_order0_folio() to handle order0 folio")

578d7699e5c2add8 c8be03806738c86521dbf1e0503 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2778801 ±  8%     +26.9%    3525681 ±  9%  cpuidle..usage
    146784 ±  4%     +31.1%     192365 ±  3%  vmstat.system.cs
    156332 ±  2%      +9.4%     171094 ±  3%  vmstat.system.in
      1.17            +0.1        1.30        mpstat.cpu.all.irq%
      0.54 ±  3%      +0.2        0.74        mpstat.cpu.all.soft%
      3.11 ±  3%      +0.7        3.76 ±  3%  mpstat.cpu.all.usr%
  58108481 ±  9%     +25.3%   72812441 ±  3%  numa-numastat.node0.local_node
  58147023 ±  9%     +25.3%   72844565 ±  3%  numa-numastat.node0.numa_hit
  45215009 ± 11%     +58.9%   71868173 ±  4%  numa-numastat.node1.local_node
  45243383 ± 11%     +58.9%   71893824 ±  4%  numa-numastat.node1.numa_hit
   4001490 ±  2%     +22.2%    4890478        meminfo.AnonPages
   6305237 ±  2%     +18.2%    7454771        meminfo.Committed_AS
   4777320 ±  3%     +24.2%    5933044        meminfo.Inactive
   4777105 ±  3%     +24.2%    5932829        meminfo.Inactive(anon)
   8865439           +13.7%   10076851        meminfo.Memused
    900111 ±  2%     +32.5%    1192737        meminfo.Shmem
   8983245           +12.5%   10107849        meminfo.max_used_kB
    303506 ±  5%     -19.0%     245819 ± 10%  numa-meminfo.node0.Mapped
     66174 ± 16%     +45.9%      96535 ±  9%  numa-meminfo.node1.Active
     66142 ± 16%     +45.9%      96503 ±  9%  numa-meminfo.node1.Active(anon)
   3300013 ±  6%     +28.5%    4239780 ±  5%  numa-meminfo.node1.AnonPages
   3711161 ±  7%     +32.7%    4926114 ±  4%  numa-meminfo.node1.Inactive
   3711088 ±  7%     +32.7%    4926043 ±  4%  numa-meminfo.node1.Inactive(anon)
    477631 ± 13%     +63.9%     782856 ±  6%  numa-meminfo.node1.Shmem
   2720488 ±  7%     +28.7%    3500421 ±  9%  turbostat.C1
      0.11 ±  3%     +38.5%       0.15        turbostat.IPC
  10180542 ±  3%     +10.0%   11201761 ±  2%  turbostat.IRQ
      2.50 ± 80%     +32.4       34.90 ± 24%  turbostat.PKG_%
     28607 ± 68%     -80.6%       5538 ± 15%  turbostat.POLL
    378.99            +4.2%     394.93        turbostat.PkgWatt
     86.06           +15.5%      99.37        turbostat.RAMWatt
   2802814           +43.7%    4026903        stress-ng.bad-altstack.ops
     46712           +43.7%      67113        stress-ng.bad-altstack.ops_per_sec
    277949 ±  6%     +26.3%     350923 ±  2%  stress-ng.time.involuntary_context_switches
    381473 ± 31%     -87.4%      48154 ± 17%  stress-ng.time.major_page_faults
 1.351e+08 ±  3%     +36.7%  1.848e+08 ±  2%  stress-ng.time.minor_page_faults
      2660           -16.2%       2228        stress-ng.time.system_time
    758.86 ±  3%     +58.2%       1200        stress-ng.time.user_time
   5562615 ±  2%     +36.4%    7587646        stress-ng.time.voluntary_context_switches
     75912 ±  5%     -19.0%      61486 ± 10%  numa-vmstat.node0.nr_mapped
  58148639 ±  9%     +25.3%   72846279 ±  3%  numa-vmstat.node0.numa_hit
  58110097 ±  9%     +25.3%   72814154 ±  3%  numa-vmstat.node0.numa_local
     16538 ± 16%     +45.9%      24127 ±  9%  numa-vmstat.node1.nr_active_anon
    825616 ±  6%     +28.4%    1060453 ±  5%  numa-vmstat.node1.nr_anon_pages
    928424 ±  7%     +32.7%    1232031 ±  4%  numa-vmstat.node1.nr_inactive_anon
    119440 ± 13%     +63.9%     195729 ±  6%  numa-vmstat.node1.nr_shmem
     16538 ± 16%     +45.9%      24127 ±  9%  numa-vmstat.node1.nr_zone_active_anon
    928423 ±  7%     +32.7%    1232029 ±  4%  numa-vmstat.node1.nr_zone_inactive_anon
  45244190 ± 11%     +58.9%   71894276 ±  4%  numa-vmstat.node1.numa_hit
  45215816 ± 11%     +58.9%   71868625 ±  4%  numa-vmstat.node1.numa_local
    996402 ±  2%     +22.8%    1223085        proc-vmstat.nr_anon_pages
    911227            +8.1%     984744        proc-vmstat.nr_file_pages
   1189975 ±  3%     +24.7%    1483657        proc-vmstat.nr_inactive_anon
     16944            -1.2%      16741        proc-vmstat.nr_kernel_stack
    224669 ±  2%     +32.7%     298186        proc-vmstat.nr_shmem
     46440            +1.9%      47326        proc-vmstat.nr_slab_unreclaimable
   1189975 ±  3%     +24.7%    1483657        proc-vmstat.nr_zone_inactive_anon
 1.034e+08 ±  3%     +40.0%  1.447e+08 ±  3%  proc-vmstat.numa_hit
 1.033e+08 ±  3%     +40.0%  1.447e+08 ±  4%  proc-vmstat.numa_local
   2348501 ±  8%     +23.4%    2897258 ±  8%  proc-vmstat.numa_pte_updates
 1.085e+08 ±  3%     +40.2%  1.521e+08 ±  3%  proc-vmstat.pgalloc_normal
 1.418e+08 ±  3%     +35.5%  1.922e+08 ±  2%  proc-vmstat.pgfault
 1.053e+08 ±  3%     +39.6%   1.47e+08 ±  3%  proc-vmstat.pgfree
   5448523 ±  2%     +43.1%    7798982        proc-vmstat.pgreuse
      1.58 ± 33%    +163.2%       4.17 ± 27%  sched_debug.cfs_rq:/.load_avg.min
      0.53 ±  8%     +14.1%       0.60 ±  3%  sched_debug.cfs_rq:/.nr_running.avg
    558.27 ±  2%     +12.5%     628.25 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
    514.79 ±  4%     +15.5%     594.46 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      1233 ±  5%     +18.9%       1466 ± 12%  sched_debug.cfs_rq:/.util_avg.max
     66.71 ± 16%     +75.6%     117.17 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    143.65 ± 10%     +18.0%     169.56 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    495236 ±  5%     -15.3%     419320 ±  4%  sched_debug.cpu.avg_idle.avg
    230019 ±  5%     -23.1%     176874 ±  8%  sched_debug.cpu.avg_idle.stddev
    689359 ± 17%     +38.0%     951353 ± 16%  sched_debug.cpu.curr->pid.avg
   1334646           +43.9%    1920253        sched_debug.cpu.curr->pid.max
    656174 ±  2%     +44.3%     946628        sched_debug.cpu.curr->pid.stddev
     74209 ±  4%     +30.6%      96907 ±  2%  sched_debug.cpu.nr_switches.avg
    117189 ± 15%     +20.5%     141177 ±  3%  sched_debug.cpu.nr_switches.max
     40246 ± 12%     +66.3%      66930 ±  8%  sched_debug.cpu.nr_switches.min
   -111.50           -66.0%     -37.92        sched_debug.cpu.nr_uninterruptible.min
     47.64 ± 79%     -67.5%      15.48 ± 11%  sched_debug.cpu.nr_uninterruptible.stddev
      4.01 ±  3%     +18.7%       4.76        perf-stat.i.MPKI
 1.333e+10 ±  2%     +43.7%  1.917e+10        perf-stat.i.branch-instructions
      0.83            +0.0        0.87        perf-stat.i.branch-miss-rate%
 1.044e+08 ±  2%     +52.3%   1.59e+08        perf-stat.i.branch-misses
     24.52 ±  2%      +2.4       26.93        perf-stat.i.cache-miss-rate%
 2.705e+08 ±  4%     +70.1%    4.6e+08        perf-stat.i.cache-misses
 1.076e+09 ±  3%     +54.9%  1.667e+09        perf-stat.i.cache-references
    152699 ±  5%     +32.5%     202264 ±  3%  perf-stat.i.context-switches
      3.13 ±  2%     -29.9%       2.20        perf-stat.i.cpi
     37636 ±  8%     +68.6%      63438        perf-stat.i.cpu-migrations
    886.42 ±  4%     -36.2%     565.50 ±  5%  perf-stat.i.cycles-between-cache-misses
  20382778 ±  8%     +41.9%   28920852 ±  8%  perf-stat.i.dTLB-load-misses
 1.681e+10 ±  2%     +43.3%  2.408e+10        perf-stat.i.dTLB-loads
  13221560 ±  5%     +44.8%   19144603 ±  3%  perf-stat.i.dTLB-store-misses
 8.862e+09           +39.9%   1.24e+10        perf-stat.i.dTLB-stores
 6.528e+10 ±  2%     +43.0%  9.337e+10        perf-stat.i.instructions
      0.34 ±  4%     +37.0%       0.47 ±  2%  perf-stat.i.ipc
      6574 ± 33%     -87.8%     802.35 ± 17%  perf-stat.i.major-faults
      1783 ±  3%     -23.0%       1373        perf-stat.i.metric.K/sec
    626.92 ±  2%     +43.1%     897.38        perf-stat.i.metric.M/sec
   2206202 ±  3%     +37.2%    3027691 ±  2%  perf-stat.i.minor-faults
  72316714 ±  2%     +54.6%  1.118e+08        perf-stat.i.node-load-misses
   5689150 ±  7%     +44.6%    8224440 ±  2%  perf-stat.i.node-loads
     48.50 ±  2%      +7.5       55.98        perf-stat.i.node-store-miss-rate%
  43592798 ±  2%     +60.1%   69775942        perf-stat.i.node-store-misses
  44813181 ±  4%     +16.4%   52146078 ±  2%  perf-stat.i.node-stores
   2321939 ±  3%     +37.3%    3186964 ±  2%  perf-stat.i.page-faults
      4.16 ±  2%     +17.4%       4.89        perf-stat.overall.MPKI
      0.77            +0.0        0.82        perf-stat.overall.branch-miss-rate%
     25.37 ±  2%      +2.2       27.57        perf-stat.overall.cache-miss-rate%
      3.11           -28.7%       2.22        perf-stat.overall.cpi
    748.23 ±  4%     -39.4%     453.76        perf-stat.overall.cycles-between-cache-misses
      0.32           +40.3%       0.45        perf-stat.overall.ipc
     49.87 ±  2%      +7.6       57.47        perf-stat.overall.node-store-miss-rate%
 1.326e+10           +40.2%  1.858e+10        perf-stat.ps.branch-instructions
 1.025e+08           +48.7%  1.524e+08        perf-stat.ps.branch-misses
   2.7e+08 ±  3%     +63.8%  4.423e+08        perf-stat.ps.cache-misses
 1.064e+09 ±  2%     +50.8%  1.604e+09        perf-stat.ps.cache-references
    150044 ±  4%     +30.4%     195609 ±  2%  perf-stat.ps.context-switches
     62652            -1.1%      61978        perf-stat.ps.cpu-clock
     36296 ±  7%     +64.3%      59630        perf-stat.ps.cpu-migrations
  20872687 ±  7%     +41.3%   29486856 ±  7%  perf-stat.ps.dTLB-load-misses
  1.67e+10           +39.8%  2.335e+10        perf-stat.ps.dTLB-loads
  13186219 ±  5%     +41.7%   18687087 ±  3%  perf-stat.ps.dTLB-store-misses
 8.814e+09           +36.7%  1.205e+10        perf-stat.ps.dTLB-stores
 6.483e+10           +39.6%  9.048e+10        perf-stat.ps.instructions
      6035 ± 32%     -87.5%     752.85 ± 16%  perf-stat.ps.major-faults
   2191364 ±  2%     +34.1%    2939168 ±  2%  perf-stat.ps.minor-faults
  71563816 ±  2%     +50.3%  1.076e+08        perf-stat.ps.node-load-misses
   6176536 ±  7%     +42.2%    8784322 ±  3%  perf-stat.ps.node-loads
  43871487           +55.0%   68012264        perf-stat.ps.node-store-misses
  44129912 ±  3%     +14.1%   50336211 ±  2%  perf-stat.ps.node-stores
   2305172 ±  2%     +34.2%    3093254 ±  2%  perf-stat.ps.page-faults
     62652            -1.1%      61978        perf-stat.ps.task-clock
  4.04e+12 ±  2%     +39.2%  5.623e+12        perf-stat.total.instructions
      0.03 ±  7%     +20.3%       0.04 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      0.02 ± 24%     +65.2%       0.03 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.do_read_fault.do_fault
      0.00 ± 64%    +491.3%       0.02 ± 82%  perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.do_cow_fault.do_fault.__handle_mm_fault
      0.02 ±  6%     +36.8%       0.03 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.02 ±223%   +2481.9%       0.45 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.__vunmap_range_noflush.remove_vm_area.vfree.delayed_vfree_work
      0.01 ± 49%    +344.8%       0.04 ± 48%  perf-sched.sch_delay.avg.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      0.05 ± 21%     -21.8%       0.04 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.01 ± 84%    +401.7%       0.05 ± 62%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      0.01 ± 68%    +242.0%       0.03 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.01 ± 38%     +88.1%       0.03 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.02 ± 13%     +42.2%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.02 ± 18%     +43.8%       0.03 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.01 ± 37%    +155.0%       0.03 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 27%    +154.4%       0.02 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.walk_component.link_path_walk.part
      0.02 ±  7%     +43.1%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.02 ± 14%     +30.1%       0.03 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.05 ± 12%     -24.5%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      0.01 ± 47%    +187.0%       0.03 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.mmput.proc_coredump_filter_write.vfs_write.ksys_write
      0.02 ± 12%     +76.7%       0.03 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.01 ± 28%    +109.6%       0.03 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      0.01 ± 64%    +463.9%       0.03 ± 58%  perf-sched.sch_delay.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.get_signal
      0.02 ± 13%     +36.4%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.02 ± 37%     +84.2%       0.04 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.01 ± 46%    +350.0%       0.04 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.02 ±  6%     +44.9%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.02 ±  8%     +50.5%       0.03 ±  3%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.05 ±  4%     -15.1%       0.04 ±  5%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ±  5%     +35.6%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.03 ±  7%     +16.1%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ±  4%     +45.2%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.02 ±  3%     +55.8%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.03 ± 13%     -34.7%       0.02 ±  7%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      0.03 ±  6%     -28.6%       0.02 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.04 ±  3%     -10.3%       0.03 ±  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±223%   +3327.6%       0.60 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.__vunmap_range_noflush.remove_vm_area.vfree.delayed_vfree_work
      0.02 ± 53%    +517.1%       0.11 ± 75%  perf-sched.sch_delay.max.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      0.02 ± 61%    +775.5%       0.15 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      0.02 ± 84%    +502.8%       0.11 ± 33%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.09 ± 50%    +203.7%       0.28 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.07 ± 60%    +250.8%       0.26 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.dput.walk_component.link_path_walk.part
      0.06 ± 73%    +268.2%       0.21 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.mmput.proc_coredump_filter_write.vfs_write.ksys_write
      0.28 ± 16%     +65.0%       0.46 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.02 ±114%    +951.4%       0.18 ± 81%  perf-sched.sch_delay.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.get_signal
      0.17 ± 57%    +134.7%       0.39 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.51 ± 14%    +110.4%       3.17 ± 33%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      1.10 ± 19%     -39.8%       0.66 ± 23%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      1.16 ± 23%     -51.3%       0.56 ± 17%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      2.38 ±  2%     -28.3%       1.70        perf-sched.total_wait_and_delay.average.ms
    563062 ±  2%     +35.7%     763916        perf-sched.total_wait_and_delay.count.ms
      2.34 ±  2%     -28.8%       1.67        perf-sched.total_wait_time.average.ms
     52.75 ± 42%     -45.7%      28.66 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     11.94 ±  9%     -35.3%       7.73 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±  8%     +17.8%       0.03 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      1.09 ±  2%     -45.8%       0.59        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.03 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     27.24 ±  5%     -31.1%      18.77 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.25 ±  6%     -30.7%       9.18 ±  5%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     34.50 ± 10%    +100.0%      69.00 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.83 ± 25%    +217.1%      21.67 ± 14%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      2041 ± 13%    +142.8%       4958 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    228205 ±  2%     +44.1%     328952        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
    228618 ±  2%     +44.2%     329566        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      9872 ±  6%     -66.8%       3276 ± 44%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     32642 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     21245 ±  6%     +44.1%      30608 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     24631 ±  6%     +44.4%      35566 ±  6%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    152.98 ± 13%     -23.1%     117.66 ± 14%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.59 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.04 ± 32%     -66.4%       0.01 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      1.07 ±  9%     -50.0%       0.53 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc.mm_init
      1.05 ± 12%     -48.1%       0.54        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pmd_alloc.copy_p4d_range.copy_page_range
      1.08 ± 15%     -50.6%       0.53 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pud_alloc.copy_p4d_range.copy_page_range
      0.96 ± 18%     -49.4%       0.49 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.get_zeroed_page.__p4d_alloc.copy_p4d_range
      1.06 ±  5%     -47.7%       0.55 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.copy_pte_range
      1.06 ± 11%     -48.1%       0.55 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      1.03 ± 12%     -41.3%       0.60 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
      1.03 ± 11%     -50.9%       0.51 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.95 ± 18%     -50.4%       0.47 ± 48%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range
      0.01 ± 49%     -90.2%       0.00 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      1.04 ± 19%     -48.5%       0.54 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.98 ±  6%     -43.4%       0.56 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      1.03 ±  4%     -46.3%       0.55        perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      1.05 ±  2%     -47.3%       0.55        perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      1.02 ±  9%     -46.2%       0.55 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dentry_kill.dput.proc_invalidate_siblings_dcache.release_task
      1.02 ±  3%     -46.0%       0.55        perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      1.04 ±  2%     -46.2%       0.56 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      1.04 ±  4%     -47.4%       0.55        perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.01 ± 45%     -90.7%       0.00 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.01 ± 52%     -93.6%       0.00 ±152%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.01 ± 44%     -96.4%       0.00 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.98 ± 17%     -42.3%       0.57 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.dput.proc_invalidate_siblings_dcache.release_task.wait_task_zombie
      0.01 ± 45%     -87.5%       0.00 ± 57%  perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
     52.75 ± 42%     -45.7%      28.66 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.00 ± 40%     -89.3%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.94 ±  9%     -45.2%       0.52 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      1.04 ±  2%     -46.8%       0.55        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      1.07 ±  7%     -49.8%       0.54 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      1.11 ± 10%     -48.9%       0.57 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      1.10 ±  7%     -48.9%       0.56 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      0.95 ± 20%     -41.5%       0.55 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      1.09 ±  9%     -47.9%       0.57 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      1.02 ±  4%     -46.3%       0.54        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      1.05 ±  3%     -47.2%       0.55        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      1.09 ± 11%     -48.5%       0.56 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.01 ± 72%     -97.5%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      1.04 ±  6%     -46.5%       0.56 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      1.01 ±  7%     -45.3%       0.55        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      1.03 ±  2%     -47.0%       0.55        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.02 ± 79%     -96.7%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
     11.93 ±  9%     -35.3%       7.71 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 53%     -84.8%       0.00 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      9.77 ±200%     -94.3%       0.56        perf-sched.wait_time.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.01 ± 23%     -43.6%       0.01 ±  7%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      1.04 ±  2%     -47.1%       0.55        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 14%    +615.6%       0.05 ±179%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.16 ±128%    +525.1%       1.00 ± 66%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ± 21%     -90.5%       0.00 ± 57%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1.03 ± 23%     -49.0%       0.53 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc
      0.63 ±  7%     -58.8%       0.26 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.62 ±  4%     -60.8%       0.24 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      0.78 ± 14%     -60.2%       0.31 ± 17%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
     27.21 ±  5%     -31.1%      18.74 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.21 ±  6%     -30.8%       9.14 ±  5%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.48 ± 10%     -52.8%       0.70 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc.mm_init
      1.67 ± 14%     -44.9%       0.92 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__pmd_alloc.copy_p4d_range.copy_page_range
      1.93 ± 43%     -61.9%       0.73 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__pud_alloc.copy_p4d_range.copy_page_range
      1.09 ± 25%     -45.3%       0.60 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.get_zeroed_page.__p4d_alloc.copy_p4d_range
      1.73 ± 20%     -43.7%       0.97 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.copy_pte_range
      1.36 ±  5%     -40.5%       0.81 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      1.49 ± 14%     -47.9%       0.78 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      1.33 ± 16%     -46.0%       0.72 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      1.10 ± 25%     -53.7%       0.51 ± 50%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range
      0.70 ± 12%     -22.0%       0.55 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      1.42 ± 35%     -47.4%       0.75 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      1.34 ± 14%     -45.0%       0.73 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.dentry_kill.dput.proc_invalidate_siblings_dcache.release_task
      0.04 ±157%     -98.4%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      2.13 ± 22%     -41.0%       1.26 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      3.53 ± 62%     -61.7%       1.35 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.72 ± 19%     -73.2%       0.19 ±107%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      1.04 ± 16%     -38.9%       0.64 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.dput.proc_invalidate_siblings_dcache.release_task.wait_task_zombie
      0.19 ±106%     -99.7%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.62 ± 12%     -88.1%       0.07 ±197%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      1.60 ± 12%     -37.9%       0.99 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      1.60 ± 17%     -49.8%       0.81 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      1.52 ± 24%     -46.1%       0.82 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      1.45 ± 15%     -41.9%       0.84 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      1.08 ± 30%     -38.2%       0.67 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      1.57 ± 13%     -35.4%       1.01 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      1.81 ± 11%     -44.1%       1.01 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      1.46 ± 19%     -43.3%       0.83 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.45 ± 69%     -87.8%       0.05 ±212%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      1.51 ± 13%     -43.4%       0.85 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      1.70 ± 15%     -41.5%       0.99 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      1.67 ± 14%     -42.5%       0.96 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.35 ± 68%     -85.9%       0.05 ±219%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
    152.96 ± 13%     -23.1%     117.65 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    167.94 ±221%     -99.4%       1.02 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.33 ±120%   +1444.6%       5.06 ± 77%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.98 ± 16%     -64.2%       0.35 ± 39%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1.17 ± 14%     -48.3%       0.61 ± 10%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc
     42.74 ±  3%     -37.3        5.45 ±  8%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     42.72 ±  3%     -37.3        5.44 ±  8%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     42.22 ±  3%     -37.3        4.97 ± 11%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     44.18 ±  2%     -36.7        7.47 ±  5%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     22.56 ±  5%     -17.2        5.38 ±  5%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     22.94 ±  5%     -17.0        5.90 ±  5%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     22.95 ±  5%     -17.0        5.92 ±  5%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     44.65 ±  2%      -2.3       42.33        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.74 ±  4%      -2.2        0.52        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__sigsetjmp
      2.73 ±  4%      -2.2        0.51        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__sigsetjmp
      2.77 ±  4%      -2.2        0.58        perf-profile.calltrace.cycles-pp.__sigsetjmp
      2.77 ±  4%      -2.2        0.58        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__sigsetjmp
      2.75 ±  4%      -2.2        0.55 ±  3%  perf-profile.calltrace.cycles-pp.setrlimit64
      2.92 ±  5%      -2.2        0.75        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      2.92 ±  5%      -2.2        0.75        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      2.92 ±  5%      -2.2        0.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      2.93 ±  5%      -2.2        0.77        perf-profile.calltrace.cycles-pp.__open64_nocancel
      2.97 ±  4%      -2.2        0.81 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
      2.92 ±  5%      -2.2        0.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      3.09 ±  3%      -2.1        0.99 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
      3.10 ±  4%      -2.1        1.00 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__libc_fork
      3.24 ±  3%      -2.0        1.21 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__libc_fork
      1.13 ± 23%      -0.4        0.68 ± 18%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mwc_reseed
      1.25 ± 21%      -0.4        0.80 ± 18%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_mwc_reseed
      1.20 ± 22%      -0.4        0.75 ± 17%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_mwc_reseed
      1.19 ± 22%      -0.4        0.75 ± 17%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mwc_reseed
      1.34 ± 21%      -0.4        0.94 ± 15%  perf-profile.calltrace.cycles-pp.stress_mwc_reseed
      1.17 ± 26%      -0.3        0.90 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_bad_altstack
      1.27 ± 25%      -0.2        1.02        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_bad_altstack
      1.34 ± 23%      -0.2        1.11        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_bad_altstack
      0.65            -0.1        0.57        perf-profile.calltrace.cycles-pp.dup_userfaultfd.dup_mmap.dup_mm.copy_process.kernel_clone
      0.67 ±  4%      +0.1        0.77 ±  5%  perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.90 ±  2%      +0.2        1.08        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store.dup_mmap.dup_mm
      0.88 ±  2%      +0.2        1.08        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.88 ±  2%      +0.2        1.08        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.01 ±  2%      +0.2        1.24        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store.dup_mmap.dup_mm.copy_process
      0.60 ±  3%      +0.2        0.85 ±  9%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.81 ±  2%      +0.3        1.07        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_bad_altstack
      0.69 ±  3%      +0.3        0.95 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.81            +0.3        1.07        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_bad_altstack
      0.81            +0.3        1.07        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_bad_altstack
      0.59 ±  3%      +0.3        0.91        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.55 ±  3%      +0.3        0.86        perf-profile.calltrace.cycles-pp.remove_vma.exit_mmap.__mmput.exit_mm.do_exit
      0.59 ±  3%      +0.3        0.92        perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4
      0.43 ± 44%      +0.3        0.77        perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.63 ±  4%      +0.3        0.97        perf-profile.calltrace.cycles-pp.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.36 ± 70%      +0.4        0.72 ±  3%  perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      0.52 ±  2%      +0.4        0.90 ±  3%  perf-profile.calltrace.cycles-pp.free_swap_cache.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap
      0.53 ±  2%      +0.4        0.91 ±  2%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.17 ±141%      +0.4        0.58        perf-profile.calltrace.cycles-pp.__slab_free.exit_mmap.__mmput.exit_mm.do_exit
      0.79            +0.4        1.20        perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.__mmput.exit_mm.do_exit
      0.74 ±  2%      +0.4        1.17        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.96 ±  2%      +0.4        1.40 ±  3%  perf-profile.calltrace.cycles-pp.up_write.dup_mmap.dup_mm.copy_process.kernel_clone
      0.80 ±  4%      +0.5        1.29 ±  2%  perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exit_mm
      0.76 ±  8%      +0.5        1.26        perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.82 ±  2%      +0.5        1.33 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_wait.kernel_wait4.__do_sys_wait4
      0.82 ±  2%      +0.5        1.33 ±  2%  perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2.46            +0.5        2.98 ±  3%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.up_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      1.60            +0.5        2.12        perf-profile.calltrace.cycles-pp.mas_store.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      0.00            +0.5        0.55 ±  3%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.kmem_cache_free.__vm_area_free.exit_mmap.__mmput.exit_mm
      0.00            +0.6        0.59 ± 13%  perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      0.00            +0.6        0.59 ±  6%  perf-profile.calltrace.cycles-pp.schedule_tail.ret_from_fork.ret_from_fork_asm.__libc_fork
      0.00            +0.6        0.59 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.do_task_dead.do_exit.do_group_exit.get_signal
      0.00            +0.6        0.60 ±  4%  perf-profile.calltrace.cycles-pp.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      1.34            +0.6        1.94 ±  2%  perf-profile.calltrace.cycles-pp.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.do_wait
      0.00            +0.6        0.61 ±  6%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm.__libc_fork
      2.02 ±  2%      +0.6        2.63 ±  7%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.17 ±141%      +0.6        0.79 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.00            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_wait.kernel_wait4
      0.00            +0.6        0.62 ± 14%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.00            +0.6        0.63 ± 18%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap
      0.00            +0.6        0.65 ±  6%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm.__libc_fork
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.kmem_cache_free.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.7        0.69 ±  2%  perf-profile.calltrace.cycles-pp._compound_head.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range
      0.08 ±223%      +0.7        0.78        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store.dup_mmap.dup_mm.copy_process
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.fput.remove_vma.exit_mmap.__mmput.exit_mm
      2.24 ±  4%      +0.8        3.00 ±  5%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      0.00            +0.8        0.77        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm.copy_process
      0.00            +0.8        0.77 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__put_anon_vma.unlink_anon_vmas
      1.08 ±  3%      +0.8        1.86 ±  3%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.8        0.79 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00            +0.8        0.81 ±  4%  perf-profile.calltrace.cycles-pp.down_write.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      1.46            +0.8        2.30        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm.copy_process
      0.81 ±  5%      +0.9        1.68 ±  2%  perf-profile.calltrace.cycles-pp.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      2.65 ±  3%      +0.9        3.54 ±  4%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      0.44 ± 45%      +0.9        1.34        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.00            +0.9        0.94 ± 13%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
      2.79 ±  3%      +0.9        3.73 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      0.76 ±  2%      +1.0        1.76 ±  8%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      0.00            +1.0        1.01 ± 15%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
      0.62 ±  6%      +1.0        1.63        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      0.00            +1.0        1.04 ± 12%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
      1.18 ±  2%      +1.1        2.25 ±  8%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +1.1        1.11        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.00            +1.1        1.13 ± 14%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
      1.64 ±  2%      +1.1        2.78        perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68 ±  2%      +1.2        2.84        perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      1.67 ±  2%      +1.2        2.84        perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      1.70 ±  2%      +1.2        2.88        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      1.71 ±  2%      +1.2        2.88        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      1.75 ±  2%      +1.2        2.95        perf-profile.calltrace.cycles-pp.wait4
      2.03            +1.2        3.24        perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      1.38 ±  2%      +1.3        2.65 ±  4%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      2.31 ±  3%      +1.4        3.70        perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.58 ±  8%      +1.5        2.13 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.29 ±101%      +1.9        2.16 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      2.39 ±  2%      +2.0        4.36 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.92 ±  7%      +2.2        3.14 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      2.96 ±  2%      +2.4        5.33 ±  3%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      3.00 ±  2%      +2.4        5.38 ±  3%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.07 ± 10%      +2.5        3.54 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables
      1.26 ±  7%      +2.5        3.75 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
      5.64            +2.5        8.14 ±  2%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      1.12 ± 10%      +2.6        3.68 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      1.32 ±  7%      +2.6        3.88 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      5.91            +2.7        8.56 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      6.07            +2.7        8.82 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.36 ±  8%      +2.7        4.11 ±  2%  perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      1.52 ±  6%      +2.8        4.34 ±  2%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      6.48            +2.9        9.35        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      1.73 ±  6%      +3.4        5.11 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
      1.79 ±  6%      +3.5        5.24 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
      1.94 ±  6%      +3.5        5.46        perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
      5.19 ±  5%      +5.5       10.72        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      5.50 ±  4%      +5.6       11.05        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      7.96 ±  3%      +7.4       15.41        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      8.49 ±  4%      +9.8       18.33        perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
     20.13 ±  2%     +14.0       34.09        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     20.19 ±  2%     +14.0       34.18        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
     20.20 ±  2%     +14.0       34.19        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     25.64           +14.3       39.93        perf-profile.calltrace.cycles-pp.__libc_fork
     21.42 ±  2%     +14.6       36.02        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     21.42 ±  2%     +14.6       36.02        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     21.43 ±  2%     +14.6       36.02        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault
     19.37 ±  2%     +14.8       34.18        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     22.02 ±  2%     +14.8       36.83        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
     22.22 ±  2%     +14.9       37.08        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     19.97 ±  2%     +15.1       35.08        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     21.42 ±  2%     +15.2       36.61        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
     21.42 ±  2%     +15.2       36.61        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
     21.35 ±  2%     +15.8       37.13        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.89 ±  2%     +16.1       37.96        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     21.88 ±  2%     +16.1       37.96        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     21.89 ±  2%     +16.1       37.98        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     21.89 ±  2%     +16.1       37.98        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
     43.99 ±  2%     -34.5        9.47 ±  4%  perf-profile.children.cycles-pp.do_read_fault
     44.05 ±  2%     -34.5        9.53 ±  4%  perf-profile.children.cycles-pp.do_fault
     45.77 ±  2%     -34.4       11.35 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
     43.61 ±  2%     -34.4        9.20 ±  4%  perf-profile.children.cycles-pp.filemap_map_pages
     46.03 ±  2%     -34.2       11.79 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
     47.01 ±  2%     -33.9       13.11 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
     47.14 ±  2%     -33.9       13.27 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
     70.28           -18.6       51.67        perf-profile.children.cycles-pp.asm_exc_page_fault
      2.74 ±  6%      -2.3        0.48 ±  3%  perf-profile.children.cycles-pp.getname_flags
      2.72 ±  6%      -2.3        0.46 ±  3%  perf-profile.children.cycles-pp.strncpy_from_user
      2.77 ±  4%      -2.2        0.59 ±  3%  perf-profile.children.cycles-pp.setrlimit64
      2.82 ±  4%      -2.2        0.64        perf-profile.children.cycles-pp.__sigsetjmp
      2.93 ±  5%      -2.2        0.77        perf-profile.children.cycles-pp.__open64_nocancel
      3.91 ±  4%      -2.0        1.89        perf-profile.children.cycles-pp.do_sys_openat2
      3.91 ±  4%      -2.0        1.90        perf-profile.children.cycles-pp.__x64_sys_openat
      2.25 ± 21%      -1.8        0.48 ±  4%  perf-profile.children.cycles-pp.strlen@plt
      1.00 ±122%      -0.9        0.12 ±  6%  perf-profile.children.cycles-pp.sysinfo
      1.16 ± 76%      -0.7        0.46 ±  4%  perf-profile.children.cycles-pp.shim_nanosleep_uint64
      1.39 ± 21%      -0.4        1.02 ± 14%  perf-profile.children.cycles-pp.stress_mwc_reseed
      0.63 ± 13%      -0.2        0.42 ±  5%  perf-profile.children.cycles-pp.stress_align_address
      0.66 ± 11%      -0.2        0.46 ±  3%  perf-profile.children.cycles-pp.__sigsetjmp@plt
      0.18 ± 21%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__do_fault
      0.92 ±  3%      -0.1        0.81 ±  4%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.66            -0.1        0.58        perf-profile.children.cycles-pp.dup_userfaultfd
      0.60 ±  2%      -0.1        0.54 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.08 ± 10%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.07 ±  9%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.pmd_install
      0.09 ±  7%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.__bad_area_nosemaphore
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.cpu_clock_sample_group
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.oom_score_adj_write
      0.13 ±  2%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.write
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.task_rq_lock
      0.06 ±  7%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.14 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__fput
      0.09            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.thread_group_cputime
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.do_sysinfo
      0.09 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__mprotect
      0.06 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.__send_signal_locked
      0.08 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.__call_rcu_common
      0.14 ±  2%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.do_open
      0.05            +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__p4d_alloc
      0.09 ±  4%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.09            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.do_prlimit
      0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.lru_add_fn
      0.05 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.error_entry
      0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.copy_signal
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.update_blocked_averages
      0.06            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.05 ±  7%      +0.0        0.07        perf-profile.children.cycles-pp.__do_sys_sysinfo
      0.05 ±  7%      +0.0        0.07        perf-profile.children.cycles-pp.select_idle_sibling
      0.05 ±  7%      +0.0        0.07        perf-profile.children.cycles-pp.find_vma
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.exit_task_stack_account
      0.07 ±  5%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.get_zeroed_page
      0.05 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.12 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.__do_sys_prlimit64
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.perf_event_task
      0.16 ±  5%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.__folio_alloc
      0.08 ± 10%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.08 ± 10%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.09 ±  7%      +0.0        0.11        perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.07 ±  5%      +0.0        0.09        perf-profile.children.cycles-pp.stress_get_setting
      0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.07 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.06            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.init_file
      0.06 ±  6%      +0.0        0.08        perf-profile.children.cycles-pp.d_walk
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.pcpu_alloc_area
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.terminate_walk
      0.07            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.seq_printf
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.mas_next_node
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.add_device_randomness
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.perf_event_fork
      0.18 ±  6%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.lookup_fast
      0.04 ± 44%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.07 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.allocate_slab
      0.13 ±  2%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.09 ± 13%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.05 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.mas_store_b_node
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.__update_load_avg_se
      0.04 ± 45%      +0.0        0.07 ±  9%  perf-profile.children.cycles-pp.free_uid
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.mprotect_fixup
      0.04 ± 45%      +0.0        0.07 ±  9%  perf-profile.children.cycles-pp.refcount_dec_and_lock_irqsave
      0.06            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.inode_init_always
      0.06            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      0.07 ± 10%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.refcount_dec_not_one
      0.04 ± 45%      +0.0        0.07        perf-profile.children.cycles-pp.mt_find
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.account_kernel_stack
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__get_free_pages
      0.10 ±  5%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.vsnprintf
      0.03 ± 70%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mast_split_data
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.put_files_struct
      0.04 ± 44%      +0.0        0.07        perf-profile.children.cycles-pp.security_cred_free
      0.16 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.13 ±  6%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.xas_find
      0.08 ±  5%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.perf_event_task_output
      0.05            +0.0        0.08        perf-profile.children.cycles-pp._find_next_or_bit
      0.19 ±  5%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.08 ±  7%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.06 ±  6%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.lockref_put_return
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.filp_flush
      0.11            +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.11 ±  3%      +0.0        0.14 ± 10%  perf-profile.children.cycles-pp.__close
      0.16 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.get_sigframe
      0.08 ±  4%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.select_task_rq
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.handle_signal
      0.07 ±  5%      +0.0        0.10        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mas_pop_node
      0.11            +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.07 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.dup_fd
      0.08 ±  6%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__d_alloc
      0.07 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.06 ±  9%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.nr_running
      0.12 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.pgd_alloc
      0.08 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mas_mab_cp
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.copy_creds
      0.02 ± 99%      +0.0        0.06        perf-profile.children.cycles-pp.update_rq_clock
      0.17 ±  6%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.13 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.do_coredump
      0.10 ±  6%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.17 ±  3%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.16 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      0.07 ±  6%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.mas_wr_walk
      0.08 ± 12%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.put_ucounts
      0.08 ± 12%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp._atomic_dec_and_lock_irqsave
      0.17 ±  4%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.10 ±  7%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.flush_tlb_func
      0.07            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__put_task_struct
      0.08 ±  8%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.xas_load
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp._find_next_and_bit
      0.10 ±  3%      +0.0        0.14 ± 10%  perf-profile.children.cycles-pp.free_pud_range
      0.11            +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
      0.06            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.11 ±  6%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.cpu_util
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.10 ±  4%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.free_p4d_range
      0.11 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.11 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.08 ±  6%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.09 ±  7%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      0.09 ±  7%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map
      0.13 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.proc_pident_instantiate
      0.11 ±  4%      +0.0        0.16 ±  8%  perf-profile.children.cycles-pp.free_pgd_range
      0.29 ±  2%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.memset_orig
      0.15 ± 12%      +0.0        0.19 ±  8%  perf-profile.children.cycles-pp.step_into
      0.06 ±  7%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.06            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.percpu_counter_destroy_many
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.cgroup_can_fork
      0.07 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.07 ± 10%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.mas_expected_entries
      0.17 ±  4%      +0.0        0.22        perf-profile.children.cycles-pp.proc_pident_lookup
      0.21 ±  4%      +0.0        0.26        perf-profile.children.cycles-pp.__wake_up_common
      0.11 ±  4%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.mas_find
      0.07 ±  9%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.03 ± 70%      +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.__free_one_page
      0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.select_collect
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__anon_vma_prepare
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.security_file_alloc
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.select_idle_cpu
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.number
      0.04 ± 45%      +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.22 ±  7%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.shrink_dcache_parent
      0.01 ±223%      +0.1        0.06        perf-profile.children.cycles-pp.prepare_task_switch
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.shuffle_freelist
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.mt_destroy_walk
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp._raw_write_lock_irq
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp._copy_from_user
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.xas_descend
      0.08 ±  5%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.alloc_pid
      0.30 ±  4%      +0.1        0.35 ±  3%  perf-profile.children.cycles-pp.unmap_single_vma
      0.11 ±  6%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.d_alloc
      0.08 ±  5%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.free_percpu
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.list_lru_add
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.12 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.prepare_creds
      0.12 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp._find_next_bit
      0.02 ±141%      +0.1        0.07        perf-profile.children.cycles-pp.filp_close
      0.15 ±  4%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.lru_add_drain
      0.06 ±  7%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.security_prepare_creds
      0.30            +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.28 ±  3%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.d_lru_add
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.mutex_lock
      0.15 ±  3%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.23 ±  6%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.d_invalidate
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.free_pid
      0.03 ±100%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.03 ± 70%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.13 ±  2%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.__exit_signal
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__mt_destroy
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.mas_ascend
      0.08 ±  9%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.detach_tasks
      0.13            +0.1        0.19        perf-profile.children.cycles-pp.loadavg_proc_show
      0.10 ±  8%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__init_rwsem
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.16 ±  7%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.alloc_inode
      0.16 ±  6%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.14 ±  5%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.14 ±  5%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.11            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.sched_cgroup_fork
      0.20 ± 10%      +0.1        0.26        perf-profile.children.cycles-pp.proc_pid_make_inode
      0.37            +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.39            +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.21 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.1        0.06 ± 26%  perf-profile.children.cycles-pp.find_unlink_vmap_area
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.proc_alloc_inode
      0.11 ±  4%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.mas_split_final_node
      0.21 ±  2%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.__memcpy
      0.21 ±  3%      +0.1        0.27        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.15 ±  4%      +0.1        0.22        perf-profile.children.cycles-pp.mab_mas_cp
      0.10 ±  4%      +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.free_unref_page
      0.36            +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.26 ±  8%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__lookup_slow
      0.22 ±  2%      +0.1        0.28        perf-profile.children.cycles-pp.__reclaim_stacks
      0.14 ±  4%      +0.1        0.21        perf-profile.children.cycles-pp.vm_normal_page
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.uncharge_batch
      0.33 ±  6%      +0.1        0.40 ± 10%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.17 ± 15%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.new_inode
      0.20 ±  7%      +0.1        0.27 ±  6%  perf-profile.children.cycles-pp.dput
      0.19 ±  2%      +0.1        0.26        perf-profile.children.cycles-pp.seq_read_iter
      0.22            +0.1        0.29        perf-profile.children.cycles-pp.__read_nocancel
      0.06 ± 11%      +0.1        0.13 ± 20%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.20 ±  2%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.down_read_trylock
      0.43            +0.1        0.51 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.22 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp.vfs_read
      0.22 ±  3%      +0.1        0.29        perf-profile.children.cycles-pp.do_notify_parent
      0.25 ±  3%      +0.1        0.33        perf-profile.children.cycles-pp.lookup_open
      0.18 ±  4%      +0.1        0.26        perf-profile.children.cycles-pp.sched_move_task
      0.08 ± 10%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.process_one_work
      0.22 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.ksys_read
      0.05 ± 46%      +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.vfree
      0.18 ±  6%      +0.1        0.26 ±  9%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.15 ±  3%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.14 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.48            +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.16 ±  4%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.15 ±  3%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.46            +0.1        0.55 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.07 ±  5%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.mark_page_accessed
      0.39 ±  6%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.walk_component
      0.09 ± 11%      +0.1        0.18 ± 16%  perf-profile.children.cycles-pp.worker_thread
      0.20 ±  3%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.18 ±  5%      +0.1        0.26        perf-profile.children.cycles-pp.dequeue_entity
      0.24 ±  2%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__put_user_4
      0.20 ±  3%      +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.37 ±  2%      +0.1        0.46        perf-profile.children.cycles-pp.open_last_lookups
      0.33 ±  4%      +0.1        0.42        perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.16 ±  3%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.01 ±223%      +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.remove_vm_area
      0.21 ±  4%      +0.1        0.30        perf-profile.children.cycles-pp.refill_obj_stock
      0.55 ±  6%      +0.1        0.64 ±  3%  perf-profile.children.cycles-pp.link_path_walk
      0.19 ±  5%      +0.1        0.28        perf-profile.children.cycles-pp.enqueue_task_fair
      0.22 ±  4%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.21 ±  5%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.23 ±  3%      +0.1        0.33        perf-profile.children.cycles-pp.update_load_avg
      0.19 ±  3%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.activate_task
      0.32 ±  4%      +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.mas_push_data
      0.28 ±  4%      +0.1        0.39 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      0.23 ±  4%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.40 ±  2%      +0.1        0.51 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.24 ±  4%      +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.mtree_range_walk
      0.24 ±  8%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.put_cred_rcu
      0.35 ±  2%      +0.1        0.47        perf-profile.children.cycles-pp.__nptl_set_robust
      0.18 ±  3%      +0.1        0.30        perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.23 ±  5%      +0.1        0.35        perf-profile.children.cycles-pp.dequeue_task_fair
      0.24 ±  2%      +0.1        0.37        perf-profile.children.cycles-pp.mas_update_gap
      0.28 ±  3%      +0.1        0.41        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.12 ±  8%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.30 ±  7%      +0.1        0.44 ±  8%  perf-profile.children.cycles-pp.clear_page_erms
      0.33 ±  2%      +0.1        0.47        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.14 ±  9%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.20            +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.18 ±  2%      +0.2        0.33 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.39 ±  3%      +0.2        0.55 ±  2%  perf-profile.children.cycles-pp.sync_regs
      0.20 ±  5%      +0.2        0.36 ±  4%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.31 ±  2%      +0.2        0.48        perf-profile.children.cycles-pp.mas_wr_append
      0.43 ±  7%      +0.2        0.60 ±  4%  perf-profile.children.cycles-pp.do_task_dead
      0.29            +0.2        0.45        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.40 ±  9%      +0.2        0.57 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.26            +0.2        0.43 ±  3%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.14 ± 10%      +0.2        0.31 ± 20%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.32 ±  2%      +0.2        0.48 ±  2%  perf-profile.children.cycles-pp.acct_collect
      0.14 ± 10%      +0.2        0.31 ± 20%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.31 ±  3%      +0.2        0.48        perf-profile.children.cycles-pp.pcpu_alloc
      0.64 ±  5%      +0.2        0.82 ±  7%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.31            +0.2        0.49        perf-profile.children.cycles-pp.find_idlest_group
      0.22 ±  4%      +0.2        0.41 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.46 ±  8%      +0.2        0.65 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      0.26 ±  4%      +0.2        0.45 ±  3%  perf-profile.children.cycles-pp.__perf_sw_event
      0.45 ±  8%      +0.2        0.64 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.91 ±  2%      +0.2        1.10        perf-profile.children.cycles-pp.mas_split
      0.30 ±  5%      +0.2        0.48 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.18 ± 10%      +0.2        0.37 ± 19%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.39 ±  4%      +0.2        0.59 ± 13%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.39 ±  5%      +0.2        0.59 ±  6%  perf-profile.children.cycles-pp.schedule_tail
      0.34 ±  2%      +0.2        0.55        perf-profile.children.cycles-pp.find_idlest_cpu
      0.52 ±  5%      +0.2        0.73 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      1.35 ±  3%      +0.2        1.56 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      1.42 ±  2%      +0.2        1.64 ±  3%  perf-profile.children.cycles-pp.set_pte_range
      0.24 ±  9%      +0.2        0.47 ±  7%  perf-profile.children.cycles-pp.kthread
      0.48 ±  2%      +0.2        0.72        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.43            +0.2        0.66        perf-profile.children.cycles-pp.select_task_rq_fair
      0.46 ±  3%      +0.2        0.70        perf-profile.children.cycles-pp.__cond_resched
      0.28 ±  5%      +0.2        0.52 ±  4%  perf-profile.children.cycles-pp.__rb_erase_color
      1.01 ±  2%      +0.2        1.25        perf-profile.children.cycles-pp.mas_wr_bnode
      0.60 ±  4%      +0.2        0.85 ±  9%  perf-profile.children.cycles-pp.dup_task_struct
      1.11 ±  2%      +0.2        1.36        perf-profile.children.cycles-pp.path_openat
      0.54 ±  2%      +0.2        0.79        perf-profile.children.cycles-pp.lock_vma_under_rcu
      1.02 ±  5%      +0.2        1.27 ±  7%  perf-profile.children.cycles-pp.__alloc_pages
      0.62 ±  3%      +0.2        0.87 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.47            +0.2        0.72        perf-profile.children.cycles-pp.mas_next_slot
      1.12            +0.2        1.37        perf-profile.children.cycles-pp.do_filp_open
      0.31 ±  3%      +0.3        0.56        perf-profile.children.cycles-pp.exit_notify
      0.44 ±  2%      +0.3        0.69 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.52 ±  2%      +0.3        0.78        perf-profile.children.cycles-pp.mm_init
      0.54 ±  2%      +0.3        0.80 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.13 ±  5%      +0.3        0.40        perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.48 ±  3%      +0.3        0.77        perf-profile.children.cycles-pp.fput
      0.49 ±  2%      +0.3        0.78        perf-profile.children.cycles-pp.wake_up_new_task
      0.19 ±  8%      +0.3        0.48 ±  6%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.56 ±  3%      +0.3        0.88        perf-profile.children.cycles-pp.remove_vma
      0.42 ±  3%      +0.3        0.74 ±  4%  perf-profile.children.cycles-pp.osq_unlock
      0.59 ±  3%      +0.3        0.92        perf-profile.children.cycles-pp.release_task
      1.10 ±  2%      +0.3        1.43        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.14 ±  2%      +0.3        1.47        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.63 ±  4%      +0.3        0.97        perf-profile.children.cycles-pp.wait_task_zombie
      0.65 ±  8%      +0.3        0.99 ±  4%  perf-profile.children.cycles-pp.load_balance
      0.66 ±  2%      +0.4        1.02        perf-profile.children.cycles-pp.rcu_core
      0.64 ±  3%      +0.4        1.00        perf-profile.children.cycles-pp.rcu_do_batch
      0.71 ±  8%      +0.4        1.08 ±  4%  perf-profile.children.cycles-pp.newidle_balance
      0.46 ±  4%      +0.4        0.84 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.54 ±  2%      +0.4        0.92 ±  2%  perf-profile.children.cycles-pp.free_swap_cache
      0.56 ±  2%      +0.4        0.95 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.78 ±  8%      +0.4        1.17 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.74 ±  2%      +0.4        1.13        perf-profile.children.cycles-pp.__do_softirq
      0.80            +0.4        1.22        perf-profile.children.cycles-pp.__vm_area_free
      0.18 ±  6%      +0.4        0.60 ±  2%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.65 ±  6%      +0.4        1.08 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
      0.94 ±  4%      +0.4        1.39 ±  2%  perf-profile.children.cycles-pp.schedule
      0.68 ±  6%      +0.4        1.12 ±  6%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.77 ±  8%      +0.5        1.27        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      2.52            +0.5        3.02 ±  3%  perf-profile.children.cycles-pp.page_remove_rmap
      1.60            +0.5        2.13        perf-profile.children.cycles-pp.mas_store
      1.78            +0.6        2.35 ±  2%  perf-profile.children.cycles-pp.__slab_free
      1.36            +0.6        1.97 ±  2%  perf-profile.children.cycles-pp.copy_present_pte
      1.51 ±  5%      +0.6        2.14 ±  2%  perf-profile.children.cycles-pp.__schedule
      1.07 ±  3%      +0.8        1.84        perf-profile.children.cycles-pp.mod_objcg_state
      2.25 ±  4%      +0.8        3.01 ±  5%  perf-profile.children.cycles-pp.copy_pte_range
      0.81 ±  5%      +0.9        1.68 ±  2%  perf-profile.children.cycles-pp.__put_anon_vma
      1.50 ±  2%      +0.9        2.37        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      2.66 ±  3%      +0.9        3.54 ±  4%  perf-profile.children.cycles-pp.copy_p4d_range
      2.80 ±  3%      +0.9        3.74 ±  4%  perf-profile.children.cycles-pp.copy_page_range
      1.66 ±  2%      +1.0        2.61        perf-profile.children.cycles-pp.kmem_cache_free
      0.51 ±  9%      +1.1        1.58 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.10 ±  2%      +1.1        5.24 ±  4%  perf-profile.children.cycles-pp.next_uptodate_folio
      1.64 ±  2%      +1.2        2.78        perf-profile.children.cycles-pp.do_wait
      1.67 ±  2%      +1.2        2.84        perf-profile.children.cycles-pp.kernel_wait4
      1.68 ±  2%      +1.2        2.84        perf-profile.children.cycles-pp.__do_sys_wait4
      1.75 ±  2%      +1.2        2.96        perf-profile.children.cycles-pp.wait4
      2.04            +1.2        3.26        perf-profile.children.cycles-pp.vm_area_dup
      1.63 ±  4%      +1.2        2.86 ±  3%  perf-profile.children.cycles-pp._compound_head
      1.40 ±  2%      +1.3        2.67 ±  4%  perf-profile.children.cycles-pp.unlink_file_vma
      2.33 ±  3%      +1.4        3.74        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      2.83 ±  2%      +1.6        4.39        perf-profile.children.cycles-pp.kmem_cache_alloc
      2.78 ±  2%      +1.6        4.41        perf-profile.children.cycles-pp.up_write
      2.42 ±  2%      +2.0        4.40 ±  3%  perf-profile.children.cycles-pp.release_pages
      2.96 ±  2%      +2.4        5.33 ±  3%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      3.01 ±  2%      +2.4        5.39 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
      5.80            +2.6        8.39 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
      5.92            +2.7        8.58 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
      6.09            +2.7        8.84 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      6.50            +2.9        9.36        perf-profile.children.cycles-pp.unmap_vmas
      1.78 ±  6%      +2.9        4.70        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      5.21 ±  5%      +5.5       10.75        perf-profile.children.cycles-pp.unlink_anon_vmas
      5.51 ±  4%      +5.6       11.06        perf-profile.children.cycles-pp.anon_vma_clone
      2.48 ±  7%      +6.7        9.20        perf-profile.children.cycles-pp.osq_lock
      7.98 ±  3%      +7.5       15.43        perf-profile.children.cycles-pp.free_pgtables
      8.51 ±  4%      +9.8       18.35        perf-profile.children.cycles-pp.anon_vma_fork
      4.92 ±  5%     +10.2       15.15        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      5.16 ±  5%     +10.6       15.78        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      7.75 ±  4%     +11.8       19.51        perf-profile.children.cycles-pp.down_write
     20.15 ±  2%     +14.0       34.12        perf-profile.children.cycles-pp.exit_mmap
     20.20 ±  2%     +14.0       34.19        perf-profile.children.cycles-pp.__mmput
     20.24 ±  2%     +14.0       34.24        perf-profile.children.cycles-pp.exit_mm
     25.74           +14.3       40.08        perf-profile.children.cycles-pp.__libc_fork
     21.83 ±  2%     +14.8       36.61        perf-profile.children.cycles-pp.do_group_exit
     21.83 ±  2%     +14.8       36.61        perf-profile.children.cycles-pp.do_exit
     22.02 ±  2%     +14.8       36.83        perf-profile.children.cycles-pp.get_signal
     19.43 ±  2%     +14.8       34.27        perf-profile.children.cycles-pp.dup_mmap
     22.22 ±  2%     +14.9       37.08        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     22.24 ±  2%     +14.9       37.09        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     22.26 ±  2%     +14.9       37.12        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
     22.30 ±  2%     +14.9       37.19        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     19.97 ±  2%     +15.1       35.08        perf-profile.children.cycles-pp.dup_mm
     28.86 ±  2%     +15.5       44.36        perf-profile.children.cycles-pp.do_syscall_64
     28.89 ±  2%     +15.5       44.40        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     21.35 ±  2%     +15.8       37.14        perf-profile.children.cycles-pp.copy_process
     21.89 ±  2%     +16.1       37.96        perf-profile.children.cycles-pp.__do_sys_clone
     21.88 ±  2%     +16.1       37.96        perf-profile.children.cycles-pp.kernel_clone
     37.55 ±  3%     -35.3        2.25 ±  3%  perf-profile.self.cycles-pp.filemap_map_pages
      0.89 ±  3%      -0.1        0.78 ±  4%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.12 ±  7%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.mast_fill_bnode
      0.07 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.do_wp_page
      0.10            +0.0        0.11        perf-profile.self.cycles-pp.do_user_addr_fault
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.mas_split
      0.05 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.__d_lookup_rcu
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.__perf_sw_event
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mas_walk
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.error_entry
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.copy_process
      0.08 ±  8%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.handle_mm_fault
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.mas_push_data
      0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.lockref_put_return
      0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__sigsetjmp@plt
      0.07 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.mas_mab_cp
      0.06 ±  8%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.mm_init
      0.04 ± 44%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.dup_fd
      0.06 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.stress_get_setting
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__tlb_remove_page_size
      0.07 ± 10%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.refcount_dec_not_one
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.prepare_creds
      0.06 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.mas_pop_node
      0.11 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.03 ± 70%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__reclaim_stacks
      0.08 ±  4%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.07            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.08 ±  8%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map
      0.08 ±  7%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mas_wr_walk
      0.07            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_wr_append
      0.07 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.mas_find
      0.06 ±  7%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.remove_vma
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp._find_next_bit
      0.09 ±  7%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.copy_p4d_range
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.update_curr
      0.10 ±  6%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.cpu_util
      0.08 ± 12%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp._atomic_dec_and_lock_irqsave
      0.05 ±  7%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.exit_mmap
      0.04 ± 44%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__put_user_4
      0.11 ±  7%      +0.0        0.15        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.07 ±  7%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.pcpu_alloc
      0.06 ±  9%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.28 ±  3%      +0.0        0.32 ±  2%  perf-profile.self.cycles-pp.memset_orig
      0.10 ± 30%      +0.0        0.15 ± 22%  perf-profile.self.cycles-pp.stress_mwc_reseed
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.strlen@plt
      0.28 ±  3%      +0.0        0.33 ±  4%  perf-profile.self.cycles-pp.unmap_single_vma
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mas_wr_bnode
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__sigsetjmp
      0.13 ±  5%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.mab_mas_cp
      0.08 ±  8%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.put_cred_rcu
      0.12 ±  3%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.copy_page_range
      0.10            +0.0        0.15        perf-profile.self.cycles-pp.mas_store
      0.08 ±  5%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.zap_pmd_range
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.d_alloc_parallel
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.filp_flush
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp._raw_write_lock_irq
      0.00            +0.1        0.05        perf-profile.self.cycles-pp._find_next_and_bit
      0.10 ±  5%      +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.vm_normal_page
      0.02 ± 99%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.nr_running
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp._copy_from_user
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.mas_ascend
      0.13 ±  5%      +0.1        0.19 ± 11%  perf-profile.self.cycles-pp.memcg_account_kmem
      0.07 ±  7%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.free_pgtables
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__init_rwsem
      0.11 ±  4%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.10            +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.03 ± 70%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.11 ±  6%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__radix_tree_lookup
      0.13            +0.1        0.19        perf-profile.self.cycles-pp.mas_update_gap
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp._find_next_or_bit
      0.20 ±  2%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__memcpy
      0.14 ±  5%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.04 ± 71%      +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.____machine__findnew_thread
      0.16            +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.___slab_alloc
      0.13 ±  7%      +0.1        0.20 ±  8%  perf-profile.self.cycles-pp.stress_bad_altstack
      0.01 ±223%      +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.__free_one_page
      0.27 ±  2%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07            +0.1        0.14        perf-profile.self.cycles-pp.queued_read_lock_slowpath
      0.19 ±  3%      +0.1        0.26 ±  4%  perf-profile.self.cycles-pp.down_read_trylock
      0.14 ±  3%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.06 ±  7%      +0.1        0.14 ±  7%  perf-profile.self.cycles-pp.mark_page_accessed
      0.14 ±  4%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.unmap_page_range
      0.13 ±  2%      +0.1        0.21        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.17 ±  4%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.__libc_fork
      0.17 ±  4%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.06 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__vm_area_free
      0.15 ±  3%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.20 ±  5%      +0.1        0.28 ±  6%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.19 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.refill_obj_stock
      0.14 ±  3%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.20 ±  5%      +0.1        0.30        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.23 ±  5%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.mtree_range_walk
      0.40 ±  2%      +0.1        0.51 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.18 ±  4%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.11 ±  5%      +0.1        0.23 ±  3%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.14 ±  3%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.27 ±  2%      +0.1        0.39 ±  4%  perf-profile.self.cycles-pp.set_pte_range
      0.21 ±  2%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.acct_collect
      0.29 ±  8%      +0.1        0.42 ±  6%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.30 ±  2%      +0.1        0.43        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.30 ±  7%      +0.1        0.43 ±  8%  perf-profile.self.cycles-pp.clear_page_erms
      0.24            +0.1        0.38        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.28 ±  4%      +0.2        0.43        perf-profile.self.cycles-pp.__cond_resched
      0.19 ±  6%      +0.2        0.34 ±  4%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.17 ±  2%      +0.2        0.32 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.39 ±  2%      +0.2        0.55 ±  2%  perf-profile.self.cycles-pp.sync_regs
      0.18 ±  5%      +0.2        0.35 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.28 ±  5%      +0.2        0.47 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.52 ±  5%      +0.2        0.72 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.24 ±  6%      +0.2        0.44 ±  5%  perf-profile.self.cycles-pp.__rb_erase_color
      0.22 ±  4%      +0.2        0.42 ±  2%  perf-profile.self.cycles-pp.__put_anon_vma
      0.40            +0.2        0.62        perf-profile.self.cycles-pp.mas_next_slot
      0.32 ±  2%      +0.2        0.54        perf-profile.self.cycles-pp.anon_vma_fork
      0.26 ±  8%      +0.3        0.53 ±  7%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.47 ±  3%      +0.3        0.75        perf-profile.self.cycles-pp.fput
      0.57 ±  2%      +0.3        0.88        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.42 ±  4%      +0.3        0.73 ±  4%  perf-profile.self.cycles-pp.osq_unlock
      0.90            +0.3        1.22 ±  4%  perf-profile.self.cycles-pp.copy_present_pte
      0.53 ±  2%      +0.3        0.87        perf-profile.self.cycles-pp.vm_area_dup
      0.51 ±  2%      +0.4        0.87 ±  3%  perf-profile.self.cycles-pp.free_swap_cache
      0.42 ±  2%      +0.4        0.78        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.24 ±  3%      +0.4        0.61        perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.81            +0.4        1.21        perf-profile.self.cycles-pp.kmem_cache_free
      2.44            +0.5        2.91 ±  3%  perf-profile.self.cycles-pp.page_remove_rmap
      0.74 ±  8%      +0.5        1.22        perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      1.08            +0.5        1.57        perf-profile.self.cycles-pp.dup_mmap
      1.02 ±  2%      +0.5        1.55        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.55 ±  3%      +0.5        1.08 ±  3%  perf-profile.self.cycles-pp.anon_vma_clone
      1.75            +0.5        2.30        perf-profile.self.cycles-pp.__slab_free
      0.88 ±  4%      +0.6        1.49        perf-profile.self.cycles-pp.mod_objcg_state
      2.38            +1.0        3.40        perf-profile.self.cycles-pp.down_write
      3.90            +1.1        4.96 ±  4%  perf-profile.self.cycles-pp.next_uptodate_folio
      1.57 ±  7%      +1.1        2.64 ±  2%  perf-profile.self.cycles-pp.zap_pte_range
      0.50 ±  9%      +1.1        1.57 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.53 ±  4%      +1.2        2.70 ±  3%  perf-profile.self.cycles-pp._compound_head
      2.30 ±  3%      +1.4        3.68        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      2.73 ±  2%      +1.6        4.29        perf-profile.self.cycles-pp.up_write
      2.04 ±  2%      +1.6        3.64 ±  3%  perf-profile.self.cycles-pp.release_pages
      1.74 ±  6%      +2.9        4.61        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.45 ±  7%      +6.6        9.07        perf-profile.self.cycles-pp.osq_lock



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/test/testcase/testtime:
  scheduler/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/4194304/lkp-icl-2sp8/zombie/stress-ng/60s

commit: 
  578d7699e5 ("proc: nommu: /proc/<pid>/maps: release mmap read lock")
  c8be038067 ("filemap: add filemap_map_order0_folio() to handle order0 folio")

578d7699e5c2add8 c8be03806738c86521dbf1e0503 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     79172           +13.2%      89660        vmstat.system.cs
      0.49 ±  4%      +0.0        0.53 ±  5%  mpstat.cpu.all.soft%
      2.65 ±  2%      +0.3        2.98        mpstat.cpu.all.usr%
   1656298           +18.8%    1967782        sched_debug.cpu.curr->pid.max
     43853           +11.6%      48941        sched_debug.cpu.nr_switches.avg
     28648 ±  5%     +14.6%      32841 ±  4%  sched_debug.cpu.nr_switches.min
   2865731 ±  6%     +21.4%    3479778 ±  2%  meminfo.AnonPages
   3516783 ±  5%     +20.2%    4225644 ±  2%  meminfo.Inactive
   3516613 ±  5%     +20.2%    4225471 ±  2%  meminfo.Inactive(anon)
    713478           +13.3%     808519        meminfo.Shmem
   2688071 ±  5%     +17.4%    3154724 ±  3%  numa-meminfo.node1.AnonPages
   9981294 ±  7%     +23.7%   12350291 ±  5%  numa-meminfo.node1.AnonPages.max
   3189843 ±  6%     +14.7%    3659429 ±  3%  numa-meminfo.node1.Inactive
   3189730 ±  6%     +14.7%    3659262 ±  3%  numa-meminfo.node1.Inactive(anon)
  59379234 ±  5%     +18.1%   70108134 ±  2%  numa-numastat.node0.local_node
  59417583 ±  5%     +18.1%   70152682        numa-numastat.node0.numa_hit
  61671621 ±  4%     +16.9%   72121881 ±  2%  numa-numastat.node1.local_node
  61706923 ±  4%     +16.9%   72131435 ±  2%  numa-numastat.node1.numa_hit
      0.11 ±  3%     +20.9%       0.14 ±  3%  turbostat.IPC
      4.32 ± 53%     +19.0       23.30 ± 12%  turbostat.PKG_%
    389.85            +1.5%     395.86        turbostat.PkgWatt
     97.34            +9.1%     106.23        turbostat.RAMWatt
  59442833 ±  5%     +18.1%   70183130 ±  2%  numa-vmstat.node0.numa_hit
  59404485 ±  5%     +18.1%   70138582 ±  2%  numa-vmstat.node0.numa_local
    668445 ±  5%     +19.3%     797389 ±  3%  numa-vmstat.node1.nr_anon_pages
    793627 ±  6%     +16.4%     923828 ±  3%  numa-vmstat.node1.nr_inactive_anon
    793626 ±  6%     +16.4%     923826 ±  3%  numa-vmstat.node1.nr_zone_inactive_anon
  61674178 ±  4%     +17.0%   72158008 ±  2%  numa-vmstat.node1.numa_hit
  61638876 ±  4%     +17.1%   72148454 ±  2%  numa-vmstat.node1.numa_local
    874342            +4.3%     912094        stress-ng.time.involuntary_context_switches
    142434 ± 14%     -71.1%      41221 ± 10%  stress-ng.time.major_page_faults
 1.399e+08 ±  2%     +20.1%   1.68e+08 ±  2%  stress-ng.time.minor_page_faults
      2946           -10.0%       2652        stress-ng.time.system_time
    755.97 ±  4%     +35.3%       1022        stress-ng.time.user_time
   3467734           +16.3%    4032971        stress-ng.time.voluntary_context_switches
   3306569           +19.1%    3938238        stress-ng.zombie.ops
     54172           +19.1%      64528        stress-ng.zombie.ops_per_sec
    720667 ±  6%     +18.3%     852660 ±  2%  proc-vmstat.nr_anon_pages
    865025            +2.6%     887842        proc-vmstat.nr_file_pages
    883490 ±  5%     +17.5%    1038376 ±  2%  proc-vmstat.nr_inactive_anon
     21386            -2.7%      20802        proc-vmstat.nr_kernel_stack
    117351 ±  3%      +5.3%     123532        proc-vmstat.nr_mapped
    178479           +12.8%     201301        proc-vmstat.nr_shmem
   2246356            +2.2%    2295342        proc-vmstat.nr_slab_unreclaimable
    883491 ±  5%     +17.5%    1038376 ±  2%  proc-vmstat.nr_zone_inactive_anon
    100207 ±  9%     +13.8%     114069 ±  9%  proc-vmstat.numa_hint_faults
 1.211e+08 ±  4%     +17.5%  1.423e+08 ±  2%  proc-vmstat.numa_hit
  1.21e+08 ±  4%     +17.5%  1.422e+08 ±  2%  proc-vmstat.numa_local
 1.314e+08 ±  3%     +17.6%  1.545e+08 ±  2%  proc-vmstat.pgalloc_normal
 1.431e+08 ±  2%     +19.9%  1.716e+08 ±  2%  proc-vmstat.pgfault
 1.283e+08 ±  4%     +17.6%  1.508e+08 ±  2%  proc-vmstat.pgfree
  12293471 ±  8%     +23.3%   15163310        proc-vmstat.pgreuse
 1.474e+10 ±  2%     +22.9%  1.812e+10        perf-stat.i.branch-instructions
 1.352e+08 ±  2%     +21.1%  1.637e+08        perf-stat.i.branch-misses
     33.32            -2.5       30.81        perf-stat.i.cache-miss-rate%
 3.996e+08 ±  4%     +17.3%  4.689e+08        perf-stat.i.cache-misses
 1.167e+09 ±  3%     +26.8%   1.48e+09        perf-stat.i.cache-references
     83846           +13.2%      94885        perf-stat.i.context-switches
      2.94           -17.8%       2.42        perf-stat.i.cpi
      1706           +64.3%       2803 ±  5%  perf-stat.i.cpu-migrations
 1.841e+10           +22.3%  2.252e+10        perf-stat.i.dTLB-loads
  14804513 ±  3%     +23.1%   18218749        perf-stat.i.dTLB-store-misses
  9.47e+09           +18.9%  1.126e+10        perf-stat.i.dTLB-stores
  7.21e+10           +22.1%  8.803e+10        perf-stat.i.instructions
      0.36 ±  3%     +18.1%       0.42        perf-stat.i.ipc
      2302 ± 14%     -71.4%     657.51 ± 10%  perf-stat.i.major-faults
    685.64           +21.9%     835.68        perf-stat.i.metric.M/sec
   2247174 ±  2%     +21.1%    2720809 ±  2%  perf-stat.i.minor-faults
  90127478           +18.7%   1.07e+08        perf-stat.i.node-load-misses
  19946667 ±  3%      +7.5%   21438414        perf-stat.i.node-loads
     33.59 ±  2%      +9.2       42.74        perf-stat.i.node-store-miss-rate%
  51544020 ±  2%     +17.4%   60489439        perf-stat.i.node-store-misses
 1.007e+08 ±  3%     -21.9%   78669033        perf-stat.i.node-stores
   2249477 ±  2%     +21.0%    2721467 ±  2%  perf-stat.i.page-faults
      5.56 ±  2%      -4.0%       5.33        perf-stat.overall.MPKI
     34.30            -2.6       31.74        perf-stat.overall.cache-miss-rate%
      3.00           -17.9%       2.47        perf-stat.overall.cpi
    540.46 ±  3%     -14.5%     462.25        perf-stat.overall.cycles-between-cache-misses
      0.33           +21.7%       0.41        perf-stat.overall.ipc
     81.23            +1.4       82.62        perf-stat.overall.node-load-miss-rate%
     33.80 ±  2%      +9.6       43.36        perf-stat.overall.node-store-miss-rate%
 1.446e+10           +22.3%  1.768e+10        perf-stat.ps.branch-instructions
 1.311e+08 ±  2%     +20.7%  1.582e+08        perf-stat.ps.branch-misses
  3.93e+08 ±  3%     +16.6%  4.581e+08        perf-stat.ps.cache-misses
 1.146e+09 ±  3%     +26.0%  1.443e+09        perf-stat.ps.cache-references
     81043           +12.9%      91527        perf-stat.ps.context-switches
      1648           +63.1%       2687 ±  5%  perf-stat.ps.cpu-migrations
 1.806e+10           +21.7%  2.198e+10        perf-stat.ps.dTLB-loads
  14615584 ±  3%     +22.5%   17900348        perf-stat.ps.dTLB-store-misses
 9.306e+09           +18.4%  1.102e+10        perf-stat.ps.dTLB-stores
 7.067e+10           +21.5%  8.587e+10        perf-stat.ps.instructions
      2207 ± 14%     -71.0%     640.72 ± 10%  perf-stat.ps.major-faults
   2204863 ±  2%     +20.6%    2658986 ±  2%  perf-stat.ps.minor-faults
  88557359           +18.0%  1.045e+08        perf-stat.ps.node-load-misses
  20464857 ±  3%      +7.5%   21989844        perf-stat.ps.node-loads
  50412569 ±  2%     +16.6%   58803020        perf-stat.ps.node-store-misses
  98758235 ±  3%     -22.2%   76834392        perf-stat.ps.node-stores
   2207071 ±  2%     +20.5%    2659627 ±  2%  perf-stat.ps.page-faults
 4.532e+12           +21.2%  5.494e+12        perf-stat.total.instructions
      1.07 ±  4%     -19.3%       0.87 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      2.84 ±  7%     -25.7%       2.11 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.do_read_fault.do_fault
      2.60           -18.9%       2.11 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      2.28 ± 18%     -30.2%       1.59 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      2.75 ±  2%     -20.2%       2.20        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      2.71 ±  5%     -19.2%       2.19 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      2.66           -20.6%       2.11 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      2.62 ±  2%     -17.2%       2.17 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      2.66 ±  2%     -16.9%       2.21 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      2.15 ±  4%      -9.0%       1.96 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      2.64 ±  4%     -17.4%       2.19 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      0.05 ±  6%     -17.3%       0.04 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.92 ±  9%     -20.4%       2.32 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.59 ±  3%     -16.8%       2.16 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      2.60 ±  5%     -15.9%       2.19 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      2.66           -20.3%       2.12 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      2.46           -16.3%       2.06        perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2.65 ±  2%     -23.4%       2.03 ±  2%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      2.07 ±  3%     -17.1%       1.72 ±  5%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2.64 ±  4%     -22.7%       2.04 ±  2%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      2.06 ±  4%     -34.8%       1.34 ±  6%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      1.93 ±  4%     -35.6%       1.24 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      2.17 ±  3%     -35.0%       1.41 ±  9%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.11 ± 28%     -53.3%       0.05 ± 51%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.04 ±  4%     +15.3%       0.05 ±  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.28 ± 26%     -39.2%       5.64 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.copy_pte_range
     17.33 ± 21%     -26.6%      12.72 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     14.22 ± 38%     -39.4%       8.62 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
     14.23 ± 12%     -21.7%      11.15 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
     15.06 ± 17%     -23.7%      11.48 ±  7%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
     10.89 ± 13%     -26.6%       8.00 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
     10.07 ± 21%     -25.0%       7.56 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     27.84 ± 10%     -21.1%      21.97 ±  9%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     15.52 ± 25%     -32.2%      10.53 ± 14%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
     17.10 ± 23%     -30.3%      11.92 ± 27%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      1.80           -17.2%       1.49        perf-sched.total_sch_delay.average.ms
     29.29 ± 11%     -20.7%      23.23 ± 12%  perf-sched.total_sch_delay.max.ms
      4.89           -16.6%       4.08        perf-sched.total_wait_and_delay.average.ms
    443986           +12.8%     500799        perf-sched.total_wait_and_delay.count.ms
      3.09           -16.3%       2.59        perf-sched.total_wait_time.average.ms
      2.82 ±  2%     -22.7%       2.18 ±  2%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      4.62 ±  3%     -34.8%       3.01        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      3.00 ±  2%     -75.3%       0.74 ±141%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      4.58 ±  2%     -34.7%       2.99        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      7.55 ±  4%     -12.7%       6.59 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.87 ±  3%     -24.0%       2.18 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      2.87           -20.6%       2.28        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2.77 ±  2%     -23.9%       2.11        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      4.45 ±  2%     -33.6%       2.95        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.64          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     19.12 ±  3%     -15.8%      16.09 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3249 ±  2%     +13.5%       3689 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      4669 ±  4%     +36.7%       6383        perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      4886 ±  4%     +40.3%       6856 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
     26.17 ± 46%     +39.5%      36.50 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
    558.67 ± 10%     +55.3%     867.33 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3998 ±  3%     +22.8%       4910        perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    274560           +19.6%     328273        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     15437 ±  6%     -59.5%       6249 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     25289           +23.2%      31152        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     10132 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     31571 ±  2%     +19.0%      37576        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     21.03 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      2.49 ±  8%     -42.9%       1.42 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      4.71 ± 19%     -47.3%       2.48 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc.mm_init
      4.46 ±  6%     -31.9%       3.04 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pmd_alloc.copy_p4d_range.copy_page_range
      4.74 ±  8%     -41.7%       2.76 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pud_alloc.copy_p4d_range.copy_page_range
      4.54 ± 23%     -49.8%       2.28 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.allocate_slab.___slab_alloc.kmem_cache_alloc
      4.32 ± 19%     -45.1%       2.37 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.allocate_slab.___slab_alloc.kmem_cache_alloc_node
      4.69 ±  3%     -39.6%       2.84 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.copy_pte_range
      4.84 ± 20%     -44.0%       2.71 ± 46%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      4.12 ± 17%     -32.5%       2.78 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      4.70 ± 15%     -36.2%       3.00 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      4.56 ±  3%     -35.0%       2.97 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
      3.90 ± 16%     -27.2%       2.84 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      4.37 ± 22%     -33.5%       2.90 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range
      4.08 ± 10%     -38.6%       2.51 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
      0.22 ± 15%     -67.3%       0.07 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      4.60 ± 10%     -28.4%       3.29 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      5.53 ± 29%     -58.6%       2.29 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      4.31 ± 14%     -29.6%       3.03 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      4.51 ±  3%     -33.7%       2.99 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      4.52 ±  3%     -34.5%       2.96        perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      4.03 ± 18%     -30.3%       2.81 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.dentry_kill.dput.proc_invalidate_siblings_dcache.release_task
      0.22 ± 43%     -89.2%       0.02 ± 86%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      2.10 ± 18%     -30.6%       1.45 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      4.49 ±  5%     -35.9%       2.87 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      4.38 ±  3%     -32.8%       2.94        perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      4.54 ±  3%     -35.5%       2.93        perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      4.56 ±  9%     -35.4%       2.95 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.24 ±  4%     -73.1%       0.06 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.25 ± 23%     -64.6%       0.09 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.23 ± 14%     -56.5%       0.10 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.43 ± 57%     -68.8%       0.13 ±138%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      3.02 ± 22%     -26.5%       2.22 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.45 ± 68%     -87.5%       0.06 ±169%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      4.44 ±  8%     -34.4%       2.92 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      2.39 ± 21%     -37.1%       1.50 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      3.70 ± 17%     -43.7%       2.08 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      3.31 ± 20%     -36.0%       2.12 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      4.19 ±  8%     -30.2%       2.92 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      4.50 ±  2%     -35.4%       2.91        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      4.89 ±  6%     -42.1%       2.83 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      4.54 ± 14%     -46.7%       2.42 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      5.31 ± 30%     -55.4%       2.37 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      4.28 ± 16%     -34.0%       2.83 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      4.84 ±  5%     -36.5%       3.07 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      2.95 ± 22%     -43.8%       1.66 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      4.57 ±  6%     -36.9%       2.89 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.18 ± 35%     -89.0%       0.02 ± 85%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      4.54 ± 25%     -43.9%       2.55 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      4.71 ±  2%     -34.9%       3.07 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      4.39 ± 16%     -29.2%       3.11 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      1.08 ± 14%     -36.1%       0.69 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.44 ± 23%     -68.1%       0.14 ± 76%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      2.55 ± 17%     -40.3%       1.52 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
      7.50 ±  4%     -12.7%       6.55 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.27 ± 10%     -64.1%       0.10 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.10 ± 61%     -86.6%       0.01 ±179%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      4.60 ±  5%     -33.3%       3.07 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      2.64 ±  5%     -40.9%       1.56 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.40 ±  5%     -46.5%       0.22 ±  2%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.61 ± 66%     -50.1%       2.80 ± 10%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.12 ± 12%     -35.6%       0.08 ± 10%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      1.69 ± 28%     -84.5%       0.26 ± 74%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.93 ± 14%     -48.7%       0.48 ± 24%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      4.37 ±  2%     -34.4%       2.87 ±  2%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.23 ± 12%     -92.2%       0.02 ± 43%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.53 ± 19%     -22.0%       0.42 ± 11%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      3.74 ±  4%     -44.0%       2.09 ±  2%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      3.73 ±  5%     -43.0%       2.13 ±  2%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      3.97 ±  8%     -37.3%       2.49 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      0.50 ±  6%     -30.6%       0.34 ± 23%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      4.27 ± 11%     -20.2%       3.41 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     19.09 ±  3%     -15.9%      16.06 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.90 ± 14%     -32.7%       0.61 ± 19%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     16.74 ± 18%     -39.5%      10.14 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__pud_alloc.copy_p4d_range.copy_page_range
     17.67 ± 17%     -35.9%      11.33 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range
     20.97 ± 12%     -37.2%      13.16 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
      4.45 ± 41%     -69.6%       1.35 ± 94%  perf-sched.wait_time.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
     25.27 ± 17%     -23.7%      19.27 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
     12.10 ± 26%     -40.2%       7.23 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     15.52 ± 42%     -52.0%       7.45 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
     21.80 ± 23%     -36.1%      13.93 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      4.07 ± 47%     -84.3%       0.64 ±167%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
    180.67 ±204%     -94.3%      10.27 ± 13%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     10.46 ± 46%     -64.5%       3.71 ± 49%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
     13.19 ± 12%     -72.5%       3.63 ± 29%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      7.56 ± 11%     -30.7%       5.24 ± 18%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
     27.62 ±  4%     -23.4        4.21 ±  4%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     27.61 ±  4%     -23.4        4.20 ±  4%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     27.42 ±  4%     -23.3        4.14 ±  4%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     28.95 ±  4%     -23.2        5.78 ±  6%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     15.73 ±  8%     -11.0        4.78 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     16.12 ±  8%     -10.9        5.22 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     16.11 ±  8%     -10.9        5.21 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     16.39 ±  8%     -10.8        5.55 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.39 ±  4%      -1.9        0.46 ± 44%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.shim_waitpid
      2.42 ±  4%      -1.8        0.58 ±  4%  perf-profile.calltrace.cycles-pp.shim_waitpid
      2.61 ±  3%      -1.8        0.86        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
      2.75 ±  2%      -1.7        1.02        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__libc_fork
      2.74 ±  2%      -1.7        1.02        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
      2.94 ±  2%      -1.7        1.25        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__libc_fork
      0.92 ±  9%      -0.4        0.52 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_zombie
      1.00 ±  8%      -0.4        0.62        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_zombie
      1.00 ±  8%      -0.4        0.61        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_zombie
      1.09 ±  9%      -0.4        0.72        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_zombie
      1.12 ±  8%      -0.4        0.74        perf-profile.calltrace.cycles-pp.stress_zombie
      0.59            -0.1        0.54        perf-profile.calltrace.cycles-pp.dup_userfaultfd.dup_mmap.dup_mm.copy_process.kernel_clone
      0.52 ±  3%      +0.1        0.58        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.52 ±  2%      +0.1        0.59        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.53 ±  2%      +0.1        0.60        perf-profile.calltrace.cycles-pp.read
      0.52 ±  2%      +0.1        0.59        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.79            +0.1        0.88        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store.dup_mmap.dup_mm
      0.73 ±  5%      +0.1        0.82 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.find_unlink_vmap_area.remove_vm_area.vfree
      0.75 ±  5%      +0.1        0.84 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.find_unlink_vmap_area.remove_vm_area.vfree.delayed_vfree_work
      0.84            +0.1        0.94        perf-profile.calltrace.cycles-pp.__slab_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.90            +0.1        1.00        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store.dup_mmap.dup_mm.copy_process
      0.53            +0.1        0.64        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store.dup_mmap.dup_mm.copy_process
      0.53            +0.1        0.64 ±  5%  perf-profile.calltrace.cycles-pp.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.67            +0.1        0.78        perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
      1.04 ±  3%      +0.1        1.14        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.80 ±  5%      +0.1        0.91 ±  5%  perf-profile.calltrace.cycles-pp.find_unlink_vmap_area.remove_vm_area.vfree.delayed_vfree_work.process_one_work
      0.56            +0.1        0.67        perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      0.60            +0.1        0.72 ±  4%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.58            +0.1        0.70 ±  5%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.54            +0.1        0.66        perf-profile.calltrace.cycles-pp.fput.remove_vma.exit_mmap.__mmput.exit_mm
      0.73 ±  2%      +0.1        0.84        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.60            +0.1        0.72 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.60            +0.1        0.72 ±  5%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.60            +0.1        0.72 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.94 ±  4%      +0.1        1.06 ±  4%  perf-profile.calltrace.cycles-pp.remove_vm_area.vfree.delayed_vfree_work.process_one_work.worker_thread
      0.62            +0.1        0.75 ±  4%  perf-profile.calltrace.cycles-pp.wait4
      0.54            +0.1        0.67        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.65            +0.1        0.78        perf-profile.calltrace.cycles-pp.remove_vma.exit_mmap.__mmput.exit_mm.do_exit
      1.03 ±  4%      +0.1        1.17 ±  4%  perf-profile.calltrace.cycles-pp.delayed_vfree_work.process_one_work.worker_thread.kthread.ret_from_fork
      1.02 ±  4%      +0.1        1.16 ±  4%  perf-profile.calltrace.cycles-pp.vfree.delayed_vfree_work.process_one_work.worker_thread.kthread
      1.10 ±  4%      +0.1        1.25 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.66            +0.1        0.80        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.08 ±  4%      +0.1        1.22 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.43 ± 44%      +0.1        0.58        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.62 ±  2%      +0.2        0.77        perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.54 ±  4%      +0.2        0.70 ±  6%  perf-profile.calltrace.cycles-pp._compound_head.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range
      0.67 ±  2%      +0.2        0.83 ±  2%  perf-profile.calltrace.cycles-pp.schedule_tail.ret_from_fork.ret_from_fork_asm.__libc_fork
      0.69 ±  2%      +0.2        0.85 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm.__libc_fork
      0.73 ±  2%      +0.2        0.89 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm.__libc_fork
      0.42 ± 44%      +0.2        0.61 ±  5%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4
      1.18 ±  2%      +0.2        1.36        perf-profile.calltrace.cycles-pp.up_write.dup_mmap.dup_mm.copy_process.kernel_clone
      0.60            +0.2        0.79 ±  2%  perf-profile.calltrace.cycles-pp.free_swap_cache.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap
      0.95            +0.2        1.14        perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.__mmput.exit_mm.do_exit
      0.61            +0.2        0.80 ±  2%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      1.28 ±  2%      +0.2        1.48        perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exit_mm
      1.57            +0.2        1.80        perf-profile.calltrace.cycles-pp.mas_store.dup_mmap.dup_mm.copy_process.kernel_clone
      1.43 ±  3%      +0.2        1.66 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.43 ±  3%      +0.2        1.66 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.43 ±  3%      +0.2        1.66 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.00            +0.2        1.24 ±  2%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.54 ±  3%      +0.3        0.80 ±  3%  perf-profile.calltrace.cycles-pp.up_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      2.09            +0.3        2.38        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm.copy_process
      1.65 ±  4%      +0.3        1.94 ±  2%  perf-profile.calltrace.cycles-pp.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      2.82 ±  5%      +0.3        3.14 ±  2%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      1.05 ±  2%      +0.4        1.40 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
      1.07 ±  2%      +0.4        1.43 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.34 ± 70%      +0.4        0.72 ±  2%  perf-profile.calltrace.cycles-pp.up_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.17 ±141%      +0.4        0.55        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      3.44 ±  5%      +0.4        3.83 ±  2%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      0.17 ±141%      +0.4        0.56        perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.95 ±  2%      +0.4        2.35 ±  4%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.24 ±  2%      +0.4        1.65 ±  2%  perf-profile.calltrace.cycles-pp.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      3.59 ±  4%      +0.4        4.02 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      1.31 ±  2%      +0.4        1.74 ±  2%  perf-profile.calltrace.cycles-pp.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process
      1.54 ±  2%      +0.4        1.98 ±  2%  perf-profile.calltrace.cycles-pp.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone
      0.67 ±  7%      +0.4        1.11 ±  6%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap
      1.99            +0.5        2.44 ±  2%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      1.40 ±  2%      +0.5        1.85 ±  4%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.71            +0.5        2.16 ±  2%  perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      2.68 ±  2%      +0.5        3.17        perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      0.77 ±  2%      +0.5        1.27        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.95 ±  2%      +0.5        1.46        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.08 ±223%      +0.5        0.60        perf-profile.calltrace.cycles-pp.kmem_cache_free.exit_mmap.__mmput.exit_mm.do_exit
      0.63 ±  8%      +0.5        1.16 ±  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.09 ±223%      +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.finish_task_switch.schedule_tail.ret_from_fork.ret_from_fork_asm.__libc_fork
      0.08 ±223%      +0.6        0.64        perf-profile.calltrace.cycles-pp.vma_interval_tree_insert_after.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.6        0.59 ±  2%  perf-profile.calltrace.cycles-pp.__mmdrop.finish_task_switch.schedule_tail.ret_from_fork.ret_from_fork_asm
      1.21 ±  6%      +0.6        1.82 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
      0.00            +0.6        0.65 ±  2%  perf-profile.calltrace.cycles-pp.up_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.19 ±  2%      +0.7        1.85        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      1.34 ±  5%      +0.7        2.00 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
      1.08 ±  7%      +0.7        1.79 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
      1.19 ±  6%      +0.8        1.95 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
      2.12 ±  4%      +0.8        2.88 ±  3%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      0.61 ±  7%      +0.9        1.48 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__put_anon_vma
      2.73 ±  2%      +0.9        3.62        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      1.78 ±  5%      +0.9        2.68 ±  4%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      3.38            +0.9        4.30        perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      2.91 ±  3%      +1.0        3.92 ±  2%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      6.19            +1.0        7.20        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      3.39            +1.1        4.47        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      3.44            +1.1        4.52        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      6.50            +1.1        7.59        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      0.96 ±  6%      +1.1        2.07 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__put_anon_vma.unlink_anon_vmas
      0.99 ±  6%      +1.1        2.11 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.__put_anon_vma.unlink_anon_vmas.free_pgtables
      6.68            +1.1        7.82        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.02 ±  5%      +1.1        2.16 ±  4%  perf-profile.calltrace.cycles-pp.down_write.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      7.10            +1.2        8.30        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      1.36 ±  4%      +1.4        2.76 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      1.86 ±  4%      +1.5        3.31 ±  3%  perf-profile.calltrace.cycles-pp.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      1.33 ±  4%      +1.7        3.00 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      2.02 ±  4%      +1.8        3.80 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      2.56 ±  3%      +2.0        4.55 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
      2.66 ±  3%      +2.0        4.69 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      2.96 ±  3%      +2.2        5.12 ±  2%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      2.33 ±  3%      +2.3        4.60 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables
      2.42 ±  3%      +2.3        4.74 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      2.78 ±  3%      +2.4        5.22 ±  3%  perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      3.49 ±  3%      +2.5        6.02 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
      3.59 ±  3%      +2.6        6.17 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
      3.76 ±  3%      +2.6        6.36 ±  2%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
      8.76 ±  2%      +3.9       12.66        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      8.78 ±  2%      +5.0       13.76 ±  2%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
     13.65 ±  2%      +6.2       19.88        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
     14.05 ±  2%      +7.0       21.09        perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
     36.28 ±  2%      +8.9       45.15        perf-profile.calltrace.cycles-pp.__libc_fork
     27.32            +9.0       36.36        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     27.39            +9.0       36.44        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     27.43            +9.1       36.48        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     28.16            +9.2       37.34        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.16            +9.2       37.34        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.16            +9.2       37.34        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.85            +9.3       38.17        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.85            +9.3       38.17        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     28.28 ±  2%      +9.5       37.79        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     29.04 ±  2%      +9.6       38.69        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     31.88 ±  2%     +10.2       42.12        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.45 ±  2%     +10.4       42.84        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     32.45 ±  2%     +10.4       42.84        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     32.52 ±  2%     +10.4       42.92        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
     32.52 ±  2%     +10.4       42.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     30.36 ±  4%     -21.2        9.19 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
     30.61 ±  4%     -21.1        9.55 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
     28.36 ±  4%     -21.0        7.31 ±  4%  perf-profile.children.cycles-pp.do_fault
     28.35 ±  4%     -21.0        7.30 ±  4%  perf-profile.children.cycles-pp.do_read_fault
     28.18 ±  4%     -21.0        7.16 ±  4%  perf-profile.children.cycles-pp.filemap_map_pages
     31.49 ±  4%     -20.9       10.56 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
     31.53 ±  4%     -20.9       10.61 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
     32.54 ±  4%     -20.7       11.81 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.29 ±  4%      -1.8        0.45 ± 32%  perf-profile.children.cycles-pp.prctl
      2.43 ±  4%      -1.8        0.60 ±  4%  perf-profile.children.cycles-pp.shim_waitpid
      2.24 ±  4%      -1.8        0.43 ±  2%  perf-profile.children.cycles-pp.strchrnul@plt
      2.22 ±  4%      -1.8        0.46 ±  2%  perf-profile.children.cycles-pp.__snprintf_chk
      1.20 ±  8%      -0.4        0.84        perf-profile.children.cycles-pp.stress_zombie
      0.84 ±  9%      -0.3        0.50 ±  3%  perf-profile.children.cycles-pp.stress_set_proc_state
      0.75 ± 15%      -0.3        0.44 ±  4%  perf-profile.children.cycles-pp.__snprintf_chk@plt
      0.80            -0.2        0.65 ±  4%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.53            -0.1        0.47        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.60            -0.1        0.54        perf-profile.children.cycles-pp.dup_userfaultfd
      0.22 ±  5%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.13 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.schedule
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.__do_sys_prctl
      0.19 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.stress_zombie_head_remove
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.ptrace_may_access
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.perf_event_task
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.11 ±  3%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.shuffle_freelist
      0.10 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.mas_wr_walk
      0.07            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.07            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.num_to_str
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mas_next_node
      0.10 ±  3%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.kill_pid_info
      0.08            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.dup_fd
      0.08            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mas_mab_cp
      0.06 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.__radix_tree_lookup
      0.06 ±  6%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp._find_next_or_bit
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.update_curr
      0.09 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.free_pgd_range
      0.08 ±  4%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
      0.07 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.07 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mas_pop_node
      0.12            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.mas_split_final_node
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.perf_event_task_output
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.seq_put_decimal_ull_width
      0.07 ±  6%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__kmalloc_node
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.prepare_creds
      0.14 ±  4%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.get_partial_node
      0.11 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.dequeue_task_fair
      0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__setpgid
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.__getpgid
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.d_walk
      0.15            +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.do_task_dead
      0.09 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.07 ±  5%      +0.0        0.09        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.15 ±  2%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.mab_mas_cp
      0.22 ±  3%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.memset_orig
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__put_user_4
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map
      0.09 ±  6%      +0.0        0.11        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.09 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.copy_creds
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.07 ±  9%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.exit_notify
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.mas_expected_entries
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.kill_something_info
      0.04 ± 45%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__ns_get_path
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__do_sys_setpgid
      0.10 ±  9%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.09 ±  6%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.put_cred_rcu
      0.06 ±  6%      +0.0        0.08        perf-profile.children.cycles-pp.insert_vmap_area
      0.12 ±  3%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.dput
      0.11 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.40 ±  4%      +0.0        0.43        perf-profile.children.cycles-pp.__nptl_set_robust
      0.13            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.11 ±  5%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__put_task_struct
      0.11 ±  4%      +0.0        0.13        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.06 ± 11%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__d_alloc
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.find_vm_area
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.21 ±  2%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.35 ±  2%      +0.0        0.37        perf-profile.children.cycles-pp.__schedule
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.11 ±  5%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.percpu_counter_destroy_many
      0.06 ±  7%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.31 ±  4%      +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.25 ±  3%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__reclaim_stacks
      0.16 ±  3%      +0.0        0.18        perf-profile.children.cycles-pp.kill
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.allocate_slab
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.list_lru_del
      0.38 ±  5%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.30 ±  2%      +0.0        0.32        perf-profile.children.cycles-pp.unmap_single_vma
      0.14 ±  2%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__exit_signal
      0.12 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp._find_next_bit
      0.11 ±  5%      +0.0        0.14 ± 20%  perf-profile.children.cycles-pp.shrink_dentry_list
      0.19            +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.lru_add_drain
      0.19 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.03 ± 70%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.d_lru_del
      0.19            +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.down_read_trylock
      0.10 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__free_one_page
      0.11 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.mas_find
      0.37 ±  4%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.12 ±  5%      +0.0        0.15        perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.10 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.alloc_pid
      0.08 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.mark_page_accessed
      0.19 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.22            +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.mas_walk
      0.16 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.33 ±  4%      +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.16 ±  3%      +0.0        0.20 ± 13%  perf-profile.children.cycles-pp.d_invalidate
      0.16 ±  2%      +0.0        0.19 ± 15%  perf-profile.children.cycles-pp.shrink_dcache_parent
      0.48 ±  4%      +0.0        0.52        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.39 ±  5%      +0.0        0.42        perf-profile.children.cycles-pp.tick_sched_timer
      0.17 ±  2%      +0.0        0.21 ±  6%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.47 ±  4%      +0.0        0.50        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.29 ±  2%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.mas_push_data
      0.44 ±  4%      +0.0        0.48        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.21 ±  5%      +0.0        0.24 ±  6%  perf-profile.children.cycles-pp.open_last_lookups
      0.18 ±  2%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.18 ±  4%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.sched_move_task
      0.19 ±  3%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.lookup_fast
      0.10 ±  4%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.free_percpu
      0.23 ±  2%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.mtree_range_walk
      0.18 ±  4%      +0.0        0.22        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.17            +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.16 ±  3%      +0.0        0.21        perf-profile.children.cycles-pp.vm_normal_page
      0.16 ±  3%      +0.0        0.20 ±  9%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.16 ±  3%      +0.0        0.20 ±  9%  perf-profile.children.cycles-pp.iterate_dir
      0.16 ±  3%      +0.0        0.20 ±  9%  perf-profile.children.cycles-pp.proc_pid_readdir
      0.09 ±  5%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.21 ±  3%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.uncharge_batch
      0.28            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.36 ±  5%      +0.0        0.41 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.getname_flags
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__vm_enough_memory
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mas_ascend
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mast_split_data
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.put_cpu_partial
      0.30 ±  3%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.38 ±  2%      +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.28            +0.1        0.33 ±  8%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.42 ±  2%      +0.1        0.48 ±  5%  perf-profile.children.cycles-pp.open64
      0.26 ±  3%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.14 ±  6%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.28            +0.1        0.34        perf-profile.children.cycles-pp.mas_update_gap
      0.32 ±  2%      +0.1        0.38        perf-profile.children.cycles-pp.acct_collect
      0.24 ±  2%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.refill_obj_stock
      0.53 ±  2%      +0.1        0.60        perf-profile.children.cycles-pp.read
      0.33 ±  2%      +0.1        0.39 ±  3%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.34 ±  2%      +0.1        0.41        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.42            +0.1        0.49        perf-profile.children.cycles-pp._exit
      0.20 ±  7%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.39 ±  5%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.36            +0.1        0.44        perf-profile.children.cycles-pp.mas_wr_append
      0.32 ±  2%      +0.1        0.40        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.40            +0.1        0.48        perf-profile.children.cycles-pp.pcpu_alloc
      0.80            +0.1        0.88        perf-profile.children.cycles-pp.mas_split
      0.39 ±  2%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.sync_regs
      0.24 ±  6%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.free_unref_page
      0.35            +0.1        0.43        perf-profile.children.cycles-pp.find_idlest_group
      0.45 ±  2%      +0.1        0.53 ±  3%  perf-profile.children.cycles-pp.proc_single_show
      0.44 ±  2%      +0.1        0.52 ±  3%  perf-profile.children.cycles-pp.do_task_stat
      0.18 ±  3%      +0.1        0.26 ±  5%  perf-profile.children.cycles-pp.wake_q_add
      0.64            +0.1        0.72        perf-profile.children.cycles-pp.___slab_alloc
      0.38            +0.1        0.47        perf-profile.children.cycles-pp.select_task_rq_fair
      0.38 ±  2%      +0.1        0.46        perf-profile.children.cycles-pp.find_idlest_cpu
      0.32 ±  3%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.92 ±  6%      +0.1        1.01 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.32            +0.1        0.41        perf-profile.children.cycles-pp.smpboot_thread_fn
      0.53            +0.1        0.62 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.30 ±  3%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.20 ±  3%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.39 ±  8%      +0.1        0.49 ±  9%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.70 ±  2%      +0.1        0.80 ±  2%  perf-profile.children.cycles-pp.seq_read
      0.66            +0.1        0.76        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.51            +0.1        0.61 ±  5%  perf-profile.children.cycles-pp.release_task
      0.60 ±  2%      +0.1        0.70 ±  6%  perf-profile.children.cycles-pp.path_openat
      0.90            +0.1        1.01        perf-profile.children.cycles-pp.mas_wr_bnode
      0.60 ±  3%      +0.1        0.71 ±  5%  perf-profile.children.cycles-pp.do_filp_open
      0.55            +0.1        0.66        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.48 ±  4%      +0.1        0.58        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.72 ±  2%      +0.1        0.82 ±  2%  perf-profile.children.cycles-pp.vfs_read
      0.69 ±  2%      +0.1        0.80 ±  2%  perf-profile.children.cycles-pp.seq_read_iter
      0.53            +0.1        0.64 ±  5%  perf-profile.children.cycles-pp.wait_task_zombie
      0.68            +0.1        0.78        perf-profile.children.cycles-pp.mm_init
      0.80 ±  5%      +0.1        0.91 ±  5%  perf-profile.children.cycles-pp.find_unlink_vmap_area
      0.73 ±  3%      +0.1        0.84 ±  2%  perf-profile.children.cycles-pp.ksys_read
      0.67 ±  2%      +0.1        0.78 ±  5%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.66 ±  3%      +0.1        0.78 ±  5%  perf-profile.children.cycles-pp.do_sys_openat2
      0.57            +0.1        0.68        perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.20 ±  3%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.60            +0.1        0.72 ±  4%  perf-profile.children.cycles-pp.kernel_wait4
      0.58            +0.1        0.70 ±  5%  perf-profile.children.cycles-pp.do_wait
      0.56            +0.1        0.68        perf-profile.children.cycles-pp.fput
      0.18 ±  3%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      0.88 ±  3%      +0.1        1.00        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.79            +0.1        0.91        perf-profile.children.cycles-pp.__rb_erase_color
      0.25 ±  3%      +0.1        0.37 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      0.60            +0.1        0.72 ±  5%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.94 ±  4%      +0.1        1.06 ±  4%  perf-profile.children.cycles-pp.remove_vm_area
      0.91 ±  4%      +0.1        1.03        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.62            +0.1        0.75 ±  5%  perf-profile.children.cycles-pp.wait4
      0.54            +0.1        0.67        perf-profile.children.cycles-pp.wake_up_new_task
      0.18 ±  2%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.wake_up_q
      0.51 ±  2%      +0.1        0.64        perf-profile.children.cycles-pp.mas_next_slot
      0.58 ±  2%      +0.1        0.71        perf-profile.children.cycles-pp.__cond_resched
      0.66            +0.1        0.80        perf-profile.children.cycles-pp.remove_vma
      1.03 ±  4%      +0.1        1.17 ±  4%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.24 ±  4%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      1.02 ±  4%      +0.1        1.16 ±  4%  perf-profile.children.cycles-pp.vfree
      1.10 ±  4%      +0.1        1.25 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.61 ±  2%      +0.1        0.76 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      1.08 ±  4%      +0.1        1.22 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.58 ±  2%      +0.1        0.72 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.48 ±  3%      +0.2        0.64        perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.67 ±  2%      +0.2        0.83 ±  2%  perf-profile.children.cycles-pp.schedule_tail
      0.66 ±  3%      +0.2        0.83        perf-profile.children.cycles-pp.rcu_core
      0.64 ±  4%      +0.2        0.81        perf-profile.children.cycles-pp.rcu_do_batch
      0.69 ±  3%      +0.2        0.86        perf-profile.children.cycles-pp.__do_softirq
      2.08            +0.2        2.26        perf-profile.children.cycles-pp.__slab_free
      0.96            +0.2        1.15        perf-profile.children.cycles-pp.__vm_area_free
      0.62            +0.2        0.82 ±  2%  perf-profile.children.cycles-pp.free_swap_cache
      0.64            +0.2        0.84 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.80 ±  2%      +0.2        1.02 ±  4%  perf-profile.children.cycles-pp.osq_unlock
      1.58            +0.2        1.81        perf-profile.children.cycles-pp.mas_store
      1.43 ±  3%      +0.2        1.66 ±  3%  perf-profile.children.cycles-pp.kthread
      1.00            +0.2        1.24        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      1.87 ±  2%      +0.3        2.14        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      1.10 ±  2%      +0.3        1.38        perf-profile.children.cycles-pp.mod_objcg_state
      1.68 ±  4%      +0.3        1.98 ±  2%  perf-profile.children.cycles-pp.copy_present_pte
      2.84 ±  4%      +0.3        3.16 ±  2%  perf-profile.children.cycles-pp.copy_pte_range
      0.60 ±  3%      +0.4        0.96 ±  4%  perf-profile.children.cycles-pp.rwsem_wake
      3.44 ±  5%      +0.4        3.84 ±  2%  perf-profile.children.cycles-pp.copy_p4d_range
      2.12 ±  3%      +0.4        2.52 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      2.16 ±  3%      +0.4        2.56 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.24 ±  2%      +0.4        1.66 ±  2%  perf-profile.children.cycles-pp.alloc_vmap_area
      3.60 ±  4%      +0.4        4.02 ±  2%  perf-profile.children.cycles-pp.copy_page_range
      1.31 ±  2%      +0.4        1.74 ±  2%  perf-profile.children.cycles-pp.__get_vm_area_node
      2.90            +0.4        3.32 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      1.54 ±  2%      +0.4        1.98 ±  2%  perf-profile.children.cycles-pp.__vmalloc_node_range
      1.99            +0.5        2.44        perf-profile.children.cycles-pp.dup_task_struct
      0.95 ±  2%      +0.5        1.40        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.71 ±  2%      +0.5        2.16 ±  2%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      1.95 ±  2%      +0.5        2.42        perf-profile.children.cycles-pp.kmem_cache_free
      2.70            +0.5        3.19        perf-profile.children.cycles-pp.vm_area_dup
      3.77            +0.6        4.38        perf-profile.children.cycles-pp.kmem_cache_alloc
      3.42 ±  2%      +0.6        4.03 ±  5%  perf-profile.children.cycles-pp.next_uptodate_folio
      2.08 ±  2%      +0.7        2.79 ±  3%  perf-profile.children.cycles-pp._compound_head
      2.40 ±  3%      +0.8        3.20 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.76            +0.9        3.64        perf-profile.children.cycles-pp.release_pages
      3.40            +0.9        4.33        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      2.92 ±  3%      +1.0        3.94 ±  2%  perf-profile.children.cycles-pp.unlink_file_vma
      6.37            +1.1        7.43        perf-profile.children.cycles-pp.zap_pte_range
      3.39            +1.1        4.48        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      3.44            +1.1        4.52        perf-profile.children.cycles-pp.tlb_finish_mmu
      6.51            +1.1        7.60        perf-profile.children.cycles-pp.zap_pmd_range
      6.69            +1.1        7.83        perf-profile.children.cycles-pp.unmap_page_range
      4.33 ±  2%      +1.2        5.52        perf-profile.children.cycles-pp.up_write
      7.11            +1.2        8.31        perf-profile.children.cycles-pp.unmap_vmas
      1.86 ±  4%      +1.5        3.32 ±  3%  perf-profile.children.cycles-pp.__put_anon_vma
      3.77 ±  2%      +2.2        5.93        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      8.77 ±  2%      +3.9       12.67        perf-profile.children.cycles-pp.anon_vma_clone
      8.80 ±  2%      +5.0       13.79 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
     13.67 ±  2%      +6.2       19.90        perf-profile.children.cycles-pp.free_pgtables
      6.64 ±  4%      +6.7       13.34 ±  3%  perf-profile.children.cycles-pp.osq_lock
     14.06 ±  2%      +7.0       21.11        perf-profile.children.cycles-pp.anon_vma_fork
     36.39 ±  2%      +8.9       45.28        perf-profile.children.cycles-pp.__libc_fork
     27.34            +9.0       36.38        perf-profile.children.cycles-pp.exit_mmap
     27.40            +9.0       36.44        perf-profile.children.cycles-pp.__mmput
     27.46            +9.1       36.52        perf-profile.children.cycles-pp.exit_mm
     11.67 ±  3%      +9.2       20.88 ±  2%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     28.58            +9.2       37.82        perf-profile.children.cycles-pp.do_group_exit
     28.57            +9.2       37.81        perf-profile.children.cycles-pp.do_exit
     28.58            +9.2       37.82        perf-profile.children.cycles-pp.__x64_sys_exit_group
     12.20 ±  3%      +9.5       21.68 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     28.34 ±  2%      +9.5       37.88        perf-profile.children.cycles-pp.dup_mmap
     29.04 ±  2%      +9.6       38.69        perf-profile.children.cycles-pp.dup_mm
     15.21 ±  3%     +10.0       25.18        perf-profile.children.cycles-pp.down_write
     31.88 ±  2%     +10.3       42.13        perf-profile.children.cycles-pp.copy_process
     32.45 ±  2%     +10.4       42.84        perf-profile.children.cycles-pp.__do_sys_clone
     32.45 ±  2%     +10.4       42.84        perf-profile.children.cycles-pp.kernel_clone
     64.04 ±  2%     +20.1       84.18        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     64.03 ±  2%     +20.1       84.16        perf-profile.children.cycles-pp.do_syscall_64
     23.26 ±  5%     -21.5        1.76 ±  4%  perf-profile.self.cycles-pp.filemap_map_pages
      0.78            -0.2        0.62 ±  5%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.34 ±  9%      -0.1        0.22 ± 15%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.93            -0.1        0.85        perf-profile.self.cycles-pp._raw_spin_lock
      0.13 ±  5%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.unlink_file_vma
      0.19 ±  5%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.try_charge_memcg
      0.13 ±  4%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.do_wp_page
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.shuffle_freelist
      0.05 ±  8%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__perf_sw_event
      0.08            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.update_load_avg
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.__radix_tree_lookup
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.mab_mas_cp
      0.09 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.mas_mab_cp
      0.08 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.__pte_offset_map
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mas_wr_walk
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.alloc_vmap_area
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__tlb_remove_page_size
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.07 ±  5%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.mas_find
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.mas_store
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.copy_p4d_range
      0.09            +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.pcpu_alloc
      0.11 ±  6%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.remove_vma
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.08            +0.0        0.10        perf-profile.self.cycles-pp.mas_wr_append
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.07            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.exit_mmap
      0.28 ±  3%      +0.0        0.30        perf-profile.self.cycles-pp.unmap_single_vma
      0.22 ±  3%      +0.0        0.24        perf-profile.self.cycles-pp.memset_orig
      0.09 ±  6%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.20 ±  3%      +0.0        0.22 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.20 ±  3%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.19            +0.0        0.21        perf-profile.self.cycles-pp.down_read_trylock
      0.05 ±  8%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.zap_pmd_range
      0.18 ±  2%      +0.0        0.20 ±  5%  perf-profile.self.cycles-pp.do_task_stat
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.free_pgtables
      0.03 ± 70%      +0.0        0.06        perf-profile.self.cycles-pp.insert_vmap_area
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.mark_page_accessed
      0.06            +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.13 ±  3%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.09 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__free_one_page
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.13 ±  4%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.copy_page_range
      0.12 ±  3%      +0.0        0.15        perf-profile.self.cycles-pp.vm_normal_page
      0.16 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.15 ±  2%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.15 ±  2%      +0.0        0.18        perf-profile.self.cycles-pp.mas_update_gap
      0.16 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.unmap_page_range
      0.11 ±  6%      +0.0        0.14        perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.20 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.acct_collect
      0.16 ±  4%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.23 ±  2%      +0.0        0.27 ±  2%  perf-profile.self.cycles-pp.mtree_range_walk
      0.21 ±  2%      +0.0        0.25        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.28 ±  2%      +0.0        0.32        perf-profile.self.cycles-pp.___slab_alloc
      0.08 ±  5%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__vm_area_free
      0.29 ±  3%      +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.25 ±  2%      +0.0        0.30        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_curr
      0.38 ±  2%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.11 ± 14%      +0.1        0.16 ±  8%  perf-profile.self.cycles-pp.____machine__findnew_thread
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.vfree
      0.22 ±  3%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.27 ±  2%      +0.1        0.33        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.29 ±  3%      +0.1        0.36        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.25            +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.set_pte_range
      0.34 ±  2%      +0.1        0.42        perf-profile.self.cycles-pp.__cond_resched
      0.39 ±  2%      +0.1        0.47 ±  2%  perf-profile.self.cycles-pp.sync_regs
      0.18 ±  3%      +0.1        0.26 ±  5%  perf-profile.self.cycles-pp.wake_q_add
      0.62 ±  2%      +0.1        0.71        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.17 ±  4%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.68 ±  2%      +0.1        0.79        perf-profile.self.cycles-pp.__rb_erase_color
      0.46 ±  4%      +0.1        0.57 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.56            +0.1        0.67        perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.44 ±  2%      +0.1        0.56        perf-profile.self.cycles-pp.mas_next_slot
      0.55            +0.1        0.67        perf-profile.self.cycles-pp.fput
      0.71            +0.1        0.84        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.42 ±  3%      +0.1        0.55 ±  3%  perf-profile.self.cycles-pp.anon_vma_fork
      0.33 ±  3%      +0.1        0.47 ±  2%  perf-profile.self.cycles-pp.__put_anon_vma
      1.08 ±  6%      +0.1        1.22 ±  3%  perf-profile.self.cycles-pp.copy_present_pte
      0.48 ±  4%      +0.1        0.62 ±  5%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.47 ±  2%      +0.2        0.63        perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      1.39 ±  2%      +0.2        1.55        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      1.11 ±  2%      +0.2        1.27        perf-profile.self.cycles-pp.dup_mmap
      2.05            +0.2        2.23        perf-profile.self.cycles-pp.__slab_free
      0.58            +0.2        0.76 ±  2%  perf-profile.self.cycles-pp.free_swap_cache
      0.54 ±  4%      +0.2        0.72 ±  2%  perf-profile.self.cycles-pp.vm_area_dup
      0.53 ±  2%      +0.2        0.73 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.79 ±  2%      +0.2        1.00 ±  4%  perf-profile.self.cycles-pp.osq_unlock
      0.94 ±  2%      +0.2        1.17        perf-profile.self.cycles-pp.mod_objcg_state
      0.98            +0.2        1.22 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      1.03 ±  2%      +0.2        1.26        perf-profile.self.cycles-pp.kmem_cache_free
      0.51 ±  3%      +0.2        0.76        perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.62 ±  2%      +0.3        0.90 ±  2%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.62 ±  3%      +0.3        0.94 ±  2%  perf-profile.self.cycles-pp.anon_vma_clone
      1.82 ±  4%      +0.4        2.24        perf-profile.self.cycles-pp.zap_pte_range
      2.75            +0.4        3.19        perf-profile.self.cycles-pp.down_write
      3.27 ±  2%      +0.6        3.85 ±  5%  perf-profile.self.cycles-pp.next_uptodate_folio
      1.97 ±  2%      +0.7        2.65 ±  3%  perf-profile.self.cycles-pp._compound_head
      2.34            +0.7        3.05 ±  2%  perf-profile.self.cycles-pp.release_pages
      2.39 ±  3%      +0.8        3.18 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.68 ±  2%      +0.8        4.49        perf-profile.self.cycles-pp.up_write
      3.35            +0.9        4.27        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      3.71 ±  2%      +2.1        5.84        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      6.57 ±  4%      +6.6       13.20 ±  3%  perf-profile.self.cycles-pp.osq_lock



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/stackmmap/stress-ng/60s

commit: 
  578d7699e5 ("proc: nommu: /proc/<pid>/maps: release mmap read lock")
  c8be038067 ("filemap: add filemap_map_order0_folio() to handle order0 folio")

578d7699e5c2add8 c8be03806738c86521dbf1e0503 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    141511 ±  2%     +14.7%     162288 ±  3%  vmstat.system.cs
     11.96 ±  6%      -1.2       10.81 ±  3%  mpstat.cpu.all.idle%
      0.44 ±  2%      +0.1        0.53 ±  2%  mpstat.cpu.all.soft%
      7.36 ±  2%      +1.1        8.46 ±  2%  mpstat.cpu.all.usr%
   4000874 ±  3%     +11.4%    4458324        meminfo.AnonPages
   4700884 ±  3%     +12.7%    5298360        meminfo.Inactive
   4700664 ±  3%     +12.7%    5298143        meminfo.Inactive(anon)
    792955           +17.7%     933155 ±  2%  meminfo.Shmem
  54901147 ±  3%     +21.1%   66465291 ±  3%  numa-numastat.node0.local_node
  54941291 ±  3%     +21.1%   66511888 ±  3%  numa-numastat.node0.numa_hit
  57920049 ±  4%     +17.2%   67876849 ±  4%  numa-numastat.node1.local_node
  57945488 ±  4%     +17.2%   67887195 ±  4%  numa-numastat.node1.numa_hit
  54942562 ±  3%     +21.1%   66515033 ±  3%  numa-vmstat.node0.numa_hit
  54902418 ±  3%     +21.1%   66468436 ±  3%  numa-vmstat.node0.numa_local
  57947624 ±  4%     +17.2%   67887690 ±  4%  numa-vmstat.node1.numa_hit
  57922185 ±  4%     +17.2%   67877344 ±  4%  numa-vmstat.node1.numa_local
     66.20 ± 16%     +25.0%      82.74 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.avg
   1428711 ±  2%     +20.9%    1727487 ±  2%  sched_debug.cpu.curr->pid.max
    682256 ±  6%     +25.7%     857912 ±  2%  sched_debug.cpu.curr->pid.stddev
     71451 ±  2%     +14.2%      81579 ±  3%  sched_debug.cpu.nr_switches.avg
     47536 ±  5%     +18.0%      56109 ±  3%  sched_debug.cpu.nr_switches.min
     12.68 ±  5%      -1.1       11.53 ±  3%  turbostat.C1%
      0.16 ±  4%     +20.2%       0.19        turbostat.IPC
     30.77 ± 18%     +40.9       71.72 ± 19%  turbostat.PKG_%
      5771 ± 14%     -28.7%       4116 ±  9%  turbostat.POLL
     95.92            +6.6%     102.29        turbostat.RAMWatt
   2995001 ±  2%     +20.9%    3621076 ±  2%  stress-ng.stackmmap.ops
     49916 ±  2%     +20.9%      60350 ±  2%  stress-ng.stackmmap.ops_per_sec
    129660 ±  8%     -75.2%      32138 ± 10%  stress-ng.time.major_page_faults
 3.191e+08 ±  2%     +21.0%  3.861e+08 ±  2%  stress-ng.time.minor_page_faults
      2779           -13.3%       2410        stress-ng.time.system_time
    594.07 ±  8%     +67.9%     997.28 ±  3%  stress-ng.time.user_time
   5679800 ±  2%     +19.7%    6800851 ±  2%  stress-ng.time.voluntary_context_switches
   1000838 ±  3%     +11.4%    1115183        proc-vmstat.nr_anon_pages
    888612            +3.9%     923668        proc-vmstat.nr_file_pages
   1175750 ±  3%     +12.7%    1325151        proc-vmstat.nr_inactive_anon
      5874 ±  2%      +4.2%       6119        proc-vmstat.nr_page_table_pages
    198257           +17.7%     233313 ±  2%  proc-vmstat.nr_shmem
   1175750 ±  3%     +12.7%    1325151        proc-vmstat.nr_zone_inactive_anon
 1.129e+08 ±  3%     +19.1%  1.344e+08 ±  3%  proc-vmstat.numa_hit
 1.128e+08 ±  3%     +19.1%  1.343e+08 ±  3%  proc-vmstat.numa_local
 1.185e+08 ±  3%     +19.1%  1.411e+08 ±  3%  proc-vmstat.pgalloc_normal
 3.241e+08 ±  2%     +20.7%  3.911e+08 ±  2%  proc-vmstat.pgfault
 1.153e+08 ±  3%     +18.5%  1.366e+08 ±  3%  proc-vmstat.pgfree
   5741812 ±  3%     +21.2%    6961766 ±  2%  proc-vmstat.pgreuse
 1.873e+10 ±  3%     +22.3%  2.291e+10 ±  2%  perf-stat.i.branch-instructions
 1.082e+08 ±  3%     +23.2%  1.333e+08 ±  3%  perf-stat.i.branch-misses
     24.46            -1.5       22.96        perf-stat.i.cache-miss-rate%
 3.667e+08 ±  3%     +15.4%  4.231e+08        perf-stat.i.cache-misses
  1.46e+09 ±  2%     +23.4%  1.801e+09        perf-stat.i.cache-references
    145763 ±  2%     +15.2%     167992 ±  3%  perf-stat.i.context-switches
      2.15 ±  2%     -17.9%       1.77 ±  2%  perf-stat.i.cpi
     36595 ±  3%     +32.4%      48445 ±  6%  perf-stat.i.cpu-migrations
    691.65           -12.7%     603.83 ±  5%  perf-stat.i.cycles-between-cache-misses
  25140445 ±  2%     +25.5%   31545433 ±  6%  perf-stat.i.dTLB-load-misses
 2.371e+10 ±  3%     +21.6%  2.884e+10        perf-stat.i.dTLB-loads
  40123934 ±  2%     +22.2%   49015934 ±  2%  perf-stat.i.dTLB-store-misses
 1.458e+10 ±  2%     +20.2%  1.752e+10        perf-stat.i.dTLB-stores
   9.5e+10 ±  3%     +21.6%  1.155e+11        perf-stat.i.instructions
      0.48 ±  2%     +21.4%       0.58 ±  4%  perf-stat.i.ipc
      2383 ±  9%     -75.8%     576.73 ±  9%  perf-stat.i.major-faults
      2448 ±  2%      +9.3%       2675        perf-stat.i.metric.K/sec
    913.61 ±  3%     +21.5%       1110        perf-stat.i.metric.M/sec
   5190230 ±  3%     +21.9%    6325232 ±  2%  perf-stat.i.minor-faults
  81746910 ±  2%     +18.9%   97196139 ±  2%  perf-stat.i.node-load-misses
   8790323 ±  4%      +8.1%    9505696 ±  2%  perf-stat.i.node-loads
     49.29            +4.1       53.41        perf-stat.i.node-store-miss-rate%
  47700938 ±  2%     +18.8%   56673627 ±  3%  perf-stat.i.node-store-misses
   5240728 ±  3%     +21.8%    6384535 ±  2%  perf-stat.i.page-faults
     24.96            -1.4       23.61        perf-stat.overall.cache-miss-rate%
      2.12 ±  2%     -16.3%       1.78 ±  2%  perf-stat.overall.cpi
    555.32 ±  2%     -12.6%     485.28        perf-stat.overall.cycles-between-cache-misses
      0.47 ±  2%     +19.5%       0.56 ±  2%  perf-stat.overall.ipc
     50.97            +3.8       54.79        perf-stat.overall.node-store-miss-rate%
 1.843e+10 ±  3%     +19.8%  2.207e+10 ±  2%  perf-stat.ps.branch-instructions
 1.053e+08 ±  3%     +20.4%  1.268e+08 ±  3%  perf-stat.ps.branch-misses
 3.575e+08 ±  3%     +14.0%  4.075e+08        perf-stat.ps.cache-misses
 1.432e+09 ±  2%     +20.5%  1.726e+09        perf-stat.ps.cache-references
    144772 ±  2%     +13.7%     164652 ±  2%  perf-stat.ps.context-switches
     62851            -0.8%      62333        perf-stat.ps.cpu-clock
     35097 ±  4%     +30.0%      45617 ±  5%  perf-stat.ps.cpu-migrations
  25866054 ±  2%     +23.9%   32060356 ±  6%  perf-stat.ps.dTLB-load-misses
 2.333e+10 ±  2%     +19.2%   2.78e+10 ±  2%  perf-stat.ps.dTLB-loads
  39475692 ±  2%     +19.9%   47333333 ±  2%  perf-stat.ps.dTLB-store-misses
 1.435e+10 ±  2%     +17.9%  1.692e+10        perf-stat.ps.dTLB-stores
  9.34e+10 ±  2%     +19.1%  1.112e+11 ±  2%  perf-stat.ps.instructions
      2048 ±  8%     -75.4%     504.48 ± 10%  perf-stat.ps.major-faults
   5096002 ±  3%     +19.6%    6093240 ±  2%  perf-stat.ps.minor-faults
  79758608 ±  2%     +17.2%   93512595 ±  2%  perf-stat.ps.node-load-misses
  47791817 ±  3%     +16.9%   55869122 ±  3%  perf-stat.ps.node-store-misses
   5145197 ±  3%     +19.5%    6150225 ±  2%  perf-stat.ps.page-faults
     62851            -0.8%      62333        perf-stat.ps.task-clock
 5.843e+12 ±  2%     +19.3%  6.968e+12 ±  2%  perf-stat.total.instructions
      0.04 ± 14%     -21.0%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.04 ±  5%     -24.2%       0.03        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.03 ± 24%     +35.1%       0.03 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.02 ±  7%     +20.8%       0.03 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.01 ± 33%    +108.2%       0.02 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      0.02 ±  6%     +19.7%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.filemap_page_mkwrite.do_page_mkwrite.do_fault.__handle_mm_fault
      0.01 ± 62%    +384.9%       0.04 ± 77%  perf-sched.sch_delay.avg.ms.__cond_resched.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.02 ±  3%     +21.2%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.02           +23.1%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ±  2%     -16.5%       0.03 ±  3%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ±  3%     +17.6%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.02 ±  6%     +18.9%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ±  3%     +23.4%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ± 36%     +54.9%       0.02 ± 14%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      0.79 ±  7%     -20.7%       0.63 ±  3%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.02 ± 48%    +231.3%       0.07 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      0.02 ±107%    +462.0%       0.10 ± 87%  perf-sched.sch_delay.max.ms.__cond_resched.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.24 ±  9%     +46.3%       1.81 ± 24%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.87 ±  6%     -22.6%       0.67 ± 13%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.91 ± 17%     -53.2%       0.43 ± 20%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.38 ± 45%     -53.8%       0.17 ± 40%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.13 ± 52%    +134.6%       0.31 ± 40%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      2.31 ±  3%     -17.4%       1.90 ±  2%  perf-sched.total_wait_and_delay.average.ms
    571437 ±  2%     +18.6%     677822 ±  2%  perf-sched.total_wait_and_delay.count.ms
      2.28 ±  3%     -17.6%       1.87 ±  2%  perf-sched.total_wait_time.average.ms
     16.12 ±  4%     -13.1%      14.00 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.95 ±  4%     -29.6%       0.67 ±  4%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.03 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.03 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     31.70 ±  2%     -11.5%      28.04 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     28.67 ± 24%     +63.4%      46.83 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1077 ± 11%     +60.2%       1725 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    248915 ±  2%     +21.8%     303203 ±  2%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    249180 ±  2%     +21.8%     303545 ±  2%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      6482 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      9922 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     18442 ±  2%     +12.2%      20701 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     21578 ±  2%     +11.3%      24013 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.37 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      1.17 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.89 ±  7%     -30.2%       0.62 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc.mm_init
      0.90 ±  4%     -31.4%       0.62 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pmd_alloc.copy_p4d_range.copy_page_range
      0.88 ± 12%     -26.8%       0.64 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__pud_alloc.copy_p4d_range.copy_page_range
      0.91 ±  5%     -30.4%       0.63 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.copy_pte_range
      0.93 ±  9%     -34.5%       0.61 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      0.89 ±  9%     -23.8%       0.68 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      0.94 ±  4%     -32.1%       0.64 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
      0.88 ±  6%     -26.5%       0.64 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.00 ± 27%     -81.2%       0.00 ± 99%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.96 ±  7%     -27.8%       0.69 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.91 ±  2%     -29.0%       0.64 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.92 ±  4%     -31.2%       0.64 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      1.46 ± 82%     -56.3%       0.64 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.89 ±  9%     -31.3%       0.61 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dentry_kill.dput.proc_invalidate_siblings_dcache.release_task
      0.92 ±  4%     -30.6%       0.64 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.91 ±  3%     -28.9%       0.65 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.93 ±  4%     -31.8%       0.64 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.93 ±  5%     -31.2%       0.64 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.00 ± 61%     -85.0%       0.00 ±152%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.00 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_page_mkwrite.do_page_mkwrite.do_fault.__handle_mm_fault
      0.95 ±  6%     -31.2%       0.65 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.93 ±  4%     -31.6%       0.64 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      0.93 ±  2%     -27.2%       0.68 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      0.93 ± 12%     -31.1%       0.64 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      0.91 ± 11%     -26.6%       0.67 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      0.86 ±  9%     -27.6%       0.62 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      0.88 ±  4%     -30.0%       0.62 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      0.90 ±  3%     -29.8%       0.64 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      1.29 ± 62%     -50.3%       0.64 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.87 ±  4%     -27.3%       0.64 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.90 ±  3%     -40.6%       0.54 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      0.92 ±  2%     -29.8%       0.64 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      0.90 ±  3%     -30.3%       0.63 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      1.02 ±143%    +338.8%       4.49 ± 86%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.95 ±  4%     -31.7%       0.65 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
     16.10 ±  4%     -13.1%      13.99 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.92 ±  8%     -31.4%       0.63 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.15 ± 14%     -40.5%       0.09 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.11 ±  5%     -14.1%       0.09 ±  5%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.91 ±  4%     -30.2%       0.64 ±  4%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ± 17%     +47.8%       0.01 ± 13%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.01 ± 23%     -96.9%       0.00 ±223%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.52 ± 10%     -40.3%       0.31 ±  5%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.53 ± 11%     -42.5%       0.30 ± 11%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      0.78 ± 28%     -52.0%       0.37 ± 39%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
     31.68 ±  2%     -11.6%      28.02 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.32 ± 17%     -34.7%       0.86 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      1.39 ± 13%     -25.4%       1.04 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.copy_pte_range
      1.27 ± 20%     -41.4%       0.74 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      1.47 ± 18%     -38.8%       0.90 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
      1.16 ± 11%     -37.7%       0.72 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.dentry_kill.dput.proc_invalidate_siblings_dcache.release_task
      0.07 ±101%     -90.0%       0.01 ±175%  perf-sched.wait_time.max.ms.__cond_resched.down_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56 ± 10%     -67.0%       0.18 ±132%  perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.63 ± 17%     -76.9%       0.15 ± 88%  perf-sched.wait_time.max.ms.__cond_resched.filemap_page_mkwrite.do_page_mkwrite.do_fault.__handle_mm_fault
      1.26 ± 11%     -23.0%       0.97 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      1.04 ± 11%     -24.6%       0.78 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      0.96 ± 12%     -29.7%       0.67 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      1.52 ±  9%     -27.5%       1.10 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      1.09 ±  3%     -26.6%       0.80 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.18 ±134%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      1.02 ± 13%     -41.4%       0.60 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      0.36 ± 58%     -72.7%       0.10 ±146%  perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.isra
      1.27 ± 16%     -25.1%       0.95 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      1.65 ± 47%     -47.4%       0.86 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
    254.18 ±149%    +186.9%     729.12 ± 54%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.81 ± 16%     -82.7%       0.14 ±128%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1.23 ± 12%     -30.2%       0.86 ± 11%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
     29.96 ±  4%     -24.2        5.77 ±  2%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     28.02 ±  5%     -24.2        3.85 ±  4%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     27.76 ±  5%     -24.0        3.74 ±  4%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     32.40 ±  4%     -23.6        8.77 ±  8%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     14.10 ±  5%      -9.6        4.48 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     14.46 ±  5%      -9.5        4.94 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     14.48 ±  5%      -9.5        4.96 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     14.74 ±  5%      -9.4        5.29 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.38 ±  4%      -1.6        0.76 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
      2.78 ± 27%      -1.6        1.17 ± 68%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.makecontext
      2.51 ±  4%      -1.6        0.92 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__libc_fork
      2.84 ± 26%      -1.6        1.25 ± 64%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.makecontext
      2.84 ± 26%      -1.6        1.25 ± 64%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.makecontext
      2.51 ±  4%      -1.6        0.92 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__libc_fork
      2.84 ±  4%      -1.6        1.26 ±  2%  perf-profile.calltrace.cycles-pp.open64
      2.91 ± 26%      -1.6        1.34 ± 59%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.makecontext
      2.95 ± 25%      -1.6        1.38 ± 57%  perf-profile.calltrace.cycles-pp.makecontext
      2.68 ±  4%      -1.5        1.14 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__libc_fork
      1.01 ±  8%      -0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.stress_stackmmap
      0.53 ±  3%      +0.0        0.56        perf-profile.calltrace.cycles-pp.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      0.67 ±  3%      +0.1        0.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      0.61 ±  3%      +0.1        0.68 ±  3%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.59 ±  5%      +0.1        0.66 ±  4%  perf-profile.calltrace.cycles-pp.filemap_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.61 ±  5%      +0.1        0.70 ±  4%  perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.79 ±  2%      +0.1        0.91 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msync
      0.68            +0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.67            +0.1        0.81 ±  4%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.85 ±  2%      +0.1        0.99 ±  3%  perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store.dup_mmap.dup_mm
      0.59 ±  3%      +0.1        0.73 ±  4%  perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      0.69 ±  3%      +0.1        0.83 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.74            +0.1        0.89 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.75            +0.1        0.89 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.75            +0.1        0.90 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.75            +0.1        0.90 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.54 ±  3%      +0.2        0.71 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm.copy_process
      0.56 ±  3%      +0.2        0.73 ±  3%  perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.58 ±  3%      +0.2        0.75 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.58 ±  2%      +0.2        0.76 ±  2%  perf-profile.calltrace.cycles-pp.remove_vma.exit_mmap.__mmput.exit_mm.do_exit
      0.97 ±  2%      +0.2        1.14 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store.dup_mmap.dup_mm.copy_process
      0.66 ±  2%      +0.2        0.84 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.53 ±  2%      +0.2        0.71        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.53 ±  2%      +0.2        0.71 ±  4%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4
      0.57 ±  2%      +0.2        0.76 ±  4%  perf-profile.calltrace.cycles-pp.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.97 ±  3%      +0.2        1.19 ±  5%  perf-profile.calltrace.cycles-pp.up_write.dup_mmap.dup_mm.copy_process.kernel_clone
      0.84 ±  2%      +0.2        1.06 ±  2%  perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.__mmput.exit_mm.do_exit
      0.87 ±  3%      +0.2        1.10 ±  3%  perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exit_mm
      0.82 ±  3%      +0.2        1.07 ±  2%  perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      1.02 ±  4%      +0.3        1.30 ±  2%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.35 ± 70%      +0.3        0.64        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store.dup_mmap.dup_mm.copy_process
      0.90 ±  2%      +0.3        1.19 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_wait.kernel_wait4.__do_sys_wait4
      0.35 ± 70%      +0.3        0.64 ±  2%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.stress_stackmmap_push_msync
      0.90 ±  2%      +0.3        1.20 ±  3%  perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.62 ±  2%      +0.3        1.95 ±  2%  perf-profile.calltrace.cycles-pp.mas_store.dup_mmap.dup_mm.copy_process.kernel_clone
      2.70 ±  2%      +0.3        3.05        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_stackmmap_push_msync
      1.76 ±  5%      +0.4        2.12 ±  5%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      2.03 ±  2%      +0.4        2.39 ±  2%  perf-profile.calltrace.cycles-pp.msync
      0.25 ±100%      +0.4        0.64 ±  2%  perf-profile.calltrace.cycles-pp.fput.remove_vma.exit_mmap.__mmput.exit_mm
      1.93 ±  2%      +0.4        2.34 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.msync
      0.92 ±  5%      +0.4        1.34 ±  5%  perf-profile.calltrace.cycles-pp.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      1.35 ±  6%      +0.4        1.78 ±  6%  perf-profile.calltrace.cycles-pp.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      3.66 ±  2%      +0.4        4.10        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_stackmmap_push_msync
      0.57 ±  6%      +0.4        1.02 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      3.78 ±  2%      +0.5        4.24        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_stackmmap_push_msync
      0.20 ±141%      +0.5        0.67 ± 15%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      1.61 ±  2%      +0.5        2.09 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm.copy_process
      0.75 ±  5%      +0.5        1.25 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap
      1.65 ±  5%      +0.5        2.17 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__vm_area_free.exit_mmap.__mmput.exit_mm
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.do_wait.kernel_wait4
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe._exit
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe._exit
      0.00            +0.5        0.55 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._exit
      0.00            +0.6        0.55 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._exit
      0.00            +0.6        0.55 ±  3%  perf-profile.calltrace.cycles-pp._exit
      1.18 ±  3%      +0.6        1.74 ±  6%  perf-profile.calltrace.cycles-pp._compound_head.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.83 ±  4%      +0.6        1.42 ±  9%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      0.00            +0.6        0.59 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.exit_mmap.__mmput.exit_mm.do_exit
      1.26 ±  2%      +0.6        1.86 ±  9%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      2.25 ±  6%      +0.6        2.86 ±  2%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      4.45 ±  2%      +0.6        5.07        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_stackmmap_push_msync
      0.86 ±  5%      +0.6        1.49 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      2.72 ±  5%      +0.6        3.37 ±  3%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      1.69 ±  2%      +0.6        2.34 ±  3%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.03 ±  5%      +0.6        2.68 ±  2%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      2.05 ±  5%      +0.7        2.70 ±  2%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.73 ±  2%      +0.7        2.39 ±  3%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      1.74 ±  2%      +0.7        2.40 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      1.77 ±  2%      +0.7        2.44 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      1.77 ±  2%      +0.7        2.44 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      1.57 ±  3%      +0.7        2.24 ±  6%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      1.80 ±  2%      +0.7        2.48 ±  3%  perf-profile.calltrace.cycles-pp.wait4
      2.86 ±  5%      +0.7        3.55 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.7        0.69 ± 15%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
      0.00            +0.7        0.69 ±  6%  perf-profile.calltrace.cycles-pp._compound_head.copy_present_pte.copy_pte_range.copy_p4d_range.copy_page_range
      2.26 ±  2%      +0.7        2.97 ±  2%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.8        0.77 ± 18%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
      0.00            +0.8        0.78 ± 14%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.00            +0.9        0.86 ± 17%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
      2.70 ±  3%      +0.9        3.61 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.86 ±  5%      +1.0        1.82 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.74 ±  7%      +1.0        1.76 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      1.37 ±  6%      +1.4        2.76 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      1.78 ±  5%      +1.6        3.33 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
      1.47 ±  6%      +1.6        3.02 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables
      1.54 ±  6%      +1.6        3.14 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      1.85 ±  5%      +1.6        3.45 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      1.80 ±  6%      +1.7        3.52 ±  5%  perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      2.09 ±  4%      +1.8        3.84 ±  2%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      6.87 ±  2%      +2.1        8.96 ±  4%  perf-profile.calltrace.cycles-pp.stress_stackmmap_push_msync
      2.44 ±  5%      +2.1        4.56 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
      2.52 ±  5%      +2.2        4.68 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
      2.66 ±  5%      +2.2        4.86 ±  3%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
      6.23 ±  4%      +3.3        9.48 ±  3%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      6.69 ±  3%      +3.5       10.17 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      9.26 ±  4%      +4.3       13.52 ±  3%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
     10.51 ±  4%      +6.1       16.64 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
     22.36 ±  3%      +7.9       30.28 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     22.45 ±  3%      +7.9       30.37 ±  2%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     22.46 ±  3%      +7.9       30.38 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     23.72 ±  3%      +8.3       32.02 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.72 ±  3%      +8.3       32.02 ±  2%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.75 ±  3%      +8.3       32.04 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.74 ±  3%      +8.3       32.04 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.67 ±  2%      +8.3       36.01 ±  2%  perf-profile.calltrace.cycles-pp.__libc_fork
     23.72 ±  3%      +8.8       32.55 ±  2%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.85 ±  3%      +9.1       30.91 ±  2%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     22.51 ±  3%      +9.3       31.77 ±  2%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     23.97 ±  3%      +9.6       33.58 ±  2%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.54 ±  3%      +9.8       34.34 ±  2%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     24.55 ±  3%      +9.8       34.34 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     24.56 ±  3%      +9.8       34.36 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
     24.55 ±  3%      +9.8       34.35 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     28.93 ±  5%     -21.7        7.26 ±  2%  perf-profile.children.cycles-pp.do_read_fault
     28.70 ±  5%     -21.7        7.03 ±  2%  perf-profile.children.cycles-pp.filemap_map_pages
     30.97 ±  4%     -21.5        9.44        perf-profile.children.cycles-pp.do_fault
     33.69 ±  4%     -21.3       12.35 ±  5%  perf-profile.children.cycles-pp.__handle_mm_fault
     34.32 ±  4%     -21.1       13.21 ±  4%  perf-profile.children.cycles-pp.handle_mm_fault
     36.16 ±  3%     -20.8       15.34 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
     36.31 ±  3%     -20.8       15.52 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
     38.94 ±  3%     -20.1       18.82 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.15 ±  6%      -1.8        0.40 ± 16%  perf-profile.children.cycles-pp.__errno_location
      2.14 ±  6%      -1.7        0.48 ±  2%  perf-profile.children.cycles-pp.prctl
      2.86 ±  4%      -1.6        1.29 ±  3%  perf-profile.children.cycles-pp.open64
      3.00 ± 25%      -1.6        1.44 ± 55%  perf-profile.children.cycles-pp.makecontext
      1.84 ± 19%      -1.4        0.39        perf-profile.children.cycles-pp.sigemptyset
      0.93 ±  8%      -0.5        0.46 ±  5%  perf-profile.children.cycles-pp.stress_parent_died_alarm
      1.04 ±  7%      -0.5        0.59 ±  3%  perf-profile.children.cycles-pp.stress_stackmmap
      0.86 ±  9%      -0.4        0.41 ±  9%  perf-profile.children.cycles-pp.prctl@plt
      0.87 ±  3%      -0.2        0.70 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.36 ±  4%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.up_read
      0.14 ±  7%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__getpid
      0.41 ±  3%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.down_read_trylock
      0.17 ±  4%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.54            -0.0        0.50 ±  3%  perf-profile.children.cycles-pp.dup_userfaultfd
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__update_load_avg_se
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.lru_add_fn
      0.09            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.proc_pident_lookup
      0.07            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__bad_area_nosemaphore
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__x64_sys_close
      0.06            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.update_blocked_averages
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.copy_signal
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.proc_pident_instantiate
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.filp_close
      0.07 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.account_kernel_stack
      0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.switch_fpu_return
      0.06 ±  6%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp._find_next_or_bit
      0.06            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.select_idle_sibling
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.07 ±  5%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.05 ±  7%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.alloc_empty_file
      0.05 ±  7%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mas_next_node
      0.06 ±  6%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.mas_store_b_node
      0.11 ±  3%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__close
      0.05            +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.perf_event_fork
      0.05 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.xas_descend
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.folio_mapping
      0.06 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__free_one_page
      0.05 ±  8%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.vfree
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.filp_flush
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.cgroup_can_fork
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.mast_split_data
      0.13            +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.lookup_open
      0.12 ±  6%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__dentry_kill
      0.07 ±  9%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.process_one_work
      0.06 ± 11%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.xas_start
      0.12 ±  5%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.pgd_alloc
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__put_task_struct
      0.08 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.05            +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.exit_task_stack_account
      0.09 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.copy_creds
      0.08 ±  4%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.proc_pid_instantiate
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.dup_fd
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.mas_pop_node
      0.08 ±  7%      +0.0        0.10        perf-profile.children.cycles-pp.prepare_creds
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.down_read
      0.16            +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.open_last_lookups
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.tlb_flush_rmaps
      0.09 ±  8%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.09 ±  6%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.select_task_rq
      0.08            +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.08            +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.access_error
      0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.20 ±  3%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.21 ±  2%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.mas_topiary_replace
      0.13            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.10 ±  5%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.put_cred_rcu
      0.11            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.file_update_time
      0.09 ±  5%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.09 ±  8%      +0.0        0.11        perf-profile.children.cycles-pp.mas_mab_cp
      0.09 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.mas_wr_walk
      0.08 ±  6%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.07 ± 10%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.perf_event_task
      0.20 ±  3%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.11 ±  3%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.cpu_util
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.19 ±  4%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.13 ±  6%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.d_alloc
      0.08 ±  6%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.06            +0.0        0.08 ± 29%  perf-profile.children.cycles-pp.oom_score_adj_write
      0.09 ±  5%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.12 ±  6%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.12 ±  4%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.flush_tlb_func
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.get_sigframe
      0.09            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.23 ±  3%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__memcpy
      0.15 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.d_invalidate
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.13 ±  2%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.mas_split_final_node
      0.08            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mas_expected_entries
      0.08            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.07 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.percpu_counter_destroy_many
      0.17 ±  4%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.shim_waitpid
      0.10            +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.error_entry
      0.17 ±  4%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.stress_mwc8
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      0.07 ±  6%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.detach_tasks
      0.20 ±  3%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.swapcontext
      0.20 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.handle_signal
      0.16 ±  4%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.13 ±  3%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.proc_pid_make_inode
      0.12 ±  4%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.new_inode
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.perf_event_task_output
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.10 ±  5%      +0.0        0.13        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  6%      +0.0        0.13 ± 10%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.08 ±  4%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.alloc_inode
      0.35 ±  3%      +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.31 ±  3%      +0.0        0.34 ±  3%  perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.15 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.lru_add_drain
      0.10 ±  4%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.alloc_pid
      0.11 ± 13%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.pick_link
      0.20 ±  6%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.15 ±  4%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.14 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__exit_signal
      0.14 ±  7%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.dput
      0.25            +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.26            +0.0        0.29        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.12 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      0.12 ±  8%      +0.0        0.16 ±  8%  perf-profile.children.cycles-pp.free_p4d_range
      0.11 ±  3%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.free_unref_page
      0.28 ±  3%      +0.0        0.31 ±  3%  perf-profile.children.cycles-pp.filemap_page_mkwrite
      0.28            +0.0        0.31 ±  3%  perf-profile.children.cycles-pp.unmap_single_vma
      0.10            +0.0        0.14 ± 19%  perf-profile.children.cycles-pp.write
      0.12 ±  5%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.14 ±  4%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.proc_root_lookup
      0.12 ±  5%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.xas_find
      0.11 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.13 ±  7%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.free_pgd_range
      0.14 ±  5%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.proc_pid_lookup
      0.07 ±  9%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.mark_page_accessed
      0.42 ±  2%      +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.30 ±  2%      +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.30 ±  3%      +0.0        0.34 ±  3%  perf-profile.children.cycles-pp.do_page_mkwrite
      0.12 ±  8%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.16 ±  4%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.mab_mas_cp
      0.54 ±  3%      +0.0        0.58        perf-profile.children.cycles-pp.__do_sys_msync
      0.12            +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.mas_find
      0.11 ±  9%      +0.0        0.15 ± 14%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.10 ±  5%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.free_percpu
      0.44 ±  2%      +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.16 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.15 ±  7%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.12 ±  3%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.11            +0.0        0.15        perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.free_pid
      0.16 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map
      0.16 ±  5%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__put_user_4
      0.13 ±  5%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      0.42 ±  2%      +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.15 ±  3%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.27            +0.0        0.31 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.14 ±  9%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.step_into
      0.24 ±  5%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.handle_pte_fault
      0.02 ±141%      +0.0        0.06        perf-profile.children.cycles-pp.perf_swevent_event
      0.15 ±  6%      +0.0        0.19 ± 13%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.02 ±141%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.inode_init_always
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.20 ±  3%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
      0.50            +0.0        0.54 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.27 ±  3%      +0.0        0.32 ±  6%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.22 ±  2%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__reclaim_stacks
      0.09 ±  8%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__mt_destroy
      0.38 ±  3%      +0.0        0.43 ±  2%  perf-profile.children.cycles-pp.finish_fault
      0.25            +0.0        0.30 ±  5%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.01 ±223%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.sched_cgroup_fork
      0.14 ± 18%      +0.0        0.19 ± 10%  perf-profile.children.cycles-pp.path_lookupat
      0.20 ±  4%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.19 ±  3%      +0.0        0.24        perf-profile.children.cycles-pp.rcu_all_qs
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__init_rwsem
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__vm_enough_memory
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.lockref_put_return
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.shmem_fault
      0.54 ±  2%      +0.1        0.59        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.53 ±  2%      +0.1        0.58        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.21 ±  4%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.available_idle_cpu
      0.10 ±  7%      +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.d_walk
      0.36            +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.20 ±  2%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.sched_move_task
      0.27 ±  2%      +0.1        0.33 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
      0.22 ±  4%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.refill_obj_stock
      0.17 ±  4%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.dequeue_entity
      0.22 ±  4%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.do_notify_parent
      0.16 ±  4%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.37 ±  3%      +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.__nptl_set_robust
      0.19 ±  4%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.activate_task
      0.20 ±  4%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.19 ±  2%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.19 ±  3%      +0.1        0.25 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.32            +0.1        0.39 ±  2%  perf-profile.children.cycles-pp.mas_push_data
      0.23 ±  3%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.__lookup_slow
      0.23 ±  2%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      0.78 ±  4%      +0.1        0.85 ±  3%  perf-profile.children.cycles-pp.__do_fault
      0.27 ±  3%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.mas_update_gap
      0.26 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_sum
      1.10            +0.1        1.16 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.61 ±  3%      +0.1        0.68 ±  3%  perf-profile.children.cycles-pp.dup_task_struct
      0.43 ±  7%      +0.1        0.50 ±  6%  perf-profile.children.cycles-pp.filemap_get_entry
      0.35 ±  3%      +0.1        0.42 ±  6%  perf-profile.children.cycles-pp.clear_page_erms
      0.42 ±  7%      +0.1        0.50 ±  6%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.30 ±  4%      +0.1        0.37 ±  4%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.31 ±  3%      +0.1        0.38 ±  4%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.19 ±  6%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.kthread
      0.23 ±  3%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.21 ±  6%      +0.1        0.28 ±  5%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.31 ±  3%      +0.1        0.39 ±  4%  perf-profile.children.cycles-pp.schedule_tail
      0.34 ±  4%      +0.1        0.42 ±  5%  perf-profile.children.cycles-pp.walk_component
      0.34 ±  2%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.acct_collect
      0.20 ±  6%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.42 ±  2%      +0.1        0.50 ±  2%  perf-profile.children.cycles-pp.do_task_dead
      0.36 ±  3%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.29 ±  3%      +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.35 ±  3%      +0.1        0.43        perf-profile.children.cycles-pp.mas_wr_append
      1.01 ±  2%      +0.1        1.09 ±  3%  perf-profile.children.cycles-pp.wp_page_copy
      0.41 ±  4%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.40 ±  2%      +0.1        0.49 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.42 ±  4%      +0.1        0.51 ±  3%  perf-profile.children.cycles-pp.find_busiest_group
      0.23 ±  4%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.29            +0.1        0.39 ±  3%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.46            +0.1        0.55 ±  4%  perf-profile.children.cycles-pp._exit
      0.51 ±  2%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.24 ±  4%      +0.1        0.34        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.36            +0.1        0.46        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.40 ±  3%      +0.1        0.50        perf-profile.children.cycles-pp.mt_find
      0.31 ±  3%      +0.1        0.42        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.46 ±  4%      +0.1        0.57 ±  4%  perf-profile.children.cycles-pp.link_path_walk
      0.32 ±  4%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.__rb_erase_color
      0.42 ±  2%      +0.1        0.53        perf-profile.children.cycles-pp.find_vma
      0.26 ± 20%      +0.1        0.38 ± 10%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.34            +0.1        0.46 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.34 ±  3%      +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
      0.66 ±  2%      +0.1        0.78 ±  6%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.35 ±  3%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.pcpu_alloc
      0.21 ±  6%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.62 ±  7%      +0.1        0.75 ±  5%  perf-profile.children.cycles-pp.pte_alloc_one
      0.61 ±  3%      +0.1        0.74 ±  2%  perf-profile.children.cycles-pp.fput
      0.53 ±  2%      +0.1        0.66        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.38 ±  3%      +0.1        0.51        perf-profile.children.cycles-pp.find_idlest_cpu
      0.48 ±  2%      +0.1        0.62 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.68            +0.1        0.81 ±  3%  perf-profile.children.cycles-pp.path_openat
      0.68            +0.1        0.82 ±  4%  perf-profile.children.cycles-pp.do_filp_open
      0.59 ±  3%      +0.1        0.73 ±  4%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.50 ±  2%      +0.1        0.65 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.34 ±  4%      +0.1        0.49 ±  2%  perf-profile.children.cycles-pp.exit_notify
      0.16 ±  6%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.75            +0.1        0.90 ±  3%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.59 ±  3%      +0.1        0.73 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      1.08 ±  3%      +0.1        1.23 ±  5%  perf-profile.children.cycles-pp.__alloc_pages
      1.09            +0.1        1.24        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.06            +0.1        1.20        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.86 ±  2%      +0.1        1.01 ±  2%  perf-profile.children.cycles-pp.mas_split
      0.74            +0.1        0.89 ±  4%  perf-profile.children.cycles-pp.do_sys_openat2
      0.46 ±  4%      +0.2        0.62        perf-profile.children.cycles-pp.select_task_rq_fair
      0.52            +0.2        0.67 ±  2%  perf-profile.children.cycles-pp.mas_next_slot
      0.54 ±  3%      +0.2        0.70 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.65 ±  2%      +0.2        0.80 ±  2%  perf-profile.children.cycles-pp.mtree_range_walk
      0.50 ±  2%      +0.2        0.66 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.51 ±  4%      +0.2        0.66 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      0.61 ±  4%      +0.2        0.77 ±  4%  perf-profile.children.cycles-pp.load_balance
      0.54 ±  4%      +0.2        0.70 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.43 ± 19%      +0.2        0.59 ± 10%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.58            +0.2        0.75 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.57 ±  2%      +0.2        0.74 ±  2%  perf-profile.children.cycles-pp.mm_init
      0.98 ±  2%      +0.2        1.15 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.46 ±  3%      +0.2        0.63 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.66 ±  4%      +0.2        0.84 ±  4%  perf-profile.children.cycles-pp.newidle_balance
      0.59 ±  2%      +0.2        0.77 ±  2%  perf-profile.children.cycles-pp.remove_vma
      0.53 ±  2%      +0.2        0.71 ±  4%  perf-profile.children.cycles-pp.release_task
      0.53 ±  2%      +0.2        0.72 ±  2%  perf-profile.children.cycles-pp.wake_up_new_task
      0.72 ±  3%      +0.2        0.91 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.57 ±  2%      +0.2        0.76 ±  4%  perf-profile.children.cycles-pp.wait_task_zombie
      0.84 ±  3%      +0.2        1.04        perf-profile.children.cycles-pp.native_irq_return_iret
      0.79 ±  2%      +0.2        0.99 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.45 ±  5%      +0.2        0.65 ±  5%  perf-profile.children.cycles-pp.osq_unlock
      0.46            +0.2        0.66 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.59 ± 10%      +0.2        0.80 ± 10%  perf-profile.children.cycles-pp.free_swap_cache
      0.62 ± 11%      +0.2        0.84 ± 11%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.54 ±  2%      +0.2        0.76 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      0.22 ±  5%      +0.2        0.46 ±  6%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.84 ±  2%      +0.2        1.08 ±  2%  perf-profile.children.cycles-pp.__vm_area_free
      0.91 ±  3%      +0.2        1.15 ±  2%  perf-profile.children.cycles-pp.sync_regs
      0.95            +0.3        1.23 ±  3%  perf-profile.children.cycles-pp.schedule
      1.02 ±  4%      +0.3        1.31 ±  2%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      1.72 ±  2%      +0.3        2.01 ±  2%  perf-profile.children.cycles-pp.__slab_free
      1.63 ±  2%      +0.3        1.97 ±  2%  perf-profile.children.cycles-pp.mas_store
      1.46            +0.4        1.84 ±  3%  perf-profile.children.cycles-pp.__schedule
      2.10 ±  2%      +0.4        2.49 ±  2%  perf-profile.children.cycles-pp.msync
      1.23 ±  3%      +0.4        1.64        perf-profile.children.cycles-pp.mod_objcg_state
      0.92 ±  4%      +0.4        1.34 ±  5%  perf-profile.children.cycles-pp.__put_anon_vma
      1.37 ±  6%      +0.4        1.81 ±  6%  perf-profile.children.cycles-pp.copy_present_pte
      0.54 ±  6%      +0.5        1.00 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.63 ±  2%      +0.5        2.11 ±  2%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      1.83 ±  2%      +0.5        2.36 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      3.38 ±  3%      +0.6        3.96 ±  2%  perf-profile.children.cycles-pp.next_uptodate_folio
      2.26 ±  6%      +0.6        2.88 ±  2%  perf-profile.children.cycles-pp.copy_pte_range
      1.69 ±  2%      +0.6        2.34 ±  3%  perf-profile.children.cycles-pp.do_wait
      2.73 ±  5%      +0.6        3.38 ±  3%  perf-profile.children.cycles-pp.copy_p4d_range
      2.05 ±  5%      +0.7        2.70 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.73 ±  2%      +0.7        2.39 ±  3%  perf-profile.children.cycles-pp.kernel_wait4
      1.74 ±  2%      +0.7        2.40 ±  3%  perf-profile.children.cycles-pp.__do_sys_wait4
      1.58 ±  4%      +0.7        2.26 ±  6%  perf-profile.children.cycles-pp.unlink_file_vma
      1.81 ±  2%      +0.7        2.49 ±  3%  perf-profile.children.cycles-pp.wait4
      2.87 ±  5%      +0.7        3.56 ±  2%  perf-profile.children.cycles-pp.copy_page_range
      2.28 ±  2%      +0.7        2.99 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      2.89 ±  3%      +0.9        3.77 ±  3%  perf-profile.children.cycles-pp.up_write
      2.64 ±  7%      +0.9        3.53 ±  8%  perf-profile.children.cycles-pp.release_pages
      3.06 ±  2%      +0.9        3.96 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      2.72 ±  3%      +0.9        3.64 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      1.82 ±  2%      +0.9        2.75 ±  6%  perf-profile.children.cycles-pp._compound_head
      3.25 ±  8%      +1.1        4.36 ±  9%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      8.30 ±  2%      +1.5        9.84        perf-profile.children.cycles-pp.stress_stackmmap_push_msync
      2.46 ±  5%      +1.8        4.21 ±  3%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      6.26 ±  4%      +3.3        9.52 ±  3%  perf-profile.children.cycles-pp.unlink_anon_vmas
      6.70 ±  3%      +3.5       10.18 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      3.53 ±  6%      +4.1        7.66 ±  4%  perf-profile.children.cycles-pp.osq_lock
      9.28 ±  4%      +4.3       13.54 ±  3%  perf-profile.children.cycles-pp.free_pgtables
     10.52 ±  4%      +6.1       16.66 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      6.69 ±  5%      +6.3       12.95 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      7.01 ±  5%      +6.5       13.48 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      9.61 ±  4%      +7.1       16.72 ±  4%  perf-profile.children.cycles-pp.down_write
     22.38 ±  3%      +7.9       30.30 ±  2%  perf-profile.children.cycles-pp.exit_mmap
     22.45 ±  3%      +7.9       30.37 ±  2%  perf-profile.children.cycles-pp.__mmput
     22.49 ±  3%      +7.9       30.42 ±  2%  perf-profile.children.cycles-pp.exit_mm
     27.77 ±  2%      +8.4       36.15 ±  2%  perf-profile.children.cycles-pp.__libc_fork
     24.16 ±  3%      +8.4       32.55 ±  2%  perf-profile.children.cycles-pp.do_exit
     24.18 ±  3%      +8.4       32.56 ±  2%  perf-profile.children.cycles-pp.do_group_exit
     24.18 ±  3%      +8.4       32.56 ±  2%  perf-profile.children.cycles-pp.__x64_sys_exit_group
     21.91 ±  3%      +9.1       30.99 ±  2%  perf-profile.children.cycles-pp.dup_mmap
     22.51 ±  3%      +9.3       31.77 ±  2%  perf-profile.children.cycles-pp.dup_mm
     23.98 ±  3%      +9.6       33.58 ±  2%  perf-profile.children.cycles-pp.copy_process
     24.55 ±  3%      +9.8       34.34 ±  2%  perf-profile.children.cycles-pp.kernel_clone
     24.55 ±  3%      +9.8       34.34 ±  2%  perf-profile.children.cycles-pp.__do_sys_clone
     52.43 ±  2%     +19.2       71.63        perf-profile.children.cycles-pp.do_syscall_64
     52.61 ±  2%     +19.3       71.87        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.74 ±  6%     -22.0        1.73 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      0.84 ±  3%      -0.2        0.66 ±  2%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.34 ±  4%      -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.up_read
      0.14 ±  4%      -0.1        0.09 ±  6%  perf-profile.self.cycles-pp.unlink_file_vma
      0.40 ±  3%      -0.1        0.35 ±  3%  perf-profile.self.cycles-pp.down_read_trylock
      0.17 ±  4%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.folio_unlock
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.dup_fd
      0.08 ±  5%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.fault_dirty_shared_page
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.prctl@plt
      0.08 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.mas_walk
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.mas_pop_node
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.mm_init
      0.05 ±  8%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.xas_descend
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.copy_process
      0.06 ±  6%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.handle_pte_fault
      0.14 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.08 ±  4%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.access_error
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.update_curr
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__put_user_4
      0.04 ± 44%      +0.0        0.06        perf-profile.self.cycles-pp.__reclaim_stacks
      0.04 ± 44%      +0.0        0.06        perf-profile.self.cycles-pp._find_next_or_bit
      0.08            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.mas_wr_append
      0.08 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.exit_mmap
      0.10            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.stress_stackmmap
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.remove_vma
      0.10 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__perf_sw_event
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.do_fault
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.makecontext
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.mas_push_data
      0.08            +0.0        0.10        perf-profile.self.cycles-pp._find_next_bit
      0.08 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.down_read
      0.10            +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.cpu_util
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.msync
      0.06 ±  8%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__free_one_page
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.09 ±  5%      +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_wr_walk
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.pte_offset_map_nolock
      0.08 ±  6%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.mas_find
      0.07 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.mas_mab_cp
      0.21 ±  3%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.mas_topiary_replace
      0.09            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.error_entry
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.10 ±  4%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.copy_p4d_range
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.pcpu_alloc
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.03 ± 70%      +0.0        0.06        perf-profile.self.cycles-pp.mas_wr_bnode
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.mas_store
      0.26 ±  2%      +0.0        0.29 ±  2%  perf-profile.self.cycles-pp.unmap_single_vma
      0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.mab_mas_cp
      0.13 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.copy_page_range
      0.10 ±  3%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.mt_find
      0.10 ±  5%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.10 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.zap_pmd_range
      0.06 ± 11%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.mark_page_accessed
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.free_pgtables
      0.16 ±  4%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.___slab_alloc
      0.14 ±  5%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.mas_update_gap
      0.11            +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.update_load_avg
      0.10            +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.18 ±  4%      +0.0        0.21 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.16 ±  2%      +0.0        0.20 ±  4%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.15 ±  4%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.14 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.__pte_offset_map
      0.13 ±  5%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.08            +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.queued_read_lock_slowpath
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__entry_text_start
      0.15 ±  2%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.18 ±  6%      +0.0        0.22 ±  4%  perf-profile.self.cycles-pp.__libc_fork
      0.07 ± 17%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.____machine__findnew_thread
      0.15 ±  6%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.16 ±  2%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.16 ±  6%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.unmap_page_range
      0.26 ±  3%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.handle_mm_fault
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.perf_swevent_event
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_cfs_group
      0.21 ±  3%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.refill_obj_stock
      0.26            +0.1        0.31 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07 ±  6%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.__vm_area_free
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.mas_ascend
      0.22 ±  2%      +0.1        0.28 ±  4%  perf-profile.self.cycles-pp.acct_collect
      0.20 ±  3%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.01 ±223%      +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.19 ±  3%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.21 ±  3%      +0.1        0.28 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.26 ±  4%      +0.1        0.33 ±  5%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.30 ±  3%      +0.1        0.37 ±  4%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.34 ±  4%      +0.1        0.41 ±  7%  perf-profile.self.cycles-pp.clear_page_erms
      0.18 ±  5%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.20 ±  6%      +0.1        0.27 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.12 ±  3%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.24 ±  2%      +0.1        0.32 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.20 ±  6%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.33            +0.1        0.41        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.27 ±  3%      +0.1        0.36 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
      0.26 ±  4%      +0.1        0.35        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.19 ± 24%      +0.1        0.28 ± 20%  perf-profile.self.cycles-pp.copy_pte_range
      0.22 ±  3%      +0.1        0.31 ±  3%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.31 ±  3%      +0.1        0.40 ±  2%  perf-profile.self.cycles-pp.set_pte_range
      0.34 ±  3%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.33 ±  2%      +0.1        0.44 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.23 ±  8%      +0.1        0.35 ±  4%  perf-profile.self.cycles-pp.__put_anon_vma
      0.60 ±  2%      +0.1        0.72 ±  2%  perf-profile.self.cycles-pp.fput
      0.45 ±  2%      +0.1        0.58 ±  2%  perf-profile.self.cycles-pp.mas_next_slot
      0.33 ±  5%      +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.anon_vma_fork
      0.58 ±  4%      +0.1        0.72 ±  4%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.63 ±  3%      +0.2        0.78 ±  2%  perf-profile.self.cycles-pp.mtree_range_walk
      0.38            +0.2        0.55 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.27 ±  6%      +0.2        0.45 ± 12%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.62 ±  3%      +0.2        0.80 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.88 ±  8%      +0.2        1.07 ±  8%  perf-profile.self.cycles-pp.copy_present_pte
      0.84 ±  3%      +0.2        1.04        perf-profile.self.cycles-pp.native_irq_return_iret
      0.54 ±  8%      +0.2        0.74 ±  8%  perf-profile.self.cycles-pp.free_swap_cache
      0.44 ±  5%      +0.2        0.64 ±  5%  perf-profile.self.cycles-pp.osq_unlock
      0.31 ±  6%      +0.2        0.52 ±  4%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.60 ±  3%      +0.2        0.82 ±  3%  perf-profile.self.cycles-pp.vm_area_dup
      0.48 ±  4%      +0.2        0.70 ±  3%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.85 ±  2%      +0.2        1.08 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.91 ±  3%      +0.2        1.15 ±  2%  perf-profile.self.cycles-pp.sync_regs
      1.18 ±  3%      +0.2        1.42 ±  2%  perf-profile.self.cycles-pp.dup_mmap
      1.00 ±  4%      +0.3        1.27 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      1.68 ±  2%      +0.3        1.96 ±  2%  perf-profile.self.cycles-pp.__slab_free
      1.10 ±  2%      +0.3        1.39 ±  3%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.63 ±  3%      +0.3        0.94 ±  3%  perf-profile.self.cycles-pp.anon_vma_clone
      1.00 ±  3%      +0.3        1.32        perf-profile.self.cycles-pp.mod_objcg_state
      0.54 ±  6%      +0.5        1.00 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.21 ±  3%      +0.5        3.73 ±  2%  perf-profile.self.cycles-pp.next_uptodate_folio
      2.38 ±  2%      +0.6        2.96 ±  3%  perf-profile.self.cycles-pp.down_write
      1.90 ±  7%      +0.6        2.53 ±  7%  perf-profile.self.cycles-pp.zap_pte_range
      2.65 ±  3%      +0.6        3.28        perf-profile.self.cycles-pp.stress_stackmmap_push_msync
      2.18 ±  7%      +0.7        2.87 ±  9%  perf-profile.self.cycles-pp.release_pages
      2.83 ±  3%      +0.9        3.68 ±  3%  perf-profile.self.cycles-pp.up_write
      1.68 ±  2%      +0.9        2.56 ±  5%  perf-profile.self.cycles-pp._compound_head
      2.69 ±  3%      +0.9        3.59 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      2.42 ±  5%      +1.7        4.15 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      3.49 ±  6%      +4.1        7.56 ±  4%  perf-profile.self.cycles-pp.osq_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


