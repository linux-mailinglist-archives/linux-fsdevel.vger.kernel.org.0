Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5912D8A10
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 21:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407915AbgLLU4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 15:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407890AbgLLU4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 15:56:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A606BC0613CF;
        Sat, 12 Dec 2020 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WvFf+jA75Sbv8N99WjSMJITzF6r6kvLC4AxYbTkoaMU=; b=pzSQ419n0/LzeB7FPfxuvjdg1b
        S+KMbAXTdTnw6SDA8CSdpfxIgeWbEoFXmLZIY5Q4KhhjNwHFcpz8n6hjPG4GTmAH5wdkzfngtMaVq
        doC3EYKNRYIzoBcoWdq/g71S7JEjPAFCgyPMWBJJYOGJRzMAXbnSlbLMq1kEkCMOeo0ssnaZHSWZg
        8jruB4/ILM61wOfh2AXUsUZVQbAVUZmhJcF7AhI2AfKp030/D3yPmxW4z6Ac+HEGGXB3j8bTfq8UX
        Cdx/JUpCZTWPTMRDRidUP3OzTz4MgZ0+cH2yW0r43+wa/77saKX3wXQJCiugCWjC7jwRRkC3srPWz
        MARMV+pg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koBvG-0005AR-R6; Sat, 12 Dec 2020 20:55:22 +0000
Date:   Sat, 12 Dec 2020 20:55:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20201212205522.GF2443@casper.infradead.org>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
> -void pid_update_inode(struct task_struct *task, struct inode *inode)
> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
> +			       unsigned int flags)

I'm really nitpicking here, but this function only _updates_ the inode
if flags says it should.  So I was thinking something like this
(compile tested only).

I'd really appreocate feedback from someone like Casey or Stephen on
what they need for their security modules.

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b362523a9829..771f330bfce7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1968,6 +1968,25 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
 	security_task_to_inode(task, inode);
 }
 
+/* See if we can avoid the above call.  Assumes RCU lock held */
+static bool inode_needs_pid_update(struct task_struct *task,
+		const struct inode *inode)
+{
+	kuid_t uid;
+	kgid_t gid;
+
+	if (inode->i_mode & (S_ISUID | S_ISGID))
+		return true;
+	task_dump_owner(task, inode->i_mode, &uid, &gid);
+	if (!uid_eq(uid, inode->i_uid) || !gid_eq(gid, inode->i_gid))
+		return true;
+	/*
+	 * XXX: Do we need to call the security system here to see if
+	 * there's a pending update?
+	 */
+	return false;
+}
+
 /*
  * Rewrite the inode's ownerships here because the owning task may have
  * performed a setuid(), etc.
@@ -1978,8 +1997,15 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 	struct inode *inode;
 	struct task_struct *task;
 
-	if (flags & LOOKUP_RCU)
+	if (flags & LOOKUP_RCU) {
+		inode = d_inode_rcu(dentry);
+		task = pid_task(proc_pid(inode), PIDTYPE_PID);
+		if (!task)
+			return 0;
+		if (!inode_needs_pid_update(task, inode))
+			return 1;
 		return -ECHILD;
+	}
 
 	inode = d_inode(dentry);
 	task = get_proc_task(inode);
