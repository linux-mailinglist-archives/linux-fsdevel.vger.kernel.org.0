Return-Path: <linux-fsdevel+bounces-39435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421ADA141E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 20:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A529A188597E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794022FDE9;
	Thu, 16 Jan 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lMVJWM8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD922FAC3;
	Thu, 16 Jan 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053994; cv=none; b=sXX+ZovtNjPQ5hnCenFt3AVPr4Ce5F/MbWkS6gwYPjTn+x906XjwZHz2ysFETShZyRiT8L5ksCNHQwsTdN2GRX1yC2vIjmWVbEze4EqjCstADO38BGBbIFfmzuMAy2I/SVCfjci9T2u3wgSwwfAhnWJKl7OKJp3O+3E18+p0NPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053994; c=relaxed/simple;
	bh=fiQbXu8bnouddMmlfWTTXD6V+eUXT2xKnq7PiHP49iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCx72gWBxeY0bcgMBQAAFpUDZHLs1VloVEOuPLJvYfuZUU4Fhr9zaGCH9kv5ffwfjXjb8uOSnqTEQTd3GqdeevZgUhMaqp46TjipamOB5+LNZkdSHlZIBpPCByFX/9mXx3hS6oBlt9t9CIr3crmqovtEDOcHA7Zl0GS8GBpc4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lMVJWM8+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=gayXrOv/ii/4l4tzYbPhb9aUtr4v6cPKWS3xNUAj/hE=; b=lMVJWM8+JhJRU2a/NVjIbXuwbs
	6qLsY1I3qEZpw/EHL8HBkhiKsfGofGaqp93+Z565KDRD1TyMlw4mRZGJZA7TrKXHojyRtLIdpyVIW
	fG7n6CXCAkdxsvz8LsptuVDnBygv00HfdQrAj/DUQIrl9Gap2SyvZ3BFz1PgqgUj4cUdx88Kxk1zy
	renUKvczTHrNX5FJiNw6v5EPdjg8iPOGc92i0Hxaiw+wabV2BsHvKmw5V6kuXI03PHwIFop/MZ6Ci
	TDYbfdkQEsRjdiGLP+eA+E4myroLtw5geOvRESqGTVGMcpgnTr6bht6fUc95AQonJ+qNzTxc8BOnT
	XC2lyPcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYV5q-00000002YrG-3CvI;
	Thu, 16 Jan 2025 18:59:50 +0000
Date: Thu, 16 Jan 2025 18:59:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 6/6] efivarfs: fix error on write to new variable
 leaving remnants
Message-ID: <20250116185950.GL1977892@ZenIV>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
 <20250107023525.11466-7-James.Bottomley@HansenPartnership.com>
 <20250116184517.GK1977892@ZenIV>
 <1d9e199d1b518a6661dee197bc767b2272acb318.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d9e199d1b518a6661dee197bc767b2272acb318.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 16, 2025 at 01:54:44PM -0500, James Bottomley wrote:
> On Thu, 2025-01-16 at 18:45 +0000, Al Viro wrote:
> > On Mon, Jan 06, 2025 at 06:35:25PM -0800, James Bottomley wrote:
> > 
> > > +       inode_lock(inode);
> > > +       if (d_unhashed(file->f_path.dentry)) {
> > > +               /*
> > > +                * file got removed; don't allow a set.  Caused by
> > > an
> > > +                * unsuccessful create or successful delete write
> > > +                * racing with us.
> > > +                */
> > > +               bytes = -EIO;
> > > +               goto out;
> > > +       }
> > 
> > Wouldn't the check for zero ->i_size work here?  Would be easier to
> > follow...
> 
> Unfortunately not.  The pathway for creating a variable involves a call
> to efivarfs_create() (create inode op) first, which would in itself
> create a zero length file, then a call to efivarfs_file_write(), so if
> we key here on zero length we'd never be able to create new variables.
> 
> The idea behind the check is that delete could race with write and if
> so, we can't resurrect the variable once it's been unhashed from the
> directory, so we need to error out at that point.

D'oh...  Point, but it still feels as if you are misplacing the object
state here ;-/

OK, so we have
	* created, open but yet to be written into
	* live
	* removed

Might be better off with explicit state in efivar_entry...

