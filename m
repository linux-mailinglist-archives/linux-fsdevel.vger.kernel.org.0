Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B2595D46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiHPN2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiHPN2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB419E13B;
        Tue, 16 Aug 2022 06:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B2DC61224;
        Tue, 16 Aug 2022 13:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C80C433D6;
        Tue, 16 Aug 2022 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656481;
        bh=3BvEO0y6SvtvJVgtB7CQ2VjDm8ESRdcCR897MOqGO58=;
        h=From:To:Cc:Subject:Date:From;
        b=tISLXKsc/ZcP8F/KpjAULGzcfxlj+fMeVk3tnNAlcctHMdRazPP+LzxFkCrb2GjvF
         077Z7lHZuOggnTDV3u9i/nX+eUfXCMDnRHxMTB5CLf/ZVriGp1tJa6JGWr5vwLMQ5p
         /spZM8nTETgVg2pUg+QbnANmY6MrGK9AD19xFfRF0iQLadahhtTeGHRnB/JK0trwAa
         9/2ZNXg2QvwuAIaYI6wXQbyPzFkyni3U5R2OtnNeLGDz48G82hFBNfZp3Mn7g5T4dd
         Pt3WRPyPTsBAwmtZCvf44YMeFI18bVEBTuBqtcxFuwAtcPOwYRkRYV2ptHwOPiQ8ux
         ZtHMzgiz7QwXQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: [PATCH 0/4] vfs: expose the inode change attribute via statx
Date:   Tue, 16 Aug 2022 09:27:55 -0400
Message-Id: <20220816132759.43248-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
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

The i_version counter is currently only really visible via knfsd with
NFSv4, so testing its behavior has always been quite difficult. The main
goal of this patchset is to remedy that.

The idea is to expose i_version to userland via statx for all
filesystems that support it. The initial usecase for this is to allow
for better testing of i_version counter behavior, but it may be useful
for userland nfs servers like nfs-ganesha and possibly other situations
in the future.

I'll be posting patches for xfsprogs and xfstests that use and test this
functionality soon.

Jeff Layton (4):
  vfs: report change attribute in statx for IS_I_VERSION inodes
  nfs: report the change attribute if requested
  afs: fill out change attribute in statx replies
  ceph: fill in the change attribute in statx requests

 fs/afs/inode.c            |  2 ++
 fs/ceph/inode.c           | 14 +++++++++-----
 fs/nfs/inode.c            |  7 +++++--
 fs/stat.c                 |  7 +++++++
 include/linux/stat.h      |  1 +
 include/uapi/linux/stat.h |  3 ++-
 samples/vfs/test-statx.c  |  8 ++++++--
 7 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.37.2

