Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD084541F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhKQHjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 02:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhKQHjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:39:52 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D0CC061570;
        Tue, 16 Nov 2021 23:36:54 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id h23so1803576ila.4;
        Tue, 16 Nov 2021 23:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ml92anNYg6Ol/pP55oyNEwNFL7suIN1WFPiqqoxKiVk=;
        b=Uh8sFmLip2HBxGtTSenKgCOkxqdCjoU3qdIh2aLRSKqAkdVgVk1ErMays9ZWQ00a3z
         BAsN1YoabWXcsZAjC6YTaWDMOFpRCRMOuQxbjlNOzd7xbPNRgiKLnmpSY5IgH8Gfs4m8
         nDePIk2pycl3drPxzHDskoUOxp7fw6VDWVIuXwcRKIyxYPqR2tG8me2M8QUrxxMoLqsK
         DioKSN+TthmvHYRS7ybzjIIkFfItZ/r22xTKmOUJJY3G6HGDQC0bveqljfJMDx+MQUGk
         CCutnBYvFucF/HKsuaR2g221srr/NLPDrodBMeT/VF4V7Ge5LYtfPMV07crcDqTgRnsz
         Cgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ml92anNYg6Ol/pP55oyNEwNFL7suIN1WFPiqqoxKiVk=;
        b=iyhexfVPeN6EQgTClHEq/wwERV13CDtNVVistriyhmOlzMgrUEvNAE/43J/sEyD9Bt
         ahJNz/N4VQDdr1hB6QJVyNnFDWj+4gU+5J+8VqBRqAbGJiguEOmmKArQh6J4jcIbptEj
         x+q1IvaZNatZP7ftOsInsoClc+2Z10lM3QuT8Xec8ZORStVXbHEpSoGsb5yqPdZudwxC
         T9ZSy+lfSsaLvqn/gLZ6+AW5hF4kAC/4Bk3aloN75XnHyLqjpt+RXyPnU95kzIuHlNYv
         vH9iRo7KOTIZu41TQpRYF+M2xyGZ+I/srhbj9lp1LoW7226aHT6o1l+grrycSub7Ucqz
         zz7A==
X-Gm-Message-State: AOAM530aRmw/LWjKivvVV0/tNIDj+Vs/zx3JkGxh6HmHgtHsn7Ys2FuC
        MnUZUeHCQ/LJ7DW72oWIuLNnGLdnENeoSFpN8UVyOZ3jHeA=
X-Google-Smtp-Source: ABdhPJzT4UQ2YWWOOZ9rkGhbi8sVGIpV4ZNn7w/xcKDZf1shkwR/HU7Q+tAud0i5glnQXlD7+DpzFcaexcCjFYHH33U=
X-Received: by 2002:a92:c983:: with SMTP id y3mr8487862iln.24.1637134613816;
 Tue, 16 Nov 2021 23:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com>
In-Reply-To: <20211117015806.2192263-1-dvander@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Nov 2021 09:36:42 +0200
Message-ID: <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     David Anderson <dvander@google.com>
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
        paulmoore@microsoft.com, Luca.Boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 3:58 AM David Anderson <dvander@google.com> wrote:
>
> Mark Salyzyn (3):
>   Add flags option to get xattr method paired to __vfs_getxattr
>   overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>   overlayfs: override_creds=off option bypass creator_cred
>
> Mark Salyzyn + John Stultz (1):
>   overlayfs: inode_owner_or_capable called during execv
>
> The first three patches address fundamental security issues that should
> be solved regardless of the override_creds=off feature.
>
> The fourth adds the feature depends on these other fixes.
>
> By default, all access to the upper, lower and work directories is the
> recorded mounter's MAC and DAC credentials.  The incoming accesses are
> checked against the caller's credentials.
>
> If the principles of least privilege are applied for sepolicy, the
> mounter's credentials might not overlap the credentials of the caller's
> when accessing the overlayfs filesystem.  For example, a file that a
> lower DAC privileged caller can execute, is MAC denied to the
> generally higher DAC privileged mounter, to prevent an attack vector.
>
> We add the option to turn off override_creds in the mount options; all
> subsequent operations after mount on the filesystem will be only the
> caller's credentials.  The module boolean parameter and mount option
> override_creds is also added as a presence check for this "feature",
> existence of /sys/module/overlay/parameters/overlay_creds
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Signed-off-by: David Anderson <dvander@google.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: selinux@vger.kernel.org
> Cc: paulmoore@microsoft.com
> Cc: Luca.Boccassi@microsoft.com
>
> ---
>
> v19
> - rebase.
>

Hi David,

I see that the patch set has changed hands (presumably to Android upstreaming
team), but you just rebased v18 without addressing the maintainers concerns [1].

Specifically, the patch 2/4 is very wrong for unprivileged mount and
I think that the very noisy patch 1/4 could be completely avoided:
Can't you use -o userxattr mount option for Android use case and limit
the manipulation of user.ovrelay.* xattr based on sepolicy for actors
that are allowed
to make changes in overlayfs mount? or not limit at all?
The access to those xattr is forbidden via "incoming" xattr ops on
overlay inodes.

Also, IMO, the Documentation section about "Non overlapping credentials" does
not hold the same standards as the section about "Permission model" -
it does not
state the requirements clear enough for my non-security-oriented brain to be
able to understand if the "Ignore mounter's credentials" model can be exploited.

Can an unprivileged user create an overlay over a directory that they have
access to and redirect an innocent looking file name to an underlying file that
said the mounting user has no access to and by doing that, tricking a privileged
user to modify the innocent looking file on the  mounter's behalf?
Of course this could be avoided by forbidding unprivileged mount with
override_creds=off, but there could be other scenarios, so a clear model
would help to understand the risks.

For example:
If user 1 was able to read in lower dir A, now the content of overlay dir A
is cached and user 2, that has permissions to read upper dir A and does
not have read permissions on lower dir A will see the content of lower dir A.

I think that the core problem with the approach is using Non-uniform
credentials to access underlying layers. I don't see a simple way around
a big audit that checks all those cases, but maybe I'm missing some quick
shortcut or maybe your use case can add some restrictions about the
users that could access this overlay that would simplify the generic problem.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/CAJfpegtMoD85j5namV592sJD23QeUMD=+tq4SvFDqjVxsAszYQ@mail.gmail.com/
