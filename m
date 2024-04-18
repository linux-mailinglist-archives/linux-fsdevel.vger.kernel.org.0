Return-Path: <linux-fsdevel+bounces-17226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A7C8A9327
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 08:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4C281D5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8122125777;
	Thu, 18 Apr 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt09tdFI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672D63C;
	Thu, 18 Apr 2024 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422180; cv=none; b=R8XUVNe3BzpAJ4QXgfKMIIbdzF0GIr7B5aLnMw4EiCAEDp2GB1bJ6QMpvzwaSK0+KbzwF4Ty/WxmWcfnuOvBZihpaQQbxMz6aDdf2xZvxQxOEX75WtMH9ps78BEqCk76of+/se7bARCipqEX8uQVj9Ni9QbT16+gjBsNukUC/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422180; c=relaxed/simple;
	bh=mrGvViLXE2Mtys96KlxXPpWUSmLfiAiORWlV5HWduYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfIX9KeksPI7VbyjnxCqQtgQEH8OQaPLCdiKTfkjiYIeEKrfWp9pxiZsxyG8QiRfj4yF4ZcnbmJhdiJmH4WDJGgAXnBJgNNKsa7urbxxtJCTgIl+4YlwiZWs0d4Ev7Ue9UTKv94ynShxYf7Z6UMuYA9vBkan/7YHJ4fF1xp5s5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt09tdFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431DFC113CC;
	Thu, 18 Apr 2024 06:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713422179;
	bh=mrGvViLXE2Mtys96KlxXPpWUSmLfiAiORWlV5HWduYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pt09tdFI852k4gRs4+vIvyJEIqllpjdD3URBRFDXWDwJXbWxvpjCVW2e3zVtPjrlC
	 5FwlpI0XC6Vh2gSzOYN/gkRtXV0dUKKmjuh1A5Vbb0dXBhnzscA6VlzNLSR1CAkLNN
	 gcTSqfDXlf2LQqwn+pmJtNKxOI8htCNJ5EX2dfc/mV6L+pHwCuFp0fzkJJRsqY3Sar
	 J6+vuKnfuL5usGB7pKvJYQ+bXFzLCwt4+S3UiG2vbC2lXlJyPVE1awRDbevI1LnY0B
	 1uq96psSGgzHQItcu8qCxbUhGssO6oSmG+KIDo0Ab2D/Msfe8ruzpjIPkmWhvqmlCf
	 pVLxqOsnqptzA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxLNd-000000000Q3-0L4L;
	Thu, 18 Apr 2024 08:36:21 +0200
Date: Thu, 18 Apr 2024 08:36:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
	regressions@lists.linux.dev
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <ZiC_ZQcIjM3xv3zT@hovoldconsulting.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <015aa42b-abac-4810-8743-43913ab8e2d9@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015aa42b-abac-4810-8743-43913ab8e2d9@paragon-software.com>

On Wed, Apr 17, 2024 at 07:07:06PM +0300, Konstantin Komarov wrote:
> On 25.03.2024 11:34, Christian Brauner wrote:
> > This causes visible changes for users that rely on ntfs3 to serve as an
> > alternative for the legacy ntfs driver. Print statements such as this
> > should probably be made conditional on a debug config option or similar.

> The initial and true reason for multiple warnings is the disregard of 
> short (DOS) names when counting hard links.
> 
> This patch should fixes this bug:
> https://lore.kernel.org/ntfs3/0cb0b314-e4f6-40a2-9628-0fe7d905a676@paragon-software.com/T/#u

As I just replied in that thread, I'm also seeing link counts being
reduced from 3 to 1, that is, to not just be decremented by one due to
the DOS name bug.

Are you sure there are no further issues here and that the patch is
indeed correct?

I did not test the patch, which is white-space damaged, but if it
addresses also the remaining warnings then the commit message would need
to be updated as well.

Johan

