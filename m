Return-Path: <linux-fsdevel+bounces-25520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE04794D05D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A768B20A21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEEA1946C4;
	Fri,  9 Aug 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qic2Ni+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922217BBF;
	Fri,  9 Aug 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207317; cv=none; b=KETkwnn5ZTpe+6kix4BQI+CEBx+OgNxQBM3yGhnnBo/dcwdlw05vkhFxfiKemqOE7VLzKK89dNv3gTtMEo6+mdJUC+GOGvN7R/7gLyPQ6BT8s631kEkVLTY5h3X6atkhR8wrROIlZAOWMRb4Y7zldBWOK9T01i4rPpPk7tR026c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207317; c=relaxed/simple;
	bh=HLwCPtG30FgCakDxpDhYlf35tiSqg1izGiXN6Rtuzz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doeB7mEO2pZulkD6LFMSgYGHgKVGm2JUKcqJhfPUwn2CxPPFyFd3QFsgwBISexp3DzlO03duY4ZfWb6V2nPJB4hFn0OgoXkZImVZ5ofwtlRgGA7lDu4cNadmhYjQ01GPHmjBvTOuyJHjLK9HYm6ogVSAgdhnS73khjEcGy8+FeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qic2Ni+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7854C32782;
	Fri,  9 Aug 2024 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723207316;
	bh=HLwCPtG30FgCakDxpDhYlf35tiSqg1izGiXN6Rtuzz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qic2Ni+b7Qjzo7+vXHNGnv6ARiXfWDmGvoPf/qDSDkNAkb3/N2M4r+wMjZE1r2vuq
	 C/wZ2iW++TjCcNWim5gKEu0KmFzDQorqxmIe4+J0FdaoSHmK7R6KGJnK+qYkBSW4vP
	 D6p2XmAkD4KCCYA34YQmn/Xp8QudUx2KyKRxiFhwuqHkA0XBz7XOUJFcVl4w/Ixh4K
	 ft1muRG6VgIDhMJOsmKbCiPsP+3QGxhyflhcflIgmUfDXbimGRLlWt4uGapmYiwOGl
	 K+bsa8xXCwMEU5TGihEe2xv/tfmPATrELn549BtuSW6vGWZ3JxtK91VBoPFM1i4gzh
	 JXCgmPPV/WSPw==
Date: Fri, 9 Aug 2024 14:41:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Morten Hein Tiljeset <morten@tiljeset.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Debugging stuck mount
Message-ID: <20240809-marsch-kreis-1323acfac954@brauner>
References: <22578d44-b822-40ff-87fb-e50b961fab15@app.fastmail.com>
 <20240808-hangar-jobverlust-2235f6ef0ccb@brauner>
 <e244e74d-9e26-4d4e-a575-ea4908a8a893@app.fastmail.com>
 <20240808-kontinental-knauf-d119d211067e@brauner>
 <dc25520d-e068-49bd-9faa-07c6f6928c35@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc25520d-e068-49bd-9faa-07c6f6928c35@app.fastmail.com>

On Fri, Aug 09, 2024 at 09:39:41AM GMT, Morten Hein Tiljeset wrote:
> > The file descriptor could already be closed but the task could be stuck
> > exiting and so queued task work including destroying files wouldn't be
> > done yet. You could also try and see if you can figure out what tasks
> > require your workload to do a lazy umount in the first place. That might
> > bring you closer to the root cause.
> >
> > What kernel version are you running anyway?
> That's an interesting idea about the stuck task, I'll try looking into that. We're not
> doing lazy unmounts on purpose -- I'm only concluding that it must be happening based on
> the mount namespace being NULL. I wonder if the lazy unmount could happen implicitly
> as a consequence of some other operation?

You don't need a lazy umount for this. You could also just have a
container or service exiting that uses a mount namespace. In that case
the last exiting task will close all of its open files and then put the
mount namespace. The mount namespace will unmount all mounts that were
still around NULLing the mntns.

Say P1 has somehow managed to get hold of a file descriptor in some
other mount namespace M1 and holds a file descriptor referring to some
mount in there. Now the last process pinning M1 exists and puts all
mounts associated with M1. Now P1 holds a file descriptor pointing to a
mount that has a NULL mount namespace.

A task could hang running task work because of some device file or
whatever that it's closing. Or it could hang exiting namespaces. I
vaguely remember that years ago on earlier kernels we had some issues
there.

