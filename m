Return-Path: <linux-fsdevel+bounces-65705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546ABC0D7AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 13:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9149140450D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62166285CAD;
	Mon, 27 Oct 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBoBOP6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8834CDD
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567396; cv=none; b=qvRE1rZ+MCgvbCwm7qSPnG1UKKwJNCVEZ4qlHNayAmpS1/ZXO0fzbpaqRpGBWwraXdh1vcNOkHiOAPvMLTv4/sbnbP3EhzDksRGlVUKMLgnfYmdrZKqJ1CyOvDx7ZcgwTAKA5j/gP5/8u5xPbDD64v0H/hkHZabDgtKE9tLLBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567396; c=relaxed/simple;
	bh=HI6yWxEJp1gjlKZvada8DPKGKofq1d1froZRXfIIJsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCpwjU151T2H90bcWCyO5cFLwcRmNkWMWy4Of21Wtr4wOaKiYHM82NSQXFpGqju2O6KkvQyyx5l+oDEXpAq8MgJgEqTGkVjnQTVS1Vyo7P5tMpCDejtY+3XRmAyhzkcm0JGYXHHrbF8fWuynM3WaTDGdBfJao7KByUi6guwxXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBoBOP6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761567394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dvr5yCDDdvO0hGiiC+c+bdZ8Q9bBrB9l+9wKUIkrPEo=;
	b=NBoBOP6nqVvgSaHaf9XSec1nTVdIOzKmgROknBlIOeaPssgDMR6dQO15O+oyzGJmgTxFK5
	6qSvWYJGx5QZKvQ6BLGIr4ZDdaan5Fg3Qbvb8LO7PjW8aOMFzgJqA0NDH6R96USh5c8Tpa
	2+WOpMm62eeuBLYUi3LM4TaUiZO73co=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-8SYgUiLWONmZLpuxqwO0RA-1; Mon,
 27 Oct 2025 08:16:28 -0400
X-MC-Unique: 8SYgUiLWONmZLpuxqwO0RA-1
X-Mimecast-MFC-AGG-ID: 8SYgUiLWONmZLpuxqwO0RA_1761567387
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC93318002DD;
	Mon, 27 Oct 2025 12:16:26 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.105])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B83718004D8;
	Mon, 27 Oct 2025 12:16:25 +0000 (UTC)
Date: Mon, 27 Oct 2025 08:20:43 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix race when reading in all bytes of a folio
Message-ID: <aP9jmwrd5r-VPWdg@bfoster>
References: <20251024215008.3844068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024215008.3844068-1-joannelkoong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Oct 24, 2025 at 02:50:08PM -0700, Joanne Koong wrote:
> There is a race where if all bytes in a folio need to get read in and
> the filesystem finishes reading the bytes in before the call to
> iomap_read_end(), then bytes_accounted in iomap_read_end() will be 0 and
> the following "ifs->read_bytes_pending -= bytes_accounting" will also be
> 0 which will trigger an extra folio_end_read() call. This extra
> folio_end_read() unlocks the folio for the 2nd time, which sets the lock
> bit on the folio, resulting in a permanent lockup.
> 
> Fix this by returning from iomap_read_end() early if all bytes are read
> in by the filesystem.
> 
> Additionally, add some comments to clarify how this accounting logic works.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")
> Reported-by: Brian Foster <bfoster@redhat.com>
> --
> This is a fix for commit 51311f045375 in the 'vfs-6.19.iomap' branch. It
> would be great if this could get folded up into that original commit, if it's
> not too logistically messy to do so.
> 
> Thanks,
> Joanne
> ---
>  fs/iomap/buffered-io.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 72196e5021b1..c31d30643e2d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -358,6 +358,25 @@ static void iomap_read_init(struct folio *folio)
>  	if (ifs) {
>  		size_t len = folio_size(folio);
>  
> +		/*
> +		 * ifs->read_bytes_pending is used to track how many bytes are
> +		 * read in asynchronously by the filesystem. We need to track
> +		 * this so that we can know when the filesystem has finished
> +		 * reading in the folio whereupon folio_end_read() should be
> +		 * called.
> +		 *
> +		 * We first set ifs->read_bytes_pending to the entire folio
> +		 * size. Then we track how many bytes are read in by the
> +		 * filesystem. At the end, in iomap_read_end(), we subtract
> +		 * ifs->read_bytes_pending by the number of bytes NOT read in so
> +		 * that ifs->read_bytes_pending will be 0 when the filesystem
> +		 * has finished reading in all pending bytes.
> +		 *
> +		 * ifs->read_bytes_pending is initialized to the folio size
> +		 * because we do not easily know in the beginning how many
> +		 * bytes need to get read in by the filesystem (eg some ranges
> +		 * may already be uptodate).
> +		 */

Hmm.. "we do this because we don't easily know how many bytes to read,"
but apparently that's how this worked before by bumping the count as
reads were submitted..? I'm not sure this is really telling much. I'd
suggest something like (and feel free to completely rework any of
this)..

"Increase ->read_bytes_pending by the folio size to start. We'll
subtract uptodate ranges that did not require I/O in iomap_read_end()
once we're done processing the read. We do this because <reasons>."

... where <reasons> explains to somebody who might look at this in a
month or year and wonder why we don't just bump read_bytes_pending as we
go.

>  		spin_lock_irq(&ifs->state_lock);
>  		ifs->read_bytes_pending += len;
>  		spin_unlock_irq(&ifs->state_lock);
> @@ -383,6 +402,9 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)

This function could use a comment at the top to explain it's meant for
ending read submission (not necessarily I/O, since that appears to be
open coded in finish_folio_read()).

>  		bool end_read, uptodate;
>  		size_t bytes_accounted = folio_size(folio) - bytes_pending;
>  

"Subtract any bytes that were initially accounted against
read_bytes_pending but skipped for I/O. If zero, then the entire folio
was submitted and we're done. I/O completion handles the rest."

Also, maybe I'm missing something but the !bytes_accounted case means
the I/O owns the folio lock now, right? If so, is it safe to access the
folio from here (i.e. folio_size() above)?

Comments aside, this survives a bunch of iters of my original
reproducer, so seems Ok from that standpoint.

Brian

> +		if (!bytes_accounted)
> +			return;
> +
>  		spin_lock_irq(&ifs->state_lock);
>  		ifs->read_bytes_pending -= bytes_accounted;
>  		/*
> -- 
> 2.47.3
> 


