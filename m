Return-Path: <linux-fsdevel+bounces-4551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA5800859
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92D1281439
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481920B21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKbEz3nq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD97E2D5F;
	Fri,  1 Dec 2023 01:30:05 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so278274466b.3;
        Fri, 01 Dec 2023 01:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701423003; x=1702027803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8xnc2cYH1N/JbEUok7VoTehJ7xqwxQ03AUqlJhtUkY=;
        b=kKbEz3nqfrHBIfjNqAnUy98vvlSzCVpJUUReOOawN6g4f2c5V7qgkZxd4bbunP1H/y
         HNpf0LkdpVHKNW0cMbnQWqYKIpzHpd/BQwOGZhgjFEFaXBEflgusBKAC8MAntTYcolCU
         nsOYgkh01MyH41aqRvXl+FEGsKdFayozMyjbjv4uPcGLypH+CBRP+qdBl2oK/rnEmyJu
         7unqB0rwUx8J9oQGaqLGC9FllPy47ixtel0JOFH+RyyoET9hCRzEio2LPK/Nr4yzo1t3
         nTNropPkHLM5mkoAYcvYAXIq18zbSnj/xv2K4lfmXx7Dtikk2efTFphCJnlGu6p/bBkI
         SD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423003; x=1702027803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8xnc2cYH1N/JbEUok7VoTehJ7xqwxQ03AUqlJhtUkY=;
        b=LcyZeVbeax5oa/sG9xQGCNMan6OcC9Rh1e/36u0iP1bWd0l0c65i9J6AwAzw/0qhOd
         +q44A3tyfDVPYaeIWtzXmwbOG2NKhR5nx6kG7akrfkDrGS9WLPNfVkkV9u8w9i9Q1B9c
         tRI7cB87NB2tAvjsBdXoZ6vAyMKy1b+VADY2m2KyTc4lqkBjhFDbYn2tj65dVvBVg6zl
         HE/Z7yfHDMGQ7UPe+yQdivd8lvAJmMK7OB84CI2d6KwcxRQN7S+cjHrxy/e3aTTSbknn
         hQMPaTHV3GCxynGXAbdVWkI25aNYlK7OJKaH1fmH8aK2Cs+5z+RKhXetI6I88earsV/8
         n3pA==
X-Gm-Message-State: AOJu0YwdCucc0b7JCmmDiPJYcG5NK5l0AgX+24DfeJVdWhK8IFTQtm7C
	GN/2/cCbvAUZCKvgTbrAMQ==
X-Google-Smtp-Source: AGHT+IHnyvw0kIxQW2ATN4u42QCXl1IjGzB4Pt+AK928Vspqpnw+0+DThCOR/32sTM3lOrfx+ZuKzw==
X-Received: by 2002:a17:906:6b82:b0:a04:4b57:8f27 with SMTP id l2-20020a1709066b8200b00a044b578f27mr469296ejr.60.1701423002927;
        Fri, 01 Dec 2023 01:30:02 -0800 (PST)
Received: from p183 ([46.53.250.155])
        by smtp.gmail.com with ESMTPSA id g18-20020a1709067c5200b009fada3e836asm1667459ejp.53.2023.12.01.01.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:30:02 -0800 (PST)
Date: Fri, 1 Dec 2023 12:30:00 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Munehisa Kamata <kamatam@amazon.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security
 attribute
Message-ID: <5f8b18b0-0744-4cf5-9ec5-b0bb0451dd18@p183>
References: <20231129171122.0171313079ea3afa84762d90@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129171122.0171313079ea3afa84762d90@linux-foundation.org>

On Wed, Nov 29, 2023 at 05:11:22PM -0800, Andrew Morton wrote:
> 
> fyi...
> 
> (yuk!)
> 
> 
> 
> Begin forwarded message:
> 
> Date: Thu, 30 Nov 2023 00:37:04 +0000
> From: Munehisa Kamata <kamatam@amazon.com>
> To: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>, "Munehisa Kamata" <kamatam@amazon.com>
> Subject: [PATCH] proc: Update inode upon changing task security attribute
> 
> 
> I'm not clear whether VFS is a better (or worse) place[1] to fix the
> problem described below and would like to hear opinion.
> 
> If the /proc/[pid] directory is bind-mounted on a system with Smack
> enabled, and if the task updates its current security attribute, the task
> may lose access to files in its own /proc/[pid] through the mountpoint.
> 
>  $ sudo capsh --drop=cap_mac_override --
>  # mkdir -p dir
>  # mount --bind /proc/$$ dir
>  # echo AAA > /proc/$$/task/current		# assuming built-in echo
>  # cat /proc/$$/task/current			# revalidate
>  AAA
>  # echo BBB > dir/attr/current
>  # cat dir/attr/current
>  cat: dir/attr/current: Permission denied
>  # ls dir/
>  ls: cannot access dir/: Permission denied
>  # cat /proc/$$/attr/current			# revalidate
>  BBB
>  # cat dir/attr/current
>  BBB
>  # echo CCC > /proc/$$/attr/current
>  # cat dir/attr/current
>  cat: dir/attr/current: Permission denied
> 
> This happens because path lookup doesn't revalidate the dentry of the
> /proc/[pid] when traversing the filesystem boundary, so the inode security
> blob of the /proc/[pid] doesn't get updated with the new task security
> attribute. Then, this may lead security modules to deny an access to the
> directory. Looking at the code[2] and the /proc/pid/attr/current entry in
> proc man page, seems like the same could happen with SELinux. Though, I
> didn't find relevant reports.
> 
> The steps above are quite artificial. I actually encountered such an
> unexpected denial of access with an in-house application sandbox
> framework; each app has its own dedicated filesystem tree where the
> process's /proc/[pid] is bind-mounted to and the app enters into via
> chroot.
> 
> With this patch, writing to /proc/[pid]/attr/current (and its per-security
> module variant) updates the inode security blob of /proc/[pid] or
> /proc/[pid]/task/[tid] (when pid != tid) with the new attribute.
> 
> [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> ---
>  fs/proc/base.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index dd31e3b6bf77..bdb7bea53475 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  {
>  	struct inode * inode = file_inode(file);
>  	struct task_struct *task;
> +	const char *name = file->f_path.dentry->d_name.name;
>  	void *page;
>  	int rv;
>  
> @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  	if (rv < 0)
>  		goto out_free;
>  
> -	rv = security_setprocattr(PROC_I(inode)->op.lsm,
> -				  file->f_path.dentry->d_name.name, page,
> -				  count);
> +	rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
>  	mutex_unlock(&current->signal->cred_guard_mutex);
> +
> +	/*
> +	 *  Update the inode security blob in advance if the task's security
> +	 *  attribute was updated
> +	 */
> +	if (rv > 0 && !strcmp(name, "current")) {
> +		struct pid *pid;
> +		struct proc_inode *cur, *ei;
> +
> +		rcu_read_lock();
> +		pid = get_task_pid(current, PIDTYPE_PID);
> +		hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
> +			ei = cur;

Should this "break;"? Why is only the last inode in the list updated?
Should it be the first? All of them?

> +		put_pid(pid);
> +		pid_update_inode(current, &ei->vfs_inode);
> +		rcu_read_unlock();
> +	}

