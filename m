Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84A02A01F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 10:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgJ3J5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgJ3J5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:57:35 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D9C0613CF;
        Fri, 30 Oct 2020 02:57:35 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so5977144ilt.6;
        Fri, 30 Oct 2020 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KHmwpEf5KO59HQ9FXioTrkHMQnSCZyA82voNpwNnxU=;
        b=GRHC3d3uHyqgAX2bNvYF5h8/iEP8by/R6OwvXZSq+WCITM51vMsZn4GtwUmgPBcPTE
         JIFj14HuPPgbTZQIawYp/WdHFcCfbmwDz6AQau0lHfSWxoyRMIQGFCa6mC/lT/vC48Fh
         wYTYSi05HENiGIZrygUitWfPOvtbzSnv0hw2foQqpN3bXy/biCRwd2YEEEo1sCaotdD+
         hA6wLP2AV/oTN011TL9T9aeU4s8MfJlR9YyL3VBEDUL1hZNcVpgED15piK/dbU9mR+9J
         OBeYqC0iHVutFieBZGl23BYx95gCrsOrOmHBWMlmgoUyWbvcB9q8hEMkjqBqpL+HaXhc
         2LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KHmwpEf5KO59HQ9FXioTrkHMQnSCZyA82voNpwNnxU=;
        b=MPYeG5L3Q4s2ik9jeEeYMYcCvIkcSlUffhLZDzg3IhIpsmJdcbB1SBeSO2uNQxTqw6
         AdR+Pk4NZ/jPEFHAubpei1Lk6cyB2FbMwEavNR7cKlLJGYlVYT2qatKXixSlEELIN6Fo
         5+M32rGJFEEO1lDM7BRnoVF9UjdsBE+YJ4bPZjoiVmCIzsm2E7+W5+xQcTCTCgJT6das
         VTNDavB6lE6NSKHKs7lVE/DlnCGwdZH+zc4d4GtIY5Hwn+jlMdt8xyZ7pggI+BXxJuR9
         4t7SujPC3ui0ImpSRlo4Pm2azPK0Sgy/H6nCKSCZTTxmJtsRtcaxlkBZGeDLtqIhYk9K
         zVuA==
X-Gm-Message-State: AOAM531nz1pG6hSWVBeyE2EIT9gmzLLCNiMKVZaVDQGYk/mK0KiJ60Fm
        o3TfoJSCwm+3Ot7l60Hd68aIzznNHz9v1XbmCBA=
X-Google-Smtp-Source: ABdhPJxFlt//ACc/IV26fZ1qCGgWOIH/npCA4rcrvS/8aohcRHMILRDfiUHL83JStMqAq2lFcdcahBWGZNVdziI1h1E=
X-Received: by 2002:a05:6e02:14c9:: with SMTP id o9mr1218968ilk.137.1604051855144;
 Fri, 30 Oct 2020 02:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com> <20201029003252.2128653-34-christian.brauner@ubuntu.com>
In-Reply-To: <20201029003252.2128653-34-christian.brauner@ubuntu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 30 Oct 2020 11:57:24 +0200
Message-ID: <CAOQ4uxjyNB2zE+GE8Wmwjq__C7e4mrWMrS8RDVOOQFLtezjTkg@mail.gmail.com>
Subject: Re: [PATCH 33/34] overlayfs: handle idmapped merged mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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
        Miklos Szeredi <miklos@szeredi.hu>,
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
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -int ovl_permission(struct inode *inode, int mask)
> +int ovl_permission_mapped(struct user_namespace *user_ns,
> +                         struct inode *inode, int mask)
>  {
>         struct inode *upperinode = ovl_inode_upper(inode);
>         struct inode *realinode = upperinode ?: ovl_inode_lower(inode);
> -       struct user_namespace *user_ns;
> +       struct user_namespace *real_user_ns;
>         const struct cred *old_cred;
>         int err;
>
> @@ -302,15 +313,15 @@ int ovl_permission(struct inode *inode, int mask)
>         }
>
>         if (upperinode)
> -               user_ns = ovl_upper_mnt_user_ns(OVL_FS(inode->i_sb));
> +               real_user_ns = ovl_upper_mnt_user_ns(OVL_FS(inode->i_sb));
>         else
> -               user_ns = OVL_I(inode)->lower_user_ns;
> +               real_user_ns = OVL_I(inode)->lower_user_ns;

These changes look strange in this patch. Better use real_user_ns in previous
patch.

Thanks,
Amir.
