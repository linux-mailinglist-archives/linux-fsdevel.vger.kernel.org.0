Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CCD77F46E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjHQKr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350005AbjHQKr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ABD2D5A
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 03:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62809611D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 10:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD04BC433C7;
        Thu, 17 Aug 2023 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692269275;
        bh=VWlWbqBITMqyfIp+sdjcPDabLMEvtxuPUFsvy9KSORc=;
        h=From:Subject:Date:To:Cc:From;
        b=Tn/QwdDz5N7NRqW/Rjyhvwt/RCdSftDFGZzAH2Y5nAH8dXalrGEURxuSxeBKoOKOV
         +3aoC+7qrXXykiFD+gpJIKgVoTL5jTtShxiuGhIR9nvIZaAHK0j3SLYtkbKr5dpSwp
         bx4/2JpN+cXUPFiSTyaTSZwTZq4Ie3E8vD8Vq0UCzi+bw1hvfsz91L94wYahjhtu9Y
         K39A6zl0Mlh5XOD3wkErzEnQyXiJ9bCnFBMYav/UvXOeTS1RuJNl4J+7DYZCHrP4eh
         8STyPMvE5SRHDjB5kRKUYe0jhG5B692ImEB0QDPAyHdvXYf/SrkcLluxgDwLFyTYPb
         XuXUAmzfjkVyA==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] super: allow waiting without s_umount held
Date:   Thu, 17 Aug 2023 12:47:41 +0200
Message-Id: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM363WQC/x2MQQqDQAwAvyI5N2V3pdL2K6WHdU1qLltJ6CKIf
 2/0OAwzGxipkMGz20Cpicm3OsRLB2XO9UMokzOkkPpwjwM2NrTfQoosKxm2HjkV5iE+Ur4F8HB
 ROp13r7fzmI1w1FzLfKz8cD0PsO9//aGob4AAAAA=
To:     Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VWlWbqBITMqyfIp+sdjcPDabLMEvtxuPUFsvy9KSORc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTc/XWz5LF/0qa6p+K2JydGpP1u/ZDCf1+bTS5ZJ/nUxuW9
 3G1qHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5KsHwv26d5LzVBi/tm1Jkb/51/b
 aYecrL5Tf7Stb8WRrRbDunUZLhf1Lut8sWpYs6Fb7cPWHgevn15x0+Vok798y39dvv861aig8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

This is an attempty to allow concurrent mounters and iterators to wait
on superblock state changes without having to hold s_umount. This is
made necessary by recent attempts to open block devices after superblock
creation and fixing deadlocks due to blkdev_put() trying to acquire
s_umount while s_umount is already held.

This is on top of Jan's and Christoph's work in vfs.super. Obviously not
for v6.6. I guess this is in between an RFC and meaning it. I hope I got
it right but this is intricate. 

It reliably survives xfstests for btrfs, ext4, and xfs while
concurrently having 7 processes running ustat() hammering on
@super_blocks and a while true loop that tries to mount a filsystem with
an invalid superblock hammering on sget{_fc}() concurrently as well.

Thanks and don't hit me over the head with things.
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      super: use super_{lock,unlock}()
      super: wait for nascent superblocks
      super: wait until we passed kill super

 fs/super.c         | 327 ++++++++++++++++++++++++++++++++++++++++++-----------
 include/linux/fs.h |   2 +
 2 files changed, 261 insertions(+), 68 deletions(-)
---
base-commit: f3aeab61fb15edef1e81828da8dbf0814541e49b
change-id: 20230816-vfs-super-fixes-v3-f2cff6192a50

