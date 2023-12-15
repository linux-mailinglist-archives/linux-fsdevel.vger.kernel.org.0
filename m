Return-Path: <linux-fsdevel+bounces-6200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1DD814DA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 17:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485041C23DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2EE3EA7B;
	Fri, 15 Dec 2023 16:54:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C03E49F;
	Fri, 15 Dec 2023 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E8A168B05; Fri, 15 Dec 2023 17:54:20 +0100 (CET)
Date: Fri, 15 Dec 2023 17:54:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 01/11] writeback: Factor out writeback_finish()
Message-ID: <20231215165419.GA3175@lst.de>
References: <20231214132544.376574-1-hch@lst.de> <20231214132544.376574-2-hch@lst.de> <20231215132639.ftis3fhmcqkhrpzo@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215132639.ftis3fhmcqkhrpzo@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 02:26:39PM +0100, Jan Kara wrote:
> > +	/* internal fields used by the ->writepages implementation: */
> > +	struct folio_batch fbatch;
> > +	pgoff_t done_index;
> > +	int err;
> > +	unsigned range_whole:1;		/* entire file */
> 
> Do we really need the range_whole member here? It is trivially derived from
> range_start && range_end and used only in one place in writeback_finish().

Yes, as nothing modified range_start and range_end this should be
easily doable.


