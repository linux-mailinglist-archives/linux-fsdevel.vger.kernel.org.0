Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06D4788E7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjHYSTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjHYSTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:19:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0426A6;
        Fri, 25 Aug 2023 11:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 437AB663BA;
        Fri, 25 Aug 2023 18:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC86C433C8;
        Fri, 25 Aug 2023 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692987528;
        bh=Tb9IAeZ7wUBkaE34M2HBL7CqEE4h643Sj+ns9NzVydQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p0Fy1sgSeZm+qa7+TSiaMK6SZSLBieQOezV3XiXS7drUxYuwT28awcVrAUDlrkjl7
         U7MI5h5uYeeYGG3YYtHoYCIzu/e+cYrC8kO8K3MNp/VEgnRJBcZmjFZajTpYPAt4uz
         p5Ylynb+AoTZDu3CScziYtdeNHYpp9APVdB3T4iZadJ9/rXYxAJQQ5HO0DCWitSE8t
         AQ33Rg6wT9vKiK1p/682/nmyXmpPIWEOI9swv6g76CYFzyE6nNQIAm8KZG3tVjSv+R
         /NrhTE7F18x7+s2DXLqKl01/lPglYMfCEppaUXVCrBl2wFORH6eHtSjiWxwd1PA4aE
         8oUfkQuKFSNxw==
Message-ID: <9a8ead64cdd32fdad29cae3aff0bd447f33a32c2.camel@kernel.org>
Subject: Re: [PATCH 6/7] dlm: use FL_SLEEP to determine blocking vs
 non-blocking
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Fri, 25 Aug 2023 14:18:46 -0400
In-Reply-To: <20230823213352.1971009-7-aahringo@redhat.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
         <20230823213352.1971009-7-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-08-23 at 17:33 -0400, Alexander Aring wrote:
> This patch uses the FL_SLEEP flag in struct file_lock to determine if
> the lock request is a blocking or non-blocking request. Before dlm was
> using IS_SETLKW() was being used which is not usable for lock requests
> coming from lockd when EXPORT_OP_SAFE_ASYNC_LOCK inside the export flags
> is set.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/plock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index 0094fa4004cc..0c6ed5eeb840 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -140,7 +140,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 nu=
mber, struct file *file,
>  	op->info.optype		=3D DLM_PLOCK_OP_LOCK;
>  	op->info.pid		=3D fl->fl_pid;
>  	op->info.ex		=3D (fl->fl_type =3D=3D F_WRLCK);
> -	op->info.wait		=3D IS_SETLKW(cmd);
> +	op->info.wait		=3D !!(fl->fl_flags & FL_SLEEP);
>  	op->info.fsid		=3D ls->ls_global_id;
>  	op->info.number		=3D number;
>  	op->info.start		=3D fl->fl_start;

Not sure you really need the !!, but ok...

Reviewed-by: Jeff Layton <jlayton@kernel.org>
