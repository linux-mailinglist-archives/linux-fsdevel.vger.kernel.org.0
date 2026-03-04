Return-Path: <linux-fsdevel+bounces-79374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI89ETM3qGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:44:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6A7200A38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDDDD30168A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC2390C96;
	Wed,  4 Mar 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e26RPWy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD871A681F;
	Wed,  4 Mar 2026 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631854; cv=none; b=BUbRJz9Oz4g0FSMn0gVC+p1Y6Z09NnteaOZNG+2EomsU4qYnqkRFjY0anlIyPHFSESYZcN9z31yRKc85zOGmaF3KZNFgQaUgmJuyfoZ7BiQr1WC2O6bbpLcbAAPh9rYvGfbx1V7f5YfyusyhHHfzOhbjXTcl9gUNHZd1dBPX788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631854; c=relaxed/simple;
	bh=g3INtWbRSN0jgkldjcsYoJmKTSHqyloAGHQW144zmBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuahwIA+THK1QMcX6ETwQdK9ztBW8SeZqGdJV99HBdiM/HIkseqygQWoMpi2S8TkI0DMX13fUcnz+Q/65AifOw7XsPVv7z+CRslfW/oyOT1BwTNDmWZJ4N392+RQmSf0KvGLccT7GvAKu1+zyNC+pcD+Hh5qgTHSmTpnOtYwThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e26RPWy+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xF3nW5vCC+iyBfuzvDC1ioxG3TRa3zdtOomhQDNrMX4=; b=e26RPWy+p372QzL+jnAnKcXN/M
	wiH2eMkftY9mJ4kH7/PqEDDLyQASUDxtKvKcZSJBsI9IapRavsleLku9Je4wUAoAl2On0zT2i710X
	yk25Dcr19xceiZLdFy76P7cxS7b0/cDxSsP9p25uPvGLL2d5K0b1kiNnOVl0VRntIQViwwQ/B47hF
	6Wzhu2fkE29yGMmhLkRrlOlptcw0CxSzXFA8lL7DderxkOUndrseIfKfSz1L5JPgHv6OgjklHpub+
	C9ZsHmyOyq5U+NSxcm+c3OxzDSkcPcBzsLsrZjbkT+Pbx6Uz+vjuzBQz7PhggUbwxiRgViLK665HL
	0tw8wkwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxmWK-0000000HGqK-2Rgh;
	Wed, 04 Mar 2026 13:44:12 +0000
Date: Wed, 4 Mar 2026 05:44:12 -0800
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
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 18/32] fs: Provide operation for fetching
 mapping_metadata_bhs
Message-ID: <aag3LLGJPNAYNeCU@infradead.org>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-50-jack@suse.cz>
 <aagxU5f1AI3y0wrw@infradead.org>
 <4ji4ihp7tzhxr35t2vgnswfskrjnsuo4eys4klblnor2b663pp@x3khuzh7cxhv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ji4ihp7tzhxr35t2vgnswfskrjnsuo4eys4klblnor2b663pp@x3khuzh7cxhv>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: DC6A7200A38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79374-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:38:41PM +0100, Jan Kara wrote:
> I was looking into that. Passing these to sync_mapping_buffers(),
> invalidate_inode_buffers() is easy. Passing to mark_buffer_dirty_inode() is
> relatively tedious but doable. Where it gets difficult are calls like
> bforget() and most importantly try_to_free_buffers() on bdev mapping where
> you currently have no way to get to the mmb struct... We do have
> b_assoc_map pointer in buffer_head which we could switch to point to mmb
> instead but IO error handling on bhs needs to get to the mapping from bh so
> we'd then have to add address_space pointer to mmb for these uses. All in
> all it's doable but I've decided it isn't really worth it.

I guess a backpointer from the bh list to the mapping/inode would solve
all this?  Or am I missing something?


