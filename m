Return-Path: <linux-fsdevel+bounces-66610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25FEC263ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3EB465B74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5051B2FD68A;
	Fri, 31 Oct 2025 16:47:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2F2EC0A6;
	Fri, 31 Oct 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929234; cv=none; b=U1j3oF6lJdiEUHz6L4edeogus/E+fjY5iXTsZtHTB0UPl3RR7x3WLdD9ZBsGqZ+S6kH+1iwgnxnoJHs2H6ylhcmwQLPViQ2AI3urvQ2swlGEM+qyZal+wtXGXFA4AND/y3gqLmzXAJ3qGqer0sA7nF4mKpTx15MAoBnLFmIX8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929234; c=relaxed/simple;
	bh=jPOtm/oX35cB6by+NQMImwBjFg4VIUlrXBxb2qtL8sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8D8kCKoYrVkkBVLD8vH3/uZs520aShl9rrzcgwoXhU2w8EMkbSaV3mF2pvYEytlh38PCs9uEIoiKvmza9XprYlH1wdvSp77f1WpA/wr1aqoF4Sp2umMXBP2xHhbhzL5LnNZFCfYECcRFQ3scr3utLKlA5kyr0mHgU9ky7xkFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50316227A88; Fri, 31 Oct 2025 17:47:02 +0100 (CET)
Date: Fri, 31 Oct 2025 17:47:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251031164701.GA27481@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <aQNJ4iQ8vOiBQEW2@dread.disaster.area> <20251030143324.GA31550@lst.de> <aQPyVtkvTg4W1nyz@dread.disaster.area> <20251031130050.GA15719@lst.de> <aQTcb-0VtWLx6ghD@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQTcb-0VtWLx6ghD@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 09:57:35AM -0600, Keith Busch wrote:
> Not sure of any official statement to that effect, but storage in
> general always says the behavior of modifying data concurrently with
> in-flight operations on that data produces non-deterministic results.

Yes, it's pretty clear that the result in non-deterministic in what you
get.  But that result still does not result in corruption, because
there is a clear boundary ( either the sector size, or for NVMe
optionally even a larger bodunary) that designates the atomicy boundary.

> An
> application with such behavior sounds like a bug to me as I can't
> imagine anyone purposefully choosing to persist data with a random
> outcome. If PI is enabled, I think they'd rather get a deterministic
> guard check error so they know they did something with undefined
> behavior.

As long as your clearly define your transaction boundaries that
non-atomicy is not a problem per se.

> It's like having reads and writes to overlapping LBA and/or memory
> ranges concurrently outstanding. There's no guaranteed result there
> either; specs just say it's the host's responsibilty to not do that.

There is no guaranteed result as in an enforced ordering.  But there
is a pretty clear model that you get either the old or new at a
well defined boundary.

> The kernel doesn't stop an application from trying that on raw block
> direct-io, but I'd say that's an application bug.

If it corrupts other applications data as in the RAID case it's
pretty clearly not an application bug.  It's also pretty clear that
at least some applications (qemu and other VMs) have been doings this
for 20+ years.

