Return-Path: <linux-fsdevel+bounces-43140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C2A4EA52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09C98E6541
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6142BE7CB;
	Tue,  4 Mar 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFrjF+sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44D2980AA;
	Tue,  4 Mar 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108635; cv=none; b=ujBCBQ8ZeFtLQlt+loMuvqhfh0CqDN2PgGsKe9oe3Hl3uu2qJnfatz2V1fFv8RbKIaWvZumoTeJPn0UzulEX5rqAU2OBKppxg40T/ifenAnA+qjA9275U6Mbeg4zinBLB4kSZjWR50QWykfjCEdrNhpNBNLoJPeA2BZSlP3bBAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108635; c=relaxed/simple;
	bh=3j+Qz7hT1f8OqjlZi9V6ZuZnjswQjZpLuYZfWeHW7K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/4yRG67kmhqTCvzfpmwGhglmLr36cdlkXDDrXnZ/G1zzwXzVz5cdh3IMr4V2aDXkzPpuZGlNqYZYsxlK0RDyChdnxDyFkhCLiTOhaRqzhgWkHag4mwpnmXIWQ/AAETwzhsvsNzZrmGLsUd1wWwykiWi4D3fMON2+kzp+9rZG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JFrjF+sp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Uoeevh/Cjq7NLA2NMtRTv1MiqPIpGJ85FyoLQLLraE=; b=JFrjF+spdHGmhMsTnV97EVwxcB
	gjRe0ezJfT9DhgQSvu6I6A0PLsl1Or6kFvAcoqmV++vCFw8QSzX5HfwYf4BRNzlGzd8K7QhYvoguP
	S3EV7klTjp15oLbLbgFQ+kMoTwBbDCt0FXmIJPAtI9TrYx2DKRiT5uFxyAo/ex95NPXiArHu1KkGJ
	cT3EcJzKvfkr3mtqYCpWUtjNOUN/s2moR7tD1xvTZzHzHkr4I6sk8K1TSTdwH6NVKPoBMM4KJ27zV
	h12RaE3NFg3pSkoYDJV4J3uk3K43b50EXrqTlvmOmcV6QBhoNYmm4NrWtHzBfdwBw2VpdgRnUH7a0
	/YQfRolQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpVtH-00000005ahU-2jq2;
	Tue, 04 Mar 2025 17:17:11 +0000
Date: Tue, 4 Mar 2025 09:17:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Heinz Mauelshagen <heinzm@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8c1l_MjG4youGNO@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8cE_4KSKHe5-J3e@infradead.org>
 <CAM23Vxr=fKy-0L1R5P-5h6A95acKT_d=CC1E+TAzAs8v6q9gHw@mail.gmail.com>
 <Z8cki-inrku8QIhB@infradead.org>
 <CAM23VxqJX46DCpCiH5qxPpDLtMVg87Ba8sx55aQ4hvt-XaHzuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM23VxqJX46DCpCiH5qxPpDLtMVg87Ba8sx55aQ4hvt-XaHzuQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 04, 2025 at 06:01:04PM +0100, Heinz Mauelshagen wrote:
> > As Mikulas shared earlier:
>  > The Android people concluded that loop is too slow and rather than using
> > loop they want to map a file using a table with dm-linear targets over the
> > image of the host filesystem. So, they are already doing what dm-loop is
> > doing.

Which again is completely handwavy.  What is the workload.  What are the
issues with the workload?  Where is the time spent making it slower.
e.g. the extent mapping code in this patch is a lot less efficient than
the btree based extent lookup in XFS.  If it is faster it is not looking
up the extents but something else, and you need to figure out what it
is.

