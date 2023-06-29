Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0F742ABB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjF2Qld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjF2Qld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6530F1;
        Thu, 29 Jun 2023 09:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF7E6159D;
        Thu, 29 Jun 2023 16:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC5C433C8;
        Thu, 29 Jun 2023 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688056891;
        bh=EjjUBOKKuMp45+GsKNXJ1r+PJqrIeTFlP3VTINPAjfE=;
        h=Date:From:To:Cc:Subject:From;
        b=IGhSSKBCEpV6VTO6wKdtINb8eQCgVkKDuNYGTeQvp+XKqai+6sBV7cvk/JqhR4XrD
         aj2uRDEm70iK2oEr9s77iwSQatJQkWHEKwkMFbOgRxvZMX+eAS31cwiI+OwIeAodWS
         X+yuptXOEIPmsd/WFq06UqDWwU72/OcwwdsFhg0T28xrp642Pnjy/EH69g4t5F+A0L
         Z6Br5SQDzjPnDj9yYkca+j394YakZ+GUsseuPOg/KL494gppVjpOgygUA9fFf+2DCB
         xeF607hTtUMaSJ8fkWnYXM0EssWViS+r9/D7tkma2BlgIhRpxfdhySD1kAvHCKY+a/
         PClqCYrHQUXkQ==
Date:   Thu, 29 Jun 2023 09:41:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, torvalds@linux-foundation.org
Cc:     dchinner@redhat.com, hch@lst.de, leo.lilong@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: new code for 6.5
Message-ID: <168805669039.2186118.13633298500357673357.stg-ugh@frogsfrogsfrogs>
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

Hi Linus,

Please pull this branch with changes for xfs for 6.5-rc1.  There's not
much going on this cycle -- the large extent counts feature graduated,
so now users can create more extremely fragmented files! :P  The rest
are bug fixes; and I'll be sending more next week.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-2

for you to fetch changes up to c3b880acadc95d6e019eae5d669e072afda24f1b:

xfs: fix ag count overflow during growfs (2023-06-13 08:49:20 -0700)

----------------------------------------------------------------
New code for 6.5:

* Fix a problem where shrink would blow out the space reserve by
declining to shrink the filesystem.
* Drop the EXPERIMENTAL tag for the large extent counts feature.
* Set FMODE_CAN_ODIRECT and get rid of an address space op.
* Fix an AG count overflow bug in growfs if the new device size is
redonkulously large.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
xfs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method

Darrick J. Wong (2):
xfs: don't deplete the reserve pool when trying to shrink the fs
xfs: drop EXPERIMENTAL tag for large extent counts

Long Li (1):
xfs: fix ag count overflow during growfs

fs/xfs/libxfs/xfs_fs.h |  2 ++
fs/xfs/xfs_aops.c      |  2 --
fs/xfs/xfs_file.c      |  2 +-
fs/xfs/xfs_fsops.c     | 23 ++++++++++++++++-------
fs/xfs/xfs_super.c     |  4 ----
5 files changed, 19 insertions(+), 14 deletions(-)
