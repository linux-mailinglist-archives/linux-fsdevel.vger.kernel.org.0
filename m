Return-Path: <linux-fsdevel+bounces-67964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 758FAC4ED4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6DB14F5E3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235C36996A;
	Tue, 11 Nov 2025 15:36:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62F366562;
	Tue, 11 Nov 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875409; cv=none; b=B6zs9injkHOKscaqMhX+U0AJYY04k5p8rILZbiOFqn+RenEVgmR6UHD2MKTt5cnX92T5uhvtHFWWa5FgFaH1hI8tD6sZUtn+l2Q5hbjqCx0uEUOWom5k8FIRuJDu3Qx+qciv6f+vXhMFM+q2cB+u9cLkQzCtAzMPpTMlg8juYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875409; c=relaxed/simple;
	bh=9+6HcLZ+rN/pP4x7GqoMSdRqDZk9W3d7cDMcK026P0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK5f0T8OCNqJhIPJs4FTUQZI/zUUL0uKkes1Z6DAtLJLo7JDIu5ypQQ6FWkk0WnKSGeFonSJ0Bv82I8oijOe2tKERb5pkNU0zfp9l3fjiRVlg1THMx3i5hS+1yBaBRM/03vl/Mctdlo/ZNSmX/qwKeKrUfaT6JrT/ZIMs+393Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DAD8227AAA; Tue, 11 Nov 2025 16:36:40 +0100 (CET)
Date: Tue, 11 Nov 2025 16:36:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Benjamin Coddington <bcodding@hammerspace.com>, jlayton@kernel.org,
	neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [Patch 0/2] NFSD: Fix server hang when there are multiple
 layout conflicts
Message-ID: <20251111153639.GA9887@lst.de>
References: <20251106170729.310683-1-dai.ngo@oracle.com> <ADB5A1E8-F1BF-4B42-BD77-96C57B135305@hammerspace.com> <e38104d7-1c2e-4791-aa78-d4458233dcb6@oracle.com> <5f014677-42c4-4638-a2ef-a1f285977ff4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f014677-42c4-4638-a2ef-a1f285977ff4@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 10:34:04AM -0500, Chuck Lever wrote:
> > This would help, and I prefer this route rather than rework __break_lease
> > to return EAGAIN/jukebox while the server recalling the layout.
> 
> Jeff is looking at continuing Neil's work in this area.
> 
> Adding more threads, IMHO, is not a good long term solution for this
> particular issue. There's no guarantee that the server won't get stuck
> no matter how many threads are created, and practically speaking, there
> are only so many threads that can be created before the server goes
> belly up. Or put another way, there's no way to formally prove that the
> server will always be able to make forward progress with this solution.

Agreed.

> We want NFSD to have a generic mechanism for deferring work so that an
> nfsd thread never waits more than a few dozen milliseconds for anything.
> This is the tactic NFSD uses for delegation recalls, for example.

Agreed.  This would also be for I/O itself, as with O_DIRECT we can
fully support direct I/O, and even with buffered I/O there is some
limited non-blocking read and write support.

