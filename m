Return-Path: <linux-fsdevel+bounces-47601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A5AA0F64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DE84A182A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDD21B9D6;
	Tue, 29 Apr 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/uYZu5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879321B9FE;
	Tue, 29 Apr 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937887; cv=none; b=ah1N1L42IMojBFxkw4JtU1aPn5G/tz85z4XlcBWEEWxRP1tIN5N4nnxcjA9EJL9P1WfRe5jfGHc1Edzlq+/2RoV+gYr1aaOD7qhfKk+TQY03tKxem4OZ2b9YcYb/3NsuvJ7a6TLRvxvrKI1sHKOAZ3ikRE0mvKknL+j7SkgsTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937887; c=relaxed/simple;
	bh=Sn37PoBA6uqfcLiWQTD8NTw2UC4GID4xT6QTryU0oQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrgnW6hUTv54+RIcUsD1XQxsVEOHoK8aTRRXl7zdGmznfEEn1nxfSI3+YWjAqXu/qiHILDKmx1zZLhN/Vtdwxn3NB2/sfuruN5fey6SCUtMJGD1rBYjI2Js9SyNHF5jmyng7rxSJxSM48CUSLBOtiyoCoh6NCoy12GteBaKrJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/uYZu5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08579C4CEED;
	Tue, 29 Apr 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745937887;
	bh=Sn37PoBA6uqfcLiWQTD8NTw2UC4GID4xT6QTryU0oQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/uYZu5c408ALa13N5kX/SmSPfL0m6yn7R0QuEVBQbDAqAgVYE4GQ6bdjR4CybSDm
	 AA+3BlqOoJ59ffnNrj0v5dokfxMpkB/NX7D0VdKr0wrwPxlCRyalKB9B131gVwfP/F
	 jzdnY5MZC309X3t4if4ZgLu59j3SOWn00SboM1CvqC2G7SKwAI9v4oCSWDPNyfekIP
	 a2+zmJ98lzdqnW6PtyH84h9y1JXQ9MG0PiKZcfGCt4qLGI28SRX0sbhp5pwaUn12AB
	 pQJ9g4G+l0yCy1jJG6IsQtBUW0hXPwNOIiXhdZ1YU42N1uw2x3dFJ8cjX1MI1ahd+5
	 nea5zftOOlPOQ==
Date: Tue, 29 Apr 2025 07:44:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v9 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250429144446.GD25655@frogsfrogsfrogs>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-6-john.g.garry@oracle.com>
 <20250429122105.GA12603@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429122105.GA12603@lst.de>

On Tue, Apr 29, 2025 at 02:21:05PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 25, 2025 at 04:44:54PM +0000, John Garry wrote:
> > +	/* Configure hardware atomic write geometry */
> > +	xfs_buftarg_config_atomic_writes(mp->m_ddev_targp);
> > +	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
> > +		xfs_buftarg_config_atomic_writes(mp->m_logdev_targp);
> > +	if (mp->m_rtdev_targp && mp->m_rtdev_targp != mp->m_ddev_targp)
> > +		xfs_buftarg_config_atomic_writes(mp->m_rtdev_targp);
> 
> So this can't be merged into xfs_setsize_buftarg as suggeted last round
> instead of needing yet another per-device call into the buftarg code?

Oh, heh, I forgot that xfs_setsize_buftarg is called a second time by
xfs_setup_devices at the end of fill_super.  xfs_setup_devices is a
better place to call xfs_buftarg_config_atomic_writes.

I don't like the idea of merging the hw atomic write detection into
xfs_setsize_buftarg itself because (a) it gets called for the data
device before we've read the fs blocksize so the validation is
meaningless and (b) that makes xfs_setsize_buftarg's purpose less
cohesive.

--D

