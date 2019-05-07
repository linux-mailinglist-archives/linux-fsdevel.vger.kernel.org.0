Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9315FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 10:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEGI5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 04:57:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52747 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEGI5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 04:57:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so8245464wmf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Z2sVzYpP+wgAKUKdpL2LjYw489n9WsWuxWr3ip8Pd4=;
        b=LVLmHvJq0N/68xeOQDEpjNlOvrdoCbKi7QCI5JHG/RL4ExKgL+ojc50giySybYrwi/
         PiKxNQ+yA6RrKNAfyocfSrsHLKuCxgr0lIIz4uwdM9WCKFXZkFKb4VnC4xM1NqZCy7wA
         d8CnLJxFNrUyoKZukZSmyW7qz3m9ZaIxC76pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Z2sVzYpP+wgAKUKdpL2LjYw489n9WsWuxWr3ip8Pd4=;
        b=srlRnssz10aO0RWb0WSNncl2Uo4cAsNq8lxCauttIqIYlEzyxM0FFoE0I02k9jflPV
         jmM2EX0d4LtRvXGP+ZTQbFsxH48wFTWIGjznkTHP2eaaVTdVSwZ92dwZKcq2zmL6CL5L
         52NnRjkxDJNfrZxPEalYY7o48GtcuY1KydQtf/6KpqQmzmXXIJQReKzSKmRdIYdlStd7
         9Gy0IGZbpc2Lqlzw/e8IQ9uufJ4e/UrqqV6ml3ShXWmL/WXpJR/HRm6dQHwD1kZt2U5M
         DuwNIggPRxR7iBpTAZqOQvIg6JMZrTKc7/QvBtKzJrhuGpQDQSZYddNNaHHIsOgtoDEd
         o12g==
X-Gm-Message-State: APjAAAXmdfVd6NXXUn+9aNHfu+9mydGHT4BiOOV9r0XDvro1xdNP+kLX
        MyZHYePoK3yPDoCn7jNsiitnTH/moG4=
X-Google-Smtp-Source: APXvYqyl0j4dXg2VfM3Q2EroRr/ElXYa/hS84HT+zP4S68xd6l028uNYXTNOVRGb9zVryYiTnjfTQQ==
X-Received: by 2002:a05:600c:2506:: with SMTP id d6mr20901593wma.106.1557219430542;
        Tue, 07 May 2019 01:57:10 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id u8sm11616473wmc.14.2019.05.07.01.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 01:57:09 -0700 (PDT)
Date:   Tue, 7 May 2019 10:57:07 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Steve French <smfrench@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] network fs notification
Message-ID: <20190507085707.GD30899@veci.piliscsaba.redhat.com>
References: <20190501205541.GC30899@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501205541.GC30899@veci.piliscsaba.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 04:55:41PM -0400, Miklos Szeredi wrote:
> This is a really really trivial first iteration, but I think it's enough to
> try out CIFS notification support.  Doesn't deal with mark deletion, but
> that's best effort anyway: fsnotify() will filter out unneeded events.

And this one actually does something for inotify.  I haven't tested fanotify
yet, but that one looks okay.

Note: FAN_MARK_MOUNT doesn't work yet, and we are not sure if it should work or
not.  FAN_MARK_FILESYSTEM would be a better candidate for remote notification,
since remote accesses are not associated with any particular local mount of the
filesystem.  But perhaps we need to turn on whole file notification for remote
due to the fact that applications rely on FAN_MARK_MOUNT already...  Btw, does the smb protocol support whole filesystem (or subtree) notifications?

Thanks,
Miklos

---
 fs/notify/fanotify/fanotify_user.c |    6 +++++-
 fs/notify/inotify/inotify_user.c   |    2 ++
 include/linux/fs.h                 |    1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1041,9 +1041,13 @@ static int do_fanotify_mark(int fanotify
 		else if (mark_type == FAN_MARK_FILESYSTEM)
 			ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
 						   flags, fsid);
-		else
+		else {
 			ret = fanotify_add_inode_mark(group, inode, mask,
 						      flags, fsid);
+
+			if (!ret && inode->i_op->notify_update)
+				inode->i_op->notify_update(inode);
+		}
 		break;
 	case FAN_MARK_REMOVE:
 		if (mark_type == FAN_MARK_MOUNT)
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -754,6 +754,8 @@ SYSCALL_DEFINE3(inotify_add_watch, int,
 
 	/* create/update an inode mark */
 	ret = inotify_update_watch(group, inode, mask);
+	if (ret >= 0 && inode->i_op->notify_update)
+		inode->i_op->notify_update(inode);
 	path_put(&path);
 fput_and_out:
 	fdput(f);
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1852,6 +1852,7 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
+	void (*notify_update)(struct inode *inode);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,


