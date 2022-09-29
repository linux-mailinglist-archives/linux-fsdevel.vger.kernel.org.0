Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17F25EFDB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiI2TPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 15:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiI2TPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:15:23 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8463A4F6A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 12:15:21 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so768465oop.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9SsU5XtPoF31nh8INwWwhQiX3HTvmaFJCOioxsEJIlk=;
        b=bNDmQtAMfPr7dEL21F/iqWm9f3vax8ZOojwsFEcNyCZQZCtIp88849W39ZRwkME8KG
         iIg4IbzkT9YMc67VV72PiP2xG3a77ywXM94/QngtGTJ9aDIFtP81Hn5r2wmZ5ICa80+5
         3cHkyyF4PQs0MTWcS7WgJ2STkGGqbpZAHE/9funi3ffikGLBuoOuRG9iBwSOPCLbdc6m
         IAtOpqqg//jg0lXlkpoCrD7wPhIsK3RmJ4SQH0P5PXziszakJYOd0WeinVhivDxx7RO3
         jK75Vh52ozc6fChJ7DvZkcup5UN5KrDUfMAMqqKR2A4ik0LdhG5Lb9BefsTzJyxzMdio
         3Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9SsU5XtPoF31nh8INwWwhQiX3HTvmaFJCOioxsEJIlk=;
        b=C8nopYzYozUxbsRZWGee4G9/RTQ8CxKKhtIVnB+RcpSOeOX9GWBwaFPVXkKbORL24F
         eDoq1BuwyG7T58HOtx7bMElq8NOva11eCC0lW53c8vwoa+mPPmqFasIxe2b2cAvSjK18
         64BG3MHwlZ/0vT4EdiLAXWxAQkKv2hcVrDlce5mx7RHDsnnO35NHa1sC7tMEApFElE3g
         I2zQ89iUbKIY8UaPpWK1PNI/yjdwFzN2rsqPnq1ePedC8BoF14utzfQGB3cMGnFxMJz1
         jYHUtUWesgNSED0xPi/kt6ikcBvRZlmajl5Gl6nWm/C7Ch+eQNRRkNz2fJB6EWhjyqWE
         DAvA==
X-Gm-Message-State: ACrzQf2mvrPL4ign1wxgZzhVVtXpDZHFissZKRABqcXd5Hf1SMb0xq7C
        X/SjbLPNJict0a/aGizzRYWuFkgCjPFIBbnmDsDjFkIG8A==
X-Google-Smtp-Source: AMsMyM681R6NGTnthAGD+cbH3aEYOvueJG0s12RDiF7/StgnvggbxtqxlUG0QfTcGQi3+FZ2qF54nCLz6vzjehCCLiY=
X-Received: by 2002:a4a:c10a:0:b0:476:4a59:4e4b with SMTP id
 s10-20020a4ac10a000000b004764a594e4bmr1980970oop.24.1664478920836; Thu, 29
 Sep 2022 12:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-12-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-12-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Sep 2022 15:15:09 -0400
Message-ID: <CAHC9VhSRsm85VNW+y0-NTwdatH5-H-KAeeMUgSpx8iD8mOqiWQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/30] smack: implement get, set and remove acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:31 AM Christian Brauner <brauner@kernel.org> wrote:
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
> I spent considerate time in the security module infrastructure and
> audited all codepaths. Smack has no restrictions based on the posix
> acl values passed through it. The capability hook doesn't need to be
> called either because it only has restrictions on security.* xattrs. So
> these all becomes very simple hooks for smack.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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
>     Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>
>  security/smack/smack_lsm.c | 69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)

Two nit-picky comments below, only worth considering if you are
respinning for other reasons.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 001831458fa2..8247e8fd43d0 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1393,6 +1393,72 @@ static int smack_inode_removexattr(struct user_namespace *mnt_userns,
>         return 0;
>  }
>
> +/**
> + * smack_inode_set_acl - Smack check for setting posix acls
> + * @mnt_userns: the userns attached to the mnt this request came from
> + * @dentry: the object
> + * @acl_name: name of the posix acl
> + * @kacl: the posix acls
> + *
> + * Returns 0 if access is permitted, an error code otherwise
> + */
> +static int smack_inode_set_acl(struct user_namespace *mnt_userns,
> +                              struct dentry *dentry, const char *acl_name,
> +                              struct posix_acl *kacl)
> +{
> +       struct smk_audit_info ad;
> +       int rc;
> +
> +       smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +       smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +       rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
> +       rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
> +       return rc;
> +}

Smack tends to add a line of vertical whitespace between the
smk_ad_setfield_...(...) call and the smk_curacc(...) call in the
xattr functions, consistency here might be nice.

> +/**
> + * smack_inode_remove_acl - Smack check for getting posix acls
> + * @mnt_userns: the userns attached to the mnt this request came from
> + * @dentry: the object
> + * @acl_name: name of the posix acl
> + *
> + * Returns 0 if access is permitted, an error code otherwise
> + */
> +static int smack_inode_remove_acl(struct user_namespace *mnt_userns,
> +                                 struct dentry *dentry, const char *acl_name)
> +{
> +       struct smk_audit_info ad;
> +       int rc;
> +
> +       smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +       smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +       rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
> +       rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
> +       return rc;
> +}

Same comment about the vertical whitespace applies here.


--
paul-moore.com
