Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9185C4D3C17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 22:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiCIVdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 16:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiCIVdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:33:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899C611D798
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 13:32:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c25so2404380edj.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZHkvHMA1I6eh/YZqJlZmNXRy1yBzafqBEJKVUwInNkU=;
        b=T/pixWr78MTQFIr0gZocxDvBgcUg8EdHrLBsGWDk2HasstXtU8yYvGSGdTEw8/CkBA
         p6xuAsgcGRciwA4yRltBP8eAhwCOgupho6O3XUF1RdZqzSHnIDtBStqZ6tpGLu6SBWRe
         p+Y2GF7wUVcPkKSKXNtNjFtJ64aFK78dPs5S3NKndWJ82s1AuAITJ5phuhVQCuk89zoY
         JJZijUXSZSZI4XD5jXTY7tiyn2SRbA1qcTNtz2f+WIzaEAhd2n8jreps3ybBJWe88Jq5
         5su8hAfUj0zUsNjXpL3t7X4Oxm+QgqSdxh10eIxKu7Z632mzJivSvC465shwR3HzKH2/
         AUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZHkvHMA1I6eh/YZqJlZmNXRy1yBzafqBEJKVUwInNkU=;
        b=vAeX79o+IRwZFgkbG1okQAX5Z1yfRhHLEs0Yexo0bmvn+CjO6Vc7gskb+uiUhyftkk
         3RsOSRQ6NGJZ0sWntnnQbv8x0eD2a6uc+5ADTINtsKZ+vGLaXsm7j2gL6aceRvX7Oumg
         rwUORlsMjamNB5d4/cmuphcc7VEcvwx8hgTGdV9/rTaqIbjxnD2cPzQdtxXqURBwFe5k
         gQ6qlvbY7Q8UKMW8fgsk737XGf3P67IJOCywc7kYbNxhVzRud0I6jIv9Sc5lMMbxalG4
         kEBTPnTrGNvJkP6KGrtXO0kC++teamnJkK9HEPvhtefx57CNHP/KsdnY7GwzugBY2cda
         Ej5w==
X-Gm-Message-State: AOAM530IndYHp33IucOWMNfrRfn5LhbuIqRSAAjgYi7nHnZn5BX/UCUZ
        dQRV5zjSvP6yURFJ9cO5MOld+lES7Qnhynyk4P24
X-Google-Smtp-Source: ABdhPJwmQnZ6x8mnpsnt5Id3i1N77PSHj7DRdzEp7HrYbjMp09EZIcsmw9Xs9Ups7S4MchBRNM5VC5oXh2hJcrmwWpM=
X-Received: by 2002:a05:6402:90c:b0:415:d340:4ae2 with SMTP id
 g12-20020a056402090c00b00415d3404ae2mr1394660edz.331.1646861527956; Wed, 09
 Mar 2022 13:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20220228215935.748017-1-mic@digikod.net> <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
 <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
In-Reply-To: <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Mar 2022 16:31:57 -0500
Message-ID: <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 1, 2022 at 5:15 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
> On 01/03/2022 10:22, Christian Brauner wrote:
> > On Mon, Feb 28, 2022 at 10:59:35PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> >> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>
> >> While transitionning to ACC_MODE() with commit 5300990c0370 ("Sanitize
> >> f_flags helpers") and then fixing it with commit 6d125529c6cb ("Fix
> >> ACC_MODE() for real"), we lost an open flags consistency check.  Openi=
ng
> >> a file with O_WRONLY | O_RDWR leads to an f_flags containing MAY_READ =
|
> >> MAY_WRITE (thanks to the ACC_MODE() helper) and an empty f_mode.
> >> Indeed, the OPEN_FMODE() helper transforms 3 (an incorrect value) to 0=
.
> >>
> >> Fortunately, vfs_read() and vfs_write() both check for FMODE_READ, or
> >> respectively FMODE_WRITE, and return an EBADF error if it is absent.
> >> Before commit 5300990c0370 ("Sanitize f_flags helpers"), opening a fil=
e
> >> with O_WRONLY | O_RDWR returned an EINVAL error.  Let's restore this s=
afe
> >> behavior.
> >
> > That specific part seems a bit risky at first glance. Given that the
> > patch referenced is from 2009 this means we've been allowing O_WRONLY |
> > O_RDWR to succeed for almost 13 years now.
>
> Yeah, it's an old bug, but we should keep in mind that a file descriptor
> created with such flags cannot be used to read nor write. However,
> unfortunately, it can be used for things like ioctl, fstat, chdir=E2=80=
=A6 I
> don't know if there is any user of this trick.
>
> Either way, there is an inconsistency between those using ACC_MODE() and
> those using OPEN_FMODE(). If we decide to take a side for the behavior
> of one or the other, without denying to create such FD, it could also
> break security policies. We have to choose what to potentially break=E2=
=80=A6

I'm not really liking the idea that the empty/0 f_mode field leads to
SELinux doing an ioctl access check as opposed to the expected
read|write check.  Yes, other parts of the code catch the problem, but
this is bad from a SELinux perspective.  Looking quickly at the other
LSMs, it would appear that other LSMs are affected as well.

If we're not going to fix file::f_mode, the LSMs probably need to
consider using file::f_flags directly in conjunction with a correct
OPEN_FMODE() macro (or better yet a small inline function that isn't
as ugly).

--=20
paul-moore.com
