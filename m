Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4720565224F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 15:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiLTOTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 09:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiLTOSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:18:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C6E53;
        Tue, 20 Dec 2022 06:18:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA1661473;
        Tue, 20 Dec 2022 14:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6088AC433EF;
        Tue, 20 Dec 2022 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671545879;
        bh=9w9mUpOi4j/n7V+26T6rTz39VVMp4D5rzvOlDNl1rog=;
        h=From:To:Cc:Subject:Date:From;
        b=CiIUCoTtBPLvhr7noYZBUfo0rFO41nmEai7Y9mD7czhlrVwqWGZhZgiGbNTjeDu8j
         OkNDWB9mBQMSaP/YVkK3nQ6ZketVFR8vpN9cA5x75dxA8SFfdJTOPVXliMITt0NAh9
         VLGPUL5WIBZsoOGqEO8AZt9XN5BY+WA+/+34qeENofuWqYzfqminpdZU+P46lgSjmw
         vW7yqpH5qM//g7FUwDGff+Zbz+BHACj08saLZOAjG4ejoGIfowiLbz4lsYkJVDLvrG
         G55PYmReLAlGTUWvRLf3fCF9hyCEQsq08EysRZVJfuzfqn+SATvyTFs2RWckdbs0jw
         yFv9S6grSP3fQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Subject: [GIT PULL] vfsuid fix for v6.2-rc1
Date:   Tue, 20 Dec 2022 15:17:43 +0100
Message-Id: <20221220141743.813176-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=brauner@kernel.org; h=from:subject; bh=9w9mUpOi4j/n7V+26T6rTz39VVMp4D5rzvOlDNl1rog=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQvPPz/QEGOX8CVbJ3HAt+MiiY96Ti4+bkv42zjoG33zvRX r34Y3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR5SKGf4rftTY39zqc93L64ftJUv Xgtk5nvaC+lvdvw21kuENCvjL84ZooJ+jSxud+j1Vzq+ublZctEiadmVqnEbjiG39bmcBhdgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This moves the ima specific vfs{g,u}id_t comparison helpers out of the header
and into the one file in ima where they are used. We shouldn't incentivize
people to use them by placing them into the header. As discussed and suggested
by Linus in [1] let's just define them locally in the one file in ima where
they are used.

Link: https://lore.kernel.org/lkml/CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com [1]

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

No build failures or warnings were observed. All old and new tests in fstests,
selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 764822972d64e7f3e6792278ecc7a3b3c81087cd:

  Merge tag 'nfsd-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2022-12-12 20:54:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.vfsuid.ima.v6.2-rc1

for you to fetch changes up to 2c05bf3aa0741f4f3c72432db7801371dbbcf289:

  mnt_idmapping: move ima-only helpers to ima (2022-12-13 12:28:51 +0100)

Please consider pulling these changes from the signed fs.vfsuid.ima.v6.2-rc1 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.vfsuid.ima.v6.2-rc1

----------------------------------------------------------------
Christian Brauner (1):
      mnt_idmapping: move ima-only helpers to ima

 include/linux/mnt_idmapping.h       | 20 --------------------
 security/integrity/ima/ima_policy.c | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 20 deletions(-)
