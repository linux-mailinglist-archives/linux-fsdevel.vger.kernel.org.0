Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82C766007
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 00:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjG0W7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 18:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjG0W7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629C94;
        Thu, 27 Jul 2023 15:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 571AF61F78;
        Thu, 27 Jul 2023 22:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D062C433C7;
        Thu, 27 Jul 2023 22:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690498740;
        bh=7YZbeoQqfKNEx+jwMo1/b4aGKcS1iuXyOx+y/zN5Zzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJ6iB/tYWfVsHajByyC28Q7EemdgjIMF6uLfu9+WgDtg2ewJu2I/4RuqBensexXAf
         FDDEk9ibYhSToWf2z2KL+m6ua2Eid74tC26XQxdAGdDyuhJauZOYrO+rSPxa76G3C8
         JM8crmumVVgBtDC38fV2RDMVcxBvwdD45lwBhEddEORux7bg7/o6DgRHlk1qTcLQfL
         DpzfQqSxW2XolqDRG8BB/4q1ZDERYghJA4A7XHyfwQH8iDKwXyZzLYDZHNAIw2TPal
         V0qSx/dLBn64aNDLJOH0GqdY6JJLnw9NBtfFrhnafz2W+ZNJQz+4SP8SRFHsnnsNW6
         qwdkUtESktMGA==
Date:   Thu, 27 Jul 2023 15:58:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Chandan Babu R <chandan.babu@oracle.com>
Subject: Re: xfs kdevops baseline for next-20230725
Message-ID: <20230727225859.GF11352@frogsfrogsfrogs>
References: <ZMK1r91ByQERwDK+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMK1r91ByQERwDK+@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:21:35AM -0700, Luis Chamberlain wrote:
> I'd like to see if this is useful so feedback is welcomed.
> 
> I recently had a reason to establish a baseline for XFS as we start
> testing some new fatures we've been working on to ensure we don't create
> regressions. I've been using kdevops for this work, its on github [0] and
> on gitlab for those that prefer that [1] and tested against linux-next
> tag next-20230725, with its respective generic kernel configuration
> which has evolved over time for kdevops which let's us test with kdevops
> with qemu / virtualbox / all cloud providers [2]. We fork fstests [3] so
> have a small delta, mostly reverts to help stability on testing as
> Chandan found regressions in some new fstest changes.
> 
> [0] https://github.com/linux-kdevops/kdevops.git
> [1] https://gitlab.com/linux-kdevops/kdevops.git
> [2] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/bootlinux/templates/config-next-20230725
> [3] https://github.com/linux-kdevops/fstests
> 
> The sections tested for are:
> 
> xfs_crc
> xfs_reflink
> xfs_reflink-normapbt
> xfs_reflink_1024
> xfs_reflink_2k
> xfs_reflink_4k
> xfs_nocrc
> xfs_nocrc_512
> xfs_nocrc_1k
> xfs_nocrc_2k
> xfs_nocrc_4k
> xfs_logdev
> xfs_rtdev
> xfs_rtlogdev

Question: Have you turned on gcov to determine how much of fs/xfs/ and
fs/iomap/ are actually getting exercised by these configurations?

I have for my fstests fleet; it's about ~90% for iomap, ~87% for
xfs/libxfs, ~84% for the pagecache, and ~80% for xfs/scrub.  Was
wondering what everyone else got on the test.

--D

> You can see what these sections represent in terms of xfs here:
> 
> https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/fstests/templates/xfs/xfs.config
> 
> The first order of business before even considering a set of changes is
> getting baseline and building a high confidence in that baseline. We had
> a technical debt as it's been a while before we get to establish and
> publish a baseline with high confidence for XFS for linux-next. Hopefully this
> will help us keep it moving forward.
> 
> The kdevops configuration used for this can be found here:
> 
> https://github.com/linux-kdevops/kdevops/blob/master/workflows/fstests/results/mcgrof/libvirt-qemu/20230727/kdevops.config
> 
> Worth noting is that virtio drives are used instead of NVMe since virtio
> supports io-threads, and so we get less NVMe timouts on the guest which
> have proven to cause major false positives for testing for a while as we
> have seen on the stable testing. I'll go ahead and make virtio the
> default for qemu configurations now. We expect to move back to nvme once
> distros pick up release of qemu with io-thread support.
> 
> This is useful truncated / sparsefiles files with loopback file strategy
> documented here:
> 
> https://github.com/linux-kdevops/kdevops/blob/master/docs/testing-with-loopback.md
> 
> I'll soon re-test with real NVMe drives though as kdevops now has
> support for using them and I have some basic tests with PCIe passthrough
> (which kdevops also enables with 'make dynconfig').
> 
> For now I've just ran one full set of fstests, ie, the confidence is rather
> low for my preference. After publishing this I will the tests against one
> week's worth of testing to build confidence up to 100 tests. We'll see
> if some other tests fail with a lower failure rate after that.
> 
> But for now I figured I'd publish preliminary results on the first run.
> Some failures seem like test bugs. Some other failures are likely real and
> require investigation.
> 
> Often we just commit into kdevops test results / expunges, but this is
> the first time publishing actual results on the mailing list. The commit
> logs detail the methodology to collect things results and go step by
> step so to help others who may want to try to start baselines with other
> filesystems, etc.
> 
> You are more than welcomed to also contribute testing and your own
> results in your own kdevops namespace, the more we have the better
> (within reason of course).
> 
> The tests found to be common in at least 2 secions go in the all.txt
> expunge list. Since at LSFMM we've been requested to store results
> this set of results go with results archived in XZ format and
> demonstrate how to list files in it, and also get results for failures
> out. I provide a simple super cursory review of the test failures as well.
> 
> The test bugs seem related to quotes, but it's not clear to me why
> this wasn't detected in other tests before.
> 
> What I'd like to know, is if this email is useful to the XFS development
> community. Should we strive to do this more often?
> 
> Here are failures found in at least more than one section:
> 
> cat workflows/fstests/expunges/6.5.0-rc3-next-20230725/xfs/unassigned/all.txt
> 
> # lazy baseline entries are failures found at least once on multiple XFS test
> # sections. To see the actual *.bad files and *.dmesg files you can use:
> #
> # tar -tOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz
> #
> # For example to see all generic/175 failures:
> #
> # tar -tOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 2>&1 | grep generic | grep 175
> # 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.out.bad
> # 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.full
> # 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.dmesg
> # 6.5.0-rc3-next-20230725/xfs_reflink/generic/175.out.bad
> # 6.5.0-rc3-next-20230725/xfs_reflink/generic/175.full
> # 6.5.0-rc3-next-20230725/xfs_reflink/generic/175.dmesg
> # 6.5.0-rc3-next-20230725/xfs_reflink_4k/generic/175.out.bad
> # 6.5.0-rc3-next-20230725/xfs_reflink_4k/generic/175.full
> # 6.5.0-rc3-next-20230725/xfs_reflink_4k/generic/175.dmesg
> # 6.5.0-rc3-next-20230725/xfs_rtdev/generic/175.out.bad
> # 6.5.0-rc3-next-20230725/xfs_rtdev/generic/175.full
> # 6.5.0-rc3-next-20230725/xfs_rtdev/generic/175.dmesg
> #
> # And now to see one individual file:
> #
> # tar -xOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.out.bad
> # tar -xOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.dmesg
> #
> generic/175 # seems like a test bug - lazy baseline - failure found in at least two sections
> generic/297 # seems like a test bug - lazy baseline - failure found in at least two sections
> generic/298 # seems like a test bug - lazy baseline - failure found in at least two sections
> generic/471 # race against loop? - lazy baseline - failure found in at least two sections
> generic/563 # needs investigation - lazy baseline - failure found in at least two sections
> xfs/157 # needs investigation - lazy baseline - failure found in at least two sections
> xfs/188 # unclear - lazy baseline - failure found in at least two sections
> xfs/205 # unclear - lazy baseline - failure found in at least two sections
> xfs/432 # test bug: blocksize should detect sector size - lazy baseline - failure found in at least two sections
> xfs/506 # needs investigation - lazy baseline - failure found in at least two sections
> xfs/516 # needs investigation - lazy baseline - failure found in at least two sections
> 
> Here are failures found in just the test section which enables reflinks
> but disables rmapbt:
> 
> cat workflows/fstests/expunges/6.5.0-rc3-next-20230725/xfs/unassigned/xfs_reflink_normapbt.txt
> 
> # For exmaple to see these failures:
> #
> # tar -tOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 2>&1 | grep xfs | grep normap | grep 301
> #
> # 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/xfs/301.out.bad
> # 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/xfs/301.full
> # 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/xfs/301.dmesg
> 
> # To see one file output:
> # tar -xOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/xfs/301.out.bad
> xfs/301 # needs investigation
> 
> And here are failures found only on the realtime device, most are likely
> test bugs which means we gotta enhance the test to skip the realtime
> device or learn to use it, but some seem like real failures:
> 
> cat workflows/fstests/expunges/6.5.0-rc3-next-20230725/xfs/unassigned/xfs_rtdev.txt
> 
> # For example to see rtdev's generic/012 related files:
> #
> # tar -tOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 2>&1 | grep xfs | grep rtdev | grep 012
> #
> # To see the generic/012 out.bad file:
> # tar -xOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 6.5.0-rc3-next-20230725/xfs_rtdev/generic/012.out.bad
> #
> generic/012 # needs investigation
> generic/013 # needs investigation
> generic/015 # might be a test bug
> generic/016 # needs investigation
> generic/021 # needs investigation
> generic/022 # needs investigation
> generic/027 # might be a test bug
> generic/058 # needs investigation
> generic/060 # needs investigation
> generic/061 # needs investigation
> generic/063 # needs investigation
> generic/074 # needs investigation
> generic/075 # needs investigation
> generic/077 # might be a test bug
> generic/096 # might be a test bug
> generic/102 # might be a test bug
> generic/112 # needs investigation
> generic/113 # needs investigation
> generic/171 # might be a test bug
> generic/172 # might be a test bug
> generic/173 # might be a test bug
> generic/174 # might be a test bug
> generic/204 # might be a test bug
> generic/224 # might be a test bug
> generic/226 # might be a test bug
> generic/251 # ran out of space and then corruption?
> generic/256 # might be a test bug
> generic/269 # might be a test bug
> generic/270 # might be a test bug
> generic/273 # might be a test bug
> generic/274 # might be a test bug
> generic/275 # might be a test bug
> generic/300 # might be a test bug
> generic/312 # might be a test bug
> generic/361 # might be a test bug
> generic/371 # might be a test bug
> generic/416 # might be a test bug
> generic/427 # might be a test bug
> generic/449 # might be a test bug
> generic/488 # might be a test bug
> generic/511 # might be a test bug
> generic/515 # might be a test bug
> generic/520 # needs investigation
> generic/551 # needs investigation
> generic/558 # might be a test bug
> generic/562 # never completed
> 
>   Luis
