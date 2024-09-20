Return-Path: <linux-fsdevel+bounces-29734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC197D009
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 04:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D169DB23157
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 02:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6E14290;
	Fri, 20 Sep 2024 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="gnmap5+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B1C148;
	Fri, 20 Sep 2024 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726801086; cv=none; b=I72yXv1fHTqfigyowLadcsgMss3eidArfkoycUfnxwXMLdf8yu60fcLB4W6jabZYG1c6i9Ug1nfCA2cnX+0Zf7uRLdQDR6MQjQXjTCm6HMSSgAjGwoGtQJAzFArVdUgS8eMvbTlALEcVV37OAyztE3r0X/oMU/ahiWp1tj4sOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726801086; c=relaxed/simple;
	bh=Pn8Xc4IRr8nDixeyROjoUOtJqd/11GXqOOauya/fBWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3MfXdlpIeOEnNPlHzDo7F8nn5dm226t64QI4EeLBtqPm4ytR/nnoLLNTYsHTxYbARaPA8SLqfnGR1W4kJ+cv5dxJRoc2JcEw3C6UMzVrtUguonb7yleflHGoguIirdoRVUZp2B+p1Hm79uCw1zY3Zc7S1exqWE9V//PHfDT+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=gnmap5+E; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 763BC697AF;
	Thu, 19 Sep 2024 22:58:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726801083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YMih+D2wi9YPfDllyA5iKM7XhtyK372/GGedwlq9L10=;
	b=gnmap5+EjwAIwiUWK0HpcE8HCAks0Et9LQ8kadQi6QeoAdN2CxJcPnDpb3HoXeeYNKz7Rd
	PTKv9f6reL0WqH0v4rdRvFf8B2fv2iaMRTq1RmQT1IRp5S68a/2HWa1UuZvDZ5KLKAvCXZ
	kMhQJFvVSprSsMYga52499cV3uiAqhfjE+ZoCufd/x8Mr7lGwqrhQKqVXQ92PwRlqSBWXw
	fsarJDIg4y39MkPXvvy1r7OFhvD8/tNw0f5j6LiZrY68fSORsyuurNm4bSa857RDJTxBes
	0gkQ6hqa63bEPBqhbg1EAgyMcoKqSegmMjZXv2NfGg7pvut4lCkmk1y1y0voaA==
Date: Fri, 20 Sep 2024 10:57:55 +0800
From: Yiyang Wu <toolmanp@tlmp.cc>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <xqta6t7rrabvj4rdwt7bhp2ijxgnfzd65fauhca2rfyfhwxyzj@5wa5h63gelc5>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <2024091602-bannister-giddy-0d6e@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091602-bannister-giddy-0d6e@gregkh>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Sep 16, 2024 at 07:51:40PM GMT, Greg KH wrote:
> On Mon, Sep 16, 2024 at 09:56:13PM +0800, Yiyang Wu wrote:
> > Introduce Errno to Rust side code. Note that in current Rust For Linux,
> > Errnos are implemented as core::ffi::c_uint unit structs.
> > However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
> > 
> > Since the errno_base hasn't changed for over 13 years,
> > This patch merely serves as a temporary workaround for the missing
> > errno in the Rust For Linux.
> 
> Why not just add the missing errno to the core rust code instead?  No
> need to define a whole new one for this.
> 
> thanks,
> 
> greg k-h

I have added all the missing errnos by autogenerating declare_err!
in the preceding patches. Please check :)

Best Regards,

Yiyang Wu

