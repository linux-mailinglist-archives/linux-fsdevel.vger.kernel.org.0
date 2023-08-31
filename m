Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5F78E3D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjHaAQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 20:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbjHaAQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:16:02 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10E2CCF;
        Wed, 30 Aug 2023 17:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lOGe6lXpQ4KfX0MYSXm9k/pKRR+uTrwu2ezbdyABHwI=; b=h4E1r9rCMpILfd0R+e6lN9hg04
        upQ8zs0YZALUKj0eA/7IRr/Vl7FdkGPGwSEcuNUXCLkeJ4/q3gV5HauJf7bEjbJNAIs7HzldM+tZT
        hvqcJDdz3dKAgVTalBcu2da7kDDZCFIEMQpTxg+VluL907uprbZpTxbwjvawcm0gQjlHSxo37Yjhx
        PbKaWDprX8DloIVNsTMAKfejf4Lz8flIyZ0A8ylHy+PKULpfsJxctlF7GOk/gI5eZy+7NSDhLaE6R
        K6WVGKdnLl+E5ZcISjeOK7dIz19X6aytvvfIRtgnk1QIrKCK2ANiLiwdc3TCZHqCJpZ2hrmNYhcjm
        tM9z7gcg==;
Received: from [187.116.122.196] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qbVLj-0001Vf-O2; Thu, 31 Aug 2023 02:15:52 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V3 0/2] Supporting same fsid mounting through the single-dev compat_ro feature
Date:   Wed, 30 Aug 2023 21:12:32 -0300
Message-ID: <20230831001544.3379273-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks, this is the third round of the same fsid mounting patch. Our goal
is to allow btrfs to have the same filesystem mounting at the same time;
for more details, please take a look in the:

V2: https://lore.kernel.org/linux-btrfs/20230803154453.1488248-1-gpiccoli@igalia.com/

V1: https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/


In this V3, besides small changes / improvements in the patches (see the
changelog per patch), we dropped the module parameter workaround (which
was the 3rd patch in V2) and implemented the fstests test (as suggested
by Josef): https://lore.kernel.org/fstests/20230830221943.3375955-1-gpiccoli@igalia.com/

As usual, suggestions / reviews are greatly appreciated.
Thanks in advance!


Guilherme G. Piccoli (2):
  btrfs-progs: Add the single-dev feature (to both mkfs/tune)
  btrfs: Introduce the single-dev feature

btrfs-progs:
 common/fsfeatures.c        |  7 ++++
 kernel-shared/ctree.h      |  3 +-
 kernel-shared/uapi/btrfs.h |  7 ++++
 mkfs/main.c                |  4 +-
 tune/main.c                | 76 ++++++++++++++++++++++++--------------
 5 files changed, 67 insertions(+), 30 deletions(-)

kernel:
 fs/btrfs/disk-io.c         | 17 +++++++-
 fs/btrfs/fs.h              |  3 +-
 fs/btrfs/ioctl.c           | 18 ++++++++
 fs/btrfs/super.c           |  8 ++--
 fs/btrfs/sysfs.c           |  2 +
 fs/btrfs/volumes.c         | 84 ++++++++++++++++++++++++++++++++------
 fs/btrfs/volumes.h         |  3 +-
 include/uapi/linux/btrfs.h |  7 ++++
 8 files changed, 122 insertions(+), 20 deletions(-)

-- 
2.41.0
