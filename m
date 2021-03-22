Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71FB343695
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 03:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVCU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 22:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVCUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:20:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C143C061574;
        Sun, 21 Mar 2021 19:20:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a198so18829773lfd.7;
        Sun, 21 Mar 2021 19:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAHZNIYSi0F1MV0vcwk809LdQrlgjxs53TwNlXuiDLI=;
        b=UerhiW+BWw9+1uBAlT7e7HZcDydSEC/UvjsujJ5fnYeYCtB18GqUe4igxjBa9U2Eu/
         aTX3+cyO9OdCfLigWF1o8iE/19oj+KkgdM/tnFs+rWsqZCJlv49xR9zcexKgzHXf/vw+
         njyTU+VYLzBVeMcjv363pZSyX13XrfLekSkYOrExmUWaneeTeS1E6ePGSjTYc1jAHRSb
         FlOPSZp4vLu+JLWWU5fcQUvPhVc236To4K6NIQyAm0v6vhNSFeXX/15TJriobkvD/9Jk
         OGHv9vaizgOoKlekamc+LZB+nyamTpMp8BcvUUTOmZnsE5yNAendp8mmOiGTrEosEC51
         eo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAHZNIYSi0F1MV0vcwk809LdQrlgjxs53TwNlXuiDLI=;
        b=Ezf8lR+Z7EajJc5+2EfRfEF6cp1iK0hTR9+vfJR9eoU2jIZBguZhgolxppzYCmkJUf
         /I+J9W2pzrny7qJXLsyKdRmHUfmVjhwIgp8PoxwqG+d339QaRDcQNUUgXhdpFj80P2kc
         mkjaeDrp6EvUZMhqjFWlECbtOUUmWwECQxO8tiiZcsE8xqYDx7jwpIvYosazJYoAH0x6
         tUWxchbcDjf1e95xcMVFkLnsEt5KAPE28pTXZ69xhTy4Ttzw5gMc2UmSbIcAJepX5Mso
         EcmCCoGtgMt2J09pQBWn8d44JvIL506rC6wvRv0nvNHvvbHb7vc99gHCw41A7GWsm4CF
         cVjQ==
X-Gm-Message-State: AOAM532NxZoRXN01IucQhhGcuWXmYjC+Az/GQ1DJ/HyV8QgmNPmSmBVS
        UQUYawQO4WEVvevNWFcXi06XlVghdOyMF0Hj06rPwK3KL9jvOg==
X-Google-Smtp-Source: ABdhPJwL2G5G9OuAdt0S6mUqLlgd+qR1m8S393PHyiFtKfXe0Qyfs1mBBQWn1188WesNVNYbTtXLjADio9e9DD05apY=
X-Received: by 2002:a19:7515:: with SMTP id y21mr7818752lfe.282.1616379604757;
 Sun, 21 Mar 2021 19:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk> <CAH2r5mvA0WeeV1ZSW4HPvksvs+=GmkiV5nDHqCRddfxkgPNfXA@mail.gmail.com>
In-Reply-To: <CAH2r5mvA0WeeV1ZSW4HPvksvs+=GmkiV5nDHqCRddfxkgPNfXA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 21 Mar 2021 21:19:53 -0500
Message-ID: <CAH2r5msWJn5a7JCUdoyJ7nfyeafRS8TvtgF+mZCY08LBf=9LAQ@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

automated tests failed so will need to dig in a little more and see
what is going on

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/533

On Sun, Mar 21, 2021 at 2:58 PM Steve French <smfrench@gmail.com> wrote:
>
> WIll run the automated tests on these.
>
> Also FYI - patches 2 and 6 had some checkpatch warnings (although fairly minor).
>
> On Fri, Mar 19, 2021 at 11:36 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Patch series (#work.cifs in vfs.git) tries to clean the things
> > up in and around build_path_from_dentry().  Part of that is constifying
> > the pointers around that stuff, then it lifts the allocations into
> > callers and finally switches build_path_from_dentry() to using
> > dentry_path_raw() instead of open-coding it.  Handling of ->d_name
> > and friends is subtle enough, and it would be better to have fewer
> > places besides fs/d_path.c that need to mess with those...
> >
> >         Help with review and testing would be very much appreciated -
> > there's a plenty of mount options/server combinations ;-/
> >
> >         For those who prefer to look at it in git, it lives in
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.cifs;
> > individual patches go in followups.
> >
> > Shortlog:
> > Al Viro (7):
> >       cifs: don't cargo-cult strndup()
> >       cifs: constify get_normalized_path() properly
> >       cifs: constify path argument of ->make_node()
> >       cifs: constify pathname arguments in a bunch of helpers
> >       cifs: make build_path_from_dentry() return const char *
> >       cifs: allocate buffer in the caller of build_path_from_dentry()
> >       cifs: switch build_path_from_dentry() to using dentry_path_raw()
> >
> > 1) a bunch of kstrdup() calls got cargo-culted as kstrndup().
> > This is unidiomatic *and* pointless - it's not any "safer"
> > that way (pass it a non-NUL-terminated array, and strlen()
> > will barf same as kstrdup()) and it's actually a pessimization.
> > Converted to plain kstrdup() calls.
> >
> > 2) constifying pathnames: get_normalized_path() gets a
> > constant string and, on success, returns either that string
> > or its modified copy.  It is declared with the wrong prototype -
> > int get_normalized_path(const char *path, char **npath)
> > so the caller might get a non-const alias of the original const
> > string.  Fortunately, none of the callers actually use that
> > alias to modify the string, so it's not an active bug - just
> > the wrong typization.
> >
> > 3) constifying pathnames: ->make_node().  Unlike the rest of
> > methods that take pathname as an argument, it has that argument
> > declared as char *, not const char *.  Pure misannotation,
> > since all instances never modify that actual string (or pass it
> > to anything that might do the same).
> >
> > 4) constifying pathnames: a bunch of helpers.  Several functions
> > have pathname argument declared as char *, when const char *
> > would be fine - they neither modify the string nor pass it to
> > anything that might.
> >
> > 5) constifying pathnames: build_path_from_dentry().
> > That's the main source of pathnames; all callers are actually
> > treating the string it returns as constant one.  Declare it
> > to return const char * and adjust the callers.
> >
> > 6) take buffer allocation out of build_path_from_dentry().
> > Trying to do exact-sized allocation is pointless - allocated
> > object are short-lived anyway (the caller is always the one
> > to free the string it gets from build_path_from_dentry()).
> > As the matter of fact, we are in the same situation as with
> > pathname arguments of syscalls - short-lived allocations
> > limited to 4Kb and freed before the caller returns to userland.
> > So we can just do allocations from names_cachep and do that
> > in the caller; that way we don't need to bother with GFP_ATOMIC
> > allocations.  Moreover, having the caller do allocations will
> > permit us to switch build_path_from_dentry() to use of dentry_path_raw()
> > (in the next commit).
> >
> > 7) build_path_from_dentry() essentially open-codes dentry_path_raw();
> > the difference is that it wants to put the result in the beginning
> > of the buffer (which we don't need anymore, since the caller knows
> > what to free anyway) _and_ we might want '\\' for component separator
> > instead of the normal '/'.  It's easier to use dentry_path_raw()
> > and (optionally) post-process the result, replacing all '/' with
> > '\\'.  Note that the last part needs profiling - I would expect it
> > to be noise (we have just formed the string and it's all in hot cache),
> > but that needs to be verified.
> >
> > Diffstat:
> >  fs/cifs/cifs_dfs_ref.c |  14 +++--
> >  fs/cifs/cifsglob.h     |   2 +-
> >  fs/cifs/cifsproto.h    |  19 +++++--
> >  fs/cifs/connect.c      |   9 +--
> >  fs/cifs/dfs_cache.c    |  41 +++++++-------
> >  fs/cifs/dir.c          | 148 ++++++++++++++++++-------------------------------
> >  fs/cifs/file.c         |  79 +++++++++++++-------------
> >  fs/cifs/fs_context.c   |   2 +-
> >  fs/cifs/inode.c        | 110 ++++++++++++++++++------------------
> >  fs/cifs/ioctl.c        |  13 +++--
> >  fs/cifs/link.c         |  46 +++++++++------
> >  fs/cifs/misc.c         |   2 +-
> >  fs/cifs/readdir.c      |  15 ++---
> >  fs/cifs/smb1ops.c      |   6 +-
> >  fs/cifs/smb2ops.c      |  19 ++++---
> >  fs/cifs/unc.c          |   4 +-
> >  fs/cifs/xattr.c        |  40 +++++++------
> >  17 files changed, 278 insertions(+), 291 deletions(-)
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
