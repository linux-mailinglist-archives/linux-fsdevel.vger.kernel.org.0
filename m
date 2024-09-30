Return-Path: <linux-fsdevel+bounces-30333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DFD989E72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209A9B22FE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8FD18A948;
	Mon, 30 Sep 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khwuO8XZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18018A92D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688786; cv=none; b=nVFXvNQ+BQyqjSPJAQ//QjXa1rkka+M+UnT6HXm6RE6kel1ra6YJXDQ3eVgebcRwuVXGpzzOxSbO5wtc4t4ixYkx8tFTWgPKFoBZUe8UUcx8wnFWcppvi14xgB2Ti1xv2wZoo729C2Sodq1YSVXqDUJ5YbCY8QcZzXLCcJC0vQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688786; c=relaxed/simple;
	bh=BWky95jMTk76TZro/HuvJJLuwzVkUJEFqg25gAhL3I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmcimhR21eivRuWWUG9x+WtIgNyiKeXfCv2RWI+GITt1Xy8LZaWWqmvsRzL2bCJvHbp1uVOIfAJbCvviyIYOFyK8BMPZVM4csyHT+z306f5ps4PZcw1DADpeLNNawbza+hmCJxACysNXetUfBmiQ5lpIr5hb7tEHJ1xnFHwRK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khwuO8XZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC86C4CECD;
	Mon, 30 Sep 2024 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727688785;
	bh=BWky95jMTk76TZro/HuvJJLuwzVkUJEFqg25gAhL3I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khwuO8XZhvC8p35YJ2J17zs4W3jM3hxSBo5bh2Spyy5UgEkQ3mSpoNSoHLjXdxpIN
	 NKHNO+pxiWIke/fOdCgftIofUw/A5Z6IjpqHoaeCchuAFL/xuwVcocim5RIQz6sXpc
	 c3SoEajAaEijakgzEyj2XNPzyhcHLcgcHEnhOMvoqzMKLbjN95kWFJxt4EGKpnu9Nw
	 gYuRUmYd5dySCzkpQ/CaRi19sjeiqycnG2Kl19D1gKHyBq3Yf0QpLllm4Agh4jM6Fs
	 WA7IC8i7dxc1i3VXr2t6mo+U3mrrQZyIedL2dwb0xfI/wR9lmUOz1xB7MU1XTZXzT1
	 VnA+TwEWFjg5g==
Date: Mon, 30 Sep 2024 11:33:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2] vfs: Add a sysctl for automated deletion of dentry
Message-ID: <20240930-jeden-wahrlich-c7981af844aa@brauner>
References: <20240929122831.92515-1-laoar.shao@gmail.com>
 <CAHk-=wi_2Y3=CjaZpi9mH3wq_E96EaJ133jRRg_vaR0Oi94R2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_2Y3=CjaZpi9mH3wq_E96EaJ133jRRg_vaR0Oi94R2Q@mail.gmail.com>

On Sun, Sep 29, 2024 at 10:07:31AM GMT, Linus Torvalds wrote:
> On Sun, 29 Sept 2024 at 05:29, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > This patch seeks to reintroduce the concept conditionally, where the
> > associated dentry is deleted only when the user explicitly opts for it
> > during file removal. A new sysctl fs.automated_deletion_of_dentry is
> > added for this purpose. Its default value is set to 0.
> 
> I look at this patch, and part of me goes "I think we should make it a
> mount option", but at the same time I'm not sure it's worth the extra
> complexity, since this is such a special case.
> 
> So Ack. While I'm not convinced a sysctl is the way to go, I also
> don't think it's worth bikeshedding any further, at least until we
> have other cases that care.
> 
> Christian, I assume this will come through you? Or should I just pick
> it up directly?

Yes. I'm just digging myself out from the mail avalance since coming
back from Vienna. I'll get to it today.

