Return-Path: <linux-fsdevel+bounces-37521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2471C9F3A6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8D416A8B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD71CEEB0;
	Mon, 16 Dec 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV2LGe8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AEE51C5A;
	Mon, 16 Dec 2024 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379555; cv=none; b=cONa9ZogmA+UJvMrVIf0U+K8voNhm9YlYLQiUYhajm4/jgSjiFOcrg4pSs7hFHy7GcM8hhc00ub+4WEy7ZYufK5CM6kMvtRd5kWBTICBlMjWHShK//4Xnwvo8E7a8C5EkCYXFM8uhIeKhv3JXF/ow3VPXSkS6rUuLoJIMQMjG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379555; c=relaxed/simple;
	bh=35Co1S/1Poie0EARm6OXu1nE4eBJSWFsXTiavSp7hyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAttfAbHLkwYyFN9Vx/TsjWOUCr+IKoohSvEV6U/gvmXpt0viuX8eu1qBpsSSp82iNl+QD+NtFyX31liTPzBHeFIJEzHJBrIj7RMQNuLJylPFHwptWEzKMCxUJ7Gaxn2Ak2zxEPcAtRmI1b5Ia959SsI0RhOCKyia0zmjRlhsX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV2LGe8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6A7C4CED4;
	Mon, 16 Dec 2024 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379554;
	bh=35Co1S/1Poie0EARm6OXu1nE4eBJSWFsXTiavSp7hyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jV2LGe8WJFr6mlDlQPEUpEKIp0jPi4IN6oEbGlUsGeER8moYRXa2b9GqRXk4LgVHl
	 D6sD8L3/veVwSaAjLsB0ik4hyQ6YEPvs5TIaNvQqbF6bmhrQhyjo39MGHa7TIcy8Sa
	 tRjX/k75JwXH9++raMFiJscOzue6PJB3C2v69A1W6WADCTFoxUL/TSRHoJlTjJ4tcr
	 +6ijciQrzn5BUPhWexsZGmc21u8BdW6jBj9HC7R+u1Lax9h7l0G8Co7ngkK0Fjmrc+
	 4ENcMRZWGFH0Rk87Do4uOGbQCREgcA71YRhEYqHS3uNVkshtRU6RyBEWsGTRJzEaGc
	 OPBxiq1iJHigg==
Date: Mon, 16 Dec 2024 12:05:52 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hch@lst.de, hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [RFC v2 02/11] fs/buffer: add a for_each_bh() for
 block_read_full_folio()
Message-ID: <Z2CIIArEF_NekLxs@bombadil.infradead.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-3-mcgrof@kernel.org>
 <Z10DbUnisJJMl0zW@casper.infradead.org>
 <Z2B36lejOx434hAR@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2B36lejOx434hAR@bombadil.infradead.org>

On Mon, Dec 16, 2024 at 10:56:44AM -0800, Luis Chamberlain wrote:
> On Sat, Dec 14, 2024 at 04:02:53AM +0000, Matthew Wilcox wrote:
> > On Fri, Dec 13, 2024 at 07:10:40PM -0800, Luis Chamberlain wrote:
> > > -	do {
> > > +	for_each_bh(bh, head) {
> > >  		if (buffer_uptodate(bh))
> > >  			continue;
> > >  
> > > @@ -2454,7 +2464,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
> > >  				continue;
> > >  		}
> > >  		arr[nr++] = bh;
> > > -	} while (i++, iblock++, (bh = bh->b_this_page) != head);
> > > +		i++;
> > > +		iblock++;
> > > +	}
> > 
> > This is non-equivalent.  That 'continue' you can see would increment i
> > and iblock.  Now it doesn't.
> 
> Thanks, not sure how I missed that! With that fix in place I ran a full
> baseline against ext4 and all XFS profiles.
> 
> For ext4 the new failures I see are just:
> 
>   * generic/044
>   * generic/045
>   * generic/046

Oh my, these all fail on vanilla v6.12-rc2 so its not the code which is
at fault.

 Luis

