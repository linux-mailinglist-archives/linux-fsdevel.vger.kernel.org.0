Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBB7A01AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 12:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjINK3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINK3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:29:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B61BEB;
        Thu, 14 Sep 2023 03:29:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE54CC433C8;
        Thu, 14 Sep 2023 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694687359;
        bh=z91D5qbFuL12k1cxFR5HlqLWojF/usGUx8PcTX1Nwlw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j8cDSiR1AwCFFS/EoQVT3m/7krDtv+Wf5SnH/mUqHhuoVJ5VooX1/KX/4h5Cer3TH
         yg7DceQc8oqCCX0JC2r5b5QpYHkxjbD51z3y5RvFKfHajqV6ZD1f7GLy7MCpsiyPjz
         8/jD4w9pEiOA5Na3xuqUyEuc9WAfGR4a4IZualYjaMaYQFcSPClCmnPeqARlwnfoX3
         lQUPm0+YsTdN6Rl0GrWZP6pN0QpaoRvVRUb+v4fZ0wLcoSzni86X8/BBXKGdyUhvhC
         HipeFzo787vehWUKgsUogBX6fBMueIf3Os/oatRYVaYjN7OPIBNJRjD1DmTDI5NpV0
         Sb//XX3Ea5ZLA==
Message-ID: <fa8ac10aa7c12f344109be815c6e3da480a33137.camel@kernel.org>
Subject: Re: [PATCHv2 nfsd/master 7/7] dlm: implement EXPORT_OP_ASYNC_LOCK
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Thu, 14 Sep 2023 06:29:17 -0400
In-Reply-To: <20230912215324.3310111-8-aahringo@redhat.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
         <20230912215324.3310111-8-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-12 at 17:53 -0400, Alexander Aring wrote:
> This patch is activating the EXPORT_OP_ASYNC_LOCK export flag to
> signal lockd that both filesystems are able to handle async lock
> requests. The cluster filesystems gfs2 and ocfs2 will redirect their
> lock requests to DLMs plock implementation that can handle async lock
> requests.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/gfs2/export.c  | 1 +
>  fs/ocfs2/export.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
> index cf40895233f5..ef1013eff936 100644
> --- a/fs/gfs2/export.c
> +++ b/fs/gfs2/export.c
> @@ -192,5 +192,6 @@ const struct export_operations gfs2_export_ops =3D {
>  	.fh_to_parent =3D gfs2_fh_to_parent,
>  	.get_name =3D gfs2_get_name,
>  	.get_parent =3D gfs2_get_parent,
> +	.flags =3D EXPORT_OP_ASYNC_LOCK,
>  };
> =20
> diff --git a/fs/ocfs2/export.c b/fs/ocfs2/export.c
> index eaa8c80ace3c..b8b6a191b5cb 100644
> --- a/fs/ocfs2/export.c
> +++ b/fs/ocfs2/export.c
> @@ -280,4 +280,5 @@ const struct export_operations ocfs2_export_ops =3D {
>  	.fh_to_dentry	=3D ocfs2_fh_to_dentry,
>  	.fh_to_parent	=3D ocfs2_fh_to_parent,
>  	.get_parent	=3D ocfs2_get_parent,
> +	.flags		=3D EXPORT_OP_ASYNC_LOCK,
>  };

Reviewed-by: Jeff Layton <jlayton@kernel.org>
