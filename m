Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B255975DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 20:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiHQSnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 14:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiHQSnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C27A00E5;
        Wed, 17 Aug 2022 11:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08CC6138B;
        Wed, 17 Aug 2022 18:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5665C433D6;
        Wed, 17 Aug 2022 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660761779;
        bh=mZlL2HyXzYY0uChXc/V3+qQzkCuusK5P5PJx7zGmsH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m2hF+lr71XxxwoN9szdS3g6zeud9f/3jjfq8Qvgq5GRTR7U5Ho7resONzKNOtmHvs
         xJ7ulDj1xLhwqxexs8GE6tOMaykayDoff2GvSUaqI2WzWIeXEnLImXRl6ZpIan6lrE
         mugM5xO9aHj9epx8UW5nTNDHBkm58T9FUYXxWxxV1sdI6acLFlx+tfqM5zpJrJjYaQ
         FpLgLuxV3RrKg6fXetCnwscitVMamBDbKHcjyEeBz6xh7bTXgCiQjqESvs9im0hqlU
         MULEpGLaMmGW2ObdV91Bqq3sE9El9umcoyehOQ28C42lg7o4KEjHSrem8GsSyqRUMb
         4wGjF7jEx6L3g==
Message-ID: <e3952386b70e9bf07e676c47a5a9fa63df93bacf.camel@kernel.org>
Subject: Re: [PATCH v2] locks: Fix dropped call to ->fl_release_private()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Aug 2022 14:42:57 -0400
In-Reply-To: <166076168742.3677624.2936950729624462101.stgit@warthog.procyon.org.uk>
References: <166076168742.3677624.2936950729624462101.stgit@warthog.procyon.org.uk>
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

On Wed, 2022-08-17 at 19:41 +0100, David Howells wrote:
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
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #2)
>  - Don't need to call ->fl_release_private() after calling the security
>    hook, only after calling ->flock().
>=20
> Fixes: 4149be7bda7e ("fs/lock: Don't allocate file_lock in flock_make_loc=
k().")
> cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> cc: Chuck Lever <chuck.lever@oracle.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/166075758809.3532462.13307935588777587536=
.stgit@warthog.procyon.org.uk/ # v1
> ---
>=20
>  fs/locks.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index c266cfdc3291..607f94a0e789 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2129,6 +2129,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned i=
nt, cmd)
>  	else
>  		error =3D locks_lock_file_wait(f.file, &fl);
> =20
> +	locks_release_private(&fl);
>   out_putf:
>  	fdput(f);
> =20
>=20
>=20

Looks good. I'll get this into -next and plan to get it up to Linus
soon.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
