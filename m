Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FB06CCC6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjC1V6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjC1V6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422879D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a25eabf3f1so892255ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AaK5WsMq5ppiBauwleEEUZSX2NycE8GcisUIACCATcc=;
        b=GROEdzY5OGr5UuXOZ6qVZO6MADKOBj/X2tZDpRxi/8KcyD/QMv2dYRMxxTF4HhGyxr
         xHr3I0y1MdS9ATDWPElr1fvO7cQRUp0CFH7Tyc0FSnmwgWAExmcXPgggNF3Z836ZuU/3
         TClmw8Pj49DdSu3pIKP4kRnKHShTd4JYefaBlygrwA+5ImpXnRCbkwy4fEUuUpp345YO
         ow/zy+3z/R71CMRYNYc978+w4G3rIpEUxqWgR0kwH+P/p0eW02/aA1NDrACdtlS4nqik
         surOEEM2+RGEJVt8qYWzzLr1vLvvEiQWKTrHolmy4G1r3ayoJ/oo+eWHtL0WjsfXMiUn
         iXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaK5WsMq5ppiBauwleEEUZSX2NycE8GcisUIACCATcc=;
        b=b2xP7XSLFpTL+wKkutZwkGj+/erE9N/0GU9bUDnUEacjCcLfUfL+KlzGxaUhUZJNQN
         irL/FDS0if7kTy64ZuSCaU1Hoym/T7NLwAWxOVO5/pnq19GZbE/VG2r8Xd8Zio/7glua
         fF9Lv/9f7wB1txNPcdQSBm9d5b5Lmr2h2sxnKcJ2n+vMGA5wr2kkKjBLpT0SK23H8XJt
         zvkEsEXOC1YjJgmoX+dZMXcmYXv/JSUrEkfh0sSGDzpALZuhMPNQBVbIPSgsq3XMg5HW
         GJnWFzKyEYvHn4Gt68DS7MfH5SJxa2PRFzU2jJI7Xv6+hLoPXznuI94+b8WAQO3O53Au
         Ixuw==
X-Gm-Message-State: AAQBX9frqYTSET2Tm75QwI4J1jU2l5EXSuhydm2XOji3Of0Nrv4IPohX
        eL4L/tGlP9JGKo+YEq0/2DMm2n0DgM52AplRoLR8Jw==
X-Google-Smtp-Source: AKy350ZU1uEuhysoLgX7UzWZ1AEiMFJddK6r1h0z4fQLIBXcQfs/49Dz1IFocBO6vNi6j8rkvg4NzQ==
X-Received: by 2002:a17:902:e547:b0:19a:a815:2877 with SMTP id n7-20020a170902e54700b0019aa8152877mr13942391plf.6.1680040694446;
        Tue, 28 Mar 2023 14:58:14 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCHSET v5 0/9] Turn single segment imports into ITER_UBUF
Date:   Tue, 28 Mar 2023 15:58:02 -0600
Message-Id: <20230328215811.903557-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
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

The main change since v4 is doing the overlay trick in the iov_iter,
so that the first segment of the iovec overlaps nicely with the ubuf
address and length. With that, we can drop any functional driver change,
as the normal iteration should just work out with ubuf having the single
segment. Replace he iter_is_iovec() check with a basic iter->user_backed
instead.

Unfortunately we can't make iov_iter_iovec() much prettier, as we have
to return a copy of the current iovec as the offset has to be added...

Include a block fix for a shoddy copy of an iterator, as that'll
otherwise cause issues.

Ran the liburing test cases and the previously indicated ltp cases
that barfed, and everything looks rosy. Comments welcome - with the
above approach, we don't ever return iter->__ubuf_iovec, it's really
just there as an overlay filler. Maybe we can make that a bit more
apparent.

-- 
Jens Axboe


