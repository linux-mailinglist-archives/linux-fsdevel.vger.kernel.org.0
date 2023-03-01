Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A656A7361
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCASZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 13:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCASZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:25:06 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE2234D3;
        Wed,  1 Mar 2023 10:25:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id j17so14946311ljq.11;
        Wed, 01 Mar 2023 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsmpw0D+wVLg2f4A5FKHFXC1PrzHNdWE6aaZ6Ob/5F4=;
        b=N2o/TkrjobO7nq+2U7h5UDrD8Y9J9z7Q0sii+mudByIuIVHsElBLr//cdWp1p1HaTG
         6fKoIwhqt/OOk41twF1duoi/mL9vIOIlOzZeaPYG169HKOQVtH0BDKgVkUkODWXt/1Cz
         b2zQLU5TE1m8PBn3uuYEnNGJObNwcrJlyNqXQez+2kCeKR5kh5XjbPLXQZIly/vkgBnJ
         n4SEciYTJ3gCqxCEq3UbWkYK5uQWrReneL8Y78/bRpAJ87Oq3Qj8+vVrtBSne0I4g5LC
         aimdgDZ5DUZRsF4iIHym1ZenOSZ7oKVVzNrzAIevhQQo+buSh90k90i5PUYgKAEtY1Id
         3eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsmpw0D+wVLg2f4A5FKHFXC1PrzHNdWE6aaZ6Ob/5F4=;
        b=QuKxDR2MgtYLBiu5zRqMUcFSpkGXiftjqi1KqOJ3Ma8YNrtEMNjlwHPj6By8DTUwUY
         cSNu5P1u74umfKKVUPmRsYaQvRjABcmgSD0/NLy9+xeVlx744v+Xd/pRdd5Q9XzKS4nr
         nG9Nuj1XkOg2km2N4soY3F9DEjfAvwNzvSfEC/KP13Pcz7Y+mXNQaf4TbrTUPumLcgUk
         IGuD33pfZvd2hjjFwF8evBIiuYL+N2lGpnuiGra1nTH5cLEuB+dLyC7/pSAfqLIMQqE7
         /Nmygq6RyeGilWsn+L/4rDY3NqJZn9XppEL8Beg0Q88uN/abrqRTotfHuxXwqObwP+d+
         L09w==
X-Gm-Message-State: AO0yUKVdgNfxvYjK7Tjs5AqNPX6YSqWKXiU9y+eBSR1NjQlZC43Hdvxz
        wQew9ARYXnw0txKzacBzEpCFkoTZgUThYteynaw=
X-Google-Smtp-Source: AK7set/jnQmZcP1/IeHiFXMC1XzNjQw++DN85W3WS6+eHxNziEznxsqPkXt2Mk+r/ipuYy+XBPBxHx23WxvaLjY374I=
X-Received: by 2002:a2e:a278:0:b0:295:9a96:a5fd with SMTP id
 k24-20020a2ea278000000b002959a96a5fdmr2358537ljm.5.1677695102024; Wed, 01 Mar
 2023 10:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20230228223838.3794807-1-dhowells@redhat.com> <20230228223838.3794807-2-dhowells@redhat.com>
 <07171afd91dbd05b425d92e54f9832f9.pc@manguebit.com>
In-Reply-To: <07171afd91dbd05b425d92e54f9832f9.pc@manguebit.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 1 Mar 2023 12:24:50 -0600
Message-ID: <CAH2r5mtD7tF7UH0sXbvX2PASV5a63X0bmGhXK6KU3UJf+HB1zg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cifs: Fix memory leak in direct I/O
To:     Paulo Alcantara <pc@manguebit.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I also verified that this fixes the problem that Murphy pointed out - thx

On Wed, Mar 1, 2023 at 9:11=E2=80=AFAM Paulo Alcantara <pc@manguebit.com> w=
rote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > When __cifs_readv() and __cifs_writev() extract pages from a user-backe=
d
> > iterator into a BVEC-type iterator, they set ->bv_need_unpin to note
> > whether they need to unpin the pages later.  However, in both cases the=
y
> > examine the BVEC-type iterator and not the source iterator - and so
> > bv_need_unpin doesn't get set and the pages are leaked.
> >
> > I think this may be responsible for the generic/208 xfstest failing
> > occasionally with:
> >
> >       WARNING: CPU: 0 PID: 3064 at mm/gup.c:218 try_grab_page+0x65/0x10=
0
> >       RIP: 0010:try_grab_page+0x65/0x100
> >       follow_page_pte+0x1a7/0x570
> >       __get_user_pages+0x1a2/0x650
> >       __gup_longterm_locked+0xdc/0xb50
> >       internal_get_user_pages_fast+0x17f/0x310
> >       pin_user_pages_fast+0x46/0x60
> >       iov_iter_extract_pages+0xc9/0x510
> >       ? __kmalloc_large_node+0xb1/0x120
> >       ? __kmalloc_node+0xbe/0x130
> >       netfs_extract_user_iter+0xbf/0x200 [netfs]
> >       __cifs_writev+0x150/0x330 [cifs]
> >       vfs_write+0x2a8/0x3c0
> >       ksys_pwrite64+0x65/0xa0
> >
> > with the page refcount going negative.  This is less unlikely than it s=
eems
> > because the page is being pinned, not simply got, and so the refcount
> > increased by 1024 each time, and so only needs to be called around ~209=
7152
> > for the refcount to go negative.
> >
> > Further, the test program (aio-dio-invalidate-failure) uses a 32MiB sta=
tic
> > buffer and all the PTEs covering it refer to the same page because it's
> > never written to.
> >
> > The warning in try_grab_page():
> >
> >       if (WARN_ON_ONCE(folio_ref_count(folio) <=3D 0))
> >               return -ENOMEM;
> >
> > then trips and prevents us ever using the page again for DIO at least.
> >
> > Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rat=
her than a page list")
> > Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> > Link: https://lore.kernel.org/r/CAH2r5mvaTsJ---n=3D265a4zqRA7pP+o4MJ36W=
CQUS6oPrOij8cw@mail.gmail.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Shyam Prasad N <nspmangalore@gmail.com>
> > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > cc: Paulo Alcantara <pc@cjr.nz>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: linux-cifs@vger.kernel.org
> > ---
> >  fs/cifs/file.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>



--=20
Thanks,

Steve
