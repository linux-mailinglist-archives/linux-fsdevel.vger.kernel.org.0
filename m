Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA05367D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 22:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350492AbiE0UFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiE0UFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 16:05:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBE20187
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 13:05:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so3316360wms.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hDs5pMehEzS9JtBcciO3du/140ZEedg4Xg+u6dsQZw=;
        b=oihAaWbcG7Yr9p0y5ULTKT7tU46NohvPTW+4VGetJ03GHSZRqq4LU+CPKg0Z2PrH5R
         b7AoPxPSIySEEsBuGcjzbeg273gPzUDiuDgPQe8t+O97X7MaFFmZxPWkqR1LY9W4beoO
         n00RsO520VB1zU12ITOAw5pKWroS+wVFZbCpC2euQgZwg2TwOVdcJe/hm29p06XZbpk9
         Sux3vMrXw4iwBHlCbOLNQjWoRtlyXEU5R6srtHjt5qRoh4UhA0D6F4jCnsUI6KqRNPOo
         yBXjUTB2xOyeoHGBTQdQEu/248CfGEyYoUye03xA0p2HIRWz4ulUElW6T5at8G4x+QOH
         iljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hDs5pMehEzS9JtBcciO3du/140ZEedg4Xg+u6dsQZw=;
        b=mUvcQxSwmZGQkWJDokOBPr0pd6w8uE7IrKTuPvfUSQeSAYgQ3wEXAPjoHsghkvt4Lr
         S35iO3IQ6Ypkugoc+XcWCbAHgGgMqd3WDUrYoHYGxBrCyLJN79KVLxkPO5apOL5+Yj5X
         w/YA+j18N8j0l/DyqazBGZnwRnFx24+3au0nYtHGc2QP3lN7+PhsO6dPoqgCp7i6S4O4
         WPz3aOaG9zgfYFBUQOzu9QPfQfL3xa3GuACGO8LDjDDSBNgf4/O8dhSQn32npbm/kKqO
         o4YOo+ZeDkc8qQluU8f9Fd8JpobBYj/xYryCKepjgb5+Fl1WObxAj7G14i8s6HWtKkqR
         lhYQ==
X-Gm-Message-State: AOAM533PVijcTewCKRCzRzsFRJBvu1lTBoMg8zF1f46S7svmwU7aYN7n
        S8Rrp7hW1PooNNQudTSox6u0czwZstCFic+d34lYwk+iBg==
X-Google-Smtp-Source: ABdhPJzSQiwbwdo8FqZ111McYTLFv4bwIxxTTbHCjxtpHRnG+P00gPgVzRWa/5Bdb55lusFwlbu3a5oOnOFQ3+tgAU8=
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id
 m5-20020a05600c3b0500b0039754ce0896mr8458182wms.3.1653681937794; Fri, 27 May
 2022 13:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220525183703.466936-1-fred@cloudflare.com>
In-Reply-To: <20220525183703.466936-1-fred@cloudflare.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 May 2022 16:05:26 -0400
Message-ID: <CAHC9VhS=_RvB66J9D5AZ+XnyDKupvTQpFzni2uvz348REPUT5A@mail.gmail.com>
Subject: Re: [PATCH v2] cred: Propagate security_prepare_creds() error code
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        serge@hallyn.com, amir73il@gmail.com, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 2:37 PM Frederick Lawler <fred@cloudflare.com> wrote:
>
> While experimenting with the security_prepare_creds() LSM hook, we
> noticed that our EPERM error code was not propagated up the callstack.
> Instead ENOMEM is always returned.  As a result, some tools may send a
> confusing error message to the user:
>
> $ unshare -rU
> unshare: unshare failed: Cannot allocate memory
>
> A user would think that the system didn't have enough memory, when
> instead the action was denied.
>
> This problem occurs because prepare_creds() and prepare_kernel_cred()
> return NULL when security_prepare_creds() returns an error code. Later,
> functions calling prepare_creds() and prepare_kernel_cred() return
> ENOMEM because they assume that a NULL meant there was no memory
> allocated.
>
> Fix this by propagating an error code from security_prepare_creds() up
> the callstack.
>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
>
> ---
> Changes since v1:
> - Revert style churn in ovl_create_or_link() noted by Amir
> - Revert style churn in prepare_nsset() noted by Serge
> - Update documentation for prepare_creds()
> - Set ofs->creator_cred in ovl_fill_super() and req->creds in aio_fsync()
>   to NULL on error noted by Amir
> ---
>  Documentation/security/credentials.rst |  6 +++---
>  fs/aio.c                               |  9 +++++++--
>  fs/cachefiles/security.c               |  8 ++++----
>  fs/cifs/cifs_spnego.c                  |  4 ++--
>  fs/cifs/cifsacl.c                      |  4 ++--
>  fs/coredump.c                          |  2 +-
>  fs/exec.c                              | 14 ++++++++-----
>  fs/ksmbd/smb_common.c                  |  4 ++--
>  fs/nfs/flexfilelayout/flexfilelayout.c |  7 +++++--
>  fs/nfs/nfs4idmap.c                     |  4 ++--
>  fs/nfsd/auth.c                         |  4 ++--
>  fs/nfsd/nfs4callback.c                 | 10 ++++-----
>  fs/nfsd/nfs4recover.c                  |  4 ++--
>  fs/nfsd/nfsfh.c                        |  4 ++--
>  fs/open.c                              |  8 ++++----
>  fs/overlayfs/dir.c                     |  6 ++++--
>  fs/overlayfs/super.c                   |  6 ++++--
>  kernel/capability.c                    |  4 ++--
>  kernel/cred.c                          | 28 +++++++++++++++-----------
>  kernel/groups.c                        |  4 ++--
>  kernel/nsproxy.c                       |  9 ++++++++-
>  kernel/sys.c                           | 28 +++++++++++++-------------
>  kernel/trace/trace_events_user.c       |  4 ++--
>  kernel/umh.c                           |  5 +++--
>  kernel/user_namespace.c                |  6 ++++--
>  net/dns_resolver/dns_key.c             |  4 ++--
>  security/apparmor/task.c               | 12 +++++------
>  security/commoncap.c                   | 20 +++++++++---------
>  security/keys/keyctl.c                 |  8 ++++----
>  security/keys/process_keys.c           | 16 +++++++--------
>  security/landlock/syscalls.c           |  4 ++--
>  security/selinux/hooks.c               |  8 ++++----
>  security/smack/smack_lsm.c             |  8 ++++----
>  security/smack/smackfs.c               |  4 ++--
>  34 files changed, 153 insertions(+), 123 deletions(-)

The SELinux bits look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

-- 
paul-moore.com
