Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678011648F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 16:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgBSPm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 10:42:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42483 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgBSPm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:42:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id j132so24202625oih.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5m55kfVwkJi2EKe9BNjAoqNwmjnBNj+rhpNNJ8psMf0=;
        b=m+WyVCnjj1MKoR4h4JIOlgp2fjMP9yF/DEMlRuSkziBg37L/i9PeB+qwHQtq+5TBM6
         SooNA0Wk6Ljhtp5qSzPtSknsnL4DWgLfrCjYHytGQKdcv6POKVRKZfNj2WLGQm/nydCI
         tLJnBS44YGa0T/JV/3kNf+/psgr2j9ltjMIFFiTi5//ha9SRMrTDUxEcO7tDYtXyCNU0
         0W+ISMm5w6/KIDLxt6/6C3JAxunTLQr6+KHCnpMaj0TdKqHVbfPLbNK5F/nDNzZq3/LD
         fJURS56rYXEp2uY/mJftWB6gjcZlAAKUD1/slAZtFwMjuk9DFgtmJPrszBy2PNb1wk3w
         XhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5m55kfVwkJi2EKe9BNjAoqNwmjnBNj+rhpNNJ8psMf0=;
        b=BQfQv5PIEE3JkkD14Q2GK068L6V5s2pukt0tEf9DFuBm3pZ3PGYl/ufC12m2HY+xzz
         vgqYaq+UGuGBIN8s+WfMEWbvdaHbSJAlKJGELUVUL87Xz4RsFFJZZBXfGskKEIohcKHN
         iucCiBRijouBw8XnG/GEDsT910PGX9bE0N3NgweFFEbi2UEo5DFiA/bgq0C48rXokr2W
         UX/jq4SFzqD5X7+e6yTKkSB05NQvBewRs4mh+H1W4XeF+3zTyFfNBj0mpyAhDwJmOFtD
         MzeOXToYoc0zSDCUtnH/WIVM9AjiLVMvHO24aiI8OT1unp90HcWIMOGgPiyWLM95Audh
         Mafw==
X-Gm-Message-State: APjAAAX03y/IUEdoa+XMxRyYdz0j/amQEhNZcRFveYOj6QLCHsHB/Rb/
        l/TJvEvlIt0zyejcN0j+xMgtG9iPZKEAu0MXaqNcUg==
X-Google-Smtp-Source: APXvYqzYVTetcJbLAR2lHbzroMwjo5ViVjvR49a/DJvQymhESORCu2lQOkJU6wuyq4SCG9SAJgJJeWDh3Spsw3GeH0I=
X-Received: by 2002:aca:484a:: with SMTP id v71mr5008155oia.39.1582126947895;
 Wed, 19 Feb 2020 07:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com> <20200218143411.2389182-25-christian.brauner@ubuntu.com>
In-Reply-To: <20200218143411.2389182-25-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 16:42:01 +0100
Message-ID: <CAG48ez3onfVSYF_qx+jJuz0y+KuZ3U75Or8dxFhiDqMTdXzCZg@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] sys: handle fsid mappings in set*id() calls
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Stephen Barber <smbarber@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 3:37 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Switch set*id() calls to lookup fsids in the fsid mappings. If no fsid mappings
> are setup the behavior is unchanged, i.e. fsids are looked up in the id
> mappings.
[...]
> @@ -353,7 +354,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>         const struct cred *old;
>         struct cred *new;
>         int retval;
> -       kgid_t krgid, kegid;
> +       kgid_t krgid, kegid, kfsgid;
>
>         krgid = make_kgid(ns, rgid);
>         kegid = make_kgid(ns, egid);
> @@ -385,12 +386,20 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>                         new->egid = kegid;
>                 else
>                         goto error;
> +               kfsgid = make_kfsgid(ns, egid);
> +       } else {
> +               kfsgid = kgid_to_kfsgid(new->user_ns, new->egid);
> +       }

Here the "kfsgid" is the new filesystem GID as translated by the
special fsgid mapping...

> +       if (!gid_valid(kfsgid)) {
> +               retval = -EINVAL;
> +               goto error;
>         }
>
>         if (rgid != (gid_t) -1 ||
>             (egid != (gid_t) -1 && !gid_eq(kegid, old->gid)))
>                 new->sgid = new->egid;
> -       new->fsgid = new->egid;
> +       new->kfsgid = new->egid;

... but the "kfsgid" of the creds struct is translated by the normal
gid mapping...

> +       new->fsgid = kfsgid;

... and the local "kfsgid" is stored into the "fsgid" member.

This is pretty hard to follow. Can you come up with some naming scheme
that is clearer and where one name is always used for the
normally-translated fsgid and another name is always used for the
specially-translated fsgid? E.g. something like "pfsgid" (with the "p"
standing for "process", because it uses the same id mappings as used
for process identities) for the IDs translated via the normal gid
mapping?
