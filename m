Return-Path: <linux-fsdevel+bounces-40245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A81A21074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 19:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5096F3A9F5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66C21DED44;
	Tue, 28 Jan 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zib/B+pI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C991DE89D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087025; cv=none; b=uZgWlylqR/tJjLx7h9PEEPd6i87mWoKrywNFKgnmdWPYGhQ3vmOdUFZuJ8sIbL8ecHgkc/f+vY7ew4vRk8z3TF5co/+g4O8tsSIMGsX2jIHyzo3JV0CyWn5+PzVziSTWz3y6jk31W6KnIZ3P4d+HDBstdwFPrV9K5x9WiTwlAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087025; c=relaxed/simple;
	bh=bqo/f4KOeEu70x09sbwjCLOoL4y8IE677pL9B41drLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmqU5+tivRQjko3t3rOymB2m2ZJYMzUkrQeqHA0rS3NKE9/MH9tLzckx+YB1TnsiAESzwSQUnprNun5OAb/+L21mlNOoCL9VBDr7eUZ6zT08gIYZrCAiUAzMI0cHupPlCF1DRxoeq1YTSEmy12wZPVXvu6Dq/io5C4wrL6k3ZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zib/B+pI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738087022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Atyyl7qbwygGo2BM9ZwbTcnDUCO9u7XINYpNimiJjNg=;
	b=Zib/B+pIuDp+hxctCEZVfAfGUN9IG20B5Z4RcIB1OsOcQ/4AsdIYPJPpUDLLwuUIEQPzE6
	B5ODuyWPYQwtraklgx9OyZX1mWXP8aG7ZCzt+1fG7FPHonEr7f5Ip6RTb+y9r3u7M9sZzz
	dLltETRqlmu0H+KMoHitG2an0XQEBDw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-8X8ud5u3PD65UZVwYqdJCw-1; Tue,
 28 Jan 2025 12:56:58 -0500
X-MC-Unique: 8X8ud5u3PD65UZVwYqdJCw-1
X-Mimecast-MFC-AGG-ID: 8X8ud5u3PD65UZVwYqdJCw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEACE1801887;
	Tue, 28 Jan 2025 17:56:57 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E96A5195608E;
	Tue, 28 Jan 2025 17:56:56 +0000 (UTC)
Date: Tue, 28 Jan 2025 12:59:09 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iomap: advance the iter directly on unshare range
Message-ID: <Z5ka7TYWr7Y9TrYO@bfoster>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-7-bfoster@redhat.com>
 <Z5htdTPrS58_QKsc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5htdTPrS58_QKsc@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 27, 2025 at 09:39:01PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 22, 2025 at 08:34:33AM -0500, Brian Foster wrote:
> > +	size_t bytes = iomap_length(iter);
> 
> > +		bytes = min_t(u64, SIZE_MAX, bytes);
> 
> bytes needs to be a u64 for the min logic to work on 32-bit systems.
> 

Err.. I think there's another bug here. I changed iomap_iter_advance()
to return s64 so it could return length or an error, but never changed
bytes over from size_t.

But that raises another question. I'd want bytes to be s64 here to
support the current factoring, but iomap_length() returns a u64. In
poking around a bit I _think_ this is practically safe because the high
level operations are bound by loff_t (int64_t), so IIUC that means we
shouldn't actually see a length that doesn't fit in s64.

That said, that still seems a bit grotty. Perhaps one option could be to
tweak iomap_length() to return something like this:

	min_t(u64, SSIZE_MAX, end);

... to at least makes things explicit.

Another option could be to rework advance back to something like:

	int iomap_iter_advance(..., u64 *count);

... but where it returns 0 or -EIO and advances/updates *count directly.
That would mean I'd have to tweak some of the loop factoring and lift
out the error passthru assignment logic from iomap_iter(). The latter
doesn't seem like a big deal. It's mostly pointless after these changes.
I'd guess the (i.e. iomap_file_unshare()) loop logic would look more
like:

	do {
		...
		ret = iomap_iter_advance(iter, &bytes);
	} while (!ret && bytes > 0);

	return ret;

Hmm.. now that I write it out that doesn't seem so bad. It does clean up
the return path a bit. I think I'll play around with that, but let me
know if there are other thoughts or ideas..

Brian


