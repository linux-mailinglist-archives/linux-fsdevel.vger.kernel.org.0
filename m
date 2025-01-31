Return-Path: <linux-fsdevel+bounces-40489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D5A23DE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 13:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080E23A82A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979BE19D06E;
	Fri, 31 Jan 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZczaUkU9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CE1DFF0
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738327685; cv=none; b=sTYCtGq0uK4A78TN/NHhGH28eJ44cAs31i1YYK0zxVqUOdKfGqL+qkw0xGvMsgDl9lS2t4ogmBRCgdy3UuFK7ocunB6mxwekwA8y58DEny7H8jZSM+uSgKeDszjywilY8De1vNtjVgpy4EksLB/ar5PaEPmEkO7eexP9l5Ckkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738327685; c=relaxed/simple;
	bh=M4LO6+nnIx8UAWOEdBwZznCS68qgeWrvHpY4GRiaBe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT2lP5gqFTPBqf5rasU/J+dpNNRKi6RzNgbuqw0xfPvmhDJaxnnxINor4pMjw26DzkQDCS1xYNcK0/iwdgcrhqsTnHYtKqa8ENDykrdqoBcXNQojORYVFsVbIb7Y3wTteF5rmW+RXWcs+99CqNHdHS3ghRzRyHLXI7yAE3qtc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZczaUkU9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738327682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79Vuhr4adK9IKEekWMGE25OkYxlpklLPg9ZITgjg6XQ=;
	b=ZczaUkU95toQc9AcexgzWGq+pwGW3nD21oYFpPWSWsa/7DLZRs8NEQQG+mdYVX2sNy+oQJ
	lx12Ngb47PvrAMgu+Rm8oXcHny6ua5oEDJPV1UXsXeNYgkhyYaJxdp200wD6K+06/iKBqp
	5q/65ifLCvi/M8AnjIgCJl8k6BD448Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-XNJeTXPxNOSdAS6LaAY2OA-1; Fri,
 31 Jan 2025 07:47:58 -0500
X-MC-Unique: XNJeTXPxNOSdAS6LaAY2OA-1
X-Mimecast-MFC-AGG-ID: XNJeTXPxNOSdAS6LaAY2OA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A93C19560B4;
	Fri, 31 Jan 2025 12:47:57 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.113])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 905C519560A3;
	Fri, 31 Jan 2025 12:47:56 +0000 (UTC)
Date: Fri, 31 Jan 2025 07:50:08 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iomap: refactor iter and advance continuation
 logic
Message-ID: <Z5zHAEJ6BEBdVHWB@bfoster>
References: <20250130170949.916098-1-bfoster@redhat.com>
 <20250130170949.916098-4-bfoster@redhat.com>
 <Z5yE419RpS52yTbq@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5yE419RpS52yTbq@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jan 31, 2025 at 12:08:03AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 30, 2025 at 12:09:44PM -0500, Brian Foster wrote:
> > In preparation for future changes and more generic use of
> > iomap_iter_advance(), lift the high level iter continuation logic
> > out of iomap_iter_advance() into the caller. Also add some comments
> > and rework iomap_iter() to jump straight to ->iomap_begin() on the
> > first iteration.
> 
> It took me a bit to reoncile the commit log with the changes.
> 
> What this does is:
> 
>  1) factor out a iomap_iter_reset_iomap caller from iomap_iter_advance
>  2) pass an explicit count to iomap_iter_advance instead of derіving
>     it from iter->processed inside of iomap_iter_advance
>  3) only call iomap_iter_advance condititional on iter->iomap.length,
>     and thus skipping the code that is now in iomap_iter_reset_iomap
>     when iter->iomap.length is 0.
> 
> All this looks fine, although I wonder why we didn't do 3) before and
> if there is a risk of a regression for some weird corner case.
> 
> I hate nitpicking too much, but maybe split the three steps into
> separate patches so that 3) is clearly documented and can be bisected
> if problems arise?
> 
> 

No problem. I originally had this split up, then combined some of it
because the changes seemed trivial, then I think it became a little too
convoluted again. I think I should be able to split this back up into
two or three incremental patches..

Brian


