Return-Path: <linux-fsdevel+bounces-31729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4499A788
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15F9283DE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675A194C75;
	Fri, 11 Oct 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FSwhhPDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7371946DF
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660393; cv=none; b=PtOjIiZHeAm8OhcvcF9Jgwr6f01CH4sPvWHuN6dnauuWPIDFmodkZ05vdfR5+w7R03xOfaxBhka+0V23o0FZZWa4YpnnrC+XTdBJrGLNKUQua3IWHUkP0r5Y4BmHGOvI3DNBstUu3KswS+VmHM+c942PJX4EbC4ETg+da9qtTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660393; c=relaxed/simple;
	bh=7ZNJv84Ggru+dRBRH9nB+hs9zmJA1/4b+RNGVkJ2Gfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg5gpjySK8pQhZ5o+lJPMjfGL3D9fNDSD3ce80ursxBYxLmGGGIc2RnIrDBfGfBFlwfnyeg9N95nlYggGxtkkd06qOVmv0fjmaPllMkFtph2Gr7RNm5nxn3mFmfVRrWYAacPIlVvXM+x/6XGU+Pa/Vi+ZHdu8FZ0XY9BCUGUTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FSwhhPDR; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ9Sz4l0DzNNq;
	Fri, 11 Oct 2024 17:26:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728660387;
	bh=26UHv/aBQrsA4HKeB26LmaMOA8BJMH3xxrfVNd4yAZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSwhhPDRpc6PlL3ay+bvREo3Xg3WSkLSFfN0F11c8I18NGx6UX8LUWvA4aUk7w43X
	 QovUsZDjdfmoJocbFWRfHrk577BFkPa3lOzWAoWdUWHAv04Z/XZ3WB/odhE5LBcHg5
	 5+s6E9J17RSLjynH3V1bqmgkWelXAInz34ZizHn4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ9Sy4F45zWyV;
	Fri, 11 Oct 2024 17:26:25 +0200 (CEST)
Date: Fri, 11 Oct 2024 17:26:22 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.Zath4ceey7ah@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
 <20241011.Di7Yoh5ikeiX@digikod.net>
 <7b379fd1-d596-4c19-80fc-53838175834e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b379fd1-d596-4c19-80fc-53838175834e@I-love.SAKURA.ne.jp>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 11:27:45PM +0900, Tetsuo Handa wrote:
> On 2024/10/11 20:04, Mickaël Salaün wrote:
> > On Fri, Oct 11, 2024 at 07:12:17PM +0900, Tetsuo Handa wrote:
> >> On 2024/10/11 0:26, Mickaël Salaün wrote:
> >>> When a filesystem manages its own inode numbers, like NFS's fileid shown
> >>> to user space with getattr(), other part of the kernel may still expose
> >>> the private inode->ino through kernel logs and audit.
> >>
> >> I can't catch what you are trying to do. What is wrong with that?
> > 
> > My understanding is that tomoyo_get_attributes() is used to log or
> > expose access requests to user space, including inode numbers.  Is that
> > correct?  If yes, then the inode numbers might not reflect what user
> > space sees with stat(2).
> 
> Several questions because I've never seen inode number beyond UINT_MAX...
> 
> Since "struct inode"->i_ino is "unsigned long" (which is 32bits on 32-bit
> architectures), despite stat(2) is ready to receive inode number as 64bits,
> filesystems (except NFS) did not use inode numbers beyond UINT_MAX until now
> so that fs/stat.c will not hit -EOVERFLOW condition, and that resulted in
> misuse of %lu for e.g. audit logs?

Yes, I think other filesystems (e.g. tmpfs) only enable 64-bit inodes on
64-bit architectures.

> 
> But NFS was already using inode numbers beyond UINT_MAX, and e.g. audit logs
> had been recording incorrect values when NFS is used?

Correct, all the logs with NFS inodes are wrong.

> 
> Or, some filesystems are already using inode numbers beyond UINT_MAX but the
> capacity limitation on 32-bit architectures practically prevented users from
> creating/mounting filesystems with so many inodes enough to require inode
> numbers going beyond UINT_MAX?

I think so but I didn't take a look at all other filesystems.

> 
> 
> 
> You are trying to fix out-of-sync between stat(2) and e.g. audit logs
> rather than introducing new feature, aren't you?

Yes

> 
> Then, what you are trying to do is OK, but TOMOYO side needs more changes.
> Since TOMOYO is currently handling any numeric values (e.g. uid, gid, device
> major/minor number, inode number, ioctl's cmd number) as "unsigned long",
> most of "unsigned long" usage in TOMOYO needs to be updated to use "u64"
> because you are about to change inode number values to always-64bits.
> 

OK, could you please send a full patch in reply to this email?  I'll
include it in the next patch series.

