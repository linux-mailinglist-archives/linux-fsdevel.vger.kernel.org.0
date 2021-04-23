Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C9C3695F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhDWPUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 11:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231858AbhDWPUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619191163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TaMjURk/uwKs3z6p90IdITDbLl5+F5GrY8JWDnXasqE=;
        b=aovWD9Wop84nxPw/KpHVjf0GDWZv0CImJLgDo9l4KrxJWQBFv8ZHxwgEMzC+bmviNnjrPa
        uLKTn32Ma3PajUdZJ3rQwS7Y/2IEQsO3bghmqb2DjVo4Vk2Cjf/BczSAIto8Xo/7YLn38k
        cMUIz6iB3rIJZwr2vtk8dk5wRm7V6HA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-CvkEzegQMXGHwtyzr4O8mg-1; Fri, 23 Apr 2021 11:19:22 -0400
X-MC-Unique: CvkEzegQMXGHwtyzr4O8mg-1
Received: by mail-oo1-f69.google.com with SMTP id k9-20020a4a43090000b02901cfd837f7baso12112520ooj.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Apr 2021 08:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TaMjURk/uwKs3z6p90IdITDbLl5+F5GrY8JWDnXasqE=;
        b=Q8V1hkk7HJj2rxsVOuX6dXG4DYAUVRrnZLRZ6PRdk9UDBZGCR+kQTwHIbdd99HErLS
         dlPAqWjPeGUKXnPA8gD98nugnKTh//tm48drW4RuDq/InM6gEH4If7kITzOrPpIHKPWD
         tNcnh3S4nGIB37HieqyWSwO2eOyCKsMsfcnjCYlun0ZZKxMqDt5Y8D7XVWDhnQ+eqOtv
         TXKq30br6AsKbNY2N1VBDr5kxDG9dk/ioqDaRrqTYm98i/5ngzPBy8illsugTcjL//Wu
         VIDdPBNNXfx7TeFUs25hyiPhnDK1udmVThENDD1+geWYwTo1cAODMdhyKCVP4YqUbzrz
         Npuw==
X-Gm-Message-State: AOAM532XLVij6R9WlcLExXdICSHtGW1g9edg2lINN2zWFxe6+MwZWSzT
        BxXSfzgOoLwBbxgxCWW37O1Gj0A8kAP1tNwCZpndTQXT0rCtn3RNgDNJcGYQBTFIGzTHjCKdf+y
        bsvlslgKsewLDDKT+IKoB/6UQ0S1QaVs9noScIZ6gTVLW3jVA3fMu6aEbLcNz36SGMkLFc1wTYS
        4=
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr3845074otp.209.1619191161323;
        Fri, 23 Apr 2021 08:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzurjzgiMl3cxgk/fC4pQBmh5uOr3MKrNK0XYkFBb7x8BJXo1a36i2WiGtf+HYNmB9ou5o41w==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr3845059otp.209.1619191161133;
        Fri, 23 Apr 2021 08:19:21 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id b12sm1468927oti.17.2021.04.23.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:19:20 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: Send FUSE_WRITE_KILL_SUIDGID for killpriv v1
Date:   Fri, 23 Apr 2021 10:19:19 -0500
Message-Id: <20210423151919.195033-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FUSE doesn't seem to be adding the FUSE_WRITE_KILL_SUIDGID flag on write
requests for FUSE connections that support FUSE_HANDLE_KILLPRIV but not
FUSE_HANDLE_KILLPRIV_V2.

However, the FUSE userspace header states:

	FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on
	write/chown/trunc
	^^^^^

To improve backwards compatibility with file servers that don't support
FUSE_HANDLE_KILLPRIV_V2, add the FUSE_WRITE_KILL_SUIDGID flag to write
requests if FUSE_HANDLE_KILLPRIV has been negotiated -OR- if the
conditions for FUSE_HANDLE_KILLPRIV_V2 support are met.

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..7dc9182d1ece 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1106,7 +1106,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
-	if (fm->fc->handle_killpriv_v2 && !capable(CAP_FSETID))
+	if (fm->fc->handle_killpriv || (fm->fc->handle_killpriv_v2 && !capable(CAP_FSETID)))
 		ia->write.in.write_flags |= FUSE_WRITE_KILL_SUIDGID;
 
 	err = fuse_simple_request(fm, &ap->args);
-- 
2.30.2

