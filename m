Return-Path: <linux-fsdevel+bounces-68428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64689C5BDC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0866E4E32F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3ED2F90DE;
	Fri, 14 Nov 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QNoFj+y5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465BF242D7B;
	Fri, 14 Nov 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107141; cv=none; b=rdyuKcFTvOc4kjmDU4CDLHhhI+YbmxDGUefAwXQwO8MOBViCF/02LVTy/XRtMatwOh8MQYP0lcpmWgdUfmaHOSeatheit6s1GooBK5SWLXl5NY0xVZlRBjaG1d0WIXCjDeX+zIvR5qUqrD6r+EZ6HKx/lFiNi2H8w1/lu5XCbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107141; c=relaxed/simple;
	bh=t69fkMqkRFPwCgXijdlay4X8A8p4kUT2bp94ITXFxaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpPWuYWWURwydHaMOpHFhmxUOwnYXAOYbmG8g6gMHt1HsqyRpGUZaHUWCOoGXRsYUrKsrdHlHgoYu1T8ea8PSencOzb5h5T5iDD9C3B24aXJz6DVC5fPqm2GcAhUUU7ku5N4qLJAKsO7y2uN5wJxylZyvMRhLmc7fq3eekGwoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QNoFj+y5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+BX9pgqKetmYXWegrY1jxWDAubueY2L9llfmksDJZ7o=; b=QNoFj+y5vkEvXZb61fdoJLx6e2
	Tc2JO92a+37E6aeKDBwJwdoYW8Dhep24cN+upN60xBcxtlg9v4K+oKBYswCsLpj+mzmQs+a30I8kL
	O9aCdsaJXsC0AhvA/uTMGAqQd6nHWcpFUDoKuVF4LQtUaU/qyHG5eNRvy86Eyy0PCuGnCZHaGszRl
	mW65m2RQX8KZ7O7g/GxFppVowqrruAkJ7W0Q5HI3ToyLPOYtngIf7chV5mMITZupTtlj5q156Q84B
	+O7EZ38GpdVxTMxzVjbchFWBMU2VFhoO4M9gkNYse+lZg1Z80PIoUePe1y5NUxAC56AoOgacVQ+yU
	yRE9z4tA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJohq-00000009fzo-2VEk;
	Fri, 14 Nov 2025 07:58:54 +0000
Date: Fri, 14 Nov 2025 07:58:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chris Mason <clm@meta.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bot+bpf-ci@kernel.org,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com, selinux@vger.kernel.org,
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Subject: Re: [functionfs] mainline UAF (was Re: [PATCH v3 36/50] functionfs:
 switch to simple_remove_by_name())
Message-ID: <20251114075854.GZ2441659@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
 <3984c9bd-2ac8-424e-9390-7170fdab3c03@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3984c9bd-2ac8-424e-9390-7170fdab3c03@meta.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 13, 2025 at 09:16:52PM -0500, Chris Mason wrote:

> ================================================================================
> BUG #2: Race condition in ffs_data_closed()
> ================================================================================
> 
> In ffs_data_closed(), there's an unsynchronized state modification:
> 
> static void ffs_data_closed(struct ffs_data *ffs)
> {
>         ...
>         if (atomic_dec_and_test(&ffs->opened)) {
>                 if (ffs->no_disconnect) {
>                         ffs->state = FFS_DEACTIVATED;
>                         ...
>                 } else {
>                         ffs->state = FFS_CLOSING;
>                         ffs_data_reset(ffs);
>                 }
>         }
>         if (atomic_read(&ffs->opened) < 0) {
>                 ffs->state = FFS_CLOSING;
>                 ffs_data_reset(ffs);
>         }
>         ...
> }
> 
> Can this race with concurrent state changes? The atomic_read() check is not
> synchronized with the subsequent state assignment. Between the read and the
> assignment, another thread could modify the state, potentially causing state
> machine corruption or double cleanup via ffs_data_reset().

The atomic_read() check is utter bollocks.  ->opened starts with 0, is bumped
on opens on that fs and decremented when files are closed.  How could it end
up negative?  Well might you ask - there's a call of ffs_data_closed() in
ffs_kill_sb().  _There_ we are guaranteed that there's no opened files (we'd
better, or there would be much worse problems), so ffs->opened is known to
be 0 and ffs_data_closed() decrements it to -1.

In other words, that couple of lines is executed on call from ffs_kill_sb()
and only on that call.  Which is to say, that thing is just an obfuscated
	if (s->s_fs_info) {
		struct ffs_data *ffs = s->s_fs_info;
		ffs->state = FFS_CLOSING;
		ffs_data_reset(ffs);
		ffs_data_put(ffs);
	}

Not a race, just a highly unidiomatic code.  While we are at it, after taking
that mess out of ffs_data_closed() we no longer need to bump/drop ffs->ref
in ffs_data_opened()/ffs_data_closed() - superblock owns a reference all along
and it's *not* going away under an opened file.

