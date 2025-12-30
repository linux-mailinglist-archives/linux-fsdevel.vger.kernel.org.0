Return-Path: <linux-fsdevel+bounces-72229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE7CE8CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 07:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB176300FA34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57EA2FBDE6;
	Tue, 30 Dec 2025 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dYzp0z8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D62F7AB8;
	Tue, 30 Dec 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767077106; cv=none; b=bcsutUg9frt6erPhuSNXc/KiARa3RjWiRo9nLZSNn3qMqApPG1WrPe3H+MBHyZzoRiNS2vPwMUmCbYWnTwIcDTrq3joupzuEF0Hzozfg0cld9yNC4sslFnSCB2TDQFk4Oak67b+L59O0KGze2u3INvDBy3OIol6GWX7pTHDQk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767077106; c=relaxed/simple;
	bh=TecJ8ubsBKjXoo9Zu3w4ty03eSiYuFx/goGVv523tWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfwutzaU+xSIwF9G5+JHhpWatqE1Bs4pHtiAc9MQGGafFdsYoBm7M+xxMMTgB9G7cBSCV8FAjt+7feaUD6ULY2qFLrKm1eI7LKWuwPQrFKWIT2W7Ik1YfIaYjcZp2Bz9dsyO1JSk1RV0cAyM8SNbaUE5au+Dg95vdspAQCyC+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dYzp0z8t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1IHLh87uprdMGZRUuwyLNwJY0qxE51+7FKCOXaDFxcc=; b=dYzp0z8tP/Fcpu0oo09n+K31yL
	bitA5HBGnaxqMSQaGLdlNzT2mouV6qtS8i3oe5Rz5RjalQWY1BhpbylFW8g2e3GnCpQ+Nl522XQy2
	/04l8/dSjRGOK8HmAxKBhdGDX3bd4NIoV7Sr3Ld3G2BFMcwdEV4S+JXPOyIas1EH5WZ23AqgFJNxL
	rT6fNb8ukx2x0XvCteVNcQYuevIg7PY7xR1Se1y75rigyb+Wo9Scuo7Nz1iiNVaQu9mcsn9TykM9v
	MMnfNyQIQO4bUgkhBSCQGtDoPQeSL/zZ/YbQCl4nuoSaK8OlLSBw0PxRzdAHrtn094UJ2T8wmEGFP
	NxDEHqog==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaTTV-00000002hTT-0BJQ;
	Tue, 30 Dec 2025 06:44:57 +0000
Date: Tue, 30 Dec 2025 06:44:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>,
	hirofumi@mail.parknet.co.jp, linux-fsdevel@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] WARNING in vfat_rmdir
Message-ID: <aVN06OKsKxZe6-Kv@casper.infradead.org>
References: <CALf2hKtp5SQCAzjkY8UvKU6Qqq4Qt=ZSjN18WK_BU==v4JOLuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALf2hKtp5SQCAzjkY8UvKU6Qqq4Qt=ZSjN18WK_BU==v4JOLuA@mail.gmail.com>

On Tue, Dec 30, 2025 at 02:18:17AM +0800, Zhiyu Zhang wrote:
> +++ b/fs/fat/dir.c
> @@ -92,8 +92,10 @@ static int fat__get_entry(struct inode *dir, loff_t *pos,
>         *bh = NULL;
>         iblock = *pos >> sb->s_blocksize_bits;
>         err = fat_bmap(dir, iblock, &phys, &mapped_blocks, 0, false);
> -       if (err || !phys)
> -               return -1;      /* beyond EOF or error */
> +       if (err)
> +               return err;     /* real error (e.g., -EIO, -EUCLEAN) */
> +       if (!phys)
> +               return -1;      /* beyond EOF */

Ooh, -1 is a real errno, so -1 or errno is a bad API.  I'd suggest just
returning -ENOENT directly instead of translating it in the caller.







