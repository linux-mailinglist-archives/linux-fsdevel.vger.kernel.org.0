Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17D477BCEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjHNPZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjHNPYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:24:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84F10C6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 08:24:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe1e7440f1so1326093e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1692026685; x=1692631485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ziw3r3Tja22DqMHkyIjj75Auq4FVBkHVssPtrJPa9M=;
        b=M4xjxW1e/fZPcoLMcHB5mqTpLyc8P97Cwp0PNoQ5QHbNxHlZjpjwVZ2popwEFDtpxf
         U5Ul0NNV0zQj+zAeghcawTCMiNcV8jaHf8Dc06XeIjlDfkLHGyLSUJdxnvwloecVMliq
         5gJKkB4paIGj4gkGU6+wcAG54AO1g6LOfL5DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692026685; x=1692631485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ziw3r3Tja22DqMHkyIjj75Auq4FVBkHVssPtrJPa9M=;
        b=Pwo+miXBwt3NzaUOvaNLbrA/q1KD3uSYjIK59AZ8ZaO5au+hXqKrUNlYprInalfh8n
         GeHY3ku4Q+a5HKg65cdUzkHpyKEngkyMO1K7ssrmkLds2XP56WoOCbwqQqsa7DXdfJhG
         I83LrfV7FTr6Lhz6GWSZayyKX4s0HbZ/BR58X8lsDguVw9LCWLWU6uAn4HopJEVY6rbe
         qPIA28zIGTlLejJlAKzoq2PNmKYUAhCWF7862QMSozri5qt4xGwSA+J4A9URZXa+VK5j
         GhJStvsfqcJx9TU9O+N9JQH0aI8Nxb/UVRVc2R4Thw+6uf8ygiVLrg5d6mtIphxp49ha
         nFGw==
X-Gm-Message-State: AOJu0YwPT6fzMCp8f/awVHo6GbhX5kz3gYoDlP+Vb7E+P/h23uAvPIv/
        E0Y8SRQcXm5Gg/hMJHfDxoVmHi/2+hpb2pVQZQN4pQ==
X-Google-Smtp-Source: AGHT+IFn8sdfqQhKIdKAAladZMLCbd6oLeRv8zsgX68V2UY+4U1l5/lbKnQBzr49lekz0v7RK+2H2fint5J5svOfdqk=
X-Received: by 2002:ac2:5f16:0:b0:4fe:5f0c:9db6 with SMTP id
 22-20020ac25f16000000b004fe5f0c9db6mr5252512lfq.5.1692026685009; Mon, 14 Aug
 2023 08:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de> <20230814-devcg_guard-v1-4-654971ab88b1@aisec.fraunhofer.de>
In-Reply-To: <20230814-devcg_guard-v1-4-654971ab88b1@aisec.fraunhofer.de>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Mon, 14 Aug 2023 17:24:33 +0200
Message-ID: <CAJqdLroV3uPnDOhTjVRiYHHFFXoj+fK0Na+mSac7zPYxkwbAsg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] fs: allow mknod in non-initial userns using
 cgroup device guard
To:     =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gyroidos@aisec.fraunhofer.de, stgraber@ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC St=C3=A9phane Graber <stgraber@ubuntu.com>


On Mon, Aug 14, 2023 at 4:26=E2=80=AFPM Michael Wei=C3=9F
<michael.weiss@aisec.fraunhofer.de> wrote:
>
> If a container manager restricts its unprivileged (user namespaced)
> children by a device cgroup, it is not necessary to deny mknod
> anymore. Thus, user space applications may map devices on different
> locations in the file system by using mknod() inside the container.
>
> A use case for this, we also use in GyroidOS, is to run virsh for
> VMs inside an unprivileged container. virsh creates device nodes,
> e.g., "/var/run/libvirt/qemu/11-fgfg.dev/null" which currently fails
> in a non-initial userns, even if a cgroup device white list with the
> corresponding major, minor of /dev/null exists. Thus, in this case
> the usual bind mounts or pre populated device nodes under /dev are
> not sufficient.
>
> To circumvent this limitation, we allow mknod() in fs/namei.c if a
> bpf cgroup device guard is enabeld for the current task using
> devcgroup_task_is_guarded() and check CAP_MKNOD for the current user
> namespace by ns_capable() instead of the global CAP_MKNOD.
>
> To avoid unusable device nodes on file systems mounted in
> non-initial user namespace, may_open_dev() ignores the SB_I_NODEV
> for cgroup device guarded tasks.
>
> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
> ---
>  fs/namei.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index e56ff39a79bc..ef4f22b9575c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3221,6 +3221,9 @@ EXPORT_SYMBOL(vfs_mkobj);
>
>  bool may_open_dev(const struct path *path)
>  {
> +       if (devcgroup_task_is_guarded(current))
> +               return !(path->mnt->mnt_flags & MNT_NODEV);
> +
>         return !(path->mnt->mnt_flags & MNT_NODEV) &&
>                 !(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
>  }
> @@ -3976,9 +3979,19 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inod=
e *dir,
>         if (error)
>                 return error;
>
> -       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> -           !capable(CAP_MKNOD))
> -               return -EPERM;
> +       /*
> +        * In case of a device cgroup restirction allow mknod in user
> +        * namespace. Otherwise just check global capability; thus,
> +        * mknod is also disabled for user namespace other than the
> +        * initial one.
> +        */
> +       if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout) {
> +               if (devcgroup_task_is_guarded(current)) {
> +                       if (!ns_capable(current_user_ns(), CAP_MKNOD))
> +                               return -EPERM;
> +               } else if (!capable(CAP_MKNOD))
> +                       return -EPERM;
> +       }
>
>         if (!dir->i_op->mknod)
>                 return -EPERM;
>
> --
> 2.30.2
>
