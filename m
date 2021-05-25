Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507C138FC21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhEYIJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhEYIIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:08:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2EC061343;
        Tue, 25 May 2021 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BNR2u6tS6tCUMqCV/Xj1JMUUEnvow8kW7218xrnPbec=; b=vaeq4DFRvl/UQV9XSp384V7LH+
        ZYHzmzbqcJrzIcfJVZj8u7xeZZO8uiw1q0Vj2ud7+m91oLkeh5I/qqyBPETHXMZVqloz3ycSv80yf
        tUQrGn3PcdP7XPPovQ5k95gzG/D/sYVpcX/vOHzNxNrFqj8OduJnFwE54XFMLu/mJ1vLWquXVGs0I
        otWHqRuajrjvv503wYhzSisGsKvLngsQnkYmKLzJ7JqkAVd0zysYdm8itlxTgYkYa/zn1NpfQYlEm
        QDw1l9JJsh47fzTiA3zalbvOF7fUOelm1CsW/ZKsj1ATeaVRTm3OyqA9KNiYG9z7ybCvUEvkYG2LP
        GRuHvYsA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llS4U-003G8t-55; Tue, 25 May 2021 08:05:54 +0000
Date:   Tue, 25 May 2021 09:05:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <YKyv3sFKLKDWUZ3C@infradead.org>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
 <20210316112916.GA23532@quack2.suse.cz>
 <20210512110149.GA31495@quack2.suse.cz>
 <20210512150346.GQ19819@pengutronix.de>
 <20210524084912.GC32705@quack2.suse.cz>
 <20210525072615.GR19819@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525072615.GR19819@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding the dfd argument should be as simple as this patch (which also
moves the cmd argument later to match typical calling conventions).

It might be worth to rename the syscall to quotactlat to better match
other syscalls.  A flags argument doesn't make much sense here, as the
cmd argument can be used for extensions and is properly checked for
unknown values.

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 05e4bd9ab6d6..940101396feb 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -968,8 +968,8 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 	return ret;
 }
 
-SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
-		mountpoint, qid_t, id, void __user *, addr)
+SYSCALL_DEFINE5(quotactl_path, int, dfd, const char __user *, mountpoint,
+		unsigned int, cmd, qid_t, id, void __user *, addr)
 {
 	struct super_block *sb;
 	struct path mountpath;
@@ -980,8 +980,8 @@ SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
 	if (type >= MAXQUOTAS)
 		return -EINVAL;
 
-	ret = user_path_at(AT_FDCWD, mountpoint,
-			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
+	ret = user_path_at(dfd, mountpoint, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
+			   &mountpath);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a672bbe28577..ae34984e2ab9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -483,8 +483,8 @@ asmlinkage long sys_pipe2(int __user *fildes, int flags);
 /* fs/quota.c */
 asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
 				qid_t id, void __user *addr);
-asmlinkage long sys_quotactl_path(unsigned int cmd, const char __user *mountpoint,
-				  qid_t id, void __user *addr);
+asmlinkage long sys_quotactl_path(int dfd, const char __user *mountpoint,
+		unsigned int cmd, qid_t id, void __user *addr);
 
 /* fs/readdir.c */
 asmlinkage long sys_getdents64(unsigned int fd,
