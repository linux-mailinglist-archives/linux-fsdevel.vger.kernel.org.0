Return-Path: <linux-fsdevel+bounces-75298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IxoJlaMc2l0xAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:57:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E4774EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 933C73009401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299932D0F0;
	Fri, 23 Jan 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoLJ2J7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDA330640
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180242; cv=none; b=C79Y4ICYabXVgDsGMM4tO7fyWyKOLWbgyYmxiaz3l5tR4tYnb/HZbaqbpaYiW1VzzSWyjkU95pTRFPGnSFEu37chKSpV2j1uy8gSxYDSR0ZBZy+Jep2cMQv4XYymHGCAUyVwF3JoLCUwPeTy54Fkfr956c4cS35CK514Wg0G6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180242; c=relaxed/simple;
	bh=98gfQfTtpuQIK4SRjDriRs29SOaTPxKtPQ4zxBSwmD8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=B9YJTCkXt2aVoera9QsnSfFgV/7arAq+U94DQ9xKiS4urCuEXpsMgC+xaV0JuItKzbEpNJvukBikwXX6vtOg51HZu8y59uSJa+1oS7CkZXxMWKaX+at6AgDp8k3QyYDJpbtM5XbmQe+voVzswMcQNQx73cotOR2lRDiyR3RrRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoLJ2J7s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769180239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9dje+sNIA+yLoiDKbDNtKWUYVXUn9yJ3J50p0rKaA0=;
	b=eoLJ2J7skX1yxSOrQZnYoXA5Q2AwPWeYlP7pqY3d7BcZflShX1K8UaeFyY2W8HcTC5vT6M
	UvSoIb/Ri89GTZoCaZWAOx/O5QK/FMFbqy5IYdYFANFcMjSdbiOm8k7BIZ+sfjQyyESU8O
	N995gH3LmUAU3xpTcj9o1NHYFW/El0c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-zQ3khed6Ng-AjKJiBdeFRg-1; Fri,
 23 Jan 2026 09:57:13 -0500
X-MC-Unique: zQ3khed6Ng-AjKJiBdeFRg-1
X-Mimecast-MFC-AGG-ID: zQ3khed6Ng-AjKJiBdeFRg_1769180232
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C95F18005B6;
	Fri, 23 Jan 2026 14:57:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97B311800999;
	Fri, 23 Jan 2026 14:57:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260123135858.GA24386@lst.de>
References: <20260123135858.GA24386@lst.de> <20260119074425.4005867-4-hch@lst.de> <20260119074425.4005867-1-hch@lst.de> <1754475.1769168237@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Christian Brauner <brauner@kernel.org>,
    "Darrick J. Wong" <djwong@kernel.org>,
    Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
    Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
    linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    Kundan Kumar <kundan.kumar@samsung.com>,
    Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1763224.1769180224.1@warthog.procyon.org.uk>
Date: Fri, 23 Jan 2026 14:57:06 +0000
Message-ID: <1763225.1769180226@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75298-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 733E4774EC
X-Rspamd-Action: no action

Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Jan 23, 2026 at 11:37:17AM +0000, David Howells wrote:
> > Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > +static unsigned int get_contig_folio_len(struct page **pages,
> > > +		unsigned int *num_pages, size_t left, size_t offset)
> > > +{
> > > +	struct folio *folio = page_folio(pages[0]);
> > 
> > You can't do this.  You cannot assume that pages[0] is of folio type.
> > vmsplice() is unfortunately a thing and the page could be a network read
> > buffer.
> 
> Hmm, this just moves around existing code added in commit ed9832bc08db
> ("block: introduce folio awareness and add a bigger size from folio").
> 
> How do we get these network read buffers into either a user address
> space or a (non-bvec) iter passed to O_DIRECT reads/writes?

Splice from TCP socket to pipe, vmsplice from there into process address
space; DIO write() from there I think should do it.

What you might need to do is write page-sized chunks into one end of the TCP
socket and flush it after each one so that vmsplice() sees page-sized chunks
of data.  I'm not sure how well an external connection would work to get
actual transmission buffers.  The problem is that the received packet is
page-aligned, including the network headers (I think), so if you can, say,
send 8K packets, you'd have to try and guess where the page boundaries are as
vmsplice can only work on whole pages.

Can we make vmsplice() just copy data?

> Can we come up with testcase for xfstests or blktests for this?
> 
> How do we find out if a given page is a folio and that we can do this?

That's a question for Willy.

David


