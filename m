Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D475B39067B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhEYQU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 12:20:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhEYQU5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 12:20:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621959566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOLQrLx78QxIRxytGL8WQqOpzKDP90+qDZBKi8kCbGw=;
        b=y309SESAi1IKh9bbtHJp4fLSFcTpVLXMVAi8h1rX2nvwaFl40bP0icZKI5A6i7WH7Z927u
        WZIcIFVyPkmZ5Br9wUBCa+gxaNmtgWhAfdrQ63RJo7iVGblDoY0V1b4GjNtCBBzJvV7gRo
        Qq6XWMHMRdiuzp1S2TLcpPFlLnoAgfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621959566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOLQrLx78QxIRxytGL8WQqOpzKDP90+qDZBKi8kCbGw=;
        b=5y+TOxVgDFjkcLfOrHMRqSK3Fx1gDGHi/SmX9qxvjGhVYkNru/sdFXdqV5q1hC3zMBjlcF
        8qOp2s3GDpnc5VCw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CD5CAEAA;
        Tue, 25 May 2021 16:19:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BDC091F2C9E; Tue, 25 May 2021 18:19:25 +0200 (CEST)
Date:   Tue, 25 May 2021 18:19:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210525161925.GF4112@quack2.suse.cz>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
 <20210512110149.GA31495@quack2.suse.cz>
 <20210512150346.GQ19819@pengutronix.de>
 <20210524084912.GC32705@quack2.suse.cz>
 <20210525072615.GR19819@pengutronix.de>
 <YKyv3sFKLKDWUZ3C@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <YKyv3sFKLKDWUZ3C@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 25-05-21 09:05:50, Christoph Hellwig wrote:
> Adding the dfd argument should be as simple as this patch (which also
> moves the cmd argument later to match typical calling conventions).
> 
> It might be worth to rename the syscall to quotactlat to better match
> other syscalls.  A flags argument doesn't make much sense here, as the
> cmd argument can be used for extensions and is properly checked for
> unknown values.

Thanks for the patch! So I was actually thinking about going to completely
fd-based syscall like ioctl(2) and then we don't have to worry about lookup
flags or paths at all. What do people thing about attached patch?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--YZ5djTAD1cGYuMQK
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-quota-Change-quotactl_path-systcall-to-an-fd-based-o.patch"

From 359222f02ff7b69668a493207e3b84d53195f818 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 25 May 2021 16:07:48 +0200
Subject: [PATCH] quota: Change quotactl_path() systcall to an fd-based one

Some users have pointed out that path-based syscalls are problematic in
some environments and at least directory fd argument and possibly also
resolve flags are desirable for such syscalls. Rather than
reimplementing all details of pathname lookup and following where it may
eventually evolve, let's go for full file descriptor based syscall
similar to how ioctl(2) works since the beginning. Managing of quotas
isn't performance sensitive so the extra overhead of open does not
matter and we are able to consume O_PATH descriptors as well which makes
open cheap anyway. Also for frequent operations (such as retrieving
usage information for all users) we can reuse single fd and in fact get
even better performance as well as avoiding races with possible remounts
etc.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/quota.c         | 27 ++++++++++++---------------
 include/linux/syscalls.h |  4 ++--
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 05e4bd9ab6d6..8450bb6186f4 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -968,31 +968,29 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 	return ret;
 }
 
-SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
-		mountpoint, qid_t, id, void __user *, addr)
+SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
+		qid_t, id, void __user *, addr)
 {
 	struct super_block *sb;
-	struct path mountpath;
 	unsigned int cmds = cmd >> SUBCMDSHIFT;
 	unsigned int type = cmd & SUBCMDMASK;
+	struct fd f = fdget_raw(fd);
 	int ret;
 
-	if (type >= MAXQUOTAS)
-		return -EINVAL;
+	if (!f.file)
+		return -EBADF;
 
-	ret = user_path_at(AT_FDCWD, mountpoint,
-			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
-	if (ret)
-		return ret;
-
-	sb = mountpath.mnt->mnt_sb;
+	ret = -EINVAL;
+	if (type >= MAXQUOTAS)
+		goto out;
 
 	if (quotactl_cmd_write(cmds)) {
-		ret = mnt_want_write(mountpath.mnt);
+		ret = mnt_want_write(f.file->f_path.mnt);
 		if (ret)
 			goto out;
 	}
 
+	sb = f.file->f_path.mnt->mnt_sb;
 	if (quotactl_cmd_onoff(cmds))
 		down_write(&sb->s_umount);
 	else
@@ -1006,9 +1004,8 @@ SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
 		up_read(&sb->s_umount);
 
 	if (quotactl_cmd_write(cmds))
-		mnt_drop_write(mountpath.mnt);
+		mnt_drop_write(f.file->f_path.mnt);
 out:
-	path_put(&mountpath);
-
+	fdput(f);
 	return ret;
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 050511e8f1f8..586128d5c3b8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -485,8 +485,8 @@ asmlinkage long sys_pipe2(int __user *fildes, int flags);
 /* fs/quota.c */
 asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
 				qid_t id, void __user *addr);
-asmlinkage long sys_quotactl_path(unsigned int cmd, const char __user *mountpoint,
-				  qid_t id, void __user *addr);
+asmlinkage long sys_quotactl_fd(unsigned int fd, unsigned int cmd, qid_t id,
+				void __user *addr);
 
 /* fs/readdir.c */
 asmlinkage long sys_getdents64(unsigned int fd,
-- 
2.26.2


--YZ5djTAD1cGYuMQK--
