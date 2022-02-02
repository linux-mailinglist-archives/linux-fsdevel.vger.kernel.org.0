Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354EF4A7B91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 00:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347992AbiBBXQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 18:16:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47518 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347982AbiBBXQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:16:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34C65B832AC;
        Wed,  2 Feb 2022 23:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEF7C340EB;
        Wed,  2 Feb 2022 23:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643843782;
        bh=GfEwU6uYg771bgA3f9CiI67zPmMXrskYblsTIUztBfg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YuuIAXwEF/7MHugB8GjsVCMOdsNOwdwdZ9gG6yzwavhQGdoNPXEsPwi3aB/NdnKpE
         Vxfz1N+eDt34Dhtj18DdTyyiGzAC3HjLKBkypk2BDPBa7X7h0LiNjVy6kKtLfoTi0s
         ZYoR66XzJqC62Z4f29+6LcM4Vamx2nkaypLiYMn4zzEYX+89DQB444RcIZD4A12Zc5
         2WiSg9sFsaylBu/nZwP7kmufBfQHzioOgD6Zq7bxPCSXQc7CAlFcmpb8eGnCrY9Ke3
         l6docqOiHFxJGkIFMij6p7hgL2HDjt1w78PVxxoVGKjD3ECPffngiiEu3P93zuxsxm
         HJfc5TVxSviFw==
Received: by mail-yb1-f176.google.com with SMTP id k31so3439357ybj.4;
        Wed, 02 Feb 2022 15:16:22 -0800 (PST)
X-Gm-Message-State: AOAM533tBIWQKgXCxhRcFKNmwSUXNnKs/AoHDimD//g2YmcbNFUW3ynX
        CxKLXkCjMBe/Sp0sebGtn5AHhgwrggLOdI7iptk=
X-Google-Smtp-Source: ABdhPJyqnkjSpCfTwycqtpnJGQcUFvpXCn2RkCP8NV+uz1BDIwW0ntf6KrGq7wQZhvj3Co4Bv30GU06o2oKq6MOpHV8=
X-Received: by 2002:a25:b217:: with SMTP id i23mr48951849ybj.722.1643843781926;
 Wed, 02 Feb 2022 15:16:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:b08e:b0:127:3295:9956 with HTTP; Wed, 2 Feb 2022
 15:16:21 -0800 (PST)
In-Reply-To: <YfdCElWBOdOnsH5b@zeniv-ca.linux.org.uk>
References: <YfdCElWBOdOnsH5b@zeniv-ca.linux.org.uk>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 3 Feb 2022 08:16:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-k=AvMcxsJg1rVsY2PPhsZuRUegqAhEFB2r-qXH3+5-w@mail.gmail.com>
Message-ID: <CAKYAXd-k=AvMcxsJg1rVsY2PPhsZuRUegqAhEFB2r-qXH3+5-w@mail.gmail.com>
Subject: Re: [ksmbd] racy uses of ->d_parent and ->d_name
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-01-31 10:57 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> 	Folks, ->d_name and ->d_parent are *NOT* stable unless the
> appropriate locks are held.  In particular, locking a directory that
> might not be our parent is obviously not going to prevent anything.
> Even if it had been our parent at some earlier point.
Hi Al,

First, Thanks for pointing that out!
>
> 	->d_lock would suffice, but it can't be held over blocking
> operation and it can't be held over dcache lookups anyway (instant
> deadlocks).  IOW, the following is racy:
>
> int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry
> *parent,
>                           struct dentry *child)
> {
>         struct dentry *dentry;
>         int ret = 0;
>
>         inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
>         dentry = lookup_one(user_ns, child->d_name.name, parent,
>                             child->d_name.len);
>         if (IS_ERR(dentry)) {
>                 ret = PTR_ERR(dentry);
>                 goto out_err;
>         }
>
>         if (dentry != child) {
>                 ret = -ESTALE;
>                 dput(dentry);
>                 goto out_err;
>         }
>
>         dput(dentry);
>         return 0;
> out_err:
>         inode_unlock(d_inode(parent));
>         return ret;
> }
>
>
> 	Some of that might be fixable - verifying that ->d_parent points
> to parent immediately after inode_lock would stabilize ->d_name in case
> of match.  However, a quick look through the callers shows e.g. this:
>                 write_lock(&ci->m_lock);
>                 if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
>                         dentry = filp->f_path.dentry;
>                         dir = dentry->d_parent;
>                         ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
>                         write_unlock(&ci->m_lock);
>                         ksmbd_vfs_unlink(file_mnt_user_ns(filp), dir,
> dentry);
>                         write_lock(&ci->m_lock);
>                 }
>                 write_unlock(&ci->m_lock);
>
> 	What's to keep dir from getting freed right under us, just as
> ksmbd_vfs_lock_parent() (from ksmbd_vfs_unlink()) tries to grab ->i_rwsem
> on its inode?
Right. We need to get parent using dget_parent().
>
> 	Have the file moved to other directory and apply memory pressure.
> What's to prevent dir from being evicted, its memory recycled, etc.?
Let me check it.
>
> 	For another fun example, consider e.g. smb2_rename():
>                 if (file_present &&
>                     strncmp(old_name, path.dentry->d_name.name,
> strlen(old_name))) {
>                         rc = -EEXIST;
>                         ksmbd_debug(SMB,
>                                     "cannot rename already existing
> file\n");
>                         goto out;
>                 }
>
> Suppose path.dentry has a name longer than 32 bytes (i.e. too large to
> fit into ->d_iname and thus allocated separately).  At this point you
> are not holding any locks (otherwise ksmbd_vfs_fp_rename() immediately
> downstream would deadlock).  So what's to prevent rename(2) on host
> ending up with path.dentry getting renamed and old name getting freed?
>
> 	More of the same: ksmbd_vfs_fp_rename().  In this one
> dget_parent() will at least avoid parent getting freed.  It won't do
> a damn thing to stabilize src_dent->d_name after lock_rename(),
> though, since we are not guaranteed that the thing we locked is
> still the parent...
Okay, I will check it.
>
> 	Why is so much tied to "open, then figure out where it is" model?
> Is it a legacy of userland implementation, or a network fs protocol that
> manages to outsuck NFS, or...?
It need to use absolute based path given from request.

Thanks!
>
