Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E3373291C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244763AbjFPHpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245644AbjFPHpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:45:08 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C882719;
        Fri, 16 Jun 2023 00:45:07 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-786e637f06dso158230241.2;
        Fri, 16 Jun 2023 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686901506; x=1689493506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbyMv4kVSEw6ifFRfsiwdW9ibmL3bA472bGIxbxrS1Y=;
        b=lwnG7Rq+mHsIaIQvdaWaNxYcmsHsocdBwuoQAnd/6uolvTtheDHlarJSF5I3ovge8/
         d5JNxEUT2UuvZVIKHUh645OyAmUOB+ATrdR+gI6dWeMNAj80E2YNNn1NQogRQdy8YP8i
         j4zeUkv5KMpAftiSsDZB86x7/i5qa/BO/FRFRZUncbaNp6hmqFJR6o/7Oj2SM3gDg7V6
         qDDnuTCF7L5UzeL9EUI/8TZHX78PFyja8WoBh7X+OrjueKSEHROiWS6Fo93Qjeqf/dC+
         27NAMtKbpSWhgy3ZVKOpScoRZyYm63jqvpjeriXDFbDgCZvfPgJi/t2YPdM4wxvTfoSx
         jJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901506; x=1689493506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbyMv4kVSEw6ifFRfsiwdW9ibmL3bA472bGIxbxrS1Y=;
        b=j9MSzrNFGaLk4WSoHmYBgJCQ4eD24VvC/VRIKQDV165QY7fxeKDAHVjUd3H66yI6r9
         Uir+89WmY666CMfyxmHmXiEM2GNOX/nEy4mjP13zcDaSggd2kVrFSZE34CN8skfHFcry
         Uxf3/Bl1jefnIOFCKvcGJeDlSrj8sTeSJlEd4F+LXIVt5uSNsJQ7Fsg8Y778DiVCH1nf
         z2hiaR118KLee3pjvDYe5G56JLBVl99ZENqfy1ZKKVPHB7l+E5O4aTF21fDw4HI2ejpo
         9VUZpoqRXARKBdWkv6m4qIvgvClvSodMItrmcASGsdcgytgo3BtfnjsN/nm+ycePTZ0u
         Ggvg==
X-Gm-Message-State: AC+VfDzZ9KHkxPXoHyTqYoWYbTaBYbEtWcJ0FAQRYFlQ9McL21qKHG3n
        LLlSxzA9Uzvvxo3OS+Zspn+CXAEv7CTFq+uLUn0=
X-Google-Smtp-Source: ACHHUZ4bd95yfoeqsQLVACMfgHvAEnHgBjuJpZ3JNuNIs72INDnxegOeFugJ1dX5LGnc6KVgFGlBggufIT9eeaaD/mo=
X-Received: by 2002:a05:6102:354c:b0:43b:4da5:f9ba with SMTP id
 e12-20020a056102354c00b0043b4da5f9bamr1090103vss.32.1686901506551; Fri, 16
 Jun 2023 00:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230615112229.2143178-1-amir73il@gmail.com> <20230615112229.2143178-5-amir73il@gmail.com>
 <20230616071534.GD29590@lst.de>
In-Reply-To: <20230616071534.GD29590@lst.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Jun 2023 10:44:55 +0300
Message-ID: <CAOQ4uxjHLW8vObUHLBj4TWZvxheV38AnqL_-y9vhcvL=qezQDw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] fs: use backing_file container for internal files
 with "fake" f_path
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:15=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> > -     if (!(f->f_mode & FMODE_NOACCOUNT))
> > +     if (unlikely(f->f_mode & FMODE_BACKING))
> > +             path_put(backing_file_real_path(f));
> > +     else
> >               percpu_counter_dec(&nr_files);
>
> This is still missing the earlier pointed out fix that we still need
> the FMODE_NOACCOUNT check, isn't it?

Yes, I forgot and Christian has already fixed this on his branch.

>
> > + * This is only for kernel internal use, and the allocate file must no=
t be
> > + * installed into file tables or such.
>
> I'd use the same blurb I'd suggest for the previous patch here as well.
>
> > +/**
> > + * backing_file_open - open a backing file for kernel internal use
> > + * @path:    path of the file to open
> > + * @flags:   open flags
> > + * @path:    path of the backing file
> > + * @cred:    credentials for open
> > + *
> > + * Open a file whose f_inode !=3D d_inode(f_path.dentry).
> > + * the returned struct file is embedded inside a struct backing_file
> > + * container which is used to store the @real_path of the inode.
> > + * The @real_path can be accessed by backing_file_real_path() and the
> > + * real dentry can be accessed with file_dentry().
> > + * The kernel internal backing file is not accounted in nr_files.
> > + * This is only for kernel internal use, and must not be installed int=
o
> > + * file tables or such.
> > + */
>
> I still find this comment not very descriptive.  Here is my counter
> suggestion, which I'm also not totally happy with, and which might not
> even be factually correct as I'm trying to understand the use case a bit
> better by reading the code:
>
>  * Open a backing file for a stackable file system (e.g. overlayfs).
>  * For these backing files that reside on the underlying file system, we =
still
>  * want to be able to return the path of the upper file in the stackable =
file
>  * system.  This is done by embedding the returned file into a container
>  * structure that also stores the path on the upper file system, which ca=
n be
>  * retreived using backing_file_real_path().

It is the other way around.
Those ovl files currently in master have the ovl path in f_path
and xfs inode in f_inode.
After this change, f_path is still ovl and f_inode is still xfs, but
backing_file_real_path() can be used to get the xfs path.

Using the terminology "upper file in the stackable file" above
is different from what "upper file" means in overlayfs terminology.
So maybe:

 * Open a backing file for a stackable filesystem (e.g. overlayfs).
 * @path may be on the stackable filesystem and backing inode on the
 * underlying filesystem.  In this case, we want to be able to return the
 * @real_path of the backing inode.  This is done by embedding the
 * returned file into a container structure that also stores the path of th=
e
 * backing inode on the underlying filesystem, which can be retrieved
 * using backing_file_real_path().

>  *
>  * The return file is not accounted in nr_files and must not be installed
>  * into the file descriptor table.
>
> > +static inline const struct path *f_real_path(struct file *f)
>
> Question from an earlier revision: why f_real_path and not file_real_path=
?
>

I missed this question.
I don't really mind.
Considering the documentation below, perhaps it should be called
file_inode_path()

> Also this really needs a kerneldoc comment explaining when it should
> be used.

How about this:

/*
 * file_real_path - get the path corresponding to f_inode
 *
 * When opening a backing file for a stackable filesystem (e.g. overlayfs)
 * f_path may be on the stackable filesystem and f_inode on the
 * underlying filesystem.  When the path associated with f_inode is
 * needed, this helper should be used instead of accessing f_path directly.
*/

Thanks,
Amir.
