Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46F2AA43
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfEZOe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40517 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfEZOe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id 15so13316071wmg.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fy51Q99NF3Xg/9ON1BPdnx3YhZjEUI9wHY7Kw8oOSo8=;
        b=Tb60AvSfrXNIvGLNnSM/IJEInz5d5OBnpneC31kbtH4D2vL9lirL08XdUNvIFuld54
         VKpl204AMrTZmT+28vQaM/cRWe4SSQfi7gdhLj8X8UqSYcpApK7CD08L3zuZBb5Zws3Y
         5xVf6ntFCWCU9eSMXWA/Zb0yLGLLPUvYIbsshxu8v508H+7s/y7GZLNOQhtLSXdEtYBu
         copLAtguin46VeRd8APVuzQ08z3aM31pwHIeqsH4QSS5TVhbFT/x3xf/gpemX02M9uus
         T2VzjyOv+lokqmuUELisZ1re1ZlzcFmzGQCUt6m+p5/Si6DYl25FgIFT1vtc7bXIBG7z
         /u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fy51Q99NF3Xg/9ON1BPdnx3YhZjEUI9wHY7Kw8oOSo8=;
        b=VR+4+TpCyj42EnRYNyYvbCJYtEuLcws1dIXy+5aCef7e+W+7QPSyQeHNFiDpOlKlpF
         C5RgAFjoD826/3uUDdDlvoLn6slpwNVhSwj13NXWlcRo4wKjmxFKigNesuRJSo2JMext
         ISQ+tJOMXwxEOnNz6peXr8jrjd8+Htt27c+br/xjmSQ24mQOn6SbmbBq27O5K24sHQCV
         TCfKik+ePdXk+o5fn/cE5KujVwqQonKbvUo3MUIhtwEgsovVOPgx0aw3YG3fELp5bR92
         oyuEm8cUYJ31ZlDAhlFKx+kyY1cKL2jW/s2KgsmzbSwI7ktjdYxQxebQDBoitGij2aZt
         9r8g==
X-Gm-Message-State: APjAAAUT4J12mfUr8kOn374G/unIXUC/IzOWEHz1d35JiyyLJ/nHUEV6
        G+qCmyU7JViyTnQlXhrAt8o=
X-Google-Smtp-Source: APXvYqzJdEdyJscp/oAat6SXewQcXjBN0Tg+Ux86gsDkK8kBuQDV5EruLNZRmo1GFPYsqwcG91u+lw==
X-Received: by 2002:a1c:701a:: with SMTP id l26mr17505283wmc.32.1558881267234;
        Sun, 26 May 2019 07:34:27 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 03/10] rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
Date:   Sun, 26 May 2019 17:34:04 +0300
Message-Id: <20190526143411.11244-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 net/sunrpc/rpc_pipe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 979d23646e33..917c85f15a0b 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -597,6 +597,8 @@ static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
 
 	dget(dentry);
 	ret = simple_rmdir(dir, dentry);
+	if (!ret)
+		fsnotify_rmdir(dir, dentry);
 	d_delete(dentry);
 	dput(dentry);
 	return ret;
@@ -608,6 +610,8 @@ static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
 
 	dget(dentry);
 	ret = simple_unlink(dir, dentry);
+	if (!ret)
+		fsnotify_unlink(dir, dentry);
 	d_delete(dentry);
 	dput(dentry);
 	return ret;
-- 
2.17.1

