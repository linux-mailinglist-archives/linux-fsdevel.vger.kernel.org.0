Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F337700BDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbjELPc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbjELPcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 11:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CE74EF6;
        Fri, 12 May 2023 08:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B602A657DA;
        Fri, 12 May 2023 15:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114AFC4339B;
        Fri, 12 May 2023 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683905517;
        bh=mFvCEEhbJP619/ZqNB7RiK8wju//RgrLnTr4ORbp1q4=;
        h=From:To:Cc:Subject:Date:From;
        b=fhpPpa6Oh3iVsM0DtccbawoYJuYi3zS4gEdaV1YLUx202Oy+7W+l91Up3XcwVfl7S
         xhoBgxzWmV9B1uRUFEUJETBtT5uAsuiaS+D+WrhNKkKx6EG9JEHerQvnbzMSIm1aa/
         +7OP9qxpb8LFkN/7ceYVlTfyOdbaHw7wn8FcXG1TTF9sK2b5B7UM19gxeCGH9Ex38y
         coKF6fzwn2mCt8N7WsU2LXDMJONjCqMpIo+mdKtyUuAHyBGZBEi+HWYVC7OIsCz9QW
         Juv9kYkU7+MRBK9uv2zpKC/WA9bfpjTBoCKpnAsdMr1Wsm4xjTEeFQqEnFkI741kpT
         ddAs8CKPj+vOQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date:   Fri, 12 May 2023 17:31:51 +0200
Message-Id: <20230512-physik-wahlen-16e1f37abbd6@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=brauner@kernel.org; h=from:subject:message-id; bh=mFvCEEhbJP619/ZqNB7RiK8wju//RgrLnTr4ORbp1q4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTERR810zGfM4tpatMnUdfdCqHLcmabfVL7Molt3vv3NwLT JS2iOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy6AUjw+eWbX/uKU8sOblfcPFExh OzSoTyQlb8vBOp1PZiuvbe3luMDHt837n+qeq7cdQh7Y1I/YmNXlN2fAv/WVd/hGt53fO7WzgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
During the pipe nonblock rework that made it in the check for both
O_NONBLOCK and IOCB_NOWAIT was dropped. Both checks need to be performed
to ensure that files without O_NONBLOCK but IOCB_NOWAIT don't block when
writing to or reading from a pipe.

This just contains the fix adding the check for IOCB_NOWAIT back in.

---

On a personal note, I'm still traveling because of LSFMMBPF (I'm
probably missing 5 letters and rearranging 3) and LSS
and will only be back on a regular schedule starting Tuesday.

/* Testing */
clang: Ubuntu clang version 15.0.6
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on 6.4-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs/v6.4-rc1/pipe

for you to fetch changes up to c04fe8e32f907ea668f3f802387c1148fdb0e6c9:

  pipe: check for IOCB_NOWAIT alongside O_NONBLOCK (2023-05-12 17:17:27 +0200)

Please consider pulling these changes from the signed vfs/v6.4-rc1/pipe tag.

Thanks!
Christian

----------------------------------------------------------------
vfs/v6.4-rc1/pipe

----------------------------------------------------------------
Jens Axboe (1):
      pipe: check for IOCB_NOWAIT alongside O_NONBLOCK

 fs/pipe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
