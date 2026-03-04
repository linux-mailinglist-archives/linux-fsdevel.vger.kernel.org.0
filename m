Return-Path: <linux-fsdevel+bounces-79361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CkHLPMzqGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:30:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F13120071A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA934300F7B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D992136BCE5;
	Wed,  4 Mar 2026 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n5QQoG7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DF366DC1;
	Wed,  4 Mar 2026 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630960; cv=none; b=VhdZH7MPQeV8GHE5gNQj22GJJgBlXPLJv7tuqnbjr3FAhZYwzisyaS/IlviS542xhgDU0+5kT4zOEZ/TjtTVmydHU2eCIH43btadkme80MVL8xXrlyUJUyb8hyuH6V0O7T4fh17iCH+c+pBSr/lbqHS8dNWT/sSkvags1Ge34vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630960; c=relaxed/simple;
	bh=IaqFF/isbWyXQxyyhesVMPgi3xKmZ9eiNwwQIv/o3A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPJHc0IPFYy6IfwsOUxdvFXZBd731agKTLF9VeyEPqDPkvaz4+mLIx2CQfZ3u9x7ee9CUps2CFu9WdrHZVS2uEgWzy9wB3DHzi3StGd17QwCIJDd0lLwzqjyvX0NVijE757t5gWPooNvtI+b7VVsp8N64jmoWMU+D72fJUCWMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n5QQoG7N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FPYKHuv7AZ8xAducUFk6uwSA1xo0j120mBJpQUPt22c=; b=n5QQoG7NOMOH6TEptJh/ogSnaC
	3AJmft4GcyF4eyoO13GGaPp+l/ZRDQ4b7Ptiscp2Vaj6Ck0j9oEIW3/JSHXOnhzbSuALODACCxojE
	SsKBb9DpB6I32LEDU1bvZLlShpPWhMuCy8SII00FJjfj+juKVt1A41YvVWRgEqNESR14Y4vhemMol
	GZgSYGXGksYtXcG+66fJpGUbZRCTz0Z4EyEc5gp0CqGvhccqlLF8QHBhyT3Wq/xrTW0nYaPbaHrKB
	sK4gs24MZ//2nDpGlVTl7dZpopefdPsa82gEJR4fpzqLjMrYV0MekOvPO8ZG/JF0/GxIY8ODTtw/h
	hdGC8DRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxmHt-0000000HFO7-32GD;
	Wed, 04 Mar 2026 13:29:17 +0000
Date: Wed, 4 Mar 2026 05:29:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org,
	Ted Tso <tytso@mit.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 21/32] bdev: Drop pointless invalidate_mapping_buffers()
 call
Message-ID: <aagzrZBKdftBb84n@infradead.org>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-53-jack@suse.cz>
 <aabrf4YhPJ2X7n9q@infradead.org>
 <n3anrkzfguzbn5sfwsom472cx4uzejyfemz3d5jm7c4rt3qr6z@ez2cgwzmbfyi>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n3anrkzfguzbn5sfwsom472cx4uzejyfemz3d5jm7c4rt3qr6z@ez2cgwzmbfyi>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 2F13120071A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79361-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,kernel.dk];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:36:29AM +0100, Jan Kara wrote:
> On Tue 03-03-26 06:09:03, Christoph Hellwig wrote:
> > FYI, linux-block only got this patch which is totally messed up.
> > Please always send all patches to every list and person, otherwise
> > you fill peoples inboxes with unreviewable junk.
> 
> Well, I've CCed on the whole series everybody who was non-trivially
> impacted. But there are couple of these trivial "remove effectively dead
> code" patches which stand on their own and a lot of people actually prefer
> to only get individual patches in such cases. So I don't plan on changing
> that but I guess I could have CCed linux-block on the whole series as
> buffer_heads are tangentially related to block layer anyway.

Ccing people or lists on just part of a series is always broken, don't
do that.  If you think something is just a FYI only CC the list to cut
down the spam.


