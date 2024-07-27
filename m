Return-Path: <linux-fsdevel+bounces-24356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4593DD64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 07:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A414285001
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 05:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3933080;
	Sat, 27 Jul 2024 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NPebm1gf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363E2C6BD
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722057187; cv=none; b=O7KK5Wxtzlq+YtS9QXRoEcfx59rQx092nXgY2XNpSQ1X5RFqkcYUtZLL82YlP6xRNsYZ015lse/+Lq/afu0ICtXkqiaLqUDMbD/O/b9DurC0q9mk3PWzjtZfBrPAcfQCQ3/urUWMn7+J+zQsDkqmKq1hgBunNlRkpJU5P/nacVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722057187; c=relaxed/simple;
	bh=wn2akuMBYSG9bOglzxWJckrDzpwvZlf4QbkqolCMY7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPP3bMi9xl/uXo2vHFTUwmcuzh7rtbJPJU/LyqGceRADOAMFtAEOyHO5DW0aBTZRHLzXnYtPB9WjKYca+JaAa0aaRQR3yb9Va+eAHZpi08fYFKfFagrQGu0ucjfd8iEH/gqfk5EwiAWQZca/4/mlDVy+atLuMLxjEwWkZfGAVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NPebm1gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30CAC4AF07;
	Sat, 27 Jul 2024 05:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722057187;
	bh=wn2akuMBYSG9bOglzxWJckrDzpwvZlf4QbkqolCMY7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPebm1gfH10HWV3tav+g5jBkPpuwD+MDBcJ0Upu8Ij5AfDfMm5quiBcKKwryqjRpq
	 YGeO1Sndv4+ft91OohcK0pE9D7kqvMtrXmW+9NgDLgGdQp5reZ15rFSOiDZeWu1LZW
	 JrukpH1/ztZIxEGb5i1653IjF/A/a6vJzpyXZ7rI=
Date: Sat, 27 Jul 2024 07:13:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: hfsplus: Initialize directory subfolders in hfsplus_mknod
Message-ID: <2024072732-collage-scam-e1b7@gregkh>
References: <20240727045127.54746-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727045127.54746-1-simeddon@gmail.com>

On Sat, Jul 27, 2024 at 10:21:29AM +0530, Siddharth Menon wrote:
>     hfsplus: Initialize directory subfolders in hfsplus_mknod
>     
>     Addresses uninitialized subfolders attribute being used in `hfsplus_subfolders_inc` and `hfsplus_subfolders_dec`.
>     
>     Fixes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
>     Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
>     Closes: https://syzkaller.appspot.com/x/report.txt?x=16efda06680000
> 

Odd indentation :(

Also, why the extra blank line before:

> Signed-off-by: Siddharth Menon <simeddon@gmail.com>

This one?

thanks,

greg k-h

