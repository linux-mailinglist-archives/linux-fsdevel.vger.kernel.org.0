Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29965525324
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 19:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356844AbiELRCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 13:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356847AbiELRBv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 13:01:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8866E8FB
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 10:01:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD29621B59;
        Thu, 12 May 2022 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652374888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=DwC7hsygrnevQUqOG2w0he+tKR8pDiLs6n0UOLzcNts=;
        b=L9TZCnGuzPorFun5j2mFI9B8ueBJCf9/eNWDdQ6IAIYO4SMiApzuvfjHc5RE9OYYZ0Pesl
        3BhWYRbe3VPq3OxRARq1ftJOM5wzG/uKfq+2zJK2LtjQi7efnzb7FF0toyJD+3qfqkqJtB
        Hknk58B7aONZdQz3KhV0hAw2AXzSzCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652374888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=DwC7hsygrnevQUqOG2w0he+tKR8pDiLs6n0UOLzcNts=;
        b=BwWKqSYqnunqN43/V1/g93nDJgRyoUVIN+QUDiNbd0JpalmRZgh3wTMA076XhoBNpMW3nZ
        OzVwyK2QmJGzcICg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD6112C141;
        Thu, 12 May 2022 17:01:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 61288A062A; Thu, 12 May 2022 19:01:28 +0200 (CEST)
Date:   Thu, 12 May 2022 19:01:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Three fixes for v5.18-rc7
Message-ID: <20220512170128.ivnuzvsspd4bbdyb@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.18-rc7

to get three fixes that I'd still like to get to 5.18.

* The fanotify change is a fixup of a missing sanity check in the
FAN_RENAME feature which went into 5.17 before it gets wider usage in
userspace.
* The udf patch is a fix for recently introduced filesystem corruption issue
* The writeback patch is a fix for race in inode list handling that can
lead to delayed writeback and possible dirty throttling stalls.

Top of the tree is c1ad35dd0548. The full shortlog is:

Amir Goldstein (1):
      fanotify: do not allow setting dirent events in mask of non-dir

Jan Kara (1):
      udf: Avoid using stale lengthOfImpUse

Jing Xia (1):
      writeback: Avoid skipping inode writeback

The diffstat is

 fs/fs-writeback.c                  |  4 ++++
 fs/notify/fanotify/fanotify_user.c | 13 +++++++++++++
 fs/udf/namei.c                     |  8 ++++----
 3 files changed, 21 insertions(+), 4 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
