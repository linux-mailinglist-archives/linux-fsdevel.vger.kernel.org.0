Return-Path: <linux-fsdevel+bounces-12926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D00868B61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48392873C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54688136669;
	Tue, 27 Feb 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTgPVEKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928055E78
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024109; cv=none; b=QLbD/y396KNbgCno/dDlgJkW93weu+ceDll5HP0K2BJKJJbSxyvi8f+MoBOmekspYGtNRr2F0m5B6XnnK8Dtyc+LKj1qRSruZQ20zKZRgwNs2NmB8a6g+sillJkNLunaUoxwN5d11cF4RuT4qQooqLeyICfm2wANkQa3ES/NzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024109; c=relaxed/simple;
	bh=Ezprr0ceJP+fX30x2rCCzplmuePgShwUwAfr1x1H/3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlrMtqImEm9CzFCmEDiexPIVqsr/i1zyRMemL5vqQksD9JdsfEOSwWxkiMpqPP44VdpyBLJREURkjYyFbcTYcZHVxRCpc/EPEUiC8nnuCpatat0LoMj2Q42ELOvfPk5ohEa5UQphHuUHG9J6x+6g0QzWctARBwUJSi6ZEO26Zso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTgPVEKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91229C433C7;
	Tue, 27 Feb 2024 08:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709024109;
	bh=Ezprr0ceJP+fX30x2rCCzplmuePgShwUwAfr1x1H/3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTgPVEKgq1K4760fxd5MX5zvYiunqKP8/YhPdn3xcLzPK+rodardm2A8R42QEO9VG
	 yCSQENLJmv/XwLpjZB4QhwGF5ofKOFC0kzR+IuR5gTjhA6fwCV446bCdMDKlq/xu70
	 dbdCu8jc0shLsWfsfZUiuNdkBZLcz6pXc7a+QW8Ya460XKrFryRhK50FlxBkKTz4+6
	 QZHW23IZQDMilR0TpeT0BtEMc/mwISF0S/U2gcMjigfKXrRWawt9YVC2b573bUy2mG
	 VePb6lPgcW5iI8a5Tmihz9HSHUpY1IooJZ6vdot74akFEEWbON4BaIOlAVLqtZxi3k
	 ziBjHtZs5DL4w==
Date: Tue, 27 Feb 2024 09:55:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/2] Fix libaio cancellation support
Message-ID: <20240227-setzlinge-pochen-ef901577b541@brauner>
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240221-hautnah-besonderen-e66d60bae4e6@brauner>
 <9a0f534d-0251-492d-b7f9-30926e037c57@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a0f534d-0251-492d-b7f9-30926e037c57@acm.org>

On Mon, Feb 26, 2024 at 12:50:46PM -0800, Bart Van Assche wrote:
> On 2/21/24 01:26, Christian Brauner wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.misc
> > 
> > [1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
> >        https://git.kernel.org/vfs/vfs/c/34c6ea2e3aea
> > [2/2] fs/aio: Make io_cancel() generate completions again
> >        https://git.kernel.org/vfs/vfs/c/ee347c5af5be
> 
> Patch [1/2] ended up in Linus' tree as commit b820de741ae4, which is
> great. However, I can't find patch [2/2] in any vfs branch nor in
> linux-next. Did I perhaps overlook something?

1/2 was supposed to be a bugfix that we had to do right away while 2/2
wasn't that urgent iirc. @Jens, can I get an Ack on the second patch?

