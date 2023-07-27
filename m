Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDBF765B4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjG0SVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 14:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjG0SVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:21:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9030DF;
        Thu, 27 Jul 2023 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KjXNXgCpSbcw+Ak4vvqhiXdosw6fqv3FoC2eku2PFsk=; b=yGeOAILaRG5hOQ2r06/5WNn5Ow
        1lZuBPy4/4IbmT0uZR+k+i8GtNDtlgTLZhA/vpo6EW87vJnG5j9nelJsPpsSLEH6Jx36T3fnfXfDp
        dmZo1BTJX0QBrEsS3sr9c8Tv3G8Ec7AQs+2f4dyC9hqEoJEPiunxg6OI1qpzePCj05Rrlsv+aXSWt
        p3ep2YitSJEfyMpmmHwvwHeGis5GvnV1VwABYpw2NsqhYyT+/0d5en2HWVYcnvu4U4nLnI9G9WXOo
        WeOkcuNcvf7IOscq9jiIDnRzWhMLkwLaPmXotDwXub4Fr/35npcCjYXhK+WP+m6ZBZgZf+OlznnPh
        CwDLvrPg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qP5cF-00087X-0j;
        Thu, 27 Jul 2023 18:21:35 +0000
Date:   Thu, 27 Jul 2023 11:21:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-xfs@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Chandan Babu R <chandan.babu@oracle.com>
Subject: xfs kdevops baseline for next-20230725
Message-ID: <ZMK1r91ByQERwDK+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd like to see if this is useful so feedback is welcomed.

I recently had a reason to establish a baseline for XFS as we start
testing some new fatures we've been working on to ensure we don't create
regressions. I've been using kdevops for this work, its on github [0] and
on gitlab for those that prefer that [1] and tested against linux-next
tag next-20230725, with its respective generic kernel configuration
which has evolved over time for kdevops which let's us test with kdevops
with qemu / virtualbox / all cloud providers [2]. We fork fstests [3] so
have a small delta, mostly reverts to help stability on testing as
Chandan found regressions in some new fstest changes.

[0] https://github.com/linux-kdevops/kdevops.git
[1] https://gitlab.com/linux-kdevops/kdevops.git
[2] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/bootlinux/templates/config-next-20230725
[3] https://github.com/linux-kdevops/fstests

The sections tested for are:

xfs_crc
xfs_reflink
xfs_reflink-normapbt
xfs_reflink_1024
xfs_reflink_2k
xfs_reflink_4k
xfs_nocrc
xfs_nocrc_512
xfs_nocrc_1k
xfs_nocrc_2k
xfs_nocrc_4k
xfs_logdev
xfs_rtdev
xfs_rtlogdev

You can see what these sections represent in terms of xfs here:

https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/fstests/templates/xfs/xfs.config

The first order of business before even considering a set of changes is
getting baseline and building a high confidence in that baseline. We had
a technical debt as it's been a while before we get to establish and
publish a baseline with high confidence for XFS for linux-next. Hopefully this
will help us keep it moving forward.

The kdevops configuration used for this can be found here:

https://github.com/linux-kdevops/kdevops/blob/master/workflows/fstests/results/mcgrof/libvirt-qemu/20230727/kdevops.config

Worth noting is that virtio drives are used instead of NVMe since virtio
supports io-threads, and so we get less NVMe timouts on the guest which
have proven to cause major false positives for testing for a while as we
have seen on the stable testing. I'll go ahead and make virtio the
default for qemu configurations now. We expect to move back to nvme once
distros pick up release of qemu with io-thread support.

This is useful truncated / sparsefiles files with loopback file strategy
documented here:

https://github.com/linux-kdevops/kdevops/blob/master/docs/testing-with-loopback.md

I'll soon re-test with real NVMe drives though as kdevops now has
support for using them and I have some basic tests with PCIe passthrough
(which kdevops also enables with 'make dynconfig').

For now I've just ran one full set of fstests, ie, the confidence is rather
low for my preference. After publishing this I will the tests against one
week's worth of testing to build confidence up to 100 tests. We'll see
if some other tests fail with a lower failure rate after that.

But for now I figured I'd publish preliminary results on the first run.
Some failures seem like test bugs. Some other failures are likely real and
require investigation.

Often we just commit into kdevops test results / expunges, but this is
the first time publishing actual results on the mailing list. The commit
logs detail the methodology to collect things results and go step by
step so to help others who may want to try to start baselines with other
filesystems, etc.

You are more than welcomed to also contribute testing and your own
results in your own kdevops namespace, the more we have the better
(within reason of course).

The tests found to be common in at least 2 secions go in the all.txt
expunge list. Since at LSFMM we've been requested to store results
this set of results go with results archived in XZ format and
demonstrate how to list files in it, and also get results for failures
out. I provide a simple super cursory review of the test failures as well.

The test bugs seem related to quotes, but it's not clear to me why
this wasn't detected in other tests before.

What I'd like to know, is if this email is useful to the XFS development
community. Should we strive to do this more often?

Here are failures found in at least more than one section:

cat workflows/fstests/expunges/6.5.0-rc3-next-20230725/xfs/unassigned/all.txt

# lazy baseline entries are failures found at least once on multiple XFS test
# sections. To see the actual *.bad files and *.dmesg files you can use:
#
# tar -tOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz
#
# For example to see all generic/175 failures:
#
# tar -tOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 2>&1 | grep generic | grep 175
# 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.out.bad
# 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.full
# 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.dmesg
# 6.5.0-rc3-next-20230725/xfs_reflink/generic/175.out.bad
# 6.5.0-rc3-next-20230725/xfs_reflink/generic/175.full
# 6.5.0-rc3-next-20230725/xfs_reflink/generic/175.dmesg
# 6.5.0-rc3-next-20230725/xfs_reflink_4k/generic/175.out.bad
# 6.5.0-rc3-next-20230725/xfs_reflink_4k/generic/175.full
# 6.5.0-rc3-next-20230725/xfs_reflink_4k/generic/175.dmesg
# 6.5.0-rc3-next-20230725/xfs_rtdev/generic/175.out.bad
# 6.5.0-rc3-next-20230725/xfs_rtdev/generic/175.full
# 6.5.0-rc3-next-20230725/xfs_rtdev/generic/175.dmesg
#
# And now to see one individual file:
#
# tar -xOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.out.bad
# tar -xOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/generic/175.dmesg
#
generic/175 # seems like a test bug - lazy baseline - failure found in at least two sections
generic/297 # seems like a test bug - lazy baseline - failure found in at least two sections
generic/298 # seems like a test bug - lazy baseline - failure found in at least two sections
generic/471 # race against loop? - lazy baseline - failure found in at least two sections
generic/563 # needs investigation - lazy baseline - failure found in at least two sections
xfs/157 # needs investigation - lazy baseline - failure found in at least two sections
xfs/188 # unclear - lazy baseline - failure found in at least two sections
xfs/205 # unclear - lazy baseline - failure found in at least two sections
xfs/432 # test bug: blocksize should detect sector size - lazy baseline - failure found in at least two sections
xfs/506 # needs investigation - lazy baseline - failure found in at least two sections
xfs/516 # needs investigation - lazy baseline - failure found in at least two sections

Here are failures found in just the test section which enables reflinks
but disables rmapbt:

cat workflows/fstests/expunges/6.5.0-rc3-next-20230725/xfs/unassigned/xfs_reflink_normapbt.txt

# For exmaple to see these failures:
#
# tar -tOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 2>&1 | grep xfs | grep normap | grep 301
#
# 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/xfs/301.out.bad
# 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/xfs/301.full
# 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/xfs/301.dmesg

# To see one file output:
# tar -xOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 6.5.0-rc3-next-20230725/xfs_reflink_normapbt/xfs/301.out.bad
xfs/301 # needs investigation

And here are failures found only on the realtime device, most are likely
test bugs which means we gotta enhance the test to skip the realtime
device or learn to use it, but some seem like real failures:

cat workflows/fstests/expunges/6.5.0-rc3-next-20230725/xfs/unassigned/xfs_rtdev.txt

# For example to see rtdev's generic/012 related files:
#
# tar -tOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 2>&1 | grep xfs | grep rtdev | grep 012
#
# To see the generic/012 out.bad file:
# tar -xOJf workflows/fstests/results/mcgrof/libvirt-qemu/20230727/6.5.0-rc3-next-20230725.xz 6.5.0-rc3-next-20230725/xfs_rtdev/generic/012.out.bad
#
generic/012 # needs investigation
generic/013 # needs investigation
generic/015 # might be a test bug
generic/016 # needs investigation
generic/021 # needs investigation
generic/022 # needs investigation
generic/027 # might be a test bug
generic/058 # needs investigation
generic/060 # needs investigation
generic/061 # needs investigation
generic/063 # needs investigation
generic/074 # needs investigation
generic/075 # needs investigation
generic/077 # might be a test bug
generic/096 # might be a test bug
generic/102 # might be a test bug
generic/112 # needs investigation
generic/113 # needs investigation
generic/171 # might be a test bug
generic/172 # might be a test bug
generic/173 # might be a test bug
generic/174 # might be a test bug
generic/204 # might be a test bug
generic/224 # might be a test bug
generic/226 # might be a test bug
generic/251 # ran out of space and then corruption?
generic/256 # might be a test bug
generic/269 # might be a test bug
generic/270 # might be a test bug
generic/273 # might be a test bug
generic/274 # might be a test bug
generic/275 # might be a test bug
generic/300 # might be a test bug
generic/312 # might be a test bug
generic/361 # might be a test bug
generic/371 # might be a test bug
generic/416 # might be a test bug
generic/427 # might be a test bug
generic/449 # might be a test bug
generic/488 # might be a test bug
generic/511 # might be a test bug
generic/515 # might be a test bug
generic/520 # needs investigation
generic/551 # needs investigation
generic/558 # might be a test bug
generic/562 # never completed

  Luis
