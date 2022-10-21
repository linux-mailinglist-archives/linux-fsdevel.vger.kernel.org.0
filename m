Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C8607BAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJUQCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJUQCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:02:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F70B24F26
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Oct 2022 09:02:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l22so7598309edj.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Oct 2022 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ulcgqfpwe5bk/eAYY7jFuAY+uHNV+yMGk/I3pwXYiBM=;
        b=mpeT3F4aKSvTHRJ+eHUhFTWE+O98RyxB2/9pRoV++ZDdr+qL1IeAWj3Md2yD/aeoWW
         S4B04gVfZNIRm6jLo10Z5RNbe/O5fa/QVRobDx1BO2YLxGoGNfMLafcFvA8aGHwywUNt
         aRxjd17GBJHSCh582oMOjGeDKbsDEYVWaT2Cv9+JgsSLS6ynEVwINVuDjWwnMUywOEb6
         n+pHMUGXnM7kAfCzifPuRo7nbeCPmwpaU90T+BIfp/xQ7IQ4toImdtVAxLdHl+ty9z+Q
         TtMNhr/J5P0KzBmEbMEnXSppv2ahqoIK46s8ctSNxqd8lUbOGlcDsdhKjMqBiBh6MlgG
         /q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulcgqfpwe5bk/eAYY7jFuAY+uHNV+yMGk/I3pwXYiBM=;
        b=wvh5EF0gbyZKKr7G+Ji+ApAmv+IioPkiO0UXVxShXcR+IVxOfUdym90KPGv4/vbEZr
         iaPNbCs3To9JfBiUetsFoZ7l1cQ0I9JTOSfA6A+e4PqhujiO2CXDy6IqgHXYopnukr0z
         5nuS8RSTP6ppEjsCmsdPUw6Q86WQe9SRvVNEySNEgxFgRWyhB6YC/qBcHVIcmvqxLdeB
         zJqZPPvJwbi8EYonzV5Kx8gRD9f6EBuPDnW2WZZi1znB+G4PLjfUfu4Ao+yQEh/6buT5
         jUMg6NzVAujBjSdh1vuMNv9xxicrLjvjyVYHlD9PwYWwTWIC6bjTyknQh/gPsya4UWag
         2oVA==
X-Gm-Message-State: ACrzQf1d1xclcCYQhjAxbkhn6nelEZUndaF5buHnmDDSxsSuLj0mxN9P
        5v0mN4nGacNTgh9qwKptwsi64VLt7mqm4OGvLlQ=
X-Google-Smtp-Source: AMsMyM5aM3hCEYSChal8ZQNK7iGD5yaNtCln6w9Zx9i1mUJRQeelTPuGvUkpk0AewmECBJRQ17jPjJmQqiHt9aIUd5M=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr6893801edq.14.1666368162955; Fri, 21 Oct
 2022 09:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221020201409.1815316-1-davemarchevsky@fb.com> <20221021080902.cshha2dja73wuojr@wittgenstein>
In-Reply-To: <20221021080902.cshha2dja73wuojr@wittgenstein>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 09:02:30 -0700
Message-ID: <CAEf4Bzbp6cMiSWBLxzXT5AT=X-cidnnx9GU6op_MnXvRH+7T3w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Rearrange fuse_allow_current_process checks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022 at 1:09 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Oct 20, 2022 at 01:14:09PM -0700, Dave Marchevsky wrote:
> > This is a followup to a previous commit of mine [0], which added the
> > allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
> > rearranges the order of checks in fuse_allow_current_process without
> > changing functionality.
> >
> > [0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
> > beginning of the function, with the reasoning that
> > allow_sys_admin_access should be an 'escape hatch' for users with
> > CAP_SYS_ADMIN, allowing them to skip any subsequent checks.
> >
> > However, placing this new check first results in many capable() calls when
> > allow_sys_admin_access is set, where another check would've also
> > returned 1. This can be problematic when a BPF program is tracing
> > capable() calls.
> >
> > At Meta we ran into such a scenario recently. On a host where
> > allow_sys_admin_access is set but most of the FUSE access is from
> > processes which would pass other checks - i.e. they don't need
> > CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
> > call for each fs op. We also have a daemon tracing capable() with BPF and
> > doing some data collection, so tracing these extraneous capable() calls
> > has the potential to regress performance for an application doing many
> > FUSE ops.
> >
> > So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
> > hatch' is checked last. Previously, if allow_other is set on the
> > fuse_conn, uid/gid checking doesn't happen as current_in_userns result
> > is returned. It's necessary to add a 'goto' here to skip past uid/gid
> > check to maintain those semantics here.
> >
> >   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > ---
>
> The idea sounds good.
>
> > v1 -> v2: lore.kernel.org/linux-fsdevel/20221020183830.1077143-1-davemarchevsky@fb.com
> >
> >   * Add missing brackets to allow_other if statement (Andrii)
> >
> >  fs/fuse/dir.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 2c4b08a6ec81..2f14e90907a2 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1254,11 +1254,11 @@ int fuse_allow_current_process(struct fuse_conn *fc)
> >  {
> >       const struct cred *cred;
> >
> > -     if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> > -             return 1;
> > -
> > -     if (fc->allow_other)
> > -             return current_in_userns(fc->user_ns);
> > +     if (fc->allow_other) {
> > +             if (current_in_userns(fc->user_ns))
> > +                     return 1;
> > +             goto skip_cred_check;
>
> I think this is misnamed especially because capabilities are creds as
> well. Maybe we should not use a goto even if it makes the patch a bit
> bigger (_completely untested_)?:
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index bb97a384dc5d..3d733e0865bf 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1235,6 +1235,28 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
>         return err;
>  }
>
> +static inline bool fuse_permissible_uidgid(const struct fuse_conn *fc)
> +{
> +       cred = current_cred();
> +       return (uid_eq(cred->euid, fc->user_id) &&
> +               uid_eq(cred->suid, fc->user_id) &&
> +               uid_eq(cred->uid,  fc->user_id) &&
> +               gid_eq(cred->egid, fc->group_id) &&
> +               gid_eq(cred->sgid, fc->group_id) &&
> +               gid_eq(cred->gid,  fc->group_id))
> +}
> +
> +static inline bool fuse_permissible_other(const struct fuse_conn *fc)
> +{
> +       if (current_in_userns(fc->user_ns))
> +               return true;
> +
> +       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> +               return true;

This needs to be checked regardless of fc->allow_other, so the change
you are proposing is not equivalent to the original logic. It does
seem like a simple goto is a cleaner approach in this particular case.

> +
> +       return false;
> +}
> +
>  /*
>   * Calling into a user-controlled filesystem gives the filesystem
>   * daemon ptrace-like capabilities over the current process.  This
> @@ -1250,24 +1272,10 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
>   */
>  int fuse_allow_current_process(struct fuse_conn *fc)
>  {
> -       const struct cred *cred;
> -
> -       if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
> -               return 1;
> -
>         if (fc->allow_other)
> -               return current_in_userns(fc->user_ns);
> -
> -       cred = current_cred();
> -       if (uid_eq(cred->euid, fc->user_id) &&
> -           uid_eq(cred->suid, fc->user_id) &&
> -           uid_eq(cred->uid,  fc->user_id) &&
> -           gid_eq(cred->egid, fc->group_id) &&
> -           gid_eq(cred->sgid, fc->group_id) &&
> -           gid_eq(cred->gid,  fc->group_id))
> -               return 1;
> +               return fuse_permissible_other(fc);
>
> -       return 0;
> +       return fuse_permissible_uidgid(fc);
>  }
>
>  static int fuse_access(struct inode *inode, int mask)
>
