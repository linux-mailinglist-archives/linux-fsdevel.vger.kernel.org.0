Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4199C9CCA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 11:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfHZJga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 05:36:30 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37724 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfHZJga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:36:30 -0400
Received: by mail-wr1-f51.google.com with SMTP id z11so14631359wrt.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2019 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gs/XcHuWdmUSJN2v6xljbmG9jqr2TGmxKKQc8QmB8+o=;
        b=S1DXy1JhQIPV/5DP2ksXdIkiRim1RxezU9xx8cokphPS2RU6x2F9CsxruMiZ5VDTeU
         GveBVMA8IGThBF+IvNbj1n9jTjZfMNIkrMCdfzHTGGod3PiNlrU2DvfQqFbOup6/kbhT
         V4USvVsOWdr6vyyAbOFvrfeVly8JxtpmC06uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gs/XcHuWdmUSJN2v6xljbmG9jqr2TGmxKKQc8QmB8+o=;
        b=K763gh/K2fOcQKGNsP4K5Fr7o2ncssUuveitd4OihQGOhE9Wrvm6jv4v57mTRo0m5Z
         3snIFbnr6ICiNgkmP8Lu3mdJxCn/yL3JBneIPwNEqpuSwV7k+Qz3CQBPN2Tf35DEZqnm
         A1dAM9gaTOXIWlqcORz8yamXmZ4UJmt13Uu6sK7jJ7wHr3+LVtWllERAgkaaTBOyFDFa
         xGCl44ppeSvK4n06PnILIMwUqzAhati3tjqQVgU+9lM/ds2RGeAh8ogrE0hOqkEBWksp
         XFduw2dDFlWceUKllq7/LkbN09H+0KIXySRh9XI8jil7UEuM6UBOVSXa8hlIORFYdxMT
         zd2w==
X-Gm-Message-State: APjAAAXabT5DSj4JFZUSBgxj2eZTCJvfV4U/OpTH39fuwFkBq1+K9QTC
        /B/91Y4chVPRAabWDCoLNlv5BfkrSAm4CmMch3jAJDnI4KY=
X-Google-Smtp-Source: APXvYqyf9sQWT41756JcOuElC8IR3PWP3kVgCqAbEdq5O+5Bgw30PdhH7gHsb+SQzZyp3394Phvk/mhnHeIfTJ7/qsw=
X-Received: by 2002:adf:d08e:: with SMTP id y14mr20808856wrh.309.1566812187624;
 Mon, 26 Aug 2019 02:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAE9vp3JsD1KVqLXnLWpNrAtDSmm6gUa0KC_degOECDsGntvUXw@mail.gmail.com>
 <CAE9vp3+SwbbEsXrttvTrw0+Go6CSL8ZrHCE6+zac+7O-dkkFuA@mail.gmail.com>
In-Reply-To: <CAE9vp3+SwbbEsXrttvTrw0+Go6CSL8ZrHCE6+zac+7O-dkkFuA@mail.gmail.com>
From:   Xavier Roche <xavier.roche@algolia.com>
Date:   Mon, 26 Aug 2019 11:36:16 +0200
Message-ID: <CAE9vp3L2kpL4P1yp2F9Oi24Qm8_W6TSGGce4TvYYKXccd+8HrA@mail.gmail.com>
Subject: Re: Possible FS race condition between vfs_rename and do_linkat (fs/namei.c)
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One more addition:

This issue seems to be a regression introduced by an old fix
(aae8a97d3ec30) in fs/namei.c preventing to hardlink a deleted file
(with i_nlink == 0):

Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Sat Jan 29 18:43:27 2011 +0530

    fs: Don't allow to create hardlink for deleted file

    Add inode->i_nlink == 0 check in VFS. Some of the file systems
    do this internally. A followup patch will remove those instance.
    This is needed to ensure that with link by handle we don't allow
    to create hardlink of an unlinked file. The check also prevent a race
    between unlink and link

    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/namei.c b/fs/namei.c
index 83e92bab79a6..33be51a2ddb7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2906,7 +2906,11 @@ int vfs_link(struct dentry *old_dentry, struct
inode *dir, struct dentry *new_de
                return error;

        mutex_lock(&inode->i_mutex);
-       error = dir->i_op->link(old_dentry, dir, new_dentry);
+       /* Make sure we don't allow creating hardlink to an unlinked file */
+       if (inode->i_nlink == 0)
+               error =  -ENOENT;
+       else
+               error = dir->i_op->link(old_dentry, dir, new_dentry);
        mutex_unlock(&inode->i_mutex);
        if (!error)
                fsnotify_link(dir, inode, new_dentry);


Regards,

-- 
Xavier Roche -
