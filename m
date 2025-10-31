Return-Path: <linux-fsdevel+bounces-66602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A730C25F57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25DD1B22C41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF20E2E8894;
	Fri, 31 Oct 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoQ1cxH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318832EAB61;
	Fri, 31 Oct 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926258; cv=none; b=c1IcXotNz52+yWgq/P+c9TPsl+nD9Ye0D1Tl0hmDeyR5aRsfk+Tk5KLnyv4MjDMIJEGtMQIap+zxih+cT4djooHPTBAgTz0WD7hiNJ6iU8MQpaA1BiwUnHY4cE8TuZpik53r5LCzbUe7na8V11Mwkr/pi0ipBnDnzKK4kMIDFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926258; c=relaxed/simple;
	bh=7vOOCPUn+sRDAtiN3PBAow6khkmIMlLpIWRfEgzH2l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbEhTrF/NGlD8naNxTYkv8QsnE6HCXsTNmgx/2ggSUTsrwcyxjOkY3PluWGLjdzF+3+egdfLUsbm65jHXlwTooMiG7Yf0WmSn4pN2SccaWEgAJfeTf2iPceHKOGOifaebBpgedbw/cpd0QjkyoyJig8KESek2ROTHTYlWlLGFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoQ1cxH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24441C4CEE7;
	Fri, 31 Oct 2025 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761926257;
	bh=7vOOCPUn+sRDAtiN3PBAow6khkmIMlLpIWRfEgzH2l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CoQ1cxH5nn62XVYZNwBAVJ5Twau7QqRh6ICNXwt4KOeBcxeUARlNDPs0iRHuTftOE
	 /kUXCHz776FA5YODBQfgW259HtLERHSfkBZqgwGo3nulEgnPfwXn+VQjOCeHFWfmXs
	 Zg0wTr95shwjkbpzsodLXUITOxbCaQG4+XW/NXogYFJar5nSjWz4oLlfo4gzTHdPEm
	 xyNTiyrnbNjqnzh+5mvPv2ZA4ROwoYjLvTPORCOqgB0mB+mrx2/3JcCWOknvxTztcd
	 CixgGeL7AAupqiwNAavfq/oPYh834CaIOCEdC0a27xKGxNTyqTynTjS0AT7xfxkXdn
	 6e5R1Vubs/meA==
Date: Fri, 31 Oct 2025 09:57:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aQTcb-0VtWLx6ghD@kbusch-mbp>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de>
 <aQPyVtkvTg4W1nyz@dread.disaster.area>
 <20251031130050.GA15719@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031130050.GA15719@lst.de>

On Fri, Oct 31, 2025 at 02:00:50PM +0100, Christoph Hellwig wrote:
> On Fri, Oct 31, 2025 at 10:18:46AM +1100, Dave Chinner wrote:
> 
> > Modifying an IO buffer whilst a DIO is in flight on that buffer has
> > -always- been an application bug.
> 
> Says who?

Not sure of any official statement to that effect, but storage in
general always says the behavior of modifying data concurrently with
in-flight operations on that data produces non-deterministic results. An
application with such behavior sounds like a bug to me as I can't
imagine anyone purposefully choosing to persist data with a random
outcome. If PI is enabled, I think they'd rather get a deterministic
guard check error so they know they did something with undefined
behavior.

It's like having reads and writes to overlapping LBA and/or memory
ranges concurrently outstanding. There's no guaranteed result there
either; specs just say it's the host's responsibilty to not do that.
The kernel doesn't stop an application from trying that on raw block
direct-io, but I'd say that's an application bug.

