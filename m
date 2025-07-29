Return-Path: <linux-fsdevel+bounces-56296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A395AB15610
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596077A1E77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E1428750B;
	Tue, 29 Jul 2025 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqz19RF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DA19D8BC;
	Tue, 29 Jul 2025 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832336; cv=none; b=f3ECTDC6v6hgh3ra8l6dk9bmuhXDpdjsUP9QmM2GCLitZG4Wjgfr0oNPRXh7eNj3klaNCGYLi8irD85JzlHvoEXqrCIfZFRf0ozNm3+rwNesI4UUpv+hkxoLvhIyvrWcdz3BxazfatWiOP3gledqJ+VxLS6gcfvFyX1+uR4lnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832336; c=relaxed/simple;
	bh=EKG2fWiBudrT/rMZjU5SGTaMs1EGJc7AAmvuurM9zpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAZ9V3NgcKVcJeyY3AzzBSfHxktYnA3oE6+4tWnEOysTN4Ec9A1/LoxHz35/aFbHgtZQaax9jQu8MsxLLLalxBv43h+R15fLdijKbqgxOdX2GqXf0LGtJOznh5bzLHN/CIaaBDn3VzWK8vA3RB5ep2Q88eJvpcr/m4DzcbxVfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqz19RF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA32C4CEEF;
	Tue, 29 Jul 2025 23:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753832335;
	bh=EKG2fWiBudrT/rMZjU5SGTaMs1EGJc7AAmvuurM9zpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nqz19RF5c9IhgnPw2fzDc36U+udYqK1HwsUOI/AuviO2mUgpdanHC3q354OvTlYdw
	 M0DbErpkwQ+XJA/7BkgYVYhvxrpMpPOBK26I/Rh8mTQpiwvq+EDyqkwztREArFLs1U
	 +GCphK9fkf7eKmjTTuOEXjQI08XShX+/I+X/wXyQvRZ/A8gUDrgGD31OAgecjweuGo
	 PviePhZxeugNnF92UmZPsngF+3Kau+vglzLx81aIAa+EaB8wQhWkXTECoJqpyT2dBw
	 EqyohHvO23q9DmNfXZUOirt9Wg4GdPK/KcorE8bachxisvGQaLUo+xMpTpOctmgHk6
	 dWlg7ec/d7/Zw==
Date: Tue, 29 Jul 2025 16:38:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250729233854.GV2672029@frogsfrogsfrogs>
References: <8734afp0ct.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734afp0ct.fsf@igalia.com>

On Tue, Jul 29, 2025 at 02:56:02PM +0100, Luis Henriques wrote:
> Hi!
> 
> I know this has been discussed several times in several places, and the
> recent(ish) addition of NOTIFY_RESEND is an important step towards being
> able to restart a user-space FUSE server.
> 
> While looking at how to restart a server that uses the libfuse lowlevel
> API, I've created an RFC pull request [1] to understand whether adding
> support for this operation would be something acceptable in the project.

Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
could restart itself.  It's unclear if doing so will actually enable us
to clear the condition that caused the failure in the first place, but I
suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
aren't totally crazy.

> The PR doesn't do anything sophisticated, it simply hacks into the opaque
> libfuse data structures so that a server could set some of the sessions'
> fields.
> 
> So, a FUSE server simply has to save the /dev/fuse file descriptor and
> pass it to libfuse while recovering, after a restart or a crash.  The
> mentioned NOTIFY_RESEND should be used so that no requests are lost, of
> course.  And there are probably other data structures that user-space file
> systems will have to keep track as well, so that everything can be
> restored.  (The parameters set in the INIT phase, for example.)

Yeah, I don't know how that would work in practice.  Would the kernel
send back the old connection flags and whatnot via some sort of
FUSE_REINIT request, and the fuse server can either decide that it will
try to recover, or just bail out?

> But, from the discussion with Bernd in the PR, one of the things that
> would be good to have is for the kernel to send back to user-space the
> information about the inodes it already knows about.
> 
> I have been playing with this idea with a patch that simply sends out
> LOOKUPs for each of these inodes.  This could be done through a new
> NOTIFY_RESEND_INODES, or maybe it could be an extra operation added to the
> already existing NOTIFY_RESEND.

I have no idea if NOTIFY_RESEND already does this, but you'd probably
want to purge all the unreferenced dentries/inodes to reduce the amount
of re-querying.

I gather that any fuse server that wants to reboot itself would either
have to persist what the nodeids map to, or otherwise stabilize them?
For example, fuse2fs could set the nodeid to match the ext2 inode
numbers.  Then reconnecting them wouldn't be too hard.

> Anyway, before spending any more time with this, I wanted to ask whether
> this is something that could be acceptable in the kernel, if people think
> a different approach should be followed, or if I'm simply trying to solve
> the wrong problem.
> 
> Thanks in advance for any feedback on this.
> 
> [1] https://github.com/libfuse/libfuse/pull/1219

Who calls fuse_session_reinitialize() ?

--D

> Cheers,
> -- 
> Luís
> 

