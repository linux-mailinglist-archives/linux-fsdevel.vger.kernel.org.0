Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70802DA011
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440576AbgLNTOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 14:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731702AbgLNTOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:14:15 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929DC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:34 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 81so17944515ioc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ob6tQYCIJyzoLm0w8K2xP8tWCorm/SCOOaYs3u3LzU=;
        b=ftnE8fmmd4Y69+MA8EEhCBvj9q5v5AwlvSZSiij30L6b1RMn500i9IzMzZSyYD3KQd
         iT3cNA6BgbylwlpEJiDIifxJKsqWPRi8g9WAw5+iQ4qi7coF0iOA41rc6pUNP+tJQMOe
         9Zt45JwTLRCMjm6Opdw3kIp7hqmzS4707T0x3XEoY7TGt4M73Qxk6ekLgR9fFyx8/+sw
         +7fswlP8jIDMSorlwDV+QmeJ4IkH3nTHEOal1oQNKPVsOaIDi8EzzVy5Bf17uRPqlnqs
         34vXirzUHky1xEt4uR4G4OhjEF4drXKOgmkH3VKO0z4X+aG3KjwyUeIIP6qPCmhlPSz9
         0BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ob6tQYCIJyzoLm0w8K2xP8tWCorm/SCOOaYs3u3LzU=;
        b=H+e2worR5XaCHVBdWLLtom6z0KLh0jauXk3xFM94rX5X1mClk5zvVmgcmOkrROtUIK
         DwhWgKyOLciLVHVX+5UsFvbA7QMdk9RJjlEv2T9y5zfitFFCKnkNW9JslR292cnRyyAt
         MitC3TwacGticQFf3JGSYUO2V2wrbAWA+7PUH17mTxfAxDQQImV12ucqh9CksnkFYqKF
         2JeapKum0Ox3Iq8QwpISTSZXPcRkF6XiGvAXf+rnq6/fN7RsOyFsFCI7KSDO3YlzkAFK
         eCcse3x0lQ9qS7rYAr2t8iU+rY1VKkZv8KSTt+9f8LkgPL9EFVrV6/XC/ld8gSbK+BBQ
         p3Mg==
X-Gm-Message-State: AOAM531FwWf3sAL+Cc0BTOsG8/sAD4Wo+7Ot23+zrx00xe+thgkaXdNf
        jyZSBbOUTvmm423qffkzFf5/jPntVwEQ9w==
X-Google-Smtp-Source: ABdhPJxyGkBiEHu9aKXF+tgGoY/51Ol/YtDPAe7DLY5eRdOovHZwUUFxuD4cGkOedGqHK2XL5Me9PA==
X-Received: by 2002:a5e:820d:: with SMTP id l13mr33397892iom.102.1607973213783;
        Mon, 14 Dec 2020 11:13:33 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 11sm11760566ilt.54.2020.12.14.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:13:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK / RESOLVE_NONBLOCK
Date:   Mon, 14 Dec 2020 12:13:20 -0700
Message-Id: <20201214191323.173773-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Wanted to throw out what the current state of this is, as we keep
getting closer to something palatable.

This time I've included the io_uring change too. I've tested this through
both openat2, and through io_uring as well.

I'm pretty happy with this at this point. The core change is very simple,
and the users end up being trivial too.

Also available here:

https://git.kernel.dk/cgit/linux-block/log/?h=nonblock-path-lookup

Changes since v2:

- Simplify the LOOKUP_NONBLOCK to _just_ cover LOOKUP_RCU and
  lookup_fast(), as per Linus's suggestion. I verified fast path
  operations are indeed just that, and it avoids having to mess with
  the inode lock and mnt_want_write() completely.

- Make O_TMPFILE return -EAGAIN for LOOKUP_NONBLOCK.

- Improve/add a few comments.

- Folded what was left of the open part of LOOKUP_NONBLOCK into the
  main patch.

-- 
Jens Axboe


