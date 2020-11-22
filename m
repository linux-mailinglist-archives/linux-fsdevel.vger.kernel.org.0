Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455F32BC987
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 22:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgKVVTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 16:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKVVTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:19:08 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9142BC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2020 13:19:08 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q16so15075427edv.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2020 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnYAfYzK9z2CU6n9f6EQEQr3kUIpHz74aN1sscdy0dE=;
        b=SbzxRegB0eYgWQjrzVNZhGj7xGAuKSyhCYUAI+WyaPpWKWhEN6iqWX+bEcJKbYoB0L
         e+h2FSiOvFHziiUa44whQFraYTHOU8p50iPMrz8231dDk9fhDLvFKe/Cjby4M/d+4U6r
         W07v+9gVUkUhjxH3Geo4u+yVOo02UkCH74LdJNvQKI4YCSBilG3kHI2Y62XjETJSZ/uX
         MlbS32EkSSCU1n+fb8kYyduz0/3kWYDqvMuc0IaCRimx25Yqqx0UR7QjDDjbfQt8oUSD
         2DZTJmGkdogVeaLOCgp12rxjJJwbqtgcnvKaMV8RD8yIeQUYlTY9lypDDNNSf4zLZOfd
         JgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnYAfYzK9z2CU6n9f6EQEQr3kUIpHz74aN1sscdy0dE=;
        b=Kb+hCUuwcaXCDHBB26AozJ5pneuLZ2sustU1x5clcIzBOvEXBS43WAspzM334BJt05
         9g2evaqMk5K+7tsR29hNgBOEY01JWxM7PVMzbl9YjC6xR4n0bCwQqKFqiG9xM/owJh5J
         efRwtxqMYs567b8htsaOkNDe9nOA6VJWiWD8rIC7QR3qBxaJtZvfg7FTVPaahf503EYf
         9W71b3GC/dZqwFFMHWjYZogPN4KIZB0kK+gu9uY/58HAsYA/4yQc12PQ48Hz+HkGxPKD
         Is0u9ffdjoB7AesYZVjGPFEXtT3Q6TfKP1Qna9h/Z2j9M042fBAnLz6Qnsv8zsrfXmWj
         mQhg==
X-Gm-Message-State: AOAM530O6JLQcpY1EzaFExjSm2YQDQcs2fonqZMm51/kn53iT4b6gzog
        sExHfxIyXfqZg+ehTE7H93RaY5phgH/+bctaV2Wt
X-Google-Smtp-Source: ABdhPJxWDVFzpcLiB/ip+VH1A679zZkgv5lzs7PTKex+TlERHeuhuyes1CoTwmWTuMvWpYfUdNgQEs+SrGqG31WGjjs=
X-Received: by 2002:aa7:de01:: with SMTP id h1mr44059484edv.269.1606079946987;
 Sun, 22 Nov 2020 13:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20201115103718.298186-1-christian.brauner@ubuntu.com> <20201115103718.298186-15-christian.brauner@ubuntu.com>
In-Reply-To: <20201115103718.298186-15-christian.brauner@ubuntu.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 22 Nov 2020 16:18:55 -0500
Message-ID: <CAHC9VhRqk1WMXyHTsrLcJnpxMPgJs_CxeG2uCaaBGgHqK_jj=g@mail.gmail.com>
Subject: Re: [PATCH v2 14/39] commoncap: handle idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 5:39 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> When interacting with user namespace and non-user namespace aware
> filesystem capabilities the vfs will perform various security checks to
> determine whether or not the filesystem capabilities can be used by the
> caller (e.g. during exec), or even whether they need to be removed. The
> main infrastructure for this resides in the capability codepaths but they
> are called through the LSM security infrastructure even though they are not
> technically an LSM or optional. This extends the existing security hooks
> security_inode_removexattr(), security_inode_killpriv(),
> security_inode_getsecurity() to pass down the mount's user namespace and
> makes them aware of idmapped mounts.
> In order to actually get filesystem capabilities from disk the capability
> infrastructure exposes the get_vfs_caps_from_disk() helper. For user
> namespace aware filesystem capabilities a root uid is stored alongside the
> capabilities.
> In order to determine whether the caller can make use of the filesystem
> capability or whether it needs to be ignored it is translated according to
> the superblock's user namespace. If it can be translated to uid 0 according
> to that id mapping the caller can use the filesystem capabilities stored on
> disk. If we are accessing the inode that holds the filesystem capabilities
> through an idmapped mount we need to map the root uid according to the
> mount's user namespace.
> Afterwards the checks are identical to non-idmapped mounts. Reading
> filesystem caps from disk enforces that the root uid associated with the
> filesystem capability must have a mapping in the superblock's user
> namespace and that the caller is either in the same user namespace or is a
> descendant of the superblock's user namespace. For filesystems that are
> mountable inside user namespace the container can just mount the filesystem
> and won't usually need to idmap it. If it does create an idmapped mount it
> can mark it with a user namespace it has created and which is therefore a
> descendant of the s_user_ns. For filesystems that are not mountable inside
> user namespaces the descendant rule is trivially true because the s_user_ns
> will be the initial user namespace.
>
> If the initial user namespace is passed all operations are a nop so
> non-idmapped mounts will not see a change in behavior and will also not see
> any performance impact.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 8dba8f0983b5..ddb9213a3e81 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1944,7 +1944,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>         if (!dentry)
>                 return 0;
>
> -       rc = get_vfs_caps_from_disk(dentry, &caps);
> +       rc = get_vfs_caps_from_disk(&init_user_ns, dentry, &caps);
>         if (rc)
>                 return rc;
>
> @@ -2495,7 +2495,8 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
>         ax->d.next = context->aux;
>         context->aux = (void *)ax;
>
> -       get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
> +       get_vfs_caps_from_disk(mnt_user_ns(bprm->file->f_path.mnt),
> +                              bprm->file->f_path.dentry, &vcaps);

As audit currently records information in the context of the
initial/host namespace I'm guessing we don't want the mnt_user_ns()
call above; it seems like &init_user_ns would be the right choice
(similar to audit_copy_fcaps()), yes?

>         ax->fcap.permitted = vcaps.permitted;
>         ax->fcap.inheritable = vcaps.inheritable;

-- 
paul moore
www.paul-moore.com
