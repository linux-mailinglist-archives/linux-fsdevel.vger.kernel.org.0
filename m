Return-Path: <linux-fsdevel+bounces-40358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8F4A2291D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 08:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03667164D09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 07:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA1D1A23A0;
	Thu, 30 Jan 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VnqNMYRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A4186294
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738221906; cv=none; b=onwzDFs+8pYiqgHc182NRYXOzhnHd8yCLzplBMP+3PUGrFr3oivRx+YAMyY8YMyRYf/Co3sRlHLoamlEyNysFRfTv5hBQkWBRo75HvYfB+94FY8xTjRb64E1MkLfr07qwfrhNP/6NlBs/SVpqdf2X0XDCp0CoiidO4PhqoW4DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738221906; c=relaxed/simple;
	bh=ObUB0EpYPGTUQqptfsaDDXOrb7t1j4KmnKKrL+FJR1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLCd7zXExmV7wd4gbrtRzTKabLLEiE8Cmz9jmKp37iGPgKxZDeKERDgBJK/kBEe+TbBCxpZoiDSAVd662xa9FlZ1vwcPURLIyzQhHosHV3yaWoaSpIHcOcNAA6M5DwMhZV7EydUI0w60T2peFrH7pRD6YCIOMiLrezYF/dpIK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VnqNMYRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CE6C4CED2;
	Thu, 30 Jan 2025 07:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738221905;
	bh=ObUB0EpYPGTUQqptfsaDDXOrb7t1j4KmnKKrL+FJR1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnqNMYRbgwU95N9NqwWkfy2ZuU/oNgJv21QFEXQEI5i0bU3GK07j/LarlOU50NEV6
	 hglzHxeyKXfvx6Wupkfv+YtXEgoeDbP7cFA/L8P1C6vfHIYh7GQ57tuG0w2Lf2Fn07
	 uPHM0xWtVAGWbMTxM1KXQJgl0bx3pb57RP0aoO1s=
Date: Thu, 30 Jan 2025 08:25:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: Regression on linux-next (next-20250120)
Message-ID: <2025013055-vowed-enjoyment-ce02@gregkh>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
 <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
 <20250127050416.GE1977892@ZenIV>
 <SJ1PR11MB6129954089EA5288ED6D963EB9EF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250129043712.GQ1977892@ZenIV>
 <2025012939-mashing-carport-53bd@gregkh>
 <20250129191937.GR1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129191937.GR1977892@ZenIV>

On Wed, Jan 29, 2025 at 07:19:37PM +0000, Al Viro wrote:
> On Wed, Jan 29, 2025 at 08:13:02AM +0100, Greg Kroah-Hartman wrote:
> 
> > > Both are needed, actually.  Slightly longer term I would rather
> > > split full_proxy_{read,write,lseek}() into short and full variant,
> > > getting rid of the "check which pointer is non-NULL" and killed
> > > the two remaining users of debugfs_real_fops() outside of
> > > fs/debugfs/file.c; then we could union these ->..._fops pointers,
> > > but until then they need to be initialized.
> > > 
> > > And yes, ->methods obviously needs to be initialized.
> > > 
> > > Al, bloody embarrassed ;-/
> > 
> > No worries, want to send a patch to fix both of these up so we can fix
> > up Linus's tree now?
> 
> [PATCH] Fix the missing initializations in __debugfs_file_get()
>     
> both method table pointers in debugfs_fsdata need to be initialized,
> obviously, and calculating the bitmap of present methods would also
> go better if we start with initialized state.
>     
> Fixes: 41a0ecc0997c "debugfs: get rid of dynamically allocation proxy_ops"
> Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Thanks, now queued up.

greg k-h

