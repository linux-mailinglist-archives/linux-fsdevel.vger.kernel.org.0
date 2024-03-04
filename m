Return-Path: <linux-fsdevel+bounces-13500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E5870889
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CF31F22435
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007461686;
	Mon,  4 Mar 2024 17:47:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DFC6166E;
	Mon,  4 Mar 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.233.56.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574444; cv=none; b=TT533DDIGO0D2RPungpF8e8/8qjNpTOEabKeWlokTUB6gj83smv3DCMVla/tc4+Y0KwavLryLauTaCcW+tT4vyw3ZBVib6u0LmqDPonKtS9f/iiqm0hR663ptPGP8n7jmrCrYbYr0nTVDyZ4557qHHPnoxlLO03DZa9OxU5ltSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574444; c=relaxed/simple;
	bh=Jva+x7rbRCUGadKDKjz7ce9+Gv5TBrbgMXjNaNg3mnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWvbtxQYux6Z+klJt3Wx7gpgD2n2up7m3D1O6KE2C3+GPHztQyImD7LJQAk6hXBZG9NnuQJasID8sB2bUPm6g+32CqKRaTYbfvGDwwaIZYT2C65Os2ibL/bHzVOziX3p8rYvBAUxxmlGG7+SIO3KA1vAc2vGzMrmw3gMnWadE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca; spf=pass smtp.mailfrom=communityfibre.ca; arc=none smtp.client-ip=205.233.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=communityfibre.ca
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 9D5926B0083; Mon,  4 Mar 2024 12:47:21 -0500 (EST)
Date: Mon, 4 Mar 2024 12:47:21 -0500
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com,
	brauner@kernel.org, jack@suse.cz, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/aio: fix uaf in sys_io_cancel
Message-ID: <20240304174721.GQ20455@kvack.org>
References: <0000000000006945730612bc9173@google.com> <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com> <14f85d0c-8303-4710-b8b1-248ce27a6e1f@acm.org> <20240304170343.GO20455@kvack.org> <73949a4d-6087-4d8c-bae0-cda60e733442@acm.org> <20240304173120.GP20455@kvack.org> <5ee4df86-458f-4544-85db-81dc82c2df4c@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee4df86-458f-4544-85db-81dc82c2df4c@acm.org>
User-Agent: Mutt/1.4.2.2i

On Mon, Mar 04, 2024 at 09:40:35AM -0800, Bart Van Assche wrote:
> On 3/4/24 09:31, Benjamin LaHaise wrote:
> >A revert is justified when a series of patches is buggy and had
> >insufficient review prior to merging.
> 
> That's not how Linux kernel development works. If a bug can get fixed
> easily, a fix is preferred instead of reverting + reapplying a patch.

Your original "fix" is not right, and it wasn't properly tested.  Commit
54cbc058d86beca3515c994039b5c0f0a34f53dd needs to be reverted.

> >Using the "a kernel warning hit" approach for work on cancellation is
> >very much a sign that the patches were half baked.
> Is there perhaps a misunderstanding? My patches fix a kernel warning and
> did not introduce any new WARN*() statements.

The change that introduced that callback by you was incorrect and should
be reverted.

> >Why are you touching the kiocb after ownership has already been
> >passed on to another entity?
> Touching the kiocb after ownership has been passed is the result of an
> oversight. Whether or not kiocb->ki_cancel() transfers ownership depends
> on the I/O type. The use-after-free was not introduced on purpose.

Your fix is still incorrect.  You're still touching memory that you don't
own.  The event should be generated via the ->ki_cancel method, not in the
io_cancel() syscall.

		-ben

> Bart.
> 
> 

-- 
"Thought is the essence of where you are now."

