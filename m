Return-Path: <linux-fsdevel+bounces-4772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3038036F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02DD1F210D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7228DCA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOB2Xdu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FBBE5;
	Mon,  4 Dec 2023 05:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701697079; x=1733233079;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qPgOqx4cEdKmsMgJJr/j80VXfx2O7ZclWenpKidSHbE=;
  b=OOB2Xdu8mUIsZGUDtawvichOEP6H05V3ueKY4HY7tr7hIRBUda7NHzeE
   elQ53wVRdLPgK0wzuEYuGJRUluaPpV7MBCGKOZ2Rpqet8YaPKTvFrp5DR
   DZ1pRbpHgvxZRrmBIvRy0iXt7xH8rGMOVIHynu201WkxpO8ij6+LVmDKm
   kiyVw6TWV1KqVOJ7HjtS08z6yTa4AGJ29kQAECMUqf6RJAkLpEPo7jA/u
   sKn4rxZ4LkFELqpgK3vzqDeHvpGBKKc9zlMLuPL4rxkIQ48Q5ViwbhI5r
   jIkUu1oPfVQqeJkP3FLRgQff7K2YO18ypwdawLWMPBnEIYTeU11QocWiG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="7060522"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="7060522"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="720325227"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="720325227"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 05:37:58 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 05:37:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 05:37:57 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 05:37:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II6dkaBWvXWHpvFQUPhjBvlLgqltmmh2GqsVP0j1/nezI4Jx7Sxm6wdtSvz1GIdhEsF/ydFflZKa/XBYsCnwOfPxbEn5gNfXSTAWzETtLyTnL8uNDIC3LiZAYyXrraqoLnNXd1NdZGUIOvdmARL57Sre7P7C6uPSOVgBk3aYZyjkI+nHjWsRan0mP3KRF+0VVlXtKykM32nHVAA4jthqbjqULOwJ0KrL2KIy6y3SgFS3bl23ExljuMuUkIZ8a8Y4Mw57yte6dLMSoNxpyt3ovs6RlMQOAU7gfuodRnhavma9Af0GHSlwH5EjmyL8d/IAxTX0pZrYarsO36kEETSQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahGdjg+pqqKSsbDO8NRoWsEFlhFw99zU8qp6D0YTdd0=;
 b=aY+cOwHnzg0uLn4JTCyedhKOA04h1BcidjgxZ1BxhoNVsZKIA/Qha752Iuf3wtLihcXzwQ0XEkCvGeUaGTsJR0jkcnUIhIc3DhSPRgkhNUInCMTkrkbw8irH8SNYSG3cNKFYQS6uwRrGrzsIuSmy/+sfExx+mAK7BD4s9t+YS0Q+BPAB8M8tIiPR3vjTS/kmEJYnnYlbdkkGx7AY2Q9DBLaZg74rx8pCbi5WobtDSWdf3DQ7tnBgjr0u4/CE10BtJTQD6PMe929c30oyUzAJBtOBRaAV+qxUEXoojv6/yVNO8PyibrUNGTeH2nFAG2CIL6d1qgwIUCZv/cr8DzBP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 13:37:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 13:37:55 +0000
Date: Mon, 4 Dec 2023 21:37:45 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	<linux-doc@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	<oliver.sang@intel.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()]  1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020>
References: <202311300906.1f989fa8-oliver.sang@intel.com>
 <20231130075535.GN38156@ZenIV>
 <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020>
 <20231201040951.GO38156@ZenIV>
 <20231201065602.GP38156@ZenIV>
 <20231201200446.GA1431056@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201200446.GA1431056@ZenIV>
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 362ea0a4-9a59-4824-e162-08dbf4ce3858
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MxdnA9MsO7HJxEvrC3S2ZcLnQjtayT/eYLzz57OcK5MiX+wqNIoQAL3qKszdplFxv/LzX5gu2H41bG7qJbjuEVH2yYpaGQaoTk+sXznwZvD212yt/+RK3Jkp1rOdzhzbbkvtsNn4+KdvCb7k7UJAZ2iOAkSRhM9LJfWVIVACVj5U7fPUTGZTxfPszoCb4JqyGHNcG+8rU+GytZK4WEx6tdgUEEfW66ocIa3JOEJ8YhSEelqIwU1QFW6KehF9yWWRjYXtwo2YWlM/tXV7iHuaJpIAnny5wf41N1d4gttcAyDXHPjHM9KItrdHz+FnIHgi4USNlwm2ZqxTJ1X6PpwYkTGKcKqmkXmKD7aQceiw3J37thN+ETo/A2KzNa80utmcEMxkrVwtPAA79JXIqN98mM8ghYIxDE2cZ7D/tKEHDMXjEaAWj5M9SYj1OSs0B+h/4ptBV2eL8DVEHY1WPE9nefzU8gpLbhF4VRRigS2IbeobuhSo2jMBvybAUZipcapsSDkGFgbaGgi5FzqMMMX7U9AHeRuxt4i0SbThmBCqR/a4AZg3sYchNoX9MAMElUJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(107886003)(82960400001)(38100700002)(86362001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(9686003)(26005)(478600001)(41300700001)(6486002)(6666004)(66946007)(66556008)(316002)(66476007)(54906003)(6916009)(2906002)(33716001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xzx0UVbS4/omeuqVv0SPkoYa28KqpqJDZum0BjKbWyaGI48/ELvwXSAGbqU4?=
 =?us-ascii?Q?MPkocL3RyqpFrNVLJtMPaLqhywYX19oq8sOMGaOj3Ez284MBcKdXHoaB4L8r?=
 =?us-ascii?Q?zqsandXtOAgMDaYWvQ+eexPuYngK1oo6zXOEEnAdCHsGPyeWMk67Sp+h79K+?=
 =?us-ascii?Q?4lvn4iGe7Xl6ASM47hHb3YGuJyN+B9YTfT7vjQVMZjz11B8b8JZZBKnHt+mx?=
 =?us-ascii?Q?J8janKkbLdAhanUVP++USuh0+TmSw74nWN6y8J3IA8ktopcojE+kgkNT7O80?=
 =?us-ascii?Q?N81gyKPuH1cgJkeFhZWkRNjQ6la+a4p09Rx2BilVEcCkoAhPEVFkiXV/btR0?=
 =?us-ascii?Q?skGOKoMSiVkNWlGx3iKO9HjgPAJRCKObtwncFlT9yxSUk8I9NfVS1JSYArGe?=
 =?us-ascii?Q?XbAyjdY5tA1YBQUcX+ZuF8jsK++rcqSevjhGWYZaa7u0KfrCIEQ29VMXUiUL?=
 =?us-ascii?Q?v32CWfwXcNmUtKdeHwqvXdofazDcET9gsO8Tn9BMTxu5LVxAXyVwnjPsHl6g?=
 =?us-ascii?Q?oCDmzAZO7Lf69rk8WbX5XgYAt4KzrolSsm2tfSgMx0RlXaMONWZaYXS55AFL?=
 =?us-ascii?Q?5qJpMfcjcufFG7r1+LfwLPsbHDqZHOSEA7B0CKQqNwG2aHwH8PBApKhQIbKF?=
 =?us-ascii?Q?i++MABhEXZR9mMOSrTvFY9VLMj+4lXvG5GM/25thZrxVnXVuGjKFMvxx4fZY?=
 =?us-ascii?Q?93XJJq80n7RxwcKlaoxyq/qx0ee9ir1cwPa5t2qz3mXaM03l7FAMzqfo9z5+?=
 =?us-ascii?Q?g7QNvpLCT5ZRggXOjO11ZMKG19elPJmRDdDQA1hReR/TdtsZjoDJU37l8U9G?=
 =?us-ascii?Q?1mHtF27FnhRC+pDhH+T6fkzdV9gJGqKxXRHf5F1G4YZR3K2JCopsNe8DeTJ4?=
 =?us-ascii?Q?TvjprpUAjsFUGGc0Iygx/q1ioZ6S/mqujyBd4XXtnP2i4iTgHOWkmRaVnBG7?=
 =?us-ascii?Q?QGJ7WiETYXOZGht4WSYHk7lqMyu7FlI4vxPvjG9Gi8rJPm0CHBefMcd3hAhn?=
 =?us-ascii?Q?RiK1FXVTzV4NBIZ0F/DL6DQqLxpLq0csVdCC2S1s1Pv+WBQHyqHYxE1GZzon?=
 =?us-ascii?Q?/vzsjiuvbELUde3uqrRAmrFNONdmsYoxqWmcBwjd+x/85cNUFJYiiJj5z+us?=
 =?us-ascii?Q?YtClky83dwJ7tRUPlxKe11464DaEE05fedifcMfOleTcuWi9LC4EuTI6L4iZ?=
 =?us-ascii?Q?CFZqKrCdJj5U0EsL2b49zcczuj4Ex+qopf3gWJAY1A2DYmm8ZhjvODmN2X0Q?=
 =?us-ascii?Q?g1Ov/KCM2rO6fBuY4f3gbVaxLKgLp4kAdnfziJAX9gx9jOxcAJre8KF0NV4C?=
 =?us-ascii?Q?84xZHxuE9qSK4RShdrRg1CEmivZxXHhL6oxB99VkkxabYUHjgsBDi4Uz/oFr?=
 =?us-ascii?Q?rKHLXIaePBaVVhWf2hODULBzA87C2J94B36CwJBBYYQPcasgrSMGRkcRwTNS?=
 =?us-ascii?Q?lUwgMfNEWdkWT2fRPjNz3iun8X9zRmTzRqTP3w2yXkM+YX/rmfyQcUr7Oz2p?=
 =?us-ascii?Q?Gw7R43yEF20CnhurzmFNOZANNx1xp3arjOE8o0o9sA1tjMwUegUMHJFo8gNi?=
 =?us-ascii?Q?cCOC7WFMkJcfADKVofKzJYfhG6ZDdXE4fi/RkXR5A9Ez3AYM+jvkAWGf7cYA?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 362ea0a4-9a59-4824-e162-08dbf4ce3858
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:37:55.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOQqRNcpLvkXwghhsHAOZAlatzWAmfzh7WMRimh9Ld9NHO4ut4UqLotgNHjGY+xCrl6iyEnSoGEpiF7BTPUMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7410
X-OriginatorOrg: intel.com

hi, Al Viro,

On Fri, Dec 01, 2023 at 08:04:46PM +0000, Al Viro wrote:
> On Fri, Dec 01, 2023 at 06:56:03AM +0000, Al Viro wrote:
> > On Fri, Dec 01, 2023 at 04:09:51AM +0000, Al Viro wrote:
> > > On Fri, Dec 01, 2023 at 10:13:09AM +0800, Oliver Sang wrote:
> > > 
> > > > > Very interesting...  Out of curiosity, what effect would the following
> > > > > have on top of 1b738f196e?
> > > > 
> > > > I applied the patch upon 1b738f196e (as below fec356fd0c), but seems less
> > > > useful.
> > > 
> > > I would be rather surprised if it fixed anything; it's just that 1b738f196e
> > > changes two things - locking rules for __dentry_kill() and, in some cases,
> > > the order of dentry eviction in shrink_dentry_list().  That delta on top of
> > > it restores the original order in shrink_dentry_list(), leaving pretty much
> > > the changes in lock_for_kill()/dput()/__dentry_kill().
> > > 
> > > Interesting...  Looks like there are serious changes in context switch
> > > frequencies, but I don't see where could that have come from...
> > 
> > In principle it could be an effect of enforcing the ordering between __dentry_kill()
> > of child and parent, but if that's what is going on... we would've seen
> > more iterations of loop in shrink_dcache_parent() and/or d_walk() calls in
> > it having more work to do.  But... had that been what's going on, wouldn't we
> > see some of those functions in the changed part of profile?  
> > 
> > I'll try to split that thing into a series of steps, so we could at least narrow
> > the effect down, but that'll have to wait until tomorrow ;-/
> 
> OK, a carved-up series (on top of 1b738f196e^) is in #carved-up-__dentry_kill
> That's 9 commits, leading to something close to 1b738f196e+patch you've tested
> yesterday; could you profile them on your reproducers?  That might give some
> useful information about the nature of the regression...
>

we rerun the test and confirmed the regression still exists if comparing
20f7d1936e8a2 (viro-vfs/carved-up-__dentry_kill) step 9: fold decrment of parent's refcount into __dentry_kill()
with
b4cc0734d2574 d_prune_aliases(): use a shrink list

the data is similar to our previous report.

now we feed the results into our auto-bisect tool and hope to get results later

but due to the limitation such like auto-bisect cannot capture multi commits if
they all contribute to the regression, after we get the results from auto
bisect, we will check if any further munual efforts needed. Thanks

