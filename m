Return-Path: <linux-fsdevel+bounces-76083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePpQAE3ugGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:34:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E39D0374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F613013D66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F842F0C6B;
	Mon,  2 Feb 2026 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QX6zh5En"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A442EBB8C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057264; cv=none; b=PrlFzIvH+b1VXr9U7UgxuWMOhfVRGArahCB7k0bjBsYN0NyBQr7BqyZjHi9XavYOgoF8jwJSp3vH25Z3OmSARrx9Brztncbn00i7571P2SMS0G3S77t5wbUmK2VtEdr7uzz5jsY4POacID0eKyDkWgIug56xRmUkhu13gCDPzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057264; c=relaxed/simple;
	bh=st2gunRIFmQ1p7JJtTsaRS1xasxYmMpqzB/ZRL8fUYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZLYSVuCY9JmwXhyUlyYzgB0phfgvBdPH1wa+/nAU0YjXZFtw/GWmd0YLxRMeLEXG9qUlraxWP8Rc/47LVLY+kRrStQt04RTZT0xnAK/O3Bkd8bwgTWqIfXUoQ+15PWW2QJL9lEvXJNzBniDE3OOgpmEIkPO/djHTrxfY+UsEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QX6zh5En; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770057262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OWPieg0Bvkioyg2EeqBdekXZF/DTC3okjM25F8ZVq1w=;
	b=QX6zh5EnFDYpp67FOEj/pw3mjA9tuLryveWn70A+eqnUcCpNh7LGQjKWVPIDOX8gq9xEQN
	/vOaQ8eeNOZJ0A7+2p3BWKBQObdFvW0zwv8FgIew+oDgR5VENdeVc/pAjet3H5ppE8Qs5n
	yC9RAD0tXEQZGI+YhuBEVPBr7DqBrqY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-1sc3xcvPNBi-w4c044jdtA-1; Mon,
 02 Feb 2026 13:34:18 -0500
X-MC-Unique: 1sc3xcvPNBi-w4c044jdtA-1
X-Mimecast-MFC-AGG-ID: 1sc3xcvPNBi-w4c044jdtA_1770057257
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D18551954204;
	Mon,  2 Feb 2026 18:34:16 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.110])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B90631800577;
	Mon,  2 Feb 2026 18:34:13 +0000 (UTC)
Date: Mon, 2 Feb 2026 13:34:11 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Piyush Patle <piyushpatle228@gmail.com>, brauner@kernel.org,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: handle iterator position advancing beyond current
 mapping
Message-ID: <aYDuI3EqwCmnc9uq@bfoster>
References: <20260202130044.567989-1-piyushpatle228@gmail.com>
 <aYC5Utav-rTKigTw@infradead.org>
 <aYDES-sGwCEr80Z3@casper.infradead.org>
 <aYDLXHqHmkdTL-M0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDLXHqHmkdTL-M0@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-76083-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,bd5ca596a01d01bfa083];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52E39D0374
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 08:05:48AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 03:35:39PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 02, 2026 at 06:48:50AM -0800, Christoph Hellwig wrote:
> > > On Mon, Feb 02, 2026 at 06:30:44PM +0530, Piyush Patle wrote:
> > > > Closes: https://syzkaller.appspot.com/bug?id=bd5ca596a01d01bfa083
> > > 
> > > This link doesn't work.  And the commit log has zero details of what's
> > > happening either.
> > 
> > Looks like this one:
> > 
> > https://syzkaller.appspot.com/bug?extid=bd5ca596a01d01bfa083
> > 
> > but there's no reproducer.  Looks like it's through the blockdev rather
> > than a filesystem being involved.
> 
> Let's wait for a reproducer.  The fix looks incorrect for anything I
> could think of, so I'd rather fix a real bug.  Given that lack of
> reproducer I'm also not confident that it fixes anything.  The fact
> that the Fixes tag points to a merge commit doesn't really increase
> the trust I have in it either.
> 
> 

+1 to this, FWIW. I've had that syzbot report marked in my inbox
expecting (hoping..) it would eventually spit out a reproducer to help
better characterize the cause.

This patch just appears to copy the warning check and force a lookup
cycle before we trigger it, which I don't think is doing us any favors.
At minimum we should have an understanding of precisely how this
happens.

Brian


