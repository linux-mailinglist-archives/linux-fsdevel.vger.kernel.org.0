Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D840600E57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJQL75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 07:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJQL74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:59:56 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FBB1FCDC;
        Mon, 17 Oct 2022 04:59:54 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id q83so5219507vkb.2;
        Mon, 17 Oct 2022 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KkDHDDtW/CzDCtr3EqNszSZBQb+H4Aq2cDIT/uMNkGo=;
        b=a5GfLe6L55tzixUoRvymfAFBI0FceGsc+cQaYJYwYzs02iVccsOfcRpIzWhq68XKE+
         jxidfBw3feyjCp3L9IBys8KfQtUo5+juX5jdA3zQcgzSijTTf6YBbHJfrn0345zdJV+A
         LT1IfaR8i1zVmgKW/k1ZbVr6YmlqBe8eMDKr97shuFHB76JTClXQziRypAkvfc/x/Hzb
         8xao82Pmew5xXzKUqVqBsrrlc+14OEQg5et+IG+On7/n6rekkXfxQxTuNmwuM1YI/P62
         4sOHmYi24SjudDV/okyZgKqk9K2LFm7BMyVVsIHGDgTNIVcu7AM9ZV1bO7kecOLNfbra
         OR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkDHDDtW/CzDCtr3EqNszSZBQb+H4Aq2cDIT/uMNkGo=;
        b=WhewYELt+4xv7AbtIQDf9hv7oeTp1HgK25GPTzmyQJaFEzcfUtQicMP04nsCNrrSrq
         KDtGtyRnzxSq0Ke5wE8dNWQO2kCkCdwy14cmjixZPfdW0teb/fG/UtJiGm30L1bnuqqt
         hZu4ZLLyvRIkcZ+1miwd7sE2KEdwxg3lNPjCtdPFdO4ImBvslyF1DQTvGOjo7/NiW3ln
         MvwASVzHvaujlR4KQ/TFboQq8hAHNNlvgQ9/Yzrc0o53Tr3rPfGmBD+NKV9RDwGUNH5W
         zaWoHz4K1KG9wdADmqoJI7ceOxkFlLKJzur/KuV0wnRtRAVXIjgfUTU05CVrPQPWpTr6
         ZwvQ==
X-Gm-Message-State: ACrzQf2mWR1zbAzrCwrA8ib0Tp2TEQ3sMgxNBtXJsw/KuUAin8iCIkTu
        fQXY9KeG3T95fjslmXTu9sr45U9OTE9LlXsbEPS626XxEL4=
X-Google-Smtp-Source: AMsMyM5WdhQ0VqsWKBwW6gfqNFYnRFUUkNzIKvHqsFG1NyexuvOBH1RJqW8HId+Fr3h1nsE3WR8CeRhYwhjI+aKcrs0=
X-Received: by 2002:a1f:60cd:0:b0:3ae:da42:89d0 with SMTP id
 u196-20020a1f60cd000000b003aeda4289d0mr3728527vkb.15.1666007993504; Mon, 17
 Oct 2022 04:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221017100600.70269-1-brauner@kernel.org> <20221017100600.70269-4-brauner@kernel.org>
In-Reply-To: <20221017100600.70269-4-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Oct 2022 14:59:42 +0300
Message-ID: <CAOQ4uxjQhuCSdxweyV9VwUgp4762Lp5QavD=m72xGZk+QMu1pg@mail.gmail.com>
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

Doubly signed...

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


Moving between C files and changing code in the same commit is bad
for review.

Please move between C files in a prep patch.

Thanks,
Amir.
