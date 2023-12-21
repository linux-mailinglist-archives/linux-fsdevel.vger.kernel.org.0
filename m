Return-Path: <linux-fsdevel+bounces-6682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C6481B5B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8881285E3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA26EB52;
	Thu, 21 Dec 2023 12:22:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25652206F;
	Thu, 21 Dec 2023 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2393868B05; Thu, 21 Dec 2023 13:22:34 +0100 (CET)
Date: Thu, 21 Dec 2023 13:22:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] writeback: Factor writeback_get_batch() out of
 write_cache_pages()
Message-ID: <20231221122233.GC17956@lst.de>
References: <20231218153553.807799-1-hch@lst.de> <20231218153553.807799-8-hch@lst.de> <20231221111743.sppmjkyah3u4ao6g@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221111743.sppmjkyah3u4ao6g@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 21, 2023 at 12:17:43PM +0100, Jan Kara wrote:
> > +static void writeback_get_batch(struct address_space *mapping,
> > +		struct writeback_control *wbc)
> > +{
> > +	folio_batch_release(&wbc->fbatch);
> > +	cond_resched();
> 
> I'd prefer to have cond_resched() explicitely in the writeback loop instead
> of hidden here in writeback_get_batch() where it logically does not make
> too much sense to me...

Based on the final state after this series, where would you place it?

(That beeing said there is a discussion underway on lkml to maybe
 kill cond_resched entirely as part of sorting out the preemption
 model mess, at that point this would become a moot point anyway)

> >  	} else {
> > -		index = wbc->range_start >> PAGE_SHIFT;
> > +		wbc->index = wbc->range_start >> PAGE_SHIFT;
> >  		end = wbc->range_end >> PAGE_SHIFT;
> >  	}
> 
> Maybe we should have:
> 	end = wbc_end(wbc);
> 
> when we have the helper? But I guess this gets cleaned up in later patches
> anyway so whatever.

Yeah, this end just goes away.  I can convert it here, but that feels
like pointless churn to me.

