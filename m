Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206EC744D72
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGBL3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 07:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBL3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 07:29:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F581A2;
        Sun,  2 Jul 2023 04:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432BD60B62;
        Sun,  2 Jul 2023 11:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D39CC433C9;
        Sun,  2 Jul 2023 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688297344;
        bh=IUCviC13AmItREN5AZVPaPxUlkoMIFSbckdm3HjhMic=;
        h=From:To:Cc:Subject:Date:From;
        b=D9Rt+3o5NgpPGDOTRkFctHwJLih33L4Sb5uBfVCzHdZykxXkBfL8iJMUpwG7R1VRH
         RVU/ALEvQ8kkTEi5gyGD4D+2jyqtMvX+fsHKnc1V7IjFy1DP4NGp0+qEyiYgjoZVyV
         8znGY8+k4po/l2UFLA++W3UG7ti1J18kVXLjJfmBRH0uqFgIZDxnjrsMKTNItEj4Sr
         rk17m0kuZzPSMlXeZus+IOlJn4xATyiS90q/WyL0RmzGfSkNFHU93zGM9Y59XfZgOA
         CIE0s+mtGJPraXUqqyugUZuTmx+yPrnB1VDBRjIRhCSwpZKcRDX4YVO2ey+sKgCnXq
         nh3kL9RmWJa3w==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date:   Sun,  2 Jul 2023 13:28:43 +0200
Message-Id: <20230702-wohlklang-heilkraft-839e2439651b@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2123; i=brauner@kernel.org; h=from:subject:message-id; bh=IUCviC13AmItREN5AZVPaPxUlkoMIFSbckdm3HjhMic=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQsjE/Y3NT9Ln1vqXuNtZO+xaJ/zy5cuMfbusBdQrNfj6V3 NuPsjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImoczH8lVd+ajOv3OMnE69C/8x9Sf lp8+xXG06ND/7wzuJ8g8slaUaGGfW+54+Vz2F9PoPh6bYVhez/nr3t62HgkpuRfPuc2Ot4ZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a fix for the backing file work from this cycle. When
init_file() failed it would call file_free_rcu() on the file allocated
by the caller of init_file(). It naively assumed that the correct
cleanup operation would be called depending on whether it is a regular
file or a backing file. However, that presupposes that the FMODE_BACKING
flag would already be set which it won't be as that is done in the
caller of init_file().

Fix that bug by moving the cleanup of the allocated file into the caller
where it belongs in the first place. There's no good reason for
init_file() to consume resources it didn't allocate. This is a mainline
only fix and was reported by syzbot. The fix was validated by syzbot
against the provided reproducer.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

All patches are based on current mainline. No build failures or warnings
were observed. All old and new tests in fstests, selftests, and LTP pass
without regressions.

The following changes since commit 995b406c7e972fab181a4bb57f3b95e59b8e5bf3:

  Merge tag 'csky-for-linus-6.5' of https://github.com/c-sky/csky-linux (2023-07-01 21:12:32 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.fixes

for you to fetch changes up to dff745c1221a402b4921d54f292288373cff500c:

  fs: move cleanup from init_file() into its callers (2023-07-02 13:15:49 +0200)

Please consider pulling these changes from the signed v6.5/vfs.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
v6.5/vfs.fixes

----------------------------------------------------------------
Amir Goldstein (1):
      fs: move cleanup from init_file() into its callers

 fs/file_table.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)
