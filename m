Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ABC597580
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiHQSC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiHQSC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:02:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897D48A7D0;
        Wed, 17 Aug 2022 11:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E30D8CE1E3D;
        Wed, 17 Aug 2022 18:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C69EC433C1;
        Wed, 17 Aug 2022 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660759373;
        bh=wsEZUarWfOAbXbr/WU8jbErUqxQi3eDq6VQAPp1GO50=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JgJLvbAYyFnyYiPb5HohTYes+B1H/tI739OH/BMKasP/tDlw8iwnhG7VLcr2WDF6R
         ZklT2iWQOXHe1sJw7jRSZmmhPStj3mYMSexuzbdepowQgCigeaJGR8gIJGahIoc2My
         e3hByENNgGj/HpV5Ae25QhhgzRGdJX+bX7Saupuujek7+KbkcEGl5xro3BCvevAGWK
         UqAi43PcmwV7axQtBRSwhbue3sL5Uwjzvez9Cyhl24lbB+RaqDUe2e+w4Gdz5oNLdc
         Ykb/KIu/aZuxjry1/O0s+/171JcwguxK5ea3gIIahtQSVtoGzcBTuZUlqG43AguYtn
         iHIfSKk3yuY5w==
Message-ID: <8048714f47f19944a95a8703086069369bb7193e.camel@kernel.org>
Subject: Re: [PATCH] locks: Fix dropped call to ->fl_release_private()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Aug 2022 14:02:51 -0400
In-Reply-To: <166075758809.3532462.13307935588777587536.stgit@warthog.procyon.org.uk>
References: <166075758809.3532462.13307935588777587536.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-08-17 at 18:33 +0100, David Howells wrote:
> Prior to commit 4149be7bda7e, sys_flock() would allocate the file_lock
> struct it was going to use to pass parameters, call ->flock() and then ca=
ll
> locks_free_lock() to get rid of it - which had the side effect of calling
> locks_release_private() and thus ->fl_release_private().
>=20
> With commit 4149be7bda7e, however, this is no longer the case: the struct
> is now allocated on the stack, and locks_free_lock() is no longer called =
-
> and thus any remaining private data doesn't get cleaned up either.
>=20
> This causes afs flock to cause oops.  Kasan catches this as a UAF by the
> list_del_init() in afs_fl_release_private() for the file_lock record
> produced by afs_fl_copy_lock() as the original record didn't get delisted=
.
> It can be reproduced using the generic/504 xfstest.
>=20
> Fix this by reinstating the locks_release_private() call in sys_flock().
> I'm not sure if this would affect any other filesystems.  If not, then th=
e
> release could be done in afs_flock() instead.
>=20
> Fixes: 4149be7bda7e ("fs/lock: Don't allocate file_lock in flock_make_loc=
k().")
> cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> cc: Chuck Lever <chuck.lever@oracle.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>=20
>  fs/locks.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index c266cfdc3291..f2d5aca782c6 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2116,7 +2116,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned i=
nt, cmd)
> =20
>  	error =3D security_file_lock(f.file, fl.fl_type);
>  	if (error)
> -		goto out_putf;
> +		goto out_release;

It probably doesn't hurt anything, but I don't think it's necessary to
call locks_release_private if the ->flock op was never called.

> =20
>  	can_sleep =3D !(cmd & LOCK_NB);
>  	if (can_sleep)
> @@ -2128,7 +2128,8 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned i=
nt, cmd)
>  					    &fl);
>  	else
>  		error =3D locks_lock_file_wait(f.file, &fl);
> -
> +out_release:
> +	locks_release_private(&fl);
^^^
I think we just need the above line.

>   out_putf:
>  	fdput(f);
> =20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
