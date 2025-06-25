Return-Path: <linux-fsdevel+bounces-52897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F0AE80DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9553ADDD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A222BEC2D;
	Wed, 25 Jun 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pbwrmppk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FE25A330;
	Wed, 25 Jun 2025 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850481; cv=none; b=d90bQAK7hPl2g+VS3gA7VUxlGqOk0sHI5FzcRD7wxuedOBAHKrqicTJKN/MBnijosRXtmEBtRfAWAlQTo7UNC5qK8dr0f7VNbYagdDHIiW7vTkwSuA1DchqHhsLZq7VqcoCfSJKi7d1oQ05SGUvmLTVWYB/0hA56FEhvEJxbVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850481; c=relaxed/simple;
	bh=6Vy7PG/zEKbxsvh7nCqKQoOgntlDs/g+Sa2/Me1gaFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCrW4IYUoExeL2zhQhoQq6gpX2Ey5KMkrPFMJeNmsjLg0oY1Ax5H2p6bkaci1J4+P4wQulXJmG0QFUF0BegU8exLsEh3ZOIUKNlEvhRtOXV7XfUgU7eApymDlyiL2VyiKD4aou3i9jQ7nCPUsQf5YCaRwuy/uqgEMVgEm1O4yUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pbwrmppk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H3jZX8kZWqx43TyOytjAFy8Zh+sFkOgP5LW+PDWuOQQ=; b=Pbwrmppkhilj7WqCSjG2WuUAkF
	Q9XnJh2XAGJF/CNnIkoY9Z1nRVoUF6y8YBx9U+EkrTfdL6u/Sjd2iQIlucU3k1U0XxYBpCmJKmccJ
	AhGm9DzLA9QLZNY0QLnArxOSwILwiW3hSrPKnMfRfMBMBK0FCTw/BqRSyTk/Q8dwqGKqZzIEfjHHP
	NARNKSzI9mU0jdKcx1o8+sKQOxiJ5JUTPh04f7pTXFY8mOflSKK6Q7TkcSYQyPlwW5zxmPjrxgvXG
	vWRE0ndX/HsY7a7lr4DV0nPlVhG8iiNVSNLMvIqbLySQLw9nNXty0cTCUzgX97IZYZcWBl2+9FPPu
	79elbm6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOBr-00000008SBj-1Bay;
	Wed, 25 Jun 2025 11:21:19 +0000
Date: Wed, 25 Jun 2025 04:21:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>, david@fromorbit.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	yc1082463@gmail.com
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aFvbr6H3WUyix2fR@infradead.org>
References: <aFqyyUk9lO5mSguL@infradead.org>
 <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
 <aFuezjrRG4L5dumV@infradead.org>
 <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 25, 2025 at 06:40:07AM -0400, Jeff Layton wrote:
> Another option:
> 
> We could expose this functionality in preadv2() with a new RWF_WBERR
> flag (better names welcome). That way applications could opt-in to
> checking for writeback errors like this. With that, the application is
> at least explicitly saying that it wants this behavior.

That sounds like a really strange interface to me.

I have to admit I don't fully understand the use case where an
application cares about these errors, but also doesn't use f(data)sync
or sync(fs) to actually persist the data.  If we can come up with a
coherent use case for that we should simply add a new syscall or fcntl
to query the delayed writeback errors instead of overloading other
interfaces.

