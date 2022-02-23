Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA94C1645
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiBWPPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbiBWPPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:15:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62990B8B43
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 07:14:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j17so13460519wrc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 07:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykq5ak7LwB0ZRmdfcGspsY+0zkbLKncbUW2qn8AKANE=;
        b=h0Jr/0QKVekBgu2adOVNDXwBCnLnUq2zwuJDg5oITly2ZLrkOohwPTWSgMbROtZy4p
         aGxwftBLr/k8vwvhQtZ7Jti4qFv5cAK+KjyRS/S7l9lANWG5cZHfm3A84ByO+hoNrmEn
         DdPLzNtCPP+CGcdstIVGok9Y2UfZao9wirq+i8ro6tNvsHdusGMgd9o0KI/yFmFsfQRp
         NgHVegiMpzYloFNFZ/UfThAzcx9uBEvgVA7wyKoskE7yGvMEYkmz27Xkm+0l1Mm0Tsr3
         gLVXxZdPgfp7tguXmZE/Mom2RLeQG8xVkkcN56w1XxIhkkeSgdHyG26qqU2P+9GdGBX8
         9b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ykq5ak7LwB0ZRmdfcGspsY+0zkbLKncbUW2qn8AKANE=;
        b=NNmUqP5kplqLpLk8V7Mc9O6sfUBvvi8HiLeXg1uOEl8tkApyv56FlpbZeFhu2UBuAu
         bD/JZPo32eNMsdIcAYut3EqrPjcJ4rBG8NTlGEmAhqacr+/TXpJexzH1g/MKLkX6xyr6
         1DjoiNj0obfGeG81RZYotOM5gJNDApo3FyqCbgojMGlfDPhKAxD3scY+7JAzzuixs+1U
         kEUADYQd18p8Mfq8Nybb1pnYkx9Jzzv6fzBeyOmgMDo/sqjeLPlFScNI3QMhQ8hCBcgd
         C8J7/uC6d8J8bssStbMNQXOC6Wmhn5ReSfGrsOfwBvL2O/7nxRhgzm4xUUTAAbKMrprr
         MsyQ==
X-Gm-Message-State: AOAM530pyDhG8/DiX+7vyPuBO5T9RBqr8wlaX5c8XRwYP2I/w36raZYs
        6V5LAO+VV4/ygwxITyMscukGNEN0HLk=
X-Google-Smtp-Source: ABdhPJzGwp8SUGUOMzPR0cHXPqDwdz5nNd9EN88hwZswXETAa6wIlVoDJJakn1ESi4jpQqbOKNx6Nw==
X-Received: by 2002:a5d:6e8e:0:b0:1e6:754b:47de with SMTP id k14-20020a5d6e8e000000b001e6754b47demr92061wrz.208.1645629283793;
        Wed, 23 Feb 2022 07:14:43 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.153])
        by smtp.gmail.com with ESMTPSA id 3sm57488548wrz.86.2022.02.23.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 07:14:43 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] Fsnotify ignored mask related fixes
Date:   Wed, 23 Feb 2022 17:14:36 +0200
Message-Id: <20220223151438.790268-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Jan,

The two patches are functionally unrelated, but they both incorporate
information from the ignored mask into the object's interest mask.

The 1st patch is a fix for a minor functional bug.
LTP test fanotify10 has a workaround for this bug, see comment:
  /* XXX: temporary hack may be removed in the future */
The test is to remove the hack and see that fanotify10 passes.

The 2nd patch is a performance optimization that you suggested.
Last time I posted it, you asked for performance numbers [1], so I ran
some micro benchmarks (see results below [3]).

Note that the other patch from that first posting ("optimize merging of
marks with no ignored masks") did not demonstrate any visible
improvements with the benchmarks that I ran so I left it out.

The micro benchmark is a simple program [2] that writes 1 byte at a time
in a loop. I ran it on tmpfs once without any mark and once with a mark
with a mask for DELETE_SELF event.

On upstream kernel, runtime with a mark is always ~25% longer.
With the optimization patch applied, runtime with a mark is most of the
time (but not always) very close to the runtime without a mark.

[1] https://lore.kernel.org/linux-fsdevel/20201203145220.GH11854@quack2.suse.cz/
[2] https://github.com/amir73il/fsnotify-utils/blob/master/src/test/ioloop.c
[3] Performance test results:

$ time ./ioloop /tmp/foo 10000000 w
$ inotifywait -e delete_self /tmp/foo &
$ time ./ioloop /tmp/foo 10000000 w
$ rm /tmp/foo

5.17.0-rc2 #1
-------------
ioloop count=10000000 op=write

real	0m24.264s
user	0m3.977s
sys	0m20.278s

Setting up watches.
Watches established.
ioloop count=10000000 op=write

real	0m29.914s
user	0m3.929s
sys	0m25.974s

/tmp/foo DELETE_SELF

5.17.0-rc2 #2
-------------
ioloop count=10000000 op=write

real	0m26.836s
user	0m4.212s
sys	0m22.615s

Setting up watches.
Watches established.
ioloop count=10000000 op=write

real	0m30.206s
user	0m4.110s
sys	0m26.090s

/tmp/foo DELETE_SELF

5.17.0-rc2 #3
-------------
ioloop count=10000000 op=write

real	0m25.359s
user	0m4.386s
sys	0m20.945s

Setting up watches.
Watches established.
ioloop count=10000000 op=write

real	0m30.213s
user	0m4.187s
sys	0m26.020s

/tmp/foo DELETE_SELF

fsnotify-ignored #1
-------------------
ioloop count=10000000 op=write

real	0m25.020s
user	0m3.982s
sys	0m21.028s

Setting up watches.
Watches established.
ioloop count=10000000 op=write

real	0m26.084s
user	0m4.266s
sys	0m21.812s

/tmp/foo DELETE_SELF

fsnotify-ignored #2
-------------------
ioloop count=10000000 op=write

real	0m24.642s
user	0m3.945s
sys	0m20.677s

Setting up watches.
Watches established.
ioloop count=10000000 op=write

real	0m25.790s
user	0m4.209s
sys	0m21.572s

/tmp/foo DELETE_SELF

fsnotify-ignored #3
-------------------
ioloop count=10000000 op=write

real	0m25.233s
user	0m4.315s
sys	0m20.906s

Setting up watches.
Watches established.
ioloop count=10000000 op=write

real	0m28.800s
user	0m4.329s
sys	0m24.462s

/tmp/foo DELETE_SELF

Amir Goldstein (2):
  fsnotify: fix merge with parent's ignored mask
  fsnotify: optimize FS_MODIFY events with no ignored masks

 fs/notify/fanotify/fanotify_user.c | 47 +++++++++++++++++++++---------
 fs/notify/fsnotify.c               |  8 +++--
 fs/notify/mark.c                   |  4 +--
 include/linux/fsnotify_backend.h   | 19 ++++++++++++
 4 files changed, 59 insertions(+), 19 deletions(-)

-- 
2.25.1

