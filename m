Return-Path: <linux-fsdevel+bounces-36507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F3A9E4B42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 01:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3F01881182
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 00:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51912E7E;
	Thu,  5 Dec 2024 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="avJhwTcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C70D531;
	Thu,  5 Dec 2024 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359112; cv=none; b=sh31RdNcQ/qjswxdf54/jUJEHZEJEploZZ6I5basA3oXyzykOmnnxlQWMlOw9qbVAc9sVWL5ah7LuIatT1+mLOxdlyZOIPpB4SSfWIjMPhMYgzkQpKyjFykLUW/wfIeo0CyX702gU/RI6jaex2eoTEE+2EN6Qlu7vHu3akKBbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359112; c=relaxed/simple;
	bh=9YVm5TgWSjCYrpLpmtVTO6+TJLEENd0UFDiH4YMYOaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRi/CUo52s1sVP2yUQBaYKrEbG7corfq+mW8Z9rGXquCXXCWy5SpTLDtHr7dTdRMwoOfITvj+/6ZzcmciEUJ0rah1KQ1awTNdIo3zscjH6kVc0RYXzCFriEKI1eu3Lfw3BRAR65wu9oSes5WpKLZkXDwIGmVWpT8S5ekeF+BQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=avJhwTcR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y+oQ0S3ae3U/S6jQx7MGFvQACNYgjF/pNRRinNABr+U=; b=avJhwTcRsgyF38KzhEz/82L23x
	jjBEnChetTC0jTQmzrlc8kPnox81tZC8a3Ah5PX3Uk8AJ0XiXt0sScmbbR6ltbmZa2A0fHcGaWpXF
	IYsfk0pUKwjYlI3lOMRUTZyU7bJ1JwicfmJXHZc80HVFSAp7vkJzjBlm9ePYnCQCz+bCHXqHF4KCu
	aZ4q0G9PRzZKeGePjj2qL2/KobMOHecU8Jz0Zhi9Bmeh4PsT3xQJTAOMuD7sKKYLR2tglHzkXsFh7
	S0akLWr75xXgL9US362UL7s3Qvpmo10uJT75ZgHhcQA+zJEHcW4+l8pJInBXzQMQvyjhg9rf3PEfC
	FD20zKOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIzsy-0000000ENKv-0WGX;
	Thu, 05 Dec 2024 00:38:28 +0000
Date: Wed, 4 Dec 2024 16:38:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <Z1D2BE2S6FLJ0tTk@infradead.org>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Dec 01, 2024 at 02:12:24PM +0100, Christian Brauner wrote:
> Hey,
> 
> Some filesystems like kernfs and pidfs support file handles as a
> convenience to enable the use of name_to_handle_at(2) and
> open_by_handle_at(2) but don't want to and cannot be reliably exported.
> Add a flag that allows them to mark their export operations accordingly
> and make NFS check for its presence.
> 
> @Amir, I'll reorder the patches such that this series comes prior to the
> pidfs file handle series. Doing it that way will mean that there's never
> a state where pidfs supports file handles while also being exportable.
> It's probably not a big deal but it's definitely cleaner. It also means
> the last patch in this series to mark pidfs as non-exportable can be
> dropped. Instead pidfs export operations will be marked as
> non-exportable in the patch that they are added in.

Can you please invert the polarity?  Marking something as not supporting
is always awkward.  Clearly marking it as supporting something (and
writing down in detail what is required for that) is much better, even
it might cause a little more churn initially.


