Return-Path: <linux-fsdevel+bounces-22958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11F92435D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 18:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD4E1C21B90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C701BD037;
	Tue,  2 Jul 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="GTze8lmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977D1BD005;
	Tue,  2 Jul 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936826; cv=none; b=ZvA8N6YhSuxMZZ18AEwXMoK3Ql7Blf5DC7qDNcSe3MBlzgZm+9MLq6ahNmjtSpcbnqhWgR80vro8EsRvsmMTYPfKhyZvYVKoQHye3zQ5n/I1yoShjxAG5gzx+OcRDk1UtqBSIcVA7I7KPhAK+xBCwsyaIqpNNr8v301rc4c6Hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936826; c=relaxed/simple;
	bh=1NPPosvEoa7YEfb3YTpwtuFz3L6/xLc2gKJ9TAc2y6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8FcZQrUUi+q5eRYTIBrSXD/XB0b8aP7d949jfW45dzEKIQXP2Sb8zYGjAsFpa7HXTkxNACTwF9Z8EYKOGoqREnIR9NGvO3gnBMUc7xxAW4vVnmD9CDsrhhzhqHe21dlb+B+zL/4qs/ND1QfLPvns3ML6XOsUoHCclR++hF7ygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=GTze8lmn; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WD7Hy1Dr1z9sST;
	Tue,  2 Jul 2024 18:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719936814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oA2Wr6VOMzgFZ0qUaQebVyDCKpm9ZO191hQv44sz+Fs=;
	b=GTze8lmnNNlFCHrThB/+rsNsw9R8Twukx9Hl2tJi+qQCgI2mMsh/6+J0lnPan0kqT7d0XQ
	i6zh7ni3jyRVUt67LghCN9oST2X3rtk+66m9JqtltYVdQ4A9f+kGM85FgdKhBqlVam9dn8
	5bkKl55oquwI57fbnrw0THmxQDb7sn0ckmNc7jXyGg0uakz9HpUoq+D0kBtY/P/0XStobb
	v5xK0h+Oy/fTOPu/AzF4QsQjYimxfrFo6Nogyk4PWMk5ugxFCWbht1K3WYl+JQvIAAUsmJ
	orz3r2CEWAiVfMEHP7Gb5qJ1EH9b59z3ibtoOyBLfzODISoZsBsKbzZh1Snc1A==
Date: Tue, 2 Jul 2024 16:13:29 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@lst.de>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240702161329.i4w6ipfs7jg5rpwx@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
 <20240702074203.GA29410@lst.de>
 <20240702101556.jdi5anyr3v5zngnv@quentin>
 <20240702120250.GA17373@lst.de>
 <20240702140123.emt2gz5kbigth2en@quentin>
 <20240702154216.GA1037@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702154216.GA1037@lst.de>
X-Rspamd-Queue-Id: 4WD7Hy1Dr1z9sST

On Tue, Jul 02, 2024 at 05:42:16PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 02:01:23PM +0000, Pankaj Raghav (Samsung) wrote:
> +static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> >                 loff_t pos, unsigned len)
> >  {
> >         struct inode *inode = file_inode(dio->iocb->ki_filp);
> >         struct bio *bio;
> >  
> > +       if (!len)
> > +               return 0;
> >         /*
> >          * Max block size supported is 64k
> >          */
> > -       WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);
> > +       if (len > ZERO_PAGE_64K_SIZE)
> > +               return -EINVAL;
> 
> The should probably be both WARN_ON_ONCE in addition to the error
> return (and ZERO_PAGE_64K_SIZE really needs to go away..)

Yes, I will rename it to ZERO_PAGE_SZ_64K as you suggested.
> 
> > +                       ret = iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
> 
> Overly lone line here.
> 
> Otherwise this looks good.
> 

