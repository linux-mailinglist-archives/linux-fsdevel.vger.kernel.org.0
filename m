Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1FC7097CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjESM6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjESM6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456710D9
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3063891d61aso3089221f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501033; x=1687093033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmSVgTxTOnOhvD9AaUsG0Tfd6GmabtDmBh1UIvyxt5A=;
        b=ZXJT9YGSyEN/Bnl5gGhDk4tpnhWycKLbuQyBH/IVF4K2y+EGQM93NwSeF45wF7E8xc
         RN+3g7Be7stzBoBxWQteG6NmcjPVNFBwIpP99pdOMLDMEvrOErr+eJdsQv7pBMv5ZD6U
         3G1xRvrNWzwW2bTSX2olJHDWnKcuoKgvzG+i6uHsBBA3gdzp3I0DjoNbvDIjNAHQQHPp
         Q/lgUkT7HjOCTF9J+VZ/SqQNs9ZOyIjdVjq1dvNoRsI4p/6hKobqQS6wunFYI0Z3EJbC
         4xMOwpyXqu5epfmreowOgl+sWl7RrrPA6yCcn5YbNmKaMwDq+B0X1ZQC5gMSBpnLXZad
         /4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501033; x=1687093033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmSVgTxTOnOhvD9AaUsG0Tfd6GmabtDmBh1UIvyxt5A=;
        b=Zxc7YaC7Ls5hUuT8Aeoj71U9VQfxwhrquyD7+CQpc8+NYOgqaVP4jXHQLndBIl6ItY
         10Mlhc7aBuMcr6K5ButOLD5x7wqlHPrEWPhnJKPGnjbvq1l6FCBxrQ3IlL2euWkhXHHm
         KdDt6py6isBNXRkC0zB7b3L8vLljGPxGK7U5EbSNTIswt6660AlFPLNpIOEm4UcFnYzF
         UsQCCbae0IgZk8O/zlvSj30+L8RJSFSkOAyrnu4WeO1wHW12wAYzPwCI1ZgzB7ca0E2D
         VjIDJhGmKHo2pLVvjO+XBTwHbOAC6x5i1KdO7IsYHT/hn9UM8vTtkadaUMwSdDwkt7NN
         sjMg==
X-Gm-Message-State: AC+VfDxlBmdZdXCPCw0OLExvAZCTObX125iCPkSsSYlcEZrF/HP0k6pR
        YfPK717OXaVHZImeyHuIooI=
X-Google-Smtp-Source: ACHHUZ5GqNWaVsopkDIo9l0KS49eWsSmEXCv4QRvkSaLzwb4CnOZvW9ogQKfRqVHt3DV7ztwOIkX5w==
X-Received: by 2002:adf:e409:0:b0:2fe:f2d1:dcab with SMTP id g9-20020adfe409000000b002fef2d1dcabmr1720394wrm.58.1684501032823;
        Fri, 19 May 2023 05:57:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:12 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 00/10] fuse: Add support for passthrough read/write
Date:   Fri, 19 May 2023 15:56:55 +0300
Message-Id: <20230519125705.598234-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

This patch set addresses your review feedback on Alesio's V12 patch set
from 2021 [1] as well as other bugs that I have found since.
This patch set uses refcounted backing files as we discussed recently [2].

I am posting this for several possible outcomes:

1. Either FUSE-BPF develpers can use this as a reference implementation
   for their 1st phase of "backing file passthrough"
2. Or they can tell me which API changes need to made to this patch set
   so the API is flexible enough to extend to "backing inode passthrough"
   and to "BPF filters" later on
3. We find there is little overlap in the APIs and merge this as is

These patches are available on github [3] along with libfuse patches [4].
I tested them by running xfstests (./check -fuse -g quick.rw) with latest
libfuse xfstest support.

Without FOPEN_PASSTHROUGH, one test in this group fails (generic/451)
which tests mixed buffered/aio writes.
With FOPEN_PASSTHROUGH, this test also passes.

This revision does not set any limitations on the number of backing files
that can be mapped by the server.  I considered several ways to address
this and decided to try a different approach.

Patch 10 (with matching libfuse patch) is an RFC patch for an alternative
API approach. Please see my comments on that patch.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20210125153057.3623715-1-balsini@android.com/
[2] https://lore.kernel.org/linux-fsdevel/CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com/
[3] https://github.com/amir73il/linux/commits/fuse-passthrough-fd
[4] https://github.com/amir73il/libfuse/commits/fuse-passthrough-fd

Changes since v12:
- Rebase to v6.4-rc2
- Reword 'lower file' language to 'backing file'
- Add explicit FOPEN_PASSTHROUGH open flags
- Remove fuse_passthrough_out container
- Add FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl
- Add experimental FUSE_DEV_IOC_PASSTHROUGH_SETUP ioctl
- Distinguished errors for failures to create passthrough id
  (EBADF, EOPNOTSUPP, ELOOP)
- idr and fuse_file point to refcounted passthrough object
- Use rcu_read_lock() to get passthrough object by id
- Handle errors to setup passthrough in atomic_open()
- Invalidate mtime/size after passthrough write
- Invalidate atime after passthrough read/mmap
- Bump FUSE protocol minor version
Alessio Balsini (2):
  fs: Generic function to convert iocb to rw flags
  fuse: Definitions and ioctl for passthrough

Amir Goldstein (8):
  fuse: Passthrough initialization and release
  fuse: Introduce synchronous read and write for passthrough
  fuse: Handle asynchronous read and write in passthrough
  fuse: Use daemon creds in passthrough mode
  fuse: Introduce passthrough for mmap
  fuse: update inode size/mtime after passthrough write
  fuse: invalidate atime after passthrough read/mmap
  fuse: setup a passthrough fd without a permanent backing id

 fs/fuse/Makefile          |   1 +
 fs/fuse/dev.c             |  76 ++++++++-
 fs/fuse/dir.c             |   7 +-
 fs/fuse/file.c            |  28 +++-
 fs/fuse/fuse_i.h          |  48 +++++-
 fs/fuse/inode.c           |  22 ++-
 fs/fuse/passthrough.c     | 344 ++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/file.c       |  23 +--
 include/linux/fs.h        |   5 +
 include/uapi/linux/fuse.h |  21 ++-
 10 files changed, 535 insertions(+), 40 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

-- 
2.34.1

