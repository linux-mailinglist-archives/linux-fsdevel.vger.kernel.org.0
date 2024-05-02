Return-Path: <linux-fsdevel+bounces-18462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A184A8B92B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 02:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7481C21410
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD629AB;
	Thu,  2 May 2024 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo3twMa1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AB7E9;
	Thu,  2 May 2024 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608903; cv=none; b=PkJY7nCoR80tKWbXRYeRCVQboNeUfJsqEkp/hELP55e+ND3MkHRCUZDPbK8Hqj6QOOvrHMyYmBNeHWWjchIXnSgDn1dhCs8XB0BTFspJbQIkdHp+yCNZf+KwMzYk6wPj1Pgx9iDXIstTEE4G9GKYRplxPiw5/9f0A0q4mqPzKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608903; c=relaxed/simple;
	bh=vfRMDD4WJyj6M9KKduCmyLDNkULC6speoHsh3153pzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNoaMtg2EpLJf8pKjRqQSUDCYZvMfR4zaYycgM4m4AVESrMWDgL6mPUbKM3WI6jtR6L5xusafDZjyvUryg61CKAbUYyYPiU0vEIaeplBw4j7nm/xMufuz0xhWUd2GGJ+i+fEyeHkG3wXhPcgJBYTXdFUKx2s+nQknB14SjbkBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo3twMa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D1FC072AA;
	Thu,  2 May 2024 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714608902;
	bh=vfRMDD4WJyj6M9KKduCmyLDNkULC6speoHsh3153pzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vo3twMa1AWKVnYprjZcdYH9bfFp19LLXjL5zKg11BhlpZFhc5x6YbrQkgHizeciEk
	 qBWVEyD/1T8PPeuJ4Mz/wJQoiefVBIx8xAJ07k8xJApBt9VP2tkMBddL7c583mu65M
	 RP41bm4PxfIxIC1h/CZ35VsfoG7LWP2NHfZIc0ShK2H8YcxWC5hXK7TLDxclNIWEvx
	 mXW5xrbuUxOEnGMeFkiRPM4YJBRmZgL+qMtMBR4KqMH8S9+eQgUkwdVCErPRYS581C
	 EgAPQtP4wmzCcFXdeGw0vRVuBShh/Uq2ImqWeWIcLxyZLdPPNPrDqImB9ZS+PKOe3+
	 FGk3nVCOdkYrg==
Date: Thu, 2 May 2024 00:15:01 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: make it possible to disable fsverity
Message-ID: <20240502001501.GB1853833@google.com>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680792.957659.14055056649560052839.stgit@frogsfrogsfrogs>
 <ZjHlventem1xkuuS@infradead.org>
 <20240501225007.GM360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501225007.GM360919@frogsfrogsfrogs>

On Wed, May 01, 2024 at 03:50:07PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 30, 2024 at 11:48:29PM -0700, Christoph Hellwig wrote:
> > On Mon, Apr 29, 2024 at 08:30:37PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Create an experimental ioctl so that we can turn off fsverity.
> > 
> > Didn't Eric argue against this?  And if we're adding this, I think
> > it should be a generic feature and not just xfs specific.
> 
> The tagging is a bit wrong, but it is a generic fsverity ioctl, though
> ext4/f2fs/btrfs don't have implementations.
> 
> <shrug> According to Ted, programs that care about fsverity are supposed
> to check that VERITY is set in the stat data, but I imagine those
> programs aren't expecting it to turn off suddenly.  Maybe I should make
> this CAP_SYS_ADMIN?  Or withdraw it?
> 

I'm concerned that fsverity could be disabled after someone has already checked
for fsverity on a particular file.  Currently users only have to re-check for
fsverity if they close the file and re-open it (as in that case it might have
been replaced with a new file with fsverity disabled).

A similar issue also would exist for the in-kernel users of fsverity such as
overlayfs and IMA (upstream), and IPE
(https://lore.kernel.org/linux-security-module/1712969764-31039-1-git-send-email-wufan@linux.microsoft.com/).
For example, IPE is being proposed to cache some state about fsverity in the LSM
blob associated with the struct inode.  If fsverity is disabled on an inode,
that state would get out of sync.  This could allow bypassing the IPE policy.

CAP_SYS_ADMIN isn't supposed to give a license to bypass all security features
including LSMs, so using CAP_SYS_ADMIN doesn't seem like a great solution.

- Eric

