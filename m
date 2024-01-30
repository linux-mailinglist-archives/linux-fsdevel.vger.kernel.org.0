Return-Path: <linux-fsdevel+bounces-9587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFC6842F21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A702A287B37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3D78B7C;
	Tue, 30 Jan 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ax/R6xWL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBvBemPg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ax/R6xWL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBvBemPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A178666;
	Tue, 30 Jan 2024 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651420; cv=none; b=mqmDmAohh/Cn/huoKUSTw73KrTM5v6dy66qJFJVCx++2BavHDATwQ0Z6m0vL4ZHZOCfxwMU2KrxfjHOipNvT/yXxo9I8UK8nUZGzH1LEXrTHbRJhpcCLT+v4PHg7smXZB6DWHZesPNrT1SqstUEphHkme1wuc8yZaXBJEy+xLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651420; c=relaxed/simple;
	bh=yja1D0oSsszcKToijHhcoFUhArBQ8Uv08OOMC3YY7Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkisovZG2/mvuBR4aTbRGVB0ymg+FkumVQpEExMqlmdaX+AHFveoELhhEmdnfq7rv8VUEburwirveFms1zI4r7LuQyZjsA0uNH3M+i4hZVL7A7GDo9vH5cx//kDqQueXZJXDHnxCUkzEeBdhPbukXGJywIHHnNoSzxZXMf85ntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ax/R6xWL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBvBemPg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ax/R6xWL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBvBemPg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0FB521D08;
	Tue, 30 Jan 2024 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706651416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6BGLwQfV4ZTDY8KhVPKQs2ZMupmIejtEZwLRmq2W/Q=;
	b=ax/R6xWLZiZ+LLZIot0FIJap/K3XocOIEdWYTAgipJY3DbamIVrdTZvBRU6mhXqSxRWyEk
	uiUMzteWYYRhSd+pbEMGzqh4bwVP5nO3XbD+X83ph8lWoHnIfHgNQHYtiRrVL988xpL2BK
	E+SGzRjhfugHG18/12sn6pD4chdu+v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706651416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6BGLwQfV4ZTDY8KhVPKQs2ZMupmIejtEZwLRmq2W/Q=;
	b=wBvBemPgd4P/xuIZtaQYVn+AQruP/OcHBtLyY+zEf5+yRDftUFexYI6LrsGJlhP9dep7VK
	NS8LhV9VcMMwG6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706651416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6BGLwQfV4ZTDY8KhVPKQs2ZMupmIejtEZwLRmq2W/Q=;
	b=ax/R6xWLZiZ+LLZIot0FIJap/K3XocOIEdWYTAgipJY3DbamIVrdTZvBRU6mhXqSxRWyEk
	uiUMzteWYYRhSd+pbEMGzqh4bwVP5nO3XbD+X83ph8lWoHnIfHgNQHYtiRrVL988xpL2BK
	E+SGzRjhfugHG18/12sn6pD4chdu+v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706651416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6BGLwQfV4ZTDY8KhVPKQs2ZMupmIejtEZwLRmq2W/Q=;
	b=wBvBemPgd4P/xuIZtaQYVn+AQruP/OcHBtLyY+zEf5+yRDftUFexYI6LrsGJlhP9dep7VK
	NS8LhV9VcMMwG6Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AE46C13462;
	Tue, 30 Jan 2024 21:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jdmDKhhvuWWxHAAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 30 Jan 2024 21:50:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E75FA07F9; Tue, 30 Jan 2024 22:50:16 +0100 (CET)
Date: Tue, 30 Jan 2024 22:50:16 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <20240130215016.npofgza5nmoxuw6m@quack3>
References: <20240125085758.2393327-1-hch@lst.de>
 <20240125085758.2393327-20-hch@lst.de>
 <20240130104605.2i6mmdncuhwwwfin@quack3>
 <20240130141601.GA31330@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130141601.GA31330@lst.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.23)[72.65%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.17

On Tue 30-01-24 15:16:01, Christoph Hellwig wrote:
> On Tue, Jan 30, 2024 at 11:46:05AM +0100, Jan Kara wrote:
> > Looking at it now I'm thinking whether we would not be better off to
> > completely dump the 'error' argument of writeback_iter() /
> > writeback_iter_next() and just make all .writepage implementations set
> > wbc->err directly. But that means touching all the ~20 writepage
> > implementations we still have...
> 
> Heh.  I actually had an earlier version that looked at wbc->err in
> the ->writepages callers.  But it felt a bit too ugly.

OK.

> > > +		 */
> > > +		if (wbc->sync_mode == WB_SYNC_NONE &&
> > > +		    (wbc->err || wbc->nr_to_write <= 0))
> > > +			goto finish;
> > 
> > I think it would be a bit more comprehensible if we replace the goto with:
> > 			folio_batch_release(&wbc->fbatch);
> > 			if (wbc->range_cyclic)
> > 				mapping->writeback_index =
> > 					folio->index + folio_nr_pages(folio);
> > 			*error = wbc->err;
> > 			return NULL;
> 
> I agree that keeping the logic on when to break and when to set the
> writeback_index is good, but duplicating the batch release and error
> assignment seems a bit suboptimal.  Let me know what you think of the
> alternatіve variant below.

Well, batch release needs to be only here because if writeback_get_folio()
returns NULL, the batch has been already released by it. So what would be
duplicated is only the error assignment. But I'm fine with the version in
the following email and actually somewhat prefer it compared the yet
another variant you've sent.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

