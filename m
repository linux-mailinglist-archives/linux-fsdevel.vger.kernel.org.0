Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5273DFD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjFZMw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjFZMwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:52:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD310D
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 05:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2144F60E00
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 12:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35415C433C8;
        Mon, 26 Jun 2023 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687783906;
        bh=CRfd+fm3QT1mCmPU7Q0A9vFAajVfwBbhh4Kqthxev6g=;
        h=From:To:Cc:Subject:Date:From;
        b=UDFC2wjOEcP9nurdOVjtxMKWZZ2nNqGbpk5Yp7InQuQ6Qy5f06wxs0bqjfDQpAUR/
         F4lG26VzK41wLOEFrGe0rBe3aIW6qDxUVtLINh1Q86bwFXhEZ0FZuFdzCxycidlCrj
         69arsH3GeYHhZmTqshH5xAq4A/LkN9N1VFIvSyE06ApfHh2ej9w6EMEdJCUZouNnAl
         tlkA+3oWIKurRSLlfLu8xWq6yAISff7x19PI9PNUAntFYg6iCkE/fgJ9iKtnjD6QKU
         oTH5mtdn8g1B6els3vfw8N/poZaOmUMzly3dGa0UVT8ImfDgCI22pG5vz4i7o6m/Rh
         Tzj8plPGi7SHw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 6.5-rc1
Date:   Mon, 26 Jun 2023 21:51:45 +0900
Message-Id: <20230626125145.1865163-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Linus,

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.5-rc1

for you to fetch changes up to 8812387d056957355ef1d026cd38bed3830649db:

  zonefs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method (2023-06-14 08:51:18 +0900)

----------------------------------------------------------------
zonefs changes for 6.5

 - Modify the synchronous direct write path to use iomap instead of
   manually coding issuing zone append write BIOs, from me.

 - Use the FMODE_CAN_ODIRECT file flag to indicate support from direct
   IO instead of using the old way with noop direct_io methods, from
   Christoph.

----------------------------------------------------------------
Christoph Hellwig (1):
      zonefs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method

Damien Le Moal (1):
      zonefs: use iomap for synchronous direct writes

 fs/zonefs/file.c   | 208 ++++++++++++++++++++++++++++-------------------------
 fs/zonefs/super.c  |   9 ++-
 fs/zonefs/zonefs.h |   2 +
 3 files changed, 121 insertions(+), 98 deletions(-)
