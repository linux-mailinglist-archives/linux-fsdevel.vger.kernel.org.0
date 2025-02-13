Return-Path: <linux-fsdevel+bounces-41631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC24A33850
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 07:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F087A144F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 06:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF0207DFB;
	Thu, 13 Feb 2025 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gjeAW4jD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7EEADC;
	Thu, 13 Feb 2025 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429684; cv=none; b=Mu5lkjW6KRcj79ZA9LXh7SEwMUbTQ4hA/vKSuxZz6p0QHfetXrQojHA8vpVvEFUTg1ma22Q+jCYei+ddk57l15GWFXcPZ5luDIZJKDDBo+EvxnhI7bozFWP8neV5Xk4ksYKN2ad8ZbtGm91WwQhV9NbMScaxojw3BW9ZY0r0d14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429684; c=relaxed/simple;
	bh=aFJmTOEVeYkwsMk5SFEBB2yB+91cI39yTdGtF0ORkhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6393EF5hpouqSMvK96aKAH3TcsqlXo0twDmS6EOH+x4FyEofoREkLhUz4uBW5pcxbozynBU+iM4i0bttXjo6qNmkYH5g9pQN61dqUgVwpVzgXN2ZxIlJrXy2RRYuM5xr/wlp3J6EvC2L/R05eJMt7qssIzrO2Zpoo3ZczfqOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gjeAW4jD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oSBlCHpYhtriMEF2N1nWb3UUjkUJK+MQ76feOH3ferg=; b=gjeAW4jDwIuVudltAXaL9nRei/
	ommBnXBYqd74+YaUl2xy6O++rhFvVlAFivtGjwhB7G5okkNxlUsz8dQGKuQ0dsctu0bN3W6VB6juX
	Bk6baMQoJh5dU6QmJaEuVEgZ4AiIP1ddMK3aAezsjoFpRRQmdKpf/2od8Tc453YPOQBNQpIC0eH5+
	0fGD0FaIPiqcuNyxC93xghuUJ8+Ps2wMHjhF5sxnlAovEkMdUNbiylzd2x3DxgpKCA3hIqcGRb+Cm
	G8URZMhrIyTtWfBJPeubllLAWhsjXOG0YLyWa6CV9bGrvq9rZ8AJDKMQnxgpTzTcMyEv+uX/vOLiG
	HT/tY5QQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT7S-0000000A108-3ldQ;
	Thu, 13 Feb 2025 06:54:42 +0000
Date: Wed, 12 Feb 2025 22:54:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 03/10] iomap: convert misc simple ops to incremental
 advance
Message-ID: <Z62XMuDSLOhF2DD7@infradead.org>
References: <20250212135712.506987-1-bfoster@redhat.com>
 <20250212135712.506987-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212135712.506987-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	u64 length = iomap_length(iter);
> +
>  	switch (iomap->type) {
>  	case IOMAP_MAPPED:
>  	case IOMAP_UNWRITTEN:
> @@ -132,7 +134,8 @@ static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
>  			return error;
>  		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
>  	}
> -	return iomap_length(iter);
> +
> +	return iomap_iter_advance(iter, &length);

I notice that for many of these callers passing in the length as in/out
argument isn't all that great.  Not sure that's worth changing now (or
adding another helper?).  The conversion itself looks good.

