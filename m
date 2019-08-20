Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EC0954E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfHTDOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 23:14:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHTDOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:14:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so2428145pfc.11;
        Mon, 19 Aug 2019 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQPEFXG5NaLlLl7jM/5xQz0mHSvpnN8IjBBA+T4iEGI=;
        b=iMbBm1t2dofey1/BjH/Eg1cEpum8t/m7wE9e1cyHBXL7q/vtT2D5LiAGnel49NAZs1
         5xEy/yW7jwaNHsZBbu4hLW12egjPaBs8gj+opFvWOgSEI+IoO5M7FnuLR62+5rwGctpd
         fAF/+nTqyGVGFDiMY1Q8FoP4W943aNDB1YdRAIEnT8fxcz2Z1GmDOaHMe3odEyqYu6SF
         iDTmdXEByZOoQtpCS3yJj5EgnHmdAEboGvyme0iHZcnR3FQfO0LrJ6wNChu9iZhNeOwu
         u6nxe7f2/gL0cvp2pSMeLllYTe/nkEWWN77pGqjtqyGV4QCOPp3ybAxjRxkwm0Xsht/8
         lH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQPEFXG5NaLlLl7jM/5xQz0mHSvpnN8IjBBA+T4iEGI=;
        b=pMTlPet/nly6zn946zHjUSmt+EuJBFKLbyn6JLQ6Hs6oKjaBFyQ/Wu9S0Z0ZGAjOX/
         V7tGxF4QfluP1Eob3dBK0IhQAYJnjjoGxNuwTgmpyjKaHAo+wY9vx348o5Jpm9pAVVn8
         NdGqaV9vu/FqP42qVq2Bsen2xHluO2MoogAhc1q23umK9BrrlAb0CtkRToWpv7gcz0XL
         uXw9ZCFD6b9iev15NW3AID3vZG0m7AOp255J7IFAUczwXEmeHqDv7g0hhsGtN+T1iX5s
         o+tRSUijuupckjXKRol5dubBuo7M4jrrJDjxFdZ0EMNYoEgW8Xipy2zXl0AGyv2XdFOD
         S5jw==
X-Gm-Message-State: APjAAAU9xLxCFYrHRmsf1QwwkJhe6qT8xsD24ObaFoVELiy+M6LqJMOv
        7a8M/lVp8AmFN+thAkQFSp4=
X-Google-Smtp-Source: APXvYqzTyrvm8j5S2KopDYOUCwWLbYjSfCB/F2McmAtf80ofjPkVHJavNFhSAmrdz0MFXxcGSNfoFA==
X-Received: by 2002:aa7:8dd2:: with SMTP id j18mr27375110pfr.88.1566270853683;
        Mon, 19 Aug 2019 20:14:13 -0700 (PDT)
Received: from localhost.localdomain ([175.223.16.125])
        by smtp.gmail.com with ESMTPSA id y16sm22979651pfc.36.2019.08.19.20.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:14:12 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 1/2] fs: export put_filesystem()
Date:   Tue, 20 Aug 2019 12:13:58 +0900
Message-Id: <20190820031359.11717-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modules, e.g. i915, can use exported get_fs_type(), but are
unable to put_filesystem(). Export it and let modules to
decrement file systems' reference counters.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 fs/filesystems.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9135646e41ac..02669839b584 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -45,6 +45,7 @@ void put_filesystem(struct file_system_type *fs)
 {
 	module_put(fs->owner);
 }
+EXPORT_SYMBOL(put_filesystem);
 
 static struct file_system_type **find_filesystem(const char *name, unsigned len)
 {
-- 
2.23.0

