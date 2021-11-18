Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B9845585C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 10:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbhKRJ5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 04:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245338AbhKRJ4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:56:25 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA4C06120B
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 01:53:25 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id y5so12299297ual.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JY0UXmr3zp8U/NJuIhRPM0TLPJ/m8rx39/0IZd280GU=;
        b=LSqC4wUQa8ABy11DMBygmQnI2lohiG0AjBOTAwhE64lMX6lHxg9/EARkmHZhPydwTn
         6tZUC0rHH5c8DCKJUghtg/zdWkytXs6k2cDXV9TuZkVuQCTmVwOnZaQOrNaGlwz3d6sY
         V0IJcupqGE5CMSctMs5GgKWaU7ip4N/ixmGOvc6UDLl9re0sf3dGvdGMqma7YTVdxVAZ
         8rB/iDNfTNSO+pkSk7akif/naGQ2yybN7C6sVIvW2wVZR0v8MnNO1UJutVuZcxlr7aNr
         ri4oN0IJRhTT1B1bYwQaJ1P0AcY3SIGrFpvySXa8bmroTJmYFtTyMDgodobuWMqpSiIc
         cnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JY0UXmr3zp8U/NJuIhRPM0TLPJ/m8rx39/0IZd280GU=;
        b=aLJdEzCCVaMTDkNdv/4UWFGfh6Q7pChpek7QxvG4pI428/L9w9ZfhOAmOs3Ctymwo/
         BrN1a/vJxk1tErQWZUYnbUaO0zkVB8sOiQpSd9BY9HJ6t6vxEAk9u3F1c3YLie4QRbQQ
         9pM883EiyAdC2otaxnQw6R3V23eAASBpnveX++Z99y7JfTCW9uYEtPsY+b3LnggvcYRq
         iGbOhTFhy4PerYEQvSqWhI8hDM7q3iBgYrEiS7m5JpQjVs1AFdPXDu9kvXqDuipjQl3d
         KQo8ruGAbwJ4Hcj2+h6IVa/P6BngJjZpCuRNwwlwFa46eRrIFStjWxU+ST6ZYzxVWeHO
         s/Gw==
X-Gm-Message-State: AOAM531TFznjvRZGfuje76GUgh95ND+jM7uatneUvDBqE+QV3QLn8uYe
        X3XoR32vo1t2j+2i13hRcYOiv7vkUHmMjuKGeon+cQ==
X-Google-Smtp-Source: ABdhPJwy0TUrPwUxvXKivmCrLAfaniiw5vp4PgG8EaXUJC1b6K6X/jKTsJBRBD29IEgpt9YxtTuvgfeAYx2mw+dE9L0=
X-Received: by 2002:a05:6102:5109:: with SMTP id bm9mr77713653vsb.10.1637229204491;
 Thu, 18 Nov 2021 01:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
From:   David Anderson <dvander@google.com>
Date:   Thu, 18 Nov 2021 01:53:13 -0800
Message-ID: <CA+FmFJBDwt52Z-dVGfuUcnRMiMtGPhK4cCQJ=J_fg0r3x-b6ng@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
> Hi David,
>
> I see that the patch set has changed hands (presumably to Android upstreaming
> team), but you just rebased v18 without addressing the maintainers concerns [1].

Indeed I'm carrying this forward as Mark is no longer working on it.
My apologies for
missing those comments!

> Specifically, the patch 2/4 is very wrong for unprivileged mount and
> I think that the very noisy patch 1/4 could be completely avoided:
> Can't you use -o userxattr mount option for Android use case and limit
> the manipulation of user.ovrelay.* xattr based on sepolicy for actors
> that are allowed
> to make changes in overlayfs mount? or not limit at all?
> The access to those xattr is forbidden via "incoming" xattr ops on
> overlay inodes.

Can you clarify a bit more? The patch is definitely super noisy and I'd love
to have a better solution. The problem it's trying to solve is:
 1. Kernel-privileged init mounts /mnt/blah-lower and /mnt/blah-upper.
 2. Kernel-privileged init mounts /blah with overlayfs using the above dirs.
 2. Kernel-privileged init loads sepolicy off /blah/policy. Enforcing begins.
 3. Kernel-privileged init tries to execute /blah/init to initiate a
domain transition.
 4. exec() fails because the overlayfs mounter creds (kernel domain) does
     not have getxattr permission to /blah/init.

Eg, we're hitting this problem without even making changes to the mount, and
without anything being written to /mnt/blah-upper.

> Can an unprivileged user create an overlay over a directory that they have
> access to and redirect an innocent looking file name to an underlying file that
> said the mounting user has no access to and by doing that, tricking a privileged
> user to modify the innocent looking file on the  mounter's behalf?
> Of course this could be avoided by forbidding unprivileged mount with
> override_creds=off, but there could be other scenarios, so a clear model
> would help to understand the risks.
>
> For example:
> If user 1 was able to read in lower dir A, now the content of overlay dir A
> is cached and user 2, that has permissions to read upper dir A and does
> not have read permissions on lower dir A will see the content of lower dir A.

I'll need to think about this more and test to verify. It's not a scenario that
would come up in our use case (both dirs effectively have the same permissions).

If the answer is "yes, that can happen" - do you see this as a problem of
clarifying the model, or a problem of fixing that loophole?

>> I think that the core problem with the approach is using Non-uniform
> credentials to access underlying layers. I don't see a simple way around
> a big audit that checks all those cases, but maybe I'm missing some quick
> shortcut or maybe your use case can add some restrictions about the
> users that could access this overlay that would simplify the generic problem.

In a security model like ours, I think there's no way around it, that
we really need
accesses to be from the caller's credentials and not the mounter's. It's even
worse than earlier iterations of this patch perhaps let on: we mount
before sepolicy
is loaded (so we can overlay the policy itself), and thus the
mounter's creds are
effectively "the kernel". This domain is highly restricted in our
sepolicy for obvious
reasons. There's no way our security team will let us unrestrict it.

Best,

-David




>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-unionfs/CAJfpegtMoD85j5namV592sJD23QeUMD=+tq4SvFDqjVxsAszYQ@mail.gmail.com/
