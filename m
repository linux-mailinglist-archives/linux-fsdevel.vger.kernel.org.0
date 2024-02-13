Return-Path: <linux-fsdevel+bounces-11367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B958B85317F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 14:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4917AB250C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496455C34;
	Tue, 13 Feb 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GN4MZxdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD555C03
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830039; cv=none; b=S2q7cSpSLNECmqtQPfrIsi1lBDslJJ3OiS/3LLOqjTK5TkiDJH061cRIdG5OboxpfXKt+ouWyoLXiyOPArmY259lN+rLmnfymlealWWo20JMYh0Azc0j1KS7dnBV6Ab5aQ2Cd2/6l2ZOHAYnYFpun9UPWougY+Tzb4vFUDcT5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830039; c=relaxed/simple;
	bh=7FBpWBbWzBXHIKgl2tq+O44Trivzk8mNpb/YfWXNbx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDCKRik0voNougb7uEQ4lNeQgHML5ZIq0LzMOLzTqmcvIAPiFHWkzN3vT+eKuPzsXg+HQ//EsKXF5FS2jfZeM6Qf/yi+ggb0k2gh41dwQkKda+LR82Zn6BppCBpBO5ZXri7btqtPbMVIW2ayi1aDMr63Y3xhkZR+sYXem2GddZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GN4MZxdr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707830036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrJK7/vivRjYFBV9aMR7eUFZf9Hk2Ry4XzHvi+/bIaM=;
	b=GN4MZxdrM6IJiHXMe6nHiqVXZOoqskVxwbuFqnqTFVQSHMfnDoQlilZidz5SQERS6LiGsp
	5acxtRdEj3SmWbETmafiIPxNmUyLr/fXymUdF+AFKGSF6ww48vQej8GIWVEl5NK5SdKAXx
	gnOCbH/WrDQ51wqRd12K9BIY2BQzR4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Rve8DbtKO0WXuzTho1yCQQ-1; Tue, 13 Feb 2024 08:13:53 -0500
X-MC-Unique: Rve8DbtKO0WXuzTho1yCQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88428101A52A;
	Tue, 13 Feb 2024 13:13:52 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2308F2022AAC;
	Tue, 13 Feb 2024 13:13:52 +0000 (UTC)
Date: Tue, 13 Feb 2024 08:15:29 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] writeback: don't call mapping_set_error in
 writepage_cb
Message-ID: <ZctrcZSvO8rjRwrp@bfoster>
References: <20240212071348.1369918-1-hch@lst.de>
 <20240212071348.1369918-2-hch@lst.de>
 <20240213130713.ysuxaqcwizqwjke2@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213130713.ysuxaqcwizqwjke2@quack3>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Tue, Feb 13, 2024 at 02:07:13PM +0100, Jan Kara wrote:
> On Mon 12-02-24 08:13:35, Christoph Hellwig wrote:
> > writepage_cb is the iterator callback for write_cache_pages, which
> > already tracks all errors and returns them to the caller.  There is
> > no need to additionally cal mapping_set_error which is intended
>                           ^^^ call
> 
> > for contexts where the error can't be directly returned (e.g. the
> > I/O completion handlers).
> > 
> > Remove the mapping_set_error call in writepage_cb which is not only
> > superfluous but also buggy as it can be called with the error argument
> > set to AOP_WRITEPAGE_ACTIVATE, which is not actually an error but a
> > magic return value asking the caller to unlock the page.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Our error handling in writeback has always been ... spotty. E.g.
> block_write_full_page() and iomap_writepage_map() call mapping_set_error()
> as well so this seems to be a common way to do things, OTOH ext4 calls
> mapping_set_error() only on IO completion. I guess the question is how
> an error in ->writepages from background writeback should propagate to
> eventual fsync(2) caller? Because currently such error propagates all the
> way up to writeback_sb_inodes() where it is silently dropped...
> 

A couple related notes from skimming around:

- Things like iomap might make this call in I/O completion paths, but
  then invoke bio completion paths on submission side errors (i.e.
  iomap_submit_ioend() -> bio_endio()).
- __writeback_single_inode() calls filemap_fdatawait() shortly after
  do_writepages(), which basically looks like it relies on mapping error
  state to propagate error within the writeback path.

The call removed by this path only seems to apply to contexts that don't
define their own .writepages, so it's not clear to me how much this
really matters. It just seems like it's a little hard to quantify
whether this is an undesireable change in behavior or not.

Brian

> 								Honza
> 
> > ---
> >  mm/page-writeback.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 3f255534986a2f..62901fa905f01e 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2534,9 +2534,8 @@ static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
> >  		void *data)
> >  {
> >  	struct address_space *mapping = data;
> > -	int ret = mapping->a_ops->writepage(&folio->page, wbc);
> > -	mapping_set_error(mapping, ret);
> > -	return ret;
> > +
> > +	return mapping->a_ops->writepage(&folio->page, wbc);
> >  }
> >  
> >  int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
> > -- 
> > 2.39.2
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 


