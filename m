Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D57369E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjFTKvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjFTKvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:51:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8431ECC;
        Tue, 20 Jun 2023 03:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB8161083;
        Tue, 20 Jun 2023 10:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E049EC433C8;
        Tue, 20 Jun 2023 10:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687258303;
        bh=i86LPEOlOqpx7HI3CWxGcRqaB9ZXh9sljcD8rZYOYO8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uuJQ0BEjYCGeN2dM1Ot4aAeFXYLM1uKNyCTpqUbi9vuX5uoLZgMd12vDMzn7ZG8C+
         nDl3HMNYeXDL6jE4rhfKzfUTJAqu7YtB8frKrSBtx7xZ4SYFKQYumYszXY273whhvT
         f/RSmRvFhVXSeMhgBxDH6Njc/FsIjG7cdVIIlnFqgUH9ElweY7hiXu0JUu67F7I/Mi
         ZyIpXn+oyizgx5zTEo/IHlsFmhfLgla+oGzwRaPZmMP02/CLF2+Qc32kbjMNaKSSx1
         hjL02+jlGUl3RMTGlDjkqRQ03qkOY70OBPmnH8WccCRbM/42e4iPKSr/pSEUJLKNxD
         h/SkYIXEywigQ==
Message-ID: <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 20 Jun 2023 06:51:41 -0400
In-Reply-To: <20230620095507.2677463-3-stsp2@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
         <20230620095507.2677463-3-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-06-20 at 14:55 +0500, Stas Sergeev wrote:
> Currently F_OFD_GETLK sets the pid of the lock owner to -1.
> Remove such behavior to allow getting the proper owner's pid.
> This may be helpful when you want to send some message (like SIGKILL)
> to the offending locker.
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
>=20
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Christian Brauner <brauner@kernel.org>
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
>=20
> ---
>  fs/locks.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 210766007e63..ee265e166542 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2158,8 +2158,6 @@ static pid_t locks_translate_pid(struct file_lock *=
fl, struct pid_namespace *ns)
>  	pid_t vnr;
>  	struct pid *pid;
> =20
> -	if (IS_OFDLCK(fl))
> -		return -1;
>  	if (IS_REMOTELCK(fl))
>  		return fl->fl_pid;
>  	/*

NACK on this one.

OFD locks are not owned by processes. They are owned by the file
description (hence the name). Because of this, returning a pid here is
wrong.

This precedent comes from BSD, where flock() and POSIX locks can
conflict. BSD returns -1 for the pid if you call F_GETLK on a file
locked with flock(). Since OFD locks have similar ownership semantics to
flock() locks, we use the same convention here.

Cheers,=20
--=20
Jeff Layton <jlayton@kernel.org>
