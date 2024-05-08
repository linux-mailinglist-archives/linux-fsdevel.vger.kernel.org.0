Return-Path: <linux-fsdevel+bounces-19131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71468C05B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 22:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBA91F21561
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24E7130E26;
	Wed,  8 May 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhGM9hsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EA413175A;
	Wed,  8 May 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200309; cv=none; b=tas7qcZIImiejGs/1NYgzjMSYTkOLtZxH3d1NwmHoSzIPWo617Qd6JTA/TSXQ7ZA5XUzS7d7a30V0CWaydTggusMrBhURhkpwPEJKFm0Phwqx7W1MKrm343u0dSJJiWv1PuAzpmjU13nQzJgSG82lStnpg7h4TVYCEjQXiVNhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200309; c=relaxed/simple;
	bh=NhTQgdMo6jj7Y9fyTFRXQu7eMUXNfOMOsCTnnfGOPJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktJj+8GzT9nW+8eI0b0qy3pX+dyVRUMkWbsKY4Hfac3XOzmEJKenLpQRdUXylKjfPV3b5IKClqmarrGaDgIOeL+2bMNiGoGmbbp1bKCqoR8tKUhRzwf8+JqKaCgA08rKWbMFuMCb9cfNtvskGleqr53iKggRhwWjN+Cmj12JIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhGM9hsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46AAC113CC;
	Wed,  8 May 2024 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715200308;
	bh=NhTQgdMo6jj7Y9fyTFRXQu7eMUXNfOMOsCTnnfGOPJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhGM9hsV/BbHQ8sp5W1d1PACGVEPAtnx4rwceFrCkhDlZ3LwaAaH6cAQeupN8ujxd
	 4FhaBWZw5dt9xyv+v3nfcTqwbgsgeUBd88gICY0hk6Ms4kyGTeHZcxVUlXfMMjKI5g
	 gcJb6Yb1ZuMUuVJeKaRtEhbwRE3aVs5dRcElah/6A2zFvz8TgS6Em0TvET0Ks4z0FN
	 9ZUwv5tH3heYsGk3pAPInKY0p3ztfVv+/xhOySDFJABW/EBObK2bTluLLc755wzp1x
	 XNYT4Eiq4rWCN3BNh2OFGePrNafCeXna8TgFPuIRcVRezsXMCdy0+z3Y+DVVWvgZeB
	 PQcj9wrKAR2aA==
Date: Wed, 8 May 2024 13:31:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <20240508203148.GE360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
 <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
 <20240502001501.GB1853833@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502001501.GB1853833@google.com>

On Thu, May 02, 2024 at 12:15:01AM +0000, Eric Biggers wrote:
> On Wed, May 01, 2024 at 03:50:07PM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 30, 2024 at 11:48:29PM -0700, Christoph Hellwig wrote:
> > > On Mon, Apr 29, 2024 at 08:30:37PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > Create an experimental ioctl so that we can turn off fsverity.
> > > 
> > > Didn't Eric argue against this?  And if we're adding this, I think
> > > it should be a generic feature and not just xfs specific.
> > 
> > The tagging is a bit wrong, but it is a generic fsverity ioctl, though
> > ext4/f2fs/btrfs don't have implementations.
> > 
> > <shrug> According to Ted, programs that care about fsverity are supposed
> > to check that VERITY is set in the stat data, but I imagine those
> > programs aren't expecting it to turn off suddenly.  Maybe I should make
> > this CAP_SYS_ADMIN?  Or withdraw it?
> > 
> 
> I'm concerned that fsverity could be disabled after someone has already checked
> for fsverity on a particular file.  Currently users only have to re-check for
> fsverity if they close the file and re-open it (as in that case it might have
> been replaced with a new file with fsverity disabled).
> 
> A similar issue also would exist for the in-kernel users of fsverity such as
> overlayfs and IMA (upstream), and IPE
> (https://lore.kernel.org/linux-security-module/1712969764-31039-1-git-send-email-wufan@linux.microsoft.com/).
> For example, IPE is being proposed to cache some state about fsverity in the LSM
> blob associated with the struct inode.  If fsverity is disabled on an inode,
> that state would get out of sync.  This could allow bypassing the IPE policy.
> 
> CAP_SYS_ADMIN isn't supposed to give a license to bypass all security features
> including LSMs, so using CAP_SYS_ADMIN doesn't seem like a great solution.

Hmm.  What if did something like what fsdax does to update the file
access methods?  We could clear the ondisk iflag but not the incore one;
set DONTCACHE on the dentry and the inode so that it will get reclaimed
ASAP instead of being put on the lru; and then tell userspace they have
to wait until the inode gets reclaimed and reloaded?

That would solve the problem of cached state (whether the statx flag
or IPE blobs) going stale because the only time we'd change the incore
flag is when there are zero open fds.

--D

> - Eric
> 

