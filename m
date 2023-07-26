Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1626576359F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjGZLvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjGZLvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:51:13 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A98270E;
        Wed, 26 Jul 2023 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1690371783;
        bh=jWiCyAHDoFfZLpVNTNaoY7OP9Un2BLhuB6gAtCXKxiU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=epxZ6oJu5I1Pe8FpvkK1jHRkLtIvks6AYMbFelpyGFHzchlagQmzNd50QWdc2TanX
         9FjyZYTraCEf+1/TL5wnh9gsQQmD8VUZg2kkeWK7QSSoqHxU7ldI+tn3XrFj72vD7e
         eNBmLfOoQZoadxbZi0zSV3KonoOf1Jb11MBNiQFM=
Received: from [IPv6:240e:456:1120:202:485:bd13:935c:5daf] (unknown [IPv6:240e:456:1120:202:485:bd13:935c:5daf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A1F23659A1;
        Wed, 26 Jul 2023 07:42:55 -0400 (EDT)
Message-ID: <3fa06f06727d8742a76fac9553e623095b7c7099.camel@xry111.site>
Subject: Re: [PATCH v2] splice, net: Fix splice_to_socket() for O_NONBLOCK
 socket
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jan Stancek <jstancek@redhat.com>, dhowells@redhat.com,
        kuba@kernel.org, netdev@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk
Date:   Wed, 26 Jul 2023 19:42:47 +0800
In-Reply-To: <023c0e21e595e00b93903a813bc0bfb9a5d7e368.1690219914.git.jstancek@redhat.com>
References: <023c0e21e595e00b93903a813bc0bfb9a5d7e368.1690219914.git.jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-07-24 at 19:39 +0200, Jan Stancek wrote:
> LTP sendfile07 [1], which expects sendfile() to return EAGAIN when
> transferring data from regular file to a "full" O_NONBLOCK socket,
> started failing after commit 2dc334f1a63a ("splice, net: Use
> sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()").
> sendfile() no longer immediately returns, but now blocks.
>=20
> Removed sock_sendpage() handled this case by setting a MSG_DONTWAIT
> flag, fix new splice_to_socket() to do the same for O_NONBLOCK sockets.
>=20
> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kerne=
l/syscalls/sendfile/sendfile07.c
>=20
> Fixes: 2dc334f1a63a ("splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather t=
han ->sendpage()")
> Acked-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

This issue caused the "test_asyncio" test in Python 3 test suite to hang
indefinitely.  I can confirm this patch fixes the issue.

Tested-by: Xi Ruoyao <xry111@xry111.site>

> ---
> Changes in v2:
> - add David's Acked-by
> - add netdev list
>=20
> =C2=A0fs/splice.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/splice.c b/fs/splice.c
> index 004eb1c4ce31..3e2a31e1ce6a 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -876,6 +876,8 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe=
, struct file *out,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0msg=
.msg_flags |=3D MSG_MORE;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (remain && pipe_occupancy(pipe->head, tail) > 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0msg=
.msg_flags |=3D MSG_MORE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (out->f_flags & O_NONBLOCK)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0msg.msg_f=
lags |=3D MSG_DONTWAIT;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 len - remain);

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
