Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDBD6C271E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCUBOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjCUBOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:14:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78EC1969B;
        Mon, 20 Mar 2023 18:13:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i6so15400454ybu.8;
        Mon, 20 Mar 2023 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679361152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGVoWyoGs6zpi27lMBwJ27qLVxT0drgNa819/hyvuwQ=;
        b=mb9NRATqXjQ2NCT9Xar10bn1AEXHXfBkPeH1XVYozCHUfNsXZSd7i6BdWw92hpGW8u
         XKXmYR2aAgTaSgPuK6VQvmzXkPECWS0HKIM+wBGS8vQlusT0BQ3715+15S77oF8bana3
         ZqsTPp28qnDJ+bmmTbejtbZ4jPdx3MXhZvi0JLCT+JdCRWSMe+HBqHVaOkaae+Iz9aN6
         0Ig7oQIxFgTuROm1wBHBz8rw1i32aN1XKmrzpItuUQcu2z9z5sa2wfJNBXbXOkRQaugM
         K0on78/1X1IopekrdDcumzEMbkSiQncLZZNo7LJsnWGeRP/myf7UkhzKpdXmoyV9GvVn
         59VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679361152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGVoWyoGs6zpi27lMBwJ27qLVxT0drgNa819/hyvuwQ=;
        b=3xERV7A5F+Bmcj3CaaEosPfVkUCW+dJQ8EI5cQXk/r/uweF3WdePefe9U7ejXfSLhR
         fmtWS2CyMU3EQ1FhR2MbAzVUklonJZj9HaOgF0eX0tlUyP/gL/S3qv9R2jqmR8h53vW4
         qk1J2RvnUWoTUdJbYUNFDrSo3wVcc17Upr9NZ1Cm4PlJjeF6dF/N8d/LaBCi4r15WsL3
         fBTSAMOsWa6NACsdRZxrCGhkA4SsViTRQh9X5GGqjFhQWBuCJ0Verlnjn2zinqiUaDAJ
         BV60Ue4zsks3ne8j+GDjPtF3sqt2B8naewsuw1n+6mByDEuAPfxxtG/Se+eRbyz5OfZK
         TjTQ==
X-Gm-Message-State: AAQBX9eISYZs3OwHhjvvKSCI8y5UTQZxEpfM84m4o1EfyiXDj3IDh3Mk
        j3wwB1RaDR8+oykH2jyrWRvxJ6SAs21oiHZUcVU=
X-Google-Smtp-Source: AKy350bcU8c2Bu4z9cQ9CFpsAnxnxfLJc11yO2y6d4hSwUmsDc3BfIQpsHVT693GW6oXavGLgMj9qEA5LfZtpdW5cjM=
X-Received: by 2002:a05:6902:283:b0:aa2:475c:2982 with SMTP id
 v3-20020a056902028300b00aa2475c2982mr273731ybh.1.1679361151889; Mon, 20 Mar
 2023 18:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230124023834.106339-1-ericvh@kernel.org> <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-11-ericvh@kernel.org> <Y/Ch8o/6HVS8Iyeh@codewreck.org>
 <Y/DBZSaAsRiNR2WV@codewreck.org>
In-Reply-To: <Y/DBZSaAsRiNR2WV@codewreck.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Mon, 20 Mar 2023 20:12:20 -0500
Message-ID: <CAFkjPT=6PdhbtkMbotKpCwaP535-YHRqrzo4Z83=vfau2UVHBg@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] fs/9p: writeback mode fixes
To:     asmadeus@codewreck.org
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I chased my tail on this for like the last month - but I finally found
the problem with fscache and it was related to one of the other
problems you pointed out - but I got distracted by a dozen red
herrings (which are probably bugs in fscache, but not caused by my
patch) -- in any case, it turns out the assert in fscache is due to an
imbalance in unuse_cookie -- and its because dirty_folio calls
use_cookie under the hood and fscache_unpin_writeback is the balance
and it calls unuse cookie under the hood.  Because there was no fid,
we were erroring out and never balancing - and it gets caught when we
close things down.

Secondarily, I'm not sure wtf we were doing in write_inode --
everybody else just calls fscache_unpin_writeback and nothing else.
The whole fsync stuff appears to be unnecessary code -- which means we
don't need a fid (certainly not an open fid) so I just removed that
code, called unpin_writeback and all my tests pass with fscache.  I'm
going to run a longer suite of tests just to make sure I didn't
accidently perturb anything else, but then I'll consolidate, clean-up
and repost the patches.

      -eric



On Sat, Feb 18, 2023 at 6:16=E2=80=AFAM <asmadeus@codewreck.org> wrote:
>
> asmadeus@codewreck.org wrote on Sat, Feb 18, 2023 at 07:01:22PM +0900:
> > > diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> > > index 5fc6a945bfff..797f717e1a91 100644
> > > --- a/fs/9p/vfs_super.c
> > > +++ b/fs/9p/vfs_super.c
> >
> > > @@ -323,16 +327,17 @@ static int v9fs_write_inode_dotl(struct inode *=
inode,
> > >      */
> > >     v9inode =3D V9FS_I(inode);
> > >     p9_debug(P9_DEBUG_VFS, "%s: inode %p, writeback_fid %p\n",
> > > -            __func__, inode, v9inode->writeback_fid);
> > > -   if (!v9inode->writeback_fid)
> > > -           return 0;
> > > +            __func__, inode, fid);
> > > +   if (!fid)
> > > +           return -EINVAL;
> >
> > Hmm, what happens if we return EINVAL here?
> > Might want a WARN_ONCE or something?
>
> Answering myself on this: No idea what happens, but it's fairly
> common...
> (I saw it from wb_writeback which considers any non-zero return value as
> 'progress', so the error is progress as well... Might make more sense to
> return 0 here actually? need more thorough checking, didn't take time to
> dig through this either...)
>
> That aside I ran with my comments addressed and cache=3Dfscache, and
> things blew up during ./configure of coreutils-9.1 in qemu:
> (I ran it as root without setting the env var so it failed, that much is
> expected -- the evict_inode blowing up isn't)
> -------
> checking whether mknod can create fifo without root privileges... configu=
re: error: in `/mnt/coreutils-9.1':
> configure: error: you should not run configure as root (set FORCE_UNSAFE_=
CONFIGURE=3D1 in environment to bypass this check)
> See `config.log' for more details
> FS-Cache:
> FS-Cache: Assertion failed
> FS-Cache: 2 =3D=3D 0 is false
> ------------[ cut here ]------------
> kernel BUG at fs/fscache/cookie.c:985!
> invalid opcode: 0000 [#3] SMP PTI
> CPU: 0 PID: 9707 Comm: rm Tainted: G      D            6.2.0-rc2+ #37
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian=
-1.16.0-5 04/01/2014
> RIP: 0010:__fscache_relinquish_cookie.cold+0x5a/0x8f
> Code: 48 c7 c7 21 5e b8 81 e8 34 87 ff ff 48 c7 c7 2f 5e b8 81 e8 28 87 f=
f ff 48 63 73 04 31 d2 48 c7 c7 00 61 b8 81 e8 16 87 ff ff <0f> 0b 44 8b 47=
 04 8b 4f 0c 45 0f b8
> RSP: 0018:ffffc90002697e08 EFLAGS: 00010286
> RAX: 0000000000000019 RBX: ffff8880077de210 RCX: 00000000ffffefff
> RDX: 00000000ffffffea RSI: 00000000ffffefff RDI: 0000000000000001
> RBP: ffffc90002697e18 R08: 0000000000004ffb R09: 00000000ffffefff
> R10: ffffffff8264ea20 R11: ffffffff8264ea20 R12: 0000000000000000
> R13: ffffffffc00870e0 R14: ffff88800308cd20 R15: ffff8880046a0020
> FS:  00007fec5aa33000(0000) GS:ffff88807cc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000009af4d8 CR3: 0000000007490000 CR4: 00000000000006b0
> Call Trace:
>  <TASK>
>  v9fs_evict_inode+0x78/0x90 [9p]
>  evict+0xc0/0x160
>  iput+0x171/0x220
>  do_unlinkat+0x197/0x280
>  __x64_sys_unlinkat+0x37/0x60
>  do_syscall_64+0x3c/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fec5ab33fdb
> Code: 73 01 c3 48 8b 0d 55 9e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 08
> RSP: 002b:00007ffd460b1858 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
> RAX: ffffffffffffffda RBX: 00000000009af830 RCX: 00007fec5ab33fdb
> RDX: 0000000000000000 RSI: 00000000009ae3d0 RDI: 00000000ffffff9c
> RBP: 00000000009ae340 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd460b1a40 R14: 0000000000000000 R15: 00000000009af830
>  </TASK>
> Modules linked in: 9pnet_virtio 9p 9pnet siw ib_core
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__fscache_relinquish_cookie.cold+0x5a/0x8f
> Code: 48 c7 c7 21 5e b8 81 e8 34 87 ff ff 48 c7 c7 2f 5e b8 81 e8 28 87 f=
f ff 48 63 73 04 31 d2 48 c7 c7 00 61 b8 81 e8 16 87 ff ff <0f> 0b 44 8b 47=
 04 8b 4f 0c 45 0f b8
> RSP: 0018:ffffc90002237e08 EFLAGS: 00010286
> RAX: 0000000000000019 RBX: ffff8880077de9a0 RCX: 00000000ffffefff
> RDX: 00000000ffffffea RSI: 00000000ffffefff RDI: 0000000000000001
> RBP: ffffc90002237e18 R08: 0000000000004ffb R09: 00000000ffffefff
> R10: ffffffff8264ea20 R11: ffffffff8264ea20 R12: 0000000000000000
> R13: ffffffffc00870e0 R14: ffff888003a6b500 R15: ffff8880046a0020
> FS:  00007fec5aa33000(0000) GS:ffff88807cc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000009af4d8 CR3: 0000000007490000 CR4: 00000000000006b0
> ./configure: line 88:  9707 Segmentation fault      exit $1
> -----------
>
> I don't have time to investigate but I'm afraid this needs a bit more
> time as well, sorry :/
>
>
>
>
>
>
>
>
>
>
> For reference, here's how I addressed my comments. I don't think that's
> related to the problem at hand but can retry later without it if you
> think something's fishy:
> ---------
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index 44918c60357f..c16c39ba55d6 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -215,7 +215,7 @@ int v9fs_dir_release(struct inode *inode, struct file=
 *filp)
>         p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
>                  inode, filp, fid ? fid->fid : -1);
>         if (fid) {
> -               if ((fid->qid.type =3D=3D P9_QTFILE) && (filp->f_mode & F=
MODE_WRITE))
> +               if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRI=
TE))
>                         v9fs_flush_inode_writeback(inode);
>
>                 spin_lock(&inode->i_lock);
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 936daff9f948..e322d4196be6 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -60,7 +60,7 @@ int v9fs_file_open(struct inode *inode, struct file *fi=
le)
>                         return PTR_ERR(fid);
>
>                 if ((v9ses->cache >=3D CACHE_WRITEBACK) && (omode & P9_OW=
RITE)) {
> -                       int writeback_omode =3D (omode & !P9_OWRITE) | P9=
_ORDWR;
> +                       int writeback_omode =3D (omode & ~P9_OWRITE) | P9=
_ORDWR;
>
>                         p9_debug(P9_DEBUG_CACHE, "write-only file with wr=
iteback enabled, try opening O_RDWR\n");
>                         err =3D p9_client_open(fid, writeback_omode);
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index d53475e1ba27..062c34524b1f 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -230,22 +230,7 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
>
>  int v9fs_flush_inode_writeback(struct inode *inode)
>  {
> -       struct writeback_control wbc =3D {
> -               .nr_to_write =3D LONG_MAX,
> -               .sync_mode =3D WB_SYNC_ALL,
> -               .range_start =3D 0,
> -               .range_end =3D -1,
> -       };
> -
> -       int retval =3D filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
> -
> -       if (retval !=3D 0) {
> -               p9_debug(P9_DEBUG_ERROR,
> -                       "trying to flush inode %p failed with error code =
%d\n",
> -                       inode, retval);
> -       }
> -
> -       return retval;
> +       return filemap_write_and_wait(inode->i_mapping);
>  }
>
>  /**
> ------
> --
> Dominique
