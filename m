Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664561D5643
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgEOQiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 12:38:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34780 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbgEOQiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 12:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589560692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Bg7RWFLPly3TX4Y/V49rHB9a190dlTFcmjCSkHrUK0=;
        b=aEVrnX8SEJcF2FYwgymeCiCSKvFxaJWdvLsVH/DXE2UJC6pyWmwIg4G4jeO8RShLoBPn6X
        1rcnZaX+3axWfleyeTR2H3DcgVwR334IA/lRF7aHtIcFZ+NoTsrpzQ+p4Cmvyu5Mzh5+aw
        kwVh777YtYo26FwYNr6yUYHGYG+p4Cs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-2h13lNY6OfCSVhtGuucrdQ-1; Fri, 15 May 2020 12:38:09 -0400
X-MC-Unique: 2h13lNY6OfCSVhtGuucrdQ-1
Received: by mail-wr1-f71.google.com with SMTP id q13so1437888wrn.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 09:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Bg7RWFLPly3TX4Y/V49rHB9a190dlTFcmjCSkHrUK0=;
        b=a8G727Y7dA6ja6S4u0mx4AUTK6EMUNkxQmkUQwhMuycMH3hzA2fM/4DSN7qosSiyz5
         UjgG0LvuqbPk2dCwdpXGAsuZH+T5Gj1c5d6+k0cwSe19CZC3BHnx01lLBY3Ad7NDbwFB
         2tSqspw/h/GVYW06t3oNkKEJTJoJ8Yx/HOH5IF0cYKV2dxm67q00sGutoMvPylkf7h3M
         ActHnGUbRe9DIY7gNrrg0sH8WOdj6E5TFVrOqfzOBSBL0YmMVImFhxNRCSeyDG0j9jpv
         r9skbmLdduqPL90T/tu2UTvumkD7fDXwtPjgb+4k0Y3Dv8yF48OwQltgGVa3enaLcxkZ
         xRnQ==
X-Gm-Message-State: AOAM531WF9+cQTM92quiBmK0wp/fBSB6/Hdq8VECpTgpK6HzsPuZ8N+B
        vYLyeisLo1/MU1veXS/GEhLwYiV3+swsb0FA7lwWK9rwjcC0BT8YBvk85sMNMk3yuulEbnGzcen
        USpAf02YNlO+5v+yyV7MDtWNuiw==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr5180362wrv.361.1589560687883;
        Fri, 15 May 2020 09:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ0wJAxWl28YCjenrP8G+kE5OMcm3BmJsWA9vMViZXynBcWONdSadJSiu/D24iHJbsAlDgVQ==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr5180340wrv.361.1589560687584;
        Fri, 15 May 2020 09:38:07 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id b145sm4680274wme.41.2020.05.15.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:38:06 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] io_uring: add a CQ ring flag to enable/disable eventfd
 notification
Date:   Fri, 15 May 2020 18:38:03 +0200
Message-Id: <20200515163805.235098-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v1 -> v2:
 - changed the flag name and behaviour from IORING_CQ_NEED_EVENT to
   IORING_CQ_EVENTFD_DISABLED [Jens]

The first patch adds the new 'cq_flags' field for the CQ ring. It
should be written by the application and read by the kernel.

The second patch adds a new IORING_CQ_EVENTFD_DISABLED flag that can be
used by the application to disable/enable eventfd notifications.

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
  io_uring: add IORING_CQ_EVENTFD_DISABLED to the CQ ring flags

 fs/io_uring.c                 | 12 +++++++++++-
 include/uapi/linux/io_uring.h | 11 ++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.25.4

