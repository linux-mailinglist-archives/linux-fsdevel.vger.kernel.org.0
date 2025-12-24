Return-Path: <linux-fsdevel+bounces-72076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF45CDD12C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20EA3021E48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0970E327211;
	Wed, 24 Dec 2025 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovuTug+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7981B4F0A;
	Wed, 24 Dec 2025 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766611280; cv=none; b=tW5GwbnWKj5STWaXoPxJN5B+vDIzEKBuizmtRK7kvCcubiN9lPSwVHXcvoiUJqJTI4ft4+tY5zKjUoAmtBjQio80e8c55GozH8+geySEOcyYBW/AN7+oDwMulF4zRDS7CL29gGkT0bwIYfiD2hD3Cp+D2sNPnNow960g7KDRjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766611280; c=relaxed/simple;
	bh=Hg0mhI4uHb2T9/lp6HFQYCRHVwUiYLmCQTTMqg4IWtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpcns3ALB/ofdkA6gt7I++2sTqS3KlLU7W7zWFI1/qLHuj29QIRrAlkJdxhnnp8U6X1MBod1skmG4MIhh3JwwA+wj5GqDqaTNGoWz2Y/CK9HWTwbp+nf0RL3KZXj1mxI2vUyFCOx6OA6vQBot+EF/co+16hTg4lnYTKT1kGBC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovuTug+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90321C4CEF7;
	Wed, 24 Dec 2025 21:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766611279;
	bh=Hg0mhI4uHb2T9/lp6HFQYCRHVwUiYLmCQTTMqg4IWtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovuTug+3ciklnXcPCWnmRzqSTJw9XLl7WYjyTPFtneR1CBAekh/z0yuXonyjm2tlf
	 o6TXEbvfx4+V1yCrwSH5JjLZlkObbxQ+mn4IfgqNlW3I+CBCrFw8BPrf6dT1mHRtw8
	 VZ4ovrsC4vmg4fkZO5bA3busWhCLx89YZltyvydhD9YpOOluMb1ThAJtkyqTiqqjLC
	 XdOxGlaA4vQJrE8xvDyYHlqZ9xeKV23AbmO3eZfMSodlXTfAaZNGVIXzbmZP2ALA00
	 fZ4IEJmFFkm6n6OOoZmmMTq+yUTleaWjDWBRj1sVpQ40p6fIzA/XJPCQniw7+DY1QA
	 /fTLDTGc2I4Yw==
Date: Wed, 24 Dec 2025 16:21:18 -0500
From: Sasha Levin <sashal@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aUxZTvH46FE9Q6qr@laps>
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org>
 <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtLi37WQR07rJeS@casper.infradead.org>
 <aUwKPtahCaMipU83@laps>
 <aUwiZ0Rurc8_aUnW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aUwiZ0Rurc8_aUnW@casper.infradead.org>

On Wed, Dec 24, 2025 at 05:27:03PM +0000, Matthew Wilcox wrote:
>On Wed, Dec 24, 2025 at 10:43:58AM -0500, Sasha Levin wrote:
>> On Wed, Dec 24, 2025 at 02:10:19AM +0000, Matthew Wilcox wrote:
>> > So Sasha has produced a very convincingly worded writeup that's
>> > hallucinated.
>>
>> And spent a few hours trying to figure it out so I could unblock testing, but
>> sure - thanks.
>
>When you produce a convincingly worded writeup that's utterly wrong,
>and have a reputation for using AI, that's the kind of reaction you're
>going to get.

A rude and unprofessional one?

>> Here's the full log:
>> https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.18-rc7-13806-gb927546677c8/testrun/30618654/suite/log-parser-test/test/exception-warning-fsiomapbuffered-io-at-ifs_free/log
>> , happy to test any patches you might have.
>
>That's actually much more helpful because it removes your incorrect
>assumptions about what's going on.
>
> WARNING: fs/iomap/buffered-io.c:254 at ifs_free+0x130/0x148, CPU#0: msync04/406
>
>That's this one:
>
>        WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=
>                        folio_test_uptodate(folio));
>
>which would be fully explained by fuse calling folio_clear_uptodate()
>in fuse_send_write_pages().  I have come to believe that allowing
>filesystems to call folio_clear_uptodate() is just dangerous.  It
>causes assertions to fire all over the place (eg if the page is mapped
>into memory, the MM contains assertions that it must be uptodate).
>
>So I think the first step is simply to delete the folio_clear_uptodate()
>calls in fuse:

[snip]

Here's the log of a run with the change you've provided applied: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.18-rc7-13807-g26a15474eb13/testrun/30620754/suite/log-parser-test/test/exception-warning-fsiomapbuffered-io-at-ifs_free/log

-- 
Thanks,
Sasha

