Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861C34DBC5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 02:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358252AbiCQB1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 21:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351869AbiCQB1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:27:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D564A1DA68
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 18:26:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so7741725ejb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9nqOkKXFqcKmZfXRa5UJynBrVNrscJsENfEMYF+znck=;
        b=VBreYxdLWKIcXeOKDZeW7+NMjoymm8jD8AQqiGK7oypua6J/BnnNi/1AeRVWVvBWZF
         +b0XiC63C5zEgd//XuM3dVzaM/1UYZeomW7WbixMwAkebyQw+U+MrbRZAKQwJRq9MyF6
         C3G8T8jezxM9E2VBsPYGl9TAGNHfNlsGHNwsXOzdYacdjugGeGWMgvmWRP79E7pWP6FA
         KDHXqnNRF8DRzMeCnX0G0GJwukTMSCSUuRj09L2Xx/aVqfdS7s5h2jKV98TwPK+gUs+6
         yLcj4/5DQiyzsKuC8v7RsvZig+ZOsI/uUIIH//+81aShcAv9ixd9AqEcL2a81LL63EqM
         ICcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9nqOkKXFqcKmZfXRa5UJynBrVNrscJsENfEMYF+znck=;
        b=0azu+28dbg+a0Cd6aMOQDIaP/NCCmH5zmWiYbjDboc5c6TTgapJvyRnKI9QkreiJ1Z
         kHwfWoIvl8hLoEhs5kjCRFjedjUwccB2YwtybD6epjgH91TG5TCATyjaZdz17HVD8Fvr
         kA85kljST8Gk9J0rxOKNm/QQky4b26JvkM0kKUNVA7KRgbs2nZU4ZT0vx5HDveQQUh85
         6f/Zkq6EF/0hiJRYK4rAk9tYGLzeDtiqDzV/8Oow71tGb2PR/myOfWMKMKwJPndI5q65
         q/7vfhZYPWkYYMj5wqTqlKs5P82KkU7FIeXZsstpy7TEvDkbh8GFEH0WGM4DPa+oMWsa
         3wpA==
X-Gm-Message-State: AOAM533akjWXs8QTqNqOYhnklk+VWg7dBH73Yn2zyipX0JDeyfMNZpIF
        MGmEpI/QGrjprAo7+nOv+aFV7Gv0ptUCUD5NF03X
X-Google-Smtp-Source: ABdhPJySNskf/+8Fh5IzexNPvLQTCJajZLf9duMCXqhf8HBRSKHqyikrX8XMbJUrminYAh2x5IhL8ig/1EJYV0Np6lE=
X-Received: by 2002:a17:907:9803:b0:6db:ab21:738e with SMTP id
 ji3-20020a170907980300b006dbab21738emr2166666ejc.112.1647480387381; Wed, 16
 Mar 2022 18:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-3-mic@digikod.net>
In-Reply-To: <20220221212522.320243-3-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:26:16 -0400
Message-ID: <CAHC9VhSAc37rX1jFNpvRczkvbfdALYkP2xm3jPbAm8Eqnp9erw@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] landlock: Reduce the maximum number of layers to 16
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> The maximum number of nested Landlock domains is currently 64.  Because
> of the following fix and to help reduce the stack size, let's reduce it
> to 16.  This seems large enough for a lot of use cases (e.g. sandboxed
> init service, spawning a sandboxed SSH service, in nested sandboxed
> containers).  Reducing the number of nested domains may also help to
> discover misuse of Landlock (e.g. creating a domain per rule).
>
> Add and use a dedicated layer_mask_t typedef to fit with the number of
> layers.  This might be useful when changing it and to keep it consistent
> with the maximum number of layers.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-3-mic@digikod.net
> ---
>  security/landlock/fs.c                     | 13 +++++--------
>  security/landlock/limits.h                 |  2 +-
>  security/landlock/ruleset.h                |  4 ++++
>  tools/testing/selftests/landlock/fs_test.c |  2 +-
>  4 files changed, 11 insertions(+), 10 deletions(-)

I'm assuming that the drop in Landlock nesting down to 16 isn't going
to cause any userspace breakage :)

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
