Return-Path: <linux-fsdevel+bounces-22451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA89173B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8B91F2339B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0AE17E470;
	Tue, 25 Jun 2024 21:52:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EF143C49;
	Tue, 25 Jun 2024 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352366; cv=none; b=gHRhP/gwT+gtX27h0PYOpw8sbN7TrtlHh4wz74/WZXo11fE8CwLgWgk/1BAFZvpOl/WLBkA8ksbyEhmdhr2ZBRVAOBGt5CqhblkAsq+nV7n/aDwuhY2qc31UZ7ES5Clf9Pr+gSOV3kpLVpU9V3ZNfbUZJ8SuZ/HgZmPXiRP7RoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352366; c=relaxed/simple;
	bh=QO9dugwlYKgNsUq0e+VqY/qfE31FenfYRo7KEIhEGWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9jY3IN+QUke1oaKyHM9erv74JEgOwnmmVDXoWnyX0RBIWTlOwhVZpcA3iMfCIGiGXdUm57pI+45ZCVvEogE8PxS7wKTSDbRWx0eBkwHRFlKWacrADGXH7fFgJ9wB84sxQ7F2UhtgQaGlioHGHVaCdSUaix1T3W1Cj1fhpSJWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id EDF5B2055FA2;
	Wed, 26 Jun 2024 06:47:16 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 45PLlFiq188477
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 06:47:16 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 45PLlFk91028401
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 06:47:15 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 45PLlFm71028400;
	Wed, 26 Jun 2024 06:47:15 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH v2 2/2] fat: always use dir_emit_dots and ignore . and
 .. entries
In-Reply-To: <20240625175133.922758-3-cascardo@igalia.com> (Thadeu Lima de
	Souza Cascardo's message of "Tue, 25 Jun 2024 14:51:33 -0300")
References: <20240625175133.922758-1-cascardo@igalia.com>
	<20240625175133.922758-3-cascardo@igalia.com>
Date: Wed, 26 Jun 2024 06:47:15 +0900
Message-ID: <871q4kae58.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

> Instead of only using dir_emit_dots for the root inode and explictily
> requiring the . and .. entries to emit them, use dir_emit_dots for all
> directories.
>
> That allows filesystems with directories without the . or .. entries to
> still show them.

Unacceptable to change the correct behavior to broken format. And
unlikely break the userspace, however this still has the user visible
change of seek pos.

Thanks.

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  fs/fat/dir.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 4e4a359a1ea3..e70781569de5 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -583,15 +583,14 @@ static int __fat_readdir(struct inode *inode, struct file *file,
>  	mutex_lock(&sbi->s_lock);
>  
>  	cpos = ctx->pos;
> -	/* Fake . and .. for the root directory. */
> -	if (inode->i_ino == MSDOS_ROOT_INO) {
> -		if (!dir_emit_dots(file, ctx))
> -			goto out;
> -		if (ctx->pos == 2) {
> -			fake_offset = 1;
> -			cpos = 0;
> -		}
> +
> +	if (!dir_emit_dots(file, ctx))
> +		goto out;
> +	if (ctx->pos == 2) {
> +		fake_offset = 1;
> +		cpos = 0;
>  	}
> +
>  	if (cpos & (sizeof(struct msdos_dir_entry) - 1)) {
>  		ret = -ENOENT;
>  		goto out;
> @@ -671,13 +670,8 @@ static int __fat_readdir(struct inode *inode, struct file *file,
>  	if (fake_offset && ctx->pos < 2)
>  		ctx->pos = 2;
>  
> -	if (!memcmp(de->name, MSDOS_DOT, MSDOS_NAME)) {
> -		if (!dir_emit_dot(file, ctx))
> -			goto fill_failed;
> -	} else if (!memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
> -		if (!dir_emit_dotdot(file, ctx))
> -			goto fill_failed;
> -	} else {
> +	if (memcmp(de->name, MSDOS_DOT, MSDOS_NAME) &&
> +	    memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
>  		unsigned long inum;
>  		loff_t i_pos = fat_make_i_pos(sb, bh, de);
>  		struct inode *tmp = fat_iget(sb, i_pos);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

