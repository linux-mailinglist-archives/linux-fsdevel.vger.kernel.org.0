Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9766653B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 22:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjAKVCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 16:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjAKVB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:01:57 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7CE33D61
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 13:01:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bj3so13880519pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDgbngjc4v9HGzL/ZKWkcstZCFUyzlGIZCcGSy3FFCA=;
        b=WsMkYTl5yqbze0vWsTf158oLSXqd+897Dr0MupRoMzmx51RtDjTydjDuk5CXYJOvEw
         e5G9c09yCcj5y+wiv1360x8EenJR+WYRyfvBVJ5njODB0eEIGRVOy9jj3UCWkuuiHEFf
         +9JOO0fdap4i+XL0tWjEzuMoPm0Phk8mmZG2RmSzwIAHIG8huhtLiNtHNjvIWsHV0E3S
         FVPbKtqZSKLpkpJkh257UPq8dxIX2/U5AlUlJ9EKOP1Qph4sVtjFISMrr0PWCzj8IIN5
         3D/D3QldurtXvXh9KhkNAYsf7qGbGeovHcbwcqi1D6BG6paSO/mGGFPzFsimu4jvsbtK
         bY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDgbngjc4v9HGzL/ZKWkcstZCFUyzlGIZCcGSy3FFCA=;
        b=E4+yTHytdzROACC6KMz/FaXwjF8j1BGTQR6h7M3a/wLWTJE/q9LOVsHe/HdygWBSFj
         2QtExcZGtGKqoVXXuD90YJSyJ14ZDb599h/8w/m1C3BTgVoGr4wmSsZ7zk6IblYs9n2Z
         jUZss6f2zrUgEqSlPVNsZIbfUH+aYYvtOYFd6PesJD29kDRZGbsiEeEOqVS+Y3MtEnQR
         vYJ4aPCPs7NL5a00BVpoox+7Mz1oAAO8gFsYs4TxXbY85+2PpYcLYXHDNtv2Kwj01nqp
         M0LBOB/v7w91GHd7/3wc6b/Q6f+NaLN02/X4w5dNUWYdXmTw6JOBY/x1g2hVCTN310WR
         u2nw==
X-Gm-Message-State: AFqh2krrgzx6QBGzzTUtCN6uuvpiNqfFnPIuamv4+rBLSmbUxno2meUl
        kBLHcknfHtkoH5HT0HzgBPSh5nszMAT+J9yfAlXr
X-Google-Smtp-Source: AMrXdXuO/JSPoIm+SW4QsD6tJOdDldBAMKvvppWaRhaCdB/EDuDTPMqu//Odjq6YtT4urkgdiWdMBoyhJKpkJVoTWrM=
X-Received: by 2002:a17:90b:a18:b0:227:202b:8eaa with SMTP id
 gg24-20020a17090b0a1800b00227202b8eaamr1074377pjb.147.1673470889752; Wed, 11
 Jan 2023 13:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com> <20230109180717.58855-4-casey@schaufler-ca.com>
In-Reply-To: <20230109180717.58855-4-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Jan 2023 16:01:18 -0500
Message-ID: <CAHC9VhRwg8g--i1db9fkwOey5aU1b2-9nRBDRRzbYRRm_QVr6w@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] proc: Use lsmids instead of lsm names for attrs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 9, 2023 at 1:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Use the LSM ID number instead of the LSM name to identify which
> security module's attibute data should be shown in /proc/self/attr.
> The security_[gs]etprocattr() functions have been changed to expect
> the LSM ID. The change from a string comparison to an integer comparison
> in these functions will provide a minor performance improvement.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/proc/base.c           | 29 +++++++++++++++--------------
>  fs/proc/internal.h       |  2 +-
>  include/linux/security.h | 11 +++++------
>  security/security.c      | 11 +++++------
>  4 files changed, 26 insertions(+), 27 deletions(-)

...

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..9328b6b07dfc 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2837,27 +2838,27 @@ static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
>
>  #ifdef CONFIG_SECURITY_SMACK
>  static const struct pid_entry smack_attr_dir_stuff[] = {
> -       ATTR("smack", "current",        0666),
> +       ATTR(LSM_ID_SMACK, "current",   0666),
>  };
>  LSM_DIR_OPS(smack);
>  #endif
>
>  #ifdef CONFIG_SECURITY_APPARMOR
>  static const struct pid_entry apparmor_attr_dir_stuff[] = {
> -       ATTR("apparmor", "current",     0666),
> -       ATTR("apparmor", "prev",        0444),
> -       ATTR("apparmor", "exec",        0666),
> +       ATTR(LSM_ID_APPARMOR, "current",        0666),
> +       ATTR(LSM_ID_APPARMOR, "prev",           0444),
> +       ATTR(LSM_ID_APPARMOR, "exec",           0666),
>  };
>  LSM_DIR_OPS(apparmor);
>  #endif
>
>  static const struct pid_entry attr_dir_stuff[] = {
> -       ATTR(NULL, "current",           0666),
> -       ATTR(NULL, "prev",              0444),
> -       ATTR(NULL, "exec",              0666),
> -       ATTR(NULL, "fscreate",          0666),
> -       ATTR(NULL, "keycreate",         0666),
> -       ATTR(NULL, "sockcreate",        0666),
> +       ATTR(0, "current",      0666),
> +       ATTR(0, "prev",         0444),
> +       ATTR(0, "exec",         0666),
> +       ATTR(0, "fscreate",     0666),
> +       ATTR(0, "keycreate",    0666),
> +       ATTR(0, "sockcreate",   0666),

See the discussion in patch 1/8, we should use a macro instead of a 0
here (although the exact macro definition is very much up for
discussion):

  ATTR(LSM_ID_UNDEF, "current", 0666),

--
paul-moore.com
