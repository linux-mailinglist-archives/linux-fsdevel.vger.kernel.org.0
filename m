Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335D629F1A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 17:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgJ2QgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJ2QgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:36:17 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B46C0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 09:36:16 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v18so3713076ilg.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+1FzFFklP1YnmghHH9t5lyMT4QSfeCr4QK0lMLwAvZE=;
        b=ipmMYI2Zt/qFpfzA3A9nrn+MY99z/pArhalXX282jU89E0zmQx8CrbLcgUJ0+4BBYr
         gOYagLL2brYfKfSk0M5bDwNOwtJPX2R0TTPBFpS1s+gFhezEv2lm2yr3dsX1V9pnC8ie
         xjQ02ffBZ46hYZ46v5xkCdBsw/A1eNnXgRfJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1FzFFklP1YnmghHH9t5lyMT4QSfeCr4QK0lMLwAvZE=;
        b=QCh5nszcRuujfdp/59GHihaMYOPq0JVz0dSJWP0ty73tUN1+6dKlq0rEA2G7V4BDY6
         ZRuWUBGNHF2yvXZuvihw/SokFRcae8g8UXxGq4TYk2fG2HKOeKxawUH9KqOc0PouyUmV
         xUtOwbMWE4v40Ados8yY18kGmbkh9QiS2Lta6G8k0r1BQ+ETqhobcH2YxCj9mgpSQxia
         47t/egU+jzxXBr4AU8MoTnHDFZnGIt2JlsCV6ItDYQ4SCCEgBBmgiJ4hrBO5UYgqSmnN
         JgLJYirLb44Q8Qi3twdjHz1VYH8GOW1gJMbeh80nTC8JN59usF75wx8/0yKeG4xU85zp
         ejbQ==
X-Gm-Message-State: AOAM5310a5u19/SkDnkVnsH2LeCYCMCVC+lQtu3wWtRdUBHMSoe4MTcl
        +995CtNK7KSchKfT5/kCACZHgQ==
X-Google-Smtp-Source: ABdhPJwdjJsI8P3ncUgKVI0MZeddl6/4SUR4eqZ1yA/w3w9keNoMZjKAVre0rxJASmFJuoRVIJjAng==
X-Received: by 2002:a92:c7c7:: with SMTP id g7mr3777623ilk.303.1603989375791;
        Thu, 29 Oct 2020 09:36:15 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id t6sm2275768ilk.5.2020.10.29.09.36.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 09:36:14 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:36:13 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Lennart Poettering <lennart@poettering.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
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
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Message-ID: <20201029163612.GA15275@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org>
 <20201029160502.GA333141@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029160502.GA333141@gardel-login>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 05:05:02PM +0100, Lennart Poettering wrote:
> On Do, 29.10.20 10:47, Eric W. Biederman (ebiederm@xmission.com) wrote:
> 
> > Is that the use case you are looking at removing the need for
> > systemd-homed to avoid chowning after lugging encrypted home directories
> > from one system to another?  Why would it be desirable to avoid the
> > chown?
> 
> Yes, I am very interested in seeing Christian's work succeed, for the
> usecase in systemd-homed. In systemd-homed each user gets their own
> private file system, and these fs shall be owned by the user's local
> UID, regardless in which system it is used. The UID should be an
> artifact of the local, individual system in this model, and thus
> the UID on of the same user/home on system A might be picked as 1010
> and on another as 1543, and on a third as 1323, and it shouldn't
> matter. This way, home directories become migratable without having to
> universially sync UID assignments: it doesn't matter anymore what the
> local UID is.
> 
> Right now we do a recursive chown() at login time to ensure the home
> dir is properly owned. This has two disadvantages:
> 
> 1. It's slow. In particular on large home dirs, it takes a while to go
>    through the whole user's homedir tree and chown/adjust ACLs for
>    everything.
> 
> 2. Because it is so slow we take a shortcut right now: if the
>    top-level home dir inode itself is owned by the correct user, we
>    skip the recursive chowning. This means in the typical case where a
>    user uses the same system most of the time, and thus the UID is
>    stable we can avoid the slowness. But this comes at a drawback: if
>    the user for some reason ends up with files in their homedir owned
>    by an unrelated user, then we'll never notice or readjust.
> 
> > If the goal is to solve fragmented administration of uid assignment I
> > suggest that it might be better to solve the administration problem so
> > that all of the uids of interest get assigned the same way on all of the
> > systems of interest.
> 
> Well, the goal is to make things simple and be able to use the home
> dir everywhere without any prior preparation, without central UID
> assignment authority.
> 
> The goal is to have a scheme that requires no administration, by
> making the UID management problem go away. Hence, if you suggest
> solving this by having a central administrative authority: this is
> exactly what the model wants to get away from.
> 
> Or to say this differently: just because I personally use three
> different computers, I certainly don't want to set up LDAP or sync
> UIDs manually.
> 
> Lennart
> 
> --
> Lennart Poettering, Berlin

Can you help me understand systemd-homed a little bit?

In the man page it says:

systemd-homed is a system service that may be used to create, remove, change or 
inspect home areas (directories and network mounts and real or loopback block 
devices with a filesystem, optionally encrypted).

It seems that the "underlay?" (If you'll call it that, maybe there is a better 
term) can either be a standalone block device (this sounds close to systemd 
machined?), a btrfs subvolume (which receives its own superblock (IIRC?, I might 
be wrong. It's been a while since I've used btrfs), or just be a directory 
that's mapped?

What decides whether it's just a directory and bind-mounted (or a similar 
vfsmount), or an actual superblock?

How is the mapping of "real UIDs" to "namespace UIDs" works when it's just a 
bind mount? From the perspective of multiple user namespaces, are all 
"underlying" UIDs mapped through, or if I try to look at another user's
home directory will they not show up?

Is there a reason you can't / don't / wont use overlayfs instead of bind mounts?
