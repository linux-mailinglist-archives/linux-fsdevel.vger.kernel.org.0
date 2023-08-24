Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0552F787226
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 16:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbjHXOsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241896AbjHXOsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CB21BCD;
        Thu, 24 Aug 2023 07:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 029D061ED9;
        Thu, 24 Aug 2023 14:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57170C433C8;
        Thu, 24 Aug 2023 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692888460;
        bh=i0im3+Fqe3jYhNnEH7ceWxvAIHoLfG9Hzv/39cxHlOM=;
        h=From:To:Cc:Subject:Date:From;
        b=I9EvEq42TS16eJRK+2/KvgWIqMppNvdoPCMD97bu5n1gbJvuLPKXWB4O91S7W/Fvr
         KFWssGD2e/hIU+HGf3Ko5854Yq23EIEij1djU/YNEOKSCEtecLUW1wTHS/UNkFtjL/
         1lQFFeGp677r9PGIXZ6Uq9Ehuvm9HswVpzEYEasIsU4KtMZuaKLAOD8Z108TxoNKRW
         ZagIqVpbFzqc1/tNtkVQ/XH9b7jiXH+Kog2JYEdihaxEBflnj1qpwXLWH34cSNLH4N
         ZU9LyOYblJk1gGMlGf23NTF7RDdKFOanXH2ssvcxPnF3jP8kPbp1l6GFJIDLMmt+lB
         PVO0j/RDA2eMA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] autofs fixes
Date:   Thu, 24 Aug 2023 16:47:33 +0200
Message-Id: <20230824-komfort-aufkam-7a2b789dd532@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=brauner@kernel.org; h=from:subject:message-id; bh=i0im3+Fqe3jYhNnEH7ceWxvAIHoLfG9Hzv/39cxHlOM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ8zy2SOPZjm82suYVlnfwtLm7fYhvlOGRyPn8+yem1VETc MntaRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ47zAyvBOR/FOT+PWV7ap4gZtNJ+ eZt3yXUpMtu+f7Y4mFqc3jQEaG3YJ96T3OwfmH2YKPXPmjsiDjQWiMe8CbFRE9onc3PYxiBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This fixes a memory leak in autofs reported by syzkaller and a missing
conversion from uninterruptible to interruptible wake up when autofs
is in catatonic mode.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.5-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.autofs

for you to fetch changes up to 17fce12e7c0a53f0bed26af231a2a98a34d34c60:

  autofs: use wake_up() instead of wake_up_interruptible(() (2023-08-04 13:57:34 +0200)

Please consider pulling these changes from the signed v6.6-vfs.autofs tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-vfs.autofs

----------------------------------------------------------------
Fedor Pchelkin (1):
      autofs: fix memory leak of waitqueues in autofs_catatonic_mode

Ian Kent (1):
      autofs: use wake_up() instead of wake_up_interruptible(()

 fs/autofs/waitq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
