Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5ED6CAC9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjC0SE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC0SE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:04:56 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7252D60
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:55 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e6so5025695ilu.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679940294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmRKJSAMClTe9h5E9bDHBb5ejo4ooOmeEUs4rnfgO7U=;
        b=hP095qdEhCQ8gVJWCmNXYF/7BHt12U2OEvqKeLHmyXoPZ7ib+bCXaXFa4CxhWau2T+
         ZJzy15FTbI9dkKPtVK3fsOwsZQlx9PmU8XtcD6FlRIGOQAPU95Gbv5UR3DL6M6v+MxEs
         +f8Rmqbph71Bwr3xBOT41+hYnBExkKkmjZDPM048kg1oAbuq94FHgZeCBinqnlHN09D5
         cWKA9YcL9ChjlqaEp0pUqOmqtQjmZC47wiZJF1K96kZ6DVXDeX79NoQvp4t1cm1j4Ez+
         Qdz0WSVry9UxijAuXyyoa34/xu4et+Yxnm1jYehJOunhYH6edSmCOpff9K0RyTYYCgMT
         D/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679940294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmRKJSAMClTe9h5E9bDHBb5ejo4ooOmeEUs4rnfgO7U=;
        b=Flxc+mIsd5nOG72qe7sQtlQUlXGk529BYbsMWLAl7bcGHeSzCifB1+7IABiy3+QTmo
         yayybL1iRjl4j69kHjh8TlSqMiuXT5GmozOULCfnKApntw5JYuPB2gEVPPCTCGLBvcjn
         H4JhxylZQoxF/5xSBSrM61Rp4byOvq2tzfcMawJjuBmzNcwHiDWNRncNBWj7na4biys0
         Qx6qLjAlo0TXleGPvr5UAMPQYcyNeNW8cM1pRP9Qn2FNpX/JlU7o8LXdl5wSPEe8s4mo
         zQZ1JRZKU++MXULxgnVwZx21hQVIE8r3atSDbL/XAo188dMJ92goGnduamz74gbk50M+
         QPoA==
X-Gm-Message-State: AAQBX9efccNMLDzMf8hxgEL1g3KCkpeGCk2eXMnU4S/iNS1QSQRR4RtI
        zCZ5aAINBnB9RAjP2QaHFtQBSweEFAeOVWIG1drZbw==
X-Google-Smtp-Source: AKy350ZksHojA7/G0+A1AFqoN0RPsQnn00D6gLSnnGT73SFMNaZ3GasICd3cTCht7LmflXLAdcBC/g==
X-Received: by 2002:a05:6e02:1d95:b0:326:1b0b:536c with SMTP id h21-20020a056e021d9500b003261b0b536cmr364920ila.1.1679940294335;
        Mon, 27 Mar 2023 11:04:54 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e28-20020a0566380cdc00b0040634c51861sm8853235jak.132.2023.03.27.11.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:04:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCHSET v2 0/4] Turn single segment imports into ITER_UBUF
Date:   Mon, 27 Mar 2023 12:04:45 -0600
Message-Id: <20230327180449.87382-1-axboe@kernel.dk>
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

We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
spots, as the latter is cheaper to iterate and hence saves some cycles.
I recently experimented [1] with io_uring converting single segment READV
and WRITEV into non-vectored variants, as we can save some cycles through
that as well.

But there's really no reason why we can't just do this further down,
enabling it for everyone. It's quite common to use vectored reads or
writes even with a single segment, unfortunately, even for cases where
there's no specific reason to do so. From a bit of non-scientific
testing on a vm on my laptop, I see about 60% of the import_iovec()
calls being for a single segment.

Ran some unscientific performanc tests [2] as well.

Changes since v1:

- Add two prep patches converting ITER_IOVEC assumptions
- Add missing import_ubuf() return value check in __import_iovec_ubuf()

[1] https://lore.kernel.org/io-uring/43cb1fb7-b30b-8df1-bba6-e50797d680c6@kernel.dk/
[2] https://lore.kernel.org/all/45c46ee9-8479-4114-6ce9-ae3082335cb8@kernel.dk/


