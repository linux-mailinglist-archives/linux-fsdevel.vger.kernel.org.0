Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F0B77EEB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 03:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347498AbjHQBZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 21:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347504AbjHQBYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA492721
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 18:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692235444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjasKeXZqylsbZptWllQNMerqPBUwmOArgVba6SAq8Q=;
        b=HpTJdGW9Mtg8MsafkzhKMVvsMmShdS+gGzfxUWgXPmb/nEMZiF/m3Uo8OgXl6pfSwZO06H
        W8qGahsmge4XJfhPnc5sS3mvc8H/TZc2zwPT6Na57gSWGvh6hvpJ29vybTjbUU3I/bJ/fJ
        pbprbV4unLDTBU32UjsEH96TnEg1AXc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-qP6tOTfKNfKEvyhN-VODBw-1; Wed, 16 Aug 2023 21:24:00 -0400
X-MC-Unique: qP6tOTfKNfKEvyhN-VODBw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5256fdb3e20so1745512a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 18:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692235439; x=1692840239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjasKeXZqylsbZptWllQNMerqPBUwmOArgVba6SAq8Q=;
        b=dcDxTnjezVf33i1s4FPucIih9zekEpAsSTatWsh5ADN72QEt8YHjq6Y0jg5dYdfk9q
         KkTZ/6BLxQxCyQATVXDWCL9yZMbN5Y+eVEgruwylHgj/EWAp/Pr+uwDjnr2UoZP6/dJI
         fbatMB4ODocCL9x0jrd8srJwc+8Ubuhl3wecXnm7LoPnHl6970QYtHfK6ahxF866M7a2
         8l08stK6xs2GawUMx+JMyw2EGWTmYafKDNXhJD3ss5MD8TYFyqBqxPpjhQ+I7B9s5rff
         hTih2jV63OlxVpr9cRrRRnypbXCi21KY9LdYjRn4Ml/D8GkBPyWGfQZOvWndC/i/8Z3w
         fpVQ==
X-Gm-Message-State: AOJu0YzDfeIgK10BoNYr3qlbheKCc+ajXdhcHcHIHIAIFRuzZ4NsRq24
        y1jLmVf/BNkDzt1GqjxbSN+98kTkHbn7TagnBKcLLdCTU7LgtPXKrdvxLW7Bemq5PHXnwL1YWWt
        uIMGD0p9YkuidKMZLfeov2I40YUbR86nHaennIHGc0A==
X-Received: by 2002:aa7:c545:0:b0:524:5e4c:2fa4 with SMTP id s5-20020aa7c545000000b005245e4c2fa4mr2839456edr.14.1692235438944;
        Wed, 16 Aug 2023 18:23:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXDmfKQ7ys1l6lXBj07FDJ7WlcIO7oafTPjac90Yx5immK+W1gBVjH7vhGznIaT59kMvjiA8PZ+Qat0vf3KLE=
X-Received: by 2002:aa7:c545:0:b0:524:5e4c:2fa4 with SMTP id
 s5-20020aa7c545000000b005245e4c2fa4mr2839440edr.14.1692235438645; Wed, 16 Aug
 2023 18:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230814211116.3224759-1-aahringo@redhat.com> <20230814211116.3224759-5-aahringo@redhat.com>
 <ca18531b54306d27218daf8e90b72ef3a4b8e44f.camel@kernel.org>
In-Reply-To: <ca18531b54306d27218daf8e90b72ef3a4b8e44f.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 16 Aug 2023 21:23:47 -0400
Message-ID: <CAK-6q+iTe86JKqeEsfUanwmu6wOxz=CqL_H_NEiq2vZ8PwcWQA@mail.gmail.com>
Subject: Re: [RFCv2 4/7] locks: update lock callback documentation
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, Aug 16, 2023 at 8:01=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> > This patch updates the existing documentation regarding recent changes
> > to vfs_lock_file() and lm_grant() is set. In case of lm_grant() is set
> > we only handle FILE_LOCK_DEFERRED in case of FL_SLEEP in fl_flags is no=
t
> > set. This is the case of an blocking lock request. Non-blocking lock
> > requests, when FL_SLEEP is not set, are handled in a synchronized way.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/locks.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/locks.c b/fs/locks.c
> > index df8b26a42524..a8e51f462b43 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2255,21 +2255,21 @@ int fcntl_getlk(struct file *filp, unsigned int=
 cmd, struct flock *flock)
> >   * To avoid blocking kernel daemons, such as lockd, that need to acqui=
re POSIX
> >   * locks, the ->lock() interface may return asynchronously, before the=
 lock has
> >   * been granted or denied by the underlying filesystem, if (and only i=
f)
> > - * lm_grant is set. Callers expecting ->lock() to return asynchronousl=
y
> > - * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and=
 only if)
> > - * the request is for a blocking lock. When ->lock() does return async=
hronously,
> > - * it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when the l=
ock
> > - * request completes.
> > - * If the request is for non-blocking lock the file system should retu=
rn
> > - * FILE_LOCK_DEFERRED then try to get the lock and call the callback r=
outine
> > - * with the result. If the request timed out the callback routine will=
 return a
> > + * lm_grant and FL_SLEEP in fl_flags is set. Callers expecting ->lock(=
) to return
> > + * asynchronously will only use F_SETLK, not F_SETLKW; When ->lock() d=
oes return
>
> Isn't the above backward? Shouldn't it say "Callers expecting ->lock()
> to return asynchronously will only use F_SETLKW, not F_SETLK" ?
>

So far I know lockd will always use F_SETLK only, if it's a blocking
or non-blocking request you need to evaluate FL_SLEEP. But if
lm_grant() is not set we are using a check on cmd if it's F_SETLK or
F_SETLKW to check if it's non-blocking or blocking.

If lm_grant() is set and checking on F_SETLKW should never be the
case, because it will never be true (speaking from lockd point of
view).

- Alex

