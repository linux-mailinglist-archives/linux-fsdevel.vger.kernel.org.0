Return-Path: <linux-fsdevel+bounces-65945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDCAC16463
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26091C25C23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E234DCE0;
	Tue, 28 Oct 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QUl6NIix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99134C820;
	Tue, 28 Oct 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673552; cv=none; b=bf40DqzLh80Yd56I/UpsFA+9AFkQfINvy6YZij2JSd8IhzisEeOvFFpqsx4c2kU3+bjE2tJ4HOtx7FJ28j51bw/BkzHlrzb++PB3yl6KuSOQ34KPWX3myKEqmml5KSr67toghHn1P5Gk73cwhemfuMuLd4YWt5fphtoSn/SPZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673552; c=relaxed/simple;
	bh=Mr1WTHFZ6i5J3hlsCvzyRrLq65RcchJJniLiOO3sXYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1F+WFPqPqt80p3tT/TdYufd551WyY4E2cg8wGatyTmek6m683X5KCYaMSjppYWXNmqqg2dPiqmKEBtuUEcvdsrfbyLZY/oh2makm3Rrbnhy8VpBBf+Y3WGfIyepIvA5PEogR5cgLRAxKYgp/YBlkscVzx8+5hsbBwXETDOwW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QUl6NIix; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2mGX18mZZPvHyD8tp/SlP21jzNUQaCksFfGjxcCZFG8=; b=QUl6NIixR/oJXVqt4B3YANU+NQ
	An/HOGXy/H+ZiEDYlQgRKgWKwvqssxz+gwDGLAME5GA/P7Qf6W6uPHxh6DWijCwvV4CcNYO/PXoT5
	YxZBFVCaU5Ea98ocoVf+/q91F1LwvtlAEGUyQ8O8zHEb4mZB0k+xjRSVz7F5gofV6A3RIqoPynnN9
	ezVcllUY59AGWdrRcZT+9Oh9asmURfIrTvNXHcX3TNV5V0uHjxp9Dz1RlWKoS/sBrDzfbCjA+ECAd
	RggfScej5M7Nnn6ExkwpClYDvlVq2rJMZSdhEkCYOdEy4KQyfIbMTYNy1dXL1QSfVewkCAh1tyQfP
	dUST2J4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDnlM-00000008bgd-3GJA;
	Tue, 28 Oct 2025 17:45:40 +0000
Date: Tue, 28 Oct 2025 17:45:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251028174540.GN2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk>
 <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 08:53:45AM -0400, James Bottomley wrote:

> That dput looks misplaced in a creation routine and this is a common
> pattern in pseudo filesystems that either pre-populate the dentry state
> or create effectively unused dentries on other changes.  I know not
> every pseudo filesystem does this, but it did make me wonder if it
> should have it's own API, say d_create_persistent()?

That dput() is paired with efivarfs_alloc_dentry(); the real problem
here is different - efivarfs_create_dentry() relies upon the external
serialization.  Have it race with lookup (let alone unlink()) and
there's a lot of headache.

Most of the callers should be safe, but... I'm not sure that unfreeze
case can't run into trouble.

It might need to be fixed; I don't want to mix that with this series,
so I went for the minimal transformation here.  I suspect that we
ought to use simple_start_creating()/simple_done_creating() instead
of those efivarfs_alloc_dentry()/dput(), but I'll need to look at
the locking environments in all call chains ;-/

FWIW, having a special path for "we are in foofs_fill_super(), fuck
the locking - nobody's going to access it anyway" is not a great
idea, simply because the helpers tend to get reused on codepaths
where we can't cut corners that way.

It *may* be useful to grow a set of primitives for something like "we are
forming a detached tree, will splice it into the final position once we
are entirely done", and configfs might shed a lot of kludges if massaged
in that direction, but I'd rather see what configfs massage converges
to before settling on an API for that.

