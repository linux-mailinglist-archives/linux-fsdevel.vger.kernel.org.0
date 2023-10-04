Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3B7B8398
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjJDPaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 11:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjJDPaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:30:13 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569793;
        Wed,  4 Oct 2023 08:30:08 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7ab9ad973e6so979447241.1;
        Wed, 04 Oct 2023 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696433408; x=1697038208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftMNMq2htFDP9N3sdfhxNDUb0xEGe1c59oVAsNzZV8g=;
        b=h2yKo8XwyPTvR4MPaItZGCICAXheUmX1Y6mVMEfaKgpPSGAmwl9SKoODW1INCiztiI
         YhuzTUtRA586kPFlqvLmsEo5+ZiEg5c+TtiN9HrjMuAhyxwnXPDxmosY4ID2Vo+s/L3L
         V9Qqhgu2/9vKgW5j6sRwn7d6nCwsJPQ7TeGSNDlSDhvl5ZfSRPZJ0F0Emxs96o+J0nXh
         Rj4iH2OBZpnTCOX9O4U29D/TilkNjcaddzwlQsvdPXVE3GeAv8SbTwT4gfKim6+TsXEM
         Im7NLbbIQHJ7Zv2HMXubmzAVLddpHj+jhiJdPEIup6QijzVUaeb1c67Tr2B4kgaD3k2p
         UkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696433408; x=1697038208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftMNMq2htFDP9N3sdfhxNDUb0xEGe1c59oVAsNzZV8g=;
        b=vPiWzu8s1ZINCHJYXQbFnSADaK61/XFfV8mhbP3mGqelILmN9PTKZrzeqis65OlkIJ
         97o0hl76kOrlx7IYpPb+iMYjz6x9vRvOlFd8yvYnFNZ4unV5h7jJ+3tUMP45mdY4+6y8
         IZTlpMso6MccoEjOWbb9eARdHGm3W9Cb0k1dE+PYrR+00KWBbbGKKkCEq5vRPP7srJsD
         t26KWh/DAeigPXpfvDOLdgeyZfspwg65ZDgE12ZwtRG0tvD0Szw5LyKiVJU9cCKl9OhB
         HR0sT7mQ3Bnh0EnyzJfJwngNsUPtu514haZwYLTLyx3ScNnpNVrT3s44lVFA3mYghvOq
         l3Uw==
X-Gm-Message-State: AOJu0YywPD4hf6bmNrl2C2tmyabJCEGUSTN/PHEjJhZgUvnCahpzfgIc
        8mhDOoQ6J4Mm6rD8GmuKupuofDvn8xQl9jjjRHo=
X-Google-Smtp-Source: AGHT+IFOW5xPW/nPbX5ZaP1c/TYbo5bolJqTNpcobEqrnMhEKXYYxnt5/LKeQ7HF93MpqjbuFVg/xAB0zrD81f2gEr4=
X-Received: by 2002:a67:f292:0:b0:452:c5b5:e666 with SMTP id
 m18-20020a67f292000000b00452c5b5e666mr2751996vsk.34.1696433407771; Wed, 04
 Oct 2023 08:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <CAJfpegvDoSWPRaoa_i_Do3JDdaXrhohDtfQNObSJ7tNhhuHAKw@mail.gmail.com>
 <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
 <CAOQ4uxgk3sAubfx84FKtNSowgT-aYj0DBX=hvAApre_3a8Cq=g@mail.gmail.com>
 <CAJfpegtt48eXhhjDFA1ojcHPNKj3Go6joryCPtEFAKpocyBsnw@mail.gmail.com> <CAOQ4uxgARF3+LgZYeyQ+YW9aXjhrzxDOmxkiP7bMyHNsHLKP3w@mail.gmail.com>
In-Reply-To: <CAOQ4uxgARF3+LgZYeyQ+YW9aXjhrzxDOmxkiP7bMyHNsHLKP3w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Oct 2023 18:29:56 +0300
Message-ID: <CAOQ4uxi0cD5McnGu3T3OWEaGymh38rNZ3bdjJJSmrrMO7pYnnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Reduce impact of overlayfs fake path files
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
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

On Mon, Oct 2, 2023 at 6:32=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Jun 9, 2023 at 6:00=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Fri, 9 Jun 2023 at 16:42, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Fri, Jun 9, 2023 at 5:28=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > > >
> > > > On Fri, Jun 9, 2023 at 4:15=E2=80=AFPM Miklos Szeredi <miklos@szere=
di.hu> wrote:
> > > > >
> > > > > On Fri, 9 Jun 2023 at 09:32, Amir Goldstein <amir73il@gmail.com> =
wrote:
> > > > > >
> > > > > > Miklos,
> > > > > >
> > > > > > This is the solution that we discussed for removing FMODE_NONOT=
IFY
> > > > > > from overlayfs real files.
> > > > > >
> > > > > > My branch [1] has an extra patch for remove FMODE_NONOTIFY, but
> > > > > > I am still testing the ovl-fsnotify interaction, so we can defe=
r
> > > > > > that step to later.
> > > > > >
> > > > > > I wanted to post this series earlier to give more time for fsde=
vel
> > > > > > feedback and if these patches get your blessing and the blessin=
g of
> > > > > > vfs maintainers, it is probably better that they will go throug=
h the
> > > > > > vfs tree.
> > > > > >
> > > > > > I've tested that overlay "fake" path are still shown in /proc/s=
elf/maps
> > > > > > and in the /proc/self/exe and /proc/self/map_files/ symlinks.
> > > > > >
> > > > > > The audit and tomoyo use of file_fake_path() is not tested
> > > > > > (CC maintainers), but they both look like user displayed paths,
> > > > > > so I assumed they's want to preserve the existing behavior
> > > > > > (i.e. displaying the fake overlayfs path).
> > > > >
> > > > > I did an audit of all ->vm_file  and found a couple of missing on=
es:
> > > >
>
> Hi Miklos,
>
> Trying to get back to this.
>
> > > > Wait, but why only ->vm_file?
> >
> > Because we don't get to intercept vm_ops, so anything done through
> > mmaps will not go though overlayfs.   That would result in apparmor
> > missing these, for example.
> >
>
> As discussed, unless we split ovl realfile to 3 variants: lower/upper/mma=
p
> vm_file will be a backing_file and so will the read/write realfile,
> sometimes the low level helpers need the real path and sometimes
> then need the fake path.
>
> > > > We were under the assumption the fake path is only needed
> > > > for mapped files, but the list below suggests that it matters
> > > > to other file operations as well...
> > > >
> > > > >
> > > > > dump_common_audit_data
>
> This is an example of a generic helper.
> There is no way of knowing if it really wants the real or fake path.
> It depends if the audit rule was set on ovl path or on real path,
> but if audit rule was set on real path, we should not let the fake path
> avert the audit, same as we should not have let the real file avert
> fsnotify events.
>
> It seems to me the audit rules are set on inodes and compare
> st_dev/st_ino, so it is more likely that for operations on the realfile,
> the real path makes more sense to print.
>
> > > > > ima_file_mprotect
>
> From the little experience I have with overlayfs and IMA,
> nothing works much wrt measuring and verifying operations
> on the real files.
>
> > > > > common_file_perm (I don't understand the code enough to know whet=
her
> > > > > it needs fake dentry or not)
> > > > > aa_file_perm
> > > > > __file_path_perm
>
> Same rationale as in audit.
> We do not want to avert permission hooks for rules that were set
> on the real inode/path, so it makes way more sense to use real path
> in these common helpers.
>
> Printing the wrong path is not as bad as not printing an audit!
>
> > > > > print_bad_pte
>
> I am not very concerned about printing real path in kmsg errors.
> Those errors are more likely cause by underlying fs/block issues anyway?
>
> > > > > file_path
>
> Too low level.
> Call sites that need to print the fake path can use d_path()
>
> > > > > seq_print_user_ip
>
> Yes.
>
> > > > > __mnt_want_write_file
> > > > > __mnt_drop_write_file
> > > > > file_dentry_name
>
> Too low level.
>
> > > > >
> > > > > Didn't go into drivers/ and didn't follow indirect calls (e.g.
> > > > > f_op->fsysnc).  I also may have missed something along the way, b=
ut my
> > > > > guess is that I did catch most cases.
> > > >
> > > > Wow. So much for 3-4 special cases...
> > > >
> > > > Confused by some of the above.
> > > >
> > > > Why would we want __mnt_want_write_file on the fake path?
> > > > We'd already taken __mnt_want_write on overlay and with
> > > > real file we need __mnt_want_write on the real path.
> >
> > It's for write faults on memory maps.   The code already branches on
> > file->f_mode, I don't think it would be a big performance hit to check
> > FMODE_FAKE_PATH.
> >
>
> Again, FMODE_BACKING is set on the same realfile that is used
> for read/write_iter. Unless you will be willing to allocate two realfiles=
.
>
> I added a patch to take mnt_writers refcount for both fake and real path
> for writable file.
> Page faults only need to take freeze protection on real sb. no?
>
> > > >
> > > > For IMA/LSMs, I'd imagine that like fanotify, they would rather get
> > > > the real path where the real policy is stored.
> > > > If some log files end with relative path instead of full fake path
> > > > it's probably not the worst outcome.
> > > >
> > > > Thoughts?
> > >
> > > Considering the results of your audit, I think I prefer to keep
> > > f_path fake and store real_path in struct file_fake for code
> > > that wants the real path.
> > >
> > > This will keep all logic unchanged, which is better for my health.
> > > and only fsnotify (for now) will start using f_real_path() to
> > > generate events on real fs objects.
> >
> > That's also an option.
> >
> > I think f_fake_path() would still be a move in the right direction.
> > We have 46 instances of file_dentry() currently and of those special
> > cases most are cosmetic, while missing file_dentry() ones are
> > crashable.
> >
>
> Here is what I have so far:
>
> https://github.com/amir73il/linux/commits/ovl_fake_path
>
> I tested it with fstests and nothing popped up.
> If this looks like a good start to you, I can throw it at linux-next and
> see and anything floats.
>

Hi Paul,

I would like to ask for your help to confirm my theory about
"overlayfs backing files" and LSM/IMA/audit hooks.

First, let me start with some background for the audience.

An overlayfs typically has lower+upper underlying layers, let's assume
for the sake of discussion that both lower and upper are on an xfs
mount at /mnt/xfs and that overlayfs is mounted at /mnt/ovl.

When a user opens a file from overlayfs mount path, an additional
internal "backing file" is opened by overlayfs on either the lower or
upper xfs path (e.g. /mnt/xfs/lower/foo).

In this example, security_file_open() will be called for the overlayfs
file at "/mnt/ovl/foo" with user credential and then backing_file_open()
will once again call security_file_open() with the backing file at
"/mnt/xfs/lower/foo" with the stored credentials of the user that mounted
overlayfs (i.e. mounter credentials). I guess you already know this part.

The problem is that the backing file's f_path is not "/mnt/xfs/lower/foo"
but rather "/mnt/ovl/foo". It has always been this way with overlayfs
files, more or less. The reason is so users will not be exposed to the
real path via /proc/<pid>/maps. backing files are not in the process
fd table, so the real path is never exposed via /proc/<pid>/fd/.

This special condition is sometimes referred to as "fake" path -
The helper open_with_fake_path() was renamed to backing_file_open()
in commit 62d53c4a1dfe ("fs: use backing_file container for internal files
with "fake" f_path").

I knew for a long time that fsnotify hooks couldn't handle files with
fake path correctly and that is the reason that I introduced the backing_fi=
le
container and file_real_path(), so that fsnotify can get to the real path
of overlayfs backing files (e.g. "/mnt/xfs/lower/foo") and fsnotify watches
on the underlying xfs filesystem could be respected.

My theory is that all the LSM hooks as well as the non-LSM IMA/audit
hooks, always need the real path of overlayfs backing files in order to
enforce their policy and not the fake path.

Mimi has know for some time that IMA does not work well in conjunction
with overlayfs and more specifically, an IMA policy that wants to measure
all files on the underlying xfs does not work well when overlayfs is using
backing files on xfs.

For example, if ima_file_free() would sometimes use the inode file->f_inode
and sometimes use d_inode(file->f_path.dentry), very bad things would
happen because it is not the same object.

For this reason I posted this IMA patch:
https://lore.kernel.org/linux-fsdevel/20230913073755.3489676-1-amir73il@gma=
il.com/

But I don't like this solution - there are endless places that may
require this fix - I suspect that many of the LSM modules are "broken"
in the same manner when it comes to overlayfs backing files.

I would rather have backing_file f_path always be the real path and
the few places that need the fake path would opt in for it, as I've
implemented in this patch set [1].

To prove my theory that this change is correct for all LSM/audit hooks,
I audited the hooks that accept file or path arguments.

It is important to note that the security_path_* hooks are never called
by overlayfs itself on the underlying filesystem paths.

overlayfs only ever calls the vfs helpers (e.g. vfs_mkdir()) which
call the security_inode_* and security_dentry_* hooks on the underlying
filesystem objects.

Likewise, security_mmap_file() and security_file_mprotect() are also
called at the "syscall level" and overlayfs never calls any vfs helpers
that call those hooks when mmaping the backing file.
Arguably, overlayfs should call security_mmap_file() explicitly
in ovl_mmap() on the real backing file.

Other security_file_* LSM hooks may very well be called by
overlayfs when operating on the backing file, for example
security_file_permission() from ovl_read_iter() which reads from
the backing file.

But in all those security_file_* LSM hooks, just like my examples
with ima_file_free() and fsnotify_open(), there is never going to
be a case where the LSM module would care about the overlayfs
fake path, and the code is always going to be more safe if the
assumption that d_inode(file->f_path.dentry) is the same as
file->f_inode holds for overlayfs backing files.

Was I able to explain the problem?

Was I able to explain why I think that the proposed change [1]
is safe and good for all the LSM modules, IMA and audit?

Do you agree with my theory?

Would you be able to run an audit integration test and other
LSM tests if available on my branch to let me know if it breaks
anything?

I could push this to linux-next via overlayfs tree, but because
it is a very subtle change, I wanted to get some ACK from
Miklos and from you on the concept first.

If possible to get an early audit/LSM test run that would be
awesome, because I don't really know which audit/LSM tests
are regularly run by bots on linux-next.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/ovl_fake_path
