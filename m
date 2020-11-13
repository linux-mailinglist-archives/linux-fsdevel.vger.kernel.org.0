Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0882B296B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 00:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKMX67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 18:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgKMX67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:58:59 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D5C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 15:58:59 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q5so8968617pfk.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 15:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Y1r53EgDZ9GPkDu0iW3/1lZHQvd9hrf2kGJ+XVJEN+U=;
        b=m73zOIkf3o/buRHMz673QJXzC4YYhUU4elGPJOYkvcdqSH/c3KZ7NAgKmQf7ILd6fg
         oc2Ida81afiuiTE8YL4ZJ+4s0XuDiknrXA1g1XH+NqjUI/xye59Ygwdu67an5YakStzA
         prM1sLuOXbSFjj/4bn9THaJufARYKiVPsFjVQWe+GxBnEvmmlozVHV0i0K5cENCKaMJu
         vZAQnjNCH55hmC9vG9NwkVqhhc1592XMSosuVfd+De9l4rY+XVc+m0IEuzjjNF8OWpi6
         xgKAFqcE7yGetTTylEBPHOoOF/r22aBGk1Jt0amVWKlLVn7DDPdYfqxk2niLTZgXMpEQ
         WcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Y1r53EgDZ9GPkDu0iW3/1lZHQvd9hrf2kGJ+XVJEN+U=;
        b=Sg4g6cdDVi75ybDKliv0j+angVchhCZJNxyrIUzrFa1iaEhXJHhK1VpstqIkiJalw8
         J5BgH01CfR93YXiMDUfArIm5BuVYK3Z9GaK0PaqcoTW7FWPTcBrvOdziVwisG0wW/NtJ
         gjlhgQ1yxJTfA9wJbxQgs+9YDcft9LgXUamCljnX3+acEDZ5JW1j8V68WHW6W9sIaDup
         w5vgKwMCNzid0W6qV7NwlNt/P6uk4BFmeTJ69lauvJC7i1wRqWtUpQa0XPNvd7ZooS6I
         HCwpZsAfvy8GT2D6PuUaX1tOT/a/PHjescoIBp3QjwG4CmdpJI9wUp4g8fqRGvKvgecR
         k9IQ==
X-Gm-Message-State: AOAM532z+YORnt6LYL4b4ntX2kP8/SFRvZ0uA8lYMpZruk+koLWFbnWz
        nc0QNZFMsifhfm7By458crnESEH3jjEwUw==
X-Google-Smtp-Source: ABdhPJzc09ogkPJ8WqRAgRtmVFe6Cu954ptBqnY/n6co9LirFaAfdh6dzqhejfW7IQGgmFJYV2L0GQ==
X-Received: by 2002:a17:90b:784:: with SMTP id l4mr5444386pjz.146.1605311938747;
        Fri, 13 Nov 2020 15:58:58 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gk22sm11645741pjb.39.2020.11.13.15.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 15:58:58 -0800 (PST)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs: make do_renameat2() take struct filename
Message-ID: <2ec50734-92a5-a2b6-ad73-10df86b02c4b@kernel.dk>
Date:   Fri, 13 Nov 2020 16:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass in the struct filename pointers instead of the user string, and
update the three callers to do the same.

This behaves like do_unlinkat(), which also takes a filename struct and
puts it when it is done. Converting callers is then trivial.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This is needed to support rename from io_uring - We're not doing
async path resolution from there for /proc/self. Al, do you have any
problems with this patch?

diff --git a/fs/internal.h b/fs/internal.h
index a7cd0f64faa4..6fd14ea213c3 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -78,6 +78,8 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 long do_rmdir(int dfd, struct filename *name);
 long do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct path *link);
+int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
+		 struct filename *newname, unsigned int flags);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index d4a6dd772303..03d0e11e4f36 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4346,8 +4346,8 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 }
 EXPORT_SYMBOL(vfs_rename);
 
-static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
-			const char __user *newname, unsigned int flags)
+int do_renameat2(int olddfd, struct filename *from, int newdfd,
+		 struct filename *to, unsigned int flags)
 {
 	struct dentry *old_dentry, *new_dentry;
 	struct dentry *trap;
@@ -4355,32 +4355,30 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 	struct qstr old_last, new_last;
 	int old_type, new_type;
 	struct inode *delegated_inode = NULL;
-	struct filename *from;
-	struct filename *to;
 	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
 	bool should_retry = false;
-	int error;
+	int error = -EINVAL;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
-		return -EINVAL;
+		goto put_both;
 
 	if ((flags & (RENAME_NOREPLACE | RENAME_WHITEOUT)) &&
 	    (flags & RENAME_EXCHANGE))
-		return -EINVAL;
+		goto put_both;
 
 	if (flags & RENAME_EXCHANGE)
 		target_flags = 0;
 
 retry:
-	from = filename_parentat(olddfd, getname(oldname), lookup_flags,
-				&old_path, &old_last, &old_type);
+	from = filename_parentat(olddfd, from, lookup_flags, &old_path,
+					&old_last, &old_type);
 	if (IS_ERR(from)) {
 		error = PTR_ERR(from);
-		goto exit;
+		goto put_new;
 	}
 
-	to = filename_parentat(newdfd, getname(newname), lookup_flags,
-				&new_path, &new_last, &new_type);
+	to = filename_parentat(newdfd, to, lookup_flags, &new_path, &new_last,
+				&new_type);
 	if (IS_ERR(to)) {
 		error = PTR_ERR(to);
 		goto exit1;
@@ -4473,34 +4471,40 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 	if (retry_estale(error, lookup_flags))
 		should_retry = true;
 	path_put(&new_path);
-	putname(to);
 exit1:
 	path_put(&old_path);
-	putname(from);
 	if (should_retry) {
 		should_retry = false;
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-exit:
+put_both:
+	if (!IS_ERR(from))
+		putname(from);
+put_new:
+	if (!IS_ERR(to))
+		putname(to);
 	return error;
 }
 
 SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname, unsigned int, flags)
 {
-	return do_renameat2(olddfd, oldname, newdfd, newname, flags);
+	return do_renameat2(olddfd, getname(oldname), newdfd, getname(newname),
+				flags);
 }
 
 SYSCALL_DEFINE4(renameat, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname)
 {
-	return do_renameat2(olddfd, oldname, newdfd, newname, 0);
+	return do_renameat2(olddfd, getname(oldname), newdfd, getname(newname),
+				0);
 }
 
 SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newname)
 {
-	return do_renameat2(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
+	return do_renameat2(AT_FDCWD, getname(oldname), AT_FDCWD,
+				getname(newname), 0);
 }
 
 int readlink_copy(char __user *buffer, int buflen, const char *link)

-- 
Jens Axboe

