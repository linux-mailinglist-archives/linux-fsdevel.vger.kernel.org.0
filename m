Return-Path: <linux-fsdevel+bounces-12830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2E867BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB88DB32747
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8D12C807;
	Mon, 26 Feb 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LQQ3nBpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01A12A14A;
	Mon, 26 Feb 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962833; cv=none; b=Q+qjIYpGQ5Kt2JoscQseZWwogyY+RPtjxxuIXhgzX1ZRGrqX6ZmQ/p5hEdFbfGv86Vh0E3Zpn543egR5fzzIyRjY8+2ooeut1/ArS6a+ka4E+W6CXC0n1lXIFQRvUahzN+qnTaBq37Ma3Zji5M63pd5CK1uXsNXXndMqs5o7vrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962833; c=relaxed/simple;
	bh=OhS4vDw10qcJb+eT/2xNrJGDLexPIJn56JWLFV7mSLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0mBcZ8WOcpABAJmRw7BIeYW0I3l34rxRbstsNIWQzWRsPOJgRNsnSuH+eqKXwzaouEz7NA4YEK+stXpACwnj7EZTqEToNPOhuw9i4/yniTuk+EIpJ7tNkQsAHRf3p/BjPUHyV+8/vZWTVdYw/+GUGZGyIX/MKSI0Ed/uOGHfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LQQ3nBpP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4th8cNSX4xav3thjL9AsP3JA1usOiTW53dcNZF3hTUE=; b=LQQ3nBpPyY7lmm0uyX6l5q7O7y
	9LIXCw8oRW15B6dslBF1PJxG1kiFvAd9Gm8xBShVpBpeZn5dOdLQlYb3/Q9fndSZv25r+jsjnIyyA
	W7EMn8fysavG5a8WcWh5C4JIl4SaZqCiuI426x9gqJZYDWOUWXpd2jtqq9vHEkXis9GF+DtB7rsSm
	Sm9wfspkbv/EmBcQXKm5/MrOTxu2+IATM9OtN6CGrIRCHIFt+ordidJDqo7XFCap3nN0DWTKkym1o
	6SQTWQS1LiJVaxZBLU97fHt7scS8jlua7IHk10+S+wakCz4KGqL3iAg/1TXh7gOW22gc/pfVnJaHs
	vcpzEf9w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redIW-00000001WNL-0Rf1;
	Mon, 26 Feb 2024 15:53:44 +0000
Date: Mon, 26 Feb 2024 07:53:44 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Groves <John@groves.net>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	john@jagalactic.com, Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com,
	gregory.price@memverge.com
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <Zdy0CGL6e0ri8LiC@bombadil.infradead.org>
References: <cover.1708709155.git.john@groves.net>
 <ZdkzJM6sze-p3EWP@bombadil.infradead.org>
 <cc2pabb3szzpm5jxxeku276csqu5vwqgzitkwevfluagx7akiv@h45faer5zpru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2pabb3szzpm5jxxeku276csqu5vwqgzitkwevfluagx7akiv@h45faer5zpru>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 26, 2024 at 07:27:18AM -0600, John Groves wrote:
> Run status group 0 (all jobs):
>   WRITE: bw=29.6GiB/s (31.8GB/s), 29.6GiB/s-29.6GiB/s (31.8GB/s-31.8GB/s), io=44.7GiB (48.0GB), run=1511-1511msec

> This is run on an xfs file system on a SATA ssd.

To compare more closer apples to apples, wouldn't it make more sense
to try this with XFS on pmem (with fio -direct=1)?

  Luis

