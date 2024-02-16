Return-Path: <linux-fsdevel+bounces-11852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCE857FF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0B01C2286F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82912F37D;
	Fri, 16 Feb 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEs10Isc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCEE12C7FB;
	Fri, 16 Feb 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095612; cv=none; b=htJqSqYSKKzxOlmDgLMbKfvHnVgPTtPvUfbrTw6K5yNez9J6lhphGvVPjdG0Hh9R8ABFEHG4wqUjlVBUwkzFV4vv2H8FKRTM3/z7vkxmQiFTU9IcHk757FVy0PCh4kscqk5Xqpruwihnq4Vc5s/ymQhtZ+pQZExripLJF1HSy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095612; c=relaxed/simple;
	bh=+cWAZxpSFep8B0Wq/lAPfRCDdbxlm6btFXbzrYKlamo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3QRGQ0pDgB4YLRnC9k5oqupEl57F8kROB8uLtkEesJ1MD+IujdXlPulIzuLj+5rWJW+CJMTB3z2OZUxKBf+urfPO1+rEj5kIPNIXoezWvJZkRDlNLtxamwmM+T04jR8cI3uLuDKMEER3B25kQe5Tn9N8HBTqQbm6blMxuKAjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEs10Isc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893B7C433F1;
	Fri, 16 Feb 2024 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708095611;
	bh=+cWAZxpSFep8B0Wq/lAPfRCDdbxlm6btFXbzrYKlamo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEs10IscE+qqcyyAOYVPf1zSxqC1p2TIrXSjp8KSLvDBO3izQM4fFDzLbtcIEfCCt
	 3IjDH3QoZqxR6FfNz5IG6juAOKW2xcpaaFpJayXo8L5vGK9oAXNGqLTZbfr+jg7jB1
	 lIhDO74RBjBrdX521CTB0ytOWZ3t79PjKrEk2Pjh8vfMXJxiXGvdAa/0jwk6y9yFwD
	 itmE5kW0GDu2r1hsvWw7HlGSI5LB3uM7RnmJl3uhC4P6NxOnh1SuEliUW7FLoC3hoi
	 tJJf61lIB7EkTjCD64N872x5LBTf7T7fNV0zRPBRqpPzSjzQe5zg/lkw79ds5yq+kp
	 5U2/p+o7TJalw==
Date: Fri, 16 Feb 2024 16:00:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>, 
	Sandeep Dhavale <dhavale@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Message-ID: <20240216-kannen-spanplatten-e08999ebb884@brauner>
References: <20240208215518.1361570-1-bvanassche@acm.org>
 <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
 <20240209-katapultieren-lastkraftwagen-d28bbc0a92b2@brauner>
 <9a7294ef-6812-43bb-af50-a2b4659f2d15@kernel.dk>
 <4e47c7d4-ece3-4b8e-a4df-80d212f673fb@acm.org>
 <3304d956-9273-4701-91ce-08248ffd5007@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3304d956-9273-4701-91ce-08248ffd5007@acm.org>

On Tue, Feb 13, 2024 at 01:01:51PM -0800, Bart Van Assche wrote:
> On 2/12/24 11:28, Bart Van Assche wrote:
> > On 2/9/24 10:12, Jens Axboe wrote:
> > > Greg, can you elaborate on how useful cancel is for gadgets? Is it one
> > > of those things that was wired up "just because", or does it have
> > > actually useful cases?
> > 
> > I found two use cases in the Android Open Source Project and have submitted
> > CLs that request to remove the io_cancel() calls from that code. Although I
> > think I understand why these calls were added, the race conditions that
> > these io_cancel() calls try to address cannot be addressed completely by
> > calling io_cancel().
> 
> (replying to my own e-mail) The adb daemon (adbd) maintainers asked me to
> preserve the I/O cancellation code in adbd because it was introduced recently
> in that code to fix an important bug. Does everyone agree with the approach of
> the untested patches below?

But I mean, the cancellation code has seemingly been broken since
forever according to your patch description. So their fix which relies
on it actually fixes nothing? And they seemingly didn't notice until you
told them that it's broken. Can we get a link to that stuff, please?

Btw, you should probably provide that context in your patch series you
sent that Christoph and I responded too. Because I just stumbled upon
this here and it provided context I was missing.

