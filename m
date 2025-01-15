Return-Path: <linux-fsdevel+bounces-39324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6FA12B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AB13A7C8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B601D63EA;
	Wed, 15 Jan 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1GE9Cpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74981D6194
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966608; cv=none; b=E8SdrmhH6wYxcLRUrr8wryjlDuhV3gffkzG22/vHRF5hXK9eInOSSn6uESKMcaSJAFCIrsTAlZMebpXqoLRSRQx2VXgV28GJN75j/fXINPixKmTdRRt0+o7KyPGR6rdOI+1c2pwOYa/oJvoKjuKIB2ian0Wp9TVwOVi4f6jHhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966608; c=relaxed/simple;
	bh=gLO1mZ9Vcg2q6FKWpS+x2oVNVo2j0I8W+Nvii5aFmbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D26aKF/Uh8vPeUOmK9sWhFy0agF0TPVtTHHnw9+7YttbXzqVveZE04GAYWhgG3ZCWJm2iJ6+J4ELWIcyXVF3PHdWi3H2xYAjRtjcgYSBuknmtqzfAG5ux/UvseSZlPjMRkOYHgsyPXVmCfM61S6om2Y9QvYS2+dys0ERoxrnA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n1GE9Cpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5941C4CED1;
	Wed, 15 Jan 2025 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736966607;
	bh=gLO1mZ9Vcg2q6FKWpS+x2oVNVo2j0I8W+Nvii5aFmbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1GE9Cpt6gU/kwR2y3JxBHToOBDNfHGZqMFa+j8KCYWsNyB6TLGZfmqJ6Rpe69g6g
	 zHSwHVFDAsKfHOdb7wyp6Jco0+K33BLrUlJ3TB5EV+i1XqVA7CdSzZexMXvg8GJ6JL
	 BOhi2/9H1a2Rp69T4s/Hq6bRFTZlCzU0joVEdHeQ=
Date: Wed, 15 Jan 2025 19:43:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fix a file reference leak in drivers/misc/ntsync.c
Message-ID: <2025011504-thong-irritate-4bf4@gregkh>
References: <20250115025002.GA1977892@ZenIV>
 <12598856.O9o76ZdvQC@camazotz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12598856.O9o76ZdvQC@camazotz>

On Wed, Jan 15, 2025 at 12:20:34PM -0600, Elizabeth Figura wrote:
> On Tuesday, 14 January 2025 20:50:02 CST Al Viro wrote:
> > 	struct ntsync_obj contains a reference to struct file
> > and that reference contributes to refcount - ntsync_alloc_obj()
> > grabs it.  Normally the object is destroyed (and reference
> > to obj->file dropped) in ntsync_obj_release().  However, in
> > case of ntsync_obj_get_fd() failure the object is destroyed
> > directly by its creator.
> > 
> > 	That case should also drop obj->file; plain kfree(obj)
> > is not enough there - it ends up leaking struct file * reference.
> > 
> > 	Take that logics into a helper (ntsync_free_obj()) and
> > use it in both codepaths that destroy ntsync_obj instances.
> > 
> > Fixes: b46271ec40a05 "ntsync: Introduce NTSYNC_IOC_CREATE_SEM"
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>
> 
> 
> ---
> 
> Thanks for catching this. There's a similar problem with the other newly introduced object types in the char-misc-next tree (and this patch doesn't apply cleanly there anyway). I'll send a similar patch for those, unless you have one already.

I already applied this and fixed up the fuzz there, it's now running
through 0-day testing...

thanks,

greg k-h

