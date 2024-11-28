Return-Path: <linux-fsdevel+bounces-36042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8AD9DB21E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4934281A24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 04:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3D13A3F3;
	Thu, 28 Nov 2024 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pDqOYNRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014B45025;
	Thu, 28 Nov 2024 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767759; cv=none; b=F+KwvV+/UIXGfQO1HFlq7Y8f6BvqvYkywmX4wLaHZz35NPlb0z3iU3acScYYRW73z9oro1BRMwTwWLNF4aWUA0TdWYFo/Q1JX5jcN7VtWJhtCqVRnuxlL7d4Knde84G3AHFTqNDcGxDklPxsZNlZthavKqusi+lnoWCSwP8Gjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767759; c=relaxed/simple;
	bh=TSd7FeSt6bVtKyO80TLyfiB9lU8WkUk6mtifnZqOFjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJSbYh6mIdk5fvaHC3ZSrO11dobze4rDofLnYA/7mUisCDWKbyrDp+3PODajXU89uz3MHEo60c4H+RuJes+Yg9VFsuXVpxulOPtFp3CWg/ACVWxtBhmmK1H5tfwLgA8ZHkXvBQesuzDhlDcI+7xhH7vk4V0ggndujRsPf65s3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pDqOYNRb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kphv4/yVKW1LfSI92pcNP8tujyuMuQa1i79yLRRZvZM=; b=pDqOYNRbAzs/QQ1J6MF9/a2k/p
	cCTbVbjhe6mBpSwa7RBwGBJQu8Cs1CPhFVAhb/W7u2QG1iv2urQM8UKtnLwpMtpcegara3QEmUkvy
	Hd9gXBBhheHzqaiX5O4uN/K+4y8zjJ4kPkJz0aj5/3Xvz4qmwuWAAa/oI8TWOI5jwyHXW1djO+ExJ
	ENvVJpvsmv9OkyOOACdw3YQsZaZZymzlfFFliwjyiphEEXaXAcncFIxaoIEKEnY0d1HTo5UkVt1+j
	DHx6lKWZ1tETTD5zNMBJ1J0a9Ar3Gm+WMnAZ+XDU1R+p8TWEBKjfaaoiK8zwGqhKYc6IiHHKt3UeK
	y8khfkOA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGW2y-00000002B5Z-2wSj;
	Thu, 28 Nov 2024 04:22:32 +0000
Date: Thu, 28 Nov 2024 04:22:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bharata B Rao <bharata@amd.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, nikunj@amd.com, vbabka@suse.cz,
	david@redhat.com, akpm@linux-foundation.org, yuzhao@google.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, joshdon@google.com, clm@meta.com
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
Message-ID: <Z0fwCFCKD6lZVGg7@casper.infradead.org>
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
 <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>

On Thu, Nov 28, 2024 at 09:31:50AM +0530, Bharata B Rao wrote:
> However a point of concern is that FIO bandwidth comes down drastically
> after the change.
> 
> 		default				inode_lock-fix
> rw=30%
> Instance 1	r=55.7GiB/s,w=23.9GiB/s		r=9616MiB/s,w=4121MiB/s
> Instance 2	r=38.5GiB/s,w=16.5GiB/s		r=8482MiB/s,w=3635MiB/s
> Instance 3	r=37.5GiB/s,w=16.1GiB/s		r=8609MiB/s,w=3690MiB/s
> Instance 4	r=37.4GiB/s,w=16.0GiB/s		r=8486MiB/s,w=3637MiB/s

Something this dramatic usually only happens when you enable a debugging
option.  Can you recheck that you're running both A and B with the same
debugging options both compiled in, and enabled?

