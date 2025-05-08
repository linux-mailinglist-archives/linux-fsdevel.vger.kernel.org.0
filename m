Return-Path: <linux-fsdevel+bounces-48487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A044AAFD01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 16:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5DD9831B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC626FA6C;
	Thu,  8 May 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Of7rTody"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180E253345
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714446; cv=none; b=Gih3O60ry8hnnMjS9MKwobf+D2cNO0ux34CIUVGZukLff5Rgrft6EpSD3GRaNZzx2HBMoEYz/Wps7K8qG9UmJbLLs89ae7Hr8cmFmlD5gdbyQpZmQOpPqcFdhA+PQ0gI+tImkbiGXRUa1jRIYV5cyddXByN3vXYdLkTVYCWv1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714446; c=relaxed/simple;
	bh=4VdkAhN8QPsDukJt4DKfrwybBh1kK+xP9pgLPPG3Q/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgvQAeLlMQ7ubGbYxXxcYEQlqDCe1e8fHYBKbvm31iCFjovniHasrOgp6PWCtFpY+gnegOwKswlK9xyEqyuvHiIV9QXPjpI5YBNz3S2jCEH2zveUZTXglRb+jIvhmyJSVj+kRSONd16Od/tsHYHCAJuz/NmmNvnoaqMXYwYlKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Of7rTody; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746714443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfU0mKrumgdVhEEH8UkW60t9kq177gr+ZNnonkg+V8E=;
	b=Of7rTodydr9GABZ7o2TkUuSKUb3zr/AIgzGIYTwHcaH7Bz6rZvz0VpxB52qQ/nLuD5EtpR
	RXkgulrz09wYgKgbw4vgTsFE+jfIZ3jAa4+uY2hO20hs9Bb/HDyM4FJl7aWo5SSTMeN7d7
	7Es0V/OHimmLipXUvlPBXcHNfqiZXdA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-N939wij2MQOSOdtxCwDYUw-1; Thu,
 08 May 2025 10:27:22 -0400
X-MC-Unique: N939wij2MQOSOdtxCwDYUw-1
X-Mimecast-MFC-AGG-ID: N939wij2MQOSOdtxCwDYUw_1746714440
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE3091955BC1;
	Thu,  8 May 2025 14:27:20 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.112])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 054A619560B3;
	Thu,  8 May 2025 14:27:18 +0000 (UTC)
Date: Thu, 8 May 2025 10:30:30 -0400
From: Brian Foster <bfoster@redhat.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [RFC] gfs2: Do not call iomap_zero_range beyond eof
Message-ID: <aBzABse9b6vF_LTv@bfoster>
References: <20250508133427.3799322-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508133427.3799322-1-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, May 08, 2025 at 03:34:27PM +0200, Andreas Gruenbacher wrote:
> Since commit eb65540aa9fc ("iomap: warn on zero range of a post-eof
> folio"), iomap_zero_range() warns when asked to zero a folio beyond eof.
> The warning triggers on the following code path:
> 
>   gfs2_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
>     __gfs2_punch_hole()
>       gfs2_block_zero_range()
>         iomap_zero_range()
> 
> So far, gfs2 is just zeroing out partial pages at the beginning and end
> of the range, whether beyond eof or not.  The data beyond eof is already
> expected to be all zeroes, though.  Truncate the range passed to
> iomap_zero_range().
> 
> As an alternative approach, we could also implicitly truncate the range
> inside iomap_zero_range() instead of issuing a warning.  Any thoughts?
> 

Thanks Andreas. The more I think about this the more it seems like
lifting this logic into iomap is a reasonable compromise between just
dropping the warning and forcing individual filesystems to work around
it. The original intent of the warning was to have something to catch
subtle bad behavior since zero range did update i_size for so long.

OTOH I think it's reasonable to argue that we shouldn't need to warn in
situations where we could just enforce correct behavior. Also, I believe
we introduced something similar to avoid post-eof weirdness wrt unshare
range [1], so precedent exists.

I'm interested if others have opinions on the iomap side.. (though as I
write this it looks like hch sits on the side of not tweaking iomap).

Brian

[1] a311a08a4237 ("iomap: constrain the file range passed to iomap_file_unshare")

> Thanks,
> Andreas
> 
> --
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index b81984def58e..d9a4309cd414 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -1301,6 +1301,10 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from,
>  				 unsigned int length)
>  {
>  	BUG_ON(current->journal_info);
> +	if (from > inode->i_size)
> +		return 0;
> +	if (from + length > inode->i_size)
> +		length = inode->i_size - from;
>  	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
>  			NULL);
>  }
> 


