Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C92675F11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 21:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjATUpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 15:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATUpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:45:47 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9294C98
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 12:45:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b10so6727101pjo.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 12:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x62E/nl+ONbICiSsmar4KjRWoAfoTSBdrOdf9qKQras=;
        b=LlMl9c3NNGZmycFs5fSTn3CIyY+wd5nQUAS9vIqtV2A1S10Snz9ztD6ABsdBAIJMRX
         oOqyZ9S+OA9lpbBymTACh/JWRKDGwvqeTHfjPnQKyCRpvfE8/kR08j3fH1/fBHcmzXW+
         TameGWN6nJVw0vttTbxWtt9aJX7iXSs3sRQbx3v6Im2BnGLE8bw+ILl7oI/tGr8nE3K9
         w0W39/8ApnDEXH2dAz1PRBoVc6nRzQCJet7n6Dt4cJAHBnHCBFVZCcL2Cuuj+41U6mTN
         5YH9HJS4Zk1qsDfsPa38q/o9UzgT13gMNA75WHbP8gGNlwakrQWhF/PC1Ia7CBB96akN
         hkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x62E/nl+ONbICiSsmar4KjRWoAfoTSBdrOdf9qKQras=;
        b=Z7cWgIXUbaiBqh0hWyxXuCVvCloZZmH9q9g/GVRHvDrOs7o2RptqHiynmM83vXOD0h
         /5AvtWbtX1fn+P7QVB8oVMFO8wEIsPZvjECnbDkXYcHSQryH4ONS5+5FzpQDps/je9Cr
         Ra2mN+oPXvzL5eU7k4Y9o3/e0HpMs4kzKNTV/eqSQzxHo5OrNIXlWeEwK08SdevZmoeU
         FT87jYO8Xu8kDXZCRmVURxEPNb6C2lvkX8iksow2WObMfm0Tt14GegqTeOWESV3uSNEr
         okoCXcioJe57f1+ueglEgXilZOL7rKejrMOhE8zj7eEHfbaDa5A4+L/JQZPIX/mU450q
         6t6g==
X-Gm-Message-State: AFqh2krsVp1lZVs3EBVPr5M4ReVpnzdApg/zYl3/u1+Pws72kAoOrxVl
        9Pgyj4Owetykz5sr9/qgvhr5C+HFsQhEWjjxz6kX
X-Google-Smtp-Source: AMrXdXvQWGH+TfxgJ4yUEtio0sfEpYaSLEATZ2oGg7OHBsGmzao1b/xL9lJ3//JRhrCw2Td14bRYp8jbP4onPyGj+Rw=
X-Received: by 2002:a17:90a:17a1:b0:229:9ffe:135b with SMTP id
 q30-20020a17090a17a100b002299ffe135bmr1730636pja.72.1674247546190; Fri, 20
 Jan 2023 12:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
In-Reply-To: <20230116212105.1840362-2-mjguzik@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jan 2023 15:45:34 -0500
Message-ID: <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 4:21 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> access(2) remains commonly used, for example on exec:
> access("/etc/ld.so.preload", R_OK)
>
> or when running gcc: strace -c gcc empty.c
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>   0.00    0.000000           0        42        26 access
>
> It falls down to do_faccessat without the AT_EACCESS flag, which in turn
> results in allocation of new creds in order to modify fsuid/fsgid and
> caps. This is a very expensive process single-threaded and most notably
> multi-threaded, with numerous structures getting refed and unrefed on
> imminent new cred destruction.
>
> Turns out for typical consumers the resulting creds would be identical
> and this can be checked upfront, avoiding the hard work.
>
> An access benchmark plugged into will-it-scale running on Cascade Lake
> shows:
> test    proc    before  after
> access1 1       1310582 2908735  (+121%)  # distinct files
> access1 24      4716491 63822173 (+1353%) # distinct files
> access2 24      2378041 5370335  (+125%)  # same file

Out of curiosity, do you have any measurements of the impact this
patch has on the AT_EACCESS case when the creds do need to be
modified?

> The above benchmarks are not integrated into will-it-scale, but can be
> found in a pull request:
> https://github.com/antonblanchard/will-it-scale/pull/36/files
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> v2:
> - fix current->cred usage warn reported by the kernel test robot
> Link: https://lore.kernel.org/all/202301150709.9EC6UKBT-lkp@intel.com/
> ---
>  fs/open.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/fs/open.c b/fs/open.c
> index 82c1a28b3308..3c068a38044c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -367,7 +367,37 @@ COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode, compat_arg_u64_dual(offset
>   * access() needs to use the real uid/gid, not the effective uid/gid.
>   * We do this by temporarily clearing all FS-related capabilities and
>   * switching the fsuid/fsgid around to the real ones.
> + *
> + * Creating new credentials is expensive, so we try to skip doing it,
> + * which we can if the result would match what we already got.
>   */
> +static bool access_need_override_creds(int flags)
> +{
> +       const struct cred *cred;
> +
> +       if (flags & AT_EACCESS)
> +               return false;
> +
> +       cred = current_cred();
> +       if (!uid_eq(cred->fsuid, cred->uid) ||
> +           !gid_eq(cred->fsgid, cred->gid))
> +               return true;
> +
> +       if (!issecure(SECURE_NO_SETUID_FIXUP)) {
> +               kuid_t root_uid = make_kuid(cred->user_ns, 0);
> +               if (!uid_eq(cred->uid, root_uid)) {
> +                       if (!cap_isclear(cred->cap_effective))
> +                               return true;
> +               } else {
> +                       if (!cap_isidentical(cred->cap_effective,
> +                           cred->cap_permitted))
> +                               return true;
> +               }
> +       }
> +
> +       return false;
> +}

I worry a little that with nothing connecting
access_need_override_creds() to access_override_creds() there is a bug
waiting to happen if/when only one of the functions is updated.

Given the limited credential changes in access_override_creds(), I
wonder if a better solution would be to see if we could create a
light(er)weight prepare_creds()/override_creds() that would avoid some
of the prepare_creds() hotspots (I'm assuming that is where most of
the time is being spent).  It's possible this could help improve the
performance of other, similar operations that need to modify task
creds for a brief, and synchronous, period of time.

Have you done any profiling inside of access_override_creds() to see
where the most time is spent?  Looking at the code I have some gut
feelings on the hotspots, but it would be good to see some proper data
before jumping to any conclusions.

>  static const struct cred *access_override_creds(void)
>  {
>         const struct cred *old_cred;
> @@ -436,7 +466,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
>         if (flags & AT_EMPTY_PATH)
>                 lookup_flags |= LOOKUP_EMPTY;
>
> -       if (!(flags & AT_EACCESS)) {
> +       if (access_need_override_creds(flags)) {
>                 old_cred = access_override_creds();
>                 if (!old_cred)
>                         return -ENOMEM;
> --
> 2.34.1

-- 
paul-moore.com
