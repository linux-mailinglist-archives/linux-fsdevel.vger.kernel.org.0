Return-Path: <linux-fsdevel+bounces-52766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE0BAE657D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E87188C9DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2CC299A83;
	Tue, 24 Jun 2025 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O0ORMoVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5329551B;
	Tue, 24 Jun 2025 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769521; cv=none; b=JRu/AJv6X/86YjQL2iZeup5d4LpGm1pnrkymVyUpG55U8VjgE0TP4kQkDh8jKSsX/jMGVOP3F2sEjwboAxqlGPVG20nlClfk7MmrrB0k54KoCdw8ta+J7Zcgkal7zA23is1RtF6qF+PDSYZpDklmIw96/J0Mpp7MJUusRnopPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769521; c=relaxed/simple;
	bh=6H/6DkhwBEk6xZXj6xYuHV8A9YsL6O4OURI3iBlHbWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCtUVDsQSSjwS1Oth8iwCrUXDeXNiUxqf3O1cAY7RKDnkH5XZ2f6VnFpAOGlTotTEoYalrAei5/uDOzgp+JSiLvaQSA+SGyxu00K3pkEsqVK/phaLxc5waiNTDs4YFxNY0tADgGBqZXhO2eozCzgin7e2daSNExgjb21qdm6m/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O0ORMoVA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YOojs8ETOh0nTkI9FVoRaG17pTblKI2h/qJphUDsFTg=; b=O0ORMoVA2HBFIa95a4tYoOnfak
	MlNH1yfUbdVu/C/pxQlWEsaEhdAx3u7SfeayvsOe9NUYSILkqFBRqkm4yIBf1E8pvaYTgHU8nzzvY
	y9JJ10OQ6HASMGlWlOnmVsnklPeMvsR+pzbKqhpAlJa+iKEYdPU8j+FtVvU+WBWkAqRtHAbbtF8t5
	eudvW7VJjfuSDpm7I/N24ZvaqCI5U+9SFvyDByBHQRUA97w0vqSV8Uv9Q4aWCqg4RF3hVL5G4FTxB
	yxwniFZbWrdvugPLzzqFJ9gn1vfOSJd+Vr5DzpRRDd0fnpYhXAZqoPh4iXN99K8hUZRhmK4+AG+Vl
	uuV/Unfw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU37w-00000006bv4-0Kku;
	Tue, 24 Jun 2025 12:51:52 +0000
Date: Tue, 24 Jun 2025 13:51:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>,
	"hch@infradead.org" <hch@infradead.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chentao325@qq.com" <chentao325@qq.com>
Subject: Re: [PATCH v2 3/5] fs: change write_begin/write_end interface to
 take struct kiocb *
Message-ID: <aFqfZ9hiiW4qnYtO@casper.infradead.org>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
 <20250624121149.2927-4-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624121149.2927-4-chentaotao@didiglobal.com>

On Tue, Jun 24, 2025 at 12:12:08PM +0000, 陈涛涛 Taotao Chen wrote:
> -static int blkdev_write_end(struct file *file, struct address_space *mapping,
> +static int blkdev_write_end(struct kiocb *iocb, struct address_space *mapping,
>  		loff_t pos, unsigned len, unsigned copied, struct folio *folio,
>  		void *fsdata)
>  {
>  	int ret;
> -	ret = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
> +	ret = block_write_end(iocb->ki_filp, mapping, pos, len, copied, folio, fsdata);

... huh.  I thought block_write_end() had to have the same prototype as
->write_end because it was used by some filesystems as the ->write_end.
I see that's not true (any more?).  Maybe I was confused with
generic_write_end().  Anyway, block_write_end() doesn't use it's file
argument, and never will, so we can just remove it.

> +++ b/include/linux/fs.h
> @@ -446,10 +446,10 @@ struct address_space_operations {
>  
>  	void (*readahead)(struct readahead_control *);
>  
> -	int (*write_begin)(struct file *, struct address_space *mapping,
> +	int (*write_begin)(struct kiocb *, struct address_space *mapping,
>  				loff_t pos, unsigned len,
>  				struct folio **foliop, void **fsdata);
> -	int (*write_end)(struct file *, struct address_space *mapping,
> +	int (*write_end)(struct kiocb *, struct address_space *mapping,
>  				loff_t pos, unsigned len, unsigned copied,
>  				struct folio *folio, void *fsdata);

Should we make this a 'const struct kiocb *'?  I don't see a need for
filesystems to be allowed to modify the kiocb in future, but perhaps
other people have different opinions.

