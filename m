Return-Path: <linux-fsdevel+bounces-694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9127CE6F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E855B20544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F4C44488;
	Wed, 18 Oct 2023 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rIerSQLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652043A88
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 18:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5346BC433C9;
	Wed, 18 Oct 2023 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697654454;
	bh=WyKP8PedU2nY8vbXQRoM3WiPDLDUtfwm9DWzRfORrUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIerSQLcj1eDe1mkPRSy4iOREOkm3M2Eb+EzEP0RsqbtAZ9liFl8nsw3MbXgQ8SVZ
	 9hQk6rGmykL/ZqW6WgEWtZY/BMc8vRAxrPa/EM2W4qcCAwpx2Exton884/7tkaB3ki
	 hGZIqK6nLJ3kCgrEH4M8lFMTXjKn+Z9qE2PgfgA0=
Date: Wed, 18 Oct 2023 20:40:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jesse Hathaway <jesse@mbuki-mvuki.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <2023101819-satisfied-drool-49bb@gregkh>
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>

On Wed, Oct 18, 2023 at 01:34:13PM -0500, Jesse Hathaway wrote:
> > If this holds up without regressions than all LTSes. That's what Amir
> > and Leah did for some other work. I can add that to the comment for
> > clarity.
> 
> Unfortunately, this has not held up in LTSes without causing
> regressions, specifically in crun:
> 
> Crun issue and patch
>  1. https://github.com/containers/crun/issues/1308
>  2. https://github.com/containers/crun/pull/1309

So thre's a fix already for this, they agree that symlinks shouldn't
have modes, so what's the issue?

> Debian bug report
>  1. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1053821

Same report.

> I think it should be reverted in LTSes and possibly in upstream.

It needs to reverted in Linus's tree first, otherwise you will hit the
same problem when moving to a new kernel.

> P.S. apologies for not having the correct threading headers. I am not on
> the list.

You can always grab the mail on lore.kernel.org and respond to it there,
you are trying to dig up a months old email and we don't really have any
context at all (I had to go to lore to figure it out...)

thanks,

greg k-h

