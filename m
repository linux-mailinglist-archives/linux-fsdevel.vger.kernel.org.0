Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5E467AC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 17:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381944AbhLCQIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 11:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381943AbhLCQIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:08:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCC8C061354
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 08:04:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so13211963edb.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Dec 2021 08:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5UkY7PRTKX26ZutUDOAR8GdNlUQaahHbEkk5mmXfS0=;
        b=2IjpP39TTGho5JpMWZSULn9plerXFndbpeBg4ZewjquTI/5S4B39O3XJEkyJVAAxDX
         s4aUtvstJ9bvwa60UHuVKVCU444AeYn0R6jJjuaB+r12HvX75J2SQitA+VCwbnPZBPUT
         ut/IAEGIez7cT2MZ03IjXneTtQpL8hhDS3OPPtLZcPe6GQuDkGjm2HMrliL60VT+P7eJ
         ObL5qEPbrX3sPtH9nuI99UVZxekY6i/IjXMDklKaZA4Pu8MafxBd6/qvbfaeFZI1fxsG
         al1bpcTjMKIfJXvO8IqNaGsUNtRSbOi5rsi0q9n2gLG64Z6JlhsTKgFQgpy4iKV1tOZn
         EedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5UkY7PRTKX26ZutUDOAR8GdNlUQaahHbEkk5mmXfS0=;
        b=oIplC7zaunjRI3u+pdYsvZohxp54KvVBCfO7kfWPfd2gPSRrxDUF9LpHJnXMl1C05A
         xXWL18pysjs5zzjRj46WXbZ4paiu/Svvt41eKjJ1HfGLhNc+UksK37K/t1icfzLHGQlQ
         kD9GjpT2px29V5Ejqm//sgN1DC6gFY5SEtsBqaKTxgDiamc/Fk/eaUk6jqy/OE6ReRI8
         oak93uJO3GMaHfkblhLXBhONIceSPUhcCI4AkFj/PWMtTORJ27yJ6rtSmm14Ie1KtJx+
         4IuppKKIlKuOUxuQ+rMZbSKI3CTRPAFtZk19EVjrJF5W5AY5EQqtf45zrugBQKmKJ19q
         2odw==
X-Gm-Message-State: AOAM533ick4PBF6Q/jWs2jwsRmyFsrYc5vqPZD8lBup45i/RL7N+RS7e
        4mxIUaF8kNfkmQEFyeIG3x5oTZk4mveKmwZ4aBTA
X-Google-Smtp-Source: ABdhPJzAwC5Ow46EDycffiA8kJlHElhGLTqqouGmZbK9nJrOnqJs8UMlEELIb8hBBa/t5wU/HllpM/L7WTZf3zvn9yk=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr24406726ejc.126.1638547474024;
 Fri, 03 Dec 2021 08:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <Yao51m9EXszPsxNN@redhat.com>
In-Reply-To: <Yao51m9EXszPsxNN@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Dec 2021 11:04:23 -0500
Message-ID: <CAHC9VhQ8NJdCKE7x5qzWoSDZvboyyy+fmOkA-cTN0XrvfYepeA@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
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

On Fri, Dec 3, 2021 at 10:38 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> On Wed, Nov 17, 2021 at 09:36:42AM +0200, Amir Goldstein wrote:
> > On Wed, Nov 17, 2021 at 3:58 AM David Anderson <dvander@google.com> wrote:
> > >
> > > Mark Salyzyn (3):
> > >   Add flags option to get xattr method paired to __vfs_getxattr
> > >   overlayfs: handle XATTR_NOSECURITY flag for get xattr method
> > >   overlayfs: override_creds=off option bypass creator_cred
> > >
> > > Mark Salyzyn + John Stultz (1):
> > >   overlayfs: inode_owner_or_capable called during execv
> > >
> > > The first three patches address fundamental security issues that should
> > > be solved regardless of the override_creds=off feature.
> > >
> > > The fourth adds the feature depends on these other fixes.
> > >
> > > By default, all access to the upper, lower and work directories is the
> > > recorded mounter's MAC and DAC credentials.  The incoming accesses are
> > > checked against the caller's credentials.
> > >
> > > If the principles of least privilege are applied for sepolicy, the
> > > mounter's credentials might not overlap the credentials of the caller's
> > > when accessing the overlayfs filesystem.  For example, a file that a
> > > lower DAC privileged caller can execute, is MAC denied to the
> > > generally higher DAC privileged mounter, to prevent an attack vector.
> > >
> > > We add the option to turn off override_creds in the mount options; all
> > > subsequent operations after mount on the filesystem will be only the
> > > caller's credentials.  The module boolean parameter and mount option
> > > override_creds is also added as a presence check for this "feature",
> > > existence of /sys/module/overlay/parameters/overlay_creds
>
> BTW, where is patch 1 of the series. I can't seem to find it.

Lore to the rescue ...

https://lore.kernel.org/selinux/20211117015806.2192263-2-dvander@google.com/

-- 
paul moore
www.paul-moore.com
