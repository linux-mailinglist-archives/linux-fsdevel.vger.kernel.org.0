Return-Path: <linux-fsdevel+bounces-66862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17923C2E4F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 23:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E92A3B93B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090852FC005;
	Mon,  3 Nov 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKXMJ/Ec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF91A9F82;
	Mon,  3 Nov 2025 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210034; cv=none; b=fwYS6T4t01jymCasqv/VZutYy0ldycdZK9GDcKXyzX66yDNSrmSDnMt5ZIxgFStDRscCWlJl0VpCZ4fyz8InnGDRiGiwvvKSGq8lGjpFBRNOyjSqsPMNw9l2QKzXx1jP1Si2Hf8xG6v0w7Mw4EF1UWfA64Yd5mKHapgXIYyiFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210034; c=relaxed/simple;
	bh=vzcjcZ/KzE5MpIcBsK7RTULC/BX++/fNaI56/t7f19g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfpQKvwjZ+RnG+93QG8h9jzTk7fFK/0uHnQwOEC7biY/C04b5DDy9ilQshmDi2+9PGoJMs9iC1HQCVuvRgPgu8IvFhy0hcctDO/do/pXvV3IzKXCKjnukzbePba91WaB+WCxUgTy9W33rJAaWxSAwfRGFwF5uZVVwUSb+tA46dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKXMJ/Ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E436C4CEE7;
	Mon,  3 Nov 2025 22:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762210033;
	bh=vzcjcZ/KzE5MpIcBsK7RTULC/BX++/fNaI56/t7f19g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKXMJ/Ec48ilrcgKvTG5GjgA5Z6I2mEPDZv3qtg5HhqKnAHiccABnQUzmRdyMaZCu
	 hFjYLCQGqBJzqbKrqRsUiRuQ+0kshhLEduF5rRRAUbkSt2Z4OkDuJxEBusN8X4pKXt
	 8FVTCg1ox+IrXozkewp4toraYgU0zItF8xFQfH4hGKx7wmq22kKuCdhM3x6/DsFWEe
	 GY0Bnk2cWlL7r/RqYtZIJFpebDk5XnJdWE79KOuVk4bTIJvP3Lk/I2wWaKCcQsDtet
	 LsdPNc/Ss0XvbsocywYxO+ZdzBnkdooEVdSAq7wnkLlMCkUMlKUcSbU5FLFr8oY2jJ
	 Vz3aZTmotFj7g==
Date: Mon, 3 Nov 2025 15:47:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aQkw75D2cqqtkOrT@kbusch-mbp>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de>
 <aQPyVtkvTg4W1nyz@dread.disaster.area>
 <20251031130050.GA15719@lst.de>
 <aQTcb-0VtWLx6ghD@kbusch-mbp>
 <20251031164701.GA27481@lst.de>
 <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
 <20251103122111.GA17600@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103122111.GA17600@lst.de>

On Mon, Nov 03, 2025 at 01:21:11PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 12:14:06PM +0100, Jan Kara wrote:
> > > Yes, it's pretty clear that the result in non-deterministic in what you
> > > get.  But that result still does not result in corruption, because
> > > there is a clear boundary ( either the sector size, or for NVMe
> > > optionally even a larger bodunary) that designates the atomicy boundary.
> > 
> > Well, is that boundary really guaranteed? I mean if you modify the buffer
> > under IO couldn't it happen that the DMA sees part of the sector new and
> > part of the sector old? I agree the window is small but I think the real
> > guarantee is architecture dependent and likely cacheline granularity or
> > something like that.
> 
> If you actually modify it: yes.  But I think Keith' argument was just
> about regular racing reads vs writes.

I was seeking documented behavior about concurrently modifying and
using any part of a host data buffer, so I look to storage specs. The
general guidance there aligns with "the reprecussions are your fault".
Linux DIO didn't say that, but I'm just saying there's precedence lower
down.

I'm not even sure how you handle the read side when multiple entities
are concurrently modifying the buffer. That has to be an application
bug even if bouncing it defeats the gaurd checks before the completion
overwrites the application's conflicting changes from the bounce buffer.

