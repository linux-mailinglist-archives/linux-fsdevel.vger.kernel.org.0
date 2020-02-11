Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CAD158BAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBKJPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 04:15:23 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37404 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgBKJPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:15:23 -0500
Received: by mail-il1-f193.google.com with SMTP id v13so2824692iln.4;
        Tue, 11 Feb 2020 01:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdIlZUjUiU9Et+TLRdOE3MZltBw9dwJzx4JE2mijFcw=;
        b=vAzh8AIn/myfslUNkQhS0VSXss0Lr8ulQmFfaCTUDXGkAucLfzIxaN2uTJJE0wgGes
         4ZDlE3vpfToIbqFOSo9RiOT7CsilTQ2LLz3xN86S4leU8cf/t5E6cGoyV+yoiWxyAGQ7
         SesIuynVStDzK5WSMXQ8rQZPniP8b9LDZHE1Wta6u+bJLK1q/ZoRXhlql4Evqw+B5nMe
         aN7NCp1Gqm4G3ZJbNfMO2F3iPeLj5syEJYeE4abTk2Ne4xgOs61Og4UW2v00ycF/LTwb
         ZuH5P3dwxBB9bZPfO9ab7lgPhTu113Z3fDo5deDSRup9fIBGDfsmLJokIxMVobuWVyGS
         26Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdIlZUjUiU9Et+TLRdOE3MZltBw9dwJzx4JE2mijFcw=;
        b=PnqsKPY/wDT89T5cxNYDdXWUhhyOBfMPXEBUf18/U0VidFi3AMOl50z/8R+YqD4fnB
         bGneubYBP6imWTmkl/WKjlPFBNM4BTAAek94z3ZKCaWmmo29IfFcedaiVrf8AwMZ0Ohi
         OS/VCgfabxibeVkt3Ontm/SAFiJcWL5BtQUpLOzNFLd5sj5vUzHJ4E8i4oh5wi1UYFNy
         Dcpkhq8kXU2RZgeLI2J3YaTBKzB39JiIdc5d96fRQsY5FcTr0iHX39DLTeSrlQmCEQYJ
         EwfZm5MR8cnwurw5dvvJ5PfLj7mgrJp5TE2NMYMNf3BORhL/iLLXGaLVaPrO4I2vXh8L
         Fk8g==
X-Gm-Message-State: APjAAAWvLnPX27MoWXc5ScVZBzJ3KE40PXu8vYD15+V+AFS/0ALesYwU
        rp+x/+s01caZ8/0Sgsb5y9ai7/7FM8+WgHQECLI=
X-Google-Smtp-Source: APXvYqwxH0MRKWbVi9LF/FoS86IWI88iWJvc+h1fAl/sYAxz77xQva2vuGHZH8OmP5XBBqDHauboTH/jr5BS0j0Ef1U=
X-Received: by 2002:a92:d7c6:: with SMTP id g6mr5423861ilq.282.1581412522484;
 Tue, 11 Feb 2020 01:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20200207214948.1073419-1-jlayton@kernel.org>
In-Reply-To: <20200207214948.1073419-1-jlayton@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 11 Feb 2020 10:15:41 +0100
Message-ID: <CAOi1vP-z4+NKMMhCz19Ld_=X5B7nvzVbS-fErS9MA3cq+SMvGg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix allocation under spinlock in mount option parsing
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ceph Development <ceph-devel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Xiubo Li <xiubli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 7, 2020 at 10:49 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> Al and syzbot reported that 4fbc0c711b24 (ceph: remove the extra slashes
> in the server path) had caused a regression where an allocation could be
> done under spinlock.
>
> Fix this by keeping a canonicalized version of the path in the mount
> options. Then we can simply compare those without making copies at all
> during the comparison.
>
> Fixes: 4fbc0c711b24 ("ceph: remove the extra slashes in the server path")
> Reported-by: syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/super.c | 170 ++++++++++++++++++++++--------------------------
>  fs/ceph/super.h |   1 +
>  2 files changed, 79 insertions(+), 92 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 5fa28e98d2b8..196d547c7054 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -208,6 +208,69 @@ struct ceph_parse_opts_ctx {
>         struct ceph_mount_options       *opts;
>  };
>
> +/**
> + * canonicalize_path - Remove the extra slashes in the server path
> + * @server_path: the server path and could be NULL

Hi Jeff,

It doesn't look like server_path can be NULL, and the code doesn't
handle that either.

> + *
> + * Return NULL if the path is NULL or only consists of "/", or a string
> + * without any extra slashes including the leading slash(es) and the

It can return an error, so this should say "string, NULL or error", but
see below.

> + * slash(es) at the end of the server path, such as:
> + * "//dir1////dir2///" --> "dir1/dir2"
> + */
> +static char *canonicalize_path(const char *server_path)
> +{
> +       const char *path = server_path;
> +       const char *cur, *end;
> +       char *buf, *p;
> +       int len;
> +
> +       /* remove all the leading slashes */
> +       while (*path == '/')
> +               path++;
> +
> +       /* if the server path only consists of slashes */
> +       if (*path == '\0')
> +               return NULL;
> +
> +       len = strlen(path);
> +
> +       buf = kmalloc(len + 1, GFP_KERNEL);
> +       if (!buf)
> +               return ERR_PTR(-ENOMEM);
> +
> +       end = path + len;
> +       p = buf;
> +       do {
> +               cur = strchr(path, '/');
> +               if (!cur)
> +                       cur = end;
> +
> +               len = cur - path;
> +
> +               /* including one '/' */
> +               if (cur != end)
> +                       len += 1;
> +
> +               memcpy(p, path, len);
> +               p += len;
> +
> +               while (cur <= end && *cur == '/')
> +                       cur++;
> +               path = cur;
> +       } while (path < end);
> +
> +       *p = '\0';
> +
> +       /*
> +        * remove the last slash if there has and just to make sure that
> +        * we will get something like "dir1/dir2"
> +        */
> +       if (*(--p) == '/')
> +               *p = '\0';
> +
> +       return buf;
> +}

I realize that you just adapted the existing function, but it really
looks like a mouthful -- both the signature (string, NULL or error)
and the code.  It could be a lot more concise...

> +
>  /*
>   * Parse the source parameter.  Distinguish the server list from the path.
>   *
> @@ -230,15 +293,23 @@ static int ceph_parse_source(struct fs_parameter *param, struct fs_context *fc)
>
>         dev_name_end = strchr(dev_name, '/');
>         if (dev_name_end) {
> -               kfree(fsopt->server_path);
>

Blank line.

>                 /*
>                  * The server_path will include the whole chars from userland
>                  * including the leading '/'.
>                  */
> +               kfree(fsopt->server_path);
>                 fsopt->server_path = kstrdup(dev_name_end, GFP_KERNEL);
>                 if (!fsopt->server_path)
>                         return -ENOMEM;
> +
> +               kfree(fsopt->canon_path);
> +               fsopt->canon_path = canonicalize_path(fsopt->server_path);
> +               if (fsopt->canon_path && IS_ERR(fsopt->canon_path)) {
> +                       ret = PTR_ERR(fsopt->canon_path);
> +                       fsopt->canon_path = NULL;
> +                       return ret;
> +               }
>         } else {
>                 dev_name_end = dev_name + strlen(dev_name);
>         }
> @@ -447,6 +518,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
>         kfree(args->snapdir_name);
>         kfree(args->mds_namespace);
>         kfree(args->server_path);
> +       kfree(args->canon_path);
>         kfree(args->fscache_uniq);
>         kfree(args);
>  }
> @@ -462,73 +534,6 @@ static int strcmp_null(const char *s1, const char *s2)
>         return strcmp(s1, s2);
>  }
>
> -/**
> - * path_remove_extra_slash - Remove the extra slashes in the server path
> - * @server_path: the server path and could be NULL
> - *
> - * Return NULL if the path is NULL or only consists of "/", or a string
> - * without any extra slashes including the leading slash(es) and the
> - * slash(es) at the end of the server path, such as:
> - * "//dir1////dir2///" --> "dir1/dir2"
> - */
> -static char *path_remove_extra_slash(const char *server_path)
> -{
> -       const char *path = server_path;
> -       const char *cur, *end;
> -       char *buf, *p;
> -       int len;
> -
> -       /* if the server path is omitted */
> -       if (!path)
> -               return NULL;
> -
> -       /* remove all the leading slashes */
> -       while (*path == '/')
> -               path++;
> -
> -       /* if the server path only consists of slashes */
> -       if (*path == '\0')
> -               return NULL;
> -
> -       len = strlen(path);
> -
> -       buf = kmalloc(len + 1, GFP_KERNEL);
> -       if (!buf)
> -               return ERR_PTR(-ENOMEM);
> -
> -       end = path + len;
> -       p = buf;
> -       do {
> -               cur = strchr(path, '/');
> -               if (!cur)
> -                       cur = end;
> -
> -               len = cur - path;
> -
> -               /* including one '/' */
> -               if (cur != end)
> -                       len += 1;
> -
> -               memcpy(p, path, len);
> -               p += len;
> -
> -               while (cur <= end && *cur == '/')
> -                       cur++;
> -               path = cur;
> -       } while (path < end);
> -
> -       *p = '\0';
> -
> -       /*
> -        * remove the last slash if there has and just to make sure that
> -        * we will get something like "dir1/dir2"
> -        */
> -       if (*(--p) == '/')
> -               *p = '\0';
> -
> -       return buf;
> -}
> -
>  static int compare_mount_options(struct ceph_mount_options *new_fsopt,
>                                  struct ceph_options *new_opt,
>                                  struct ceph_fs_client *fsc)
> @@ -536,7 +541,6 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
>         struct ceph_mount_options *fsopt1 = new_fsopt;
>         struct ceph_mount_options *fsopt2 = fsc->mount_options;
>         int ofs = offsetof(struct ceph_mount_options, snapdir_name);
> -       char *p1, *p2;
>         int ret;
>
>         ret = memcmp(fsopt1, fsopt2, ofs);
> @@ -546,21 +550,12 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
>         ret = strcmp_null(fsopt1->snapdir_name, fsopt2->snapdir_name);
>         if (ret)
>                 return ret;
> +
>         ret = strcmp_null(fsopt1->mds_namespace, fsopt2->mds_namespace);
>         if (ret)
>                 return ret;
>
> -       p1 = path_remove_extra_slash(fsopt1->server_path);
> -       if (IS_ERR(p1))
> -               return PTR_ERR(p1);
> -       p2 = path_remove_extra_slash(fsopt2->server_path);
> -       if (IS_ERR(p2)) {
> -               kfree(p1);
> -               return PTR_ERR(p2);
> -       }
> -       ret = strcmp_null(p1, p2);
> -       kfree(p1);
> -       kfree(p2);
> +       ret = strcmp_null(fsopt1->canon_path, fsopt2->canon_path);
>         if (ret)
>                 return ret;
>
> @@ -963,7 +958,9 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>         mutex_lock(&fsc->client->mount_mutex);
>
>         if (!fsc->sb->s_root) {
> -               const char *path, *p;
> +               const char *path = fsc->mount_options->canon_path ?
> +                                       fsc->mount_options->canon_path : "";
> +
>                 err = __ceph_open_session(fsc->client, started);
>                 if (err < 0)
>                         goto out;
> @@ -975,22 +972,11 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>                                 goto out;
>                 }
>
> -               p = path_remove_extra_slash(fsc->mount_options->server_path);
> -               if (IS_ERR(p)) {
> -                       err = PTR_ERR(p);
> -                       goto out;
> -               }
> -               /* if the server path is omitted or just consists of '/' */
> -               if (!p)
> -                       path = "";
> -               else
> -                       path = p;
>                 dout("mount opening path '%s'\n", path);
>
>                 ceph_fs_debugfs_init(fsc);
>
>                 root = open_root_dentry(fsc, path, started);
> -               kfree(p);
>                 if (IS_ERR(root)) {
>                         err = PTR_ERR(root);
>                         goto out;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index e8f891770f9d..70aa32cfb64d 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -94,6 +94,7 @@ struct ceph_mount_options {
>         char *snapdir_name;   /* default ".snap" */
>         char *mds_namespace;  /* default NULL */
>         char *server_path;    /* default  "/" */
> +       char *canon_path;     /* default "/" */

Why keep both the original and canon_path around?  It looks like
the only remaining use of server_path is in create_session_open_msg().
Since that's just metadata, I think we can safely switch it over.

Also, the comment is misleading.  The default is NULL (which _means_
"/" for metadata purposes but "/" is never stored here).

I'll post what I have in mind as a patch shortly.

Thanks,

                Ilya
