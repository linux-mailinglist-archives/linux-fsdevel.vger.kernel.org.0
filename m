Return-Path: <linux-fsdevel+bounces-44511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A840A69F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E77E463CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 05:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB961EC014;
	Thu, 20 Mar 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0MDEI4JV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE794B665;
	Thu, 20 Mar 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742450253; cv=none; b=f+fgR9mjCyZ5WaX4lsOY2gqmrxeXSohtQtU7nYdsz0+IxYx6aYJwjtV6tGTyADc3GA9UNjBfRuP8rQ6VD6c8DfNNaDPqQ67syiRhn+mm2aEonNDMYGg76CuTA3TI38/5QPnr8+S7tVb/QhBxV8QKU4k+5XRPERYuuuNjFN1OhNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742450253; c=relaxed/simple;
	bh=pOT0b8q3m3RNHNYoWJiTM8hh9YfacaYpgKl/S1A4rAQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb1Y/DlHeWyqovyT1ahUmzHEmcevAmw+gMHv+H7k0FN4r3C5SwhCyF+rlI0VFawNKGwHIttoUPiCZW3zw7mFaEo5M18ERYMMucJouFC1tt6QJU4XKZw/A1rzZQS18LLl29zssTPK/rwGGnnEoOUcMKjTFdoIwN2x3nBV6G/HgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0MDEI4JV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=RZ3fQEbT9mvcfdUWKbxqUehLqBK4yxe6EScMLHKEND4=; b=0MDEI4JVq+f4Isn7dudUNf2sL3
	yfp/Vxiu3CN9jWIL4jaaZxg7jIcHh6PioXn9qjG+fjTWTkVI2hCFgc8Jmgy9wKUbFi2Bjquq4acjN
	/VSoQ1LkYFafDoTGW76M2FC0HxPR2WCV+vy+lIpjuUsgAQ+tjxb7rcjmGIAR2OP7mLnRGkG7pfxud
	4meDPogXRxxvcYnpbRpU7uSY10YG4wETStvAMH5JTGbrPLx9cZQF5HLQ/vuFSG/2iKYS+wxI+6EEH
	2Vuxz191y4atjC/JYQc53ilRniq6r1ndT+FddolgQB6FfeNAIYdzFyZVTlcUvQFRFFmc5gOsQc713
	zfuk8aHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tv8uH-0000000BGY1-1Xfp;
	Thu, 20 Mar 2025 05:57:29 +0000
Date: Wed, 19 Mar 2025 22:57:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joe Damato <jdamato@fastly.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9uuSQ7SrigAsLmt@infradead.org>
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 19, 2025 at 10:45:22AM -0700, Joe Damato wrote:
> I don't disagree; I just don't know if app developers:
>   a.) know that this is possible to do, and
>   b.) know how to do it

So if you don't know that why do you even do the work?

> In general: it does seem a bit odd to me that there isn't a safe
> sendfile syscall in Linux that uses existing completion notification
> mechanisms.

Agreed.  Where the existing notification mechanism is called io_uring.

> Of course, I certainly agree that the error queue is a work around.
> But it works, app use it, and its fairly well known. I don't see any
> reason, other than historical context, why sendmsg can use this
> mechanism, splice can, but sendfile shouldn't?

Because sendmsg should never have done that it certainly should not
spread beyond purely socket specific syscalls.

> If you feel very strongly that this cannot be merged without
> dropping sendfile2 and only plumbing this through for splice, then
> I'll drop the sendfile2 syscall when I submit officially (probably
> next week?).

Splice should also not do "error queue notifications".  Nothing
new and certainly nothing outside of net/ should.

> I do feel pretty strongly that it's more likely apps would use
> sendfile2 and we'd have safer apps out in the wild. But, I could be
> wrong.

A purely synchronous sendfile that is safe is a good thing.  Spreading
non-standard out of band notifications is not.  How to build that
safe sendmsg is a good question, and a sendmsg2 might be a sane
option for that.  The important thing is that the underlying code
should use iocbs and ki_complete to notify I/O completion so that
all the existing infrastucture like io_uring and in-kernel callers
can reuse this.

Note that this also ties into the currently broken memory mamangement
in the networking code that directly messeѕ with page references
rather than notifying the caller about I/O completion.


