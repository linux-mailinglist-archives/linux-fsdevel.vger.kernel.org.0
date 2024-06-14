Return-Path: <linux-fsdevel+bounces-21689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611EC9082E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 06:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F331C217D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 04:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D15130A54;
	Fri, 14 Jun 2024 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKTncywV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0B26AD7;
	Fri, 14 Jun 2024 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338579; cv=none; b=TrttZETrsO1KmdOnhCLMEAxvD29rd+yzxVYZnuiMH6SIbc4pCBRs2kqGtoXC+3X5397dXa+MvxWLNJyEZpvUPJLvsk+eIStqpLtmIMabog7TSKsSp7K+/yAsrtyD7WMWtFJtatGnBY0mK+E/dSrS5jUFeG7+vRffDYI5j7iQxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338579; c=relaxed/simple;
	bh=0AZwXYWJM7GQmfY0DNQALlctd54dI34x8sBTPIXqi9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yib8rH6f8DQIHPneOKavcKujxG7Kr7CKhc5RYJ629BQDqNpwq2ucS0k3FwdmfWBbS4A4i8T6QTK1sPE0cfLUOLp1X1YAXIdXQ1wf7RE1r3KdLi5jTp+fZLO9hDa7ckGk7Obt4OD7kbXbWRBNA2uT9awzqDAAf1ClATSxMUo6dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKTncywV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA83C2BD10;
	Fri, 14 Jun 2024 04:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718338579;
	bh=0AZwXYWJM7GQmfY0DNQALlctd54dI34x8sBTPIXqi9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKTncywVzsAx/iIfGJgGogoQP0dia65O0YA1KcQFdbEQHTAHuaVy+rXgTD+9D6c7x
	 T9d5KUuQBAkHuxM/EynUXzLURy0xf8L894HkEiKX8iMpFrFTWJn1M68yA/hArdHvrf
	 rvk+4mBu838JNPqAwtamjkNlaqLUBdH8H7c/XoFpg78PbUG4oajWQhl+HGkGCOhJBr
	 XDeZgj6Omd1+kwLfcvF+kq/61l9a5I4z2xF/MnrlKNE+Dak7nDMmbxUzOflwyZ7uro
	 Zj9lhNvy9Banwg2PBiY6bpT+LXbaxLZ5D0B6W9ZMIkFYTw1RO/xSXdMrtWIQoYM30z
	 /+4jrGzWedvMg==
Date: Thu, 13 Jun 2024 21:16:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	fstests@vger.kernel.org
Subject: Re: Flaky test: generic:269 (EBUSY on umount)
Message-ID: <20240614041618.GA6147@frogsfrogsfrogs>
References: <20240612162948.GA2093190@mit.edu>
 <20240612194136.GA2764780@frogsfrogsfrogs>
 <20240613215639.GE1906022@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613215639.GE1906022@mit.edu>

On Thu, Jun 13, 2024 at 10:56:39PM +0100, Theodore Ts'o wrote:
> On Wed, Jun 12, 2024 at 12:41:36PM -0700, Darrick J. Wong wrote:
> > 
> > I don't see this problem; if you apply this to fstests to turn off
> > io_uring:
> > https://lore.kernel.org/fstests/169335095953.3534600.16325849760213190849.stgit@frogsfrogsfrogs/#r
> > 
> > do the problems go away?
> 
> Thanks for pointing out the mail thread; I had a vague memory that
> this had been raised as a problem before.  Looking at the discussion
> (from August 2023, so over 9 months ago), this is a bug that has been
> acknowledged as an io_uring bug, but it still hasn't been fixed.
> 
> Using Zorro's sugestion of adding "-f uring_read=0 -f uring_write=0"
> to the fsstress options makes the EBUSY umount failures go away.  I've
> also created a new test which relaibly reproduces the "fsstress ;
> umount" EBUSY bug (as opposed to the existing test failures which only
> fail 1-10% of the time).  So with that I can with a clean conscience
> suggest that we omit io_uring calls from those tests using fsstress to
> thest some non-io_uring related bug if they run into the umount EBUSY
> bug, since there is now a new bug which reliably shows off the
> problem....

Amusingly enough, I still have that patch (and generic/1220) in my
fstests branch, and I haven't seen this problem happen on g/1220 in
quite a while.

--D
> 
> 						- Ted

