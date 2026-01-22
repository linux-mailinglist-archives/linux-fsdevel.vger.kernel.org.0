Return-Path: <linux-fsdevel+bounces-75146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IG7LOGAcmlElgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:56:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0766D4B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67E803006795
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1AF3502A0;
	Thu, 22 Jan 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ap9cTWAv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373663876AF
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111771; cv=none; b=PUcbqkoY25AF/PRvG1pyeZyhucx2B1BfEtGZIxoMkScD56ixf+A5ANoRWqDyTEhHMvfdYIxyRAdEXoMg610euFkoGH7S5TdcBl7pbbXTUP2JAzhVYZie6DxKIzm531sBn/hrS+U302NxByZzW7OOSPKFrAjCdNp2m28GX+cZlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111771; c=relaxed/simple;
	bh=E1tS73HuoL6RYJUE0Jh5698DsEQelbvu2AVNoLFA+sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN9sb1R66UtJqPjN+unx4Zk1AW1lL+LcI94+VqaHRVs/cg4mxpxUK8JkNUgqkTcaZ2KNj6VRunc25zGYh4uDLJ04F5CNU0Vu3OMpxNOXS4DgpKB0h49UJ62RquUpkOzMgdi8ru1hWDWHY3Wqae6XXwabWF31uUfjslYtLiad+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ap9cTWAv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qizryI9VzwM+k6LebJ70Nc7dpPI8B6toVtU6C+TxVYk=; b=ap9cTWAvU4/HvybI5IyXtQoQeb
	ZWyPavsuBHNwlxHHCKmn0A+piWWCNgodX6wOJXPP1g1nmvJWVrDPzopMHMDqx6jK9XKY58l0He9Jo
	UmGqzTU7RGx6C4xP//I14LZO+1wVbwJcCOBn8A9NtYxZKGUTRphdZ8j+tELcf2C8cMkyG7MXpKPs8
	3fJGrXnilos+XDCQyZt8ngQXw4Q2gx/q1SQyr/QaMPFoBz6CS21eI0NlF9TehrfJjnK/mZ+p61Zkd
	wXa83/H6cr+dYsrBVjqn1ssIkh4CVC6AMP+1U9t3DCc1sykCDHUFA/aZS7a+Ji+qDoZDr9W01Cufo
	/U3vs59Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj0mg-00000000nAU-1uwT;
	Thu, 22 Jan 2026 19:56:02 +0000
Date: Thu, 22 Jan 2026 19:56:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iomap: fix readahead folio access after
 folio_end_read()
Message-ID: <aXKA0gD0J5r4w925@casper.infradead.org>
References: <20260116200427.1016177-1-joannelkoong@gmail.com>
 <20260116200427.1016177-2-joannelkoong@gmail.com>
 <aXCE7jZ5HdhOktEs@infradead.org>
 <CAJnrk1Zp1gkwP=paJLtHN5S41JNBJar-_W0q7K_1zTULh4TqUw@mail.gmail.com>
 <aXJVlYkGKaHFFH9T@casper.infradead.org>
 <CAJnrk1Z083d_SXB8uk5oerrdyezDY7LqcqKcir9r02GUmRAU6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z083d_SXB8uk5oerrdyezDY7LqcqKcir9r02GUmRAU6g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75146-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,infradead.org:dkim]
X-Rspamd-Queue-Id: 2B0766D4B6
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:50:18AM -0800, Joanne Koong wrote:
> On Thu, Jan 22, 2026 at 8:51 AM Matthew Wilcox <willy@infradead.org> wrote:
> > This is so complicated.  I think you made your life harder by adding the
> > bias to read_bytes_pending.  What if we just rip most of this out ...
> 
> I don't think we can rip this out because when the read starts,
> ifs->read_bytes_pending gets set to the folio size, but if there are
> already some uptodate ranges in the folio, the filesystem IO helper
> will not be reading in the entire folio size, which means we still
> need all this logic to decrement ifs->read_bytes_pending by the bytes
> not read in by the IO helper and to end the folio read.

Well, the patch as-is doesn't work (squinting at it now to see
what I missed ...), but that's not an insurmountable problem.
If we find already-uptodate blocks in the folio, we can just call
iomap_finish_folio_read() for them without starting I/O.  That's very
much a corner case, so we need not try hard for efficiency (eg skipping
the ifs_set_range_uptodate() call).

