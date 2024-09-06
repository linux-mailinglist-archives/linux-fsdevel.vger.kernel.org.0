Return-Path: <linux-fsdevel+bounces-28879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6396FBD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F25D1C223B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8B1CEAA5;
	Fri,  6 Sep 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3JX607w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171C1C7B68
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649874; cv=none; b=EzvrfV/9L6XO9AaaoyTCkQDLTN8ZcjyF2OIMAWh2pDz20+UxqaSdf/8yd7ZTbuF+LaW4XjIyJGZiZJqQIx2qmtYuRolMCwOGImkVZgX0uhlPmkLc3+g0UYCJDJAY36N5N7yFy5MYz0EiM2BV5SJbnfhk5/qLdrW4Qi+fkMLcKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649874; c=relaxed/simple;
	bh=ANnz/mI0Ezz/s9YoMUah0W6jtEqdDLddIcG58ey6WQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCeieFvWF5wUgJG4KQ+UDDSzQv6Lkip1wWmbOFLpiX13uXbpT1rJHAFIKQNizslarFByF14IPa1OkQZ37pSI0J6kTmbVDymDK9BHEHeD11QoEulVMJ950gAPOT4dGBkA4L3vZymT53RuQUHkG1BcsEeJHn4pEEp/NHPG8eIXt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3JX607w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725649870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRlOOe+qYTwbhQcnlBfMJYGvzI12GpQGO343uCKlfbQ=;
	b=Z3JX607wZSxPILjcNlW7vM5Q7bc1nsx/KqadS4VFPRvBGBz5tKTRclgkbTOp2onaphp2Ln
	RG4qjKQ8hZ/fwufZF454+mGAFePDxbAj2i2d6fWo9DCptJS5mBcXfofW01u3wL7gnCCEQD
	8zYJ3J7TSuX1I7mRNmmgLK4VzLycxAI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-AHw-okcaOi2VWda7YHlUoQ-1; Fri,
 06 Sep 2024 15:11:04 -0400
X-MC-Unique: AHw-okcaOi2VWda7YHlUoQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EF291955F45;
	Fri,  6 Sep 2024 19:10:58 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.69])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0E5F1955D45;
	Fri,  6 Sep 2024 19:10:55 +0000 (UTC)
Date: Fri, 6 Sep 2024 15:11:58 -0400
From: Brian Foster <bfoster@redhat.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, djwong@kernel.org, david@fromorbit.com,
	hch@lst.de, syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
Message-ID: <ZttT_sHrS5NQPAM9@bfoster>
References: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Sep 05, 2024 at 06:24:24PM +0800, Julian Sun wrote:
> Attempting to unshare extents beyond EOF will trigger
> the need zeroing case, which in turn triggers a warning.
> Therefore, let's skip the unshare process if extents are
> beyond EOF.
> 
> Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
> Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> Inspired-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f420c53d86ac..8898d5ec606f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  	/* don't bother with holes or unwritten extents */
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
>  		return length;
> +	/* don't try to unshare any extents beyond EOF. */
> +	if (pos > i_size_read(iter->inode))
> +		return length;

Hi Julian,

What about if pos starts within EOF and the operation extends beyond it?
I ask because I think I've reproduced this scenario, though it is a bit
tricky and has dependencies...

For one, it seems to depend on the cowblocks patch I recently posted
here [1] (though I don't think this is necessarily a problem with the
patch, it just depends on keeping COW fork blocks around after the
unshare). With that, I reproduce via fsx with unshare range support [2]
using the ops file appended below [3] on a -bsize=1k XFS fs.

I haven't quite characterized the full sequence other than it looks like
the unshare walks across EOF with a shared data fork block and COW fork
delalloc, presumably finds the post-eof part of the folio !uptodate (so
iomap_adjust_read_range() doesn't skip it), and then trips over the
warning and error return associated with the folio zeroing in
__iomap_write_begin().

This all kind of has me wondering.. do we know the purpose of this
warning/error in the first place? It seems like it's more of an
"unexpected situation" than a specific problem. E.g., assuming the same
page were mmap'd, I _think_ the read fault path would do the same sort
of zeroing such that the unshare would see a fully uptodate folio and
carry on as normal. I added the mapread op to the opsfile below to give
that a quick test (remove the "skip" text to enable it), and it seems to
prevent the error, but I've not confirmed whether that theory is
actually what's happening.

FWIW, I also wonder if another way to handle this would be to just
restrict the range of iomap_file_unshare() to within EOF. IOW if a
caller passes a range beyond EOF, just process whatever part of the
range falls within EOF. It seems iomap isn't responsible for the file
extending aspect of the fallocate unshare command anyways.

Thoughts?

Brian

[1] https://lore.kernel.org/linux-xfs/20240906114051.120743-1-bfoster@redhat.com/
[2] https://lore.kernel.org/fstests/20240906185606.136402-1-bfoster@redhat.com/
[3] fsx ops file:

fallocate 0x3bc00 0x400 0
write 0x3bc00 0x800 0x3c000
clone_range 0x3bc00 0x400 0x0 0x3c400
skip mapread 0x3c000 0x400 0x3c400
fallocate 0x3bc00 0xc00 0x3c400 unshare


