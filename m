Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A74DBC57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 02:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358047AbiCQB2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 21:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358359AbiCQB2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:28:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3555F1E3D0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 18:26:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d10so7679978eje.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 18:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZR/DEFbOpOOseNzxrxorA6yZUP/TbtoQM/q0IPLkfmI=;
        b=Vu8cOWSSdPTLVcRWohewxdmLRQxVqX5G7SUHDcA67mA7+SrWHr8ow4ThRm5LEstvWw
         IEgjSEd40DMQ1+IuUFwzBi31HKFwIIugnArAA56pUoL/lCwAoWOIeQdo6+GfgQuQGcJF
         zUeNw3fttzU1sW03isEVvfnjfCJy6OTQ0xLKtSqR3SfSl7cvQGyMXzT4fc1DtcxKRKAk
         wnunvG9W4fBvoDor3vM9sCzsDHsVnD/Mp4meKn1Dwcpa0epLxP7p5elp53ZFcjAMOHKQ
         06WgrKjRIumAzcq80kxuCUU5aCuCa2wOzrqSREeWqIbzVytfZAQ3MqCGsc2b1I5woAMq
         pYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZR/DEFbOpOOseNzxrxorA6yZUP/TbtoQM/q0IPLkfmI=;
        b=1SFPwL91vlJtjEOZPCAk9OWaDz++S+Kd3lNdGN09OW7j2aj0vGSiusIVkk3q8iMTHE
         RbYORgOQtcG7ga+hFUMBM2c9D/SI0hC+JhX/kfl8ETY2HJakMp8oFNkoVwIv9pi41Mny
         b5XYcCgtAN7Nshq3OJzdcnGFni4P5ZYwNh+QgqoAXaUEOBVRNq+E5RcFlHudNw57tzTo
         seKUOAoOnqYGdkES3WgGVQGvHMxYTGl2D7+66Y9pKt1pAJvFB5hWd7bRZjiujmV497YH
         ATDylruScI1HT3eEjg1Ny1G59p6Ou/otUwFIu+MRUXtxG6woBffqvN62h0DryJm3ZPY6
         15Ig==
X-Gm-Message-State: AOAM532X0VJPAHHFxI1XKPGyHMzRXOU4eSlgyYZ4Ubgv7dwlg1dAbA6H
        cSmfohM3qMoraqGebNnoyY0TdKO0BhMnATZ42UBs
X-Google-Smtp-Source: ABdhPJxvlfdxiQVIVkvN+TVLMxt53sFBlWvNw3SKNONngtxOqYyCYTtz57lOjM+6whOanqUeaNe1D0+4YA97GtEkBVY=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr2152723ejc.701.1647480402665; Wed, 16
 Mar 2022 18:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-5-mic@digikod.net>
In-Reply-To: <20220221212522.320243-5-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:26:31 -0400
Message-ID: <CAHC9VhT7+Xm+GCg5BqYQgauKOwRxsxfS5WCj+-HW2w6VpaF=6g@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] landlock: Fix same-layer rule unions
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> The original behavior was to check if the full set of requested accesses
> was allowed by at least a rule of every relevant layer.  This didn't
> take into account requests for multiple accesses and same-layer rules
> allowing the union of these accesses in a complementary way.  As a
> result, multiple accesses requested on a file hierarchy matching rules
> that, together, allowed these accesses, but without a unique rule
> allowing all of them, was illegitimately denied.  This case should be
> rare in practice and it can only be triggered by the path_rename or
> file_open hook implementations.
>
> For instance, if, for the same layer, a rule allows execution
> beneath /a/b and another rule allows read beneath /a, requesting access
> to read and execute at the same time for /a/b should be allowed for this
> layer.
>
> This was an inconsistency because the union of same-layer rule accesses
> was already allowed if requested once at a time anyway.
>
> This fix changes the way allowed accesses are gathered over a path walk.
> To take into account all these rule accesses, we store in a matrix all
> layer granting the set of requested accesses, according to the handled
> accesses.  To avoid heap allocation, we use an array on the stack which
> is 2*13 bytes.  A following commit bringing the LANDLOCK_ACCESS_FS_REFER
> access right will increase this size to reach 84 bytes (2*14*3) in case
> of link or rename actions.
>
> Add a new layout1.layer_rule_unions test to check that accesses from
> different rules pertaining to the same layer are ORed in a file
> hierarchy.  Also test that it is not the case for rules from different
> layers.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-5-mic@digikod.net
> ---
>  security/landlock/fs.c                     |  77 ++++++++++-----
>  security/landlock/ruleset.h                |   2 +
>  tools/testing/selftests/landlock/fs_test.c | 107 +++++++++++++++++++++
>  3 files changed, 160 insertions(+), 26 deletions(-)
>
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 0bcb27f2360a..9662f9fb3cd0 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -204,45 +204,66 @@ static inline const struct landlock_rule *find_rule=
(
>         return rule;
>  }
>
> -static inline layer_mask_t unmask_layers(
> -               const struct landlock_rule *const rule,
> -               const access_mask_t access_request, layer_mask_t layer_ma=
sk)
> +/*
> + * @layer_masks is read and may be updated according to the access reque=
st and
> + * the matching rule.
> + *
> + * Returns true if the request is allowed (i.e. relevant layer masks for=
 the
> + * request are empty).
> + */
> +static inline bool unmask_layers(const struct landlock_rule *const rule,
> +               const access_mask_t access_request,
> +               layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS]=
)
>  {
>         size_t layer_level;
>
> +       if (!access_request || !layer_masks)
> +               return true;
>         if (!rule)
> -               return layer_mask;
> +               return false;
>
>         /*
>          * An access is granted if, for each policy layer, at least one r=
ule
> -        * encountered on the pathwalk grants the requested accesses,
> -        * regardless of their position in the layer stack.  We must then=
 check
> +        * encountered on the pathwalk grants the requested access,
> +        * regardless of its position in the layer stack.  We must then c=
heck
>          * the remaining layers for each inode, from the first added laye=
r to
> -        * the last one.
> +        * the last one.  When there is multiple requested accesses, for =
each
> +        * policy layer, the full set of requested accesses may not be gr=
anted
> +        * by only one rule, but by the union (binary OR) of multiple rul=
es.
> +        * E.g. /a/b <execute> + /a <read> =3D /a/b <execute + read>
>          */
>         for (layer_level =3D 0; layer_level < rule->num_layers; layer_lev=
el++) {
>                 const struct landlock_layer *const layer =3D
>                         &rule->layers[layer_level];
>                 const layer_mask_t layer_bit =3D BIT_ULL(layer->level - 1=
);
> +               const unsigned long access_req =3D access_request;
> +               unsigned long access_bit;
> +               bool is_empty;
>
> -               /* Checks that the layer grants access to the full reques=
t. */
> -               if ((layer->access & access_request) =3D=3D access_reques=
t) {
> -                       layer_mask &=3D ~layer_bit;
> -
> -                       if (layer_mask =3D=3D 0)
> -                               return layer_mask;
> +               /*
> +                * Records in @layer_masks which layer grants access to e=
ach
> +                * requested access.
> +                */
> +               is_empty =3D true;
> +               for_each_set_bit(access_bit, &access_req,
> +                               ARRAY_SIZE(*layer_masks)) {
> +                       if (layer->access & BIT_ULL(access_bit))
> +                               (*layer_masks)[access_bit] &=3D ~layer_bi=
t;
> +                       is_empty =3D is_empty && !(*layer_masks)[access_b=
it];

From what I can see the only reason not to return immediately once
@is_empty is true is the need to update @layer_masks.  However, the
only caller that I can see (up to patch 4/11) is check_access_path()
which thanks to this patch no longer needs to reference @layer_masks
after the call to unmask_layers() returns true.  Assuming that to be
the case, is there a reason we can't return immediately after finding
@is_empty true, or am I missing something?


>                 }
> +               if (is_empty)
> +                       return true;
>         }
> -       return layer_mask;
> +       return false;
>  }
>
>  static int check_access_path(const struct landlock_ruleset *const domain=
,
>                 const struct path *const path,
>                 const access_mask_t access_request)
>  {
> -       bool allowed =3D false;
> +       layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> +       bool allowed =3D false, has_access =3D false;
>         struct path walker_path;
> -       layer_mask_t layer_mask;
>         size_t i;
>
>         if (!access_request)
> @@ -262,13 +283,20 @@ static int check_access_path(const struct landlock_=
ruleset *const domain,
>                 return -EACCES;
>
>         /* Saves all layers handling a subset of requested accesses. */
> -       layer_mask =3D 0;
>         for (i =3D 0; i < domain->num_layers; i++) {
> -               if (domain->fs_access_masks[i] & access_request)
> -                       layer_mask |=3D BIT_ULL(i);
> +               const unsigned long access_req =3D access_request;
> +               unsigned long access_bit;
> +
> +               for_each_set_bit(access_bit, &access_req,
> +                               ARRAY_SIZE(layer_masks)) {
> +                       if (domain->fs_access_masks[i] & BIT_ULL(access_b=
it)) {
> +                               layer_masks[access_bit] |=3D BIT_ULL(i);
> +                               has_access =3D true;
> +                       }
> +               }
>         }
>         /* An access request not handled by the domain is allowed. */
> -       if (layer_mask =3D=3D 0)
> +       if (!has_access)
>                 return 0;
>
>         walker_path =3D *path;
> @@ -280,14 +308,11 @@ static int check_access_path(const struct landlock_=
ruleset *const domain,
>         while (true) {
>                 struct dentry *parent_dentry;
>
> -               layer_mask =3D unmask_layers(find_rule(domain,
> -                                       walker_path.dentry), access_reque=
st,
> -                               layer_mask);
> -               if (layer_mask =3D=3D 0) {
> +               allowed =3D unmask_layers(find_rule(domain, walker_path.d=
entry),
> +                               access_request, &layer_masks);
> +               if (allowed)
>                         /* Stops when a rule from each layer grants acces=
s. */
> -                       allowed =3D true;
>                         break;
> -               }
>
>  jump_up:
>                 if (walker_path.dentry =3D=3D walker_path.mnt->mnt_root) =
{

--
paul-moore.com
