Return-Path: <linux-fsdevel+bounces-43723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CFFA5CC7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB38D179BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DFF26389E;
	Tue, 11 Mar 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DopLSpB6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF536262D1B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715036; cv=none; b=CWCyedEK59xaOycc+scEVkG8+nczgiIdO/lg0ME9czQvYZ/+ZccFzmIxNU3cRssSVajivvkKoy/SKa+05oJwkKgfls4cFngoDjeVNU7xQWqrAWo7hD+14AMDpq6aeg7P3Y2YlijNHu6+mD4Kqk8Ipm9wuZf2Qt/kbcFxTgNT6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715036; c=relaxed/simple;
	bh=inPsFWznoBdBd6e/7UmP6VhBEW1t5AFq21v5HkveYgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbLAIrIQ4u67UPqBT7jAst7QxMDNtl9xxWY/gvqlssu+M/p+eswAXD5YAApPGrB7i68nFArWSADCmtkCzZoTn0Z/1qtZivPlGpRPInFgCTBYLV4KagSjjoz4ZIj+kK7L4Wg3O5X+eMyzfhCLw6UcgK7IUyIhp2jnYDmsdNQp2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DopLSpB6; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Mar 2025 13:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741715023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpiVMH+uz8pDBdQTIQDJEk8NQ4sF1A/ZCxIs+//yAkI=;
	b=DopLSpB6oOTI5CesGQUr2YrmcJ6lQAC2QoMYIPLxseHW28dPXg89d0wzYK5NaQdy95Rqel
	7TP3xYxpZP3tWxRy2zyKvCBJMrakbjjP8aZCgg40MjA3EAEVtxvckU0vMtWMOHnmJlpT0M
	llSv3SRWIcdpUIwqFPYeX4F3rMqnsrI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Demi Marie Obenour <demi@invisiblethingslab.com>, cve@kernel.org, 
	gnoack@google.com, gregkh@linuxfoundation.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, mic@digikod.net, 
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <3xdcuya6ww25nglnfslj5tzb4wqu52az2r4hqx7hqvj3xrvt2a@pdoztv74g5ue>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <20250311-desillusionieren-goldfisch-0c2ce3194e68@brauner>
 <20250311173600.GR2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311173600.GR2023217@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 11, 2025 at 05:36:00PM +0000, Al Viro wrote:
> On Tue, Mar 11, 2025 at 12:01:48PM +0100, Christian Brauner wrote:
> 
> > The case where arbitrary devices stuck into a laptop (e.g., USB sticks)
> > are mounted isn't solved by making a filesystem mountable unprivileged.
> > The mounted device cannot show up in the global mount namespace
> > somewhere since the user doesn't own the initial mount+user namespace.
> > So it's pointless. In other words, there's filesystem level checks and
> > mount namespace based checks. Circumventing that restriction means that
> > any user can just mount the device at any location in the global mount
> > namespace and therefore simply overmount other stuff.
> 
> Note that "untrusted contents" is not the worst thing you can run into -
> it can be content changing behind your back.  I seriously doubt that
> anyone fuzzes for that kind of crap (and no, it's not an invitation to
> start).  I seriously doubt that there's any local filesystem that would
> be resilent to that...

Given network block devices (more common with cloud stuff these days),
it's not a totally unreasonable thing to want to be secure against.

I'd love to see someone attack bcachefs that way - in a few more years :)

