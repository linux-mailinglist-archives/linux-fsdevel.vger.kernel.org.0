Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26E9742A50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjF2QKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjF2QJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:09:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD52D70
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 09:09:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso1376351e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688054993; x=1690646993;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVQpm19ZsPB5l2eVz0uufXIbFSagGcLK+ucGfqBu58Y=;
        b=rqVU0/kQ9LGJLx7a6pSYXyKtI16Hp+e0TUK7qQTgvRydLZaPYjq9VrTMDSd1AFHCjE
         qbYT/HZRSZXF64NeBDxf+oPqWJRqA64oT+E/V4AWGZ492+krhBU0G8MYmimSjUAJmejX
         nR9WiW91YxgV9+y299w2ZX96LF2WhqqAJ6yTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054993; x=1690646993;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVQpm19ZsPB5l2eVz0uufXIbFSagGcLK+ucGfqBu58Y=;
        b=Ko3eZxkr6piuYh6MthUTEmFauuZUWPGbiZQKgIrdFrZXopGc7/LEM0BhCErpuxfimo
         ntDeFnQS3uOKUhD5Twa82HV/6IjI+ihbR+XfTf1l3cdwk2KU0tgsD/1QF5AuwSs+SKrM
         K5ni6pK1ol+CS9EV+aJu51/+D2UM8V80SS6AuWoeRuexzKCYfFIGraF5OQT5urfFysYO
         LXtpCYY3OqdGcR/h7P2UqRmTY+k4FU6E9Tys/Wn+m3nPn9Hwk1HTF2NwNJpMJXs8HnVM
         IqqDuTV/hDbMSGb6kILTJfYZToK6N3JDMGttZCnNP2LOcC97mcL3byvjW8x56DXBROaS
         5m3Q==
X-Gm-Message-State: ABy/qLYW4G5wo7BSi/U//yj4zOZWpxuxY5zfMY/ZFb7gSMnXFTNZ3xsw
        n/4+CpjTR7DZjZH6wK0cKD9YFMyuAL9uFxq+L71sQw==
X-Google-Smtp-Source: APBJJlG0OgPd8zjXJQepA1HB39UixVkkU1xtTu78MMenFsFjkHxu7EcX+VUIMJ0T4SYSnAX49kWxsFa8KjrpywhqXw4=
X-Received: by 2002:a19:3846:0:b0:4f9:556b:93c4 with SMTP id
 d6-20020a193846000000b004f9556b93c4mr270070lfj.31.1688054993213; Thu, 29 Jun
 2023 09:09:53 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Thu, 29 Jun 2023 17:09:41 +0100
Message-ID: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
Subject: Backporting of series xfs/iomap: fix data corruption due to stale
 cached iomap
To:     Dave Chinner <david@fromorbit.com>, djwong@kernel.org
Cc:     kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave and Derrick,

We are tracking down some corruptions on xfs for our rocksdb workload,
running on kernel 6.1.25. The corruptions were
detected by rocksdb block checksum. The workload seems to share some
similarities
with the multi-threaded write workload described in
https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@dread.disaster.area/

Can we backport the patch series to stable since it seemed to fix data
corruptions ?

Best,
Daniel
