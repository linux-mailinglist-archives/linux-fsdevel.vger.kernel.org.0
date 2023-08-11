Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660C4779BA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 01:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjHKXtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 19:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjHKXtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB430D7
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 16:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97701663FB
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 23:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C2C433C7;
        Fri, 11 Aug 2023 23:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691797732;
        bh=EMmzNb7Hc1ItGqYjTpqptjG1HTaPGsiLkrVd5MLD1tk=;
        h=From:To:Cc:Subject:Date:From;
        b=KlmGR6iQp7gEDNiYnLqJdGuxq1jH5WJ5Ag4+Chj/m9RcJULqqvxy/d+JSFfA2vC7K
         CTySepfwKMPFfnivAZF8LX6GISij95ozpPa2AT0D008zg/JNjvV4NxMHFJgCAL3mbL
         hYYlL6HSYgJInJDmfUrdgKqnmwUQAfeAMnnWWwCgBH7t5c59lDrIrQBpUSRbbkyLrh
         wZgw5a4hXxTbzvGcN/Bu4mdnyg/psPg6dFYhjPPTQINVlpwQFEeL0kOtOb3/oAwZBx
         uxmNIfSBNr6qrP11Knkw5EBgpnQTr/klVaAUMBJL4wIiftZ6xetGa2qQLtMILzXegN
         mZNiQMKnGgaRw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 6.5-rc6
Date:   Sat, 12 Aug 2023 08:48:50 +0900
Message-ID: <20230811234850.101951-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Linus,

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.5-rc6

for you to fetch changes up to fe9da61ffccad80ae79fadad836971acf0d465bd:

  zonefs: fix synchronous direct writes to sequential files (2023-08-10 12:59:47 +0900)

----------------------------------------------------------------
zonefs fixes for 6.5-rc6

 - The switch to using iomap for executing direct synchronous write to
   sequential files using zone append BIO overlooked cases where the BIO
   built by iomap is too large and needs splitting, which is not allowed
   with zone append. Fix this by using regular write commands instead.
   The use of zone append commands will be reintroduces later with
   proper support from iomap.

----------------------------------------------------------------
Damien Le Moal (1):
      zonefs: fix synchronous direct writes to sequential files

 fs/zonefs/file.c   | 111 ++---------------------------------------------------
 fs/zonefs/super.c  |   9 +----
 fs/zonefs/zonefs.h |   2 -
 3 files changed, 4 insertions(+), 118 deletions(-)
