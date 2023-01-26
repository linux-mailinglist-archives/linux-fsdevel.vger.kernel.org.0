Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB667D331
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjAZRbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 12:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjAZRbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:31:31 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B5122A06
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 09:31:26 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id s26so843733ioa.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 09:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9BJJQzoDsnrUeYgDKx6LZgv0cypBSRKCQgn69cO5NY=;
        b=G2rPmK5wUbasPBB9wP26jHgdhIzDTXImqwlPuLi/CKZj4DtdTEcl5ekusISuKLF0bm
         CUG+8VQfyZpRAS0shgOK00Zq096xreZcdXRz9S2FNduzrL+gpA/BQHiXNi4V5sPtkeWh
         L8PJDe2KZFuPxIRwzPFys0/cRYOlyhrG9w4gMHQsolWjmXzFaoRoEBhkbamk4PE6vbF9
         USXYCFowo3wJg1sdq8/s96EEKtgzVx9oGF4PjjkdDQDV0g0Hj/W7Z+OoGjy8w+s6RngN
         NGPUwhAV1KJjSsYg70jMM2Bekmc4I4PCWRVL3vHEzja7CwgyTkoDGO3HEL7lHDlNdXAQ
         6pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9BJJQzoDsnrUeYgDKx6LZgv0cypBSRKCQgn69cO5NY=;
        b=GNvkas2OBX/bcVeI16FbOJFqAZouvP4vFsbwQZkUbqS7gZQ1LF4dfrtUuxKdT0RcDn
         SDRPj1IX04NgbvaiXbKNCegIKFLLjN+DPN6NiJWPH0peUz4a3mCdOwvjcbMOzx3l8oqi
         k8r2jl9YKZcsRfu2dZtKAzij+JMFDf1GHq4I5p1RPO9QKc9HqLXvu7jrxeB+bYaqpdoZ
         cKqYVpKrOxjeUa0M2XN7t40zLeNQYQRo+nPR6xPxIQQ5HIKl26mAWypljaxMCAcCE/U8
         NXQkfSP3edLrygZeHM/1s4EB54muj4NpsUUf7NV3hh90LtmPLDleXYChyW36NiQp9OZ7
         Fo6w==
X-Gm-Message-State: AFqh2konO8jiliGwVStGsAAhX04SxiHEcUO6Y+W+5ZTYeFNHw6LpZMpy
        EEy5hYOKgxl39O4qOBFFA1Zl0XWY+QrZswHU
X-Google-Smtp-Source: AMrXdXt9WYOZCub+SRV6z4+V2VsdgVaUgzsgEWT5NgUCzBffkM/vKdVrPBTbP+KBlurR1oo8mG94xw==
X-Received: by 2002:a5d:9e4d:0:b0:707:6808:45c0 with SMTP id i13-20020a5d9e4d000000b00707680845c0mr4429830ioi.1.1674754285967;
        Thu, 26 Jan 2023 09:31:25 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n24-20020a02a198000000b0038a434685dbsm641377jah.102.2023.01.26.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:31:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230125065839.191256-1-hch@lst.de>
References: <20230125065839.191256-1-hch@lst.de>
Subject: Re: build direct-io.c conditionally
Message-Id: <167475428508.707060.7530877439951509379.b4-ty@kernel.dk>
Date:   Thu, 26 Jan 2023 10:31:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Wed, 25 Jan 2023 07:58:37 +0100, Christoph Hellwig wrote:
> this series makes the build of direct-io.c conditional as only
> about a dozen file systems actually use it.
> 
> Diffstat:
>  Kconfig          |    4 ++++
>  Makefile         |    3 ++-
>  affs/Kconfig     |    1 +
>  direct-io.c      |   24 ------------------------
>  exfat/Kconfig    |    1 +
>  ext2/Kconfig     |    1 +
>  fat/Kconfig      |    1 +
>  hfs/Kconfig      |    1 +
>  hfsplus/Kconfig  |    1 +
>  internal.h       |    4 +---
>  jfs/Kconfig      |    1 +
>  nilfs2/Kconfig   |    1 +
>  ntfs3/Kconfig    |    1 +
>  ocfs2/Kconfig    |    1 +
>  reiserfs/Kconfig |    1 +
>  super.c          |   24 ++++++++++++++++++++++++
>  udf/Kconfig      |    1 +
>  17 files changed, 43 insertions(+), 28 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] fs: move sb_init_dio_done_wq out of direct-io.c
      commit: 439bc39b3cf0014b1b75075812f7ef0f8baa9674
[2/2] fs: build the legacy direct I/O code conditionally
      commit: 9636e650e16f6b01f0044f7662074958c23e4707

Best regards,
-- 
Jens Axboe



