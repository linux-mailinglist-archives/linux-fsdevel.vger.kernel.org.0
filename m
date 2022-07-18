Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1EB577D57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 10:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiGRISg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiGRISe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:18:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AF1900C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 01:18:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m16so14172494edb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+u8dlZ8Muf2HXMeU0KFrMSR2DdrEfYE39jHtYBLJvk=;
        b=e/pfi4LiQiBx98KeNwsNG85Q9l7RndPje7VUL/FYpkZcIQkcvtf7tM4VafS+M7L8wa
         +r9PGqWoTeSaG9Ow4MsGxFsdeZu1szALQtbuu+oyGz0fGits8Gami5fdaVLPTukXEo7V
         eLr6Zn4BxFxFNd6hCuekvtVsP+0z3UqKCJVYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+u8dlZ8Muf2HXMeU0KFrMSR2DdrEfYE39jHtYBLJvk=;
        b=yO6KsZMOkfIiJIRyFGAkVsZviNesLNM/IT1Zajo5xxdc4lm3rsj11G4dOcxghUXx49
         dsEIZ5DMbOYf1dvG7auT8W9Zj1F/2ziG4x+dOLD+QxNgv87hYRNB8atNU7FBeOUI9K/c
         Fij1hxz9zQJrX+Pm6875ZABb4breAJ04N+I5ICWTNKwc+3bSNMQwCIgua7Vrj12BeiCS
         USMn1d4pJWrLPD5O9749rZhOsZxIc1oQeI8wq7EAPbNGGFoDYz4MaWCArLRot/a2exJ0
         Nx4paNpyTNz+wyKGD5ZcO0rdG3tJw7b4nOmb6jG9qh+vJ0JCnX6vINDfGw33PEFi4tS5
         sIYw==
X-Gm-Message-State: AJIora+ACio/YKhc9AFfFW9JMy922tlhvOcuZ7Kl5y/t96EeZ06En4VP
        gbdkHQa7IuK4e2ZTF7gNTRsv//sKUCsvrd0P/n+7AQ==
X-Google-Smtp-Source: AGRyM1t2KjNAK8+Cdsj/U870U8abc3W65tr4+56ozSx6bSjF1xdkpTirePoJ75KgMCJxjWca6RFNJYpWxwZZUBXUHq4=
X-Received: by 2002:a05:6402:3202:b0:43a:86f5:a930 with SMTP id
 g2-20020a056402320200b0043a86f5a930mr34796033eda.389.1658132309531; Mon, 18
 Jul 2022 01:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220624055825.29183-1-zhangjiachen.jaycee@bytedance.com>
 <CAJfpegtSsG_qUT8LsO=ro76RTwBBfa=1JVwwX+mVxd-svir+3g@mail.gmail.com> <CAFQAk7jTJi_OcX=4nevbOquphcibtD=jG-jwwbC0KMJOfx9DeQ@mail.gmail.com>
In-Reply-To: <CAFQAk7jTJi_OcX=4nevbOquphcibtD=jG-jwwbC0KMJOfx9DeQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 10:18:18 +0200
Message-ID: <CAJfpegu1uSMGrh==DS9+fbX+Gm8XaOyY3KTQ3xtZsbPEJo1M8A@mail.gmail.com>
Subject: Re: [PATCH] fuse: writeback_cache consistency enhancement (writeback_cache_v2)
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>, fam.zheng@bytedance.com,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Jul 2022 at 08:01, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> On Fri, Jul 15, 2022 at 6:07 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, 24 Jun 2022 at 07:58, Jiachen Zhang
> > <zhangjiachen.jaycee@bytedance.com> wrote:

> > > +       if (fc->writeback_cache_v2 && S_ISREG(inode->i_mode)) {
> > > +               inode_lock(inode);
> >
> > I don't think this can work.   fuse_change_attributes() might be
> > called from within inlode locked context.  E.g.
> >
> > lookup_slow -> __lookup_slow -> d_revalidate -> fuse_dentry_revalidate
> > -> fuse_change_attributes
> >
>
> Yes, this is a problem that should be fixed. As we can not check the
> inode lock state from the inode->i_rwsem structure, I think we can
> pass the inode lock state along the FUSE function call-path to
> fuse_change_attributes(), and only when we can certainly know whether
> the inode is locked or unlocked then we continue the
> writeback_cache_v2 logics. What do you think?

Not liking it very much.

Better create a new lock for this purpose that we do always know the state of.

Thanks,
Miklos
