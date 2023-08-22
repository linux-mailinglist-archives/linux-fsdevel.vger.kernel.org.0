Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE7783709
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 02:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjHVAWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 20:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjHVAWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:22:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077BA184;
        Mon, 21 Aug 2023 17:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ACAE633AD;
        Tue, 22 Aug 2023 00:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A03C433C7;
        Tue, 22 Aug 2023 00:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692663725;
        bh=S8dUBXf0RVR3IHxUc2d7j6ePxJ+jln0LQkw4r+sP8SU=;
        h=Date:From:To:Cc:Subject:From;
        b=IGlA2EjNxAq7EOpu9iI9mngcePz0P5u4X9tDzfs6j36BMUQRhnLlEIXPCfVaboy4s
         0CF9AZrZup5n/7bok6wsiqRNvREYqxc5fuB6ZkKO1+J/E/gK8oIuAMiGqpUk2QjhOt
         29ZfkEJUmYVl280n0VDaiPzlqnXzW4YCSCF8tqq/u+aiBivPoa5yUEHds60vthpsQj
         sezBvmqFrdLUuB3g5P1p1I8FE9zcYoM6sJt0PuGhtjw59t9jGQwZgz29eXfg9Eu+LS
         c8vdTjBz/0mKH1ZfVvzvEMjkvT/S7pqsbz4dVZS4s96/o64VdgTwsG9bLGXLUhPfdr
         o7tEzyS8WhHhg==
Date:   Mon, 21 Aug 2023 17:22:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     dchinner@redhat.com, Carlos Maiolino <cem@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Shirley Ma <shirley.ma@oracle.com>,
        Greg Marsden <greg.marsden@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Catherine Hoang <catherine.hoang@oracle.com>
Subject: [ANNOUNCE] xfs: online repair is completely finished!
Message-ID: <20230822002204.GA11263@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

I am /very/ pleased to announce that online repair for XFS is completely
finished.  For those of you who have been following along all this time,
this means that part 1 and part 2 are done!

With the addition in part 2 of directory parent pointers patchset,
xfs_scrub gains the ability to correct broken links and loops in the
directory tree.  Part 2 also adds a faster FITRIM implementation,
improved detection of malicious filenames, and a vectorized scrub mode
that cuts the runtime by 20%.

Code coverage averages around ~75% for the online fsck code (and ~85%
for the rest of XFS), and the kernel can now rebuild 90% of the
corruptions that can manifest on a mountable filesystem.

The code itself lives in my git trees, which I've just updated:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=vectorized-scrub
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=vectorized-scrub
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=scrub-directory-tree

As I have now been testing online repair in its various stages [on my
testing cloud] for two years and the fstests cloud has nearly cleared
300 million successful filesystem repairs, I am discontinuing all
notices about "This is an extraordinary way to destroy your data".
It works, and it's time to merge it to get broader testing.

A big thank you to Allison Henderson, Catherine Hoang for their work on
the directory parent pointers feature; Chandan Babu for reviewing the
design documentation; and Dave Chinner and Matthew Wilcox for staring
at the code longer than is probably healthy. 8-)

Stay tuned for more exciting announcements!

--Darrick
