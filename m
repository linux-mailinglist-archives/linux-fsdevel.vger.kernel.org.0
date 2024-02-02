Return-Path: <linux-fsdevel+bounces-10021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E5847125
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 14:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBDC1C25D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1030C46546;
	Fri,  2 Feb 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5WBL7m9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D84428
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880510; cv=none; b=f1Tnnt7L8ru9IgVC/uqHEJIIfGNFoDmYY7i2M4K+0MiuP/aEv+xR3zKDA6zedlTlQ2gZaaT32zjGV51+RCmtlhjz4BfUOXIrDb2Ym6mYTNu3MyzPIXE7wyIiDgqhQB1hJRDC8xNWiX6hBoD42ZaRvJvv1OY7/uB/zx5vfuaZyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880510; c=relaxed/simple;
	bh=Oy++gtsKGYLvpFs15Gzv9zKqrKOJ/GUX+gIUDbKfpF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNGs+jeYEanf93mXukUxJY5dlQEPa4UzQRbJ4O/LFHgCK6ZecieVa2lfcXG41sxU6THpExVY/0mr/pirzVxnBgJFMjDdMb91WTjkotlCDw3xggCS3GWmQOM7N7CRoJPssY5werjZNB/LLW8fGXyii1SJ0+lSfHKrxSU7FWfvm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S5WBL7m9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x606Z/KcYmnJxZy76x1M0MtI6Q/G0bPc8vDseQeRUmU=; b=S5WBL7m9BVakDCbUA5iktIyy+z
	2GAiwwP+ORnRd08ykLvyBOEkXEfAgFlPtoah70U0i0zVxMLI3AeMcP/21lexi3zu73uEumzhzNO2H
	faJO8AQwTgPSLJytSDp5/UzPxhu4Zml47OuOUF/WUY8HcxQx60j03bqod6xJHVA+lpzuCYb9XE/gI
	wkzLW36PE53ECK1CcOfHbILwfQnXSPkPxUIRVxTsMv56FWOa58LlOqHPSas7PqYtXW9iuawnxrj43
	MbOSdG6H8q7upE9gcLwnfoEpu7OEsYvz3ELcOaq+khI+u7mSri8TKAAbcQL35d5xN6htmFXCcYvBh
	UV3Wc8Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVtaY-000000019bW-3Ywr;
	Fri, 02 Feb 2024 13:28:14 +0000
Date: Fri, 2 Feb 2024 13:28:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org,
	Kent Overstreet <kent.overstreet@linux.dev>, dwmw2@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions
 of uninterruptibility
Message-ID: <Zbzt7rzFeM_tsWCp@casper.infradead.org>
References: <2701318.1706863882@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2701318.1706863882@warthog.procyon.org.uk>

On Fri, Feb 02, 2024 at 08:51:22AM +0000, David Howells wrote:
> Hi,
> 
> We have various locks, mutexes, etc., that are taken on entry to filesystem
> code, for example, and a bunch of them are taken interruptibly or killably (or
> ought to be) - but filesystem code might be called into from uninterruptible
> code, such as the memory allocator, fscache, etc..
> 
> Does it make sense to replace TASK_{INTERRUPTIBLE,KILLABLE,UNINTERRUPTIBLE}
> with begin/end functions that define the area of uninterruptibility?  The
> regions would need to handle being nested, so maybe some sort of counter in
> the task_struct counter would work.

I don't think filesystems ever want to do stuff interruptible.
That allows any signal, including SIGALRM, SIGWINCH or SIGUSR[12] to
interrupt your sleep, and user code just isn't written to handle that
(short reads, etc).

But killable is useful.  If I hit ^C, I want the task to die.  Maybe some
of its resources hang around futilely waiting for a packet that will never
arrive; so be it.  So I would not define inode_lock_interruptible().
But I would define inode_lock_killable().  I'd be happy to see that
overridden by a task_set_uninterruptible(), but we do need a new API to
give filesystems a chance to handle "I didn't get the lock, abort".

