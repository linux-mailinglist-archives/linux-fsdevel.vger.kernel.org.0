Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1010F7B5F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjJCDi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 23:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJCDiz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:38:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB53B7
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 20:38:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77574c076e4so39358085a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696304328; x=1696909128; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8/+wJV819lXGEfhGKndHNo+ce73WLnUIxruRbRerE0=;
        b=RmGN8wwdLVVJWyxWaCQ+xy+ad1w0desDkc6Z4EoenPOlfsOTTEpiZ7OAL8abo4tUqm
         eFspZUOOPobDZQ9syGkeGlnMl9ymJyi3AcDx8BP5awRh4YxIrTsxfyR32DXYPopyQBCA
         3m3lZfpyydAH5oBmPA33kIFuWmh3ooZ/kWbyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696304328; x=1696909128;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8/+wJV819lXGEfhGKndHNo+ce73WLnUIxruRbRerE0=;
        b=SIu18TUNPXQ5UQTrDH2h2ZReCkH3Ib1TwxbGKEXh98nsmkoow9wNnyBqIJQK/L4U8j
         dxqq6Bpuj/UNVhj09f56QQIdw6qqYg1GksdiI/1YDYTMCPG5eypDFVFPW405dM8UjSKw
         SGeRWE5kyks2PpE60nSoiIpNrxCXZTVkkyu2ki04xNBKEnbp968PAlFtmW7nEmMnF8+Y
         6M6jLuOO2TihKMgdp2yNbX3Qq0sHpvk73e1FxQdBwehBzH6BWz/l809ddHFV1BBw0oMo
         QZnCBtCWSDXddQM+Da0FmcHB8MvkoNT+CVQo8G69Ad8mF6KXKW5d3FCyNHf6gmeoP7Lc
         MPdQ==
X-Gm-Message-State: AOJu0YwKfy3BN7P62P2MqbVsbPxlBUkntpJvNR3pxpxB8BuwKO9E78bb
        PjmGpLpFZXKQMEfZqTv2rqwg
X-Google-Smtp-Source: AGHT+IHSSq18xUsm1JAWalnCPmFvDuaPoP8Tw3R4IbS3KFg90RB0n0U97nB0cA8jbqC/8YsT5YpY9g==
X-Received: by 2002:a05:620a:d93:b0:767:c572:ab10 with SMTP id q19-20020a05620a0d9300b00767c572ab10mr13955827qkl.35.1696304328065;
        Mon, 02 Oct 2023 20:38:48 -0700 (PDT)
Received: from smtpclient.apple ([2401:fa00:8f:201:8510:bc28:be1d:f3ba])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b00570668ccd5bsm260881pgf.14.2023.10.02.20.38.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2023 20:38:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v9 2/7] fuse: introduce atomic open
From:   Yuan Yao <yuanyaogoog@chromium.org>
In-Reply-To: <20230920173445.3943581-3-bschubert@ddn.com>
Date:   Tue, 3 Oct 2023 12:38:35 +0900
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Horst Birthelmer <hbirthelmer@ddn.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, takayas@chromium.org,
        keiichiw@chromium.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DBD1761-E13F-4033-8CFF-75CDC1EFCA21@chromium.org>
References: <20230920173445.3943581-1-bschubert@ddn.com>
 <20230920173445.3943581-3-bschubert@ddn.com>
To:     Bernd Schubert <bschubert@ddn.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for confusing, I=E2=80=99m resending the mail as the previous mail =
had a formatting issue(not plain text) and was not sent to =
linux-fsdevel.

Hi, I=E2=80=99m Yuan, particularly interested in this patch set, and =
I've noticed some ambiguity regarding the behavior of atomic_open for =
symbolic links.

I think this part may cause a problem if we atomic_open a symbolic =
link.The previous behavior for fuse_create_open() will only do lookup =
but not open the symbolic link. But, with the full atomic open kernel =
patch. My understanding is that when the kernel performs an atomic_open =
operation on a symbolic link, the dentry returned from the FUSE server =
contains the inode pointing to the opened symbolic link. However, after =
atomic_open() is called, the may_open() function in namei.c checks the =
node's i_mode and identifies it as a symbolic link, resulting in an =
ELOOP error.

My concernn is: what is the expected behavior for opening a symbolic =
link, both on the kernel side and the server side? Is it possible for =
the fuse server to return the dentry containing the inode of the link =
destination instead of the inode of the symbolic link itself?

> On Sep 21, 2023, at 2:34, Bernd Schubert <bschubert@ddn.com> wrote:
>=20
> From: Dharmendra Singh <dsingh@ddn.com>
>=20
> This adds full atomic open support, to avoid lookup before =
open/create.
> If the implementation (fuse server/daemon) does not support atomic =
open
> it falls back to non-atomic open.
>=20
> Co-developed-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
> fs/fuse/dir.c             | 214 +++++++++++++++++++++++++++++++++++++-
> fs/fuse/fuse_i.h          |   3 +
> include/uapi/linux/fuse.h |   3 +
> 3 files changed, 219 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 542086140781..4cb2809a852d 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -722,7 +722,7 @@ static int _fuse_create_open(struct inode *dir, =
struct dentry *entry,
>=20
> static int fuse_mknod(struct mnt_idmap *, struct inode *, struct =
dentry *,
>      umode_t, dev_t);
> -static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> +static int fuse_create_open(struct inode *dir, struct dentry *entry,
>    struct file *file, unsigned flags,
>    umode_t mode)
> {
> @@ -768,6 +768,218 @@ static int fuse_atomic_open(struct inode *dir, =
struct dentry *entry,
> return finish_no_open(file, res);
> }
>=20
> +static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
> +     struct file *file, unsigned flags,
> +     umode_t mode)
> +{
> + int err;
> + struct inode *inode;
> + struct fuse_mount *fm =3D get_fuse_mount(dir);
> + struct fuse_conn *fc =3D fm->fc;
> + FUSE_ARGS(args);
> + struct fuse_forget_link *forget;
> + struct fuse_create_in inarg;
> + struct fuse_open_out outopen;
> + struct fuse_entry_out outentry;
> + struct fuse_inode *fi;
> + struct fuse_file *ff;
> + struct dentry *switched_entry =3D NULL, *alias =3D NULL;
> + DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> +
> + /* Expect a negative dentry */
> + if (unlikely(d_inode(entry)))
> + goto fallback;
> +
> + /* Userspace expects S_IFREG in create mode */
> + if ((flags & O_CREAT) && (mode & S_IFMT) !=3D S_IFREG)
> + goto fallback;
> +
> + forget =3D fuse_alloc_forget();
> + err =3D -ENOMEM;
> + if (!forget)
> + goto out_err;
> +
> + err =3D -ENOMEM;
> + ff =3D fuse_file_alloc(fm);
> + if (!ff)
> + goto out_put_forget_req;
> +
> + if (!fc->dont_mask)
> + mode &=3D ~current_umask();
> +
> + flags &=3D ~O_NOCTTY;
> + memset(&inarg, 0, sizeof(inarg));
> + memset(&outentry, 0, sizeof(outentry));
> + inarg.flags =3D flags;
> + inarg.mode =3D mode;
> + inarg.umask =3D current_umask();
> +
> + if (fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
> +    !(flags & O_EXCL) && !capable(CAP_FSETID)) {
> + inarg.open_flags |=3D FUSE_OPEN_KILL_SUIDGID;
> + }
> +
> + args.opcode =3D FUSE_OPEN_ATOMIC;
> + args.nodeid =3D get_node_id(dir);
> + args.in_numargs =3D 2;
> + args.in_args[0].size =3D sizeof(inarg);
> + args.in_args[0].value =3D &inarg;
> + args.in_args[1].size =3D entry->d_name.len + 1;
> + args.in_args[1].value =3D entry->d_name.name;
> + args.out_numargs =3D 2;
> + args.out_args[0].size =3D sizeof(outentry);
> + args.out_args[0].value =3D &outentry;
> + args.out_args[1].size =3D sizeof(outopen);
> + args.out_args[1].value =3D &outopen;
> +
> + if (flags & O_CREAT) {
> + err =3D get_create_ext(&args, dir, entry, mode);
> + if (err)
> + goto out_free_ff;
> + }
> +
> + err =3D fuse_simple_request(fm, &args);
> + free_ext_value(&args);
> + if (err =3D=3D -ENOSYS) {
> + fc->no_open_atomic =3D 1;
> + fuse_file_free(ff);
> + kfree(forget);
> + goto fallback;
> + }
> +
> + if (!err && !outentry.nodeid)
> + err =3D -ENOENT;
> +
> + if (err)
> + goto out_free_ff;
> +
> + err =3D -EIO;
> + if (invalid_nodeid(outentry.nodeid) || =
fuse_invalid_attr(&outentry.attr))
> + goto out_free_ff;
> +
> + ff->fh =3D outopen.fh;
> + ff->nodeid =3D outentry.nodeid;
> + ff->open_flags =3D outopen.open_flags;
> + inode =3D fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
> +  &outentry.attr, entry_attr_timeout(&outentry), 0);
> + if (!inode) {
> + flags &=3D ~(O_CREAT | O_EXCL | O_TRUNC);
> + fuse_sync_release(NULL, ff, flags);
> + fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> + err =3D -ENOMEM;
> + goto out_err;
> + }
> +
> + /* prevent racing/parallel lookup on a negative hashed */
> + if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
> + d_drop(entry);
> + switched_entry =3D d_alloc_parallel(entry->d_parent,
> +   &entry->d_name, &wq);
> + if (IS_ERR(switched_entry)) {
> + err =3D PTR_ERR(switched_entry);
> + goto out_free_ff;
> + }
> +
> + if (unlikely(!d_in_lookup(switched_entry))) {
> + /* fall back */
> + dput(switched_entry);
> + switched_entry =3D NULL;
> + goto free_and_fallback;
> + }
> +
> + entry =3D switched_entry;
> + }
> +
> + if (d_really_is_negative(entry)) {
> + d_drop(entry);
> + alias =3D d_exact_alias(entry, inode);
> + if (!alias) {
> + alias =3D d_splice_alias(inode, entry);
> + if (IS_ERR(alias)) {
> + /*
> + * Close the file in user space, but do not unlink it,
> + * if it was created - with network file systems other
> + * clients might have already accessed it.
> + */
> + fi =3D get_fuse_inode(inode);
> + fuse_sync_release(fi, ff, flags);
> + fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> + err =3D PTR_ERR(alias);
> + goto out_err;
> + }
> + }
> +
> + if (alias)
> + entry =3D alias;
> + }
> +
> + fuse_change_entry_timeout(entry, &outentry);
> +
> + /*  File was indeed created */
> + if (outopen.open_flags & FOPEN_FILE_CREATED) {
> + if (!(flags & O_CREAT)) {
> + pr_debug("Server side bug, FOPEN_FILE_CREATED set "
> + "without O_CREAT, ignoring.");
> + } else {
> + /* This should be always set when the file is created */
> + fuse_dir_changed(dir);
> + file->f_mode |=3D FMODE_CREATED;
> + }
> + }
> +
> + if (S_ISDIR(mode))
> + ff->open_flags &=3D ~FOPEN_DIRECT_IO;
> + err =3D finish_open(file, entry, generic_file_open);
> + if (err) {
> + fi =3D get_fuse_inode(inode);
> + fuse_sync_release(fi, ff, flags);
> + } else {
> + file->private_data =3D ff;
> + fuse_finish_open(inode, file);
> + }
> +
> + kfree(forget);
> +
> + if (switched_entry) {
> + d_lookup_done(switched_entry);
> + dput(switched_entry);
> + }
> +
> + dput(alias);
> +
> + return err;
> +
> +out_free_ff:
> + fuse_file_free(ff);
> +out_put_forget_req:
> + kfree(forget);
> +out_err:
> + if (switched_entry) {
> + d_lookup_done(switched_entry);
> + dput(switched_entry);
> + }
> +
> + return err;
> +
> +free_and_fallback:
> + fuse_file_free(ff);
> + kfree(forget);
> +fallback:
> + return fuse_create_open(dir, entry, file, flags, mode);
> +}
> +
> +static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> +    struct file *file, unsigned int flags,
> +    umode_t mode)
> +{
> + struct fuse_conn *fc =3D get_fuse_conn(dir);
> +
> + if (fc->no_open_atomic)
> + return fuse_create_open(dir, entry, file, flags, mode);
> + else
> + return _fuse_atomic_open(dir, entry, file, flags, mode);
> +}
> +
> /*
>  * Code shared between mknod, mkdir, symlink and link
>  */
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 9b7fc7d3c7f1..c838708cfa2b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -672,6 +672,9 @@ struct fuse_conn {
> /** Is open/release not implemented by fs? */
> unsigned no_open:1;
>=20
> + /** Is open atomic not implemented by fs? */
> + unsigned no_open_atomic:1;
> +
> /** Is opendir/releasedir not implemented by fs? */
> unsigned no_opendir:1;
>=20
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index b3fcab13fcd3..33fefee42697 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -315,6 +315,7 @@ struct fuse_file_lock {
>  * FOPEN_STREAM: the file is stream-like (no file position at all)
>  * FOPEN_NOFLUSH: don't flush data cache on close (unless =
FUSE_WRITEBACK_CACHE)
>  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the =
same inode
> + * FOPEN_FILE_CREATED: the file was indeed created
>  */
> #define FOPEN_DIRECT_IO (1 << 0)
> #define FOPEN_KEEP_CACHE (1 << 1)
> @@ -323,6 +324,7 @@ struct fuse_file_lock {
> #define FOPEN_STREAM (1 << 4)
> #define FOPEN_NOFLUSH (1 << 5)
> #define FOPEN_PARALLEL_DIRECT_WRITES (1 << 6)
> +#define FOPEN_FILE_CREATED (1 << 7)
>=20
> /**
>  * INIT request/reply flags
> @@ -575,6 +577,7 @@ enum fuse_opcode {
> FUSE_REMOVEMAPPING =3D 49,
> FUSE_SYNCFS =3D 50,
> FUSE_TMPFILE =3D 51,
> + FUSE_OPEN_ATOMIC =3D 52,
>=20
> /* CUSE specific operations */
> CUSE_INIT =3D 4096,
> --=20
> 2.39.2
>=20
>=20

