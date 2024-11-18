Return-Path: <linux-fsdevel+bounces-35070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7609D0B3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 09:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460CF1F221B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628718B46E;
	Mon, 18 Nov 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJWxoI3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28544161302;
	Mon, 18 Nov 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920053; cv=none; b=dFxyJ5OspkdaJTY8QymjJKVkGoiZ0uLeATGz8bBWXKjtUlHdb1SwXM9dRyWKXEz9OC3mbvVkaJCFyWFDBD/kjNHdhd+7i0PekBTUZHfzCOSxG0emEFgqsj0vVzm9+ucJcESBzkozRZBLbD942sBVcdf5vdvhPuvnQw+0cUkd7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920053; c=relaxed/simple;
	bh=BHmPj2GKglel+dM6EkvB195s41aF0+QsrleQeUPbE40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tY7p0trfvTAagLg4culX75JYDx38i274Y9VzyDvFPAo/5oLEERZu+kKo4yaSbnSfQc3MXUxYZvN3PinzOptItKbIKhoOfWmmvG1HyuRCwKlo7kSMl+gt3hY1qfC0yxMBKk6ivlQ6vqSFY59nTrg4uOq1weAb85AOsM3H53vDh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJWxoI3G; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so2549614a12.0;
        Mon, 18 Nov 2024 00:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731920049; x=1732524849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ImUwhj3KLskmnmevpPwGVzAUnC3K8Cw7DOCj378hYQ4=;
        b=JJWxoI3G/O7dceYiB+YBt1xRXX6+ngFfNHve1tO18EJfPII52NIxKlndlUmk5Tq3PH
         mYZ+3QrZArbR7H866c4tjjgoRx4uoqSY6hYtXvUclwqD3AlUsT/BUI8Tu6Y1S9MpMIlG
         wn4wWnmCyPc2zsNGA0rMxh5r4vKJOOFXaGdKOKViI5yY9bWQo4jAQIpluuer+43CKnfm
         u9saqaCo1WISF/vOMkMoeLHcxHuWF2cKxOG9ijNpa2vkDbNYBEhmMP5f1crOekRlxAG2
         mi0jvR/+q+84f9dGsMNiihazTox9IV0+RaS4a9IxYgGOkkH11WfL3dikWuUT+OApGo3a
         JuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731920049; x=1732524849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImUwhj3KLskmnmevpPwGVzAUnC3K8Cw7DOCj378hYQ4=;
        b=KE0CTHm5CvdKsVnS/IvbqhRGf4qtlgky3Ezr9ZPpA8FkZkW3uwDyW9aPZV7RJsr3yz
         o7q/QinBcTNmLT8rzquvUjcwqW4PN2O4BT2meR+lwpqZN4DR2tQ0/dMuv5S7Vazp4glQ
         m3o4o/CRTMkNvDd426MH5bOhOECAN5TDB0/ctXv25TkNoZe9tU9EDOG8tYxJETHISwfm
         cR7f4Prcr287awWBqk/0d0Rl/3o7ulM8C0DqKLzqZQb/U4KMnI2t65SjpPK5jDuDcGuQ
         0Rjr93Aioo8btMxA799kRLFwzw+aUCHdnUKCWgKMSCtoBXIs/kA3y1JMha7Mio8RV6Uj
         4mqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbvaEUdH1xNgeCA3tPiEchR584IcrPOrLWF48t3GrkFM8SlGW7u4IvcdslawSB0czfFy46FtAwnkh82G2X@vger.kernel.org, AJvYcCWeUn2ma1mVH+Ym9WbXV6tY/ie5HSGi7U1Wo4AkD3RdM1ez7yD7SwWhi30xtjL32tUrcTeC3xku2b/Y+osh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl11hLPNqD+Hkb5SannnwwVkGiSCz0FkoiLC8xLyPvmkVJKu9f
	8iDYbR4Vd1CaiCyoF5MbO7kyq5ZR73xm7Y9CUUc7QGgnTcZcbFs6
X-Google-Smtp-Source: AGHT+IFMZsuRW8lyHa4uZxiVXF1UJ6529fUgXwhx7zMAEfmXDbMidud1UIVIS50bZZhM6fd+8aIv2w==
X-Received: by 2002:a05:6402:5189:b0:5cf:cf81:c39f with SMTP id 4fb4d7f45d1cf-5cfcf81c701mr1111937a12.19.1731920047654;
        Mon, 18 Nov 2024 00:54:07 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9e168sm4524329a12.21.2024.11.18.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:54:06 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] vfs: dodge strlen() in vfs_readlink() when ->i_link is populated
Date: Mon, 18 Nov 2024 09:53:57 +0100
Message-ID: <20241118085357.494178-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This gives me about 1.5% speed up when issuing readlink on /initrd.img
on ext4.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I had this running with the following debug:

if (strlen(link) != inode->i_size)
       printk(KERN_CRIT "mismatch [%s] %l %l\n", link,
           strlen(link), inode->i_size);

nothing popped up

I would leave something of that sort in if it was not defeating the
point of the change.

However, I'm a little worried some crap fs *does not* fill this in
despite populating i_link.

Perhaps it would make sense to keep the above with the patch hanging out
in next and remove later?

Anyhow, worst case, should it turn out i_size does not work there are at
least two 4-byte holes which can be used to store the length (and
chances are some existing field can be converted into a union instead).

Bench:
$ cat tests/readlink1.c
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>
#include <string.h>

char *testcase_description = "readlink /initrd.img";

void testcase(unsigned long long *iterations, unsigned long nr)
{
        char *tmplink = "/initrd.img";
        char buf[1024];

        while (1) {
                int error = readlink(tmplink, buf, sizeof(buf));
                assert(error > 0);

                (*iterations)++;
        }
}

 fs/namei.c                     | 43 ++++++++++++++++++----------------
 fs/proc/namespaces.c           |  2 +-
 include/linux/fs.h             |  2 +-
 security/apparmor/apparmorfs.c |  2 +-
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9d30c7aa9aa6..7aced8aca0f6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5272,19 +5272,16 @@ SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newna
 				getname(newname), 0);
 }
 
-int readlink_copy(char __user *buffer, int buflen, const char *link)
+int readlink_copy(char __user *buffer, int buflen, const char *link, int linklen)
 {
-	int len = PTR_ERR(link);
-	if (IS_ERR(link))
-		goto out;
+	int copylen;
 
-	len = strlen(link);
-	if (len > (unsigned) buflen)
-		len = buflen;
-	if (copy_to_user(buffer, link, len))
-		len = -EFAULT;
-out:
-	return len;
+	copylen = linklen;
+	if (unlikely(copylen > (unsigned) buflen))
+		copylen = buflen;
+	if (copy_to_user(buffer, link, copylen))
+		copylen = -EFAULT;
+	return copylen;
 }
 
 /**
@@ -5317,13 +5314,15 @@ int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 	}
 
 	link = READ_ONCE(inode->i_link);
-	if (!link) {
-		link = inode->i_op->get_link(dentry, inode, &done);
-		if (IS_ERR(link))
-			return PTR_ERR(link);
+	if (link)
+		return readlink_copy(buffer, buflen, link, inode->i_size);
+
+	link = inode->i_op->get_link(dentry, inode, &done);
+	res = PTR_ERR(link);
+	if (!IS_ERR(link)) {
+		res = readlink_copy(buffer, buflen, link, strlen(link));
+		do_delayed_call(&done);
 	}
-	res = readlink_copy(buffer, buflen, link);
-	do_delayed_call(&done);
 	return res;
 }
 EXPORT_SYMBOL(vfs_readlink);
@@ -5391,10 +5390,14 @@ EXPORT_SYMBOL(page_put_link);
 
 int page_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
+	const char *link;
+	int res;
+
 	DEFINE_DELAYED_CALL(done);
-	int res = readlink_copy(buffer, buflen,
-				page_get_link(dentry, d_inode(dentry),
-					      &done));
+	link = page_get_link(dentry, d_inode(dentry), &done);
+	res = PTR_ERR(link);
+	if (!IS_ERR(link))
+		res = readlink_copy(buffer, buflen, link, strlen(link));
 	do_delayed_call(&done);
 	return res;
 }
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a..c610224faf10 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -83,7 +83,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)
-			res = readlink_copy(buffer, buflen, name);
+			res = readlink_copy(buffer, buflen, name, strlen(name));
 	}
 	put_task_struct(task);
 	return res;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 972147da71f9..7d456db6a381 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3351,7 +3351,7 @@ extern const struct file_operations generic_ro_fops;
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
 
-extern int readlink_copy(char __user *, int, const char *);
+extern int readlink_copy(char __user *, int, const char *, int);
 extern int page_readlink(struct dentry *, char __user *, int);
 extern const char *page_get_link(struct dentry *, struct inode *,
 				 struct delayed_call *);
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 01b923d97a44..60959cfba672 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2611,7 +2611,7 @@ static int policy_readlink(struct dentry *dentry, char __user *buffer,
 	res = snprintf(name, sizeof(name), "%s:[%lu]", AAFS_NAME,
 		       d_inode(dentry)->i_ino);
 	if (res > 0 && res < sizeof(name))
-		res = readlink_copy(buffer, buflen, name);
+		res = readlink_copy(buffer, buflen, name, strlen(name));
 	else
 		res = -ENOENT;
 
-- 
2.43.0


