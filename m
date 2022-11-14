Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5062836B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiKNPCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 10:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiKNPCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:02:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0722B0A;
        Mon, 14 Nov 2022 07:02:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D8F1611BD;
        Mon, 14 Nov 2022 15:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F541C433B5;
        Mon, 14 Nov 2022 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668438162;
        bh=a/M/1yxUU4iYIOYE9x1Z1vSjcrb3/s/dP4Ig3YsXU7k=;
        h=From:To:Cc:Subject:Date:From;
        b=ki4aTxzxZwY66+CmURYuwfmNsD1Ziw2UP0ORPQ2ZFbOxCNpMjk3yi7idjYuyYkfUx
         AebzVxOPpUJCmjiU7PbZ7RNKKEv8JNiPPnXsI2y8fbn6h66Y5TsNnDQIPuH1kkyXJ4
         PKIAg6xo0AGfOQqJDUcFbdU/BiUiuk4+vVEqAnGg+uK/Ve6ohBCsU4hqsz1cnpy6dN
         ez89DupOFBDPASVgZXs18FTFRaLh3g95Z3OO7pbwls9DUuaL/5z3ZgMB1Os4LtSVYm
         VGUS5e3D4Aa67Yf0+P0rw404apIlJ4jE9fsCL4Q6uZZheKx+rwFXfddw6lrr+lmfuZ
         BfSEDme/WpT1Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] filelock: remove redundant filp arguments from API
Date:   Mon, 14 Nov 2022 10:02:37 -0500
Message-Id: <20221114150240.198648-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some of the exported functions in fs/locks.c take both a struct file
argument and a struct file_lock. struct file_lock has a dedicated field
to record which file it was set on (fl_file). This is redundant, and
there have been some cases where the two didn't match [1], leading to
bugs.

This patchset is intended to remove this ambiguity by eliminating the
separate struct file argument from vfs_lock_file, vfs_test_lock and
vfs_cancel_lock.

Most callers are easy to vet to ensure that they set this correctly, but
lockd had a few places where it wasn't doing the right thing. This
series depends on the lockd patches I sent late last week [2].

I'm targeting this series for v6.3. I'll plan to get it into linux-next
soon unless there are objections.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=216582
[2]: https://lore.kernel.org/linux-nfs/20221111215538.356543-1-jlayton@kernel.org/T/#t

Jeff Layton (3):
  filelock: remove redundant filp argument from vfs_lock_file
  filelock: remove redundant filp argument from vfs_test_lock
  filelock: remove redundant filp arg from vfs_cancel_lock

 fs/ksmbd/smb2pdu.c  |  4 ++--
 fs/lockd/svclock.c  | 21 +++++++--------------
 fs/lockd/svcsubs.c  |  4 ++--
 fs/locks.c          | 29 ++++++++++++++---------------
 fs/nfsd/nfs4state.c |  6 +++---
 include/linux/fs.h  | 14 +++++++-------
 6 files changed, 35 insertions(+), 43 deletions(-)

-- 
2.38.1

