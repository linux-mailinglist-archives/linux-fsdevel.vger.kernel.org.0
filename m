Return-Path: <linux-fsdevel+bounces-10261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD38498FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06741F237F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EDE19472;
	Mon,  5 Feb 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea5No9/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DE18E00;
	Mon,  5 Feb 2024 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132980; cv=none; b=cMOup714zGX1IJaloq3IfS/vL3L6351XKFKbbtz9J9QfqGjbzQq0fukJEvS5E8s4+sdhUs2Gq8xj9/CHerdVe28QM408QvWpaaAi7ojaxbOzW1Z2bbZ4Yb9Jn8xXqRoPYBtuoK8pKeXy3eGE/Nd3ZGrcXofgNI3MeHAxI1y9nHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132980; c=relaxed/simple;
	bh=XXMTy7omW95QL4wYydLM30UA75bH/787fQ5A85xLdT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhrKDpFUkiXYAYVsE4XM5HIxXDxBNFSu1EaOjLZVcdNnpVvDGSuW3956uJkyLndAW91OEzRG3QpLElJVd1tqglrJ8pn2nhPG9BlnE9PMC7dTN/zTAM5CBLcbssyTBIRRgzZS1elTUVKsSaggeYA0IN2k+FVNMKBPyp540haKkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea5No9/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8BEC433C7;
	Mon,  5 Feb 2024 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707132979;
	bh=XXMTy7omW95QL4wYydLM30UA75bH/787fQ5A85xLdT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ea5No9/B9/3ZwCOcBfLkGLDE/MvFK7jfTUn58PgVM0YUBlaEetZHBUxE4H4EzZn42
	 VWdhM23gfRNhm+XkbKtNEj3C0OmneHbqvfBlFcfZLvnjj3kZ4di005cvbN+JyjMJdQ
	 BruEA7v+rRVY+KS6rCy/IwVi0gCGBix8KOWYvJHTF29ICn+h5BgF4YiPjGhV27Ivp0
	 jO6Cl/P5PsiUPrSoyHjFnTn7f3CBaebYqvaP/rB+cBxBXBaKeixBPxLeuM1DmUhs89
	 fZgMOGkmBEvIyeouCRrK7VIoPHz5+OYJ84CAAZZqjo1XPLWVZIGfTK1XnMbrLvuspx
	 LDK7mVCz6FqrA==
Date: Mon, 5 Feb 2024 12:36:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v3 04/47] filelock: add some new helper functions
Message-ID: <20240205-wegschauen-unappetitlich-2b0926023605@brauner>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
 <20240131-flsplit-v3-4-c6129007ee8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131-flsplit-v3-4-c6129007ee8d@kernel.org>

> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 085ff6ba0653..a814664b1053 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -147,6 +147,29 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
>  int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
>  int fcntl_getlease(struct file *filp);
>  
> +static inline bool lock_is_unlock(struct file_lock *fl)
> +{
> +	return fl->fl_type == F_UNLCK;
> +}
> +
> +static inline bool lock_is_read(struct file_lock *fl)
> +{
> +	return fl->fl_type == F_RDLCK;
> +}
> +
> +static inline bool lock_is_write(struct file_lock *fl)
> +{
> +	return fl->fl_type == F_WRLCK;
> +}
> +
> +static inline void locks_wake_up(struct file_lock *fl)
> +{
> +	wake_up(&fl->fl_wait);
> +}
> +
> +/* for walking lists of file_locks linked by fl_list */
> +#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head, fl_list)
> +

This causes a build warning for fs/ceph/ and fs/afs when
!CONFIG_FILE_LOCKING. I'm about to fold the following diff into this
patch. The diff looks a bit wonky but essentially I've moved
lock_is_unlock(), lock_is_{read,write}(), locks_wake_up() and
for_each_file_lock() out of the ifdef CONFIG_FILE_LOCKING:

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index a814664b1053..62be9c6b1e59 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -133,20 +133,6 @@ struct file_lock_context {
        struct list_head        flc_lease;
 };

-#ifdef CONFIG_FILE_LOCKING
-int fcntl_getlk(struct file *, unsigned int, struct flock *);
-int fcntl_setlk(unsigned int, struct file *, unsigned int,
-                       struct flock *);
-
-#if BITS_PER_LONG == 32
-int fcntl_getlk64(struct file *, unsigned int, struct flock64 *);
-int fcntl_setlk64(unsigned int, struct file *, unsigned int,
-                       struct flock64 *);
-#endif
-
-int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
-int fcntl_getlease(struct file *filp);
-
 static inline bool lock_is_unlock(struct file_lock *fl)
 {
        return fl->fl_type == F_UNLCK;
@@ -170,6 +156,20 @@ static inline void locks_wake_up(struct file_lock *fl)
 /* for walking lists of file_locks linked by fl_list */
 #define for_each_file_lock(_fl, _head) list_for_each_entry(_fl, _head, fl_list)

+#ifdef CONFIG_FILE_LOCKING
+int fcntl_getlk(struct file *, unsigned int, struct flock *);
+int fcntl_setlk(unsigned int, struct file *, unsigned int,
+                       struct flock *);
+
+#if BITS_PER_LONG == 32
+int fcntl_getlk64(struct file *, unsigned int, struct flock64 *);
+int fcntl_setlk64(unsigned int, struct file *, unsigned int,
+                       struct flock64 *);
+#endif
+
+int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
+int fcntl_getlease(struct file *filp);
+
 /* fs/locks.c */
 void locks_free_lock_context(struct inode *inode);
 void locks_free_lock(struct file_lock *fl);


