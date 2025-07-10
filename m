Return-Path: <linux-fsdevel+bounces-54444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB79AFFBF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BF44E7114
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5928C025;
	Thu, 10 Jul 2025 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0rdLHvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907F28983F;
	Thu, 10 Jul 2025 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135276; cv=none; b=a38cki5efUO8fCG0FU5H5TlkzH1IcXLXSgoZCiuFy9ZCBS15ZZUIfnGOLc0RFtLsu6zCN+Bja4a8fCOcIwgTtfJotxE/ApC4Sw1i/l/nHINpNcHDEVbJQndIHrfJBYvk//ck1VuY9hTW0yAadTI6RZxVqLZ48gMcHIs288qED1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135276; c=relaxed/simple;
	bh=Uf2bKkveCd5eeYTIYxiJBJQrt9uh9wn7rGVqPe+eAQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcOuwr5pYOhNoQbyr02UWxicC7ofwkkZxqp6zwZzfFyGdjfgrxdgSwQEWER//Suv6Zr6DZs2L3gJZMkAVbSFACkrJNnetU+aJqMgkE6tfX2GP0ukCeuMIrJlik8x5j1OC0vHfNvP/qVeKXBOpzilLQFGokofl7M6Q14JFyMghKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l0rdLHvS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AJpJ7CHfROH+35o2twlxL0uolXlA5ZgQUcP1WJNCmfw=; b=l0rdLHvSj8mPHA/M6NJjtoeqEZ
	HL47DtEGcn6xNC4Ly08/V+oJYgC4V84kLlwFgwKPd6cS0HU9n0haUiO9+eww/Fh0rRDnuoKQoX5s2
	LangJNsBPEC51RKRX6HuJAkwTpvh4z+W7MPMcFvYdxawwCQkwlFonOxfpcMTEt2qXJOihPgPk3HGN
	x9Vh5DlX2taCyr0rc5THuIolRXXPurch77quBXqIXJCyJHVl3BUjUDZovAliFpHXCSwc09RkN+evT
	Nr2UaXnLjNwKFj5JC698Hnsk8KJ10SfyLXXNhLcYXA0KwqAfx7ALKGVHqMIMwwxrYZOgtJqz4VIdM
	Fs4ZbI/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZmQL-0000000B8Rp-1YiR;
	Thu, 10 Jul 2025 08:14:33 +0000
Date: Thu, 10 Jul 2025 01:14:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, ltp@lists.linux.it,
	dan.carpenter@linaro.org, benjamin.copeland@linaro.org,
	rbm@suse.com, Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <aG92abpCeyML01E1@infradead.org>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 10, 2025 at 10:00:48AM +0200, Christian Brauner wrote:
> +       switch (_IOC_NR(cmd)) {
> +       case _IOC_NR(FS_IOC_GETLBMD_CAP):
> +               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
> +                       break;
> +               if (_IOC_SIZE(cmd) > PAGE_SIZE)
> +                       break;
> +               return blk_get_meta_cap(bdev, cmd, argp);
> +       }

Yikes.  I really don't get why we're trying change the way how ioctls
worked forever.  We can and usually do use the size based macro already.
And when we introduce a new size (which should happen rarely), we add a
new entry to the switch using the normal _IO* macros, and either
rename the struct, or use offsetofend in the _IO* entry for the old one.

Just in XFS which I remember in detail we've done that to extend
structures in backwards compatible ways multiple times.

