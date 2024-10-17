Return-Path: <linux-fsdevel+bounces-32201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 228179A2528
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8EB2703B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4C1DE4F3;
	Thu, 17 Oct 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="knvMIdWm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGHEmtPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974501DE4C6;
	Thu, 17 Oct 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175694; cv=none; b=OCyDTZsTzh1ypQRL2U5ZqDlg0Pt6JNHls0t0cGor4Ulq1TrrASELvtvWpmoxuUHX6pCxb6ZDV5hsQBiotciVvtXfRaOMFhJZcZQxKov/oxuqTr3sIRiKupH8pv1P5YIjGKCxv1S2gZ6dZT2/7cltH6JCKksemwhfJqXhGCNWznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175694; c=relaxed/simple;
	bh=cMZoz3j10Skqn9kMG7AGIHbr1Z69W4yQ2XlQebpb2Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS471TqeE3FieMTM0zVaw6Bo6GPhb/8ITTWgBNvp85o5Xievtc6TA8PG5ADu9lEemRO4u/hB3IvNdRzJzasYusuvItig4hjGAS1Ocog8r874N3QvZ1ZOJG0tyb2tP0IKYQd9mAwpzFhKMTTYoDYwlB51gjWwQnYNQIbdPlvTJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=knvMIdWm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGHEmtPP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B422A13803B0;
	Thu, 17 Oct 2024 10:34:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 17 Oct 2024 10:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1729175690; x=1729262090; bh=fJvS9+alsJ
	c2s4fbn9EOmQmJgz5/GJjCwKHXNF0mOXM=; b=knvMIdWmldnajbMQdhTIKNW59a
	MXU4Pd2QFC9jU3qEyQqVCHgzuesoHNXNwrPh8//mha/2u12nPZ3axGQxJ9VNFcjv
	7A/xzXhtWOVblyZ0W5ZAH0wJhN5Hp50IJ5+1r7H0rUIH5fK8QF1ZWtzn/5iIZUBO
	gP6nrCjLS8IsD2TFpQNDA7kq+S/aHltuzpj2mCJCb05ppz0Ynw2uN6YB+zCjabFJ
	BAu37jsHDtNgOOATSIhB1DfjM3t1Erb794v+NvbGPOjtLaLS3uvKzDJPnWKy/BLo
	Ahb6B3TA0NEN2/nVTOS62kpuLK+P30IiRmZGY1EYqjF25OFrJqDQ5L+2SyXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729175690; x=1729262090; bh=fJvS9+alsJc2s4fbn9EOmQmJgz5/
	GJjCwKHXNF0mOXM=; b=BGHEmtPPm1GAZFsOXkPCogc9J8tWkbURh5EeMDLOrBvw
	y1Yx9CnR0XDBMiSzr08DcxzbOGx/j06lVnTWJvTMpEVChUJ2uKDuzdokpNxDNPg0
	RclIPb0BoBEjW4ZNQLSeOrSuA8k/Yfr9LhcD1SuEip/LO8DfgXRR81jiIv1miij7
	j6ZVKJ8JCBWKyi3LhGAM2qpte66kGFX2D4n6wyXsnZpiwPJpNSiyMvlVhFVpLOZB
	cwX66jN8ddksafTM6OM297/OAITYRVMvalfXxTp4jhxoA5V46CAwxtKR24GSch5I
	N2McI7hH4zvSVoc3If0Iexc4V66fYituafPfqLQElg==
X-ME-Sender: <xms:iSARZ-YFNHmsF8V9GHi_KL3Wn2A2dIjJHiCZw-DaHUExVIwnk3RtYA>
    <xme:iSARZxZDcYSZmjsME2dI6vcoGxxmF_Z0eNpEH3lyGlK_bxOrY7UWbqpN2oOP1u4R4
    3FldoVCfqUonPgegnw>
X-ME-Received: <xmr:iSARZ4-sJwrQQcVcvOOcg8L_y50dYdLdNcvQrahza8RTyQ2AJAS42ws2h4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfihtghhohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrph
    hiiiiirgeqnecuggftrfgrthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifedu
    leegjedutdefffetkeelhfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirgdpnhgspghrtghp
    thhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggvsheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepiigshihsiigvkhesihhnrdifrgifrdhplhdprhgt
    phhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepvh
    hirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhn
    vghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprh
    gtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhu
    tghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrlhgvgidrrghrih
    hnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iSARZwpfpFIWI0Bm43OSe8Jhyha8a7o02UJYpzVaZgPhDw7Ubj6mbA>
    <xmx:iSARZ5o322JfOjlAFuRhD5J5ugzVxq92kwFG6cuLHeKoDr7bs2wkLg>
    <xmx:iSARZ-SkKVobzQLDFi2jD0qZ_RlRG0YU5c5WVmoB6mzeDwAOPNX7Ag>
    <xmx:iSARZ5qerfqqfx5Aklv79Rlq0F-cE2MjD4zaNyq1qAiV9uq-agSXFA>
    <xmx:iiARZ0Bmijn4nR9JtoZIcvGUIewgJ0pI8yT4tWvGJY2HsZGaMGW1N0p0>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 10:34:47 -0400 (EDT)
Date: Thu, 17 Oct 2024 08:34:43 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Kees Cook <kees@kernel.org>
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <ZxEgg+CEnvIHJJ4q@tycho.pizza>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <Zv1aA4I6r4py-8yW@kawka3.in.waw.pl>
 <ZwaWG/ult2P7HR5A@tycho.pizza>
 <202410141403.D8B6671@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410141403.D8B6671@keescook>

On Mon, Oct 14, 2024 at 02:13:32PM -0700, Kees Cook wrote:
> On Wed, Oct 09, 2024 at 08:41:31AM -0600, Tycho Andersen wrote:
> > +static int bprm_add_fixup_comm(struct linux_binprm *bprm, struct user_arg_ptr argv)
> > +{
> > +	const char __user *p = get_user_arg_ptr(argv, 0);
> > +
> > +	/*
> > +	 * In keeping with the logic in do_execveat_common(), we say p == NULL
> > +	 * => "" for comm.
> > +	 */
> > +	if (!p) {
> > +		bprm->argv0 = kstrdup("", GFP_KERNEL);
> > +		return 0;
> > +	}
> > +
> > +	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
> > +	if (bprm->argv0)
> > +		return 0;
> > +
> > +	return -EFAULT;
> > +}
> 
> I'd rather this logic got done in copy_strings() and to avoid duplicating
> a copy for all exec users. I think it should be possible to just do
> this, to find the __user char *:
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 77364806b48d..e12fd706f577 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -642,6 +642,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>  				goto out;
>  			}
>  		}
> +		if (argc == 0)
> +			bprm->argv0 = str;
>  	}
>  	ret = 0;
>  out:

Isn't str here a __user? We want a kernel string for setting comm, so
I guess kaddr+offset? But that's not mapped any more...

> Once we get to begin_new_exec(), only if we need to do the work (fdpath
> set), then we can do the strndup_user() instead of making every exec
> hold a copy regardless of whether it will be needed.

What happens if that allocation fails? begin_new_exec() says it is the
point of no return, so we would just swallow the exec? Or have
mysteriously inconsistent behavior?

I think we could check ->fdpath in the bprm_add_fixup_comm() above,
and only do the allocation when really necessary. I should have done
that in the above version, which would have made the comment about
checking fdpath even somewhat true :)

Something like the below?

Tycho



diff --git a/fs/exec.c b/fs/exec.c
index dad402d55681..7ec0bbfbc3c3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1416,7 +1416,16 @@ int begin_new_exec(struct linux_binprm * bprm)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	perf_event_exec();
-	__set_task_comm(me, kbasename(bprm->filename), true);
+
+	/*
+	 * If argv0 was set, execveat() made up a path that will
+	 * probably not be useful to admins running ps or similar.
+	 * Let's fix it up to be something reasonable.
+	 */
+	if (bprm->argv0)
+		__set_task_comm(me, kbasename(bprm->argv0), true);
+	else
+		__set_task_comm(me, kbasename(bprm->filename), true);
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
@@ -1566,9 +1575,36 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
 	kfree(bprm->fdpath);
+	kfree(bprm->argv0);
 	kfree(bprm);
 }
 
+static int bprm_add_fixup_comm(struct linux_binprm *bprm, struct user_arg_ptr argv)
+{
+	const char __user *p = get_user_arg_ptr(argv, 0);
+
+	/*
+	 * If this isn't an execveat(), we don't need to fix up the command.
+	 */
+	if (!bprm->fdpath)
+		return 0;
+
+	/*
+	 * In keeping with the logic in do_execveat_common(), we say p == NULL
+	 * => "" for comm.
+	 */
+	if (!p) {
+		bprm->argv0 = kstrdup("", GFP_KERNEL);
+		return 0;
+	}
+
+	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
+	if (bprm->argv0)
+		return 0;
+
+	return -EFAULT;
+}
+
 static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
 {
 	struct linux_binprm *bprm;
@@ -1975,6 +2011,10 @@ static int do_execveat_common(int fd, struct filename *filename,
 		goto out_ret;
 	}
 
+	retval = bprm_add_fixup_comm(bprm, argv);
+	if (retval != 0)
+		goto out_free;
+
 	retval = count(argv, MAX_ARG_STRINGS);
 	if (retval == 0)
 		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",

