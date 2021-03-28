Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70FC34BF77
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 23:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhC1VuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 17:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC1Vtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 17:49:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D4C061756;
        Sun, 28 Mar 2021 14:49:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so6760287pjc.2;
        Sun, 28 Mar 2021 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/zvfTvdxk0vbwiBYUAI5cCrEALj8Ff0dONrOmIH+zLA=;
        b=HLhc8rnAnNPkEhC+I9pOWaUrTUqpGRb/B57xQk/Yj9EoCWlUn8j51wySzBrPi58cTj
         s9i6JZZdRHDB5SMOMe/xQLnuoGWZAxLrZb3ecKC1o1ZgjJFHMblehze4vDOxTXnJcs5u
         U1vQcoHOsUClqcGqGHU6JKDpp6Kdt+MIzKp6ynfPuoAUgsTtksTQw83l5TQDSIlVR8kl
         GfEhdw/0QNr6kuTSCvNVocjeVWIDOQWIS82JOS8rwje5jbXoxq+DLkoMfqgOA/pZPvk6
         4cpCJ46n57++EiqJyr2ZDfMIRzNYt9mKE8VSskhB5vpI8wOhOUy9udZGInaZvY2tpVSE
         V/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/zvfTvdxk0vbwiBYUAI5cCrEALj8Ff0dONrOmIH+zLA=;
        b=INCR1pq6oxNS/rqEPi1TKqFDa2O3O+v+pbCPPO3UdUXS3TA5vZQMQi6X3FXRetI2UV
         VjG8aQq2CCjZ5N1GsS3E595H8uL5e2e7KyTDkE3nHxsKPEAOPiZjASi1DjwK6c8sKLGo
         6LCF6GabSTCjGOx9Pi3TZFgwvOPbjbp90o3YiIII90n7faUTtGQlz6XrzITslbCgkKIz
         7UwQC5pjfDf8spvEgVM8ruMioLNjnrht7j7D55trhydsEY00CYJMY4tnOExgkXLX54nS
         LG6/UlQybWj45p37qX1gw+9IRNgBC8rZTBOiAkFLJH6xqbvQVs+W5gUg/hrj4QtKxIfY
         6xqw==
X-Gm-Message-State: AOAM533QR+rBzERu/SRGevrB4zKgCtmZQlOJvFpFT+E9flcH0uQUYOiz
        DpujHqBvtpI078qIidBK++c=
X-Google-Smtp-Source: ABdhPJxK9s39yP05OYtTDS4bPnOImGthNz79kJm6kLScqC6/bcisYGD7jvNtpXxN/z+0l3vEBnljTQ==
X-Received: by 2002:a17:90a:f3d7:: with SMTP id ha23mr22840428pjb.130.1616968192329;
        Sun, 28 Mar 2021 14:49:52 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id i4sm15819093pfo.14.2021.03.28.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 14:49:51 -0700 (PDT)
Date:   Sun, 28 Mar 2021 14:47:30 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move_mount: allow to add a mount into an existing group
Message-ID: <YGD5cqCb9IM907NL@gmail.com>
References: <20210325121444.87140-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210325121444.87140-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:14:44PM +0300, Pavel Tikhomirov wrote:
> Previously a sharing group (shared and master ids pair) can be only
> inherited when mount is created via bindmount. This patch adds an
> ability to add an existing private mount into an existing sharing group.
> 
> With this functionality one can first create the desired mount tree from
> only private mounts (without the need to care about undesired mount
> propagation or mount creation order implied by sharing group
> dependencies), and next then setup any desired mount sharing between
> those mounts in tree as needed.
> 
> This allows CRIU to restore any set of mount namespaces, mount trees and
> sharing group trees for a container.
> 
> We have many issues with restoring mounts in CRIU related to sharing
> groups and propagation:
> - reverse sharing groups vs mount tree order requires complex mounts
>   reordering which mostly implies also using some temporary mounts
> (please see https://lkml.org/lkml/2021/3/23/569 for more info)
> 
> - mount() syscall creates tons of mounts due to propagation
> - mount re-parenting due to propagation
> - "Mount Trap" due to propagation
> - "Non Uniform" propagation, meaning that with different tricks with
>   mount order and temporary children-"lock" mounts one can create mount
>   trees which can't be restored without those tricks
> (see https://www.linuxplumbersconf.org/event/7/contributions/640/)
> 
> With this new functionality we can resolve all the problems with
> propagation at once.
> 

Thanks for picking this up. Overall it looks good for me. Here is one
comment inline.

> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: lkml <linux-kernel@vger.kernel.org>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> 
> ---
> This is a rework of "mnt: allow to add a mount into an existing group"
> patch from Andrei. https://lkml.org/lkml/2017/4/28/20
> 
> New do_set_group is similar to do_move_mount, but with many restrictions
> of do_move_mount removed and that's why:
> 
> 1) Allow "cross-namespace" sharing group set. If we allow operation only
> with mounts from current+anon mount namespace one would still be able to
> setns(from_mntns) + open_tree(from, OPEN_TREE_CLONE) + setns(to_mntns) +
> move_mount(anon, to, MOVE_MOUNT_SET_GROUP) to set sharing group to mount
> in different mount namespace with source mount. But with this approach
> we would need to create anon mount namespace and mount copy each time,
> which is just a waste of resources. So instead lets just check if we are
> allowed to modify both mount namespaces (which looks equivalent to what
> setns-es and open_tree check).
> 
> 2) Allow operating on non-root dentry of the mount. As if we prohibit it
> this would require extra care from CRIU side in places where we wan't to
> copy sharing group from mount on host (for external mounts) and user
> gives us path to non-root dentry. I don't see any problem with
> referencing mount with any dentry for sharing group setting. Also there
> is no problem with referencing one by file and one by directory.
> 
> 3) Also checks wich only apply to actually moving mount which we have in
> do_move_mount and open_tree are skipped. We don't need to check
> MNT_LOCKED, unbindable, nsfs loops and ancestor relation as we don't
> move mounts.
> 
> Security note: there would be no (new) loops in sharing groups tree,
> because this new move_mount(MOVE_MOUNT_SET_GROUP) operation only adds
> one _private_ mount to one group (without moving between groups), the
> sharing groups tree itself stays unchanged after it.
> 
> In Virtuozzo we have "mount-v2" implementation, based with the original
> kernel patch from Andrei, tested for almost a year and it actually
> decreased number of bugs with mounts a lot. One can take a look on the
> implementation of sharing group restore in CRIU in "mount-v2" here:
> 
> https://src.openvz.org/projects/OVZ/repos/criu/browse/criu/mount-v2.c#898
> 
> This works almost the same with current version of patch if we replace
> mount(MS_SET_GROUP) to move_mount(MOVE_MOUNT_SET_GROUP), please see
> super-draft port for mainstream criu, this at least passes
> non-user-namespaced mount tests (zdtm.py --mounts-v2 -f ns).
> 
> https://github.com/Snorch/criu/commits/mount-v2-poc
> 
> ---
>  fs/namespace.c             | 57 +++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/mount.h |  3 +-
>  2 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 9d33909d0f9e..ab439d8510dd 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2660,6 +2660,58 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
>  	return ret;
>  }
>  
> +static int do_set_group(struct path *from_path, struct path *to_path)
> +{
> +	struct mount *from, *to;
> +	int err;
> +
> +	from = real_mount(from_path->mnt);
> +	to = real_mount(to_path->mnt);
> +
> +	namespace_lock();
> +
> +	err = -EINVAL;
> +	/* To and From must be mounted */
> +	if (!is_mounted(&from->mnt))
> +		goto out;
> +	if (!is_mounted(&to->mnt))
> +		goto out;
> +
> +	err = -EPERM;
> +	/* We should be allowed to modify mount namespaces of both mounts */
> +	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +		goto out;
> +	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +		goto out;
> +
> +	err = -EINVAL;
> +	/* Setting sharing groups is only allowed across same superblock */
> +	if (from->mnt.mnt_sb != to->mnt.mnt_sb)
> +		goto out;

I think we need to check that mnt_root of "to" is in the sub-tree of
mnt_root of "from". Otherwise, there can be a case when a user will get
access to some extra mounts

For example, let's imagine that we have three mounts:
A: root: /test/subtest shared: 1
B: root: /test
C: root: / shared: 1

A and B is in the same mount namespaces and a test user can access them.

C is in another namespace and the user can't access it.

Now, we add B to the shared group of A and then another user mounts a
forth mount to /C/test/subtest2. If we allow to add B to the shared
group of A, our test user will get access to the new mount via
B/test/subtest2.

Thanks,
Andrei

