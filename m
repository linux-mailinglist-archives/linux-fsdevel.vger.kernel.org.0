Return-Path: <linux-fsdevel+bounces-64927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E379BF6BC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF3B4876DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9001337113;
	Tue, 21 Oct 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRZ9V5QZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF38143C61;
	Tue, 21 Oct 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052875; cv=none; b=MIJ87pg2SBqMg5inMXEi7Ohh99Re3PLLF/iLkx/NFuoyB1E5y5Yd2RJU3LUNrvRI2+NZBcihmI9mNNuVDaA7A0QBeG3XaR2xdWeHV9YQrBGnXBrtYLpAanQ9Txe8lb5b+WeXfE66H56Mq7mJWqRm80iIcHzl5lf4jleKUsLhvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052875; c=relaxed/simple;
	bh=lvcRb/61yamx9Ux8qcx+0p2Z2oz7rIaAXsUA3+G6uXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGyZmSRzukedmvUwd8gdYjG3PJBvcmouNE12WwxtZSG/Sd+7iTjQswTt1jG9AsTMrxpCI7qqN0c8S+clRAnBslXJaw9YMhuaKTh+iL5xZqH+ZTxP0ujrmdMmBUpT4lIfcDa9uy+T88OdvkAfxvi3/+34MGR3DCankINYbJwk20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRZ9V5QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD8C4CEF1;
	Tue, 21 Oct 2025 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761052874;
	bh=lvcRb/61yamx9Ux8qcx+0p2Z2oz7rIaAXsUA3+G6uXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRZ9V5QZIibDOsO9wccPJdCMBqXt9+lUebH4uqUNlwIGaqGNPHXtxgk83a1Rg6KX0
	 On7CO7L3CH3u8UM6MvMznOHukWIxAJmmtkHpKXyhyZyJqLiWZ1FKnz29oi4S51rxfY
	 U8OpG0vUpUy3PCNi3RE7Ig91WHeNU40tA6FKiN2OLmobeH0i8fNPxGHWx6HrBm5H3C
	 NP7kIxANp5Xch80kwvtZUuiP512KcySpiGdz00wgSDZfP/6zuEXUITgFZxPWFwM0YC
	 d505f4KOmvU7NF1GiN3FKzl3LXlMZqpVyiF5mt7NvobjAQYvJVbvuOW4JgdbR4MhIt
	 i3QIg217Yj6ZA==
Date: Tue, 21 Oct 2025 15:21:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
Message-ID: <20251021-wollust-biografie-c4d97486c587@brauner>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan>
 <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>

On Fri, Oct 17, 2025 at 02:43:14PM +0200, Jan Kara wrote:
> On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> > Hi!
> > > > ## Test error log
> > > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > > @1760657272 aarch64
> > > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > > which might slow the execution
> > > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > > info_invalid) expected EINVAL: ENOTTY (25)
> > 
> > Looking closely this is a different problem.
> > 
> > What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> > size with:
> > 
> > struct pidfd_info_invalid {
> >         uint32_t dummy;
> > };
> > 
> > #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)
> > 
> > 
> > And we expect to hit:
> > 
> >         if (usize < PIDFD_INFO_SIZE_VER0)
> >                 return -EINVAL; /* First version, no smaller struct possible */
> > 
> > in fs/pidfs.c
> > 
> > 
> > And apparently the return value was changed in:
> > 
> > commit 3c17001b21b9f168c957ced9384abe969019b609
> > Author: Christian Brauner <brauner@kernel.org>
> > Date:   Fri Sep 12 13:52:24 2025 +0200
> > 
> >     pidfs: validate extensible ioctls
> >     
> >     Validate extensible ioctls stricter than we do now.
> >     
> >     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> >     Reviewed-by: Jan Kara <jack@suse.cz>
> >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index edc35522d75c..0a5083b9cce5 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> >                  * erronously mistook the file descriptor for a pidfd.
> >                  * This is not perfect but will catch most cases.
> >                  */
> > -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> >         }
> >  
> >         return false;
> > 
> > 
> > So kernel has changed error it returns, if this is a regression or not
> > is for kernel developers to decide.
> 
> Yes, it's mostly a question to Christian whether if passed size for
> extensible ioctl is smaller than minimal, we should be returning
> ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
> is our "extensible ioctl expert" :).

You're asking difficult questions actually. :D
I think it would be completely fine to return EINVAL in this case.
But traditionally ENOTTY has been taken to mean that this is not a
supported ioctl. This translation is done by the VFS layer itself iirc.


