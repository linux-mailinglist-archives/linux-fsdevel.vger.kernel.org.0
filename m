Return-Path: <linux-fsdevel+bounces-31997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233C599EE91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F571C22ECF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C91B2190;
	Tue, 15 Oct 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAD7GhDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB991AF0DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000893; cv=none; b=Ng/kocN3XrbL1800oQLSKhnpYGy2i8UytgJsN7L6T81H177/469tLq7RRUTzPnW/fg6MgLx66bojeonxc4oWZqJVLUrLoVC/m8FRoiBFeAn2wil+mNUyoUtvTjmfYZnAiBVnWC0UKR051kzrUi3BXOwjn/Zux7ZdLZAC7zupB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000893; c=relaxed/simple;
	bh=REM+2JFObwLN4MpwBXCHS5Z4Amz8NlEpI5oRoF1I5mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgVAW7JsAWh78nLF5ApwCcOfWLPdiFagFRLJek0SmUj4TiYCG6XvrORejpZI1EjYipdKrI7hzE2TsYpTgQsT18+J0SSmD4y7g18XQdFChSfIM8S9tIISiJznB87Xl5inzmjeohbrWV8PXvt0nftzUFAHKcxZgjkWyiQU53ZN6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAD7GhDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB69C4CEC6;
	Tue, 15 Oct 2024 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729000893;
	bh=REM+2JFObwLN4MpwBXCHS5Z4Amz8NlEpI5oRoF1I5mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAD7GhDUZkvxU3eBShCfaw3E6p+UH13NAnCE2XYYqfm4SwUP5uGqxDzQ8ur7GwZH9
	 zQKVmvs/tA9dG7RYC/edeJcmFvnCyI7D4mMUu+rKJLoLj4+cbfx+mr6RljCnh8OyU6
	 Dhe63cesZM9myH3gGVAdEMuoMqRxiTI3ovkgFVJWAbGV6H06qdScR6W/LJTGu3zaEE
	 NsmduNLzT3gD3KGnUQUtbX2nVZvgMvA9tsH2Pn+qk26lvzKkPL8VJqrvkCkk05ZQmb
	 EztwJYkkjemQuZ4x6LtdD6u1oElVd71W1N8QVaCVJB+3vlto3Z7+snCh2g+MW/1LHP
	 pWbZUhO3nOzZQ==
Date: Tue, 15 Oct 2024 16:01:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] : fhandle: relax open_by_handle_at() permission
 checks
Message-ID: <20241015-geehrt-kaution-c9b3f1381b6f@brauner>
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
 <CAOQ4uxhjQwvJZEcuPyOg02rcDgcLfHQL-zhUGUmTf1VD8cCg4w@mail.gmail.com>
 <CAOQ4uxgjY=upKo7Ry9NxahJHhU8jV193EjsRbK80=yXd5yikYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgjY=upKo7Ry9NxahJHhU8jV193EjsRbK80=yXd5yikYg@mail.gmail.com>

On Sun, Oct 13, 2024 at 06:34:18PM +0200, Amir Goldstein wrote:
> On Fri, May 24, 2024 at 2:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, May 24, 2024 at 1:19 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > A current limitation of open_by_handle_at() is that it's currently not possible
> > > to use it from within containers at all because we require CAP_DAC_READ_SEARCH
> > > in the initial namespace. That's unfortunate because there are scenarios where
> > > using open_by_handle_at() from within containers.
> > >
> > > Two examples:
> > >
> > > (1) cgroupfs allows to encode cgroups to file handles and reopen them with
> > >     open_by_handle_at().
> > > (2) Fanotify allows placing filesystem watches they currently aren't usable in
> > >     containers because the returned file handles cannot be used.
> > >
> 
> Christian,
> 
> Follow up question:
> Now that open_by_handle_at(2) is supported from non-root userns,
> What about this old patch to allow sb/mount watches from non-root userns?
> https://lore.kernel.org/linux-fsdevel/20230416060722.1912831-1-amir73il@gmail.com/
> 
> Is it useful for any of your use cases?
> Should I push it forward?

Dammit, I answered that message already yesterday but somehow it didn't
get sent or lost in some other way.

I personally don't have a use-case for it but the systemd folks might
and it would be best to just rope them in.

