Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58479BC5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfHXHYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Aug 2019 03:24:54 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:41005 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHXHYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Aug 2019 03:24:54 -0400
Received: by mail-wr1-f42.google.com with SMTP id j16so10522842wrr.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2019 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=s3Gss3HM5gbjg/V69lpsoE7stzUh5gs9evWb5TKK9xI=;
        b=dy4guNnbYZIMBHJ0AW0E/6mA4/qKnE2OF+5WRYbdO/NL5CulNWWxXuQm6BL3cBfZ8G
         p4SwJj4ST72NEcsXvnpcgRuYHsu0yZIFg46po5l/Y0xhlIBH8GEYQpx6/6Q1jjqlSz8N
         LgnIqY4TxIbC9J9/SU+ZifrHdg1yevhIexhDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s3Gss3HM5gbjg/V69lpsoE7stzUh5gs9evWb5TKK9xI=;
        b=HUXlmIC9N4DQ9T6+aTZ1S6VqFYEgmjoRzQngqi9A3FZ0rLH47+RzA4rBrrIS6xUiNS
         RK4JWrvdXr0jwMlE6BrOk7ZWd5uGOFgs6u8UTbfnAzApqiquWAYKzB9A/PSPdUwATQ50
         Ld7BCme0V3fu1a+l65Rq+TyiHBK3zYU+DHS0at9sQCquXKoS+lIQhPdGSzq+OQI/H/FQ
         TOjdmoNu+Dus6lG84ee1pddqUDVBAJ/HDF7zCginNM+BQyj/6JU7Nlk/xIK+50FTNX88
         QKATAcqu4sULxGP79gZsLcFIvPGmpweieidspBazYDZ5rCmygeK91fsCqHqtIymfsRmq
         SVsw==
X-Gm-Message-State: APjAAAW+i5ISrUDaBjuzQ6i/5y+qELNhTZzEqjWc5nGzzlxUGPkUb4f6
        ec/v65WM92Qpasj3wbpK1M+yE3AqwqJiYRrWnJtj0i3Ge/hQxw==
X-Google-Smtp-Source: APXvYqxCpKumqGenslAGg9UwlBBZpDQRkZj65PYjuK/tUlCQpMtygy3IHX6Yc8My/aZKbrtgtxymvWRzIlLpiXeHH/U=
X-Received: by 2002:adf:ed8d:: with SMTP id c13mr9527222wro.106.1566631491570;
 Sat, 24 Aug 2019 00:24:51 -0700 (PDT)
MIME-Version: 1.0
From:   Xavier Roche <xavier.roche@algolia.com>
Date:   Sat, 24 Aug 2019 09:24:40 +0200
Message-ID: <CAE9vp3JsD1KVqLXnLWpNrAtDSmm6gUa0KC_degOECDsGntvUXw@mail.gmail.com>
Subject: Possible FS race condition between vfs_rename and do_linkat (fs/namei.c)
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear distinguished filesystem contributors,

There seem to be a race condition between vfs_rename and do_linkat,
when those operations are done in parallel:

1. Moving a file to a target file (eg. mv file target)
2. Creating a link from the target file (eg. ln target link)

My understanding is that as the target file is never erased on client
side, but just replaced, the link should never fail.

But maybe this is something the filesystem can not guarantee at all
(w.r.t POSIX typically) ?

To demonstrate this issue, just run the following script (it will in
loop move "file" to "target", and in parallel link "target" to "link")
:

========== Cut here ==========
#!/bin/bash
#

rm -f link file target
touch target

# Link target -> link in loop
while ln target link && rm link; do :; done &

# Overwrite file -> target in loop
while touch file && mv file target; do :; done &

wait
========== Cut here ==========

Running the script will yield:
./bug.sh
ln: failed to create hard link 'link' => 'target': No such file or directory

The issue seem to lie inside vfs_link (fs/namei.c):
       inode_lock(inode);
       /* Make sure we don't allow creating hardlink to an unlinked file */
       if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
               error =  -ENOENT;

The possible answer is that the inode refcount is zero because the
file has just been replaced concurrently, old file being erased, and
as such, the link operation is failing.

Patching with this very naive fix "solves" the issue (but this is
probably not something we want):

diff --git a/fs/namei.c b/fs/namei.c
index 209c51a5226c..befb15f4b865 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4231,9 +4231,10 @@ int vfs_link(struct dentry *old_dentry, struct
inode *dir, struct dentry *new_de

        inode_lock(inode);
        /* Make sure we don't allow creating hardlink to an unlinked file */
-       if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
-               error =  -ENOENT;
-       else if (max_links && inode->i_nlink >= max_links)
+       //if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+       //      error =  -ENOENT;
+       // else
+       if (max_links && inode->i_nlink >= max_links)
                error = -EMLINK;
        else {
                error = try_break_deleg(inode, delegated_inode);

Kudos to Xavier Grand from Algolia for spotting the issue with a
reproducible case.

-- 
Xavier Roche -
xavier.roche at algolia.com
