Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EFF79F521
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 00:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjIMWoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 18:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMWoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:44:22 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EEF1BCB;
        Wed, 13 Sep 2023 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aoawsj0y9Fl/8/hECDjcCmSLe02tbdgQ6ntQkPkRi9E=; b=lowWYAUPakQI31wBdFjbGIYdAd
        JR3O/THJm2b5BSA7H+jdeT73ZiltUWeS7TAXT/HHTNXeqPFr7Hjxwy0eVqo1yeEUr2wRHIUX15Fnp
        ZoKyxcqc4w8azzZLVhvS3UoFh2IByIWgWo90x8/jeqIVCPtJ00ywnXUa3bDLPz0lK+a68f7gvP/dS
        ol10/HZ3/FKiPDZgmJKbHikhuHNSJpKtV0cEevLEdzlZDFVkYA9Hd41mmn9/Mn3/n/QUjjAZfk5Ju
        5mQOtz+n1uDWMyWm7LQcROf+k0RrRDwU70LfgYnhvfWgRGd43Kt8mRMJ1qGewRDVcbwwVxio9YGjE
        gZfodmnA==;
Received: from [187.116.122.196] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qgYah-003Z6W-Ok; Thu, 14 Sep 2023 00:44:12 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v4 0/2]  Supporting same fsid mounting through the temp-fsid feature
Date:   Wed, 13 Sep 2023 19:36:14 -0300
Message-ID: <20230913224402.3940543-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, this is the 4th round of the same fsid mounting patch. Our goal
is to allow btrfs to have the same filesystem mounting at the same time.
The main change this time was the name of the feature, from single-dev to
temp-fsid, which seems the less disliked name heh

More details in the patches' changelogs.
Thanks,

Guilherme


Guilherme G. Piccoli (2):
  btrfs-progs: Add the temp-fsid feature (to both mkfs/tune)
  btrfs: Introduce the temp-fsid feature

btrfs-progs:
 common/fsfeatures.c        |  7 ++++
 kernel-shared/ctree.h      |  3 +-
 kernel-shared/uapi/btrfs.h |  7 ++++
 mkfs/main.c                |  4 ++-
 tune/main.c                | 72 +++++++++++++++++++++++++-------------
 5 files changed, 66 insertions(+), 27 deletions(-)

kernel:
 fs/btrfs/disk-io.c         | 18 +++++++++-
 fs/btrfs/fs.h              |  3 +-
 fs/btrfs/ioctl.c           | 18 ++++++++++
 fs/btrfs/sysfs.c           |  2 ++
 fs/btrfs/volumes.c         | 70 +++++++++++++++++++++++++++++++-------
 fs/btrfs/volumes.h         |  5 +++
 include/uapi/linux/btrfs.h |  7 ++++
 7 files changed, 109 insertions(+), 14 deletions(-)

-- 
2.42.0

