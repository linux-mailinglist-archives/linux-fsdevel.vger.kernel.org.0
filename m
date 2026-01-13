Return-Path: <linux-fsdevel+bounces-73395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A570D1771A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BC6030082C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123543806CE;
	Tue, 13 Jan 2026 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqR5dR46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707323806BA;
	Tue, 13 Jan 2026 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294845; cv=none; b=Q6A40JxJg6YiZbv6qdFAiiwizfRjYAT72OMxMPcTvWkWdvtjxmKlKNAAYOaAmVBSZ3fI/3wbpIY8H0RKMCpX1MGn16QNmpWkmJNEPl9lqfMKOgT1QSU/LRFL6NSQYdHoJHmzc8ye5iIN7L63xyNxW2ttXVjbTX+xLhsHBZlRjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294845; c=relaxed/simple;
	bh=NcgixvU8t6r+aTlPzM5IXWTRH+hNmROWTOh/D6b16pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdfqk3tR1UaQMZ/4QlUJdrDtposA04gFx82TmqiwqyjyE7YLPOOPBh1a/cO3IjJvpjnBlp905gtfyBFEaLzpvJ7lJ5KhkxIAuKMpXs1Rkdqy5UFLk7AKbkZ9G0JIUNy2ZCpuy9gce8p9D62qeAN2ygJ5k85U3TqCFhL9SWNLHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqR5dR46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C3FC116C6;
	Tue, 13 Jan 2026 09:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768294845;
	bh=NcgixvU8t6r+aTlPzM5IXWTRH+hNmROWTOh/D6b16pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqR5dR46SQQhEwlhnrl/iCog79Tx8YUXN+sWQoejtzJKzwPpUYmgA9ukxel01EfhW
	 iWp2lFA945kbp7aN0UyPL6qvzO3MNru5ixfnsahuihxbiFK5DLAJNGCOSl9hc8/gAP
	 e5dzJSmHmtnvO350dZQXtILvP7NAjp917SA5b9jtRZ2AARB22RNMXYjsh5paF9sTDf
	 OLiFKyFOd0tzflPkkxjX9ThZIegrvENwgRqK8f06hco89H4+dS86y5K9tv0FQGqjmX
	 P48LKM2GvXN8TYbbQv+U8uMcwrlAfFgbUGnqHUZ0hc63yM0LloRNFcd9NTdcSBHFrW
	 MGriJdtzvLTqw==
Date: Tue, 13 Jan 2026 10:00:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/4] btrfs: stop duplicating VFS code for
 subvolume/snapshot dentry
Message-ID: <20260113-pulver-rekultivieren-aa251a68a998@brauner>
References: <cover.1767801889.git.fdmanana@suse.com>
 <20260112-wonach-mochten-cd6c14b298ae@brauner>
 <CAL3q7H5xB1RFQK6fn1KL73AiGr-A+SoKCFH1pfwBTxHCkHPXCg@mail.gmail.com>
 <20260113011643.GY21071@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113011643.GY21071@twin.jikos.cz>

On Tue, Jan 13, 2026 at 02:16:43AM +0100, David Sterba wrote:
> On Mon, Jan 12, 2026 at 01:49:07PM +0000, Filipe Manana wrote:
> > On Mon, Jan 12, 2026 at 12:48 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Thu, Jan 08, 2026 at 01:35:30PM +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Currently btrfs has copies of two unexported functions from fs/namei.c
> > > > used in the snapshot/subvolume creation and deletion. This patchset
> > > > exports those functions and makes btrfs use them, to avoid duplication
> > > > and the burden of keeping the copies up to date.
> > >
> > > Seems like a good idea to me.
> > > Let me know once it's ready and I'll give you a stable branch with the
> > > VFS bits applied where you can apply the btrfs specific changes on top.
> > 
> > Right now what's missing is just an update to the changelog of patch
> > 4/4 to mention that the btrfs copy is missing the audit_inode_child()
> > call.
> > 
> > If there are no other comments, I can prepare a v2 with that update,
> > and then you can pick the patches into a branch.
> > For the btrfs patches, you can probably pick them too as they are
> > trivial, though I'll defer to David in case he has a different
> > preference.
> 
> I agree that this is relatively trivial, also it does not affect
> anything in particular we have in for-next, so Christian feel free to
> take it via the vfs trees. Thanks.

Thanks for the trust, appreciate it.

