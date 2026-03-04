Return-Path: <linux-fsdevel+bounces-79401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KUgMM9BqGn8rgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:29:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E792017A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05C1830C1E8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D14035CB6F;
	Wed,  4 Mar 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x27lCMff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53A30F932;
	Wed,  4 Mar 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634354; cv=none; b=heqsBz5RNxpift6qiPQnYsOePNZ1JDhaco+SzWyzrzBtG5W5iU+dqDR10AcmtPUj+VBBsulRhx5NT2Ww1ytOnk0Dvf4CHbYQLzp2VybeWsVUACyAOY1cOAJfl0JZxMvnuQCS2OBsX5opOm6pNFcawDwUI4gbyUnbfzwuLjntkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634354; c=relaxed/simple;
	bh=qdY5vaVJURTWs72EyZ8cPNPdS082XZvUtj3CCkb5nGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXG2TnEjhYNcO0dZSzVZiJ4EkoXNE+HGbDNlyiAXjJe1RFoVo8fbmvuX4tY7ly1R6L3KUU7Vn+HMovdt8dZVizXw66xsZTgJQeyYGRx8nYfGuVGIZzRx0wX17ntvJizHQjtMS0kl3lU70ne53YrhjzzQKecRFAdkTOLfSKanviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x27lCMff; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tQK7I2fIPyvq2g9xdz8S+f6AJpFhfFODuiVP1vyE7vM=; b=x27lCMffnHSJWh4uGGnQkxH63X
	o4wIOlq4UCohr2v8YTNWk4Vh1pQMQ5GovXc3B/niDcwWQx+cdDmfkDblQbflWLIs14f5Owl8Ykijj
	ZLgMcyfYJY3DwuxvJbt6axXqAN8aqVD0iYeS2TzFYKkO6ATLbbnS2WiN7R6iBMDznnhiCHQA6kmOY
	QjybGzXwM0xgAGt5nv3EkMn07NNyh37uIozjIM8/OR0ohai+SNA9krqCSDloUkU6fKldmw+ifEwNy
	cQmzlD609M8++/ZnQwZQE3gKC6QQPLC6RDRFxfUD+uC97jQiBC8r+a6Rb3MG0ukbdEV7lrsMCKGnz
	vNy90w9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnAc-0000000HOlV-39DX;
	Wed, 04 Mar 2026 14:25:50 +0000
Date: Wed, 4 Mar 2026 06:25:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 02/17] vfs: Implement a FIEMAP callback
Message-ID: <aahA7rQVf5liFYMv@infradead.org>
References: <aag8fPUDCY_g-_LY@infradead.org>
 <20260304140328.112636-1-dhowells@redhat.com>
 <20260304140328.112636-3-dhowells@redhat.com>
 <114166.1772634114@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114166.1772634114@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 48E792017A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79401-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,infradead.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:21:54PM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Wed, Mar 04, 2026 at 02:03:09PM +0000, David Howells wrote:
> > > Implement a callback in the internal kernel FIEMAP API so that kernel users
> > > can make use of it as the filler function expects to write to userspace.
> > > This allows the FIEMAP data to be captured and parsed.  This is useful for
> > > cachefiles and also potentially for knfsd and ksmbd to implement their
> > > equivalents of FIEMAP remotely rather than using SEEK_DATA/SEEK_HOLE.
> > 
> > Hell no.  FIEMAP is purely a debugging toool and must not get anywhere
> > near a data path.  NAK to all of this.
> 
> So I have to stick with SEEK_DATA/SEEK_HOLE for this?

Yes.  Why do you even want to move away from that?  It's the far
better API.  Of course like all other reporting APIs it still is
racy, but has far less problems than fiemap.


