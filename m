Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57CD39166D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhEZLqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 07:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229799AbhEZLqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 07:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622029516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Uw+/IY4PFLhc9QD0XQTD8Vq22Bv9V1A42B8cw/tcfQ=;
        b=KZW7SBXegZu/wpZtz8zD3v+c+Tfn24w8Eh3QahoBAYv0mpHdy6NN90Pi9eTOR4ih+SkyEC
        Jf0bJbiqlXJ21kPasLIbijiQ9LPvSbiQI8LWQ2eukOZjfTtYzxlONsPX/yCSUf1N4nyABf
        PSighAa3eR5ZZsVoX0qyYHzpK1vuiOQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-gJDS7jqNNFuyRJZtrKC19Q-1; Wed, 26 May 2021 07:45:15 -0400
X-MC-Unique: gJDS7jqNNFuyRJZtrKC19Q-1
Received: by mail-yb1-f199.google.com with SMTP id a139-20020a25ca910000b0290525c6ebf206so1337270ybg.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 04:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Uw+/IY4PFLhc9QD0XQTD8Vq22Bv9V1A42B8cw/tcfQ=;
        b=WdNHIX3pD6BnwST6ctJ9hBgL1ZBYwzwQt7Aa5HWHtb7wkdNN+9BvT1DG8JuN60JCZL
         6mg9uPGb01UIFgenzvEAM0FSSOTQKoizBYGfySMEZb/IMGC5dwDgRFR4YvMKUqZpabQK
         L9Sw4dnXz6/QPztmDUslZS+hw6Hn5SjAQjXhlkhdcS2RwK5SfcAv6g7d+6mRqqpe+ojJ
         wCSJ/PzkPbo+s8GHi+E6ZWYfeKj8YY3qYPQ+ro7BoexwF3mEmvAnYo2DRpaRXbrfRzsZ
         xv8TMurKzGU0njE36DgxF30cYulPrOdhuVZ9KNrZ4pClHlUPxdLbr3YwKwlrQKdFgEY9
         qKVw==
X-Gm-Message-State: AOAM533g6jj5pXsnqdRs2PzZ7cNTwK98/QMhZkPpZpKksbj56vdzOYWE
        +BCnV/eZ8zB8bPjML7QxUTeNwORIEGOXPWet5RhXJRaOdcRu15nO+e6dCL/HpNb7wOuV78GLaHX
        ck9PR2dAaiFNTYxEToYupuqPCmtDmNC7/J6hL1cQPPA==
X-Received: by 2002:a25:f50e:: with SMTP id a14mr48352360ybe.172.1622029514559;
        Wed, 26 May 2021 04:45:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7JX0t9Q+MjZUdNuGYqNNwFWjv7mwlUzB5zjT5J9a7c3DzGoUhB3CdgL/OZI5wwTVrJZE9FoOnkmowu6kRXnk=
X-Received: by 2002:a25:f50e:: with SMTP id a14mr48352333ybe.172.1622029514339;
 Wed, 26 May 2021 04:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <87o8d9k4ln.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o8d9k4ln.fsf@mpe.ellerman.id.au>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 26 May 2021 13:44:59 +0200
Message-ID: <CAFqZXNtUvrGxT6UMy81WfMsfZsydGN5k-VGFBq8yjDWN5ARAWw@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 1:00 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:
> > Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> > lockdown") added an implementation of the locked_down LSM hook to
> > SELinux, with the aim to restrict which domains are allowed to perform
> > operations that would breach lockdown.
> >
> > However, in several places the security_locked_down() hook is called in
> > situations where the current task isn't doing any action that would
> > directly breach lockdown, leading to SELinux checks that are basically
> > bogus.
> >
> > Since in most of these situations converting the callers such that
> > security_locked_down() is called in a context where the current task
> > would be meaningful for SELinux is impossible or very non-trivial (and
> > could lead to TOCTOU issues for the classic Lockdown LSM
> > implementation), fix this by modifying the hook to accept a struct cred
> > pointer as argument, where NULL will be interpreted as a request for a
> > "global", task-independent lockdown decision only. Then modify SELinux
> > to ignore calls with cred == NULL.
> >
> > Since most callers will just want to pass current_cred() as the cred
> > parameter, rename the hook to security_cred_locked_down() and provide
> > the original security_locked_down() function as a simple wrapper around
> > the new hook.
> >
> > The callers migrated to the new hook, passing NULL as cred:
> > 1. arch/powerpc/xmon/xmon.c
> >      Here the hook seems to be called from non-task context and is only
> >      used for redacting some sensitive values from output sent to
> >      userspace.
>
> It's hard to follow but it actually disables interactive use of xmon
> entirely if lockdown is in confidentiality mode, and disables
> modifications of the kernel in integrity mode.
>
> But that's not really that important, the patch looks fine.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks, Michael!

James/Paul, is there anything blocking this patch from being merged?
Especially the BPF case is causing real trouble for people and the
only workaround is to broadly allow lockdown::confidentiality in the
policy.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

