Return-Path: <linux-fsdevel+bounces-30836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB3A98EA4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBFD1C20E3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 07:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1E126BFC;
	Thu,  3 Oct 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ttqtx+QI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF484A39;
	Thu,  3 Oct 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940224; cv=none; b=BgFR6QEtKBujxOTctvb3yFMWf2ktms1xOyUFf7HZC7YAEWZVli4G06IwcWbdRs+Ypou3DAW2cM+EfGjLVKgjRy8tXORJFJdpame316/FIUSE6hLJFu6bezoOy0J5hWC4zZpywAe6w1puOqVsw0b336E0f37Hk7qYejQB4zTaDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940224; c=relaxed/simple;
	bh=boIGii97GtnIAYFvV4UnJstxUlseiejWTQ+bIPYtkkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD1v2cO3YY9l/l3RCZVRfuxx8eHTrvUYaOi6xvoaoey/Dt2Jm/nVpAv2jURo270d1lxZ6O3y+K9XT3IUs0FjI5WoIf6wkH9HTluTLBh9KIctxozovEKUuaQAPaOs9HrpeoH4ymx2Oi3auwBfxfUlufE/zM0Gn3TY3ohHp2jz56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ttqtx+QI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9gQTSOdAxNgE/UHE36OTqZ/8I7rKzF2rYjwAHLuDrxc=; b=Ttqtx+QIJ8HuJUc6hfh37CmhfF
	jmnSxl7R1coO/UyqC5hZIdq/iKD+/WFXHqSZuq9Hbc/jg8Ms5nyEKVewvVHvNZSxL2jjpph2XAfH6
	fuW1/5H0HoinpzwqD+qQVu/PNT1jC6knf7cc/NTavHB3vKTlTpbDTDl7rk6ZaSzgq/qB67aTvekUo
	hNjh8VQ8hgWnDQOXFLWe8AP0Uk3OSlTD3FQk1/toCpLa6gsGzzoRqTkWzrS5Vu78tlcJBAVVT1Txs
	kCr9YxPx1KuGbrxdB16GmLXQBtnIzsOPthB8trtpcHIa6LEeSRY/P83j41lzrI4LKKOZ1sz0jWx1n
	Q122q2GA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swGBZ-00000008O6p-0vSa;
	Thu, 03 Oct 2024 07:23:41 +0000
Date: Thu, 3 Oct 2024 00:23:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org
Subject: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
Message-ID: <Zv5GfY1WS_aaczZM@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-5-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 11:33:21AM +1000, Dave Chinner wrote:
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1223,109 +1223,60 @@ static void hook_inode_free_security_rcu(void *inode_security)
>  
>  /*
>   * Release the inodes used in a security policy.
> - *
> - * Cf. fsnotify_unmount_inodes() and invalidate_inodes()
>   */
> +static int release_inode_fn(struct inode *inode, void *data)

Looks like this is called from the sb_delete LSM hook, which
is only implemented by landlock, and only called from
generic_shutdown_super, separated from evict_inodes only by call
to fsnotify_sb_delete.  Why did LSM not hook into that and instead
added another iteration of the per-sb inode list?

(Note that this is not tying to get Dave to fix this, just noticed
it when reviewing this series)


