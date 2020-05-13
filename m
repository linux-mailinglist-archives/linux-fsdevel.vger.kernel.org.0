Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81D1D1997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbgEMPh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgEMPh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 11:37:28 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B667C061A0C;
        Wed, 13 May 2020 08:37:28 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id p127so2301511oia.13;
        Wed, 13 May 2020 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JesLt0wnnXQRtMcIHg+I5khr0BA/8cCmiohenjE2ta4=;
        b=ErjuYfLQPK801OItCcYqBQDTNpGUtD2W7nLO68xLL9Zs3t7SXdMHPvJFYcFXgU0oY4
         tVKWCqPzr0IjBic4LQ7O5s3+CKc1XmGPgyzgrkGteK2wp7Uh5ppMeJRJrbbkILA8gGTE
         YxH9X5yYsM6dJbD68EAxWQx07chav4YEvVZnvf4BgcXmcsp2lkQzBshZbjMvlXhtj2pF
         dwhbeaKI3v+dx4HUbbm/1DAkLRFTqi+Bd3u2xHt/K5RGIEzi0OetKzpz/MPsOL7cJirm
         jfgiLNLDsUOub1+/Hm3NxIpAytmgc0YR6KH+CgSTqkq1pJiz4MeFvGI3nYbPY9U6X4m8
         saIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JesLt0wnnXQRtMcIHg+I5khr0BA/8cCmiohenjE2ta4=;
        b=efsib6pjLc5zA6dlp8jlXiebMN/7+ANfsOjGybf1n2LwzkxbQmMrBxkEjH4MMsJHc5
         MPq96GuXf0pqv//4MFFYJsmAl3kAye+cadCq0gqI7+JSvOUzOJCzn7oo9dY0RM3aAXAl
         BRnv0IdRrE6mkiUN0LTvub0T6dmHih9/1+DwqiNGm+TNnJ7EGvsCx4vfcKQVY07TINhz
         Nmm6ncpTYfGxsvCgcjTwVLNEj/4vsHip2prsZktbcfjGjxd8saQk/O23bo+6U6LO0LcB
         ax+qqDaWhCIpiKPWlk8BoRa2TeiYLT/7Z8bpvFcDk+MtXSK8gAl5YHt659vwH9Yych1a
         XmuQ==
X-Gm-Message-State: AGi0PuakD9+X1SVfK/Lsprqx95SGoxxkVkLL0+8MG7kncfZiCzXSftQo
        J1s5aHgJAwbsuX1TKoH7tOZGLhU/H8UpiTxLjzc=
X-Google-Smtp-Source: APiQypI+NDJoITHYfkqfEHsy2flEkLfDB5ZZom8ahxgSAc1RCzwvPgqRJlVhbVAW3EqoZWFQfSQrU6Gi8kmLlaY03xI=
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr26174094oib.160.1589384247535;
 Wed, 13 May 2020 08:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200505153156.925111-1-mic@digikod.net> <20200505153156.925111-4-mic@digikod.net>
In-Reply-To: <20200505153156.925111-4-mic@digikod.net>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 13 May 2020 11:37:16 -0400
Message-ID: <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] fs: Enable to enforce noexec mounts or file exec
 through O_MAYEXEC
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 11:33 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Enable to forbid access to files open with O_MAYEXEC.  Thanks to the
> noexec option from the underlying VFS mount, or to the file execute
> permission, userspace can enforce these execution policies.  This may
> allow script interpreters to check execution permission before reading
> commands from a file, or dynamic linkers to allow shared object loading.
>
> Add a new sysctl fs.open_mayexec_enforce to enable system administrators
> to enforce two complementary security policies according to the
> installed system: enforce the noexec mount option, and enforce
> executable file permission.  Indeed, because of compatibility with
> installed systems, only system administrators are able to check that
> this new enforcement is in line with the system mount points and file
> permissions.  A following patch adds documentation.
>
> For tailored Linux distributions, it is possible to enforce such
> restriction at build time thanks to the CONFIG_OMAYEXEC_STATIC option.
> The policy can then be configured with CONFIG_OMAYEXEC_ENFORCE_MOUNT and
> CONFIG_OMAYEXEC_ENFORCE_FILE.
>
> Being able to restrict execution also enables to protect the kernel by
> restricting arbitrary syscalls that an attacker could perform with a
> crafted binary or certain script languages.  It also improves multilevel
> isolation by reducing the ability of an attacker to use side channels
> with specific code.  These restrictions can natively be enforced for ELF
> binaries (with the noexec mount option) but require this kernel
> extension to properly handle scripts (e.g., Python, Perl).  To get a
> consistent execution policy, additional memory restrictions should also
> be enforced (e.g. thanks to SELinux).
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> ---

> diff --git a/fs/namei.c b/fs/namei.c
> index 33b6d372e74a..70f179f6bc6c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -411,10 +412,90 @@ static int sb_permission(struct super_block *sb, st=
ruct inode *inode, int mask)
<snip>
> +#if defined(CONFIG_SYSCTL) && !defined(CONFIG_OMAYEXEC_STATIC)
> +int proc_omayexec(struct ctl_table *table, int write, void __user *buffe=
r,
> +               size_t *lenp, loff_t *ppos)
> +{
> +       int error;
> +
> +       if (write) {
> +               struct ctl_table table_copy;
> +               int tmp_mayexec_enforce;
> +
> +               if (!capable(CAP_MAC_ADMIN))
> +                       return -EPERM;

Not fond of using CAP_MAC_ADMIN here (or elsewhere outside of security
modules).  The ability to set this sysctl is not equivalent to being
able to load a MAC policy, set arbitrary MAC labels on
processes/files, etc.

> + * omayexec_inode_permission - Check O_MAYEXEC before accessing an inode
> + *
> + * @inode: Inode to check permission on
> + * @mask: Right to check for (%MAY_OPENEXEC, %MAY_EXECMOUNT, %MAY_EXEC)
> + *
> + * Returns 0 if access is permitted, -EACCES otherwise.
> + */
> +static inline int omayexec_inode_permission(struct inode *inode, int mas=
k)
> +{
> +       if (!(mask & MAY_OPENEXEC))
> +               return 0;
> +
> +       if ((sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_MOUNT) &&
> +                       !(mask & MAY_EXECMOUNT))
> +               return -EACCES;
> +
> +       if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_FILE)
> +               return generic_permission(inode, MAY_EXEC);
> +
> +       return 0;
> +}

I'm wondering if this is being done at the wrong level.  I would think
that OMAYEXEC_ENFORCE_FILE would mean to check file execute permission
with respect to all mechanisms/policies, including DAC,
filesystem-specific checking (inode->i_op->permission), security
modules, etc.  That requires more than just calling
generic_permission() with MAY_EXEC, which only covers the default
DAC/ACL logic; you'd need to take the handling up a level to
inode_permission() and re-map MAY_OPENEXEC to MAY_EXEC for
do_inode_permission() and security_inode_permission() at least.
Alternatively, we can modify each individual filesystem (that
implements its own i_op->permission) and security module to start
handling MAY_OPENEXEC and have them choose to remap it to a file
execute check (or not) independent of the sysctl.  Not sure of your
intent.  As it stands, selinux_inode_permission() will ignore the new
MAY_OPENEXEC flag until someone updates it.  Likewise for Smack.
AppArmor/TOMOYO would probably need to check and handle FMODE_EXEC in
their file_open hooks since they don't implement inode_permission().
