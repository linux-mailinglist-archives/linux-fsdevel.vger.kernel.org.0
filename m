Return-Path: <linux-fsdevel+bounces-8784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F083AF6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236C01F249D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6937E796;
	Wed, 24 Jan 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VnfCx64F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE87E798
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116542; cv=none; b=DJLYbSuG+4HWSQxE/L+5O4Jk0N0meJjH3FkgfPU+N+fp3mNIXu+3pf5g9VPj3QAicti1g5RBVCRUwzV7tepXqJkSYi/S0Ds0/DjxDvWythU0cGnF0fFs7NOebBSLAURv8JStP/j7vpWVwaQevOP3jtIpF4uGyY3gTN/eipJ2u0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116542; c=relaxed/simple;
	bh=81mkfaPIV3l+5W5/Io29q5qBbGLhqIevhvpzE2K69N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldD3YosIEuvdNifxBG0BICbALLemre+r1dcwWp37lwPrSU8VgwTlzY4mcd5vdpjtSxV7H4ypZmYb4EjI18AP/1v2lp/xPF/dshUhD8V6z2F+KJwUrx6QRbDzF7O0zvC/N+8X+U5cZm916DEQemgmUxCQbcAkMeYI9F7HHab3/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VnfCx64F; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3627e9f1b40so16434875ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706116540; x=1706721340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AtjqtWQJSzRmjQ40qBkgrmDmBtAr9tkAVMLkDK2JZy0=;
        b=VnfCx64F72OBNkIfdUDDoV6Myo2Tdnhkw6ubhRLjupN8T8W/X8gQuAJNzqmUKeRJxj
         iNv8zR3hOgnwtmWu6Ln+UpXmSS3qzllCzZlr+nihoCel2GOEhd+l+8kawKYrvFljxgh0
         nx78CSWFegodh+BpvFR1sFHSAi0iD8rw66Ncg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116540; x=1706721340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtjqtWQJSzRmjQ40qBkgrmDmBtAr9tkAVMLkDK2JZy0=;
        b=GHgMaNsVH5yRwZnsbyXDiqWd+TXQWDR/PklsoXi/xitd4He/JAlj9zKKBPEYPWX8IW
         I1F0xF9J4dQQNFnOFmQbr1X41k4RhO45OWy1u2PEOIFmb8sntz2sT3YAeIDUXmvAEPFT
         Gy9mLfX3PgwUaSl2KhCPAPqhoVWbSqVRVfhxkCOpbap+2q5s/t6OFQXc/5y54rSqoeAQ
         jC7vCJ2mkPZ5uc2uoMJlFVmyUq2jZQTK2pUloCJK5NFVsq79ZOlO5Z+lS+0IuYmV9Bs3
         UQDv9pxrT+y/NQxgu1gnwY+2MPVnkJXmn2jeBKZ6j1AjTxxo1Q57zrrOOMoi12SUrjRy
         V+uQ==
X-Gm-Message-State: AOJu0YzaQppCGuhBXdgLHrvm1bjootktq5mgKKHl8aFlRU8pTAw/7HjW
	63PcqtqObctfWsHyn0ycX07r5ZfdnYY3bYN8L+qKcNBuj2T66khwSXG8B2GfSQ==
X-Google-Smtp-Source: AGHT+IEumDQJqaq75I9i1VHN14DXtK52FPlkPRPNODL5r/5aNFoRHKNDUtbUXZxMuQxI43sueBUEvA==
X-Received: by 2002:a92:c9c6:0:b0:361:a5a6:aa7b with SMTP id k6-20020a92c9c6000000b00361a5a6aa7bmr1577157ilq.38.1706116540247;
        Wed, 24 Jan 2024 09:15:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i15-20020a63cd0f000000b005ce6b79ab6asm12175650pgg.82.2024.01.24.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:15:39 -0800 (PST)
Date: Wed, 24 Jan 2024 09:15:38 -0800
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401240910.E0449F0F@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401240832.02940B1A@keescook>

On Wed, Jan 24, 2024 at 08:35:29AM -0800, Kees Cook wrote:
> On Wed, Jan 24, 2024 at 09:19:54AM -0700, Kevin Locke wrote:
> > Hello Linux developers,
> > 
> > Using AppArmor 3.0.12 and libvirt 10.0.0 (from Debian packages) with
> > Linux 6.8-rc1 (unpatched), I'm unable to start KVM domains due to
> > AppArmor errors. Everything works fine on Linux 6.7.  After attempting
> > to start a domain, syslog contains:
> > 
> > libvirtd[38705]: internal error: Child process (LIBVIRT_LOG_OUTPUTS=3:stderr /usr/lib/libvirt/virt-aa-helper -c -u libvirt-4fad83ef-4285-4cf5-953c-5c13d943c1fb) unexpected exit status 1: virt-aa-helper: error: apparmor_parser exited with error
> > libvirtd[38705]: internal error: cannot load AppArmor profile 'libvirt-4fad83ef-4285-4cf5-953c-5c13d943c1fb'
> > 
> > dmesg contains the additional message:
> > 
> > audit: type=1400 audit(1706112657.438:74): apparmor="DENIED" operation="open" class="file" profile="virt-aa-helper" name="/usr/sbin/apparmor_parser" pid=6333 comm="virt-aa-helper" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
> 
> Oh, yikes. This means the LSM lost the knowledge that this open is an
> _exec_, not a _read_.
> 
> I will starting looking at this. John might be able to point me in the
> right direction more quickly, though.

Here's a possible patch for in_execve. Can you test this? I'm going to
also examine switching to FMODE_EXEC ... I think I know why this wasn't
done in the past, but I have to check the history...


diff --git a/fs/exec.c b/fs/exec.c
index 39d773021fff..ddd0fa2e84a7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1505,7 +1505,7 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 /* Matches do_open_execat() */
 static void do_close_execat(struct file *file)
 {
-	if (!file)
+	if (IS_ERR_OR_NULL(file))
 		return;
 	allow_write_access(file);
 	fput(file);
@@ -1530,23 +1530,30 @@ static void free_bprm(struct linux_binprm *bprm)
 		kfree(bprm->interp);
 	kfree(bprm->fdpath);
 	kfree(bprm);
+	current->in_execve = 0;
 }
 
 static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
 {
-	struct linux_binprm *bprm;
-	struct file *file;
+	struct linux_binprm *bprm = NULL;
+	struct file *file = NULL;
 	int retval = -ENOMEM;
 
+	/*
+	 * Mark this "open" as an exec attempt for the LSMs. We reset
+	 * it in bprm_free() (and our common error path below).
+	 */
+	current->in_execve = 1;
+
 	file = do_open_execat(fd, filename, flags);
-	if (IS_ERR(file))
-		return ERR_CAST(file);
+	if (IS_ERR(file)) {
+		retval = PTR_ERR(file);
+		goto out_cleanup;
+	}
 
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
-	if (!bprm) {
-		do_close_execat(file);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!bprm)
+		goto out_cleanup;
 
 	bprm->file = file;
 
@@ -1559,7 +1566,7 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
 			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
 						  fd, filename->name);
 		if (!bprm->fdpath)
-			goto out_free;
+			goto out_cleanup;
 
 		/*
 		 * Record that a name derived from an O_CLOEXEC fd will be
@@ -1581,8 +1588,11 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
 	if (!retval)
 		return bprm;
 
-out_free:
-	free_bprm(bprm);
+out_cleanup:
+	if (bprm)
+		free_bprm(bprm);
+	do_close_execat(file);
+	current->in_execve = 0;
 	return ERR_PTR(retval);
 }
 
@@ -1633,6 +1643,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	}
 	rcu_read_unlock();
 
+	/* "users" and "in_exec" locked for copy_fs() */
 	if (p->fs->users > n_fs)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
 	else
@@ -1863,7 +1874,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 	 * where setuid-ness is evaluated.
 	 */
 	check_unsafe_exec(bprm);
-	current->in_execve = 1;
 	sched_mm_cid_before_execve(current);
 
 	sched_exec();
@@ -1880,7 +1890,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
 	current->fs->in_exec = 0;
-	current->in_execve = 0;
 	rseq_execve(current);
 	user_events_execve(current);
 	acct_update_integrals(current);
@@ -1899,7 +1908,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 	sched_mm_cid_after_execve(current);
 	current->fs->in_exec = 0;
-	current->in_execve = 0;
 
 	return retval;
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 47ff3b35352e..0d944e92a43f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1748,6 +1748,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
+		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;

-- 
Kees Cook

