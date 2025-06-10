Return-Path: <linux-fsdevel+bounces-51172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C0AD3AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 16:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDD03A6294
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BBB29B214;
	Tue, 10 Jun 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjJCp49V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D4296152
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564970; cv=none; b=BYO7YfXvGjQ3NXOjuNEIia8TPkV8aloQGo6xIJW6CQ/WEWNhPsKtYhJNLfiaHctHAT4AX2JjPRPaC0iedI/j/XRakbPJiJ1W+M62BcLcU8A9fh67ExK6ZxyBz1Ql5ZdYLQ4CziJGqfjfjYtUs57OKB2YsLlUE+gKSRnJBLt4W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564970; c=relaxed/simple;
	bh=D7BOAezUBKStFtuUw2O7uMpCJ+VbOFUoNW+cBcLtYEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txS5l930oSl/xtjfnMFS3WV4XvqUx0LD68TLvfBYyPe0iAXgdPsd2vdsmOlYI+Jbj6iVmj8h5ECt18z9LxiPsPw43YCKnfIRyHpoBsF+ZFHn4TTw5rCTJhhExNXa7afXvP+Du4hjrrNv4T3fbCqcWCJd5OeVjH4CQOdaKCoK3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjJCp49V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749564967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ckEtXaJDkq/vPCJoXtoHzuYpOtdz098DwOjgA2RlsqE=;
	b=JjJCp49VkDJpWmzw3It6Y70Noie3wf0JIfBt/ewkkvKkVTJfEyEK61+fuSXYmupDCtmRge
	jKcyN3L+g3Yh4/9k/5YVoAxfWQrsEv1GzJEffwvI9DWqEZEswehZYQq1ir7eHXxJsCaCX5
	JyGdOGTmL6K712qHFJQ/WQQn3o6eu2k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-0-dAorxrPJiRa1APmCi7lw-1; Tue,
 10 Jun 2025 10:16:04 -0400
X-MC-Unique: 0-dAorxrPJiRa1APmCi7lw-1
X-Mimecast-MFC-AGG-ID: 0-dAorxrPJiRa1APmCi7lw_1749564962
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E89A419560BA;
	Tue, 10 Jun 2025 14:16:01 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE2B5180035C;
	Tue, 10 Jun 2025 14:16:00 +0000 (UTC)
Date: Tue, 10 Jun 2025 10:19:35 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aEg-9ygiDrIATmx3@bfoster>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-4-bfoster@redhat.com>
 <20250609160420.GC6156@frogsfrogsfrogs>
 <aEgjMtAONSHz6yJT@bfoster>
 <aEgzJgwRDsvlfhA1@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEgzJgwRDsvlfhA1@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Jun 10, 2025 at 06:29:10AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 08:21:06AM -0400, Brian Foster wrote:
> > Yes.. but I'm not totally sure wrt impact on the fbatch checks quite
> > yet. The next thing I wanted to look at is addressing the same unwritten
> > mapping vs. dirty folios issue in the seek data/hole path. It's been a
> > little while since I last investigated there (and that was also before
> > the whole granular advance approach was devised), but IIRC it would look
> > rather similar to what this is doing for zero range. That may or may
> > not justify just making the batch required for both operations and
> > potentially simplifying this logic further. I'll keep that in mind when
> > I get to it..
> 
> On thing that the batch would be extremely useful for is making
> iomap_file_unshare not totally suck by reading in all folios for a
> range (not just the dirty ones) similar to the filemap_read path
> instead of synchronously reading one block at a time.
> 

I can add it to the list to look into. On a quick look though any reason
we wouldn't want to just invoke readahead or something somewhere in that
loop, particularly if that is mainly a performance issue..?

Brian


