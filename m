Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F235772267
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjHGLdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjHGLcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:32:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05042726;
        Mon,  7 Aug 2023 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NlmJ2S0P/uz5iMElrPSgS3bSwMmeQoWOLoOqB0sn44Y=; b=XVP8+K26ocL0Ksks2M+bNeKMHi
        G9Zg5YzDOdSHvH1e8xjVSim+FLLKjjb2wBBaBcc7+A1dqVgofsgk4zNdAd5xipEaAHkdlIQDUGnfi
        gF3EoxPPoHFWy7FvKOcLKnmo5yF2Brs1mesDSGML2S+9dAw7BAa7757SRfbJgX0DueyZdKHDEew66
        ePcxdVQuJ2lELZOet8OkKafgpefnleluoChRJQL7fbm1XdsspCgmkSaNdwPO5jwmREwCZyj6t9gHp
        4fZ9kF89ZZTjXsp01N18uJcghpndtpOCN0bC3+Rq0SmDB9YGkC5AvgzKwZafWAlmnXkVt9V/dq11J
        Y8vHiYKQ==;
Received: from [82.33.212.90] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSyNa-00H569-0a;
        Mon, 07 Aug 2023 11:26:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: remove bdev->bd_super
Date:   Mon,  7 Aug 2023 12:26:21 +0100
Message-Id: <20230807112625.652089-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series is against the vfs.super branch in the VFS tree and removes the
bd_super field in struct block_device.

Diffstat:
 fs/buffer.c               |   11 +++--------
 fs/ext4/ext4_jbd2.c       |    3 +--
 fs/ext4/super.c           |    1 -
 fs/ocfs2/journal.c        |    6 +++---
 fs/romfs/super.c          |    1 -
 fs/super.c                |    3 ---
 include/linux/blk_types.h |    1 -
 7 files changed, 7 insertions(+), 19 deletions(-)
