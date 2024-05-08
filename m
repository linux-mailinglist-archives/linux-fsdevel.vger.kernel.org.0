Return-Path: <linux-fsdevel+bounces-19085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E545A8BFC3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226901C20F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6F82492;
	Wed,  8 May 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDWFMJXj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0E8120A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168274; cv=none; b=ewFpP/MjBrS9Wavory16gMAJsxGJJRDaBgFLX6A46yN91Zl25UOkbBj5qPdHxJcEA446eBIGPk5gNjHIQbgqrNKGiWqjzlru5CoNfVaZNIAtcie18twjr2JydWujF4n9t9igJk2Fvi5kuk9RZm7GPtFlOQCqavrLWc+SdQlYqZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168274; c=relaxed/simple;
	bh=pfjIocG+7TQ87eVVkXgoqky7MM6rtfZR+3UgKfMogYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihf+EPGnm7X8qH6hm578cjnFSpSsB2hLeMQzNUR8Kp0J3Cqst85htBTzZCNGmgXo2aT4udyeU+hNO344X5+LVvP2cxWz/ikRUAR5WTa5WOp5HyZz9MFOxaQ0Er4qHSaOQAq8BjkE/Io1Ftm5Gmor3m2t9Z5SfYoUwiDZiJwWUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDWFMJXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90197C3277B;
	Wed,  8 May 2024 11:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715168274;
	bh=pfjIocG+7TQ87eVVkXgoqky7MM6rtfZR+3UgKfMogYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDWFMJXjN7WuMd3gIXTuS0LTkpqjruAph2tptODNCcaZ315veKZ+pmeC8j0QVxzya
	 PJQ2IHeClND9fgYcQde6bgkTo4x9kxJyprxli1ZJAwN8dPslAvxEb9CUgFVZo7J7HI
	 0AzGe8yMrbZr2Crtwdj1fBSSM3pCK/UT7dS30WKIo2GDXBq4UeC9DDZkC7hm06mlRO
	 ITzq2rAX5Eit6Cbk9TAoVSJGkPhDCBpPx74RT1hCvFv0y4IdJ9PYv8QjV5MKIIGOwH
	 Dztq/3vOyr7E27WqmbFc0AY/K3ZE+0zSEte4AtKMX/XiorNUYNRub8HGJe9CTJi72Y
	 Mh+bxk3Cypf6w==
Date: Wed, 8 May 2024 13:37:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dawid Osuchowski <linux@osuchow.ski>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240508-geeinigt-anbruch-d41b994120ed@brauner>
References: <20240426075854.4723-1-linux@osuchow.ski>
 <20240426-singt-abgleichen-2c4c879f3808@brauner>
 <20240508004106.GL2118490@ZenIV>
 <20240508004659.GM2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240508004659.GM2118490@ZenIV>

On Wed, May 08, 2024 at 01:46:59AM +0100, Al Viro wrote:
> On Wed, May 08, 2024 at 01:41:06AM +0100, Al Viro wrote:
> 
> > So it looks like you forgot to push vfs.misc as well...
> 
> BTW, IME it's useful to have all merges either go from tips of
> named branches or from tags - easier to catch that kind of
> SNAFU when one forgets to push the topical out.  You can
> easily see it in e.g. gitk.

Yes, forgot to push vfs.misc. Fixed now!

