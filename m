Return-Path: <linux-fsdevel+bounces-37562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE9F9F3CFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE1A1882C5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E41D5CE7;
	Mon, 16 Dec 2024 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovHyIWwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319051D434F;
	Mon, 16 Dec 2024 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385590; cv=none; b=dNmc02bu65piITxFL7wrawxaW9AZYzP1isR/e8/sbSWgMS8sF3Dxnbc8QXg8izzQxDU/brScMZxTlo2siWvsEvBJju1vFcW8paYLK3kP3/TM8gZl2TstR6cSdxLDcuEl9em9+CV1zyKKXAwISsl+84oXl5rso5LsX298e/Q3yFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385590; c=relaxed/simple;
	bh=zVoa/3Oc5FzS+EfNO9uf7upvkjncYUhVe8FspYxQz0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKGW2fDlLhyjswkfSklGcg6ii7M5n6YIwBIEmGyLIDIgic3iaX637pPRQneDDhVns0utIaPY0mUtev4t0Q/3T34Jvv8wvXBhcyQOyA4QHr8JQEBriilolmP1xUQjDInma9L+gWccZ11TXLVNoU/0e8xIIe6XafcsR0/FnM4BooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovHyIWwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D196C4CED0;
	Mon, 16 Dec 2024 21:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734385589;
	bh=zVoa/3Oc5FzS+EfNO9uf7upvkjncYUhVe8FspYxQz0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovHyIWwLQVRPv9DaeMkNyocG87kBANi07qRqLesaOz+3eArdoGEUnfr25PEYT4qfr
	 NeOkL47ZrQfAKxt2gvH0rTccMi3cyne/v8H4zs9hFo1vPKIpPBrkr9nhDSsogFmFTW
	 HFqdFJdAxFB+9Qm/dKqzpaogSOs7W69TVNTqUmaxU723xAnviAj70dIKvPxEKC4K2c
	 1+ie53f4tgO95INdj1LngPqapMxppyL5//8Gb7ePQZtr+ZcNBg8kE9LSWTxuEAxtJv
	 rUOfGMGg/sj7MRwXSi60gSdkldoemEHoSJuQ4EQU9/SLKwmfIh57dpJStL+mIuWiMf
	 +iLYqg3qh1SDw==
Date: Mon, 16 Dec 2024 13:46:27 -0800
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
Message-ID: <Z2Cfs4-hWIauE0ce@bombadil.infradead.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-3-mcgrof@kernel.org>
 <Z10DbUnisJJMl0zW@casper.infradead.org>
 <Z2B36lejOx434hAR@bombadil.infradead.org>
 <Z2CIIArEF_NekLxs@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2CIIArEF_NekLxs@bombadil.infradead.org>

On Mon, Dec 16, 2024 at 12:05:54PM -0800, Luis Chamberlain wrote:
> On Mon, Dec 16, 2024 at 10:56:44AM -0800, Luis Chamberlain wrote:
> > On Sat, Dec 14, 2024 at 04:02:53AM +0000, Matthew Wilcox wrote:
> > > On Fri, Dec 13, 2024 at 07:10:40PM -0800, Luis Chamberlain wrote:
> > > > -	do {
> > > > +	for_each_bh(bh, head) {
> > > >  		if (buffer_uptodate(bh))
> > > >  			continue;
> > > >  
> > > > @@ -2454,7 +2464,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
> > > >  				continue;
> > > >  		}
> > > >  		arr[nr++] = bh;
> > > > -	} while (i++, iblock++, (bh = bh->b_this_page) != head);
> > > > +		i++;
> > > > +		iblock++;
> > > > +	}
> > > 
> > > This is non-equivalent.  That 'continue' you can see would increment i
> > > and iblock.  Now it doesn't.
> > 
> > Thanks, not sure how I missed that! With that fix in place I ran a full
> > baseline against ext4 and all XFS profiles.
> > 
> > For ext4 the new failures I see are just:
> > 
> >   * generic/044
> >   * generic/045
> >   * generic/046
> 
> Oh my, these all fail on vanilla v6.12-rc2 so its not the code which is
> at fault.

I looked inside my bag of "tribal knowedlge" and found that these are
known to fail because by default ext4 uses mount -o data=ordered mode
in favor of performance instead of the     mount -o data=journal mode.
And I confirm using mount -o data=journal fixes this for both the
baselines v6.13-rc2 and with these patches. In fstets you do that with:

MOUNT_OPTIONS='-o data=journal'

And so these failure are part of the baseline, and so, so far no
regressions are found with ext4 with this patch series.

  Luis

