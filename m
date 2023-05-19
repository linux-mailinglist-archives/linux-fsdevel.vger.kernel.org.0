Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8ED709DF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjESR1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 13:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjESR1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 13:27:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D82103;
        Fri, 19 May 2023 10:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F324B616F7;
        Fri, 19 May 2023 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C2C433D2;
        Fri, 19 May 2023 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684517218;
        bh=3drYpyYKUnH1cb6kQ/uVQsoKFoAeU6vU9OI6/6PAfZk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n9S35mWf0Pm1llwyRM/w2pbmtXfNp34VbrsNfXPxN520wya1N0C9fZhbaDkGXp6t1
         ++4elSII5PbPazoPs1V13ArsNYNWNCG9iBVCR8Jg+0ORpWnLuUWnIvNyTthkwCh/Wp
         mMkIJ/RKwTOi9mGU1PpxaVARUlGIQaKWBPHYsWJq7aOFuZoXPs/Xsal++FoCctM77B
         T3WzBD4cszc8qG0Mpj1oUa2IW7kT7dBh48dusd/dRyZLrXwhjMXA990AA7/jN7Qacf
         vg6p0Bhiq9oBCEdH0NSkyjZxonQ6UpawB1FL3Dh9IyGluDL25TXzfnenQB65Xtwag7
         1bCFyT4ZTuATQ==
Message-ID: <9672a3006f0f8424c09e0f00dcb8ecaa1c42abb6.camel@kernel.org>
Subject: Re: [PATCH] cachefiles: Allow the cache to be non-root
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 May 2023 13:26:56 -0400
In-Reply-To: <1853230.1684516880@warthog.procyon.org.uk>
References: <1853230.1684516880@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
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

On Fri, 2023-05-19 at 18:21 +0100, David Howells wrote:
>    =20
> Set mode 0600 on files in the cache so that cachefilesd can run as an
> unprivileged user rather than leaving the files all with 0.  Directories
> are already set to 0700.
>=20
> Userspace then needs to set the uid and gid before issuing the "bind"
> command and the cache must've been chown'd to those IDs.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/cachefiles/namei.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 82219a8f6084..66482c193e86 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -451,7 +451,8 @@ struct file *cachefiles_create_tmpfile(struct cachefi=
les_object *object)
> =20
>  	ret =3D cachefiles_inject_write_error();
>  	if (ret =3D=3D 0) {
> -		file =3D vfs_tmpfile_open(&nop_mnt_idmap, &parentpath, S_IFREG,
> +		file =3D vfs_tmpfile_open(&nop_mnt_idmap, &parentpath,
> +					S_IFREG | 0600,
>  					O_RDWR | O_LARGEFILE | O_DIRECT,
>  					cache->cache_cred);
>  		ret =3D PTR_ERR_OR_ZERO(file);
>=20

Seems safe enough, and if it helps allow this to run unprivileged then:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
