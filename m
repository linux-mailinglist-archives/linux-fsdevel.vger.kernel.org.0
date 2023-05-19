Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E007709BEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjESQCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjESQCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 12:02:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D89E;
        Fri, 19 May 2023 09:02:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510d8d7f8eeso5607873a12.0;
        Fri, 19 May 2023 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684512126; x=1687104126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuBiIv9uR6ASD9Nq3Oq0ciug5A9AOnv/YLTp1TY+UV4=;
        b=o4EQNG9tI2j9R+emrs16upzQIppnFwAddW0DmMmsfk5e5k/T4WSz758jeXMQvJo9y2
         OEFvJMitNfNVbTfu0bwcXBbqNML8EuYkoXuEx0pFuXb7BgaGzDFxNDLoimsl8R2QXJ0E
         rKVrU2TXMo65qkFX/lLcCDvMzCfi1qFiSwbEzXKaqVwz4E7jJ+P3xiGcHGLNokvjGNwD
         QvaYXMbNVVvm3jptLlesOL/lLVA/yfFLpqJ4+l703siJNlffHzbNqqnhLcoS12vUyXCp
         L73v50aM+rkcMKv5NaEzUWCAzBRUNDixqdb0U4JuVpJRS4n76QAPao6X7Vh2oFiMQQO4
         DPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684512126; x=1687104126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuBiIv9uR6ASD9Nq3Oq0ciug5A9AOnv/YLTp1TY+UV4=;
        b=dXDFjZr/1GDRlggBmUm+CDIBHZnSfcoLZLMn2MOot6coqhDFleeHvg6jXDVAlBebec
         ZiDCB2C+QS8cieGqzUGd03hX/VAT9p83ZId236Ngqad+K7ifEEp5L0bjb9SQ7Zccna4R
         9kTyGVYPtQ/j98kfHt26MpjSH9ahmbEEVILG9G3Mqbm754RdmPRgYco2Lom6m6HCrBQk
         K1OjUEVZgbozbVBzsZsGNjKqW6vcnC0CRQJ8xq3ChPS9v4KuwzXfXQ6i5dgvJ2pMZ4Kh
         TLg9IkD0k9Ip1Wu/jyX+alRqGcm7UTAUZ6tb3+1vJ0axHsWkh1gnUL6t0G3z7C8k14Ds
         7sdQ==
X-Gm-Message-State: AC+VfDxQgq06FvHuiujE6mrnDKj+S5LA5gFAMEuioJd6ROqm46TE+06n
        EckDOxSsJwE0bvIttARZSh6UX/dTs067D6mVcoA=
X-Google-Smtp-Source: ACHHUZ5GvB8XYG1VDe6pzEEnHGC25HOO1GKx3i2tpUHfT7irJA6Nuw6KD87GaoK7bwqagORT51NjHwNa6q6y5YOV1LQ=
X-Received: by 2002:aa7:c50e:0:b0:50e:412:5a50 with SMTP id
 o14-20020aa7c50e000000b0050e04125a50mr1982043edq.29.1684512125668; Fri, 19
 May 2023 09:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230518215444.1418789-1-andrii@kernel.org> <20230518215444.1418789-2-andrii@kernel.org>
 <20230519-eiswasser-leibarzt-ed7e52934486@brauner>
In-Reply-To: <20230519-eiswasser-leibarzt-ed7e52934486@brauner>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 May 2023 09:01:53 -0700
Message-ID: <CAEf4BzY_kJZiWe804-DOzfNJNKVSQCct8_gNta7jFyruFDw6zA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN
 and BPF_OBJ_GET commands
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        cyphar@cyphar.com, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 2:49=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, May 18, 2023 at 02:54:42PM -0700, Andrii Nakryiko wrote:
> > Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() syscall
> > forces users to specify pinning location as a string-based absolute or
> > relative (to current working directory) path. This has various
> > implications related to security (e.g., symlink-based attacks), forces
> > BPF FS to be exposed in the file system, which can cause races with
> > other applications.
> >
> > One of the feedbacks we got from folks working with containers heavily
> > was that inability to use purely FD-based location specification was an
> > unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GET
> > commands. This patch closes this oversight, adding path_fd field to
> > BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established by
> > *at() syscalls for dirfd + pathname combinations.
> >
> > This now allows interesting possibilities like working with detached BP=
F
> > FS mount (e.g., to perform multiple pinnings without running a risk of
> > someone interfering with them), and generally making pinning/getting
> > more secure and not prone to any races and/or security attacks.
> >
> > This is demonstrated by a selftest added in subsequent patch that takes
> > advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstrate
> > creating detached BPF FS mount, pinning, and then getting BPF map out o=
f
> > it, all while never exposing this private instance of BPF FS to outside
> > worlds.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  4 ++--
> >  include/uapi/linux/bpf.h       | 10 ++++++++++
> >  kernel/bpf/inode.c             | 16 ++++++++--------
> >  kernel/bpf/syscall.c           | 25 ++++++++++++++++++++-----
> >  tools/include/uapi/linux/bpf.h | 10 ++++++++++
> >  5 files changed, 50 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 36e4b2d8cca2..f58895830ada 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2077,8 +2077,8 @@ struct file *bpf_link_new_file(struct bpf_link *l=
ink, int *reserved_fd);
> >  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> >  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> >
> > -int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
> > -int bpf_obj_get_user(const char __user *pathname, int flags);
> > +int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname=
);
> > +int bpf_obj_get_user(int path_fd, const char __user *pathname, int fla=
gs);
> >
> >  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
> >  #define DEFINE_BPF_ITER_FUNC(target, args...)                        \
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1bb11a6ee667..3731284671e4 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1272,6 +1272,9 @@ enum {
> >
> >  /* Create a map that will be registered/unregesitered by the backed bp=
f_link */
> >       BPF_F_LINK              =3D (1U << 13),
> > +
> > +/* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
> > +     BPF_F_PATH_FD           =3D (1U << 14),
> >  };
> >
> >  /* Flags for BPF_PROG_QUERY. */
> > @@ -1420,6 +1423,13 @@ union bpf_attr {
> >               __aligned_u64   pathname;
> >               __u32           bpf_fd;
> >               __u32           file_flags;
> > +             /* Same as dirfd in openat() syscall; see openat(2)
> > +              * manpage for details of path FD and pathname semantics;
> > +              * path_fd should accompanied by BPF_F_PATH_FD flag set i=
n
> > +              * file_flags field, otherwise it should be set to zero;
> > +              * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
> > +              */
> > +             __u32           path_fd;
> >       };
>
> Thanks for changing that.
>
> This is still odd though because you prevent users from specifying
> AT_FDCWD explicitly. They should be allowed to do that plus file
> descriptors are signed integers so please s/__u32/__s32/. AT_FDCWD
> should be passable anywhere where we have at* semantics. Plus, if in the
> vfs we ever add
> #define AT_ROOT -200
> or something you can't use without coming up with your own custom flags.
> If you just follow what everyone else does and use __s32 then you're
> good.

It's just an oversight, I'll change to __s32, good point. I intended
AT_FDCWD to be passable explicitly and it will work because we just
interpret that path_fd as int internally, but you are of course right
that API should make it clear that this is signed value.

>
> File descriptors really need to be signed. There's no way around that.
> See io_uring as a good example
>
> io_uring_sqe {
>           __u8    opcode;         /* type of operation for this sqe */
>           __u8    flags;          /* IOSQE_ flags */
>           __u16   ioprio;         /* ioprio for the request */
>           __s32   fd;             /* file descriptor to do IO on */
> }
>
> where the __s32 fd is used in all fd based requests including
> io_openat*() (See io_uring/openclose.c) which are effectively the
> semantics you want to emulate here.

Agreed. Please bear in mind that it's the first time we are dealing
with these path FDs in bpf() subsystem, so all these silly mistakes
are just coming from being exposed into unfamiliar "territory". Will
fix in v3, along with adding explicit tests for AT_FWCWD.
