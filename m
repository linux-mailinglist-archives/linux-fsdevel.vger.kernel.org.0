Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505CF4F8C25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiDHBoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 21:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiDHBoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:44:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D7F12F6C7
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 18:42:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r10so8438932eda.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Apr 2022 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xCv5DXX9ijy/PE+Fv/yKOblKDG06N2ROExnKPiddkiU=;
        b=xHLU3VTS2ptDA+EsiDb9d9GAPmO0xeEyazs1bLbJ/QVB1T+jdO4hti7wvExaysx1NL
         PoGR5EswnEEgQpsHXqcpfB85DFTiQZtd7CvTzp7uWaKp5nQCHJ3l8X9oAPUCtimQHu3B
         AZGE59pcru7eafp+3nm5XPQEaX+9Xw03eyr1oylhuISY7jlV+ju4dh9i/JcZFQPOK3eL
         eVH7g+HkVs0mEGJt9BKjzqCJwjMFrVDrG0/W8Ut9g0YWnbZRAbaBzHXIA9SRbV7DQX1l
         irC4aEnS+ULqzznFCktV2CDAgS/sEUiWKedCnKSN5FBv5ztl4OmIUA07SK0fdLxONCZk
         OjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xCv5DXX9ijy/PE+Fv/yKOblKDG06N2ROExnKPiddkiU=;
        b=vPUdeHglA6fjkE9HvlzJIfdvG6xsyMJVVUF7Q9cEE8uqBdnQ/wbJqEqpi3kibliryM
         1O9KptDpBKwFtqCOt8ftTBFrDJyoiF7dth5BcXZe45yE70srYZMqXrbHuTuER1aIeppG
         tt49Q8c5xJjgP/g44o20L53eWxt6olGHyJuzFnfoUakQmKg7/kdQ+f125CR7b396h7jp
         AOGvQZmKVWIVqbDVcmd3BhUIz3ItSy3kd9DBnaQ8ZXYfdS8x490qCYcQ9BJkJIyKUr/n
         mtza28iTYfTsjtDJjzrEjD3WgL2sYwzSR1ER/r3ZKitDNhA3isyIx35px5oTVVcJyTdx
         T22w==
X-Gm-Message-State: AOAM531T6gYFfzx4+U9r+tZQCaMCDH69eSkkYgiKHNEz1o52p9ZUZFL2
        0z/WNYn/fUFC2kl17tpL0fABxxBDcu1b6AyTQ8It
X-Google-Smtp-Source: ABdhPJxO+N6oGriDELXQ6Ik1rLFnHwovOpG6Sz/8grFw7AbhwJUqwHvTAcztCZnXDsMAvXbi8gwPJkt7rR9hql0VoiI=
X-Received: by 2002:a05:6402:35c9:b0:41d:1447:5f9f with SMTP id
 z9-20020a05640235c900b0041d14475f9fmr3711479edc.343.1649382132419; Thu, 07
 Apr 2022 18:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220329125117.1393824-1-mic@digikod.net> <20220329125117.1393824-8-mic@digikod.net>
In-Reply-To: <20220329125117.1393824-8-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Apr 2022 21:42:01 -0400
Message-ID: <CAHC9VhQpZ12Chgd+xMibUxgvcPjTn9FMnCdMGYbLcWG3eTqDQg@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 8:51 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> Add a new LANDLOCK_ACCESS_FS_REFER access right to enable policy writers
> to allow sandboxed processes to link and rename files from and to a
> specific set of file hierarchies.  This access right should be composed
> with LANDLOCK_ACCESS_FS_MAKE_* for the destination of a link or rename,
> and with LANDLOCK_ACCESS_FS_REMOVE_* for a source of a rename.  This
> lift a Landlock limitation that always denied changing the parent of an
> inode.
>
> Renaming or linking to the same directory is still always allowed,
> whatever LANDLOCK_ACCESS_FS_REFER is used or not, because it is not
> considered a threat to user data.
>
> However, creating multiple links or renaming to a different parent
> directory may lead to privilege escalations if not handled properly.
> Indeed, we must be sure that the source doesn't gain more privileges by
> being accessible from the destination.  This is handled by making sure
> that the source hierarchy (including the referenced file or directory
> itself) restricts at least as much the destination hierarchy.  If it is
> not the case, an EXDEV error is returned, making it potentially possible
> for user space to copy the file hierarchy instead of moving or linking
> it.
>
> Instead of creating different access rights for the source and the
> destination, we choose to make it simple and consistent for users.
> Indeed, considering the previous constraint, it would be weird to
> require such destination access right to be also granted to the source
> (to make it a superset).  Moreover, RENAME_EXCHANGE would also add to
> the confusion because of paths being both a source and a destination.
>
> See the provided documentation for additional details.
>
> New tests are provided with a following commit.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220329125117.1393824-8-mic@digikod.net
> ---
>
> Changes since v1:
> * Update current_check_access_path() to efficiently handle
>   RENAME_EXCHANGE thanks to the updated LSM hook (see previous patch).
>   Only one path walk is performed per rename arguments until their
>   common mount point is reached.  Superset of access rights is correctly
>   checked, including when exchanging a file with a directory.  This
>   requires to store another matrix of layer masks.
> * Reorder and rename check_access_path_dual() arguments in a more
>   generic way: switch from src/dst to 1/2.  This makes it easier to
>   understand the RENAME_EXCHANGE cases alongs with the others.  Update
>   and improve check_access_path_dual() documentation accordingly.
> * Clean up the check_access_path_dual() loop: set both allowed_parent*
>   when reaching internal filesystems and remove a useless one.  This
>   allows potential renames in internal filesystems (like for other
>   operations).
> * Move the function arguments checks from BUILD_BUG_ON() to
>   WARN_ON_ONCE() to avoid clang build error.
> * Rename is_superset() to no_more_access() and make it handle superset
>   checks of source and destination for simple and exchange cases.
> * Move the layer_masks_child* creation from current_check_refer_path()
>   to check_access_path_dual(): this is simpler and less error-prone,
>   especially with RENAME_EXCHANGE.
> * Remove one optimization in current_check_refer_path() to make the code
>   simpler, especially with the RENAME_EXCHANGE handling.
> * Remove overzealous WARN_ON_ONCE() for !access_request check in
>   init_layer_masks().
> ---
>  include/uapi/linux/landlock.h                |  27 +-
>  security/landlock/fs.c                       | 607 ++++++++++++++++---
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   3 +-
>  6 files changed, 566 insertions(+), 77 deletions(-)

I'm still not going to claim that I'm a Landlock expert, but this
looks sane to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> +static inline access_mask_t init_layer_masks(
> +               const struct landlock_ruleset *const domain,
> +               const access_mask_t access_request,
> +               layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS]=
)
> +{
> +       access_mask_t handled_accesses =3D 0;
> +       size_t layer_level;
> +
> +       memset(layer_masks, 0, sizeof(*layer_masks));
> +       /* An empty access request can happen because of O_WRONLY | O_RDW=
R. */

 ;)

--=20
paul-moore.com
