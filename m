Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2846F761DDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjGYP7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGYP7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5A22106
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 08:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67BA9617D1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 15:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6914C433C7;
        Tue, 25 Jul 2023 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690300773;
        bh=0u+HYQGmoCedoBKVOoR5Hosif+VWaXwQKUiW99pfSl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTK5dt2WSUPfGCvS5hXGIxM5+Qo1OOaSBnYQUfe+AhZjnnlzlWwviZyCv9g4SmG6O
         x4FpMQGpcbie1X5LzuFQwFPEM7hMTeUoiHPNk/aSF9wqaXFYHcaWCL/2GwbPxq5P94
         aFgY4ZwvYReY5VgXWvhtK7ZnYGnSXcahi0rchwtbgR41DYp/GDOJp1461QAp4qrrAn
         hq0maRK6VgjD16grARCE3QsP99YcuPcKVsYEjvxuCZTIMmD1SSZWT+bA4RdoYxrEMd
         4bFVQNDaD1RB6Agl1WVf56i10pWbHdlzmP3yaXondjpvmEcR5YDQPkuC0O43oOFasY
         sitViS0NP5xIg==
Date:   Tue, 25 Jul 2023 17:59:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Philip Li <philip.li@intel.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        kernel test robot <oliver.sang@intel.com>,
        Chuck Lever <cel@kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] shmem: stable directory offsets
Message-ID: <20230725-geraubt-international-910f0d37175b@brauner>
References: <202307171436.29248fcf-oliver.sang@intel.com>
 <3B736492-9332-40C9-A916-DA6EE1A425B9@oracle.com>
 <53E23038-3904-400F-97E1-0BAFAD510D2D@oracle.com>
 <ZL/wMvYSjRU0L6Cp@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZL/wMvYSjRU0L6Cp@rli9-mobl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:54:26PM +0800, Philip Li wrote:
> On Tue, Jul 25, 2023 at 03:12:22PM +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Jul 22, 2023, at 4:33 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > > 
> > > 
> > > 
> > >> On Jul 17, 2023, at 2:46 AM, kernel test robot <oliver.sang@intel.com> wrote:
> > >> 
> > >> 
> > >> hi, Chuck Lever,
> > >> 
> > >> we reported a 3.0% improvement of stress-ng.handle.ops_per_sec for this commit
> > >> on
> > >> https://lore.kernel.org/oe-lkp/202307132153.a52cdb2d-oliver.sang@intel.com/
> > >> 
> > >> but now we noticed a regression, detail as below, FYI
> > >> 
> > >> Hello,
> > >> 
> > >> kernel test robot noticed a -15.5% regression of will-it-scale.per_thread_ops on:
> > >> 
> > >> 
> > >> commit: a1a690e009744e4526526b2f838beec5ef9233cc ("[PATCH v7 3/3] shmem: stable directory offsets")
> > >> url: https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/libfs-Add-directory-operations-for-stable-offsets/20230701-014925
> > >> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> > >> patch link: https://lore.kernel.org/all/168814734331.530310.3911190551060453102.stgit@manet.1015granger.net/
> > >> patch subject: [PATCH v7 3/3] shmem: stable directory offsets
> > >> 
> > >> testcase: will-it-scale
> > >> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > >> parameters:
> > >> 
> > >> nr_task: 16
> > >> mode: thread
> > >> test: unlink2
> > >> cpufreq_governor: performance
> > >> 
> > >> 
> > >> In addition to that, the commit also has significant impact on the following tests:
> > >> 
> > >> +------------------+-------------------------------------------------------------------------------------------------+
> > >> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -40.0% regression                                   |
> > >> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
> > >> | test parameters  | cpufreq_governor=performance                                                                    |
> > >> |                  | mode=thread                                                                                     |
> > >> |                  | nr_task=16                                                                                      |
> > >> |                  | test=unlink2                                                                                    |
> > >> +------------------+-------------------------------------------------------------------------------------------------+
> > >> | testcase: change | stress-ng: stress-ng.handle.ops_per_sec 3.0% improvement                                        |
> > >> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory        |
> > >> | test parameters  | class=filesystem                                                                                |
> > >> |                  | cpufreq_governor=performance                                                                    |
> > >> |                  | disk=1SSD                                                                                       |
> > >> |                  | fs=ext4                                                                                         |
> > >> |                  | nr_threads=10%                                                                                  |
> > >> |                  | test=handle                                                                                     |
> > >> |                  | testtime=60s                                                                                    |
> > >> +------------------+-------------------------------------------------------------------------------------------------+
> > >> 
> > >> 
> > >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > >> the same patch/commit), kindly add following tags
> > >> | Reported-by: kernel test robot <oliver.sang@intel.com>
> > >> | Closes: https://lore.kernel.org/oe-lkp/202307171436.29248fcf-oliver.sang@intel.com
> > >> 
> > >> 
> > >> Details are as below:
> > >> -------------------------------------------------------------------------------------------------->
> > >> 
> > >> 
> > >> To reproduce:
> > >> 
> > >>       git clone https://github.com/intel/lkp-tests.git
> > >>       cd lkp-tests
> > >>       sudo bin/lkp install job.yaml           # job file is attached in this email
> > 
> > Has anyone from the lkp or ltp teams had a chance to look at this?
> > I'm stuck without this reproducer.
> 
> Sorry about this that fedora is not fully supported now [1]. A possible way
> is to run the test inside docker [2]. But we haven't fully tested the
> reproduce steps in docker yet, which is in our TODO list. Also a concern is
> that docker environment probably can't reproduce the performance regression.
> 
> For now, not sure whether it is convenient for you to have a ubuntu or debian
> environment to give a try? Another alternative is if you have new patch, we
> can assist to verify it on our machines.

So while we have your attention here. I've asked this a while ago in
another mail: It would be really really helpful if there was a way for
us to ask/trigger a perf test run for specific branches/patches we
suspect of being performance sensitive.

It's a bit of a shame that we have no simple way of submitting a custom
job and get performance results reported. I know that resources for this
are probably scarce but some way to at least request it would be really
really nice.
