Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2815B4A84E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350538AbiBCNOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbiBCNOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:14:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A16C061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 05:14:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1467461807
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170C4C340E4;
        Thu,  3 Feb 2022 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643894079;
        bh=rpu8ah0DCEBiXfpRHm8MCEl29MJDi3Q6DxQPVF72DUc=;
        h=From:To:Cc:Subject:Date:From;
        b=gHf5dCnvWHJeB2Hfsfc2DK+JbWunCXGH9dlLTARa50sQR8AKGnblLJqYWpQfUSOn0
         GAArjyceenYgMBZzMISXrwxnxAkyYVuJaNv/EPMvMxpzhGIIIJ/xgmteyJ2F5ZZD8Y
         A91WOA+3w9hFUTpnDoL2vP8D3cy4fjSvunt5H7U6I5JsR10CPWSCGl610PcRBHcVKO
         ggcvOT9XH4RAXSCiLFwZZTymFtZY4TPBu3kqLm2tvuRVdpEYCtgrwCPJopsrpvuMSh
         0r8XplhivlW+4K0GBR42OGql+4I6TzyrRzrOINKZdIZD0cqENaFGnvEePHhTes5bv6
         BJl+5CsmO1jVQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/7] mount_setattr fixes
Date:   Thu,  3 Feb 2022 14:14:04 +0100
Message-Id: <20220203131411.3093040-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; h=from:subject; bh=rpu8ah0DCEBiXfpRHm8MCEl29MJDi3Q6DxQPVF72DUc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+vsp4TOfKBOkwQfeHul5W28Q7/dktds8rs3w50/KSf8Ob 6UHbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyu5nhf5SC5coTqyd5XPh/Sfb684 tGVo83cRzwedLdUZlemtnMzcLI0C84Zan/pa37ueZvmXn+WHh0KNt7w/UXPYV2y+UK3571kBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey,

This contains a couple of minor fixes for the mount_setattr() code I
didn't get around to sending so far. Apart from making the control flow
a little easier to follow there's a fix for a long-standing braino in
one of the idmapped mount kernel selftests. The kernel selftests are
separate from the large fstests suite and are only concerned with
testing the syscall itself whereas the fstests test all related vfs and
filesystem specific functionality for idmapped mounts. I would also like
to add a maintenance entry for idmapped mounts for the few files and
documentation that I've written.
I'll be gone for ~10 days starting next week but I'll try to check-in
regularly.

Thanks!
Christian

Christian Brauner (7):
  tests: fix idmapped mount_setattr test
  MAINTAINERS: add entry for idmapped mounts
  fs: add kernel doc for mnt_{hold,unhold}_writers()
  fs: add mnt_allow_writers() and simplify mount_setattr_prepare()
  fs: simplify check in mount_setattr_commit()
  fs: don't open-code mnt_hold_writers()
  fs: clean up mount_setattr control flow

 MAINTAINERS                                   |   9 ++
 fs/namespace.c                                | 148 +++++++++++-------
 .../mount_setattr/mount_setattr_test.c        |   4 +-
 3 files changed, 105 insertions(+), 56 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.32.0

