Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0862C226
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiKPPRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiKPPRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:17:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024EF4FF8E;
        Wed, 16 Nov 2022 07:17:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2C15B81DC2;
        Wed, 16 Nov 2022 15:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB89C433C1;
        Wed, 16 Nov 2022 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611849;
        bh=eVaemk5bRp5UIAhx/BwapOwzeYPJ7UWbBodOfxndur8=;
        h=From:To:Cc:Subject:Date:From;
        b=F71CUEH5+o5c5rWc3RGIwNq4U9xmYW3X9g6dSZZKUNBri/UgqlEeQC+Cd7Nzbu6Gy
         VRHH0BudcTr1hgViqIiw5Pk0eVnliQYu0MzP03imkse3UiZ4RgEkWKJQuznzgsRK82
         eUCDv034JxLJnYSK8+krjpSWroUCUMoQ6LZT1BzoR8K1yChICmcr93oUmBwb2ykc7w
         5oZYtYyrb8tK6g1GieJyOUMxhyRVI1XzoGcOssg/fwZScexdr+s6Fp1GVZRXX9w7tK
         qwiBJtgpXWlqShpZabya3/nY8xWM1fp9l7pE+dpHnZDaIrtWMoNG8FXJ0HpNGt2/06
         u84RlSTCfbelw==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de
Subject: [PATCH 0/7] fs: fix inode->i_flctx accesses
Date:   Wed, 16 Nov 2022 10:17:19 -0500
Message-Id: <20221116151726.129217-1-jlayton@kernel.org>
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

The inode->i_flctx field is set via a cmpxchg operation, which is a
release op. This means that most callers need to use an acquire to
access it.

This series adds a new helper function for that, and replaces the
existing accesses of i_flctx with that. The later patches then convert
the various subsystems that access i_flctx directly to use the new
helper.

Assuming there are no objectsions, I'll plan to merge this for v6.2 via
my tree. If any maintainers want to take the subsystem patches in via
their trees, let me know and we'll work it out.

Jeff Layton (7):
  filelock: add a new locks_inode_context accessor function
  ceph: use locks_inode_context helper
  cifs: use locks_inode_context helper
  ksmbd: use locks_inode_context helper
  lockd: use locks_inode_context helper
  nfs: use locks_inode_context helper
  nfsd: use locks_inode_context helper

 fs/ceph/locks.c     |  4 ++--
 fs/cifs/file.c      |  2 +-
 fs/ksmbd/vfs.c      |  2 +-
 fs/lockd/svcsubs.c  |  4 ++--
 fs/locks.c          | 20 ++++++++++----------
 fs/nfs/delegation.c |  2 +-
 fs/nfs/nfs4state.c  |  2 +-
 fs/nfs/pagelist.c   |  2 +-
 fs/nfs/write.c      |  4 ++--
 fs/nfsd/nfs4state.c |  6 +++---
 include/linux/fs.h  | 14 ++++++++++++++
 11 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.38.1

