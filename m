Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07AD669C7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjAMPfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 10:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjAMPe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:34:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC6887F30;
        Fri, 13 Jan 2023 07:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2F76B8217E;
        Fri, 13 Jan 2023 15:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F489C433D2;
        Fri, 13 Jan 2023 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623683;
        bh=/WFO5kmEHVzUbgmBmc+dReM3alIskIwlJX9FItlyzA0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M/cLbI4QV7jm1LK27vAyJ+HIrxp8zVXiaTGY5XZ6h7YqA+Dq21xp0ghv/4J4oldks
         GPyo48+AdYHebZfyxDv3TWKirZtyRI3tEWvFkcOot31Y6/WRK/T2nk6DAILvGjQ3Pf
         K4FDjWj6R/qpUBYzvksCxqSLxBqoxjsM289Yg5oOar6kTFHjR22UEOhNKfxslceCs6
         /XN1Kewc5IhCSmv3hmkrV95/9IFK5dAvdDTM5JW70bRzQpgzu1sl0mkC45AzKq639F
         Xwq9QeUhbDgsKRFBsbsmLiiPt/WGJ43VgytsD1HWY56EH4g8QiTh2ilN5pYXsLKwKO
         Q3ELrohTZGb9Q==
Message-ID: <bc07b4d69f6c709988d2faca50717a402c1ed81e.camel@kernel.org>
Subject: Re: [PATCH v3 2/2] fscache: Use clear_and_wake_up_bit() in
 fscache_create_volume_work()
From:   Jeff Layton <jlayton@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>, linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com
Date:   Fri, 13 Jan 2023 10:28:01 -0500
In-Reply-To: <20230113115211.2895845-3-houtao@huaweicloud.com>
References: <20230113115211.2895845-1-houtao@huaweicloud.com>
         <20230113115211.2895845-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-01-13 at 19:52 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> fscache_create_volume_work() uses wake_up_bit() to wake up the processes
> which are waiting for the completion of volume creation. According to
> comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
> needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
> flag and waitqueue_active() before invoking wake_up_bit().
>=20
> Fixing it by using clear_and_wake_up_bit() to add the missing memory
> barrier.
>=20
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fscache/volume.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index 903af9d85f8b..cdf991bdd9de 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -280,8 +280,7 @@ static void fscache_create_volume_work(struct work_st=
ruct *work)
>  	fscache_end_cache_access(volume->cache,
>  				 fscache_access_acquire_volume_end);
> =20
> -	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
> -	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
> +	clear_and_wake_up_bit(FSCACHE_VOLUME_CREATING, &volume->flags);
>  	fscache_put_volume(volume, fscache_volume_put_create_work);
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
