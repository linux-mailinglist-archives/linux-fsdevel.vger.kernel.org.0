Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DA4401C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390992AbfFMQDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:03:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42074 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731393AbfFMIrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:47:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so4515741wrl.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v6PLdyQOzI0tG2cZQ2qQYi4K1VGuuUo6oAxFYdZjwNY=;
        b=WkxZ0ZaYt/UxgaO0AGRtXeVfV8vQftxoFqoFblsq3fXVJa5lyDJ3lsrYxFr7sULIua
         YpIWXsQ5rwhxeRkpgCujNzHng+MyOoF9WlBdSS5plsIn1a5nsD07hT3DUFt42YMe4Hz6
         nq+bHgOZbAlNCEv4qryu1jup+dv7NFBzv8UG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v6PLdyQOzI0tG2cZQ2qQYi4K1VGuuUo6oAxFYdZjwNY=;
        b=LQ89FYYv9Syw67/CIG35kFb1g9Up8uWJGqfj+iQl3fksxUQgaLOiRyKbHS4E0gT4U0
         /X95k0nNTI3TyfU4VAzYGpbYhVFhUZQPKfShLOG9aNfKGPDyMFnIoV+C/8mmyOZp0Y4D
         7Xi1QFhmmUi9Ww8SjEvRY/jSdsBsAReBGLJ2FizGKD4W1ODNsQRMDBJOGot6yEAWl06W
         3zyW+VFnt+BvsKxTFikZ9SjszVD3IvI7vH7tp/69b1vaRVcQKbbZlutPj3cB+Gt0m87e
         NDxL89PCdp0gmk3QZzzg13Hta3tpMDWpOkAWfQ+q5pSD3/kdVzhFc1AyD8eDBEjKoPcE
         AKSg==
X-Gm-Message-State: APjAAAX8zFJHUNeNIBcoVyQQayMqjZfklpym+YAXND0xT8SuHNtmGZgz
        qV3dBTloMieFsIjej1wx7Pr0HA==
X-Google-Smtp-Source: APXvYqxKS8gUln6fvs1SbyW8pE5NsMpr3bzbKlLKlBr0EAEthBfXY+0ShPDuQUi4SaVl+Mr1RTCvhw==
X-Received: by 2002:adf:f683:: with SMTP id v3mr1049914wrp.258.1560415657694;
        Thu, 13 Jun 2019 01:47:37 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id w67sm4993557wma.24.2019.06.13.01.47.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 01:47:36 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:47:28 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fsmount: add missing mntget()
Message-ID: <20190613084728.GA32129@miu.piliscsaba.redhat.com>
References: <20190610183031.GE63833@gmail.com>
 <20190612184313.143456-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612184313.143456-1-ebiggers@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:43:13AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> sys_fsmount() needs to take a reference to the new mount when adding it
> to the anonymous mount namespace.  Otherwise the filesystem can be
> unmounted while it's still in use, as found by syzkaller.

So it needs one count for the file (which dentry_open() obtains) and one for the
attachment into the anonymous namespace.  The latter one is dropped at cleanup
time, so your patch appears to be correct at getting that ref.

I wonder why such a blatant use-after-free was missed in normal testing.  RCU
delayed freeing, I guess?

How about this additional sanity checking patch?

Thanks,
Miklos


diff --git a/fs/namespace.c b/fs/namespace.c
index b26778bdc236..c638f220805a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -153,10 +153,10 @@ static inline void mnt_add_count(struct mount *mnt, int n)
 /*
  * vfsmount lock must be held for write
  */
-unsigned int mnt_get_count(struct mount *mnt)
+int mnt_get_count(struct mount *mnt)
 {
 #ifdef CONFIG_SMP
-	unsigned int count = 0;
+	int count = 0;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
@@ -1140,6 +1140,8 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
 static void mntput_no_expire(struct mount *mnt)
 {
+	int count;
+
 	rcu_read_lock();
 	if (likely(READ_ONCE(mnt->mnt_ns))) {
 		/*
@@ -1162,11 +1164,13 @@ static void mntput_no_expire(struct mount *mnt)
 	 */
 	smp_mb();
 	mnt_add_count(mnt, -1);
-	if (mnt_get_count(mnt)) {
+	count = mnt_get_count(mnt);
+	if (count > 0) {
 		rcu_read_unlock();
 		unlock_mount_hash();
 		return;
 	}
+	WARN_ON(count < 0);
 	if (unlikely(mnt->mnt.mnt_flags & MNT_DOOMED)) {
 		rcu_read_unlock();
 		unlock_mount_hash();
diff --git a/fs/pnode.h b/fs/pnode.h
index 49a058c73e4c..26f74e092bd9 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -44,7 +44,7 @@ int propagate_mount_busy(struct mount *, int);
 void propagate_mount_unlock(struct mount *);
 void mnt_release_group_id(struct mount *);
 int get_dominating_id(struct mount *mnt, const struct path *root);
-unsigned int mnt_get_count(struct mount *mnt);
+int mnt_get_count(struct mount *mnt);
 void mnt_set_mountpoint(struct mount *, struct mountpoint *,
 			struct mount *);
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,
