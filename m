Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBC5654F46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 11:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiLWKnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 05:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiLWKnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:43:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF2B13CCB
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Dec 2022 02:43:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5B4AB820DB
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Dec 2022 10:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125D4C433EF;
        Fri, 23 Dec 2022 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671792226;
        bh=1Hgfbro9Glq3TLCI9OXA/diQwMaRsQxRznKCL4Hh+i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=at8ZlXJEuDWy8f0egkh+LRyctJqdQIEVCvx79o6vY0bvzCl834TLJXM5CNHGGcui1
         W/i7ahe5CiRlhHY3TpE6+DWweOuLfbn02B6xi3SFLiWoVvxxbvpXrYoW/q/yxSNxxU
         h8ezujwexS/HoCituw30tvoJ86zDAWN2spcSIMo535VJy51eeYBSCDbmyIGn+EK7qA
         tPr36HsI+VdfK/e8BLv+iihYD86uyEDYAMaBHzSvmV5Eqzx46foAiRSISra0ZDZlyL
         b1ydKu+P6xrGo1PCsxhemZvnTUQIpN0rA+Ar6uTPTo1EXXCOOB65ZsQbPB39m3xb1f
         F5j5CAITV3IZw==
Date:   Fri, 23 Dec 2022 11:43:41 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     bugzilla-daemon@kernel.org, rprichard@google.com,
        jaegeuk@google.com
Cc:     linux-fsdevel@vger.kernel.org, sforshee@kernel.org
Subject: Re: [Bug 216834] New: fchmodat changes permission bits of symlink
Message-ID: <20221223104341.kdkfe5rhwuiu75iv@wittgenstein>
References: <bug-216834-223290@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bug-216834-223290@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 10:06:13PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216834
> 
>             Bug ID: 216834
>            Summary: fchmodat changes permission bits of symlink
>            Product: File System
>            Version: 2.5
>     Kernel Version: 5.19.11-1rodete1-amd64,
>                     5.15.41-android13-8-00205-gf1bf82c3dacd-ab8747247,
>                     "latest" as of 2022-12-22
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>           Assignee: fs_other@kernel-bugs.osdl.org
>           Reporter: rprichard@google.com
>         Regression: No
> 
> Created attachment 303456
>   --> https://bugzilla.kernel.org/attachment.cgi?id=303456&action=edit
> modify-symlink.c
> 
> I've noticed that I'm able to change the permission bits of a symlink by
> invoking __NR_fchmodat on a /proc/self/fd path for a symlink opened with
> O_PATH. On some filesystems (ext4, btrfs, and xfs), the syscall fails with
> ENOTSUP, but the permission bits are still changed. On f2fs, on the other hand,
> the syscall fails with ENOTSUP and the bits are unchanged.
> 
> Using the attached modify-symlink.c, I see this output:
> 
> -1 [Operation not supported]
> lrw---x-w- 1 rprichard primarygroup 1 Dec 22 13:58 A -> B
> -rw-r--r-- 1 rprichard primarygroup 0 Dec 22 13:58 B
> 
> I see this behavior with the kernel on my gLinux (Debian) machine, as well as
> various Android kernels. I showed the problem to jaegeuk@google.com, who also
> tested it on a recent kernel.

Yeah, this is a known issue. Or at least I'm aware of it and it's a bit
wonky as this is at the intersection of two issues. Wouldn't be fun if
it wasn't:

(1) /proc/self/fd/<nr> doesn't honor permission bits. For example, you
    can easily upgrade permission bits by reopening an fd via
    /proc/self/fd<nr>. This is well-known and next year we'll hopefully
    be able to further restrict this with upgrade masks specifiable in
    openat2().
    Consequently, /proc/self/fd/<nr> easily let's you change permission
    bits and other stuff. It's not really like an fd.
(2) Symlinks don't support xattrs and thus don't support POSIX ACLs.
    If you change the mode of a file and the file has POSIX ACLs then
    the permission mask stored in the POSIX ACLs needs to be updated.
    Since symlinks don't support POSIX ACLs this is where it fails and
    this is where the EOPNOTSUPP comes from.

    For example, xfs keeps changing POSIX ACLs out of the transaction
    path. IOW, it calls posix_acl_chmod() after it has already updated
    the inode and completed the transaction. The same behavior exists
    for ext4 and btrfs.

    In a way, your chmod() is successful it's just that updating POSIX
    ACLs fails which is ok since symlinks don't support them.

One way to improve this situation is to just make posix_acl_chmod() not
bother reporting errors for acls on symlinks instead of reporting a
failure. IOW,

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 74dc0f571dc9..a9246934a4ca 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -594,7 +594,7 @@ int
        struct posix_acl *acl;
        int ret = 0;

-       if (!IS_POSIXACL(inode))
+       if (S_ISLNK(mode) || !IS_POSIXACL(dir))
                return 0;
        if (!inode->i_op->set_acl)
                return -EOPNOTSUPP;
