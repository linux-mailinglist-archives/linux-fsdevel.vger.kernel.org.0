Return-Path: <linux-fsdevel+bounces-30014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F98984E3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B418284A94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B9183CCE;
	Tue, 24 Sep 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="JLpmeHWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naAS52CC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3318308A;
	Tue, 24 Sep 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218782; cv=none; b=ZBNSaSg/0lhiSTyg5xVejj7oK3DKMYlDkzxKz5O7xvS19eFUZVYLy/Nb/m53qzPRPkLoKASVEigTAv4WXfYa3xIMP805wqHf5f811QUK5ZLsmhLUuaC7uEdNtpuAIFTrPl0EkDpl0JTlG0YaRJWDF44VnXGKU1CHLs6bqOwseG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218782; c=relaxed/simple;
	bh=hCm2r49j3Of0+4EQato9rBmCHM9Q/7oZBXd2y2KGElU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8A58lfMwW+l6w3H41ZD8VIbs6K16Q7Ol2CyqArkqia8SYBVG57uuzAla8C5C5+cResH52gAOXTYyjNToshzUkZczcp1dVySrhd3KtnhqywQzIHZyCM7hdOGcnGyuDI9gEPF9qvjCURVC0rAfA36sDgS3HjqBWw4K+jRBImuPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=JLpmeHWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=naAS52CC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B83213800F0;
	Tue, 24 Sep 2024 18:59:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Sep 2024 18:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727218779; x=1727305179; bh=d8fUlRHE2i
	Zfy80BDgU0TCA1aV71a21YfiFtM5egfSU=; b=JLpmeHWoWH6kE+W42hBonNbqK1
	MU6EglXwbTg8IylUGpH58l2TFkopHLmOPFMAie1iFzqJu/ht1OY8OWfw3yQ0gVu+
	7qUlC48O7QSk7YY79ZAyfRkAaxE4UXbJnb+ULC0XV16s/zzI2GVcYpoT35wQSqkI
	i59vcYcau6W1uz9nTOgQKZxP64Qs2BZqUVa+jtCiu8YcdWENBYKFLuxhq+awz06U
	oZPUmpB8MTb1Umkq4OIgtHpZSPP1iC1TGFeJP9Oz3TKbtQEtLQ9RKhGDdb9sj0de
	6A+Z8Al2s2nKfQ3syEh87pCDRqEb8fIXDDabgxkOHkPdQmJhRkWkIP4fKdOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727218779; x=1727305179; bh=d8fUlRHE2iZfy80BDgU0TCA1aV71
	a21YfiFtM5egfSU=; b=naAS52CC4mk6nmZPC08I6+3XtolR88HMhgLx24YxES/7
	rVwRp/rh7wTozU6t7CNSzk7J7n9GnZAxLnTFf2Sc5RJzgXHYelclqepTLZHdgPyN
	QQjKoRXyxtx8afvdUdnxtXW9cu7VFFrBEjo1dp/Nh2if4qh+OU4n5ERypTUMRxox
	pqyLrayTFkgpT1mqrIpvKcQnFmy8/k884Iu7iD+4srs08/Lp/MvQV64M0dGNYrF2
	3dOJ5dXlfrQGQUeFqHeolbwgcGFdnVQY24VL2fuqoueGV481yc7UPiyKCmgGSZV1
	mbmm7i6oJrEv1qfCYechgy//sESy0s5rB7BMgyxMEw==
X-ME-Sender: <xms:WkTzZikh350BFq5eKnrrkajnBwFicADwlCJ4O9OUgUk0xw77ofZtBw>
    <xme:WkTzZp0Qjhcq_lpj2HMa-z1DG89MQ5mzmcqBxD7g3f8eq9Ze4ZA9X6R1CdPnLif19
    _LXZJdZr8brKXAbCK4>
X-ME-Received: <xmr:WkTzZgp5hhjijI9fnozf7YTNVCt_Z9WC7fqAwyXnOhfsODXMNQlHQlT7NmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfihtghhohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrph
    hiiiiirgeqnecuggftrfgrthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifedu
    leegjedutdefffetkeelhfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirgdpnhgspghrtghp
    thhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggvsheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtgho
    mhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghk
    sehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthht
    oheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WkTzZmnxG8iZlArWJrTtCHR1bUfKxNOyjtngtG727WYrsqscq4a_1Q>
    <xmx:WkTzZg3k2SWdm8D1mS4f2uIncmEy_EHvWitrHCm1uC0ZGaag-ABptw>
    <xmx:WkTzZttjjOPm1DFdeuQ0kg9g9YR4pb3z_yJZhCj_ddkKVUyZ8Tel_A>
    <xmx:WkTzZsXX_m6wNvYQqsylvcRBGpYdk0t1hyeic3gFemOYB6c79DbhKw>
    <xmx:W0TzZqP1W3TDASKyYhUGBWtKx_LPX1sDcnzMpAMwK92jfd5pmxe4K_lU>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 18:59:35 -0400 (EDT)
Date: Tue, 24 Sep 2024 16:59:33 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Kees Cook <kees@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <ZvNEVT+AR6dX88KK@tycho.pizza>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <8D545969-2EFA-419A-B988-74AD0C26020C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8D545969-2EFA-419A-B988-74AD0C26020C@kernel.org>

On Tue, Sep 24, 2024 at 02:37:13PM -0700, Kees Cook wrote:
> 
> 
> On September 24, 2024 10:39:35 AM PDT, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
> >Tycho Andersen <tycho@tycho.pizza> writes:
> >
> >> From: Tycho Andersen <tandersen@netflix.com>
> >>
> >> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> >> switching to execveat() for service execution, but can't, because the
> >> contents of /proc/pid/comm are the file descriptor which was used,
> >> instead of the path to the binary. This makes the output of tools like
> >> top and ps useless, especially in a world where most fds are opened
> >> CLOEXEC so the number is truly meaningless.
> 
> And just to double check: systemd's use would be entirely cosmetic, yes?

I think it's not really systemd, but their concern for admins looking
at `ps` and being confused by "4 is using lots of CPU". IIUC systemd
won't actually use the value at all. Zbigniew can confirm though.

> >>
> >> This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
> >> contents of argv[0], instead of the fdno.
> >
> >The kernel allows prctl(PR_SET_NAME, ...)  without any permission
> >checks so adding an AT_ flat to use argv[0] instead of the execed
> >filename seems reasonable.
> >
> >Maybe the flag should be called AT_NAME_ARGV0.
> 
> If we add an AT flag I like this name.

+1

> >
> >
> >That said I am trying to remember why we picked /dev/fd/N, as the
> >filename.
> >
> >My memory is that we couldn't think of anything more reasonable to use.
> >Looking at commit 51f39a1f0cea ("syscalls: implement execveat() system
> >call") unfortunately doesn't clarify anything for me, except that
> >/dev/fd/N was a reasonable choice.
> >
> >I am thinking the code could reasonably try:
> >	get_fs_root_rcu(current->fs, &root);
> >	path = __d_path(file->f_path, root, buf, buflen);
> >
> >To see if a path to the file from the current root directory can be
> >found.  For files that are not reachable from the current root the code
> >still need to fallback to /dev/fd/N.
> >
> >Do you think you can investigate that and see if that would generate
> >a reasonable task->comm?
> >
> >If for no other reason than because it would generate a usable result
> >for #! scripts, without /proc mounted.
> >
> >
> >It looks like a reasonable case can be made that while /dev/fd/N is
> >a good path for interpreters, it is never a good choice for comm,
> >so perhaps we could always use argv[0] if the fdpath is of the
> >form /dev/fd/N.
> 
> I haven't had a chance to go look closely yet, but this was the same thought I had when I first read this RFC. Nobody really wants a dev path in comm. Can we do this unconditionally? (And if argv0 is empty, use dev path...)

We can, I was just worried about the behavior change. But it seems we
are all in violent agreement that the current behavior isn't very
good, so maybe it's fine to change.

> >All of that said I am not a fan of the implementation below as it has
> >the side effect of replacing /dev/fd/N with a filename that is not
> >usable by #! interpreters.  So I suggest an implementation that affects
> >task->comm and not brpm->filename.
> 
> Also agreed. There is already enough fiddly usage of the bprm filename/interpreter/fdpath members -- the argv0 stuff should be distinct. Perhaps store a pointer to argv0 during arg copy? I need to go look but I'm still AFK/OoO...

Yeah, on second thought we could do something like:

diff --git a/fs/exec.c b/fs/exec.c
index 36434feddb7b..a45ea270cc43 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1416,7 +1416,10 @@ int begin_new_exec(struct linux_binprm * bprm)
                set_dumpable(current->mm, SUID_DUMP_USER);

        perf_event_exec();
-       __set_task_comm(me, kbasename(bprm->filename), true);
+       if (needs_comm_fixup)
+               __set_task_comm(me, argv0, true);
+       else
+               __set_task_comm(me, kbasename(bprm->filename), true);

        /* An exec changes our domain. We are no longer part of the thread
           group */

and then we don't need to mess with bprm at all. Seems much cleaner. I
will see about the

	get_fs_root_rcu(current->fs, &root);
	path = __d_path(file->f_path, root, buf, buflen);

that Eric suggested and how that works with the above.

Tycho

