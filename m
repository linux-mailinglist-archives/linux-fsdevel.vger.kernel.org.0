Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4E78DBC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbjH3Shh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244031AbjH3MQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA00CC9
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693397724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXW+YJ7Es1NUxs1wO/8B0lyOdXp6T+rmiitd4bvcpy8=;
        b=SG+WuMrf5wj6EH0bpIhdtMrbBWrcJEbV1Dq2liUzRemjDqjiHbSKd6vob/iCylWdFKlbNg
        JyvpUGUoIn82lAOvdJ1LX888EfBHKbPI0PQpUlt5bKwIGIAaq2cK6QWDYQ43VwzSzZdZkJ
        VHBneZzBphz5VtUCi+nlLgHCdAaw10Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-MyflNwU3M1KqQ8t-zusS_w-1; Wed, 30 Aug 2023 08:15:22 -0400
X-MC-Unique: MyflNwU3M1KqQ8t-zusS_w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50091a3fd87so6117585e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693397721; x=1694002521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXW+YJ7Es1NUxs1wO/8B0lyOdXp6T+rmiitd4bvcpy8=;
        b=J9/hnZL7xRAPFE5hpKG120Usu7kIVhS5CD/NhOM8s5cQzgfT8jcGo/b174FTMt1brt
         nCJGPLXZJAV/sCu99IVj0ObXE8xo09gA9pkOiZAo5l8KU1rqlXSkmctYRB6pv1VUCF8U
         IaBTCjvctTkJoiezRPbNEa0JiSUsc5K4yjWNAoKsAhHcxGA8C2qhjFNtE3NoD04dRFb3
         7FYoiBnX/+pVJxddyI9HIsvNmetoIFp22VtzNWVu/xqynK7QtOQ2LjsoIRVi8EXCSGxR
         sq5V4BFblojRP4Fwg5Ddb7Z+OfZX4ofyS6/Pw6jP5QvDIWvQuKv4FoEDt3zIgm4DQAPS
         fWEQ==
X-Gm-Message-State: AOJu0YxOxXS2zpz62jXsZbd9PfFuZjX79SRxs0njNDnjwJ7yGh6Q1SvO
        5JEG6kQYOn2gf4ZfmJ14sCUbWHlSzqko6ac/XxvyVXpNLPM2bvjOX9voCmgKZSq0unbHElbdqTo
        bW148YClICdBACddI41N0v3bzDMMxb2Z1c6AKc5yq4g==
X-Received: by 2002:a05:6512:3a8e:b0:500:bc5a:517a with SMTP id q14-20020a0565123a8e00b00500bc5a517amr1599278lfu.56.1693397721195;
        Wed, 30 Aug 2023 05:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH4CTWLGIc2/L6PKaTeIATaE0rFTOba0dxmf+/1WydwsNUiyEi5RRMTlB/tcj2GzHwHxxqFM7q4A7ioapsKgE=
X-Received: by 2002:a05:6512:3a8e:b0:500:bc5a:517a with SMTP id
 q14-20020a0565123a8e00b00500bc5a517amr1599259lfu.56.1693397720785; Wed, 30
 Aug 2023 05:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230823213352.1971009-1-aahringo@redhat.com> <20230823213352.1971009-3-aahringo@redhat.com>
 <ae36349af354dcf40c29ff1c6bf7d930f08e7115.camel@kernel.org>
In-Reply-To: <ae36349af354dcf40c29ff1c6bf7d930f08e7115.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 30 Aug 2023 08:15:09 -0400
Message-ID: <CAK-6q+hZ8T+Ji5kkmrE4xfA0mf+B7k44nySJqDf2zyJEO3n9Ng@mail.gmail.com>
Subject: Re: [PATCH 2/7] lockd: don't call vfs_lock_file() for pending requests
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, Aug 25, 2023 at 2:10=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2023-08-23 at 17:33 -0400, Alexander Aring wrote:
> > This patch returns nlm_lck_blocked in nlmsvc_lock() when an asynchronou=
s
> > lock request is pending. During testing I ran into the case with the
> > side-effects that lockd is waiting for only one lm_grant() callback
> > because it's already part of the nlm_blocked list. If another
> > asynchronous for the same nlm_block is triggered two lm_grant()
> > callbacks will occur but lockd was only waiting for one.
> >
> > To avoid any change of existing users this handling will only being mad=
e
> > when export_op_support_safe_async_lock() returns true.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/lockd/svclock.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index 6e3b230e8317..aa4174fbaf5b 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -531,6 +531,23 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fil=
e *file,
> >               goto out;
> >       }
> >
> > +     spin_lock(&nlm_blocked_lock);
> > +     /*
> > +      * If this is a lock request for an already pending
> > +      * lock request we return nlm_lck_blocked without calling
> > +      * vfs_lock_file() again. Otherwise we have two pending
> > +      * requests on the underlaying ->lock() implementation but
> > +      * only one nlm_block to being granted by lm_grant().
> > +      */
> > +     if (export_op_support_safe_async_lock(inode->i_sb->s_export_op,
> > +                                           nlmsvc_file_file(file)->f_o=
p) &&
> > +         !list_empty(&block->b_list)) {
> > +             spin_unlock(&nlm_blocked_lock);
> > +             ret =3D nlm_lck_blocked;
> > +             goto out;
> > +     }
>
> Looks reasonable. The block->b_list check is subtle, but the comment
> helps.

thanks. To be honest, I am "a little bit" worried (I am thinking of
this scenario) that we might have a problem here with multiple
identically lock requests being granted at the same time. In such
cases the most fields of struct file_lock are mostly the same and
nlm_compare_locks() checks exactly on those fields. I am concerned
this corner case could cause problems, but it is a very rare case and
it makes totally no sense that an application is doing such a request.

I am currently trying to get an xfstest for this upstream.

- Alex

