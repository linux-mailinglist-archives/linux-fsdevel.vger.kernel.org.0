Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037C0434B1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhJTM1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTM1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:27:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D7C06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 05:25:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w14so24390297edv.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JB7H3ohM5l70AQemzmGYYtizSnnDY/xIC1TQbSPrjbg=;
        b=rLU0zY3vuETlD8DmXa6icR4V0aZP7SDSFOv0A6gC6PjWLkWUnOXPevqNLUuFKMGfRd
         P3YPsN0m9K+kbIJpG0XJuYnNvFuqUkKY1tqTd83Dgp/ML8j+TqRT2WMJkVKvMM2DrFXM
         WMikcrl5blUx0kl36C9sOUF8R+OmPP0b7ult7a5I7yAPYzbbutNNxvHbnOzpKZXsUwE9
         eFdh2zLJ9aRW5t8WLT6PbcQCcdj6qj3XAZu58vuOl6e5ci73vbDUMrlWroby41Ry7drM
         qsdaWrj3JDOj8QnhA/ow2VgGlOwItBtfQoQCh8HAmXYot9iY0Lxg6OWLD/ccRlL1kMiI
         kaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JB7H3ohM5l70AQemzmGYYtizSnnDY/xIC1TQbSPrjbg=;
        b=TEAq2EFsgj2f/VotT1GvNZDQVCh+neBHHeP0kRuq2/oq6iFXiOgIBgUmfYyHToQsFN
         NFdgX8m8jRzF0Y3yQ/BX+mcq19TMPPR9cjQOAXqwYsBSCicyhhKuTAj9yfNDUgMIzut/
         fS4bewGN8RIXZdBsbV+XsV+TT2AIvP9B1nwuUu7HW1L9bt0G4HRM6JnJ2Isbk6DlkCzF
         aRZEVpoJwjlVGbbxROMwawGFguKKhjntBKnqAsMmf3tayzHUnktpKv3APfbVBEGWWfPQ
         d5WFeMvwqxAHyJD5YXXb35q+wWyjec0M20aEYYqiz/h+1BmBYUNRZMT+QqgN6GE+SQ04
         iQEQ==
X-Gm-Message-State: AOAM5334C4oqcx9j7gNyOqVtcg8ecNiLDVQiOBHA33sdk6Bwk8cP8yOz
        3bVLbKeWyqiNHtc7e1sD27n4c41luaeSv51nDi5/
X-Google-Smtp-Source: ABdhPJwXIr+e4+zM4WzBAc+p0tdkWxFt1PkMYpHZJVn7kSklMh9yyHrMX7sFePN1X9RSG+jO5qK0R7JOU1xxwB9QGVw=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr63176602edb.209.1634732695469;
 Wed, 20 Oct 2021 05:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <YWWMO/ZDrvDZ5X4c@redhat.com>
In-Reply-To: <YWWMO/ZDrvDZ5X4c@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Oct 2021 08:24:44 -0400
Message-ID: <CAHC9VhRv8xOoPtfpSYSvUrcHUjhqQWw5LiDSfwR2f4VJ=9Qr8Q@mail.gmail.com>
Subject: Re: [PATCH v2] security: Return xattr name from security_dentry_init_security()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Dan Walsh <dwalsh@redhat.com>, jlayton@kernel.org,
        idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, bfields@fieldses.org,
        chuck.lever@oracle.com, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 9:23 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Right now security_dentry_init_security() only supports single security
> label and is used by SELinux only. There are two users of of this hook,
> namely ceph and nfs.
>
> NFS does not care about xattr name. Ceph hardcodes the xattr name to
> security.selinux (XATTR_NAME_SELINUX).
>
> I am making changes to fuse/virtiofs to send security label to virtiofsd
> and I need to send xattr name as well. I also hardcoded the name of
> xattr to security.selinux.
>
> Stephen Smalley suggested that it probably is a good idea to modify
> security_dentry_init_security() to also return name of xattr so that
> we can avoid this hardcoding in the callers.
>
> This patch adds a new parameter "const char **xattr_name" to
> security_dentry_init_security() and LSM puts the name of xattr
> too if caller asked for it (xattr_name != NULL).
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>
> Changes since v1:
> - Updated comment to make it clear caller does not have to free the
>   xattr_name. (Jeff Layton).
> - Captured Jeff's Reviewed-by ack.
>
> I have tested this patch with virtiofs and compile tested for ceph and nfs.
>
> NFS changes are trivial. Looking for an ack from NFS maintainers.
>
> ---
>  fs/ceph/xattr.c               |    3 +--
>  fs/nfs/nfs4proc.c             |    3 ++-
>  include/linux/lsm_hook_defs.h |    3 ++-
>  include/linux/lsm_hooks.h     |    3 +++
>  include/linux/security.h      |    6 ++++--
>  security/security.c           |    7 ++++---
>  security/selinux/hooks.c      |    6 +++++-
>  7 files changed, 21 insertions(+), 10 deletions(-)

This looks fine to me and considering the trivial nature of the NFS
changes I'm okay with merging this without an explicit ACK from the
NFS folks.  Similarly, I generally dislike merging new functionality
once we hit -rc6, but this is trivial enough that I think it's okay;
I'm merging this into selinux/next now, thanks everyone.

-- 
paul moore
www.paul-moore.com
