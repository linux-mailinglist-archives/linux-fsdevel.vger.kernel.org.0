Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F913764C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhEGL61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 07:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235595AbhEGL61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 07:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620388647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YXvAn6PhmCpGYLW0QYPpJQEW72/FRvqimCSflbY0beM=;
        b=IScXL8azk/nILs9p3STiE/MO+2GH9VPrd1fl64vUOagS+YFFVbZ6rNzc5ZSNBCkMWOOSJ5
        pGewXPmfHUnqNuwbJoJu1Em5yCHxbNM/phoh9DJa2AAfU3kd/dWqfh4+e8LpFq+VhBkGcl
        ZKjcSyFlJ/F8ni86UCfq0R+sH4ueM4E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-7YGwmzvzNqi16_0WWWu2CQ-1; Fri, 07 May 2021 07:57:25 -0400
X-MC-Unique: 7YGwmzvzNqi16_0WWWu2CQ-1
Received: by mail-ej1-f72.google.com with SMTP id v7-20020a1709061807b02903a3d1724659so2923380eje.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 04:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXvAn6PhmCpGYLW0QYPpJQEW72/FRvqimCSflbY0beM=;
        b=TtJmkVJOU398A85+0//gF8+q+GZ2Oud9oK+RRkrVvrW9P0xH1xvgYdjs5t3eCS44KR
         vtON/KHF8nzqBUHZZyRPBrGEYVjVV17/xB4bP8pKpeXVT+p8Iu4AXkXyv/UwyR91AW0z
         0e+W2KfXga9HpTCwO/kMl99DxlllXfe70Y3uqsEWjDaHIUnUpYJOXxLJ6+pO3t6IVKZ/
         bzhUQZpc5wZumQrBwu9eImXhbJFGyA9TnrISFFf6omOzCzQyiXmWvxq/H8JxvzvCJocH
         eeZCk2vdE6Zb4nOqX3uzogZt1OXF1P+3Oy3ldrrDH6kvQv/f56v6HhVyMCELch8Uh6A7
         sKVw==
X-Gm-Message-State: AOAM532pON4QT4Y51u9MrF5W2XP1YxXawyff1Z03MK3TrCDnxpDjnkKe
        YU99iGR89yxpVM02PuZF0CzLQfr0D8pcHpC0X0Jgj1i+pVAYyYCJl22EnHlTRGggphKkEk5Xoc1
        1o5VG1Zoj33W3ZgHeSYxDqg1Z3g==
X-Received: by 2002:a05:6402:518f:: with SMTP id q15mr10961518edd.345.1620388644407;
        Fri, 07 May 2021 04:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0mUjelRd+5LBa+/SoDUEq7Qu7Gn0SmyPwD91nNDesN5xWttmUuZOfJ500zMk6FJ/yUea2gQ==
X-Received: by 2002:a05:6402:518f:: with SMTP id q15mr10961502edd.345.1620388644218;
        Fri, 07 May 2021 04:57:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id l7sm3657324ejk.115.2021.05.07.04.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 04:57:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: fix suspicious security_locked_down() call
Date:   Fri,  7 May 2021 13:57:19 +0200
Message-Id: <20210507115719.140799-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The commit that added this check did so in a very strange way - first
security_locked_down() is called, its value stored into retval, and if
it's nonzero, then an additional check is made for (change_irq ||
change_port), and if this is true, the function returns. However, if
the goto exit branch is not taken, the code keeps the retval value and
continues executing the function. Then, depending on whether
uport->ops->verify_port is set, the retval value may or may not be reset
to zero and eventually the error value from security_locked_down() may
abort the function a few lines below.

I will go out on a limb and assume that this isn't the intended behavior
and that an error value from security_locked_down() was supposed to
abort the function only in case (change_irq || change_port) is true.

Note that security_locked_down() should be called last in any series of
checks, since the SELinux implementation of this hook will do a check
against the policy and generate an audit record in case of denial. If
the operation was to carry on after calling security_locked_down(), then
the SELinux denial record would be bogus.

See commit 59438b46471a ("security,lockdown,selinux: implement SELinux
lockdown") for how SELinux implements this hook.

Fixes: 794edf30ee6c ("lockdown: Lock down TIOCSSERIAL")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 drivers/tty/serial/serial_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ba31e97d3d96..d7d8e7dbda60 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -865,9 +865,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		goto check_and_exit;
 	}
 
-	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
-	if (retval && (change_irq || change_port))
-		goto exit;
+	if (change_irq || change_port) {
+		retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
+		if (retval)
+			goto exit;
+	}
 
 	/*
 	 * Ask the low level driver to verify the settings.
-- 
2.31.1

