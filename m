Return-Path: <linux-fsdevel+bounces-64999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A98BF8C68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 22:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD953BF26E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABED27FB25;
	Tue, 21 Oct 2025 20:48:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE1274666
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079737; cv=none; b=GUPJ+8lFwJEN9iR4K5JHcD4VZrsNVWR65vz12bhujj/0L794x0v1DMQpz6vabbenIKtYvqQMfU5QeLoDp5mWl/dfneyRiYL6NzaIFxszQkZ9CnfXv7QJ/UUhZneCCZLbQ5KCwSeDSz3khLRgAROYqEy5C+ButKDKDwysDkq871c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079737; c=relaxed/simple;
	bh=RflHPTLEr0DiuzTrG2cL6lTyezLKTb7u5dOyQveQkAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zes1mwkFM2xzqGSH7/5ElxZkkpMbAq11TwnBAyfLRCVrNyGyFY+PLTW8PCpeG38a6avO488THNfEqYTyxcwu9VotugPPc/x6wescV7YGGVt8bSCbGEn4OQkn9RlR7ddnIi0Ck0uIQRI9BG6qk7y6uu2JoSAKLbbjXRSIY1dZXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DBCB211A8;
	Tue, 21 Oct 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D5E4139D2;
	Tue, 21 Oct 2025 20:48:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WUCqGrbx92h3VQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 20:48:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC0EBA0990; Tue, 21 Oct 2025 22:48:49 +0200 (CEST)
Date: Tue, 21 Oct 2025 22:48:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Cyril Hrubis <chrubis@suse.cz>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
Message-ID: <lguqncbotw2cu2nfaf6hwgip6wtrmeg2azvyeht7l56itlomy5@uccupuql3let>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan>
 <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
 <20251021-wollust-biografie-c4d97486c587@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-wollust-biografie-c4d97486c587@brauner>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 7DBCB211A8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

On Tue 21-10-25 15:21:08, Christian Brauner wrote:
> On Fri, Oct 17, 2025 at 02:43:14PM +0200, Jan Kara wrote:
> > On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> > > Hi!
> > > > > ## Test error log
> > > > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > > > @1760657272 aarch64
> > > > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > > > which might slow the execution
> > > > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > > > info_invalid) expected EINVAL: ENOTTY (25)
> > > 
> > > Looking closely this is a different problem.
> > > 
> > > What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> > > size with:
> > > 
> > > struct pidfd_info_invalid {
> > >         uint32_t dummy;
> > > };
> > > 
> > > #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)
> > > 
> > > 
> > > And we expect to hit:
> > > 
> > >         if (usize < PIDFD_INFO_SIZE_VER0)
> > >                 return -EINVAL; /* First version, no smaller struct possible */
> > > 
> > > in fs/pidfs.c
> > > 
> > > 
> > > And apparently the return value was changed in:
> > > 
> > > commit 3c17001b21b9f168c957ced9384abe969019b609
> > > Author: Christian Brauner <brauner@kernel.org>
> > > Date:   Fri Sep 12 13:52:24 2025 +0200
> > > 
> > >     pidfs: validate extensible ioctls
> > >     
> > >     Validate extensible ioctls stricter than we do now.
> > >     
> > >     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> > >     Reviewed-by: Jan Kara <jack@suse.cz>
> > >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > 
> > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > index edc35522d75c..0a5083b9cce5 100644
> > > --- a/fs/pidfs.c
> > > +++ b/fs/pidfs.c
> > > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> > >                  * erronously mistook the file descriptor for a pidfd.
> > >                  * This is not perfect but will catch most cases.
> > >                  */
> > > -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > > +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> > >         }
> > >  
> > >         return false;
> > > 
> > > 
> > > So kernel has changed error it returns, if this is a regression or not
> > > is for kernel developers to decide.
> > 
> > Yes, it's mostly a question to Christian whether if passed size for
> > extensible ioctl is smaller than minimal, we should be returning
> > ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
> > is our "extensible ioctl expert" :).
> 
> You're asking difficult questions actually. :D
> I think it would be completely fine to return EINVAL in this case.
> But traditionally ENOTTY has been taken to mean that this is not a
> supported ioctl. This translation is done by the VFS layer itself iirc.

Now the translation is done by VFS, I agree. But in the past (when the LTP
test was written) extensible ioctl with too small structure passed the
initial checks, only later we found out the data is too short and returned
EINVAL for that case. I *think* we are fine with just adjusting the test to
accept the new world order but wanted your opinion what are the chances of
some real userspace finding the old behavior useful or otherwise depending
on it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

