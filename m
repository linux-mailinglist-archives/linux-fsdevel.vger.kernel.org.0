Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2C1362E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAIVzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 16:55:03 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36045 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:55:02 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so75529pjb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7GVSKV4F6bNHQbtnn1xWNA8+a7ZmcRqqi6Z4aNgeGA=;
        b=o37iHXGp65Rk0F0pK1xFqFPpnQd/WKN5KY466a+wyzlHSoLBCsdZxrfPvUUQSLOlT8
         rHhH3A+iDPu6V11/cmz+hyZ8RRAChafIntBfQm7i0/fNDXHeGI98GV+O2S93KYmpCDrG
         N4gJf3oYaJlKnwlSb7UsfkgcXGoK/W4wx/Pyn7uLtj00Ms5Foa4pGAqa9nJfg1kVwApW
         qPA49nyCy8y05IRz2dMCAelP4+0HTNB2qykTRdVa8tzMf6tQDMYeKYAfsp/m4wKqUX95
         LFxXoOV4qxPkXN5Mvn16Qq2zeVY4wc87USuITxzTan5jrZrwZrd9z3Nvgb4JmEXRoGw9
         V2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7GVSKV4F6bNHQbtnn1xWNA8+a7ZmcRqqi6Z4aNgeGA=;
        b=Luondv3B/CciHZgjfirnWx0Osu8DNe7JX5GsqAC4BE3Y+NUuVcheQHu0kjtZdRdEWx
         F2DZtmuA5sBc2VI9fpLRy6LO6tBO6nxdMsA59rfGrJ1oPqmm6F7pyPkmgzs7Ef03rFGG
         Cp8QJ81Hj4PnI5yhVEeLXJA+ptrJmAYGTPGOh1Qg+pUys+ZcwRlNYXZ64GuTOFmq47OG
         Z7+o4J+Ltj4F1k9rQwEUS4x7O6ahGuYxPZHx6SjhhEuOYhoH4Tz8jzuglsKKYf+Z6CS6
         QRhba5Oyi1x0J19lxwX9uBbNZhCjLLeG0XfJy6NzWRECNxIwbGSozGcJ1eU7pHbXjg40
         I2Lg==
X-Gm-Message-State: APjAAAU3Fv+Vjv/y5XvkCvp1FSaIfCjRwyGKYQ0ZDG+4r8FMkUVGpfm+
        351Hxz5IJ4akKdzsC7IxE5WTrg==
X-Google-Smtp-Source: APXvYqzay0u4UiA0c3NMCDCn2cO+dnn7O2PaiaVMcZodtNNHJIDvBJOVl2BTM9pOsCj6E9bkX3PJEw==
X-Received: by 2002:a17:902:7102:: with SMTP id a2mr99621pll.301.1578606901747;
        Thu, 09 Jan 2020 13:55:01 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r20sm8711536pgu.89.2020.01.09.13.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:55:00 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH-next 0/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Thu,  9 Jan 2020 21:54:41 +0000
Message-Id: <20200109215444.95995-1-dima@arista.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Magic sysrq has proven for Arista usecases to be useful for debugging
issues in field, over serial line when the switch is in such bad state
that it can't accept network connections anymore.

Unfortunately, having sysrq always enabled doesn't work for some
embedded boards that tend to generate garbage on serial line (including
BREAKs). Since commit 732dbf3a6104 ("serial: do not accept sysrq
characters via serial port"), it's possible to keep sysrq enabled, but
over serial line.

Add a way to enable sysrq on a uart, where currently it can be
constantly either on or off (CONFIG_MAGIC_SYSRQ_SERIAL).
While doing so, cleanup __sysrq_enabled and serial_core header file.

Sending against -next tree as it's based on removing SUPPORT_SYSRQ
ifdeffery [1].

[1]: https://lkml.kernel.org/r/20191213000657.931618-1-dima@arista.com

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Cc: linux-serial@vger.kernel.org

Thanks,
             Dmitry

Dmitry Safonov (3):
  serial_core: Move sysrq functions from header file
  sysctl/sysrq: Remove __sysrq_enabled copy
  serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE

 drivers/tty/serial/serial_core.c | 123 +++++++++++++++++++++++++++++++
 drivers/tty/sysrq.c              |   7 ++
 include/linux/serial_core.h      |  86 ++-------------------
 include/linux/sysrq.h            |   1 +
 kernel/sysctl.c                  |  41 ++++++-----
 lib/Kconfig.debug                |   8 ++
 6 files changed, 167 insertions(+), 99 deletions(-)

-- 
2.24.1

