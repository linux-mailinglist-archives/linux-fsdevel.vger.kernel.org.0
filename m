Return-Path: <linux-fsdevel+bounces-17757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86C8B21D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F402894A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F21494C7;
	Thu, 25 Apr 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U3ka5y23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD615AF6;
	Thu, 25 Apr 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049093; cv=none; b=D77XQweJOTT2lxWMJh3D+62KFnzO5hF3zx8nZDEnezVq0yPZi1meA63C4L4/sHCeduVuztpf9PUHSXH9x2nK6GWD+33BuHZsy3b15oGA1sLv9YrkfqZCdkrqJNvMgdU+P0ptkz4Md30qfl0wdIvNzH6srjQWhsaSRwJXTLXxKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049093; c=relaxed/simple;
	bh=FKP4rwK5HVxu4BI9BqHwkO0GA561653oDDY27Kaxpm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlShN+Enlvasu3ReWDSfvsL4sWrI+B9Q0pR1Z6UHiTNB9gUMN42KyIAGAxjrBqU2cBzDA/N8UfG/F9dqoNCq96JCtg3sdObKb0E5xVQcm0eG1jiU6DulsG0EsPXZTWG7QshncU4cWJdtvRxshiPRfctu4u6CSrzGqNrm+thIxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U3ka5y23; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bib3CrkpXPZh3fL7KWT/QVmeJRtookIbtMqUYQFAvRw=; b=U3ka5y23JWwQ0p+XkRvJa0pXZU
	RDIQYifjcjrxeWOakx/oGJ5IKNSxnv/omV3jk2DrH8ylwR3NTKjjof86xtrSUxLh2BEoke9x++ujH
	3L9wJOPdUcIaBl/vCYNH7DEHTRbwXTA1TLcQ9l2M33vX/MUKdKZ30Be5rANx8oU39vhPGauV96pOK
	LOve1fsHpBVqUyfbUXtFWbu4ZSNuxZjxn7ypqPCLYI6a21CuwxnVaEoD9hvevBWkC4JbIjwDAYkxQ
	8TjZf5JuJQHP1VDz7xgXwhw7gGj0DjrbsT3xIVYbzkYFtmM79E7aj08faYfJClP62yGCduBbPFozb
	rcPYzQkA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzyT3-000000032Ji-3Ug1;
	Thu, 25 Apr 2024 12:44:49 +0000
Date: Thu, 25 Apr 2024 13:44:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <ZipQQYPLuFuh3ui6@casper.infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
 <ZiYAoTnn8bO26sK3@infradead.org>
 <ZiZ817PiBFqDYo1T@casper.infradead.org>
 <ZiaBqiYUx5NrunTO@infradead.org>
 <ZiajqYd305U8njo5@casper.infradead.org>
 <ZipLUF3cZkXctvGG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZipLUF3cZkXctvGG@infradead.org>

On Thu, Apr 25, 2024 at 05:23:44AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 22, 2024 at 06:51:37PM +0100, Matthew Wilcox wrote:
> > If I do that then half the mailing lists bounce them for having too
> > many recipients.  b4 can fetch the entire series for you if you've
> > decided to break your email workflow.  And yes, 0/30 was bcc'd to
> > linux-xfs as well.
> 
> I can't find it on linux-xfs still.  And please just don't make up
> your own workflow or require odd tools.

You even quoted the bit where I explained that the workflow you insist I
follow doesn't work.

