Return-Path: <linux-fsdevel+bounces-43599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A55A594AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 13:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FD13A9CFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4579227567;
	Mon, 10 Mar 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrNRJdDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067C1C07D9;
	Mon, 10 Mar 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610332; cv=none; b=OSppeuPJj5mnnRTQM/nXMQedMNL/OUQQRRb7/vIGwSzcTV+zHCez6HTg1/W5mOrUifa5gJXnJDatcHEewUMhvuoDdO5hXjdn34bJfoCCB/RbwQ2FE1w86UvHFM+A2QVeQu2enTp8oOJxGmUylGJYrI5RlwUlYPUyac1PDvjYKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610332; c=relaxed/simple;
	bh=WRKwgp9/W2Uc6gBCt9hZjYK7YEjuemL/fdknnANjgrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXf+gp8uOEZAsszZnamfdfhm5ivMSMe5EuCVjdve22pidLPHktnYiqmDsEBQ+YDfB8G9wmzRKy62UHzGro8QZpyjSYjAg/VEF/xpl/HRzYs74PjiuDXAbe1JzwgIhdLBZHM5rmfBjnZkzTq7eSvfhnf5cwzGQS6t2FNFCZF8yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrNRJdDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA527C4CEE5;
	Mon, 10 Mar 2025 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741610331;
	bh=WRKwgp9/W2Uc6gBCt9hZjYK7YEjuemL/fdknnANjgrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrNRJdDLtTBy9a0IsCmi6ZPi/OrvBuzzHIrI8BSvn2txMWZVOhyPubuxmrukT1P8a
	 BkFMpqj9hdJCV3LWELD0lyA+35RRl963k4J2lwCdgEHYaCqEz7jsQAfS0uPi4byZKy
	 QkHKi00NHG1NYyXjbL8KpIGqPlo9oVf/uf6UUFjqKeN2YTjBZ6k3TN3kqZc76YadEm
	 hCqGImrv9WuBiLJXSGuTcowGm6DC/c+JktsWvj3j2LzO6QvPtFBF3h5rb4T8hA7yZW
	 qtWitDPxukyqBsDgzRUxleuanwjrdR3lykxnFDzO5DnDwrfe9hTnhK0e4yxrK3eoIs
	 MD4JYvPe2/iiQ==
Date: Mon, 10 Mar 2025 13:38:40 +0100
From: Carlos Maiolino <cem@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 11/12] xfs: Update atomic write max size
Message-ID: <vdar74f5jw6je4z2lbpconpitcevl2mdp7hatp62tf4kop6fnq@nhtboaaaar4v>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <2LEUjvzJ3RO3jyirsnti2pPKtOuVZZt-wKhzIi2mfCPwOESoN_SuN9GjHA4Iu_C4LRZQxiZ6dF__eT6u-p8CdQ==@protonmail.internalid>
 <20250303171120.2837067-12-john.g.garry@oracle.com>
 <bed7wptkueyxnjvaq4isizybxsagh7vb7nx7efcyamvtzbot5p@oqrij3ahq3vl>
 <QIPhZNej-x0SeCVuzuqhmRIPUPKvV7w_4DB3ehJ2dYmLS1kwYGIJi1F3F34dhPTCy6oBq_3O-4Kjxxt4cIiP9Q==@protonmail.internalid>
 <c2fdb9bb-e360-4ece-930d-bab4354f1abf@oracle.com>
 <egqflg5pygs4454uz2yjmoachsfwpl3jqlhfy3hp6feptnylcl@74aeqdedvira>
 <Y_Bg5L4XDukci667dxJMc9smhcW9Yz9EtBzX00M1L0lGfTouxvMztMPoBnG7m56FYpJhi_76fdjJ7ShIMbNr4A==@protonmail.internalid>
 <cb7a9d18-c24d-4d90-881b-1914a760a378@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7a9d18-c24d-4d90-881b-1914a760a378@oracle.com>

On Mon, Mar 10, 2025 at 11:20:23AM +0000, John Garry wrote:
> On 10/03/2025 11:11, Carlos Maiolino wrote:
> > On Mon, Mar 10, 2025 at 10:54:23AM +0000, John Garry wrote:
> >> On 10/03/2025 10:06, Carlos Maiolino wrote:
> >>>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> >>>> index fbed172d6770..bc96b8214173 100644
> >>>> --- a/fs/xfs/xfs_mount.h
> >>>> +++ b/fs/xfs/xfs_mount.h
> >>>> @@ -198,6 +198,7 @@ typedef struct xfs_mount {
> >>>>    	bool			m_fail_unmount;
> >>>>    	bool			m_finobt_nores; /* no per-AG finobt resv. */
> >>>>    	bool			m_update_sb;	/* sb needs update in mount */
> >>>> +	xfs_extlen_t		awu_max;	/* data device max atomic write */
> >>> Could you please rename this to something else? All fields within xfs_mount
> >>> follows the same pattern m_<name>. Perhaps m_awu_max?
> >> Fine, but I think I then need to deal with spilling multiple lines to
> >> accommodate a proper comment.
> >>
> >>> I was going to send a patch replacing it once I had this merged, but giving
> >>> Dave's new comments, and the conflicts with zoned devices, you'll need to send a
> >>> V5, so, please include this change if nobody else has any objections on keeping
> >>> the xfs_mount naming convention.
> >> What branch do you want me to send this against?
> > I just pushed everything to for-next, so you can just rebase it against for-next
> >
> > Notice this includes the iomap patches you sent in this series which Christian
> > picked up. So if you need to re-work something on the iomap patches, you'll
> > probably need to take this into account.
> 
> Your branch includes the iomap changes, so hard to deal with.

> For the iomap change, Dave was suggesting a name change only, so not a
> major issue.

If you don't plan to change anything related to the iomap (depending on the path
the discussion on path 5/12 takes), I believe all you need to do is remove the
iomap patches from your branch, sending only the xfs patches.

> So if we really want to go with a name change, then I could add a patch
> to change the name only and include in the v5.
> 
> Review comments are always welcome, but I wish that they did not come so
> late...

That's why I didn't bother asking you to change xfs_mount until now, I'd do it
myself if you weren't going to send a V5.
But Dave's comments are more than a mere naming convention, but logic
adjusting due to operator precedence.

Carlos

> 
> Thanks,
> John

