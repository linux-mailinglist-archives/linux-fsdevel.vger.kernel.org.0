Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868595F06E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 10:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiI3IxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiI3IxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:53:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40094166F3F
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 01:53:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nb11so7650983ejc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K8KYCzJbYIonb5+JjExfvqHNImT94GXAowWxcjjUc7w=;
        b=UbVe2z+e99x30ztqmjuZaau50NzRYpAXXdcigzuCF5BNCUIbVBhbJfcQWvhlX8D/U5
         eItiTp4HfYmDOKMpeU0EQ0E5Jav8uAuBcIF3YZd9nK3ilHz8B+0Mz5F0EPxWtbetvNYS
         kaZiR/miCc4Jb9Uf9pVGizA2kCCGKyrjYhM9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K8KYCzJbYIonb5+JjExfvqHNImT94GXAowWxcjjUc7w=;
        b=A5SwtBRlmWoepV2gqQLilAM2KyxYRdoFsatpUR2xSGIdf6eVIBvtlldBQRLKlU2ZrO
         tF8QI67ZQCA9DGbMatwIja3UYghHPbLK4WDKSNQfKimMy1uYI6FAJ7hSEECgbiYCpb5O
         4ktboG4kIJ6qjGczrzUK+pwsfbS/ZwzSFEsbLMlBi4zkzHrgM8RojHFnzXMbUQWCUJJ7
         WjvVO6eoYmmK0DCVXEuXFSBYpEFphiiKXK0t3iVQmrFxADwe3Zx8hr9rD1tZvO1W73my
         kTVdSYOyuUl25YUkjfnrT0Gph57JVHfY1MJxK2BYwfrVFKRkZTgY0xsaVlIGlOMyxl79
         eCmQ==
X-Gm-Message-State: ACrzQf2608jRQkKtT/Ht/cPm/+YsScZZSaVssUZZn0VvnUDv2q1H4OLa
        7SZ/9aphxsoswoDlwFOlcOjVS+euS31ly6AAOPqFWX1beQmrOA==
X-Google-Smtp-Source: AMsMyM7acy/+/V1jGIdnMmBrA7NWTJ3L9r00p2DzykegLSnUX1KkGVSMv2aly2+YOcIN5vzawkqnZ4Kzcmli1dYauKI=
X-Received: by 2002:a17:906:478d:b0:783:2270:e85a with SMTP id
 cw13-20020a170906478d00b007832270e85amr5745460ejc.371.1664527996814; Fri, 30
 Sep 2022 01:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-5-brauner@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 10:53:05 +0200
Message-ID: <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:

> This adds a new ->get_acl() inode operations which takes a dentry
> argument which filesystems such as 9p, cifs, and overlayfs can implement
> to get posix acls.

This is confusing.   For example overlayfs ends up with two functions
that are similar, but not quite the same:

 ovl_get_acl -> ovl_get_acl_path -> vfs_get_acl -> __get_acl(mnt_userns, ...)

 ovl_get_inode_acl -> get_inode_acl -> __get_acl(&init_user_ns, ...)

So what's the difference and why do we need both?  If one can retrive
the acl without dentry, then why do we need the one with the dentry?
(BTW in both cases the mnt_userns for the underlying fs is available
and used to translate the acl.)

If a filesystem cannot implement a get_acl() without a dentry, then
what will happen to caller's that don't have a dentry?

Thanks,
Miklos
