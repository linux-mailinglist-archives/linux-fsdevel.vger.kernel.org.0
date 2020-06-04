Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277441EEA91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgFDSwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 14:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgFDSwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:52:03 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0962C08C5C0;
        Thu,  4 Jun 2020 11:52:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a21so6007957oic.8;
        Thu, 04 Jun 2020 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wZxQ2ZYTUXj6H4A/fAYu04YU+AVtihyuBKgDVRw7Dg=;
        b=Eqp6HF106HdaJQCMM+MYN1Iag55bBz6XgbmJ4Rm+khvXbF3EW/YGZnt5wSvXmnOXV+
         PTG0zUud87zStyGqsE6yQ4+OYSUEwySxI/JnIzd/UJSsLBfcrV8Ozp8HdrRXMuOL7hm6
         cKAPs5iOW6Ou+IALHz+4AjrXFUjZLxqF5a77thdclvBo5CEipnfaHAA7/iHa8hXVdSRB
         HVCgTkhFbk5Sy4N16Lt8aPmsOu53xRuTM++U+gtRPPMAkMn95kECiKFKPweWrA+gYcCC
         rD/QdTrM0c6/m1Pg7Nw9vxqQ9C4HqHTpGTDslhPq19VHW1Rn/QcmeGA+WUVoVuIbyLOc
         Xx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wZxQ2ZYTUXj6H4A/fAYu04YU+AVtihyuBKgDVRw7Dg=;
        b=DaWyPJTckb7qy1hZHUy/VBS5X2nfUd5jzLsZ3RigWGNsXnVBbdc74iGr8PqwaMwnhy
         Wn6WPdUlm+e9y8Jr52hkGa2lyNvE4nUkVya18dRlBjbeVGavyqTuzvC+7UPsdYca0c1a
         Q5xhoda6Fh+YocHawJHAMlR9gm99Qe/XuYwdvkp7bdCC0MS5Ybrtzbi7cC1CajKkTQJp
         5x2lXjL+aMZEuwEp/Idmj24AGKrCV/Mt3lZmQ0P8LQegrMTt6O/s45azJ1Iv3fCtH/oW
         E+puIyFbXm4gFaIIyMTmF60m2VN9Nr2z62tTwjzDXmFXNru7TQbcphEBBVFHKYATfFAu
         HpQg==
X-Gm-Message-State: AOAM531S2jLRZ+hPJrpjf058UMiqTdP6AVJGGAujwZVqsVoBf2jnJ4VB
        RYaMQKONjGt3VSdOllFel27y78y4NiUzNPWE0EHMT9sY
X-Google-Smtp-Source: ABdhPJxn3lSKV7CojeVjAyCPOlId/gXxk16z216+OIfdv+TZra7z0yINDq7DlAdQ8TogaDU/9ZC5XOvBb3vs4jP5I5M=
X-Received: by 2002:aca:a948:: with SMTP id s69mr4146936oie.140.1591296723348;
 Thu, 04 Jun 2020 11:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
 <alpine.LRH.2.21.2006041354381.1812@namei.org>
In-Reply-To: <alpine.LRH.2.21.2006041354381.1812@namei.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Jun 2020 14:51:52 -0400
Message-ID: <CAEjxPJ4GvTXQY_BzLugnrXrPnehqwnmqxn21mjVDhpk4kYV3Aw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     James Morris <jmorris@namei.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 3, 2020 at 11:59 PM James Morris <jmorris@namei.org> wrote:
>
> On Wed, 1 Apr 2020, Daniel Colascione wrote:
>
> > Daniel Colascione (3):
> >   Add a new LSM-supporting anonymous inode interface
> >   Teach SELinux about anonymous inodes
> >   Wire UFFD up to SELinux
> >
> >  fs/anon_inodes.c                    | 191 ++++++++++++++++++++++------
> >  fs/userfaultfd.c                    |  30 ++++-
> >  include/linux/anon_inodes.h         |  13 ++
> >  include/linux/lsm_hooks.h           |  11 ++
> >  include/linux/security.h            |   3 +
> >  security/security.c                 |   9 ++
> >  security/selinux/hooks.c            |  53 ++++++++
> >  security/selinux/include/classmap.h |   2 +
> >  8 files changed, 267 insertions(+), 45 deletions(-)
>
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git secure_uffd_v5.9
> and next-testing.
>
> This will provide test coverage in linux-next, as we aim to get this
> upstream for v5.9.
>
> I had to make some minor fixups, please review.

LGTM and my userfaultfd test case worked.
