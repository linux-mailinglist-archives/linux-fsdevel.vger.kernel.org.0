Return-Path: <linux-fsdevel+bounces-19183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84E8C113B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629D41F2344C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3202A1C2;
	Thu,  9 May 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK9xR7Pg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACEE15AF1;
	Thu,  9 May 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265172; cv=none; b=Q+Ne1vLR52dNiFrFo4Uenc6wADen19WtBQNefe29JMd+y0VDrFUTR4kmb+TqiYSRqFg3ED9U9t6f/qkordTu0CjRI/uapYvZBv9J+Uk64tYSUQfmlJ2JlMiHmb25Mf9pGGbFVYMiquGRuEKj72cbNsL5NdPPYYHv2xyUiND+H84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265172; c=relaxed/simple;
	bh=yz+YFbGtkYLL4EGdTd6mZCOqxppkuLvjVZ6QPxvtmJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqHpySUMW37PC24K6eiPd8oqpbj9gqYgA1y9HNzkqhPpHue6DqP5CitfrplS8eS8ZaVaYYuCUZloN86coHl1+6gtoLwJ3xtZCRFm+po2KMLSqoRp+f0vCZ4kZCe4r6H2GfTCiK6liiDJRmT8CrayluzXUoRKOaOxBnp34TKcP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK9xR7Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9ADC116B1;
	Thu,  9 May 2024 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715265171;
	bh=yz+YFbGtkYLL4EGdTd6mZCOqxppkuLvjVZ6QPxvtmJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aK9xR7PgFB5bDXWjchi/PqHuIU+Au6YYRAM+Mc+i7r8mptyatvOtU9H4ymrCRKzmX
	 i1sa0hT0QuCmU3225WaJYaVv4BtoK1vggutyVLg7djL1WBuTjj7+EdyqT0w8Tc5UzV
	 cplECW9fHgxmwKrmNEi7OF5MMXzHdpv7cKYMhiJsoW2PO4MWua9n3g7I0OBw87Wb5o
	 F8TzTC14QhZ5+Il++GiDZP2p48vWsay4RsUHHuXpR3KC08CzL0MY1485d83TBH1R9Q
	 i/piU4TfG71SnOHL6E9uxmyWLBqTeo44jfN62fB9JzQHw0sEkTn7J2oAR8jltBkZ8F
	 NEv6pP91cFwMg==
Date: Thu, 9 May 2024 07:32:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, hch@lst.de,
	willy@infradead.org, mcgrof@kernel.org, akpm@linux-foundation.org,
	brauner@kernel.org, chandan.babu@oracle.com, david@fromorbit.com,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <20240509143250.GF360919@frogsfrogsfrogs>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
 <20240508113949.pwyeavrc2rrwsxw2@quentin>
 <Zjtlep7rySFJFcik@infradead.org>
 <20240509123107.hhi3lzjcn5svejvk@quentin>
 <ZjzFv7cKJcwDRbjQ@infradead.org>
 <20240509125514.2i3a7yo657frjqwq@quentin>
 <ZjzIb-xfFgZ4yg0I@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzIb-xfFgZ4yg0I@infradead.org>

On Thu, May 09, 2024 at 05:58:23AM -0700, Christoph Hellwig wrote:
> On Thu, May 09, 2024 at 12:55:14PM +0000, Pankaj Raghav (Samsung) wrote:
> > We might still fail here during mount. My question is: do we also fail
> > the mount if folio_alloc fails?
> 
> Yes.  Like any other allocation that fails at mount time.

How hard is it to fallback to regular zero-page if you can't allocate
the zero-hugepage?  I think most sysadmins would rather mount with
reduced zeroing performance than get an ENOMEM.

--D

