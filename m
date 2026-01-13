Return-Path: <linux-fsdevel+bounces-73449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA9D19DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A2F30173AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B935A392B78;
	Tue, 13 Jan 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CqNE+MCH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023B26F2A0;
	Tue, 13 Jan 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317785; cv=none; b=lJ8FSMGucpRL9tgp423LD7SpD5A9VWfO52oXtKDOu8sdxHrbcPs4rcYGHnfQCFHpnWZ+TD/Vtw5Rg9cqUEF2e97wNpvXVtJ+S/LGt7mxuME/UY6n4V5kz6zTWLLm3woigOOimmotRdPihugSxMPE22BxzD7N9W1zhAnnQj2A0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317785; c=relaxed/simple;
	bh=gcfc5wcjpJca98kHniwYmavst1O5jZiKDPMrQ9v/jdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiltNDPQ9DZMvoltAJdS8/6I4PnIzdATF7V9iJCuFKUpwb2qe9MZnIh98A+AWIG+6d17hHnhsCneJMGd/GwU/SkgLt/1aAlwpRvAcro2s4t2HMzLXhD0peHJDtGyBGYbHW+B1QU5NDcSPpNLPSoGNkrVxpAO5WoRltWL9d9nJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CqNE+MCH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r4deXc7HegwnHrb+EBuAAMgs1ckJi6PkLXe6iw1M+NE=; b=CqNE+MCH7ZhGgwgkTP/P8umWVk
	dwtCfU4NnvIfozpQzLJxGDR54pOU3XX05XBY/XUIm2vNb9Eu+o7iuwfLbbpyXsX7u08mVtgnQoJu3
	JwFsxJl+AmjdWlIUOx1bEeWHnjOhlufPlaWAUcriAl6wWaS2IGI5XLbS28tKg6OpviX5HgX+0HRR2
	jT2g/OAwClSSrc+DfmSxXiuJg027czYo2I1XCZhqLZFLIg9qzt+shiIPExPx0vAEo0D8wmgmS2zpB
	nrz+EgCi4E3/ATHoCD8MApUxW8GUVC6dJEOsHLTU8jGKIrOJlgzRLpBK0paMpmriVTg+w3hBgEJ+6
	085uTIWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfgEY-00000007MId-0i74;
	Tue, 13 Jan 2026 15:23:02 +0000
Date: Tue, 13 Jan 2026 07:23:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
	chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 02/16] fat: Implement fileattr_get for case sensitivity
Message-ID: <aWZjVkb9fSigpW2L@infradead.org>
References: <20260112174629.3729358-1-cel@kernel.org>
 <20260112174629.3729358-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112174629.3729358-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +extern int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);

No need for "extern" for function prototypes.

> +int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
> +
> +	/*
> +	 * FAT filesystems do not preserve case: stored names are

Is that actually true?  It's been a while since I deal with them,
but IIRC at least vfat is case preserving.


