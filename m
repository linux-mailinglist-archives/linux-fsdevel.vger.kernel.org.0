Return-Path: <linux-fsdevel+bounces-22078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C81911D27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 09:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81B128309A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 07:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E816D4C9;
	Fri, 21 Jun 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGixSzB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7316C863;
	Fri, 21 Jun 2024 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955909; cv=none; b=QZgSWQdWG5J02t9y3ZHlU1zkt0VLc/SMaTbpprxO3YM+xuulDP0q+vOByv3XP7no+DIVjNtzeJHpoXnw9RyIdecdwpKDroWDW/aRS6O233dlDpby6oWZln79RpQiclbYdiwmI7Bx0jfRJIzLTNBt/7BlZ0l4sgyTrTxv0XjY4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955909; c=relaxed/simple;
	bh=BKloq4l0KXsDbGYa0GQa6fYov7fV7968BcqnN8MWPjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJzPsacPpxusINOwyVUBhy79NyLZYAkViuvdgn3YUQfTRTHRx8+Q2b2R05NjdtEls1kz7B+3vwtPHm0p+P63GZaZiuKF7a0rwiQDbGA3PCgKbr7JjKBzZ/dOb3oZ/l7wNEes3A1DkS5n7Cnve6OsfdsYAfhtcw35GcPaPFCwGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGixSzB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324D0C4AF08;
	Fri, 21 Jun 2024 07:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718955908;
	bh=BKloq4l0KXsDbGYa0GQa6fYov7fV7968BcqnN8MWPjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGixSzB2urtBGQHaEj1PJq2l1YxK33I/GFyO8CAtI61LjhZrXm5HVhXRrGPj8OOKm
	 6OuKRpqwEDPNlwzUnAKwK9LjiCMr/d47L9TSaro7UipMH2We02CJL/JXrCViVofqWT
	 1h8YChg6AfNKq6w/VxSWwtc7WGIue6E/ShLliIt4dD5CeeZOhgG2Rn36W6Jx4Mbjxs
	 u3h0GqedLl4Dc0LDKp5MEoYyxaGWcIRr+z3g4l4RIuljV1KRMzzSXgwdgCICyD68y+
	 KDDrtsjXS3GFDVSHSf6/F4IWqBkAmQe4sls92al0ojLcRk+aZsEbOv0hOBWbFZr0U/
	 5j0DbR2DbAJPQ==
Date: Fri, 21 Jun 2024 09:45:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: reorder checks in may_create_in_sticky
Message-ID: <20240621-affekt-denkzettel-3c115f68355a@brauner>
References: <20240620120359.151258-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620120359.151258-1-mjguzik@gmail.com>

On Thu, Jun 20, 2024 at 02:03:59PM GMT, Mateusz Guzik wrote:
> The routine is called for all directories on file creation and weirdly
> postpones the check if the dir is sticky to begin with. Instead it first
> checks fifos and regular files (in that order), while avoidably pulling
> globals.
> 
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 63d1fb06da6b..b1600060ecfb 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1246,9 +1246,9 @@ static int may_create_in_sticky(struct mnt_idmap *idmap,
>  	umode_t dir_mode = nd->dir_mode;
>  	vfsuid_t dir_vfsuid = nd->dir_vfsuid;
>  
> -	if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
> -	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
> -	    likely(!(dir_mode & S_ISVTX)) ||
> +	if (likely(!(dir_mode & S_ISVTX)) ||
> +	    (S_ISREG(inode->i_mode) && !sysctl_protected_regular) ||
> +	    (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos) ||
>  	    vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
>  	    vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
>  		return 0;

I think we really need to unroll this unoly mess to make it more readable?

diff --git a/fs/namei.c b/fs/namei.c
index 3e23fbb8b029..1dd2d328bae3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1244,25 +1244,43 @@ static int may_create_in_sticky(struct mnt_idmap *idmap,
                                struct nameidata *nd, struct inode *const inode)
 {
        umode_t dir_mode = nd->dir_mode;
-       vfsuid_t dir_vfsuid = nd->dir_vfsuid;
+       vfsuid_t dir_vfsuid = nd->dir_vfsuid, i_vfsuid;
+       int ret;
+
+       if (likely(!(dir_mode & S_ISVTX)))
+               return 0;
+
+       if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
+               return 0;
+
+       if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
+               return 0;
+
+       i_vfsuid = i_uid_into_vfsuid(idmap, inode);
+
+       if (vfsuid_eq(i_vfsuid, dir_vfsuid))
+               return 0;

-       if (likely(!(dir_mode & S_ISVTX)) ||
-           (S_ISREG(inode->i_mode) && !sysctl_protected_regular) ||
-           (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos) ||
-           vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
-           vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
+       if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
                return 0;

-       if (likely(dir_mode & 0002) ||
-           (dir_mode & 0020 &&
-            ((sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) ||
-             (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode))))) {
-               const char *operation = S_ISFIFO(inode->i_mode) ?
-                                       "sticky_create_fifo" :
-                                       "sticky_create_regular";
-               audit_log_path_denied(AUDIT_ANOM_CREAT, operation);
+       if (likely(dir_mode & 0002)) {
+               audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
                return -EACCES;
        }
+
+       if (dir_mode & 0020) {
+               if (sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) {
+                       audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create_fifo");
+                       return -EACCES;
+               }
+
+               if (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode)) {
+                       audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create_regular");
+                       return -EACCES;
+               }
+       }
+
        return 0;
 }

That gives us:

static int may_create_in_sticky(struct mnt_idmap *idmap,
				struct nameidata *nd, struct inode *const inode)
{
	umode_t dir_mode = nd->dir_mode;
	vfsuid_t dir_vfsuid = nd->dir_vfsuid, i_vfsuid;
	int ret;

	if (likely(!(dir_mode & S_ISVTX)))
		return 0;

	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
		return 0;

	if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
		return 0;

	i_vfsuid = i_uid_into_vfsuid(idmap, inode);

	if (vfsuid_eq(i_vfsuid, dir_vfsuid))
		return 0;

	if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
		return 0;

	if (likely(dir_mode & 0002)) {
		audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
		return -EACCES;
	}

	if (dir_mode & 0020) {
		if (sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) {
			audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create_fifo");
			return -EACCES;
		}

		if (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode)) {
			audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create_regular");
			return -EACCES;
		}
	}

	return 0;
}

