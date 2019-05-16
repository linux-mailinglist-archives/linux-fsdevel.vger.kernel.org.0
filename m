Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8041A20362
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfEPK1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39529 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfEPK1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so2760151wrl.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PiKGye4OdnurD2UG7Qy/Yk+AdnxTE8ZqIDQFphGQPkE=;
        b=Yl+dSSqlN+wslK/raRN19OJkoIjmmXZIR3TWFavXbZVWpLg5qqG1ebXRfipBuiIMgx
         iw3g4ciBL81SIatUw8wZjCoV+CK5RnaJQ84FBx7oZYhMqoIQFjkmUcWPVPtO706Jh6F1
         MBMzH+9HV3yh+lypyGZgEt40GtvijSL3TePEbfEbaVBDSlHJtSxR+sOIZh2AxTttb5Wa
         lgW8OuPWqfrsJOFS9dWLt00PAJbErihyuW8/IiEF5i4eu/PYQRm1weQcQwbC/2uu0fWd
         zRU7cCQR1ZeIY9j1LFIoxO2XKwKAHNW+HmjroIS5CLaf3JEFX9q8bcmk83lNoEU6dSZg
         vDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PiKGye4OdnurD2UG7Qy/Yk+AdnxTE8ZqIDQFphGQPkE=;
        b=OrC4nu/DHhZCTrCLqoANR191Bi1dFVp8LCLSLRE4JY7PvCWFlMICvYyMPzZ2g4ucUv
         RqG0DFhmRWV6DVvdMr4rwzlyoFxb8rYIIIUisVDRlUT8H9hdUHV5vH48A8S3SjAVK5UJ
         SE2hXPqgb2MOvMy7OSPBsKks1IfcEIk5OH82jprWXj5Ac5DFJOxwvK1FuxSB3LfOnfcv
         WYOJ7wV1Y+wRz5tnZsItcfn4EOYSSvhXAPqnebdHNaVch2HtHp4z7d238vsxYELYdy9E
         E6658IVxZ2/a/RiL/IU46wJ0o+WkmKYCfyi9u++S9vkS3qGR7U4Hnt/0ag4CEZ1GmhmI
         Sxuw==
X-Gm-Message-State: APjAAAXruRl0WUM1y999+5FGgHQUZER5LD44t8GHJU7Wwt4OM45CweVT
        NrEk1KZBdjsVDVDoHDWjUg8=
X-Google-Smtp-Source: APXvYqzjyQgI992E9Xx0p8+ZbR77CncYwBlUsDhPiVT3IpMlIJzo5SFDece9dQnuhxRz/Crj8cm2Ww==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr10948714wrn.108.1558002425341;
        Thu, 16 May 2019 03:27:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
Subject: [PATCH v2 09/14] fs: convert apparmorfs to use simple_remove() helper
Date:   Thu, 16 May 2019 13:26:36 +0300
Message-Id: <20190516102641.6574-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: John Johansen <john.johansen@canonical.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 security/apparmor/apparmorfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 9ab5613fe07c..4a10acb4a6d3 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -351,11 +351,7 @@ static void aafs_remove(struct dentry *dentry)
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(dir, dentry);
-		else
-			simple_unlink(dir, dentry);
-		d_delete(dentry);
+		simple_remove(dir, dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.17.1

