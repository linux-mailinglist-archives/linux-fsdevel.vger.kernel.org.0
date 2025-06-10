Return-Path: <linux-fsdevel+bounces-51157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15F8AD35C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 14:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037BD3B85C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6328ECD3;
	Tue, 10 Jun 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaAotfFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3028ECDB
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557658; cv=none; b=k0aN11vyZ9wvCR4Oj15EpXV5E22tvwRQ6am2LwV+PR2DdJE+64jNU5y42dv6a6HMZ+dCdY5oWSmRuVh/2t4EAicVIAT/js9vpMetv1Lkt3hwX1TxfBY6DN/Bbsuuf015/wx6j/OE7F5PNsNpIMz6LwAiQUmNg/5GuH903A/G7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557658; c=relaxed/simple;
	bh=V+guWLZ69vqifZlQbMS6D4nJY9iyL6sjXj+IsHTPcxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm6JIPD60UqTmlxxehQxY4hdBhE64n6Fg64Pqq7cZVzQuvWax70LT9eiofZId9nAyKocvX7ZN9/vrjMLqxjop0Me7uwt4W+xFl6aqkF3wr0vOcynpooIe0lKzX2fWqfNyqNWfJruQZWMhEX3FkbPIHCQgTzBn0TgJdxbwBiWmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaAotfFW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749557656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7M2KXkYboJQV8WZTt83MZ+x4H8up8eCNZ6BOoJSfhd8=;
	b=RaAotfFWSnmEGRFoZCBgql4hJke1Yv2J9fZllgT5EHfD+xAya4Hl7KlLRZqE23RJeKch5A
	GS2n1V7ZhyLfsyHGdsl1oFoChnjPzhzaw/hWeaG8F65+uqnsZ+iDOy9jq46RuePZS4ca2M
	n/rsTORk+MHy0yYtjze7ExnlpKPYOeY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-Uc6vkY5tOoe8unqS1MkvTw-1; Tue,
 10 Jun 2025 08:14:12 -0400
X-MC-Unique: Uc6vkY5tOoe8unqS1MkvTw-1
X-Mimecast-MFC-AGG-ID: Uc6vkY5tOoe8unqS1MkvTw_1749557651
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 636CD1956080;
	Tue, 10 Jun 2025 12:14:11 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A06F19560A3;
	Tue, 10 Jun 2025 12:14:10 +0000 (UTC)
Date: Tue, 10 Jun 2025 08:17:45 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/7] filemap: add helper to look up dirty folios in a
 range
Message-ID: <aEgiaXohtmidV3T9@bfoster>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-3-bfoster@redhat.com>
 <20250609154802.GB6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154802.GB6156@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jun 09, 2025 at 08:48:02AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 05, 2025 at 01:33:52PM -0400, Brian Foster wrote:
> > Add a new filemap_get_folios_dirty() helper to look up existing dirty
> > folios in a range and add them to a folio_batch. This is to support
> > optimization of certain iomap operations that only care about dirty
> > folios in a target range. For example, zero range only zeroes the subset
> > of dirty pages over unwritten mappings, seek hole/data may use similar
> > logic in the future, etc.
> > 
> > Note that the helper is intended for use under internal fs locks.
> > Therefore it trylocks folios in order to filter out clean folios.
> > This loosely follows the logic from filemap_range_has_writeback().
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> You might want to cc willy directly on this one... 

Er yeah, I'll do that for v2.

> > ---
> >  include/linux/pagemap.h |  2 ++
> >  mm/filemap.c            | 42 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> > 
...
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index bada249b9fb7..d28e984cdfd4 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2334,6 +2334,48 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
> >  }
> >  EXPORT_SYMBOL(filemap_get_folios_tag);
> >  
> > +unsigned filemap_get_folios_dirty(struct address_space *mapping, pgoff_t *start,
> > +			pgoff_t end, struct folio_batch *fbatch)
> 
> This ought to have a comment explaining what the function does.
> It identifies every folio starting at @*start and ending before @end
> that is dirty and tries to assign them to @fbatch, right?
> 

Yep, or at least every folio that starts before end. I'll add a comment
and incorporate all the followup feedback. Thanks.

Brian

> The code looks reasonable to me; hopefully there aren't some subtleties
> that I'm missing here :P
> 
> > +{
> > +	XA_STATE(xas, &mapping->i_pages, *start);
> > +	struct folio *folio;
> > +
> > +	rcu_read_lock();
> > +	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
> > +		if (xa_is_value(folio))
> > +			continue;
> > +		if (folio_trylock(folio)) {
> > +			bool clean = !folio_test_dirty(folio) &&
> > +				     !folio_test_writeback(folio);
> > +			folio_unlock(folio);
> > +			if (clean) {
> > +				folio_put(folio);
> > +				continue;
> > +			}
> > +		}
> > +		if (!folio_batch_add(fbatch, folio)) {
> > +			unsigned long nr = folio_nr_pages(folio);
> > +			*start = folio->index + nr;
> > +			goto out;
> > +		}
> > +	}
> > +	/*
> > +	 * We come here when there is no page beyond @end. We take care to not
> 
> ...no folio beyond @end?
> 
> --D
> 
> > +	 * overflow the index @start as it confuses some of the callers. This
> > +	 * breaks the iteration when there is a page at index -1 but that is
> > +	 * already broke anyway.
> > +	 */
> > +	if (end == (pgoff_t)-1)
> > +		*start = (pgoff_t)-1;
> > +	else
> > +		*start = end + 1;
> > +out:
> > +	rcu_read_unlock();
> > +
> > +	return folio_batch_count(fbatch);
> > +}
> > +EXPORT_SYMBOL(filemap_get_folios_dirty);
> > +
> >  /*
> >   * CD/DVDs are error prone. When a medium error occurs, the driver may fail
> >   * a _large_ part of the i/o request. Imagine the worst scenario:
> > -- 
> > 2.49.0
> > 
> > 
> 


