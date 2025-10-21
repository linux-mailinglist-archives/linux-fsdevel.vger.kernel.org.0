Return-Path: <linux-fsdevel+bounces-64928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96607BF6C2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D6D486575
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1D3370F9;
	Tue, 21 Oct 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cShytyIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C7334C38
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053129; cv=none; b=VzEX2baQGRMLcHiPPIseG6sekJ+nEUOc1eA49TUsgshKJ9CIlW3m3+I22423aAcg8JxpJ/TVpveKnQSOEb3oWJvEUxbxUH1Zr4VlvZL6+1/28XlHXdrTOnpAbXtA856OjN1EmcLkVtoKoLRgfZR4kmGSRSD9qBUbcjf3z4CpAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053129; c=relaxed/simple;
	bh=JzgDv/RfOhMuQvoaod65TzGOljuExVlcA6WBMBonTlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArRWhyiq5dmjlxfyiPt9IJ5NKksMxgzsSqLv7u1zQohxDXk0CFWFN2wZpk+RwuSrjTmY7dJd4CkPxDAgLvlQcgXMoigzjMj8jFJtDJWD1qM86WDf/ALfiTozerkt11P7BRVcy5e7Cu28f6Ycx+tavGFSeX1fC6czPk7KOQOkrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cShytyIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D365C4CEF1;
	Tue, 21 Oct 2025 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053128;
	bh=JzgDv/RfOhMuQvoaod65TzGOljuExVlcA6WBMBonTlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cShytyIsmiJO1UhosNbO0CHuwe0rLfhQkJagl/5h9T2SphJBEzVMr1R3etrEbMrXX
	 r5jd9DHepgknXVGzRogEVsKiuhU1iD/Hi4wfxRJAuTsuFktiwz677EctOAGFvd2mTI
	 mo1DBwbGqrwZiyS8d71/Ui3ICsSkV94jQpB9EqzZEmEPegiw7oEwulrwY6iza782p5
	 GNEPPe7iThAa/qZc53kAlzbwn3rKXw625CwC3KFByY5JoR1hBg0k5ACs87p5C/tcyB
	 J0guRi6oIjxudW/01sTdmyh0BZXL5LxsHW+0DI7nwJLTe5UNU94Xnc+Cbr1wb0iCuV
	 Jz+UFi6qhvfnw==
Date: Tue, 21 Oct 2025 15:25:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 end_renaming()
Message-ID: <20251021-kakteen-infekt-183f22b3e4a4@brauner>
References: <20251015014756.2073439-1-neilb@ownmail.net>
 <20251015014756.2073439-10-neilb@ownmail.net>
 <CAOQ4uxg27fWDEqQYJ9yw25PTZ37qjNUJu36SfQNwdCComP0UOA@mail.gmail.com>
 <CAOQ4uxjVTpK1OYU9vHROmeXwcs5B+nc67=G7s1YBvp+PW9vU9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjVTpK1OYU9vHROmeXwcs5B+nc67=G7s1YBvp+PW9vU9A@mail.gmail.com>

On Sun, Oct 19, 2025 at 12:33:05PM +0200, Amir Goldstein wrote:
> On Sun, Oct 19, 2025 at 12:25 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 3:48 AM NeilBrown <neilb@ownmail.net> wrote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > start_renaming() combines name lookup and locking to prepare for rename.
> > > It is used when two names need to be looked up as in nfsd and overlayfs -
> > > cases where one or both dentrys are already available will be handled
> > > separately.
> > >
> > > __start_renaming() avoids the inode_permission check and hash
> > > calculation and is suitable after filename_parentat() in do_renameat2().
> > > It subsumes quite a bit of code from that function.
> > >
> > > start_renaming() does calculate the hash and check X permission and is
> > > suitable elsewhere:
> > > - nfsd_rename()
> > > - ovl_rename()
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > Review comments from v1 not addressed:
> > https://lore.kernel.org/linux-fsdevel/CAOQ4uxh+NcAv9v6NtVRrLCMYbpd0ajtvsd6c9-W2a7+vur0UJQ@mail.gmail.com/
> >
> 
> Obviously, I am more attached to my comments on the overlayfs
> changes. since you have not replied to those, you might have missed them...

I'll wait for a resend of this version then.

