Return-Path: <linux-fsdevel+bounces-27711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81319636E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 02:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8261C21764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 00:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F066EEDD;
	Thu, 29 Aug 2024 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp+WuzEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F636D29E;
	Thu, 29 Aug 2024 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724891549; cv=none; b=tDXNGTQ4JkHaKAzlQBA9UrtKguuEMG61fu66b07BHGvYog4msDVvZiWSy+VyXOlJnn1g4DDkXAQqmFv9mh/soUTPYPPwkVYhJ8QAoyVPt7RjwdZXfS1J9ubw/16Rs9Hhwe1uARh4LiW4jhT/3Hf9EqWYk/987S7+iAcBlTXdCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724891549; c=relaxed/simple;
	bh=dVi7mGJ6niljRO3IJCWQogkHHAOqnUHxrMNLiX6kJkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV8OQZR6nKaXQri77XfDTdkqvYU4YweXHXrJU3jtElsEN38dWHhb7ohKKjuKLfN/bDv/KT4hUyFYswLFpMbejynGeWLfyOPkPVbIojv9NhvlpLUHfbq8SAmFNJ+iq8qsMSCAmnNak+/ZRRHyLK5HWuMk88/9I+NqlwPnWcS2vRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp+WuzEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A981DC4CEC2;
	Thu, 29 Aug 2024 00:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724891548;
	bh=dVi7mGJ6niljRO3IJCWQogkHHAOqnUHxrMNLiX6kJkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zp+WuzEYHSf0Coxoo2KzfgO7YsUSnX7g6N5LKwO79Ug7J9JactMB0DApT+4XFYsUi
	 LYQv0ovBR36XzZbo4dI6PbDV+LPEXBTRnVILDOPU5nT00e6A1wgTkVvmfw+9RHG/+6
	 Rk3kJ2Rd6xlmnadlmdVFR5sa3bzb9hRJQ88FX1P4uK8jov8sLE+JfavVLUtwFY7N2c
	 u3V5ti7oTT9XtZW6q3qmbTvOpPYDwF7KYzsgj0VIMxagduC1rWpcpg8QQxrfZ2O2ID
	 Q3D258yQ/LViLlMBLuffwM8MU6PJR9HUSb9TmorCLir/R2dEvPOu86aOhDqIqSeJcI
	 gm+nWbV1x8gVQ==
Date: Wed, 28 Aug 2024 20:32:27 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
Message-ID: <Zs_Bm2mvqLXLrFTp@kernel.org>
References: <>
 <ZstOonct0HiaRCBM@tissot.1015granger.net>
 <172462948890.6062.12952329291740788286@noble.neil.brown.name>
 <Zs9XzSHGysK4eCJO@tissot.1015granger.net>
 <Zs_BE4l-fNqtjlcB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs_BE4l-fNqtjlcB@kernel.org>

On Wed, Aug 28, 2024 at 08:30:11PM -0400, Mike Snitzer wrote:
> On Wed, Aug 28, 2024 at 01:01:01PM -0400, Chuck Lever wrote:
> > On Mon, Aug 26, 2024 at 09:44:48AM +1000, NeilBrown wrote:
> > > On Mon, 26 Aug 2024, Chuck Lever wrote:
> > > > See comment on 5/N: since that patch makes this a public API again,
> > > > consider not removing this kdoc comment but rather updating it.
> > > 
> > > What exactly do you consider to be a "public API"??  Anything without
> > > "static"?  That seems somewhat arbitrary.
> > > 
> > > I think of __fh_verify() as a private API used by fh_verify() and
> > > nfsd_file_acquire_local() and nothing else.
> > > 
> > > It seems pointless duplication the documentation for __fh_verify() and
> > > fh_verify().  Maybe one could refer to the other "fh_verify is like
> > > fh_verify except ....."
> > > 
> > > ??
> > > 
> > > > 
> > > > 
> > > > > -__be32
> > > > > -fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> > > > > +static __be32
> > > > > +__fh_verify(struct svc_rqst *rqstp,
> > 
> > An alternative would be to leave __fh_verify() as a static, and then
> > add an fh_verify_local() API, echoing nfsd_file_acquire_local(), and
> > then give that API a kdoc comment.
> > 
> > That would make it clear who the intended consumer is.
> 
> I ran with this idea, definite improvement, you'll find the changes
> folded in to the relevant patch (with the same subject) in v14.

Err, sorry, in v14 it'll be patch 9 with subject:
"nfsd: add nfsd_file_acquire_local()" 

