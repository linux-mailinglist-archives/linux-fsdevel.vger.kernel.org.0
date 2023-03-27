Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184BF6CB250
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjC0X1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 19:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjC0X1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:27:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECA52689
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so9981272pll.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679959644; x=1682551644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVcuVvAUld5UR637XbG/ZdiLaagMM1L+LCw7YZ/2VGk=;
        b=T293V8XpRDl9QV0XcP79UjQ2f/3oLo36EMRY4z8m06cXSH+NbRl3OAb9uz9rJdLecS
         2cABI60V3obZi/4EleK2C86ob2Q8nkAtXqHQrSAtUO5pl3haZGjsdwtxm79sf6psXipf
         xaNWp1xWrUEykkIZ2DMzQ5QCDa46QCvY6Wmm874jMBMdvAysI5kCVjN2+yWp2nZA3+ZT
         u0zo2PkL8oXFaa+oTwoNMLR0p4heSYjSKDcpgx3eqDuM3fFER/gkpBEgWGqSZ9THq3fi
         Jzc0PQSblw6xmOjwABZXLjzxQIsvwMObKr32oO6KNnCQOfMzoP6FAR43g9Mk0MURwsQW
         TfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959644; x=1682551644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVcuVvAUld5UR637XbG/ZdiLaagMM1L+LCw7YZ/2VGk=;
        b=8Am0dDglK3dkQo/diKkNk7W6ztWzgIQ2BVuk7L47IAU1Yk6+F9ys77b1YeJs3EJxfB
         QRMUQWqW1JMRMC/zuyYbaYryDh0e92QAbePCGylk0cJHA21DpCfP9UPUIOApvMvg1q7B
         dKBPEgjjm4A+CyfQJuUTrr0Nj8BmJ94oFQwVIJwXRCoC4TjNOnq2J66I0wYD4dI4M/8k
         T+SDXjC/owps6YsxhRnprAyQfY8p4op5rN4OGTdt6zeH57MYNRUxd6cExKICNzOVYyHw
         47j9tt7t6970v0LdQ2T9zZsagGwaz7nOr41SfrFEzlRtD9pCdcivdsBmUbFZqaBZa8/n
         MyBQ==
X-Gm-Message-State: AO0yUKXqxJQWoelXaRgtFTlslL7puE5LgZpFXCak3c2PqYpD+pMsyVSP
        n8HQy5cJziwHIejSi951whPkmMuZdKSWSshvlbrVgQ==
X-Google-Smtp-Source: AK7set8YTp+Za/rUYmIMlAu0FTsFJk1NuyfYFBB00Uewgf//8B6f3gnjC02IDLifcz12lc/p49TWzA==
X-Received: by 2002:a05:6a20:8e08:b0:cd:2c0a:6ec0 with SMTP id y8-20020a056a208e0800b000cd2c0a6ec0mr19616328pzj.3.1679959644170;
        Mon, 27 Mar 2023 16:27:24 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm15534222plr.146.2023.03.27.16.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:27:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCHSET v3 0/4] Turn single segment imports into ITER_UBUF
Date:   Mon, 27 Mar 2023 17:27:10 -0600
Message-Id: <20230327232713.313974-1-axboe@kernel.dk>
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

Rather than repeat the same blurb again, see the v2 posting here:

https://lore.kernel.org/linux-fsdevel/20230327180449.87382-1-axboe@kernel.dk/

tldr - turn single segment iovecs into ITER_UBUF rather than ITER_IOVEC,
because they are more efficient.

Since v2:

- Add prep patch based on Al's suggestion on just making iov_iter_iovec()
  deal with ITER_UBUF.
- Drop previous two prep patches, as they are no longer needed.

-- 
Jens Axboe


