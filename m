Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B3600E8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJQMF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 08:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJQMF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:05:27 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F721D31C;
        Mon, 17 Oct 2022 05:05:25 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 63so11205107vse.2;
        Mon, 17 Oct 2022 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/CYV+XzTs+Z5NXexOxqHZrkVYIBaC9b5lgXXgEwFQg=;
        b=ahD2gI9gBlH0LTut1jECOHVDR2InDWBgu09SKXzswfRBrVHapsLwhsV5nTO6ssUW7+
         df6x8UahfnZ4WTk2PfO2z4R/bpvuGAmQUa12N2oK6BK8ZIjySvfUyaIDTfSykHnk9Gmy
         5mnpfX9Gv6uzN6ETeSN1zgE4WdajsiyAA5FDCVEdqbqusLWm0uURDc2+/3/ruEX7vKjD
         kzQsjPrmkxNBWt+tMAFMZjDBLfsh0lnHd+EV5T2JvPQ7ChBRepGTNKHASDTvBYqos3ta
         LVWHOZhgksyf/P94AS1WqAYhIqliJDeFhvGvoo1D9YjXRCtoXvYJI42eAzmafoetO8k1
         vAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/CYV+XzTs+Z5NXexOxqHZrkVYIBaC9b5lgXXgEwFQg=;
        b=HqnKnyErnOJxCP6iRNcThkSO/s8ZV26o2FpzWH4+vScJLPAbWTuxYASYXp5VQkKIbr
         9oapZ5rVX4VHTEded2S1W06rHzPhF7GhYavw/3LDIno5o0I8YkNHXgsbkIo0WcOMzFAT
         YNeuxXIBaGSVPDD23byhjm8ZWxoHFbCkrzI7MAaPlsPZEkiCHptdKs25jHYutyc8htCo
         QgDjBVZblEwhBm6sGED3Sj4SDC6S6q6rM/JMiCso8+stSijoLKXgcnFKmPrFWAPGxKYn
         7WCGjci/mnc+5Gp9aGXNsiH5mTjWo/lzefk683byaSWsilSkSEVCjVTOdqXLujPQ26nS
         HYgQ==
X-Gm-Message-State: ACrzQf3RhX2JnmtLrLgRQSTjAqcv54emp/nqm4SyCQuSd3INIFV2TYaU
        M/wfkWD9uvt/gtAftrhdcpwF3jQUuZXfZIh6MNJtjz8Chq4=
X-Google-Smtp-Source: AMsMyM5BBPgG3FO/x4dCb5iiVaZKCalho7b5xO9UpE93B8pLancDBGD9ii8+pEyLV+oxeMZIiAUC2XfraSZW+5B6Rrs=
X-Received: by 2002:a67:a24e:0:b0:3a5:38a0:b610 with SMTP id
 t14-20020a67a24e000000b003a538a0b610mr3951825vsh.2.1666008324319; Mon, 17 Oct
 2022 05:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221017100600.70269-1-brauner@kernel.org> <20221017100600.70269-4-brauner@kernel.org>
In-Reply-To: <20221017100600.70269-4-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Oct 2022 15:05:12 +0300
Message-ID: <CAOQ4uxgxo+LRq8m_zyCshcrrWYYg7yioytvvZCViQZx1qbbadA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] attr: use consistent sgid stripping checks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Mon, Oct 17, 2022 at 1:06 PM Christian Brauner <brauner@kernel.org> wrote:
>
> Currently setgid stripping in file_remove_privs()'s should_remove_suid()
> helper is inconsistent with other parts of the vfs. Specifically, it only
> raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP but not if the
> inode isn't in the caller's groups and the caller isn't privileged over the
> inode although we require this already in setattr_prepare() and
> setattr_copy() and so all filesystem implement this requirement implicitly
> because they have to use setattr_{prepare,copy}() anyway.
>
> But the inconsistency shows up in setgid stripping bugs for overlayfs in
> xfstests (e.g., generic/673, generic/683, generic/685, generic/686,
> generic/687). For example, we test whether suid and setgid stripping works
> correctly when performing various write-like operations as an unprivileged
> user (fallocate, reflink, write, etc.):
>
> echo "Test 1 - qa_user, non-exec file $verb"
> setup_testfile
> chmod a+rws $junk_file
> commit_and_check "$qa_user" "$verb" 64k 64k
>
> The test basically creates a file with 6666 permissions. While the file has
> the S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. On a
> regular filesystem like xfs what will happen is:
>
> sys_fallocate()
> -> vfs_fallocate()
>    -> xfs_file_fallocate()
>       -> file_modified()
>          -> __file_remove_privs()
>             -> dentry_needs_remove_privs()
>                -> should_remove_suid()
>             -> __remove_privs()
>                newattrs.ia_valid = ATTR_FORCE | kill;
>                -> notify_change()
>                   -> setattr_copy()
>
> In should_remove_suid() we can see that ATTR_KILL_SUID is raised
> unconditionally because the file in the test has S_ISUID set.
>
> But we also see that ATTR_KILL_SGID won't be set because while the file
> is S_ISGID it is not S_IXGRP (see above) which is a condition for
> ATTR_KILL_SGID being raised.
>
> So by the time we call notify_change() we have attr->ia_valid set to
> ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that
> ATTR_KILL_SUID is set and does:
>
> ia_valid = attr->ia_valid |= ATTR_MODE
> attr->ia_mode = (inode->i_mode & ~S_ISUID);
>
> which means that when we call setattr_copy() later we will definitely
> update inode->i_mode. Note that attr->ia_mode still contains S_ISGID.
>
> Now we call into the filesystem's ->setattr() inode operation which will
> end up calling setattr_copy(). Since ATTR_MODE is set we will hit:
>
> if (ia_valid & ATTR_MODE) {
>         umode_t mode = attr->ia_mode;
>         vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
>         if (!vfsgid_in_group_p(vfsgid) &&
>             !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
>                 mode &= ~S_ISGID;
>         inode->i_mode = mode;
> }
>
> and since the caller in the test is neither capable nor in the group of the
> inode the S_ISGID bit is stripped.
>
> But assume the file isn't suid then ATTR_KILL_SUID won't be raised which
> has the consequence that neither the setgid nor the suid bits are stripped
> even though it should be stripped because the inode isn't in the caller's
> groups and the caller isn't privileged over the inode.
>
> If overlayfs is in the mix things become a bit more complicated and the bug
> shows up more clearly. When e.g., ovl_setattr() is hit from
> ovl_fallocate()'s call to file_remove_privs() then ATTR_KILL_SUID and
> ATTR_KILL_SGID might be raised but because the check in notify_change() is
> questioning the ATTR_KILL_SGID flag again by requiring S_IXGRP for it to be
> stripped the S_ISGID bit isn't removed even though it should be stripped:
>
> sys_fallocate()
> -> vfs_fallocate()
>    -> ovl_fallocate()
>       -> file_remove_privs()
>          -> dentry_needs_remove_privs()
>             -> should_remove_suid()
>          -> __remove_privs()
>             newattrs.ia_valid = ATTR_FORCE | kill;
>             -> notify_change()
>                -> ovl_setattr()
>                   // TAKE ON MOUNTER'S CREDS
>                   -> ovl_do_notify_change()
>                      -> notify_change()
>                   // GIVE UP MOUNTER'S CREDS
>      // TAKE ON MOUNTER'S CREDS
>      -> vfs_fallocate()
>         -> xfs_file_fallocate()
>            -> file_modified()
>               -> __file_remove_privs()
>                  -> dentry_needs_remove_privs()
>                     -> should_remove_suid()
>                  -> __remove_privs()
>                     newattrs.ia_valid = attr_force | kill;
>                     -> notify_change()
>
> The fix for all of this is to make file_remove_privs()'s
> should_remove_suid() helper to perform the same checks as we already
> require in setattr_prepare() and setattr_copy() and have notify_change()
> not pointlessly requiring S_IXGRP again. It doesn't make any sense in the
> first place because the caller must calculate the flags via
> should_remove_suid() anyway which would raise ATTR_KILL_SGID.
>
> While we're at it we move should_remove_suid() from inode.c to attr.c
> where it belongs with the rest of the iattr helpers. Especially since it
> returns ATTR_KILL_S{G,U}ID flags. We also rename it to
> setattr_should_drop_suidgid() to better reflect that it indicates both
> setuid and setgid bit removal and also that it returns attr flags.
>
> Running xfstests with this doesn't report any regressions. We should really
> try and use consistent checks.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     Amir Goldstein <amir73il@gmail.com>:
>     - mention xfstests that failed prior to that
>
>     Christian Brauner <brauner@kernel.org>:
>     - Use should_remove_sgid() in chown_common() just like we do in do_truncate().
>
>     /* v3 */
>     Christian Brauner <brauner@kernel.org>:
>     - Move should_remove_suid() from inode.c to attr.c where it belongs with the
>       rest of the iattr helpers. Especially since it returns ATTR_KILL_S{G,U}ID
>       flags. We also rename it to setattr_should_drop_suidgid() to better reflect
>       that it indicates both setuid and setgid bit removal and also that it returns
>       attr flags.
>     - Since setattr_should_drop_suidgid() only needs the inode pass an inode,
>       not a dentry.
>
>  Documentation/trace/ftrace.rst |  2 +-
>  fs/attr.c                      | 37 +++++++++++++++++++++++++++++++++-
>  fs/fuse/file.c                 |  2 +-
>  fs/inode.c                     | 36 ++++-----------------------------
>  fs/internal.h                  |  3 ++-
>  fs/ocfs2/file.c                |  4 ++--
>  fs/open.c                      |  8 ++++----
>  include/linux/fs.h             |  2 +-
>  8 files changed, 51 insertions(+), 43 deletions(-)
>
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 60bceb018d6a..21f01d32c959 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -2940,7 +2940,7 @@ Produces::
>                bash-1994  [000] ....  4342.324898: ima_get_action <-process_measurement
>                bash-1994  [000] ....  4342.324898: ima_match_policy <-ima_get_action
>                bash-1994  [000] ....  4342.324899: do_truncate <-do_last
> -              bash-1994  [000] ....  4342.324899: should_remove_suid <-do_truncate
> +              bash-1994  [000] ....  4342.324899: setattr_should_drop_suidgid <-do_truncate
>                bash-1994  [000] ....  4342.324899: notify_change <-do_truncate
>                bash-1994  [000] ....  4342.324900: current_fs_time <-notify_change
>                bash-1994  [000] ....  4342.324900: current_kernel_time <-current_fs_time
> diff --git a/fs/attr.c b/fs/attr.c
> index 3d03ceb332e5..12938a1442f2 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -65,6 +65,41 @@ int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
>                                  i_gid_into_vfsgid(mnt_userns, inode));
>  }
>
> +/**
> + * setattr_should_drop_suidgid - determine whether the set{g,u}id bit needs to
> + *                               be dropped
> + * @mnt_userns:        user namespace of the mount @inode was found from
> + * @inode:     inode to check
> + *
> + * This function determines whether the set{g,u}id bits need to be removed.
> + * If the setuid bit needs to be removed ATTR_KILL_SUID is returned. If the
> + * setgid bit needs to be removed ATTR_KILL_SGID is returned. If both
> + * set{g,u}id bits need to be removed the corresponding mask of both flags is
> + * returned.
> + *
> + * Return: A mask of ATTR_KILL_S{G,U}ID indicating which - if any - setid bits
> + * to remove, 0 otherwise.
> + */
> +int setattr_should_drop_suidgid(struct user_namespace *mnt_userns,
> +                               struct inode *inode)
> +{
> +       umode_t mode = inode->i_mode;
> +       int kill = 0;
> +
> +       /* suid always must be killed */
> +       if (unlikely(mode & S_ISUID))
> +               kill = ATTR_KILL_SUID;
> +
> +       if (unlikely(setattr_should_drop_sgid(mnt_userns, inode)))
> +               kill |= ATTR_KILL_SGID;

kill |= setattr_should_drop_sgid(mnt_userns, inode);

Thanks,
Amir.
