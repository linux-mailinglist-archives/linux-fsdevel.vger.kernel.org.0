Return-Path: <linux-fsdevel+bounces-51835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA9ADC0F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7063AF391
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4FC238151;
	Tue, 17 Jun 2025 04:42:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA561AAA1E;
	Tue, 17 Jun 2025 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135342; cv=none; b=hEYaWWP3I+CZBEPd3hjwLTt0/e0z4PYdQPkb9+WMd3SXXuzEQQTBEft/aV+oEo/h3XSUZAOdr874L3Y3NRCLgzsBqCUxujv1sINrCPAwa/nFJfiegojgq8+U/feI7w2eMiJ0IHnqmLAa8QJ8UZc1Wu6GaeW9TmKhl+g4tJ2aS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135342; c=relaxed/simple;
	bh=TYLI+FXOM2ZRSFIY4//MnpgO5JrwEz89pltvLKC6mHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw5cFpdZM26bO0L0UCXQAiYau6kyyev+F11ghrqGmegLz4SiA6pkpqhiYfeSEELsWrGZi5WmKOINmAlnEryIUf6b+9Xevt01L7uOl9WRwJUh/8HG58DcM7nRl7SPgBM297f+dnTbxe3VszH48lYHefSLxbLMoLgqf/r96/Oro+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A1DB68D05; Tue, 17 Jun 2025 06:42:16 +0200 (CEST)
Date: Tue, 17 Jun 2025 06:42:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 3/6] iomap: refactor the writeback interface
Message-ID: <20250617044215.GA1824@lst.de>
References: <20250616125957.3139793-1-hch@lst.de> <20250616125957.3139793-4-hch@lst.de> <CAJnrk1bFxRj=CF7g0YswktsPS=2oSBuHX6T3cyvTRRJjuAFyfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1bFxRj=CF7g0YswktsPS=2oSBuHX6T3cyvTRRJjuAFyfw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 03:41:12PM -0700, Joanne Koong wrote:
> I'm not acquainted with the block io / bio layer so please do ignore
> this if my analysis here is wrong, but AFAICT we do still need to add
> this range to the ioend in the case where the mapping is already
> valid? Should this be "return iomap_add_to_ioend(wpc, folio, offset,
> end_pos, len)" instead of return 0?

Yes, absolutely.  That's what the XFS code does, which is the only thing
I tested at this point.  All the other conversion look pretty broken
right now, and I'm glad you spotted this before I'd run into when testing.

> > -       } while (dirty_len && !error);
> > +               ret = wpc->ops->writeback_range(wpc, folio, pos, rlen, end_pos);
> > +               if (WARN_ON_ONCE(ret == 0))
> > +                       return -EIO;
> > +               if (ret < 0)
> > +                       return ret;
> 
> Should we also add a warn check here for if ret > rlen?

Yes, that's a good idea.


