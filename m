Return-Path: <linux-fsdevel+bounces-30305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85529891A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 23:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C131C22EB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 21:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA721865E6;
	Sat, 28 Sep 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Teb2HkVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057E17B428;
	Sat, 28 Sep 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727560563; cv=none; b=b5CAEpt5PGLBqOdqM4HAO8Lt+5uHEdnEzrRzl8WGkp4TD75Ch5RGkWrIKcXFlxMVo9ikfeasiwUQBQZ3Hk3cojSAEQp2XOWgbSbcNLX1G3p9JReYCdvkIrVA4ATf25SmY/koxTYbSJj467Y2xwmb2RNBMdXQde5OzYKJWoYYGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727560563; c=relaxed/simple;
	bh=Bls5swmpeMzUWj2RlsQGBW8bINZMXO0c0CeG2/n6aR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi29yvr/Z5BbjwCUmS1rXFTTSQkhL/cTvhSznhTCx+b41EW1le0lUeP4BLjiNBl1ebwCaJ8tkXBZGo710qRuMYBqKEqQLkcwuDV1R7+lUswTITp10DdMa6pDw5YomuJl+wmXR+TK8q/98iNlp7WHLn5+K78m0Ot+ouFCi/QaJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Teb2HkVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1605C4CEC3;
	Sat, 28 Sep 2024 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727560563;
	bh=Bls5swmpeMzUWj2RlsQGBW8bINZMXO0c0CeG2/n6aR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Teb2HkVSXlHPGKaQcYTedlkoVOlbSwhrrHJD0daluNnTdurb5ZsbWx4N/mlLU3GVJ
	 uTJuNrdK0n2GyH6iTeTPQRWzyCGKBkaFYMN+ED6ybnoII/TOZg7zbMBk7IfPu2+YLE
	 akqKzVjZSHmpndorYJ3AcDK0ROyPcMDoQSfp8+K3M3gSHrxWKWIgkLcCO5So2Gafk7
	 EReey6Ip1vTAFTo+Xj/JKL5Gyhrgp9SfWyfRdnXA0H0umdKOJcEu3gCiPUv9N2SosM
	 8B0QXa2iZV93R3OQUvaCk4dmersJxQSJp/yPDdyYo58dEbHX2AEbj8xHsyCT+ML2Ak
	 Narrp1bIfYvoQ==
Date: Sat, 28 Sep 2024 14:56:02 -0700
From: Kees Cook <kees@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2 1/2] exec: add a flag for "reasonable" execveat() comm
Message-ID: <202409281453.B9B9999D@keescook>
References: <20240927151746.391931-1-tycho@tycho.pizza>
 <87ikuhw155.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikuhw155.fsf@email.froward.int.ebiederm.org>

On Fri, Sep 27, 2024 at 10:45:58AM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > From: Tycho Andersen <tandersen@netflix.com>
> >
> > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > switching to execveat() for service execution, but can't, because the
> > contents of /proc/pid/comm are the file descriptor which was used,
> > instead of the path to the binary. This makes the output of tools like
> > top and ps useless, especially in a world where most fds are opened
> > CLOEXEC so the number is truly meaningless.
> >
> > Change exec path to fix up /proc/pid/comm in the case where we have
> > allocated one of these synthetic paths in bprm_init(). This way the actual
> > exec machinery is unchanged, but cosmetically the comm looks reasonable to
> > admins investigating things.
> 
> Perhaps change the subject to match the code.
> 
> > Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> > Suggested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
> > CC: Aleksa Sarai <cyphar@cyphar.com>
> > Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec
> > ---
> > v2: * drop the flag, everyone :)
> >     * change the rendered value to f_path.dentry->d_name.name instead of
> >       argv[0], Eric
> > ---
> >  fs/exec.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index dad402d55681..9520359a8dcc 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1416,7 +1416,18 @@ int begin_new_exec(struct linux_binprm * bprm)
> >  		set_dumpable(current->mm, SUID_DUMP_USER);
> >  
> >  	perf_event_exec();
> > -	__set_task_comm(me, kbasename(bprm->filename), true);
> > +
> > +	/*
> > +	 * If fdpath was set, execveat() made up a path that will
> > +	 * probably not be useful to admins running ps or similar.
> > +	 * Let's fix it up to be something reasonable.
> > +	 */
> > +	if (bprm->fdpath) {
> > +		BUILD_BUG_ON(TASK_COMM_LEN > DNAME_INLINE_LEN);
> > +		__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);
> 
> We can just do this regardless of bprm->fdpath.
> 
> It will be a change of behavior on when executing symlinks and possibly
> mount points but I don't think we care.  If we do then we can add make
> it conditional with "if (bprm->fdpath)"
> 
> At the very least using the above version unconditionally ought to flush
> out any bugs.

I'm not super comfortable doing this regardless of bprm->fdpath; that
seems like too many cases getting changed. Can we just leave it as
depending on bprm->fdpath?

Also, is d_name.name always going to be set? e.g. what about memfd, etc?

-- 
Kees Cook

