Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D927B564C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbjJBPcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbjJBPcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:32:48 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9933B3;
        Mon,  2 Oct 2023 08:32:44 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7ab68ef45e7so5088798241.3;
        Mon, 02 Oct 2023 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696260764; x=1696865564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uClni+UffmmYTuy1hPAFIlwBMSb8VjQU0Au+7tp7fWY=;
        b=cgT3Qq/VO9qCl+zYg70pE2Gp2JGmyle4zfOPAAqW3DBDgva0qFIUrKkLQGZqu9+/Vd
         xtQ2bbFdH3Ebx7lN8VaIM9yvXgNRKjuZJi89ZAShJqX4l9avJ+vzqWgVTKr3pB7pvCJ2
         Ks2/t9vO0XDwAcDoCsfIktDxNUc4SNSheLBjpJcNHtDhndwZEYnlf1Kx9RcGZ67lc8x4
         EkIvGx5hIC5IFgT7uOxxqbNZHwCHgbdsx9ngyryggPibW8AHASugyzBYzu6EAAz1whoL
         x0Hv8B5avKw6aS1RK6/d8GdYcIX1/wYUZuWwCPgBzDQ4csmr7JX/v5NljzrobaxfU1pO
         Zcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260764; x=1696865564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uClni+UffmmYTuy1hPAFIlwBMSb8VjQU0Au+7tp7fWY=;
        b=hDcO2cloMSocWaGN+/MXeFGTYzeokC2A/JvMU27Coa6VXYJGss4NLr+BJ0nVjmKD2t
         ESy5w11DbipLeWKQ4YDfWwjm5LeHodlRAyR61YxkxRUNF7jXUVqFf75HPKlA/6METqKl
         vGK6ORirvQNmxFsYTEAWZU/RpqX+bzHPhtI1nevj4PTjPcNESYc6f3s/CIe0RyxzdFZj
         ChaLyS9n5H5DqjfYB53uxvHQIfazx1v7vYDYu8srLORFH29WO1R303deEGRvMD8wqMiU
         vIiQB14IpeqolGcZ80TwR+PxT+GvUjZr1pyiP7FW+orYYrMGm8shsF+9q5LZVGRI0oNi
         l5lA==
X-Gm-Message-State: AOJu0Yy/NdJSmbvQYnN6vhob+B2ud9m1aNF76aSdcW2tXiHKv39PIKWn
        yjiTg9tr2qi/4DiAvf7ZidznKtkaGVyWjcjhPj9F+4RVS8c=
X-Google-Smtp-Source: AGHT+IF5TKbQs/EqesVIsrB7z4OuZfaBMnnKZvX5LpPDaXoWCwhwhKWtUE7Do87EF50hB3WYu564gjnysSAsfGA/bQE=
X-Received: by 2002:a05:6102:51a:b0:44e:ac98:c65d with SMTP id
 l26-20020a056102051a00b0044eac98c65dmr7242250vsa.27.1696260763734; Mon, 02
 Oct 2023 08:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <CAJfpegvDoSWPRaoa_i_Do3JDdaXrhohDtfQNObSJ7tNhhuHAKw@mail.gmail.com>
 <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
 <CAOQ4uxgk3sAubfx84FKtNSowgT-aYj0DBX=hvAApre_3a8Cq=g@mail.gmail.com> <CAJfpegtt48eXhhjDFA1ojcHPNKj3Go6joryCPtEFAKpocyBsnw@mail.gmail.com>
In-Reply-To: <CAJfpegtt48eXhhjDFA1ojcHPNKj3Go6joryCPtEFAKpocyBsnw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Oct 2023 18:32:32 +0300
Message-ID: <CAOQ4uxgARF3+LgZYeyQ+YW9aXjhrzxDOmxkiP7bMyHNsHLKP3w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Reduce impact of overlayfs fake path files
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 6:00=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 9 Jun 2023 at 16:42, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Jun 9, 2023 at 5:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > >
> > > On Fri, Jun 9, 2023 at 4:15=E2=80=AFPM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > > >
> > > > On Fri, 9 Jun 2023 at 09:32, Amir Goldstein <amir73il@gmail.com> wr=
ote:
> > > > >
> > > > > Miklos,
> > > > >
> > > > > This is the solution that we discussed for removing FMODE_NONOTIF=
Y
> > > > > from overlayfs real files.
> > > > >
> > > > > My branch [1] has an extra patch for remove FMODE_NONOTIFY, but
> > > > > I am still testing the ovl-fsnotify interaction, so we can defer
> > > > > that step to later.
> > > > >
> > > > > I wanted to post this series earlier to give more time for fsdeve=
l
> > > > > feedback and if these patches get your blessing and the blessing =
of
> > > > > vfs maintainers, it is probably better that they will go through =
the
> > > > > vfs tree.
> > > > >
> > > > > I've tested that overlay "fake" path are still shown in /proc/sel=
f/maps
> > > > > and in the /proc/self/exe and /proc/self/map_files/ symlinks.
> > > > >
> > > > > The audit and tomoyo use of file_fake_path() is not tested
> > > > > (CC maintainers), but they both look like user displayed paths,
> > > > > so I assumed they's want to preserve the existing behavior
> > > > > (i.e. displaying the fake overlayfs path).
> > > >
> > > > I did an audit of all ->vm_file  and found a couple of missing ones=
:
> > >

Hi Miklos,

Trying to get back to this.

> > > Wait, but why only ->vm_file?
>
> Because we don't get to intercept vm_ops, so anything done through
> mmaps will not go though overlayfs.   That would result in apparmor
> missing these, for example.
>

As discussed, unless we split ovl realfile to 3 variants: lower/upper/mmap
vm_file will be a backing_file and so will the read/write realfile,
sometimes the low level helpers need the real path and sometimes
then need the fake path.

> > > We were under the assumption the fake path is only needed
> > > for mapped files, but the list below suggests that it matters
> > > to other file operations as well...
> > >
> > > >
> > > > dump_common_audit_data

This is an example of a generic helper.
There is no way of knowing if it really wants the real or fake path.
It depends if the audit rule was set on ovl path or on real path,
but if audit rule was set on real path, we should not let the fake path
avert the audit, same as we should not have let the real file avert
fsnotify events.

It seems to me the audit rules are set on inodes and compare
st_dev/st_ino, so it is more likely that for operations on the realfile,
the real path makes more sense to print.

> > > > ima_file_mprotect

From the little experience I have with overlayfs and IMA,
nothing works much wrt measuring and verifying operations
on the real files.

> > > > common_file_perm (I don't understand the code enough to know whethe=
r
> > > > it needs fake dentry or not)
> > > > aa_file_perm
> > > > __file_path_perm

Same rationale as in audit.
We do not want to avert permission hooks for rules that were set
on the real inode/path, so it makes way more sense to use real path
in these common helpers.

Printing the wrong path is not as bad as not printing an audit!

> > > > print_bad_pte

I am not very concerned about printing real path in kmsg errors.
Those errors are more likely cause by underlying fs/block issues anyway?

> > > > file_path

Too low level.
Call sites that need to print the fake path can use d_path()

> > > > seq_print_user_ip

Yes.

> > > > __mnt_want_write_file
> > > > __mnt_drop_write_file
> > > > file_dentry_name

Too low level.

> > > >
> > > > Didn't go into drivers/ and didn't follow indirect calls (e.g.
> > > > f_op->fsysnc).  I also may have missed something along the way, but=
 my
> > > > guess is that I did catch most cases.
> > >
> > > Wow. So much for 3-4 special cases...
> > >
> > > Confused by some of the above.
> > >
> > > Why would we want __mnt_want_write_file on the fake path?
> > > We'd already taken __mnt_want_write on overlay and with
> > > real file we need __mnt_want_write on the real path.
>
> It's for write faults on memory maps.   The code already branches on
> file->f_mode, I don't think it would be a big performance hit to check
> FMODE_FAKE_PATH.
>

Again, FMODE_BACKING is set on the same realfile that is used
for read/write_iter. Unless you will be willing to allocate two realfiles.

I added a patch to take mnt_writers refcount for both fake and real path
for writable file.
Page faults only need to take freeze protection on real sb. no?

> > >
> > > For IMA/LSMs, I'd imagine that like fanotify, they would rather get
> > > the real path where the real policy is stored.
> > > If some log files end with relative path instead of full fake path
> > > it's probably not the worst outcome.
> > >
> > > Thoughts?
> >
> > Considering the results of your audit, I think I prefer to keep
> > f_path fake and store real_path in struct file_fake for code
> > that wants the real path.
> >
> > This will keep all logic unchanged, which is better for my health.
> > and only fsnotify (for now) will start using f_real_path() to
> > generate events on real fs objects.
>
> That's also an option.
>
> I think f_fake_path() would still be a move in the right direction.
> We have 46 instances of file_dentry() currently and of those special
> cases most are cosmetic, while missing file_dentry() ones are
> crashable.
>

Here is what I have so far:

https://github.com/amir73il/linux/commits/ovl_fake_path

I tested it with fstests and nothing popped up.
If this looks like a good start to you, I can throw it at linux-next and
see and anything floats.

Thanks,
Amir.
