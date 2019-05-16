Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD320363
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfEPK1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40854 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfEPK1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so2880612wmb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrosxJxuqEP56M8QLL8XGLvEr2oqgW0pZ3sFOuyMfuE=;
        b=KLQHueo8rjrYg+n+iHJNuSzgmEMZJty00fj6Osq1f2rni5RF3Wvg/9HrJ16uMAOlU9
         AAXx+ADEe/fSBZHeppmmVjxTvXgO0TgcUcs8qX4N3pveQbsBTrHSJQyehh6sV9vog8Mo
         TeTg48DNPatuP1LMoXfPkDtyPlsbG54wA1OaRKkfsaNSbdRDXfErqnk1zKqKzGMdLzis
         2N85524B99Rnrcr2R9hwmWxyI1trz/eWyAwme2MwKLDPQTMy2FkiSMI06LD4Aam49Q9c
         5oGcGZ7wfqGtsivUzChSgu5GCYtllm/ORDq87/AVceviTT1P9+hQX34OQCiqmwf9J7rm
         9AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrosxJxuqEP56M8QLL8XGLvEr2oqgW0pZ3sFOuyMfuE=;
        b=uGOQVkd80gwkHDQeH4SXda8vE+MUVhL1ydarijWhM5dBSOLqHX/gXHrBqfOQEUj/1+
         W1LHkb+VrW2Du42yPKiV2SieQ9bjItzK4K7x/wEKKq0uOyf//W1eDlPb54LVpaP3NkUu
         QP/CtwdbCcckiCuNCMrGE4kGmLyDtp0ooOQlctQCMz+2zcotQbelhZoVvoLq/qJ+gMO4
         g8CfKtMNDxpAx3y39XnTejZhA5bQeE3heysAExRZhhl4zuaYbcZAWwXbWfoL4u82jJjN
         zu8MQbDRIcTxtzEMTNnxj+OpygkhIxHeMEgHIAMwCepZyW5W8xxoVxBiSxMlLd2uFXjK
         PL9g==
X-Gm-Message-State: APjAAAXZNNhC1MM90QvrzCVgVCJvoCfnP7W8aOdC4qUDIfEhV6MQI55y
        Q9hTCO1shwSJFNdd5DztUJM=
X-Google-Smtp-Source: APXvYqyqiIidIIQ4dNlUy37u73XrHi7+F0kVr6hw5JmyrWCoGIWb2AiQMF1uM/ESQFSSzWzBPzYafQ==
X-Received: by 2002:a1c:9c02:: with SMTP id f2mr13565242wme.8.1558002426780;
        Thu, 16 May 2019 03:27:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:06 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2 10/14] fsnotify: call fsnotify_rmdir() hook from btrfs
Date:   Thu, 16 May 2019 13:26:37 +0300
Message-Id: <20190516102641.6574-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/btrfs/ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6dafa857bbb9..2cfd1bfb3871 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2930,8 +2930,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	inode_lock(inode);
 	err = btrfs_delete_subvolume(dir, dentry);
 	inode_unlock(inode);
-	if (!err)
+	if (!err) {
+		fsnotify_rmdir(dir, dentry);
 		d_delete(dentry);
+	}
 
 out_dput:
 	dput(dentry);
-- 
2.17.1

