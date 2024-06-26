Return-Path: <linux-fsdevel+bounces-22542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98F919878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 21:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A991B2828A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA81922E4;
	Wed, 26 Jun 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bPqgu9v6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604CBE6C;
	Wed, 26 Jun 2024 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431213; cv=none; b=jvdkwVofhYdft3uZQ45QWwlNtYssGVblB5xos5uJK09gMtQ75BNPFbXM2jRmN8MEb7mfIQytGnU/8gJlHNb1AkTZJmVUZ2Ac3kSjEOQqFnJ2elRcU9WBmVKFqZRsPK+Su+JPHessHoUk08pkbVWMX6n511PWZbQ2TdKav0x8lIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431213; c=relaxed/simple;
	bh=g/ioBzCSVDqSPBS6IBljlwJBhjN2Mdqu60+lQO8OqSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNimfmaAfnH6+JydYQQrDxYPJXddyoEVhf4BjhxmnZNGJ2yZYydaiZobUxiE8FEZi5aHAsq6XPSsa6ctRzidnG3VQVYmU6VBIl4Gh5gCHbiMlVKYfGxL59Q8XJaL7kUAigYmRFN+GsJbjuNlrvM9ESSksr00guxOdQO7RkkTyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bPqgu9v6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SVeZo/sykfAtUGNgIOtWwp6zcpPi0nW7pbSEEQYvGSE=; b=bPqgu9v6Yddrpt/6usqzHdnAH3
	IbvbdhdmEJT8f+O0emYcG81B8UdEZXBvlZzvcHU1pWTaSC21iThWCByp6zKcO1yg7nvIJW80reEPb
	3T0TyTz1E+QPtJLjW0QF3HIEoJkn/QIm2Km+pd91yfeINiFHhVc3IftjXhFaf1t1OtrxVGkPxWuyl
	xbSH8sCLdw+9Y75BnW2UKJwneosX17Mv+gb8H0gjUeKCIZOn1dn5zPa6f4l5vu5OwFLo1LzA/7Q1o
	X6RNafkNweLCdcfIQumRiqbfI4xAZjYjsk79bZQwx0iVaMPuXhfWMt6hAYPmoLg8KoZ3RlG97OCQ2
	9mQLGoZg==;
Received: from 179-125-70-190-dinamico.pombonet.net.br ([179.125.70.190] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sMYbB-007p7w-OE; Wed, 26 Jun 2024 21:46:34 +0200
Date: Wed, 26 Jun 2024 16:46:26 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH v2 2/2] fat: always use dir_emit_dots and ignore . and ..
 entries
Message-ID: <ZnxwEtmYeZcKopJK@quatroqueijos.cascardo.eti.br>
References: <20240625175133.922758-1-cascardo@igalia.com>
 <20240625175133.922758-3-cascardo@igalia.com>
 <871q4kae58.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q4kae58.fsf@mail.parknet.co.jp>

On Wed, Jun 26, 2024 at 06:47:15AM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> > Instead of only using dir_emit_dots for the root inode and explictily
> > requiring the . and .. entries to emit them, use dir_emit_dots for all
> > directories.
> >
> > That allows filesystems with directories without the . or .. entries to
> > still show them.
> 
> Unacceptable to change the correct behavior to broken format. And
> unlikely break the userspace, however this still has the user visible
> change of seek pos.
> 
> Thanks.
> 

I agree that if this breaks userspace with a good filesystem or regresses
in a way that real applications would break, that this needs to be redone.

However, I spent a few hours doing some extra testing (I had already run
some xfstests that include directory testing) and I failed to find any
issues with this fix.

If this would break, it would have broken the root directory. In the case
of a directory including the . and .. entries, the d_off for the .. entry
will be set for the first non-dot-or-dotdot entry. For ., it will be set as
1, which, if used by telldir (or llseek), will emit the .. entry, as
expected.

For the case where both . and .. are absent, the first real entry will have
d_off as 2, and it will just work.

So everything seems to work as expected. Do you see any user visible change
that would break any applications?

Thanks.
Cascardo.

> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >  fs/fat/dir.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> > index 4e4a359a1ea3..e70781569de5 100644
> > --- a/fs/fat/dir.c
> > +++ b/fs/fat/dir.c
> > @@ -583,15 +583,14 @@ static int __fat_readdir(struct inode *inode, struct file *file,
> >  	mutex_lock(&sbi->s_lock);
> >  
> >  	cpos = ctx->pos;
> > -	/* Fake . and .. for the root directory. */
> > -	if (inode->i_ino == MSDOS_ROOT_INO) {
> > -		if (!dir_emit_dots(file, ctx))
> > -			goto out;
> > -		if (ctx->pos == 2) {
> > -			fake_offset = 1;
> > -			cpos = 0;
> > -		}
> > +
> > +	if (!dir_emit_dots(file, ctx))
> > +		goto out;
> > +	if (ctx->pos == 2) {
> > +		fake_offset = 1;
> > +		cpos = 0;
> >  	}
> > +
> >  	if (cpos & (sizeof(struct msdos_dir_entry) - 1)) {
> >  		ret = -ENOENT;
> >  		goto out;
> > @@ -671,13 +670,8 @@ static int __fat_readdir(struct inode *inode, struct file *file,
> >  	if (fake_offset && ctx->pos < 2)
> >  		ctx->pos = 2;
> >  
> > -	if (!memcmp(de->name, MSDOS_DOT, MSDOS_NAME)) {
> > -		if (!dir_emit_dot(file, ctx))
> > -			goto fill_failed;
> > -	} else if (!memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
> > -		if (!dir_emit_dotdot(file, ctx))
> > -			goto fill_failed;
> > -	} else {
> > +	if (memcmp(de->name, MSDOS_DOT, MSDOS_NAME) &&
> > +	    memcmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
> >  		unsigned long inum;
> >  		loff_t i_pos = fat_make_i_pos(sb, bh, de);
> >  		struct inode *tmp = fat_iget(sb, i_pos);
> 
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

