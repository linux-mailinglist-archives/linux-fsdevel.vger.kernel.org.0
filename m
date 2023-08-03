Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6606776EE7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjHCPpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjHCPpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:45:18 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1FD35A6;
        Thu,  3 Aug 2023 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8tD2pgOxyBUMQkoiBNewoI718bhhhFSSdLu6MC274YE=; b=XvEHfCUHbc/tFvyKK8TD7dKamo
        MswmkjmIa5FrNjDCFxVl1RvswwXl/YI45Jogh5jry9Xsv57SQ2f6Bbu7UHoqw6wl6lG6lqvXjS7vv
        0zxhAvu4DbpjhE2cG7alVDa5EkhcOXGeOnicr2tOjNQIK54rn4ml6Ib9wvZYKcUgMS5lvx0v7Rf+S
        +r/5PxcMBMOG2LAnqIEXbhGRIF9X/TIc50z3uvna1RW6l78Ana4EnKgqw/VTjwpBp/LYF8GgCKj4y
        jvtNAnoOcGUC2PgQ8atoy7N7spbm3gOc69GRDxlS3L6ElTimTyKLzX+705+x/1nUY7beIN2dHC9eI
        PJD+l5rA==;
Received: from [201.92.22.215] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qRaVg-00Bty4-5T; Thu, 03 Aug 2023 17:45:08 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        gpiccoli@igalia.com, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: [PATCH V2 0/3] Supporting same fsid mounting through a compat_ro feature
Date:   Thu,  3 Aug 2023 12:43:38 -0300
Message-ID: <20230803154453.1488248-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all, this is the 2nd attempt of supporting same fsid mounting
on btrfs. V1 is here:
https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/

The mechanism used to achieve that in V2 was a mix between the suggestion
from JohnS (spoofed fsid) and Qu (a single-dev compat_ro flag) - it is
still based in the metadata_uuid feature, leveraging that infrastructure
since it prevents lots of corner cases, like sysfs same-fsid crashes.

The patches are based on kernel v6.5-rc3 with Anand's metadata_uuid refactor
part 2 on top of it [0]; the btrfs-progs patch is based on "v6.3.3".

Comments/suggestions and overall feedback is much appreciated - tnx in advance!
Cheers,

Guilherme


[0] https://lore.kernel.org/linux-btrfs/cover.1690792823.git.anand.jain@oracle.com/


Guilherme G. Piccoli (3):
  btrfs-progs: Add the single-dev feature (to both mkfs/tune)
  btrfs: Introduce the single-dev feature
  btrfs: Add parameter to force devices behave as single-dev ones

btrfs-progs:
 common/fsfeatures.c        |  7 ++++
 kernel-shared/ctree.h      |  3 +-
 kernel-shared/uapi/btrfs.h |  7 ++++
 mkfs/main.c                |  4 ++-
 tune/main.c                | 72 +++++++++++++++++++++++---------------
 5 files changed, 63 insertions(+), 30 deletions(-)

kernel:
 fs/btrfs/disk-io.c         |  19 +++++-
 fs/btrfs/fs.h              |   3 +-
 fs/btrfs/ioctl.c           |  18 +++++
 fs/btrfs/super.c           |  13 ++--
 fs/btrfs/super.h           |   2 +
 fs/btrfs/volumes.c         | 136 +++++++++++++++++++++++++++++++------
 fs/btrfs/volumes.h         |   5 +-
 include/uapi/linux/btrfs.h |   7 ++
 8 files changed, 175 insertions(+), 28 deletions(-)

-- 
2.41.0

