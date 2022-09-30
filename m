Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F905F07D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiI3JnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 05:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiI3JnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:43:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6173314C9D0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 02:43:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc7so7953663ejb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K9BxadCBYBzaBTyQRyF/w6rBPEGeOhrH+tm0fSl5DRM=;
        b=kNP9aRNM3QO6PO+jNGGedT1/gfIo7tenrFk15eP7tS8Ong7YEIUlVxbhpWCp0tvg8P
         pMH699lyYfWQVX+3Y+lHf+4g6KfeF9zrweQB/K+bCEHnCuE8GvEPGf/ob3S0R0aUbT9F
         fQkHt6IS6G1+PQ6qhzaGPaOcRRyrnq5BP7hnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K9BxadCBYBzaBTyQRyF/w6rBPEGeOhrH+tm0fSl5DRM=;
        b=J4HyjTvjBrxCbCdQAGYyh1xFC90vFoGP7PzzLIIV3h9K57IvSKwwNV1hVSxpx9FI3T
         DibG+Vp5RjmShiuu9kR9RwfqIkcAoYiWHLI4ACVe13g6RnV/dN1bBB6D+WMEC+NQnEFZ
         LdtO4fyojBGa9Rz5QCw2TNi+Rbcqs+gyC1RoZT3R5ZAYurJSMVEcYRbJg2K7Mm5Q/HJC
         ZPTOzgb8f1EZaYzjp5PDcH163wEbMkSYv634ptDSHfRk8+f9yAKiTZfEbZ8bQ6uokSSg
         F+gPkJEbj5RShRA2M2BVTPde5vjSaltRg5gm2PGreSTC0CvjaQWCjtQGNoRaa6Ff9gg4
         98cQ==
X-Gm-Message-State: ACrzQf3Amzu/HnZGeCUbpt6pqfWFun11Kankt1/8Qu8tZA9m3rrUriS3
        r8s8m0xXVd1j1LmdPGhIFi2VBCphhCNVY4tPQtiDdw==
X-Google-Smtp-Source: AMsMyM6/e9bKat+xexCpKn9P8ksCzV90qmbW3LJaH+3XUmspyG6GPPBL3FPFtFmD2ewFq9eCdpFgJF0q1tXhZFDehcQ=
X-Received: by 2002:a17:906:7315:b0:782:66dc:4b76 with SMTP id
 di21-20020a170906731500b0078266dc4b76mr5883321ejc.751.1664530998871; Fri, 30
 Sep 2022 02:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com> <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
In-Reply-To: <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 11:43:07 +0200
Message-ID: <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Sept 2022 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Sep 30, 2022 at 10:53:05AM +0200, Miklos Szeredi wrote:
> > On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> >
> > > This adds a new ->get_acl() inode operations which takes a dentry
> > > argument which filesystems such as 9p, cifs, and overlayfs can implement
> > > to get posix acls.
> >
> > This is confusing.   For example overlayfs ends up with two functions
> > that are similar, but not quite the same:
> >
> >  ovl_get_acl -> ovl_get_acl_path -> vfs_get_acl -> __get_acl(mnt_userns, ...)
> >
> >  ovl_get_inode_acl -> get_inode_acl -> __get_acl(&init_user_ns, ...)
> >
> > So what's the difference and why do we need both?  If one can retrive
> > the acl without dentry, then why do we need the one with the dentry?
>
> The ->get_inode_acl() method is called during generic_permission() and
> inode_permission() both of which are called from various filesystems in
> their ->permission inode operations. There's no dentry available during
> the permission inode operation and there are filesystems like 9p and
> cifs that need a dentry.

This doesn't answer the question about why we need two for overlayfs
and what's the difference between them.

>
> > If a filesystem cannot implement a get_acl() without a dentry, then
> > what will happen to caller's that don't have a dentry?
>
> This happens today for cifs where posix acls can be created and read but
> they cannot be used for permission checking where no inode is available.
> New filesystems shouldn't have this issue.

That's weird, how does it make sense to set acl on a filesystem that
cannot use it for permission checking?   Maybe the permission checking
is done by the server?

Steve?

Thanks,
Miklos
