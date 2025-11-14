Return-Path: <linux-fsdevel+bounces-68447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9017C5C4AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB68E3AC505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD0306D36;
	Fri, 14 Nov 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti58+DK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797C303A03
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112598; cv=none; b=RdnTPJII/Ck85QFaYW9f1FWTH74AO0IPTl2RKl87hv9/trOUTHZg/KD6xoA6g+PaS+DwBIQu02f3G7rGjLcN2yK/+QapxYSDJvwiFlDtrUXCSDp02iPt5Vj+dgm4QfzmtEGmsa+8PhHOAODEnwouHYnQKOPeMcEPy7/vFcBUiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112598; c=relaxed/simple;
	bh=jN/U10PEACfI2LGvwU3yDap5PnO6nXq6dqmyFFl38SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VphGdeyEclrRGQAaxrH1JjBqA1AW6Vw/ynpDDZeDe1oKsSokd4yeA4SdehKRUtVj/6FWX1Ba59oBKXffcVJsx/F0wGHUXOJjDhMdN/IGBAe+MV70BHUbCh2yZ6mcxBVEJDNkKI+fG++OaZBxkR3nNYL11YTFLITALevRsvKHvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ti58+DK9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763112595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2UMGJvbyd+Jx465vz/JOY+McTzX6ECnbNFSuf+fQx5w=;
	b=Ti58+DK9r6BlIiwMwfPxGwYeT2Rz2uw5o5pd5bR/0HEhZP7cabaXjvWpz5AjWu5ZwwC+qB
	Cw51/7Ic05QPGCThFTrBKpMmaLusLkF+gkCUYi7gL/EkEspkOrr9ELWfdzYgeutCETmUZX
	POOCGKUMjPL7hRRejKiyMDC7olVMEpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-8we_DQwTOeeMbY0saWDPXg-1; Fri,
 14 Nov 2025 04:29:48 -0500
X-MC-Unique: 8we_DQwTOeeMbY0saWDPXg-1
X-Mimecast-MFC-AGG-ID: 8we_DQwTOeeMbY0saWDPXg_1763112586
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E3981956080;
	Fri, 14 Nov 2025 09:29:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D9B5300018D;
	Fri, 14 Nov 2025 09:29:42 +0000 (UTC)
Date: Fri, 14 Nov 2025 10:29:39 +0100
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
Message-ID: <aRb2g3VLjz1Q_rLa@redhat.com>
References: <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de>
 <aQPyVtkvTg4W1nyz@dread.disaster.area>
 <20251031130050.GA15719@lst.de>
 <aQTcb-0VtWLx6ghD@kbusch-mbp>
 <20251031164701.GA27481@lst.de>
 <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
 <20251103122111.GA17600@lst.de>
 <aRYXuwtSQUz6buBs@redhat.com>
 <20251114053943.GA26898@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114053943.GA26898@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Am 14.11.2025 um 06:39 hat Christoph Hellwig geschrieben:
> On Thu, Nov 13, 2025 at 06:39:07PM +0100, Kevin Wolf wrote:
> > > A complication is that PI could relax that requirement if we support
> > > PI passthrough from userspace (currently only for block device, but I
> > > plan to add file system support), where the device checks it, but we
> > > can't do that for parity RAID.
> > 
> > Not sure I understand the problem here. If it's passed through from
> > userspace, isn't its validity the problem of userspace, too? I'd expect
> > that you only need a bounce buffer in the kernel if the kernel itself
> > does something like a checksum calculation?
> 
> Yes, the PI validity is a userspace problem.  But if you then also use
> software RAID (right now mdraid RAID5/6 does not support PI, so that's a
> theoretical case), a (potentially malicious) modification of in-flight
> data could still corrupt data in another stripe.  So we'd still have to
> bounce buffer for user passed PI when using parity RAID below, but not
> when just sending on the PI to a device (which also checks the validity
> and rejects the I/O).

Right, but since this is direct I/O and the approach with only declaring
I/O from the page cache safe without a bounce buffer means that RAID has
to use a bounce buffer here anyway (with or without PI), doesn't this
automatically solve it?

So if it's only PI, it's the problem of userspace, and if you add RAID
on top, then the normal rules for RAID apply. (And that the buffer
doesn't get modified and PI doesn't become invalid until RAID does its
thing is still a userspace problem.)

Kevin


