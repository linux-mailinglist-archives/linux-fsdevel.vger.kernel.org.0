Return-Path: <linux-fsdevel+bounces-22956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13D992429F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE24E28710A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0691BC086;
	Tue,  2 Jul 2024 15:42:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16DE14D42C;
	Tue,  2 Jul 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934950; cv=none; b=WXHK57rRqbII7K3kQTfBRsiT9nSh2CUP657n4WKqQ2XGafcv9PN0WciJmi343zbBRoPJLjlzoxCmQmfmmZB0RX/rQr/qVkKHFReHSoPEoc9yrCqEPiJH/iFDGgMfpgf5FYpvHFp0JT9IDXg/7Vm0KgTkdhBPQfKR3oNUJcQ0rfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934950; c=relaxed/simple;
	bh=aV/L68Jag8FiloFG5N6zdozHvLyOLD33i4y1O1Z9cj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2v9QoWzQLTBICmRzfHb2NesaisDR5Yp3xAtVxoENGsJXcgDxtA6nh/3XN+IRwjBHJllmP2lbMqpAvdoqJtEop2zdp2XORRkLGydJDhMoI/KE6uAJ4nP9qTqDTSPfcaQImuwS2R77UzqfJr9+9NZ7OYPOBIO25tB5ycN2JePc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77F3668BFE; Tue,  2 Jul 2024 17:42:16 +0200 (CEST)
Date: Tue, 2 Jul 2024 17:42:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@lst.de>, david@fromorbit.com,
	willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs >
 system page size
Message-ID: <20240702154216.GA1037@lst.de>
References: <20240625114420.719014-1-kernel@pankajraghav.com> <20240625114420.719014-7-kernel@pankajraghav.com> <20240702074203.GA29410@lst.de> <20240702101556.jdi5anyr3v5zngnv@quentin> <20240702120250.GA17373@lst.de> <20240702140123.emt2gz5kbigth2en@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702140123.emt2gz5kbigth2en@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 02, 2024 at 02:01:23PM +0000, Pankaj Raghav (Samsung) wrote:
+static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>                 loff_t pos, unsigned len)
>  {
>         struct inode *inode = file_inode(dio->iocb->ki_filp);
>         struct bio *bio;
>  
> +       if (!len)
> +               return 0;
>         /*
>          * Max block size supported is 64k
>          */
> -       WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);
> +       if (len > ZERO_PAGE_64K_SIZE)
> +               return -EINVAL;

The should probably be both WARN_ON_ONCE in addition to the error
return (and ZERO_PAGE_64K_SIZE really needs to go away..)

> +                       ret = iomap_dio_zero(iter, dio, pos, fs_block_size - pad);

Overly lone line here.

Otherwise this looks good.


