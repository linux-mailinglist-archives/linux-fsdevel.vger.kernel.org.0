Return-Path: <linux-fsdevel+bounces-56389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C1CB17065
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C391AA66ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B602C08C4;
	Thu, 31 Jul 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/qe3p+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D22C9A;
	Thu, 31 Jul 2025 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961594; cv=none; b=iKIZaSICEhDCkFq/TKCFbsCFice1Pe+TISfBxivRkc5wpR0Z7kjCXg2l8yus1jzQRecTc3/c1y8so+qhCBfV0rjiHdoz6kbTgNYJMexahm0uB5Cu6ohEia9NpvzpFQaWUwKQVsV2lhByyao3QjTu6VWM+vjRCVfQUQgkqYIZIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961594; c=relaxed/simple;
	bh=sTbx7McNSccTMzi7rESQoqeGOeBghvgV4NqCILAaT3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krV+Sbyqe//1+E7z1LV91p6CGlKRR/RdLdFX2BnPcGRWg6wJ6DdvImU22m8cPYE0085w5vYivzgW/6QAh2G6dYa9e3Vkm8W6q2tTR/4f7ueLTnHR8hU+UmK6qGI57JZp8YA/rHejROS0Q/ONTgp7UlzJoV7C8hecx7I9e58vBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/qe3p+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25382C4CEEF;
	Thu, 31 Jul 2025 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961593;
	bh=sTbx7McNSccTMzi7rESQoqeGOeBghvgV4NqCILAaT3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/qe3p+eRLamN7D5azYA3q3rxP2X2iSZAfM7QwsPKP6E8FP9Yg2Nv8oesgdd0gTUT
	 S1ZgL+2m0/CRdjMDGQJl4qYVlbJ7Ms6xuSLFxMczXq/egP8WqscurAeOHlMs0m5amy
	 MEazmBmhAIK9DVgJSBi4JkJEpIZ/ozykpJAQJixkeKNijlMmK5NFEdPrMnkYbZivJf
	 wUnO3nm65BPSCDjrmPt95WU80G7p6nPChf97RLIepkPaWqB8mjx9d4GXOANIkpPaeU
	 KTwQjdavFgRJV3sBYBWcIvVdUwfrutgOTc8bFqi0wCnfQfiZOK4EfIDCTaLg+WO2C+
	 BZsgjIxE10qZg==
Date: Thu, 31 Jul 2025 13:33:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250731-diamant-kringeln-7f16e5e96173@brauner>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs>
 <87freddbcf.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87freddbcf.fsf@igalia.com>

On Wed, Jul 30, 2025 at 03:04:00PM +0100, Luis Henriques wrote:
> Hi Darrick,
> 
> On Tue, Jul 29 2025, Darrick J. Wong wrote:
> 
> > On Tue, Jul 29, 2025 at 02:56:02PM +0100, Luis Henriques wrote:
> >> Hi!
> >> 
> >> I know this has been discussed several times in several places, and the
> >> recent(ish) addition of NOTIFY_RESEND is an important step towards being
> >> able to restart a user-space FUSE server.
> >> 
> >> While looking at how to restart a server that uses the libfuse lowlevel
> >> API, I've created an RFC pull request [1] to understand whether adding
> >> support for this operation would be something acceptable in the project.
> >
> > Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> > could restart itself.  It's unclear if doing so will actually enable us
> > to clear the condition that caused the failure in the first place, but I
> > suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> > aren't totally crazy.
> 
> Maybe my PR lacks a bit of ambition -- it's goal wasn't to have libfuse do
> the restart itself.  Instead, it simply adds some visibility into the
> opaque data structures so that a FUSE server could re-initialise a session
> without having to go through a full remount.
> 
> But sure, there are other things that could be added to the library as
> well.  For example, in my current experiments, the FUSE server needs start
> some sort of "file descriptor server" to keep the fd alive for the
> restart.  This daemon could be optionally provided in libfuse itself,
> which could also be used to store all sorts of blobs needed by the file
> system after recovery is done.

Fwiw, for most use-cases you really just want to use systemd's file
descriptor store to persist the /dev/fuse connection:
https://systemd.io/FILE_DESCRIPTOR_STORE/

> 
> >> The PR doesn't do anything sophisticated, it simply hacks into the opaque
> >> libfuse data structures so that a server could set some of the sessions'
> >> fields.
> >> 
> >> So, a FUSE server simply has to save the /dev/fuse file descriptor and
> >> pass it to libfuse while recovering, after a restart or a crash.  The
> >> mentioned NOTIFY_RESEND should be used so that no requests are lost, of
> >> course.  And there are probably other data structures that user-space file
> >> systems will have to keep track as well, so that everything can be
> >> restored.  (The parameters set in the INIT phase, for example.)
> >
> > Yeah, I don't know how that would work in practice.  Would the kernel
> > send back the old connection flags and whatnot via some sort of
> > FUSE_REINIT request, and the fuse server can either decide that it will
> > try to recover, or just bail out?
> 
> That would be an option.  But my current idea would be that the server
> would need to store those somewhere and simply assume they are still OK

The fdstore currently allows to associate a name with a file descriptor
in the fdstore. That name would allow you to associate the options with
the fuse connection. However, I would not rule it out that additional
metadata could be attached to file descriptors in the fdstore if that's
something that's needed.

