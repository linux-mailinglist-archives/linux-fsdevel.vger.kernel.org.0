Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F96B1F5FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 04:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFKCHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 22:07:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:18297 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgFKCHc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:07:32 -0400
IronPort-SDR: MM2iTVu7nZ5lej1oVUpCCr8KyskROO1SZFCSwxBudqgb72LN7CHCLu9g5+7d/8JUI9NzvppZeK
 4rAJ8rBr/g6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 19:07:32 -0700
IronPort-SDR: /Ge1PVEpVrBbA2100P3pQNHJyfAEGcrkEFRiCLJorfdprEtApfcMvqffyphjlsELMvbEEkWC1y
 HMDXYRYgadTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="275176620"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2020 19:07:26 -0700
Date:   Thu, 11 Jun 2020 10:06:57 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Subject: Re: [kernfs] ea7c5fc39a: stress-ng.stream.ops_per_sec 11827.2%
 improvement
Message-ID: <20200611020657.GI12456@shao2-debian>
References: <159038562460.276051.5267555021380171295.stgit@mickey.themaw.net>
 <20200606155216.GU12456@shao2-debian>
 <20200606181802.GA15638@kroah.com>
 <5df6bec6f1b332c993474782c08fe8db30bffddc.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5df6bec6f1b332c993474782c08fe8db30bffddc.camel@themaw.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 07, 2020 at 09:13:08AM +0800, Ian Kent wrote:
> On Sat, 2020-06-06 at 20:18 +0200, Greg Kroah-Hartman wrote:
> > On Sat, Jun 06, 2020 at 11:52:16PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a 11827.2% improvement of stress-
> > > ng.stream.ops_per_sec due to commit:
> > > 
> > > 
> > > commit: ea7c5fc39ab005b501e0c7666c29db36321e4f74 ("[PATCH 1/4]
> > > kernfs: switch kernfs to use an rwsem")
> > > url: 
> > > https://github.com/0day-ci/linux/commits/Ian-Kent/kernfs-proposed-locking-and-concurrency-improvement/20200525-134849
> > > 
> > 
> > Seriously?  That's a huge performance increase, and one that feels
> > really odd.  Why would a stress-ng test be touching sysfs?
> 
> That is unusually high even if there's a lot of sysfs or kernfs
> activity and that patch shouldn't improve VFS path walk contention
> very much even if it is present.
> 
> Maybe I've missed something, and the information provided doesn't
> seem to be quite enough to even make a start on it.
> 
> That's going to need some analysis which, for my part, will need to
> wait probably until around rc1 time frame to allow me to get through
> the push down stack (reactive, postponed due to other priorities) of
> jobs I have in order to get back to the fifo queue (longer term tasks,
> of which this is one) list of jobs I need to do as well, ;)
> 
> Please, kernel test robot, more information about this test and what
> it's doing.
> 

Hi Ian,

We increased the timeout of stress-ng from 1s to 32s, and there's only
3% improvement of stress-ng.stream.ops_per_sec:

fefcfc968723caf9  ea7c5fc39ab005b501e0c7666c  testcase/testparams/testbox
----------------  --------------------------  ---------------------------
         %stddev      change         %stddev
             \          |                \  
     10686               3%      11037        stress-ng/cpu-cache-performance-1HDD-100%-32s-ucode=0x500002c/lkp-csl-2sp5
     10686               3%      11037        GEO-MEAN stress-ng.stream.ops_per_sec

It seems the result of stress-ng is inaccurate if test time too
short, we'll increase the test time to avoid unreasonable results,
sorry for the inconvenience.

Best Regards,
Rong Chen
