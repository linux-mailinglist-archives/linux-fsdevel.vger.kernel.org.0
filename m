Return-Path: <linux-fsdevel+bounces-40280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3EEA217EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 08:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299343A4B9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D1719306F;
	Wed, 29 Jan 2025 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0kRWCyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797218C31
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134842; cv=none; b=A3zcfdla/uDrrQg1qfX/9QM5tNSSCxZroWhB/Dd85TNyImiBUw1vLL+aKBugP7UiQOP1nZHDWse6mldzOKlkH3+MphI0q40fleuHKWdVSTlTwLZ6gQkK/KEqX+yG5Ju1JQv1KbLImUMi/IUzGLKDTC9lGmnVzV9aaqVmJJR6eWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134842; c=relaxed/simple;
	bh=pQKfIqTs67XaBgVdfvmEec+ala9DLbPpDu/m06RopH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiZZiOzK3c8WjuFGPIHlhuTujs8Ccl/sNTguZTr0EexuFU213hCcvifpbYXn9WlCrCnaaqtK99XoDd3fulcdxwptKm0GAk6yvhEf2sN5XfWjjPNtCxKf0OCs7jz46T2wW2z+4ObHYDxb83FDZNLeYJTA5OWdwReJne+zzdC4ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a0kRWCyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CECC4CED3;
	Wed, 29 Jan 2025 07:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738134841;
	bh=pQKfIqTs67XaBgVdfvmEec+ala9DLbPpDu/m06RopH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0kRWCyRjNnyhbam25NeMZt6ZfQ8gq+dh32Ck64LVaM5cvPOp9+TVA0/ILaGRcDTW
	 KqVzg5l7G2x1LE2n2MWMdf/y7EJ1ohqk0SM00NiGOQQ/wz0cJ8PqZpfg3Wlom0eTNP
	 zDSDJIUPcIqsmqH2CK0EiGmVqY8STz3ko0JtpGTQ=
Date: Wed, 29 Jan 2025 08:13:02 +0100
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
Message-ID: <2025012939-mashing-carport-53bd@gregkh>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
 <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
 <20250127050416.GE1977892@ZenIV>
 <SJ1PR11MB6129954089EA5288ED6D963EB9EF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250129043712.GQ1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129043712.GQ1977892@ZenIV>

On Wed, Jan 29, 2025 at 04:37:12AM +0000, Al Viro wrote:
> On Tue, Jan 28, 2025 at 04:00:58PM +0000, Borah, Chaitanya Kumar wrote:
> 
> > Unfortunately this change does not help us. I think it is the methods member that causes the problem. So the following change solves the problem for us.
> > 
> > 
> > --- a/fs/debugfs/file.c
> > +++ b/fs/debugfs/file.c
> > @@ -102,6 +102,8 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
> >                 if (!fsd)
> >                         return -ENOMEM;
> > 
> > +               fsd->methods = 0;
> > +
> >                 if (mode == DBGFS_GET_SHORT) {
> >                         const struct debugfs_short_fops *ops;
> >                         ops = fsd->short_fops = DEBUGFS_I(inode)->short_fops;
> 
> D'OH.
> 
> Both are needed, actually.  Slightly longer term I would rather
> split full_proxy_{read,write,lseek}() into short and full variant,
> getting rid of the "check which pointer is non-NULL" and killed
> the two remaining users of debugfs_real_fops() outside of
> fs/debugfs/file.c; then we could union these ->..._fops pointers,
> but until then they need to be initialized.
> 
> And yes, ->methods obviously needs to be initialized.
> 
> Al, bloody embarrassed ;-/

No worries, want to send a patch to fix both of these up so we can fix
up Linus's tree now?

thanks,

greg k-h

