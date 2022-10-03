Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFCD5F3038
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 14:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiJCMWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCMWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:22:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D0A2F65D;
        Mon,  3 Oct 2022 05:22:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a10so4122895wrm.12;
        Mon, 03 Oct 2022 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=T/fREI+xTUR4XLBsF14/qTUE846Qs6i3HlylJyTm2k0=;
        b=j2dCQeYf0H+hOG9k/vfH/hMG+FYFkbuEXZAKylEfzvVz8RWSRXEm73zk444vydIGEg
         JF7G/0gCd0QoY1VuF7froZmb5iMiLI7/Q3NyuR9Fk3JhuTBxE1YZiLzTZNp81LcM8NOD
         +k92VqDP2P+P64kTc/x+BfIi1U8kruP3ehuXh76NLibJWfPsgpRVDGi6rWoRLkqbquEn
         En7e3ROXU4Tstk0U21ro+pDBdDL8ygqnowaoadsw6fF66mqU6P7UDJ2uyEhrpRTYkHAa
         XsQf+82RoXNrGpOocLwD2QdVX/NULzYG5SwGxRjLDpQgF5uLmz5JCFOIoWXUnnSvdpPE
         IIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=T/fREI+xTUR4XLBsF14/qTUE846Qs6i3HlylJyTm2k0=;
        b=1pF1paFQ6nBXYn2t0V+Y7ydl9OYceRH4vDMjY9GTaqIGx6lG9oo3socQCIyDQA7aTC
         yJ806kr3fe6TCcXtp3TDrvfVjg2R41XeCJM2dkrtIh94rf8zCCXId4GI/wR6ZVklzSGy
         mYoyNZ2QDji58oDHl54RJx8XAYuPxoTYknbq9djbmivSxA+dfrdraYffrmS9Z4K2XODk
         k4606GAuwC24VcS5AarxlEAX58FsVJt1mHs0PyeuzNsGGGFMnCXZ7mQR7ECtf6Ip+gNd
         UMZP4AMneEiJNDvvwQnBLuGZBvA6UkiZQ0KXR0HHo9mQGMxT5JeO2URsYE2dUy/edITK
         DDww==
X-Gm-Message-State: ACrzQf2Oc4byr2A6k0rlhXQGKp8YY1eADqJTSZzzCHG9o8qWujW6HWR5
        ctjgbEWW7H6AxHrQ3RxU0Ts=
X-Google-Smtp-Source: AMsMyM7pW4+emV1gJQ+9fnjmtttrvUuJ9w/EipvvpnqZBunhQxjUxw0cLMEsAc/Yd/+A9ixoYiiV9w==
X-Received: by 2002:a5d:6d85:0:b0:226:ffd5:5231 with SMTP id l5-20020a5d6d85000000b00226ffd55231mr12143995wrs.202.1664799721230;
        Mon, 03 Oct 2022 05:22:01 -0700 (PDT)
Received: from localhost.localdomain ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003a682354f63sm16983387wmn.11.2022.10.03.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 05:21:59 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Some fixes for overlayfs remove privs
Date:   Mon,  3 Oct 2022 15:21:52 +0300
Message-Id: <20221003122154.900300-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

While running latest fstests on overlayfs-next, I noticed these
failures:
generic/673 generic/683 generic/684 generic/685 generic/686 generic/687

Christian has also reported those failures earlier.

Those are not regressions, those are 5 new tests added to fstests and
one test whose expected result was modified by fstests commit b3a59bb6
("generic/673: fix golden output to reflect vfs setgid behavior").

The following two patches aim to fix those test failures, but they are
incomplete - without those patches, the tests fail miserably in all test
cases, because no privs are stripped.

With those two patches, only two test cases are failing, which are the
two test cases whose expectation was changed by fstests commit b3a59bb6.
The reason was explained in [1] and the issue was fixed for xfs by kernel
commit e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes").

Trying to figure out how to fix this hurts my brain, so I'll need
suggestions how to proceed.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-xfs/CAL3q7H47iNQ=Wmk83WcGB-KBJVOEtR9+qGczzCeXJ9Y2KCV25Q@mail.gmail.com/

Amir Goldstein (2):
  ovl: remove privs in ovl_copyfile()
  ovl: remove privs in ovl_fallocate()

 fs/overlayfs/file.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

-- 
2.25.1

