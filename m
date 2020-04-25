Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA931B881B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDYR3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 13:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYR3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:29:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D5C09B04D
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2020 10:29:19 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e8so12564098ilm.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2020 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lonelycoder.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=W8PtJHuos4f7kE/zqDG6OHkG/lAdIycvdAHU7I6Bdno=;
        b=QAwk7HOufak0isMR0bjJqbvMbKHyAHp5rmb1AZZeIfyjmONJ2V0D8uD2dk+tv2MxGO
         81ybYAC6sdDrRW/6YDk0UQpcZSJqHNAAzL5FXoqGwgLfOQ8XvEGsuX88O6c06rdoNudf
         voV7rmelAsRf8RZSUEeKli0puf7wNajWrwbzRG64X62ysj0PymVqdMZwgX33Zu8tpXQE
         tCZoYeZQu3VGJwyBn03svenk3eBovEqyUYpQ9IKz+jQ0i5GPsXfgmVBoLZu7QB98xXi4
         KX4hHSAdp7L9ELMMqSJxYYo2sMfNqFgJwxa2etgT/fVPgpWiMkMv6bYmpJaoJQjQAwPg
         5WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W8PtJHuos4f7kE/zqDG6OHkG/lAdIycvdAHU7I6Bdno=;
        b=DA8bizpEe410rkNMd73XW/FPzxO6vsLN5NCNNol+wfgEpRyKhu+22DOuxgaXlf/HeA
         tNQMMz9IYO+9srkKxXUULEDDJewGHAdmjaRSw9pF5LOE43r4e58MUO/jH/bwO6vIubzX
         OBI4TlCl0htfiRqvxDfXE/0Zmb5RaHRUtI76NkKDGdYlP9b4Lh0hAIHforALQHppjKcl
         02GaIOX1hFGET2VSp5M4XLqKEASfWG97/7Yvzig610tIJioHzT9wB1sL+Im6+57Pb7sp
         Vqjs2SuSFMMVRpD0eUDmEG5JFJoGjGKYiqCZfafH4cklfI+3B0vMUk1vH56E5WmoLv5z
         0CUw==
X-Gm-Message-State: AGi0PuZIkliRsPCWOwWCbiZ4G9sO2XE0pJ1tUnAdMWwgo38klgB982Zp
        crqNHUCnGOGSLrHKST7kc6PcfqZBPx4s1+ZOLvH/cf/r2zg=
X-Google-Smtp-Source: APiQypKUEt9xF/24tAPEr9tI40zNE61VwJcz1azwPnHbzgJ7a7o4nnCN3OabPx9epXiZsMJgbnKzEDGrC33aDPXrhyY=
X-Received: by 2002:a92:985d:: with SMTP id l90mr14575191ili.108.1587835758992;
 Sat, 25 Apr 2020 10:29:18 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Smas <andreas@lonelycoder.com>
Date:   Sat, 25 Apr 2020 10:29:08 -0700
Message-ID: <CAObFT-S27KXFGomqPZdXA8oJDe6QxmoT=T6CBgD9R9UHNmakUQ@mail.gmail.com>
Subject: io_uring, IORING_OP_RECVMSG and ancillary data
To:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Tried to use io_uring with OP_RECVMSG with ancillary buffers (for my
particular use case I'm using SO_TIMESTAMP for incoming UDP packets).

These submissions fail with EINVAL due to the check in __sys_recvmsg_sock().

The following hack fixes the problem for me and I get valid timestamps
back. Not suggesting this is the real fix as I'm not sure what the
implications of this is.

Any insight into this would be much appreciated.

Thanks,
Andreas

diff --git a/net/socket.c b/net/socket.c
index 2dd739fba866..689f41f4156e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2637,10 +2637,6 @@ long __sys_recvmsg_sock(struct socket *sock,
struct msghdr *msg,
                        struct user_msghdr __user *umsg,
                        struct sockaddr __user *uaddr, unsigned int flags)
 {
-       /* disallow ancillary data requests from this path */
-       if (msg->msg_control || msg->msg_controllen)
-               return -EINVAL;
-
        return ____sys_recvmsg(sock, msg, umsg, uaddr, flags, 0);
 }
