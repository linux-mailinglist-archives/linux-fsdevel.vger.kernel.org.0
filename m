Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8927176192
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 18:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCBRvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 12:51:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51093 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBRvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:51:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so1510wmb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pb95E00qJt13iWTog3FXOsgax75wf6WaIkcw28uyMlc=;
        b=e5js09qmzuQmFNbwwvYJJXKYkaHmkTgpdchmTZ802ygwq6rWIhdMl+8nayrC1yUByS
         5/Tb66nJiqisnU+KXFadjnIP9R57WNOruQG+ah4dmJynCD9HXBnYWYGEjV1ot9PLSJij
         xSrNhp722oBcKeO9kSZbhDnvVK4uCWn7WJQFQ/ntYh0zkyaJ0QDuTHbvUN8MDDnVgZ+Y
         kvAo6cj3DGcaYW5xYJ6do3dh7lW7R5OXgqOS1jopG5arCG+/z8hxOPRsYexPVmvK65NM
         Klu8VDe5t19hoMzhUR7Sp8mfv3bBWL/K0/gVvYH2Wk2Mm/Hfw3zC91lhnzLxM7jRKyB2
         C9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pb95E00qJt13iWTog3FXOsgax75wf6WaIkcw28uyMlc=;
        b=jHWsWvVU/Fcf9cZ/kvnKFKHwyFsHcgE4TDusuw2Tj6II66ujDPauQb4wFoEOFq3sp4
         TJHDh603UyNFos+9IA5IubnbTXMM+D5KNL+7lfhWZ8Y+2QrEbXUgw3fpRJhyTIlbNvMx
         h+CyShLtzn+ZLF/X50gTQ+WsBJ5cSUOWEkvrlafQ3YNPNYc5lInSTLyj49u1TDBVnqIX
         6DK/yGo9hsKEmAKvnmeIwpuUN0gPSB3OYCKyTkhxfkU9h6eS11LS26oImIY0ulbvQTXw
         HUmjCsUIYnQ5XBWD4RL+eduu8Wm4zr7G8+tJa7WcMweh2tqefCkko0YRygC/4PlRwgqU
         y3fA==
X-Gm-Message-State: ANhLgQ3EOY/yVQQR34VybOP1JBM3UiKxmJqw+gT2BGyViScSafAu/9fw
        8TqkXI62mLjCUUgd07Vcqfimcw==
X-Google-Smtp-Source: ADFU+vsFr2KTv4/KKUSrBKY28s9eXDJo3L5bmZDOjL8AoWf2qi6HO/kr1bKia+ebeQ9aRe9mgw4NNA==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr230134wmf.142.1583171502083;
        Mon, 02 Mar 2020 09:51:42 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b10sm163234wmh.48.2020.03.02.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:51:41 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHv3 0/2] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Mon,  2 Mar 2020 17:51:33 +0000
Message-Id: <20200302175135.269397-1-dima@arista.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Magic sysrq has proven for Arista usecases to be useful for debugging issues
in field, over serial line when the switch is in such bad state
that it can't accept network connections anymore.

Unfortunately, having sysrq always enabled doesn't work for some
embedded boards that tend to generate garbage on serial line (including
BREAKs). Since commit 732dbf3a6104 ("serial: do not accept sysrq
characters via serial port"), it's possible to keep sysrq enabled, but
over serial line.

Add a way to enable sysrq on a uart, where currently it can be
constantly either on or off (CONFIG_MAGIC_SYSRQ_SERIAL).
While doing so, cleanup __sysrq_enabled and serial_core header file.

Changes since v2 [2]:
- sysrq_get_mask() renamed to sysrq_mask() as there isn't
  sysrq_put_mask(); acquired kernel-doc (by Greg's review, thanks)
- uart_try_toggle_sysrq() now returns true/false instead 1/0 as it's
  a bool function (nits by Joe Perches, thanks!)
- Dropped "sizeof(port->sysrq_seq)*U8_MAX" and used U8_MAX (Randy Dunlap)

Changes since v1 [1]:
- Fix typo in pr_info() message (noticed by Randy Dunlap, thanks)
- Add SYSRQ_TIMEOUT define for timeout after BREAK and separate removing
  @unused member of uart_port into cleanup patch (by Greg's review, thanks)
- Add const qualifier, make uart_try_toggle_sysrq() bool function
  (Joe Perches, thanks)
- Fix !CONFIG_SYSRQ and CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
  build failures (kudos to kbuild test robot)

[1]: https://lkml.kernel.org/r/20200109215444.95995-1-dima@arista.com
[2]: https://lkml.kernel.org/r/20200114171912.261787-1-dima@arista.com

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Joe Perches <joe@perches.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Cc: linux-serial@vger.kernel.org

Thanks,
             Dmitry

Dmitry Safonov (2):
  sysctl/sysrq: Remove __sysrq_enabled copy
  serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE

 drivers/tty/serial/serial_core.c | 75 +++++++++++++++++++++++++++++---
 drivers/tty/sysrq.c              | 12 +++++
 include/linux/serial_core.h      |  1 +
 include/linux/sysrq.h            |  7 +++
 kernel/sysctl.c                  | 41 +++++++++--------
 lib/Kconfig.debug                |  8 ++++
 6 files changed, 118 insertions(+), 26 deletions(-)

-- 
2.25.0

