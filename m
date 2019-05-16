Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296842035D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfEPK1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35523 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEPK1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so2599392wrv.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SXMAy2Tc7pT34BBm6t9XXqikNr+mRicfmU61npbyIgI=;
        b=jL1J7kQdPji14blEw0M8jwiLkTdXTMEQmh2dXPwDWYIbP1TFYG4i+ir11TjhlWe5lP
         2OEKKmuY7akVnOp7SnTkGvhBtyRXFRKFuFpw1evTy5BC/n6cc9LGguwgfwyFJxd7c+fu
         OEPRrAjymaCFpk4S2Q+WZGEKliEN8iE8vbdC3Wd/y4362v7FcN6yJMEXuAEchyBMZbM+
         6C0sT7+iMupdTWZ+96pCv/t10HBfGd8QuvWuoj7uL2WrsKOVMka/Xln26HEkZP9HF+/o
         3BkH2wNfoDbQSzXL1/0ibk4sfQNel7vBzuGcpEVmOdzWJFUWHTZR+2yApySeM2DrQ9ed
         GSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SXMAy2Tc7pT34BBm6t9XXqikNr+mRicfmU61npbyIgI=;
        b=i475010Z+Y+rrcd3ZjuzPUnFYhtrsGsRs6JoJTJEdN/WXKDj8FPmRp2PI/nditTkAF
         SIz0mh4jhpTKMEPtvfH5//9coDccaRolo76SKqfBzDqS6bFkHDK6wo/b162voqR+7mw1
         3eaQ6J6q0Jrhb2yvi4y9P/ytqwo8FM4ivkq6ZddOELBi2VDK8DHpuYChIA+wlHgieOrf
         TU4jnpE55Wvuc00OrfyylRYIJLrND2G0YnlTbfzbtu6MX1FxoZ0ys5s/wVEMlPAf2Kio
         7sIqQAQI1CNANZr2o+ERD7/4YAEgh8XxsW5bQicwfI3a0KwtWEPkGsACFlJ8h/u3UeNp
         AjeA==
X-Gm-Message-State: APjAAAUGPiAElUnWZ/3U/3ZvSed1a/M/druFVAzuaYHzJfAxcKElVH5U
        KqhIHXpW6xFgJiqrF9q+kxA=
X-Google-Smtp-Source: APXvYqwwwi3xERo0k5rImNc+Acp075Bd/gzEsROFwphCTl/dAigUfPXagw9LqYlP5MyDkfHYClPTWQ==
X-Received: by 2002:adf:f3ca:: with SMTP id g10mr5890386wrp.249.1558002418729;
        Thu, 16 May 2019 03:26:58 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:26:58 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH v2 04/14] fs: convert hypfs to use simple_remove() helper
Date:   Thu, 16 May 2019 13:26:31 +0300
Message-Id: <20190516102641.6574-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 arch/s390/hypfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index ccad1398abd4..30a0ab967461 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -70,13 +70,8 @@ static void hypfs_remove(struct dentry *dentry)
 
 	parent = dentry->d_parent;
 	inode_lock(d_inode(parent));
-	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(d_inode(parent), dentry);
-		else
-			simple_unlink(d_inode(parent), dentry);
-	}
-	d_delete(dentry);
+	if (simple_positive(dentry))
+		simple_remove(d_inode(parent), dentry);
 	dput(dentry);
 	inode_unlock(d_inode(parent));
 }
-- 
2.17.1

