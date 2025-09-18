Return-Path: <linux-fsdevel+bounces-62169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE26B86DE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 22:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A5B620C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A731BCA3;
	Thu, 18 Sep 2025 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNfr2VjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4031BC86
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226475; cv=none; b=IUrsI3XmAESj5oFH7scajS4BgrEYvCkPsncyA5EmoezB61iF7Cccqvs4vnV+29VgJFqjDTtQkLZk0r7JCIIlRvSs4kiR6yohAq/D0jFvu0jN1opDIP2h56c8DRWRepm1nbcjccqfYoU7EiJv8ebU400aQ9Cwrky5k1BsDNr3FNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226475; c=relaxed/simple;
	bh=K/jaPhDCfjYhLpQMObBGLkP1U31NxY6X9mfRyW5UpxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0E47HmDp5lvs1/qSTqV4u3GYcjCRCu5bDjZo1BI2x36FASQ/U+YYHFYFH74n7sHUMWXXHqkLr1JJzBWvK3xWOclrUY+L+7vnGVEKr0hI8KnjIpmXwGTqymvyNoBnGK6OQ8rV2Dz+fY0pK/AzWlHk8m1oVt6g+Ff08rHOg1ud0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNfr2VjN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758226473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIDyIwPGLIVAqXvlX9X2afBhZSX5daSvzk10wkDvdZQ=;
	b=VNfr2VjNIvzUROvTerPgixYXWeMrfEf4p35py0bkQdmtLjQD82fKUiVQyN7ToVBppOQG4V
	4udh6XP9vQub+FsM949Rdy7y5dXs0fINrgKhByepO9C6muAsHpD48HPW5kDRDtkk5Z/HCR
	Kwb6LuH8SA03rXb+7NOFy+XoVlLB79I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-LWVzhj8xPmO85ni729s47w-1; Thu,
 18 Sep 2025 16:14:27 -0400
X-MC-Unique: LWVzhj8xPmO85ni729s47w-1
X-Mimecast-MFC-AGG-ID: LWVzhj8xPmO85ni729s47w_1758226466
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E9E81800447;
	Thu, 18 Sep 2025 20:14:26 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71C2930002C5;
	Thu, 18 Sep 2025 20:14:25 +0000 (UTC)
Date: Thu, 18 Sep 2025 16:18:29 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] iomap: simplify iomap_iter_advance()
Message-ID: <aMxpFWnIDOpEWR1U@bfoster>
References: <20250917004001.2602922-1-joannelkoong@gmail.com>
 <aMqzoK1BAq0ed-pB@bfoster>
 <CAJnrk1ZeYWseb0rpTT7w5S-c1YuVXe-w-qMVCAiwTJRpgm+fbQ@mail.gmail.com>
 <aMvtlfIRvb9dzABh@bfoster>
 <aMwW0Zp2hdXfTGos@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMwW0Zp2hdXfTGos@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Sep 18, 2025 at 07:27:29AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 18, 2025 at 07:31:33AM -0400, Brian Foster wrote:
> > IME the __iomap_iter_advance() would be the most low level and flexible
> > version, whereas the wrappers simplify things. There's also the point
> > that the wrapper seems the more common case, so maybe that makes things
> > cleaner if that one is used more often.
> > 
> > But TBH I'm not sure there is strong precedent. I'm content if we can
> > retain the current variant for the callers that take advantage of it.
> > Another idea is you could rename the current function to
> > iomap_iter_advance_and_update_length_for_loopy_callers() and see what
> > alternative suggestions come up. ;)
> 
> Yeah, __ names are a bit nasty.  I prefer to mostly limit them to
> local helpers, or to things with an obvious inline wrapper for the
> fast path.  So I your latest suggestions actually aims in the right
> directly, but maybe we can shorten the name a little and do something
> like:
> 
> iomap_iter_advance_and_update_len
> 
> although even that would probably lead a few lines to spill.
> iomap_iter_advance_len would be a shorter, but a little more confusing,
> but still better than __-naming, so maybe it should be fine with a good
> kerneldoc comment?
> 

Ack, anything like that is fine with me, even something like
iomap_iter_advance_and_length() with a comment that just points out it
also calls iomap_length().

Another thought was to have one helper that returns the remaining length
or error and then a wrapper that translates the return (i.e. return ret
>= 0 ? 0 : ret). But when I thought more about it seemed like it just
created confusion.

Brian


