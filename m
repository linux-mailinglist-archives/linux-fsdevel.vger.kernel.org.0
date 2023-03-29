Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670516CF251
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjC2SlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC2SlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:01 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B6186
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:00 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k17so7251653iob.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115259; x=1682707259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XyzLB4YxqpohSZzs2IWD8g8i5X0/uQbpb9HXCzras5k=;
        b=V96Ofehxus9CxkIWFGyQHQy860t0l+3fAPEutPIc2VVD8ImK1rmYBBgz8/tggStwj2
         nJTL06lH5PkHsLnWKIsX9mmcQRCKrWubsGc6ckiqn+1y2Kw56pmwjcNqhASAG1HOMBxb
         r3NVbV0vweevzKagsztr7NV78Myni4Xh98ppQkWSD6Cr6ncqWdydX1Kf7Lj8Rp5tXz9n
         sz5cUxkA/xXAKdwONUN+z6Ut4jZac9jYQQAu0d7xTgwiXcedCTgdu6bm/qybxct2m3zE
         PgPot95AVZiF+4ofs6tvhBXpeyFAENapFY5cvffBOkogWak/y/LXIjTanyUFUoIx8poG
         KYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115259; x=1682707259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyzLB4YxqpohSZzs2IWD8g8i5X0/uQbpb9HXCzras5k=;
        b=n723vKsqIpvh/ulnJl+JjAxUWlO59j7at4yoi9g+Y9wpEQwuyv9bpELihP9cJVuKVn
         vtcd7Qtw6nLqzshvE4E9a9EkoCFA+nR9e+3FlopKn8GkfCpMu0Yt8DIm4vZwvJ+tTCu/
         pTFN3OFMZGe7Jx9VAkXs9i0E6mex7qC59bSqbu/z+1wn7bWlnu2Y1dAgCEjcXmwXfINb
         Nl2rbAVOr6mK3MgfA0/TrkJAIJBoba83Xsa0obxszTN1O6ndnEe3QTHPGkXVFEoMMNMM
         25lDBL7aKlcuU+/isZQoaUu+eTDrL2y/EI0KclS37ONDSMbW+qizTd+6RpCCwxsTUOvw
         +z7g==
X-Gm-Message-State: AO0yUKVYoI1bANB8eggOA4wSYoYB/5hO1wIw/ywH/MfPjPDgf2hKZUNa
        bIwBZ4gJ2JmKtyRC/pBOh/4vcluSCz2NzQi17WBOQA==
X-Google-Smtp-Source: AK7set81ZmOWOFmDydq0WJQJnblnNO61aKfvfKQ2Jz2mMtlVibCw7tYUI7MoZS94Ox7ytuS73T4fuQ==
X-Received: by 2002:a05:6602:2f04:b0:758:9dcb:5d1a with SMTP id q4-20020a0566022f0400b007589dcb5d1amr14209779iow.2.1680115259551;
        Wed, 29 Mar 2023 11:40:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:40:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCHSET v6 0/11] Turn single segment imports into ITER_UBUF
Date:   Wed, 29 Mar 2023 12:40:44 -0600
Message-Id: <20230329184055.1307648-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Rather than repeat the same blurb again, see the v2 posting here:

https://lore.kernel.org/linux-fsdevel/20230327180449.87382-1-axboe@kernel.dk/

tldr - turn single segment iovecs into ITER_UBUF rather than ITER_IOVEC,
because they are more efficient.

Attempt 2 at doing the overlay. The series starts by adding an
iter_iov() helper, which simply returns iter->iov. At the same time we
rename it, to catch anyone using it and to further signify that future
direct uses of it should be discouraged. There are a few manual bits
left, I'll clean those up if we agree this is moving in the right
direction.

Then we get rid of returning an iovec copy with iov_iter_iovec(), and
killing off that function. Two helpers are added to return the current
segment address and length.

Then the usual few iter_is_iovec() -> iter->user_backed changes. For
the alsa part, Takashi did say that single segments could be valid.
But with the rest of the changes, this is no longer interesting as we
don't have to deal with it separately.

Finally, do the last two patches that turn single iovec segments into
ITER_UBUF at import time.

Passes testing, and verified we do the right thing for 1 and multi
segments.

Also viewable here:

https://git.kernel.dk/cgit/linux-block/log/?h=iter-ubuf.2

-- 
Jens Axboe


