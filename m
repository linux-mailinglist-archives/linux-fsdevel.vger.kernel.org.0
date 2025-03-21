Return-Path: <linux-fsdevel+bounces-44676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD93A6B42D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C6F17E901
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C41EA7D7;
	Fri, 21 Mar 2025 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rtEvPPct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E033F6;
	Fri, 21 Mar 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536579; cv=none; b=femxJQwuo224gZ5Jh+5Hot2pMlbfM76x+pQPMO8I7yJTaPmD+Wzes3ZQNdgH6eSVYXyY/tiLJmRMoqjk9vywP2Fom0Zm8C3eQj7Pe/RL2XpkBLhhDSUijher4mhmo3Sfs8NUOOuQ2I5gnGHBh5dxABih8l6D/nsrNKjLl4XSKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536579; c=relaxed/simple;
	bh=rakOtM9qjCQHkqBpgJGi83hrWXwvmBdKuX7OU7VwvKc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ/Ccn8/O9uv7IU02iD+qjogQmEdhn8WJUj6Y73LcALGTBhVRsF1fjCImRd0cGe2vqJSGqwNQRWcMbJAJX+9fVaYo1c7UoslmgIypLlckSUUKGonTcteUAgACJ5rT3P/EOAsrdpVVNPI2HBykVWltHL+uhU6qCk6dh4ILrAGamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rtEvPPct; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4b1rZoFjUmC82SICohDGJF5TYEnTu/ZO1nB8POqr7Q0=; b=rtEvPPctHs4DFbvPx/CFLoyoym
	6shRxW1IEni3BZVrGEpigNTI4fFOotZtAwTzg7t3/heKPPgWop8SQgg8ayjoSHdZKuc21WHScvUlY
	DOacoBbESG0gjX1w9ySCeVX/fRv+0YXIMtQuzFUuMVT6y1NsbK59hYbVFFnS2R6/X7kEAgNbnAm8M
	d/qjZun2Kfpxi/TWhJTu30swVFU8UXKiZnDH5cib3qyqPaKVZETBMKR6mnUr5+7AzzkVtS0Jghu4y
	9e8GMKlGu1NoqqmHBw4RFC1Hn+f33autaSrS+5JkBAmynbDc8GF3PNeIvCwxJSJH4ffQ8CzqDDv9C
	Lw+g9dEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVMd-0000000DvYO-33Wf;
	Fri, 21 Mar 2025 05:56:15 +0000
Date: Thu, 20 Mar 2025 22:56:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9z_f-kR0lBx8P_9@infradead.org>
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 20, 2025 at 11:23:57AM -0700, Joe Damato wrote:
> In my other message to Jens I proposed:
>   - SPLICE_F_ZC for splice to generate zc completion notifications
>     to the error queue
>   - Modifying sendfile so that if SO_ZEROCOPY (which already exists)
>     is set on a network socket, zc completion notifications are
>     generated.
> 
> In both cases no new system call is needed and both splice and
> sendfile become safer to use. 
> 
> At some point in the future a mechanism built on top of iouring
> introduced as new system calls (sendmsg2, sendfile2, splice2, etc)
> can be built.

I strongly disagree with this.  This is spreading the broken
SO_ZEROCOPY to futher places outside the pure networking realm.  Don't
do that.

It also doesn't help that more than 7 years after adding it,
SO_ZEROCOPY is still completely undocumented.

> > Because sendmsg should never have done that it certainly should not
> > spread beyond purely socket specific syscalls.
> 
> I don't know the entire historical context, but I presume sendmsg
> did that because there was no other mechanism at the time.

At least aio had been around for about 15 years at the point, but
networking folks tend to be pretty insular and reinvent things.

> It seems like Jens suggested that plumbing this through for splice
> was a possibility, but sounds like you disagree.

Yes, very strongly.

> As mentioned above and in other messages, it seems like it is
> possible to improve the networking parts of splice (and therefore
> sendfile) to make them safer to use without introducing a new system
> call.
> 
> Are you saying that you are against doing that, even if the code is
> network specific (but lives in fs/)?

Yes.

Please take the work and integrate it with the kiocb-based system
we use for all other in-kernel I/O that needs completion notifications
and which makes it trivial to integate with io_uring instead of
spreading an imcompatible and inferior event system.

