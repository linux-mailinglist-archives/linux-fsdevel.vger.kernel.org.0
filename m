Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A578DAB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbjH3Sgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbjH3Mj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD098D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693399148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2sZJy7coZxAVZRyjBbEYGHy7Fw4aLyn9Mmqx4qqxfs=;
        b=WPsERkRm4a330G0taRSjAVNgtKTx/F//CWQqQuzlqfLn3gklJU/fljdPAHuAVVNkGYSnRf
        ldqDcOyr9IND5aAVbh8pZfJiRV1IRTOb3NnzT6KxuUf9Zv/k2Cune+MdQg+VQW6+oNxG+K
        E5O99/QTka2dFUnPi2OWXHsip8V28JY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-kCXLl_pPM5GjfpBCSm5Crw-1; Wed, 30 Aug 2023 08:39:07 -0400
X-MC-Unique: kCXLl_pPM5GjfpBCSm5Crw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52a3e9c53e7so4367487a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399146; x=1694003946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2sZJy7coZxAVZRyjBbEYGHy7Fw4aLyn9Mmqx4qqxfs=;
        b=QyO6cuk+nwn+9lkxpZACplRp2ceuZtfbU0t0u7+ErxDrLMCkbHka/A6mRltP+J6qrp
         sGkStzLfDJ+qdh7gwXPeAnL0aqNXxmxqsMP9HODnGW4sp6wdPrAK7RylFWRTpmevcxXf
         R+k5mUMkYSvjcif7xeXHUKPbUeoo7qXVxz7i3NEuwpYRgq5bptbUwAy3wqy9oW4xd6p4
         61IhUzRa2/8HvPkBqWD4tM9TQvkXZDtUMOvmVhooQoFSYeqauRRR4H5PHT0W7Pwl970B
         LHZUKWXh3AcNatKyVEB//Y6q7TyiV77rEGclEghe31y9caEYfSdaouGq5ZBIqXpLTS2g
         OMeQ==
X-Gm-Message-State: AOJu0YxAgRsg1UNOib5IZRH9EgMPf3tEUqTsKCB+Qd6GuruiMBpX3r6+
        756b5t++AKifBHTuI2ZNjkquI0hWgFdN8f2TnYLPNk8AiN15tLU3ayWPyhb6HoTVLm4ZL2G4j3J
        l+ELlD7mEktJirgoIunGV1GlwNxympcCSam6XhsGY0A==
X-Received: by 2002:a50:ef1a:0:b0:51b:c714:a2a1 with SMTP id m26-20020a50ef1a000000b0051bc714a2a1mr1972653eds.7.1693399146288;
        Wed, 30 Aug 2023 05:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfewQayRTjS+ETA5KSggFgeSlv49VrL0zQXHu5OfkWiTGdWkUo1JPaTBQ/aMX8Dt5k7rGTtcbDWOy5lMZ3Qew=
X-Received: by 2002:a50:ef1a:0:b0:51b:c714:a2a1 with SMTP id
 m26-20020a50ef1a000000b0051bc714a2a1mr1972643eds.7.1693399146053; Wed, 30 Aug
 2023 05:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230823213352.1971009-1-aahringo@redhat.com> <20230823213352.1971009-7-aahringo@redhat.com>
 <9a8ead64cdd32fdad29cae3aff0bd447f33a32c2.camel@kernel.org>
In-Reply-To: <9a8ead64cdd32fdad29cae3aff0bd447f33a32c2.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 30 Aug 2023 08:38:54 -0400
Message-ID: <CAK-6q+i+j1TUmWGH+fdYHix5TwujH8_kuR5ayUv9h6Ah8OQecQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] dlm: use FL_SLEEP to determine blocking vs non-blocking
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, Aug 25, 2023 at 2:18=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2023-08-23 at 17:33 -0400, Alexander Aring wrote:
> > This patch uses the FL_SLEEP flag in struct file_lock to determine if
> > the lock request is a blocking or non-blocking request. Before dlm was
> > using IS_SETLKW() was being used which is not usable for lock requests
> > coming from lockd when EXPORT_OP_SAFE_ASYNC_LOCK inside the export flag=
s
> > is set.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/dlm/plock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > index 0094fa4004cc..0c6ed5eeb840 100644
> > --- a/fs/dlm/plock.c
> > +++ b/fs/dlm/plock.c
> > @@ -140,7 +140,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 =
number, struct file *file,
> >       op->info.optype         =3D DLM_PLOCK_OP_LOCK;
> >       op->info.pid            =3D fl->fl_pid;
> >       op->info.ex             =3D (fl->fl_type =3D=3D F_WRLCK);
> > -     op->info.wait           =3D IS_SETLKW(cmd);
> > +     op->info.wait           =3D !!(fl->fl_flags & FL_SLEEP);
> >       op->info.fsid           =3D ls->ls_global_id;
> >       op->info.number         =3D number;
> >       op->info.start          =3D fl->fl_start;
>
> Not sure you really need the !!, but ok...
>

The wait is a byte value and FL_SLEEP doesn't fit into it, I already
run into problems with it. I don't think somebody does a if (foo->wait
=3D=3D 1) but it should be set to 1 or 0.

An alternative would be: ((fl->fl_flags & FL_SLEEP) =3D=3D FL_SLEEP). I am
not sure what the coding style says here. I think it's more important
what the C standard says about !!(condition), but there are other
users of this in the Linux kernel. :-/

- Alex

