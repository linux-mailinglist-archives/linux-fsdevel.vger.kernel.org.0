Return-Path: <linux-fsdevel+bounces-15308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE60D88BFF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00391C2B4D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F1DF49;
	Tue, 26 Mar 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5sdY4N9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1533CA40;
	Tue, 26 Mar 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450392; cv=none; b=H0h1aio3RzkAhQbLZISDdkW7jSAqj+O6eq34/TpXfPabqwen0+YONIx9yEiprZWttnjLmd8ZGmYVPNc2PHIc7as3lrd6Ii7QXKWcJPx7WpoIsxXT7H/Gdjk/BYDOrRzhhEoN+ZQGKw91xGtDDc9Z8Gt1ANvF5yIsu50ONFTVvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450392; c=relaxed/simple;
	bh=RtwpU/b3cZgpifZH0sdVkvycWNTWL05WL7gJesfToLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXuEaamgK+VR0x6h1uvla2TjV5IJjJ3bPyx3TOg78nneQ0PqKlZbPHKpkH+D4lHPwAfOHNelMvfHd23vXWTmIg11N61/+E+6XgmwlBxUrwBt6IlfDX6q+f1Hlmw2FK0S+d1e2yQk+LsSMV2LgzO6Wbz8O7c+fzsLaeg7UNJqdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5sdY4N9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A6FC433F1;
	Tue, 26 Mar 2024 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711450391;
	bh=RtwpU/b3cZgpifZH0sdVkvycWNTWL05WL7gJesfToLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5sdY4N9qn5xBPQ1ReVyvi8+o1Lnwh2FYCdTgv1xUc2LJTwTiu6xLCmxrnVeQ7fR/
	 ibcpfDCIxBTQyrOochAvSBSTNluunNNYmc3hp6IyEMsQxJus4SLffShO33SbLZG1Bq
	 l5XcqMspTe5lJWaPta8PY6fv6xetOBS3qhop5ZdK2KTx2VbiaKErdHI1R3f1usPW2k
	 xTuDXcF13NplPCHVoxRpy4wBlgtMuZQd51cvt53iUB8bQw/+rJTezvi7dTkmssmNN4
	 AiVxg59g3sMuM0IqExfjRcDWAIjaFVSxWL8qZT7pJ/kpOoqxP7Cx73VkOJd7QEI2uR
	 wPFbeklsyORLQ==
Date: Tue, 26 Mar 2024 11:53:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/5] cleanup: Fix discarded const warning when defining
 lock guard
Message-ID: <20240326-steil-sachpreis-cec621ae5c59@brauner>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
 <20240216051640.197378-2-vinicius.gomes@intel.com>
 <20240318-flocken-nagetiere-1e027955d06e@brauner>
 <20240318-dehnen-entdecken-dd436f42f91a@brauner>
 <87msqlq0i8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msqlq0i8.fsf@intel.com>

On Mon, Mar 25, 2024 at 05:50:55PM -0700, Vinicius Costa Gomes wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> >
> > So something like this? (Amir?)
> >
> >  
> > -DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
> > -	     revert_creds_light(_T->lock));
> > +DEFINE_LOCK_GUARD_1(cred, struct cred,
> > +		    _T->lock = (struct cred *)override_creds_light(_T->lock),
> > +		    revert_creds_light(_T->lock));
> > +
> > +#define cred_guard(_cred) guard(cred)(((struct cred *)_cred))
> > +#define cred_scoped_guard(_cred) scoped_guard(cred, ((struct cred *)_cred))
> >  
> >  /**
> >   * get_new_cred_many - Get references on a new set of credentials
> 
> Thinking about proposing a PATCH version (with these suggestions applied), Amir
> has suggested in the past that I should propose two separate series:
>  (1) introducing the guard helpers + backing file changes;
>  (2) overlayfs changes;
> 
> Any new ideas about this? Or should I go with this plan?

I mean make it two separate patches and I can provide Amir with a stable
branch for the cleanup guards. I think that's what he wanted.

