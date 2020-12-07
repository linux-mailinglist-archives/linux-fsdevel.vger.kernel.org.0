Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983172D163C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 17:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgLGQel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgLGQek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1fH8U2k617dM0XyiEykpCNbr+LOxy6e2jOJ7NB6sW0=;
        b=e/IrhDUJ5UrOemjndxXNFPZmGb7mXxAU0pfvFO+r/z7baK7qRDUQtjf+duM+5n97kB+LGo
        v5bne3pj1lyf4eB4hl8O0gn6iDzVYB1xM746YdsGk7dyP8iAp6e/VVFVuZSWA+k0yLSO4F
        PfRyxIR+p2Vnh80+IwBKQ2qXyPRq1Lg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-4GWLfU6lOQ6u1OPsrI4Jzw-1; Mon, 07 Dec 2020 11:33:12 -0500
X-MC-Unique: 4GWLfU6lOQ6u1OPsrI4Jzw-1
Received: by mail-ej1-f70.google.com with SMTP id m4so998795ejc.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1fH8U2k617dM0XyiEykpCNbr+LOxy6e2jOJ7NB6sW0=;
        b=MDIuG6tRZ9YB0zEg+Tlt8UTx+DYHyY4/jybNxqHAaxLVwA2nQsBKkD75Bo0K2C11fm
         V89j5T6CaejvPfduqzosjBCs/eQPYUU1nkmi1gWT/iPXhWLllOeCTP8LVmR+s/3mdgWX
         yUgf2Bi/0PRFYF23bFejYv48zk7R8E1McClyFjal6PwoHkjgeHQGgWxGKCcRrvepm1HZ
         fRHOZDpXDtJgF37HgwcS4c4J5W4IUAinCBZ0gBq8b8OH5vodhnJGHJ7pT5yvov5tnWl+
         KJG6hiOa+jacneJqrLvFwF8/v8HpmnKMroHjtam5SDi/elX82aZBo1dkFWuhdLtTdd65
         MyQA==
X-Gm-Message-State: AOAM5302Q69Xup5bC32aM67OAfP7rD7vVW8NKxL8qprkA+owr4GiZrbW
        VAR5laFBYoXkim2biWRYkAkQ+8llJBqRepuyUr5d96M2MhQYTR+pBZOioQL6sBBsuTfu/6roRyR
        LaLMeb932IGOveMODzZwgnprSHA==
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr19156481ejb.207.1607358790895;
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweaIFgMC09TO4pnW1Q9E6ePGnwgJZA2DaWMFT2e+UPWDLsluzpW5Ef28/5k5tUJJKQ0PR7fA==
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr19156470ejb.207.1607358790718;
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] ovl: do not fail because of O_NOATIME
Date:   Mon,  7 Dec 2020 17:32:53 +0100
Message-Id: <20201207163255.564116-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case the file cannot be opened with O_NOATIME because of lack of
capabilities, then clear O_NOATIME instead of failing.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index dc767034d37b..d6ac7ac66410 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,9 +53,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
-		realfile = ERR_PTR(-EPERM);
 	} else {
+		if (!inode_owner_or_capable(realinode))
+			flags &= ~O_NOATIME;
+
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
 					       current_cred());
 	}
-- 
2.26.2

