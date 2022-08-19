Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C595995D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 09:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbiHSHSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbiHSHSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:18:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB0EE51;
        Fri, 19 Aug 2022 00:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE0CEB824F4;
        Fri, 19 Aug 2022 07:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A9EC433C1;
        Fri, 19 Aug 2022 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660893490;
        bh=urBqd6sIRU3x6OGrBbvlSl/MLtqpjSnSa5yBG6LG85U=;
        h=From:To:Cc:Subject:Date:From;
        b=EzTgxveXKG6RaPuiWCg5OL1nA6+W37vbIimNvAC3Mb3YdTdUMG7GirW7dF3s8YHGw
         7o2yhmFGYeuJPsb/xi8MA+QezhLDSy+m3VVxblZ813u3QfeWCh4OFiZnSqxcANQ6bi
         63pBjUwT4SMVj2xq4i5HpmhbZm4eSgjbRL0ka3B6kvbE8wUdyb12CHrxFVzQ14doVZ
         ZGoT13lAoImOFb45KcpBRN+HHzL2t/YhIsaaIl8bLYOE3VBIlWmZavxCATAMmwAHbi
         hG507ZrXL6BfEm03BNMLq3HrNE9X3GjxEs4FZvqaB9kqGh0M/F2Gd58fxURFZROJ6B
         0OcOmQDnPTHjQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] fscrypt: rework filesystem-level keyring
Date:   Fri, 19 Aug 2022 00:15:30 -0700
Message-Id: <20220819071532.221026-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series reworks the filesystem-level keyring to not use the keyrings
subsystem as part of its internal implementation (except for ->mk_users,
which remains unchanged for now).  This fixes several issues, described
in the first patch.  This is also a prerequisite for removing the direct
use of struct request_queue from filesystem code, as discussed at
https://lore.kernel.org/linux-fscrypt/20220721125929.1866403-1-hch@lst.de/T/#u

Eric Biggers (2):
  fscrypt: stop using keyrings subsystem for fscrypt_master_key
  fscrypt: stop holding extra request_queue references

 fs/crypto/fscrypt_private.h |  74 ++++--
 fs/crypto/hooks.c           |  10 +-
 fs/crypto/inline_crypt.c    |  83 +++----
 fs/crypto/keyring.c         | 476 +++++++++++++++++++-----------------
 fs/crypto/keysetup.c        |  89 +++----
 fs/crypto/keysetup_v1.c     |   4 +-
 fs/crypto/policy.c          |   8 +-
 fs/super.c                  |   2 +-
 include/linux/fs.h          |   2 +-
 include/linux/fscrypt.h     |   4 +-
 10 files changed, 387 insertions(+), 365 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1

