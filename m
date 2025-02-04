Return-Path: <linux-fsdevel+bounces-40814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA3A27C93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F2C1665F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E3A219A74;
	Tue,  4 Feb 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQnxeMBj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5B218AA2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699968; cv=none; b=qVaNYULQKI9XYUy/kQYACe5+3W8Gm75qqZkTz5dF5/136UxgbUgbvDNi3+N/ZwUhnnEns/VdoEZ4R9HyJPwRYfe8HQUK8yJn+9v8RcVjxqMuPPNQwfY1Kqkjtr4id/cjf5y6d2RthH/yZL54fn2ZlW7aCeqfsJxT4h2n98ACWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699968; c=relaxed/simple;
	bh=ZNpDW47ZwJRfd5juonz+KhxN5D0K/9JonKH7PFYBTXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrZFCpGZVvr7pjvBn5fWXcllVrhkvMnm/x3ePjTLn+ZwBbo6l5BacpfHNzTBZVvBFvt3t/3s6rJgiRccH6+tlFtmsJ2C4n2zs0r3bLn2MpLJd4mTI5n+0U2zfxIrvPDlpxzq/fNaq8zerGckOYQKVBmlR47jAX+nNP4T5Z5y2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQnxeMBj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738699965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIyppWYvJ3bM7feOJ1OCGhytewxAHTi+RJR0pVnCasU=;
	b=EQnxeMBj8XjNj6khkjCrJSGjtvwI6T5EvFWxXzZNOXypetzZwuyT0gMqgUu8F2AAcGpjDU
	4mIXpQEFzU7DcdPBVmbcMjqw6CCV4P5A4lf2fFL3M7R2Q4UVe2+bdEaNko/nhY7ImLcTLR
	a+uik7t/pqLaucXu9sJVbFTKIGsgUBM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-689QQHlRP9OKopZdsXcnnw-1; Tue,
 04 Feb 2025 15:12:41 -0500
X-MC-Unique: 689QQHlRP9OKopZdsXcnnw-1
X-Mimecast-MFC-AGG-ID: 689QQHlRP9OKopZdsXcnnw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BB3119560BB;
	Tue,  4 Feb 2025 20:12:40 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B5A030001BE;
	Tue,  4 Feb 2025 20:12:38 +0000 (UTC)
Date: Tue, 4 Feb 2025 15:15:04 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 05/10] iomap: lift iter termination logic from
 iomap_iter_advance()
Message-ID: <Z6J1SJCM1wpjxBpL@bfoster>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-6-bfoster@redhat.com>
 <20250204195220.GE21808@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204195220.GE21808@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Feb 04, 2025 at 11:52:20AM -0800, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 08:30:39AM -0500, Brian Foster wrote:
> > The iter termination logic in iomap_iter_advance() is only needed by
> > iomap_iter() to determine whether to proceed with the next mapping
> > for an ongoing operation. The old logic sets ret to 1 and then
> > terminates if the operation is complete (iter->len == 0) or the
> > previous iteration performed no work and the mapping has not been
> > marked stale. The stale check exists to allow operations to
> > retry the current mapping if an inconsistency has been detected.
> > 
> > To further genericize iomap_iter_advance(), lift the termination
> > logic into iomap_iter() and update the former to return success (0)
> > or an error code. iomap_iter() continues on successful advance and
> > non-zero iter->len or otherwise terminates in the no progress (and
> > not stale) or error cases.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/iter.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index fcc8d75dd22f..04bd39ee5d47 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
...
> > @@ -89,8 +84,18 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >  		return iter->processed;
> >  	}
> >  
> > -	/* advance and clear state from the previous iteration */
> > +	/*
> > +	 * Advance the iter and clear state from the previous iteration. Use
> > +	 * iter->len to determine whether to continue onto the next mapping.
> > +	 * Explicitly terminate in the case where the current iter has not
> > +	 * advanced at all (i.e. no work was done for some reason) unless the
> > +	 * mapping has been marked stale and needs to be reprocessed.
> > +	 */
> >  	ret = iomap_iter_advance(iter, iter->processed);
> > +	if (!ret && iter->len > 0)
> > +		ret = 1;
> > +	if (ret > 0 && !iter->processed && !stale)
> 
> How can ret be greater than zero here other than the previous line
> setting it?  I /think/ this is the same as:
> 
> 	if (!ret && iter->len > 0) {
> 		if (iter->processed || stale)
> 			ret = 1;
> 	}
> 
> but then I wonder if it's really necessary to reset the iter state on
> error, or if we've finished the whole thing, or if we've done no work
> and didn't set STALE?  What do you think about:
> 
> 	ret = iomap_iter_advance(...);
> 	if (ret || !iter->len)
> 		return ret;
> 	if (!iter->processed && !stale)
> 		return 0;
> 
> 	iomap_iter_reset_iomap(iter);
> 	ret = ops->iomap_begin(...);
> 

Two thoughts come to mind...

The first is that I'm really trying to be as incremental as possible
here to minimize possibility of subtle issues that might come along with
subtle changes (i.e. like when we do or don't reset, etc.). If you
wanted to tack this on as a followon cleanup, I'd have no issue with it
in general. But that leads to...

The second is that I have a followup series to convert the rest of the
iomap ops to use iter_advance(), after which the iomap_iter() advance in
the logic above goes away. So it might be best to defer this sort of
reset and continuation logic cleanup to after that..

Brian

> --D
> 
> > +		ret = 0;
> >  	iomap_iter_reset_iomap(iter);
> >  	if (ret <= 0)
> >  		return ret;
> > -- 
> > 2.48.1
> > 
> > 
> 


