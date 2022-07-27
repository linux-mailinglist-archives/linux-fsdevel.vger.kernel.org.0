Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC6582058
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiG0Gor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiG0Gok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9D40BF6
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b9so15295686pfp.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWSvmewN8U9kt58F9ww9X8uKXCBd0vWKU9SNeTfLslw=;
        b=UgZyI+8ZRH9W4R1ZiXQuf5elOfzwzK3VgFjPnmCKtadKmj8BmyEnKJ2+MUAPB9VxA8
         0Lj6bhHd0t9Fh35N8XQf2l15wUiEJktNdblYfUP8pIuUAzQLp1cQyTWW+TRYX2SqiH7+
         NKfyNIl73Pv3GU95pp7iaHsbQMrcpC6MSm9bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWSvmewN8U9kt58F9ww9X8uKXCBd0vWKU9SNeTfLslw=;
        b=Qxa/JMvGITftJinCpfPIuW0JG9TZo9+klNVTFTNLS72u/5ZmOPQsDNH/D6adkuBjZJ
         P8/ycB7tas++dhkxLdjFJuNxnmvi+pnF85FCXgUZvTF9djs/eOU3wZvMynaaQN/MoS82
         UwH2ehEaO7zE30Caefe2zMephWtYylaACsOzdbscMVmfFS5QWT2bBHiE8Fu9bV/o64wy
         8sQOdnpZiLuftWaiIE0rBkjfISqnjJWssSRmpBYbH93Qf4oq9rJKtfxzlk2qaLwM0SVh
         hENTKIZIjox6g7kPXKa6h2lq5f76ZyAY/yf9DPoMJX05hDFaZK9Tsa+HiV65uXFIU7PG
         YYNg==
X-Gm-Message-State: AJIora9lUWdfrnaJWtOwW3nR4FXvyd9s3F5Myw7Js6TV2mmpfk6dzNCX
        vX6RmeWktUartWRRmXMQBO5wrY7+1o2yFQ==
X-Google-Smtp-Source: AGRyM1vxMhAFkw1J0zpvF4EyAwdqpepdmxYq8U8bEWqUj2+dlFGN1asQWJtTa4k7LrGfICS/xIiyOQ==
X-Received: by 2002:aa7:954a:0:b0:52a:bd44:d15a with SMTP id w10-20020aa7954a000000b0052abd44d15amr20359778pfq.35.1658904279373;
        Tue, 26 Jul 2022 23:44:39 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm12627001pln.110.2022.07.26.23.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:44:39 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v5 0/2] Prevent re-use of FUSE block-device-based superblock after force unmount
Date:   Wed, 27 Jul 2022 16:44:23 +1000
Message-Id: <20220727064425.4144478-1-dlunev@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes in v5:
- Update commit messages to specify that only block-device-based
  superblocks are affected
- Restrict retire_super call in FUSE to be issued for fuseblk only.

Changes in v4:
- Simplify condition according to Christoph Hellwig's comments.

Changes in v3:
- Back to state tracking from v1
- Use s_iflag to mark superblocked ignored
- Only unregister private bdi in retire, without freeing

Changes in v2:
- Remove super from list of superblocks instead of using a flag

Daniil Lunev (2):
  fs/super: function to prevent re-use of block-device-based superblocks
  FUSE: Retire block-device-based superblock on force unmount

 fs/fuse/inode.c    | 10 ++++++++--
 fs/super.c         | 32 ++++++++++++++++++++++++++++++--
 include/linux/fs.h |  2 ++
 3 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.31.0

