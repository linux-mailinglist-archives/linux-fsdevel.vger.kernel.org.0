Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39CD76422F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 00:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGZWed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 18:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGZWec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:34:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA2270F
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 15:34:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9891c73e0fbso52052366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1690410861; x=1691015661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hH9OKNlsUJnLecjnnm5rLrXsBLC5HG39SrjraGbl7j0=;
        b=sCgmxZx76eT4E3BbLe31K9ttu6lswKBfK4Lt4HtvqWhtW8GpPIfr3uXKEHBtQAqPZO
         O3IKJSUtu2WLOLk+B/hMOk0ghNXGHnc0ty/oNdOv66s8u1ArklIQb0NAg6pjERmyDGQr
         DfMYZBV2bFIrKKXoFZGt6rUJg2bFMpoFB4cjqm8/IapWidGI77bz5msYcRHGHJ9X9y79
         EwguMeqr9ucNlUHrduI0r/nIuHOsXy8vOjXFap7UC90co5F54KaOQOd7fLov/EnDOVgZ
         xa4vnrVOLugtcwQnlwH06D8zUu0YFKfz7jIybz1xubBfFEjE+2CRRNgLI0eTfK68lObD
         AgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690410861; x=1691015661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH9OKNlsUJnLecjnnm5rLrXsBLC5HG39SrjraGbl7j0=;
        b=CqgdaUygaqGJy9+pgvhkpT69Thb+fbt8Egk//EcWBNZyHid4HEWDzPe6s2OqNiaYFv
         i3ehOOYaIUX4tAfX4CFtV1yf+RnqRDRtdtntlFHklmFOHhdTtuq6+bQF0JAy0uJv4mk8
         R6ODJF/r9QiK8Pa0LcADhMcARebShb/zVjYAu5nrmqfv/pawN3IY09Xu/R6UCMlTswMi
         F7cae70cmX5+MElBh8iHU/k08LOSlqlahqygW/mQFJF1GVcq8FP8+hAb15Q4ljrXlKY+
         5bEbCB3ogR2LKNf73NpbgnYJtuXNxM27pUl6NZbLeYseUfQZR6xnCe4hgIhw/0p34dOj
         M7nA==
X-Gm-Message-State: ABy/qLYBgIUdcbGGq2c2k9frU10wks0IAecPB1smPS0v5bReZu8zIpHa
        ie2HcZrD9WfTzwMyikIYSkM+FmEJTgbS8FLdV2pQ5w==
X-Google-Smtp-Source: APBJJlEzuu6Dndx36AHnJ64J6fp+ywPKu3tOxvp4LfcHvSCc3JxKqHtozBdlJFnt634jzj4yDt9gZnCsNl9RHQKEfoY=
X-Received: by 2002:a17:906:5a4a:b0:99b:cb59:79b3 with SMTP id
 my10-20020a1709065a4a00b0099bcb5979b3mr412703ejc.1.1690410861473; Wed, 26 Jul
 2023 15:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-4-amiculas@cisco.com>
In-Reply-To: <20230726164535.230515-4-amiculas@cisco.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Wed, 26 Jul 2023 18:34:09 -0400
Message-ID: <CALNs47tkc2vWYW13LQq17Qcy0UFBJXan+7S_JVsPBXwTTJn3bQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/10] rust: kernel: add an abstraction over
 vfsmount to allow cloning a new private mount
To:     Ariel Miculas <amiculas@cisco.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.pizza,
        brauner@kernel.org, viro@zeniv.linux.org.uk, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:54=E2=80=AFPM Ariel Miculas <amiculas@cisco.com>=
 wrote:
> [...]
> +++ b/rust/kernel/mount.rs
> @@ -0,0 +1,71 @@
> [...]
> +impl Vfsmount {
> +    /// Create a new private mount clone based on a path name
> +    pub fn new_private_mount(path_name: &CStr) -> Result<Self> {
> +        let path: Path =3D Path(Opaque::uninit());
> +        // SAFETY: path_name is a &CStr, so it's a valid string pointer;=
 path is an uninitialized
> +        // struct stored on the stack and it's ok because kern_path expe=
cts an out parameter
> +        let err =3D unsafe {
> +            bindings::kern_path(
> +                path_name.as_ptr() as *const i8,
> +                bindings::LOOKUP_FOLLOW | bindings::LOOKUP_DIRECTORY,
> +                path.0.get(),
> +            )
> +        };

Nit: I believe that `.cast::<i8>()` is preferred over `as *const T`
because it makes it harder to
accidentally change constness or indirection level. This isn't always
followed in kernel, but
good practice.

> +        if err !=3D 0 {
> +            pr_err!("failed to resolve '{}': {}\n", path_name, err);
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: path is a struct stored on the stack and it is  initi=
alized because the call to
> +        // kern_path succeeded
> +        let vfsmount =3D unsafe { from_err_ptr(bindings::clone_private_m=
ount(path.0.get()))? };
> +
> +        // Don't inherit atime flags
> +        // SAFETY: we called from_err_ptr so it's safe to dereference th=
is pointer
> +        unsafe {
> +            (*vfsmount).mnt_flags &=3D
> +                !(bindings::MNT_NOATIME | bindings::MNT_NODIRATIME | bin=
dings::MNT_RELATIME) as i32;
> +        }

Nit: it looks a bit cleaner to OR the flags outside of the unsafe
block, which is also nice because then
the unsafe block only contains the unsafe ops (could do this above
too). Also - I think maybe style
might encourage `// CAST:` where `as` is used?

    let new_flags =3D
        !(bindings::MNT_NOATIME | bindings::MNT_NODIRATIME |
bindings::MNT_RELATIME) as i32;

    // SAFETY: we called from_err_ptr so it's safe to dereference this poin=
ter
    unsafe { (*vfsmount).mnt_flags &=3D new_flags }

> +        Ok(Self { vfsmount })
> +    }
> +
> +    /// Returns a raw pointer to vfsmount
> +    pub fn get(&self) -> *mut bindings::vfsmount {
> +        self.vfsmount
> +    }
> +}
> +
> +impl Drop for Vfsmount {
> +    fn drop(&mut self) {
> +        // SAFETY new_private_mount makes sure to return a valid pointer
> +        unsafe { bindings::kern_unmount(self.vfsmount) };
> +    }
> +}
> --
> 2.41.0
>
>
