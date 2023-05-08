Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27206F9D55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 03:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjEHBTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 21:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjEHBTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 21:19:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE412E8E;
        Sun,  7 May 2023 18:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NkhgxHjE0NhPEajBFvo6SOCCt0dVYGvbT1tUI2iCTdc=; b=jU7gHaM/BJls0chhhubhGC0fdy
        xUMIDK0zNGzjemV2PNM9UpavYGgUtSanMJrQdL09r0m1QB5jqHMt6VO8VjbdrV6b0VcSuXN8Te9iL
        EzJ4wFCNd4u/VPv0CofbvWkySFRJmwk7Da450B4kfABuM2tjhh39PtTaxTbEpO7xv3esDtM5Yc6ta
        ad3xIgbxc2qtthGhRkKIKE16NFv9b8SJOFj7KAB/MrWp3Uzh64eqDo6EF2LRrtgRFluq86awWAElC
        Ei1GTFQQVy75GiI3ueSUs9y/NRXS0fs7DJ3XLoqJ/UXikWt3uypIONgUNlDQIdmOJY79qQKta8yXD
        MW21UQjw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvpXE-00Gw8M-18;
        Mon, 08 May 2023 01:19:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/3] filesystems: start removal of the kthread freezer
Date:   Sun,  7 May 2023 18:19:24 -0700
Message-Id: <20230508011927.4036707-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's 3 filesystems converted over to remove the kthread freezer.

Luis Chamberlain (3):
  ext4: replace kthread freezing with auto fs freezing
  btrfs: replace kthread freezing with auto fs freezing
  xfs: replace kthread freezing with auto fs freezing

 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/super.c       |  4 ++--
 fs/ext4/super.c        |  9 +++------
 fs/xfs/xfs_log.c       |  3 +--
 fs/xfs/xfs_log_cil.c   |  2 +-
 fs/xfs/xfs_mru_cache.c |  2 +-
 fs/xfs/xfs_pwork.c     |  2 +-
 fs/xfs/xfs_super.c     | 16 ++++++++--------
 fs/xfs/xfs_trans_ail.c |  3 ---
 10 files changed, 20 insertions(+), 27 deletions(-)

-- 
2.39.2

