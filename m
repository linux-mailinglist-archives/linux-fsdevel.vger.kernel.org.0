Return-Path: <linux-fsdevel+bounces-51615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B993DAD95E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA781E2FDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DE924676E;
	Fri, 13 Jun 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uR0MtTse"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A51F3B83;
	Fri, 13 Jun 2025 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845086; cv=none; b=nghwglcI+WfdNecaljR/DFbDdzJB9Mz3EZZchcbZN2f8/f8HxlqufboWBPkvC/o0J+NqJYn79IGzWAZJoLuGAck7LWHgq3rB7jz+U9d/8S5wpCt562+3rjbnNEUoRKgAZooa6zsRM7JNczBvRlJb2BUxsVpD8xRcR34wpCiFjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845086; c=relaxed/simple;
	bh=1vsSmmZ1ACTtZ+LU4FX4Fkr0A7F1qz8MU5LJDH6hE0s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FD62vVc0D46QKbhioKtNUDOmrQQ993lQ1yYGklQEvm8wVKSzX5aANFZSl+88aSYAeRqY0aabbJwOsCsXjHP3wChjOq7mVgQH7VAWDcFDgY8f4I3hSfs99Yh7iUiFMe0V4AlNfgzJrT5CykF74KYwnae6zhgN7vpU0CO3KBNbKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uR0MtTse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E65DC4CEE3;
	Fri, 13 Jun 2025 20:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749845085;
	bh=1vsSmmZ1ACTtZ+LU4FX4Fkr0A7F1qz8MU5LJDH6hE0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uR0MtTse3NJobk7ndpDlO3mCZtOnoOleS5ge7zjMo/J9hJYL8soqpGK/2rvnmG/L4
	 9jJlO0u1UkhUxI/GaRKqlyqymKta0fYrCqCaZam/RcEaF/kZvss3Nw2IXrr4O3YjN6
	 42tdSlI7P/Whb5eQnTSRilfEFAWSmIHa4bEO25Vw=
Date: Fri, 13 Jun 2025 13:04:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, Ira Weiny
 <ira.weiny@intel.com>, linux-block@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove zero_user()
Message-Id: <20250613130444.9a1affd0ef5ff719be34103e@linux-foundation.org>
In-Reply-To: <aEyBKksbj0DebCOw@casper.infradead.org>
References: <20250612143443.2848197-1-willy@infradead.org>
	<20250613052432.GA8802@lst.de>
	<aEyBKksbj0DebCOw@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 20:51:06 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jun 13, 2025 at 07:24:32AM +0200, Christoph Hellwig wrote:
> > On Thu, Jun 12, 2025 at 03:34:36PM +0100, Matthew Wilcox (Oracle) wrote:
> > > The zero_user() API is almost unused these days.  Finish the job of
> > > removing it.
> > 
> > Both the block layer users really should use bvec based helpers.
> > I was planning to get to that this merge window.  Can we queue up
> > just the other two removals for and remove zero_user after -rc1
> > to reduce conflicts?
> 
> If I'd known you were doing that, I wouldn't've bothered.  However,
> Andrew's taken the patches now, so I'm inclined to leave them in.
> No matter which tree it gets merged through, this is a relatively easy
> conflict to resolve (ie just take your version).  I have some more
> patches which build on the removal of zero_user() so it'd be nice to
> not hold them up.

Sure, Christoph, please just proceed with the block changes and we can
see what the conflicts look like when Stephen hits them.  If Matthew's
series needs modification then so be it.

