Return-Path: <linux-fsdevel+bounces-33906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A79C080A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 14:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61AD288AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA3212655;
	Thu,  7 Nov 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYG5uvqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118789450;
	Thu,  7 Nov 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987368; cv=none; b=dg/aYmOSMWTxQYim62bBzjNa4OuOYHKirX3IaqA0prSdixtLm2GWlUWkcGJykJIc2MXnRGr7gmC8pEV/gtBVJMMWkjndD0dYVYFz+NONP0OxazyIPVRZWzWju7Yvqjy/y7ck5g0do4pV6mDerjJFX6AJf1zMnX237oGByEGQaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987368; c=relaxed/simple;
	bh=S0uqOs3OT6EK95y6+TWKk54ktPxmXunkL0Meh8SJuYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l92nafGO6RWDB9LuY1eH4JpixzY8d/t/gM0A+8c56NVaWjpv/1J/+P6kcnGgwnkDwDiurcJqVBLoYgKKHgYIz5LS+728gXo7J626sl3+74W5nz5H9DyYCJCRZH/a+aL8c8Qd7x3m/c55o9vmfPI9xEh6GX0KVB0iPyNChn9lkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYG5uvqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238D3C4CECC;
	Thu,  7 Nov 2024 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730987367;
	bh=S0uqOs3OT6EK95y6+TWKk54ktPxmXunkL0Meh8SJuYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYG5uvqV1qG+r8SzZ+S/m/8pX/OIMtpoY65PYUCgqTNe0dgwnqPLlOGqWlTkuOupe
	 vttwl0bGLW0XkFvIgZC7EQZKPP9lzgKnVvjNLOHBRdLxNVFq7Ue7T/TgWa1KiJ79zG
	 DMQUmZT0c59LgycD2zOz24CADf8FqBe8vQ62Dw46ijWORv7s3e85uU44TNJg7i0DLc
	 3p9tqYqud3+8ldxqvCr9cpzmDtNEaAS0oliQyIwX3Wdq9xXkAKBtIbOXO7lvEeN3ER
	 JUgo0gavVnZSeZl8Yxrt9FEd9sBskMTf330daFnHXsfJSdNDPCeNvj0qiRdOCI+4vq
	 uWsPp6hauXTXw==
Date: Thu, 7 Nov 2024 14:49:20 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, John Garry <john.g.garry@oracle.com>, 
	Catherine Hoang <catherine.hoang@oracle.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE v2] work tree for untorn filesystem writes
Message-ID: <3x7l6ydqn3azs4m73lggzyznntojagkcclrkrgxecncascd6qq@wmuvbowt7nxp>
References: <20241106005740.GM2386201@frogsfrogsfrogs>
 <20241106-zerkleinern-verzweifeln-7ec8173c56ad@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-zerkleinern-verzweifeln-7ec8173c56ad@brauner>

On Wed, Nov 06, 2024 at 10:50:21AM +0100, Christian Brauner wrote:
> On Tue, Nov 05, 2024 at 04:57:40PM -0800, Darrick J. Wong wrote:
> > Hi everyone,
> > 
> > Here's a slightly updated working branch for the filesystem side of
> > atomic write changes for 6.13:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fs-atomic_2024-11-05
> > 
> > This branch is, like yesterday's, based off of axboe's
> > for-6.13/block-atomic branch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block-atomic
> > 
> > The only difference is that I added Ojaswin's Tested-by: tags to the end
> > of the xfs series.  I have done basic testing with the shell script at
> > the end of this email and am satisfied that it at least seems to do the
> > (limited) things that I think we're targeting for 6.13.
> > 
> > Christian: Could you pull this fs-atomic branch into your vfs.git work
> > for 6.13, please?
> 
> Of course!
> 
> I did git pull fs-atomic_2024-11-05 from your tree. It should show up in
> -next tomorrow.

I just saw this message Christian, please ignore my previous email, my
apologies.

Carlos

