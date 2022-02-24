Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E044C2341
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 06:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiBXFRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 00:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBXFRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:17:15 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311F2ACA;
        Wed, 23 Feb 2022 21:16:45 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e2so1226048ljq.12;
        Wed, 23 Feb 2022 21:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=18860cMb/URSkshgbrnOr0/8ErWRf8j4conFU0FMPxc=;
        b=cr4wpHLBLM3w7i0VaGELXcAQk5y74c52zEIGpH7eVpSodrPuisysypBlywGkNAhPXw
         HXE/hHevUjJaqLtsAO9+/5v7sVOBJ4wVYK5UC8u5f6S3dsstWNSA4P5mvV2rwjLC3sVy
         WcpoIswP7a/37plJBB64aGs6y5tkZ5AD4/DerwATciWLDY3B5G8LMDvLGig13CFUrXm8
         6IWH9sFzgomZ/1Xy7hrIsjM6scEElkHhTe/rqrsi+GvQ4olavrJCRcXVFphdys8ovUTt
         iTVf/Z1FhCLKfdgCvJuKpoJZdJrwi1VohisICwFXREQIkCGgYtoCtM9eE2Bc9z/U42NP
         djLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=18860cMb/URSkshgbrnOr0/8ErWRf8j4conFU0FMPxc=;
        b=6VH1NmB2r3pIURwzZ5cothnlSeLITKQeYYjDicVTm0p27tNDeH9YqKmWqJ9Tk5mB1a
         g10NB1IYc/GFo568TZng0NQQYgF6qXSh9H4XQ+Cy05rrObIya8l5+QMhWsX4N4moeyLY
         0+Inqfj9U5GjTI2/Gg+7VjzeNnB2l8Fseq+yOtutQVGk18wOS6/K2LFuO0aclXieqmVK
         q46fXi2MapanD7gqV5wu2cHvShTzkHZb46cwFivgZjAR7Q8uAPvmOahS8WXQqua+D4oC
         c1yddWMNwMXG1ffftrX048GA0j/OSpMSu/kgX+oyvVvnp4lUVrkntn/BD0ra+qap/d9B
         ZLrQ==
X-Gm-Message-State: AOAM532lA8QXWljQqEYrEIHo4Z/YbifhX4wAxLL2c2hMBBj84pNKtIT9
        0BYHzWerdREMLo6SDYiAzdXfNGZ2r4kSZBkq4ktLCekthug=
X-Google-Smtp-Source: ABdhPJzXCO4D+WAQIXeO2Cq6DQ4gWkr6/BE6hSzZ9kff5K5UgWAlafhA10OiKnj/ackhhFkOZK/9pf1cYtQRRqJAA0Q=
X-Received: by 2002:a2e:b014:0:b0:23c:9593:f7 with SMTP id y20-20020a2eb014000000b0023c959300f7mr736675ljk.209.1645679804044;
 Wed, 23 Feb 2022 21:16:44 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 23 Feb 2022 23:16:33 -0600
Message-ID: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Enabling change notification for network and
 cluster fs
To:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently only local events can be waited on with the current notify
kernel API since the requests to wait on these events is not passed to
the filesystem.   Especially for network and cluster filesystems it is
important that they be told that applications want to be notified of
these file or directory change events.

A few years ago, discussions began on the changes needed to enable
support for this.   Would be timely to finish those discussions, as
waiting on file and directory change events to network mounts is very
common for other OS, and would be valuable for Linux to fix.

-- 
Thanks,

Steve
