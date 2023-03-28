Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622366CC959
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjC1RgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjC1RgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:18 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A968BDD5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:17 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3261b76b17aso144245ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcnCuSVSdcb6qqtswvw4qZ7VcoSSq9GLRfxgtx7chVA=;
        b=SAdvC3v9ia1EZl+BD68n41UfwUhD6p3EewK66kjOHp9snK0UnSDSsO7dYOebyP7Ej7
         wkvmp7p4Pcww6GqzGHOqu5hBQ2hCMqSet5DbR98/w6nMaTRw8ATnQk4+RjgdgcFnuOHt
         lZhVf4T+/7y9xSGt6z+TxgjKZOIguqIHP6l9/RK4sxFQ7CMcy2NZrf5/uVEfuzLwTJ6h
         E/2owOW1GEJ8BNjvFkTwDCzMm8INUeMIPH02y//pY3lEByBlR+XU4ZOKoapkknuUZ5dd
         krpPcq/ki5ousy3M6HJcUMj0xqat6qUdaeAcX4o7b1uALNIoDnlIgl59lzXc3bMBaCpf
         d3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcnCuSVSdcb6qqtswvw4qZ7VcoSSq9GLRfxgtx7chVA=;
        b=dPo+z+iSBRGNnpsr4vj5Z66UmiCxuEj7SulotLDkDRN+aCw7nSVKYwtX/16bj7RYcG
         pZd29a5zz9eZUcFXRtkx/V1HoNs4movHUd08CHDE+GFOU1K7Sjf4G1VHVAIyukZr8X/C
         Kt2U/u7jxJUiBa9Ia22tl/LnAh+Rt9VRkMeSoRNjuwbOUbhp0tEL6TCdY6uNPlXwl8Zt
         E3WEEv2G6AiBSVaREYunRtZ1f9UxTW51tyYBWGmMMjFWtH8T5BPbqeb4bGRzDQbp2CAy
         9haDpoohcgqqIGPe5/R3ZpkO688NTIuPMmCsGJoOoYxipfd+d0OKfZxHFQ8nZsIO0ZKl
         o1nA==
X-Gm-Message-State: AO0yUKWmnWOm2X+XWMOnrSf80pmQz0avreORPALLdpUMG4f+fAKqWtX5
        BB4bSlIiTYFuXDZIYgyDodAYpTQu+NQc/E6xs3p/Cg==
X-Google-Smtp-Source: AK7set8GwhhrRmhNbqL/zF0Kx0LUgQ2fSz7HE+KHaqWniI5Yv2+6rOn6qiGYeoljqSEFCyjwCJLlJw==
X-Received: by 2002:a05:6602:2d87:b0:759:485:41d with SMTP id k7-20020a0566022d8700b007590485041dmr9646450iow.0.1680024976603;
        Tue, 28 Mar 2023 10:36:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCHSET v4 0/8] Turn single segment imports into ITER_UBUF
Date:   Tue, 28 Mar 2023 11:36:05 -0600
Message-Id: <20230328173613.555192-1-axboe@kernel.dk>
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

ather than repeat the same blurb again, see the v2 posting here:

https://lore.kernel.org/linux-fsdevel/20230327180449.87382-1-axboe@kernel.dk/

tldr - turn single segment iovecs into ITER_UBUF rather than ITER_IOVEC,
because they are more efficient.

Main addition since v3 is being careful checking users of iov_iter,
and there are two odd ones - infiniband and sound. I've added a
prep patch to be able to grab the segment count of a user backed
iterator, which sound and IB can then use.

I'm not convinced the sound patch is useful at all, since it LOOKS
like it requires nr_segments > 1 anyway. I'll chat with the folks
on that side to be sure. We may get away with just EINVAL for
this case.

IB is pretty straight forward, just make it deal with ITER_UBUF
as a single segment thing.

-- 
Jens Axboe


