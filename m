Return-Path: <linux-fsdevel+bounces-73697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BE5D1ED62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B4173032955
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8463F397AAE;
	Wed, 14 Jan 2026 12:40:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9AE35965;
	Wed, 14 Jan 2026 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394400; cv=none; b=ZO6uJDgHzCNjWtWINPPVyyYdgAre0zXyHL2JjZfI9a9eufMJ2C2YpG3OGS7iVV9Kpn42gILZcbyFEHgyg0ObTV/z1b6nEnuP+MPhq2Ia8G5ktkOWZCtq1Pvlw+2TTVul8/JgjphL5GU25OsiGDisGL2XF5vyUnclp9hthLGfSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394400; c=relaxed/simple;
	bh=VVr7YjUo372QTeC3/sM+m6U+iPVx2JqR1ZTmmqHi9c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihR21mO7yB7I4PU2QSNCjLiaWArXaCbw5U3db8M+tXmZwT+WKzm7eS0cQdwLaEzBy5D6+ttwTcYQ9Ur6VzTBJjgYY2cPgO1ynMe034Nm8EBCtJPRXyCo/X69hQYD/LQetj4QAlKbfKKsk2xlAcHNBQHLfgyxdEKt+0srwQnNXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 671F4227AA8; Wed, 14 Jan 2026 13:39:54 +0100 (CET)
Date: Wed, 14 Jan 2026 13:39:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: bounce buffer direct I/O when stable pages are required
Message-ID: <20260114123954.GA4430@lst.de>
References: <20260114074145.3396036-1-hch@lst.de> <f5568a83-75df-4e84-8cf0-01df6dd4e810@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5568a83-75df-4e84-8cf0-01df6dd4e810@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 08:22:27PM +1030, Qu Wenruo wrote:
> I guess the final reason to bounce other than falling back to buffered IO 
> is still performance, especially for AIO cases?

It is to support AIO and parallel writers, yes.

> If iomap is going to handle the page bouncing I guess we btrfs people will 
> be pretty happy to use that, without implementing our own bouncing code.

Given that btrfs runs all read completions from a workqueue I think
just setting the new IOMAP_DIO_BOUNCE flag and otherwise reverting
to the old direct I/O implementation should be all that is needed.


