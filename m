Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE915EFDB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiI2TPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 15:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiI2TO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:14:58 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BB1264B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 12:14:53 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-131b7bb5077so2974634fac.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=so8f7/FpW15uqm64n1pk5SbXYMzGIpKd49c5eY6WZhI=;
        b=DuO4Ghap+57aG2+4EBfVbGqGkqFbZ8mMkc4f/baBKELkqqTkWW4Mmx5l5DS9hE2W+b
         4N6qDuPVJN9A/JvN8SmObmxYfyfrCkWhXpC7ARxFQRs+3OFKx3dPoAuhyNbDN496C0Ma
         kB1Ik5Pd2KjblhkMTRlplrd/sBVd39orC+pVfXBfKcs9zJBEZ4HHCaIxRRdbmromVsGT
         TqlciHhiCI9TDmtbUlNVdLJbIzSwYpFsIBtbiKR/KjA9/qE51YqGpqA6p7gXRUfxnVQw
         rTELVRH2b/5hSQk064L6hOiNT5Rc2UvZmte19QJxCbecySUF75yBfAakdzJGIuSDZmiH
         lyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=so8f7/FpW15uqm64n1pk5SbXYMzGIpKd49c5eY6WZhI=;
        b=yyknvQTlpVyi7dI+3sbIApx/Enkahcjmwn3pxpbrZZNVys0OgjyKmBoObjZzr5I1ro
         tyC+SVnZsWQkbCaVmmM6Yxlk74QgqTXGaXLovyf3qWvt3N1MTRSkYCVinbPs8ALj0icx
         c7HGGykQKfYCFA4gzO55O5/BqyK+nLHxWnpv8MhATYjlUtf8JuVkrO9VGsl3tflzxurK
         TP0W3z9IAoD9dD77W/kJ+2IUTzQp8fiTHwWR2Tes+5jE5R5WP6dXCPwgPspnpnOmlzCc
         OHLpNY11BD7gTjp+q3PmSqU2ITAEPhALRVtHEFj5tvcd5xsP/It+x0o6br4AfijrFSWJ
         zK3A==
X-Gm-Message-State: ACrzQf3SK2PzCab+Rbh6VUTLIS8q8qfHtuTJJDreCtfnkNEkyYV7HdVe
        M3Hl6vnWf5RvGrS3HbtNdCo3IJkSrGoTeraofFHa
X-Google-Smtp-Source: AMsMyM45cOexR0D+Wh6iAT/29fWCulWmYamGRCQWxac1spbOjzNUMh22cQMNGqRgnmLZJxrvU6hN17CJ8Jt5qfHl89c=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr7564530oac.51.1664478892860; Thu, 29
 Sep 2022 12:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-13-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-13-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Sep 2022 15:14:42 -0400
Message-ID: <CAHC9VhSxr-aUj7mqKo05B5Oj=5FWeajx_mNjR_EszzpYR1YozA@mail.gmail.com>
Subject: Re: [PATCH v4 12/30] integrity: implement get and set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:33 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> I spent considerate time in the security module and integrity
> infrastructure and audited all codepaths. EVM is the only part that
> really has restrictions based on the actual posix acl values passed
> through it. Before this dedicated hook EVM used to translate from the
> uapi posix acl format sent to it in the form of a void pointer into the
> vfs format. This is not a good thing. Instead of hacking around in the
> uapi struct give EVM the posix acls in the appropriate vfs format and
> perform sane permissions checks that mirror what it used to to in the
> generic xattr hook.
>
> IMA doesn't have any restrictions on posix acls. When posix acls are
> changed it just wants to update its appraisal status.
>
> The removal of posix acls is equivalent to passing NULL to the posix set
> acl hooks. This is the same as before through the generic xattr api.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>     /* v3 */
>     Paul Moore <paul@paul-moore.com>:
>     - Add get, and remove acl hook
>
>     /* v4 */
>     unchanged
>
>  include/linux/evm.h                   | 23 +++++++++
>  include/linux/ima.h                   | 21 ++++++++
>  security/integrity/evm/evm_main.c     | 70 ++++++++++++++++++++++++++-
>  security/integrity/ima/ima_appraise.c |  9 ++++
>  security/security.c                   | 21 +++++++-
>  5 files changed, 141 insertions(+), 3 deletions(-)

...

> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 23d484e05e6f..7904786b610f 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -8,7 +8,7 @@
>   *
>   * File: evm_main.c
>   *     implements evm_inode_setxattr, evm_inode_post_setxattr,
> - *     evm_inode_removexattr, and evm_verifyxattr
> + *     evm_inode_removexattr, evm_verifyxattr, and evm_inode_set_acl.
>   */
>
>  #define pr_fmt(fmt) "EVM: "fmt
> @@ -670,6 +670,74 @@ int evm_inode_removexattr(struct user_namespace *mnt_userns,
>         return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
>  }
>
> +static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
> +                                   struct dentry *dentry, const char *name,
> +                                   struct posix_acl *kacl)
> +{
> +#ifdef CONFIG_FS_POSIX_ACL
> +       int rc;
> +
> +       umode_t mode;
> +       struct inode *inode = d_backing_inode(dentry);
> +
> +       if (!kacl)
> +               return 1;
> +
> +       rc = posix_acl_update_mode(mnt_userns, inode, &mode, &kacl);
> +       if (rc || (inode->i_mode != mode))
> +               return 1;
> +#endif
> +       return 0;
> +}

I'm not too bothered by it either way, but one might consider pulling
the #ifdef outside the function definition, for example:

#ifdef CONFIG_FS_POSIX_ACL
static int evm_inode_foo(...)
{
  /* ... stuff ... */
}
#else
static int evm_inode_foo(...)
{
  return 0;
}
#endif /* CONFIG_FS_POSIX_ACL */

> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index bde74fcecee3..698a8ae2fe3e 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -770,6 +770,15 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>         return result;
>  }
>
> +int ima_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> +                     const char *acl_name, struct posix_acl *kacl)
> +{
> +       if (evm_revalidate_status(acl_name))
> +               ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> +
> +       return 0;
> +}

While the ima_inode_set_acl() implementation above looks okay for the
remove case, I do see that the ima_inode_setxattr() function has a
call to validate_hash_algo() before calling
ima_reset_appraise_flags().  IANAIE (I Am Not An Ima Expert), but it
seems like we would still want that check in the ACL case.

-- 
paul-moore.com
