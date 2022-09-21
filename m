Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9FF5C004E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIUOxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiIUOxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:53:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0965D0CB
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:53:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so14281756ejc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=z+xbIRwCsE5eTNiCgnP102j4D9tzKysCp+MKGxURoR4=;
        b=T7622FQYuxGlKSR24k95EbE3+a2HY0xdyWsN27XQxOzmEqw49n65/E1Toa3j2Hj8CY
         1sQqQ08IRK7BfiHLsKAGfzpHAUKyv9UQNTKhinHWAmPsVGy7cgpOnY28jbEMeFi/co1Z
         6HnDMMl/Y4w8q9YEVu83pSRdnFQBkP1P8lzeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=z+xbIRwCsE5eTNiCgnP102j4D9tzKysCp+MKGxURoR4=;
        b=s4UAxQJGvkTMlcD2dhD9DOkhVOQ/J3qgL422P6zWV2YjouG8qmCN7J/9fcwme9oPpu
         7Yx5x+KTkjghzL5ogk7t3G+giaLPlz5V5t5HmSMjYXp9XxZal8akocegiTcm54KuuDpS
         nnPS5MKKOzINcje/t2DLcIGF/d6+/xA0rsXsOWhQ9XA5BwbuYEIZ5NsFbTRVszlakX6u
         HuG+a7Gzk/DBnnsC9ZbmpTe526AsY1NmpRC522r6U6x3JijqPmcSfalnbG3GoJ1r8T4u
         X5U1UKUR/Y1GpdoEG/DhLxY4rTx4y1rsLBSX4F9SGz0Gx90TqGI7W11+ErDXsAIRvkkS
         41AA==
X-Gm-Message-State: ACrzQf3CApcbLLDJH/tt8i6wSXBYTSpygE1gclKZSn4Ao/U/G7fLBWb8
        YwvhlJUBlXqyqUrrCVgG3FuAEKZgfC+okEUI41FjJw==
X-Google-Smtp-Source: AMsMyM56PiM9mdIxPYjrMux6io1cNN2MvkWE4Z7ek9/rYEu9XTzXwtW/UbVOkNknzrwPDa1Kz5Ha6TbmajP5z/jKXtA=
X-Received: by 2002:a17:907:62a1:b0:781:b320:90c0 with SMTP id
 nd33-20020a17090762a100b00781b32090c0mr7268570ejc.255.1663772016703; Wed, 21
 Sep 2022 07:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-8-mszeredi@redhat.com>
 <YyopS+KNN49oz2vB@ZenIV> <CAJfpegv6-qmLrW-gKx4uZmjSehhttzF1Qd2Nqk=+vGiGoq2Ouw@mail.gmail.com>
 <20220921085434.g3ak6lwqvpe67ksn@wittgenstein>
In-Reply-To: <20220921085434.g3ak6lwqvpe67ksn@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 16:53:25 +0200
Message-ID: <CAJfpegsrc5u+0ea4hE-tFGX5qXT6_dJbjwnkAr8zSeszvRpXOA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
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

On Wed, 21 Sept 2022 at 10:54, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 05:06:57AM +0200, Miklos Szeredi wrote:
> > On Tue, 20 Sept 2022 at 22:57, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Tue, Sep 20, 2022 at 09:36:30PM +0200, Miklos Szeredi wrote:
> > >
> > > >       inode = child->d_inode;
> > >
> > > Better
> > >         inode = file_inode(file);
> > >
> > > so that child would be completely ignored after dput().
> > >
> > > > +     error = vfs_tmpfile(mnt_userns, &path, file, op->mode);
> > > > +     if (error)
> > > >               goto out2;
> > > > -     dput(path.dentry);
> > > > -     path.dentry = child;
> > > > -     audit_inode(nd->name, child, 0);
> > > > +     audit_inode(nd->name, file->f_path.dentry, 0);
> > > >       /* Don't check for other permissions, the inode was just created */
> > > > -     error = may_open(mnt_userns, &path, 0, op->open_flag);
> > >
> > > Umm...  I'm not sure that losing it is the right thing - it might
> > > be argued that ->permission(..., MAY_OPEN) is to be ignored for
> > > tmpfile (and the only thing checking for MAY_OPEN is nfs, which is
> > > *not* going to grow tmpfile any time soon - certainly not with these
> > > calling conventions), but you are also dropping the call of
> > > security_inode_permission(inode, MAY_OPEN) and that's a change
> > > compared to what LSM crowd used to get...
> >
> > Not losing it, just moving it into vfs_tmpfile().
>
> Afaict, we haven't called may_open() for tmpfile creation in either
> cachefiles or overlayfs before. So from that perspective I wonder if
> there's a good reason for us to do it now.

For overlayfs we did check MAY_WRITE | MAY_OPEN through
ovl_path_open().  Just checking MAY_OPEN relaxes this, but it's in
line with the overlay model of checking the same permissions as if the
operation was invoked directly.

For cachefiles no permission was checked before this patch, so in
theory it could change behavior.  Moving the permission check back out
to callers would fix this, but I'm not entirely sure that that is the
best way forward.

David, what is the model for cachefiles?  Is this okay to check for
permissions on underlying ops, or that must be avoided?

Thanks,
Miklos
