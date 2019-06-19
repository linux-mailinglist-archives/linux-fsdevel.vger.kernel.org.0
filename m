Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1724B867
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbfFSMbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:31:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39278 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbfFSMai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so1644123wma.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH+k6ndWzHXcUGt/1dQWHzCs9DtuO0deMfiOOMoKDp4=;
        b=spvvZjMOjVAkWyORI9b37NHQqZkuL/TY8zlw77GlVWts/tq6EsH44u9pjIHZVl6kJQ
         pSe/p+pNKZlQizmlIZToNUWIT3CZaIT/Qktt0qvu2RPHSaGryycKkaW+Nta9yKzpTsIo
         MbmUlXJjK1reYHR7cF3JkqXYHMSdVwbYl5fXgY+UJXwEnqsp5qeeuum8syDreYkZzskD
         8HkQkxAtwbvftUkzFFR9VBnZzsYRY3I2u2nULz0xtY+pPHLw7GwTmoCGYSxgWH64g9I0
         PeQWEBjRRyAD6NKm6DtC9OSdnj84bAZNGP3JKgFG2/vchf3c6eMxV8JrPfglbylV8nbn
         544g==
X-Gm-Message-State: APjAAAXWWFTc+v5fDCxXaf3VR7QZPfEaB9/3VcaBYL0RxgmcYhAdEn3I
        GnKTa0/x1Z7EYhQW1HYhh8TKww==
X-Google-Smtp-Source: APXvYqzuyPwUZiu30WPoQqiKG/EAE+hhjNevOIChGgYRXYTK/dXvHdqIoIpAjRdiAlQh9pVuex6Smw==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr8881330wmb.25.1560947436334;
        Wed, 19 Jun 2019 05:30:36 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:35 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] proc: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:13 +0200
Message-Id: <20190619123019.30032-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the proc filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/proc/root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 6ef1527ad975..70127eaba04d 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -58,7 +58,7 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	int ret, opt;
 
-	ret = vfs_parse_sb_flag(fc, param);
+	ret = vfs_parse_ro_rw(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
-- 
2.21.0

