Return-Path: <linux-fsdevel+bounces-68534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E30C0C5E99F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 18:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 100453A0C85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD3336EFB;
	Fri, 14 Nov 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZMab8F9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3F2C15B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139366; cv=none; b=iti2uGbPqn6ooqY+Cms7lI8nFCmDw6/SyXGRd1fkYM9QabzQIj4anWNPGPKSOeKiDQHlQmgvSVt9tFeRe4ogpBtFQ83oZDrqjCWFpPA2s5kiXkPzKkxw+c0Jv0JGfNaZly9VLOhgYFojESlY9RtERJZ6arjqtBPwHYfByDCMoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139366; c=relaxed/simple;
	bh=6TSkTd8QYhGIkuJktBXMhRTbFnRorBPr9gWU+GWWeCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY8yMfqQWfnNt9zCrRlRdj+PrBjKmgxtVwSrEB2OjcfbpbEIvY1F+y2RPpLXlqKzTfh9eJaJ4psgrMh4IFbqXokTwYmHXf+XAklPKZuoHtrLkKtuUpymaXfQ7dNTwP7R/cEL0wAWoIhlnx1CCTxjLasFDAWorBN5yd3DvjQdrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZMab8F9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763139363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+w7fTZt5yUvxxlHlhv9qFh5bl+En30eT9dJ3sbzFCY=;
	b=FZMab8F9sEMWlmo1JhVuLYsItPORBWp8cFuYIjcFTzfc+A8ggyS2AIMkCLkvG5blD7M2Jz
	jle050kO6ZUTkmGx1r+79KNOaR5+IDSwyjEvi72gcwWIcFDJPExp4busxZWUFNre0OAGjr
	mY84cXU/9EG3DG7r7OY+5QCOA+ylPKY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-0Y7IkpOzNdGYfOhy4GdU6A-1; Fri,
 14 Nov 2025 11:55:59 -0500
X-MC-Unique: 0Y7IkpOzNdGYfOhy4GdU6A-1
X-Mimecast-MFC-AGG-ID: 0Y7IkpOzNdGYfOhy4GdU6A_1763139358
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB9F019540E8;
	Fri, 14 Nov 2025 16:55:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E2B618004A3;
	Fri, 14 Nov 2025 16:55:52 +0000 (UTC)
Date: Fri, 14 Nov 2025 17:55:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aRdfFRw1vKUHXqIg@redhat.com>
References: <aQTcb-0VtWLx6ghD@kbusch-mbp>
 <20251031164701.GA27481@lst.de>
 <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
 <20251103122111.GA17600@lst.de>
 <aRYXuwtSQUz6buBs@redhat.com>
 <20251114053943.GA26898@lst.de>
 <aRb2g3VLjz1Q_rLa@redhat.com>
 <20251114120152.GA13689@lst.de>
 <aRchGBJA1ExoGi8W@redhat.com>
 <20251114153644.GA31395@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114153644.GA31395@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Am 14.11.2025 um 16:36 hat Christoph Hellwig geschrieben:
> On Fri, Nov 14, 2025 at 01:31:20PM +0100, Kevin Wolf wrote:
> > My main point above was that RAID and (potentially passed through) PI
> > are independent of each other and I think that's still true with or
> > without multiple stability levels.
> > 
> > If you don't have these levels, you just have to treat level 1 and 2 the
> > same, i.e. bounce all the time if the kernel needs the guarantee (which
> > is not for userspace PI, unless the same request needs the bounce buffer
> > for another reason in a different place like RAID). That might be less
> > optimal, but still correct and better than what happens today because at
> > least you don't bounce for level 0 any more.
> 
> Agreed.
> 
> > If there is something you can optimise by delegating the responsibility
> > to userspace in some cases - like you can prove that only the
> > application itself would be harmed by doing things wrong - then having
> > level 1 separate could certainly be interesting. In this case, I'd
> > consider adding an RWF_* flag for userspace to make the promise even
> > outside PI passthrough. But while potentially worthwhile, it feels like
> > this is a separate optimisation from what you tried to address here.
> 
> Agreed as well.
> 
> In fact I'm kinda lost what we're even arguing about :)

Probably nothing then. :-) I was just confused because you called PI
passthrough from userspace a complication, but it seems we agree that
there is no real complication in the sense that it's hard to get
correct and the approach can be implemented just like that.

That's really why I posted in the first place, to agree with you that
this approach seems best to me, and because I don't want to see our
O_DIRECT requests silently fall back to buffered I/O in more cases,
especially with AIO.

Kevin


