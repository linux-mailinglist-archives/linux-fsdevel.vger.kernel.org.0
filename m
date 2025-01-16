Return-Path: <linux-fsdevel+bounces-39393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A4A137D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EE718889EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFFC1DDC23;
	Thu, 16 Jan 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL47gL66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4A19006B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023342; cv=none; b=vCIAvqi+3vqPAsT73EaSUT865MUIHkBGIXEEQef4ut6Hfv32mygD2zDX1MAySs50R23QpJymMMlsK2G1Q2B9+EXCzDu+8FZtVzk0OE8Flk3dTd4gvPNxrNoyTWMsBMdS0mPQ+CYaoEo1Ldt3Y1HeOcIE/fUl5kxsvU5fi9FPE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023342; c=relaxed/simple;
	bh=aUuO6YD6RW/QPwki9pe+Wo8mysfSgZr4wZKzLZlh8c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM/ZPOpgcG50UH6bwZLBJIXEF95TjtSNgFuQKJVyzmnzAzjMMgExrOBZ+MYvY8vzTPg3Tt8iaSbUBZRntAJgL58i02X/wTA5oAmXxDOEue4jVDEUhYn8cZtjCZp9pBr5CYij//jMOUh9bjUh326HaRAifjsocdInck/9p3QhQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL47gL66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B8DC4CED6;
	Thu, 16 Jan 2025 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737023341;
	bh=aUuO6YD6RW/QPwki9pe+Wo8mysfSgZr4wZKzLZlh8c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LL47gL66erUzikx+paAP+IMUCEsWwuXYMG500fv8OgZbXv3u63zQQxHFUs7gmO79M
	 4zTxYTIjsaV7uw9O36V04+XLrVp46CE3kNbanK/GkY4LfU1qYDCOgxcz14cdGwCEbW
	 P6nv1vRJcaTo3eDNSZnBLVABytJpGS4O51k7hx6z46Pq3pmNxRV8pjoZlP5V6v9GIh
	 xZ9H/zhdr4FnTxjeBUZkEVH6nUEGWMXvUn0jyYFx0JEvbe6SX1lXa8Zhc8PVwgFG+6
	 voTTNPxlZKr+lINtT2wnzfAKVsswSxg0slx/FgYgH61f35Tzn5coF72isMUZ5u878e
	 GuExa/CZnr7Dg==
Date: Thu, 16 Jan 2025 11:28:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Carine Braun-Heneault <cbraunhe@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: mount api: Q on behavior of mount_single vs. get_tree_single
Message-ID: <20250116-erbeben-waren-2ad516da1343@brauner>
References: <732c3de1-ef0b-49a9-b2c2-0c3c5e718a40@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <732c3de1-ef0b-49a9-b2c2-0c3c5e718a40@redhat.com>

On Wed, Jan 15, 2025 at 10:50:31AM -0600, Eric Sandeen wrote:
> I was finally getting back to some more mount API conversions,
> and was looking at pstore, which I thought would be straightforward.
> 
> I noticed that mount options weren't being accepted, and I'm fairly
> sure that this is because there's some internal or hidden mount of
> pstore, and mount is actually a remount due to it using a single
> superblock. (looks like it was some sort of clone mount done under

Yes, some legacy filesystems behave that way unforunately.

> the covers by various processes, still not sure.)
> 
> In any case, that led me to wonder:
> 
> Should get_tree_single() be doing an explicit reconfigure like
> mount_single does?
> 
> mount_single() {
> ...
>         if (!s->s_root) {
>                 error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
>                 if (!error)
>                         s->s_flags |= SB_ACTIVE;
>         } else {
>                 error = reconfigure_single(s, flags, data);
>         }
> ...
> 
> My pstore problem abovec reminded me of the recent issue with tracefs
> after the mount api conversion, fixed with:
> 
> e4d32142d1de tracing: Fix tracefs mount options
> 
> and discussed at:
> 
> https://lore.kernel.org/lkml/20241030171928.4168869-2-kaleshsingh@google.com/
> 
> which in turn reminded me of:
> 
> a6097180d884 devtmpfs regression fix: reconfigure on each mount
> 
> so we've seen this difference in behavior with get_tree_single twice already,
> and then I ran into it again on pstore.
> 
> Should get_tree_single() callers be fixing this up themselves ala devtmpfs
> and tracefs, or should get_tree_single() be handling this internally?

I would think we should make this the filesystems problem or add a
get_tree_single_reconfigure() helper that the few filesystems that need
this behavior can use. Thoughts?

