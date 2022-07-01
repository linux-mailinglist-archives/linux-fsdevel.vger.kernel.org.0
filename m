Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ECD563192
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 12:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiGAKjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiGAKjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:39:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F009D7B363;
        Fri,  1 Jul 2022 03:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96CB5B82F5C;
        Fri,  1 Jul 2022 10:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CEBC3411E;
        Fri,  1 Jul 2022 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656671940;
        bh=T0XBeDYljbRFmQyINnaCOdDR8jU5Y5HNwbtK/xZuj9g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mf2WP2dI5ypSyV8u1nmWowrJ2uhtBjF8ww25aIqzj5blp3T6WNm1K8Cl/zfH6kMoo
         x3nwNVG6R+MnI3oZjIQ9V7cLgXcbg3Vk9y5O2H4LMv5IheVA9VKApz9eDaDTNI/QS2
         Frkft1NZGJ2LHtREQf57Hp1yNDO0tHBnVXAFZIhzsGHvdqtAb7CqEQ9Gq/BcLXQ3O0
         /Rq8r9fWS0hBzT6rFuvyx5U2Xea4AxRVQALg+fU0vIHo6x/pHXCLy8U7H0jRzkrpPD
         cgvvlpbReWlyeJNhfnWzcYfFMqS17qIa5pVW4A/bjygNx0hDhIYLWBRWpyGnKibDus
         nHli1VhQ4rS+w==
Message-ID: <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
Subject: Re: [PATCH 1/2] netfs: release the folio lock and put the folio
 before retrying
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, idryomov@gmail.com, dhowells@redhat.com
Cc:     vshankar@redhat.com, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
Date:   Fri, 01 Jul 2022 06:38:57 -0400
In-Reply-To: <20220701022947.10716-2-xiubli@redhat.com>
References: <20220701022947.10716-1-xiubli@redhat.com>
         <20220701022947.10716-2-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-07-01 at 10:29 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>=20
> The lower layer filesystem should always make sure the folio is
> locked and do the unlock and put the folio in netfs layer.
>=20
> URL: https://tracker.ceph.com/issues/56423
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/netfs/buffered_read.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 42f892c5712e..257fd37c2461 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -351,8 +351,11 @@ int netfs_write_begin(struct netfs_inode *ctx,
>  		ret =3D ctx->ops->check_write_begin(file, pos, len, folio, _fsdata);
>  		if (ret < 0) {
>  			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
> -			if (ret =3D=3D -EAGAIN)
> +			if (ret =3D=3D -EAGAIN) {
> +				folio_unlock(folio);
> +				folio_put(folio);
>  				goto retry;
> +			}
>  			goto error;
>  		}
>  	}

I don't know here... I think it might be better to just expect that when
this function returns an error that the folio has already been unlocked.
Doing it this way will mean that you will lock and unlock the folio a
second time for no reason.

Maybe something like this instead?

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 42f892c5712e..8ae7b0f4c909 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -353,7 +353,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
                        trace_netfs_failure(NULL, NULL, ret, netfs_fail_che=
ck_write_begin);
                        if (ret =3D=3D -EAGAIN)
                                goto retry;
-                       goto error;
+                       goto error_unlocked;
                }
        }
=20
@@ -418,6 +418,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 error:
        folio_unlock(folio);
        folio_put(folio);
+error_unlocked:
        _leave(" =3D %d", ret);
        return ret;
 }

