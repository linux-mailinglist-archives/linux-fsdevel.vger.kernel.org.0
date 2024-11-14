Return-Path: <linux-fsdevel+bounces-34795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890169C8CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D5A1F22F07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256E39FF3;
	Thu, 14 Nov 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixCBApAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82A45C18;
	Thu, 14 Nov 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594441; cv=none; b=ugbnEFpNk0qag2/E71ayek5/+EWrD0CNZu1YgXyi858USBLw1edzoybiI7aMIE2SxgGjPZ4d6itWLe4sdfk+3jhV5BVtcbcoGj5Y1kIOwEFFmbpUP8OVXQMPqWN+qeR5yVTc7IM+BkGB/WpxNsWXyLPWCs1x44cgyDeyu96nwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594441; c=relaxed/simple;
	bh=RttMla1agAuMy1UR4i926rrAGPIvTpDPS8i0LswFYoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0K3RHwUjQJcpXkk+aWO0xLyecTnOZVAx797O0pMplMJRyg2BAsbccngiMj23309JOGa+ePlzjkeVVUXfv8MgSa7JbqFKLbD90g8YbCvDL6xiEveE6DnXBtO9zYYUMJaX01dlmBYekXNgVLl+u7utg/i0MOFEvmR7lGsrOpZqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixCBApAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E43C4CECD;
	Thu, 14 Nov 2024 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731594437;
	bh=RttMla1agAuMy1UR4i926rrAGPIvTpDPS8i0LswFYoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixCBApAn2dmJy6SoOKtL2J4k+OqHQNyWnPDyVeyFGMHuACHBS8PNUN4l7G14Uj+T4
	 MWgp9++CAil1MyfV/uFcNZXY1IL/snMH34AP0jNGzkjcvpqe8/3z9mHT+K0SensGPJ
	 +8JYtzegSjrG6t8FNyiqdXATN5MaUM+zAScyIG7JHB++ko44Ds/zOFpO3xW1axjGE1
	 BrcQE0wmMzIkbH4Ri7lQWcyY2q3ESBzb8xQLfut+fV9/tsYjGl4L44bOpVhdPFbcAH
	 +CkUVYW9vSEooPJya9J81NAZDxdkDjR3W05Wd5Q3PUtMipB0c317tPBntOAJ1OLTLL
	 wYP9VghPDpvkQ==
Date: Thu, 14 Nov 2024 15:27:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pidfs: implement file handle support
Message-ID: <20241114-fragt-rohre-28b21496ecbc@brauner>
References: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>
 <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <CAOQ4uxg4Gu2CWM0O2bs93h_9jS+nm6x=P2yu4fZSL_ahaSqHSQ@mail.gmail.com>
 <431019de-b6c6-474b-bf1f-e0afcdc0ce63@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431019de-b6c6-474b-bf1f-e0afcdc0ce63@e43.eu>

On Thu, Nov 14, 2024 at 01:48:02PM +0100, Erin Shepherd wrote:
>    
> 
> On 14/11/2024 08:02, Amir Goldstein wrote:
> > On Wed, Nov 13, 2024 at 7:01 PM Erin Shepherd <erin.shepherd@e43.eu> wrote:
> >> Since the introduction of pidfs, we have had 64-bit process identifiers
> >> that will not be reused for the entire uptime of the system. This greatly
> >> facilitates process tracking in userspace.
> >>
> >> There are two limitations at present:
> >>
> >>  * These identifiers are currently only exposed to processes on 64-bit
> >>    systems. On 32-bit systems, inode space is also limited to 32 bits and
> >>    therefore is subject to the same reuse issues.
> >>  * There is no way to go from one of these unique identifiers to a pid or
> >>    pidfd.
> >>
> >> This patch implements fh_export and fh_to_dentry which enables userspace to
> >> convert PIDs to and from PID file handles. A process can convert a pidfd into
> >> a file handle using name_to_handle_at, store it (in memory, on disk, or
> >> elsewhere) and then convert it back into a pidfd suing open_by_handle_at.
> >>
> >> To support us going from a file handle to a pidfd, we have to store a pid
> >> inside the file handle. To ensure file handles are invariant and can move
> >> between pid namespaces, we stash a pid from the initial namespace inside
> >> the file handle.
> >>
> >>   (There has been some discussion as to whether or not it is OK to include
> >>   the PID in the initial pid namespace, but so far there hasn't been any
> >>   conclusive reason given as to why this would be a bad idea)
> > IIUC, this is already exposed as st_ino on a 64bit arch?
> > If that is the case, then there is certainly no new info leak in this patch.
> 
> pid.ino is exposed, but the init-ns pid isn't exposed anywhere to my knowledge.

I see what you mean. That might be an information leak. Not a very
interesting one, I think but I need to think about it.

> 
> >> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> >> ---
> >> Changes in v2:
> >> - Permit filesystems to opt out of CAP_DAC_READ_SEARCH
> >> - Inline find_pid_ns/get_pid logic; remove unnecessary put_pid
> >> - Squash fh_export & fh_to_dentry into one commit
> > Not sure why you did that.
> > It was pretty nice as separate commits if you ask me. Whatever.
> 
> I can revert that if you prefer. I squashed them because there was some churn
> when adding the init-ns-pid necessary to restore them, but I am happy to do
> things in two steps.
> 
> Do you prefer having the final handle format in the first step, or letting it
> evolve into final form over the series?
> 

