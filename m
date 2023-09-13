Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8698479E96A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbjIMNfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbjIMNfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:35:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF3F19BB;
        Wed, 13 Sep 2023 06:35:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC56C433C8;
        Wed, 13 Sep 2023 13:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694612125;
        bh=gGXT3kmObMJ3rj+5DgWC+3LTzwUysc9Y/omZ+GtMi+s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cfJPJakdgyhah+veTqJt77C1nmRxv2bpIUW49He0ziJQ7cxpSUW1R1Hxr5nYySJE/
         hVaY4sfW3X+BL81oE64oLlOv00IBKkPdvezLLTo+iPGXB23P4J41Fnp0/smRCkohzg
         tXTDk0u+6oADJcwM9ulix3XhHBy5NcH/LU3VOGgEpUYE3HKf3gtgjFqPVcwZEEVFh0
         M5QSCI3Ohv9k74NK8EUkdVe4y/TJ3iq3RYIFCSW9own0GQfafUhXVfhfwlTohx2AAH
         lYpyX10gmkJXDYnv8+cFPnNlDA5oc2htGEuOBAt993LMAM0zT1eoLxJQfrb15WJs1n
         yseXXNjynikkg==
Message-ID: <0c9331becf9b4b09ae8f6cf4a8a68d0bb8738022.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
From:   Jeff Layton <jlayton@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Sep 2023 09:35:23 -0400
In-Reply-To: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-13 at 09:33 -0400, Jeff Layton wrote:
> Nathan reported that he was seeing the new warning in
> setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> trying to set the atime and mtime via notify_change without also
> setting the ctime.
>=20
> POSIX states that when the atime and mtime are updated via utimes() that
> we must also update the ctime to the current time. The situation with
> overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.

Bah...make that "analogous".

> notify_change will fill in the value.
>=20
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> The new WARN_ON_ONCE in setattr_copy_mgtime caught a bug! Fix up
> overlayfs to ensure that the ctime on the upper inode is also updated
> when copying up the atime and mtime.
> ---
>  fs/overlayfs/copy_up.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index d1761ec5866a..ada3fcc9c6d5 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -337,7 +337,7 @@ static int ovl_set_timestamps(struct ovl_fs *ofs, str=
uct dentry *upperdentry,
>  {
>  	struct iattr attr =3D {
>  		.ia_valid =3D
> -		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET,
> +		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_=
CTIME,
>  		.ia_atime =3D stat->atime,
>  		.ia_mtime =3D stat->mtime,
>  	};
>=20
> ---
> base-commit: 9cb8e7c86ac793862e7bea7904b3426942bbd7ef
> change-id: 20230913-ctime-299173760dd9
>=20
> Best regards,

--=20
Jeff Layton <jlayton@kernel.org>
