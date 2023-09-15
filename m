Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42A47A1A06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjIOJLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjIOJKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:10:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12342D74
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:10:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ada6b0649fso260216666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1694769020; x=1695373820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRjYglBqs5F5J7S3mQRUnlVAa9BG9BX7AnjHY2r5MEE=;
        b=W3wOOla97DfZjxv4BidSkKhVJPTl+34XdjM7Lx/fDmkGbS/RR5gNNhnfzOUdOHRRhs
         dTqkFk2tz/oqeAeGxnDOMYWfR/xFY5xek9ZP4NxGtmc90K7gAM1HCMOp+XH4F2EC8vfD
         koue8YqhCMQ/ivvI8UW3UF8e7Gpuwsq7B0/Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769020; x=1695373820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRjYglBqs5F5J7S3mQRUnlVAa9BG9BX7AnjHY2r5MEE=;
        b=nI0qMRy2utivzl1amoj8o+WC7nZhMPXAngCl2uYeTCCdm91ra9tDZi/EP+UPqqDLyu
         uO9IOBmBFTL/D84eIRG1+i5kguADY2AIjlL8Ja6vSh6vrHP36cXzekXx98j0tTnjTEXM
         cmJz8up2WuvHgko4w3ByJ51ExQVoOLHDIQ6Ogv4iUX9HT92DGZerdxThrLNNvP6jfZuF
         5NT9DqV5TK7LC39g4g7VaegT+8ao75k5H0k+GOayGaXEIxGX70+lxleozQMEbg/hcxrI
         PRsNcx3+9kgjGke9w/FCBuMsAMBMwsZwqlP/yKl0Z6fh2zLEveQQXKpyj8R/cMBeDasr
         3r/A==
X-Gm-Message-State: AOJu0YxAKAqDFCwNd8E8gWjmpgSpAFRNu8B54/cNZ4JzNyVvn5zaokcw
        v8/hiCqDjFNT3K2Z+mGPcFaAhk4oPRszaTc06FJAqulRZtgCfSGB
X-Google-Smtp-Source: AGHT+IF5o+bJdY1XoE9oumhDri70UKYOZcaWOi4aRZ9DJwItzvK+ny3LRDTQ+Ry1vPqF3T4LbISGgzRE4RCxdvaDSiE=
X-Received: by 2002:a17:906:76d9:b0:9a9:e393:8bd6 with SMTP id
 q25-20020a17090676d900b009a9e3938bd6mr819105ejn.38.1694769020190; Fri, 15 Sep
 2023 02:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <CAHC9VhSQb0fYz9FqEu-1jQ1UNsnt-asrKuPt4ufui92GC+=5=Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSQb0fYz9FqEu-1jQ1UNsnt-asrKuPt4ufui92GC+=5=Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 15 Sep 2023 11:10:08 +0200
Message-ID: <CAJfpegsct9a9D8p==mQcAfN_pJWWbXSj4oM9LHgTQEk+KPPaAw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Paul Moore <paul@paul-moore.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Sept 2023 at 22:40, Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Sep 13, 2023 at 11:23=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.=
com> wrote:

> ...
>
> > +static int do_statmnt(struct stmt_state *s)
> > +{
> > +       struct statmnt *sm =3D &s->sm;
> > +       struct mount *m =3D real_mount(s->mnt);
> > +
> > +       if (!capable(CAP_SYS_ADMIN) &&
> > +           !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> > +               return -EPERM;
>
> I realize statmnt() is different from fstatfs(), but from an access
> control perspective they look a lot alike to me which is why I think
> we should probably have a security_sb_statfs() call here.  Same thing
> for the listmnt() syscall in patch 3/3.

Okay, makes sense.

Thanks,
Miklos
