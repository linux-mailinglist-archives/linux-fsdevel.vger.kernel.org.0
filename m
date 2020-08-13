Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4187C243EF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 20:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHMSjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:39:23 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF5C061757;
        Thu, 13 Aug 2020 11:39:23 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k12so5646114otr.1;
        Thu, 13 Aug 2020 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y7lNN8r9lQHJr7MGliJHH6oai9G3/LoeZrHO1ezSymg=;
        b=hZRKobHrmcwd7ZBaJZr1UhFE9EkEawa4jcXjhvjc7A0JwqsL2rpjf/L2SIHFKiStNe
         soofYzcuF4lbxAffpF62tDVqI6gyYJ9/0dqVuP2p7hHzu1f0m160hVIWhzVrFQDGnPGA
         qgizYVuYrqGjKEBqH2Q3s65w4PlO6j52SlGLMZajVogKJwB30YP3dvngY4Gy/1MwL31a
         GDBac+LreOXZsEeDAnjUis2LdW5yrixuTiK8/6lkZ8uTgg5/JfoiAm0Cx4HcAb7AbIG9
         zlTtycrarSA3+uJtnGv3xkTJqZ/SES7upawwm/Jcj2Rqwbr4NcmYDVBn8WKQtr7Ka2b6
         Tvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y7lNN8r9lQHJr7MGliJHH6oai9G3/LoeZrHO1ezSymg=;
        b=uDCEVHg7hO3fvln7wjUzgzYofzVbFn3MdE3RJbTHdMVMizZdyhITg3vHWKHHRqIpV0
         gpvTNkBjhxs6HTGrfwepySZLMsBesdSH24bQYfw8V54auncthqR0c8W0nfkOEhWq30tD
         hr2mAUODg+JW3PGMADcnIgoyM9XLR6lXd6SddXKdJt7JCiN5GPt0aV51qL/FbHzv3OgX
         p87+4yNNjFLNJr9YyiV/aGUymEtxM8nlWqaT1+Ym309ImjJM2Cd5zb3ULTTaK8mzrFeI
         xAooL73jwnzFJZp3stGWDhKF6jdnjk8MZaYwBOy4Z/40pzXsjSATMg+v9RYO4bX/LKoV
         nKsQ==
X-Gm-Message-State: AOAM531dO0W+CnLp0FxcRQTQ2b76SjtoMgKsU0Py6Eilbxwm65TKX9Ij
        hLhXpl5MrCoQpXfCEJJIW0g2pF6g1kQ6571HzRA=
X-Google-Smtp-Source: ABdhPJxOp79nbcc+gKMVWTSK9TAVg9Xfj8b3S6m17wgxhIQIhStE/aQ6riTh85EJ8Bn2tWlj/ZtPP3EqiCpIShZ/YfE=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr5273440otr.89.1597343963111;
 Thu, 13 Aug 2020 11:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200802215903.91936-1-mic@digikod.net> <20200802215903.91936-6-mic@digikod.net>
 <779c290b-45f5-b86c-c573-2edb4004105d@tycho.nsa.gov> <03f522c0-414c-434b-a0d1-57c3b17fa67f@digikod.net>
In-Reply-To: <03f522c0-414c-434b-a0d1-57c3b17fa67f@digikod.net>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 13 Aug 2020 14:39:12 -0400
Message-ID: <CAEjxPJ7POnxKy=5w-iQkKhjftxf2-=UuvA6D8EmhUPJyS1F6qg@mail.gmail.com>
Subject: Re: [PATCH v20 05/12] LSM: Infrastructure management of the superblock
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:17 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
>
> On 12/08/2020 21:16, Stephen Smalley wrote:
> > On 8/2/20 5:58 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> >> From: Casey Schaufler <casey@schaufler-ca.com>
> >>
> >> Move management of the superblock->sb_security blob out
> >> of the individual security modules and into the security
> >> infrastructure. Instead of allocating the blobs from within
> >> the modules the modules tell the infrastructure how much
> >> space is required, and the space is allocated there.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >> Link:
> >> https://lore.kernel.org/r/20190829232935.7099-2-casey@schaufler-ca.com
> >> ---
> >>
> >> Changes since v17:
> >> * Rebase the original LSM stacking patch from v5.3 to v5.7: I fixed so=
me
> >>    diff conflicts caused by code moves and function renames in
> >>    selinux/include/objsec.h and selinux/hooks.c .  I checked that it
> >>    builds but I didn't test the changes for SELinux nor SMACK.
> >
> > You shouldn't retain Signed-off-by and Reviewed-by lines from an earlie=
r
> > patch if you made non-trivial changes to it (even more so if you didn't
> > test them).
>
> I think I made trivial changes according to the original patch. But
> without reply from other people with Signed-off-by or Reviewed-by
> (Casey, Kees, John), I'll remove them. I guess you don't want your
> Reviewed-by to be kept, so I'll remove it, except if you want to review
> this patch (or the modified part).

At the very least your Reviewed-by line is wrong - yours should be
Signed-off-by because the patch went through you and you modified it.
I'll try to take a look as time permits but FYI you should this
address (already updated in MAINTAINERS) going forward.
