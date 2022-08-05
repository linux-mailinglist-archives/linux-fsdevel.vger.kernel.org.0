Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401E258AFD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbiHESfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbiHESft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:35:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E9765E;
        Fri,  5 Aug 2022 11:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66EAEB80D83;
        Fri,  5 Aug 2022 18:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E91FC433D6;
        Fri,  5 Aug 2022 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659724546;
        bh=0nXuhjdJNF9HU4zM6ykQuL5s8Oky62WY1qkxmt9LyPg=;
        h=From:To:Cc:Subject:Date:From;
        b=lGCbyajAonhHywdyKx4A4xVUbXE6QpFYgWo1K1jBW9mZOSGz9j+yy7RMJttRLu5v7
         vZeYpF40ZRBQnGviqeHrXhX5prfwnhpKh9gx8h1cAWn/YAfwteNd8AUB2aaV81uQaG
         NUmc/zHpVmHxwyCgfX+jKfV1kK1nfUc0L/jbSu93a+qUOZmTG3NyEtCUyEu2KuXhqf
         NIiiwnLFRhsQ334bAuZ4BuI9ybLGRN5u5AN9YNQ7xQ3AfdN69hIw878y8lZSgs3pAm
         lLyp6L6pXHcM8mQwYM9oGjkFrlSg8LcoK4VvwPyk0gRX8vAju5/x8W95jWApO0loh1
         iyePi98+oobMw==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, lczerner@redhat.com, bxue@redhat.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 0/4] vfs: allow querying i_version via statx
Date:   Fri,  5 Aug 2022 14:35:39 -0400
Message-Id: <20220805183543.274352-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently I posted a patch to turn on the i_version counter
unconditionally in ext4, and Lukas rightly pointed out that we don't
currently have an easy way to validate its functionality. You can fetch
it via NFS (and see it in network traces), but there's no way to get to
it from userland.

Besides testing, this may also be of use for userland NFS servers, or by
any program that wants to accurately check for file changes, and not be
subject to mtime granularity problems.

Comments and suggestions welcome. I'm not 100% convinced that this is a
great idea, but we've had people ask for it before and it seems like a
reasonable thing to provide.

Jeff Layton (4):
  vfs: report change attribute in statx for IS_I_VERSION inodes
  nfs: report the change attribute if requested
  afs: fill out change attribute in statx replies
  ceph: fill in the change attribute in statx requests

 fs/afs/inode.c            |  2 ++
 fs/ceph/inode.c           | 14 +++++++++-----
 fs/nfs/inode.c            |  3 +++
 fs/stat.c                 |  7 +++++++
 include/linux/stat.h      |  1 +
 include/uapi/linux/stat.h |  3 ++-
 samples/vfs/test-statx.c  |  4 +++-
 7 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.37.1

