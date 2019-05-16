Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91A720365
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfEPK1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39540 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfEPK1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id w8so2760411wrl.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PWquflfDaJrkdOvqQTXIMVF7HKc8rtuLphpMKMGCCts=;
        b=YFJpUywYtIQZm4ZzE3P2rX7fHSLab6f9svleAEad1mWpctbsi6Uwnge035bmCpRAoW
         DHXWdRgi6XjWo3MJxth45jVr1GahqBmA4Sq7S3tbeMHFoprW7at4uJtfCwINOldlzByQ
         7WeG3Tuo8q3EL9NTuZ6+6ynqq3jfWJTG18KLk9AuU7BBWn5nTfZVvAPUFnJWNtKFsFB0
         kVp2yKHCySHxUKZu36HnGwjZkhBq8oCRysC3l97NMo0ON0iusm6D4luD6cPzHh18jIz3
         TYy6YZEq4UGxJioPfz/t8HaboR/KgZ7gcna562Yp/uTviD9o5ts6VB5Pczi49XW7VdXc
         yttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PWquflfDaJrkdOvqQTXIMVF7HKc8rtuLphpMKMGCCts=;
        b=sOaeJg4iDbGXTLvaJLKPj6mmzQQC8QiCtDF4FiB7pfB2wxy8XFOTaEE+kQHqJQ07FH
         ey99Rb8E9rpMTKeiIiBphB6BAEVud2QYpfPIfiLkn1yOKjohAP0juys3/6cjVYEjnptp
         AIDFIWaC2dpClDnDxCNTlY1fXtbfuB9toYhA0xX0jXFHblide4V8it1rDteLkaapGiAa
         YLLV+ZcvCYbs2OuOHV8K2mR64bkGQpcw8YmJYc0tq4SQUrPaZWXAiA2U6AerjcNGsK7a
         EYEBGSRer+wch2lBO1w0lKiwXvVqj2WX9tiMZEGG6WI6CIpYt/1NspYzx4nENjnjxiMv
         XDXA==
X-Gm-Message-State: APjAAAUdrHPFie/MMBXFW4nMjUOVEGiDDmEyv1Xxxr4Td0NMScghVaQV
        AaBu5TXSYQv4PSsFPhL4H4jXZbHe
X-Google-Smtp-Source: APXvYqyzRd52GVYuib8zBVHqDBy10DO88yW3PMo5HXb6+0WVyYQkF10FrjSH34FrmcghmpCYtO+Lgg==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr26667302wrn.109.1558002429070;
        Thu, 16 May 2019 03:27:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:08 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/14] fsnotify: call fsnotify_unlink() hook from devpts
Date:   Thu, 16 May 2019 13:26:39 +0300
Message-Id: <20190516102641.6574-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/devpts/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 553a3f3300ae..1d7844809f01 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -624,6 +624,7 @@ void devpts_pty_kill(struct dentry *dentry)
 
 	dentry->d_fsdata = NULL;
 	drop_nlink(dentry->d_inode);
+	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
 	d_delete(dentry);
 	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
 }
-- 
2.17.1

