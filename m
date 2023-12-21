Return-Path: <linux-fsdevel+bounces-6685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC781B5E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9123D1F23E3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E897319C;
	Thu, 21 Dec 2023 12:29:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6256F601;
	Thu, 21 Dec 2023 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD52568B05; Thu, 21 Dec 2023 13:29:10 +0100 (CET)
Date: Thu, 21 Dec 2023 13:29:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] writeback: Add for_each_writeback_folio()
Message-ID: <20231221122910.GF17956@lst.de>
References: <20231218153553.807799-1-hch@lst.de> <20231218153553.807799-16-hch@lst.de> <20231221115149.ke74ddapwb7q6fdz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221115149.ke74ddapwb7q6fdz@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 21, 2023 at 12:51:49PM +0100, Jan Kara wrote:
> On Mon 18-12-23 16:35:51, Christoph Hellwig wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Wrap up the iterator with a nice bit of syntactic sugar.  Now the
> > caller doesn't need to know about wbc->err and can just return error,
> > not knowing that the iterator took care of storing errors correctly.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Not sure if the trick with 'error' variable isn't a bit too clever for us
> ;) We'll see how many bugs it will cause in the future...

It's a bit too much syntactic sugar for my taste, but if we want a magic
for macro I can't really see a good way around it.  I personally wouldn't
mind a version where the writeback_get_folio moves out of
writeback_iter_init and the pattern would look more like:

	writeback_iter_init(mapping, wbc);
	while ((folio = writeback_iter_next(mapping, wbc, folio))) {
		wbc->err = <do something>
	}

	return wbc->err;


