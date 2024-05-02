Return-Path: <linux-fsdevel+bounces-18503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7F8B9B43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 15:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E77F1C21CEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911FA83CCF;
	Thu,  2 May 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC/n65fl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCD32C60;
	Thu,  2 May 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655073; cv=none; b=CMMvVAO1weEEPKIAJjF9bXzfdcO1VchZusAzMfIaVkYMTqKDYvSAni5mV8OfvV0OUoZbzlK1hcc+acfuSxncc3PN0qp/mMKD/YpmOwky2OhRf2Gw/vNLhUCE4jxLDmirIKsv9gQdjaY5sCN+sZD1bX6kfj2qCDycoX2jSbAPn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655073; c=relaxed/simple;
	bh=LxYoy5aryNP2HMhsf2xv0naIvXnZbLmH+o8waQE0UrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWD5SlOC25PN080cxgouhoC8R17s7t+i+foj04XMnt+tuFKfIqQj+BJYAmj/AxzMIhAmnlwr/5ZvWOupH5doRCbGgh+dF/jkP4G0c4EPn59nJBlww7GfE6PIT0Tra3d0ZxihHLETKQm2g86YVwKWYHEIWRgzDH8E5AQzAl1z4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC/n65fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFD2C113CC;
	Thu,  2 May 2024 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714655072;
	bh=LxYoy5aryNP2HMhsf2xv0naIvXnZbLmH+o8waQE0UrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iC/n65flUWWkvVzlWCRqHhOK18rapNIuK5TRG/60Hb4VkQXdaXhjcSKi45tYurzXB
	 QYxWML007PwZWEYaYC5JoKXVbpDce+u5GoYgOZE0SB7ENfrm6za00f8roLirVb1LZ2
	 Ed5nKsebg88bbdxqn0+wtWQv00XkjpiY3aUBactJVBXkEmZs916WErcTaPTL6ZXc/Y
	 vLeU2lJk/uHNzbaFk5bqxi0Bj/LKMSfbi5KmylDzMX+PScS9S3Nx7y39QHfXx9U74V
	 qykma9KTEkX+aTgm91VfnSQOKKwOqen6N6WIBBZyofgr0nbg9NQWQd/khkmpQBBeza
	 mvfQlsROA9dWg==
Date: Thu, 2 May 2024 15:04:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: cgzones@googlemail.com, Jan Kara <jack@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, Sohil Mehta <sohil.mehta@intel.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: unify *at syscalls
Message-ID: <20240502-wegweisend-hippen-75aae5b9da3f@brauner>
References: <20240430151917.30036-1-cgoettsche@seltendoof.de>
 <20240502103716.avdfm6r3ma2wfxjj@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502103716.avdfm6r3ma2wfxjj@quack3>

On Thu, May 02, 2024 at 12:37:16PM +0200, Jan Kara wrote:
> On Tue 30-04-24 17:19:14, Christian Göttsche wrote:
> > From: Christian Göttsche <cgzones@googlemail.com>
> > 
> > Use the same parameter ordering for all four newly added *xattrat
> > syscalls:
> > 
> >     dirfd, pathname, at_flags, ...
> > 
> > Also consistently use unsigned int as the type for at_flags.
> > 
> > Suggested-by: Jan Kara <jack@suse.com>
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> 
> Thanks! The change looks good to me. Christian, do you plan to fold this
> into the series you've taken to your tree?

Yep, that's the plan.

