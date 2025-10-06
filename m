Return-Path: <linux-fsdevel+bounces-63498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081EBBE4FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B54EEF85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85372D4B7A;
	Mon,  6 Oct 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnHVGFwe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B2329A31C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760311; cv=none; b=QGIFklEAwx0zvDK7RJtiPWPoJAdvAp60Fi9X0ZkMtm1/gK3kSooyMDn33vq7iYGV/1JPheHeG0Rcv65NMsW1wohq48baS8p62FO+A/cXjjwNwmD5tfArBcPmbTVuvfv0gpzwlkkkNnSVxxj7TL3M6gJaYQ1ewG48/pKUU2uPZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760311; c=relaxed/simple;
	bh=lD+gJOH7BbrAfztkPzkBUkg4YmpmpiNcVfG5FaH5V0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKAHXHxVuIN5g+E+ZbsjLXbvlr2wGh2n8jsgnEFhrdEww747p6kyzwag6VkyVjHgsl+4HFajUq9I73C5VGJobqdg/QnQIalA8LFY0mp3gNOTvt9Tvcak7Z/Je/xyn1eFI/0lX+TRcZDO1tvd5oTSQdTzgnBLMIVW3m8VPJMasmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnHVGFwe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759760308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VD2zsKbVIO0/etmD/GaqQQpyf9O3SbQk82/C3h0JpE=;
	b=XnHVGFwe11CVpLFBJTPucRAqfl7k6hReu+f1ZwxJpV/VRI4ZE93m4U33DnAFM3BUHJ0JBj
	H1EeFpy5PsfkzawWQxYhblxxj6Ws+6gzWtv4ZB/IKCb2rcclcAKY7JOStHlvGPf1N60xXH
	5ilCnhyL6ghlmwD0nhjymZ+FiVxq0JI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-nfW2r-0WP_-7PdbSSG4qIA-1; Mon,
 06 Oct 2025 10:18:25 -0400
X-MC-Unique: nfW2r-0WP_-7PdbSSG4qIA-1
X-Mimecast-MFC-AGG-ID: nfW2r-0WP_-7PdbSSG4qIA_1759760304
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC28B195609E;
	Mon,  6 Oct 2025 14:18:23 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD0EC30002CC;
	Mon,  6 Oct 2025 14:18:17 +0000 (UTC)
Date: Mon, 6 Oct 2025 22:18:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 6/6] loop: add hint for handling aio via IOCB_NOWAIT
Message-ID: <aOPPpEPnClM-4CSy@fedora>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <20250928132927.3672537-7-ming.lei@redhat.com>
 <aN92BCY1GQZr9YB-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN92BCY1GQZr9YB-@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Oct 03, 2025 at 12:06:44AM -0700, Christoph Hellwig wrote:
> On Sun, Sep 28, 2025 at 09:29:25PM +0800, Ming Lei wrote:
> > - there isn't any queued blocking async WRITEs, because NOWAIT won't cause
> > contention with blocking WRITE, which often implies exclusive lock
> 
> Isn't this a generic thing we should be doing in core code so that
> it applies to io_uring I/O as well?

No.

It is just policy of using NOWAIT or not, so far:

- RWF_NOWAIT can be set from preadv/pwritev

- used for handling io_uring FS read/write

Even though loop's situation is similar with io-uring, however, both two are
different subsystem, and there is nothing `core code` for both, more importantly
it is just one policy: use it or not use it, each subsystem can make its
own decision based on subsystem internal.

Thanks, 
Ming


