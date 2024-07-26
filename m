Return-Path: <linux-fsdevel+bounces-24337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016593D75F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 19:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA037B22921
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B317CA0E;
	Fri, 26 Jul 2024 17:14:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023121364;
	Fri, 26 Jul 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014045; cv=none; b=LnXTMGy8bfOhtYE5Fgu2DmAH+0+xSAn28OObaxZnJHo24eicW7XVPs0JqToSEHIdrNDQO+Uu3f8mMBJxKibnMkr30Bj2yluga6RAyeW9ipDMpVnaONdR8sUd0FC+3zUtAwj42CuMvu4I/Fi3JPqLSd4UhZUUHi0tyYfHvHR25iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014045; c=relaxed/simple;
	bh=vnaGRt35OXW8GrcOhfdqhoDi2Phsfws9fRC2hdplJOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/TEAaO2ZA4Rxq/YY/JcFCESw6bl8RzuI+0MgY2M4WmSNFjJZlNMP+XwK7+B+yS66UpL7CsE7l7vSA16OZj7RlK1JMS1+1ko+HF8VLmL/7Kqf7+8obhCS79R8vOKfMG9kkV+zncjxxd3ZkOzfCPm8lWhVrhPMKZutmxkSFIfMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C3AA68B05; Fri, 26 Jul 2024 19:13:59 +0200 (CEST)
Date: Fri, 26 Jul 2024 19:13:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, djwong@kernel.org, hch@lst.de,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
Message-ID: <20240726171358.GA27612@lst.de>
References: <20240429174746.2132161-1-john.g.garry@oracle.com> <20240429174746.2132161-15-john.g.garry@oracle.com> <ZjGVuBi6XeJYo4Ca@dread.disaster.area> <c8be257c-833f-4394-937d-eab515ad6996@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8be257c-833f-4394-937d-eab515ad6996@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 26, 2024 at 03:29:48PM +0100, John Garry wrote:
> I have been considering another approach to solve this problem.
>
> In this patch - as you know - we zero unwritten parts of a newly allocated 
> extent. This is so that when we later issue an atomic write, we would not 
> have the problem of unwritten extents and how the iomap iterator will 
> create multiple BIOs (which is not permitted).
>
> How about an alternate approach like this:
> - no sub-extent zeroing
> - iomap iter is changed to allocate a single BIO for an atomic write in 
> first iteration
> - each iomap extent iteration appends data to that same BIO
> - when finished iterating, we submit the BIO
>
> Obviously that will mean many changes to the iomap bio iterator, but is 
> quite self-contained.

Yes, I also suggested that during the zeroing fix discussion.  There
is generally no good reason to start a new direct I/O bio if the
write is contiguous on disk and only the state of the srcmap is different.
This will also be a big win for COW / out of place overwrites.


