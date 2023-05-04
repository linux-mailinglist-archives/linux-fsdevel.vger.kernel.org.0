Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3D6F7070
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjEDRHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEDRHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 13:07:32 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA122719;
        Thu,  4 May 2023 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=C3UDy4nsBXNKp9DnXHXrxI5GE3/VS6QXu7rM0bSRoBs=; b=bmodqTHz3rIZbJjbVdX2QqxlmU
        wvXk2gYRz6TWg1OExNibYHSIk2TZFqpSA3pQtpzFVGPqBGoyGt1KScdhRULsbHpq8uud9G1/asCnZ
        gntH9qEtWcca7UC8fyDD4F+ujFbS5jYZNkCGJpWYEBkBtMXlazE/d82zG08tCSzm7kWVNrqhucIQB
        eG7m/FEL+vSgDu3shEtVRdcczKx9ygVK0TbPMLaQTAt7WV+FxA70IdBz6yh/luto1LMM1edIoiZ2o
        ygMbWlNPBs2pX4VwncdwA/QoT9v9aNHR3xcWGyuMz7DO+ad31Xwn2nLwkcS/IJsax2wfNsKPV8LMg
        7P6qyZhQ==;
Received: from [177.189.3.64] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pucQO-001H6c-W8; Thu, 04 May 2023 19:07:25 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Date:   Thu,  4 May 2023 14:07:06 -0300
Message-Id: <20230504170708.787361-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks, this is an attempt of supporting same fsid mounting on btrfs.
Currently, we cannot reliably mount same fsid filesystems even one at
a time in btrfs, but if users want to mount them at the same time, it's
pretty much impossible. Other filesystems like ext4 are capable of that.

The goal is to allow systems with A/B partitioning scheme (like the
Steam Deck console or various mobile devices) to be able to hold
the same filesystem image in both partitions; it also allows to have
block device level check for filesystem integrity - this is used in the
Steam Deck image installation, to check if the current read-only image
is pristine. A bit more details are provided in the following ML thread:

https://lore.kernel.org/linux-btrfs/c702fe27-8da9-505b-6e27-713edacf723a@igalia.com/

The mechanism used to achieve it is based in the metadata_uuid feature,
leveraging such code infrastructure for that. The patches are based on
kernel 6.3 and were tested both in a virtual machine as well as in the
Steam Deck. Comments, suggestions and overall feedback is greatly
appreciated - thanks in advance!

Cheers,


Guilherme


Guilherme G. Piccoli (2):
  btrfs: Introduce the virtual_fsid feature
  btrfs: Add module parameter to enable non-mount scan skipping

 fs/btrfs/disk-io.c |  22 +++++++--
 fs/btrfs/ioctl.c   |  18 ++++++++
 fs/btrfs/super.c   |  41 ++++++++++++-----
 fs/btrfs/super.h   |   1 +
 fs/btrfs/volumes.c | 111 +++++++++++++++++++++++++++++++++++++++------
 fs/btrfs/volumes.h |  11 ++++-
 6 files changed, 174 insertions(+), 30 deletions(-)

-- 
2.40.0

