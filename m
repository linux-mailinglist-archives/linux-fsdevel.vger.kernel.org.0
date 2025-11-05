Return-Path: <linux-fsdevel+bounces-67068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F912C340B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 07:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD951897D42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 06:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41E2C08AB;
	Wed,  5 Nov 2025 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DKqQnOYr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0100729C338;
	Wed,  5 Nov 2025 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323907; cv=none; b=W1a8wnbz8YwIxmaxJ0iwAC1USfPqcFeMIxADSz/N7dZhmhWQ01wjJ/Hh305wGz9qwOVIeUKaCwxA/rKqkcIOGEYGG+kNa2qBw2rkh3V+YpRZrOxhwejD9jX5iWKbiUG10lCJipRYR9WvtxTiGd2WlMfV6AjpQs6FdGFD4vMZSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323907; c=relaxed/simple;
	bh=PYeGwhSelUDlgFEYczoOST+VVcOmZjQzlpX+qD1Ww00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVKK5pi5kpr0Liyr+tgLDfWOC41SU1Y8YEsDOkTK1F3zJTuyWw8n3c4HuEbkDecw4K3+RDS1CMeW3ZKVfzvARtGjVmiaa54SSwIibLi4siVSLHOI5/6l+ee5gp4n/HgS+PpjgK5BGfbDlv1hHhuFU6uCgyHh9a618LuZ7e/mFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DKqQnOYr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K3trsM2jtIqcXAhO2RW82Rusl1AamfzGXsKVmqjZpjY=; b=DKqQnOYru7+/NOF0d6uXDrfww4
	f7RyIm9g2Agn8TBxBmz/a6g1hVMmQFoCyvaegYhnKkXOnq/aNSSC92OhoZtxYMCe1d4Oof4v4yAI+
	iB8dd37SlbbottLqCYa6LZI+SbFKwCgrZ4P78lZllzrs+EQE9853uqdluxgDN/t3J25eraFa66LFd
	2xpJWYtn7mBiia3+AQ+xsG4XGgYFwh6D0VFNCQwkwa0doBd9/Y2OEfEWrxArVAmgvJWwt6OsKh1SA
	cF/Omol/fEDnRr6TivnztsVS6VWJRQ+mlV3EQUBkr2gDQF9CTXmee4Z5I8gEm46a4G/D/j7WBk/Mi
	XKdHUNpg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGWx3-00000005J1b-0Cti;
	Wed, 05 Nov 2025 06:25:01 +0000
Date: Wed, 5 Nov 2025 06:25:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in putname()
Message-ID: <20251105062501.GG2441659@ZenIV>
References: <20251029134952.658450-1-mjguzik@gmail.com>
 <20251031201753.GD2441659@ZenIV>
 <20251101060556.GA1235503@ZenIV>
 <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
 <20251102061443.GE2441659@ZenIV>
 <CAGudoHFDAPEYoC8RAPuPVkcsHsgpdJtQh91=8wRgMAozJyYf2w@mail.gmail.com>
 <20251103044553.GF2441659@ZenIV>
 <CAGudoHGP+x0VPpJnn=zWG6NLTkN8t+TvKDwErfWVvzZ7CEa+=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGP+x0VPpJnn=zWG6NLTkN8t+TvKDwErfWVvzZ7CEa+=Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 03, 2025 at 05:44:07PM +0100, Mateusz Guzik wrote:

> a sketch:
> /* called by the thread which allocated the name if it decides to go
> through with it */
> delegate_alien_name(name) {
>     VFS_BUG_ON(name->delegated);
>     name->delegated = true;
> }
> 
> /* called by the thread using the name */
> claim_alien_name(name) {
>     VFS_BUG_ON(!name->delegated);
>     VFS_BUG_ON(name->__who_can_free != NULL);
>     name->__who_can_free = current;
> }
> 
> destroy_alien_name(name) {
>     if (name->delegated) {
>         VFS_BUG_ON(name->__who_can_free == NULL);
>         VFS_BUG_ON(name->__who_can_free != current);
>     }
>     putname(..);
> }
> 
> So a sample correct consumer looks like this:
> err = getname_alien(&name);
> ....
> err = other_prep();
> if (!err)
>     actual_work(delegate_alien_name(name));
> else
>     destroy_alien_name(name);
> 
> the *other* thread which eventually works on the name:
> claim_alien_name(name);
> /* hard work goes here */
> destroy_alien_name(name);
> 
> Sample buggy consumer which both delegated the free *and* decided free
> anyway is caught.

That would make sense had there been any places where we would want
use the alien_filename contents (hell, access it) in any way other
than "destroy and get a struct filename reference".  I don't see any
candidates, TBH...

