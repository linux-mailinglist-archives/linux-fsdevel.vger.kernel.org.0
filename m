Return-Path: <linux-fsdevel+bounces-3196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BD7F1286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 12:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB131F23C8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACDE18C10;
	Mon, 20 Nov 2023 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pLANkITR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D032CAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 03:55:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so6166254a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 03:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1700481325; x=1701086125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3vsvlrcGrEGBTtA0AP5aKKnvlKyJhXO+Stjh5B7q6E=;
        b=pLANkITRLfmcC2J2YJuCVAa1pwMrD93Mc4zVHF9sidJYmleg6uvCC0cn11PBpLeTzU
         wnWGW66IJSF5DTsBOm+IoH6vcKqPv4EewI0zatcHhSaHN1imDCyf5VuhD6x/ycD7DpNM
         S2OFwCooxjQic/D8w4m//o32R0QqvTEw4jh90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700481325; x=1701086125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3vsvlrcGrEGBTtA0AP5aKKnvlKyJhXO+Stjh5B7q6E=;
        b=s8gFOEmaPvbqAK+FjaFKB0cgY5YX6AIIPP2Wt3xW7UyvuLJjwa3PWG/KcVU1PvqfaP
         kAie1uK/gOCwSKrCpugDYwkYHcQOtmOI7n5Y6K7TF5gHhSd8p2ZihXrQXpI89owBjP4h
         tfs3tcLq6x+cB0xhEos6oDPf7cJmhtdSncNTAPaLZ5iPAsA0iFJXyOF0Ecxafmd9s17j
         fuj88AKZHRGx9PC2OTw43lrL3sLTnP+TbADgpSs95Yc60wQ3OneW4MBLKe8igmYyKezl
         Ts/iedYkmqKT6X1J6i1d0Y1vfAj3heesHOziXd4pwcQ5MMNSk+3WEKCM3qVcP6cU2syy
         /0eQ==
X-Gm-Message-State: AOJu0YzrpsoRPjEEe6ioPyL6R3zZofgiksXM+/IdQ/pMEit1NMI204Cz
	Bm7l6yEfk2YCohjUWy0/Ku/TFw==
X-Google-Smtp-Source: AGHT+IHRK6NFPlWpLc2M9qeLs7fvIv/FO+aj2+Cw07fK4WT3xRJbJ7ajVhN90FoD6icsE0y5IMV/Fw==
X-Received: by 2002:a17:906:4a50:b0:9c2:a072:78bf with SMTP id a16-20020a1709064a5000b009c2a07278bfmr5239895ejv.26.1700481325269;
        Mon, 20 Nov 2023 03:55:25 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-181-165.pool.digikabel.hu. [91.82.181.165])
        by smtp.gmail.com with ESMTPSA id dk26-20020a170906f0da00b009fc0c42098csm1963955ejb.173.2023.11.20.03.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:55:24 -0800 (PST)
Date: Mon, 20 Nov 2023 12:55:17 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
Message-ID: <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
 <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
 <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>

On Fri, Nov 17, 2023 at 04:50:25PM +0100, Miklos Szeredi wrote:
> I wonder... Is there a reason this shouldn't be done statelessly by
> adding an "continue after this ID" argument to listmount(2)?  The
> caller will just need to pass the last mount ID received in the array
> to the next listmount(2) call and iterate until a short count is
> returned.

No comments so far... maybe more explanation is needed.

New signature of listmount() would be:

ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
		  uint64_t *buf, size_t bufsize, unsigned int flags);

And the usage would be:

	for (last = 0; nres == bufsize; last = buf[bufsize-1]) {
		nres = listmount(parent, last, buf, bufsize, flags);
		for (i = 0; i < nres; i++) {
			/* process buf[i] */
		}
	}


Here's a kernel patch against the version in Christian's tree.  The syscall
signature doesn't need changing, since we have a spare u64 in the mnt_id_req for
listmount.

The major difference is in the order that the mount ID's are listed, which is
now strictly increasing.  Doing the recursive listing in DFS order is nicer, but
I don't think it's important enough.

Comments?

Thanks,
Miklos

---
 fs/namespace.c             |   41 +++++++++++++++++++++++++----------------
 include/uapi/linux/mount.h |    5 ++++-
 2 files changed, 29 insertions(+), 17 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1009,7 +1009,7 @@ void mnt_change_mountpoint(struct mount
 
 static inline struct mount *node_to_mount(struct rb_node *node)
 {
-	return rb_entry(node, struct mount, mnt_node);
+	return node ? rb_entry(node, struct mount, mnt_node) : NULL;
 }
 
 static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
@@ -4960,21 +4960,22 @@ SYSCALL_DEFINE4(statmount, const struct
 	return ret;
 }
 
-static struct mount *listmnt_first(struct mount *root)
+static struct mount *listmnt_next(struct mount *curr)
 {
-	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
+	return node_to_mount(rb_next(&curr->mnt_node));
 }
 
-static struct mount *listmnt_next(struct mount *curr, struct mount *root, bool recurse)
+static bool is_submount(struct mount *sub, struct mount *mnt)
 {
-	if (recurse)
-		return next_mnt(curr, root);
-	if (!list_is_head(curr->mnt_child.next, &root->mnt_mounts))
-		return list_next_entry(curr, mnt_child);
-	return NULL;
+	for (; sub != mnt; sub = sub->mnt_parent) {
+		if (sub->mnt_parent == sub)
+			return false;
+	}
+	return true;
 }
 
-static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
+static long do_listmount(struct vfsmount *mnt, struct mount *last,
+			 u64 __user *buf, size_t bufsize,
 			 const struct path *root, unsigned int flags)
 {
 	struct mount *r, *m = real_mount(mnt);
@@ -5000,13 +5001,16 @@ static long do_listmount(struct vfsmount
 	if (err)
 		return err;
 
-	for (r = listmnt_first(m); r; r = listmnt_next(r, m, recurse)) {
+	for (r = last; (r = listmnt_next(r)) != NULL && ctr < bufsize;) {
+		if (recurse && !is_submount(r, m))
+			continue;
+		if (!recurse && r->mnt_parent != m)
+			continue;
+
 		if (reachable_only &&
 		    !is_path_reachable(r, r->mnt.mnt_root, root))
 			continue;
 
-		if (ctr >= bufsize)
-			return -EOVERFLOW;
 		if (put_user(r->mnt_id_unique, buf + ctr))
 			return -EFAULT;
 		ctr++;
@@ -5021,6 +5025,7 @@ SYSCALL_DEFINE4(listmount, const struct
 {
 	struct mnt_id_req kreq;
 	struct vfsmount *mnt;
+	struct mount *last;
 	struct path root;
 	u64 mnt_id;
 	long err;
@@ -5030,8 +5035,6 @@ SYSCALL_DEFINE4(listmount, const struct
 
 	if (copy_from_user(&kreq, req, sizeof(kreq)))
 		return -EFAULT;
-	if (kreq.request_mask != 0)
-		return -EINVAL;
 	mnt_id = kreq.mnt_id;
 
 	down_read(&namespace_sem);
@@ -5040,13 +5043,19 @@ SYSCALL_DEFINE4(listmount, const struct
 	else
 		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
 
+	if (!kreq.last_mnt_id) {
+		last = real_mount(mnt);
+	} else {
+		last = mnt_find_id_at(current->nsproxy->mnt_ns, kreq.last_mnt_id);
+	}
+
 	err = -ENOENT;
 	if (mnt) {
 		get_fs_root(current->fs, &root);
 		/* Skip unreachable for LSMT_ROOT */
 		if (mnt_id == LSMT_ROOT && !(flags & LISTMOUNT_UNREACHABLE))
 			mnt = root.mnt;
-		err = do_listmount(mnt, buf, bufsize, &root, flags);
+		err = do_listmount(mnt, last, buf, bufsize, &root, flags);
 		path_put(&root);
 	}
 	up_read(&namespace_sem);
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -178,7 +178,10 @@ struct statmount {
 
 struct mnt_id_req {
 	__u64 mnt_id;
-	__u64 request_mask;
+	union {
+		__u64 request_mask;
+		__u64 last_mnt_id;
+	};
 };
 
 /*

