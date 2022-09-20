Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031A45BDF66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiITIMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 04:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiITILh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:11:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C165674
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 01:08:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hy2so504455ejc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lIBfonnYdSlNUdE4hCfwnyGgYks8EaajA+Dk52ch3iE=;
        b=pRs4hqeOTCqzTiO5lSuJhPrxbhKAQ/8n4UcBh/PbWJyqJGvlSfvzjMymVW4soyo8xu
         LoA7Kz9CDDu44lJ/Y6O6CfVq/IacRa+D2oXkVWJk+TaT45fSstLDeoEQukmxheSpzyxY
         +kH1H26HXO1ZxODLZxvLTS/eJRKi4g689GxxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lIBfonnYdSlNUdE4hCfwnyGgYks8EaajA+Dk52ch3iE=;
        b=j93qf65AzbAqO5WeorZeA5i6FaATzgzM5OoKf05VU+6eBi5J0lj1y1JHPOxrfMpLrx
         jWeEdfZqWzFWP/rsyiRemuV1i6k5SdoZiuKiQaVpVhdDYpxXgSLb8uWoAeebGhJv8oQN
         aY5guLeWWxU6sCp1IooNUUHkhfiKvTWNFuEcN0jYCiLZQN9+CfsMUmY2crzxKhA3MK5X
         hFjjQAf7yyAds0xKRegEoHrEPdMfM4oyoOg1eVDnAATv04s5li5XmsogIyAvoULRUz9r
         dnw1kXeoOpmuVBJvYJZUsqezQdyLa9aFfXkzboqEhPGC2zTFBwBQOn7Zd5/EaEX5NZaX
         GQrQ==
X-Gm-Message-State: ACrzQf1Po++TpKEGJyOF1jf3bqTXWfBQRiECBqweW9nU9+x132hb8HKk
        huq38aeDCgzMlQivYwPnlQEAIYqziYHw06GV5ucj8w==
X-Google-Smtp-Source: AMsMyM7k3WFY9ek3FZT+qjD4Lov49OlIGaXFVfGbhipegsuKH7Wkmlia+rPkNEb0INBshUU2/G/3uqxAfEJ4eIFqv54=
X-Received: by 2002:a17:907:6093:b0:780:7671:2c97 with SMTP id
 ht19-20020a170907609300b0078076712c97mr15984660ejc.8.1663661302705; Tue, 20
 Sep 2022 01:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220919141031.1834447-1-mszeredi@redhat.com> <20220919141031.1834447-7-mszeredi@redhat.com>
 <YykaEI5BQ9nem3eW@ZenIV>
In-Reply-To: <YykaEI5BQ9nem3eW@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 20 Sep 2022 10:08:11 +0200
Message-ID: <CAJfpeguNUQHOtjtNJrgcpCgHBjcgU8dbjM0XptBLtcnYMSeaNQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] vfs: move open right after ->tmpfile()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
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

On Tue, 20 Sept 2022 at 03:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Sep 19, 2022 at 04:10:29PM +0200, Miklos Szeredi wrote:
>
> > -     child = d_alloc(dentry, &slash_name);
> > +     child = d_alloc(parentpath->dentry, &slash_name);
> >       if (unlikely(!child))
> >               goto out_err;
> > +     file->f_path.mnt = parentpath->mnt;
> > +     file->f_path.dentry = child;
> >       mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
> >       error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
> > +     error = finish_open_simple(file, error);
> > +     dput(child);
> > +     if (error)
> > +             goto out_err;
> > +     error = may_open(mnt_userns, &file->f_path, 0, file->f_flags);
> >       if (error)
> >               goto out_err;
> >       error = -ENOENT;
> >       inode = child->d_inode;
> >       if (unlikely(!inode))
> >               goto out_err;
>
> Ugh...  First of all, goto out_err leading to immediate return error;
> is obfuscation for no good reason.  What's more, how the hell can
> we get a negative dentry here?  The only thing that makes this check
> valid is that after successful open child is pinned as file->f_path.dentry -
> otherwise dput() above might have very well freed it.  And if we ever
> end up with a negative dentry in file->f_path.dentry of an opened
> file, we are really screwed...

OK.

Thanks,
Miklos
