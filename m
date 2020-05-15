Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60231D4BAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEOKyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 06:54:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725980AbgEOKyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 06:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589540060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=v6+7HSHBKR8s0hEc33VZWCAeaUDT8hTqdZCAfgvJPF0=;
        b=auwsXi5ChYKGe9gfeUvtqL62zydkMAhZSHybWOWtL2afFS2HcwvMftLHTfwCzdx7LN8q+y
        Zb846USVkIbP2M/Wai8jWGoA3QpuH0+2V/yuK3ei0yqhgG1o00bkD5cZrEqPOElktCdtid
        skRVMi+wXmLFHBTRckfPCjSpudt/2Fo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-TwMTKU6VPTic3yRykCvZ2g-1; Fri, 15 May 2020 06:54:18 -0400
X-MC-Unique: TwMTKU6VPTic3yRykCvZ2g-1
Received: by mail-wm1-f72.google.com with SMTP id n66so1005298wme.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 03:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6+7HSHBKR8s0hEc33VZWCAeaUDT8hTqdZCAfgvJPF0=;
        b=APRSyEUCKAAczDZf4x5aKONGez00uwzYkECBUxelgZuS75YDWFA2t/xCxxy/HCdv0x
         hde2HCbXfOEsO7tm0rv6N/vDQCKNByrcv7An/H7i5nBnNGdImyMH5K2XT0EKsbQAQAh9
         bX09sXtyfLhsgdxqVSeSJbqO6V2O/IoIpvov79XWkHudqHfquHo+EV8mazNT7NdnGEzW
         AQFW0egV6phSjLF101KfJIduzaPyVnFVfZ1xtNf/7NgG1HWwTe8eya9evmnaSPgVO9Ns
         bQEykX4iKyPzZKjH3IH/N6I5Dsf5kxWdg1NjaJs94oo2vYUa9X3VhaS8EGB+TwPs/dSC
         jqFQ==
X-Gm-Message-State: AOAM533r0nIKQMiwOo73zD7FEz7r4esiFxAYUlYhDZYFSQyQ5elWmNOr
        kgfKi932hxQFE+2aGtTClaPZRFv4G3QK0/bRPI/T8doHInkHYx0TcbmDZEbtDB7HFgjQVE4lNTM
        9ZVeAqBjXJy0rZZ2oW+CmmVvpyQ==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr611346wmh.141.1589540056768;
        Fri, 15 May 2020 03:54:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGKSyZ3EcGNQMbE2oXkZ+N+V0uB4B/vMGscbFwTRyBx5EdRM7q4us6BaR9smbe7DP+QNBN5g==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr611327wmh.141.1589540056541;
        Fri, 15 May 2020 03:54:16 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u74sm3081713wmu.13.2020.05.15.03.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:54:15 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/2] io_uring: add a CQ ring flag to enable/disable eventfd
 notification
Date:   Fri, 15 May 2020 12:54:12 +0200
Message-Id: <20200515105414.68683-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first patch adds the new 'cq_flags' field for the CQ ring. It
should be written by the application and read by the kernel.

The second patch adds a new IORING_CQ_NEED_WAKEUP flag that can be
used by the application to enable/disable eventfd notifications.

I'm not sure the name is the best one, an alternative could be
IORING_CQ_NEED_EVENT.

This feature can be useful if the application are using eventfd to be
notified when requests are completed, but they don't want a notification
for every request.
Of course the application can already remove the eventfd from the event
loop, but as soon as it adds the eventfd again, it will be notified,
even if it has already handled all the completed requests.

The most important use case is when the registered eventfd is used to
notify a KVM guest through irqfd and we want a mechanism to
enable/disable interrupts.

I also extended liburing API and added a test case here:
https://github.com/stefano-garzarella/liburing/tree/eventfd-disable

Stefano Garzarella (2):
  io_uring: add 'cq_flags' field for the CQ ring
  io_uring: add IORING_CQ_NEED_WAKEUP to the CQ ring flags

 fs/io_uring.c                 | 17 ++++++++++++++++-
 include/uapi/linux/io_uring.h |  9 ++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.25.4

