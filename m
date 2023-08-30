Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EE778DB03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbjH3SiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbjH3Our (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:50:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A9FFF
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 07:50:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so7771328a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693407043; x=1694011843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEPXUvU9gsZgeDKfTjxNMbhgA2fLlyJGg00t/tcScRM=;
        b=GsXHiji+ZXLAN8Wq2e3h2jLY4YoSvePBuS71EsYjeZB7kenPTe4u7m0BDi9JF7+x+F
         Lv4lePyRSBxEX6f2YnrYOAlXhxGlBdlemtaQqkKsP4ew0sErzissCHXXNf+S5My1rxBj
         N/VR/QqLdUYGWYj8gouZxaLXoK1mujRx4aEgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407043; x=1694011843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEPXUvU9gsZgeDKfTjxNMbhgA2fLlyJGg00t/tcScRM=;
        b=Jxr81lfLZDJpHLMxYw7GykAdy8rlAQAo5DtjseFwHQgb07/ovqj2X7wggfzXjvlQXD
         0MVv/Q2gDGwV3KXQienvBglTr4/CVirbT0Hx7gC7RjELkFncfpIpU8zCa+Kt9gDm4wK5
         ZgamDcI2y8iuKkyBtgGPqoDA2RU3C7F23T9/oU7fI40R44e6MzAzVi+qTQL5YfqNPVdC
         uj2uKudnHGj8rUecaWgkMJJ6roDhSt8cjB49b+654KRe3VT/Ah/22M2s/K8b73ODV49H
         Zm4lpIZxbjqiCcsLBsHA3Gh2yH7JOu/1tHwOCeAju3X5/F3216u7E2M7HyHAFNiRdBTV
         TXzQ==
X-Gm-Message-State: AOJu0YzoXLavAiQfK6Ewoiy/gkhp1/UJW+ImGzX40IgXbPj2jdnxOruc
        XH6+QR6Gfx/QSXHwxbQLhDrldaVeNYQopX3LbeWVhg==
X-Google-Smtp-Source: AGHT+IHCkBZVgQMttbM17vt2feNaZRivXI6pakm7IIomykIGxDUiUwe0Dn1qeHGAENKtWQbIaLuCfNaxvnvy4myrQWI=
X-Received: by 2002:a17:907:75d7:b0:9a5:7926:e391 with SMTP id
 jl23-20020a17090775d700b009a57926e391mr1773822ejc.10.1693407043460; Wed, 30
 Aug 2023 07:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230829161116.2914040-1-bschubert@ddn.com> <20230829161116.2914040-4-bschubert@ddn.com>
 <CAJfpegsGLTiWvjfoZs9fAQ0xWK-QBwtAXe5_Msr_jiY4Rjssxg@mail.gmail.com> <77a8edad-0a26-aed5-2ee3-956a96a034de@fastmail.fm>
In-Reply-To: <77a8edad-0a26-aed5-2ee3-956a96a034de@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Aug 2023 16:50:32 +0200
Message-ID: <CAJfpegsxE35RbW3uj9AV6c_aA2C0AaixZs5TFiB9YuoMF_VkkQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] fuse: Allow parallel direct writes for O_DIRECT
To:     Bernd Schubert <aakef@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        bernd.schubert@fastmail.fm, dsingh@ddn.com,
        Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 30 Aug 2023 at 16:38, Bernd Schubert <aakef@fastmail.fm> wrote:
>
>
>
> On 8/30/23 15:28, Miklos Szeredi wrote:
> > On Tue, 29 Aug 2023 at 18:11, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> Take a shared lock in fuse_cache_write_iter. This was already
> >> done for FOPEN_DIRECT_IO in
> >>
> >> commit 153524053bbb ("fuse: allow non-extending parallel direct
> >> writes on the same file")
> >>
> >> but so far missing for plain O_DIRECT. Server side needs
> >> to set FOPEN_PARALLEL_DIRECT_WRITES in order to signal that
> >> it supports parallel dio writes.
> >
> > Hmm, I think file_remove_privs() needs exclusive lock (due to calling
> > notify_change()).   And the fallback case also.
> >
> > Need to be careful with such locking changes...
>
> Hrmm, yeah, I missed that :( Really sorry and thanks!
>
> I guess I can fix it if by exporting dentry_needs_remove_privs. I hope
> that is acceptable. Interesting is that btrfs_direct_write seems to have
> the same issue.
>
> btrfs_direct_write
>         if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
>                 ilock_flags |= BTRFS_ILOCK_SHARED;
> ...
>         err = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
> ...
>         err = btrfs_write_check(iocb, from, err);
> ...
>                         ret = file_remove_privs(file);
>
>
> I think that can be fixed as well after exporting
> dentry_needs_remove_privs().

Interesting.  Would be worth asking the btrfs devs what they think of this.

>
>
> Btw, why is fuse_direct_write_iter not dropping privileges? That is
> another change I need to document...

Generally read and write can't fail due to lack of privileges, so that
should be okay.  But it would be more consistent to drop privs during
I/O as well.  But this is something that needs some thought as well,
because there could be non-obvious consequences.

> Another issue I just see is that it needs to check file size again after
> taking the lock.

Yes.

> Thanks a lot for your review,

Thanks for doing the actual work, that's the harder one.

Thanks,
Miklos
