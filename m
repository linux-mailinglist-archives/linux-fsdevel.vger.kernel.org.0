Return-Path: <linux-fsdevel+bounces-69640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC989C7F749
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6377F4E3C9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBF25BEF8;
	Mon, 24 Nov 2025 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArT3jxUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477FB269AEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974946; cv=none; b=GaSqdsEeMBAU5Elq/gaV18cX5082zU+05rlg6rUsH2CPR3GmLvV7D1O6ECCmSiOWAbqM2JQ3PeXOvCr+Z5pgHP5m+cLkvHTuaaZed334eEgF1nBD3LbjjslSksHWqaUtlbTd/fvOToq0gccCCrgW/+/9QtXz4NJ9dq+CZ9MJ8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974946; c=relaxed/simple;
	bh=+joBFnap1Zy88Qx9KLeTDuNpFUQvP/eFFduyXDiR2eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrpCSqkMxs70FQbTRDfOEBPEoIpjVTiyYPmEktSTo1RIJ6kpNtqSWaS/fNLGlicqDIAZQbdX+T0dgFZt1UvQwRVj/tS+cStp8yUWkRUCtm0Q5v5SGgxpgrWHGvCIxu3nbqTtwoPj/p9sIM6sU+CjQvAEr+nvrqnuFLkIOw90sEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArT3jxUl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763974943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtOasMHvCP7ivXo4B4weeUpeNfCZFIX/ucoYYb5qtyI=;
	b=ArT3jxUlQii0YPVKQnCaGHG0dHPGROBW3v4RclaI+2vTq5KsnD1xhnQ4LompfH5x6CNjTd
	S1PkvcUSnUH62WjG/jM0+IZglZBOMXUGzfpPkI3hRv6tjNO01E53DYVrIcQktz/d+EF5d+
	SxXmR+nbOIYP4334B1QKfwyOCuHFk6M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-IfGb1u6uNI-ykC5sqbsIKQ-1; Mon,
 24 Nov 2025 04:02:18 -0500
X-MC-Unique: IfGb1u6uNI-ykC5sqbsIKQ-1
X-Mimecast-MFC-AGG-ID: IfGb1u6uNI-ykC5sqbsIKQ_1763974936
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D02BE1955DE0;
	Mon, 24 Nov 2025 09:02:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 104811956045;
	Mon, 24 Nov 2025 09:02:07 +0000 (UTC)
Date: Mon, 24 Nov 2025 17:02:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSQfC2rzoCZcMfTH@fedora>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSP3SG_KaROJTBHx@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
> FYI, with this series I'm seeing somewhat frequent stack overflows when
> using loop on top of XFS on top of stacked block devices.

Can you share your setting?

BTW, there are one followup fix:

https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/

I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
not see stack overflow with the above fix against -next.

> 
> This seems to be because this can now issue I/O directly from ->queue_rq
> instead of breaking the stack chain, i.e. we can build much deeper call
> stacks now.
> 
> Also this now means a file systems using current->journal_info can call
> into another file system trying to use, making things blow up even worse.
> 
> In other words:  I don't think issuing file system I/O from the
> submission thread in loop can work, and we should drop this again.

I don't object to drop it one more time.

However, can we confirm if it is really a stack overflow because of
calling into FS from ->queue_rq()?

If yes, it could be dead end to improve loop in this way, then I can give up.


Thanks, 
Ming


