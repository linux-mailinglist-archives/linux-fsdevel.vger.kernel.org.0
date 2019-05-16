Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4364220AB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfEPPIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 11:08:53 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37712 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfEPPIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 11:08:53 -0400
Received: by mail-yw1-f66.google.com with SMTP id 186so1487065ywo.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwNcDffx5FXLsst6ZfNoKJUq6CkZuIQmCoIEewj/ww4=;
        b=T7r2dQA5wEOeMwABynb3ybma5vAj/jQdtdwl3IDypiWBxREbT6kK3tJO8VUhUDIc+6
         BOAQVbNPEsHxIHHQNFB6gQ2VnOi4zY1rVX/b2Awithb44i1THLMk5NS4cYWyUFtZxzWq
         H/ZKfB0ciyTA0tUJ5qkLTID3Ej6QdsXbotIBU+Xo0seqjwk2ZnnBVXXqizyUznouf+C7
         Z1112gLDWRAlbqs2Lkq0BlSiKGXPIa0Ex/1ZJ8G61U9EL2tq1QLKMBVWcd0QG8QNoKZw
         eYD4Fc7Nr3s43KvpD7xg67JkKIK+XgdsdrvjlFUuj4foNvZiWoapGgSnIN6IcvAVYq6m
         aI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwNcDffx5FXLsst6ZfNoKJUq6CkZuIQmCoIEewj/ww4=;
        b=pHsnASS3038eg7Ca0ebjuRph3oM720KltpR8iiJvvdr+O5meaU7ihctGmn+oVlUTlL
         IMN4RbUhnpdmBkOHCC0actV/7lnIHMwgaXAt6Agby5U4qAgaGJ/g3jjrEekc0rO3eNCQ
         WpjryRRkzPvjRGGCBeG28qEYCgINKu0OgeADGgIE0iCZwDEMuDGzelKCMn6QRIoHnsYc
         62+ppice7dgHWRa48mA9B8GuSgt9X+p3uJodF5hIPNwYajVHfax/Csw6wyNxWwdtQqJP
         uRX62a2PoVJYwMdF7HXTTm3BHo5eB93GaSvoBbfpv56iMEUxKToxRWcJkXyd2Q+ACs3/
         cMFA==
X-Gm-Message-State: APjAAAX61G6V4QEEtneXT+5dnKI26pdqQeAUJBIfw/S/SWXkLxLwp47S
        bB3FlNGLKJOiUe6jN/ZXLNW78llincbqPudDVto=
X-Google-Smtp-Source: APXvYqxGLMBWLjs+4w3CMD7KrQSn+/ysr8/ePZmQzKOPDd243nz+wDxn2++8dTzKCkWGKiSm3CGdH1n46JJxvLnpaJY=
X-Received: by 2002:a81:63c3:: with SMTP id x186mr23586096ywb.248.1558019332717;
 Thu, 16 May 2019 08:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-3-amir73il@gmail.com>
In-Reply-To: <20190516102641.6574-3-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 18:08:40 +0300
Message-ID: <CAOQ4uxigP4rP=+h=_OXhetFd2ZWmYeLnv=zjUp21qV=sP5VtSQ@mail.gmail.com>
Subject: Fwd: [PATCH v2 02/14] fs: create simple_remove() helper
To:     John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear pseudo fs maintainer,

Today you received a patch from me titled
"fs: convert <your>fs to use simple_remove() helper"

The patch that you received depends on this patch from my series
and this patch is obviously needed for the context of your review.

Please review the use of the helper as a cleanup/refactoring
patch for your fs that should not change logic regardless of the wider
scope of my series.

For complete context and motivation, please see the rest of the series at:
https://lore.kernel.org/linux-fsdevel/20190516102641.6574-1-amir73il@gmail.com/

Thanks,
Amir.

---------- Forwarded message ---------
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, May 16, 2019 at 1:26 PM
Subject: [PATCH v2 02/14] fs: create simple_remove() helper
To: Jan Kara <jack@suse.cz>
Cc: Matthew Bobrowski <mbobrowski@mbobrowski.org>,
<linux-fsdevel@vger.kernel.org>


There is a common pattern among pseudo filesystems for removing a dentry
from code paths that are NOT coming from vfs_{unlink,rmdir}, using a
combination of simple_{unlink,rmdir} and d_delete().

Create an helper to perform this common operation.  This helper is going
to be used as a place holder for the new fsnotify_{unlink,rmdir} hooks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/libfs.c         | 27 +++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4b59b1816efb..ca1132f1d5c6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -353,6 +353,33 @@ int simple_rmdir(struct inode *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(simple_rmdir);

+/*
+ * Unlike simple_unlink/rmdir, this helper is NOT called from vfs_unlink/rmdir.
+ * Caller must guaranty that d_parent and d_name are stable.
+ */
+int simple_remove(struct inode *dir, struct dentry *dentry)
+{
+       int ret;
+
+       /*
+        * 'simple_' operations get a dentry reference on create/mkdir and drop
+        * it on unlink/rmdir. So we have to get dentry reference here to
+        * protect d_delete() from accessing a freed dentry.
+        */
+       dget(dentry);
+       if (d_is_dir(dentry))
+               ret = simple_rmdir(dir, dentry);
+       else
+               ret = simple_unlink(dir, dentry);
+
+       if (!ret)
+               d_delete(dentry);
+       dput(dentry);
+
+       return ret;
+}
+EXPORT_SYMBOL(simple_remove);
+
 int simple_rename(struct inode *old_dir, struct dentry *old_dentry,
                  struct inode *new_dir, struct dentry *new_dentry,
                  unsigned int flags)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..74ea5f0b3b9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3245,6 +3245,7 @@ extern int simple_open(struct inode *inode,
struct file *file);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
+extern int simple_remove(struct inode *, struct dentry *);
 extern int simple_rename(struct inode *, struct dentry *,
                         struct inode *, struct dentry *, unsigned int);
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
--
2.17.1
