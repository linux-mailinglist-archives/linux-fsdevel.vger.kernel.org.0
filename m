Return-Path: <linux-fsdevel+bounces-65065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42FBFAAF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D0A18C4073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981EC2FD1DA;
	Wed, 22 Oct 2025 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WLXa50SG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gp2gnW1d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EpE1Gh4k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S4V6uw3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622452FD1CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119509; cv=none; b=Se3E2a1kFyg7mBuoXSmyYatjExQflZu4snyAZVKaUTicvGasylFiquou8roaqrQrrCzsMAIPnk2xV5QMr+jUyYSptfvW+Oe/Fe2t5/htHpMlSzNwgsSF5MxmoD4NuLGvQ7jLc+1DPsk3/gDa8sbzCptb3PhAT7vRzejShIyj+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119509; c=relaxed/simple;
	bh=YKZ71TcAYFCzk7LquCBHOkVCCNwK04Z3Rwp22Zmy91I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m819PlvsbMaXSGYm6RETWVyEF9qiwmnYkVf3vSq2FX47r5/IXXi6TEUtP0DW7FpHJaoh65770qoz7UGXCyuwpU9+0YBgqLWmnQnFMTcGQq5nv5cj9wM35u0UfzgHq4yxZM+5NVFbO4Yt77AyWYjZnJCDRYTWjDGDilPs09uK//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WLXa50SG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gp2gnW1d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EpE1Gh4k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S4V6uw3J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 697FE1F391;
	Wed, 22 Oct 2025 07:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761119501;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G+GN8XQO5NVhzF4+79I45VeDXm2lq0alql08lbGTcE=;
	b=WLXa50SGfYw7rx7r4BN+nhQyq++ghDHg1ILi/T4sza3/QJ+Who//4+jrQgwYV1akk7mj1e
	9Wth5U2AbZuywjMz8SsZzGeVFhkYoNIprJLooi5yCtd63A+P/FfKtMyDb68RF30DJR7NMz
	DtRUuqFSo7684kNY44GPwwAkH2lVOx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761119501;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G+GN8XQO5NVhzF4+79I45VeDXm2lq0alql08lbGTcE=;
	b=Gp2gnW1d6NINLIIhBR2OqeKJ2ILh4BD4+Ntp3mI0DgeiMeQPjZppVQiozFYkz1maTSiKUy
	JPHthh/9+rROq4DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761119497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G+GN8XQO5NVhzF4+79I45VeDXm2lq0alql08lbGTcE=;
	b=EpE1Gh4kUFU/o+1PmPuBcPQ6azU+Q4iPrQLtzPMrEIQX+rcbdk4IDS2sWtGyp3FsmSmdOn
	INwmNqPtKfDLGOO+IV2FofeD94ZxKaYTh9tL1vGSiUz3oC5nf9ro4jR/SYd4zVikQscUqQ
	1eDWVg/r1IkQDOKbF2EmlR46J0u5BPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761119497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G+GN8XQO5NVhzF4+79I45VeDXm2lq0alql08lbGTcE=;
	b=S4V6uw3JuJ1C9DB14S9HN2lPzawgxazhh8V4t99V+qeTHqzukUimBNO5VmcFCeaGETjmth
	pwex/ShDkTVcsFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B76D11339F;
	Wed, 22 Oct 2025 07:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qGcUKgiN+Gj4KAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 22 Oct 2025 07:51:36 +0000
Date: Wed, 22 Oct 2025 09:51:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Cyril Hrubis <chrubis@suse.cz>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	LTP List <ltp@lists.linux.it>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
Message-ID: <20251022075134.GA463176@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan>
 <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
 <20251021-wollust-biografie-c4d97486c587@brauner>
 <lguqncbotw2cu2nfaf6hwgip6wtrmeg2azvyeht7l56itlomy5@uccupuql3let>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lguqncbotw2cu2nfaf6hwgip6wtrmeg2azvyeht7l56itlomy5@uccupuql3let>
X-Spam-Level: 
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -7.50

> On Tue 21-10-25 15:21:08, Christian Brauner wrote:
> > On Fri, Oct 17, 2025 at 02:43:14PM +0200, Jan Kara wrote:
> > > On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> > > > Hi!
> > > > > > ## Test error log
> > > > > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > > > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > > > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > > > > @1760657272 aarch64
> > > > > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > > > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > > > > which might slow the execution
> > > > > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > > > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > > > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > > > > info_invalid) expected EINVAL: ENOTTY (25)

> > > > Looking closely this is a different problem.

> > > > What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> > > > size with:

> > > > struct pidfd_info_invalid {
> > > >         uint32_t dummy;
> > > > };

> > > > #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)


> > > > And we expect to hit:

> > > >         if (usize < PIDFD_INFO_SIZE_VER0)
> > > >                 return -EINVAL; /* First version, no smaller struct possible */

> > > > in fs/pidfs.c


> > > > And apparently the return value was changed in:

> > > > commit 3c17001b21b9f168c957ced9384abe969019b609
> > > > Author: Christian Brauner <brauner@kernel.org>
> > > > Date:   Fri Sep 12 13:52:24 2025 +0200

> > > >     pidfs: validate extensible ioctls

> > > >     Validate extensible ioctls stricter than we do now.

> > > >     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> > > >     Reviewed-by: Jan Kara <jack@suse.cz>
> > > >     Signed-off-by: Christian Brauner <brauner@kernel.org>

> > > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > > index edc35522d75c..0a5083b9cce5 100644
> > > > --- a/fs/pidfs.c
> > > > +++ b/fs/pidfs.c
> > > > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> > > >                  * erronously mistook the file descriptor for a pidfd.
> > > >                  * This is not perfect but will catch most cases.
> > > >                  */
> > > > -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > > > +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> > > >         }

> > > >         return false;


> > > > So kernel has changed error it returns, if this is a regression or not
> > > > is for kernel developers to decide.

> > > Yes, it's mostly a question to Christian whether if passed size for
> > > extensible ioctl is smaller than minimal, we should be returning
> > > ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
> > > is our "extensible ioctl expert" :).

> > You're asking difficult questions actually. :D
> > I think it would be completely fine to return EINVAL in this case.
> > But traditionally ENOTTY has been taken to mean that this is not a
> > supported ioctl. This translation is done by the VFS layer itself iirc.

> Now the translation is done by VFS, I agree. But in the past (when the LTP
> test was written) extensible ioctl with too small structure passed the
> initial checks, only later we found out the data is too short and returned
> EINVAL for that case. I *think* we are fine with just adjusting the test to
> accept the new world order but wanted your opinion what are the chances of
> some real userspace finding the old behavior useful or otherwise depending
> on it.

+1, thanks! Is it ok just expect any of these two regardless kernel version?

@Naresh Kamboju will you send a patch to LTP ML?

Kind regards,
Petr

> 								Honza

