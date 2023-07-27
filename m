Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8A765EFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 00:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjG0WMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjG0WMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137292723;
        Thu, 27 Jul 2023 15:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99E8861F5D;
        Thu, 27 Jul 2023 22:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E9C433C7;
        Thu, 27 Jul 2023 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690495919;
        bh=a90k990ogojxvVdeCNt26tl6xkRdkM2R09eaTB3375s=;
        h=Date:From:To:Cc:Subject:From;
        b=r6lL+TIJ/0+qYpdq14Vs8basCjozEsPa3U5o9o+9k1fjNr8vrTtHssgovsNatm1hC
         ajUPM/1K/LNo89xOV3oHPmO0XULNJIW5p6zfyIXh62M/f5JWE5RJKaqzOyzuOag+hS
         qNQfKom0E4+l8low6O9K3JSoAojC6u9BDWEirGvoklC9gAilV+kDcaebq6/qthOv4w
         mT8SxVlYqpK2+aFuDil4TblzzGkK0TB3pLPuLdM9gcjXWe7XTaCukPgT3Rq1U8b1d2
         dh1AszS6+Ke8x06IK7+ZsznAQA5hghCOivHkVZUv7P/WT2JTqGeLTD+kg8EbG3NalR
         8vdTS30ziIDFA==
Date:   Thu, 27 Jul 2023 15:11:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        Chandan Babu R <chandanrlinux@gmail.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Catherine Hoang <catherine.hoang@oracle.com>
Subject: [MEGAPATCHSET v26] xfs: online repair, part of part 1
Message-ID: <20230727221158.GE11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone,

I've rebased the online fsck development branches atop 6.5, applied the
changes requested during the review of v25, and cleaned up the common
code as needed to make online fsck part 2 work more smoothly.  Part 2
has also grown a directory tree structure checker that can find and fix
un-tree like things.  I also added some simple performance counters that
are accessible via debugfs.

In other words, I'm formally submitting part 1 for inclusion in 6.6.

For this review, I would like people to focus the following:

- Are the major subsystems sufficiently documented that you could figure
  out what the code does?

- Do you see any problems that are severe enough to cause long term
  support hassles? (e.g. bad API design, writing weird metadata to disk)

- Can you spot mis-interactions between the subsystems?

- What were my blind spots in devising this feature?

- Are there missing pieces that you'd like to help build?

- Can I just merge all of this?

The one thing that is /not/ in scope for this review are requests for
more refactoring of existing subsystems.

I've been running daily online **repairs** of every computer I own for
the last 16 months.  So far, no damage has resulted from these
operations.

Fuzz and stress testing of online repairs have been running well for a
year now.  As of this writing, online repair can fix slightly more
things than offline repair, and the fsstress+repair long soak test has
passed 250 million repairs with zero problems observed.  All issues
observed in that time have been corrected in this submission.

(For comparison, the long soak fsx test recently passed 103 billion file
operations with only one corruption reported, so online fsck has a ways
to go...)

This is actually an excerpt of the full megapatchset -- I'm only sending
about 51 patches from the kernel branch, which is enough to rebuild the
space management btrees that don't require special effort.  I've left
for another day the remaining ~400 patches in part 1.

--D
