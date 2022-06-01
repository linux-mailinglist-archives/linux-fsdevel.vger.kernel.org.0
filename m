Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495B3539AA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348426AbiFABLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiFABLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 21:11:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90D29398C
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o17so326783pla.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PY52JYSItUrD0Mk4PEiJ0pqT4TM+vNP414Zt5LGtliE=;
        b=PAW8k48qlNqQflXlFpEJ0cX8I5KIPtuqqme5jdgYIyESn5OZDzntu7JT7gqsB4mWDH
         gtiliobRdEBNFVdLZ2q/orekQSS9fxq50GYUVTopeXIBONpf/cENekuuqeZd9L0MD099
         FgDDvH80EefjJDmahtzu/bT0h6YMoN1rU+vRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PY52JYSItUrD0Mk4PEiJ0pqT4TM+vNP414Zt5LGtliE=;
        b=6BNkK+xZPMlH3W+WpYx8XiwaZwNwnPKShTwmoD0jxbnjDLBV7LdRoiroxNQxJOQ9g9
         oIrqe8Wg/6a6YtEp1lSYTu71V7JSz74/o+GYCgYt/k/+iiG6fj/8Jxpke5d1FqOru3CE
         PGeb4mEjpg/eGa++kNae8+VmpVp8INoP2ymEwdWMwztsnXtaoZLVPkxA4gMdNb8KL4GZ
         F2dLIVFN9ZWehI2ZeBfv6oHmY+6h0BrvhjfnD9kP5zcai+36/wdHo43xLZ7w8pQaEn2j
         kSD8Eguz+5tRz6IKVP8/f0F4RZe2fAnbpYt7vQkHuvhT1Pxhmh7Kf+lo7N2mkofBupBM
         0NCg==
X-Gm-Message-State: AOAM530Fg0ApVzEwJ3ht8EGbp0hkIybEcixbCZLS+ENpqHRhixu3Ik76
        xKXHswIUbzpiehrjAnb4ADTaRbJhSXed5w==
X-Google-Smtp-Source: ABdhPJz5XtkTLFu8eWOaq840/e37fMnCQQr3fVv46InGOG5yauQ8+yK6cLIyG1qAM7LHMXYy+5kukA==
X-Received: by 2002:a17:902:a585:b0:14d:58ef:65 with SMTP id az5-20020a170902a58500b0014d58ef0065mr62807127plb.139.1654045876273;
        Tue, 31 May 2022 18:11:16 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id mi16-20020a17090b4b5000b001df6173700dsm2621916pjb.49.2022.05.31.18.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 18:11:15 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
X-Google-Original-From: Daniil Lunev <dlunev@google.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Daniil Lunev <dlunev@google.com>
Subject: [PATCH v4 0/2] Prevent re-use of FUSE superblock after force unmount
Date:   Wed,  1 Jun 2022 11:11:01 +1000
Message-Id: <20220601011103.12681-1-dlunev@google.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Force unmount of fuse severes the connection between FUSE driver and its
userspace counterpart. However, open file handles will prevent the
superblock from being reclaimed. An attempt to remount the filesystem at
the same endpoint will try re-using the superblock, if still present.
Since the superblock re-use path doesn't go through the fs-specific
superblock setup code, its state in FUSE case is already disfunctional,
and that will prevent the mount from succeeding.

Changes in v4:
- Simplify condition according to Christoph Hellwig's comments.

Changes in v3:
- Back to state tracking from v1
- Use s_iflag to mark superblocked ignored
- Only unregister private bdi in retire, without freeing

Changes in v2:
- Remove super from list of superblocks instead of using a flag

Daniil Lunev (2):
  fs/super: function to prevent super re-use
  FUSE: Retire superblock on force unmount

 fs/fuse/inode.c    |  7 +++++--
 fs/super.c         | 28 ++++++++++++++++++++++++++--
 include/linux/fs.h |  2 ++
 3 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.31.0

