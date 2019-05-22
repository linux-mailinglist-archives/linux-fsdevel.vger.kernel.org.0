Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF327227
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 00:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfEVWSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 18:18:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41314 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfEVWSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 18:18:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so2049440pfq.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Jd0RSCXoP1EdL1cjt/xgeuNaQX2V7Ph/JBkgB7uNH0g=;
        b=GXLavN/7grE6LNJqyGhvPPesKBk185WFjgJna7ETOIJBaq1hY/O3DZYH9mqYTRPG6J
         GdFKCMBa8+OJJ7SXTg/NgAmRQpnKKVfSSiZLmo2keKmw0ot67menzPS8qFUMaPrsgUDO
         GNub7HFs2rNTz94sRTH62HK1i3T4MLXdmoCYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jd0RSCXoP1EdL1cjt/xgeuNaQX2V7Ph/JBkgB7uNH0g=;
        b=KAt3zgOCrpS7iqS889EGOJdrJwmjgURvl5UvRZexIF+d/yiqFBhZjQBjBry4KeQ0I6
         C2W2abJ4tKLIo4PD20ktHaG+zkyh8ZEQHe7xXZrMoVVxOA01RfyNtmsiW4ZONs73i791
         G/WIZbb6psjYwiLT7YMMpSWhz7IOMd3T9gmt940BcbsQdZ6XdE1SqvUNpmeCt3ezR8v/
         2WfrgfxgB5NK92+fh4eXx+hL32AeaZ5XSUneI/QEs9ed02vHQPPgzX1Wh0Ifw8pfxmlU
         OeqMs7vutMsIYoqqtojkUywyQ1Ao6uMZeKfRfsSfPQVteOzqSBtLbHmoJC9lERLeqP6f
         7ApA==
X-Gm-Message-State: APjAAAWh43eY0Tuc4Q5Ima/Z8fKUOhuPdsJzpbbdxY8/U8GatZO0Z4PE
        7tfBaN/POEKn0DUI9wlWYWyI+NykScuVEJQk
X-Google-Smtp-Source: APXvYqwYkSpq4sI0OwVnuYJtsng97b6lnFAf2peUNKoiZTQR4ze4ezgmfpK+1cl50ZPOllSPkVklsg==
X-Received: by 2002:a63:6f0b:: with SMTP id k11mr92068194pgc.342.1558563487623;
        Wed, 22 May 2019 15:18:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::e733])
        by smtp.gmail.com with ESMTPSA id l7sm28232045pfl.9.2019.05.22.15.18.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 15:18:06 -0700 (PDT)
Date:   Wed, 22 May 2019 18:18:05 -0400
From:   Chris Down <chris@chrisdown.name>
To:     deepa.kernel@gmail.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de, axboe@kernel.dk,
        dave@stgolabs.net, dbueso@suse.de, e@80x24.org, jbaron@akamai.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        omar.kilani@gmail.com, stable@vger.kernel.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org
Subject: Re: [PATCH v2] signal: Adjust error codes according to
 restore_user_sigmask()
Message-ID: <20190522221805.GA30062@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190522032144.10995-1-deepa.kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Cc: linux-mm, since this broke mmots tree and has been applied there

This patch is missing a definition for signal_detected in io_cqring_wait, which 
breaks the build.

diff --git fs/io_uring.c fs/io_uring.c
index b785c8d7efc4..b34311675d2d 100644
--- fs/io_uring.c
+++ fs/io_uring.c
@@ -2182,7 +2182,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 {
        struct io_cq_ring *ring = ctx->cq_ring;
        sigset_t ksigmask, sigsaved;
-       int ret;
+       int ret, signal_detected;
 
        if (io_cqring_events(ring) >= min_events)
                return 0;
