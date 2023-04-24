Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA26EC458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 06:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjDXEZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 00:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXEZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:25:34 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC27919A4;
        Sun, 23 Apr 2023 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2Qb4zQ9ksN8MuZZ+mD1yaDjq361e0yne8EL9nnCgEYs=; b=V75BRYunrNqwadwy7gWSnNakAf
        mxgw3trke8W5Cg+rsq5VCWKcqIPAnxF6HiWGMfUH+M0dD+waeVM4yr2iOTYKlG0ITNrA9S1XFw6yZ
        j7Em9nOpgqlxXvff/2GdTdcEfOlFDZfYRPwO6OxqmrzqGVKRpwf5mHikW5V9tKCknfwIbCFpoj9mz
        cx/hksa1ClBAp0/nT5gaPsMsWGwrsPqsCugETaXEDCYa9H8WFEgO6pwXWOY6d+/LVmuOecZQYYYYF
        Aizu4UtfCsqy+3HnC/NX3xm3uXdcdEt2vNA66JqVAIJr8eDQobylnnp+9cIUbrhXy9KRT/78UumfO
        sKN8pqJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqnlZ-00C0Fe-0y;
        Mon, 24 Apr 2023 04:25:29 +0000
Date:   Mon, 24 Apr 2023 05:25:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] fget() whack-a-mole
Message-ID: <20230424042529.GI3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd

for you to fetch changes up to 4a892c0fe4bb0546d68a89fa595bd22cb4be2576:

  fuse_dev_ioctl(): switch to fdget() (2023-04-20 22:55:35 -0400)

----------------------------------------------------------------
fget() to fdget() conversions

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (8):
      convert setns(2) to fdget()/fdput()
      convert sgx_set_attribute() to fdget()/fdput()
      SVM-SEV: convert the rest of fget() uses to fdget() in there
      kill the last remaining user of proc_ns_fget()
      build_mount_idmapped(): switch to fdget()
      bpf: switch to fdget_raw()
      cgroup_get_from_fd(): switch to fdget_raw()
      fuse_dev_ioctl(): switch to fdget()

 arch/x86/kernel/cpu/sgx/main.c | 11 +++++------
 arch/x86/kvm/svm/sev.c         | 26 ++++++++++++++------------
 fs/fuse/dev.c                  | 41 +++++++++++++++++++++--------------------
 fs/namespace.c                 | 12 ++++++------
 fs/nsfs.c                      | 18 ------------------
 include/linux/proc_ns.h        |  1 -
 kernel/bpf/bpf_inode_storage.c | 38 +++++++++++++++-----------------------
 kernel/cgroup/cgroup.c         | 10 ++++------
 kernel/nsproxy.c               | 17 ++++++++---------
 net/core/net_namespace.c       | 23 +++++++++++------------
 10 files changed, 84 insertions(+), 113 deletions(-)
