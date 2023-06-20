Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87A73700F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjFTPO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjFTPOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:14:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B51BF5
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 08:13:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668730696a4so1408873b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687274031; x=1689866031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cYhpq8kII/zBY/3iWU+UakUCHm4VL9Cr+rVrcVWuTHY=;
        b=N6t88ac0/O9s1WSvaIdjbqn07sFmRw7LRT9pzUoAPItbwebr1dZnPGKuiO5ep9pKb2
         UBuw49WxISSOx7oeBfa4zbSCOE68r0PGKekjIy3XjV5KVMtuATtOpyGJafarRoNOxZpX
         JavurTTFcLQInhHa02OYpekFd7Wg/YQL4TOJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274031; x=1689866031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYhpq8kII/zBY/3iWU+UakUCHm4VL9Cr+rVrcVWuTHY=;
        b=EhimOil/fYVtZl5CdEgKArHgeqeZuob6Bao+DoX8ktY9rdI7Y1W48fCEF3tOWUE5c0
         i71raFGN5fWb5GxC8Wc3J1wmzQHCA5413At+Tz1raOOgZph7EoPdyhSYtfKtPQhXhKrB
         uGsiilT65RK2B0Hl7NmSxUNZmJTV2tSBj6vVIqdYiO49b21GBERUFdtOtlA14c1S/FPb
         vdb2Xmn2rQ74Et9QOZ57LYsj1tIXKLLh7kTvzfy3g2EX2fvqwYRhuRkOYFjM6cJtmk9L
         RfqIrVKDyuQ4SDz28Yl9PwF9VeWyGcX9yX5dlDFqjue0YKfs9dl9UIp/4CJ+QOBOxJmu
         2W4A==
X-Gm-Message-State: AC+VfDy3/hNQ0PrNdmA0UafG2TttS5pz3ZW4Q4phEIzVXv4UPFYKTUrM
        TiLyi1Ky2Z384A7ifYzI/DVgEg==
X-Google-Smtp-Source: ACHHUZ5FuufZTijicZcf+ErEEp0rFQuZuKEzL6yES24xb2lmYLqT0Bo9sqezWSJJNuVJRjpYIfom4g==
X-Received: by 2002:a05:6a20:8411:b0:10c:4c76:e909 with SMTP id c17-20020a056a20841100b0010c4c76e909mr10027154pzd.8.1687274030764;
        Tue, 20 Jun 2023 08:13:50 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:8f:203:e87e:41e3:d762:f8a8])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b001aaf370b1c7sm1731872plg.278.2023.06.20.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:13:50 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     mhiramat@google.com, takayas@chromium.org, drosen@google.com,
        sarthakkukreti@google.com, uekawa@chromium.org,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 0/3] Support negative dentry cache for FUSE and virtiofs
Date:   Wed, 21 Jun 2023 00:13:13 +0900
Message-ID: <20230620151328.1637569-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This patch series adds a new mount option called negative_dentry_timeout
for FUSE and virtio-fs filesystems. This option allows the kernel to cache
negative dentries, which are dentries that represent a non-existent file.
When this option is enabled, the kernel will skip FUSE_LOOKUP requests for
second and subsequent lookups to a non-existent file.

Unlike negative dentry caches on a normal filesystem such as ext4, the
kernel may need to refresh the cache for FUSE and virtio-fs filesystems.
This is because the kernel does not know when a FUSE server or a virtio-fs
device creates or deletes files. To address this, the new
negative_dentry_timeout option takes an expiration time for cache entries.
The appropriate timeout duration should be determined by considering how
often a FUSE server updates file paths and the amount of memory the kernel
can use for the cache.

As we evaluated the virtio-fs's performance on a guest Linux on crosvm
[1]'s virtiofs device[2], the `negative_dentry_timeout` option saved ~1
second per 10000 `stat` call against a non-existent path. The experiment
settings and results are as follows:

* Command to start VM with crosvm:
sudo crosvm run \
  --disable-sandbox \
  --cpus 1 \
  --mem 2048 \
  --rwroot debian.img \
  --shared-dir \
  /path/:my_virtiofs:type=fs:cache=always:timeout=3600 \
  -p "console=hvc0 init=/bin/bash" \
  vmlinux

* Mount command in the guest
Default:
$ mount -t virtiofs my_virtiofs ./workspace/
With negative dentry cache:
$ mount -t virtiofs -o negative_dentry_timeout=10 my_virtiofs ./workspace/

* Test commands
$ cd workspace
$ echo 3 > /proc/sys/vm/drop_caches
$ time for i in `seq 1 10000`; \
  do stat non-existent.txt 2> /dev/null; \
  done

* Results:
Default:
real 0m12.606s
user 0m3.624s
sys 0m7.756s

With `-o negative_dentry_timeout=10`:
real 0m11.276s
user 0m3.514s
sys 0m7.544s

[1]: https://crosvm.dev/book/
[2]: https://crosvm.dev/book/devices/fs.html


Keiichi Watanabe (3):
  docs: virtiofs: Fix descriptions about virtiofs mount option
  fuse: Add negative_dentry_timeout option
  virtiofs: Add negative_dentry_timeout option

 Documentation/filesystems/dax.rst      |  1 +
 Documentation/filesystems/fuse.rst     |  6 ++++++
 Documentation/filesystems/virtiofs.rst |  9 ++++++++-
 fs/fuse/dir.c                          |  3 ++-
 fs/fuse/fuse_i.h                       |  4 ++++
 fs/fuse/inode.c                        | 12 +++++++++++-
 fs/fuse/virtio_fs.c                    |  8 ++++++++
 7 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.41.0.185.g7c58973941-goog

