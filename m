Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AEC4DBC6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 02:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358285AbiCQB2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 21:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358326AbiCQB22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:28:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40021E3FF
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 18:27:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w25so4787051edi.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QAkNyjcPXo50xRXiBUT4G4BKOrlhYx68SMmwnSYQIUg=;
        b=Dop/+ShLFtKuMTYbs0avRrPNmZRZ40QC2SmtXTlmz04dxVtPNxDxhRGFudiOqvIwm6
         R3gAzzL0hkk0N5TzLd1ljQC4uUPJHK0nhv+zbOKgZIDgVx1kXaef9XYL9QPla1N9G731
         ocDTST9XL0pebpbiSYt/1dDgRysC5RztIUJWh+0aXxxqJIPABloKVAYzFybdFrwrTyjz
         vGEJYN2L/NG4r7tyUsZZ6112tryS+UvP24z2ZtXWM47bVUCKeDJVPwnuPxaFn6bEfoz6
         SvNE6k19AGlgA/W62HboNA6G6DKj8snf1OE+8tuklUDC+vd3zXNP/t2r0piTSJb7MR18
         c+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QAkNyjcPXo50xRXiBUT4G4BKOrlhYx68SMmwnSYQIUg=;
        b=P8kgknNfzK3/810s3f6Qe3rKbHFjV++rZnI3WxYV8pjzNtXOTz8A1MM/6XACQ4Pife
         BD6KVm0JFhda0NtLIPD0OP3QcSUnoEDC8gknVbtV9q1VXa+rkNN+y1FohfzbapiUgtRz
         ykhtx+hTVc88WY2hwHglmYNSq1J1W/aqJvtIdeo3L11IC5/MJdhYjWKHC35xMtTzr3xc
         thnrZ970fVm2WOO81h1ks5xvusnBMafa1tI934bLO1PZy7/9MXY/bZRph7MVGpOcsWbu
         fRQnh8kCXZNK5l2yVnFz8GwmbySSFK98pQKp2puStCkjy7kMnOiii2r2kF6bMFUeMHdL
         Onwg==
X-Gm-Message-State: AOAM530Lfrmf76cKS3w5HIZN5UzZ06EBd88ptWVfUhk9TW010ezklgif
        uMfE7IijOMHxThFvAAnHO7UwZQ+iBqizDyKW8ONpH22HoQ==
X-Google-Smtp-Source: ABdhPJwvcSOYeRU2KF1gD7ArNsblZMaIVYldliadYwwMoupQSk1zheXGCuBymGxEsIlS1e5x/4T0yCrEKAfYQiikRZk=
X-Received: by 2002:a05:6402:d2:b0:413:2e50:d6fd with SMTP id
 i18-20020a05640200d200b004132e50d6fdmr1997123edu.171.1647480419862; Wed, 16
 Mar 2022 18:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-7-mic@digikod.net>
In-Reply-To: <20220221212522.320243-7-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:26:48 -0400
Message-ID: <CAHC9VhSFXN39EuVG5aVK0jtgCOmzM2FSCoVa2Xrs=oJQ4AkWMQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER
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
> (to make it a superset).
>
> See the provided documentation for additional details.
>
> New tests are provided with a following commit.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-7-mic@digikod.net
> ---
>  include/uapi/linux/landlock.h                |  27 +-
>  security/landlock/fs.c                       | 550 ++++++++++++++++---
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   3 +-
>  6 files changed, 516 insertions(+), 70 deletions(-)

...

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 3886f9ad1a60..c7c7ce4e7cd5 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright =C2=A9 2016-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>   * Copyright =C2=A9 2018-2020 ANSSI
> + * Copyright =C2=A9 2021-2022 Microsoft Corporation
>   */
>
>  #include <linux/atomic.h>
> @@ -269,16 +270,188 @@ static inline bool is_nouser_or_private(const stru=
ct dentry *dentry)
>                          unlikely(IS_PRIVATE(d_backing_inode(dentry))));
>  }
>
> -static int check_access_path(const struct landlock_ruleset *const domain=
,
> -               const struct path *const path,
> +static inline access_mask_t get_handled_accesses(
> +               const struct landlock_ruleset *const domain)
> +{
> +       access_mask_t access_dom =3D 0;
> +       unsigned long access_bit;

Would it be better to declare @access_bit as an access_mask_t type?
You're not using any macros like for_each_set_bit() in this function
so I believe it should be safe.

> +       for (access_bit =3D 0; access_bit < LANDLOCK_NUM_ACCESS_FS;
> +                       access_bit++) {
> +               size_t layer_level;

Considering the number of layers has dropped down to 16, it seems like
a normal unsigned int might be big enough for @layer_level :)

> +               for (layer_level =3D 0; layer_level < domain->num_layers;
> +                               layer_level++) {
> +                       if (domain->fs_access_masks[layer_level] &
> +                                       BIT_ULL(access_bit)) {
> +                               access_dom |=3D BIT_ULL(access_bit);
> +                               break;
> +                       }
> +               }
> +       }
> +       return access_dom;
> +}
> +
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
> +       if (WARN_ON_ONCE(!access_request))
> +               return 0;
> +
> +       /* Saves all handled accesses per layer. */
> +       for (layer_level =3D 0; layer_level < domain->num_layers;
> +                       layer_level++) {
> +               const unsigned long access_req =3D access_request;
> +               unsigned long access_bit;
> +
> +               for_each_set_bit(access_bit, &access_req,
> +                               ARRAY_SIZE(*layer_masks)) {
> +                       if (domain->fs_access_masks[layer_level] &
> +                                       BIT_ULL(access_bit)) {
> +                               (*layer_masks)[access_bit] |=3D
> +                                       BIT_ULL(layer_level);
> +                               handled_accesses |=3D BIT_ULL(access_bit)=
;
> +                       }
> +               }
> +       }
> +       return handled_accesses;
> +}
> +
> +/*
> + * Check that a destination file hierarchy has more restrictions than a =
source
> + * file hierarchy.  This is only used for link and rename actions.
> + */
> +static inline bool is_superset(bool child_is_directory,
> +               const layer_mask_t (*const
> +                       layer_masks_dst_parent)[LANDLOCK_NUM_ACCESS_FS],
> +               const layer_mask_t (*const
> +                       layer_masks_src_parent)[LANDLOCK_NUM_ACCESS_FS],
> +               const layer_mask_t (*const
> +                       layer_masks_child)[LANDLOCK_NUM_ACCESS_FS])
> +{
> +       unsigned long access_bit;
> +
> +       for (access_bit =3D 0; access_bit < ARRAY_SIZE(*layer_masks_dst_p=
arent);
> +                       access_bit++) {
> +               /* Ignores accesses that only make sense for directories.=
 */
> +               if (!child_is_directory && !(BIT_ULL(access_bit) & ACCESS=
_FILE))
> +                       continue;
> +
> +               /*
> +                * Checks if the destination restrictions are a superset =
of the
> +                * source ones (i.e. inherited access rights without chil=
d
> +                * exceptions).
> +                */
> +               if ((((*layer_masks_src_parent)[access_bit] & (*layer_mas=
ks_child)[access_bit]) |
> +                                       (*layer_masks_dst_parent)[access_=
bit]) !=3D
> +                               (*layer_masks_dst_parent)[access_bit])
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +/*
> + * Removes @layer_masks accesses that are not requested.
> + *
> + * Returns true if the request is allowed, false otherwise.
> + */
> +static inline bool scope_to_request(const access_mask_t access_request,
> +               layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS]=
)
> +{
> +       const unsigned long access_req =3D access_request;
> +       unsigned long access_bit;
> +
> +       if (WARN_ON_ONCE(!layer_masks))
> +               return true;
> +
> +       for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_mas=
ks))
> +               (*layer_masks)[access_bit] =3D 0;
> +       return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
> +}
> +
> +/*
> + * Returns true if there is at least one access right different than
> + * LANDLOCK_ACCESS_FS_REFER.
> + */
> +static inline bool is_eacces(
> +               const layer_mask_t (*const
> +                       layer_masks)[LANDLOCK_NUM_ACCESS_FS],
>                 const access_mask_t access_request)
>  {

Granted, I don't have as deep of an understanding of Landlock as you
do, but the function name "is_eacces" seems a little odd given the
nature of the function.  Perhaps "is_fsrefer"?

> -       layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> -       bool allowed =3D false, has_access =3D false;
> +       unsigned long access_bit;
> +       /* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
> +       const unsigned long access_check =3D access_request &
> +               ~LANDLOCK_ACCESS_FS_REFER;
> +
> +       if (!layer_masks)
> +               return false;
> +
> +       for_each_set_bit(access_bit, &access_check, ARRAY_SIZE(*layer_mas=
ks)) {
> +               if ((*layer_masks)[access_bit])
> +                       return true;
> +       }

Is calling for_each_set_bit() overkill here?  @access_check should
only ever have at most one bit set (LANDLOCK_ACCESS_FS_REFER), yes?

> +       return false;
> +}
> +
> +/**
> + * check_access_path_dual - Check a source and a destination accesses
> + *
> + * @domain: Domain to check against.
> + * @path: File hierarchy to walk through.
> + * @child_is_directory: Must be set to true if the (original) leaf is a
> + *     directory, false otherwise.
> + * @access_request_dst_parent: Accesses to check, once @layer_masks_dst_=
parent
> + *     is equal to @layer_masks_src_parent (if any).
> + * @layer_masks_dst_parent: Pointer to a matrix of layer masks per acces=
s
> + *     masks, identifying the layers that forbid a specific access.  Bit=
s from
> + *     this matrix can be unset according to the @path walk.  An empty m=
atrix
> + *     means that @domain allows all possible Landlock accesses (i.e. no=
t only
> + *     those identified by @access_request_dst_parent).  This matrix can
> + *     initially refer to domain layer masks and, when the accesses for =
the
> + *     destination and source are the same, to request layer masks.
> + * @access_request_src_parent: Similar to @access_request_dst_parent but=
 for an
> + *     initial source path request.  Only taken into account if
> + *     @layer_masks_src_parent is not NULL.
> + * @layer_masks_src_parent: Similar to @layer_masks_dst_parent but for a=
n
> + *     initial source path walk.  This can be NULL if only dealing with =
a
> + *     destination access request (i.e. not a rename nor a link action).
> + * @layer_masks_child: Similar to @layer_masks_src_parent but only for t=
he
> + *     linked or renamed inode (without hierarchy).  This is only used i=
f
> + *     @layer_masks_src_parent is not NULL.
> + *
> + * This helper first checks that the destination has a superset of restr=
ictions
> + * compared to the source (if any) for a common path.  It then checks th=
at the
> + * collected accesses and the remaining ones are enough to allow the req=
uest.
> + *
> + * Returns:
> + * - 0 if the access request is granted;
> + * - -EACCES if it is denied because of access right other than
> + *   LANDLOCK_ACCESS_FS_REFER;
> + * - -EXDEV if the renaming or linking would be a privileged escalation
> + *   (according to each layered policies), or if LANDLOCK_ACCESS_FS_REFE=
R is
> + *   not allowed by the source or the destination.
> + */
> +static int check_access_path_dual(const struct landlock_ruleset *const d=
omain,
> +               const struct path *const path,
> +               bool child_is_directory,
> +               const access_mask_t access_request_dst_parent,
> +               layer_mask_t (*const
> +                       layer_masks_dst_parent)[LANDLOCK_NUM_ACCESS_FS],
> +               const access_mask_t access_request_src_parent,
> +               layer_mask_t (*layer_masks_src_parent)[LANDLOCK_NUM_ACCES=
S_FS],
> +               layer_mask_t (*layer_masks_child)[LANDLOCK_NUM_ACCESS_FS]=
)
> +{
> +       bool allowed_dst_parent =3D false, allowed_src_parent =3D false, =
is_dom_check;
>         struct path walker_path;
> -       size_t i;
> +       access_mask_t access_masked_dst_parent, access_masked_src_parent;
>
> -       if (!access_request)
> +       if (!access_request_dst_parent && !access_request_src_parent)
>                 return 0;
>         if (WARN_ON_ONCE(!domain || !path))
>                 return 0;
> @@ -287,22 +460,20 @@ static int check_access_path(const struct landlock_=
ruleset *const domain,
>         if (WARN_ON_ONCE(domain->num_layers < 1))
>                 return -EACCES;
>
> -       /* Saves all layers handling a subset of requested accesses. */
> -       for (i =3D 0; i < domain->num_layers; i++) {
> -               const unsigned long access_req =3D access_request;
> -               unsigned long access_bit;
> -
> -               for_each_set_bit(access_bit, &access_req,
> -                               ARRAY_SIZE(layer_masks)) {
> -                       if (domain->fs_access_masks[i] & BIT_ULL(access_b=
it)) {
> -                               layer_masks[access_bit] |=3D BIT_ULL(i);
> -                               has_access =3D true;
> -                       }
> -               }
> +       BUILD_BUG_ON(!layer_masks_dst_parent);

I know the kbuild robot already flagged this, but checking function
parameters with BUILD_BUG_ON() does seem a bit ... unusual :)

> +       if (layer_masks_src_parent) {
> +               if (WARN_ON_ONCE(!layer_masks_child))
> +                       return -EACCES;
> +               access_masked_dst_parent =3D access_masked_src_parent =3D
> +                       get_handled_accesses(domain);
> +               is_dom_check =3D true;
> +       } else {
> +               if (WARN_ON_ONCE(layer_masks_child))
> +                       return -EACCES;
> +               access_masked_dst_parent =3D access_request_dst_parent;
> +               access_masked_src_parent =3D access_request_src_parent;
> +               is_dom_check =3D false;
>         }
> -       /* An access request not handled by the domain is allowed. */
> -       if (!has_access)
> -               return 0;
>
>         walker_path =3D *path;
>         path_get(&walker_path);
> @@ -312,11 +483,50 @@ static int check_access_path(const struct landlock_=
ruleset *const domain,
>          */
>         while (true) {
>                 struct dentry *parent_dentry;
> +               const struct landlock_rule *rule;
> +
> +               /*
> +                * If at least all accesses allowed on the destination ar=
e
> +                * already allowed on the source, respectively if there i=
s at
> +                * least as much as restrictions on the destination than =
on the
> +                * source, then we can safely refer files from the source=
 to
> +                * the destination without risking a privilege escalation=
.
> +                * This is crucial for standalone multilayered security
> +                * policies.  Furthermore, this helps avoid policy writer=
s to
> +                * shoot themselves in the foot.
> +                */
> +               if (is_dom_check && is_superset(child_is_directory,
> +                                       layer_masks_dst_parent,
> +                                       layer_masks_src_parent,
> +                                       layer_masks_child)) {
> +                       allowed_dst_parent =3D
> +                               scope_to_request(access_request_dst_paren=
t,
> +                                               layer_masks_dst_parent);
> +                       allowed_src_parent =3D
> +                               scope_to_request(access_request_src_paren=
t,
> +                                               layer_masks_src_parent);
> +
> +                       /* Stops when all accesses are granted. */
> +                       if (allowed_dst_parent && allowed_src_parent)
> +                               break;
> +
> +                       /*
> +                        * Downgrades checks from domain handled accesses=
 to
> +                        * requested accesses.
> +                        */
> +                       is_dom_check =3D false;
> +                       access_masked_dst_parent =3D access_request_dst_p=
arent;
> +                       access_masked_src_parent =3D access_request_src_p=
arent;
> +               }
> +
> +               rule =3D find_rule(domain, walker_path.dentry);
> +               allowed_dst_parent =3D unmask_layers(rule, access_masked_=
dst_parent,
> +                               layer_masks_dst_parent);
> +               allowed_src_parent =3D unmask_layers(rule, access_masked_=
src_parent,
> +                               layer_masks_src_parent);
>
> -               allowed =3D unmask_layers(find_rule(domain, walker_path.d=
entry),
> -                               access_request, &layer_masks);
> -               if (allowed)
> -                       /* Stops when a rule from each layer grants acces=
s. */
> +               /* Stops when a rule from each layer grants access. */
> +               if (allowed_dst_parent && allowed_src_parent)
>                         break;

If "(allowed_dst_parent && allowed_src_parent)" is true, you break out
of the while loop only to do a path_put(), check the two booleans once
more, and then return zero, yes?  Why not just do the path_put() and
return zero here?


--
paul-moore.com
