Return-Path: <linux-fsdevel+bounces-57792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3549B254E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 23:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4201C82DB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD62E2DC1;
	Wed, 13 Aug 2025 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu4s+og3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804A366;
	Wed, 13 Aug 2025 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118867; cv=none; b=bBFJ5z7BT+I6yKAZlVj1M6clfrgBWAZRLtRH1N+ayui21gK3CnI73rcnYkaGAG9/Y8ghpKaWs7PB5z9mg6Q5qO/JkyWA4OaeMw4uBTfFKkh3F+JVWw+Pp6kQW6M8w/cVD8lUXTUN3SqLRr/m0lvH49rGErOy3asrOHF/RiIlM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118867; c=relaxed/simple;
	bh=B5StP3b1sHXAZBZT9YN1bo+BioHUfmi8jf8ZsHJcLaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjFspFzpKkrMCeSWotJIVLB+ZmUost+BklKap5k0lM2QizHWUuGY74EGEjYpp9oaL+uyVyQT21WAUmorsrJ2SVoWa5Y25q2SWOO4FLt6gPgGfROIm4Y8OnYiG549lIrWZUyYjRGgVDUOYE8iEbGb66CScxfSn7vLGEk3fKPC29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu4s+og3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0CFC4CEEB;
	Wed, 13 Aug 2025 21:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755118867;
	bh=B5StP3b1sHXAZBZT9YN1bo+BioHUfmi8jf8ZsHJcLaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fu4s+og3J4Aui5TFCEz6OF3/N+eZz7W8Mwh3V7QQQdKhYEmXuxs5w1/dz/lUEXHi/
	 33LDHc1Bz1wYFuXgihIsUbpupCFVY/MHD6dlzMZJXw5bQzBVqbeWCf4WstL8Jg4wRO
	 10Q726enDsY9r1zQoQ4lQTwxavM9yJ8Mwj5749aYKeM1g9vhr1CbLAvyS+CQ835ccX
	 yc+3St5y9aPr8i0ClAYUcj1AF+Oz/y3hTNUils1YqmkWDU0QYZzJJ4hT7LCkDkP05M
	 iTmrTsSd81RVppwOeOYAkkRd//EtyyJyl/fa0I/VGWejOeASsldMMLzS+jwZuPTasf
	 pGDsSKTOPxg7Q==
Date: Wed, 13 Aug 2025 15:01:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
Message-ID: <aJz9EUxTutWLxQmk@kbusch-mbp>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com>
 <aJzwO9dYeBQAHnCC@kbusch-mbp>
 <d9116c88-4098-46a7-8cbc-c900576a5da3@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9116c88-4098-46a7-8cbc-c900576a5da3@acm.org>

On Wed, Aug 13, 2025 at 01:41:49PM -0700, Bart Van Assche wrote:
> On 8/13/25 1:06 PM, Keith Busch wrote:
> > But I can't make that change because many scsi devices don't set the dma
> > alignment and get the default 511 value. This is fine for the memory
> > address offset, but the lengths sent for various inquriy commands are
> > much smaller, like 4 and 32 byte lengths. That length wouldn't pass the
> > dma alignment granularity, so I think the default value is far too
> > conservative. Does the address start size need to be a different limit
> > than minimum length? I feel like they should be the same, but maybe
> > that's just an nvme thing.
> 
> Hi Keith,
> 
> Maybe I misunderstood your question. It seems to me that the SCSI core
> sets the DMA alignment by default to four bytes. From
> drivers/scsi/hosts.c:

Thanks, I think you got my meaning. 

I'm using the AHCI driver. It looks like ata_scsi_dev_config() overrides
the dma_alignment to sector_size - 1, and that pattern goes way back,
almost 20 years ago, so maybe I can't change it.

