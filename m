Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA75BFFF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiIUOdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIUOdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:33:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECEA501B7
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:33:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z13so8928429edb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=W/Je6PzJtShTJymkztXHS9Q3ua2CVKkROh9UfEsU3UA=;
        b=m12RGVrC1P8KEBD15MNsFqXcP2CJCUPh30zRlm4Ut5DA4r0yBz/i6OyZYFzaVzNWSp
         9Tt5ZArzb8Ma7d0S22VJvM7Sji76mDRePoC094AITnkUG0beuRIM7O0NO1hXrJVTreWQ
         y4ltBGb9Hu1ZBw/t2xnSlvgn4xDhObgEZv6sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W/Je6PzJtShTJymkztXHS9Q3ua2CVKkROh9UfEsU3UA=;
        b=pm7kOdjuQxP1YuBVQqlpVDi12neFrTXE3ZQRUtsWPrthdPc/A71MShacCuC63tYC0a
         NI07pIO88p56/Ypc4RxDHNDYFHTAbBnce0hW+V7quWv8MK7QHvGqCJyeTsHF+YaC37nM
         hjzkLaKWtNOhIlgPrJm5Myxnq7nClFAjASVX51m50AKP8gvTkorswznvK1dzxQFFiUW0
         0amibuIew4Z+2Hc0HtVAZyR1z3nbHC1iEyK5oEHZNBzWyahAQU5y3Fv1c5NhrU8rapjX
         nTy7gp3cM/Eso6oZJeAPBXnE4NjpztpFLEevq3AWeafmld8p87nDs7B+y5a20e8vfANC
         +mBg==
X-Gm-Message-State: ACrzQf1sLfj10fv89B9YkITMHLBOKXWKCUjzvmsU6K5gGJ7TFdWV/4fr
        xEiQgG+qc971p9LLOpATxangRThzC8SGuGS+iHK0+Q==
X-Google-Smtp-Source: AMsMyM7QbcUj1RWl72ddioCHph1ojRuVSh/n4NzzXMYjgvK4thwV3Cq0bKBKVbbCEhuyH4+AnROqBTJ6lO5/I6GXn1I=
X-Received: by 2002:a50:ef03:0:b0:44e:82bf:28e6 with SMTP id
 m3-20020a50ef03000000b0044e82bf28e6mr24170707eds.270.1663770798078; Wed, 21
 Sep 2022 07:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-4-mszeredi@redhat.com>
 <20220921080902.wbjbsrlwj3frrot3@wittgenstein>
In-Reply-To: <20220921080902.wbjbsrlwj3frrot3@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 16:33:07 +0200
Message-ID: <CAJfpegvYKV5ViNMev+zieH5Zu4uYGHNjjOzT2R7ZHvnwevLmTA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] vfs: add tmpfile_open() helper
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Sept 2022 at 10:09, Christian Brauner <brauner@kernel.org> wrote:
>
> Feels like this could be simplified while being equally legible to
> something like:
>
> /**
>  * tmpfile_open - open a tmpfile for kernel internal use
>  * @mnt_userns: user namespace of the mount the inode was found from
>  * @parentpath: path of the base directory
>  * @mode:       mode of the new tmpfile
>  * @open_flag:  flags
>  * @cred:       credentials for open
>  *
>  * Create and open a temporary file.  The file is not accounted in nr_files,
>  * hence this is only for kernel internal use, and must not be installed into
>  * file tables or such.
>  *
>  * The helper relies on the "noaccount" property of open_with_fake_path().
>  * Otherwise it is equivalent to dentry_open().
>  *
>  * Return: Opened tmpfile on success, error pointer on failure.
>  */
> struct file *tmpfile_open(struct user_namespace *mnt_userns,
>                           const struct path *parentpath,
>                           umode_t mode, int open_flag, const struct cred *cred)
> {
>         struct file *file;
>         int error;
>         struct path path = { .mnt = parentpath->mnt };
>
>         path.dentry = vfs_tmpfile(mnt_userns, parentpath->dentry, mode, open_flag);
>         if (IS_ERR(path.dentry))
>                 return ERR_CAST(path.dentry);
>
>         error = may_open(mnt_userns, &path, 0, open_flag);
>         if (!error)
>                 file = open_with_fake_path(&path, open_flag, d_inode(path.dentry), cred);
>         else
>                 file = ERR_PTR(error);
>         dput(path.dentry);
>         return file;
> }
> EXPORT_SYMBOL(tmpfile_open);

Okay, but this code gets completely rewritten in 7/9, so maybe not
worth bothering about.

Thanks,
Miklos
