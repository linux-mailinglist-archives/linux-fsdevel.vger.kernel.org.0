Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D292C2F5944
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 04:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbhANDXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 22:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbhANDXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:23:02 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDAEC0617BD
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 19:22:29 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id w26so4932816ljo.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 19:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zTCVvJXagfoiZ6eSiel9WcBpW8eVcBj2VTu0FoIa1B0=;
        b=JiYDr2VnqULMIy70Nb0fBwWiEy/uDdJG1fCUhZvvNsD562Bf3IBEyl7o6j2JQZmsTN
         EJTEtoIluw9iIvZ0MgmGLsp46TfjFR5z5tTm+A7cOaOTUHgsgWtUJpoKIfYVWVBuio1c
         v96AeWPCRX/2IrcIpq0WVjZ1J92LDRLgwNLFFdTcZUKRXgQ8Vdg5fbWWMyFBpmo9rEGL
         Lifl9OsukLAL7boxX5/8SSplzTlUkQDRml6XDCxTbUnjKde1OF3TAQy6OoQnSt4kSUkP
         x6ycb8D1DXdMgoeALx/O5hxSdayZvSnStvJFm1qKec2R3+0D0y6CEUIzMwm5k072M4pL
         ptnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zTCVvJXagfoiZ6eSiel9WcBpW8eVcBj2VTu0FoIa1B0=;
        b=h4sI91JNJtq9hswqfyYhEdxQG0bXwJ8mDyzGlVgXeAEknEz1WoeYKNblZiAL5Apkv0
         CJO48uEEJEhaQKZlpfsUpKk36EgqB+mDzkPFOc9yt6PqZOCMdi8A1fjPH4DxWwdGGZSs
         q69AfFLqtSHJ+K218LwXf9CPWlgugxdGEBWyNAw0xunxGH70kqyd1v8nG0zIuGYKW8gr
         sbzcIKDG6Dmkx6eeBEGUTiwfd4FQNeqUjJgp8lGEXoS7Jib24GUeqIndwAbzukvTBqqP
         X949vi6bwWCQ8dVhQAr7ezFSrgRZSper0lDKkWMTtm55WHVL1vSjU9u1J/zzdeiCzbUY
         zubg==
X-Gm-Message-State: AOAM531RXzucAYBeu63w3xdTWeqnUXOYpd793KpD2wfLyH+wI3P8sfxF
        NXbU5bxc70mas0ym94Y/y54Ledj+UKnKJWxUBTddRg==
X-Google-Smtp-Source: ABdhPJwrbinyTfuQMzoD+5WNpL0EUhOuOWv1aK365JQd6QPuBnP/tRM63LPNrPM1A6XuPbhD56TnCuYYwLEorE1W7Ys=
X-Received: by 2002:a2e:8745:: with SMTP id q5mr2118434ljj.77.1610594547372;
 Wed, 13 Jan 2021 19:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20201209192839.1396820-1-mic@digikod.net> <20201209192839.1396820-8-mic@digikod.net>
In-Reply-To: <20201209192839.1396820-8-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Jan 2021 04:22:01 +0100
Message-ID: <CAG48ez1wbAQwU-eoC9DngHyUM_5F01MJQpRnLaJFvfRUrnXBdA@mail.gmail.com>
Subject: Re: [PATCH v26 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 8:28 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
> Thanks to the Landlock objects and ruleset, it is possible to identify
> inodes according to a process's domain.  To enable an unprivileged
> process to express a file hierarchy, it first needs to open a directory
> (or a file) and pass this file descriptor to the kernel through
> landlock_add_rule(2).  When checking if a file access request is
> allowed, we walk from the requested dentry to the real root, following
> the different mount layers.  The access to each "tagged" inodes are
> collected according to their rule layer level, and ANDed to create
> access to the requested file hierarchy.  This makes possible to identify
> a lot of files without tagging every inodes nor modifying the
> filesystem, while still following the view and understanding the user
> has from the filesystem.
>
> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
> keep the same struct inodes for the same inodes whereas these inodes are
> in use.
>
> This commit adds a minimal set of supported filesystem access-control
> which doesn't enable to restrict all file-related actions.  This is the
> result of multiple discussions to minimize the code of Landlock to ease
> review.  Thanks to the Landlock design, extending this access-control
> without breaking user space will not be a problem.  Moreover, seccomp
> filters can be used to restrict the use of syscall families which may
> not be currently handled by Landlock.
[...]
> +static bool check_access_path_continue(
> +               const struct landlock_ruleset *const domain,
> +               const struct path *const path, const u32 access_request,
> +               u64 *const layer_mask)
> +{
[...]
> +       /*
> +        * An access is granted if, for each policy layer, at least one r=
ule
> +        * encountered on the pathwalk grants the access, regardless of t=
heir
> +        * position in the layer stack.  We must then check not-yet-seen =
layers
> +        * for each inode, from the last one added to the first one.
> +        */
> +       for (i =3D 0; i < rule->num_layers; i++) {
> +               const struct landlock_layer *const layer =3D &rule->layer=
s[i];
> +               const u64 layer_level =3D BIT_ULL(layer->level - 1);
> +
> +               if (!(layer_level & *layer_mask))
> +                       continue;
> +               if ((layer->access & access_request) !=3D access_request)
> +                       return false;
> +               *layer_mask &=3D ~layer_level;

Hmm... shouldn't the last 5 lines be replaced by the following?

if ((layer->access & access_request) =3D=3D access_request)
    *layer_mask &=3D ~layer_level;

And then, since this function would always return true, you could
change its return type to "void".


As far as I can tell, the current version will still, if a ruleset
looks like this:

/usr read+write
/usr/lib/ read

reject write access to /usr/lib, right?


> +       }
> +       return true;
> +}
