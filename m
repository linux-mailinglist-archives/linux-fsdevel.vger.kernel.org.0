Return-Path: <linux-fsdevel+bounces-55163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0046CB076A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C683A8418
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4B22F49EE;
	Wed, 16 Jul 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n1nTm4bk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B782F2708
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671575; cv=none; b=VB2C3u04lxG/bWyqywzYYNywoE0yAAADioRbtlR0JSPBskZGXwfZ3l+kiHuLrTxl3+UsfQNh4BbCZbL5cR0sQV/qpqXVaXkVuMIYR2T5WsmNkrxZimNHOdiYHK60QYywMYuqEndnVRFA9ExxqnSeE/lXdYLQuorR8UaX7qs6MKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671575; c=relaxed/simple;
	bh=JJI7bvWP3bGKinDTuQ0X7OaDvecrS23ALoiZ0kqEwIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzsA0nHAJqVkjNGlFYE955GW+iPv2U3dnjG0G0e7+p1F8TdQ7A8RRcQcKG5+XQxuNi0AspcKDS+ypiDsqb2GnrGrzq+FT4I63uVQXfy8f5s/xluL/c8U+7jUsrxs4nXB146orIHMN1HO8SNsgvZ64myFE04Yk/OPR1xfSVW3pN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=n1nTm4bk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9Vj1+lsfj/mETLoPQjD0+P8XafZN5UQfO5tx+zNb+Ts=; b=n1nTm4bkrQ6GnHODUoQfzw8ce5
	TZ5xnqXqIqWzw0cI14e/ZmfJse0y9UmVfDFWZj19i1zaX9mwcNG8n47xMFPf20FHL7iH2nDSgfqHD
	kIx6EkCSEYXJ37euWpEfKlbxUnp8ouYH3Fw2Uh7DkGiHg8Fh5EeA7Wrv9N78vzM6bD13+asfd+w+h
	tR4R1kTZisg3G3siwLMNhgdxln0kLkf5wywthbbZ5OdQ/ua+K5Eo+5Xs3Rq0HkJ73eDgrkDp5i2ZH
	ShcLbzsql0JTE5d6fESs2Yruw5Ii+Hwm63EWPzv8qGsozC2IKWJdI4VKKdlhiPtz4lk5fddNjqRXs
	sE5WwP/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1wI-0000000A22H-2Q60;
	Wed, 16 Jul 2025 13:12:50 +0000
Date: Wed, 16 Jul 2025 14:12:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alex <alex.fcyrx@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, torvalds@linux-foundation.org,
	paulmck@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove obsolete logic in i_size_read/write
Message-ID: <20250716131250.GC2580412@ZenIV>
References: <20250716125304.1189790-1-alex.fcyrx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716125304.1189790-1-alex.fcyrx@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 16, 2025 at 08:53:04PM +0800, Alex wrote:
> The logic is used to protect load/store tearing on 32 bit platforms,
> for example, after i_size_read returned, there is no guarantee that
> inode->size won't be changed. Therefore, READ/WRITE_ONCE suffice, which
> is already implied by smp_load_acquire/smp_store_release.

Sorry, what?  The problem is not a _later_ change, it's getting the
upper and lower 32bit halves from different values.

Before: position is 0xffffffff
After: position is 0x100000000
The value that might be returned by your variant: 0x1ffffffff.

