Return-Path: <linux-fsdevel+bounces-17418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C478AD383
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0020D2864F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F674154421;
	Mon, 22 Apr 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lCOsRmTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51C153BF2;
	Mon, 22 Apr 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808301; cv=none; b=hPJ3tBd01pZN+H1wrZKSHO2P4WJMdL6DH7kw3nisRND+UYQ3Kai8HpOzEyr+ae0x0UxJO/1SRjcBzYT5zByy71FpfvCs53NNWQwMB6rfNE2yDWRQDvjardauuRZaVg8XAUwriq2yh8xRn3Qz845EGrmYXfH/ld8oStA4Tqi+2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808301; c=relaxed/simple;
	bh=tcf7LtMc1iHHWuaCXNBYUda1jDDRLHAk7qCytm0ssq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmRcvyy+i/SqF8TZILuWOrydyOE8+ZCXjcCnLQoD/XYuybi0wE/ritOreelnnmVFk9iBbgYksWK8Km5gDvLcTE0mDiE7EKXkhPbw/0iKm5wpKsNDaXyW4zH7dReUIR1JRGLFDOukokwrPLDH7+lJ0b34YLGKpPr1D20PdT9EKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lCOsRmTz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=owoNbbq/4Oa3wX8a4pMKvLe3fxSRVjBq0pacla7xhpQ=; b=lCOsRmTzxgMHbDgAwc1ovGatqm
	LqiEMBykFU2AKz1wuIr1yToMgeOZHqZ/5gZ1OINwJNM5vYSA61XJ/QvK48MmACHkNJbORcU5pDG9p
	aDUpu5SlfiDPzpK0ut9Kz1cGfPuaxGXkDyu81ksAg9WYU5tKGVlrE7ay00n/0ss13NMBbXML3vav4
	64FpEI0x9+SH/i6lZfA4P87cmZBiZD5eQmaasM2OyAZd+R9BZxe0MwIG233FkL1D/PF14gIJWzX/u
	jV0ygpqaa7EVnJ8LFmHp5Y33QvZd7uJoh5rhz2FpciUZPKCnrPhDBZU0Mvz+NMIceufua7bKVOBCM
	A04dQNsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryxpK-0000000EgZQ-0MtG;
	Mon, 22 Apr 2024 17:51:38 +0000
Date: Mon, 22 Apr 2024 18:51:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <ZiajqYd305U8njo5@casper.infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
 <ZiYAoTnn8bO26sK3@infradead.org>
 <ZiZ817PiBFqDYo1T@casper.infradead.org>
 <ZiaBqiYUx5NrunTO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiaBqiYUx5NrunTO@infradead.org>

On Mon, Apr 22, 2024 at 08:26:34AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 22, 2024 at 04:05:59PM +0100, Matthew Wilcox wrote:
> > On Sun, Apr 21, 2024 at 11:16:01PM -0700, Christoph Hellwig wrote:
> > > On Sat, Apr 20, 2024 at 03:50:22AM +0100, Matthew Wilcox (Oracle) wrote:
> > > > The folio error flag is not checked anywhere, so we can remove the calls
> > > > to set and clear it.
> > > 
> > > This patch on it's own looks good, but seeing this is a 27/30 I have
> > > no chance to actually fully review it.
> > 
> > You were bcc'd on 0/30 which fully explained this.
> 
> Not on the XFS list through which I'm reading this at least.  If it
> was to me personally those all go to >/dev/null anyway for mails
> Cced to mailing lists.
> 
> Please always send the damn series to everyone, fishing individual
> mails out of it is just a giant pain in the butt.

If I do that then half the mailing lists bounce them for having too
many recipients.  b4 can fetch the entire series for you if you've
decided to break your email workflow.  And yes, 0/30 was bcc'd to
linux-xfs as well.

