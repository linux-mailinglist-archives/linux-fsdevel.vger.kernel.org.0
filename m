Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE6711AEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjEZAA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjEZAAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E969C;
        Thu, 25 May 2023 17:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACCA564B53;
        Fri, 26 May 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1857EC433EF;
        Fri, 26 May 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685059221;
        bh=Rv/9AaaPRgSQNsKPeSqBSjfB5dbXn+qZlod3vzY8KXk=;
        h=Date:From:To:Cc:Subject:From;
        b=bV1/JRerXd8uZxRqC+jRCHQ5NGH+jb0rTykBKEgKtXkYiMaprwXA/9qq1EZzD16oJ
         I6OX67bgc3xZ99R8Mf8RBhpIpOrwoT8YuD9v1kQhdY9f1HPPg73dMrefcejMYTDuDZ
         rVKQp8U6SGjBfpUUsVRRE+RB7mEiLzLPIDOWm8qrVy+rgKiPErVzof9A9+Z1TytLB2
         OEKXAZyjZUis8OR12VFbUjYjI1teUaLmeM+HPfFeI8znFxpB7wD9+toCR6qbCfR7mh
         09cirkh1BNzKNw5EYdlAYsHVg5uff9x67TmuDRaV6wPG8WWHhf/o+9VztIAAQlCgXo
         XwC5npTMHhL1g==
Date:   Thu, 25 May 2023 17:00:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Catherine Hoang <catherine.hoang@oracle.com>
Subject: [MEGAPATCHSET v25 1/2] xfs: online repair, part 1
Message-ID: <20230526000020.GJ11620@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone,

I've finished merging parent pointers into what is now part 2 of online
repair.  Part 1 hasn't changed much since the last posting at the end of
2022, aside from various reorganizations of the directory repair, dotdot
repair, and the tempfile/orphanage infrastructure to support the bits
that part 2 will want.  Zorro merged all the pending fstests changes to
support and test everything in part 1, so that part is done.

In other words, I'm formally submitting part 1 for inclusion in 6.5.

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
the last 14 months.  So far, no damage has resulted from these
operations.

Fuzz and stress testing of online repairs have been running well for a
year now.  As of this writing, online repair can fix slightly more
things than offline repair, and the fsstress+repair long soak test has
passed 200 million repairs with zero problems observed.  All issues
observed in that time have been corrected in this submission.

(For comparison, the long soak fsx test recently passed 99 billion file
operations, so online fsck has a ways to go...)

This is actually an excerpt of the xfsprogs patches -- I'm only mailing
the changes to xfs_scrub; there are substantially more bug fixes and
improvements to xfs_{db,repair,spaceman} that I've made along the way.

--D
