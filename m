Return-Path: <linux-fsdevel+bounces-19089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833968BFC79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3979E1F24F90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72B83CB4;
	Wed,  8 May 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R42QFJlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61C823BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168573; cv=none; b=usWyJsqBW+7eEH5G8711fTY/Unm/kTtdB6dkLeztCElaTQJEYcYMhXyaVHyJlinkFB/Uq0Hg/1EneNUbxDl0MFLTlRYIHyb9a46RL4u8mQEd1iW2Z2nKl9uVMLMIu6JPH7CZ/vxnFGXkLJwwz7dpxl6S/bSmg09woUxVG6BCMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168573; c=relaxed/simple;
	bh=m1nwS5uoXmDs2WVu9czWgRK84oBrObiNnuoWONh1f3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRIlcRLqp0G1KafYZmfZU1WNiIIOEsxDqae4nYZnOwRlhGF2CVqCM1GAC2w4HjjTiHMRxf3tenkdKxkwNfPaH5xtPnZBuE/sopCiSBTqIiWMODl8g8dFpW8mZOYupCEEX5FO4sdQuitwA9s63VXfRLpxoJz8cHwLZdha2448xdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R42QFJlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A680C4AF18;
	Wed,  8 May 2024 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715168573;
	bh=m1nwS5uoXmDs2WVu9czWgRK84oBrObiNnuoWONh1f3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R42QFJlxXgsKcZfE/p4Wvi9YYiLVjUe5pBL0Rg1BSVJb01yeG+PO1aDEqkcnpJvDF
	 VOprR4OQpwG6cSV0RiuGHhSssaII01GBzPxFNTWB7DrlZTw4W0OxDcWpm1pKdfNPRY
	 yXFUWqTIVAWfxEuveLh/GS9ETGlS1DDkNjYT3UDZhHlOuHjKv8zDrtNAzX8xG6sR95
	 5GddVcIXWG5/Y4120hdz8fTGQlE9m2CqsFlXEUJzgYvFJr1srM1suB21RgYpwengq5
	 uuMwTb+Vxl6wB0jMLN08Kf7I3JJ7xKW06rqBjzH34cSN9CGEK9QLLusFlv1gq0Pf95
	 dIngGL7d2II1Q==
Date: Wed, 8 May 2024 13:42:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [LSF/MM/BPF TOPIC] finishing up mount API conversions;
 consistency & logging
Message-ID: <20240508-zielt-babykleidung-c39d454f2112@brauner>
References: <12d50bb6-7238-466b-8b67-c4ae42586818@redhat.com>
 <CAOQ4uxiXrSaDg40hpU=ZDpH3DQ3dbJ1XT_77EmM8_K704PyVCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiXrSaDg40hpU=ZDpH3DQ3dbJ1XT_77EmM8_K704PyVCg@mail.gmail.com>

On Wed, May 08, 2024 at 01:32:10PM +0300, Amir Goldstein wrote:
> On Mon, Apr 15, 2024 at 6:59 PM Eric Sandeen <sandeen@redhat.com> wrote:
> >
> > In case this is of interest to anyone I'll propose it.
> >
> > The "new" mount API was merged about 5 years ago, but not all filesystems
> > were converted, so we still have the legacy helpers in place. There has been
> > a slow trickle of conversions, with a renewed interest in completing this
> > task.
> >
> > The remaining conversions are of varying complexity (bcachefs might
> > be "fun!") but other questions remain around how userspace expects to use
> > the informational messages the API provides, what types of messages those
> > should be, and whether those messages should also go to the kernel dmesg.
> > Last I checked, userspace is not yet doing anything with those messages,
> > so any inconsistencies probably aren't yet apparent.
> >
> > There's also the remaining task of getting the man pages completed.
> >
> > There were also some recent questions and suggestions about how to handle
> > unknown mount options, see Miklos' FSOPEN_REJECT_UNKNOWN suggestion. [1]
> >
> > I'm not sure if this warrants a full session, as it's actually quite
> > an old topic. If nothing else, a BOF for those interested might be
> > worthwhile.
> >
> 
> Christian,
> 
> I scheduled a slot for your talk on "Mount API extensions" on Tue 11:30
> before Eric's Mount API conversions session.
> 
> Do you think this is the right order or do you prefer these sessions
> to be swapped?
> 
> Also, this seems like a large topic, so I could try to clear more than
> 30min in the
> schedule for it if you like. the buffer_heads session after your talks
> will probably
> be removed from there anyway.
> 
> I was thinking that we need a followup session for statmount/listmount [1]
> What's still missing (mount change notifications, fsinfo) and what are
> the next steps.
> Are you planning to address those in your session?

Yeah, let's do that in my session. The order is fine by me!

