Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E946F4EED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 05:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjECDCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 23:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECDCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 23:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1291FCA;
        Tue,  2 May 2023 20:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690A7629E8;
        Wed,  3 May 2023 03:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E7DC433D2;
        Wed,  3 May 2023 03:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683082933;
        bh=Rf3elCEyDb+Cv+Z4BoVXFWk2JMNZeMlmtkFHzB1KUVg=;
        h=Subject:From:To:Cc:Date:From;
        b=rP+Xk1vWuob3O0rxXkP/YXRuEsPj0om0C+7IE5ahR+5+ieUxIsJoEmY3HBsy4PMTA
         n6xZzIokIeY97ElMjVot//s5iCDhmNjIMX6+zI+10AOsuyKpbTTFINc5VZ1mK39Sqd
         k9pQ/hl0x18/jjAa0CIEF8Ep+zafOl8S/V8nyEZ2eeuabfGLG++K3BcFsl3txUnW7n
         wzwFnehIE6wy/YDWWSwyVhh0qlwcAoLO6DF2Rl9nxEfpSFT0ogg+5JPcU4Bg7yTadG
         McE2iFDwxA8wZjQhXweVl7kLlQUL3hLjCcdJOE3tBTORiGr/jeBP0H6PFvgVrLcee9
         GivmQh3gbwISA==
Subject: [PATCHSET RFC v24.6 0/4] xfs: online repair for fs summary counters
 with exclusive fsfreeze
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, mcgrof@kernel.org,
        ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org
Date:   Tue, 02 May 2023 20:02:13 -0700
Message-ID: <168308293319.734377.10454919162350827812.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

A longstanding deficiency in the online fs summary counter scrubbing
code is that it hasn't any means to quiesce the incore percpu counters
while it's running.  There is no way to coordinate with other threads
are reserving or freeing free space simultaneously, which leads to false
error reports.  Right now, if the discrepancy is large, we just sort of
shrug and bail out with an incomplete flag, but this is lame.

For repair activity, we actually /do/ need to stabilize the counters to
get an accurate reading and install it in the percpu counter.  To
improve the former and enable the latter, allow the fscounters online
fsck code to perform an exclusive mini-freeze on the filesystem.  The
exclusivity prevents userspace from thawing while we're running, and the
mini-freeze means that we don't wait for the log to quiesce, which will
make both speedier.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-fscounters

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=repair-fscounters
---
 fs/super.c                       |   74 ++++++++++++++-
 fs/xfs/Makefile                  |    1 
 fs/xfs/scrub/fscounters.c        |  185 ++++++++++++++++++++++++++++----------
 fs/xfs/scrub/fscounters.h        |   20 ++++
 fs/xfs/scrub/fscounters_repair.c |   72 +++++++++++++++
 fs/xfs/scrub/repair.h            |    2 
 fs/xfs/scrub/scrub.c             |    8 +-
 fs/xfs/scrub/scrub.h             |    1 
 fs/xfs/scrub/trace.c             |    1 
 fs/xfs/scrub/trace.h             |   22 ++++-
 fs/xfs/xfs_super.c               |   20 ++++
 fs/xfs/xfs_super.h               |    2 
 include/linux/fs.h               |    3 +
 13 files changed, 348 insertions(+), 63 deletions(-)
 create mode 100644 fs/xfs/scrub/fscounters.h
 create mode 100644 fs/xfs/scrub/fscounters_repair.c

