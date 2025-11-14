Return-Path: <linux-fsdevel+bounces-68478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 975DEC5D02E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A1CB4E8D30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414B314D1A;
	Fri, 14 Nov 2025 12:02:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E62DFA48;
	Fri, 14 Nov 2025 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121723; cv=none; b=o7njJfgGFEqaqY/FRnEtMzeMwD7Y+L3zmTkbAk4MbkpSgTRv3y7fHpQy/ZqeTFkhUNQ6I9/Tilg7TkSbEnF+kGZe4QGTrl20sdASp9IrFCZSAFn/0STILHDMz1PMsoRNrYHqpXsn4WuEClNwpy0Ysij+rh6A4eZjVfCMtnNkWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121723; c=relaxed/simple;
	bh=K6naIdsy7yyYyA4vb9Cz7pWbHURboZOc8nlzvye4JfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2Ht4EKE7aIMB1DlstE2Z3z/aPGsGgwn4Lb/9KdTFbVXqxRDVE82YMHMoFAqlmidcEm8Fg0D9IJNUZujI262Fu8rOgILiaGo4yHUvuv19/4hg0A9h+jRk7l7x3RR7QBQY36L9arxPjw/He+JCkvHOaUnoXPiVBoAbtZgD38aN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2CA5227AAA; Fri, 14 Nov 2025 13:01:52 +0100 (CET)
Date: Fri, 14 Nov 2025 13:01:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Keith Busch <kbusch@kernel.org>, Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251114120152.GA13689@lst.de>
References: <20251030143324.GA31550@lst.de> <aQPyVtkvTg4W1nyz@dread.disaster.area> <20251031130050.GA15719@lst.de> <aQTcb-0VtWLx6ghD@kbusch-mbp> <20251031164701.GA27481@lst.de> <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj> <20251103122111.GA17600@lst.de> <aRYXuwtSQUz6buBs@redhat.com> <20251114053943.GA26898@lst.de> <aRb2g3VLjz1Q_rLa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRb2g3VLjz1Q_rLa@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 14, 2025 at 10:29:39AM +0100, Kevin Wolf wrote:
> Right, but since this is direct I/O and the approach with only declaring
> I/O from the page cache safe without a bounce buffer means that RAID has
> to use a bounce buffer here anyway (with or without PI), doesn't this
> automatically solve it?
>
> So if it's only PI, it's the problem of userspace, and if you add RAID
> on top, then the normal rules for RAID apply. (And that the buffer
> doesn't get modified and PI doesn't become invalid until RAID does its
> thing is still a userspace problem.)

Well, only if we have different levels of I/O stability guarantees:

Level 0
  - trusted caller guarantees pages are stable (buffered I/O,
    in-kernel direct I/O callers that control the buffer)

Level 1:
  - untrusted caller declares the pages are stable
    (direct I/O with PI)

Level 2:
  - no one guarantees nothing
    (other direct I/O directly or indirectly fed from userspace)

PI formatted devices would only bounce for 1, parity would bounce for
1 and 2.  Software checksums could probably get away with only 1,
although 2 would feel safer.


