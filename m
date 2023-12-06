Return-Path: <linux-fsdevel+bounces-4925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4E380663F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 05:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E279B20DFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113010783
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kv4y/v16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303BB129;
	Tue,  5 Dec 2023 18:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701830435; x=1733366435;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WuBdFeXfNMShPHYej8vR7gHM8iK9LtrjEbJwB5I9nys=;
  b=Kv4y/v16edCyOtYziM+2EtnGu1yajnGgtedFVU+Wcx4xUl9zPWcUrDvs
   h0N8ZGiwI00N3sB5+x7WaTRPWtBdIpZ5SZgmEhToOB7RWJZJicrRisKd4
   O6Xcfv0L/4FA5vmMbKVli3of1iCJwQASN+on/33ahGu1sT+LOQitUdS80
   9WMy8cklL3SXhrE4rbNwekPtvI8KPZJY1sIEgtnKBmcew4yVClAJ2M9vH
   IH6MFxlUaB3AVmxz+/O86cd8jckNbBKmSN63OxTdcNsh64EeX295bW/ON
   lXlUzI9BLzpnM0v3UIo7G2uEdCDb2CUb/1eGhLc35yNHZgO0O/iK9RFND
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="15544911"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="15544911"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 18:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764549114"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="764549114"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 18:40:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 18:40:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 18:40:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 18:40:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxWhDgJgjF9wH+5ovEsmlv82DHSK8Xh+C1fganciEh7IJEFk/5RoPpdyyETbBUj75zvkOo2Et0dNR9znemHshRdRAldpl7Aec9250HBz+mDu1+DG282//AzvCJTlPCtptP7lPa3wtHOfaC5oSORfkahtN2kT/gmeiwx8Mzsajfx1mHgaMqPL/kUlqz2/urn+Lca9aqjM1AlXGonX6bGAyJmyObY7lP/NXs5W2BY3jl5xAVRs4P1PzpmFcYogJ3W5Y8/ibYSOwv8iUq60uZmdpuEU5Qm/yiAFn6g5GWZxCkL00qJatkFv10eOZvciS5EjSlPJr1TK0A6/uUQQIhmkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW9RwLuKlatQtm7Y5d42W6MCTQM3ei4uBHTj8UpD85o=;
 b=kD9JEWcM/wKGivdRhayw/kzvYEwec5SAoVGTr54MMOtsIJZOgTUnh1VCCv4J0ho9X39l0Wyn+IQXOB3HxIGv/OF6/OXkX08Wp4UL97RnJqyKl2sUhgmyrO/4J6/uCWg+81zA2lFlMHE7xl7lHg5u2NBLJ8A0+1utMiIGQpPxk5s2AImAvuDR7v9ExI8ujBItViAJLsCVI4frWpT76CwDNEKvpGGZF7A6R11ihIijS3zpuB6tYVLR1sm6Zzg/9a9iVs1lTjgRXwTSYote7/pO/Qq2x6oiJgnGCxk+XO6GFC1qwsQI2/ZyjxHR5r6vHT6NKT7zQ9st0Jq5KP9PdDSXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Wed, 6 Dec 2023 02:40:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 02:40:26 +0000
Date: Wed, 6 Dec 2023 10:40:15 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	<linux-doc@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	<oliver.sang@intel.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()]  1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020>
References: <202311300906.1f989fa8-oliver.sang@intel.com>
 <20231130075535.GN38156@ZenIV>
 <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020>
 <20231201040951.GO38156@ZenIV>
 <20231201065602.GP38156@ZenIV>
 <20231201200446.GA1431056@ZenIV>
 <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020>
 <20231204195321.GA1674809@ZenIV>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204195321.GA1674809@ZenIV>
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b31e46-133b-4ca3-3b4c-08dbf604b2c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRAqSj/7qBkxt2BC/AnfU7BR+cnKpDuOAAVf0B0+IzmIHe2OxjX2GYW+Kvc5/V7515FQVcU16yHmv/h5MdLATZIBAnGidNCCg7gqJPgVVs0Vwbv+CO5WbD+/VSKW3csOq7E9BpwSJHptlG7ONqG/DzucP83XzTLQFapmMhOWwFs1/e9ft9KuSKXyXlB90PsndEJMC/B6uK6ahxBpOUICR7dFzz9LwrGtXJGZgNHF9RnHQ2Io4hfJ38/RV93PS62K+jmc/1F9DNkgglSGUCcW+tWkg8E/+J/e9EU43hK1K0pIlyZONjiYJglLmTUy2M4cUbnXP78eSQNHgNH3ibqQQ/Rs4tIG9fq1N6u5g6qN76NOvZXCAEjvIlpy0rmsOZim5/yzO5JcjKzrk4gk2kENqjHVUUOP6XSFAxjuI+MtCRxP2D+b/P5O7LmB6YCC7T/KqfNwuz73zX370hDRgVF3jBVIlpGVy+hl9tCfmllCS7+QXym0vbwb10Je7bkJB7blm+r9hqO/JnU+BoygU7mkWgHuttfEISxd2Y7l+PscUIgoIeWWvMmSSfA03AxUKVMR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(30864003)(38100700002)(5660300002)(2906002)(86362001)(33716001)(44832011)(82960400001)(41300700001)(107886003)(26005)(6666004)(478600001)(6506007)(8676002)(6486002)(9686003)(54906003)(4326008)(66946007)(66556008)(66476007)(83380400001)(8936002)(316002)(6916009)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?iUPaxvlbS4bRQZQpWFeXwTONvUdVQC/gdVXSTX/ILeyTfr75/YqydZjWdw?=
 =?iso-8859-1?Q?35TmBBTLZLpJtFXzxfzCV6AQLJtetTJBKlfAsaSI3YOyoigLhPnYqsZg/7?=
 =?iso-8859-1?Q?alPd0h2bcRzf8C9IEI6ASeSyjpoPXJ5PX3yVhaLus724HsqCNqfgxsHTPN?=
 =?iso-8859-1?Q?UMJPfpqJYzgjhyV1qYsEC6ZZl2K3JUQflBIyrmwu+0VzgzcYY/07d3PQN8?=
 =?iso-8859-1?Q?5ITtTkEaWE9zEeMT0cIIFVgiDDkGvehEkeW5jTGT7h0pM1lmshwadH6lNU?=
 =?iso-8859-1?Q?vYJAAFp1UAofS6/Zq0K6XcUnxIyitV3ZCama99fT3XJ06A/tSv/+dERVzi?=
 =?iso-8859-1?Q?UL0njQPfKPmAMtQr+KRwLbp7eluP1+3TaT0q5a92Q1r+/DSONH15YWuf4w?=
 =?iso-8859-1?Q?KKPXXlD/lDGeZJ0Jx1EFLR6a+9joDg60CcDzwRwGs1qQ8Qoy841QbBdV+g?=
 =?iso-8859-1?Q?J4GwoF8atiLvJKs5eHqxCkBDhp2xYHjbDd7jeaZuQckqdU4kJUYmccsl3j?=
 =?iso-8859-1?Q?f2vVgzdWYJH4R38EPrVohQsN0wpriXaKSFsVjw2zsFJGStKkx3OlglLWs6?=
 =?iso-8859-1?Q?uUASh9UYuRtcl5IQtbtfpEu23e7+b4m/Np1ifTlOlNZ8RSqjSgBMEIQFrR?=
 =?iso-8859-1?Q?SuiGzqc0j+H2R2+8GAFS7qpw99qs3Y4nDdN0A5a7a+RDLTSvkGYO32H6ts?=
 =?iso-8859-1?Q?sFw/BJXI8bhU9sE3Q32kjcKjbBHNwMzfI2sUi3jQmKAYcPsHGPj+lU3MVt?=
 =?iso-8859-1?Q?bJMR5LiRzC+W6OaGLZnl6Qv4RuZkDbblSKlKzldlBrpHX8Ch1CU9BleBnU?=
 =?iso-8859-1?Q?VSCfNyivoQwDysfDiC8RPvhNVjfEBvv6Ls85hlQHspF0dJHGdKVNwXH/eG?=
 =?iso-8859-1?Q?a3qMDBiB+HaWI53HIbb3OS8/lk+SsQtSBEJt/42fRdqs6qhVDTAd3cs7Td?=
 =?iso-8859-1?Q?eioXMq55p3BCQyiNMJHLZ5ZEHgI+5kmCDXIAWNS3EQqVtmlQcVPd34lN3j?=
 =?iso-8859-1?Q?63NQsxQ7ywdw+Wv8HPrCUrM3u+ODB9t1fGTCd0KHPzfl5qdpE7ucq9iDdN?=
 =?iso-8859-1?Q?EYxceV/RI52ui8MNpnJYcGRiNxRHuCSLU88us2gB3KRXGw2hnVIHik8B1s?=
 =?iso-8859-1?Q?pK7bTztqkL7x79dHGmwvPwrWGa8heABehCtZPEQ/0qeOhUCh20SFZux1OC?=
 =?iso-8859-1?Q?5cSStYGT9cU2TcCcX78MdbGPGHo2xZzmgAWGSKLndApzqrDCHJuteoF1zd?=
 =?iso-8859-1?Q?Vx3u0NDswLhFouXEbCnYyNad72mHHf0jzlEUb2Ir7Kzve55jU/xMhV5Upo?=
 =?iso-8859-1?Q?QDoaiO1C0nN0ZUT5Dk5vC6MQ8pcogR0XX0pe0NH5Qpren5DjEZtMip2v4B?=
 =?iso-8859-1?Q?q0j8pihJso67a70XWldVVqgzt2gSfryQBwhzbzpBfPP1rTwf7ThUx/hCEE?=
 =?iso-8859-1?Q?m6rfSHaFey/t3rRwSYGcof8h+6FygPTb6xWVSyXpGCNaRgJRHMy/Ei2C8y?=
 =?iso-8859-1?Q?UEBzl9Fi1zAQuUaYme43xm8g/6ju0KtYagEkVtbBu0hrAUNLkhz6p+VjoS?=
 =?iso-8859-1?Q?uubICdJ/s0zvivQuaIDZ+aYKJ2niZwEg7R3le1IR08wWgmdSlnFSA6yS6a?=
 =?iso-8859-1?Q?YGGQV4ay13jT5ar3GilY/XE9WRV9A3eRFyVbQp2H4VOFXK+cNgGg1ztQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b31e46-133b-4ca3-3b4c-08dbf604b2c1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:40:25.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq39ex45+lx/9wzjTygyjMj7rjsV77KoxNyWpKoZ7tM79XvPHC2271fPz7B3G+hdB5Ob9oSBfzLzwPa1XuJeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
X-OriginatorOrg: intel.com

hi, Al Viro,

On Mon, Dec 04, 2023 at 07:53:21PM +0000, Al Viro wrote:
> On Mon, Dec 04, 2023 at 09:37:45PM +0800, Oliver Sang wrote:
> 
> > > OK, a carved-up series (on top of 1b738f196e^) is in #carved-up-__dentry_kill
> > > That's 9 commits, leading to something close to 1b738f196e+patch you've tested
> > > yesterday; could you profile them on your reproducers?  That might give some
> > > useful information about the nature of the regression...
> > >
> > 
> > we rerun the test and confirmed the regression still exists if comparing
> > 20f7d1936e8a2 (viro-vfs/carved-up-__dentry_kill) step 9: fold decrment of parent's refcount into __dentry_kill()
> > with
> > b4cc0734d2574 d_prune_aliases(): use a shrink list
> > 
> > the data is similar to our previous report.
> > 
> > now we feed the results into our auto-bisect tool and hope to get results later
> 
> Thank you.
>  
> > but due to the limitation such like auto-bisect cannot capture multi commits if
> > they all contribute to the regression, after we get the results from auto
> > bisect, we will check if any further munual efforts needed. Thanks
> 
> My apologies for the number of steps in that ;-/

Not at all! it's always our great pleasure that we could help developers to
root cause problems then improve linux kernel code quality.

> 
> FWIW, what I'm really afraid of is this regression coming from #4; it might mean
> that on some loads shrink_dcache_parent() benefits from evicting a parent while
> it still has children halfway through ->d_iput().
> 
> That should not happen to sillyrenamed children, which is the only case where
> the mainline instances of ->d_iput() currently access the parent, but that
> depends upon too many subtle details spread over too many places ;-/
> 
> Oh, well - let's see what profiles show...  I still hope that it's not where
> the trouble comes from - it would've lead the extra cycles in shrink_dcache_parent()
> or d_walk() called from it and profiles you've posted do not show that, so...
> 

our auto-bisect pointed to
3f99656f7bc2f step 5: call __dentry_kill() without holding a lock on parent

for stress-ng:

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s

commit:
  b4cc0734d2574 ("d_prune_aliases(): use a shrink list")
  7408e24933084 ("step 4: make shrink_kill() keep the parent pinned until after __dentry_kill() of victim")
  3f99656f7bc2f ("step 5: call __dentry_kill() without holding a lock on parent")
  20f7d1936e8a2 ("step 9: fold decrment of parent's refcount into __dentry_kill()")

b4cc0734d25746d4 7408e24933084750710d8187741 3f99656f7bc2f0c2eda8ad5115c 20f7d1936e8a2859fee51273c8f
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
    319870 ±  2%      +0.5%     321475 ±  3%     -30.8%     221219 ±  3%     -26.7%     234578 ±  4%  stress-ng.sysinfo.ops
      5331 ±  2%      +0.5%       5357 ±  3%     -30.8%       3686 ±  3%     -26.7%       3909 ±  4%  stress-ng.sysinfo.ops_per_sec

since 7408e24933084's data is similar to b4cc0734d2574, and 3f99656f7bc2f's data
is similar to 20f7d1936e8a2 (which is a little better here), we guess the
  3f99656f7bc2f step 5: call __dentry_kill() without holding a lock on parent
is the major reason for regression.
so in below [1] full comparison, I just give out profiles of 7408e24933084
and 3f99656f7bc2f. just let us know if you need data for other two commits
or you need more results from other commits in this set.



for unixbench:

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit:
  b4cc0734d2574 ("d_prune_aliases(): use a shrink list")
  7408e24933084 ("step 4: make shrink_kill() keep the parent pinned until after __dentry_kill() of victim")
  3f99656f7bc2f ("step 5: call __dentry_kill() without holding a lock on parent")
  20f7d1936e8a2 ("step 9: fold decrment of parent's refcount into __dentry_kill()")

b4cc0734d25746d4 7408e24933084750710d8187741 3f99656f7bc2f0c2eda8ad5115c 20f7d1936e8a2859fee51273c8f
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     35025            -1.2%      34616           -12.9%      30501           -14.6%      29913        unixbench.score

we saw similar results that 3f99656f7bc2f seems be the major reason for
regression.
in below [2] full comparison, just give results for 7408e24933084 and
3f99656f7bc2f.


[1]

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s

commit:
  7408e24933084 ("step 4: make shrink_kill() keep the parent pinned until after __dentry_kill() of victim")
  3f99656f7bc2f ("step 5: call __dentry_kill() without holding a lock on parent")

7408e24933084750 3f99656f7bc2f0c2eda8ad5115c
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
      0.07 ± 13%      +0.0        0.09 ±  3%  mpstat.cpu.all.soft%
      0.11 ±  4%     -14.1%       0.09 ±  4%  turbostat.IPC
      1652 ± 62%     -72.3%     457.34 ± 58%  sched_debug.cfs_rq:/.avg_vruntime.min
      1652 ± 62%     -72.3%     457.34 ± 58%  sched_debug.cfs_rq:/.min_vruntime.min
    321475 ±  3%     -31.2%     221219 ±  3%  stress-ng.sysinfo.ops
      5357 ±  3%     -31.2%       3686 ±  3%  stress-ng.sysinfo.ops_per_sec
      5189 ± 44%     -78.1%       1138 ±  9%  stress-ng.time.involuntary_context_switches
      5189 ± 44%     -78.1%       1138 ±  9%  time.involuntary_context_switches
      3.29 ±  4%     -27.9%       2.37 ±  4%  time.user_time
    262.33 ±  4%     +31.5%     345.00 ±  6%  time.voluntary_context_switches
      1.63 ±  2%     +11.7%       1.82 ±  4%  perf-stat.i.MPKI
 1.114e+09 ±  3%     -12.3%  9.768e+08 ±  2%  perf-stat.i.branch-instructions
      0.75 ±  4%      +0.0        0.80 ±  3%  perf-stat.i.branch-miss-rate%
   8623818            -6.9%    8027153 ±  3%  perf-stat.i.cache-misses
      3.77 ±  3%     +20.1%       4.52 ±  2%  perf-stat.i.cpi
      2364 ±  2%      +8.4%       2563 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.02 ±  2%      +0.3        0.29 ±206%  perf-stat.i.dTLB-load-miss-rate%
 1.412e+09 ±  3%     -14.1%  1.212e+09 ±  2%  perf-stat.i.dTLB-loads
      0.01 ±  8%      +0.0        0.01 ±  4%  perf-stat.i.dTLB-store-miss-rate%
  6.83e+08 ±  3%     -18.6%  5.558e+08 ±  3%  perf-stat.i.dTLB-stores
 5.544e+09 ±  3%     -13.8%  4.779e+09 ±  2%  perf-stat.i.instructions
      0.29 ±  3%     -13.2%       0.25        perf-stat.i.ipc
    475.41 ±  3%      -6.9%     442.53 ±  2%  perf-stat.i.metric.K/sec
     50.11 ±  3%     -14.5%      42.86 ±  2%  perf-stat.i.metric.M/sec
   4629618            -8.7%    4227531 ±  2%  perf-stat.i.node-load-misses
     86.89            +1.9       88.84        perf-stat.i.node-store-miss-rate%
    473216 ±  4%     -19.4%     381604 ±  5%  perf-stat.i.node-stores
      1.56 ±  3%      +7.9%       1.68 ±  4%  perf-stat.overall.MPKI
      0.88 ±  4%      +0.1        0.97 ±  3%  perf-stat.overall.branch-miss-rate%
      3.60 ±  3%     +16.5%       4.19 ±  2%  perf-stat.overall.cpi
      2308            +8.1%       2495 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.02 ±  2%     +16.7       16.68 ±223%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  8%      +0.0        0.01 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
      0.28 ±  3%     -14.2%       0.24 ±  2%  perf-stat.overall.ipc
     87.67            +1.8       89.52        perf-stat.overall.node-store-miss-rate%
 1.095e+09 ±  3%     -12.3%  9.603e+08 ±  2%  perf-stat.ps.branch-instructions
   8487523            -6.9%    7898469 ±  3%  perf-stat.ps.cache-misses
 1.389e+09 ±  3%     -14.2%  1.192e+09 ±  2%  perf-stat.ps.dTLB-loads
 6.719e+08 ±  3%     -18.6%  5.466e+08 ±  3%  perf-stat.ps.dTLB-stores
 5.452e+09 ±  3%     -13.8%  4.698e+09 ±  2%  perf-stat.ps.instructions
   4557328            -8.7%    4160758 ±  2%  perf-stat.ps.node-load-misses
    464694 ±  4%     -19.4%     374391 ±  5%  perf-stat.ps.node-stores
 3.445e+11 ±  3%     -14.3%  2.952e+11 ±  2%  perf-stat.total.instructions
      0.07 ± 30%     -83.7%       0.01 ± 35%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 20%     -45.4%       0.03 ± 16%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.82 ± 25%     -45.7%       2.62 ± 51%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ±182%     -93.2%       0.01 ± 13%  perf-sched.total_sch_delay.average.ms
      3740 ± 13%     -15.1%       3175 ±  4%  perf-sched.total_wait_and_delay.count.ms
      3832           +14.0%       4367        perf-sched.total_wait_and_delay.max.ms
      3832           +14.0%       4367        perf-sched.total_wait_time.max.ms
      0.30 ± 33%     -95.3%       0.01 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.25 ± 18%     -88.4%       0.03 ± 44%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    423.61 ± 25%     +46.6%     620.91 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     36.33 ± 71%     -92.7%       2.67 ±223%  perf-sched.wait_and_delay.count.__cond_resched.dput.step_into.path_lookupat.filename_lookup
     74.33 ± 60%     -60.8%      29.17 ±  9%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    778.33 ± 34%     -40.1%     466.50 ± 10%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.90 ± 16%     -86.0%       0.13 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      1.10 ± 13%     -65.2%       0.38 ± 69%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3339 ± 31%     +30.1%       4344        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.24 ± 48%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.28 ± 65%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.step_into.path_lookupat
      0.35 ± 43%     -92.6%       0.03 ± 67%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast.walk_component
      0.31 ± 31%     -89.5%       0.03 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.kernfs_iop_permission.inode_permission.link_path_walk
      0.32 ± 23%     -84.8%       0.05 ± 68%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.26 ± 18%     -93.6%       0.02 ± 98%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.28 ± 34%     -91.7%       0.02 ± 33%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.user_statfs.__do_sys_statfs
      0.29 ± 29%     -91.4%       0.03 ± 64%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.vfs_statx.__do_sys_newstat
      0.25 ± 39%     -88.8%       0.03 ± 85%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.30 ± 33%     -85.7%       0.04 ± 60%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.28 ± 21%     -81.7%       0.05 ± 75%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.39 ± 53%     -99.6%       0.00 ±142%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.25 ± 18%     -88.5%       0.03 ± 45%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    423.54 ± 25%     +46.6%     620.89 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.72 ± 54%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.63 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_into.path_lookupat
      0.64 ± 16%     -95.6%       0.03 ± 64%  perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast.walk_component
      0.93 ± 21%     -93.0%       0.07 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_iop_permission.inode_permission.link_path_walk
      0.95 ± 13%     -69.1%       0.29 ± 93%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.82 ± 15%     -95.5%       0.04 ±121%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.78 ±  9%     -94.8%       0.04 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.user_statfs.__do_sys_statfs
      0.80 ± 18%     -93.7%       0.05 ± 90%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.__do_sys_newstat
      0.58 ± 46%     -93.1%       0.04 ± 95%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.90 ± 16%     -75.3%       0.22 ±119%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.88 ± 36%     -99.8%       0.00 ±142%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      1.10 ± 13%     -65.2%       0.38 ± 69%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3339 ± 31%     +30.1%       4344        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     10.79            -9.3        1.50        perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
     18.44            -6.5       11.92        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup
     18.63            -6.2       12.39        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      3.71            -3.0        0.76 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      3.54            -2.8        0.73 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      3.21            -2.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
      3.32            -2.6        0.74 ±  4%  perf-profile.calltrace.cycles-pp.fast_dput.dput.d_alloc_parallel.__lookup_slow.walk_component
      9.11            -2.6        6.55        perf-profile.calltrace.cycles-pp.open64
      9.02            -2.5        6.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      9.00            -2.5        6.48        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      8.98            -2.5        6.47        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      8.97            -2.5        6.46        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.16            -2.5        0.71 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.d_alloc_parallel.__lookup_slow
      3.14            -2.4        0.70 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.d_alloc_parallel
      8.48            -2.4        6.10        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.45            -2.4        6.08        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      7.59            -2.2        5.34        perf-profile.calltrace.cycles-pp.__xstat64
      7.51            -2.2        5.28        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      7.50            -2.2        5.28        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      7.48            -2.2        5.26        perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      7.15            -2.1        5.04        perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      6.38            -1.9        4.51        perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.53            -1.9        4.66        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      6.35            -1.9        4.49        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      7.05 ±  2%      -1.8        5.27        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
      5.86 ±  2%      -1.5        4.32        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup
      5.83 ±  2%      -1.5        4.30        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_lookupat
     31.74            -1.2       30.58        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      3.92 ±  2%      -1.0        2.89        perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      3.16 ±  2%      -0.9        2.22        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      3.16            -0.9        2.29 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.64 ±  4%      -0.8        0.80 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
      1.94            -0.8        1.14 ±  3%  perf-profile.calltrace.cycles-pp.__close
      1.86            -0.8        1.09 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      1.85            -0.8        1.08 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.82            -0.8        1.06 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.20 ±  5%      -0.7        1.48 ±  6%  perf-profile.calltrace.cycles-pp.syscall
      2.11 ±  4%      -0.7        1.42 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      2.10 ±  4%      -0.7        1.41 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.07 ±  4%      -0.7        1.39 ±  5%  perf-profile.calltrace.cycles-pp.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.54            -0.7        0.88 ±  2%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.46            -0.7        1.80 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.44            -0.6        1.79 ±  2%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      2.43            -0.6        1.78 ±  2%  perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_openat.do_filp_open
      1.96 ±  2%      -0.6        1.35        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.12 ±  2%      -0.6        1.54        perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      2.11 ±  2%      -0.6        1.53        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      2.19            -0.6        1.62 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.terminate_walk.path_openat
      1.64 ±  5%      -0.6        1.09 ±  4%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ±  5%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
      1.95 ±  3%      -0.5        1.44        perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      1.96 ±  2%      -0.5        1.47        perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.95 ±  2%      -0.5        1.46        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
      1.96 ±  2%      -0.5        1.47        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
      1.41 ±  2%      -0.5        0.94        perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      1.08 ±  2%      -0.4        0.63 ±  5%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.path_lookupat.filename_lookup
      1.28 ±  4%      -0.4        0.86 ±  7%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      0.79 ±  8%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.shmem_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
      1.02 ± 20%      -0.4        0.66        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      1.12 ±  5%      -0.4        0.77 ±  5%  perf-profile.calltrace.cycles-pp.user_get_super.__do_sys_ustat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.11 ±  4%      -0.3        0.81 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.12 ±  4%      -0.3        0.82 ±  2%  perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
      0.74 ±  4%      -0.3        0.44 ± 44%  perf-profile.calltrace.cycles-pp.__do_sys_fstatfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.97 ±  3%      -0.3        0.68 ±  3%  perf-profile.calltrace.cycles-pp.fstatfs64
      0.90 ±  4%      -0.3        0.64 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty
      0.89 ±  3%      -0.3        0.63 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      0.82 ±  3%      -0.2        0.57 ±  5%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
      0.81 ±  4%      -0.2        0.57 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.79 ±  4%      -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatfs64
      0.48 ± 45%      +0.3        0.78 ±  5%  perf-profile.calltrace.cycles-pp.down_read.walk_component.path_lookupat.filename_lookup.user_path_at_empty
      1.04 ±  2%      +0.5        1.50 ±  4%  perf-profile.calltrace.cycles-pp.lockref_put_return.fast_dput.dput.terminate_walk.path_lookupat
      0.26 ±100%      +0.5        0.73 ± 10%  perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      5.29            +2.1        7.42 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      5.86            +2.3        8.11 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      6.32            +2.3        8.61 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
     17.81            +3.5       21.30        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.terminate_walk
     16.19            +3.5       19.72        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
     16.04            +3.9       19.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.terminate_walk.path_lookupat
     17.24            +4.4       21.60        perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_lookupat.filename_lookup
     12.08            +4.9       16.95        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_lookupat.filename_lookup.user_path_at_empty
     15.15            +4.9       20.10        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty
      1.62 ±  2%      +4.9        6.56        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
     15.19            +5.0       20.14        perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
     10.16            +5.2       15.35        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      9.65 ±  2%      +5.3       14.93        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
      1.70 ±  2%      +5.3        6.98        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.step_into
      1.73 ±  2%      +5.3        7.04        perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.step_into.path_lookupat
      2.08            +5.3        7.42        perf-profile.calltrace.cycles-pp.fast_dput.dput.step_into.path_lookupat.filename_lookup
     10.66            +5.4       16.08        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.path_lookupat
     10.67            +5.4       16.10        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.path_lookupat.filename_lookup
      1.93            +5.6        7.58        perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.path_lookupat
      2.11            +5.9        8.03        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.path_lookupat.filename_lookup
      8.15            +7.7       15.86        perf-profile.calltrace.cycles-pp.step_into.path_lookupat.filename_lookup.user_path_at_empty.user_statfs
     68.43            +7.8       76.19        perf-profile.calltrace.cycles-pp.__statfs
     68.14            +7.8       75.98        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
     68.09            +7.9       75.95        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      7.60            +7.9       15.48        perf-profile.calltrace.cycles-pp.dput.step_into.path_lookupat.filename_lookup.user_path_at_empty
     67.96            +7.9       75.85        perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     67.72            +8.0       75.69        perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
     65.35            +8.7       74.07        perf-profile.calltrace.cycles-pp.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
     63.37            +9.0       72.39        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
     63.20            +9.1       72.28        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs
      7.42            -7.4        0.00        perf-profile.children.cycles-pp.lock_for_kill
     18.48            -6.5       11.95        perf-profile.children.cycles-pp.d_alloc_parallel
     18.66            -6.2       12.42        perf-profile.children.cycles-pp.__lookup_slow
     13.02            -3.7        9.33        perf-profile.children.cycles-pp.link_path_walk
      9.13            -2.6        6.56        perf-profile.children.cycles-pp.open64
      9.18            -2.5        6.66        perf-profile.children.cycles-pp.__x64_sys_openat
      9.17            -2.5        6.65        perf-profile.children.cycles-pp.do_sys_openat2
      8.69            -2.4        6.29        perf-profile.children.cycles-pp.do_filp_open
      8.66            -2.4        6.28        perf-profile.children.cycles-pp.path_openat
      7.63            -2.3        5.36        perf-profile.children.cycles-pp.__xstat64
      7.52            -2.2        5.31        perf-profile.children.cycles-pp.__do_sys_newstat
      7.19            -2.1        5.08        perf-profile.children.cycles-pp.vfs_statx
     33.76            -1.7       32.06        perf-profile.children.cycles-pp.walk_component
      2.91 ±  4%      -1.0        1.95 ±  4%  perf-profile.children.cycles-pp.statfs_by_dentry
      2.61 ±  2%      -0.9        1.70 ±  7%  perf-profile.children.cycles-pp.inode_permission
      1.96            -0.8        1.17 ±  3%  perf-profile.children.cycles-pp.__close
      1.83            -0.8        1.06 ±  2%  perf-profile.children.cycles-pp.__x64_sys_close
      2.24 ±  4%      -0.7        1.50 ±  6%  perf-profile.children.cycles-pp.syscall
      2.07 ±  4%      -0.7        1.39 ±  6%  perf-profile.children.cycles-pp.__do_sys_ustat
      2.10 ±  5%      -0.7        1.43 ±  5%  perf-profile.children.cycles-pp.__percpu_counter_sum
      1.55            -0.7        0.89 ±  2%  perf-profile.children.cycles-pp.__fput
      1.64 ±  3%      -0.6        1.04 ±  9%  perf-profile.children.cycles-pp.kernfs_iop_permission
      1.96 ±  2%      -0.6        1.36        perf-profile.children.cycles-pp.do_open
      2.04 ±  3%      -0.5        1.52 ±  2%  perf-profile.children.cycles-pp.complete_walk
      1.40 ±  3%      -0.5        0.90 ±  3%  perf-profile.children.cycles-pp.lockref_get
      1.42 ±  2%      -0.5        0.95        perf-profile.children.cycles-pp.do_dentry_open
      1.43 ±  2%      -0.5        0.98 ±  6%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.39 ±  7%      -0.4        0.94 ±  7%  perf-profile.children.cycles-pp.shmem_statfs
      0.87 ±  2%      -0.4        0.44 ±  3%  perf-profile.children.cycles-pp.dcache_dir_close
      0.49 ± 18%      -0.4        0.11 ± 27%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.49 ± 18%      -0.4        0.11 ± 27%  perf-profile.children.cycles-pp.ret_from_fork
      0.48 ± 18%      -0.4        0.11 ± 27%  perf-profile.children.cycles-pp.kthread
      1.20 ±  2%      -0.4        0.83 ±  4%  perf-profile.children.cycles-pp.getname_flags
      0.48 ±  7%      -0.4        0.12 ± 12%  perf-profile.children.cycles-pp._raw_spin_trylock
      1.12 ±  5%      -0.4        0.77 ±  5%  perf-profile.children.cycles-pp.user_get_super
      2.30 ±  3%      -0.3        1.98 ±  5%  perf-profile.children.cycles-pp.down_read
      0.99 ±  8%      -0.3        0.66 ±  5%  perf-profile.children.cycles-pp.ext4_statfs
      1.03 ±  3%      -0.3        0.72 ±  2%  perf-profile.children.cycles-pp.fstatfs64
      0.99 ±  2%      -0.3        0.70 ±  3%  perf-profile.children.cycles-pp.try_to_unlazy_next
      0.80 ±  3%      -0.3        0.54 ±  3%  perf-profile.children.cycles-pp.__traverse_mounts
      0.48 ±  3%      -0.3        0.23 ±  5%  perf-profile.children.cycles-pp.path_init
      0.77 ±  2%      -0.2        0.53 ±  5%  perf-profile.children.cycles-pp.strncpy_from_user
      0.42 ±  2%      -0.2        0.18 ±  5%  perf-profile.children.cycles-pp.nd_jump_root
      1.00 ±  2%      -0.2        0.78 ±  5%  perf-profile.children.cycles-pp.up_read
      0.74 ±  4%      -0.2        0.52 ±  3%  perf-profile.children.cycles-pp.__do_sys_fstatfs
      0.66 ±  4%      -0.2        0.46 ±  4%  perf-profile.children.cycles-pp.fd_statfs
      0.79 ±  3%      -0.2        0.60        perf-profile.children.cycles-pp.path_put
      0.62 ±  8%      -0.2        0.43 ±  3%  perf-profile.children.cycles-pp._find_next_or_bit
      0.58 ±  7%      -0.2        0.42 ± 13%  perf-profile.children.cycles-pp.__d_lookup
      0.50 ±  6%      -0.2        0.34 ±  4%  perf-profile.children.cycles-pp.dcache_dir_open
      0.50 ±  6%      -0.2        0.34 ±  4%  perf-profile.children.cycles-pp.d_alloc_cursor
      0.51 ±  4%      -0.2        0.35 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.53 ±  6%      -0.2        0.38 ±  8%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      0.97 ±  3%      -0.1        0.82 ±  6%  perf-profile.children.cycles-pp.__do_softirq
      0.58 ±  8%      -0.1        0.43 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
      0.44 ±  5%      -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.44 ±  5%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.23 ±  3%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp.set_root
      0.39 ±  3%      -0.1        0.27 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      0.24 ±  7%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.security_file_free
      0.24 ±  7%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.44 ±  8%      -0.1        0.34 ±  5%  perf-profile.children.cycles-pp.init_file
      0.56 ±  5%      -0.1        0.46 ± 11%  perf-profile.children.cycles-pp.rcu_core
      0.42 ±  9%      -0.1        0.32 ±  5%  perf-profile.children.cycles-pp.security_file_alloc
      0.31 ±  4%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.55 ±  4%      -0.1        0.46 ± 10%  perf-profile.children.cycles-pp.rcu_do_batch
      0.31 ±  6%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.super_lock
      0.28 ±  4%      -0.1        0.19 ±  9%  perf-profile.children.cycles-pp.open_last_lookups
      0.25 ±  4%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp._copy_to_user
      0.28 ± 43%      -0.1        0.19 ±  6%  perf-profile.children.cycles-pp.menu_select
      0.25 ±  7%      -0.1        0.17 ± 14%  perf-profile.children.cycles-pp.ioctl
      0.15 ± 12%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.lookup_mnt
      0.38 ±  8%      -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.18 ± 10%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.generic_fillattr
      0.21 ± 12%      -0.1        0.13 ± 17%  perf-profile.children.cycles-pp.drop_super
      0.18 ± 11%      -0.1        0.11 ± 10%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.18 ±  4%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.do_statfs_native
      0.18 ±  2%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.generic_permission
      0.13 ± 17%      -0.1        0.07        perf-profile.children.cycles-pp.security_file_open
      0.13 ± 18%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.apparmor_file_open
      0.38 ±  5%      -0.1        0.32 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.18 ±  7%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.check_heap_object
      0.17 ±  2%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.simple_statfs
      0.13 ±  8%      -0.1        0.08 ± 25%  perf-profile.children.cycles-pp.common_perm_cond
      0.15 ±  7%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.filp_flush
      0.15 ±  5%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.vfs_statfs
      0.13 ±  8%      -0.0        0.08 ± 22%  perf-profile.children.cycles-pp.security_inode_getattr
      0.16 ±  8%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.12 ± 11%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.may_open
      0.11 ± 10%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.dnotify_flush
      0.11 ±  3%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__check_heap_object
      0.10 ± 12%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      0.21 ±  7%      -0.0        0.17 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.12 ±  6%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.autofs_d_manage
      0.10 ±  7%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.fsnotify_find_mark
      0.09 ±  9%      -0.0        0.06 ± 16%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.10 ± 12%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.btrfs_statfs
      0.07 ± 15%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.cp_new_stat
      0.34 ±  4%      +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.__d_alloc
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__wake_up
      0.22 ±  8%      +0.1        0.28 ±  9%  perf-profile.children.cycles-pp.__call_rcu_common
      0.06 ± 13%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.___d_drop
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__d_lookup_unhash
      0.97 ±  7%      +0.1        1.09 ±  7%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.04 ± 70%      +0.1        0.17 ± 13%  perf-profile.children.cycles-pp.__d_rehash
      0.64 ± 14%      +0.2        0.85 ±  8%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.16 ± 11%      +0.2        0.41 ±  3%  perf-profile.children.cycles-pp.__d_add
      0.17 ± 10%      +0.3        0.43 ±  3%  perf-profile.children.cycles-pp.simple_lookup
     40.64            +1.4       42.03        perf-profile.children.cycles-pp.dput
     21.24            +2.2       23.42        perf-profile.children.cycles-pp.lockref_get_not_dead
      6.35            +2.3        8.64 ±  2%  perf-profile.children.cycles-pp.d_alloc
     21.51            +2.6       24.11        perf-profile.children.cycles-pp.__legitimize_path
      6.17            +2.9        9.04        perf-profile.children.cycles-pp.__dentry_kill
     20.60            +2.9       23.47        perf-profile.children.cycles-pp.try_to_unlazy
     19.84            +3.7       23.55        perf-profile.children.cycles-pp.terminate_walk
     14.14            +4.3       18.44        perf-profile.children.cycles-pp.lookup_fast
     26.92            +6.0       32.88        perf-profile.children.cycles-pp.fast_dput
     63.66            +6.5       70.15        perf-profile.children.cycles-pp._raw_spin_lock
     59.48            +7.0       66.52        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     69.80            +7.2       76.96        perf-profile.children.cycles-pp.filename_lookup
     69.62            +7.2       76.83        perf-profile.children.cycles-pp.path_lookupat
      9.15            +7.3       16.50        perf-profile.children.cycles-pp.step_into
     68.56            +7.7       76.28        perf-profile.children.cycles-pp.__statfs
     67.97            +7.9       75.86        perf-profile.children.cycles-pp.__do_sys_statfs
     67.73            +8.0       75.70        perf-profile.children.cycles-pp.user_statfs
     65.37            +8.7       74.09        perf-profile.children.cycles-pp.user_path_at_empty
      2.58 ±  2%      -1.0        1.60 ±  4%  perf-profile.self.cycles-pp.lockref_get_not_dead
      4.20 ±  3%      -0.6        3.60 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      1.42 ±  2%      -0.5        0.96 ±  6%  perf-profile.self.cycles-pp.__d_lookup_rcu
      1.32 ±  6%      -0.4        0.88 ±  8%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.48 ±  7%      -0.4        0.12 ± 12%  perf-profile.self.cycles-pp._raw_spin_trylock
      2.25 ±  4%      -0.3        1.94 ±  5%  perf-profile.self.cycles-pp.down_read
      0.82 ±  4%      -0.2        0.58 ±  6%  perf-profile.self.cycles-pp.inode_permission
      0.70 ±  5%      -0.2        0.46 ±  8%  perf-profile.self.cycles-pp.lockref_get
      0.98 ±  3%      -0.2        0.77 ±  5%  perf-profile.self.cycles-pp.up_read
      0.55 ±  5%      -0.2        0.39 ±  3%  perf-profile.self.cycles-pp.user_get_super
      0.40 ±  3%      -0.2        0.25 ±  8%  perf-profile.self.cycles-pp.kmem_cache_free
      0.40 ±  4%      -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.do_dentry_open
      0.47 ±  9%      -0.1        0.33 ±  4%  perf-profile.self.cycles-pp._find_next_or_bit
      0.38 ±  3%      -0.1        0.27 ±  7%  perf-profile.self.cycles-pp.strncpy_from_user
      0.27 ± 10%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.shmem_statfs
      0.24 ±  8%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.30 ±  5%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.26 ±  5%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.link_path_walk
      0.28 ±  5%      -0.1        0.19 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.24 ±  5%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp._copy_to_user
      0.37 ±  8%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.18 ± 10%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.generic_fillattr
      0.19 ±  4%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.statfs_by_dentry
      0.19 ± 10%      -0.1        0.13 ±  9%  perf-profile.self.cycles-pp.step_into
      0.13 ± 18%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.apparmor_file_open
      0.18 ± 11%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.filename_lookup
      0.17 ±  4%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.simple_statfs
      0.14 ±  4%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.generic_permission
      0.34 ±  6%      -0.1        0.29 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.14 ±  3%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.vfs_statfs
      0.12 ±  9%      -0.0        0.07 ± 21%  perf-profile.self.cycles-pp.common_perm_cond
      0.11 ±  9%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__do_sys_statfs
      0.13 ±  2%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.lookup_fast
      0.10 ±  9%      -0.0        0.06 ± 48%  perf-profile.self.cycles-pp.set_root
      0.08 ± 12%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.path_init
      0.12 ± 10%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.10 ±  4%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__check_heap_object
      0.10 ±  9%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.getname_flags
      0.10 ± 11%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.07 ± 11%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.fstatfs64
      0.12 ±  7%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp.__cond_resched
      0.07 ±  8%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__fput
      0.10 ±  8%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.do_syscall_64
      0.07 ± 11%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.check_heap_object
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__d_add
      0.06 ± 13%      +0.1        0.14 ±  7%  perf-profile.self.cycles-pp.___d_drop
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__d_lookup_unhash
      0.95 ±  7%      +0.1        1.08 ±  7%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.04 ± 70%      +0.1        0.17 ± 14%  perf-profile.self.cycles-pp.__d_rehash
      0.52 ±  4%      +0.7        1.20 ±  2%  perf-profile.self.cycles-pp.d_alloc_parallel
     59.18            +6.8       66.01        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



[2]

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit:
  7408e24933084 ("step 4: make shrink_kill() keep the parent pinned until after __dentry_kill() of victim")
  3f99656f7bc2f ("step 5: call __dentry_kill() without holding a lock on parent")

7408e24933084750 3f99656f7bc2f0c2eda8ad5115c
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
  1.25e+08           +16.4%  1.456e+08        cpuidle..usage
      1027 ±  2%     -11.9%     905.50 ±  5%  perf-c2c.DRAM.local
      0.00 ± 39%      -0.0        0.00 ± 38%  mpstat.cpu.all.iowait%
     10.04            -1.2        8.85        mpstat.cpu.all.usr%
    451523           +12.9%     509960        vmstat.system.cs
    265072           +11.5%     295475        vmstat.system.in
 4.848e+08           -12.0%  4.267e+08        numa-numastat.node0.local_node
 4.848e+08           -12.0%  4.267e+08        numa-numastat.node0.numa_hit
 4.813e+08           -11.8%  4.244e+08        numa-numastat.node1.local_node
 4.813e+08           -11.8%  4.244e+08        numa-numastat.node1.numa_hit
 4.848e+08           -12.0%  4.267e+08        numa-vmstat.node0.numa_hit
 4.848e+08           -12.0%  4.267e+08        numa-vmstat.node0.numa_local
 4.813e+08           -11.8%  4.244e+08        numa-vmstat.node1.numa_hit
 4.813e+08           -11.8%  4.244e+08        numa-vmstat.node1.numa_local
    276688 ± 33%     -45.7%     150177 ± 40%  sched_debug.cfs_rq:/.left_vruntime.avg
    276688 ± 33%     -45.7%     150177 ± 40%  sched_debug.cfs_rq:/.right_vruntime.avg
      0.68 ±  4%      -7.2%       0.63        sched_debug.cpu.nr_running.avg
   2122523           +12.9%    2396614        sched_debug.cpu.nr_switches.avg
   2172060           +13.1%    2456552        sched_debug.cpu.nr_switches.max
   2021870           +14.0%    2304304        sched_debug.cpu.nr_switches.min
   9713986            -8.7%    8871130        time.involuntary_context_switches
    926657 ±  6%     -18.4%     756349        time.major_page_faults
 1.404e+09           -12.1%  1.234e+09        time.minor_page_faults
      3760            -4.4%       3596        time.percent_of_cpu_this_job_got
     18300            -2.2%      17905        time.system_time
      5419 ±  3%     -11.6%       4787        time.user_time
 1.365e+08           +16.2%  1.586e+08        time.voluntary_context_switches
 1.247e+08           +16.4%  1.452e+08        turbostat.C1
     37.18            +2.2       39.42        turbostat.C1%
      0.20 ± 10%     -11.5%       0.18        turbostat.IPC
 1.696e+08           +11.3%  1.888e+08        turbostat.IRQ
      2.30 ± 14%      -2.3        0.00        turbostat.PKG_%
    272791 ±  2%     +15.5%     315203        turbostat.POLL
    391.76            -2.3%     382.81        turbostat.PkgWatt
     83.31            -2.0%      81.65        turbostat.RAMWatt
     34616           -11.9%      30501        unixbench.score
   9713986            -8.7%    8871130        unixbench.time.involuntary_context_switches
    926657 ±  6%     -18.4%     756349        unixbench.time.major_page_faults
 1.404e+09           -12.1%  1.234e+09        unixbench.time.minor_page_faults
      3760            -4.4%       3596        unixbench.time.percent_of_cpu_this_job_got
     18300            -2.2%      17905        unixbench.time.system_time
      5419 ±  3%     -11.6%       4787        unixbench.time.user_time
 1.365e+08           +16.2%  1.586e+08        unixbench.time.voluntary_context_switches
  92541079           -11.9%   81517788        unixbench.workload
    528441            +3.5%     547099        proc-vmstat.nr_active_anon
   1256553            +1.5%    1275361        proc-vmstat.nr_file_pages
    550865            +3.4%     569839        proc-vmstat.nr_shmem
    528441            +3.5%     547099        proc-vmstat.nr_zone_active_anon
 9.661e+08           -11.9%  8.511e+08        proc-vmstat.numa_hit
 9.661e+08           -11.9%   8.51e+08        proc-vmstat.numa_local
   1788398            -9.2%    1624636 ±  5%  proc-vmstat.pgactivate
  1.02e+09           -11.9%   8.99e+08        proc-vmstat.pgalloc_normal
 1.409e+09           -12.1%  1.239e+09        proc-vmstat.pgfault
  1.02e+09           -11.9%  8.982e+08        proc-vmstat.pgfree
  55462844           -11.9%   48868253        proc-vmstat.pgreuse
     48536           -11.7%      42839        proc-vmstat.thp_fault_alloc
  20464348           -11.9%   18032977        proc-vmstat.unevictable_pgs_culled
      2.87            +4.5%       3.00        perf-stat.i.MPKI
 1.718e+10           -10.4%   1.54e+10        perf-stat.i.branch-instructions
      1.79            +0.0        1.82        perf-stat.i.branch-miss-rate%
 3.112e+08            -8.6%  2.844e+08        perf-stat.i.branch-misses
 2.514e+08            -6.6%  2.348e+08        perf-stat.i.cache-misses
 1.162e+09            -6.0%  1.093e+09        perf-stat.i.cache-references
    453809           +12.9%     512466        perf-stat.i.context-switches
      1.77            +8.1%       1.91        perf-stat.i.cpi
 1.474e+11            -3.1%  1.427e+11        perf-stat.i.cpu-cycles
    121183            +2.3%     123978        perf-stat.i.cpu-migrations
  17111183 ±  5%     -10.3%   15342429 ±  3%  perf-stat.i.dTLB-load-misses
 2.127e+10           -10.5%  1.905e+10        perf-stat.i.dTLB-loads
      0.12            -0.0        0.12        perf-stat.i.dTLB-store-miss-rate%
  14111418 ±  2%     -11.4%   12500877        perf-stat.i.dTLB-store-misses
 1.149e+10            -9.4%  1.041e+10        perf-stat.i.dTLB-stores
 8.519e+10           -10.7%  7.608e+10        perf-stat.i.instructions
      0.57            -7.7%       0.53        perf-stat.i.ipc
      1468 ±  6%     -18.4%       1198        perf-stat.i.major-faults
      2.30            -3.1%       2.23        perf-stat.i.metric.GHz
      2431            -8.0%       2236        perf-stat.i.metric.K/sec
    798.35           -10.1%     717.71        perf-stat.i.metric.M/sec
   2188739           -12.1%    1923948        perf-stat.i.minor-faults
  54474911            -6.5%   50932514        perf-stat.i.node-load-misses
   6922180            -9.7%    6252471        perf-stat.i.node-loads
     37.41            +0.9       38.30        perf-stat.i.node-store-miss-rate%
  27678436            -5.9%   26045646        perf-stat.i.node-store-misses
  45787892            -9.9%   41263768        perf-stat.i.node-stores
   2190208           -12.1%    1925146        perf-stat.i.page-faults
      2.95            +4.6%       3.08        perf-stat.overall.MPKI
      1.81            +0.0        1.85        perf-stat.overall.branch-miss-rate%
      1.73            +8.5%       1.88        perf-stat.overall.cpi
    586.28            +3.7%     608.14        perf-stat.overall.cycles-between-cache-misses
      0.12            -0.0        0.12        perf-stat.overall.dTLB-store-miss-rate%
      0.58            -7.8%       0.53        perf-stat.overall.ipc
     37.66            +1.0       38.68        perf-stat.overall.node-store-miss-rate%
    580977            +1.4%     588977        perf-stat.overall.path-length
 1.716e+10           -10.4%  1.538e+10        perf-stat.ps.branch-instructions
 3.109e+08            -8.6%  2.841e+08        perf-stat.ps.branch-misses
  2.51e+08            -6.6%  2.344e+08        perf-stat.ps.cache-misses
 1.161e+09            -6.0%  1.092e+09        perf-stat.ps.cache-references
    453225           +12.9%     511681        perf-stat.ps.context-switches
 1.472e+11            -3.1%  1.425e+11        perf-stat.ps.cpu-cycles
    121040            +2.3%     123806        perf-stat.ps.cpu-migrations
  17120012 ±  5%     -10.4%   15346813 ±  3%  perf-stat.ps.dTLB-load-misses
 2.125e+10           -10.5%  1.903e+10        perf-stat.ps.dTLB-loads
  14095865 ±  2%     -11.4%   12484963        perf-stat.ps.dTLB-store-misses
 1.148e+10            -9.4%   1.04e+10        perf-stat.ps.dTLB-stores
  8.51e+10           -10.7%    7.6e+10        perf-stat.ps.instructions
      1467 ±  6%     -18.4%       1197        perf-stat.ps.major-faults
   2186107           -12.1%    1921281        perf-stat.ps.minor-faults
  54378641            -6.5%   50836612        perf-stat.ps.node-load-misses
   6931517            -9.7%    6257953        perf-stat.ps.node-loads
  27629196            -5.9%   25995922        perf-stat.ps.node-store-misses
  45733344            -9.9%   41207111        perf-stat.ps.node-stores
   2187574           -12.1%    1922478        perf-stat.ps.page-faults
 5.376e+13           -10.7%  4.801e+13        perf-stat.total.instructions
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__dentry_kill.dput.d_alloc_parallel.lookup_open
      0.02 ± 10%     -29.3%       0.02 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.02 ± 16%     +80.3%       0.04 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.03 ± 12%     -28.7%       0.02 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.02 ±  9%     -30.4%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.02 ±  5%     -27.7%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ± 16%     -31.0%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.02 ±  2%     -25.5%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.02 ±  3%     -25.0%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  6%     -33.8%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.02 ±  3%     -12.1%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.01 ±  7%     -21.1%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.01 ±  5%     -23.9%       0.01        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  6%     -37.6%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.70 ± 51%     -63.3%       0.26 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.01 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_parallel.lookup_open
      0.13 ± 92%     -95.1%       0.01 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.step_into.open_last_lookups
      0.00 ± 11%   +1488.9%       0.07 ±147%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_phdrs.load_elf_binary
      1.42 ± 14%     -38.4%       0.88 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      1.19 ± 11%     -42.0%       0.69 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.82 ± 51%     -76.5%       0.19 ±120%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.93 ± 45%     -59.4%       0.38 ± 72%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      1.29 ± 20%     -47.7%       0.68 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      5.49 ±203%     -96.9%       0.17 ±118%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      1.64 ±  9%     -28.3%       1.18 ±  6%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      0.02           -14.8%       0.02 ±  2%  perf-sched.total_sch_delay.average.ms
   1399213           +10.9%    1551614        perf-sched.total_wait_and_delay.count.ms
      3.04 ± 65%    +169.4%       8.19 ± 35%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      1.77 ± 50%    +126.9%       4.02 ± 31%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      6.75 ± 35%     -60.7%       2.66 ± 59%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      3.52           +15.9%       4.08        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.52           +11.3%       7.26        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.95           +20.1%       2.34        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.27           -13.5%       0.23        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.25            -9.8%       0.22        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.24           -15.3%       0.20        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.16           -14.8%       0.14        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.31 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.12 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.25 ±  2%     -11.6%       0.22 ±  3%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
    102.00 ±  8%     -27.0%      74.50 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    145.83 ±  8%     -25.5%     108.67 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
    690.83 ±  5%     -29.4%     487.83 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      4073 ±  2%     -16.4%       3405 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     43913           -10.9%      39124        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    457.67 ±  6%     -14.2%     392.50 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
    834.33 ±  5%     -12.9%     726.33 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     94893            -8.7%      86654        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     75154            -9.0%      68398        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     39713           -19.5%      31976        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    555.50            +8.4%     602.33 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    785791           +27.5%    1002084        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
     13112 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
     14862 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
     21158            -8.7%      19322        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10536            -8.7%       9621        perf-sched.wait_and_delay.count.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.18 ±142%    +334.5%       9.49 ± 13%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     26.27 ± 18%     -73.7%       6.90 ± 55%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.path_put.exit_fs.do_exit
     33.94 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      4.48 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.20 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.d_alloc_parallel.lookup_open
      3.22 ± 53%    +154.2%       8.18 ± 35%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      0.20 ±  2%     -15.7%       0.16 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
      0.23 ±  5%     -14.8%       0.20 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.isra.0.change_protection_range
      0.21 ±  3%     -10.9%       0.19 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.22 ±  2%     -15.0%       0.19        perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      2.01 ± 23%     +99.6%       4.01 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.22 ±  3%     -13.4%       0.19 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      1.25 ± 38%     +76.7%       2.21 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.21 ±  8%     -12.8%       0.18 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
      0.27 ±  5%     -23.8%       0.20 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      6.74 ± 35%     -60.3%       2.67 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      0.23           -12.2%       0.20        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.23 ±  6%     -14.7%       0.19 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.24 ± 14%     -15.6%       0.20 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.21           -11.8%       0.19 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.22 ±  5%     -13.9%       0.19 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.28 ± 19%     -32.5%       0.19 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.17 ±  7%     -20.2%       0.14 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.23 ±  3%     -11.9%       0.20 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.26 ±  6%     -25.4%       0.19 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.21 ±  3%     -14.8%       0.18 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.24 ±  5%     -12.0%       0.21 ±  3%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      3.49           +16.1%       4.05        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.49           +11.4%       7.23        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.14 ±  3%     -14.8%       0.12 ±  2%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1.93           +20.5%       2.33        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.24           -11.6%       0.22        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.23            -9.6%       0.21        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.23           -14.9%       0.20        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.15           -14.2%       0.13        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.12 ±  4%     -22.8%       0.09 ±  8%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.23 ±  2%      -9.3%       0.21 ±  3%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ± 39%     -52.5%       0.28 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_cow_fault
      1.03 ± 22%     -72.8%       0.28 ± 38%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.30 ± 26%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_parallel.lookup_open
      0.53 ± 32%     -57.0%       0.23 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_into.open_last_lookups
     19.69 ± 50%     +69.8%      33.42 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     26.26 ± 18%     -73.6%       6.93 ± 54%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      0.72 ± 37%     -57.2%       0.31 ± 50%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      3.46 ± 32%     -68.6%       1.08 ± 84%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.67 ± 36%     -58.9%       0.28 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.do_brk_flags.__do_sys_brk
      1.57 ± 19%     -40.0%       0.94 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      6.77 ± 48%     -49.6%       3.41 ± 64%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     15.12 ±  6%      -6.2        8.89 ±  5%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.86 ±  6%      -6.2        8.66 ±  6%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     13.59 ±  7%      -6.0        7.55 ±  6%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.57 ±  7%      -6.0        7.53 ±  6%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.80 ±  8%      -4.8        5.03 ± 12%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      7.25 ± 10%      -4.5        2.75 ± 19%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
      6.60 ± 10%      -4.4        2.23 ± 11%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
      8.91 ±  8%      -4.0        4.86 ±  7%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      5.68 ± 10%      -3.7        1.94 ± 10%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      5.25 ±  9%      -3.1        2.20 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
      5.65 ±  7%      -2.5        3.13 ±  7%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      5.03 ±  8%      -2.4        2.61 ±  8%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      4.62 ±  9%      -2.4        2.26 ±  9%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      4.58 ±  9%      -2.4        2.22 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      3.77 ±  9%      -2.3        1.45 ±  9%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      3.74 ± 10%      -2.3        1.43 ± 28%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
      3.70 ±  9%      -2.3        1.42 ±  9%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      3.63 ±  9%      -2.2        1.39 ±  9%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
      3.60 ±  9%      -2.2        1.37 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.unmap_region
      3.98 ±  8%      -2.2        1.77 ± 21%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      3.86 ± 10%      -2.2        1.68 ± 22%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      9.66            -2.2        7.50        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.66            -2.2        7.50        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.66            -2.2        7.50        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.13 ±  2%      -2.1        6.04 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      8.12 ±  2%      -2.1        6.03 ±  2%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      8.10 ±  2%      -2.1        6.01 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      8.78            -1.8        6.94        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.19            -1.8        7.40        perf-profile.calltrace.cycles-pp.execve
      9.18            -1.8        7.39        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      9.18            -1.8        7.39        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      9.18            -1.8        7.39        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      9.17            -1.8        7.38        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      8.19            -1.8        6.41        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      8.18            -1.8        6.40        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      8.08            -1.8        6.32        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      3.86 ±  5%      -1.6        2.25 ±  2%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      4.39 ±  2%      -1.6        2.84        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      7.98 ±  4%      -1.5        6.43 ±  2%  perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      3.53 ±  6%      -1.5        2.02 ±  2%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      4.68 ±  4%      -1.5        3.18 ±  8%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.81 ±  6%      -1.5        2.31 ±  5%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      4.13 ±  5%      -1.4        2.70        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      3.03 ±  8%      -1.4        1.64 ±  8%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      2.58 ± 10%      -1.3        1.24 ± 10%  perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      2.55 ± 10%      -1.3        1.21 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      2.52 ± 10%      -1.3        1.19 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
      2.32 ± 10%      -1.3        1.05 ± 10%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
      3.66 ±  8%      -1.2        2.46        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      3.68 ±  8%      -1.2        2.48        perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      4.81 ±  3%      -1.1        3.66        perf-profile.calltrace.cycles-pp.__libc_fork
      4.26 ±  3%      -1.1        3.17        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.26 ±  3%      -1.1        3.18        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.26 ±  3%      -1.1        3.17        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      4.26 ±  3%      -1.1        3.18        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      7.19            -1.0        6.23        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.22 ± 15%      -0.9        0.29 ±100%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap
      6.54            -0.9        5.66        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      6.50            -0.9        5.62        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.75            -0.8        4.95        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.48            -0.8        4.71        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.49 ± 14%      -0.8        0.73 ±  9%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      1.41 ± 14%      -0.7        0.66 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
      1.39 ± 14%      -0.7        0.65 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
      1.74 ±  6%      -0.7        1.01 ±  5%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
      1.27 ±  8%      -0.7        0.60 ±  8%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exec_mmap
      3.57            -0.5        3.07        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.05 ±  9%      -0.5        0.55 ±  8%  perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      1.75 ±  3%      -0.5        1.28 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75 ±  3%      -0.5        1.28 ±  3%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.28 ±  5%      -0.5        0.81 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ±  5%      -0.5        0.80 ±  5%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.20 ±  5%      -0.5        0.75 ±  5%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.24            -0.5        2.79        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.60 ±  3%      -0.5        1.15 ±  3%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ±  4%      -0.4        1.03 ±  4%  perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      3.07            -0.4        2.64        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.43 ±  4%      -0.4        1.00 ±  4%  perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.99 ±  6%      -0.4        0.62 ±  6%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      2.81 ±  2%      -0.4        2.45        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      2.64 ±  2%      -0.3        2.30        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      0.59 ±  2%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.31 ±  3%      -0.3        1.01        perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      1.30 ±  3%      -0.3        1.00        perf-profile.calltrace.cycles-pp.elf_load.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm
      2.23 ±  2%      -0.3        1.95        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      1.29            -0.3        1.02 ±  2%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.10 ±  2%      -0.3        1.83        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.30            -0.3        1.03 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80            -0.3        1.55        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.59 ±  2%      -0.2        1.37        perf-profile.calltrace.cycles-pp.setlocale
      1.32 ±  2%      -0.2        1.11 ±  2%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.30 ±  2%      -0.2        1.08 ±  2%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      1.75 ±  2%      -0.2        1.54        perf-profile.calltrace.cycles-pp.__mmap
      0.76 ±  4%      -0.2        0.55 ±  2%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.76 ±  4%      -0.2        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.72 ±  2%      -0.2        1.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.72 ±  2%      -0.2        1.52        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.69 ±  2%      -0.2        1.49        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.67 ±  2%      -0.2        1.47        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.82 ±  5%      -0.2        0.63 ±  2%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary
      0.84 ±  5%      -0.2        0.66 ±  2%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_interp.load_elf_binary.search_binary_handler
      1.03 ±  2%      -0.2        0.85 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.79 ±  5%      -0.2        0.61 ±  2%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf_load.load_elf_interp
      0.63 ±  2%      -0.2        0.45 ± 44%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.63 ±  2%      -0.2        0.45 ± 44%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups.path_openat
      0.60            -0.2        0.44 ± 44%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.60 ±  2%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.83 ±  2%      -0.2        0.67 ±  2%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.58 ±  2%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp._IO_default_xsputn
      1.04 ±  2%      -0.1        0.90        perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      1.00 ±  2%      -0.1        0.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.00 ±  2%      -0.1        0.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.99 ±  2%      -0.1        0.85        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.99 ±  2%      -0.1        0.85        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      1.37 ±  2%      -0.1        1.24        perf-profile.calltrace.cycles-pp._dl_addr
      1.00 ±  3%      -0.1        0.88 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.00 ±  3%      -0.1        0.88 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.78 ±  2%      -0.1        0.67 ±  2%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.97 ±  3%      -0.1        0.86 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.71            -0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.wait4
      0.87 ±  2%      -0.1        0.77        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.70            -0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.70            -0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.80 ±  3%      -0.1        0.70 ±  4%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.82 ±  2%      -0.1        0.72 ±  2%  perf-profile.calltrace.cycles-pp.elf_load.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.78 ±  2%      -0.1        0.69        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exec_mmap
      0.72            -0.1        0.62 ±  2%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.69 ±  2%      -0.1        0.60 ±  4%  perf-profile.calltrace.cycles-pp.down_read.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.68 ±  2%      -0.1        0.58 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.open_last_lookups.path_openat.do_filp_open
      0.80 ±  2%      -0.1        0.71        perf-profile.calltrace.cycles-pp.__strcoll_l
      0.73 ±  2%      -0.1        0.66        perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.66 ±  2%      -0.1        0.59 ±  2%  perf-profile.calltrace.cycles-pp.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96            +0.1        1.01        perf-profile.calltrace.cycles-pp.open64
      0.94            +0.1        1.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.94            +0.1        1.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.94            +0.1        0.99        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.93            +0.1        0.99        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.69 ±  3%      +0.1        0.79        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
      0.69 ±  3%      +0.1        0.79        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.69 ±  3%      +0.1        0.80        perf-profile.calltrace.cycles-pp.unlinkat
      0.68 ±  3%      +0.1        0.79        perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.68 ±  3%      +0.1        0.79        perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.61 ±  2%      +0.1        0.75        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.64 ±  2%      +0.1        0.77        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.76            +0.2        0.92        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      1.38 ±  3%      +0.2        1.55        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat
      0.73 ±  6%      +0.2        0.92 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.44 ± 44%      +0.2        0.63        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.70 ±  6%      +0.2        0.89 ±  3%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
      0.70 ±  6%      +0.2        0.89 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.70 ±  6%      +0.2        0.89 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
      1.41 ±  3%      +0.2        1.61        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup
      1.59 ±  2%      +0.2        1.80        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.69 ±  5%      +0.3        0.98 ±  3%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.71 ±  6%      +0.3        1.00 ±  3%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.94 ±  2%      +0.4        2.33 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      2.69            +0.4        3.10        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.80            +0.4        3.23        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.79            +0.4        3.22        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.03            +0.4        3.47        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.28 ±  2%      +0.5        1.74 ±  8%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      3.63            +0.5        4.09        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.62            +0.5        4.09        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.62            +0.5        4.08        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.30 ±  5%      +0.5        2.78 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
      3.68            +0.5        4.16        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      2.41 ±  5%      +0.5        2.90 ±  3%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      2.36 ±  5%      +0.5        2.85 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      0.17 ±141%      +0.5        0.67 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      1.42 ±  2%      +0.5        1.92 ±  7%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      2.25 ±  5%      +0.5        2.76 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.d_alloc_parallel.__lookup_slow
      1.44 ±  3%      +0.5        1.95 ±  7%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      2.24 ±  5%      +0.5        2.76 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.d_alloc_parallel
      2.30 ±  5%      +0.5        2.81 ±  2%  perf-profile.calltrace.cycles-pp.fast_dput.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_lookupat.filename_lookup
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      2.19 ±  2%      +0.6        2.78 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      2.43            +0.6        3.02        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00            +0.6        0.64 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open
      0.00            +0.7        0.65 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
      0.00            +0.7        0.67 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.open_last_lookups
      1.91 ±  2%      +0.7        2.59 ±  7%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.00            +0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.open_last_lookups.path_openat
      0.00            +0.7        0.68 ±  4%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.step_into.open_last_lookups
      0.00            +0.7        0.72 ±  4%  perf-profile.calltrace.cycles-pp.fast_dput.dput.step_into.open_last_lookups.path_openat
      0.70 ±  3%      +0.7        1.44 ±  3%  perf-profile.calltrace.cycles-pp.step_into.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.66 ±  3%      +0.7        1.40 ±  3%  perf-profile.calltrace.cycles-pp.dput.step_into.open_last_lookups.path_openat.do_filp_open
      2.09 ±  2%      +0.7        2.84 ±  7%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled
      2.12 ±  3%      +0.8        2.88 ±  7%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath
      2.84 ±  2%      +0.8        3.64 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.71 ±  2%      +0.8        3.54 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.71 ±  2%      +0.8        3.53 ±  2%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.69 ±  2%      +0.8        3.52 ±  2%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      2.90 ±  2%      +1.0        3.85 ±  6%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      2.90 ±  2%      +1.0        3.86 ±  6%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk
      3.16 ±  2%      +1.1        4.25 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk.path_openat
      3.23 ±  2%      +1.1        4.36 ±  5%  perf-profile.calltrace.cycles-pp.down_read.walk_component.link_path_walk.path_openat.do_filp_open
      3.68 ±  3%      +1.2        4.87 ±  2%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     10.39 ±  4%      +1.7       12.08 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
     10.46 ±  4%      +1.8       12.23 ±  2%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
      2.10 ±  4%      +2.5        4.64 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      1.84 ±  4%      +2.6        4.41 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      1.79 ±  4%      +2.6        4.44 ±  5%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      2.29 ±  5%      +2.7        5.03 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
      2.34 ±  4%      +2.7        5.09 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
      2.64 ±  4%      +2.8        5.43 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      0.00            +2.8        2.81 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.step_into.link_path_walk
      0.00            +2.8        2.83 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
      0.00            +2.9        2.90 ±  3%  perf-profile.calltrace.cycles-pp.fast_dput.dput.step_into.link_path_walk.path_openat
      0.00            +2.9        2.94 ±  3%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_openat
      1.83 ±  4%      +3.0        4.83 ±  5%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      2.97 ±  4%      +3.2        6.15 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.terminate_walk
      2.99 ±  4%      +3.2        6.18 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.terminate_walk.path_openat
      3.11 ±  4%      +3.2        6.35 ±  3%  perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_openat.do_filp_open
      3.11 ±  4%      +3.2        6.36 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      3.13 ±  4%      +3.2        6.38 ±  3%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.76 ±  3%      +3.3        6.06 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      0.00            +3.4        3.37 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
      3.02 ±  3%      +3.4        6.46 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      0.00            +3.5        3.50 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fast_dput.dput.step_into
      1.37 ±  2%      +4.5        5.85 ±  3%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      1.40 ±  3%      +4.5        5.88 ±  3%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
     58.00            +5.1       63.08        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     57.97            +5.1       63.06        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.92 ±  3%      +5.5       21.40        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
     17.45 ±  3%      +9.9       27.40        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     26.90 ±  3%     +14.0       40.88        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.82 ±  3%     +14.0       40.81        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     25.79 ±  3%     +14.0       39.79        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.76 ±  3%     +14.0       39.78        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.88 ±  9%      -9.7       10.14 ±  8%  perf-profile.children.cycles-pp.down_write
     19.07 ±  9%      -9.6        9.45 ±  9%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     18.52 ± 10%      -9.5        9.01 ±  9%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     16.66 ± 10%      -9.0        7.62 ± 10%  perf-profile.children.cycles-pp.osq_lock
     17.99 ±  5%      -7.0       11.01 ±  5%  perf-profile.children.cycles-pp.vm_mmap_pgoff
     17.78 ±  6%      -7.0       10.82 ±  5%  perf-profile.children.cycles-pp.do_mmap
     17.43 ±  6%      -6.9       10.51 ±  5%  perf-profile.children.cycles-pp.mmap_region
     15.28 ±  6%      -6.2        9.03 ±  5%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
     10.95 ±  7%      -4.6        6.30 ±  6%  perf-profile.children.cycles-pp.do_vmi_munmap
     10.86 ±  7%      -4.6        6.22 ±  6%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      9.79 ±  7%      -4.3        5.49 ±  6%  perf-profile.children.cycles-pp.free_pgtables
      8.40 ±  9%      -4.1        4.30 ±  8%  perf-profile.children.cycles-pp.unlink_file_vma
      7.14 ±  8%      -3.3        3.82 ±  7%  perf-profile.children.cycles-pp.vma_prepare
     12.04 ±  2%      -3.2        8.84 ±  2%  perf-profile.children.cycles-pp.__mmput
     12.00 ±  2%      -3.2        8.80 ±  2%  perf-profile.children.cycles-pp.exit_mmap
      7.45 ±  6%      -3.0        4.43 ±  5%  perf-profile.children.cycles-pp.__split_vma
      9.82            -2.2        7.63        perf-profile.children.cycles-pp.do_exit
      9.83            -2.2        7.64        perf-profile.children.cycles-pp.__x64_sys_exit_group
      9.82            -2.2        7.64        perf-profile.children.cycles-pp.do_group_exit
      8.15 ±  2%      -2.1        6.05 ±  2%  perf-profile.children.cycles-pp.exit_mm
     10.48            -2.1        8.42        perf-profile.children.cycles-pp.__x64_sys_execve
     10.46            -2.1        8.41        perf-profile.children.cycles-pp.do_execveat_common
      4.54 ±  7%      -2.0        2.52 ±  6%  perf-profile.children.cycles-pp.unmap_region
      8.85            -1.9        6.99        perf-profile.children.cycles-pp.bprm_execve
      9.19            -1.8        7.40        perf-profile.children.cycles-pp.execve
      8.19            -1.8        6.42        perf-profile.children.cycles-pp.exec_binprm
      8.18            -1.8        6.40        perf-profile.children.cycles-pp.search_binary_handler
      8.08            -1.8        6.32        perf-profile.children.cycles-pp.load_elf_binary
     10.22            -1.4        8.85        perf-profile.children.cycles-pp.asm_exc_page_fault
      5.43 ±  3%      -1.3        4.09        perf-profile.children.cycles-pp.kernel_clone
      5.02 ±  3%      -1.3        3.72        perf-profile.children.cycles-pp.__do_sys_clone
      4.90 ±  3%      -1.3        3.63        perf-profile.children.cycles-pp.copy_process
      9.19            -1.3        7.94        perf-profile.children.cycles-pp.exc_page_fault
      9.15            -1.2        7.90        perf-profile.children.cycles-pp.do_user_addr_fault
      3.86 ±  5%      -1.2        2.64 ±  2%  perf-profile.children.cycles-pp.dup_mm
      4.40            -1.2        3.23        perf-profile.children.cycles-pp.begin_new_exec
      8.39            -1.2        7.22        perf-profile.children.cycles-pp.handle_mm_fault
      3.54 ±  6%      -1.2        2.38 ±  2%  perf-profile.children.cycles-pp.dup_mmap
      4.85 ±  3%      -1.2        3.69        perf-profile.children.cycles-pp.__libc_fork
      4.22 ±  2%      -1.1        3.07        perf-profile.children.cycles-pp.exec_mmap
      8.01            -1.1        6.89        perf-profile.children.cycles-pp.__handle_mm_fault
      5.27            -0.7        4.52        perf-profile.children.cycles-pp.do_fault
      4.83            -0.7        4.14        perf-profile.children.cycles-pp.do_read_fault
      4.66            -0.7        4.00        perf-profile.children.cycles-pp.filemap_map_pages
      1.09 ±  8%      -0.5        0.58 ±  7%  perf-profile.children.cycles-pp.vma_expand
      1.75 ±  3%      -0.5        1.28 ±  3%  perf-profile.children.cycles-pp.do_mprotect_pkey
      1.75 ±  3%      -0.5        1.28 ±  3%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      1.61 ±  3%      -0.5        1.16 ±  3%  perf-profile.children.cycles-pp.mprotect_fixup
      2.38 ±  2%      -0.4        1.94        perf-profile.children.cycles-pp.elf_load
      1.46 ±  4%      -0.4        1.03 ±  4%  perf-profile.children.cycles-pp.vma_modify
      3.43 ±  2%      -0.4        3.00        perf-profile.children.cycles-pp.unmap_vmas
      3.17 ±  2%      -0.4        2.77        perf-profile.children.cycles-pp.unmap_page_range
      2.74            -0.4        2.34        perf-profile.children.cycles-pp.next_uptodate_folio
      3.07 ±  2%      -0.4        2.68        perf-profile.children.cycles-pp.zap_pmd_range
      3.02 ±  2%      -0.4        2.63        perf-profile.children.cycles-pp.zap_pte_range
      1.52 ±  2%      -0.4        1.15 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.45 ±  4%      -0.3        1.12        perf-profile.children.cycles-pp.load_elf_interp
      2.06 ±  2%      -0.3        1.74 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.86 ±  2%      -0.3        1.56 ±  2%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      1.54 ±  2%      -0.3        1.28 ±  2%  perf-profile.children.cycles-pp.release_pages
      1.60 ±  2%      -0.2        1.38        perf-profile.children.cycles-pp.setlocale
      1.80            -0.2        1.59        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.66 ±  2%      -0.2        1.44        perf-profile.children.cycles-pp.vma_interval_tree_insert
      1.76 ±  2%      -0.2        1.55        perf-profile.children.cycles-pp.__mmap
      1.17 ±  2%      -0.2        0.96 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
      1.35 ±  2%      -0.2        1.16        perf-profile.children.cycles-pp.__open64_nocancel
      1.44            -0.2        1.25        perf-profile.children.cycles-pp.alloc_pages_mpol
      1.05 ±  2%      -0.2        0.87        perf-profile.children.cycles-pp.__vm_munmap
      1.37            -0.2        1.19        perf-profile.children.cycles-pp.__alloc_pages
      0.84 ±  3%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.init_file
      0.73 ±  3%      -0.2        0.56 ±  3%  perf-profile.children.cycles-pp.security_file_alloc
      1.14 ±  2%      -0.2        0.98        perf-profile.children.cycles-pp.page_remove_rmap
      0.64 ±  3%      -0.2        0.48 ±  3%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.71 ±  3%      -0.1        0.56        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.21 ±  2%      -0.1        1.07 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.97 ±  2%      -0.1        0.83        perf-profile.children.cycles-pp.set_pte_range
      1.18 ±  2%      -0.1        1.05 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      0.84 ±  2%      -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.vma_complete
      1.04 ±  2%      -0.1        0.90 ±  2%  perf-profile.children.cycles-pp.do_anonymous_page
      1.39 ±  2%      -0.1        1.26        perf-profile.children.cycles-pp._dl_addr
      0.94            -0.1        0.82        perf-profile.children.cycles-pp.get_page_from_freelist
      0.86 ±  2%      -0.1        0.74        perf-profile.children.cycles-pp._compound_head
      1.46 ±  2%      -0.1        1.34        perf-profile.children.cycles-pp.kmem_cache_free
      0.43 ±  5%      -0.1        0.31 ±  5%  perf-profile.children.cycles-pp.security_file_free
      0.69 ±  5%      -0.1        0.57 ±  3%  perf-profile.children.cycles-pp.mm_init
      0.42 ±  5%      -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.89 ±  2%      -0.1        0.78        perf-profile.children.cycles-pp.perf_event_mmap
      0.19 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
      1.66            -0.1        1.55        perf-profile.children.cycles-pp.up_write
      0.97 ±  3%      -0.1        0.86 ±  4%  perf-profile.children.cycles-pp.kthread
      0.86 ±  2%      -0.1        0.75        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.70            -0.1        0.59 ±  3%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.71            -0.1        0.61 ±  2%  perf-profile.children.cycles-pp.wait4
      0.91 ±  2%      -0.1        0.80        perf-profile.children.cycles-pp.mas_store_prealloc
      1.31 ±  2%      -0.1        1.20 ±  2%  perf-profile.children.cycles-pp.rcu_do_batch
      0.69 ±  2%      -0.1        0.59 ±  3%  perf-profile.children.cycles-pp.kernel_wait4
      0.68 ±  2%      -0.1        0.57 ±  3%  perf-profile.children.cycles-pp.do_wait
      1.35 ±  2%      -0.1        1.25 ±  2%  perf-profile.children.cycles-pp.rcu_core
      0.80 ±  3%      -0.1        0.70 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.92 ±  3%      -0.1        0.82        perf-profile.children.cycles-pp.wp_page_copy
      0.80 ±  2%      -0.1        0.72        perf-profile.children.cycles-pp.__strcoll_l
      0.94            -0.1        0.85 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.50 ±  5%      -0.1        0.42 ±  3%  perf-profile.children.cycles-pp.release_empty_file
      0.50 ±  3%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.do_open
      0.62 ±  2%      -0.1        0.54        perf-profile.children.cycles-pp._IO_default_xsputn
      0.53            -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.ksys_read
      0.76 ±  2%      -0.1        0.68        perf-profile.children.cycles-pp.copy_strings
      0.55 ±  2%      -0.1        0.47        perf-profile.children.cycles-pp.vma_alloc_folio
      0.51            -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.vfs_read
      0.77 ±  2%      -0.1        0.69 ±  2%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.40 ±  7%      -0.1        0.33 ±  3%  perf-profile.children.cycles-pp.pcpu_alloc
      0.59 ±  3%      -0.1        0.51        perf-profile.children.cycles-pp.__mmdrop
      0.47            -0.1        0.40        perf-profile.children.cycles-pp.read
      0.56 ±  2%      -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.copy_p4d_range
      0.58 ±  2%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.copy_page_range
      0.61 ±  4%      -0.1        0.54        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.46 ±  2%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      0.47 ±  6%      -0.1        0.40 ±  4%  perf-profile.children.cycles-pp.alloc_bprm
      0.56 ±  3%      -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.63            -0.1        0.56        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.49 ±  2%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.clear_page_erms
      0.42 ±  2%      -0.1        0.36        perf-profile.children.cycles-pp.do_cow_fault
      0.49            -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.vm_area_alloc
      0.40 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.58 ±  2%      -0.1        0.51        perf-profile.children.cycles-pp.getname_flags
      0.26 ±  5%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.55 ±  3%      -0.1        0.49        perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.46 ±  2%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.__fput
      0.44 ±  3%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.45            -0.1        0.39        perf-profile.children.cycles-pp.rmqueue
      0.57 ±  2%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.40 ±  2%      -0.1        0.34 ±  6%  perf-profile.children.cycles-pp.do_task_dead
      0.57            -0.1        0.51        perf-profile.children.cycles-pp.sync_regs
      0.46 ±  3%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.task_work_run
      0.40 ±  2%      -0.1        0.35        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.42 ±  3%      -0.1        0.36        perf-profile.children.cycles-pp.mas_wr_node_store
      0.62 ±  2%      -0.1        0.56 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.47            -0.1        0.42 ±  3%  perf-profile.children.cycles-pp.__vfork
      0.34 ±  4%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.do_dentry_open
      0.60 ±  3%      -0.1        0.55        perf-profile.children.cycles-pp.find_idlest_cpu
      0.42 ±  3%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.dup_task_struct
      0.30            -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.pipe_read
      0.38 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.setup_arg_pages
      0.38 ±  2%      -0.0        0.33        perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.45 ±  2%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.43 ±  2%      -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.get_arg_page
      0.39 ±  2%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.pte_alloc_one
      0.36 ±  4%      -0.0        0.32        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.33 ±  2%      -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.42 ±  2%      -0.0        0.37 ±  3%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.35 ±  2%      -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.free_swap_cache
      0.32 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.copy_pte_range
      0.57            -0.0        0.52 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.37 ±  3%      -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.__vm_area_free
      0.64 ±  2%      -0.0        0.59 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      0.37 ±  3%      -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.29 ±  2%      -0.0        0.25        perf-profile.children.cycles-pp.__do_wait
      0.43 ±  3%      -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.40 ±  2%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.create_elf_tables
      0.33 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.32 ±  3%      -0.0        0.28        perf-profile.children.cycles-pp.shift_arg_pages
      0.52 ±  2%      -0.0        0.48 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
      0.44 ±  2%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.strnlen_user
      0.34 ±  3%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.29 ±  2%      -0.0        0.25 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.57 ±  2%      -0.0        0.53        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.39 ±  3%      -0.0        0.35 ±  2%  perf-profile.children.cycles-pp.mas_split
      0.42 ±  2%      -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.36 ±  2%      -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.34 ±  3%      -0.0        0.30        perf-profile.children.cycles-pp.__perf_sw_event
      0.15 ± 10%      -0.0        0.11 ± 24%  perf-profile.children.cycles-pp.osq_unlock
      0.40            -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      0.41 ±  2%      -0.0        0.37 ±  3%  perf-profile.children.cycles-pp.wake_up_new_task
      0.38 ±  2%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.30 ±  2%      -0.0        0.26        perf-profile.children.cycles-pp._IO_padn
      0.30 ±  3%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.22 ±  4%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.78 ±  2%      -0.0        0.74        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.27 ±  3%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.memset_orig
      0.26 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.48 ±  3%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.42 ±  2%      -0.0        0.38        perf-profile.children.cycles-pp.__cond_resched
      0.38 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.37 ±  3%      -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.mtree_range_walk
      0.29 ±  5%      -0.0        0.25 ±  6%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.29 ±  3%      -0.0        0.25 ±  3%  perf-profile.children.cycles-pp.lru_add_drain
      0.29 ±  4%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      0.21 ±  7%      -0.0        0.18 ±  7%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.28 ±  4%      -0.0        0.25 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.40 ±  3%      -0.0        0.36        perf-profile.children.cycles-pp.sched_exec
      0.35 ±  2%      -0.0        0.31        perf-profile.children.cycles-pp.__get_user_pages
      0.30 ±  4%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__pte_alloc
      0.70 ±  2%      -0.0        0.67        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.58            -0.0        0.55        perf-profile.children.cycles-pp.update_process_times
      0.29 ±  3%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.write
      0.27            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp._IO_fwrite
      0.76 ±  2%      -0.0        0.73        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.26 ±  3%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.free_unref_page
      0.22 ±  2%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp._copy_to_iter
      0.11 ±  9%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.security_file_open
      0.59 ±  2%      -0.0        0.56        perf-profile.children.cycles-pp.tick_sched_handle
      0.28 ±  3%      -0.0        0.25 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.28 ±  2%      -0.0        0.25 ±  3%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.31 ±  2%      -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.ksys_write
      0.27 ±  3%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.copy_string_kernel
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.24 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__x64_sys_close
      0.21 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.wait_task_zombie
      0.11 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.apparmor_file_open
      0.31 ±  3%      -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.get_unmapped_area
      0.24 ±  3%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.27 ±  3%      -0.0        0.24        perf-profile.children.cycles-pp.mas_next_slot
      0.48            -0.0        0.46 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.41            -0.0        0.38        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.30 ±  3%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.vfs_write
      0.26 ±  3%      -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.22 ±  5%      -0.0        0.19 ±  5%  perf-profile.children.cycles-pp.anon_vma_clone
      0.27 ±  3%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.18 ±  3%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.28 ±  2%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      0.26 ±  4%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.25 ±  4%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__close
      0.24 ±  3%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.24 ±  2%      -0.0        0.21        perf-profile.children.cycles-pp.filemap_read
      0.20 ±  5%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__close_nocancel
      0.20 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      0.36            -0.0        0.33 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.22 ±  2%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.22 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.19 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.19 ±  5%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.25 ±  2%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      0.19 ±  4%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.29 ±  2%      -0.0        0.26        perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.23 ±  4%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__fxstat64
      0.22 ±  4%      -0.0        0.19        perf-profile.children.cycles-pp.__pmd_alloc
      0.20 ±  4%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.do_open_execat
      0.16 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.18 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.mas_store
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.exit_notify
      0.14 ±  5%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.14            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__sysconf
      0.23 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.d_path
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.release_task
      0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.20 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.schedule_tail
      0.19 ±  3%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp._IO_file_xsputn
      0.20 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.malloc
      0.17 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.16 ±  3%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.__get_free_pages
      0.18 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.memmove
      0.14 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.open_exec
      0.19            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp._exit
      0.16 ±  2%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.balance_fair
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__do_fault
      0.20 ±  4%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__rb_erase_color
      0.16 ±  4%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.wmemchr
      0.21 ±  3%      -0.0        0.19        perf-profile.children.cycles-pp.flush_tlb_func
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.map_vdso
      0.17 ±  5%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.wait_for_completion_state
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.security_mmap_file
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.schedule_timeout
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.security_bprm_creds_for_exec
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.apparmor_bprm_creds_for_exec
      0.19            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__pud_alloc
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.do_brk_flags
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__cxa_atexit
      0.15 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp._copy_from_user
      0.15 ±  4%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.free_pgd_range
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__get_user_8
      0.12 ±  6%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.vfs_fstat
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__vsnprintf_chk
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.brk
      0.19 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__install_special_mapping
      0.15 ±  4%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.fopen
      0.13 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.mas_push_data
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.alloc_fd
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__exit_signal
      0.12 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.handle_pte_fault
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.do_faccessat
      0.11 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp._setjmp
      0.26 ±  2%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.18 ±  5%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.inode_permission
      0.14 ±  5%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.13 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.prepend_path
      0.13 ±  6%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.free_pud_range
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__wait_for_common
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map
      0.22 ±  2%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.14 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__do_sys_brk
      0.11 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.user_path_at_empty
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.filemap_fault
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.14 ±  3%      -0.0        0.12        perf-profile.children.cycles-pp.do_notify_parent
      0.10 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.count
      0.14 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.free_p4d_range
      0.13 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.remove_vma
      0.12 ±  4%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.prepare_creds
      0.11 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.strchrnul@plt
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.copy_present_pte
      0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__put_anon_vma
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.expand_downwards
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp._copy_to_user
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.handle_signal
      0.07 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.07 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.finish_fault
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.insert_vm_struct
      0.09 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.__snprintf_chk
      0.09 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.__fsnotify_parent
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.stop_one_cpu
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.find_mergeable_anon_vma
      0.08 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.cfree
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.14 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.12 ±  4%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.sched_move_task
      0.09 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.mas_prev_slot
      0.09 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.evict
      0.12            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.mas_topiary_replace
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.10 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.10 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.__free_one_page
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp._IO_setb
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.vm_brk_flags
      0.08            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.get_zeroed_page
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.__send_signal_locked
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.free_unref_page_prepare
      0.10 ±  3%      +0.0        0.11        perf-profile.children.cycles-pp.wake_affine
      0.09            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.08 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.wakeup_preempt
      0.15 ±  2%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.resched_curr
      0.20 ±  4%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.llist_add_batch
      0.09 ±  4%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.29 ±  3%      +0.0        0.32        perf-profile.children.cycles-pp.select_task_rq
      0.21 ±  3%      +0.0        0.24        perf-profile.children.cycles-pp.up_read
      0.07 ±  6%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.16 ±  4%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.24 ±  2%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.20 ±  5%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.complete_walk
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.04 ± 71%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.path_parentat
      0.04 ± 71%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__filename_parentat
      0.29 ±  3%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.__d_alloc
      0.64            +0.0        0.68 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.80 ±  2%      +0.0        0.84        perf-profile.children.cycles-pp.try_to_wake_up
      0.47            +0.0        0.52        perf-profile.children.cycles-pp.enqueue_entity
      0.62 ±  2%      +0.0        0.67        perf-profile.children.cycles-pp.enqueue_task_fair
      0.96            +0.1        1.01        perf-profile.children.cycles-pp.open64
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__wake_up
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.___d_drop
      0.15 ±  8%      +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.copy_fs_struct
      0.16 ±  6%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.lockref_get
      0.70 ±  2%      +0.1        0.76        perf-profile.children.cycles-pp.activate_task
      0.74 ±  2%      +0.1        0.80 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      0.64 ±  2%      +0.1        0.70        perf-profile.children.cycles-pp.wake_up_q
      0.46 ±  2%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__d_rehash
      0.61            +0.1        0.68 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.24 ± 12%      +0.1        0.32 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.59            +0.1        0.68        perf-profile.children.cycles-pp.ttwu_do_activate
      0.12 ±  4%      +0.1        0.21        perf-profile.children.cycles-pp.__d_add
      0.23 ± 11%      +0.1        0.33 ±  9%  perf-profile.children.cycles-pp.exit_fs
      0.12 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.simple_lookup
      0.70 ±  3%      +0.1        0.80        perf-profile.children.cycles-pp.unlinkat
      0.68 ±  3%      +0.1        0.79        perf-profile.children.cycles-pp.__x64_sys_unlinkat
      0.68 ±  3%      +0.1        0.79        perf-profile.children.cycles-pp.do_unlinkat
      0.61 ±  2%      +0.1        0.72        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.40 ±  3%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.lockref_put_return
      0.29 ±  9%      +0.1        0.41 ±  8%  perf-profile.children.cycles-pp.path_put
      0.72            +0.1        0.86        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.74            +0.1        0.88        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.87            +0.2        1.04        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.82 ±  5%      +0.3        1.10 ±  4%  perf-profile.children.cycles-pp.lookup_open
      1.75            +0.4        2.14        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      2.72 ±  2%      +0.4        3.14        perf-profile.children.cycles-pp.acpi_safe_halt
      2.73 ±  2%      +0.4        3.15        perf-profile.children.cycles-pp.acpi_idle_enter
      2.84 ±  2%      +0.4        3.28        perf-profile.children.cycles-pp.cpuidle_enter
      2.84 ±  2%      +0.4        3.27        perf-profile.children.cycles-pp.cpuidle_enter_state
      3.08 ±  2%      +0.4        3.53        perf-profile.children.cycles-pp.cpuidle_idle_call
      3.63            +0.5        4.09        perf-profile.children.cycles-pp.start_secondary
      3.68            +0.5        4.16        perf-profile.children.cycles-pp.do_idle
      3.68            +0.5        4.16        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.68            +0.5        4.16        perf-profile.children.cycles-pp.cpu_startup_entry
      3.87 ±  2%      +0.8        4.67 ±  5%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      3.07 ±  2%      +0.8        3.88 ±  2%  perf-profile.children.cycles-pp.filename_lookup
      3.05 ±  2%      +0.8        3.86 ±  2%  perf-profile.children.cycles-pp.path_lookupat
      3.20 ±  2%      +0.8        4.02        perf-profile.children.cycles-pp.__do_sys_newstat
      3.06 ±  2%      +0.8        3.90 ±  2%  perf-profile.children.cycles-pp.vfs_statx
      3.84 ±  2%      +1.0        4.84 ±  5%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      3.96 ±  2%      +1.0        4.99 ±  5%  perf-profile.children.cycles-pp.down_read
      3.90 ±  3%      +1.2        5.06 ±  2%  perf-profile.children.cycles-pp.open_last_lookups
     79.50            +1.6       81.11        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     79.44            +1.6       81.06        perf-profile.children.cycles-pp.do_syscall_64
     12.06 ±  4%      +2.0       14.02 ±  2%  perf-profile.children.cycles-pp.__lookup_slow
     12.68 ±  4%      +2.1       14.82 ±  2%  perf-profile.children.cycles-pp.d_alloc_parallel
      3.61 ±  3%      +2.9        6.50 ±  2%  perf-profile.children.cycles-pp.lookup_fast
      3.19 ±  4%      +3.0        6.23 ±  2%  perf-profile.children.cycles-pp.try_to_unlazy
      3.17 ±  4%      +3.0        6.21 ±  2%  perf-profile.children.cycles-pp.__legitimize_path
      3.29 ±  4%      +3.1        6.44 ±  2%  perf-profile.children.cycles-pp.lockref_get_not_dead
      3.56 ±  4%      +3.4        7.01 ±  2%  perf-profile.children.cycles-pp.terminate_walk
      3.82 ±  3%      +3.4        7.27 ±  2%  perf-profile.children.cycles-pp.d_alloc
      3.54 ±  4%      +3.7        7.28 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      2.41 ±  2%      +5.4        7.83 ±  3%  perf-profile.children.cycles-pp.step_into
     18.26 ±  3%      +5.8       24.10        perf-profile.children.cycles-pp.walk_component
     14.67 ±  4%      +7.3       22.01 ±  2%  perf-profile.children.cycles-pp.dput
      7.29 ±  4%      +7.4       14.68 ±  2%  perf-profile.children.cycles-pp.fast_dput
     19.98 ±  3%     +10.5       30.47        perf-profile.children.cycles-pp.link_path_walk
     20.36 ±  4%     +13.7       34.10 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     28.00 ±  3%     +13.9       41.88        perf-profile.children.cycles-pp.__x64_sys_openat
     27.98 ±  3%     +13.9       41.86        perf-profile.children.cycles-pp.do_sys_openat2
     21.38 ±  4%     +13.9       35.27 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
     27.34 ±  3%     +13.9       41.27        perf-profile.children.cycles-pp.do_filp_open
     27.27 ±  3%     +13.9       41.20        perf-profile.children.cycles-pp.path_openat
     16.46 ± 10%      -8.9        7.54 ± 10%  perf-profile.self.cycles-pp.osq_lock
      2.55            -0.4        2.18        perf-profile.self.cycles-pp.next_uptodate_folio
      1.48 ±  2%      -0.4        1.12 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.64 ±  2%      -0.2        1.42        perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.93 ±  2%      -0.2        0.77 ±  2%  perf-profile.self.cycles-pp.up_write
      0.62 ±  3%      -0.2        0.46 ±  4%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.94 ±  2%      -0.2        0.79 ±  3%  perf-profile.self.cycles-pp.release_pages
      1.05 ±  2%      -0.2        0.90        perf-profile.self.cycles-pp.page_remove_rmap
      0.94 ±  2%      -0.1        0.81        perf-profile.self.cycles-pp.filemap_map_pages
      1.24 ±  2%      -0.1        1.12        perf-profile.self.cycles-pp._dl_addr
      0.19 ±  3%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.41 ±  5%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.74            -0.1        0.63 ±  2%  perf-profile.self.cycles-pp.down_write
      0.78 ±  2%      -0.1        0.67        perf-profile.self.cycles-pp._compound_head
      0.85 ±  3%      -0.1        0.75        perf-profile.self.cycles-pp.zap_pte_range
      1.00 ±  2%      -0.1        0.90        perf-profile.self.cycles-pp.kmem_cache_free
      0.79 ±  2%      -0.1        0.70        perf-profile.self.cycles-pp.__strcoll_l
      0.60 ±  2%      -0.1        0.52        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.92 ±  2%      -0.1        0.84 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.58 ±  2%      -0.1        0.51        perf-profile.self.cycles-pp._IO_default_xsputn
      0.28 ± 23%      -0.1        0.21 ±  4%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.49            -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      0.57            -0.1        0.51        perf-profile.self.cycles-pp.sync_regs
      0.54 ±  4%      -0.1        0.49        perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.36 ±  3%      -0.1        0.31 ±  2%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.37 ±  3%      -0.0        0.32        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.57            -0.0        0.52 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.32 ±  2%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.free_swap_cache
      0.43 ±  2%      -0.0        0.39 ±  2%  perf-profile.self.cycles-pp.strnlen_user
      0.46 ±  3%      -0.0        0.42 ±  2%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.18 ±  4%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.56 ±  2%      -0.0        0.52        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.15 ± 10%      -0.0        0.11 ± 24%  perf-profile.self.cycles-pp.osq_unlock
      0.47 ±  4%      -0.0        0.43        perf-profile.self.cycles-pp.lockref_get_not_dead
      0.36 ±  2%      -0.0        0.33 ±  2%  perf-profile.self.cycles-pp.mtree_range_walk
      0.28 ±  2%      -0.0        0.24        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.29 ±  2%      -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.set_pte_range
      0.25            -0.0        0.21 ±  3%  perf-profile.self.cycles-pp._IO_fwrite
      0.26 ±  3%      -0.0        0.23        perf-profile.self.cycles-pp.memset_orig
      0.42 ±  2%      -0.0        0.39        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.21 ±  6%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.28 ±  2%      -0.0        0.25 ±  3%  perf-profile.self.cycles-pp._IO_padn
      0.24 ±  3%      -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.10 ±  7%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.apparmor_file_open
      0.33 ±  2%      -0.0        0.30 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.26 ±  4%      -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.20 ±  2%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.18 ±  5%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__rb_erase_color
      0.16 ±  4%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.link_path_walk
      0.15 ±  4%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp._copy_from_user
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_walk
      0.20 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.mmap_region
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.handle_mm_fault
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp._IO_file_xsputn
      0.24 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.mas_next_slot
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.16 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.strncpy_from_user
      0.20 ±  2%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__memcpy
      0.16 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__get_user_8
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__pte_offset_map
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.09 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.mas_topiary_replace
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__snprintf_chk
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.12 ±  4%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.mas_pop_node
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.11 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.mas_rev_awalk
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.08 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.mas_prev_slot
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.d_path
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.fput
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.13            +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.enqueue_entity
      0.13 ±  3%      +0.0        0.15        perf-profile.self.cycles-pp.__update_load_avg_se
      0.04 ± 44%      +0.0        0.06        perf-profile.self.cycles-pp.resched_curr
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.llist_add_batch
      0.18 ±  4%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.up_read
      0.07 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.13 ±  5%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.09 ±  7%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.release_empty_file
      0.10 ± 14%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.10 ±  4%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.down_read
      0.14 ±  5%      +0.0        0.19        perf-profile.self.cycles-pp.d_alloc
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__dentry_kill
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__d_rehash
      1.54 ±  2%      +0.1        1.64        perf-profile.self.cycles-pp._raw_spin_lock
      0.39 ±  3%      +0.1        0.51 ±  2%  perf-profile.self.cycles-pp.lockref_put_return
      0.18 ±  3%      +0.2        0.38 ±  3%  perf-profile.self.cycles-pp.d_alloc_parallel
      1.22            +0.2        1.45        perf-profile.self.cycles-pp.acpi_safe_halt
     20.09 ±  4%     +13.6       33.67 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




