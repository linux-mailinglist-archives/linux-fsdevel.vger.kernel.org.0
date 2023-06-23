Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99F73B5C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 12:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFWK6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWK6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2681BCA;
        Fri, 23 Jun 2023 03:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C4461A1D;
        Fri, 23 Jun 2023 10:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D3DC433C8;
        Fri, 23 Jun 2023 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687517900;
        bh=25fIr3PopiCHtulS02FXujGMe2mNjiZ0I+FrvBTiG5U=;
        h=From:To:Cc:Subject:Date:From;
        b=VUquvolySvSCjvCTBAqsxqaF3AKCTrHkal3EIQBuJXifzEAW3UGRq1RkYMoUh23AD
         M+MfVY43exAibELouvE2KbCFA/+msGYt7IxBo9+iTRW7RSFeATD8EcsNYwSlp/yZYz
         dwFZqSns1r+BTZEuLDcyA7q85Q8BdhvinDkVes+ve7qABjYwcKbCVPaGR1CjOQlNrU
         uTJ3g/d0VlVsAwCymg/D7+JkkUdpf1Vaye8pVTHnh/J2Qr5pzjFN65Eoy51Of6MHWq
         ezrbciKzI0ZKw82bBgrTC6idxRI46i8VNJmhlhblBVLL2My6YVr9Xa0mXIMYTyPH/y
         +5zndUgv4EAog==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs: ntfs
Date:   Fri, 23 Jun 2023 12:58:08 +0200
Message-Id: <20230623-pflug-reibt-3435a40349d3@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=brauner@kernel.org; h=from:subject:message-id; bh=25fIr3PopiCHtulS02FXujGMe2mNjiZ0I+FrvBTiG5U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMrdpzx/aqSfjsrvJ5hb1qbxe1S3Io7vj6IPyJxR9PP7mU NW8VOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai0Mvwm6X288O5K3bsfhus/OXuk/ g7ky95xEurmwfqHZM4aHPMoY2R4ZubtJu04IeldrP5tU7nKVbJ6ekqNE8+aOS+INV90xVfBgA=
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
This contains a pile of various smaller fixes for ntfs. There's really
not a lot to say about them. I'm just the messenger, so this is an
unusually short pull request.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.4-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/fs.ntfs

for you to fetch changes up to aa4b92c5234878d55da96d387ea4d3695ca5e4ab:

  ntfs: do not dereference a null ctx on error (2023-05-24 11:10:14 +0200)

Please consider pulling these changes from the signed v6.5/fs.ntfs tag.

Thanks!
Christian

----------------------------------------------------------------
v6.5/fs.ntfs

----------------------------------------------------------------
Colin Ian King (1):
      ntfs: remove redundant initialization to pointer cb_sb_start

Danila Chernetsov (1):
      ntfs: do not dereference a null ctx on error

Deming Wang (1):
      ntfs: Correct spelling

Shaomin Deng (1):
      ntfs: Remove unneeded semicolon

 fs/ntfs/attrib.c   |  2 +-
 fs/ntfs/compress.c |  2 +-
 fs/ntfs/mft.c      | 36 +++++++++++++++++++-----------------
 fs/ntfs/super.c    |  4 ++--
 4 files changed, 23 insertions(+), 21 deletions(-)
