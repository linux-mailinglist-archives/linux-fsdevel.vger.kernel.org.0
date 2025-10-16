Return-Path: <linux-fsdevel+bounces-64338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF31BE16E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 06:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A99E4E5F6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 04:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF7520C48A;
	Thu, 16 Oct 2025 04:33:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037618872A;
	Thu, 16 Oct 2025 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589221; cv=none; b=J/zh9rX3xTUMq3URxDzblH5qsMtFnqFWTB7vEn6IAQA8IzpBqebr+uycAHlhGFzFt4p9haYr/j3352zSuYOKQv0xbvA5AFqo1/e3plIVZ+V0BnNDEZfgDoW6MB1UWvx0/lEoxtBzeP0sxRSo1Ji7CdGroKPD/t1dEnPe3RaTNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589221; c=relaxed/simple;
	bh=m/50nW7ENKQcY+VcOm6HkD9A5idX37B4MEwyJMgsbjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvYhPUPHmAT/a57U0LFAy2XK433TnVsv/pZAhhWaeEkR6BcesbR4ZQc4DiJyvq3dLtCAq5iE4+6HnMKvqyMu/B3ZdstBxqR2Yk7KEBi1hSc1qtRPOhcO7UY/U59uzqVMuQ5MugTBDDoVaIa72VazUtTjoHq00R8T3KGIz2NJNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DC40227A87; Thu, 16 Oct 2025 06:33:34 +0200 (CEST)
Date: Thu, 16 Oct 2025 06:33:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
Message-ID: <20251016043333.GA29905@lst.de>
References: <20251015062728.60104-1-hch@lst.de> <20251015062728.60104-3-hch@lst.de> <20251015151353.GA786497@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015151353.GA786497@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 15, 2025 at 11:13:53AM -0400, Theodore Ts'o wrote:
> I wonder if we should bump the default; and if the concern is that
> might be problematic for super slow devices (e.g., cheap USB thumb
> drives), perhaps we can measure the time needed to complete the
> writeback, and then dynamically adjust the value based on the apparent
> write bandwidth?
> 
> We could have each file system implement something like this, but
> maybe there should be a way to do this in fs generic code?

Right now my main concern here is zoned file systems where the switching
directly leads to fragmentation.  Besides XFS that would in theory also
affect f2fs and btrfs, but unlike XFS they do not do the trivial data
separation by inode but just throw all writes into the blender with (f2fs)
or without (btrfs) some hot cold separation applied.  But even if they did
it finding the zone size is file system specific, so right now I don't see
much too share.  If we end up with duplicate code I'll happily factor it
into helpers.

> 
> 	      	    	      	       - Ted
---end quoted text---

