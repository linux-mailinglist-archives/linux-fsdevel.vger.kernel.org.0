Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BF75FBC5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 22:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJKUpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJKUps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259517E838
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665521147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOkcw94jKoThb1YsGFgEY6secfp0Ar+WXfJ+Ghon9q0=;
        b=Dv9es6PYnaTycs8PNM3fsu/en7HAPbC0D2o6s9ziEmYkgOv46c2/hmVky9zKghcv0sKiUh
        XJeCOwAav5I3z6tBLHzg/n9Jq2VMhlecMEsvYQUqWR39/aYmuqWUgIbvGuanUmYGcNJcPK
        NsF3OA+sAOOdIUMCNZ5YLmiZrnxrtq0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-pV15iaf6NGqgZeLYKd24AQ-1; Tue, 11 Oct 2022 16:45:46 -0400
X-MC-Unique: pV15iaf6NGqgZeLYKd24AQ-1
Received: by mail-qk1-f200.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso12480582qkp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 13:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOkcw94jKoThb1YsGFgEY6secfp0Ar+WXfJ+Ghon9q0=;
        b=rJIvUZ0KpiZKighPdmZGZ1bCI4nP9a7uv0l35dkhYvO27/+cq0KE822vw/vZjwI7jN
         a9yygBDeFgQPSEmwtRyQVngx7HcOtw5CUWwEhYgABIF7ys9kWPtHmPFQMJRxo9GOLSuf
         ShERmPCmJ+jJ3Gga5QMZgUyRcWnU0/1ONqHQAmUryFrczOYRwS3M0+RVs7Y/P4RJJpeq
         pM/iDjRuXk+syWb2k3pMdODUsgn+ATqM8bFqp/mCtmpFWAf5+0Vd2NT01FDAPFhhTtFB
         MmhgRrgUXLRUpKUifxwifK19X3WEtvw1l5Hrfu48+VeflJbDqNB/h1QZfrjDqSeeKGOq
         DQZQ==
X-Gm-Message-State: ACrzQf3PaGmq92SquF6Xo/I6F/EBK/JuRip99I2A1CEsHwg6DyxbsGe/
        fLR2dPd601ruYdxsp5jpFBO8jnQz2NZdzDT/31jbzDpsCcJpTNO4Ycrlt5u8GTV2Xop/xNCeZTe
        dOZ6B0YRiMrTx91YZ7mPkeNoxxA==
X-Received: by 2002:a05:620a:16aa:b0:6ce:70b2:598b with SMTP id s10-20020a05620a16aa00b006ce70b2598bmr17723036qkj.670.1665521145549;
        Tue, 11 Oct 2022 13:45:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4wVB7dGSkAPwDnirR1rGdKqjuIHBNirWI+NGnyUsln8ZEV3Q7BW4Cl3WsKBjBCcUXZj9enlw==
X-Received: by 2002:a05:620a:16aa:b0:6ce:70b2:598b with SMTP id s10-20020a05620a16aa00b006ce70b2598bmr17723017qkj.670.1665521145227;
        Tue, 11 Oct 2022 13:45:45 -0700 (PDT)
Received: from [172.16.1.108] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id o19-20020a05620a2a1300b006cddf59a600sm14139046qkp.34.2022.10.11.13.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:45:44 -0700 (PDT)
Message-ID: <5a5a92423c8bac5b275c213ed1ce3fa59cafda4f.camel@redhat.com>
Subject: Re: [RFC] fl_owner_t and use of filp_close() in
 nfs4_free_lock_stateid()
From:   Jeff Layton <jlayton@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Tue, 11 Oct 2022 16:45:43 -0400
In-Reply-To: <CAJfpegsgtke1X7FGpMSgTGdDsOxU7kqPqf2JbOAnqgMj0XFoSQ@mail.gmail.com>
References: <Y0Wv6qe3r8/Djt7s@ZenIV>
         <CAJfpegsgtke1X7FGpMSgTGdDsOxU7kqPqf2JbOAnqgMj0XFoSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-10-11 at 21:02 +0200, Miklos Szeredi wrote:
> On Tue, 11 Oct 2022 at 20:04, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> > Another interesting question is about FUSE ->flush() - how is the
> > server supposed to use the value it gets from
> >         inarg.lock_owner =3D fuse_lock_owner_id(fm->fc, id);
> > in fuse_flush()?  Note that e.g. async write might be followed by
> > close() before the completion.  Moreover, it's possible to start
> > async write and do unshare(CLONE_FILES); if the descriptor table
> > used to be shared and all other threads exit after our unshare,
> > it's possible to get
> >         async write begins, fuse_send_write() called with current->file=
s as owner
> >         flush happens, with current->files as id
> >         what used to be current->files gets freed and memory reused
> >         async write completes
> >=20
> > Miklos, could you give some braindump on that?
>=20
> The lock_owner in flush is supposed to be used for remote posix lock
> release [1].   I don't like posix lock semantics the least bit, and in
> hindsight it would have been better to just not try to support remote
> posix locks (nfs doesn't, so why would anyone care for it in fuse?)
> Anyway, it's probably too late to get rid of this wart now.
>=20

The NFS client maintains lock records in the local VFS. When a file is
closed, the VFS issues a whole file unlock. You're probably getting
bitten by this in locks_remove_posix:

        ctx =3D  smp_load_acquire(&inode->i_flctx);
        if (!ctx || list_empty(&ctx->flc_posix))
                return;

Because FUSE doesn't set any locks in the local kernel, that final
unlock never occurs.

There are a couple of options here: You could have FUSE start setting
local lock records, or you could look at pushing the above check down
into the individual ->lock ops.

> The lock_owner field in read/write/setattr was added for mandatory
> locking [2].  Now that support for mandatory locking has been removed
> this is dead code, I guess.  Will clean up in fuse as well.
>=20

That sounds like a good plan.

>=20
> [1] v2.6.18: 7142125937e1 ("[PATCH] fuse: add POSIX file locking support"=
)
> [2] v2.6.24: f33321141b27 ("fuse: add support for mandatory locking")
>=20

