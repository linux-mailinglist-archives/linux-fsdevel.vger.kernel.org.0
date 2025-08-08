Return-Path: <linux-fsdevel+bounces-57083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1650BB1E98B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633821C23240
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36F31487E9;
	Fri,  8 Aug 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldLbuBxl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FAA1B7F4;
	Fri,  8 Aug 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661126; cv=none; b=UDvhbf3lcpxCHvY760K1Pe+ipI5bWiPGBN7flSUmriFthJJr4DzXXHeEDUu9BHsD0L81af+aavR1wtwU2+QzTFpFckRE342po7M+2YAnv8/yXo3J57QQzeOpoLjAeGfywJOeEA2nMnV+NNjKdus7vgBQh5nooQ4dtG486A1I7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661126; c=relaxed/simple;
	bh=+89FbzoXzbeBFvgwfAw8UlIb8w1o2l86DsH+uTjvG9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o79AjJdAVxOyWRT73OJI6ODOGJWmRZSHcDNjnyeTcfvww5qkdJyS3RHVrkUNYSCx+LzoJNvZQfoI9HEQV1dX1ysp5LetOCTcjkd68r4i+b68pEJmiPGDbuSABCu3L35ICdiE8oXf3mCHldJKjFvUw00oeGoklcyLIFr/7ZAtqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldLbuBxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88941C4CEED;
	Fri,  8 Aug 2025 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754661125;
	bh=+89FbzoXzbeBFvgwfAw8UlIb8w1o2l86DsH+uTjvG9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldLbuBxlhKi8JUBDf6G3L/Y+wnIU5DwrlHdrbWDdl5iMLBl04MWlZufA487rSlUPn
	 8FGYNe+44rTxfd1l7lbbYnUsK+jHPtr1bkWH09QNW1b7fSArFu+KHm5nqA9RXmfz/S
	 Pya7S/u5PWHaUznf79abzAsPBz4o7SyiIGEVh9riD4X8qEPueChLC7AKh4ODZTD1Th
	 iqcfLZLtjINdpqRWlWC2Inze+2+BcCSRXxS89RJlChiZoiexAgPIPnE3ZNjebk4ttb
	 SFsjc/b17vPCLU/tdYaw67pYibrl4ZB/kPDx4ITRfjSMtJYYgHIhRqDVIjUUglSRLO
	 KaRAwfNxc94cA==
Date: Fri, 8 Aug 2025 15:52:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fscontext: do not consume log entries when
 returning -EMSGSIZE
Message-ID: <20250808-notieren-abwaschen-cc01d21dd933@brauner>
References: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
 <20250807-fscontext-log-cleanups-v3-1-8d91d6242dc3@cyphar.com>
 <20250806190751.GG222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806190751.GG222315@ZenIV>

On Wed, Aug 06, 2025 at 08:07:51PM +0100, Al Viro wrote:
> On Thu, Aug 07, 2025 at 03:55:23AM +1000, Aleksa Sarai wrote:
> 
> > -		goto err_free;
> > -	ret = -EFAULT;
> > -	if (copy_to_user(_buf, p, n) != 0)
> > -		goto err_free;
> > +	if (copy_to_user(_buf, p, n))
> > +		n = -EFAULT;
> >  	ret = n;
> > -
> > -err_free:
> >  	if (need_free)
> >  		kfree(p);
> >  	return ret;
> 
> Minor nit: seeing that there's only one path to that return, I would
> rather turn it into
> 	return n;
> and dropped the assignment to ret a few lines above.  Anyway, that's
> trivially done when applying...
> 
> Anyway, who's carrying fscontext-related stuff this cycle?  I've got
> a short series in that area, but there won't be much from me around
> there - a plenty of tree-in-dcache stuff, quite a bit of mount-related
> work, etc., but not a lot around the options-parsing machinery.
> 
> Christian, do you have any plans around that area?

I've got a tree for that already and have applied related stuff there.
I've fixed up the comments from this thread.

