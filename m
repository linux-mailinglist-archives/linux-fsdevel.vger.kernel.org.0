Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E85F304F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJCMau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJCMas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:30:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6423B723;
        Mon,  3 Oct 2022 05:30:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq9so16510013wrb.4;
        Mon, 03 Oct 2022 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=T/fREI+xTUR4XLBsF14/qTUE846Qs6i3HlylJyTm2k0=;
        b=mGes8gwyavTU/IuW1lJAN3G2GK5dEpSSsW4XGvYx6hw6tmLt0GzyNr5Zoi5MOX2Yx8
         HjE4CieK1H4rMQE6L7HZgVptpd1Akoow1uAYhdC2fgO3E4SuI09rydDNXzHSM5oPqy0i
         Foa7nINII+gjFEiHcgrW1ZwLzM1kxMPo4TJmK8sCCZku6zYuWeMjhH0kvvn5kwUOKZmX
         WVg3wWxdPYq8wqBaRnwnwBGu5Ep5qsPPyVNmLHpTJT+Q1fr6gK7KZzwEy/iBeV0+K0gZ
         lP1OvWFHATIC6FefupTjfKnO88ikuHvFHLHZLF6+5AYuPTZ4h615CO4Wm8yXdCm6h8xR
         P8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=T/fREI+xTUR4XLBsF14/qTUE846Qs6i3HlylJyTm2k0=;
        b=Cga/LKWKoDtfBjo4c0tyqngJXdGX/ic6jmpXnO8SvMYYZY1YV6G4AZB1Fnlqp51cId
         I2cec/1y8jPPR5Wl7cJuyyQKKs/MXLK56/qManxPPOLDnKDy1Qqka7y8Qdi5PxK1rBaU
         f5/Gz3HzZYE6zo6pCJxUxkyFExKVZaaBES50zz00vQPT4LQhgqmNMEQCe0XmCmggiqc/
         jhvBX9s4zjoZz/8iV15VmO4KwgS2zZ3Jz633XIx368WLp26MFM4o7cZeGI/QLZPYPsGQ
         a5iJZs4bUL7x+30OJ+cBmCvEFbi0zy2anW3J2a3qXpkoFjfOs/dQmeQMUVdJiASjfhEn
         TN/Q==
X-Gm-Message-State: ACrzQf2a7DTA80NYbEr1Li9GNDzUjJqNpT+qhiswViW4ZodqXuO6YoEb
        qAVmgEE2omQ2vXPoDYRpMHM=
X-Google-Smtp-Source: AMsMyM6fWSPpt5nlhadYT2i0lBhhG3NNQqb0UiyviKFEN7whva/Kdq6q+tiECsJaLo4l20HNVvdGYQ==
X-Received: by 2002:adf:fdc6:0:b0:22e:373:939e with SMTP id i6-20020adffdc6000000b0022e0373939emr8592745wrs.290.1664800245545;
        Mon, 03 Oct 2022 05:30:45 -0700 (PDT)
Received: from localhost.localdomain ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c4e0e00b003b535ad4a5bsm11845392wmq.9.2022.10.03.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 05:30:44 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Some fixes for overlayfs remove privs
Date:   Mon,  3 Oct 2022 15:30:38 +0300
Message-Id: <20221003123040.900827-1-amir73il@gmail.com>
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

