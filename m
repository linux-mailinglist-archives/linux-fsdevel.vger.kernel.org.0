Return-Path: <linux-fsdevel+bounces-40361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9FA229AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 09:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A436A1887B65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4B1AF0CA;
	Thu, 30 Jan 2025 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R5GKG3cS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB751C5A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226221; cv=none; b=FDt/NHqtpTN9CNV1IUIw5nA3E+77dbYm+CyV8qCPzBKut9kHerDDi59BK1jT6c+wPdE3S8Keqv1kbJstl4pwlwM6fR1G8Ft9fRg77aHt6oUq2uC9ujTyZ0bzL9Q7Du94SEfuo0zGgGzyAYQuVLJneib8w97ozZaacMS96GRvNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226221; c=relaxed/simple;
	bh=SkT743wa/olFo78wLQvP9MMQ9915yalZCxfpq9WEduE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq8JcHLAdo2XGMXrYpOm3zkbOpQWT8Xde+2eq2oZYppobVilwtF+1RQ4JGtYpi9weF4xv2XYXcUloZ5yq9OxSDVzR3qqcleXkBVPlSPwkkFg1m8sDwNd7QaKsMhev1Q+WbKaC7CjT5IZJhRpsDRrkJlj123P3tH0Z+2Y33pBtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R5GKG3cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBEBC4CED3;
	Thu, 30 Jan 2025 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738226220;
	bh=SkT743wa/olFo78wLQvP9MMQ9915yalZCxfpq9WEduE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5GKG3cSAdtF2he/RoyxVZjgEGSKd0fIkGDekgyoz2kCYeDpJLW8W2kUj+IQQQF2s
	 y19oxuR7+5DIj6vPlenP6ENXYgUpYnk8T+peoAa8/IkSZkAK+1JNF65Vl3SSDtcdcI
	 m3r4Gkq2Y8RM72wRbeWTU9elUfqynkv+IFaGnCH4=
Date: Thu, 30 Jan 2025 09:36:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: Regression on linux-next (next-20250120)
Message-ID: <2025013052-refueling-ripping-2f6e@gregkh>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
 <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
 <20250127050416.GE1977892@ZenIV>
 <SJ1PR11MB6129954089EA5288ED6D963EB9EF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250129043712.GQ1977892@ZenIV>
 <2025012939-mashing-carport-53bd@gregkh>
 <20250129191937.GR1977892@ZenIV>
 <2025013055-vowed-enjoyment-ce02@gregkh>
 <SJ1PR11MB61297857686D10DD3F65645AB9E92@SJ1PR11MB6129.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB61297857686D10DD3F65645AB9E92@SJ1PR11MB6129.namprd11.prod.outlook.com>

On Thu, Jan 30, 2025 at 08:08:30AM +0000, Borah, Chaitanya Kumar wrote:
> 
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Thursday, January 30, 2025 12:55 PM
> > To: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; intel-
> > gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org; Kurmi, Suresh
> > Kumar <suresh.kumar.kurmi@intel.com>; Saarinen, Jani
> > <jani.saarinen@intel.com>; linux-fsdevel@vger.kernel.org; Alexander Gordeev
> > <agordeev@linux.ibm.com>
> > Subject: Re: Regression on linux-next (next-20250120)
> > 
> > On Wed, Jan 29, 2025 at 07:19:37PM +0000, Al Viro wrote:
> > > On Wed, Jan 29, 2025 at 08:13:02AM +0100, Greg Kroah-Hartman wrote:
> > >
> > > > > Both are needed, actually.  Slightly longer term I would rather
> > > > > split full_proxy_{read,write,lseek}() into short and full variant,
> > > > > getting rid of the "check which pointer is non-NULL" and killed
> > > > > the two remaining users of debugfs_real_fops() outside of
> > > > > fs/debugfs/file.c; then we could union these ->..._fops pointers,
> > > > > but until then they need to be initialized.
> > > > >
> > > > > And yes, ->methods obviously needs to be initialized.
> > > > >
> > > > > Al, bloody embarrassed ;-/
> > > >
> > > > No worries, want to send a patch to fix both of these up so we can
> > > > fix up Linus's tree now?
> > >
> > > [PATCH] Fix the missing initializations in __debugfs_file_get()
> > >
> > > both method table pointers in debugfs_fsdata need to be initialized,
> > > obviously, and calculating the bitmap of present methods would also go
> > > better if we start with initialized state.
> > >
> > > Fixes: 41a0ecc0997c "debugfs: get rid of dynamically allocation proxy_ops"
> > > Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > 
> > Thanks, now queued up.
> 
> We can confirm that this change works.

Wonderful, thanks!

